Return-Path: <linux-kernel+bounces-152649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 638068AC1FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBAE8280CD7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59EA44C8F;
	Sun, 21 Apr 2024 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ggv/vjcg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06886175AB
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 22:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713740326; cv=none; b=uHJK5xEgTpEt7rdvtcD+Qiraz6F+c/yu7tZd1OIooTfzKwX+cHFKLLHcK8HNlVYmCLhMlpolvmnWjz98lIRhQehQjxwdbAOaviu4Zyk0p3I5ZsA+dR31FQHRyF97Z0zJMf47arZdJeOoDp0rRrwnvqbsVFBDazDPcDdihe2rN/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713740326; c=relaxed/simple;
	bh=FfkEvj3224K+BsB0MJupvSWk89bACoL6USvKHySPRKI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uUDJXUqh9eb6tmt5dRQJBETEQ9eANFeIcFsZbp6OSNoJMYvjknx8gb10z+Fd9ptateIJJGw44pZB+mBAzQEPRUsQcnRGyK5kSg/AgY4827cUkhpJoDf377ZxtzbJl686qa1/Ym0GIRatr52IMrWbWfKrJr7mDf73hKuKVnct+Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ggv/vjcg; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713740323; x=1745276323;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FfkEvj3224K+BsB0MJupvSWk89bACoL6USvKHySPRKI=;
  b=Ggv/vjcg2WXfAfpPu7T/KW4z/JVo1nANK7Lul55dCvD206X1WdnCViIn
   wQ9QlXDwD+lgY4l5mjGc50/cTZQp/S+tUcqwunBNz4vPp1whXQm4Y5yyl
   Rw9MlV5BFXHuG0c63q1DpxcEaJApHsJnImQI9RlCeHvT5T9egHURbDra2
   jIcvXO09/Uy7rkS2j5MibPadOMMFAtn+0xo4hF7n74nBJZZeqmEv3LGJX
   2Zi5i8iYuTFFpGtdhdB6YpI4aAYuKSwYHhv8F8RnYqCjVh6uQfiZg863l
   0DltfOOwDuwG/6YmkkUSxQvoTkwRCjvLojY6VBOpp+N7K2105xJ6pfukd
   A==;
X-CSE-ConnectionGUID: seAaCcLWRMyn2xASdcjSKg==
X-CSE-MsgGUID: JmjeNUiwTGGYLejH2HMANg==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="9384115"
X-IronPort-AV: E=Sophos;i="6.07,219,1708416000"; 
   d="scan'208";a="9384115"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2024 15:58:42 -0700
X-CSE-ConnectionGUID: Dl4SsmqnRRKoWM2kssW3+g==
X-CSE-MsgGUID: qwvw5gi7S4yXR3IvgxwiRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,219,1708416000"; 
   d="scan'208";a="23908218"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 21 Apr 2024 15:58:40 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ryg8s-000CCQ-1Y;
	Sun, 21 Apr 2024 22:58:38 +0000
Date: Mon, 22 Apr 2024 06:58:36 +0800
From: kernel test robot <lkp@intel.com>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: cfi_util.c:(.xiptext+0x257): dangerous relocation: windowed longcall
 crosses 1GB boundary; return may fail: __tsan_write4
