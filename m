Return-Path: <linux-kernel+bounces-27224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B42B82EC6B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 062E6B22C34
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C1418E0B;
	Tue, 16 Jan 2024 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t0fLXc0+"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8400E18EA8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5f75aee31d2so85472007b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 01:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705399108; x=1706003908; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R1xEZasaNALs0H/c20rzDJz1USl3lr2o7KFCpBSV5WU=;
        b=t0fLXc0+GvjQOBzJi2qbSTSKCP2bmzWlkjcLI8Kw5DSdg0cvqnBpZty4kum2pIWzMB
         7BkW7ihSSjZP44xErm8hTvUSJEQWzx1jinQ8/XILK0MMeNLz6wucPZ91DQOW9zu4lABD
         8g/PRPTp/4R3FA2/56rHoEMvbG0zEvYT8R+Go6N9Zq2J+29XR7dA09kB7BK80y0cvfy4
         GeUG1lp9W0nV1bUFEO+mUCzgaPl1N7mYzzXbX/hV38M0t0Ce+th9MmV1QqbDnXj+XHQ8
         k+QajJV/sC9Q2os2IB6LaKh3dAnKtmG0kAUTyeR0ZCgTJQNXSkiVS9vNRCpM9Xtblm0m
         0svQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705399108; x=1706003908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1xEZasaNALs0H/c20rzDJz1USl3lr2o7KFCpBSV5WU=;
        b=qNS2AqALpwIMQFEMhKDx/i+l+UQ2GrxmJDUhmAgsfNxEkwKY0x/Gvicj3KfCRTCo8A
         a1MajM2VKu+qLsS8xe612UAGetIlB/a8EuqLe6l7NtazRtq5fg7uHS0umFtBeLig9IXG
         HJqwHxVNp7h46Xgvl3Y+GvQikrYSoUxYMeZTqz1uuLWpFxsvkn23qjQoE8CMdNJjakOC
         p228gFEDJ0xDLJPB5tfEHJSffK0CimwCQBRTIHTG6/3kOL59V6HUNsjGS4JW28OxCpOP
         Fiil1+ffdTrDw+gkPIllNZbaH+vRPJSorsgmBwXhQ4y5lJUNUttmMaK/C4ENRjjYdxjB
         NdSw==
X-Gm-Message-State: AOJu0YwU7rHHlJNNX2qOEPTSt35dfWCHa8nD65NYOolsQzL2Wd9VWN3g
	vb7EhFxbG308BooPaUKT7YDKD7jjNW4ro3QOhhbfgkry1FcBlA==
X-Google-Smtp-Source: AGHT+IEXftEaoSyn1koz1ntE2MMdhAkNAHrntukTqgwGP7zuusTChJSDEo3EuSuE+f2Sr8KZRlvgAnfoYF0dttlFtxE=
X-Received: by 2002:a81:4e82:0:b0:5ff:5bac:a28a with SMTP id
 c124-20020a814e82000000b005ff5baca28amr148911ywb.76.1705399108510; Tue, 16
 Jan 2024 01:58:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116094935.9988-1-quic_riteshk@quicinc.com> <20240116094935.9988-3-quic_riteshk@quicinc.com>
In-Reply-To: <20240116094935.9988-3-quic_riteshk@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 16 Jan 2024 11:58:17 +0200
Message-ID: <CAA8EJpp3WJ8132aB-tyzJPXsdczvQC+TvKemm9NvUNYNrEntow@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qcm6490-idp: add display and panel
To: Ritesh Kumar <quic_riteshk@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, quic_bjorande@quicinc.com, 
	geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org, 
	nfraprado@collabora.com, m.szyprowski@samsung.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	quic_abhinavk@quicinc.com, quic_rajeevny@quicinc.com, 
	quic_vproddut@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jan 2024 at 11:49, Ritesh Kumar <quic_riteshk@quicinc.com> wrote:
>
> Enable Display Subsystem with Novatek NT36672E Panel
> on qcm6490 idp platform.

Is this panel always present on the IDP board or is it an optional
addon, like the panels for all the RBn boards?

>
> Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 100 +++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> index 2a6e4907c5ee..efa5252130a1 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> @@ -9,6 +9,7 @@
>  #define PM7250B_SID 8
>  #define PM7250B_SID1 9
>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "sc7280.dtsi"
>  #include "pm7250b.dtsi"
> @@ -38,6 +39,25 @@
>                 stdout-path = "serial0:115200n8";
>         };
>
> +       lcd_disp_bias: lcd-disp-bias-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "lcd_disp_bias";
> +               regulator-min-microvolt = <5500000>;
> +               regulator-max-microvolt = <5500000>;
> +               gpio = <&pm7250b_gpios 2 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&lcd_disp_bias_en>;
> +       };
> +
> +       pm8350c_pwm_backlight: backlight {
> +               compatible = "pwm-backlight";
> +               pwms = <&pm8350c_pwm 3 65535>;
> +               enable-gpios = <&pm8350c_gpios 7 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pmic_lcd_bl_en>;
> +       };
> +
>         reserved-memory {
>                 xbl_mem: xbl@80700000 {
>                         reg = <0x0 0x80700000 0x0 0x100000>;
> @@ -420,6 +440,86 @@
>         };
>  };
>
> +&gpu {
> +       status = "disabled";
> +};
> +
> +&mdss {
> +       status = "okay";
> +};
> +
> +&mdss_dsi {
> +       vdda-supply = <&vreg_l6b_1p2>;
> +       status = "okay";
> +
> +       panel@0 {
> +               compatible = "novatek,nt36672e";
> +               reg = <0>;
> +
> +               reset-gpios = <&tlmm 44 GPIO_ACTIVE_HIGH>;
> +
> +               vddi-supply = <&vreg_l8c_1p62>;
> +               avdd-supply = <&lcd_disp_bias>;
> +               avee-supply = <&lcd_disp_bias>;
> +
> +               backlight = <&pm8350c_pwm_backlight>;
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
> +&mdss_dsi_phy {
> +       vdds-supply = <&vreg_l10c_0p88>;
> +       status = "okay";
> +};
> +
> +&pm7250b_gpios {
> +       lcd_disp_bias_en: lcd-disp-bias-en-state {
> +               pins = "gpio2";
> +               function = "func1";
> +               bias-disable;
> +               qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
> +               input-disable;
> +               output-enable;
> +               power-source = <0>;
> +       };
> +};
> +
> +&pm8350c_gpios {
> +       pmic_lcd_bl_en: pmic-lcd-bl-en-state {
> +               pins = "gpio7";
> +               function = "normal";
> +               bias-disable;
> +               qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
> +               output-low;
> +               power-source = <0>;
> +       };
> +
> +       pmic_lcd_bl_pwm: pmic-lcd-bl-pwm-state {
> +               pins = "gpio8";
> +               function = "func1";
> +               bias-disable;
> +               qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
> +               output-low;
> +               power-source = <0>;
> +       };
> +};
> +
> +&pm8350c_pwm {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pmic_lcd_bl_pwm>;
> +       status = "okay";
> +};
> +
>  &qupv3_id_0 {
>         status = "okay";
>  };
> --
> 2.17.1
>


-- 
With best wishes
Dmitry

