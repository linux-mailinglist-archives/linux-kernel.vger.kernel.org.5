Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA9A7F3268
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbjKUPep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbjKUPeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:34:44 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EACED
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:34:37 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a00b056ca38so214291666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700580876; x=1701185676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A8XPrjXgy2s3frM3oHSfy423ocmpIuFfhUuMZaQwqQ0=;
        b=BAYEP5uWdAvcoxEz5eUYdr6A+Rxqyt4+7a/jm3PJOaU/S+Xq3vPzETk5NhTvdhvQbl
         531sYfv6qYszVeQzVkKoHXCIhK0tuogDHx9B5hTE9aJA4DE1JPDAEcbvUVK5NatdGXj/
         qsj+k6ZThG3GJlZ+Llpblb18AIHO+ky5gFbW6eeMm68rXp834SK0rM/QtBEHxVOcN1VN
         nvBHGjc9DDXrCXqAr4gmIpR9Fcs2eYonLkaWM18OC/Fw3Ba2LaLpd6bG5Hu70qeKGclL
         Mb/Hb8/qDw46ih65lMIR7tTXmYwyKdv0d4lQdBq3xr9wreqJVTTpZ6nlXtL1dzR+tDxg
         P2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700580876; x=1701185676;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A8XPrjXgy2s3frM3oHSfy423ocmpIuFfhUuMZaQwqQ0=;
        b=aySXhvOlEYxAleluZHnGSF1hr7KjWV1D4JYp8ePibhQfPy6F4hYohvyukTkred1pit
         Xv3qCLfPIOVxlnnRksQgtcYJDj1hapZboxa5FA+ES0tLjPLHfF5KoVB26KUcOuVJcdPb
         KQmMSfdSrYRXATq9t6L33q6FqF8bNQ+atF8OFOnY98uxMDjSFdFNLzMOx/bMzoPR3Y69
         ROcMnLC7REvUspGYSYe1jM/uQ6rThJ9PLGlxm9kHwEeLgEN8HhTReEM8D08lb5iYyM52
         CqN+dxxoD+uNVfv0iyZZHwoegQa6yiF2cZqKIWvSKVhLCxxX8Nw/RBJ97VokM5Ceozf1
         oI4Q==
X-Gm-Message-State: AOJu0YyvEESmJvG+1MESk4N/ykuOmtVIwD1RPi/5DVZ6bMV2/KTHHiu7
        V0xrm0UVvJTod+uLAN7H19WqWIIWuAHDp9ubcqM=
X-Google-Smtp-Source: AGHT+IG6TIZmgc+Nf+53KQpDieUnnoY6037qQLBnc1gOe3fBNjHVf+6d3RoLClRodq9omx4MB5F5vg==
X-Received: by 2002:a17:906:8a4a:b0:a00:4d7e:4825 with SMTP id gx10-20020a1709068a4a00b00a004d7e4825mr3024902ejc.35.1700580876272;
        Tue, 21 Nov 2023 07:34:36 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id lz10-20020a170906fb0a00b009737b8d47b6sm5358811ejb.203.2023.11.21.07.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 07:34:35 -0800 (PST)
Message-ID: <1c9838fb-7f2d-4752-b86a-95bcf504ac2f@linaro.org>
Date:   Tue, 21 Nov 2023 16:34:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panfrost: Really power off GPU cores in
 panfrost_gpu_power_off()
Content-Language: en-US
To:     Steven Price <steven.price@arm.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        boris.brezillon@collabora.com
Cc:     tzimmermann@suse.de, linux-kernel@vger.kernel.org,
        mripard@kernel.org, dri-devel@lists.freedesktop.org,
        wenst@chromium.org, kernel@collabora.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20231102141507.73481-1-angelogioacchino.delregno@collabora.com>
 <7928524a-b581-483b-b1a1-6ffd719ce650@arm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <7928524a-b581-483b-b1a1-6ffd719ce650@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2023 14:20, Steven Price wrote:
> On 02/11/2023 14:15, AngeloGioacchino Del Regno wrote:
>> The layout of the registers {TILER,SHADER,L2}_PWROFF_LO, used to request
>> powering off cores, is the same as the {TILER,SHADER,L2}_PWRON_LO ones:
>> this means that in order to request poweroff of cores, we are supposed
>> to write a bitmask of cores that should be powered off!
>> This means that the panfrost_gpu_power_off() function has always been
>> doing nothing.
>>
>> Fix powering off the GPU by writing a bitmask of the cores to poweroff
>> to the relevant PWROFF_LO registers and then check that the transition
>> (from ON to OFF) has finished by polling the relevant PWRTRANS_LO
>> registers.
>>
>> While at it, in order to avoid code duplication, move the core mask
>> logic from panfrost_gpu_power_on() to a new panfrost_get_core_mask()
>> function, used in both poweron and poweroff.
>>
>> Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


