Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212DC7EFE1D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 07:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjKRGd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 01:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjKRGdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 01:33:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2682D5D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 22:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700289231; x=1731825231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CifJ4bCTttMoFJ4+KJqxI/k/1BSNMX+SU6KP3cRH6vE=;
  b=SbQZ8ZaTrBpHUqlVJbaC6gZp87A3nOJnsaRIUviqbCqKx5W9nO/7kzZQ
   blGxoBEBms2YAkH9KqlK57wmxKEMkYG1S614QYxyHHswxio5F1MEpppDA
   9X4TPlM7f2poVPE6N+B13bgJZQCq/4rPPAO7KI9uHJjckBRxasuRR9OXh
   emlItxBMEOHmcmuJjO7FB9GDjZi/ExnbTu6G5vcVcnZkZ+hY2wq2YlPFm
   KKux133UcIB9DImiVbmxccLVZ03mKJ9DY2iTuFWkwJUpiFn6a23+pXIiy
   JW9CpJIYK6CpzItw5DVMqteYI2NGyx6AfeXLdY5I4/af1MdYIYFVopi0s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="376458006"
X-IronPort-AV: E=Sophos;i="6.04,207,1695711600"; 
   d="scan'208";a="376458006"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 22:33:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="939350356"
X-IronPort-AV: E=Sophos;i="6.04,207,1695711600"; 
   d="scan'208";a="939350356"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 Nov 2023 22:33:48 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4Etl-0003bT-2w;
        Sat, 18 Nov 2023 06:33:45 +0000
Date:   Sat, 18 Nov 2023 14:33:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     marc.ferland@gmail.com, krzysztof.kozlowski@linaro.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        gregkh@linuxfoundation.org, marc.ferland@sonatest.com,
        jeff.dagenais@gmail.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] w1: ds2433: introduce a configuration structure
Message-ID: <202311181436.TyinUJiw-lkp@intel.com>
References: <20231117192909.98944-4-marc.ferland@sonatest.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117192909.98944-4-marc.ferland@sonatest.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on 7475e51b87969e01a6812eac713a1c8310372e8a]

url:    https://github.com/intel-lab-lkp/linux/commits/marc-ferland-gmail-com/w1-ds2433-add-support-for-registering-multiple-families/20231118-034145
base:   7475e51b87969e01a6812eac713a1c8310372e8a
patch link:    https://lore.kernel.org/r/20231117192909.98944-4-marc.ferland%40sonatest.com
patch subject: [PATCH 4/7] w1: ds2433: introduce a configuration structure
config: hexagon-randconfig-001-20231118 (https://download.01.org/0day-ci/archive/20231118/202311181436.TyinUJiw-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231118/202311181436.TyinUJiw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311181436.TyinUJiw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/w1/slaves/w1_ds2433.c:269:21: error: initializer element is not a compile-time constant
     269 |         .size = config_f23.eeprom_size,
         |                 ~~~~~~~~~~~^~~~~~~~~~~
   1 error generated.


vim +269 drivers/w1/slaves/w1_ds2433.c

   264	
   265	static struct bin_attribute bin_attr_f23_eeprom = {
   266		.attr = { .name = "eeprom", .mode = 0644 },
   267		.read = eeprom_read,
   268		.write = eeprom_write,
 > 269		.size = config_f23.eeprom_size,
   270	};
   271	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
