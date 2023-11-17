Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FA57EF05F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344735AbjKQK3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbjKQK3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:29:45 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F83D52
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:29:41 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50a6ff9881fso2659917e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 02:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700216979; x=1700821779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BoEox1kgRFqAIJhjXGjp6oBa+sl9y3mmkTtvH+PZDss=;
        b=LsCpPG7Lj1m4hzP6hOBXiHcYP8euJZn6kUNhXs2VlwvmA6jB8S48EBvrTtNmB22dIQ
         5n89fbEe37UiwD6/etqulKhAWoVnsrEjL/CEQQk2NQiy7OsDvdLK3nv4E20fHSolDJZM
         UY+Aotzl1uDbfAqxmYcN3t+wTJRE0yWVE+7cFSpr6EbehgL/LZaEL8UoPWZ5GgSI6SFh
         xBp55OH3pkuWVZMO+IBdtdQYQzXT32TjNWJ4Ku7BvyL/OLelny73ENotBgZ45nHn2Ypd
         2yn4YiYxNl4Bu1T3GQKrwhkqoUYnzbk/QYAlMEl56mSyD5mGuPE4s1ak9QeoUs7suz7G
         FaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700216979; x=1700821779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BoEox1kgRFqAIJhjXGjp6oBa+sl9y3mmkTtvH+PZDss=;
        b=NL4aTEkzbFwEVKl/CZ/O0wisdM2bw4yxqRo58UxsQ3Uq2+2RVXBQtXB1angMA3n/WR
         RDTfRI7CeljHhC4T1ldEa2WrI58ljqQ/+iFj8RoUpcwiYYNoSyX0u4sfhRO10khQhX7t
         2jmwdd+HjP49tVa7CUQ390ultXKw1e4hRXogkbe92fW/lVYUwzAU8gjWR3/1o4lzGqLX
         qdbb0hxEllZsWFACr9QdwZ5QaoTVvBosnKdd/j2UtZmAl3XexviWc3f/KJxCFSXqHWEj
         C4DuXciON/fOGFV4/T3f+fZqRaYThT4sWJ+ySRBtunfeYBOqnv90X9DDc4M4R6e8yre0
         V2Wg==
X-Gm-Message-State: AOJu0YzvKgW3Qb4SXYXEtZOhD3973Tdg/tMZwotp/gThakRlpYZmD3E9
        v1Lqm74u8X5ymdExWrPFBrILXQ==
X-Google-Smtp-Source: AGHT+IGT/UprG83MbsSA21snmE3q243sJytU2zp9hpuCBZ/SGQrf1LgXnlEPx71KcgssY0H1xYU1Bw==
X-Received: by 2002:a05:6512:21cd:b0:509:faef:82f1 with SMTP id d13-20020a05651221cd00b00509faef82f1mr11625958lft.26.1700216979660;
        Fri, 17 Nov 2023 02:29:39 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id f16-20020a19ae10000000b005041a71237asm182106lfc.111.2023.11.17.02.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 02:29:39 -0800 (PST)
Message-ID: <37a3a407-07e7-49d8-bbce-b1dac8cfcf5a@linaro.org>
Date:   Fri, 17 Nov 2023 12:29:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] arm64: dts: qcom: sm8550-aim300: add PCIe0
Content-Language: en-GB
To:     Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, -cc=kernel@quicinc.com
References: <20231117101817.4401-1-quic_tengfan@quicinc.com>
 <20231117101817.4401-8-quic_tengfan@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231117101817.4401-8-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2023 12:18, Tengfei Fan wrote:
> Add PCIe0 nodes used with WCN7851 device.  The PCIe1 is not connected,
> thus skip pcie_1_phy_aux_clk input clock to GCC.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sm8550-aim300.dts | 32 ++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-aim300.dts b/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
> index 202b979da8ca..3aca0a433a00 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
> @@ -393,6 +393,38 @@
>   	};
>   };
>   
> +&gcc {
> +	clocks = <&bi_tcxo_div2>, <&sleep_clk>,
> +		 <&pcie0_phy>,
> +		 <&pcie1_phy>,
> +		 <0>,
> +		 <&ufs_mem_phy 0>,
> +		 <&ufs_mem_phy 1>,
> +		 <&ufs_mem_phy 2>,
> +		 <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
> +};

NAK, this should go to sm8550.dtsi unless there is a good reason.

> +
> +&pcie_1_phy_aux_clk {
> +	status = "disabled";
> +};
> +
> +&pcie0 {
> +	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
> +
> +	pinctrl-0 = <&pcie0_default_state>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +&pcie0_phy {
> +	vdda-phy-supply = <&vreg_l1e_0p88>;
> +	vdda-pll-supply = <&vreg_l3e_1p2>;
> +
> +	status = "okay";
> +};
> +
>   &pm8550b_eusb2_repeater {
>   	vdd18-supply = <&vreg_l15b_1p8>;
>   	vdd3-supply = <&vreg_l5b_3p1>;

-- 
With best wishes
Dmitry

