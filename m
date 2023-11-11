Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD307E8AC0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 12:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjKKLsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 06:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjKKLsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 06:48:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA6F3AA0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 03:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699703320; x=1731239320;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GjMhf6wmEyxwcWyWujPAqP05PLKAzvnsnJidha5LjXM=;
  b=ZOjCK/XqNNlrX+mU+sFy3hAv12veZ02QFBQJ/0h1mcqqpvp5IAczHnm+
   JPc5BhFH7qGUclb4T6Hubi6JB6e1qjk7KqBNgRWkXvISrfcXm87JKHYQO
   qZFj6/g2BYW34SgaGp2PzHZoasCBuVGepH3+SyUohtT964UmiI8ekBJaf
   514ZLQ2jEZPjW/QaOFzAHVvgeAfBEiUBwTCf+HeFKZS/xrXa7GAq0NEfr
   ik4pgZKe0+GmvN5YGMvRoGf4qQmb9Hli1RPeaOiGw7EqM5oH/tjQRTHVw
   WeE5fjXdC0n1zoPpWPRRyX3t1B7VLzLQRfBcHqsWIF7qbwp3QWMiiMN0Q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="3328729"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="3328729"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 03:48:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="11663479"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 11 Nov 2023 03:48:38 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1mTa-000AQ2-1h;
        Sat, 11 Nov 2023 11:48:34 +0000
Date:   Sat, 11 Nov 2023 19:47:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: arch/x86/hyperv/hv_init.c:69:20: sparse: sparse: cast removes
 address space '__iomem' of expression
