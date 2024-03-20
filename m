Return-Path: <linux-kernel+bounces-108484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F2B880B17
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41AD82839CC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2273D182A1;
	Wed, 20 Mar 2024 06:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lVHSsUZ3"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72C11DA4D;
	Wed, 20 Mar 2024 06:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710915230; cv=none; b=q/VlACLnfyELSUDG3i5coUYqajprgVxnffLxMlc4HSMyRcjoI5faK00oW282eO8WYeIChJj4taRzge6iCmIZuJbKDuOxjt2Hl/Vyf1/NBK1IAEqJNZ1d8uTvij2LOHShJmyoruovx5NMfoMKAiY6+2smsGEN0zad9CPXdCC8Qjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710915230; c=relaxed/simple;
	bh=t1LNVcM3aaCZqfjv0hwEZ81ouLW2veDDXJvd/KDBq/0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W7z88DYo6q7bjV4gD9mJu5XcgBvVhWC5/Lf9wrxlbwHL/yjJ2EJbERGMzXSlK2nX2Et256bzRZIRFWaEXnNGLhk8CRP15uyasufSHZDjfV/qT/7qxFayOfCjlZQcldG9pvSftLp8SwsxZsOGIeOkQjVVc7eSofGARkVVhuSnWa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=lVHSsUZ3; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ffd89544e68011eeb8927bc1f75efef4-20240320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=C/x5ZEPwF9HzG+0ysOsNMQvXNqur3Ncn/FhZ9KulUQ4=;
	b=lVHSsUZ3/78y68PeK7mTFcWc+jjoCJklWpt1mLlcAkiRoZgOhH9+ToY6Q86mnsEx+eIvMPLxBPYgn66/q+lR14bA5IzpDQ10NggjzojuwIOF7DBNWHt6vwcErTEY0KiBkgGAjDT1Jh/u2hGkOyUAFJ7lUL2LTcZnEQAQvQIz1Iw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:0c20c6eb-3c5b-4f3d-b299-a52996961ba9,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:1b8fb581-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: ffd89544e68011eeb8927bc1f75efef4-20240320
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <irui.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1729256188; Wed, 20 Mar 2024 14:13:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Mar 2024 14:13:39 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Mar 2024 14:13:38 +0800
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
Subject: [PATCH] media: mediatek: vcodec: Handle invalid decoder vsi
Date: Wed, 20 Mar 2024 14:13:36 +0800
Message-ID: <20240320061336.2615-1-irui.wang@mediatek.com>
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
X-TM-AS-Result: No-10--2.832200-8.000000
X-TMASE-MatchedRID: nNgqr+SeSsSrSedjouq7Z7MjW/sniEQK+Vb3woyMZbuU8ftiyKjZrRKD
	eJ94PUa2cspcFewXO92AMuqetGVetv1UB9A6pTKC3QfwsVk0UbsIoUKaF27lxVOb0brJ+/6rvkS
	GjzkB1uo1yZqscazcVC2u/uqEQ+30NPT6X9pzQIunTH3K2EqYY3j6YUn1Dqif7TmFv0QF0kyTES
	cYd8gA2mmnnl9kOWyvfhxj8HsmpdphnVHs1efQx0GaYJdwrIUUnqg/VrSZEiM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.832200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 26B1BC9D6BAFBFA7FE3DF0EA3DC0BBCEE827FEFEE317F6209CECF52A10B9F6542000:8
X-MTK: N

Handle invalid decoder vsi in vpu_dec_init to ensure the decoder vsi is
valid for future use.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
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


