Return-Path: <linux-kernel+bounces-134074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C8089ACE9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 22:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43741F2313C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 20:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E09C4CDEB;
	Sat,  6 Apr 2024 20:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0nygJzF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1009718C1F
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712435753; cv=none; b=kcBiv1fSkAZDZSiG4ePoBkHGCXdIGEmgff2F4AXERR7db6HUcHK6MIIXR3BJ6bHzN/BwaeX4skTbwkCH7MtkNoi9BePHkOw5UBiEnvdqYdbnfjxXi8q4jZDnkNHOUh/CP+7q3xWye1wsBSm6EFcFopPr2oVXrEKblBVsOeDsx+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712435753; c=relaxed/simple;
	bh=rkD9NL6W+G6GrYqTYymBTl0TVkn2V8FXKcBG7YbWhAU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r+RN5pDSwPSaFFpL87IayMQFh0PqCZA3XzRTTHDpgHJq7RWJhtVU3pbx73G36w/y7ujYXZTlXUkaggb/b5/VGPsOqMT/ssul+XC2P4tMuV8YbQfksbMKogmo1c6b8S6IZSJWH1ffvszjFtelO1CBU6jQfJuVJegD8COxh7y1CU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0nygJzF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712435752; x=1743971752;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rkD9NL6W+G6GrYqTYymBTl0TVkn2V8FXKcBG7YbWhAU=;
  b=J0nygJzFgEWpvz5LNUO8GGJ9LJWZLbmdDppBKd54KiWRv5xRaDPDvVoU
   lFkLvTHweu5GoyX5oFBK+BsOVOO5vLmM6fmK61IOXn6QJzTRX04rsc3OV
   /5Eo2CUNFD+isz7UAWv1i2Ml3C8MKUAf6aRszRIjPrnzn92veWdvBmGnU
   Icdao2Kkl/lvYAWDxzQ8W7XOzVp2ACaGr62xANLvp66n9DGnBJkZNTyF0
   QZw1hJNn3r2D/P4L/MVPJdad1unbg8QseTI7FCOUVlfv/VbXiDFUm0qMz
   AFAzacu75cDJqthR6og5Rj0rxgFpdSR246GV5LfshwCsbRmxox4gk+eLp
   A==;
X-CSE-ConnectionGUID: Vhj4vTgyQHGj5BEgLvoQcg==
X-CSE-MsgGUID: czwVZRz/S1SYdurfk8Ov+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="19179123"
X-IronPort-AV: E=Sophos;i="6.07,183,1708416000"; 
   d="scan'208";a="19179123"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 13:35:51 -0700
X-CSE-ConnectionGUID: 7Cn4H+4RS6GkPfHROLwVRA==
X-CSE-MsgGUID: ZJFWNazNR+aQ1RJ5TfR9uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,183,1708416000"; 
   d="scan'208";a="24118862"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 06 Apr 2024 13:35:49 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rtClO-0003pi-26;
	Sat, 06 Apr 2024 20:35:46 +0000
Date: Sun, 7 Apr 2024 04:35:28 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>
Subject: lib/overflow_kunit.c:295:14-19: Unneeded variable: "index". Return
 "0" on line 297
Message-ID: <202404070416.WaNXeve0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f2f80ac809875855ac843f9e5e7480604b5cbff5
commit: 08d45ee84bb2650e237e150caca87cc4ded9b3e2 overflow: Introduce wrapping_assign_add() and wrapping_assign_sub()
date:   5 weeks ago
config: hexagon-randconfig-r053-20240406 (https://download.01.org/0day-ci/archive/20240407/202404070416.WaNXeve0-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 546dc2245ffc4cccd0b05b58b7a5955e355a3b27)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404070416.WaNXeve0-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> lib/overflow_kunit.c:295:14-19: Unneeded variable: "index". Return "0" on line 297

vim +295 lib/overflow_kunit.c

   292	
   293	static int get_index(void)
   294	{
 > 295		volatile int index = 0;
   296		bump_counter();
 > 297		return index;
   298	}
   299	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

