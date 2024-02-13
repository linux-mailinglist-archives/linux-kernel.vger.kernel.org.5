Return-Path: <linux-kernel+bounces-63168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ED0852BD3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF041F24325
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E51C21104;
	Tue, 13 Feb 2024 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/Im/KNI"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E1C1B7E6;
	Tue, 13 Feb 2024 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814762; cv=none; b=ZihFsrbqYfFN6KdKd3BspyxqDuIVdQokWWblWd8no0FJHuwHte4EVGi208ppj8sxNs58EtnyGcbkWrdPgbq7Y66UblZeEvMCKZAhbllxyzjaW26kwLLNFHkkKaq7ORIEV0V3S/b/EEvsDe854tbKh7iPAMilvA+To5ye/TtieRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814762; c=relaxed/simple;
	bh=IB+Cqii8gfzUfHQMIEHpcpm15e5ALfL6x97JYW+pD/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VMke9+HVcMbWXjSJ9AukrPBSdXN0lurfOF7jj2cq+pxDJEPcM4bMAuHiP7UytGLIL6iT+b+HC3LeaHt41mEVoEpXR4hzUCacKp5MDf0xhhQmwwaixSKDl7MUAylw1tWhhQMyrIpOkCPNt75GWx6L4KehjV6HNPZs/0O6szlFGfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/Im/KNI; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d10ad265d5so3381051fa.0;
        Tue, 13 Feb 2024 00:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707814758; x=1708419558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A+rca7UJDShH+g1ZK8dFbCY12cccgTgH8rSZBK2oZgU=;
        b=F/Im/KNIzZxWXeJ5mcq8vth0ZHHvmwMEDv3GO6CL4kRLEmv4QE6WImzeZ9KouFRgyN
         rnH/y4z9HvFbSuiXJw+8a4jWWJAFU+WMkSMrtFVeF3Scj2b7Ghgnl9ykHQmj/AFQpLTF
         fCTR8laVihVmMKH5avZLRkJvqdYsQM9RmxIEy9D9Df+ODurDt7zGV54bZmIcqQ2HhJrt
         vy91QVK9l0IYbKwdZ/V6m1JvfU2vwmitTdyj4N5RLe19memR4EH8er8DakCNDctbcL7b
         ncqsGeZRpMKGaUV7sCGvimctfX1UZUF+xwe0vA8bVsbqRzv+5fT/I73xlIXqu0HQ1aDm
         RFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707814758; x=1708419558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+rca7UJDShH+g1ZK8dFbCY12cccgTgH8rSZBK2oZgU=;
        b=KrxH6ycJpy9EGQzHW4Ulcr43nrbkSNYVeIIalsBjHQEd1TlMd2MZWYfPIPhe+DRbGK
         wRInrlHCYfYzBeyzLJZ5gQmUFm9iSOjeHWj3w4oh2wRPv/Y2/pw/lX2YFM9m6UN7aNJb
         AhjWsyORaOONKjhepNxUkPejwe1jCrwEPmbm9d0kCaiNXhboxqIaqOzcmaovbnMvMOAK
         vmCxbGMoFIM9qo7kOrfQYyk7dye9Qj4KAbOrrBWA272KPFJH36KjeUoq7ZkLhhpYUZuA
         lZNjL0Q7frTVX8zxxFPctivYiS0l1eK2bpnTP9ZJGlO/q99MaDPul9ron77lq8dg3bCg
         1Emw==
X-Gm-Message-State: AOJu0YyAVBt03WCfl153YrbZKfUiSAr7R1kpQ4DIrfCUHIfvz6vIMMwQ
	S8f7rOSfa5F5R7WUdeagf8nBt7F2S1CZtHJpQbzjkZm5CM7wtnUB
X-Google-Smtp-Source: AGHT+IE7ctqI5RzwANomWKNPi1hR0T+q0t/trY4j4qC/ca8SuAIFzV4xG2TfZWEpYXrM/YjKPIjjGA==
X-Received: by 2002:a2e:a544:0:b0:2d0:f8f2:233 with SMTP id e4-20020a2ea544000000b002d0f8f20233mr4176626ljn.45.1707814758239;
        Tue, 13 Feb 2024 00:59:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUV3PIlcuCNm8Qeb94qKsjF3jpQzWk26R8WB3aOyQtKU8J6JPqC+PfB5/30C56G92RvoqiWoazI2MYNDBdPoCUCUylffXmgA0oC28jyWIFeb/jZ99EdcBNqu3DCRLqNU/QlUcfaB3r4/WBHwTDQv4QhpXfQnzh5FLwEmypY1S6IexySsfvu5E2tWJ0RnnXnzvkYeH/3kWso6LvRjBA1EEkxWdeKpZCL9hKgp8DpwCcM4l0Ep2NIpOdYQlVQYvasgS2fVK4ykilsZbVIsoCz4MaemqKdKru4+6SAep2gi1MhEd6knrbmN30eOoFyR3LPidmButHyBuJdmhGt5yJfVPtma90W9dODpWNGoqCN1NsV9K4uswFU31surpblj73vkYGjg5DIluMjf6BVnSU8UpiKkoAH2gYigBJHPXv9vxBfpWlXSO+TZg5UdhSY0C+3iRTmCevIV+urGheA3fMlM6ifulQMbdjKd4ZrXJTj
