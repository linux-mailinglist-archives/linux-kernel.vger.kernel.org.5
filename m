Return-Path: <linux-kernel+bounces-167870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C25298BB090
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8A4282D5E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED30155340;
	Fri,  3 May 2024 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBrMuUW0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999CCA944;
	Fri,  3 May 2024 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714752441; cv=none; b=MJEDb99OOY9W3JO2o03qRuN4SxVpWf7PLgo7hV274EqxC438bNmfLLdbKepy7Zq9/BQEKYrLENM6NSk5Q6MXXWVbwXTDJ9MkbS1VyLiemFEcRwmW0F7tfllYR5vfisTXFeJplsI7QjceGV6dYFJkXbDC59Xz3AlyOKxTh73At0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714752441; c=relaxed/simple;
	bh=W91kcN7nrkWghZ/PoRIVOeNh3GWbeg+b2FW9mH1axwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bu8ideHFdM3OGhgk3CfZJWNnolqPsPiaDSGQqZKW34gccNH3rowvhJJ6/Nk4u3AycZIe/ElUJ1NKq32GeR6xx/O+9UF8X0TZF9GChRxOvJvLyuxd2EqNgnHwUB30mDZMabap0vs3exB3M9NNb2hXVqb8/l0NmIwsupvimPjNWEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBrMuUW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DEBC116B1;
	Fri,  3 May 2024 16:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714752441;
	bh=W91kcN7nrkWghZ/PoRIVOeNh3GWbeg+b2FW9mH1axwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OBrMuUW0rIzSheM3VMg+BPEExT47shrT6vDtXPA/mYlO86AKvbLspq93o37ooLZkg
	 TO5HSnOpCGfcdQnvry6z4aKC+RE/RiIfy+5xFk913pofDAHOZ0obuDJ52RhY1kn3pk
	 7yV5Cb/Yd///3aCUP8g0WFLWZKHfaM8SdG+3yxo8t80O+/r1jIgXarRWvlLaPekLtx
	 /rCBufHXZw0XInJ70OUguiUwEgfn0jO2MuVX/JLR8GgtZmsIqEP6dHx0eMEuk2j7D6
	 e2K4jV1VytMBye349sNgGR0yTODH9wmFJHsjXJPiT/kr0oQTW5CWkmkFP6WQkxdKEq
	 0w1WXOw120J6Q==
Date: Fri, 3 May 2024 17:07:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Alex Soo <yuklin.soo@starfivetech.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jianlong Huang <jianlong.huang@starfivetech.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew Fustini <drew@beagleboard.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [RFC PATCH v3 1/7] dt-bindings: pinctrl: starfive: Add JH8100
 pinctrl
Message-ID: <20240503-undress-mantra-e5e46b2f6360@spud>
References: <20240503111436.113089-1-yuklin.soo@starfivetech.com>
 <20240503111436.113089-2-yuklin.soo@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KxAjTyFg5buG+CKV"
Content-Disposition: inline
In-Reply-To: <20240503111436.113089-2-yuklin.soo@starfivetech.com>


--KxAjTyFg5buG+CKV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 07:14:30PM +0800, Alex Soo wrote:
> Add documentation and header file for JH8100 pinctrl driver.
>=20
> Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>

> diff --git a/include/dt-bindings/pinctrl/starfive,jh8100-pinctrl.h b/incl=
ude/dt-bindings/pinctrl/starfive,jh8100-pinctrl.h
> new file mode 100644
> index 000000000000..153ba950c062
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/starfive,jh8100-pinctrl.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +/*
> + * Copyright (C) 2023-2024 StarFive Technology Co., Ltd.
> + */
> +
> +#ifndef __DT_BINDINGS_PINCTRL_STARFIVE_JH8100_H__
> +#define __DT_BINDINGS_PINCTRL_STARFIVE_JH8100_H__
> +
> +/* Pad Slew Rates */
> +#define PAD_SLEW_RATE_FAST		1
> +#define PAD_SLEW_RATE_SLOW		0

Should this really be in the bindings? I don't see it having a direct
user in the driver.

Also, if this is the only header you have, I think the RFC tag could be
dropped, since there'll not be a header we need to worry about getting
into U-Boot etc with values that may change when the SoC moves from an
FPGA etc to tape out.

Cheers,
Conor.

--KxAjTyFg5buG+CKV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjULswAKCRB4tDGHoIJi
0gziAQCOhL3Nl0Z9Etl6BrrDO57we/UhOPrfgVEhlu3CnukqOwD+JLtE6cJPbh5t
83xkoNV1bF4rXWsE5iiR7H8VKiAfEQc=
=Lyzr
-----END PGP SIGNATURE-----

--KxAjTyFg5buG+CKV--

