Return-Path: <linux-kernel+bounces-21751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8658293C2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237A71F2534F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3578B3E496;
	Wed, 10 Jan 2024 06:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lyq1J+Mu"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D6239FF4;
	Wed, 10 Jan 2024 06:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 77ffbd4eaf8211eea2298b7352fd921d-20240110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=l4NM4WHXvgGHuuOipCUkWTmtju1wQilBTUjr22G5ZXc=;
	b=lyq1J+MuL4VGxOhFMRDfDczKJRGceE4ezVlP09ojBpDnpVwo2SUFzNsfN03r1gXLwvp8XREkKqMwxJ+GvL4DKZOwIGr9rYN+9OcNb0Qntb/kT8CBGM2Xgb4PxwgOLHsUKapzXsj20MqpsjKNiHs7ZGq6clOmzxvhE5bkTNhP6kc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:73cbb27f-3461-4548-96f5-1e5c1b04b6aa,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:5d391d7,CLOUDID:54baaf82-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 77ffbd4eaf8211eea2298b7352fd921d-20240110
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 289910775; Wed, 10 Jan 2024 14:35:38 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 Jan 2024 14:35:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 Jan 2024 14:35:33 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Jason-ch Chen
	<jason-ch.chen@mediatek.com>, Johnson Wang <johnson.wang@mediatek.com>,
	"Jason-JH . Lin" <jason-jh.lin@mediatek.com>, Singo Chang
	<singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>, Shawn Sung
	<shawn.sung@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2 1/4] dt-bindings: mailbox: Add mediatek,gce-props.yaml
Date: Wed, 10 Jan 2024 14:35:29 +0800
Message-ID: <20240110063532.14124-2-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240110063532.14124-1-jason-jh.lin@mediatek.com>
References: <20240110063532.14124-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.118600-8.000000
X-TMASE-MatchedRID: l/nE+SiO7IYdj9vNGYhpke7KTDtx8CggFuNF4lJG6xtnnK6mXN72myxV
	Tnd/2+hkRLNsboQSGqkAQnv84ocXVz95f95FaTdFx9eKAyUg50pbAoaK+wS4jb/tumWFs8JCABh
	pcjjrL9DibhAVW/2FX7dnCNkrUAnNBFvtFhU06+GzI1v7J4hECgrefVId6fzVt2rjS6M+VNkRgq
	CiBaeM80L/0cWZPQ9Rjo9/NbZjvDLQo7lIbG5ppGG7NUiB8AhK5eIYmexVYWNjyv+d0Z0Oxbu9b
	SM2pMfUo+XXdVMhrBMH637f7m1F7EgMxOkBoMP0QpxiLlDD9FWOJZyIAulM00oCplsay+SBo8WM
	kQWv6iVfx6Zf83Do5eTCMddcL/gjOwBXM346/+xNCCFUIgLNRA2IEnyL2YkYCcA2Po60OLvkaoX
	mWZTQJvAB0fNALMoA
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.118600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	628B0BC7F1D1E13276DE3C8EBA7E4AAAD4E305B87DE893A65D89B695D2F1A5582000:8
X-MTK: N

Add mediatek,gce-props.yaml for specific GCE properties for both
Mailbox Providers and Consumers.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 .../bindings/mailbox/mediatek,gce-props.yaml  | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,gce-props.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-props.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-props.yaml
new file mode 100644
index 000000000000..aac776b74e88
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-props.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/mediatek,gce-props.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Global Command Engine common propertes for both Mailbox Providers and Consumers.
+
+maintainers:
+  - Houlong Wei <houlong.wei@mediatek.com>
+
+description:
+  The Global Command Engine (GCE) is used to implement a Command Queue (CMDQ)
+  driver using the Linux Mailbox framework. The GCE is an instruction based,
+  multi-threaded, single-core command dispatcher for MediaTek hardware.
+  We use GCE Mailbox binding to define GCE core properties for GCE Mailbox Provider.
+  A device that uses the CMDQ driver to confige its hardware registers by requesting
+  the Linux Mailbox Channels in the GCE Mailbox Controller is a Mailbox Consumer.
+  This binding defines the common GCE properties for both Mailbox Providers and Consumers.
+
+properties:
+  mediatek,gce-events:
+    description:
+      Each gce-events is an event id corresponding to a specific hardware event
+      signal sent to GCE. The event id is defined in the GCE header
+      include/dt-bindings/gce/<chip>-gce.h of each chips.
+      CMDQ client drivers have two usage of GCE event signals,
+      one is sfotware tokens and the other is hardware events.
+      Software tokens refer to GCE event signals triggered by drivers.
+      e.g. software drivers append GCE commands to set a GCE event after specific
+      GCE commands. Or CMDQ client driver uses the CPU to write the event id
+      into GCE register to trigger the GCE event corresponding to the event id.
+      Hardware events refer to GCE event signals triggered by hardware engines.
+      e.g. When OVL fetches all the data in the frame buffer, OVL will send
+      a frame done irq and send a frame done GCE event via hardware bus directly
+      at the same time.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 1024
+
+additionalProperties: true
-- 
2.18.0


