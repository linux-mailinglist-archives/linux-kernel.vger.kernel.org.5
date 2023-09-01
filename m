Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AED78F914
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348486AbjIAH1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345419AbjIAH1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:27:49 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837A8CFE;
        Fri,  1 Sep 2023 00:27:43 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout1.routing.net (Postfix) with ESMTP id B59283FF3B;
        Fri,  1 Sep 2023 07:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1693553261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kIjOu9XgiejjBGgxALVhj8CipJIkLUKJc8BINq5SLgk=;
        b=jdy1+n1CvunsgfhGiX0wrC4o89x841J8EAsmKNy1Y23y8Jyp/C1sObUPbCpYyQRPndw5Ee
        zXrtEtfjDE61ibn7N5hEJBwhVGkViQJC23wmLzX4dvizlN26smsxuRzdifyhEXkkZA4toq
        B/fwRXHI0RHI1/Fxa0BP0fNhQIptlYg=
Received: from frank-G5.. (fttx-pool-80.245.79.3.bambit.de [80.245.79.3])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 4B95D3601E7;
        Fri,  1 Sep 2023 07:27:37 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1] arm64: dts: mt7986: add overlay for SATA power socket on BPI-R3
Date:   Fri,  1 Sep 2023 09:27:30 +0200
Message-Id: <20230901072730.13571-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 17c63c84-d582-4f38-896e-fd3131e7c05c
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Bananapi R3 has a Power socket entended for using external SATA drives.
This Socket is off by default but can be switched with gpio 8.

Add an overlay to activate it.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../mt7986a-bananapi-bpi-r3-sata.dtso         | 39 +++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sata.dtso

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index c99c3372a4b5..822d3e36d3df 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nand.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nor.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd.dtbo
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sata.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-rfb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986b-rfb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8167-pumpkin.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sata.dtso b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sata.dtso
new file mode 100644
index 000000000000..6ab06813412a
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sata.dtso
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2021 MediaTek Inc.
+ * Author: Frank Wunderlich <frank-w@public-files.de>
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	compatible = "bananapi,bpi-r3", "mediatek,mt7986a";
+
+	fragment@0 {
+		target-path = "/";
+		__overlay__ {
+			reg_sata12v: regulator-sata12v {
+				compatible = "regulator-fixed";
+				regulator-name = "sata12v";
+				regulator-min-microvolt = <12000000>;
+				regulator-max-microvolt = <12000000>;
+				gpio = <&pio 8 GPIO_ACTIVE_HIGH>;
+				enable-active-high;
+				regulator-always-on;
+			};
+
+			reg_sata5v: regulator-sata5v {
+				compatible = "regulator-fixed";
+				regulator-name = "sata5v";
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5000000>;
+				regulator-always-on;
+				vin-supply = <&reg_sata12v>;
+			};
+		};
+	};
+};
+
-- 
2.34.1

