Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695A6804FD0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjLEKGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjLEKGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:06:48 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1D6C9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:06:51 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40859dee28cso54037985e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 02:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701770809; x=1702375609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O9sl689hzlJQYzBsgFB2WhOlBJ/fZZG2kg7Y3Bfk+Jk=;
        b=V7BRyWDxUP1hG/Zo6RS6hmRrdauQ+z3OqZVh1sCZL1igS05Txk5+fU7MbWC/tInP0H
         l7SlMsb4kUW/BEgX0AP1WMtosmJTxY/ue5xU9Ni0xq1odmx2n8IdxSZMad4842OwYSqh
         c1UkM7Iu3a/13hpd5vqD10VcD7zY1rZaW+cAYArp75MKSA2TamIzJojrl8d5hc2wgoUL
         qiEH2waU7uZ37EtE/PsY9clGK/lphCxznk+h1Log3jXcdK52rM6iEo6z94VqmibaA6/z
         Oc1aeJy1wR/1UhnbyVYpzIDnLCYcpWLmt3zaYB+vKGGzpuH8gRM3eqRfyLaXyX0d6pSt
         6MWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701770809; x=1702375609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9sl689hzlJQYzBsgFB2WhOlBJ/fZZG2kg7Y3Bfk+Jk=;
        b=d+8HrfgpiFD1yQafAPziJBXPXHffj9/VOomWbPMuCISQUOra2SBAIJ41/zBFW0GEEh
         wA1FnXm0HSQ5etRA42Srqv+6EvQ9UT/wcYQRtK24TsvYJHTPjqjnuAFomMpe9YA4sFg8
         3M1dwq0PuT/L6Mx4RfQvwU6cbB8q+8GArDisXvbdZ7oZFfSijDKAXl+ZTshnN/KPPYDR
         /mXBq6VWISa2ThfxmFEqc/GLXxsKSXlB5Glh0KCSzpfI1KO6xUW1iVyNbOTgaf6rHYy2
         z7tKpIz8EkkKTzk/eD4SCYBddokZ1ItpsCLtiW0QtRHYRfKObAr6ixSBtc3n6W9dy1BI
         2Hsg==
X-Gm-Message-State: AOJu0YwgtSN5N1QC5ayYoIRhnm3so36RPXbfnlyp7eVBgTT0a9OrPF74
        aTmT0y2RQ3NiOTgUCAQz9yTULw==
X-Google-Smtp-Source: AGHT+IGiqAcOWb6+LtZFfcXdEsKroCG+o1qA0L106wojDPkJpNUDy3QfsoSUNiXys+b/+Co1QkteCg==
X-Received: by 2002:a05:600c:19ce:b0:40a:25f1:7a28 with SMTP id u14-20020a05600c19ce00b0040a25f17a28mr4156631wmq.40.1701770809237;
        Tue, 05 Dec 2023 02:06:49 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c310e00b0040b481222e3sm21976386wmo.41.2023.12.05.02.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:06:48 -0800 (PST)
Date:   Tue, 5 Dec 2023 13:06:45 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Dan Carpenter <error27@gmail.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Luca Abeni <luca.abeni@santannapisa.it>
Subject: Re: drivers/video/fbdev/amifb.c:3375:32: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <b139b275-ee57-4026-83d3-7d49ae04ef49@suswa.mountain>
References: <202312051741.BVXr9CRP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312051741.BVXr9CRP-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Something went wrong with this git bisect.  The Sparse warning predates
git.  The file was renamed at some point so I would have thought the
bisect would point to that.

regards,
dan carpenter

