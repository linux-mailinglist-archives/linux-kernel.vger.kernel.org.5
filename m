Return-Path: <linux-kernel+bounces-42910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB082840861
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3369B1F21666
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A4C1534EC;
	Mon, 29 Jan 2024 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="GrY/GFDa"
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D64152DE8;
	Mon, 29 Jan 2024 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538757; cv=none; b=EcvgixGnIvWUarejg7XmYxGtwSiwt4SBA0h+DC4aF3eLr9XKccfZvNl1SF8DYwJsrMtIQvHzM1OX0L3dsPyo7pODw8oM4E2XRkxOKGTiC0n6+hDcdem3sEEuH7Wn5b2iduYQdOiIBL1Al97lGlztIPTKhtQS/C194Mtk3iGY2lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538757; c=relaxed/simple;
	bh=iLKirAOBFsjwMJqhIF9KvWCex4SweNAYIAJgss0M7a4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DGe/IU9vXnSeIyNwk0R2MaWQYZkzvG3kOl0l9I6YyqhnLypLF34nqtrB71aBCWh6vOiPpAUJzyV/eIKJUrcyvKnu7L1frHXC5wLuIQmMB2cmMnDsruVQOeWbxT5xWURf743DCzhlY6tYm3gM4zz+S5uhPYCxNN23ps+yHLKlMnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=GrY/GFDa; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1706538739; x=1706797939;
	bh=F+uuXyg6J0fkNKlbhNfTA8pIOgWaw2kxlqkQX5fXG3M=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GrY/GFDaQudVtWaUisxqZv02BJoDxdIiIPq8BbetgAGjg/nmgH2E2AuCoKvHXX4ne
	 GC8DM8H3FyLjXhXdCCVTmza6nBj78eUkB7vO91hITpWcQkohmO/m231XCL7e+kZENl
	 jnRkFBwuxXuiZVKEAuBEfP/3dNEDulssb3yh2lfQVPScj/70oYiJavAHDjbIBUhZcn
	 0HI20zIzb68lRdCn1Vip6diTEjnV5Zp1cBcH+OZuT69iySY4xGECkB9Y6MufPxMjAo
	 Axb4j2vn90t17Lak6GR7NkZdP9M70dS6vpnWFsOB08/gafmbBqNtFFCK+P6TYVYOj5
	 hRUM9PbgZXLNA==
Date: Mon, 29 Jan 2024 14:32:02 +0000
To: linux-kernel@vger.kernel.org
From: Raymond Hackley <raymondhackley@protonmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, Walter Broemeling <wallebroem@gmail.com>, Joe Mason <buddyjojo06@outlook.com>, Siddharth Manthan <siddharth.manthan@gmail.com>
Subject: [PATCH v4] arm64: dts: qcom: msm8916-samsung-fortuna/rossa: Add initial device trees
Message-ID: <20240129143147.5058-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Walter Broemeling <wallebroem@gmail.com>

Samsung Galaxy Core Prime and Grand Prime are phones based on MSM8916.
They are similar to the other Samsung devices based on MSM8916 with only a
few minor differences.

This initial commit adds support for:
 - fortuna3g (SM-G530H)
 - gprimeltecan (SM-G530W)
 - grandprimelte (SM-G530FZ)
 - rossa (SM-G360G)

The device trees contain initial support with:
 - GPIO keys
 - Regulator haptic
 - SDHCI (internal and external storage)
 - USB Device Mode
 - UART (on USB connector via the SM5502/SM5504 MUIC)
 - WCNSS (WiFi/BT)
 - Regulators
 - QDSP6 audio
 - Speaker/earpiece/headphones/microphones via digital/analog codec in
   MSM8916/PM8916
 - WWAN Internet via BAM-DMUX

There are different variants of Core Prime and Grand Prime, with some
differences in accelerometer, NFC and panel.
Core Prime and Grand Prime are similar, with some differences in MUIC,
panel and touchscreen.

The common parts are shared in
msm8916-samsung-fortuna-common.dtsi and msm8916-samsung-rossa-common.dtsi
to reduce duplication.

Signed-off-by: Walter Broemeling <wallebroem@gmail.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
[Joe: Add audio, buttons and WiFi]
Signed-off-by: Joe Mason <buddyjojo06@outlook.com>
[Siddharth: Add fortuna3g]
Signed-off-by: Siddharth Manthan <siddharth.manthan@gmail.com>
[Raymond: Add modem, fortuna-common.dtsi, grandprimelte and rossa]
Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
---
v4: dt-bindings have been applied, skip.
    Fix missing msm8216-samsung-fortuna3g.dts
    Enable &venus, &venus_mem and &wcnss_mem. Add comments for &mpss_mem.
v3: Drop fortunaltezt and heatqlte. Add sound and modem.
    /delete-node/ &muic; in rossa-common.dtsi
