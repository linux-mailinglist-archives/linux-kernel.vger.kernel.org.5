Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18E975A2AC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 01:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjGSXNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 19:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGSXNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:13:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951061701
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 16:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689808431; x=1721344431;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EEC54lNlZTABNqycZeRjQsyi7DpEys803HMO3Jtvbd8=;
  b=iAAIpYG4A3/AC+pYpvGTyrWEnRHubXbDBRq/urXGjo1VXkaiZ3oxRgcQ
   9U74J76sdIKIIZaDsGwoNRVFNxGr+lTgkZ3SNEhFrFyHDNdwh3nNnq9Eq
   9Fu6ZmOZnAoyHc9LiU31IjDMY51Ekt42zVHnuyRZtLdAOGb8FaGAQxWju
   CoLLYLe016iehV0uTYTw8/6l6Y8UWKOHlDRF9EeJQIuZD1wCFu9F2q3Md
   lefkxlOmKpikv9EsGNCck73Ynf7ASEy8TLhY5nv71p+96ZCcMdT9AzQWE
   WvqdWfnQayinyH3vp61081GMqivWVB8k5KBXgDV0LmGEgwzyrK68DdVv5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="346181886"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="346181886"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 16:13:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="848222309"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="848222309"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 19 Jul 2023 16:13:49 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMGMc-0005Zl-0e;
        Wed, 19 Jul 2023 23:13:46 +0000
Date:   Thu, 20 Jul 2023 07:13:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: drivers/net/veth.c:848:12: warning: stack frame size (2096) exceeds
 limit (2048) in 'veth_xdp_rcv'
