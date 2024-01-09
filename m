Return-Path: <linux-kernel+bounces-21370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4471828E48
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42CB1C20CEF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F653D55D;
	Tue,  9 Jan 2024 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XiuVI81a"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F61A3D540;
	Tue,  9 Jan 2024 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 409JuDVp114991;
	Tue, 9 Jan 2024 13:56:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704830173;
	bh=Gz1EqEj/w1hK8urEF4MOK+IV7RzuofopJEawVQm/wqk=;
	h=From:To:CC:Subject:Date;
	b=XiuVI81a1d374dZcGa5Z9c0GOJlPR1ex9ZlAISqnX8gZpAfoM4b89iPd2hmo+qLFV
	 A2tx51UtuG8/DkxuMh7zf2FRLjGXz2G5sEEM8drXl9QPwSgDOHAmaRwCGGwo8+1rpJ
	 4ZsnEcPDpSyzqTdlK3hTTMETF1xi3eyCiK80S1NA=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 409JuDbj027054
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jan 2024 13:56:13 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jan 2024 13:56:13 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jan 2024 13:56:13 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 409JuD4A118972;
	Tue, 9 Jan 2024 13:56:13 -0600
From: Nishanth Menon <nm@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>
CC: <afd@ti.com>, <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] ARM: dts: keystone: Replace http urls with https
Date: Tue, 9 Jan 2024 13:56:12 -0600
Message-ID: <20240109195612.3833281-1-nm@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Replace http url instances with https.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/ti/keystone/keystone-clocks.dtsi      | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2e-clocks.dtsi  | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2e-evm.dts      | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2e-netcp.dtsi   | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2e.dtsi         | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2g-evm.dts      | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2g-ice.dts      | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2g-netcp.dtsi   | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2g.dtsi         | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2hk-clocks.dtsi | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2hk-evm.dts     | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2hk-netcp.dtsi  | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2hk.dtsi        | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2l-clocks.dtsi  | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2l-evm.dts      | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2l-netcp.dtsi   | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi         | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone.dtsi             | 2 +-
 18 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/ti/keystone/keystone-clocks.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-clocks.dtsi
index 0397c3423d2d..20bab90ee0ba 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-clocks.dtsi
+++ b/arch/arm/boot/dts/ti/keystone/keystone-clocks.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for Keystone 2 clock tree
  *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 clocks {
diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2e-clocks.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2e-clocks.dtsi
index cf30e007fea3..74720dbf3110 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2e-clocks.dtsi
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2e-clocks.dtsi
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 Edison SoC specific device tree
  *
- * Copyright (C) 2014-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2014-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 clocks {
diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2e-evm.dts b/arch/arm/boot/dts/ti/keystone/keystone-k2e-evm.dts
index 6978d6a362f3..58099ce8d449 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2e-evm.dts
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2e-evm.dts
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 Edison EVM device tree
  *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2e-netcp.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2e-netcp.dtsi
index 5c88a90903b8..e586350ae4dc 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2e-netcp.dtsi
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2e-netcp.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for Keystone 2 Edison Netcp driver
  *
- * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 qmss: qmss@2a40000 {
diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2e.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2e.dtsi
index 65c32946c522..662aa33cba11 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2e.dtsi
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2e.dtsi
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 Edison soc device tree
  *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <dt-bindings/reset/ti-syscon.h>
diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2g-evm.dts b/arch/arm/boot/dts/ti/keystone/keystone-k2g-evm.dts
index f0ddbbcdc972..bf5f67d70235 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2g-evm.dts
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for K2G EVM
  *
- * Copyright (C) 2016-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2016-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2g-ice.dts b/arch/arm/boot/dts/ti/keystone/keystone-k2g-ice.dts
index 6ceb0d5c6388..264e1e0d23c8 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2g-ice.dts
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2g-ice.dts
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for K2G Industrial Communication Engine EVM
  *
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2g-netcp.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2g-netcp.dtsi
index 7109ca031617..974c8f2fa740 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2g-netcp.dtsi
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2g-netcp.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for K2G Netcp driver
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 qmss: qmss@4020000 {
diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2g.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2g.dtsi
index 102d59694d90..790b29ab0fa2 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2g.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for K2G SOC
  *
- * Copyright (C) 2016-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2016-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2hk-clocks.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2hk-clocks.dtsi
index 4ba6912176ef..3ca4722087c9 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2hk-clocks.dtsi
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2hk-clocks.dtsi
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 Kepler/Hawking SoC clock nodes
  *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 clocks {
diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2hk-evm.dts b/arch/arm/boot/dts/ti/keystone/keystone-k2hk-evm.dts
index 8dfb54295027..b824fad9a4ec 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2hk-evm.dts
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2hk-evm.dts
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 Kepler/Hawking EVM device tree
  *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2hk-netcp.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2hk-netcp.dtsi
index c2ee775eab6a..3ab1b5d6f9bc 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2hk-netcp.dtsi
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2hk-netcp.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for Keystone 2 Hawking Netcp driver
  *
- * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 qmss: qmss@2a40000 {
diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2hk.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2hk.dtsi
index da6d3934c2e8..4fdf4b30384f 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2hk.dtsi
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2hk.dtsi
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 Kepler/Hawking soc specific device tree
  *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <dt-bindings/reset/ti-syscon.h>
diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2l-clocks.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2l-clocks.dtsi
index 635528064dea..fcfc2fb6cc2d 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2l-clocks.dtsi
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2l-clocks.dtsi
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 lamarr SoC clock nodes
  *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 clocks {
diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2l-evm.dts b/arch/arm/boot/dts/ti/keystone/keystone-k2l-evm.dts
index be619e39a16f..ccda63ab12fe 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2l-evm.dts
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2l-evm.dts
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 Lamarr EVM device tree
  *
- * Copyright (C) 2014-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2014-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2l-netcp.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2l-netcp.dtsi
index 1afebd7458c1..b8f880faaa31 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2l-netcp.dtsi
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2l-netcp.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for Keystone 2 Lamarr Netcp driver
  *
- * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 qmss: qmss@2a40000 {
diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
index 2062fe561642..330b437b667f 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 Lamarr SoC specific device tree
  *
- * Copyright (C) 2014-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2014-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <dt-bindings/reset/ti-syscon.h>
diff --git a/arch/arm/boot/dts/ti/keystone/keystone.dtsi b/arch/arm/boot/dts/ti/keystone/keystone.dtsi
index 1fd04bb37a15..ff16428860a9 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone.dtsi
+++ b/arch/arm/boot/dts/ti/keystone/keystone.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-- 
2.43.0


