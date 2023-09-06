Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511AA793AB1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbjIFLHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbjIFLH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:07:29 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360F910D0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 04:07:25 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52c9f1bd05dso5199947a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 04:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693998443; x=1694603243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hP3Q4zwhfkjEm0tc2IG4bz2zoQsKRY7LuWYMr41LgGY=;
        b=kkfTp8TqLJyL3X+qYLrZoIGFc3P9jH2DOvzTHM4la6Lwr8a5dsRVW3RUQp6P4840+8
         ymeB5V7hRK4B5UH+EEDHBUfXZYv6RKqd/LM6c5T+yXIe/Ev4jukuflifh9q/kDJqBU87
         9TwUdqrtqhbRbPh+JFk16YlKyyiXJSfRfm5CNzqmHsOyymwC4JYsHoyQAr2CWM5OBGl1
         ZgPm7JjlvLYcFR1R/ykeVCKcVzbkaC2te4HR1fBCDw3mfP2leUrzopoe7PsG8W+hEBMg
         3LHnhTrWVW0cpQPQ0azrtpAdwAE/uzd4Nq3f3a+O+fLN9WukoKr5Ga5/gfSKkay5+md9
         nhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693998443; x=1694603243;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hP3Q4zwhfkjEm0tc2IG4bz2zoQsKRY7LuWYMr41LgGY=;
        b=fgjOesN4l3n7EmBB7aMIHKoUY+aFNOaFQ3MstPndZmXPefxKGjlfCNIunrC4STu+dF
         kR07oGAKVPmjA1tGZEINSwD4AitljLY5w8iTLeQEvRRhiEpdtDlsbIs7zbuUh0gWAGxv
         F05aQB299lY8AJF+fXqHgewbnpwSMgN4gITVS+J7Fdom55naOc25oHmq00G0kVzYjvcO
         Z53JZw8TQASEQ05oFS/jfLJQnuaLTZB3+4vEGVrD+VzzjAnH8EAe9+IahVo/HQwI8SoO
         2KWfGBZWw8hvL7i6U8BP/S5wpjDHFwlNMm/PuNmbu0Ig4xt93OvPqL58D7n7N2dXXYMk
         Lmrw==
X-Gm-Message-State: AOJu0Yym2tYjQwcCNAh5DBnS0DMbavlsZpmvUQ/85Mwm8lncPSAdb0IS
        THqC3rBdyuM/2zFTSWtjtlpg6g==
X-Google-Smtp-Source: AGHT+IERJ+mF55KBBmcllnFSi/evw/MLX7Jn4sDpezkpyTXDb2g17UqmNMAy02XPFbkz9yt7Xpa8xw==
X-Received: by 2002:a17:907:60c6:b0:9a6:5696:388e with SMTP id hv6-20020a17090760c600b009a65696388emr1604752ejc.77.1693998443676;
        Wed, 06 Sep 2023 04:07:23 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id ja8-20020a170907988800b0099bd5d28dc4sm8775909ejc.195.2023.09.06.04.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 04:07:23 -0700 (PDT)
Message-ID: <8f306f3b-ab43-411c-9cd3-9e03b93602ee@linaro.org>
Date:   Wed, 6 Sep 2023 14:07:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] arm64: dts: qcom: qrb2210-rb1: Swap UART index
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230906-topic-rb1_features_sans_icc-v1-0-e92ce6fbde16@linaro.org>
 <20230906-topic-rb1_features_sans_icc-v1-1-e92ce6fbde16@linaro.org>
 <7bca9767-1112-4817-aac1-e6d720e92817@linaro.org>
In-Reply-To: <7bca9767-1112-4817-aac1-e6d720e92817@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 14:05, Dmitry Baryshkov wrote:
> On 06/09/2023 12:24, Konrad Dybcio wrote:
>> Newer RB1 board revisions have a debug UART on QUP0. Sadly, it looks
> 
> Nit: I think this is '.. revisions should have...'. Because I was told 
> that the board I got is the final design / production.
> 
>> like even when ordering one in retail, customers receive prototype
>> boards with "Enginering Sample" written on them.
>>
>> Use QUP4 for UART to make all known RB1 boards boot.
>>
>> Fixes: e18771961336 ("arm64: dts: qcom: Add initial QTI RB1 device tree")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Ugh. This should have been:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
>> ---
>>   arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts 
>> b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
>> index eadba066972e..5cda5b761455 100644
>> --- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
>> +++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
>> @@ -13,7 +13,7 @@ / {
>>       compatible = "qcom,qrb2210-rb1", "qcom,qrb2210", "qcom,qcm2290";
>>       aliases {
>> -        serial0 = &uart0;
>> +        serial0 = &uart4;
>>           sdhc1 = &sdhc_1;
>>           sdhc2 = &sdhc_2;
>>       };
>> @@ -357,7 +357,7 @@ key_volp_n: key-volp-n-state {
>>   };
>>   /* UART connected to the Micro-USB port via a FTDI chip */
>> -&uart0 {
>> +&uart4 {
>>       compatible = "qcom,geni-debug-uart";
>>       status = "okay";
>>   };
>>
> 

-- 
With best wishes
Dmitry

