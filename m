Return-Path: <linux-kernel+bounces-257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 313EE813E62
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1BD21F22AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264B32DB61;
	Thu, 14 Dec 2023 23:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nwT1RK+4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3566C6FD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702597716; x=1734133716;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ulvggAM+hEB3dBJmGI1RltxMRtuffozXg9K4ZybPd20=;
  b=nwT1RK+4sqxXc8Et2EzuAfGbzmvBbtfFgalSNDxNM05e7bEvQWLN9GXg
   CFlOfD33I97Ze5b8y4wETOOr4FAKLSKiKz/UigDp4RDJYqIjDPFco7AHw
   DVKHEBVYHqK/Z7h/h3LGWgIJwjLpXKpNU1GDEWTsNWT8hm7v5cml0xvB1
   YB0a/aDiJuBWSWwKCN6pTvUrfK50fP0kgneh8JjtfZNjato6epCiLsjl8
   ac2k8PvWAMvt4xA6d6ZbmxC9Sotz1RqbQhKKcGMNZJ96c4qMkJpX5wVrL
   QhWp2Vh7god6OesujhOUfrL5cAVXB4pkIUhE3QqwhusASrBQC250FEd2x
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2058220"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="2058220"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 15:48:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="844910735"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="844910735"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 14 Dec 2023 15:48:34 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDvRM-000MkX-1V;
	Thu, 14 Dec 2023 23:48:30 +0000
Date: Fri, 15 Dec 2023 07:48:24 +0800
From: kernel test robot <lkp@intel.com>
To: Grygorii Strashko <grygorii.strashko@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: arch/arm/mm/init.c:718: warning: Function parameter or member
 'perms' not described in 'update_sections_early'
Message-ID: <202312150743.bwMvCOJ8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c7402612e2e61b76177f22e6e7f705adcbecc6fe
commit: 11ce4b33aedc65198d7bc9669344ebca5ee36a41 ARM: 8672/1: mm: remove tasklist locking from update_sections_early()
date:   7 years ago
config: arm-s3c6400_defconfig (https://download.01.org/0day-ci/archive/20231215/202312150743.bwMvCOJ8-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312150743.bwMvCOJ8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150743.bwMvCOJ8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/arm/mm/init.c:128:13: warning: no previous prototype for 'setup_dma_zone' [-Wmissing-prototypes]
     128 | void __init setup_dma_zone(const struct machine_desc *mdesc)
         |             ^~~~~~~~~~~~~~
   arch/arm/mm/init.c:769:6: warning: no previous prototype for 'free_tcmmem' [-Wmissing-prototypes]
     769 | void free_tcmmem(void)
         |      ^~~~~~~~~~~
>> arch/arm/mm/init.c:718: warning: Function parameter or member 'perms' not described in 'update_sections_early'
>> arch/arm/mm/init.c:718: warning: Function parameter or member 'n' not described in 'update_sections_early'


vim +718 arch/arm/mm/init.c

1e6b48116a9504 Kees Cook         2014-04-03  711  
11ce4b33aedc65 Grygorii Strashko 2017-04-25  712  /**
11ce4b33aedc65 Grygorii Strashko 2017-04-25  713   * update_sections_early intended to be called only through stop_machine
11ce4b33aedc65 Grygorii Strashko 2017-04-25  714   * framework and executed by only one CPU while all other CPUs will spin and
11ce4b33aedc65 Grygorii Strashko 2017-04-25  715   * wait, so no locking is required in this function.
11ce4b33aedc65 Grygorii Strashko 2017-04-25  716   */
08925c2f124f1b Laura Abbott      2015-11-30  717  static void update_sections_early(struct section_perm perms[], int n)
1e6b48116a9504 Kees Cook         2014-04-03 @718  {
08925c2f124f1b Laura Abbott      2015-11-30  719  	struct task_struct *t, *s;
08925c2f124f1b Laura Abbott      2015-11-30  720  
08925c2f124f1b Laura Abbott      2015-11-30  721  	for_each_process(t) {
08925c2f124f1b Laura Abbott      2015-11-30  722  		if (t->flags & PF_KTHREAD)
08925c2f124f1b Laura Abbott      2015-11-30  723  			continue;
08925c2f124f1b Laura Abbott      2015-11-30  724  		for_each_thread(t, s)
08925c2f124f1b Laura Abbott      2015-11-30  725  			set_section_perms(perms, n, true, s->mm);
08925c2f124f1b Laura Abbott      2015-11-30  726  	}
08925c2f124f1b Laura Abbott      2015-11-30  727  	set_section_perms(perms, n, true, current->active_mm);
08925c2f124f1b Laura Abbott      2015-11-30  728  	set_section_perms(perms, n, true, &init_mm);
08925c2f124f1b Laura Abbott      2015-11-30  729  }
08925c2f124f1b Laura Abbott      2015-11-30  730  

:::::: The code at line 718 was first introduced by commit
:::::: 1e6b48116a95046ec51f3d40f83aff8b006674d7 ARM: mm: allow non-text sections to be non-executable

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Kees Cook <keescook@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

