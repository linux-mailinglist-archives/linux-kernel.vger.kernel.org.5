Return-Path: <linux-kernel+bounces-10821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF9181DC59
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 21:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68526281DF3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 20:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1091EDF61;
	Sun, 24 Dec 2023 20:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJs1h5Bl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7F7DF52
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703449920; x=1734985920;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+gn+rc0/aHfOoQ7X0jzN46qOjEh5aMTxtyJwrWyB1Q4=;
  b=kJs1h5BlzqzSEPiNaTlqgUehFRlMsOOW6H+CN83USSxF3iW3282+uKL5
   N4q6po7CIAI6DkTEH4nRy8Lg8subRd5A+1/8f2WYR9b4VAdM3kiihSoLG
   js92NoPWANVaKe/5HFEhl1YeEKs8w21ndOS32srjWht8les50s+LUitTs
   g840uQCZD4LL8DBUqkANKeuIkUiroQJsG1rKOfLCAPbXRAawaoeoISSzz
   efYRSafW//0TeZRk5k48wXgQVZAEgkWvzYuMomCyDbl8pGTPKHBoRgBVP
   9B+w53G43QfoujMuZKVSXTCTo0U9a9q5Xqbr2rOSKLwZbX0xZi6YOagbH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="399032490"
X-IronPort-AV: E=Sophos;i="6.04,301,1695711600"; 
   d="scan'208";a="399032490"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 12:32:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="1109003731"
X-IronPort-AV: E=Sophos;i="6.04,301,1695711600"; 
   d="scan'208";a="1109003731"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 24 Dec 2023 12:31:58 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHV8R-000Cd8-32;
	Sun, 24 Dec 2023 20:31:44 +0000
Date: Mon, 25 Dec 2023 04:30:29 +0800
From: kernel test robot <lkp@intel.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>
Subject: WARN: resolve_btfids: unresolved symbol bpf_percpu_obj_new_impl
Message-ID: <202312250413.x3uDC4YH-lkp@intel.com>
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
commit: 36d8bdf75a93190e5669b9d1d95994e13e15ba1d bpf: Add alloc/xchg/direct_access support for local percpu kptr
date:   4 months ago
config: arm-randconfig-r014-20230728 (https://download.01.org/0day-ci/archive/20231225/202312250413.x3uDC4YH-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231225/202312250413.x3uDC4YH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312250413.x3uDC4YH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   WARN: resolve_btfids: unresolved symbol prog_test_ref_kfunc
   WARN: resolve_btfids: unresolved symbol bpf_cpumask
>> WARN: resolve_btfids: unresolved symbol bpf_percpu_obj_new_impl
   WARN: resolve_btfids: unresolved symbol bpf_obj_new_impl
   WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_xdp
   WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_skb

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

