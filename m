Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F2A7FB6DD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344098AbjK1KMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbjK1KKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:10:44 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB7610A;
        Tue, 28 Nov 2023 02:10:49 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ASAAdIT130530;
        Tue, 28 Nov 2023 04:10:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701166239;
        bh=Q9GfHFzHUPAETZ8jhp2saTZ+Xv19cmZBETN28QC0nhk=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=Ky7vmDyr0Rl5xR8C6Yz7BBRmhmaPC2+tCN8b1Y/VX+tDj9YGnqVVJBt49Vua/nc1E
         +2xv/n8U3+ahFkFkdAOUV/e6f4qnfu4KrLrbpixc7IctGT2iAVrCeW2bnYSniSmqtj
         TYNhVm9urTZzABO/cvIQUfHRlgJZE+7L4tJoC5R8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ASAAdDJ017691
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Nov 2023 04:10:39 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 Nov 2023 04:10:39 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 Nov 2023 04:10:38 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ASAAbHL125525;
        Tue, 28 Nov 2023 04:10:38 -0600
From:   Jai Luthra <j-luthra@ti.com>
Date:   Tue, 28 Nov 2023 15:39:51 +0530
Subject: [PATCH v3 9/9] arm64: dts: ti: Use OF_ALL_DTBS for combined blobs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231128-csi_dts-v3-9-0bb11cfa9d43@ti.com>
References: <20231128-csi_dts-v3-0-0bb11cfa9d43@ti.com>
In-Reply-To: <20231128-csi_dts-v3-0-0bb11cfa9d43@ti.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Julien Massot <julien.massot@collabora.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4271; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=DBLMWQAFX1Tzf8/HJoNJY/8QVwt817bQEtms+t6sTDU=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlZbyF3IhjJ5X3bCjqBnxoMzIQ3GkrVHXZZTfdw
 mBdnqbSjByJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZWW8hQAKCRBD3pH5JJpx
 Rar8EADPpaRLtsJQXmGW8Q+gW34blRbguI8y54fZpqg6z9AnFvQ7Hpf4eYUdQ6fgBKf4r4aM4vo
 8mRuCSI9CUHtUpLoHKwqNQT2S12B457mJdMcGDaVTDf0TW2/AipMUvisWVCSAGFMmyaV7b35AAi
 +REdYwk5cfZ/Ly5Bh2gCPSYD1MZOrMOrGo6jJRaac2ZbnGFU9Br48yEz1uNo6xnLerojvSCDy6v
 ZgCThKkYYFczxReGKEtEVI13KOevXxZ+yFd/Y3Fc8prxKWCW6p4dtVBaCgv18u14/i41N/O3YJJ
 HvZlwApWsLhd3Hc7aLEplz5iUbZqyErW+b+ZhbLMDKbL8i+gnUNfGZ+ngG3l5vnJZ47B9zNr0dk
 n9FoXQ39dcT4D0k/0rvUsrCJSnX9npMIU4NQ3IcPBrP+BVtE8ucUJ6UVBBbsV6uuwv8nPpcPXRk
 tgxezeBvl3NAHZ1pEnbq+J9jS05AemG/IOl22Hg9Z+Ys2ApiyDe+BM1UNlUynuOttylEV3KDd8h
 cjddZd119hMut/0A4QSvXGCiGd8wZEoMu5UxXaxsXcHqb2AM6ftg8j4vJXfmdI8Et5mZHLVgJkg
 teXlQAuyeJPLjdO+Abp7/J45o+DgDP1/2OfbG+AywcOkrYVi9FUB0WwwmynhDgg5Oxet334zUfQ
 9JgP/VjLLNYwncw==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combined dtb builds are only useful for making sure that the overlay
applies cleanly on the base dtb.

So we move all such combined blobs under a `dtb- +=` section that is
only built when OF_ALL_DTBS config is enabled.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index fd9166497c32..5ef49b02c71f 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -9,8 +9,6 @@
 # alphabetically.
 
 # Boards with AM62x SoC
-k3-am625-sk-hdmi-audio-dtbs := k3-am625-sk.dtb k3-am62x-sk-hdmi-audio.dtbo
-k3-am62-lp-sk-hdmi-audio-dtbs := k3-am62-lp-sk.dtb k3-am62x-sk-hdmi-audio.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay-csi2-ov5640.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay-csi2-tevi-ov5640.dtbo
@@ -23,8 +21,6 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dev.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-yavia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
-dtb-$(CONFIG_ARCH_K3) += k3-am625-sk-hdmi-audio.dtb
-dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk-hdmi-audio.dtb
 
 # Boards with AM62Ax SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
@@ -36,20 +32,15 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-csi2-ov5640.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-csi2-tevi-ov5640.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-csi2-imx219.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-hdmi-audio.dtbo
 
 # Boards with AM64x SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
-
-k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
-	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
-k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs := \
-	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
-
-dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb
-dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl-wlan.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
 
 # Boards with AM65x SoC
 k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb k3-am654-base-board-rocktech-rk101-panel.dtbo
@@ -98,26 +89,36 @@ k3-am625-sk-csi2-ov5640-dtbs := k3-am625-sk.dtb \
 	k3-am62x-sk-csi2-ov5640.dtbo
 k3-am625-sk-csi2-tevi-ov5640-dtbs := k3-am625-sk.dtb \
 	k3-am62x-sk-csi2-tevi-ov5640.dtbo
+k3-am625-sk-hdmi-audio-dtbs := k3-am625-sk.dtb k3-am62x-sk-hdmi-audio.dtbo
+k3-am62-lp-sk-hdmi-audio-dtbs := k3-am62-lp-sk.dtb k3-am62x-sk-hdmi-audio.dtbo
 k3-am62a7-sk-csi2-imx219-dtbs := k3-am62a7-sk.dtb \
 	k3-am62x-sk-csi2-imx219.dtbo
 k3-am62a7-sk-csi2-ov5640-dtbs := k3-am62a7-sk.dtb \
 	k3-am62x-sk-csi2-ov5640.dtbo
 k3-am62a7-sk-csi2-tevi-ov5640-dtbs := k3-am62a7-sk.dtb \
 	k3-am62x-sk-csi2-tevi-ov5640.dtbo
+k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
+	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
+k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs := \
+	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
 dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am625-beagleplay-csi2-tevi-ov5640.dtb \
 	k3-am625-sk-csi2-imx219.dtb \
 	k3-am625-sk-csi2-ov5640.dtb \
 	k3-am625-sk-csi2-tevi-ov5640.dtb \
+	k3-am625-sk-hdmi-audio.dtb \
+	k3-am62-lp-sk-hdmi-audio.dtb \
 	k3-am62a7-sk-csi2-imx219.dtb \
 	k3-am62a7-sk-csi2-ov5640.dtb \
-	k3-am62a7-sk-csi2-tevi-ov5640.dtb
+	k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb \
+	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb
 
 # Enable support for device-tree overlays
 DTC_FLAGS_k3-am625-beagleplay += -@
 DTC_FLAGS_k3-am625-sk += -@
 DTC_FLAGS_k3-am62-lp-sk += -@
 DTC_FLAGS_k3-am62a7-sk += -@
+DTC_FLAGS_k3-am642-tqma64xxl-mbax4xxl += -@
 DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
 DTC_FLAGS_k3-j721e-common-proc-board += -@
 DTC_FLAGS_k3-j721s2-common-proc-board += -@

-- 
2.42.1

