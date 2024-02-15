Return-Path: <linux-kernel+bounces-67432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A994856B79
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EFD4B2156E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3716E1386AD;
	Thu, 15 Feb 2024 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4jYCgIO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DDC1369B2;
	Thu, 15 Feb 2024 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019203; cv=none; b=Itizu7zr+BaciO0cIWU6J4CnDg1FLVtvijaVkSOmfw6PAuRXo5YQMwRyCh5t2C5jwHv1sXnjAKXSa3PWIWC2NJqp+xsaCku+x1ZuuzRkn282aJFXZqFG5Lyn9Fr1VIKRlhmsWiCkXHzILaHh7H1XbbsWRtrJO+ABgp6CL2FqP8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019203; c=relaxed/simple;
	bh=qrkL/cNhS+5VssaK2deynwkxln+cK6Q46lyuSrshsP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VKo4MHo9RPh9TXfrg5ZFEkTKevWVGJn8H6BDJ7Uas63c9ZP76jAVx3eYT0TZq6rbKw+pGWoegGTnWno2nunSslJgQtQE5Iy5HY3wmO2um5UsbIYxKff7ELrKZ7H+lQtOPNptgSAJzg/LuxJ9cnT3bbzv9MOosjUulX0AHw7v2tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4jYCgIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8706C43399;
	Thu, 15 Feb 2024 17:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708019202;
	bh=qrkL/cNhS+5VssaK2deynwkxln+cK6Q46lyuSrshsP8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=R4jYCgIOG1sqiWcVTSMjk3GVSIyvK3jhwIHX8a/OR9wFQ6JqA5U9QZ8Ve7wn+Z2Gf
	 IyJcbct0J2eQBHWHUNk6BToF6BIjYrnbetgjl8rTG6F0Z6BEUx5GsloDmo5KVKakVB
	 4sJRD8vdDnuIg3UCit0Q2pWaTezfDyUg8UelflIO/VM0Up7OfcBqkUEJo6hyZUHAo1
	 dnbnLx1lRkbbWwV6U7UoMQCGrEMg6Q6mslVOcsbjNE2JQxTNAHTJ+pBnUQB4ehjxiB
	 ufi2FQ4xwF2K07Y/di93LwXpoqzqQ65bcIMNn0aAepLtlnpUgOzl+5XsuWdJ53ni5r
	 REPxrKbwBv2wA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFC1C48BF2;
	Thu, 15 Feb 2024 17:46:42 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 16 Feb 2024 01:46:44 +0800
Subject: [PATCH 3/3] dt-bindings: mmc: dw-mshc-hi3798cv200: rename to
 dw-mshc-histb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-b4-mmc-hi3798mv200-v1-3-7d46db845ae6@outlook.com>
References: <20240216-b4-mmc-hi3798mv200-v1-0-7d46db845ae6@outlook.com>
In-Reply-To: <20240216-b4-mmc-hi3798mv200-v1-0-7d46db845ae6@outlook.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>, 
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708019203; l=4176;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=vyT5SY9rrA1BRKlIPW3ARvBOXeZjjpuC0pdH+zidx+U=;
 b=Tf3Nb3SLoAI+EwCZ6ijWxGYdkpP8wYBMIRw7xswxJo5oZ6AvOrrL3r6U3dllsArYeg57hgvnE
 9OOU7fzbCSNBO41J+nGHqoN6vK/gcrutOvSe/waWCtMDad1zAuLOUIS
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Add binding for Hi3798MV200 DWMMC specific extension.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 ...hi3798cv200-dw-mshc.yaml => histb-dw-mshc.yaml} | 60 +++++++++++++++++++---
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml
similarity index 57%
rename from Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.yaml
rename to Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml
index 5db99cd94b90..d2f5b7bb7a58 100644
--- a/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/histb-dw-mshc.yaml
@@ -1,11 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/mmc/hi3798cv200-dw-mshc.yaml#
+$id: http://devicetree.org/schemas/mmc/histb-dw-mshc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title:
-  Hisilicon Hi3798CV200 SoC specific extensions to the Synopsys DWMMC controller
+  Hisilicon HiSTB SoCs specific extensions to the Synopsys DWMMC controller
 
 maintainers:
   - Yang Xiwen <forbidden405@outlook.com>
@@ -14,16 +14,14 @@ description:
   The Synopsys designware mobile storage host controller is used to interface
   a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
   differences between the core Synopsys dw mshc controller properties described
-  by synopsys-dw-mshc.txt and the properties used by the Hisilicon Hi3798CV200
-  specific extensions to the Synopsys Designware Mobile Storage Host Controller.
-
-allOf:
-  - $ref: synopsys-dw-mshc-common.yaml#
+  by synopsys-dw-mshc.txt and the properties used by the Hisilicon HiSTB specific
+  extensions to the Synopsys Designware Mobile Storage Host Controller.
 
 properties:
   compatible:
     enum:
       - hisilicon,hi3798cv200-dw-mshc
+      - hisilicon,hi3798mv200-dw-mshc
 
   reg:
     maxItems: 1
@@ -48,6 +46,12 @@ properties:
       control the clock phases, "ciu-sample" is required for tuning
       high speed modes.
 
+  hisilicon,sap-dll-reg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      A phandle points to the sample delay-locked-loop(DLL)
+      syscon node, used for tuning.
+
 required:
   - compatible
   - reg
@@ -55,13 +59,25 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - $ref: synopsys-dw-mshc-common.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: hisilicon,hi3798mv200-dw-mshc
+    then:
+      required:
+        - hisilicon,sap-dll-reg
+
 unevaluatedProperties: false
 
 examples:
   - |
     #include <dt-bindings/clock/histb-clock.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-    emmc: mmc@9830000 {
+    mmc@9830000 {
       compatible = "hisilicon,hi3798cv200-dw-mshc";
       reg = <0x9830000 0x10000>;
       interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
@@ -84,3 +100,31 @@ examples:
       bus-width = <8>;
       status = "okay";
     };
+  - |
+    #include <dt-bindings/clock/histb-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mmc@9830000 {
+      compatible = "hisilicon,hi3798mv200-dw-mshc";
+      reg = <0x9830000 0x10000>;
+      interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&crg HISTB_MMC_CIU_CLK>,
+               <&crg HISTB_MMC_BIU_CLK>,
+               <&crg HISTB_MMC_SAMPLE_CLK>,
+               <&crg HISTB_MMC_DRV_CLK>;
+      clock-names = "ciu", "biu", "ciu-sample", "ciu-drive";
+      resets = <&crg 0xa0 4>;
+      reset-names = "reset";
+      pinctrl-names = "default";
+      pinctrl-0 = <&emmc_pins>;
+      fifo-depth = <256>;
+      clock-frequency = <50000000>;
+      max-frequency = <150000000>;
+      cap-mmc-highspeed;
+      mmc-ddr-1_8v;
+      mmc-hs200-1_8v;
+      mmc-hs400-1_8v;
+      non-removable;
+      bus-width = <8>;
+      hisilicon,sap-dll-reg = <&emmc_sap_dll_reg>;
+      status = "okay";
+    };

-- 
2.43.0


