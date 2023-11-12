Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051FD7E91DB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 18:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjKLRyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 12:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKLRyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 12:54:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9517D2715
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 09:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699811689; x=1731347689;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Jn6NYa8UYloGVmszKp9PNtBd9iWMHjWefpDrR4Zr14Q=;
  b=ZDHDReyMHx97OZ7MenaUTdQCXUXRoIIlNrtv5z8J+jEwiBDFwMiYYpXJ
   nGc2pWQZOF/Mo4YaO88QNAD2Jk4wQnAfhS7kQQHstsPNxc7UKxXioFUOe
   dQAG42ApgP2Hc0/qlIII0JATFikbYvRfZiGqtEB9h3MgnbUGI/dzdR0oW
   K+V1Yx3RdN0Fdd/ciqZwH0cF/qbZtDLGSanxk+poNExx6vpnHi/V1v1S0
   rmdPLOFd2nqmut0YPw8kvU17eU+RrQeWSBauCFrd0Br+7u/+kozJWXj4v
   IEbvzfholcQNWV2Xe9mqskbhgpaGG3j2ScXqucppu5+OYJTFJqcJ9WxrD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="456836757"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="456836757"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 09:54:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="834543864"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="834543864"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 12 Nov 2023 09:54:47 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r2EfV-000BOw-0c;
        Sun, 12 Nov 2023 17:54:45 +0000
Date:   Mon, 13 Nov 2023 01:54:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: arch/x86/kernel/cpu/mtrr/generic.c:259: warning: Function parameter
 or member 'var' not described in 'mtrr_overwrite_state'
Message-ID: <202311130104.9xKAKzke-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juergen,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1b907d0507354b74a4f2c286380cd6059af79248
commit: 29055dc74287467bd7a053d60b4afe753832960d x86/mtrr: Support setting MTRR state for software defined MTRRs
date:   5 months ago
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20231113/202311130104.9xKAKzke-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231113/202311130104.9xKAKzke-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311130104.9xKAKzke-lkp@intel.com/

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
