Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61ADB77F789
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351226AbjHQNUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351438AbjHQNUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:20:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3A62133
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692278414; x=1723814414;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oCTVmNYrLlpnyZdSlsj8M2QXwVyMDIZGZUYhsRuF2BM=;
  b=QU/8tmqJLjH2XlXkwU8fZws39if52t160bEHqe3nmwrp8kR2kAQ0TF4U
   MdggIBigLQhBu682N3pMzE481iibuVslJalvMcHIFIJDtJ33z+PVPIoUp
   0ZLwKbe9hzoqTPGNdxaoelCb4mB/n22KMFvEhl+hLVZ2CoEcVZ6Ulps9e
   /EYeY1MP+qzZnNeHeaq9FZF8yVGIRjMaHeCxYcYUcHBI/VLBC/5AV885x
   e/YBJqrxt5gHKMSDhYc6lLh5MddnnrkFLEGVsooqUapmC7M7uNv7Yqwwx
   8OcqTZdvHYidLEAzIrxYwFiaP1jB32LF/WFTS/H5+mtGR7jkgOc2o5HM6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="362961457"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="362961457"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 06:17:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="1065233569"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="1065233569"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 17 Aug 2023 06:17:42 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWcsb-00019o-02;
        Thu, 17 Aug 2023 13:17:37 +0000
Date:   Thu, 17 Aug 2023 21:17:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jing Zhang <jingzhangos@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Upton <oliver.upton@linux.dev>
Subject: arch/arm64/kvm/sys_regs.c:1239: warning: Function parameter or
 member 'vcpu' not described in 'arm64_check_features'
Message-ID: <202308172123.fPQkVpYE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: 2e8bf0cbd0589bae3a0466a3ed45f9cf9f3164eb KVM: arm64: Use arm64_ftr_bits to sanitise ID register writes
date:   9 weeks ago
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20230817/202308172123.fPQkVpYE-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308172123.fPQkVpYE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308172123.fPQkVpYE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm64/kvm/sys_regs.c:1239: warning: Function parameter or member 'vcpu' not described in 'arm64_check_features'
>> arch/arm64/kvm/sys_regs.c:1239: warning: Function parameter or member 'rd' not described in 'arm64_check_features'
>> arch/arm64/kvm/sys_regs.c:1239: warning: Function parameter or member 'val' not described in 'arm64_check_features'
   arch/arm64/kvm/sys_regs.c:2868: warning: Function parameter or member 'global' not described in 'kvm_handle_cp_64'
   arch/arm64/kvm/sys_regs.c:2868: warning: Function parameter or member 'nr_global' not described in 'kvm_handle_cp_64'
   arch/arm64/kvm/sys_regs.c:2868: warning: Excess function parameter 'run' description in 'kvm_handle_cp_64'
   arch/arm64/kvm/sys_regs.c:3036: warning: Function parameter or member 'params' not described in 'kvm_handle_cp_32'
   arch/arm64/kvm/sys_regs.c:3036: warning: Function parameter or member 'global' not described in 'kvm_handle_cp_32'
   arch/arm64/kvm/sys_regs.c:3036: warning: Function parameter or member 'nr_global' not described in 'kvm_handle_cp_32'
   arch/arm64/kvm/sys_regs.c:3036: warning: Excess function parameter 'run' description in 'kvm_handle_cp_32'


vim +1239 arch/arm64/kvm/sys_regs.c

  1223	
  1224	/**
  1225	 * arm64_check_features() - Check if a feature register value constitutes
  1226	 * a subset of features indicated by the idreg's KVM sanitised limit.
  1227	 *
  1228	 * This function will check if each feature field of @val is the "safe" value
  1229	 * against idreg's KVM sanitised limit return from reset() callback.
  1230	 * If a field value in @val is the same as the one in limit, it is always
  1231	 * considered the safe value regardless For register fields that are not in
  1232	 * writable, only the value in limit is considered the safe value.
  1233	 *
  1234	 * Return: 0 if all the fields are safe. Otherwise, return negative errno.
  1235	 */
  1236	static int arm64_check_features(struct kvm_vcpu *vcpu,
  1237					const struct sys_reg_desc *rd,
  1238					u64 val)
> 1239	{
  1240		const struct arm64_ftr_reg *ftr_reg;
  1241		const struct arm64_ftr_bits *ftrp = NULL;
  1242		u32 id = reg_to_encoding(rd);
  1243		u64 writable_mask = rd->val;
  1244		u64 limit = rd->reset(vcpu, rd);
  1245		u64 mask = 0;
  1246	
  1247		/*
  1248		 * Hidden and unallocated ID registers may not have a corresponding
  1249		 * struct arm64_ftr_reg. Of course, if the register is RAZ we know the
  1250		 * only safe value is 0.
  1251		 */
  1252		if (sysreg_visible_as_raz(vcpu, rd))
  1253			return val ? -E2BIG : 0;
  1254	
  1255		ftr_reg = get_arm64_ftr_reg(id);
  1256		if (!ftr_reg)
  1257			return -EINVAL;
  1258	
  1259		ftrp = ftr_reg->ftr_bits;
  1260	
  1261		for (; ftrp && ftrp->width; ftrp++) {
  1262			s64 f_val, f_lim, safe_val;
  1263			u64 ftr_mask;
  1264	
  1265			ftr_mask = arm64_ftr_mask(ftrp);
  1266			if ((ftr_mask & writable_mask) != ftr_mask)
  1267				continue;
  1268	
  1269			f_val = arm64_ftr_value(ftrp, val);
  1270			f_lim = arm64_ftr_value(ftrp, limit);
  1271			mask |= ftr_mask;
  1272	
  1273			if (f_val == f_lim)
  1274				safe_val = f_val;
  1275			else
  1276				safe_val = kvm_arm64_ftr_safe_value(id, ftrp, f_val, f_lim);
  1277	
  1278			if (safe_val != f_val)
  1279				return -E2BIG;
  1280		}
  1281	
  1282		/* For fields that are not writable, values in limit are the safe values. */
  1283		if ((val & ~mask) != (limit & ~mask))
  1284			return -E2BIG;
  1285	
  1286		return 0;
  1287	}
  1288	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
