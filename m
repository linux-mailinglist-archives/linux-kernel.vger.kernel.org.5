Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B9580F360
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbjLLQlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjLLQli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:41:38 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364BF1B6;
        Tue, 12 Dec 2023 08:41:34 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCF3fML001333;
        Tue, 12 Dec 2023 16:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jy4/tffTntSGacJXt6QsY6IPV+TiYa52rsAHUe6V6F8=;
 b=W7aAYMmEfaohTFb9oxzfHVNVAo8i8exh4vgDeIz91kVY3lAhQyMTThHa2T/kORM9oMyd
 4ZBepGnPcHOy91BNgs0OSkS0jnv+XyA0C76Ow1a+PZDshzOVNxb9/yfYhGSXiTWRnpJD
 kSw6jj1ziBXk6O/yKd2NXLimCki0Dq6ED2qGQQi64vldVdprww8n+4l0M3h9TNIlXtsD
 fAEFxf71xktyZO1Pc4vgxz2dZMLs6VIKr+hQqRTBYf7Iw0h/tGzZToG4/RWCVsqfVgnR
 ra61vWF4qeF7NGq3ehov9PKmnE6aP8nc6iT0IkCs8Y5DkcqctqwX/BAxhB/Gum1sHcHF 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxpk3j9k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 16:40:23 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BCEaLha025472;
        Tue, 12 Dec 2023 16:40:22 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxpk3j9j1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 16:40:22 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCGHd5W008491;
        Tue, 12 Dec 2023 16:40:20 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw2jtamm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 16:40:20 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BCGeJk526608008
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 16:40:20 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1D8C58068;
        Tue, 12 Dec 2023 16:40:19 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 029E958059;
        Tue, 12 Dec 2023 16:40:18 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 12 Dec 2023 16:40:17 +0000 (GMT)
From:   Ninad Palsule <ninad@linux.ibm.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        ninad@linux.ibm.com, johannes.holland@infineon.com,
        linux@roeck-us.net, broonie@kernel.org
Cc:     Andrew Geissler <geissonator@yahoo.com>,
        patrick.rudolph@9elements.com, vincent@vtremblay.dev,
        peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com,
        bhelgaas@google.com, naresh.solanki@9elements.com,
        alexander.stein@ew.tq-group.com, festevam@denx.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v1 3/8] ARM: dts: aspeed: System1: IBM system1 BMC board
Date:   Tue, 12 Dec 2023 10:39:59 -0600
Message-Id: <20231212164004.1683589-4-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231212164004.1683589-1-ninad@linux.ibm.com>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z2tIFKZzvH28KmLX2eq70n-C6RyojVv4
X-Proofpoint-ORIG-GUID: FT8kNhgCIR2A8Ia5v3L7PLPmBuahJmXx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_10,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Geissler <geissonator@yahoo.com>

Add a device tree for IBM system1 BMC board. It uses AST2600 SOC.

Tested:
    This board is tested using the simics simulator.

Signed-off-by: Andrew Geissler <geissonator@yahoo.com>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 188 ++++++++++++++++++
 2 files changed, 189 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 3e3e6b96cb79..6f7ed11978ff 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -35,6 +35,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-ibm-rainier.dtb \
 	aspeed-bmc-ibm-rainier-1s4u.dtb \
 	aspeed-bmc-ibm-rainier-4u.dtb \
+	aspeed-bmc-ibm-system1.dtb \
 	aspeed-bmc-intel-s2600wf.dtb \
 	aspeed-bmc-inspur-fp5280g2.dtb \
 	aspeed-bmc-inspur-nf5280m6.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
