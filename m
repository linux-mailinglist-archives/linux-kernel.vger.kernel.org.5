Return-Path: <linux-kernel+bounces-163305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7896A8B6907
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CB10B22D5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D324112E5D;
	Tue, 30 Apr 2024 03:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X1AGQKgv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A2310A36;
	Tue, 30 Apr 2024 03:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448294; cv=none; b=QWBrWNsZ20H0bR0GE1NE7+nvbUx6+D4usbSoou849PUI1ZKVrCncluQusHPSASj/9EOWmFkYHe6c4jWMOCVDSzIQSmOP1BNkVfGy/E3Awyy5hXwTDrmK5TPaVusxVNwvyx2jqEDhKqxurIWkoHXp1cRXOHPcsulM40IEfCj5gs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448294; c=relaxed/simple;
	bh=3z2FPLYGn85NQ7VMbiwYtkfo57s0YIE77TixRvhDD0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5duM7N5tUIrkpe44je3Eur+gxlnsdKHLYFRi/af09Ng/tqFlllde6IpEI9PTHyixd9sWaUs+cJB2jUAjOU98Oq2L/4CcikVd/vPZJ232y0uB/clc9SBAd554aQ8237Wpdda13odrjNFVo9aP2o4jP3yw3gOFwbqjsSa+elek60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X1AGQKgv; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714448293; x=1745984293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3z2FPLYGn85NQ7VMbiwYtkfo57s0YIE77TixRvhDD0E=;
  b=X1AGQKgv+IUWgv6x921uMRvycW9nRFuV4YjENSLwE7LLCMHHGWwP3cgo
   0TepT+E9NI9aG2cmFOGZTyjxsJY7ycuH16lQdqu0INMCzlyuEVcWxwiCH
   xFNlgiE0LKJmjwdKFKdomfOi4D0SxtyCHj3MsGsR20TAMJJOYzqyBsSJm
   OXu62E57wP0MVQX0AnSu+LvopHwhCL8ig6w+ZUC6/t8YXDiOzhoM7Qmj5
   37/mUDHTk1yWWCTSNxk567Xv/wOvYnuWzScIx4nfW+NOS3yYOnXQYbNo6
   fcGS17qUwjE45+J5KFFVwbPdrq+bKopIbC1BBdn5ph3TDZFhMEaWGflGR
   A==;
X-CSE-ConnectionGUID: dodPzThFTSSZiiDx5sqkgA==
X-CSE-MsgGUID: Yhq1bUKxQa6lgmJEI0edog==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="9965343"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="9965343"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 20:38:12 -0700
X-CSE-ConnectionGUID: 0VnLH+HlSqCbjuZkPbagRQ==
X-CSE-MsgGUID: 6RE/8Zy2QRGaZnn2fJoiow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26249181"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 29 Apr 2024 20:38:08 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1eJh-0007gm-2d;
	Tue, 30 Apr 2024 03:38:05 +0000
Date: Tue, 30 Apr 2024 11:37:33 +0800
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
Message-ID: <202404301142.aJtZ8Xh9-lkp@intel.com>
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
config: arm64-randconfig-r121-20240430 (https://download.01.org/0day-ci/archive/20240430/202404301142.aJtZ8Xh9-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 37ae4ad0eef338776c7e2cffb3896153d43dcd90)
reproduce: (https://download.01.org/0day-ci/archive/20240430/202404301142.aJtZ8Xh9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404301142.aJtZ8Xh9-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/acpi/numa/srat.c:15:
   In file included from include/linux/acpi.h:39:
   In file included from include/acpi/acpi_io.h:7:
   In file included from arch/arm64/include/asm/acpi.h:14:
   In file included from include/linux/memblock.h:12:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     509 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     516 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     528 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/acpi/numa/srat.c:211:19: warning: no previous prototype for function 'numa_fill_memblks' [-Wmissing-prototypes]
     211 | __weak int __init numa_fill_memblks(u64 start, u64 end)
         |                   ^
   drivers/acpi/numa/srat.c:211:8: note: declare 'static' if the function is not intended to be used outside of this translation unit
     211 | __weak int __init numa_fill_memblks(u64 start, u64 end)
         |        ^
         |        static 
   6 warnings generated.


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

