Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D2878A4B3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 04:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjH1CtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 22:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjH1Cs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 22:48:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995C610E
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 19:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693190936; x=1724726936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MGOQof3/0GwxYRKJJukycYMzoBjUOOyTQDx9zZt6q8s=;
  b=eNNrEOIdOpXwYVhPeDcsfzgs0leDbLcFflKMn1Gr28MN4ln1Pjn7p5OB
   VPgzj04AZ/jg+dsyDwoUGaDglkdO2tWRDuUrDNJL9C+Zts3WlzHFvMOto
   JTkjVQD0YxasR3JxXOfKEDy5TmMIxj50J2Png04eHcKwxh8drugfeRbIX
   CNBMJA5btdclsNqkzfcp0fAg3Ay9zp5QYcdYKV1/lLPYR/5CrVLtPYVKL
   ZmgvEDkOlzNZbTIieUnkrSm70tULg8nthKPICcKT6TwfLTYpYv6fPZtlt
   C+P0gcwx2I2dj8ZSmW5dQKZ/iIrm8wPhuYGS89OFoatZaZBZzfIndXkAE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="359991711"
X-IronPort-AV: E=Sophos;i="6.02,206,1688454000"; 
   d="scan'208";a="359991711"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 19:48:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="984718120"
X-IronPort-AV: E=Sophos;i="6.02,206,1688454000"; 
   d="scan'208";a="984718120"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 27 Aug 2023 19:48:46 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qaSJ3-0006Ql-2J;
        Mon, 28 Aug 2023 02:48:45 +0000
Date:   Mon, 28 Aug 2023 10:48:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oliver Crumrine <ozlinux@hotmail.com>, gregkh@linuxfoundation.org,
        colin.i.king@gmail.com, sumitraartsy@gmail.com,
        u.kleine-koenig@pengutronix.de, geert@linux-m68k.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 6/6] staging: octeon: clean up the octeon ethernet
 driver
Message-ID: <202308281043.2o6mVbgk-lkp@intel.com>
References: <PH7PR11MB764329EC8CFB56ABFA7A8D77BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB764329EC8CFB56ABFA7A8D77BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

kernel test robot noticed the following build warnings:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Oliver-Crumrine/staging-octeon-clean-up-the-octeon-ethernet-driver/20230828-080105
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/PH7PR11MB764329EC8CFB56ABFA7A8D77BCE1A%40PH7PR11MB7643.namprd11.prod.outlook.com
patch subject: [PATCH v3 6/6] staging: octeon: clean up the octeon ethernet driver
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230828/202308281043.2o6mVbgk-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230828/202308281043.2o6mVbgk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308281043.2o6mVbgk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/staging/octeon/ethernet.c: In function 'cvm_oct_common_get_stats':
   drivers/staging/octeon/ethernet.c:204:39: error: storage size of 'rx_status' isn't known
     204 |         struct cvmx_pip_port_status_t rx_status;
         |                                       ^~~~~~~~~
   In file included from include/linux/string.h:254,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from arch/x86/include/asm/paravirt.h:17,
                    from arch/x86/include/asm/irqflags.h:60,
                    from include/linux/irqflags.h:17,
                    from include/linux/rcupdate.h:26,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from drivers/staging/octeon/ethernet.c:8:
>> include/linux/fortify-string.h:515:65: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     515 |         fortify_memset_chk(__fortify_size, p_size, p_size_field),       \
         |                                                                 ^
   include/linux/fortify-string.h:524:25: note: in expansion of macro '__fortify_memset_chk'
     524 | #define memset(p, c, s) __fortify_memset_chk(p, c, s,                   \
         |                         ^~~~~~~~~~~~~~~~~~~~
   drivers/staging/octeon/ethernet.c:211:25: note: in expansion of macro 'memset'
     211 |                         memset(&rx_status, 0, sizeof(rx_status));
         |                         ^~~~~~
>> drivers/staging/octeon/ethernet.c:204:39: warning: unused variable 'rx_status' [-Wunused-variable]
     204 |         struct cvmx_pip_port_status_t rx_status;
         |                                       ^~~~~~~~~


vim +/rx_status +204 drivers/staging/octeon/ethernet.c

   195	
   196	/**
   197	 * cvm_oct_common_get_stats - get the low level ethernet statistics
   198	 * @dev:    Device to get the statistics from
   199	 *
   200	 * Returns Pointer to the statistics
   201	 */
   202	static struct net_device_stats *cvm_oct_common_get_stats(struct net_device *dev)
   203	{
 > 204		struct cvmx_pip_port_status_t rx_status;
   205		cvmx_pko_port_status_t tx_status;
   206		struct octeon_ethernet *priv = netdev_priv(dev);
   207	
   208		if (priv->port < CVMX_PIP_NUM_INPUT_PORTS) {
   209			if (octeon_is_simulation()) {
   210				/* The simulator doesn't support statistics */
   211				memset(&rx_status, 0, sizeof(rx_status));
   212				memset(&tx_status, 0, sizeof(tx_status));
   213			} else {
   214				cvmx_pip_get_port_status(priv->port, 1, &rx_status);
   215				cvmx_pko_get_port_status(priv->port, 1, &tx_status);
   216			}
   217	
   218			dev->stats.rx_packets += rx_status.inb_packets;
   219			dev->stats.tx_packets += tx_status.packets;
   220			dev->stats.rx_bytes += rx_status.inb_octets;
   221			dev->stats.tx_bytes += tx_status.octets;
   222			dev->stats.multicast += rx_status.multicast_packets;
   223			dev->stats.rx_crc_errors += rx_status.inb_errors;
   224			dev->stats.rx_frame_errors += rx_status.fcs_align_err_packets;
   225			dev->stats.rx_dropped += rx_status.dropped_packets;
   226		}
   227	
   228		return &dev->stats;
   229	}
   230	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
