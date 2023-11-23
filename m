Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D4D7F56F6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 04:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344520AbjKWDRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 22:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344455AbjKWDRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 22:17:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184CF1B6;
        Wed, 22 Nov 2023 19:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700709439; x=1732245439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1c3Mf56cspS0rK0V+e9p5p1VgJgFuCb7pZFxscw0f/Q=;
  b=RxIWG4AP5nErNZ3whJsyLAYUN2FOpCs//PJq0eGYe9nX/XiR2ALvXf3I
   BKaQMnd4ei3NPlvXDPIHb9xa2RwkxVm3yyJE5ZrLlhvUg755jevHK4h4w
   R1d3O5Wyh/AHQ+EOg74bgOHLZAPV/BESrKmf+nPLyHFvF3n0D9FkVgu2W
   x49ISnbwRBTTDSWHKfTh9VFt/se5laj7Tv8Fn/Ciq5c7wZ8VNfkSg9ZUR
   XC+Pn1Y3c13/8n1B5dNsFGvy7I95QblrJxF5e1GAz8V7fR4xcr3gWqKig
   Nk1GT3QVZR+KYo9BNdRihjjLOBCjo9UbNXfGG5aNLlQzEL130aq9a6TAH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="5380205"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="5380205"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 19:17:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="767083290"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="767083290"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Nov 2023 19:17:14 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r60DI-0001Ag-0H;
        Thu, 23 Nov 2023 03:17:12 +0000
Date:   Thu, 23 Nov 2023 11:16:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alain Volmat <alain.volmat@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-media@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Pavel Machek <pavel@ucw.cz>,
        Alain Volmat <alain.volmat@foss.st.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] media: i2c: gc2145: Galaxy Core GC2145 sensor
 support
Message-ID: <202311231047.GzLUXA47-lkp@intel.com>
References: <20231122075154.789431-4-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122075154.789431-4-alain.volmat@foss.st.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain,

kernel test robot noticed the following build errors:

[auto build test ERROR on linuxtv-media-stage/master]
[also build test ERROR on linus/master v6.7-rc2 next-20231122]
[cannot apply to media-tree/master robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alain-Volmat/dt-bindings-vendor-prefixes-Add-prefix-for-GalaxyCore-Inc/20231122-155443
base:   https://git.linuxtv.org/media_stage.git master
patch link:    https://lore.kernel.org/r/20231122075154.789431-4-alain.volmat%40foss.st.com
patch subject: [PATCH v5 3/3] media: i2c: gc2145: Galaxy Core GC2145 sensor support
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231123/202311231047.GzLUXA47-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231123/202311231047.GzLUXA47-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311231047.GzLUXA47-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/media/i2c/gc2145.c:664:11: error: call to undeclared function 'v4l2_subdev_state_get_format'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           format = v4l2_subdev_state_get_format(state, 0);
                    ^
   drivers/media/i2c/gc2145.c:664:9: error: incompatible integer to pointer conversion assigning to 'struct v4l2_mbus_framefmt *' from 'int' [-Wint-conversion]
           format = v4l2_subdev_state_get_format(state, 0);
                  ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/media/i2c/gc2145.c:669:9: error: call to undeclared function 'v4l2_subdev_state_get_crop'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           crop = v4l2_subdev_state_get_crop(state, 0);
                  ^
   drivers/media/i2c/gc2145.c:669:7: error: incompatible integer to pointer conversion assigning to 'struct v4l2_rect *' from 'int' [-Wint-conversion]
           crop = v4l2_subdev_state_get_crop(state, 0);
                ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/gc2145.c:681:13: error: call to undeclared function 'v4l2_subdev_state_get_crop'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   sel->r = *v4l2_subdev_state_get_crop(sd_state, 0);
                             ^
   drivers/media/i2c/gc2145.c:681:12: error: indirection requires pointer operand ('int' invalid)
                   sel->r = *v4l2_subdev_state_get_crop(sd_state, 0);
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/gc2145.c:758:13: error: call to undeclared function 'v4l2_subdev_state_get_format'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           framefmt = v4l2_subdev_state_get_format(sd_state, fmt->pad);
                      ^
   drivers/media/i2c/gc2145.c:758:11: error: incompatible integer to pointer conversion assigning to 'struct v4l2_mbus_framefmt *' from 'int' [-Wint-conversion]
           framefmt = v4l2_subdev_state_get_format(sd_state, fmt->pad);
                    ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/gc2145.c:770:9: error: call to undeclared function 'v4l2_subdev_state_get_crop'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           crop = v4l2_subdev_state_get_crop(sd_state, fmt->pad);
                  ^
   drivers/media/i2c/gc2145.c:770:7: error: incompatible integer to pointer conversion assigning to 'struct v4l2_rect *' from 'int' [-Wint-conversion]
           crop = v4l2_subdev_state_get_crop(sd_state, fmt->pad);
                ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/gc2145.c:874:8: error: call to undeclared function 'v4l2_subdev_state_get_format'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           fmt = v4l2_subdev_state_get_format(state, 0);
                 ^
   drivers/media/i2c/gc2145.c:874:6: error: incompatible integer to pointer conversion assigning to 'struct v4l2_mbus_framefmt *' from 'int' [-Wint-conversion]
           fmt = v4l2_subdev_state_get_format(state, 0);
               ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   12 errors generated.


vim +/v4l2_subdev_state_get_format +664 drivers/media/i2c/gc2145.c

   655	
   656	static int gc2145_init_cfg(struct v4l2_subdev *sd,
   657				   struct v4l2_subdev_state *state)
   658	{
   659		struct gc2145 *gc2145 = to_gc2145(sd);
   660		struct v4l2_mbus_framefmt *format;
   661		struct v4l2_rect *crop;
   662	
   663		/* Initialize pad format */
 > 664		format = v4l2_subdev_state_get_format(state, 0);
   665		gc2145_update_pad_format(gc2145, &supported_modes[0], format,
   666					 MEDIA_BUS_FMT_RGB565_1X16);
   667	
   668		/* Initialize crop rectangle. */
 > 669		crop = v4l2_subdev_state_get_crop(state, 0);
   670		*crop = supported_modes[0].crop;
   671	
   672		return 0;
   673	}
   674	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
