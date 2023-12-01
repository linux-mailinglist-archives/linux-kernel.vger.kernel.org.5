Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B708002E0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 06:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377568AbjLAFKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 00:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377582AbjLAFK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 00:10:27 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C5C1980;
        Thu, 30 Nov 2023 21:10:24 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B15AETo049982;
        Thu, 30 Nov 2023 23:10:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701407414;
        bh=Qm78XzrRYE6dT0oIbU5WDgyx6hn0YmjpOZVu9WaEDzA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SKTuwNMu2tJRpd7gRXwYVtsSzZvOEIY8urdPJbDO3aGvHuihVmxX2K4+UHb0QGwCQ
         2HO3ZZqDu8Zko8C54sswENFpdCNEb86WHHh7csGq3FNFOD1cG4fwbyTdNfCzZeU3aq
         5VF2wAJNVKyoqF5D5oT4GEspfNwxe71cLskPyjk8=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B15AEG3016483
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Nov 2023 23:10:14 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 Nov 2023 23:10:13 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 Nov 2023 23:10:14 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B15ADUX024214;
        Thu, 30 Nov 2023 23:10:13 -0600
From:   Jai Luthra <j-luthra@ti.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Jai Luthra <j-luthra@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Julien Massot <julien.massot@collabora.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH RESEND v3 7/9] arm64: dts: ti: k3-am62a7-sk: Enable camera peripherals
Date:   Fri, 1 Dec 2023 10:39:22 +0530
Message-ID: <20231201-csi_dts-v3-7-9f06f31080fe@ti.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231201-csi_dts-v3-0-9f06f31080fe@ti.com>
References: <20231201-csi_dts-v3-0-9f06f31080fe@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=s5NY99U26dYVT2Xd40MgpPFPJ01pwWoG1kV6T+WuzsM=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlaWXw3Vd3zNFK6A93GkahZzKk2heSI0oiFXP7/
 KzdhkwLLGKJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZWll8AAKCRBD3pH5JJpx
 RaTrD/9um6J/5EdZbvxIkH36xGSs/9+sGwF6qrgKDtmFzaHyfQGo2wFxCm5sOotY3AsxPcNXKkY
 0i92BifDhRiyyMAxQaTT09OayjD/Q745SIjxD7zirXgY2eFBQxATWwVhSCK/UUWDkuRJXNIpEhp
 Sy29GHPqVut38WNtEkDz3YYihyBzfTSebnMIJQfxBh7PxQMn8taQMue5bqotx8ol503Nk/yPYnH
 xNKlLTr23mfpsaiRzbH2u1XIgiPHMWAB054K0UceYmp+f1iG81hxpkN4nAIm4jGBhfqAa8/FQtq
 kBtGsixBhjFAfTWjcQGVfHECIYm+e+Shn/kRzcocJjXoCMaQlsuozMSFodvNu14dXTBqo/BXaMI
 OppVoG9GqNCWEa6j0qU9QhHhUAS3N8GtLsmSkoj/isjjJ3TKBvaQY3CX9fcCtuvzrIBbc+TCzML
 BaNO2cRjQf04l8daf1Kk5+WLYMo4BM4nkAGc32HTni/QdbUrE4WFvPAXg19AQmWqpU/KMmsOyvp
 HnG2aZgKfuqua7oUCcyRD9hdAbNIuPYOjNDJekHswrby9/8nQqzZFiCl9zen+QVWlAkZTFvPtOW
 Hb3NgBNf24N4Y9Otc/y34AZrI+rDv1v0V3bEwpTo1PeFCNxTjFQLHJLxx5M/QcPX9c+YzmcDP6m
 mn/RI8gmc7QWyCg==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
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

Enable I2C-2 as it is used to control CSI based sensors. Also enable
IO-EXP-2 as it controls the mux between different CSI-2 connectors.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index 8f64ac2c7568..eb2f45a6ba23 100644
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

-- 
2.42.1

