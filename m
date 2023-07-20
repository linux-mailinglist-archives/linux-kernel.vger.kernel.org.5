Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FAB75A4D7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 05:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjGTDl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 23:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTDlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 23:41:55 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD70B1FCB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 20:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689824510; x=1721360510;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=bte1Ep5r+Dpx/BVCSgMuozxde4OMP9zkza/PiKRKgh8=;
  b=Q/JHzYEdPiSZ/oZXQmPs9H8t3uHYNDN8CqaCf60Tnq93XLn60oQUk6gB
   YtBSsq6Zz+1k56HNG2uDuOgPpPQgmj9a2ScLtKd8nTrbe3BkO0Fc57d+g
   16BS0QyYwPf4TXETvRUZ6G4K6uys7S37yUs2cX58t7bzlhY+HnzUt4q6F
   ZCEQR5hhSyEeh53npmQtRI2KvlNONX9BHeCO5i7BWLOvDHHNhVaCpMH5d
   OgdcyI/Y4hgMBVGGz+wl2mK49H1PdRsvCLB2i/iPV+EeFqM9qt8szA2Ct
   iqGN+edr7YDaz3sb5LPGjsOA1JkpyEinGZl2oJEaxmrh9GaBUnAXNw37V
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="365507474"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="365507474"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 20:41:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="674542251"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="674542251"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 19 Jul 2023 20:41:48 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMKXz-0005k9-0Z;
        Thu, 20 Jul 2023 03:41:47 +0000
Date:   Thu, 20 Jul 2023 11:41:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: net/core/flow_dissector.c:916:6: warning: stack frame size (2144)
 exceeds limit (2048) in '__skb_flow_dissect'
