Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52307F33DD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjKUQfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKUQfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:35:41 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C0719E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:35:36 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c87acba73bso35169451fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700584535; x=1701189335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F0Qc58VOhtQSFb6zH77rAvrOot3qoWr1Hqgr/cQJ/eg=;
        b=wyWqC9swm9S/55hr5E7EeP5P1ewt+mauRNO7l/zNP3fdoFbmDjY7eXuja3Q/ep0fr7
         RQOA1gY48+ltyJOPO2phrKn/9KCXbThw71WSQRy9pQU2mywEsgXek8IYQzs9KBP6ZEhF
         Y/w5IYmE7PJOwyzfSyI7+iXVuC3klPWqVNtIyLT+Sw5i+gsv0hIiiw7xWamJaDRmPfiZ
         QMr+aaegVoFXYQecnct/BIWLZrlz5nWs4e2pKbcIHf7N80UOXdzEaVRmql/h43RCoPOI
         OW7EOAMDjJk3B0K4/MxrKGqPARlnyJW16xrK6zMbh7CBPaajrj4yRwJlADTreg1116bx
         Vnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700584535; x=1701189335;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0Qc58VOhtQSFb6zH77rAvrOot3qoWr1Hqgr/cQJ/eg=;
        b=c8OEJ177q0JuIw0N893EWCSf3vk0HcQju+s/QMKdwP80bxOe8ubt9ew+UMivWqfUi1
         xhX13IwkROissjIRHiI0w4SaPO5KxOqjAkPOfk4YRxwndsw6dldKaWSYmoj01KN351hR
         P5DqPFNMtx2r61cE+Fo3jt8zwBqkzU1jhlh1BDwYtL6ZnaJUCiaKQpeAn2D0d0t+px5K
         OR3NQ73tuAf7m1fh/dNkF08dHB25ahTqxUmPlZ5bqCbvDFIhzx59O12gTIcHGRFdEJGA
         56nYg5RTvys413Nm0dIcXpUwHdCUrYG2Y92rbl5zPRTszGhIe46z2n+BzcYF4FljjeBg
         QViQ==
X-Gm-Message-State: AOJu0YwbPtBKbrIwb0tfjTgr73xoiBvdO95oJnHVvZRW5kjb8/qdczOF
        ULIBe0XmXUoMHCFQWvo9Zi3LkA==
X-Google-Smtp-Source: AGHT+IFovDezjZHG+3S3ZJllJwIhLh9fyfAyiCj86C8liDIgk3R+JsbXwgyyfN5jtQ7MeJXgiPmefg==
X-Received: by 2002:a05:6512:3c81:b0:50a:aa0e:876f with SMTP id h1-20020a0565123c8100b0050aaa0e876fmr7583958lfv.53.1700584534875;
        Tue, 21 Nov 2023 08:35:34 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id n22-20020a170906b31600b009fc6ac28110sm3402780ejz.20.2023.11.21.08.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 08:35:34 -0800 (PST)
Message-ID: <5ee44954-1ea8-4ab6-b308-d58b52bd5c87@linaro.org>
Date:   Tue, 21 Nov 2023 17:35:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panfrost: Really power off GPU cores in
 panfrost_gpu_power_off()
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Steven Price <steven.price@arm.com>,
        boris.brezillon@collabora.com
Cc:     tzimmermann@suse.de, linux-kernel@vger.kernel.org,
        mripard@kernel.org, dri-devel@lists.freedesktop.org,
        wenst@chromium.org, kernel@collabora.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20231102141507.73481-1-angelogioacchino.delregno@collabora.com>
 <7928524a-b581-483b-b1a1-6ffd719ce650@arm.com>
 <1c9838fb-7f2d-4752-b86a-95bcf504ac2f@linaro.org>
 <6b7a4669-7aef-41a7-8201-c2cfe401bc43@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <6b7a4669-7aef-41a7-8201-c2cfe401bc43@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2023 17:11, AngeloGioacchino Del Regno wrote:
