Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BE67DFB17
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377269AbjKBTrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBTrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:47:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356A8DC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698954467; x=1730490467;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ev5tfQm/MV98szo2yK9Jnm9lxiQX3TWEqDZBKhLR7PU=;
  b=VyVBJJ9Nt2qZ2zZK7SIKHUPWmPTuLZMYLxjzZIEnnKqzKG7ksdZBeTDT
   ddKMkwiaSJBtvZnvU9LWy9ml88MNWR61ZoJ6eXRljkvWkNh1E8hm3aUVf
   yW5OF3j+T+4794f4y7lbkj/K1NJkX0ZcLEYQnHb4crplKzrIjW0EdJQ0t
   W25ownLu91aXfixYYGm9fuxzVi6pLrpNrrktpASnsh064vSS8QSoc8Dq4
   K6c+wIcRvJ8cdljmqw4lnq8OwFn6dQ1Zqx0w2d9JszjGXYkGao9qOuNkX
   yIxFbnPpY4C90wc+UwgYPEUkUy4pw9Yeer/OE6wfaYIgq8i/kvknWOA1G
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="379195189"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="379195189"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 12:47:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="2548336"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 02 Nov 2023 12:47:45 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qydfK-0001pD-2A;
        Thu, 02 Nov 2023 19:47:42 +0000
Date:   Fri, 3 Nov 2023 03:47:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Parav Pandit <parav@nvidia.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: drivers/net/virtio_net.c:3613:50: warning: 'sprintf' may write a
 terminating nul past the end of the destination
