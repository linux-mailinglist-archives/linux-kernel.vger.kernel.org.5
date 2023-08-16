Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C796777E48F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343940AbjHPPCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343933AbjHPPCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:02:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F348C26A1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692198143; x=1723734143;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YHr8qotILcwaWrSBPNLEZRePCvsFg0279hOp41I7C38=;
  b=muokw/sWmSwdeY+fTIQc+UzvOfMEUrbPJAFnyUHVLLaLMqYqyx99BF6S
   p1YU0H9B1cLOVHlb7JkrkDrRv4A/Ecy74uJit5YDsgGJQBHb6FVou47On
   AtSLjOHkrg9UAvnc4t/r7uKSOsiJ8Z0ELOjZhgCBxZcupHMTKfkWGi4ms
   1wn117T850XlOcrsIaiYELBD39gl2WBVnsetm/q0efrNB2ospjGWxAb75
   gbThYl0u6L7fisHxiKP01qRhht2IRIHxVDU890/H3FJs3GGbQ9ghxCBSQ
   uxSiL1TedDw0dggG58YleC2mc4qISPrUuleCo0pEIiAyN6FfE3BKGURWV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403531583"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="403531583"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 08:02:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="980763509"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="980763509"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 16 Aug 2023 08:02:20 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWI2K-0000Nu-0J;
        Wed, 16 Aug 2023 15:02:17 +0000
Date:   Wed, 16 Aug 2023 23:01:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: kernel/bpf/helpers.c:1757:7: warning: no previous declaration for
 'bpf_obj_new_impl'
Message-ID: <202308162255.nWBAw9u6-lkp@intel.com>
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
commit: 958cf2e273f0929c66169e0788031310e8118722 bpf: Introduce bpf_obj_new
date:   9 months ago
config: x86_64-randconfig-x012-20230816 (https://download.01.org/0day-ci/archive/20230816/202308162255.nWBAw9u6-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20230816/202308162255.nWBAw9u6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308162255.nWBAw9u6-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/helpers.c:1757:7: warning: no previous declaration for 'bpf_obj_new_impl' [-Wmissing-declarations]
    void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
          ^~~~~~~~~~~~~~~~


vim +/bpf_obj_new_impl +1757 kernel/bpf/helpers.c

  1752	
  1753	__diag_push();
  1754	__diag_ignore_all("-Wmissing-prototypes",
  1755			  "Global functions as their definitions will be in vmlinux BTF");
  1756	
> 1757	void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
  1758	{
  1759		struct btf_struct_meta *meta = meta__ign;
  1760		u64 size = local_type_id__k;
  1761		void *p;
  1762	
  1763		if (unlikely(!bpf_global_ma_set))
  1764			return NULL;
  1765		p = bpf_mem_alloc(&bpf_global_ma, size);
  1766		if (!p)
  1767			return NULL;
  1768		if (meta)
  1769			bpf_obj_init(meta->field_offs, p);
  1770		return p;
  1771	}
  1772	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
