Return-Path: <linux-kernel+bounces-164370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43E78B7CD8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87101C23326
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCCD17A939;
	Tue, 30 Apr 2024 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SNc3nYv8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80D6179658;
	Tue, 30 Apr 2024 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494519; cv=none; b=K5yu2b8D+igH8V7mzt9Ka9CFtk/T3khLBsIZHDHC7+nOVw1YVX2PNNFiakprYZ1oyurfE6f4vxTHGnoCw5N95yNL1z7CrBXDpExYeGoc9Qqar2UU47KeK+czppNNqu69XlTubj2pn+ftaZGHVx6ZfFu27nWFw0OHAl8817QciQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494519; c=relaxed/simple;
	bh=ugkt3k4B4PYbENI6jlGFe6etoG8QJ8s0xUKQxIhNEMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6atL4xeqAxqJEzRxbuw9AP7ZUPadP6iXsksgSQoHkXq0qIK3zk6lAt6D8gNYMO7IKkJifVmQD+7TnkVjzGzhZXC97Yt7hJA2aICmF9R6yOiboXGjZXOn6G+n5DZCSv5ROIIyMaUWJQVqHppX9LMJrOaV1C0FR6UobSWOVD0k0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SNc3nYv8; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714494518; x=1746030518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ugkt3k4B4PYbENI6jlGFe6etoG8QJ8s0xUKQxIhNEMY=;
  b=SNc3nYv8QZNk0MPnggrGQkbOoZDE2R/5qjQeTJCOLWvnFohctauVJB22
   jViMQdZ92pxUlPYQlCgd8Fqfeq4YaffrU2k/4SOYVu4EctYd8rZ7lViIa
   V8DDTuQQrMi29Xx2YRfq3PEr7WGyPzO7rlT2Nib7jaY3/v5ZbtwRfaBT+
   W3b2rru508Q7SbYYNORy6OIWryMZkOehI8b9oCj09DbJ9GDdPDo+m4/TJ
   gIFbSQfZN4ne4iX70Bl4me7iBYJRIcCVnsk3WgnAx/h0Wqs8KKZFX2Edc
   lQb0rczBcHkuCCAHhR6g5uXsdLReho+8iS0ebp1ukvfxys9qjMwdPVtun
   Q==;
X-CSE-ConnectionGUID: FMTSUrHsQkiqS5JVUcWVKw==
X-CSE-MsgGUID: 8QcIDfi/QvWIc08zbOO9pw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="13994263"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="13994263"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:28:37 -0700
X-CSE-ConnectionGUID: XwE2O6zpS8Onouf1kmd13g==
X-CSE-MsgGUID: Y3r7vwXvQb6rUnmrtCY3zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="57394192"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 30 Apr 2024 09:28:31 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1qLE-0008Lj-1Y;
	Tue, 30 Apr 2024 16:28:28 +0000
Date: Wed, 1 May 2024 00:27:54 +0800
From: kernel test robot <lkp@intel.com>
To: lakshmi.sowjanya.d@intel.com, tglx@linutronix.de, jstultz@google.com,
	giometti@enneenne.com, corbet@lwn.net, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, christopher.s.hall@intel.com,
	subramanian.mohan@intel.com, lakshmi.sowjanya.d@intel.com,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	pandith.n@intel.com, x86@kernel.org, eddie.dong@intel.com,
	linux-sound@vger.kernel.org, alexandre.torgue@foss.st.com,
	peter.hilber@opensynergy.com, joabreu@synopsys.com,
	intel-wired-lan@lists.osuosl.org, mcoquelin.stm32@gmail.com,
	thejesh.reddy.t.r@intel.com, perex@perex.cz,
	anthony.l.nguyen@intel.com, andriy.shevchenko@linux.intel.com,
	davem@davemloft.net
Subject: Re: [Intel-wired-lan] [PATCH v7 09/12] timekeeping: Add function to
 convert realtime to base clock
Message-ID: <202405010052.Cxh2bazm-lkp@intel.com>
References: <20240430085225.18086-10-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430085225.18086-10-lakshmi.sowjanya.d@intel.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/timers/core]
[also build test WARNING on tnguy-next-queue/dev-queue tnguy-net-queue/dev-queue linus/master v6.9-rc6 next-20240430]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/lakshmi-sowjanya-d-intel-com/timekeeping-Add-base-clock-properties-in-clocksource-structure/20240430-165602
base:   tip/timers/core
patch link:    https://lore.kernel.org/r/20240430085225.18086-10-lakshmi.sowjanya.d%40intel.com
patch subject: [Intel-wired-lan] [PATCH v7 09/12] timekeeping: Add function to convert realtime to base clock
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20240501/202405010052.Cxh2bazm-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240501/202405010052.Cxh2bazm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405010052.Cxh2bazm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/time/timekeeping.c:1271: warning: Function parameter or struct member 'cycles' not described in 'ktime_real_to_base_clock'
   kernel/time/timekeeping.c:2547: warning: Function parameter or struct member 'txc' not described in 'do_adjtimex'
   kernel/time/timekeeping.c:2615: warning: Function parameter or struct member 'phase_ts' not described in 'hardpps'
   kernel/time/timekeeping.c:2615: warning: Function parameter or struct member 'raw_ts' not described in 'hardpps'


vim +1271 kernel/time/timekeeping.c

  1259	
  1260	/**
  1261	 * ktime_real_to_base_clock() - Convert CLOCK_REALTIME timestamp to a base clock timestamp
  1262	 * @treal:	CLOCK_REALTIME timestamp to convert
  1263	 * @base_id:	base clocksource id
  1264	 * @*cycles:	pointer to store the converted base clock timestamp
  1265	 *
  1266	 * Converts a supplied, future realtime clock value to the corresponding base clock value.
  1267	 *
  1268	 * Return:  true if the conversion is successful, false otherwise.
  1269	 */
  1270	bool ktime_real_to_base_clock(ktime_t treal, enum clocksource_ids base_id, u64 *cycles)
> 1271	{
  1272		struct timekeeper *tk = &tk_core.timekeeper;
  1273		unsigned int seq;
  1274		u64 delta;
  1275	
  1276		do {
  1277			seq = read_seqcount_begin(&tk_core.seq);
  1278			if ((u64)treal < tk->tkr_mono.base_real)
  1279				return false;
  1280			delta = (u64)treal - tk->tkr_mono.base_real;
  1281			if (!convert_ns_to_cs(&delta))
  1282				return false;
  1283			*cycles = tk->tkr_mono.cycle_last + delta;
  1284			if (!convert_cs_to_base(cycles, base_id))
  1285				return false;
  1286		} while (read_seqcount_retry(&tk_core.seq, seq));
  1287	
  1288		return true;
  1289	}
  1290	EXPORT_SYMBOL_GPL(ktime_real_to_base_clock);
  1291	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

