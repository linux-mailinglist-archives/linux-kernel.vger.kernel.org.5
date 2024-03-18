Return-Path: <linux-kernel+bounces-106440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6DE87EEB3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F512280D70
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD2D56460;
	Mon, 18 Mar 2024 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYIxbsSU"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F8255C36;
	Mon, 18 Mar 2024 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710782559; cv=none; b=WTL9b660CSgASLcwe8B1lYL6hUyTiIg4pOwsm7FTOsK62jJh50wYk9o9zxI6euBEify3kowB94SgUR9DKD4eaiaOG8jbmIEE19iaLGiAk7ieO9pGdQuwLOzW82l6gp2XL29fR+zvWxOm5g8lHGzPkasuraJegcXIhXtIwhhNExk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710782559; c=relaxed/simple;
	bh=kWErAwD9TJvsgos1SwxZVJeBao/DzulBMDP2w0L2Pxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qju7+kBGly6oy6rrJ7Vnimze71CiE8cGWC/FQwtubvba9jSYFF8PdikseN3sX3/OYbew+dTR1wggvr3oDp+Dq+WejCVmtMuKHq1ZwCW5UhN6JFxEGh70SQ6yZCkmpdjqNf3T+TwfULxxaiWBVhbfpH38FCjj8J5wvJQQknGa0OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYIxbsSU; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3416df43cabso858267f8f.3;
        Mon, 18 Mar 2024 10:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710782555; x=1711387355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Gam1JdPmDvO9yXMiXtlHAHoXQ20qxsq3uvgoQxIdjc=;
        b=TYIxbsSUBznp2o3sbZHTBoLRi4tar6Okcs1CPIcQhayvKA76kGM9vXwk5zdlq779/S
         qDdsLtslxHq7BeFj4tmqym2n8cYuakUf+kUiFLdsZZ7motEmQu7xIelFUS6wQJu+38T7
         slmrg0NoaF4V5bm6zypclooKO45QPqT1gipv+Ee/ZL9lx5lURNTrtqE7CVCg9/+XM6SX
         L1CzgxHF9D5diYSzcqVckvSNEscwo3QAdCreVdSbHxtcdtrLcyoE0s1AS+FFtZ305ieb
         12N98qnnyznnkLSE+o3LkgRma4FEF5RUBsqiVKmOifOugx11evr5//MxzfuMQARHPn9+
         gFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710782555; x=1711387355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Gam1JdPmDvO9yXMiXtlHAHoXQ20qxsq3uvgoQxIdjc=;
        b=NFqyAoVUR3851kBB6hCE+XCKq2OzaLV4UH+84wQIeVJuEhN4mQEgHZTURA9Ak8rqRa
         4msbsxIGA9I2HSEPFmQTZeY6mOFnE092gbqQGYQ0LNy69v8YJLHvAN2imQqxvI2I2lMm
         qtSO2cCvKEoDMF6pc2bKyuclINXIJjvzLzuDRrfIUFzWOxARO7+eIT9Vle7f93alvbyo
         bWWL/icHVwG5JS+upBnFF/D9I44BNWc7d6lGkt2eYC7LNBTdkn181nHgu826BfrMISKy
         T0hN/EYA3pBV5YpyYkzOIPc9rQ7ZednitC7fe5WRZpBFlff6brC4IVc8jjv1Qe8jxSUs
         rrzg==
X-Forwarded-Encrypted: i=1; AJvYcCVMknO+oEj4bh4CxuGDQNXyLgXI8xHCcKRcCCeL+wMNc6pnEvn16caDDp8/d+BhyAx2g4zYzm/7aKC7tnarHeGuPc0/Munt6F0VfCBaH9icHeuSMp/wkWMSYqhQDzhngNgJNS0Zot1tm3WDt5g/C6Ka8nTcxa/29LOiOgVXAiBfX/l3NuFbvm4UBI6C
X-Gm-Message-State: AOJu0Yz/bibE7n2qkn/UTgzwOqZZtR2OCTAuVcCBsCIypm+y4sWasTmO
	R+cahVnEFvXHIlImzlhJ8JjI9hTxQ8NQ8UTIYMKsDcIaRZF4fgqH
X-Google-Smtp-Source: AGHT+IF4pWLDZ6wEBNAQ4maqH2CTIEW+vFfrfRCE9h7HA5EwMllZPx3Vzq+IkthuL+JCEiSOPGvHBg==
X-Received: by 2002:adf:fdd1:0:b0:33e:78d5:848e with SMTP id i17-20020adffdd1000000b0033e78d5848emr8117277wrs.12.1710782555590;
        Mon, 18 Mar 2024 10:22:35 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:c23f:76ae:8149:291])
        by smtp.gmail.com with ESMTPSA id bv30-20020a0560001f1e00b0034180898569sm1140769wrb.72.2024.03.18.10.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 10:22:35 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 3/4] dt-bindings: serial: renesas,scif: Document R9A09G057 support
Date: Mon, 18 Mar 2024 17:21:01 +0000
Message-Id: <20240318172102.45549-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318172102.45549-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240318172102.45549-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document support for the Serial Communication Interface with FIFO (SCIF)
available in the Renesas RZ/V2H(P) (R9A09G057) SoC. The SCIF interface in
the Renesas RZ/V2H(P) is similar to that available in the RZ/G2L
(R9A07G044) SoC, with the only difference being that the RZ/V2H(P) SoC has
three additional interrupts: one for Tx end/Rx ready and the other two for
Rx and Tx buffer full, which are edge-triggered.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3
- Added SoC specific compat string
---
 .../bindings/serial/renesas,scif.yaml         | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index 53f18e9810fd..e4ce13e20cd7 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -79,6 +79,8 @@ properties:
               - renesas,scif-r9a08g045      # RZ/G3S
           - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback
 
+      - const: renesas,scif-r9a09g057       # RZ/V2H(P)
+
   reg:
     maxItems: 1
 
@@ -204,6 +206,37 @@ allOf:
             - const: dri
             - const: tei
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,scif-r9a09g057
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: Error interrupt
+            - description: Receive buffer full interrupt
+            - description: Transmit buffer empty interrupt
+            - description: Break interrupt
+            - description: Data Ready interrupt
+            - description: Transmit End interrupt
+            - description: Transmit End/Data Ready interrupt
+            - description: Receive buffer full interrupt (EDGE trigger)
+            - description: Transmit buffer empty interrupt (EDGE trigger)
+
+        interrupt-names:
+          items:
+            - const: eri
+            - const: rxi
+            - const: txi
+            - const: bri
+            - const: dri
+            - const: tei
+            - const: tei-dri
+            - const: rxi-edge
+            - const: txi-edge
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1


