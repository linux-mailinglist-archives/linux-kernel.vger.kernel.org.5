Return-Path: <linux-kernel+bounces-158142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BB58B1C1A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0212883B6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CA16E2AE;
	Thu, 25 Apr 2024 07:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+gL0k7z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445235D477;
	Thu, 25 Apr 2024 07:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714031092; cv=none; b=W0RYQKTdImTGwTVYdoNwyFMYzASEcUK65H6EatzfOiIVnbgjl31qzDZng9cHa2cpgtMNKmABgbAIXZR9VfF3fDiAWarEeMEiGa9z7go7gKXA3BMO9kuh2TllvxsNL0cqYXV386QdNlX4OMPjwiMXxy+ltlElKzFPEYvEkb0Vqbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714031092; c=relaxed/simple;
	bh=rbX1x4TtwxifDMMdKqyi1QPKjCEIzapcUurPaX8Pusg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqk6SSCfvCpANRi/w7FNMOt8rAODZrlIGEq2lct9UJgeNnkRMnFvxrvlUg4ISGI3g1nmTcouovgI000KDx5C8fWR3uH83vqaUlin6tp9kePUtZLP58fDtaRZ44BYFEExiHJWSWpAT2MHvKW1fp263oupmvE1E7Y2skDJm1RYJ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+gL0k7z; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714031091; x=1745567091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rbX1x4TtwxifDMMdKqyi1QPKjCEIzapcUurPaX8Pusg=;
  b=Q+gL0k7zgTVNzGqoSZx1ZX/utkqdFj7dUE/kDCcNlgKgPRtF3WJCo5KA
   sIRvToY/RO0o5gobPAKtzrvYCIA0mjHZ7SqgT3evlEwe0+B/90h2QuuG2
   ddwiHf1156Ex610peGl46jZEpsw25BiN5xSicRGAi6Y2sjdPpENPkIorD
   P+7bbeQCqYMmbaqrPpQwz7H/QwMC6Au9iDNUrAc/G8WmhU6zX8ZPBzMBh
   45VYLfYXznOP48zJ2/amH2w7HCP/JSgkU4yV9PF7sbBQyd2sXSWM72gLe
   bVa2KJNKxDyKT1gvB3QsM4zdlCrzYlVL/PIEr5AooS8HtAQWlee4Ncr/X
   A==;
X-CSE-ConnectionGUID: 9kAdhV/+QeSca8Y+jYd+pw==
X-CSE-MsgGUID: HaHrPoW0SviBUXJzMugBfQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9863056"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="9863056"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 00:44:51 -0700
X-CSE-ConnectionGUID: acf16ZVORAGiprmzlKwKDQ==
X-CSE-MsgGUID: djmKY/R8TruoiMqNuEWQ4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="25017439"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 25 Apr 2024 00:44:48 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rztmf-00028W-2m;
	Thu, 25 Apr 2024 07:44:45 +0000
Date: Thu, 25 Apr 2024 15:44:04 +0800
From: kernel test robot <lkp@intel.com>
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: add heuristic for enabling TCP
 fraglist GRO
Message-ID: <202404251517.ZUALo8e5-lkp@intel.com>
References: <20240424180458.56211-5-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424180458.56211-5-nbd@nbd.name>

Hi Felix,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Felix-Fietkau/net-move-skb_gro_receive_list-from-udp-to-core/20240425-060838
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240424180458.56211-5-nbd%40nbd.name
patch subject: [PATCH net-next 4/4] net: add heuristic for enabling TCP fraglist GRO
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20240425/202404251517.ZUALo8e5-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240425/202404251517.ZUALo8e5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404251517.ZUALo8e5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/ipv6/tcpv6_offload.c: In function 'tcp6_check_fraglist_gro':
   net/ipv6/tcpv6_offload.c:48:14: error: implicit declaration of function '__inet6_lookup_established'; did you mean '__inet_lookup_established'? [-Werror=implicit-function-declaration]
      48 |         sk = __inet6_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |              __inet_lookup_established
>> net/ipv6/tcpv6_offload.c:48:12: warning: assignment to 'struct sock *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      48 |         sk = __inet6_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
         |            ^
   cc1: some warnings being treated as errors


vim +48 net/ipv6/tcpv6_offload.c

    16	
    17	static bool tcp6_check_fraglist_gro(struct sk_buff *skb)
    18	{
    19		const struct ipv6hdr *hdr = skb_gro_network_header(skb);
    20		struct net *net = dev_net(skb->dev);
    21		unsigned int off, hlen, thlen;
    22		struct tcphdr *th;
    23		struct sock *sk;
    24		int iif, sdif;
    25	
    26		if (!(skb->dev->features & NETIF_F_GRO_FRAGLIST))
    27			return false;
    28	
    29		inet6_get_iif_sdif(skb, &iif, &sdif);
    30	
    31		off = skb_gro_offset(skb);
    32		hlen = off + sizeof(*th);
    33		th = skb_gro_header(skb, hlen, off);
    34		if (unlikely(!th))
    35			return false;
    36	
    37		thlen = th->doff * 4;
    38		if (thlen < sizeof(*th))
    39			return false;
    40	
    41		hlen = off + thlen;
    42		if (!skb_gro_may_pull(skb, hlen)) {
    43			th = skb_gro_header_slow(skb, hlen, off);
    44			if (unlikely(!th))
    45				return false;
    46		}
    47	
  > 48		sk = __inet6_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
    49						&hdr->saddr, th->source,
    50						&hdr->daddr, ntohs(th->dest),
    51						iif, sdif);
    52		if (!sk)
    53			return true;
    54	
    55		sock_put(sk);
    56	
    57		return false;
    58	}
    59	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

