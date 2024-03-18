Return-Path: <linux-kernel+bounces-106439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16DE87EEAF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F662812D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9559055E6C;
	Mon, 18 Mar 2024 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIaPtzCu"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164245579B;
	Mon, 18 Mar 2024 17:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710782557; cv=none; b=UrIL5jJvFk3Lc7NSBP8sAEXbzWS9Cq5AeCaY3+0o0zYGoSMXgwN7ljPvqDUMTA5Y+Rq4mqK0nTpF+KZyIvhXzefi5w4RdnDphaI6y2X+yKudIUYL8SP1ckXehIIs1YOuYpcWA6p1PhfqioI7D1N1BgoX7vTQSY7heytbbKf+gPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710782557; c=relaxed/simple;
	bh=FAcDPmSnwlJA07x2VaIi24bTmpN9XuJ8WgMtpuZ45AI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LkjvgEyBApH7ZmnXeKwTImG58I9+M83XG5JO8GjA25Ck4ri7HCYN05kVxjoJ6sTBFCg/yrWWpA794H5ijzKOzZgKY1+Uyy7Mb8xJV6IuUJerGKJO64YsntRl4CKjQdeen8JLWqRjQd0+mQmfu2smwbh40o74vcXnBnIBlk7X6UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIaPtzCu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3416df43cabso858252f8f.3;
        Mon, 18 Mar 2024 10:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710782554; x=1711387354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAzOS4Jg9xMuNGPCFRfi3Q3UsukUay6p1+JHj01+NW4=;
        b=eIaPtzCuRRSklWcM7LWPapOGHCwHH841OhJfVR2KF/mXlYp00ml2ma4+IvVSxluRsW
         r0LsmtM7z/bkICkx2f5V80GWF21ny/9nxhc44VDf2ifkoUb8TlYiikOEHjJpG/nCl4jZ
         Xl/igTi4abS2G98Hcd6urCHcpkwUeWR0SkS5RVUWiFeNBR1uK8E5wJWwJStRHqw5ZZAp
         tk8kw+KK07j1qXLy3w13zR4R9sU3jd3ordBlbKIlvD01cq61FZ5CkKBPuPP9IDRKIcmf
         /ioHJr9S8VSD0sJVx5gFSoH9KJySRwGVgyoMExcyCXZqA1MGNMBn1xp3dXeFHciJfKsw
         JgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710782554; x=1711387354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAzOS4Jg9xMuNGPCFRfi3Q3UsukUay6p1+JHj01+NW4=;
        b=ov+Rs/5XZfyK00lyUzJDfAxAAtWhyB6LVtMFRmRD7I1Uf2kwdA+BQ5vBmTN7467m+D
         s0ma+Wwf3+X9RH7g9X7OKyxwaFhTSZskGZ2DSUoq3TMCzOCz6Y+wUtX5QNg4VCvuQc7l
         TaczgX5GziIgxGy3xKqIZcGvKVrHEpDemUMGe6Ii8NvHFfXcOTvGgTmEjbY/jnJ/L52u
         YLsyPzQhEofZbOjYtP6zJdH+D8y4ffthJopUQEi3p+X6hzlJe7ROYsPO4yiojkyrEN3n
         sIQa/Rd6Y3ffXvmBCfSQfV4ISYTbGCCDw/ciabMcFdwHtfFqOaj/76gwet9RKta3NeWg
         hKlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4kvl1VQqiOZyCFNsxp+SeU5xYCMSM966Vx28zRQXlm0aAXlWRZs3pKPFpFu0rJ/GPgiiTXLspBVG4WO6mZBEkKbNK8CdFrBEkvUE+DgHbbQcNuYnwSYdx+1bKy4F+AIavAdw954DWoXnKDwHMmZv8QTOQsiWUBMJfcHFlMOtX7KrMMnmeDsmWiyNQ
X-Gm-Message-State: AOJu0YxbVOpMjC1LPqr41c5hxcD/olMacPO/Gj9dWwWPm7GTMW0VeaiW
	DikRLHFFfQzwvXgRHzWU8h3J8sOXzAPFZeHOhIZg2WibRg4q+V8RUJSqcCAo
X-Google-Smtp-Source: AGHT+IHBlekqgf8r1EBVAltwzeIiZ0jodOa0yPmzw/7zt3EWMRenT4/UGp/6dXvAAfRF++kLk3eAUA==
X-Received: by 2002:a05:6000:1e8c:b0:33c:e396:b035 with SMTP id dd12-20020a0560001e8c00b0033ce396b035mr8043260wrb.69.1710782554373;
        Mon, 18 Mar 2024 10:22:34 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:c23f:76ae:8149:291])
        by smtp.gmail.com with ESMTPSA id bv30-20020a0560001f1e00b0034180898569sm1140769wrb.72.2024.03.18.10.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 10:22:33 -0700 (PDT)
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
Subject: [PATCH v3 2/4] dt-bindings: serial: renesas,scif: Validate 'interrupts' and 'interrupt-names'
Date: Mon, 18 Mar 2024 17:21:00 +0000
Message-Id: <20240318172102.45549-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Add support to validate the 'interrupts' and 'interrupt-names' properties
for every supported SoC. This ensures proper handling and configuration of
interrupt-related properties across supported platforms.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3
- Listed interrupts and interrupt-names for every SoC in if check
---
 .../bindings/serial/renesas,scif.yaml         | 95 ++++++++++++-------
 1 file changed, 63 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index af72c3420453..53f18e9810fd 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -82,38 +82,6 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts:
-    oneOf:
-      - items:
-          - description: A combined interrupt
-      - items:
-          - description: Error interrupt
-          - description: Receive buffer full interrupt
-          - description: Transmit buffer empty interrupt
-          - description: Break interrupt
-      - items:
-          - description: Error interrupt
-          - description: Receive buffer full interrupt
-          - description: Transmit buffer empty interrupt
-          - description: Break interrupt
-          - description: Data Ready interrupt
-          - description: Transmit End interrupt
-
-  interrupt-names:
-    oneOf:
-      - items:
-          - const: eri
-          - const: rxi
-          - const: txi
-          - const: bri
-      - items:
-          - const: eri
-          - const: rxi
-          - const: txi
-          - const: bri
-          - const: dri
-          - const: tei
-
   clocks:
     minItems: 1
     maxItems: 4
@@ -173,6 +141,69 @@ allOf:
       required:
         - resets
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rcar-gen1-scif
+              - renesas,rcar-gen2-scif
+              - renesas,rcar-gen3-scif
+              - renesas,rcar-gen4-scif
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: Single combined interrupt
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,scif-r7s72100
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: Error interrupt
+            - description: Receive buffer full interrupt
+            - description: Transmit buffer empty interrupt
+            - description: Break interrupt
+
+        interrupt-names:
+          items:
+            - const: eri
+            - const: rxi
+            - const: txi
+            - const: bri
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,scif-r7s9210
+              - renesas,scif-r9a07g044
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
+
+        interrupt-names:
+          items:
+            - const: eri
+            - const: rxi
+            - const: txi
+            - const: bri
+            - const: dri
+            - const: tei
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1


