Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF24E7AC4C3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 21:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjIWTTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 15:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIWTT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 15:19:29 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43F7193
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 12:19:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-405361bba99so35333035e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 12:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695496761; x=1696101561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z8xXffWx5kVe/4j/cS4SgS21MBCU87jO1sBks4myRec=;
        b=QOVudxrP8jBGrVyaoqCycWtWegWAMqpQn4Jx4ZYahxAYPMLKhUw604xDfscmTLxDUW
         GgoeYozsR3c8IXq3M9qCqo8Jn9ZioDVcadq7mWKccfdgnSPqEqyF9VdZj5VlU8FKu2Wg
         psVYG4tsxp5NRwyDQjEtc7ZPHAiOC73DvyISyotNzJQvM3nTpjkD+xzZLohqjchRPCd1
         QikPjlUKnznQ8hFFkj6OFFRNKAZbHo5VijO+tjZFEtXpLRE6HQsmIYViUu4puPHUNY4b
         EQL8+zIttb/tcY5IM3iQGZjoVdlEy/jlEknyvug5TAcVMd2pymO0qEPHZWRS2MALMbh8
         161A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695496761; x=1696101561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8xXffWx5kVe/4j/cS4SgS21MBCU87jO1sBks4myRec=;
        b=iaA50VycQMyXB33amjEtGZM+oDTC87b7q4BDiWNN6kay1afqL/kSsiRIK3Vu4DJtGw
         Hw9vgrRvlKPr2hFvoidnehW3yjIQ8e9OkHgsZYHjOOSbIuzEX/x2M1wYIlvllEuWJu0B
         kVFBJ6wUmvFrBDZrE9i5aPnh4vvIMn0wO1s0bdlVcSOSNlkmPLgrghD/1z/tHwK49gIq
         jwDbA+MVEN9rp0F717Yw1J8pBEgyTGuBR16JwlJYLA2b9LonzdO0Zji/nmsHjzYyFq8x
         QqgTm+aVPD8QJh6QK/i22LmgBM4b71V0I4UWMstnNja7n74PBk5zDZlXhu5187YHWVyl
         +bJg==
X-Gm-Message-State: AOJu0YzOte6I/IIKfn10gp0fJwLlSwUiNgasZHtIU6E1enygM7mKDeM0
        BeXU7K/TJheL9KGm4Nsb+cydmw==
X-Google-Smtp-Source: AGHT+IFh4AYqzmkpbkxYp2xkj0c0iNGkqPrGZTygHfEDvoelBIFMh/S2eXgEqZe3+Mv/8+lWyX8ycg==
X-Received: by 2002:a1c:720c:0:b0:401:38dc:891c with SMTP id n12-20020a1c720c000000b0040138dc891cmr2333405wmc.5.1695496761269;
        Sat, 23 Sep 2023 12:19:21 -0700 (PDT)
Received: from [10.73.151.44] ([188.111.42.10])
        by smtp.gmail.com with ESMTPSA id k12-20020a7bc40c000000b003fc04d13242sm10858665wmi.0.2023.09.23.12.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 12:19:20 -0700 (PDT)
Message-ID: <29b774d4-3759-4b49-926e-551c92d3f8c7@linaro.org>
Date:   Sat, 23 Sep 2023 22:19:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: Add USB3 and PHY support
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1695383434-24705-1-git-send-email-quic_rohiagar@quicinc.com>
 <1695383434-24705-3-git-send-email-quic_rohiagar@quicinc.com>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1695383434-24705-3-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2023 14:50, Rohit Agarwal wrote:
> Add devicetree nodes for enabling USB3 controller, Qcom QMP PHY and
> HS PHY on SDX75.

Please fix the subject to mention the platform.

Other than that, LGTM.

> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sdx75.dtsi | 116 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 116 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
> index dd3a525..c44cdd1 100644
> --- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
> @@ -473,6 +473,47 @@
>   			};
>   		};
>   
> +		usb_hsphy: phy@ff4000 {
> +			compatible = "qcom,sdx75-snps-eusb2-phy", "qcom,sm8550-snps-eusb2-phy";
> +			reg = <0x0 0x00ff4000 0x0 0x154>;
> +			#phy-cells = <0>;
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "ref";
> +
> +			resets = <&gcc GCC_QUSB2PHY_BCR>;
> +
> +			status = "disabled";
> +		};
> +
> +		usb_qmpphy: phy@ff6000 {
> +			compatible = "qcom,sdx75-qmp-usb3-uni-phy";
> +			reg = <0x0 0x00ff6000 0x0 0x2000>;
> +
> +			clocks = <&gcc GCC_USB3_PHY_AUX_CLK>,
> +				 <&gcc GCC_USB2_CLKREF_EN>,
> +				 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
> +				 <&gcc GCC_USB3_PHY_PIPE_CLK>;
> +			clock-names = "aux",
> +				      "ref",
> +				      "cfg_ahb",
> +				      "pipe";
> +
> +			power-domains = <&gcc GCC_USB3_PHY_GDSC>;
> +
> +			resets = <&gcc GCC_USB3_PHY_BCR>,
> +				 <&gcc GCC_USB3PHY_PHY_BCR>;
> +			reset-names = "phy",
> +				      "phy_phy";
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "usb3_uni_phy_pipe_clk_src";
> +
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
>   		system_noc: interconnect@1640000 {
>   			compatible = "qcom,sdx75-system-noc";
>   			reg = <0x0 0x01640000 0x0 0x4b400>;
> @@ -493,6 +534,81 @@
>   			#hwlock-cells = <1>;
>   		};
>   
> +		usb: usb@a6f8800 {
> +			compatible = "qcom,sdx75-dwc3", "qcom,dwc3";
> +			reg = <0x0 0x0a6f8800 0x0 0x400>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_USB30_SLV_AHB_CLK>,
> +				 <&gcc GCC_USB30_MASTER_CLK>,
> +				 <&gcc GCC_USB30_MSTR_AXI_CLK>,
> +				 <&gcc GCC_USB30_SLEEP_CLK>,
> +				 <&gcc GCC_USB30_MOCK_UTMI_CLK>;
> +			clock-names = "cfg_noc",
> +				      "core",
> +				      "iface",
> +				      "sleep",
> +				      "mock_utmi";
> +
> +			assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
> +					  <&gcc GCC_USB30_MASTER_CLK>;
> +			assigned-clock-rates = <19200000>, <200000000>;
> +
> +			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&pdc 9 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 10 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "hs_phy_irq",
> +					  "ss_phy_irq",
> +					  "dm_hs_phy_irq",
> +					  "dp_hs_phy_irq";
> +
> +			power-domains = <&gcc GCC_USB30_GDSC>;
> +
> +			resets = <&gcc GCC_USB30_BCR>;
> +
> +			interconnects = <&system_noc MASTER_USB3_0 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_USB3 0>;
> +			interconnect-names = "usb-ddr",
> +					     "apps-usb";
> +
> +			status = "disabled";
> +
> +			usb_dwc3: usb@a600000 {
> +				compatible = "snps,dwc3";
> +				reg = <0x0 0x0a600000 0x0 0xcd00>;
> +				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> +				iommus = <&apps_smmu 0x80 0x0>;
> +				snps,dis_u2_susphy_quirk;
> +				snps,dis_enblslpm_quirk;
> +				phys = <&usb_hsphy>,
> +				       <&usb_qmpphy>;
> +				phy-names = "usb2-phy",
> +					    "usb3-phy";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +
> +						usb_1_dwc3_hs: endpoint {
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +
> +						usb_1_dwc3_ss: endpoint {
> +						};
> +					};
> +				};
> +			};
> +		};
> +
>   		pdc: interrupt-controller@b220000 {
>   			compatible = "qcom,sdx75-pdc", "qcom,pdc";
>   			reg = <0x0 0xb220000 0x0 0x30000>,

-- 
With best wishes
Dmitry

