Return-Path: <linux-kernel+bounces-105917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5018987E65B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04AF32824F9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01462E62A;
	Mon, 18 Mar 2024 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fVOqI6G4"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB14A2D047
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755460; cv=none; b=T9ENdR071xFz6qlanByttZjIXTQOZsjI67pMkggASPmyGBVOopAL5KlQsocfdh7dLhN3bxLHGj2k1j+F4CFCdFRY8kxo7qDjanX9S0xsVMDBdfmuk0CxWHqukNWdIoeWu/BjAIedWYdyzyjqs2x9Cy57TNQp1JGHNwkj9909i3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755460; c=relaxed/simple;
	bh=auVUFwgCBmyVxTxFiH+lRCLpkk+F+vVWKfEeldpx/lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdsZZz6Tdl1HWKs4FP0OlBIv6nj1E8HOUG2BGqclwJFeoWku38Mxmq8XJ2kSGGfNDqd/ILWK8vNVitzVqJJ2FjgXZ7RGucY1YOxRvTHmPCiL7/uXgx69QLikM+nc79r5cDom3vnJWZ56tDhWxZyLM1EaDbCFpQaA583NtpQai8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fVOqI6G4; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4767bf3e2a2so631525137.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 02:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710755458; x=1711360258; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jfd2BbpInLFXO/gl5I1K9j+aMpVjnkifvVf9+3n/epo=;
        b=fVOqI6G4nj9LuRdNTqc6L/wwnGtnAwG4I04uiDnYi2u55yR9iDUEYjuH/f6WseCFji
         NPUFiPzkyIU+QBghK/lHRgakVNmiRWtRltgiI2SVY8KgRBkH/PAjUrHS99I66QqySowA
         X+oY84q37ncPq1GaxMfbwL4amx3gmt8NjT2HFY/IrAw8jfJjL4yGiyAj6Fzz45689zvq
         KbaHNvqfckNz9l0X4D6Qt8Vv8NiXCfNv6oD4WI+Y+MhJHu4+XfUuszFJcwGEteFfZyAX
         WDKTbSN380r1cAN8wFjiINnLObcN1pAFca1tqFPlo2V+jW/0VNXdHjrQAKGj8sLufoyU
         I+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710755458; x=1711360258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jfd2BbpInLFXO/gl5I1K9j+aMpVjnkifvVf9+3n/epo=;
        b=rnfh8ZOiyY4R9JnAyF2jnjNKE0EjbC4bS//1vDnBqiQWayrSq4dnVrN/ifw62TVRYx
         cTz28X95LPnxLiV2VtrEizbBz04F2Qu2bdfkYAw8BYZrs2bgBmYGN5WqeAeoUAMc+bl/
         Tr+L3p8/XCJ51cJZi14L1TFi8ya6fAhgtsQRXViZoa4biU0S//6QIZqbZidW3+uAJ4k+
         S26K7pD54/zgyY1UYFYpqyM71idn/XVLayEDPyDU+/nQldnEQfBrYzYDv62tjhLIIRdM
         9flB04Zp02GqF8Uc1brcYuIJKamjBMTSzj2vH5zKKgusiQMT15J798ZKduZe0SKrHtxL
         3yuw==
X-Forwarded-Encrypted: i=1; AJvYcCW3MaYbn3BbV4eWDFSF2e5aXolEeAgjbDg+f0aEpG/n55ktBwHQfj83gP/+USWgheF3m5CIrg9ebsdAvveC/pi5dXtvohPy9ffteGBH
X-Gm-Message-State: AOJu0Yw4IbjVv6dF2/vGnVsdYuuF+FRTB/Q1pSo1jLVqvs2193MG019K
	gA3XBPL1l5ENl8GOt5Re5ogPjwZueqmhjHZW9bDQLUfYlmRUnkSZCebmXY576uBPTByx4QeFdwZ
	Kg72UQBsxMtOOJSf1k1ybYnl+uYayrBqW0XiY2g==
