Return-Path: <linux-kernel+bounces-11319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD7781E484
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 03:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A366E1F22377
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 02:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C2B185B;
	Tue, 26 Dec 2023 02:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKVVgbBN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB661849
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 02:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703557012; x=1735093012;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FIbjR4MeHR1cPJ+c1UzOobgRtxx5vLTwcCPN8hzu+bM=;
  b=SKVVgbBNDspNbdYOl0nPmuQsiKHgVlCqU5L0JXRU8McYFMJlTTP72onv
   T9zu7HOeo7fZBQ/Xjv5Sh59wBbKbO1FrOQN/GZqoeGMPO80a7RQeBzG7Y
   1FAXHRddVSVW1GOJsdM2cMVCmg9eaDr6p9IYFGdgSwtvkBeaieiNR9YjN
   8NlJuB5lIen+/RlIzIYhDvqMTYqYk1XntYymw5fHcqUGxZKJFDOjEiJav
   eP4DO/m5/ZntooIwlhPyH4R6qtnCvhwKtlFRuO8dVuMk0uTfZ+B/BPQdY
   z02O7BalMNG5qFqZF1hStlQAOcaJh8NxBS6r6bX+omw9o8YASZScZ/acT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="376454698"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="376454698"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 18:16:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="754050175"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="754050175"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 25 Dec 2023 18:16:49 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHwzv-000Dsj-0L;
	Tue, 26 Dec 2023 02:16:47 +0000
Date: Tue, 26 Dec 2023 10:16:34 +0800
From: kernel test robot <lkp@intel.com>
To: Andrey Konovalov <andreyknvl@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Marco Elver <elver@google.com>
Subject: mm/kasan/kasan_test.c:36:6: sparse: sparse: symbol
 'kasan_ptr_result' was not declared. Should it be static?
Message-ID: <202312261010.o0lRiI9b-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fbafc3e621c3f4ded43720fdb1d6ce1728ec664e
commit: f7e01ab828fd4bf6d25b1f143a3994241e8572bf kasan: move tests to mm/kasan/
date:   1 year, 3 months ago
config: x86_64-randconfig-122-20231101 (https://download.01.org/0day-ci/archive/20231226/202312261010.o0lRiI9b-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231226/202312261010.o0lRiI9b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312261010.o0lRiI9b-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/kasan/kasan_test.c:36:6: sparse: sparse: symbol 'kasan_ptr_result' was not declared. Should it be static?
>> mm/kasan/kasan_test.c:37:5: sparse: sparse: symbol 'kasan_int_result' was not declared. Should it be static?

vim +/kasan_ptr_result +36 mm/kasan/kasan_test.c

f33a01492a24a2 lib/test_kasan.c Walter Wu        2020-08-06  31  
adb72ae1915db2 lib/test_kasan.c Daniel Axtens    2020-06-03  32  /*
0fd379253691e7 lib/test_kasan.c Andrey Konovalov 2021-02-24  33   * Some tests use these global variables to store return values from function
0fd379253691e7 lib/test_kasan.c Andrey Konovalov 2021-02-24  34   * calls that could otherwise be eliminated by the compiler as dead code.
adb72ae1915db2 lib/test_kasan.c Daniel Axtens    2020-06-03  35   */
adb72ae1915db2 lib/test_kasan.c Daniel Axtens    2020-06-03 @36  void *kasan_ptr_result;
83c4e7a0363bdb lib/test_kasan.c Patricia Alfonso 2020-10-13 @37  int kasan_int_result;
83c4e7a0363bdb lib/test_kasan.c Patricia Alfonso 2020-10-13  38  

:::::: The code at line 36 was first introduced by commit
:::::: adb72ae1915db28f934e9e02c18bfcea2f3ed3b7 kasan: stop tests being eliminated as dead code with FORTIFY_SOURCE

:::::: TO: Daniel Axtens <dja@axtens.net>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

