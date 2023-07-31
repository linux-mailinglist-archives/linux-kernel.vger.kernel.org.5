Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D839769138
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjGaJOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjGaJOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:14:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536C511A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:14:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c10ba30afso196213366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690794851; x=1691399651;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KPT5psZDnsv1eUHcgQJHOsimNQGLNtcaN5J7ygYlDy4=;
        b=M7BNZwumUjhbY2urw+cFRMviIALm8akB70pZrN+ASUNvSZXwli+LSPNYrJRWCPtjpy
         eopB+e2clJTNLo+65vhKA4U5dlQAtcjOaMqOsjV/BcE8AmtvA62SfikEJsi1R6WV+Ue3
         rwrv6QGQ2sYiZxAjnDAPKVNmLbqy19QPX60lSe7SaUZCpzdWe7IuEeOuYrYrS0NguJvt
         1VyYYz2HoerpULcNzBgomAkq96JjTKAhpqEcAVZIbKQeFSzDVLxr9EAfnkSBjEu6ZebW
         V2vzMHVBBqF0Le1PWyVA42fnVVcyK1kRxLkHem8am8ddqURojaSqfQ0k4TiJwXKzBztG
         Bkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690794851; x=1691399651;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KPT5psZDnsv1eUHcgQJHOsimNQGLNtcaN5J7ygYlDy4=;
        b=eKhamKHPUYzHZ4KuQrpEim22a/MJqodfavjA6TAmtb29H/3V1Z8JRC+xmQKKQO2FYM
         F6umHMGYEVurhIF5OTjti88sgETk0HoPWxiHdFLn/OJiDlZpKQlMfjpQdkw6fTMpfynD
         0wLT5R6yeic/CfW4perBLhRxktceTMjWK22v6hdzEgGwv190XPlbC07Ql8uaY6/WLyRL
         DJNChHKqXdK4yVxbgF0KGxbA9yReQFv1mF/hAqvrPEGh2Fy5AZZKY/4He2rYbZU0g5Oo
         r4GUT5q8izAX0vwbRpXtOfIN7dn3I5N1LZaRqlDw6Q2iMocPTNT7BfHkkv3j/rxpvh8P
         /y5w==
X-Gm-Message-State: ABy/qLaod3bBkrDoXiXMBpXuqvlTnb4p3UGu1g49vhgj2H6u7NvKi9wM
        vWUfkTTiyb8ZPl74DpSTKg+hWg==
X-Google-Smtp-Source: APBJJlEZ1rkfhNblIOIRMbTUx5jFLxhco5Gyqdv5hePXck3o0BhkXRH1fttcm2t5zZM/QX2/nCxPZA==
X-Received: by 2002:a17:906:3143:b0:993:d632:2c3 with SMTP id e3-20020a170906314300b00993d63202c3mr6790210eje.21.1690794850768;
        Mon, 31 Jul 2023 02:14:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id qc8-20020a170906d8a800b00989828a42e8sm5872867ejb.154.2023.07.31.02.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 02:14:10 -0700 (PDT)
Message-ID: <21f654b5-5b9e-2486-889a-f6c884706f7f@linaro.org>
Date:   Mon, 31 Jul 2023 11:14:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] ARM: dts: qcom: use defines for interrupts
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230730111530.98105-1-krzysztof.kozlowski@linaro.org>
 <e274df6d-d34b-8a5d-8792-261ae51e2f66@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e274df6d-d34b-8a5d-8792-261ae51e2f66@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2023 10:07, Konrad Dybcio wrote:
> On 30.07.2023 13:15, Krzysztof Kozlowski wrote:
>> Replace hard-coded interrupt parts (GIC, flags) with standard defines
>> for readability.  No changes in resulting DTBs.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 44 ++++++++++++------------
>>  arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi |  2 +-
>>  arch/arm/boot/dts/qcom/qcom-msm8660.dtsi | 22 ++++++------
>>  arch/arm/boot/dts/qcom/qcom-msm8974.dtsi |  6 ++--
>>  arch/arm/boot/dts/qcom/qcom-sdx55.dtsi   | 18 +++++-----
>>  arch/arm/boot/dts/qcom/qcom-sdx65.dtsi   | 26 +++++++-------
>>  6 files changed, 59 insertions(+), 59 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
>> index e0adf237fc5c..c693bfc63488 100644
>> --- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
>> +++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
>> @@ -190,7 +190,7 @@ cpu_crit3: trip1 {
>>  
>>  	cpu-pmu {
>>  		compatible = "qcom,krait-pmu";
>> -		interrupts = <1 10 0x304>;
>> +		interrupts = <GIC_PPI 10 0x304>;
> Looks like 0x304 would be (IRQ_TYPE_LEVEL_HIGH | IRQ_LEVEL | IRQ_PER_CPU)
> 
> 
> [...]
> 
>>  	timer {
>>  		compatible = "arm,armv7-timer";
>> -		interrupts = <1 2 0xf08>,
>> +		interrupts = <GIC_PPI 2 0xf08>,
> 0xf08 -> (IRQ_LEVEL | IRQ_PER_CPU | IRQ_NOPROBE | IRQ_NOREQUEST | IRQ_TYPE_LEVEL_LOW)
> 
> there's a couple more 0x3XX and 0xfXX in there

I was too lazy to decode these, but since you did the hard part, I will
change them. :) Thanks

Best regards,
Krzysztof

