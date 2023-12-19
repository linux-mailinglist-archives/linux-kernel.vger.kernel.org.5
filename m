Return-Path: <linux-kernel+bounces-4792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 043A481821F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87A6286576
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A27D8BE6;
	Tue, 19 Dec 2023 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ndSacNlr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886E811C9F;
	Tue, 19 Dec 2023 07:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702970252; x=1734506252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FVUCMuly39zh45kSUkdxdd10YAp2v8XjUsT+A/CBjTk=;
  b=ndSacNlrU40KKr5cM59IaoL4m+qGBNuFYldKnykPiTE4k5rCToBRsgR5
   pOssNzmjgL2fAKo6bMYnehinq4ebFG73lIQg5FUW4nsu5GHc3ta0D+Xzp
   su4myFmXFGSlq5j7umyMXyDitFGrNYFZql78Pl/ZVMzvkTdL5FViyhqsH
   zWbih23ElyPCORSl3CP2q3PYzAqqYFUZKvYW16xvimw2YB0LeY2SzMD8z
   LzihHryJ2qcZno2YxZxyPzCWHBlMH0lW0fXkhIlbvTUL+G970QkgEpj+C
   y0ameVQkIj1oCdPi/hNmBiP5PvoGO5DR2Xo7E4kKDoV6CIbQiUNrvfP+l
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="426751088"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="426751088"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 23:17:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="894170301"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="894170301"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 18 Dec 2023 23:17:29 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFUM3-0004xd-0w;
	Tue, 19 Dec 2023 07:17:27 +0000
Date: Tue, 19 Dec 2023 15:16:29 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net,
	lukasz.luba@arm.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	rui.zhang@intel.com, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/2] thermal/debugfs: Add thermal cooling device
 debugfs information
Message-ID: <202312191425.5o49Dzmt-lkp@intel.com>
References: <20231218171942.3048095-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218171942.3048095-1-daniel.lezcano@linaro.org>

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on linus/master v6.7-rc6 next-20231218]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/thermal-debugfs-Add-thermal-debugfs-information-for-mitigation-episodes/20231219-012118
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20231218171942.3048095-1-daniel.lezcano%40linaro.org
patch subject: [PATCH v2 1/2] thermal/debugfs: Add thermal cooling device debugfs information
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231219/202312191425.5o49Dzmt-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231219/202312191425.5o49Dzmt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312191425.5o49Dzmt-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/thermal_debugfs.c:73: warning: cannot understand function prototype: 'struct cdev_value '
>> drivers/thermal/thermal_debugfs.c:91: warning: cannot understand function prototype: 'struct thermal_debugfs '
>> drivers/thermal/thermal_debugfs.c:370: warning: bad line: 


vim +73 drivers/thermal/thermal_debugfs.c

    60	
    61	/**
    62	 * cdev_value - Common structure for cooling device entry
    63	 *
    64	 * The following common structure allows to store the information
    65	 * related to the transitions and to the state residencies. They are
    66	 * identified with a id which is associated to a value. It is used as
    67	 * nodes for the "transitions" and "durations" above.
    68	 *
    69	 * @node: node to insert the structure in a list
    70	 * @id: identifier of the value which can be a state or a transition
    71	 * @value: the id associated value which can be a duration or an occurrence
    72	 */
  > 73	struct cdev_value {
    74		struct list_head node;
    75		int id;
    76		u64 value;
    77	};
    78	
    79	/**
    80	 * thermal_debugfs - High level structure for a thermal object in
    81	 * debugfs
    82	 *
    83	 * The thermal_debugfs structure is the common structure used by the
    84	 * cooling device to compute the statistics.
    85	 *
    86	 * @d_top: top directory of the thermal object directory
    87	 * @lock: per object lock to protect the internals
    88	 *
    89	 * @cdev: a cooling device debug structure
    90	 */
  > 91	struct thermal_debugfs {
    92		struct dentry *d_top;
    93		struct mutex lock;
    94		union {
    95			struct cdev_debugfs cdev;
    96		};
    97	};
    98	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

