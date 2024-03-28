Return-Path: <linux-kernel+bounces-115073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747A8888E70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4A25B22700
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BB62F4446;
	Mon, 25 Mar 2024 01:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGg8DQUm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04200180A68;
	Sun, 24 Mar 2024 23:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324051; cv=none; b=oou3OAyYVcdBGNs5rAOhzBi/lDRbLPFo4fACPR9ulyzBidY+zm62bMWajMIo3/kMShnE/uDePQdy+u8jJbqeEA8QjL9SP7BkwZFIwy2LHgwCFdaPspZplq5xZrdJdQGorT/xx8muL/CYH6Y7ZGHsozz+q3+tmyb51A1hsVYDSPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324051; c=relaxed/simple;
	bh=jYDTbR26PJRInBYcYizCpWjuJC+jhpRY45ethz54KGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGj7Y68gfnfHWYrkyMX5aa0SMcGJYu+bReXfIWCkA+szOEgupnBSzoSeDyaSNOQQaNdRnNgY0J6cKhNdmznCWz0BJjV7vwIwYEo7u/hk4aoXxq3iVcMIdatnruH2PWSDBudEndHUqMYLDEKwu+vpQjAfjYmXS3IVwk955GBHkeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGg8DQUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2860FC433C7;
	Sun, 24 Mar 2024 23:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324049;
	bh=jYDTbR26PJRInBYcYizCpWjuJC+jhpRY45ethz54KGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MGg8DQUmCe/iLfoEUKntVtQfyLV5Kci5uLe0ELTkO4nWiuSfLBPCLycmdagdjTdXj
	 iCNJDi3Xonxnshfvn0j8q5CmfY65O/M8RYcVEiWPRU0glT3MmUcdD6/kwhyqRbni5q
	 4ElVZxafQM4TmJ5nh72K4CN/09IFkSYsVk4bYacSFdccoa+3s9yMrjiyC2EJuTuVng
	 0qrkAxMppS4hjIYXJrQ6Wg+A4wF5tTo6Yo3ZxYtSXKtTasYT84cdbgnElyM24oHxxY
	 Nml+2Fyk4jQWoqckkARSkP7f9Vi2RQcAhgkoAtZ4SgTTiKAL3fWGj4zhJoa7YHGgyK
	 7soqs04lkn25Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 050/183] arm64: dts: qcom: msm8996: Use node references in db820c
Date: Sun, 24 Mar 2024 19:44:23 -0400
Message-ID: <20240324234638.1355609-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Bjorn Andersson <bjorn.andersson@linaro.org>

[ Upstream commit 75b77d6492eb5e582e17618b71f62140faf2de29 ]

Instead of mimicing the structure of the platform, reference nodes by
their label in apq8096-db820c.dtsi. Add labels in msm8996.dtsi where
necessary.

Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Stable-dep-of: 68c4c20848d7 ("arm64: dts: qcom: msm8996: Define UFS UniPro clock limits")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 691 +++++++++----------
 arch/arm64/boot/dts/qcom/msm8996.dtsi        |   4 +-
 2 files changed, 341 insertions(+), 354 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index da2f01eb3be2c..44ec3eb1c8e85 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -77,396 +77,383 @@ div1_mclk: divclk1 {
 			enable-gpios = <&pm8994_gpios 15 0>;
 		};
 	};
+};
 
