Return-Path: <linux-kernel+bounces-61612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A2C851449
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3428B20F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5073A1D3;
	Mon, 12 Feb 2024 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NCFYkqm1"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B223C499
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743440; cv=none; b=eg+/k8abvx0+1cN+Cjoxf5cbvdC/ojttigxtEMu7bnNVJe2JT7RsfSaNGvaQCb/jh//jekc7diw6vnLa/+/kMrapsr+qW7GdpOzrmaWCl4sVzSKbQILDsAfUF/hew+ks4419c3cepEuaZxgsQDT9rLXCBca+G8I8uT7fWwvAlqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743440; c=relaxed/simple;
	bh=RKTKSpnq7umb+4fU+UBs7880UjfiZvFKMpd6xVM+qMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hKheykwJ0mz/gtYhXOiotK0bVGT6PbPBhmD/9wfpiHpopX5mBhIHseLWcLD+j0xRzLkD/MXQD1r9RuuiwyMXvjz+rSxJ8vItRNJA3DOGHY5tJFFnc2a5xt33bBaOOffB7EiSk2NNeE7y9Cr8QX6YbYIZtS8WSCSefB3SrOgYC3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NCFYkqm1; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so4124803a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707743435; x=1708348235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEpC85HaJHjps7u9qXX2iFK9E/1tRVU1sKPhZz4k634=;
        b=NCFYkqm1LOXZPEurpteyyqVfyEkwqjX8RrnPA85DHzCDAlCOOFxwaRw0HQEeGy2Q9K
         6l2u5uZzVMZO9BhYepNWIrCr8OsqhrrdfpqbO6QM+mLG224jnlUPxh84vN1vmfY4pxNs
         vLHLJTY7r4xzvPOnWCjClc+ZAOF9cRhxZHyv5zEAcNwyu81/290sxILR3jKn+l7g+1us
         iKHx7ozQ3quUmmM27zzLyWnd2CiQd2DMfBIczQB7eEjep0+xhqQTpeFGJ1XIzKteptZW
         cS24fkgQKvtohtoS6R07gxmCFM/Cu0m2tKcm3ukYOW2nO0xhFGxpxKDlH69BwT5naLe6
         QP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707743435; x=1708348235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEpC85HaJHjps7u9qXX2iFK9E/1tRVU1sKPhZz4k634=;
        b=CATXrReq3t+9PhAwAtnDMyN1OhuwW88z/56bytYyY0zVVnyZpAM/c8vAtjXrDjuR49
         KnQJwYqy7iL1oLeTBOG3HgvSCcGVTdtCjEkHRtPZiW1hmBgXpM+HqJeZJmTrzMGVagdz
         UIxkLmUuRacDS4ZEgJozfJ9TR+031WYGqinrrLW+YytqAmhzpyoGJzG4nYqCxPaA2o2q
         fmjwr5poAz0fz/Wxgxs68RTL+CZC4+sRJM3lVtk0kOSQZ64zVQ/5nouCN7RMJLikS8hP
         BXDhHO/HG2iAgp16nK4GegsEnMy0qIkzW2+K8gCSUK6wiITceGwHCDmvIXztpwljo1Wz
         I/IQ==
X-Gm-Message-State: AOJu0YynGJXQWVg+W5bcHI4LtMpqp4rL04Yex0q5Qp+QSjmN6Ng/+8qu
	I2tJfA6V4DFRPOfFFQaLaxphLfUuzWoFK/GH3cNSGUJ2Qj0MeR59YnwY5xyCR60=
