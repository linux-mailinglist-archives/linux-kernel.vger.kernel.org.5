Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711BA7EF088
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345913AbjKQKdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345923AbjKQKc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:32:58 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D741AD
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:32:54 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50a938dda08so2629124e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700217172; x=1700821972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w+99jgvIZKUzur07v/TVxDxwMZ3N1VRCZ1WvScDSaRk=;
        b=XLzwqEBSBeX0f1aggVVCdXIvFxzG+e6AFtR/h/gTGY/olXcDCgMaBkbySf0HimKJD3
         3dTLSVxPePh3zGIO+ZSCeHX0K9KkN2rxmIot5bm5rmk8XQ8lyIv0jOSgLqh15FGR3e7z
         mFV7cKSBIVmNk+KJ4oeJqnVfICdBEn7C8JThagRiT3HmiSZHVP8NVOxJ/ffhop28nIKD
         wi/KWHa2MIwWFd0m9y6+IdA3VI9OSwV71TOWO5pNJbwRqTWmwqcllJ9X2Md046+8Krxf
         RUjk/eamU/RYXmLGtnOvdXJTthYHd2VlsO6fkgH+DpalT538aXQ9isSzluSTC8eY9Jcb
         8G0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700217172; x=1700821972;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w+99jgvIZKUzur07v/TVxDxwMZ3N1VRCZ1WvScDSaRk=;
        b=EoT0gs7lT2YN/YY7sanyIm5pYNlwiinb+OU6fPECNEFlz+v7R4IfJ0hrJ0qY1qK1sd
         clEpXY6KECkyv13toj3Y+vicTxdaBba2n7eM8ZTza/W7Wz32mceHpNOdMRAXWzZhWt0r
         O4zmpI8/nw3ESu0/2B+8gLt+caF8SFOtKMChbOU66tZtfi44UDxbaGK5y94Cl9Lmejuz
         5TF+H1I4vBLotRJzmdkuyBjNHVIPTtz2rWKGSTcV9ospQudPGh0uzzle18fTyWVkaJDN
         CcIeWWzvS5p+9yj/ts6zJ6NLxcR0aCBOfqSxSL3ZEPQDiz44P3dnP3blvuWJcIov2Lk2
         Xe1Q==
X-Gm-Message-State: AOJu0YySfmOsqyRxIzRimqz0YfN1uiipe7xJ4yn7nCyQSF9I1tN9ep5n
        xklOadw53slm/3VLifK7QEqySA==
X-Google-Smtp-Source: AGHT+IEHohEcVycUzd2D8YilrfUOvKzArtQuKnq0RXNCSNivWeCz8/fOITaeCed3KUqAXiAar81DPA==
X-Received: by 2002:ac2:5216:0:b0:507:aaa4:e3b3 with SMTP id a22-20020ac25216000000b00507aaa4e3b3mr12278491lfl.50.1700217172448;
        Fri, 17 Nov 2023 02:32:52 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id z2-20020a19f702000000b00509d0c5a8bcsm180931lfe.295.2023.11.17.02.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 02:32:51 -0800 (PST)
Message-ID: <e3e27fec-8ab9-4331-a5aa-2958dd630b11@linaro.org>
Date:   Fri, 17 Nov 2023 12:32:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] arm64: dts: qcom: sm8550-aim300: add pmic glink
 port/endpoints
Content-Language: en-GB
To:     Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, -cc=kernel@quicinc.com
References: <20231117101817.4401-1-quic_tengfan@quicinc.com>
 <20231117101817.4401-16-quic_tengfan@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231117101817.4401-16-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2023 12:18, Tengfei Fan wrote:
> Add nodes to support Type-C USB/DP functionality.
> 
> On this platform, a Type-C redriver is added to the SuperSpeed graph.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sm8550-aim300.dts | 88 +++++++++++++++++++++-
>   1 file changed, 87 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-aim300.dts b/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
> index 6dc3040b9f76..f3c558dd40f1 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
> @@ -100,7 +100,15 @@
>   					reg = <1>;
>   
>   					pmic_glink_ss_in: endpoint {
> -						remote-endpoint = <&usb_1_dwc3_ss>;
> +						remote-endpoint = <&redriver_ss_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					pmic_glink_sbu: endpoint {
> +						remote-endpoint = <&fsa4480_sbu_mux>;
>   					};
>   				};
>   			};
> @@ -519,6 +527,62 @@
>   	};
>   };
>   
> +&i2c_master_hub_0 {
> +	status = "okay";
> +};
> +
> +&i2c_hub_2 {
> +	status = "okay";
> +
> +	typec-mux@42 {
> +		compatible = "fcs,fsa4480";
> +		reg = <0x42>;
> +
> +		vcc-supply = <&vreg_bob1>;
> +
> +		mode-switch;
> +		orientation-switch;
> +
> +		port {
> +			fsa4480_sbu_mux: endpoint {
> +				remote-endpoint = <&pmic_glink_sbu>;
> +			};
> +		};
> +	};
> +
> +	typec-retimer@1c {
> +		compatible = "onnn,nb7vpq904m";
> +		reg = <0x1c>;
> +
> +		vcc-supply = <&vreg_l15b_1p8>;
> +
> +		orientation-switch;
> +		retimer-switch;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				redriver_ss_out: endpoint {
> +					remote-endpoint = <&pmic_glink_ss_in>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +
> +				redriver_ss_in: endpoint {
> +					data-lanes = <3 2 1 0>;
> +					remote-endpoint = <&usb_dp_qmpphy_out>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
>   &gcc {
>   	clocks = <&bi_tcxo_div2>, <&sleep_clk>,
>   		 <&pcie0_phy>,
> @@ -552,6 +616,16 @@
>   	status = "okay";
>   };
>   
> +&mdss_dp0 {
> +	status = "okay";
> +};
> +
> +&mdss_dp0_out {
> +	data-lanes = <0 1>;

Why? Are you really limited to two lanes for DP by the hardware?

> +	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
> +};
> +
> +
>   &mdss_dsi0 {
>   	vdda-supply = <&vreg_l3e_1p2>;
>   	status = "okay";
> @@ -861,6 +935,18 @@
>   	status = "okay";
>   };
>   
> +&usb_dp_qmpphy_dp_in {
> +	remote-endpoint = <&mdss_dp0_out>;
> +};
> +
> +&usb_dp_qmpphy_out {
> +	remote-endpoint = <&redriver_ss_in>;
> +};
> +
> +&usb_dp_qmpphy_usb_ss_in {
> +	remote-endpoint = <&usb_1_dwc3_ss>;
> +};
> +
>   &xo_board {
>   	clock-frequency = <76800000>;
>   };

-- 
With best wishes
Dmitry

