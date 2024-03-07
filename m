Return-Path: <linux-kernel+bounces-95488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB54874E3D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5396E282D60
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A870912C52D;
	Thu,  7 Mar 2024 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fo+YjDCQ"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EF1129A7A;
	Thu,  7 Mar 2024 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709812098; cv=none; b=Ld5FY5YTw5/ieKLmtMDKA3CY/nTIYnpfXCiGpnKF0PIl6S7aeud6efYysotbrcEcsYVtxBLYq/dlqf2gdwbNz8sTlRxWkhnyQ7htpe4Zfy0n0drFAbE2ZXcS3jPRpjAYlQCLnf9N8TB6LmHkpLr/emr2d7eOhMpQGJ0LCAwFdQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709812098; c=relaxed/simple;
	bh=p1e4tJNMl2RFCMrte2AszGEoRzNHGeM0TnyX8cSFV2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I3luVUeXgTysX4ofa+nCgOtEmZ90910ly9FvltLgsjpHx1nkqucmz4NLQ+QLNYEqdYkvFBYC5tAxzNUiwS8FgTRmpSzLqIkgd/iPTbr8Z50doCtug0k/PhXGuNUZq4s7QU4refu8qlJDG1zWoDe7nU+Eq5K2ck6zyn+rAwlHB+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fo+YjDCQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412fe981ef1so4696975e9.1;
        Thu, 07 Mar 2024 03:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709812095; x=1710416895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HdCRMTKRhqynPJO0vr+KIPrYHrZQvMYn+jwShMV7v90=;
        b=Fo+YjDCQPclstjGrOSppSZvjV9iIVogbbN+yo84E520nvQh44YUC3YnirTwXJHMYdT
         EC1ipNba7h8nMP1R/0P+By2ti0sEe+Ehs/jFX1CRb7dOEzdbNcUDuDifllO0bLeJigU0
         HfflVm+p7syr5tx++fwRmIANLLRbJivy4QsPBN7JNxnOGDWITQyALMNZiGg7dO8aZPPy
         tlB0GpGHCHr+3Ij20uK4nfLaTHxQ03ayMFy7B3fNT99j8xEXcnuCidmex1XV7lJ0JYGg
         sPtuiEF7kVuozdfUKjWu9X9U81gW32XYLJ2TneFVsuN6RXMT2sQ0hcsB9uDkywSoqVXc
         wtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709812095; x=1710416895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdCRMTKRhqynPJO0vr+KIPrYHrZQvMYn+jwShMV7v90=;
        b=p3jXY5aXK8W15Dtkz1drY6BAaIwX2HK7bCy+clSzgKZBxf3qdxER4NGCEpLnIrKDyS
         9rXYZVsdr+19W5ILYClUu4jcuKzdXWc7qVnn5gt0zJ9A9CtTGHmh7TiZJekui9fpl9ro
         wIHD5dw0nDG9S/MGOMknULxUKmTPXrCvOkJE7Hj98vcjqpzwqkbDzO6D9tiIpwN7o1Ja
         0+PYK3dYYSlC0THPeGGLnb2i5PVzOFFlw8B3K7AWUMpXOeu6hTUEVzzG+WlfpFnvnGeK
         CvmFdPJrQ08eC7KwEuUndXCIcvkBtOqF8QT2Xe+9mDI7RVESKWzFBZZHGulpkckamLIK
         kVpg==
X-Forwarded-Encrypted: i=1; AJvYcCVxQRpgIj2ZziMYiwjwY5ZJ5xIHb6vIMhrsDSCWFQmV+fnMcJbcTqnEwiTlCpTRwTCfeFSK3bQ9qhoaPO4dKcgu0Lpaiaml+O5TUp3pVXS9JRRISYNyyvDNr4dOAF6G/kzh3F09GeraQpJt5koRYNgzBAsjLxyRVP31yHcGY4E5ndFuxEFCgWhMsO5N
X-Gm-Message-State: AOJu0YzTHxoKSYzmHoPPuDYDEDPmj5MN0LD7Ed6OgGffjm2+r8GAkMp7
	ZX/PkEKMPG85Ml8IWGylIWNS5QUVmorRHVltz6ELqj1LINRT1how
X-Google-Smtp-Source: AGHT+IFHgnbyzOxpiE/NPYUNciYRrQC8bvPnKwv7h8vdfmxZdkKUBxJdS+wQAto8IoYEvVYfaahYzw==
X-Received: by 2002:a05:600c:4f91:b0:413:119:33e2 with SMTP id n17-20020a05600c4f9100b00413011933e2mr1328074wmq.14.1709812094868;
        Thu, 07 Mar 2024 03:48:14 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:fef2:3c1d:a816:65f7])
        by smtp.gmail.com with ESMTPSA id fc20-20020a05600c525400b00412ae4b45b3sm2401616wmb.30.2024.03.07.03.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 03:48:14 -0800 (PST)
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
Subject: [PATCH v2] dt-bindings: serial: renesas,scif: Document R9A09G057 support
Date: Thu,  7 Mar 2024 11:47:31 +0000
Message-Id: <20240307114731.34953-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
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

No driver changes are required as generic compatible string
"renesas,scif-r9a07g044" will be used as a fallback on RZ/V2H(P) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
v1->v2
* Added validation to check interrupts and interrupt-names count

Note, this patch applies on top of series [0].

[0] https://patchwork.ozlabs.org/project/devicetree-bindings/cover/20240307114217.34784-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 .../bindings/serial/renesas,scif.yaml         | 31 ++++++++++++++++---
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index 6ba6b6d52208..a9c60334d702 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -77,6 +77,7 @@ properties:
               - renesas,scif-r9a07g043      # RZ/G2UL and RZ/Five
               - renesas,scif-r9a07g054      # RZ/V2L
               - renesas,scif-r9a08g045      # RZ/G3S
+              - renesas,scif-r9a09g057      # RZ/V2H(P)
           - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback
 
   reg:
@@ -91,6 +92,9 @@ properties:
       - description: Break interrupt
       - description: Data Ready interrupt
       - description: Transmit End interrupt
+      - description: Transmit End/Data Ready interrupt
+      - description: Receive buffer full interrupt (EDGE trigger)
+      - description: Transmit buffer empty interrupt (EDGE trigger)
 
   interrupt-names:
     minItems: 4
@@ -101,6 +105,9 @@ properties:
       - const: bri
       - const: dri
       - const: tei
+      - const: teidri
+      - const: rxi-edge
+      - const: txi-edge
 
   clocks:
     minItems: 1
@@ -197,15 +204,31 @@ allOf:
         compatible:
           contains:
             enum:
-              - renesas,scif-r7s9210
-              - renesas,scif-r9a07g044
+              - renesas,scif-r9a09g057
     then:
       properties:
         interrupts:
-          minItems: 6
+          minItems: 9
 
         interrupt-names:
-          minItems: 6
+          minItems: 9
+    else:
+      if:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - renesas,scif-r7s9210
+                - renesas,scif-r9a07g044
+      then:
+        properties:
+          interrupts:
+            minItems: 6
+            maxItems: 6
+
+          interrupt-names:
+            minItems: 6
+            maxItems: 6
 
 unevaluatedProperties: false
 
-- 
2.34.1