Message-ID: <202307200753.sG6BpxE4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bfa3037d828050896ae52f6467b6ca2489ae6fb1
commit: 03f61041c17914355dde7261be9ccdc821ddd454 skbuff: Switch structure bounds to struct_group()
date:   1 year, 8 months ago
config: riscv-randconfig-r042-20230720 (https://download.01.org/0day-ci/archive/20230720/202307200753.sG6BpxE4-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230720/202307200753.sG6BpxE4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307200753.sG6BpxE4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/veth.c:848:12: warning: stack frame size (2096) exceeds limit (2048) in 'veth_xdp_rcv' [-Wframe-larger-than]
     848 | static int veth_xdp_rcv(struct veth_rq *rq, int budget,
         |            ^
   1 warning generated.


vim +/veth_xdp_rcv +848 drivers/net/veth.c

948d4f214fde43 Toshiaki Makita  2018-08-03  847  
1c5b82e55f1529 Lorenzo Bianconi 2020-03-19 @848  static int veth_xdp_rcv(struct veth_rq *rq, int budget,
1c5b82e55f1529 Lorenzo Bianconi 2020-03-19  849  			struct veth_xdp_tx_bq *bq,
1c5b82e55f1529 Lorenzo Bianconi 2020-03-19  850  			struct veth_stats *stats)
948d4f214fde43 Toshiaki Makita  2018-08-03  851  {
65e6dcf73398dd Lorenzo Bianconi 2021-01-29  852  	int i, done = 0, n_xdpf = 0;
65e6dcf73398dd Lorenzo Bianconi 2021-01-29  853  	void *xdpf[VETH_XDP_BATCH];
948d4f214fde43 Toshiaki Makita  2018-08-03  854  
948d4f214fde43 Toshiaki Makita  2018-08-03  855  	for (i = 0; i < budget; i++) {
638264dc90227c Toshiaki Makita  2018-08-03  856  		void *ptr = __ptr_ring_consume(&rq->xdp_ring);
948d4f214fde43 Toshiaki Makita  2018-08-03  857  
9fc8d518d9d590 Toshiaki Makita  2018-08-03  858  		if (!ptr)
948d4f214fde43 Toshiaki Makita  2018-08-03  859  			break;
948d4f214fde43 Toshiaki Makita  2018-08-03  860  
d1396004dd8686 Toshiaki Makita  2018-08-03  861  		if (veth_is_xdp_frame(ptr)) {
65e6dcf73398dd Lorenzo Bianconi 2021-01-29  862  			/* ndo_xdp_xmit */
4195e54aaf1c8d Toshiaki Makita  2018-10-11  863  			struct xdp_frame *frame = veth_ptr_to_xdp(ptr);
4195e54aaf1c8d Toshiaki Makita  2018-10-11  864  
1c5b82e55f1529 Lorenzo Bianconi 2020-03-19  865  			stats->xdp_bytes += frame->len;
65e6dcf73398dd Lorenzo Bianconi 2021-01-29  866  			frame = veth_xdp_rcv_one(rq, frame, bq, stats);
65e6dcf73398dd Lorenzo Bianconi 2021-01-29  867  			if (frame) {
65e6dcf73398dd Lorenzo Bianconi 2021-01-29  868  				/* XDP_PASS */
65e6dcf73398dd Lorenzo Bianconi 2021-01-29  869  				xdpf[n_xdpf++] = frame;
65e6dcf73398dd Lorenzo Bianconi 2021-01-29  870  				if (n_xdpf == VETH_XDP_BATCH) {
65e6dcf73398dd Lorenzo Bianconi 2021-01-29  871  					veth_xdp_rcv_bulk_skb(rq, xdpf, n_xdpf,
65e6dcf73398dd Lorenzo Bianconi 2021-01-29  872  							      bq, stats);
65e6dcf73398dd Lorenzo Bianconi 2021-01-29  873  					n_xdpf = 0;
65e6dcf73398dd Lorenzo Bianconi 2021-01-29  874  				}
65e6dcf73398dd Lorenzo Bianconi 2021-01-29  875  			}
d1396004dd8686 Toshiaki Makita  2018-08-03  876  		} else {
65e6dcf73398dd Lorenzo Bianconi 2021-01-29  877  			/* ndo_start_xmit */
65e6dcf73398dd Lorenzo Bianconi 2021-01-29  878  			struct sk_buff *skb = ptr;
65e6dcf73398dd Lorenzo Bianconi 2021-01-29  879  
1c5b82e55f1529 Lorenzo Bianconi 2020-03-19  880  			stats->xdp_bytes += skb->len;
1c5b82e55f1529 Lorenzo Bianconi 2020-03-19  881  			skb = veth_xdp_rcv_skb(rq, skb, bq, stats);
948d4f214fde43 Toshiaki Makita  2018-08-03  882  			if (skb)
638264dc90227c Toshiaki Makita  2018-08-03  883  				napi_gro_receive(&rq->xdp_napi, skb);
65e6dcf73398dd Lorenzo Bianconi 2021-01-29  884  		}
948d4f214fde43 Toshiaki Makita  2018-08-03  885  		done++;
948d4f214fde43 Toshiaki Makita  2018-08-03  886  	}
948d4f214fde43 Toshiaki Makita  2018-08-03  887  
65e6dcf73398dd Lorenzo Bianconi 2021-01-29  888  	if (n_xdpf)
65e6dcf73398dd Lorenzo Bianconi 2021-01-29  889  		veth_xdp_rcv_bulk_skb(rq, xdpf, n_xdpf, bq, stats);
65e6dcf73398dd Lorenzo Bianconi 2021-01-29  890  
4195e54aaf1c8d Toshiaki Makita  2018-10-11  891  	u64_stats_update_begin(&rq->stats.syncp);
9152cff0dd3df6 Lorenzo Bianconi 2020-03-19  892  	rq->stats.vs.xdp_redirect += stats->xdp_redirect;
1c5b82e55f1529 Lorenzo Bianconi 2020-03-19  893  	rq->stats.vs.xdp_bytes += stats->xdp_bytes;
66fe4a078879d1 Lorenzo Bianconi 2020-03-19  894  	rq->stats.vs.xdp_drops += stats->xdp_drops;
66fe4a078879d1 Lorenzo Bianconi 2020-03-19  895  	rq->stats.vs.rx_drops += stats->rx_drops;
65780c5627a26d Lorenzo Bianconi 2020-03-19  896  	rq->stats.vs.xdp_packets += done;
4195e54aaf1c8d Toshiaki Makita  2018-10-11  897  	u64_stats_update_end(&rq->stats.syncp);
4195e54aaf1c8d Toshiaki Makita  2018-10-11  898  
948d4f214fde43 Toshiaki Makita  2018-08-03  899  	return done;
948d4f214fde43 Toshiaki Makita  2018-08-03  900  }
948d4f214fde43 Toshiaki Makita  2018-08-03  901  

:::::: The code at line 848 was first introduced by commit
:::::: 1c5b82e55f152988778bebeea52fae7f6cea9a60 veth: introduce more specialized counters in veth_stats

:::::: TO: Lorenzo Bianconi <lorenzo@kernel.org>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
