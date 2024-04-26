Return-Path: <linux-kernel+bounces-160442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3298B3D8A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603841C24F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A34715B0FB;
	Fri, 26 Apr 2024 17:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9ZPMW0G"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6763924B21;
	Fri, 26 Apr 2024 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714151025; cv=none; b=p9nFLPZJ/RBPjps0TYxJv1wauMWGhVM66tfiUNyEdFjUZqSlqPxOsN/gjDZACeLS5whR9sftCYUiHiaXVWC3YgF0Av1IcNcBhZj2iz06+jBpLfEi/DXiAqNLMHnTc75I7xtx1r2Pt12ONy84IEYx9+lNSYZZRcyC48fuWiOJG+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714151025; c=relaxed/simple;
	bh=E5Zo0clvt55KvUvDKEImazN2BO8g7JyqxoRuWQ3jSVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CVRCvGA8/7uC9OxkHSlvoWbERd/4Ly7+5VDzAase0MiWZzIrQS1ZyAjbokaQs3rsw2+KOHfhJXzed5f/JLEXuutNzhRpIv9jz+hRdJNk1/+bKCzsG38Uc91U+GV226fvQPnwrV3ozQXM5IGsAU0xRb1OVqB3IgoNhJQR3RuwD0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9ZPMW0G; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so1634284a12.0;
        Fri, 26 Apr 2024 10:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714151023; x=1714755823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sv58Qd5ksYyhASH2QCPLwEVVVgnFfv8OH/VM1sHFeck=;
        b=B9ZPMW0GDTQCMIRczKzxuPN6HXJWO+R+c0htN3vLm6cBgWCrPOvREXurOSjwpa4nZ+
         GP52eVtWC+PlvkGEgCU1x3IlHpgNIbXz9xh6MfsUFqX0VCdp0rgu/biS8GXTzY5U6Fsa
         dChdgXU3eFkW2GlNui5KBYnYqhz+oWaC8ZGQJHvY5thWX6U3G4Jx4InwLWkTlKOrr0iL
         XsZSPP2ndKf8vuHxHNAvZ6HSErVYzrHvv5XkPDHBaovwzUcDjJRrNhORos0mnuXXmWSk
         32HOvaksHtkc4WqHUWfIdG54juvY/47/s6VDKzEyacN63JnXNUHg9de4b/iBA6E4I0DL
         4r9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714151023; x=1714755823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sv58Qd5ksYyhASH2QCPLwEVVVgnFfv8OH/VM1sHFeck=;
        b=t7aGaMVbTozerWNrMI3U8cSC3EI5VP3RitR8K0+QAsO8S/L4s0vQ3g2Z4MaDHfHsYa
         m/iZqiwjhqEtjTUAZswA+gPjOuECMBHUV+KvKwa2hSjBr9CPNHAtftWJWE6xtgmF6GWm
         WoXIaJLFV0Kryj8DtGe64y0Y3sVKgTJNUvX9f2qUNapHk67Ktxd1AXnWZpPTDzXJmiL6
         owBaZQNMvGbe44GppV+epcKYTrTfXa0KQvjrG63t/spdXgKuOz66mf3eAoTW2kbtk7X6
         HrDzrxkwoqg2Zi/lJSL6+2LAOD8RpmV5BzD0id2JYhw9BMo1t5tZ1CyXOima9uHFRRW/
         8a8g==
X-Forwarded-Encrypted: i=1; AJvYcCU7qB7/bIeUA4UXwCfs2Ef+ZnJ5gu4U57pJ1T+6CsgYtuSHbsN9aAcg4uaFRiWAGNOT5Js5AQjKeBmQaJ0VS7/BN5O3WR9hGr1YARn6YFNL1JIQYp4+ZIJ5PTQ4PLWgbquYzbPEOsYeC78YnMpQHjN/zwLR3VNKacsQiaNoH1sxOKAcCxABLiQf8Z8CkTymRiCdO6iCqzsBvHlx06hig1oJC2A=
X-Gm-Message-State: AOJu0YyViMM7Y2n8JLuW3ebdMGceOkJXnZ8SiIHt2PGhMO+TIn7UXlUz
	mcnOPIbA6Qi85Ev5yRL95leMfChGxw7HGfth7rQtWCIOTHvZnC7Q
