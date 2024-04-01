Return-Path: <linux-kernel+bounces-126985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F8E894571
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B279B2181A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7765C53372;
	Mon,  1 Apr 2024 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EKYCWhLd"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C88053370
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 19:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711999362; cv=none; b=KqXZrQiob5l1Q5S8OyQ2WAolRVcT09lT/iTqbLBn0MKYYwuOUFJdPO1i56A0ElbqUEQ1Mm+b+1tnE1BxbH+lkHrd7cdPcQQodoqBbocECXNKKsG1urkKweXkffqaFj8fWM8PtGOl474eucXTjGXMLEWP+tRgKY1mJnzgZPEQ7dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711999362; c=relaxed/simple;
	bh=z0TyYCmeCKFtlFcAlva4XJcOn8MH8YBfe34AMkoMOpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/hDCs2bCflauW/38jwJYfuRqa6DXisIl4GsRRd2Ntb0bWXd2yku7Ld7bp1Zh6OyevaDlmd7QNaOIpkKgo4Z2kQL/3qkvvBA2bXyEVoeSNGU6Rv/4p7jSXDIvPPdv6jLYRYbjugxDaswz4Ej2SNGFtt5jMtMz3HFF8zQZXkncPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EKYCWhLd; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dd02fb9a31cso3694035276.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 12:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711999359; x=1712604159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7Uz10MZlhGKllJSDw2j3vPUCAL03zsf7WqitsfzNhkw=;
        b=EKYCWhLdqTJzPQxOMJsLTErN2YlZGrtpYFGcLkDtqWaDKHgXhupN2PtWPBXJ+chY9/
         fNpUC+IA3+icUSmUVhs0L124sXMNPGZqNIamFFsBR5I9NbyQu8dySmRHK75RGjmIXK9k
         bnHBDx7g+cU7e4uUilqpCMXz20F4YwOirLEuWNNWM8N8YeWXHzExXOUe6jkq/Sj0Z9WK
         Ice5ZYOcdIz9Dnt6Z1bfJEUIy++KAYxskhzo6YYVLkHCkAKzxWZ7WdZOlnvliIIzGuWX
         VJf1oZAZlYP1/EnhJrs/rOzHlWXgMiasVXlDgT89ImpkI/lJF1WvmLqdvpYSh3cZKrjr
         /TSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711999359; x=1712604159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Uz10MZlhGKllJSDw2j3vPUCAL03zsf7WqitsfzNhkw=;
        b=Mi3orRQrBrjvkh6tN1KTIjyaJHAl23XSa7sysL056k2r1mgit0Pk8yPFzIm59xplB0
         InHUjPrIrBtY//TDMRRYyYpQ4ph4SVWv7HQ6ScdcVrECWJj0itJzPE7eSduEVmm9jyle
         0rszmMiOISK5ZBv/PpGOyjDlxtGLKbO/679esCR6kO37dfFK/UiL8xzaCiajVqXRg9G7
         YfxpIAGuHkuP9VBWWApFkyb+Dgeneo101Das0DGkBbAoT2etwHYaChJSL24D+UQYcrJN
         eFs6pBFtm22BXBwyycEFjp38VgZym30oNx0gOd/AqN0DZgnn/gvNxzwkaLOawEWzCthQ
         czkw==
X-Forwarded-Encrypted: i=1; AJvYcCWik3Uz/0uSFFRkNimINvvdWTrYE014yMymtMVhyNHb6DLKJ/ZLycRCalJoVRhQzWatlQf/Xoen4fxSNwg9i+gaTSJ3qNkamvCdUGDi
X-Gm-Message-State: AOJu0Yx9NyaoRDXAWEuvl6gFiNCplJcMD+OdeoAfP+nl5uEkEf3S2D5T
	/A+nqz1sRZCppZGrEPxkBFdEPyYcd+OKxAXrH+k6V40QC6o5G4rUkZMBz450tJjGfnvslPoLKYO
	RlJqNfYzoZK1QytYVan2bsuoOM+hJGLA1o3lpLQ==
X-Google-Smtp-Source: AGHT+IGGyN4Yf36VxfeJVzeUvZZ+lsW0a5/Y6kiM7+h45e4SsuuzRQZ/AMDg4DWC//VcHVkLMztmTVDdqegiYAcW1Dg=
X-Received: by 2002:a25:5f4e:0:b0:ddd:7456:d203 with SMTP id
 h14-20020a255f4e000000b00ddd7456d203mr8773506ybm.41.1711999358969; Mon, 01
 Apr 2024 12:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401093843.2591147-1-quic_tengfan@quicinc.com> <20240401093843.2591147-5-quic_tengfan@quicinc.com>
