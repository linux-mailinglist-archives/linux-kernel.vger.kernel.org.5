Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ED277B32F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjHNICN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjHNIBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:01:39 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A739F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:01:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe4a89e8c4so36851345e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692000097; x=1692604897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6iRD9A4irJNmOgu6eUxG8gRcHEW76etNPCgT+ma+/4M=;
        b=mtoe8izgXzHXuALrWwwyl/olIUk2+XnUPjPqEHhXpft+LZRT5+Wi24R9EIqRg911Fu
         Y51yihxEOqA/mUIs64B/6fNH/bDSgczY7eWaLQpZTTgbKR2G9nSa2Li0/swbJgoY3tA0
         AzhEuHZzd8PesLeCOYs3kXox5IbAiNgpZK88DmCcb+JZ5AwEA/vEE6Npc4r0JZ9yR0so
         I2c6QPgBQg63M+yps32jREj4fnUBKqAmQqlBYCsGxmW6doR/oWG2TVNaLLYSVqT/n/YH
         QqwbepB8SP4+uW8FO36S/2RrXJWavK799imH/TNeGjuYAURxF5r3nS7Y+vEjluSDWKaT
         c5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692000097; x=1692604897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6iRD9A4irJNmOgu6eUxG8gRcHEW76etNPCgT+ma+/4M=;
        b=iLvgYtpP3KdYkuwe65dAds+6ALFVycbhRPr5N6L5ou9/gxhtRyUnqnO8KYmSmRR+uh
         VBm25E/DsI6yvUKN0p6Uj4lZljziEh2VjP/hQrDbyeSnyhx9rdUhYpesW7VFCcba3RTt
         qKDOfFa6wM8c7KeqlbN1XOCEEOHMCtmvRkCoBoez/ch7q8dqqype6ITPjR+4NwwuHeX1
         2NQ3u5aQPSt+iwaGDX5ee21u5ZAHwU8a667ed/tReF9KYBaLPAQp9VLRTBnAchGKQhtk
         fF4VteVACdE7oqzxCSEICngkylL34WK4uyo1dXz52aWBvHNXzKBmpGV5bZtALcyQ4S/K
         r0LA==
X-Gm-Message-State: AOJu0YyWZHIbvMv4H15cLFSUUAEYcN5W7TtIDbLmDQL+dnDffJuhDHOY
        Y79r12gKyzab+vmf81U8l9nT8floUOi2xqdYkC3bEA==
X-Google-Smtp-Source: AGHT+IHl+WyUuKJlARfd8AJ8xAj3jeBTIhgTCUmlckWdRylYB0YEauFV5hliIuK5c5ePGXkYuElu1A==
X-Received: by 2002:a7b:c307:0:b0:3fe:1c33:2814 with SMTP id k7-20020a7bc307000000b003fe1c332814mr6794323wmj.30.1692000096756;
        Mon, 14 Aug 2023 01:01:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c229100b003fc01f7a42dsm7998151wmf.8.2023.08.14.01.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 01:01:36 -0700 (PDT)
Message-ID: <1dfaf72b-1e2a-e771-39f9-c3a5cf1c8463@linaro.org>
Date:   Mon, 14 Aug 2023 10:01:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sc7180: Add board id for
 lazor/limozeen
Content-Language: en-US
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     agross@kernel.org, andersson@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        dianders@chromium.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        robh+dt@kernel.org
References: <20230809064908.193739-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20230809144516.v3.3.Ie77732a87ab53d21bac47db309b75a796fa19337@changeid>
 <cd15df3a-eadc-13d6-7088-3ad785ea733e@linaro.org>
 <4e05a1fb-f6f2-3219-b41d-67351c70a7ff@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4e05a1fb-f6f2-3219-b41d-67351c70a7ff@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2023 05:46, Sheng-Liang Pan wrote:
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> On 10/08/2023 11:30, Sheng-Liang Pan wrote:
>>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>>> Isn't this duplicated with r9? Probably other places as well... or....
>>>> separate r10 add rt5682s node which different with r9.
>>> we separate r10 add rt5682s which differentwith r9
>>>
>>>
>>>>> -	model = "Google Lazor Limozeen without Touchscreen (rev9+)";
>>>>> -	compatible = "google,lazor-sku6", "google,lazor-sku18", "qcom,sc7180";
>>>>> +	model = "Google Lazor Limozeen without Touchscreen (rev9)";
>>>>> +	compatible = "google,lazor-rev9-sku6", "google,lazor-rev9-sku18", "qcom,sc7180";
>>>
>>>> Your patch 2 does not make any sense. Didn't you touch it in patch 2?
>>>> Really, what is happening here?
>>> patch 2 explain why we added new sku for no-eSIM.
>>
>> So which commit explain why you touch the same line twice? Sorry, this
>> does not make sense.
>>
>> Best regards,
>> Krzysztof
> 
> We sort patch by change order,
> fist request for non-eSIM, patch2 add new sku 10, 15 for non-eSIM, and 18, but keep the newset reversion is r9,
> after add non-eSIM SKU, a sencond request for ALC5682i-VS, 
> so continue patch2 we upreversion r10 which include rt5682s node.

I barely can parse it, but anyway does not look right. You explained
what you are doing but it does not explain why touching the same line
twice. There is no point in making one board new SKU, but then
immediately change it to something else. The previous commit is just no-op.

Best regards,
Krzysztof

