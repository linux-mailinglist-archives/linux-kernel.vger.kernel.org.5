Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8417976E34F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjHCIjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbjHCIj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:39:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC9A422A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:38:03 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98273ae42d0so21205366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 01:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1691051881; x=1691656681;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLeBA2gvCKSwrQ2IvmVGA7dsAuidJbK+oOtl2KRNGpE=;
        b=dkoz6pqa4E8bxR4RkItrXILd3Y/VJzIvTG++n03jk/d8c59UylipU/Ba3IwteUXleg
         DnpklusI8Og2PfgPLyG6IY//WsWP/Fl3CKJ8K91058WfHk5snuYIzZLwBjcT1MPiQ5gs
         GQi6UsHsMfrjgwhiHG7GBTtxJRlCmOAfdTMGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691051881; x=1691656681;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLeBA2gvCKSwrQ2IvmVGA7dsAuidJbK+oOtl2KRNGpE=;
        b=Lym12kRHFr2NfbD5HiNrso9lJ2tqANIoQt4wglyQYwNw9HX1voNGI3CcZN2nqBsyeD
         mK+59N8oJeWalZrhDiMZl1QYZ4Hnsip9HEzxJF/16CJidQdfKbNprA/fzGjVkksNfEv0
         aodNOzu8p/dOfI+bjZlJxSodOCKK4NfGTdx2DIj5+tr7ixQkma7FUU014C03pCJ4PwLe
         gXp0IUVkiWR3RxnMY0O6Ck2G15JXT9ju4sENh1czwI89aIX/rVJZfPqB71eRf5vINf0N
         /BoVXRNL2C6mnYVqRKC1N5+f20l+JmTqccJcgx5Lp3Ia/2Y9T7wi48yW5hDLNE5Ok4YR
         H3YQ==
X-Gm-Message-State: ABy/qLbmXbrZvv+zPFyGZ2AMvCqXE0ugOJvt56yBxSuBdMkxA01IKm84
        8ciYvbF7OYAogF1COkf6tgITmw==
X-Google-Smtp-Source: APBJJlEPTLJ8mnYKZG5mALpz1XgrinUrw5SQRSvDFIWcwmGgjU0tebOBnTwaHBT9+oxIBjM2QZQkWA==
X-Received: by 2002:a17:906:112:b0:99b:c845:7917 with SMTP id 18-20020a170906011200b0099bc8457917mr13076136eje.4.1691051881488;
        Thu, 03 Aug 2023 01:38:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y9-20020a170906470900b0099bc8db97bcsm10143956ejq.131.2023.08.03.01.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 01:38:00 -0700 (PDT)
Date:   Thu, 3 Aug 2023 10:37:58 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] drm/msm: Remove vma use tracking
Message-ID: <ZMtnZgpv4TQtYybA@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230802222158.11838-1-robdclark@gmail.com>
 <20230802222158.11838-5-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802222158.11838-5-robdclark@gmail.com>
X-Operating-System: Linux phenom 6.3.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 03:21:52PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> This was not strictly necessary, as page unpinning (ie. shrinker) only
> cares about the resv.  It did give us some extra sanity checking for
> userspace controlled iova, and was useful to catch issues on kernel and
> userspace side when enabling userspace iova.  But if userspace screws
> this up, it just corrupts it's own gpu buffers and/or gets iova faults.
> So we can just let userspace shoot it's own foot and drop the extra per-
> buffer SUBMIT overhead.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>

