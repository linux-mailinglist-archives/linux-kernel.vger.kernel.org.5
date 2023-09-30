Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640327B3D54
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 02:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjI3Ai0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 20:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjI3AiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 20:38:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1279E5;
        Fri, 29 Sep 2023 17:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696034304; x=1727570304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2WjIR2c1pM2qQHYl9zj7z0Ym8F1m+VHvFFY1MZSzVB4=;
  b=GGW9/UCfRIE+2K7HuweuimdjU6k6yGCEyXtGvlgZBGJyXlhyoZ8fy3uP
   /TyX9IqdeWpfeezN7nHvu6Sstgv+tcg0/p+4fObMyC37gSe6xZSYROCxI
   ONHgurHOyWlOjMGbANDS958COt4V1on1/fMhXBlw6++gYWzeh4ROH8Wr3
   Jl6RSaqaVIFSe+YjOwQJ1AA2zJvxdLlAcXvysRZU9IEZuY9wnWVbidlZ0
   bw8Yn+wVw5h+A2LXFuk3xvakHoxjbglEIQtImmQoHEDm39wUd9Nogq8/K
   EFQTwTNKHdxuaNf9CCS8Icc4z9JT4VxlROyLsyTH5NoknUM589/vTnNxF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="385230908"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="385230908"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 17:38:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="873841640"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="873841640"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 29 Sep 2023 17:38:20 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmNzu-0003Ti-1W;
        Sat, 30 Sep 2023 00:38:18 +0000
Date:   Sat, 30 Sep 2023 08:37:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ivan Mikhaylov <fr0st61te@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: Add driver support for MAX34408/9
Message-ID: <202309300847.Vb7WCpaN-lkp@intel.com>
References: <20230929200844.23316-3-fr0st61te@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929200844.23316-3-fr0st61te@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v6.6-rc3 next-20230929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ivan-Mikhaylov/dt-bindings-adc-provide-max34408-9-device-tree-binding-document/20230930-043842
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20230929200844.23316-3-fr0st61te%40gmail.com
patch subject: [PATCH v2 2/2] iio: adc: Add driver support for MAX34408/9
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230930/202309300847.Vb7WCpaN-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230930/202309300847.Vb7WCpaN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309300847.Vb7WCpaN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/max34408.c:79: warning: Function parameter or member 'input1_rsense' not described in 'max34408_data'
>> drivers/iio/adc/max34408.c:79: warning: Function parameter or member 'input2_rsense' not described in 'max34408_data'
>> drivers/iio/adc/max34408.c:79: warning: Function parameter or member 'input3_rsense' not described in 'max34408_data'
>> drivers/iio/adc/max34408.c:79: warning: Function parameter or member 'input4_rsense' not described in 'max34408_data'


vim +79 drivers/iio/adc/max34408.c

    62	
    63	/**
    64	 * struct max34408_data - max34408/max34409 specific data.
    65	 * @regmap:	device register map.
    66	 * @dev:	max34408 device.
    67	 * @lock:	lock for protecting access to device hardware registers, mostly
    68	 *		for read modify write cycles for control registers.
    69	 * @rsense:	Rsense value in uOhm.
    70	 */
    71	struct max34408_data {
    72		struct regmap *regmap;
    73		struct device *dev;
    74		struct mutex lock;
    75		u32 input1_rsense;
    76		u32 input2_rsense;
    77		u32 input3_rsense;
    78		u32 input4_rsense;
  > 79	};
    80	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
