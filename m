Return-Path: <linux-kernel+bounces-2444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F33F815D47
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 04:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5FB2823CE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 03:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FC71874;
	Sun, 17 Dec 2023 03:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O11lIz29"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA14ED8;
	Sun, 17 Dec 2023 03:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702782560; x=1734318560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ldclQnPKIK3R6DIjY7MVhmWZyFLDghhGP8FiLsTQals=;
  b=O11lIz29c0oc6S6n5WRGfz4jvfuGvjSdFE2n2/Jo4yKHhvb69dL+VUuE
   4DN5lQPNDp+Wmeg+Uqab9w1ZBgzwqyDIQwaQX+C+udHcORcT0sMwcpkC2
   clSj320jTKxKgncSDpCRsxKD0rNEU9oAmbcPVpJUw1Mac34VVmxXRD/1w
   OvV0q1uv95CUMsMg4/iQCa5XaH+mEUSQy8jBRIS6P/LXE2LWq3W+DVqb4
   QgsmeeiIflepQ1yYAvqd8yWVxuNv8oGcjIF5UUhqhPhmjqTze/Jom58ny
   ts7RW+ErX4gz0YQoniVUE8FQT6Xq6D8awaVwjube2HPtWnHFGhhlR0fzH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="398184643"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="398184643"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 19:09:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="1022376189"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="1022376189"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 16 Dec 2023 19:09:15 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEhWj-0002YT-1I;
	Sun, 17 Dec 2023 03:09:13 +0000
Date: Sun, 17 Dec 2023 11:08:18 +0800
From: kernel test robot <lkp@intel.com>
To: Elad Nachman <enachman@marvell.com>, wim@linux-watchdog.org,
	linux@roeck-us.net, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	gregory.clement@bootlin.com, chris.packham@alliedtelesis.co.nz,
	andrew@lunn.ch, fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com,
	al.stone@linaro.org, timur@codeaurora.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, enachman@marvell.com, cyuval@marvell.com
Subject: Re: [PATCH 3/3] watchdog: sbsa_gwdt: add support for Marvell ac5
Message-ID: <202312171047.mHNijCmt-lkp@intel.com>
References: <20231214150414.1849058-4-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214150414.1849058-4-enachman@marvell.com>

Hi Elad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on groeck-staging/hwmon-next linus/master v6.7-rc5 next-20231215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Elad-Nachman/dt-bindings-watchdog-add-Marvell-AC5-watchdog/20231214-230812
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231214150414.1849058-4-enachman%40marvell.com
patch subject: [PATCH 3/3] watchdog: sbsa_gwdt: add support for Marvell ac5
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231217/202312171047.mHNijCmt-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312171047.mHNijCmt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312171047.mHNijCmt-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> scripts/kernel-doc: drivers/watchdog/sbsa_gwdt.c:141: warning: Function parameter or struct member 'reg_read32' not described in 'sbsa_gwdt_regs_ops'
>> scripts/kernel-doc: drivers/watchdog/sbsa_gwdt.c:141: warning: Function parameter or struct member 'reg_read64' not described in 'sbsa_gwdt_regs_ops'
>> scripts/kernel-doc: drivers/watchdog/sbsa_gwdt.c:141: warning: Function parameter or struct member 'reg_write32' not described in 'sbsa_gwdt_regs_ops'
>> scripts/kernel-doc: drivers/watchdog/sbsa_gwdt.c:141: warning: Function parameter or struct member 'reg_write64' not described in 'sbsa_gwdt_regs_ops'
>> scripts/kernel-doc: drivers/watchdog/sbsa_gwdt.c:141: warning: Excess struct member 'reg_read' description in 'sbsa_gwdt_regs_ops'
>> scripts/kernel-doc: drivers/watchdog/sbsa_gwdt.c:141: warning: Excess struct member 'read_write' description in 'sbsa_gwdt_regs_ops'
>> scripts/kernel-doc: drivers/watchdog/sbsa_gwdt.c:141: warning: Excess struct member 'read_write' description in 'sbsa_gwdt_regs_ops'
>> scripts/kernel-doc: drivers/watchdog/sbsa_gwdt.c:141: warning: Excess struct member 'reg_read' description in 'sbsa_gwdt_regs_ops'
>> scripts/kernel-doc: drivers/watchdog/sbsa_gwdt.c:158: warning: Function parameter or struct member 'soc_reg_ops' not described in 'sbsa_gwdt'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

