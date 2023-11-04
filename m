Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B887E0D7E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 04:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjKDD3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 23:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjKDD3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 23:29:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5BDD50
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 20:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699068578; x=1730604578;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Aoo6+FhiWZExDmyK02vSNA27yH4NQsW44C95Ktkkwes=;
  b=ePScnpmGV4f3GV/efJmk/bjb6mr65xJpXGPAIGBlkZMly1wIqlwXCVaQ
   yxgCzsyCg0o9G1GNKdixBkSKOdQvVxX/zXKdFb3H3s9OUfYxFMeXM6u8Z
   klTTU2NpJmbyv85r/TQscYsUtCO0mnIerlpVpMaZzFtLxzAlBFRSjZxza
   6QZbMstsyqMxWLAip86uBdlcYA8vH3pZoH+fQGwgXz4Yl6PQjMG3mvK4R
   WItWnzqezj0ej6gRKfPBChNXlvcz73wd+xHTAZD5zPpRKUXyn89mQ60f7
   u8n5yqw9aGkRCeEbGCfBhAYBKjKWrug9Z+Jzi81egX0g3p0iOXQfyrFNf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="1939514"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="1939514"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 20:29:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="832205377"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="832205377"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 Nov 2023 20:29:37 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qz7Lq-0003Lg-2s;
        Sat, 04 Nov 2023 03:29:34 +0000
Date:   Sat, 4 Nov 2023 11:28:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/platforms/pseries/rtas-work-area.c:189: warning:
 Function parameter or member 'limit' not described in
 'rtas_work_area_reserve_arena'
Message-ID: <202311041118.evjjdof8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2c40c1c6adab90ee4660caf03722b3a3ec67767b
commit: 43033bc62d349d8d852855a336c91d046de819bd powerpc/pseries: add RTAS work area allocator
date:   9 months ago
config: powerpc64-randconfig-003-20231101 (https://download.01.org/0day-ci/archive/20231104/202311041118.evjjdof8-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311041118.evjjdof8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311041118.evjjdof8-lkp@intel.com/

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
