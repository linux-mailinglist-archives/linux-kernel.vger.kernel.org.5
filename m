Return-Path: <linux-kernel+bounces-79824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D29D2862736
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19245B21515
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BBD4CDE7;
	Sat, 24 Feb 2024 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2j6suK+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E161D4879B;
	Sat, 24 Feb 2024 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708805047; cv=none; b=m/HxGKHOwZegfGWsK8sbWzkFWjgPUBQ4k39mEJqqllYrvV2zqKWfzF2qTCo7EbzCxEe5x6HMVpIVWZT2CkMQMpj5FZOxRU+RD8dhekcoiUNSdp9y0bOUvSy0wGmdcoWvLpPfeqfLZE12Q244wvA8VSxYItI/syGi6dpzTyyqjFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708805047; c=relaxed/simple;
	bh=QQt7ewCTYNG2n3qgf2FwZvSl3Jiu92dblSUDYtxymas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENJlFs6ZUojgucYp8pLnkKI/5kEOSHrw+8e9tfI6tX4Q0ZICy4Z0uBQ7xTIeuCzMPFyVECRJSpNZKu9hVNvfpk3nKhZ6a6nB+b5KfgGCZbGDg3g9TqAKNrf3IZncDrgIltAs/3PF9ubqV9b5hTnHCUYWX+G4aeew45KelJsRgrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2j6suK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EBBC433F1;
	Sat, 24 Feb 2024 20:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708805046;
	bh=QQt7ewCTYNG2n3qgf2FwZvSl3Jiu92dblSUDYtxymas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l2j6suK+FIAMgWZWlYyIf66Ynb2aWkrPMg63SagYT1M20Iwu6QGFyyXYRmIT8hiZe
	 2f6z9bo1MKPNdXhWEFtvqPwKKw/4Sir13mwD5E2Mo+rG5vSEC+P/Gij8eSgtWhkaVP
	 q+Vz71yWO4RNfwfv3wX4ijcZsl38mVZtV6ncqnWQM2V36aCzRaqAaXHSOiFyYhNAf0
	 pSK0p6vYyRCsLZYWWVPLj7Y+TyhFWWYkzGfKNHf4F3GPcTy7XmCRpwF6xdsdst1Upk
	 kZD379VLQOW47lCXR6m+yJakCmBKMMvPF8tHN/qHNL3/mzCzpWincyFXlQybo0Rsnl
	 gc8vNBhPTmGmQ==
Date: Sat, 24 Feb 2024 20:04:01 +0000
From: Conor Dooley <conor@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, eugen.hristev@collabora.com,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 15/39] dt-bindings: watchdog: sama5d4-wdt: add
 compatible for sam9x7-wdt
Message-ID: <20240224-runway-seventy-18c05d9017d2@spud>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172627.672316-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MCL1PDjEzHWh/lOV"
Content-Disposition: inline
In-Reply-To: <20240223172627.672316-1-varshini.rajendran@microchip.com>


--MCL1PDjEzHWh/lOV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 10:56:27PM +0530, Varshini Rajendran wrote:
> Add compatible microchip,sam9x7-wdt to DT bindings documentation.
>=20
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--MCL1PDjEzHWh/lOV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdpLsQAKCRB4tDGHoIJi
0hIqAP9kYsyM/YK3cpEQzpTJxA9CBgfV+9cmesaYky6zgK2UxAD/UrckegCYyIKZ
MNg+hmDjQg76dZfYNeQdT328+3zi2wo=
=9lnG
-----END PGP SIGNATURE-----

--MCL1PDjEzHWh/lOV--

