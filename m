Return-Path: <linux-kernel+bounces-117202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE80688A89E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCDB1C63384
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7D8145B1B;
	Mon, 25 Mar 2024 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkKfAbUa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D555B145B0D;
	Mon, 25 Mar 2024 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375529; cv=none; b=CUpvfi5jbxEbUEl77gg81/L6uopicq8zeyboxAEdas9wxsH8lG+LsjprZEdYxhozTpJFHYwSpY4sLVQtmyAbHje7Me6xAt6TT4kWrQANBuwV2X+MdO1zZcaaKdH2XLZHUHLcA2ItPFll6Z0ClpZsVIOLgbIpB3R97n9CYdWH2f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375529; c=relaxed/simple;
	bh=uf/R53zaVnuGZbcB2TuZ5BsOey0PJ2c85vkaFbROMxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPxtNLKlC7J5G6ObmeGfJsvuXqwGJeZqBuE52r17bl94Yp27cRSzIO2O8+CwoND9TwE1lXEaWF6d4BPaV4vFaBt/9Ecp6qkamvPoPKxgVJczFx8SWHQI/Fsn5pXsgcGit8txbxQBIsfRDxbAORT6eOw6L3N5t930Ez7jgPClm1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkKfAbUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59A7C433C7;
	Mon, 25 Mar 2024 14:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711375529;
	bh=uf/R53zaVnuGZbcB2TuZ5BsOey0PJ2c85vkaFbROMxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MkKfAbUaQ7uWpPmnLxC8B7s28wwO98cB6lYha78LxVZ7jXw86V/rhC+Nm2J9ZR0jY
	 97ZA1HGsOhgWCMVSqLS9eu1w9LYiJgxYKtBnuQsATrPClAnFH9cCmEmiA1j7jl1pHL
	 1okd+RVDsqMeMHxsgwJTCTVYU458cvw4DgZsLsWi+RKF6N3teSDWPXgAuV4thUdB8S
	 WclMOG3SviGzQ1JMauLfgAvIjPPyOX88TPz31/ZRg/JDdxvXEUPzjcV+nnDpeA6wL5
	 8f5Pg38Vm5gVtFD7I3b/fVUc6P+iv2O23dRGbmZY2GG0knLNh3NxPhj6klCaVVgoNC
	 6PxhTowK1pELw==
Date: Mon, 25 Mar 2024 14:05:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Miquel Raynal <miquel.raynal@bootlin.com>, yen-mei.goh@keysight.com,
	koon-kee.lie@keysight.com, jeremie.dautheribes@bootlin.com
Subject: Re: [PATCH v2 2/3] spi: omap2-mcspi: Add support for MULTI-mode
Message-ID: <8e5f3551-75c5-4211-84f6-18bbaf061dfb@sirena.org.uk>
References: <20240223-spi-omap2-mcspi-multi-mode-v2-0-afe94476b9c3@bootlin.com>
 <20240223-spi-omap2-mcspi-multi-mode-v2-2-afe94476b9c3@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BVu5qILBOPn9IOdo"
Content-Disposition: inline
In-Reply-To: <20240223-spi-omap2-mcspi-multi-mode-v2-2-afe94476b9c3@bootlin.com>
X-Cookie: GIVE UP!!!!


--BVu5qILBOPn9IOdo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 10:32:12AM +0100, Louis Chauvet wrote:
> Introduce support for MULTI-mode in the OMAP2 MCSPI driver. Currently, the
> driver always uses SINGLE mode to handle the chip select (CS). With this
> enhancement, MULTI-mode is enabled for specific messages, allowing for a
> shorter delay between CS enable and the message (some FPGA devices are
> sensitive to this delay).

This breaks an allmodconfig build:

/build/stage/linux/drivers/spi/spi-omap2-mcspi.c: In function =E2=80=98omap=
2_mcspi_prepare_message=E2=80=99:
/build/stage/linux/drivers/spi/spi-omap2-mcspi.c:1280:17: error: "/*" withi=
n comment [-Werror=3Dcomment]
 1280 |                 /*
      |                 =20
/build/stage/linux/drivers/spi/spi-omap2-mcspi.c:1265:14: error: unused var=
iable =E2=80=98word_delay_is_zero=E2=80=99 [-Werror=3Dunused-variable]
 1265 |         bool word_delay_is_zero;
      |              ^~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

--BVu5qILBOPn9IOdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYBhKQACgkQJNaLcl1U
h9CjiAf/UluKgKZdZYNuV2XqvYOl3EGdorIiBSd5CC1Pf3akC/6c++zqz1muuJAw
eGxsRVYnSc1epuNfk9zA8g8fn9hy3v0tFrJsSXjc/WAbMxHXyLh8V/OAtEWbty4w
T6UsfnIj9O4KJ/ZGUeyl/eMLlhcUQKjcy68Jo4ysFrYZAxyOaD7v1lvovjHQIRyZ
VTRJp9eZdvIe0fqqbSqVcQaCrJZNJHN3eXvDiyb2Kn3iNK5T/qGBcjGuQHip3sCX
8DATjgGI7rkpYfi0ZXx9faarfcWnd2+EjeP0hytGOE7YzFKYsGZn0mfTMkLMkGuj
1VRip+3OdTyeW85zDVuehYF+1VrD/Q==
=kr+5
-----END PGP SIGNATURE-----

--BVu5qILBOPn9IOdo--

