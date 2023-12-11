Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A9D80CFC8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344179AbjLKPk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344158AbjLKPk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:40:28 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781BEA1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:40:34 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-59064bca27dso2656010eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702309234; x=1702914034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=olWTkTTTDMqyGniJrt96EJYeNEaxv5XjfscB27aHKBI=;
        b=l1h4D7tQLoemGqj5pyxq18qsiBWZea/dcy51BbWT1G3LW1M4kXlISt8XXn45rV7F97
         d6562tTg31ZvhWNpRqPocCj3hc30LaTk/ULYn9kJVFXS6sbdBvPSj+oJ8UawyO/vgFxT
         qayGnl6sEQUxEB+SlA9uK4CNOw2S5y2lFnhXJB9kCCzKrBK/qMJopKn0ZR0cXMV86y6J
         rfq06+88Oi+Z5oi+5qLCaesNMYtj4bihYv3t01DJc2njXVTTZEAQ7WkPJA1teT30ssPs
         LRiTaQn09Q+y3uEB/KYra+BFJ7PLA7mK/VbKQzBOOgmUTpt72NAfQBpUIGDTWUL6lI2A
         t2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702309234; x=1702914034;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=olWTkTTTDMqyGniJrt96EJYeNEaxv5XjfscB27aHKBI=;
        b=VzO5Y1ULRgLOxTmt4C5QIaRxoioTg1zXy740pOOGa3b0g3sfeTHaBWKlRsUE8ejE07
         5dTSjhnJhKVR/vlcrUpVBvFf8wvebillx5xJMpOVvAI4ImYOgMK9KDna3B9C51WM+Jtg
         6Vize2oGRTzqjABcFbIM/p5qe8AS3+Maq783L6CIWP6mTHmNTlyxj3EAyeMFCldoLRgM
         ATcmQlmPN2dK8gbAQGkAw8hBxMOTk4lHu1QQy3xCsPr76SodIn4lDtL5cSWs4NVXX+8F
         SHGwVBAIPpA4WrNrnX3qv+sGqlmFH/PPGopuD1rGxef5AqhhdeBgLJGPJ/S1KoVlxTxH
         maqA==
X-Gm-Message-State: AOJu0Yzlb8j2dpp3PWr9HU9xC9He28csRzNO4mLYLAVj6qdq3xT+jNmy
        0s0/y+kVw3I/Qv6JAfd7cS/vJw==
X-Google-Smtp-Source: AGHT+IHkgREgetJtJ3CpZeBOhCg+lo0iJmAL4cDPZHyGGcooXLGdNWNZrDMNjy7Xl75SejBdf5W5Lg==
X-Received: by 2002:a05:6358:9209:b0:170:1d30:56e0 with SMTP id d9-20020a056358920900b001701d3056e0mr5134113rwb.30.1702309233725;
        Mon, 11 Dec 2023 07:40:33 -0800 (PST)
Received: from ?IPV6:2600:1700:2000:b002:f8a3:26ec:ac85:392e? ([2600:1700:2000:b002:f8a3:26ec:ac85:392e])
        by smtp.gmail.com with ESMTPSA id s6-20020a0cf646000000b0067ec9faed23sm1463005qvm.142.2023.12.11.07.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 07:40:33 -0800 (PST)
Message-ID: <ae9b5592-549d-4a6a-82c8-9545ab8eb924@sifive.com>
Date:   Mon, 11 Dec 2023 09:40:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amd/display: Support DRM_AMD_DC_FP on RISC-V
Content-Language: en-US
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        "Conor.Dooley" <conor.dooley@microchip.com>, llvm@lists.linux.dev,
        Leo Li <sunpeng.li@amd.com>, Pan Xinhui <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-riscv@lists.infradead.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20231122030621.3759313-1-samuel.holland@sifive.com>
 <20231122030621.3759313-4-samuel.holland@sifive.com>
 <20231123-headdress-mold-0dd7a74477f7@wendy>
 <20231130004224.GE2513828@dev-arch.thelio-3990X>
 <4f277982-fffb-4fe1-bc02-007633400f31@sifive.com>
 <5090a015-5b6f-44be-bb25-d2ca3fdf5d40@app.fastmail.com>
 <07d27191-12b6-4c84-b80e-75c618df9de4@sifive.com>
 <CADnq5_O+ozkwQAEn3K_=-pB2L0+pbc+tbPU0CEwOTa+QysogAg@mail.gmail.com>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <CADnq5_O+ozkwQAEn3K_=-pB2L0+pbc+tbPU0CEwOTa+QysogAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 2023-12-11 9:17 AM, Alex Deucher wrote:
