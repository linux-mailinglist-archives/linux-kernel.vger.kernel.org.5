Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091C37A86A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbjITOd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbjITOdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:33:55 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2B9D8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:33:49 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9ad810be221so920292266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695220427; x=1695825227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nn6IgZd5Q0e3a3u9j4Q81rIk1Nx8wVCC6hGARhQrRyE=;
        b=OOf7cno96T3qjLMSAouBDjluI6dpgxYJdlP8o0IP9cM/IrYxiYiFY0O1kVEi6tFxM5
         TecuGK5C4A5UUhV3ewJu3ej1qiJ66Qx83233G2AZma2EziaIrmKMJAJ+POG+DDJUIGms
         AwksuBmlyxn6Ll+pIU/tuNY7aemu23KPia8xdXlDofLXc2CVDdbADob0bVv/OGWmUG0n
         dOgwuULhtT3ypMIx1KJP2Ote3uQMhBdPnGSZIAsAz7h0JBLf09GdY/2BJdcSFQ5bt6Ik
         jK2ot6YnjJ3b313WYKKZgb8qRMACnFF28mHMn1CGWnpoXdSzC+bkh7ptPvWx3wUYsi2A
         z7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695220427; x=1695825227;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nn6IgZd5Q0e3a3u9j4Q81rIk1Nx8wVCC6hGARhQrRyE=;
        b=IPkXyNkz++SqmkA3MPIXg3D/dyPT0SQzPc9CRFv3AojbYDGaxaXsdM7IBfqJurEuMK
         lyEGLG/E8LpBbR/xZUzqN0qSrs2yTPMWBVFysWCUrWJmZjWxJpnBucoLUVJPq7a8XZHa
         s2/03FNpztzhR6ysPNjvMlzH4d0BRoE/wKt1IICYHEhBZeFIs4FMQmyB6xPcn6NWO21Z
         eKEESBkkeYTzB8vLFGCG0PzbYbmQfPi8hkWa08I+RuEAf198AFreHf6onb+1zwZvWJR9
         7Mo4PRKAS1TuhmkL4dIyWGlucjH8+5+J+/2yCphSrxyKLv/90lWFru67eS7aQS1rznUE
         j7MA==
X-Gm-Message-State: AOJu0YxKvZ6l5fnBSQZQkOWxLErP3rxTTRmnj4ora4IvqAlCD6Dnb76e
        VP83S6vdXrVRxt56K73CZvCrOQ==
X-Google-Smtp-Source: AGHT+IFBHOmsN85o0yc92bWhdnSuR1Qb3jxeuLwcHhLZvDXj5OpOxhrowGaUdFyOIs0g9qziD3fvEw==
X-Received: by 2002:a17:907:7882:b0:9a5:a44a:86f3 with SMTP id ku2-20020a170907788200b009a5a44a86f3mr1872262ejc.25.1695220427670;
        Wed, 20 Sep 2023 07:33:47 -0700 (PDT)
Received: from [172.20.86.172] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id bo4-20020a170906d04400b009a9f00bdf8dsm9340063ejb.191.2023.09.20.07.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 07:33:47 -0700 (PDT)
Message-ID: <ae4df26d-b74e-f22e-f532-7ff34d139fa3@linaro.org>
Date:   Wed, 20 Sep 2023 16:33:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sm4450: Add RPMH and Global clock
 controller
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
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
 <20230908065847.28382-6-quic_tengfan@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230908065847.28382-6-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 9/8/23 08:58, Tengfei Fan wrote:
> From: Ajit Pandey <quic_ajipan@quicinc.com>
> 
> Add device node for RPMH and Global clock controller on Qualcomm
> SM4450 platform.
> 
> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sm4450.dtsi | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi b/arch/arm64/boot/dts/qcom/sm4450.dtsi
> index eb544d875806..2395b1d655a2 100644
> --- a/arch/arm64/boot/dts/qcom/sm4450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm4450.dtsi
> @@ -3,6 +3,8 @@
>    * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>    */
>   
> +#include <dt-bindings/clock/qcom,rpmh.h>
> +#include <dt-bindings/clock/qcom,sm4450-gcc.h>
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> @@ -367,6 +369,22 @@
>   			apps_bcm_voter: bcm-voter {
>   				compatible = "qcom,bcm-voter";
>   			};
> +
> +			rpmhcc: clock-controller {
> +				compatible = "qcom,sm4450-rpmh-clk";
> +				#clock-cells = <1>;
> +				clock-names = "xo";
> +				clocks = <&xo_board>;
property
property-names

please

Konrad
