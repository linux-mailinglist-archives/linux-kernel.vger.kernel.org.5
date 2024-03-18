Return-Path: <linux-kernel+bounces-105733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8562787E39E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4FFD1C20D44
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3FC2233E;
	Mon, 18 Mar 2024 06:08:11 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6A125760;
	Mon, 18 Mar 2024 06:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710742091; cv=none; b=bsUA6XOJ34YxYTDn7ud2X9kFOXxJRb9/vEZH7FzJbhey307WTX5KAE66nwdT4l6uYoEOvtn2HtWWNparZpBsDbBPHSnZ1jnTSW9wazP2aDuPZTzUIKjSfS+gDN/TOkTca22BwWDwrsLS4wk0sAUC/jxqhhoNtxEE24q4er7yDCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710742091; c=relaxed/simple;
	bh=HidclDyKzwRkwWfUSuUAQNcNN6rOoKPyRcPubwTEddg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LwENOEZ8sraeFww+3eO+D8j++JgHFqCwVLftFSG9NDo3QPBNgEcmcZt8Gkx3EylwizSMKkIGvXihJNUYrszi4DO4U7Ld5U0JjKbXS57aSwOd+4nnyyqeVB/uldgc1EJ0Vib6ebEVDVfcAC1Fte3qDoGyjaMBBBmKh9oRRpIlmpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3b5a911b6901478ba98d27ef83d7aff1-20240318
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:4826ad02-b567-4506-bfc6-14e8f3afc932,IP:20,
	URL:0,TC:0,Content:-5,EDM:-30,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-20
X-CID-INFO: VERSION:1.1.37,REQID:4826ad02-b567-4506-bfc6-14e8f3afc932,IP:20,UR
	L:0,TC:0,Content:-5,EDM:-30,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-20
X-CID-META: VersionHash:6f543d0,CLOUDID:36a21e85-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240318140518DUIROKMZ,BulkQuantity:5,Recheck:0,SF:38|24|72|19|44|66|1
	02,TC:nil,Content:0,EDM:2,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 3b5a911b6901478ba98d27ef83d7aff1-20240318
Received: from node2.com.cn [(39.156.73.10)] by mailgw
	(envelope-from <wangyufeng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 395493931; Mon, 18 Mar 2024 14:07:59 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 3FBD3B807587;
	Mon, 18 Mar 2024 14:07:59 +0800 (CST)
X-ns-mid: postfix-65F7DA3F-89971108
Received: from localhost.localdomain (unknown [10.42.12.106])
	by node2.com.cn (NSMail) with ESMTPA id BB327B807587;
	Mon, 18 Mar 2024 06:07:58 +0000 (UTC)
From: Yufeng Wang <wangyufeng@kylinos.cn>
To: Denis Efremov <efremov@linux.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yufeng Wang <wangyufeng@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] floppy: remove duplicated code, unlock_fdc() function has the same code "do_floppy = NULL" inside.
Date: Mon, 18 Mar 2024 14:07:56 +0800
Message-Id: <20240318060756.18649-1-wangyufeng@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Cc: stable@vger.kernel.org
Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
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


