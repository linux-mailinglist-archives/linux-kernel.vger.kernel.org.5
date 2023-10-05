Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1997BAF58
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 01:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjJEXfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 19:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjJEXeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:34:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F150B119;
        Thu,  5 Oct 2023 16:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696548845; x=1728084845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kNlsRW4WFlGXVfge1WJ6meHpmVQjd3H9vQAlCblm87s=;
  b=TmFzloG5ZC30MDcy4w+JXkKfGh7lKE2S3tPFfdeXJT04tEjIC4jezcx8
   xIWpRkbc3UQtR+VuKOURtNk9uXVAa9StSfcWW7DHI8Sx6m3YycjrCk2Dg
   mkRjzkXFgILsw79b0bJgOys2Y7F9aWBfy6GJCOOBhMs7zhwTAPy9lrlx7
   0bfESTvytyu6jLDCPox/1AjufX32xGNBuOhTJSbRntYku6n0OUby6ktJY
   /8QIF8e54T6wrkPefhZbHg+5aehfTkteTOaKvIoKQif1B3FmmOblfXykk
   ieXdq3lX9q2D74YsfIla7ZzwgktGCl6XrY9QnjbmOQoUylIfvOPhduPPz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="373995508"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="373995508"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 16:34:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="822306557"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="822306557"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 05 Oct 2023 16:34:02 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoXqy-000M1c-0y;
        Thu, 05 Oct 2023 23:34:00 +0000
Date:   Fri, 6 Oct 2023 07:33:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     advantech.susiteam@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, wenkai.chung@advantech.com.tw,
        Susi.Driver@advantech.com,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/5] watchdog: eiois200_wdt: Constructing Advantech
 EIO-IS200 watchdog driver
Message-ID: <202310060719.v6gRNpBq-lkp@intel.com>
References: <b627f827d13514c1746beb31bb80db71023e9bb1.1696495372.git.advantech.susiteam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b627f827d13514c1746beb31bb80db71023e9bb1.1696495372.git.advantech.susiteam@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9aab92bc3a8922d4b2e24d10271dfe3034cbf5c2]

url:    https://github.com/intel-lab-lkp/linux/commits/advantech-susiteam-gmail-com/watchdog-eiois200_wdt-Constructing-Advantech-EIO-IS200-watchdog-driver/20231005-231419
base:   9aab92bc3a8922d4b2e24d10271dfe3034cbf5c2
patch link:    https://lore.kernel.org/r/b627f827d13514c1746beb31bb80db71023e9bb1.1696495372.git.advantech.susiteam%40gmail.com
patch subject: [PATCH 1/5] watchdog: eiois200_wdt: Constructing Advantech EIO-IS200 watchdog driver
config: i386-randconfig-003-20231006 (https://download.01.org/0day-ci/archive/20231006/202310060719.v6gRNpBq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231006/202310060719.v6gRNpBq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310060719.v6gRNpBq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/watchdog/eiois200_wdt.c:14:10: fatal error: ../mfd/eiois200.h: No such file or directory
      14 | #include "../mfd/eiois200.h"
         |          ^~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +14 drivers/watchdog/eiois200_wdt.c

    13	
  > 14	#include "../mfd/eiois200.h"
    15	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
