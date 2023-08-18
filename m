Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045D6780F19
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378158AbjHRPYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378119AbjHRPX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:23:59 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A703C1F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 08:23:55 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ff91f2d7e2so1410479e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 08:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692372233; x=1692977033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1C0vCDTaaUlQQOaP+aUyo87dt8SzTy/fVmI6KNG6Qfg=;
        b=wx9p9RSXvwziATlMwVYVVrbpx2Z9ABqklNhv/UuFDKnTWuxJqVrVQesIlZlG3rmqEr
         gctgW1zDC1tib5AhcVcao2DJ6dlNn5lUlZQ9v4i1NCKeaNJfv91d/aFBEM1zQb4NvgFn
         Bsvmz9yDgo1jknBdhFmLnboozdHWSAgxVQ7uzfZaHGWBnaysoq/OcBHiYHri39idW9Cs
         s/dJjYhjN1YwB8peBF97w+gTXr0VsqY31IV/42GXC6zk2y5c4QbdTDPC1hX2bg2zWtHV
         cNRZTGaGfhlNw+Fq77tSD+OYLGoeORSPeKyEvFxVm//dXxJ43xZa1WtBE4l3jgWHfyD6
         FN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692372233; x=1692977033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1C0vCDTaaUlQQOaP+aUyo87dt8SzTy/fVmI6KNG6Qfg=;
        b=YHLt2pBpVlkatoYQUBE+8na5xPoCBSnYOj9Pre8rpopylbeeQO8+TQUOMzoqf7xV5j
         lDoyFwVLiL1p/RlxxvMgZCAL8L6UWZ3nN6TSffjGzJ4j7JyggOOniDiglF9k9PkOXpkn
         En746XuK3910ibYrcnO6Fq1OVcalpAK2Mvv8WC7yihQN6Tp8WGtr7yzLYKdI+zq4+URv
         2o9dOEbWSLP+vLenjCGDEH7zLrtRycBg3LLafrNsdRrct71hgu/N7KfZAnNtI6Fa4k2+
         swUuzci81E+ijYffYP+HI1lf18MQOODAPRlK9ANV/kfizxxJZf2lZ4JVh1jSYpIQn2kD
         IXHw==
X-Gm-Message-State: AOJu0YyXW3oG0oAoDdKfuR0pQhpNcA/vJGzghHptxUXJZENbT3Jdq+qG
        2+CVzh2dauRJE/Am0BzQ6G7LqQ==
X-Google-Smtp-Source: AGHT+IHYRePZMnnp6MM60liWo6ROE9kW+vSENW75nQbCW8CoaiZiXyLXxcof3BJkVQM0RoAXa5gL3g==
X-Received: by 2002:a19:7616:0:b0:4fe:1e69:c37b with SMTP id c22-20020a197616000000b004fe1e69c37bmr1828659lff.10.1692372233316;
        Fri, 18 Aug 2023 08:23:53 -0700 (PDT)
Received: from [192.168.1.101] (abxh52.neoplus.adsl.tpnet.pl. [83.9.1.52])
        by smtp.gmail.com with ESMTPSA id y2-20020ac24202000000b004fe4d122a66sm383715lfh.187.2023.08.18.08.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:23:53 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 18 Aug 2023 17:23:27 +0200
Subject: [PATCH 4/5] arm64: dts: qcom: sm6375-murray: Separate out common
 parts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230818-topic-10v-v1-4-dbb6464223c6@linaro.org>
References: <20230818-topic-10v-v1-0-dbb6464223c6@linaro.org>
In-Reply-To: <20230818-topic-10v-v1-0-dbb6464223c6@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-hardening@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692372226; l=18160;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=N8+JyTSCBYvOorQ+CdiyBuRQvt/vFE9GwEbDEamdj/U=;
 b=DoY727hXHG4qQyuaodsCRofdFlP0La/wHB1AoFDAfuZmQVXXqKasGc7sc6FgmWf+b0rwj/t/3
 Z8Cgbsg6vliC6h6c+FndkZAKlfvz5L8EZ+5DQUcfxPT3zVPpVDjbq33
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a new kid in the Murray family, let's make space for it!

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../dts/qcom/sm6375-sony-xperia-murray-pdx225.dts  | 421 +-------------------
 .../boot/dts/qcom/sm6375-sony-xperia-murray.dtsi   | 427 +++++++++++++++++++++
 2 files changed, 428 insertions(+), 420 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
