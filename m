Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04227E51B6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjKHIL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjKHIL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:11:57 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B711BB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 00:11:54 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9e1021dbd28so437201666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 00:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699431113; x=1700035913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J5/MAswvSM0oMq2yOpZKDBOUMqzw+a+RK61Veif8ZZY=;
        b=vxPNt2GVjlwt1cAzdPqo/NVFBcje74L03WB/USrZ2aGzDhdXLIYvHc52ga1/JK33nh
         dABmf8og66lDePsQNIkggFcI6XniaI5+6r35LvTbOWYkuhMqXK2RG1Xq73OutWXN0dAT
         rMg6bjKWzX2gFO7QUxcm+mKuJubJJVHug3yHo0lnC6kdKmbHIXba9Mg42MNq5LGXVBkc
         APoVU9pY4LdRSa5o+pYxAGyiLY6vY5YYob8gk/Y6AmD3gj73p2D2wEXBeBKbvPRcm2wt
         TgfAlhXHoaMnhqcfN0/fhSgVbsL7bXH1Jry3ytZNpNw1uSH8dNsisRd0Eg6yoAMbTIa2
         GxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699431113; x=1700035913;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5/MAswvSM0oMq2yOpZKDBOUMqzw+a+RK61Veif8ZZY=;
        b=pETfT4CeLu52efwbkJ+bcDhcM19nXDHfq46OKgv3VVL0CZOKcrZ9HqDUXpKVl2+9Cb
         UssXNp5akJEv0KzGGUZYkYAmJJJmVFXeZ/3qmNngcyv3sBhRsay4Tlv68ZOz1O3SNK5/
         ZNokkkMdkL9+ks744gs1HPmtNAjwmVrUAL/MLAF6Vv6jZDV2WaZb+Swgs5xUj970cUcO
         b4CFR/haDwVz5Hg6BwbFbZvccIu2qO0VbsnZszJxTAJNjQ703ozyzxfg08/N+WLRTE7I
         Y8fRnk4ZbIic//kDVhp7UkizYBtgdW+/I3ui+jmEm/YL9tXWxD6hr70VjopyMl2pocVn
         taqw==
X-Gm-Message-State: AOJu0YwdvG4Vwx76SHXt+2jj6SUTJ9tR3NbrJ5GrPeNDs8UsnQRaWP3S
        Uq8g+CHTnGA0Hme8BTWytzmsQw==
X-Google-Smtp-Source: AGHT+IEcEUuTdwqWSr4qNoenbzc5s46krEBz/BkkrO+os4GFtw+7a7lJWGogLtuRlVVlM9rQOODbbw==
X-Received: by 2002:a17:907:c13:b0:9b2:b149:b81a with SMTP id ga19-20020a1709070c1300b009b2b149b81amr808365ejc.64.1699431113266;
        Wed, 08 Nov 2023 00:11:53 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id t28-20020a508d5c000000b0053e5a1bf77dsm6513606edt.88.2023.11.08.00.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 00:11:52 -0800 (PST)
Message-ID: <b1b5b020-600d-48c0-aec8-c866c4c29c7a@linaro.org>
Date:   Wed, 8 Nov 2023 09:11:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: soc: Add new board description for
 MicroBlaze V
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, palmer@dabbelt.com
References: <50c277c92c41a582ef171fb75efc6a6a4f860be2.1699271616.git.michal.simek@amd.com>
 <20231106-hangnail-prankster-a04e713bed35@spud>
 <4223470c-5596-4168-9c89-e701559fbbed@amd.com>
 <e9fef49e-c0ca-4f7d-9618-151216e25280@linaro.org>
 <92d95425-5bae-4ada-8fc3-966e7bfbd815@amd.com>
 <90f9991e-26a3-498e-9449-c96663987459@linaro.org>
 <20231107-darkening-daylong-deef34169798@spud>
 <872007e1-6e57-4dc4-89f5-62fea3c969a5@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <872007e1-6e57-4dc4-89f5-62fea3c969a5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2023 08:16, Michal Simek wrote:
