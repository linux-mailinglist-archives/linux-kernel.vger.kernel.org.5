Return-Path: <linux-kernel+bounces-127063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E27894657
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3B828211B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4350B54746;
	Mon,  1 Apr 2024 20:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="P8plVfOP"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF052A1BF;
	Mon,  1 Apr 2024 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712005150; cv=none; b=GTxtyV9VZXZVm+j0WuK3l1tao5mE9W9SmLdm3/YCujpmbaUr68X/f55PCOwVJ0xDqclM04axEkf6NFLHF5L2G25bgBcazoz7eK+V0yjdgaaMUPQD0iXbDUy5v2wRGwcIj8+A4ftGSNCbgV3r7ICY2QXVZlh74yn5K/JhJgsK7Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712005150; c=relaxed/simple;
	bh=OB0ETBxnseius7m19Wmd6yrUIYnFKVtrxfsfellkL/0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=r37wg1e1Vb3Tt8p6Z+8vcI7O2tksd089YMthZWtSEITgC+lCsqty/INDaC1BIU1KpEv1FJexgkgBp9LZWIZJBasdRRI7qfI5pyV//4crK1wqG9fercmz/Ca3/1upe8hooQxMTnXh0P3j5LmAGDdwTWf8NcbllxsKGii5qHYNNo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=P8plVfOP; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712005135;
	bh=M9y+v2QMPLEHcbgJ2rGOOe+abN6YHUdrG4eoxD783hA=;
	h=Date:From:To:Cc:Subject:From;
	b=P8plVfOPiEOwVa5GYa+hlCTDfnttSyYUTVcdovNgK5oQ4sC2XwqQ77XN9/clflHoA
	 JVU4RZZRb+GCIoclz7FlJO3krPxtDYwoTSBfGrjApejy0wKPKL4VtdhfIvY4+oJbCd
	 aKWDS4UdQa+cQLS9Ab+68QgCyM4ux/svSfKsnMfZNOmMGis10QC/qwKYWss+60Mc0N
	 Kdgkg8rktWmppR1lM8pxMlBqSsEt8hxHV5ilWzzD7yP+GPvSwYfHQMOc2DuqAZBbek
	 rwr+/W3obhL1/wRsJNFvh2vk9XnMgi7uzId3zwderWM6IGo2KmmbjhZ44/qtXKa5L/
	 AXluqUuPyG0Pw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V7jzf5Zspz4wcn;
	Tue,  2 Apr 2024 07:58:54 +1100 (AEDT)
Date: Tue, 2 Apr 2024 07:58:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Takashi Iwai <tiwai@suse.de>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the sound-current tree
Message-ID: <20240402075853.4e5a61cf@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LWwARJsdLi1heG3CjWP.50C";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/LWwARJsdLi1heG3CjWP.50C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  e1d8acf35ce7 ("Revert "ALSA: emu10k1: fix synthesizer sample playback pos=
ition and caching"")

Fixes tag

  Fixes: df335e9a8b (ALSA: emu10k1: fix synthesizer sample playback positio=
n and caching, 2023-05-18)

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").
  - Subject does not match target commit subject
    Just use
        git log -1 --format=3D'Fixes: %h ("%s")'

The date field adds nothing.

Thus:

Fixes: df335e9a8bcb ("ALSA: emu10k1: fix synthesizer sample playback positi=
on and caching")

--=20
Cheers,
Stephen Rothwell

--Sig_/LWwARJsdLi1heG3CjWP.50C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYLIA0ACgkQAVBC80lX
0GxSmQf/U73DHJIZMTtvtRMUHeMJIbfnQWMQFp2wpLLY53vu7Cdv20kc0xM13/C0
KGKp66A9ObD17QOwT14AGrmUeUZk/EqW6OUg2iBOqArQvgnD0Jm7A0pHddgYfLcU
XvHL3A/5MZWS1pFMslPkCBDJMHNCgwyvJploH9SG2lx1WXGCaIenPp8szn7PEGZ0
x/xjX1XFiWFhhiYLFJfTXi8rU1AARgEmDB+aSuGPXWnZo2O8bmu1X3jdCdmmQ/tE
07wpD1NxHCTpEcrCRgaw9VNVZ261kiAvGmYFaSqfB+qPn2CNpNmAsSG0oq+KmCLI
yt9f9y9/jfodIGfX6SNW55A58bI6Fw==
=UjWk
-----END PGP SIGNATURE-----

--Sig_/LWwARJsdLi1heG3CjWP.50C--

