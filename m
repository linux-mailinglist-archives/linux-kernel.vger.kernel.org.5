Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA30D7899C0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 00:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjHZWsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 18:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjHZWrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 18:47:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B6A18C
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 15:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693090067; x=1724626067;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kDRlpeY0vEITNN+Wdwk2GZcPgOoVK5u0o6s78q+jodA=;
  b=CJFeUqFBhp3W5xiCht5p9gHuJ33ssK9MUS4UKSaQvXHiEhwfZ+dONJep
   4ifXb6/0s8PctR7Xc3la3DJzaDqjTKO2QY/i9wrVedqU02kRQKYh/1h/v
   /SJmhPaE892eNnjxs0XbYi+4VgisPflDqKuKRp9a3PgZt9SfaI3f7Wq0s
   GSpPRWcQ8G25TW7LNC7Iclk7hEGi/rShtTe9gYmgBly/HGuv0zH+8sne5
   d0Vurm6ib+jMzsdFLcPXIHnefVGi2M0YFYXkLr/lUDBHWdRUvOjudvyys
   JE9zoC3N+nqRqofD5MGE8okhTtzueKc2dpSQHv0J5zU9B7wr+Kns0Jbyp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="373782338"
X-IronPort-AV: E=Sophos;i="6.02,204,1688454000"; 
   d="scan'208";a="373782338"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2023 15:47:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="984478530"
X-IronPort-AV: E=Sophos;i="6.02,204,1688454000"; 
   d="scan'208";a="984478530"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 26 Aug 2023 15:47:45 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qa22a-000595-2Z;
        Sat, 26 Aug 2023 22:46:36 +0000
Date:   Sun, 27 Aug 2023 06:45:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: warning: unsafe memset() usage lacked '__write_overflow' symbol in
 lib/test_fortify/write_overflow-memset.c
Message-ID: <202308270621.uCWbWfPY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   28f20a19294da7df158dfca259d0e2b5866baaf9
commit: 78a498c3a227f2ac773a8234b2ce092a4403f2c3 x86: fortify: kmsan: fix KMSAN fortify builds
date:   10 months ago
config: x86_64-buildonly-randconfig-002-20230827 (https://download.01.org/0day-ci/archive/20230827/202308270621.uCWbWfPY-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230827/202308270621.uCWbWfPY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308270621.uCWbWfPY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: unsafe memset() usage lacked '__write_overflow' symbol in lib/test_fortify/write_overflow-memset.c
--
>> warning: unsafe memset() usage lacked '__write_overflow_field' symbol in lib/test_fortify/write_overflow_field-memset.c

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
