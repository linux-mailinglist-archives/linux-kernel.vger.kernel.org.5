Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E612E768FB0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjGaIME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjGaILn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:11:43 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA3E1BC5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:07:29 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so40436401fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690790847; x=1691395647;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZqTmRIbEzGWkMIQ/7WUD43X1exAHGHGBjC+JLzJ3vlw=;
        b=dDu3pT6Z2pBpixJh9+pzWjBRT6ICwIa1XvWIDvSh0G4WmAfufd5lYeeAer0s1IeKWL
         Q2z+4fJkFSOYxWqgLWX1JKAlzU5z6in65GzzHHX1PF7vmsrniAoCF6WD/ZP07E2h0Gsy
         WLQ2h4mNeFRzPa1OvyKE9kdwCEQsVgdl6n6BJFvbBOKZ8CC70VubPKlyGkJdp8TDoDto
         kOeVrVLigTtGh2k372mhwhbKDrHHn/EGuvoTaoNcf573fY/n1jLU9FMTwhAYoSP5dbQ0
         wg5cPa5rNkmA+P3S2lrqPWqeiIjWI4O4dgPi8BPXm9xIqFOoSbU6+jd50fI0R79M2Kha
         +SpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690790847; x=1691395647;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqTmRIbEzGWkMIQ/7WUD43X1exAHGHGBjC+JLzJ3vlw=;
        b=jaau9X2bSijUJsn6pNl6+oxaepGbfI5jvwDUnkb6Tudz+NjXWaIWmiVATQjnLLK1pa
         N0pm/rBYhAiIDq2PZPqfR1wFQFktoxBCNxwdjolVCP5rD5XJ8O/rN4qgDMmyR4oQH298
         4sWf0ZdXNR7NPeF+XxM6GVsKI2y2fSpFl0WDGBJADdHqrGK7qT8oNOJszaR49Gynw/TQ
         0VKsnBbu2t2LPJ7cnI3rom8+mIU/sNwOfehaVzkNICJZU9081XhN2tBn5wAzQgf4FnQ1
         cuQg5fWCNwx/lXVmGxjhwVk0cYEI51YVONkhmMzUrvZ/w43umfTBuclDvMJEFljVKMML
         IUpA==
X-Gm-Message-State: ABy/qLYBDtQUfwjESLVMI4AQBz3NkfVurDnm2RgY5ibrbX1AkvWZEP8+
        GcUbQ2ZHfLOpiwej0SjuWjjsEA==
X-Google-Smtp-Source: APBJJlGMqG5IlFByvjde3/tO+un+SfvKLos/B9DUiKrbZqzGjWFmsRNr1v0/XvOB7unx/zERilrkBw==
X-Received: by 2002:a2e:9e46:0:b0:2b6:d0fc:ee18 with SMTP id g6-20020a2e9e46000000b002b6d0fcee18mr5819812ljk.19.1690790847277;
        Mon, 31 Jul 2023 01:07:27 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id w18-20020a2e3012000000b002b6a5dfc7f3sm2448776ljw.30.2023.07.31.01.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 01:07:26 -0700 (PDT)
Message-ID: <e274df6d-d34b-8a5d-8792-261ae51e2f66@linaro.org>
Date:   Mon, 31 Jul 2023 10:07:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: qcom: use defines for interrupts
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230730111530.98105-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230730111530.98105-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

On 30.07.2023 13:15, Krzysztof Kozlowski wrote:
> Replace hard-coded interrupt parts (GIC, flags) with standard defines
> for readability.  No changes in resulting DTBs.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 44 ++++++++++++------------
>  arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi |  2 +-
>  arch/arm/boot/dts/qcom/qcom-msm8660.dtsi | 22 ++++++------
>  arch/arm/boot/dts/qcom/qcom-msm8974.dtsi |  6 ++--
>  arch/arm/boot/dts/qcom/qcom-sdx55.dtsi   | 18 +++++-----
>  arch/arm/boot/dts/qcom/qcom-sdx65.dtsi   | 26 +++++++-------
>  6 files changed, 59 insertions(+), 59 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
> index e0adf237fc5c..c693bfc63488 100644
> --- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
> @@ -190,7 +190,7 @@ cpu_crit3: trip1 {
>  
>  	cpu-pmu {
>  		compatible = "qcom,krait-pmu";
> -		interrupts = <1 10 0x304>;
> +		interrupts = <GIC_PPI 10 0x304>;
Looks like 0x304 would be (IRQ_TYPE_LEVEL_HIGH | IRQ_LEVEL | IRQ_PER_CPU)


[...]

>  	timer {
>  		compatible = "arm,armv7-timer";
> -		interrupts = <1 2 0xf08>,
> +		interrupts = <GIC_PPI 2 0xf08>,
0xf08 -> (IRQ_LEVEL | IRQ_PER_CPU | IRQ_NOPROBE | IRQ_NOREQUEST | IRQ_TYPE_LEVEL_LOW)

there's a couple more 0x3XX and 0xfXX in there

otherwise lgtm

Konrad
