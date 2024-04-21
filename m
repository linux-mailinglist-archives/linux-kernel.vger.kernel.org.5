Return-Path: <linux-kernel+bounces-152477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C82818ABF0B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 13:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC21281019
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 11:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABBB125BA;
	Sun, 21 Apr 2024 11:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ba4BUY3O"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB12205E18;
	Sun, 21 Apr 2024 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713697785; cv=none; b=b8P4uzLd0ec8cyP4uAJGADeycf01B3T+gRs99JiiCIpfU8RpC+/LCb31BV60O56En7bIVEODDrTCELJlxC270XPx4YEtHvtgZvKtF4tik5tF6rXt8Gf0FHOIPL+vPnBD20ZpjEIz/YIauUxjTD9k52OiwVPRloMiGUN3CmY5XK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713697785; c=relaxed/simple;
	bh=4LIluELKsAg0RvjnTm13p6oqqf2Kl3p8f3JSIQo4YVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cYCJEBKqlm5ktepZCDXKJus8nhjomAudpQLuN8RhAfRrIl9WC35LY/xeUm8k0GZoYosE5rQX1faW3PMeueV7iEETXlb7oTWFB6JYPHFlceBsEDYlp+ofjX+vVVI7HV8PsJpppckWVW881UpLZFr3XBBvukRZwdsYW3ox9Q0fgUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ba4BUY3O; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e4266673bbso31106995ad.2;
        Sun, 21 Apr 2024 04:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713697783; x=1714302583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gCeM9ne1R4TNu8Re+QZrgQf9jfqwpZtPiiKgFbyNlW4=;
        b=ba4BUY3OLh2KrmlZqfTyasfhw4rBut5lVD1GhG6CHRKLLSK+yjMq2MSfEKl0HEQxCY
         2cIfEy5GUgjEjWrtnDNsCaZ0mPwXJctCKeADHjwFa5vaqj7V9jRR2MBLHP2mh8jIsQs0
         qJjZXObVPtTa6oBGPdi8B0QF/PVFjeO+lAb99UU1noypIePw5jXFv74Tc+D3WPnsGtRE
         WMmYGutNsuJELyhciKjQB1PC5y2xZcC8mgc6hyT4jND3jKtDCM/tYzQgYV5Fn7CH50mn
         gf1OQyKwnW+Qzdu0vYySDb6wkvT9wU9HhA/EGdLBiXNMVQZ3kQ4Yilr1hkr5WZpn3MHt
         /PJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713697783; x=1714302583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gCeM9ne1R4TNu8Re+QZrgQf9jfqwpZtPiiKgFbyNlW4=;
        b=NfgHeBj4wAvh3RYtqmZmfxaOTEK1vRcHvTYa+xVlaHeHoqoSEF3Tgimi5zNGCP/B5i
         2FBaDacrmbUiQrphJtiAmSTM9CQtUCAUALzfdGKTbrI2xSFmDJTTrwQDBjxZBPh41wsO
         ynzQhNC3Elgb8YhpaUtriHjnCMSavlmYg/803zOV7zOTthiZLHBffR3AwDxVzT/uG2mA
         WxkdOOSHOLAuesFfpS/iSxnZGX9kSIWyHqsGB2kgJICuIeCjqEzhToSDzQHDQE1Uorgo
         uC1yZO0Oi0rMsja04b8hO8dj+KqmuqaVyajmELgJvnfoJbE+pV38Zqs/YG6+lSeqIHni
         susg==
X-Forwarded-Encrypted: i=1; AJvYcCXoUuk+uOTpIDbRU0hy2IE1uTocvBF9LTVXbF0m4oe4HdJrQGCqg64HlHDjHg7JpRsrxHQgmkel2UzOFhcGsJ2YHYxUbI4KUUiVuIvAaqUOf0ItGpt3VIbl1DAW3qVQ5PopEn1NNYX94bjNYxu2gHYJOV1jFW5kgdo6Sh2gTGAfAAiwHkmDaUd3KhT8eWrt3uQMC2sZHMqVyxOT6hCrountQM0=
X-Gm-Message-State: AOJu0YyiAof1dqpH8ep4SSp/HbR7Vxf4KVwTzehYZ+XtM3V/6udV/g7D
	qP1IkQj+PgXWy6xZyD9OapOcBo80a8MXFGy8khF/aM9yMo2Xa62Ks7UOU8hUmq4=
