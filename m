Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5529804EAE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346540AbjLEJum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjLEJue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:50:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3197BAF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701769839; x=1733305839;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Wb+nP3uWGNr4eVKcgKvIUTwvDqfMqPZGWYZ+1de9evM=;
  b=ALy9eFVTsHdf00taBP3O4xMk9HMzlvjiJ1BObKXQAHhSWL5qBUuUQTDe
   TlQwFN4WxY96BxJ/8crddoHtIiEVCx/fW/WCRlkcaVpJzepaQLRRKzdmk
   q6oxH0VfiTQ4f/d59VyunpfKfkruH7Vkhm2RmMO13gkoH/TcTXLOpx6Yp
   Aa74pxNjlOXjezpB3kId0VWQlaVHXd4xyVJeDnBkTF43LwM5JLAvFzwqo
   idJAIuZqpNlEbrzT36tLNPLT2Z9vIbyO6lpbsbjKCadHOWAffR1IrmupO
   h42J7ELKQq0L8atAqhRJbN6IdjDio2IFewCNeudy3KBSvj3bW1+p0O/rS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="384269382"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="384269382"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:50:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="805229069"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="805229069"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 05 Dec 2023 01:50:36 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAS4Y-0008hi-0l;
        Tue, 05 Dec 2023 09:50:34 +0000
