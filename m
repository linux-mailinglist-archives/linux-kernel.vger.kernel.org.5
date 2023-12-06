Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FE08064F9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjLFC0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 21:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFC0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 21:26:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E280A183;
        Tue,  5 Dec 2023 18:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701829580; x=1733365580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wYF7RpbeB8g+ke68CCl/dlzrv8SelrNRCEz/XWFPejw=;
  b=Neo1MBIx+b/mLlSdYNdMKUzR18NHKRYmBAQlhxVqP8xYefhFXqoHzJcQ
   SgAOVlsuAtTlUvGJwIIz0cmN9b2D5dis7uebVcJzDvGLhpnoGdcihfDPm
   P+W3FQh93vngmgncW1PS6+09SSmyBt4nSjhtD7xv68JuNODR4RkyZFOg/
   iVSVvmUl61RL+GM7DY0OpBORpP67P+eUgdfV5gkzUvwlRWlYjZpuKiO9J
   GQYlPGq6aQaifnw/yuY3g2aY7uJMiJ2WbtHtURe3/j6u/L6j/Qwwq7Xve
   /SZbr0PsJI/J6dWWzbnGW2j1bW7OgZP5bVXknDI9zfDwpULEeoBf25pwv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="384396868"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="384396868"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 18:26:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="1018415924"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="1018415924"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 05 Dec 2023 18:26:17 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAhc6-000A5O-38;
        Wed, 06 Dec 2023 02:26:14 +0000
