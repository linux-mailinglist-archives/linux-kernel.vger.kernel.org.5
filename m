Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889077996AB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 09:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbjIIHH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 03:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjIIHHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 03:07:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADB41BFF
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 00:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694243270; x=1725779270;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=foRAnYeNbtyWXLOG68TP07h5ZP4CZXQJD1hz1aym0qo=;
  b=CAAKCI+2lEvGO1mZF7RxW+zzK0rt0Rz55F4wIGJzIP4I7zmhk8N82HKK
   s5VAsXXT8lV0to1sjw5OOBhrsReJmVhuSg17jLdObJ9nqnNGXa/93thJS
   TQv2ovdz97gJa7M4mU5Mt7S9beS5zampGhI3C+BV0dff65Y9Lz3uS9d5I
   e3LEAn9UgsSZHzdOOTqMvB76BZe1siwAPHC1ly02v2gszJzjzg7fIayE5
   qNl/2OoZjVSiqWIq5WPXjkaqEEs+1ye9WSU5ElJ0nd2gTFo1VlaaNDJDj
   43dw0WhE2tuR6KhNb8Xn2cDdX/F+WjVRm3WVM8xIIcWOeCTvw9Q4DCPtT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="380526680"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="380526680"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 00:07:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="692500239"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="692500239"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 Sep 2023 00:07:48 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qes4I-00032S-0W;
        Sat, 09 Sep 2023 07:07:46 +0000
Date:   Sat, 9 Sep 2023 15:07:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: net/core/filter.c:11748:17: error: no previous declaration for
 'bpf_sock_destroy'
Message-ID: <202309091542.bIKqs1sH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6099776f9f268e61fe5ecd721f994a8cfce5306f
commit: 4ddbcb886268af8d12a23e6640b39d1d9c652b1b bpf: Add bpf_sock_destroy kfunc
date:   4 months ago
config: x86_64-sof-customedconfig-avs-defconfig (https://download.01.org/0day-ci/archive/20230909/202309091542.bIKqs1sH-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309091542.bIKqs1sH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309091542.bIKqs1sH-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/core/filter.c:11650:17: error: no previous declaration for 'bpf_dynptr_from_skb' [-Werror=missing-declarations]
    __bpf_kfunc int bpf_dynptr_from_skb(struct sk_buff *skb, u64 flags,
                    ^~~~~~~~~~~~~~~~~~~
   net/core/filter.c:11663:17: error: no previous declaration for 'bpf_dynptr_from_xdp' [-Werror=missing-declarations]
    __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags,
                    ^~~~~~~~~~~~~~~~~~~
>> net/core/filter.c:11748:17: error: no previous declaration for 'bpf_sock_destroy' [-Werror=missing-declarations]
    __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
                    ^~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/bpf_sock_destroy +11748 net/core/filter.c

 11646	
 11647	__diag_push();
 11648	__diag_ignore_all("-Wmissing-prototypes",
 11649			  "Global functions as their definitions will be in vmlinux BTF");
 11650	__bpf_kfunc int bpf_dynptr_from_skb(struct sk_buff *skb, u64 flags,
 11651					    struct bpf_dynptr_kern *ptr__uninit)
 11652	{
 11653		if (flags) {
 11654			bpf_dynptr_set_null(ptr__uninit);
 11655			return -EINVAL;
 11656		}
 11657	
 11658		bpf_dynptr_init(ptr__uninit, skb, BPF_DYNPTR_TYPE_SKB, 0, skb->len);
 11659	
 11660		return 0;
 11661	}
 11662	
 11663	__bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags,
 11664					    struct bpf_dynptr_kern *ptr__uninit)
 11665	{
 11666		if (flags) {
 11667			bpf_dynptr_set_null(ptr__uninit);
 11668			return -EINVAL;
 11669		}
 11670	
 11671		bpf_dynptr_init(ptr__uninit, xdp, BPF_DYNPTR_TYPE_XDP, 0, xdp_get_buff_len(xdp));
 11672	
 11673		return 0;
 11674	}
 11675	__diag_pop();
 11676	
 11677	int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
 11678				       struct bpf_dynptr_kern *ptr__uninit)
 11679	{
 11680		int err;
 11681	
 11682		err = bpf_dynptr_from_skb(skb, flags, ptr__uninit);
 11683		if (err)
 11684			return err;
 11685	
 11686		bpf_dynptr_set_rdonly(ptr__uninit);
 11687	
 11688		return 0;
 11689	}
 11690	
 11691	BTF_SET8_START(bpf_kfunc_check_set_skb)
 11692	BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
 11693	BTF_SET8_END(bpf_kfunc_check_set_skb)
 11694	
 11695	BTF_SET8_START(bpf_kfunc_check_set_xdp)
 11696	BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
 11697	BTF_SET8_END(bpf_kfunc_check_set_xdp)
 11698	
 11699	static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 11700		.owner = THIS_MODULE,
 11701		.set = &bpf_kfunc_check_set_skb,
 11702	};
 11703	
 11704	static const struct btf_kfunc_id_set bpf_kfunc_set_xdp = {
 11705		.owner = THIS_MODULE,
 11706		.set = &bpf_kfunc_check_set_xdp,
 11707	};
 11708	
 11709	static int __init bpf_kfunc_init(void)
 11710	{
 11711		int ret;
 11712	
 11713		ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_skb);
 11714		ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_kfunc_set_skb);
 11715		ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SK_SKB, &bpf_kfunc_set_skb);
 11716		ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCKET_FILTER, &bpf_kfunc_set_skb);
 11717		ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_kfunc_set_skb);
 11718		ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_OUT, &bpf_kfunc_set_skb);
 11719		ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_IN, &bpf_kfunc_set_skb);
 11720		ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_XMIT, &bpf_kfunc_set_skb);
 11721		ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL, &bpf_kfunc_set_skb);
 11722		ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER, &bpf_kfunc_set_skb);
 11723		return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
 11724	}
 11725	late_initcall(bpf_kfunc_init);
 11726	
 11727	/* Disables missing prototype warnings */
 11728	__diag_push();
 11729	__diag_ignore_all("-Wmissing-prototypes",
 11730			  "Global functions as their definitions will be in vmlinux BTF");
 11731	
 11732	/* bpf_sock_destroy: Destroy the given socket with ECONNABORTED error code.
 11733	 *
 11734	 * The function expects a non-NULL pointer to a socket, and invokes the
 11735	 * protocol specific socket destroy handlers.
 11736	 *
 11737	 * The helper can only be called from BPF contexts that have acquired the socket
 11738	 * locks.
 11739	 *
 11740	 * Parameters:
 11741	 * @sock: Pointer to socket to be destroyed
 11742	 *
 11743	 * Return:
 11744	 * On error, may return EPROTONOSUPPORT, EINVAL.
 11745	 * EPROTONOSUPPORT if protocol specific destroy handler is not supported.
 11746	 * 0 otherwise
 11747	 */
 11748	__bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
 11749	{
 11750		struct sock *sk = (struct sock *)sock;
 11751	
 11752		/* The locking semantics that allow for synchronous execution of the
 11753		 * destroy handlers are only supported for TCP and UDP.
 11754		 * Supporting protocols will need to acquire sock lock in the BPF context
 11755		 * prior to invoking this kfunc.
 11756		 */
 11757		if (!sk->sk_prot->diag_destroy || (sk->sk_protocol != IPPROTO_TCP &&
 11758						   sk->sk_protocol != IPPROTO_UDP))
 11759			return -EOPNOTSUPP;
 11760	
 11761		return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
 11762	}
 11763	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
