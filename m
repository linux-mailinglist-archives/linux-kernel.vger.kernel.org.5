Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814777983BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 10:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240499AbjIHIKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 04:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239556AbjIHIKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:10:22 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9911BDA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 01:10:17 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bf6b37859eso5245091fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 01:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694160616; x=1694765416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TOWQ2ESsosOqw5vvZj/k+8ICArSpB+tBiMgWjf414VE=;
        b=GdwbFDBwU7kYPWc8Ny3nUhBv8ByczhIvP7HcGaSybyxOLv156VdRRS8DERInpx68LT
         Gg6xD1DZYfzcEZr3i8gE12oPeyGT00aiBawCoOcKqK+e9ymbwYHKLOdnDEqPlXiteRqK
         zjjisCDE9tc8JkXoGdvuJ0uyL558b3TX1qMATa3YG/Ss8XBBqN7cXFAcCR52BH6MHlT4
         ZcWJ/k0U7RULiOzHOAIpGSE5XtJ4VY/4zPs2YKPRRn88VhRDXC89Xv5pscGD4d8ottVq
         u9VgqkAo4qfCFUzSuKRLi+Bvu225sJ09pFAwsjyFZn1ggMPA7VC05SaipS219+C8iX0O
         uJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694160616; x=1694765416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TOWQ2ESsosOqw5vvZj/k+8ICArSpB+tBiMgWjf414VE=;
        b=swzFZTCSsVfVkpHBVDOSjyaIXlmocEvXafZZfs4vDUWVMcGotPz7kiezh8MA+Z9xcA
         grlb7Y9WmfZDkIjhGri/0lVdxUnpDL6OAe5w8Q8s32wT8JMhk8kFbptQRfHsaL5aATBi
         CLpeSOl+P1AMgeUGlP1873ceVPNO9iWfu6xNFst1qtfaOgoojTXzMIJkrvCdTUQm59Ez
         990Vv+xKvFVlVOcDft/9ElomSpYK20gKNVJ0Be6q10aSWcN6GhRnsGdKht/1ark1oV3L
         1m18ZLX8VDey51FPz5jaEEmNFvSxNoi9xDpXMgwQlymP+9k5kmEULopcEsmCMCSOA1sy
         sZ1g==
X-Gm-Message-State: AOJu0YwelhvrL0u8La6NWWjtuEIGubFi8CT9c5f2M7zpiDAyP84HZmCW
        PUypOugrg4aoVsEGJy79JirKFVZ7tP9tKVmy4xlyWMaZ
X-Google-Smtp-Source: AGHT+IGYaS8a3hgXz1ASZAnOXKbQ2NNqou9IH3AWLjI5UBthZque247+3f6pMjJyfv/HrQakyEjJUA==
X-Received: by 2002:a05:651c:201:b0:2b6:eb68:fe76 with SMTP id y1-20020a05651c020100b002b6eb68fe76mr1151251ljn.25.1694160615888;
        Fri, 08 Sep 2023 01:10:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id mb18-20020a170906eb1200b00997cce73cc7sm675164ejb.29.2023.09.08.01.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 01:10:15 -0700 (PDT)
Message-ID: <59626d1b-8407-9370-21ab-bf15853f24c0@linaro.org>
Date:   Fri, 8 Sep 2023 10:10:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 4/6] arm64: dts: qcom: sm4450: Add apps_rsc and cmd_db
 node
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, lee@kernel.org
Cc:     robimarko@gmail.com, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_shashim@quicinc.com, quic_kaushalk@quicinc.com,
        quic_tdas@quicinc.com, quic_tingweiz@quicinc.com,
        quic_aiquny@quicinc.com, kernel@quicinc.com,
        quic_bjorande@quicinc.com, Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230908065847.28382-1-quic_tengfan@quicinc.com>
 <20230908065847.28382-5-quic_tengfan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230908065847.28382-5-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2023 08:58, Tengfei Fan wrote:
> From: Ajit Pandey <quic_ajipan@quicinc.com>
> 
> Add apps_rsc node and cmd_db memory region for sm4450.
> 
> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm4450.dtsi | 34 ++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi b/arch/arm64/boot/dts/qcom/sm4450.dtsi
> index c4e5b33f5169..eb544d875806 100644
> --- a/arch/arm64/boot/dts/qcom/sm4450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm4450.dtsi
> @@ -5,6 +5,7 @@
>  
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  
>  / {
>  	interrupt-parent = <&intc>;
> @@ -328,6 +329,18 @@
>  		};
>  	};
>  
> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		aop_cmd_db_mem: cmd-db@80860000 {
> +			compatible = "qcom,cmd-db";
> +			reg = <0x0 0x80860000 0x0 0x20000>;
> +			no-map;
> +		};
> +	};
> +
>  	soc: soc@0 {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -335,6 +348,27 @@
>  		dma-ranges = <0 0 0 0 0x10 0>;
>  		compatible = "simple-bus";
>  
> +		apps_rsc: rsc@17a00000 {
> +			label = "apps_rsc";

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +			compatible = "qcom,rpmh-rsc";

compatible is always the first property. reg/reg-names/ranges follow.



Best regards,
Krzysztof

