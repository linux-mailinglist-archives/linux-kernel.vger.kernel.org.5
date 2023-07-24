Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0A675F3A7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjGXKlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjGXKlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:41:20 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2989107;
        Mon, 24 Jul 2023 03:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1690195276; x=1721731276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OURxuQskE7K3r2Yh/wCDQ09pFOr0qamiXk2zVI9QFoQ=;
  b=S8do5/17YTjmzMI5OMFw/wYcKh51F5lrBHwRUGDmvSYOI21Qj9sgPVkx
   a5AyE1mROFG3+HGOelIal5OPG2h6LfNSjdr1Rud1McAhAYJLu58uSzE9y
   RXh5glyy84SC8VsmTBUdHM0J3iNqg7Ht53JJQ038cui6k4fPdsUwXW2vR
   7cow2AobvHHTUGq44kQitfIDE8D9IJL2QZFMK5XMMyjlb1+cID9ytR+VP
   y+EbKZTpLjYq1dkbweN9FH1fXNVMMeb6zn0wdBGxRn3e/7+VZ0vEOqqPR
   mniWIMLWViExyJnymy+230jUw0mdPJVMzy4K+vMGnAUlwAcrg5yrKzMPc
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684792800"; 
   d="scan'208";a="32078528"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 24 Jul 2023 12:41:09 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.20])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id E1D1328008A;
        Mon, 24 Jul 2023 12:41:08 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 3/3] arm64: dts: ti: k3-am64-tqma64xxl-mbax4xxl: add SD-card and WLAN overlays
Date:   Mon, 24 Jul 2023 12:40:50 +0200
Message-Id: <adacb622f5cf026775c988cdedb812d23152b3c8.1690195151.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <867f55a4ac865b979fa58a8828e0d0cade619843.1690195151.git.matthias.schiffer@ew.tq-group.com>
References: <867f55a4ac865b979fa58a8828e0d0cade619843.1690195151.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

v2: no changes

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

