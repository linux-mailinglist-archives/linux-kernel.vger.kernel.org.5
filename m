Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3240780834
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359041AbjHRJXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238613AbjHRJXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:23:02 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB7430E6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:23:01 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c353a395cso84428766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692350579; x=1692955379;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pO/NLfSXQCGnKg4+bEM0fLqxGi3J0/6qioKdfhMjmdo=;
        b=nOTMo+/1Nw73rHt39/57JPvg8AsFjBbuGVIRDhbSLc9e9KEsQhYu2qCHwlHXrm7kUn
         QwdXc0JDCMyvRljUROn2cOHO03isnm6xLcG0vz8OhYXxtGH6KjtC8zF+/2Ltar+s0PZm
         vkPw8nJwF5xBeSvs84CB/vJ5uCmbdqyVdvpWWA39YIQ7tDWd5ObhOT1TPoJctvyixJWd
         antEv6SML394RmMhEtniBfsR6ierMCyMRaZ9L9ZK+qIaoY+WvhxvlezxAeitjZfzE+GY
         fAzGGf0gUR3Rbblxj7emd0z/pIpTZb5x58pRdZ2O7Ik46Ya7OQmsuN3tVeenahjDAXA5
         4sFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692350579; x=1692955379;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pO/NLfSXQCGnKg4+bEM0fLqxGi3J0/6qioKdfhMjmdo=;
        b=CKPSFksAhZuLr0t1OX5mHuaRWoUp71K9ws0/OdrIiial4Nbnz9STxYvo4SvWxMlrh0
         gGlZtRMuONLVzEXAfsVw6/xV7J5oRJ0RWgXf+cw+lJ0Ux8hck2fc+Y3o5KGZO7chh3h9
         d1pmQHwHXUfNKpa3ckc9Ggg+MGWXykecz4eEvrth/Hz05q9oBZ0h812Noqdibm3UDGjG
         dbICeauijBunejaGG9aaa+/B/4N3qDbisxmx+So+kvPC1TvWVNGe9zaMZRyt2pYyzB5o
         2mp8NQHgluh0eCaR0vfXMKspxZBr/fMDplJggV6AIx8q8MphSf4Ma5H9h3ewt/o8Jw60
         0vCw==
X-Gm-Message-State: AOJu0Ywjz3yqM4CiDQ21T1nC+nTLVQA6M0NwKg85K/1cCU4LIdZd1OSN
        3EjnCEUdL7IwzzbU7KK21EiukA==
X-Google-Smtp-Source: AGHT+IFw9N3TQC1B1E4pRPOoPEQa1tQS+7EU7C2gCPA40q+AD0dhQe3+j9nAbySNev9yshEM1YHHWg==
X-Received: by 2002:a17:906:311b:b0:99d:e417:d6f6 with SMTP id 27-20020a170906311b00b0099de417d6f6mr1477184ejx.32.1692350579419;
        Fri, 18 Aug 2023 02:22:59 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id k21-20020a1709063fd500b0099bcf1c07c6sm956182ejj.138.2023.08.18.02.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 02:22:58 -0700 (PDT)
Message-ID: <5cde8986-1b12-a85e-b2fe-e1aa1087b429@linaro.org>
Date:   Fri, 18 Aug 2023 11:22:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/3] dt-bindings: hwmon: Add Infineon TDA38640
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
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
 <b3eebd2b-c73b-fdc7-2b2b-07e97db26d92@linaro.org>
 <CABqG17hgU44H9KbALy_336Sb+YOiEOzbnAihiox1OEuVnNiayQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CABqG17hgU44H9KbALy_336Sb+YOiEOzbnAihiox1OEuVnNiayQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 10:51, Naresh Solanki wrote:
> Hi Krzysztof,
> 
> On Tue, 15 Aug 2023 at 01:02, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 11/08/2023 18:00, Naresh Solanki wrote:
>>> Hi,
>>>
>>> On Tue, 8 Aug 2023 at 19:58, Conor Dooley <conor@kernel.org> wrote:
>>>>
>>>> On Tue, Aug 08, 2023 at 07:10:08AM -0700, Guenter Roeck wrote:
>>>>> On 8/8/23 04:46, Conor Dooley wrote:
>>>>>> On Wed, Aug 02, 2023 at 09:31:51PM +0200, Naresh Solanki wrote:
>>>>>>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>>>>>
>>>>>>> The TDA38640 chip has different output control mechanisms depending on
>>>>>>> its mode of operation. When the chip is in SVID mode, only
>>>>>>> hardware-based output control is supported via ENABLE pin. However, when
>>>>>>> it operates in PMBus mode, software control works perfectly.
>>>>>>>
>>>>>>> To enable software control as a workaround in SVID mode, add the DT
>>>>>>> property 'infineon,en-svid-control'. This property will enable the
>>>>>>> workaround, which utilizes ENABLE pin polarity flipping for output when
>>>>>>> the chip is in SVID mode.
>>>>>>
>>>>>> Why do you need a custom property for this? How come it is not possible
>>>>>> to determine what bus you are on?
>>>>>>
>>>>>
>>>>> That is not the point. Yes, it can be detected if the control method is
>>>>> PMBus or SVID. However, in SVID mode, SVID is supposed to control the
>>>>> output, not PMBUs. This is bypassed by controlling the polarity of the
>>>>> (physical) output enable signal. We do _not_ want this enabled automatically
>>>>> in SVID mode. Its side effects on random boards using this chip are unknown.
>>>>> Thus, this needs a property which specifically enables this functionality
>>>>> for users who _really_ need to use it and (hopefully) know what they are
>>>>> doing.
>>>>
>>>> Hmm, reading this it makes a lot more sense why this is a property - I
>>>> guess I just struggled to understand the commit message here,
>>>> particularly what the benefit of using the workaround is. I'm still
>>>> having difficulty parsing the commit & property text though - its
>>>> unclear to me when you would need to use it - so I will stay out
>>>> of the way & let Rob or Krzysztof handle things.
>>>
>>> To provide context, my system employs a unique power sequence
>>> strategy utilizing a BMC (Baseboard Management Controller),
>>> rendering the reliance on the ENABLE pin unnecessary.
>>> In this configuration, the ENABLE pin is grounded in the hardware.
>>> While most regulators facilitate PMBus Operation for output control,
>>> the TDA38640 chip, when in SVID mode, is constrained by the
>>> ENABLE pin to align with Intel specifications.
>>> My communication with Infineon confirmed that the recommended
>>> approach is to invert the Enable Pin for my use case.
>>>
>>> Since this is not typically the use case for most setup & hence DT property
>>> is must for enabling the special case.
>>>
>>> For further insight into my setup's power sequence strategy, you can
>>> refer to the following link: https://github.com/9elements/pwrseqd
>>>
>>
>> This justifies to me the property, but still you described desired
>> driver behavior, not the hardware characteristic. Don't describe what
>> you want to control, but describe the entire system.
> I guess by entire system you mean how the regulators(including
> TDA38640) connected & operated in our setup ?

I mean, property name and description should say what is the
characteristic of the hardware/firmware/entire system.


Best regards,
Krzysztof

