Return-Path: <linux-kernel+bounces-106895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD9787F520
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6541F21DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1920764A92;
	Tue, 19 Mar 2024 01:42:39 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDBA1E504;
	Tue, 19 Mar 2024 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710812558; cv=none; b=qofnPdeAjo/7A+a70+irUQ+K/oHeN+PYQgtTzzO3d1hT/SBxKQh1Le7IzewgRtmIPi4IFFZ8oe0sbSpH1NuQqvjL2u5Fed9pJuvqOPndE1KgkxatEsgkU6oe6I9VqXEYQE+lviM0F7B1cxMnfY0lzZlGwgIO1NM5yVCylE2fGWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710812558; c=relaxed/simple;
	bh=xzsYvNWKhVY6etQtKChX5/0UdHVuT/bqKtxzfd7W/98=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MvFHaMUnTMw2R+uVIPRMsRH0RJ5betD2aZ4c6RoLQ1CspwqcJkgom3johrcqzpgmc3lkicOZILiKvsizMMyehKaznYD1BbdZw0sVZ1lzmqOfsSzObgYPJOeXAIgayZei6CBsn8Qmxzi4InXsRfm7xapy7J+FsxgQ6t3YT9CNCrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7ab02576484b4260883ce4e6914adae5-20240319
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:228200b1-ea71-40c3-af52-feef24af35c6,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:15
X-CID-INFO: VERSION:1.1.37,REQID:228200b1-ea71-40c3-af52-feef24af35c6,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:15
X-CID-META: VersionHash:6f543d0,CLOUDID:c43d2785-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240319094226CXQRFDBC,BulkQuantity:0,Recheck:0,SF:66|38|24|72|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 7ab02576484b4260883ce4e6914adae5-20240319
Received: from node2.com.cn [(39.156.73.10)] by mailgw
	(envelope-from <wangyufeng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1617078796; Tue, 19 Mar 2024 09:42:24 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 2FD0AB807587;
	Tue, 19 Mar 2024 09:42:24 +0800 (CST)
X-ns-mid: postfix-65F8ED80-1244201
Received: from localhost.localdomain (unknown [10.42.12.106])
	by node2.com.cn (NSMail) with ESMTPA id 42343B807587;
	Tue, 19 Mar 2024 01:42:22 +0000 (UTC)
From: Yufeng Wang <wangyufeng@kylinos.cn>
To: Denis Efremov <efremov@linux.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yufeng Wang <wangyufeng@kylinos.cn>
Subject: [PATCH v2] floppy: remove duplicated code in redo_fd_request()
Date: Tue, 19 Mar 2024 09:42:19 +0800
Message-Id: <20240319014219.7812-1-wangyufeng@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

duplicated code in redo_fd_request(),
unlock_fdc() function has the same code "do_floppy =3D NULL" inside.

Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
Suggested-by: Denis Efremov <efremov@linux.com>
---
v2: The commit title is too long, update a new short commit title.
---
 drivers/block/floppy.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 1b399ec8c07d..25c9d85667f1 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -2787,7 +2787,6 @@ static void redo_fd_request(void)
 		pending =3D set_next_request();
 		spin_unlock_irq(&floppy_lock);
 		if (!pending) {
-			do_floppy =3D NULL;
 			unlock_fdc();
 			return;
 		}
--=20
2.34.1


