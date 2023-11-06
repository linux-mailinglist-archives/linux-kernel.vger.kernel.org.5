Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7D87E1935
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 04:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjKFDfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 22:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFDfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 22:35:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715BBBD
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 19:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699241715; x=1730777715;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AR1Te9tN20j3SIcVWZeTdrTNlOxIuWXOAFl10+CjTfk=;
  b=n2NPykD4q2IUL1+AC8eZVr/z/qd9s9ppR2PXGfCtrD7/rZv5speohcm4
   ViIxbmIoziKpBjBbPbso+BrqfOs5Up8b/UVm5reF1WZaf6IBqiCgDklxk
   XS/KJ4cueCOz/hlQXv343IMuUPMtD8dnsJ2EqFkg43roYTK/pNTMh4lQE
   2vXvVdyjSdTSwAtIpPo9wIPjggbek5YDwnPHY6W9ccJcGxyV/jUgPi8Uv
   figKXpPOqkNg8lVgM/Qb4pi/EbRlKxkb4VK6EwdhO/iWMOPexr5RVkpBV
   gvRWB/DUFh6FHLcX1XH0oeGpne85rW4ETLN9O3qVxO+GNizfCZAF0ayoT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="374232908"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="374232908"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 19:35:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="762191809"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="762191809"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 05 Nov 2023 19:35:12 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzqOM-00064W-1m;
        Mon, 06 Nov 2023 03:35:10 +0000
