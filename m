Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EDB7D1AA9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 05:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjJUDmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 23:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJUDmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 23:42:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71392D76;
        Fri, 20 Oct 2023 20:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697859768; x=1729395768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8PNS9IwLu/TMYdHnEZRKjglbKlVyBvxRYtzA2v+FvTs=;
  b=OYJNHGdjDY2uQiHI8RUMRE96033TPKS43bG7HrdlZVc9Uj9Khx8+0xOQ
   BZBHufg2v1/Y1BFIZ2thkU3zva7Ayd4Q1YfRRyaMiBhrDCOPfy3Rj2jrp
   IRaC9TcKyHfJrVQMnmUKEglAfBIYeDoTO5feQho+bLYhhLFyx7SbMoBae
   L9ZZrb43oORBr1QsxXchuLO1Pk+CCyDAe9d2pImo1orAS1r2/XQu9rRbG
   1agwxgzBq/BZzMHPuGfr7pUE0T493Shm9rQfQp8iETqrS8xPsRzHdMmuK
   LEFGnjNg9nURigYqH4S5tp657aQpt1+yk97N3pQ1hJjxTE/Q9+ra7q6r1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="371676306"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="371676306"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 20:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="881243647"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="881243647"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Oct 2023 20:42:45 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qu2st-0004LK-1q;
        Sat, 21 Oct 2023 03:42:43 +0000
Date:   Sat, 21 Oct 2023 11:42:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mhi@lists.linux.dev
Cc:     oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH] bus: mhi: ep: Add support for interrupt moderation timer
Message-ID: <202310211125.dCDfH087-lkp@intel.com>
References: <20231019080911.57938-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019080911.57938-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manivannan,

kernel test robot noticed the following build errors:

[auto build test ERROR on mani-mhi/mhi-next]
[also build test ERROR on linus/master v6.6-rc6 next-20231020]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam/bus-mhi-ep-Add-support-for-interrupt-moderation-timer/20231019-161023
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git mhi-next
patch link:    https://lore.kernel.org/r/20231019080911.57938-1-manivannan.sadhasivam%40linaro.org
patch subject: [PATCH] bus: mhi: ep: Add support for interrupt moderation timer
config: x86_64-buildonly-randconfig-003-20231021 (https://download.01.org/0day-ci/archive/20231021/202310211125.dCDfH087-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231021/202310211125.dCDfH087-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310211125.dCDfH087-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/bus/mhi/ep/main.c: In function 'mhi_ep_send_event':
>> drivers/bus/mhi/ep/main.c:71:52: error: 'struct mhi_ep_ring' has no member named 'intmod_work'; did you mean 'intmodt_work'?
      71 |                         cancel_delayed_work(&ring->intmod_work);
         |                                                    ^~~~~~~~~~~
         |                                                    intmodt_work
   drivers/bus/mhi/ep/main.c:76:46: error: 'struct mhi_ep_ring' has no member named 'intmod_work'; did you mean 'intmodt_work'?
      76 |                 schedule_delayed_work(&ring->intmod_work, msecs_to_jiffies(ring->intmodt));
         |                                              ^~~~~~~~~~~
         |                                              intmodt_work

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for VIDEO_OV7670
   Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
   Selected by [y]:
   - VIDEO_CAFE_CCIC [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && PCI [=y] && I2C [=y] && VIDEO_DEV [=y] && COMMON_CLK [=y]


vim +71 drivers/bus/mhi/ep/main.c

    27	
    28	static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 ring_idx,
    29				     struct mhi_ring_element *el, bool bei)
    30	{
    31		struct device *dev = &mhi_cntrl->mhi_dev->dev;
    32		union mhi_ep_ring_ctx *ctx;
    33		struct mhi_ep_ring *ring;
    34		int ret;
    35	
    36		mutex_lock(&mhi_cntrl->event_lock);
    37		ring = &mhi_cntrl->mhi_event[ring_idx].ring;
    38		ctx = (union mhi_ep_ring_ctx *)&mhi_cntrl->ev_ctx_cache[ring_idx];
    39		if (!ring->started) {
    40			ret = mhi_ep_ring_start(mhi_cntrl, ring, ctx);
    41			if (ret) {
    42				dev_err(dev, "Error starting event ring (%u)\n", ring_idx);
    43				goto err_unlock;
    44			}
    45		}
    46	
    47		/* Add element to the event ring */
    48		ret = mhi_ep_ring_add_element(ring, el);
    49		if (ret) {
    50			dev_err(dev, "Error adding element to event ring (%u)\n", ring_idx);
    51			goto err_unlock;
    52		}
    53	
    54		mutex_unlock(&mhi_cntrl->event_lock);
    55	
    56		/*
    57		 * As per the MHI specification, section 4.3, Interrupt moderation:
    58		 *
    59		 * 1. If BEI flag is not set, cancel any pending intmodt work if started
    60		 * for the event ring and raise IRQ immediately.
    61		 *
    62		 * 2. If both BEI and intmodt are set, and if no IRQ is pending for the
    63		 * same event ring, start the IRQ delayed work as per the value of
    64		 * intmodt. If previous IRQ is pending, then do nothing as the pending
    65		 * IRQ is enough for the host to process the current event ring element.
    66		 *
    67		 * 3. If BEI is set and intmodt is not set, no need to raise IRQ.
    68		 */
    69		if (!bei) {
    70			if (READ_ONCE(ring->irq_pending))
  > 71				cancel_delayed_work(&ring->intmod_work);
    72	
    73			mhi_cntrl->raise_irq(mhi_cntrl, ring->irq_vector);
    74		} else if (ring->intmodt && !READ_ONCE(ring->irq_pending)) {
    75			WRITE_ONCE(ring->irq_pending, true);
    76			schedule_delayed_work(&ring->intmod_work, msecs_to_jiffies(ring->intmodt));
    77		}
    78	
    79		return 0;
    80	
    81	err_unlock:
    82		mutex_unlock(&mhi_cntrl->event_lock);
    83	
    84		return ret;
    85	}
    86	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
