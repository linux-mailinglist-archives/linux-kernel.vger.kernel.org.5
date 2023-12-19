Return-Path: <linux-kernel+bounces-4958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEDA818461
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED772B22BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE1213FFB;
	Tue, 19 Dec 2023 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+Sm/dpT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CC2134DE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702977971; x=1734513971;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jzG+lGE3/WkEP054xRKyKv7aE8K4z9zbvIr6Dcu+5k4=;
  b=n+Sm/dpTF98bwHYfJC1+1uG7sNsbPIAci8MKaTjPTEiJd8JMBiBgE6kH
   qjOZl2NXcb+gZs66y6bHt2BtC5xcP6Uki/trqN1Jz01txgiSXlTdHpRJF
   bzzvf4g++rG+zXGAgzKx8ScHnuQEGhesupN6infqH7aqO6xXwELri/zfN
   +I+BhBLH6TxUxAWxfXZ9MXzihSVNwpZGjZ/SHzd32Yo/L3c7udXbeLWJ0
   lNYSu2LqHcJpfHJGkNEACLdC6YL3e57Cp4ZUgzweOw/deb2AT82RSuFyq
   dKO0NoyU4CydwL/qPMVaYZgRmSMEdQTwqJTgeQjuAlpsnfgr3IR6uhMLW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2727489"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="2727489"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 01:26:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="894219933"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="894219933"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 19 Dec 2023 01:26:09 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFWMZ-00057V-0s;
	Tue, 19 Dec 2023 09:26:07 +0000
Date: Tue, 19 Dec 2023 17:25:29 +0800
From: kernel test robot <lkp@intel.com>
To: Kent Overstreet <kmo@daterainc.com>,
	Kent Overstreet <kent.overstreet@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/reflink.c:111:32-33: Unneeded semicolon
Message-ID: <202312191741.tYE8q8kO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2cf4f94d8e8646803f8fb0facf134b0cd7fb691a
commit: 523f33efbf406f2eb0f071123d17fbbd9e40d692 bcachefs: All triggers are BTREE_TRIGGER_WANTS_OLD_AND_NEW
date:   7 weeks ago
config: x86_64-randconfig-102-20231219 (https://download.01.org/0day-ci/archive/20231219/202312191741.tYE8q8kO-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312191741.tYE8q8kO-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> fs/bcachefs/reflink.c:111:32-33: Unneeded semicolon

vim +111 fs/bcachefs/reflink.c

   105	
   106	static inline void check_indirect_extent_deleting(struct bkey_i *new, unsigned *flags)
   107	{
   108		if ((*flags & BTREE_TRIGGER_INSERT) && !*bkey_refcount(new)) {
   109			new->k.type = KEY_TYPE_deleted;
   110			new->k.size = 0;
 > 111			set_bkey_val_u64s(&new->k, 0);;
   112			*flags &= ~BTREE_TRIGGER_INSERT;
   113		}
   114	}
   115	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

