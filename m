Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5E77BA5BD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242060AbjJEQTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240601AbjJEQPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:15:31 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2185.outbound.protection.outlook.com [40.92.63.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823A95591;
        Thu,  5 Oct 2023 07:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1Kx8cjyvxuH9XPqD05oezu55S2J7ZsUjhrTAGuDrrbZq/29D64JOrpL4Y7js6UNC2sNrNU3fWhsNOXEgsFfD/xWKuiRubDHAHp0JXkOrujqJptFydGHTZGLPPXZTfj1QjsMon+yLhpi3x0pK/2iMH+GFpleDuNzgZabgaVvCRK2DBnL2yv+d1ndp35PyOZ/rHz0DRFUzHYwLYYm6G2GBgNQDC6xGLJJqS5D/0wqP9NnacXsYkjrjz6ycaCaRov7hHefzXJfMFncT/iLvVJ7xBBoH8AThJvsJqB44zQQNf/KrRHxTN6xh9OR5LIcVPO/PM8/AGT9cTjmN5AzvVRIvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BafRdhJK4lZJDowAeN3ZJZ56xRfr68nSF9HOpCvkgkU=;
 b=KBlkbIq4vKu3ncVw0Li1fjbEFcvFqhDqUFYAKIFsAca3LHWAqcqv3V014hHdE/MzKQACTr3q4w9unb6Hb35Ul0AB7crG8JIsRc0ZLg5OA4p4Rep10raUbGIGpEl+uPszFi1TuzLS7Mq29zDJrWeHE0GpzAVy3lMEWLfzGu+mLn0jLJihCaD+/vgMtiEltIHVjgXcAqhptwUf7C77GYZFOw7Xy5vZGsqvXZywivph/A7lKQK0OaPjgUbW2RAapUiZDjjY+ICVAa9swX7lW0tpBtcKHvep10p3+plov6jI6TqhTDSV/KPHNa+gUtvL2F79vSNCpC5iicz0yganvzWThw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BafRdhJK4lZJDowAeN3ZJZ56xRfr68nSF9HOpCvkgkU=;
 b=O2FqSFs679wKthNUoTNL7hXT8uuGWsCq4jtm14f/L8Urq46N9+nhpybAgHVsc3EC/A1/yuyH4EsYxFYOn3bj530TmcYDl9gtiuuBH8HINklSu3185kkT96CeAF2YMFs3a0MDW+POzI1rgEJTteKT63HBYGlVttXU49YUY42PpxllGWehP16ehZEdsp/8bOeZrNqoE5Xvk/+g654n3SWbFhs/HYaaJRZWdRk1jTGDSUDwN/j0dk76ClJ82Woy6xIGofP1rV2Z3DyQyYuZmrgbjQb0GfkSSYCT0xOO/9BybqVjQD0fkOFHT+yUN76w+1eeXK938fnA2SrC2pgEzI9NqQ==
Received: from SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1e3::6) by
 ME4P282MB1366.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:97::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20; Thu, 5 Oct 2023 14:31:46 +0000
Received: from SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 ([fe80::448c:c25:de75:905a]) by SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 ([fe80::448c:c25:de75:905a%7]) with mapi id 15.20.6792.020; Thu, 5 Oct 2023
 14:31:46 +0000
