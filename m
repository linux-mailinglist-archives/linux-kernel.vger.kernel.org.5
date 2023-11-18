Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232437F0302
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 22:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjKRVfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 16:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjKRVft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 16:35:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EA9E0;
        Sat, 18 Nov 2023 13:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700343345; x=1731879345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LJXjOb+KewYsrTEUlJCa92ls1KMHSAnBn81gLT7ZRXk=;
  b=TqIbyDZh8XOb+gOjP4cuz0Rafzg9UR6C2KPvlc2sSAq0aQVRKhoUireP
   GGvZo7HyPWYrCT+YlP1Jtd6N1dnrNjFVHw2s7v2n6x45QdhJnPVrtFuJk
   axVoI2CIbC/KCujgzHvvU2HVA3E6/iMrKHlvVz1R400YKWlceswMsaqiS
   vhNwujeKLnamAFDHN97Ne83u01yj/1d0u3zSaCyuNZ+bkr33IaFmSKb97
   FZZd4sKc2rOV8jaLReHVmN0axJT2Ie2FYxxFpbzJn3VEb+9tr3qM8QFBU
   aCyx9asVbRFf8AlVRf15DetnNWQnr5j0eLOksXI9S5f+91eJ1mPw1m35H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="388604876"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="388604876"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 13:35:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="14219335"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 18 Nov 2023 13:35:42 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4SyZ-0004Jj-1Q;
        Sat, 18 Nov 2023 21:35:39 +0000
Date:   Sun, 19 Nov 2023 05:35:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com, paul.kocialkowski@bootlin.com,
        michael.riesch@wolfvision.net,
        Mehdi Djait <mehdi.djait@bootlin.com>
Subject: Re: [PATCH v11 2/3] media: rockchip: Add a driver for Rockchip's
 camera interface
Message-ID: <202311190502.W5r6jlfH-lkp@intel.com>
References: <db605935ad21c4780b73db87605b52d30bc936a4.1700132457.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db605935ad21c4780b73db87605b52d30bc936a4.1700132457.git.mehdi.djait@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mehdi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on linuxtv-media-stage/master robh/for-next linus/master v6.7-rc1 next-20231117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mehdi-Djait/media-dt-bindings-media-add-bindings-for-Rockchip-CIF/20231116-190910
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/db605935ad21c4780b73db87605b52d30bc936a4.1700132457.git.mehdi.djait%40bootlin.com
patch subject: [PATCH v11 2/3] media: rockchip: Add a driver for Rockchip's camera interface
config: x86_64-kismet-CONFIG_VIDEO_V4L2_SUBDEV_API-CONFIG_VIDEO_ROCKCHIP_CIF-0-0 (https://download.01.org/0day-ci/archive/20231119/202311190502.W5r6jlfH-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20231119/202311190502.W5r6jlfH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311190502.W5r6jlfH-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for VIDEO_V4L2_SUBDEV_API when selected by VIDEO_ROCKCHIP_CIF
   
   WARNING: unmet direct dependencies detected for VIDEO_V4L2_SUBDEV_API
     Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && MEDIA_CONTROLLER [=n]
     Selected by [y]:
     - VIDEO_ROCKCHIP_CIF [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && VIDEO_DEV [=y] && (ARCH_ROCKCHIP || COMPILE_TEST [=y]) && V4L_PLATFORM_DRIVERS [=y] && PM [=y] && COMMON_CLK [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
