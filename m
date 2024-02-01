Return-Path: <linux-kernel+bounces-48528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96D7845D54
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 358B4B353F1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403765A4E4;
	Thu,  1 Feb 2024 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/YrN8xV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C73E608F1;
	Thu,  1 Feb 2024 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804922; cv=none; b=roAPNgMS3RfATSetBuAFEAV0v2XCEoeR2zZ1dTt9jTpSOrMrS6vwAIDnpV6QRUNpRinNnWkhuKqHyQTrDYVBA6+yyVgNloABbG1hx6lld5XxKngESnG0h/k7p3Jkz8JV6NQ4JYjzSHXJX0/OhgJBNKRT6CysHhU/nQrvDuJd+mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804922; c=relaxed/simple;
	bh=LJTGJnhKgBYom823WICiuecs0YNygUgE0aq5j4PGVZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYEJW9+FKA4aHXfedGrmlwkVBUe5ePgtyrR+yBK0CySPgDDMXf0Kxz5kmIlTq6rqIFyGBe0xh9vSVa/qepT9k30/KwyTY1hIPtpVxUhpgI2yqy5fnojxG8NaBMVlZOejGd93pFRJAii8y8tCS8JJqC1vizbWrBsSU89hGoj2OT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/YrN8xV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDA3C43399;
	Thu,  1 Feb 2024 16:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706804922;
	bh=LJTGJnhKgBYom823WICiuecs0YNygUgE0aq5j4PGVZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T/YrN8xV5LIjD423yTEX25iirZD26sOJfCJkEnAKs6HK5nsBkayfsbt32MwUhGFJk
	 3GsxvemXC/+R6v7nbE3KBXsxwpIek191xaqhOxZlKLo5O5J/uDVkcKBIdlGcFrDfd9
	 4GEdSPWhI0gJ7HFLHa4ZI2UZJOIInXYa/MR9nQfck3NYx2hYqaS4Wo6W9IDdWNDSBJ
	 9t1bhKd5kG3ouY6JphGegPscO8bWAvFqtRa3gtIDDJ/QNaOl1JVshwyXKiTcbvsrlW
	 vmt8BQffBZ9h488G0MhHSv/UUixKT/l/Td7gV9ZyiKDm6ECPo31OHD+FeX28SBmebn
	 SVlQ5Tuom8boA==
Date: Thu, 1 Feb 2024 16:28:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: amba-pl011: Remove QDF2xxx workarounds
Message-ID: <9e60d1ef-976d-4fed-aadf-2c76edf6ae6f@sirena.org.uk>
References: <20240122-topic-qdf_cleanup_tty-v1-1-0415503184be@linaro.org>
 <baf69674-7c69-4658-94ad-9b39fbb9924d@sirena.org.uk>
 <226874eb-18c0-4834-aca5-46396b8a07e6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GqORtPCICAVRgGZ0"
Content-Disposition: inline
In-Reply-To: <226874eb-18c0-4834-aca5-46396b8a07e6@linaro.org>
X-Cookie: You can't cheat the phone company.


--GqORtPCICAVRgGZ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 01, 2024 at 03:48:08PM +0100, Konrad Dybcio wrote:

> Right, sorry for the mess. It actually turned out that Qualcomm is apparently
> still using some of these internally and was interested in still keeping it
> alive, at least for the time being.. I mentioned this on another similarly-
> themed patch threads, but forgot this one.

> Should I submit a revert, or can this be dropped?

Might be as well to send the revert then if it's needed it's there?
It'd be good to get this fixed quickly due to the issue Nathan found,
that means it's pretty disruptive for testing if you're using platforms
with the pl011.

--GqORtPCICAVRgGZ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW7xrQACgkQJNaLcl1U
h9DtKwf/XHZLRutrtzqZAB2UjgAFvpa1lV3WNXLIw2d5SyXS2O8pGXYfs0/c1kBQ
x4tOHMwgtFKAcZ/as1U3dIwru13Rk4anlEcKK/oio6OheunXmNYZe/XbPjD2jtI0
LCwJL/oW4E0ElXeTPQaeX5C5iyLLzB7v7ejzcUf4BvrI9PD5AB7viacZ8+1CSWN0
XZgefIEfTelEjsrXzEdRNOGmH32tHg3sHJsPjUbNdFMcc8KZ2KnVlVE4ezkV84m7
5TnBh5SDl/GrTxV1Lnnnr905MJ2UBucPWC20F3pYWgURcSiJ6bpKl2s0HTwJ9iqC
QzXpGaEUbr/CknaFB//CdWX3WOPDEQ==
=mGrq
-----END PGP SIGNATURE-----

--GqORtPCICAVRgGZ0--

