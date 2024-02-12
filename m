Return-Path: <linux-kernel+bounces-62139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90424851C25
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FDD2B2963D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8954C405F8;
	Mon, 12 Feb 2024 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="hrcfe0jQ"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149F146420;
	Mon, 12 Feb 2024 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760301; cv=none; b=JJ5JSOlG2wJw4XK93PGBkYZ9Yw/IMt26RcEAMb1z6tIiDO9Xt0N+RylReLGuXYjiG/RttPOe1Zj8D9f4pgX3Vk8DRImLYFuBCPhVN3ajRqLWXSbfVMSa06OTEqmvbp2whZk3fKFLe3NUmGRNT29i/LW2n4Zw+Ox0gK0tG9iLUAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760301; c=relaxed/simple;
	bh=SUp82WtXCPkv/U7G1G6anjiZg2kxGqB+XlCK+OQw44Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWOVI4i/8vTETo1TBZ8tRfCT/9KPmRuwXNkNdtAga+29+fqYsQHJccHXqxcz5MAWozmPsyQsqCJ2ZmwugSMThKUyFBxIHyM12L/9VQqzP1Uw3G8THysBKiCdQTrLhKP+sLfyZQn83eqtu/ZPv7W2GGi/Q2PKhwONb55ogeD2oIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=hrcfe0jQ; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CDLYd1017013;
	Mon, 12 Feb 2024 18:51:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=gGmqZUUYdxZJD5cJg3PaUW7eiTzp+8uxvs/xF3DyUoU=; b=hr
	cfe0jQdi0LwwQRCZSL04+9skNSXiCngGyEwok+/S0OEs+ixzIInuERxFZ6Qk5rmh
	NK1aswqaKD2xCvjhK7TLlb6lv/w+84bisVlJ5SMqaIArmb53jQ3ZgmsRdBb0TgPg
	mGpEn94QjchQg5LIMLhJwbmIxqiMhqjcu7Puk0iDC8Sw21ToTlTQy9bvsnLNgCA3
	AeM4U8n2vRv1if7B3uFVV8iSmZHh6AuNJr1GUIGm8Sb5pxURSOXSFo5u78y3ltht
	jJhneNhAlClZj7Y6cPIu+6lOmiqogZXhd8dx31MTr1JnyLBGhPOQJ6y+scF0e7Gw
	0FOdycZtXV9N4DZgjAnw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w62js7pwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 18:51:26 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E851B40045;
	Mon, 12 Feb 2024 18:51:22 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4C6B327F266;
	Mon, 12 Feb 2024 18:50:37 +0100 (CET)
Received: from localhost (10.201.22.200) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 12 Feb
 2024 18:50:37 +0100
From: Christophe Kerello <christophe.kerello@foss.st.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH 08/12] dt-bindings: mtd: st,stm32: add MP25 support
Date: Mon, 12 Feb 2024 18:48:18 +0100
Message-ID: <20240212174822.77734-9-christophe.kerello@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240212174822.77734-1-christophe.kerello@foss.st.com>
References: <20240212174822.77734-1-christophe.kerello@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_15,2024-02-12_03,2023-05-22_02

Add 2 new compatible strings to support MP25 SOC.
MP25 SOC supports up to 4 chip select.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
---
 .../bindings/mtd/st,stm32-fmc2-nand.yaml      | 58 ++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml b/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
index e72cb5bacaf0..33a753c8877b 100644
--- a/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
@@ -14,10 +14,12 @@ properties:
     enum:
       - st,stm32mp15-fmc2
       - st,stm32mp1-fmc2-nfc
+      - st,stm32mp25-fmc2
+      - st,stm32mp25-fmc2-nfc
 
   reg:
     minItems: 6
-    maxItems: 7
+    maxItems: 13
 
   interrupts:
     maxItems: 1
@@ -92,6 +94,60 @@ allOf:
             - description: Chip select 1 command
             - description: Chip select 1 address space
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: st,stm32mp25-fmc2
+    then:
+      properties:
+        reg:
+          items:
+            - description: Registers
+            - description: Chip select 0 data
+            - description: Chip select 0 command
+            - description: Chip select 0 address space
+            - description: Chip select 1 data
+            - description: Chip select 1 command
+            - description: Chip select 1 address space
+            - description: Chip select 2 data
+            - description: Chip select 2 command
+            - description: Chip select 2 address space
+            - description: Chip select 3 data
+            - description: Chip select 3 command
+            - description: Chip select 3 address space
+
+        clocks:
+          maxItems: 1
+
+        resets:
+          maxItems: 1
+
+      required:
+        - clocks
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: st,stm32mp25-fmc2-nfc
+    then:
+      properties:
+        reg:
+          items:
+            - description: Chip select 0 data
+            - description: Chip select 0 command
+            - description: Chip select 0 address space
+            - description: Chip select 1 data
+            - description: Chip select 1 command
+            - description: Chip select 1 address space
+            - description: Chip select 2 data
+            - description: Chip select 2 command
+            - description: Chip select 2 address space
+            - description: Chip select 3 data
+            - description: Chip select 3 command
+            - description: Chip select 3 address space
+
 required:
   - compatible
   - reg
-- 
2.25.1


