Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27B37ACD4A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 02:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjIYAnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 20:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjIYAno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 20:43:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA3EC4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 17:43:37 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c93638322so1244462366b.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 17:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695602615; x=1696207415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=voLpRV9BzDd7KFcn1zScjesjTJxbnSzvVJd4Ts99MQs=;
        b=DU7J4xEtejKT3+eccbzoLKRBeIgw4WhPOJ53C6ChPzDiMYxaVqPNUJAlNaFITLDb2D
         HcUraecTqOKKpXWCW5JRpuZHvkxXOzls9ttjhYBrkoG38LhOINXvmsalz9rMTMJHa8A+
         A1AF2p0tGsHumxHkf5AuB4wuPj4DovWz0RUNwTBBkq+RzaN7ulmQfJMQ2McgfIkEZ3nt
         uKM8cDgHLmoLxKtcwpU/4n5Bt0Un8t3tZI7sMA3L/rftWGQlD4IGx6dG4KFDpRz8pyJw
         ckMrQM4c2s6UdnorotwMcvfVT1h4uospDdoesfw0E/8nnE4djchDCRZxVORUzkYsUvX0
         Up3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695602615; x=1696207415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=voLpRV9BzDd7KFcn1zScjesjTJxbnSzvVJd4Ts99MQs=;
        b=XBX5iaHR58t0Rl/+QxgIBfnu0XKUmwgMOhaktsv43XUjAm5aLsN/HAYNA9+HyA3ZSA
         +NFf6bjFhtISW+8/WXAtDiXKSzZ6t7V5MdomuTq01uHUMhS+foc2Xhd4dZ6Ez8zZqww6
         b7MXI8jK4iMTX6wTDmNg+1VBCmHvEZDltfk38AUX+XNYLNVlvhH/E50oM7WctWE+CGVA
         GHq46LXB2xxesqUTqEmKX6Qeqyrt1QYe0vJmnaJXx3yzCib+RC5UNAYn4pebtlBuu4M1
         7qFGptSXYxevydf1MYtZpxc0pC9zO5KO5HtReq42LRfvGZzBtZmH80Py8neWYSn2fHYi
         SvWg==
X-Gm-Message-State: AOJu0YxjJke4IRAUzRh0o6eLUWDw6O3+WPcd8W/v6uteW5brDOm3HHTG
        55d3IMZLr7bpJ1/8Iua87uwgCFpHRmgqsebsq00=
X-Google-Smtp-Source: AGHT+IEaESKn3LhZPlfSbobeZNZQTAicxTBJOIIaFkSdoe4C6shOEgEdtRfmXOhL86rO6SVgWD2YYaBjDP2lHVuToCo=
X-Received: by 2002:a17:906:ca08:b0:9a5:aa43:1c7c with SMTP id
 jt8-20020a170906ca0800b009a5aa431c7cmr8856060ejb.26.1695602615372; Sun, 24
 Sep 2023 17:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230920144343.64830-1-dakr@redhat.com> <20230920144343.64830-4-dakr@redhat.com>
In-Reply-To: <20230920144343.64830-4-dakr@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 25 Sep 2023 10:43:23 +1000
Message-ID: <CAPM=9txPkeaTb3sRMqdmDDKmMgaL4eNvSZ64tkfDDTr-ULjVmw@mail.gmail.com>
Subject: Re: [PATCH drm-misc-next v4 3/8] drm/nouveau: uvmm: rename 'umgr' to 'base'
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sept 2023 at 00:44, Danilo Krummrich <dakr@redhat.com> wrote:
>
> Rename struct drm_gpuvm within struct nouveau_uvmm from 'umgr' to base.
>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

Reviewed-by: Dave Airlie <airlied@redhat.com>