Message-ID: <202307201120.crTyImvS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bfa3037d828050896ae52f6467b6ca2489ae6fb1
commit: 281d0c962752fb40866dd8d4cade68656f34bd1f fortify: Add Clang support
date:   1 year, 5 months ago
config: riscv-randconfig-r042-20230720 (https://download.01.org/0day-ci/archive/20230720/202307201120.crTyImvS-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230720/202307201120.crTyImvS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307201120.crTyImvS-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/core/flow_dissector.c:3:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:5:
   In file included from include/linux/fs.h:6:
   In file included from include/linux/wait_bit.h:8:
   In file included from include/linux/wait.h:9:
   In file included from include/linux/spinlock.h:62:
   In file included from include/linux/lockdep.h:14:
   In file included from include/linux/smp.h:13:
   In file included from include/linux/cpumask.h:12:
   In file included from include/linux/bitmap.h:11:
   In file included from include/linux/string.h:253:
   include/linux/fortify-string.h:336:4: warning: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
     336 |                         __read_overflow2_field(q_size_field, size);
         |                         ^
>> net/core/flow_dissector.c:916:6: warning: stack frame size (2144) exceeds limit (2048) in '__skb_flow_dissect' [-Wframe-larger-than]
     916 | bool __skb_flow_dissect(const struct net *net,
         |      ^
   2 warnings generated.
--
>> crypto/testmgr.c:3097:12: warning: stack frame size (2064) exceeds limit (2048) in 'test_skcipher' [-Wframe-larger-than]
    3097 | static int test_skcipher(int enc, const struct cipher_test_suite *suite,
         |            ^
   1 warning generated.


vim +/__skb_flow_dissect +916 net/core/flow_dissector.c

c8aa703822bf81 Stanislav Fomichev  2019-01-28   896  
453a940ea725d6 WANG Cong           2014-08-25   897  /**
453a940ea725d6 WANG Cong           2014-08-25   898   * __skb_flow_dissect - extract the flow_keys struct and return it
3cbf4ffba5eeec Stanislav Fomichev  2019-04-22   899   * @net: associated network namespace, derived from @skb if NULL
453a940ea725d6 WANG Cong           2014-08-25   900   * @skb: sk_buff to extract the flow from, can be NULL if the rest are specified
06635a35d13d42 Jiri Pirko          2015-05-12   901   * @flow_dissector: list of keys to dissect
06635a35d13d42 Jiri Pirko          2015-05-12   902   * @target_container: target structure to put dissected values into
453a940ea725d6 WANG Cong           2014-08-25   903   * @data: raw buffer pointer to the packet, if NULL use skb->data
453a940ea725d6 WANG Cong           2014-08-25   904   * @proto: protocol for which to get the flow, if @data is NULL use skb->protocol
453a940ea725d6 WANG Cong           2014-08-25   905   * @nhoff: network header offset, if @data is NULL use skb_network_offset(skb)
453a940ea725d6 WANG Cong           2014-08-25   906   * @hlen: packet header length, if @data is NULL use skb_headlen(skb)
d79b3bafabc27c Bart Van Assche     2019-03-25   907   * @flags: flags that control the dissection process, e.g.
1cc26450a855aa Stanislav Fomichev  2019-05-31   908   *         FLOW_DISSECTOR_F_STOP_AT_ENCAP.
453a940ea725d6 WANG Cong           2014-08-25   909   *
06635a35d13d42 Jiri Pirko          2015-05-12   910   * The function will try to retrieve individual keys into target specified
06635a35d13d42 Jiri Pirko          2015-05-12   911   * by flow_dissector from either the skbuff or a raw buffer specified by the
06635a35d13d42 Jiri Pirko          2015-05-12   912   * rest parameters.
06635a35d13d42 Jiri Pirko          2015-05-12   913   *
06635a35d13d42 Jiri Pirko          2015-05-12   914   * Caller must take care of zeroing target container memory.
453a940ea725d6 WANG Cong           2014-08-25   915   */
3cbf4ffba5eeec Stanislav Fomichev  2019-04-22  @916  bool __skb_flow_dissect(const struct net *net,
3cbf4ffba5eeec Stanislav Fomichev  2019-04-22   917  			const struct sk_buff *skb,
06635a35d13d42 Jiri Pirko          2015-05-12   918  			struct flow_dissector *flow_dissector,
f96533cded173b Alexander Lobakin   2021-03-14   919  			void *target_container, const void *data,
f96533cded173b Alexander Lobakin   2021-03-14   920  			__be16 proto, int nhoff, int hlen, unsigned int flags)
0744dd00c1b1be Eric Dumazet        2011-11-28   921  {
42aecaa9bb2bd5 Tom Herbert         2015-06-04   922  	struct flow_dissector_key_control *key_control;
06635a35d13d42 Jiri Pirko          2015-05-12   923  	struct flow_dissector_key_basic *key_basic;
06635a35d13d42 Jiri Pirko          2015-05-12   924  	struct flow_dissector_key_addrs *key_addrs;
d34af823ff401c Tom Herbert         2015-06-04   925  	struct flow_dissector_key_tags *key_tags;
f6a66927692e30 Hadar Hen Zion      2016-08-17   926  	struct flow_dissector_key_vlan *key_vlan;
3a1214e8b06317 Tom Herbert         2017-09-01   927  	enum flow_dissect_ret fdret;
24c590e3b0f9ee Jianbo Liu          2018-07-06   928  	enum flow_dissector_key_id dissector_vlan = FLOW_DISSECTOR_KEY_MAX;
58cff782cc55eb Guillaume Nault     2020-05-26   929  	bool mpls_el = false;
58cff782cc55eb Guillaume Nault     2020-05-26   930  	int mpls_lse = 0;
1eed4dfb81b193 Tom Herbert         2017-09-01   931  	int num_hdrs = 0;
8e690ffdbcc7b5 Geert Uytterhoeven  2015-06-25   932  	u8 ip_proto = 0;
34fad54c2537f7 Eric Dumazet        2016-11-09   933  	bool ret;
0744dd00c1b1be Eric Dumazet        2011-11-28   934  
690e36e726d00d David S. Miller     2014-08-23   935  	if (!data) {
690e36e726d00d David S. Miller     2014-08-23   936  		data = skb->data;
d5709f7ab77679 Hadar Hen Zion      2016-08-17   937  		proto = skb_vlan_tag_present(skb) ?
d5709f7ab77679 Hadar Hen Zion      2016-08-17   938  			 skb->vlan_proto : skb->protocol;
453a940ea725d6 WANG Cong           2014-08-25   939  		nhoff = skb_network_offset(skb);
690e36e726d00d David S. Miller     2014-08-23   940  		hlen = skb_headlen(skb);
2d5716456404a1 John Crispin        2017-08-10   941  #if IS_ENABLED(CONFIG_NET_DSA)
8bef0af09a5415 Alexander Lobakin   2019-12-05   942  		if (unlikely(skb->dev && netdev_uses_dsa(skb->dev) &&
8bef0af09a5415 Alexander Lobakin   2019-12-05   943  			     proto == htons(ETH_P_XDSA))) {
43e665287f931a John Crispin        2017-08-09   944  			const struct dsa_device_ops *ops;
8bef0af09a5415 Alexander Lobakin   2019-12-05   945  			int offset = 0;
43e665287f931a John Crispin        2017-08-09   946  
43e665287f931a John Crispin        2017-08-09   947  			ops = skb->dev->dsa_ptr->tag_ops;
ec13357263fb67 Vladimir Oltean     2021-06-14   948  			/* Only DSA header taggers break flow dissection */
ec13357263fb67 Vladimir Oltean     2021-06-14   949  			if (ops->needed_headroom) {
54fec33582aa60 Vladimir Oltean     2020-09-26   950  				if (ops->flow_dissect)
2e8cb1b3db3843 Vladimir Oltean     2020-09-26   951  					ops->flow_dissect(skb, &proto, &offset);
54fec33582aa60 Vladimir Oltean     2020-09-26   952  				else
54fec33582aa60 Vladimir Oltean     2020-09-26   953  					dsa_tag_generic_flow_dissect(skb,
54fec33582aa60 Vladimir Oltean     2020-09-26   954  								     &proto,
54fec33582aa60 Vladimir Oltean     2020-09-26   955  								     &offset);
43e665287f931a John Crispin        2017-08-09   956  				hlen -= offset;
43e665287f931a John Crispin        2017-08-09   957  				nhoff += offset;
43e665287f931a John Crispin        2017-08-09   958  			}
43e665287f931a John Crispin        2017-08-09   959  		}
2d5716456404a1 John Crispin        2017-08-10   960  #endif
690e36e726d00d David S. Miller     2014-08-23   961  	}
690e36e726d00d David S. Miller     2014-08-23   962  
42aecaa9bb2bd5 Tom Herbert         2015-06-04   963  	/* It is ensured by skb_flow_dissector_init() that control key will
42aecaa9bb2bd5 Tom Herbert         2015-06-04   964  	 * be always present.
42aecaa9bb2bd5 Tom Herbert         2015-06-04   965  	 */
42aecaa9bb2bd5 Tom Herbert         2015-06-04   966  	key_control = skb_flow_dissector_target(flow_dissector,
42aecaa9bb2bd5 Tom Herbert         2015-06-04   967  						FLOW_DISSECTOR_KEY_CONTROL,
42aecaa9bb2bd5 Tom Herbert         2015-06-04   968  						target_container);
42aecaa9bb2bd5 Tom Herbert         2015-06-04   969  
06635a35d13d42 Jiri Pirko          2015-05-12   970  	/* It is ensured by skb_flow_dissector_init() that basic key will
06635a35d13d42 Jiri Pirko          2015-05-12   971  	 * be always present.
06635a35d13d42 Jiri Pirko          2015-05-12   972  	 */
06635a35d13d42 Jiri Pirko          2015-05-12   973  	key_basic = skb_flow_dissector_target(flow_dissector,
06635a35d13d42 Jiri Pirko          2015-05-12   974  					      FLOW_DISSECTOR_KEY_BASIC,
06635a35d13d42 Jiri Pirko          2015-05-12   975  					      target_container);
0744dd00c1b1be Eric Dumazet        2011-11-28   976  
d0e13a1488ad30 Willem de Bruijn    2018-09-24   977  	if (skb) {
3cbf4ffba5eeec Stanislav Fomichev  2019-04-22   978  		if (!net) {
d0e13a1488ad30 Willem de Bruijn    2018-09-24   979  			if (skb->dev)
3cbf4ffba5eeec Stanislav Fomichev  2019-04-22   980  				net = dev_net(skb->dev);
d0e13a1488ad30 Willem de Bruijn    2018-09-24   981  			else if (skb->sk)
3cbf4ffba5eeec Stanislav Fomichev  2019-04-22   982  				net = sock_net(skb->sk);
9b52e3f267a683 Stanislav Fomichev  2019-04-22   983  		}
3cbf4ffba5eeec Stanislav Fomichev  2019-04-22   984  	}
3cbf4ffba5eeec Stanislav Fomichev  2019-04-22   985  
9b52e3f267a683 Stanislav Fomichev  2019-04-22   986  	WARN_ON_ONCE(!net);
9b52e3f267a683 Stanislav Fomichev  2019-04-22   987  	if (net) {
a3fd7ceee05431 Jakub Sitnicki      2020-05-31   988  		enum netns_bpf_attach_type type = NETNS_BPF_FLOW_DISSECTOR;
695c12147a4018 Jakub Sitnicki      2020-06-25   989  		struct bpf_prog_array *run_array;
a3fd7ceee05431 Jakub Sitnicki      2020-05-31   990  
9b52e3f267a683 Stanislav Fomichev  2019-04-22   991  		rcu_read_lock();
695c12147a4018 Jakub Sitnicki      2020-06-25   992  		run_array = rcu_dereference(init_net.bpf.run_array[type]);
695c12147a4018 Jakub Sitnicki      2020-06-25   993  		if (!run_array)
695c12147a4018 Jakub Sitnicki      2020-06-25   994  			run_array = rcu_dereference(net->bpf.run_array[type]);
a11c397c43d5b2 Stanislav Fomichev  2019-10-07   995  
695c12147a4018 Jakub Sitnicki      2020-06-25   996  		if (run_array) {
9b52e3f267a683 Stanislav Fomichev  2019-04-22   997  			struct bpf_flow_keys flow_keys;
9b52e3f267a683 Stanislav Fomichev  2019-04-22   998  			struct bpf_flow_dissector ctx = {
9b52e3f267a683 Stanislav Fomichev  2019-04-22   999  				.flow_keys = &flow_keys,
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1000  				.data = data,
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1001  				.data_end = data + hlen,
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1002  			};
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1003  			__be16 n_proto = proto;
695c12147a4018 Jakub Sitnicki      2020-06-25  1004  			struct bpf_prog *prog;
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1005  
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1006  			if (skb) {
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1007  				ctx.skb = skb;
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1008  				/* we can't use 'proto' in the skb case
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1009  				 * because it might be set to skb->vlan_proto
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1010  				 * which has been pulled from the data
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1011  				 */
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1012  				n_proto = skb->protocol;
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1013  			}
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1014  
695c12147a4018 Jakub Sitnicki      2020-06-25  1015  			prog = READ_ONCE(run_array->items[0].prog);
695c12147a4018 Jakub Sitnicki      2020-06-25  1016  			ret = bpf_flow_dissect(prog, &ctx, n_proto, nhoff,
086f95682114fd Stanislav Fomichev  2019-07-25  1017  					       hlen, flags);
d58e468b1112dc Petar Penkov        2018-09-14  1018  			__skb_flow_bpf_to_target(&flow_keys, flow_dissector,
d58e468b1112dc Petar Penkov        2018-09-14  1019  						 target_container);
d58e468b1112dc Petar Penkov        2018-09-14  1020  			rcu_read_unlock();
c8aa703822bf81 Stanislav Fomichev  2019-01-28  1021  			return ret;
d58e468b1112dc Petar Penkov        2018-09-14  1022  		}
d58e468b1112dc Petar Penkov        2018-09-14  1023  		rcu_read_unlock();
c8aa703822bf81 Stanislav Fomichev  2019-01-28  1024  	}
d58e468b1112dc Petar Penkov        2018-09-14  1025  
20a17bf6c04e3e David S. Miller     2015-09-01  1026  	if (dissector_uses_key(flow_dissector,
67a900cc0436d7 Jiri Pirko          2015-05-12  1027  			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
67a900cc0436d7 Jiri Pirko          2015-05-12  1028  		struct ethhdr *eth = eth_hdr(skb);
67a900cc0436d7 Jiri Pirko          2015-05-12  1029  		struct flow_dissector_key_eth_addrs *key_eth_addrs;
67a900cc0436d7 Jiri Pirko          2015-05-12  1030  
67a900cc0436d7 Jiri Pirko          2015-05-12  1031  		key_eth_addrs = skb_flow_dissector_target(flow_dissector,
67a900cc0436d7 Jiri Pirko          2015-05-12  1032  							  FLOW_DISSECTOR_KEY_ETH_ADDRS,
67a900cc0436d7 Jiri Pirko          2015-05-12  1033  							  target_container);
67a900cc0436d7 Jiri Pirko          2015-05-12  1034  		memcpy(key_eth_addrs, &eth->h_dest, sizeof(*key_eth_addrs));
67a900cc0436d7 Jiri Pirko          2015-05-12  1035  	}
67a900cc0436d7 Jiri Pirko          2015-05-12  1036  
c5ef188e931869 Jiri Pirko          2017-03-06  1037  proto_again:
3a1214e8b06317 Tom Herbert         2017-09-01  1038  	fdret = FLOW_DISSECT_RET_CONTINUE;
3a1214e8b06317 Tom Herbert         2017-09-01  1039  
0744dd00c1b1be Eric Dumazet        2011-11-28  1040  	switch (proto) {
2b8837aeaaa0bb Joe Perches         2014-03-12  1041  	case htons(ETH_P_IP): {
0744dd00c1b1be Eric Dumazet        2011-11-28  1042  		const struct iphdr *iph;
0744dd00c1b1be Eric Dumazet        2011-11-28  1043  		struct iphdr _iph;
3a1214e8b06317 Tom Herbert         2017-09-01  1044  
690e36e726d00d David S. Miller     2014-08-23  1045  		iph = __skb_header_pointer(skb, nhoff, sizeof(_iph), data, hlen, &_iph);
3a1214e8b06317 Tom Herbert         2017-09-01  1046  		if (!iph || iph->ihl < 5) {
3a1214e8b06317 Tom Herbert         2017-09-01  1047  			fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert         2017-09-01  1048  			break;
3a1214e8b06317 Tom Herbert         2017-09-01  1049  		}
3a1214e8b06317 Tom Herbert         2017-09-01  1050  
3797d3e8462efd Eric Dumazet        2013-11-07  1051  		nhoff += iph->ihl * 4;
0744dd00c1b1be Eric Dumazet        2011-11-28  1052  
3797d3e8462efd Eric Dumazet        2013-11-07  1053  		ip_proto = iph->protocol;
3797d3e8462efd Eric Dumazet        2013-11-07  1054  
918c023f29ab2d Alexander Duyck     2016-02-24  1055  		if (dissector_uses_key(flow_dissector,
918c023f29ab2d Alexander Duyck     2016-02-24  1056  				       FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
06635a35d13d42 Jiri Pirko          2015-05-12  1057  			key_addrs = skb_flow_dissector_target(flow_dissector,
918c023f29ab2d Alexander Duyck     2016-02-24  1058  							      FLOW_DISSECTOR_KEY_IPV4_ADDRS,
918c023f29ab2d Alexander Duyck     2016-02-24  1059  							      target_container);
918c023f29ab2d Alexander Duyck     2016-02-24  1060  
323e0cb473e2a8 Gustavo A. R. Silva 2021-07-26  1061  			memcpy(&key_addrs->v4addrs.src, &iph->saddr,
323e0cb473e2a8 Gustavo A. R. Silva 2021-07-26  1062  			       sizeof(key_addrs->v4addrs.src));
323e0cb473e2a8 Gustavo A. R. Silva 2021-07-26  1063  			memcpy(&key_addrs->v4addrs.dst, &iph->daddr,
323e0cb473e2a8 Gustavo A. R. Silva 2021-07-26  1064  			       sizeof(key_addrs->v4addrs.dst));
c3f8324188fa80 Tom Herbert         2015-06-04  1065  			key_control->addr_type = FLOW_DISSECTOR_KEY_IPV4_ADDRS;
918c023f29ab2d Alexander Duyck     2016-02-24  1066  		}
807e165dc44fd9 Tom Herbert         2015-09-01  1067  
d2126838050ccd Davide Caratti      2021-02-12  1068  		__skb_flow_dissect_ipv4(skb, flow_dissector,
d2126838050ccd Davide Caratti      2021-02-12  1069  					target_container, data, iph);
d2126838050ccd Davide Caratti      2021-02-12  1070  
807e165dc44fd9 Tom Herbert         2015-09-01  1071  		if (ip_is_fragment(iph)) {
4b36993d3df083 David S. Miller     2015-09-01  1072  			key_control->flags |= FLOW_DIS_IS_FRAGMENT;
807e165dc44fd9 Tom Herbert         2015-09-01  1073  
807e165dc44fd9 Tom Herbert         2015-09-01  1074  			if (iph->frag_off & htons(IP_OFFSET)) {
3a1214e8b06317 Tom Herbert         2017-09-01  1075  				fdret = FLOW_DISSECT_RET_OUT_GOOD;
3a1214e8b06317 Tom Herbert         2017-09-01  1076  				break;
807e165dc44fd9 Tom Herbert         2015-09-01  1077  			} else {
4b36993d3df083 David S. Miller     2015-09-01  1078  				key_control->flags |= FLOW_DIS_FIRST_FRAG;
3a1214e8b06317 Tom Herbert         2017-09-01  1079  				if (!(flags &
3a1214e8b06317 Tom Herbert         2017-09-01  1080  				      FLOW_DISSECTOR_F_PARSE_1ST_FRAG)) {
3a1214e8b06317 Tom Herbert         2017-09-01  1081  					fdret = FLOW_DISSECT_RET_OUT_GOOD;
3a1214e8b06317 Tom Herbert         2017-09-01  1082  					break;
3a1214e8b06317 Tom Herbert         2017-09-01  1083  				}
807e165dc44fd9 Tom Herbert         2015-09-01  1084  			}
807e165dc44fd9 Tom Herbert         2015-09-01  1085  		}
807e165dc44fd9 Tom Herbert         2015-09-01  1086  
0744dd00c1b1be Eric Dumazet        2011-11-28  1087  		break;
0744dd00c1b1be Eric Dumazet        2011-11-28  1088  	}
2b8837aeaaa0bb Joe Perches         2014-03-12  1089  	case htons(ETH_P_IPV6): {
0744dd00c1b1be Eric Dumazet        2011-11-28  1090  		const struct ipv6hdr *iph;
0744dd00c1b1be Eric Dumazet        2011-11-28  1091  		struct ipv6hdr _iph;
19469a873bafd4 Tom Herbert         2014-07-01  1092  
690e36e726d00d David S. Miller     2014-08-23  1093  		iph = __skb_header_pointer(skb, nhoff, sizeof(_iph), data, hlen, &_iph);
3a1214e8b06317 Tom Herbert         2017-09-01  1094  		if (!iph) {
3a1214e8b06317 Tom Herbert         2017-09-01  1095  			fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert         2017-09-01  1096  			break;
3a1214e8b06317 Tom Herbert         2017-09-01  1097  		}
0744dd00c1b1be Eric Dumazet        2011-11-28  1098  
0744dd00c1b1be Eric Dumazet        2011-11-28  1099  		ip_proto = iph->nexthdr;
0744dd00c1b1be Eric Dumazet        2011-11-28  1100  		nhoff += sizeof(struct ipv6hdr);
19469a873bafd4 Tom Herbert         2014-07-01  1101  
20a17bf6c04e3e David S. Miller     2015-09-01  1102  		if (dissector_uses_key(flow_dissector,
b924933cbbfbdc Jiri Pirko          2015-05-12  1103  				       FLOW_DISSECTOR_KEY_IPV6_ADDRS)) {
b3c3106ce3f464 Alexander Duyck     2016-02-24  1104  			key_addrs = skb_flow_dissector_target(flow_dissector,
b924933cbbfbdc Jiri Pirko          2015-05-12  1105  							      FLOW_DISSECTOR_KEY_IPV6_ADDRS,
b924933cbbfbdc Jiri Pirko          2015-05-12  1106  							      target_container);
b924933cbbfbdc Jiri Pirko          2015-05-12  1107  
323e0cb473e2a8 Gustavo A. R. Silva 2021-07-26  1108  			memcpy(&key_addrs->v6addrs.src, &iph->saddr,
323e0cb473e2a8 Gustavo A. R. Silva 2021-07-26  1109  			       sizeof(key_addrs->v6addrs.src));
323e0cb473e2a8 Gustavo A. R. Silva 2021-07-26  1110  			memcpy(&key_addrs->v6addrs.dst, &iph->daddr,
323e0cb473e2a8 Gustavo A. R. Silva 2021-07-26  1111  			       sizeof(key_addrs->v6addrs.dst));
c3f8324188fa80 Tom Herbert         2015-06-04  1112  			key_control->addr_type = FLOW_DISSECTOR_KEY_IPV6_ADDRS;
b924933cbbfbdc Jiri Pirko          2015-05-12  1113  		}
87ee9e52ffeb16 Tom Herbert         2015-06-04  1114  
461547f3158978 Alexander Duyck     2016-02-09  1115  		if ((dissector_uses_key(flow_dissector,
461547f3158978 Alexander Duyck     2016-02-09  1116  					FLOW_DISSECTOR_KEY_FLOW_LABEL) ||
461547f3158978 Alexander Duyck     2016-02-09  1117  		     (flags & FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL)) &&
461547f3158978 Alexander Duyck     2016-02-09  1118  		    ip6_flowlabel(iph)) {
461547f3158978 Alexander Duyck     2016-02-09  1119  			__be32 flow_label = ip6_flowlabel(iph);
461547f3158978 Alexander Duyck     2016-02-09  1120  
20a17bf6c04e3e David S. Miller     2015-09-01  1121  			if (dissector_uses_key(flow_dissector,
87ee9e52ffeb16 Tom Herbert         2015-06-04  1122  					       FLOW_DISSECTOR_KEY_FLOW_LABEL)) {
87ee9e52ffeb16 Tom Herbert         2015-06-04  1123  				key_tags = skb_flow_dissector_target(flow_dissector,
87ee9e52ffeb16 Tom Herbert         2015-06-04  1124  								     FLOW_DISSECTOR_KEY_FLOW_LABEL,
06635a35d13d42 Jiri Pirko          2015-05-12  1125  								     target_container);
87ee9e52ffeb16 Tom Herbert         2015-06-04  1126  				key_tags->flow_label = ntohl(flow_label);
12c227ec89a70c Jiri Pirko          2015-05-22  1127  			}
3a1214e8b06317 Tom Herbert         2017-09-01  1128  			if (flags & FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL) {
3a1214e8b06317 Tom Herbert         2017-09-01  1129  				fdret = FLOW_DISSECT_RET_OUT_GOOD;
3a1214e8b06317 Tom Herbert         2017-09-01  1130  				break;
3a1214e8b06317 Tom Herbert         2017-09-01  1131  			}
19469a873bafd4 Tom Herbert         2014-07-01  1132  		}
19469a873bafd4 Tom Herbert         2014-07-01  1133  
518d8a2e9bad83 Or Gerlitz          2017-06-01  1134  		__skb_flow_dissect_ipv6(skb, flow_dissector,
518d8a2e9bad83 Or Gerlitz          2017-06-01  1135  					target_container, data, iph);
518d8a2e9bad83 Or Gerlitz          2017-06-01  1136  
0744dd00c1b1be Eric Dumazet        2011-11-28  1137  		break;
0744dd00c1b1be Eric Dumazet        2011-11-28  1138  	}
2b8837aeaaa0bb Joe Perches         2014-03-12  1139  	case htons(ETH_P_8021AD):
2b8837aeaaa0bb Joe Perches         2014-03-12  1140  	case htons(ETH_P_8021Q): {
24c590e3b0f9ee Jianbo Liu          2018-07-06  1141  		const struct vlan_hdr *vlan = NULL;
bc72f3dd89e087 Arnd Bergmann       2016-10-24  1142  		struct vlan_hdr _vlan;
2064c3d4c02026 Jianbo Liu          2018-07-06  1143  		__be16 saved_vlan_tpid = proto;
d5709f7ab77679 Hadar Hen Zion      2016-08-17  1144  
24c590e3b0f9ee Jianbo Liu          2018-07-06  1145  		if (dissector_vlan == FLOW_DISSECTOR_KEY_MAX &&
24c590e3b0f9ee Jianbo Liu          2018-07-06  1146  		    skb && skb_vlan_tag_present(skb)) {
d5709f7ab77679 Hadar Hen Zion      2016-08-17  1147  			proto = skb->protocol;
24c590e3b0f9ee Jianbo Liu          2018-07-06  1148  		} else {
d5709f7ab77679 Hadar Hen Zion      2016-08-17  1149  			vlan = __skb_header_pointer(skb, nhoff, sizeof(_vlan),
d5709f7ab77679 Hadar Hen Zion      2016-08-17  1150  						    data, hlen, &_vlan);
3a1214e8b06317 Tom Herbert         2017-09-01  1151  			if (!vlan) {
3a1214e8b06317 Tom Herbert         2017-09-01  1152  				fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert         2017-09-01  1153  				break;
3a1214e8b06317 Tom Herbert         2017-09-01  1154  			}
3a1214e8b06317 Tom Herbert         2017-09-01  1155  
d5709f7ab77679 Hadar Hen Zion      2016-08-17  1156  			proto = vlan->h_vlan_encapsulated_proto;
d5709f7ab77679 Hadar Hen Zion      2016-08-17  1157  			nhoff += sizeof(*vlan);
24c590e3b0f9ee Jianbo Liu          2018-07-06  1158  		}
24c590e3b0f9ee Jianbo Liu          2018-07-06  1159  
24c590e3b0f9ee Jianbo Liu          2018-07-06  1160  		if (dissector_vlan == FLOW_DISSECTOR_KEY_MAX) {
24c590e3b0f9ee Jianbo Liu          2018-07-06  1161  			dissector_vlan = FLOW_DISSECTOR_KEY_VLAN;
24c590e3b0f9ee Jianbo Liu          2018-07-06  1162  		} else if (dissector_vlan == FLOW_DISSECTOR_KEY_VLAN) {
24c590e3b0f9ee Jianbo Liu          2018-07-06  1163  			dissector_vlan = FLOW_DISSECTOR_KEY_CVLAN;
24c590e3b0f9ee Jianbo Liu          2018-07-06  1164  		} else {
3a1214e8b06317 Tom Herbert         2017-09-01  1165  			fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
3a1214e8b06317 Tom Herbert         2017-09-01  1166  			break;
3a1214e8b06317 Tom Herbert         2017-09-01  1167  		}
0744dd00c1b1be Eric Dumazet        2011-11-28  1168  
24c590e3b0f9ee Jianbo Liu          2018-07-06  1169  		if (dissector_uses_key(flow_dissector, dissector_vlan)) {
f6a66927692e30 Hadar Hen Zion      2016-08-17  1170  			key_vlan = skb_flow_dissector_target(flow_dissector,
24c590e3b0f9ee Jianbo Liu          2018-07-06  1171  							     dissector_vlan,
d34af823ff401c Tom Herbert         2015-06-04  1172  							     target_container);
d34af823ff401c Tom Herbert         2015-06-04  1173  
24c590e3b0f9ee Jianbo Liu          2018-07-06  1174  			if (!vlan) {
f6a66927692e30 Hadar Hen Zion      2016-08-17  1175  				key_vlan->vlan_id = skb_vlan_tag_get_id(skb);
9b319148cb34ec Michał Mirosław     2018-11-07  1176  				key_vlan->vlan_priority = skb_vlan_tag_get_prio(skb);
f6a66927692e30 Hadar Hen Zion      2016-08-17  1177  			} else {
f6a66927692e30 Hadar Hen Zion      2016-08-17  1178  				key_vlan->vlan_id = ntohs(vlan->h_vlan_TCI) &
d5709f7ab77679 Hadar Hen Zion      2016-08-17  1179  					VLAN_VID_MASK;
f6a66927692e30 Hadar Hen Zion      2016-08-17  1180  				key_vlan->vlan_priority =
f6a66927692e30 Hadar Hen Zion      2016-08-17  1181  					(ntohs(vlan->h_vlan_TCI) &
f6a66927692e30 Hadar Hen Zion      2016-08-17  1182  					 VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT;
f6a66927692e30 Hadar Hen Zion      2016-08-17  1183  			}
2064c3d4c02026 Jianbo Liu          2018-07-06  1184  			key_vlan->vlan_tpid = saved_vlan_tpid;
d34af823ff401c Tom Herbert         2015-06-04  1185  		}
d34af823ff401c Tom Herbert         2015-06-04  1186  
3a1214e8b06317 Tom Herbert         2017-09-01  1187  		fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
3a1214e8b06317 Tom Herbert         2017-09-01  1188  		break;
0744dd00c1b1be Eric Dumazet        2011-11-28  1189  	}
2b8837aeaaa0bb Joe Perches         2014-03-12  1190  	case htons(ETH_P_PPP_SES): {
0744dd00c1b1be Eric Dumazet        2011-11-28  1191  		struct {
0744dd00c1b1be Eric Dumazet        2011-11-28  1192  			struct pppoe_hdr hdr;
0744dd00c1b1be Eric Dumazet        2011-11-28  1193  			__be16 proto;
0744dd00c1b1be Eric Dumazet        2011-11-28  1194  		} *hdr, _hdr;
690e36e726d00d David S. Miller     2014-08-23  1195  		hdr = __skb_header_pointer(skb, nhoff, sizeof(_hdr), data, hlen, &_hdr);
3a1214e8b06317 Tom Herbert         2017-09-01  1196  		if (!hdr) {
3a1214e8b06317 Tom Herbert         2017-09-01  1197  			fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert         2017-09-01  1198  			break;
3a1214e8b06317 Tom Herbert         2017-09-01  1199  		}
3a1214e8b06317 Tom Herbert         2017-09-01  1200  
0744dd00c1b1be Eric Dumazet        2011-11-28  1201  		nhoff += PPPOE_SES_HLEN;
2e861e5e97175d Boris Sukholitko    2021-09-29  1202  		switch (hdr->proto) {
2b8837aeaaa0bb Joe Perches         2014-03-12  1203  		case htons(PPP_IP):
3a1214e8b06317 Tom Herbert         2017-09-01  1204  			proto = htons(ETH_P_IP);
3a1214e8b06317 Tom Herbert         2017-09-01  1205  			fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
3a1214e8b06317 Tom Herbert         2017-09-01  1206  			break;
2b8837aeaaa0bb Joe Perches         2014-03-12  1207  		case htons(PPP_IPV6):
3a1214e8b06317 Tom Herbert         2017-09-01  1208  			proto = htons(ETH_P_IPV6);
3a1214e8b06317 Tom Herbert         2017-09-01  1209  			fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
3a1214e8b06317 Tom Herbert         2017-09-01  1210  			break;
0744dd00c1b1be Eric Dumazet        2011-11-28  1211  		default:
3a1214e8b06317 Tom Herbert         2017-09-01  1212  			fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert         2017-09-01  1213  			break;
0744dd00c1b1be Eric Dumazet        2011-11-28  1214  		}
3a1214e8b06317 Tom Herbert         2017-09-01  1215  		break;
0744dd00c1b1be Eric Dumazet        2011-11-28  1216  	}
08bfc9cb76e26d Erik Hugne          2015-01-22  1217  	case htons(ETH_P_TIPC): {
8d6e79d3ce13e3 Jon Maloy           2017-11-08  1218  		struct tipc_basic_hdr *hdr, _hdr;
8d6e79d3ce13e3 Jon Maloy           2017-11-08  1219  
8d6e79d3ce13e3 Jon Maloy           2017-11-08  1220  		hdr = __skb_header_pointer(skb, nhoff, sizeof(_hdr),
8d6e79d3ce13e3 Jon Maloy           2017-11-08  1221  					   data, hlen, &_hdr);
3a1214e8b06317 Tom Herbert         2017-09-01  1222  		if (!hdr) {
3a1214e8b06317 Tom Herbert         2017-09-01  1223  			fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert         2017-09-01  1224  			break;
3a1214e8b06317 Tom Herbert         2017-09-01  1225  		}
06635a35d13d42 Jiri Pirko          2015-05-12  1226  
20a17bf6c04e3e David S. Miller     2015-09-01  1227  		if (dissector_uses_key(flow_dissector,
8d6e79d3ce13e3 Jon Maloy           2017-11-08  1228  				       FLOW_DISSECTOR_KEY_TIPC)) {
06635a35d13d42 Jiri Pirko          2015-05-12  1229  			key_addrs = skb_flow_dissector_target(flow_dissector,
8d6e79d3ce13e3 Jon Maloy           2017-11-08  1230  							      FLOW_DISSECTOR_KEY_TIPC,
06635a35d13d42 Jiri Pirko          2015-05-12  1231  							      target_container);
8d6e79d3ce13e3 Jon Maloy           2017-11-08  1232  			key_addrs->tipckey.key = tipc_hdr_rps_key(hdr);
8d6e79d3ce13e3 Jon Maloy           2017-11-08  1233  			key_control->addr_type = FLOW_DISSECTOR_KEY_TIPC;
06635a35d13d42 Jiri Pirko          2015-05-12  1234  		}
3a1214e8b06317 Tom Herbert         2017-09-01  1235  		fdret = FLOW_DISSECT_RET_OUT_GOOD;
3a1214e8b06317 Tom Herbert         2017-09-01  1236  		break;
08bfc9cb76e26d Erik Hugne          2015-01-22  1237  	}
b3baa0fbd02a1a Tom Herbert         2015-06-04  1238  
b3baa0fbd02a1a Tom Herbert         2015-06-04  1239  	case htons(ETH_P_MPLS_UC):
4a5d6c8b14b81e Jiri Pirko          2017-03-06  1240  	case htons(ETH_P_MPLS_MC):
3a1214e8b06317 Tom Herbert         2017-09-01  1241  		fdret = __skb_flow_dissect_mpls(skb, flow_dissector,
4a5d6c8b14b81e Jiri Pirko          2017-03-06  1242  						target_container, data,
58cff782cc55eb Guillaume Nault     2020-05-26  1243  						nhoff, hlen, mpls_lse,
58cff782cc55eb Guillaume Nault     2020-05-26  1244  						&mpls_el);
58cff782cc55eb Guillaume Nault     2020-05-26  1245  		nhoff += sizeof(struct mpls_label);
58cff782cc55eb Guillaume Nault     2020-05-26  1246  		mpls_lse++;
3a1214e8b06317 Tom Herbert         2017-09-01  1247  		break;
56193d1bce2b27 Alexander Duyck     2014-09-05  1248  	case htons(ETH_P_FCOE):
3a1214e8b06317 Tom Herbert         2017-09-01  1249  		if ((hlen - nhoff) < FCOE_HEADER_LEN) {
3a1214e8b06317 Tom Herbert         2017-09-01  1250  			fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert         2017-09-01  1251  			break;
3a1214e8b06317 Tom Herbert         2017-09-01  1252  		}
224516b3a798a0 Alexander Duyck     2016-02-24  1253  
224516b3a798a0 Alexander Duyck     2016-02-24  1254  		nhoff += FCOE_HEADER_LEN;
3a1214e8b06317 Tom Herbert         2017-09-01  1255  		fdret = FLOW_DISSECT_RET_OUT_GOOD;
3a1214e8b06317 Tom Herbert         2017-09-01  1256  		break;
55733350e5e8b7 Simon Horman        2017-01-11  1257  
55733350e5e8b7 Simon Horman        2017-01-11  1258  	case htons(ETH_P_ARP):
9bf881ffc5c0e6 Jiri Pirko          2017-03-06  1259  	case htons(ETH_P_RARP):
3a1214e8b06317 Tom Herbert         2017-09-01  1260  		fdret = __skb_flow_dissect_arp(skb, flow_dissector,
9bf881ffc5c0e6 Jiri Pirko          2017-03-06  1261  					       target_container, data,
3a1214e8b06317 Tom Herbert         2017-09-01  1262  					       nhoff, hlen);
3a1214e8b06317 Tom Herbert         2017-09-01  1263  		break;
3a1214e8b06317 Tom Herbert         2017-09-01  1264  
5b0890a9720462 Sven Eckelmann      2017-12-21  1265  	case htons(ETH_P_BATMAN):
5b0890a9720462 Sven Eckelmann      2017-12-21  1266  		fdret = __skb_flow_dissect_batadv(skb, key_control, data,
5b0890a9720462 Sven Eckelmann      2017-12-21  1267  						  &proto, &nhoff, hlen, flags);
5b0890a9720462 Sven Eckelmann      2017-12-21  1268  		break;
5b0890a9720462 Sven Eckelmann      2017-12-21  1269  
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1270  	case htons(ETH_P_1588): {
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1271  		struct ptp_header *hdr, _hdr;
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1272  
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1273  		hdr = __skb_header_pointer(skb, nhoff, sizeof(_hdr), data,
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1274  					   hlen, &_hdr);
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1275  		if (!hdr) {
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1276  			fdret = FLOW_DISSECT_RET_OUT_BAD;
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1277  			break;
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1278  		}
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1279  
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1280  		nhoff += ntohs(hdr->message_length);
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1281  		fdret = FLOW_DISSECT_RET_OUT_GOOD;
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1282  		break;
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1283  	}
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1284  
3a1214e8b06317 Tom Herbert         2017-09-01  1285  	default:
3a1214e8b06317 Tom Herbert         2017-09-01  1286  		fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert         2017-09-01  1287  		break;
3a1214e8b06317 Tom Herbert         2017-09-01  1288  	}
3a1214e8b06317 Tom Herbert         2017-09-01  1289  
3a1214e8b06317 Tom Herbert         2017-09-01  1290  	/* Process result of proto processing */
3a1214e8b06317 Tom Herbert         2017-09-01  1291  	switch (fdret) {
9bf881ffc5c0e6 Jiri Pirko          2017-03-06  1292  	case FLOW_DISSECT_RET_OUT_GOOD:
55733350e5e8b7 Simon Horman        2017-01-11  1293  		goto out_good;
3a1214e8b06317 Tom Herbert         2017-09-01  1294  	case FLOW_DISSECT_RET_PROTO_AGAIN:
1eed4dfb81b193 Tom Herbert         2017-09-01  1295  		if (skb_flow_dissect_allowed(&num_hdrs))
3a1214e8b06317 Tom Herbert         2017-09-01  1296  			goto proto_again;
1eed4dfb81b193 Tom Herbert         2017-09-01  1297  		goto out_good;
3a1214e8b06317 Tom Herbert         2017-09-01  1298  	case FLOW_DISSECT_RET_CONTINUE:
3a1214e8b06317 Tom Herbert         2017-09-01  1299  	case FLOW_DISSECT_RET_IPPROTO_AGAIN:
3a1214e8b06317 Tom Herbert         2017-09-01  1300  		break;
9bf881ffc5c0e6 Jiri Pirko          2017-03-06  1301  	case FLOW_DISSECT_RET_OUT_BAD:
7c92de8eaabfff Jiri Pirko          2017-03-06  1302  	default:
9bf881ffc5c0e6 Jiri Pirko          2017-03-06  1303  		goto out_bad;
55733350e5e8b7 Simon Horman        2017-01-11  1304  	}
0744dd00c1b1be Eric Dumazet        2011-11-28  1305  
6a74fcf426f51a Tom Herbert         2015-06-12  1306  ip_proto_again:
3a1214e8b06317 Tom Herbert         2017-09-01  1307  	fdret = FLOW_DISSECT_RET_CONTINUE;
3a1214e8b06317 Tom Herbert         2017-09-01  1308  
0744dd00c1b1be Eric Dumazet        2011-11-28  1309  	switch (ip_proto) {
7c92de8eaabfff Jiri Pirko          2017-03-06  1310  	case IPPROTO_GRE:
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1311  		if (flags & FLOW_DISSECTOR_F_STOP_BEFORE_ENCAP) {
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1312  			fdret = FLOW_DISSECT_RET_OUT_GOOD;
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1313  			break;
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1314  		}
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1315  
3a1214e8b06317 Tom Herbert         2017-09-01  1316  		fdret = __skb_flow_dissect_gre(skb, key_control, flow_dissector,
7c92de8eaabfff Jiri Pirko          2017-03-06  1317  					       target_container, data,
3a1214e8b06317 Tom Herbert         2017-09-01  1318  					       &proto, &nhoff, &hlen, flags);
3a1214e8b06317 Tom Herbert         2017-09-01  1319  		break;
3a1214e8b06317 Tom Herbert         2017-09-01  1320  
6a74fcf426f51a Tom Herbert         2015-06-12  1321  	case NEXTHDR_HOP:
6a74fcf426f51a Tom Herbert         2015-06-12  1322  	case NEXTHDR_ROUTING:
6a74fcf426f51a Tom Herbert         2015-06-12  1323  	case NEXTHDR_DEST: {
6a74fcf426f51a Tom Herbert         2015-06-12  1324  		u8 _opthdr[2], *opthdr;
6a74fcf426f51a Tom Herbert         2015-06-12  1325  
6a74fcf426f51a Tom Herbert         2015-06-12  1326  		if (proto != htons(ETH_P_IPV6))
6a74fcf426f51a Tom Herbert         2015-06-12  1327  			break;
6a74fcf426f51a Tom Herbert         2015-06-12  1328  
6a74fcf426f51a Tom Herbert         2015-06-12  1329  		opthdr = __skb_header_pointer(skb, nhoff, sizeof(_opthdr),
6a74fcf426f51a Tom Herbert         2015-06-12  1330  					      data, hlen, &_opthdr);
3a1214e8b06317 Tom Herbert         2017-09-01  1331  		if (!opthdr) {
3a1214e8b06317 Tom Herbert         2017-09-01  1332  			fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert         2017-09-01  1333  			break;
3a1214e8b06317 Tom Herbert         2017-09-01  1334  		}
6a74fcf426f51a Tom Herbert         2015-06-12  1335  
1e98a0f08abddd Eric Dumazet        2015-06-12  1336  		ip_proto = opthdr[0];
1e98a0f08abddd Eric Dumazet        2015-06-12  1337  		nhoff += (opthdr[1] + 1) << 3;
6a74fcf426f51a Tom Herbert         2015-06-12  1338  
3a1214e8b06317 Tom Herbert         2017-09-01  1339  		fdret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
3a1214e8b06317 Tom Herbert         2017-09-01  1340  		break;
6a74fcf426f51a Tom Herbert         2015-06-12  1341  	}
b840f28b908da0 Tom Herbert         2015-09-01  1342  	case NEXTHDR_FRAGMENT: {
b840f28b908da0 Tom Herbert         2015-09-01  1343  		struct frag_hdr _fh, *fh;
b840f28b908da0 Tom Herbert         2015-09-01  1344  
b840f28b908da0 Tom Herbert         2015-09-01  1345  		if (proto != htons(ETH_P_IPV6))
b840f28b908da0 Tom Herbert         2015-09-01  1346  			break;
b840f28b908da0 Tom Herbert         2015-09-01  1347  
b840f28b908da0 Tom Herbert         2015-09-01  1348  		fh = __skb_header_pointer(skb, nhoff, sizeof(_fh),
b840f28b908da0 Tom Herbert         2015-09-01  1349  					  data, hlen, &_fh);
b840f28b908da0 Tom Herbert         2015-09-01  1350  
3a1214e8b06317 Tom Herbert         2017-09-01  1351  		if (!fh) {
3a1214e8b06317 Tom Herbert         2017-09-01  1352  			fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert         2017-09-01  1353  			break;
3a1214e8b06317 Tom Herbert         2017-09-01  1354  		}
b840f28b908da0 Tom Herbert         2015-09-01  1355  
4b36993d3df083 David S. Miller     2015-09-01  1356  		key_control->flags |= FLOW_DIS_IS_FRAGMENT;
b840f28b908da0 Tom Herbert         2015-09-01  1357  
b840f28b908da0 Tom Herbert         2015-09-01  1358  		nhoff += sizeof(_fh);
43d2ccb3c122a4 Alexander Duyck     2016-02-24  1359  		ip_proto = fh->nexthdr;
b840f28b908da0 Tom Herbert         2015-09-01  1360  
b840f28b908da0 Tom Herbert         2015-09-01  1361  		if (!(fh->frag_off & htons(IP6_OFFSET))) {
4b36993d3df083 David S. Miller     2015-09-01  1362  			key_control->flags |= FLOW_DIS_FIRST_FRAG;
3a1214e8b06317 Tom Herbert         2017-09-01  1363  			if (flags & FLOW_DISSECTOR_F_PARSE_1ST_FRAG) {
3a1214e8b06317 Tom Herbert         2017-09-01  1364  				fdret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
3a1214e8b06317 Tom Herbert         2017-09-01  1365  				break;
b840f28b908da0 Tom Herbert         2015-09-01  1366  			}
3a1214e8b06317 Tom Herbert         2017-09-01  1367  		}
3a1214e8b06317 Tom Herbert         2017-09-01  1368  
3a1214e8b06317 Tom Herbert         2017-09-01  1369  		fdret = FLOW_DISSECT_RET_OUT_GOOD;
3a1214e8b06317 Tom Herbert         2017-09-01  1370  		break;
b840f28b908da0 Tom Herbert         2015-09-01  1371  	}
0744dd00c1b1be Eric Dumazet        2011-11-28  1372  	case IPPROTO_IPIP:
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1373  		if (flags & FLOW_DISSECTOR_F_STOP_BEFORE_ENCAP) {
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1374  			fdret = FLOW_DISSECT_RET_OUT_GOOD;
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1375  			break;
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1376  		}
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1377  
fca418955148e4 Tom Herbert         2013-07-29  1378  		proto = htons(ETH_P_IP);
823b96939578ea Tom Herbert         2015-09-01  1379  
4b36993d3df083 David S. Miller     2015-09-01  1380  		key_control->flags |= FLOW_DIS_ENCAPSULATION;
3a1214e8b06317 Tom Herbert         2017-09-01  1381  		if (flags & FLOW_DISSECTOR_F_STOP_AT_ENCAP) {
3a1214e8b06317 Tom Herbert         2017-09-01  1382  			fdret = FLOW_DISSECT_RET_OUT_GOOD;
3a1214e8b06317 Tom Herbert         2017-09-01  1383  			break;
3a1214e8b06317 Tom Herbert         2017-09-01  1384  		}
3a1214e8b06317 Tom Herbert         2017-09-01  1385  
3a1214e8b06317 Tom Herbert         2017-09-01  1386  		fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
3a1214e8b06317 Tom Herbert         2017-09-01  1387  		break;
823b96939578ea Tom Herbert         2015-09-01  1388  
b438f940d3541f Tom Herbert         2013-07-29  1389  	case IPPROTO_IPV6:
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1390  		if (flags & FLOW_DISSECTOR_F_STOP_BEFORE_ENCAP) {
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1391  			fdret = FLOW_DISSECT_RET_OUT_GOOD;
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1392  			break;
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1393  		}
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1394  
b438f940d3541f Tom Herbert         2013-07-29  1395  		proto = htons(ETH_P_IPV6);
823b96939578ea Tom Herbert         2015-09-01  1396  
4b36993d3df083 David S. Miller     2015-09-01  1397  		key_control->flags |= FLOW_DIS_ENCAPSULATION;
3a1214e8b06317 Tom Herbert         2017-09-01  1398  		if (flags & FLOW_DISSECTOR_F_STOP_AT_ENCAP) {
3a1214e8b06317 Tom Herbert         2017-09-01  1399  			fdret = FLOW_DISSECT_RET_OUT_GOOD;
3a1214e8b06317 Tom Herbert         2017-09-01  1400  			break;
3a1214e8b06317 Tom Herbert         2017-09-01  1401  		}
3a1214e8b06317 Tom Herbert         2017-09-01  1402  
3a1214e8b06317 Tom Herbert         2017-09-01  1403  		fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
3a1214e8b06317 Tom Herbert         2017-09-01  1404  		break;
3a1214e8b06317 Tom Herbert         2017-09-01  1405  
823b96939578ea Tom Herbert         2015-09-01  1406  
b3baa0fbd02a1a Tom Herbert         2015-06-04  1407  	case IPPROTO_MPLS:
b3baa0fbd02a1a Tom Herbert         2015-06-04  1408  		proto = htons(ETH_P_MPLS_UC);
3a1214e8b06317 Tom Herbert         2017-09-01  1409  		fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
3a1214e8b06317 Tom Herbert         2017-09-01  1410  		break;
3a1214e8b06317 Tom Herbert         2017-09-01  1411  
ac4bb5de27010e Jiri Pirko          2017-05-23  1412  	case IPPROTO_TCP:
ac4bb5de27010e Jiri Pirko          2017-05-23  1413  		__skb_flow_dissect_tcp(skb, flow_dissector, target_container,
ac4bb5de27010e Jiri Pirko          2017-05-23  1414  				       data, nhoff, hlen);
ac4bb5de27010e Jiri Pirko          2017-05-23  1415  		break;
3a1214e8b06317 Tom Herbert         2017-09-01  1416  
3b336d6f4ec690 Matteo Croce        2019-10-29  1417  	case IPPROTO_ICMP:
3b336d6f4ec690 Matteo Croce        2019-10-29  1418  	case IPPROTO_ICMPV6:
3b336d6f4ec690 Matteo Croce        2019-10-29  1419  		__skb_flow_dissect_icmp(skb, flow_dissector, target_container,
3b336d6f4ec690 Matteo Croce        2019-10-29  1420  					data, nhoff, hlen);
3b336d6f4ec690 Matteo Croce        2019-10-29  1421  		break;
3b336d6f4ec690 Matteo Croce        2019-10-29  1422  
0744dd00c1b1be Eric Dumazet        2011-11-28  1423  	default:
0744dd00c1b1be Eric Dumazet        2011-11-28  1424  		break;
0744dd00c1b1be Eric Dumazet        2011-11-28  1425  	}
0744dd00c1b1be Eric Dumazet        2011-11-28  1426  
8ffb055beae585 Yoshiki Komachi     2019-12-03  1427  	if (!(key_control->flags & FLOW_DIS_IS_FRAGMENT))
8ffb055beae585 Yoshiki Komachi     2019-12-03  1428  		__skb_flow_dissect_ports(skb, flow_dissector, target_container,
8ffb055beae585 Yoshiki Komachi     2019-12-03  1429  					 data, nhoff, ip_proto, hlen);
5af7fb6e3e92c2 Alexander Duyck     2014-10-10  1430  
3a1214e8b06317 Tom Herbert         2017-09-01  1431  	/* Process result of IP proto processing */
3a1214e8b06317 Tom Herbert         2017-09-01  1432  	switch (fdret) {
3a1214e8b06317 Tom Herbert         2017-09-01  1433  	case FLOW_DISSECT_RET_PROTO_AGAIN:
1eed4dfb81b193 Tom Herbert         2017-09-01  1434  		if (skb_flow_dissect_allowed(&num_hdrs))
3a1214e8b06317 Tom Herbert         2017-09-01  1435  			goto proto_again;
1eed4dfb81b193 Tom Herbert         2017-09-01  1436  		break;
3a1214e8b06317 Tom Herbert         2017-09-01  1437  	case FLOW_DISSECT_RET_IPPROTO_AGAIN:
1eed4dfb81b193 Tom Herbert         2017-09-01  1438  		if (skb_flow_dissect_allowed(&num_hdrs))
3a1214e8b06317 Tom Herbert         2017-09-01  1439  			goto ip_proto_again;
1eed4dfb81b193 Tom Herbert         2017-09-01  1440  		break;
3a1214e8b06317 Tom Herbert         2017-09-01  1441  	case FLOW_DISSECT_RET_OUT_GOOD:
3a1214e8b06317 Tom Herbert         2017-09-01  1442  	case FLOW_DISSECT_RET_CONTINUE:
3a1214e8b06317 Tom Herbert         2017-09-01  1443  		break;
3a1214e8b06317 Tom Herbert         2017-09-01  1444  	case FLOW_DISSECT_RET_OUT_BAD:
3a1214e8b06317 Tom Herbert         2017-09-01  1445  	default:
3a1214e8b06317 Tom Herbert         2017-09-01  1446  		goto out_bad;
3a1214e8b06317 Tom Herbert         2017-09-01  1447  	}
3a1214e8b06317 Tom Herbert         2017-09-01  1448  
a6e544b0a88b53 Tom Herbert         2015-09-01  1449  out_good:
a6e544b0a88b53 Tom Herbert         2015-09-01  1450  	ret = true;
a6e544b0a88b53 Tom Herbert         2015-09-01  1451  
34fad54c2537f7 Eric Dumazet        2016-11-09  1452  out:
d0c081b49137cd Eric Dumazet        2018-01-17  1453  	key_control->thoff = min_t(u16, nhoff, skb ? skb->len : hlen);
a6e544b0a88b53 Tom Herbert         2015-09-01  1454  	key_basic->n_proto = proto;
a6e544b0a88b53 Tom Herbert         2015-09-01  1455  	key_basic->ip_proto = ip_proto;
a6e544b0a88b53 Tom Herbert         2015-09-01  1456  
a6e544b0a88b53 Tom Herbert         2015-09-01  1457  	return ret;
34fad54c2537f7 Eric Dumazet        2016-11-09  1458  
34fad54c2537f7 Eric Dumazet        2016-11-09  1459  out_bad:
34fad54c2537f7 Eric Dumazet        2016-11-09  1460  	ret = false;
34fad54c2537f7 Eric Dumazet        2016-11-09  1461  	goto out;
0744dd00c1b1be Eric Dumazet        2011-11-28  1462  }
690e36e726d00d David S. Miller     2014-08-23  1463  EXPORT_SYMBOL(__skb_flow_dissect);
441d9d327f1e77 Cong Wang           2013-01-21  1464  

:::::: The code at line 916 was first introduced by commit
:::::: 3cbf4ffba5eeec60f82868a5facc1962d8a44d00 net: plumb network namespace into __skb_flow_dissect

:::::: TO: Stanislav Fomichev <sdf@google.com>
:::::: CC: Daniel Borkmann <daniel@iogearbox.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
