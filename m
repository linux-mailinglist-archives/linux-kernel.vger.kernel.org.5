Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0291E7F41A7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbjKVJ37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbjKVJ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:29:56 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD3119D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:29:48 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-543923af573so9594461a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700645387; x=1701250187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s1w8ab5r90+EJ51l39hOBpCVC+IvzWdxIq4B5cXP4xQ=;
        b=VHBw1zlxF1aESjz83LrfpuLbz3J2smOnf1kcqO6I5175vOFefUao3zvEvIyWvYpOZp
         idYMBLiWhCyUCTDKzeRNa65Pi2nemK3EyHqwhpnwXQrRfG4msX7mH5wsSTUrp8XciZ0v
         xtTcuYLR4Vt3UpHwDh9deUKUoHMvHyuL3P639V+f1NwY2EKvKG9FToyoECYVOAxJi0eD
         b6qPH4IUKbaGmOJ+SGgWDd3Sx7x8+pJpRSgw6oB51DEQSAXpw2mcVfc24uLbc2uwmr7j
         80NjFxQ1VpE/HoL8ePaOzE9mRpPbL078rXAZd+qXC0Gz96hV60A26YSxPG08YDKYrf2v
         kQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700645387; x=1701250187;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1w8ab5r90+EJ51l39hOBpCVC+IvzWdxIq4B5cXP4xQ=;
        b=c4RHlE8U+3dzza2mk25A+on7hYu5iVwajc/4D7cMFCb+NaiHCfOCudcmFRSHugRJs5
         hfOtZBHy7oSKMOBAQGsYPA1grF6ZGxVBK095tO9BvmPxMZFjMhQhv2qP+7rsYB+ZhRqg
         AI7Uxlt47WPTcEnX/BwwX7XLMgueRirahHIs2EW2rJdRdkqRVu+xbsitPDFcyrmKOf4c
         o/YKZ3s+/uvoGtkmqRSQQxwalF1twaVO+l8wf9ad3773868Q+Dm5Ci0CHnfcPkdPdrUr
         ttIhf60++cFAiVMJzAwDInokcTc1grOwX8ZPLoeG6iCl7slYc8rnWQqlexnIPz8Ep79v
         49lA==
X-Gm-Message-State: AOJu0YxbUrOjEpEbb4ky/ZEkUezKDNJy/ZnMmq2KhpyQJ+YTD11OiWMC
        Tp179QMvTRIOlk7tjj05bVgtgQ==
X-Google-Smtp-Source: AGHT+IHOW5kPh3I+vG6Z/5ArKWuEUgHJowuM8ulr+F53M00g+aYVcA+mRl6j54COsKtksWI5aKjGWg==
X-Received: by 2002:a05:6402:1202:b0:540:bf39:bf72 with SMTP id c2-20020a056402120200b00540bf39bf72mr1289129edw.25.1700645387062;
        Wed, 22 Nov 2023 01:29:47 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id a16-20020a50e710000000b00532eba07773sm5823343edn.25.2023.11.22.01.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 01:29:46 -0800 (PST)
Message-ID: <39e9514b-087c-42eb-8d0e-f75dc620e954@linaro.org>
Date:   Wed, 22 Nov 2023 10:29:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panfrost: Really power off GPU cores in
 panfrost_gpu_power_off()
Content-Language: en-US
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <4c73f67e-174c-497e-85a5-cb053ce657cb@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2023 10:06, AngeloGioacchino Del Regno wrote:

>>>>>    
>>>>
>>>> Hey Krzysztof,
>>>>
>>>> This is interesting. It might be about the cores that are missing from the partial
>>>> core_mask raising interrupts, but an external abort on non-linefetch is strange to
>>>> see here.
>>>
>>> I've seen such external aborts in the past, and the fault type has
>>> often been misleading. It's unlikely to have anything to do with a
>>
>> Yeah, often accessing device with power or clocks gated.
>>
> 
> Except my commit does *not* gate SoC power, nor SoC clocks 🙂

It could be that something (like clocks or power supplies) was missing
on this board/SoC, which was not critical till your patch came.

> 
> What the "Really power off ..." commit does is to ask the GPU to internally power
> off the shaders, tilers and L2, that's why I say that it is strange to see that
> kind of abort.
> 
> The GPU_INT_CLEAR GPU_INT_STAT, GPU_FAULT_STATUS and GPU_FAULT_ADDRESS_{HI/LO}
> registers should still be accessible even with shaders, tilers and cache OFF.
> 
> Anyway, yes, synchronizing IRQs before calling the poweroff sequence would also
> work, but that'd add up quite a bit of latency on the runtime_suspend() call, so
> in this case I'd be more for avoiding to execute any register r/w in the handler
> by either checking if the GPU is supposed to be OFF, or clearing interrupts, which
> may not work if those are generated after the execution of the poweroff function.
> Or we could simply disable the irq after power_off, but that'd be hacky (as well).
> 
> 
> Let's see if asking to poweroff *everything* works:

Worked.

Best regards,
Krzysztof

