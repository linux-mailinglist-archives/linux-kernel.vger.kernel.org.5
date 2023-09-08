Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8CF798306
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbjIHHDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 03:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjIHHDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:03:30 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5535D10CF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 00:03:26 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52c74a2e8edso2345878a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 00:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694156605; x=1694761405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=okcWD7N3Q16flP7KKKhZ6wDq8bzIw+Eq1LknpxTrajc=;
        b=Xb8mgAw0cy9Mc/8iO6MqZK5UeZpvo3PxdQzrSpIr9S5WhJZ4XfoGB9r9DuEw+chWOz
         k8T9S8GORJ1Klqt9dgadcF2Jf2U4p74BnhvYKcZKE17EMZIC2ZMT11hXbumcG6Gs8My4
         fMD+D50PI+Hmon72Gh2SM8n7b28P5+omxzYmyw2vGMxzBSaKaIAF6Tdj1RUGym5JvIl3
         m+bgzFw/icG6Lk1WTb9MtTzxh3OeqIYdo91VXw0gBZ6jfSzIf1Clq23Zu6jncL8wqqHY
         BqzHlVI402KmUzDVml6XwjhwPX1PDVUAXKGAxOG/ZI5boNnAvQeS84bvBD730lEDOoYx
         xeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694156605; x=1694761405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=okcWD7N3Q16flP7KKKhZ6wDq8bzIw+Eq1LknpxTrajc=;
        b=D+dHKX44FBnKONqsBpTUMkf9jxFBziFQZnvOiguXqoESK9woooZBwvSLNs/7rUca6R
         ktZwd/7YvF81YHLZIqXO3rF0qO+RfqiuUmPXdJWUCETkN57jAQIe+MouSF6XPTlrs7Bg
         DPyxU9Ni17+6EgQZT3RUVA01ctU+YegcflOCP5C3NZF+DN05fnuS4Y3/fcVxyS1QuhD/
         JA9qrN2LsQDkO64uM9W1CH3DZznqkye8J+P8Wy+zwN3krKF8V1mRp0c+UU+irfzF1rfG
         Boy1eyOabHngw211mHPlKIT8VQmNtFsJ33G1R4lqdZsvRjNGmokN+I93x1kwd7VgNqeM
         zALQ==
X-Gm-Message-State: AOJu0Yytg4YCBpWXS7GG9jKh7tSkzN4shHBZ+voGxU7Km8XJ0Br3d2o4
        CtcWGg+yqyZwL7raYiKOSz94vw==
X-Google-Smtp-Source: AGHT+IF+CDiY8E89/dSN/nzzvPEsXUmsQ3bNw5qeJKEf3xCYuG9FhNc6Voc1ovYxm99eozXLXHKEJg==
X-Received: by 2002:aa7:d34b:0:b0:524:24dc:c455 with SMTP id m11-20020aa7d34b000000b0052424dcc455mr861175edr.42.1694156604782;
        Fri, 08 Sep 2023 00:03:24 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id z12-20020aa7d40c000000b0052241b8fd0bsm625745edq.29.2023.09.08.00.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 00:03:24 -0700 (PDT)
Message-ID: <5cc6b461-0a19-429c-ba06-7df73a48c46c@linaro.org>
Date:   Fri, 8 Sep 2023 10:03:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] arm64: dts: qcom: sm4450: Add apps_rsc and cmd_db
 node
Content-Language: en-GB
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
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230908065847.28382-5-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2023 09:58, Tengfei Fan wrote:
> From: Ajit Pandey <quic_ajipan@quicinc.com>
> 
> Add apps_rsc node and cmd_db memory region for sm4450.
> 
> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sm4450.dtsi | 34 ++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi b/arch/arm64/boot/dts/qcom/sm4450.dtsi
> index c4e5b33f5169..eb544d875806 100644
> --- a/arch/arm64/boot/dts/qcom/sm4450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm4450.dtsi
> @@ -5,6 +5,7 @@
>   
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
>   
>   / {
>   	interrupt-parent = <&intc>;
> @@ -328,6 +329,18 @@
>   		};
>   	};
>   
> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		aop_cmd_db_mem: cmd-db@80860000 {

Judging from sm8550, this should be aop-cmd-db-region@....

> +			compatible = "qcom,cmd-db";
> +			reg = <0x0 0x80860000 0x0 0x20000>;
> +			no-map;
> +		};
> +	};
> +
>   	soc: soc@0 {
>   		#address-cells = <2>;
>   		#size-cells = <2>;
> @@ -335,6 +348,27 @@
>   		dma-ranges = <0 0 0 0 0x10 0>;
>   		compatible = "simple-bus";
>   
> +		apps_rsc: rsc@17a00000 {
> +			label = "apps_rsc";
> +			compatible = "qcom,rpmh-rsc";
> +			reg = <0 0x17a00000 0 0x10000>,
> +			      <0 0x17a10000 0 0x10000>,
> +			      <0 0x17a20000 0 0x10000>;
> +			reg-names = "drv-0", "drv-1", "drv-2";
> +			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +			qcom,tcs-offset = <0xd00>;
> +			qcom,drv-id = <2>;
> +			qcom,tcs-config = <ACTIVE_TCS    2>, <SLEEP_TCS     3>,
> +					  <WAKE_TCS      3>, <CONTROL_TCS   0>;
> +			power-domains = <&CLUSTER_PD>;
> +
> +			apps_bcm_voter: bcm-voter {
> +				compatible = "qcom,bcm-voter";
> +			};
> +		};
> +
>   		tcsr_mutex: hwlock@1f40000 {
>   			compatible = "qcom,tcsr-mutex";
>   			reg = <0x0 0x01f40000 0x0 0x40000>;

-- 
With best wishes
Dmitry