Date:   Wed, 6 Dec 2023 10:25:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Weongyo Jeong <weongyo.linux@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Jesper Brouer <jesper@cloudflare.com>
Subject: Re: [PATCH v2 net-next] packet: add a generic drop reason for receive
Message-ID: <202312061012.2LbT2aSi-lkp@intel.com>
References: <ZWobMUp22oTpP3FW@debian.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWobMUp22oTpP3FW@debian.debian>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Yan-Zhai/packet-add-a-generic-drop-reason-for-receive/20231202-014515
base:   net-next/main
patch link:    https://lore.kernel.org/r/ZWobMUp22oTpP3FW%40debian.debian
patch subject: [PATCH v2 net-next] packet: add a generic drop reason for receive
config: x86_64-randconfig-121-20231202 (https://download.01.org/0day-ci/archive/20231206/202312061012.2LbT2aSi-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312061012.2LbT2aSi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312061012.2LbT2aSi-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/packet/af_packet.c: In function 'packet_rcv':
>> net/packet/af_packet.c:2130:7: warning: variable 'is_drop_n_account' set but not used [-Wunused-but-set-variable]
    2130 |  bool is_drop_n_account = false;
         |       ^~~~~~~~~~~~~~~~~
   net/packet/af_packet.c: In function 'tpacket_rcv':
   net/packet/af_packet.c:2255:7: warning: variable 'is_drop_n_account' set but not used [-Wunused-but-set-variable]
    2255 |  bool is_drop_n_account = false;
         |       ^~~~~~~~~~~~~~~~~


vim +/is_drop_n_account +2130 net/packet/af_packet.c

16cc1400456a4d Willem de Bruijn         2016-02-03  2108  
^1da177e4c3f41 Linus Torvalds           2005-04-16  2109  /*
62ab0812137ec4 Eric Dumazet             2010-12-06  2110   * This function makes lazy skb cloning in hope that most of packets
62ab0812137ec4 Eric Dumazet             2010-12-06  2111   * are discarded by BPF.
62ab0812137ec4 Eric Dumazet             2010-12-06  2112   *
62ab0812137ec4 Eric Dumazet             2010-12-06  2113   * Note tricky part: we DO mangle shared skb! skb->data, skb->len
62ab0812137ec4 Eric Dumazet             2010-12-06  2114   * and skb->cb are mangled. It works because (and until) packets
62ab0812137ec4 Eric Dumazet             2010-12-06  2115   * falling here are owned by current CPU. Output packets are cloned
62ab0812137ec4 Eric Dumazet             2010-12-06  2116   * by dev_queue_xmit_nit(), input packets are processed by net_bh
0e4161d0eda56e Wang Hai                 2021-03-24  2117   * sequentially, so that if we return skb to original state on exit,
62ab0812137ec4 Eric Dumazet             2010-12-06  2118   * we will not harm anyone.
^1da177e4c3f41 Linus Torvalds           2005-04-16  2119   */
^1da177e4c3f41 Linus Torvalds           2005-04-16  2120  
40d4e3dfc2f56a Eric Dumazet             2009-07-21  2121  static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
40d4e3dfc2f56a Eric Dumazet             2009-07-21  2122  		      struct packet_type *pt, struct net_device *orig_dev)
^1da177e4c3f41 Linus Torvalds           2005-04-16  2123  {
^1da177e4c3f41 Linus Torvalds           2005-04-16  2124  	struct sock *sk;
^1da177e4c3f41 Linus Torvalds           2005-04-16  2125  	struct sockaddr_ll *sll;
^1da177e4c3f41 Linus Torvalds           2005-04-16  2126  	struct packet_sock *po;
^1da177e4c3f41 Linus Torvalds           2005-04-16  2127  	u8 *skb_head = skb->data;
^1da177e4c3f41 Linus Torvalds           2005-04-16  2128  	int skb_len = skb->len;
dbcb5855d108b7 David S. Miller          2007-01-24  2129  	unsigned int snaplen, res;
da37845fdce24e Weongyo Jeong            2016-04-14 @2130  	bool is_drop_n_account = false;
e31e10cea16faa Yan Zhai                 2023-12-01  2131  	enum skb_drop_reason drop_reason = SKB_CONSUMED;
^1da177e4c3f41 Linus Torvalds           2005-04-16  2132  
^1da177e4c3f41 Linus Torvalds           2005-04-16  2133  	if (skb->pkt_type == PACKET_LOOPBACK)
^1da177e4c3f41 Linus Torvalds           2005-04-16  2134  		goto drop;
^1da177e4c3f41 Linus Torvalds           2005-04-16  2135  
^1da177e4c3f41 Linus Torvalds           2005-04-16  2136  	sk = pt->af_packet_priv;
^1da177e4c3f41 Linus Torvalds           2005-04-16  2137  	po = pkt_sk(sk);
^1da177e4c3f41 Linus Torvalds           2005-04-16  2138  
09ad9bc752519c Octavian Purdila         2009-11-25  2139  	if (!net_eq(dev_net(dev), sock_net(sk)))
d12d01d6b4d197 Denis V. Lunev           2007-11-19  2140  		goto drop;
d12d01d6b4d197 Denis V. Lunev           2007-11-19  2141  
^1da177e4c3f41 Linus Torvalds           2005-04-16  2142  	skb->dev = dev;
^1da177e4c3f41 Linus Torvalds           2005-04-16  2143  
d549699048b4b5 Eyal Birger              2020-11-21  2144  	if (dev_has_header(dev)) {
^1da177e4c3f41 Linus Torvalds           2005-04-16  2145  		/* The device has an explicit notion of ll header,
62ab0812137ec4 Eric Dumazet             2010-12-06  2146  		 * exported to higher levels.
62ab0812137ec4 Eric Dumazet             2010-12-06  2147  		 *
62ab0812137ec4 Eric Dumazet             2010-12-06  2148  		 * Otherwise, the device hides details of its frame
62ab0812137ec4 Eric Dumazet             2010-12-06  2149  		 * structure, so that corresponding packet head is
62ab0812137ec4 Eric Dumazet             2010-12-06  2150  		 * never delivered to user.
^1da177e4c3f41 Linus Torvalds           2005-04-16  2151  		 */
^1da177e4c3f41 Linus Torvalds           2005-04-16  2152  		if (sk->sk_type != SOCK_DGRAM)
98e399f82ab3a6 Arnaldo Carvalho de Melo 2007-03-19  2153  			skb_push(skb, skb->data - skb_mac_header(skb));
^1da177e4c3f41 Linus Torvalds           2005-04-16  2154  		else if (skb->pkt_type == PACKET_OUTGOING) {
^1da177e4c3f41 Linus Torvalds           2005-04-16  2155  			/* Special case: outgoing packets have ll header at head */
bbe735e4247dba Arnaldo Carvalho de Melo 2007-03-10  2156  			skb_pull(skb, skb_network_offset(skb));
^1da177e4c3f41 Linus Torvalds           2005-04-16  2157  		}
^1da177e4c3f41 Linus Torvalds           2005-04-16  2158  	}
^1da177e4c3f41 Linus Torvalds           2005-04-16  2159  
^1da177e4c3f41 Linus Torvalds           2005-04-16  2160  	snaplen = skb->len;
^1da177e4c3f41 Linus Torvalds           2005-04-16  2161  
dbcb5855d108b7 David S. Miller          2007-01-24  2162  	res = run_filter(skb, sk, snaplen);
dbcb5855d108b7 David S. Miller          2007-01-24  2163  	if (!res)
^1da177e4c3f41 Linus Torvalds           2005-04-16  2164  		goto drop_n_restore;
e31e10cea16faa Yan Zhai                 2023-12-01  2165  
e31e10cea16faa Yan Zhai                 2023-12-01  2166  	/* skb will only be "consumed" not "dropped" before this */
e31e10cea16faa Yan Zhai                 2023-12-01  2167  	drop_reason = SKB_DROP_REASON_PACKET_SOCK_ERROR;
e31e10cea16faa Yan Zhai                 2023-12-01  2168  
dbcb5855d108b7 David S. Miller          2007-01-24  2169  	if (snaplen > res)
dbcb5855d108b7 David S. Miller          2007-01-24  2170  		snaplen = res;
^1da177e4c3f41 Linus Torvalds           2005-04-16  2171  
0fd7bac6b6157e Eric Dumazet             2011-12-21  2172  	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf)
^1da177e4c3f41 Linus Torvalds           2005-04-16  2173  		goto drop_n_acct;
^1da177e4c3f41 Linus Torvalds           2005-04-16  2174  
^1da177e4c3f41 Linus Torvalds           2005-04-16  2175  	if (skb_shared(skb)) {
^1da177e4c3f41 Linus Torvalds           2005-04-16  2176  		struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);
^1da177e4c3f41 Linus Torvalds           2005-04-16  2177  		if (nskb == NULL)
^1da177e4c3f41 Linus Torvalds           2005-04-16  2178  			goto drop_n_acct;
^1da177e4c3f41 Linus Torvalds           2005-04-16  2179  
^1da177e4c3f41 Linus Torvalds           2005-04-16  2180  		if (skb_head != skb->data) {
^1da177e4c3f41 Linus Torvalds           2005-04-16  2181  			skb->data = skb_head;
^1da177e4c3f41 Linus Torvalds           2005-04-16  2182  			skb->len = skb_len;
^1da177e4c3f41 Linus Torvalds           2005-04-16  2183  		}
abc4e4fa29eb81 Eric Dumazet             2012-04-19  2184  		consume_skb(skb);
^1da177e4c3f41 Linus Torvalds           2005-04-16  2185  		skb = nskb;
^1da177e4c3f41 Linus Torvalds           2005-04-16  2186  	}
^1da177e4c3f41 Linus Torvalds           2005-04-16  2187  
b4772ef879a8f7 Eyal Birger              2015-03-01  2188  	sock_skb_cb_check_size(sizeof(*PACKET_SKB_CB(skb)) + MAX_ADDR_LEN - 8);
ffbc61117d32dc Herbert Xu               2007-02-04  2189  
ffbc61117d32dc Herbert Xu               2007-02-04  2190  	sll = &PACKET_SKB_CB(skb)->sa.ll;
^1da177e4c3f41 Linus Torvalds           2005-04-16  2191  	sll->sll_hatype = dev->type;
^1da177e4c3f41 Linus Torvalds           2005-04-16  2192  	sll->sll_pkttype = skb->pkt_type;
ee5675ecdf7a4e Eric Dumazet             2023-03-16  2193  	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
80feaacb8a6400 Peter P. Waskiewicz Jr   2007-04-20  2194  		sll->sll_ifindex = orig_dev->ifindex;
80feaacb8a6400 Peter P. Waskiewicz Jr   2007-04-20  2195  	else
^1da177e4c3f41 Linus Torvalds           2005-04-16  2196  		sll->sll_ifindex = dev->ifindex;
^1da177e4c3f41 Linus Torvalds           2005-04-16  2197  
b95cce3576813a Stephen Hemminger        2007-09-26  2198  	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
^1da177e4c3f41 Linus Torvalds           2005-04-16  2199  
2472d7613bd3ba Eyal Birger              2015-03-01  2200  	/* sll->sll_family and sll->sll_protocol are set in packet_recvmsg().
2472d7613bd3ba Eyal Birger              2015-03-01  2201  	 * Use their space for storing the original skb length.
2472d7613bd3ba Eyal Birger              2015-03-01  2202  	 */
2472d7613bd3ba Eyal Birger              2015-03-01  2203  	PACKET_SKB_CB(skb)->sa.origlen = skb->len;
8dc41944741596 Herbert Xu               2007-02-04  2204  
^1da177e4c3f41 Linus Torvalds           2005-04-16  2205  	if (pskb_trim(skb, snaplen))
^1da177e4c3f41 Linus Torvalds           2005-04-16  2206  		goto drop_n_acct;
^1da177e4c3f41 Linus Torvalds           2005-04-16  2207  
^1da177e4c3f41 Linus Torvalds           2005-04-16  2208  	skb_set_owner_r(skb, sk);
^1da177e4c3f41 Linus Torvalds           2005-04-16  2209  	skb->dev = NULL;
adf30907d63893 Eric Dumazet             2009-06-02  2210  	skb_dst_drop(skb);
^1da177e4c3f41 Linus Torvalds           2005-04-16  2211  
84531c24f27b02 Phil Oester              2005-07-12  2212  	/* drop conntrack reference */
895b5c9f206eb7 Florian Westphal         2019-09-29  2213  	nf_reset_ct(skb);
84531c24f27b02 Phil Oester              2005-07-12  2214  
^1da177e4c3f41 Linus Torvalds           2005-04-16  2215  	spin_lock(&sk->sk_receive_queue.lock);
ee80fbf301adac Daniel Borkmann          2013-04-19  2216  	po->stats.stats1.tp_packets++;
3bc3b96f3b455b Eyal Birger              2015-03-01  2217  	sock_skb_set_dropcount(sk, skb);
27942a15209f56 Martin KaFai Lau         2022-03-02  2218  	skb_clear_delivery_time(skb);
^1da177e4c3f41 Linus Torvalds           2005-04-16  2219  	__skb_queue_tail(&sk->sk_receive_queue, skb);
^1da177e4c3f41 Linus Torvalds           2005-04-16  2220  	spin_unlock(&sk->sk_receive_queue.lock);
676d23690fb62b David S. Miller          2014-04-11  2221  	sk->sk_data_ready(sk);
^1da177e4c3f41 Linus Torvalds           2005-04-16  2222  	return 0;
^1da177e4c3f41 Linus Torvalds           2005-04-16  2223  
^1da177e4c3f41 Linus Torvalds           2005-04-16  2224  drop_n_acct:
da37845fdce24e Weongyo Jeong            2016-04-14  2225  	is_drop_n_account = true;
8e8e2951e30957 Eric Dumazet             2019-06-12  2226  	atomic_inc(&po->tp_drops);
7091fbd82cd568 Willem de Bruijn         2011-09-30  2227  	atomic_inc(&sk->sk_drops);
^1da177e4c3f41 Linus Torvalds           2005-04-16  2228  
^1da177e4c3f41 Linus Torvalds           2005-04-16  2229  drop_n_restore:
^1da177e4c3f41 Linus Torvalds           2005-04-16  2230  	if (skb_head != skb->data && skb_shared(skb)) {
^1da177e4c3f41 Linus Torvalds           2005-04-16  2231  		skb->data = skb_head;
^1da177e4c3f41 Linus Torvalds           2005-04-16  2232  		skb->len = skb_len;
^1da177e4c3f41 Linus Torvalds           2005-04-16  2233  	}
^1da177e4c3f41 Linus Torvalds           2005-04-16  2234  drop:
e31e10cea16faa Yan Zhai                 2023-12-01  2235  	kfree_skb_reason(skb, drop_reason);
^1da177e4c3f41 Linus Torvalds           2005-04-16  2236  	return 0;
^1da177e4c3f41 Linus Torvalds           2005-04-16  2237  }
^1da177e4c3f41 Linus Torvalds           2005-04-16  2238  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
