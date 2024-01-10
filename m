Return-Path: <linux-kernel+bounces-22315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15365829C1F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16F7289BDD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F834D10F;
	Wed, 10 Jan 2024 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SO8m9Yeu"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200264BA9B;
	Wed, 10 Jan 2024 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40AE971A082837;
	Wed, 10 Jan 2024 08:09:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704895747;
	bh=L5VLsrL0Bqa0SgidGjHRgq79IVi8Co3IsXwFN895ax4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SO8m9Yeuh1Bg3EXc7zqW/of5vPMxRRKEHw/NQJQMM/UcxnCOrMEbQmIHBW5Z9q72s
	 40ZO9nYPRElzpzPb2arlb4y5ZzbbDGfzXCUaIT9+AvNCPROdNgaMmsXlJ3lbDia6Ve
	 1QjsaLt9eUIhkb1EuQ7y6ZRnP7u6zjkESb8QUz8s=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40AE97uJ103025
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Jan 2024 08:09:07 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Jan 2024 08:09:07 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Jan 2024 08:09:07 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40AE96bP041080;
	Wed, 10 Jan 2024 08:09:06 -0600
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        Ayush
 Singh <ayushdevel1325@gmail.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Robert Nelson
	<robertcnelson@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Wadim Egorov
	<w.egorov@phytec.de>
Subject: [PATCH 13/16] arm64: dts: ti: beagle*: Add MIT license along with GPL-2.0
Date: Wed, 10 Jan 2024 08:09:00 -0600
Message-ID: <20240110140903.4090946-14-nm@ti.com>
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
license for device trees belonging to BeagleBoard.org Foundation
platforms. This allows for Linux kernel device tree to be used in
other Operating System ecosystems such as Zephyr or FreeBSD.

While at this, update the GPL-2.0 to be GPL-2.0-only to be in sync
with latest SPDX conventions (GPL-2.0 is deprecated).

While at this, update the copyright year to sync with current year
to indicate license change.

Cc: Ayush Singh <ayushdevel1325@gmail.com>
Cc: Jason Kridner <jkridner@beagleboard.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Robert Nelson <robertcnelson@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Wadim Egorov <w.egorov@phytec.de>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../boot/dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso      | 4 ++--
 .../boot/dts/ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso | 4 ++--
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts            | 6 +++---
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts        | 8 ++++----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso b/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso
index 5e80ca7033ba..3b4643b7d19c 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso
@@ -1,7 +1,7 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * ALINX AN5641 & Digilent PCam 5C - OV5640 camera module
- * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso b/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso
index 5e1cbbc27c8f..81a2763d43c6 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso
@@ -1,7 +1,7 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * Technexion TEVI-OV5640-*-RPI - OV5640 camera module
- * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index eadbdd9ffe37..600db09b8ad3 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -1,9 +1,9 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * https://beagleplay.org/
  *
- * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
- * Copyright (C) 2022-2023 Robert Nelson, BeagleBoard.org Foundation
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2022-2024 Robert Nelson, BeagleBoard.org Foundation
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index 2f954729f353..dfc9adacd511 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -1,9 +1,9 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
  * https://beagleboard.org/ai-64
- * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
- * Copyright (C) 2022 Jason Kridner, BeagleBoard.org Foundation
- * Copyright (C) 2022 Robert Nelson, BeagleBoard.org Foundation
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2022-2024 Jason Kridner, BeagleBoard.org Foundation
+ * Copyright (C) 2022-2024 Robert Nelson, BeagleBoard.org Foundation
  */
 
 /dts-v1/;
-- 
2.43.0


