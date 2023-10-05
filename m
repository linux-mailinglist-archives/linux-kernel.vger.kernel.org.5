Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB877B997A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 03:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244268AbjJEBNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 21:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243808AbjJEBNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 21:13:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4899CCE;
        Wed,  4 Oct 2023 18:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696468381; x=1728004381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VVynd+E2oXjDW4eXcmQeX+pxzwLJmpuXmxCEdtwoB5c=;
  b=VXHGi3H6aEouyCzzJbvcQOavccVoRbQQyXH8jPZFoXBlexwJYED9hny3
   +ODQtC0wY9Y6Oy43UzJm+oiTuL3uEmqjD8CheG6otNbi9kE7ZLf6mvhvh
   iwXan6/K6MnTEWup4EUmxCsedK0tEd+QtfVp0mgLhYBCTeVlXaVkMiukX
   9pWpS1c5wSQiO86daqRwLVdCGorsafpjBAfa5iSB7J7exsrEiRx2QmXpH
   bouHpbOMiBIabedEfZsTDL/ZFaIRWw7gdIcw86lyRLBeHC5F2I3X8uTuV
   ewYGqpDT76ewsAHY1SQTVVrY+lqARquuvSt4B/SHrxlz7N/TaSijjUoS3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="387236015"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="387236015"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 18:13:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="745231792"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="745231792"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 04 Oct 2023 18:12:58 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoCum-000Kpc-1g;
        Thu, 05 Oct 2023 01:12:45 +0000
Date:   Thu, 5 Oct 2023 09:11:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shawn Anastasio <sanastasio@raptorengineering.com>,
        devicetree@vger.kernel.org, lee@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Timothy Pearson <tpearson@raptorengineering.com>,
        linux-kernel@vger.kernel.org,
        Georgy Yakovlev <Georgy.Yakovlev@sony.com>,
        Shawn Anastasio <sanastasio@raptorengineering.com>
Subject: Re: [PATCH 3/3] mfd: sie-cronos-cpld: Add driver for SIE cronos CPLD
Message-ID: <202310050807.eDZkgFy5-lkp@intel.com>
References: <2e9763cb4fa258fe11769a4ff1544d96c536a4a2.1696285339.git.sanastasio@raptorengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e9763cb4fa258fe11769a4ff1544d96c536a4a2.1696285339.git.sanastasio@raptorengineering.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lee-mfd/for-mfd-next]
[also build test WARNING on robh/for-next linus/master v6.6-rc4 next-20231004]
[cannot apply to lee-leds/for-leds-next lee-mfd/for-mfd-fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shawn-Anastasio/dt-bindings-mfd-sie-cronos-cpld-Add-initial-DT-binding/20231003-073243
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
patch link:    https://lore.kernel.org/r/2e9763cb4fa258fe11769a4ff1544d96c536a4a2.1696285339.git.sanastasio%40raptorengineering.com
patch subject: [PATCH 3/3] mfd: sie-cronos-cpld: Add driver for SIE cronos CPLD
config: i386-randconfig-063-20231005 (https://download.01.org/0day-ci/archive/20231005/202310050807.eDZkgFy5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231005/202310050807.eDZkgFy5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310050807.eDZkgFy5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mfd/sie-cronos-cpld.c:509:34: warning: 'cronos_cpld_dt_ids' defined but not used [-Wunused-const-variable=]
     509 | static const struct of_device_id cronos_cpld_dt_ids[] = {
         |                                  ^~~~~~~~~~~~~~~~~~


vim +/cronos_cpld_dt_ids +509 drivers/mfd/sie-cronos-cpld.c

   508	
 > 509	static const struct of_device_id cronos_cpld_dt_ids[] = {
   510		{ .compatible = "sie,cronos-cpld", },
   511		{ }
   512	};
   513	MODULE_DEVICE_TABLE(of, cronos_cpld_dt_ids);
   514	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
