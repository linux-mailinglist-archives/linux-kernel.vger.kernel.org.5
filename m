Return-Path: <linux-kernel+bounces-13980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC194821673
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 03:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F4EBB212A3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 02:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0290023C3;
	Tue,  2 Jan 2024 02:25:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D7020F8;
	Tue,  2 Jan 2024 02:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2702639705b74b68ae7db21b7a38e136-20240102
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:cfb1ae9d-dce7-4d4a-9e39-7eb0d5557db4,IP:25,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-INFO: VERSION:1.1.35,REQID:cfb1ae9d-dce7-4d4a-9e39-7eb0d5557db4,IP:25,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:20
X-CID-META: VersionHash:5d391d7,CLOUDID:2b23b32e-1ab8-4133-9780-81938111c800,B
	ulkID:240102102455N4DPI6YB,BulkQuantity:0,Recheck:0,SF:66|24|72|19|44|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-UUID: 2702639705b74b68ae7db21b7a38e136-20240102
Received: from node4.com.cn [(39.156.73.12)] by mailgw
	(envelope-from <tanzheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2025099286; Tue, 02 Jan 2024 10:24:53 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 589A316001CD7;
	Tue,  2 Jan 2024 10:24:53 +0800 (CST)
X-ns-mid: postfix-659373F5-169960324
Received: from localhost.localdomain (unknown [172.20.40.222])
	by node4.com.cn (NSMail) with ESMTPA id 8127716001CD7;
	Tue,  2 Jan 2024 02:24:52 +0000 (UTC)
From: zheng tan <tanzheng@kylinos.cn>
To: skashyap@marvell.com,
	jhasan@marvell.com,
	GR-QLogic-Storage-Upstream@marvell.com
Cc: jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zheng tan <tanzheng@kylinos.cn>,
	k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH 4/5] scsi: qedf: fix spelling typo in comment
Date: Tue,  2 Jan 2024 10:24:48 +0800
Message-Id: <20240102022448.3970501-1-tanzheng@kylinos.cn>
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
 drivers/scsi/qedf/qedf_hsi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qedf/qedf_hsi.h b/drivers/scsi/qedf/qedf_hsi.h
index ecd5cb53b750..2df2165e4356 100644
--- a/drivers/scsi/qedf/qedf_hsi.h
+++ b/drivers/scsi/qedf/qedf_hsi.h
@@ -300,7 +300,7 @@ struct fcoe_respqe {
 /* PARAM that is located in the FCP_RSP FC header */
 #define FCOE_RESPQE_PARAM_MASK            0xFFFFFF
 #define FCOE_RESPQE_PARAM_SHIFT           0
-/* Indication whther its Target-auto-rsp mode or not */
+/* Indication wether its Target-auto-rsp mode or not */
 #define FCOE_RESPQE_TARGET_AUTO_RSP_MASK  0xFF
 #define FCOE_RESPQE_TARGET_AUTO_RSP_SHIFT 24
 };
--=20
2.34.1


