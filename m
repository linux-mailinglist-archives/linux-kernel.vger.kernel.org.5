Return-Path: <linux-kernel+bounces-30692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B831832320
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4CD1C22AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFFD1375;
	Fri, 19 Jan 2024 01:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="srtiBcBV"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA1B4691;
	Fri, 19 Jan 2024 01:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705628846; cv=none; b=tI3376qsQspeAx4lhd8zWQfo96qrFs3l5yuG0ZVqIr8/1xqGxtBhBhEkjVDNS8eCIHIQge9b3eIoC57zimJCVyX5R4GxsatiEyddARx8rSfcmMW7e78TU/Dhz5mvi+1lretU3H6HCvwvaIPh0ZOJr7K47RP0tHEOiMqPgc+kPaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705628846; c=relaxed/simple;
	bh=wQivY0pWW6w7xKu/OOnqm/ChK0c4f+0qQZR/pZI3LCY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=sYBZwjeqKnEg3QFvateC4oPKUXmRnNqzDMqF1im2g9Kjzrq7Qe2Gg6XdIOK5shbUofouDmzso+F+B9n/OgxsYUA0JYhlpXdmbHHwA2MWhM5jK25Hk4r9E1wqQuP2/DsANJP4gYIQI1jneM50VZPiqW17QPMQd/VdgpRE4WAwZGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=srtiBcBV; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1705628839;
	bh=KtGZVy2bxqM8exDfb7DvTYM5vDGOCgBQyRjFAA6zJws=;
	h=Date:From:To:Cc:Subject:From;
	b=srtiBcBV/92pcjHNjpwRASIOenAa5LUdfiMXh2tTyRFOrEnagjM5Sz9Ure4V0M6vQ
	 T99sK2m8sYZkZLQPWJPxB2JtJDTqsbGikrxPdNT0S0fEGwrhhtZ3TH9Rs7wckdp0Tl
	 h5w1fOD1ZjIWQ26CDwYCP87qfTy3LA3IgKTNvkgZ1YfK2qTFRbsJQ56AG6ElCbybTN
	 xi/I8dn0+/isDZ7gk5PtvaRXDyHV/3hMFaxrmnrw6gNyO9ABFYL/bcATZ9oJ8WHp8V
	 wRj+CcDQH+Q+/UXVUsMXvk/p3iZo0+F1oE+u4KDQICfVVmeZePYmIpYJWBrkoSC6Yv
	 7cT6smvbGB9Ng==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TGMtZ5mdmz4wy9;
	Fri, 19 Jan 2024 12:47:18 +1100 (AEDT)
Date: Fri, 19 Jan 2024 12:47:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Steve French <smfrench@gmail.com>
Cc: CIFS <linux-cifs@vger.kernel.org>, Steve French
 <stfrench@microsoft.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the cifs tree
Message-ID: <20240119124715.7be9a3d7@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/F4BzNxJH3cRkWVtPzKyKz=Q";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/F4BzNxJH3cRkWVtPzKyKz=Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the cifs tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/admin-guide/cifs/todo.rst:7: WARNING: Definition list ends wi=
thout a blank line; unexpected unindent.
Documentation/admin-guide/cifs/todo.rst:20: ERROR: Unexpected indentation.
Documentation/admin-guide/cifs/todo.rst:21: WARNING: Block quote ends witho=
ut a blank line; unexpected unindent.

Introduced by commit

  e7dccb219fde ("smb3: minor documentation updates")

--=20
Cheers,
Stephen Rothwell

--Sig_/F4BzNxJH3cRkWVtPzKyKz=Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWp1KMACgkQAVBC80lX
0GzQHQf8CxeQqMZ38/JSJ3yNqBinSX0qKVxwNkji223x3zo5bLjkkmIO9GNE6Req
dlLMYVP4DpGfJvTnWcf0vATrdqxyc0G0pgvbrsxOiHN3rN55qPjwiPzIKPExLBsg
8sfo+GiSTe1ZPO+E8GBDl5LurAW7GvOQPn41ssak61wyAvtIcGGnGrDnX91ohxXw
YKaCeFaCkibQzl1WLSSeGkukmGZM7QoV0H89vo3yejfgp9VSX4FgRYELcQEfa8y6
ZkUEROGi0WWpASf05D36pvWumt27l+aDiXYEIoj43Qerf91gSRx5yWtY3b6O+9+A
Y2L33at6kZSvLl8MmCxKXPI0PENLAw==
=awMF
-----END PGP SIGNATURE-----

--Sig_/F4BzNxJH3cRkWVtPzKyKz=Q--