> 
> 
> On 11/7/23 22:36, Conor Dooley wrote:
>> +CC Palmer
>>
>> On Tue, Nov 07, 2023 at 01:38:15PM +0100, Krzysztof Kozlowski wrote:
>>> On 07/11/2023 13:09, Michal Simek wrote:
>>>> On 11/7/23 12:27, Krzysztof Kozlowski wrote:
>>>>> On 07/11/2023 12:09, Michal Simek wrote:
>>>>>> On 11/6/23 18:07, Conor Dooley wrote:
>>>>>>> On Mon, Nov 06, 2023 at 12:53:40PM +0100, Michal Simek wrote:
>>
>>>>>>>> +description: |
>>>>>>>> +  AMD boards with MicroBlaze V SOC
>>>>>>>> +
>>>>>>>> +properties:
>>>>>>>> +  $nodename:
>>>>>>>> +    const: '/'
>>>>>>>> +  compatible:
>>>>>>>> +    oneOf:
>>>>>>>> +      - description: AMD MicroBlaze V
>>>>>>>> +        items:
>>>>>>>> +          - const: amd,mbv
>>>>>>>
>>>>>>> You don't actually list any boards here, but instead permit having only
>>>>>>> the SoC compatible and no board one. The SoC compatible is also
>>>>>>> incredibly generic. Personally I don't think this binding makes any
>>>>>>> sense as it appears to exist as a catch all for anything using your
>>>>>>> new cores in any combination.
>>>>>>
>>>>>> I think I need to define any string for compatibility because it is standard
>>>>>> property. Because this is soft core it can be added to any board with AMD/Xilinx
>>>>>> chip. I don't have really an option to list all boards.
>>>>>
>>>>> Why? Either there is a product with this soft-core or there is not. It
>>>>> cannot be both.
>>>>
>>>> I am doing basic enablement. I am not making product. Product will be done by
>>>> our customers using this core.
>>>> There will be thousands of different configurations done by customers which will
>>>> have products with it. Also there could be hundreds configurations done on the
>>>> same board.
>>>
>>> If this is the same board, then why there is compatible for it?
>>>
>>>>
>>>> Does it make sense to have board related compatible string like this if this
>>>> evaluation board is used by a lot of customers?
>>>> "amd,kcu105-mbv-ABC-vXYZ", "amd,kcu105-mbv", "amd,mbv"
>>>
>>> I miss the point what is the hardware. Evaluation board is the hardware.
>>> If someone changes it and makes a new product, it is a new product.
>>
>> To me, this does actually make (some) sense.
>> The first compatible is "soc" + board + design.
>> The second is "soc" + board.
>> The final one is the "soc".
>>
>> I say "soc" though, because it is not a single soc - it could be any
>> configuration of these soft AMD cores on an FPGA in any quality,
>> possibly set up heterogeneously too. I don't think trying to define a
>> generic compatible for it like this makes sense as the soc part does
>> not come close to identifying a specific device.
> 
> I am fine to skip it but it is required property which has to be defined somehow.
> 
>>
>> Until someone actually creates a product that ships with this, I don't
>> think it makes sense to try and define a binding.
> 
> I disagree with this description. I am coming from FPGA world where it is too 
> late to start to deal with dt binding when you have a product.
> You are saying release the product and then start to deal with dt binding. When 
> product is released there must be stable dt binding.

I meant that creating a binding for something which is not and will not
be a product does not bring any benefits. Why do we even care to
document it? Who requires it? I don't. I don't see DTS or driver, no
need for compatible.

That's why entire discussion starts with DTS (and/or driver).

> 
>>
>> I spoke to Palmer a bit about this, and what I think would make sense is
>> if you had some sort of "reference design" bitstream that people could
>> download and run on xyz AMD devkit. If that existed, then we could
>> document that configuration etc. Otherwise you're in the same spot that
>> a lot of IP vendor stuff is, where without there being something that
>> qualifies as "real hardware" using the core, it doesn't make sense to
>> try and create bindings etc. It's the same for the various people in
>> the RISC-V community that created their own CPUs that they run on FPGAs.
> 
> Aren't all ARM FVP models enabled by SW before soc vendors put them to a real 
> chip? Is there any real product available at that time?

FVP also finished one. They do not claim they added compatible for a SoC
or CPU. And that's my impression here.

