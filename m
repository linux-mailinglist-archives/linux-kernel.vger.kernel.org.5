Return-Path: <linux-kernel+bounces-9235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75FA81C2AE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080281C246C8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563BEEB8;
	Fri, 22 Dec 2023 01:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XAI89is7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D9EA49
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 01:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703208305; x=1734744305;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lB1TksxHjcbEUnYsUhC7XLEfrjEUgEBFIeGb4PweDMY=;
  b=XAI89is7zT39q+mUUyc0S69Vmxnbm6EoYng9PvOBF39UzxPanS520nw9
   N7G4x5XAXoDYi1mIreqopwu0yPUeC/gBGWQ9knN4ixZvC6wCq/AvBVHxK
   +0vZAg+LQBbIkHWir1bOdwE/gtv3CjQamqFgT/B3qFNDRkic63AQYR0SK
   0aL+SgM7yBCoXMswO8TLzKyl1tRPAN5lWgxdyX1Qok1yuDcIOw93FXDw7
   HA5+7OEyP/+qNkunSO2ZDBlid2BFMIfDUSCMVpTJeweucHHT+9jsNXRbu
   RZLiAjHlFCSD+w9BF5VHGpkCoq9YRg3D4UAmpnAV1Fe7Y5mNnXXpiT6t1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="9444026"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="9444026"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 17:24:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="895307967"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="895307967"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 21 Dec 2023 17:24:54 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGUHM-0008x7-2r;
	Fri, 22 Dec 2023 01:24:48 +0000
