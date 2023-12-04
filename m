Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E8C80412C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbjLDVyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjLDVyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:54:09 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF5CC3;
        Mon,  4 Dec 2023 13:54:14 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54c70c70952so3664655a12.3;
        Mon, 04 Dec 2023 13:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701726853; x=1702331653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlZLmeqxpiGQQSs10LoTtpiBgorU3TT3VUZTA6H0DRg=;
        b=OQhyiLHFdeGndwRT8/xpYQzTXwui3fbX+0vafumUYF6B7r1Z0bhgl2+GpBjFGHPpeH
         t9VsCzkOHWXRuzBLI9vKamPDQa4wQUei/jxZQaZnXl7SjfYpBMyfHgqhv55XYRu8FF0z
         sSNlPXI8fsNfBukT7LM1tWUK8l2k+VUdNQ12uqFLC+fdKqBojdnr/moJQBwiJHj7cyZ6
         d4s0pnd8SYSX5A9OGLVBN8oM5x3bCNiOZWe0aY1ZPzRan5BgBfCEshlNzhw4Vd9FmV8q
         SVU36DaW7DObBbzkf2d3eLYBB3s/fmJfpOo7hFNxa4JbxCipIY0tNbndeHHs39d/RBqG
         ZM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701726853; x=1702331653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlZLmeqxpiGQQSs10LoTtpiBgorU3TT3VUZTA6H0DRg=;
        b=niSumKhy5o8xOwEJ5MbFYuxiHgtB+ay8g5clRHUz6uI3JyB4+tklQ6MW/w/dygp1aO
         MQI4YT99U1leA/z0o0VA4xhIv6QlIL4KHqqnTrVaRftxhNMa25M1Z0tvHgpKEQBsQfNn
         VZmvYbnRaD+V7ROO23qehYvCdmzpr2sIcjw1CB5rPK05hAGV+NYBwtP0NxHt6Vfrngfa
         30BnlsONgyAZuyy/q2++Jp7o22sK7najWGofw/lbH/HcvmQz7DsZPd4Zvtk596efvc07
         nMaGdqBqd8FJ186yw+qBvsoezPodv8v1YB1ViLchD2n7YXpKpQzyUO8rXYM1p2AajrcN
         s//w==
X-Gm-Message-State: AOJu0YzydVDak55kyLuSm4unyHxYbR7JE7YiZeP256Os8tFRgV9CU7MG
        EqTR6ml/OifU4N8dc2uethGly1SHOBaiV14hnt0=
X-Google-Smtp-Source: AGHT+IHLb6cOm/rSV+8ZQDXUTAc7/tdhPwiDOu1giLgNpUuulAb5IUur2kx36jKOArzZ7OT3QTPrJ5xd+t3zYomTLWs=
X-Received: by 2002:a50:ab12:0:b0:54c:ba16:f573 with SMTP id
 s18-20020a50ab12000000b0054cba16f573mr1121210edc.69.1701726852960; Mon, 04
 Dec 2023 13:54:12 -0800 (PST)
MIME-Version: 1.0
References: <20230322224403.35742-1-robdclark@gmail.com> <b9fb81f1-ac9e-cf3f-5cf4-f2d972d3ed3d@amd.com>
 <CAF6AEGvMwZCLntfYeH3Vg_Z7kYynqdVrinp+pmcbREksK1WGMA@mail.gmail.com>
 <e2fa296b-9b71-a41b-d37d-33f0fac2cd4e@amd.com> <CAF6AEGvdVca_mnZVo9He9oKVfYp84e_kOPWaxX+K5aV4Es9kcQ@mail.gmail.com>
