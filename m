Return-Path: <linux-kernel+bounces-109545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4C3881AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F24C1C20F08
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1154A1D;
	Thu, 21 Mar 2024 01:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DIUPw6kT"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D341C17;
	Thu, 21 Mar 2024 01:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710985689; cv=none; b=iycV0Lsf/RnaCY3PdeekPjzdxmlxGMUncGTg9Dvpt2g82OwBgV2r7SofvEXPpntzjsdQKx1BnvQis+WCXB/0PLPJN0QhP4n3y+nC4C9SZDVUGV7FpLbLvhG5KbZgf2vbA+LNrsAZxRQcfrBxwAss6KrYLR/Xii4WjzpHssw6qJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710985689; c=relaxed/simple;
	bh=2cvA/ledniTMPmnNcBlR6zvTS86Z3KqolPgDFhB6OD4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G8Rhwk11uZBiKhBw/L6fJEUWj+zkciqehcBwCpNjVJ8WDi0uZ2z3MbCL9qpR0t6YAA9N2OhaNAzif9pu8kJVwKn8bEWMQr+6iyZScy38T45yV5Vlji5N6Ag4x8cgCnHRViAuTOUEk3XmkStqQbW49CHF7MN5OasXYEkouCt6Xcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DIUPw6kT; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0b7e7590e72511eeb8927bc1f75efef4-20240321
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=dEJZ0X1McOPizF7jgy7/EKKAk82UfoRmWloVvTbNFTk=;
	b=DIUPw6kTIba+q9ODt3PDHGkTQ5zpWu0UGc1iiO0y87TghYNUqHjqYJS5RZttyExewN9mwzgxUU+onYNISlIXb8UF4bG/57GQP50Tpa7cTXmP0IE4lyRwq4gQyj7ISTaJOcLIYvCauFXi6Y6sqDYsUG3bQEmQ0oySOTSr71xMTzw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:029fa9cc-5672-4a2b-9ece-1127b226042b,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:be9f3e85-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 0b7e7590e72511eeb8927bc1f75efef4-20240321
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <irui.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1963483388; Thu, 21 Mar 2024 09:47:58 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 21 Mar 2024 09:47:56 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 21 Mar 2024 09:47:55 +0800
From: Irui Wang <irui.wang@mediatek.com>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Yunfei Dong
	<yunfei.dong@mediatek.com>, <angelogioacchino.delregno@collabora.com>,
	<nicolas.dufresne@collabora.com>, <sebastian.fricke@collabora.com>
CC: Longfei Wang <longfei.wang@mediatek.com>, Maoguang Meng
	<maoguang.meng@mediatek.com>, Irui Wang <irui.wang@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2] media: mediatek: vcodec: Handle invalid decoder vsi
Date: Thu, 21 Mar 2024 09:47:54 +0800
Message-ID: <20240321014754.6540-1-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.032200-8.000000
X-TMASE-MatchedRID: vl5QM0vd8N2rSedjouq7Z7MjW/sniEQKMZm0+sEE9mv7efdnqtsaE7x1
	VMA+w2Qu/mRejmnKqNv182FRWwrycVxxDx5qbkR9FEUknJ/kEl7dB/CxWTRRuwihQpoXbuXFgfV
	e2TOg2R0Kzm808vZggmNkwsaDLShPAZFwQlvysNQPhbT9/Y4bTXE4Dm8YPvFzQapnAAOBflb/DA
	3T/JDd9AtMf/rFuFCcaaeeX2Q5bK9+HGPweyal2mGdUezV59DHQZpgl3CshRSeqD9WtJkSIw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.032200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	9001B387118349F518ECCC3A1D208436A392DE5B2B2515818146CE89C0D88BDC2000:8
X-MTK: N

Handle invalid decoder vsi in vpu_dec_init to ensure the decoder vsi is
valid for future use.

Fixes: 590577a4e525 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video Decoder Driver")

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
changed with v1:
 - add Fixes tag
---
 .../media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c    | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
index 82e57ae983d5..17770993fe5a 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
@@ -231,6 +231,12 @@ int vpu_dec_init(struct vdec_vpu_inst *vpu)
 	mtk_vdec_debug(vpu->ctx, "vdec_inst=%p", vpu);
 
 	err = vcodec_vpu_send_msg(vpu, (void *)&msg, sizeof(msg));
+
+	if (IS_ERR_OR_NULL(vpu->vsi)) {
+		mtk_vdec_err(vpu->ctx, "invalid vdec vsi, status=%d", err);
+		return -EINVAL;
+	}
+
 	mtk_vdec_debug(vpu->ctx, "- ret=%d", err);
 	return err;
 }
-- 
2.18.0


