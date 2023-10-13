Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B9F7C8668
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjJMNKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjJMNKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:10:35 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D750C91
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:10:31 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-536b39daec1so3508893a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697202630; x=1697807430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DidT7rALl9vSF4ezIvtxrsqdbMXEXfeI236EUj2B1bQ=;
        b=k3y+tVrZRSR9sTaR+7YJyrY6KeBVJBFIy9MiRdGOrUKtIsLlQrDiftK2Cb49imJflR
         xLVCgxJj2HtasO6Ps4nsiv7k76QvGYqW9cEfszrvbbLszOe1c58Z5aJse6j0nToJZA++
         72pRBbgZjavAdbDeMoSRxRj8k7w4HF0vrObUfbGP6gX22MZjC9emFeoIoG6caZSwxS9o
         6vFGohLG3mS4NerLSL0ebPDKfDw1iRq1N0wv+Ts8KbZ2PKR2/wAqZm4l8b+qVwyHTLHM
         X8oaFcdiEQIwuFShorsVc3gQuVPQEvxOgxTjz5JbNC9vSHpCWLFyb8bANaspf6nFmxK7
         kxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697202630; x=1697807430;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DidT7rALl9vSF4ezIvtxrsqdbMXEXfeI236EUj2B1bQ=;
        b=rZduk9d2GybqlSKe6AtfXqTz5Ajqo9+hneM+uiNg+Q3+nx9kcZqhVpj0+9PvtKfkMf
         mxP3w4PWWaofD/YPCxarOBi0rQmsLdMOP6eFNOX2ul0vOKAj2mBET2Mi/9vVETO2+ilV
         sqWa+nQKx0goRxYwoejeDavWNyXkbszpAwa4qoDrnyeQfX67HY2K0sVRr2Yq9vEKPBc9
         bdKzPbIoG9sYLL5UwUC0IU7YQ9b9IgX8myiQexNEZsFA/nTFDyjwB/75HQgoLCVpz0zl
         tEvbrQOYrx/M0iI9FKEIClT+px1Ce6Gb3wKW9Vi6kYC/ca4oNwXR47+WyFfUyxlhhXP1
         Ipzw==
X-Gm-Message-State: AOJu0YxEZhGLkiy43Ixvxqmj44GEf3qSvKmwlDZnqpmMZHyzCTrTnvmA
        FMutGhHCGQIKN4BollujfFOfBA==
X-Google-Smtp-Source: AGHT+IHCEyK9mCE041a3H3Q7K6wLBHjj5TtJM8ehk1tbJh+RtrzOtD9tOsF/Q6SYASmdF3InCWAUOw==
X-Received: by 2002:a17:907:77cf:b0:9ae:4b25:d89f with SMTP id kz15-20020a17090777cf00b009ae4b25d89fmr14247611ejc.6.1697202630322;
        Fri, 13 Oct 2023 06:10:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id pw1-20020a17090720a100b009ada9f7217asm12255651ejb.88.2023.10.13.06.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 06:10:29 -0700 (PDT)
Message-ID: <a990fead-b7af-48e6-ab28-3a69ce07d248@linaro.org>
Date:   Fri, 13 Oct 2023 15:10:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt to
 yaml
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>,
        Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <20231013101450.573-1-praveen.teja.kundanala@amd.com>
 <20231013101450.573-3-praveen.teja.kundanala@amd.com>
 <02d3fa42-75a3-4f4f-ade6-204c8146d694@linaro.org>
 <91d61e1a-abb0-4b31-aa22-aff72d582ebe@amd.com>
 <b72e6fe0-2ba4-47ac-80a5-94ee4101ad2b@linaro.org>
 <013e44c6-45f5-44c1-94b3-536955fae78f@amd.com>
 <b5a2d37b-168c-4cc9-9dc0-68f131cdf3ad@linaro.org>
 <5a3b6efe-5884-4727-a1e1-e9b8b0658523@amd.com>
 <209334cd-c922-4bd6-b116-83297c7e8b79@linaro.org>
 <edbd1434-c05b-461f-96e5-f57775dcf915@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <edbd1434-c05b-461f-96e5-f57775dcf915@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2023 15:06, Michal Simek wrote:
> 
> 
> On 10/13/23 14:54, Krzysztof Kozlowski wrote:
>> On 13/10/2023 14:08, Michal Simek wrote:
>>>
>>>
>>> On 10/13/23 13:58, Krzysztof Kozlowski wrote:
>>>> On 13/10/2023 13:51, Michal Simek wrote:
>>>>>
>>>>>
>>>>> On 10/13/23 13:46, Krzysztof Kozlowski wrote:
>>>>>> On 13/10/2023 13:22, Michal Simek wrote:
>>>>>>>>
>>>>>>>>> +
>>>>>>>>> +required:
>>>>>>>>> +  - compatible
>>>>>>>>
>>>>>>>> required: block goes after patternProperties: block
>>>>>>>>
>>>>>>>>> +
>>>>>>>>> +patternProperties:
>>>>>>>>> +  "^soc_revision@0$":
>>>>>>>>
>>>>>>>> Why do you define individual memory cells? Is this part of a binding?
>>>>>>>> IOW, OS/Linux requires this?
>>>>>>>
>>>>>>> nvmem has in kernel interface where you can reference to nodes. nvmem_cell_get()
>>>>>>> calls. It means you should be able to describe internal layout that's why names
>>>>>>> are used. And address in name is there because of reg property is used to
>>>>>>> describe base offset and size.
>>>>>>
>>>>>> That's not really what I am asking. Why internal layout of memory must
>>>>>> be part of the bindings?
>>>>>
>>>>> It doesn't need to be but offsets are hardcoded inside the driver itself and
>>>>> they can't be different.
>>>>
>>>> Hm, where? I opened drivers/nvmem/zynqmp_nvmem.c and I do not see any
>>>> hard-coded offsets.
>>>
>>> Current driver supports only soc revision from offset 0.
>>> But if you look at 5/5 you need to define offsets where information is present.
>>> +#define SOC_VERSION_OFFSET	0x0
>>> +#define EFUSE_START_OFFSET	0xC
>>> +#define EFUSE_END_OFFSET	0xFC
>>> +#define EFUSE_PUF_START_OFFSET	0x100
>>> +#define EFUSE_PUF_MID_OFFSET	0x140
>>> +#define EFUSE_PUF_END_OFFSET	0x17F
>>
>> There is nothing like this in existing driver, so the argument that "I
>> am adding this to the binding during conversion because driver needs it"
>> is not true. Conversion is only a conversion.
> 
> Conversion in 2/5 is adding only soc revision which is already there. It is 
> starting from 0 and world size is 1. And 0 is not listed because that's start 
> all the time.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvmem/zynqmp_nvmem.c?h=v6.6-rc5#n39

This defines the nvmem config, not what should be where.

> 
> And soc revision was also listed in origin binding example.

Example is not a binding. Please drop enforcement of some specific nodes
from the binding.

> 
>> Now, if you want to add something new to the binding because of new
>> driver changes, that's separate topic.
> 
> Functionality in firmware is there for quite a long time but as I said I am fine 
> if map is not going to be inside dt binding spec.
> 
>> And since it is new change in the driver I can comment: please don't.
>> Your nvmem driver should not depend on it. nvmem is only the provider.
> 
> Let's see what Srinivas says about implementation. If driver should be just 
> provider then pretty much current driver should be completely rewritten to 
> different style. I mean to have just transport via SMCs with offset/size and 
> then providing functionality in firmware.

Best regards,
Krzysztof

