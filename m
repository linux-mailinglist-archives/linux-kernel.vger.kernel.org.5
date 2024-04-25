Return-Path: <linux-kernel+bounces-158245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EBB8B1D74
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FF5EB25180
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF8C7F486;
	Thu, 25 Apr 2024 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGCL9toV"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1246A7FBB0;
	Thu, 25 Apr 2024 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036045; cv=none; b=b/jPi9bi5gnt0lRn7J43O+RhzH7IPsYoBPkIu8X86kfyaZUmVE4xppQM483ekssCMA5Vlt8wXSORqwuxj4RFQugo2hz+kQEn9GfQHv/c3NsoX5y1Vjo/FjcSOHuYwGi5XHjCauzN0P27Oonlyri9K7i1LMW0exwxDZhqHrk/twQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036045; c=relaxed/simple;
	bh=mMZvfoqcQBTuRChmieZa5D5b5PaDayZKxY7BssiNplg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oljQc1NmSaZhKm/xwjo/82cgYCbINpkrEcYpDPy9uaabwYOPdOo6lKugI4dgvUlYimUMZ6jd0fSfuwPXA97GGG9i27OuHx5WUEmSPnZJ+ZyLn+lSJPRU4QSk9fFXUpZSM32d23PMYt9rBk6Q4/K7CCXoR6m98/Iher/wJToYXtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGCL9toV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e8b03fa5e5so6346405ad.1;
        Thu, 25 Apr 2024 02:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714036043; x=1714640843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FJ9FQCx0e5TdFMZpfO8erltXPtH4u8W7h6Ha1qbTBNM=;
        b=UGCL9toVQVKAYq+/uta99VX9a4SVCobCbUdvnad9S+SFA5eyS6Zm2HsfTd4kq36kYK
         1GRg4I4KUTWrxoBG8KdfsA3IDhYxs4rUIJw2Qcgpz/90uhzHGI9LKQiBXGzaxyMzFNTB
         U8i5PUKVcGzIGcf/Ll5YJmR008xfluwmBDnhBowtLkJ6yyfYfFbSpMaj3N8barM0iA9M
         v43H2phExDdLHZPptFor3glKVunuO2R1/Wq0fpcTxsUeD4IqN4qPbrlwdxhcrcNckkDZ
         I2UJIgE+/6Tbb2xBHTtsv45kv+uddpPZk7JlW8sbV+EkXXJrfBk6OdAm4Mz6ZO1XMKOJ
         gJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714036043; x=1714640843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJ9FQCx0e5TdFMZpfO8erltXPtH4u8W7h6Ha1qbTBNM=;
        b=g8WRSZXCA3MRz2+f4DwsSbhOnmsTo7LPBIf1Ujrx4B32GoTN6njR8NVzj/5y+NH54+
         nRKFpFY9MufqOmatV/oZtx0s6CgA9qEj9SkJZIJ96vrNR57+4lRibVfN6Esb3JV54ddW
         VisbPqKJ26R55ezd4e1e50nYYRzSzVIPjK38uTwCjI7VvCgKq6PkHCPwv/CjGnfZq6m7
         ES9V1SnSxs2hCBU5N5jkEAEZ1jskYqyLBZTlwXeoi1pjJZrViDaWFnznExqk1UEt1NSD
         g4AjsZGvieh1WM+DFKye+444v5z3SC4t9IxOoFRb2bCA8UDnsbvuF30OAtJDwSdvdt5r
         e31A==
X-Forwarded-Encrypted: i=1; AJvYcCUHrCngptbi3PXZz/CBMb/AChozBPaPVx+/y2vtibkRSbi8s88vpnVHVi5Nm731idSogNyg8jLq2U5MfOJrunDHUFdv7ciCIwYc46aSVR9TRYOXEWECrOiR6XQCUyi/4n/vDu4jf1s+Bo7ZHPDJapckIZUiFHqUpP1emg6+6f77gzrz4u3ZxM6pdeLd6ksZxb2+mhoM9svYi1G6REtbyz+N4VU=
X-Gm-Message-State: AOJu0YzttbahK7wYDfQeS18W241Vskx7gaz8Q3er2IBV0ZuB1LhS7XMX
	+2EtgqjnypMAV2jf+ciLMbxJYDw5CH9Nz9u0xdx02afi23uEw88l
X-Google-Smtp-Source: AGHT+IEw0+L7Uo9RJkt0QNIEhz/BNr5odMWcoZTgSX9rieBovsk+suyD7cQDqYRF1qTh9d7WIF0l2g==
X-Received: by 2002:a17:902:efc2:b0:1e3:e1d5:c680 with SMTP id ja2-20020a170902efc200b001e3e1d5c680mr5453428plb.63.1714036043165;
        Thu, 25 Apr 2024 02:07:23 -0700 (PDT)
Received: from localhost (ec2-3-111-32-5.ap-south-1.compute.amazonaws.com. [3.111.32.5])
        by smtp.gmail.com with UTF8SMTPSA id t10-20020a170902e84a00b001e5a5ea5287sm13251722plg.208.2024.04.25.02.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 02:07:22 -0700 (PDT)
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
Subject: [PATCH v3] ASoC: dt-bindings: tegra30-i2s: convert to dt schema
Date: Thu, 25 Apr 2024 14:37:14 +0530
Message-ID: <20240425090716.176818-1-sheharyaar48@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert NVIDIA Tegra30 I2S binding to DT schema and
add new examples.

Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
---
Changes v2->v3:
- Fixed example indentation
- Fix compatible logic
- Add new examples from existing dts
- Add clock-names in properties

v2:
https://lore.kernel.org/all/20240421123037.75680-1-sheharyaar48@gmail.com/
---
 .../bindings/sound/nvidia,tegra30-i2s.txt     | 27 ------
 .../bindings/sound/nvidia,tegra30-i2s.yaml    | 94 +++++++++++++++++++
 2 files changed, 94 insertions(+), 27 deletions(-)
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
index 000000000000..3d8d56c666d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.yaml
@@ -0,0 +1,94 @@
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
+          - enum:
+              - nvidia,tegra114-i2s
+              - nvidia,tegra132-i2s
+          - enum:
+              - nvidia,tegra124-i2s
+              - nvidia,tegra30-i2s
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    maxItems: 1
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
+  - |
+    #include <dt-bindings/clock/tegra124-car.h>
+
+    i2s@70301100 {
+        compatible = "nvidia,tegra124-i2s";
+        reg = <0x70301100 0x100>;
+        nvidia,ahub-cif-ids = <5 5>;
+        clocks = <&tegra_car TEGRA124_CLK_I2S1>;
+        clock-names = "i2s";
+        resets = <&tegra_car 11>;
+        reset-names = "i2s";
+    };
+  - |
+    #include <dt-bindings/clock/tegra114-car.h>
+
+    i2s@70080500 {
+        compatible = "nvidia,tegra114-i2s", "nvidia,tegra30-i2s";
+        reg = <0x70080500 0x100>;
+        nvidia,ahub-cif-ids = <6 6>;
+        clocks = <&tegra_car TEGRA114_CLK_I2S2>;
+        resets = <&tegra_car 18>;
+        reset-names = "i2s";
+    };
+...
-- 
2.44.0


