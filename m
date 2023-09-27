Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56C07B024B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjI0K7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjI0K7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:59:51 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F430F3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 03:59:50 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-405361bb94eso109288025e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 03:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695812388; x=1696417188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IWg5TiNW1Dws0r0H6VHI8s8vbhc7ehxun/IKO0phH0Y=;
        b=ztCHOP7O6ndfRucAyWcGFFtW/OD19VIZcg4K2Byr1Uc+GzrlkS8a1fp5Et5zs3vz0u
         /woZeMS+Pop2neTfqe0VM/j0UtPydkFJo7RftnZtI5io61NJuYBGWyK6kH+A/w4hqi/d
         /T6Y9cUJrWyAcmmiDdtDPCm8ASkTMI7duMDi2JBRwMF96iCF/Aw1nu17nbOybod6eL83
         T9+gIdxNaWcDypN9RZlDkSr1zHYVgGl2CnWQOUDdAsbpHXDKD5i0lBKHl7osekZmiFJh
         fsXskhtxLGr2JxrJjpPFcEO7pTrrp1J+5vuzT9Ce+jTpUGUaaeJnkhVd5PAkhK7Kxc/O
         XYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695812388; x=1696417188;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IWg5TiNW1Dws0r0H6VHI8s8vbhc7ehxun/IKO0phH0Y=;
        b=GSzzGMU4C7MIxydLaS5mUuJD1htVnL8ZRDjsXPjb2RwRgEQWT0+0DvuDLUAbXzv2Lh
         Wr50BzN52wbuBYyM51m48BMpRE1A7D4oC9G1w1zwx+YsxOP8RDzLqeugadqDJQqLqTYC
         w80DXEZwf4jyJI4A2L8xd5mexsC5lh9FS5Cwnuq3duClLzZWKq0JmUruTqPqlUV0yA6Q
         RRNTRhHeb8aJ1zR6r7706szsIucqZ08uNvpExxdb2q0lpQfGKsKqCprNW9qzQTXyJRGz
         SBtaNYEFuyH2QdKTyuzx61I1GNm6bN17mCZtAP9d1Z2tIQqJZEixaeXtkqFXKiZMNK/0
         Wvrg==
X-Gm-Message-State: AOJu0YxFKrOksS03d9y96JMTmKBJoQGcUUcZAwgCvx00HI911tOQ7UtI
        GDhnhFZnmBQ+5wnAMGP9yWiK+Q==
X-Google-Smtp-Source: AGHT+IElOxv/ufPOyKieeHDHmlR/WUO2h7LLzGfcWwjtp2J6oQ+ov6B97LkCHZFhfopbeNWJkDMySw==
X-Received: by 2002:a7b:ca4d:0:b0:405:359e:ee43 with SMTP id m13-20020a7bca4d000000b00405359eee43mr1694856wml.1.1695812388513;
        Wed, 27 Sep 2023 03:59:48 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c1d9300b0040531f5c51asm17650473wms.5.2023.09.27.03.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 03:59:48 -0700 (PDT)
Message-ID: <7f4f3e06-af20-4276-bcb9-6ad7acbf9c35@linaro.org>
Date:   Wed, 27 Sep 2023 11:59:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sm6375: Add UART1
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230927-topic-6375_stuff-v1-0-12243e36b45c@linaro.org>
 <20230927-topic-6375_stuff-v1-1-12243e36b45c@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230927-topic-6375_stuff-v1-1-12243e36b45c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2023 10:21, Konrad Dybcio wrote:
> Add UART1 node, generally used for the Bluetooth module.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm6375.dtsi | 43 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
> index e7ff55443da7..2fba0e7ea4e6 100644
> --- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
> @@ -896,6 +896,36 @@ qup_spi0_default: qup-spi0-default-state {
>   				drive-strength = <6>;
>   				bias-disable;
>   			};
> +
> +			qup_uart1_default: qup-uart1-default-state {
> +				cts-pins {
> +					pins = "gpio61";
> +					function = "qup01";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +				};

Any particular reason you are doing bias-pull-down here instead of

bias-disable ?

> +
> +				rts-pins {
> +					pins = "gpio62";
> +					function = "qup01";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +
> +				tx-pins {
> +					pins = "gpio63";
> +					function = "qup01";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +
> +				rx-pins {
> +					pins = "gpio64";
> +					function = "qup01";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +			};
>   		};
>   
>   		gcc: clock-controller@1400000 {
> @@ -1111,6 +1141,19 @@ spi1: spi@4a84000 {
>   				status = "disabled";
>   			};
>   
> +			uart1: serial@4a84000 {
> +				compatible = "qcom,geni-uart";
> +				reg = <0x0 0x04a84000 0x0 0x4000>;
> +				interrupts = <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
> +				clock-names = "se";
> +				power-domains = <&rpmpd SM6375_VDDCX>;
> +				operating-points-v2 = <&qup_opp_table>;
> +				pinctrl-0 = <&qup_uart1_default>;
> +				pinctrl-names = "default";
> +				status = "disabled";
> +			};
> +
>   			i2c2: i2c@4a88000 {
>   				compatible = "qcom,geni-i2c";
>   				reg = <0x0 0x04a88000 0x0 0x4000>;
> 

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
