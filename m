Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5FD7C6EB0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343971AbjJLNBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343711AbjJLNBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:01:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA70BA;
        Thu, 12 Oct 2023 06:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697115665; x=1728651665;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HlI9nRmiOWzTgfw2KPSLAj7uKfHlFCqpVjECnsGmXrU=;
  b=L3YnvTmbfnVx36DoAxC0eSVewynV8xdpVH3zCzmby74M4eNvzOKvVbS8
   5mI8Je0cJ9HJCOVJivsJVaEifLyM/78qHdJwkU9HNiFgI47YlFTc4u4By
   l76makyHB6z9DyCKulU694t6IcizzgXNNLsWt03Y/HOocF57LQmYCaSMT
   1WGKjNIyUb4p9FY9v6ViGw/q4FSGdtulNKo4Khp1j0A945K4jKnNMo0L/
   bXb0IEWpYh8ac4XoA/Js5sGcLePYBdubb6UBzOmvdYK1d0jpbmx2fmvjF
   YFPcfYd0o8y8ShZzTsq4SZc1bMGTdUf1hsbvXg2VecviqZ7cxvLgLHDUf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="369977417"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="369977417"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 06:01:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="704150482"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="704150482"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 12 Oct 2023 06:01:02 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqvJE-0003SR-0c;
        Thu, 12 Oct 2023 13:01:00 +0000
Date:   Thu, 12 Oct 2023 21:00:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Werner Sembach <wse@tuxedocomputers.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Werner Sembach <wse@tuxedocomputers.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH] leds: rgb: Implement per-key keyboard backlight for
 several TUXEDO devices
Message-ID: <202310122012.C2mSREZ7-lkp@intel.com>
References: <20231011190017.1230898-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011190017.1230898-1-wse@tuxedocomputers.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Werner,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lee-leds/for-leds-next]
[also build test WARNING on linus/master v6.6-rc5 next-20231012]
[cannot apply to pavel-leds/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Werner-Sembach/leds-rgb-Implement-per-key-keyboard-backlight-for-several-TUXEDO-devices/20231012-030206
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git for-leds-next
patch link:    https://lore.kernel.org/r/20231011190017.1230898-1-wse%40tuxedocomputers.com
patch subject: [PATCH] leds: rgb: Implement per-key keyboard backlight for several TUXEDO devices
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20231012/202310122012.C2mSREZ7-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231012/202310122012.C2mSREZ7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310122012.C2mSREZ7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/leds/rgb/leds-tuxedo-ite8291.c:44: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Set color for specified [row, column] in row based data structure
   drivers/leds/rgb/leds-tuxedo-ite8291.c:79: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Just a generic helper function to reduce boilerplate code
   drivers/leds/rgb/leds-tuxedo-ite8291.c:96: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Update brightness of the whole keyboard. Only used for initialization as this doesn't allow per
   drivers/leds/rgb/leds-tuxedo-ite8291.c:116: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Update color of a singular row from row_data. This is the smallest unit this device allows to
   drivers/leds/rgb/leds-tuxedo-ite8291.c:138: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Write color and brightness to the whole keyboard from row data. Note that per key brightness is


vim +44 drivers/leds/rgb/leds-tuxedo-ite8291.c

    42	
    43	/**
  > 44	 * Set color for specified [row, column] in row based data structure
    45	 *
    46	 * @param row_data Data structure to fill
    47	 * @param row Row number 0 - 5
    48	 * @param column Column number 0 - 20
    49	 * @param red Red brightness 0x00 - 0xff
    50	 * @param green Green brightness 0x00 - 0xff
    51	 * @param blue Blue brightness 0x00 - 0xff
    52	 *
    53	 * @returns 0 on success, otherwise error
    54	 */
    55	static int leds_tuxedo_ite8291_set_row_data(row_data_t row_data, int row, int column,
    56						    u8 red, u8 green, u8 blue)
    57	{
    58		int column_index_red, column_index_green, column_index_blue;
    59	
    60		if (row < 0 || row >= LEDS_TUXEDO_ITE8291_ROWS ||
    61		    column < 0 || column >= LEDS_TUXEDO_ITE8291_COLUMNS)
    62			return -EINVAL;
    63	
    64		column_index_red =
    65			LEDS_TUXEDO_ITE8291_ROW_DATA_PADDING + (2 * LEDS_TUXEDO_ITE8291_COLUMNS) + column;
    66		column_index_green =
    67			LEDS_TUXEDO_ITE8291_ROW_DATA_PADDING + (1 * LEDS_TUXEDO_ITE8291_COLUMNS) + column;
    68		column_index_blue =
    69			LEDS_TUXEDO_ITE8291_ROW_DATA_PADDING + (0 * LEDS_TUXEDO_ITE8291_COLUMNS) + column;
    70	
    71		row_data[row][column_index_red] = red;
    72		row_data[row][column_index_green] = green;
    73		row_data[row][column_index_blue] = blue;
    74	
    75		return 0;
    76	}
    77	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
