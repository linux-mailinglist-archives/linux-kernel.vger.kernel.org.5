Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24627BBE57
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 20:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjJFSFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 14:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjJFSF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:05:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610F0BE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 11:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696615528; x=1728151528;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JGxeA53DeaKrWwQYPhwmExeafhmjcPav9jvfM8ZXgqg=;
  b=Q61IbcbQpqTJP+S7i9SfKZszESvuciBVviliFMIeoaPDJovfgEWEkkxm
   s1WJloQiZkrcp2Dga5GX8GIzqxIWWecuWG1yzvC4+HMKsLZ6aVuFo5iXG
   C0SkshEOIJt+OQc6QwJb/fveh2WlDwzHjpr4lfdCCMPxyKW9qN6ZOIyoe
   xHTGoV+R4Xge7gAiVDQyMahtC3UjgT55YX36GXebeExOksOU3b5vK74ss
   axpR55yyaKQqUf9juJPWMZn8LAYWp2lpL7jad6935WBoS8DSQXuHjcUNV
   7x1+JBqAgEQTbRWHOMaHd5tWyx9sSe0s1ZyjSX8gH0NcrwGpbQ6YfBzri
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="364084259"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="364084259"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 11:05:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="876026412"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="876026412"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 06 Oct 2023 11:05:25 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qopCV-0003VF-1t;
        Fri, 06 Oct 2023 18:05:23 +0000
Date:   Sat, 7 Oct 2023 02:04:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Paul Burton <paulburton@kernel.org>
Subject: arch/mips/kernel/spram.c:194:6: warning: no previous prototype for
 'spram_config'
