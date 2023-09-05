Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D15793076
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244041AbjIEUzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjIEUzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:55:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA3FB2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 13:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693947336; x=1725483336;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Aw7dag/DVhiHHEga1cLf4b1kX+uFM7E72srohLT9sNw=;
  b=kIhwFdUi8BgmvuFU6uVMeKmWai/xrLxyXmYNb5k7sB9E4wwJFENTkmpB
   aYvSsvha330u4n3WkIyHUb4t5eyWN7+FzUk/j3d73vl9xR7aiH8eAAWSX
   9PIh2wMwnG/zdL8FLdlNga4Ca3FYLKZKE+RUA//tv/lmndmf02QumYC5g
   U+jQKMyas70+VVV0nYIBjxAun/x0RCd6SIYrZfhWoZWuITVabCKD0BO2v
   8Gwsun5hfP4OopOHNVGeBu2sva3sNoqSxurKSymdMlRGGOmu9arvV/XsV
   aSNBvDN/usf5ASepu4gRPVVkE4GIt48GQoWnxjUcvEBsCAxGDPSkCI18t
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="374290066"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="374290066"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 13:55:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="806750004"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="806750004"
Received: from lkp-server02.sh.intel.com (HELO e0b2ea88afd5) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 05 Sep 2023 13:55:34 -0700
Received: from kbuild by e0b2ea88afd5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdd59-00024H-2F;
        Tue, 05 Sep 2023 20:55:31 +0000
Date:   Wed, 6 Sep 2023 04:54:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Harrison <John.C.Harrison@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Subject: drivers/gpu/drm/i915/gt/uc/intel_guc_fw.c:190:15: warning: 'success'
 is used uninitialized in this function