Date:   Mon, 6 Nov 2023 11:34:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: drivers/block/drbd/drbd_state.c:1629:3: warning: cast from 'int
 (*)(struct sk_buff *, unsigned int, struct drbd_resource_state_change *,
 enum drbd_notification_type)' to 'typeof (last_func)' (aka 'int (*)(struct
 sk_buff *, unsigned int, void *, enum drbd_...
Message-ID: <202311061159.cpOTZn3O-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lv,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   77fa2fbe87fc605c4bfa87dff87be9bfded0e9a3
commit: aadb22ba2f656581b2f733deb3a467c48cc618f6 drbd: Fix five use after free bugs in get_initial_state
date:   1 year, 7 months ago
config: x86_64-randconfig-012-20230909 (https://download.01.org/0day-ci/archive/20231106/202311061159.cpOTZn3O-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311061159.cpOTZn3O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311061159.cpOTZn3O-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/block/drbd/drbd_state.c:1629:3: warning: cast from 'int (*)(struct sk_buff *, unsigned int, struct drbd_resource_state_change *, enum drbd_notification_type)' to 'typeof (last_func)' (aka 'int (*)(struct sk_buff *, unsigned int, void *, enum drbd_notification_type)') converts to incompatible function type [-Wcast-function-type-strict]
                   REMEMBER_STATE_CHANGE(notify_resource_state_change,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_state.c:1616:17: note: expanded from macro 'REMEMBER_STATE_CHANGE'
              last_func = (typeof(last_func))func; \
                          ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/block/drbd/drbd_state.c:1638:4: warning: cast from 'int (*)(struct sk_buff *, unsigned int, struct drbd_connection_state_change *, enum drbd_notification_type)' to 'typeof (last_func)' (aka 'int (*)(struct sk_buff *, unsigned int, void *, enum drbd_notification_type)') converts to incompatible function type [-Wcast-function-type-strict]
                           REMEMBER_STATE_CHANGE(notify_connection_state_change,
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_state.c:1616:17: note: expanded from macro 'REMEMBER_STATE_CHANGE'
              last_func = (typeof(last_func))func; \
                          ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/block/drbd/drbd_state.c:1647:4: warning: cast from 'int (*)(struct sk_buff *, unsigned int, struct drbd_device_state_change *, enum drbd_notification_type)' to 'typeof (last_func)' (aka 'int (*)(struct sk_buff *, unsigned int, void *, enum drbd_notification_type)') converts to incompatible function type [-Wcast-function-type-strict]
                           REMEMBER_STATE_CHANGE(notify_device_state_change,
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_state.c:1616:17: note: expanded from macro 'REMEMBER_STATE_CHANGE'
              last_func = (typeof(last_func))func; \
                          ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/block/drbd/drbd_state.c:1661:4: warning: cast from 'int (*)(struct sk_buff *, unsigned int, struct drbd_peer_device_state_change *, enum drbd_notification_type)' to 'typeof (last_func)' (aka 'int (*)(struct sk_buff *, unsigned int, void *, enum drbd_notification_type)') converts to incompatible function type [-Wcast-function-type-strict]
                           REMEMBER_STATE_CHANGE(notify_peer_device_state_change,
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/block/drbd/drbd_state.c:1616:17: note: expanded from macro 'REMEMBER_STATE_CHANGE'
              last_func = (typeof(last_func))func; \
                          ^~~~~~~~~~~~~~~~~~~~~~~
   4 warnings generated.


vim +1629 drivers/block/drbd/drbd_state.c

a29728463b254c Andreas Gruenbacher 2014-07-31  1599  
a29728463b254c Andreas Gruenbacher 2014-07-31  1600  static void broadcast_state_change(struct drbd_state_change *state_change)
a29728463b254c Andreas Gruenbacher 2014-07-31  1601  {
a29728463b254c Andreas Gruenbacher 2014-07-31  1602  	struct drbd_resource_state_change *resource_state_change = &state_change->resource[0];
a29728463b254c Andreas Gruenbacher 2014-07-31  1603  	bool resource_state_has_changed;
a29728463b254c Andreas Gruenbacher 2014-07-31  1604  	unsigned int n_device, n_connection, n_peer_device, n_peer_devices;
aadb22ba2f6565 Lv Yunlong          2022-04-06  1605  	int (*last_func)(struct sk_buff *, unsigned int, void *,
a29728463b254c Andreas Gruenbacher 2014-07-31  1606  			  enum drbd_notification_type) = NULL;
805cdb8bc6da87 Kees Cook           2020-06-03  1607  	void *last_arg = NULL;
a29728463b254c Andreas Gruenbacher 2014-07-31  1608  
a29728463b254c Andreas Gruenbacher 2014-07-31  1609  #define HAS_CHANGED(state) ((state)[OLD] != (state)[NEW])
a29728463b254c Andreas Gruenbacher 2014-07-31  1610  #define FINAL_STATE_CHANGE(type) \
a29728463b254c Andreas Gruenbacher 2014-07-31  1611  	({ if (last_func) \
a29728463b254c Andreas Gruenbacher 2014-07-31  1612  		last_func(NULL, 0, last_arg, type); \
a29728463b254c Andreas Gruenbacher 2014-07-31  1613  	})
a29728463b254c Andreas Gruenbacher 2014-07-31  1614  #define REMEMBER_STATE_CHANGE(func, arg, type) \
a29728463b254c Andreas Gruenbacher 2014-07-31  1615  	({ FINAL_STATE_CHANGE(type | NOTIFY_CONTINUES); \
a29728463b254c Andreas Gruenbacher 2014-07-31 @1616  	   last_func = (typeof(last_func))func; \
a29728463b254c Andreas Gruenbacher 2014-07-31  1617  	   last_arg = arg; \
a29728463b254c Andreas Gruenbacher 2014-07-31  1618  	 })
a29728463b254c Andreas Gruenbacher 2014-07-31  1619  
a29728463b254c Andreas Gruenbacher 2014-07-31  1620  	mutex_lock(&notification_mutex);
a29728463b254c Andreas Gruenbacher 2014-07-31  1621  
a29728463b254c Andreas Gruenbacher 2014-07-31  1622  	resource_state_has_changed =
a29728463b254c Andreas Gruenbacher 2014-07-31  1623  	    HAS_CHANGED(resource_state_change->role) ||
a29728463b254c Andreas Gruenbacher 2014-07-31  1624  	    HAS_CHANGED(resource_state_change->susp) ||
a29728463b254c Andreas Gruenbacher 2014-07-31  1625  	    HAS_CHANGED(resource_state_change->susp_nod) ||
a29728463b254c Andreas Gruenbacher 2014-07-31  1626  	    HAS_CHANGED(resource_state_change->susp_fen);
a29728463b254c Andreas Gruenbacher 2014-07-31  1627  
a29728463b254c Andreas Gruenbacher 2014-07-31  1628  	if (resource_state_has_changed)
a29728463b254c Andreas Gruenbacher 2014-07-31 @1629  		REMEMBER_STATE_CHANGE(notify_resource_state_change,
a29728463b254c Andreas Gruenbacher 2014-07-31  1630  				      resource_state_change, NOTIFY_CHANGE);
a29728463b254c Andreas Gruenbacher 2014-07-31  1631  
a29728463b254c Andreas Gruenbacher 2014-07-31  1632  	for (n_connection = 0; n_connection < state_change->n_connections; n_connection++) {
a29728463b254c Andreas Gruenbacher 2014-07-31  1633  		struct drbd_connection_state_change *connection_state_change =
a29728463b254c Andreas Gruenbacher 2014-07-31  1634  				&state_change->connections[n_connection];
a29728463b254c Andreas Gruenbacher 2014-07-31  1635  
a29728463b254c Andreas Gruenbacher 2014-07-31  1636  		if (HAS_CHANGED(connection_state_change->peer_role) ||
a29728463b254c Andreas Gruenbacher 2014-07-31  1637  		    HAS_CHANGED(connection_state_change->cstate))
a29728463b254c Andreas Gruenbacher 2014-07-31 @1638  			REMEMBER_STATE_CHANGE(notify_connection_state_change,
a29728463b254c Andreas Gruenbacher 2014-07-31  1639  					      connection_state_change, NOTIFY_CHANGE);
a29728463b254c Andreas Gruenbacher 2014-07-31  1640  	}
a29728463b254c Andreas Gruenbacher 2014-07-31  1641  
a29728463b254c Andreas Gruenbacher 2014-07-31  1642  	for (n_device = 0; n_device < state_change->n_devices; n_device++) {
a29728463b254c Andreas Gruenbacher 2014-07-31  1643  		struct drbd_device_state_change *device_state_change =
a29728463b254c Andreas Gruenbacher 2014-07-31  1644  			&state_change->devices[n_device];
a29728463b254c Andreas Gruenbacher 2014-07-31  1645  
a29728463b254c Andreas Gruenbacher 2014-07-31  1646  		if (HAS_CHANGED(device_state_change->disk_state))
a29728463b254c Andreas Gruenbacher 2014-07-31 @1647  			REMEMBER_STATE_CHANGE(notify_device_state_change,
a29728463b254c Andreas Gruenbacher 2014-07-31  1648  					      device_state_change, NOTIFY_CHANGE);
a29728463b254c Andreas Gruenbacher 2014-07-31  1649  	}
a29728463b254c Andreas Gruenbacher 2014-07-31  1650  
a29728463b254c Andreas Gruenbacher 2014-07-31  1651  	n_peer_devices = state_change->n_devices * state_change->n_connections;
a29728463b254c Andreas Gruenbacher 2014-07-31  1652  	for (n_peer_device = 0; n_peer_device < n_peer_devices; n_peer_device++) {
a29728463b254c Andreas Gruenbacher 2014-07-31  1653  		struct drbd_peer_device_state_change *p =
a29728463b254c Andreas Gruenbacher 2014-07-31  1654  			&state_change->peer_devices[n_peer_device];
a29728463b254c Andreas Gruenbacher 2014-07-31  1655  
a29728463b254c Andreas Gruenbacher 2014-07-31  1656  		if (HAS_CHANGED(p->disk_state) ||
a29728463b254c Andreas Gruenbacher 2014-07-31  1657  		    HAS_CHANGED(p->repl_state) ||
a29728463b254c Andreas Gruenbacher 2014-07-31  1658  		    HAS_CHANGED(p->resync_susp_user) ||
a29728463b254c Andreas Gruenbacher 2014-07-31  1659  		    HAS_CHANGED(p->resync_susp_peer) ||
a29728463b254c Andreas Gruenbacher 2014-07-31  1660  		    HAS_CHANGED(p->resync_susp_dependency))
a29728463b254c Andreas Gruenbacher 2014-07-31 @1661  			REMEMBER_STATE_CHANGE(notify_peer_device_state_change,
a29728463b254c Andreas Gruenbacher 2014-07-31  1662  					      p, NOTIFY_CHANGE);
a29728463b254c Andreas Gruenbacher 2014-07-31  1663  	}
a29728463b254c Andreas Gruenbacher 2014-07-31  1664  
a29728463b254c Andreas Gruenbacher 2014-07-31  1665  	FINAL_STATE_CHANGE(NOTIFY_CHANGE);
a29728463b254c Andreas Gruenbacher 2014-07-31  1666  	mutex_unlock(&notification_mutex);
a29728463b254c Andreas Gruenbacher 2014-07-31  1667  

:::::: The code at line 1629 was first introduced by commit
:::::: a29728463b254ce81ecefdf20c1a02e01d9361da drbd: Backport the "events2" command

:::::: TO: Andreas Gruenbacher <agruen@linbit.com>
:::::: CC: Jens Axboe <axboe@fb.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
