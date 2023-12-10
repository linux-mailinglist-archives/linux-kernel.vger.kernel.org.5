Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45C980BAA2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 13:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjLJMUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 07:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJMUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 07:20:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78DAFF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 04:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702210806; x=1733746806;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E2Cz8W3+wq+iLQx7epUCLvSaKQ8HHOGIRGq5VV4rhuU=;
  b=UnAk/79OPVfsacBdSJtS7m5XUbkCNUp0h7dtDJ+Ld2l2YEX6qzXBWhle
   z728QIr10HJAWfSvy3M5EBiBw0JlJzhRLq9xhVPu1WryHF2MVED2GHrvs
   TJkmfKAam66826JwVer1vM+v1ryOuuUtcZ7/SapkJiOC/SsJaUalSWr1f
   ULAAUyKh/i89FddHFBt9PajX7mphjtsIm1NDWQoDtTztv1v+aX58HwOfY
   cuamnjuZKUXAQLiHcLB+pHGqTpwxWdX/Ls2BGdjRCpVRFRS/VhW4+rEMU
   KlXQnovW30E3//8n7ubJV36M81hJg5lNnJFLMaHA4Jn453gzErjH4BbqR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="374058123"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="374058123"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 04:20:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="801654373"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="801654373"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 10 Dec 2023 04:20:05 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCImw-000GoW-2q;
        Sun, 10 Dec 2023 12:20:02 +0000
Date:   Sun, 10 Dec 2023 20:19:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>
Subject: powerpc-linux-ld: warning: orphan section `.init.plt' from
 `drivers/hid/hid-uclogic-params.o' being placed in section `.init.plt'
Message-ID: <202312102059.jy7TxyjJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c527f5606aa545233a4d2c6d5c636ed82b8633ef
commit: a64cbf3ce63122168e1edb3eb1eb1cf7781ae230 HID: uclogic: Refactor UGEE v2 string descriptor parsing
date:   1 year, 4 months ago
config: powerpc-randconfig-r052-20231210 (https://download.01.org/0day-ci/archive/20231210/202312102059.jy7TxyjJ-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231210/202312102059.jy7TxyjJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312102059.jy7TxyjJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   powerpc-linux-ld: warning: orphan section `.init.plt' from `drivers/hid/hid-uclogic-rdesc.o' being placed in section `.init.plt'
>> powerpc-linux-ld: warning: orphan section `.init.plt' from `drivers/hid/hid-uclogic-params.o' being placed in section `.init.plt'
   powerpc-linux-ld: warning: drivers/of/unittest-data/overlay_gpio_04b.dtb.o: missing .note.GNU-stack section implies executable stack
   powerpc-linux-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
   powerpc-linux-ld: block/blk-iocost.o: in function `ioc_refresh_params.isra.0':
   blk-iocost.c:(.text+0x1b5c): undefined reference to `__udivdi3'
   powerpc-linux-ld: block/blk-iocost.o: in function `transfer_surpluses':
   blk-iocost.c:(.text+0x3cd4): undefined reference to `__udivdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
