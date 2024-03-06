Return-Path: <linux-kernel+bounces-94687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC7D87438B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E4D284190
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6431D537;
	Wed,  6 Mar 2024 23:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXgBiSIg"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79881BDCB;
	Wed,  6 Mar 2024 23:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766681; cv=none; b=VaUb98jaEpZeea4gdg5rY3/2esXqyn4oWrrE/WD2//P3YJwUWVjyNBmsk+d5vwkTrkXZ+YbT2DKBBpBI6ru1McbnafnnqmDlQT29tTp5r5ayqfdKb8uBkT5NY+uHBhsbMBmoQs8K+BLS0ZkAHzFKFjrTYzQFMxAfO2GNxMdBTK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766681; c=relaxed/simple;
	bh=kkTeTRlQYHGubbxf8oTQAHLevd5HHkciwToNTxrHDEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YQv39fBvcYzaOR50MVxCyvOMTU4uU61VDUOJdAMevoo7IuXD983ii9Z9jc/JtQxOLZAdf2QmueGP5P/iEFbq6alIdcxbra+oGJ5hAmyp/qojLRYFbsrjbtC0YcfTMsO4WFXCFJzhBF/G/WT53WgwpJ9CQCiOsY4Vbm9UYmZLOT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXgBiSIg; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33e1d327595so76160f8f.2;
        Wed, 06 Mar 2024 15:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709766678; x=1710371478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lT8rwEzv9nZdvt9KnXNks4AhpZYHTgdm5IOnVdT/+A=;
        b=WXgBiSIg7MTR0HPIgLzoFh3ifHhq7xV8jHfCVjZFFHN0FWc3gipAIk8SrZ4E5904Xx
         N10o6t3zBUZpNJ0DDrujUuKND7OUx/pZDL0seKTAsrpmQQLW7YpXqmIkRm3d0hhNSvTK
         GX53/u6x1mrPKv4cSevvH7+qBDVArkjnwSytiAEMS7O1LqDZ0681G/jOEEGliJT8GO4M
         gX1FSJ9JrH+5UdaB5g7wfXsJMgkcasvJzMtRLK8GGyZkF1yQ4Pc8EMvjRQjPzLEULPTk
         8sbgPAXRV5K+QgVxywxy78Cd1liJqaOmch9hCxvsYcq+hE0vdSFZm5Gme8Zt7tCtt4lZ
         7VeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709766678; x=1710371478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lT8rwEzv9nZdvt9KnXNks4AhpZYHTgdm5IOnVdT/+A=;
        b=R5BeKYejzVbxr6sQCfv3xbymoNKjPQ2xJjWS6fs1ilcQ5SvclapVzVg6wRiQguSGFd
         gE8l83eDN7o8EIQn+obFDx4LtRW3mgScSOfwclz05/2dtcIyCp7okJ3vk+Rm8j8I1FE9
         DPstt4aHkKL6KlewjnkGa+8mIyNiUJjWKwC356S8MKCsawfbB8ojQUoHR7lXTl1DGzjN
         lMs8455ctAjtui68SP+4143zwwRLjECBRE+tUVNveZu7xgtmKV95AzVs93dfnjXu38jM
         4ZFA+yZaj3V5QrDgspIrgpzvL9OKHWN/km+jU3kNpg6IgCgB9pmbGsKP5I2nq5RVg7E7
         HFqg==
X-Forwarded-Encrypted: i=1; AJvYcCUZlZFrgIr6qr5YQUVr8DRjtWjUlIoqkMskc3HnqcPRCRVzbNlMB8NveVaK2zBvv48wgJUu4POIR4/LE5dBR1y2mqSRBg5U9bgGqgLtkGFWkDtxChxoZmp4f2zCw1IJOw7//gziJ0Hx99XQM9BY6UkVabasQQjuU5rLbLLFlDe7OTfKfHIf27lLnf5/
X-Gm-Message-State: AOJu0YzLGzPlHproI1e8vJFsoiQDLKep15VLhkVG/j0d+q41eXJV7yRB
	eJnyIYb4B1nll8PxmeVFbEfcO8l1anVl2WRsn/sxCYo4XSJzRGaJEDmwJFva
X-Google-Smtp-Source: AGHT+IEDoY5ntSzM3jzUQfSFOONRrhu7HqY/ObZb+Bqt9gJ6b+UOR0IYUTOE+xy0n7rlbPyiO2gQog==
X-Received: by 2002:adf:ce88:0:b0:33d:3218:3378 with SMTP id r8-20020adfce88000000b0033d32183378mr11609787wrn.20.1709766677869;
        Wed, 06 Mar 2024 15:11:17 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:fef2:3c1d:a816:65f7])
        by smtp.gmail.com with ESMTPSA id h8-20020a056000000800b0033d2ae84fafsm15328996wrx.52.2024.03.06.15.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 15:11:17 -0800 (PST)
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
Subject: [PATCH 1/2] dt-bindings: serial: renesas,scif: Move ref for serial.yaml at the end
Date: Wed,  6 Mar 2024 23:10:06 +0000
Message-Id: <20240306231007.13622-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

In preparation for adding more validation checks move the ref for
'serial.yaml' to the end and also move reset check in 'allOf' block.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/serial/renesas,scif.yaml         | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index 4610a5bd580c..af72c3420453 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -9,9 +9,6 @@ title: Renesas Serial Communication Interface with FIFO (SCIF)
 maintainers:
   - Geert Uytterhoeven <geert+renesas@glider.be>
 
-allOf:
-  - $ref: serial.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -160,18 +157,21 @@ required:
   - clock-names
   - power-domains
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - renesas,rcar-gen2-scif
-          - renesas,rcar-gen3-scif
-          - renesas,rcar-gen4-scif
-          - renesas,scif-r9a07g044
-then:
-  required:
-    - resets
+allOf:
+  - $ref: serial.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rcar-gen2-scif
+              - renesas,rcar-gen3-scif
+              - renesas,rcar-gen4-scif
+              - renesas,scif-r9a07g044
+    then:
+      required:
+        - resets
 
 unevaluatedProperties: false
 
-- 
2.34.1


