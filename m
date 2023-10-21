Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0413C7D1C7F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 12:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjJUKVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 06:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjJUKUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 06:20:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A446D5B;
        Sat, 21 Oct 2023 03:20:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5522C433D9;
        Sat, 21 Oct 2023 10:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697883645;
        bh=qQUYOFRneXglnQjUZHXccRjcxl3amfsQW0dGZV7/QBw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=H6gkRBpzZIcSiT2csgw5HEm/hrZfCbsNnahTbuCdH5ku9GUFgUE3pG5gbQs70Yh4/
         hOHrOAtwDMI/7znd1x4i6uSLgP47U1mTzyBXFoGc2VJehVCtICQkhKrC9V/Hgu0OAk
         WoO3LDzXRDAypjuSEkVKe3jXziHREmJOJHFiSxjXVitviP3cUOU+cHf0WMzEsbpO7s
         /u5BPnGZ8I/DTD6PGs0F0b6ufX8paDit3Kg1Nk93l7twA7pnMyajG1xtP/JQwUj8em
         Iy4Kpu0HRE/DlCIiP+NE5PhSxRnw4vgOFHVTRrJm3sUrLifaAG33mM0uwF95zs6Va5
         eAgsHQ8tylvsQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 89F0CC25B42;
        Sat, 21 Oct 2023 10:20:45 +0000 (UTC)
From:   Xilin Wu via B4 Relay <devnull+wuxilin123.gmail.com@kernel.org>
Date:   Sat, 21 Oct 2023 18:20:40 +0800
Subject: [PATCH v2 3/3] arm64: dts: qcom: Add device tree for Xiaomi Mi 11
 Ultra
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231021-sakuramist-mi11u-v2-3-fa82c91ecaf0@gmail.com>
References: <20231021-sakuramist-mi11u-v2-0-fa82c91ecaf0@gmail.com>
In-Reply-To: <20231021-sakuramist-mi11u-v2-0-fa82c91ecaf0@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
        Xilin Wu <wuxilin123@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697883643; l=31018;
 i=wuxilin123@gmail.com; s=20231021; h=from:subject:message-id;
 bh=XHLY8lvyckaP5vG1NEc+3Vw2fHAcQfJUfB/pIIlb1FI=;
 b=uzlffYw7mKvXTxOLilguae27z0+4PZbPiG8dBc0v++UIM9fGilrRkxkKSwkp9gFeiDAJ98hyF
 gtLIr1eOBcuCCTTiz9VDFPTTh7egDtsV1eD7JxYU7WkLwKaXGMK9jL0
X-Developer-Key: i=wuxilin123@gmail.com; a=ed25519;
 pk=edoFbrGewAWr5/CxptHll7XzvXBjYiN49RrEgipi1Cg=
X-Endpoint-Received: by B4 Relay for wuxilin123@gmail.com/20231021 with auth_id=89
X-Original-From: Xilin Wu <wuxilin123@gmail.com>
Reply-To: <wuxilin123@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xilin Wu <wuxilin123@gmail.com>

Add support for Xiaomi Mi 11 Ultra. This commit brings support for:
* Front and rear display panels (initialized by bootloader)
* USB
* UFS
* PCIe0
* Thermistor sensors
* ADSP/CDSP/Modem/SLPI
* IR Transmitter
* RTC provided by PMK8350
* Buttons

To create a working boot image, you need to run:
cat arch/arm64/boot/Image.gz arch/arm64/boot/dts/qcom/sm8350-xiaomi-\
star.dtb > .Image.gz-dtb

mkbootimg \
--kernel .Image.gz-dtb \
--ramdisk some_initrd.img \
--pagesize 4096 \
--base 0x0 \
--kernel_offset 0x8000 \
--ramdisk_offset 0x1000000 \
--tags_offset 0x100 \
--cmdline "SOME_CMDLINE" \
--dtb_offset 0x1f00000 \
--header_version 1 \
--os_version 14.0.0 \
--os_patch_level 2099-12 \
-o boot.img-xiaomi-star

Then, you can flash it to slot b on the device:

