Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BCD780A54
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376371AbjHRKjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345501AbjHRKiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:38:51 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47A812C;
        Fri, 18 Aug 2023 03:38:49 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37IAcign060787;
        Fri, 18 Aug 2023 05:38:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692355124;
        bh=++tHZOxQVyjXEzaxXM5oI+J3Y6rU4s5mxcooRIrhNZ4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Yo+N0lHu9wTiLa0xrZQv6S/XFh0+cD0SqzFV/quAIOuCoA66Drl5FJX3xBE+pfVuX
         G9iEK9OroIlFyCOHBQrRPChL2yDeSL0CLZU9XMQVIoj8WIhO8ww66szqvMP+jixoH5
         AyWUsWOjvtHyLg5Sox8TJf0AvR8VfPyikkp/IjBw=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37IAcil9020280
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Aug 2023 05:38:44 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 18
 Aug 2023 05:38:44 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 18 Aug 2023 05:38:43 -0500
Received: from dhruva.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37IAcZ5a001102;
        Fri, 18 Aug 2023 05:38:41 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Mark Brown <broonie@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-am62-main: PM fixes in the fss node
Date:   Fri, 18 Aug 2023 16:07:49 +0530
Message-ID: <20230818103750.516309-2-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818103750.516309-1-d-gole@ti.com>
References: <20230818103750.516309-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

* Make use of Simple Power-Managed Bus as the fss bus controller is under
the control of a functional clock, and also is part of a PM domain.
* Specify the appropriate k3 pd to the fss node as per tisci docs [0].

[0] https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am62x/devices.html

Fixes: c37c58fdeb8a ("arm64: dts: ti: k3-am62: Add more peripheral nodes")
Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 284b90c94da8..b23c9e3d91cd 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -640,10 +640,11 @@ usb1: usb@31100000 {
 	};
 
 	fss: bus@fc00000 {
-		compatible = "simple-bus";
+		compatible = "simple-pm-bus";
 		reg = <0x00 0x0fc00000 0x00 0x70000>;
 		#address-cells = <2>;
 		#size-cells = <2>;
+		power-domains = <&k3_pds 74 TI_SCI_PD_EXCLUSIVE>;
 		ranges;
 
 		ospi0: spi@fc40000 {
-- 
2.34.1

