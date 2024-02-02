Return-Path: <linux-kernel+bounces-49601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DF5846C49
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2BF1C25C22
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CB577F10;
	Fri,  2 Feb 2024 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hi5Ob23l"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E73960BA6;
	Fri,  2 Feb 2024 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706866767; cv=none; b=tNKXmO8BoB6iNFkCQYUQMy/MuGsXayOpSAUeTRcS2zXZmLTWVyfio/9O71Bzzuy76IaX3xheOb+p6OlCxhLS/vvIGYJZ2fSF/R460CUl5W2p11VeKs/6bggRXxspVnD5EzPniv7cNaLD6UzWH4+/zC/e1FhM2fwHp0qzNjPGGJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706866767; c=relaxed/simple;
	bh=fxcQbiZuKXTYvImMfOEE4sD7KfzL3aauPXr/9Xw+pS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c1lc3QshTF44UBqOy8Ff+waMnzRCQFXk3M/jfDwBurcuTGv+2laVcT0G3HA9VHBVC0tN5A3DYJeSjwVR1ov291rXOZqosIvX3fZrDWtcnXkWokYmhvQLEgBmERgM23mfdr+R565eESBT1rfoYXU+Avs8sQ8LLXNrokx8p3zA+II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hi5Ob23l; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40fc52c2ae4so5220555e9.3;
        Fri, 02 Feb 2024 01:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706866763; x=1707471563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2k6sfPimCPYbE1TyfDUboyw74TFWcRFeVd2lcCqIRM=;
        b=Hi5Ob23lSu1uMwXEEsKwsTwtXYBGWb4An1SnwIPF+u1IAtcEkoeuBXgxuQK5Oliihg
         lPp6IY9q1eon5JSzgvmzClOieiHx19TinXjZAn1nEPnGj+VdzQ7v6xX/b1Fg/CF7ohLn
         bOBoq0pN2OqQU/LyOIG/Qs4qF2MnnfWlf0zL7dncIsJFqg7IUaIYKpLppX/naSZ3YpJ3
         LuMyWY9T1HgVp1aKk9ooejRmHRtHmDKVle1LuSlO8HuhayoJDv+kkvLZZ2X2xIQYVuRl
         SSkX/sm7MsfgHwDyBU7vdAU26h7d31p5HJEE3FVkNfuJdSt8hrNuKN1w4XvxryERMN8C
         rl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706866763; x=1707471563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2k6sfPimCPYbE1TyfDUboyw74TFWcRFeVd2lcCqIRM=;
        b=kSKdQ8tGjEQPpeY9wlvXvyPcg8BqtGh52O15cFa1vZAd/hhFByE9klwC9AOiLcVGDm
         ZBp+AU1UAzIsLf+XvuCrh43alXJmih1yMJwTrL2lHoFoY2gQvasRJ3uvRUeK9qeOeHBV
         fENM4hBzcJsjvWk5iTVTNO96OJSV66l+ZCCfbeKJG3aE8xdRLPoJXlJNvrU4kvgQKG02
         OvTrxKJjdazuNZxesTi7CFD7BWXNyVz3wA/YUX8bYbqsDb/vHXA7tWZxBy4u5v0KAEPi
         uYhCMFoGJHAV4HD/v4QivhqwTHs4JmPy2fLkXhp1RdlTStoP1BWAGfKmoGb2zCSUYLqN
         VViQ==
X-Gm-Message-State: AOJu0YwLOVP65w0Kn9iKtC/SqNrFyPc6jbzhkML2KLTSxJ8Ky3QudVaW
	uzqQy+znnXo6S+fiSEjxI/N6g/o2itDs7K6n7QC09Yi+4CVoiFdG
X-Google-Smtp-Source: AGHT+IHZ+xhE5fifLkpyiD5A4kS0YRQDa3RY0zi4Az33bhKXjNnuOuXtT5r5/EtewxHOMpooHveekg==
X-Received: by 2002:a05:600c:46c7:b0:40f:bf02:3bc4 with SMTP id q7-20020a05600c46c700b0040fbf023bc4mr1189874wmo.8.1706866763219;
        Fri, 02 Feb 2024 01:39:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU/Yj4kxpNW7e540YO2k0DOfkx8KTZhPMWAfxUKkQgBZ4UPxJTA2QRzJjpFQ0HAls8hxRKe326228uuYRuZ38XqOaW8DFYAUL8qRYEAMKx5QTktn1+0Odu/fhIKb3USlE0vz+pT8ePjND/2lj67PZNxcOaNEcNV0yfdz9CLlWzIobmCV06FN43EcdYXZAfOgiAb+gOQ+8TSRU/2TDbNvffjmCS6ParuRj5c57ImMF33DUVtNWEc9eNQbZbw0QghvV6EA6DLTlgIgjafwWvzdphlS7x+Jlkbum1EIR/ePB5bAXFKPhEIa8C9my2uJzOLj1ngUr2ohiPm2xuWuJTX7F8qPIezeghMKjGcMd02OJkwE5dj8dP/tejMwcX28YVGMTourdsl8+fEldQAx4rT7lEQDjwx2t1AXgdaLwCL3vJYrt3P9bgpS8pZCyN6/A32W5UpuaTeFM/cKqOzShgKWPL4j5TG9JQElOoi8Uyi6os=
Received: from prasmi.home ([2a00:23c8:2500:a01:a994:230a:9969:dbf7])
        by smtp.gmail.com with ESMTPSA id bg10-20020a05600c3c8a00b0040fbdf77ca3sm3827530wmb.42.2024.02.02.01.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 01:39:22 -0800 (PST)
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
Subject: [PATCH 1/3] dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update interrupts
Date: Fri,  2 Feb 2024 09:39:05 +0000
Message-Id: <20240202093907.9465-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202093907.9465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240202093907.9465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

RZ/{G2L, G2LC}, RZ/G2UL, RZ/V2L and RZ/G3S SoCs have ECCRAM0/1 interrupts,
reflect the same in the DT binding doc.

RZ/G3S SoC has ECCRAM0/1 interrupts combined into single interrupts so
we just use the below to represent them:
- ec7tie1-0
- ec7tie2-0
- ec7tiovf-0

Additionally mark 'interrupt-names' property as required for all the SoCs
and update the example node in the binding doc.

Fixes: 96fed779d3d4 ("dt-bindings: interrupt-controller: Add Renesas RZ/G2L Interrupt Controller")
Fixes: 1cf0697a24ef ("dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G3S")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../renesas,rzg2l-irqc.yaml                   | 44 +++++++++++++++----
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
index d3b5aec0a3f7..0bc9c604a2d7 100644
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


