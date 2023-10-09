Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C507BE609
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377119AbjJIQNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376437AbjJIQNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:13:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E674DB6;
        Mon,  9 Oct 2023 09:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696867984; x=1728403984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g1NiAretHPplC4GfKJCFweDZcYF7PrRqdWCN6KS9zxo=;
  b=H+NO3U2CF7aDQNcY08iJn4eoLqw/kqori3U7fHZk6l+Rn9jPQDeUIZ4D
   X/qQdA1qtbd+NWocve24GXuZ0YxuAUKaUGHgIEk3osLhBOAzgL3jv3J6w
   tgzTA9YbK1Aczv8FOaPAHuSNpTwpimjQ2qaGxcXt/Z864Rx+xQESL8z3y
   GN31WRZQtDde8Q2UQubwrv6V27Y+tJ2w97HMrxOUjz28hF6D5pjZCl7da
   NTaNjV6hTMV0Skpy1yf4Wj2Ru1Cytgbvznr8Dulk67jncVOJEWmu0lNqT
   1CAeyWvFGhEa/y8nKmvb1r755Hmvj2iH5DLhof+whgsFgl1zO3ZXkH9c+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="448373563"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="448373563"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 09:13:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="788220909"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="788220909"
Received: from lkp-server02.sh.intel.com (HELO 4ed589823ba4) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 09 Oct 2023 09:13:01 -0700
Received: from kbuild by 4ed589823ba4 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpssI-0000Lk-1J;
        Mon, 09 Oct 2023 16:12:55 +0000
Date:   Tue, 10 Oct 2023 00:12:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Beniamino Galvani <b.galvani@gmail.com>, netdev@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 7/7] vxlan: use generic function for tunnel IPv4
 route lookup
