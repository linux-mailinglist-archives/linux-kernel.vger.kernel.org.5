Return-Path: <linux-kernel+bounces-4072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 160E481779D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ED8F2842C1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1681E4A3;
	Mon, 18 Dec 2023 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="lXCogHzX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5D11DFCC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2023121816360259f200d0a2ece6b18f
        for <linux-kernel@vger.kernel.org>;
        Mon, 18 Dec 2023 17:36:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=5xW+98WHaV2XUXSnRdkYfMBQBIiopl+UMOYJignJW1c=;
 b=lXCogHzXWsZbRlSN67KEEqmy8PWtxSaPQlQIGEdN3L7SFfQA7twpn435AUEvHBRkAZ0A/V
 HqnvKc4kLe9dvxtOFF+aLrXz2sq2EOl1shmxp2xq+VYHLq9r11IaOxqrcDNLFpXhI2p9hd6R
 8EQPl1puGii6l4f/cwH3HEB6CGRc0=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bao Cheng Su <baocheng.su@siemens.com>
Subject: [PATCH 2/4] arm64: dts: ti: iot2050: Disable R5 lockstep for all PG2 boards
Date: Mon, 18 Dec 2023 17:35:58 +0100
Message-Id: <ebfb1c761624a6998c22808020f1462a9a20065f.1702917360.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1702917360.git.jan.kiszka@siemens.com>
References: <cover.1702917360.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Baocheng Su <baocheng.su@siemens.com>

The R5 lockstep disabling should be common for all PG2 boards, move it
from variants dts to common-pg2.dtsi.

As now the Basic PG2 consumes this twice, move Basic disabling to the
PG1 variant.

Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
[Jan: avoid duplication of disabling for Basic PG2]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi     | 7 ++++++-
 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi | 5 -----
 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts         | 5 +++++
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts   | 5 -----
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts  | 7 +------
 5 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
index e9b57b87e42e..42adb8815f38 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) Siemens AG, 2021
+ * Copyright (c) Siemens AG, 2021-2023
  *
  * Authors:
  *   Chao Zeng <chao.zeng@siemens.com>
@@ -9,6 +9,11 @@
  * Common bits of the IOT2050 Basic and Advanced variants, PG2
  */
 
+&mcu_r5fss0 {
+	/* lock-step mode not supported on PG2 boards */
+	ti,cluster-mode = <0>;
+};
+
 &main_pmx0 {
 	cp2102n_reset_pin_default: cp2102n-reset-default-pins {
 		pinctrl-single,pins = <
diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
index 5ab434c02ab6..2300abe69e94 100644
--- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
@@ -54,8 +54,3 @@ &main_uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
 };
-
-&mcu_r5fss0 {
-	/* lock-step mode not supported on Basic boards */
-	ti,cluster-mode = <0>;
-};
diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
index 87928ff28214..be9c8db4c43a 100644
--- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
@@ -22,3 +22,8 @@ / {
 	compatible = "siemens,iot2050-basic", "ti,am654";
 	model = "SIMATIC IOT2050 Basic";
 };
+
+&mcu_r5fss0 {
+	/* lock-step mode not supported on this board */
+	ti,cluster-mode = <0>;
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
index bd6f2e696e94..1e5d4d98b69b 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts
@@ -21,11 +21,6 @@ / {
 	model = "SIMATIC IOT2050 Advanced M2";
 };
 
-&mcu_r5fss0 {
-	/* lock-step mode not supported on this board */
-	ti,cluster-mode = <0>;
-};
-
 &main_pmx0 {
 	main_bkey_pcie_reset: main-bkey-pcie-reset-default-pins {
 		pinctrl-single,pins = <
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
index f00dc86d01b9..a8ce8c891894 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) Siemens AG, 2018-2021
+ * Copyright (c) Siemens AG, 2018-2023
  *
  * Authors:
  *   Le Jin <le.jin@siemens.com>
@@ -22,8 +22,3 @@ / {
 	compatible = "siemens,iot2050-advanced-pg2", "ti,am654";
 	model = "SIMATIC IOT2050 Advanced PG2";
 };
-
-&mcu_r5fss0 {
-	/* lock-step mode not supported on this board */
-	ti,cluster-mode = <0>;
-};
-- 
2.35.3


