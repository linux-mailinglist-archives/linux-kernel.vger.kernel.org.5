Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0303C7DBAF6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 14:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjJ3Nip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 09:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJ3Nin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 09:38:43 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB84897;
        Mon, 30 Oct 2023 06:38:40 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507c91582fdso6449342e87.2;
        Mon, 30 Oct 2023 06:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698673119; x=1699277919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XTY7Ceg2W761HSG7aGBRMEokR6cgjVhFDn1Z8HE4To=;
        b=EOtLr2Mm76cyiN8E6XAE9qiemSkaFmbDle9gDNUFvd9GJ8Uk9sMHlyDPmOoh01XUxt
         EfEF4PV08SF+dztRjGLzjGkb6fJCIK/1NqXL+L417GYoJ3yqLXc8pn6T2aU0ZxhswADC
         QeBCM1lFpP9Si07YG412VePYF0d8DIhYhVxZKUPU/JSX6sXvD5etgWpvv2OGAikDrlQ7
         xwg8xoDCLnwFxopTyziHM5YJggsWVW8hSJ90/aDgrGSEUl89LGpie2+5J0w9wDHQk2lP
         Kt9Loq3o+QrLA7ZyEKpBtQuYNTeDfHfCHvyyV8kY8ULxn8/ne50i34XMUx1vw3LXVtLG
         1tBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698673119; x=1699277919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XTY7Ceg2W761HSG7aGBRMEokR6cgjVhFDn1Z8HE4To=;
        b=rXWvU2oIwL+CRUXkMUmL+Q948JUOa8L+MSP92QoGdSYEWQRynBbZVOUmjmakPJ1KN1
         spS40qNMIM5prqAa9dT+ELi3kgw+kH+PxwUu9RvUOd5LGn6QRYYho4CDE4IGHxL2n4jA
         0puZXhCP9vGrvT9fL288Qji3rqCwT4U8PbLZ4AtOQnM19VXwKBCbzGEBG0DzTV/Tsp8a
         qJmM/yT2sTM/0RZmECo0+BNasPPV609RmFJZCi1mFLBownSqIxgQnFP0SEgbOBbdutt6
         O/yjVBbZUXF0wlEzcG+EdkyfhKBcZXFrKQJi3BLI1eZhk+baVxAjHkqgkXpnp7jRwzQt
         ClZw==
X-Gm-Message-State: AOJu0YzyxGMDhMK/SVZl9HJkd/lstAow1L4aFxDfNiGqjnSl3pNCkWDS
        7OmX6bJAYvt6ORDXhJzvtgIs8bIMK7F3aRpY89c=
X-Google-Smtp-Source: AGHT+IHdElXWFmKYD1j9eSX3y4FD/cwV2Kl6WssGkJK7frmORyS1HkzDxkdhTKCzAef0BSodpHk6yj3z/NEtX5b7xY4=
X-Received: by 2002:a19:5513:0:b0:507:a8d1:6e57 with SMTP id
 n19-20020a195513000000b00507a8d16e57mr6903381lfe.40.1698673118796; Mon, 30
 Oct 2023 06:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231027165859.395638-1-robdclark@gmail.com> <20231027165859.395638-7-robdclark@gmail.com>
 <597b5bb3-ca75-4662-9904-12c4d8e9101a@amd.com>
In-Reply-To: <597b5bb3-ca75-4662-9904-12c4d8e9101a@amd.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 30 Oct 2023 06:38:26 -0700
Message-ID: <CAF6AEGu1Z1k0bKrMZw4-RJSC-nbO=tuDOjQiPmi61_m_1nRCgA@mail.gmail.com>
Subject: Re: [PATCH 6/7] drm/exec: Pass in initial # of objects
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Dong Chenchen <dongchenchen2@huawei.com>,
        Philip Yang <Philip.Yang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        Jonathan Kim <jonathan.kim@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 1:05=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 27.10.23 um 18:58 schrieb Rob Clark:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > In cases where the # is known ahead of time, it is silly to do the tabl=
