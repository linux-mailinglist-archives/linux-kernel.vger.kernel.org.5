Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AAF7E8265
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbjKJTUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346162AbjKJTUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:20:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A0B2FEC7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 03:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699615739; x=1731151739;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eSe2sHY/T+OevWi8DcHwyZ79/IlfPEVAQ/f1I+RRSus=;
  b=DnaBasBzq7ECMxWzNK0fLwcQsi55LAlDI6xlwDct8acVeWCMugzUDSiW
   OzDkmIhrtOq4/RhZ2HG5FohwnlUxKE/jN+41yQIzy38rxozjT5N9+P9zW
   BifW0x+8hQjGWkkqbjLzKBFByOOLMXRaPJMeqQxD2zgg627mekqTi9Or2
   krp+HBXi09HwlWIZevQulWz9tJSCU/20TtjDWWObK+kIUsLSSV9olW1At
   qZtCjBZgHHX1QZoQxJT2EYtbT1i1eUvWXn+JVr8wYT3A1pO526EDZ8Z2Z
   9ku85zvHQzZtvJ47Jesqo4IGjcB14zfbt6qq7MpbqAKv+Sp/WvycXxWLP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="456670360"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="456670360"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 03:28:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="907450637"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="907450637"
Received: from gpruna-mobl4.ger.corp.intel.com (HELO [10.213.236.135]) ([10.213.236.135])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 03:28:55 -0800
Message-ID: <2be07d6d-6ffe-4496-b642-3278ef28f169@linux.intel.com>
Date:   Fri, 10 Nov 2023 11:28:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Remove custom dumb_map_offset implementations in i915
 driver
Content-Language: en-US
To:     Dipam Turkar <dipamt1729@gmail.com>, jani.nikula@linux.intel.com
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@gmail.com
References: <20231110105811.380646-1-dipamt1729@gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20231110105811.380646-1-dipamt1729@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/11/2023 10:58, Dipam Turkar wrote:
> Making i915 use drm_gem_create_mmap_offset() instead of its custom
> implementations for associating GEM object with a fake offset.

Does it compile?

Regards,

Tvrtko

