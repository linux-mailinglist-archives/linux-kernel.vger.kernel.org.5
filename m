Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFE677D84E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 04:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241243AbjHPCQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 22:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241308AbjHPCQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 22:16:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71612689
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 19:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692152197; x=1723688197;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YOnjRkSImAk3sLb2sJP+ZgKltOBE8aehRMj+DCgzQDE=;
  b=GWSD9jt38ApDgV3xM+GjuFMllyqN6YnSlR2pSp+FlgWWeuP1j+7T9gke
   v9oPxmUzQEDTTI1vprh+vGXkVyHtRMCdZKzl8ODoahOLuc0DndZjumj6z
   On+ONOEmRb3zhgNnvn6//5tTGkjjyqVS1FLwOg5j3n/EZkHY/y8SbvxUO
   ZsoL+GFhtBowkQ134yNO1/PGL88nKjFv9XhYFJEn6x03xezdp4VsUi3zr
   Ei85lU0Fsn35X9KIdVgBdPJmB9ws8kcIpaS1oG/0NpBnmxc8+zyT/DW6Y
   EyQG7YQ1ULGXsj8rE4JxFCiTSPbXJKRltL1gE6uKiSXMd8MJ+2MYboLeJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="458774369"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="458774369"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 19:16:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="877584448"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2023 19:16:39 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qW65L-0001Pb-0Y;
        Wed, 16 Aug 2023 02:16:35 +0000
Date:   Wed, 16 Aug 2023 10:15:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.08.14a 48/51] kernel/rcu/tree_stall.h:11:10:
 fatal error: 'linux/rcu_notifier.h' file not found
Message-ID: <202308161021.xxxuCjro-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.08.14a
head:   a90c4cbc91475bd5df35f712a954972fbfff40a1
commit: 815c9a53ab6b20e0dc90e733336151310a05cba2 [48/51] rcu: Add RCU CPU stall notifier
config: x86_64-randconfig-x004-20230816 (https://download.01.org/0day-ci/archive/20230816/202308161021.xxxuCjro-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230816/202308161021.xxxuCjro-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308161021.xxxuCjro-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/rcu/tree.c:5066:
>> kernel/rcu/tree_stall.h:11:10: fatal error: 'linux/rcu_notifier.h' file not found
   #include <linux/rcu_notifier.h>
            ^~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +11 kernel/rcu/tree_stall.h

  > 11	#include <linux/rcu_notifier.h>
    12	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