I did check a few things (like that the gem lru helpers have all the
needed lockdep_assert_held) and I think aside from the optimization this
is a nice semantic cleanup. Since iirc we've had a locking inversion
discussion and the vma tracking here came up as a culprit. On the series:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/msm/msm_gem.c        |  9 +---
>  drivers/gpu/drm/msm/msm_gem.h        | 12 +----
>  drivers/gpu/drm/msm/msm_gem_submit.c | 14 ++----
>  drivers/gpu/drm/msm/msm_gem_vma.c    | 67 +---------------------------
>  drivers/gpu/drm/msm/msm_ringbuffer.c |  3 +-
>  5 files changed, 9 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 1c81ff6115ac..ce1ed0f9ad2d 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -607,9 +607,6 @@ static int clear_iova(struct drm_gem_object *obj,
>  	if (!vma)
>  		return 0;
>  
> -	if (msm_gem_vma_inuse(vma))
> -		return -EBUSY;
> -
>  	msm_gem_vma_purge(vma);
>  	msm_gem_vma_close(vma);
>  	del_vma(vma);
> @@ -660,7 +657,6 @@ void msm_gem_unpin_iova(struct drm_gem_object *obj,
>  	msm_gem_lock(obj);
>  	vma = lookup_vma(obj, aspace);
>  	if (!GEM_WARN_ON(!vma)) {
> -		msm_gem_vma_unpin(vma);
>  		msm_gem_unpin_locked(obj);
>  	}
>  	msm_gem_unlock(obj);
> @@ -991,11 +987,10 @@ void msm_gem_describe(struct drm_gem_object *obj, struct seq_file *m,
>  			} else {
>  				name = comm = NULL;
>  			}
> -			seq_printf(m, " [%s%s%s: aspace=%p, %08llx,%s,inuse=%d]",
> +			seq_printf(m, " [%s%s%s: aspace=%p, %08llx,%s]",
>  				name, comm ? ":" : "", comm ? comm : "",
>  				vma->aspace, vma->iova,
> -				vma->mapped ? "mapped" : "unmapped",
> -				msm_gem_vma_inuse(vma));
> +				vma->mapped ? "mapped" : "unmapped");
>  			kfree(comm);
>  		}
>  
> diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
> index 2ddd896aac68..8ddef5443140 100644
> --- a/drivers/gpu/drm/msm/msm_gem.h
> +++ b/drivers/gpu/drm/msm/msm_gem.h
> @@ -59,24 +59,16 @@ struct msm_fence_context;
>  
>  struct msm_gem_vma {
>  	struct drm_mm_node node;
> -	spinlock_t lock;
>  	uint64_t iova;
>  	struct msm_gem_address_space *aspace;
>  	struct list_head list;    /* node in msm_gem_object::vmas */
>  	bool mapped;
> -	int inuse;
> -	uint32_t fence_mask;
> -	uint32_t fence[MSM_GPU_MAX_RINGS];
> -	struct msm_fence_context *fctx[MSM_GPU_MAX_RINGS];
>  };
>  
>  struct msm_gem_vma *msm_gem_vma_new(struct msm_gem_address_space *aspace);
>  int msm_gem_vma_init(struct msm_gem_vma *vma, int size,
>  		u64 range_start, u64 range_end);
> -bool msm_gem_vma_inuse(struct msm_gem_vma *vma);
>  void msm_gem_vma_purge(struct msm_gem_vma *vma);
> -void msm_gem_vma_unpin(struct msm_gem_vma *vma);
> -void msm_gem_vma_unpin_fenced(struct msm_gem_vma *vma, struct msm_fence_context *fctx);
>  int msm_gem_vma_map(struct msm_gem_vma *vma, int prot, struct sg_table *sgt, int size);
>  void msm_gem_vma_close(struct msm_gem_vma *vma);
>  
> @@ -298,15 +290,13 @@ struct msm_gem_submit {
>  /* make sure these don't conflict w/ MSM_SUBMIT_BO_x */
>  #define BO_VALID	0x8000	/* is current addr in cmdstream correct/valid? */
>  #define BO_LOCKED	0x4000	/* obj lock is held */
> -#define BO_OBJ_PINNED	0x2000	/* obj (pages) is pinned and on active list */
> -#define BO_VMA_PINNED	0x1000	/* vma (virtual address) is pinned */
> +#define BO_PINNED	0x2000	/* obj (pages) is pinned and on active list */
>  		uint32_t flags;
>  		union {
>  			struct drm_gem_object *obj;
>  			uint32_t handle;
>  		};
>  		uint64_t iova;
> -		struct msm_gem_vma *vma;
>  	} bos[];
>  };
>  
> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
> index b17561ebd518..5f90cc8e7b7f 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -261,10 +261,7 @@ static void submit_cleanup_bo(struct msm_gem_submit *submit, int i,
>  	 */
>  	submit->bos[i].flags &= ~cleanup_flags;
>  
> -	if (flags & BO_VMA_PINNED)
> -		msm_gem_vma_unpin(submit->bos[i].vma);
> -
> -	if (flags & BO_OBJ_PINNED)
> +	if (flags & BO_PINNED)
>  		msm_gem_unpin_locked(obj);
>  
>  	if (flags & BO_LOCKED)
> @@ -273,7 +270,7 @@ static void submit_cleanup_bo(struct msm_gem_submit *submit, int i,
>  
>  static void submit_unlock_unpin_bo(struct msm_gem_submit *submit, int i)
>  {
> -	unsigned cleanup_flags = BO_VMA_PINNED | BO_OBJ_PINNED | BO_LOCKED;
> +	unsigned cleanup_flags = BO_PINNED | BO_LOCKED;
>  	submit_cleanup_bo(submit, i, cleanup_flags);
>  
>  	if (!(submit->bos[i].flags & BO_VALID))
> @@ -404,9 +401,6 @@ static int submit_pin_objects(struct msm_gem_submit *submit)
>  		if (ret)
>  			break;
>  
> -		submit->bos[i].flags |= BO_VMA_PINNED;
> -		submit->bos[i].vma = vma;
> -
>  		if (vma->iova == submit->bos[i].iova) {
>  			submit->bos[i].flags |= BO_VALID;
>  		} else {
> @@ -420,7 +414,7 @@ static int submit_pin_objects(struct msm_gem_submit *submit)
>  	mutex_lock(&priv->lru.lock);
>  	for (i = 0; i < submit->nr_bos; i++) {
>  		msm_gem_pin_obj_locked(submit->bos[i].obj);
> -		submit->bos[i].flags |= BO_OBJ_PINNED;
> +		submit->bos[i].flags |= BO_PINNED;
>  	}
>  	mutex_unlock(&priv->lru.lock);
>  
> @@ -547,7 +541,7 @@ static void submit_cleanup(struct msm_gem_submit *submit, bool error)
>  	unsigned i;
>  
>  	if (error)
> -		cleanup_flags |= BO_VMA_PINNED | BO_OBJ_PINNED;
> +		cleanup_flags |= BO_PINNED;
>  
>  	for (i = 0; i < submit->nr_bos; i++) {
>  		struct drm_gem_object *obj = submit->bos[i].obj;
> diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
> index 98287ed99960..11e842dda73c 100644
> --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> @@ -38,41 +38,12 @@ msm_gem_address_space_get(struct msm_gem_address_space *aspace)
>  	return aspace;
>  }
>  
> -bool msm_gem_vma_inuse(struct msm_gem_vma *vma)
> -{
> -	bool ret = true;
> -
> -	spin_lock(&vma->lock);
> -
> -	if (vma->inuse > 0)
> -		goto out;
> -
> -	while (vma->fence_mask) {
> -		unsigned idx = ffs(vma->fence_mask) - 1;
> -
> -		if (!msm_fence_completed(vma->fctx[idx], vma->fence[idx]))
> -			goto out;
> -
> -		vma->fence_mask &= ~BIT(idx);
> -	}
> -
> -	ret = false;
> -
> -out:
> -	spin_unlock(&vma->lock);
> -
> -	return ret;
> -}
> -
>  /* Actually unmap memory for the vma */
>  void msm_gem_vma_purge(struct msm_gem_vma *vma)
>  {
>  	struct msm_gem_address_space *aspace = vma->aspace;
>  	unsigned size = vma->node.size;
>  
> -	/* Print a message if we try to purge a vma in use */
> -	GEM_WARN_ON(msm_gem_vma_inuse(vma));
> -
>  	/* Don't do anything if the memory isn't mapped */
>  	if (!vma->mapped)
>  		return;
> @@ -82,33 +53,6 @@ void msm_gem_vma_purge(struct msm_gem_vma *vma)
>  	vma->mapped = false;
>  }
>  
> -static void vma_unpin_locked(struct msm_gem_vma *vma)
> -{
> -	if (GEM_WARN_ON(!vma->inuse))
> -		return;
> -	if (!GEM_WARN_ON(!vma->iova))
> -		vma->inuse--;
> -}
> -
> -/* Remove reference counts for the mapping */
> -void msm_gem_vma_unpin(struct msm_gem_vma *vma)
> -{
> -	spin_lock(&vma->lock);
> -	vma_unpin_locked(vma);
> -	spin_unlock(&vma->lock);
> -}
> -
> -/* Replace pin reference with fence: */
> -void msm_gem_vma_unpin_fenced(struct msm_gem_vma *vma, struct msm_fence_context *fctx)
> -{
> -	spin_lock(&vma->lock);
> -	vma->fctx[fctx->index] = fctx;
> -	vma->fence[fctx->index] = fctx->last_fence;
> -	vma->fence_mask |= BIT(fctx->index);
> -	vma_unpin_locked(vma);
> -	spin_unlock(&vma->lock);
> -}
> -
>  /* Map and pin vma: */
>  int
>  msm_gem_vma_map(struct msm_gem_vma *vma, int prot,
> @@ -120,11 +64,6 @@ msm_gem_vma_map(struct msm_gem_vma *vma, int prot,
>  	if (GEM_WARN_ON(!vma->iova))
>  		return -EINVAL;
>  
> -	/* Increase the usage counter */
> -	spin_lock(&vma->lock);
> -	vma->inuse++;
> -	spin_unlock(&vma->lock);
> -
>  	if (vma->mapped)
>  		return 0;
>  
> @@ -146,9 +85,6 @@ msm_gem_vma_map(struct msm_gem_vma *vma, int prot,
>  
>  	if (ret) {
>  		vma->mapped = false;
> -		spin_lock(&vma->lock);
> -		vma->inuse--;
> -		spin_unlock(&vma->lock);
>  	}
>  
>  	return ret;
> @@ -159,7 +95,7 @@ void msm_gem_vma_close(struct msm_gem_vma *vma)
>  {
>  	struct msm_gem_address_space *aspace = vma->aspace;
>  
> -	GEM_WARN_ON(msm_gem_vma_inuse(vma) || vma->mapped);
> +	GEM_WARN_ON(vma->mapped);
>  
>  	spin_lock(&aspace->lock);
>  	if (vma->iova)
> @@ -179,7 +115,6 @@ struct msm_gem_vma *msm_gem_vma_new(struct msm_gem_address_space *aspace)
>  	if (!vma)
>  		return NULL;
>  
> -	spin_lock_init(&vma->lock);
>  	vma->aspace = aspace;
>  
>  	return vma;
> diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/msm_ringbuffer.c
> index 6fa427d2992e..7f5e0a961bba 100644
> --- a/drivers/gpu/drm/msm/msm_ringbuffer.c
> +++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
> @@ -26,9 +26,8 @@ static struct dma_fence *msm_job_run(struct drm_sched_job *job)
>  	for (i = 0; i < submit->nr_bos; i++) {
>  		struct drm_gem_object *obj = submit->bos[i].obj;
>  
> -		msm_gem_vma_unpin_fenced(submit->bos[i].vma, fctx);
>  		msm_gem_unpin_active(obj);
> -		submit->bos[i].flags &= ~(BO_VMA_PINNED | BO_OBJ_PINNED);
> +		submit->bos[i].flags &= ~BO_PINNED;
>  	}
>  
>  	mutex_unlock(&priv->lru.lock);
> -- 
> 2.41.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
