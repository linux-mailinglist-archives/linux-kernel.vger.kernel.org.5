Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A95B75DD6F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 18:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjGVQVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 12:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGVQVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 12:21:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57631FCB
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 09:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690042859; x=1721578859;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=aNTTqXUdlX92xW+5y21Vhc5kXXNOURXng6U49NoKOFY=;
  b=Fg5UuIa44/fbSPEqhSjhtaZqFFqrvStsrNmzQWMiZGYowI7px0YCLaia
   micN9LFgU/yCDbT00KPlO+kHey+utLA1SWvlUaMFRj7v8WPnub+U4+py4
   ZdCsc+p708l4fkEWUjg1mT5ZoXI89OoVahQg+9RqzFXl5MIWQwMvxpgA3
   2WspLE0ViB+p9AFr0knWN3XO2WgFZ3LmUElUK/IydwpD0VQHEN6+JrQoD
   I6CaoS8txdn5svtxfAkVnsldZouNjECNtmygZIeA3WKWzJJ0ZkTdLazuh
   eKK/Jzk35KJIz1bm51GtE4uFexLs8OjEwJ+8X4YesJy/bSnc6s0b+TMtM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="347491670"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="347491670"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 09:20:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="838913197"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="838913197"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jul 2023 09:20:49 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qNFLc-0008S5-37;
        Sat, 22 Jul 2023 16:20:48 +0000
Date:   Sun, 23 Jul 2023 00:20:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wojciech Drewek <wojciech.drewek@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: net/core/flow_dissector.c:946:6: warning: stack frame size (1056)
 exceeds limit (1024) in '__skb_flow_dissect'
