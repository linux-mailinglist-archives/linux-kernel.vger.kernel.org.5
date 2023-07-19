Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7C8759C44
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjGSRUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjGSRUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:20:09 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E4B197
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:20:07 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbdfda88f4so65784045e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689787206; x=1692379206;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tryqWINbuaEc88iTrVyHMsqPdFzMjV4Usg4i5lKUzxg=;
        b=BFhym1rSHwx5Or+Pii0FqmZpyk6fWpZjZKuo/9KNL6cngJ1bY3HlQ6rlV5EcJyFRLw
         31K4RtM628f51v3S8c5Qi0K+lV2LP3yEBUDlYdKQn5eZ1TR5bO0zO4gWNUqeMYgLprrV
         vsj44XHkZLFHVH7Lhy1WesZcIkZQIaceksaTSd13I8/6O1HJMGeEhvgpy6H/EzHjdzoZ
         j8BPZjt1gCWP0rBB0a5szfWaRB71TzqswPLfbYyCb/6N/CQ6Cu6X5jO8liFDTkAIa4Ja
         ywl1hQ9WidgV5njtS2Ml2ZnGxg8JPyfLbqHf+t+NNiz6J5eWzBNa4yr/dQEH8Ul2zmMk
         xSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689787206; x=1692379206;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tryqWINbuaEc88iTrVyHMsqPdFzMjV4Usg4i5lKUzxg=;
        b=S22TErZUveO0SBEJqqI7md2hhj2nBtqT6yIVS6x5bDfUb229bprkf2RgXTb3Agmfsf
         QTAAByNuDtzuWWqWzdLC2sgp0QQaRu2YgodN/6QEnSqkKdVGTP1WfYS+kL9NhbK9CiJ/
         2x6maUrjaqLPB2mZ37ihJZ13ADzJfpVQvoV6HFRHG/zQPongJFcE0rrPCm4TSP68BAYt
         jAyAZQK1pcXPPVOVSU0IrbKQ34o9E47AjAajaM/TfFxoVS1mtkNixvRnI4bmn0ydEgW/
         9TzoDhorOGGc8RArmVN3EfnX8jTryt/Ny10ratCvDltmi8HMUXnnir0DZkrdb6EtSBKB
         BJhg==
X-Gm-Message-State: ABy/qLbcGpg2yLeo8t/XTMcnysH0iA6fOeFFWYj9JubIlYcveHszuZh+
        aFUkVPGTrwQMnJsiVaGr1ZLCdA==
X-Google-Smtp-Source: APBJJlERLjXGvjJSJjU1AMkKL+pqkSk/vqOk8N4LMFX++aVs21FOCvyEtjc8FdvLbnLuf1/njZiDZw==
X-Received: by 2002:a05:600c:2113:b0:3fb:ba04:6d5d with SMTP id u19-20020a05600c211300b003fbba046d5dmr49523wml.12.1689787206013;
        Wed, 19 Jul 2023 10:20:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c204300b003fc3b03e41esm2485270wmg.1.2023.07.19.10.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 10:20:05 -0700 (PDT)
Message-ID: <3bff674f-791b-74bd-da1c-13b6596ea276@linaro.org>
Date:   Wed, 19 Jul 2023 19:20:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Content-Language: en-US
To:     Marius.Cristea@microchip.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org
Cc:     conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230714150051.637952-1-marius.cristea@microchip.com>
 <20230714150051.637952-2-marius.cristea@microchip.com>
 <d0682516-28aa-dbfc-81d1-33300c669835@linaro.org>
 <3d5cc96388f27b1f03f5a1d3bee7113686548e43.camel@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3d5cc96388f27b1f03f5a1d3bee7113686548e43.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 17:40, Marius.Cristea@microchip.com wrote:
> Hi Krzysztof,
> 
>>> +
>>> +patternProperties:
>>> +  "^channel@([0-9]|([1-7][0-9]))$":
>>> +    $ref: adc.yaml
>>> +    type: object
>>
>> Missing unevaluatedProperties: false.
>>
>> Open other bindings and look how it is done there.
>>
>>> +    description: Represents the external channels which are
>>> connected to the ADC.
>>> +
>>> +    properties:
>>> +      reg:
>>> +        description: The channel number in single-ended and
>>> differential mode.
>>> +        minimum: 0
>>> +        maximum: 79
>>> +
>>> +      diff-channels: true
>>
>> Why? Drop, unless you want to say there all other ADC properties are
>> invalid for this type of device (device, not driver!).
>>
>>> +
>>> +    required:
>>> +      - reg
>>
>>
> 
> All other ADC properties are valid.

So drop what I questioned.


Best regards,
Krzysztof

