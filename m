Return-Path: <linux-kernel+bounces-129105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B10F896513
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934AC283D85
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEA95A4CD;
	Wed,  3 Apr 2024 06:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SaGRsBq9"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110BE535D4;
	Wed,  3 Apr 2024 06:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712127375; cv=none; b=UjWCdaO1kf7C/x/Ts7FO0dh6qCnVQ9NV8BE3j1W7GOd/tsannOOLqCkzOpAh4wYT5x+NrPP1qWTGbhqkuJ4EqauNRP/oQiSFEvOjzewAhr10FZE5Rra3EmwFKi/gTytg/uH2QwXNy0uPIdlnUpO6y34PKt+LjJU199GwoQvOQZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712127375; c=relaxed/simple;
	bh=4UwcMPPDzRH26gb2m2qKXKP0UIaao+ObEIVLwtRJRT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jfNx2/xZDQ0xhOJ9xMc53Qj8saHjnYk/smpYMkILM+Ab28DKc0gkb7caBX/mvfMvC4H4+TLW+B8hDjibG1b/Nf3kGXtSqNXg1YyvFxocNh66C+4LwsgDcuiyFZcOK3u51vSEDM2Pre7ijfDdOHAicMAq5HA/j+5UOzweTkpacxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SaGRsBq9; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3f9da9ecf18711ee935d6952f98a51a9-20240403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=J7GVq50e/cnKmwr692qLbeiX3iiulaSkExJyOfZxnCM=;
	b=SaGRsBq950yngdO4gGvON9GcMbmo+v75fVSAWkl5L05pCyocK4De2Eki69AP8MZ02M82COdXvshuLzkznbUmX67ikF8XA/RryT9ybBzWI09F4L2eOWNkPCc4Z7wIR24wQgReenWHXZrk/rjTkarcj8nHdbGGYu1yNpIhNcS3fKg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:60002dbc-5824-42ff-944c-3c91816aab6a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:c90f2a91-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3f9da9ecf18711ee935d6952f98a51a9-20240403
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1942880279; Wed, 03 Apr 2024 14:56:08 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Apr 2024 14:56:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 Apr 2024 14:56:05 +0800
From: Shawn Sung <shawn.sung@mediatek.com>
To: CK Hu <ck.hu@mediatek.com>, Jassi Brar <jassisinghbrar@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, Hsiao Chien Sung
	<shawn.sung@mediatek.com>, "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
	Houlong Wei <houlong.wei@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH v4 1/9] dt-bindings: gce: mt8195: Add CMDQ_SYNC_TOKEN_SECURE_THR_EOF event id
Date: Wed, 3 Apr 2024 14:55:55 +0800
Message-ID: <20240403065603.21920-2-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240403065603.21920-1-shawn.sung@mediatek.com>
References: <20240403065603.21920-1-shawn.sung@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.865800-8.000000
X-TMASE-MatchedRID: MfleD8Y7obJ/Kgj3tMS/EPyAR9DgC/hHDqdsP48ZEpT1gF7PCEF9bjFa
	TRf5dTetd1cwAoVwUpIm83mw8YvWBKF2E6v/FJwhB7TqRAYVohYrHkgIan9a0fzaSz3Z/4aaP6C
	wLhrNSrC58Ekbt0Wd7Np5CTaON5EqmWDI8lRCplAD2WXLXdz+AZl/lu28zzkBDnmf9WY7ZBKjxY
	yRBa/qJcFwgTvxipFajoczmuoPCq0tuL2EWbPwWzqlZ78my/54WyVeiFiE5JFlmoAELIG8LTNdw
	sfnupvQQwymtxuJ6y0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.865800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	5716AA618B8E33AD16CAEFBE32D6EA598C972FA52D2CD2C068F261F013F33D9C2000:8
X-MTK: N

From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>

There are 2 kind of GCE event signal:
- The SW token means: a GCE event signal triggered by SW drivers.
e.g. SW driver append a GCE command to set a GCE event after a specific
GCE command. Or SW driver use CPU to write a event id to GCE register to
trigger the GCE event corresponding to that event id.

- The HW event means: a GCE event signal triggered by HW engines.
e.g. When HW OVL fetches all the data in frame buffer, HW OVL will send
a frame done irq and also send a frame done GCE event via HW bus directly.

CMDQ_SYNC_TOKEN_SECURE_THR_EOF is a SW token event that is set in the
end of each cmdq secure pkt. It is used as a secure irq to notify
CMDQ driver in the normal world that GCE secure thread has completed
a secure cmd buffer in thee secure world.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 include/dt-bindings/gce/mt8195-gce.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/dt-bindings/gce/mt8195-gce.h b/include/dt-bindings/gce/mt8195-gce.h
index dcfb302b8a5bc..b6b3db82c381e 100644
--- a/include/dt-bindings/gce/mt8195-gce.h
+++ b/include/dt-bindings/gce/mt8195-gce.h
@@ -800,6 +800,12 @@
 #define CMDQ_EVENT_WPE_VPP1_WPE_GCE_FRAME_DONE	969
 #define CMDQ_EVENT_WPE_VPP1_WPE_DONE_SYNC_OUT	970
 
+/*
+ * Notify normal CMDQ there are some secure task done,
+ * this token sync with secure world.
+ */
+#define CMDQ_SYNC_TOKEN_SECURE_THR_EOF			980
+
 #define CMDQ_EVENT_DP_TX_VBLANK_FALLING	994
 #define CMDQ_EVENT_DP_TX_VSC_FINISH	995
 
-- 
2.18.0


