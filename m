Return-Path: <linux-kernel+bounces-61783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F25A785167A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE941C21E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638643C063;
	Mon, 12 Feb 2024 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkHQw16g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9793F3BB41
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746494; cv=none; b=gGAzElOB8DcUsYN8ZY1nkdm2bY+7p+Pvr4XdVaDkzOOOcY9aOydWBSotxMl7BzvmhU0tViIbf7SwwNJenQIEE+cgEpPlVzT/LepIQiPVd3oex+meWiv8XrHzALuCKpnt398A77fogiQ5m4tJxXfmG+/1Z0Pvh1mpx2Gebg8L9Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746494; c=relaxed/simple;
	bh=kWeSii4mNds3X3Ix8SXiG+FYicUYqqt4VtVYpMibzTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r71TYpN/baFKzJCjhBuCWivK2K9ReLd5dE86yDYy+lJzHLoMkqxPbkJy161lafmwGiFypRoNrrRa9idAK1srPS4OBA9hwxzBIv8+GJlhYD8qEX7gtgLSfuSj2SnFG0FRlJtOqonznhc96M5aChbQM2yYKlrEqBXyLLD23TM45dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkHQw16g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720EDC433C7;
	Mon, 12 Feb 2024 14:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707746494;
	bh=kWeSii4mNds3X3Ix8SXiG+FYicUYqqt4VtVYpMibzTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MkHQw16gt+uzNFo9mfcyBFoy3vPRV5R/QISelgkmlJZRWOra5McOFHHOl/3CSK229
	 DYXtX41LMKDoem87/g85BQJ4yKntYPLisGNajqvkkEHJKqx3401LO/ROoN/GPOEx4B
	 /VCelaLeIZfJQGZu3sPItXh2W1O94aYQNKYiXHomtjls8rj5p6cMHBDdh37JzL1srQ
	 Yy8Kzcymo7V3X9v9XWSlSwBfCpPVcKXz3wDlPjTMm4n2xwxoBm1JhD1KLHDIpQXu2B
	 OOxnNPle2Qd5/XdP5qttKUzZqBMShez54LtWjBg6Zyr6JqT2eZ/ZkmLn6oNiqwS51t
	 pICF2IcteH5xQ==
Date: Mon, 12 Feb 2024 14:01:30 +0000
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] regmap: kunit: Ensure that changed bytes are actually
 different
Message-ID: <7979c4a4-d33d-4379-974a-12391b3a0ed7@sirena.org.uk>
References: <20240211-regmap-kunit-random-change-v3-1-e387a9ea4468@kernel.org>
 <d1136c07-191e-443f-b462-c18ee2c217e3@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8IXBz4LFi6fe6SOd"
Content-Disposition: inline
In-Reply-To: <d1136c07-191e-443f-b462-c18ee2c217e3@roeck-us.net>
X-Cookie: Will stain.


--8IXBz4LFi6fe6SOd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 11, 2024 at 10:54:25AM -0800, Guenter Roeck wrote:
> On Sun, Feb 11, 2024 at 04:58:17PM +0000, Mark Brown wrote:

> > -	KUNIT_EXPECT_MEMNEQ(test, &hw_buf[6], val, sizeof(u16));
> > +	KUNIT_EXPECT_MEMNEQ(test, &hw_buf[2], &val[0], sizeof(val));

> I kept those two checks separate on purpose because a non-equal check
> will "succeed" if a single byte is different. That means the above check
> will "pass" if one of regmap_raw_write() or regmap_write() works but
> the other is broken.

Good point, I'll do an incremental change for that though since that's
more of a belt and braces thing for something that should be checked
elsewhere than a core part of the test here.

--8IXBz4LFi6fe6SOd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXKJLkACgkQJNaLcl1U
h9CXoQf+My9Q33QtH1SW2OHxt7b5jbNW8wM+5esXkkYBxlApL/xxHTJkG1SRGCZc
Lnp1al6bM/iqjj1r2oVJtA1c9Ny3rZQkUjqg08G3UK9SO52w/J1b2L3ZA5Hn5326
sFQAVnR5ZC3xwsmeFVZ1BO3sCWhS7yHaXdOml/GD/ZqvjYPjRV8sOEZy0cX0hXHm
YJ0DBUYHuDms20TMt+HsUbcCJLljN/uxk1rUMVNemceAOyY4ewTLtUu4JVkpvaLS
0ZWNGgY8ipqLmVwcb1SlCa3akWFjSS9GImxUrI+h7FI7dIu/DvnF/YlkMjVfbNU4
UR6GCFZmVLVDkjFG80MbWlFt6FN62w==
=iEG+
-----END PGP SIGNATURE-----

--8IXBz4LFi6fe6SOd--

