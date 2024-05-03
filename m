Return-Path: <linux-kernel+bounces-167101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED23A8BA48C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F013B23F65
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B74757C9A;
	Fri,  3 May 2024 00:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V5OKzgS6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D726A360
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 00:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714696150; cv=none; b=CIbvLH60+4PEWMURq5ZvWV10xoJ5Q4StemPQ2sczCzWAmbsgfXVF0xogBdnS2Z/jFTxcFCyO9kVMGAEjyWCSkK7vkr9RnxsKMA8rh/d9FJ7bvQoCuIf80PK9PmLSrovJtXUpE3xV/oRS9QJtC7OVCDr6FgG7CM0CIKunl3zs6VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714696150; c=relaxed/simple;
	bh=opB4+xmpKchilhQkW1zQkI4ZIclXqwiPDZeEdySA2tg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m/WxIUx1AE7eINpYy+3ngTqQf7CjfVZHyPw2a4uYzJrbjaMDUQm+q0OdIRbwrsKyEX3g36u99adLDbhX9E/svb4pJBSZm57jpSvoHgmrWWyDZfC8KpW7C3QHtKqMDRA6CwPWpxh9a4URLCSfLO/rOogY6B8M1gmevok0ycP7/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V5OKzgS6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714696149; x=1746232149;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=opB4+xmpKchilhQkW1zQkI4ZIclXqwiPDZeEdySA2tg=;
  b=V5OKzgS6p3IesGo5A2f+/yA7N/SgCv4i9FUAen64A9s47KRan3ggdXf0
   ikpxeY7wocDFkJmU9PezwMidYBWirVMXSmp/xfpNDzjU94/9NVPdg/e6/
   q2uzcX7UCutDt8pRUctXyNa9K0FJk6FvjKl8XeylAPUIUff4/4aDaqqIq
   jpVGW5hV4i+5RnrWavi3aRvVjYcFPUdtbvkVz7aRragPTcALjO+9KME/h
   oUp/BZaLuGG93+dUHz8bi47Aalasq7RN/fnsq6fkIKUyEmSgjo7w1i/V7
   SgR5St+bdRbTtbke72MD6m0OIkU7dFH9ozrNzHgYFvEA07jTlkOMaNrcO
   w==;
X-CSE-ConnectionGUID: bhwwd4skTZmoDKUHXZe6wQ==
X-CSE-MsgGUID: vVm/h6XwThCzzxHGv/2S/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10716084"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10716084"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 17:29:08 -0700
X-CSE-ConnectionGUID: otrXqZxqS8qp5DzLzV/qaA==
X-CSE-MsgGUID: 8zXjyTkPRme4RXRrEUKY6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27171392"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 02 May 2024 17:29:06 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2gnQ-000BAM-1A;
	Fri, 03 May 2024 00:29:04 +0000
Date: Fri, 3 May 2024 08:28:06 +0800
From: kernel test robot <lkp@intel.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: [tip:perf/core 12/12] arch/x86/events/rapl.c:154:69: warning: return
 discards 'const' qualifier from pointer target type
Message-ID: <202405030821.FtWhxfmP-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
head:   5d4d0283c0546559600dee7e9a4d87e402f3f4d9
commit: 5d4d0283c0546559600dee7e9a4d87e402f3f4d9 [12/12] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
config: x86_64-buildonly-randconfig-001-20240503 (https://download.01.org/0day-ci/archive/20240503/202405030821.FtWhxfmP-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240503/202405030821.FtWhxfmP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405030821.FtWhxfmP-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/events/rapl.c: In function 'get_rapl_pmu_cpumask':
>> arch/x86/events/rapl.c:154:69: warning: return discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     154 |         return rapl_pmu_is_pkg_scope() ? topology_core_cpumask(cpu) :


vim +/const +154 arch/x86/events/rapl.c

   151	
   152	static inline cpumask_t *get_rapl_pmu_cpumask(int cpu)
   153	{
 > 154		return rapl_pmu_is_pkg_scope() ? topology_core_cpumask(cpu) :
   155						 topology_die_cpumask(cpu);
   156	}
   157	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

