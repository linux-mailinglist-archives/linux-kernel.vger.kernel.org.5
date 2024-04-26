Return-Path: <linux-kernel+bounces-159380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 027278B2DEB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A0A1C21759
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116B8652;
	Fri, 26 Apr 2024 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EaxcdgIm"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CBA620;
	Fri, 26 Apr 2024 00:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714090729; cv=none; b=EQkGDe1NpGXjQ5rKpARN3ACEWK8ZDKMOockqIqMitYPENsW7/wFzCYAKDgSMAbIErAzL4Uv0t/7ctHOX3PIDYC0+LSIvJEq5F5sQ0XYRDA+C/oSJSFUZb3QBzCBEmXmlE6EjV/VrNfCidlbnAxFDr2zJlL6QNnUR+BgDU7OOF1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714090729; c=relaxed/simple;
	bh=9ycmrmx8XGQIVsVWBCN5lP2LVOqgfEuazMcB2SY/oeM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LgTRqmGtpI5OhCoZ9tFlRW2LJjpptpggYjA7GEkPB9fJSWoa7M5J3VGVlVX7M4PpferODG2fSeuHK5L+J3SP4hCVIXMyHWVOZSIbdUG3XpEotJ4El7xRZjujsmU4DqqMKNL+Wonw/wD9gElyXCnzCucr7Sd5r88BsX20l8yapDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=EaxcdgIm; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714090722;
	bh=V3i7bB4xVigHTQJijvglvbfbxRtYWKrx07gsRRE9zvk=;
	h=Date:From:To:Cc:Subject:From;
	b=EaxcdgImvI+wE0eSFjoo5GeJ730Imps5MUre3KCMZfyt6FRfe4mtdMwGxRcSAN7+5
	 /LrBKUT9F7GdcWq3FwD/mVH2mkK2gF6OPPyfIJIGxae2PdgHq701/rvwhVJsbnu2Xh
	 aOxjV5F1tnFCtg+4SPI95SsD5cPS+vK7tGCGSg63AXlqssTnMg5zHw5YycrlIPR0LD
	 krH5jN5r3JN5bf9WfsA4ALeyW8oHi30by5Fmph8FKbVy4PUtoGl/FuhQ3ZgbSy0HFL
	 Bxq6Jh+PVxGaD4ATxU+AxLNAZkewJQYvuNYP0FoSCKZCQ+BKuuyn2vGE+ifOU5wn9F
	 Q2NWbbOTaauVw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VQYH6008Zz4wcr;
	Fri, 26 Apr 2024 10:18:41 +1000 (AEST)
Date: Fri, 26 Apr 2024 10:18:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Sterba <dsterba@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the btrfs tree
Message-ID: <20240426101838.0cd78625@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/b7_t==gRfH.wBVGWFzcoZBG";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/b7_t==gRfH.wBVGWFzcoZBG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the bbtrfs-fixes tree as different
commits (but the same patches):

  7f1f55f2cdcd ("btrfs: add missing mutex_unlock in btrfs_relocate_sys_chun=
ks()")
  8aa467899340 ("btrfs: take the cleaner_mutex earlier in qgroup disable")

--=20
Cheers,
Stephen Rothwell

--Sig_/b7_t==gRfH.wBVGWFzcoZBG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYq8t4ACgkQAVBC80lX
0GxNKgf/YyRSOPAckz9UNWM+801+y1zPLWj9trEF0sj/4+UMQHX2nz+xHNr7U58L
dnLOPIky9mEUzdnqu4t7tApxXKmxm65hFTSxtn0cHKHPdD3AZg27ABjVplA1YzYp
vcyIhmjOMa2R7mHPh9yoCoYYxwdmx9+0DgJa+z59MboV7P/lDJdSFRhAp5nVDWfN
Rpz7K9raowrWJmgnfQ6VLJVHGNqXgp9OgzauB3TrGNskhtdg+l8sVb9qlE4ZizDl
SmZHzzlbyguKr50Z8a9J4tz4+hJRhs5nRQp92PGXL6ZUtFwcnNTJqJ/sNFXDfFmz
n1tVtt4F8RzRe0ZfyxQhMRzIRe/9iA==
=SU45
-----END PGP SIGNATURE-----

--Sig_/b7_t==gRfH.wBVGWFzcoZBG--

