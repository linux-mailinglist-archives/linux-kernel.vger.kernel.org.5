Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251BB7E84C9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbjKJU4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235790AbjKJU4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:56:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286F75ED8B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699641432; x=1731177432;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ma8woTlLXt37OgJ3lG1H9hM4J+sMKQ6o3z6BV4rfNfw=;
  b=OsvYRkXLfg/pO9B9iRa/RiKb7n2HuzJ7HxT7WSDr1kuH5KeCMHk4ixIp
   7m8uBuzz/YMlYYQVxV9+PiZU5kB7FuW9l2XaSbzITJg3cyzlt2OUuKO2k
   SHJ8Wc522FARAS0qeGzsr0etJhuDyQCmUyHv1R4zb3X1bJAvDz++6zdjI
   mUNGC2M8tzKwqTj0wdipcfnXDvu+PeybJHXC5YRZ+obLtydGNAKlC1H47
   amn4AXctBNVv1F4mWvizaMW7HcZu6LLA5CBobXwLpOIgeT2hImZfyTMq2
   EaO5BDigsbdNgXNv/llQz/dnccUgGsA10FijouoWIpJNMJ+lPRKyrOAom
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="3205536"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="3205536"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 10:37:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="11548609"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 10 Nov 2023 10:37:10 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1WNO-0009p0-1a;
        Fri, 10 Nov 2023 18:37:06 +0000
Date:   Sat, 11 Nov 2023 02:37:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dipam Turkar <dipamt1729@gmail.com>, jani.nikula@linux.intel.com
Cc:     oe-kbuild-all@lists.linux.dev, Dipam Turkar <dipamt1729@gmail.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        rodrigo.vivi@intel.com, airlied@gmail.com
Subject: Re: [Intel-gfx] [PATCH] Remove custom dumb_map_offset
 implementations in i915 driver
Message-ID: <202311110226.CsxS1u1i-lkp@intel.com>
References: <20231110105811.380646-1-dipamt1729@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110105811.380646-1-dipamt1729@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dipam,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-tip/drm-tip]

