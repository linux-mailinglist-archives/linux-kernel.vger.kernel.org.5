Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01C177FAB0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353173AbjHQP0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353174AbjHQPZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:25:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84837E56
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692285943; x=1723821943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dv1rWAggk6QsneHzEIlpHOBsevb6HNOlpyXK3ZrSojM=;
  b=jFyW2xuwnHXE7dgHiawWiiDVoG6byTOH7cY3Wh7kursmGoEO2DlIEO5U
   vc30ST80ZixKLUrYpIByszysfiEF8ccIJtV17mCrEHHkrB0jW5MSiSx51
   6Fyvp4m8mrQ6GcRius45OHHcPNaVVGmUhfrG2TYSNiUa3/JPKd/p21261
   t6k1NyltuZMt0VgtMLdT2HYNiCOBMp/bwvQdFFl+dmH5wSxToKBPDINzu
   TepR2NjL7NEVunIJgXHGoN2HMrplAbhpmK5N7BUce7k4xr+17l3aa+g6k
   bmn09ML9g3lAFUy1Y8hQoOgboCODhYOJ1G69JLM8UogFJi+VOYhsvRL0V
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="372832654"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="372832654"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 08:25:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="728175525"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="728175525"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 17 Aug 2023 08:25:22 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWesD-0001Gs-0v;
        Thu, 17 Aug 2023 15:25:21 +0000
Date:   Thu, 17 Aug 2023 23:24:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manikandan Muralidharan <manikandan.m@microchip.com>,
        sam@ravnborg.org, bbrezillon@kernel.org, airlied@gmail.com,
        daniel@ffwll.ch, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, lee@kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Balakrishnan.S@microchip.com, Nayabbasha.Sayed@microchip.com,
        Balamanikandan.Gunasundar@microchip.com,
        Manikandan Muralidharan <manikandan.m@microchip.com>,
        Varshini.Rajendran@microchip.com, Dharma.B@microchip.com,
        Durai Manickam KR <durai.manickamkr@microchip.com>,
        Hari.PrasathGE@microchip.com
Subject: Re: [PATCH v3 5/8] drm: atmel_hlcdc: Add support for XLCDC in atmel
 LCD driver
Message-ID: <202308172303.AgUIhGKY-lkp@intel.com>
References: <20230817091250.225512-6-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817091250.225512-6-manikandan.m@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manikandan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on lee-mfd/for-mfd-next lee-leds/for-leds-next lee-mfd/for-mfd-fixes linus/master v6.5-rc6 next-20230817]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manikandan-Muralidharan/mfd-atmel-hlcdc-Add-compatible-for-sam9x75-XLCD-controller/20230817-172003
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20230817091250.225512-6-manikandan.m%40microchip.com
patch subject: [PATCH v3 5/8] drm: atmel_hlcdc: Add support for XLCDC in atmel LCD driver
config: arm-randconfig-r046-20230817 (https://download.01.org/0day-ci/archive/20230817/202308172303.AgUIhGKY-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308172303.AgUIhGKY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308172303.AgUIhGKY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c:1013:6: warning: no previous prototype for function 'hlcdc_irq_dbg' [-Wmissing-prototypes]
    1013 | void hlcdc_irq_dbg(struct atmel_hlcdc_plane *plane,
         |      ^
   drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c:1013:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1013 | void hlcdc_irq_dbg(struct atmel_hlcdc_plane *plane,
         | ^
         | static 
>> drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c:1029:6: warning: no previous prototype for function 'xlcdc_irq_dbg' [-Wmissing-prototypes]
    1029 | void xlcdc_irq_dbg(struct atmel_hlcdc_plane *plane,
         |      ^
   drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c:1029:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1029 | void xlcdc_irq_dbg(struct atmel_hlcdc_plane *plane,
         | ^
         | static 
   2 warnings generated.


vim +/hlcdc_irq_dbg +1013 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c

  1012	
> 1013	void hlcdc_irq_dbg(struct atmel_hlcdc_plane *plane,
  1014			   const struct atmel_hlcdc_layer_desc *desc)
  1015	{
  1016		u32 isr = atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_ISR);
  1017	
  1018		/*
  1019		 * There's not much we can do in case of overrun except informing
  1020		 * the user. However, we are in interrupt context here, hence the
  1021		 * use of dev_dbg().
  1022		 */
  1023		if (isr &
  1024		    (ATMEL_HLCDC_LAYER_OVR_IRQ(0) | ATMEL_HLCDC_LAYER_OVR_IRQ(1) |
  1025		     ATMEL_HLCDC_LAYER_OVR_IRQ(2)))
  1026			pr_warn("%s: overrun on plane %s\n", __func__, desc->name);
  1027	}
  1028	
> 1029	void xlcdc_irq_dbg(struct atmel_hlcdc_plane *plane,
  1030			   const struct atmel_hlcdc_layer_desc *desc)
  1031	{
  1032		u32 isr = atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_XLCDC_LAYER_ISR);
  1033	
  1034		/*
  1035		 * There's not much we can do in case of overrun except informing
  1036		 * the user. However, we are in interrupt context here, hence the
  1037		 * use of dev_dbg().
  1038		 */
  1039		if (isr &
  1040		    (ATMEL_XLCDC_LAYER_OVR_IRQ(0) | ATMEL_XLCDC_LAYER_OVR_IRQ(1) |
  1041		     ATMEL_XLCDC_LAYER_OVR_IRQ(2)))
  1042			pr_warn("%s: overrun on plane %s\n", __func__, desc->name);
  1043	}
  1044	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
