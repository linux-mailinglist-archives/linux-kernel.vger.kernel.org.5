Return-Path: <linux-kernel+bounces-150883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F375B8AA632
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED121F225F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C455438B;
	Fri, 19 Apr 2024 00:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WxB+WSJP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9853619E;
	Fri, 19 Apr 2024 00:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713486039; cv=none; b=mbEmfoubqpTGjcaxZXCDpHvhDEGgaByMJ6RXn+jTj0HKf8hIx+65MBfeKrNyHjx83aB/1eCujMAJHe00XFuB4UA9tEZhOT6I/8bvQu6qo2iurJqHABbJKdtKManmXy0TcuJLSoE9uvVl9nDVVordQ5/zZ8WCJmd46N80ZtX9fM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713486039; c=relaxed/simple;
	bh=LpOfZNVE6nHnz9BR7fw7WPp7kKPKZbrSWak6+3gqXIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chvZFuC+0ACxXRd+7dT+GG1VMydaRJ7xaYJTqBzA6yvnSaVawaM+yY1s/GVLYdvlv5gClTSH49e0XNG9AQ9f5oN4mBDyh8trnouHc0pOwmmC9ipY0mA08RDs02UCPfKRkuMX/y+Z3t0Xxd0XyFK7YIDV9JqwZCxXI2mZ3+X81G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WxB+WSJP; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713486037; x=1745022037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LpOfZNVE6nHnz9BR7fw7WPp7kKPKZbrSWak6+3gqXIE=;
  b=WxB+WSJPiaoLlt2rUA++KIumx9QFY2/HFQliM4PwzXvAnhZde80mObAS
   8VsGtE7SYQArt4jIgis7X6U+in/MFpPtJksutZXrYYHlEB4vdHBxxxqLu
   EPBrF8NgdODWXwykzBlDVW8LYdakhSLjs0YXcrr6WLzVCkCAQHBhbkyDv
   bkdY3plbtBGc8DHOAmQH2RsSLU92PCfjK2/oTQlo8B23Efn8j8rHc5bXj
   F4b1MIXDtkV7advusAh9/N7zg+dSyttceA3IeSTDrik6pTwDgChedzjrF
   1oiRxMZ+AnteOnc4iTuOqdBXe3bM64r4nznENrfVJf+l04biHRzY0xLLy
   g==;
X-CSE-ConnectionGUID: xt2pBpLITXOmY8r3A70/Og==
X-CSE-MsgGUID: 0IKSk0LsReWgrPxgBVzZEw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8929243"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="8929243"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 17:20:36 -0700
X-CSE-ConnectionGUID: YNCy/pPDQhCLFUtFdq7zow==
X-CSE-MsgGUID: hRzoxbpLRBmHDOxlJgJYlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23232293"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 18 Apr 2024 17:20:35 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxbzU-0009OO-31;
	Fri, 19 Apr 2024 00:20:32 +0000
Date: Fri, 19 Apr 2024 08:19:58 +0800
From: kernel test robot <lkp@intel.com>
To: Dawei Li <dawei.li@shingroup.cn>, davem@davemloft.net,
	andreas@gaisler.com
Cc: oe-kbuild-all@lists.linux.dev, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dawei Li <dawei.li@shingroup.cn>
Subject: Re: [PATCH 2/5] sparc/irq: Remove on-stack cpumask var
Message-ID: <202404190826.Zi1J5nCx-lkp@intel.com>
References: <20240418104949.3606645-3-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418104949.3606645-3-dawei.li@shingroup.cn>

Hi Dawei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.9-rc4]
[also build test WARNING on linus/master next-20240418]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dawei-Li/sparc-srmmu-Remove-on-stack-cpumask-var/20240418-185348
base:   v6.9-rc4
patch link:    https://lore.kernel.org/r/20240418104949.3606645-3-dawei.li%40shingroup.cn
patch subject: [PATCH 2/5] sparc/irq: Remove on-stack cpumask var
config: sparc64-defconfig (https://download.01.org/0day-ci/archive/20240419/202404190826.Zi1J5nCx-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240419/202404190826.Zi1J5nCx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404190826.Zi1J5nCx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/sparc/kernel/irq_64.c: In function 'irq_choose_cpu':
>> arch/sparc/kernel/irq_64.c:358:46: warning: the omitted middle operand in '?:' will always be 'true', suggest explicit middle operand [-Wparentheses]
     358 |                 cpuid = cpuid < nr_cpu_ids ? : map_to_cpu(irq);
         |                                              ^


vim +358 arch/sparc/kernel/irq_64.c

   348	
   349	#ifdef CONFIG_SMP
   350	static int irq_choose_cpu(unsigned int irq, const struct cpumask *affinity)
   351	{
   352		int cpuid;
   353	
   354		if (cpumask_equal(affinity, cpu_online_mask)) {
   355			cpuid = map_to_cpu(irq);
   356		} else {
   357			cpuid = cpumask_first_and(affinity, cpu_online_mask);
 > 358			cpuid = cpuid < nr_cpu_ids ? : map_to_cpu(irq);
   359		}
   360	
   361		return cpuid;
   362	}
   363	#else
   364	#define irq_choose_cpu(irq, affinity)	\
   365		real_hard_smp_processor_id()
   366	#endif
   367	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

