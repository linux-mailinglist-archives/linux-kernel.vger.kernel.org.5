Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7A07F8BD5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 15:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjKYOsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 09:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjKYOsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 09:48:39 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB850193
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:48:44 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40838915cecso19985185e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700923723; x=1701528523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N20/oiu77CX6Sa1yTEd4j/RHq6LyJhq5tkjVVC8KpEM=;
        b=vj9G11DHEuRVaAEIcYYApWLz9Ru6i4B4eT4OcUrFhW4CSPbZTlc0dbqDciMxpBy027
         T3XsBEJ2jsYVMUMjnvtTyJr9Mpy0/w7KedPXZHDA28RKrzsOid2spSAzx+Y5VblJfaQA
         3sTaA9Yy7KkiKslBcuIN0xRxInhO2fcQHmVTAeDnm2QDGb/Xyn2nunP3pw2SzNKVCVz1
         kKOicHIMYHW24hlOI2dysIRA3fAN3USIYr1Ss/oGYLfmwSzi+T3R043n/fiNwP5CYvhK
         /tWXBv1/fR/d9x1txcRpBCqe5kDmYKii6+adSeqfpieFGl10BHYkAtCsoRGmmQ3ARAOf
         wcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700923723; x=1701528523;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N20/oiu77CX6Sa1yTEd4j/RHq6LyJhq5tkjVVC8KpEM=;
        b=EVE/xDu/+1BcGxpNWHBnFByUsQAqRE+o6k71JtLJMNfL16yVY9tErSIhslsZ+vHmnc
         jnRRYWP6Qq02Ceb6+JU1orgv9VrH+qtZzOkYx6Bu2Rk/WZmS54clCw8yyeNUTbGl3yIN
         dQJlUfhwhefzTPyxtcyZvY5NGnhU7IPgNcEkn+MINE+TuIgStFpwUvUPaXU8pssm5bE5
         cpIRPs3OdVnkGO7/fHSa379nfL951vIkKB0+DwLmYgrclUMN9L1/VSH/mCbX6hWgomGT
         uo3cO4MZHFrJTHoGXDwSiDtujHXQGJ+Ra/0cpIi16GSw7LCEFhLumbYtwbrJ+VKZo7MQ
         T1Nw==
X-Gm-Message-State: AOJu0YwNGNzvXHVwoZfj5bCoQoqRz3DkuuukF/KpQ96hGV8pyJB1Yya/
        /e4+yHgBbjfGmHWI0zsJ3+V6Jg==
X-Google-Smtp-Source: AGHT+IH807Wmgd7sTkaZ9EqVyeLwmxRRsQ9F3Mo+OTglyb0Myt0I0yzSqfJ8frDAqd3mLKa/g0tbhg==
X-Received: by 2002:a05:600c:4589:b0:40b:357c:bb9f with SMTP id r9-20020a05600c458900b0040b357cbb9fmr1122292wmo.33.1700923723052;
        Sat, 25 Nov 2023 06:48:43 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b0040b3632e993sm8138661wmq.46.2023.11.25.06.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 06:48:42 -0800 (PST)
Message-ID: <708925cc-abd6-4b90-b273-fbf9a34498d1@linaro.org>
Date:   Sat, 25 Nov 2023 14:48:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm6115: Add UART3
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
References: <20231120-topic-rb2_bt-v1-0-509db2e28e70@linaro.org>
 <20231120-topic-rb2_bt-v1-1-509db2e28e70@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231120-topic-rb2_bt-v1-1-509db2e28e70@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2023 13:04, Konrad Dybcio wrote:
> Hook up UART3, usually used for communicating with a Bluetooth module.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm6115.dtsi | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 839c60351240..0d13d7bf6bd1 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -273,6 +273,25 @@ memory@80000000 {
>   		reg = <0 0x80000000 0 0>;
>   	};
>   
> +	qup_opp_table: opp-table-qup {
> +		compatible = "operating-points-v2";
> +
> +		opp-75000000 {
> +			opp-hz = /bits/ 64 <75000000>;
> +			required-opps = <&rpmpd_opp_low_svs>;
> +		};
> +
> +		opp-100000000 {
> +			opp-hz = /bits/ 64 <100000000>;
> +			required-opps = <&rpmpd_opp_svs>;
> +		};
> +
> +		opp-128000000 {
> +			opp-hz = /bits/ 64 <128000000>;
> +			required-opps = <&rpmpd_opp_nom>;
> +		};
> +	};
> +

It looked odd to me that the same opps as the FP4 were used but, this 
declaration is consistent with downstream.

>   	pmu {
>   		compatible = "arm,armv8-pmuv3";
>   		interrupts = <GIC_PPI 6 IRQ_TYPE_LEVEL_HIGH>;
> @@ -1208,6 +1227,17 @@ spi3: spi@4a8c000 {
>   				status = "disabled";
>   			};
>   
> +			uart3: serial@4a8c000 {
> +				compatible = "qcom,geni-uart";
> +				reg = <0x0 0x04a8c000 0x0 0x4000>;
> +				interrupts-extended = <&intc GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
> +				clock-names = "se";
> +				power-domains = <&rpmpd SM6115_VDDCX>;
> +				operating-points-v2 = <&qup_opp_table>;
> +				status = "disabled";
> +			};
> +
>   			i2c4: i2c@4a90000 {
>   				compatible = "qcom,geni-i2c";
>   				reg = <0x0 0x04a90000 0x0 0x4000>;
> 

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
