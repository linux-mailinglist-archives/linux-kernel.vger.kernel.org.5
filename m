Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F40475371F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbjGNJvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbjGNJvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:51:41 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FD230CA;
        Fri, 14 Jul 2023 02:51:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 72F9C5BC37;
        Fri, 14 Jul 2023 09:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1689328297;
        bh=9YdiC6yP/uFp6AFL5xOcZWtsFNruI4WD3T4VKunyZuM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=tVradgmizqZtTSMOOR1/kDVWWp9IuFmRZeHsU7ET8PCoB9Gg/lv3s9QNmXaGXXvSz
         U5dY2f1B7lE/TBHDRgUCjn6EjBE+UspHpBMddK3gRTbmsCjwL40Hz/AoXw+fQX3M3k
         RlPAGl663yz9oVtSFLLy6YXSVMK+QLcBHL/YaTXlgoB2NaZ+595tz7cJF9v+SqhE/B
         JRkfi4PKbAwYmlyVuN9N4KAeM12bj4QbXatuJ4RSEiduMivPqVW5dB9AixUkWLcYkq
         9VUVPT7M2xR4ZohtD+P7oM6A5u7QlwqmDaPpVTDrAJCx4ikXGt7sfbLF8RjNoUGE72
         Zuo61b+e6nYlQ==
Message-ID: <d2e748e3-0263-70ed-0f6a-278441379371@asahilina.net>
Date:   Fri, 14 Jul 2023 18:51:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] drm/scheduler: Add more documentation
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>
Cc:     Faith Ekstrand <faith.ekstrand@collabora.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, asahi@lists.linux.dev
References: <20230714-drm-sched-fixes-v1-0-c567249709f7@asahilina.net>
 <20230714-drm-sched-fixes-v1-1-c567249709f7@asahilina.net>
 <332e031c-c04e-998c-e401-685c817ea2a1@amd.com>
 <6ba6827b-ab2b-1c03-2c72-eb3f6da7e719@asahilina.net>
 <1c9e3c2b-a2bd-e465-809c-0e57ca61f40d@amd.com>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <1c9e3c2b-a2bd-e465-809c-0e57ca61f40d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2023 18.47, Christian König wrote:
> Am 14.07.23 um 11:39 schrieb Asahi Lina:
>> On 14/07/2023 17.40, Christian König wrote:
>>> Am 14.07.23 um 10:21 schrieb Asahi Lina:
>>>> Document the implied lifetime rules of the scheduler (or at least the
>>>> intended ones), as well as the expectations of how resource acquisition
>>>> should be handled.
>>>>
>>>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>>>> ---
>>>>     drivers/gpu/drm/scheduler/sched_main.c | 58
>>>> ++++++++++++++++++++++++++++++++--
>>>>     1 file changed, 55 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
>>>> b/drivers/gpu/drm/scheduler/sched_main.c
>>>> index 7b2bfc10c1a5..1f3bc3606239 100644
>>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>>> @@ -43,9 +43,61 @@
>>>>      *
>>>>      * The jobs in a entity are always scheduled in the order that
>>>> they were pushed.
>>>>      *
>>>> - * Note that once a job was taken from the entities queue and
>>>> pushed to the
>>>> - * hardware, i.e. the pending queue, the entity must not be
>>>> referenced anymore
>>>> - * through the jobs entity pointer.
>>>> + * Lifetime rules
>>>> + * --------------
>>>> + *
>>>> + * Getting object lifetimes right across the stack is critical to
>>>> avoid UAF
>>>> + * issues. The DRM scheduler has the following lifetime rules:
>>>> + *
>>>> + * - The scheduler must outlive all of its entities.
>>>> + * - Jobs pushed to the scheduler are owned by it, and must only be
>>>> freed
>>>> + *   after the free_job() callback is called.
>>>> + * - Scheduler fences are reference-counted and may outlive the
>>>> scheduler.
>>>
>>>> + * - The scheduler *may* be destroyed while jobs are still in flight.
>>>
>>> That's not correct. The scheduler can only be destroyed after all the
>>> entities serving it have been destroyed as well as all the jobs already
>>> pushed to the hw finished.
>>
>> The point of this series is to change this behavior so I can actually
>> use the scheduler in my use case, and that begins with formally
>> documenting it as Daniel suggested. That is, I need it to be safe for
>> jobs to not be yet complete before the scheduler is destroyed (the
>> entities do get destroyed first, that's the first bullet point).
> 
> Yeah, but you need to document the current situation not how you like it
> to be.

Daniel told me to document how I think it should be, then fix the bugs 
that make it not so. That's what this series does.

>> We already had this discussion. Without this guarantee, I cannot build
>> a reasonable safe Rust abstraction. Unless you have another
>> suggestion, as far as I can tell it's either this or I give up on
>> using the DRM scheduler entirely and reimplement something else on my
>> own.
>>
>>> What might be possible to add is that the hw is still working on the
>>> already pushed jobs, but so far that was rejected as undesirable.
>>
>> Where was this rejected?
> 
> Years ago. Our initial driver suspend/resume design relied on that.
> Turned out not to be a good idea

Times change, maybe it's time to revisit that decision?

~~ Lina

