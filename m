Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D654979D3C7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbjILOel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjILOej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:34:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAA110D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694529275; x=1726065275;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0OKqkQKJS3WV9cniVX/rAP6QHhyqfdQ6uX7H4idPa7o=;
  b=kn91L6EWYqwRheSqqZ6BJReQWc6fjEH1V8Cm3pQWW2SAxp+H5OfAbvsQ
   RgqG1cHNWd2yFS13KcCrpkMsQQjsRoL3/24z+JRl15rBKWQ2rYDqp1uV5
   +THqg/+rfgMzT/X0txhNvp04ZzYU3FS/VcwHrYeZFJdVe/6b5IJfnTw+L
   LTgZTMWm4xNtPtTB4w4G1zCUKv807isnRDBPmcAwrk8HDpXjjALOhTK97
   h8wow2K6k1H3Xr7KV/ylWesSqRCZF+7azdq4LpSB67acDviabASkykOFs
   QEcxnkCCbOfhUAOfuDY/X6x7tPlgoGc+CHqhEpb7pkTLOl5k07awWE8tt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="444824881"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="444824881"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 07:34:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="917447259"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="917447259"
Received: from lkp-server02.sh.intel.com (HELO 0a6943a0b3e1) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 12 Sep 2023 07:34:05 -0700
Received: from kbuild by 0a6943a0b3e1 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qg4So-00004t-2k;
        Tue, 12 Sep 2023 14:34:02 +0000
Date:   Tue, 12 Sep 2023 22:33:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: Re: [PATCH] drm/simpledrm: Add support for multiple "power-domains"
Message-ID: <202309122212.MetCn4UK-lkp@intel.com>
References: <20230910-simpledrm-multiple-power-domains-v1-1-f8718aefc685@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230910-simpledrm-multiple-power-domains-v1-1-f8718aefc685@jannau.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janne,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 15d30b46573d75f5cb58cfacded8ebab9c76a2b0]

url:    https://github.com/intel-lab-lkp/linux/commits/Janne-Grunau-via-B4-Relay/drm-simpledrm-Add-support-for-multiple-power-domains/20230911-004026
base:   15d30b46573d75f5cb58cfacded8ebab9c76a2b0
patch link:    https://lore.kernel.org/r/20230910-simpledrm-multiple-power-domains-v1-1-f8718aefc685%40jannau.net
patch subject: [PATCH] drm/simpledrm: Add support for multiple "power-domains"
config: arm64-randconfig-r003-20230912 (https://download.01.org/0day-ci/archive/20230912/202309122212.MetCn4UK-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230912/202309122212.MetCn4UK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309122212.MetCn4UK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/tiny/simpledrm.c:506:24: warning: flag ' ' results in undefined behavior with 'p' conversion specifier [-Wformat]
     506 |         drm_err(&sdev->dev, "% power-domains count:%d\n", __func__, sdev->pwr_dom_count);
         |                              ~^~
   include/drm/drm_print.h:469:39: note: expanded from macro 'drm_err'
     469 |         __drm_printk((drm), err,, "*ERROR* " fmt, ##__VA_ARGS__)
         |                                              ^~~
   include/drm/drm_print.h:456:41: note: expanded from macro '__drm_printk'
     456 |         dev_##level##type((drm)->dev, "[drm] " fmt, ##__VA_ARGS__)
         |                                                ^~~
   include/linux/dev_printk.h:144:57: note: expanded from macro 'dev_err'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                ^~~
   include/linux/dev_printk.h:19:22: note: expanded from macro 'dev_fmt'
      19 | #define dev_fmt(fmt) fmt
         |                      ^~~
   include/linux/dev_printk.h:110:16: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   1 warning generated.


vim +506 drivers/gpu/drm/tiny/simpledrm.c

   477	
   478	#if defined CONFIG_OF && defined CONFIG_PM_GENERIC_DOMAINS
   479	/*
   480	 * Generic power domain handling code.
   481	 *
   482	 * Here we handle the power-domains properties of our "simple-framebuffer"
   483	 * dt node. This is only necessary if there is more than one power-domain.
   484	 * A single power-domains is handled automatically by the driver core. Multiple
   485	 * power-domains have to be handled by drivers since the driver core can't know
   486	 * the correct power sequencing. Power sequencing is not an issue for simpledrm
   487	 * since the bootloader has put the power domains already in the correct state.
   488	 * simpledrm has only to ensure they remain active for its lifetime.
   489	 *
   490	 * When the driver unloads, we detach from the power-domains.
   491	 *
   492	 * We only complain about errors here, no action is taken as the most likely
   493	 * error can only happen due to a mismatch between the bootloader which set
   494	 * up the "simple-framebuffer" dt node, and the PM domain providers in the
   495	 * device tree. Chances are that there are no adverse effects, and if there are,
   496	 * a clean teardown of the fb probe will not help us much either. So just
   497	 * complain and carry on, and hope that the user actually gets a working fb at
   498	 * the end of things.
   499	 */
   500	static void simpledrm_device_detach_genpd(void *res)
   501	{
   502		int i;
   503		struct simpledrm_device *sdev = /*(struct simpledrm_device *)*/res;
   504	
   505	
 > 506		drm_err(&sdev->dev, "% power-domains count:%d\n", __func__, sdev->pwr_dom_count);
   507		if (sdev->pwr_dom_count <= 1)
   508			return;
   509	
   510		for (i = sdev->pwr_dom_count - 1; i >= 0; i--) {
   511			if (!sdev->pwr_dom_links[i])
   512				device_link_del(sdev->pwr_dom_links[i]);
   513			if (!IS_ERR_OR_NULL(sdev->pwr_dom_devs[i]))
   514				dev_pm_domain_detach(sdev->pwr_dom_devs[i], true);
   515		}
   516	}
   517	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
