Return-Path: <linux-kernel+bounces-91538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352C1871357
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C1A3B24B74
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5C118054;
	Tue,  5 Mar 2024 02:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cne/KgbO"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCE917C95;
	Tue,  5 Mar 2024 02:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709604248; cv=none; b=enMhdP+y/xbYkLFwCWle8s710xy+uYMsLMma2QeChKdS9oPWasS3Cnk2EWA1i36U+gxhFs0be6rKW69nof3kCycc+5L1atLe+CcHsjZ+UipFpsXYyni9CmN56QOZlx9KJV/2uzs3A1oXHkZiKV6ibdXbA16bos+fr/zFKhgfrHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709604248; c=relaxed/simple;
	bh=nYYKfNUOFhQgvcfKIGiZ9HKYCmINslELdbcTPSTt8u0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QE/TMcswkvvkN9o40blPEEgsECPsJmySPgeLZWHPehHRrjtYZ/BebVNlZpdLIgFSbG0WkYRprQ7MAu6VEzlxFLvHtWMXNhuvJKUhSv4w/AeDbA7jH56jm4IZYB4f04SzoF3htOu9wq/3b3ml7eOCfk1pVb/gNI3bfz2lnWm/f10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cne/KgbO; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d228a132acso67817761fa.0;
        Mon, 04 Mar 2024 18:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709604245; x=1710209045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNlCYCD3A5X7opMa78QyTbPYgKpu//YZT0Q5xl7o9vw=;
        b=Cne/KgbOBltYPR1DFCSwB8+6B2oV8ZUOtpNn+rXOsa/WZbbnHOzHKBv8B5G05UNoM/
         zIGlDnsBBfwmLsNka+9tT0bmI2pIrSmU9GVglnwYDrHDkArWkUCVfKjreBECUioM6iCg
         8NqpTdBe4OTk9hjEc75wP/j+71Iw2rxpuK2s1VpSQVP+xIajr2qlTVuFFWlS1o1AKLME
         RgewEI0gBXw1oFr0J2BO3Nzz43ZCVKkksg4O/X90KUqCF36M1a4C8jBVkeSL0itvvuZ1
         JLCLk14ylxWQYsQX9BdvgxDmRe2xyBm//mXVRazgeZHcXeyxJDHEjCvV8xMRgB4/c0z1
         qY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709604245; x=1710209045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNlCYCD3A5X7opMa78QyTbPYgKpu//YZT0Q5xl7o9vw=;
        b=VdjZqHLFixIkV64/vKGTkjFFmDOeCxqclfpEyANiTsOXo2Wo8bReRXV3bUpno/Zczv
         Sm359vjL4C1yeKhi/PtNVWnYMADyQmMKnLvohi4kAWFBtQKjooajhf/0bB68EmP96zj8
         yi+yJwAOAjJHzrCWZDFn24MI45/xttzzJlqN0BUFoIE+esyh0bek3aahTnnV0t1nUdDs
         IkMbcvxrpOknCPCx2/d7b3cjE7HWqkXQA6WrUkGfp27QUlLAL+d3z8CiaBA/GjtAFYun
         EbzKNNqFzjUB0hO6U0a6el8kYb2OztqtLzm5lEOzKCnintqKIfbP87Ri+ehzjJ0XK2Az
         NlCA==
X-Forwarded-Encrypted: i=1; AJvYcCWst5BbnWckQLVZkUhcc3xButeZ0//8eZuWj40jaldS39J4YkvEmyXyiWza0/9ptQ/iGD8FBQa8pyNx9P2jiT9NPiTA1ZvBAjH+NPd8gMpZVTlX2WoKKTNaqCJ+8FQoOS9cfNcd/Zvpe9N+aw==
X-Gm-Message-State: AOJu0Yyhb9JLz90LkMHXFmaXLLy8IbMws6+6SbNT892ppdS99EdoLQGl
	zTO/gfcFedoqhkXMWqUo63orbcssEuPV5DENeA8Qkbug1KyqGpw95Dr7hLc1+MvoTAbJAOLCBug
	2gkKYC28o3sedVS3ZZ5HWfa/K5aw=