Message-ID: <202404220616.NxJhnAye-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ed30a4a51bb196781c8058073ea720133a65596f
commit: 03ce34cf8f50e4c62f9a4b62caffdba1165ca977 xtensa: add XIP-aware MTD support
date:   8 months ago
config: xtensa-randconfig-r015-20221109 (https://download.01.org/0day-ci/archive/20240422/202404220616.NxJhnAye-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240422/202404220616.NxJhnAye-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404220616.NxJhnAye-lkp@intel.com/

All errors (new ones prefixed by >>):

   cfi_probe.c:(.xiptext+0x1098): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x10a4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x10b9): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x10c2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x10d0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x10e8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x10f0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_probe.c:(.xiptext+0x10fe): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x1112): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x1127): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x1132): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x113a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x1148): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x1153): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x1160): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_probe.c:(.xiptext+0x116e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x18)
   cfi_probe.c:(.xiptext+0x1177): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x1182): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x118f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_probe.c:(.xiptext+0x119b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_probe.o: in function `cfi_probe_chip':
   cfi_probe.c:(.xiptext+0x1332): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   cfi_probe.c:(.xiptext+0x133c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x1346): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x1353): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x135e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x136c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x1377): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x1384): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_probe.c:(.xiptext+0x1397): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x13a2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x13af): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_probe.c:(.xiptext+0x13c0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x13cb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x13d8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_probe.c:(.xiptext+0x13f3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x13fe): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x140b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_probe.c:(.xiptext+0x1429): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x1434): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x1442): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_probe.c:(.xiptext+0x1453): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x145e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x146a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x1477): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_probe.c:(.xiptext+0x148d): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x1498): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x14a6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_probe.c:(.xiptext+0x14b7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x14cd): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x14de): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   cfi_probe.c:(.xiptext+0x14ef): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x14fa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x1506): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_probe.c:(.xiptext+0x1511): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x1520): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x152f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_probe.c:(.xiptext+0x1548): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x1551): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x1566): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_probe.c:(.xiptext+0x1595): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x159e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x15ae): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_probe.c:(.xiptext+0x15bf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x15cb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x15d8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_probe.c:(.xiptext+0x15e7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x1600): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x160b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x161a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_probe.c:(.xiptext+0x1640): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x164b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x1658): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_probe.c:(.xiptext+0x1668): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x1673): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x1682): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_probe.c:(.xiptext+0x168e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x1698): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x16ae): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_probe.c:(.xiptext+0x16d6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x16e0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_probe.c:(.xiptext+0x16fb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_probe.c:(.xiptext+0x1712): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_util.o: in function `cfi_qry_present':
   cfi_util.c:(.xiptext+0x146): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   cfi_util.c:(.xiptext+0x14c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x154): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x15f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x170): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x184): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x19c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x1b0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x1cb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x1e4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x200): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x213): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x21e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x238): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x246): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x24e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
>> cfi_util.c:(.xiptext+0x257): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_util.c:(.xiptext+0x262): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x26e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x27b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_util.c:(.xiptext+0x28e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x29c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x2b4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x2bf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x2ce): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_util.c:(.xiptext+0x2de): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x2eb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_util.c:(.xiptext+0x2f8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x303): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_util.c:(.xiptext+0x313): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x322): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_util.c:(.xiptext+0x32f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x344): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x352): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x35a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x363): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_util.c:(.xiptext+0x36e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x37a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x387): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_util.c:(.xiptext+0x39a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x3aa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_util.c:(.xiptext+0x3b8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x3ce): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x3d7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_util.c:(.xiptext+0x3e7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x3f4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_util.c:(.xiptext+0x402): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x415): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x422): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x42a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x433): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_util.c:(.xiptext+0x43e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x44a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x457): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_util.c:(.xiptext+0x46a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x478): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x487): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x490): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_util.c:(.xiptext+0x49b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x4aa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x4b8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_util.c:(.xiptext+0x4c2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_util.o: in function `cfi_qry_mode_off':
   cfi_util.c:(.xiptext+0x536): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   cfi_util.c:(.xiptext+0x53c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x54a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x55c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x578): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x586): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x59c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x5a7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x5b0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x5be): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x5ca): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x5d7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_util.c:(.xiptext+0x5e8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x5f7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x610): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x61c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x627): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x634): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_util.c:(.xiptext+0x63e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   drivers/mtd/chips/cfi_util.o: in function `cfi_qry_mode_on':
   cfi_util.c:(.xiptext+0x7fe): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   cfi_util.c:(.xiptext+0x804): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x812): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x823): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x83a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x854): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x862): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x880): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x88b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x898): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x8a3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x8b4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_util.c:(.xiptext+0x8c8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x8d8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x8f4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x902): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x918): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x932): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x940): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x960): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x96b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x97c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_util.c:(.xiptext+0x988): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0x993): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x9a4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_util.c:(.xiptext+0x9b8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x9c7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x9dc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x9f4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0xa03): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0xa23): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0xa2e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0xa3c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __sanitizer_cov_trace_pc
   cfi_util.c:(.xiptext+0xa47): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

