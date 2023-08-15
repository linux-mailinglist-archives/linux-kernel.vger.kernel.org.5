Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C3477CFD2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbjHOQBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238485AbjHOQAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:00:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDF9127;
        Tue, 15 Aug 2023 09:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692115250; x=1723651250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s1vDqhBD78d5dFi8FLwZ+C7F8GGkuDRSb/H+ET+fVig=;
  b=DOlaJII4ci7JoWaqo4yUWjLAi7GaX8GbUJZYnCEAjbQ9D+Me6eE2+AWT
   YLS4iK0Znry9yJb5YedheONjOTGL1iR66q3UG9t09cyjhOzTaFDocKOy3
   eIb800NOn+WCmUBpYI81N/YmFYRV/4zxOXFqoynPcdTjZYKgBCJLsmK0D
   LtBxsjMv74akdNbL4Nup74uLhxvFsdvOXtiCo3ytwbm4uNpq9bduyYPXo
   nDhBjRm+i624Yu86wdxR7v880fqNczyv6bFHsFoE0xU+UAs2dwP7MVpAH
   xQTEppiaRMQhObGHhFyeUUaLIOFVohSL3ioFqTwfGSi/9REKUqcmDv7jg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="376043584"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="376043584"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 09:00:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="1064511283"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="1064511283"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 15 Aug 2023 09:00:47 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVwSh-00014X-0w;
        Tue, 15 Aug 2023 16:00:17 +0000
Date:   Tue, 15 Aug 2023 23:58:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Ober <dober6023@gmail.com>, linux-hwmon@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        dober@lenovo.com, mpearson@lenovo.com,
        David Ober <dober6023@gmail.com>
Subject: Re: [PATCH] hwmon: add in watchdog for nct6686
Message-ID: <202308152354.OmOTyX2r-lkp@intel.com>
References: <20230815115515.286142-1-dober6023@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815115515.286142-1-dober6023@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on linus/master v6.5-rc6 next-20230815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Ober/hwmon-add-in-watchdog-for-nct6686/20230815-195946
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20230815115515.286142-1-dober6023%40gmail.com
patch subject: [PATCH] hwmon: add in watchdog for nct6686
config: x86_64-randconfig-r006-20230815 (https://download.01.org/0day-ci/archive/20230815/202308152354.OmOTyX2r-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230815/202308152354.OmOTyX2r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308152354.OmOTyX2r-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: watchdog_init_timeout
   >>> referenced by nct6683.c:1514 (drivers/hwmon/nct6683.c:1514)
   >>>               drivers/hwmon/nct6683.o:(nct6683_probe) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: devm_watchdog_register_device
   >>> referenced by nct6683.c:1524 (drivers/hwmon/nct6683.c:1524)
   >>>               drivers/hwmon/nct6683.o:(nct6683_probe) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