Hi,

This commit was added to next recently but it causes "external abort on
non-linefetch" during boot of my Odroid HC1 board.

At least bisect points to it.

If fixed, please add:

Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[    4.861683] 8<--- cut here ---
[    4.863429] Unhandled fault: external abort on non-linefetch (0x1008) at 0xf0c8802c
[    4.871018] [f0c8802c] *pgd=433ed811, *pte=11800653, *ppte=11800453
...
[    5.164010]  panfrost_gpu_irq_handler from __handle_irq_event_percpu+0xcc/0x31c
[    5.171276]  __handle_irq_event_percpu from handle_irq_event+0x38/0x80
[    5.177765]  handle_irq_event from handle_fasteoi_irq+0x9c/0x250
[    5.183743]  handle_fasteoi_irq from generic_handle_domain_irq+0x28/0x38
[    5.190417]  generic_handle_domain_irq from gic_handle_irq+0x88/0xa8
[    5.196741]  gic_handle_irq from generic_handle_arch_irq+0x34/0x44
[    5.202893]  generic_handle_arch_irq from __irq_svc+0x8c/0xd0

Full log:
https://krzk.eu/#/builders/21/builds/4392/steps/11/logs/serial0

1. exynos_defconfig
2. HW: Odroid HC1
   ARMv7, octa-core (Cortex-A7+A15), Exynos5422 SoC
   arm,mali-t628
   
Bisect log:

git bisect start
# bad: [07b677953b9dca02928be323e2db853511305fa9] Add linux-next specific files for 20231121
git bisect bad 07b677953b9dca02928be323e2db853511305fa9
# good: [98b1cc82c4affc16f5598d4fa14b1858671b2263] Linux 6.7-rc2
git bisect good 98b1cc82c4affc16f5598d4fa14b1858671b2263
# good: [13e2401d5bdc7f5a30f2651c99f0e3374cdda815] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
git bisect good 13e2401d5bdc7f5a30f2651c99f0e3374cdda815
# bad: [3b586cd6d8e51c428675312e7c3f634eb96337e9] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
git bisect bad 3b586cd6d8e51c428675312e7c3f634eb96337e9
# bad: [9d63fd5f05248c78d9a66ce5dbc9cf5649054848] Merge branch 'drm-next' of https://gitlab.freedesktop.org/agd5f/linux
git bisect bad 9d63fd5f05248c78d9a66ce5dbc9cf5649054848
# bad: [5dea0c3fedee65413271a5700e653eff633e9a7f] drm/panel-elida-kd35t133: Drop shutdown logic
git bisect bad 5dea0c3fedee65413271a5700e653eff633e9a7f
# good: [48d45fac3940347becd290b96b2fc6d5ad8171f7] accel/ivpu: Remove support for uncached buffers
git bisect good 48d45fac3940347becd290b96b2fc6d5ad8171f7
# bad: [809ef191ee600e8bcbe2f8a769e00d2d54c16094] drm/gpuvm: add drm_gpuvm_flags to drm_gpuvm
git bisect bad 809ef191ee600e8bcbe2f8a769e00d2d54c16094
# good: [a78422e9dff366b3a46ae44caf6ec8ded9c9fc2f] drm/sched: implement dynamic job-flow control
git bisect good a78422e9dff366b3a46ae44caf6ec8ded9c9fc2f
# bad: [e4178256094a76cc36d9b9aabe7482615959b26f] drm/virtio: use uint64_t more in virtio_gpu_context_init_ioctl
git bisect bad e4178256094a76cc36d9b9aabe7482615959b26f
# bad: [56e76c0179185568049913257c18069293f8bde9] drm/panfrost: Implement ability to turn on/off GPU clocks in suspend
git bisect bad 56e76c0179185568049913257c18069293f8bde9
# bad: [57d4e26717b030fd794df3534e6b2e806eb761e4] drm/panfrost: Perform hard reset to recover GPU if soft reset fails
git bisect bad 57d4e26717b030fd794df3534e6b2e806eb761e4
# bad: [22aa1a209018dc2eca78745f7666db63637cd5dc] drm/panfrost: Really power off GPU cores in panfrost_gpu_power_off()
git bisect bad 22aa1a209018dc2eca78745f7666db63637cd5dc
# first bad commit: [22aa1a209018dc2eca78745f7666db63637cd5dc] drm/panfrost: Really power off GPU cores in panfrost_gpu_power_off()
  

Best regards,
Krzysztof