From:   ZeYan Li <qaz6750@outlook.com>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ZeYan Li <qaz6750@outlook.com>
Subject: [PATCH 2/2] arm64: dts: qcom: Add device tree for Xiaomi Mi 9
Date:   Thu,  5 Oct 2023 22:31:31 +0800
Message-ID: <SY7P282MB3787E3A1FE3DA22CC6701BFBB2CAA@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [j02nBnNmZCyG77xzFeDfZ7Mm8HRM1P/K]
X-ClientProxiedBy: TYCP286CA0115.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::19) To SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:1e3::6)
X-Microsoft-Original-Message-ID: <20231005143131.9032-1-qaz6750@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY7P282MB3787:EE_|ME4P282MB1366:EE_
X-MS-Office365-Filtering-Correlation-Id: ef0d80dd-0c7f-44d2-b9ca-08dbc5afcda0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 61gHe/4ihGd6JjZc/fu3W8WgwAQfbWlqefmcEqO2xBy6UMCeZtGW5PZj+CS0JRJAphIOAbhLouy651MjhK7iOqR9d2VOPcnkCN8FR4+oW/h4LTAw1vtLNwgVewaqIVnQed7ztAFad8XQmLps9P4wbBMy6afrQsizjqdKpWWwg2t7NNGKIJGs0p1MRCRuZgDhfCDV7Lnnlxormwb5XFQ0EdkRgD3cNLgW4JMdI8iAUHSt7zyhky6rmbtQmDNMjueX03xFvt/JgQtOJ0SwdapJuNLU9ThO6OhtAJv2txoo+CaqbuTA1dTzy5sbdZo7IJof8fDaMZv2YYBd3ooz4pt5CrqBBLmgn983fXf/csU46i6/ENdAT7qlL7mY5INwjhbtpbd0TBOx2O1sNAZSjPw/e0ewVyu8kC+Tn4CFm2i1xmN+ay+n15Po5Jr9cT/j7zbsx9CYdXDu0oDVHWRnsRQGeIBBWIgKDQ64n/UlBZLXs7MlXWRutcr/Al9J28T9fBs436ZZIwThJMuJGfCNwKoV9VH9l05a7SWUCxTBbPUen/e/HprFwx0MY/8SKm0uoBUvcGwnDjtyzo3oOx0l9+Guhhl/I/hh+l5x2mn9q3M312VZMkNa4w1Qszte+VrwEkLU
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eJEblWdVn//HjNZfNGlbceBpnzEjaVO+G34Cr1zzo2Q96OXxTXBlBE9+ub+8?=
 =?us-ascii?Q?LW6IMgeDZNMINZpplUoALn5ttdlkf7uKrolEBq1/0Uff/vj9Mztjf9gGRE+4?=
 =?us-ascii?Q?DZU8GNkwtP3R/qeyCZ4ADF6QN+WhDxr4rmt11DoUV+ln69dMSn1HOuOc8xgA?=
 =?us-ascii?Q?HOu0cDGViMmE2uuUhMHVTE7HTeD6dzp0he82hnPvOBe8bCpd8pMG29htXsqJ?=
 =?us-ascii?Q?Lrro28yx+IBrk0Apl50wmH3ulqszzmtdph7VF+Gv1MV/ek6VaYSv1QO1FMTw?=
 =?us-ascii?Q?m7TGM+FYrq3a7IZxaWonSf6SQx/PcIMvGe1FtdoWofp0spV/OhHWCqpoeH/K?=
 =?us-ascii?Q?KnmHYd8/CZNfFG0t54WxAWXbgUCKklTLigpCe5csdhLmH0rZmQszNLg7o8mm?=
 =?us-ascii?Q?kSo7KKT/Lfa70RgQEiD4zycswlfx1O6uEYbSjk6xsHvOfuo40E/NB5rQNaVl?=
 =?us-ascii?Q?d5ewkZXQVd+sP6Jje1vgwUUSV0ntxfJDnEB5OtToUUkl3JK943DyZZ/fqjrZ?=
 =?us-ascii?Q?QsJjzqIBS4Oj34ZksKF4Rr/suwnF/5LZeXV0JY+q/UlNkE2UbGCA+husNGkK?=
 =?us-ascii?Q?PHDLEXYsuqW31MHHPV+cchYKQy4Y06Nutjy6XcL04WLk1nf4erZkb+wsqLBl?=
 =?us-ascii?Q?DYl9btAd27m9qDC2M8SffTn1cZV6jGVx6faTaJFXRyuu9dFYKTMIaKfqqdGH?=
 =?us-ascii?Q?12jS4M48d7Q+5o8y/yhSwiHOEpjyEqT7ZoCAQOHvn7MtaZ/toUEj/zq3Fe6r?=
 =?us-ascii?Q?YICiAtKkoHAcIo7ZAtcYH4u8sN5wMhCB967pD7s6DXQXJbfTcSHwE7RHbNOo?=
 =?us-ascii?Q?hadM7lEUXCAxCOaBGb7iF/1J8AYxSj2vyr1mUYQ/jw+YuLKmLmSvrbzKg+1W?=
 =?us-ascii?Q?96ck4i5RHkEJK35Zf2YoQvuGS+mNz5eZx+ofW9wYh2RKZaOHJCEh4fCKEbw6?=
 =?us-ascii?Q?tq/msoxYrgONF/OyUSFJWh4cfMbANhaoKZ0h/ePq4rPYgISQnIUa/Qqo75BU?=
 =?us-ascii?Q?ZXzBsVHTAD2wXH5RXMFPHkNIfqzqgtTdiBBaj+ubeKoIrkBG3rW+b6eJvEOa?=
 =?us-ascii?Q?MALJH8WWD56fA8vhfVPZq7wJBd2ENYcKuIONH7xJAwvEFKe0FcbEWVpEsN36?=
 =?us-ascii?Q?Bqsyj6EPDTbRWfpwo5T26C27TNB1QnN76Nf84FhNMUvXtD1eObE02BBuC7yh?=
 =?us-ascii?Q?UZ8/JZOYYLIZgHI/EcUBaZAfN6LrL3xEXZLVag=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0d80dd-0c7f-44d2-b9ca-08dbc5afcda0
