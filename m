Return-Path: <linux-kernel+bounces-22153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F49829A0C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915C41F213E3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A74947F5D;
	Wed, 10 Jan 2024 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bTqvLxCV"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF4447F5F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704887944; x=1736423944;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/QdH6kRQ236+guhsbkCOMJQvN+dOj67iSemfGrJcy1I=;
  b=bTqvLxCVkbjfNBH1na5OCZ9bURXFXp78xIHqXIG05cZCONOii4XsLgj9
   iFCz5iIYF4B0DLGefPzRckqXMyKWkehsjOwe6O+CqMnadixO8vFqcpbEw
   KxN+L++Bo+bhaFEbHG0+UYJcTss6SdPeRbu0Q5TRj4LTOItpVMc7rmkgg
   J7OjNZLW1dlA+wKAFim55yvdzruT/u10XkaafHyf5ph42gzDnzUbH6/4n
   wEph4Iug+hpXaGcxM+/hXq2n5Og5noL6GfpFOB4FNy2KifxsFfrfLXGKh
   PcpEovHEkUppcQAZuZbGi8huf4by66Swir8rxfTc2AwyOB6NRcm10Izc8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="397348025"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="397348025"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 03:59:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="1029132155"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="1029132155"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jan 2024 03:59:02 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNXEa-0006xw-0B;
	Wed, 10 Jan 2024 11:59:00 +0000
Date: Wed, 10 Jan 2024 19:58:51 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Subject: lib/overflow_kunit.c:998:9: sparse: sparse: cast truncates bits from
 constant value (ffffff01 becomes 1)
