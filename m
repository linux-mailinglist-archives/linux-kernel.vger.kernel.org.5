Return-Path: <linux-kernel+bounces-27388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE4082EF27
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48C91B23018
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D581BC3A;
	Tue, 16 Jan 2024 12:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="l9NCEZeI"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F58E1BC23;
	Tue, 16 Jan 2024 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705408985; x=1706013785; i=spasswolf@web.de;
	bh=xR+AbpSYK5Ush+oOyZXSsKwb6UQMHRLzqbKcH282vXo=;
	h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
	b=l9NCEZeI8gB188L3UygaYcWgCQHhtx+uIDdNLxwW2SmZdl9PCsX5nvWSgwpm9Wq6
	 CxIEfHWIm8s3P3/03FY22TKebnxIS+blwH3RWHipzWftVToa1N/mpFZ341OJ+/lmT
	 Pt2iLMbGn0/1xyrb+G37ovVDNbBPBhW5tpwZ+ubdh/nzHJm0wJ0b1xvGTnQUAMMm6
	 RQ0g0XlvOTUgkBdIrfTbUet6dX+shbh131HPWPSp7xMZMPXoU9zXRolZKY+SFncW9
	 woR+MifFggo2Uxyx8S7fK8wUaQtHOjRssty2uZ4HXlBS/2ZhFkVwxtbk/kax0iSJI
	 VYTcW2UrBUiXEUf2KA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSIJ0-1rabnl0odk-00SpYr; Tue, 16
 Jan 2024 13:43:05 +0100
Message-ID: <fd8bbe7d391921bf05178a2ff01f1ba8a759aaca.camel@web.de>
Subject: drivers: irqchip: irq-qcom-mpm: rpm IRQ does not trigger when
 resuming on msm8953 soc
From: Bert Karwatzki <spasswolf@web.de>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Konrad
 Dybcio <konrad.dybcio@linaro.org>, spasswolf@web.de
Date: Tue, 16 Jan 2024 13:43:04 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6GvQl2vga+3kojtadg4w3EfE2JqG/iHGk/xZjlZmfIfTUYLvgij
 Q7wWwTqYFJ8R0mVEQQtcfwnCqIFEun3FE/jyOI+7zUlo7dAriSrAK2Wrhbf/qnqn8S01n8A
 pdgkC0Dt+h425aoryJPLgsWrmcUkrhuyXur6ghOidJ8vIHXeC2UpKaxD0+HpfLL/9Q/W9QC
 PVgC/3rbjZxWeXaOmbY6g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0PHpyzFrv88=;mqLFc6xUR7/MgWiTLVWkTnEjuqj
 VXiwDIRjMSByHW3m5NzcojF6Y2p/LU8MtnxANm6s3aZ3tZenNhXpADP1R3KSaLskEyNlistIt
 yymqWTeAD+8dUnytnR2jmJ/dxZ/XBqPbTmyBxcV1ngC482/9J//6v8S1cVNnPPhb0uwNswGMJ
 AvQ9XMhzm4qjyGrIbEHqtMnxJ/gpH8CPIfVNDMsdmYSEDsNBwaj/gZHitW6/+5QhFo1MbQvE3
 7v3riuQBk5o35PlnbeTdiJn1FPOsHrHzU8pqDXraNrjTZ3t+IWXiEkdkgcOdbsh+kZEL71+Zf
 Uh7jtc5U/GZt287ovuvYfQPVcOnMpBuC+lMGG5f6PFZYjGCx+y+XhOg9Af0EL5CHXDd/uSPkE
 DwmLiphpJRW4/WjtM9im/lmChSK91Fh8zaK/mGnz+c9NX4i7vx8TeuKh96E1kKk2kQmYWhnF+
 Riq5Vy+a00+dhPwGvib/NeYEf3E3Jot9gJfVwsDCAHp8j3gQG02+v8cuoX3MkXEkTYAV3/tiU
 xibJW7VbxUE9kFNbcJaX8H5QBWiz5r35YT4dWiTWTFEy1u4BcIRmqPwWCB+odYR9OvHTHDkqH
 3cEkrib1NkmngkdJuUQNc8DBCMPBC6+gnTld55Rinywh6yw+2m4/GqXx1ePuNQohiuzbBxHhX
 bzCxmnX6hzWbsAyZddAmCDDajkOLcRnzSs4zRc/FCxb/VCweDLHkkMJ7R0nuzvkgGCDY8a+VO
 +AjpXxasbKrX2dCXLt5LS/nbU41hZYcwzUV88Xdq8xCY+zjmtGW05qO97EwnwQm6c+RTCOMw3
 rJCh2SmXUIiz7QjNarOc3eqJ0AAldi1IWvtktNOdgoqJTST6Ixgk0/m9zHbaOCFP1n96A5U0m
 ktIBmtOTbSfNhPwfjX89/4L4u0obFEJzOPd67PlSvinCRL6Kzvvcl1t3yVcliZavlaz9PBVpW
 LWmF5HIOU9npXhE0i+D0Ln0qxZk=

