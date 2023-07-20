Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E722075A3E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 03:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjGTB2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 21:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjGTB2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 21:28:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5062103
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 18:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689816487; x=1721352487;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dS8zSys+I8foEjEJBKgN0Zwufp1FjomI7SC8JYJszT0=;
  b=iqgaNif83kV5xxKmNsmNfOPH2b3MgkmpiwjhlYBV/Nwb8lcn1CPlTE10
   Fr4496RV+hAm17pujo+cO3N69k319hxNM5mzzAhw6hP7Al9jPMayJ77qq
   TIlCqjAFxmYgKxjewfAQAweB5rLUi4lde56erWaHtwSMuwGMdZACupbsz
   5NLNzxTrcknOhwI/CTK4X/SKBIx008+LF9GIC7r71uWQrEIXmFbbdQ3FX
   naZ2GBPILwAbOiah5uV4fmdjhK9KBkw9XpCNeT9Rpw3Fjz+6tJOIT3g1n
   pYdufnWamxt6kqneCy+XSnY1OIsaXRciKcUiWT+tmdFpUXR+ZrQW90SVD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="365490967"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="365490967"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 18:28:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="794246809"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="794246809"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jul 2023 18:28:04 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMISZ-0005eX-1Q;
        Thu, 20 Jul 2023 01:28:03 +0000
Date:   Thu, 20 Jul 2023 09:27:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brett Creeley <brett.creeley@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: drivers/net/ethernet/intel/ice/ice_txrx.c:1110:5: warning: stack
 frame size (2112) exceeds limit (2048) in 'ice_clean_rx_irq'
