Return-Path: <linux-kernel+bounces-10502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAC481D527
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 17:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CF06B21849
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 16:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626A8FBF0;
	Sat, 23 Dec 2023 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHZrldiY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6472A12E4C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703349986; x=1734885986;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eYi+dBPZr3QsXQetIR389qf6Ip2of8g5VQBp5M0uZzY=;
  b=jHZrldiYR+lI/9LQQimj32o5tVA/soNJy+5ICwrx4US1/sDPyo5VLWGy
   4GTDK/7Ekjvdqan0CKvaKLeP4qalsCuAhWJK1XUBMwPzfZ6wzQtVQNVoz
   6bEira4K0XJ+epj8CaqxvWp7X/kh14WcSkj1eOytDqr7oN1j+NlWMNug1
   CPio0khO6BFcmWPdrwSMcaGtLA7LsIfEEYwjTAF1iSO/BE5GNqaudLVwJ
   MUCw4CgvDpSD5rZ32NFmsLchgRQYIF6ghNjTTK5flnjw4y+jOnmxHLueA
   wFqu7+84GM7M/tNYUNUhxtb90PRoTowYcNgc/ep7Kajjfz2TCBFUX9fg+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="395094929"
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="395094929"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 08:46:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="811652336"
X-IronPort-AV: E=Sophos;i="6.04,299,1695711600"; 
   d="scan'208";a="811652336"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 23 Dec 2023 08:46:23 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rH57o-000BDE-02;
	Sat, 23 Dec 2023 16:45:42 +0000
Date: Sun, 24 Dec 2023 00:41:43 +0800
From: kernel test robot <lkp@intel.com>
To: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: net/netfilter/ipvs/ip_vs_core.c:1666:15: warning: variable
 'outer_proto' set but not used
