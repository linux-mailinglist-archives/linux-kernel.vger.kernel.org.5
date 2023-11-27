Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FA17FAA59
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjK0TgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjK0TgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:36:14 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09A8D5A;
        Mon, 27 Nov 2023 11:36:19 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ARJa4cU101037;
        Mon, 27 Nov 2023 13:36:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701113764;
        bh=iI7ZvtM2UEW3p1rnWnJJvLA76dVEiHpqzz31MDh7+4E=;
        h=From:To:CC:Subject:Date;
        b=dR8IECDwChavWD2mjflDtcmgLKzmw8YssZn/8qjC1V67oHtahP1m2vKyYZ/6O7mKT
         4Xubwks+cgv1eBG6JJO9KZb3CT/d8bBZO2DUx+PvWzXJIYQq2Oupduzto0Tb0fXP6X
         9EjyctEF/DxOhK+3bYCMfeG81dGLIVmUgX5O0tos=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ARJa4OM027994
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Nov 2023 13:36:04 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Nov 2023 13:36:03 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Nov 2023 13:36:03 -0600
Received: from lelv0327.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ARJa3c1060644;
        Mon, 27 Nov 2023 13:36:03 -0600
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-am625-beagleplay: Use UART name in pinmux name
Date:   Mon, 27 Nov 2023 13:36:02 -0600
Message-ID: <20231127193602.151499-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main_uart0 may not always be the console, but it will always be
the UART0 in MAIN domain. Name the pinmux node to match. This makes
it consistent with all other TI SoC based boards.

Signed-off-by: Andrew Davis <afd@ti.com>
---

Changes for v2:
 - Update node name to -pins postfix
 - Rebase on v6.7-rc1

 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index 9a6bd0a3c94f7..eadbdd9ffe377 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -443,7 +443,7 @@ AM62X_IOPAD(0x01a8, PIN_INPUT, 7) /* (D20) MCASP0_AFSX.GPIO1_12 */
 		>;
 	};
 
-	console_pins_default: console-default-pins {
+	main_uart0_pins_default: main-uart0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x01c8, PIN_INPUT, 0) /* (D14) UART0_RXD */
@@ -877,7 +877,7 @@ wlcore: wlcore@2 {
 &main_uart0 {
 	bootph-all;
 	pinctrl-names = "default";
-	pinctrl-0 = <&console_pins_default>;
+	pinctrl-0 = <&main_uart0_pins_default>;
 	status = "okay";
 };
 
-- 
2.39.2

