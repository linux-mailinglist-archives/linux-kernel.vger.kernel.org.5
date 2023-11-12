Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D557E8DEA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 03:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjKLCCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 21:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKLCCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 21:02:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB12930C5;
        Sat, 11 Nov 2023 18:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699754571; x=1731290571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zYgV3EeWTUWInSYElFdO19myYIuDelV579co8Zr1cYA=;
  b=XT3LN90VGamPb72MSKbOdTlrHdkvSSH+CDsR3VpqkZud2w3fMuWckz4/
   uyO0TmT5Tk6txc5I4CFNZuGQMv43zsBpuOTWcxoOJuK5Kv1KQ9OH4dHcV
   X6ErRlafKvxvHl5o7fTKSF1Vv6i6EKNj8kTgmuzJ9TWn4r7ni9qkQ3Jz5
   YCUZokUshSV5TqDJ7YDyHPAbgeI35utqIp5kzfn2cwaviNo/DisAwbbL4
   vs3Ggq5ssuhwiGHhcNxK/03O+0qDxOB3yGabNz0LJpjRmhFTKTQtwzar7
   0vBu8CQx6o5qQywFr/TD7kS/EzbKngH+9rpE/MTu9Mod+ZjBNP2FChpqQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="11857525"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="11857525"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 18:02:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="11761982"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 11 Nov 2023 18:02:47 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1zoC-000AsW-2c;
        Sun, 12 Nov 2023 02:02:44 +0000
Date:   Sun, 12 Nov 2023 10:02:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bean Huo <beanhuo@iokpp.de>, avri.altman@wdc.com,
        bvanassche@acm.org, alim.akhtar@samsung.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        mani@kernel.org, quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        beanhuo@micron.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikebi@micron.com, lporzio@micron.com
Subject: Re: [PATCH v1 2/2] scsi: ufs: core: Add sysfs node for UFS RTC update
Message-ID: <202311120923.S1Zbpb0s-lkp@intel.com>
References: <20231109125217.185462-3-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109125217.185462-3-beanhuo@iokpp.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bean,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mkp-scsi/for-next]
[also build test WARNING on jejb-scsi/for-next linus/master v6.6 next-20231110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bean-Huo/scsi-ufs-core-Add-UFS-RTC-support/20231110-051048
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20231109125217.185462-3-beanhuo%40iokpp.de
patch subject: [PATCH v1 2/2] scsi: ufs: core: Add sysfs node for UFS RTC update
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20231112/202311120923.S1Zbpb0s-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231112/202311120923.S1Zbpb0s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311120923.S1Zbpb0s-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/ufs/core/ufs-sysfs.c:276:6: warning: variable 'resume_period_update' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     276 |         if (!hba->dev_info.rtc_update_period && ms > 0)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ufs/core/ufs-sysfs.c:281:6: note: uninitialized use occurs here
     281 |         if (resume_period_update)
         |             ^~~~~~~~~~~~~~~~~~~~
   drivers/ufs/core/ufs-sysfs.c:276:2: note: remove the 'if' if its condition is always true
     276 |         if (!hba->dev_info.rtc_update_period && ms > 0)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     277 |                 resume_period_update =  true;
         | ~~~~~~~~~~~~~~~~
>> drivers/ufs/core/ufs-sysfs.c:276:6: warning: variable 'resume_period_update' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
     276 |         if (!hba->dev_info.rtc_update_period && ms > 0)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ufs/core/ufs-sysfs.c:281:6: note: uninitialized use occurs here
     281 |         if (resume_period_update)
         |             ^~~~~~~~~~~~~~~~~~~~
   drivers/ufs/core/ufs-sysfs.c:276:6: note: remove the '&&' if its condition is always true
     276 |         if (!hba->dev_info.rtc_update_period && ms > 0)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ufs/core/ufs-sysfs.c:271:27: note: initialize the variable 'resume_period_update' to silence this warning
     271 |         bool resume_period_update;
         |                                  ^
         |                                   = 0
   2 warnings generated.


vim +276 drivers/ufs/core/ufs-sysfs.c

   265	
   266	static ssize_t rtc_update_ms_store(struct device *dev, struct device_attribute *attr,
   267				   const char *buf, size_t count)
   268	{
   269		struct ufs_hba *hba = dev_get_drvdata(dev);
   270		unsigned int ms;
   271		bool resume_period_update;
   272	
   273		if (kstrtouint(buf, 0, &ms))
   274			return -EINVAL;
   275	
 > 276		if (!hba->dev_info.rtc_update_period && ms > 0)
   277			resume_period_update =  true;
   278		/* Minimum and maximum update frequency should be synchronized with all UFS vendors */
   279		hba->dev_info.rtc_update_period = ms;
   280	
   281		if (resume_period_update)
   282			schedule_delayed_work(&hba->ufs_rtc_delayed_work,
   283							msecs_to_jiffies(hba->dev_info.rtc_update_period));
   284		return count;
   285	}
   286	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
