Return-Path: <linux-kernel+bounces-11954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDDB81EE1F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0BD1C217DF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2FE2C878;
	Wed, 27 Dec 2023 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JzJJSLMj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2ED2C868
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703672437; x=1735208437;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2bhcE0W6Qhtu0M2ApBsS1wup7lhibVlBvGSChtIuaQg=;
  b=JzJJSLMjHBazchnGVj70MvRju+wMTBnd9MKMxHzdN4esclBuaxN2hYcS
   PcHe8gM/69fwBNGbE63WPGOgfRygLRr5bM1RD2RkddJP57mqIz0nj2h0y
   N5m6K4TFiYkhkBFJMRVcdOVUx0io2bLmB/gheRRcXNtg2JhlphPI1gfLd
   G7CD+rMZ5LiXX4br59H0nKdj//H5Y2JYHydwAPZ4I6QiVQRvrB9XKlRtE
   uBphIcJM+U5+zwZlLBcVZqTRPPm7pwaIMaNZY39QXn4cgxfyPmGF0OZ61
   NyTSbaIDU91zBFuLiUEhHvG/tRXUli878GwQJ4JKuDcspEg+EDkCpBlNV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="9982403"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="9982403"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 02:20:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="868829087"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="868829087"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Dec 2023 02:20:35 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rIR1d-000FIz-0G;
	Wed, 27 Dec 2023 10:20:33 +0000
Date: Wed, 27 Dec 2023 18:19:51 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: drivers/powercap/dtpm.c:602: warning: Function parameter or member
 'dtpm_match_table' not described in 'dtpm_create_hierarchy'
Message-ID: <202312271839.qpdWcLne-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Daniel,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fbafc3e621c3f4ded43720fdb1d6ce1728ec664e
commit: 3759ec678e8944dc2ea70cab77a300408f78ae27 powercap/drivers/dtpm: Add hierarchy creation
date:   1 year, 11 months ago
config: x86_64-randconfig-015-20231009 (https://download.01.org/0day-ci/archive/20231227/202312271839.qpdWcLne-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231227/202312271839.qpdWcLne-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312271839.qpdWcLne-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/powercap/dtpm.c:602: warning: Function parameter or member 'dtpm_match_table' not described in 'dtpm_create_hierarchy'
>> drivers/powercap/dtpm.c:602: warning: Excess function parameter 'hierarchy' description in 'dtpm_create_hierarchy'


vim +602 drivers/powercap/dtpm.c

   574	
   575	/**
   576	 * dtpm_create_hierarchy - Create the dtpm hierarchy
   577	 * @hierarchy: An array of struct dtpm_node describing the hierarchy
   578	 *
   579	 * The function is called by the platform specific code with the
   580	 * description of the different node in the hierarchy. It creates the
   581	 * tree in the sysfs filesystem under the powercap dtpm entry.
   582	 *
   583	 * The expected tree has the format:
   584	 *
   585	 * struct dtpm_node hierarchy[] = {
   586	 *	[0] { .name = "topmost", type =  DTPM_NODE_VIRTUAL },
   587	 *	[1] { .name = "package", .type = DTPM_NODE_VIRTUAL, .parent = &hierarchy[0] },
   588	 *	[2] { .name = "/cpus/cpu0", .type = DTPM_NODE_DT, .parent = &hierarchy[1] },
   589	 *	[3] { .name = "/cpus/cpu1", .type = DTPM_NODE_DT, .parent = &hierarchy[1] },
   590	 *	[4] { .name = "/cpus/cpu2", .type = DTPM_NODE_DT, .parent = &hierarchy[1] },
   591	 *	[5] { .name = "/cpus/cpu3", .type = DTPM_NODE_DT, .parent = &hierarchy[1] },
   592	 *	[6] { }
   593	 * };
   594	 *
   595	 * The last element is always an empty one and marks the end of the
   596	 * array.
   597	 *
   598	 * Return: zero on success, a negative value in case of error. Errors
   599	 * are reported back from the underlying functions.
   600	 */
   601	int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
 > 602	{

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