Since recently mpm node were added to the msm8996.dtsi devicetree:
https://lore.kernel.org/r/20231215-topic-mpm_dt-v1-2-c6636fc75ce3@linaro.o=
rg
I tried to add support for the mpm interrupt controller to the msm8953.dts=
i
device tree as both SOCs looked similar at first sight. The mpm-pin-map da=
ta
here was taken from the fairphone-fp3 downstream kernel (file
drivers/irqchip/qcom/mpm-8953.c):
Link: https://code.fairphone.com/projects/fairphone-3/gpl.html
The following patches were made for the following tree:
https://github.com/spasswolf/msm8953-linux/tree/v6.6.10_mpm

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi
b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 566dd2197fd1..f7184b890d24 100644
=2D-- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -633,6 +633,24 @@ memory {
 		reg =3D <0 0 0 0>;
 	};

+	mpm: interrupt-controller@601d4 {
+		compatible =3D "qcom,mpm";
+		qcom,rpm-msg-ram =3D <&apss_mpm>;
+		interrupts =3D <GIC_SPI 171 IRQ_TYPE_EDGE_RISING>;
+		mboxes =3D <&apcs 1>;
+		interrupt-controller;
+		#interrupt-cells =3D <2>;
+		#power-domain-cells =3D <0>;
+		interrupt-parent =3D <&intc>;
+		qcom,mpm-pin-count =3D <96>;
+		qcom,mpm-pin-map =3D <2 184>,  /* tsens_upper_lower_int */
+				   <37 220>, /* qmp_usb3_lfps_rxterm_irq ->
ss_phy_irq */
+				   <49 136>, /* qusb2phy_dpse_hv ->
hs_phy_irq*/
+				   <53 72>, /* mdss_irq */
+				   <58 136>, /* qusb2phy_dmse_hv ->
hs_phy_irq*/
+				   <88 190>; /* ee0_krait_hlos_spmi_periph_irq
*/
+	};
+
 	pmu {
 		compatible =3D "arm,cortex-a53-pmu";
 		interrupts =3D <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(8) |
IRQ_TYPE_LEVEL_HIGH)>;
@@ -694,11 +712,13 @@ CPU_PD7: power-domain-cpu7 {
 		CLUSTER0_PD: power-domain-cluster0 {
 			#power-domain-cells =3D <0>;
 			domain-idle-states =3D <&CLUSTER_RET>, <&CLUSTER_GDHS>,
<&CLUSTER_PC>;
+			power-domains =3D <&mpm>;
 		};

 		CLUSTER1_PD: power-domain-cluster1 {
 			#power-domain-cells =3D <0>;
 			domain-idle-states =3D <&CLUSTER_RET>, <&CLUSTER_GDHS>,
<&CLUSTER_PC>;
+			power-domains =3D <&mpm>;
 		};
 	};

