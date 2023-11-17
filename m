Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B32E7EEB18
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 03:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345623AbjKQCdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 21:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjKQCdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 21:33:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972111A8;
        Thu, 16 Nov 2023 18:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700188408; x=1731724408;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3gLagopNTFrZ+no4RRGv3edWm/bc9IZNOJcKZBnlVV8=;
  b=ahEx1e32vlj2plWVEGOOR75BnhofNUp3fEM6mbIFVTKya6SEqD8GNtUV
   RxaK+U21IKi9UbrTsPfRF9DVWcgfScVT9IDL9b8jQeYS2x1Sgnv4dSQ7T
   wyQcbbUxZtAW8FESGTyxa16/acgh3gv/HgLwSDO1shQBR8cPL4vHkx/Q1
   T/OUKQhIg64c5gmjKNEsUQzbciij1L40VrvA9IZgPbhf8AC27vlD6uW+F
   +TZTJroPFohvADmAjBafNUbPZvVLkZcqc1rf75mq9xzchcTHOgSSt+nxx
   HGpj+c7gkAnF0j3yvlW1n2QbZvxuW1/wbgY52QxavUnwd9U+bSTobD0ck
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="457720617"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="457720617"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 18:33:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="909308544"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="909308544"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 16 Nov 2023 18:33:24 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3ofa-0002I7-1x;
        Fri, 17 Nov 2023 02:33:22 +0000
Date:   Fri, 17 Nov 2023 10:33:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li peiyu <579lpy@gmail.com>, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li peiyu <579lpy@gmail.com>
Subject: Re: [PATCH [1/2]] iio: humidity: Add driver for ti HDC302x humidity
 sensors
Message-ID: <202311171052.IjyxJMuw-lkp@intel.com>
References: <20231116125805.13466-1-579lpy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116125805.13466-1-579lpy@gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.7-rc1 next-20231116]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-peiyu/iio-humidity-Add-driver-for-ti-HDC302x-humidity-sensors/20231116-210050
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20231116125805.13466-1-579lpy%40gmail.com
patch subject: [PATCH [1/2]] iio: humidity: Add driver for ti HDC302x humidity sensors
config: x86_64-randconfig-r111-20231117 (https://download.01.org/0day-ci/archive/20231117/202311171052.IjyxJMuw-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231117/202311171052.IjyxJMuw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311171052.IjyxJMuw-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/humidity/hdc3020.c:23:10: sparse: sparse: symbol 'HDC3020_S_AUTO_10HZ_MOD0' was not declared. Should it be static?
>> drivers/iio/humidity/hdc3020.c:25:10: sparse: sparse: symbol 'HDC3020_EXIT_AUTO' was not declared. Should it be static?
>> drivers/iio/humidity/hdc3020.c:27:10: sparse: sparse: symbol 'HDC3020_R_T_RH_AUTO' was not declared. Should it be static?
>> drivers/iio/humidity/hdc3020.c:28:10: sparse: sparse: symbol 'HDC3020_R_T_LOW_AUTO' was not declared. Should it be static?
>> drivers/iio/humidity/hdc3020.c:29:10: sparse: sparse: symbol 'HDC3020_R_T_HIGH_AUTO' was not declared. Should it be static?
>> drivers/iio/humidity/hdc3020.c:30:10: sparse: sparse: symbol 'HDC3020_R_RH_LOW_AUTO' was not declared. Should it be static?
>> drivers/iio/humidity/hdc3020.c:31:10: sparse: sparse: symbol 'HDC3020_R_RH_HIGH_AUTO' was not declared. Should it be static?
>> drivers/iio/humidity/hdc3020.c:33:10: sparse: sparse: symbol 'HDC3020_ENABLE_HEATER' was not declared. Should it be static?
>> drivers/iio/humidity/hdc3020.c:34:10: sparse: sparse: symbol 'HDC3020_DISABLE_HEATER' was not declared. Should it be static?
>> drivers/iio/humidity/hdc3020.c:36:10: sparse: sparse: symbol 'HDC3020_HEATER_FULL' was not declared. Should it be static?
>> drivers/iio/humidity/hdc3020.c:37:10: sparse: sparse: symbol 'HDC3020_HEATER_HALF' was not declared. Should it be static?
>> drivers/iio/humidity/hdc3020.c:38:10: sparse: sparse: symbol 'HDC3020_HEATER_QUARTER' was not declared. Should it be static?

vim +/HDC3020_S_AUTO_10HZ_MOD0 +23 drivers/iio/humidity/hdc3020.c

    22	
  > 23	const u8 HDC3020_S_AUTO_10HZ_MOD0[2] = { 0x27, 0x37 };
    24	
  > 25	const u8 HDC3020_EXIT_AUTO[2] = { 0x30, 0x93 };
    26	
  > 27	const u8 HDC3020_R_T_RH_AUTO[2] = { 0xE0, 0x00 };
  > 28	const u8 HDC3020_R_T_LOW_AUTO[2] = { 0xE0, 0x02 };
  > 29	const u8 HDC3020_R_T_HIGH_AUTO[2] = { 0xE0, 0x03 };
  > 30	const u8 HDC3020_R_RH_LOW_AUTO[2] = { 0xE0, 0x04 };
  > 31	const u8 HDC3020_R_RH_HIGH_AUTO[2] = { 0xE0, 0x05 };
    32	
  > 33	const u8 HDC3020_ENABLE_HEATER[2] = { 0x30, 0x6D };
  > 34	const u8 HDC3020_DISABLE_HEATER[2] = { 0x30, 0x66 };
    35	
  > 36	const u8 HDC3020_HEATER_FULL[5] = { 0x30, 0x6E, 0x3F, 0xFF, 0x06 };
  > 37	const u8 HDC3020_HEATER_HALF[5] = { 0x30, 0x6E, 0x03, 0xFF, 0x00 };
  > 38	const u8 HDC3020_HEATER_QUARTER[5] = { 0x30, 0x6E, 0x00, 0x9F, 0x96 };
    39	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
