Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BA17A7864
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbjITKAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbjITKAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:00:12 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A8EAC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 03:00:05 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso881789966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 03:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695204004; x=1695808804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fBd3XO3VXcZ5Eq/j57aWQEchJJdUk3Puq2N4/Qm3ZrE=;
        b=fIFFSWd4ZzHRni5pAcyyNjQcaD1AlBQwSWO3blkfpxagEQUBg/rP3i6Q9oV0LwGfeN
         64FfCRlIebfZb5MYiqvtONHekRd0i1q7+1h2Mqz1OkGj2LG/DihZkvje50J1jWhpOVkP
         ofj1ciHP+aCBHNk6q6r1lSH1pBN8q7d3RRi1hji6UylODXD5n33AWIbMO5zfvN5fIpZS
         XryUThF/QkCYGXMoyWDjPdyuhCUGGB4kYJZhTY86wwiuy+TLhCqEL2jhkMfyzxayy92t
         qmUPljhe4NLAN6UX/xquW5vpYNHHGMhwgPM9HG85HWad7FC29GLtfn0HeYplS78L4U99
         xCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695204004; x=1695808804;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBd3XO3VXcZ5Eq/j57aWQEchJJdUk3Puq2N4/Qm3ZrE=;
        b=aUu84d6I4lT/W4HWMG2phhvd2+TePAbnr+K898G0m8nahV5S/TjwqUCycwxP+RsW6G
         Vn2UbmOqNtKxAHdx16ruvFxwyqzJ6BKrZxPXWwt9GdSTRJwcH+15WOsM6ti+VMYQXloY
         lNYlSIcZcRxvowvMN+K+rT9bEkVCfgrI+C10vk3aJzI1/Ar4mlETYDjRV4R8tZvhCZ7q
         pXUFJSIdOavqzvsKTPeTOu1RuMhO4+Ku6/I1/TUQcp23XyhT/pikh8lsjeU/iNmI9/M1
         d/fUbMBhw6W/uD7t0Q5WCG/ypWmOGv2j2fFNQk62TSoKZcNS67muGyQQqCChVg/YuKE6
         HvCA==
X-Gm-Message-State: AOJu0YwsraSoxTsl6jrbzhys5MZ65lDZdHRn3xPn8lo8vKvwbPGK0/aP
        EeeUxowRr8X4jesbjbatq+GxJA==
X-Google-Smtp-Source: AGHT+IFzx44j6/2ljA8qYlX2Z/kLYtXcrrNf5TI8l2xvWsgQAei8ep7dJ2ovnEU2Nlx9asEfjVeJ3g==
X-Received: by 2002:a17:906:3091:b0:9a1:ddb9:6546 with SMTP id 17-20020a170906309100b009a1ddb96546mr1621996ejv.61.1695204003913;
        Wed, 20 Sep 2023 03:00:03 -0700 (PDT)
Received: from [172.20.86.172] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id n25-20020a170906b31900b0099bcdfff7cbsm9184201ejz.160.2023.09.20.03.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 03:00:03 -0700 (PDT)
Message-ID: <21b8b019-42b8-6e47-e640-8bca28d2d784@linaro.org>
Date:   Wed, 20 Sep 2023 12:00:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 3/5] arm64: dts: qcom: sm4450: Add RPMH and Global
 clock
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, tglx@linutronix.de, maz@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org
Cc:     geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        quic_ajipan@quicinc.com, kernel@quicinc.com
References: <20230920065459.12738-1-quic_tengfan@quicinc.com>
 <20230920065459.12738-4-quic_tengfan@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230920065459.12738-4-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/23 08:54, Tengfei Fan wrote:
> Add device node for RPMH and Global clock controller on Qualcomm
> SM4450 platform.
> 
> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sm4450.dtsi | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi b/arch/arm64/boot/dts/qcom/sm4450.dtsi
> index 3d9d3b5e9510..c27f17a41699 100644
> --- a/arch/arm64/boot/dts/qcom/sm4450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm4450.dtsi
> @@ -3,6 +3,8 @@
>    * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>    */
>   
> +#include <dt-bindings/clock/qcom,rpmh.h>
> +#include <dt-bindings/clock/qcom,sm4450-gcc.h>
These should be sorted alphabetically.

[...]

> +			rpmhcc: clock-controller {
> +				compatible = "qcom,sm4450-rpmh-clk";
> +				#clock-cells = <1>;
> +				clock-names = "xo";
> +				clocks = <&xo_board>;
property
property-names

Konrad
