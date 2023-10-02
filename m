Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087107B59B8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbjJBSCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjJBSCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:02:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2979B;
        Mon,  2 Oct 2023 11:02:05 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32320381a07so93577f8f.0;
        Mon, 02 Oct 2023 11:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696269724; x=1696874524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zam6JpvTJFSRB7Mf1N6WASAM0s+ax1vMTASmJwGp/GQ=;
        b=QS6ZD+uMxiya5EGaWSBQVsdE5heWfEHr1m/rv5WkvePRRelpkxM927XwulTiV9BJPc
         iBzmZkl5SqqUE6/iOW2hAKLxibUcx2nrT1fjTVFRVUYaipBkaDCT/j/x8OPCuY6BX6ma
         WO+OsLpZjijQ22stG2uIOD8nqJpGXdte4/u6PSrgjEBWkc9wlTUjxXuM9vxhm39n8oqr
         HlAUhuCmZaSJo/LquYHldKttpEW8Cpx5uxgOKMAlU8IM9IN+XWbKSp7H8w31rfmmR2od
         IaoxiPNuKfWVHKabRIrAs1YDDXtu45ctjjd9iVBLSWjI95MfvlVn3jTxqTpsf/mfnfh3
         udKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696269724; x=1696874524;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zam6JpvTJFSRB7Mf1N6WASAM0s+ax1vMTASmJwGp/GQ=;
        b=r2K3f4IV6g2P9bhQdB4lFjNtAodm4Iydg9DKwzB2XDNOnS29xThjZ8wNfXINcBr4Hz
         TMLly3qVf6LYx1Vf53mTbv29OgEjgKNrdKcSMtBELc2MdPF4SbtahM2BGMJqGV53FkeC
         uRpiaAuBrgeNvYn49grGnzZq1gQ2QNpjD9d8Rc072H2POr49m1E3qPaITMPv/QL+I/mv
         +HtShjksG1JQX/sYvNym2KjCm6LZZEuZFrbmjpNse/j86BeHRQNV5gOvCeoQaOSYFZHE
         jbgC/TM3v3s+Hy3T06y4QZxZQTDL8jsxU+5Fv4O+28p9MslYLqCSNKPchD4vWgkqCmYQ
         Vvtg==
X-Gm-Message-State: AOJu0Yw5B3yi/lDz8qCMB8AU7XkVXw81DEMqnWyfi8rhmufRDX1fT9vK
        u0pAEXZRUUc18bcfgJoSHAY=
X-Google-Smtp-Source: AGHT+IHXROz9dJDWlLZd0E9oyaIxp9J/Vso2ikdsfsbdxkJUFVX9OGXOEmAj9p/hMQ4gi+RMtS0pLQ==
X-Received: by 2002:adf:d4c2:0:b0:317:ddd3:1aed with SMTP id w2-20020adfd4c2000000b00317ddd31aedmr10422745wrk.68.1696269723540;
        Mon, 02 Oct 2023 11:02:03 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id g16-20020adfa490000000b003232380ffd5sm20650839wrb.106.2023.10.02.11.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 11:02:02 -0700 (PDT)
Message-ID: <10644b5f-b0a7-85ef-0658-2353ee14df0d@gmail.com>
Date:   Mon, 2 Oct 2023 20:01:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/9] drm: Annotate structs with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     David Airlie <airlied@gmail.com>,
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
        freedreno@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Zack Rusin <zackr@vmware.com>, linux-hardening@vger.kernel.org
References: <20230922173110.work.084-kees@kernel.org>
 <169601600138.3014939.8511343741428844249.b4-ty@chromium.org>
 <83cd056c-52ae-01dd-7576-42d41da64c26@gmail.com>
 <CADnq5_Ma2CrLYggJHKFEObsNmUoqJwb2p1xai5DfL=m43U6zEA@mail.gmail.com>
 <202310020952.E7DE0948C0@keescook>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <202310020952.E7DE0948C0@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.10.23 um 18:53 schrieb Kees Cook:
> On Mon, Oct 02, 2023 at 11:06:19AM -0400, Alex Deucher wrote:
>> On Mon, Oct 2, 2023 at 5:20 AM Christian König
>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>> Am 29.09.23 um 21:33 schrieb Kees Cook:
>>>> On Fri, 22 Sep 2023 10:32:05 -0700, Kees Cook wrote:
>>>>> This is a batch of patches touching drm for preparing for the coming
>>>>> implementation by GCC and Clang of the __counted_by attribute. Flexible
>>>>> array members annotated with __counted_by can have their accesses
>>>>> bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS (for array
>>>>> indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family functions).
>>>>>
>>>>> As found with Coccinelle[1], add __counted_by to structs that would
>>>>> benefit from the annotation.
>>>>>
>>>>> [...]
>>>> Since this got Acks, I figure I should carry it in my tree. Let me know
>>>> if this should go via drm instead.
>>>>
>>>> Applied to for-next/hardening, thanks!
>>>>
>>>> [1/9] drm/amd/pm: Annotate struct smu10_voltage_dependency_table with __counted_by
>>>>         https://git.kernel.org/kees/c/a6046ac659d6
>>> STOP! In a follow up discussion Alex and I figured out that this won't work.
> I'm so confused; from the discussion I saw that Alex said both instances
> were false positives?
>
>>> The value in the structure is byte swapped based on some firmware
>>> endianness which not necessary matches the CPU endianness.
>> SMU10 is APU only so the endianess of the SMU firmware and the CPU
>> will always match.
> Which I think is what is being said here?
>
>>> Please revert that one from going upstream if it's already on it's way.
>>>
>>> And because of those reasons I strongly think that patches like this
>>> should go through the DRM tree :)
> Sure, that's fine -- please let me know. It was others Acked/etc. Who
> should carry these patches?

Probably best if the relevant maintainer pick them up individually.

Some of those structures are filled in by firmware/hardware and only the 
maintainers can judge if that value actually matches what the compiler 
needs.

We have cases where individual bits are used as flags or when the size 
is byte swapped etc...

Even Alex and I didn't immediately say how and where that field is 
actually used and had to dig that up. That's where the confusion came from.

Regards,
Christian.

>
> Thanks!
>
> -Kees
>
>
>>> Regards,
>>> Christian.
>>>
>>>> [2/9] drm/amdgpu/discovery: Annotate struct ip_hw_instance with __counted_by
>>>>         https://git.kernel.org/kees/c/4df33089b46f
>>>> [3/9] drm/i915/selftests: Annotate struct perf_series with __counted_by
>>>>         https://git.kernel.org/kees/c/ffd3f823bdf6
>>>> [4/9] drm/msm/dpu: Annotate struct dpu_hw_intr with __counted_by
>>>>         https://git.kernel.org/kees/c/2de35a989b76
>>>> [5/9] drm/nouveau/pm: Annotate struct nvkm_perfdom with __counted_by
>>>>         https://git.kernel.org/kees/c/188aeb08bfaa
>>>> [6/9] drm/vc4: Annotate struct vc4_perfmon with __counted_by
>>>>         https://git.kernel.org/kees/c/59a54dc896c3
>>>> [7/9] drm/virtio: Annotate struct virtio_gpu_object_array with __counted_by
>>>>         https://git.kernel.org/kees/c/5cd476de33af
>>>> [8/9] drm/vmwgfx: Annotate struct vmw_surface_dirty with __counted_by
>>>>         https://git.kernel.org/kees/c/b426f2e5356a
>>>> [9/9] drm/v3d: Annotate struct v3d_perfmon with __counted_by
>>>>         https://git.kernel.org/kees/c/dc662fa1b0e4
>>>>
>>>> Take care,
>>>>