@@ -958,6 +978,13 @@ soc: soc@0 {
 		rpm_msg_ram: sram@60000 {
 			compatible =3D "qcom,rpm-msg-ram";
 			reg =3D <0x00060000 0x8000>;
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			ranges =3D <0 0x00060000 0x8000>;
+
+			apss_mpm: sram@1d4 {
+				reg =3D <0x1d4 0x48>;
+			};
 		};

 		hsusb_phy: phy@79000 {
@@ -1012,8 +1039,8 @@ tsens0: thermal-sensor@4a9000 {
 			reg =3D <0x004a9000 0x1000>, /* TM */
 			      <0x004a8000 0x1000>; /* SROT */
 			#qcom,sensors =3D <16>;
-			interrupts =3D <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended =3D <&mpm 2 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 314
IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names =3D "uplow", "critical";
 			#thermal-sensor-cells =3D <1>;
 		};
@@ -1052,6 +1079,7 @@ tlmm: pinctrl@1000000 {
 			interrupts =3D <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
 			gpio-ranges =3D <&tlmm 0 0 142>;
+			wakeup-parent =3D <&mpm>;
 			#gpio-cells =3D <2>;
 			interrupt-controller;
 			#interrupt-cells =3D <2>;
@@ -2176,7 +2204,7 @@ spmi_bus: spmi@200f000 {
 			      <0x0200a000 0x2100>;
 			reg-names =3D "core", "chnls", "obsrvr", "intr", "cnfg";
 			interrupt-names =3D "periph_irq";
-			interrupts =3D <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended =3D <&mpm 88 IRQ_TYPE_LEVEL_HIGH>;
 			qcom,ee =3D <0>;
 			qcom,channel =3D <0>;
 			interrupt-controller;
@@ -2247,8 +2275,8 @@ usb3: usb@70f8800 {
 			#size-cells =3D <1>;
 			ranges;

-			interrupts =3D <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended =3D <&mpm 49 IRQ_TYPE_LEVEL_HIGH>,
+					      <&mpm 37 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names =3D "hs_phy_irq", "ss_phy_irq";

 			clocks =3D <&gcc GCC_USB_PHY_CFG_AHB_CLK>,


I also added the msm_gpio_wakeirq_map (data again from downstream kernel)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm8953.c
b/drivers/pinctrl/qcom/pinctrl-msm8953.c
index 998351bdfee1..2ea2c05aca9f 100644
=2D-- a/drivers/pinctrl/qcom/pinctrl-msm8953.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm8953.c
=2D-- a/drivers/pinctrl/qcom/pinctrl-msm8953.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm8953.c
@@ -1790,6 +1790,20 @@ static const struct msm_pingroup msm8953_groups[] =
=3D {
        SDC_QDSD_PINGROUP(sdc2_data, 0x109000, 9, 0),
 };

+static const struct msm_gpio_wakeirq_map msm8953_mpm_map[] =3D {
+       {38, 3}, {1, 4}, {5, 5}, {9, 6}, {37, 8},
+       {36, 9}, {13, 10}, {35, 11}, {17, 12}, {21, 13},
+       {54, 14}, {34, 15}, {31, 16}, {58, 17}, {28, 18},
+       {42, 19}, {25, 20}, {12, 21}, {43, 22}, {44, 23},
+       {45, 24}, {46, 25}, {48, 26}, {65, 27}, {93, 28},
+       {97, 29}, {63, 30}, {70, 31}, {71, 32}, {72, 33},
+       {81, 34}, {85, 35}, {90, 36}, {67, 50}, {73, 51},
+       {74, 52}, {62, 53}, {59, 59}, {60, 60}, {61, 61},
+       {86, 62}, {87, 63}, {91, 64}, {129, 65}, {130, 66},
+       {131, 67}, {132, 68}, {133, 69}, {137, 70}, {138, 71},
+       {139, 72}, {140, 73}, {141, 74},
+};
+
 static const struct msm_pinctrl_soc_data msm8953_pinctrl =3D {
        .pins =3D msm8953_pins,
        .npins =3D ARRAY_SIZE(msm8953_pins),
@@ -1798,6 +1812,9 @@ static const struct msm_pinctrl_soc_data msm8953_pin=
ctrl =3D
{
        .groups =3D msm8953_groups,
        .ngroups =3D ARRAY_SIZE(msm8953_groups),
        .ngpios =3D 142,
+       .wakeirq_map =3D msm8953_mpm_map,
+       .nwakeirq_map =3D ARRAY_SIZE(msm8953_mpm_map),
+       .wakeirq_dual_edge_errata =3D true,
 };

The initial commit message of irq-qcom-mpm.c says
>    - When SoC gets awake from sleep mode, the driver will receive an
>      interrupt from RPM, so that it can replay interrupt for particular
>      polarity.


The problem is that the IRQ does not trigger when suspending and resuming =
by
pressing the powerkey (tested on fairphone-fp3 running debian stable with =
the
linux-msm8953 mainline kernel):
$ cat /proc/interrupt | grep qcom_mpm
 15:          0          0          0          0          0          0
0          0 GIC-0 203 Edge      qcom_mpm

Is this a problem of the mpm driver or the mpm nodes? Or is this a misconf=
igured
RPM that does not trigger the interrupt when waking up? Do the mpm patches=
 for
msm8996 sm6375 and qcm2290 already work on actual hardware? Is there
Documentation for the qcom RPM which describes how to enable this wakeup
interrupt?

Thanks in advance
Bert Karwatzki



