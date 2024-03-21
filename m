Return-Path: <linux-kernel+bounces-110478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AC9885F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A56C9B24FE9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0D117590;
	Thu, 21 Mar 2024 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8o0ZpY1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF3F224D7;
	Thu, 21 Mar 2024 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041467; cv=none; b=c0/vjp0cWGRcVQo0iOfkPLyai9/yyK3a18C2pVU2JWLGtlw0UGjQg59vEDeiKz+J+0qj1eFkAGWnXd5VbWDGUyCwZ+nYBLVY2XOZzRMDu8IgsLs3AJXsBtJJfyiEJPPxAA/htICo1jAw8bTH3rQyld/82rRZgIprIGWsQ28s/uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041467; c=relaxed/simple;
	bh=1L/duXBiIPiVo7GCjSeUY9hylRmojjGd3gub4/7cGB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMMXngLr3L9tM/Xg4JEOyxclFoEzQxcqRXi/TBOQKZnG+VX+7MFFyfIyDJGX0b5nbu0jS/bMUfau/mv127lWjhpTPDKpidUb+I9DHlPtYxHX5634rVDCh04kEI0mIiTX9AQ6QkOGZfU8dI4Nln32TpBBEQlk7AMnvbDAEx46WtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8o0ZpY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9759FC433F1;
	Thu, 21 Mar 2024 17:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711041467;
	bh=1L/duXBiIPiVo7GCjSeUY9hylRmojjGd3gub4/7cGB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K8o0ZpY1mORa3rA1SZPj71EfUvQ/wRgEAFvOc9SnBV5ozsrvIXEIIeV3ehfSupap5
	 JndNoTEicC610bIW+GeQqg1F2cP7beIlC9E1MCVwYXPpGMdfzS3NYpmu8PmAbl9QRN
	 1guiY6dxqSX+3dOopVLaliM8Qm2ggtJ8gJjoTtG4TTB9PNf0iDfqZgOzGA98I9P3F7
	 RNXPSaIRBNIpSdpvlMcTZgYqJtZ1VZSdkoswogKQf0vmtDOlbgjaBobCRWssKkC5NM
	 wtC/U2MFabtmplYAtBCCxdQ/qq/t/W8IXXiTLrfow3zjTwSm0noSgjJk4Lfy7XQ4dk
	 IMTxavIkasHMg==
Date: Thu, 21 Mar 2024 17:17:40 +0000
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
Message-ID: <45079e37-dde9-4310-a112-7af49f35ac77@sirena.org.uk>
References: <20240311160110.32185-1-karelb@gimli.ms.mff.cuni.cz>
 <20240311160110.32185-3-karelb@gimli.ms.mff.cuni.cz>
 <20240321154211.GA13211@google.com>
 <CZZK759UU6G7.MFPYOI0HBB6I@matfyz.cz>
 <20240321162045.GC13211@google.com>
 <CZZL3MNOT0QG.2WDSNX9XD2RET@matfyz.cz>
 <879296b4-5186-4170-af3f-971787d28514@sirena.org.uk>
 <CZZLDK79D5VK.2VK3X59OHIY2Z@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oJHv45Mb4kHzpP0z"
Content-Disposition: inline
In-Reply-To: <CZZLDK79D5VK.2VK3X59OHIY2Z@matfyz.cz>
X-Cookie: MIT:


--oJHv45Mb4kHzpP0z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 21, 2024 at 06:08:16PM +0100, Karel Balej wrote:
> Mark Brown, 2024-03-21T16:58:44+00:00:

> > > > > > > +static const struct regmap_config pm886_i2c_regmap = {
> > > > > > > +	.reg_bits = 8,
> > > > > > > +	.val_bits = 8,
> > > > > > > +	.max_register = PM886_REGMAP_CONF_MAX_REG,
> > > > > > > +};

..

> > You shouldn't be creating two regmaps for the same set of registers,
> > that just opens the potential for confusion.

> Just the regmap config is the same. Otherwise, each regmap lives at a
> different I2C address.

Do they both genuinely have the same maximum register?

--oJHv45Mb4kHzpP0z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX8a7QACgkQJNaLcl1U
h9AzgQf/ZFwxdRh8PV6KEsERNGwwS8v1mrS7lrZyYJ3WLjvxLW4IGIhGJlvYT0QK
6qY1L7OPpALhBqB9PJOMmzj25gYUrH0G7Xm/mgNLHGUfcziiy+aYFK+qMJz+WhmA
4jJZonmfKnPo14Q3P0BTRbQ31Sea749XWHsBX6Lj35znOawhFuAveCYPFnmkXV8z
IGGDK1JzLfPpzqIAt4sQSAK4IxcVZlhW431iWlsOjT6fGjUoCYJ024vfjt/Qe5a9
LV21+ek3qXEgkiHcJN4J4hVDwm2yQ/+AbTPPjwu1zWmSDWGu9GURK3MJaJYw4xQ0
8xeNT4PV3q7NHyFblyIuRyKnCJRIXg==
=XIFj
-----END PGP SIGNATURE-----

--oJHv45Mb4kHzpP0z--

