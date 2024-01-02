Return-Path: <linux-kernel+bounces-13984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD19082167C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 03:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5681F218DB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 02:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEEC10EC;
	Tue,  2 Jan 2024 02:32:36 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEE6EBC;
	Tue,  2 Jan 2024 02:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2c410ea93b3e4cacba85cfabb0418f34-20240102
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:ae92b39a-53f3-4113-b068-2fdf06733a69,IP:25,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:15
X-CID-INFO: VERSION:1.1.35,REQID:ae92b39a-53f3-4113-b068-2fdf06733a69,IP:25,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-META: VersionHash:5d391d7,CLOUDID:a4efe17e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240102103214JQ1WJQQO,BulkQuantity:0,Recheck:0,SF:24|72|19|44|66|38|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-UUID: 2c410ea93b3e4cacba85cfabb0418f34-20240102
Received: from node4.com.cn [(39.156.73.12)] by mailgw
	(envelope-from <tanzheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1289491454; Tue, 02 Jan 2024 10:32:11 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id A298816001CD7;
	Tue,  2 Jan 2024 10:32:11 +0800 (CST)
X-ns-mid: postfix-659375AB-484940367
Received: from localhost.localdomain (unknown [172.20.40.222])
	by node4.com.cn (NSMail) with ESMTPA id CB81716001CD9;
	Tue,  2 Jan 2024 02:32:10 +0000 (UTC)
From: zheng tan <tanzheng@kylinos.cn>
To: gotom@debian.or.jp,
	yokota@netlab.is.tsukuba.ac.jp
Cc: jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zheng tan <tanzheng@kylinos.cn>,
	k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH 5/5] scsi: nsp32: fix spelling typo in comment
Date: Tue,  2 Jan 2024 10:32:09 +0800
Message-Id: <20240102023209.4107281-1-tanzheng@kylinos.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Zheng tan <tanzheng@kylinos.cn>=20

fix spelling typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Zheng tan <tanzheng@kylinos.cn>
---
 drivers/scsi/nsp32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/nsp32.h b/drivers/scsi/nsp32.h
index 924889f8bd37..47993d123a6f 100644
--- a/drivers/scsi/nsp32.h
+++ b/drivers/scsi/nsp32.h
@@ -520,7 +520,7 @@ typedef struct _nsp32_sync_table {
 #define SDTR_TARGET	  BIT(1)    /* sending SDTR from target           */
 #define SDTR_DONE	  BIT(2)    /* exchanging SDTR has been processed */
=20
-/* syncronous period value for nsp32_target.config_max */
+/* synchronous period value for nsp32_target.config_max */
 #define FAST5M			0x32
 #define FAST10M			0x19
 #define ULTRA20M		0x0c
--=20
2.34.1