Message-ID: <202310100015.LteDznhb-lkp@intel.com>
References: <20231009082059.2500217-8-b.galvani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009082059.2500217-8-b.galvani@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Beniamino,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Beniamino-Galvani/ipv4-rename-and-move-ip_route_output_tunnel/20231009-162823
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231009082059.2500217-8-b.galvani%40gmail.com
patch subject: [PATCH net-next 7/7] vxlan: use generic function for tunnel IPv4 route lookup
config: s390-randconfig-001-20231009 (https://download.01.org/0day-ci/archive/20231010/202310100015.LteDznhb-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310100015.LteDznhb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310100015.LteDznhb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/vxlan/vxlan_core.c: In function 'vxlan_xmit_one':
   drivers/net/vxlan/vxlan_core.c:2381:24: warning: variable 'flow_flags' set but not used [-Wunused-but-set-variable]
    2381 |         __u8 tos, ttl, flow_flags = 0;
         |                        ^~~~~~~~~~
>> drivers/net/vxlan/vxlan_core.c:2375:37: warning: variable 'local_ip' set but not used [-Wunused-but-set-variable]
    2375 |         union vxlan_addr remote_ip, local_ip;
         |                                     ^~~~~~~~


vim +/local_ip +2375 drivers/net/vxlan/vxlan_core.c

fee1fad7c73dd0 drivers/net/vxlan.c            pravin shelar       2016-11-13  2364  
6ab271aaad2535 drivers/net/vxlan/vxlan_core.c Ido Schimmel        2023-03-15  2365  void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
6ab271aaad2535 drivers/net/vxlan/vxlan_core.c Ido Schimmel        2023-03-15  2366  		    __be32 default_vni, struct vxlan_rdst *rdst, bool did_rsc)
d342894c5d2f8c drivers/net/vxlan.c            stephen hemminger   2012-10-01  2367  {
d71785ffc7e7ca drivers/net/vxlan.c            Paolo Abeni         2016-02-12  2368  	struct dst_cache *dst_cache;
3093fbe7ff4bc7 drivers/net/vxlan.c            Thomas Graf         2015-07-21  2369  	struct ip_tunnel_info *info;
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2370  	struct ip_tunnel_key *pkey;
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2371  	struct ip_tunnel_key key;
d342894c5d2f8c drivers/net/vxlan.c            stephen hemminger   2012-10-01  2372  	struct vxlan_dev *vxlan = netdev_priv(dev);
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2373  	const struct iphdr *old_iph = ip_hdr(skb);
e4c7ed415387cf drivers/net/vxlan.c            Cong Wang           2013-08-31  2374  	union vxlan_addr *dst;
272d96a5ab1066 drivers/net/vxlan.c            pravin shelar       2016-08-05 @2375  	union vxlan_addr remote_ip, local_ip;
ee122c79d4227f drivers/net/vxlan.c            Thomas Graf         2015-07-21  2376  	struct vxlan_metadata _md;
ee122c79d4227f drivers/net/vxlan.c            Thomas Graf         2015-07-21  2377  	struct vxlan_metadata *md = &_md;
4095e0e1328a3c drivers/net/vxlan/vxlan_core.c Nikolay Aleksandrov 2022-03-01  2378  	unsigned int pkt_len = skb->len;
e4c7ed415387cf drivers/net/vxlan.c            Cong Wang           2013-08-31  2379  	__be16 src_port = 0, dst_port;
655c3de16540b8 drivers/net/vxlan.c            pravin shelar       2016-11-13  2380  	struct dst_entry *ndst = NULL;
7e2fb8bc7ef6c7 drivers/net/vxlan/vxlan_core.c Paul Chaignon       2022-07-25  2381  	__u8 tos, ttl, flow_flags = 0;
49f810f00fa347 drivers/net/vxlan.c            Matthias Schiffer   2017-06-19  2382  	int ifindex;
0e6fbc5b6c6218 drivers/net/vxlan.c            Pravin B Shelar     2013-06-17  2383  	int err;
dc5321d79697db drivers/net/vxlan.c            Matthias Schiffer   2017-06-19  2384  	u32 flags = vxlan->cfg.flags;
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2385  	bool use_cache;
b4ed5cad24c107 drivers/net/vxlan.c            Jiri Benc           2016-02-02  2386  	bool udp_sum = false;
f491e56dba511d drivers/net/vxlan.c            Jiri Benc           2016-02-02  2387  	bool xnet = !net_eq(vxlan->net, dev_net(vxlan->dev));
fba55a66e8ecd1 drivers/net/vxlan/vxlan_core.c Roopa Prabhu        2022-03-01  2388  	__be32 vni = 0;
fba55a66e8ecd1 drivers/net/vxlan/vxlan_core.c Roopa Prabhu        2022-03-01  2389  #if IS_ENABLED(CONFIG_IPV6)
fba55a66e8ecd1 drivers/net/vxlan/vxlan_core.c Roopa Prabhu        2022-03-01  2390  	__be32 label;
fba55a66e8ecd1 drivers/net/vxlan/vxlan_core.c Roopa Prabhu        2022-03-01  2391  #endif
e4f67addf158f9 drivers/net/vxlan.c            David Stevens       2012-11-20  2392  
61adedf3e3f1d3 drivers/net/vxlan.c            Jiri Benc           2015-08-20  2393  	info = skb_tunnel_info(skb);
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2394  	use_cache = ip_tunnel_dst_cache_usable(skb, info);
3093fbe7ff4bc7 drivers/net/vxlan.c            Thomas Graf         2015-07-21  2395  
ee122c79d4227f drivers/net/vxlan.c            Thomas Graf         2015-07-21  2396  	if (rdst) {
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2397  		dst = &rdst->remote_ip;
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2398  		memset(&key, 0, sizeof(key));
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2399  		pkey = &key;
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2400  
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2401  		if (vxlan_addr_any(dst)) {
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2402  			if (did_rsc) {
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2403  				/* short-circuited back to local bridge */
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2404  				vxlan_encap_bypass(skb, vxlan, vxlan,
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2405  						   default_vni, true);
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2406  				return;
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2407  			}
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2408  			goto drop;
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2409  		}
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2410  
0dfbdf4102b930 drivers/net/vxlan.c            Thomas Graf         2015-07-21  2411  		dst_port = rdst->remote_port ? rdst->remote_port : vxlan->cfg.dst_port;
3ad7a4b141ebd6 drivers/net/vxlan.c            Roopa Prabhu        2017-01-31  2412  		vni = (rdst->remote_vni) ? : default_vni;
49f810f00fa347 drivers/net/vxlan.c            Matthias Schiffer   2017-06-19  2413  		ifindex = rdst->remote_ifindex;
1158632b5a2dcc drivers/net/vxlan.c            Brian Russell       2017-02-24  2414  		local_ip = vxlan->cfg.saddr;
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2415  
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2416  		if (dst->sa.sa_family == AF_INET) {
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2417  			key.u.ipv4.src = vxlan->cfg.saddr.sin.sin_addr.s_addr;
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2418  			key.u.ipv4.dst = rdst->remote_ip.sin.sin_addr.s_addr;
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2419  		} else {
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2420  			key.u.ipv6.src = vxlan->cfg.saddr.sin6.sin6_addr;
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2421  			key.u.ipv6.dst = rdst->remote_ip.sin6.sin6_addr;
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2422  		}
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2423  
d71785ffc7e7ca drivers/net/vxlan.c            Paolo Abeni         2016-02-12  2424  		dst_cache = &rdst->dst_cache;
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2425  		md->gbp = skb->mark;
72f6d71e491e6c drivers/net/vxlan.c            Hangbin Liu         2018-04-17  2426  		if (flags & VXLAN_F_TTL_INHERIT) {
72f6d71e491e6c drivers/net/vxlan.c            Hangbin Liu         2018-04-17  2427  			ttl = ip_tunnel_get_ttl(old_iph, skb);
72f6d71e491e6c drivers/net/vxlan.c            Hangbin Liu         2018-04-17  2428  		} else {
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2429  			ttl = vxlan->cfg.ttl;
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2430  			if (!ttl && vxlan_addr_multicast(dst))
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2431  				ttl = 1;
72f6d71e491e6c drivers/net/vxlan.c            Hangbin Liu         2018-04-17  2432  		}
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2433  
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2434  		tos = vxlan->cfg.tos;
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2435  		if (tos == 1)
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2436  			tos = ip_tunnel_get_dsfield(old_iph, skb);
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2437  		if (tos && !info)
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2438  			use_cache = false;
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2439  
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2440  		if (dst->sa.sa_family == AF_INET)
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2441  			udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM_TX);
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2442  		else
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2443  			udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM6_TX);
fba55a66e8ecd1 drivers/net/vxlan/vxlan_core.c Roopa Prabhu        2022-03-01  2444  #if IS_ENABLED(CONFIG_IPV6)
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2445  		label = vxlan->cfg.label;
fba55a66e8ecd1 drivers/net/vxlan/vxlan_core.c Roopa Prabhu        2022-03-01  2446  #endif
ee122c79d4227f drivers/net/vxlan.c            Thomas Graf         2015-07-21  2447  	} else {
435be28b0789b3 drivers/net/vxlan.c            Jakub Kicinski      2020-09-25  2448  		if (!info) {
435be28b0789b3 drivers/net/vxlan.c            Jakub Kicinski      2020-09-25  2449  			WARN_ONCE(1, "%s: Missing encapsulation instructions\n",
435be28b0789b3 drivers/net/vxlan.c            Jakub Kicinski      2020-09-25  2450  				  dev->name);
435be28b0789b3 drivers/net/vxlan.c            Jakub Kicinski      2020-09-25  2451  			goto drop;
435be28b0789b3 drivers/net/vxlan.c            Jakub Kicinski      2020-09-25  2452  		}
b1be00a6c39fda drivers/net/vxlan.c            Jiri Benc           2015-09-24  2453  		remote_ip.sa.sa_family = ip_tunnel_info_af(info);
272d96a5ab1066 drivers/net/vxlan.c            pravin shelar       2016-08-05  2454  		if (remote_ip.sa.sa_family == AF_INET) {
c1ea5d672aaff0 drivers/net/vxlan.c            Jiri Benc           2015-08-20  2455  			remote_ip.sin.sin_addr.s_addr = info->key.u.ipv4.dst;
272d96a5ab1066 drivers/net/vxlan.c            pravin shelar       2016-08-05  2456  			local_ip.sin.sin_addr.s_addr = info->key.u.ipv4.src;
272d96a5ab1066 drivers/net/vxlan.c            pravin shelar       2016-08-05  2457  		} else {
a725e514dbb444 drivers/net/vxlan.c            Jiri Benc           2015-08-20  2458  			remote_ip.sin6.sin6_addr = info->key.u.ipv6.dst;
272d96a5ab1066 drivers/net/vxlan.c            pravin shelar       2016-08-05  2459  			local_ip.sin6.sin6_addr = info->key.u.ipv6.src;
272d96a5ab1066 drivers/net/vxlan.c            pravin shelar       2016-08-05  2460  		}
ee122c79d4227f drivers/net/vxlan.c            Thomas Graf         2015-07-21  2461  		dst = &remote_ip;
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2462  		pkey = &info->key;
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2463  		dst_port = info->key.tp_dst ? : vxlan->cfg.dst_port;
7e2fb8bc7ef6c7 drivers/net/vxlan/vxlan_core.c Paul Chaignon       2022-07-25  2464  		flow_flags = info->key.flow_flags;
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2465  		vni = tunnel_id_to_key32(info->key.tun_id);
49f810f00fa347 drivers/net/vxlan.c            Matthias Schiffer   2017-06-19  2466  		ifindex = 0;
d71785ffc7e7ca drivers/net/vxlan.c            Paolo Abeni         2016-02-12  2467  		dst_cache = &info->dst_cache;
eadf52cf185219 drivers/net/vxlan.c            Xin Long            2019-10-29  2468  		if (info->key.tun_flags & TUNNEL_VXLAN_OPT) {
eadf52cf185219 drivers/net/vxlan.c            Xin Long            2019-10-29  2469  			if (info->options_len < sizeof(*md))
eadf52cf185219 drivers/net/vxlan.c            Xin Long            2019-10-29  2470  				goto drop;
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2471  			md = ip_tunnel_info_opts(info);
eadf52cf185219 drivers/net/vxlan.c            Xin Long            2019-10-29  2472  		}
7c383fb2254c44 drivers/net/vxlan.c            Jiri Benc           2015-08-20  2473  		ttl = info->key.ttl;
7c383fb2254c44 drivers/net/vxlan.c            Jiri Benc           2015-08-20  2474  		tos = info->key.tos;
fba55a66e8ecd1 drivers/net/vxlan/vxlan_core.c Roopa Prabhu        2022-03-01  2475  #if IS_ENABLED(CONFIG_IPV6)
e7f70af111f086 drivers/net/vxlan.c            Daniel Borkmann     2016-03-09  2476  		label = info->key.label;
fba55a66e8ecd1 drivers/net/vxlan/vxlan_core.c Roopa Prabhu        2022-03-01  2477  #endif
b4ed5cad24c107 drivers/net/vxlan.c            Jiri Benc           2016-02-02  2478  		udp_sum = !!(info->key.tun_flags & TUNNEL_CSUM);
ee122c79d4227f drivers/net/vxlan.c            Thomas Graf         2015-07-21  2479  	}
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2480  	src_port = udp_flow_src_port(dev_net(dev), skb, vxlan->cfg.port_min,
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2481  				     vxlan->cfg.port_max, true);
ee122c79d4227f drivers/net/vxlan.c            Thomas Graf         2015-07-21  2482  
56de859e9967c0 drivers/net/vxlan.c            Jakub Kicinski      2017-02-24  2483  	rcu_read_lock();
a725e514dbb444 drivers/net/vxlan.c            Jiri Benc           2015-08-20  2484  	if (dst->sa.sa_family == AF_INET) {
c6fcc4fc5f8b59 drivers/net/vxlan.c            pravin shelar       2016-10-28  2485  		struct vxlan_sock *sock4 = rcu_dereference(vxlan->vn4_sock);
c46b7897ad5ba4 drivers/net/vxlan.c            pravin shelar       2016-11-13  2486  		struct rtable *rt;
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2487  		__be16 df = 0;
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2488  		__be32 saddr;
c6fcc4fc5f8b59 drivers/net/vxlan.c            pravin shelar       2016-10-28  2489  
aab8cc3630e325 drivers/net/vxlan.c            Alexis Bauvin       2018-12-03  2490  		if (!ifindex)
aab8cc3630e325 drivers/net/vxlan.c            Alexis Bauvin       2018-12-03  2491  			ifindex = sock4->sock->sk->sk_bound_dev_if;
aab8cc3630e325 drivers/net/vxlan.c            Alexis Bauvin       2018-12-03  2492  
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2493  		rt = udp_tunnel_dst_lookup(skb, dev, vxlan->net, ifindex,
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2494  					   &saddr, pkey, src_port, dst_port,
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2495  					   tos, use_cache ? dst_cache : NULL);
8ebd115bb23ac4 drivers/net/vxlan.c            David S. Miller     2016-11-15  2496  		if (IS_ERR(rt)) {
8ebd115bb23ac4 drivers/net/vxlan.c            David S. Miller     2016-11-15  2497  			err = PTR_ERR(rt);
c46b7897ad5ba4 drivers/net/vxlan.c            pravin shelar       2016-11-13  2498  			goto tx_error;
8ebd115bb23ac4 drivers/net/vxlan.c            David S. Miller     2016-11-15  2499  		}
d342894c5d2f8c drivers/net/vxlan.c            stephen hemminger   2012-10-01  2500  
fee1fad7c73dd0 drivers/net/vxlan.c            pravin shelar       2016-11-13  2501  		if (!info) {
b4d3069783bccf drivers/net/vxlan.c            Stefano Brivio      2018-11-08  2502  			/* Bypass encapsulation if the destination is local */
fee1fad7c73dd0 drivers/net/vxlan.c            pravin shelar       2016-11-13  2503  			err = encap_bypass_if_local(skb, dev, vxlan, dst,
49f810f00fa347 drivers/net/vxlan.c            Matthias Schiffer   2017-06-19  2504  						    dst_port, ifindex, vni,
49f810f00fa347 drivers/net/vxlan.c            Matthias Schiffer   2017-06-19  2505  						    &rt->dst, rt->rt_flags);
fee1fad7c73dd0 drivers/net/vxlan.c            pravin shelar       2016-11-13  2506  			if (err)
56de859e9967c0 drivers/net/vxlan.c            Jakub Kicinski      2017-02-24  2507  				goto out_unlock;
b4d3069783bccf drivers/net/vxlan.c            Stefano Brivio      2018-11-08  2508  
b4d3069783bccf drivers/net/vxlan.c            Stefano Brivio      2018-11-08  2509  			if (vxlan->cfg.df == VXLAN_DF_SET) {
b4d3069783bccf drivers/net/vxlan.c            Stefano Brivio      2018-11-08  2510  				df = htons(IP_DF);
b4d3069783bccf drivers/net/vxlan.c            Stefano Brivio      2018-11-08  2511  			} else if (vxlan->cfg.df == VXLAN_DF_INHERIT) {
b4d3069783bccf drivers/net/vxlan.c            Stefano Brivio      2018-11-08  2512  				struct ethhdr *eth = eth_hdr(skb);
b4d3069783bccf drivers/net/vxlan.c            Stefano Brivio      2018-11-08  2513  
b4d3069783bccf drivers/net/vxlan.c            Stefano Brivio      2018-11-08  2514  				if (ntohs(eth->h_proto) == ETH_P_IPV6 ||
b4d3069783bccf drivers/net/vxlan.c            Stefano Brivio      2018-11-08  2515  				    (ntohs(eth->h_proto) == ETH_P_IP &&
b4d3069783bccf drivers/net/vxlan.c            Stefano Brivio      2018-11-08  2516  				     old_iph->frag_off & htons(IP_DF)))
b4d3069783bccf drivers/net/vxlan.c            Stefano Brivio      2018-11-08  2517  					df = htons(IP_DF);
b4d3069783bccf drivers/net/vxlan.c            Stefano Brivio      2018-11-08  2518  			}
fee1fad7c73dd0 drivers/net/vxlan.c            pravin shelar       2016-11-13  2519  		} else if (info->key.tun_flags & TUNNEL_DONT_FRAGMENT) {
6ceb31ca5f65ac drivers/net/vxlan.c            Alexander Duyck     2016-02-19  2520  			df = htons(IP_DF);
fee1fad7c73dd0 drivers/net/vxlan.c            pravin shelar       2016-11-13  2521  		}
6ceb31ca5f65ac drivers/net/vxlan.c            Alexander Duyck     2016-02-19  2522  
c46b7897ad5ba4 drivers/net/vxlan.c            pravin shelar       2016-11-13  2523  		ndst = &rt->dst;
94d166c5318c6e drivers/net/vxlan/vxlan_core.c Jiri Benc           2023-07-20  2524  		err = skb_tunnel_check_pmtu(skb, ndst, vxlan_headroom(flags & VXLAN_F_GPE),
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2525  					    netif_is_any_bridge_port(dev));
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2526  		if (err < 0) {
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2527  			goto tx_error;
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2528  		} else if (err) {
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2529  			if (info) {
30a93d2b7d5a7c drivers/net/vxlan.c            Antoine Tenart      2021-03-25  2530  				struct ip_tunnel_info *unclone;
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2531  
30a93d2b7d5a7c drivers/net/vxlan.c            Antoine Tenart      2021-03-25  2532  				unclone = skb_tunnel_info_unclone(skb);
30a93d2b7d5a7c drivers/net/vxlan.c            Antoine Tenart      2021-03-25  2533  				if (unlikely(!unclone))
30a93d2b7d5a7c drivers/net/vxlan.c            Antoine Tenart      2021-03-25  2534  					goto tx_error;
30a93d2b7d5a7c drivers/net/vxlan.c            Antoine Tenart      2021-03-25  2535  
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2536  				unclone->key.u.ipv4.src = pkey->u.ipv4.dst;
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2537  				unclone->key.u.ipv4.dst = saddr;
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2538  			}
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2539  			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2540  			dst_release(ndst);
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2541  			goto out_unlock;
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2542  		}
a93bf0ff449064 drivers/net/vxlan.c            Xin Long            2017-12-18  2543  
a0dced17ad9dc0 drivers/net/vxlan.c            Hangbin Liu         2020-08-05  2544  		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
0e6fbc5b6c6218 drivers/net/vxlan.c            Pravin B Shelar     2013-06-17  2545  		ttl = ttl ? : ip4_dst_hoplimit(&rt->dst);
c46b7897ad5ba4 drivers/net/vxlan.c            pravin shelar       2016-11-13  2546  		err = vxlan_build_skb(skb, ndst, sizeof(struct iphdr),
54bfd872bf16d4 drivers/net/vxlan.c            Jiri Benc           2016-02-16  2547  				      vni, md, flags, udp_sum);
f491e56dba511d drivers/net/vxlan.c            Jiri Benc           2016-02-02  2548  		if (err < 0)
c46b7897ad5ba4 drivers/net/vxlan.c            pravin shelar       2016-11-13  2549  			goto tx_error;
f491e56dba511d drivers/net/vxlan.c            Jiri Benc           2016-02-02  2550  
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2551  		udp_tunnel_xmit_skb(rt, sock4->sock->sk, skb, saddr,
b4a6c582b7ff13 drivers/net/vxlan/vxlan_core.c Beniamino Galvani   2023-10-09  2552  				    pkey->u.ipv4.dst, tos, ttl, df,
f491e56dba511d drivers/net/vxlan.c            Jiri Benc           2016-02-02  2553  				    src_port, dst_port, xnet, !udp_sum);
e4c7ed415387cf drivers/net/vxlan.c            Cong Wang           2013-08-31  2554  #if IS_ENABLED(CONFIG_IPV6)
e4c7ed415387cf drivers/net/vxlan.c            Cong Wang           2013-08-31  2555  	} else {
c6fcc4fc5f8b59 drivers/net/vxlan.c            pravin shelar       2016-10-28  2556  		struct vxlan_sock *sock6 = rcu_dereference(vxlan->vn6_sock);
e4c7ed415387cf drivers/net/vxlan.c            Cong Wang           2013-08-31  2557  
aab8cc3630e325 drivers/net/vxlan.c            Alexis Bauvin       2018-12-03  2558  		if (!ifindex)
aab8cc3630e325 drivers/net/vxlan.c            Alexis Bauvin       2018-12-03  2559  			ifindex = sock6->sock->sk->sk_bound_dev_if;
aab8cc3630e325 drivers/net/vxlan.c            Alexis Bauvin       2018-12-03  2560  
49f810f00fa347 drivers/net/vxlan.c            Matthias Schiffer   2017-06-19  2561  		ndst = vxlan6_get_route(vxlan, dev, sock6, skb, ifindex, tos,
272d96a5ab1066 drivers/net/vxlan.c            pravin shelar       2016-08-05  2562  					label, &dst->sin6.sin6_addr,
1158632b5a2dcc drivers/net/vxlan.c            Brian Russell       2017-02-24  2563  					&local_ip.sin6.sin6_addr,
4ecb1d83f6abe8 drivers/net/vxlan.c            Martynas Pumputis   2017-01-11  2564  					dst_port, src_port,
db3c6139e6ead9 drivers/net/vxlan.c            Daniel Borkmann     2016-03-04  2565  					dst_cache, info);
e5d4b29fe86a91 drivers/net/vxlan.c            Jiri Benc           2015-12-07  2566  		if (IS_ERR(ndst)) {
8ebd115bb23ac4 drivers/net/vxlan.c            David S. Miller     2016-11-15  2567  			err = PTR_ERR(ndst);
c46b7897ad5ba4 drivers/net/vxlan.c            pravin shelar       2016-11-13  2568  			ndst = NULL;
e4c7ed415387cf drivers/net/vxlan.c            Cong Wang           2013-08-31  2569  			goto tx_error;
e4c7ed415387cf drivers/net/vxlan.c            Cong Wang           2013-08-31  2570  		}
655c3de16540b8 drivers/net/vxlan.c            pravin shelar       2016-11-13  2571  
fee1fad7c73dd0 drivers/net/vxlan.c            pravin shelar       2016-11-13  2572  		if (!info) {
fee1fad7c73dd0 drivers/net/vxlan.c            pravin shelar       2016-11-13  2573  			u32 rt6i_flags = ((struct rt6_info *)ndst)->rt6i_flags;
e4c7ed415387cf drivers/net/vxlan.c            Cong Wang           2013-08-31  2574  
fee1fad7c73dd0 drivers/net/vxlan.c            pravin shelar       2016-11-13  2575  			err = encap_bypass_if_local(skb, dev, vxlan, dst,
49f810f00fa347 drivers/net/vxlan.c            Matthias Schiffer   2017-06-19  2576  						    dst_port, ifindex, vni,
49f810f00fa347 drivers/net/vxlan.c            Matthias Schiffer   2017-06-19  2577  						    ndst, rt6i_flags);
fee1fad7c73dd0 drivers/net/vxlan.c            pravin shelar       2016-11-13  2578  			if (err)
56de859e9967c0 drivers/net/vxlan.c            Jakub Kicinski      2017-02-24  2579  				goto out_unlock;
fee1fad7c73dd0 drivers/net/vxlan.c            pravin shelar       2016-11-13  2580  		}
35e2d1152b22ea drivers/net/vxlan.c            Jesse Gross         2016-01-20  2581  
94d166c5318c6e drivers/net/vxlan/vxlan_core.c Jiri Benc           2023-07-20  2582  		err = skb_tunnel_check_pmtu(skb, ndst,
94d166c5318c6e drivers/net/vxlan/vxlan_core.c Jiri Benc           2023-07-20  2583  					    vxlan_headroom((flags & VXLAN_F_GPE) | VXLAN_F_IPV6),
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2584  					    netif_is_any_bridge_port(dev));
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2585  		if (err < 0) {
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2586  			goto tx_error;
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2587  		} else if (err) {
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2588  			if (info) {
30a93d2b7d5a7c drivers/net/vxlan.c            Antoine Tenart      2021-03-25  2589  				struct ip_tunnel_info *unclone;
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2590  				struct in6_addr src, dst;
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2591  
30a93d2b7d5a7c drivers/net/vxlan.c            Antoine Tenart      2021-03-25  2592  				unclone = skb_tunnel_info_unclone(skb);
30a93d2b7d5a7c drivers/net/vxlan.c            Antoine Tenart      2021-03-25  2593  				if (unlikely(!unclone))
30a93d2b7d5a7c drivers/net/vxlan.c            Antoine Tenart      2021-03-25  2594  					goto tx_error;
30a93d2b7d5a7c drivers/net/vxlan.c            Antoine Tenart      2021-03-25  2595  
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2596  				src = remote_ip.sin6.sin6_addr;
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2597  				dst = local_ip.sin6.sin6_addr;
30a93d2b7d5a7c drivers/net/vxlan.c            Antoine Tenart      2021-03-25  2598  				unclone->key.u.ipv6.src = src;
30a93d2b7d5a7c drivers/net/vxlan.c            Antoine Tenart      2021-03-25  2599  				unclone->key.u.ipv6.dst = dst;
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2600  			}
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2601  
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2602  			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2603  			dst_release(ndst);
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2604  			goto out_unlock;
fc68c99577cc66 drivers/net/vxlan.c            Stefano Brivio      2020-08-04  2605  		}
a93bf0ff449064 drivers/net/vxlan.c            Xin Long            2017-12-18  2606  
a0dced17ad9dc0 drivers/net/vxlan.c            Hangbin Liu         2020-08-05  2607  		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
e4c7ed415387cf drivers/net/vxlan.c            Cong Wang           2013-08-31  2608  		ttl = ttl ? : ip6_dst_hoplimit(ndst);
f491e56dba511d drivers/net/vxlan.c            Jiri Benc           2016-02-02  2609  		skb_scrub_packet(skb, xnet);
f491e56dba511d drivers/net/vxlan.c            Jiri Benc           2016-02-02  2610  		err = vxlan_build_skb(skb, ndst, sizeof(struct ipv6hdr),
54bfd872bf16d4 drivers/net/vxlan.c            Jiri Benc           2016-02-16  2611  				      vni, md, flags, udp_sum);
c46b7897ad5ba4 drivers/net/vxlan.c            pravin shelar       2016-11-13  2612  		if (err < 0)
c46b7897ad5ba4 drivers/net/vxlan.c            pravin shelar       2016-11-13  2613  			goto tx_error;
c46b7897ad5ba4 drivers/net/vxlan.c            pravin shelar       2016-11-13  2614  
0770b53bd276a7 drivers/net/vxlan.c            pravin shelar       2016-11-13  2615  		udp_tunnel6_xmit_skb(ndst, sock6->sock->sk, skb, dev,
1158632b5a2dcc drivers/net/vxlan.c            Brian Russell       2017-02-24  2616  				     &local_ip.sin6.sin6_addr,
272d96a5ab1066 drivers/net/vxlan.c            pravin shelar       2016-08-05  2617  				     &dst->sin6.sin6_addr, tos, ttl,
e7f70af111f086 drivers/net/vxlan.c            Daniel Borkmann     2016-03-09  2618  				     label, src_port, dst_port, !udp_sum);
e4c7ed415387cf drivers/net/vxlan.c            Cong Wang           2013-08-31  2619  #endif
e4c7ed415387cf drivers/net/vxlan.c            Cong Wang           2013-08-31  2620  	}
4095e0e1328a3c drivers/net/vxlan/vxlan_core.c Nikolay Aleksandrov 2022-03-01  2621  	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX, pkt_len);
56de859e9967c0 drivers/net/vxlan.c            Jakub Kicinski      2017-02-24  2622  out_unlock:
56de859e9967c0 drivers/net/vxlan.c            Jakub Kicinski      2017-02-24  2623  	rcu_read_unlock();
4ad169300a7350 drivers/net/vxlan.c            Stephen Hemminger   2013-06-17  2624  	return;
d342894c5d2f8c drivers/net/vxlan.c            stephen hemminger   2012-10-01  2625  
d342894c5d2f8c drivers/net/vxlan.c            stephen hemminger   2012-10-01  2626  drop:
d342894c5d2f8c drivers/net/vxlan.c            stephen hemminger   2012-10-01  2627  	dev->stats.tx_dropped++;
4095e0e1328a3c drivers/net/vxlan/vxlan_core.c Nikolay Aleksandrov 2022-03-01  2628  	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_DROPS, 0);
c46b7897ad5ba4 drivers/net/vxlan.c            pravin shelar       2016-11-13  2629  	dev_kfree_skb(skb);
c46b7897ad5ba4 drivers/net/vxlan.c            pravin shelar       2016-11-13  2630  	return;
d342894c5d2f8c drivers/net/vxlan.c            stephen hemminger   2012-10-01  2631  
d342894c5d2f8c drivers/net/vxlan.c            stephen hemminger   2012-10-01  2632  tx_error:
56de859e9967c0 drivers/net/vxlan.c            Jakub Kicinski      2017-02-24  2633  	rcu_read_unlock();
655c3de16540b8 drivers/net/vxlan.c            pravin shelar       2016-11-13  2634  	if (err == -ELOOP)
655c3de16540b8 drivers/net/vxlan.c            pravin shelar       2016-11-13  2635  		dev->stats.collisions++;
655c3de16540b8 drivers/net/vxlan.c            pravin shelar       2016-11-13  2636  	else if (err == -ENETUNREACH)
655c3de16540b8 drivers/net/vxlan.c            pravin shelar       2016-11-13  2637  		dev->stats.tx_carrier_errors++;
c46b7897ad5ba4 drivers/net/vxlan.c            pravin shelar       2016-11-13  2638  	dst_release(ndst);
d342894c5d2f8c drivers/net/vxlan.c            stephen hemminger   2012-10-01  2639  	dev->stats.tx_errors++;
4095e0e1328a3c drivers/net/vxlan/vxlan_core.c Nikolay Aleksandrov 2022-03-01  2640  	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_ERRORS, 0);
c46b7897ad5ba4 drivers/net/vxlan.c            pravin shelar       2016-11-13  2641  	kfree_skb(skb);
d342894c5d2f8c drivers/net/vxlan.c            stephen hemminger   2012-10-01  2642  }
d342894c5d2f8c drivers/net/vxlan.c            stephen hemminger   2012-10-01  2643  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