Date: Fri, 22 Dec 2023 09:23:55 +0800
From: kernel test robot <lkp@intel.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: net/xfrm/xfrm_state.c:2695:31: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202312220907.G4BidbSh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9a6b294ab496650e9f270123730df37030911b55
commit: fe9f1d8779cb47046e76ea209b6eece7ec56d1b4 xfrm: add state hashtable keyed by seq
date:   2 years, 7 months ago
config: openrisc-randconfig-r133-20231130 (https://download.01.org/0day-ci/archive/20231222/202312220907.G4BidbSh-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231222/202312220907.G4BidbSh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312220907.G4BidbSh-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1168:77: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1168:77: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1168:77: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:1170:77: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1170:77: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1170:77: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:1173:85: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1173:85: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1173:85: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:1177:85: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1177:85: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1177:85: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:1195:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct xfrm_state [noderef] __rcu *x @@     got struct xfrm_state *[assigned] x @@
   net/xfrm/xfrm_state.c:1195:42: sparse:     expected struct xfrm_state [noderef] __rcu *x
   net/xfrm/xfrm_state.c:1195:42: sparse:     got struct xfrm_state *[assigned] x
   net/xfrm/xfrm_state.c:1282:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1282:61: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1282:61: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:1285:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1285:61: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1285:61: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:1291:69: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1291:69: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1291:69: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:1297:69: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1297:69: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1297:69: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:1411:69: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1411:69: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1411:69: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:1413:69: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1413:69: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1413:69: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2076:69: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:2076:69: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:2076:69: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:2686:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hlist_head [noderef] __rcu *state_bydst @@     got struct hlist_head * @@
   net/xfrm/xfrm_state.c:2686:31: sparse:     expected struct hlist_head [noderef] __rcu *state_bydst
   net/xfrm/xfrm_state.c:2686:31: sparse:     got struct hlist_head *
   net/xfrm/xfrm_state.c:2689:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hlist_head [noderef] __rcu *state_bysrc @@     got struct hlist_head * @@
   net/xfrm/xfrm_state.c:2689:31: sparse:     expected struct hlist_head [noderef] __rcu *state_bysrc
   net/xfrm/xfrm_state.c:2689:31: sparse:     got struct hlist_head *
   net/xfrm/xfrm_state.c:2692:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hlist_head [noderef] __rcu *state_byspi @@     got struct hlist_head * @@
   net/xfrm/xfrm_state.c:2692:31: sparse:     expected struct hlist_head [noderef] __rcu *state_byspi
   net/xfrm/xfrm_state.c:2692:31: sparse:     got struct hlist_head *
>> net/xfrm/xfrm_state.c:2695:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hlist_head [noderef] __rcu *state_byseq @@     got struct hlist_head * @@
   net/xfrm/xfrm_state.c:2695:31: sparse:     expected struct hlist_head [noderef] __rcu *state_byseq
   net/xfrm/xfrm_state.c:2695:31: sparse:     got struct hlist_head *
   net/xfrm/xfrm_state.c:2708:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_byspi @@
   net/xfrm/xfrm_state.c:2708:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:2708:33: sparse:     got struct hlist_head [noderef] __rcu *state_byspi
   net/xfrm/xfrm_state.c:2710:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_bysrc @@
   net/xfrm/xfrm_state.c:2710:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:2710:33: sparse:     got struct hlist_head [noderef] __rcu *state_bysrc
   net/xfrm/xfrm_state.c:2712:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_bydst @@
   net/xfrm/xfrm_state.c:2712:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:2712:33: sparse:     got struct hlist_head [noderef] __rcu *state_bydst
>> net/xfrm/xfrm_state.c:2728:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head const *h @@     got struct hlist_head [noderef] __rcu *state_byseq @@
   net/xfrm/xfrm_state.c:2728:9: sparse:     expected struct hlist_head const *h
   net/xfrm/xfrm_state.c:2728:9: sparse:     got struct hlist_head [noderef] __rcu *state_byseq
>> net/xfrm/xfrm_state.c:2729:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_byseq @@
   net/xfrm/xfrm_state.c:2729:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:2729:33: sparse:     got struct hlist_head [noderef] __rcu *state_byseq
   net/xfrm/xfrm_state.c:2730:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head const *h @@     got struct hlist_head [noderef] __rcu *state_byspi @@
   net/xfrm/xfrm_state.c:2730:9: sparse:     expected struct hlist_head const *h
   net/xfrm/xfrm_state.c:2730:9: sparse:     got struct hlist_head [noderef] __rcu *state_byspi
   net/xfrm/xfrm_state.c:2731:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_byspi @@
   net/xfrm/xfrm_state.c:2731:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:2731:33: sparse:     got struct hlist_head [noderef] __rcu *state_byspi
   net/xfrm/xfrm_state.c:2732:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head const *h @@     got struct hlist_head [noderef] __rcu *state_bysrc @@
   net/xfrm/xfrm_state.c:2732:9: sparse:     expected struct hlist_head const *h
   net/xfrm/xfrm_state.c:2732:9: sparse:     got struct hlist_head [noderef] __rcu *state_bysrc
   net/xfrm/xfrm_state.c:2733:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_bysrc @@
   net/xfrm/xfrm_state.c:2733:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:2733:33: sparse:     got struct hlist_head [noderef] __rcu *state_bysrc
   net/xfrm/xfrm_state.c:2734:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head const *h @@     got struct hlist_head [noderef] __rcu *state_bydst @@
   net/xfrm/xfrm_state.c:2734:9: sparse:     expected struct hlist_head const *h
   net/xfrm/xfrm_state.c:2734:9: sparse:     got struct hlist_head [noderef] __rcu *state_bydst
   net/xfrm/xfrm_state.c:2735:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_bydst @@
   net/xfrm/xfrm_state.c:2735:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:2735:33: sparse:     got struct hlist_head [noderef] __rcu *state_bydst
   net/xfrm/xfrm_state.c: note: in included file (through include/linux/workqueue.h):
   include/linux/rcupdate.h:709:9: sparse: sparse: context imbalance in 'xfrm_register_type' - unexpected unlock
   include/linux/rcupdate.h:709:9: sparse: sparse: context imbalance in 'xfrm_unregister_type' - unexpected unlock
   net/xfrm/xfrm_state.c:328:13: sparse: sparse: context imbalance in 'xfrm_get_type' - unexpected unlock
   include/linux/rcupdate.h:709:9: sparse: sparse: context imbalance in 'xfrm_register_type_offload' - unexpected unlock
   include/linux/rcupdate.h:709:9: sparse: sparse: context imbalance in 'xfrm_unregister_type_offload' - unexpected unlock
   include/linux/rcupdate.h:709:9: sparse: sparse: context imbalance in 'xfrm_get_type_offload' - unexpected unlock
   net/xfrm/xfrm_state.c:734:17: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:795:17: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:755:17: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:839:17: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:54:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:54:39: sparse:     expected struct refcount_struct [usertype] *r
   net/xfrm/xfrm_state.c:54:39: sparse:     got struct refcount_struct [noderef] __rcu *
   net/xfrm/xfrm_state.c:54:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:54:39: sparse:     expected struct refcount_struct [usertype] *r
   net/xfrm/xfrm_state.c:54:39: sparse:     got struct refcount_struct [noderef] __rcu *
   net/xfrm/xfrm_state.c:54:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:54:39: sparse:     expected struct refcount_struct [usertype] *r
   net/xfrm/xfrm_state.c:54:39: sparse:     got struct refcount_struct [noderef] __rcu *
   net/xfrm/xfrm_state.c:1227:9: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:1321:9: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:1356:9: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c: note: in included file:
   include/net/xfrm.h:1731:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/xfrm.h:1731:16: sparse:    struct sock [noderef] __rcu *
   include/net/xfrm.h:1731:16: sparse:    struct sock *

vim +2695 net/xfrm/xfrm_state.c

  2673	
  2674	int __net_init xfrm_state_init(struct net *net)
  2675	{
  2676		unsigned int sz;
  2677	
  2678		if (net_eq(net, &init_net))
  2679			xfrm_state_cache = KMEM_CACHE(xfrm_state,
  2680						      SLAB_HWCACHE_ALIGN | SLAB_PANIC);
  2681	
  2682		INIT_LIST_HEAD(&net->xfrm.state_all);
  2683	
  2684		sz = sizeof(struct hlist_head) * 8;
  2685	
  2686		net->xfrm.state_bydst = xfrm_hash_alloc(sz);
  2687		if (!net->xfrm.state_bydst)
  2688			goto out_bydst;
  2689		net->xfrm.state_bysrc = xfrm_hash_alloc(sz);
  2690		if (!net->xfrm.state_bysrc)
  2691			goto out_bysrc;
  2692		net->xfrm.state_byspi = xfrm_hash_alloc(sz);
  2693		if (!net->xfrm.state_byspi)
  2694			goto out_byspi;
> 2695		net->xfrm.state_byseq = xfrm_hash_alloc(sz);
  2696		if (!net->xfrm.state_byseq)
  2697			goto out_byseq;
  2698		net->xfrm.state_hmask = ((sz / sizeof(struct hlist_head)) - 1);
  2699	
  2700		net->xfrm.state_num = 0;
  2701		INIT_WORK(&net->xfrm.state_hash_work, xfrm_hash_resize);
  2702		spin_lock_init(&net->xfrm.xfrm_state_lock);
  2703		seqcount_spinlock_init(&net->xfrm.xfrm_state_hash_generation,
  2704				       &net->xfrm.xfrm_state_lock);
  2705		return 0;
  2706	
  2707	out_byseq:
  2708		xfrm_hash_free(net->xfrm.state_byspi, sz);
  2709	out_byspi:
  2710		xfrm_hash_free(net->xfrm.state_bysrc, sz);
  2711	out_bysrc:
  2712		xfrm_hash_free(net->xfrm.state_bydst, sz);
  2713	out_bydst:
  2714		return -ENOMEM;
  2715	}
  2716	
  2717	void xfrm_state_fini(struct net *net)
  2718	{
  2719		unsigned int sz;
  2720	
  2721		flush_work(&net->xfrm.state_hash_work);
  2722		flush_work(&xfrm_state_gc_work);
  2723		xfrm_state_flush(net, 0, false, true);
  2724	
  2725		WARN_ON(!list_empty(&net->xfrm.state_all));
  2726	
  2727		sz = (net->xfrm.state_hmask + 1) * sizeof(struct hlist_head);
> 2728		WARN_ON(!hlist_empty(net->xfrm.state_byseq));
> 2729		xfrm_hash_free(net->xfrm.state_byseq, sz);
  2730		WARN_ON(!hlist_empty(net->xfrm.state_byspi));
  2731		xfrm_hash_free(net->xfrm.state_byspi, sz);
  2732		WARN_ON(!hlist_empty(net->xfrm.state_bysrc));
  2733		xfrm_hash_free(net->xfrm.state_bysrc, sz);
  2734		WARN_ON(!hlist_empty(net->xfrm.state_bydst));
  2735		xfrm_hash_free(net->xfrm.state_bydst, sz);
  2736	}
  2737	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