Date:   Tue, 5 Dec 2023 17:50:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Luca Abeni <luca.abeni@santannapisa.it>
Subject: drivers/video/fbdev/amifb.c:3375:32: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202312051741.BVXr9CRP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: aa5222e92f8000ed3c1c38dddf11c83222aadfb3 sched/deadline: Don't use dubious signed bitfields
date:   6 years ago
config: m68k-randconfig-r131-20231129 (https://download.01.org/0day-ci/archive/20231205/202312051741.BVXr9CRP-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231205/202312051741.BVXr9CRP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312051741.BVXr9CRP-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/video/fbdev/amifb.c:3375:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *dst @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/amifb.c:3375:32: sparse:     expected void *dst
   drivers/video/fbdev/amifb.c:3375:32: sparse:     got char [noderef] __iomem *screen_base
>> drivers/video/fbdev/amifb.c:3713:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got char * @@
   drivers/video/fbdev/amifb.c:3713:35: sparse:     expected char [noderef] __iomem *screen_base
   drivers/video/fbdev/amifb.c:3713:35: sparse:     got char *
>> drivers/video/fbdev/amifb.c:3755:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/amifb.c:3755:26: sparse:     expected void [noderef] __iomem *addr
   drivers/video/fbdev/amifb.c:3755:26: sparse:     got void *
   drivers/video/fbdev/amifb.c:3772:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/amifb.c:3772:26: sparse:     expected void [noderef] __iomem *addr
   drivers/video/fbdev/amifb.c:3772:26: sparse:     got void *
   In file included from include/linux/workqueue.h:9,
                    from include/linux/srcu.h:34,
                    from include/linux/notifier.h:16,
                    from include/linux/memory_hotplug.h:7,
                    from include/linux/mmzone.h:780,
                    from include/linux/gfp.h:6,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:22,
                    from include/linux/module.h:13,
                    from drivers/video/fbdev/amifb.c:43:
   include/linux/timer.h: In function 'timer_setup':
   include/linux/timer.h:159:30: warning: cast between incompatible function types from 'void (*)(struct timer_list *)' to 'void (*)(long unsigned int)' [-Wcast-function-type]
     159 |         __setup_timer(timer, (TIMER_FUNC_TYPE)callback,
         |                              ^
   include/linux/timer.h:126:39: note: in definition of macro '__setup_timer'
     126 |                 (_timer)->function = (_fn);                             29-      |                                       ^~~
   include/linux/timer.h: In function 'timer_setup_on_stack':
   include/linux/timer.h:167:39: warning: cast between incompatible function types from 'void (*)(struct timer_list *)' to 'void (*)(long unsigned int)' [-Wcast-function-type]
     167 |         __setup_timer_on_stack(timer, (TIMER_FUNC_TYPE)callback,
         |                                       ^
   include/linux/timer.h:133:39: note: in definition of macro '__setup_timer_on_stack'
     133 |                 (_timer)->function = (_fn);                             36-      |                                       ^~~
   drivers/video/fbdev/amifb.c: In function 'ami_decode_var':
   drivers/video/fbdev/amifb.c:1127:23: warning: variable 'vtotal' set but not used [-Wunused-but-set-variable]
    1127 |         u_int htotal, vtotal;
         |                       ^~~~~~
   drivers/video/fbdev/amifb.c:1127:15: warning: variable 'htotal' set but not used [-Wunused-but-set-variable]
    1127 |         u_int htotal, vtotal;
         |               ^~~~~~
   drivers/video/fbdev/amifb.c: In function 'ami_get_var_cursorinfo':
   drivers/video/fbdev/amifb.c:1848:19: warning: variable 'alloc' set but not used [-Wunused-but-set-variable]
    1848 |         int size, alloc;
         |                   ^~~~~
   drivers/video/fbdev/amifb.c: In function 'amifb_pan_display':
   drivers/video/fbdev/amifb.c:2540:34: warning: comparison of unsigned expression in '< 0' is always false [-Wtype-limits]
    2540 |                 if (var->yoffset < 0 ||
         |                                  ^
   drivers/video/fbdev/amifb.c: At top level:
   include/linux/module.h:131:13: warning: 'init_module' specifies less restrictive attribute than its target 'amifb_driver_init': 'cold' [-Wmissing-attributes]
     131 |         int init_module(void) __attribute__((alias(#initfn)));
         |             ^~~~~~~~~~~
   include/linux/platform_device.h:251:1: note: in expansion of macro 'module_init'
     251 | module_init(__platform_driver##_init); 58-      | ^~~~~~~~~~~
   drivers/video/fbdev/amifb.c:3786:1: note: in expansion of macro 'module_platform_driver_probe'
    3786 | module_platform_driver_probe(amifb_driver, amifb_probe);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/video/fbdev/amifb.c:53:
   drivers/video/fbdev/amifb.c:3786:30: note: 'init_module' target declared here
    3786 | module_platform_driver_probe(amifb_driver, amifb_probe);
         |                              ^~~~~~~~~~~~
   include/linux/platform_device.h:246:19: note: in definition of macro 'module_platform_driver_probe'
     246 | static int __init __platform_driver##_init(void) 68-      |                   ^~~~~~~~~~~~~~~~~
   include/linux/module.h:137:14: warning: 'cleanup_module' specifies less restrictive attribute than its target 'amifb_driver_exit': 'cold' [-Wmissing-attributes]
     137 |         void cleanup_module(void) __attribute__((alias(#exitfn)));
         |              ^~~~~~~~~~~~~~
   include/linux/platform_device.h:256:1: note: in expansion of macro 'module_exit'
     256 | module_exit(__platform_driver##_exit);
         | ^~~~~~~~~~~
   drivers/video/fbdev/amifb.c:3786:1: note: in expansion of macro 'module_platform_driver_probe'
    3786 | module_platform_driver_probe(amifb_driver, amifb_probe);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/video/fbdev/amifb.c:3786:30: note: 'cleanup_module' target declared here
    3786 | module_platform_driver_probe(amifb_driver, amifb_probe);
         |                              ^~~~~~~~~~~~
   include/linux/platform_device.h:252:20: note: in definition of macro 'module_platform_driver_probe'
     252 | static void __exit __platform_driver##_exit(void) 83-      |                    ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/amifb.c:2344:19: warning: 'amifb_setup' defined but not used [-Wunused-function]
    2344 | static int __init amifb_setup(char *options)
         |                   ^~~~~~~~~~~

vim +3375 drivers/video/fbdev/amifb.c

f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3334  
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3335  
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3336  static void amifb_imageblit(struct fb_info *info, const struct fb_image *image)
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3337  {
423a53086ce409 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3338  	struct amifb_par *par = info->par;
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3339  	int x2, y2;
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3340  	unsigned long *dst;
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3341  	int dst_idx;
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3342  	const char *src;
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3343  	u32 dx, dy, width, height, pitch;
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3344  
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3345  	/*
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3346  	 * We could use hardware clipping but on many cards you get around
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3347  	 * hardware clipping by writing to framebuffer directly like we are
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3348  	 * doing here.
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3349  	 */
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3350  	x2 = image->dx + image->width;
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3351  	y2 = image->dy + image->height;
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3352  	dx = image->dx;
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3353  	dy = image->dy;
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3354  	x2 = x2 < info->var.xres_virtual ? x2 : info->var.xres_virtual;
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3355  	y2 = y2 < info->var.yres_virtual ? y2 : info->var.yres_virtual;
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3356  	width  = x2 - dx;
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3357  	height = y2 - dy;
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3358  
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3359  	if (image->depth == 1) {
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3360  		dst = (unsigned long *)
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3361  			((unsigned long)info->screen_base & ~(BYTES_PER_LONG - 1));
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3362  		dst_idx = ((unsigned long)info->screen_base & (BYTES_PER_LONG - 1)) * 8;
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3363  		dst_idx += dy * par->next_line * 8 + dx;
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3364  		src = image->data;
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3365  		pitch = (image->width + 7) / 8;
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3366  		while (height--) {
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3367  			expand_one_line(info->var.bits_per_pixel,
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3368  					par->next_plane, dst, dst_idx, width,
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3369  					src, image->bg_color,
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3370  					image->fg_color);
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3371  			dst_idx += par->next_line * 8;
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3372  			src += pitch;
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3373  		}
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3374  	} else {
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21 @3375  		c2p_planar(info->screen_base, image->data, dx, dy, width,
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3376  			   height, par->next_line, par->next_plane,
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3377  			   image->width, info->var.bits_per_pixel);
^1da177e4c3f41 drivers/video/amifb.c Linus Torvalds     2005-04-16  3378  	}
^1da177e4c3f41 drivers/video/amifb.c Linus Torvalds     2005-04-16  3379  }
f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3380  

:::::: The code at line 3375 was first introduced by commit
:::::: f1cbb17ac73993225402d7e40a0694c502570876 fbdev/amifb: Reorder functions to remove forward declarations

:::::: TO: Geert Uytterhoeven <geert@linux-m68k.org>
:::::: CC: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