X-Google-Smtp-Source: AGHT+IHyxcxKCNoIbIl6jQA5poxccSFgss/1TDc5IEDT+158XYAb96YfGxSAkztcPYCUhraYU1wpKA==
X-Received: by 2002:a17:902:d2d0:b0:1e8:32ed:6f6d with SMTP id n16-20020a170902d2d000b001e832ed6f6dmr7851014plc.39.1713697782482;
        Sun, 21 Apr 2024 04:09:42 -0700 (PDT)
Received: from localhost (ec2-3-111-32-5.ap-south-1.compute.amazonaws.com. [3.111.32.5])
        by smtp.gmail.com with UTF8SMTPSA id r11-20020a170902c60b00b001e54f250ca9sm6154435plr.212.2024.04.21.04.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 04:09:40 -0700 (PDT)
From: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: tegra20-ac97: convert to dt schema
Date: Sun, 21 Apr 2024 16:39:25 +0530
Message-ID: <20240421110929.139191-1-sheharyaar48@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert NVIDIA Tegra20 AC97 binding to DT schema.

Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
---
 .../bindings/sound/nvidia,tegra20-ac97.txt    | 36 ---------
 .../bindings/sound/nvidia,tegra20-ac97.yaml   | 80 +++++++++++++++++++
 2 files changed, 80 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.yaml

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt
deleted file mode 100644
index eaf00102d92c..000000000000
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-NVIDIA Tegra 20 AC97 controller
-
-Required properties:
-- compatible : "nvidia,tegra20-ac97"
-- reg : Should contain AC97 controller registers location and length
-- interrupts : Should contain AC97 interrupt
-- resets : Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names : Must include the following entries:
-  - ac97
-- dmas : Must contain an entry for each entry in clock-names.
-  See ../dma/dma.txt for details.
-- dma-names : Must include the following entries:
-  - rx
-  - tx
-- clocks : Must contain one entry, for the module clock.
-  See ../clocks/clock-bindings.txt for details.
-- nvidia,codec-reset-gpio : The Tegra GPIO controller's phandle and the number
-  of the GPIO used to reset the external AC97 codec
-- nvidia,codec-sync-gpio : The Tegra GPIO controller's phandle and the number
-  of the GPIO corresponding with the AC97 DAP _FS line
-
-Example:
-
-ac97@70002000 {
-	compatible = "nvidia,tegra20-ac97";
-	reg = <0x70002000 0x200>;
-	interrupts = <0 81 0x04>;
-	nvidia,codec-reset-gpio = <&gpio 170 0>;
-	nvidia,codec-sync-gpio = <&gpio 120 0>;
-	clocks = <&tegra_car 3>;
-	resets = <&tegra_car 3>;
-	reset-names = "ac97";
-	dmas = <&apbdma 12>, <&apbdma 12>;
-	dma-names = "rx", "tx";
-};
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.yaml
new file mode 100644
index 000000000000..e7ffa93eec30
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra20-ac97.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra20 AC97 controller
+
+maintainers:
+  - Thierry Reding <treding@nvidia.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+
+properties:
+  compatible:
+    const: nvidia,tegra20-ac97
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: ac97
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+
+  dmas:
+    minItems: 2
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+  nvidia,codec-reset-gpio:
+    description: |
+      The Tegra GPIO controller's phandle and the number
+      of the GPIO used to reset the external AC97 codec
+    maxItems: 1
+
+  nvidia,codec-sync-gpio:
+    description: |
+      The Tegra GPIO controller's phandle and the number
+      of the GPIO corresponding with the AC97 DAP _FS line
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - resets
+  - reset-names
+  - interrupts
+  - clocks
+  - dmas
+  - dma-names
+  - nvidia,codec-reset-gpio
+  - nvidia,codec-sync-gpio
+
+additionalProperties: false
+
+examples:
+  - |
+    ac97@70002000 {
+            compatible = "nvidia,tegra20-ac97";
+            reg = <0x70002000 0x200>;
+            resets = <&tegra_car 3>;
+            reset-names = "ac97";
+            interrupts = <0 81 0x04>;
+            clocks = <&tegra_car 3>;
+            dmas = <&apbdma 12>, <&apbdma 12>;
+            dma-names = "rx", "tx";
+            nvidia,codec-reset-gpio = <&gpio 170 0>;
+            nvidia,codec-sync-gpio = <&gpio 120 0>;
+    };
+...
-- 
2.44.0