Message-ID: <202307230059.Au2QdqPK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d192f5382581d972c4ae1b4d72e0b59b34cadeb9
commit: dda2fa08a13c688bed320ef2e4ba541abb4d6c17 flow_dissector: Add L2TPv3 dissectors
date:   10 months ago
config: riscv-randconfig-r022-20230722 (https://download.01.org/0day-ci/archive/20230723/202307230059.Au2QdqPK-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20230723/202307230059.Au2QdqPK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307230059.Au2QdqPK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/core/flow_dissector.c:946:6: warning: stack frame size (1056) exceeds limit (1024) in '__skb_flow_dissect' [-Wframe-larger-than]
   bool __skb_flow_dissect(const struct net *net,
        ^
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   1 warning and 20 errors generated.


vim +/__skb_flow_dissect +946 net/core/flow_dissector.c

46126db9c86110 Wojciech Drewek     2022-07-18   926  
453a940ea725d6 WANG Cong           2014-08-25   927  /**
453a940ea725d6 WANG Cong           2014-08-25   928   * __skb_flow_dissect - extract the flow_keys struct and return it
3cbf4ffba5eeec Stanislav Fomichev  2019-04-22   929   * @net: associated network namespace, derived from @skb if NULL
453a940ea725d6 WANG Cong           2014-08-25   930   * @skb: sk_buff to extract the flow from, can be NULL if the rest are specified
06635a35d13d42 Jiri Pirko          2015-05-12   931   * @flow_dissector: list of keys to dissect
06635a35d13d42 Jiri Pirko          2015-05-12   932   * @target_container: target structure to put dissected values into
453a940ea725d6 WANG Cong           2014-08-25   933   * @data: raw buffer pointer to the packet, if NULL use skb->data
453a940ea725d6 WANG Cong           2014-08-25   934   * @proto: protocol for which to get the flow, if @data is NULL use skb->protocol
453a940ea725d6 WANG Cong           2014-08-25   935   * @nhoff: network header offset, if @data is NULL use skb_network_offset(skb)
453a940ea725d6 WANG Cong           2014-08-25   936   * @hlen: packet header length, if @data is NULL use skb_headlen(skb)
d79b3bafabc27c Bart Van Assche     2019-03-25   937   * @flags: flags that control the dissection process, e.g.
1cc26450a855aa Stanislav Fomichev  2019-05-31   938   *         FLOW_DISSECTOR_F_STOP_AT_ENCAP.
453a940ea725d6 WANG Cong           2014-08-25   939   *
06635a35d13d42 Jiri Pirko          2015-05-12   940   * The function will try to retrieve individual keys into target specified
06635a35d13d42 Jiri Pirko          2015-05-12   941   * by flow_dissector from either the skbuff or a raw buffer specified by the
06635a35d13d42 Jiri Pirko          2015-05-12   942   * rest parameters.
06635a35d13d42 Jiri Pirko          2015-05-12   943   *
06635a35d13d42 Jiri Pirko          2015-05-12   944   * Caller must take care of zeroing target container memory.
453a940ea725d6 WANG Cong           2014-08-25   945   */
3cbf4ffba5eeec Stanislav Fomichev  2019-04-22  @946  bool __skb_flow_dissect(const struct net *net,
3cbf4ffba5eeec Stanislav Fomichev  2019-04-22   947  			const struct sk_buff *skb,
06635a35d13d42 Jiri Pirko          2015-05-12   948  			struct flow_dissector *flow_dissector,
f96533cded173b Alexander Lobakin   2021-03-14   949  			void *target_container, const void *data,
f96533cded173b Alexander Lobakin   2021-03-14   950  			__be16 proto, int nhoff, int hlen, unsigned int flags)
0744dd00c1b1be Eric Dumazet        2011-11-28   951  {
42aecaa9bb2bd5 Tom Herbert         2015-06-04   952  	struct flow_dissector_key_control *key_control;
06635a35d13d42 Jiri Pirko          2015-05-12   953  	struct flow_dissector_key_basic *key_basic;
06635a35d13d42 Jiri Pirko          2015-05-12   954  	struct flow_dissector_key_addrs *key_addrs;
d34af823ff401c Tom Herbert         2015-06-04   955  	struct flow_dissector_key_tags *key_tags;
f6a66927692e30 Hadar Hen Zion      2016-08-17   956  	struct flow_dissector_key_vlan *key_vlan;
3a1214e8b06317 Tom Herbert         2017-09-01   957  	enum flow_dissect_ret fdret;
24c590e3b0f9ee Jianbo Liu          2018-07-06   958  	enum flow_dissector_key_id dissector_vlan = FLOW_DISSECTOR_KEY_MAX;
58cff782cc55eb Guillaume Nault     2020-05-26   959  	bool mpls_el = false;
58cff782cc55eb Guillaume Nault     2020-05-26   960  	int mpls_lse = 0;
1eed4dfb81b193 Tom Herbert         2017-09-01   961  	int num_hdrs = 0;
8e690ffdbcc7b5 Geert Uytterhoeven  2015-06-25   962  	u8 ip_proto = 0;
34fad54c2537f7 Eric Dumazet        2016-11-09   963  	bool ret;
0744dd00c1b1be Eric Dumazet        2011-11-28   964  
690e36e726d00d David S. Miller     2014-08-23   965  	if (!data) {
690e36e726d00d David S. Miller     2014-08-23   966  		data = skb->data;
d5709f7ab77679 Hadar Hen Zion      2016-08-17   967  		proto = skb_vlan_tag_present(skb) ?
d5709f7ab77679 Hadar Hen Zion      2016-08-17   968  			 skb->vlan_proto : skb->protocol;
453a940ea725d6 WANG Cong           2014-08-25   969  		nhoff = skb_network_offset(skb);
690e36e726d00d David S. Miller     2014-08-23   970  		hlen = skb_headlen(skb);
2d5716456404a1 John Crispin        2017-08-10   971  #if IS_ENABLED(CONFIG_NET_DSA)
8bef0af09a5415 Alexander Lobakin   2019-12-05   972  		if (unlikely(skb->dev && netdev_uses_dsa(skb->dev) &&
8bef0af09a5415 Alexander Lobakin   2019-12-05   973  			     proto == htons(ETH_P_XDSA))) {
43e665287f931a John Crispin        2017-08-09   974  			const struct dsa_device_ops *ops;
8bef0af09a5415 Alexander Lobakin   2019-12-05   975  			int offset = 0;
43e665287f931a John Crispin        2017-08-09   976  
43e665287f931a John Crispin        2017-08-09   977  			ops = skb->dev->dsa_ptr->tag_ops;
ec13357263fb67 Vladimir Oltean     2021-06-14   978  			/* Only DSA header taggers break flow dissection */
ec13357263fb67 Vladimir Oltean     2021-06-14   979  			if (ops->needed_headroom) {
54fec33582aa60 Vladimir Oltean     2020-09-26   980  				if (ops->flow_dissect)
2e8cb1b3db3843 Vladimir Oltean     2020-09-26   981  					ops->flow_dissect(skb, &proto, &offset);
54fec33582aa60 Vladimir Oltean     2020-09-26   982  				else
54fec33582aa60 Vladimir Oltean     2020-09-26   983  					dsa_tag_generic_flow_dissect(skb,
54fec33582aa60 Vladimir Oltean     2020-09-26   984  								     &proto,
54fec33582aa60 Vladimir Oltean     2020-09-26   985  								     &offset);
43e665287f931a John Crispin        2017-08-09   986  				hlen -= offset;
43e665287f931a John Crispin        2017-08-09   987  				nhoff += offset;
43e665287f931a John Crispin        2017-08-09   988  			}
43e665287f931a John Crispin        2017-08-09   989  		}
2d5716456404a1 John Crispin        2017-08-10   990  #endif
690e36e726d00d David S. Miller     2014-08-23   991  	}
690e36e726d00d David S. Miller     2014-08-23   992  
42aecaa9bb2bd5 Tom Herbert         2015-06-04   993  	/* It is ensured by skb_flow_dissector_init() that control key will
42aecaa9bb2bd5 Tom Herbert         2015-06-04   994  	 * be always present.
42aecaa9bb2bd5 Tom Herbert         2015-06-04   995  	 */
42aecaa9bb2bd5 Tom Herbert         2015-06-04   996  	key_control = skb_flow_dissector_target(flow_dissector,
42aecaa9bb2bd5 Tom Herbert         2015-06-04   997  						FLOW_DISSECTOR_KEY_CONTROL,
42aecaa9bb2bd5 Tom Herbert         2015-06-04   998  						target_container);
42aecaa9bb2bd5 Tom Herbert         2015-06-04   999  
06635a35d13d42 Jiri Pirko          2015-05-12  1000  	/* It is ensured by skb_flow_dissector_init() that basic key will
06635a35d13d42 Jiri Pirko          2015-05-12  1001  	 * be always present.
06635a35d13d42 Jiri Pirko          2015-05-12  1002  	 */
06635a35d13d42 Jiri Pirko          2015-05-12  1003  	key_basic = skb_flow_dissector_target(flow_dissector,
06635a35d13d42 Jiri Pirko          2015-05-12  1004  					      FLOW_DISSECTOR_KEY_BASIC,
06635a35d13d42 Jiri Pirko          2015-05-12  1005  					      target_container);
0744dd00c1b1be Eric Dumazet        2011-11-28  1006  
d0e13a1488ad30 Willem de Bruijn    2018-09-24  1007  	if (skb) {
3cbf4ffba5eeec Stanislav Fomichev  2019-04-22  1008  		if (!net) {
d0e13a1488ad30 Willem de Bruijn    2018-09-24  1009  			if (skb->dev)
3cbf4ffba5eeec Stanislav Fomichev  2019-04-22  1010  				net = dev_net(skb->dev);
d0e13a1488ad30 Willem de Bruijn    2018-09-24  1011  			else if (skb->sk)
3cbf4ffba5eeec Stanislav Fomichev  2019-04-22  1012  				net = sock_net(skb->sk);
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1013  		}
3cbf4ffba5eeec Stanislav Fomichev  2019-04-22  1014  	}
3cbf4ffba5eeec Stanislav Fomichev  2019-04-22  1015  
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1016  	WARN_ON_ONCE(!net);
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1017  	if (net) {
a3fd7ceee05431 Jakub Sitnicki      2020-05-31  1018  		enum netns_bpf_attach_type type = NETNS_BPF_FLOW_DISSECTOR;
695c12147a4018 Jakub Sitnicki      2020-06-25  1019  		struct bpf_prog_array *run_array;
a3fd7ceee05431 Jakub Sitnicki      2020-05-31  1020  
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1021  		rcu_read_lock();
695c12147a4018 Jakub Sitnicki      2020-06-25  1022  		run_array = rcu_dereference(init_net.bpf.run_array[type]);
695c12147a4018 Jakub Sitnicki      2020-06-25  1023  		if (!run_array)
695c12147a4018 Jakub Sitnicki      2020-06-25  1024  			run_array = rcu_dereference(net->bpf.run_array[type]);
a11c397c43d5b2 Stanislav Fomichev  2019-10-07  1025  
695c12147a4018 Jakub Sitnicki      2020-06-25  1026  		if (run_array) {
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1027  			struct bpf_flow_keys flow_keys;
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1028  			struct bpf_flow_dissector ctx = {
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1029  				.flow_keys = &flow_keys,
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1030  				.data = data,
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1031  				.data_end = data + hlen,
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1032  			};
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1033  			__be16 n_proto = proto;
695c12147a4018 Jakub Sitnicki      2020-06-25  1034  			struct bpf_prog *prog;
0ba985024ae7db Shmulik Ladkani     2022-08-21  1035  			u32 result;
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1036  
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1037  			if (skb) {
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1038  				ctx.skb = skb;
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1039  				/* we can't use 'proto' in the skb case
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1040  				 * because it might be set to skb->vlan_proto
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1041  				 * which has been pulled from the data
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1042  				 */
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1043  				n_proto = skb->protocol;
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1044  			}
9b52e3f267a683 Stanislav Fomichev  2019-04-22  1045  
695c12147a4018 Jakub Sitnicki      2020-06-25  1046  			prog = READ_ONCE(run_array->items[0].prog);
0ba985024ae7db Shmulik Ladkani     2022-08-21  1047  			result = bpf_flow_dissect(prog, &ctx, n_proto, nhoff,
086f95682114fd Stanislav Fomichev  2019-07-25  1048  						  hlen, flags);
91350fe152930c Shmulik Ladkani     2022-08-21  1049  			if (result == BPF_FLOW_DISSECTOR_CONTINUE)
91350fe152930c Shmulik Ladkani     2022-08-21  1050  				goto dissect_continue;
d58e468b1112dc Petar Penkov        2018-09-14  1051  			__skb_flow_bpf_to_target(&flow_keys, flow_dissector,
d58e468b1112dc Petar Penkov        2018-09-14  1052  						 target_container);
d58e468b1112dc Petar Penkov        2018-09-14  1053  			rcu_read_unlock();
0ba985024ae7db Shmulik Ladkani     2022-08-21  1054  			return result == BPF_OK;
d58e468b1112dc Petar Penkov        2018-09-14  1055  		}
91350fe152930c Shmulik Ladkani     2022-08-21  1056  dissect_continue:
d58e468b1112dc Petar Penkov        2018-09-14  1057  		rcu_read_unlock();
c8aa703822bf81 Stanislav Fomichev  2019-01-28  1058  	}
d58e468b1112dc Petar Penkov        2018-09-14  1059  
20a17bf6c04e3e David S. Miller     2015-09-01  1060  	if (dissector_uses_key(flow_dissector,
67a900cc0436d7 Jiri Pirko          2015-05-12  1061  			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
67a900cc0436d7 Jiri Pirko          2015-05-12  1062  		struct ethhdr *eth = eth_hdr(skb);
67a900cc0436d7 Jiri Pirko          2015-05-12  1063  		struct flow_dissector_key_eth_addrs *key_eth_addrs;
67a900cc0436d7 Jiri Pirko          2015-05-12  1064  
67a900cc0436d7 Jiri Pirko          2015-05-12  1065  		key_eth_addrs = skb_flow_dissector_target(flow_dissector,
67a900cc0436d7 Jiri Pirko          2015-05-12  1066  							  FLOW_DISSECTOR_KEY_ETH_ADDRS,
67a900cc0436d7 Jiri Pirko          2015-05-12  1067  							  target_container);
1b808993e19447 Jakub Kicinski      2022-04-06  1068  		memcpy(key_eth_addrs, eth, sizeof(*key_eth_addrs));
67a900cc0436d7 Jiri Pirko          2015-05-12  1069  	}
67a900cc0436d7 Jiri Pirko          2015-05-12  1070  
34951fcf26c59e Boris Sukholitko    2022-04-19  1071  	if (dissector_uses_key(flow_dissector,
34951fcf26c59e Boris Sukholitko    2022-04-19  1072  			       FLOW_DISSECTOR_KEY_NUM_OF_VLANS)) {
34951fcf26c59e Boris Sukholitko    2022-04-19  1073  		struct flow_dissector_key_num_of_vlans *key_num_of_vlans;
34951fcf26c59e Boris Sukholitko    2022-04-19  1074  
34951fcf26c59e Boris Sukholitko    2022-04-19  1075  		key_num_of_vlans = skb_flow_dissector_target(flow_dissector,
34951fcf26c59e Boris Sukholitko    2022-04-19  1076  							     FLOW_DISSECTOR_KEY_NUM_OF_VLANS,
34951fcf26c59e Boris Sukholitko    2022-04-19  1077  							     target_container);
34951fcf26c59e Boris Sukholitko    2022-04-19  1078  		key_num_of_vlans->num_of_vlans = 0;
34951fcf26c59e Boris Sukholitko    2022-04-19  1079  	}
34951fcf26c59e Boris Sukholitko    2022-04-19  1080  
c5ef188e931869 Jiri Pirko          2017-03-06  1081  proto_again:
3a1214e8b06317 Tom Herbert         2017-09-01  1082  	fdret = FLOW_DISSECT_RET_CONTINUE;
3a1214e8b06317 Tom Herbert         2017-09-01  1083  
0744dd00c1b1be Eric Dumazet        2011-11-28  1084  	switch (proto) {
2b8837aeaaa0bb Joe Perches         2014-03-12  1085  	case htons(ETH_P_IP): {
0744dd00c1b1be Eric Dumazet        2011-11-28  1086  		const struct iphdr *iph;
0744dd00c1b1be Eric Dumazet        2011-11-28  1087  		struct iphdr _iph;
3a1214e8b06317 Tom Herbert         2017-09-01  1088  
690e36e726d00d David S. Miller     2014-08-23  1089  		iph = __skb_header_pointer(skb, nhoff, sizeof(_iph), data, hlen, &_iph);
3a1214e8b06317 Tom Herbert         2017-09-01  1090  		if (!iph || iph->ihl < 5) {
3a1214e8b06317 Tom Herbert         2017-09-01  1091  			fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert         2017-09-01  1092  			break;
3a1214e8b06317 Tom Herbert         2017-09-01  1093  		}
3a1214e8b06317 Tom Herbert         2017-09-01  1094  
3797d3e8462efd Eric Dumazet        2013-11-07  1095  		nhoff += iph->ihl * 4;
0744dd00c1b1be Eric Dumazet        2011-11-28  1096  
3797d3e8462efd Eric Dumazet        2013-11-07  1097  		ip_proto = iph->protocol;
3797d3e8462efd Eric Dumazet        2013-11-07  1098  
918c023f29ab2d Alexander Duyck     2016-02-24  1099  		if (dissector_uses_key(flow_dissector,
918c023f29ab2d Alexander Duyck     2016-02-24  1100  				       FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
06635a35d13d42 Jiri Pirko          2015-05-12  1101  			key_addrs = skb_flow_dissector_target(flow_dissector,
918c023f29ab2d Alexander Duyck     2016-02-24  1102  							      FLOW_DISSECTOR_KEY_IPV4_ADDRS,
918c023f29ab2d Alexander Duyck     2016-02-24  1103  							      target_container);
918c023f29ab2d Alexander Duyck     2016-02-24  1104  
323e0cb473e2a8 Gustavo A. R. Silva 2021-07-26  1105  			memcpy(&key_addrs->v4addrs.src, &iph->saddr,
323e0cb473e2a8 Gustavo A. R. Silva 2021-07-26  1106  			       sizeof(key_addrs->v4addrs.src));
323e0cb473e2a8 Gustavo A. R. Silva 2021-07-26  1107  			memcpy(&key_addrs->v4addrs.dst, &iph->daddr,
323e0cb473e2a8 Gustavo A. R. Silva 2021-07-26  1108  			       sizeof(key_addrs->v4addrs.dst));
c3f8324188fa80 Tom Herbert         2015-06-04  1109  			key_control->addr_type = FLOW_DISSECTOR_KEY_IPV4_ADDRS;
918c023f29ab2d Alexander Duyck     2016-02-24  1110  		}
807e165dc44fd9 Tom Herbert         2015-09-01  1111  
d2126838050ccd Davide Caratti      2021-02-12  1112  		__skb_flow_dissect_ipv4(skb, flow_dissector,
d2126838050ccd Davide Caratti      2021-02-12  1113  					target_container, data, iph);
d2126838050ccd Davide Caratti      2021-02-12  1114  
807e165dc44fd9 Tom Herbert         2015-09-01  1115  		if (ip_is_fragment(iph)) {
4b36993d3df083 David S. Miller     2015-09-01  1116  			key_control->flags |= FLOW_DIS_IS_FRAGMENT;
807e165dc44fd9 Tom Herbert         2015-09-01  1117  
807e165dc44fd9 Tom Herbert         2015-09-01  1118  			if (iph->frag_off & htons(IP_OFFSET)) {
3a1214e8b06317 Tom Herbert         2017-09-01  1119  				fdret = FLOW_DISSECT_RET_OUT_GOOD;
3a1214e8b06317 Tom Herbert         2017-09-01  1120  				break;
807e165dc44fd9 Tom Herbert         2015-09-01  1121  			} else {
4b36993d3df083 David S. Miller     2015-09-01  1122  				key_control->flags |= FLOW_DIS_FIRST_FRAG;
3a1214e8b06317 Tom Herbert         2017-09-01  1123  				if (!(flags &
3a1214e8b06317 Tom Herbert         2017-09-01  1124  				      FLOW_DISSECTOR_F_PARSE_1ST_FRAG)) {
3a1214e8b06317 Tom Herbert         2017-09-01  1125  					fdret = FLOW_DISSECT_RET_OUT_GOOD;
3a1214e8b06317 Tom Herbert         2017-09-01  1126  					break;
3a1214e8b06317 Tom Herbert         2017-09-01  1127  				}
807e165dc44fd9 Tom Herbert         2015-09-01  1128  			}
807e165dc44fd9 Tom Herbert         2015-09-01  1129  		}
807e165dc44fd9 Tom Herbert         2015-09-01  1130  
0744dd00c1b1be Eric Dumazet        2011-11-28  1131  		break;
0744dd00c1b1be Eric Dumazet        2011-11-28  1132  	}
2b8837aeaaa0bb Joe Perches         2014-03-12  1133  	case htons(ETH_P_IPV6): {
0744dd00c1b1be Eric Dumazet        2011-11-28  1134  		const struct ipv6hdr *iph;
0744dd00c1b1be Eric Dumazet        2011-11-28  1135  		struct ipv6hdr _iph;
19469a873bafd4 Tom Herbert         2014-07-01  1136  
690e36e726d00d David S. Miller     2014-08-23  1137  		iph = __skb_header_pointer(skb, nhoff, sizeof(_iph), data, hlen, &_iph);
3a1214e8b06317 Tom Herbert         2017-09-01  1138  		if (!iph) {
3a1214e8b06317 Tom Herbert         2017-09-01  1139  			fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert         2017-09-01  1140  			break;
3a1214e8b06317 Tom Herbert         2017-09-01  1141  		}
0744dd00c1b1be Eric Dumazet        2011-11-28  1142  
0744dd00c1b1be Eric Dumazet        2011-11-28  1143  		ip_proto = iph->nexthdr;
0744dd00c1b1be Eric Dumazet        2011-11-28  1144  		nhoff += sizeof(struct ipv6hdr);
19469a873bafd4 Tom Herbert         2014-07-01  1145  
20a17bf6c04e3e David S. Miller     2015-09-01  1146  		if (dissector_uses_key(flow_dissector,
b924933cbbfbdc Jiri Pirko          2015-05-12  1147  				       FLOW_DISSECTOR_KEY_IPV6_ADDRS)) {
b3c3106ce3f464 Alexander Duyck     2016-02-24  1148  			key_addrs = skb_flow_dissector_target(flow_dissector,
b924933cbbfbdc Jiri Pirko          2015-05-12  1149  							      FLOW_DISSECTOR_KEY_IPV6_ADDRS,
b924933cbbfbdc Jiri Pirko          2015-05-12  1150  							      target_container);
b924933cbbfbdc Jiri Pirko          2015-05-12  1151  
323e0cb473e2a8 Gustavo A. R. Silva 2021-07-26  1152  			memcpy(&key_addrs->v6addrs.src, &iph->saddr,
323e0cb473e2a8 Gustavo A. R. Silva 2021-07-26  1153  			       sizeof(key_addrs->v6addrs.src));
323e0cb473e2a8 Gustavo A. R. Silva 2021-07-26  1154  			memcpy(&key_addrs->v6addrs.dst, &iph->daddr,
323e0cb473e2a8 Gustavo A. R. Silva 2021-07-26  1155  			       sizeof(key_addrs->v6addrs.dst));
c3f8324188fa80 Tom Herbert         2015-06-04  1156  			key_control->addr_type = FLOW_DISSECTOR_KEY_IPV6_ADDRS;
b924933cbbfbdc Jiri Pirko          2015-05-12  1157  		}
87ee9e52ffeb16 Tom Herbert         2015-06-04  1158  
461547f3158978 Alexander Duyck     2016-02-09  1159  		if ((dissector_uses_key(flow_dissector,
461547f3158978 Alexander Duyck     2016-02-09  1160  					FLOW_DISSECTOR_KEY_FLOW_LABEL) ||
461547f3158978 Alexander Duyck     2016-02-09  1161  		     (flags & FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL)) &&
461547f3158978 Alexander Duyck     2016-02-09  1162  		    ip6_flowlabel(iph)) {
461547f3158978 Alexander Duyck     2016-02-09  1163  			__be32 flow_label = ip6_flowlabel(iph);
461547f3158978 Alexander Duyck     2016-02-09  1164  
20a17bf6c04e3e David S. Miller     2015-09-01  1165  			if (dissector_uses_key(flow_dissector,
87ee9e52ffeb16 Tom Herbert         2015-06-04  1166  					       FLOW_DISSECTOR_KEY_FLOW_LABEL)) {
87ee9e52ffeb16 Tom Herbert         2015-06-04  1167  				key_tags = skb_flow_dissector_target(flow_dissector,
87ee9e52ffeb16 Tom Herbert         2015-06-04  1168  								     FLOW_DISSECTOR_KEY_FLOW_LABEL,
06635a35d13d42 Jiri Pirko          2015-05-12  1169  								     target_container);
87ee9e52ffeb16 Tom Herbert         2015-06-04  1170  				key_tags->flow_label = ntohl(flow_label);
12c227ec89a70c Jiri Pirko          2015-05-22  1171  			}
3a1214e8b06317 Tom Herbert         2017-09-01  1172  			if (flags & FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL) {
3a1214e8b06317 Tom Herbert         2017-09-01  1173  				fdret = FLOW_DISSECT_RET_OUT_GOOD;
3a1214e8b06317 Tom Herbert         2017-09-01  1174  				break;
3a1214e8b06317 Tom Herbert         2017-09-01  1175  			}
19469a873bafd4 Tom Herbert         2014-07-01  1176  		}
19469a873bafd4 Tom Herbert         2014-07-01  1177  
518d8a2e9bad83 Or Gerlitz          2017-06-01  1178  		__skb_flow_dissect_ipv6(skb, flow_dissector,
518d8a2e9bad83 Or Gerlitz          2017-06-01  1179  					target_container, data, iph);
518d8a2e9bad83 Or Gerlitz          2017-06-01  1180  
0744dd00c1b1be Eric Dumazet        2011-11-28  1181  		break;
0744dd00c1b1be Eric Dumazet        2011-11-28  1182  	}
2b8837aeaaa0bb Joe Perches         2014-03-12  1183  	case htons(ETH_P_8021AD):
2b8837aeaaa0bb Joe Perches         2014-03-12  1184  	case htons(ETH_P_8021Q): {
24c590e3b0f9ee Jianbo Liu          2018-07-06  1185  		const struct vlan_hdr *vlan = NULL;
bc72f3dd89e087 Arnd Bergmann       2016-10-24  1186  		struct vlan_hdr _vlan;
2064c3d4c02026 Jianbo Liu          2018-07-06  1187  		__be16 saved_vlan_tpid = proto;
d5709f7ab77679 Hadar Hen Zion      2016-08-17  1188  
24c590e3b0f9ee Jianbo Liu          2018-07-06  1189  		if (dissector_vlan == FLOW_DISSECTOR_KEY_MAX &&
24c590e3b0f9ee Jianbo Liu          2018-07-06  1190  		    skb && skb_vlan_tag_present(skb)) {
d5709f7ab77679 Hadar Hen Zion      2016-08-17  1191  			proto = skb->protocol;
24c590e3b0f9ee Jianbo Liu          2018-07-06  1192  		} else {
d5709f7ab77679 Hadar Hen Zion      2016-08-17  1193  			vlan = __skb_header_pointer(skb, nhoff, sizeof(_vlan),
d5709f7ab77679 Hadar Hen Zion      2016-08-17  1194  						    data, hlen, &_vlan);
3a1214e8b06317 Tom Herbert         2017-09-01  1195  			if (!vlan) {
3a1214e8b06317 Tom Herbert         2017-09-01  1196  				fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert         2017-09-01  1197  				break;
3a1214e8b06317 Tom Herbert         2017-09-01  1198  			}
3a1214e8b06317 Tom Herbert         2017-09-01  1199  
d5709f7ab77679 Hadar Hen Zion      2016-08-17  1200  			proto = vlan->h_vlan_encapsulated_proto;
d5709f7ab77679 Hadar Hen Zion      2016-08-17  1201  			nhoff += sizeof(*vlan);
24c590e3b0f9ee Jianbo Liu          2018-07-06  1202  		}
24c590e3b0f9ee Jianbo Liu          2018-07-06  1203  
34951fcf26c59e Boris Sukholitko    2022-04-19  1204  		if (dissector_uses_key(flow_dissector,
34951fcf26c59e Boris Sukholitko    2022-04-19  1205  				       FLOW_DISSECTOR_KEY_NUM_OF_VLANS)) {
34951fcf26c59e Boris Sukholitko    2022-04-19  1206  			struct flow_dissector_key_num_of_vlans *key_nvs;
34951fcf26c59e Boris Sukholitko    2022-04-19  1207  
34951fcf26c59e Boris Sukholitko    2022-04-19  1208  			key_nvs = skb_flow_dissector_target(flow_dissector,
34951fcf26c59e Boris Sukholitko    2022-04-19  1209  							    FLOW_DISSECTOR_KEY_NUM_OF_VLANS,
34951fcf26c59e Boris Sukholitko    2022-04-19  1210  							    target_container);
34951fcf26c59e Boris Sukholitko    2022-04-19  1211  			key_nvs->num_of_vlans++;
34951fcf26c59e Boris Sukholitko    2022-04-19  1212  		}
34951fcf26c59e Boris Sukholitko    2022-04-19  1213  
24c590e3b0f9ee Jianbo Liu          2018-07-06  1214  		if (dissector_vlan == FLOW_DISSECTOR_KEY_MAX) {
24c590e3b0f9ee Jianbo Liu          2018-07-06  1215  			dissector_vlan = FLOW_DISSECTOR_KEY_VLAN;
24c590e3b0f9ee Jianbo Liu          2018-07-06  1216  		} else if (dissector_vlan == FLOW_DISSECTOR_KEY_VLAN) {
24c590e3b0f9ee Jianbo Liu          2018-07-06  1217  			dissector_vlan = FLOW_DISSECTOR_KEY_CVLAN;
24c590e3b0f9ee Jianbo Liu          2018-07-06  1218  		} else {
3a1214e8b06317 Tom Herbert         2017-09-01  1219  			fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
3a1214e8b06317 Tom Herbert         2017-09-01  1220  			break;
3a1214e8b06317 Tom Herbert         2017-09-01  1221  		}
0744dd00c1b1be Eric Dumazet        2011-11-28  1222  
24c590e3b0f9ee Jianbo Liu          2018-07-06  1223  		if (dissector_uses_key(flow_dissector, dissector_vlan)) {
f6a66927692e30 Hadar Hen Zion      2016-08-17  1224  			key_vlan = skb_flow_dissector_target(flow_dissector,
24c590e3b0f9ee Jianbo Liu          2018-07-06  1225  							     dissector_vlan,
d34af823ff401c Tom Herbert         2015-06-04  1226  							     target_container);
d34af823ff401c Tom Herbert         2015-06-04  1227  
24c590e3b0f9ee Jianbo Liu          2018-07-06  1228  			if (!vlan) {
f6a66927692e30 Hadar Hen Zion      2016-08-17  1229  				key_vlan->vlan_id = skb_vlan_tag_get_id(skb);
9b319148cb34ec Michał Mirosław     2018-11-07  1230  				key_vlan->vlan_priority = skb_vlan_tag_get_prio(skb);
f6a66927692e30 Hadar Hen Zion      2016-08-17  1231  			} else {
f6a66927692e30 Hadar Hen Zion      2016-08-17  1232  				key_vlan->vlan_id = ntohs(vlan->h_vlan_TCI) &
d5709f7ab77679 Hadar Hen Zion      2016-08-17  1233  					VLAN_VID_MASK;
f6a66927692e30 Hadar Hen Zion      2016-08-17  1234  				key_vlan->vlan_priority =
f6a66927692e30 Hadar Hen Zion      2016-08-17  1235  					(ntohs(vlan->h_vlan_TCI) &
f6a66927692e30 Hadar Hen Zion      2016-08-17  1236  					 VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT;
f6a66927692e30 Hadar Hen Zion      2016-08-17  1237  			}
2064c3d4c02026 Jianbo Liu          2018-07-06  1238  			key_vlan->vlan_tpid = saved_vlan_tpid;
2105f700b53c24 Vlad Buslov         2022-04-06  1239  			key_vlan->vlan_eth_type = proto;
d34af823ff401c Tom Herbert         2015-06-04  1240  		}
d34af823ff401c Tom Herbert         2015-06-04  1241  
3a1214e8b06317 Tom Herbert         2017-09-01  1242  		fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
3a1214e8b06317 Tom Herbert         2017-09-01  1243  		break;
0744dd00c1b1be Eric Dumazet        2011-11-28  1244  	}
2b8837aeaaa0bb Joe Perches         2014-03-12  1245  	case htons(ETH_P_PPP_SES): {
0744dd00c1b1be Eric Dumazet        2011-11-28  1246  		struct {
0744dd00c1b1be Eric Dumazet        2011-11-28  1247  			struct pppoe_hdr hdr;
0744dd00c1b1be Eric Dumazet        2011-11-28  1248  			__be16 proto;
0744dd00c1b1be Eric Dumazet        2011-11-28  1249  		} *hdr, _hdr;
46126db9c86110 Wojciech Drewek     2022-07-18  1250  		u16 ppp_proto;
46126db9c86110 Wojciech Drewek     2022-07-18  1251  
690e36e726d00d David S. Miller     2014-08-23  1252  		hdr = __skb_header_pointer(skb, nhoff, sizeof(_hdr), data, hlen, &_hdr);
3a1214e8b06317 Tom Herbert         2017-09-01  1253  		if (!hdr) {
3a1214e8b06317 Tom Herbert         2017-09-01  1254  			fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert         2017-09-01  1255  			break;
3a1214e8b06317 Tom Herbert         2017-09-01  1256  		}
3a1214e8b06317 Tom Herbert         2017-09-01  1257  
f86d1fbbe78588 Linus Torvalds      2022-08-03  1258  		if (!is_pppoe_ses_hdr_valid(&hdr->hdr)) {
46126db9c86110 Wojciech Drewek     2022-07-18  1259  			fdret = FLOW_DISSECT_RET_OUT_BAD;
46126db9c86110 Wojciech Drewek     2022-07-18  1260  			break;
46126db9c86110 Wojciech Drewek     2022-07-18  1261  		}
46126db9c86110 Wojciech Drewek     2022-07-18  1262  
46126db9c86110 Wojciech Drewek     2022-07-18  1263  		/* least significant bit of the most significant octet
46126db9c86110 Wojciech Drewek     2022-07-18  1264  		 * indicates if protocol field was compressed
46126db9c86110 Wojciech Drewek     2022-07-18  1265  		 */
46126db9c86110 Wojciech Drewek     2022-07-18  1266  		ppp_proto = ntohs(hdr->proto);
46126db9c86110 Wojciech Drewek     2022-07-18  1267  		if (ppp_proto & 0x0100) {
46126db9c86110 Wojciech Drewek     2022-07-18  1268  			ppp_proto = ppp_proto >> 8;
46126db9c86110 Wojciech Drewek     2022-07-18  1269  			nhoff += PPPOE_SES_HLEN - 1;
46126db9c86110 Wojciech Drewek     2022-07-18  1270  		} else {
0744dd00c1b1be Eric Dumazet        2011-11-28  1271  			nhoff += PPPOE_SES_HLEN;
46126db9c86110 Wojciech Drewek     2022-07-18  1272  		}
46126db9c86110 Wojciech Drewek     2022-07-18  1273  
46126db9c86110 Wojciech Drewek     2022-07-18  1274  		if (ppp_proto == PPP_IP) {
3a1214e8b06317 Tom Herbert         2017-09-01  1275  			proto = htons(ETH_P_IP);
3a1214e8b06317 Tom Herbert         2017-09-01  1276  			fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
46126db9c86110 Wojciech Drewek     2022-07-18  1277  		} else if (ppp_proto == PPP_IPV6) {
3a1214e8b06317 Tom Herbert         2017-09-01  1278  			proto = htons(ETH_P_IPV6);
3a1214e8b06317 Tom Herbert         2017-09-01  1279  			fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
46126db9c86110 Wojciech Drewek     2022-07-18  1280  		} else if (ppp_proto == PPP_MPLS_UC) {
46126db9c86110 Wojciech Drewek     2022-07-18  1281  			proto = htons(ETH_P_MPLS_UC);
46126db9c86110 Wojciech Drewek     2022-07-18  1282  			fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
46126db9c86110 Wojciech Drewek     2022-07-18  1283  		} else if (ppp_proto == PPP_MPLS_MC) {
46126db9c86110 Wojciech Drewek     2022-07-18  1284  			proto = htons(ETH_P_MPLS_MC);
46126db9c86110 Wojciech Drewek     2022-07-18  1285  			fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
46126db9c86110 Wojciech Drewek     2022-07-18  1286  		} else if (ppp_proto_is_valid(ppp_proto)) {
46126db9c86110 Wojciech Drewek     2022-07-18  1287  			fdret = FLOW_DISSECT_RET_OUT_GOOD;
46126db9c86110 Wojciech Drewek     2022-07-18  1288  		} else {
3a1214e8b06317 Tom Herbert         2017-09-01  1289  			fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert         2017-09-01  1290  			break;
0744dd00c1b1be Eric Dumazet        2011-11-28  1291  		}
46126db9c86110 Wojciech Drewek     2022-07-18  1292  
46126db9c86110 Wojciech Drewek     2022-07-18  1293  		if (dissector_uses_key(flow_dissector,
46126db9c86110 Wojciech Drewek     2022-07-18  1294  				       FLOW_DISSECTOR_KEY_PPPOE)) {
46126db9c86110 Wojciech Drewek     2022-07-18  1295  			struct flow_dissector_key_pppoe *key_pppoe;
46126db9c86110 Wojciech Drewek     2022-07-18  1296  
46126db9c86110 Wojciech Drewek     2022-07-18  1297  			key_pppoe = skb_flow_dissector_target(flow_dissector,
46126db9c86110 Wojciech Drewek     2022-07-18  1298  							      FLOW_DISSECTOR_KEY_PPPOE,
46126db9c86110 Wojciech Drewek     2022-07-18  1299  							      target_container);
46126db9c86110 Wojciech Drewek     2022-07-18  1300  			key_pppoe->session_id = hdr->hdr.sid;
46126db9c86110 Wojciech Drewek     2022-07-18  1301  			key_pppoe->ppp_proto = htons(ppp_proto);
46126db9c86110 Wojciech Drewek     2022-07-18  1302  			key_pppoe->type = htons(ETH_P_PPP_SES);
46126db9c86110 Wojciech Drewek     2022-07-18  1303  		}
3a1214e8b06317 Tom Herbert         2017-09-01  1304  		break;
0744dd00c1b1be Eric Dumazet        2011-11-28  1305  	}
08bfc9cb76e26d Erik Hugne          2015-01-22  1306  	case htons(ETH_P_TIPC): {
8d6e79d3ce13e3 Jon Maloy           2017-11-08  1307  		struct tipc_basic_hdr *hdr, _hdr;
8d6e79d3ce13e3 Jon Maloy           2017-11-08  1308  
8d6e79d3ce13e3 Jon Maloy           2017-11-08  1309  		hdr = __skb_header_pointer(skb, nhoff, sizeof(_hdr),
8d6e79d3ce13e3 Jon Maloy           2017-11-08  1310  					   data, hlen, &_hdr);
3a1214e8b06317 Tom Herbert         2017-09-01  1311  		if (!hdr) {
3a1214e8b06317 Tom Herbert         2017-09-01  1312  			fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert         2017-09-01  1313  			break;
3a1214e8b06317 Tom Herbert         2017-09-01  1314  		}
06635a35d13d42 Jiri Pirko          2015-05-12  1315  
20a17bf6c04e3e David S. Miller     2015-09-01  1316  		if (dissector_uses_key(flow_dissector,
8d6e79d3ce13e3 Jon Maloy           2017-11-08  1317  				       FLOW_DISSECTOR_KEY_TIPC)) {
06635a35d13d42 Jiri Pirko          2015-05-12  1318  			key_addrs = skb_flow_dissector_target(flow_dissector,
8d6e79d3ce13e3 Jon Maloy           2017-11-08  1319  							      FLOW_DISSECTOR_KEY_TIPC,
06635a35d13d42 Jiri Pirko          2015-05-12  1320  							      target_container);
8d6e79d3ce13e3 Jon Maloy           2017-11-08  1321  			key_addrs->tipckey.key = tipc_hdr_rps_key(hdr);
8d6e79d3ce13e3 Jon Maloy           2017-11-08  1322  			key_control->addr_type = FLOW_DISSECTOR_KEY_TIPC;
06635a35d13d42 Jiri Pirko          2015-05-12  1323  		}
3a1214e8b06317 Tom Herbert         2017-09-01  1324  		fdret = FLOW_DISSECT_RET_OUT_GOOD;
3a1214e8b06317 Tom Herbert         2017-09-01  1325  		break;
08bfc9cb76e26d Erik Hugne          2015-01-22  1326  	}
b3baa0fbd02a1a Tom Herbert         2015-06-04  1327  
b3baa0fbd02a1a Tom Herbert         2015-06-04  1328  	case htons(ETH_P_MPLS_UC):
4a5d6c8b14b81e Jiri Pirko          2017-03-06  1329  	case htons(ETH_P_MPLS_MC):
3a1214e8b06317 Tom Herbert         2017-09-01  1330  		fdret = __skb_flow_dissect_mpls(skb, flow_dissector,
4a5d6c8b14b81e Jiri Pirko          2017-03-06  1331  						target_container, data,
58cff782cc55eb Guillaume Nault     2020-05-26  1332  						nhoff, hlen, mpls_lse,
58cff782cc55eb Guillaume Nault     2020-05-26  1333  						&mpls_el);
58cff782cc55eb Guillaume Nault     2020-05-26  1334  		nhoff += sizeof(struct mpls_label);
58cff782cc55eb Guillaume Nault     2020-05-26  1335  		mpls_lse++;
3a1214e8b06317 Tom Herbert         2017-09-01  1336  		break;
56193d1bce2b27 Alexander Duyck     2014-09-05  1337  	case htons(ETH_P_FCOE):
3a1214e8b06317 Tom Herbert         2017-09-01  1338  		if ((hlen - nhoff) < FCOE_HEADER_LEN) {
3a1214e8b06317 Tom Herbert         2017-09-01  1339  			fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert         2017-09-01  1340  			break;
3a1214e8b06317 Tom Herbert         2017-09-01  1341  		}
224516b3a798a0 Alexander Duyck     2016-02-24  1342  
224516b3a798a0 Alexander Duyck     2016-02-24  1343  		nhoff += FCOE_HEADER_LEN;
3a1214e8b06317 Tom Herbert         2017-09-01  1344  		fdret = FLOW_DISSECT_RET_OUT_GOOD;
3a1214e8b06317 Tom Herbert         2017-09-01  1345  		break;
55733350e5e8b7 Simon Horman        2017-01-11  1346  
55733350e5e8b7 Simon Horman        2017-01-11  1347  	case htons(ETH_P_ARP):
9bf881ffc5c0e6 Jiri Pirko          2017-03-06  1348  	case htons(ETH_P_RARP):
3a1214e8b06317 Tom Herbert         2017-09-01  1349  		fdret = __skb_flow_dissect_arp(skb, flow_dissector,
9bf881ffc5c0e6 Jiri Pirko          2017-03-06  1350  					       target_container, data,
3a1214e8b06317 Tom Herbert         2017-09-01  1351  					       nhoff, hlen);
3a1214e8b06317 Tom Herbert         2017-09-01  1352  		break;
3a1214e8b06317 Tom Herbert         2017-09-01  1353  
5b0890a9720462 Sven Eckelmann      2017-12-21  1354  	case htons(ETH_P_BATMAN):
5b0890a9720462 Sven Eckelmann      2017-12-21  1355  		fdret = __skb_flow_dissect_batadv(skb, key_control, data,
5b0890a9720462 Sven Eckelmann      2017-12-21  1356  						  &proto, &nhoff, hlen, flags);
5b0890a9720462 Sven Eckelmann      2017-12-21  1357  		break;
5b0890a9720462 Sven Eckelmann      2017-12-21  1358  
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1359  	case htons(ETH_P_1588): {
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1360  		struct ptp_header *hdr, _hdr;
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1361  
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1362  		hdr = __skb_header_pointer(skb, nhoff, sizeof(_hdr), data,
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1363  					   hlen, &_hdr);
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1364  		if (!hdr) {
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1365  			fdret = FLOW_DISSECT_RET_OUT_BAD;
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1366  			break;
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1367  		}
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1368  
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1369  		nhoff += ntohs(hdr->message_length);
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1370  		fdret = FLOW_DISSECT_RET_OUT_GOOD;
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1371  		break;
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1372  	}
4f1cc51f34886d Eran Ben Elisha     2021-01-12  1373  
f65e58440d4fca Kurt Kanzenbach     2022-03-10  1374  	case htons(ETH_P_PRP):
bf08824a0f4776 Kurt Kanzenbach     2022-02-28  1375  	case htons(ETH_P_HSR): {
bf08824a0f4776 Kurt Kanzenbach     2022-02-28  1376  		struct hsr_tag *hdr, _hdr;
bf08824a0f4776 Kurt Kanzenbach     2022-02-28  1377  
bf08824a0f4776 Kurt Kanzenbach     2022-02-28  1378  		hdr = __skb_header_pointer(skb, nhoff, sizeof(_hdr), data, hlen,
bf08824a0f4776 Kurt Kanzenbach     2022-02-28  1379  					   &_hdr);
bf08824a0f4776 Kurt Kanzenbach     2022-02-28  1380  		if (!hdr) {
bf08824a0f4776 Kurt Kanzenbach     2022-02-28  1381  			fdret = FLOW_DISSECT_RET_OUT_BAD;
bf08824a0f4776 Kurt Kanzenbach     2022-02-28  1382  			break;
bf08824a0f4776 Kurt Kanzenbach     2022-02-28  1383  		}
bf08824a0f4776 Kurt Kanzenbach     2022-02-28  1384  
bf08824a0f4776 Kurt Kanzenbach     2022-02-28  1385  		proto = hdr->encap_proto;
bf08824a0f4776 Kurt Kanzenbach     2022-02-28  1386  		nhoff += HSR_HLEN;
bf08824a0f4776 Kurt Kanzenbach     2022-02-28  1387  		fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
bf08824a0f4776 Kurt Kanzenbach     2022-02-28  1388  		break;
bf08824a0f4776 Kurt Kanzenbach     2022-02-28  1389  	}
bf08824a0f4776 Kurt Kanzenbach     2022-02-28  1390  
3a1214e8b06317 Tom Herbert         2017-09-01  1391  	default:
3a1214e8b06317 Tom Herbert         2017-09-01  1392  		fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert         2017-09-01  1393  		break;
3a1214e8b06317 Tom Herbert         2017-09-01  1394  	}
3a1214e8b06317 Tom Herbert         2017-09-01  1395  
3a1214e8b06317 Tom Herbert         2017-09-01  1396  	/* Process result of proto processing */
3a1214e8b06317 Tom Herbert         2017-09-01  1397  	switch (fdret) {
9bf881ffc5c0e6 Jiri Pirko          2017-03-06  1398  	case FLOW_DISSECT_RET_OUT_GOOD:
55733350e5e8b7 Simon Horman        2017-01-11  1399  		goto out_good;
3a1214e8b06317 Tom Herbert         2017-09-01  1400  	case FLOW_DISSECT_RET_PROTO_AGAIN:
1eed4dfb81b193 Tom Herbert         2017-09-01  1401  		if (skb_flow_dissect_allowed(&num_hdrs))
3a1214e8b06317 Tom Herbert         2017-09-01  1402  			goto proto_again;
1eed4dfb81b193 Tom Herbert         2017-09-01  1403  		goto out_good;
3a1214e8b06317 Tom Herbert         2017-09-01  1404  	case FLOW_DISSECT_RET_CONTINUE:
3a1214e8b06317 Tom Herbert         2017-09-01  1405  	case FLOW_DISSECT_RET_IPPROTO_AGAIN:
3a1214e8b06317 Tom Herbert         2017-09-01  1406  		break;
9bf881ffc5c0e6 Jiri Pirko          2017-03-06  1407  	case FLOW_DISSECT_RET_OUT_BAD:
7c92de8eaabfff Jiri Pirko          2017-03-06  1408  	default:
9bf881ffc5c0e6 Jiri Pirko          2017-03-06  1409  		goto out_bad;
55733350e5e8b7 Simon Horman        2017-01-11  1410  	}
0744dd00c1b1be Eric Dumazet        2011-11-28  1411  
6a74fcf426f51a Tom Herbert         2015-06-12  1412  ip_proto_again:
3a1214e8b06317 Tom Herbert         2017-09-01  1413  	fdret = FLOW_DISSECT_RET_CONTINUE;
3a1214e8b06317 Tom Herbert         2017-09-01  1414  
0744dd00c1b1be Eric Dumazet        2011-11-28  1415  	switch (ip_proto) {
7c92de8eaabfff Jiri Pirko          2017-03-06  1416  	case IPPROTO_GRE:
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1417  		if (flags & FLOW_DISSECTOR_F_STOP_BEFORE_ENCAP) {
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1418  			fdret = FLOW_DISSECT_RET_OUT_GOOD;
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1419  			break;
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1420  		}
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1421  
3a1214e8b06317 Tom Herbert         2017-09-01  1422  		fdret = __skb_flow_dissect_gre(skb, key_control, flow_dissector,
7c92de8eaabfff Jiri Pirko          2017-03-06  1423  					       target_container, data,
3a1214e8b06317 Tom Herbert         2017-09-01  1424  					       &proto, &nhoff, &hlen, flags);
3a1214e8b06317 Tom Herbert         2017-09-01  1425  		break;
3a1214e8b06317 Tom Herbert         2017-09-01  1426  
6a74fcf426f51a Tom Herbert         2015-06-12  1427  	case NEXTHDR_HOP:
6a74fcf426f51a Tom Herbert         2015-06-12  1428  	case NEXTHDR_ROUTING:
6a74fcf426f51a Tom Herbert         2015-06-12  1429  	case NEXTHDR_DEST: {
6a74fcf426f51a Tom Herbert         2015-06-12  1430  		u8 _opthdr[2], *opthdr;
6a74fcf426f51a Tom Herbert         2015-06-12  1431  
6a74fcf426f51a Tom Herbert         2015-06-12  1432  		if (proto != htons(ETH_P_IPV6))
6a74fcf426f51a Tom Herbert         2015-06-12  1433  			break;
6a74fcf426f51a Tom Herbert         2015-06-12  1434  
6a74fcf426f51a Tom Herbert         2015-06-12  1435  		opthdr = __skb_header_pointer(skb, nhoff, sizeof(_opthdr),
6a74fcf426f51a Tom Herbert         2015-06-12  1436  					      data, hlen, &_opthdr);
3a1214e8b06317 Tom Herbert         2017-09-01  1437  		if (!opthdr) {
3a1214e8b06317 Tom Herbert         2017-09-01  1438  			fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert         2017-09-01  1439  			break;
3a1214e8b06317 Tom Herbert         2017-09-01  1440  		}
6a74fcf426f51a Tom Herbert         2015-06-12  1441  
1e98a0f08abddd Eric Dumazet        2015-06-12  1442  		ip_proto = opthdr[0];
1e98a0f08abddd Eric Dumazet        2015-06-12  1443  		nhoff += (opthdr[1] + 1) << 3;
6a74fcf426f51a Tom Herbert         2015-06-12  1444  
3a1214e8b06317 Tom Herbert         2017-09-01  1445  		fdret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
3a1214e8b06317 Tom Herbert         2017-09-01  1446  		break;
6a74fcf426f51a Tom Herbert         2015-06-12  1447  	}
b840f28b908da0 Tom Herbert         2015-09-01  1448  	case NEXTHDR_FRAGMENT: {
b840f28b908da0 Tom Herbert         2015-09-01  1449  		struct frag_hdr _fh, *fh;
b840f28b908da0 Tom Herbert         2015-09-01  1450  
b840f28b908da0 Tom Herbert         2015-09-01  1451  		if (proto != htons(ETH_P_IPV6))
b840f28b908da0 Tom Herbert         2015-09-01  1452  			break;
b840f28b908da0 Tom Herbert         2015-09-01  1453  
b840f28b908da0 Tom Herbert         2015-09-01  1454  		fh = __skb_header_pointer(skb, nhoff, sizeof(_fh),
b840f28b908da0 Tom Herbert         2015-09-01  1455  					  data, hlen, &_fh);
b840f28b908da0 Tom Herbert         2015-09-01  1456  
3a1214e8b06317 Tom Herbert         2017-09-01  1457  		if (!fh) {
3a1214e8b06317 Tom Herbert         2017-09-01  1458  			fdret = FLOW_DISSECT_RET_OUT_BAD;
3a1214e8b06317 Tom Herbert         2017-09-01  1459  			break;
3a1214e8b06317 Tom Herbert         2017-09-01  1460  		}
b840f28b908da0 Tom Herbert         2015-09-01  1461  
4b36993d3df083 David S. Miller     2015-09-01  1462  		key_control->flags |= FLOW_DIS_IS_FRAGMENT;
b840f28b908da0 Tom Herbert         2015-09-01  1463  
b840f28b908da0 Tom Herbert         2015-09-01  1464  		nhoff += sizeof(_fh);
43d2ccb3c122a4 Alexander Duyck     2016-02-24  1465  		ip_proto = fh->nexthdr;
b840f28b908da0 Tom Herbert         2015-09-01  1466  
b840f28b908da0 Tom Herbert         2015-09-01  1467  		if (!(fh->frag_off & htons(IP6_OFFSET))) {
4b36993d3df083 David S. Miller     2015-09-01  1468  			key_control->flags |= FLOW_DIS_FIRST_FRAG;
3a1214e8b06317 Tom Herbert         2017-09-01  1469  			if (flags & FLOW_DISSECTOR_F_PARSE_1ST_FRAG) {
3a1214e8b06317 Tom Herbert         2017-09-01  1470  				fdret = FLOW_DISSECT_RET_IPPROTO_AGAIN;
3a1214e8b06317 Tom Herbert         2017-09-01  1471  				break;
b840f28b908da0 Tom Herbert         2015-09-01  1472  			}
3a1214e8b06317 Tom Herbert         2017-09-01  1473  		}
3a1214e8b06317 Tom Herbert         2017-09-01  1474  
3a1214e8b06317 Tom Herbert         2017-09-01  1475  		fdret = FLOW_DISSECT_RET_OUT_GOOD;
3a1214e8b06317 Tom Herbert         2017-09-01  1476  		break;
b840f28b908da0 Tom Herbert         2015-09-01  1477  	}
0744dd00c1b1be Eric Dumazet        2011-11-28  1478  	case IPPROTO_IPIP:
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1479  		if (flags & FLOW_DISSECTOR_F_STOP_BEFORE_ENCAP) {
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1480  			fdret = FLOW_DISSECT_RET_OUT_GOOD;
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1481  			break;
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1482  		}
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1483  
fca418955148e4 Tom Herbert         2013-07-29  1484  		proto = htons(ETH_P_IP);
823b96939578ea Tom Herbert         2015-09-01  1485  
4b36993d3df083 David S. Miller     2015-09-01  1486  		key_control->flags |= FLOW_DIS_ENCAPSULATION;
3a1214e8b06317 Tom Herbert         2017-09-01  1487  		if (flags & FLOW_DISSECTOR_F_STOP_AT_ENCAP) {
3a1214e8b06317 Tom Herbert         2017-09-01  1488  			fdret = FLOW_DISSECT_RET_OUT_GOOD;
3a1214e8b06317 Tom Herbert         2017-09-01  1489  			break;
3a1214e8b06317 Tom Herbert         2017-09-01  1490  		}
3a1214e8b06317 Tom Herbert         2017-09-01  1491  
3a1214e8b06317 Tom Herbert         2017-09-01  1492  		fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
3a1214e8b06317 Tom Herbert         2017-09-01  1493  		break;
823b96939578ea Tom Herbert         2015-09-01  1494  
b438f940d3541f Tom Herbert         2013-07-29  1495  	case IPPROTO_IPV6:
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1496  		if (flags & FLOW_DISSECTOR_F_STOP_BEFORE_ENCAP) {
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1497  			fdret = FLOW_DISSECT_RET_OUT_GOOD;
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1498  			break;
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1499  		}
6de6e46d27ef38 Yoshiki Komachi     2021-10-29  1500  
b438f940d3541f Tom Herbert         2013-07-29  1501  		proto = htons(ETH_P_IPV6);
823b96939578ea Tom Herbert         2015-09-01  1502  
4b36993d3df083 David S. Miller     2015-09-01  1503  		key_control->flags |= FLOW_DIS_ENCAPSULATION;
3a1214e8b06317 Tom Herbert         2017-09-01  1504  		if (flags & FLOW_DISSECTOR_F_STOP_AT_ENCAP) {
3a1214e8b06317 Tom Herbert         2017-09-01  1505  			fdret = FLOW_DISSECT_RET_OUT_GOOD;
3a1214e8b06317 Tom Herbert         2017-09-01  1506  			break;
3a1214e8b06317 Tom Herbert         2017-09-01  1507  		}
3a1214e8b06317 Tom Herbert         2017-09-01  1508  
3a1214e8b06317 Tom Herbert         2017-09-01  1509  		fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
3a1214e8b06317 Tom Herbert         2017-09-01  1510  		break;
3a1214e8b06317 Tom Herbert         2017-09-01  1511  
823b96939578ea Tom Herbert         2015-09-01  1512  
b3baa0fbd02a1a Tom Herbert         2015-06-04  1513  	case IPPROTO_MPLS:
b3baa0fbd02a1a Tom Herbert         2015-06-04  1514  		proto = htons(ETH_P_MPLS_UC);
3a1214e8b06317 Tom Herbert         2017-09-01  1515  		fdret = FLOW_DISSECT_RET_PROTO_AGAIN;
3a1214e8b06317 Tom Herbert         2017-09-01  1516  		break;
3a1214e8b06317 Tom Herbert         2017-09-01  1517  
ac4bb5de27010e Jiri Pirko          2017-05-23  1518  	case IPPROTO_TCP:
ac4bb5de27010e Jiri Pirko          2017-05-23  1519  		__skb_flow_dissect_tcp(skb, flow_dissector, target_container,
ac4bb5de27010e Jiri Pirko          2017-05-23  1520  				       data, nhoff, hlen);
ac4bb5de27010e Jiri Pirko          2017-05-23  1521  		break;
3a1214e8b06317 Tom Herbert         2017-09-01  1522  
3b336d6f4ec690 Matteo Croce        2019-10-29  1523  	case IPPROTO_ICMP:
3b336d6f4ec690 Matteo Croce        2019-10-29  1524  	case IPPROTO_ICMPV6:
3b336d6f4ec690 Matteo Croce        2019-10-29  1525  		__skb_flow_dissect_icmp(skb, flow_dissector, target_container,
3b336d6f4ec690 Matteo Croce        2019-10-29  1526  					data, nhoff, hlen);
3b336d6f4ec690 Matteo Croce        2019-10-29  1527  		break;
dda2fa08a13c68 Wojciech Drewek     2022-09-08  1528  	case IPPROTO_L2TP:
dda2fa08a13c68 Wojciech Drewek     2022-09-08  1529  		__skb_flow_dissect_l2tpv3(skb, flow_dissector, target_container,
dda2fa08a13c68 Wojciech Drewek     2022-09-08  1530  					  data, nhoff, hlen);
dda2fa08a13c68 Wojciech Drewek     2022-09-08  1531  		break;
3b336d6f4ec690 Matteo Croce        2019-10-29  1532  
0744dd00c1b1be Eric Dumazet        2011-11-28  1533  	default:
0744dd00c1b1be Eric Dumazet        2011-11-28  1534  		break;
0744dd00c1b1be Eric Dumazet        2011-11-28  1535  	}
0744dd00c1b1be Eric Dumazet        2011-11-28  1536  
8ffb055beae585 Yoshiki Komachi     2019-12-03  1537  	if (!(key_control->flags & FLOW_DIS_IS_FRAGMENT))
8ffb055beae585 Yoshiki Komachi     2019-12-03  1538  		__skb_flow_dissect_ports(skb, flow_dissector, target_container,
8ffb055beae585 Yoshiki Komachi     2019-12-03  1539  					 data, nhoff, ip_proto, hlen);
5af7fb6e3e92c2 Alexander Duyck     2014-10-10  1540  
3a1214e8b06317 Tom Herbert         2017-09-01  1541  	/* Process result of IP proto processing */
3a1214e8b06317 Tom Herbert         2017-09-01  1542  	switch (fdret) {
3a1214e8b06317 Tom Herbert         2017-09-01  1543  	case FLOW_DISSECT_RET_PROTO_AGAIN:
1eed4dfb81b193 Tom Herbert         2017-09-01  1544  		if (skb_flow_dissect_allowed(&num_hdrs))
3a1214e8b06317 Tom Herbert         2017-09-01  1545  			goto proto_again;
1eed4dfb81b193 Tom Herbert         2017-09-01  1546  		break;
3a1214e8b06317 Tom Herbert         2017-09-01  1547  	case FLOW_DISSECT_RET_IPPROTO_AGAIN:
1eed4dfb81b193 Tom Herbert         2017-09-01  1548  		if (skb_flow_dissect_allowed(&num_hdrs))
3a1214e8b06317 Tom Herbert         2017-09-01  1549  			goto ip_proto_again;
1eed4dfb81b193 Tom Herbert         2017-09-01  1550  		break;
3a1214e8b06317 Tom Herbert         2017-09-01  1551  	case FLOW_DISSECT_RET_OUT_GOOD:
3a1214e8b06317 Tom Herbert         2017-09-01  1552  	case FLOW_DISSECT_RET_CONTINUE:
3a1214e8b06317 Tom Herbert         2017-09-01  1553  		break;
3a1214e8b06317 Tom Herbert         2017-09-01  1554  	case FLOW_DISSECT_RET_OUT_BAD:
3a1214e8b06317 Tom Herbert         2017-09-01  1555  	default:
3a1214e8b06317 Tom Herbert         2017-09-01  1556  		goto out_bad;
3a1214e8b06317 Tom Herbert         2017-09-01  1557  	}
3a1214e8b06317 Tom Herbert         2017-09-01  1558  
a6e544b0a88b53 Tom Herbert         2015-09-01  1559  out_good:
a6e544b0a88b53 Tom Herbert         2015-09-01  1560  	ret = true;
a6e544b0a88b53 Tom Herbert         2015-09-01  1561  
34fad54c2537f7 Eric Dumazet        2016-11-09  1562  out:
d0c081b49137cd Eric Dumazet        2018-01-17  1563  	key_control->thoff = min_t(u16, nhoff, skb ? skb->len : hlen);
a6e544b0a88b53 Tom Herbert         2015-09-01  1564  	key_basic->n_proto = proto;
a6e544b0a88b53 Tom Herbert         2015-09-01  1565  	key_basic->ip_proto = ip_proto;
a6e544b0a88b53 Tom Herbert         2015-09-01  1566  
a6e544b0a88b53 Tom Herbert         2015-09-01  1567  	return ret;
34fad54c2537f7 Eric Dumazet        2016-11-09  1568  
34fad54c2537f7 Eric Dumazet        2016-11-09  1569  out_bad:
34fad54c2537f7 Eric Dumazet        2016-11-09  1570  	ret = false;
34fad54c2537f7 Eric Dumazet        2016-11-09  1571  	goto out;
0744dd00c1b1be Eric Dumazet        2011-11-28  1572  }
690e36e726d00d David S. Miller     2014-08-23  1573  EXPORT_SYMBOL(__skb_flow_dissect);
441d9d327f1e77 Cong Wang           2013-01-21  1574  

:::::: The code at line 946 was first introduced by commit
:::::: 3cbf4ffba5eeec60f82868a5facc1962d8a44d00 net: plumb network namespace into __skb_flow_dissect

:::::: TO: Stanislav Fomichev <sdf@google.com>
:::::: CC: Daniel Borkmann <daniel@iogearbox.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
