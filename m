Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D3C761103
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjGYKhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjGYKhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:37:08 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D01188;
        Tue, 25 Jul 2023 03:37:04 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36PAautL128618;
        Tue, 25 Jul 2023 05:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690281416;
        bh=Gx3pkO743ZYy70rdXZr1aUnKtpWrxfRjEon4KIhVveE=;
        h=From:To:CC:Subject:Date;
        b=ts2X9QlawMADm+QctN7ScpVIZKMip1VfN7Y7wHnTYqoM5FAY+v0GzxhTKkTRfFAwO
         yIOaXhQLLDKzcly/mBUfmnpea4bNMQxb6p0PwhSjhi6whaE/1ueJZcjKmXT/oS8+3c
         Ecrer+vherJsVO7haulg1Ku5uWV0CYEbT+3tYGMc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36PAauaO104450
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jul 2023 05:36:56 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jul 2023 05:36:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jul 2023 05:36:55 -0500
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36PAaqiN113828;
        Tue, 25 Jul 2023 05:36:52 -0500
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <rogerq@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-am62a7-sk: Enable dual role support for Type-C port
Date:   Tue, 25 Jul 2023 16:06:51 +0530
Message-ID: <20230725103651.1612-1-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB0 is interfaced with a Type-C DRP connector and is managed via a
USB PD controller. Add support for the Type-C port with dual data
and power sink role.

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
Changes since v1:
* Added space between node name and ":"
* Changed the node name from "tps6598x" to "usb-power-controller"

v1: https://lore.kernel.org/all/20230724115133.2226-1-r-gunasekaran@ti.com/

arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 33 +++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index d2cca6182738..cff283c75f8e 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -226,6 +226,24 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
 	clock-frequency = <400000>;
+
+	typec_pd0: usb-power-controller@3f {
+		compatible = "ti,tps6598x";
+		reg = <0x3f>;
+
+		connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			self-powered;
+			data-role = "dual";
+			power-role = "sink";
+			port {
+				usb_con_hs: endpoint {
+					remote-endpoint = <&usb0_hs_ep>;
+				};
+			};
+		};
+	};
 };
 
 &main_i2c1 {
@@ -290,6 +308,21 @@
 	status = "reserved";
 };
 
+&usbss0 {
+	status = "okay";
+	ti,vbus-divider;
+};
+
+&usb0 {
+	usb-role-switch;
+
+	port {
+		usb0_hs_ep: endpoint {
+			remote-endpoint = <&usb_con_hs>;
+		};
+	};
+};
+
 &usbss1 {
 	status = "okay";
 };

base-commit: 1e25dd7772483f477f79986d956028e9f47f990a
-- 
2.17.1

