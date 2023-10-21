Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED127D2043
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 00:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjJUW3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 18:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJUW3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 18:29:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCE6106
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 15:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697927368; x=1729463368;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=usAeQk5fHXw7mos+VP941V8p/TlDfRRhdbF7LLpOjww=;
  b=Wap5pjbO+XyUgqI9Bdrq5edj0QZiP0HZx8S+2xKU5JDdTQpzQl7BP5t+
   /p5RRenhw2JmwQaZBi63KXU4doRH/o1FmIfZN835aNbS1GPh4F2SfNs3k
   pQ24k9hNfNWb8hhJDxSob7/UcAMXBF7rBhwdQPl6DTmwEXl76dZLKowtr
   nVBxQov5zkNlcmFDtiTF2/bRSoHypR0slpmGiuq/KNDgl2NKhCxRowIpU
   8YVl57ZZg+Msi1BI5sGj341iap6ui7VWUti7v9sjANHvwDMBsaoUhkFYt
   oQC2AWS70BzOp1ch1+NOvyqMkSKrdde6CnO+jRCXSCPhPWfTCawH8aOWC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="386484517"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="386484517"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2023 15:29:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="734295896"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="734295896"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2023 15:29:26 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1quKTE-0005Hu-0k;
        Sat, 21 Oct 2023 22:29:24 +0000
Date:   Sun, 22 Oct 2023 06:29:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/mellanox/mlx5/core/en/qos.c:364:40: sparse:
 sparse: incorrect type in initializer (different address spaces)
Message-ID: <202310220647.PkybxdJH-lkp@intel.com>
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
head:   45d3291c5201fced351e62d714e2912400cc7f4d
commit: d636fc5dd692c8f4e00ae6e0359c0eceeb5d9bdb net: sched: add rcu annotations around qdisc->qdisc_sleeping
date:   5 months ago
config: i386-randconfig-063-20231022 (https://download.01.org/0day-ci/archive/20231022/202310220647.PkybxdJH-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231022/202310220647.PkybxdJH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310220647.PkybxdJH-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/mellanox/mlx5/core/en/qos.c:364:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct Qdisc *qdisc @@     got struct Qdisc [noderef] __rcu *qdisc_sleeping @@
   drivers/net/ethernet/mellanox/mlx5/core/en/qos.c:364:40: sparse:     expected struct Qdisc *qdisc
   drivers/net/ethernet/mellanox/mlx5/core/en/qos.c:364:40: sparse:     got struct Qdisc [noderef] __rcu *qdisc_sleeping

vim +364 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c

214baf22870cfa Maxim Mikityanskiy 2021-01-19  360  
462b0059993696 Moshe Tal          2022-05-02  361  void mlx5e_reset_qdisc(struct net_device *dev, u16 qid)
214baf22870cfa Maxim Mikityanskiy 2021-01-19  362  {
214baf22870cfa Maxim Mikityanskiy 2021-01-19  363  	struct netdev_queue *dev_queue = netdev_get_tx_queue(dev, qid);
214baf22870cfa Maxim Mikityanskiy 2021-01-19 @364  	struct Qdisc *qdisc = dev_queue->qdisc_sleeping;
214baf22870cfa Maxim Mikityanskiy 2021-01-19  365  
214baf22870cfa Maxim Mikityanskiy 2021-01-19  366  	if (!qdisc)
214baf22870cfa Maxim Mikityanskiy 2021-01-19  367  		return;
214baf22870cfa Maxim Mikityanskiy 2021-01-19  368  
214baf22870cfa Maxim Mikityanskiy 2021-01-19  369  	spin_lock_bh(qdisc_lock(qdisc));
214baf22870cfa Maxim Mikityanskiy 2021-01-19  370  	qdisc_reset(qdisc);
214baf22870cfa Maxim Mikityanskiy 2021-01-19  371  	spin_unlock_bh(qdisc_lock(qdisc));
214baf22870cfa Maxim Mikityanskiy 2021-01-19  372  }
214baf22870cfa Maxim Mikityanskiy 2021-01-19  373  

:::::: The code at line 364 was first introduced by commit
:::::: 214baf22870cfa437522f3bd4fbae56338674b04 net/mlx5e: Support HTB offload

:::::: TO: Maxim Mikityanskiy <maximmi@mellanox.com>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
