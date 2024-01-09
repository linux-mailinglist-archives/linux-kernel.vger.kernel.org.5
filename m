Return-Path: <linux-kernel+bounces-21369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FDB828E45
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8856A1C210A0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346043D55F;
	Tue,  9 Jan 2024 19:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xOLAR3qR"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27353D39A;
	Tue,  9 Jan 2024 19:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 409Jt4eT114662;
	Tue, 9 Jan 2024 13:55:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704830104;
	bh=r2NDbpPs2btHBdlEyqB7QdJ7YMaq1T/LIfdJbIlc3VA=;
	h=From:To:CC:Subject:Date;
	b=xOLAR3qRJRlZpUL01ueZkUQe5DHt2dG4D9E3qw5Avt0KM8bMyZih1u1sMaZkeIqeO
	 p7po/6vmXjHx3rLzwl26BO1m+EHTIkyWwvMuqRdI3lhrS13jXDrOwqMSOAhmPqJVGT
	 /xQ+G72OV1SaUhScvgGMrGuoV/jGEITnbTTXk7lU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 409Jt3Gq026232
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jan 2024 13:55:04 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jan 2024 13:55:03 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jan 2024 13:55:03 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 409Jt3FU018530;
	Tue, 9 Jan 2024 13:55:03 -0600
From: Nishanth Menon <nm@ti.com>
To: Mark Jackson <mpfj@newflow.co.uk>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, Marc Murphy <marc.murphy@sancloud.com>,
        Paul
 Barker <paul.barker@sancloud.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: dts: omap: Switch over to https:// url
Date: Tue, 9 Jan 2024 13:55:00 -0600
Message-ID: <20240109195500.3833121-1-nm@ti.com>
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

Move the pending urls back to https:// and mark the ones that are no
longer accessible (http or https) as defunct.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/ti/omap/am335x-baltos-ir2110.dts            | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-baltos-ir3220.dts            | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-baltos-ir5221.dts            | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-baltos-leds.dtsi             | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-baltos.dtsi                  | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-base0033.dts                 | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi             | 4 ++--
 arch/arm/boot/dts/ti/omap/am335x-cm-t335.dts                  | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-evmsk.dts                    | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-guardian.dts                 | 4 ++--
 arch/arm/boot/dts/ti/omap/am335x-icev2.dts                    | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-igep0033.dtsi                | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-myirtech-myc.dtsi            | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-myirtech-myd.dts             | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-nano.dts                     | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-netcan-plus-1xx.dts          | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dts          | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-netcom-plus-8xx.dts          | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-pdu001.dts                   | 2 +-
 .../boot/dts/ti/omap/am335x-sancloud-bbe-extended-wifi.dts    | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-sancloud-bbe-lite.dts        | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-sbc-t335.dts                 | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-sl50.dts                     | 3 ++-
 arch/arm/boot/dts/ti/omap/am437x-cm-t43.dts                   | 2 +-
 arch/arm/boot/dts/ti/omap/am437x-sbc-t43.dts                  | 2 +-
 arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts             | 2 +-
 arch/arm/boot/dts/ti/omap/am57xx-cl-som-am57x.dts             | 2 +-
 arch/arm/boot/dts/ti/omap/am57xx-sbc-am57x.dts                | 2 +-
 arch/arm/boot/dts/ti/omap/compulab-sb-som.dtsi                | 2 +-
 arch/arm/boot/dts/ti/omap/dra74x-p.dtsi                       | 2 +-
 arch/arm/boot/dts/ti/omap/omap4-sdp.dts                       | 2 +-
 arch/arm/boot/dts/ti/omap/omap5-igep0050.dts                  | 2 +-
 arch/arm/boot/dts/ti/omap/twl4030.dtsi                        | 2 +-
 arch/arm/boot/dts/ti/omap/twl6030.dtsi                        | 4 ++--
 34 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-baltos-ir2110.dts b/arch/arm/boot/dts/ti/omap/am335x-baltos-ir2110.dts
