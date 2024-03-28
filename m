Return-Path: <linux-kernel+bounces-123527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58957890A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896A91C2E9DF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A5B13A86A;
	Thu, 28 Mar 2024 19:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCPwoLDJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F55B1327FC;
	Thu, 28 Mar 2024 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655714; cv=none; b=GhjqSprrJbmo4yHeB0SBqz+yGCFZ+TQstNu28OamQAKULYvWJZDCZKkx5v1aKG8HNh2unCyGIADIQYFexgJSokPJSLA88akuK/yUsU3b2YMPKZHnQRm8XVneLwdPO9r+/4pLwSjagSyc2BEEIgnGWICpxgcozXWF1kx0C2e3ecM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655714; c=relaxed/simple;
	bh=Dyq24aNRTpRP2AlBrzBlIY42U6Q43vHXCPypw35SFNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyHYg+dDae3Q+UGWDjU5tplQe5ChiEeaojPKTzZ/JdH9NZ4aLqR/RmMs7J1SU/PxmvoVpvGu+sVDOcv03bb5iJuk9JIGjmdgIFfAvxnMRTdhFTZ42FaXd15nMAx9s+9T7pNAcIlNAMHaYEr5FYcm/7KTdUp3L+LPsUhn447GygM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCPwoLDJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21ECC433F1;
	Thu, 28 Mar 2024 19:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711655713;
	bh=Dyq24aNRTpRP2AlBrzBlIY42U6Q43vHXCPypw35SFNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LCPwoLDJ99lEB9KPJBDfak4y/Mx034iYfykx3FUVUwFuL5qwiNm39VeNOcUP0rl/J
	 2kXOfH/qsfHsDwgyGVxVZ90kAfXdd8ZNDYu8SOmhruDoYXnZDaLNCbujaEwg/bkOoN
	 fzjJsfUZmey5dtYiCxleOndfjM1EBD+4ATMS036t98Q2gJsYfWpqi7ClgTbW2uj9eP
	 L8bO/SKaP9RxYAO+9mt7TLq/hu7WQID25CpjnhZH5O0bohIiBe0z5pr3ypC1KjiMx9
	 jlHnzz2a3s71Mg2NtP9x32GpC7mmqRAxnntLNwcZ7yVDeURiH2QXFtq4b6eHub4fdc
	 LGabLtH0ukZLQ==
Date: Thu, 28 Mar 2024 19:55:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Bhargav Raviprakash <bhargav.r@ltts.com>
Cc: linux-kernel@vger.kernel.org, m.nirmaladevi@ltts.com, lee@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jpanis@baylibre.com,
	devicetree@vger.kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, lgirdwood@gmail.com,
	linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nm@ti.com, vigneshr@ti.com,
	kristo@kernel.org, eblanc@baylibre.com
Subject: Re: [PATCH v5 09/11] regulator: tps6594-regulator: Add TI TPS65224
 PMIC regulators
Message-ID: <3e6d7c20-766c-4d27-aa10-f30f30cbd646@sirena.org.uk>
References: <20240328124016.161959-1-bhargav.r@ltts.com>
 <20240328124016.161959-10-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+rxx+apRdHZ17chU"
Content-Disposition: inline
In-Reply-To: <20240328124016.161959-10-bhargav.r@ltts.com>
X-Cookie: Yes, but which self do you want to be?


--+rxx+apRdHZ17chU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 06:10:14PM +0530, Bhargav Raviprakash wrote:
> From: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
>=20
> Add support for TPS65224 regulators (bucks and LDOs) to TPS6594 driver as
> they have significant functional overlap. TPS65224 PMIC has 4 buck
> regulators and 3 LDOs. BUCK12 can operate in dual phase.
> The output voltages are configurable and are meant to supply power to the
> main processor and other components.

Reviewed-by: Mark Brown <broonie@kernel.org>

--+rxx+apRdHZ17chU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYFyxoACgkQJNaLcl1U
h9AmSAf9FWOqRdRhslGis6k+Eil3DKdDypYcR3ewj1nJ7vbgnlf4rhQqNIPn19ne
LW1mI7b6FfOIirklxrnGRMMiLRqQDAAgO3no0wSVpPDm8+iYdwyQUxL0eMw0lRrC
OdEorwSOP2WDNunmAj5qTWvaUZrJTvOVZSoucRjywwBMMLMQk5hoEU6ro47Su6c5
qi13BPGjphA4cxNRP5SVPv53jNUKKMMYNrrgKG42CZQOiEQjO4G1/TfGLCVN+TOI
Lae3gQsCqO29pt8peeO5N2qUvuUJAuVQTb+6p+9qFweFz7CkpP5CZrM0OtpXRevs
t6jySrmy1q8uzRSBjIp6dbiiV9SDsw==
=/eiv
-----END PGP SIGNATURE-----

--+rxx+apRdHZ17chU--

