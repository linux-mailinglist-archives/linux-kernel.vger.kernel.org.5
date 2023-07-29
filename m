Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85447681D3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 22:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjG2Umh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 16:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG2Umg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 16:42:36 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95856134
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 13:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690663354; x=1722199354;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K6DFC6MulgB643qbjFg/D4n6h0V/KwiJQP5vs6znntI=;
  b=lfsLE3E3/F+guIa85QUNJJ64xwOOPXcwDFI5BJn70RDhqs+uHNHkMxie
   SzWEkzDd13XTcRe9iJ4tcByMleRRsFNbKROgAu4JadRS6aAXjPdewNomP
   75K1I7kfOIvajXsW+qxGYGDME/3Rr2g4hTcbp4TkElaipqvjJ4XrGKyce
   ehqxgD+VxQkwOjB/COL/6aAjSbYbBwKOqwIbpbGoH2c950OVS8JxB7LzF
   BxQpS0yR9tJilbYR2pDEw2niwAk2TvEfgLEUUsh56DhkQrORmvstbbGEj
   WZ9fGjpR7tSNJ9J/+r8bAW2SEZsHvGTz227E/eM9l7m7+M7PF8W3RHXdH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="455151509"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="455151509"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2023 13:42:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="841702363"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="841702363"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jul 2023 13:42:18 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPqlW-0004IF-0n;
        Sat, 29 Jul 2023 20:42:18 +0000
Date:   Sun, 30 Jul 2023 04:41:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: arch/x86/kernel/callthunks.c:303:20: sparse: sparse: incorrect type
 in initializer (different address spaces)
Message-ID: <202307300433.nmumrsXO-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   12214540ad87ce824a8a791a3f063e6121ec5b66
commit: f5c1bb2afe93396d41c5cbdcb909b08a75b8dde4 x86/calldepth: Add ret/call counting for debug
date:   10 months ago
config: x86_64-randconfig-x062-20230729 (https://download.01.org/0day-ci/archive/20230730/202307300433.nmumrsXO-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230730/202307300433.nmumrsXO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307300433.nmumrsXO-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/x86/kernel/callthunks.c:303:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/x86/kernel/callthunks.c:303:20: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/kernel/callthunks.c:303:20: sparse:     got unsigned long long *
   arch/x86/kernel/callthunks.c:306:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/x86/kernel/callthunks.c:306:20: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/kernel/callthunks.c:306:20: sparse:     got unsigned long long *

vim +303 arch/x86/kernel/callthunks.c

   296	
   297	#if defined(CONFIG_CALL_THUNKS_DEBUG) && defined(CONFIG_DEBUG_FS)
   298	static int callthunks_debug_show(struct seq_file *m, void *p)
   299	{
   300		unsigned long cpu = (unsigned long)m->private;
   301	
   302		seq_printf(m, "C: %16llu R: %16llu S: %16llu X: %16llu\n,",
 > 303			   per_cpu(__x86_call_count, cpu),
   304			   per_cpu(__x86_ret_count, cpu),
   305			   per_cpu(__x86_stuffs_count, cpu),
   306			   per_cpu(__x86_ctxsw_count, cpu));
   307		return 0;
   308	}
   309	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
