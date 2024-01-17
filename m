Return-Path: <linux-kernel+bounces-28462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C2A82FECD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B592EB22FA1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB3C1FAF;
	Wed, 17 Jan 2024 02:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gdf5BwmY"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0555867C6F;
	Wed, 17 Jan 2024 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705458525; cv=none; b=kpUvuRZ/yzRgybUKVBTQj8eZ66hsscteftYCrnwwc4BPxDeA5xfxY+KIssblOk2fA8yoFuV6om4/kePQYdZSkOGJuoTnpDFOKbaWE05fB5YfJEcvzjhn09U3oJohv27yaZhss+wPiD3m7T16GuRBCKn+ak27uLihB+JILX/uOG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705458525; c=relaxed/simple;
	bh=gUYaIXsAnsWCAGvlwrbJtxyQWPTPXTHSo90ogSxZpsk=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type; b=Bf7YneolgrQe6OoHoUrYqXamXflmoDICHyYSm+YSd7vbosueXxBqry/q/QBX/oBfTp6j0TxuvJi56qqGJG8m3FDOUzH7OtNCakjEeGC2dsZTXoRYba5w3FbyMATkpECkmBGgytHlBmlqj3EYk1Y/Ymj3CJ8kTN5JPfatHcSU2R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=gdf5BwmY; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1705458519;
	bh=AILWackQ3IIQxSReCJYiOEICpCBquDT3UIg9BsXmvw8=;
	h=Date:From:To:Cc:Subject:From;
	b=gdf5BwmYKu0+LYriuCRuslVGPm2BJL8lfYBKrOnsFzUApo3ahXHv/E7s+11gOFw6J
	 agVjQLwO06+z9jy6BGtN/wsRyhD/thdy4Hzm6aJsJPvuxjK8yBK3EVWbaESuiRaEGr
	 j+RlU6WvRmOu33uALqdVw3yPPXyPJwnJes+rYjcmRG06eAmYnJ+WWWO210E7b1ZVms
	 2pE6AGbTHFWjOTubTU+xPwhdbz4h7dm0tqiGe10+ZRgl3NntUIMCkSl9Oq291iLr1O
	 W13RlnMpBWyn5/sgZ8Ix9uYBCHYKUdQKa5x13AH9PfkmrhEldseWu0fXMXuvUmJBK/
	 kTCd53R8wjChw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TF8vC1FNyz4wqN;
	Wed, 17 Jan 2024 13:28:38 +1100 (AEDT)
Date: Wed, 17 Jan 2024 13:28:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the bcachefs tree
Message-ID: <20240117132837.3b1d8caa@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vdhNBSut0YlYsBFp_NUN=Dm";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/vdhNBSut0YlYsBFp_NUN=Dm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bcachefs tree, today's linux-next build (s390 defconfig)
produced this warning:

fs/bcachefs/btree_write_buffer.c: In function 'wb_flush_one':
fs/bcachefs/btree_write_buffer.c:128:24: warning: unused variable 'c' [-Wun=
used-variable]
  128 |         struct bch_fs *c =3D trans->c;
      |                        ^

Introduced by commit

  3e76edb0f4db ("bcachefs: Prep work for variable size btree node buffers")

--=20
Cheers,
Stephen Rothwell

--Sig_/vdhNBSut0YlYsBFp_NUN=Dm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWnO1UACgkQAVBC80lX
0GxD/wf+I0Kos60IyuSN9FO68GSDPv76Jhl0ALB0mID03NyYo85O3nWseaLBEeCA
TFIC9gMHnMi2TvD7Zc2/WsNnx5Y4rO6ya6FaGmJzN8ph+N00sklI6ekeHj270Tke
K5/4+SScTHmJR9q2JpQN/yUDV/1KYYdHWUhCPC4wsg4TrUnBFIPOJLKad4Ss0xdb
JHMXafxk5Hwo7sXNC4U0pI8R7yTC3C9PHXckjS4B1l7csYgZTUPek4LBsAS/TDNz
EyZQf31eJrql/I7vzJfVTSioiI8f34HQn+G7jxvxD9wZbi7s5gVFXmI/YGivJnh5
r8dcXirx1vWDRg9XNUE4i4cUXwSWVg==
=OkLU
-----END PGP SIGNATURE-----

--Sig_/vdhNBSut0YlYsBFp_NUN=Dm--

