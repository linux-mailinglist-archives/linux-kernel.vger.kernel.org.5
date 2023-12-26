Return-Path: <linux-kernel+bounces-11465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F28E581E6BF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE41E28312F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F82E4D58B;
	Tue, 26 Dec 2023 09:58:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523A54D133;
	Tue, 26 Dec 2023 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6c4deba695604a0e99eafb52b5725d95-20231226
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:580ffc04-c4f4-499e-b578-3fe4318405e1,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.35,REQID:580ffc04-c4f4-499e-b578-3fe4318405e1,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:c68e958d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:231226175732QO6M93J7,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
	TF_CID_SPAM_FSI
X-UUID: 6c4deba695604a0e99eafb52b5725d95-20231226
Received: from node4.com.cn [(39.156.73.12)] by mailgw
	(envelope-from <liyouhong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 657365931; Tue, 26 Dec 2023 17:57:30 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id C95C716001CD6;
	Tue, 26 Dec 2023 17:57:29 +0800 (CST)
X-ns-mid: postfix-658AA389-675146153
Received: from localhost.localdomain (unknown [172.20.185.164])
	by node4.com.cn (NSMail) with ESMTPA id 31A6616001CD6;
	Tue, 26 Dec 2023 09:57:29 +0000 (UTC)
From: YouHong Li <liyouhong@kylinos.cn>
To: jgross@suse.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liyouhong <liyouhong@kylinos.cn>,
	k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH v2] drivers/block/xen-blkback/common.h: Fix spelling typo in comment
Date: Tue, 26 Dec 2023 17:57:01 +0800
Message-Id: <20231226095701.172080-1-liyouhong@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: liyouhong <liyouhong@kylinos.cn>

Fix spelling typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: liyouhong <liyouhong@kylinos.cn>

---
v1->v2:
	*keep the "*/" aligned with the ones above and below.
---
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkba=
ck/common.h
index a3eeccf3ac5f..3296a6ec8d75 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -133,7 +133,7 @@ struct blkif_x86_32_request {
 struct blkif_x86_64_request_rw {
 	uint8_t        nr_segments;  /* number of segments                   */
 	blkif_vdev_t   handle;       /* only for read/write requests         */
-	uint32_t       _pad1;        /* offsetof(blkif_reqest..,u.rw.id)=3D=3D8=
  */
+	uint32_t       _pad1;        /* offsetof(blkif_request..,u.rw.id)=3D=3D=
8 */
 	uint64_t       id;
 	blkif_sector_t sector_number;/* start sector idx on disk (r/w only)  */
 	struct blkif_request_segment seg[BLKIF_MAX_SEGMENTS_PER_REQUEST];
--=20
2.34.1


