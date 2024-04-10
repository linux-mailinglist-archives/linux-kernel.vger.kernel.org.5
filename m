Return-Path: <linux-kernel+bounces-139285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D87648A00EE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A731C22520
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A6B181B88;
	Wed, 10 Apr 2024 19:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QylYHhYI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D9D18133A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712779114; cv=none; b=k6Q9TV1F5VERXYHUPj2U+LBkAd6gXycDlUL/qx9OiGSw+Mg38vZuolC8ByxaoHpXeodX2crrs35zQWeFvdZCq7VIHafyfQdm8jJj3RrMQpMhUbMw1S7M78VQMHZfsIiqCYJM1sGxu4Tf6lqRNXVC58UVPyQaqWMrSbuX9ncfWeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712779114; c=relaxed/simple;
	bh=zLwmqMV4AThUNLY2C0AJAwuOIliylAKYtQ0vTEe64Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVVhiXwneEhhNjRDGC831HZgXxq/tBFJQMvdc714fB9WerFml+x4U7IzVNDMY8OVKvOHQLweLxBejoETpPExR0SHoW4MQkiLFtPAcjJeCA6JRiBhuhHzZE/lJpTaaaGuMSCxJPQ9pNOtXVU2QRnWcEuTYZ0c9+VOyFDahkn1v6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QylYHhYI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712779113; x=1744315113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zLwmqMV4AThUNLY2C0AJAwuOIliylAKYtQ0vTEe64Gg=;
  b=QylYHhYIzrCwkNlxYtL+AM1zsD3VdFFrPfN8mUlESsv2OueT+IAiVtZk
   PBGeLwoxSbHkl73nbgmP3Sx3NVTFV8pKSIP0aUveS/Fcq+TL+6EEflnX4
   4d/mOpzBacDXuhmoZrY/kRQj9Cs3XPOB2HD4JS12sMA06IYzUUUtVlhBi
   2ltsewgxhz8SrjoBpuIPYflW1PDnR1v1Z4+/vmjL4k/jOxAmOTZMRxrm9
   7ocT7LBxIySfkbYGXRPDBukMimCF8yfleRSWE5qPREx18rzC/MQl9sJGf
   rBiLDsa8LdWmImp27xjOxrpoIV4hkdt8RaKFiXrciuaR30wLLSEDCGfyN
   Q==;
X-CSE-ConnectionGUID: zyv23Df7RdaUyqrw1Egp8w==
X-CSE-MsgGUID: K4JrVTalRLG8CnBLmofSpg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8026704"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="8026704"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 12:58:31 -0700
X-CSE-ConnectionGUID: 81dFEfzJTEm0/J5lUQyriA==
X-CSE-MsgGUID: f1p2tR/CRuyjiSt/lZUEyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="20753180"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 10 Apr 2024 12:58:29 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rue5S-0007kO-26;
	Wed, 10 Apr 2024 19:58:26 +0000
Date: Thu, 11 Apr 2024 03:57:30 +0800
From: kernel test robot <lkp@intel.com>
To: Jinglin Wen <jinglin.wen@shingroup.cn>, palmer@dabbelt.com
Cc: oe-kbuild-all@lists.linux.dev, paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu, gregkh@linuxfoundation.org,
	atishp@rivosinc.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Jinglin Wen <jinglin.wen@shingroup.cn>
Subject: Re: [PATCH 1/3] riscv: Support for early console.
Message-ID: <202404110326.Qa9YV4bV-lkp@intel.com>
References: <20240410063432.23058-2-jinglin.wen@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410063432.23058-2-jinglin.wen@shingroup.cn>

Hi Jinglin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus linus/master v6.9-rc3 next-20240410]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jinglin-Wen/riscv-Support-for-early-console/20240410-143840
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20240410063432.23058-2-jinglin.wen%40shingroup.cn
patch subject: [PATCH 1/3] riscv: Support for early console.
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20240411/202404110326.Qa9YV4bV-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240411/202404110326.Qa9YV4bV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404110326.Qa9YV4bV-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/riscv/kernel/early_console.c: In function 'early_console_printf':
>> arch/riscv/kernel/early_console.c:51:17: warning: function 'early_console_printf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
      51 |                 vsnprintf(buf, EARLY_CONSOLE_BUFSIZE, fmt, args);
         |                 ^~~~~~~~~


vim +51 arch/riscv/kernel/early_console.c

    42	
    43	#define EARLY_CONSOLE_BUFSIZE 256
    44	void early_console_printf(const char *fmt, ...)
    45	{
    46		if (riscv_early_console_putc) {
    47			char buf[EARLY_CONSOLE_BUFSIZE];
    48			va_list args;
    49	
    50			va_start(args, fmt);
  > 51			vsnprintf(buf, EARLY_CONSOLE_BUFSIZE, fmt, args);
    52			early_console_puts(buf);
    53			va_end(args);
    54		}
    55	}
    56	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

