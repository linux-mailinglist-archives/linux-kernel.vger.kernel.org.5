Return-Path: <linux-kernel+bounces-160009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B962E8B37A5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70793284967
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080601474B5;
	Fri, 26 Apr 2024 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="8fhydkHI"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CD3144D3E;
	Fri, 26 Apr 2024 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714136391; cv=none; b=tLRsB2G8f24eqPrEAUQqy9m3VDCZy9n6mp3nsbnKyKfymBOPMeAv4iDQSzBeb5xB1O5g3Kad1zDNKtlCivnggsl7O81C4Cx18vV+u9NWvc56Ye7RC5WKbDJGWjVJZvg/tV1Np5UbVvvT9erfF6M0N2klvRekDUiY2RNfHQg3zbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714136391; c=relaxed/simple;
	bh=S08BQUFRfqJkfVyhy0xu9hpc4fol4tGtIRvX3fmETb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iWjtEPX0wPqqNNT+ldZiC/8//eEDKa6PRUqrNkezfdVJ2fnuECbysaypDOZ241mA9pNZdOcNDoUAxbB1OiqEjL3tBxbmCCvUCwZlThIpe5zlFcepEqIiFIfr4Qwv4J1Acjd26kn0dJjLl4Lab8c+yAt6ILarmnyEqvJ6KHj2VhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=8fhydkHI; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q9frIK029734;
	Fri, 26 Apr 2024 14:59:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=IpIPqjbC8mgfO8SO/lOJhLWcIY0STLLGzxjN3SEZAP8=; b=8f
	hydkHIGdZkR5wFGni4297SSgT2Ykg62nUvANe3Nnarj6hVGG+GdCy3s/310c7Wqz
	rkoFcsYx05fPBEdNRrIZHZNAOeF2jew7nEhiskJ5ZPOR4tPDAcGqmr60soSPPv8D
	JrtFP4w9QI+TE/bKMkgOKB3HCv9y8PYDo/7Xa4kPvadCmv466qxSthTUlxSa7xpH
	LKB1qEAhfmk7ikQS1QuYikjVdB/wTTTV+QQtquw65bTHH4MU/ILctEOMBx1QCmiT
	cR9VJNtBl3tnpkTZrh2KlXPVxy5lMnFlQCYBvOw0+ZXJhjC/g4xa0mK8Pm6DTRo+
	PaZwrSAKvw/7cQW1HwXg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xmrnjfjqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 14:59:24 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7095640044;
	Fri, 26 Apr 2024 14:59:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F3EDC222CA8;
	Fri, 26 Apr 2024 14:58:02 +0200 (CEST)
Received: from localhost (10.252.17.191) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 14:58:02 +0200
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
	<christophe.roullier@foss.st.com>,
        Marek Vasut <marex@denx.de>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 01/11] dt-bindings: net: add STM32MP13 compatible in documentation for stm32
Date: Fri, 26 Apr 2024 14:56:57 +0200
Message-ID: <20240426125707.585269-2-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240426125707.585269-1-christophe.roullier@foss.st.com>
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02

New STM32 SOC have 2 GMACs instances.
GMAC IP version is SNPS 4.20.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 .../devicetree/bindings/net/stm32-dwmac.yaml  | 76 ++++++++++++++++---
 1 file changed, 67 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
index f2714b5b6cf4..b901a432dfa9 100644
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
+    description:
+      Should be phandle/offset pair. The phandle to the syscon node which
+      encompases the glue register, the offset of the control register and
+      the mask to set bitfield in control register
     items:
-      - items:
+      - minItems: 2
+        items:
           - description: phandle to the syscon node which encompases the glue register
           - description: offset of the control register
-    description:
-      Should be phandle/offset pair. The phandle to the syscon node which
-      encompases the glue register, and the offset of the control register
+          - description: field to set mask in register
 
   st,eth-clk-sel:
     description:
@@ -105,12 +107,38 @@ required:
 
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
+            maxItems: 2
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
+            maxItems: 3
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/clock/stm32mp1-clks.h>
-    #include <dt-bindings/reset/stm32mp1-resets.h>
-    #include <dt-bindings/mfd/stm32h7-rcc.h>
     //Example 1
      ethernet0: ethernet@5800a000 {
            compatible = "st,stm32mp1-dwmac", "snps,dwmac-4.20a";
@@ -165,3 +193,33 @@ examples:
            snps,pbl = <8>;
            phy-mode = "mii";
        };
+
+  - |
+     //Example 4
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


