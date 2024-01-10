Return-Path: <linux-kernel+bounces-22382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA9E829CF1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12D5281E72
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ED34BA8B;
	Wed, 10 Jan 2024 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MFMLifwQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809214BAA5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704898567; x=1736434567;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F3WiUFbxHTe7eB0jKLKknHEdlY9fonsHIWBBHR4FDH0=;
  b=MFMLifwQxZI11JHF7HOvT52xSO3F0cySgeIGG+JwxdsngolR6/02YBs4
   LbsukiWayriq9fG0hEJ4PTwhYcVV8wkKDukVIwHXZOhGz61KJ/oUqPJ5s
   isapLn/c6Ri2wq0Dn+DQp6T4DZ/IeRkMwvO+YWG/ZOzHVnhsQrYjSAo3Q
   XUR/uCFCEJkyrq5Gyg2Q4ps6Zv/U50AhjTV+ALYE27s+pl1AEe9zkYtZR
   TKevRgg5zXbsBMPFwliE5Blc2GUx16TP9Rr62KO0eCaxPIWZljlFsVkos
   FKsWaPWdHotSJ1Xpk1b0yUYP4VcwooQQdqL9Jo2NXWtS9o93Mc7GK9kX/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="11884696"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="11884696"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 06:56:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="16673378"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 10 Jan 2024 06:56:04 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNZzt-000798-2j;
	Wed, 10 Jan 2024 14:56:01 +0000
Date: Wed, 10 Jan 2024 22:55:22 +0800
From: kernel test robot <lkp@intel.com>
To: Vlad Buslov <vladbu@nvidia.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Maor Dickman <maord@nvidia.com>, Roi Dayan <roid@nvidia.com>
Subject: drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c:1833:4:
 warning: 'snprintf' will always be truncated; specified size is 80, but
 format string expands to at least 94
Message-ID: <202401102205.XmxWrS5y-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ab27740f76654ed58dd32ac0ba0031c18a6dea3b
commit: 70f0302b3f2053b64a6a653a76a20cb95438dc85 net/mlx5: Bridge, implement mdb offload
date:   9 months ago
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20240110/202401102205.XmxWrS5y-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 7e186d366d6c7def0543acc255931f617e76dff0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240110/202401102205.XmxWrS5y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401102205.XmxWrS5y-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c:1833:4: warning: 'snprintf' will always be truncated; specified size is 80, but format string expands to at least 94 [-Wformat-truncation-non-kprintf]
    1833 |                         NL_SET_ERR_MSG_FMT_MOD(extack,
         |                         ^
   include/linux/netlink.h:130:2: note: expanded from macro 'NL_SET_ERR_MSG_FMT_MOD'
     130 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
         |         ^
   include/linux/netlink.h:115:6: note: expanded from macro 'NL_SET_ERR_MSG_FMT'
     115 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
         |             ^
   1 warning generated.


vim +/snprintf +1833 drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c

  1805	
  1806	int mlx5_esw_bridge_port_mdb_add(u16 vport_num, u16 esw_owner_vhca_id, const unsigned char *addr,
  1807					 u16 vid, struct mlx5_esw_bridge_offloads *br_offloads,
  1808					 struct netlink_ext_ack *extack)
  1809	{
  1810		struct mlx5_esw_bridge_vlan *vlan;
  1811		struct mlx5_esw_bridge_port *port;
  1812		struct mlx5_esw_bridge *bridge;
  1813		int err;
  1814	
  1815		port = mlx5_esw_bridge_port_lookup(vport_num, esw_owner_vhca_id, br_offloads);
  1816		if (!port) {
  1817			esw_warn(br_offloads->esw->dev,
  1818				 "Failed to lookup bridge port to add MDB (MAC=%pM,vport=%u)\n",
  1819				 addr, vport_num);
  1820			NL_SET_ERR_MSG_FMT_MOD(extack,
  1821					       "Failed to lookup bridge port to add MDB (MAC=%pM,vport=%u)\n",
  1822					       addr, vport_num);
  1823			return -EINVAL;
  1824		}
  1825	
  1826		bridge = port->bridge;
  1827		if (bridge->flags & MLX5_ESW_BRIDGE_VLAN_FILTERING_FLAG && vid) {
  1828			vlan = mlx5_esw_bridge_vlan_lookup(vid, port);
  1829			if (!vlan) {
  1830				esw_warn(br_offloads->esw->dev,
  1831					 "Failed to lookup bridge port vlan metadata to create MDB (MAC=%pM,vid=%u,vport=%u)\n",
  1832					 addr, vid, vport_num);
> 1833				NL_SET_ERR_MSG_FMT_MOD(extack,
  1834						       "Failed to lookup bridge port vlan metadata to create MDB (MAC=%pM,vid=%u,vport=%u)\n",
  1835						       addr, vid, vport_num);
  1836				return -EINVAL;
  1837			}
  1838		}
  1839	
  1840		err = mlx5_esw_bridge_port_mdb_attach(port, addr, vid);
  1841		if (err) {
  1842			NL_SET_ERR_MSG_FMT_MOD(extack, "Failed to add MDB (MAC=%pM,vid=%u,vport=%u)\n",
  1843					       addr, vid, vport_num);
  1844			return err;
  1845		}
  1846	
  1847		return 0;
  1848	}
  1849	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

