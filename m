Return-Path: <linux-kernel+bounces-17197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A368982498E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C57B1C2293E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851012C69E;
	Thu,  4 Jan 2024 20:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kj6TNpNA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9A82C697
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 20:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704400031; x=1735936031;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g1oDRCv8dPqMR/AR77cJFUoMVlJQWt/Q6i9jLC9FSxU=;
  b=kj6TNpNABFdX8VcsQX3Telw2wwd8kzr+RQAawqMc+0SotE6XfSAIdlE7
   Jj4RM43Kl8UMILwkqGWopyaDt4xRxLfemq/WjGQs1MrzCGQq/UOoVoeTY
   0NYtmKlKIgRF8/MNd0dRxbjm3pJCqU1roCh8mKhWNeaA4Ybs/pcTW/af9
   lwz4BjbgC6Azq3JkWNO3wB8Oucext9XndB07w531Y85vZpw3ttwviQ0MV
   TZhvg/QLADjAut7KlQ/l7yEubsvqp6GhwMCmYiJKzKmlpO3rTX8yWH84H
   q/UoQZhd/GNrW/0o9tPl6OCDAVqd7ntHObJ5mAuXIV8CSaClWZ4tvI6gB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="483530905"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="483530905"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 12:26:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="22285442"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 04 Jan 2024 12:26:17 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLUIA-0000Oi-2J;
	Thu, 04 Jan 2024 20:26:14 +0000
Date: Fri, 5 Jan 2024 04:25:25 +0800
From: kernel test robot <lkp@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/alloc_background.c:200:5-8: Unneeded variable: "ret".
 Return "  0" on line 208
Message-ID: <202401050409.VH31aFND-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ac865f00af293d081356bec56eea90815094a60e
commit: b65db750e2bb9252321fd54c284edd73c1595a09 bcachefs: Enumerate fsck errors
date:   9 weeks ago
config: x86_64-randconfig-r064-20231231 (https://download.01.org/0day-ci/archive/20240105/202401050409.VH31aFND-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401050409.VH31aFND-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> fs/bcachefs/alloc_background.c:200:5-8: Unneeded variable: "ret". Return "  0" on line 208
   fs/bcachefs/alloc_background.c:216:5-8: Unneeded variable: "ret". Return "  0" on line 222
   fs/bcachefs/alloc_background.c:230:5-8: Unneeded variable: "ret". Return "  0" on line 236
   fs/bcachefs/alloc_background.c:243:5-8: Unneeded variable: "ret". Return "  0" on line 297
   fs/bcachefs/alloc_background.c:523:5-8: Unneeded variable: "ret". Return "  0" on line 530
--
>> fs/bcachefs/lru.c:17:5-8: Unneeded variable: "ret". Return "  0" on line 23
--
>> fs/bcachefs/quota.c:66:5-8: Unneeded variable: "ret". Return "  0" on line 73
--
>> fs/bcachefs/subvolume.c:104:5-8: Unneeded variable: "ret". Return "  0" on line 111

vim +200 fs/bcachefs/alloc_background.c

   194	
   195	int bch2_alloc_v1_invalid(struct bch_fs *c, struct bkey_s_c k,
   196				  enum bkey_invalid_flags flags,
   197				  struct printbuf *err)
   198	{
   199		struct bkey_s_c_alloc a = bkey_s_c_to_alloc(k);
 > 200		int ret = 0;
   201	
   202		/* allow for unknown fields */
   203		bkey_fsck_err_on(bkey_val_u64s(a.k) < bch_alloc_v1_val_u64s(a.v), c, err,
   204				 alloc_v1_val_size_bad,
   205				 "incorrect value size (%zu < %u)",
   206				 bkey_val_u64s(a.k), bch_alloc_v1_val_u64s(a.v));
   207	fsck_err:
 > 208		return ret;
   209	}
   210	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

