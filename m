Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067CC79DF4A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 06:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbjIME5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 00:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjIME5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 00:57:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCB11738
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 21:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694581023; x=1726117023;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0SzukiZqeuhVgL4Y6GY9n5ArZRoYw3DfNp92MdmbiYA=;
  b=WsrBj08djatxTh25eoCef/xmXIa91cK+XGhbEWSfgaF8/CyWe1BNrr+7
   2OWtUB83loHaxEZbRWn296NQ4D8RMDVeRi8oB4uxSkf7LF3l1woEoYNrg
   4N2/6PuFhBpEV+cuueWHne1BFrhoJp8W07O7kP4vW5cERCsXp8YPa4dx2
   /dY4Y42pK+81hnZnZ8c8kUTyzODaG6DcgusZkgD7uW9K+UYKp1nP8wCTc
   T7kBmXjsDGh0vdA6tpfxN/iX4UnmRJDMbCs8E789EfaeRrL9hJGIiYnVy
   vgvFRwZKplSrwm5PCOSHWQDPhe9akGrUe7slgmfclIKzmv4vEGoiiIsqD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="358838548"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="358838548"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 21:57:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="834170989"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="834170989"
Received: from lkp-server02.sh.intel.com (HELO cf13c67269a2) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Sep 2023 21:57:01 -0700
Received: from kbuild by cf13c67269a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgHvv-00002f-09;
        Wed, 13 Sep 2023 04:56:59 +0000
Date:   Wed, 13 Sep 2023 12:56:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/platforms/pseries/rtas-work-area.c:189: warning:
 Function parameter or member 'limit' not described in
 'rtas_work_area_reserve_arena'
Message-ID: <202309131221.Bm1pg96n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3669558bdf354cd352be955ef2764cde6a9bf5ec
commit: 43033bc62d349d8d852855a336c91d046de819bd powerpc/pseries: add RTAS work area allocator
date:   7 months ago
config: powerpc-ppc64_defconfig (https://download.01.org/0day-ci/archive/20230913/202309131221.Bm1pg96n-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309131221.Bm1pg96n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309131221.Bm1pg96n-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/powerpc/platforms/pseries/rtas-work-area.c:189: warning: Function parameter or member 'limit' not described in 'rtas_work_area_reserve_arena'


vim +189 arch/powerpc/platforms/pseries/rtas-work-area.c

   184	
   185	/**
   186	 * rtas_work_area_reserve_arena() - Reserve memory suitable for RTAS work areas.
   187	 */
   188	void __init rtas_work_area_reserve_arena(const phys_addr_t limit)
 > 189	{

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
