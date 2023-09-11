Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7E479B9D9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343928AbjIKVM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240276AbjIKOkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:40:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E291F2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694443219; x=1725979219;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sYTW2zq+2z/NTKUtq71ZsQ+GiwaVAi8mdhW3hBrys1E=;
  b=IyU35PneGxI4FMFxVKSjeLLAKFZpcvh8DxwIjMAnOCKEcBl4E0aCO8mN
   OUree0p0aEnzScV4OibNNMAk4LcSENWBv97Mq+G7PJdWkrY7NUTO1iv0n
   7JlQtTDx754lrUQJKE2yL/xerq1p4SrRc8eop1uK1/F9IQdXW51+9Wtyb
   m35+xaa+58MB0FPpOzPa5Kp/zcB5stB4K+pX/eIbPhlUiYjFTJqY5waDa
   kfxnYoBjYsJsH3d1vGcgbn6FWkUXCW4nqLtMZ6uFSZUz7FT0lYxeHW1yF
   Ec4cesH1Y9viJSzr7oEmzFUL2nJcc31wOynaze0RKHsxBlNbXsAM4Jh8D
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="375448508"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="375448508"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 07:40:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="1074167653"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="1074167653"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 11 Sep 2023 07:40:16 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfi5G-0006Kw-0w;
        Mon, 11 Sep 2023 14:40:14 +0000
Date:   Mon, 11 Sep 2023 22:39:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jing Zhang <jingzhangos@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Upton <oliver.upton@linux.dev>
Subject: arch/arm64/kvm/sys_regs.c:1239: warning: Function parameter or
 member 'vcpu' not described in 'arm64_check_features'
Message-ID: <202309112251.e25LqfcK-lkp@intel.com>
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

Hi Jing,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0bb80ecc33a8fb5a682236443c1e740d5c917d1d
commit: 2e8bf0cbd0589bae3a0466a3ed45f9cf9f3164eb KVM: arm64: Use arm64_ftr_bits to sanitise ID register writes
date:   3 months ago
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20230911/202309112251.e25LqfcK-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230911/202309112251.e25LqfcK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309112251.e25LqfcK-lkp@intel.com/

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
