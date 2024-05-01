Return-Path: <linux-kernel+bounces-165363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 442E48B8BC1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA2F1C20EBF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1883A12F36E;
	Wed,  1 May 2024 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjGgtqjf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B81712EBCC;
	Wed,  1 May 2024 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714573127; cv=none; b=PfzKzRZj68EHFuYw9OygZW76MseeTeKQ/czNvAymYStNI4BYXIvY+N3+qQAoHNiVRjDVnimCC+aN1GYnhVuxn22Ws+hgvqXnSAx0Bvnfu5VugPPpezsRCRRMbyqOxxM/ZSTDMXGWTe+PgoWIA1r0U3M3IBxVLoPz3wKDB7Crayo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714573127; c=relaxed/simple;
	bh=n9gpKxgqcB23fdP3+w4SCDsaIrVkU7Ay+0MgT7lB0cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuBPteX7RnmtlJXFVWuurz/veVZbuF0pRIxN4U7yl6NorcGbdvvhFdn99aRJ4+cOvO0+8FiXDGIp9DcNcnydus0QkTjhdeE9PfE5F8070bK9m5IfqNdRz2C/1q2P8xR4zpQea+xe/9ilxWZPH68Efu1y4KbeqfavSvm1rPxgkgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjGgtqjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85020C4AF49;
	Wed,  1 May 2024 14:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714573126;
	bh=n9gpKxgqcB23fdP3+w4SCDsaIrVkU7Ay+0MgT7lB0cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TjGgtqjfzvjHibdl8jOLM4phUG5pPnD8fVaXVdFbwRwFhGdW1IedqsViWH6PZXN+K
	 woy1j/IYufXkGPC4GpIArJbm/7ADfIu2XLVU1HpROZyPJFE53kNVcMzr0kekVEXxl9
	 DsvyXB0XXPAjjSVVIMQcrVsUR9CAmWYjUM3juxbfIad8NzSOBbQ+EOBO0PzHnEPIvy
	 F66Hb3XBdT4afoiG0z7kbMEskZ3CmTb7e7hF2rpDFM3konatS2KPze1AHTgrP20nnN
	 4CUeI75MrZ5r/do7ll6JvlKX6OqauYw982VH1CShXjgp55GV/M9/Da9RYyTRMAubDP
	 V/MsU3VD86F7w==
Date: Wed, 1 May 2024 23:18:44 +0900
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 0/9] spi: pxa2xx: Drop linux/spi/pxa2xx_spi.h
Message-ID: <ZjJPRBfilhNWlkLs@finisterre.sirena.org.uk>
References: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com>
 <ZipBLUa57YxBAeZD@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wSXKgfu5h5o3OCvp"
Content-Disposition: inline
In-Reply-To: <ZipBLUa57YxBAeZD@smile.fi.intel.com>
X-Cookie: lisp, v.:


--wSXKgfu5h5o3OCvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 02:40:29PM +0300, Andy Shevchenko wrote:

> Any chance to have a fresh look at this?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--wSXKgfu5h5o3OCvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYyT0MACgkQJNaLcl1U
h9A1XQf6ApPEMItg0D/eh6zIHqj98h0RwEAS2puuJHYsUcLuuJVnMLN4x2Zeo6w6
5QkVfebSpGSBXn+qVwDy9cNnYeFIQz/y+pw57P9rvSrMWGHv33E3lS9cJ5TWiMiv
Ql7F76ekjSDHzI1bZ2bVI1q+ORw37r1B196RkeG0SYmlTqdCBCNb+fQxXZedu1Eo
CBxrZ4XI/XIlTaN5bOCZOlTpF2eNuLsS92M0y7U8ZVqYG6Pcy5L3ixB8wWNpeMmk
1zFB/kIT7ljKA2bNc2QHRnWlp3N7cMLqVPyfyO4shYXqrj7IIyTlNEYa8XVxXweh
SbafSYgpbMPeXNncyg4IzvEHdwWR/Q==
=udRt
-----END PGP SIGNATURE-----

--wSXKgfu5h5o3OCvp--

