Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431237ED7FF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 00:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343674AbjKOXMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 18:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjKOXMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 18:12:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB9B189
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 15:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700089925; x=1731625925;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QXLlRpAPKJtq077TtPE6Gqg6acuJU5mOfOr2BT75oDE=;
  b=QZMlQ/eAeOLUj2+cPDJg+33xYJky+lKOVGnDMHMCRL7le2pQ/mhmTGv7
   QqSu5NgMboLfBUFqBUSQjFFkz6ZjjtMG1T86jsBSVa9MyfmD44ahre/kY
   FAoxT2ysSQXE9N8EUMrGk8jpRRcoj8whygcAmAVidrAZiHTSEczo0BHgp
   UOLCkltPyGebOeudqlzlyprGrG+mgVRlKjN/fuovjAP7+JOHAr5a01U5g
   MpQxldArZUxRIl+WTm6sx4NnV36C0W8pmx9paZoEM+4p4VzPVbmXYI6kG
   fxDArRacj4oR6VFRnIjJmCRclqn4S3tpUewSJZ6zFNUNOU718/us1pGr0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="9615125"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="9615125"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 15:12:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="6323212"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 15 Nov 2023 15:12:03 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3P3A-0000we-11;
        Wed, 15 Nov 2023 23:12:00 +0000
Date:   Thu, 16 Nov 2023 07:11:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/splice.c:53:19: sparse: sparse: cast from restricted fmode_t
Message-ID: <202311160739.F2W0koQB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: 0f99fc513ddd28de155c58547824a9fd63daacea splice: clear FMODE_NOWAIT on file if splice/vmsplice is used
date:   7 months ago
config: sparc64-randconfig-r025-20230806 (https://download.01.org/0day-ci/archive/20231116/202311160739.F2W0koQB-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231116/202311160739.F2W0koQB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311160739.F2W0koQB-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/splice.c:53:19: sparse: sparse: cast from restricted fmode_t
>> fs/splice.c:53:19: sparse: sparse: cast from restricted fmode_t
>> fs/splice.c:53:19: sparse: sparse: cast to restricted fmode_t

vim +53 fs/splice.c

    39	
    40	/*
    41	 * Splice doesn't support FMODE_NOWAIT. Since pipes may set this flag to
    42	 * indicate they support non-blocking reads or writes, we must clear it
    43	 * here if set to avoid blocking other users of this pipe if splice is
    44	 * being done on it.
    45	 */
    46	static noinline void noinline pipe_clear_nowait(struct file *file)
    47	{
    48		fmode_t fmode = READ_ONCE(file->f_mode);
    49	
    50		do {
    51			if (!(fmode & FMODE_NOWAIT))
    52				break;
  > 53		} while (!try_cmpxchg(&file->f_mode, &fmode, fmode & ~FMODE_NOWAIT));
    54	}
    55	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
