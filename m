Return-Path: <linux-kernel+bounces-80-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C0B813BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4C428372A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256B46A359;
	Thu, 14 Dec 2023 20:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XH77n6nU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5A03BB21
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702586475; x=1734122475;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UGpskkH5LDPti066ioLLwm9RqEirrtXjQg5422mYqgY=;
  b=XH77n6nUj53JRdfufMN5HMLqKJaHIsZM7Mr3yrwMAr3JBordlxYkqyGM
   9VLWWIIx6dGdBFxEP3J4r9PR02htTSdZ/2vod4/d1yqTWZX5cIO2VF2ND
   Kn+gtmindECiEaqUgnuoahu+S2RtVsv3Q+6rD694Fj4eJq9yulnVnD/Ij
   qP1jPX7tAZ9tIQN9SmETU4siqjjuQPSmvN1nbM+TcR8HiNH5soXty2YV6
   mpNOZsrE1UIGWEhkIpm5eHtKpY59vOE9SXttrsm5R5RZRlkErKXwh4RqZ
   Y/XM0TE8eavKBBCST7lKANpfD9akJV8MTYKUlnbH95I83T2axBiwSTbWx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="385600020"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="385600020"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 12:41:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="840414199"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="840414199"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 14 Dec 2023 12:41:13 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDsW7-000MbE-0o;
	Thu, 14 Dec 2023 20:41:11 +0000
Date: Fri, 15 Dec 2023 04:40:44 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Chan <mchan@broadcom.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Prashant Sreedharan <prashant@broadcom.com>
Subject: drivers/net/ethernet/broadcom/bnxt/bnxt.c:4114:38: warning: '%s'
 directive output may be truncated writing 4 bytes into a region of size
 between 2 and 17
