Return-Path: <linux-kernel+bounces-7807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C54A681AD7B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD961C22490
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742CE63D5;
	Thu, 21 Dec 2023 03:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="F5RWXqHP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA604C64;
	Thu, 21 Dec 2023 03:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c7d0b8c89fb011eeba30773df0976c77-20231221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=qlh/VbDYXlXEU1JaXc715148R0jpddLs+ZhwUrdEA90=;
	b=F5RWXqHPPTCwYDeM+Zckon9CTQAHP5hBqWehQOEoNSgOYogk8NQyQmBOGY8G2n6A9J67oAMM5+fW04FcKAjjXzHsIH/XNv85ENYea1vWUkO6gHze/aXIjYOc0qQbb/VQUpH9JXiNScjFx+4ohb/TRvw6ni6hLkfCos4TE4Rk0zY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:0cb7be99-254d-456c-9198-ace6eb0f5d96,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:3b18688d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c7d0b8c89fb011eeba30773df0976c77-20231221
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <chui-hao.chiu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1023971889; Thu, 21 Dec 2023 11:26:51 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 21 Dec 2023 11:26:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 21 Dec 2023 11:26:49 +0800
From: Peter Chiu <chui-hao.chiu@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <linux-wireless@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH v4] dt-bindings: net: wireless: mt76: add interrupts description for MT7986
Date: Thu, 21 Dec 2023 11:26:48 +0800
Message-ID: <20231221032648.641-1-chui-hao.chiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

The mt7986 can support four interrupts to distribute the interrupts
to different CPUs.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
---
v2: Change to use description instead of using items.
v3: Change to use items and set different minItems for mediatek,mt7986-wmac
v4: Move allOf after required and remove duplicated blank line.
---
 .../bindings/net/wireless/mediatek,mt76.yaml  | 32 ++++++++++++++++---
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
index 252207adbc54..0c6835db397f 100644
--- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
@@ -19,9 +19,6 @@ description: |
   Alternatively, it can specify the wireless part of the MT7628/MT7688
   or MT7622/MT7986 SoC.
 
-allOf:
-  - $ref: ieee80211.yaml#
-
 properties:
   compatible:
     enum:
@@ -38,7 +35,12 @@ properties:
       MT7986 should contain 3 regions consys, dcm, and sku, in this order.
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: major interrupt for rings
+      - description: additional interrupt for ring 19
+      - description: additional interrupt for ring 4
+      - description: additional interrupt for ring 5
 
   power-domains:
     maxItems: 1
@@ -217,6 +219,23 @@ required:
   - compatible
   - reg
 
+allOf:
+  - $ref: ieee80211.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt7986-wmac
+    then:
+      properties:
+        interrupts:
+          minItems: 4
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+
 unevaluatedProperties: false
 
 examples:
@@ -293,7 +312,10 @@ examples:
         reg = <0x18000000 0x1000000>,
               <0x10003000 0x1000>,
               <0x11d10000 0x1000>;
-        interrupts = <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>;
+        interrupts = <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
         clocks = <&topckgen 50>,
                  <&topckgen 62>;
         clock-names = "mcu", "ap2conn";
-- 
2.18.0