Message-ID: <202307200940.zVMY6MIK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bfa3037d828050896ae52f6467b6ca2489ae6fb1
commit: 0d54d8f7a16de0fc53d6ac15361c518af422570e ice: Add hot path support for 802.1Q and 802.1ad VLAN offloads
date:   1 year, 5 months ago
config: riscv-randconfig-r042-20230720 (https://download.01.org/0day-ci/archive/20230720/202307200940.zVMY6MIK-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230720/202307200940.zVMY6MIK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307200940.zVMY6MIK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ice/ice_txrx.c:1110:5: warning: stack frame size (2112) exceeds limit (2048) in 'ice_clean_rx_irq' [-Wframe-larger-than]
    1110 | int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
         |     ^
   1 warning generated.


vim +/ice_clean_rx_irq +1110 drivers/net/ethernet/intel/ice/ice_txrx.c

2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1097  
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1098  /**
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1099   * ice_clean_rx_irq - Clean completed descriptors from Rx ring - bounce buf
d337f2afb7aceb Anirudh Venkataramanan 2018-10-26  1100   * @rx_ring: Rx descriptor ring to transact packets on
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1101   * @budget: Total limit on number of packets to process
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1102   *
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1103   * This function provides a "bounce buffer" approach to Rx interrupt
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1104   * processing. The advantage to this is that on systems that have
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1105   * expensive overhead for IOMMU access this provides a means of avoiding
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1106   * it by maintaining the mapping of the page to the system.
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1107   *
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1108   * Returns amount of work completed
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1109   */
e72bba21355dbb Maciej Fijalkowski     2021-08-19 @1110  int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1111  {
43b5169d8355cc Lorenzo Bianconi       2020-12-22  1112  	unsigned int total_rx_bytes = 0, total_rx_pkts = 0, frame_sz = 0;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1113  	u16 cleaned_count = ICE_DESC_UNUSED(rx_ring);
f1b1f409bf7903 Maciej Fijalkowski     2021-01-18  1114  	unsigned int offset = rx_ring->rx_offset;
eb087cd828648d Maciej Fijalkowski     2021-08-19  1115  	struct ice_tx_ring *xdp_ring = NULL;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1116  	unsigned int xdp_res, xdp_xmit = 0;
29b82f2a09d590 Maciej Fijalkowski     2021-01-18  1117  	struct sk_buff *skb = rx_ring->skb;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1118  	struct bpf_prog *xdp_prog = NULL;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1119  	struct xdp_buff xdp;
cb7db35641c9a5 Brett Creeley          2019-06-26  1120  	bool failure;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1121  
d4ecdbf7aa2fa4 Jesper Dangaard Brouer 2020-05-14  1122  	/* Frame size depend on rx_ring setup when PAGE_SIZE=4K */
d4ecdbf7aa2fa4 Jesper Dangaard Brouer 2020-05-14  1123  #if (PAGE_SIZE < 8192)
43b5169d8355cc Lorenzo Bianconi       2020-12-22  1124  	frame_sz = ice_rx_frame_truesize(rx_ring, 0);
d4ecdbf7aa2fa4 Jesper Dangaard Brouer 2020-05-14  1125  #endif
43b5169d8355cc Lorenzo Bianconi       2020-12-22  1126  	xdp_init_buff(&xdp, frame_sz, &rx_ring->xdp_rxq);
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1127  
eb087cd828648d Maciej Fijalkowski     2021-08-19  1128  	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
eb087cd828648d Maciej Fijalkowski     2021-08-19  1129  	if (xdp_prog)
eb087cd828648d Maciej Fijalkowski     2021-08-19  1130  		xdp_ring = rx_ring->xdp_ring;
eb087cd828648d Maciej Fijalkowski     2021-08-19  1131  
f9867df6d96593 Anirudh Venkataramanan 2019-02-19  1132  	/* start the loop to process Rx packets bounded by 'budget' */
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1133  	while (likely(total_rx_pkts < (unsigned int)budget)) {
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1134  		union ice_32b_rx_flex_desc *rx_desc;
6c869cb7a8f02b Maciej Fijalkowski     2019-02-13  1135  		struct ice_rx_buf *rx_buf;
be9df4aff65f18 Lorenzo Bianconi       2020-12-22  1136  		unsigned char *hard_start;
6c869cb7a8f02b Maciej Fijalkowski     2019-02-13  1137  		unsigned int size;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1138  		u16 stat_err_bits;
1beb7830d3b285 Björn Töpel            2020-08-25  1139  		int rx_buf_pgcnt;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1140  		u16 vlan_tag = 0;
dda90cb90a5ced Jesse Brandeburg       2021-02-23  1141  		u16 rx_ptype;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1142  
f9867df6d96593 Anirudh Venkataramanan 2019-02-19  1143  		/* get the Rx desc from Rx ring based on 'next_to_clean' */
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1144  		rx_desc = ICE_RX_DESC(rx_ring, rx_ring->next_to_clean);
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1145  
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1146  		/* status_error_len will always be zero for unused descriptors
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1147  		 * because it's cleared in cleanup, and overlaps with hdr_addr
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1148  		 * which is always zero because packet split isn't used, if the
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1149  		 * hardware wrote DD then it will be non-zero
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1150  		 */
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1151  		stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_DD_S);
0d54d8f7a16de0 Brett Creeley          2021-12-02  1152  		if (!ice_test_staterr(rx_desc->wb.status_error0, stat_err_bits))
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1153  			break;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1154  
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1155  		/* This memory barrier is needed to keep us from reading
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1156  		 * any other fields out of the rx_desc until we know the
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1157  		 * DD bit is set.
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1158  		 */
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1159  		dma_rmb();
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1160  
3089cf6d3caa1e Jesse Brandeburg       2021-06-08  1161  		ice_trace(clean_rx_irq, rx_ring, rx_desc);
148beb61203125 Henry Tieman           2020-05-11  1162  		if (rx_desc->wb.rxdid == FDIR_DESC_RXDID || !rx_ring->netdev) {
d6218317e2eff8 Qi Zhang               2021-03-09  1163  			struct ice_vsi *ctrl_vsi = rx_ring->vsi;
d6218317e2eff8 Qi Zhang               2021-03-09  1164  
d6218317e2eff8 Qi Zhang               2021-03-09  1165  			if (rx_desc->wb.rxdid == FDIR_DESC_RXDID &&
d6218317e2eff8 Qi Zhang               2021-03-09  1166  			    ctrl_vsi->vf_id != ICE_INVAL_VFID)
d6218317e2eff8 Qi Zhang               2021-03-09  1167  				ice_vc_fdir_irq_handler(ctrl_vsi, rx_desc);
1beb7830d3b285 Björn Töpel            2020-08-25  1168  			ice_put_rx_buf(rx_ring, NULL, 0);
148beb61203125 Henry Tieman           2020-05-11  1169  			cleaned_count++;
148beb61203125 Henry Tieman           2020-05-11  1170  			continue;
148beb61203125 Henry Tieman           2020-05-11  1171  		}
148beb61203125 Henry Tieman           2020-05-11  1172  
6c869cb7a8f02b Maciej Fijalkowski     2019-02-13  1173  		size = le16_to_cpu(rx_desc->wb.pkt_len) &
6c869cb7a8f02b Maciej Fijalkowski     2019-02-13  1174  			ICE_RX_FLX_DESC_PKT_LEN_M;
6c869cb7a8f02b Maciej Fijalkowski     2019-02-13  1175  
ac6f733a7bd5e2 Mitch Williams         2019-07-25  1176  		/* retrieve a buffer from the ring */
29b82f2a09d590 Maciej Fijalkowski     2021-01-18  1177  		rx_buf = ice_get_rx_buf(rx_ring, size, &rx_buf_pgcnt);
ac6f733a7bd5e2 Mitch Williams         2019-07-25  1178  
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1179  		if (!size) {
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1180  			xdp.data = NULL;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1181  			xdp.data_end = NULL;
aaf27254fdf905 Maciej Fijalkowski     2019-10-24  1182  			xdp.data_hard_start = NULL;
aaf27254fdf905 Maciej Fijalkowski     2019-10-24  1183  			xdp.data_meta = NULL;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1184  			goto construct_skb;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1185  		}
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1186  
be9df4aff65f18 Lorenzo Bianconi       2020-12-22  1187  		hard_start = page_address(rx_buf->page) + rx_buf->page_offset -
be9df4aff65f18 Lorenzo Bianconi       2020-12-22  1188  			     offset;
be9df4aff65f18 Lorenzo Bianconi       2020-12-22  1189  		xdp_prepare_buff(&xdp, hard_start, offset, size, true);
d4ecdbf7aa2fa4 Jesper Dangaard Brouer 2020-05-14  1190  #if (PAGE_SIZE > 4096)
d4ecdbf7aa2fa4 Jesper Dangaard Brouer 2020-05-14  1191  		/* At larger PAGE_SIZE, frame_sz depend on len size */
d4ecdbf7aa2fa4 Jesper Dangaard Brouer 2020-05-14  1192  		xdp.frame_sz = ice_rx_frame_truesize(rx_ring, size);
d4ecdbf7aa2fa4 Jesper Dangaard Brouer 2020-05-14  1193  #endif
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1194  
49589b23d5a92d Toke Høiland-Jørgensen 2021-06-24  1195  		if (!xdp_prog)
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1196  			goto construct_skb;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1197  
eb087cd828648d Maciej Fijalkowski     2021-08-19  1198  		xdp_res = ice_run_xdp(rx_ring, &xdp, xdp_prog, xdp_ring);
59bb0808055758 Maciej Fijalkowski     2019-10-24  1199  		if (!xdp_res)
59bb0808055758 Maciej Fijalkowski     2019-10-24  1200  			goto construct_skb;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1201  		if (xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR)) {
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1202  			xdp_xmit |= xdp_res;
d4ecdbf7aa2fa4 Jesper Dangaard Brouer 2020-05-14  1203  			ice_rx_buf_adjust_pg_offset(rx_buf, xdp.frame_sz);
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1204  		} else {
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1205  			rx_buf->pagecnt_bias++;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1206  		}
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1207  		total_rx_bytes += size;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1208  		total_rx_pkts++;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1209  
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1210  		cleaned_count++;
1beb7830d3b285 Björn Töpel            2020-08-25  1211  		ice_put_rx_buf(rx_ring, rx_buf, rx_buf_pgcnt);
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1212  		continue;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1213  construct_skb:
1f45ebe0d8fbe6 Mitch Williams         2019-12-12  1214  		if (skb) {
7237f5b0dba443 Maciej Fijalkowski     2019-10-24  1215  			ice_add_rx_frag(rx_ring, rx_buf, skb, size);
1f45ebe0d8fbe6 Mitch Williams         2019-12-12  1216  		} else if (likely(xdp.data)) {
1f45ebe0d8fbe6 Mitch Williams         2019-12-12  1217  			if (ice_ring_uses_build_skb(rx_ring))
aaf27254fdf905 Maciej Fijalkowski     2019-10-24  1218  				skb = ice_build_skb(rx_ring, rx_buf, &xdp);
712edbbb67d404 Maciej Fijalkowski     2019-02-13  1219  			else
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1220  				skb = ice_construct_skb(rx_ring, rx_buf, &xdp);
1f45ebe0d8fbe6 Mitch Williams         2019-12-12  1221  		}
712edbbb67d404 Maciej Fijalkowski     2019-02-13  1222  		/* exit if we failed to retrieve a buffer */
712edbbb67d404 Maciej Fijalkowski     2019-02-13  1223  		if (!skb) {
712edbbb67d404 Maciej Fijalkowski     2019-02-13  1224  			rx_ring->rx_stats.alloc_buf_failed++;
ac6f733a7bd5e2 Mitch Williams         2019-07-25  1225  			if (rx_buf)
712edbbb67d404 Maciej Fijalkowski     2019-02-13  1226  				rx_buf->pagecnt_bias++;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1227  			break;
712edbbb67d404 Maciej Fijalkowski     2019-02-13  1228  		}
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1229  
1beb7830d3b285 Björn Töpel            2020-08-25  1230  		ice_put_rx_buf(rx_ring, rx_buf, rx_buf_pgcnt);
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1231  		cleaned_count++;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1232  
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1233  		/* skip if it is NOP desc */
29b82f2a09d590 Maciej Fijalkowski     2021-01-18  1234  		if (ice_is_non_eop(rx_ring, rx_desc))
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1235  			continue;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1236  
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1237  		stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_RXE_S);
0d54d8f7a16de0 Brett Creeley          2021-12-02  1238  		if (unlikely(ice_test_staterr(rx_desc->wb.status_error0,
0d54d8f7a16de0 Brett Creeley          2021-12-02  1239  					      stat_err_bits))) {
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1240  			dev_kfree_skb_any(skb);
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1241  			continue;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1242  		}
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1243  
0d54d8f7a16de0 Brett Creeley          2021-12-02  1244  		vlan_tag = ice_get_vlan_tag_from_rx_desc(rx_desc);
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1245  
133f4883f90668 Krzysztof Kazimierczak 2019-10-09  1246  		/* pad the skb if needed, to make a valid ethernet frame */
133f4883f90668 Krzysztof Kazimierczak 2019-10-09  1247  		if (eth_skb_pad(skb)) {
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1248  			skb = NULL;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1249  			continue;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1250  		}
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1251  
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1252  		/* probably a little skewed due to removing CRC */
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1253  		total_rx_bytes += skb->len;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1254  
d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1255  		/* populate checksum, VLAN, and protocol */
6503b659302893 Jesse Brandeburg       2019-08-08  1256  		rx_ptype = le16_to_cpu(rx_desc->wb.ptype_flex_flags0) &
6503b659302893 Jesse Brandeburg       2019-08-08  1257  			ICE_RX_FLEX_DESC_PTYPE_M;
6503b659302893 Jesse Brandeburg       2019-08-08  1258  
d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1259  		ice_process_skb_fields(rx_ring, rx_desc, skb, rx_ptype);
d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1260  
3089cf6d3caa1e Jesse Brandeburg       2021-06-08  1261  		ice_trace(clean_rx_irq_indicate, rx_ring, rx_desc, skb);
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1262  		/* send completed skb up the stack */
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1263  		ice_receive_skb(rx_ring, skb, vlan_tag);
29b82f2a09d590 Maciej Fijalkowski     2021-01-18  1264  		skb = NULL;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1265  
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1266  		/* update budget accounting */
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1267  		total_rx_pkts++;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1268  	}
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1269  
cb7db35641c9a5 Brett Creeley          2019-06-26  1270  	/* return up to cleaned_count buffers to hardware */
cb7db35641c9a5 Brett Creeley          2019-06-26  1271  	failure = ice_alloc_rx_bufs(rx_ring, cleaned_count);
cb7db35641c9a5 Brett Creeley          2019-06-26  1272  
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1273  	if (xdp_prog)
eb087cd828648d Maciej Fijalkowski     2021-08-19  1274  		ice_finalize_xdp_rx(xdp_ring, xdp_xmit);
29b82f2a09d590 Maciej Fijalkowski     2021-01-18  1275  	rx_ring->skb = skb;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1276  
2d4238f5569722 Krzysztof Kazimierczak 2019-11-04  1277  	ice_update_rx_ring_stats(rx_ring, total_rx_pkts, total_rx_bytes);
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1278  
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1279  	/* guarantee a trip back through this routine if there was a failure */
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1280  	return failure ? budget : (int)total_rx_pkts;
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1281  }
2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1282  

:::::: The code at line 1110 was first introduced by commit
:::::: e72bba21355dbb67512a0d666fec9f4b56dbfc2f ice: split ice_ring onto Tx/Rx separate structs

:::::: TO: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
:::::: CC: Tony Nguyen <anthony.l.nguyen@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
