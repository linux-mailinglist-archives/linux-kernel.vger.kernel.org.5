Return-Path: <linux-kernel+bounces-156538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAF88B0448
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C331F25B4B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22D0158869;
	Wed, 24 Apr 2024 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nL/xHw2b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825ED157468
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947169; cv=none; b=qciPorHr/lheBqMXpS0Sol29o29fVep2XiOSOo6Ch03SnpuGrRqCQ87AJmk0Js6a+mqM24y3X4daCkVd7Wx0kgyQfJH65+LgLEXL1jLXkx7WX/HdATGm9HbqpaeEVLIv4+j8ucOUi0mTggFgVLbplXz6Sa9WR0RBY+1M56eg+pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947169; c=relaxed/simple;
	bh=EmHMPvgKAoQJDRWQwlm9jmDo8kEKQqcKd0ef85rUkXc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aCnpo4kmR1ksHsKgBIhT6oi++j5W879Dfj6WOJH0v4j/fMlinyhWP8N7/+FFmYL2fODglOH7T8CPaznLoM4EI+v0c+U5AcvfHVVCacvDcgX5XZ88pSMTtcUpmlJkvasEahWS9bbmr51xG2z0Sujk7nfVuWUB6EhLL+Mto/KDRb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nL/xHw2b; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713947168; x=1745483168;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EmHMPvgKAoQJDRWQwlm9jmDo8kEKQqcKd0ef85rUkXc=;
  b=nL/xHw2bxo2psFNnF9wKIocSG9Ez+wjwRzXPW8/SV+ORhasKEPzdEP4n
   EDAJXLiN9GIyz455Po6CIhaC8Y0laisn2saiRlzd2R59faCQj/ECHV4yG
   mw1I7L9h7fUPpvEmeOQLduY7XPiVrxWtCk+bduIiqeu88wvHESzntVNLB
   PN/OSgOZ2aLjK4jGHj4BOjin0n3vI1l9mkYw3rE2sDscbmR5u5a+UMWqv
   5aafr9q5EXgWuAdC7GkpFf+mnrGSIEG37Ju5OXhOksWD3iYy5HGOvyC2H
   00w0dv0i0So3HKu+o1UQEWYmyEObGiJRG6FcGSakmdHgkC0BSNCiouA92
   w==;
X-CSE-ConnectionGUID: g0wz8gCHQji8kXhD9LcUQA==
X-CSE-MsgGUID: wUns77grTVWTd1EpOpMKeQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27079755"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27079755"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 01:26:07 -0700
X-CSE-ConnectionGUID: vZo7Fr8TTHyOmC05hFvI9g==
X-CSE-MsgGUID: tEBgCSWzQbGOWqc+uJMFfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="29118475"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 24 Apr 2024 01:26:05 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rzXx5-00012Q-1J;
	Wed, 24 Apr 2024 08:26:03 +0000
Date: Wed, 24 Apr 2024 16:25:59 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data319'
 from `kernel/sched/core.o' being placed in section `.bss..Lubsan_data319'
Message-ID: <202404241643.0athGlpO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9d1ddab261f3e2af7c384dc02238784ce0cf9f98
commit: 7a50f76674f8b6f4f30a1cec954179f10e20110c sched: Simplify yield_to()
date:   7 months ago
config: powerpc-randconfig-s032-20220402 (https://download.01.org/0day-ci/archive/20240424/202404241643.0athGlpO-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240424/202404241643.0athGlpO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404241643.0athGlpO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data319' from `kernel/sched/core.o' being placed in section `.bss..Lubsan_data319'
   powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data228' from `fs/overlayfs/copy_up.o' being placed in section `.bss..Lubsan_data228'
>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data319' from `kernel/sched/core.o' being placed in section `.bss..Lubsan_data319'
   powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data228' from `fs/overlayfs/copy_up.o' being placed in section `.bss..Lubsan_data228'
>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data319' from `kernel/sched/core.o' being placed in section `.bss..Lubsan_data319'
   powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data228' from `fs/overlayfs/copy_up.o' being placed in section `.bss..Lubsan_data228'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

