Return-Path: <linux-kernel+bounces-36262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D4F839E11
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F081C2268C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FA553B9;
	Wed, 24 Jan 2024 01:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VltTYfW1"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE0515C3;
	Wed, 24 Jan 2024 01:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706058913; cv=none; b=LAygZDVJ6DJbNQkBPwEOo7RKfJW9wsbFREv65oL9GyMJHAm3M1NPzgljv5ysRT4Ejv8iItdHPYq7H7r96V4ObpWLNbC2/aUaDkes115yZfYtbMH6lcpchu3/jypvLASycofACmhdvNIdWTye/rdBACqKQ2OlTWBibSAOcvi6TTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706058913; c=relaxed/simple;
	bh=JdeZPlKEjiLFuIYu403Ub4DRintQoAN0e/US5KhzuOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DRgVlTaQ8pDBCqVA4l79OJfWmR5Cyaqy9jYL7hG52rfXlk1HJX/jbCBSVT9mtZMqbLK2jZOsKRFu+zxKipPRUwyR1T513Gpup8AdaqmC0hJ8Z+928oj0E25BnljBVJL/IBHN1XAgRq9OE4ix3bFtrc+pUrZ+JWtAndgKlwXyQDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VltTYfW1; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 007edd0cba5611eea2298b7352fd921d-20240124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jY25V9ghNP6bd61jv/tFtIQwKG0PgprM4MMtTJO0/9M=;
	b=VltTYfW1n1gnwG0yHWDo8hMamjNxLTuE3pACeUt/5DmX9W1BtKqJk5np2TiEvh/DhzpB2VKj4v1UxzT8Lk6XKL+LLipHPe9Ivm0QfnXjOlaqBIPBXQbMZpo6cbRU8QWs7ibX94/0D2ryaygheKOC+h/SQDBRZukQRgdk+/7KOWE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:bb6cc438-7e20-4c2f-b643-a804101d7f2f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6e16cf4,CLOUDID:2c58958e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 007edd0cba5611eea2298b7352fd921d-20240124
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1884859621; Wed, 24 Jan 2024 09:15:03 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 Jan 2024 09:15:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 24 Jan 2024 09:15:01 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<dri-devel@lists.freedesktop.org>, <linux-media@vger.kernel.org>,
	<linaro-mm-sig@lists.linaro.org>, Jason-ch Chen <jason-ch.chen@mediatek.com>,
	Johnson Wang <johnson.wang@mediatek.com>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, "Nancy
 Lin" <nancy.lin@mediatek.com>, Shawn Sung <shawn.sung@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Fei Shao
	<fshao@chromium.org>
Subject: [PATCH v4 3/3] dt-bindings: soc: mediatek: Change mediatek,gce-events to refernece
Date: Wed, 24 Jan 2024 09:14:59 +0800
Message-ID: <20240124011459.12204-4-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240124011459.12204-1-jason-jh.lin@mediatek.com>
References: <20240124011459.12204-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.790600-8.000000
X-TMASE-MatchedRID: aM1oCRdK49EMiTNbd7AZSQPZZctd3P4BK2i9pofGVSsCsxyhR8y7CSks
	jJeAae2ufhI10pDdSP7QVGKORWAoMGF/gGkQ6asW6/xAZojbl7cP4vBWNr0zgZsoi2XrUn/J8m+
	hzBStanuKNyKr3HDyRVgXepbcl7r7c9dBRqd2oZqdyRtt2G3UGEkKSKbZ9hn3+2Ue2XythBWzqT
	iktjuYHOATQC+C5DxwHppUPPd3QHIsk7D0F7HbwZwbAlgRrbfpgITnGkK0NFNRskXKHhdfKpij9
	M86UwHhsKHfMTjCprzAgTvs8QFuaX7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.790600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	DA2C902CD1BF65E2707E1D1AA58B11103764CD002F061AD63A7F2A6C02519CD22000:8
X-MTK: N

Change mediatek,gce-events property to reference mediatek,gce-props.yaml
instead of defining itself.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/soc/mediatek/mediatek,ccorr.yaml        | 12 ++++--------
 .../bindings/soc/mediatek/mediatek,mutex.yaml        | 11 +++--------
 .../bindings/soc/mediatek/mediatek,wdma.yaml         | 12 ++++--------
 3 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
index 4380b98b0dfe..305f2cd9f865 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
@@ -34,13 +34,6 @@ properties:
       4 arguments defined in this property. Each GCE subsys id is mapping to
       a client defined in the header include/dt-bindings/gce/<chip>-gce.h.
 
-  mediatek,gce-events:
-    description:
-      The event id which is mapping to the specific hardware event signal
-      to gce. The event id is defined in the gce header
-      include/dt-bindings/gce/<chip>-gce.h of each chips.
-    $ref: /schemas/types.yaml#/definitions/uint32-array
-
   clocks:
     minItems: 1
 
@@ -51,7 +44,10 @@ required:
   - mediatek,gce-events
   - clocks
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/mailbox/mediatek,gce-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
index ba2014a8725c..61cf16ce8b0b 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
@@ -53,13 +53,6 @@ properties:
     items:
       - description: MUTEX Clock
 
-  mediatek,gce-events:
-    description:
-      The event id which is mapping to the specific hardware event signal
-      to gce. The event id is defined in the gce header
-      include/dt-bindings/gce/<chip>-gce.h of each chips.
-    $ref: /schemas/types.yaml#/definitions/uint32-array
-
   mediatek,gce-client-reg:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
@@ -73,6 +66,8 @@ properties:
       a client defined in the header include/dt-bindings/gce/<chip>-gce.h.
 
 allOf:
+  - $ref: /schemas/mailbox/mediatek,gce-props.yaml#
+
   - if:
       properties:
         compatible:
@@ -97,7 +92,7 @@ required:
   - interrupts
   - power-domains
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
index 69afb329e5f4..d9dd4428c036 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
@@ -35,13 +35,6 @@ properties:
       4 arguments defined in this property. Each GCE subsys id is mapping to
       a client defined in the header include/dt-bindings/gce/<chip>-gce.h.
 
-  mediatek,gce-events:
-    description:
-      The event id which is mapping to the specific hardware event signal
-      to gce. The event id is defined in the gce header
-      include/dt-bindings/gce/<chip>-gce.h of each chips.
-    $ref: /schemas/types.yaml#/definitions/uint32-array
-
   power-domains:
     maxItems: 1
 
@@ -60,7 +53,10 @@ required:
   - clocks
   - iommus
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/mailbox/mediatek,gce-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.18.0


