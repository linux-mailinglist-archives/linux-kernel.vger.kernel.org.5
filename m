Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E384E77FA7F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353006AbjHQPPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353016AbjHQPOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:14:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650D2106
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692285271; x=1723821271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1hndQl9W6c/sH31dXMVTwUkTb63Rp/C/PF9sphtZ5VU=;
  b=Qj5bPUXfk+QzPuDetoUFv4K+AWzeoqwIEB21CxpFzw+GHgLvLvAChxqe
   Ru6aeG8mP1f7a+IwFpT9dac1NCn9xoisqZbTg1mF6Ejo3aASri32v5cPd
   r5COvQEFVGv6INWPGkakqQKkw8rkZMN3mJoDmOEDF4urEVgWLMfnUE8AW
   ycoj6e4VIgRmEsT2xVJWh02E2VPh4migb6Jss/FJdRh2myRHhWhMWKFju
   4DSVnf7qKG5vcZ2SfnWK+WQpjXtCIpPGpWhh9gxxYpfUVzTue62odSYVr
   FNsZhDwi5NvI2r9ftqzw6pY4pWjvG22GUMPFfQrnwx0MfD/3LekQX4dXc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="439215583"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="439215583"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 08:14:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="908426946"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="908426946"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 Aug 2023 08:14:21 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWehY-0001Fx-0h;
        Thu, 17 Aug 2023 15:14:20 +0000
Date:   Thu, 17 Aug 2023 23:13:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manikandan Muralidharan <manikandan.m@microchip.com>,
        sam@ravnborg.org, bbrezillon@kernel.org, airlied@gmail.com,
        daniel@ffwll.ch, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, lee@kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Balakrishnan.S@microchip.com,
        Nayabbasha.Sayed@microchip.com,
        Balamanikandan.Gunasundar@microchip.com,
        Manikandan Muralidharan <manikandan.m@microchip.com>,
        Varshini.Rajendran@microchip.com, Dharma.B@microchip.com,
        Durai Manickam KR <durai.manickamkr@microchip.com>,
        Hari.PrasathGE@microchip.com
Subject: Re: [PATCH v3 5/8] drm: atmel_hlcdc: Add support for XLCDC in atmel
 LCD driver
Message-ID: <202308172209.DZ2HgtVa-lkp@intel.com>
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
config: arm-randconfig-r033-20230817 (https://download.01.org/0day-ci/archive/20230817/202308172209.DZ2HgtVa-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308172209.DZ2HgtVa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308172209.DZ2HgtVa-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c:1013:6: warning: no previous prototype for 'hlcdc_irq_dbg' [-Wmissing-prototypes]
    1013 | void hlcdc_irq_dbg(struct atmel_hlcdc_plane *plane,
         |      ^~~~~~~~~~~~~
>> drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c:1029:6: warning: no previous prototype for 'xlcdc_irq_dbg' [-Wmissing-prototypes]
    1029 | void xlcdc_irq_dbg(struct atmel_hlcdc_plane *plane,
         |      ^~~~~~~~~~~~~


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
