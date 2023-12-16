Return-Path: <linux-kernel+bounces-1911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 276898155AE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC171B23755
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEB9110E;
	Sat, 16 Dec 2023 00:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DrKabudx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8692810FE
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 00:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702687480; x=1734223480;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X4sQbpPpcTm7AtZ9Kn3seYsh/lkK8EdHmphYrJTVCe4=;
  b=DrKabudxxSZrOt24Qh06EZbewwUxrHWhYYELELOK9Z2JvybcyJJfXEx5
   YzTc03NPcKD+SehHv85ZpY9lckBZj6hptnjEF2HB9lrOAmYhIA+6yUEw2
   QvR6eaQmNONXSVXpW7FJPgr9sgighzssHaoS41wYz3cOMqoe9jbz1hLAr
   q5DeFZ2AX6KoJYSxoPx5CAQxWvNKYXe+kqlHEv2BGgwoG9tdTQdlfRDsU
   a7+z+HJXmOuXIgkNqI7lC45qHqsMZnEdJjxXOdzjfPFaYc6ao2huRGM83
   uwzm+PB1r4GqU94VramJyjQBvXq6vxeKSIAJIfKq90vG/l7k5AyEmIhcG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="2520115"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="2520115"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 16:44:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="893089388"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="893089388"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 15 Dec 2023 16:44:38 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEInC-0000xW-1t;
	Sat, 16 Dec 2023 00:44:34 +0000
Date: Sat, 16 Dec 2023 08:44:14 +0800
From: kernel test robot <lkp@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	John Harrison <John.C.Harrison@intel.com>,
	Alan Previn <alan.previn.teres.alexis@intel.com>,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Subject: htmldocs: ./scripts/kernel-doc:
 ./drivers/gpu/drm/i915/gt/uc/intel_guc.h:268: warning: Excess struct member
 'guc_ids_in_use' description in 'intel_guc'
Message-ID: <202312160834.FqDRMa8g-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3bd7d748816927202268cb335921f7f68b3ca723
commit: 833210943099f5cfd9bd054ce9c5ec2e971bcc89 drm/i915/guc: Delay disabling guc_id scheduling for better hysteresis
date:   1 year, 2 months ago
reproduce: (https://download.01.org/0day-ci/archive/20231216/202312160834.FqDRMa8g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312160834.FqDRMa8g-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> ./scripts/kernel-doc: ./drivers/gpu/drm/i915/gt/uc/intel_guc.h:268: warning: Excess struct member 'guc_ids_in_use' description in 'intel_guc'
>> ./scripts/kernel-doc: ./drivers/gpu/drm/i915/gt/uc/intel_guc.h:268: warning: Excess struct member 'sched_disable_delay_ms' description in 'intel_guc'
>> ./scripts/kernel-doc: ./drivers/gpu/drm/i915/gt/uc/intel_guc.h:268: warning: Excess struct member 'sched_disable_gucid_threshold' description in 'intel_guc'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

