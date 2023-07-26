Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD48B763751
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjGZNQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbjGZNP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:15:58 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917792127
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 06:15:52 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f954d7309fso1302353e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 06:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690377351; x=1690982151;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kCgEAnQldbWSshS+6UesBxXb+/eschag6NjEzTyYfa8=;
        b=CseQ0KYHYZZa0X7rrG4Bskpw5tABmqHqvo11Bhw7TtDzn+9/b9PUChRsCy2XbZn2It
         X8LWcmsD2kHeqvHKBNbHrvC+vwIwWHN3TnyvWLtiEtOJ8n383x8cjtiYJL9OuEAsu9vE
         lW8bdq9pqLdLNexP3eZdpJedZeJIeBAZNPOW0e7L3EUILqlQ2gdMgDrQ7pAmDIs0VxjW
         rUHqZ2JJHMzvHDs92k2rv0jIVv+nJOLpSFWYKYdEZVFuqixpQqOxZsCO4iGgPXJFEenT
         QZLFtDQ/o9lAXJZyJYHOOBmKJB30xl8BcN2fI2ypAXFyM3pApgDnXouSXMM5BdwBww6k
         TzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690377351; x=1690982151;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kCgEAnQldbWSshS+6UesBxXb+/eschag6NjEzTyYfa8=;
        b=TzYdYX7JvFZcZrDeciociBDXBa1asyQJ1Ho0iBJv/EsSHgS1p3swjEOvmjiLs5aXS5
         wfIdqwO4qr7fgyol0H6ywyvr6hLTaMn3oUJ9EOmQfvMQPHVI+FvmEb75QyIg64lKJuy3
         34wS7IfW/c9RSW3xJ+QSUCvUPKQ3Eg4++5qv4uG3NqqzuMAqTxDayWUJSdmsoEZB9Vdt
         Nfq70omq/2L5RQvqDRPG6F3A8nChfQDfnHNqT31JhaRac6eFGoXygVNenFb7mSz9JjO8
         eChVwdTKbD+LlqoLvnG3kHbpBaMzWApGCEzbuTmwsCDD3D22NYK0dIaBey8yczc41S4j
         syyA==
X-Gm-Message-State: ABy/qLYcT4zm/ovEE16YTz+FvSCRqRfbOvoAeRro/pprhm2t2P2Lm/x8
        YZM7+RKb8XeqKqUXOLgKmhzXAQ==
X-Google-Smtp-Source: APBJJlFPqqbf4K9dM5wgRbIKUsSBqxqeeMPrkrrT0+xpxgRCvU3YrZK42DFyjtViSnUsFS86ouqtpQ==
X-Received: by 2002:a05:6512:31d1:b0:4fb:7371:3db6 with SMTP id j17-20020a05651231d100b004fb73713db6mr1699084lfe.29.1690377350680;
        Wed, 26 Jul 2023 06:15:50 -0700 (PDT)
Received: from [192.168.1.101] (abyl59.neoplus.adsl.tpnet.pl. [83.9.31.59])
        by smtp.gmail.com with ESMTPSA id m9-20020a056512014900b004fb8ff1f531sm3248476lfo.70.2023.07.26.06.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 06:15:50 -0700 (PDT)
Message-ID: <2bcad16b-ed94-357f-5153-372a216ce958@linaro.org>
Date:   Wed, 26 Jul 2023 15:15:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Add BQ Aquaris M5
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230724-bq_m5-v1-0-17a0870a73be@apitzsch.eu>
 <20230724-bq_m5-v1-1-17a0870a73be@apitzsch.eu>
 <877c6d2c-430f-b1fb-4267-18be5d7256dc@linaro.org>
 <d51dee67-02f4-1256-877f-61629c04b08f@linaro.org>
 <a90461fa-8319-5b87-397f-53ba169a3d31@linaro.org>
 <1717ccb1-46b3-8ac3-2c09-9558bd12cc40@linaro.org>
 <d9cb0908-4074-2f01-efaf-cdd863a039f2@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <d9cb0908-4074-2f01-efaf-cdd863a039f2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.2023 09:34, Krzysztof Kozlowski wrote:
> On 25/07/2023 12:03, Konrad Dybcio wrote:
>> On 25.07.2023 11:43, Krzysztof Kozlowski wrote:
>>> On 25/07/2023 10:13, Konrad Dybcio wrote:
>>>> On 25.07.2023 07:46, Krzysztof Kozlowski wrote:
>>>>> On 24/07/2023 22:52, André Apitzsch wrote:
>>>>>> Add a compatible for BQ Aquaris M5 (Longcheer L9100).
>>>>>>
>>>>>> Signed-off-by: André Apitzsch <git@apitzsch.eu>
>>>>>> ---
>>>>>>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>>
>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>>
>>>>>
>>>>> ---
>>>>>
>>>>> This is an automated instruction, just in case, because many review tags
>>>>> are being ignored. If you do not know the process, here is a short
>>>>> explanation:
>>>>>
>>>>> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
>>>>> versions, under or above your Signed-off-by tag. Tag is "received", when
>>>>> provided in a message replied to you on the mailing list. Tools like b4
>>>>> can help here. However, there's no need to repost patches *only* to add
>>>>> the tags. The upstream maintainer will do that for acks received on the
>>>>> version they apply.
>>>>>
>>>>> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
>>>> Krzysztof, update your bot to paste this link with s/v5.17/latest/g
>>>
>>> Is there any difference? :) I would need to update links in all my
>>> templates and re-check the links...
>> Don't know, but the keyword "latest" in the link always points to the..
>> latest available release
> 
> And how do you update the line marker in "latest" version, so it points
> to exact line I want? I could switch to latest kernel doc and point to
> chapters, but then not to specific lines.
Hm, right. Didn't think about that.

Konrad
