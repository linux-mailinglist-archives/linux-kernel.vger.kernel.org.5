Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F6875C55E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjGULCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjGULAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:00:16 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323B31BFC;
        Fri, 21 Jul 2023 03:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1689937180; x=1721473180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7pwpwezLhnPguFQlx3+eDK88sjHn+6oiFaPstXwW1PY=;
  b=GkeEqiq4F496JqFGHuewfXsndce7LOxrrIriJmeeJxnZtppfayFhSZv4
   VrrYhKSvTqxAOoulNg8Rbh/1g1sGzXfiGpxtHv1KHpJ+DKcGoxD+A8ZTA
   2GTitR/rJOXki6iUDJrZYyplBnOzInHXznvW8fm+kM2A8SOF5QGCWWqrV
   mIopAQU72sdu1Hk/RjztwUDiYFY+/37nZQDhcxPhbupX349RGLj7X4oZ/
   CqXPphMx/p+xqcij7336VYHMv6+QTXX7tJcYMFrca88YuW+aZ4z/WgwB7
   PBJX7xGgomuRCaijU5OBCwPDNpJMIEVX4TCqscpwap8JoGKzD6YYbmvSI
   w==;
X-IronPort-AV: E=Sophos;i="6.01,220,1684792800"; 
   d="scan'208";a="32052496"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 21 Jul 2023 12:59:35 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.20])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 4CE62280085;
        Fri, 21 Jul 2023 12:59:35 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 3/3] arm64: dts: ti: k3-am64-tqma64xxl-mbax4xxl: add SD-card and WLAN overlays
Date:   Fri, 21 Jul 2023 12:59:02 +0200
Message-Id: <445751e60215c0b03a15681533e4ae998829dff6.1689936866.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6db614465a281f802771994399ebb1040acb67bc.1689936866.git.matthias.schiffer@ew.tq-group.com>
References: <6db614465a281f802771994399ebb1040acb67bc.1689936866.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the SD-card and WLAN are connected to the same SDHC interface (with a
GPIO-controlled mux), they are mutually exclusive. Provide Device Tree
overlays for both configurations.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm64/boot/dts/ti/Makefile               |  8 +++++++
 .../ti/k3-am64-tqma64xxl-mbax4xxl-sdcard.dtso | 22 +++++++++++++++++++
 .../ti/k3-am64-tqma64xxl-mbax4xxl-wlan.dtso   | 22 +++++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am64-tqma64xxl-mbax4xxl-sdcard.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am64-tqma64xxl-mbax4xxl-wlan.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 7dbd8a9c02225..24ea0e78dd3b9 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -29,6 +29,14 @@ dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
 
+k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
+	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
+k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs := \
+	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
+
+dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl-wlan.dtb
+
 # Boards with AM65x SoC
 k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb k3-am654-base-board-rocktech-rk101-panel.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am64-tqma64xxl-mbax4xxl-sdcard.dtso b/arch/arm64/boot/dts/ti/k3-am64-tqma64xxl-mbax4xxl-sdcard.dtso
new file mode 100644
index 0000000000000..79ed19c6c0e90
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am64-tqma64xxl-mbax4xxl-sdcard.dtso
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 TQ-Systems GmbH <linux@ew.tq-group.com>, D-82229 Seefeld, Germany.
+ */
+
+/dts-v1/;
+/plugin/;
+
+&sdhci1 {
+	vmmc-supply = <&reg_sd>;
+	no-sdio;
+	status = "okay";
+};
+
+&main_gpio0 {
+	line43-hog {
+		gpio-hog;
+		gpios = <43 0>;
+		line-name = "MMC1_CTRL";
+		output-low;
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am64-tqma64xxl-mbax4xxl-wlan.dtso b/arch/arm64/boot/dts/ti/k3-am64-tqma64xxl-mbax4xxl-wlan.dtso
new file mode 100644
index 0000000000000..32596a84b7ba1
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am64-tqma64xxl-mbax4xxl-wlan.dtso
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 TQ-Systems GmbH <linux@ew.tq-group.com>, D-82229 Seefeld, Germany.
+ */
+
+/dts-v1/;
+/plugin/;
+
+&sdhci1 {
+	mmc-pwrseq = <&wifi_pwrseq>;
+	no-sd;
+	status = "okay";
+};
+
+&main_gpio0 {
+	line43-hog {
+		gpio-hog;
+		gpios = <43 0>;
+		line-name = "MMC1_CTRL";
+		output-high;
+	};
+};
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

