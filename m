Return-Path: <linux-kernel+bounces-98282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5C28777D7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 18:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C70281AEE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 17:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EA439ACB;
	Sun, 10 Mar 2024 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeO3Gz6E"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401D11D6BD;
	Sun, 10 Mar 2024 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710093191; cv=none; b=Vc93tiArdlXlAoRR/bSXADTH3vqh6OAsH1LMsaqXUbP8In8LcOoXm/XI9ah8TEOv/M9Wmbf5h1P8KlcdjPQFoC1ZXrqejaW6Lgg7J6KvPlT1v5eTvHbfkwBOt+O2Zqad/44Qu1auMMNeLXMgOIPh0k/mw1PruUKyKnCoQyVWpfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710093191; c=relaxed/simple;
	bh=PAEPg+/maxDYsnqqpjNNlC7+pfvlYT8sZpuckOLX2Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JEfEmE3348Xyk3+qvvn9AmtiVjpAgE3o60A/SfYxOxdXvbdtURQr/DC9hvzRba7WUIRH0BChPPreznmVvdurOGgMqDnSW2MWifz3SpQAHJ24TYYStjcqGY7AO9YjaUqE2gpdf8uyTMDU1qaZ4v/BPR8rsSRmAA+EoYyQUr/FVO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeO3Gz6E; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dd10a37d68so30672575ad.2;
        Sun, 10 Mar 2024 10:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710093189; x=1710697989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tS9N1ruJVI0BmOAihQAk3F4D+Z/MUY8XwkjThKFRoCU=;
        b=jeO3Gz6EqrCgTL2c9vylGkQXfCGgm4u3RKIxiG8UwmOS9ziJvXL31VA5htIn2msOpa
         u64Q1GV5Emc+GYmmiwbxBbQNPZCIZUGN71PGLttvhwQ9z/kbPbuxWO7F4HTh0HyjsUck
         dDMEAnG2hl8K9HD2rqPPUcLmL+vAWgIg1qSJc+j4r37kAgpd8tbyk63kOiOX+qups4bB
         Wr6iek/OufdSCNgEfM81Vxz4AccJGZy8OszHBsF5FgSTW7H1XGMd7tgsjlvj9sKa2hAX
         t7DcJcUZDLRJ5UDGvkHTjeuCR1bp4LQnVoRcwFMeIZeyqn5CJr09bcLh88VBpaq29BBI
         d6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710093189; x=1710697989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tS9N1ruJVI0BmOAihQAk3F4D+Z/MUY8XwkjThKFRoCU=;
        b=r/SQTXli/126AWR+R92U8cdXT9/zwFQGRIvN3/kkyXzb5zPib7DDbIUZ/SDSta6QJJ
         g/yWQRhRw/RH6ax6Ee+Uj+VWjgskEsvwEa43QeV5aDh18Q0Y727XeoVK/oxkb59U6btS
         YAej2ZL7J9vJWm7bK4TX62GBEw+WzLxuuv7kxWtqrX+gXPTDky4RTDoy/ZMHQEIkVhbA
         2kJw+FVF8/YYj7AnhqeDRtrVrEducbMlObYsqfUvl1kR75N1PMpsXwSS5eowreNRidyk
         ZX2TIiJdjH6fO9eVQWgPRhXZlQNxXMZAEiqbpuNuEp87+Un1K6GlYB20X3Qw5ABZex/D
         5s2g==
X-Forwarded-Encrypted: i=1; AJvYcCXLk5uCDEpSjqHT2ft14OPHTgtPFfSqkF0J1pzSl+wWh1gZxPZdQaqC6nvXLYqrjQAUB06b/b7AJnoYYRT2+fauRcXnySLhnxS2/2vob2ThwTBuDngfDrlWSU63pnqTZQ3Yazze4mpMkqYSBVX+tiT8VS9Wb/3ryoeZYSvDXbL+XhUh3A==
X-Gm-Message-State: AOJu0YyXSmoMkLYhKk4kP0682PdvlfWmEXr+nFi+EFGkwoBIrWIjRAmZ
	hW8nYnG4kEiAOEooxsiyVKZnVev0RE2N9L0dJUvzcEdScF1N0UyB
X-Google-Smtp-Source: AGHT+IHHarjmbSJAfp4+wX7aP9GbwqCXzb3OwiyyKq/kCEzWGSJ0ZTZGva24e7VBNgg2V0JnOm1v0w==
X-Received: by 2002:a17:903:22c5:b0:1d8:f072:ec9f with SMTP id y5-20020a17090322c500b001d8f072ec9fmr5859755plg.28.1710093189412;
        Sun, 10 Mar 2024 10:53:09 -0700 (PDT)
Received: from fedora.. ([2409:40f4:12:62d1:ef0e:a60d:25ad:394c])
        by smtp.gmail.com with ESMTPSA id g22-20020a1709029f9600b001dd61965137sm2902050plq.304.2024.03.10.10.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 10:53:09 -0700 (PDT)
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
Subject: [PATCH v6] dt-bindings: imx-pata: Convert to dtschema
Date: Sun, 10 Mar 2024 23:22:13 +0530
Message-ID: <20240310175217.20981-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset converts imx-pata bindings to DT schema.
file name is changed to fsl,imx-pata to follow vendor,device scheme
imx31-pata and imx51-pata are added in compatible to ensure this node compiles to
imx31-pata.dtsi or imx51-pata.dtsi
oneOf is also added to allow the usage of imx27 alone.
Cleanups are done in patch 6

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>

---
Changes in v6:
- removed items before const due to single element.

Changes in v5:
- added oneOf in compatible property to allow the usage of imx27 alone.

Changes in v4:
- added fsl,imx31-pata in compatible property as enum
- imx31-pata was not listed in compatible in original txt binding
- adding imx31-pata in enum ensures the node compiles to imx31.dtsi

Changes in v3:
- added fsl,imx51-pata in compatible property as enum
- imx51-pata was not listed in compatible in original txt binding
- adding imx51-pata in enum ensures the node compiles to imx31.dtsi
- fsl,imx27-pata is added as a const to ensure it is present always

Changes in v2:
- fixed style issues
- compatible property now matches the examples
- fixed yamllint warnings/errors
---
 .../devicetree/bindings/ata/fsl,imx-pata.yaml | 43 +++++++++++++++++++
 .../devicetree/bindings/ata/imx-pata.txt      | 16 -------
 2 files changed, 43 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/imx-pata.txt

diff --git a/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml b/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
new file mode 100644
index 000000000000..c108a4b6636a
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
@@ -0,0 +1,43 @@
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
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx31-pata
+              - fsl,imx51-pata
+          - const: fsl,imx27-pata
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
+        compatible = "fsl,imx51-pata","fsl,imx27-pata";
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


