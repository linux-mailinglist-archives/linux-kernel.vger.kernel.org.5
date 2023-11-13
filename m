Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FFD7EA26E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjKMRxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMRxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:53:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67292DB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 09:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699897988; x=1731433988;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=udS9SfzTwwnCam3BM7zqV5qU6ZGdKL8Y0UdUz8KpRV8=;
  b=fIBMRLnKnGsk4oJ5/OGJzZEU7ncj+hI4olfsOpNUdkl0CooCYn3beR6p
   VaH5NxokhSfyRRF9XDpPiyPn4yEJkL0y0/zZRgZnIVyJRipNU7dqC1QTs
   nlQvElYu2MkqGbvRYE93fU2Xavy6Xap4E+v0iF1wxkabyd9TCvOAi9dSz
   V1ZFC1oJNj0c1pCmrgMUMOoXFmn9Wnpy1nJ/I67Dg4cdlGLPYtW9rnb/V
   7S1GP7aWRuovkoOeA2J7YeDhSvmAYJmGuYNf8G2YMfRhn9jQPmkTqvz6c
   UDrkBGejeDLfPxr/cCzKYVZSj1zMiFcN4+CRr+L6Ru8IdY6wyIWG7wsbM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="9122381"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="9122381"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 09:53:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="855030752"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="855030752"
Received: from cgheban-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.92])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 09:53:03 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Dipam Turkar <dipamt1729@gmail.com>
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, airlied@gmail.com, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Dipam Turkar <dipamt1729@gmail.com>
Subject: Re: [PATCH v2] Remove custom dumb_map_offset implementations in
 i915 driver
In-Reply-To: <20231110184126.712310-1-dipamt1729@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231110184126.712310-1-dipamt1729@gmail.com>
Date:   Mon, 13 Nov 2023 19:53:01 +0200
Message-ID: <875y25tu9u.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2023, Dipam Turkar <dipamt1729@gmail.com> wrote:
> Making i915 use drm_gem_create_mmap_offset() instead of its custom
> implementations for associating GEM object with a fake offset.

It would probably help a lot if your commit messages explained what you
are trying to achieve and, especially, why. This only describes the
patch in English.

BR,
Jani.

>
> Signed-off-by: Dipam Turkar <dipamt1729@gmail.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_mman.c | 21 ---------------------
>  drivers/gpu/drm/i915/gem/i915_gem_mman.h |  4 ----
>  drivers/gpu/drm/i915/i915_driver.c       |  3 ++-
>  3 files changed, 2 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
> index aa4d842d4c5a..71d621a1f249 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
> @@ -771,27 +771,6 @@ __assign_mmap_offset_handle(struct drm_file *file,
>  	return err;
>  }
>  
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
>  /**
>   * i915_gem_mmap_offset_ioctl - prepare an object for GTT mmap'ing
>   * @dev: DRM device
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.h b/drivers/gpu/drm/i915/gem/i915_gem_mman.h
> index 196417fd0f5c..253435795caf 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_mman.h
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.h
> @@ -20,10 +20,6 @@ struct mutex;
>  int i915_gem_mmap_gtt_version(void);
>  int i915_gem_mmap(struct file *filp, struct vm_area_struct *vma);
>  
> -int i915_gem_dumb_mmap_offset(struct drm_file *file_priv,
> -			      struct drm_device *dev,
> -			      u32 handle, u64 *offset);
> -
>  void __i915_gem_object_release_mmap_gtt(struct drm_i915_gem_object *obj);
>  void i915_gem_object_release_mmap_gtt(struct drm_i915_gem_object *obj);
>  
> diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
> index d50347e5773a..48d7e53c49d6 100644
> --- a/drivers/gpu/drm/i915/i915_driver.c
> +++ b/drivers/gpu/drm/i915/i915_driver.c
> @@ -42,6 +42,7 @@
>  #include <drm/drm_aperture.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_ioctl.h>
> +#include <drm/drm_gem.h>
>  #include <drm/drm_managed.h>
>  #include <drm/drm_probe_helper.h>
>  
> @@ -1826,7 +1827,7 @@ static const struct drm_driver i915_drm_driver = {
>  	.gem_prime_import = i915_gem_prime_import,
>  
>  	.dumb_create = i915_gem_dumb_create,
> -	.dumb_map_offset = i915_gem_dumb_mmap_offset,
> +	.dumb_map_offset = drm_gem_dumb_map_offset,
>  
>  	.ioctls = i915_ioctls,
>  	.num_ioctls = ARRAY_SIZE(i915_ioctls),

-- 
Jani Nikula, Intel
