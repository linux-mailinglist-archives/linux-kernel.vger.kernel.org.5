Return-Path: <linux-kernel+bounces-22318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB01829C24
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F851C22525
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EC84D5AA;
	Wed, 10 Jan 2024 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ho97cREP"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167924D100;
	Wed, 10 Jan 2024 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40AE96WG047182;
	Wed, 10 Jan 2024 08:09:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704895747;
	bh=y3e2ST9h/gjKlMO9xxY/N0oaPGcC5266nL2pIKIfuZo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ho97cREPbgHrkyccJyVgUVlhV6lvqwhoK7BP15icwfpjDE8Yfj4mxkLhliOdqc6Ov
	 2H6C8Wqophos+xOUZ/mzOOtQ7UXTIG3du6QoIQu4WfidIVbeJb7Oii7eZb2UgnMgWC
	 3tzoR7gy9ZFw8UPv1dzrHtgcd/fxEzpouSwQnmT0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40AE96nF098337
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Jan 2024 08:09:06 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Jan 2024 08:09:06 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Jan 2024 08:09:06 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40AE96HA041054;
	Wed, 10 Jan 2024 08:09:06 -0600
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        Guillaume
 La Roque <glaroque@baylibre.com>,
        Julien Panis <jpanis@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierre Gondois
	<pierre.gondois@arm.com>,
        Roger Quadros <rogerq@kernel.org>,
        Ronald Wahl
	<ronald.wahl@raritan.com>,
        Sarah Walker <sarah.walker@imgtec.com>,
        Tony
 Lindgren <tony@atomide.com>
Subject: [PATCH 03/16] arm64: dts: ti: k3-am625: Add MIT license along with GPL-2.0
Date: Wed, 10 Jan 2024 08:08:50 -0600
Message-ID: <20240110140903.4090946-4-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110140903.4090946-1-nm@ti.com>
References: <20240110140903.4090946-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Modify license to include dual licensing as GPL-2.0-only OR MIT
license for SoC and TI evm device tree files. This allows for Linux
kernel device tree to be used in other Operating System ecosystems
such as Zephyr or FreeBSD.

While at this, update the GPL-2.0 to be GPL-2.0-only to be in sync
with latest SPDX conventions (GPL-2.0 is deprecated).

While at this, update the TI copyright year to sync with current year
to indicate license change (and add it at least for one file which was
missing TI copyright).

Cc: Guillaume La Roque <glaroque@baylibre.com>
Cc: Julien Panis <jpanis@baylibre.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Pierre Gondois <pierre.gondois@arm.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Ronald Wahl <ronald.wahl@raritan.com>
Cc: Sarah Walker <sarah.walker@imgtec.com>
Cc: Tony Lindgren <tony@atomide.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts                 | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi                 | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi                  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi              | 5 ++++-
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi               | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62.dtsi                      | 4 ++--
 arch/arm64/boot/dts/ti/k3-am625-sk.dts                   | 4 ++--
 arch/arm64/boot/dts/ti/k3-am625.dtsi                     | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi           | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso      | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso      | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso       | 4 ++--
 13 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
index 5e6feb8cd125..c4149059a4c5 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * AM62x LP SK: https://www.ti.com/tool/SK-AM62-LP
  *
- * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2021-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 464b7565d085..fe0cc4a9a501 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for AM625 SoC Family Main Domain peripherals
  *
- * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 &cbass_main {
diff --git a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
index 0e0b234581c6..e66d486ef1f2 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for AM625 SoC Family MCU Domain peripherals
  *
- * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 &cbass_mcu {
diff --git a/arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi
index a358757e26f0..12ba833002a1 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi
@@ -1,4 +1,7 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
 
 #include <dt-bindings/thermal/thermal.h>
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
index fef76f52a52e..a0bba5ddd409 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for AM625 SoC Family Wakeup Domain peripherals
  *
- * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 &cbass_wakeup {
diff --git a/arch/arm64/boot/dts/ti/k3-am62.dtsi b/arch/arm64/boot/dts/ti/k3-am62.dtsi
index f1e15206e1ce..f0781f2bea29 100644
--- a/arch/arm64/boot/dts/ti/k3-am62.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for AM62 SoC Family
  *
- * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index b18092497c9a..ae81ebb39d02 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * AM625 SK: https://www.ti.com/lit/zip/sprr448
  *
- * Copyright (C) 2021-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2021-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-am625.dtsi b/arch/arm64/boot/dts/ti/k3-am625.dtsi
index 4193c2b3eed6..4014add6320d 100644
--- a/arch/arm64/boot/dts/ti/k3-am625.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am625.dtsi
@@ -1,10 +1,10 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for AM625 SoC family in Quad core configuration
  *
  * TRM: https://www.ti.com/lit/pdf/spruiv7
  *
- * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 33768c02d8eb..05b762602a65 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Common dtsi for AM62x SK and derivatives
  *
- * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2021-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <dt-bindings/leds/common.h>
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
index 6f4cd73c2f43..76ca02127f95 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
@@ -1,7 +1,7 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * IMX219 (RPi v2) Camera Module
- * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso
index 9323a4b38389..ccc7f5e43184 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso
@@ -1,7 +1,7 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * ALINX AN5641 & Digilent PCam 5C - OV5640 camera module
- * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso
index dcaa33a4c8d3..4eaf9d757dd0 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso
@@ -1,7 +1,7 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Technexion TEVI-OV5640-*-RPI - OV5640 camera module
- * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso b/arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso
index 08eb2e894bbc..18c3082f68e6 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /**
  * Audio playback via HDMI for AM625-SK and AM62-LP SK.
  *
@@ -6,7 +6,7 @@
  * AM625 SK: https://www.ti.com/tool/SK-AM62
  * AM62-LP SK: https://www.ti.com/tool/SK-AM62-LP
  *
- * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
-- 
2.43.0


