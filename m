Return-Path: <linux-kernel+bounces-97947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25720877224
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 17:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98721F215BD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 16:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7C14595A;
	Sat,  9 Mar 2024 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1gbajLT"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7883C2030B;
	Sat,  9 Mar 2024 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710000489; cv=none; b=RktpiGi8jkZLvlCHLlTbl8ujLo+quiduRU3n0tAACQUEDinzSOV3RnNx1r1ySCB46Jc06LaATM3/uMQizO3b57OWO0CRAeJMklMKF4ndlXBnMTikXqFUHgikRf4guYtpEyw6UqlaHuZRGwJnCe8juwawnuSlfSkv1AZzKgiWfNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710000489; c=relaxed/simple;
	bh=QGwTGd/TaR77dn4aQ/0D8foMz+86+hImvonQq6+yMls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pa157JUOYbiAewzwZc/b7z22b0idQUn6zXCP4EzvyqU7I8jXJsYMm7HxHMfIAC5f9lyWn6kNbR+E4En5Tn/Tn+rXZACBCGyW3ypOVT4z7WO9ikD0yEkjjnsKQzOzLw2iBrto6+Y0iDPwwmwD4zytV4MgzGuiZn49W+t7cihaqgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1gbajLT; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29b9f258cd9so1811665a91.3;
        Sat, 09 Mar 2024 08:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710000488; x=1710605288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GqlhDy46i3V7tyjUGg2eME879GebKkwNCL+NAebQcd8=;
        b=V1gbajLTL58o30bQKxn7LpknA/dRTcXOaoZLgqpxvjTQaMFb8WkbD/tCaJeKXcIOFr
         bwcdk3cX4kHb57lfn6nG9g/zuUYToBxnBlobk5SMdf9JUzRFvLURpCPZ0iQCtCz6W86N
         EoVZaLj1bMN2a2/uq/gb9/KrLh5fGFL63bWUogxqTwCLfX1WpIxPyMfpc/bX2GsepIVD
         mcUCsMHEmIt9VC4BqbD8us8P8caaQlji14Kqt672JLg6xfHxMtltJSPVLoilTe7x46li
         i0chNZ4ZquDiOK0Gd9iAThPFv6sbmhTjQXcN5+Bn3OKv8f71joCbHyCrf189lU6RQ5jw
         WqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710000488; x=1710605288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqlhDy46i3V7tyjUGg2eME879GebKkwNCL+NAebQcd8=;
        b=cbIQOUrWRgR49sgdeKsEkxPFOoFlHiLugcAuEG6KLxszH1gmPSkiardSp08+TD6Jpz
         qLEEDmeenSZkpdkIF0CTovN+H3tITatEaS7PW8+W4MYixwjvxRXLJ32BJWW6pS00NV9t
         O6X3N1iulP8WMg7Zv1DN+H0Jp0QknWJ1NuIAo4kxCtpJR5V5Iy5aeQPYbTGW7Wi/UUP4
         Uk84svR7sJjCg1FTk94TqXaIep0jOgoF3CfQPqymavGuxWQ4ViqVDt6neaVA7eGQ1CiP
         +vOyXwiX8vIA6wzOYhPaZL2DTXzw9oGfZJqjisfVOY1A1Wbw8EmoIkqVrnMhQ2PQLM+i
         zShQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaFrSOmt0gDthPT+ZOvH9VQgfX3UdAINKK2CIJsXFsmDxHZXWaCRpfLxIc1QaG/eIH58ZS7b2TtdSYBYSZny/zGLhR9OoMj4eTk9d+UQyFmFfaFRIyAtjNGJ8LZUFxm3t/uUDbot2WmhwELSjR4ZF0JsOZK6oeLUB9Yv1/jPGj4tn/Ww==
X-Gm-Message-State: AOJu0YyaF2XdaAwLD6odcwtAsBlZTTpn+z2rmlngzXMPtlB1BoXr/PoQ
	8PsJ2/LLEEAiPeLIFmCKtbH21hm+f3Jgy8IkLI+BLzFEiJNOUJgq
X-Google-Smtp-Source: AGHT+IEnYggkndkwsXdhE96+Jbwmg9joVTgcGCl0WyEJGjx6BM7+WU9Qf2K31jPLG+hz0JXlD7JtOQ==
X-Received: by 2002:a17:90a:4607:b0:29b:7244:c4eb with SMTP id w7-20020a17090a460700b0029b7244c4ebmr1435519pjg.42.1710000487659;
        Sat, 09 Mar 2024 08:08:07 -0800 (PST)
Received: from fedora.. ([2409:40f4:3a:d8ab:6980:be5b:99c3:fb12])
        by smtp.gmail.com with ESMTPSA id fu2-20020a17090ad18200b0029abb8b1265sm1392507pjb.49.2024.03.09.08.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 08:08:07 -0800 (PST)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: animeshagarwal28@gmail.com,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: imx-pata: Convert to dtschema
Date: Sat,  9 Mar 2024 21:37:36 +0530
Message-ID: <20240309160741.54096-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the imx-pata bindings to DT schema.

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
---
Changes in v3:
- added fsl,imx51-pata in compatible property

Changes in v2:
- fixed style issues
- compatible property now matches the examples
- fixed yamllint warnings/errors
---
 .../devicetree/bindings/ata/fsl,imx-pata.yaml | 40 +++++++++++++++++++
 .../devicetree/bindings/ata/imx-pata.txt      | 16 --------
 2 files changed, 40 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/imx-pata.txt

diff --git a/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml b/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
new file mode 100644
index 000000000000..265ea80434e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/fsl,imx-pata.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX PATA Controller
+
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx51-pata
+      - const: fsl,imx27-pata
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: PATA Controller interrupts
+
+  clocks:
+    items:
+      - description: PATA Controller clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    pata: pata@83fe0000 {
+        compatible = "fsl,imx51-pata", "fsl,imx27-pata";
+        reg = <0x83fe0000 0x4000>;
+        interrupts = <70>;
+        clocks = <&clks 161>;
+    };
+
diff --git a/Documentation/devicetree/bindings/ata/imx-pata.txt b/Documentation/devicetree/bindings/ata/imx-pata.txt
deleted file mode 100644
index f1172f00188a..000000000000
--- a/Documentation/devicetree/bindings/ata/imx-pata.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-* Freescale i.MX PATA Controller
-
-Required properties:
-- compatible: "fsl,imx27-pata"
-- reg: Address range of the PATA Controller
-- interrupts: The interrupt of the PATA Controller
-- clocks: the clocks for the PATA Controller
-
-Example:
-
-	pata: pata@83fe0000 {
-		compatible = "fsl,imx51-pata", "fsl,imx27-pata";
-		reg = <0x83fe0000 0x4000>;
-		interrupts = <70>;
-		clocks = <&clks 161>;
-	};
-- 
2.44.0


