Return-Path: <linux-kernel+bounces-3190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAACB8168C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978F22824F9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B761118F;
	Mon, 18 Dec 2023 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdh/P+HF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6743710A2E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702889570; x=1734425570;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bZCFZL7iDl6rX7EGf09C9U1b3W4raZXLVsbXzyIuzhA=;
  b=kdh/P+HFv8oAkzTzbmo2vpSbnkIjwdyxZw5ix5SiHQCOnRQjB/qGF78h
   4UNJGlaljf8MK7ZKzc5KIsBxy6su17uyRQm6v3MMhrdO2I0KSRKl6VOfK
   lGQFLDXBV7IqeMdMt1j3Jjv+v144BADqBR1wbOGxHayclhfpSz+AapL58
   K1v2mQaIOA3lTk48vceNepIuOz9Avq94bi1DL5QSnK4acrudIMBdksuwr
   qhi9pv6tiosociHNRE6+jisXNvqwOyS40ZzEPfe84DFXYP9pikLQu/Buz
   pXmbW3GesPScIXfvAq2P1tanmIT7DfrdO6fer5yxCAXQBuqLCCj3x5JkC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="14165835"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="14165835"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 00:52:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="893740379"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="893740379"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 18 Dec 2023 00:52:46 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rF9Mi-0003wO-2t;
	Mon, 18 Dec 2023 08:52:44 +0000
Date: Mon, 18 Dec 2023 16:52:35 +0800
From: kernel test robot <lkp@intel.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: drivers/cpuidle/governors/ladder.c:54: warning: Function parameter
 or member 'dev' not described in 'ladder_do_selection'
Message-ID: <202312181621.8F4HyH1d-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marcelo,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ceb6a6f023fd3e8b07761ed900352ef574010bcb
commit: 7d4daeedd575bbc3c40c87fc6708a8b88c50fe7e governors: unify last_state_idx
date:   4 years, 5 months ago
config: x86_64-randconfig-161-20230927 (https://download.01.org/0day-ci/archive/20231218/202312181621.8F4HyH1d-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231218/202312181621.8F4HyH1d-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312181621.8F4HyH1d-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cpuidle/governors/ladder.c:54: warning: Function parameter or member 'dev' not described in 'ladder_do_selection'


vim +54 drivers/cpuidle/governors/ladder.c

4f86d3a8e29720 Len Brown       2007-10-03  44  
4f86d3a8e29720 Len Brown       2007-10-03  45  /**
4f86d3a8e29720 Len Brown       2007-10-03  46   * ladder_do_selection - prepares private data for a state change
4f86d3a8e29720 Len Brown       2007-10-03  47   * @ldev: the ladder device
4f86d3a8e29720 Len Brown       2007-10-03  48   * @old_idx: the current state index
4f86d3a8e29720 Len Brown       2007-10-03  49   * @new_idx: the new target state index
4f86d3a8e29720 Len Brown       2007-10-03  50   */
7d4daeedd575bb Marcelo Tosatti 2019-07-03  51  static inline void ladder_do_selection(struct cpuidle_device *dev,
7d4daeedd575bb Marcelo Tosatti 2019-07-03  52  				       struct ladder_device *ldev,
4f86d3a8e29720 Len Brown       2007-10-03  53  				       int old_idx, int new_idx)
4f86d3a8e29720 Len Brown       2007-10-03 @54  {
4f86d3a8e29720 Len Brown       2007-10-03  55  	ldev->states[old_idx].stats.promotion_count = 0;
4f86d3a8e29720 Len Brown       2007-10-03  56  	ldev->states[old_idx].stats.demotion_count = 0;
7d4daeedd575bb Marcelo Tosatti 2019-07-03  57  	dev->last_state_idx = new_idx;
4f86d3a8e29720 Len Brown       2007-10-03  58  }
4f86d3a8e29720 Len Brown       2007-10-03  59  

:::::: The code at line 54 was first introduced by commit
:::::: 4f86d3a8e297205780cca027e974fd5f81064780 cpuidle: consolidate 2.6.22 cpuidle branch into one patch

:::::: TO: Len Brown <len.brown@intel.com>
:::::: CC: Len Brown <len.brown@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

