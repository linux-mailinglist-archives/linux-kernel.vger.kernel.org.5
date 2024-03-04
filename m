Return-Path: <linux-kernel+bounces-90987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE2387080F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0F81C21211
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CEB60253;
	Mon,  4 Mar 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WH2sUL65"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F65A20;
	Mon,  4 Mar 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709572226; cv=none; b=mqDRhyvdwbtv/v830P4lGbxUHp7SryDfhTDKvLflY3T1efrbTH0rEFnLbgoUp0rFRuwCOIcYYwf/T08YZYML67APpIttoSEWSb4aaPbym97oC6alr42spUIrg0rFTr1/R18F8bFKzfhHM+lKPGm7S4RwDKhbHcZ5V32rjintWdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709572226; c=relaxed/simple;
	bh=ir7CIMz84CsYxYaV1KjttiipiJKUuOcc6oUPRUzVK8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYgQgWqiHgEnAbOZgrwg915fJxvbiei10kNzyaxOLnvGWfWEFAatT04JbNmh+jWqkKwfE2/QxQnhiCjlH6+gXR2Mg2dtujb3ZGRLc6R3JfirxtLEkQOYV7K4RMXUoGIDrOApsaiXmfNA7eLqXKyEcZhrJVxshz8nh/GDJEpGHQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WH2sUL65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65935C43394;
	Mon,  4 Mar 2024 17:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709572226;
	bh=ir7CIMz84CsYxYaV1KjttiipiJKUuOcc6oUPRUzVK8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WH2sUL65uuJb1FXEFfxXJzD4xUHPjhvCwhuc35gH6m+oszK2XeEK2rKGEGOBTSU5O
	 avnLI9H8cGiMutKCJejAb0cKvAq8K6OkeZNL5P/tfHQe0UQB0pygOhXyaAoMGQ633t
	 AIpp8ylPvnwoogpRz4MBuhXhdLS4T5Gi41+vnZp/JeR7G53RL48S5Otmkl0IMe0HA8
	 y4Dw/jRzqL3SChEXl96EhNH3Cmx7YTJZRTUdlxIm0lZVeKzCQyik3hetr6Ovpspkqp
	 NcsSmFK7fayrZM/bqld5LhffOab2ecFDHZIzL2O2ymeeAn8ixhr5vbm8pd2MFLJqE0
	 kgSYOOR6PPkoQ==
Date: Mon, 4 Mar 2024 17:10:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: oc-tiny: Remove unused of_gpio.h
Message-ID: <9ac09714-25e6-429f-8847-0ee6a34e0220@sirena.org.uk>
References: <20240228193732.3605768-1-andriy.shevchenko@linux.intel.com>
 <ZeXd7zrNZSTW3va0@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dPx+4uutjh+/sTt7"
Content-Disposition: inline
In-Reply-To: <ZeXd7zrNZSTW3va0@smile.fi.intel.com>
X-Cookie: He who hesitates is last.


--dPx+4uutjh+/sTt7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 04:42:55PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 28, 2024 at 09:37:31PM +0200, Andy Shevchenko wrote:
> > of_gpio.h is deprecated and subject to remove.
> > The driver doesn't use it, simply remove the unused header.

> Hmm... did it fall through cracks or anything should I do?

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

--dPx+4uutjh+/sTt7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXmAH0ACgkQJNaLcl1U
h9CBJAf+KCmOyXbSHMSaUF7iM+zgyrhoXTfgVHjEVwpXQpfln6OE+3PioX6XmDNW
LofkMmGBQf48vwR+e1n6orXYP+OvlzzupDHDvmHSrDP19fTcUs6KCtsDRn8nnnhu
tBjUPdwyxM5v7AfUoyocY7PfZPPwflWjVX/Mx8RKl5BcXU/NULfqBy5EwEhvuI01
2m3asHZn7+Rv8cFnz33FZYQ746RbwsYdBwTQ9j0Gz2s47BdMDI5P9RqUMyaWaQIy
8G5AJu/AGoBdgeZTqPIA8FwE0j+TM5NY1I6bxriH4B7KPRyn9MrlYJnSfxb0EAKJ
xJ0slGZ6RbNIFg0oEe4O+knZHp/j+g==
=oZhH
-----END PGP SIGNATURE-----

--dPx+4uutjh+/sTt7--

