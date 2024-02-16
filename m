Return-Path: <linux-kernel+bounces-68359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E2885793B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A934B23B34
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F59A1C69D;
	Fri, 16 Feb 2024 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="RbZppuBS"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739AD1BC36;
	Fri, 16 Feb 2024 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708076974; cv=none; b=B2cilENocmaO7jzwkmCdyAaAFD0kGyoJWRRWbQwj4CwUFotCfn0LPAoEVC7gu/nvqCUC/JjxnTn2aSkHHJtc8AIwqohzttmoh2xFuaozUclGbwoFldn+OGLyMXGsRVwnNkxpVt/Bnno0wzFcLX7qkKWqk291+R0ofzr9L6NQTy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708076974; c=relaxed/simple;
	bh=PbKiPm65AQhzwm7LxGporlmFUt0BSmqJq6j8SVwUHjs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Az02lW1Pz0lgtUgmCvQHYGGz1d6tjQgL8iNjFS3oj2R5OPN+TMvY3CDeJpLUEmjO3R0p+kysdQKp/095m4msC1X9KRAlA0toCL2LdQYqCXHDaer0DZ9zkRMlCZZe266lI8B+QXP2PKnXfn68omh4KdupoTbxjIoGcW2c6heZQM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=RbZppuBS; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G4qHJU024968;
	Fri, 16 Feb 2024 10:49:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=6oy4aiUMKITAZcOmFqBjM6ZnhYNqhJFyPyPaNACQD3I=; b=Rb
	ZppuBSKRCfE/AbEaqxNqIA71yVxaQPb2Z5/M+GS+P4mUIe+YW02k722ObMuEbe9T
	EKAdxPvUcNWa4tPtIBTF7CBh2yzARnlJgrDLsnjy58nbPJEfaqaUStz/Gxcph/oW
	SbcFLnG1bKeK/5lESmWN61uv1VPCAi5hAk8Oavo4xDdpll5hX3jxhLoXJyQewWMb
	RdBiP6f2X7UVqApIaYeP18BxT5e/zbFYdYZattcrl9a1ykHP/cZMl5hA1Y0+Y7kC
	168z3S1YxlIx7xPs7QeYXnfPcr1zT1GbDFIwFv9CwH+y7Jem0gytKix2lkHFkl+I
	yp0MrKV+veearNGx3GuA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wa126gy3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 10:49:06 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 89DB340048;
	Fri, 16 Feb 2024 10:49:03 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3D0A8237D75;
	Fri, 16 Feb 2024 10:48:18 +0100 (CET)
Received: from localhost (10.201.20.114) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 16 Feb
 2024 10:48:17 +0100
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: Antonio Borneo <antonio.borneo@foss.st.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>
Subject: [PATCH 02/12] dt-bindings: interrupt-controller: stm32-exti: Add irq nexus child node
Date: Fri, 16 Feb 2024 10:47:47 +0100
Message-ID: <20240216094758.916722-3-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216094758.916722-1-antonio.borneo@foss.st.com>
References: <20240216094758.916722-1-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_08,2024-02-14_01,2023-05-22_02

The mapping of EXTI interrupts to its parent interrupt controller
is both SoC and instance dependent.
The current implementation requires adding a new table to the
driver's code and a new compatible for each new EXTI instance.

Add to the binding an interrupt nexus child node that will be
used on the new EXTI instances and can be optionally used on the
existing instances.
The property 'interrupt-map' in the nexus node maps each EXTI
interrupt to the parent interrupt.
Align #address-cells and #interrupt-cells between the EXTI node
and its nexus node.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 .../interrupt-controller/st,stm32-exti.yaml   | 42 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
index 00c10a8258f1..1a4cf9537b9e 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
@@ -26,6 +26,9 @@ properties:
   "#interrupt-cells":
     const: 2
 
+  "#address-cells":
+    const: 0
+
   reg:
     maxItems: 1
 
@@ -42,6 +45,24 @@ properties:
     description:
       Interrupts references to primary interrupt controller
 
+  exti-interrupt-map:
+    type: object
+    properties:
+      interrupt-map: true
+
+      interrupt-map-mask: true
+
+      "#interrupt-cells":
+        const: 2
+
+      "#address-cells":
+        const: 0
+
+    required:
+      - interrupt-map
+      - "#interrupt-cells"
+      - "#address-cells"
+
 required:
   - "#interrupt-cells"
   - compatible
@@ -89,8 +110,27 @@ examples:
         reg = <0x5000d000 0x400>;
     };
 
+  - |
     //Example 2
-    exti2: interrupt-controller@40013c00 {
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    exti2: interrupt-controller@5000d000 {
+        compatible = "st,stm32mp1-exti", "syscon";
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        reg = <0x5000d000 0x400>;
+        exti-interrupt-map {
+            #address-cells = <0>;
+            #interrupt-cells = <2>;
+            interrupt-map-mask = <0xffffffff 0>;
+            interrupt-map =
+                <0 0 &intc GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+                <3 0 &intc GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+
+  - |
+    //Example 3
+    exti3: interrupt-controller@40013c00 {
         compatible = "st,stm32-exti";
         interrupt-controller;
         #interrupt-cells = <2>;
-- 
2.34.1