// You have to either pull vbmeta{"","_system"} from
// /dev/block/bootdevice/by-name/ or build one as a part of AOSP build process
fastboot --disable-verity --disable-verification flash vbmeta_b vbmeta.img
fastboot --disable-verity --disable-verification flash vbmeta_system_b \
vbmeta_system.img

fastboot flash boot_b boot.img-xiaomi-star
fastboot erase dtbo_b
fastboot set_active b
fastboot reboot

Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile               |    1 +
 arch/arm64/boot/dts/qcom/sm8350-xiaomi-star.dts | 1249 +++++++++++++++++++++++
 2 files changed, 1250 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index d6cb840b7050..635bda47ebdf 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -225,6 +225,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-microsoft-surface-duo2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx214.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx215.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-xiaomi-star.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-qrd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx223.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8350-xiaomi-star.dts b/arch/arm64/boot/dts/qcom/sm8350-xiaomi-star.dts
new file mode 100644
index 000000000000..6140e74fd2e9
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8350-xiaomi-star.dts
@@ -0,0 +1,1249 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023, Xilin Wu <wuxilin123@gmail.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
+#include <dt-bindings/iio/qcom,spmi-adc7-pm8350b.h>
+#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
+#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
+#include "sm8350.dtsi"
+#include "pm8350.dtsi"
+#include "pm8350b.dtsi"
+#include "pm8350c.dtsi"
+#include "pmk8350.dtsi"
+#include "pmr735a.dtsi"
+
+/*
+ * Delete following upstream (sm8350.dtsi) reserved
+ * memory mappings which are different on this device.
+ */
+/delete-node/ &pil_adsp_mem;
+/delete-node/ &pil_slpi_mem;
+/delete-node/ &pil_cdsp_mem;
+/delete-node/ &pil_ipa_fw_mem;
+/delete-node/ &pil_ipa_gsi_mem;
+/delete-node/ &pil_gpu_mem;
+/delete-node/ &pil_spss_mem;
+/delete-node/ &pil_modem_mem;
+/delete-node/ &rmtfs_mem;
+/delete-node/ &pil_trustedvm_mem;
+/delete-node/ &removed_mem;
+
+/ {
+	model = "Xiaomi Mi 11 Ultra";
+	compatible = "xiaomi,star", "qcom,sm8350";
+	chassis-type = "handset";
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		framebuffer0: framebuffer@ea600000 {
+			compatible = "simple-framebuffer";
+			reg = <0 0xea600000 0 (1440 * 3200 * 4)>;
+
+			width = <1440>;
+			height = <3200>;
+			stride = <(1440 * 4)>;
+			format = "a8r8g8b8";
+		};
+
+		framebuffer1: framebuffer@eb79c000 {
+			compatible = "simple-framebuffer";
+			reg = <0 0xeb79c000 0 (126 * 294 * 4)>;
+
+			width = <126>;
+			height = <294>;
+			stride = <(126 * 4)>;
+			format = "a8r8g8b8";
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-0 = <&volume_up_n>;
+		pinctrl-names = "default";
+
+		key-volume-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&pm8350_gpios 6 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+	};
+
+	pmic-glink {
+		compatible = "qcom,sm8350-pmic-glink", "qcom,pmic-glink";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_hs_in: endpoint {
+						remote-endpoint = <&usb_1_dwc3_hs>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					pmic_glink_sbu: endpoint {
+						remote-endpoint = <&fsa4480_sbu_mux>;
+					};
+				};
+			};
+		};
+	};
+
+	reserved-memory {
+		pil_adsp_mem: memory@86100000 {
+			reg = <0 0x86100000 0 0x3900000>;
+			no-map;
+		};
+
+		pil_slpi_mem: memory@89a00000 {
+			reg = <0 0x89a00000 0 0x2f00000>;
+			no-map;
+		};
+
+		pil_cdsp_mem: memory@8c900000 {
+			reg = <0 0x8c900000 0 0x1e00000>;
+			no-map;
+		};
+
+		pil_ipa_fw_mem: memory@8e700000 {
+			reg = <0 0x8e700000 0 0x10000>;
+			no-map;
+		};
+
+		pil_ipa_gsi_mem: memory@8e710000 {
+			reg = <0 0x8e710000 0 0xa000>;
+			no-map;
+		};
+
+		pil_gpu_mem: memory@8e71a000 {
+			reg = <0 0x8e71a000 0 0x2000>;
+			no-map;
+		};
+
+		pil_spss_mem: memory@8e800000 {
+			reg = <0 0x8e800000 0 0x100000>;
+			no-map;
+		};
+
+		pil_modem_mem: memory@8f000000 {
+			reg = <0 0x8f000000 0 0x10000000>;
+			no-map;
+		};
+
+		ramoops@b0000000 {
+			compatible = "ramoops";
+			reg = <0 0xb0000000 0 0x400000>;
+			console-size = <0x200000>;
+			pmsg-size = <0x200000>;
+			ecc-size = <16>;
+			no-map;
+		};
+
+		rmtfs_mem: memory@d6a00000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0 0xd6a00000 0 0x300000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+		};
+
+		removed_mem: memory@d8800000 {
+			reg = <0 0xd8800000 0 0xa000000>;
+			no-map;
+		};
+
+		cont_splash_mem: memory@ea600000 {
+			reg = <0 0xea600000 0 0x2400000>;
+			no-map;
+		};
+	};
+
+	thermal-zones {
+		skin-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmk8350_adc_tm 0>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		flash-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmk8350_adc_tm 1>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		usb-con-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmk8350_adc_tm 2>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		quiet-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmk8350_adc_tm 3>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		pa-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmk8350_adc_tm 4>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		wl-chg-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmk8350_adc_tm 5>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		wifi-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmk8350_adc_tm 6>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&adsp {
+	firmware-name = "qcom/sm8350/xiaomi/star/adsp.mbn";
+	status = "okay";
+};
+
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pm8350-rpmh-regulators";
+		qcom,pmic-id = "b";
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
+		vdd-s11-supply = <&vph_pwr>;
+		vdd-s12-supply = <&vph_pwr>;
+
+		vdd-l1-l4-supply = <&vreg_s11b_0p95>;
+		vdd-l2-l7-supply = <&vreg_bob>;
+		vdd-l3-l5-supply = <&vreg_bob>;
+		vdd-l6-l9-l10-supply = <&vreg_s11b_0p95>;
+		vdd-l8-supply = <&vreg_s2c_0p8>;
+
+		vreg_s10b_1p8: smps10 {
+			regulator-name = "vreg_s10b_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vreg_s11b_0p95: smps11 {
+			regulator-name = "vreg_s11b_0p95";
+			regulator-min-microvolt = <752000>;
+			regulator-max-microvolt = <1000000>;
+		};
+
+		vreg_s12b_1p25: smps12 {
+			regulator-name = "vreg_s12b_1p25";
+			regulator-min-microvolt = <1224000>;
+			regulator-max-microvolt = <1360000>;
+		};
+
+		vreg_l1b_0p88: ldo1 {
+			regulator-name = "vreg_l1b_0p88";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2b_3p07: ldo2 {
+			regulator-name = "vreg_l2b_3p07";
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3b_0p9: ldo3 {
+			regulator-name = "vreg_l3b_0p9";
+			regulator-min-microvolt = <904000>;
+			regulator-max-microvolt = <904000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5b_0p88: ldo5 {
+			regulator-name = "vreg_l5b_0p88";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <888000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6b_1p2: ldo6 {
+			regulator-name = "vreg_l6b_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1208000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7b_2p96: ldo7 {
+			regulator-name = "vreg_l7b_2p96";
+			regulator-min-microvolt = <2400000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9b_1p2: ldo9 {
+			regulator-name = "vreg_l9b_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pm8350c-rpmh-regulators";
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
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+
+		vdd-l1-l12-supply = <&vreg_s1c_1p86>;
+		vdd-l2-l8-supply = <&vreg_s1c_1p86>;
+		vdd-l3-l4-l5-l7-l13-supply = <&vreg_bob>;
+		vdd-l6-l9-l11-supply = <&vreg_bob>;
+		vdd-l10-supply = <&vreg_s12b_1p25>;
+
+		vdd-bob-supply = <&vph_pwr>;
+
+		vreg_s1c_1p86: smps1 {
+			regulator-name = "vreg_s1c_1p86";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		vreg_s2c_0p8: smps2 {
+			regulator-name = "vreg_s2c_0p8";
+			regulator-min-microvolt = <640000>;
+			regulator-max-microvolt = <1000000>;
+		};
+
+		vreg_s10c_1p05: smps10 {
+			regulator-name = "vreg_s10c_1p05";
+			regulator-min-microvolt = <1048000>;
+			regulator-max-microvolt = <1128000>;
+		};
+
+		vreg_bob: bob {
+			regulator-name = "vreg_bob";
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+		};
+
+		vreg_l1c_1p8: ldo1 {
+			regulator-name = "vreg_l1c_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2c_1p8: ldo2 {
+			regulator-name = "vreg_l2c_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3c_3p0: ldo3 {
+			regulator-name = "vreg_l3c_3p0";
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4c_uim1: ldo4 {
+			regulator-name = "vreg_l4c_uim1";
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5c_uim2: ldo5 {
+			regulator-name = "vreg_l5c_uim2";
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6c_1p8: ldo6 {
+			regulator-name = "vreg_l6c_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7c_3p0: ldo7 {
+			regulator-name = "vreg_l7c_3p0";
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8c_1p8: ldo8 {
+			regulator-name = "vreg_l8c_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9c_2p96: ldo9 {
+			regulator-name = "vreg_l9c_2p96";
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10c_1p2: ldo10 {
+			regulator-name = "vreg_l10c_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11c_2p96: ldo11 {
+			regulator-name = "vreg_l11c_2p96";
+			regulator-min-microvolt = <2400000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l12c_1p8: ldo12 {
+			regulator-name = "vreg_l12c_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l13c_3p0: ldo13 {
+			regulator-name = "vreg_l13c_3p0";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-2 {
+		compatible = "qcom,pmr735a-rpmh-regulators";
+		qcom,pmic-id = "e";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+
+		vdd-l1-l2-supply = <&pmr735a_s2>;
+		vdd-l3-supply = <&pmr735a_s1>;
+		vdd-l4-supply = <&vreg_s1c_1p86>;
+		vdd-l5-l6-supply = <&vreg_s1c_1p86>;
+		vdd-l7-bob-supply = <&vreg_bob>;
+
+		pmr735a_s1: smps1 {
+			regulator-name = "pmr735a_s1";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1280000>;
+		};
+
+		pmr735a_s2: smps2 {
+			regulator-name = "pmr735a_s2";
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <976000>;
+		};
+
+		pmr735a_s3: smps3 {
+			regulator-name = "pmr735a_s3";
+			regulator-min-microvolt = <2200000>;
+			regulator-max-microvolt = <2352000>;
+		};
+
+		pmr735a_l1: ldo1 {
+			regulator-name = "pmr735a_l1";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <912000>;
+		};
+
+		pmr735a_l2: ldo2 {
+			regulator-name = "pmr735a_l2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pmr735a_l3: ldo3 {
+			regulator-name = "pmr735a_l3";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pmr735a_l4: ldo4 {
+			regulator-name = "pmr735a_l4";
+			regulator-min-microvolt = <1776000>;
+			regulator-max-microvolt = <1872000>;
+		};
+
+		pmr735a_l5: ldo5 {
+			regulator-name = "pmr735a_l5";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+		};
+
+		pmr735a_l6: ldo6 {
+			regulator-name = "pmr735a_l6";
+			regulator-min-microvolt = <480000>;
+			regulator-max-microvolt = <904000>;
+		};
+
+		pmr735a_l7: ldo7 {
+			regulator-name = "pmr735a_l7";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-always-on;
+		};
+	};
+};
+
+&cdsp {
+	firmware-name = "qcom/sm8350/xiaomi/star/cdsp.mbn";
+	status = "okay";
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
+&i2c4 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/* Zinitix BT541 or Cypress CYTTSP5 rear touchscreen @ 24 */
+};
+
+&i2c6 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/* AWINIC AW8697 vibrator @ 5a */
+};
+
+&i2c8 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	cs35l41_l: speaker-amp@40 {
+		compatible = "cirrus,cs35l41";
+		reg = <0x40>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <44 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&tlmm 15 GPIO_ACTIVE_HIGH>;
+		VA-supply = <&vreg_s10b_1p8>;
+		VP-supply = <&vph_pwr>;
+		cirrus,boost-peak-milliamp = <4000>;
+		cirrus,boost-ind-nanohenry = <1000>;
+		cirrus,boost-cap-microfarad = <15>;
+		cirrus,gpio2-src-select = <2>;
+		cirrus,gpio2-output-enable;
+		cirrus,asp-sdout-hiz = <3>;
+		#sound-dai-cells = <1>;
+	};
+
+	cs35l41_r: speaker-amp@42 {
+		compatible = "cirrus,cs35l41";
+		reg = <0x42>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <116 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&tlmm 15 GPIO_ACTIVE_HIGH>;
+		VA-supply = <&vreg_s10b_1p8>;
+		VP-supply = <&vph_pwr>;
+		cirrus,boost-peak-milliamp = <4000>;
+		cirrus,boost-ind-nanohenry = <1000>;
+		cirrus,boost-cap-microfarad = <15>;
+		cirrus,gpio2-src-select = <2>;
+		cirrus,gpio2-output-enable;
+		cirrus,asp-sdout-hiz = <3>;
+		#sound-dai-cells = <1>;
+	};
+};
+
+&i2c13 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	typec-mux@42 {
+		compatible = "fcs,fsa4480";
+		reg = <0x42>;
+
+		interrupts-extended = <&tlmm 2 IRQ_TYPE_LEVEL_LOW>;
+
+		vcc-supply = <&vreg_bob>;
+		mode-switch;
+		orientation-switch;
+
+		port {
+			fsa4480_sbu_mux: endpoint {
+				remote-endpoint = <&pmic_glink_sbu>;
+			};
+		};
+	};
+};
+
+&i2c15 {
+	clock-frequency = <1000000>;
+	status = "okay";
+};
+
+&ipa {
+	qcom,gsi-loader = "self";
+	memory-region = <&pil_ipa_fw_mem>;
+	firmware-name = "qcom/sm8350/xiaomi/star/ipa_fws.mbn";
+	status = "okay";
+};
+
+&mpss {
+	firmware-name = "qcom/sm8350/xiaomi/star/modem.mbn";
+	status = "okay";
+};
+
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_default_state>;
+
+	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
+
+	status = "okay";
+};
+
+&pcie0_phy {
+	vdda-phy-supply = <&vreg_l5b_0p88>;
+	vdda-pll-supply = <&vreg_l6b_1p2>;
+
+	status = "okay";
+};
+
+&pm8350_gpios {
+	gpio-line-names = "NC",
+			  "BuildID",
+			  "NC",
+			  "ProjectID",
+			  "NC",
+			  "KEY_VOLP_N",
+			  "SP_ARI_POWER_ALARM",
+			  "NC",
+			  "NC",
+			  "GND";
+
+	volume_up_n: volume-up-n-state {
+		pins = "gpio6";
+		function = "normal";
+		power-source = <1>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
+&pm8350b_gpios {
+	gpio-line-names = "WIFI_THERM",
+			  "WP_THERM",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "FORCED_USB_BOOT",
+			  "NC",
+			  "NC";
+};
+
+&pm8350c_gpios {
+	gpio-line-names = "VDD_BOOST_5V_EN",
+			  "NC",
+			  "OTG_OVP_EN",
+			  "WL_TXON",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC";
+};
+
+&pmk8350_adc_tm {
+	status = "okay";
+
+	pm8350-skin-therm@0 {
+		reg = <0>;
+		io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM1_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	pm8350-cam-flash-therm@1 {
+		reg = <1>;
+		io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM2_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	pm8350b-usb-con-therm@2 {
+		reg = <2>;
+		io-channels = <&pmk8350_vadc PM8350B_ADC7_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	pm8350-quiet-therm@3 {
+		reg = <3>;
+		io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	pmr735a-pa-therm@4 {
+		reg = <4>;
+		io-channels = <&pmk8350_vadc PMR735A_ADC7_GPIO1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	pm8350b-wl-chg-therm@5 {
+		reg = <5>;
+		io-channels = <&pmk8350_vadc PM8350B_ADC7_GPIO2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	pm8350b-wifi-therm@6 {
+		reg = <6>;
+		io-channels = <&pmk8350_vadc PM8350B_ADC7_GPIO1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+};
+
+&pmk8350_rtc {
+	nvmem-cells = <&rtc_offset>;
+	nvmem-cell-names = "offset";
+
+	status = "okay";
+};
+
+&pmk8350_sdam_2 {
+	status = "okay";
+
+	rtc_offset: rtc-offset@bc {
+		reg = <0xbc 0x4>;
+	};
+};
+
+&pmk8350_vadc {
+	channel@324 {
+		reg = <PM8350_ADC7_AMUX_THM1_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "pm8350_skin_therm";
+	};
+
+	channel@325 {
+		reg = <PM8350_ADC7_AMUX_THM2_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "pm8350_cam_flash_therm";
+	};
+
+	channel@327 {
+		reg = <PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "pm8350_quiet_therm";
+	};
+
+	channel@836 {
+		reg = <PM8350B_ADC7_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "pm8350b_usb_con_therm";
+	};
+
+	channel@842 {
+		reg = <PM8350B_ADC7_GPIO1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "pm8350b_wifi_therm";
+	};
+
+	channel@843 {
+		reg = <PM8350B_ADC7_GPIO2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "pm8350b_wl_chg_therm";
+	};
+
+	channel@1098 {
+		reg = <PMR735A_ADC7_GPIO1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "pmr735a_pa_therm";
+	};
+};
+
+&pmr735a_gpios {
+	gpio-line-names = "PA_THERM0",
+			  "PA_THERM1",
+			  "NC",
+			  "NC";
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
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
+&slpi {
+	firmware-name = "qcom/sm8350/xiaomi/star/slpi.mbn";
+	status = "okay";
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&qup_spi1_default>;
+	status = "okay";
+
+	irled@0 {
+		compatible = "ir-spi-led";
+		reg = <0>;
+		power-supply = <&vph_pwr>;
+		spi-max-frequency = <19200000>;
+	};
+};
+
+&spi11 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&qup_spi11_default>;
+	status = "okay";
+
+	/* STM FTS touchscreen */
+};
+
+&tlmm {
+	gpio-reserved-ranges = <52 8>;
+	gpio-line-names = "APPS_I2C_SDA", /* GPIO_0 */
+			  "APPS_I2C_SCL",
+			  "FSA_INT_N",
+			  "SEC_AMOLED_CVO_EN",
+			  "WLC_PMIC_I2C_SDA",
+			  "WLC_PMIC_I2C_SCL",
+			  "SBU_UART_EN",
+			  "WLC_INT_N",
+			  "NC",
+			  "INFARED_SPI_MOSI",
+			  "NC", /* GPIO_10 */
+			  "NC",
+			  "CAMW_AVDD_EN",
+			  "AMOLED_VDDI_EN",
+			  "CP_INT",
+			  "SMART_PA_0_EN",
+			  "CAM1_RESET_N",
+			  "CAM5_RESET_N",
+			  "DEBUG_UART_TX",
+			  "DEBUG_UART_RX",
+			  "TS_I2C_SDA", /* GPIO_20 */
+			  "TS_I2C_SCL",
+			  "TP_RESET_N",
+			  "TP_INT_N",
+			  "LCD_RESET_N",
+			  "WL_CP_EN_AP",
+			  "WL_DET",
+			  "CP_INT_S",
+			  "HAP_I2C_SDA",
+			  "HAP_I2C_SCL",
+			  "SEC_AMOLED_RESET_DIS", /* GPIO_30 */
+			  "SEC_AMOLED_TP_INT",
+			  "PM8008_1_IRQ",
+			  "PM8008_1_RESET_N",
+			  "CAMFD_AVDD_EN",
+			  "SEC_AMOLED_VDDI_EN",
+			  "SPKR_I2C_SDA",
+			  "SPKR_I2C_SCL",
+			  "FOD_INT_N1",
+			  "FOD_RST",
+			  "SMB_SPMI_DATA", /* GPIO_40 */
+			  "SMB_SPMI_CLK",
+			  "WLS_CHARGE_CTRL",
+			  "FORCED_USB_BOOT",
+			  "SPKR_INT",
+			  "LCD_ID_DET1",
+			  "CHARGER_UART_TX",
+			  "CHARGER_UART_RX",
+			  "TP_SPI_MISO",
+			  "TP_SPI_MOSI",
+			  "TP_SPI_CLK", /* GPIO_50 */
+			  "TP_SPI_CS",
+			  "FOD_SPI_MISO",
+			  "FOD_SPI_MOSI",
+			  "FOD_SPI_CLK",
+			  "FOD_SPI_CS",
+			  "NFC_SE_SPI_MISO",
+			  "NFC_SE_SPI_MOSI",
+			  "NFC_SE_SPI_CLK",
+			  "NFC_SE_SPI_CS",
+			  "NFC_I2C_SDA", /* GPIO_60 */
+			  "NFC_I2C_SCL",
+			  "NFC_EN",
+			  "NFC_CLK_REQ",
+			  "HST_WLAN_EN",
+			  "HST_BT_EN",
+			  "CAMU_AVDD_EN",
+			  "VBUS_NTC_CTRL",
+			  "HST_BT_UART_CTS",
+			  "HST_BT_UART_RFR",
+			  "HST_BT_UART_TX", /* GPIO_70 */
+			  "HST_BT_UART_RX",
+			  "ADSP_FG_I2C_SDA",
+			  "ADSP_FG_I2C_SCL",
+			  "DISP_RATE",
+			  "ERR_INT_N",
+			  "TOF_SPI_MISO",
+			  "TOF_SPI_MOSI",
+			  "TOF_SPI_CLK",
+			  "TOF_SPI_CS",
+			  "HALL_OUT1", /* GPIO_80 */
+			  "USB_CC_DIR",
+			  "MDP_VSYNC_P",
+			  "SEC_AMOLED_TE_DIS",
+			  "FLICKER_INT",
+			  "HALL_OUT2",
+			  "NFC_DWL_REQ",
+			  "NFC_INT_REQ",
+			  "WCD_RESET_N",
+			  "ALS_INT_N",
+			  "GPIO_BQ25970_MASTER_INT", /* GPIO_90 */
+			  "GYRO_INT",
+			  "NC",
+			  "CAMF_DVDD_EN",
+			  "PCIE0_RESET_N",
+			  "PCIE0_CLK_REQ_N",
+			  "PCIE0_WAKE_N",
+			  "RF_CABLE_INT2",
+			  "NC",
+			  "TOF_IRQ",
+			  "CAM_MCLK0", /* GPIO_100 */
+			  "CAM_MCLK1",
+			  "CAM_MCLK2",
+			  "CAM_MCLK3",
+			  "NC",
+			  "CAM_MCLK5",
+			  "CAM3_RESET_N",
+			  "CCI_I2C0_SDA",
+			  "CCI_I2C0_SCL",
+			  "CCI_I2C1_SDA",
+			  "CCI_I2C1_SCL", /* GPIO_110 */
+			  "CCI_I2C2_SDA",
+			  "CCI_I2C2_SCL",
+			  "CCI_I2C3_SDA",
+			  "CCI_I2C3_SCL",
+			  "SEC_AMOLED_TP_3P3_EN",
+			  "SPKR_PA_INT",
+			  "CAM2_RESET_N",
+			  "ACCEL_INT",
+			  "HAP_DRV_INT",
+			  "SPKR_I2S_BCK", /* GPIO_120 */
+			  "SPKR_I2S_DIN",
+			  "SPKR_I2S_WS",
+			  "GPIO_BQ25970_SLAVE_INT",
+			  "SPKR_I2S_DOUT",
+			  "SEC_AMOLED_TP_RST",
+			  "RF_CABLE_INT1",
+			  "WLS_QUCK_EN",
+			  "NC",
+			  "HST_BT_WLAN_SLIMBUS_CLK",
+			  "HST_BT_WLAN_SLIMBUS_DAT0", /* GPIO_130 */
+			  "NC",
+			  "TP_3P3_EN",
+			  "UIM2_DATA",
+			  "UIM2_CLK",
+			  "UIM2_RESET",
+			  "UIM2_PRESENT",
+			  "UIM1_DATA",
+			  "UIM1_CLK",
+			  "UIM1_RESET",
+			  "UIM1_PRESENT", /* GPIO_140 */
+			  "SM_RFFE0_CLK",
+			  "SM_RFFE0_DATA",
+			  "SM_RFFE1_CLK",
+			  "SM_RFFE1_DATA",
+			  "SM_RFFE2_CLK",
+			  "SM_RFFE2_DATA",
+			  "SM_RFFE3_CLK",
+			  "SM_RFFE3_DATA",
+			  "SM_RFFE4_CLK",
+			  "SM_RFFE4_DATA", /* GPIO_150 */
+			  "WLAN_COEX_UART1_RX",
+			  "WLAN_COEX_UART1_TX",
+			  "HST_SW_CTRL",
+			  "SEC_AMOLED_VDDI_TP_EN",
+			  "HAP_DRV_RSTN",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "QLINK0_REQ",
+			  "QLINK0_EN", /* GPIO_160 */
+			  "QLINK0_WMSS_RESET_N",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "RF_CABLE_INT3",
+			  "NC",
+			  "WCD_SWR_TX_CLK",
+			  "WCD_SWR_TX_DATA0",
+			  "WCD_SWR_TX_DATA1", /* GPIO_170 */
+			  "HAP_SWR_RX_CLK",
+			  "HAP_SWR_RX_DATA0",
+			  "WCD_SWR_RX_DATA1",
+			  "NC",
+			  "CAMW_DVDD_EN",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_180 */
+			  "NC",
+			  "WCD_SWR_TX_DATA2",
+			  "ACC_I3C_SDA",
+			  "ACC_I3C_SCL",
+			  "SSC_SENSOR_I2C1_SDA",
+			  "SSC_SENSOR_I2C1_SCL",
+			  "NC",
+			  "TCS3718_GPIO",
+			  "NC",
+			  "NC", /* GPIO_190 */
+			  "SSC_MAG_I2C_SDA",
+			  "SSC_MAG_I2C_SCL",
+			  "SSC_SENSOR_I2C_SDA",
+			  "SSC_SENSOR_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "HST_BLE_UART_TX",
+			  "HST_BLE_UART_RX", /* GPIO_200 */
+			  "HST_WLAN_UART_TX",
+			  "HST_WLAN_UART_RX";
+
+	pcie0_default_state: pcie0-default-state {
+		perst-pins {
+			pins = "gpio94";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		clkreq-pins {
+			pins = "gpio95";
+			function = "pcie0_clkreqn";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		wake-pins {
+			pins = "gpio96";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	qup_spi1_default: qup-spi1-default-state {
+		pins = "gpio8", "gpio9", "gpio10", "gpio11";
+		function = "qup1";
+		drive-strength = <6>;
+		bias-disable;
+	};
+
+	qup_spi11_default: qup-spi11-default-state {
+		pins = "gpio48", "gpio49", "gpio50", "gpio51";
+		function = "qup11";
+		drive-strength = <6>;
+		bias-disable;
+	};
+};
+
+&ufs_mem_hc {
+	reset-gpios = <&tlmm 203 GPIO_ACTIVE_LOW>;
+	vcc-supply = <&vreg_l7b_2p96>;
+	vcc-max-microamp = <800000>;
+	vccq-supply = <&vreg_l9b_1p2>;
+	vccq-max-microamp = <900000>;
+	vdd-hba-supply = <&vreg_l9b_1p2>;
+
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l5b_0p88>;
+	vdda-pll-supply = <&vreg_l6b_1p2>;
+
+	status = "okay";
+};
+
+&usb_1 {
+	/* USB 2.0 only */
+	qcom,select-utmi-as-pipe-clk;
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "otg";
+	usb-role-switch;
+	maximum-speed = "high-speed";
+	/* Remove USB3 phy */
+	phys = <&usb_1_hsphy>;
+	phy-names = "usb2-phy";
+};
+
+&usb_1_dwc3_hs {
+	remote-endpoint = <&pmic_glink_hs_in>;
+};
+
+&usb_1_hsphy {
+	vdda-pll-supply = <&vreg_l5b_0p88>;
+	vdda18-supply = <&vreg_l1c_1p8>;
+	vdda33-supply = <&vreg_l2b_3p07>;
+
+	status = "okay";
+};
\ No newline at end of file

-- 
2.42.0

