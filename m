Return-Path: <linux-kernel+bounces-94688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D649187438F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF301F26CA9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64FF1F933;
	Wed,  6 Mar 2024 23:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWTozTHm"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9401CA9E;
	Wed,  6 Mar 2024 23:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766682; cv=none; b=nFvMeSXZJe8zTlk00oYSZxbkfpUXt3kKQZzZO0BhUpPDkGd/qsANV890oDgiCX3rMzQK5H/DT96akHe4lcLxLwe+Ki7vYh0AZrGyKlK5QSLXXuvUWSLmicTWQ7N3tnPmmZSPLWf3TZ649nlEysDAjss8OoDifsmMc+53DUlpsiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766682; c=relaxed/simple;
	bh=txRoFjCj76TPMuWlc61maImG4mA2l8HcjBunpnjoxZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ai5VPgpkFLjhaILMWpuHpSOMvzcfDp2m1h1lorGhlGCd9I4BaRSc3n5Psr60vWbn4VbfR6+PMbsC7AAxFRkoFeexSnnmYdOFODPFNZpAIBZVpRloxOltnibt19x1IWl3MhCXD1/MTU5UWsMm4wQ5ImGBihVIEf7FrVhttoIg+sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWTozTHm; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5133bd7eb47so294270e87.3;
        Wed, 06 Mar 2024 15:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709766679; x=1710371479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPeLsfmoFyBpyxACO+p/2P02zy9oWm1FVbXBx8sEC2o=;
        b=LWTozTHmz2pxfGne0iFdniuf6QZBofKfRON89qxMHoGG6LMsm0FPUsdk+jZQDwRtIE
         qcIdYxHq6nv65Cml+H2f9gp4Acx1ZxFJta9lEYbay/CLDbj84u3LtLUZNoAwl8tOpF8U
         yMGCYK7sb9QsO2Vw2H4PbGlfcpOJjKnI61X9W/+LHqBNRAGJbQSXjqehVCVtpOtVZYc1
         D5yxAAxhfflwto4IFwbWmFFbv8drbgG6z1TLH4u8D0qNYk8bS/hHkTdVKVg172spym4n
         SU8TpWgge6GKNav2w/UYo6uKGqRUdH64Nzfw/qUQ0uapkmFZoZvnF65tVpHWzT8yJ9ym
         j73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709766679; x=1710371479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPeLsfmoFyBpyxACO+p/2P02zy9oWm1FVbXBx8sEC2o=;
        b=QsdJGHGdt2rYH0A9o1DSjU2KY0qAHZNT0/+bw4SSsKiu5AFvTNsKybYBL1Boo8UZbH
         C1lNpSH/ToyRpw/zG1COoGRttUidL0fG0baLkyCA73dgF6HURUDR1CUPFd3CLGJDO5Mr
         heBCOqdoryekeSliMd39sW7OAZKMipoK/VyklISZGoDPhkp9BVEHaTKsQt9SLyzTY9w0
         Wm7TcI7ndUCMgDYkvTalPxwoHWbaLnYn/ybl/pQQMq6H0RQndEQbc+P+jg9VdYCFhEcH
         KcKVwfceFLdWLgDPyUNpMm4CIF6ab35wjKgm8p1TYX+baPgzH9fr/WTLV35/93C4SOMi
         a8lA==
X-Forwarded-Encrypted: i=1; AJvYcCUesiMzTZmePxfgWFCdhQv5mDfMcWqEMtr9xaktIcyajARFIZbakJ4kzRUTg0aGHF/kvWQKh96Hjep9cwLsVZs+DWsTcr81JwcdSqqaC/1uKyxS4la1mPf4W5DUMDlY8Q9ooJiAY0fnTMi9saoNCEsG51sG5P8pdsHINCmscyo7bXFinxHKyZ6kmnBW
X-Gm-Message-State: AOJu0Yy4We88SHfEr01MgfVjP9fN765UMoVkMN0MKK89FfXBSmT73BaF
	Ow4M2g7RgIKN8047ZcIZUpWlPvcX5anRWxxHg4sd8PnSnUhd6LCR
X-Google-Smtp-Source: AGHT+IGimgoniuZJyVX5rCtthLWcKxUS+dCcDaAZ++m5jL1TIwzBf7x6ZTFIdjb+OumOZ8WgkWYIYA==
X-Received: by 2002:ac2:4a85:0:b0:513:5a3c:e8cc with SMTP id l5-20020ac24a85000000b005135a3ce8ccmr241086lfp.19.1709766679343;
        Wed, 06 Mar 2024 15:11:19 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:fef2:3c1d:a816:65f7])
        by smtp.gmail.com with ESMTPSA id h8-20020a056000000800b0033d2ae84fafsm15328996wrx.52.2024.03.06.15.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 15:11:18 -0800 (PST)
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
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/2] dt-bindings: serial: renesas,scif: Validate 'interrupts' and 'interrupt-names'
Date: Wed,  6 Mar 2024 23:10:07 +0000
Message-Id: <20240306231007.13622-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306231007.13622-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240306231007.13622-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
---
 .../bindings/serial/renesas,scif.yaml         | 117 +++++++++++++-----
 1 file changed, 85 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index af72c3420453..1a5f4568ae4f 100644
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
@@ -173,6 +141,91 @@ allOf:
       required:
         - resets
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,scif-r8a7742
+              - renesas,scif-r8a7743
+              - renesas,scif-r8a7744
+              - renesas,scif-r8a7745
+              - renesas,scif-r8a77470
+              - renesas,scif-r8a774a1
+              - renesas,scif-r8a774b1
+              - renesas,scif-r8a774c0
+              - renesas,scif-r8a774e1
+              - renesas,scif-r8a7778
+              - renesas,scif-r8a7779
+              - renesas,scif-r8a7790
+              - renesas,scif-r8a7791
+              - renesas,scif-r8a7792
+              - renesas,scif-r8a7793
+              - renesas,scif-r8a7794
+              - renesas,scif-r8a7795
+              - renesas,scif-r8a7796
+              - renesas,scif-r8a77961
+              - renesas,scif-r8a77965
+              - renesas,scif-r8a77970
+              - renesas,scif-r8a77980
+              - renesas,scif-r8a77990
+              - renesas,scif-r8a77995
+              - renesas,scif-r8a779a0
+              - renesas,scif-r8a779f0
+              - renesas,scif-r8a779g0
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: A combined interrupt
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
+          items:
+            - description: Error interrupt
+            - description: Receive buffer full interrupt
+            - description: Transmit buffer empty interrupt
+            - description: Break interrupt
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


