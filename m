Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499367A26F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbjIOTJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbjIOTJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:09:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D2498
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694804936; x=1726340936;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rgBrumOV2mAn5UshKD0Yo3PtckwP8FoTVd5SuXQWTI4=;
  b=gb8f+5ghBhLw55pOmFgBtF9wgAIBexX7L2TLFz14CMJEl5R0YbypsTSX
   QHPhIi0CR1vi2OK6sH950iK+6GlQde9jQ2simtnVyh/XB/OQWF1avamK6
   rF6kAiUoDSKFxc6txuV5ab0Ms2PMBYy9eZHEQovcSTMLV/xi0jbn4Dohv
   5b8S5AQT2OYBtkXMjgnhPI0otirKAPFFbJ7FOmOcOHKbDFNum3jla3WRN
   bS5OYDfQXkTsQ8S/AokdVOjNb3SkiA86aAAG8xDiu8CmpyxMi4XKBq7Mi
   G3xY+/W27u5p9jtDR/2Kaf77h5IRhfyLEiX7DKoLIA6RYzGEnk6LVRcud
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="378235262"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="378235262"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 12:08:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="721794421"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="721794421"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Sep 2023 12:08:54 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qhEB4-0003Jv-08;
        Fri, 15 Sep 2023 19:08:34 +0000
Date:   Sat, 16 Sep 2023 03:07:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Vernet <void@manifault.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: kernel/bpf/cpumask.c:41:21: warning: no previous declaration for
 'bpf_cpumask_create'
Message-ID: <202309160350.D3bbZlsa-lkp@intel.com>
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

