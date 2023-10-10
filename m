Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE0F7C016B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjJJQRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbjJJQRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:17:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E090181
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696954045; x=1728490045;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9Hn3QKVxb4sctB5kVFZ9VNmukxEB4LZt3lftgaj2lEk=;
  b=cRwMuPDZ4v+B5wX2kyjf8OU5NR+DsI/ZD2paRxJiOL2SPN10mji75Z+9
   FEl3EIHoMzFK18OMZnaxYtaFVvFhd8bufyEvpfLhnrXcKVOZD2eF6mxdy
   UR2GKQnV5w6Z5Ejr7/hqUK6UEkT+t48cW7XQfabsoFOCJR8llXqhFQXOZ
   FjKp+o43c0IQig2m4wP8/JOg7PvplQpxTqQzqIN3wzEP+Klt3MzevWCIF
   bIfceILNxroeEYOp3BIFUU2NzIyf6PUKpZt4fKcFdASUAfJtdV1Gu44iQ
   4cZMHlR6JAg3ny4GNtgVheyhpDWSrLfbK3ba1qhcMlMdt7F+594xq/xdW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="374783181"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="374783181"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 09:05:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="869752929"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="869752929"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 10 Oct 2023 09:05:35 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqFEj-0000jE-0e;
        Tue, 10 Oct 2023 16:05:33 +0000
Date:   Wed, 11 Oct 2023 00:04:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: arch/x86/kernel/cpu/mtrr/generic.c:259: warning: Function parameter
 or member 'var' not described in 'mtrr_overwrite_state'
Message-ID: <202310102349.gDBgWNwG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juergen,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   94f6f0550c625fab1f373bb86a6669b45e9748b3
commit: 29055dc74287467bd7a053d60b4afe753832960d x86/mtrr: Support setting MTRR state for software defined MTRRs
date:   4 months ago
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20231010/202310102349.gDBgWNwG-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310102349.gDBgWNwG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310102349.gDBgWNwG-lkp@intel.com/

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

   109	
   110	/**
   111	 * mtrr_type_lookup_fixed - look up memory type in MTRR fixed entries
   112	 *
   113	 * Return the MTRR fixed memory type of 'start'.
   114	 *
   115	 * MTRR fixed entries are divided into the following ways:
   116	 *  0x00000 - 0x7FFFF : This range is divided into eight 64KB sub-ranges
   117	 *  0x80000 - 0xBFFFF : This range is divided into sixteen 16KB sub-ranges
   118	 *  0xC0000 - 0xFFFFF : This range is divided into sixty-four 4KB sub-ranges
   119	 *
   120	 * Return Values:
   121	 * MTRR_TYPE_(type)  - Matched memory type
   122	 * MTRR_TYPE_INVALID - Unmatched
   123	 */
   124	static u8 mtrr_type_lookup_fixed(u64 start, u64 end)
 > 125	{
   126		int idx;
   127	
   128		if (start >= 0x100000)
   129			return MTRR_TYPE_INVALID;
   130	
   131		/* 0x0 - 0x7FFFF */
   132		if (start < 0x80000) {
   133			idx = 0;
   134			idx += (start >> 16);
   135			return mtrr_state.fixed_ranges[idx];
   136		/* 0x80000 - 0xBFFFF */
   137		} else if (start < 0xC0000) {
   138			idx = 1 * 8;
   139			idx += ((start - 0x80000) >> 14);
   140			return mtrr_state.fixed_ranges[idx];
   141		}
   142	
   143		/* 0xC0000 - 0xFFFFF */
   144		idx = 3 * 8;
   145		idx += ((start - 0xC0000) >> 12);
   146		return mtrr_state.fixed_ranges[idx];
   147	}
   148	
   149	/**
   150	 * mtrr_type_lookup_variable - look up memory type in MTRR variable entries
   151	 *
   152	 * Return Value:
   153	 * MTRR_TYPE_(type) - Matched memory type or default memory type (unmatched)
   154	 *
   155	 * Output Arguments:
   156	 * repeat - Set to 1 when [start:end] spanned across MTRR range and type
   157	 *	    returned corresponds only to [start:*partial_end].  Caller has
   158	 *	    to lookup again for [*partial_end:end].
   159	 *
   160	 * uniform - Set to 1 when an MTRR covers the region uniformly, i.e. the
   161	 *	     region is fully covered by a single MTRR entry or the default
   162	 *	     type.
   163	 */
   164	static u8 mtrr_type_lookup_variable(u64 start, u64 end, u64 *partial_end,
   165					    int *repeat, u8 *uniform)
   166	{
   167		int i;
   168		u64 base, mask;
   169		u8 prev_match, curr_match;
   170	
   171		*repeat = 0;
   172		*uniform = 1;
   173	
   174		prev_match = MTRR_TYPE_INVALID;
   175		for (i = 0; i < num_var_ranges; ++i) {
   176			unsigned short start_state, end_state, inclusive;
   177	
   178			if (!(mtrr_state.var_ranges[i].mask_lo & MTRR_PHYSMASK_V))
   179				continue;
   180	
   181			base = (((u64)mtrr_state.var_ranges[i].base_hi) << 32) +
   182			       (mtrr_state.var_ranges[i].base_lo & PAGE_MASK);
   183			mask = (((u64)mtrr_state.var_ranges[i].mask_hi) << 32) +
   184			       (mtrr_state.var_ranges[i].mask_lo & PAGE_MASK);
   185	
   186			start_state = ((start & mask) == (base & mask));
   187			end_state = ((end & mask) == (base & mask));
   188			inclusive = ((start < base) && (end > base));
   189	
   190			if ((start_state != end_state) || inclusive) {
   191				/*
   192				 * We have start:end spanning across an MTRR.
   193				 * We split the region into either
   194				 *
   195				 * - start_state:1
   196				 * (start:mtrr_end)(mtrr_end:end)
   197				 * - end_state:1
   198				 * (start:mtrr_start)(mtrr_start:end)
   199				 * - inclusive:1
   200				 * (start:mtrr_start)(mtrr_start:mtrr_end)(mtrr_end:end)
   201				 *
   202				 * depending on kind of overlap.
   203				 *
   204				 * Return the type of the first region and a pointer
   205				 * to the start of next region so that caller will be
   206				 * advised to lookup again after having adjusted start
   207				 * and end.
   208				 *
   209				 * Note: This way we handle overlaps with multiple
   210				 * entries and the default type properly.
   211				 */
   212				if (start_state)
   213					*partial_end = base + get_mtrr_size(mask);
   214				else
   215					*partial_end = base;
   216	
   217				if (unlikely(*partial_end <= start)) {
   218					WARN_ON(1);
   219					*partial_end = start + PAGE_SIZE;
   220				}
   221	
   222				end = *partial_end - 1; /* end is inclusive */
   223				*repeat = 1;
   224				*uniform = 0;
   225			}
   226	
   227			if ((start & mask) != (base & mask))
   228				continue;
   229	
   230			curr_match = mtrr_state.var_ranges[i].base_lo & MTRR_PHYSBASE_TYPE;
   231			if (prev_match == MTRR_TYPE_INVALID) {
   232				prev_match = curr_match;
   233				continue;
   234			}
   235	
   236			*uniform = 0;
   237			if (check_type_overlap(&prev_match, &curr_match))
   238				return curr_match;
   239		}
   240	
   241		if (prev_match != MTRR_TYPE_INVALID)
   242			return prev_match;
   243	
   244		return mtrr_state.def_type;
   245	}
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