-	soc {
-		serial@7570000 {
-			label = "BT-UART";
-			status = "okay";
-			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&blsp1_uart1_default>;
-			pinctrl-1 = <&blsp1_uart1_sleep>;
+&blsp1_uart1 {
+	label = "BT-UART";
+	status = "okay";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&blsp1_uart1_default>;
+	pinctrl-1 = <&blsp1_uart1_sleep>;
 
-			bluetooth {
-				compatible = "qcom,qca6174-bt";
+	bluetooth {
+		compatible = "qcom,qca6174-bt";
 
-				/* bt_disable_n gpio */
-				enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
+		/* bt_disable_n gpio */
+		enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
 
-				clocks = <&divclk4>;
-			};
-		};
+		clocks = <&divclk4>;
+	};
+};
 
-		serial@75b0000 {
-			label = "LS-UART1";
-			status = "okay";
-			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&blsp2_uart1_2pins_default>;
-			pinctrl-1 = <&blsp2_uart1_2pins_sleep>;
-		};
+&blsp2_uart1 {
+	label = "LS-UART1";
+	status = "okay";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&blsp2_uart1_2pins_default>;
+	pinctrl-1 = <&blsp2_uart1_2pins_sleep>;
+};
 
-		serial@75b1000 {
-			label = "LS-UART0";
-			status = "disabled";
-			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&blsp2_uart2_4pins_default>;
-			pinctrl-1 = <&blsp2_uart2_4pins_sleep>;
-		};
+&blsp2_uart2 {
+	label = "LS-UART0";
+	status = "disabled";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&blsp2_uart2_4pins_default>;
+	pinctrl-1 = <&blsp2_uart2_4pins_sleep>;
+};
 
-		i2c@7577000 {
-		/* On Low speed expansion */
-			label = "LS-I2C0";
-			status = "okay";
-		};
+&blsp1_i2c2 {
+	/* On Low speed expansion */
+	label = "LS-I2C0";
+	status = "okay";
+};
 
-		i2c@75b6000 {
-		/* On Low speed expansion */
-			label = "LS-I2C1";
-			status = "okay";
-		};
+&blsp2_i2c1 {
+	/* On Low speed expansion */
+	label = "LS-I2C1";
+	status = "okay";
+};
 
-		spi@7575000 {
-		/* On Low speed expansion */
-			label = "LS-SPI0";
-			status = "okay";
-		};
+&blsp1_spi0 {
+	/* On Low speed expansion */
+	label = "LS-SPI0";
+	status = "okay";
+};
 
-		i2c@75b5000 {
-		/* On High speed expansion */
-			label = "HS-I2C2";
-			status = "okay";
-		};
+&blsp2_i2c0 {
+	/* On High speed expansion */
+	label = "HS-I2C2";
+	status = "okay";
+};
 
-		spi@75ba000{
-		/* On High speed expansion */
-			label = "HS-SPI1";
-			status = "okay";
-		};
+&blsp2_spi5 {
+	/* On High speed expansion */
+	label = "HS-SPI1";
+	status = "okay";
+};
 
-		sdhci@74a4900 {
-		/* External SD card */
-			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
-			pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
-			cd-gpios = <&msmgpio 38 0x1>;
-			vmmc-supply = <&pm8994_l21>;
-			vqmmc-supply = <&pm8994_l13>;
-			status = "okay";
-		};
+&sdhc2 {
+	/* External SD card */
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
+	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+	cd-gpios = <&msmgpio 38 0x1>;
+	vmmc-supply = <&pm8994_l21>;
+	vqmmc-supply = <&pm8994_l13>;
+	status = "okay";
+};
 
-		phy@627000 {
-			status = "okay";
-		};
+&ufsphy {
+	status = "okay";
+};
 
-		ufshc@624000 {
-			status = "okay";
-		};
+&ufshc {
+	status = "okay";
+};
 
-		pinctrl@1010000 {
-			gpio-line-names =
-				"[SPI0_DOUT]", /* GPIO_0, BLSP1_SPI_MOSI, LSEC pin 14 */
-				"[SPI0_DIN]", /* GPIO_1, BLSP1_SPI_MISO, LSEC pin 10 */
-				"[SPI0_CS]", /* GPIO_2, BLSP1_SPI_CS_N, LSEC pin 12 */
-				"[SPI0_SCLK]", /* GPIO_3, BLSP1_SPI_CLK, LSEC pin 8 */
-				"[UART1_TxD]", /* GPIO_4, BLSP8_UART_TX, LSEC pin 11 */
-				"[UART1_RxD]", /* GPIO_5, BLSP8_UART_RX, LSEC pin 13 */
-				"[I2C1_SDA]", /* GPIO_6, BLSP8_I2C_SDA, LSEC pin 21 */
-				"[I2C1_SCL]", /* GPIO_7, BLSP8_I2C_SCL, LSEC pin 19 */
-				"GPIO-H", /* GPIO_8, LCD0_RESET_N, LSEC pin 30 */
-				"TP93", /* GPIO_9 */
-				"GPIO-G", /* GPIO_10, MDP_VSYNC_P, LSEC pin 29 */
-				"[MDP_VSYNC_S]", /* GPIO_11, S HSEC pin 55 */
-				"NC", /* GPIO_12 */
-				"[CSI0_MCLK]", /* GPIO_13, CAM_MCLK0, P HSEC pin 15 */
-				"[CAM_MCLK1]", /* GPIO_14, J14 pin 11 */
-				"[CSI1_MCLK]", /* GPIO_15, CAM_MCLK2, P HSEC pin 17 */
-				"TP99", /* GPIO_16 */
-				"[I2C2_SDA]", /* GPIO_17, CCI_I2C_SDA0, P HSEC pin 34 */
-				"[I2C2_SCL]", /* GPIO_18, CCI_I2C_SCL0, P HSEC pin 32 */
-				"[CCI_I2C_SDA1]", /* GPIO_19, S HSEC pin 38 */
-				"[CCI_I2C_SCL1]", /* GPIO_20, S HSEC pin 36 */
-				"FLASH_STROBE_EN", /* GPIO_21, S HSEC pin 5 */
-				"FLASH_STROBE_TRIG", /* GPIO_22, S HSEC pin 1 */
-				"GPIO-K", /* GPIO_23, CAM2_RST_N, LSEC pin 33 */
-				"GPIO-D", /* GPIO_24, LSEC pin 26 */
-				"GPIO-I", /* GPIO_25, CAM0_RST_N, LSEC pin 31 */
-				"GPIO-J", /* GPIO_26, CAM0_STANDBY_N, LSEC pin 32 */
-				"BLSP6_I2C_SDA", /* GPIO_27 */
-				"BLSP6_I2C_SCL", /* GPIO_28 */
-				"GPIO-B", /* GPIO_29, TS0_RESET_N, LSEC pin 24 */
-				"GPIO30", /* GPIO_30, S HSEC pin 4 */
-				"HDMI_CEC", /* GPIO_31 */
-				"HDMI_DDC_CLOCK", /* GPIO_32 */
-				"HDMI_DDC_DATA", /* GPIO_33 */
-				"HDMI_HOT_PLUG_DETECT", /* GPIO_34 */
-				"PCIE0_RST_N", /* GPIO_35 */
-				"PCIE0_CLKREQ_N", /* GPIO_36 */
-				"PCIE0_WAKE", /* GPIO_37 */
-				"SD_CARD_DET_N", /* GPIO_38 */
-				"TSIF1_SYNC", /* GPIO_39, S HSEC pin 48 */
-				"W_DISABLE_N", /* GPIO_40 */
-				"[BLSP9_UART_TX]", /* GPIO_41 */
-				"[BLSP9_UART_RX]", /* GPIO_42 */
-				"[BLSP2_UART_CTS_N]", /* GPIO_43 */
-				"[BLSP2_UART_RFR_N]", /* GPIO_44 */
-				"[BLSP3_UART_TX]", /* GPIO_45 */
-				"[BLSP3_UART_RX]", /* GPIO_46 */
-				"[I2C0_SDA]", /* GPIO_47, LS_I2C0_SDA, LSEC pin 17 */
-				"[I2C0_SCL]", /* GPIO_48, LS_I2C0_SCL, LSEC pin 15 */
-				"[UART0_TxD]", /* GPIO_49, BLSP9_UART_TX, LSEC pin 5 */
-				"[UART0_RxD]", /* GPIO_50, BLSP9_UART_RX, LSEC pin 7 */
-				"[UART0_CTS]", /* GPIO_51, BLSP9_UART_CTS_N, LSEC pin 3 */
-				"[UART0_RTS]", /* GPIO_52, BLSP9_UART_RFR_N, LSEC pin 9 */
-				"[CODEC_INT1_N]", /* GPIO_53 */
-				"[CODEC_INT2_N]", /* GPIO_54 */
-				"[BLSP7_I2C_SDA]", /* GPIO_55 */
-				"[BLSP7_I2C_SCL]", /* GPIO_56 */
-				"MI2S_MCLK", /* GPIO_57, S HSEC pin 3 */
-				"[PCM_CLK]", /* GPIO_58, QUA_MI2S_SCK, LSEC pin 18 */
-				"[PCM_FS]", /* GPIO_59, QUA_MI2S_WS, LSEC pin 16 */
-				"[PCM_DO]", /* GPIO_60, QUA_MI2S_DATA0, LSEC pin 20 */
-				"[PCM_DI]", /* GPIO_61, QUA_MI2S_DATA1, LSEC pin 22 */
-				"GPIO-E", /* GPIO_62, LSEC pin 27 */
-				"TP87", /* GPIO_63 */
-				"[CODEC_RST_N]", /* GPIO_64 */
-				"[PCM1_CLK]", /* GPIO_65 */
-				"[PCM1_SYNC]", /* GPIO_66 */
-				"[PCM1_DIN]", /* GPIO_67 */
-				"[PCM1_DOUT]", /* GPIO_68 */
-				"AUDIO_REF_CLK", /* GPIO_69 */
-				"SLIMBUS_CLK", /* GPIO_70 */
-				"SLIMBUS_DATA0", /* GPIO_71 */
-				"SLIMBUS_DATA1", /* GPIO_72 */
-				"NC", /* GPIO_73 */
-				"NC", /* GPIO_74 */
-				"NC", /* GPIO_75 */
-				"NC", /* GPIO_76 */
-				"TP94", /* GPIO_77 */
-				"NC", /* GPIO_78 */
-				"TP95", /* GPIO_79 */
-				"GPIO-A", /* GPIO_80, MEMS_RESET_N, LSEC pin 23 */
-				"TP88", /* GPIO_81 */
-				"TP89", /* GPIO_82 */
-				"TP90", /* GPIO_83 */
-				"TP91", /* GPIO_84 */
-				"[SD_DAT0]", /* GPIO_85, BLSP12_SPI_MOSI, P HSEC pin 1 */
-				"[SD_CMD]", /* GPIO_86, BLSP12_SPI_MISO, P HSEC pin 11 */
-				"[SD_DAT3]", /* GPIO_87, BLSP12_SPI_CS_N, P HSEC pin 7 */
-				"[SD_SCLK]", /* GPIO_88, BLSP12_SPI_CLK, P HSEC pin 9 */
-				"TSIF1_CLK", /* GPIO_89, S HSEC pin 42 */
-				"TSIF1_EN", /* GPIO_90, S HSEC pin 46 */
-				"TSIF1_DATA", /* GPIO_91, S HSEC pin 44 */
-				"NC", /* GPIO_92 */
-				"TSIF2_CLK", /* GPIO_93, S HSEC pin 52 */
-				"TSIF2_EN", /* GPIO_94, S HSEC pin 56 */
-				"TSIF2_DATA", /* GPIO_95, S HSEC pin 54 */
-				"TSIF2_SYNC", /* GPIO_96, S HSEC pin 58 */
-				"NC", /* GPIO_97 */
-				"CAM1_STANDBY_N", /* GPIO_98 */
-				"NC", /* GPIO_99 */
-				"NC", /* GPIO_100 */
-				"[LCD1_RESET_N]", /* GPIO_101, S HSEC pin 51 */
-				"BOOT_CONFIG1", /* GPIO_102 */
-				"USB_HUB_RESET", /* GPIO_103 */
-				"CAM1_RST_N", /* GPIO_104 */
-				"NC", /* GPIO_105 */
-				"NC", /* GPIO_106 */
-				"NC", /* GPIO_107 */
-				"NC", /* GPIO_108 */
-				"NC", /* GPIO_109 */
-				"NC", /* GPIO_110 */
-				"NC", /* GPIO_111 */
-				"NC", /* GPIO_112 */
-				"PMI8994_BUA", /* GPIO_113 */
-				"PCIE2_RST_N", /* GPIO_114 */
-				"PCIE2_CLKREQ_N", /* GPIO_115 */
-				"PCIE2_WAKE", /* GPIO_116 */
-				"SSC_IRQ_0", /* GPIO_117 */
-				"SSC_IRQ_1", /* GPIO_118 */
-				"SSC_IRQ_2", /* GPIO_119 */
-				"NC", /* GPIO_120 */
-				"GPIO121", /* GPIO_121, S HSEC pin 2 */
-				"NC", /* GPIO_122 */
-				"SSC_IRQ_6", /* GPIO_123 */
-				"SSC_IRQ_7", /* GPIO_124 */
-				"GPIO-C", /* GPIO_125, TS_INT0, LSEC pin 25 */
-				"BOOT_CONFIG5", /* GPIO_126 */
-				"NC", /* GPIO_127 */
-				"NC", /* GPIO_128 */
-				"BOOT_CONFIG7", /* GPIO_129 */
-				"PCIE1_RST_N", /* GPIO_130 */
-				"PCIE1_CLKREQ_N", /* GPIO_131 */
-				"PCIE1_WAKE", /* GPIO_132 */
-				"GPIO-L", /* GPIO_133, CAM2_STANDBY_N, LSEC pin 34 */
-				"NC", /* GPIO_134 */
-				"NC", /* GPIO_135 */
-				"BOOT_CONFIG8", /* GPIO_136 */
-				"NC", /* GPIO_137 */
-				"NC", /* GPIO_138 */
-				"GPS_SSBI2", /* GPIO_139 */
-				"GPS_SSBI1", /* GPIO_140 */
-				"NC", /* GPIO_141 */
-				"NC", /* GPIO_142 */
-				"NC", /* GPIO_143 */
-				"BOOT_CONFIG6", /* GPIO_144 */
-				"NC", /* GPIO_145 */
-				"NC", /* GPIO_146 */
-				"NC", /* GPIO_147 */
-				"NC", /* GPIO_148 */
-				"NC"; /* GPIO_149 */
-		};
+&msmgpio {
+	gpio-line-names =
+		"[SPI0_DOUT]", /* GPIO_0, BLSP1_SPI_MOSI, LSEC pin 14 */
+		"[SPI0_DIN]", /* GPIO_1, BLSP1_SPI_MISO, LSEC pin 10 */
+		"[SPI0_CS]", /* GPIO_2, BLSP1_SPI_CS_N, LSEC pin 12 */
+		"[SPI0_SCLK]", /* GPIO_3, BLSP1_SPI_CLK, LSEC pin 8 */
+		"[UART1_TxD]", /* GPIO_4, BLSP8_UART_TX, LSEC pin 11 */
+		"[UART1_RxD]", /* GPIO_5, BLSP8_UART_RX, LSEC pin 13 */
+		"[I2C1_SDA]", /* GPIO_6, BLSP8_I2C_SDA, LSEC pin 21 */
+		"[I2C1_SCL]", /* GPIO_7, BLSP8_I2C_SCL, LSEC pin 19 */
+		"GPIO-H", /* GPIO_8, LCD0_RESET_N, LSEC pin 30 */
+		"TP93", /* GPIO_9 */
+		"GPIO-G", /* GPIO_10, MDP_VSYNC_P, LSEC pin 29 */
+		"[MDP_VSYNC_S]", /* GPIO_11, S HSEC pin 55 */
+		"NC", /* GPIO_12 */
+		"[CSI0_MCLK]", /* GPIO_13, CAM_MCLK0, P HSEC pin 15 */
+		"[CAM_MCLK1]", /* GPIO_14, J14 pin 11 */
+		"[CSI1_MCLK]", /* GPIO_15, CAM_MCLK2, P HSEC pin 17 */
+		"TP99", /* GPIO_16 */
+		"[I2C2_SDA]", /* GPIO_17, CCI_I2C_SDA0, P HSEC pin 34 */
+		"[I2C2_SCL]", /* GPIO_18, CCI_I2C_SCL0, P HSEC pin 32 */
+		"[CCI_I2C_SDA1]", /* GPIO_19, S HSEC pin 38 */
+		"[CCI_I2C_SCL1]", /* GPIO_20, S HSEC pin 36 */
+		"FLASH_STROBE_EN", /* GPIO_21, S HSEC pin 5 */
+		"FLASH_STROBE_TRIG", /* GPIO_22, S HSEC pin 1 */
+		"GPIO-K", /* GPIO_23, CAM2_RST_N, LSEC pin 33 */
+		"GPIO-D", /* GPIO_24, LSEC pin 26 */
+		"GPIO-I", /* GPIO_25, CAM0_RST_N, LSEC pin 31 */
+		"GPIO-J", /* GPIO_26, CAM0_STANDBY_N, LSEC pin 32 */
+		"BLSP6_I2C_SDA", /* GPIO_27 */
+		"BLSP6_I2C_SCL", /* GPIO_28 */
+		"GPIO-B", /* GPIO_29, TS0_RESET_N, LSEC pin 24 */
+		"GPIO30", /* GPIO_30, S HSEC pin 4 */
+		"HDMI_CEC", /* GPIO_31 */
+		"HDMI_DDC_CLOCK", /* GPIO_32 */
+		"HDMI_DDC_DATA", /* GPIO_33 */
+		"HDMI_HOT_PLUG_DETECT", /* GPIO_34 */
+		"PCIE0_RST_N", /* GPIO_35 */
+		"PCIE0_CLKREQ_N", /* GPIO_36 */
+		"PCIE0_WAKE", /* GPIO_37 */
+		"SD_CARD_DET_N", /* GPIO_38 */
+		"TSIF1_SYNC", /* GPIO_39, S HSEC pin 48 */
+		"W_DISABLE_N", /* GPIO_40 */
+		"[BLSP9_UART_TX]", /* GPIO_41 */
+		"[BLSP9_UART_RX]", /* GPIO_42 */
+		"[BLSP2_UART_CTS_N]", /* GPIO_43 */
+		"[BLSP2_UART_RFR_N]", /* GPIO_44 */
+		"[BLSP3_UART_TX]", /* GPIO_45 */
+		"[BLSP3_UART_RX]", /* GPIO_46 */
+		"[I2C0_SDA]", /* GPIO_47, LS_I2C0_SDA, LSEC pin 17 */
+		"[I2C0_SCL]", /* GPIO_48, LS_I2C0_SCL, LSEC pin 15 */
+		"[UART0_TxD]", /* GPIO_49, BLSP9_UART_TX, LSEC pin 5 */
+		"[UART0_RxD]", /* GPIO_50, BLSP9_UART_RX, LSEC pin 7 */
+		"[UART0_CTS]", /* GPIO_51, BLSP9_UART_CTS_N, LSEC pin 3 */
+		"[UART0_RTS]", /* GPIO_52, BLSP9_UART_RFR_N, LSEC pin 9 */
+		"[CODEC_INT1_N]", /* GPIO_53 */
+		"[CODEC_INT2_N]", /* GPIO_54 */
+		"[BLSP7_I2C_SDA]", /* GPIO_55 */
+		"[BLSP7_I2C_SCL]", /* GPIO_56 */
+		"MI2S_MCLK", /* GPIO_57, S HSEC pin 3 */
+		"[PCM_CLK]", /* GPIO_58, QUA_MI2S_SCK, LSEC pin 18 */
+		"[PCM_FS]", /* GPIO_59, QUA_MI2S_WS, LSEC pin 16 */
+		"[PCM_DO]", /* GPIO_60, QUA_MI2S_DATA0, LSEC pin 20 */
+		"[PCM_DI]", /* GPIO_61, QUA_MI2S_DATA1, LSEC pin 22 */
+		"GPIO-E", /* GPIO_62, LSEC pin 27 */
+		"TP87", /* GPIO_63 */
+		"[CODEC_RST_N]", /* GPIO_64 */
+		"[PCM1_CLK]", /* GPIO_65 */
+		"[PCM1_SYNC]", /* GPIO_66 */
+		"[PCM1_DIN]", /* GPIO_67 */
+		"[PCM1_DOUT]", /* GPIO_68 */
+		"AUDIO_REF_CLK", /* GPIO_69 */
+		"SLIMBUS_CLK", /* GPIO_70 */
+		"SLIMBUS_DATA0", /* GPIO_71 */
+		"SLIMBUS_DATA1", /* GPIO_72 */
+		"NC", /* GPIO_73 */
+		"NC", /* GPIO_74 */
+		"NC", /* GPIO_75 */
+		"NC", /* GPIO_76 */
+		"TP94", /* GPIO_77 */
+		"NC", /* GPIO_78 */
+		"TP95", /* GPIO_79 */
+		"GPIO-A", /* GPIO_80, MEMS_RESET_N, LSEC pin 23 */
+		"TP88", /* GPIO_81 */
+		"TP89", /* GPIO_82 */
+		"TP90", /* GPIO_83 */
+		"TP91", /* GPIO_84 */
+		"[SD_DAT0]", /* GPIO_85, BLSP12_SPI_MOSI, P HSEC pin 1 */
+		"[SD_CMD]", /* GPIO_86, BLSP12_SPI_MISO, P HSEC pin 11 */
+		"[SD_DAT3]", /* GPIO_87, BLSP12_SPI_CS_N, P HSEC pin 7 */
+		"[SD_SCLK]", /* GPIO_88, BLSP12_SPI_CLK, P HSEC pin 9 */
+		"TSIF1_CLK", /* GPIO_89, S HSEC pin 42 */
+		"TSIF1_EN", /* GPIO_90, S HSEC pin 46 */
+		"TSIF1_DATA", /* GPIO_91, S HSEC pin 44 */
+		"NC", /* GPIO_92 */
+		"TSIF2_CLK", /* GPIO_93, S HSEC pin 52 */
+		"TSIF2_EN", /* GPIO_94, S HSEC pin 56 */
+		"TSIF2_DATA", /* GPIO_95, S HSEC pin 54 */
+		"TSIF2_SYNC", /* GPIO_96, S HSEC pin 58 */
+		"NC", /* GPIO_97 */
+		"CAM1_STANDBY_N", /* GPIO_98 */
+		"NC", /* GPIO_99 */
+		"NC", /* GPIO_100 */
+		"[LCD1_RESET_N]", /* GPIO_101, S HSEC pin 51 */
+		"BOOT_CONFIG1", /* GPIO_102 */
+		"USB_HUB_RESET", /* GPIO_103 */
+		"CAM1_RST_N", /* GPIO_104 */
+		"NC", /* GPIO_105 */
+		"NC", /* GPIO_106 */
+		"NC", /* GPIO_107 */
+		"NC", /* GPIO_108 */
+		"NC", /* GPIO_109 */
+		"NC", /* GPIO_110 */
+		"NC", /* GPIO_111 */
+		"NC", /* GPIO_112 */
+		"PMI8994_BUA", /* GPIO_113 */
+		"PCIE2_RST_N", /* GPIO_114 */
+		"PCIE2_CLKREQ_N", /* GPIO_115 */
+		"PCIE2_WAKE", /* GPIO_116 */
+		"SSC_IRQ_0", /* GPIO_117 */
+		"SSC_IRQ_1", /* GPIO_118 */
+		"SSC_IRQ_2", /* GPIO_119 */
+		"NC", /* GPIO_120 */
+		"GPIO121", /* GPIO_121, S HSEC pin 2 */
+		"NC", /* GPIO_122 */
+		"SSC_IRQ_6", /* GPIO_123 */
+		"SSC_IRQ_7", /* GPIO_124 */
+		"GPIO-C", /* GPIO_125, TS_INT0, LSEC pin 25 */
+		"BOOT_CONFIG5", /* GPIO_126 */
+		"NC", /* GPIO_127 */
+		"NC", /* GPIO_128 */
+		"BOOT_CONFIG7", /* GPIO_129 */
+		"PCIE1_RST_N", /* GPIO_130 */
+		"PCIE1_CLKREQ_N", /* GPIO_131 */
+		"PCIE1_WAKE", /* GPIO_132 */
+		"GPIO-L", /* GPIO_133, CAM2_STANDBY_N, LSEC pin 34 */
+		"NC", /* GPIO_134 */
+		"NC", /* GPIO_135 */
+		"BOOT_CONFIG8", /* GPIO_136 */
+		"NC", /* GPIO_137 */
+		"NC", /* GPIO_138 */
+		"GPS_SSBI2", /* GPIO_139 */
+		"GPS_SSBI1", /* GPIO_140 */
+		"NC", /* GPIO_141 */
+		"NC", /* GPIO_142 */
+		"NC", /* GPIO_143 */
+		"BOOT_CONFIG6", /* GPIO_144 */
+		"NC", /* GPIO_145 */
+		"NC", /* GPIO_146 */
+		"NC", /* GPIO_147 */
+		"NC", /* GPIO_148 */
+		"NC"; /* GPIO_149 */
+};
 
-		qcom,spmi@400f000 {
-			pmic@0 {
-				gpios@c000 {
-					gpio-line-names =
-						"NC",
-						"KEY_VOLP_N",
-						"NC",
-						"BL1_PWM",
-						"GPIO-F", /* BL0_PWM, LSEC pin 28 */
-						"BL1_EN",
-						"NC",
-						"WLAN_EN",
-						"NC",
-						"NC",
-						"NC",
-						"NC",
-						"NC",
-						"NC",
-						"DIVCLK1",
-						"DIVCLK2",
-						"DIVCLK3",
-						"DIVCLK4",
-						"BT_EN",
-						"PMIC_SLB",
-						"PMIC_BUA",
-						"USB_VBUS_DET";
-				};
-
-				mpps@a000 {
-					gpio-line-names =
-						"VDDPX_BIAS",
-						"WIFI_LED",
-						"NC",
-						"BT_LED",
-						"PM_MPP05",
-						"PM_MPP06",
-						"PM_MPP07",
-						"NC";
-				};
-			};
+&pm8994_gpios {
+	gpio-line-names =
+		"NC",
+		"KEY_VOLP_N",
+		"NC",
+		"BL1_PWM",
+		"GPIO-F", /* BL0_PWM, LSEC pin 28 */
+		"BL1_EN",
+		"NC",
+		"WLAN_EN",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"DIVCLK1",
+		"DIVCLK2",
+		"DIVCLK3",
+		"DIVCLK4",
+		"BT_EN",
+		"PMIC_SLB",
+		"PMIC_BUA",
+		"USB_VBUS_DET";
+};
 
-			pmic@2 {
-				gpios@c000 {
-					gpio-line-names =
-						"NC",
-						"SPKR_AMP_EN1",
-						"SPKR_AMP_EN2",
-						"TP61",
-						"NC",
-						"USB2_VBUS_DET",
-						"NC",
-						"NC",
-						"NC",
-						"NC";
-				};
-			};
-		};
+&pm8994_mpps {
+	gpio-line-names =
+		"VDDPX_BIAS",
+		"WIFI_LED",
+		"NC",
+		"BT_LED",
+		"PM_MPP05",
+		"PM_MPP06",
+		"PM_MPP07",
+		"NC";
+};
 
-		phy@34000 {
-			status = "okay";
-		};
+&pmi8994_gpios {
+	gpio-line-names =
+		"NC",
+		"SPKR_AMP_EN1",
+		"SPKR_AMP_EN2",
+		"TP61",
+		"NC",
+		"USB2_VBUS_DET",
+		"NC",
+		"NC",
+		"NC",
+		"NC";
+};
 
-		phy@7410000 {
-			status = "okay";
-		};
+&pcie_phy {
+	status = "okay";
+};
 
-		phy@7411000 {
-			status = "okay";
-		};
+&usb3phy {
+	status = "okay";
+};
 
-		phy@7412000 {
-			status = "okay";
-		};
+&hsusb_phy1 {
+	status = "okay";
+};
 
-		usb@6af8800 {
-			status = "okay";
-			extcon = <&usb3_id>;
+&hsusb_phy2 {
+	status = "okay";
+};
 
-			dwc3@6a00000 {
-				extcon = <&usb3_id>;
-				dr_mode = "otg";
-			};
-		};
+&usb3 {
+	status = "okay";
+	extcon = <&usb3_id>;
 
-		usb@76f8800 {
-			status = "okay";
-			extcon = <&usb2_id>;
+	dwc3@6a00000 {
+		extcon = <&usb3_id>;
+		dr_mode = "otg";
+	};
+};
 
-			dwc3@7600000 {
-				extcon = <&usb2_id>;
-				dr_mode = "otg";
-				maximum-speed = "high-speed";
-			};
-		};
+&usb2 {
+	status = "okay";
+	extcon = <&usb2_id>;
 
-		agnoc@0 {
-			pcie@600000 {
-				status = "okay";
-				perst-gpio = <&msmgpio 35 GPIO_ACTIVE_LOW>;
-				vddpe-3v3-supply = <&wlan_en>;
-			};
+	dwc3@7600000 {
+		extcon = <&usb2_id>;
+		dr_mode = "otg";
+		maximum-speed = "high-speed";
+	};
+};
 
-			pcie@608000 {
-				status = "okay";
-				perst-gpio = <&msmgpio 130 GPIO_ACTIVE_LOW>;
-			};
+&pcie0 {
+	status = "okay";
+	perst-gpio = <&msmgpio 35 GPIO_ACTIVE_LOW>;
+	vddpe-3v3-supply = <&wlan_en>;
+};
 
-			pcie@610000 {
-				status = "okay";
-				perst-gpio = <&msmgpio 114 GPIO_ACTIVE_LOW>;
-			};
-		};
+&pcie1 {
+	status = "okay";
+	perst-gpio = <&msmgpio 130 GPIO_ACTIVE_LOW>;
+};
 
-		slim_msm: slim@91c0000 {
-			ngd@1 {
-				wcd9335: codec@1{
-					clock-names = "mclk", "slimbus";
-					clocks = <&div1_mclk>,
-						 <&rpmcc RPM_SMD_BB_CLK1>;
-				};
-			};
-		};
+&pcie2 {
+	status = "okay";
+	perst-gpio = <&msmgpio 114 GPIO_ACTIVE_LOW>;
+};
 
-		mdss@900000 {
-			status = "okay";
+&wcd9335 {
+	clock-names = "mclk", "slimbus";
+	clocks = <&div1_mclk>,
+		 <&rpmcc RPM_SMD_BB_CLK1>;
+};
 
-			mdp@901000 {
-				status = "okay";
-			};
+&mdss {
+	status = "okay";
+};
 
-			hdmi-phy@9a0600 {
-				status = "okay";
+&mdp {
+	status = "okay";
+};
 
-				vddio-supply = <&pm8994_l12>;
-				vcca-supply = <&pm8994_l28>;
-				#phy-cells = <0>;
-			};
+&hdmi_phy {
+	status = "okay";
 
-			hdmi-tx@9a0000 {
-				status = "okay";
+	vddio-supply = <&pm8994_l12>;
+	vcca-supply = <&pm8994_l28>;
+	#phy-cells = <0>;
+};
 
-				pinctrl-names = "default", "sleep";
-				pinctrl-0 = <&hdmi_hpd_active &hdmi_ddc_active>;
-				pinctrl-1 = <&hdmi_hpd_suspend &hdmi_ddc_suspend>;
+&hdmi {
+	status = "okay";
 
-				core-vdda-supply = <&pm8994_l12>;
-				core-vcc-supply = <&pm8994_s4>;
-			};
-		};
-	};
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&hdmi_hpd_active &hdmi_ddc_active>;
+	pinctrl-1 = <&hdmi_hpd_suspend &hdmi_ddc_suspend>;
 
+	core-vdda-supply = <&pm8994_l12>;
+	core-vcc-supply = <&pm8994_s4>;
+};
 
+/ {
 	gpio_keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index fb9556f57f55b..bbdb0fcd818e9 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1464,7 +1464,7 @@ gpu_speed_bin: gpu_speed_bin@133 {
 			};
 		};
 
-		phy@34000 {
+		pcie_phy: phy@34000 {
 			compatible = "qcom,msm8996-qmp-pcie-phy";
 			reg = <0x34000 0x488>;
 			#clock-cells = <1>;
@@ -1526,7 +1526,7 @@ pciephy_2: lane@37000 {
 			};
 		};
 
-		phy@7410000 {
+		usb3phy: phy@7410000 {
 			compatible = "qcom,msm8996-qmp-usb3-phy";
 			reg = <0x7410000 0x1c4>;
 			#clock-cells = <1>;
-- 
2.43.0