Hi David,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9fdfb15a3dbf818e06be514f4abbfc071004cbe7
commit: 516f4d3397c9e90f4da04f59986c856016269aa1 bpf: Enable cpumasks to be queried and used as kptrs
date:   8 months ago
config: x86_64-randconfig-003-20230916 (https://download.01.org/0day-ci/archive/20230916/202309160350.D3bbZlsa-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230916/202309160350.D3bbZlsa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309160350.D3bbZlsa-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/cpumask.c:41:21: warning: no previous declaration for 'bpf_cpumask_create' [-Wmissing-declarations]
    struct bpf_cpumask *bpf_cpumask_create(void)
                        ^~~~~~~~~~~~~~~~~~
>> kernel/bpf/cpumask.c:55:21: warning: no previous declaration for 'bpf_cpumask_acquire' [-Wmissing-declarations]
    struct bpf_cpumask *bpf_cpumask_acquire(struct bpf_cpumask *cpumask)
                        ^~~~~~~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:61:21: warning: no previous declaration for 'bpf_cpumask_kptr_get' [-Wmissing-declarations]
    struct bpf_cpumask *bpf_cpumask_kptr_get(struct bpf_cpumask **cpumaskp)
                        ^~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/cpumask.c:79:6: warning: no previous declaration for 'bpf_cpumask_release' [-Wmissing-declarations]
    void bpf_cpumask_release(struct bpf_cpumask *cpumask)
         ^~~~~~~~~~~~~~~~~~~
>> kernel/bpf/cpumask.c:91:5: warning: no previous declaration for 'bpf_cpumask_first' [-Wmissing-declarations]
    u32 bpf_cpumask_first(const struct cpumask *cpumask)
        ^~~~~~~~~~~~~~~~~
>> kernel/bpf/cpumask.c:96:5: warning: no previous declaration for 'bpf_cpumask_first_zero' [-Wmissing-declarations]
    u32 bpf_cpumask_first_zero(const struct cpumask *cpumask)
        ^~~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/cpumask.c:101:6: warning: no previous declaration for 'bpf_cpumask_set_cpu' [-Wmissing-declarations]
    void bpf_cpumask_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
         ^~~~~~~~~~~~~~~~~~~
>> kernel/bpf/cpumask.c:109:6: warning: no previous declaration for 'bpf_cpumask_clear_cpu' [-Wmissing-declarations]
    void bpf_cpumask_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
         ^~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/cpumask.c:117:6: warning: no previous declaration for 'bpf_cpumask_test_cpu' [-Wmissing-declarations]
    bool bpf_cpumask_test_cpu(u32 cpu, const struct cpumask *cpumask)
         ^~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/cpumask.c:125:6: warning: no previous declaration for 'bpf_cpumask_test_and_set_cpu' [-Wmissing-declarations]
    bool bpf_cpumask_test_and_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/cpumask.c:133:6: warning: no previous declaration for 'bpf_cpumask_test_and_clear_cpu' [-Wmissing-declarations]
    bool bpf_cpumask_test_and_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/cpumask.c:141:6: warning: no previous declaration for 'bpf_cpumask_setall' [-Wmissing-declarations]
    void bpf_cpumask_setall(struct bpf_cpumask *cpumask)
         ^~~~~~~~~~~~~~~~~~
>> kernel/bpf/cpumask.c:146:6: warning: no previous declaration for 'bpf_cpumask_clear' [-Wmissing-declarations]
    void bpf_cpumask_clear(struct bpf_cpumask *cpumask)
         ^~~~~~~~~~~~~~~~~
>> kernel/bpf/cpumask.c:151:6: warning: no previous declaration for 'bpf_cpumask_and' [-Wmissing-declarations]
    bool bpf_cpumask_and(struct bpf_cpumask *dst,
         ^~~~~~~~~~~~~~~
>> kernel/bpf/cpumask.c:158:6: warning: no previous declaration for 'bpf_cpumask_or' [-Wmissing-declarations]
    void bpf_cpumask_or(struct bpf_cpumask *dst,
         ^~~~~~~~~~~~~~
>> kernel/bpf/cpumask.c:165:6: warning: no previous declaration for 'bpf_cpumask_xor' [-Wmissing-declarations]
    void bpf_cpumask_xor(struct bpf_cpumask *dst,
         ^~~~~~~~~~~~~~~
>> kernel/bpf/cpumask.c:172:6: warning: no previous declaration for 'bpf_cpumask_equal' [-Wmissing-declarations]
    bool bpf_cpumask_equal(const struct cpumask *src1, const struct cpumask *src2)
         ^~~~~~~~~~~~~~~~~
>> kernel/bpf/cpumask.c:177:6: warning: no previous declaration for 'bpf_cpumask_intersects' [-Wmissing-declarations]
    bool bpf_cpumask_intersects(const struct cpumask *src1, const struct cpumask *src2)
         ^~~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/cpumask.c:182:6: warning: no previous declaration for 'bpf_cpumask_subset' [-Wmissing-declarations]
    bool bpf_cpumask_subset(const struct cpumask *src1, const struct cpumask *src2)
         ^~~~~~~~~~~~~~~~~~
>> kernel/bpf/cpumask.c:187:6: warning: no previous declaration for 'bpf_cpumask_empty' [-Wmissing-declarations]
    bool bpf_cpumask_empty(const struct cpumask *cpumask)
         ^~~~~~~~~~~~~~~~~
>> kernel/bpf/cpumask.c:192:6: warning: no previous declaration for 'bpf_cpumask_full' [-Wmissing-declarations]
    bool bpf_cpumask_full(const struct cpumask *cpumask)
         ^~~~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:197:6: warning: no previous declaration for 'bpf_cpumask_copy' [-Wmissing-declarations]
    void bpf_cpumask_copy(struct bpf_cpumask *dst, const struct cpumask *src)
         ^~~~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:202:5: warning: no previous declaration for 'bpf_cpumask_any' [-Wmissing-declarations]
    u32 bpf_cpumask_any(const struct cpumask *cpumask)
        ^~~~~~~~~~~~~~~
   kernel/bpf/cpumask.c:207:5: warning: no previous declaration for 'bpf_cpumask_any_and' [-Wmissing-declarations]
    u32 bpf_cpumask_any_and(const struct cpumask *src1, const struct cpumask *src2)
        ^~~~~~~~~~~~~~~~~~~


vim +/bpf_cpumask_create +41 kernel/bpf/cpumask.c

    36	
    37	__diag_push();
    38	__diag_ignore_all("-Wmissing-prototypes",
    39			  "Global kfuncs as their definitions will be in BTF");
    40	
  > 41	struct bpf_cpumask *bpf_cpumask_create(void)
    42	{
    43		struct bpf_cpumask *cpumask;
    44	
    45		cpumask = bpf_mem_alloc(&bpf_cpumask_ma, sizeof(*cpumask));
    46		if (!cpumask)
    47			return NULL;
    48	
    49		memset(cpumask, 0, sizeof(*cpumask));
    50		refcount_set(&cpumask->usage, 1);
    51	
    52		return cpumask;
    53	}
    54	
  > 55	struct bpf_cpumask *bpf_cpumask_acquire(struct bpf_cpumask *cpumask)
    56	{
    57		refcount_inc(&cpumask->usage);
    58		return cpumask;
    59	}
    60	
    61	struct bpf_cpumask *bpf_cpumask_kptr_get(struct bpf_cpumask **cpumaskp)
    62	{
    63		struct bpf_cpumask *cpumask;
    64	
    65		/* The BPF memory allocator frees memory backing its caches in an RCU
    66		 * callback. Thus, we can safely use RCU to ensure that the cpumask is
    67		 * safe to read.
    68		 */
    69		rcu_read_lock();
    70	
    71		cpumask = READ_ONCE(*cpumaskp);
    72		if (cpumask && !refcount_inc_not_zero(&cpumask->usage))
    73			cpumask = NULL;
    74	
    75		rcu_read_unlock();
    76		return cpumask;
    77	}
    78	
  > 79	void bpf_cpumask_release(struct bpf_cpumask *cpumask)
    80	{
    81		if (!cpumask)
    82			return;
    83	
    84		if (refcount_dec_and_test(&cpumask->usage)) {
    85			migrate_disable();
    86			bpf_mem_free(&bpf_cpumask_ma, cpumask);
    87			migrate_enable();
    88		}
    89	}
    90	
  > 91	u32 bpf_cpumask_first(const struct cpumask *cpumask)
    92	{
    93		return cpumask_first(cpumask);
    94	}
    95	
  > 96	u32 bpf_cpumask_first_zero(const struct cpumask *cpumask)
    97	{
    98		return cpumask_first_zero(cpumask);
    99	}
   100	
 > 101	void bpf_cpumask_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
   102	{
   103		if (!cpu_valid(cpu))
   104			return;
   105	
   106		cpumask_set_cpu(cpu, (struct cpumask *)cpumask);
   107	}
   108	
 > 109	void bpf_cpumask_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
   110	{
   111		if (!cpu_valid(cpu))
   112			return;
   113	
   114		cpumask_clear_cpu(cpu, (struct cpumask *)cpumask);
   115	}
   116	
 > 117	bool bpf_cpumask_test_cpu(u32 cpu, const struct cpumask *cpumask)
   118	{
   119		if (!cpu_valid(cpu))
   120			return false;
   121	
   122		return cpumask_test_cpu(cpu, (struct cpumask *)cpumask);
   123	}
   124	
 > 125	bool bpf_cpumask_test_and_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
   126	{
   127		if (!cpu_valid(cpu))
   128			return false;
   129	
   130		return cpumask_test_and_set_cpu(cpu, (struct cpumask *)cpumask);
   131	}
   132	
 > 133	bool bpf_cpumask_test_and_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
   134	{
   135		if (!cpu_valid(cpu))
   136			return false;
   137	
   138		return cpumask_test_and_clear_cpu(cpu, (struct cpumask *)cpumask);
   139	}
   140	
 > 141	void bpf_cpumask_setall(struct bpf_cpumask *cpumask)
   142	{
   143		cpumask_setall((struct cpumask *)cpumask);
   144	}
   145	
 > 146	void bpf_cpumask_clear(struct bpf_cpumask *cpumask)
   147	{
   148		cpumask_clear((struct cpumask *)cpumask);
   149	}
   150	
 > 151	bool bpf_cpumask_and(struct bpf_cpumask *dst,
   152			     const struct cpumask *src1,
   153			     const struct cpumask *src2)
   154	{
   155		return cpumask_and((struct cpumask *)dst, src1, src2);
   156	}
   157	
 > 158	void bpf_cpumask_or(struct bpf_cpumask *dst,
   159			    const struct cpumask *src1,
   160			    const struct cpumask *src2)
   161	{
   162		cpumask_or((struct cpumask *)dst, src1, src2);
   163	}
   164	
 > 165	void bpf_cpumask_xor(struct bpf_cpumask *dst,
   166			     const struct cpumask *src1,
   167			     const struct cpumask *src2)
   168	{
   169		cpumask_xor((struct cpumask *)dst, src1, src2);
   170	}
   171	
 > 172	bool bpf_cpumask_equal(const struct cpumask *src1, const struct cpumask *src2)
   173	{
   174		return cpumask_equal(src1, src2);
   175	}
   176	
 > 177	bool bpf_cpumask_intersects(const struct cpumask *src1, const struct cpumask *src2)
   178	{
   179		return cpumask_intersects(src1, src2);
   180	}
   181	
 > 182	bool bpf_cpumask_subset(const struct cpumask *src1, const struct cpumask *src2)
   183	{
   184		return cpumask_subset(src1, src2);
   185	}
   186	
 > 187	bool bpf_cpumask_empty(const struct cpumask *cpumask)
   188	{
   189		return cpumask_empty(cpumask);
   190	}
   191	
 > 192	bool bpf_cpumask_full(const struct cpumask *cpumask)
   193	{
   194		return cpumask_full(cpumask);
   195	}
   196	
 > 197	void bpf_cpumask_copy(struct bpf_cpumask *dst, const struct cpumask *src)
   198	{
   199		cpumask_copy((struct cpumask *)dst, src);
   200	}
   201	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
