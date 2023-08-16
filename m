Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D08377E10A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244940AbjHPMEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244930AbjHPMDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:03:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E9E2121
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692187428; x=1723723428;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Kne35BLzrkePprXduXdVCgfl2Vz+HiuNOI0AGPtE+fQ=;
  b=bxs10II0naWxvcRbGoOL3dfYRoTaGgqlh1e1iZUWIlIc+H8OcW7zlK6W
   Bj867iht8PI+Jb/iJLzHVJSIix1M8oIOYSSuSPRWKOCv9ZelR1vJdwKDi
   mZWIAa9TtedqZfgOreXkgHtsmE4NOScREBObGFqQNbQq6yMx/FQUzRpEo
   FxQdM+G33ti/W52ZReHoh0ClzTWLFOnBrrArZXvCSRh1sL8IC8wz0Y9dC
   KtlpdHsrmTa3mN4EcjEQ4ArsyswI+Ck673LkuRgt4nkbUT3T6uTOzlL50
   Sr0cRp4xi1GhR+hvq12O3y3+JSuP81jnRm/z+ZHcnx7Er/+1vjj9Sq0Qw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403490987"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="403490987"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 05:03:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="1064808185"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="1064808185"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 Aug 2023 05:03:47 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWFFa-0000IL-0x;
        Wed, 16 Aug 2023 12:03:46 +0000
Date:   Wed, 16 Aug 2023 20:03:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Ehrig <cehrig@cloudflare.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: net/ipv4/fou_bpf.c:46:17: warning: no previous declaration for
 'bpf_skb_set_fou_encap'
Message-ID: <202308161949.ynVqsx87-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: c50e96099edb134bf107fafc02715fbc4aa2277f bpf,fou: Add bpf_skb_{set,get}_fou_encap kfuncs
date:   4 months ago
config: x86_64-buildonly-randconfig-r001-20230816 (https://download.01.org/0day-ci/archive/20230816/202308161949.ynVqsx87-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20230816/202308161949.ynVqsx87-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308161949.ynVqsx87-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/ipv4/fou_bpf.c:46:17: warning: no previous declaration for 'bpf_skb_set_fou_encap' [-Wmissing-declarations]
    __bpf_kfunc int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx,
                    ^~~~~~~~~~~~~~~~~~~~~
>> net/ipv4/fou_bpf.c:88:17: warning: no previous declaration for 'bpf_skb_get_fou_encap' [-Wmissing-declarations]
    __bpf_kfunc int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
                    ^~~~~~~~~~~~~~~~~~~~~


vim +/bpf_skb_set_fou_encap +46 net/ipv4/fou_bpf.c

    24	
    25	__diag_push();
    26	__diag_ignore_all("-Wmissing-prototypes",
    27			  "Global functions as their definitions will be in BTF");
    28	
    29	/* bpf_skb_set_fou_encap - Set FOU encap parameters
    30	 *
    31	 * This function allows for using GUE or FOU encapsulation together with an
    32	 * ipip device in collect-metadata mode.
    33	 *
    34	 * It is meant to be used in BPF tc-hooks and after a call to the
    35	 * bpf_skb_set_tunnel_key helper, responsible for setting IP addresses.
    36	 *
    37	 * Parameters:
    38	 * @skb_ctx	Pointer to ctx (__sk_buff) in TC program. Cannot be NULL
    39	 * @encap	Pointer to a `struct bpf_fou_encap` storing UDP src and
    40	 * 		dst ports. If sport is set to 0 the kernel will auto-assign a
    41	 * 		port. This is similar to using `encap-sport auto`.
    42	 * 		Cannot be NULL
    43	 * @type	Encapsulation type for the packet. Their definitions are
    44	 * 		specified in `enum bpf_fou_encap_type`
    45	 */
  > 46	__bpf_kfunc int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx,
    47					      struct bpf_fou_encap *encap, int type)
    48	{
    49		struct sk_buff *skb = (struct sk_buff *)skb_ctx;
    50		struct ip_tunnel_info *info = skb_tunnel_info(skb);
    51	
    52		if (unlikely(!encap))
    53			return -EINVAL;
    54	
    55		if (unlikely(!info || !(info->mode & IP_TUNNEL_INFO_TX)))
    56			return -EINVAL;
    57	
    58		switch (type) {
    59		case FOU_BPF_ENCAP_FOU:
    60			info->encap.type = TUNNEL_ENCAP_FOU;
    61			break;
    62		case FOU_BPF_ENCAP_GUE:
    63			info->encap.type = TUNNEL_ENCAP_GUE;
    64			break;
    65		default:
    66			info->encap.type = TUNNEL_ENCAP_NONE;
    67		}
    68	
    69		if (info->key.tun_flags & TUNNEL_CSUM)
    70			info->encap.flags |= TUNNEL_ENCAP_FLAG_CSUM;
    71	
    72		info->encap.sport = encap->sport;
    73		info->encap.dport = encap->dport;
    74	
    75		return 0;
    76	}
    77	
    78	/* bpf_skb_get_fou_encap - Get FOU encap parameters
    79	 *
    80	 * This function allows for reading encap metadata from a packet received
    81	 * on an ipip device in collect-metadata mode.
    82	 *
    83	 * Parameters:
    84	 * @skb_ctx	Pointer to ctx (__sk_buff) in TC program. Cannot be NULL
    85	 * @encap	Pointer to a struct bpf_fou_encap storing UDP source and
    86	 * 		destination port. Cannot be NULL
    87	 */
  > 88	__bpf_kfunc int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
    89					      struct bpf_fou_encap *encap)
    90	{
    91		struct sk_buff *skb = (struct sk_buff *)skb_ctx;
    92		struct ip_tunnel_info *info = skb_tunnel_info(skb);
    93	
    94		if (unlikely(!info))
    95			return -EINVAL;
    96	
    97		encap->sport = info->encap.sport;
    98		encap->dport = info->encap.dport;
    99	
   100		return 0;
   101	}
   102	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