> ---
>  drivers/gpu/drm/nouveau/nouveau_debugfs.c |  2 +-
>  drivers/gpu/drm/nouveau/nouveau_exec.c    |  4 +--
>  drivers/gpu/drm/nouveau/nouveau_uvmm.c    | 32 +++++++++++------------
>  drivers/gpu/drm/nouveau/nouveau_uvmm.h    |  6 ++---
>  4 files changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> index 053f703f2f68..e83db051e851 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> @@ -231,7 +231,7 @@ nouveau_debugfs_gpuva(struct seq_file *m, void *data)
>                         continue;
>
>                 nouveau_uvmm_lock(uvmm);
> -               drm_debugfs_gpuva_info(m, &uvmm->umgr);
> +               drm_debugfs_gpuva_info(m, &uvmm->base);
>                 seq_puts(m, "\n");
>                 nouveau_debugfs_gpuva_regions(m, uvmm);
>                 nouveau_uvmm_unlock(uvmm);
> diff --git a/drivers/gpu/drm/nouveau/nouveau_exec.c b/drivers/gpu/drm/nouveau/nouveau_exec.c
> index c001952cd678..b4239af29e5a 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_exec.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_exec.c
> @@ -106,8 +106,8 @@ nouveau_exec_job_submit(struct nouveau_job *job)
>         drm_exec_until_all_locked(exec) {
>                 struct drm_gpuva *va;
>
> -               drm_gpuvm_for_each_va(va, &uvmm->umgr) {
> -                       if (unlikely(va == &uvmm->umgr.kernel_alloc_node))
> +               drm_gpuvm_for_each_va(va, &uvmm->base) {
> +                       if (unlikely(va == &uvmm->base.kernel_alloc_node))
>                                 continue;
>
>                         ret = drm_exec_prepare_obj(exec, va->gem.obj, 1);
> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> index c750072cb268..6c86b64273c3 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> @@ -329,7 +329,7 @@ nouveau_uvma_region_create(struct nouveau_uvmm *uvmm,
>         struct nouveau_uvma_region *reg;
>         int ret;
>
> -       if (!drm_gpuva_interval_empty(&uvmm->umgr, addr, range))
> +       if (!drm_gpuva_interval_empty(&uvmm->base, addr, range))
>                 return -ENOSPC;
>
>         ret = nouveau_uvma_region_alloc(&reg);
> @@ -384,7 +384,7 @@ nouveau_uvma_region_empty(struct nouveau_uvma_region *reg)
>  {
>         struct nouveau_uvmm *uvmm = reg->uvmm;
>
> -       return drm_gpuva_interval_empty(&uvmm->umgr,
> +       return drm_gpuva_interval_empty(&uvmm->base,
>                                         reg->va.addr,
>                                         reg->va.range);
>  }
> @@ -589,7 +589,7 @@ op_map_prepare(struct nouveau_uvmm *uvmm,
>         uvma->region = args->region;
>         uvma->kind = args->kind;
>
> -       drm_gpuva_map(&uvmm->umgr, &uvma->va, op);
> +       drm_gpuva_map(&uvmm->base, &uvma->va, op);
>
>         /* Keep a reference until this uvma is destroyed. */
>         nouveau_uvma_gem_get(uvma);
> @@ -1194,7 +1194,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
>                                 goto unwind_continue;
>                         }
>
> -                       op->ops = drm_gpuvm_sm_unmap_ops_create(&uvmm->umgr,
> +                       op->ops = drm_gpuvm_sm_unmap_ops_create(&uvmm->base,
>                                                                 op->va.addr,
>                                                                 op->va.range);
>                         if (IS_ERR(op->ops)) {
> @@ -1205,7 +1205,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
>                         ret = nouveau_uvmm_sm_unmap_prepare(uvmm, &op->new,
>                                                             op->ops);
>                         if (ret) {
> -                               drm_gpuva_ops_free(&uvmm->umgr, op->ops);
> +                               drm_gpuva_ops_free(&uvmm->base, op->ops);
>                                 op->ops = NULL;
>                                 op->reg = NULL;
>                                 goto unwind_continue;
> @@ -1240,7 +1240,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
>                                 }
>                         }
>
> -                       op->ops = drm_gpuvm_sm_map_ops_create(&uvmm->umgr,
> +                       op->ops = drm_gpuvm_sm_map_ops_create(&uvmm->base,
>                                                               op->va.addr,
>                                                               op->va.range,
>                                                               op->gem.obj,
> @@ -1256,7 +1256,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
>                                                           op->va.range,
>                                                           op->flags & 0xff);
>                         if (ret) {
> -                               drm_gpuva_ops_free(&uvmm->umgr, op->ops);
> +                               drm_gpuva_ops_free(&uvmm->base, op->ops);
>                                 op->ops = NULL;
>                                 goto unwind_continue;
>                         }
> @@ -1264,7 +1264,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
>                         break;
>                 }
>                 case OP_UNMAP:
> -                       op->ops = drm_gpuvm_sm_unmap_ops_create(&uvmm->umgr,
> +                       op->ops = drm_gpuvm_sm_unmap_ops_create(&uvmm->base,
>                                                                 op->va.addr,
>                                                                 op->va.range);
>                         if (IS_ERR(op->ops)) {
> @@ -1275,7 +1275,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
>                         ret = nouveau_uvmm_sm_unmap_prepare(uvmm, &op->new,
>                                                             op->ops);
>                         if (ret) {
> -                               drm_gpuva_ops_free(&uvmm->umgr, op->ops);
> +                               drm_gpuva_ops_free(&uvmm->base, op->ops);
>                                 op->ops = NULL;
>                                 goto unwind_continue;
>                         }
> @@ -1404,7 +1404,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job)
>                         break;
>                 }
>
> -               drm_gpuva_ops_free(&uvmm->umgr, op->ops);
> +               drm_gpuva_ops_free(&uvmm->base, op->ops);
>                 op->ops = NULL;
>                 op->reg = NULL;
>         }
> @@ -1509,7 +1509,7 @@ nouveau_uvmm_bind_job_free_work_fn(struct work_struct *work)
>                 }
>
>                 if (!IS_ERR_OR_NULL(op->ops))
> -                       drm_gpuva_ops_free(&uvmm->umgr, op->ops);
> +                       drm_gpuva_ops_free(&uvmm->base, op->ops);
>
>                 if (obj)
>                         drm_gem_object_put(obj);
> @@ -1836,7 +1836,7 @@ nouveau_uvmm_init(struct nouveau_uvmm *uvmm, struct nouveau_cli *cli,
>         uvmm->kernel_managed_addr = kernel_managed_addr;
>         uvmm->kernel_managed_size = kernel_managed_size;
>
> -       drm_gpuvm_init(&uvmm->umgr, cli->name,
> +       drm_gpuvm_init(&uvmm->base, cli->name,
>                        NOUVEAU_VA_SPACE_START,
>                        NOUVEAU_VA_SPACE_END,
>                        kernel_managed_addr, kernel_managed_size,
> @@ -1855,7 +1855,7 @@ nouveau_uvmm_init(struct nouveau_uvmm *uvmm, struct nouveau_cli *cli,
>         return 0;
>
>  out_free_gpuva_mgr:
> -       drm_gpuvm_destroy(&uvmm->umgr);
> +       drm_gpuvm_destroy(&uvmm->base);
>  out_unlock:
>         mutex_unlock(&cli->mutex);
>         return ret;
> @@ -1877,11 +1877,11 @@ nouveau_uvmm_fini(struct nouveau_uvmm *uvmm)
>         wait_event(entity->job.wq, list_empty(&entity->job.list.head));
>
>         nouveau_uvmm_lock(uvmm);
> -       drm_gpuvm_for_each_va_safe(va, next, &uvmm->umgr) {
> +       drm_gpuvm_for_each_va_safe(va, next, &uvmm->base) {
>                 struct nouveau_uvma *uvma = uvma_from_va(va);
>                 struct drm_gem_object *obj = va->gem.obj;
>
> -               if (unlikely(va == &uvmm->umgr.kernel_alloc_node))
> +               if (unlikely(va == &uvmm->base.kernel_alloc_node))
>                         continue;
>
>                 drm_gpuva_remove(va);
> @@ -1910,7 +1910,7 @@ nouveau_uvmm_fini(struct nouveau_uvmm *uvmm)
>
>         mutex_lock(&cli->mutex);
>         nouveau_vmm_fini(&uvmm->vmm);
> -       drm_gpuvm_destroy(&uvmm->umgr);
> +       drm_gpuvm_destroy(&uvmm->base);
>         mutex_unlock(&cli->mutex);
>
>         dma_resv_fini(&uvmm->resv);
> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.h b/drivers/gpu/drm/nouveau/nouveau_uvmm.h
> index e96c9919d1bd..a308c59760a5 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.h
> @@ -8,8 +8,8 @@
>  #include "nouveau_drv.h"
>
>  struct nouveau_uvmm {
> +       struct drm_gpuvm base;
>         struct nouveau_vmm vmm;
> -       struct drm_gpuvm umgr;
>         struct maple_tree region_mt;
>         struct mutex mutex;
>         struct dma_resv resv;
> @@ -41,10 +41,10 @@ struct nouveau_uvma {
>         u8 kind;
>  };
>
> -#define uvmm_from_mgr(x) container_of((x), struct nouveau_uvmm, umgr)
> +#define uvmm_from_gpuvm(x) container_of((x), struct nouveau_uvmm, base)
>  #define uvma_from_va(x) container_of((x), struct nouveau_uvma, va)
>
> -#define to_uvmm(x) uvmm_from_mgr((x)->va.vm)
> +#define to_uvmm(x) uvmm_from_gpuvm((x)->va.vm)
>
>  struct nouveau_uvmm_bind_job {
>         struct nouveau_job base;
> --
> 2.41.0
>
