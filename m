Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E345806747
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 07:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376786AbjLFGa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 01:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjLFGaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 01:30:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361271A4;
        Tue,  5 Dec 2023 22:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701844232; x=1733380232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PHvL8DySQS64lFK/MNrATOz4ftqzzReR7jKUSx0+q9A=;
  b=EmcHXCHQYDyeF5K1Ozksr7FHYcDDEikWcIEU1YGHAR/8l0umeaFPU2g/
   CwYUlvUrFUiDnGOMW8LGIunxz5lYzqXnouma9cQqt/7t3hyoheZmvnYqZ
   1WzU7wvn1V9pSAzv40KyhDQrWOhKc5bxphtCrLIQfjoJeCszTCShq5+zY
   zCWeguGCqo3khaWIh5Fqm5tvWymf4XEYsxUKfr4Dv2yYiTrtQbxZmYGOT
   ur43q2HjMJBKBNtM/bBMdcAVxLEfjNLFcabuV2i7D8rlQ0nIRvsFCXTWF
   VQSiCrrxnARRQaoq0M2v8WkZiDvbVRbrLjlzWxbpJ78Az46YZYEu2m8AE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="15564101"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="15564101"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 22:30:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="944537706"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="944537706"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 05 Dec 2023 22:30:28 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAlQJ-000AOQ-0m;
        Wed, 06 Dec 2023 06:30:20 +0000
Date:   Wed, 6 Dec 2023 14:29:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hugo Villeneuve <hugo@hugovil.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, hvilleneuve@dimonoff.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, hugo@hugovil.com,
        stable@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/7] serial: sc16is7xx: fix snprintf format specifier in
 sc16is7xx_regmap_name()
Message-ID: <202312061443.Cknef7Uq-lkp@intel.com>
References: <20231130191050.3165862-2-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130191050.3165862-2-hugo@hugovil.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d804987153e7bedf503f8e4ba649afe52cfd7f6d]

url:    https://github.com/intel-lab-lkp/linux/commits/Hugo-Villeneuve/serial-sc16is7xx-fix-snprintf-format-specifier-in-sc16is7xx_regmap_name/20231201-031413
base:   d804987153e7bedf503f8e4ba649afe52cfd7f6d
patch link:    https://lore.kernel.org/r/20231130191050.3165862-2-hugo%40hugovil.com
patch subject: [PATCH 1/7] serial: sc16is7xx: fix snprintf format specifier in sc16is7xx_regmap_name()
config: x86_64-buildonly-randconfig-001-20231201 (https://download.01.org/0day-ci/archive/20231206/202312061443.Cknef7Uq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312061443.Cknef7Uq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312061443.Cknef7Uq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/tty/serial/sc16is7xx.c: In function 'sc16is7xx_i2c_probe':
>> drivers/tty/serial/sc16is7xx.c:1703:41: warning: '%u' directive output may be truncated writing between 1 and 10 bytes into a region of size 2 [-Wformat-truncation=]
    1703 |         snprintf(buf, sizeof(buf), "port%u", port_id);
         |                                         ^~
   In function 'sc16is7xx_regmap_name',
       inlined from 'sc16is7xx_i2c_probe' at drivers/tty/serial/sc16is7xx.c:1805:17:
   drivers/tty/serial/sc16is7xx.c:1703:36: note: directive argument in the range [0, 4294967294]
    1703 |         snprintf(buf, sizeof(buf), "port%u", port_id);
         |                                    ^~~~~~~~
   drivers/tty/serial/sc16is7xx.c:1703:9: note: 'snprintf' output between 6 and 15 bytes into a destination of size 6
    1703 |         snprintf(buf, sizeof(buf), "port%u", port_id);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +1703 drivers/tty/serial/sc16is7xx.c

  1698	
  1699	static const char *sc16is7xx_regmap_name(unsigned int port_id)
  1700	{
  1701		static char buf[6];
  1702	
> 1703		snprintf(buf, sizeof(buf), "port%u", port_id);
  1704	
  1705		return buf;
  1706	}
  1707	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
