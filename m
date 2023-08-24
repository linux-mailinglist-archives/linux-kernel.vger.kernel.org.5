Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD103786C74
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240794AbjHXJ7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240765AbjHXJ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:59:03 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591B6198B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:58:59 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so10315425e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692871137; x=1693475937;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iluwx0+OdEeVx1NlITEa6gRIHD6wIOwv+uw97q1022g=;
        b=V1jRJS+Z/uIrHu/asWV9RgF5P3lxXm5XHPl/OtA2Nbwh1J0V0dNo/phNhIrPjQJM4m
         YFnlVTWlvBv1CLBBkNV+oPvuuMdyaa1HxlGKHfoNvPOKp6jyYTvpTwcvhQFWHjxKS+aL
         zzqP8PzayqYij5W7OfzNLKoO75UQnruyvbDMjDBceh/4lOgzwFcIE/8+W4IZsEDDR/0P
         v7LPIrn8mLRValVmFFvPYjAQLAfxoLzerANw1Fw+t63v9ymBmntBVlU/+TGPAgQodMsi
         yFzxV+XE6IeLNlW1RoSUCHedTs8eDxoUlVBN87ZsmxL1UrxP/EbbWGRIJLjbBbkPB7qq
         WUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692871137; x=1693475937;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iluwx0+OdEeVx1NlITEa6gRIHD6wIOwv+uw97q1022g=;
        b=JmT3Nz1TriJ1SExa4992jvwWT6Y+C1c4vi/TtT9JeskVurbxyhh2xe3MNNpA8bgfCD
         zyPhmGagvq8E1XbwKXmjz6n+rOWwakvwzI0d5BMxCbr1vAojwiNjqANkYSBS7hI4mZaP
         te2+hruI7UXxe1V559f7MnhkAgIwIHz4tH23W+oKq2NjZxl6FdUfnXLeFlTs67iqJmWe
         fHsILQwAuLKqjRpgI6/EUn2wQeCuFs/KFRwcT88+ArKtRf9VKULH8x8mAfWPsstO+JrP
         9WVl7NWS871p0rWl+XvYg9xf4fnppDOxlOfqProVpfdiaf2wuxk6w+XcBC2OX3yIHsuz
         qtsw==
X-Gm-Message-State: AOJu0YwvV8ZxoIeGOQNVreWQWUcLfdeXTur0xswQBHlGkOxTe1kwXTAK
        I0YOBn8EI6G6hG+xEtbWAE8JEw==
X-Google-Smtp-Source: AGHT+IG8+CEmxWe4stFNGz0LOedwWd/rbMUiw9dRtuBhQWgUl66QkvhQsIlU5YmOCsnx/lUo9hzv1g==
X-Received: by 2002:a05:6512:6cf:b0:4fd:faa1:fefc with SMTP id u15-20020a05651206cf00b004fdfaa1fefcmr11423484lff.56.1692871137399;
        Thu, 24 Aug 2023 02:58:57 -0700 (PDT)
Received: from [10.167.154.1] ([2a00:f41:4882:ba34:4490:938b:eab4:c5ef])
        by smtp.gmail.com with ESMTPSA id y2-20020a197502000000b0050096712dc8sm712301lfe.277.2023.08.24.02.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 02:58:57 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 24 Aug 2023 11:58:52 +0200
Subject: [PATCH 1/3] arm64: dts: qcom: sdm845-tama: Add GPIO line names for
 TLMM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-topic-tama_gpio-v1-1-014e9d198dce@linaro.org>
References: <20230824-topic-tama_gpio-v1-0-014e9d198dce@linaro.org>
In-Reply-To: <20230824-topic-tama_gpio-v1-0-014e9d198dce@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692871134; l=12525;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=PhIbvbvU6bm2zsML0qFtramMqdPjyXuUneRgzhg73+U=;
 b=0h35VK6cEekZdu+9mFkpZyn9AFxGdameOqVkmHyub54GdTPWC3ffTC8TP+30HMjtIatooFmpz
 hZUtfLDWTXgBmWcSzX+X//D/5ErdfBB3mAzW359I24Nw3o2jOkdMHGM
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sony ever so graciously provides GPIO line names in their downstream
kernel (though sometimes they are not 100% accurate and you can judge
that by simply looking at them and with what drivers they are used).

