Return-Path: <linux-kernel+bounces-52912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDB6849E31
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93591F20FBF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14E12D03B;
	Mon,  5 Feb 2024 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRp1Ufoy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11E32CCBA;
	Mon,  5 Feb 2024 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147139; cv=none; b=OZznlzDMAmmtP2C4h7nROcVE/Cysyn+VJNWf0Y+a4Q/gMhX32daqjt6ssy+FvtrBonXElkdKbabkpxIg5faqDHfncpmP6KnZ2tbwDHBU2bKbq1gXjqLkAN5GCgnTEGwg10JqPKW2pS7UITFh8NLvADEZiSM3y+O/8YqiuFaoZdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147139; c=relaxed/simple;
	bh=VyryEeFktouoPtBlGjASqjjuFJfIz/FqEICD23Ug1nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9DsslKvlejGY7enRHJ3fXA1nr+Xchztu1s2EVCf2XJ0w5N/x8qJNZFa76EuXVdJDVU2XvcoxoOhJ0lzLG6wG2ta0GYPx7pwo1F/e+qaRzBUfzwXXOdzitNVZe+wZ+WNA9GneFPla+4RPUyYIynLsE6jUYsGcj9PoBADQVrereg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRp1Ufoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0646C433F1;
	Mon,  5 Feb 2024 15:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707147138;
	bh=VyryEeFktouoPtBlGjASqjjuFJfIz/FqEICD23Ug1nI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jRp1UfoySFcHnU8OKUHbSECBQs4H+bbZMGQIQ5Qp/RLOcVjMM3wMWxH2lSZdp7OMS
	 xY+IVFAPDeAEgj9qwEy8f57YjbpXm/KhTVhLIAzdtxZ9a8qOqoDCaKmjf2EVAKX+DY
	 wZ3rC0+Ti7DbPTJK70IdoIRelIdtFGsWW1rfHUlqPuLYzIj5WRPlSUfx0Q8/MnUwxV
	 xv7fNGjSAfF96j8rSf1y77C1rhBOTL44owiAwTj4SZmWDa3DP9IIIu4u7h3hSHdpJv
	 DQozGislNB1Os2a4IQ8fMW5njlUrE5bmgp7QFAQpFycl8Ab7c0sEW63M21dRbCurwf
	 zfX85Onv8dQIA==
Date: Mon, 5 Feb 2024 15:32:14 +0000
From: Mark Brown <broonie@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Liam Beguin <liambeguin@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Okan Sahin <okan.sahin@analog.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads1298: Add driver
Message-ID: <ZcD/fnVVLdR2TFr1@finisterre.sirena.org.uk>
References: <ZcDo6QvoE_e5s_f1@smile.fi.intel.com>
 <7d7ea4e4-fcae-4966-b194-e1d328751b6b@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FV/jdPwiWoSPXR4m"
Content-Disposition: inline
In-Reply-To: <7d7ea4e4-fcae-4966-b194-e1d328751b6b@topic.nl>
X-Cookie: You might have mail.


--FV/jdPwiWoSPXR4m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 05, 2024 at 04:25:19PM +0100, Mike Looijmans wrote:
> On 05-02-2024 14:55, Andy Shevchenko wrote:

> > > > +	.cache_type = REGCACHE_RBTREE,

> > Why not MAPPLE TREE?

> Reading the description this driver isn't a good candidate - the map isn't
> sparse and the hardware can do bulk read/write (though the driver doesn't
> use it).

If your driver is a good candidate for rbtree it's a good candidate for
maple tree.  There are very few specialist cases where there's an
advantage to sticking with rbtree.  The maple cache has no meaningful
overhead compared to rbtree for non-sparse regmaps and will generate
bulk writes just fine.

--FV/jdPwiWoSPXR4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXA/30ACgkQJNaLcl1U
h9ApSwf+OwSOaTAWvNTxBwn5cVSksk9dF5DFAZBL5mKj9G4dZWY4eJ5VbtBKncbX
WbsBVkA5dJRmRmwl5hgSBsw0KnnZ624s4JDOXfQ3Aic1Q1n7eFY5RbE02Ba+nk95
ob+9fsminr/iwZphEJFOO9Xb2B8LXWZAuJ66Y66UaIFm++9eD+tLDbjFOcsFu3Du
6ZAUt230YdQA8jTu+ZwFRtp3Qb1830MJTx7wsmGEmII/e7j22I5rW0YXkjS81MDj
LiNGSP5BcuwcIJE/NqYZbO2c3Mx6WKogIeu/7Lktb/Hbjjptne7wSLG10KbaY2By
mIPP+d/Frr5LsVbR6NLv8CtVMbok2Q==
=vGvm
-----END PGP SIGNATURE-----

--FV/jdPwiWoSPXR4m--

