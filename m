Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47757BA016
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbjJEOdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbjJEOb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:31:28 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5245BAD3D;
        Thu,  5 Oct 2023 02:42:46 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4065f29e933so7125545e9.1;
        Thu, 05 Oct 2023 02:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696498964; x=1697103764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=693KH3zKhYevDlo1VF7tZiOPFyQxum49fs5ILYx5v8c=;
        b=KlQlCCxaDdbdM/77MV3aYSCaAMJZrf5XTckHj73GAqe+taEDYD3GgYGNm4ne8WslZw
         zs5yuTG0s8twzf52YDk9LE+CEkWflQkuE7RbyBiYaenJQoyAspvC+W/UazfKRTHC9ZSc
         sgWKy/TQdSqfMd1LM0fEUxLLD3+yEfZNdaQ2FhwhtrslxIm4YfMQIQLvYg68D/4aGW+C
         evYxsuBqEuiGkj/XxCdhQygvB45uNMM8VHQGroxqeQCX0TY1i/ZdI2dwBUqFpsc4F4sl
         NHWJooTwrPJgK4bgYDS4cfNsGM7FNaFynLaUBHkwhpKMio0zO9vCncwe4mpunDTosVNq
         2VrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696498964; x=1697103764;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=693KH3zKhYevDlo1VF7tZiOPFyQxum49fs5ILYx5v8c=;
        b=VVl01rZ3FOaurFpIqNOlWRYmDSMc6TZT8uHqtDBPk3bwV+8z2338YLpqHB4gM9gngx
         U1p3QyGwiIxFueqqf0gHj1W61FEG0Q9mvkB8D172omUEeHmD51EIuek2Whbirkw6JzER
         Cpynt9uTRjjgcr16dRIpuUgP0nAiQWi8FsCPlKKNjbac9+P34ErJZylU2AZKF4xyoNBb
         35bXl5sENinyB0UK1gq9Lar3ckYwVs3kjuZ12reebz7iu2nle2RbtYquDpD3mO2fnvqG
         UUDTTmBjYhBWhx/p7fhmcKTqaRVnxd5D1N4ggrAj6d62L6FcKDxCSIqJsQ6b5nx/J4OF
         zvrA==
X-Gm-Message-State: AOJu0YzQed3IkYwB5N2ZTg4tL3zLzGLV6CVZw/cMRau9bJTNcd3MAFt1
        C93Jox82061++sdxvYY8Dyw=
X-Google-Smtp-Source: AGHT+IEqCjtTNseNA7LGC5Lm5Y9+taQvSKRx7vpW4rapsxY7APIyKIIa0O5eElHs85P9+NWErlFwBw==
X-Received: by 2002:a05:600c:c9:b0:405:3dee:3515 with SMTP id u9-20020a05600c00c900b004053dee3515mr4625492wmm.27.1696498964439;
        Thu, 05 Oct 2023 02:42:44 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040535648639sm1103836wmm.36.2023.10.05.02.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 02:42:43 -0700 (PDT)
Message-ID: <d58bbe17-efa7-4548-9c7d-bf0310d31ef5@gmail.com>
Date:   Thu, 5 Oct 2023 11:42:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] drm: Annotate structs with __counted_by
To:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        David Airlie <airlied@gmail.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Karol Herbst <kherbst@redhat.com>, Tom Rix <trix@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        dri-devel@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Prike Liang <Prike.Liang@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Matthew Brost <matthew.brost@intel.com>,
        Evan Quan <evan.quan@amd.com>, Emma Anholt <emma@anholt.net>,
        amd-gfx@lists.freedesktop.org,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        nouveau@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Chia-I Wu <olvaffe@gmail.com>, llvm@lists.linux.dev,
        Yifan Zhang <yifan1.zhang@amd.com>,
        linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Kevin Wang <kevin1.wang@amd.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>, Le Ma <le.ma@amd.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        virtualization@lists.linux-foundation.org,
        Sean Paul <sean@poorly.run>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Xiaojian Du <Xiaojian.Du@amd.com>, Lang Yu <Lang.Yu@amd.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Tejas Upadhyay <tejas.upadhyay@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Rob Clark <robdclark@gmail.com>, Melissa Wen <mwen@igalia.com>,
        John Harrison <john.c.harrison@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        freedreno@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>,
        linux-hardening@vger.kernel.org