new file mode 100644
index 000000000000..01291b407f59
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2023 IBM Corp.
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+#include <dt-bindings/leds/leds-pca955x.h>
+
+/ {
+	model = "System1";
+	compatible = "ibm,system1-bmc", "aspeed,ast2600";
+
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS4,115200n8 earlycon";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		event_log: tcg_event_log@b3d00000 {
+			no-map;
+			reg = <0xb3d00000 0x100000>;
+		};
+
+		ramoops@b3e00000 {
+			compatible = "ramoops";
+			reg = <0xb3e00000 0x200000>; /* 16 * (4 * 0x8000) */
+			record-size = <0x8000>;
+			console-size = <0x8000>;
+			ftrace-size = <0x8000>;
+			pmsg-size = <0x8000>;
+			max-reason = <3>; /* KMSG_DUMP_EMERG */
+		};
+
+		/* LPC FW cycle bridge region requires natural alignment */
+		flash_memory: region@b4000000 {
+			no-map;
+			reg = <0xb4000000 0x04000000>; /* 64M */
+		};
+
+		/* VGA region is dictated by hardware strapping */
+		vga_memory: region@bf000000 {
+			no-map;
+			compatible = "shared-dma-pool";
+			reg = <0xbf000000 0x01000000>;  /* 16M */
+		};
+	};
+};
+
+&adc1 {
+	status = "okay";
+	aspeed,int-vref-microvolt = <2500000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc8_default
+		&pinctrl_adc9_default
+		&pinctrl_adc10_default
+		&pinctrl_adc11_default
+		&pinctrl_adc12_default
+		&pinctrl_adc13_default
+		&pinctrl_adc14_default
+		&pinctrl_adc15_default>;
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&uhci {
+	status = "okay";
+};
+
+&gpio0 {
+	gpio-line-names =
+	/*A0-A7*/	"","","","","","","","",
+	/*B0-B7*/	"","","","","","","","",
+	/*C0-C7*/	"","","","","","","","",
+	/*D0-D7*/	"","","","","","","","",
+	/*E0-E7*/	"","","","","","","","",
+	/*F0-F7*/	"","","","","","","","",
+	/*G0-G7*/	"","","","","","","","",
+	/*H0-H7*/	"","","","","","","","",
+	/*I0-I7*/	"","","","","","","","",
+	/*J0-J7*/	"","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"","","","","","","","",
+	/*N0-N7*/	"","","","","","","","",
+	/*O0-O7*/	"","","","","","","","",
+	/*P0-P7*/	"","","","","","","","",
+	/*Q0-Q7*/	"","","","","","","","",
+	/*R0-R7*/	"","","","","","","","",
+	/*S0-S7*/	"","","","","","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","","","power-chassis-control","","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","power-chassis-good","","","","","","",
+	/*Y0-Y7*/	"","","","","","","","",
+	/*Z0-Z7*/	"","","","","","","","";
+};
+
+&emmc_controller {
+	status = "okay";
+};
+
+&pinctrl_emmc_default {
+	bias-disable;
+};
+
+&emmc {
+	status = "okay";
+	clk-phase-mmc-hs200 = <180>, <180>;
+};
+
+&ibt {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&vuart1 {
+	status = "okay";
+};
+
+&vuart2 {
+	status = "okay";
+};
+
+&lpc_ctrl {
+	status = "okay";
+	memory-region = <&flash_memory>;
+};
+
+&mac2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii3_default>;
+	clocks = <&syscon ASPEED_CLK_GATE_MAC3CLK>,
+		 <&syscon ASPEED_CLK_MAC3RCLK>;
+	clock-names = "MACCLK", "RCLK";
+	use-ncsi;
+};
+
+&mac3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii4_default>;
+	clocks = <&syscon ASPEED_CLK_GATE_MAC4CLK>,
+		 <&syscon ASPEED_CLK_MAC4RCLK>;
+	clock-names = "MACCLK", "RCLK";
+	use-ncsi;
+};
+
+&wdt1 {
+	aspeed,reset-type = "none";
+	aspeed,external-signal;
+	aspeed,ext-push-pull;
+	aspeed,ext-active-high;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst1_default>;
+};
+
+&wdt2 {
+	status = "okay";
+};
+
+&kcs2 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xca8 0xcac>;
+};
+
+&kcs3 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xca2>;
+	aspeed,lpc-interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+};
-- 
2.39.2

