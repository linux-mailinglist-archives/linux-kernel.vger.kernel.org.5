Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48FF776741
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjHIS3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHIS3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:29:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C3B1BCF;
        Wed,  9 Aug 2023 11:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691605785; x=1723141785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aLuIdV6iSRzzxVlGj1OxKR40f9V9S3igWYxrpOIqEko=;
  b=Epsg/UDNV0ZFmBh9gNE9DDjbJfN24eOtlpX6pIFpMAHbC3y63kpgu70K
   gRNodlEIW4nv/CBr6nfg/+kbn9CFj4olaPOnkNp+48I9418bSnE9EdYCV
   q/oG2jJkQ68Om0uYnV0p/Hv1eWb+71wqLH/Ls8dxxFQmFRH+TnnzrC0DE
   f05IawokOpqTue0NZiCqK6lwC79RPQzyTug5wpcD2LnXx+iINb7dOIRnS
   OMzjLAg+0DhS0KJJEtmGFRDRKs2mZojLJEvTNZUcsM2c8BtK8oVzbF7pR
   yqA0gNiR8bO41UW6gOLSKCwzJOQ4mSoSfmUY4Z9RAkt2+srNxiPblEYYv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="361331767"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="361331767"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 11:29:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="875385952"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 09 Aug 2023 11:29:45 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTnwD-0006K2-0O;
        Wed, 09 Aug 2023 18:29:41 +0000
Date:   Thu, 10 Aug 2023 02:29:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wenchao Chen <wenchao.chen@unisoc.com>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenchao.chen666@gmail.com,
        zhenxiong.lai@unisoc.com, chunyan.zhang@unisoc.com,
        yuelin.tang@unisoc.com, Wenchao Chen <wenchao.chen@unisoc.com>
Subject: Re: [PATCH] mmc: core: Add host specific tuning support for SD HS
 mode
Message-ID: <202308100202.lY0aerbk-lkp@intel.com>
References: <20230809052952.323-1-wenchao.chen@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809052952.323-1-wenchao.chen@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wenchao,

kernel test robot noticed the following build errors:

[auto build test ERROR on ulf-hansson-mmc-mirror/next]
[also build test ERROR on linus/master v6.5-rc5 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wenchao-Chen/mmc-core-Add-host-specific-tuning-support-for-SD-HS-mode/20230809-133203
base:   https://git.linaro.org/people/ulf.hansson/mmc-mirror.git next
patch link:    https://lore.kernel.org/r/20230809052952.323-1-wenchao.chen%40unisoc.com
patch subject: [PATCH] mmc: core: Add host specific tuning support for SD HS mode
config: arm-randconfig-r064-20230809 (https://download.01.org/0day-ci/archive/20230810/202308100202.lY0aerbk-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230810/202308100202.lY0aerbk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308100202.lY0aerbk-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "mmc_sd_switch" [drivers/mmc/host/sdhci-sprd.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