index ea5882ed7010..f82d2231dfaa 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-baltos-ir2110.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-baltos-ir2110.dts
@@ -5,7 +5,7 @@
 
 /*
  * VScom OnRISC
- * http://www.vscom.de
+ * https://www.vscom.de
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-baltos-ir3220.dts b/arch/arm/boot/dts/ti/omap/am335x-baltos-ir3220.dts
index ea4f8dde6424..74a2191af146 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-baltos-ir3220.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-baltos-ir3220.dts
@@ -5,7 +5,7 @@
 
 /*
  * VScom OnRISC
- * http://www.vscom.de
+ * https://www.vscom.de
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-baltos-ir5221.dts b/arch/arm/boot/dts/ti/omap/am335x-baltos-ir5221.dts
index ec914f27d11d..723ff88f76ac 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-baltos-ir5221.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-baltos-ir5221.dts
@@ -5,7 +5,7 @@
 
 /*
  * VScom OnRISC
- * http://www.vscom.de
+ * https://www.vscom.de
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-baltos-leds.dtsi b/arch/arm/boot/dts/ti/omap/am335x-baltos-leds.dtsi
index 6a52e42b9e81..049fd8e1b40f 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-baltos-leds.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am335x-baltos-leds.dtsi
@@ -5,7 +5,7 @@
 
 /*
  * VScom OnRISC
- * http://www.vscom.de
+ * https://www.vscom.de
  */
 
 /*#include "am33xx.dtsi"*/
diff --git a/arch/arm/boot/dts/ti/omap/am335x-baltos.dtsi b/arch/arm/boot/dts/ti/omap/am335x-baltos.dtsi
index c14d5b70c72f..a4beb718559c 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-baltos.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am335x-baltos.dtsi
@@ -5,7 +5,7 @@
 
 /*
  * VScom OnRISC
- * http://www.vscom.de
+ * https://www.vscom.de
  */
 
 #include "am33xx.dtsi"
diff --git a/arch/arm/boot/dts/ti/omap/am335x-base0033.dts b/arch/arm/boot/dts/ti/omap/am335x-base0033.dts
index eba843e22ea1..46078af4b7a3 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-base0033.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-base0033.dts
@@ -2,7 +2,7 @@
 /*
  * am335x-base0033.dts - Device Tree file for IGEP AQUILA EXPANSION
  *
- * Copyright (C) 2013 ISEE 2007 SL - http://www.isee.biz
+ * Copyright (C) 2013 ISEE 2007 SL - https://www.isee.biz
  */
 
 #include "am335x-igep0033.dtsi"
