Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E938E77C099
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjHNTSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjHNTSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:18:44 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AC2E61
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:18:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe2048c910so43209765e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692040721; x=1692645521;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72S2n2lYPlrUM7ALoHtN9DEXfa2PT84mmokJwTNUvmk=;
        b=TBb8grKi7j+lELjw3Ihzgfgf18E8CY0MRN/h+FGwbfymfjb1yxo0fCAIWwB3UbsQS6
         WeInwfinusQ9UEdLRBDby+avB+k8ncrYk8BPtFAE3wm91XzJ+Y0QINjEx0+ZpE5aUmbD
         wNv/jMgiaquqemZkBlLIPNTqifydMmomZnZ/XBH8h3szl4XBkwm+NGiyOdfW79HFDpLN
         vrWKQbPRWL56kFUcNlLgUOBopKfYTvm82ecGOVEHj7x+H4QOU3Gp16iIlmK+7ppa1SNt
         J7uqcXY1w4KEnFqY9pJg3V8ONHQAkdWHPwj+ArDmjBgX8zC+LcZzQB6oBkO10zcibY61
         BfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692040721; x=1692645521;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72S2n2lYPlrUM7ALoHtN9DEXfa2PT84mmokJwTNUvmk=;
        b=NK+iKcF7fiwnUynHyjxGJJAr3s8rU3v1gySVb/NDDP6gRO6G2BL9+twTrA2uGALV42
         dol3ThhaYlS8khqqLQHks2fsobXNF7CKOFiYbJoDIfxmcRMo2J4KTs+RRPc7DYvy0F6q
         HtMFKSTjnhCP4wk9LjTvWsS0hO4gOYdeS3N/q6q8fVZv8Avv6UZO0cgDToXH785o+z48
         7oVKj+MWEUPNb9tkWAmVHRKKshaCTVshOwo5tVcGVKk9Rgzxsbgyp9m0Doz+P24tWnYx
         rH1njiuTtclhV9zRkrP1UfjJpzEXCPHhmsiRFpo0lMDuVaCMUp0vWiojzifOxtvyyOg6
         YaOA==
X-Gm-Message-State: AOJu0YzT3fueEqQCPvm/mX9HSsWUhs3y+eVotclW0tvYOwuex5fFJ8Y/
        yfY3Sm6aYOlE187/dYJHl+Vixw==
X-Google-Smtp-Source: AGHT+IEeFPxWx2KSxTh6FCCps3OOKBDVdbRhF6OY2QRxepJQgs6kH8Obt3EcA9VGUfe6+GdUAdjj4w==
X-Received: by 2002:adf:db0a:0:b0:314:2e95:1ec9 with SMTP id s10-20020adfdb0a000000b003142e951ec9mr7902967wri.10.1692040721649;
        Mon, 14 Aug 2023 12:18:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c234b00b003fbca942499sm18034835wmq.14.2023.08.14.12.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:18:41 -0700 (PDT)
Message-ID: <b911cd23-8590-55bb-7606-718f16e8ed42@linaro.org>
Date:   Mon, 14 Aug 2023 21:18:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/2] gpio: dt-bindings: add parsing of loongson gpio
 offset
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Conor Dooley <conor@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn
References: <20230807074043.31288-1-zhuyinbo@loongson.cn>
 <20230807074043.31288-2-zhuyinbo@loongson.cn>
 <20230808-amount-urban-9a6eb09852ca@spud>
 <536a9062-65b2-5518-5c50-1a61e23870ee@loongson.cn>
 <20230809-circus-photo-6911d2e18f96@spud>
 <d4e16768-bed0-beda-42c3-f0a01b7e96cc@loongson.cn>
 <CAMRc=Mc00yy6DxdEos_w7HAkAwH7j0HBvkbQbaQiA_wTXiwFUg@mail.gmail.com>
 <80325b72-e7b3-08cc-f726-513de75de94c@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <80325b72-e7b3-08cc-f726-513de75de94c@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2023 05:39, Yinbo Zhu wrote:
> 
> 
> 在 2023/8/11 下午10:25, Bartosz Golaszewski 写道:
>> On Thu, Aug 10, 2023 at 8:19 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
>>>
>>>
>>>
>>> 在 2023/8/9 下午11:39, Conor Dooley 写道:
>>>> On Wed, Aug 09, 2023 at 03:47:55PM +0800, Yinbo Zhu wrote:
>>>>> 在 2023/8/8 下午8:05, Conor Dooley 写道:
>>>>>> On Mon, Aug 07, 2023 at 03:40:42PM +0800, Yinbo Zhu wrote:
>>>>
>>>>>>> +  loongson,gpio-ctrl-mode:
>>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>>>> +    description:
>>>>>>> +      This option indicate this GPIO control mode, where '0' represents
>>>>>>> +      bit control mode and '1' represents byte control mode.
>>>>>>
>>>>>> How is one supposed to know which of these modes to use?
>>>>>
>>>>>
>>>>> Byte mode is to access by byte, such as gpio3, the base address of the
>>>>> gpio controller is offset by 3 bytes as the access address of gpio3.
>>>>>
>>>>> The bit mode is the normal mode that like other platform gpio and it is
>>>>> to access by bit.
>>>>>
>>>>> If both modes are supported, it is recommended to prioritize using byte
>>>>> mode that according to spec.
>>>>
>>>> So, sounds like this property should instead be a boolean that notes
>>>> whether the hardware supports the mode or not, rather than the current
>>>> enum used to determine software policy.
>>>
>>>
>>> okay, I got it, I will use boolean,
>>>
>>
>> Why do you want to put it into device-tree so badly? This is not the
>> first driver that would have of_match_data for different variants
>> where you can have a structure that would keep offsets for different
>> models. It's not like you will have hundreds of "compatible" chips
>> anyway, most likely just a few?
> 
> 
> Using this ways that put offset property into device-tree that can be
> compatible with future GPIO chips without the need to modify drivers,

That's not an argument for putting into DT.

> such as more 2K chips in the future, but use of_match_data and data
> field of_device_id, which every time a new SoC is released, the GPIO
> driver needs to be modified once, which is not friendly to us.

Sorry, "friendly" is again hardly an argument what should or should not
be in DT.

Best regards,
Krzysztof

