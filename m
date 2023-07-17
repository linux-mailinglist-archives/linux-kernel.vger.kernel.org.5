Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2848D755D12
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjGQHgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjGQHgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:36:08 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC13186
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:36:06 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51f90f713b2so6368660a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689579365; x=1692171365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jqT+iFyS34vkrxYBHX/puqSX/t6Fdl3YR5Gn4hTNWmk=;
        b=DD9TPlON+krHvCo42f5dKfAAnK50pBRStg0YHIqwjxIR17RTB1W1r+09PXSyxzuP+S
         5n1+khZgAs6+tUBhlsgNDumiheAs6SCoM/UiwUuxdH1S/pmYoDR0Lz+hvM0z69YZep8K
         DAomM1Ec2HTKIIEbuUfvlIWI8lNIcT9Vwy1qoFdDNDxpNFHui7z+RhlBkmhdjN3u6aH5
         48scNofXa5O52gRPKfZh55Scm8fi1yx8MWhn1psrocv13Kz/BVv6ErlUJr3Q89NGCZuO
         qsuVrdzHVKZXz9IapFsbAlGDrNPmeXjZMz9ARy/JpW42B8WPNZccvVSSix4/G/AfTGxP
         qzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689579365; x=1692171365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jqT+iFyS34vkrxYBHX/puqSX/t6Fdl3YR5Gn4hTNWmk=;
        b=BxuizkKG5czCJIGAzY9/AtHKn+UnY9bitjzd2oRKsNoUDCPIVbMflKP7evuglmjCmg
         j3kgdxt1ealWUpJiFRTHVwwobNhlBIw/iPyWYQgNiu265kcMrmG1ZmhrHcXR1SFXyUVa
         w+K1o+W8C6K90f2baaRMSM+hqePyBaza9pb/GI0Srkm2oB+BerGYwg05j0xvT8g0AgiN
         6ZAfguFq7/nI9uDymAOgHDjnaoTO57kI8SthfiFzgo7bWctyaSuZw/+712AqYNlsm2tq
         NKph/TInx92x54Vv6UxslOR2SVpxcSlJ5YbjkIFAyGdpcK665tPtA2LvIQ/dSz1MwNOY
         O/iQ==
X-Gm-Message-State: ABy/qLYeA5oYN+XW714SzVf4llnMcvyGQMhD5MUPuI9d42BdG7f53l9i
        HjS1WYsyZFk7NI0OQ8A7hA+fPg==
X-Google-Smtp-Source: APBJJlFHbePd2LG7loIwJ/95MB+gYsFBOZB4Cxq0f1JYSNmyiAWfvRxUQ6TzZbjKvVuxAr2d5Mya5A==
X-Received: by 2002:aa7:d4c7:0:b0:51d:d4c3:6858 with SMTP id t7-20020aa7d4c7000000b0051dd4c36858mr11137044edr.12.1689579365024;
        Mon, 17 Jul 2023 00:36:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w24-20020aa7cb58000000b0051e0f8aac74sm9623910edt.8.2023.07.17.00.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 00:36:04 -0700 (PDT)
Message-ID: <2aa65957-61d5-8e06-5a50-a4750f6dd44b@linaro.org>
Date:   Mon, 17 Jul 2023 09:36:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/7] dt-bindings: soc: qcom: Add qcom-pbs bindings
Content-Language: en-US
To:     Anjelique Melendez <quic_amelende@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, pavel@ucw.cz, lee@kernel.org,
        thierry.reding@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, u.kleine-koenig@pengutronix.de,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <20230621185949.2068-1-quic_amelende@quicinc.com>
 <20230621185949.2068-2-quic_amelende@quicinc.com>
 <20230626135857.GA3118929-robh@kernel.org>
 <2e871e21-a81d-0d7d-993b-9a9d7bd9d962@quicinc.com>
 <e7298704-5a03-0961-90a3-dab4af60c326@linaro.org>
 <32e9a512-fd74-b2f6-6b8a-fefb9ad5912d@quicinc.com>
 <431faa87-d152-5f7a-40fd-8b6fe26f0bb9@linaro.org>
 <71e1f36f-8fd8-9d61-d563-577d4fb54f10@quicinc.com>
 <69c01f0f-4eb0-bb44-a238-5c9ce5beede9@linaro.org>
 <CAA8EJppCSnEg1GjX8CavxRPiiE19JwVAOTspjWJR-OzdQMcu+g@mail.gmail.com>
 <7ecf968b-45b2-c6b7-86a7-8d8caccf5002@linaro.org>
 <511a84a8-ecb4-13bb-2eab-982b19758ba5@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <511a84a8-ecb4-13bb-2eab-982b19758ba5@quicinc.com>
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

On 14/07/2023 22:32, Anjelique Melendez wrote:
> 
> 
> On 7/12/2023 1:11 PM, Krzysztof Kozlowski wrote:
>> On 12/07/2023 16:35, Dmitry Baryshkov wrote:
>>>>>> Rob asked you - "Is there more than 1 instance in a PMIC?" - and you did
>>>>>> not answer positively, just mentioned something about drivers in
>>>>>> downstream, which do not matter. So is the answer for that question:
>>>>>> yes, you have two instances of the same PMIC differing by presence of
>>>>>> PBS and other features"?
>>>>>>
>>>>> Sorry that was a misunderstanding on my part.
>>>>> Yes, answer to Rob's question should have been "We have two instances of PMI632,
>>>>> where one instance holds the pbs peripheral and the other holds the lpg
>>>>> peripherals. The child node for pbs is needed so lpg client can access
>>>>> the PMI632 regmap which contains the pbs peripheral."
>>>>
>>>> I guess I miss here something. What is "LPG client"? I don't understand
>>>> why this LPG client needs existence of PBS node, to be able to get the
>>>> regmap.
>>>>
>>>> PBS is a child of PMIC, so it can get regmap from the parent. What's
>>>> more, which DT property passes the regmap from PMIC to LPG client?
>>>
>>> There are some PMICs which claim two SPMI SIDs. For such PMICs, each
>>> SID is a separate device, so it is not directly possible to get the
>>> regmap of the other SID.
>>
>> OK, maybe after implementing all the review changes - including dropping
>> that singleton pattern - this will be clearer. Please send new version
>> and we will discuss it from there.
>>
> Sure, will work on getting that new version sent but I did just have clarifying question.
> When you say "dropping that singleton pattern" are you referring to dropping the 
> PBS node?
> Want to make sure we are all on the same page with what the next version will include :)

I was referring to my comments on driver, that you should not have
file-scope variable and get_pbs_client_device() iterating over global
list. It isn't singleton, actually, but the pattern in coding is very
similar to singleton approach.

Best regards,
Krzysztof

