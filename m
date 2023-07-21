Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A8875C2F7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjGUJX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjGUJXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:23:19 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6723D2706
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:23:03 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3158a5e64b6so1372180f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689931382; x=1690536182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=88mpJoGLk3K0AQWL88TAAFTQ19gJNfzpATcUNHu1Koc=;
        b=A+o5T3bCIR9n12ySKKl6prib5i7UzIIG06/C1FKIJTMqBJxOPxO3yVgXl/x2c2n5bq
         cQVjaP57pYdANYqdzzpY8B6mFa+r7icw169QzeSbSsp7iuAunaaE+SIzIaV0MgBS/g/h
         kvgJ+9tiy+oLY6Kw7nOgmRu28xMtJeb/1w1gelhnbdj+gF7SJm5pMk8O07on5KTNfwat
         qJKTNTC4z99ObGq4RMrMx42ykQcom4W3E0isA9Sg+WScNJfa79Qd015ltEEXX4et02n7
         E0+yIT8k7xK8P/VtnQJXi3b1n/0aQLJ3fY4uPEKpV3pQrt65E8gXYLqeK1pxDlI0AkUK
         gJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689931382; x=1690536182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=88mpJoGLk3K0AQWL88TAAFTQ19gJNfzpATcUNHu1Koc=;
        b=I6KOxNcUblzrlJvjd4edtySB5vwreziRkKXbyaztdkygj20nVQMeqMiYcw1WLCg7iV
         tKGrxQozlIDW9UPsO+Z/8Wv32MRrTwQlZMQ3ft9rG2yUlhmgMKd3SNlj9LhC6QbZzyYF
         IlkV0WqWUIxsiERNuBRTtEVLUca0ZPcfAfSJqVmeee+lhasBLohTIjUbBuZsoggwiI4/
         A4CXWOY0zRTu98XEdaHA8MP3GEI50nDWexy4aoMOXVcAUBMZPNXOxvAns37puq2JMpbJ
         OOgdkgpaSygg9PsjzREPChpI9frWRkX8jHycNFv9KXQjmV3qlI0/iCS8jGnDWfs2eS1J
         fqMQ==
X-Gm-Message-State: ABy/qLbtxT0m2x0+ZFnahIq4b3XSOm2Ta2kH0ExOGHgJlu3Bdha7t+Ro
        H+mhvwTsW5h+kHeoLzbe78JCKA==
X-Google-Smtp-Source: APBJJlGPiAHr1rhA6JqTZrNomxprYe2CukiWc5LIrT8c34tXmSQ3b6yHlXfBSW9vj5UxkGnNFcDL2g==
X-Received: by 2002:adf:df01:0:b0:313:ef24:6fe6 with SMTP id y1-20020adfdf01000000b00313ef246fe6mr1087215wrl.1.1689931381764;
        Fri, 21 Jul 2023 02:23:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id j6-20020adfff86000000b0031274a184d5sm3623920wrr.109.2023.07.21.02.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 02:23:01 -0700 (PDT)
Message-ID: <846fad90-04b1-53e7-0f9d-1c243bbc6e92@linaro.org>
Date:   Fri, 21 Jul 2023 11:22:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [v2 PATCH] arm64: dts: stratix10: add new compatible for Intel
 SoCFPGA Stratix10 platform
Content-Language: en-US
To:     "Li, Meng" <Meng.Li@windriver.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230721083821.1820881-1-Meng.Li@windriver.com>
 <b8333812-df9d-368a-939b-3495878a2e5e@linaro.org>
 <884ed5d5-8863-ac76-5f00-4ed58480e9ab@linaro.org>
 <PH0PR11MB5191F52F01EF337A5965F848F13FA@PH0PR11MB5191.namprd11.prod.outlook.com>
 <2dac9cb5-2582-2e5d-689d-49ced2dbde5b@linaro.org>
 <PH0PR11MB51918208B7FE0413548F2DE5F13FA@PH0PR11MB5191.namprd11.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PH0PR11MB51918208B7FE0413548F2DE5F13FA@PH0PR11MB5191.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2023 11:21, Li, Meng wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Friday, July 21, 2023 5:19 PM
>> To: Li, Meng <Meng.Li@windriver.com>; dinguyen@kernel.org;
>> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>> devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Subject: Re: [v2 PATCH] arm64: dts: stratix10: add new compatible for Intel
>> SoCFPGA Stratix10 platform
>>
>> CAUTION: This email comes from a non Wind River email account!
>> Do not click links or open attachments unless you recognize the sender and
>> know the content is safe.
>>
>> On 21/07/2023 11:05, Li, Meng wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> Sent: Friday, July 21, 2023 4:54 PM
>>>> To: Li, Meng <Meng.Li@windriver.com>; dinguyen@kernel.org;
>>>> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
>>>> robh+conor+dt@kernel.org;
>>>> devicetree@vger.kernel.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Subject: Re: [v2 PATCH] arm64: dts: stratix10: add new compatible for
>>>> Intel SoCFPGA Stratix10 platform
>>>>
>>>> CAUTION: This email comes from a non Wind River email account!
>>>> Do not click links or open attachments unless you recognize the
>>>> sender and know the content is safe.
>>>>
>>>> On 21/07/2023 10:51, Krzysztof Kozlowski wrote:
>>>>> On 21/07/2023 10:38, Meng Li wrote:
>>>>>> Intel Stratix10 is very the same with Agilex platform, the DWC2 IP
>>>>>> on the Stratix platform also does not support clock-gating. The
>>>>>> commit
>>>>>> 3d8d3504d233("usb: dwc2: Add platform specific data for Intel's
>>>>>> Agilex") had fixed this issue. So, add the essential compatible to
>>>>>> also use the specific data on Stratix10 platform.
>>>>>>
>>>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>>
>>>>> From where did you get it?
>>>>>
>>>>> Did you just fake a tag to pass the review?
>>>>
>>>> I just double checked my replies and this for sure never happened.
>>>>
>>>> NAK, don't fake reviews. This very impolite and destroys entire trust.
>>>> The model of upstream collaboration depends on the trust, which is
>>>> now gone for Windriver.
>>>>
>>>
>>> No! I don't fake a tag.
>>
>> Really? Then I ask second time - from where did you get it? Provide a link.
>>
> 
> https://lore.kernel.org/lkml/20230718030851.2014306-1-Meng.Li@windriver.com/T/

So where is it? You pointed to your email. Where is the tag?

Best regards,
Krzysztof