References: <20230922173110.work.084-kees@kernel.org>
 <169601600138.3014939.8511343741428844249.b4-ty@chromium.org>
 <83cd056c-52ae-01dd-7576-42d41da64c26@gmail.com>
 <CADnq5_Ma2CrLYggJHKFEObsNmUoqJwb2p1xai5DfL=m43U6zEA@mail.gmail.com>
 <202310020952.E7DE0948C0@keescook>
 <10644b5f-b0a7-85ef-0658-2353ee14df0d@gmail.com>
 <202310021107.9BB46FB8E@keescook>
 <0be2dfa4-b6c1-f62a-66e1-615da7aa3c76@amd.com>
 <202310021122.B6DA850FB0@keescook>
Content-Language: en-US
From:   =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <202310021122.B6DA850FB0@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.10.23 um 20:22 schrieb Kees Cook:
> On Mon, Oct 02, 2023 at 08:11:41PM +0200, Christian König wrote:
>> Am 02.10.23 um 20:08 schrieb Kees Cook:
>>> On Mon, Oct 02, 2023 at 08:01:57PM +0200, Christian König wrote:
>>>> Am 02.10.23 um 18:53 schrieb Kees Cook:
>>>>> On Mon, Oct 02, 2023 at 11:06:19AM -0400, Alex Deucher wrote:
>>>>>> On Mon, Oct 2, 2023 at 5:20 AM Christian König
>>>>>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>>>>>> Am 29.09.23 um 21:33 schrieb Kees Cook:
>>>>>>>> On Fri, 22 Sep 2023 10:32:05 -0700, Kees Cook wrote:
>>>>>>>>> This is a batch of patches touching drm for preparing for the coming
>>>>>>>>> implementation by GCC and Clang of the __counted_by attribute. Flexible
>>>>>>>>> array members annotated with __counted_by can have their accesses
>>>>>>>>> bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS (for array
>>>>>>>>> indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family functions).
>>>>>>>>>
>>>>>>>>> As found with Coccinelle[1], add __counted_by to structs that would
>>>>>>>>> benefit from the annotation.
>>>>>>>>>
>>>>>>>>> [...]
>>>>>>>> Since this got Acks, I figure I should carry it in my tree. Let me know
>>>>>>>> if this should go via drm instead.
>>>>>>>>
>>>>>>>> Applied to for-next/hardening, thanks!
>>>>>>>>
>>>>>>>> [1/9] drm/amd/pm: Annotate struct smu10_voltage_dependency_table with __counted_by
>>>>>>>>           https://git.kernel.org/kees/c/a6046ac659d6
>>>>>>> STOP! In a follow up discussion Alex and I figured out that this won't work.
>>>>> I'm so confused; from the discussion I saw that Alex said both instances
>>>>> were false positives?
>>>>>
>>>>>>> The value in the structure is byte swapped based on some firmware
>>>>>>> endianness which not necessary matches the CPU endianness.
>>>>>> SMU10 is APU only so the endianess of the SMU firmware and the CPU
>>>>>> will always match.
>>>>> Which I think is what is being said here?
>>>>>
>>>>>>> Please revert that one from going upstream if it's already on it's way.
>>>>>>>
>>>>>>> And because of those reasons I strongly think that patches like this
>>>>>>> should go through the DRM tree :)
>>>>> Sure, that's fine -- please let me know. It was others Acked/etc. Who
>>>>> should carry these patches?
>>>> Probably best if the relevant maintainer pick them up individually.
>>>>
>>>> Some of those structures are filled in by firmware/hardware and only the
>>>> maintainers can judge if that value actually matches what the compiler
>>>> needs.
>>>>
>>>> We have cases where individual bits are used as flags or when the size is
>>>> byte swapped etc...
>>>>
>>>> Even Alex and I didn't immediately say how and where that field is actually
>>>> used and had to dig that up. That's where the confusion came from.
>>> Okay, I've dropped them all from my tree. Several had Acks/Reviews, so
>>> hopefully those can get picked up for the DRM tree?
>> I will pick those up to go through drm-misc-next.
>>
>> Going to ping maintainers once more when I'm not sure if stuff is correct or
>> not.
> Sounds great; thanks!

I wasn't 100% sure for the VC4 patch, but pushed the whole set to 
drm-misc-next anyway.

This also means that the patches are now auto merged into the drm-tip 
integration branch and should any build or unit test go boom we should 
notice immediately and can revert it pretty easily.

Thanks,
Christian.

>
> -Kees
>