X-Google-Smtp-Source: AGHT+IH4FyFv1D8F2gZISrZTTPRuc+B0sE92LhX8lYAkMKHcHpV2oQ5xGlf9diPhxK2wW1KsYreKGIW8bDmby41ZNIQ=
X-Received: by 2002:a67:fe4b:0:b0:473:148c:805d with SMTP id
 m11-20020a67fe4b000000b00473148c805dmr8854213vsr.11.1710755457728; Mon, 18
 Mar 2024 02:50:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315060707.471248-1-sumit.garg@linaro.org>
 <20240315060707.471248-4-sumit.garg@linaro.org> <ZfRlYnEQUKvwGQ65@gerhold.net>
In-Reply-To: <ZfRlYnEQUKvwGQ65@gerhold.net>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 18 Mar 2024 15:20:46 +0530
Message-ID: <CAFA6WYMucNzLNm+oHNd-Jb65oigpNphU=mFGM1cD8A-mK-BFDw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS
To: Stephan Gerhold <stephan@gerhold.net>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	caleb.connolly@linaro.org, neil.armstrong@linaro.org, 
	dmitry.baryshkov@linaro.org, laetitia.mariottini@se.com, 
	pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com, 
	benjamin.missey@non.se.com, daniel.thompson@linaro.org, 
	linux-kernel@vger.kernel.org, Jagdish Gediya <jagdish.gediya@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Mar 2024 at 20:43, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Fri, Mar 15, 2024 at 11:37:07AM +0530, Sumit Garg wrote:
> > Add Schneider Electric HMIBSC board DTS. The HMIBSC board is an IIoT Edge
> > Box Core board based on the Qualcomm APQ8016E SoC.
> >
> > Support for Schneider Electric HMIBSC. Features:
> > - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> > - 1GiB RAM
> > - 8GiB eMMC, SD slot
> > - WiFi and Bluetooth
> > - 2x Host, 1x Device USB port
> > - HDMI
> > - Discrete TPM2 chip over SPI
> > - USB ethernet adaptors (soldered)
> >
> > Co-developed-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> > Signed-off-by: Jagdish Gediya <jagdish.gediya@linaro.org>
> > Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/Makefile             |   1 +
> >  .../dts/qcom/apq8016-schneider-hmibsc.dts     | 510 ++++++++++++++++++
> >  2 files changed, 511 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> >
> > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> > index 39889d5f8e12..ad55e52e950b 100644
> > --- a/arch/arm64/boot/dts/qcom/Makefile
> > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > @@ -5,6 +5,7 @@ apq8016-sbc-usb-host-dtbs     := apq8016-sbc.dtb apq8016-sbc-usb-host.dtbo
> >
> >  dtb-$(CONFIG_ARCH_QCOM)      += apq8016-sbc-usb-host.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += apq8016-sbc-d3-camera-mezzanine.dtb
> > +dtb-$(CONFIG_ARCH_QCOM)      += apq8016-schneider-hmibsc.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += apq8039-t2.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += apq8094-sony-xperia-kitakami-karin_windy.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += apq8096-db820c.dtb
> > diff --git a/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> > new file mode 100644
> > index 000000000000..9c79a31a04db
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> > @@ -0,0 +1,510 @@
> > [...]
> > +&blsp_uart1 {
> > +     label = "UART0";
> > +     status = "okay";
> > +};
> > +
> > +&blsp_uart2 {
> > +     label = "UART1";
> > +     status = "okay";
> > +};
> > +
> > +/* Enable CoreSight */
> > +&cti0 { status = "okay"; };
> > +&cti1 { status = "okay"; };
> > +&cti12 { status = "okay"; };
> > +&cti13 { status = "okay"; };
> > +&cti14 { status = "okay"; };
> > +&cti15 { status = "okay"; };
> > +&debug0 { status = "okay"; };
> > +&debug1 { status = "okay"; };
> > +&debug2 { status = "okay"; };
> > +&debug3 { status = "okay"; };
> > +&etf { status = "okay"; };
> > +&etm0 { status = "okay"; };
> > +&etm1 { status = "okay"; };
> > +&etm2 { status = "okay"; };
> > +&etm3 { status = "okay"; };
> > +&etr { status = "okay"; };
> > +&funnel0 { status = "okay"; };
> > +&funnel1 { status = "okay"; };
> > +&replicator { status = "okay"; };
> > +&stm { status = "okay"; };
> > +&tpiu { status = "okay"; };
>
> Nitpick: The &cti0 is in the correct alphabetically ordered place, but
> &replicator, &stm and &tpiu are not.
>
> I know you changed this based on the review comments but I personally
> think it was clearer having this separated as condensed block towards
> the end of the file (where it was before).
>
> The other option would be to put each element individually at the
> correctly ordered position in the file. However, having a single "Enable
> CoreSight" comment for the entire block would then not work anymore
> since all the lines would be interspersed throughout the file.

