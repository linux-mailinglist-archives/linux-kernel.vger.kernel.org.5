Return-Path: <linux-kernel+bounces-111641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9D3886EF0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02471B24300
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E884953E3C;
	Fri, 22 Mar 2024 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+AzHnAD"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5695C4DA04;
	Fri, 22 Mar 2024 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118708; cv=none; b=Xn43K1drMGUe8UbNDwx/HCqVGYIfxeaxc3IvhiHY0NYZr9RLn/lUd0SfQ6MmubWdVGBVK0npWycjjfIRR0GE44NLWJSBjFWaiuxlnR+BYdmWZS1S2kEhqBNTvr6IjMUsgZvBdYYSlFZrTeWhqwB4qJapomTA5vt88ixaNQQaHh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118708; c=relaxed/simple;
	bh=nQMrjmx7lgvEYfRwPyMU/m3B5DVzZbErmWc3hp0SIdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ToAQsa08M1XGjdeuprGdzznhTILTOpU/GfRlUyNNLRgQNCXT9i1PuuM8dMlTWqzipzWFOI/mx9FPJYh2asichELQwtCQlgYLUHeQSbiEKSPvGllvpKqsMMbxjt+NOvRfCjGZbmQTVajumuxW3+7ydhkN/9Bi+8DNV3RdB+XT5Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+AzHnAD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4141156f245so15909135e9.2;
        Fri, 22 Mar 2024 07:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711118704; x=1711723504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=730autSsxHiNL+j8Su0BEnmYSpQjBiOSWmu8ipKoYuM=;
        b=g+AzHnADdT+qrj6Jc2IsLiz5p1t9dGCpVFxYUH68uKtiqBoVtJhmums9SZSGn6subr
         2XcuOxCTfXWXaq24bPmJMOSC74uRO/bGpp88lX2ZsrUXN8WnbFeYaVwDa0Y4jutAOVF7
         OicMXH66Pp6flEtLQSriQ37ZHcxrguMLnvvxibzrliuJncn7PD3vpbk02P6OrV6qpp6L
         oEVehc9kI+VRsygF1ikDTQoJB2SYii3L50cWr0/J9OacyQBHFK6JQ9W953+jIRsUf8KK
         dpW87QNk+WCGuLi0DXi5vuBllceSYn9fAWwJi2xreu5jWTsa4euq6bfe+qne7ZuDpvoC
         xT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711118704; x=1711723504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=730autSsxHiNL+j8Su0BEnmYSpQjBiOSWmu8ipKoYuM=;
        b=KD7r6UfEZvLadLjuPKOoL+58yCC9RdFCDrb9klXbLuV9ixlYcEt/Kuj0RM9Rl/cNnU
         v6Fjs6ABep6nP9A5xqTmJ9Jpgk3Af04HImMVjwN2gZjECpdjdNKnbqKeVaUzt3JfCJUo
         hPbo2JVlK2VqtfZUbq2yfnCTT7XGcwksIG2UgdY2xA4ycQuwCh89Fb8m2ISpbaF0TGjJ
         nYEFQuHHdhELhLAWWL22HHjL9am2Z+shtujox/rP3mfhS2kciQMOPH68wSC3IJhtXtqO
         xYH0ycfWq9I3sAksoifMtHpxJVrlk71QRFH5Zq6pxGShShfysHS961ATJrC7MsZRsjkk
         x9CA==
X-Forwarded-Encrypted: i=1; AJvYcCXtlIdTLVgLqJZSa7w29QgSLfAAS/6Y8Oy4CI0Cr/qKetxZweaThu43aiyo1OwASr1FSc+wLlKrzKFOfieZ0DO5rWMxQT5nWt9i7SPgqU0R7XLB7iuqJbQ7cWL+ApDAflz1hCJo4GfkBSy8Z0GidWy44NijO6a3gau6SVs3SYE09UJDNRq8NTGE35SE
X-Gm-Message-State: AOJu0YxjWBT2+F3VJkgZP7unCtrvWMxh7lGbpCdbIb8WTdXQ9sMh+FHQ
	vQGFvT1imM8WLQzvSKQuR+5TDJr3RqWJYK3hmVIYBfWYIwPa1HwR
X-Google-Smtp-Source: AGHT+IFt3u0l3sCLK1UPGdOdEjuEY+q9T7jOioz7zsCtUYJEa2Gsr1vYuNcs4ULg4z9cXjzTf99gsA==
X-Received: by 2002:a05:600c:1f81:b0:414:a6d:52d8 with SMTP id je1-20020a05600c1f8100b004140a6d52d8mr1737187wmb.17.1711118704327;
        Fri, 22 Mar 2024 07:45:04 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:7b89:721b:d6b0:d7e8])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c45cf00b0041466e03e55sm3911117wmo.0.2024.03.22.07.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:45:03 -0700 (PDT)
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
Subject: [PATCH v4 2/5] dt-bindings: serial: renesas,scif: Validate 'interrupts' and 'interrupt-names'
Date: Fri, 22 Mar 2024 14:43:52 +0000
Message-Id: <20240322144355.878930-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322144355.878930-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240322144355.878930-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

This commit adds support to validate the 'interrupts' and 'interrupt-names'
properties for every supported SoC. This ensures proper handling and
configuration of interrupt-related properties across supported platforms.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3->v4
- Reverted back to v2 version of the patch.
- Used suggestion from Krzysztof for interrupts
- Restored RB tag from Geert

v2->v3
- Listed interrupts and interrupt-names for every SoC in if check
---
 .../bindings/serial/renesas,scif.yaml         | 73 ++++++++++++++-----
 1 file changed, 55 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index af72c3420453..eb2aa5e75e02 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -86,11 +86,6 @@ properties:
     oneOf:
       - items:
           - description: A combined interrupt
-      - items:
-          - description: Error interrupt
-          - description: Receive buffer full interrupt
-          - description: Transmit buffer empty interrupt
-          - description: Break interrupt
       - items:
           - description: Error interrupt
           - description: Receive buffer full interrupt
@@ -98,21 +93,17 @@ properties:
           - description: Break interrupt
           - description: Data Ready interrupt
           - description: Transmit End interrupt
+        minItems: 4
 
   interrupt-names:
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
+    minItems: 4
+    items:
+      - const: eri
+      - const: rxi
+      - const: txi
+      - const: bri
+      - const: dri
+      - const: tei
 
   clocks:
     minItems: 1
@@ -173,6 +164,52 @@ allOf:
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
+          maxItems: 1
+
+        interrupt-names: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,scif-r7s72100
+    then:
+      properties:
+        interrupts:
+          minItems: 4
+          maxItems: 4
+
+        interrupt-names:
+          maxItems: 4
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
+          minItems: 6
+
+        interrupt-names:
+          minItems: 6
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1