X-Google-Smtp-Source: AGHT+IEsaTnMH3oMopizAu6CA7GTle7EL46mSKQT1n2c9WcXwr+zfYdrr0YLFuqMIk6UdOLR8yEK2g==
X-Received: by 2002:a17:906:1c4b:b0:a3c:4f51:19a0 with SMTP id l11-20020a1709061c4b00b00a3c4f5119a0mr3614232ejg.56.1707743435149;
        Mon, 12 Feb 2024 05:10:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqrWAWAd9uPdRq5fWKunrlfWqNYL+rJxz71Mpoh6I4C5Ikh9KVFj2Xm2+iPt1WdZDdYE2BrnuW89FEPxx+xefGPLqI0y62UWmf4t36llu0u2VV7BzsLjQXET2N+K8avKHzuYLNEyLTG7N8s4wwvcy5oa2KVpPKq9I2vezqdT3QvAJOcdZGr0Se21yW0QolfB6R7dd90ofNX/AdaTrSIY2MtAqlQJQXOlsU4bC4Nrd/TKTtupROWb1Tgn1SvUg5poJ1JnP+0MfSlo8OTA4iq7eLXl9xKXPsTEmIQwvpEXIuJOEyu29zpEEcs17EAYbw9p77AWZesDKiYtaU2DOleSIdJcPqJ/Iboex3yPwU3JFgWJQr+Nq7H67uUc22MAbJ3s+L9xAvMWf0pFEv6tDSRtwimzEiL9OQmRq5sTs0l7nEoaLysw9Dbg5tXAmEiyoL8TpfmvUpYpDDdJtJ0v0K9pPDPsEAFOkwo4JEshgE4r2MC6KkgWC00+maGZMRt6tk4ua10vL870BZwZ204MAln9j1VKRLhE8hQoTNE1b+iXO5E0pxX17z934EBTbJhFTXA7/MgRaW6rOhHlH2nLt3kHVccdVQ+gBmZf5sXdcyg5jOyboYKe/CVUMdoQs+Y4QLhmYKMai0PUmZHPfeVo11lhyQBjzjRt+P1O82lz8wTlCx2AfGJjZRh2OUwk79sroP4yCV+EnZI9a2CGat2ttbXDudsQn+EI18kEbOjREgj49piz+eQZUT2LqNkr/e87vql6dbu/BtaE3SYB98e1rQyHnM6C/IVW/CUxC9lL1zEM9Zv3n06hZxCYzwsVWEwIA3m6pC2Y2Zoz/x1sFZtKhjMKUPR8ZW
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id gz9-20020a170906f2c900b00a3515b35be4sm193052ejb.104.2024.02.12.05.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 05:10:34 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 12 Feb 2024 14:10:15 +0100
Subject: [PATCH 7/7] arm64: dts: qcom: Add SM8550 Xperia 1 V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-topic-1v-v1-7-fda0db38e29b@linaro.org>
References: <20240210-topic-1v-v1-0-fda0db38e29b@linaro.org>
In-Reply-To: <20240210-topic-1v-v1-0-fda0db38e29b@linaro.org>
To: James Schulman <james.schulman@cirrus.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>, 
 Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707743413; l=21987;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=RKTKSpnq7umb+4fU+UBs7880UjfiZvFKMpd6xVM+qMs=;
 b=n80aZUcqcoyBgIg9eJD2vDXcrnfKyj/yR9bB4HnAHKOhFsfFsPkmtlMJOKVILVrZPktBymQCi
 603ICmpAMWZBWkX0yVjbR257zY4oXTCmAw28KK12CeFhyI+tBycQjpo
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add support for Sony Xperia 1 V, a.k.a PDX234. This device is a part
of the SoMC SM8550 Yodo platform.

