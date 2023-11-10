Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52AF7E8219
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344793AbjKJS7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbjKJS6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:58:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E00C71000
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699640499; x=1731176499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dZi44k3TgPgnnNlNBP+yBAC74XU+dQcO86pQx+Yfm7U=;
  b=WYQIn2Lt371jf84T8xfm4nZ2yJxrf1fh5ZWC/8Xpz2UwRAB6BOJnlg/0
   7VmP12s0xtfvhYkVq07U0x/5m6RULrEOxDLUnmKhIYIopQ2J1YPi0/9Mf
   Qa4Le5PZBTPU9TM2Gvdnmg4GoBXc3IiSmveTfcDjCMjVzbK+J14K7zMqs
   s53ZMwBVcgD0mMx0jwUHzrISaonEDJe4+JBmFso6yzb2KdPi1AgyZ/JOI
   F1CJMeShj+M3WuD2iZUx6gjBWpY8Y5K4hH+u6RclZs4Y7xUzkXrjXBTL9
   hXIpO4ZBxXumCXPKjGv9DN4pJItL1p4EXpDhdepg5D4RLb7Q10zQO54wH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="393091177"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="393091177"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 10:20:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="1011009099"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="1011009099"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 10 Nov 2023 10:20:55 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1W7g-0009oA-2D;
        Fri, 10 Nov 2023 18:20:52 +0000
Date:   Sat, 11 Nov 2023 02:20:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dipam Turkar <dipamt1729@gmail.com>, jani.nikula@linux.intel.com
Cc:     oe-kbuild-all@lists.linux.dev, Dipam Turkar <dipamt1729@gmail.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        rodrigo.vivi@intel.com, airlied@gmail.com
Subject: Re: [Intel-gfx] [PATCH] Remove custom dumb_map_offset
 implementations in i915 driver
Message-ID: <202311110234.QjYxC2bv-lkp@intel.com>
References: <20231110105811.380646-1-dipamt1729@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231110105811.380646-1-dipamt1729@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dipam,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-tip/drm-tip]

url:    https://github.com/intel-lab-lkp/linux/commits/Dipam-Turkar/Remove-custom-dumb_map_offset-implementations-in-i915-driver/20231110-185942
base:   git://anongit.freedesktop.org/drm/drm-tip drm-tip
patch link:    https://lore.kernel.org/r/20231110105811.380646-1-dipamt1729%40gmail.com
patch subject: [Intel-gfx] [PATCH] Remove custom dumb_map_offset implementations in i915 driver
config: x86_64-randconfig-014-20231110 (https://download.01.org/0day-ci/archive/20231111/202311110234.QjYxC2bv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311110234.QjYxC2bv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311110234.QjYxC2bv-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/i915/gem/i915_gem_mman.c: In function 'i915_gem_mmap_offset_ioctl':
   drivers/gpu/drm/i915/gem/i915_gem_mman.c:673:16: error: implicit declaration of function '__assign_mmap_offset_handle' [-Werror=implicit-function-declaration]
     673 |         return __assign_mmap_offset_handle(file, args->handle, type, &args->offset);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/gem/i915_gem_mman.c: In function 'i915_gem_fb_mmap':
   drivers/gpu/drm/i915/gem/i915_gem_mman.c:896:23: error: implicit declaration of function 'mmap_offset_attach' [-Werror=implicit-function-declaration]
     896 |                 mmo = mmap_offset_attach(obj, mmap_type, NULL);
         |                       ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/gem/i915_gem_mman.c:896:21: warning: assignment to 'struct i915_mmap_offset *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     896 |                 mmo = mmap_offset_attach(obj, mmap_type, NULL);
         |                     ^
   In file included from drivers/gpu/drm/i915/gem/i915_gem_mman.c:912:
   drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c: In function 'assert_mmap_offset':
>> drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c:624:15: error: implicit declaration of function '__assign_mmap_offset'; did you mean 'assert_mmap_offset'? [-Werror=implicit-function-declaration]
     624 |         ret = __assign_mmap_offset(obj, default_mapping(i915), &offset, NULL);
         |               ^~~~~~~~~~~~~~~~~~~~
         |               assert_mmap_offset
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_I915_DEBUG_GEM
   Depends on [n]: HAS_IOMEM [=y] && DRM_I915 [=y] && EXPERT [=y] && DRM_I915_WERROR [=n]
   Selected by [y]:
   - DRM_I915_DEBUG [=y] && HAS_IOMEM [=y] && DRM_I915 [=y] && EXPERT [=y] && !COMPILE_TEST [=n]


vim +624 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c

450cede7f3804c Thomas Hellström  2021-08-31  611  
b414fcd5be0b00 Chris Wilson      2019-05-28  612  static bool assert_mmap_offset(struct drm_i915_private *i915,
b414fcd5be0b00 Chris Wilson      2019-05-28  613  			       unsigned long size,
b414fcd5be0b00 Chris Wilson      2019-05-28  614  			       int expected)
b414fcd5be0b00 Chris Wilson      2019-05-28  615  {
b414fcd5be0b00 Chris Wilson      2019-05-28  616  	struct drm_i915_gem_object *obj;
cf3e3e86d77970 Maarten Lankhorst 2021-06-10  617  	u64 offset;
cf3e3e86d77970 Maarten Lankhorst 2021-06-10  618  	int ret;
b414fcd5be0b00 Chris Wilson      2019-05-28  619  
450cede7f3804c Thomas Hellström  2021-08-31  620  	obj = create_sys_or_internal(i915, size);
b414fcd5be0b00 Chris Wilson      2019-05-28  621  	if (IS_ERR(obj))
cf3e3e86d77970 Maarten Lankhorst 2021-06-10  622  		return expected && expected == PTR_ERR(obj);
b414fcd5be0b00 Chris Wilson      2019-05-28  623  
7961c5b60f23df Maarten Lankhorst 2021-07-14 @624  	ret = __assign_mmap_offset(obj, default_mapping(i915), &offset, NULL);
b414fcd5be0b00 Chris Wilson      2019-05-28  625  	i915_gem_object_put(obj);
b414fcd5be0b00 Chris Wilson      2019-05-28  626  
cf3e3e86d77970 Maarten Lankhorst 2021-06-10  627  	return ret == expected;
b414fcd5be0b00 Chris Wilson      2019-05-28  628  }
b414fcd5be0b00 Chris Wilson      2019-05-28  629  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