Message-ID: <202312240023.NpJRWsBC-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Haishuang,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5254c0cbc92d2a08e75443bdb914f1c4839cdf5a
commit: 73348fed35d023e998cbd303a28400f2c0ec30a3 ipvs: optimize tunnel dumps for icmp errors
date:   3 years, 9 months ago
config: s390-defconfig (https://download.01.org/0day-ci/archive/20231224/202312240023.NpJRWsBC-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231224/202312240023.NpJRWsBC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312240023.NpJRWsBC-lkp@intel.com/

All warnings (new ones prefixed by >>):

         |                                         ^~~~~~~~~~~~
   include/net/sch_generic.h:883:9: note: in expansion of macro 'this_cpu_inc'
     883 |         this_cpu_inc(sch->cpu_qstats->qlen);
         |         ^~~~~~~~~~~~
   include/net/sch_generic.h: In function 'qdisc_qstats_cpu_qlen_dec':
   arch/s390/include/asm/percpu.h:74:28: warning: comparison is always true due to limited range of data type [-Wtype-limits]
      74 |             ((szcast)val__ > -129) && ((szcast)val__ < 128)) {          \
         |                            ^
   arch/s390/include/asm/percpu.h:91:34: note: in expansion of macro 'arch_this_cpu_add'
      91 | #define this_cpu_add_8(pcp, val) arch_this_cpu_add(pcp, val, "laag", "agsi", long)
         |                                  ^~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:380:25: note: in expansion of macro 'this_cpu_add_8'
     380 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
         |                         ^~~~
   include/linux/percpu-defs.h:509:41: note: in expansion of macro '__pcpu_size_call'
     509 | #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:519:41: note: in expansion of macro 'this_cpu_add'
     519 | #define this_cpu_sub(pcp, val)          this_cpu_add(pcp, -(typeof(pcp))(val))
         |                                         ^~~~~~~~~~~~
   include/linux/percpu-defs.h:521:41: note: in expansion of macro 'this_cpu_sub'
     521 | #define this_cpu_dec(pcp)               this_cpu_sub(pcp, 1)
         |                                         ^~~~~~~~~~~~
   include/net/sch_generic.h:888:9: note: in expansion of macro 'this_cpu_dec'
     888 |         this_cpu_dec(sch->cpu_qstats->qlen);
         |         ^~~~~~~~~~~~
   include/net/sch_generic.h: In function 'qdisc_qstats_cpu_requeues_inc':
   arch/s390/include/asm/percpu.h:74:28: warning: comparison is always true due to limited range of data type [-Wtype-limits]
      74 |             ((szcast)val__ > -129) && ((szcast)val__ < 128)) {          \
         |                            ^
   arch/s390/include/asm/percpu.h:91:34: note: in expansion of macro 'arch_this_cpu_add'
      91 | #define this_cpu_add_8(pcp, val) arch_this_cpu_add(pcp, val, "laag", "agsi", long)
         |                                  ^~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:380:25: note: in expansion of macro 'this_cpu_add_8'
     380 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
         |                         ^~~~
   include/linux/percpu-defs.h:509:41: note: in expansion of macro '__pcpu_size_call'
     509 | #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:520:41: note: in expansion of macro 'this_cpu_add'
     520 | #define this_cpu_inc(pcp)               this_cpu_add(pcp, 1)
         |                                         ^~~~~~~~~~~~
   include/net/sch_generic.h:893:9: note: in expansion of macro 'this_cpu_inc'
     893 |         this_cpu_inc(sch->cpu_qstats->requeues);
         |         ^~~~~~~~~~~~
   include/net/sch_generic.h: In function 'qdisc_qstats_cpu_drop':
   arch/s390/include/asm/percpu.h:74:28: warning: comparison is always true due to limited range of data type [-Wtype-limits]
      74 |             ((szcast)val__ > -129) && ((szcast)val__ < 128)) {          \
         |                            ^
   arch/s390/include/asm/percpu.h:91:34: note: in expansion of macro 'arch_this_cpu_add'
      91 | #define this_cpu_add_8(pcp, val) arch_this_cpu_add(pcp, val, "laag", "agsi", long)
         |                                  ^~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:380:25: note: in expansion of macro 'this_cpu_add_8'
     380 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
         |                         ^~~~
   include/linux/percpu-defs.h:509:41: note: in expansion of macro '__pcpu_size_call'
     509 | #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:520:41: note: in expansion of macro 'this_cpu_add'
     520 | #define this_cpu_inc(pcp)               this_cpu_add(pcp, 1)
         |                                         ^~~~~~~~~~~~
   include/net/sch_generic.h:918:9: note: in expansion of macro 'this_cpu_inc'
     918 |         this_cpu_inc(sch->cpu_qstats->drops);
         |         ^~~~~~~~~~~~
   include/net/sch_generic.h: In function 'qdisc_update_stats_at_enqueue':
   arch/s390/include/asm/percpu.h:74:28: warning: comparison is always true due to limited range of data type [-Wtype-limits]
      74 |             ((szcast)val__ > -129) && ((szcast)val__ < 128)) {          \
         |                            ^
   arch/s390/include/asm/percpu.h:91:34: note: in expansion of macro 'arch_this_cpu_add'
      91 | #define this_cpu_add_8(pcp, val) arch_this_cpu_add(pcp, val, "laag", "agsi", long)
         |                                  ^~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:380:25: note: in expansion of macro 'this_cpu_add_8'
     380 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
         |                         ^~~~
   include/linux/percpu-defs.h:509:41: note: in expansion of macro '__pcpu_size_call'
     509 | #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
         |                                         ^~~~~~~~~~~~~~~~
   include/net/sch_generic.h:1117:17: note: in expansion of macro 'this_cpu_add'
    1117 |                 this_cpu_add(sch->cpu_qstats->backlog, pkt_len);
         |                 ^~~~~~~~~~~~
   include/net/sch_generic.h: In function 'mini_qdisc_qstats_cpu_drop':
   arch/s390/include/asm/percpu.h:74:28: warning: comparison is always true due to limited range of data type [-Wtype-limits]
      74 |             ((szcast)val__ > -129) && ((szcast)val__ < 128)) {          \
         |                            ^
   arch/s390/include/asm/percpu.h:91:34: note: in expansion of macro 'arch_this_cpu_add'
      91 | #define this_cpu_add_8(pcp, val) arch_this_cpu_add(pcp, val, "laag", "agsi", long)
         |                                  ^~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:380:25: note: in expansion of macro 'this_cpu_add_8'
     380 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
         |                         ^~~~
   include/linux/percpu-defs.h:509:41: note: in expansion of macro '__pcpu_size_call'
     509 | #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:520:41: note: in expansion of macro 'this_cpu_add'
     520 | #define this_cpu_inc(pcp)               this_cpu_add(pcp, 1)
         |                                         ^~~~~~~~~~~~
   include/net/sch_generic.h:1286:9: note: in expansion of macro 'this_cpu_inc'
    1286 |         this_cpu_inc(miniq->cpu_qstats->drops);
         |         ^~~~~~~~~~~~
   net/netfilter/ipvs/ip_vs_core.c: In function 'ip_vs_in_icmp':
>> net/netfilter/ipvs/ip_vs_core.c:1666:15: warning: variable 'outer_proto' set but not used [-Wunused-but-set-variable]
    1666 |         char *outer_proto;
         |               ^~~~~~~~~~~
   In file included from include/net/ip_tunnels.h:16,
                    from include/net/gre.h:6,
                    from net/netfilter/ipvs/ip_vs_core.c:38:
   In function 'net_generic',
       inlined from '__ip_vs_init' at net/netfilter/ipvs/ip_vs_core.c:2361:9:
   include/net/netns/generic.h:46:22: warning: array subscript <unknown> is outside array bounds of 'void *[0]' [-Warray-bounds=]
      46 |         ptr = ng->ptr[id];
         |               ~~~~~~~^~~~
   include/net/netns/generic.h: In function '__ip_vs_init':
   include/net/netns/generic.h:35:23: note: while referencing 'ptr'
      35 |                 void *ptr[0];
         |                       ^~~
   In file included from arch/s390/include/asm/bitops.h:39,
                    from include/linux/bitops.h:29,
                    from include/linux/kernel.h:12,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12:
   In function '__atomic_add',
       inlined from '__preempt_count_add' at arch/s390/include/asm/preempt.h:58:3,
       inlined from '__local_bh_disable_ip' at include/linux/bottom_half.h:12:2,
       inlined from 'local_bh_disable' at include/linux/bottom_half.h:19:2,
       inlined from 'ip_vs_conn_stats' at net/netfilter/ipvs/ip_vs_core.c:211:2,
       inlined from 'ip_vs_sched_persist' at net/netfilter/ipvs/ip_vs_core.c:426:2:
   arch/s390/include/asm/atomic_ops.h:18:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds=]
      18 |         asm volatile(                                                   \
         |         ^~~
   arch/s390/include/asm/atomic_ops.h:27:9: note: in expansion of macro '__ATOMIC_OP'
      27 |         __ATOMIC_OP(op_name, op_type, op_string, "\n")                  \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:30:1: note: in expansion of macro '__ATOMIC_OPS'
      30 | __ATOMIC_OPS(__atomic_add, int, "laa")
         | ^~~~~~~~~~~~
   In function 'ip_vs_sched_persist':
   cc1: note: source object is likely at address zero
   In function '__atomic_add',
       inlined from '__preempt_count_add' at arch/s390/include/asm/preempt.h:58:3,
       inlined from '__local_bh_disable_ip' at include/linux/bottom_half.h:12:2,
       inlined from 'local_bh_disable' at include/linux/bottom_half.h:19:2,
       inlined from 'ip_vs_conn_stats' at net/netfilter/ipvs/ip_vs_core.c:211:2,
       inlined from 'ip_vs_sched_persist' at net/netfilter/ipvs/ip_vs_core.c:426:2:
   arch/s390/include/asm/atomic_ops.h:18:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds=]
      18 |         asm volatile(                                                   \
         |         ^~~
   arch/s390/include/asm/atomic_ops.h:27:9: note: in expansion of macro '__ATOMIC_OP'
      27 |         __ATOMIC_OP(op_name, op_type, op_string, "\n")                  \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:30:1: note: in expansion of macro '__ATOMIC_OPS'
      30 | __ATOMIC_OPS(__atomic_add, int, "laa")
         | ^~~~~~~~~~~~
   In function 'ip_vs_sched_persist':
   cc1: note: source object is likely at address zero
   In function '__atomic_add',
       inlined from '__preempt_count_add' at arch/s390/include/asm/preempt.h:58:3,
       inlined from '__local_bh_disable_ip' at include/linux/bottom_half.h:12:2,
       inlined from 'local_bh_disable' at include/linux/bottom_half.h:19:2,
       inlined from 'ip_vs_conn_stats' at net/netfilter/ipvs/ip_vs_core.c:211:2,
       inlined from 'ip_vs_new_conn_out' at net/netfilter/ipvs/ip_vs_core.c:1220:2:
   arch/s390/include/asm/atomic_ops.h:18:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds=]
      18 |         asm volatile(                                                   \
         |         ^~~
   arch/s390/include/asm/atomic_ops.h:27:9: note: in expansion of macro '__ATOMIC_OP'
      27 |         __ATOMIC_OP(op_name, op_type, op_string, "\n")                  \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:30:1: note: in expansion of macro '__ATOMIC_OPS'
      30 | __ATOMIC_OPS(__atomic_add, int, "laa")
         | ^~~~~~~~~~~~
   In function 'ip_vs_new_conn_out':
   cc1: note: source object is likely at address zero
   In function '__atomic_add',
       inlined from '__preempt_count_add' at arch/s390/include/asm/preempt.h:58:3,
       inlined from '__local_bh_disable_ip' at include/linux/bottom_half.h:12:2,
       inlined from 'local_bh_disable' at include/linux/bottom_half.h:19:2,
       inlined from 'ip_vs_conn_stats' at net/netfilter/ipvs/ip_vs_core.c:211:2,
       inlined from 'ip_vs_new_conn_out' at net/netfilter/ipvs/ip_vs_core.c:1220:2:
   arch/s390/include/asm/atomic_ops.h:18:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds=]
      18 |         asm volatile(                                                   \
         |         ^~~
   arch/s390/include/asm/atomic_ops.h:27:9: note: in expansion of macro '__ATOMIC_OP'
      27 |         __ATOMIC_OP(op_name, op_type, op_string, "\n")                  \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:30:1: note: in expansion of macro '__ATOMIC_OPS'
      30 | __ATOMIC_OPS(__atomic_add, int, "laa")
         | ^~~~~~~~~~~~
   In function 'ip_vs_new_conn_out':
   cc1: note: source object is likely at address zero
   In function '__atomic_add',
       inlined from '__preempt_count_add' at arch/s390/include/asm/preempt.h:58:3,
       inlined from '__local_bh_disable_ip' at include/linux/bottom_half.h:12:2,
       inlined from 'local_bh_disable' at include/linux/bottom_half.h:19:2,
       inlined from 'ip_vs_out_stats' at net/netfilter/ipvs/ip_vs_core.c:179:3,
       inlined from 'handle_response.constprop' at net/netfilter/ipvs/ip_vs_core.c:1325:2:
   arch/s390/include/asm/atomic_ops.h:18:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds=]
      18 |         asm volatile(                                                   \
         |         ^~~
   arch/s390/include/asm/atomic_ops.h:27:9: note: in expansion of macro '__ATOMIC_OP'
      27 |         __ATOMIC_OP(op_name, op_type, op_string, "\n")                  \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:30:1: note: in expansion of macro '__ATOMIC_OPS'


vim +/outer_proto +1666 net/netfilter/ipvs/ip_vs_core.c

  1645	
  1646	/*
  1647	 *	Handle ICMP messages in the outside-to-inside direction (incoming).
  1648	 *	Find any that might be relevant, check against existing connections,
  1649	 *	forward to the right destination host if relevant.
  1650	 *	Currently handles error types - unreachable, quench, ttl exceeded.
  1651	 */
  1652	static int
  1653	ip_vs_in_icmp(struct netns_ipvs *ipvs, struct sk_buff *skb, int *related,
  1654		      unsigned int hooknum)
  1655	{
  1656		struct iphdr *iph;
  1657		struct icmphdr	_icmph, *ic;
  1658		struct iphdr	_ciph, *cih;	/* The ip header contained within the ICMP */
  1659		struct ip_vs_iphdr ciph;
  1660		struct ip_vs_conn *cp;
  1661		struct ip_vs_protocol *pp;
  1662		struct ip_vs_proto_data *pd;
  1663		unsigned int offset, offset2, ihl, verdict;
  1664		bool tunnel, new_cp = false;
  1665		union nf_inet_addr *raddr;
> 1666		char *outer_proto;
  1667	
  1668		*related = 1;
  1669	
  1670		/* reassemble IP fragments */
  1671		if (ip_is_fragment(ip_hdr(skb))) {
  1672			if (ip_vs_gather_frags(ipvs, skb, ip_vs_defrag_user(hooknum)))
  1673				return NF_STOLEN;
  1674		}
  1675	
  1676		iph = ip_hdr(skb);
  1677		offset = ihl = iph->ihl * 4;
  1678		ic = skb_header_pointer(skb, offset, sizeof(_icmph), &_icmph);
  1679		if (ic == NULL)
  1680			return NF_DROP;
  1681	
  1682		IP_VS_DBG(12, "Incoming ICMP (%d,%d) %pI4->%pI4\n",
  1683			  ic->type, ntohs(icmp_id(ic)),
  1684			  &iph->saddr, &iph->daddr);
  1685	
  1686		/*
  1687		 * Work through seeing if this is for us.
  1688		 * These checks are supposed to be in an order that means easy
  1689		 * things are checked first to speed up processing.... however
  1690		 * this means that some packets will manage to get a long way
  1691		 * down this stack and then be rejected, but that's life.
  1692		 */
  1693		if ((ic->type != ICMP_DEST_UNREACH) &&
  1694		    (ic->type != ICMP_SOURCE_QUENCH) &&
  1695		    (ic->type != ICMP_TIME_EXCEEDED)) {
  1696			*related = 0;
  1697			return NF_ACCEPT;
  1698		}
  1699	
  1700		/* Now find the contained IP header */
  1701		offset += sizeof(_icmph);
  1702		cih = skb_header_pointer(skb, offset, sizeof(_ciph), &_ciph);
  1703		if (cih == NULL)
  1704			return NF_ACCEPT; /* The packet looks wrong, ignore */
  1705		raddr = (union nf_inet_addr *)&cih->daddr;
  1706	
  1707		/* Special case for errors for IPIP/UDP/GRE tunnel packets */
  1708		tunnel = false;
  1709		if (cih->protocol == IPPROTO_IPIP) {
  1710			struct ip_vs_dest *dest;
  1711	
  1712			if (unlikely(cih->frag_off & htons(IP_OFFSET)))
  1713				return NF_ACCEPT;
  1714			/* Error for our IPIP must arrive at LOCAL_IN */
  1715			if (!(skb_rtable(skb)->rt_flags & RTCF_LOCAL))
  1716				return NF_ACCEPT;
  1717			dest = ip_vs_find_tunnel(ipvs, AF_INET, raddr, 0);
  1718			/* Only for known tunnel */
  1719			if (!dest || dest->tun_type != IP_VS_CONN_F_TUNNEL_TYPE_IPIP)
  1720				return NF_ACCEPT;
  1721			offset += cih->ihl * 4;
  1722			cih = skb_header_pointer(skb, offset, sizeof(_ciph), &_ciph);
  1723			if (cih == NULL)
  1724				return NF_ACCEPT; /* The packet looks wrong, ignore */
  1725			tunnel = true;
  1726			outer_proto = "IPIP";
  1727		} else if ((cih->protocol == IPPROTO_UDP ||	/* Can be UDP encap */
  1728			    cih->protocol == IPPROTO_GRE) &&	/* Can be GRE encap */
  1729			   /* Error for our tunnel must arrive at LOCAL_IN */
  1730			   (skb_rtable(skb)->rt_flags & RTCF_LOCAL)) {
  1731			__u8 iproto;
  1732			int ulen;
  1733	
  1734			/* Non-first fragment has no UDP/GRE header */
  1735			if (unlikely(cih->frag_off & htons(IP_OFFSET)))
  1736				return NF_ACCEPT;
  1737			offset2 = offset + cih->ihl * 4;
  1738			if (cih->protocol == IPPROTO_UDP) {
  1739				ulen = ipvs_udp_decap(ipvs, skb, offset2, AF_INET,
  1740						      raddr, &iproto);
  1741				outer_proto = "UDP";
  1742			} else {
  1743				ulen = ipvs_gre_decap(ipvs, skb, offset2, AF_INET,
  1744						      raddr, &iproto);
  1745				outer_proto = "GRE";
  1746			}
  1747			if (ulen > 0) {
  1748				/* Skip IP and UDP/GRE tunnel headers */
  1749				offset = offset2 + ulen;
  1750				/* Now we should be at the original IP header */
  1751				cih = skb_header_pointer(skb, offset, sizeof(_ciph),
  1752							 &_ciph);
  1753				if (cih && cih->version == 4 && cih->ihl >= 5 &&
  1754				    iproto == IPPROTO_IPIP)
  1755					tunnel = true;
  1756				else
  1757					return NF_ACCEPT;
  1758			}
  1759		}
  1760	
  1761		pd = ip_vs_proto_data_get(ipvs, cih->protocol);
  1762		if (!pd)
  1763			return NF_ACCEPT;
  1764		pp = pd->pp;
  1765	
  1766		/* Is the embedded protocol header present? */
  1767		if (unlikely(cih->frag_off & htons(IP_OFFSET) &&
  1768			     pp->dont_defrag))
  1769			return NF_ACCEPT;
  1770	
  1771		IP_VS_DBG_PKT(11, AF_INET, pp, skb, offset,
  1772			      "Checking incoming ICMP for");
  1773	
  1774		offset2 = offset;
  1775		ip_vs_fill_iph_skb_icmp(AF_INET, skb, offset, !tunnel, &ciph);
  1776		offset = ciph.len;
  1777	
  1778		/* The embedded headers contain source and dest in reverse order.
  1779		 * For IPIP/UDP/GRE tunnel this is error for request, not for reply.
  1780		 */
  1781		cp = INDIRECT_CALL_1(pp->conn_in_get, ip_vs_conn_in_get_proto,
  1782				     ipvs, AF_INET, skb, &ciph);
  1783	
  1784		if (!cp) {
  1785			int v;
  1786	
  1787			if (tunnel || !sysctl_schedule_icmp(ipvs))
  1788				return NF_ACCEPT;
  1789	
  1790			if (!ip_vs_try_to_schedule(ipvs, AF_INET, skb, pd, &v, &cp, &ciph))
  1791				return v;
  1792			new_cp = true;
  1793		}
  1794	
  1795		verdict = NF_DROP;
  1796	
  1797		/* Ensure the checksum is correct */
  1798		if (!skb_csum_unnecessary(skb) && ip_vs_checksum_complete(skb, ihl)) {
  1799			/* Failed checksum! */
  1800			IP_VS_DBG(1, "Incoming ICMP: failed checksum from %pI4!\n",
  1801				  &iph->saddr);
  1802			goto out;
  1803		}
  1804	
  1805		if (tunnel) {
  1806			__be32 info = ic->un.gateway;
  1807			__u8 type = ic->type;
  1808			__u8 code = ic->code;
  1809	
  1810			/* Update the MTU */
  1811			if (ic->type == ICMP_DEST_UNREACH &&
  1812			    ic->code == ICMP_FRAG_NEEDED) {
  1813				struct ip_vs_dest *dest = cp->dest;
  1814				u32 mtu = ntohs(ic->un.frag.mtu);
  1815				__be16 frag_off = cih->frag_off;
  1816	
  1817				/* Strip outer IP and ICMP, go to IPIP/UDP/GRE header */
  1818				if (pskb_pull(skb, ihl + sizeof(_icmph)) == NULL)
  1819					goto ignore_tunnel;
  1820				offset2 -= ihl + sizeof(_icmph);
  1821				skb_reset_network_header(skb);
  1822				IP_VS_DBG(12, "ICMP for %s %pI4->%pI4: mtu=%u\n",
  1823					  outer_proto, &ip_hdr(skb)->saddr,
  1824					  &ip_hdr(skb)->daddr, mtu);
  1825				ipv4_update_pmtu(skb, ipvs->net, mtu, 0, 0);
  1826				/* Client uses PMTUD? */
  1827				if (!(frag_off & htons(IP_DF)))
  1828					goto ignore_tunnel;
  1829				/* Prefer the resulting PMTU */
  1830				if (dest) {
  1831					struct ip_vs_dest_dst *dest_dst;
  1832	
  1833					dest_dst = rcu_dereference(dest->dest_dst);
  1834					if (dest_dst)
  1835						mtu = dst_mtu(dest_dst->dst_cache);
  1836				}
  1837				if (mtu > 68 + sizeof(struct iphdr))
  1838					mtu -= sizeof(struct iphdr);
  1839				info = htonl(mtu);
  1840			}
  1841			/* Strip outer IP, ICMP and IPIP/UDP/GRE, go to IP header of
  1842			 * original request.
  1843			 */
  1844			if (pskb_pull(skb, offset2) == NULL)
  1845				goto ignore_tunnel;
  1846			skb_reset_network_header(skb);
  1847			IP_VS_DBG(12, "Sending ICMP for %pI4->%pI4: t=%u, c=%u, i=%u\n",
  1848				&ip_hdr(skb)->saddr, &ip_hdr(skb)->daddr,
  1849				type, code, ntohl(info));
  1850			icmp_send(skb, type, code, info);
  1851			/* ICMP can be shorter but anyways, account it */
  1852			ip_vs_out_stats(cp, skb);
  1853	
  1854	ignore_tunnel:
  1855			consume_skb(skb);
  1856			verdict = NF_STOLEN;
  1857			goto out;
  1858		}
  1859	
  1860		/* do the statistics and put it back */
  1861		ip_vs_in_stats(cp, skb);
  1862		if (IPPROTO_TCP == cih->protocol || IPPROTO_UDP == cih->protocol ||
  1863		    IPPROTO_SCTP == cih->protocol)
  1864			offset += 2 * sizeof(__u16);
  1865		verdict = ip_vs_icmp_xmit(skb, cp, pp, offset, hooknum, &ciph);
  1866	
  1867	out:
  1868		if (likely(!new_cp))
  1869			__ip_vs_conn_put(cp);
  1870		else
  1871			ip_vs_conn_put(cp);
  1872	
  1873		return verdict;
  1874	}
  1875	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

