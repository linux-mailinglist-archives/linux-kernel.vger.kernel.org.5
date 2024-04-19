Return-Path: <linux-kernel+bounces-150888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED8D8AA644
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA861C20BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95748818;
	Fri, 19 Apr 2024 00:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VTFRe/ZD"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62723384;
	Fri, 19 Apr 2024 00:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713487054; cv=none; b=uoXb2qV2+STPJwoG2oypN4dqUErPgeWjdiCecicnDSA3Z+1mWBbgUrz+G4wfHO19tSRZw1Lmy7VpLAw2NdwGeDTtI1j9cQWVPMaX2bJ6/bWKn+XDGMq2QOzd3ZFOEX2CD69N4mI6BZksOhs0j2aVk8joubNrwtiVuuTyqqeaao0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713487054; c=relaxed/simple;
	bh=CcGEKncHjnK9oegEy+rFRUzjPhjImM2kopuifNanh+g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FGLzS3zF/17i+JHDZtTUvZeS75Chz5VNIuNJ+MYxVbANypItc+Us2Eqgi9/LyJ+FYYZVID18+UHgz7t2E2T4mr16MEwGcj7vlIZHohPF/xb7PJtDCBp2PT0dthlKrO7OH3DxlWAUurBijP0LxnOmbkdvS6GvOsv40CFZR8FBlu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=VTFRe/ZD; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713487045;
	bh=OX7S1sR6sXcP0D47BRR5wjNC+gpszdeK3EnHLvWyQDc=;
	h=Date:From:To:Cc:Subject:From;
	b=VTFRe/ZDlj34t0VP9+KvFSxBVZcCTSXuVurePCE34zCjxbDmFWBe54Lm0g8PdUsWP
	 ftOfx6WVaN7/xbmfT7zL4prCn5YMcXej46cXK/i3q4AWGLgzci3LOFtO6QvLAqi0Mn
	 divzvbblxU4PoRO7QXn65TWqKRfvkD8x+9qyeoDm+Q0ukJYKF5ZU8NX5n/qNYq3zZv
	 peJd4re6k0YcRdl3AIq9geoSNvqnt7gQ6nkDkYFQuVYropXbwY22NXUBsEsJH/B6Ud
	 dMgr9pqQf1+qmV724c+Fpqo1OpacIC2pjPGrPYD3phUsTLRt3caNln/t1PjVcgbec2
	 4ipM5IXEHKW8w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VLG1x65vbz4wyq;
	Fri, 19 Apr 2024 10:37:25 +1000 (AEST)
Date: Fri, 19 Apr 2024 10:37:23 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Sterba <dsterba@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the btrfs tree
Message-ID: <20240419103723.3192c053@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_yftGmpBDooVRbQmi/Or5S+";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/_yftGmpBDooVRbQmi/Or5S+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the btrfs-fixes tree as different
commits (but the same patches):

  040702ff5478 ("btrfs: scrub: run relocation repair when/only needed")
  37590e1de8dc ("btrfs: fallback if compressed IO fails for ENOSPC")
  43832980f44a ("btrfs: fix wrong block_start calculation for btrfs_drop_ex=
tent_map_range()")
  5093db2d7628 ("btrfs: remove colon from messages with state")

--=20
Cheers,
Stephen Rothwell

--Sig_/_yftGmpBDooVRbQmi/Or5S+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYhvMMACgkQAVBC80lX
0GxCPQgAo1T1K4ZEeesFNJGTJwA+V31WwhAsrc4nXSb8UO2Cc6moCR/wdCCfF7jO
NQ5WdYfJN6W2mDZkWIcaDCO9E2VildCknMXwLfYOQywNUAi+U+hIs59lQYRYKQZc
uqs9alPjiNRHgKYRb0XoY9jGcdhEZs5wGvDD1gTdbZzvyoLtlRmdK/ubTr/xUtRX
Af+UybNytoctQQlU1ZpIBII+BPSfz/SqdxjtfLDI1xh27jPIraIE4PLPo35nFqXQ
HRkA/cvTTyfiBWssZ4T5Wsj+p94XG7llrAe5ZPDdgVsAMSkwbBKYDUU7o3pUSOqH
pMT7N3wCSwk7Dh3mOct5Gb1bjUUwTQ==
=SO2j
-----END PGP SIGNATURE-----

--Sig_/_yftGmpBDooVRbQmi/Or5S+--