Received: from prasmi.home ([2a00:23c8:2500:a01:3791:9495:d351:f873])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c00ca00b00410cc2f5550sm5845166wmm.19.2024.02.13.00.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 00:59:17 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3] dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update interrupts
Date: Tue, 13 Feb 2024 08:59:12 +0000
Message-Id: <20240213085912.56600-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

All the RZ/G2L and alike SoC's (listed below) have ECCRAM0/1 interrupts
supported by the IRQC block, reflect the same in DT binding doc.

- R9A07G043U              - RZ/G2UL
- R9A07G044L/R9A07G044LC  - RZ/{G2L,G2LC}
- R9A07G054               - RZ/V2L
- R9A08G045               - RZ/G3S

For the RZ/G3S SoC ("R9A08G045") ECCRAM0/1 interrupts combined into single
interrupt so we just use the below to represent them:
- ec7tie1-0
- ec7tie2-0
- ec7tiovf-0

Previously, it was assumed that BUS-error and ECCRAM0/1 error interrupts
were only supported by RZ/G2UL ("R9A07G043U") and RZ/G3S ("R9A08G045")
SoCs. However, in reality, all RZ/G2L and similar SoCs (listed above)
support these interrupts. Therefore, mark the 'interrupt-names' property
as required for all the SoCs and update the example node in the binding
document.

Fixes: 96fed779d3d4 ("dt-bindings: interrupt-controller: Add Renesas RZ/G2L Interrupt Controller")
Fixes: 1cf0697a24ef ("dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G3S")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2 -> v3:
- Fixed IRQ description as pointed by Geert
- Sending this individual patch as DTSI patches have been Reviewed by Geert

v1 -> v2:
- Fixed review comments pointed by Conor

v1: https://patchwork.kernel.org/project/linux-renesas-soc/patch/20240202093907.9465-2-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 .../renesas,rzg2l-irqc.yaml                   | 44 +++++++++++++++----
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
index d3b5aec0a3f7..daef4ee06f4e 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
@@ -44,7 +44,7 @@ properties:
     maxItems: 1
 
   interrupts:
-    minItems: 41
+    minItems: 45
     items:
       - description: NMI interrupt
       - description: IRQ0 interrupt
@@ -88,9 +88,15 @@ properties:
       - description: GPIO interrupt, TINT30
       - description: GPIO interrupt, TINT31
       - description: Bus error interrupt
+      - description: ECCRAM0 or combined ECCRAM0/1 1bit error interrupt
+      - description: ECCRAM0 or combined ECCRAM0/1 2bit error interrupt
+      - description: ECCRAM0 or combined ECCRAM0/1 error overflow interrupt
+      - description: ECCRAM1 1bit error interrupt
+      - description: ECCRAM1 2bit error interrupt
+      - description: ECCRAM1 error overflow interrupt
 
   interrupt-names:
-    minItems: 41
+    minItems: 45
     items:
       - const: nmi
       - const: irq0
@@ -134,6 +140,12 @@ properties:
       - const: tint30
       - const: tint31
       - const: bus-err
+      - const: ec7tie1-0
+      - const: ec7tie2-0
+      - const: ec7tiovf-0
+      - const: ec7tie1-1
+      - const: ec7tie2-1
+      - const: ec7tiovf-1
 
   clocks:
     maxItems: 2
@@ -156,6 +168,7 @@ required:
   - interrupt-controller
   - reg
   - interrupts
+  - interrupt-names
   - clocks
   - clock-names
   - power-domains
@@ -169,16 +182,19 @@ allOf:
         compatible:
           contains:
             enum:
-              - renesas,r9a07g043u-irqc
               - renesas,r9a08g045-irqc
     then:
       properties:
         interrupts:
-          minItems: 42
+          maxItems: 45
         interrupt-names:
-          minItems: 42
-      required:
-        - interrupt-names
+          maxItems: 45
+    else:
+      properties:
+        interrupts:
+          minItems: 48
+        interrupt-names:
+          minItems: 48
 
 unevaluatedProperties: false
 
@@ -233,7 +249,14 @@ examples:
                      <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
-                     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
+                     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 37 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 39 IRQ_TYPE_EDGE_RISING>;
         interrupt-names = "nmi",
                           "irq0", "irq1", "irq2", "irq3",
                           "irq4", "irq5", "irq6", "irq7",
@@ -244,7 +267,10 @@ examples:
                           "tint16", "tint17", "tint18", "tint19",
                           "tint20", "tint21", "tint22", "tint23",
                           "tint24", "tint25", "tint26", "tint27",
-                          "tint28", "tint29", "tint30", "tint31";
+                          "tint28", "tint29", "tint30", "tint31",
+                          "bus-err", "ec7tie1-0", "ec7tie2-0",
+                          "ec7tiovf-0", "ec7tie1-1", "ec7tie2-1",
+                          "ec7tiovf-1";
         clocks = <&cpg CPG_MOD R9A07G044_IA55_CLK>,
                  <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
         clock-names = "clk", "pclk";
-- 
2.34.1


