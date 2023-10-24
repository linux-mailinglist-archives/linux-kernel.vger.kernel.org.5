Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C36C7D52C6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343580AbjJXNtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343571AbjJXNsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:48:22 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB5419AD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:47:20 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32dd70c5401so3067153f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698155239; x=1698760039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wvhpCK3frheCthRrpOgh0zrl+ct+ClP+4XcisWHapjk=;
        b=TpKRsUxltXjHqYx5IKnhJM4qe7cLJQkF5InzYtsuAi8CIOlMJ7uIIwjWTSNZHCZkZH
         +TtuuDl7rGeuE3vl93xIsS/VGIGnP6Z3YCfNXJYQMDcF5WpMAnrVjK9E2nhaxv6uF2i5
         CzxmpwGI2jTbjfwupbr0xQup/lO+sng17mQaiBTWakiYwbZnXygI1gA26stGtPJC3YSk
         Kecf78A+iuL/kN7rdlI2SoVpJrOCnE4wEnkkXFKxnG2cCH2Ftp3Y/lBUw27BPh/eGa53
         rYyB6PORjTKk3pIZB6udvYAQobAHdpGcdIyfFmWYxLV5Hpd0kUTPjzh+DR7ZzbcilyLz
         YJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155239; x=1698760039;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wvhpCK3frheCthRrpOgh0zrl+ct+ClP+4XcisWHapjk=;
        b=upnaIeo3u42qV+QWD+dBFJ/dnqk17wpvR52/KbJXQs0572MO3SrebQpHLEkMenRhkg
         WAjSNfPHsHJf0R++lE9bi573aBiUEZG1mDs0inFo9pw80NOg4glV2JG3LKgd0fKxKDkn
         Er1N8AgSzpUwPoiJxhwQ8bbJD71dgtDd/1CJbZIsc92PHW35EdXAAuodKXS0r9GlJTNd
         D+fBN11IvjC1ogCciXzXP8pIYKi/krd+XMdubEDyq0rpChEqQOzN8/M5m61LTq9izNFX
         Rk3Q6vIgQZUdFM00siitur7xTt8pHFs5p1+VNuAG7Tno3TXEVTBxss9+C5RWVRVLsrG8
         R3lQ==
X-Gm-Message-State: AOJu0Yw3oQtJnnLW4Sack3n/hdzdxILCxk/Z29IEm3IsCpoi6Olezcuu
        kj3U9WFAFNtSsyWdp1V6Nnx4F66CsVW5QprhOQ4=
X-Google-Smtp-Source: AGHT+IGz3jnjKq9evm/HLmafgvEvDPTZr2z9ydQDtKuBwKG0JHRLP24wqRMQ4CriBz77UjQDHz5O9A==
X-Received: by 2002:a5d:5b1f:0:b0:32d:7615:372b with SMTP id bx31-20020a5d5b1f000000b0032d7615372bmr12731797wrb.12.1698155238858;
        Tue, 24 Oct 2023 06:47:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id y10-20020a5d470a000000b0032d9efeccd8sm9975318wrq.51.2023.10.24.06.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 06:47:18 -0700 (PDT)
Message-ID: <8391fb67-e575-49e6-9857-806cb85e9e59@linaro.org>
Date:   Tue, 24 Oct 2023 15:47:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] dt-bindings: adis16460: Add
 'spi-cs-inactive-delay-ns' property
Content-Language: en-US
To:     =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
        Conor Dooley <conor@kernel.org>
Cc:     Ramona Gradinariu <ramona.gradinariu@analog.com>, jic23@kernel.org,
        nuno.sa@analog.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20231023140534.704312-1-ramona.gradinariu@analog.com>
 <20231023140534.704312-4-ramona.gradinariu@analog.com>
 <e97ac024cb2654507ed8f7af715f3604efefbdbb.camel@gmail.com>
 <20231023-repost-coma-2f67ea8b95af@spud>
 <5c600a6db6173a56251302da8d2f438435959bd2.camel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <5c600a6db6173a56251302da8d2f438435959bd2.camel@gmail.com>
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

On 24/10/2023 08:53, Nuno Sá wrote:
> On Mon, 2023-10-23 at 17:06 +0100, Conor Dooley wrote:
>> On Mon, Oct 23, 2023 at 04:27:48PM +0200, Nuno Sá wrote:
>>> On Mon, 2023-10-23 at 17:05 +0300, Ramona Gradinariu wrote:
>>>> The adis16460 device requires a stall time between SPI
>>>> transactions (during which the chip select is inactive),
>>>> with a minimum value equal to 16 microseconds.
>>>> This commit adds 'spi-cs-inactive-delay-ns' property, which should
>>>> indicate the stall time between consecutive SPI transactions.
>>>>
>>>> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
>>>> ---
>>>> changes in v2:
>>>>  - added default value
>>>>  - updated description
>>>>  - updated commit message
>>>>  .../devicetree/bindings/iio/imu/adi,adis16460.yaml          | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
>>>> b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
>>>> index 4e43c80e5119..f10469b86ee0 100644
>>>> --- a/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
>>>> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
>>>> @@ -25,6 +25,12 @@ properties:
>>>>
>>>>    spi-cpol: true
>>>>
>>>> +  spi-cs-inactive-delay-ns:
>>>> +    minimum: 16000
>>>> +    default: 16000
>>>> +    description:
>>>> +      Indicates the stall time between consecutive SPI transactions.
>>>> +
>>>
>>> You should drop the description... 
>>>
>>> Also, give more time before posting a v2 so others get a chance to review
>>> your
>>> patches. It's also better for you since you can gather more change requests.
>>
>> Further, I don't see an answer to Krzysztof's question of why the stall
>> time would not just be set to 16,000 ns in the driver, based on the
>> compatible.
> 
> Hi Conor,
> 
> Regarding that, I'm the one to blame since I was the one asking for the property
> during internal review... The reason is that "spi-cs-inactive-delay-ns" is
> already part of spi-peripheral-props.yaml which we already reference. So my
> question would be why not using it?
> 
> These devices are a bit sensitive regarding these timings. Not in devices
> supported by this driver but I already experienced having to set timings bigger
> than defined in the datasheet for spi to be reliable. this was true on a RPI but
> might not be in another platform.
> 
> Hence having the flexibility to change the time in an already supported property
> does sound good to me. If not set, we still use the default value based on the
> compatible. Now, if you tell me "let's just add this if we really get the need
> for it", I get it but I also don't understand why not add it now...
> 

I think it is okay to document specific SPI peripheral constraints in
each device. Just like we document sometimes SPI frequency. The v1 did
not explain this, but I see in this commit msg some rationale.

Best regards,
Krzysztof