url:    https://github.com/intel-lab-lkp/linux/commits/Dipam-Turkar/Remove-custom-dumb_map_offset-implementations-in-i915-driver/20231110-185942
base:   git://anongit.freedesktop.org/drm/drm-tip drm-tip
patch link:    https://lore.kernel.org/r/20231110105811.380646-1-dipamt1729%40gmail.com
patch subject: [Intel-gfx] [PATCH] Remove custom dumb_map_offset implementations in i915 driver
config: x86_64-randconfig-001-20231110 (https://download.01.org/0day-ci/archive/20231111/202311110226.CsxS1u1i-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311110226.CsxS1u1i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311110226.CsxS1u1i-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/i915/gem/i915_gem_mman.c: In function 'i915_gem_mmap_offset_ioctl':
   drivers/gpu/drm/i915/gem/i915_gem_mman.c:673:9: error: implicit declaration of function '__assign_mmap_offset_handle'; did you mean 'i915_gem_mmap_offset_ioctl'? [-Werror=implicit-function-declaration]
     return __assign_mmap_offset_handle(file, args->handle, type, &args->offset);
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
            i915_gem_mmap_offset_ioctl
   drivers/gpu/drm/i915/gem/i915_gem_mman.c: In function 'i915_gem_fb_mmap':
   drivers/gpu/drm/i915/gem/i915_gem_mman.c:896:9: error: implicit declaration of function 'mmap_offset_attach'; did you mean 'dma_free_attrs'? [-Werror=implicit-function-declaration]
      mmo = mmap_offset_attach(obj, mmap_type, NULL);
            ^~~~~~~~~~~~~~~~~~
            dma_free_attrs
>> drivers/gpu/drm/i915/gem/i915_gem_mman.c:896:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      mmo = mmap_offset_attach(obj, mmap_type, NULL);
          ^
   cc1: some warnings being treated as errors


vim +896 drivers/gpu/drm/i915/gem/i915_gem_mman.c

eaee1c085863951 Nirmoy Das    2023-04-04  874  
eaee1c085863951 Nirmoy Das    2023-04-04  875  int i915_gem_fb_mmap(struct drm_i915_gem_object *obj, struct vm_area_struct *vma)
eaee1c085863951 Nirmoy Das    2023-04-04  876  {
eaee1c085863951 Nirmoy Das    2023-04-04  877  	struct drm_i915_private *i915 = to_i915(obj->base.dev);
eaee1c085863951 Nirmoy Das    2023-04-04  878  	struct drm_device *dev = &i915->drm;
eaee1c085863951 Nirmoy Das    2023-04-04  879  	struct i915_mmap_offset *mmo = NULL;
eaee1c085863951 Nirmoy Das    2023-04-04  880  	enum i915_mmap_type mmap_type;
eaee1c085863951 Nirmoy Das    2023-04-04  881  	struct i915_ggtt *ggtt = to_gt(i915)->ggtt;
eaee1c085863951 Nirmoy Das    2023-04-04  882  
eaee1c085863951 Nirmoy Das    2023-04-04  883  	if (drm_dev_is_unplugged(dev))
eaee1c085863951 Nirmoy Das    2023-04-04  884  		return -ENODEV;
eaee1c085863951 Nirmoy Das    2023-04-04  885  
eaee1c085863951 Nirmoy Das    2023-04-04  886  	/* handle ttm object */
eaee1c085863951 Nirmoy Das    2023-04-04  887  	if (obj->ops->mmap_ops) {
eaee1c085863951 Nirmoy Das    2023-04-04  888  		/*
eaee1c085863951 Nirmoy Das    2023-04-04  889  		 * ttm fault handler, ttm_bo_vm_fault_reserved() uses fake offset
eaee1c085863951 Nirmoy Das    2023-04-04  890  		 * to calculate page offset so set that up.
eaee1c085863951 Nirmoy Das    2023-04-04  891  		 */
eaee1c085863951 Nirmoy Das    2023-04-04  892  		vma->vm_pgoff += drm_vma_node_start(&obj->base.vma_node);
eaee1c085863951 Nirmoy Das    2023-04-04  893  	} else {
eaee1c085863951 Nirmoy Das    2023-04-04  894  		/* handle stolen and smem objects */
eaee1c085863951 Nirmoy Das    2023-04-04  895  		mmap_type = i915_ggtt_has_aperture(ggtt) ? I915_MMAP_TYPE_GTT : I915_MMAP_TYPE_WC;
eaee1c085863951 Nirmoy Das    2023-04-04 @896  		mmo = mmap_offset_attach(obj, mmap_type, NULL);
274d4b96b12f78c Dan Carpenter 2023-06-06  897  		if (IS_ERR(mmo))
274d4b96b12f78c Dan Carpenter 2023-06-06  898  			return PTR_ERR(mmo);
eaee1c085863951 Nirmoy Das    2023-04-04  899  	}
eaee1c085863951 Nirmoy Das    2023-04-04  900  
eaee1c085863951 Nirmoy Das    2023-04-04  901  	/*
eaee1c085863951 Nirmoy Das    2023-04-04  902  	 * When we install vm_ops for mmap we are too late for
eaee1c085863951 Nirmoy Das    2023-04-04  903  	 * the vm_ops->open() which increases the ref_count of
eaee1c085863951 Nirmoy Das    2023-04-04  904  	 * this obj and then it gets decreased by the vm_ops->close().
eaee1c085863951 Nirmoy Das    2023-04-04  905  	 * To balance this increase the obj ref_count here.
eaee1c085863951 Nirmoy Das    2023-04-04  906  	 */
eaee1c085863951 Nirmoy Das    2023-04-04  907  	obj = i915_gem_object_get(obj);
eaee1c085863951 Nirmoy Das    2023-04-04  908  	return i915_gem_object_mmap(obj, mmo, vma);
eaee1c085863951 Nirmoy Das    2023-04-04  909  }
eaee1c085863951 Nirmoy Das    2023-04-04  910  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
