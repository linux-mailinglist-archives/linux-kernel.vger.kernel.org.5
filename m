Return-Path: <linux-kernel+bounces-158300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 105258B1E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317021C2406C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B8284DFB;
	Thu, 25 Apr 2024 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PgXlwjHz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA09728F7;
	Thu, 25 Apr 2024 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714037457; cv=none; b=eiX2e2z6nRVkBIMf2tWI/iLyVOIkTmA3NyG9kl+6A2AACtDvia8fwSj489unz6QCkRhwdlS50hCFix0oU+qroyPv3Vr9ORXs223+coJgJnUvW3/xsTEm6Helo3/iChHKnU77OTFs7Ql1SQiBZrNqylcLhO87XHrdx0JiQCQF5cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714037457; c=relaxed/simple;
	bh=BidwcMZvw8hOvIN0VNzLTIwSisk6VgByY2ElyypLUNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RC5JlCwkfWoygg61jYCislNYsfbcDprEQcoANh8tu24NKjgCXjUpBs28TX0g9BPdE+r7xZsgzbGMZjErczTMndH55vbw1+JXPKb9KCK5qWtmStagp80v7WPVU5GmHl/SHywwNBXxUSEhDWfYh+UjV3rKmGytcC9YpPOZHlT8A7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PgXlwjHz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714037456; x=1745573456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BidwcMZvw8hOvIN0VNzLTIwSisk6VgByY2ElyypLUNs=;
  b=PgXlwjHzNZPObJJrN/9XPMFjPZrAf75xUCwX/3f0XKNM79m2OTwKkJLm
   OzU6oAzoY8B6SdWPKMIrrRLvMUyNLnFu3QG/hev4EfhshiRTUS7mdHzbP
   DmxQKI2/zUVeo3PQZGysGi7yoJ2FRTAek/Vjcrk9aHEPjTAiItMe1q3iR
   djM4f1gsBxs2g3QGec4y0xt1BCAqQS4b/BPywfOAQo5tJiFvok8Vr2uML
   BGa/P7jrqLeQilc+SDG0jVG/XFTY3TiacC904Oo+4RI+DssXrCXF3CtvG
   ebd9VR2emUq3GyTqRdX2HfAtv9A0gK3/FCx4o3RHvRB34LmeFx3uPCfp8
   w==;
X-CSE-ConnectionGUID: YA3aW5ybQGK/qo0okejWXA==
X-CSE-MsgGUID: mhgK/B53SxWVr+hPZhDFww==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="13495975"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="13495975"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 02:30:55 -0700
X-CSE-ConnectionGUID: 6Lpm9UTlRXC1Pzb3vKTFXg==
X-CSE-MsgGUID: eDqDKVkqQ2CEowjwPnckpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="29472185"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 25 Apr 2024 02:30:52 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rzvRK-0002Dm-10;
	Thu, 25 Apr 2024 09:30:50 +0000
Date: Thu, 25 Apr 2024 17:30:47 +0800
From: kernel test robot <lkp@intel.com>
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: add heuristic for enabling TCP
 fraglist GRO
Message-ID: <202404251744.Tq24y05K-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Felix-Fietkau/net-move-skb_gro_receive_list-from-udp-to-core/20240425-060838
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240424180458.56211-5-nbd%40nbd.name
patch subject: [PATCH net-next 4/4] net: add heuristic for enabling TCP fraglist GRO
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20240425/202404251744.Tq24y05K-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240425/202404251744.Tq24y05K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404251744.Tq24y05K-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/ipv6/tcpv6_offload.c:9:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from net/ipv6/tcpv6_offload.c:9:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from net/ipv6/tcpv6_offload.c:9:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> net/ipv6/tcpv6_offload.c:48:7: error: call to undeclared function '__inet6_lookup_established'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           sk = __inet6_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
                ^
   net/ipv6/tcpv6_offload.c:48:7: note: did you mean '__inet_lookup_established'?
   include/net/inet_hashtables.h:371:14: note: '__inet_lookup_established' declared here
   struct sock *__inet_lookup_established(struct net *net,
                ^
   net/ipv6/tcpv6_offload.c:48:5: error: incompatible integer to pointer conversion assigning to 'struct sock *' from 'int' [-Wint-conversion]
           sk = __inet6_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   12 warnings and 2 errors generated.


vim +/__inet6_lookup_established +48 net/ipv6/tcpv6_offload.c

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

