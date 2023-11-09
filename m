Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED4B7E6564
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjKIIgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjKIIgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:36:53 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6055D5A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 00:36:50 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9dd5879a126so91748066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 00:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699519009; x=1700123809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HM+DFmrG6wa8ydEQeoV3Vc8//oFV5vln5+Xv9+Di6Zo=;
        b=ruekoEvJjH5EnF8dw47kbm/t0P2gHjJFyXfuixLWa9duAMeww2eyUQjqa9mpkmtOKs
         FiQ6fcIv2/mT5no1mWvRpjazYZ4RUqKONKyUym7uLNOpovhqrofalv3/U6Os/DxP+K5U
         rLckK2+8gugOYNEZCMioeDpkQvewjg9SObbwFMDwBmgkvObo1RB3KaGtDs3uf+5c3rmA
         XSc/CsEksdwv1Sq7aOf3KCFt/T0U1jX7pkOyNQ0sHjYjEz7QRe5S5MEaYfszUFCBh4Kg
         fIJXL0YfZXHfhPjMq3BbT5SwEg8oToL8Kx+86KLlAfJkZBk0ZUG1gID8gQwWqptHYwDi
         pZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699519009; x=1700123809;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HM+DFmrG6wa8ydEQeoV3Vc8//oFV5vln5+Xv9+Di6Zo=;
        b=fBtl3Pd92p5Tja4hT/IAoOxCMvjx3mOz4G9SABGhNfPygQPfI7qZ1Wuq76Fy8uxdmn
         LhHK+bqgsVjt2xzXEHNc3Ny75DQ5gIS+i1aX/+n5+qOcoKOMdeAB6k653jJKtCas+0W9
         CmeWqDsROPGxL2iHqXRw4QOt4B04Iq7Btxk5H2Go9BBPz6BRRCOPi/atFkDcr0PHZj+y
         ibAP70L9gsSTSKiK16AFjpldHPYA6nNM6LFiN+SUq0To9deMMggvrksADOZ3NhjTww6Q
         bdbhbIZmRSbWQ4origCVjH5O90lyvJ4tyiCltr9fno3FKv+hJ9jpFqchskKJ25W6r0tj
         +FdQ==
X-Gm-Message-State: AOJu0Yz0Dn64PJKEkTUf6q2am3KjN2klAW4aUGmPeg68s7vO/iU8ZU/e
        Bppi+aaIg1tjLsNpKRfZK769UQ==
X-Google-Smtp-Source: AGHT+IEDyH3wJqJ/md+1tYIycG5iM5Sf6AN9x90DWZ62ddR60zBSCsVIw9iYz43G9HRDfmx3dCKcfQ==
X-Received: by 2002:a17:906:c144:b0:9e2:b250:98c9 with SMTP id dp4-20020a170906c14400b009e2b25098c9mr4174428ejc.21.1699519009031;
        Thu, 09 Nov 2023 00:36:49 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id t27-20020a170906179b00b009a1dbf55665sm2210950eje.161.2023.11.09.00.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 00:36:48 -0800 (PST)
Message-ID: <04242b1b-477b-45cd-bcb8-0125e705b71a@linaro.org>
Date:   Thu, 9 Nov 2023 09:36:46 +0100
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
 <b1b5b020-600d-48c0-aec8-c866c4c29c7a@linaro.org>
 <d62a1b46-d44f-48b9-9f93-647fe2a6f8a2@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <d62a1b46-d44f-48b9-9f93-647fe2a6f8a2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2023 11:11, Michal Simek wrote:
>> I meant that creating a binding for something which is not and will not
>> be a product does not bring any benefits. Why do we even care to
>> document it? Who requires it? I don't. I don't see DTS or driver, no
>> need for compatible.
>>
>> That's why entire discussion starts with DTS (and/or driver).
> 
> We have dt description for soft IPs like uartlite
> Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
> 
> We have 16550 compatible IP with
> Documentation/devicetree/bindings/serial/8250.yaml
> 
> Simple ethernet core
> Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
> 
> Axi ethernet
> Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
> 
> Adi clock generator
> Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
> 
> Adi fan control
> Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yam
> 
> Adi adcs
> Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> 
> and much more.
> 
> They are IPs from vendor catalogs. We can talk if it is a product (definitely 
> yes if you need to buy it for your design). But all of them fit to the same 
> category that you are composing your HW design with them.
> All of them as standalone can't run. You will never create a product with just 
> uartlite IP. You need to add cpu, clocks, reset logic and others around to make 
> a product out of it.
> 
> Our mental model is HW designer create new IP, we are writing driver for it, 
> customers can buy it (or get it for free) and use it.
> They put it to their design, create custom board and sell it as a product.
> 
> And in this particular case HW designed create risc-v compatible CPU.
> I expect this should fine
> https://lore.kernel.org/r/d442d916204d26f82c1c3a924a4cdfb117960e1b.1699270661.git.michal.simek@amd.com
> 
> And discussion what we are having is pretty much about how to share the view on 
> the system.

