Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24598758840
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjGRWJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjGRWJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:09:01 -0400
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B4A1FF6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:08:34 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4f954d7309fso222208e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689717778; x=1690322578;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rNDKOzlYPxGuMs2KncsT0nwhwoFvuzBBjJp1G8pPnVI=;
        b=vuZIUV0MiW49B1TR2RK+zQrigyap1MzpeYpQr5n+DE/3s2R6OB3VXg+eUeNSA2wqwu
         dYTjRPR2v0yrtgdEhzKD5hpgEf2V5Cub4MA/Nkq/vEBwf/2dss24wWvT4aMK2kZsls1d
         5vJfVRBtNE9MHqGHkqxv3k9wfZ0PwOXygRTOQ5JIklydupo/LhD8XiA3VK1q9hYeue6t
         tKLjWTrl2D88zC+ihLPYVIwwHKnzx1eMR7zBKHU4MVHq+XJsO9HF5/3mGE9tRa+31Ifp
         hIypLS+CHYwBfwj8bDXVmkoQNxZMDkZCFZRsuCfhmbBl270ihN+STJzxACCADrNlhANs
         cT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717778; x=1690322578;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNDKOzlYPxGuMs2KncsT0nwhwoFvuzBBjJp1G8pPnVI=;
        b=cuJpsxoNUrJWZbvwZPKh+mqp2GWMS2EqquTafL/GE8RDY7o1HyN2bum4ousI8QxWIn
         picHHnGqd4aKS7yIKMyp/6DWZSsZHD87MeL+u5fwZlLDXdH5CvkMrzUNb96MhcaLf8EE
         mD53xEwXu26uuC2Wj4fUtzCOIk0+HSHrkDfw0zZZczoHP87RLhpSjtsWokLApOn+AKLN
         NzpGKe9aS8x7vPaEiZBu3s9x5ymyM+byd+JyehhR1tfT4oj/4fFV9jFgg6nUEHth3WdG
         E31W+5vLTxKi0VA/wMDrZM/Gvxa2j73Gxy7XUAiP/LU1kcT7lfHAGqVU383kQZecuOna
         jHAQ==
X-Gm-Message-State: ABy/qLYtSBXBrLgncjkxpQrTiqI4tXg3hw4kGmatf8e4H9yhe0GNCRJx
        mfhzwmo7f+eACqInFGnKgl5zGw==
X-Google-Smtp-Source: APBJJlEzzO92pAca9uOAcmF9Oxp3Fq4quU2D8QWHbF3UNYaUO4bu8i3x2boSfuxbQYAJ/7rubYq1CA==
X-Received: by 2002:a05:6512:3da4:b0:4fd:c8fb:eb71 with SMTP id k36-20020a0565123da400b004fdc8fbeb71mr132296lfv.11.1689717778055;
        Tue, 18 Jul 2023 15:02:58 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id f25-20020ac251b9000000b004eb0c51780bsm636973lfk.29.2023.07.18.15.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 15:02:57 -0700 (PDT)
Message-ID: <149d15e6-4995-8ff6-5191-77783c3dedb8@linaro.org>
Date:   Wed, 19 Jul 2023 01:02:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 02/15] arm64: dts: qcom: sm6125: Sort spmi_bus node
 numerically by reg
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
References: <20230718-sm6125-dpu-v3-0-6c5a56e99820@somainline.org>
 <20230718-sm6125-dpu-v3-2-6c5a56e99820@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230718-sm6125-dpu-v3-2-6c5a56e99820@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 00:24, Marijn Suijten wrote:
> This node has always resided in the wrong spot, making it somewhat
> harder to contribute new node entries while maintaining proper sorting
> around it.  Move the node up to sit after hsusb_phy1 where it maintains
> proper numerical sorting on the (first of its many) reg address
> property.
> 
> Fixes: cff4bbaf2a2d ("arm64: dts: qcom: Add support for SM6125")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   arch/arm64/boot/dts/qcom/sm6125.dtsi | 38 ++++++++++++++++++------------------
>   1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index 6937c7ebdb81..cfd0901d4555 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -684,6 +684,24 @@ hsusb_phy1: phy@1613000 {
>   			status = "disabled";
>   		};
>   
> +		spmi_bus: spmi@1c40000 {
> +			compatible = "qcom,spmi-pmic-arb";
> +			reg = <0x01c40000 0x1100>,
> +			      <0x01e00000 0x2000000>,
> +			      <0x03e00000 0x100000>,
> +			      <0x03f00000 0xa0000>,
> +			      <0x01c0a000 0x26000>;
> +			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
> +			interrupt-names = "periph_irq";
> +			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
> +			qcom,ee = <0>;
> +			qcom,channel = <0>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +			interrupt-controller;
> +			#interrupt-cells = <4>;
> +		};
> +
>   		rpm_msg_ram: sram@45f0000 {
>   			compatible = "qcom,rpm-msg-ram";
>   			reg = <0x045f0000 0x7000>;
> @@ -1189,27 +1207,9 @@ sram@4690000 {
>   			reg = <0x04690000 0x10000>;
>   		};
>   
> -		spmi_bus: spmi@1c40000 {
> -			compatible = "qcom,spmi-pmic-arb";
> -			reg = <0x01c40000 0x1100>,
> -			      <0x01e00000 0x2000000>,
> -			      <0x03e00000 0x100000>,
> -			      <0x03f00000 0xa0000>,
> -			      <0x01c0a000 0x26000>;
> -			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
> -			interrupt-names = "periph_irq";
> -			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
> -			qcom,ee = <0>;
> -			qcom,channel = <0>;
> -			#address-cells = <2>;
> -			#size-cells = <0>;
> -			interrupt-controller;
> -			#interrupt-cells = <4>;
> -		};
> -
>   		apps_smmu: iommu@c600000 {
>   			compatible = "qcom,sm6125-smmu-500", "qcom,smmu-500", "arm,mmu-500";
> -			reg = <0xc600000 0x80000>;
> +			reg = <0x0c600000 0x80000>;

Irrelevant, please split.

>   			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
> 

-- 
With best wishes
Dmitry

