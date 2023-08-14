Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E9D77C0D9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjHNTd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjHNTdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:33:00 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15686ED
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:32:59 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5234f46c6f9so6236349a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692041577; x=1692646377;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+PPyRkE8QNcnw8n4URXIBMydlUyue4gEnUO37VgDlOA=;
        b=uZ42I4tK6dm+P+AF/H5MI2p0bu0VHhQ7yPZs/u6FYyCso2ccRZgNK6eZBMNd3rmvFo
         sLXx4suRvyn6HQYLfroPz4RL43N7kgktorfctw5SfYFMrhK3qCBbcWgm0rh1R0eSDX6s
         kZ6dHLa3Hes0qOybeWm0EAXeb+7QMheSjTumDW4XQJPTpXMINE5Lv0ogrgL7ssFYqUbY
         90BM7ESD8Y3MuQBzRaiUrDFp4xKx44Coo4evx2Y9K8KK614ipaXzIkPxvQQvKL1HY/kt
         /N1bdIYgFb5wyqnMDqdCf44YbHhHkHUGlT48j5CZlGww6W2fDaceH9UP8GCDz46y01ci
         RXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692041577; x=1692646377;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PPyRkE8QNcnw8n4URXIBMydlUyue4gEnUO37VgDlOA=;
        b=JAxYj4qDPvQXhnn3IzxsRgnl6gUhmJM9acrF4wOo+ANKOROHzVWgXlyBRbpT6Zcvs5
         KwmVog7n+1wCGppkyLYrEWkWvrKKizlBPA4Fnj8blwq4ifxUmtSl4hO3ow07h7mIHH6u
         /q7CuXFHNMITarQWT8D02Lb9jJXa1ABUEznm/0DZTMAVei/NKAhUiOorAQNGl5yrQxHv
         r/XYcWEyCNZ+jIs4EO0bbkrKQj8LqsZJf7gYs+WHCD6xlxjeVJiXxB2WZMd47xYLLsSE
         qr/1Go/CmYu/EXa1RVSwLNkMdDhK/X9IvAX8RXlxyjHwJ17slAv8SsyRIhcNAVZPheoN
         0SrQ==
X-Gm-Message-State: AOJu0YyVTLs3CR7Msd2Uw8Syy5zIt5/sJ7uuF7dbhaRkUTTpPgWT8qHO
        mOJIxbz+Fw+MpFcMuV34E4BqLA==
X-Google-Smtp-Source: AGHT+IHCJObag9Dyk19qMlfSCfz6Iy2moD47tbSnD7NtULAtaT+peJh+ZdxunQCt9JIIgTgjSOmhoQ==
X-Received: by 2002:aa7:d8d8:0:b0:525:46b7:40f2 with SMTP id k24-20020aa7d8d8000000b0052546b740f2mr5057909eds.21.1692041577535;
        Mon, 14 Aug 2023 12:32:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id a25-20020aa7cf19000000b0051e1660a34esm5930702edy.51.2023.08.14.12.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:32:57 -0700 (PDT)
Message-ID: <b3eebd2b-c73b-fdc7-2b2b-07e97db26d92@linaro.org>
Date:   Mon, 14 Aug 2023 21:32:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/3] dt-bindings: hwmon: Add Infineon TDA38640
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Conor Dooley <conor@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230802193155.2170935-1-Naresh.Solanki@9elements.com>
 <20230808-stand-cheddar-b76b0b7509a0@spud>
 <eced746a-1181-bd8f-6828-4a4eeb79727c@roeck-us.net>
 <20230808-esquire-epidemic-f9bd74ffde25@spud>
 <CABqG17jm938MaEeqS03WeryVWSRBS7Bqq2Vwq9SL4QOGqXU43A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CABqG17jm938MaEeqS03WeryVWSRBS7Bqq2Vwq9SL4QOGqXU43A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2023 18:00, Naresh Solanki wrote:
> Hi,
> 
> On Tue, 8 Aug 2023 at 19:58, Conor Dooley <conor@kernel.org> wrote:
>>
>> On Tue, Aug 08, 2023 at 07:10:08AM -0700, Guenter Roeck wrote:
>>> On 8/8/23 04:46, Conor Dooley wrote:
>>>> On Wed, Aug 02, 2023 at 09:31:51PM +0200, Naresh Solanki wrote:
>>>>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>>>
>>>>> The TDA38640 chip has different output control mechanisms depending on
>>>>> its mode of operation. When the chip is in SVID mode, only
>>>>> hardware-based output control is supported via ENABLE pin. However, when
>>>>> it operates in PMBus mode, software control works perfectly.
>>>>>
>>>>> To enable software control as a workaround in SVID mode, add the DT
>>>>> property 'infineon,en-svid-control'. This property will enable the
>>>>> workaround, which utilizes ENABLE pin polarity flipping for output when
>>>>> the chip is in SVID mode.
>>>>
>>>> Why do you need a custom property for this? How come it is not possible
>>>> to determine what bus you are on?
>>>>
>>>
>>> That is not the point. Yes, it can be detected if the control method is
>>> PMBus or SVID. However, in SVID mode, SVID is supposed to control the
>>> output, not PMBUs. This is bypassed by controlling the polarity of the
>>> (physical) output enable signal. We do _not_ want this enabled automatically
>>> in SVID mode. Its side effects on random boards using this chip are unknown.
>>> Thus, this needs a property which specifically enables this functionality
>>> for users who _really_ need to use it and (hopefully) know what they are
>>> doing.
>>
>> Hmm, reading this it makes a lot more sense why this is a property - I
>> guess I just struggled to understand the commit message here,
>> particularly what the benefit of using the workaround is. I'm still
>> having difficulty parsing the commit & property text though - its
>> unclear to me when you would need to use it - so I will stay out
>> of the way & let Rob or Krzysztof handle things.
> 
> To provide context, my system employs a unique power sequence
> strategy utilizing a BMC (Baseboard Management Controller),
> rendering the reliance on the ENABLE pin unnecessary.
> In this configuration, the ENABLE pin is grounded in the hardware.
> While most regulators facilitate PMBus Operation for output control,
> the TDA38640 chip, when in SVID mode, is constrained by the
> ENABLE pin to align with Intel specifications.
> My communication with Infineon confirmed that the recommended
> approach is to invert the Enable Pin for my use case.
> 
> Since this is not typically the use case for most setup & hence DT property
> is must for enabling the special case.
> 
> For further insight into my setup's power sequence strategy, you can
> refer to the following link: https://github.com/9elements/pwrseqd
> 

This justifies to me the property, but still you described desired
driver behavior, not the hardware characteristic. Don't describe what
you want to control, but describe the entire system.

Best regards,
Krzysztof

