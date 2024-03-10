Return-Path: <linux-kernel+bounces-98273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5458D8777B7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 18:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFFF0B20E95
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 17:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A28C38F9B;
	Sun, 10 Mar 2024 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pps3yB/j"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459538485;
	Sun, 10 Mar 2024 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710091295; cv=none; b=r8vf0bFHV84za7R2DXonOmU5yljUQEK+GCl4i1/xziih487TPGCtH3lOjykUB345coG5ZutTg/hv/1yak5IvETbfxe6XW3UzLc0B9xWZ7IPIFdyScTJGhk80bhO2yxUEyn9iMiR2EY3MXARlhK6Vl839MPfykvHkFpakf0IWw9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710091295; c=relaxed/simple;
	bh=NjfINqP+akN7Lp2vYlpSmyvDSm4qfj4dzUVs9ziFcGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kz9TDYK4X2XPsIyASQT0FYoZl8VTfTomu1yOCcPm9N3EP+E1PXVfrmQQ3U+8hhTyR3DaxZGQL0VAcockAQHOj8IQWY0AXUQjLx085l25+wSasdWvL3PRGHCPS4xp6AGUBATKim7Io/5ACD6BEmkX4m3ih06AcWiYUP2jbwTSy10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pps3yB/j; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dd611d5645so20432065ad.1;
        Sun, 10 Mar 2024 10:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710091293; x=1710696093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=37N+z8r1KNMcdCEWN/3kPTY7hq4V3O6RsVqPfX/Ix64=;
        b=Pps3yB/jbX3ijDFJRYxleit/LNjCeHVOaygczWfiySJHKfwDBdlRjU8scyXgJE1KDC
         1LXuG83GoRBDZrZX/m/8JBfLkciqPpRXkTVVpdRk32O79UrV5r/329qekgxs5Tc54COj
         7+n57xusm893sOKFXHCmH4gShhjxDWxb/QRKRlJSOJwZWF1LbRbpFJaICXOdDKO15EnN
         K1ajsLWYy34e/LMrcdfS6qpViZ6Gd1J9FAer3CCNgS3Y6DlEjixh+2gIr7eTf0gVz6Ec
         pSzU8HFTqby+4B8aRikJgbEkAcmQluaP8uSW0OQFmVFCWStrwhw8YPEa6Yk6DQD0tgGM
         7hyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710091293; x=1710696093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=37N+z8r1KNMcdCEWN/3kPTY7hq4V3O6RsVqPfX/Ix64=;
        b=CePange6GNZHB0hwY2eM2TOhwfTNi23EVNdWVVjjyUIMIfXymxBLt7R/GpnlhLiOvi
         AWUymj6ItdSotFz2OJ3LuZfwXVa3srR2zg04jlYhhYVeMkjNUd2dQgeRdF9fKM8ltsqA
         d/Xy8RAqKmnXdKR5DGZJuTOMr3AP2B2mrnvvMvJgE7zxsWIl39yNb6sTtmSO5zWlMZOJ
         hq5oz/s5daT2/7gjv8vGWsj0+JtX/CYoSAxj5dDJZpxuQYsURX97ISGpIDMllD4DanLM
         4N0M3dlZP8lepv7YgArD+qmT9UNmgmCsLzNnL7tgFAMEshDA++nAibQikSAKpk52tI7E
         1Wng==
X-Forwarded-Encrypted: i=1; AJvYcCUudv22/R+3y37quf0vXdGKi0gAGevpi33VJj73Ze9ZeF6JB8y1BHoDb2G8MgwOYSun7Fb/kPNC71vKyfXP3TT3E88DIk5LONtODlC7WKInWh4QQpKj4UO3glnRBmzf1xsxbfAPQKe5rrRdfpQ0YoRd/1OpTiJsO44BlFKYP1EFrXw2Kw==
X-Gm-Message-State: AOJu0YwZYyfZME4bS7WAxQ/TQ7bHpCyOMJ2ydu06p4wbDckQeS0emL6A
	MKfK7wWrqAxJTFS2L77JMNOKRumAe4O3tlnYmSZEkLNwvoYcuHLI
X-Google-Smtp-Source: AGHT+IGH/tYzdl8P8qj1fQrdunhc5dPv7ab0pBMdmdv7iYxxDpiOEsJY4GP4iL5BlhEZODI85xTTrQ==
X-Received: by 2002:a17:902:e5d0:b0:1db:ed09:db98 with SMTP id u16-20020a170902e5d000b001dbed09db98mr6071427plf.12.1710091293479;
        Sun, 10 Mar 2024 10:21:33 -0700 (PDT)
Received: from localhost.localdomain ([115.240.194.54])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709026b4600b001dd79b9b5c7sm2793999plt.161.2024.03.10.10.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 10:21:32 -0700 (PDT)
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
Subject: [PATCH v5] dt-bindings: imx-pata: Convert to dtschema
Date: Sun, 10 Mar 2024 22:49:52 +0530
Message-ID: <20240310171958.96388-1-animeshagarwal28@gmail.com>
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
index 000000000000..85b18d26a834
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
+      - items:
+          - const: fsl,imx27-pata
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