In-Reply-To: <CAF6AEGvdVca_mnZVo9He9oKVfYp84e_kOPWaxX+K5aV4Es9kcQ@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 4 Dec 2023 13:54:00 -0800
Message-ID: <CAF6AEGt2D6Ei6OkUK5osz+jWzmkX8tmB1KGi305HaNd=bnQSoA@mail.gmail.com>
Subject: Re: [RFC] drm/scheduler: Unwrap job dependencies
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 2:30=E2=80=AFPM Rob Clark <robdclark@gmail.com> wro=
te:
>
> On Thu, Mar 23, 2023 at 7:03=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > Am 23.03.23 um 14:54 schrieb Rob Clark:
> > > On Thu, Mar 23, 2023 at 12:35=E2=80=AFAM Christian K=C3=B6nig
> > > <christian.koenig@amd.com> wrote:
> > >> Am 22.03.23 um 23:44 schrieb Rob Clark:
> > >>> From: Rob Clark <robdclark@chromium.org>
> > >>>
> > >>> Container fences have burner contexts, which makes the trick to sto=
re at
> > >>> most one fence per context somewhat useless if we don't unwrap arra=
y or
> > >>> chain fences.
> > >> Mhm, we intentionally kept them not unwrapped since this way they on=
ly
> > >> occupy one fence slot.
> > >>
> > >> But it might be better to unwrap them if you add many of those depen=
dencies.
> > >>
> > >>> Signed-off-by: Rob Clark <robdclark@chromium.org>
> > >>> ---
> > >>> tbh, I'm not sure why we weren't doing this already, unless there i=
s
> > >>> something I'm overlooking
> > >>>
> > >>>    drivers/gpu/drm/scheduler/sched_main.c | 43 +++++++++++++++++---=
------
> > >>>    1 file changed, 28 insertions(+), 15 deletions(-)
> > >>>
> > >>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/d=
rm/scheduler/sched_main.c
> > >>> index c2ee44d6224b..f59e5335afbb 100644
> > >>> --- a/drivers/gpu/drm/scheduler/sched_main.c
> > >>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > >>> @@ -41,20 +41,21 @@
> > >>>     * 4. Entities themselves maintain a queue of jobs that will be =
scheduled on
> > >>>     *    the hardware.
> > >>>     *
> > >>>     * The jobs in a entity are always scheduled in the order that t=
hey were pushed.
> > >>>     */
> > >>>
> > >>>    #include <linux/kthread.h>
> > >>>    #include <linux/wait.h>
> > >>>    #include <linux/sched.h>
> > >>>    #include <linux/completion.h>
> > >>> +#include <linux/dma-fence-unwrap.h>
> > >>>    #include <linux/dma-resv.h>
> > >>>    #include <uapi/linux/sched/types.h>
> > >>>
> > >>>    #include <drm/drm_print.h>
> > >>>    #include <drm/drm_gem.h>
> > >>>    #include <drm/gpu_scheduler.h>
> > >>>    #include <drm/spsc_queue.h>
> > >>>
> > >>>    #define CREATE_TRACE_POINTS
> > >>>    #include "gpu_scheduler_trace.h"
> > >>> @@ -665,41 +666,27 @@ void drm_sched_job_arm(struct drm_sched_job *=
job)
> > >>>        sched =3D entity->rq->sched;
> > >>>
> > >>>        job->sched =3D sched;
> > >>>        job->s_priority =3D entity->rq - sched->sched_rq;
> > >>>        job->id =3D atomic64_inc_return(&sched->job_id_count);
> > >>>
> > >>>        drm_sched_fence_init(job->s_fence, job->entity);
> > >>>    }
> > >>>    EXPORT_SYMBOL(drm_sched_job_arm);
> > >>>
> > >>> -/**
> > >>> - * drm_sched_job_add_dependency - adds the fence as a job dependen=
cy
> > >>> - * @job: scheduler job to add the dependencies to
> > >>> - * @fence: the dma_fence to add to the list of dependencies.
> > >>> - *
> > >>> - * Note that @fence is consumed in both the success and error case=
s.
> > >>> - *
> > >>> - * Returns:
> > >>> - * 0 on success, or an error on failing to expand the array.
> > >>> - */
> > >>> -int drm_sched_job_add_dependency(struct drm_sched_job *job,
> > >>> -                              struct dma_fence *fence)
> > >>> +static int _add_dependency(struct drm_sched_job *job, struct dma_f=
ence *fence)
> > >> Please keep the drm_sched_job_ prefix here even for static functions=
.
> > >> The symbol _add_dependency just sucks in a backtrace, especially whe=
n
> > >> it's tail optimized.
> > >>
> > >>>    {
> > >>>        struct dma_fence *entry;
> > >>>        unsigned long index;
> > >>>        u32 id =3D 0;
> > >>>        int ret;
> > >>>
> > >>> -     if (!fence)
> > >>> -             return 0;
> > >>> -
> > >>>        /* Deduplicate if we already depend on a fence from the same=
 context.
> > >>>         * This lets the size of the array of deps scale with the nu=
mber of
> > >>>         * engines involved, rather than the number of BOs.
> > >>>         */
> > >>>        xa_for_each(&job->dependencies, index, entry) {
> > >>>                if (entry->context !=3D fence->context)
> > >>>                        continue;
> > >>>
> > >>>                if (dma_fence_is_later(fence, entry)) {
> > >>>                        dma_fence_put(entry);
> > >>> @@ -709,20 +696,46 @@ int drm_sched_job_add_dependency(struct drm_s=
ched_job *job,
> > >>>                }
> > >>>                return 0;
> > >>>        }
> > >>>
> > >>>        ret =3D xa_alloc(&job->dependencies, &id, fence, xa_limit_32=
b, GFP_KERNEL);
> > >>>        if (ret !=3D 0)
> > >>>                dma_fence_put(fence);
> > >>>
> > >>>        return ret;
> > >>>    }
> > >>> +
> > >>> +/**
> > >>> + * drm_sched_job_add_dependency - adds the fence as a job dependen=
cy
> > >>> + * @job: scheduler job to add the dependencies to
> > >>> + * @fence: the dma_fence to add to the list of dependencies.
> > >>> + *
> > >>> + * Note that @fence is consumed in both the success and error case=
s.
> > >>> + *
> > >>> + * Returns:
> > >>> + * 0 on success, or an error on failing to expand the array.
> > >>> + */
> > >>> +int drm_sched_job_add_dependency(struct drm_sched_job *job,
> > >>> +                              struct dma_fence *fence)
> > >> Maybe name the new function drm_sched_job_unwrap_add_dependency or
> > >> something like this.
> > >>
> > >> I need to double check, but I think for some cases we don't need or
> > >> don't even want this in the driver.
> > > I'd be curious to know the cases where you don't want this.. one thin=
g
> > > I was thinking about, what if you have a container fence with two
> > > contained fences.  One is on the same ctx as the job, one is not but
> > > signals sooner.  You end up artificially waiting on both, which seems
> > > sub-optimal.
> >
> > Well resv objects don't contain other containers for example.
>
> I suppose I have the explicit sync case more in mind, where the
> dependent fence ends up being a chain or array (if userspace is
> merging fence fd's).
>
> > Then we also have an use case in amdgpu where fence need to be
> > explicitly waited for even when they are from the same ctx as the job
> > because otherwise we wouldn't see everything cache coherent.
>
> This was the kinda weird case I wanted to make sure I wasn't breaking.
> I remember seeing something fly by for this, but can't find it now or
> remember what amdgpu's solution was..
>
> > On the other hand we currently handle that amdgpu use case differently
> > and the extra overhead of unwrapping fences even if they can't be
> > containers is probably negligible.
> >
> > > Anyways, I can make this a new entrypoint which unwraps, and/or renam=
e
> > > the internal static function, if we think this is a good idea.
> >
> > If you think that's unnecessary keeping your original approach is fine
> > with me as well.
>
> I'm going to assume unnecessary until someone speaks up with their
> weird specific case ;-)

So, this patch turns out to blow up spectacularly with dma_fence
refcnt underflows when I enable DRIVER_SYNCOBJ_TIMELINE .. I think,
because it starts unwrapping fence chains, possibly in parallel with
fence signaling on the retire path.  Is it supposed to be permissible
to unwrap a fence chain concurrently?

BR,
-R

> BR,
> -R
>
> > Regards,
> > Christian.
> >
> > >
> > > BR,
> > > -R
> > >
> > >> Christian.
> > >>
> > >>> +{
> > >>> +     struct dma_fence_unwrap iter;
> > >>> +     struct dma_fence *f;
> > >>> +     int ret =3D 0;
> > >>> +
> > >>> +     dma_fence_unwrap_for_each (f, &iter, fence) {
> > >>> +             ret =3D _add_dependency(job, f);
> > >>> +             if (ret)
> > >>> +                     break;
> > >>> +     }
> > >>> +
> > >>> +     return ret;
> > >>> +}
> > >>>    EXPORT_SYMBOL(drm_sched_job_add_dependency);
> > >>>
> > >>>    /**
> > >>>     * drm_sched_job_add_resv_dependencies - add all fences from the=
 resv to the job
> > >>>     * @job: scheduler job to add the dependencies to
> > >>>     * @resv: the dma_resv object to get the fences from
> > >>>     * @usage: the dma_resv_usage to use to filter the fences
> > >>>     *
> > >>>     * This adds all fences matching the given usage from @resv to @=
job.
> > >>>     * Must be called with the @resv lock held.
> >
