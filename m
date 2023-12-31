Return-Path: <linux-kernel+bounces-13628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 244398209A1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 04:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72E91F22206
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 03:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF9E1371;
	Sun, 31 Dec 2023 03:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nFyRa6B/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C170BEB8
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 03:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703993319; x=1735529319;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/y1Ti7bBLbT852DZdMqugdPa8oJ5gQVHqVgwRCteU6I=;
  b=nFyRa6B/KsbG5ri0sHoL6+b5VMsmLF9qeBbWrPLemM05a3+lTBs+V+By
   vjOEcTQDNekV8Hk8zor7mQUqVdmuOSXLHWPhIFw5z75226OVPgJT2yzv3
   R1JmGCMBm5sD4hmIX3aBhQgZz6Xlz1efE4JRVNImleEy2dZ0dJUmcTEMz
   BB6Moo0B3EaHHQTsbK85Z6pevG1dO8tk8+ui/QgOcyryD6IUdmTod3EAo
   4TDR4CVyYfu3q278qwKjbK+jScHypXVl/ljohEbj+xCESR7RGdkveX0W5
   KnUB31V85RF98C/ElpVDgFL+UrolOpaUZkxfj2fjOyAvzG0XjK5qlwoyY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10939"; a="10123636"
X-IronPort-AV: E=Sophos;i="6.04,319,1695711600"; 
   d="scan'208";a="10123636"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2023 19:28:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10939"; a="902572982"
X-IronPort-AV: E=Sophos;i="6.04,319,1695711600"; 
   d="scan'208";a="902572982"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 30 Dec 2023 19:28:37 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJmV9-000IyP-1S;
	Sun, 31 Dec 2023 03:28:35 +0000
Date: Sun, 31 Dec 2023 11:28:00 +0800
From: kernel test robot <lkp@intel.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/kernel/switch.S:170: Error: operand out of range
 (0xfe10 is not between 0xffffffffffff8000 and 0x7fff)
Message-ID: <202312311135.Nh024ziD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   453f5db0619e2ad64076aab16ff5a00e0f7c53a2
commit: afc6386815a88d067d9f567dcc6266800286f626 powerpc: merge 32-bit and 64-bit _switch implementation
date:   7 months ago
config: powerpc64-randconfig-r052-20231226 (https://download.01.org/0day-ci/archive/20231231/202312311135.Nh024ziD-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231231/202312311135.Nh024ziD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312311135.Nh024ziD-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/switch.S: Assembler messages:
>> arch/powerpc/kernel/switch.S:170: Error: operand out of range (0xfe10 is not between 0xffffffffffff8000 and 0x7fff)
   arch/powerpc/kernel/switch.S:249:  Info: macro invoked from here


vim +170 arch/powerpc/kernel/switch.S

   151	
   152	.macro do_switch_64
   153		ld	r8,KSP(r4)	/* Load new stack pointer */
   154	
   155		kuap_check_amr r9, r10
   156	
   157		FLUSH_COUNT_CACHE	/* Clobbers r9, ctr */
   158	
   159		STOP_STREAMS		/* Clobbers r6 */
   160	
   161		addi	r3,r3,-THREAD	/* old thread -> task_struct for return value */
   162		addi	r6,r4,-THREAD	/* new thread -> task_struct */
   163		std	r6,PACACURRENT(r13)	/* Set new task_struct to 'current' */
   164	#if defined(CONFIG_STACKPROTECTOR)
   165		ld	r6, TASK_CANARY(r6)
   166		std	r6, PACA_CANARY(r13)
   167	#endif
   168		/* Set new PACAKSAVE */
   169		clrrdi	r7,r8,THREAD_SHIFT	/* base of new stack */
 > 170		addi	r7,r7,THREAD_SIZE-SWITCH_FRAME_SIZE
   171		std	r7,PACAKSAVE(r13)
   172	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

