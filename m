Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426347C862D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjJMMyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjJMMyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:54:41 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DFABF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:54:37 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso315792766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697201676; x=1697806476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=spTfC78Itvw/hW/o2eytnI9brc+L/P4ujKi/XHn8SkQ=;
        b=VA1hix7nAUFCI5wOY4CZCIWUuj9s6LO8iOmS7RGyGzv+5W1FPpQHyXYPF/7CvlO+e7
         xr9z5tgWUvfCz6z1Bq2ufzjOq0HDX1JK42GZQk4yXeRY1dOxVX3VTKAi9LAOEy91BKdQ
         AvdfRgWwAWjzrXjXCwYNz/Ms6UqCpqw486oNyyTxeXaYtCe/BK8yu6bkkjcfB/WplwPK
         PyOT0DhH4p1cnWS1nExRTRADC6wXLtZKL6qWDfHfBnJ2zQVv5AYN3izmId6EXw5gmO1Q
         G8RzsrvsF1hVApaobo4vQhtMi3/XoUF5hzAWnV3Ed7nVRVlsrAxFFDBknCly0sUsdxV5
         a8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697201676; x=1697806476;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=spTfC78Itvw/hW/o2eytnI9brc+L/P4ujKi/XHn8SkQ=;
        b=eBhJQ/K++yynhe5SBdvrRVj+o1eRwCkvLf8n8R50NbwMK91wfKI306kGMUPA7XQTDu
         6GEg+he4BtbtqpePITxmzIdyNHvFcG1/6bpXyfvLld9hwNSP6NZCQeXE/ESqzp7rlxmo
         /vJOIWHbFCaj0ARy2M+ES1gLGdD1w6800EWY+DyrFPFYnuKRw6WmRSWTWP5iNlV6dOrY
         Kmc3LjcaED0T0FTOBWoUorUcP6Yz5jwyVjOQ8AU9TjnRJ1ghyctb5SVDd6PTf6xxT/hd
         PnyT3Z8g8ttxf9MuWw57pAFrJq37WovVXAp1Mt4/4oiNqjtFR85BLow3x88uLwJmgclO
         oUKA==
X-Gm-Message-State: AOJu0YyBjPCdIjzR0eBZyyRJ94oUIeypUHJwGO+RbOUWmR/HXj/OnCL3
        xxf2yJ+ibKJu2MKohuEBvE4Wdcgo0HAvBVKa7wo=
X-Google-Smtp-Source: AGHT+IHmWYDS78zBfrXaXOT2tqxlDxLju4GNSBtW3NWuZ7y5KuM0DJ+rqI5HR7dz8smGz0Fmh2gW2g==
X-Received: by 2002:a17:907:1dd8:b0:9ba:3434:482b with SMTP id og24-20020a1709071dd800b009ba3434482bmr9420633ejc.26.1697201676134;
        Fri, 13 Oct 2023 05:54:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id jp20-20020a170906f75400b0099bcb44493fsm12486065ejb.147.2023.10.13.05.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 05:54:35 -0700 (PDT)
Message-ID: <209334cd-c922-4bd6-b116-83297c7e8b79@linaro.org>
Date:   Fri, 13 Oct 2023 14:54:34 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <5a3b6efe-5884-4727-a1e1-e9b8b0658523@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2023 14:08, Michal Simek wrote:
> 
> 
> On 10/13/23 13:58, Krzysztof Kozlowski wrote:
>> On 13/10/2023 13:51, Michal Simek wrote:
>>>
>>>
>>> On 10/13/23 13:46, Krzysztof Kozlowski wrote:
>>>> On 13/10/2023 13:22, Michal Simek wrote:
>>>>>>
>>>>>>> +
>>>>>>> +required:
>>>>>>> +  - compatible
>>>>>>
>>>>>> required: block goes after patternProperties: block
>>>>>>
>>>>>>> +
>>>>>>> +patternProperties:
>>>>>>> +  "^soc_revision@0$":
>>>>>>
>>>>>> Why do you define individual memory cells? Is this part of a binding?
>>>>>> IOW, OS/Linux requires this?
>>>>>
>>>>> nvmem has in kernel interface where you can reference to nodes. nvmem_cell_get()
>>>>> calls. It means you should be able to describe internal layout that's why names
>>>>> are used. And address in name is there because of reg property is used to
>>>>> describe base offset and size.
>>>>
>>>> That's not really what I am asking. Why internal layout of memory must
>>>> be part of the bindings?
>>>
>>> It doesn't need to be but offsets are hardcoded inside the driver itself and
>>> they can't be different.
>>
>> Hm, where? I opened drivers/nvmem/zynqmp_nvmem.c and I do not see any
>> hard-coded offsets.
> 
> Current driver supports only soc revision from offset 0.
> But if you look at 5/5 you need to define offsets where information is present.
> +#define SOC_VERSION_OFFSET	0x0
> +#define EFUSE_START_OFFSET	0xC
> +#define EFUSE_END_OFFSET	0xFC
> +#define EFUSE_PUF_START_OFFSET	0x100
> +#define EFUSE_PUF_MID_OFFSET	0x140
> +#define EFUSE_PUF_END_OFFSET	0x17F

There is nothing like this in existing driver, so the argument that "I
am adding this to the binding during conversion because driver needs it"
is not true. Conversion is only a conversion.

Now, if you want to add something new to the binding because of new
driver changes, that's separate topic.

And since it is new change in the driver I can comment: please don't.
Your nvmem driver should not depend on it. nvmem is only the provider.

Best regards,
Krzysztof

