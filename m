Return-Path: <linux-kernel+bounces-148098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E80638A7DAB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8EC1F24089
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96767C6D5;
	Wed, 17 Apr 2024 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ULmEmzro"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD267C0B7
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713341038; cv=none; b=SXEb5iqjvWoUZ9BMgMcuKLuiVkvWTLqwtHa5BqFFi6pFa4mldgiYRv/cRsWY4BLXX48davNGgLvu0gOP8Y42QmlGjgBmDPr3eLtL4zta/awjGZQvkvOKbsuhfyxZwKdjmVDeTxfhUrkeYnx3WzD3FZlYgR0ZBVYWiG4eZTZ00W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713341038; c=relaxed/simple;
	bh=U25CbIrq2jWLxU2udGIy5RjYN3IOG0T8/1W7bVg5PdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITnIGQCp9b2MpjEWkA6VzLMi3BlHf85/mErwqx5z7fCfTiDh0d4ZbTKLahOw5pg0kbe63RhTHq/I8t1YkX28sR7LRP+Pwdrss2qzn8gGkE95hgwkvwlLqghCRWbbCDm8cZ9gMwgqmvkNs/aArXA2FeWlhaDZ43ip63uBC6LKUbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ULmEmzro; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713341033; x=1744877033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U25CbIrq2jWLxU2udGIy5RjYN3IOG0T8/1W7bVg5PdQ=;
  b=ULmEmzroq6HX3YV5hBsTFDsM+NpPM1qFhjkaq7NgdvWOcG+TnVVqzv1e
   OPsra72Knvp9KL9wdFRbDfMkz2ji5DW+fas5lr7DinoJp0Xbs4Of0KAeZ
   cSKav7MyEHo3r7gc5SI3DudZ2aCGMv8FCOn5eATfeMPEbeoLyF1m1hEC6
   q0Otb796rWXhJX5tJK73HEP3RtWXkpZjoIyUoJCsk2+x+Dq+RPBxZAVEu
   bxP1EIvxMekEnQhtHHqrW8AAcyrLiaXamJZSHt4NUSlozo0MUs/HRW3SM
   3MmGqilWHGJp1x2qCBeab3/bUqwDE/UID13BmDT6G8a0PKmGTq/hDm1BB
   g==;
X-CSE-ConnectionGUID: ZrjSd6QuQ8yNFP97sHny/Q==
X-CSE-MsgGUID: H8ylmn9jRYOxUrSqXmfErA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="31300743"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="31300743"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 01:03:51 -0700
X-CSE-ConnectionGUID: 5nRE2iQNRemALNiykozjwg==
X-CSE-MsgGUID: VQmyzcNCShSNIddc8wPEWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="22413256"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 17 Apr 2024 01:03:49 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rx0Gc-0006Hc-03;
	Wed, 17 Apr 2024 08:03:42 +0000
Date: Wed, 17 Apr 2024 16:03:29 +0800
From: kernel test robot <lkp@intel.com>
To: Jinglin Wen <jinglin.wen@shingroup.cn>, palmer@dabbelt.com
Cc: oe-kbuild-all@lists.linux.dev, paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu, gregkh@linuxfoundation.org,
	atishp@rivosinc.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Jinglin Wen <jinglin.wen@shingroup.cn>
Subject: Re: [PATCH 2/3] riscv: SBI as the interface for the early console
Message-ID: <202404171502.Yz861Nvd-lkp@intel.com>
References: <20240410063432.23058-3-jinglin.wen@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410063432.23058-3-jinglin.wen@shingroup.cn>

Hi Jinglin,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus linus/master v6.9-rc4 next-20240416]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jinglin-Wen/riscv-Support-for-early-console/20240410-143840
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20240410063432.23058-3-jinglin.wen%40shingroup.cn
patch subject: [PATCH 2/3] riscv: SBI as the interface for the early console
config: riscv-randconfig-r071-20240417 (https://download.01.org/0day-ci/archive/20240417/202404171502.Yz861Nvd-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240417/202404171502.Yz861Nvd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404171502.Yz861Nvd-lkp@intel.com/

All errors (new ones prefixed by >>):

   riscv64-linux-ld: arch/riscv/kernel/early_console.o: in function `early_console_init':
>> arch/riscv/kernel/early_console.c:100:(.init.text+0x18): undefined reference to `hvc_sbi_early_init'


vim +100 arch/riscv/kernel/early_console.c

f4e6608ec4adae Jinglin Wen 2024-04-10   87  
f4e6608ec4adae Jinglin Wen 2024-04-10   88  /*
f4e6608ec4adae Jinglin Wen 2024-04-10   89   * This is called after sbi_init.
f4e6608ec4adae Jinglin Wen 2024-04-10   90   */
f4e6608ec4adae Jinglin Wen 2024-04-10   91  void __init early_console_init(void)
f4e6608ec4adae Jinglin Wen 2024-04-10   92  {
f4e6608ec4adae Jinglin Wen 2024-04-10   93  	/*
f4e6608ec4adae Jinglin Wen 2024-04-10   94  	 * Set riscv_early_console_putc.
f4e6608ec4adae Jinglin Wen 2024-04-10   95  	 * If there are other output interfaces, you can add corresponding code
f4e6608ec4adae Jinglin Wen 2024-04-10   96  	 * to initialize riscv_early_console_putc.
f4e6608ec4adae Jinglin Wen 2024-04-10   97  	 */
f4e6608ec4adae Jinglin Wen 2024-04-10   98  #if defined(CONFIG_RISCV_EARLY_CONSOLE_SBI)
f4e6608ec4adae Jinglin Wen 2024-04-10   99  	/* using the sbi */
f4e6608ec4adae Jinglin Wen 2024-04-10 @100  	hvc_sbi_early_init(&riscv_early_console_putc);
f4e6608ec4adae Jinglin Wen 2024-04-10  101  #else
f4e6608ec4adae Jinglin Wen 2024-04-10  102  	/* using other */
f4e6608ec4adae Jinglin Wen 2024-04-10  103  #endif
f4e6608ec4adae Jinglin Wen 2024-04-10  104  
f4e6608ec4adae Jinglin Wen 2024-04-10  105  	console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
f4e6608ec4adae Jinglin Wen 2024-04-10  106  	register_early_console();
f4e6608ec4adae Jinglin Wen 2024-04-10  107  }
f4e6608ec4adae Jinglin Wen 2024-04-10  108  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