Message-ID: <202310070246.8CwDzTcs-lkp@intel.com>
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
head:   af95dc6fdc25e616051d0234aad638e15c02ec8f
commit: 51522217f65f1f937f421d9f417cf0e714ef3c02 MIPS: Loongson64: Bump ISA level to MIPSR2
date:   3 years, 8 months ago
config: mips-loongson3_defconfig (https://download.01.org/0day-ci/archive/20231007/202310070246.8CwDzTcs-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310070246.8CwDzTcs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310070246.8CwDzTcs-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/mips/kernel/spram.c:8:
   include/linux/mmzone.h: In function '__nr_to_section':
   include/linux/mmzone.h:1255:13: warning: the comparison will always evaluate as 'true' for the address of 'mem_section' will never be NULL [-Waddress]
    1255 |         if (!mem_section[SECTION_NR_TO_ROOT(nr)])
         |             ^
   include/linux/mmzone.h:1241:27: note: 'mem_section' declared here
    1241 | extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
         |                           ^~~~~~~~~~~
   arch/mips/kernel/spram.c: At top level:
>> arch/mips/kernel/spram.c:194:6: warning: no previous prototype for 'spram_config' [-Wmissing-prototypes]
     194 | void spram_config(void)
         |      ^~~~~~~~~~~~


vim +/spram_config +194 arch/mips/kernel/spram.c

0b6d497fcbb72b35 Chris Dearman  2007-09-13  112  
078a55fc824c1633 Paul Gortmaker 2013-06-18  113  static void probe_spram(char *type,
0b6d497fcbb72b35 Chris Dearman  2007-09-13  114  	    unsigned int base,
0b6d497fcbb72b35 Chris Dearman  2007-09-13  115  	    unsigned int (*read)(unsigned int),
0b6d497fcbb72b35 Chris Dearman  2007-09-13  116  	    void (*write)(unsigned int, unsigned int))
0b6d497fcbb72b35 Chris Dearman  2007-09-13  117  {
0b6d497fcbb72b35 Chris Dearman  2007-09-13  118  	unsigned int firstsize = 0, lastsize = 0;
0b6d497fcbb72b35 Chris Dearman  2007-09-13  119  	unsigned int firstpa = 0, lastpa = 0, pa = 0;
0b6d497fcbb72b35 Chris Dearman  2007-09-13  120  	unsigned int offset = 0;
0b6d497fcbb72b35 Chris Dearman  2007-09-13  121  	unsigned int size, tag0, tag1;
0b6d497fcbb72b35 Chris Dearman  2007-09-13  122  	unsigned int enabled;
0b6d497fcbb72b35 Chris Dearman  2007-09-13  123  	int i;
0b6d497fcbb72b35 Chris Dearman  2007-09-13  124  
0b6d497fcbb72b35 Chris Dearman  2007-09-13  125  	/*
0b6d497fcbb72b35 Chris Dearman  2007-09-13  126  	 * The limit is arbitrary but avoids the loop running away if
0b6d497fcbb72b35 Chris Dearman  2007-09-13  127  	 * the SPRAM tags are implemented differently
0b6d497fcbb72b35 Chris Dearman  2007-09-13  128  	 */
0b6d497fcbb72b35 Chris Dearman  2007-09-13  129  
0b6d497fcbb72b35 Chris Dearman  2007-09-13  130  	for (i = 0; i < 8; i++) {
0b6d497fcbb72b35 Chris Dearman  2007-09-13  131  		tag0 = read(offset);
0b6d497fcbb72b35 Chris Dearman  2007-09-13  132  		tag1 = read(offset+SPRAM_TAG_STRIDE);
0b6d497fcbb72b35 Chris Dearman  2007-09-13  133  		pr_debug("DBG %s%d: tag0=%08x tag1=%08x\n",
0b6d497fcbb72b35 Chris Dearman  2007-09-13  134  			 type, i, tag0, tag1);
0b6d497fcbb72b35 Chris Dearman  2007-09-13  135  
0b6d497fcbb72b35 Chris Dearman  2007-09-13  136  		size = tag1 & SPRAM_TAG1_SIZE_MASK;
0b6d497fcbb72b35 Chris Dearman  2007-09-13  137  
0b6d497fcbb72b35 Chris Dearman  2007-09-13  138  		if (size == 0)
0b6d497fcbb72b35 Chris Dearman  2007-09-13  139  			break;
0b6d497fcbb72b35 Chris Dearman  2007-09-13  140  
0b6d497fcbb72b35 Chris Dearman  2007-09-13  141  		if (i != 0) {
0b6d497fcbb72b35 Chris Dearman  2007-09-13  142  			/* tags may repeat... */
0b6d497fcbb72b35 Chris Dearman  2007-09-13  143  			if ((pa == firstpa && size == firstsize) ||
0b6d497fcbb72b35 Chris Dearman  2007-09-13  144  			    (pa == lastpa && size == lastsize))
0b6d497fcbb72b35 Chris Dearman  2007-09-13  145  				break;
0b6d497fcbb72b35 Chris Dearman  2007-09-13  146  		}
0b6d497fcbb72b35 Chris Dearman  2007-09-13  147  
0b6d497fcbb72b35 Chris Dearman  2007-09-13  148  		/* Align base with size */
0b6d497fcbb72b35 Chris Dearman  2007-09-13  149  		base = (base + size - 1) & ~(size-1);
0b6d497fcbb72b35 Chris Dearman  2007-09-13  150  
0b6d497fcbb72b35 Chris Dearman  2007-09-13  151  		/* reprogram the base address base address and enable */
0b6d497fcbb72b35 Chris Dearman  2007-09-13  152  		tag0 = (base & SPRAM_TAG0_PA_MASK) | SPRAM_TAG0_ENABLE;
0b6d497fcbb72b35 Chris Dearman  2007-09-13  153  		write(offset, tag0);
0b6d497fcbb72b35 Chris Dearman  2007-09-13  154  
0b6d497fcbb72b35 Chris Dearman  2007-09-13  155  		base += size;
0b6d497fcbb72b35 Chris Dearman  2007-09-13  156  
0b6d497fcbb72b35 Chris Dearman  2007-09-13  157  		/* reread the tag */
0b6d497fcbb72b35 Chris Dearman  2007-09-13  158  		tag0 = read(offset);
0b6d497fcbb72b35 Chris Dearman  2007-09-13  159  		pa = tag0 & SPRAM_TAG0_PA_MASK;
0b6d497fcbb72b35 Chris Dearman  2007-09-13  160  		enabled = tag0 & SPRAM_TAG0_ENABLE;
0b6d497fcbb72b35 Chris Dearman  2007-09-13  161  
0b6d497fcbb72b35 Chris Dearman  2007-09-13  162  		if (i == 0) {
0b6d497fcbb72b35 Chris Dearman  2007-09-13  163  			firstpa = pa;
0b6d497fcbb72b35 Chris Dearman  2007-09-13  164  			firstsize = size;
0b6d497fcbb72b35 Chris Dearman  2007-09-13  165  		}
0b6d497fcbb72b35 Chris Dearman  2007-09-13  166  
0b6d497fcbb72b35 Chris Dearman  2007-09-13  167  		lastpa = pa;
0b6d497fcbb72b35 Chris Dearman  2007-09-13  168  		lastsize = size;
0b6d497fcbb72b35 Chris Dearman  2007-09-13  169  
0b6d497fcbb72b35 Chris Dearman  2007-09-13  170  		if (strcmp(type, "DSPRAM") == 0) {
0b6d497fcbb72b35 Chris Dearman  2007-09-13  171  			unsigned int *vp = (unsigned int *)(CKSEG1 | pa);
0b6d497fcbb72b35 Chris Dearman  2007-09-13  172  			unsigned int v;
0b6d497fcbb72b35 Chris Dearman  2007-09-13  173  #define TDAT	0x5a5aa5a5
0b6d497fcbb72b35 Chris Dearman  2007-09-13  174  			vp[0] = TDAT;
0b6d497fcbb72b35 Chris Dearman  2007-09-13  175  			vp[1] = ~TDAT;
0b6d497fcbb72b35 Chris Dearman  2007-09-13  176  
0b6d497fcbb72b35 Chris Dearman  2007-09-13  177  			mb();
0b6d497fcbb72b35 Chris Dearman  2007-09-13  178  
0b6d497fcbb72b35 Chris Dearman  2007-09-13  179  			v = vp[0];
0b6d497fcbb72b35 Chris Dearman  2007-09-13  180  			if (v != TDAT)
0b6d497fcbb72b35 Chris Dearman  2007-09-13  181  				printk(KERN_ERR "vp=%p wrote=%08x got=%08x\n",
0b6d497fcbb72b35 Chris Dearman  2007-09-13  182  				       vp, TDAT, v);
0b6d497fcbb72b35 Chris Dearman  2007-09-13  183  			v = vp[1];
0b6d497fcbb72b35 Chris Dearman  2007-09-13  184  			if (v != ~TDAT)
0b6d497fcbb72b35 Chris Dearman  2007-09-13  185  				printk(KERN_ERR "vp=%p wrote=%08x got=%08x\n",
0b6d497fcbb72b35 Chris Dearman  2007-09-13  186  				       vp+1, ~TDAT, v);
0b6d497fcbb72b35 Chris Dearman  2007-09-13  187  		}
0b6d497fcbb72b35 Chris Dearman  2007-09-13  188  
0b6d497fcbb72b35 Chris Dearman  2007-09-13  189  		pr_info("%s%d: PA=%08x,Size=%08x%s\n",
0b6d497fcbb72b35 Chris Dearman  2007-09-13  190  			type, i, pa, size, enabled ? ",enabled" : "");
0b6d497fcbb72b35 Chris Dearman  2007-09-13  191  		offset += 2 * SPRAM_TAG_STRIDE;
0b6d497fcbb72b35 Chris Dearman  2007-09-13  192  	}
0b6d497fcbb72b35 Chris Dearman  2007-09-13  193  }
078a55fc824c1633 Paul Gortmaker 2013-06-18 @194  void spram_config(void)

:::::: The code at line 194 was first introduced by commit
:::::: 078a55fc824c1633b3a507e4ad48b4637c1dfc18 MIPS: Delete __cpuinit/__CPUINIT usage from MIPS code

:::::: TO: Paul Gortmaker <paul.gortmaker@windriver.com>
:::::: CC: Paul Gortmaker <paul.gortmaker@windriver.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
