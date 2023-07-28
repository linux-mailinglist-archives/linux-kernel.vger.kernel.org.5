Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9859767387
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbjG1RfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbjG1RfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:35:06 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07663A8B;
        Fri, 28 Jul 2023 10:35:04 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36SHYk9v127161;
        Fri, 28 Jul 2023 12:34:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690565686;
        bh=pDtWUriBKWXqnzYAqJp4o7247YUcH3BwNj7spNhcOsU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Bj5YQAoH+hpOqTz3on+ypa6kco8zMKz5m7tlOrEf08uZVlWC4GEkvlW8voxqUHohQ
         hbtc2w/t4Yshe9jiqywnzjSd0FJEm6jOHB4KSSinoLnROeydIjzcHndYLQ7jlBhs6x
         v75jIpVcyybvHBNLOWLecTBeQdUSUjTIGNYeklxc=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36SHYkhj121034
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Jul 2023 12:34:46 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jul 2023 12:34:45 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jul 2023 12:34:45 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36SHYjZg004026;
        Fri, 28 Jul 2023 12:34:45 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v3 4/8] arm64: dts: ti: k3-am62x-sk-common: Add HDMI support
Date:   Fri, 28 Jul 2023 23:04:34 +0530
Message-ID: <20230728173438.12995-5-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728173438.12995-1-a-bhatia1@ti.com>
References: <20230728173438.12995-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT nodes for sil9022 HDMI transmitter (TX), and the HDMI connector
on the AM625 SK and AM62-LP SK platforms.

Additionally, connect the outputu of DSS (VP2) with input of the HDMI TX,
and the output of HDMI TX to the input of the HDMI connector.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index d479c0c415a7..8fd80cf63d65 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -114,6 +114,17 @@ sound_master: simple-audio-card,codec {
 			clocks = <&tlv320_mclk>;
 		};
 	};
+
+	hdmi: connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&sii9022_out>;
+			};
+		};
+	};
 };
 
 &main_pmx0 {
@@ -371,6 +382,38 @@ tlv320aic3106: audio-codec@1b {
 		IOVDD-supply = <&vcc_3v3_sys>;
 		DRVDD-supply = <&vcc_3v3_sys>;
 	};
+
+	sii9022: sii9022@3b {
+		compatible = "sil,sii9022";
+		reg = <0x3b>;
+
+		interrupt-parent = <&exp1>;
+		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+
+		#sound-dai-cells = <0>;
+		sil,i2s-data-lanes = < 0 >;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				sii9022_in: endpoint {
+					remote-endpoint = <&dpi1_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				sii9022_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
 };
 
 &sdhci0 {
@@ -473,3 +516,14 @@ &dss {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_dss0_pins_default &main_oldi0_pins_default>;
 };
+
+&dss_ports {
+	/* VP2: DPI Output */
+	port@1 {
+		reg = <1>;
+
+		dpi1_out: endpoint {
+			remote-endpoint = <&sii9022_in>;
+		};
+	};
+};
-- 
2.40.1

