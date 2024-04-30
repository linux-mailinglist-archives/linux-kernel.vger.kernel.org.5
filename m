Return-Path: <linux-kernel+bounces-163278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF738B6819
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5A11C21E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E221078F;
	Tue, 30 Apr 2024 02:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vt41SZpA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6835DDA1;
	Tue, 30 Apr 2024 02:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714445712; cv=none; b=eA0fj3nF4m1fzwvgRtpuhbP2AzeSK2x29Xf0Kp/rubRsEpEk8WArToqaE3bzwgWmv3MxcVtDZvN8rqbD3HyZc0Ro3yAOklygfZ6cK3h3ZQ2IicsAaSd4/n/jgUZdK3hjM+XEm53rF3WJnM5kAZk3cgVQZh5dYk/7BckvV6TipOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714445712; c=relaxed/simple;
	bh=iZ6nNOe9HtBpD2tVNcHlM/SflcebPn4cUJdzsYt8o5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ai9J0+B09pGe5WCv6WBsO2dbL9xYX+xBYHPOAZXebBRgvMEHUwn61T+1ntoeX2Doyc/xpNWqmt+Y2uquv26/OnFR+dG+5GjVax1/YDoJjxqnrsFOrHDXTZh3U5eaIwVT8F/xXaHS+OniEDp9mt1vQBiMR7vZrRp4YcJbO22xwCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vt41SZpA; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714445711; x=1745981711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iZ6nNOe9HtBpD2tVNcHlM/SflcebPn4cUJdzsYt8o5M=;
  b=Vt41SZpA8s2iAF7e4LNfVfw2coTewpt0IIOn4ftcZf+AYjqJWeGN6lkr
   XNBK9m5WIqu2xZd74dTPZ0SyG6qwc2Oqdu4ElrmUTNO487HySOIZRezK+
   SjANXNhUpJvq4HWRimpoS8pvNf4ryqn/tFS5MGfQF0dChtB/ae1qQu3QU
   TlFOxXNWbrX/JgQtVj8mflNUIwLetIq8YlCTa/QBYgTqlhEU35+6J7Rt4
   2T+UhYGJ/zIInjS8vOL24U17fB1kZ+c4ufnAzm2q4hEuLcmVsThLsI6pp
   vvljfYnPGzQlw4JuRve+RSjoXgf+T+6rTDNqgW4N7gaSJYSPWZ/kPje+t
   g==;
X-CSE-ConnectionGUID: ZzlFhlneTwu/bwLqDeDdxQ==
X-CSE-MsgGUID: BeW712F/T9G3w3lqW3abUg==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10299262"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="10299262"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 19:55:10 -0700
X-CSE-ConnectionGUID: du8PLjy7Q7KwqHJe8LXpcg==
X-CSE-MsgGUID: 6nbmXDibROWrmWQ+fDjV5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="49508152"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 29 Apr 2024 19:55:06 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1de4-0007eC-0x;
	Tue, 30 Apr 2024 02:55:04 +0000
Date: Tue, 30 Apr 2024 10:54:58 +0800
From: kernel test robot <lkp@intel.com>
To: Robert Richter <rrichter@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Robert Richter <rrichter@amd.com>,
	Derick Marks <derick.w.marks@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v5 1/7] x86/numa: Fix SRAT lookup of CFMWS ranges with
 numa_fill_memblks()
Message-ID: <202404301038.2YNsO1Qn-lkp@intel.com>
References: <20240429124955.2294014-2-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429124955.2294014-2-rrichter@amd.com>

Hi Robert,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 62dba604a4883169abf959b7d09449900e7d4537]

url:    https://github.com/intel-lab-lkp/linux/commits/Robert-Richter/x86-numa-Fix-SRAT-lookup-of-CFMWS-ranges-with-numa_fill_memblks/20240429-205337
base:   62dba604a4883169abf959b7d09449900e7d4537
patch link:    https://lore.kernel.org/r/20240429124955.2294014-2-rrichter%40amd.com
patch subject: [PATCH v5 1/7] x86/numa: Fix SRAT lookup of CFMWS ranges with numa_fill_memblks()
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240430/202404301038.2YNsO1Qn-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240430/202404301038.2YNsO1Qn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404301038.2YNsO1Qn-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/numa/srat.c:211:19: warning: no previous prototype for 'numa_fill_memblks' [-Wmissing-prototypes]
     211 | __weak int __init numa_fill_memblks(u64 start, u64 end)
         |                   ^~~~~~~~~~~~~~~~~


vim +/numa_fill_memblks +211 drivers/acpi/numa/srat.c

   210	
 > 211	__weak int __init numa_fill_memblks(u64 start, u64 end)
   212	{
   213		return NUMA_NO_MEMBLK;
   214	}
   215	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

