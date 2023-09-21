Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010347A906C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 03:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjIUBTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 21:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjIUBTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 21:19:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49100A1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 18:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695259148; x=1726795148;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UX8dHJKy0P7nUs3MVyqaK2U4OV4HlWmCZdC3XxW4fNM=;
  b=EM0+4mqOKus4uU4+Zx5HKeVXonPuuc+7lNiF+OrQfsI7AUtBvJtoeCdD
   /0AD/tzwvSWwx40i0uwpvS0ibvZGmqPc/NINElNk0ronVJ12CTlRjZDDi
   b/8hwtY4XjT01XW77hjy0ExYLKXm3hTQjRVkP7OU2QrzjSrSZI6Rz4sGg
   rpDoli4IUvqBI8v8BW//6DsvQQXtPR5213knqv2BjzpuSqXjIlosnasfQ
   75zskj4MmhNaUK3SfbzFQyYTeRtH5/Remi+hLTMXzahVN6/OYlQFZ/0Of
   okpoWdZxNrHBFnZD1iylZV5laHm8qZ03QhjEFIFJZMcg2J96v3xkr/pu0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="383129903"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="383129903"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 18:18:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="750171847"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="750171847"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 20 Sep 2023 18:18:47 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qj8L7-0009Mm-0Q;
        Thu, 21 Sep 2023 01:18:45 +0000
Date:   Thu, 21 Sep 2023 09:18:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: {standard input}:14: Error: symbol `__export_symbol_alpha_mv' is
 already defined
Message-ID: <202309210930.XnJajyc6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   42dc814987c1feb6410904e58cfd4c36c4146150
commit: 481461f5109919babbb393d6f68002936b8e2493 linux/export.h: make <linux/export.h> independent of CONFIG_MODULES
date:   8 weeks ago
config: alpha-randconfig-r024-20230129 (https://download.01.org/0day-ci/archive/20230921/202309210930.XnJajyc6-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230921/202309210930.XnJajyc6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309210930.XnJajyc6-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/alpha/kernel/sys_sio.c:312:1: warning: no previous prototype for 'sio_kill_arch' [-Wmissing-prototypes]
     312 | sio_kill_arch(int mode)
         | ^~~~~~~~~~~~~
   {standard input}: Assembler messages:
>> {standard input}:14: Error: symbol `__export_symbol_alpha_mv' is already defined

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