e
> > resize dance.
>
> Ah, yes that was my initial implementation as well, but I ditched that
> because nobody actually used it.
>
> One comment below.
>
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c |  4 ++--
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c |  4 ++--
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  4 ++--
> >   drivers/gpu/drm/drm_exec.c              | 15 ++++++++++++---
> >   drivers/gpu/drm/nouveau/nouveau_exec.c  |  2 +-
> >   drivers/gpu/drm/nouveau/nouveau_uvmm.c  |  2 +-
> >   include/drm/drm_exec.h                  |  2 +-
> >   8 files changed, 22 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cs.c
> > index efdb1c48f431..d27ca8f61929 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -65,7 +65,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_par=
ser *p,
> >       }
> >
> >       amdgpu_sync_create(&p->sync);
> > -     drm_exec_init(&p->exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
> > +     drm_exec_init(&p->exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> >       return 0;
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_csa.c
> > index 720011019741..796fa6f1420b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> > @@ -70,7 +70,7 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev,=
 struct amdgpu_vm *vm,
> >       struct drm_exec exec;
> >       int r;
> >
> > -     drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
> > +     drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> >       drm_exec_until_all_locked(&exec) {
> >               r =3D amdgpu_vm_lock_pd(vm, &exec, 0);
> >               if (likely(!r))
> > @@ -110,7 +110,7 @@ int amdgpu_unmap_static_csa(struct amdgpu_device *a=
dev, struct amdgpu_vm *vm,
> >       struct drm_exec exec;
> >       int r;
> >
> > -     drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
> > +     drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> >       drm_exec_until_all_locked(&exec) {
> >               r =3D amdgpu_vm_lock_pd(vm, &exec, 0);
> >               if (likely(!r))
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gem.c
> > index ca4d2d430e28..16f1715148ad 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > @@ -203,7 +203,7 @@ static void amdgpu_gem_object_close(struct drm_gem_=
object *obj,
> >       struct drm_exec exec;
> >       long r;
> >
> > -     drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES);
> > +     drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
> >       drm_exec_until_all_locked(&exec) {
> >               r =3D drm_exec_prepare_obj(&exec, &bo->tbo.base, 1);
> >               drm_exec_retry_on_contention(&exec);
> > @@ -739,7 +739,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, voi=
d *data,
> >       }
> >
> >       drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
> > -                   DRM_EXEC_IGNORE_DUPLICATES);
> > +                   DRM_EXEC_IGNORE_DUPLICATES, 0);
> >       drm_exec_until_all_locked(&exec) {
> >               if (gobj) {
> >                       r =3D drm_exec_lock_obj(&exec, gobj);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_mes.c
> > index b6015157763a..3c351941701e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > @@ -1105,7 +1105,7 @@ int amdgpu_mes_ctx_map_meta_data(struct amdgpu_de=
vice *adev,
> >
> >       amdgpu_sync_create(&sync);
> >
> > -     drm_exec_init(&exec, 0);
> > +     drm_exec_init(&exec, 0, 0);
> >       drm_exec_until_all_locked(&exec) {
> >               r =3D drm_exec_lock_obj(&exec,
> >                                     &ctx_data->meta_data_obj->tbo.base)=
;
> > @@ -1176,7 +1176,7 @@ int amdgpu_mes_ctx_unmap_meta_data(struct amdgpu_=
device *adev,
> >       struct drm_exec exec;
> >       long r;
> >
> > -     drm_exec_init(&exec, 0);
> > +     drm_exec_init(&exec, 0, 0);
> >       drm_exec_until_all_locked(&exec) {
> >               r =3D drm_exec_lock_obj(&exec,
> >                                     &ctx_data->meta_data_obj->tbo.base)=
;
> > diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
> > index 5d2809de4517..27d11c20d148 100644
> > --- a/drivers/gpu/drm/drm_exec.c
> > +++ b/drivers/gpu/drm/drm_exec.c
> > @@ -69,16 +69,25 @@ static void drm_exec_unlock_all(struct drm_exec *ex=
ec)
> >    * drm_exec_init - initialize a drm_exec object
> >    * @exec: the drm_exec object to initialize
> >    * @flags: controls locking behavior, see DRM_EXEC_* defines
> > + * @nr: the initial # of objects
> >    *
> >    * Initialize the object and make sure that we can track locked objec=
ts.
> > + *
> > + * If nr is non-zero then it is used as the initial objects table size=
.
> > + * In either case, the table will grow (be re-allocated) on demand.
> >    */
> > -void drm_exec_init(struct drm_exec *exec, uint32_t flags)
> > +void drm_exec_init(struct drm_exec *exec, uint32_t flags, unsigned nr)
> >   {
> > +     size_t sz =3D PAGE_SIZE;
> > +
> > +     if (nr)
> > +             sz =3D (size_t)nr * sizeof(void *);
> > +
> >       exec->flags =3D flags;
> > -     exec->objects =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
> > +     exec->objects =3D kmalloc(sz, GFP_KERNEL);
>
> Please use k*v*malloc() here since we can't predict how large that will b=
e.

or __GFP_NOWARN?  If userspace (or kasan) is cheeky and asks for ~0
objects, we should probably just fail?

BR,
-R

> With that fixed the patch is Reviewed-by: Christian K=C3=B6nig
> <christian.koenig@amd.com>.
>
> Regards,
> Christian.
>
> >
> >       /* If allocation here fails, just delay that till the first use *=
/
> > -     exec->max_objects =3D exec->objects ? PAGE_SIZE / sizeof(void *) =
: 0;
> > +     exec->max_objects =3D exec->objects ? sz / sizeof(void *) : 0;
> >       exec->num_objects =3D 0;
> >       exec->contended =3D DRM_EXEC_DUMMY;
> >       exec->prelocked =3D NULL;
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_exec.c b/drivers/gpu/drm/n=
ouveau/nouveau_exec.c
> > index 19024ce21fbb..f5930cc0b3fb 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_exec.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_exec.c
> > @@ -103,7 +103,7 @@ nouveau_exec_job_submit(struct nouveau_job *job)
> >
> >       nouveau_uvmm_lock(uvmm);
> >       drm_exec_init(exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
> > -                         DRM_EXEC_IGNORE_DUPLICATES);
> > +                         DRM_EXEC_IGNORE_DUPLICATES, 0);
> >       drm_exec_until_all_locked(exec) {
> >               struct drm_gpuva *va;
> >
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/n=
ouveau/nouveau_uvmm.c
> > index aae780e4a4aa..3a9331a1c830 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> > @@ -1288,7 +1288,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *=
job)
> >       }
> >
> >       drm_exec_init(exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
> > -                         DRM_EXEC_IGNORE_DUPLICATES);
> > +                         DRM_EXEC_IGNORE_DUPLICATES, 0);
> >       drm_exec_until_all_locked(exec) {
> >               list_for_each_op(op, &bind_job->ops) {
> >                       struct drm_gpuva_op *va_op;
> > diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
> > index b5bf0b6da791..f1a66c048721 100644
> > --- a/include/drm/drm_exec.h
> > +++ b/include/drm/drm_exec.h
> > @@ -135,7 +135,7 @@ static inline bool drm_exec_is_contended(struct drm=
_exec *exec)
> >       return !!exec->contended;
> >   }
> >
> > -void drm_exec_init(struct drm_exec *exec, uint32_t flags);
> > +void drm_exec_init(struct drm_exec *exec, uint32_t flags, unsigned nr)=
;
> >   void drm_exec_fini(struct drm_exec *exec);
> >   bool drm_exec_cleanup(struct drm_exec *exec);
> >   int drm_exec_lock_obj(struct drm_exec *exec, struct drm_gem_object *o=
bj);
>