In-Reply-To: <20240401093843.2591147-5-quic_tengfan@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 1 Apr 2024 22:22:28 +0300
Message-ID: <CAA8EJpoUgP8Ec-0-WO=65Sdzh0ASwsMqvMP-HUnZ0Q7sjLg-YQ@mail.gmail.com>
Subject: Re: [PATCH v6 RESEND 4/4] arm64: dts: qcom: aim300: add AIM300 AIoT
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, keescook@chromium.org, 
	tony.luck@intel.com, gpiccoli@igalia.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kernel@quicinc.com, 
	Qiang Yu <quic_qianyu@quicinc.com>, Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Apr 2024 at 12:40, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>
> Add AIM300 AIoT Carrier board DTS support, including usb, UART, PCIe,
> I2C functions support.
> Here is a diagram of AIM300 AIoT Carrie Board and SoM
>  +--------------------------------------------------+
>  |             AIM300 AIOT Carrie Board             |
>  |                                                  |
>  |           +-----------------+                    |
>  |power----->| Fixed regulator |---------+          |
>  |           +-----------------+         |          |
>  |                                       |          |
>  |                                       v VPH_PWR  |
>  | +----------------------------------------------+ |
>  | |                          AIM300 SOM |        | |
>  | |                                     |VPH_PWR | |
>  | |                                     v        | |
>  | |   +-------+       +--------+     +------+    | |
>  | |   | UFS   |       | QCS8550|     |PMIC  |    | |
>  | |   +-------+       +--------+     +------+    | |
>  | |                                              | |
>  | +----------------------------------------------+ |
>  |                                                  |
>  |                    +----+          +------+      |
>  |                    |USB |          | UART |      |
>  |                    +----+          +------+      |
>  +--------------------------------------------------+
>
> Co-developed-by: Qiang Yu <quic_qianyu@quicinc.com>
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> Co-developed-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/qcs8550-aim300-aiot.dts     | 384 ++++++++++++++++++
>  2 files changed, 385 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 7d40ec5e7d21..02d9bc3bfce7 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -96,6 +96,7 @@ dtb-$(CONFIG_ARCH_QCOM)       += qcm6490-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += qcs404-evb-1000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += qcs404-evb-4000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += qcs6490-rb3gen2.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        += qcs8550-aim300-aiot.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += qdu1000-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += qrb2210-rb1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += qrb4210-rb2.dtb
> diff --git a/arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts b/arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts
> new file mode 100644
> index 000000000000..8188766c3d84
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts
> @@ -0,0 +1,384 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/leds/common.h>
> +#include "qcs8550-aim300.dtsi"
> +#include "pm8010.dtsi"
> +#include "pmr735d_a.dtsi"
> +#include "pmr735d_b.dtsi"
> +
> +/ {
> +       model = "Qualcomm Technologies, Inc. QCS8550 AIM300 AIOT";
> +       compatible = "qcom,qcs8550-aim300-aiot", "qcom,qcs8550-aim300", "qcom,qcs8550",
> +                    "qcom,sm8550";
> +
> +       aliases {
> +               serial0 = &uart7;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +
> +       gpio-keys {
> +               compatible = "gpio-keys";
> +
> +               pinctrl-0 = <&volume_up_n>;
> +               pinctrl-names = "default";
> +
> +               key-volume-up {
> +                       label = "Volume Up";
> +                       debounce-interval = <15>;
> +                       gpios = <&pm8550_gpios 6 GPIO_ACTIVE_LOW>;
> +                       linux,code = <KEY_VOLUMEUP>;
> +                       linux,can-disable;
> +                       wakeup-source;
> +               };
> +       };
> +
> +       pmic-glink {
> +               compatible = "qcom,sm8550-pmic-glink", "qcom,pmic-glink";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               orientation-gpios = <&tlmm 11 GPIO_ACTIVE_HIGH>;
> +
> +               connector@0 {
> +                       compatible = "usb-c-connector";
> +                       reg = <0>;
> +                       power-role = "dual";
> +                       data-role = "dual";
> +
> +                       ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               port@0 {
> +                                       reg = <0>;
> +
> +                                       pmic_glink_hs_in: endpoint {
> +                                               remote-endpoint = <&usb_1_dwc3_hs>;
> +                                       };
> +                               };
> +
> +                               port@1 {
> +                                       reg = <1>;
> +
> +                                       pmic_glink_ss_in: endpoint {
> +                                               remote-endpoint = <&redriver_ss_out>;
> +                                       };
> +                               };
> +
> +                               port@2 {
> +                                       reg = <2>;
> +
> +                                       pmic_glink_sbu: endpoint {
> +                                               remote-endpoint = <&fsa4480_sbu_mux>;
> +                                       };
> +                               };
> +                       };
> +               };
> +       };
> +
> +       vph_pwr: regulator-vph-pwr {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vph_pwr";
> +               regulator-min-microvolt = <3700000>;
> +               regulator-max-microvolt = <3700000>;
> +
> +               regulator-always-on;
> +               regulator-boot-on;
> +       };
> +};
> +
> +&apps_rsc {
> +       regulators-0 {
> +               vdd-bob1-supply = <&vph_pwr>;
> +               vdd-bob2-supply = <&vph_pwr>;
> +       };
> +
> +       regulators-3 {
> +               vdd-s4-supply = <&vph_pwr>;
> +               vdd-s5-supply = <&vph_pwr>;
> +       };
> +
> +       regulators-4 {
> +               vdd-s4-supply = <&vph_pwr>;
> +       };
> +
> +       regulators-5 {
> +               vdd-s1-supply = <&vph_pwr>;
> +               vdd-s2-supply = <&vph_pwr>;
> +               vdd-s3-supply = <&vph_pwr>;
> +               vdd-s4-supply = <&vph_pwr>;
> +               vdd-s5-supply = <&vph_pwr>;
> +               vdd-s6-supply = <&vph_pwr>;
> +       };
> +};
> +
> +&i2c_hub_2 {
> +       status = "okay";
> +
> +       typec-mux@42 {
> +               compatible = "fcs,fsa4480";
> +               reg = <0x42>;
> +
> +               vcc-supply = <&vreg_bob1>;
> +
> +               mode-switch;
> +               orientation-switch;
> +
> +               port {
> +                       fsa4480_sbu_mux: endpoint {
> +                               remote-endpoint = <&pmic_glink_sbu>;
> +                       };
> +               };
> +       };
> +
> +       typec-retimer@1c {
> +               compatible = "onnn,nb7vpq904m";
> +               reg = <0x1c>;
> +
> +               vcc-supply = <&vreg_l15b_1p8>;
> +
> +               orientation-switch;
> +               retimer-switch;
> +
> +               ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port@0 {
> +                               reg = <0>;
> +
> +                               redriver_ss_out: endpoint {
> +                                       remote-endpoint = <&pmic_glink_ss_in>;
> +                               };
> +                       };
> +
> +                       port@1 {
> +                               reg = <1>;
> +
> +                               redriver_ss_in: endpoint {
> +                                       data-lanes = <3 2 1 0>;
> +                                       remote-endpoint = <&usb_dp_qmpphy_out>;
> +                               };
> +                       };
> +               };
> +       };
> +};
> +
> +&mdss_dsi0 {
> +       vdda-supply = <&vreg_l3e_1p2>;

Is this wired on the carrier board or on the AIC300 SoM?

> +       status = "okay";
> +
> +       panel@0 {
> +               compatible = "visionox,vtdr6130";
> +               reg = <0>;
> +
> +               pinctrl-0 = <&dsi_active>, <&te_active>;
> +               pinctrl-1 = <&dsi_suspend>, <&te_suspend>;
> +               pinctrl-names = "default", "sleep";
> +
> +               reset-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
> +
> +               vci-supply = <&vreg_l13b_3p0>;
> +               vdd-supply = <&vreg_l11b_1p2>;
> +               vddio-supply = <&vreg_l12b_1p8>;
> +
> +               port {
> +                       panel0_in: endpoint {
> +                               remote-endpoint = <&mdss_dsi0_out>;
> +                       };
> +               };
> +       };
> +};
> +
> +&mdss_dsi0_out {
> +       remote-endpoint = <&panel0_in>;
> +       data-lanes = <0 1 2 3>;
> +};
> +
> +&mdss_dsi0_phy {
> +       vdds-supply = <&vreg_l1e_0p88>;

This too

> +       status = "okay";
> +};
> +
> +&pcie0 {
> +       perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
> +       wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;

And this

> +
> +       pinctrl-0 = <&pcie0_default_state>;
> +       pinctrl-names = "default";
> +
> +       status = "okay";
> +};
> +
> +&pcie0_phy {
> +       vdda-phy-supply = <&vreg_l1e_0p88>;
> +       vdda-pll-supply = <&vreg_l3e_1p2>;

You guess the question. I think I'll stop here. Please review your
changes here, which are really specific to the carrier board and which
apply to the SoM.

> +
> +       status = "okay";
> +};
> +
> +&pcie_1_phy_aux_clk {
> +       clock-frequency = <1000>;
> +};
> +
> +&pcie1 {
> +       perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
> +       wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
> +
> +       pinctrl-0 = <&pcie1_default_state>;
> +       pinctrl-names = "default";
> +
> +       status = "okay";
> +};
> +
> +&pcie1_phy {
> +       vdda-phy-supply = <&vreg_l3c_0p9>;
> +       vdda-pll-supply = <&vreg_l3e_1p2>;
> +       vdda-qref-supply = <&vreg_l1e_0p88>;
> +
> +       status = "okay";
> +};
> +
> +&pm8550_gpios {
> +       volume_up_n: volume-up-n-state {
> +               pins = "gpio6";
> +               function = "normal";
> +               power-source = <1>;
> +               bias-pull-up;
> +               input-enable;
> +       };
> +};
> +
> +&pm8550b_eusb2_repeater {
> +       vdd18-supply = <&vreg_l15b_1p8>;
> +       vdd3-supply = <&vreg_l5b_3p1>;
> +};
> +
> +
> +&pon_pwrkey {
> +       status = "okay";
> +};
> +
> +&pon_resin {
> +       linux,code = <KEY_VOLUMEDOWN>;
> +
> +       status = "okay";
> +};
> +
> +&qupv3_id_0 {
> +       status = "okay";
> +};
> +
> +&remoteproc_adsp {
> +       firmware-name = "qcom/qcs8550/adsp.mbn",
> +                       "qcom/qcs8550/adsp_dtbs.elf";
> +       status = "okay";
> +};
> +
> +&remoteproc_cdsp {
> +       firmware-name = "qcom/qcs8550/cdsp.mbn",
> +                       "qcom/qcs8550/cdsp_dtbs.elf";
> +       status = "okay";
> +};
> +
> +&sleep_clk {
> +       clock-frequency = <32000>;
> +};
> +
> +&swr1 {
> +       status = "okay";
> +};
> +
> +&swr2 {
> +       status = "okay";
> +};
> +
> +&tlmm {
> +       gpio-reserved-ranges = <32 8>;
> +
> +       dsi_active: dsi-active-state {
> +               pins = "gpio133";
> +               function = "gpio";
> +               drive-strength = <8>;
> +               bias-disable;
> +       };
> +
> +       dsi_suspend: dsi-suspend-state {
> +               pins = "gpio133";
> +               function = "gpio";
> +               drive-strength = <2>;
> +               bias-pull-down;
> +       };
> +
> +       te_active: te-active-state {
> +               pins = "gpio86";
> +               function = "mdp_vsync";
> +               drive-strength = <2>;
> +               bias-pull-down;
> +       };
> +
> +       te_suspend: te-suspend-state {
> +               pins = "gpio86";
> +               function = "mdp_vsync";
> +               drive-strength = <2>;
> +               bias-pull-down;
> +       };
> +};
> +
> +&uart7 {
> +       status = "okay";
> +};
> +
> +&usb_1 {
> +       status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +       dr_mode = "otg";
> +       usb-role-switch;
> +};
> +
> +&usb_1_dwc3_hs {
> +       remote-endpoint = <&pmic_glink_hs_in>;
> +};
> +
> +&usb_1_dwc3_ss {
> +       remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
> +};
> +
> +&usb_1_hsphy {
> +       phys = <&pm8550b_eusb2_repeater>;
> +
> +       vdd-supply = <&vreg_l1e_0p88>;
> +       vdda12-supply = <&vreg_l3e_1p2>;
> +
> +       status = "okay";
> +};
> +
> +&usb_dp_qmpphy {
> +       vdda-phy-supply = <&vreg_l3e_1p2>;
> +       vdda-pll-supply = <&vreg_l3f_0p88>;
> +
> +       orientation-switch;
> +
> +       status = "okay";
> +};
> +
> +&usb_dp_qmpphy_out {
> +       remote-endpoint = <&redriver_ss_in>;
> +};
> +
> +&usb_dp_qmpphy_usb_ss_in {
> +       remote-endpoint = <&usb_1_dwc3_ss>;
> +};
> +
> +&xo_board {
> +       clock-frequency = <76800000>;
> +};
> --
> 2.25.1
>
>


-- 
With best wishes
Dmitry

