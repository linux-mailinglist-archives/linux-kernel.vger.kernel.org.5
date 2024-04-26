Return-Path: <linux-kernel+bounces-159737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D208B337B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03EB5282300
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCCE13D291;
	Fri, 26 Apr 2024 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LRB7pejm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E5913C838
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122045; cv=none; b=tzKYtZJmnFVuxQmGCS7EZEj92Um3bSv459CXq3NwfzLQe1Q9JPciZoemF0IJjv6HU2eHWXKktfcM6UYlHUVxfL4ms1H+rERGazu9gsRwiwReu9aP33fV7Nuh1q8nv5nEX8Z0sJA7YExY/P3t5eJShDi3P7+TdAi3l7Il3LuQv3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122045; c=relaxed/simple;
	bh=hkvrwq0uWGSiJHO7TTFapyHX4LA/xNXwZasZASBeMAI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oB6lMdJgn+tIYvAnMExztbXCRTAPbw5BCVjHRzEVUJ8Nwygx+GtxT2Z3WN84y45h97zhReHtTeHcjvdi6nb8JY0sc6/KoJg8Cc1PlRMeqv267HhO8KhPmokgQN98K2g3CMc+IHijsUqvdsPNBJz4fb5pTqIf/u1EwnVIcX7UsNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LRB7pejm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714122044; x=1745658044;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hkvrwq0uWGSiJHO7TTFapyHX4LA/xNXwZasZASBeMAI=;
  b=LRB7pejmnyJdNJvd/7ohFWa/DHIb1OTdQ0CwE1MnPK63CrTfrmQWsFwG
   WQDA9M3m1Qg1Y7eOsItaAOecMtDXs9fC2Y0Xe4mroICA4gAKvStEJtVNP
   dWvm2FJVMev3q+OZ4UQRcxISyNg1SHDlsFgO/FdnvBqPSMZi8zXIkGynt
   5cFKjloWEF8sWD4OzDBQp03Wzv5X1+ZT8YRYAQes9Y8jNDILeQgTw8ZSA
   qcR0a9m/O5X8gK+Hvl95QphALnhOVA1a/O46oHgzVvnAMoQ28oys9biZE
   fCrYKJUVIHSQyYm9yMonP9rmymF0aVuM66qiQS3WLnvgRN0yXUASwCCiA
   A==;
X-CSE-ConnectionGUID: 0vl8xfy7TXiY+gBwczcO6A==
X-CSE-MsgGUID: wuBO4aV5QCi4yW6h5yqFpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9776911"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="9776911"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 02:00:43 -0700
X-CSE-ConnectionGUID: +taR4C8mTmGHlYYZ8bvhOQ==
X-CSE-MsgGUID: PdfGznN8QlilP4Ln48PMfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="29823933"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 26 Apr 2024 02:00:41 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s0HRf-0003Ve-28;
	Fri, 26 Apr 2024 09:00:39 +0000
Date: Fri, 26 Apr 2024 16:59:45 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>
Subject: powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data65' from
 `kernel/ptrace.o' being placed in section `.bss..Lubsan_data65'
Message-ID: <202404261646.RbWtKBhy-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c942a0cd3603e34dd2d7237e064d9318cb7f9654
commit: 5431fdd2c181dd2eac218e45b44deb2925fa48f0 ptrace: Convert ptrace_attach() to use lock guards
date:   5 months ago
config: powerpc-randconfig-r033-20230815 (https://download.01.org/0day-ci/archive/20240426/202404261646.RbWtKBhy-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240426/202404261646.RbWtKBhy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404261646.RbWtKBhy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data65' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data65'
>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data65' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data65'
>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data65' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data65'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