v2: Use interrupt-extended. Drop fuelgauge, sensors and NFC for now.
---
 arch/arm64/boot/dts/qcom/Makefile             |   4 +
 .../dts/qcom/msm8216-samsung-fortuna3g.dts    |  11 ++
 .../qcom/msm8916-samsung-fortuna-common.dtsi  | 182 ++++++++++++++++++
 .../dts/qcom/msm8916-samsung-gprimeltecan.dts |  27 +++
 .../qcom/msm8916-samsung-grandprimelte.dts    |  16 ++
 .../qcom/msm8916-samsung-rossa-common.dtsi    |  16 ++
 .../boot/dts/qcom/msm8916-samsung-rossa.dts   |  16 ++
 7 files changed, 272 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common=
dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-gprimeltecan.d=
ts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-grandprimelte.=
dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.d=
tsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-rossa.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/M=
akefile
index b5f88b3d6793..239ea867f0f5 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -24,6 +24,7 @@ dtb-$(CONFIG_ARCH_QCOM)=09+=3D ipq9574-rdp433.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D ipq9574-rdp449.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D ipq9574-rdp453.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D ipq9574-rdp454.dtb
+dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8216-samsung-fortuna3g.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-acer-a1-724.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-alcatel-idol347.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-asus-z00l.dtb
@@ -36,11 +37,14 @@ dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-a3u-eur.=
dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-a5u-eur.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-e5.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-e7.dtb
+dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-gprimeltecan.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-grandmax.dtb
+dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-grandprimelte.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-gt510.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-gt58.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-j5.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-j5x.dtb
+dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-rossa.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-samsung-serranove.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-thwc-uf896.dtb
 dtb-$(CONFIG_ARCH_QCOM)=09+=3D msm8916-thwc-ufi001c.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts b/arch/=
arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts
new file mode 100644
index 000000000000..366914be7d53
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-samsung-fortuna-common.dtsi"
+
+/ {
+=09model =3D "Samsung Galaxy Grand Prime (SM-G530H)";
+=09compatible =3D "samsung,fortuna3g", "qcom,msm8916";
+=09chassis-type =3D "handset";
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi b=
/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
new file mode 100644
index 000000000000..052024073f54
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "msm8916-pm8916.dtsi"
+#include "msm8916-modem-qdsp6.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+=09aliases {
+=09=09mmc0 =3D &sdhc_1; /* eMMC */
+=09=09mmc1 =3D &sdhc_2; /* SD card */
+=09=09serial0 =3D &blsp_uart2;
+=09};
+
+=09chosen {
+=09=09stdout-path =3D "serial0";
+=09};
+
+=09reserved-memory {
+=09=09/* Additional memory used by Samsung firmware modifications */
+=09=09tz-apps@85a00000 {
+=09=09=09reg =3D <0x0 0x85a00000 0x0 0x600000>;
+=09=09=09no-map;
+=09=09};
+=09};
+
+=09gpio-keys {
+=09=09compatible =3D "gpio-keys";
+
+=09=09pinctrl-0 =3D <&gpio_keys_default>;
+=09=09pinctrl-names =3D "default";
+
+=09=09label =3D "GPIO Buttons";
+
+=09=09button-volume-up {
+=09=09=09label =3D "Volume Up";
+=09=09=09gpios =3D <&tlmm 107 GPIO_ACTIVE_LOW>;
+=09=09=09linux,code =3D <KEY_VOLUMEUP>;
+=09=09};
+
+=09=09button-home {
+=09=09=09label =3D "Home";
+=09=09=09gpios =3D <&tlmm 109 GPIO_ACTIVE_LOW>;
+=09=09=09linux,code =3D <KEY_HOMEPAGE>;
+=09=09};
+=09};
+
+=09haptic {
+=09=09compatible =3D "regulator-haptic";
+=09=09haptic-supply =3D <&reg_motor_vdd>;
+=09=09min-microvolt =3D <3300000>;
+=09=09max-microvolt =3D <3300000>;
+=09};
+
+=09reg_motor_vdd: regulator-motor-vdd {
+=09=09compatible =3D "regulator-fixed";
+=09=09regulator-name =3D "motor_vdd";
+=09=09regulator-min-microvolt =3D <3300000>;
+=09=09regulator-max-microvolt =3D <3300000>;
+
+=09=09gpio =3D <&tlmm 72 GPIO_ACTIVE_HIGH>;
+=09=09enable-active-high;
+
+=09=09pinctrl-0 =3D <&motor_en_default>;
+=09=09pinctrl-names =3D "default";
+=09};
+};
+
+&blsp_i2c1 {
+=09status =3D "okay";
+
+=09muic: extcon@25 {
+=09=09compatible =3D "siliconmitus,sm5502-muic";
+=09=09reg =3D <0x25>;
+=09=09interrupts-extended =3D <&tlmm 12 IRQ_TYPE_EDGE_FALLING>;
+=09=09pinctrl-0 =3D <&muic_int_default>;
+=09=09pinctrl-names =3D "default";
+=09};
+};
+
+&blsp_uart2 {
+=09status =3D "okay";
+};
+
+&mpss_mem {
+=09reg =3D <0x0 0x86800000 0x0 0x5000000>;
+};
+
+&pm8916_resin {
+=09linux,code =3D <KEY_VOLUMEDOWN>;
+=09status =3D "okay";
+};
+
+&pm8916_rpm_regulators {
+=09pm8916_l17: l17 {
+=09=09regulator-min-microvolt =3D <2850000>;
+=09=09regulator-max-microvolt =3D <2850000>;
+=09};
+};
+
+&sdhc_1 {
+=09status =3D "okay";
+};
+
+&sdhc_2 {
+=09pinctrl-0 =3D <&sdc2_default &sdc2_cd_default>;
+=09pinctrl-1 =3D <&sdc2_sleep &sdc2_cd_default>;
+=09pinctrl-names =3D "default", "sleep";
+
+=09cd-gpios =3D <&tlmm 38 GPIO_ACTIVE_LOW>;
+
+=09status =3D "okay";
+};
+
+&sound {
+=09model =3D "msm8916-1mic";
+=09audio-routing =3D
+=09=09"AMIC1", "MIC BIAS External1",
+=09=09"AMIC2", "MIC BIAS Internal2",
+=09=09"AMIC3", "MIC BIAS External1";
+};
+
+&usb {
+=09extcon =3D <&muic>, <&muic>;
+=09status =3D "okay";
+};
+
+&usb_hs_phy {
+=09extcon =3D <&muic>;
+};
+
+&venus {
+=09status =3D "okay";
+};
+
+&venus_mem {
+=09status =3D "okay";
+};
+
+&wcnss {
+=09status =3D "okay";
+};
+
+&wcnss_iris {
+=09compatible =3D "qcom,wcn3620";
+};
+
+&wcnss_mem {
+=09status =3D "okay";
+};
+
+&tlmm {
+=09gpio_keys_default: gpio-keys-default-state {
+=09=09pins =3D "gpio107", "gpio109";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-pull-up;
+=09};
+
+=09motor_en_default: motor-en-default-state {
+=09=09pins =3D "gpio72";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09muic_int_default: muic-int-default-state {
+=09=09pins =3D "gpio12";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09sdc2_cd_default: sdc2-cd-default-state {
+=09=09pins =3D "gpio38";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gprimeltecan.dts b/ar=
ch/arm64/boot/dts/qcom/msm8916-samsung-gprimeltecan.dts
new file mode 100644
index 000000000000..9d65fa58ba92
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gprimeltecan.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-samsung-fortuna-common.dtsi"
+
+/ {
+=09model =3D "Samsung Galaxy Grand Prime (SM-G530W)";
+=09compatible =3D "samsung,gprimeltecan", "qcom,msm8916";
+=09chassis-type =3D "handset";
+
+=09reserved-memory {
+=09=09/* Firmware for gprimeltecan needs more space */
+=09=09/delete-node/ tz-apps@85a00000;
+
+=09=09/* Additional memory used by Samsung firmware modifications */
+=09=09tz-apps@85500000 {
+=09=09=09reg =3D <0x0 0x85500000 0x0 0xb00000>;
+=09=09=09no-map;
+=09=09};
+=09};
+};
+
+&mpss_mem {
+=09/* Firmware for gprimeltecan needs more space */
+=09reg =3D <0x0 0x86800000 0x0 0x5400000>;
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandprimelte.dts b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-grandprimelte.dts
new file mode 100644
index 000000000000..a66ce4b13547
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-grandprimelte.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-samsung-fortuna-common.dtsi"
+
+/ {
+=09model =3D "Samsung Galaxy Grand Prime (SM-G530FZ)";
+=09compatible =3D "samsung,grandprimelte", "qcom,msm8916";
+=09chassis-type =3D "handset";
+};
+
+&mpss_mem {
+=09/* Firmware for grandprimelte needs more space */
+=09reg =3D <0x0 0x86800000 0x0 0x5400000>;
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi
new file mode 100644
index 000000000000..42843771ae2a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "msm8916-samsung-fortuna-common.dtsi"
+
+/* SM5504 MUIC instead of SM5502 */
+/delete-node/ &muic;
+
+&blsp_i2c1 {
+=09muic: extcon@14 {
+=09=09compatible =3D "siliconmitus,sm5504-muic";
+=09=09reg =3D <0x14>;
+=09=09interrupts-extended =3D <&tlmm 12 IRQ_TYPE_EDGE_FALLING>;
+=09=09pinctrl-0 =3D <&muic_int_default>;
+=09=09pinctrl-names =3D "default";
+=09};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa.dts b/arch/arm6=
4/boot/dts/qcom/msm8916-samsung-rossa.dts
new file mode 100644
index 000000000000..ebaa13c6b016
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-samsung-rossa-common.dtsi"
+
+/ {
+=09model =3D "Samsung Galaxy Core Prime LTE";
+=09compatible =3D "samsung,rossa", "qcom,msm8916";
+=09chassis-type =3D "handset";
+};
+
+&mpss_mem {
+=09/* Firmware for rossa needs more space */
+=09reg =3D <0x0 0x86800000 0x0 0x5800000>;
+};
--=20
2.39.2