index b2f1bb1d58e9..bcbef6ed7006 100644
--- a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
+++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
@@ -5,429 +5,10 @@
 
 /dts-v1/;
 
-/* PMK8350 is configured to use SID6 instead of 0 */
-#define PMK8350_SID 6
-
-#include <dt-bindings/gpio/gpio.h>
-#include "sm6375.dtsi"
-#include "pm6125.dtsi"
-#include "pmk8350.dtsi"
-#include "pmr735a.dtsi"
-
-/* PM6125 PON is used and we can't have duplicate labels */
-/delete-node/ &pmk8350_pon;
+#include "sm6375-sony-xperia-murray.dtsi"
 
 / {
 	model = "Sony Xperia 10 IV";
 	compatible = "sony,pdx225", "qcom,sm6375";
 	chassis-type = "handset";
-
-	chosen {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		framebuffer: framebuffer@85200000 {
-			compatible = "simple-framebuffer";
-			reg = <0 0x85200000 0 0xc00000>;
-
-			width = <1080>;
-			height = <2520>;
-			stride = <(1080 * 4)>;
-			format = "a8r8g8b8";
-			/*
-			 * That's (going to be) a lot of clocks, but it's necessary due
-			 * to unused clk cleanup & no panel driver yet
-			 */
-			clocks = <&gcc GCC_DISP_AHB_CLK>,
-				 <&gcc GCC_DISP_HF_AXI_CLK>,
-				 <&gcc GCC_DISP_THROTTLE_CORE_CLK>,
-				 <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>;
-		};
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		label = "gpio-keys";
-
-		pinctrl-0 = <&vol_down_n>;
-		pinctrl-names = "default";
-
-		key-volume-down {
-			label = "Volume Down";
-			linux,code = <KEY_VOLUMEDOWN>;
-			gpios = <&pmr735a_gpios 1 GPIO_ACTIVE_LOW>;
-			debounce-interval = <15>;
-			linux,can-disable;
-			wakeup-source;
-		};
-	};
-
-	reserved-memory {
-		cont_splash_mem: memory@85200000 {
-			reg = <0 0x85200000 0 0xc00000>;
-			no-map;
-		};
-
-		ramoops@ffc40000 {
-			compatible = "ramoops";
-			reg = <0 0xffc40000 0 0xb0000>;
-			record-size = <0x10000>;
-			console-size = <0x60000>;
-			ftrace-size = <0x10000>;
-			pmsg-size = <0x20000>;
-			ecc-size = <16>;
-		};
-	};
-
-	vph_pwr: vph-pwr-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vph_pwr";
-		regulator-min-microvolt = <3700000>;
-		regulator-max-microvolt = <3700000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-};
-
-&sdc2_off_state {
-	sd-cd-pins {
-		pins = "gpio94";
-		function = "gpio";
-		drive-strength = <2>;
-		bias-disable;
-	};
-};
-
-&sdc2_on_state {
-	sd-cd-pins {
-		pins = "gpio94";
-		function = "gpio";
-		drive-strength = <2>;
-		bias-pull-up;
-	};
-};
-
-&sdhc_2 {
-	status = "okay";
-
-	vmmc-supply = <&pm6125_l22>;
-	vqmmc-supply = <&pm6125_l5>;
-
-	cd-gpios = <&tlmm 94 GPIO_ACTIVE_HIGH>;
-};
-
-&gpi_dma0 {
-	status = "okay";
-};
-
-&gpi_dma1 {
-	status = "okay";
-};
-
-&i2c8 {
-	clock-frequency = <400000>;
-	status = "okay";
-
-	touchscreen@48 {
-		compatible = "samsung,s6sy761";
-		reg = <0x48>;
-		interrupt-parent = <&tlmm>;
-		interrupts = <22 0x2008>;
-
-		vdd-supply = <&pm6125_l13>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&ts_int_default &ts_avdd_default>;
-	};
-};
-
-&pmk8350_adc_tm {
-	status = "okay";
-};
-
-&pmk8350_rtc {
-	status = "okay";
-};
-
-&pmr735a_gpios {
-	vol_down_n: vol-down-n-state {
-		pins = "gpio1";
-		function = "normal";
-		power-source = <1>;
-		bias-pull-up;
-		input-enable;
-	};
-};
-
-&pon_pwrkey {
-	status = "okay";
-};
-
-&pon_resin {
-	linux,code = <KEY_VOLUMEUP>;
-	status = "okay";
-};
-
-&qupv3_id_0 {
-	status = "okay";
-};
-
-&qupv3_id_1 {
-	status = "okay";
-};
-
-&remoteproc_adsp {
-	firmware-name = "qcom/sm6375/Sony/murray/adsp.mbn";
-	status = "okay";
-};
-
-&remoteproc_cdsp {
-	firmware-name = "qcom/sm6375/Sony/murray/cdsp.mbn";
-	status = "okay";
-};
-
-&rpm_requests {
-	regulators-0 {
-		compatible = "qcom,rpm-pm6125-regulators";
-
-		pm6125_s5: s5 {
-			regulator-min-microvolt = <382000>;
-			regulator-max-microvolt = <1120000>;
-		};
-
-		pm6125_s6: s6 {
-			regulator-min-microvolt = <320000>;
-			regulator-max-microvolt = <1374000>;
-		};
-
-		pm6125_s7: s7 {
-			regulator-min-microvolt = <1574000>;
-			regulator-max-microvolt = <2040000>;
-		};
-
-		/*
-		 * S8 is VDD_GFX
-		 * L1 is VDD_LPI_CX
-		 */
-
-		pm6125_l2: l2 {
-			regulator-min-microvolt = <1170000>;
-			regulator-max-microvolt = <1304000>;
-		};
-
-		pm6125_l3: l3 {
-			regulator-min-microvolt = <1100000>;
-			regulator-max-microvolt = <1300000>;
-		};
-
-		pm6125_l4: l4 {
-			regulator-min-microvolt = <1100000>;
-			regulator-max-microvolt = <1300000>;
-		};
-
-		pm6125_l5: l5 {
-			regulator-min-microvolt = <1650000>;
-			regulator-max-microvolt = <2960000>;
-			regulator-allow-set-load;
-		};
-
-		pm6125_l6: l6 {
-			regulator-min-microvolt = <1080000>;
-			regulator-max-microvolt = <1304000>;
-		};
-
-		pm6125_l7: l7 {
-			regulator-min-microvolt = <720000>;
-			regulator-max-microvolt = <1050000>;
-		};
-
-		pm6125_l8: l8 {
-			regulator-min-microvolt = <1100000>;
-			regulator-max-microvolt = <1304000>;
-		};
-
-		pm6125_l9: l9 {
-			regulator-min-microvolt = <1504000>;
-			regulator-max-microvolt = <2000000>;
-		};
-
-		pm6125_l10: l10 {
-			regulator-min-microvolt = <1620000>;
-			regulator-max-microvolt = <1980000>;
-		};
-
-		pm6125_l11: l11 {
-			regulator-min-microvolt = <1620000>;
-			regulator-max-microvolt = <1980000>;
-		};
-
-		pm6125_l12: l12 {
-			regulator-min-microvolt = <1620000>;
-			regulator-max-microvolt = <2000000>;
-		};
-
-		pm6125_l13: l13 {
-			regulator-min-microvolt = <1650000>;
-			regulator-max-microvolt = <1980000>;
-		};
-
-		pm6125_l14: l14 {
-			regulator-min-microvolt = <1700000>;
-			regulator-max-microvolt = <1900000>;
-		};
-
-		pm6125_l15: l15 {
-			regulator-min-microvolt = <1650000>;
-			regulator-max-microvolt = <3544000>;
-		};
-
-		pm6125_l16: l16 {
-			regulator-min-microvolt = <1620000>;
-			regulator-max-microvolt = <1980000>;
-		};
-
-		/* L17 is VDD_LPI_MX */
-
-		pm6125_l18: l18 {
-			regulator-min-microvolt = <830000>;
-			regulator-max-microvolt = <920000>;
-		};
-
-		pm6125_l19: l19 {
-			regulator-min-microvolt = <1624000>;
-			regulator-max-microvolt = <3304000>;
-		};
-
-		pm6125_l20: l20 {
-			regulator-min-microvolt = <1624000>;
-			regulator-max-microvolt = <3304000>;
-		};
-
-		pm6125_l21: l21 {
-			regulator-min-microvolt = <3000000>;
-			regulator-max-microvolt = <3400000>;
-		};
-
-		pm6125_l22: l22 {
-			regulator-min-microvolt = <2704000>;
-			regulator-max-microvolt = <2960000>;
-			regulator-allow-set-load;
-		};
-
-		pm6125_l23: l23 {
-			regulator-min-microvolt = <3000000>;
-			regulator-max-microvolt = <3400000>;
-		};
-
-		pm6125_l24: l24 {
-			regulator-min-microvolt = <2704000>;
-			regulator-max-microvolt = <3544000>;
-		};
-	};
-
-	regulators-1 {
-		compatible = "qcom,rpm-pmr735a-regulators";
-
-		/*
-		 * S1 is VDD_MX
-		 * S2 is VDD_CX
-		 */
-
-		pmr735a_l1: l1 {
-			regulator-min-microvolt = <570000>;
-			regulator-max-microvolt = <650000>;
-		};
-
-		pmr735a_l2: l2 {
-			regulator-min-microvolt = <352000>;
-			regulator-max-microvolt = <796000>;
-		};
-
-		pmr735a_l3: l3 {
-			regulator-min-microvolt = <1000000>;
-			regulator-max-microvolt = <1200000>;
-		};
-
-		pmr735a_l4: l4 {
-			regulator-min-microvolt = <1504000>;
-			regulator-max-microvolt = <2000000>;
-		};
-
-		pmr735a_l5: l5 {
-			regulator-min-microvolt = <751000>;
-			regulator-max-microvolt = <824000>;
-		};
-
-		pmr735a_l6: l6 {
-			regulator-min-microvolt = <504000>;
-			regulator-max-microvolt = <868000>;
-		};
-
-		pmr735a_l7: l7 {
-			regulator-min-microvolt = <2700000>;
-			regulator-max-microvolt = <3544000>;
-		};
-	};
-};
-
-&sdc2_off_state {
-	sd-cd-pins {
-		pins = "gpio94";
-		function = "gpio";
-		drive-strength = <2>;
-		bias-disable;
-	};
-};
-
-&sdc2_on_state {
-	sd-cd-pins {
-		pins = "gpio94";
-		function = "gpio";
-		drive-strength = <2>;
-		bias-pull-up;
-	};
-};
-
-&sdhc_2 {
-	status = "okay";
-
-	vmmc-supply = <&pm6125_l22>;
-	vqmmc-supply = <&pm6125_l5>;
-
-	cd-gpios = <&tlmm 94 GPIO_ACTIVE_HIGH>;
-};
-
-&tlmm {
-	gpio-reserved-ranges = <13 4>;
-
-	ts_int_default: ts-int-default-state {
-		pins = "gpio22";
-		function = "gpio";
-		drive-strength = <8>;
-		bias-pull-up;
-	};
-
-	ts_avdd_default: ts-avdd-default-state {
-		pins = "gpio59";
-		function = "gpio";
-		drive-strength = <8>;
-		output-high;
-	};
-};
-
-&usb_1 {
-	status = "okay";
-};
-
-&usb_1_dwc3 {
-	dr_mode = "peripheral";
-};
-
-&usb_1_hsphy {
-	status = "okay";
-};
-
-&xo_board_clk {
-	clock-frequency = <19200000>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray.dtsi b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray.dtsi
new file mode 100644
index 000000000000..072f7ce2a7f6
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray.dtsi
@@ -0,0 +1,427 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Konrad Dybcio <konrad.dybcio@somainline.org>
+ */
+
+/* PMK8350 is configured to use SID6 instead of 0 */
+#define PMK8350_SID 6
+
+#include <dt-bindings/gpio/gpio.h>
+#include "sm6375.dtsi"
+#include "pm6125.dtsi"
+#include "pmk8350.dtsi"
+#include "pmr735a.dtsi"
+
+/* PM6125 PON is used and we can't have duplicate labels */
+/delete-node/ &pmk8350_pon;
+
+/ {
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		framebuffer: framebuffer@85200000 {
+			compatible = "simple-framebuffer";
+			reg = <0 0x85200000 0 0xc00000>;
+
+			width = <1080>;
+			height = <2520>;
+			stride = <(1080 * 4)>;
+			format = "a8r8g8b8";
+			/*
+			 * That's (going to be) a lot of clocks, but it's necessary due
+			 * to unused clk cleanup & no panel driver yet
+			 */
+			clocks = <&gcc GCC_DISP_AHB_CLK>,
+				 <&gcc GCC_DISP_HF_AXI_CLK>,
+				 <&gcc GCC_DISP_THROTTLE_CORE_CLK>,
+				 <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		label = "gpio-keys";
+
+		pinctrl-0 = <&vol_down_n>;
+		pinctrl-names = "default";
+
+		key-volume-down {
+			label = "Volume Down";
+			linux,code = <KEY_VOLUMEDOWN>;
+			gpios = <&pmr735a_gpios 1 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+	};
+
+	reserved-memory {
+		cont_splash_mem: memory@85200000 {
+			reg = <0 0x85200000 0 0xc00000>;
+			no-map;
+		};
+
+		ramoops@ffc40000 {
+			compatible = "ramoops";
+			reg = <0 0xffc40000 0 0xb0000>;
+			record-size = <0x10000>;
+			console-size = <0x60000>;
+			ftrace-size = <0x10000>;
+			pmsg-size = <0x20000>;
+			ecc-size = <16>;
+		};
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&sdc2_off_state {
+	sd-cd-pins {
+		pins = "gpio94";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&sdc2_on_state {
+	sd-cd-pins {
+		pins = "gpio94";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+};
+
+&sdhc_2 {
+	status = "okay";
+
+	vmmc-supply = <&pm6125_l22>;
+	vqmmc-supply = <&pm6125_l5>;
+
+	cd-gpios = <&tlmm 94 GPIO_ACTIVE_HIGH>;
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
+&i2c8 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	touchscreen@48 {
+		compatible = "samsung,s6sy761";
+		reg = <0x48>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <22 0x2008>;
+
+		vdd-supply = <&pm6125_l13>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_int_default &ts_avdd_default>;
+	};
+};
+
+&pmk8350_adc_tm {
+	status = "okay";
+};
+
+&pmk8350_rtc {
+	status = "okay";
+};
+
+&pmr735a_gpios {
+	vol_down_n: vol-down-n-state {
+		pins = "gpio1";
+		function = "normal";
+		power-source = <1>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEUP>;
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
+&remoteproc_adsp {
+	firmware-name = "qcom/sm6375/Sony/murray/adsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/sm6375/Sony/murray/cdsp.mbn";
+	status = "okay";
+};
+
+&rpm_requests {
+	regulators-0 {
+		compatible = "qcom,rpm-pm6125-regulators";
+
+		pm6125_s5: s5 {
+			regulator-min-microvolt = <382000>;
+			regulator-max-microvolt = <1120000>;
+		};
+
+		pm6125_s6: s6 {
+			regulator-min-microvolt = <320000>;
+			regulator-max-microvolt = <1374000>;
+		};
+
+		pm6125_s7: s7 {
+			regulator-min-microvolt = <1574000>;
+			regulator-max-microvolt = <2040000>;
+		};
+
+		/*
+		 * S8 is VDD_GFX
+		 * L1 is VDD_LPI_CX
+		 */
+
+		pm6125_l2: l2 {
+			regulator-min-microvolt = <1170000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		pm6125_l3: l3 {
+			regulator-min-microvolt = <1100000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		pm6125_l4: l4 {
+			regulator-min-microvolt = <1100000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		pm6125_l5: l5 {
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-allow-set-load;
+		};
+
+		pm6125_l6: l6 {
+			regulator-min-microvolt = <1080000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		pm6125_l7: l7 {
+			regulator-min-microvolt = <720000>;
+			regulator-max-microvolt = <1050000>;
+		};
+
+		pm6125_l8: l8 {
+			regulator-min-microvolt = <1100000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		pm6125_l9: l9 {
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		pm6125_l10: l10 {
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <1980000>;
+		};
+
+		pm6125_l11: l11 {
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <1980000>;
+		};
+
+		pm6125_l12: l12 {
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		pm6125_l13: l13 {
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <1980000>;
+		};
+
+		pm6125_l14: l14 {
+			regulator-min-microvolt = <1700000>;
+			regulator-max-microvolt = <1900000>;
+		};
+
+		pm6125_l15: l15 {
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <3544000>;
+		};
+
+		pm6125_l16: l16 {
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <1980000>;
+		};
+
+		/* L17 is VDD_LPI_MX */
+
+		pm6125_l18: l18 {
+			regulator-min-microvolt = <830000>;
+			regulator-max-microvolt = <920000>;
+		};
+
+		pm6125_l19: l19 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		pm6125_l20: l20 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		pm6125_l21: l21 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3400000>;
+		};
+
+		pm6125_l22: l22 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-allow-set-load;
+		};
+
+		pm6125_l23: l23 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3400000>;
+		};
+
+		pm6125_l24: l24 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <3544000>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,rpm-pmr735a-regulators";
+
+		/*
+		 * S1 is VDD_MX
+		 * S2 is VDD_CX
+		 */
+
+		pmr735a_l1: l1 {
+			regulator-min-microvolt = <570000>;
+			regulator-max-microvolt = <650000>;
+		};
+
+		pmr735a_l2: l2 {
+			regulator-min-microvolt = <352000>;
+			regulator-max-microvolt = <796000>;
+		};
+
+		pmr735a_l3: l3 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pmr735a_l4: l4 {
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		pmr735a_l5: l5 {
+			regulator-min-microvolt = <751000>;
+			regulator-max-microvolt = <824000>;
+		};
+
+		pmr735a_l6: l6 {
+			regulator-min-microvolt = <504000>;
+			regulator-max-microvolt = <868000>;
+		};
+
+		pmr735a_l7: l7 {
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <3544000>;
+		};
+	};
+};
+
+&sdc2_off_state {
+	sd-cd-pins {
+		pins = "gpio94";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&sdc2_on_state {
+	sd-cd-pins {
+		pins = "gpio94";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+};
+
+&sdhc_2 {
+	status = "okay";
+
+	vmmc-supply = <&pm6125_l22>;
+	vqmmc-supply = <&pm6125_l5>;
+
+	cd-gpios = <&tlmm 94 GPIO_ACTIVE_HIGH>;
+};
+
+&tlmm {
+	gpio-reserved-ranges = <13 4>;
+
+	ts_int_default: ts-int-default-state {
+		pins = "gpio22";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
+	ts_avdd_default: ts-avdd-default-state {
+		pins = "gpio59";
+		function = "gpio";
+		drive-strength = <8>;
+		output-high;
+	};
+};
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "peripheral";
+};
+
+&usb_1_hsphy {
+	status = "okay";
+};
+
+&xo_board_clk {
+	clock-frequency = <19200000>;
+};

-- 
2.41.0