IMO, having it as a condensed block is a bit more clear such that
people are able to locate overrides easily given their function.
However, there aren't any guidelines for such block orders. So let me
wait to hear back from platform maintainers if they would like
anything to be changed here.

>
> > [...]
> > +&pm8916_codec {
> > +     qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
> > +     qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
> > +     status = "okay";
> > +};
> > +
> > +&pm8916_gpios {
> > +     gpio-line-names =
> > +             "USB_HUB_RESET_N_PM",
> > +             "USB_SW_SEL_PM",
> > +             "NC",
> > +             "NC";
> > +
> > +     usb_hub_reset_pm: usb-hub-reset-pm-state {
> > +             pins = "gpio1";
> > +             function = PMIC_GPIO_FUNC_NORMAL;
> > +
> > +             input-disable;
> > +             output-high;
> > +     };
> > +
> > +     usb_hub_reset_pm_device: usb-hub-reset-pm-device-state {
> > +             pins = "gpio1";
> > +             function = PMIC_GPIO_FUNC_NORMAL;
> > +
> > +             output-low;
> > +     };
> > +
> > +     usb_sw_sel_pm: usb-sw-sel-pm-state {
> > +             pins = "gpio2";
> > +             function = PMIC_GPIO_FUNC_NORMAL;
> > +
> > +             power-source = <PM8916_GPIO_VPH>;
> > +             input-disable;
> > +             output-high;
> > +     };
> > +
> > +     usb_sw_sel_pm_device: usb-sw-sel-pm-device-state {
> > +             pins = "gpio2";
> > +             function = PMIC_GPIO_FUNC_NORMAL;
> > +
> > +             power-source = <PM8916_GPIO_VPH>;
> > +             input-disable;
> > +             output-low;
> > +     };
> > +};
> > +
> > +&pm8916_mpps {
> > +     gpio-line-names =
> > +             "NC",
> > +             "WLAN_LED_CTRL",
> > +             "BT_LED_CTRL",
> > +             "NC";
> > +
> > +     pm8916_mpps_leds: pm8916-mpps-state {
> > +             pins = "mpp2", "mpp3";
> > +             function = "digital";
> > +
> > +             output-low;
> > +     };
> > +};
> > +
> > +&pm8916_resin {
> > +     interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_FALLING>;
>
> What is the goal of overriding the interrupt here? It looks like you are
> changing the interrupt type from IRQ_TYPE_EDGE_BOTH to FALLING. This
> sounds a bit like you want the driver to receive just button release
> events (or just press events, not sure about the polarity). I'm not sure
> if the driver will handle this correctly.

The use-case here is to just act upon button release events and the
driver handles this appropriately. Final use-case of the reset button:

- Short press and release leads to normal Linux reboot.
- Long press for more than 10 sec or so leads to a hard reset.

With IRQ_TYPE_EDGE_BOTH, that's not achievable because just a simple
press leads to Linux reboot.

>
> > +     linux,code = <KEY_POWER>;
> > +     status = "okay";
> > +};
> > +
> > +&pm8916_rpm_regulators {
> > +     pm8916_l17: l17 {
> > +             regulator-min-microvolt = <3300000>;
> > +             regulator-max-microvolt = <3300000>;
> > +     };
> > +};
> > +
> > +&sdhc_1 {
> > +     status = "okay";
> > +};
> > +
> > +&sdhc_2 {
> > +     pinctrl-0 = <&sdc2_default &sdc2_cd_default>;
> > +     pinctrl-1 = <&sdc2_sleep &sdc2_cd_default>;
> > +     pinctrl-names = "default", "sleep";
> > +
> > +     cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
> > +     status = "okay";
> > +};
> > +
> > +&sound {
> > +     pinctrl-0 = <&cdc_pdm_default &sec_mi2s_default>;
> > +     pinctrl-1 = <&cdc_pdm_sleep &sec_mi2s_sleep>;
> > +     pinctrl-names = "default", "sleep";
> > +     model = "HMIBSC";
> > +     audio-routing =
> > +             "AMIC2", "MIC BIAS Internal2",
> > +             "AMIC3", "MIC BIAS External1";
> > +     status = "okay";
> > +
> > +     quaternary-dai-link {
> > +             link-name = "ADV7533";
> > +             cpu {
> > +                     sound-dai = <&lpass MI2S_QUATERNARY>;
> > +             };
> > +             codec {
> > +                     sound-dai = <&adv_bridge 0>;
> > +             };
> > +     };
> > +
> > +     primary-dai-link {
> > +             link-name = "WCD";
> > +             cpu {
> > +                     sound-dai = <&lpass MI2S_PRIMARY>;
> > +             };
> > +             codec {
> > +                     sound-dai = <&lpass_codec 0>, <&pm8916_codec 0>;
> > +             };
> > +     };
> > +
> > +     tertiary-dai-link {
> > +             link-name = "WCD-Capture";
> > +             cpu {
> > +                     sound-dai = <&lpass MI2S_TERTIARY>;
> > +             };
> > +             codec {
> > +                     sound-dai = <&lpass_codec 1>, <&pm8916_codec 1>;
> > +             };
> > +     };
> > +};
> > +
> > +&tlmm {
> > +     pinctrl-0 = <&uart1_mux0_rs232_high &uart1_mux1_rs232_low>;
> > +     pinctrl-names = "default";
> > +
> > +     adv7533_int_active: adv533-int-active-state {
> > +             pins = "gpio31";
> > +             function = "gpio";
> > +
> > +             drive-strength = <16>;
> > +             bias-disable;
> > +     };
> > +
> > +     adv7533_int_suspend: adv7533-int-suspend-state {
> > +             pins = "gpio31";
> > +             function = "gpio";
> > +
> > +             drive-strength = <2>;
> > +             bias-disable;
> > +     };
> > +
> > +     adv7533_switch_active: adv7533-switch-active-state {
> > +             pins = "gpio32";
> > +             function = "gpio";
> > +
> > +             drive-strength = <16>;
> > +             bias-disable;
> > +     };
> > +
> > +     adv7533_switch_suspend: adv7533-switch-suspend-state {
> > +             pins = "gpio32";
> > +             function = "gpio";
> > +
> > +             drive-strength = <2>;
> > +             bias-disable;
> > +     };
> > +
> > +     msm_key_volp_n_default: msm-key-volp-n-default-state {
> > +             pins = "gpio107";
> > +             function = "gpio";
> > +
> > +             drive-strength = <8>;
> > +             bias-pull-up;
> > +     };
> > +
> > +     sdc2_cd_default: sdc2-cd-default-state {
> > +             pins = "gpio38";
> > +             function = "gpio";
> > +             drive-strength = <2>;
> > +             bias-disable;
> > +     };
>
> Nitpick: It would look a bit cleaner to have the empty lines consistent
> in all pinctrl nodes, i.e. either always having an empty line between
> function and drive-strength or never. I think Konrad prefers the more
> compact version without empty line (sadly I'm not sure if this is
> clearly documented anywhere). Same for &pm8916_gpios and mpps.
>

Sure I can remove the empty lines to be consistent with msm8916.dtsi.

> > +
> > +     /*
> > +      * UART1 being the debug console supports various modes of
> > +      * operation (RS-232/485/422) controlled via GPIOs configured
> > +      * mux as follows:
> > +      *
> > +      *   gpio100    gpio99    UART mode
> > +      *   0          0         loopback
> > +      *   0          1         RS-232
> > +      *   1          0         RS-485
> > +      *   1          1         RS-422
> > +      *
> > +      * The default mode configured here is RS-232 mode.
> > +      */
>
> :D
>
> Thanks a lot for making this clear using the table. And also for all the
> other cleanup changes!

Thanks for your review.

-Sumit

>
> Stephan

