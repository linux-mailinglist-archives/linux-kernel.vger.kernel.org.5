Return-Path: <linux-kernel+bounces-18793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CCD826319
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 06:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5AA31C213E1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 05:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F770125B4;
	Sun,  7 Jan 2024 05:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hDDUrmo7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D528125AE
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 05:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704606965; x=1736142965;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CDM7O/aNwXft08O1jKgAlrtcGQec92BLDNxyXa3INsU=;
  b=hDDUrmo7RLRkswS3MJUInTfQkOXkcYQ7NJ4Jgp+nbOLEqxbCl3jxUZdO
   v20Q4jFGXEdyzXwEkR7oD1Kz6J87uxVYALHMKzrWAVaauQ5rna0qmt41L
   g36U8dA+SdqZ/bZh6+KnBCdL26InqAhvZi6Q3nUf3kizDria3dOHaBpfh
   Dt22F9uwn5BN7agzINeaXaPOYhgAUubCNQglPfzbg5CE1lAwS1Ct3BkAS
   DRHqH9mOFftw3c+4DxVOMP1egwnJnLrOXKn0KzqbEChOBrBMby12xDk+u
   QLRvztM8gXdifesd578gR+A7HUSNCu9MfWTcY4oQWDDl12iYfl477HdtZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="4457723"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="4457723"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 21:56:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="730823476"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="730823476"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 06 Jan 2024 21:56:02 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMM8e-0003SM-1E;
	Sun, 07 Jan 2024 05:56:00 +0000
Date: Sun, 7 Jan 2024 13:55:46 +0800
From: kernel test robot <lkp@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <simon.horman@corigine.com>
Subject: drivers/net/ethernet/freescale/enetc/enetc.c:2713:3: warning:
 'snprintf' will always be truncated; specified size is 80, but format string
 expands to at least 110
Message-ID: <202401071345.gs4ThqGA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52b1853b080a082ec3749c3a9577f6c71b1d4a90
commit: 800db2d125c2bc22c448e2386c3518e663d6db71 net: enetc: ensure we always have a minimum number of TXQs for stack
date:   11 months ago
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20240107/202401071345.gs4ThqGA-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 7e186d366d6c7def0543acc255931f617e76dff0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401071345.gs4ThqGA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401071345.gs4ThqGA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/freescale/enetc/enetc.c:2713:3: warning: 'snprintf' will always be truncated; specified size is 80, but format string expands to at least 110 [-Wformat-truncation]
    2713 |                 NL_SET_ERR_MSG_FMT_MOD(extack,
         |                 ^
   include/linux/netlink.h:131:2: note: expanded from macro 'NL_SET_ERR_MSG_FMT_MOD'
     131 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^
   include/linux/netlink.h:116:6: note: expanded from macro 'NL_SET_ERR_MSG_FMT'
     116 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^
   1 warning generated.


vim +/snprintf +2713 drivers/net/ethernet/freescale/enetc/enetc.c

  2703	
  2704	static int enetc_setup_xdp_prog(struct net_device *ndev, struct bpf_prog *prog,
  2705					struct netlink_ext_ack *extack)
  2706	{
  2707		int num_xdp_tx_queues = prog ? num_possible_cpus() : 0;
  2708		struct enetc_ndev_priv *priv = netdev_priv(ndev);
  2709		bool extended;
  2710	
  2711		if (priv->min_num_stack_tx_queues + num_xdp_tx_queues >
  2712		    priv->num_tx_rings) {
> 2713			NL_SET_ERR_MSG_FMT_MOD(extack,
  2714					       "Reserving %d XDP TXQs does not leave a minimum of %d TXQs for network stack (total %d available)",
  2715					       num_xdp_tx_queues,
  2716					       priv->min_num_stack_tx_queues,
  2717					       priv->num_tx_rings);
  2718			return -EBUSY;
  2719		}
  2720	
  2721		extended = !!(priv->active_offloads & ENETC_F_RX_TSTAMP);
  2722	
  2723		/* The buffer layout is changing, so we need to drain the old
  2724		 * RX buffers and seed new ones.
  2725		 */
  2726		return enetc_reconfigure(priv, extended, enetc_reconfigure_xdp_cb, prog);
  2727	}
  2728	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