Add these to the Akari, Apollo & Akatsuki DTS-es to better document
the hardware.

Apollo can be considered the 'base configuration'. Akari brings
WLC_INT_N on GPIO_31 over that.

Akatsuki & Akari diff:

<                         "NC",
>                         "SAMD_RSTEN_N",
<                         "NC",
>                         "MASTER_RST_N",
<                         "NC",
>                         "DISP_ERR_FG",
<                         "NC",
>                         "SAMD_BOOTL_PIN",
<                         "NC",
<                         "NC",
<                         "NC", /* GPIO_60 */
>                         "SDM_SWD_CLK",
>                         "SDM_SWD_DAT",
>                         "SAMD_RST", /* GPIO_60 */
<                         "NC",
>                         "MODE_SEL2",
<                         "NC",
>                         "NFC_ESE_PWR_REQ",
<                         "NC",
>                         "TS_VDDIO_EN",

Which makes sense, as Akari and Akatsuki have a wireless charger and
Akatsuki also additionally has a super-high-end-complex-for-the-time
Samsung OLED display, as opposed to LCDs on the other Tama devices.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../dts/qcom/sdm845-sony-xperia-tama-akari.dts     | 153 +++++++++++++++++++++
 .../dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts  | 151 ++++++++++++++++++++
 .../dts/qcom/sdm845-sony-xperia-tama-apollo.dts    | 153 +++++++++++++++++++++
 3 files changed, 457 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts
index d97b7f1e7140..d2cb6478a8c0 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts
@@ -15,3 +15,156 @@ / {
 &panel {
 	compatible = "sony,td4353-jdi-tama";
 };
+
+&tlmm {
+	gpio-line-names = "NC", /* GPIO_0 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "DEBUG_UART_TX",
+			  "DEBUG_UART_RX",
+			  "DISP_RESET_N",
+			  "NC",
+			  "CHAT_CAM_PWR_EN",
+			  "CAM2_RSTN",
+			  "MDP_VSYNC_P", /* GPIO_10 */
+			  "RGBC_IR_INT",
+			  "NFC_VEN",
+			  "CAM_MCLK0",
+			  "CAM_MCLK1",
+			  "NC",
+			  "NC",
+			  "CCI_I2C_SDA0",
+			  "CCI_I2C_SCL0",
+			  "CCI_I2C_SDA1",
+			  "CCI_I2C_SCL1", /* GPIO_20 */
+			  "CAM_SOF",
+			  "TOF_INT",
+			  "TOF_RESET_N",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "MAIN_CAM_PWR_EN",
+			  "DVDT_ENABLE",
+			  "DVDT_WRT_DET_AND",
+			  "DVDT_WRT_DET_OR", /* GPIO_30 */
+			  "WLC_INT_N",
+			  "NC",
+			  "CAMSENSOR_I2C_SDA",
+			  "CAMSENSOR_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "CC_DIR",
+			  "NC",
+			  "FP_RESET_N", /* GPIO_40 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "BT_HCI_UART_CTS_N",
+			  "BT_HCI_UART_RFR_N",
+			  "BT_HCI_UART_TXD",
+			  "BT_HCI_UART_TRXD",
+			  "USB_AUDIO_EN1",
+			  "SW_SERVICE", /* GPIO_50 */
+			  "US_EURO_SEL",
+			  "NC",
+			  "CODEC_INT2_N",
+			  "CODEC_INT1_N",
+			  "APPS_I2C_SDA",
+			  "APPS_I2C_SCL",
+			  "FORCED_USB_BOOT",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_60 */
+			  "USB_PD_EN",
+			  "NFC_DWLD_EN",
+			  "NFC_IRQ",
+			  "CODEC_RST_N",
+			  "CODEC_SPI_MISO",
+			  "CODEC_SPI_MOSI",
+			  "CODEC_SPI_CLK",
+			  "CODEC_SPI_CS_N",
+			  "NC",
+			  "CODEC_SLIMBUS_CLK", /* GPIO_70 */
+			  "CODEC_SLIMBUS_DATA0",
+			  "CODEC_SLIMBUS_DATA1",
+			  "BT_FM_SLIMBUS_DATA",
+			  "BT_FM_SLIMBUS_CLK",
+			  "HW_ID_0",
+			  "HW_ID_1",
+			  "TX_GTR_THRES_IN",
+			  "NC",
+			  "NC",
+			  "CAM1_RSTN", /* GPIO_80 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "TS_I2C_SDA",
+			  "TS_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_90 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "RFFE6_CLK",
+			  "RFFE6_DATA",
+			  "TS_RESET_N",
+			  "", /* GPIO_100 */
+			  "GRFC4",
+			  "DEBUG_GPIO0",
+			  "DEBUG_GPIO1",
+			  "RF_LCD_ID_EN",
+			  "UIM2_DATA",
+			  "UIM2_CLK",
+			  "UIM2_RESET",
+			  "UIM2_PRESENT",
+			  "UIM1_DATA",
+			  "UIM1_CLK", /* GPIO_110 */
+			  "UIM1_RESET",
+			  "UIM1_PRESENT",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "ACCEL_INT",
+			  "GYRO_INT",
+			  "COMPASS_INT",
+			  "ALS_PROX_INT_N", /* GPIO_120 */
+			  "FP_INT",
+			  "RF_ID_EXTENTION",
+			  "BAROMETER_INT",
+			  "ACC_COVER_OPEN",
+			  "TS_INT_N",
+			  "TRAY_DET",
+			  "GRFC3",
+			  "NC",
+			  "UIM2_DETECT_EN",
+			  "QLINK_REQUEST", /* GPIO_130 */
+			  "QLINK_ENABLE",
+			  "GRFC2",
+			  "NC",
+			  "WMSS_RESET_N",
+			  "PA_INDICATOR_OR",
+			  "GRFC1",
+			  "RFFE3_DATA",
+			  "RFFE3_CLK",
+			  "RFFE4_DATA",
+			  "RFFE4_CLK", /* GPIO_140 */
+			  "RFFE5_DATA",
+			  "RFFE5_CLK",
+			  "GNSS_EN",
+			  "MSS_LTE_COXM_TXD",
+			  "MSS_LTE_COXM_RXD",
+			  "RFFE2_DATA",
+			  "RFFE2_CLK",
+			  "RFFE1_DATA",
+			  "RFFE1_CLK";
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
index 5d2052a0ff69..a91712f6af28 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
@@ -49,6 +49,157 @@ &pmi8998_wled {
 };
 
 &tlmm {
+	gpio-line-names = "NC", /* GPIO_0 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "DEBUG_UART_TX",
+			  "DEBUG_UART_RX",
+			  "DISP_RESET_N",
+			  "SAMD_RSTEN_N",
+			  "CHAT_CAM_PWR_EN",
+			  "CAM2_RSTN",
+			  "MDP_VSYNC_P", /* GPIO_10 */
+			  "RGBC_IR_INT",
+			  "NFC_VEN",
+			  "CAM_MCLK0",
+			  "CAM_MCLK1",
+			  "NC",
+			  "MASTER_RST_N",
+			  "CCI_I2C_SDA0",
+			  "CCI_I2C_SCL0",
+			  "CCI_I2C_SDA1",
+			  "CCI_I2C_SCL1", /* GPIO_20 */
+			  "CAM_SOF",
+			  "TOF_INT",
+			  "TOF_RESET_N",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "MAIN_CAM_PWR_EN",
+			  "DVDT_ENABLE",
+			  "DVDT_WRT_DET_AND",
+			  "DVDT_WRT_DET_OR", /* GPIO_30 */
+			  "WLC_INT_N",
+			  "NC",
+			  "CAMSENSOR_I2C_SDA",
+			  "CAMSENSOR_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "CC_DIR",
+			  "NC",
+			  "FP_RESET_N", /* GPIO_40 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "DISP_ERR_FG",
+			  "BT_HCI_UART_CTS_N",
+			  "BT_HCI_UART_RFR_N",
+			  "BT_HCI_UART_TXD",
+			  "BT_HCI_UART_TRXD",
+			  "USB_AUDIO_EN1",
+			  "SW_SERVICE", /* GPIO_50 */
+			  "US_EURO_SEL",
+			  "SAMD_BOOTL_PIN",
+			  "CODEC_INT2_N",
+			  "CODEC_INT1_N",
+			  "APPS_I2C_SDA",
+			  "APPS_I2C_SCL",
+			  "FORCED_USB_BOOT",
+			  "SDM_SWD_CLK",
+			  "SDM_SWD_DAT",
+			  "SAMD_RST", /* GPIO_60 */
+			  "USB_PD_EN",
+			  "NFC_DWLD_EN",
+			  "NFC_IRQ",
+			  "CODEC_RST_N",
+			  "CODEC_SPI_MISO",
+			  "CODEC_SPI_MOSI",
+			  "CODEC_SPI_CLK",
+			  "CODEC_SPI_CS_N",
+			  "NC",
+			  "CODEC_SLIMBUS_CLK", /* GPIO_70 */
+			  "CODEC_SLIMBUS_DATA0",
+			  "CODEC_SLIMBUS_DATA1",
+			  "BT_FM_SLIMBUS_DATA",
+			  "BT_FM_SLIMBUS_CLK",
+			  "HW_ID_0",
+			  "HW_ID_1",
+			  "TX_GTR_THRES_IN",
+			  "MODE_SEL2",
+			  "NC",
+			  "CAM1_RSTN", /* GPIO_80 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "TS_I2C_SDA",
+			  "TS_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_90 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "RFFE6_CLK",
+			  "RFFE6_DATA",
+			  "TS_RESET_N",
+			  "", /* GPIO_100 */
+			  "GRFC4",
+			  "DEBUG_GPIO0",
+			  "DEBUG_GPIO1",
+			  "RF_LCD_ID_EN",
+			  "UIM2_DATA",
+			  "UIM2_CLK",
+			  "UIM2_RESET",
+			  "UIM2_PRESENT",
+			  "UIM1_DATA",
+			  "UIM1_CLK", /* GPIO_110 */
+			  "UIM1_RESET",
+			  "UIM1_PRESENT",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NFC_ESE_PWR_REQ",
+			  "ACCEL_INT",
+			  "GYRO_INT",
+			  "COMPASS_INT",
+			  "ALS_PROX_INT_N", /* GPIO_120 */
+			  "FP_INT",
+			  "RF_ID_EXTENTION",
+			  "BAROMETER_INT",
+			  "ACC_COVER_OPEN",
+			  "TS_INT_N",
+			  "TRAY_DET",
+			  "GRFC3",
+			  "NC",
+			  "UIM2_DETECT_EN",
+			  "QLINK_REQUEST", /* GPIO_130 */
+			  "QLINK_ENABLE",
+			  "GRFC2",
+			  "TS_VDDIO_EN",
+			  "WMSS_RESET_N",
+			  "PA_INDICATOR_OR",
+			  "GRFC1",
+			  "RFFE3_DATA",
+			  "RFFE3_CLK",
+			  "RFFE4_DATA",
+			  "RFFE4_CLK", /* GPIO_140 */
+			  "RFFE5_DATA",
+			  "RFFE5_CLK",
+			  "GNSS_EN",
+			  "MSS_LTE_COXM_TXD",
+			  "MSS_LTE_COXM_RXD",
+			  "RFFE2_DATA",
+			  "RFFE2_CLK",
+			  "RFFE1_DATA",
+			  "RFFE1_CLK";
+
 	ts_vddio_en: ts-vddio-en-state {
 		pins = "gpio133";
 		function = "gpio";
diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dts b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dts
index cd056f78070f..52bd83d1febf 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dts
@@ -17,3 +17,156 @@ &panel {
 	height-mm = <112>;
 	width-mm = <56>;
 };
+
+&tlmm {
+	gpio-line-names = "NC", /* GPIO_0 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "DEBUG_UART_TX",
+			  "DEBUG_UART_RX",
+			  "DISP_RESET_N",
+			  "NC",
+			  "CHAT_CAM_PWR_EN",
+			  "CAM2_RSTN",
+			  "MDP_VSYNC_P", /* GPIO_10 */
+			  "RGBC_IR_INT",
+			  "NFC_VEN",
+			  "CAM_MCLK0",
+			  "CAM_MCLK1",
+			  "NC",
+			  "NC",
+			  "CCI_I2C_SDA0",
+			  "CCI_I2C_SCL0",
+			  "CCI_I2C_SDA1",
+			  "CCI_I2C_SCL1", /* GPIO_20 */
+			  "CAM_SOF",
+			  "TOF_INT",
+			  "TOF_RESET_N",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "MAIN_CAM_PWR_EN",
+			  "DVDT_ENABLE",
+			  "DVDT_WRT_DET_AND",
+			  "DVDT_WRT_DET_OR", /* GPIO_30 */
+			  "NC",
+			  "NC",
+			  "CAMSENSOR_I2C_SDA",
+			  "CAMSENSOR_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "CC_DIR",
+			  "NC",
+			  "FP_RESET_N", /* GPIO_40 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "BT_HCI_UART_CTS_N",
+			  "BT_HCI_UART_RFR_N",
+			  "BT_HCI_UART_TXD",
+			  "BT_HCI_UART_TRXD",
+			  "USB_AUDIO_EN1",
+			  "SW_SERVICE", /* GPIO_50 */
+			  "US_EURO_SEL",
+			  "NC",
+			  "CODEC_INT2_N",
+			  "CODEC_INT1_N",
+			  "APPS_I2C_SDA",
+			  "APPS_I2C_SCL",
+			  "FORCED_USB_BOOT",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_60 */
+			  "USB_PD_EN",
+			  "NFC_DWLD_EN",
+			  "NFC_IRQ",
+			  "CODEC_RST_N",
+			  "CODEC_SPI_MISO",
+			  "CODEC_SPI_MOSI",
+			  "CODEC_SPI_CLK",
+			  "CODEC_SPI_CS_N",
+			  "NC",
+			  "CODEC_SLIMBUS_CLK", /* GPIO_70 */
+			  "CODEC_SLIMBUS_DATA0",
+			  "CODEC_SLIMBUS_DATA1",
+			  "BT_FM_SLIMBUS_DATA",
+			  "BT_FM_SLIMBUS_CLK",
+			  "HW_ID_0",
+			  "HW_ID_1",
+			  "TX_GTR_THRES_IN",
+			  "NC",
+			  "NC",
+			  "CAM1_RSTN", /* GPIO_80 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "TS_I2C_SDA",
+			  "TS_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_90 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "RFFE6_CLK",
+			  "RFFE6_DATA",
+			  "TS_RESET_N",
+			  "", /* GPIO_100 */
+			  "GRFC4",
+			  "DEBUG_GPIO0",
+			  "DEBUG_GPIO1",
+			  "RF_LCD_ID_EN",
+			  "UIM2_DATA",
+			  "UIM2_CLK",
+			  "UIM2_RESET",
+			  "UIM2_PRESENT",
+			  "UIM1_DATA",
+			  "UIM1_CLK", /* GPIO_110 */
+			  "UIM1_RESET",
+			  "UIM1_PRESENT",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "ACCEL_INT",
+			  "GYRO_INT",
+			  "COMPASS_INT",
+			  "ALS_PROX_INT_N", /* GPIO_120 */
+			  "FP_INT",
+			  "RF_ID_EXTENTION",
+			  "BAROMETER_INT",
+			  "ACC_COVER_OPEN",
+			  "TS_INT_N",
+			  "TRAY_DET",
+			  "GRFC3",
+			  "NC",
+			  "UIM2_DETECT_EN",
+			  "QLINK_REQUEST", /* GPIO_130 */
+			  "QLINK_ENABLE",
+			  "GRFC2",
+			  "NC",
+			  "WMSS_RESET_N",
+			  "PA_INDICATOR_OR",
+			  "GRFC1",
+			  "RFFE3_DATA",
+			  "RFFE3_CLK",
+			  "RFFE4_DATA",
+			  "RFFE4_CLK", /* GPIO_140 */
+			  "RFFE5_DATA",
+			  "RFFE5_CLK",
+			  "GNSS_EN",
+			  "MSS_LTE_COXM_TXD",
+			  "MSS_LTE_COXM_RXD",
+			  "RFFE2_DATA",
+			  "RFFE2_CLK",
+			  "RFFE1_DATA",
+			  "RFFE1_CLK";
+};

-- 
2.42.0