> Il 21/11/23 16:34, Krzysztof Kozlowski ha scritto:
>> On 08/11/2023 14:20, Steven Price wrote:
>>> On 02/11/2023 14:15, AngeloGioacchino Del Regno wrote:
>>>> The layout of the registers {TILER,SHADER,L2}_PWROFF_LO, used to request
>>>> powering off cores, is the same as the {TILER,SHADER,L2}_PWRON_LO ones:
>>>> this means that in order to request poweroff of cores, we are supposed
>>>> to write a bitmask of cores that should be powered off!
>>>> This means that the panfrost_gpu_power_off() function has always been
>>>> doing nothing.
>>>>
>>>> Fix powering off the GPU by writing a bitmask of the cores to poweroff
>>>> to the relevant PWROFF_LO registers and then check that the transition
>>>> (from ON to OFF) has finished by polling the relevant PWRTRANS_LO
>>>> registers.
>>>>
>>>> While at it, in order to avoid code duplication, move the core mask
>>>> logic from panfrost_gpu_power_on() to a new panfrost_get_core_mask()
>>>> function, used in both poweron and poweroff.
>>>>
>>>> Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
>>
>> Hi,
>>
>> This commit was added to next recently but it causes "external abort on
>> non-linefetch" during boot of my Odroid HC1 board.
>>
>> At least bisect points to it.
>>
>> If fixed, please add:
>>
>> Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> [    4.861683] 8<--- cut here ---
>> [    4.863429] Unhandled fault: external abort on non-linefetch (0x1008) at 0xf0c8802c
>> [    4.871018] [f0c8802c] *pgd=433ed811, *pte=11800653, *ppte=11800453
>> ...
>> [    5.164010]  panfrost_gpu_irq_handler from __handle_irq_event_percpu+0xcc/0x31c
>> [    5.171276]  __handle_irq_event_percpu from handle_irq_event+0x38/0x80
>> [    5.177765]  handle_irq_event from handle_fasteoi_irq+0x9c/0x250
>> [    5.183743]  handle_fasteoi_irq from generic_handle_domain_irq+0x28/0x38
>> [    5.190417]  generic_handle_domain_irq from gic_handle_irq+0x88/0xa8
>> [    5.196741]  gic_handle_irq from generic_handle_arch_irq+0x34/0x44
>> [    5.202893]  generic_handle_arch_irq from __irq_svc+0x8c/0xd0
>>
>> Full log:
>> https://krzk.eu/#/builders/21/builds/4392/steps/11/logs/serial0
>>
> 
> Hey Krzysztof,
> 
> This is interesting. It might be about the cores that are missing from the partial
> core_mask raising interrupts, but an external abort on non-linefetch is strange to
> see here.
> 
> Would you be available for some tests?
> 
> I'm thinking to call power_off on all cores (all shaders, all tilers, all l2s),
> regardless of what panfrost_get_core_mask() says, as it could be that your GPU
> powers on the cores that are unused by Panfrost by default, and that then we never
> turn them off, escalating to this issue.
> 
> If you can please please please test:
> 
> void panfrost_gpu_power_off(struct panfrost_device *pfdev)
> {
> 	u64 core_mask = panfrost_get_core_mask(pfdev);
> 	int ret;
> 	u32 val;
> 
> 	gpu_write(pfdev, SHADER_PWROFF_LO, pfdev->features.shader_present);
> 	gpu_write(pfdev, SHADER_PWROFF_HI, pfdev->features.shader_present >> 32);
> 	ret = readl_relaxed_poll_timeout(pfdev->iomem + SHADER_PWRTRANS_LO,
> 					 val, !val, 1, 1000);
> 	if (ret)
> 		dev_err(pfdev->dev, "shader power transition timeout");
> 
> 	gpu_write(pfdev, TILER_PWROFF_LO, pfdev->features.tiler_present);
> 	gpu_write(pfdev, TILER_PWROFF_HI, pfdev->features.tiler_present >> 32);
> 	ret = readl_relaxed_poll_timeout(pfdev->iomem + TILER_PWRTRANS_LO,
> 					 val, !val, 1, 1000);
> 	if (ret)
> 		dev_err(pfdev->dev, "tiler power transition timeout");
> 
> 	gpu_write(pfdev, L2_PWROFF_LO, pfdev->features.l2_present);
> 	ret = readl_poll_timeout(pfdev->iomem + L2_PWRTRANS_LO,
> 					 val, !val, 0, 1000);
> 	if (ret)
> 		dev_err(pfdev->dev, "l2 power transition timeout");
> 
> 	gpu_write(pfdev, L2_PWROFF_HI, pfdev->features.l2_present >> 32);
> 	ret = readl_poll_timeout(pfdev->iomem + L2_PWRTRANS_HI,
> 					 val, !val, 0, 1000);
> 	if (ret)
> 		dev_err(pfdev->dev, "l2 power transition timeout");
> }
> 

Send a diff please - against next or some other commit sha from next.

Best regards,
Krzysztof

