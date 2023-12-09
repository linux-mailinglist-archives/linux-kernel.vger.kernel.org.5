Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7DD80B47E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 14:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjLINBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 08:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjLINB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 08:01:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482F3172B
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 05:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702126880; x=1733662880;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yZISQe5JW7IsurlA6TgRETGGnFbT5OQryncOU8eiQKY=;
  b=jX7bhqOMmA+ui0ulnIdb3UJUVMdqk7iPa/KVnRT8Q60jAXM1nXMxXOCZ
   SN+d5Xobxl1Fjw9gCaoyduWRF0jD0mw4BOnzDSnEiPeJOON2uRc5JFLYY
   H9kdJHSsb1EsPzOPekNim9HRxshmnp29GWaKJILSRcTQevojYsFPA9d9a
   O2h4wOqbXuRckuK+/xXRpSryXRRY6dRsQcu2gSHq08+zjpvwxb5pYEiiy
   Ym+3GWmPIUTKv9zplwUWcUzGQ2NssMyL0PUpVDueVdh4IcJ78GPsPNC/R
   4vLDOOV/0yVNw4DCOEvzXMRvvvdLI3AFM2a5lwK6RiC3PpKde5D+c0cbx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="374670842"
X-IronPort-AV: E=Sophos;i="6.04,263,1695711600"; 
   d="scan'208";a="374670842"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 05:01:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="722158056"
X-IronPort-AV: E=Sophos;i="6.04,263,1695711600"; 
   d="scan'208";a="722158056"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 09 Dec 2023 05:01:17 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBwxH-000FMj-1N;
        Sat, 09 Dec 2023 13:01:15 +0000
Date:   Sat, 9 Dec 2023 21:00:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: arch/x86/mm/pgtable.c:600: warning: Function parameter or member
 'p4d' not described in 'p4d_set_huge'
Message-ID: <202312092055.UWtOrFJM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f2e8a57ee9036c7d5443382b6c3c09b51a92ec7e
commit: b8504058a06bd19286c8b59539eebfda69d1ecb5 x86/mm: Add basic defines/helpers for CONFIG_X86_5LEVEL=y
date:   7 years ago
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20231209/202312092055.UWtOrFJM-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231209/202312092055.UWtOrFJM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312092055.UWtOrFJM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/mm/pgtable.c: In function 'pgd_alloc':
   arch/x86/mm/pgtable.c:380:13: warning: 'preallocate_pmds' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
     380 |         if (preallocate_pmds(mm, pmds) != 0)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/mm/pgtable.c:380:13: note: referencing argument 2 of type 'pmd_t *[0]'
   arch/x86/mm/pgtable.c:214:12: note: in a call to function 'preallocate_pmds'
     214 | static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[])
         |            ^~~~~~~~~~~~~~~~
   arch/x86/mm/pgtable.c:401:9: warning: 'free_pmds' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
     401 |         free_pmds(mm, pmds);
         |         ^~~~~~~~~~~~~~~~~~~
   arch/x86/mm/pgtable.c:401:9: note: referencing argument 2 of type 'pmd_t *[0]'
   arch/x86/mm/pgtable.c:202:13: note: in a call to function 'free_pmds'
     202 | static void free_pmds(struct mm_struct *mm, pmd_t *pmds[])
         |             ^~~~~~~~~
   arch/x86/mm/pgtable.c:394:9: warning: 'pgd_prepopulate_pmd' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
     394 |         pgd_prepopulate_pmd(mm, pgd, pmds);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/mm/pgtable.c:394:9: note: referencing argument 3 of type 'pmd_t *[0]'
   arch/x86/mm/pgtable.c:270:13: note: in a call to function 'pgd_prepopulate_pmd'
     270 | static void pgd_prepopulate_pmd(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmds[])
         |             ^~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/bitops.h: Assembler messages:
   arch/x86/include/asm/bitops.h:265: Warning: no instruction mnemonic suffix given and no register operands; using default for `btr'
   arch/x86/include/asm/bitops.h:265: Warning: no instruction mnemonic suffix given and no register operands; using default for `btr'
   arch/x86/mm/pgtable.c:563: warning: Function parameter or member 'reserve' not described in 'reserve_top_address'
>> arch/x86/mm/pgtable.c:600: warning: Function parameter or member 'p4d' not described in 'p4d_set_huge'
>> arch/x86/mm/pgtable.c:600: warning: Function parameter or member 'addr' not described in 'p4d_set_huge'
>> arch/x86/mm/pgtable.c:600: warning: Function parameter or member 'prot' not described in 'p4d_set_huge'
>> arch/x86/mm/pgtable.c:610: warning: Function parameter or member 'p4d' not described in 'p4d_clear_huge'
   arch/x86/mm/pgtable.c:634: warning: Function parameter or member 'pud' not described in 'pud_set_huge'
   arch/x86/mm/pgtable.c:634: warning: Function parameter or member 'addr' not described in 'pud_set_huge'
   arch/x86/mm/pgtable.c:634: warning: Function parameter or member 'prot' not described in 'pud_set_huge'
   arch/x86/mm/pgtable.c:659: warning: Function parameter or member 'pmd' not described in 'pmd_set_huge'
   arch/x86/mm/pgtable.c:659: warning: Function parameter or member 'addr' not described in 'pmd_set_huge'
   arch/x86/mm/pgtable.c:659: warning: Function parameter or member 'prot' not described in 'pmd_set_huge'
   arch/x86/mm/pgtable.c:685: warning: Function parameter or member 'pud' not described in 'pud_clear_huge'
   arch/x86/mm/pgtable.c:700: warning: Function parameter or member 'pmd' not described in 'pmd_clear_huge'


vim +600 arch/x86/mm/pgtable.c

   591	
   592	#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
   593	#ifdef CONFIG_X86_5LEVEL
   594	/**
   595	 * p4d_set_huge - setup kernel P4D mapping
   596	 *
   597	 * No 512GB pages yet -- always return 0
   598	 */
   599	int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t prot)
 > 600	{
   601		return 0;
   602	}
   603	
   604	/**
   605	 * p4d_clear_huge - clear kernel P4D mapping when it is set
   606	 *
   607	 * No 512GB pages yet -- always return 0
   608	 */
   609	int p4d_clear_huge(p4d_t *p4d)
 > 610	{
   611		return 0;
   612	}
   613	#endif
   614	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
