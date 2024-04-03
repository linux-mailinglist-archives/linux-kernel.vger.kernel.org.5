Return-Path: <linux-kernel+bounces-130708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79652897BDE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB641F25437
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EB7156979;
	Wed,  3 Apr 2024 23:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iKX71dB0"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8704615686D;
	Wed,  3 Apr 2024 23:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712185478; cv=none; b=rbMLIrw1RZPO7nvKZ3Tbx8HIHSCbEQu5pEmBIfXYP3F6zPNh4mnxKGclZFsnVwsOjDuACPBTsMfh2vcEDX0B2aMshqS54JfEYHozSRfyI40ef7YpqDJkfqOgfM9IJBcuAfGusxVhcUSOtO8vrA889Iv/CgSKAJ9TK8TWhzAZmls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712185478; c=relaxed/simple;
	bh=p0B+KzeoKsGPV5moQo87AqFn4hIbr+yGKAhlUgIGrtk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=TnlCBdBU7wev2wBtV1haZig7cYeYVe6sxdsbpAc4avwEOmWZQBGuJxa9dfl671hA9u30DPUdfyGuJl1J/lqlz1BdBZG2Z9mrB7X0ThMt6WQub/vrfN/jQAAQ5HJS2tZLuZF7xIXlBx3vdpQOh9VWYfFtyqX+ZJe0YEl19T4iX+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=iKX71dB0; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712185470;
	bh=pnryQuPhuGAULDvfxr5ClnJzmhEyaiMzdzleSjyuBYQ=;
	h=Date:From:To:Cc:Subject:From;
	b=iKX71dB0nV/jmQkmFgD0Y7WfboOIaAljYo5g1pj/RQDNn9WtOPkfEdYRYCmaoUSYQ
	 NtDLx7zvTdn0M1ewd6s3t3TRwD+JM2gR8c/m+5MPZpWG3+v9A7V5HplbVtk6dMBG+t
	 NEnhgRdSgkunNKQfSiYR1nRgMe7aw6vZz6APbKlDIzOi0geMycK5zLStCky4Eo5Jr1
	 /U/FMTaZ9rgQaH0wAQ00+SHEXNMLXHWYbdyyEeBMZJkRx7B5xbH/k2vQZZpysoZSqs
	 1u8ODIN3i8eUIWFungaRbG1P+V5lDLih2g5ay9/hvG6FxNJo6Gljl2iBTiXl7Cg2LB
	 OLA8AyJHA541A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V90gf1Yxbz4wcC;
	Thu,  4 Apr 2024 10:04:29 +1100 (AEDT)
Date: Thu, 4 Apr 2024 10:04:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Sterba <dsterba@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the btrfs tree
Message-ID: <20240404100426.72a84d28@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/25YY4HjbIBNgz5HZzrnScxU";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/25YY4HjbIBNgz5HZzrnScxU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the btrfs-fixes tree as different
commits (but the same patches):

  16b265d574c7 ("btrfs: qgroup: correctly model root qgroup rsv in convert")
  49514f133c10 ("btrfs: qgroup: fix qgroup prealloc rsv leak in subvolume o=
perations")
  79bc0330ea11 ("btrfs: record delayed inode root in transaction")
  8a9fbee85827 ("btrfs: make btrfs_clear_delalloc_extent() free delalloc re=
serve")
  99e563e30c41 ("btrfs: qgroup: convert PREALLOC to PERTRANS after record_r=
oot_in_trans")
  c22750cb802e ("btrfs: always clear PERTRANS metadata during commit")

--=20
Cheers,
Stephen Rothwell

--Sig_/25YY4HjbIBNgz5HZzrnScxU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYN4HoACgkQAVBC80lX
0Gx5Wwf+Pz5sVF370bXMbO7OxSo51xCzFLDM9VP4fmjnimG815gKQsPYtQdVXlQe
MVPLItsZ/i/gLHyEKHPaaeSRRX0SmuLRbYLMgUY/1Mxch1IneUVJxs6/SPquhI/o
Qv9NKmSCxTICeXhu1gCi/9MvfXh5X4G4Z8IhjV7pMb/sY2m8OWXPm2g+adjDbBdg
e7+g+equAsZFWIk69IkSdO4iESBEX6jd1CmoPWggB+406BMTytm0yg4HBNVUQyLL
QOOEy9knhvMBFz2YV+ZTLlzy9pM9cC8TPYYNhycc5FX/2orkOwh0S/tmSicL0GX4
2pZwE3R04ehNBLlm7pd2zC6Efwdh4g==
=R7+X
-----END PGP SIGNATURE-----

--Sig_/25YY4HjbIBNgz5HZzrnScxU--