X-Google-Smtp-Source: AGHT+IFMceCZFif0B91YDqZNtx0yyR5xJSzTuZu5RE4WXIT/MpFQHon3MPffBxjB1nXZzggujq4OYw==
X-Received: by 2002:a17:90b:3614:b0:2a3:acc:a97e with SMTP id ml20-20020a17090b361400b002a30acca97emr3427120pjb.20.1714151023400;
        Fri, 26 Apr 2024 10:03:43 -0700 (PDT)
Received: from localhost (ec2-3-111-32-5.ap-south-1.compute.amazonaws.com. [3.111.32.5])
        by smtp.gmail.com with UTF8SMTPSA id x6-20020a17090ad68600b002a20c0dcebbsm14976192pju.31.2024.04.26.10.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 10:03:43 -0700 (PDT)
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
Subject: [PATCH v5] ASoC: dt-bindings: tegra30-i2s: convert to dt schema
Date: Fri, 26 Apr 2024 22:33:18 +0530
Message-ID: <20240426170322.36273-1-sheharyaar48@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert NVIDIA Tegra30 I2S binding to DT schema and
add "clock-names" property used by multiple tegra i2s blocks
in arch/arm64/boot/dts/nvidia/tegra132.dtsi. This is not a
required property by the binding.

Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
---
Changes v4->v5:
- removed redundant example
- removed redundant compatible

v4 : https://lore.kernel.org/all/20240425153045.49939-1-sheharyaar48@gmail.com/
---
 .../bindings/sound/nvidia,tegra30-i2s.txt     | 27 --------
 .../bindings/sound/nvidia,tegra30-i2s.yaml    | 67 +++++++++++++++++++
 2 files changed, 67 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.yaml

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
deleted file mode 100644
index 38caa936f6f8..000000000000
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-NVIDIA Tegra30 I2S controller
-
-Required properties:
-- compatible : For Tegra30, must contain "nvidia,tegra30-i2s".  For Tegra124,
-  must contain "nvidia,tegra124-i2s".  Otherwise, must contain
-  "nvidia,<chip>-i2s" plus at least one of the above, where <chip> is
-  tegra114 or tegra132.
-- reg : Should contain I2S registers location and length
-- clocks : Must contain one entry, for the module clock.
-  See ../clocks/clock-bindings.txt for details.
-- resets : Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names : Must include the following entries:
-  - i2s
-- nvidia,ahub-cif-ids : The list of AHUB CIF IDs for this port, rx (playback)
-  first, tx (capture) second. See nvidia,tegra30-ahub.txt for values.
-
-Example:
-
-i2s@70080300 {
-	compatible = "nvidia,tegra30-i2s";
-	reg = <0x70080300 0x100>;
-	nvidia,ahub-cif-ids = <4 4>;
-	clocks = <&tegra_car 11>;
-	resets = <&tegra_car 11>;
-	reset-names = "i2s";
-};
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.yaml
new file mode 100644
index 000000000000..89c3c6414ab1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra30-i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra30 I2S controller
+
+maintainers:
+  - Thierry Reding <treding@nvidia.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - nvidia,tegra124-i2s
+          - nvidia,tegra30-i2s
+      - items:
+          - const: nvidia,tegra114-i2s
+          - const: nvidia,tegra30-i2s
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: i2s
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: i2s
+
+  nvidia,ahub-cif-ids:
+    description: list of AHUB CIF IDs
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: rx (playback)
+      - description: tx (capture)
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - reset-names
+  - nvidia,ahub-cif-ids
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra30-car.h>
+
+    i2s@70080300 {
+        compatible = "nvidia,tegra30-i2s";
+        reg = <0x70080300 0x100>;
+        nvidia,ahub-cif-ids = <4 4>;
+        clocks = <&tegra_car TEGRA30_CLK_I2S0>;
+        resets = <&tegra_car 30>;
+        reset-names = "i2s";
+    };
+...
-- 
2.44.0


