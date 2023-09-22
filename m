Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DE17AB6A6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjIVRAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjIVRAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:00:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC682194;
        Fri, 22 Sep 2023 10:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695402008; x=1726938008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qAO+Fx+7qDGA/k6tiA2MeLOYvaVrb2IJmhjs6tvvbYs=;
  b=QRpTz41Gk1pphxtrc4Bv8y8ZoY+rCe+zHc4jlAeFoL+sbq57p8RCNz2J
   JrpIQsZz42ojiwU4efV/OgHW+wB97K3XghMQzTzbFutFpGU8mwIPEz/Hp
   zcfjaHfGjMSUqRvDVBvL/MTqOZ5WLPrASno9zFSJTzK8htwyp66sqUPz3
   FE5V6PnDBFksGk8dWLlbPLDVOIEyiLq5JVfsWYATv2ykWyx/+Q4eMuPjT
   upoZbTkSmD2I1uwXgXnea07SVD18y9u7gIm5dwCzpfX+WoxoYWYJ4EQtE
   QR5Gk2y/zUX0AnVW67fTNC+Bqt2IjPPRYADQ7OgsBasE8/5VB91XMTl5d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="384720594"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="384720594"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 10:00:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="863022048"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="863022048"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 22 Sep 2023 09:59:59 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjjVV-00012p-2N;
        Fri, 22 Sep 2023 16:59:57 +0000
Date:   Sat, 23 Sep 2023 00:59:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Ober <dober6023@gmail.com>, linux-hwmon@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, corbet@lwn.net, dober@lenovo.com,
        mpearson@lenovo.com, David Ober <dober6023@gmail.com>
Subject: Re: [PATCH] hwmon: add in watchdog for nct6686
Message-ID: <202309230032.aGiDd9Or-lkp@intel.com>
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
[also build test ERROR on linus/master v6.6-rc2 next-20230921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Ober/hwmon-add-in-watchdog-for-nct6686/20230815-195946
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20230815115515.286142-1-dober6023%40gmail.com
patch subject: [PATCH] hwmon: add in watchdog for nct6686
config: csky-randconfig-r026-20230816 (https://download.01.org/0day-ci/archive/20230923/202309230032.aGiDd9Or-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230923/202309230032.aGiDd9Or-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309230032.aGiDd9Or-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/hwmon/nct6683.o: in function `nct6683_probe':
>> nct6683.c:(.text+0x1594): undefined reference to `watchdog_init_timeout'
>> csky-linux-ld: nct6683.c:(.text+0x15fc): undefined reference to `watchdog_init_timeout'
>> csky-linux-ld: nct6683.c:(.text+0x1684): undefined reference to `devm_watchdog_register_device'
   csky-linux-ld: nct6683.c:(.text+0x16a4): undefined reference to `devm_watchdog_register_device'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