On Tue, Dec 05, 2023 at 05:50:23PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
> commit: aa5222e92f8000ed3c1c38dddf11c83222aadfb3 sched/deadline: Don't use dubious signed bitfields
> date:   6 years ago
> config: m68k-randconfig-r131-20231129 (https://download.01.org/0day-ci/archive/20231205/202312051741.BVXr9CRP-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20231205/202312051741.BVXr9CRP-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312051741.BVXr9CRP-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/video/fbdev/amifb.c:3375:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *dst @@     got char [noderef] __iomem *screen_base @@
>    drivers/video/fbdev/amifb.c:3375:32: sparse:     expected void *dst
>    drivers/video/fbdev/amifb.c:3375:32: sparse:     got char [noderef] __iomem *screen_base
> >> drivers/video/fbdev/amifb.c:3713:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got char * @@
>    drivers/video/fbdev/amifb.c:3713:35: sparse:     expected char [noderef] __iomem *screen_base
>    drivers/video/fbdev/amifb.c:3713:35: sparse:     got char *
> >> drivers/video/fbdev/amifb.c:3755:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
>    drivers/video/fbdev/amifb.c:3755:26: sparse:     expected void [noderef] __iomem *addr
>    drivers/video/fbdev/amifb.c:3755:26: sparse:     got void *
>    drivers/video/fbdev/amifb.c:3772:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
>    drivers/video/fbdev/amifb.c:3772:26: sparse:     expected void [noderef] __iomem *addr
>    drivers/video/fbdev/amifb.c:3772:26: sparse:     got void *
>    In file included from include/linux/workqueue.h:9,
>                     from include/linux/srcu.h:34,
>                     from include/linux/notifier.h:16,
>                     from include/linux/memory_hotplug.h:7,
>                     from include/linux/mmzone.h:780,
>                     from include/linux/gfp.h:6,
>                     from include/linux/umh.h:4,
>                     from include/linux/kmod.h:22,
>                     from include/linux/module.h:13,
>                     from drivers/video/fbdev/amifb.c:43:
>    include/linux/timer.h: In function 'timer_setup':
>    include/linux/timer.h:159:30: warning: cast between incompatible function types from 'void (*)(struct timer_list *)' to 'void (*)(long unsigned int)' [-Wcast-function-type]
>      159 |         __setup_timer(timer, (TIMER_FUNC_TYPE)callback,
>          |                              ^
>    include/linux/timer.h:126:39: note: in definition of macro '__setup_timer'
>      126 |                 (_timer)->function = (_fn);                             29-      |                                       ^~~
>    include/linux/timer.h: In function 'timer_setup_on_stack':
>    include/linux/timer.h:167:39: warning: cast between incompatible function types from 'void (*)(struct timer_list *)' to 'void (*)(long unsigned int)' [-Wcast-function-type]
>      167 |         __setup_timer_on_stack(timer, (TIMER_FUNC_TYPE)callback,
>          |                                       ^
>    include/linux/timer.h:133:39: note: in definition of macro '__setup_timer_on_stack'
>      133 |                 (_timer)->function = (_fn);                             36-      |                                       ^~~
>    drivers/video/fbdev/amifb.c: In function 'ami_decode_var':
>    drivers/video/fbdev/amifb.c:1127:23: warning: variable 'vtotal' set but not used [-Wunused-but-set-variable]
>     1127 |         u_int htotal, vtotal;
>          |                       ^~~~~~
>    drivers/video/fbdev/amifb.c:1127:15: warning: variable 'htotal' set but not used [-Wunused-but-set-variable]
>     1127 |         u_int htotal, vtotal;
>          |               ^~~~~~
>    drivers/video/fbdev/amifb.c: In function 'ami_get_var_cursorinfo':
>    drivers/video/fbdev/amifb.c:1848:19: warning: variable 'alloc' set but not used [-Wunused-but-set-variable]
>     1848 |         int size, alloc;
>          |                   ^~~~~
>    drivers/video/fbdev/amifb.c: In function 'amifb_pan_display':
>    drivers/video/fbdev/amifb.c:2540:34: warning: comparison of unsigned expression in '< 0' is always false [-Wtype-limits]
>     2540 |                 if (var->yoffset < 0 ||
>          |                                  ^
>    drivers/video/fbdev/amifb.c: At top level:
>    include/linux/module.h:131:13: warning: 'init_module' specifies less restrictive attribute than its target 'amifb_driver_init': 'cold' [-Wmissing-attributes]
>      131 |         int init_module(void) __attribute__((alias(#initfn)));
>          |             ^~~~~~~~~~~
>    include/linux/platform_device.h:251:1: note: in expansion of macro 'module_init'
>      251 | module_init(__platform_driver##_init); 58-      | ^~~~~~~~~~~
>    drivers/video/fbdev/amifb.c:3786:1: note: in expansion of macro 'module_platform_driver_probe'
>     3786 | module_platform_driver_probe(amifb_driver, amifb_probe);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    In file included from drivers/video/fbdev/amifb.c:53:
>    drivers/video/fbdev/amifb.c:3786:30: note: 'init_module' target declared here
>     3786 | module_platform_driver_probe(amifb_driver, amifb_probe);
>          |                              ^~~~~~~~~~~~
>    include/linux/platform_device.h:246:19: note: in definition of macro 'module_platform_driver_probe'
>      246 | static int __init __platform_driver##_init(void) 68-      |                   ^~~~~~~~~~~~~~~~~
>    include/linux/module.h:137:14: warning: 'cleanup_module' specifies less restrictive attribute than its target 'amifb_driver_exit': 'cold' [-Wmissing-attributes]
>      137 |         void cleanup_module(void) __attribute__((alias(#exitfn)));
>          |              ^~~~~~~~~~~~~~
>    include/linux/platform_device.h:256:1: note: in expansion of macro 'module_exit'
>      256 | module_exit(__platform_driver##_exit);
>          | ^~~~~~~~~~~
>    drivers/video/fbdev/amifb.c:3786:1: note: in expansion of macro 'module_platform_driver_probe'
>     3786 | module_platform_driver_probe(amifb_driver, amifb_probe);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/video/fbdev/amifb.c:3786:30: note: 'cleanup_module' target declared here
>     3786 | module_platform_driver_probe(amifb_driver, amifb_probe);
>          |                              ^~~~~~~~~~~~
>    include/linux/platform_device.h:252:20: note: in definition of macro 'module_platform_driver_probe'
>      252 | static void __exit __platform_driver##_exit(void) 83-      |                    ^~~~~~~~~~~~~~~~~
>    drivers/video/fbdev/amifb.c:2344:19: warning: 'amifb_setup' defined but not used [-Wunused-function]
>     2344 | static int __init amifb_setup(char *options)
>          |                   ^~~~~~~~~~~
> 
> vim +3375 drivers/video/fbdev/amifb.c
> 
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3334  
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3335  
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3336  static void amifb_imageblit(struct fb_info *info, const struct fb_image *image)
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3337  {
> 423a53086ce409 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3338  	struct amifb_par *par = info->par;
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3339  	int x2, y2;
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3340  	unsigned long *dst;
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3341  	int dst_idx;
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3342  	const char *src;
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3343  	u32 dx, dy, width, height, pitch;
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3344  
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3345  	/*
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3346  	 * We could use hardware clipping but on many cards you get around
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3347  	 * hardware clipping by writing to framebuffer directly like we are
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3348  	 * doing here.
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3349  	 */
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3350  	x2 = image->dx + image->width;
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3351  	y2 = image->dy + image->height;
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3352  	dx = image->dx;
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3353  	dy = image->dy;
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3354  	x2 = x2 < info->var.xres_virtual ? x2 : info->var.xres_virtual;
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3355  	y2 = y2 < info->var.yres_virtual ? y2 : info->var.yres_virtual;
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3356  	width  = x2 - dx;
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3357  	height = y2 - dy;
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3358  
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3359  	if (image->depth == 1) {
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3360  		dst = (unsigned long *)
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3361  			((unsigned long)info->screen_base & ~(BYTES_PER_LONG - 1));
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3362  		dst_idx = ((unsigned long)info->screen_base & (BYTES_PER_LONG - 1)) * 8;
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3363  		dst_idx += dy * par->next_line * 8 + dx;
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3364  		src = image->data;
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3365  		pitch = (image->width + 7) / 8;
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3366  		while (height--) {
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3367  			expand_one_line(info->var.bits_per_pixel,
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3368  					par->next_plane, dst, dst_idx, width,
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3369  					src, image->bg_color,
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3370  					image->fg_color);
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3371  			dst_idx += par->next_line * 8;
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3372  			src += pitch;
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3373  		}
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3374  	} else {
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21 @3375  		c2p_planar(info->screen_base, image->data, dx, dy, width,
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3376  			   height, par->next_line, par->next_plane,
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3377  			   image->width, info->var.bits_per_pixel);
> ^1da177e4c3f41 drivers/video/amifb.c Linus Torvalds     2005-04-16  3378  	}
> ^1da177e4c3f41 drivers/video/amifb.c Linus Torvalds     2005-04-16  3379  }
> f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3380  
> 
> :::::: The code at line 3375 was first introduced by commit
> :::::: f1cbb17ac73993225402d7e40a0694c502570876 fbdev/amifb: Reorder functions to remove forward declarations
> 
> :::::: TO: Geert Uytterhoeven <geert@linux-m68k.org>
> :::::: CC: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
