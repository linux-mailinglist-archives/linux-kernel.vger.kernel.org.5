Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17097CC8FB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbjJQQjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQQjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:39:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763BBA4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697560753; x=1729096753;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L36RMN+enFdWDzdAWt7750bmsek9LlwGNYRCeS+PSQs=;
  b=iTLaWbsbQO287z8LqeHQEkjXnxuOqIhuQvlbWvToDIEV55mbGV18gyAt
   TW5IoIJVIKifM3I0ODb34KB/GKSYbJvQaV1+p+1KUEPxE/M6iRSL5GPXY
   YhtUYALlV3bHIfuKB2P5pM1+Dmq+R72NvktbM6+TK0Pq2auNSEgIOxw06
   atOv82AsoEe0w5nD8Vu6mEARm8tOeH8+dr6TkhGtVraEetyuV6Orf3geF
   vmnN9mISqszJ2HiBSzOmGFpqOsb33ntq/yvVLMOpH1yBcZsrHgR9JXrUe
   fNv2mkC5LES92EvxBi/uBdneK4pvKqEMZdsWPJBzIbK9JL7T0DqueAyo6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="389693717"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="389693717"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 09:39:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="706068410"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="706068410"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 17 Oct 2023 09:39:10 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsn64-0009pd-1C;
        Tue, 17 Oct 2023 16:39:08 +0000
Date:   Wed, 18 Oct 2023 00:39:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chris Lew <quic_clew@quicinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Sarannya S <quic_sarannya@quicinc.com>
Subject: drivers/rpmsg/rpmsg_char.c:75: warning: Function parameter or member
 'remote_flow_restricted' not described in 'rpmsg_eptdev'
Message-ID: <202310180054.aikLn1A7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   213f891525c222e8ed145ce1ce7ae1f47921cb9c
commit: 5550201c0fe26a76c53983bd36a58d4c4395ec22 rpmsg: char: Add RPMSG GET/SET FLOWCONTROL IOCTL support
date:   3 months ago
config: x86_64-buildonly-randconfig-001-20231012 (https://download.01.org/0day-ci/archive/20231018/202310180054.aikLn1A7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310180054.aikLn1A7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310180054.aikLn1A7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/rpmsg/rpmsg_char.c:75: warning: Function parameter or member 'remote_flow_restricted' not described in 'rpmsg_eptdev'
>> drivers/rpmsg/rpmsg_char.c:75: warning: Function parameter or member 'remote_flow_updated' not described in 'rpmsg_eptdev'


vim +75 drivers/rpmsg/rpmsg_char.c

c0cdc19f84a471 Bjorn Andersson  2017-01-11  41  
c0cdc19f84a471 Bjorn Andersson  2017-01-11  42  /**
c0cdc19f84a471 Bjorn Andersson  2017-01-11  43   * struct rpmsg_eptdev - endpoint device context
c0cdc19f84a471 Bjorn Andersson  2017-01-11  44   * @dev:	endpoint device
c0cdc19f84a471 Bjorn Andersson  2017-01-11  45   * @cdev:	cdev for the endpoint device
c0cdc19f84a471 Bjorn Andersson  2017-01-11  46   * @rpdev:	underlaying rpmsg device
c0cdc19f84a471 Bjorn Andersson  2017-01-11  47   * @chinfo:	info used to open the endpoint
c0cdc19f84a471 Bjorn Andersson  2017-01-11  48   * @ept_lock:	synchronization of @ept modifications
c0cdc19f84a471 Bjorn Andersson  2017-01-11  49   * @ept:	rpmsg endpoint reference, when open
c0cdc19f84a471 Bjorn Andersson  2017-01-11  50   * @queue_lock:	synchronization of @queue operations
c0cdc19f84a471 Bjorn Andersson  2017-01-11  51   * @queue:	incoming message queue
c0cdc19f84a471 Bjorn Andersson  2017-01-11  52   * @readq:	wait object for incoming queue
bea9b79c2d10fe Arnaud Pouliquen 2022-01-24  53   * @default_ept: set to channel default endpoint if the default endpoint should be re-used
bea9b79c2d10fe Arnaud Pouliquen 2022-01-24  54   *              on device open to prevent endpoint address update.
5550201c0fe26a Chris Lew        2023-07-07  55   * remote_flow_restricted: to indicate if the remote has requested for flow to be limited
5550201c0fe26a Chris Lew        2023-07-07  56   * remote_flow_updated: to indicate if the flow control has been requested
c0cdc19f84a471 Bjorn Andersson  2017-01-11  57   */
c0cdc19f84a471 Bjorn Andersson  2017-01-11  58  struct rpmsg_eptdev {
c0cdc19f84a471 Bjorn Andersson  2017-01-11  59  	struct device dev;
c0cdc19f84a471 Bjorn Andersson  2017-01-11  60  	struct cdev cdev;
c0cdc19f84a471 Bjorn Andersson  2017-01-11  61  
c0cdc19f84a471 Bjorn Andersson  2017-01-11  62  	struct rpmsg_device *rpdev;
c0cdc19f84a471 Bjorn Andersson  2017-01-11  63  	struct rpmsg_channel_info chinfo;
c0cdc19f84a471 Bjorn Andersson  2017-01-11  64  
c0cdc19f84a471 Bjorn Andersson  2017-01-11  65  	struct mutex ept_lock;
c0cdc19f84a471 Bjorn Andersson  2017-01-11  66  	struct rpmsg_endpoint *ept;
bea9b79c2d10fe Arnaud Pouliquen 2022-01-24  67  	struct rpmsg_endpoint *default_ept;
c0cdc19f84a471 Bjorn Andersson  2017-01-11  68  
c0cdc19f84a471 Bjorn Andersson  2017-01-11  69  	spinlock_t queue_lock;
c0cdc19f84a471 Bjorn Andersson  2017-01-11  70  	struct sk_buff_head queue;
c0cdc19f84a471 Bjorn Andersson  2017-01-11  71  	wait_queue_head_t readq;
bea9b79c2d10fe Arnaud Pouliquen 2022-01-24  72  
5550201c0fe26a Chris Lew        2023-07-07  73  	bool remote_flow_restricted;
5550201c0fe26a Chris Lew        2023-07-07  74  	bool remote_flow_updated;
c0cdc19f84a471 Bjorn Andersson  2017-01-11 @75  };
c0cdc19f84a471 Bjorn Andersson  2017-01-11  76  

:::::: The code at line 75 was first introduced by commit
:::::: c0cdc19f84a4712cf74888f83af286e3c2e14efd rpmsg: Driver for user space endpoint interface

:::::: TO: Bjorn Andersson <bjorn.andersson@linaro.org>
:::::: CC: Bjorn Andersson <bjorn.andersson@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
