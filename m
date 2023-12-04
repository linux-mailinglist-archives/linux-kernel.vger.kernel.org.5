Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B73802C85
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbjLDH4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343619AbjLDHzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:55:40 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF18102
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 23:53:39 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3333fbbeab9so1200907f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 23:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701676415; x=1702281215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DUE9cIia5RndsrVuBCAFeRy3st8DEQwSkYVMSuUSur0=;
        b=i4YtHj4nUuogg76wyTALwUWt+mJLKKz5+7JUFJSIAj0zuFGXZ54sIyRDfyw54jgmIV
         rpLqrRTEXpZg3tCh+RtNXd62yq0W+2soEzY5qIRPb+US3ZCopdP2eaw0NS3Y96Q5rS3S
         5VDJsgEAh0gj6aR9rwn9hLrFn5OKAZ/4lNbx/TfvyCe2mWfXe4g0nV83FD1Zspqq0oz/
         HsA/Cq/48Q1//0UiV7kWnh+lGQZRUaNOCLt1d9VCtUpMampdwqGIUMf9/JfgREqTK3UT
         +phzMKIUYFpSHe5C0/T1aGGmxRCEU/eecx//00oviqkw7KrcjqIocX2E19u6TmPYiNp8
         MWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701676415; x=1702281215;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DUE9cIia5RndsrVuBCAFeRy3st8DEQwSkYVMSuUSur0=;
        b=t1nVhC2ZcCp6SH6M7r+D/JwphoagcCedKybBOncCbBni9kLMKt2P9Sw8G68ytyHAMH
         C/PnOh45yI+kIX6UCNOyLwdBUpEaDhdot5mfCPinXuwsT4rKit2LOj5BBER5Gr3PQ7K3
         yhhT7pe30anQ9qVsw48LKfDGN/YsQBybkUC5sgZFFPH8cHlVGCPnvFQND2FgM8HOJ654
         rYEktosKrKSpaYmIF6kXMTjkwlp25GHTeKU3Vnsis1MlA6N2+ceBgfDv5yVCzfWSHxli
         xhbeiaOs0XInpmFh+6uMZVfkTocPc/iYf2uKWlS8B1HYGKYp2poYA4ZlcGjkdDruwcDy
         +xfg==
X-Gm-Message-State: AOJu0YwfREf1wyxsCjyqsr3E7V8BRgfjaPPgCtUeM6GEK2n8EFnPnhj3
        NsGZGjOQmIkh6Po5Pj9uMqGR8uGncaADz0eKY1Y=
X-Google-Smtp-Source: AGHT+IFe3sKzxeepTekqDNg5IF+EueiJ2Wb9yYNrh2Wyp9e/pQD2dR0MmBaREgcI+/CHxC9EsDpSlg==
X-Received: by 2002:adf:a195:0:b0:332:ee1e:1993 with SMTP id u21-20020adfa195000000b00332ee1e1993mr3009916wru.20.1701676415546;
        Sun, 03 Dec 2023 23:53:35 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id f9-20020a056000036900b00332e073f12bsm11009137wrf.19.2023.12.03.23.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Dec 2023 23:53:34 -0800 (PST)
Message-ID: <d186b6ef-5ca1-4db4-b3a2-fc1a17a2e912@linaro.org>
Date:   Mon, 4 Dec 2023 08:53:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panfrost: Really power off GPU cores in
 panfrost_gpu_power_off()
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Steven Price <steven.price@arm.com>, tzimmermann@suse.de,
        linux-kernel@vger.kernel.org, mripard@kernel.org,
        dri-devel@lists.freedesktop.org, wenst@chromium.org,
        kernel@collabora.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20231102141507.73481-1-angelogioacchino.delregno@collabora.com>
 <7928524a-b581-483b-b1a1-6ffd719ce650@arm.com>
 <1c9838fb-7f2d-4752-b86a-95bcf504ac2f@linaro.org>
 <6b7a4669-7aef-41a7-8201-c2cfe401bc43@collabora.com>
 <20231121175531.085809f5@collabora.com>
 <d95259b8-10cf-4ded-866c-47cbd2a44f84@linaro.org>
 <4c73f67e-174c-497e-85a5-cb053ce657cb@collabora.com>
 <39e9514b-087c-42eb-8d0e-f75dc620e954@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <39e9514b-087c-42eb-8d0e-f75dc620e954@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2023 10:29, Krzysztof Kozlowski wrote:
> On 22/11/2023 10:06, AngeloGioacchino Del Regno wrote:
> 
>>>>>>    
>>>>>
>>>>> Hey Krzysztof,
>>>>>
>>>>> This is interesting. It might be about the cores that are missing from the partial
>>>>> core_mask raising interrupts, but an external abort on non-linefetch is strange to
>>>>> see here.
>>>>
>>>> I've seen such external aborts in the past, and the fault type has
>>>> often been misleading. It's unlikely to have anything to do with a
>>>
>>> Yeah, often accessing device with power or clocks gated.
>>>
>>
>> Except my commit does *not* gate SoC power, nor SoC clocks 🙂
> 
> It could be that something (like clocks or power supplies) was missing
> on this board/SoC, which was not critical till your patch came.
> 
>>
>> What the "Really power off ..." commit does is to ask the GPU to internally power
>> off the shaders, tilers and L2, that's why I say that it is strange to see that
>> kind of abort.
>>
>> The GPU_INT_CLEAR GPU_INT_STAT, GPU_FAULT_STATUS and GPU_FAULT_ADDRESS_{HI/LO}
>> registers should still be accessible even with shaders, tilers and cache OFF.
>>
>> Anyway, yes, synchronizing IRQs before calling the poweroff sequence would also
>> work, but that'd add up quite a bit of latency on the runtime_suspend() call, so
>> in this case I'd be more for avoiding to execute any register r/w in the handler
>> by either checking if the GPU is supposed to be OFF, or clearing interrupts, which
>> may not work if those are generated after the execution of the poweroff function.
>> Or we could simply disable the irq after power_off, but that'd be hacky (as well).
>>
>>
>> Let's see if asking to poweroff *everything* works:
> 
> Worked.

Is anything happening with this patchset? linux-next is broken - fails
to boot - for three weeks now on my platforms.

Best regards,
Krzysztof

