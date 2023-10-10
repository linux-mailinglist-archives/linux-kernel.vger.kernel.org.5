Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC0C7BF97B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjJJLRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjJJLRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:17:41 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3084B7;
        Tue, 10 Oct 2023 04:17:38 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39ABHRFs045232;
        Tue, 10 Oct 2023 06:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696936647;
        bh=f3goIoTrjrBs5EwnCS2UuiWS0+VYrJ80vuluOlzf2iI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fvOiu16lWo6DB5aLM2925fc9F68tthWtrwy0+3/mhzF1H9LSHtBpwO27G+QTkazqT
         ieklVjSBG+0F3K0jrBxmzD5ef0UgUTl/laryHgYOGMa1LPAVboeuFzh2BIW3o4NyWH
         I58M2XzlcLwbglFWgmXIJFynQL0tC8M+1UKTGsmU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39ABHRBH020246
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Oct 2023 06:17:27 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Oct 2023 06:17:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Oct 2023 06:17:26 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39ABHPoi042363;
        Tue, 10 Oct 2023 06:17:26 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-j721s2-main: Add BCDMA instance for CSI2RX
Date:   Tue, 10 Oct 2023 16:47:22 +0530
Message-ID: <20231010111723.17524-2-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231010111723.17524-1-vaishnav.a@ti.com>
References: <20231010111723.17524-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J721S2 has a dedicated BCDMA controller for the Camera Serial Interface.
Events from the BCDMA controller instance are routed through the
main UDMA interrupt aggregator as unmapped events. Add the node for
the DMA controller and keep it disabled by default.

See J721S2 Technical Reference Manual (SPRUJ28)
for further details: http://www.ti.com/lit/pdf/spruj28

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

V1->V2:
    * Fix indentation for the reg entries.

 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 6d32544c8881..d5d13d61ade3 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -807,6 +807,7 @@
 			ti,sci = <&sms>;
 			ti,sci-dev-id = <265>;
 			ti,interrupt-ranges = <0 0 256>;
+			ti,unmapped-event-sources = <&main_bcdma_csi>;
 		};
 
 		secure_proxy_main: mailbox@32c00000 {
@@ -1103,6 +1104,22 @@
 			ti,sci-rm-range-rflow = <0x00>; /* GP RFLOW */
 		};
 
+		main_bcdma_csi: dma-controller@311a0000 {
+			compatible = "ti,j721s2-dmss-bcdma-csi";
+			reg = <0x00 0x311a0000 0x00 0x100>,
+			      <0x00 0x35d00000 0x00 0x20000>,
+			      <0x00 0x35c00000 0x00 0x10000>,
+			      <0x00 0x35e00000 0x00 0x80000>;
+			reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt";
+			msi-parent = <&main_udmass_inta>;
+			#dma-cells = <3>;
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <225>;
+			ti,sci-rm-range-rchan = <0x21>;
+			ti,sci-rm-range-tchan = <0x22>;
+			status = "disabled";
+		};
+
 		cpts@310d0000 {
 			compatible = "ti,j721e-cpts";
 			reg = <0x0 0x310d0000 0x0 0x400>;
-- 
2.17.1

