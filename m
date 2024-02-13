Return-Path: <linux-kernel+bounces-63377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D37A852E66
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D74DDB26953
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4668424B28;
	Tue, 13 Feb 2024 10:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wwVM7OX1"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EE02BD01
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821649; cv=none; b=oc+mIQNDkAjGPGWCIIkd1WotM/HPabY9B8MjVdWdVGQVZwQNQXbT+r6wvR9O/QaB1TPD58dFJ7twFnxn/7cKVGbLqrV89Pw3H0Q3p2zUgeSuc+i1Fa1OJ20MUSveDU+cbqqNXLSChpDZXu/I3d9guQ/TEkINnrVwYGrk5V3/Nw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821649; c=relaxed/simple;
	bh=zIILUVITRYsRVIoakXIdWqn4esADPrLTftPfvi8YhQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eT5+D+0t2RwY3GnApzS1dcz7S9tZssaAkN+qvCbVSDY8LFY8Q4/R9uNNo+cceUjpBtkLyaRk4fuQ8sNuCsRA+8xsyiLieiRqP5NJUmYq+8Io2oY3pdAdPkOoehRV6lGzi061wzZOX4B4cRRN+CmL+ybGsoNoQfassYKdnOdX59c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wwVM7OX1; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so4003888276.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 02:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707821647; x=1708426447; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=62wygMyBdeSVpMuQ3wI8n4MfTzhln2PY4S7FohPAHFs=;
        b=wwVM7OX1662vOFflvsrw3L4B+DkQNAK5H9GBP75piM9/sXk1mNG2AGKjikG6KWlWyR
         daFXPXVPJrsb0MjCiFSfGBQ+TM+0LhctMxzjbjCPuBt2yCoSMDFfB7lFXHgmJOJWQEMZ
         0MQq4quYJIVjc3MPdmx0tjufLfXQtSRtOtTclgyMpXaqAwVXpo5k9/zDgfG2yg4Y9mE7
         RIL0WrrIh/PleJEmRRWKXWvCtBN0JmSHmeGnMud5mrinTGHJ8FSNWBEkUBl1BJbvQTj7
         5ILypmOecVL7bByks26QOIaJ3uWWVDX6RiG8fCGCChsycutOAZDkUXKLPyuYviQO+u7k
         GvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707821647; x=1708426447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62wygMyBdeSVpMuQ3wI8n4MfTzhln2PY4S7FohPAHFs=;
        b=gOWgkdC8wVQzeLllU8+Ygya+++2M6A92+bdiD6OXiXR+rcbSAqJVwmnb03hmwIxuIq
         kxv/Xw+So3A2TaOz40d4LBO7IF7LAy9Ze/ewu8rhYJ9oi3x5h9QIoClip5b9ESM2CXxT
         7qlWgS9PSRRMpsxCeYlQH0CZFb8qNA3N75jOnT13+YqJ6OMu3lBeUJEi2itHZa5QyvAf
         ubUAjraCtAd9AfTJJ/YicIvDTikneQWs+3AeTnO5VAK+dmaE8fyA/qgw0perGSKvjszg
         +wCHVKpxRm8RcpTaScDvdnMYevwqgNbXf3yTzbG3Whe2Vqiaks7oKyxTaF7VFGD8655q
         egrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmeEU3z8Kq6tANTvV61LE3211wy+P1PX7Nte3wN5jnW/MbZv0BuWFL64uMD9x5VaIztsZPvuZOgtGkRvWdmkgoOKwKNgjYqxfXuGsm
X-Gm-Message-State: AOJu0YyLFCPiaxSYc16uYLwC61kmecphSrFkZfMU/WF4veiblOPBGNHB
	CivmcoD+1ALSmY9ZsrpfdNKchrZ7iltaVhk98WqJxTvzSSzaEjAUC2Xe6y0Bp/upZ/lxT1fgWj7
	DwiwkAVDA5iz2vptVY8VytcBFfR2mSENpRFxZwQ==
X-Google-Smtp-Source: AGHT+IGLUVGIHY81Tcp0bv2vTSWijZVfrPPjlMaVyZ75RYgEoRCw78YWDpdzbiB2KYKdDN525kZxCQzSFmKzTrLQJyw=
X-Received: by 2002:a05:6902:542:b0:dc6:6307:d188 with SMTP id
 z2-20020a056902054200b00dc66307d188mr7487929ybs.25.1707821646726; Tue, 13 Feb
 2024 02:54:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213104754.8195-1-quic_riteshk@quicinc.com> <20240213104754.8195-3-quic_riteshk@quicinc.com>
In-Reply-To: <20240213104754.8195-3-quic_riteshk@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 13 Feb 2024 12:53:55 +0200
Message-ID: <CAA8EJprztE0Cwc=+vxxXk=wKmyMU_TCtLPcY29RHO4-+nWFQEw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: qcm6490-idp: add display and panel
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

On Tue, 13 Feb 2024 at 12:48, Ritesh Kumar <quic_riteshk@quicinc.com> wrote:
>
> Enable Display Subsystem with Novatek NT36672E Panel
> on qcm6490 idp platform.
>
> Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>
>
> ---
> v2: Fixed review comments from Dmitry and Konrad
>       - moved pinctrl-names after pinctrl-0 property.
>       - removed gpu disablement change after validating gpu.
>     Rebased the patch
>       - rebased the patch to resolve conflicts.
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 92 ++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> index 502a5a383bde..0054b2a8d6c7 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> @@ -10,6 +10,7 @@
>  #define PM7250B_SID1 9
>
>  #include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "sc7280.dtsi"
>  #include "pm7250b.dtsi"
> @@ -39,6 +40,25 @@
>                 stdout-path = "serial0:115200n8";
>         };
>
> +       lcd_disp_bias: lcd-disp-bias-regulator {

regualtor-lcd-disp-bias, please. This will allow grouping regulators together.

> +               compatible = "regulator-fixed";
> +               regulator-name = "lcd_disp_bias";
> +               regulator-min-microvolt = <5500000>;
> +               regulator-max-microvolt = <5500000>;
> +               gpio = <&pm7250b_gpios 2 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +               pinctrl-0 = <&lcd_disp_bias_en>;
> +               pinctrl-names = "default";
> +       };
> +
> +       pm8350c_pwm_backlight: backlight {

This node isn't in the sort order.

> +               compatible = "pwm-backlight";
> +               pwms = <&pm8350c_pwm 3 65535>;
> +               enable-gpios = <&pm8350c_gpios 7 GPIO_ACTIVE_HIGH>;
> +               pinctrl-0 = <&pmic_lcd_bl_en>;
> +               pinctrl-names = "default";
> +       };
> +
>         reserved-memory {
>                 xbl_mem: xbl@80700000 {
>                         reg = <0x0 0x80700000 0x0 0x100000>;
> @@ -421,7 +441,79 @@
>         };
>  };
>
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
>  &pm8350c_pwm {
> +       pinctrl-0 = <&pmic_lcd_bl_pwm>;
> +       pinctrl-names = "default";
>         status = "okay";
>
>         multi-led {
> --
> 2.17.1
>


-- 
With best wishes
Dmitry

