Return-Path: <linux-kernel+bounces-22319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E54D829C26
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBB5AB23C8E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2264B5A6;
	Wed, 10 Jan 2024 14:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lnYgjD0R"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826824A9BA;
	Wed, 10 Jan 2024 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40AE97kw016832;
	Wed, 10 Jan 2024 08:09:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704895747;
	bh=X4OrnPhsoybFZZB+R/1ekVCGxvig/wfVN85sRVNy6CQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lnYgjD0RqlxpeBIjCey+4uSKFZ/bTYkBg+tqh74w2mYDj7FhJ9dTIFVL62/VrA4gl
	 u6gZ8zYhnhvOeQLzCDfKA13sZulro/JJnU6zg8gf9WGykOnaQmOsYuymx81ouzwqk+
	 DKipQp6lSFJxLW+IF5N3TesuRbITGxvMJlYNQet4=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40AE97kk026325
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Jan 2024 08:09:07 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Jan 2024 08:09:06 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Jan 2024 08:09:06 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40AE96fv041060;
	Wed, 10 Jan 2024 08:09:06 -0600
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Jan Kiszka
	<jan.kiszka@siemens.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Matthias Schiffer
	<matthias.schiffer@ew.tq-group.com>,
        Pierre Gondois <pierre.gondois@arm.com>, Rob Herring <robh@kernel.org>,
        Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/16] arm64: dts: ti: k3-am65: Add MIT license along with GPL-2.0
Date: Wed, 10 Jan 2024 08:08:53 -0600
Message-ID: <20240110140903.4090946-7-nm@ti.com>
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

Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Tony Lindgren <tony@atomide.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi                     | 4 ++--
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi                      | 4 ++--
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi                   | 4 ++--
 arch/arm64/boot/dts/ti/k3-am65.dtsi                          | 4 ++--
 arch/arm64/boot/dts/ti/k3-am652.dtsi                         | 4 ++--
 .../dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso     | 4 ++--
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts               | 4 ++--
 arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso                  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am654-idk.dtso                     | 4 ++--
 arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi      | 5 ++++-
 arch/arm64/boot/dts/ti/k3-am654.dtsi                         | 4 ++--
 11 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index fcea54465636..e55a8c891bc9 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for AM6 SoC Family Main Domain peripherals
  *
- * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2016-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 #include <dt-bindings/phy/phy-am654-serdes.h>
 
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index ecd7356f3315..6ff3ccc39fb4 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for AM6 SoC Family MCU Domain peripherals
  *
- * Copyright (C) 2016-2020 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2016-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 &cbass_mcu {
diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index f037b36243ce..37527890ddea 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for AM6 SoC Family Wakeup Domain peripherals
  *
- * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2016-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 &cbass_wakeup {
diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
index 4d7b6155a76b..c59baebc5a25 100644
--- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for AM6 SoC Family
  *
- * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2016-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/arm64/boot/dts/ti/k3-am652.dtsi b/arch/arm64/boot/dts/ti/k3-am652.dtsi
index 0f22e00faa90..cbb3caaf82c3 100644
--- a/arch/arm64/boot/dts/ti/k3-am652.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am652.dtsi
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for AM65 SoC family in Dual core configuration
  *
- * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "k3-am65.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso b/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
index 4209d991eb6b..364c57b3b3a0 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
@@ -1,10 +1,10 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /**
  * OLDI-LCD1EVM Rocktech integrated panel and touch DT overlay for AM654-EVM.
  * Panel Link: https://www.digimax.it/en/tft-lcd/20881-RK101II01D-CT
  * AM654 LCD EVM: https://www.ti.com/tool/TMDSLCD1EVM
  *
- * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 822c288d2797..5109e1bf68d0 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
- * Copyright (C) 2016-2020 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2016-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso b/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
index ec8cf20ca3ac..0a6e75265ba9 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /**
  * DT overlay for IDK application board on AM654 EVM
  *
- * Copyright (C) 2018-2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2018-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-am654-idk.dtso b/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
index 150428dfce6f..8bdb87fcbde0 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /**
  * DT overlay for IDK application board on AM654 EVM
  *
- * Copyright (C) 2018-2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2018-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi
index 9021c738056b..de5a2ed907a7 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi
@@ -1,4 +1,7 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
 
 #include <dt-bindings/thermal/thermal.h>
 
diff --git a/arch/arm64/boot/dts/ti/k3-am654.dtsi b/arch/arm64/boot/dts/ti/k3-am654.dtsi
index 888567b921f0..bb77c8454734 100644
--- a/arch/arm64/boot/dts/ti/k3-am654.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am654.dtsi
@@ -1,8 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Device Tree Source for AM6 SoC family in Quad core configuration
  *
- * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2016-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "k3-am65.dtsi"
-- 
2.43.0