Message-ID: <202311030342.XpVqfmYT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4652b8e4f3ffa48c706ec334f048c217a7d9750d
commit: d0671115869d19ec76d658c4bf86d3211a8ea121 virtio-net: Reduce debug name field size to 16 bytes
date:   9 months ago
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20231103/202311030342.XpVqfmYT-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311030342.XpVqfmYT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311030342.XpVqfmYT-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/virtio_net.c: In function 'virtnet_find_vqs':
>> drivers/net/virtio_net.c:3613:50: warning: 'sprintf' may write a terminating nul past the end of the destination [-Wformat-overflow=]
    3613 |                 sprintf(vi->rq[i].name, "input.%d", i);
         |                                                  ^
   drivers/net/virtio_net.c:3613:17: note: 'sprintf' output between 8 and 17 bytes into a destination of size 16
    3613 |                 sprintf(vi->rq[i].name, "input.%d", i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/virtio_net.c:3614:49: warning: '%d' directive writing between 1 and 10 bytes into a region of size 9 [-Wformat-overflow=]
    3614 |                 sprintf(vi->sq[i].name, "output.%d", i);
         |                                                 ^~
   drivers/net/virtio_net.c:3614:41: note: directive argument in the range [0, 2147483646]
    3614 |                 sprintf(vi->sq[i].name, "output.%d", i);
         |                                         ^~~~~~~~~~~
   drivers/net/virtio_net.c:3614:17: note: 'sprintf' output between 9 and 18 bytes into a destination of size 16
    3614 |                 sprintf(vi->sq[i].name, "output.%d", i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/sprintf +3613 drivers/net/virtio_net.c

d85b758f72b05a Michael S. Tsirkin 2017-03-09  3568  
986a4f4d452dec Jason Wang         2012-12-07  3569  static int virtnet_find_vqs(struct virtnet_info *vi)
3f9c10b0d478a3 Amit Shah          2011-12-22  3570  {
986a4f4d452dec Jason Wang         2012-12-07  3571  	vq_callback_t **callbacks;
986a4f4d452dec Jason Wang         2012-12-07  3572  	struct virtqueue **vqs;
986a4f4d452dec Jason Wang         2012-12-07  3573  	int ret = -ENOMEM;
986a4f4d452dec Jason Wang         2012-12-07  3574  	int i, total_vqs;
986a4f4d452dec Jason Wang         2012-12-07  3575  	const char **names;
d45b897b11eaf9 Michael S. Tsirkin 2017-03-06  3576  	bool *ctx;
986a4f4d452dec Jason Wang         2012-12-07  3577  
986a4f4d452dec Jason Wang         2012-12-07  3578  	/* We expect 1 RX virtqueue followed by 1 TX virtqueue, followed by
986a4f4d452dec Jason Wang         2012-12-07  3579  	 * possible N-1 RX/TX queue pairs used in multiqueue mode, followed by
986a4f4d452dec Jason Wang         2012-12-07  3580  	 * possible control vq.
986a4f4d452dec Jason Wang         2012-12-07  3581  	 */
986a4f4d452dec Jason Wang         2012-12-07  3582  	total_vqs = vi->max_queue_pairs * 2 +
986a4f4d452dec Jason Wang         2012-12-07  3583  		    virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ);
986a4f4d452dec Jason Wang         2012-12-07  3584  
986a4f4d452dec Jason Wang         2012-12-07  3585  	/* Allocate space for find_vqs parameters */
6396bb221514d2 Kees Cook          2018-06-12  3586  	vqs = kcalloc(total_vqs, sizeof(*vqs), GFP_KERNEL);
986a4f4d452dec Jason Wang         2012-12-07  3587  	if (!vqs)
986a4f4d452dec Jason Wang         2012-12-07  3588  		goto err_vq;
6da2ec56059c3c Kees Cook          2018-06-12  3589  	callbacks = kmalloc_array(total_vqs, sizeof(*callbacks), GFP_KERNEL);
986a4f4d452dec Jason Wang         2012-12-07  3590  	if (!callbacks)
986a4f4d452dec Jason Wang         2012-12-07  3591  		goto err_callback;
6da2ec56059c3c Kees Cook          2018-06-12  3592  	names = kmalloc_array(total_vqs, sizeof(*names), GFP_KERNEL);
986a4f4d452dec Jason Wang         2012-12-07  3593  	if (!names)
986a4f4d452dec Jason Wang         2012-12-07  3594  		goto err_names;
192f68cf35f5ee Jason Wang         2017-07-19  3595  	if (!vi->big_packets || vi->mergeable_rx_bufs) {
6396bb221514d2 Kees Cook          2018-06-12  3596  		ctx = kcalloc(total_vqs, sizeof(*ctx), GFP_KERNEL);
d45b897b11eaf9 Michael S. Tsirkin 2017-03-06  3597  		if (!ctx)
d45b897b11eaf9 Michael S. Tsirkin 2017-03-06  3598  			goto err_ctx;
d45b897b11eaf9 Michael S. Tsirkin 2017-03-06  3599  	} else {
d45b897b11eaf9 Michael S. Tsirkin 2017-03-06  3600  		ctx = NULL;
d45b897b11eaf9 Michael S. Tsirkin 2017-03-06  3601  	}
986a4f4d452dec Jason Wang         2012-12-07  3602  
986a4f4d452dec Jason Wang         2012-12-07  3603  	/* Parameters for control virtqueue, if any */
986a4f4d452dec Jason Wang         2012-12-07  3604  	if (vi->has_cvq) {
986a4f4d452dec Jason Wang         2012-12-07  3605  		callbacks[total_vqs - 1] = NULL;
986a4f4d452dec Jason Wang         2012-12-07  3606  		names[total_vqs - 1] = "control";
986a4f4d452dec Jason Wang         2012-12-07  3607  	}
986a4f4d452dec Jason Wang         2012-12-07  3608  
986a4f4d452dec Jason Wang         2012-12-07  3609  	/* Allocate/initialize parameters for send/receive virtqueues */
986a4f4d452dec Jason Wang         2012-12-07  3610  	for (i = 0; i < vi->max_queue_pairs; i++) {
986a4f4d452dec Jason Wang         2012-12-07  3611  		callbacks[rxq2vq(i)] = skb_recv_done;
986a4f4d452dec Jason Wang         2012-12-07  3612  		callbacks[txq2vq(i)] = skb_xmit_done;
986a4f4d452dec Jason Wang         2012-12-07 @3613  		sprintf(vi->rq[i].name, "input.%d", i);
986a4f4d452dec Jason Wang         2012-12-07 @3614  		sprintf(vi->sq[i].name, "output.%d", i);
986a4f4d452dec Jason Wang         2012-12-07  3615  		names[rxq2vq(i)] = vi->rq[i].name;
986a4f4d452dec Jason Wang         2012-12-07  3616  		names[txq2vq(i)] = vi->sq[i].name;
d45b897b11eaf9 Michael S. Tsirkin 2017-03-06  3617  		if (ctx)
d45b897b11eaf9 Michael S. Tsirkin 2017-03-06  3618  			ctx[rxq2vq(i)] = true;
986a4f4d452dec Jason Wang         2012-12-07  3619  	}
986a4f4d452dec Jason Wang         2012-12-07  3620  
2e9ca760c289e1 Michael S. Tsirkin 2022-08-16  3621  	ret = virtio_find_vqs_ctx(vi->vdev, total_vqs, vqs, callbacks,
2e9ca760c289e1 Michael S. Tsirkin 2022-08-16  3622  				  names, ctx, NULL);
986a4f4d452dec Jason Wang         2012-12-07  3623  	if (ret)
986a4f4d452dec Jason Wang         2012-12-07  3624  		goto err_find;
3f9c10b0d478a3 Amit Shah          2011-12-22  3625  
986a4f4d452dec Jason Wang         2012-12-07  3626  	if (vi->has_cvq) {
986a4f4d452dec Jason Wang         2012-12-07  3627  		vi->cvq = vqs[total_vqs - 1];
986a4f4d452dec Jason Wang         2012-12-07  3628  		if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VLAN))
f646968f8f7c62 Patrick McHardy    2013-04-19  3629  			vi->dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
986a4f4d452dec Jason Wang         2012-12-07  3630  	}
3f9c10b0d478a3 Amit Shah          2011-12-22  3631  
986a4f4d452dec Jason Wang         2012-12-07  3632  	for (i = 0; i < vi->max_queue_pairs; i++) {
986a4f4d452dec Jason Wang         2012-12-07  3633  		vi->rq[i].vq = vqs[rxq2vq(i)];
d85b758f72b05a Michael S. Tsirkin 2017-03-09  3634  		vi->rq[i].min_buf_len = mergeable_min_buf_len(vi, vi->rq[i].vq);
986a4f4d452dec Jason Wang         2012-12-07  3635  		vi->sq[i].vq = vqs[txq2vq(i)];
986a4f4d452dec Jason Wang         2012-12-07  3636  	}
3f9c10b0d478a3 Amit Shah          2011-12-22  3637  
2fa3c8a8b23041 Tonghao Zhang      2018-05-31  3638  	/* run here: ret == 0. */
3f9c10b0d478a3 Amit Shah          2011-12-22  3639  
3f9c10b0d478a3 Amit Shah          2011-12-22  3640  
986a4f4d452dec Jason Wang         2012-12-07  3641  err_find:
d45b897b11eaf9 Michael S. Tsirkin 2017-03-06  3642  	kfree(ctx);
d45b897b11eaf9 Michael S. Tsirkin 2017-03-06  3643  err_ctx:
986a4f4d452dec Jason Wang         2012-12-07  3644  	kfree(names);
986a4f4d452dec Jason Wang         2012-12-07  3645  err_names:
986a4f4d452dec Jason Wang         2012-12-07  3646  	kfree(callbacks);
986a4f4d452dec Jason Wang         2012-12-07  3647  err_callback:
986a4f4d452dec Jason Wang         2012-12-07  3648  	kfree(vqs);
986a4f4d452dec Jason Wang         2012-12-07  3649  err_vq:
986a4f4d452dec Jason Wang         2012-12-07  3650  	return ret;
3f9c10b0d478a3 Amit Shah          2011-12-22  3651  }
986a4f4d452dec Jason Wang         2012-12-07  3652  

:::::: The code at line 3613 was first introduced by commit
:::::: 986a4f4d452dec004697f667439d27c3fda9c928 virtio_net: multiqueue support

:::::: TO: Jason Wang <jasowang@redhat.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
