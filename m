Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396A9803399
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjLDM5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbjLDM5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:57:01 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1804D2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:57:06 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40a4848c6e1so45582615e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701694625; x=1702299425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQxUoSlgKQDc8MMwqLTcF6hSga+T/gfF/ZomSBCTcmI=;
        b=KbgyiyifcM8zvA9NCqCQ1IiP96m5rwlPWjyvZRZSIK4jDTWflvYmZE9SosbmZnnpB3
         fW6kxOy+yEFlJgTBM6f75alq9kQlmE+meZCOGNKRRq6sPOLvaMEU66BbtFrsdqojA3Wn
         UgRgXIDhFYc2Fo+fwbl7gfFRJmL5lvv/XoeL3FxLWlsLo3itspH8D1AHIYOH33McN/u7
         TZ5jH4iMJPiGMZp68Rjdk93d8BpsDAe9UnMrzrXAN/UTsPdcEoKVFlCn2DdnWwl6mhvK
         q9HSteKa7kTdQWaix5HWbvVZIYdF4/HCo9RjrVhi6ynCp8eWbl3burOiasUUeDd58I1d
         JV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701694625; x=1702299425;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OQxUoSlgKQDc8MMwqLTcF6hSga+T/gfF/ZomSBCTcmI=;
        b=WUA5qN/NgqVEMRktvBaDrueF134c5Pyp9LziAGxXjdSpyl7UnJe2THxeHTJ6OeLHeH
         8y7zYLSRVdAOvVAd5oZyrLBYL+xhTR3UFwPqmlId9Ueto8gnQPfYd8m02dgboprOT+I/
         4m/lyepJb8i6yMmxDIBQ4i9/8JdriVreDLzObUQ8lcwRXvo8432+vq+A8oH22l8bf3qq
         kjkWWxHAyyfD3tz12jO55f64QMBY/LDiEWmeIfVbSxdVYe3YrBI16kLHqYTjCBgapv4U
         vZNDUVUaAbwA8F+q3AxVI3Xk/AAIUnf+ITJq+3uWq+P82OfOP7GLFxJa3C4MQfmKzLFi
         1Z6A==
X-Gm-Message-State: AOJu0YzMSOK1gvmgGFRdYFm9ltkmusYGNM051YFu11MY+WwTvv4PLj06
        C0Ggyo9pO+3xvk7L+CPlu4KHVA==
X-Google-Smtp-Source: AGHT+IGWMvIc+OEdNJr1CsIP8UbVai4BWUfMDlunsOUJC+LgT5h4NJ8q3+IWPo/TPzxR+lv+Bs+jEg==
X-Received: by 2002:a05:600c:4588:b0:40b:5e21:bdb5 with SMTP id r8-20020a05600c458800b0040b5e21bdb5mr2303118wmo.68.1701694625398;
        Mon, 04 Dec 2023 04:57:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:58:12b5:777b:9d17? ([2a01:e0a:982:cbb0:58:12b5:777b:9d17])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c501000b00407b93d8085sm18677041wmr.27.2023.12.04.04.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 04:57:04 -0800 (PST)
Message-ID: <b52212f4-39a9-474c-87ea-72f6d08a8388@linaro.org>
Date:   Mon, 4 Dec 2023 13:57:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: sm8550: Add GPU nodes
Content-Language: en-US, fr
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20231127-topic-a7xx_dt-v2-0-2a437588e563@linaro.org>
 <20231127-topic-a7xx_dt-v2-3-2a437588e563@linaro.org>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20231127-topic-a7xx_dt-v2-3-2a437588e563@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2023 13:55, Konrad Dybcio wrote:
