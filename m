Return-Path: <linux-kernel+bounces-80312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66226862D3A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E291C20891
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794041B960;
	Sun, 25 Feb 2024 21:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kH22xdVB"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C4ED2FE;
	Sun, 25 Feb 2024 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708897136; cv=none; b=RkojXUSDSa0UuD5G9wWZcU2/cxIc0g02eyytHbPWr/QIjLW+1oARLhum94UrvKh4Pe1uHl0esoz62zHWkkFzz/lLSV01BPwMTrJd96M1RweTTymHppYgsuibTs7QxdYuXk/cCM/FM2oqw23rYIXlDGcvX849IDMN9Kw7k3Qn7XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708897136; c=relaxed/simple;
	bh=C6ZRlr4hhwzZi76Oe0YZb2r5RybeBtFmwf4TAP7UQbM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gxjws9aYLmLgq0/giLBBzfmvJMFlAxOiNyH0fMNfwyXpqv49YT4JmsPElWXIPborowajgfrHCcL2tHyXX0QRDNBocRZhAG8tRXTugA7/j1DFXafgfzo/G3iMLKd0thaIfa/iBiRN6NO1o1Vl0ZukD/qr6rgjqvy4EEp8NI/q9wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=kH22xdVB; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708897130;
	bh=1/jCEWG+8g2pJX5P5neA7Evh2tbbkvcFKwZoV8Ds+OU=;
	h=Date:From:To:Cc:Subject:From;
	b=kH22xdVBg6+NWvwOgXvkVrJZdtxw1VPly6ayq+S4K29vNUEfQiUKpT4sWyESsgslO
	 CvJUZdmX6n/VsO97ygPKWcaA7XczYCMb9bXv72w1MfQhMXPPjm5qPf2tWttK7ReCtR
	 AAYdK7GbeLjn+m+2nDo8Dbp59zutrO2zOQLBKWFYCiqXh6cRRAOzWOmdN9rbQfncfb
	 JCWQ1DxHjLVH3dLuVNDgUJhqAnbfNxfE7l5HUlc4TDjJPZOSsFTWKP+z7uHVltRryf
	 mcUxZGo33wCKgPfYoXR7zXjXiOAJICgzyaCuNkU8+lucdUtPijggVr2IzxrGriJR15
	 tJ4fPisnp3hVQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TjcZL167Jz4wc6;
	Mon, 26 Feb 2024 08:38:49 +1100 (AEDT)
Date: Mon, 26 Feb 2024 08:38:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the pm tree
Message-ID: <20240226083848.3d864885@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TVNqU9ib/INJfkAjCfrViHl";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/TVNqU9ib/INJfkAjCfrViHl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  43b549c5d8de ("ACPI: property: Polish ignoring bad data nodes")

Fixes tag

  Fixes: 6018731b04ca ("ACPI: property: Ignore bad graph port nodes on Dell=
 XPS 9315")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 5bd4edbbf920 ("ACPI: property: Ignore bad graph port nodes on Dell X=
PS 9315")

--=20
Cheers,
Stephen Rothwell

--Sig_/TVNqU9ib/INJfkAjCfrViHl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXbs2gACgkQAVBC80lX
0GyKyAf/YypIwFEV6aHy37F3mgm5pvHsze3towl3PULRTixdhCKcuR+vPi6v5e3l
NaSVq2Kc7hi9VKNoeQ9aC5M1GsjqAg8nvHAnFQLeiY0BLznmWfF3Zd6p80ei9+QN
tWeXssAyUZfsFcoFhW7l3KYiyD9oJIsnJHuLKDOmhoW1FBeqshC95BeBgvcL48V3
vfijsKPkSzKOEYBqh+2H1ERj/CD94iimO/pewze9aTsD1g+hM+KZtorQLhzdySMQ
/+o1xzLfToucuQx2qpWBxWa5xrgwDMgvU5KHmwrCV+wyOw9kYii1hkLTAEofmTD6
ap2OvLK4F/TbEmhOKIn5Xkd4wHpe0Q==
=MEyt
-----END PGP SIGNATURE-----

--Sig_/TVNqU9ib/INJfkAjCfrViHl--