> On Sun, Dec 10, 2023 at 5:10 AM Samuel Holland
> <samuel.holland@sifive.com> wrote:
>>
>> Hi Arnd,
>>
>> On 2023-12-09 2:38 PM, Arnd Bergmann wrote:
>>> On Fri, Dec 8, 2023, at 06:04, Samuel Holland wrote:
>>>> On 2023-11-29 6:42 PM, Nathan Chancellor wrote:
>>>>> On Thu, Nov 23, 2023 at 02:23:01PM +0000, Conor Dooley wrote:
>>>>>> On Tue, Nov 21, 2023 at 07:05:15PM -0800, Samuel Holland wrote:
>>>>>>> RISC-V uses kernel_fpu_begin()/kernel_fpu_end() like several other
>>>>>>> architectures. Enabling hardware FP requires overriding the ISA string
>>>>>>> for the relevant compilation units.
>>>>>>
>>>>>> Ah yes, bringing the joy of frame-larger-than warnings to RISC-V:
>>>>>> ../drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:58:13: warning: stack frame size (2416) exceeds limit (2048) in 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation' [-Wframe-larger-than]
>>>>>
>>>>> :(
>>>>>
>>>>>> Nathan, have you given up on these being sorted out?
>>>>>
>>>>> Does your configuration have KASAN (I don't think RISC-V supports
>>>>> KCSAN)? It is possible that dml/dcn32 needs something similar to commit
>>>>> 6740ec97bcdb ("drm/amd/display: Increase frame warning limit with KASAN
>>>>> or KCSAN in dml2")?
>>>>>
>>>>> I am not really interested in playing whack-a-mole with these warnings
>>>>> like I have done in the past for the reasons I outlined here:
>>>>>
>>>>> https://lore.kernel.org/20231019205117.GA839902@dev-arch.thelio-3990X/
>>>>
>>>> I also see one of these with clang 17 even with KASAN disabled:
>>>>
>>>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:37:6:
>>>> warning: stack frame size (2208) exceeds limit (2048) in 'dml32_recalculate'
>>>> [-Wframe-larger-than]
>>>> void dml32_recalculate(struct display_mode_lib *mode_lib)
>>>>
>>>>      ^
>>>> 1532/2208 (69.38%) spills, 676/2208 (30.62%) variables
>>>>
>>>> So I'm in favor of just raising the limit for these files for clang, like you
>>>> suggested in the linked thread.
>>>
>>> How about just adding a BUG_ON(IS_ENABLED(CONFIG_RISCV))
>>> in that function? That should also avoid the build failure
>>> but give a better indication of where the problem is
>>> if someone actually runs into that function and triggers
>>> a runtime stack overflow.
>>
>> Won't that break actual users of the driver, trading an unlikely but
>> theoretically possible stack overflow for a guaranteed crash? The intent of this
>> series is that I have one of these GPUs plugged in to a RISC-V board, and I want
>> to use it.
> 
> Does this patch address the issue?
> https://gitlab.freedesktop.org/agd5f/linux/-/commit/72ada8603e36291ad91e4f40f10ef742ef79bc4e

No, I get the warning without any of these debugging options enabled. I can
reproduce with just defconfig + CONFIG_DRM_AMDGPU=m when built with clang 17.

Regards,
Samuel