> Add the required nodes to support the A740 GPU.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 166 +++++++++++++++++++++++++++++++++++
>   1 file changed, 166 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 7bafb3d88d69..8f59085c804d 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -1984,6 +1984,128 @@ tcsr: clock-controller@1fc0000 {
>   			#reset-cells = <1>;
>   		};
>   
> +		gpu: gpu@3d00000 {
> +			compatible = "qcom,adreno-43050a01", "qcom,adreno";
> +			reg = <0x0 0x03d00000 0x0 0x40000>,
> +			      <0x0 0x03d9e000 0x0 0x1000>,
> +			      <0x0 0x03d61000 0x0 0x800>;
> +			reg-names = "kgsl_3d0_reg_memory",
> +				    "cx_mem",
> +				    "cx_dbgc";
> +
> +			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			iommus = <&adreno_smmu 0 0x0>,
> +				 <&adreno_smmu 1 0x0>;
> +
> +			operating-points-v2 = <&gpu_opp_table>;
> +
> +			qcom,gmu = <&gmu>;
> +
> +			status = "disabled";
> +
> +			zap-shader {
> +				memory-region = <&gpu_micro_code_mem>;
> +			};
> +
> +			/* Speedbin needs more work on A740+, keep only lower freqs */
> +			gpu_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-680000000 {
> +					opp-hz = /bits/ 64 <680000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> +				};
> +
> +				opp-615000000 {
> +					opp-hz = /bits/ 64 <615000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
> +				};
> +
> +				opp-550000000 {
> +					opp-hz = /bits/ 64 <550000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> +				};
> +
> +				opp-475000000 {
> +					opp-hz = /bits/ 64 <475000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L1>;
> +				};
> +
> +				opp-401000000 {
> +					opp-hz = /bits/ 64 <401000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +				};
> +
> +				opp-348000000 {
> +					opp-hz = /bits/ 64 <348000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0>;
> +				};
> +
> +				opp-295000000 {
> +					opp-hz = /bits/ 64 <295000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
> +				};
> +
> +				opp-220000000 {
> +					opp-hz = /bits/ 64 <220000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
> +				};
> +			};
> +		};
> +
> +		gmu: gmu@3d6a000 {
> +			compatible = "qcom,adreno-gmu-740.1", "qcom,adreno-gmu";
> +			reg = <0x0 0x03d6a000 0x0 0x35000>,
> +			      <0x0 0x03d50000 0x0 0x10000>,
> +			      <0x0 0x0b280000 0x0 0x10000>;
> +			reg-names = "gmu", "rscc", "gmu_pdc";
> +
> +			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hfi", "gmu";
> +
> +			clocks = <&gpucc GPU_CC_AHB_CLK>,
> +				 <&gpucc GPU_CC_CX_GMU_CLK>,
> +				 <&gpucc GPU_CC_CXO_CLK>,
> +				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
> +				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
> +				 <&gpucc GPU_CC_HUB_CX_INT_CLK>,
> +				 <&gpucc GPU_CC_DEMET_CLK>;
> +			clock-names = "ahb",
> +				      "gmu",
> +				      "cxo",
> +				      "axi",
> +				      "memnoc",
> +				      "hub",
> +				      "demet";
> +
> +			power-domains = <&gpucc GPU_CC_CX_GDSC>,
> +					<&gpucc GPU_CC_GX_GDSC>;
> +			power-domain-names = "cx",
> +					     "gx";
> +
> +			iommus = <&adreno_smmu 5 0x0>;
> +
> +			qcom,qmp = <&aoss_qmp>;
> +
> +			operating-points-v2 = <&gmu_opp_table>;
> +
> +			gmu_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-500000000 {
> +					opp-hz = /bits/ 64 <500000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> +				};
> +
> +				opp-200000000 {
> +					opp-hz = /bits/ 64 <200000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +				};
> +			};
> +		};
> +
>   		gpucc: clock-controller@3d90000 {
>   			compatible = "qcom,sm8550-gpucc";
>   			reg = <0 0x03d90000 0 0xa000>;
> @@ -1995,6 +2117,50 @@ gpucc: clock-controller@3d90000 {
>   			#power-domain-cells = <1>;
>   		};
>   
> +		adreno_smmu: iommu@3da0000 {
> +			compatible = "qcom,sm8550-smmu-500", "qcom,adreno-smmu",
> +				     "qcom,smmu-500", "arm,mmu-500";
> +			reg = <0x0 0x03da0000 0x0 0x40000>;
> +			#iommu-cells = <2>;
> +			#global-interrupts = <1>;
> +			interrupts = <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 677 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 678 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 679 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 680 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 681 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 682 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 683 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 684 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 476 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 574 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 575 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 576 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 577 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 659 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 661 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 664 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 665 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 666 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 668 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 669 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 699 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>,
> +				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
> +				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>,
> +				 <&gpucc GPU_CC_AHB_CLK>;
> +			clock-names = "hlos",
> +				      "bus",
> +				      "iface",
> +				      "ahb";
> +			power-domains = <&gpucc GPU_CC_CX_GDSC>;
> +			dma-coherent;
> +		};
> +
>   		remoteproc_mpss: remoteproc@4080000 {
>   			compatible = "qcom,sm8550-mpss-pas";
>   			reg = <0x0 0x04080000 0x0 0x4040>;
> 

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
