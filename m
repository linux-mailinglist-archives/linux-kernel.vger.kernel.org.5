Return-Path: <linux-kernel+bounces-63819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D69D8534D9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104AE1F2A616
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E050A5EE76;
	Tue, 13 Feb 2024 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfTqm80V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1275EE65
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838670; cv=none; b=Y/Vvjnq3IGvt9VBw792xCD30Ofh33wxcwdugcx3YDix4fyBSshLOBalDH/HCSAcTj+NuusBraWCxt1yx+zR/Eag8Ak9CGaCrvjrIGy1VsuszpKNeMpdXN0hOWLEvKhIvzTogmCrTR/ENqyYcs/nMeUkDir99WxJTVY1e8syd7TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838670; c=relaxed/simple;
	bh=icr/pOYN3NQ4vt5p2G2RvMWyYtK1FI1GNj7EmEU+oGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJ01bkM7+7NCq0Be2V2C4RwAmsIOQgS2SIwmdzoELfkBFPTgPCz7lNnJLmLyCQ+9sVJWOOl44SBBNeVbp6Zrbma+reblhaDCKu8s7POd1nBSKQGnGIIDkSqM/ObGwG+lnK4YFBwPZU+PPlgNARtLKTdhV+Sj0vl8Dait2+WvvZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfTqm80V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4588C433C7;
	Tue, 13 Feb 2024 15:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707838669;
	bh=icr/pOYN3NQ4vt5p2G2RvMWyYtK1FI1GNj7EmEU+oGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EfTqm80VkfhaBxwvM10KIiWzm2C3AZLuhwDmIjMZA0IiRiRikvPeOEeTDJKVlmiz1
	 ANHxqv9lM8Zrm6Ndo6vFfM0V+LYYLdB0v5jaN5/b53xTm77qX7hHK2TwygpEWimAPO
	 g7f8ACeY5d2oolCc++pr1hFvveBU0dokMFCTZAB9t0gSfpoKC8ttAZKRJxR8IZG8U7
	 0m9ZPWeDP5/eeFBOiILYf89Xg5oasTxKRrcE94dWoKvd4Rjd0ASvdSbBRX8Yi2U2tA
	 xoI0Xd5xZImgc1tRNV3CfdLYhbR+aK8mx7gp6+U6gvHEyFuif2o0m3NYWYClzG4Ktv
	 DZ6VKMWONz2pg==
Date: Tue, 13 Feb 2024 15:37:45 +0000
From: Mark Brown <broonie@kernel.org>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, mazziesaccount@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator (max5970): Fix regulator child node name
Message-ID: <7a687805-3c99-4e1e-bad7-f40ed06ea96e@sirena.org.uk>
References: <20240213145801.2564518-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LLRaq9BoFVNdMckq"
Content-Disposition: inline
In-Reply-To: <20240213145801.2564518-1-naresh.solanki@9elements.com>
X-Cookie: Does not include installation.


--LLRaq9BoFVNdMckq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 13, 2024 at 08:28:00PM +0530, Naresh Solanki wrote:
> Update regulator child node name to lower case i.e., sw0 & sw1 as
> descibed in max5970 dt binding.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--LLRaq9BoFVNdMckq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXLjMkACgkQJNaLcl1U
h9AxgQf+M9nClxgcBOj/MSRtFgP+bD9RUfJOpOAnZomdPANSDgzuytH7i8Z4BtdW
gR5eJzvz384kkX9GkIFzq3DCxHbojsp8/+gNjvJeEiVDO21wDCIrip5j+LU7omb/
5tPNp/rBZ17vMMCMyFlnDwGyDv4uE+LU8us/0yY/0TSVOOwC5pg5xRGJTcVdgqkN
TXBJLU8MnQ0XaV1h2VSgdj0uxdCxEmy+S3A+Gs/zOYFe9yYwN9+4hMgAGCZPQryn
55fV8WS+fiMBKOS8+eV2mJVdnIdXFBZoTOmWTxseqfxQhDJsPzVjc4nHnH9mttJW
DGdm+Zl85/UoD6GoIrRfFpiZy47cqQ==
=G118
-----END PGP SIGNATURE-----

--LLRaq9BoFVNdMckq--

