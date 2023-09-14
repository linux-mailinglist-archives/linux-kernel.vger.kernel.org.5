Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BA47A000F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbjINJa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236984AbjINJax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:30:53 -0400
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B3B1BFB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1694683846; x=1697275846;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BikrMtESuNp+DgxwHDrljdpsjzQ302FVUhgX7muuOUk=;
        b=lpkXwOUT0ck26Q2lbH75Gdhzvt+BV2lyGyqcC6WEEGpNfk2Yi7tAk2i8kJYN2YCR
        Hs62PkMQrQ5ot15wAwoMXnvQNV7sMJzvJkHCHbbg/tKuQFqBU+4q1H88ogyTQHeJ
        V+by2xr+dXJztt4bJGsLHlKOQTwRCKB2rFJp1FMGK0g=;
X-AuditID: ac14000a-6e25770000001e37-f1-6502d2c626ef
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id B9.F2.07735.6C2D2056; Thu, 14 Sep 2023 11:30:46 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 14 Sep
 2023 11:30:46 +0200
From:   Wadim Egorov <w.egorov@phytec.de>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <upstream@lists.phytec.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: ti: phycore-am64: Add RTC interrupt pin
Date:   Thu, 14 Sep 2023 11:30:27 +0200
Message-ID: <20230914093027.3901602-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWyRpKBR/fYJaZUg9ZFShZr9p5jsph/5Byr
        xfLPs9kt+l48ZLbY9Pgaq8XlXXPYLN78OMtk0br3CLtF9zt1i/9nP7A7cHlsWtXJ5nHn2h42
        j81L6j36u1tYPY7f2M7k8XmTXABbFJdNSmpOZllqkb5dAlfGiXWn2QvecFbcPPeQvYGxj6OL
        kZNDQsBE4uXRTqYuRi4OIYElTBLn19xghXCeMErcmXCXDaSKTUBd4s6Gb2AJEYFuRomTB5Yx
        gzjMAm2MEof2rmEEqRIWcJFY9fYNK4jNIqAqceH3axYQm1fAUuLz01NsEPvkJWZe+s4OEReU
        ODnzCVgNM1C8eetsZghbQuLgixdgthBQ/MWl5SwwvdPOvWaGsEMljmxazTSBUWAWklGzkIya
        hWTUAkbmVYxCuZnJ2alFmdl6BRmVJanJeimpmxhBkSDCwLWDsW+OxyFGJg7GQ4wSHMxKIrxs
        tkypQrwpiZVVqUX58UWlOanFhxilOViUxHnv9zAlCgmkJ5akZqemFqQWwWSZODilGhitpIKv
        lzAErJdyeXFTJPrhhM0lBSeNPXZM8FT35wxa4dvMe9NturTfJN9zej8v3/At5V8ZkSl/wL+O
        8UxwdEz3HKUuZQ0lvQyR0zMF/9k+tsz738Q968XMrM1OVfZ9hYdCuRsXPD0gJMSz4iTLXNfn
        tXVWB/+90lv4Xp5Z5dXc7+ZZUwq/pyixFGckGmoxFxUnAgDh8L4rcgIAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wth commit 16b26f602758 ("rtc: rv3028: Use IRQ flags obtained from device
tree if available") we can now use the interrupt pin of the RTC.
Let's add interrupt pin definitions to the SoM RTC.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
index 1c2c8f0daca9..f87f09d83c95 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
@@ -126,6 +126,12 @@ AM64X_IOPAD(0x0028, PIN_INPUT, 0)	/* (M17) OSPI0_D7 */
 			AM64X_IOPAD(0x002c, PIN_OUTPUT, 0)	/* (L19) OSPI0_CSn0 */
 		>;
 	};
+
+	rtc_pins_default: rtc-defaults-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0278, PIN_INPUT, 7)	/* (C19) EXTINTn.GPIO1_70 */
+		>;
+	};
 };
 
 &cpsw3g {
@@ -177,6 +183,11 @@ eeprom@50 {
 	i2c_som_rtc: rtc@52 {
 		compatible = "microcrystal,rv3028";
 		reg = <0x52>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&rtc_pins_default>;
+		interrupt-parent = <&main_gpio1>;
+		interrupts = <70 IRQ_TYPE_EDGE_FALLING>;
+		wakeup-source;
 	};
 };
 
-- 
2.25.1

