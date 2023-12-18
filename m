Return-Path: <linux-kernel+bounces-3016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BA181662B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5176E281E3C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9544B6FAC;
	Mon, 18 Dec 2023 05:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+6jTfac"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4CD6FA2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 05:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702878844; x=1734414844;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RScmLFsmCoaeq+4oC2D88yOXI8d9a/nOXycDamMBBSw=;
  b=P+6jTfacI6Pr55BTr45GZO6IL5rxyK3qcYtqmFIQwUbqjnImyAaT10A3
   YAb+sxD7G7w/F/evWv0PUtTEN3o3j4PCwEWC47h5em1s0CjBSMs74YMVi
   P5Zjow7BhVJZrkdmQ4kFc20VbjwKzFkxJj2GXXGrH1QgQBSastgo6su+m
   WDCyHlps6OsL6NS90r5aIbm/RjBcwTCQkl3OjZL666lK+8mFRZO8p/LK2
   hP2oFFQDGIlynCXybWAwK9fUUNU9YEbj8HAxopgDUqMhnSgtqgkFZuH+r
   vURl6ndYDklb7So/XgMNREFd9jBRNy/i4IFPYfJSHCAG7n/H51tEPz5R3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="375612591"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="375612591"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 21:54:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="751628868"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="751628868"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Dec 2023 21:54:01 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rF6Zi-0003oP-2s;
	Mon, 18 Dec 2023 05:53:58 +0000
Date: Mon, 18 Dec 2023 13:53:48 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Lew <quic_clew@quicinc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Deepak Kumar Singh <quic_deesin@quicinc.com>,
	Sarannya S <quic_sarannya@quicinc.com>
Subject: drivers/rpmsg/rpmsg_char.c:75: warning: Function parameter or struct
 member 'remote_flow_restricted' not described in 'rpmsg_eptdev'
Message-ID: <202312181313.S1vYyoGH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ceb6a6f023fd3e8b07761ed900352ef574010bcb
commit: 5550201c0fe26a76c53983bd36a58d4c4395ec22 rpmsg: char: Add RPMSG GET/SET FLOWCONTROL IOCTL support
date:   5 months ago
config: i386-buildonly-randconfig-001-20231218 (https://download.01.org/0day-ci/archive/20231218/202312181313.S1vYyoGH-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231218/202312181313.S1vYyoGH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312181313.S1vYyoGH-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/rpmsg/rpmsg_char.c:75: warning: Function parameter or struct member 'remote_flow_restricted' not described in 'rpmsg_eptdev'
>> drivers/rpmsg/rpmsg_char.c:75: warning: Function parameter or struct member 'remote_flow_updated' not described in 'rpmsg_eptdev'


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

