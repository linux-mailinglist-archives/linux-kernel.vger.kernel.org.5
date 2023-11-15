Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DD87EC036
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjKOJws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234842AbjKOJwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:52:42 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DE318D;
        Wed, 15 Nov 2023 01:52:31 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AF9qImS100743;
        Wed, 15 Nov 2023 03:52:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700041938;
        bh=PNUVApjVYaIGK9JiiY4OVOF3nsNslR6FLMX8Zywxucg=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=PFjK70W+5y9a82/TLUNRSGcOwROC4P0Ke4iRo6p85Mk+LydlJ3UKQindAcJAk3c8w
         2U6GYAsCRCeofef7V8ozm1co2HBMcT8lCwQZZCm/X/d5uapkN0p7JezrFGS3nlW2At
         HEe7+qPTQIV2sOBfNYzDMTwcSpjUzfhYYH3+2FWI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AF9qI37109218
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Nov 2023 03:52:18 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 Nov 2023 03:52:18 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 Nov 2023 03:52:17 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AF9qHto009790;
        Wed, 15 Nov 2023 03:52:17 -0600
From:   Jai Luthra <j-luthra@ti.com>
Date:   Wed, 15 Nov 2023 15:21:15 +0530
Subject: [PATCH 7/8] arm64: dts: ti: k3-am62a7-sk: Enable camera
 peripherals
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231115-csi_dts-v1-7-99fc535b2bde@ti.com>
References: <20231115-csi_dts-v1-0-99fc535b2bde@ti.com>
In-Reply-To: <20231115-csi_dts-v1-0-99fc535b2bde@ti.com>
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
        Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1496; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=gz9E1SzSNspg9BAAZhjLumqrDg19fknMHvxVHY3oO+E=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlVJS+SQwuO3y5czKQptuHNVtnvW/0c6tvCBl8y
 9qeg9MJ84WJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZVSUvgAKCRBD3pH5JJpx
 RWAAD/4vFcUOIxprUiXAS+TvJxuxnVBqtEX/d31DvULFnPjH9NdgZiimn/J7xeiXYPrhrRsHPOL
 DsVZauJc9GIOVbKKgU/DVr66JHHXbd2MupDQJUerw7uQKd1emkxMgP5K6gxoR6rgyJmi4jFMxRG
 e7oV3m7EAIrQfDnJIalNlXZNStLD7QUS1uSIo+Unkq69YZrLLibdy3NM5HP4i+2qOsGTIfTX8aW
 wuA5OL9FUBn5Gf4hyQRfV7EQ3L/AzobzM2fhLnGKKvBEsgFtkNU2RE1T0s4D9gFhGVlMG4KRr07
 dfFw1zuE8rK7jbBf9bVU+rHP/qSIzUvhKrr2hShQ6Y54wiI4b+ulAMzyOw9kRPYFw3v9l48gNaT
 NXgoCKrWe8+PAYQ42Sln6RuI1C3oLOrg3rChUcXSzRGAhdc1BzYqsx6txgTCdScZ32oan2KalWH
 1RGf1umjKZVOQeEL69aDHwkNlEQCOuP90yvASXvDGFW2/359lhOUwFn3yO7SXBPnnHD/0GPVPmz
 fiTLU3kO26CgZtHpzg9w+iqsyq/5hmKMxtoS4dMjbBdG+3nwsf7d0Nor6tmYFXk/afGqOBh+AIS
 jv44T+jjzaUVP5M7t1Aal4kKzmISSJTS7k2hcvauyWEmyGS4RJTsXXw3Qkjab1qPQvyh8BSIbbv
 DtZAA8FQernGuGA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
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

Enable the nodes for CSI-RX, DPHY-RX and I2C-2 as it is used to control
CSI based sensors. Also enable IO-EXP-2 as it controls the mux between
different CSI-2 connectors.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 35 +++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index 8f64ac2c7568..20ec07a5237c 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -434,6 +434,33 @@ tlv320aic3106: audio-codec@1b {
 		DRVDD-supply = <&vcc_3v3_sys>;
 		DVDD-supply = <&buck5>;
 	};
+
+	exp2: gpio@23 {
+		compatible = "ti,tca6424";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names = "", "",
+				  "", "",
+				  "", "",
+				  "", "",
+				  "WL_LT_EN", "CSI_RSTz",
+				  "", "",
+				  "", "",
+				  "", "",
+				  "SPI0_FET_SEL", "SPI0_FET_OE",
+				  "RGMII2_BRD_CONN_DET", "CSI_SEL2",
+				  "CSI_EN", "AUTO_100M_1000M_CONFIG",
+				  "CSI_VLDO_SEL", "SoC_WLAN_SDIO_RST";
+	};
+};
+
+&main_i2c2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c2_pins_default>;
+	clock-frequency = <400000>;
 };
 
 &sdhci1 {
@@ -544,3 +571,11 @@ &mcasp1 {
 	tx-num-evt = <32>;
 	rx-num-evt = <32>;
 };
+
+&ti_csi2rx0 {
+	status = "okay";
+};
+
+&dphy0 {
+	status = "okay";
+};

-- 
2.42.1

