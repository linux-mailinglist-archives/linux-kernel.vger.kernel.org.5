Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7714806A4B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346719AbjLFJEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346701AbjLFJEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:04:47 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251B119BA;
        Wed,  6 Dec 2023 01:04:52 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3332ad5b3e3so478659f8f.2;
        Wed, 06 Dec 2023 01:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701853490; x=1702458290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WOtnnMKriIqWynhK5sWA4VrWdmrI0YzrWSrmJwB2ukc=;
        b=OgVTYH9bhB1yxpqt+BitTYZ4bN6IXFkHA68L6m7jcd0zo1husdyR5zQEEumnDn9RfD
         H485tGZQABuZ8eET9rnBkfNnOWJdAdrVg4OZx+9uCqeVqLwwzVEqhzga56j2XoTWp9Oc
         7CDamGfBqRwT0EK+pwvvATxKmqy1vccSrK6mXVrTRhGoVBAgGP5cge0ltw+Qk7+LUODq
         DKngh1TRvnuJwAPwxrZ8Io0BVDsqJyAW+pbNbe2d251okWeIHTHCjd+ubhnkXIgMLhHF
         CcPEK6MRXh1u1FRtjJ6bJRZy4wzICmTNeCOh2vEL8VxZhKZPbjAE5F+LpRjnGhRxWWA1
         dVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701853490; x=1702458290;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOtnnMKriIqWynhK5sWA4VrWdmrI0YzrWSrmJwB2ukc=;
        b=DPyNvua/zkxoQfk2cJHucGOW1PxlCDq5O1hc1NgeURSUIo6zMPbVeYsxKr4dJE0wv7
         n7JpErevrSOwN/BFJLOyx+iO/fmuiGMA/1i+m/PgNSOFY8zMpbFwUf7MFq/8xjCRyp2V
         KlTYtQDS0/HRk8veCE0oVba3mb8x6fEsKQjE22FWcqGef4Bc6+yUHWQ8iANKrkolP4Nu
         XI1R90QzytzFW3LQyez1MyKlz6dAe2/a0IswOLfeuK/n7NbZQB6BSPyNtY4m+UZnf8vU
         0I6Lg/hAJNZu0Ox5VVN0kBEdez84dNasRHLWtUXt9MosfdCxXNfQ0V4/0eI2EomANb9W
         Tl2w==
X-Gm-Message-State: AOJu0YzvFTjU0nIEfWDIF3mp8qTyw+6TCGSKZispbyEhIeaWmMI2Xb7u
        9ugoJ4WJvxtRe03GYS5vHtI=
X-Google-Smtp-Source: AGHT+IEwxvTnU6iUQdCapyDpGUJnMcE+k8C0c8hfETB3YNpX9m9/dT8VslAdBQ47KTMOpcXp6ClMoQ==
X-Received: by 2002:a5d:448a:0:b0:332:d4a6:1143 with SMTP id j10-20020a5d448a000000b00332d4a61143mr284784wrq.7.1701853490199;
        Wed, 06 Dec 2023 01:04:50 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id l13-20020adffe8d000000b0033342978c93sm8880999wrr.30.2023.12.06.01.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 01:04:49 -0800 (PST)
Message-ID: <1d336117-a94f-4b79-bc71-be9c24a0246a@gmail.com>
Date:   Wed, 6 Dec 2023 10:04:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linaro-mm-sig] Re: [RFC] drm/scheduler: Unwrap job dependencies
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
References: <20230322224403.35742-1-robdclark@gmail.com>
 <b9fb81f1-ac9e-cf3f-5cf4-f2d972d3ed3d@amd.com>
 <CAF6AEGvMwZCLntfYeH3Vg_Z7kYynqdVrinp+pmcbREksK1WGMA@mail.gmail.com>
 <e2fa296b-9b71-a41b-d37d-33f0fac2cd4e@amd.com>
 <CAF6AEGvdVca_mnZVo9He9oKVfYp84e_kOPWaxX+K5aV4Es9kcQ@mail.gmail.com>
 <CAF6AEGt2D6Ei6OkUK5osz+jWzmkX8tmB1KGi305HaNd=bnQSoA@mail.gmail.com>
 <69d66b9e-5810-4844-a53f-08b7fd8eeccf@amd.com>
 <CAF6AEGuSexYVL2RF4yVCJptfJgN9vvTgzGWn3CminbsYvctTaw@mail.gmail.com>
 <96665cc5-01ab-4446-af37-e0f456bfe093@amd.com>
 <CAF6AEGtyUsARUTJb=+LwRQ96665tdcLLBxXH--18FDECuYOP6Q@mail.gmail.com>
 <CAF6AEGs5uh1sRDzz7xeDr5xZrXdtg7eoWJhPhRgqhcqAeTX1Jg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAF6AEGs5uh1sRDzz7xeDr5xZrXdtg7eoWJhPhRgqhcqAeTX1Jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 05.12.23 um 18:14 schrieb Rob Clark:
> On Tue, Dec 5, 2023 at 8:56 AM Rob Clark <robdclark@gmail.com> wrote:
>> On Tue, Dec 5, 2023 at 7:58 AM Christian König <christian.koenig@amd.com> wrote:
>>> Am 05.12.23 um 16:41 schrieb Rob Clark:
>>>> On Mon, Dec 4, 2023 at 10:46 PM Christian König
>>>> <christian.koenig@amd.com> wrote:
>>>>> Am 04.12.23 um 22:54 schrieb Rob Clark:
>>>>>> On Thu, Mar 23, 2023 at 2:30 PM Rob Clark <robdclark@gmail.com> wrote:
>>>>>>> [SNIP]
>>>>>> So, this patch turns out to blow up spectacularly with dma_fence
>>>>>> refcnt underflows when I enable DRIVER_SYNCOBJ_TIMELINE .. I think,
>>>>>> because it starts unwrapping fence chains, possibly in parallel with
>>>>>> fence signaling on the retire path.  Is it supposed to be permissible
>>>>>> to unwrap a fence chain concurrently?
>>>>> The DMA-fence chain object and helper functions were designed so that
>>>>> concurrent accesses to all elements are always possible.
>>>>>
>>>>> See dma_fence_chain_walk() and dma_fence_chain_get_prev() for example.
>>>>> dma_fence_chain_walk() starts with a reference to the current fence (the
>>>>> anchor of the walk) and tries to grab an up to date reference on the
>>>>> previous fence in the chain. Only after that reference is successfully
>>>>> acquired we drop the reference to the anchor where we started.
>>>>>
>>>>> Same for dma_fence_array_first(), dma_fence_array_next(). Here we hold a
>>>>> reference to the array which in turn holds references to each fence
>>>>> inside the array until it is destroyed itself.
>>>>>
>>>>> When this blows up we have somehow mixed up the references somewhere.
>>>> That's what it looked like to me, but wanted to make sure I wasn't
>>>> overlooking something subtle.  And in this case, the fence actually
>>>> should be the syncobj timeline point fence, not the fence chain.
>>>> Virtgpu has essentially the same logic (there we really do want to
>>>> unwrap fences so we can pass host fences back to host rather than
>>>> waiting in guest), I'm not sure if it would blow up in the same way.
>>> Well do you have a backtrace of what exactly happens?
>>>
>>> Maybe we have some _put() before _get() or something like this.
>> I hacked up something to store the backtrace in dma_fence_release()
>> (and leak the block so the backtrace would still be around later when
>> dma_fence_get/put was later called) and ended up with:
>>
>> [  152.811360] freed at:
>> [  152.813718]  dma_fence_release+0x30/0x134
>> [  152.817865]  dma_fence_put+0x38/0x98 [gpu_sched]
>> [  152.822657]  drm_sched_job_add_dependency+0x160/0x18c [gpu_sched]
>> [  152.828948]  drm_sched_job_add_syncobj_dependency+0x58/0x88 [gpu_sched]
>> [  152.835770]  msm_ioctl_gem_submit+0x580/0x1160 [msm]
>> [  152.841070]  drm_ioctl_kernel+0xec/0x16c
>> [  152.845132]  drm_ioctl+0x2e8/0x3f4
>> [  152.848646]  vfs_ioctl+0x30/0x50
>> [  152.851982]  __arm64_sys_ioctl+0x80/0xb4
>> [  152.856039]  invoke_syscall+0x8c/0x120
>> [  152.859919]  el0_svc_common.constprop.0+0xc0/0xdc
>> [  152.864777]  do_el0_svc+0x24/0x30
>> [  152.868207]  el0_svc+0x8c/0xd8
>> [  152.871365]  el0t_64_sync_handler+0x84/0x12c
>> [  152.875771]  el0t_64_sync+0x190/0x194
>>
>> I suppose that doesn't guarantee that this was the problematic put.
>> But dropping this patch to unwrap the fence makes the problem go
>> away..
> Oh, hmm, _add_dependency() is consuming the fence reference

Yeah, I was just about to point that out as well :)

Should be trivial to fix,
Christian

>
> BR,
> -R
>
>> BR,
>> -R
>>
>>> Thanks,
>>> Christian.
>>>
>>>> BR,
>>>> -R
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>> BR,
>>>>>> -R
> _______________________________________________
> Linaro-mm-sig mailing list -- linaro-mm-sig@lists.linaro.org
> To unsubscribe send an email to linaro-mm-sig-leave@lists.linaro.org

