Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE9777F097
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 08:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348266AbjHQGjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 02:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348225AbjHQGjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 02:39:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30B81B4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 23:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692254352; x=1723790352;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gB5KMoof55X+0asjNIfV2F8znju0t4PbHxg2RW6F1DI=;
  b=h9ufKKNPMovvYtFmsnnLZ8tVoWiptc3KvVrEb2OyJQMJkOHaPqnPVHy7
   wJ0UICA0FeTdC1PKibDRPdIWWo9yXCuqyfUCCkKDPNZfyXH+yV37u6gIF
   bhucb7w8sXJRwU7nxfbMAuw8ZDGfZMJThyxM9JJ50Ekz2RqwIHC4grp69
   SL4lIfHHaFKDyriuOMSnZ13Q4LbdNKsLuC7RifftZnZx+6z2gvJp8lTST
   SYEJtBqdqTVL9gcpbBKWHkc6P1B8IMTFyr3DIB5eZ4OFeiNWZo7aBPpWR
   L4Ck2gXXEiNCxgGOVZFuDHFR38ssp/+XHtB5oHdBN3P4vayJb69Qz4Ii/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="372727107"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="372727107"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 23:39:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="1065135115"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="1065135115"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 Aug 2023 23:39:10 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWWez-0000rV-0e;
        Thu, 17 Aug 2023 06:39:09 +0000
Date:   Thu, 17 Aug 2023 14:38:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: arch/x86/kernel/cpu/mtrr/generic.c:259: warning: Function parameter
 or member 'var' not described in 'mtrr_overwrite_state'
Message-ID: <202308171419.RgHfW1sc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: 29055dc74287467bd7a053d60b4afe753832960d x86/mtrr: Support setting MTRR state for software defined MTRRs
date:   3 months ago
config: i386-randconfig-i011-20230817 (https://download.01.org/0day-ci/archive/20230817/202308171419.RgHfW1sc-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171419.RgHfW1sc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308171419.RgHfW1sc-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/kernel/cpu/mtrr/generic.c:125: warning: Function parameter or member 'start' not described in 'mtrr_type_lookup_fixed'
   arch/x86/kernel/cpu/mtrr/generic.c:125: warning: Function parameter or member 'end' not described in 'mtrr_type_lookup_fixed'
   arch/x86/kernel/cpu/mtrr/generic.c:166: warning: Function parameter or member 'start' not described in 'mtrr_type_lookup_variable'
   arch/x86/kernel/cpu/mtrr/generic.c:166: warning: Function parameter or member 'end' not described in 'mtrr_type_lookup_variable'
   arch/x86/kernel/cpu/mtrr/generic.c:166: warning: Function parameter or member 'partial_end' not described in 'mtrr_type_lookup_variable'
   arch/x86/kernel/cpu/mtrr/generic.c:166: warning: Function parameter or member 'repeat' not described in 'mtrr_type_lookup_variable'
   arch/x86/kernel/cpu/mtrr/generic.c:166: warning: Function parameter or member 'uniform' not described in 'mtrr_type_lookup_variable'
>> arch/x86/kernel/cpu/mtrr/generic.c:259: warning: Function parameter or member 'var' not described in 'mtrr_overwrite_state'
>> arch/x86/kernel/cpu/mtrr/generic.c:259: warning: Function parameter or member 'num_var' not described in 'mtrr_overwrite_state'
>> arch/x86/kernel/cpu/mtrr/generic.c:259: warning: Function parameter or member 'def_type' not described in 'mtrr_overwrite_state'
   arch/x86/kernel/cpu/mtrr/generic.c:316: warning: Function parameter or member 'start' not described in 'mtrr_type_lookup'
   arch/x86/kernel/cpu/mtrr/generic.c:316: warning: Function parameter or member 'end' not described in 'mtrr_type_lookup'
   arch/x86/kernel/cpu/mtrr/generic.c:316: warning: Function parameter or member 'uniform' not described in 'mtrr_type_lookup'


vim +259 arch/x86/kernel/cpu/mtrr/generic.c

   246	
   247	/**
   248	 * mtrr_overwrite_state - set static MTRR state
   249	 *
   250	 * Used to set MTRR state via different means (e.g. with data obtained from
   251	 * a hypervisor).
   252	 * Is allowed only for special cases when running virtualized. Must be called
   253	 * from the x86_init.hyper.init_platform() hook.  It can be called only once.
   254	 * The MTRR state can't be changed afterwards.  To ensure that, X86_FEATURE_MTRR
   255	 * is cleared.
   256	 */
   257	void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_var,
   258				  mtrr_type def_type)
 > 259	{
   260		unsigned int i;
   261	
   262		/* Only allowed to be called once before mtrr_bp_init(). */
   263		if (WARN_ON_ONCE(mtrr_state_set))
   264			return;
   265	
   266		/* Only allowed when running virtualized. */
   267		if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
   268			return;
   269	
   270		/*
   271		 * Only allowed for special virtualization cases:
   272		 * - when running as Hyper-V, SEV-SNP guest using vTOM
   273		 * - when running as Xen PV guest
   274		 * - when running as SEV-SNP or TDX guest to avoid unnecessary
   275		 *   VMM communication/Virtualization exceptions (#VC, #VE)
   276		 */
   277		if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP) &&
   278		    !hv_is_isolation_supported() &&
   279		    !cpu_feature_enabled(X86_FEATURE_XENPV) &&
   280		    !cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
   281			return;
   282	
   283		/* Disable MTRR in order to disable MTRR modifications. */
   284		setup_clear_cpu_cap(X86_FEATURE_MTRR);
   285	
   286		if (var) {
   287			if (num_var > MTRR_MAX_VAR_RANGES) {
   288				pr_warn("Trying to overwrite MTRR state with %u variable entries\n",
   289					num_var);
   290				num_var = MTRR_MAX_VAR_RANGES;
   291			}
   292			for (i = 0; i < num_var; i++)
   293				mtrr_state.var_ranges[i] = var[i];
   294			num_var_ranges = num_var;
   295		}
   296	
   297		mtrr_state.def_type = def_type;
   298		mtrr_state.enabled |= MTRR_STATE_MTRR_ENABLED;
   299	
   300		mtrr_state_set = 1;
   301	}
   302	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
