Return-Path: <linux-kernel+bounces-16097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C058238E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6CF1C241A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9527A1F613;
	Wed,  3 Jan 2024 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="o8rZcdDm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7921F601;
	Wed,  3 Jan 2024 23:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704323074;
	bh=0FNwfJNTGkTVJF/7s7AiAmrUgt6nCiD1aUrR6ZJFZDY=;
	h=Date:From:To:Cc:Subject:From;
	b=o8rZcdDmSXvn1BXlN2nSP20/cYUkc9lHf4ANbCA8UFAx+8TG3rDzqq+OJB6NvX5Vc
	 V2cmF/mBwxywFiHS2O/i0vH81+bF7uyFM8FETN/7xDNWTzW9sknzfpDP3zMgK8WGPY
	 SyzIHwmdPzaK2TvsDguLRLtYW3y2vMFV2lHqP1DCX2LJEyaHqDRcDV//8FsWAVNRHK
	 8jIqfbYDNvu16BzBDhkFIGlaJhUCKkxtKw0T13V/HvpenLJYQruYXzh6igPXeihwwr
	 NkS/hCsRJrXJQznoCu/5x5tWrlPgx5FEP2pssE9t9yfMUYQWQH8A+e2S4NWnWMTNmK
	 7ohelpVQC/Xng==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T54zf1l9Bz4x5l;
	Thu,  4 Jan 2024 10:04:30 +1100 (AEDT)
Date: Thu, 4 Jan 2024 10:04:28 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mike Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>, Sam Shih <sam.shih@mediatek.com>,
 Stephen Boyd <swboyd@chromium.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the clk tree
Message-ID: <20240104100428.1f2c3f6a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//fa6zbZC8YgtxDjUtMn_PBa";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_//fa6zbZC8YgtxDjUtMn_PBa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the clk tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

ERROR: modpost: missing MODULE_LICENSE() in drivers/clk/mediatek/clk-mt7988=
-infracfg.o

Caused by commit

  7589129341ad ("clk: mediatek: add drivers for MT7988 SoC")

I have used the clk tree from next-20240103 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_//fa6zbZC8YgtxDjUtMn_PBa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWV5/wACgkQAVBC80lX
0GyXQgf/f9J5EbkHH0E5i1aKWqG0l6iITMdNd0+y1qKp8T+NK4FiipZBXF/xQ/Nz
WdGgTJc3MHwLVA6hM3E9B4eKpphJw0MoPT6N5qH27TggSl+eNG17nDtc5A/152OP
pYljFurF67qr8Ll53Q7Fhezftxp8jrguLX0eXJPkSwO1GX8T0pZO9EMDsCvYMqIJ
V2PjFfCnT6fqWp3WMSIKP5HHzPaRzpXsLVuy/BnjGrVWqcV2PeY1K37PwSBN6paj
VRs1pcvbMaTJnDWicnxQ7duZgmAbMdPce+QBysjKg0rTVRfJMaNXJnVyr/Qu8pxR
bY5GF/4gGja1aeE0cqwqrGED9u+4pg==
=+iMk
-----END PGP SIGNATURE-----

--Sig_//fa6zbZC8YgtxDjUtMn_PBa--

