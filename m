Return-Path: <linux-kernel+bounces-140664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC2A8A1779
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB8C1C20E16
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA8AFBEF;
	Thu, 11 Apr 2024 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="6RYrOvsA"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D741314A8C;
	Thu, 11 Apr 2024 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846342; cv=none; b=jjyribWN077NRBAglklsHwK1fmmw2JdiXCt0VG09+0g+3JZctjEx1mLHfao0BXbfFsPtNUy8FtZvdBnoBauYjlAbM/HSJMNZzEkXJDMxX3GokMzuHuHCRoEh0K3V8mNyhR7jMmjiNNfwzOrELmTaPyv9qi1UzxDc85e9SpPM0JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846342; c=relaxed/simple;
	bh=ZU0KvSwWhAqlOsS1Jel23LclvxlY6tZAOvDV8FDTb1Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWcJ34PribEkDi5bbfOB9/smYtlC+ldhw1n2cSaH1r8pn2xW1F8CbqEjCLEKAvTCgjhpyaP6CLgJT2+DGrMuULaZX3/aDkNJTJviq+GnYjHNZ6XL1MGtzHB37RO6h3sc71ptSqbggOSo11sIKQuhoUkI0zY1V9rOC7dUpwirusw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=6RYrOvsA; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43B8nFV0029043;
	Thu, 11 Apr 2024 16:38:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=pdiOg0qMVK3K8F6mkd9yI3FRY3kP3X2qeN1i6q/LFAs=; b=6R
	YrOvsA8Cfo7AMuhHFFuZUxg4zvvvrIFz2P5I1DfVUpZwhq8VHwmJGSmI7ehstsP7
	DREk6dLHmWJ23xTRbZ571qdwrB46tGvpFUX9xrSjZ39knWWgx4iLuKUPUKVKda8s
	pqbIj/3fx9ETV0p5twbAR91kcAxxvtxPLUwdTfhlzSMuJvBp5vM15lY9Dti0bQLg
	3jwt1wJHtKLxTW1H9KfVfCdsQpmP5WXkvP+qflgGkOSPS4nbMh70C6oUwjAb4A16
	LbbxlgYujgZ7nLEvK0X2E6IkdZCjjveHplsuy7+DVp0qHscYfprkQjY4oO/1yBnE
	aCgWVdOrCfd/hfrYpMaQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xawqy5ds5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 16:38:35 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 64D8A40045;
	Thu, 11 Apr 2024 16:38:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 892C4216821;
	Thu, 11 Apr 2024 16:37:22 +0200 (CEST)
Received: from localhost (10.48.86.106) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 11 Apr
 2024 16:37:22 +0200
From: Christophe Roullier <christophe.roullier@foss.st.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/11] dt-bindings: net: add STM32MP13 compatible in documentation for stm32
Date: Thu, 11 Apr 2024 16:36:48 +0200
Message-ID: <20240411143658.1049706-2-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240411143658.1049706-1-christophe.roullier@foss.st.com>
References: <20240411143658.1049706-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_08,2024-04-09_01,2023-05-22_02

New STM32 SOC have 2 GMACs instances.
GMAC IP version is SNPS 4.20.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 .../devicetree/bindings/net/stm32-dwmac.yaml  | 80 +++++++++++++++++--
 1 file changed, 72 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
index 857d58949b029..20f58eff6e6f9 100644
--- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
@@ -22,18 +22,17 @@ select:
         enum:
           - st,stm32-dwmac
           - st,stm32mp1-dwmac
+          - st,stm32mp13-dwmac
   required:
     - compatible
 
-allOf:
-  - $ref: snps,dwmac.yaml#
-
 properties:
   compatible:
     oneOf:
       - items:
           - enum:
               - st,stm32mp1-dwmac
+              - st,stm32mp13-dwmac
           - const: snps,dwmac-4.20a
       - items:
           - enum:
@@ -74,13 +73,16 @@ properties:
 
   st,syscon:
     $ref: /schemas/types.yaml#/definitions/phandle-array
-    items:
-      - items:
-          - description: phandle to the syscon node which encompases the glue register
-          - description: offset of the control register
     description:
       Should be phandle/offset pair. The phandle to the syscon node which
-      encompases the glue register, and the offset of the control register
+      encompases the glue register, the offset of the control register and
+      the mask to set bitfield in control register
+    items:
+      minItems: 2
+      items:
+        - description: phandle to the syscon node which encompases the glue register
+        - description: offset of the control register
+        - description: field to set mask in register
 
   st,ext-phyclk:
     description:
@@ -108,6 +110,34 @@ required:
 
 unevaluatedProperties: false
 
+allOf:
+  - $ref: snps,dwmac.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - st,stm32mp1-dwmac
+              - st,stm32-dwmac
+    then:
+      properties:
+        st,syscon:
+          items:
+            minItems: 2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - st,stm32mp13-dwmac
+    then:
+      properties:
+        st,syscon:
+          items:
+            minItems: 3
+
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -168,3 +198,37 @@ examples:
            snps,pbl = <8>;
            phy-mode = "mii";
        };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/stm32mp1-clks.h>
+    #include <dt-bindings/reset/stm32mp1-resets.h>
+    #include <dt-bindings/mfd/stm32h7-rcc.h>
+    //Example 4
+     ethernet3: ethernet@5800a000 {
+           compatible = "st,stm32mp13-dwmac", "snps,dwmac-4.20a";
+           reg = <0x5800a000 0x2000>;
+           reg-names = "stmmaceth";
+           interrupts-extended = <&intc GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
+                                 <&exti 68 IRQ_TYPE_LEVEL_HIGH>;
+           interrupt-names = "macirq",
+                             "eth_wake_irq";
+           clock-names = "stmmaceth",
+                         "mac-clk-tx",
+                         "mac-clk-rx",
+                         "eth-ck",
+                         "ptp_ref",
+                         "ethstp";
+           clocks = <&rcc ETHMAC>,
+                    <&rcc ETHTX>,
+                    <&rcc ETHRX>,
+                    <&rcc ETHCK_K>,
+                    <&rcc ETHPTP_K>,
+                    <&rcc ETHSTP>;
+           st,syscon = <&syscfg 0x4 0xff0000>;
+           snps,mixed-burst;
+           snps,pbl = <2>;
+           snps,axi-config = <&stmmac_axi_config_1>;
+           snps,tso;
+           phy-mode = "rmii";
+     };
-- 
2.25.1


