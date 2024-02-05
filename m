Return-Path: <linux-kernel+bounces-52839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32592849D4A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88E41F23958
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DAC2C699;
	Mon,  5 Feb 2024 14:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THPub77T"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA2A2C19D;
	Mon,  5 Feb 2024 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144283; cv=none; b=NbAbhnfVDkJ6BCMvlSmbEYUxx1GbqTx1SDjqIni/ydfBwShQI8ZOf8530YqLDahQPw/Z+ZvqyK60dyx4ph3wq/qAiOJaPJfiti1uHKwoUN1YqZ4zRiNg7gg5kdCe/xlDeCj+e/fS7i7zfLhwEmnC6Ww47/BQhfpNglz6407uwcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144283; c=relaxed/simple;
	bh=AQTOuWqRCiwwJGRGLO9WO3lmKoyPCiflQ20FiC7Z7sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U19CgfrfXJL56g1Dvtylzwv+BEvUVsZptwVVR8PkElSLA9om517okvdq0rvRERdTdFzOQKiDHPJ1xZ5vVBcaQ/YH8ZpIyatN8AsEkLxZCGcC2VvhB/shtxqdTJKHGr6vmXw6G/SZruNhQ4/yNrdTChxMijP440PAW4sR3cZZ+Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THPub77T; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40fc6343bd2so27862465e9.1;
        Mon, 05 Feb 2024 06:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707144279; x=1707749079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ag94mHXz3y80NsPilnTku7mCKndRCRCm6Hi1ifPq2Zc=;
        b=THPub77TK//ZR21vCpfn71Krgef54MMEP0DnNzVQDnS0iSm40swjXHPs8mdDjUG3lp
         lQ2HInrEphYEoTl7ImzBolp4vEUwUUG6DHeCQEhFVcjAmI+F02cCAi4hZeUiE7FH6vYA
         63aRFAurerw+0UfT/4UWK/xkDvSVdGWyvcE9FYHnK7GVgNfNMVm4DYz9cXa0zpkZCM22
         e1QaV5DdAZu0qtoZyo2xENy9WgLOXXjoXTQuKbifXkWv5eCgmxfeSMtJkjEWWMTlZ6Sq
         o4T40zvzqT/Itz3pvCEpgC1nAzhqr3p+xuGf/tqc/mvzX3uRFpZ1GsWQfP1Q+rgEZRUQ
         C5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707144279; x=1707749079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ag94mHXz3y80NsPilnTku7mCKndRCRCm6Hi1ifPq2Zc=;
        b=QQB//6OwFakuIfRWb+IyFjjJfpD3+im76XnobkNRKCsVJJl6zyDaxsM9oj+g65skeP
         wPMfYIkxfpGAKaawkm2kW2sCWY5qn5/dOxN29zXjRBlf9LG8lYS5nqpFIzqr/QMV5dw1
         NXbsCy4EA47SQBe6gEWUczw7F9/xHjyjA0y/6O27iqub551o4ZboIft1uzVLHSCIfo8A
         vaG5INuoZvoW1ZPvKkkahNr/l/mwZQyzkbnUfX29Am3kvuZASJ8Tb3ucLsMNHyPHHysh
         a9k4DfSV7G4lQH8uHkBpebfjHw1apyB+hL2PAjQ6fyt57b2fFxRZsof+hlGDHnbbjLP6
         l50g==
X-Gm-Message-State: AOJu0YyewIdsHoKgEL/i6q4kNTmz7PfllAPYAs1cZJc017Q3SWloAoZF
	0lVy5ELPni1G/9/2Q6tWPNmGjHwVbW1j38x5QaW+81fnA8htSUoVnB1RBVhH
X-Google-Smtp-Source: AGHT+IGHFO+puO6OXHwqoZ899jJBhQUkayLDksTAnyDyrWIw+ejeInBCT65cWe8hGmW6PSN8b2a/Ww==
X-Received: by 2002:a05:600c:34ca:b0:40f:ddb1:dff6 with SMTP id d10-20020a05600c34ca00b0040fddb1dff6mr1304583wmq.28.1707144279176;
        Mon, 05 Feb 2024 06:44:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVzU3+wj+EFYFxKXFJlFe8zbpPvgyvO2vpzPmhmGXo3SdkIkxcUiXK34Mw18Ar5s9W3gmFto2xn/9pRS5NlTnN6Wrw+zO9DZ1oaeOexk4JWFqDDAnNhbTodISlARJ4llWUlFTCnAQ7/Lsx+Bag0D0vc9/PLXFFj7WDoAQ4cIzcqn9BJsYWWtQ52KQeHubVLwDyHG7jJOl5QI9oZnDDmV10cB2Qi0KneAsC/RPowlAZ3Sbs3dzh5bn56DFsbg0Ekab10Sj/sVz3wj+nxO4uzjyiON61PTa9G06tmitzLVkPxIyrdIlvzxkD+SG+oiFaeVBsoddvKF11Oui3mxnAEkmLYC+JiKJHb7mizvByQyiU8ugFZotFhgrprGef6sCAQxixXDWQz9rTfBSD+Pc4G+NimP2uNnk5XjDXr0D1z1aUskZZNDGum9klviiogC+Ms5Twe7qgfeCsW2G8RV6pusq2ekhp6gg3pHD+JrIE4jjQ=
Received: from prasmi.home ([2a00:23c8:2500:a01:8f3c:6ff8:96c9:c9f0])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b0040fdf2832desm70272wmq.12.2024.02.05.06.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 06:44:38 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 1/3] dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update interrupts
Date: Mon,  5 Feb 2024 14:44:19 +0000
Message-Id: <20240205144421.51195-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205144421.51195-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240205144421.51195-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 .../renesas,rzg2l-irqc.yaml                   | 44 +++++++++++++++----
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
index d3b5aec0a3f7..078c538f8fbf 100644
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
+      - description: ECCRAM0 1bit error interrupt
+      - description: ECCRAM0 2bit error interrupt
+      - description: ECCRAM0 error overflow interrupt
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
+      - const: ec7tie1-0   # For RZ/G3S SoC ("R9A08G045") ECCRAM0/1 interrupts are combined into single interrupt.
+      - const: ec7tie2-0   # For RZ/G3S SoC ("R9A08G045") ECCRAM0/1 interrupts are combined into single interrupt.
+      - const: ec7tiovf-0  # For RZ/G3S SoC ("R9A08G045") ECCRAM0/1 interrupts are combined into single interrupt.
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


