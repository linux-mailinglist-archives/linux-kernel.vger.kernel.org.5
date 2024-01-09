Return-Path: <linux-kernel+bounces-20379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDC0827DE4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FFB01F2402D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A729A5C;
	Tue,  9 Jan 2024 04:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LHjc+J9j"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7886124;
	Tue,  9 Jan 2024 04:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704775249;
	bh=OD1kdsXDxhb0d73nWXl4qvfjYdrXuITC1OxevP0TOq8=;
	h=Date:From:To:Cc:Subject:From;
	b=LHjc+J9jIAtaDmZKtYM6LKC6HUssL49hPyPoW+FVpOdkMb5vyv7uTZZU/UEJImNH4
	 cGpLKZ5cBFxDbT+LZoJnVfF5JyPrPTTLY+MlD7SalpvNK2QAca5dXJF/w0Bdt8cL0O
	 54ydOBf6m9LiVKrPnaaNTcP8/RxchYjjCUIyRrIFkqHcVUIEViEzN9IffB+oP/i4CG
	 LCNVPtU96bCwiCAGCnWOPbDp3EhCwFh0u7BdLK+uHrMLNtsOcfppOJnKEHxbF0Bb65
	 TCnutvrX6TaH9B4LU60G5/LqT6uSAt1op2Yy+OuD6dP6beiYcwwVYYBkt2Ltt0dy03
	 0/dOV8pYa3SRQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T8JCN5Zy6z4wbR;
	Tue,  9 Jan 2024 15:40:48 +1100 (AEDT)
Date: Tue, 9 Jan 2024 15:40:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Boris Brezillon  <boris.brezillon@collabora.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li
 <Frank.Li@nxp.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the i3c tree
Message-ID: <20240109154046.71ad80d2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/K9Wo=8QArLdjIPEdYYXEIsL";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/K9Wo=8QArLdjIPEdYYXEIsL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the i3c tree, today's linux-next build (htmldocs) produced
this warning:

include/linux/i3c/master.h:464: warning: Function parameter or struct membe=
r 'enable_hotjoin' not described in 'i3c_master_controller_ops'
include/linux/i3c/master.h:464: warning: Function parameter or struct membe=
r 'disable_hotjoin' not described in 'i3c_master_controller_ops'
include/linux/i3c/master.h:506: warning: Function parameter or struct membe=
r 'hotjoin' not described in 'i3c_master_controller'

Introduced by commit

  317bacf960a4 ("i3c: master: add enable(disable) hot join in sys entry")

--=20
Cheers,
Stephen Rothwell

--Sig_/K9Wo=8QArLdjIPEdYYXEIsL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWczk4ACgkQAVBC80lX
0GzI6gf8DnmLRstU0lsNjqZvxOdUqA9FjMCndxkzn4uLhYbdUZ++iJh1Lua0HdMJ
9XaGw1dSdoGDMLb0396tUyjTDYmx92fWm1CQ1zgE66HAusaazvQONf4/zsiJ8Wbd
K2slxXxPUe+iGP7nU6pllUCDIGWZbRSMSIkapNsLcvm2xOtXOckb3x4oBQOADQPw
B/RQkYyjR/LpuQJVLQkUV+dWZq6lEsmckxVZUjRflUOkfqhPI/ZNTq9OdRKVy3Hp
dvH1RScvxbzgps3pVhqRC0hbUrt0cQKCTnMwSkwIGsY9895rFz7BfDrmFDwq2lEl
HZ9q3pX+YOjQb6333xVf0iBWn4XDbw==
=pb7e
-----END PGP SIGNATURE-----

--Sig_/K9Wo=8QArLdjIPEdYYXEIsL--