> Signed-off-by: Dipam Turkar <dipamt1729@gmail.com>
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_mman.c | 192 -----------------------
>   drivers/gpu/drm/i915/gem/i915_gem_mman.h |   4 -
>   drivers/gpu/drm/i915/i915_driver.c       |   3 +-
>   3 files changed, 2 insertions(+), 197 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
> index aa4d842d4c5a..6b73fe509270 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
> @@ -600,198 +600,6 @@ void i915_gem_object_release_mmap_offset(struct drm_i915_gem_object *obj)
>   	spin_unlock(&obj->mmo.lock);
>   }
>   
> -static struct i915_mmap_offset *
> -lookup_mmo(struct drm_i915_gem_object *obj,
> -	   enum i915_mmap_type mmap_type)
> -{
> -	struct rb_node *rb;
> -
> -	spin_lock(&obj->mmo.lock);
> -	rb = obj->mmo.offsets.rb_node;
> -	while (rb) {
> -		struct i915_mmap_offset *mmo =
> -			rb_entry(rb, typeof(*mmo), offset);
> -
> -		if (mmo->mmap_type == mmap_type) {
> -			spin_unlock(&obj->mmo.lock);
> -			return mmo;
> -		}
> -
> -		if (mmo->mmap_type < mmap_type)
> -			rb = rb->rb_right;
> -		else
> -			rb = rb->rb_left;
> -	}
> -	spin_unlock(&obj->mmo.lock);
> -
> -	return NULL;
> -}
> -
> -static struct i915_mmap_offset *
> -insert_mmo(struct drm_i915_gem_object *obj, struct i915_mmap_offset *mmo)
> -{
> -	struct rb_node *rb, **p;
> -
> -	spin_lock(&obj->mmo.lock);
> -	rb = NULL;
> -	p = &obj->mmo.offsets.rb_node;
> -	while (*p) {
> -		struct i915_mmap_offset *pos;
> -
> -		rb = *p;
> -		pos = rb_entry(rb, typeof(*pos), offset);
> -
> -		if (pos->mmap_type == mmo->mmap_type) {
> -			spin_unlock(&obj->mmo.lock);
> -			drm_vma_offset_remove(obj->base.dev->vma_offset_manager,
> -					      &mmo->vma_node);
> -			kfree(mmo);
> -			return pos;
> -		}
> -
> -		if (pos->mmap_type < mmo->mmap_type)
> -			p = &rb->rb_right;
> -		else
> -			p = &rb->rb_left;
> -	}
> -	rb_link_node(&mmo->offset, rb, p);
> -	rb_insert_color(&mmo->offset, &obj->mmo.offsets);
> -	spin_unlock(&obj->mmo.lock);
> -
> -	return mmo;
> -}
> -
> -static struct i915_mmap_offset *
> -mmap_offset_attach(struct drm_i915_gem_object *obj,
> -		   enum i915_mmap_type mmap_type,
> -		   struct drm_file *file)
> -{
> -	struct drm_i915_private *i915 = to_i915(obj->base.dev);
> -	struct i915_mmap_offset *mmo;
> -	int err;
> -
> -	GEM_BUG_ON(obj->ops->mmap_offset || obj->ops->mmap_ops);
> -
> -	mmo = lookup_mmo(obj, mmap_type);
> -	if (mmo)
> -		goto out;
> -
> -	mmo = kmalloc(sizeof(*mmo), GFP_KERNEL);
> -	if (!mmo)
> -		return ERR_PTR(-ENOMEM);
> -
> -	mmo->obj = obj;
> -	mmo->mmap_type = mmap_type;
> -	drm_vma_node_reset(&mmo->vma_node);
> -
> -	err = drm_vma_offset_add(obj->base.dev->vma_offset_manager,
> -				 &mmo->vma_node, obj->base.size / PAGE_SIZE);
> -	if (likely(!err))
> -		goto insert;
> -
> -	/* Attempt to reap some mmap space from dead objects */
> -	err = intel_gt_retire_requests_timeout(to_gt(i915), MAX_SCHEDULE_TIMEOUT,
> -					       NULL);
> -	if (err)
> -		goto err;
> -
> -	i915_gem_drain_freed_objects(i915);
> -	err = drm_vma_offset_add(obj->base.dev->vma_offset_manager,
> -				 &mmo->vma_node, obj->base.size / PAGE_SIZE);
> -	if (err)
> -		goto err;
> -
> -insert:
> -	mmo = insert_mmo(obj, mmo);
> -	GEM_BUG_ON(lookup_mmo(obj, mmap_type) != mmo);
> -out:
> -	if (file)
> -		drm_vma_node_allow_once(&mmo->vma_node, file);
> -	return mmo;
> -
> -err:
> -	kfree(mmo);
> -	return ERR_PTR(err);
> -}
> -
> -static int
> -__assign_mmap_offset(struct drm_i915_gem_object *obj,
> -		     enum i915_mmap_type mmap_type,
> -		     u64 *offset, struct drm_file *file)
> -{
> -	struct i915_mmap_offset *mmo;
> -
> -	if (i915_gem_object_never_mmap(obj))
> -		return -ENODEV;
> -
> -	if (obj->ops->mmap_offset)  {
> -		if (mmap_type != I915_MMAP_TYPE_FIXED)
> -			return -ENODEV;
> -
> -		*offset = obj->ops->mmap_offset(obj);
> -		return 0;
> -	}
> -
> -	if (mmap_type == I915_MMAP_TYPE_FIXED)
> -		return -ENODEV;
> -
> -	if (mmap_type != I915_MMAP_TYPE_GTT &&
> -	    !i915_gem_object_has_struct_page(obj) &&
> -	    !i915_gem_object_has_iomem(obj))
> -		return -ENODEV;
> -
> -	mmo = mmap_offset_attach(obj, mmap_type, file);
> -	if (IS_ERR(mmo))
> -		return PTR_ERR(mmo);
> -
> -	*offset = drm_vma_node_offset_addr(&mmo->vma_node);
> -	return 0;
> -}
> -
> -static int
> -__assign_mmap_offset_handle(struct drm_file *file,
> -			    u32 handle,
> -			    enum i915_mmap_type mmap_type,
> -			    u64 *offset)
> -{
> -	struct drm_i915_gem_object *obj;
> -	int err;
> -
> -	obj = i915_gem_object_lookup(file, handle);
> -	if (!obj)
> -		return -ENOENT;
> -
> -	err = i915_gem_object_lock_interruptible(obj, NULL);
> -	if (err)
> -		goto out_put;
> -	err = __assign_mmap_offset(obj, mmap_type, offset, file);
> -	i915_gem_object_unlock(obj);
> -out_put:
> -	i915_gem_object_put(obj);
> -	return err;
> -}
> -
> -int
> -i915_gem_dumb_mmap_offset(struct drm_file *file,
> -			  struct drm_device *dev,
> -			  u32 handle,
> -			  u64 *offset)
> -{
> -	struct drm_i915_private *i915 = to_i915(dev);
> -	enum i915_mmap_type mmap_type;
> -
> -	if (HAS_LMEM(to_i915(dev)))
> -		mmap_type = I915_MMAP_TYPE_FIXED;
> -	else if (pat_enabled())
> -		mmap_type = I915_MMAP_TYPE_WC;
> -	else if (!i915_ggtt_has_aperture(to_gt(i915)->ggtt))
> -		return -ENODEV;
> -	else
> -		mmap_type = I915_MMAP_TYPE_GTT;
> -
> -	return __assign_mmap_offset_handle(file, handle, mmap_type, offset);
> -}
> -
>   /**
>    * i915_gem_mmap_offset_ioctl - prepare an object for GTT mmap'ing
>    * @dev: DRM device
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.h b/drivers/gpu/drm/i915/gem/i915_gem_mman.h
> index 196417fd0f5c..253435795caf 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_mman.h
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.h
> @@ -20,10 +20,6 @@ struct mutex;
>   int i915_gem_mmap_gtt_version(void);
>   int i915_gem_mmap(struct file *filp, struct vm_area_struct *vma);
>   
> -int i915_gem_dumb_mmap_offset(struct drm_file *file_priv,
> -			      struct drm_device *dev,
> -			      u32 handle, u64 *offset);
> -
>   void __i915_gem_object_release_mmap_gtt(struct drm_i915_gem_object *obj);
>   void i915_gem_object_release_mmap_gtt(struct drm_i915_gem_object *obj);
>   
> diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
> index d50347e5773a..a18a33896ba4 100644
> --- a/drivers/gpu/drm/i915/i915_driver.c
> +++ b/drivers/gpu/drm/i915/i915_driver.c
> @@ -42,6 +42,7 @@
>   #include <drm/drm_aperture.h>
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_ioctl.h>
> +#include <drm/drm_gem.h>
>   #include <drm/drm_managed.h>
>   #include <drm/drm_probe_helper.h>
>   
> @@ -1826,7 +1827,7 @@ static const struct drm_driver i915_drm_driver = {
>   	.gem_prime_import = i915_gem_prime_import,
>   
>   	.dumb_create = i915_gem_dumb_create,
> -	.dumb_map_offset = i915_gem_dumb_mmap_offset,
> +	.dumb_map_offset = drm_gem_dumb_mmap_offset,
>   
>   	.ioctls = i915_ioctls,
>   	.num_ioctls = ARRAY_SIZE(i915_ioctls),
