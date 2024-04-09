Return-Path: <linux-kernel+bounces-136322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD6989D2A6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7201F2361B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E495D7F489;
	Tue,  9 Apr 2024 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HWwH4lfy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCA87F469
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 06:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712645096; cv=none; b=DFluW0J/hJ8PwP2obuNyGlLeQByI1Ap1CEaZmnv09N5bEfmyn4E7R4ITsMDhV++TOevTfNpKQb76OqDScv/LhWpi2dJN7ShVs+upL1rLrzM7WxIFC6sjKmT95tEKiY9EURChMj5aanHRhhlXubpbIt723NCtHF8h2kr0QGMfROw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712645096; c=relaxed/simple;
	bh=Y4fwionJ7MA0g8amtT8EkR/ZIt4iZAGfM7Xnpv+YETc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aNQtNQy++1s6S9bCsy9u9vkmY9nT05VRmCvGggCbFKNisWgSG6CO1PsepM1v/2mI1/YsUzipOKHibs+j5p9mV3GxlZaSrwzkvk1FseC67WUvS09our33tUY2kYmQzDRh6ddSUi7kR6VcaSJLmiHgZw6iuAO8rmiIx/ubM7g+bmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HWwH4lfy; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712645095; x=1744181095;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y4fwionJ7MA0g8amtT8EkR/ZIt4iZAGfM7Xnpv+YETc=;
  b=HWwH4lfyYcfNdtNx+/Ohcy4XhCxsJYSnJ2YLmmqxsNdWq9uVKjGHjM1U
   kZg2IGr+1Pq98f2uBbIc+ltBszXOOYt6IW0xDV9vT8zyPWH6O8fyyPujj
   u2yJh3+Jqb2FOl5Qf5wRIrKvg4zUMl3Xb+eHjOmWLgzEMnQuOmUZax0Fl
   vhbFysSw1tVhD9z3KL3vZnwd49GGTSBJvE/NwIlAJNFxuCElfHtZs6ciO
   Xqem7Kb8uxYYG0BbH1we4XQl20WDnlGqPvX8+CteiuSgm0ca8sVzDKo8L
   F8xWQUHNwbs6r2sZtmYl6D+0fFv9GY9uHMNyzYCjHP4lQ05rvll/ZWr6z
   Q==;
X-CSE-ConnectionGUID: yGZrqdOaQROnl1O/gzR14Q==
X-CSE-MsgGUID: IktXC+gkRc2AD3SZjCmCPA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="33352668"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="33352668"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 23:44:54 -0700
X-CSE-ConnectionGUID: PZk59RutSwSzxReBV5OLsQ==
X-CSE-MsgGUID: 7KZAMXh/TM2aKU6LPvFOWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="20698153"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 08 Apr 2024 23:44:53 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ru5Du-0005pw-0b;
	Tue, 09 Apr 2024 06:44:50 +0000
Date: Tue, 9 Apr 2024 14:44:49 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.04.04b 59/65] controller.c:undefined reference
 to `cmpxchg_emu_u8'
Message-ID: <202404091402.CYa0g4R6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.04.04b
head:   e2a520f3f3921cb5d3c9631917fccf8c215991ce
commit: 5ce37a62e3d207bd20d4c850c4547816c0dd9c22 [59/65] EXP arch/x86: Test one-byte cmpxchg emulation
config: i386-buildonly-randconfig-006-20240409 (https://download.01.org/0day-ci/archive/20240409/202404091402.CYa0g4R6-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240409/202404091402.CYa0g4R6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404091402.CYa0g4R6-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/platform/surface/aggregator/controller.o: in function `ssam_request_write_data':
>> controller.c:(.text+0xcdf): undefined reference to `cmpxchg_emu_u8'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

