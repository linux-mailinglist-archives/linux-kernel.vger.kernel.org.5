Return-Path: <linux-kernel+bounces-110456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58269885F29
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB9428341C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62481332B1;
	Thu, 21 Mar 2024 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxVMI/IV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181FE18AE8;
	Thu, 21 Mar 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711040330; cv=none; b=gG/CQAzH3AM2AMH/UY8vAIE5JpMbsxBVJybwDjmBR4Q/OnKKopF0gU+/pmM/H6Wg9EUoxmqYrc0FTnW8BZI9EbPXUiCKvi+HmN1OV2e8/A/Z9Eu6aNs1xkfZxj9Ru19S/TcEgazzlfsWLFl00B/4xFSEREtva3mgp8nMUd1fEXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711040330; c=relaxed/simple;
	bh=WMfHoNOhghTVhWw9O8SXq+LgpuJpchmhoKsoJ8RY5FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pB5zRrNqqu4hu54tNW5elW8tl/P+dX0obtfOKUPaM3SrMv7lTSuA0jyNXW450us/w8oiBJDH8U3TIoBkje/Ii8MbSBNYQ8qXBRURXm63n3JwTxOjm+l3PEX7WzNutx8ObZwARzOMa4hWTauRnucup4gFsMVUIIPwpNWmu6NDEY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxVMI/IV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1365CC433C7;
	Thu, 21 Mar 2024 16:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711040329;
	bh=WMfHoNOhghTVhWw9O8SXq+LgpuJpchmhoKsoJ8RY5FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sxVMI/IVxQZ3x7AFp43PF4dgBna5a3mSwKzrd1u7mSNs4cVZrdSs8lGdG+uzN1byE
	 wXHqg3DUHpwNPvbQMLVkHH70bCotFh10H7RzlRN2fXWf8+esbiFRqqmd0zvE33VdIV
	 6KfVmiEhOblZFRiqcFGKSsK8HgEYOPeCZZCzH4FfZWH4E00rH0j/5uudtJ6PEj/3he
	 BnvyZ5MOC4YnaIbsvBmYSyyBPWm1HVDXGqw1Qq31WDfb37cXBLTsVY6ow+lhtzkpGz
	 1oWaf2v9241ms+Xn0/gluUbHeMbVEs6XZdxlIG9R+aTu3LZ85wSD832E3uWg18wpUt
	 lkf222qowAqGQ==
Date: Thu, 21 Mar 2024 16:58:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Karel Balej <balejk@matfyz.cz>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RFC PATCH v4 2/5] mfd: add driver for Marvell 88PM886 PMIC
Message-ID: <879296b4-5186-4170-af3f-971787d28514@sirena.org.uk>
References: <20240311160110.32185-1-karelb@gimli.ms.mff.cuni.cz>
 <20240311160110.32185-3-karelb@gimli.ms.mff.cuni.cz>
 <20240321154211.GA13211@google.com>
 <CZZK759UU6G7.MFPYOI0HBB6I@matfyz.cz>
 <20240321162045.GC13211@google.com>
 <CZZL3MNOT0QG.2WDSNX9XD2RET@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XkucS5hq8f1KJRxO"
Content-Disposition: inline
In-Reply-To: <CZZL3MNOT0QG.2WDSNX9XD2RET@matfyz.cz>
X-Cookie: MIT:


--XkucS5hq8f1KJRxO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 21, 2024 at 05:55:17PM +0100, Karel Balej wrote:
> Lee Jones, 2024-03-21T16:20:45+00:00:
> > On Thu, 21 Mar 2024, Karel Balej wrote:

> > > > > +static const struct regmap_config pm886_i2c_regmap = {
> > > > > +	.reg_bits = 8,
> > > > > +	.val_bits = 8,
> > > > > +	.max_register = PM886_REGMAP_CONF_MAX_REG,
> > > > > +};

> > > > Why is this in here?

> > > Because since I moved the regulators regmap initialization into the
> > > regulators driver, I need to access it from there.

> > So move it into the regulators driver?

> It is used in the MFD driver too for the base regmap.

You shouldn't be creating two regmaps for the same set of registers,
that just opens the potential for confusion.

--XkucS5hq8f1KJRxO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX8Z0MACgkQJNaLcl1U
h9CAcwf/UU9whJTldKYf2Umup+pvhQQafpsIdaLAKZdVwH/4F27rS8pRMp1Cp4n6
nfCNwWaCrnRt8iHni5jzqgtroLfbIjeC5t4MMjvElqtkNTQ2hmGCKFAkofIA/KWk
BcKU+0N9riQ8OeUaf2VgxlaMKLP7DZUFV2ln6AeGRZUS5hzZENPn8RrLhIhhM+5m
6VqIssfMZ+gTc4dyrRuVy9X1tn+xIGxEJQuNSSsPP/yTMKgtrufRGztUlBuAoHk2
pzGryzuraqhgU++fHB652FuHhxfQ9MACAH8KXDEzHtgYcSb7eJ6FcjMCqvbPGAb6
kBruh2gv2bEw/5pteRoKXtYkcu8pvA==
=RfEQ
-----END PGP SIGNATURE-----

--XkucS5hq8f1KJRxO--

