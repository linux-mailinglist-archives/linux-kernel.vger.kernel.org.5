Return-Path: <linux-kernel+bounces-10653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D620B81D829
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 09:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D689DB21356
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 08:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D32715C5;
	Sun, 24 Dec 2023 08:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y1kqeqFG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980CC111C
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703405019; x=1734941019;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=d4YLznvoFUdo23PFke8rrgb9DLB67IMQm9O8Dzsmia8=;
  b=Y1kqeqFG52BwJm+YFXgX/Vs76fujwMcMXaxZuFNhS/6QDkYKEz3lQ2B5
   DABzHMXPsvz2kCFHIKt8/qaSpcQclSrqZo5zabyW3figH5wMcV4z6/JY6
   wjyJAc8FzSb2sGtFTqy1eSWGav4/cuyxIVt6QNIdSBTE9z1dfJ8Rwyhzb
   CNtkeweJaRnKp+NRkpCprO7TeZjk90WoOseRyNctNjOrN3TYIFmS51KXd
   GQxl9lxeSJZIN4WKHZl+YvZhocq86OPLyXyJru9xTj3ACWmTQZF65Ji1k
   uUqNpkwfOAicl80S+xVDIcBit/ikJG9AhWF2hoAks3qTJq4U3m4zjYLIs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="386659955"
X-IronPort-AV: E=Sophos;i="6.04,300,1695711600"; 
   d="scan'208";a="386659955"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 00:03:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="868124956"
X-IronPort-AV: E=Sophos;i="6.04,300,1695711600"; 
   d="scan'208";a="868124956"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Dec 2023 00:03:37 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHJQD-000Bzd-2G;
	Sun, 24 Dec 2023 08:01:59 +0000
Date: Sun, 24 Dec 2023 15:59:33 +0800
From: kernel test robot <lkp@intel.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>
Subject: WARN: resolve_btfids: unresolved symbol bpf_obj_new_impl
Message-ID: <202312241556.HvtxWr3T-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   861deac3b092f37b2c5e6871732f3e11486f7082
commit: 7b99f75942da332e3f4f865e55a10fec95a30d4f bpf: Add --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags for v1.25
date:   8 months ago
config: arm-randconfig-r014-20230728 (https://download.01.org/0day-ci/archive/20231224/202312241556.HvtxWr3T-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231224/202312241556.HvtxWr3T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312241556.HvtxWr3T-lkp@intel.com/

All warnings (new ones prefixed by >>):

   WARN: resolve_btfids: unresolved symbol prog_test_ref_kfunc
   WARN: resolve_btfids: unresolved symbol bpf_cpumask
>> WARN: resolve_btfids: unresolved symbol bpf_obj_new_impl
   WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_xdp
   WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_skb

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