That's different category. All of these are part of SoC. Here we talk
about the SoC and I had impression that you added compatible for the SoC
alone.

> 
>>>
>>>>
>>>> I spoke to Palmer a bit about this, and what I think would make sense is
>>>> if you had some sort of "reference design" bitstream that people could
>>>> download and run on xyz AMD devkit. If that existed, then we could
>>>> document that configuration etc. Otherwise you're in the same spot that
>>>> a lot of IP vendor stuff is, where without there being something that
>>>> qualifies as "real hardware" using the core, it doesn't make sense to
>>>> try and create bindings etc. It's the same for the various people in
>>>> the RISC-V community that created their own CPUs that they run on FPGAs.
>>>
>>> Aren't all ARM FVP models enabled by SW before soc vendors put them to a real
>>> chip? Is there any real product available at that time?
>>
>> FVP also finished one. They do not claim they added compatible for a SoC
>> or CPU. And that's my impression here.
> 
> Are these real chips?
>          compatible = "arm,foundation-aarch64", "arm,vexpress";
>          compatible = "arm,fvp-base-revc", "arm,vexpress";
> 
> FVP are Fixed Virtual Platforms. Pretty much emulators similar to QEMU.

If your case is this one, then few parts of description should be
rephrased in the bindings.

> 
>>
>>>
>>> I will try to find out if there is any official plan for releasing any reference
>>> design against any evaluation board with commitment to supporting it.
>>>
>>>>>> Or I can define qemu one.
>>>>>> "amd,qemu-mbv", "amd,mbv"
>>>>>
>>>>> QEMU is not hardware, so not.
>>>
>>> I am still trying to wrap my head around it. In qemu we are actually going to
>>> create model for this configuration but based on what you are saying here we
>>> shouldn't really have DT which describes it.
>>> That's why we likely end up in situation that qemu create DT description self,
>>> put it to memory and u-boot/kernel will consume it. The only difference is going
>>> to be that DT will be used but won't be checked against dt-schema.
>>> I personally prefer to have DT pass dt-schema checking and tell qemu guys, this
>>> is what qemu should generate.
>>> But if you think that this is wrong approach I will let them generate whatever
>>> they want and will just check functionality. It means u-boot won't have DT,
>>> Linux won't have DT and I am done.
>>
>>
>> Sorry, I am confused now. Are we talking about real hardware or QEMU SW
>> model? Your description clearly said:
>> "AMD boards with MicroBlaze V SOC"
>> so QEMU is not a board. Board has a physical form, a shape. Usually flat.
> 
> Let me describe what we do for all our SOCs but Microblaze is the best example here.
> Customers open design tools (right know Vivado) and design their system there.
> Choose cpu and it's configuration like barrel shifter, divider, multiplicator, 
> size of caches. Then put there interrupt controller, timer, consoles, ethernet, 
> spi, i2c, etc. For all IPs you need to choose mmio base address and connect them 
> to any interrupt line you like.
> You normally target a board, evaluation platforms or just standalone chips which 
> you use on your custom boards.
> And build bitstream (configuration for FPGA) and also going over our device tree 
> generators which generate DT for describing the system.
> Very old example is for example visible here
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/microblaze/boot/dts/system.dts?h=v6.6
> 
> Another example is mb-v description mentioned in previous thread.
> 
> The reason is simple with a lot of IPs in the design none will be able to get 
> description right in connection to addresses and especially interrupt numbers.
> 
> It means at this stage you have bistream for your board and you have DTS 
> (without board specific information like i2c devices, ethernet phy, etc)
> 
> For 10+ years our qemu is taking input as DTB and create qemu model based on it. 
> It means you say via DT I want this cpu core, this timer at 0x..., interrupt at 
> 0x..., uart at 0x..., etc. and qemu generates model for it. Pretty much the same 
> DT can be consumed by SW to run it on the model.
> 
> We reached the state that you have qemu model which reflects your design choice 
> and at the same time you have hardware for your board.
> 
> It means same DT describe qemu configuration and also hardware.

So you can run it under QEMU. I misunderstood your proposal of adding
qemu compatibles few emails before.

But if the QEMU model and also the hardware is called "AMD MicroBlaze
V", then how the heck is SoC called?



Best regards,
Krzysztof

