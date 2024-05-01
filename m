Return-Path: <linux-kernel+bounces-164831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FE28B83B0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED271C21F53
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0783210FD;
	Wed,  1 May 2024 00:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Htu1Lox5"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE47625;
	Wed,  1 May 2024 00:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714522968; cv=none; b=Uzz+1XMECvbrrwFm/dr/6LjV3H3BspwdbbCHLr9O6nt3kXHK1JUhEc5BCbQKAnQyHAqzMRrZCBUuniaI7Ju/xw+A1HUQPmeNdA2XLLW+aVQ7TV574PJZ6zCZxu61+yWSM16Mm5Qyr/oW7VKBsnViWT2cMkV3vGttlKRVuOpv84A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714522968; c=relaxed/simple;
	bh=9ma8h1YWI7JVJDivGTyD80NXVGyder/zRwEJYPUfQ4k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BBtwkUm/srsJ8CqkTPuqeDHRwzuCJCp4mO2mWnuMIJo71PhyKYbacUi5SSYT3GQAXh+tpH8EVbiJouIDSIcXYzW9xnXhmA5BGyf2qmW6q6dazSUEPiJtPNa8NBsTpiIWvNO1j4Ndf7yo0/8ssRpRX5iElZzJJ1BtySv/b6BgcOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Htu1Lox5; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714522961;
	bh=j/MQyFD4x7ofxGWW87wj/gBPiZZOf5wZndIiflW6PPU=;
	h=Date:From:To:Cc:Subject:From;
	b=Htu1Lox5mEzLvB6ELDIV4QXlxHOJOfRJ23E1Z6rAe3CMKFnQOSVQx2XkBA2Y9CFuL
	 GvzZma2Ys+IVLfWqamcmZ9mXVA4kC9iei3E6QgISgYvDFGb0nBcUGt+A89WVsZGMNV
	 OU7hqJ6ns10ICUx8KbkO+SnHqyRgtxQ403wTf/HRGw7Q4e9k/1AJjcbjSRN+QGHHe4
	 KVei1ybxD9mStvMzOLU0L0YU6Tynmz03CJ0AYZST/ToavWQ61x/uiWp3DjPF2DFyVM
	 ViE2yj7i4VPfoH/StD358DIC/SSZTmCmCHW1cwPUgM6DdDiQ9F24Bgs1o9q2tFRqm1
	 2RSYxmjFD9BKg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VTd7M5Mvxz4wxs;
	Wed,  1 May 2024 10:22:39 +1000 (AEST)
Date: Wed, 1 May 2024 10:22:36 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Bingbu Cao <bingbu.cao@intel.com>, Hans Verkuil
 <hverkuil-cisco@xs4all.nl>, Sakari Ailus <sakari.ailus@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the v4l-dvb-next tree
Message-ID: <20240501102236.3b2585d1@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vwnLW3NQHmckwq=vflSFPAf";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/vwnLW3NQHmckwq=vflSFPAf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the v4l-dvb-next tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/media/pci/intel/ipu6/ipu6.c: In function 'request_cpd_fw':
drivers/media/pci/intel/ipu6/ipu6.c:529:21: error: implicit declaration of =
function 'vmalloc'; did you mean 'kvmalloc'? [-Werror=3Dimplicit-function-d=
eclaration]
  529 |         dst->data =3D vmalloc(fw->size);
      |                     ^~~~~~~
      |                     kvmalloc
drivers/media/pci/intel/ipu6/ipu6.c:529:19: error: assignment to 'const u8 =
*' {aka 'const unsigned char *'} from 'int' makes pointer from integer with=
out a cast [-Werror=3Dint-conversion]
  529 |         dst->data =3D vmalloc(fw->size);
      |                   ^
cc1: all warnings being treated as errors

Caused by commit

  25fedc021985 ("media: intel/ipu6: add Intel IPU6 PCI device driver")

I have used the vl4-dvb-next tree from next-20240430 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/vwnLW3NQHmckwq=vflSFPAf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYxi0wACgkQAVBC80lX
0Gz+tAf/Rc6y9Y7QPG1nKRw3l5B3PCGRfYktRKEp73ruX84UZUV4hPrPnwE08WNM
y0Y4MO4UaPCEpGD5xQ3qrm6xdR0Vi7LoIjUMF0dqKT3FVuQ8nf05ZGMDhiHdGqC4
lm6vCNOZfUvVVxSzrRPtBWjFVXfPjw31uSuJqAeRNj4F/HOx8B2/LDRroP0fYzph
t21AjAKnqep8mnk1slpF1fGyKXpnScHyukuv4pVD9RBeje9/26Calv2cJbkJy/9E
+MFjUfbZhFPFj3owPcyvSBPkDNFaTRhGMVfOFrL7WSjVoqGhVSyCnH9Iql68TUJj
/ARaZCoUnFv7UMsd0aJrz3kCp0lRIQ==
=O8G2
-----END PGP SIGNATURE-----

--Sig_/vwnLW3NQHmckwq=vflSFPAf--