Message-ID: <202312150450.V7TAnasg-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: c0c050c58d840994ba842ad1c338a98e7c12b764 bnxt_en: New Broadcom ethernet driver.
date:   8 years ago
config: alpha-randconfig-r034-20230903 (https://download.01.org/0day-ci/archive/20231215/202312150450.V7TAnasg-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231215/202312150450.V7TAnasg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150450.V7TAnasg-lkp@intel.com/

All warnings (new ones prefixed by >>):

     319 |         if (sk->sk_wmem_queued > SOCK_MIN_SNDBUF &&
         |                                ^
   include/net/tcp.h: In function 'tcp_slow_start_after_idle_check':
   include/net/tcp.h:1188:19: warning: comparison of integer expressions of different signedness: 's32' {aka 'int'} and '__u32' {aka 'unsigned int'} [-Wsign-compare]
    1188 |         if (delta > inet_csk(sk)->icsk_rto)
         |                   ^
   include/net/tcp.h: In function 'keepalive_intvl_when':
   include/net/tcp.h:1224:40: warning: operand of '?:' changes signedness from 'int' to 'unsigned int' due to unsignedness of other operand [-Wsign-compare]
    1224 |         return tp->keepalive_intvl ? : sysctl_tcp_keepalive_intvl;
         |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/tcp.h: In function 'keepalive_time_when':
   include/net/tcp.h:1229:39: warning: operand of '?:' changes signedness from 'int' to 'unsigned int' due to unsignedness of other operand [-Wsign-compare]
    1229 |         return tp->keepalive_time ? : sysctl_tcp_keepalive_time;
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/tcp.h: In function 'tcp_paws_check':
   include/net/tcp.h:1261:36: warning: comparison of integer expressions of different signedness: 'long unsigned int' and 'long int' [-Wsign-compare]
    1261 |         if (unlikely(get_seconds() >= rx_opt->ts_recent_stamp + TCP_PAWS_24DAYS))
         |                                    ^~
   include/linux/compiler.h:166:45: note: in definition of macro 'unlikely'
     166 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/net/tcp.h: In function 'tcp_paws_reject':
   include/net/tcp.h:1291:34: warning: comparison of integer expressions of different signedness: 'long unsigned int' and 'long int' [-Wsign-compare]
    1291 |         if (rst && get_seconds() >= rx_opt->ts_recent_stamp + TCP_PAWS_MSL)
         |                                  ^~
   In file included from include/net/ip_tunnels.h:11,
                    from include/net/dst_metadata.h:5,
                    from include/net/vxlan.h:10,
                    from drivers/net/ethernet/broadcom/bnxt/bnxt.c:41:
   include/net/gro_cells.h: In function 'gro_cells_receive':
   include/net/gro_cells.h:29:45: warning: comparison of integer expressions of different signedness: '__u32' {aka 'unsigned int'} and 'int' [-Wsign-compare]
      29 |         if (skb_queue_len(&cell->napi_skbs) > netdev_max_backlog) {
         |                                             ^
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_start_xmit':
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:192:32: warning: comparison of integer expressions of different signedness: 'u32' {aka 'unsigned int'} and 'int' [-Wsign-compare]
     192 |         if (unlikely(free_size < skb_shinfo(skb)->nr_frags + 2)) {
         |                                ^
   include/linux/compiler.h:166:45: note: in definition of macro 'unlikely'
     166 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:221:53: warning: comparison of integer expressions of different signedness: 'unsigned int' and 'int' [-Wsign-compare]
     221 |         if (free_size == bp->tx_ring_size && length <= bp->tx_push_thresh) {
         |                                                     ^~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:389:44: warning: comparison of integer expressions of different signedness: 'u32' {aka 'unsigned int'} and 'int' [-Wsign-compare]
     389 |                 if (bnxt_tx_avail(bp, txr) > bp->tx_wake_thresh)
         |                                            ^
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_tx_int':
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:475:37: warning: comparison of integer expressions of different signedness: 'u32' {aka 'unsigned int'} and 'int' [-Wsign-compare]
     475 |             (bnxt_tx_avail(bp, txr) > bp->tx_wake_thresh)) {
         |                                     ^
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:478:44: warning: comparison of integer expressions of different signedness: 'u32' {aka 'unsigned int'} and 'int' [-Wsign-compare]
     478 |                     bnxt_tx_avail(bp, txr) > bp->tx_wake_thresh &&
         |                                            ^
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_init_rxbd_pages':
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:1933:31: warning: comparison of integer expressions of different signedness: 'int' and 'long unsigned int' [-Wsign-compare]
    1933 |                 for (j = 0; j < RX_DESC_CNT; j++, rxbd++, prod++) {
         |                               ^
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_init_one_rx_ring':
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:1963:23: warning: comparison of integer expressions of different signedness: 'int' and 'u32' {aka 'unsigned int'} [-Wsign-compare]
    1963 |         for (i = 0; i < bp->rx_ring_size; i++) {
         |                       ^
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:1985:23: warning: comparison of integer expressions of different signedness: 'int' and 'u32' {aka 'unsigned int'} [-Wsign-compare]
    1985 |         for (i = 0; i < bp->rx_agg_ring_size; i++) {
         |                       ^
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_free_stats':
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:2375:23: warning: comparison of integer expressions of different signedness: 'u32' {aka 'unsigned int'} and 'int' [-Wsign-compare]
    2375 |         for (i = 0; i < bp->cp_nr_rings; i++) {
         |                       ^
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_alloc_stats':
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:2394:23: warning: comparison of integer expressions of different signedness: 'u32' {aka 'unsigned int'} and 'int' [-Wsign-compare]
    2394 |         for (i = 0; i < bp->cp_nr_rings; i++) {
         |                       ^
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function '_hwrm_send_message':
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:2612:45: warning: comparison of integer expressions of different signedness: 'u32' {aka 'unsigned int'} and 'int' [-Wsign-compare]
    2612 |                 while (bp->hwrm_intr_seq_id != HWRM_SEQ_ID_INVALID &&
         |                                             ^~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:2617:42: warning: comparison of integer expressions of different signedness: 'u32' {aka 'unsigned int'} and 'int' [-Wsign-compare]
    2617 |                 if (bp->hwrm_intr_seq_id != HWRM_SEQ_ID_INVALID) {
         |                                          ^~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_hwrm_func_drv_rgtr':
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:2702:31: warning: comparison of integer expressions of different signedness: 'int' and 'long unsigned int' [-Wsign-compare]
    2702 |                 for (i = 0; i < ARRAY_SIZE(bnxt_vf_req_snif); i++)
         |                               ^
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_hwrm_stat_ctx_free':
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:3565:42: warning: comparison of integer expressions of different signedness: 'u32' {aka 'unsigned int'} and 'int' [-Wsign-compare]
    3565 |                 if (cpr->hw_stats_ctx_id != INVALID_STATS_CTX_ID) {
         |                                          ^~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_tx_enable':
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:4313:30: warning: variable 'txq' set but not used [-Wunused-but-set-variable]
    4313 |         struct netdev_queue *txq;
         |                              ^~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_get_stats64':
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:4754:23: warning: comparison of integer expressions of different signedness: 'u32' {aka 'unsigned int'} and 'int' [-Wsign-compare]
    4754 |         for (i = 0; i < bp->cp_nr_rings; i++) {
         |                       ^
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_rx_flow_steer':
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:5359:29: warning: comparison is always false due to limited range of data type [-Wtype-limits]
    5359 |         if (new_fltr->sw_id < 0) {
         |                             ^
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_setup_msix':
>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:4114:38: warning: '%s' directive output may be truncated writing 4 bytes into a region of size between 2 and 17 [-Wformat-truncation=]
    4114 |                                  "%s-%s-%d", dev->name, "TxRx", i);
         |                                      ^~                 ~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:4114:34: note: directive argument in the range [-2147483644, 2147483646]
    4114 |                                  "%s-%s-%d", dev->name, "TxRx", i);
         |                                  ^~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:4113:25: note: 'snprintf' output between 8 and 33 bytes into a destination of size 18
    4113 |                         snprintf(bp->irq_tbl[i].name, len,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    4114 |                                  "%s-%s-%d", dev->name, "TxRx", i);
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function '__bnxt_open_nic':
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:4154:22: warning: '%s' directive output may be truncated writing 4 bytes into a region of size between 2 and 17 [-Wformat-truncation=]
    4154 |                  "%s-%s-%d", bp->dev->name, "TxRx", 0);
         |                      ^~                     ~~~~~~
   In function 'bnxt_setup_inta',
       inlined from 'bnxt_setup_int_mode' at drivers/net/ethernet/broadcom/bnxt/bnxt.c:4169:8,
       inlined from '__bnxt_open_nic' at drivers/net/ethernet/broadcom/bnxt/bnxt.c:4558:8:
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:4153:9: note: 'snprintf' output between 8 and 23 bytes into a destination of size 18
    4153 |         snprintf(bp->irq_tbl[0].name, len,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    4154 |                  "%s-%s-%d", bp->dev->name, "TxRx", 0);
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_init_one':
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:3743:69: warning: '.' directive output may be truncated writing 1 byte into a region of size between 0 and 8 [-Wformat-truncation=]
    3743 |         snprintf(bp->fw_ver_str, BC_HWRM_STR_LEN, "bc %d.%d.%d rm %d.%d.%d",
         |                                                                     ^
   In function 'bnxt_hwrm_ver_get',
       inlined from 'bnxt_init_one' at drivers/net/ethernet/broadcom/bnxt/bnxt.c:5669:2:
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:3743:51: note: directive argument in the range [0, 255]
    3743 |         snprintf(bp->fw_ver_str, BC_HWRM_STR_LEN, "bc %d.%d.%d rm %d.%d.%d",
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:3743:51: note: directive argument in the range [0, 255]
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:3743:9: note: 'snprintf' output between 18 and 30 bytes into a destination of size 21
    3743 |         snprintf(bp->fw_ver_str, BC_HWRM_STR_LEN, "bc %d.%d.%d rm %d.%d.%d",
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    3744 |                  resp->hwrm_fw_maj, resp->hwrm_fw_min, resp->hwrm_fw_bld,
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    3745 |                  resp->hwrm_intf_maj, resp->hwrm_intf_min, resp->hwrm_intf_upd);
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_init_one':
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:5563:54: warning: '.' directive output may be truncated writing 1 byte into a region of size between 0 and 4 [-Wformat-truncation=]
    5563 |         snprintf(phy_ver, PHY_VER_STR_LEN, " ph %d.%d.%d",
         |                                                      ^
   In function 'bnxt_probe_phy',
       inlined from 'bnxt_init_one' at drivers/net/ethernet/broadcom/bnxt/bnxt.c:5712:7:
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:5563:44: note: directive argument in the range [0, 255]
    5563 |         snprintf(phy_ver, PHY_VER_STR_LEN, " ph %d.%d.%d",
         |                                            ^~~~~~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:5563:9: note: 'snprintf' output between 10 and 16 bytes into a destination of size 11
    5563 |         snprintf(phy_ver, PHY_VER_STR_LEN, " ph %d.%d.%d",
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    5564 |                  link_info->phy_ver[0],
         |                  ~~~~~~~~~~~~~~~~~~~~~~
    5565 |                  link_info->phy_ver[1],
         |                  ~~~~~~~~~~~~~~~~~~~~~~
    5566 |                  link_info->phy_ver[2]);
         |                  ~~~~~~~~~~~~~~~~~~~~~~


vim +4114 drivers/net/ethernet/broadcom/bnxt/bnxt.c

  4058	
  4059	static int bnxt_setup_msix(struct bnxt *bp)
  4060	{
  4061		struct msix_entry *msix_ent;
  4062		struct net_device *dev = bp->dev;
  4063		int i, total_vecs, rc = 0;
  4064		const int len = sizeof(bp->irq_tbl[0].name);
  4065	
  4066		bp->flags &= ~BNXT_FLAG_USING_MSIX;
  4067		total_vecs = bp->cp_nr_rings;
  4068	
  4069		msix_ent = kcalloc(total_vecs, sizeof(struct msix_entry), GFP_KERNEL);
  4070		if (!msix_ent)
  4071			return -ENOMEM;
  4072	
  4073		for (i = 0; i < total_vecs; i++) {
  4074			msix_ent[i].entry = i;
  4075			msix_ent[i].vector = 0;
  4076		}
  4077	
  4078		total_vecs = pci_enable_msix_range(bp->pdev, msix_ent, 1, total_vecs);
  4079		if (total_vecs < 0) {
  4080			rc = -ENODEV;
  4081			goto msix_setup_exit;
  4082		}
  4083	
  4084		bp->irq_tbl = kcalloc(total_vecs, sizeof(struct bnxt_irq), GFP_KERNEL);
  4085		if (bp->irq_tbl) {
  4086			int tcs;
  4087	
  4088			/* Trim rings based upon num of vectors allocated */
  4089			bp->rx_nr_rings = min_t(int, total_vecs, bp->rx_nr_rings);
  4090			bp->tx_nr_rings = min_t(int, total_vecs, bp->tx_nr_rings);
  4091			bp->tx_nr_rings_per_tc = bp->tx_nr_rings;
  4092			tcs = netdev_get_num_tc(dev);
  4093			if (tcs > 1) {
  4094				bp->tx_nr_rings_per_tc = bp->tx_nr_rings / tcs;
  4095				if (bp->tx_nr_rings_per_tc == 0) {
  4096					netdev_reset_tc(dev);
  4097					bp->tx_nr_rings_per_tc = bp->tx_nr_rings;
  4098				} else {
  4099					int i, off, count;
  4100	
  4101					bp->tx_nr_rings = bp->tx_nr_rings_per_tc * tcs;
  4102					for (i = 0; i < tcs; i++) {
  4103						count = bp->tx_nr_rings_per_tc;
  4104						off = i * count;
  4105						netdev_set_tc_queue(dev, i, count, off);
  4106					}
  4107				}
  4108			}
  4109			bp->cp_nr_rings = max_t(int, bp->rx_nr_rings, bp->tx_nr_rings);
  4110	
  4111			for (i = 0; i < bp->cp_nr_rings; i++) {
  4112				bp->irq_tbl[i].vector = msix_ent[i].vector;
  4113				snprintf(bp->irq_tbl[i].name, len,
> 4114					 "%s-%s-%d", dev->name, "TxRx", i);
  4115				bp->irq_tbl[i].handler = bnxt_msix;
  4116			}
  4117			rc = bnxt_set_real_num_queues(bp);
  4118			if (rc)
  4119				goto msix_setup_exit;
  4120		} else {
  4121			rc = -ENOMEM;
  4122			goto msix_setup_exit;
  4123		}
  4124		bp->flags |= BNXT_FLAG_USING_MSIX;
  4125		kfree(msix_ent);
  4126		return 0;
  4127	
  4128	msix_setup_exit:
  4129		netdev_err(bp->dev, "bnxt_setup_msix err: %x\n", rc);
  4130		pci_disable_msix(bp->pdev);
  4131		kfree(msix_ent);
  4132		return rc;
  4133	}
  4134	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