Message-ID: <202311111925.iPGGJik4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3ca112b71f35dd5d99fc4571a56b5fc6f0c15814
commit: 6afd9dc1a4b158456c072580f0851b4dbaaa02f1 Drivers: hv: Don't remap addresses that are above shared_gpa_boundary
date:   7 months ago
config: i386-randconfig-062-20230909 (https://download.01.org/0day-ci/archive/20231111/202311111925.iPGGJik4-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311111925.iPGGJik4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311111925.iPGGJik4-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/x86/hyperv/hv_init.c:69:20: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/x86/hyperv/hv_init.c:223:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   arch/x86/hyperv/hv_init.c:223:33: sparse:     expected void volatile [noderef] __iomem *addr
   arch/x86/hyperv/hv_init.c:223:33: sparse:     got void *
--
>> drivers/hv/hv.c:224:28: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hv/hv.c:243:28: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hv/hv.c:322:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *synic_message_page @@
   drivers/hv/hv.c:322:31: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hv/hv.c:322:31: sparse:     got void *synic_message_page
>> drivers/hv/hv.c:334:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *synic_event_page @@
   drivers/hv/hv.c:334:31: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hv/hv.c:334:31: sparse:     got void *synic_event_page

vim +/__iomem +69 arch/x86/hyperv/hv_init.c

    47	
    48	static int hyperv_init_ghcb(void)
    49	{
    50		u64 ghcb_gpa;
    51		void *ghcb_va;
    52		void **ghcb_base;
    53	
    54		if (!hv_isolation_type_snp())
    55			return 0;
    56	
    57		if (!hv_ghcb_pg)
    58			return -EINVAL;
    59	
    60		/*
    61		 * GHCB page is allocated by paravisor. The address
    62		 * returned by MSR_AMD64_SEV_ES_GHCB is above shared
    63		 * memory boundary and map it here.
    64		 */
    65		rdmsrl(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);
    66	
    67		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
    68		ghcb_gpa &= ~ms_hyperv.shared_gpa_boundary;
  > 69		ghcb_va = (void *)ioremap_cache(ghcb_gpa, HV_HYP_PAGE_SIZE);
    70		if (!ghcb_va)
    71			return -ENOMEM;
    72	
    73		ghcb_base = (void **)this_cpu_ptr(hv_ghcb_pg);
    74		*ghcb_base = ghcb_va;
    75	
    76		return 0;
    77	}
    78	
    79	static int hv_cpu_init(unsigned int cpu)
    80	{
    81		union hv_vp_assist_msr_contents msr = { 0 };
    82		struct hv_vp_assist_page **hvp = &hv_vp_assist_page[cpu];
    83		int ret;
    84	
    85		ret = hv_common_cpu_init(cpu);
    86		if (ret)
    87			return ret;
    88	
    89		if (!hv_vp_assist_page)
    90			return 0;
    91	
    92		if (hv_root_partition) {
    93			/*
    94			 * For root partition we get the hypervisor provided VP assist
    95			 * page, instead of allocating a new page.
    96			 */
    97			rdmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
    98			*hvp = memremap(msr.pfn << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT,
    99					PAGE_SIZE, MEMREMAP_WB);
   100		} else {
   101			/*
   102			 * The VP assist page is an "overlay" page (see Hyper-V TLFS's
   103			 * Section 5.2.1 "GPA Overlay Pages"). Here it must be zeroed
   104			 * out to make sure we always write the EOI MSR in
   105			 * hv_apic_eoi_write() *after* the EOI optimization is disabled
   106			 * in hv_cpu_die(), otherwise a CPU may not be stopped in the
   107			 * case of CPU offlining and the VM will hang.
   108			 */
   109			if (!*hvp)
   110				*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
   111			if (*hvp)
   112				msr.pfn = vmalloc_to_pfn(*hvp);
   113	
   114		}
   115		if (!WARN_ON(!(*hvp))) {
   116			msr.enable = 1;
   117			wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
   118		}
   119	
   120		return hyperv_init_ghcb();
   121	}
   122	
   123	static void (*hv_reenlightenment_cb)(void);
   124	
   125	static void hv_reenlightenment_notify(struct work_struct *dummy)
   126	{
   127		struct hv_tsc_emulation_status emu_status;
   128	
   129		rdmsrl(HV_X64_MSR_TSC_EMULATION_STATUS, *(u64 *)&emu_status);
   130	
   131		/* Don't issue the callback if TSC accesses are not emulated */
   132		if (hv_reenlightenment_cb && emu_status.inprogress)
   133			hv_reenlightenment_cb();
   134	}
   135	static DECLARE_DELAYED_WORK(hv_reenlightenment_work, hv_reenlightenment_notify);
   136	
   137	void hyperv_stop_tsc_emulation(void)
   138	{
   139		u64 freq;
   140		struct hv_tsc_emulation_status emu_status;
   141	
   142		rdmsrl(HV_X64_MSR_TSC_EMULATION_STATUS, *(u64 *)&emu_status);
   143		emu_status.inprogress = 0;
   144		wrmsrl(HV_X64_MSR_TSC_EMULATION_STATUS, *(u64 *)&emu_status);
   145	
   146		rdmsrl(HV_X64_MSR_TSC_FREQUENCY, freq);
   147		tsc_khz = div64_u64(freq, 1000);
   148	}
   149	EXPORT_SYMBOL_GPL(hyperv_stop_tsc_emulation);
   150	
   151	static inline bool hv_reenlightenment_available(void)
   152	{
   153		/*
   154		 * Check for required features and privileges to make TSC frequency
   155		 * change notifications work.
   156		 */
   157		return ms_hyperv.features & HV_ACCESS_FREQUENCY_MSRS &&
   158			ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE &&
   159			ms_hyperv.features & HV_ACCESS_REENLIGHTENMENT;
   160	}
   161	
   162	DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_reenlightenment)
   163	{
   164		ack_APIC_irq();
   165		inc_irq_stat(irq_hv_reenlightenment_count);
   166		schedule_delayed_work(&hv_reenlightenment_work, HZ/10);
   167	}
   168	
   169	void set_hv_tscchange_cb(void (*cb)(void))
   170	{
   171		struct hv_reenlightenment_control re_ctrl = {
   172			.vector = HYPERV_REENLIGHTENMENT_VECTOR,
   173			.enabled = 1,
   174		};
   175		struct hv_tsc_emulation_control emu_ctrl = {.enabled = 1};
   176	
   177		if (!hv_reenlightenment_available()) {
   178			pr_warn("Hyper-V: reenlightenment support is unavailable\n");
   179			return;
   180		}
   181	
   182		if (!hv_vp_index)
   183			return;
   184	
   185		hv_reenlightenment_cb = cb;
   186	
   187		/* Make sure callback is registered before we write to MSRs */
   188		wmb();
   189	
   190		re_ctrl.target_vp = hv_vp_index[get_cpu()];
   191	
   192		wrmsrl(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *((u64 *)&re_ctrl));
   193		wrmsrl(HV_X64_MSR_TSC_EMULATION_CONTROL, *((u64 *)&emu_ctrl));
   194	
   195		put_cpu();
   196	}
   197	EXPORT_SYMBOL_GPL(set_hv_tscchange_cb);
   198	
   199	void clear_hv_tscchange_cb(void)
   200	{
   201		struct hv_reenlightenment_control re_ctrl;
   202	
   203		if (!hv_reenlightenment_available())
   204			return;
   205	
   206		rdmsrl(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *(u64 *)&re_ctrl);
   207		re_ctrl.enabled = 0;
   208		wrmsrl(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *(u64 *)&re_ctrl);
   209	
   210		hv_reenlightenment_cb = NULL;
   211	}
   212	EXPORT_SYMBOL_GPL(clear_hv_tscchange_cb);
   213	
   214	static int hv_cpu_die(unsigned int cpu)
   215	{
   216		struct hv_reenlightenment_control re_ctrl;
   217		unsigned int new_cpu;
   218		void **ghcb_va;
   219	
   220		if (hv_ghcb_pg) {
   221			ghcb_va = (void **)this_cpu_ptr(hv_ghcb_pg);
   222			if (*ghcb_va)
 > 223				iounmap(*ghcb_va);
   224			*ghcb_va = NULL;
   225		}
   226	
   227		hv_common_cpu_die(cpu);
   228	
   229		if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
   230			union hv_vp_assist_msr_contents msr = { 0 };
   231			if (hv_root_partition) {
   232				/*
   233				 * For root partition the VP assist page is mapped to
   234				 * hypervisor provided page, and thus we unmap the
   235				 * page here and nullify it, so that in future we have
   236				 * correct page address mapped in hv_cpu_init.
   237				 */
   238				memunmap(hv_vp_assist_page[cpu]);
   239				hv_vp_assist_page[cpu] = NULL;
   240				rdmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
   241				msr.enable = 0;
   242			}
   243			wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
   244		}
   245	
   246		if (hv_reenlightenment_cb == NULL)
   247			return 0;
   248	
   249		rdmsrl(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *((u64 *)&re_ctrl));
   250		if (re_ctrl.target_vp == hv_vp_index[cpu]) {
   251			/*
   252			 * Reassign reenlightenment notifications to some other online
   253			 * CPU or just disable the feature if there are no online CPUs
   254			 * left (happens on hibernation).
   255			 */
   256			new_cpu = cpumask_any_but(cpu_online_mask, cpu);
   257	
   258			if (new_cpu < nr_cpu_ids)
   259				re_ctrl.target_vp = hv_vp_index[new_cpu];
   260			else
   261				re_ctrl.enabled = 0;
   262	
   263			wrmsrl(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *((u64 *)&re_ctrl));
   264		}
   265	
   266		return 0;
   267	}
   268	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
