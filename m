Return-Path: <linux-kernel+bounces-4494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD14C817E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9631C21E35
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA160760B5;
	Mon, 18 Dec 2023 23:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="uzeDmeTr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEE7760AA;
	Mon, 18 Dec 2023 23:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1702942500;
	bh=HJ1CRQWLiCZq8U/lr5SyAp2NLP9GNnqriT3hKzk8dXs=;
	h=Date:From:To:Cc:Subject:From;
	b=uzeDmeTrTKdzEtTbOlD/eWQPqSISeY0VsR0eNfFDj/9Q323ITzzJW/ccIWfg1SJ9P
	 +i+HsFy4sCq6tRz0D2HCrVCNjNG5+0mPgXeztNUyLq3AG82KvqKN3q9hyRrxpeH+rJ
	 pc5jbqU/ULyA4QEh2svcdzcu36IAs8x12V7TjaAhmstsnIsIIE2spYrENwDtnZcT74
	 HzK0pIcLS3rMEA5TlEh+d7zIAIVlIpe0GUkjTViZtofTWZvSZ446mTJGUogR4YLfOt
	 Ejk28oSqFn/c5TFA3lT3/3uA4f4gCDjyYihV+PASFbAdY/8142c5yZ0tleEkNLC0Ih
	 vCfQ7sP4XvC0g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvGQC5gkhz4wbr;
	Tue, 19 Dec 2023 10:34:59 +1100 (AEDT)
Date: Tue, 19 Dec 2023 10:34:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
 <rui.zhang@intel.com>
Cc: Fabio Estevam <festevam@denx.de>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the thermal tree
Message-ID: <20231219103457.4e034e9a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hPaIo/OfsMOZ0uTj.GPQbje";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/hPaIo/OfsMOZ0uTj.GPQbje
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the thermal tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: "__hw_protection_shutdown" [drivers/platform/chrome/cros_ec=
_lpcs.ko] undefined!

Caused by commit

  726edaad90f6 ("thermal/core: Prepare for introduction of thermal reboot")

I have used the thermal tree from next-20231218 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/hPaIo/OfsMOZ0uTj.GPQbje
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWA1yEACgkQAVBC80lX
0GwW5wgAh4J7ovvk0fyqzaSHqE9KpawWnrZh9a7NbqnbQqbozlkU7l+MRyddORd7
MGZdqwbwtch5B8N4mQ7mWF3bCJiWqPkDSEGpepRdRqUSVvVVl//v8Ge2l9MX2AoK
mmwE5lC/URWB0Ie1wtMdqq9mHwvb+VwV+lUdD17fmf+LZlD+ckc2xJMxq2A90r4B
QJS3aeAyMQXTiRPRQkcbIIAvx3sZEGmM/zOD7aGvpmjLlGQI+Kiq8XVsfnO9zmje
eLcPrRS3QvLn1jcnY35vgk2zjEsBoKkSzbqZ79+rg0Nyen1pHK6DB7QXVyo5tWL6
gERC0Tys/bW7IXMvsI5uNG+goSexRA==
=SfjZ
-----END PGP SIGNATURE-----

--Sig_/hPaIo/OfsMOZ0uTj.GPQbje--