This commit brings support for:
* Remoteprocs (sans modem for now)
* Flash LED (the notification LED is gone :((((()
* SD Card
* USB (*including SuperSpeed*) + PMIC_GLINK (it's funky, requires a replug
  with an cable flip sometimes..)
* Most regulators
* Part of I2C-connected peripherals (notably no touch due to a
driver bug)
* PCIe0 (PCIe1 is unused)

Do note display via simplefb is not supported, as the display is blanked
upon exiting XBL.

To create a working boot image, you need to run:
cat arch/arm64/boot/Image.gz arch/arm64/boot/dts/qcom/sm8550-sony-xperia-\
yodo-pdx234.dtb > .Image.gz-dtb

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
--header_version 2 \
-o boot.img-sony-xperia-pdx234

Then, you need to flash it on the device and get rid of all the
vendor_boot/dtbo mess:

// You have to either pull vbmeta{"","_system"} from
// /dev/block/bootdevice/by-name/ or build one as a part of AOSP build process
fastboot --disable-verity --disable-verification flash vbmeta vbmeta.img
fastboot --disable-verity --disable-verification flash vbmeta_system \
vbmeta_system.img

fastboot flash boot boot.img-sony-xperia-pdx234
fastboot erase vendor_boot
fastboot erase recovery
fastboot flash dtbo emptydtbo.img
fastboot erase init_boot // ? I don't remember if it's necessary, sorry
fastboot continue

Where emptydtbo.img is a tiny file that consists of 2 bytes (all zeroes), doing
a "fastboot erase" won't cut it, the bootloader will go crazy and things will
fall apart when it tries to overlay random bytes from an empty partition onto a
perfectly good appended DTB.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 .../dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts    | 779 +++++++++++++++++++++
 2 files changed, 780 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index f7c5662213e4..9bbea531660d 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -237,6 +237,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx224.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-qrd.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-sony-xperia-yodo-pdx234.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-qrd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-crd.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts b/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
new file mode 100644
index 000000000000..85e0d3d66e16
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
@@ -0,0 +1,779 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/firmware/qcom,scm.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/sound/cs35l45.h>
+#include "sm8550.dtsi"
+#include "pm8010.dtsi"
+#include "pm8550.dtsi"
+#include "pm8550b.dtsi"
+#define PMK8550VE_SID 5
+#include "pm8550ve.dtsi"
+#include "pm8550vs.dtsi"
+#include "pmk8550.dtsi"
+/* TODO: Only one SID of PMR735D seems accessible? */
+
+/delete-node/ &hwfence_shbuf;
+/delete-node/ &mpss_mem;
+/delete-node/ &rmtfs_mem;
+/ {
+	model = "Sony Xperia 1 V";
+	compatible = "sony,pdx234", "qcom,sm8550";
+	chassis-type = "handset";
+
+	aliases {
+		i2c0 = &i2c0;
+		i2c4 = &i2c4;
+		i2c10 = &i2c10;
+		i2c11 = &i2c11;
+		i2c16 = &i2c_hub_2;
+		serial0 = &uart7;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		label = "gpio-keys";
+
+		pinctrl-0 = <&focus_n &snapshot_n &vol_down_n>;
+		pinctrl-names = "default";
+
+		key-camera-focus {
+			label = "Camera Focus";
+			linux,code = <KEY_CAMERA_FOCUS>;
+			gpios = <&pm8550b_gpios 8 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+
+		key-camera-snapshot {
+			label = "Camera Snapshot";
+			gpios = <&pm8550b_gpios 7 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_CAMERA>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+
+		key-volume-down {
+			label = "Volume Down";
+			linux,code = <KEY_VOLUMEDOWN>;
+			gpios = <&pm8550_gpios 6 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+	};
+
+	pmic-glink {
+		compatible = "qcom,sm8550-pmic-glink", "qcom,pmic-glink";
+		orientation-gpios = <&tlmm 11 GPIO_ACTIVE_HIGH>;
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
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_ss_in: endpoint {
+						remote-endpoint = <&usb_dp_qmpphy_out>;
+					};
+				};
+			};
+		};
+	};
+
+	reserved-memory {
+		mpss_mem: mpss-region@89800000 {
+			reg = <0x0 0x89800000 0x0 0x10800000>;
+			no-map;
+		};
+
+		splash@b8000000 {
+			reg = <0x0 0xb8000000 0x0 0x2b00000>;
+			no-map;
+		};
+
+		hwfence_shbuf: hwfence-shbuf-region@e6440000 {
+			reg = <0x0 0xe6440000 0x0 0x2dd000>;
+			no-map;
+		};
+
+		rmtfs_mem: memory@f8b00000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0 0xf8b00000 0x0 0x280000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
+		};
+
+		ramoops@ffd00000 {
+			compatible = "ramoops";
+			reg = <0x0 0xffd00000 0x0 0xc0000>;
+			console-size = <0x40000>;
+			record-size = <0x1000>;
+			pmsg-size = <0x40000>;
+			ecc-size = <16>;
+		};
+
+		rdtag-store-region@ffdc0000 {
+			reg = <0x0 0xffdc0000 0x0 0x40000>;
+			no-map;
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
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pm8550-rpmh-regulators";
+		qcom,pmic-id = "b";
+
+		pm8550_bob1: bob1 {
+			regulator-name = "pm8550_bob1";
+			regulator-min-microvolt = <3416000>;
+			regulator-max-microvolt = <3960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		/* TODO: bob2 @ 2.704-3.008V doesn't fall into the vreg driver constraints */
+
+		pm8550_l1: ldo1 {
+			regulator-name = "pm8550_l1";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550_l2: ldo2 {
+			regulator-name = "pm8550_l2";
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		/* L4 exists in cmd-db, but the board seems to crash on access */
+
+		pm8550_l5: ldo5 {
+			regulator-name = "pm8550_l5";
+			regulator-min-microvolt = <3104000>;
+			regulator-max-microvolt = <3104000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550_l6: ldo6 {
+			regulator-name = "pm8550_l6";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550_l7: ldo7 {
+			regulator-name = "pm8550_l7";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550_l8: ldo8 {
+			regulator-name = "pm8550_l8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550_l9: ldo9 {
+			regulator-name = "pm8550_l9";
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550_l10: ldo10 {
+			regulator-name = "pm8550_l10";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550_l11: ldo11 {
+			regulator-name = "pm8550_l11";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1504000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550_l12: ldo12 {
+			regulator-name = "pm8550_l12";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550_l13: ldo13 {
+			regulator-name = "pm8550_l13";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550_l14: ldo14 {
+			regulator-name = "pm8550_l14";
+			regulator-min-microvolt = <3304000>;
+			regulator-max-microvolt = <3304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550_l15: ldo15 {
+			regulator-name = "pm8550_l15";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550_l16: ldo16 {
+			regulator-name = "pm8550_l16";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550_l17: ldo17 {
+			regulator-name = "pm8550_l17";
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2504000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pm8550vs-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		pm8550vs_0_l1: ldo1 {
+			regulator-name = "pm8550vs_0_l1";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550vs_0_l3: ldo3 {
+			regulator-name = "pm8550vs_0_l3";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-2 {
+		compatible = "qcom,pm8550vs-rpmh-regulators";
+		qcom,pmic-id = "d";
+
+		pm8550vs_1_l1: ldo1 {
+			regulator-name = "pm8550vs_1_l1";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		/* L3 exists in cmd-db, but the board seems to crash on access */
+	};
+
+	regulators-3 {
+		compatible = "qcom,pm8550vs-rpmh-regulators";
+		qcom,pmic-id = "e";
+
+		pm8550vs_2_s4: smps4 {
+			regulator-name = "pm8550vs_2_s4";
+			regulator-min-microvolt = <904000>;
+			regulator-max-microvolt = <984000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550vs_2_s5: smps5 {
+			regulator-name = "pm8550vs_2_s5";
+			regulator-min-microvolt = <1010000>;
+			regulator-max-microvolt = <1120000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550vs_2_l1: ldo1 {
+			regulator-name = "pm8550vs_2_l1";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550vs_2_l2: ldo2 {
+			regulator-name = "pm8550vs_2_l2";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <968000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550vs_2_l3: ldo3 {
+			regulator-name = "pm8550vs_2_l3";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-4 {
+		compatible = "qcom,pm8550ve-rpmh-regulators";
+		qcom,pmic-id = "f";
+
+		pm8550ve_s4: smps4 {
+			regulator-name = "pm8550ve_s4";
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <700000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550ve_l1: ldo1 {
+			regulator-name = "pm8550ve_l1";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550ve_l2: ldo2 {
+			regulator-name = "pm8550ve_l2";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550ve_l3: ldo3 {
+			regulator-name = "pm8550ve_l3";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-5 {
+		compatible = "qcom,pm8550vs-rpmh-regulators";
+		qcom,pmic-id = "g";
+
+		pm8550vs_3_s1: smps1 {
+			regulator-name = "pm8550vs_3_s1";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550vs_3_s2: smps2 {
+			regulator-name = "pm8550vs_3_s2";
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1036000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550vs_3_s3: smps3 {
+			regulator-name = "pm8550vs_3_s3";
+			regulator-min-microvolt = <300000>;
+			regulator-max-microvolt = <1004000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550vs_3_s4: smps4 {
+			regulator-name = "pm8550vs_3_s4";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1352000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550vs_3_s5: smps5 {
+			regulator-name = "pm8550vs_3_s5";
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <1004000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550vs_3_s6: smps6 {
+			regulator-name = "pm8550vs_3_s6";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550vs_3_l1: ldo1 {
+			regulator-name = "pm8550vs_3_l1";
+			regulator-min-microvolt = <1144000>;
+			regulator-max-microvolt = <1256000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550vs_3_l2: ldo2 {
+			regulator-name = "pm8550vs_3_l2";
+			regulator-min-microvolt = <1104000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		pm8550vs_3_l3: ldo3 {
+			regulator-name = "pm8550vs_3_l3";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	/* TODO: Unknown PMIC @ k, l, PM8010 @ m, n */
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
+&i2c_hub_2 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	pmic@75 {
+		compatible = "dlg,slg51000";
+		reg = <0x75>;
+		dlg,cs-gpios = <&pm8550vs_g_gpios 4 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-0 = <&cam_pwr_a_cs>;
+		pinctrl-names = "default";
+
+		regulators {
+			slg51000_a_ldo1: ldo1 {
+				regulator-name = "slg51000_a_ldo1";
+				regulator-min-microvolt = <2400000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			slg51000_a_ldo2: ldo2 {
+				regulator-name = "slg51000_a_ldo2";
+				regulator-min-microvolt = <2400000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			slg51000_a_ldo3: ldo3 {
+				regulator-name = "slg51000_a_ldo3";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+			};
+
+			slg51000_a_ldo4: ldo4 {
+				regulator-name = "slg51000_a_ldo4";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+			};
+
+			slg51000_a_ldo5: ldo5 {
+				regulator-name = "slg51000_a_ldo5";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1200000>;
+			};
+
+			slg51000_a_ldo6: ldo6 {
+				regulator-name = "slg51000_a_ldo6";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1200000>;
+			};
+
+			slg51000_a_ldo7: ldo7 {
+				regulator-name = "slg51000_a_ldo7";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+			};
+		};
+	};
+};
+
+&i2c_master_hub_0 {
+	status = "okay";
+};
+
+&i2c0 {
+	clock-frequency = <1000000>;
+	status = "okay";
+
+	/* NXP NFC @ 28 */
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/* LX Semi SW82907 touchscreen @ 28 */
+};
+
+&i2c10 {
+	clock-frequency = <1000000>;
+	status = "okay";
+
+	/* Cirrus Logic CS40L25A boosted haptics driver @ 40 */
+};
+
+&i2c11 {
+	clock-frequency = <1000000>;
+	status = "okay";
+
+	cs35l41_l: speaker-amp@30 {
+		compatible = "cirrus,cs35l45";
+		reg = <0x30>;
+		interrupts-extended = <&tlmm 182 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&tlmm 183 GPIO_ACTIVE_HIGH>;
+		cirrus,asp-sdout-hiz-ctrl = <(CS35L45_ASP_TX_HIZ_UNUSED | CS35L45_ASP_TX_HIZ_DISABLED)>;
+		#sound-dai-cells = <1>;
+
+		cirrus,gpio-ctrl2 {
+			gpio-ctrl = <0x2>;
+		};
+	};
+
+	cs35l41_r: speaker-amp@31 {
+		compatible = "cirrus,cs35l45";
+		reg = <0x31>;
+		interrupts-extended = <&tlmm 182 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&tlmm 183 GPIO_ACTIVE_HIGH>;
+		cirrus,asp-sdout-hiz-ctrl = <(CS35L45_ASP_TX_HIZ_UNUSED | CS35L45_ASP_TX_HIZ_DISABLED)>;
+		#sound-dai-cells = <1>;
+
+		cirrus,gpio-ctrl2 {
+			gpio-ctrl = <0x2>;
+		};
+	};
+};
+
+&pcie0 {
+	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
+	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
+
+	pinctrl-0 = <&pcie0_default_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie0_phy {
+	vdda-phy-supply = <&pm8550vs_2_l1>;
+	vdda-pll-supply = <&pm8550vs_2_l3>;
+
+	status = "okay";
+};
+
+&pm8550_flash {
+	status = "okay";
+
+	led-0 {
+		function = LED_FUNCTION_FLASH;
+		color = <LED_COLOR_ID_WHITE>;
+		led-sources = <1>, <4>;
+		led-max-microamp = <500000>;
+		flash-max-microamp = <1000000>;
+		flash-max-timeout-us = <1280000>;
+		function-enumerator = <0>;
+	};
+
+	led-1 {
+		function = LED_FUNCTION_FLASH;
+		color = <LED_COLOR_ID_YELLOW>;
+		led-sources = <2>, <3>;
+		led-max-microamp = <500000>;
+		flash-max-microamp = <1000000>;
+		flash-max-timeout-us = <1280000>;
+		function-enumerator = <1>;
+	};
+};
+
+&pm8550_gpios {
+	vol_down_n: volume-down-n-state {
+		pins = "gpio6";
+		function = "normal";
+		power-source = <1>;
+		bias-pull-up;
+		input-enable;
+	};
+
+	sdc2_card_det_n: sd-card-det-n-state {
+		pins = "gpio12";
+		function = "normal";
+		power-source = <1>;
+		bias-pull-down;
+		output-disable;
+		input-enable;
+	};
+};
+
+&pm8550b_gpios {
+	snapshot_n: snapshot-n-state {
+		pins = "gpio7";
+		function = "normal";
+		power-source = <1>;
+		bias-pull-up;
+		input-enable;
+	};
+
+	focus_n: focus-n-state {
+		pins = "gpio8";
+		function = "normal";
+		power-source = <1>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
+&pm8550vs_g_gpios {
+	cam_pwr_a_cs: cam-pwr-a-cs-state {
+		pins = "gpio4";
+		function = "normal";
+		power-source = <0x01>;
+		drive-push-pull;
+		output-low;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
+	};
+};
+
+&pm8550b_eusb2_repeater {
+	qcom,tune-usb2-disc-thres = /bits/ 8 <0x6>;
+	qcom,tune-usb2-amplitude = /bits/ 8 <0xf>;
+	qcom,tune-usb2-preem = /bits/ 8 <0x7>;
+	vdd18-supply = <&pm8550_l15>;
+	vdd3-supply = <&pm8550_l5>;
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
+	firmware-name = "qcom/sm8550/Sony/yodo/adsp.mbn",
+			"qcom/sm8550/Sony/yodo/adsp_dtb.mbn";
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/sm8550/Sony/yodo/cdsp.mbn",
+			"qcom/sm8550/Sony/yodo/cdsp_dtb.mbn";
+	status = "okay";
+};
+
+&sdhc_2 {
+	cd-gpios = <&pm8550_gpios 12 GPIO_ACTIVE_HIGH>;
+	pinctrl-0 = <&sdc2_default &sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_card_det_n>;
+	pinctrl-names = "default", "sleep";
+	vmmc-supply = <&pm8550_l9>;
+	vqmmc-supply = <&pm8550_l8>;
+	no-sdio;
+	no-mmc;
+	status = "okay";
+};
+
+&sleep_clk {
+	clock-frequency = <32000>;
+};
+
+&tlmm {
+	gpio-reserved-ranges = <32 8>;
+};
+
+&uart7 {
+	status = "okay";
+};
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "otg";
+	usb-role-switch;
+};
+
+&usb_1_dwc3_hs {
+	remote-endpoint = <&pmic_glink_hs_in>;
+};
+
+&usb_1_dwc3_ss {
+	remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
+};
+
+&usb_1_hsphy {
+	vdd-supply = <&pm8550vs_2_l1>;
+	vdda12-supply = <&pm8550vs_2_l3>;
+	phys = <&pm8550b_eusb2_repeater>;
+
+	status = "okay";
+};
+
+&usb_dp_qmpphy {
+	vdda-phy-supply = <&pm8550vs_2_l3>;
+	vdda-pll-supply = <&pm8550ve_l3>;
+	orientation-switch;
+
+	status = "okay";
+};
+
+&usb_dp_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss_in>;
+};
+
+&usb_dp_qmpphy_usb_ss_in {
+	remote-endpoint = <&usb_1_dwc3_ss>;
+};
+
+&xo_board {
+	clock-frequency = <76800000>;
+};

-- 
2.43.1


