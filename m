Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493287A8FE7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 01:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjITXkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 19:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjITXkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 19:40:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19677C9;
        Wed, 20 Sep 2023 16:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695253196; x=1726789196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7rBWAZNkXl0XliJjOhwzouxtCGTxulwG6PXP2zaxTVY=;
  b=CLgMyj7h76D86x8McOwXOOn+SPDEaPb4rzmYQ+KPP0KyVUy/jXHiv0ZV
   xIKF4G2QsjJuSmSdbgh9mJOpp2N1V/Dl5vFQzyvtOKTmBeaHiVMWUSyWQ
   2+GBgwA2OQr5CqgiHoNkpmQVxFt0TkjmIsCx+Zijlb9yoFs4zneMxfraH
   PMLLiy2a3aHNsfKbyHKCXgkGfTSk34zgbwpVL68bvmgvqpKhe2IxYSNwW
   t6qG9QDvqDMHCzm2DLK+RWyS3vZlltgSHBRJbqVfGqo/0rBswaunMm1pB
   yl0gUrHKEKdSie9jG1dBTKhorKZw780k1NPY7DlctHmGTZBrzXmwDprB3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="384209308"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="384209308"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 16:35:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="750146565"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="750146565"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 20 Sep 2023 16:35:26 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qj6j6-0009GO-30;
        Wed, 20 Sep 2023 23:35:24 +0000
Date:   Thu, 21 Sep 2023 07:35:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     oe-kbuild-all@lists.linux.dev,
        David Lechner <dlechner@baylibre.com>,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>
Subject: Re: [PATCH 4/4] iio: resolver: add new driver for AD2S1210
Message-ID: <202309210740.YRdN185w-lkp@intel.com>
References: <20230920170253.203395-5-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920170253.203395-5-dlechner@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.6-rc2 next-20230920]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/dt-bindings-iio-resolver-add-devicetree-bindings-for-ad2s1210/20230921-010529
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20230920170253.203395-5-dlechner%40baylibre.com
patch subject: [PATCH 4/4] iio: resolver: add new driver for AD2S1210
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230921/202309210740.YRdN185w-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230921/202309210740.YRdN185w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309210740.YRdN185w-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/resolver/ad2s1210.c:113: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Writes the given data to the given register address.
   drivers/iio/resolver/ad2s1210.c:151: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Reads value from one of the registers.
   drivers/iio/resolver/ad2s1210.c:201: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Sets the excitation frequency and performs software reset.


vim +113 drivers/iio/resolver/ad2s1210.c

   111	
   112	/**
 > 113	 * Writes the given data to the given register address.
   114	 *
   115	 * If the mode is configurable, the device will first be placed in
   116	 * configuration mode.
   117	 */
   118	static int ad2s1210_regmap_reg_write(void *context, unsigned int reg,
   119					     unsigned int val)
   120	{
   121		struct ad2s1210_state *st = context;
   122		struct spi_transfer xfers[] = {
   123			{
   124				.len = 1,
   125				.rx_buf = &st->rx[0],
   126				.tx_buf = &st->tx[0],
   127				.cs_change = 1,
   128			}, {
   129				.len = 1,
   130				.rx_buf = &st->rx[1],
   131				.tx_buf = &st->tx[1],
   132			},
   133		};
   134		int ret;
   135	
   136		/* values can only be 7 bits, the MSB indicates an address */
   137		if (val & ~0x7F)
   138			return -EINVAL;
   139	
   140		st->tx[0] = reg;
   141		st->tx[1] = val;
   142	
   143		ret = ad2s1210_set_mode(st, AD2S1210_MODE_CONFIG);
   144		if (ret < 0)
   145			return ret;
   146	
   147		return spi_sync_transfer(st->sdev, xfers, ARRAY_SIZE(xfers));
   148	}
   149	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
