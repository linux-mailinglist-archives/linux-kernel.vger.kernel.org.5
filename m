Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A36797FCC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 02:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241091AbjIHAfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 20:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjIHAfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 20:35:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5471D1BDB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 17:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694133344; x=1725669344;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9GjhWOhjH0wxGVPMcJD8CO+Jf39kpEAM+q0cTHyhmJo=;
  b=igqUPRAkYghq9ICUUc2S4KPRiAaD/eEPa/5mSMOSmeG+31xt628lXD4H
   6qDvIHUL3rX+KA9iOC1UsCo8VFq4p5X+AbCAymSL4oOPdpPb/SvXbz5ZL
   npSyxY9tzhSS9B0yOrWSRDXco07X08f500GeSjyz7gMkmGz3NZGUCj/QD
   M4jlOWLCLynPJC45Gta4f7Pxm4KdyKuoftm6PD3Cfa4XOyvNnjh6cB2S4
   LvpsdL+mTKUTIzI7WFV3eA8gC/HzA2P1Y+UNyReRpN0mCf4Rejb4RQdAy
   gwcc9yYUzRR1cNLSHoSwz1XbFTH+lWk8G+Fnz2o8ezitLKy1bUpM0EtCJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="377422440"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="377422440"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 17:35:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="865859423"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="865859423"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 Sep 2023 17:35:42 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qePTG-0001kl-3A;
        Fri, 08 Sep 2023 00:35:38 +0000
Date:   Fri, 8 Sep 2023 08:35:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: net/core/filter.c:11639:17: error: no previous declaration for
 'bpf_dynptr_from_skb'
Message-ID: <202309080849.4yWoDkBk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ff6e6ded54725cd01623b9a1a86b74a523198733
commit: b5964b968ac64c2ec2debee7518499113b27c34e bpf: Add skb dynptrs
date:   6 months ago
config: x86_64-sof-customedconfig-avs-defconfig (https://download.01.org/0day-ci/archive/20230908/202309080849.4yWoDkBk-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230908/202309080849.4yWoDkBk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309080849.4yWoDkBk-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/core/filter.c:11639:17: error: no previous declaration for 'bpf_dynptr_from_skb' [-Werror=missing-declarations]
    __bpf_kfunc int bpf_dynptr_from_skb(struct sk_buff *skb, u64 flags,
                    ^~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/bpf_dynptr_from_skb +11639 net/core/filter.c

 11635	
 11636	__diag_push();
 11637	__diag_ignore_all("-Wmissing-prototypes",
 11638			  "Global functions as their definitions will be in vmlinux BTF");
 11639	__bpf_kfunc int bpf_dynptr_from_skb(struct sk_buff *skb, u64 flags,
 11640					    struct bpf_dynptr_kern *ptr__uninit)
 11641	{
 11642		if (flags) {
 11643			bpf_dynptr_set_null(ptr__uninit);
 11644			return -EINVAL;
 11645		}
 11646	
 11647		bpf_dynptr_init(ptr__uninit, skb, BPF_DYNPTR_TYPE_SKB, 0, skb->len);
 11648	
 11649		return 0;
 11650	}
 11651	__diag_pop();
 11652	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
