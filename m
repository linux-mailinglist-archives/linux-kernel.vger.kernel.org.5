Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792FD7F5634
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 02:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjKWBze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 20:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344398AbjKWBzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 20:55:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8AED42;
        Wed, 22 Nov 2023 17:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700704513; x=1732240513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AZJ271P9oq4wW/F8qserHlPAU235ACCRwStgacxDnBY=;
  b=bjP28GuP8q3C/8ocg3UkRVZ28DBeLO0ix0L8pbTG8MuyOyfXQN9JH+YA
   AaYjk8JC4B5ntBv36TobMvjndouJtGFCa4QjVSa7/47qDfvHZw3WH7rT/
   BqAMe2xliwxgHZBSFs5OQxngAodchByC5fajQpm5l96CT9H1bzA32qAiT
   ib0f7w/tn6duTBpkTvHsLmoGpO+I3NmR1f/M0ENYCEHEprMONiT9wPfXx
   +EEQL+dluRDrVbCkuKpIUeVf35aS26kc3+4nQRNY50J22VGalAttzu1G7
   9wnxtH56Z7L3uwhZ+cKUyszisuNj4IQ8rNu9L6Ls9ZhXHmmWGbaBOI7NR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="13737178"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="13737178"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 17:55:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="801909594"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="801909594"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Nov 2023 17:55:09 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5yvr-00016F-0h;
        Thu, 23 Nov 2023 01:55:07 +0000
Date:   Thu, 23 Nov 2023 09:54:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alain Volmat <alain.volmat@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Pavel Machek <pavel@ucw.cz>,
        Alain Volmat <alain.volmat@foss.st.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] media: i2c: gc2145: Galaxy Core GC2145 sensor
 support
Message-ID: <202311230621.ATIDPgtm-lkp@intel.com>
References: <20231122075154.789431-4-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122075154.789431-4-alain.volmat@foss.st.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231123/202311230621.ATIDPgtm-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231123/202311230621.ATIDPgtm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311230621.ATIDPgtm-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/media/i2c/gc2145.c: In function 'gc2145_init_cfg':
>> drivers/media/i2c/gc2145.c:664:18: error: implicit declaration of function 'v4l2_subdev_state_get_format'; did you mean 'v4l2_subdev_state_get_stream_format'? [-Werror=implicit-function-declaration]
     664 |         format = v4l2_subdev_state_get_format(state, 0);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                  v4l2_subdev_state_get_stream_format
   drivers/media/i2c/gc2145.c:664:16: warning: assignment to 'struct v4l2_mbus_framefmt *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     664 |         format = v4l2_subdev_state_get_format(state, 0);
         |                ^
>> drivers/media/i2c/gc2145.c:669:16: error: implicit declaration of function 'v4l2_subdev_state_get_crop'; did you mean 'v4l2_subdev_state_get_stream_crop'? [-Werror=implicit-function-declaration]
     669 |         crop = v4l2_subdev_state_get_crop(state, 0);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                v4l2_subdev_state_get_stream_crop
   drivers/media/i2c/gc2145.c:669:14: warning: assignment to 'struct v4l2_rect *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     669 |         crop = v4l2_subdev_state_get_crop(state, 0);
         |              ^
   drivers/media/i2c/gc2145.c: In function 'gc2145_get_selection':
   drivers/media/i2c/gc2145.c:681:26: error: invalid type argument of unary '*' (have 'int')
     681 |                 sel->r = *v4l2_subdev_state_get_crop(sd_state, 0);
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/gc2145.c: In function 'gc2145_set_pad_format':
   drivers/media/i2c/gc2145.c:758:18: warning: assignment to 'struct v4l2_mbus_framefmt *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     758 |         framefmt = v4l2_subdev_state_get_format(sd_state, fmt->pad);
         |                  ^
   drivers/media/i2c/gc2145.c:770:14: warning: assignment to 'struct v4l2_rect *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     770 |         crop = v4l2_subdev_state_get_crop(sd_state, fmt->pad);
         |              ^
   drivers/media/i2c/gc2145.c: In function 'gc2145_start_streaming':
   drivers/media/i2c/gc2145.c:874:13: warning: assignment to 'struct v4l2_mbus_framefmt *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     874 |         fmt = v4l2_subdev_state_get_format(state, 0);
         |             ^
   cc1: some warnings being treated as errors


vim +664 drivers/media/i2c/gc2145.c

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
