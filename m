Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949C077E78C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345142AbjHPR1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345202AbjHPR10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:27:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A689E55
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692206845; x=1723742845;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yMiVYYxGzyMe2PR89NcT2PwERTyiuhQhQBH6aPrJE4g=;
  b=hMghbmoEewkOqqX7sMZ87L+SiKjI9+QHMB2qEEyGX15UcVJxTG8ZyAG1
   jjkUs17KXh8NfdEREwvG7fEwzLeiLcKC/T0LrJDP8vh05HEcZSI3Qe+I/
   fq4qkBC93MMyEDMKbgIMXRfqyNFokwNqyREkK62b9Cw4UvD3wGqwgavcX
   96+51UX+nnJuSWxMGmgMaPTqlc5vSoEWHigTp2oMa+WGC8s6hnVLjZVvw
   YPoK72p9Acr31WAJT+4h64T62V68pqvO6caBARPOyO/xBfX/vO90uxb0a
   7reXe+WWLuN80iLSnTd+sq/Xm5in80AxdoqScqhqKn5jImbMVMiiIStdp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="362742340"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="362742340"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 10:27:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="684148238"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="684148238"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Aug 2023 10:27:22 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWKIk-0000Sx-0X;
        Wed, 16 Aug 2023 17:27:22 +0000
Date:   Thu, 17 Aug 2023 01:27:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: net/bpf/test_run.c:303:15: warning: no previous declaration for
 'bpf_kfunc_call_memb_release'
Message-ID: <202308170136.QmDPx82O-lkp@intel.com>
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

Hi Kumar,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: 8218ccb5bd68976ed5d75028ef50c13a857eee25 selftests/bpf: Add tests for kfunc register offset checks
date:   1 year, 5 months ago
config: x86_64-randconfig-x012-20230816 (https://download.01.org/0day-ci/archive/20230817/202308170136.QmDPx82O-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308170136.QmDPx82O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308170136.QmDPx82O-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/bpf/test_run.c:206:14: warning: no previous declaration for 'bpf_fentry_test1' [-Wmissing-declarations]
    int noinline bpf_fentry_test1(int a)
                 ^~~~~~~~~~~~~~~~
   net/bpf/test_run.c:213:14: warning: no previous declaration for 'bpf_fentry_test2' [-Wmissing-declarations]
    int noinline bpf_fentry_test2(int a, u64 b)
                 ^~~~~~~~~~~~~~~~
   net/bpf/test_run.c:218:14: warning: no previous declaration for 'bpf_fentry_test3' [-Wmissing-declarations]
    int noinline bpf_fentry_test3(char a, int b, u64 c)
                 ^~~~~~~~~~~~~~~~
   net/bpf/test_run.c:223:14: warning: no previous declaration for 'bpf_fentry_test4' [-Wmissing-declarations]
    int noinline bpf_fentry_test4(void *a, char b, int c, u64 d)
                 ^~~~~~~~~~~~~~~~
   net/bpf/test_run.c:228:14: warning: no previous declaration for 'bpf_fentry_test5' [-Wmissing-declarations]
    int noinline bpf_fentry_test5(u64 a, void *b, short c, int d, u64 e)
                 ^~~~~~~~~~~~~~~~
   net/bpf/test_run.c:233:14: warning: no previous declaration for 'bpf_fentry_test6' [-Wmissing-declarations]
    int noinline bpf_fentry_test6(u64 a, void *b, short c, int d, void *e, u64 f)
                 ^~~~~~~~~~~~~~~~
   net/bpf/test_run.c:242:14: warning: no previous declaration for 'bpf_fentry_test7' [-Wmissing-declarations]
    int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
                 ^~~~~~~~~~~~~~~~
   net/bpf/test_run.c:247:14: warning: no previous declaration for 'bpf_fentry_test8' [-Wmissing-declarations]
    int noinline bpf_fentry_test8(struct bpf_fentry_test_t *arg)
                 ^~~~~~~~~~~~~~~~
   net/bpf/test_run.c:252:14: warning: no previous declaration for 'bpf_modify_return_test' [-Wmissing-declarations]
    int noinline bpf_modify_return_test(int a, int *b)
                 ^~~~~~~~~~~~~~~~~~~~~~
   net/bpf/test_run.c:258:14: warning: no previous declaration for 'bpf_kfunc_call_test1' [-Wmissing-declarations]
    u64 noinline bpf_kfunc_call_test1(struct sock *sk, u32 a, u64 b, u32 c, u64 d)
                 ^~~~~~~~~~~~~~~~~~~~
   net/bpf/test_run.c:263:14: warning: no previous declaration for 'bpf_kfunc_call_test2' [-Wmissing-declarations]
    int noinline bpf_kfunc_call_test2(struct sock *sk, u32 a, u32 b)
                 ^~~~~~~~~~~~~~~~~~~~
   net/bpf/test_run.c:268:24: warning: no previous declaration for 'bpf_kfunc_call_test3' [-Wmissing-declarations]
    struct sock * noinline bpf_kfunc_call_test3(struct sock *sk)
                           ^~~~~~~~~~~~~~~~~~~~
   net/bpf/test_run.c:291:1: warning: no previous declaration for 'bpf_kfunc_call_test_acquire' [-Wmissing-declarations]
    bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr)
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/bpf/test_run.c:299:15: warning: no previous declaration for 'bpf_kfunc_call_test_release' [-Wmissing-declarations]
    noinline void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> net/bpf/test_run.c:303:15: warning: no previous declaration for 'bpf_kfunc_call_memb_release' [-Wmissing-declarations]
    noinline void bpf_kfunc_call_memb_release(struct prog_test_member *p)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/bpf/test_run.c:345:15: warning: no previous declaration for 'bpf_kfunc_call_test_pass_ctx' [-Wmissing-declarations]
    noinline void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/bpf/test_run.c:349:15: warning: no previous declaration for 'bpf_kfunc_call_test_pass1' [-Wmissing-declarations]
    noinline void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   net/bpf/test_run.c:353:15: warning: no previous declaration for 'bpf_kfunc_call_test_pass2' [-Wmissing-declarations]
    noinline void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   net/bpf/test_run.c:357:15: warning: no previous declaration for 'bpf_kfunc_call_test_fail1' [-Wmissing-declarations]
    noinline void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   net/bpf/test_run.c:361:15: warning: no previous declaration for 'bpf_kfunc_call_test_fail2' [-Wmissing-declarations]
    noinline void bpf_kfunc_call_test_fail2(struct prog_test_fail2 *p)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   net/bpf/test_run.c:365:15: warning: no previous declaration for 'bpf_kfunc_call_test_fail3' [-Wmissing-declarations]
    noinline void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   net/bpf/test_run.c:369:15: warning: no previous declaration for 'bpf_kfunc_call_test_mem_len_pass1' [-Wmissing-declarations]
    noinline void bpf_kfunc_call_test_mem_len_pass1(void *mem, int mem__sz)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/bpf/test_run.c:373:15: warning: no previous declaration for 'bpf_kfunc_call_test_mem_len_fail1' [-Wmissing-declarations]
    noinline void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/bpf/test_run.c:377:15: warning: no previous declaration for 'bpf_kfunc_call_test_mem_len_fail2' [-Wmissing-declarations]
    noinline void bpf_kfunc_call_test_mem_len_fail2(u64 *mem, int len)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/bpf_kfunc_call_memb_release +303 net/bpf/test_run.c

   302	
 > 303	noinline void bpf_kfunc_call_memb_release(struct prog_test_member *p)
   304	{
   305	}
   306	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
