Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0882C7C04E7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343656AbjJJTrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbjJJTrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:47:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D918E94;
        Tue, 10 Oct 2023 12:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696967224; x=1728503224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VPrHXiQm5RWmzzSVo8j3cx+9+CzFPY38DEadQdbhtyk=;
  b=bVmA5KCuI4r9UWMM5uGgyyx2F7VJlQJLuadnfAAhbgqN3wKOwGFkX2KZ
   BRUwxfT34A3FMIvurzu0dKSbtdTMlTAGtqRXkXYUldRMgyfjS8WkJnjYa
   8hDyzjym6LM5Hd5rsWMnro5adPtLUb0MlHjra0xiNdt/dzClsCoDEfXM7
   j2zzxmBDsFS6FSTLfMWtzN2Jb0oKZuyOKEgNeCkwpDID6oMavZDT+naFU
   U4Ugo9aVwXZn5Ga6tYtw+DfO6jMa17+hnOlxWUJk+Ndyq4tiqBSZcBB39
   n1uQaPLKsDOzeUdgkSpf8DK2q7snwzcWWRjqwbJ6/w2B+OoCJvQ5EDpNO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="381744444"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="381744444"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 12:47:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="897330864"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="897330864"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 10 Oct 2023 12:45:17 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqIgp-0000zo-1T;
        Tue, 10 Oct 2023 19:46:50 +0000
Date:   Wed, 11 Oct 2023 03:45:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, ezequiel@vanguardiasur.com.ar
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com, paul.kocialkowski@bootlin.com,
        Mehdi Djait <mehdi.djait@bootlin.com>
Subject: Re: [PATCH v7 2/3] media: rockchip: Add a driver for Rockhip's
 camera interface
Message-ID: <202310110303.xXSwhz1o-lkp@intel.com>
References: <d5f301fe2b72f90aff357b3b6b4de77939f5248d.1696943295.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5f301fe2b72f90aff357b3b6b4de77939f5248d.1696943295.git.mehdi.djait@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mehdi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on linus/master v6.6-rc5 next-20231010]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mehdi-Djait/media-dt-bindings-media-add-bindings-for-Rockchip-VIP/20231010-211703
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/d5f301fe2b72f90aff357b3b6b4de77939f5248d.1696943295.git.mehdi.djait%40bootlin.com
patch subject: [PATCH v7 2/3] media: rockchip: Add a driver for Rockhip's camera interface
config: microblaze-allyesconfig (https://download.01.org/0day-ci/archive/20231011/202310110303.xXSwhz1o-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231011/202310110303.xXSwhz1o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310110303.xXSwhz1o-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/media/platform/rockchip/vip/capture.c: In function 'rk_vip_irq_pingpong':
>> drivers/media/platform/rockchip/vip/capture.c:1134:13: warning: unused variable 'ret' [-Wunused-variable]
    1134 |         int ret;
         |             ^~~


vim +/ret +1134 drivers/media/platform/rockchip/vip/capture.c

  1127	
  1128	irqreturn_t rk_vip_irq_pingpong(int irq, void *ctx)
  1129	{
  1130		struct device *dev = ctx;
  1131		struct rk_vip_device *vip_dev = dev_get_drvdata(dev);
  1132		struct rk_vip_stream *stream = &vip_dev->stream;
  1133		void __iomem *base = vip_dev->base_addr;
> 1134		int ret;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