> 
> I will try to find out if there is any official plan for releasing any reference 
> design against any evaluation board with commitment to supporting it.
> 
>>>> Or I can define qemu one.
>>>> "amd,qemu-mbv", "amd,mbv"
>>>
>>> QEMU is not hardware, so not.
> 
> I am still trying to wrap my head around it. In qemu we are actually going to 
> create model for this configuration but based on what you are saying here we 
> shouldn't really have DT which describes it.
> That's why we likely end up in situation that qemu create DT description self, 
> put it to memory and u-boot/kernel will consume it. The only difference is going 
> to be that DT will be used but won't be checked against dt-schema.
> I personally prefer to have DT pass dt-schema checking and tell qemu guys, this 
> is what qemu should generate.
> But if you think that this is wrong approach I will let them generate whatever 
> they want and will just check functionality. It means u-boot won't have DT, 
> Linux won't have DT and I am done.


Sorry, I am confused now. Are we talking about real hardware or QEMU SW
model? Your description clearly said:
"AMD boards with MicroBlaze V SOC"
so QEMU is not a board. Board has a physical form, a shape. Usually flat.

> 
>>>
>>>>
>>>> I think customers should be adding their compatible string in front of generic one.
>>>
>>> To what? To evaluation board? Why?
>>>
>>>>
>>>> Years ago I have done the same thing with Microblaze where compatible is defined
>>>> as xlnx,microblaze only.
>>>
>>> Again, what is the use of such binding?
>>>
>>>> When customer take this soft core, put IPs around and
>>>> create a product they should extend it to be for example like this.
>>>> "xyz,my-product-1.0", "xlnx,microblaze";
>>>
>>> So there is a product, not evaluation board.
>>>
>>>>
>>>> And over all of years I have never seen any single customer to try to push dt
>>>> description for any Microblaze based product.
>>>>
>>>>>>
>>>>>> I am happy to change it to something else but not sure to what.
>>>>>
>>>>> Alone this compatible does not bring you anything.
>>>>
>>>> I don't agree with it. It is standard property and I have to define it somehow.
>>>
>>> The property is already defined, you do not have to define it. What you
>>> define here is the value for compatible. Why do you need to define it
>>> somehow? Who asks for that?
>>>
>>>> If not, I get an error.
>>>> .../xilinx-mbv32.dtb: /: 'compatible' is a required property
>>>
>>> So you have a board? The patches must be linked to each other, e.g.
>>> preferred way is to send them in one patchset.
>>
>> There were patches sent to U-Boot for an example configuration:
>> https://lore.kernel.org/u-boot/d488b7016e0d1b1324c64d8a8b2f033851aab6c6.1699271804.git.michal.simek@amd.com/
> 
> thx.
> 
>>
>>>> And it tells me that this risc-v compatible core runs on AMD fpga and it is
>>>> compatible with it.
>>
>> Basically, it provides no more specific information than the cpu node
>> does. From me, it's a NAK for a compatible like this that that permits
>> using it in isolation for any core configuration and combination.
> 
> I hope you agree that if we ignore compatible string for the whole DT that DT 
> describes HW is very reasonable way. It means you know what CPU is, what timer, 
> console and intc are.
> It clearly shows how MicroBlaze-V AMD design will be done for others who are 
> interested on using it.
> It also shows and explain what drivers needs to be enabled in defconfigs.
> 
> In connection to above u-boot. I can simply remove DT patch from that series (or 
> move it to readme) and just say these IPs will be used that's why I am enabling 
> them and point them to public announcement. And configure that DT will be passed 
> via address in DDR and that's it.
> But I simply think that DT is providing better view on the system.
> 
> We will of course extending our device tree generators to provide DT description 
> directly from the tool as a starting point for customers.
> 


You called the file:
"AMD boards with MicroBlaze V SOC", which means "AMD MicroBlaze V" is
the name of the SoC.

Now you create one compatible, not a list, for "AMD MicroBlaze V", so
only for the SoC. That's the discussion about. You cannot create a
final, real and working hardware with this SoC alone. To make it
working, you need to put it into some board. Now, for SW models,
probably you can... but then how do you run it? If under QEMU then show
me the QEMU machine file - I bet there are some specifics for this given
configuration. This means you have specific configuration, not a generic
SoC. And again we are at the same spot as with hardware - you could not
run the SW model without configuring it, thus you cannot run a "SoC".

Best regards,
Krzysztof

