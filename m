Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635987B41B6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 17:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbjI3PfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 11:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjI3PfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 11:35:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A60B3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 08:35:18 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-406589e5765so19944565e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 08:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696088117; x=1696692917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GdA9CydRMRNZ+tMRFsfw3YeBxrde3OG+GVWa/TYXyBo=;
        b=pdx9Tds6urXB0VeMZnL1t6zpAH/hNL2q1fTqTSLECExpLGpZxIyS4T6sCeXzmuJvr1
         GbVmBR4jZ33E+bGENyM6yqbG1j4dSSMmmm6WP/0FJhjYBt2UKHJDC1jvRtOuaxzCx/he
         wypS0yK/7AsOWwQiQOUudhIcJkN38KQVIq47hj056AfWbhiR86TQVUZU1cBIcH0hC70j
         1TsMFfhTNVsZvpvKLYH55wx+3rm5fuCdHVsp9qXvEzvidi4YPbdWV/fOHqE4weY/JUxa
         zM7aSq4Ndca0c40+dEO3GkE6W/7nnpjHPxj3aGK/jiI2f0QoX7fHv3XDKvLNOdDQ4nSM
         nxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696088117; x=1696692917;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GdA9CydRMRNZ+tMRFsfw3YeBxrde3OG+GVWa/TYXyBo=;
        b=cFxLeOJCgf843bmxNetnp0IFQGHFgp0N3CnAPmI45kSy55M1ewatvKgYl9ATXtwMWw
         qSzusjYWzHjKQX7CzCEw3PNC0CCITlyaCHIkP1kln4gAe7XXQyKfUjEhyuuBdorw2KLj
         c04HfNR/J9Kj1UmX6adXVqquaqs/rzG4oNB3HWJev4Iz0RuETlkM/tdcJKeT7Jpc+13W
         5v0c7reDyWOfGJS4PKyBJ9BXklGb1Elahk8B084963Gj4QKl3YlKRMpGgChkBYb0CTeX
         V6AyGQH70/m3OVYgG/4pWuW6D45gaLkR+GEbyuCS1B+b5X+Gub80cYxUNVwtFnpdqoiC
         ATYw==
X-Gm-Message-State: AOJu0Yy8WKrdKy3dd5KNCTO5NLkekeg5fT+k0+7GbLYTLam5GiSz4gya
        n9CfuhjtyMpaFumvguRD9QqPvQ==
X-Google-Smtp-Source: AGHT+IGVSAmsgmKiAl/Do7KYc1zGUxdenZ2gOrUQ/5BpAoc0QriZKUUA1Qkn9KzxlwXlpH2oheOUlA==
X-Received: by 2002:a7b:ce95:0:b0:401:aa8f:7566 with SMTP id q21-20020a7bce95000000b00401aa8f7566mr5905702wmj.26.1696088117196;
        Sat, 30 Sep 2023 08:35:17 -0700 (PDT)
Received: from [192.168.8.76] ([88.155.253.228])
        by smtp.gmail.com with ESMTPSA id y24-20020a05600c365800b0040652e8ca13sm3601794wmq.43.2023.09.30.08.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Sep 2023 08:35:16 -0700 (PDT)
Message-ID: <c673ba8e-76e5-4a23-b395-f61ec59d9bc7@linaro.org>
Date:   Sat, 30 Sep 2023 17:35:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V12 3/3] arm64: dts: ipq6018: add pwm node
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, thierry.reding@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, ndesaulniers@google.com, trix@redhat.com,
        baruch@tkos.co.il, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     linux-pwm@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        nathan@kernel.org
References: <20230925065915.3467964-1-quic_devipriy@quicinc.com>
 <20230925065915.3467964-4-quic_devipriy@quicinc.com>
 <9155c1e3-d163-b2ad-8a7b-57ffeca2b122@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <9155c1e3-d163-b2ad-8a7b-57ffeca2b122@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2023 13:47, Devi Priya wrote:
> 
> 
> On 9/25/2023 12:29 PM, Devi Priya wrote:
>> Describe the PWM block on IPQ6018.
>>
>> The PWM is in the TCSR area. Make &tcsr "simple-mfd" compatible, and add
>> &pwm as child of &tcsr.
>>
>> Add also ipq6018 specific compatible string.
>>
>> Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
>> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>> v12:
>>
>>    No change
>>
>> v11:
>>
>>    No change
>>
>> v10:
>>
>>    No change
>>
>> v9:
>>
>>    Add 'ranges' property (Rob)
>>
>> v8:
>>
>>    Add size cell to 'reg' (Rob)
>>
>> v7:
>>
>>    Use 'reg' instead of 'offset' (Rob)
>>
>>    Add qcom,tcsr-ipq6018 (Rob)
>>
>>    Drop clock-names (Bjorn)
>>
>> v6:
>>
>>    Make the PWM node child of TCSR (Rob Herring)
>>
>>    Add assigned-clocks/assigned-clock-rates (Uwe Kleine-König)
>>
>> v5: Use qcom,pwm-regs for TCSR phandle instead of direct regs
>>
>> v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
>>
>>   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> index 47b8b1d6730a..cadd2c583526 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> @@ -398,8 +398,21 @@ tcsr_mutex: hwlock@1905000 {
>>   		};
>>   
>>   		tcsr: syscon@1937000 {
>> -			compatible = "qcom,tcsr-ipq6018", "syscon";
>> +			compatible = "qcom,tcsr-ipq6018", "syscon", "simple-mfd";
>>   			reg = <0x0 0x01937000 0x0 0x21000>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges = <0x0 0x0 0x01937000 0x21000>;
>> +
> Hi Krzysztof,
> Referring to 
> https://lore.kernel.org/all/20220909091056.128949-1-krzysztof.kozlowski@linaro.org/, 
> it seems that the TCSR block should
> not have any child nodes. Could you pls provide your suggestions on pwm
> being added as the child node?

If you are sure that TCSR contains PWM and all registers are there, then
feel free to add proper binding. Sending untested patch is not the way
to go.

Best regards,
Krzysztof