X-MS-Exchange-CrossTenant-AuthSource: SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 14:31:46.6072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB1366
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds initial support for the Xiaomi Mi 9.

Signed-off-by: ZeYan Li <qaz6750@outlook.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/sm8150-xiaomi-cepheus.dts   | 610 ++++++++++++++++++
 2 files changed, 611 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8150-xiaomi-cepheus.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index d6cb840b7050..75e9657d7d57 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -214,6 +214,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-microsoft-surface-duo.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-sony-xperia-kumano-bahamut.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-sony-xperia-kumano-griffin.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-xiaomi-cepheus.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx203.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8150-xiaomi-cepheus.dts b/arch/arm64/boot/dts/qcom/sm8150-xiaomi-cepheus.dts
new file mode 100644
index 000000000000..bc4f3533455a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8150-xiaomi-cepheus.dts
@@ -0,0 +1,610 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023, Zeyan Li <qaz6750@outlook.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/input/gpio-keys.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include "sm8150.dtsi"
+#include "pm8150.dtsi"
+#include "pm8150b.dtsi"
+#include "pm8150l.dtsi"
+
+/*
+ * Delete following upstream (sm8150.dtsi) reserved
+ * memory mappings which are different in this device.
+ */
+/delete-node/ &tz_mem;      /* same address but larger, no place for rmtfs_mem! */
+/delete-node/ &rmtfs_mem;   /* moved to completely different address */
+/delete-node/ &adsp_mem;    /* same start address, but larger size */
+/delete-node/ &mpss_mem;    /* same size, shifted higher, due to larger adsp_mem */
+/delete-node/ &venus_mem;   /* same size, shifted higher */
+/delete-node/ &slpi_mem;    /* same size, shifted higher */
+/delete-node/ &ipa_fw_mem;  /* same size, shifted higher */
+/delete-node/ &ipa_gsi_mem; /* same size, shifted higher */
+/delete-node/ &gpu_mem;     /* same size, shifted higher */
+/delete-node/ &spss_mem;    /* same size, shifted higher */
+/delete-node/ &cdsp_mem;    /* same size, shifted higher */
+
+/ {
+	model = "xiaomi Mi 9";
+	compatible = "xiaomi,cepheus", "qcom,sm8150";
+	chassis-type = "handset";
+	/* Required for bootloader to select correct board */
+	qcom,board-id = <37 0>;
+
+	aliases {
+		serial0 = &uart2;
+		display0 = &framebuffer;
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		framebuffer: framebuffer@9c000000 {
+			compatible = "simple-framebuffer";
+			reg = <0 0x9c000000 0 0x2400000>;
+			status = "okay";
+			width = <1080>;
+			height = <2340>;
+			stride = <(1080 * 4)>;
+			format = "a8r8g8b8";
+			/*
+			 * That's (going to be) a lot of clocks, but it's necessary due
+			 * to unused clk cleanup & no panel driver yet (& no dispcc either)..
+			 */
+			clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
+				 <&gcc GCC_DISP_SF_AXI_CLK>;
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&ai_key_pin_a &vol_up_pin_a>;
+
+		vol_up {
+			label = "volume_up";
+			gpios = <&pm8150_gpios 6 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_KEY>;
+			linux,code = <KEY_VOLUMEUP>;
+			wakeup-source;
+			debounce-interval = <15>;
+		};
+
+		ai_key {
+			label = "ai_key";
+			gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_KEY>;
+			linux,code = <KEY_HOMEPAGE>; /* no AI key in Linux */
+			wakeup-source;
+			debounce-interval = <39>;
+		};
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+	};
+
+	/*
+	 * Apparently RPMh does not provide support for PM8150 S4 because it
+	 * is always-on; model it as a fixed regulator.
+	 */
+	vreg_s4a_1p8: pm8150-s4 {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_s4a_1p8";
+
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+
+		vin-supply = <&vph_pwr>;
+	};
+
+		reserved-memory {
+		tz_mem: memory@86200000 {
+			no-map;
+			reg = <0x0 0x86200000 0x0 0x5500000>;
+		};
+
+		adsp_mem: memory@8be00000 {
+			no-map;
+			reg = <0x0 0x8be00000 0x0 0x2200000>;
+		};
+
+		mpss_mem: memory@8e000000 {
+			no-map;
+			reg = <0x0 0x8e000000 0x0 0x9600000>;
+		};
+
+		venus_mem: memory@97600000 {
+			no-map;
+			reg = <0x0 0x97600000 0x0 0x500000>;
+		};
+
+		slpi_mem: memory@97b00000 {
+			no-map;
+			reg = <0x0 0x97b00000 0x0 0x1400000>;
+		};
+
+		ipa_fw_mem: memory@98f00000 {
+			no-map;
+			reg = <0x0 0x98f00000 0x0 0x10000>;
+		};
+
+		ipa_gsi_mem: memory@98f10000 {
+			no-map;
+			reg = <0x0 0x98f10000 0x0 0x5000>;
+		};
+
+		gpu_mem: memory@98f15000 {
+			no-map;
+			reg = <0x0 0x98f15000 0x0 0x2000>;
+		};
+
+		spss_mem: memory@99000000 {
+			no-map;
+			reg = <0x0 0x99000000 0x0 0x100000>;
+		};
+
+		cdsp_mem: memory@99100000 {
+			no-map;
+			reg = <0x0 0x99100000 0x0 0x1400000>;
+		};
+
+		cont_splash_mem: memory@9c000000 {
+			reg = <0x0 0x9c000000 0x0 0x2400000>;
+			no-map;
+		};
+
+		cdsp_sec_mem: memory@a4c00000 {
+			reg = <0x0 0xa4c00000 0x0 0x3c00000>;
+			no-map;
+		};
+
+		ramoops@a1600000 {
+			compatible = "ramoops";
+			reg = <0x0 0xa1600000 0x0 0x800000>;
+			console-size = <0x400000>;
+			ecc-size = <0>;
+			ftrace-size = <0>;
+			pmsg-size = <0x200000>;
+			record-size = <0>;
+			no-map;
+		};
+
+		rmtfs_mem: memory@fe101000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0 0xfe101000 0 0x300000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+		};
+	};
+};
+
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pm8150-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+
+		vdd-l1-l8-l11-supply = <&vreg_s6a_0p9>;
+		vdd-l2-l10-supply = <&vreg_bob>;
+		vdd-l3-l4-l5-l18-supply = <&vreg_s6a_0p9>;
+		vdd-l6-l9-supply = <&vreg_s8c_1p3>;
+		vdd-l7-l12-l14-l15-supply = <&vreg_s5a_2p0>;
+		vdd-l13-l16-l17-supply = <&vreg_bob>;
+
+		vreg_s5a_2p0: smps5 {
+			regulator-min-microvolt = <1904000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		vreg_s6a_0p9: smps6 {
+			regulator-min-microvolt = <920000>;
+			regulator-max-microvolt = <1128000>;
+		};
+
+		vdda_wcss_pll:
+		vreg_l1a_0p75: ldo1 {
+			regulator-min-microvolt = <752000>;
+			regulator-max-microvolt = <752000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdd_pdphy:
+		vdda_usb_hs_3p1:
+		vreg_l2a_3p1: ldo2 {
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3a_0p8: ldo3 {
+			regulator-min-microvolt = <480000>;
+			regulator-max-microvolt = <932000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdd_usb_hs_core:
+		vdda_csi_0_0p9:
+		vdda_csi_1_0p9:
+		vdda_csi_2_0p9:
+		vdda_csi_3_0p9:
+		vdda_dsi_0_0p9:
+		vdda_dsi_1_0p9:
+		vdda_dsi_0_pll_0p9:
+		vdda_dsi_1_pll_0p9:
+		vdda_pcie_1ln_core:
+		vdda_pcie_2ln_core:
+		vdda_pll_hv_cc_ebi01:
+		vdda_pll_hv_cc_ebi23:
+		vdda_qrefs_0p875_5:
+		vdda_sp_sensor:
+		vdda_ufs_2ln_core_1:
+		vdda_ufs_2ln_core_2:
+		vdda_usb_ss_dp_core_1:
+		vdda_usb_ss_dp_core_2:
+		vdda_qlink_lv:
+		vdda_qlink_lv_ck:
+		vreg_l5a_0p875: ldo5 {
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6a_1p2: ldo6 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7a_1p8: ldo7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vddpx_10:
+		vreg_l9a_1p2: ldo9 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10a_2p5: ldo10 {
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11a_0p8: ldo11 {
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdd_qfprom:
+		vdd_qfprom_sp:
+		vdda_apc_cs_1p8:
+		vdda_gfx_cs_1p8:
+		vdda_usb_hs_1p8:
+		vdda_qrefs_vref_1p8:
+		vddpx_10_a:
+		vreg_l12a_1p8: ldo12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l13a_2p7: ldo13 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2704000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l14a_1p8: ldo14 {
+			regulator-min-microvolt = <1880000>;
+			regulator-max-microvolt = <1880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l15a_1p7: ldo15 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1704000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l16a_2p7: ldo16 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l17a_3p0: ldo17 {
+			regulator-min-microvolt = <2856000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pm8150l-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+
+		vdd-l1-l8-supply = <&vreg_s4a_1p8>;
+		vdd-l2-l3-supply = <&vreg_s8c_1p3>;
+		vdd-l4-l5-l6-supply = <&vreg_bob>;
+		vdd-l7-l11-supply = <&vreg_bob>;
+		vdd-l9-l10-supply = <&vreg_bob>;
+
+		vdd-bob-supply = <&vph_pwr>;
+		vdd-flash-supply = <&vreg_bob>;
+		vdd-rgb-supply = <&vreg_bob>;
+
+		vreg_bob: bob {
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <4000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+			regulator-allow-bypass;
+		};
+
+		vreg_s8c_1p3: smps8 {
+			regulator-min-microvolt = <1352000>;
+			regulator-max-microvolt = <1352000>;
+		};
+
+		vreg_l1c_1p8: ldo1 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdda_wcss_adcdac_1:
+		vdda_wcss_adcdac_22:
+		vreg_l2c_1p3: ldo2 {
+			regulator-min-microvolt = <1304000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdda_hv_ebi0:
+		vdda_hv_ebi1:
+		vdda_hv_ebi2:
+		vdda_hv_ebi3:
+		vdda_hv_refgen0:
+		vdda_mipi_dsi0_1p2:
+		vdda_mipi_dsi1_1p2:
+		vdda_qlink_hv_ck:
+		vreg_l3c_1p2: ldo3 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vddpx_5:
+		vreg_l4c_1p8: ldo4 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <2928000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vddpx_6:
+		vreg_l5c_1p8: ldo5 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <2928000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vddpx_2:
+		vreg_l6c_2p9: ldo6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7c_3p0: ldo7 {
+			regulator-min-microvolt = <2856000>;
+			regulator-max-microvolt = <3104000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8c_1p8: ldo8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9c_2p9: ldo9 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10c_3p3: ldo10 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11c_3p3: ldo11 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+};
+
+&i2c4 {
+	status = "okay";
+
+	/* Qcom SMB1390 @ 10 */
+	/* Cirrus Logic CS35L41 boosted audio amplifier @ 40 */
+	/* IDTP9220 @ 3B  */
+};
+
+&i2c9 {
+	status = "okay";
+
+	/* NXP SN100T @ 28  */
+};
+
+&i2c10 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/* FingerTipS-Touch521 @ 49 */
+};
+
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
+&gpi_dma2 {
+	status = "okay";
+};
+
+&pm8150_gpios {
+	vol_up_pin_a: vol-up-active {
+		pins = "gpio6";
+		function = "normal";
+		input-enable;
+		bias-pull-up;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+	};
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&qupv3_id_1 {
+	status = "okay";
+};
+
+&qupv3_id_2 {
+	status = "okay";
+};
+
+&remoteproc_adsp {
+	status = "okay";
+	firmware-name = "qcom/sm8150/xiaomi/cepheus/adsp.mbn";
+};
+
+&remoteproc_cdsp {
+	status = "okay";
+	firmware-name = "qcom/sm8150/xiaomi/cepheus/cdsp.mbn";
+};
+
+&remoteproc_mpss {
+	status = "okay";
+	firmware-name = "qcom/sm8150/xiaomi/cepheus/modem.mbn";
+};
+
+&remoteproc_slpi {
+	status = "disabled";
+	firmware-name = "qcom/sm8150/xiaomi/cepheus/slpi.mbn";
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
+&tlmm {
+	gpio-reserved-ranges = <0 4>, <126 4>;
+
+	ai_key_pin_a: ai-key-pin-active {
+		pins = "gpio97";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&ufs_mem_hc {
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	status = "okay";
+};
+
+&usb_1_hsphy {
+	status = "okay";
+	vdda-pll-supply = <&vreg_l5a_0p875>;
+	vdda18-supply = <&vreg_l12a_1p8>;
+	vdda33-supply = <&vreg_l2a_3p1>;
+};
+
+&usb_1_qmpphy {
+	status = "okay";
+	vdda-phy-supply = <&vreg_l3c_1p2>;
+	vdda-pll-supply = <&vreg_l5a_0p875>;
+};
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	snps,has-lpm-erratum;
+	snps,hird-threshold = /bits/ 8 <0x10>;
+	maximum-speed = "high-speed";
+	dr_mode = "peripheral";
+};
+
+&wifi {
+	status = "okay";
+
+	vdd-0.8-cx-mx-supply = <&vdda_wcss_pll>;
+	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
+	vdd-1.3-rfa-supply = <&vreg_l2c_1p3>;
+	vdd-3.3-ch0-supply = <&vreg_l11c_3p3>;
+};
\ No newline at end of file
-- 
2.34.1

