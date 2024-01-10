Return-Path: <linux-kernel+bounces-22520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8D9829EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD7BCB22593
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A6E4CE18;
	Wed, 10 Jan 2024 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pd59UjXX"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03394B5BB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704907273; x=1736443273;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=S5q6qQ/mVRtd8Lp2GoraYID8cvUn0ZdcxB0bf44ien8=;
  b=Pd59UjXXgFqHw6LiSE1zAm6lzvZd3QisuK7bA/gW4az7/u4e9m7VkTJo
   3Fd4ZSyBKoBWHILwX3PwJi6oTnWiF/cm5BVkVjwUQxgS/HDYVqg0hu0Tb
   P1GbWiDnd9pxtBEO77AVLnjXdN58kHazoklLsHZKc/VxiramPJcrnzEAa
   9rXLe71Q/VWFENvMCxj16XI9r6MRObNEBLpLvwzQxbze1ndtzLSDj9Yd8
   BZ29VwSSlA4D9d+9J3fBiVCtJgQYJIzao/OOmSX0WWXFrXuR8e85jBzv6
   r05uOiTH0at21Gf5LJ0yXkCnL4Puty2TQBpBGqw8DnFaK6TYyiPciSiXM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="397445481"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="397445481"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 09:21:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="24024173"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 10 Jan 2024 09:21:11 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNcGK-0007K4-2U;
	Wed, 10 Jan 2024 17:21:08 +0000
Date: Thu, 11 Jan 2024 01:20:18 +0800
From: kernel test robot <lkp@intel.com>
To: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: include/trace/stages/init.h:2:23: warning:
 'str__irq_vectors__trace_system_name' defined but not used
Message-ID: <202401110124.FXHxWlN9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Steven,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ab27740f76654ed58dd32ac0ba0031c18a6dea3b
commit: af6b9668e85ffd1502aada8036ccbf4dbd481708 tracing: Move the defines to create TRACE_EVENTS into their own files
date:   1 year, 10 months ago
config: i386-buildonly-randconfig-003-20240106 (https://download.01.org/0day-ci/archive/20240111/202401110124.FXHxWlN9-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240111/202401110124.FXHxWlN9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401110124.FXHxWlN9-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/trace/trace_events.h:27,
                    from include/trace/define_trace.h:102,
                    from arch/x86/include/asm/trace/irq_vectors.h:383,
                    from arch/x86/kernel/irq.c:27:
>> include/trace/stages/init.h:2:23: warning: 'str__irq_vectors__trace_system_name' defined but not used [-Wunused-const-variable=]
       2 | #define __app__(x, y) str__##x##y
         |                       ^~~~~
   include/trace/stages/init.h:3:21: note: in expansion of macro '__app__'
       3 | #define __app(x, y) __app__(x, y)
         |                     ^~~~~~~
   include/trace/stages/init.h:5:29: note: in expansion of macro '__app'
       5 | #define TRACE_SYSTEM_STRING __app(TRACE_SYSTEM_VAR,__trace_system_name)
         |                             ^~~~~
   include/trace/stages/init.h:8:20: note: in expansion of macro 'TRACE_SYSTEM_STRING'
       8 |  static const char TRACE_SYSTEM_STRING[] = \
         |                    ^~~~~~~~~~~~~~~~~~~
   include/trace/stages/init.h:11:1: note: in expansion of macro 'TRACE_MAKE_SYSTEM_STR'
      11 | TRACE_MAKE_SYSTEM_STR();
         | ^~~~~~~~~~~~~~~~~~~~~


vim +/str__irq_vectors__trace_system_name +2 include/trace/stages/init.h

   > 2	#define __app__(x, y) str__##x##y
     3	#define __app(x, y) __app__(x, y)
     4	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

