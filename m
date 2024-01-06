Return-Path: <linux-kernel+bounces-18596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B70825FDD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4CF1C212FC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 14:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B9F79EC;
	Sat,  6 Jan 2024 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J9zaWgsw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BD779C7
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704551520; x=1736087520;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YLb29ntlNMHCptZ+tsXL5a021uz62e3a6/fcFnbE+48=;
  b=J9zaWgswL8Edg9BzRzbLrmrFiGlWWFCj0aeJf/CUWdhHoJblj6lv6CcW
   DiKi1dAdBTm9ZI3+qwxFZW6EIx2QceWejsGh2F3Jgvz1pUydC6GvWz0zl
   kCzvlA0WzDxcIYZF0Dp9vCf9DkR9poiwMU8C3D5ELjDn8QIGjEr+dfw2R
   0G1EJpQxcGje1ycMdb/Wm7+RG2ZlvYsO//GRz7hca2LlVt6eCkIVwWbDe
   zI1nYvXvfUeYer0T9bNPb7miEkJ48ETzZ5e0tSrwIO71pVqbZIPIx9XQr
   gBDlJeR6Dbkt/L2EXwrLKZ4d0bDSkqjfbvnExnMdPbAu/oL/GDiVN9vax
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="377149980"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="377149980"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 06:31:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="1112338600"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="1112338600"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jan 2024 06:31:57 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rM7iN-0002Za-1W;
	Sat, 06 Jan 2024 14:31:55 +0000
Date: Sat, 6 Jan 2024 22:31:31 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Lew <quic_clew@quicinc.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Deepak Kumar Singh <quic_deesin@quicinc.com>,
	Sarannya S <quic_sarannya@quicinc.com>
Subject: drivers/rpmsg/rpmsg_char.c:75: warning: Function parameter or member
 'remote_flow_restricted' not described in 'rpmsg_eptdev'
Message-ID: <202401062227.o7hS4CFl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Chris,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   95c8a35f1c017327eab3b6a2ff5c04255737c856
commit: 5550201c0fe26a76c53983bd36a58d4c4395ec22 rpmsg: char: Add RPMSG GET/SET FLOWCONTROL IOCTL support
date:   6 months ago
config: x86_64-buildonly-randconfig-001-20240105 (https://download.01.org/0day-ci/archive/20240106/202401062227.o7hS4CFl-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240106/202401062227.o7hS4CFl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401062227.o7hS4CFl-lkp@intel.com/

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

