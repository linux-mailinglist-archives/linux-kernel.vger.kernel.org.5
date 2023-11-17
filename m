Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D41A7EF06C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345922AbjKQKa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345924AbjKQKaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:30:55 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB2BD6A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:30:50 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5094727fa67so2583720e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700217049; x=1700821849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wc+G2BXYXEPt9fQTDN8l2bnR2Ld4/4FL6ZOxBvBX3jM=;
        b=WcMGIUoNBI418br/H9qyQN6W8kLCKXnqcIEDbMqNOezO6PgiBBuzZGZH2IlxFOe6+p
         twN03RLdrKQDfuPADl6hzcU1QbCv+ABdwsh00tX6VO2gCNVMHOTsvUV1gkchdi25k/Z9
         V/4fhel3uSsthujgIbe25WgBdCM8gXbETFHc1YjXFibT1vJuUH0zUfXyjqToX/7xY7el
         fJ32gUpWqXp2VT6DR9XBudh1edGNZaBkxxa02EQBwrw6mvekh9MIJbpWMTcoa5ORaWCE
         /B8g1f68juXoyZWs+SAahu2//BFBgyppZhMl6HP9+MepF7l+B22T4A8btw05lFeBva/O
         yfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700217049; x=1700821849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wc+G2BXYXEPt9fQTDN8l2bnR2Ld4/4FL6ZOxBvBX3jM=;
        b=WvAtC4ahZjwh84/5IaK1j0cFwW1cpcnBAX/SB8WrdK6FU2XOaZrMsNhHOxOdovUG7N
         VT8KSSLpeLycNNMiX6jm30DlPmQXon/VGNsiLshgS6ZITqQAuRN9TxEwKntSZBp+2+L3
         7U8gP38k/TV28CEnOj0ewPDOoMPsrrG9Ct00NH02imkCEq86DIGQk8NhfXGQBju+Mp4B
         NbeKwG/j104MM2CGR3r+QdVBKWq2XPDyWoAqa9osnDAuB3buH9dAc8HDFcfx8qifxACd
         PTFBFkDxVHAD80LKg+5DCnAXdb1IxLufX9CK1bMvm5kRn3KCWTApmLQM+kQ97zAY5NmS
         rueg==
X-Gm-Message-State: AOJu0YzE2A2QzR9XPpyBCUh+3a1UDXwz94AoLXE8Cq9Cw26DBHsnnFtF
        58LVheUuHwQ7vTS7I+1yKBmDcw==
X-Google-Smtp-Source: AGHT+IF8EgoN+6Ul76S0+HqO+Ku3iKGOfRbkNAN8caHPSacEHxyf71UwWQIUrpjmlQJxFh4HabLQrg==
X-Received: by 2002:a05:6512:1381:b0:507:98d0:bec4 with SMTP id fc1-20020a056512138100b0050798d0bec4mr5062456lfb.54.1700217048809;
        Fri, 17 Nov 2023 02:30:48 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id f16-20020a19ae10000000b005041a71237asm182106lfc.111.2023.11.17.02.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 02:30:48 -0800 (PST)
Message-ID: <a1672479-ca5f-4d96-8583-014d3adfc37c@linaro.org>
Date:   Fri, 17 Nov 2023 12:30:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] arm64: dts: qcom: sm8550-aim300: add display and
 panel
Content-Language: en-GB
To:     Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, -cc=kernel@quicinc.com
References: <20231117101817.4401-1-quic_tengfan@quicinc.com>
 <20231117101817.4401-11-quic_tengfan@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231117101817.4401-11-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2023 12:18, Tengfei Fan wrote:
> Enable Display Subsystem with Visionox VTDR6130 Panel.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sm8550-aim300.dts | 68 ++++++++++++++++++++++
>   1 file changed, 68 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-aim300.dts b/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
> index cafddc02aef0..9b568ae9581e 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
> @@ -432,6 +432,46 @@
>   		 <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
>   };
>   
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_dsi0 {
> +	vdda-supply = <&vreg_l3e_1p2>;
> +	status = "okay";
> +
> +	panel@0 {
> +		compatible = "visionox,vtdr6130";
> +		reg = <0>;
> +
> +		pinctrl-0 = <&sde_dsi_active>, <&sde_te_active>;
> +		pinctrl-1 = <&sde_dsi_suspend>, <&sde_te_suspend>;
> +		pinctrl-names = "default", "sleep";
> +
> +		reset-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
> +
> +		vci-supply = <&vreg_l13b_3p0>;
> +		vdd-supply = <&vreg_l11b_1p2>;
> +		vddio-supply = <&vreg_l12b_1p8>;
> +
> +		port {
> +			panel0_in: endpoint {
> +				remote-endpoint = <&mdss_dsi0_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdss_dsi0_out {
> +	remote-endpoint = <&panel0_in>;
> +	data-lanes = <0 1 2 3>;
> +};
> +
> +&mdss_dsi0_phy {
> +	vdds-supply = <&vreg_l1e_0p88>;
> +	status = "okay";
> +};
> +
>   &pcie_1_phy_aux_clk {
>   	status = "disabled";
>   };
> @@ -533,6 +573,34 @@
>   &tlmm {
>   	gpio-reserved-ranges = <32 8>;
>   
> +	sde_dsi_active: sde-dsi-active-state {

sde is the name from the other kernel branch. Drop it please. Just 'dsi' 
is enough.

> +		pins = "gpio133";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-disable;
> +	};
> +
> +	sde_dsi_suspend: sde-dsi-suspend-state {
> +		pins = "gpio133";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	sde_te_active: sde-te-active-state {
> +		pins = "gpio86";
> +		function = "mdp_vsync";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	sde_te_suspend: sde-te-suspend-state {
> +		pins = "gpio86";
> +		function = "mdp_vsync";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
>   	wcd_default: wcd-reset-n-active-state {
>   		pins = "gpio108";
>   		function = "gpio";

-- 
With best wishes
Dmitry

