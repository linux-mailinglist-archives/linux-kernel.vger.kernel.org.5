Return-Path: <linux-kernel+bounces-153341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F7A8ACCD7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887622815B0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1036E147C82;
	Mon, 22 Apr 2024 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrOhPnVg"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2B43D3B3;
	Mon, 22 Apr 2024 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789524; cv=none; b=XDR6ejUJ80i0wvl9wvZ15o6zVMotlw3kE7lCL5vQd0v3XenjbH+lodZKu19Kysf9UvywIqQbe6l76CAGCtiElrcX8WZnikYmvJugPV2uh3ev0wZxTxMdMIVZWu5JoYx3PHqFafWC5Uu2Qc7kNGwdi0LXFR/rhY6TbKgYuKcLXxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789524; c=relaxed/simple;
	bh=pxRWRkI6R4pqlO69Ln9+iTq4dBMcUUKju/X9sDhmjyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oyimlKRBIKBhDrAsg3V8i12gsMAMiZCE4Y4nZ8zhaBfrN83mADEEMn4ygLtDSEZoby+fKAL6OYmVR3e9IvNHGkL4vR8sX9rGF7VLIW5iJBMJuYQLqCHw1EHea3BvzSzn8xsAemmpUhPdHJSMCbr8a+KilW7kkaIdcGSyqWniaxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrOhPnVg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e9bcff8a8cso5062515ad.3;
        Mon, 22 Apr 2024 05:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713789522; x=1714394322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vbuaZWGTBIowVRErwzSunyvXAmc6nmwLHaqK1i/4KhE=;
        b=OrOhPnVgwLkVvqyflfcABWQZHz7EDpJ3pbz2Lbnrx9Lsb8x8LdrJVKnHWZL38+7i8v
         oJwHlVgE/o2sRXfLtPxrE0dWqL+y7K2cGL7kXlzsM+XIkF28dcIrViLnVI8KrJI6tO1B
         OM3Mk3HcggEQk5TSvu3UgIYXruiP9Uj2vxPiGHpm3Yx++my11umW1PQVhSBoO+Rzhsbr
         kMsXdMesCFF+IMs9X1idAvkXs+98YlV6DgrRCWuGadkeLFqNkMZIuGtbMvr+AFORNZ3N
         qDODcCldLKhdDO5UyqNjU+UnRNiAUyvqzzxxTiRJ69pcg1IT+spfmRrrk1HBwE2aP0zO
         hMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713789522; x=1714394322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbuaZWGTBIowVRErwzSunyvXAmc6nmwLHaqK1i/4KhE=;
        b=RQO6j69IcWTb2UqEBxYOKYO01dI28OOiYHaNEUplGc8bK4/6lJLDYGyqEBPvo8H50x
         J0Wz6aosxlaZsNXH1WabbKMH07JEu1q/N+6OTSNxx35EeWSSbI2NnlTXu0ouP9FRudCU
         2B0QSZYwNXa6I3lw9V3uM3WyzAZv3BUS/5oQsGwXpHeLpiMuGbLV8EG6bvY7OZH8Fj8c
         LHeKNgXSoOfDzB0Qc6jD3IgL4T6GaKopM7K16mbINoaW/mTpOV9aJAMKx8C8joFcTgWU
         rxchPn6+cEvg4ZJEV5uey1FTKthwWazVDY9viblnn9uQWgKrBa6MtrhUB4ZusdgJt4TS
         0G8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUx2BJ7Wry10zrsJ73SU3AAjmL9J0KKiHha/FvTxh8nN1RrgRXlq6b9/iOnJIOa5VM22k4TFjHPPYMl0VNZsu8IAqIgV/NZViM1qfHZwCCebqr/cuMETPCiH/3k0KTb7B7UhfuvOVcz9ptbNgM9pmkhA88xqdeu6/1GD/cVbsE0WXm0T7XVlHoWpzFyUbQ5QXPh5AFwhsA/V0nunCb4dSDpo0=
X-Gm-Message-State: AOJu0Ywd8D+rY5/JrmBkUEERUy9OyU5WaUUEcqDDA10sxhv5Z+TRpyDx
	/yYyETcYRFbb+yixsC9k4AH8C/W7WB7NKuVmV11hILt/uWrCn8fI9U/LuQkhEjw=
X-Google-Smtp-Source: AGHT+IGxNNoba5r7CKT54oO8Zfvg3wqYM94cHQ3+cfc2Yn9G6PIlvRbfPJsphpqtISJ4py9IgWTwZA==
X-Received: by 2002:a17:903:124c:b0:1e1:a54:1fe8 with SMTP id u12-20020a170903124c00b001e10a541fe8mr10807848plh.53.1713789521962;
        Mon, 22 Apr 2024 05:38:41 -0700 (PDT)
Received: from localhost (ec2-3-111-32-5.ap-south-1.compute.amazonaws.com. [3.111.32.5])
        by smtp.gmail.com with UTF8SMTPSA id x18-20020a170902b41200b001e446fe6843sm7988915plr.79.2024.04.22.05.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 05:38:41 -0700 (PDT)
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
Subject: [PATCH v2] ASoC: dt-bindings: tegra20-ac97: convert to dt schema
Date: Mon, 22 Apr 2024 18:08:28 +0530
Message-ID: <20240422123830.472109-1-sheharyaar48@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert NVIDIA Tegra20 AC97 binding to DT schema.
Change -gpio to -gpios in both schema and nvidia/tegra20-colibri.dtsi

Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
---
Changes v1->v2:
- change -gpio to -gpios in both schema and dtsi
- tested against dts
- add header files and defines
---
 .../bindings/sound/nvidia,tegra20-ac97.txt    | 36 --------
 .../bindings/sound/nvidia,tegra20-ac97.yaml   | 86 +++++++++++++++++++
 arch/arm/boot/dts/nvidia/tegra20-colibri.dtsi |  4 +-
 3 files changed, 88 insertions(+), 38 deletions(-)
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
index 000000000000..9a68578f6fc3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.yaml
@@ -0,0 +1,86 @@
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
+    description:
+      The Tegra GPIO controller's phandle and the number
+      of the GPIO used to reset the external AC97 codec
+    maxItems: 1
+
+  nvidia,codec-sync-gpios:
+    description:
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
diff --git a/arch/arm/boot/dts/nvidia/tegra20-colibri.dtsi b/arch/arm/boot/dts/nvidia/tegra20-colibri.dtsi
index 8c1d5c9fa483..2ff7be8f1382 100644
--- a/arch/arm/boot/dts/nvidia/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra20-colibri.dtsi
@@ -445,9 +445,9 @@ lvp0 {
 
 	tegra_ac97: ac97@70002000 {
 		status = "okay";
-		nvidia,codec-reset-gpio =
+		nvidia,codec-reset-gpios =
 			<&gpio TEGRA_GPIO(V, 0) GPIO_ACTIVE_LOW>;
-		nvidia,codec-sync-gpio =
+		nvidia,codec-sync-gpios =
 			<&gpio TEGRA_GPIO(P, 0) GPIO_ACTIVE_HIGH>;
 	};
 
-- 
2.44.0


