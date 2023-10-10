Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B287BF748
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjJJJ13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjJJJ1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:27:24 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF79694;
        Tue, 10 Oct 2023 02:27:22 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39A9R5tl107121;
        Tue, 10 Oct 2023 04:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696930025;
        bh=D2IGiPDYKpC0zOzjj5FGs/m5JW+z/i2Nu5bmrKfakq8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CMXjPxEEip6I+SASk7Cyh0ShknYBPJf0owDpZtN6H8laJgdxbiuofelL15kqpuqSa
         IvgklUNZKernw8e+V5EmytyaeZU9/ps7PW7RibfsnqgAszmHjKTDAjSBg31Bo4B7XC
         w2PM6lTVYNutWHd8H3M5gTjx3wJ6b8IxQpXHq0SQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39A9R5u7096963
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Oct 2023 04:27:05 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Oct 2023 04:27:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Oct 2023 04:27:05 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39A9R4HT079451;
        Tue, 10 Oct 2023 04:27:05 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>, <u-kumar1@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-j784s4-main: Add BCDMA instance for CSI2RX
Date:   Tue, 10 Oct 2023 14:57:00 +0530
Message-ID: <20231010092700.2089-3-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231010092700.2089-1-vaishnav.a@ti.com>
References: <20231010092700.2089-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J784S4 has a dedicated BCDMA controller for the Camera Serial Interface.
Events from the BCDMA controller instance are routed through the
main UDMA interrupt aggregator as unmapped events. Add the node for
the DMA controller and keep it disabled by default.

See J784S4 Technical Reference Manual (SPRUJ52)
for further details: http://www.ti.com/lit/zip/spruj52

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index efed2d683f63..a772f563c1ed 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -703,6 +703,7 @@
 			ti,sci = <&sms>;
 			ti,sci-dev-id = <321>;
 			ti,interrupt-ranges = <0 0 256>;
+			ti,unmapped-event-sources = <&main_bcdma_csi>;
 		};
 
 		secure_proxy_main: mailbox@32c00000 {
@@ -1000,6 +1001,22 @@
 			ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
 		};
 
+		main_bcdma_csi: dma-controller@311a0000 {
+			compatible = "ti,j721s2-dmss-bcdma-csi";
+			reg = <0x00 0x311a0000 0x00 0x100>,
+				<0x00 0x35d00000 0x00 0x20000>,
+				<0x00 0x35c00000 0x00 0x10000>,
+				<0x00 0x35e00000 0x00 0x80000>;
+			reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt";
+			msi-parent = <&main_udmass_inta>;
+			#dma-cells = <3>;
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <281>;
+			ti,sci-rm-range-rchan = <0x21>;
+			ti,sci-rm-range-tchan = <0x22>;
+			status = "disabled";
+		};
+
 		cpts@310d0000 {
 			compatible = "ti,j721e-cpts";
 			reg = <0x00 0x310d0000 0x00 0x400>;
-- 
2.17.1

