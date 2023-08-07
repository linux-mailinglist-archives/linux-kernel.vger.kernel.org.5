Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79E2772E15
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjHGSog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjHGSod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:44:33 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153171722
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 11:44:31 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe426b8583so42291475e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 11:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691433869; x=1692038669;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zol9Y1aLsvmdyfqvAX1V5FxzXvCH4Sriw98PTemVe/Y=;
        b=vjyhPkEwkKxlqSi04SjKJd3eMNMokdMkJK1iLWhFCbhIqmWw11MawDEdbbsai/YNKD
         6Qpx8J59b/tBL4kqDdfm4yBWCRakUxcysqa38qCjOa/k3By/sLdHIlI/9lg1SVgReyg3
         NvCIpoHCeGFfQsvtSL5u9pM972PO+FJXo1+a6j/yLhbU+7lqTyetKKLqafZmM+zf1HgW
         gIGjderr/ZVvF8JRbLbzig6HT5wgBramYWjQd5zGDyVIgvIal15uEIVfsq8QaDILBsag
         TNAo6gdW5QDmZMCkaJiPhE4mmmMCf31Bcc3PNrqRwI+XZocg4tYilx91WSuobeFP1khG
         g6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691433869; x=1692038669;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zol9Y1aLsvmdyfqvAX1V5FxzXvCH4Sriw98PTemVe/Y=;
        b=T83P1krA1dZzI7WyqTGWt0yadsh1v1c/BIM9U5UuxNp9382SW4QSwizJ/Gmvcnm6+K
         pAl2FbIqhjfNEAEK8ctg50TWoXJOACktgnYv8GlgQnkBMIwiDPkGK9aDcCV6BNexM+Ew
         q1ByJDT7NTCrAFCrJlk4zb9n5N0NZr0AJCUBaU1FVfa50/rKfHMRL/TpDpIN6FDuu2uL
         IRxewDyZuuWZDey5HhXycTs4AFccpESqGnyBEek3pzRcKM81agfvlntfRV+/v1ZUlLEb
         H7xw8XBUIOPQlrTkCJbUX5P9OS6ag4VvYHXO5/F6RryTjjwdIicxxYqBxe8yeJEWevE+
         cMlQ==
X-Gm-Message-State: AOJu0Yy851AtUD0xOhyMRuedkupXt8+SAuGZZhsp6TrzS31Gye3WU/8r
        L/sp9oiTBDvx+EpcvJNuWyDZpg==
X-Google-Smtp-Source: AGHT+IGkU+sRFzXebcv1bEtGyvJz3C5vtCBxWmEJ2Tp8v0Xoa905AJwzisVYBKC4XbijduimSwLgbA==
X-Received: by 2002:a1c:6a05:0:b0:3fb:415a:d07 with SMTP id f5-20020a1c6a05000000b003fb415a0d07mr7951188wmc.36.1691433869440;
        Mon, 07 Aug 2023 11:44:29 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d5-20020a5d6dc5000000b003142ea7a661sm11317894wrz.21.2023.08.07.11.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 11:44:28 -0700 (PDT)
Message-ID: <816359f7-ad4d-659f-db39-c971e1b1cd9a@linaro.org>
Date:   Mon, 7 Aug 2023 19:44:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/6] media: dt-bindings: Document SC8280XP/SM8350 Venus
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230731-topic-8280_venus-v1-0-8c8bbe1983a5@linaro.org>
 <20230731-topic-8280_venus-v1-1-8c8bbe1983a5@linaro.org>
 <84ab9380-2fb2-76f9-2eb9-71d9202718cc@linaro.org>
 <659e30a7-80f7-4fd8-af58-45505213a2ef@linaro.org>
 <ba40de82-b308-67b1-5751-bb2d95f2b8a5@linaro.org>
 <fa5dc696-6c67-49d0-b158-f1e3398813e2@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <fa5dc696-6c67-49d0-b158-f1e3398813e2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 16:02, Konrad Dybcio wrote:
> On 7.08.2023 16:04, Krzysztof Kozlowski wrote:
>> On 07/08/2023 14:41, Konrad Dybcio wrote:
>>> On 5.08.2023 21:29, Krzysztof Kozlowski wrote:
>>>> On 04/08/2023 22:09, Konrad Dybcio wrote:
>>>>> Both of these SoCs implement an IRIS2 block, with SC8280XP being able
>>>>> to clock it a bit higher.
>>>>>
>>>>
>>>> ...
>>>>
>>>>> +
>>>>> +  iommus:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  video-decoder:
>>>>> +    type: object
>>>>> +
>>>>> +    properties:
>>>>> +      compatible:
>>>>> +        const: venus-decoder
>>>>
>>>> That's not how compatibles are constructed... missing vendor prefix, SoC
>>>> or IP block name.
>>>>
>>>>> +
>>>>> +    required:
>>>>> +      - compatible
>>>>> +
>>>>> +    additionalProperties: false
>>>>
>>>> Why do you need this child node? Child nodes without properties are
>>>> usually useless.
>>> For both comments: I aligned with what was there..
>>>
>>> The driver abuses these compats to probe enc/dec submodules, even though
>>> every Venus implementation (to my knowledge) is implicitly enc/dec capable..
>>
>> Holy crap, I see...
>>
>>>
>>> Perhaps a bigger clean-up is due. I guess I could just create the venc/vdec
>>> devices from the venus core probe and get rid of this fake stuff?
>>
>> Few devices (qcom,msm8996-venus.yaml, sdm660, sdm845) have clocks there,
>> so we actually could stay with these subnodes, just correct the
>> compatibles to a list with correct prefixes:
>>
>> qcom,sc8280xp-venus-decoder + qcom,venus-decoder
> Hm.. looks like pre-845-v2 (with the v2 being "v2 binding" and not
> "v2 chip" or "v2 hardware") these were used to look up clocks but
> then they were moved to the root node.
> 
> I am not quite sure if it makes sense to distinguish e.g.
> sc8280xp-venus-decoder within sc8280xp-venus..
> 
> Perhaps deprecating the "8916 way" (clocks under subnodes), adding
> some boilerplate to look up clocks/pds in both places and converting
> everybody to the "7180 way" way of doing things (clocks under venus),
> and then getting rid of venus encoder/decoder completely (by calling
> device creation from venus probe) would be better. WDYT?
> 
> Konrad

As I understand it though, for some classes of venus hardware - earlier, 
it was possible to have two encoders or two decoders and it really 
didn't - perhaps still doesn't matter which order they are declared in.

That's the logic behind having a compat string that assigns either 
encoder or decoder to one of the logical blocks.

You can have any mixture of
- encoder
- decoder

- encoder
- encoder

- decoder
- decoder

- decoder
- encoder

- encoder

- decoder

I think it should *still* be the case - whether it is a practical 
reality or not, that any of those mapping can be selected and supported.

---
bod