Message-ID: <202309060411.7Mxcdcji-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   65d6e954e37872fd9afb5ef3fc0481bb3c2f20f4
commit: 9469d456c6a28494dd9d5cc16e17cf2d4c15c571 drm/i915/guc: Allow for very slow GuC loading
date:   6 months ago
config: x86_64-buildonly-randconfig-002-20230906 (https://download.01.org/0day-ci/archive/20230906/202309060411.7Mxcdcji-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230906/202309060411.7Mxcdcji-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309060411.7Mxcdcji-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/i915/gt/uc/intel_guc_fw.c: In function 'guc_wait_ucode':
>> drivers/gpu/drm/i915/gt/uc/intel_guc_fw.c:190:15: warning: 'success' is used uninitialized in this function [-Wuninitialized]
     190 |   if (!ret || !success)
         |               ^


vim +/success +190 drivers/gpu/drm/i915/gt/uc/intel_guc_fw.c

   151	
   152	static int guc_wait_ucode(struct intel_guc *guc)
   153	{
   154		struct intel_gt *gt = guc_to_gt(guc);
   155		struct intel_uncore *uncore = gt->uncore;
   156		ktime_t before, after, delta;
   157		bool success;
   158		u32 status;
   159		int ret, count;
   160		u64 delta_ms;
   161		u32 before_freq;
   162	
   163		/*
   164		 * Wait for the GuC to start up.
   165		 *
   166		 * Measurements indicate this should take no more than 20ms
   167		 * (assuming the GT clock is at maximum frequency). So, a
   168		 * timeout here indicates that the GuC has failed and is unusable.
   169		 * (Higher levels of the driver may decide to reset the GuC and
   170		 * attempt the ucode load again if this happens.)
   171		 *
   172		 * FIXME: There is a known (but exceedingly unlikely) race condition
   173		 * where the asynchronous frequency management code could reduce
   174		 * the GT clock while a GuC reload is in progress (during a full
   175		 * GT reset). A fix is in progress but there are complex locking
   176		 * issues to be resolved. In the meantime bump the timeout to
   177		 * 200ms. Even at slowest clock, this should be sufficient. And
   178		 * in the working case, a larger timeout makes no difference.
   179		 *
   180		 * IFWI updates have also been seen to cause sporadic failures due to
   181		 * the requested frequency not being granted and thus the firmware
   182		 * load is attempted at minimum frequency. That can lead to load times
   183		 * in the seconds range. However, there is a limit on how long an
   184		 * individual wait_for() can wait. So wrap it in a loop.
   185		 */
   186		before_freq = intel_rps_read_actual_frequency(&uncore->gt->rps);
   187		before = ktime_get();
   188		for (count = 0; count < GUC_LOAD_RETRY_LIMIT; count++) {
   189			ret = wait_for(guc_load_done(uncore, &status, &success), 1000);
 > 190			if (!ret || !success)
   191				break;
   192	
   193			guc_dbg(guc, "load still in progress, count = %d, freq = %dMHz\n",
   194				count, intel_rps_read_actual_frequency(&uncore->gt->rps));
   195		}
   196		after = ktime_get();
   197		delta = ktime_sub(after, before);
   198		delta_ms = ktime_to_ms(delta);
   199		if (ret || !success) {
   200			u32 ukernel = REG_FIELD_GET(GS_UKERNEL_MASK, status);
   201			u32 bootrom = REG_FIELD_GET(GS_BOOTROM_MASK, status);
   202	
   203			guc_info(guc, "load failed: status = 0x%08X, time = %lldms, freq = %dMHz, ret = %d\n",
   204				 status, delta_ms, intel_rps_read_actual_frequency(&uncore->gt->rps), ret);
   205			guc_info(guc, "load failed: status: Reset = %d, BootROM = 0x%02X, UKernel = 0x%02X, MIA = 0x%02X, Auth = 0x%02X\n",
   206				 REG_FIELD_GET(GS_MIA_IN_RESET, status),
   207				 bootrom, ukernel,
   208				 REG_FIELD_GET(GS_MIA_MASK, status),
   209				 REG_FIELD_GET(GS_AUTH_STATUS_MASK, status));
   210	
   211			switch (bootrom) {
   212			case INTEL_BOOTROM_STATUS_NO_KEY_FOUND:
   213				guc_info(guc, "invalid key requested, header = 0x%08X\n",
   214					 intel_uncore_read(uncore, GUC_HEADER_INFO));
   215				ret = -ENOEXEC;
   216				break;
   217	
   218			case INTEL_BOOTROM_STATUS_RSA_FAILED:
   219				guc_info(guc, "firmware signature verification failed\n");
   220				ret = -ENOEXEC;
   221				break;
   222			}
   223	
   224			switch (ukernel) {
   225			case INTEL_GUC_LOAD_STATUS_EXCEPTION:
   226				guc_info(guc, "firmware exception. EIP: %#x\n",
   227					 intel_uncore_read(uncore, SOFT_SCRATCH(13)));
   228				ret = -ENXIO;
   229				break;
   230	
   231			case INTEL_GUC_LOAD_STATUS_INIT_MMIO_SAVE_RESTORE_INVALID:
   232				guc_info(guc, "illegal register in save/restore workaround list\n");
   233				ret = -EPERM;
   234				break;
   235	
   236			case INTEL_GUC_LOAD_STATUS_HWCONFIG_START:
   237				guc_info(guc, "still extracting hwconfig table.\n");
   238				ret = -ETIMEDOUT;
   239				break;
   240			}
   241	
   242			/* Uncommon/unexpected error, see earlier status code print for details */
   243			if (ret == 0)
   244				ret = -ENXIO;
   245		} else if (delta_ms > 200) {
   246			guc_warn(guc, "excessive init time: %lldms! [freq = %dMHz, before = %dMHz, status = 0x%08X, count = %d, ret = %d]\n",
   247				 delta_ms, intel_rps_read_actual_frequency(&uncore->gt->rps),
   248				 before_freq, status, count, ret);
   249		} else {
   250			guc_dbg(guc, "init took %lldms, freq = %dMHz, before = %dMHz, status = 0x%08X, count = %d, ret = %d\n",
   251				delta_ms, intel_rps_read_actual_frequency(&uncore->gt->rps),
   252				before_freq, status, count, ret);
   253		}
   254	
   255		return ret;
   256	}
   257	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
