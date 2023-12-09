Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B23E80B68A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 22:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjLIV3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 16:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLIV3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 16:29:46 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0828FD0
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 13:29:51 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77f3c4914e5so169059285a.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 13:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702157390; x=1702762190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iFEUFFz09hiRyS0qcoPsXIF6VUSImKjj5WbLQv8dS3M=;
        b=kSMGWODtsfRNVnvMFyPi+SNeNbOH1Qn7BMfvOQNt3FX7PFfvH4WCCEZl6c9DPddIRJ
         8/kotrBqMWENf1oRUgSMxrj2P3l8ziJTzRFnrsWsJ0RIUdCs0oCsy45hhLXy+CMLg+XT
         czaLbZ1UI/QXvn1lfgKoBb2XmW25pI22n8l+XeeTC/GsnxE0ZC0YOXk5XduPCH6LtCA6
         MOvlP3JUeMLTcGXThGsffiPCfzzekowMt9cJ86oRegsL+CJIEoDjqkfVmAatXCBvXNKi
         17oO+lkgRmrWLooJJ2xT262fAMpPJFjPunbaxWQMJ7kBYbU2X72Kca7MeArSKFvSll0+
         JPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702157390; x=1702762190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iFEUFFz09hiRyS0qcoPsXIF6VUSImKjj5WbLQv8dS3M=;
        b=TDVsTQlbecLIJZl5we5sdAllkW52C+KMhrg8KsQrYnNQRmPg/aQxfqK7gEs2NayM2x
         X6XFjyxgq4RWOP0Q9Wr47OWX7IMSNTk16JhWKaeQzddVAv7x/xJyp1Ltf5x7UJ1bKYFc
         gnhVq2rOV0BMh411LF+HP8TF0ymL4QsY4je1d8p3/ZixTo9omX3cHpLZ2M7sn9SKOoe8
         j8rfzQP+FQMZm3jS1WWBkuAILemG8oTtipr3HZCnZdqsXheH6m/Al3XXz+WIo6bb+lni
         OS3D/iMU/5HacRVHrolz9atEJ094Kk+atH6AiUsT6hlGsvdaohtxmeHdDtWLG3AdLzis
         kEAA==
X-Gm-Message-State: AOJu0Yzl6ujBT4jOd0ZWf3hII0+uK5WfiNiIjaiMc+B1TujerCrNuphs
        Ap8y7ayTlyIgsAtZPydZbp0kEA==
X-Google-Smtp-Source: AGHT+IFocs3LkyA/Jt/FCqhjxzgRz8AgbQ0brbt26sXxD73qHkqT5u0QLdYWPcmh/VTk8arvnDsjzw==
X-Received: by 2002:a05:620a:8112:b0:77f:61d3:734c with SMTP id os18-20020a05620a811200b0077f61d3734cmr1598295qkn.43.1702157390147;
        Sat, 09 Dec 2023 13:29:50 -0800 (PST)
Received: from ?IPV6:2600:1700:2000:b002:f559:1d79:8a5d:590e? ([2600:1700:2000:b002:f559:1d79:8a5d:590e])
        by smtp.gmail.com with ESMTPSA id tn24-20020a05620a3c1800b0077f052fa73bsm1662198qkn.15.2023.12.09.13.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 13:29:48 -0800 (PST)
Message-ID: <07d27191-12b6-4c84-b80e-75c618df9de4@sifive.com>
Date:   Sat, 9 Dec 2023 15:29:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amd/display: Support DRM_AMD_DC_FP on RISC-V
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        "Conor.Dooley" <conor.dooley@microchip.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Dave Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        llvm@lists.linux.dev
References: <20231122030621.3759313-1-samuel.holland@sifive.com>
 <20231122030621.3759313-4-samuel.holland@sifive.com>
 <20231123-headdress-mold-0dd7a74477f7@wendy>
 <20231130004224.GE2513828@dev-arch.thelio-3990X>
 <4f277982-fffb-4fe1-bc02-007633400f31@sifive.com>
 <5090a015-5b6f-44be-bb25-d2ca3fdf5d40@app.fastmail.com>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <5090a015-5b6f-44be-bb25-d2ca3fdf5d40@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 2023-12-09 2:38 PM, Arnd Bergmann wrote:
> On Fri, Dec 8, 2023, at 06:04, Samuel Holland wrote:
>> On 2023-11-29 6:42 PM, Nathan Chancellor wrote:
>>> On Thu, Nov 23, 2023 at 02:23:01PM +0000, Conor Dooley wrote:
>>>> On Tue, Nov 21, 2023 at 07:05:15PM -0800, Samuel Holland wrote:
>>>>> RISC-V uses kernel_fpu_begin()/kernel_fpu_end() like several other
>>>>> architectures. Enabling hardware FP requires overriding the ISA string
>>>>> for the relevant compilation units.
>>>>
>>>> Ah yes, bringing the joy of frame-larger-than warnings to RISC-V:
>>>> ../drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:58:13: warning: stack frame size (2416) exceeds limit (2048) in 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation' [-Wframe-larger-than]
>>>
>>> :(
>>>
>>>> Nathan, have you given up on these being sorted out?
>>>
>>> Does your configuration have KASAN (I don't think RISC-V supports
>>> KCSAN)? It is possible that dml/dcn32 needs something similar to commit
>>> 6740ec97bcdb ("drm/amd/display: Increase frame warning limit with KASAN
>>> or KCSAN in dml2")?
>>>
>>> I am not really interested in playing whack-a-mole with these warnings
>>> like I have done in the past for the reasons I outlined here:
>>>
>>> https://lore.kernel.org/20231019205117.GA839902@dev-arch.thelio-3990X/
>>
>> I also see one of these with clang 17 even with KASAN disabled:
>>
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:37:6:
>> warning: stack frame size (2208) exceeds limit (2048) in 'dml32_recalculate'
>> [-Wframe-larger-than]
>> void dml32_recalculate(struct display_mode_lib *mode_lib)
>>
>>      ^
>> 1532/2208 (69.38%) spills, 676/2208 (30.62%) variables
>>
>> So I'm in favor of just raising the limit for these files for clang, like you
>> suggested in the linked thread.
> 
> How about just adding a BUG_ON(IS_ENABLED(CONFIG_RISCV))
> in that function? That should also avoid the build failure
> but give a better indication of where the problem is
> if someone actually runs into that function and triggers
> a runtime stack overflow.

Won't that break actual users of the driver, trading an unlikely but
theoretically possible stack overflow for a guaranteed crash? The intent of this
series is that I have one of these GPUs plugged in to a RISC-V board, and I want
to use it.

Regards,
Samuel

