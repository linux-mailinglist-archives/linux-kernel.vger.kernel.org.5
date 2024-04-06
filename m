Return-Path: <linux-kernel+bounces-133750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E6989A80E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 03:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 558BF1C229BD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4031F5695;
	Sat,  6 Apr 2024 01:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AzG1Zzj8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC50A38
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 01:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712365276; cv=none; b=jwextitqRZbm4su++w9Jpra8Hr/EoPm53ulsTo3b1LgQ1PpR25H7YeeHInMm/WbfO1YKDeFVyNlUWEHHEs/LoU0W7lle5iaX9s3QHbE3y1Pi3UHJzBWqVN0AvK4vbKxNtFzWh/+1ht+vk1r5Af5cMacHrdYKmA23u48mGhbsQ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712365276; c=relaxed/simple;
	bh=RPBiXOvJ3qO08FTb2PnV5TeQKTc1e33mARDhTSge36Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tssEORZgF5cc9BYB1UZpjaP7OLDR9PDoiqX+5UusUFvG5nKn0h6M7hmXXm1CgAd2BF8HtGSrZuKurKz041HsOwUP5E8+kgd6Mwxux6uvhHzhLp0y5cWReH+Lluqd5c2yZKjQ7kQ6ha3TeKECARlT5DLe/PEeJxxkdYwv0cwph7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AzG1Zzj8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712365274; x=1743901274;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RPBiXOvJ3qO08FTb2PnV5TeQKTc1e33mARDhTSge36Q=;
  b=AzG1Zzj8vH65S8h+Zi1sunFXktTUfBJU6uLB5utz2YV/rzHdYQynv919
   6cfpOstSC/bJStgJY+LSoY6FrWI613O8ws3r29wVkBhuNoXffaMPkTubM
   BM8LJrIUPK2dJ5Ahp1zQDqmj3gS+2+0SbLUKA0TDcAGdsIOs7NFfCZSOa
   VW4RW/mKj9AYM/1XrhbCgNSQ4FMH21Wn2QQy+7tuciP24hYFMrzMzbil2
   iROT5jLHJyAS+wBArkJd0hc0mqRFye3WuRDpGosEFB+WT/aRS886/JGEP
   HKUaOGldvEwR6vJUigEWM5WzoKPuhivxNm9aqlrgauzPfADcrakKR+MaK
   w==;
X-CSE-ConnectionGUID: ialNMgs5Sm2pkKenngiIMg==
X-CSE-MsgGUID: VLXx2OMNRd+ZG5lgGdFcEw==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="25154210"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="25154210"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 18:01:13 -0700
X-CSE-ConnectionGUID: Kq04r+ZxSMyO0jmPvuZ9Mg==
X-CSE-MsgGUID: TGfzPn0dS3aZHhuFHGentA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19253399"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 05 Apr 2024 18:01:12 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsuQf-0002wu-1x;
	Sat, 06 Apr 2024 01:01:09 +0000
Date: Sat, 6 Apr 2024 09:00:49 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: include/linux/list.h:69:(.text+0x338f): dangerous relocation:
 windowed longcall crosses 1GB boundary; return may fail: *UND*
Message-ID: <202404060846.sebDx4Nj-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8a05ef7087166d7fa0de986fb6a2d97850dbd551
commit: 481461f5109919babbb393d6f68002936b8e2493 linux/export.h: make <linux/export.h> independent of CONFIG_MODULES
date:   9 months ago
config: xtensa-randconfig-r012-20230616 (https://download.01.org/0day-ci/archive/20240406/202404060846.sebDx4Nj-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240406/202404060846.sebDx4Nj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404060846.sebDx4Nj-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/media/common/siano/smscoreapi.o: in function `smscore_register_hotplug':
>> include/linux/list.h:69:(.text+0x338f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: *UND*


vim +69 include/linux/list.h

d7c816733d501b Kees Cook        2016-08-17  58  
^1da177e4c3f41 Linus Torvalds   2005-04-16  59  /*
^1da177e4c3f41 Linus Torvalds   2005-04-16  60   * Insert a new entry between two known consecutive entries.
^1da177e4c3f41 Linus Torvalds   2005-04-16  61   *
^1da177e4c3f41 Linus Torvalds   2005-04-16  62   * This is only for internal list manipulation where we know
^1da177e4c3f41 Linus Torvalds   2005-04-16  63   * the prev/next entries already!
^1da177e4c3f41 Linus Torvalds   2005-04-16  64   */
^1da177e4c3f41 Linus Torvalds   2005-04-16  65  static inline void __list_add(struct list_head *new,
^1da177e4c3f41 Linus Torvalds   2005-04-16  66  			      struct list_head *prev,
^1da177e4c3f41 Linus Torvalds   2005-04-16  67  			      struct list_head *next)
^1da177e4c3f41 Linus Torvalds   2005-04-16  68  {
d7c816733d501b Kees Cook        2016-08-17 @69  	if (!__list_add_valid(new, prev, next))
d7c816733d501b Kees Cook        2016-08-17  70  		return;
d7c816733d501b Kees Cook        2016-08-17  71  
^1da177e4c3f41 Linus Torvalds   2005-04-16  72  	next->prev = new;
^1da177e4c3f41 Linus Torvalds   2005-04-16  73  	new->next = next;
^1da177e4c3f41 Linus Torvalds   2005-04-16  74  	new->prev = prev;
1c97be677f72b3 Paul E. McKenney 2015-09-20  75  	WRITE_ONCE(prev->next, new);
^1da177e4c3f41 Linus Torvalds   2005-04-16  76  }
^1da177e4c3f41 Linus Torvalds   2005-04-16  77  

:::::: The code at line 69 was first introduced by commit
:::::: d7c816733d501b59dbdc2483f2cc8e4431fd9160 list: Split list_add() debug checking into separate function

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