diff --git a/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi b/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
index 96451c8a815c..2d0216840ff5 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi
@@ -289,8 +289,8 @@ &tps {
 	 * For details, see linux-omap mailing list May 2015 thread
 	 *	[PATCH] ARM: dts: am335x-bone* enable pmic-shutdown-controller
 	 * In particular, messages:
-	 *	http://www.spinics.net/lists/linux-omap/msg118585.html
-	 *	http://www.spinics.net/lists/linux-omap/msg118615.html
+	 *	https://www.spinics.net/lists/linux-omap/msg118585.html
+	 *	https://www.spinics.net/lists/linux-omap/msg118615.html
 	 *
 	 * You can override this later with
 	 *	&tps {  /delete-property/ ti,pmic-shutdown-controller;  }
diff --git a/arch/arm/boot/dts/ti/omap/am335x-cm-t335.dts b/arch/arm/boot/dts/ti/omap/am335x-cm-t335.dts
index 72990e7ffe10..06767ea164b5 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-cm-t335.dts
@@ -2,7 +2,7 @@
 /*
  * am335x-cm-t335.dts - Device Tree file for Compulab CM-T335
  *
- * Copyright (C) 2014 - 2015 CompuLab Ltd. - http://www.compulab.co.il/
+ * Copyright (C) 2014 - 2015 CompuLab Ltd. - https://www.compulab.co.il/
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-evmsk.dts b/arch/arm/boot/dts/ti/omap/am335x-evmsk.dts
index 57f78846c42d..eba888dcd60e 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-evmsk.dts
@@ -5,7 +5,7 @@
 
 /*
  * AM335x Starter Kit
- * http://www.ti.com/tool/tmdssk3358
+ * https://www.ti.com/tool/tmdssk3358
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-guardian.dts b/arch/arm/boot/dts/ti/omap/am335x-guardian.dts
index 205fe0ed7352..56e5d954a490 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-guardian.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-guardian.dts
@@ -303,8 +303,8 @@ &tps {
    * For details, see linux-omap mailing list May 2015 thread
    *  [PATCH] ARM: dts: am335x-bone* enable pmic-shutdown-controller
    * In particular, messages:
-   *  http://www.spinics.net/lists/linux-omap/msg118585.html
-   *  http://www.spinics.net/lists/linux-omap/msg118615.html
+   *  https://www.spinics.net/lists/linux-omap/msg118585.html
+   *  https://www.spinics.net/lists/linux-omap/msg118615.html
    *
    * You can override this later with
    *  &tps {  /delete-property/ ti,pmic-shutdown-controller;  }
diff --git a/arch/arm/boot/dts/ti/omap/am335x-icev2.dts b/arch/arm/boot/dts/ti/omap/am335x-icev2.dts
index 3c4228927f56..6f0f4fba043b 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-icev2.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-icev2.dts
@@ -5,7 +5,7 @@
 
 /*
  * AM335x ICE V2 board
- * http://www.ti.com/tool/tmdsice3359
+ * https://www.ti.com/tool/tmdsice3359
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-igep0033.dtsi b/arch/arm/boot/dts/ti/omap/am335x-igep0033.dtsi
index e85c33fd42f0..c7a4a5476489 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am335x-igep0033.dtsi
@@ -2,7 +2,7 @@
 /*
  * am335x-igep0033.dtsi - Device Tree file for IGEP COM AQUILA AM335x
  *
- * Copyright (C) 2013 ISEE 2007 SL - http://www.isee.biz
+ * Copyright (C) 2013 ISEE 2007 SL - https://www.isee.biz
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-myirtech-myc.dtsi b/arch/arm/boot/dts/ti/omap/am335x-myirtech-myc.dtsi
index 584599269217..9c9359844a20 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-myirtech-myc.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am335x-myirtech-myc.dtsi
@@ -2,7 +2,7 @@
 /* SPDX-FileCopyrightText: Alexander Shiyan, <shc_work@mail.ru> */
 
 /* Based on code by myc_c335x.dts, MYiRtech.com */
-/* Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/ */
+/* Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/ */
 
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/ti/omap/am335x-myirtech-myd.dts b/arch/arm/boot/dts/ti/omap/am335x-myirtech-myd.dts
index d3bba79b9358..fd91a3c01a63 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-myirtech-myd.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-myirtech-myd.dts
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /* SPDX-FileCopyrightText: Alexander Shiyan, <shc_work@mail.ru> */
 /* Based on code by myd_c335x.dts, MYiRtech.com */
-/* Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/ */
+/* Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/ */
 
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/ti/omap/am335x-nano.dts b/arch/arm/boot/dts/ti/omap/am335x-nano.dts
index a475c0d91306..26b5510cb3d1 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-nano.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-nano.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2013 Newflow Ltd - http://www.newflow.co.uk/
+ * Copyright (C) 2013 Newflow Ltd - https://www.newflow.co.uk/
  */
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/ti/omap/am335x-netcan-plus-1xx.dts b/arch/arm/boot/dts/ti/omap/am335x-netcan-plus-1xx.dts
index f7fad48e36ed..546e88f8fbad 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-netcan-plus-1xx.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-netcan-plus-1xx.dts
@@ -5,7 +5,7 @@
 
 /*
  * VScom OnRISC
- * http://www.vscom.de
+ * https://www.vscom.de
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dts b/arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dts
index 76751a324ad7..f66d57bb685e 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-netcom-plus-2xx.dts
@@ -5,7 +5,7 @@
 
 /*
  * VScom OnRISC
- * http://www.vscom.de
+ * https://www.vscom.de
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-netcom-plus-8xx.dts b/arch/arm/boot/dts/ti/omap/am335x-netcom-plus-8xx.dts
index 5a9fcec040fa..5fb2c629f35c 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-netcom-plus-8xx.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-netcom-plus-8xx.dts
@@ -5,7 +5,7 @@
 
 /*
  * VScom OnRISC
- * http://www.vscom.de
+ * https://www.vscom.de
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-pdu001.dts b/arch/arm/boot/dts/ti/omap/am335x-pdu001.dts
index 3c9444e98c14..f38f5bff2b96 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-pdu001.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-pdu001.dts
@@ -3,7 +3,7 @@
  *
  * EETS GmbH PDU001 board device tree file
  *
- * Copyright (C) 2018 EETS GmbH - http://www.eets.ch/
+ * Copyright (C) 2018 EETS GmbH - https://www.eets.ch/
  *
  * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  *
diff --git a/arch/arm/boot/dts/ti/omap/am335x-sancloud-bbe-extended-wifi.dts b/arch/arm/boot/dts/ti/omap/am335x-sancloud-bbe-extended-wifi.dts
index 5522759def26..7c9f65126c63 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-sancloud-bbe-extended-wifi.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-sancloud-bbe-extended-wifi.dts
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2021 Sancloud Ltd
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
  */
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/ti/omap/am335x-sancloud-bbe-lite.dts b/arch/arm/boot/dts/ti/omap/am335x-sancloud-bbe-lite.dts
index b1b400226d83..c6c96f6182a8 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-sancloud-bbe-lite.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-sancloud-bbe-lite.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
  * Copyright (C) 2021 SanCloud Ltd
  */
 /dts-v1/;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-sbc-t335.dts b/arch/arm/boot/dts/ti/omap/am335x-sbc-t335.dts
index 596774c84744..2841e95d9a09 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-sbc-t335.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-sbc-t335.dts
@@ -2,7 +2,7 @@
 /*
  * am335x-sbc-t335.dts - Device Tree file for Compulab SBC-T335
  *
- * Copyright (C) 2014 - 2015 CompuLab Ltd. - http://www.compulab.co.il/
+ * Copyright (C) 2014 - 2015 CompuLab Ltd. - https://www.compulab.co.il/
  */
 
 #include "am335x-cm-t335.dts"
diff --git a/arch/arm/boot/dts/ti/omap/am335x-sl50.dts b/arch/arm/boot/dts/ti/omap/am335x-sl50.dts
index 1115c812f6c8..757ebd96b3f0 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-sl50.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-sl50.dts
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2015 Toby Churchill - http://www.toby-churchill.com/
+ * Copyright (C) 2015 Toby Churchill - https://www.toby-churchill.com/
+ * url above is defunct
  */
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/ti/omap/am437x-cm-t43.dts b/arch/arm/boot/dts/ti/omap/am437x-cm-t43.dts
index 9ec75d03eaff..172516a7667e 100644
--- a/arch/arm/boot/dts/ti/omap/am437x-cm-t43.dts
+++ b/arch/arm/boot/dts/ti/omap/am437x-cm-t43.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2015 CompuLab, Ltd. - http://www.compulab.co.il/
+ * Copyright (C) 2015 CompuLab, Ltd. - https://www.compulab.co.il/
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/ti/omap/am437x-sbc-t43.dts b/arch/arm/boot/dts/ti/omap/am437x-sbc-t43.dts
index 34a5407bee15..5ec57dcb0659 100644
--- a/arch/arm/boot/dts/ti/omap/am437x-sbc-t43.dts
+++ b/arch/arm/boot/dts/ti/omap/am437x-sbc-t43.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2015 CompuLab, Ltd. - http://www.compulab.co.il/
+ * Copyright (C) 2015 CompuLab, Ltd. - https://www.compulab.co.il/
  */
 
 #include "am437x-cm-t43.dts"
diff --git a/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts b/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
index c8e55642f9c6..a8519429c061 100644
--- a/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
+++ b/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2014-2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2014-2019 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/ti/omap/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/ti/omap/am57xx-cl-som-am57x.dts
index 4fd831ff206f..d6e3152b02f7 100644
--- a/arch/arm/boot/dts/ti/omap/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/ti/omap/am57xx-cl-som-am57x.dts
@@ -2,7 +2,7 @@
 /*
  * Support for CompuLab CL-SOM-AM57x System-on-Module
  *
- * Copyright (C) 2015 CompuLab Ltd. - http://www.compulab.co.il/
+ * Copyright (C) 2015 CompuLab Ltd. - https://www.compulab.co.il/
  * Author: Dmitry Lifshitz <lifshitz@compulab.co.il>
  */
 
diff --git a/arch/arm/boot/dts/ti/omap/am57xx-sbc-am57x.dts b/arch/arm/boot/dts/ti/omap/am57xx-sbc-am57x.dts
index 363115afb0a4..64675f4edb60 100644
--- a/arch/arm/boot/dts/ti/omap/am57xx-sbc-am57x.dts
+++ b/arch/arm/boot/dts/ti/omap/am57xx-sbc-am57x.dts
@@ -2,7 +2,7 @@
 /*
  * Support for CompuLab SBC-AM57x single board computer
  *
- * Copyright (C) 2015 CompuLab Ltd. - http://www.compulab.co.il/
+ * Copyright (C) 2015 CompuLab Ltd. - https://www.compulab.co.il/
  * Author: Dmitry Lifshitz <lifshitz@compulab.co.il>
  */
 
diff --git a/arch/arm/boot/dts/ti/omap/compulab-sb-som.dtsi b/arch/arm/boot/dts/ti/omap/compulab-sb-som.dtsi
index f5e6216718d8..8a8fa1b2b26c 100644
--- a/arch/arm/boot/dts/ti/omap/compulab-sb-som.dtsi
+++ b/arch/arm/boot/dts/ti/omap/compulab-sb-som.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2015 CompuLab, Ltd. - http://www.compulab.co.il/
+ * Copyright (C) 2015 CompuLab, Ltd. - https://www.compulab.co.il/
  */
 
 / {
diff --git a/arch/arm/boot/dts/ti/omap/dra74x-p.dtsi b/arch/arm/boot/dts/ti/omap/dra74x-p.dtsi
index 006189dad7a7..bb5239ae164d 100644
--- a/arch/arm/boot/dts/ti/omap/dra74x-p.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dra74x-p.dtsi
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/boot/dts/ti/omap/omap4-sdp.dts b/arch/arm/boot/dts/ti/omap/omap4-sdp.dts
index b2cb93edbc3a..b535d24c6140 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-sdp.dts
+++ b/arch/arm/boot/dts/ti/omap/omap4-sdp.dts
@@ -439,7 +439,7 @@ tmp105@48 {
 
 	/*
 	 * Ambient Light Sensor
-	 * http://www.rohm.com/products/databook/sensor/pdf/bh1780gli-e.pdf
+	 * https://www.rohm.com/products/databook/sensor/pdf/bh1780gli-e.pdf (defunct)
 	 */
 	bh1780@29 {
 		compatible = "rohm,bh1780";
diff --git a/arch/arm/boot/dts/ti/omap/omap5-igep0050.dts b/arch/arm/boot/dts/ti/omap/omap5-igep0050.dts
index d4ca2e3a14dd..0368e32f67e7 100644
--- a/arch/arm/boot/dts/ti/omap/omap5-igep0050.dts
+++ b/arch/arm/boot/dts/ti/omap/omap5-igep0050.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2013 ISEE 2007 SL - http://www.isee.biz/
+ * Copyright (C) 2013 ISEE 2007 SL - https://www.isee.biz/
  */
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/ti/omap/twl4030.dtsi b/arch/arm/boot/dts/ti/omap/twl4030.dtsi
index 93e07c18781b..a5d9c5738317 100644
--- a/arch/arm/boot/dts/ti/omap/twl4030.dtsi
+++ b/arch/arm/boot/dts/ti/omap/twl4030.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /*
diff --git a/arch/arm/boot/dts/ti/omap/twl6030.dtsi b/arch/arm/boot/dts/ti/omap/twl6030.dtsi
index 9d588cfaa5cb..8da969035c41 100644
--- a/arch/arm/boot/dts/ti/omap/twl6030.dtsi
+++ b/arch/arm/boot/dts/ti/omap/twl6030.dtsi
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /*
  * Integrated Power Management Chip
- * http://www.ti.com/lit/ds/symlink/twl6030.pdf
+ * https://www.ti.com/lit/ds/symlink/twl6030.pdf
  */
 &twl {
 	compatible = "ti,twl6030";
-- 
2.43.0


