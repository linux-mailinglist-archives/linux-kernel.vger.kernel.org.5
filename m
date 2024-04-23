Return-Path: <linux-kernel+bounces-155114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5B28AE571
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BFAC1C22CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4671513E3EF;
	Tue, 23 Apr 2024 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ro8zqk+U"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26AB84A2E;
	Tue, 23 Apr 2024 11:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873483; cv=none; b=Qg8QlEi7x89T7ePfr3+qTlZeA65cqSn/jWPZ697do2MaKQSMyyrzha5aBU2OuYWnf3nkJqvpznkklFt+4oB6dpIlsdvLwZJLAIKkeaJsec/kLpyjPjQEtlZnM3CVlXF0v4DQRRkBN8XrMGO7LI/PF5U7syjwEf36ieSbgCllmgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873483; c=relaxed/simple;
	bh=FQXhx2R1lSfWR/ArLZ33NLR2SrABIM6HJonvYmtWnuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J39T0bWzMyduY4aYHmlXRDbZLHY4hbIRPQbZMrwpJz5XBnfQPwb96LZT45EDqF1AGCFL/uikqRCTntmAEUFL5Kn5BnuNY/Eyt14vcC+y07r37Nhv3tWuJNtUYpEq03x9Ok4Co50bMgteFSgwXyB7Q7cjI+4S04BWcMGk9F6HoL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ro8zqk+U; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2a564ca6f67so4578020a91.2;
        Tue, 23 Apr 2024 04:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713873481; x=1714478281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MLBJVL6Zs6xX5RgPPoHakdz0gIokn0SzcSKDDSlz0Kk=;
        b=Ro8zqk+UYS4sPhc5abNHAJ9asqsXin2PTesad+bWsEhH03ffp3IsE87RsZwUZEM0Gb
         MNPhHqrFAce53aIiOd7nkBL9anwhGm80IBarPF3x2aBpQPAIhp/jwFjh0yxrCTwRsQYL
         lGJD52nAKDqYtLU8skRU9DLKozMWFJldk0BQWOsCytS5J7+Q7aVSLEV/rXk0wR9VKuH5
         /NfobUcyVyElc1BtwHs+wLmEdXpNnppL0m4nRpKwFjpBKU4bchzR7e4JQog7lEe06JAr
         qJ5mThsP4nBhTOUJ/FkekCbngET9WIYUGjCk7f9gXOhlSWxKYv0NrgcAhUSqE5t7mSXQ
         dpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713873481; x=1714478281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLBJVL6Zs6xX5RgPPoHakdz0gIokn0SzcSKDDSlz0Kk=;
        b=fa8zTjbW3SiljQhoGfwot4Uy17k9/y/vcQO5ylJD2NajQR6thF3oiATbTC02D+BiSk
         xut2IaZ0gV4CWaIIz5dOG9F7FetzPsP9JGC5omlgNEQdU2IFhRiP4UAyJDb6olISJI+y
         zWga75VURl0jcN758XttwZe9xNIXHHEuFTnqfC0UHI8QuVgxujI095d23gcTtjlPBvFJ
         9IXnjkKyQviMDUB9O6qy3bz4w06p3jQT325Fl5pOvVPmSOrFhtPL4gViSaKqs71RrlGP
         26bfv8AwPcDjsdnvod32Z65/YkWZda1qJhAMgp8097pa8bySuBshzdukx8NqdCCCS8/g
         ygjA==
X-Forwarded-Encrypted: i=1; AJvYcCXEmWA1oVIxxKZUEgHVdWwFYg6MaE9FQrWmOgGbCqs3vZkLfsxwzeSkgBDF/jTKXuMtNAZmqH079YoShwecY6SQaiV9IfzHYH0q93FP7DFDOUVjA3r+GAPgpqH73O1GNa02YmatY7vxHYrxcXMqsly2/f+AVjF3Q447h1pjOhwGATEkP6MqlHHfMkb1djkQ2utM0TXGt2at8nnR1uU3udVNG6k=
X-Gm-Message-State: AOJu0YzN1IMjPrFKgctWK+Gmle8bhXOU+bQUGR3TSKVnSAGpI8bBn44e
	jZEDOozQB12/4kmeAxXMwgfxeXG4IGSTDq6pstiLRX/8PeUJOfRtEmqWPzsszi8=
X-Google-Smtp-Source: AGHT+IGpezawsi7L9yl9OuiRmpihUZN+0NbXr2MY7scA1VG7GrpEXzz/DrnVMZgNJQI0bxaEdi+dAQ==
X-Received: by 2002:a17:90a:9e8:b0:2a2:ba9:ba61 with SMTP id 95-20020a17090a09e800b002a20ba9ba61mr13715610pjo.34.1713873480825;
        Tue, 23 Apr 2024 04:58:00 -0700 (PDT)
Received: from localhost (ec2-3-111-32-5.ap-south-1.compute.amazonaws.com. [3.111.32.5])
        by smtp.gmail.com with UTF8SMTPSA id e14-20020a17090ab38e00b002a03456ccabsm10952427pjr.30.2024.04.23.04.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 04:58:00 -0700 (PDT)
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
Subject: [PATCH v3] ASoC: dt-bindings: tegra20-ac97: convert to dt schema
Date: Tue, 23 Apr 2024 17:27:47 +0530
Message-ID: <20240423115749.15786-1-sheharyaar48@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert NVIDIA Tegra20 AC97 binding to DT schema.
Change -gpio to -gpios in schema as "gpio" suffix is deprecated.

Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
---
 .../bindings/sound/nvidia,tegra20-ac97.txt    | 36 --------
 .../bindings/sound/nvidia,tegra20-ac97.yaml   | 82 +++++++++++++++++++
 2 files changed, 82 insertions(+), 36 deletions(-)
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
index 000000000000..4ea0a303d995
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.yaml
@@ -0,0 +1,82 @@
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
+    maxItems: 1
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+  nvidia,codec-reset-gpios:
+    description: Reset pin of external AC97 codec
+    maxItems: 1
+
+  nvidia,codec-sync-gpios:
+    description: AC97 DAP _FS line
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
+  - nvidia,codec-reset-gpios
+  - nvidia,codec-sync-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra20-car.h>
+    #include <dt-bindings/gpio/tegra-gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    ac97@70002000 {
+        compatible = "nvidia,tegra20-ac97";
+        reg = <0x70002000 0x200>;
+        resets = <&tegra_car 3>;
+        reset-names = "ac97";
+        interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&tegra_car 3>;
+        dmas = <&apbdma 12>, <&apbdma 12>;
+        dma-names = "rx", "tx";
+        nvidia,codec-reset-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
+        nvidia,codec-sync-gpios = <&gpio TEGRA_GPIO(P, 0) GPIO_ACTIVE_HIGH>;
+    };
+...
-- 
2.44.0


