Return-Path: <linux-kernel+bounces-24349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CF582BB6C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1ED1C24FA9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932EF5C907;
	Fri, 12 Jan 2024 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXu6qLXF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2C51A72F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 06:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705042702; x=1736578702;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A4Uy7Ajsj6SUOi6nMD1J8RWRv90SkpcVxs+drA+sxhY=;
  b=jXu6qLXFxYzLupPKjD57nE36XaYzHS46zU1yPqwFwpFJ22o7OI1C8XVR
   AHcYxKSbtBe+1K3kN1U9lcRftqVX0tL9fAp4BbJ6nmLdyAADvA7FPPjNr
   WNbEOe8hZeTIF0uHFRfWdnq608u4j60haHATH8tkZgcDxiRk7Sk20Ra19
   +nMjjFcFjsAtyr7VTNOTbd7rvepxZ6YIzVSwrreEazZAw8bhAp1Phew7m
   rXZN3nCf5YCdy34WLxTz5mPvKc0HhrKFSccZB66QgWWNnXib0A6ieNi2G
   uI0L4cT+5fKlbavsSzeP4kVrysyvJzwpvioaMiHv2bJvaiH4kfFuslLMh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="5822853"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="5822853"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 22:58:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="24910675"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 11 Jan 2024 22:58:18 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOBUe-0009BA-2S;
	Fri, 12 Jan 2024 06:58:16 +0000
Date: Fri, 12 Jan 2024 14:57:58 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>
Subject: WARNING: modpost: vmlinux: section mismatch in reference:
 __apply_fineibt+0x542 (section: .text) -> poison_endbr (section: .init.text)
Message-ID: <202401121450.TRN6qxCa-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   70d201a40823acba23899342d62bc2644051ad2e
commit: 04505bbbbb15da950ea0239e328a76a3ad2376e0 x86/fineibt: Poison ENDBR at +0
date:   6 months ago
config: x86_64-buildonly-randconfig-003-20240112 (https://download.01.org/0day-ci/archive/20240112/202401121450.TRN6qxCa-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240112/202401121450.TRN6qxCa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401121450.TRN6qxCa-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x12f (section: .text) -> text_poke_early (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x1d5 (section: .text) -> text_poke_early (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x2ec (section: .text) -> text_poke_early (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x3aa (section: .text) -> text_poke_early (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x40b (section: .text) -> text_poke_early (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x42b (section: .text) -> text_poke_early (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x4e5 (section: .text) -> text_poke_early (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x50c (section: .text) -> text_poke_early (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x542 (section: .text) -> poison_endbr (section: .init.text)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

