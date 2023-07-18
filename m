Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6E275785E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjGRJrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjGRJre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:47:34 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD6CE60
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:47:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so13837055a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689673650; x=1692265650;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=btOylq44qE3hGXl4wQpe3Auk+ZV3+DCDDTN42Bq3TwQ=;
        b=lHLMOLv5J6z2rjvGcQUyoSNRu5DjFOGb5i7WqJScPEStEZIyvEjtHaLiysLzxSw3aq
         dPemYOncMtcY9m7o4NljPVxAskxNylokj2/GGfwzCLvtU6AWk34W1HcUAvAyOxCzR5hO
         n3gYFq6dLS7VHBDo1fpWfVTfbp66KR1ApglvtdkAQO9mr8cjulmRC2ZMK3/D1ICTdzbC
         pXYnNU1lu1/TLQppkIjAKgIQ6VQuhWg2MwC9wxBiXD1jp8BzfoqIDpGiF3v9UdVZwV0r
         934LNUBggElPpPeVu6ZsOiN1+GSBL0iIkaVy1ncgZjIHVyR48UWEe2txm5vSR7f1JylL
         g7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689673650; x=1692265650;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=btOylq44qE3hGXl4wQpe3Auk+ZV3+DCDDTN42Bq3TwQ=;
        b=Kkp140RCTbt/a5tcEhkd9fpfxQjuYg7U51riRE0JiqrlUMhOLRLOiY/SxxFJfLLgsq
         pzqDg90HxbOZ07WzRL91OjpaAQMnz5p6iqVIFCTy2KmolmRwf2cD1eJgmR3tMRgxHvtl
         +8WPV0968n53SDM7HRhM6kur71U2PMpa/NLlPmF2TMUDXrkKc1+nJ2oIgxsizJ0b/+4r
         azBvqL5aWklpnU5lM9lK/C6904lxSD4ED8oBpEPasN8kgyUSdDvb6wnBP2XqsTU54EOR
         p52Z5a7sJ5X2WFbW0CHmViy84M/+uwk8GJd3UG/6YwW/rJNFF6BIznN99ozI7k5sxOOx
         dCaw==
X-Gm-Message-State: ABy/qLZRRdcVWrW7eIP0ORpk+Kv8wtBd2VV9CMdTfVkB1/ACoFv68Omq
        ZGg+eyQqTP/Ux6mWDMaHXCvLhg==
X-Google-Smtp-Source: APBJJlEACjV7y+0+WMDrNxfFGJkjSdUG+4wKfwPLuyevz4IqfWvcvjKI4V63E6+jJNKP4SAIgay07w==
X-Received: by 2002:a05:6402:3550:b0:51e:5aac:6bad with SMTP id f16-20020a056402355000b0051e5aac6badmr14603995edd.11.1689673649807;
        Tue, 18 Jul 2023 02:47:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id u25-20020aa7d899000000b0051e19bf66a4sm935507edq.83.2023.07.18.02.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 02:47:29 -0700 (PDT)
Message-ID: <e25fb716-38f3-7f4b-d525-e20455cdae85@linaro.org>
Date:   Tue, 18 Jul 2023 11:47:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm64: dts: qcom: sm8450-hdk: add other analogue
 microphones
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230717143824.203352-1-krzysztof.kozlowski@linaro.org>
 <76c99543-4f77-38c2-5940-517f2715060d@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <76c99543-4f77-38c2-5940-517f2715060d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 11:40, Srinivas Kandagatla wrote:
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
>> index bd5e8181f2aa..9bd1ef401ca3 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
>> @@ -915,14 +915,23 @@ &sound {
>>   			"SpkrRight IN", "WSA_SPK2 OUT",
>>   			"IN1_HPHL", "HPHL_OUT",
>>   			"IN2_HPHR", "HPHR_OUT",
>> +			"AMIC1", "MIC BIAS1",
>>   			"AMIC2", "MIC BIAS2",
>> -			"VA DMIC0", "MIC BIAS1",
>> -			"VA DMIC1", "MIC BIAS1",
>> -			"VA DMIC2", "MIC BIAS3",
>> -			"TX DMIC0", "MIC BIAS1",
>> -			"TX DMIC1", "MIC BIAS2",
>> -			"TX DMIC2", "MIC BIAS3",
>> -			"TX SWR_ADC1", "ADC2_OUTPUT";
>> +			"AMIC3", "MIC BIAS3",
>> +			"AMIC4", "MIC BIAS3",
>> +			"AMIC5", "MIC BIAS4",
> These should reflect the board-level wiring of MIC BIAS, are you sure 
> that this is how the hdk is wired up?

If I read the schematics correctly, then yes. You can double check, if I
understood this right: page 40 of HDK schematics

Best regards,
Krzysztof