X-Google-Smtp-Source: AGHT+IGRZQ/BGfXr4JyRSnaEMtBihRHwRoaenXLEwD0fFOB7V17Y1jXXWBjl3v+IqZFEixVDxybirYpjYDfuPmdJPZg=
X-Received: by 2002:ac2:428a:0:b0:513:3309:cc62 with SMTP id
 m10-20020ac2428a000000b005133309cc62mr303303lfh.47.1709604244339; Mon, 04 Mar
 2024 18:04:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301185346.10412-1-robdclark@gmail.com> <CAAfnVBnXCqCQjamnSC0SArrNykiSgjwNpMvrkmb7kTuufW-opg@mail.gmail.com>
In-Reply-To: <CAAfnVBnXCqCQjamnSC0SArrNykiSgjwNpMvrkmb7kTuufW-opg@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 4 Mar 2024 18:03:52 -0800
Message-ID: <CAF6AEGuvXAXgtDgVTL0Z80pbR4d-oUnwBf0uB1GRJkZHd=2ftQ@mail.gmail.com>
Subject: Re: [RFC] drm/msm: Add GPU memory traces
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Daniel Vetter <daniel@ffwll.ch>, Rob Clark <robdclark@chromium.org>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 5:38=E2=80=AFPM Gurchetan Singh
<gurchetansingh@chromium.org> wrote:
>
>
>
>
> On Fri, Mar 1, 2024 at 10:54=E2=80=AFAM Rob Clark <robdclark@gmail.com> w=
rote:
>>
>> From: Rob Clark <robdclark@chromium.org>
>>
>> Perfetto can use these traces to track global and per-process GPU memory
>> usage.
>>
>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>> ---
>> I realized the tracepoint that perfetto uses to show GPU memory usage
>> globally and per-process was already upstream, but with no users.
>>
>> This overlaps a bit with fdinfo, but ftrace is a lighter weight
>> mechanism and fits better with perfetto (plus is already supported in
>> trace_processor and perfetto UI, whereas something fdinfo based would
>> require new code to be added in perfetto.
>>
>> We could probably do this more globally (ie. drm_gem_get/put_pages() and
>> drm_gem_handle_create_tail()/drm_gem_object_release_handle() if folks
>> prefer.  Not sure where that leaves the TTM drivers.
>>
>>  drivers/gpu/drm/msm/Kconfig   |  1 +
>>  drivers/gpu/drm/msm/msm_drv.h |  5 +++++
>>  drivers/gpu/drm/msm/msm_gem.c | 37 +++++++++++++++++++++++++++++++++++
>>  drivers/gpu/drm/msm/msm_gpu.h |  8 ++++++++
>>  4 files changed, 51 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
>> index f202f26adab2..e4c912fcaf22 100644
>> --- a/drivers/gpu/drm/msm/Kconfig
>> +++ b/drivers/gpu/drm/msm/Kconfig
>> @@ -33,6 +33,7 @@ config DRM_MSM
>>         select PM_OPP
>>         select NVMEM
>>         select PM_GENERIC_DOMAINS
>> +       select TRACE_GPU_MEM
>>         help
>>           DRM/KMS driver for MSM/snapdragon.
>>
>> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv=
h
>> index 16a7cbc0b7dd..cb8f7e804b5b 100644
>> --- a/drivers/gpu/drm/msm/msm_drv.h
>> +++ b/drivers/gpu/drm/msm/msm_drv.h
>> @@ -137,6 +137,11 @@ struct msm_drm_private {
>>         struct msm_rd_state *hangrd;   /* debugfs to dump hanging submit=
s */
>>         struct msm_perf_state *perf;
>>
>> +       /**
>> +        * total_mem: Total/global amount of memory backing GEM objects.
>> +        */
>> +       atomic64_t total_mem;
>> +
>>         /**
>>          * List of all GEM objects (mainly for debugfs, protected by obj=
_lock
>>          * (acquire before per GEM object lock)
>> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem=
c
>> index 175ee4ab8a6f..e04c4af5d154 100644
>> --- a/drivers/gpu/drm/msm/msm_gem.c
>> +++ b/drivers/gpu/drm/msm/msm_gem.c
>> @@ -12,6 +12,9 @@
>>  #include <linux/pfn_t.h>
>>
>>  #include <drm/drm_prime.h>
>> +#include <drm/drm_file.h>
>> +
>> +#include <trace/events/gpu_mem.h>
>>
>>  #include "msm_drv.h"
>>  #include "msm_fence.h"
>> @@ -33,6 +36,34 @@ static bool use_pages(struct drm_gem_object *obj)
>>         return !msm_obj->vram_node;
>>  }
>>
>> +static void update_device_mem(struct msm_drm_private *priv, ssize_t siz=
e)
>> +{
>> +       uint64_t total_mem =3D atomic64_add_return(size, &priv->total_me=
m);
>> +       trace_gpu_mem_total(0, 0, total_mem);
>> +}
>> +
>> +static void update_ctx_mem(struct drm_file *file, ssize_t size)
>> +{
>> +       struct msm_file_private *ctx =3D file->driver_priv;
>> +       uint64_t ctx_mem =3D atomic64_add_return(size, &ctx->ctx_mem);
>> +
>> +       rcu_read_lock(); /* Locks file->pid! */
>> +       trace_gpu_mem_total(0, pid_nr(file->pid), ctx_mem);
>> +       rcu_read_unlock();
>> +
>> +}
>> +
>> +static int msm_gem_open(struct drm_gem_object *obj, struct drm_file *fi=
le)
>> +{
>> +       update_ctx_mem(file, obj->size);
>> +       return 0;
>> +}
>> +
>> +static void msm_gem_close(struct drm_gem_object *obj, struct drm_file *=
file)
>> +{
>> +       update_ctx_mem(file, -obj->size);
>> +}
>> +
>>  /*
>>   * Cache sync.. this is a bit over-complicated, to fit dma-mapping
>>   * API.  Really GPU cache is out of scope here (handled on cmdstream)
>> @@ -156,6 +187,8 @@ static struct page **get_pages(struct drm_gem_object=
 *obj)
>>                         return p;
>>                 }
>>
>> +               update_device_mem(dev->dev_private, obj->size);
>> +
>>                 msm_obj->pages =3D p;
>>
>>                 msm_obj->sgt =3D drm_prime_pages_to_sg(obj->dev, p, npag=
es);
>> @@ -209,6 +242,8 @@ static void put_pages(struct drm_gem_object *obj)
>>                         msm_obj->sgt =3D NULL;
>>                 }
>>
>> +               update_device_mem(obj->dev->dev_private, -obj->size);
>> +
>>                 if (use_pages(obj))
>>                         drm_gem_put_pages(obj, msm_obj->pages, true, fal=
se);
>>                 else
>> @@ -1118,6 +1153,8 @@ static const struct vm_operations_struct vm_ops =
=3D {
>>
>>  static const struct drm_gem_object_funcs msm_gem_object_funcs =3D {
>>         .free =3D msm_gem_free_object,
>> +       .open =3D msm_gem_open,
>> +       .close =3D msm_gem_close,
>>         .pin =3D msm_gem_prime_pin,
>>         .unpin =3D msm_gem_prime_unpin,
>>         .get_sg_table =3D msm_gem_prime_get_sg_table,
>> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu=
h
>> index 2bfcb222e353..f7d2a7d6f8cc 100644
>> --- a/drivers/gpu/drm/msm/msm_gpu.h
>> +++ b/drivers/gpu/drm/msm/msm_gpu.h
>> @@ -428,6 +428,14 @@ struct msm_file_private {
>>          * level.
>>          */
>>         struct drm_sched_entity *entities[NR_SCHED_PRIORITIES * MSM_GPU_=
MAX_RINGS];
>> +
>> +       /**
>> +        * ctx_mem:
>> +        *
>> +        * Total amount of memory of GEM buffers with handles attached f=
or
>> +        * this context.
>> +        */
>> +       atomic64_t ctx_mem;
>>  };
>
>
>
> Just for added context, past discussions on TRACE_GPU_MEM:
>
> https://lists.freedesktop.org/archives/dri-devel/2021-October/328260.html
> https://lists.freedesktop.org/archives/dri-devel/2021-January/295120.html
>
> Some have even suggested deleting the tracepoint altogether.
>
> Personally, I think we should land an internal user in a non-breaking way=
, since userspace (Perfetto) already depends on it.  Right now, we're in li=
mbo for multiple years ...

For better or for worse, the tracepoint already landed.. and tbh I
don't see any real problem with it.  And it defn seems like a valid
option to land support for in-driver and later refactor for more
shared code.  We already have the uapi and the userspace consuming it,
so doesn't seem like there is any debate there.  Maybe there is
something from the original series that could be recycled for
something less driver specific.

Re: some of the discussion about cgroups, I think that is a
non-sequitur because (AFAICT) perfetto wants a global view of pids/etc
(at least I'm not really sure what the value of system tracing is if
it isn't, you know, system level.. I deliberately avoided using
virtual-pid's for that reason)

BR,
-R

>>
>>  /**
>> --
>> 2.44.0
>>

