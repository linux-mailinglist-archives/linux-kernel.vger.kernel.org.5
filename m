Return-Path: <linux-kernel+bounces-19049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C94826736
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 02:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727D91C217E4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 01:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F256A7497;
	Mon,  8 Jan 2024 01:56:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AD36119
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 01:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 781fe7b1ea8d4441a2389ee0ceefbce3-20240108
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:8f87dd18-c74c-44fb-b42b-672a2cbfa6a4,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.1.35,REQID:8f87dd18-c74c-44fb-b42b-672a2cbfa6a4,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:5d391d7,CLOUDID:f4c8167f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:2401080956160OKR5O9P,BulkQuantity:0,Recheck:0,SF:44|66|24|72|19|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 781fe7b1ea8d4441a2389ee0ceefbce3-20240108
X-User: zhangyongzhen@kylinos.cn
Received: from localhost.localdomain [(39.156.73.13)] by mailgw
	(envelope-from <zhangyongzhen@kylinos.cn>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 791975846; Mon, 08 Jan 2024 09:56:14 +0800
From: Yongzhen Zhang <zhangyongzhen@kylinos.cn>
To: joseph.qi@linux.alibaba.com
Cc: jlbec@evilplan.org,
	linux-kernel@vger.kernel.org,
	mark@fasheh.com,
	ocfs2-devel@lists.linux.dev,
	zhangyongzhen@kylinos.cn
Subject: [PATCH v2] ocfs2: Spelling fix
Date: Mon,  8 Jan 2024 09:56:04 +0800
Message-Id: <20240108015604.38377-1-zhangyongzhen@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <64d54843-4e25-4777-b324-dff105da705b@linux.alibaba.com>
References: <64d54843-4e25-4777-b324-dff105da705b@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify reques to request in the comment

Signed-off-by: Yongzhen Zhang <zhangyongzhen@kylinos.cn>
---
 fs/ocfs2/dlmglue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 64a6ef638495..cb40cafbc062 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -1615,7 +1615,7 @@ static int __ocfs2_cluster_lock(struct ocfs2_super *osb,
 unlock:
 	lockres_clear_flags(lockres, OCFS2_LOCK_UPCONVERT_FINISHING);
 
-	/* ocfs2_unblock_lock reques on seeing OCFS2_LOCK_UPCONVERT_FINISHING */
+	/* ocfs2_unblock_lock request on seeing OCFS2_LOCK_UPCONVERT_FINISHING */
 	kick_dc = (lockres->l_flags & OCFS2_LOCK_BLOCKED);
 
 	spin_unlock_irqrestore(&lockres->l_lock, flags);
-- 
2.34.1


