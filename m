Return-Path: <linux-kernel+bounces-129537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5AE896C42
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05211F2894C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE89813BAD6;
	Wed,  3 Apr 2024 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="h5T69hrD"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3BE1386DC;
	Wed,  3 Apr 2024 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139977; cv=none; b=ncVG1jQ3bF/t7oF7pai8hoDFdr44Z6TtftO2aWqX70Ee1XAVLJEcwiUJVcAEq8i073neJnk/tQlHPL66ncWb/ro/OPE7ycODwbORM2mIhmInbzX7HuGZOkM5JV6z51JAezW0Ejtv0gMCmn0MqnF7d7BRkEamb9OvOGu7c1y/00A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139977; c=relaxed/simple;
	bh=4UwcMPPDzRH26gb2m2qKXKP0UIaao+ObEIVLwtRJRT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTHCZJYcMBtfEJzalNnOgS9e2p2DxhUr5p9+QYj3zV9y+GP/J365goxSR+NVHJo5bzt2oELjcq0rws3BVT+3/CsS1rxXsmTQHjfCrVCopIExitDR2q/bFPA5VotITkyKwk4bYUV402MNOswCsS03UT/jueTc6AUk/IZKPgCq6t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=h5T69hrD; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 93ee5a24f1a411ee935d6952f98a51a9-20240403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=J7GVq50e/cnKmwr692qLbeiX3iiulaSkExJyOfZxnCM=;
	b=h5T69hrDKuOx1ndVIcqdvRGS6OxfKzmcmmpV5SKq29tONwqxEB5a8ziy+rDTkODQtGjXOa6lK/OwH5P93jnXD0hJVZgXeYiqeyZ1Un60HvV21CPR8fQrKLP59C9HkLIBmzaTSVJRCsgea5xwpQYc36SIy5UDXWk8Fvk6ZjVLqu4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:cbe4ce9c-fc09-4eeb-813f-d8872a1acbee,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:7c6faa00-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 93ee5a24f1a411ee935d6952f98a51a9-20240403
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1466533684; Wed, 03 Apr 2024 18:26:05 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Apr 2024 18:26:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 Apr 2024 18:26:04 +0800
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
Subject: [PATCH v5 01/10] dt-bindings: gce: mt8195: Add CMDQ_SYNC_TOKEN_SECURE_THR_EOF event id
Date: Wed, 3 Apr 2024 18:25:53 +0800
Message-ID: <20240403102602.32155-2-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240403102602.32155-1-shawn.sung@mediatek.com>
References: <20240403102602.32155-1-shawn.sung@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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


