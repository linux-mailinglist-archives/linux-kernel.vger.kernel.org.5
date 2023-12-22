Return-Path: <linux-kernel+bounces-9291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB0681C374
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFC761C24812
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 03:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7E079C4;
	Fri, 22 Dec 2023 03:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="s4vr2K7M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD5163C2;
	Fri, 22 Dec 2023 03:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703215798;
	bh=ZjTAReK+4AutrZqqwPCmUGG9nhSNgmsOovJ+6BfDm3k=;
	h=Date:From:To:Cc:Subject:From;
	b=s4vr2K7M48u4jHsfd3vuBvQqjYNJwAYYrozujypTC+dgDEafSnI8nEamHkCDwq3w6
	 sug++SEZh/KfvhpucodqqwTzQQG2JPDJQgRlymQyxy54kSNA9zpSZIyCuGBys0kc+k
	 XkuJ8cccvMKtrd+NG4KIaizbViXCHOkFtWN4ZHBoV9jN8XweMbP0PjZvpwGXujW71m
	 deck7M3O+uhhdxDglbQc1wBuxIttWdiB8aOxZJF5M3iDUTJUE8NV5CSrZaYu2lWwW1
	 LV57d62sufCvGqF2CYyh7DdmbF8u7W6Og83MreBscdsa84ViIOphs26I9jknin6eek
	 23GxgsoQqeGQA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SxCTx3LLkz4wbp;
	Fri, 22 Dec 2023 14:29:57 +1100 (AEDT)
Date: Fri, 22 Dec 2023 14:29:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Vinod Koul <vkoul@kernel.org>
Cc: Jan Kuliga <jankul@alatek.krakow.pl>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the dmaengine tree
Message-ID: <20231222142956.3ee9749f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WahcYMu61Tsmh/jG5vt/d4v";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/WahcYMu61Tsmh/jG5vt/d4v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the dmaengine tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/dma/xilinx/xdma.c:729:1: warning: no previous prototype for 'xdma_p=
rep_interleaved_dma' [-Wmissing-prototypes]
  729 | xdma_prep_interleaved_dma(struct dma_chan *chan,
      | ^~~~~~~~~~~~~~~~~~~~~~~~~

Introduced by commit

  01e6d9076561 ("dmaengine: xilinx: xdma: Implement interleaved DMA transfe=
rs")

It should probably be static.

--=20
Cheers,
Stephen Rothwell

--Sig_/WahcYMu61Tsmh/jG5vt/d4v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWFArQACgkQAVBC80lX
0GxC/AgAkm3CDGpM/5spA5FKaC76wzkVPHBMx7QnDa4ynBq/yQUtultVXVehjiJS
5Jncl6AkoG4CjVlUSQp8KKo3j2EhT1KRMWV5RuiN4vjVKEoDDsswseXigiIf9qX8
pDuSk0SPaUgB5Tym9k7OL4GdhUJjZ+Ru+bnHlTT/XN/CzMccFTEGksMHrX+ezI4U
fIZZhok2lcGRr1NmdwrqoEa77azVbnMCeuOINETZjpUR6dWcL4NiE6tBlurPhJAD
SRtrP/6eG3V6a5UzT9+rFHyGLYSX1h+kR4uNG+92y6xViKv2BXvvDGhcfVNFS2Tf
kPQqKVSGXlBgZM4A0q49uW06nVXgEg==
=ClHa
-----END PGP SIGNATURE-----

--Sig_/WahcYMu61Tsmh/jG5vt/d4v--