Message-ID: <202401101916.N7fPxjk2-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ab27740f76654ed58dd32ac0ba0031c18a6dea3b
commit: 4b21d25bf519c9487935a664886956bb18f04f6d overflow: Introduce overflows_type() and castable_to_type()
date:   1 year, 2 months ago
config: arm-randconfig-r122-20240105 (https://download.01.org/0day-ci/archive/20240110/202401101916.N7fPxjk2-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240110/202401101916.N7fPxjk2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401101916.N7fPxjk2-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   lib/overflow_kunit.c:300:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:300:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:300:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:300:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:300:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:300:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:300:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:300:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:301:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:301:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:301:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:301:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:301:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:301:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:301:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:301:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:301:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:301:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:302:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:302:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:302:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:302:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:302:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:302:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:302:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:302:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:302:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:302:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:303:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:303:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:303:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:303:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:303:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:303:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:303:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:303:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:303:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:303:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:304:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:304:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:304:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:304:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:304:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:304:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:304:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:304:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:304:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:304:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:313:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:313:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:313:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:313:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:313:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:313:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:313:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:313:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:313:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:313:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:319:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:319:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:319:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:319:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:319:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:319:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:319:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:319:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:319:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:319:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:326:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:326:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:326:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:326:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:326:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:326:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:326:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:326:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:326:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:326:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:333:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:333:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:333:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:333:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:333:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:333:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:333:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:333:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:333:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:333:1: sparse: sparse: self-comparison always evaluates to true
   lib/overflow_kunit.c:427:9: sparse: sparse: cast truncates bits from constant value (12c becomes 2c)
   lib/overflow_kunit.c:429:9: sparse: sparse: cast truncates bits from constant value (1112c becomes 112c)
   lib/overflow_kunit.c:431:9: sparse: sparse: cast truncates bits from constant value (10811112c becomes 811112c)
   lib/overflow_kunit.c:432:9: sparse: sparse: cast truncates bits from constant value (10811112c becomes 811112c)
   lib/overflow_kunit.c:449:9: sparse: sparse: cast truncates bits from constant value (12c becomes 2c)
   lib/overflow_kunit.c:451:9: sparse: sparse: cast truncates bits from constant value (1112c becomes 112c)
   lib/overflow_kunit.c:453:9: sparse: sparse: cast truncates bits from constant value (10811112c becomes 811112c)
   lib/overflow_kunit.c:454:9: sparse: sparse: cast truncates bits from constant value (10811112c becomes 811112c)
   lib/overflow_kunit.c:466:9: sparse: sparse: cast truncates bits from constant value (100 becomes 0)
   lib/overflow_kunit.c:468:9: sparse: sparse: cast truncates bits from constant value (10000 becomes 0)
   lib/overflow_kunit.c:470:9: sparse: sparse: cast truncates bits from constant value (100000000 becomes 0)
   lib/overflow_kunit.c:471:9: sparse: sparse: cast truncates bits from constant value (100000000 becomes 0)
>> lib/overflow_kunit.c:998:9: sparse: sparse: cast truncates bits from constant value (ffffff01 becomes 1)
>> lib/overflow_kunit.c:998:9: sparse: sparse: cast truncates bits from constant value (ffffff01 becomes 1)
>> lib/overflow_kunit.c:998:9: sparse: sparse: cast truncates bits from constant value (ffffff01 becomes 1)
>> lib/overflow_kunit.c:998:9: sparse: sparse: cast truncates bits from constant value (ffff0001 becomes 1)
>> lib/overflow_kunit.c:998:9: sparse: sparse: cast truncates bits from constant value (ffffff01 becomes 1)
>> lib/overflow_kunit.c:998:9: sparse: sparse: cast truncates bits from constant value (ffffff01 becomes 1)
>> lib/overflow_kunit.c:998:9: sparse: sparse: cast truncates bits from constant value (ffffff01 becomes 1)
>> lib/overflow_kunit.c:998:9: sparse: sparse: cast truncates bits from constant value (ffffff01 becomes 1)
   lib/overflow_kunit.c:999:9: sparse: sparse: cast truncates bits from constant value (ffff0001 becomes 1)
   lib/overflow_kunit.c:999:9: sparse: sparse: cast truncates bits from constant value (ffffff01 becomes 1)
   lib/overflow_kunit.c:999:9: sparse: sparse: cast truncates bits from constant value (ffff0001 becomes 1)
   lib/overflow_kunit.c:999:9: sparse: sparse: cast truncates bits from constant value (ffff0001 becomes 1)
   lib/overflow_kunit.c:999:9: sparse: sparse: cast truncates bits from constant value (ffff0001 becomes 1)
   lib/overflow_kunit.c:999:9: sparse: sparse: cast truncates bits from constant value (ffff0001 becomes 1)
   lib/overflow_kunit.c:999:9: sparse: sparse: cast truncates bits from constant value (ffff0001 becomes 1)
   lib/overflow_kunit.c:999:9: sparse: sparse: cast truncates bits from constant value (ffff0001 becomes 1)
   lib/overflow_kunit.c:1000:9: sparse: sparse: cast truncates bits from constant value (ffffff01 becomes 1)
   lib/overflow_kunit.c:1000:9: sparse: sparse: cast truncates bits from constant value (ffff0001 becomes 1)
   lib/overflow_kunit.c:1001:9: sparse: sparse: cast truncates bits from constant value (ffffff01 becomes 1)
   lib/overflow_kunit.c:1001:9: sparse: sparse: cast truncates bits from constant value (ffff0001 becomes 1)
   lib/overflow_kunit.c:1002:9: sparse: sparse: cast truncates bits from constant value (ffffff01 becomes 1)
   lib/overflow_kunit.c:1002:9: sparse: sparse: cast truncates bits from constant value (ffff0001 becomes 1)
   lib/overflow_kunit.c:1003:9: sparse: sparse: cast truncates bits from constant value (ffffff01 becomes 1)
   lib/overflow_kunit.c:1003:9: sparse: sparse: cast truncates bits from constant value (ffff0001 becomes 1)
   lib/overflow_kunit.c:1098:9: sparse: sparse: cast truncates bits from constant value (ffffff01 becomes 1)
   lib/overflow_kunit.c:1098:9: sparse: sparse: cast truncates bits from constant value (ffffff01 becomes 1)
   lib/overflow_kunit.c:1098:9: sparse: sparse: cast truncates bits from constant value (ffffff01 becomes 1)
   lib/overflow_kunit.c:1099:9: sparse: sparse: cast truncates bits from constant value (ffff0001 becomes 1)
   lib/overflow_kunit.c:1099:9: sparse: sparse: cast truncates bits from constant value (ffff0001 becomes 1)
   lib/overflow_kunit.c:1099:9: sparse: sparse: cast truncates bits from constant value (ffff0001 becomes 1)

vim +998 lib/overflow_kunit.c

   997	
 > 998		TEST_TYPE_SETS(u8,   true, false, false, false, false, false, false, false);
   999		TEST_TYPE_SETS(u16, false,  true, false, false, false, false, false, false);
  1000		TEST_TYPE_SETS(u32, false, false,  true, false, false, false, false, false);
  1001		TEST_TYPE_SETS(s8,  false, false, false,  true, false, false, false, false);
  1002		TEST_TYPE_SETS(s16, false, false, false, false,  true, false, false, false);
  1003		TEST_TYPE_SETS(s32, false, false, false, false, false,  true, false, false);
  1004	#if BITS_PER_LONG == 64
  1005		TEST_TYPE_SETS(u64, false, false, false, false, false, false,  true, false);
  1006		TEST_TYPE_SETS(s64, false, false, false, false, false, false, false,  true);
  1007	#endif
  1008	
  1009		/* Check for macro side-effects. */
  1010		var = 4;
  1011		KUNIT_EXPECT_EQ(test, var, 4);
  1012		KUNIT_EXPECT_TRUE(test, __same_type(var++, int));
  1013		KUNIT_EXPECT_EQ(test, var, 4);
  1014		KUNIT_EXPECT_TRUE(test, __same_type(int, var++));
  1015		KUNIT_EXPECT_EQ(test, var, 4);
  1016		KUNIT_EXPECT_TRUE(test, __same_type(var++, var++));
  1017		KUNIT_EXPECT_EQ(test, var, 4);
  1018	
  1019		kunit_info(test, "%d __same_type() tests finished\n", count);
  1020	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

