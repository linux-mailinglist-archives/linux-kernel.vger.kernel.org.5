Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45917E3F34
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbjKGMum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344603AbjKGMtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:49:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAF711EFA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 04:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699360622; x=1730896622;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QhAUzXlAGfGlLzqEk8WpaGgxTvi8bgswrMkjPi1TywQ=;
  b=EJbliZU6uOwPEoiLXhqqMPRlE9GfVOvehpHJ5AJc259lnahu8P692whs
   6BcQ00LHVnIF5QmzKwcwIRTlt7VTZhneNakoGBlDJoZleVnC1I7ZuOgbL
   vEdwuwNTSdVNfKCwvR19XbTXjy2d1jGV1pVCj4Ny5jD6ofEKq8U0yHG7+
   ZxihbyliIDkVH8xKEreCL4oVfoLckDgRpA1wx/ed/t7CzRpEbsmIhMmNS
   04cc5fjBpnBRqKiih3UL6no1nXHpmbhgPiiHpcBA5qxrObVp3+YsQVFOL
   or3ahq8WcI8gM5nINVlPXvzWOHjr62Q0oYMgkFu1DBvj/CoKRxTSEAu+v
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="368834945"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="368834945"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 04:37:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="762689684"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="762689684"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 07 Nov 2023 04:37:00 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0LKD-000763-2O;
        Tue, 07 Nov 2023 12:36:57 +0000
Date:   Tue, 7 Nov 2023 20:36:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: arch/sparc/include/asm/cmpxchg_64.h:161:55: sparse: sparse: cast
 truncates bits from constant value (eb9f becomes 9f)
Message-ID: <202311072039.EqYDv3BV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   be3ca57cfb777ad820c6659d52e60bbdd36bf5ff
commit: c3c510ce431cd99fa10dcd50d995c8e89330ee5b bpf: Add 'owner' field to bpf_{list,rb}_node
date:   4 months ago
config: sparc64-randconfig-r113-20231107 (https://download.01.org/0day-ci/archive/20231107/202311072039.EqYDv3BV-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231107/202311072039.EqYDv3BV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311072039.EqYDv3BV-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/bpf/helpers.c: note: in included file (through arch/sparc/include/asm/cmpxchg.h, arch/sparc/include/asm/atomic_64.h, arch/sparc/include/asm/atomic.h, ...):
>> arch/sparc/include/asm/cmpxchg_64.h:161:55: sparse: sparse: cast truncates bits from constant value (eb9f becomes 9f)
>> arch/sparc/include/asm/cmpxchg_64.h:161:55: sparse: sparse: cast truncates bits from constant value (eb9f becomes 9f)
   kernel/bpf/helpers.c:2419:18: sparse: sparse: context imbalance in 'bpf_rcu_read_lock' - wrong count at exit
   kernel/bpf/helpers.c:2424:18: sparse: sparse: context imbalance in 'bpf_rcu_read_unlock' - unexpected unlock

vim +161 arch/sparc/include/asm/cmpxchg_64.h

d550bbd40c0e10 David Howells 2012-03-28  155  
d550bbd40c0e10 David Howells 2012-03-28  156  static inline unsigned long
d550bbd40c0e10 David Howells 2012-03-28  157  __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
d550bbd40c0e10 David Howells 2012-03-28  158  {
d550bbd40c0e10 David Howells 2012-03-28  159  	switch (size) {
a12ee2349312d7 Babu Moger    2017-05-24  160  		case 1:
a12ee2349312d7 Babu Moger    2017-05-24 @161  			return __cmpxchg_u8(ptr, old, new);
d550bbd40c0e10 David Howells 2012-03-28  162  		case 4:
d550bbd40c0e10 David Howells 2012-03-28  163  			return __cmpxchg_u32(ptr, old, new);
d550bbd40c0e10 David Howells 2012-03-28  164  		case 8:
d550bbd40c0e10 David Howells 2012-03-28  165  			return __cmpxchg_u64(ptr, old, new);
d550bbd40c0e10 David Howells 2012-03-28  166  	}
d550bbd40c0e10 David Howells 2012-03-28  167  	__cmpxchg_called_with_bad_pointer();
d550bbd40c0e10 David Howells 2012-03-28  168  	return old;
d550bbd40c0e10 David Howells 2012-03-28  169  }
d550bbd40c0e10 David Howells 2012-03-28  170  

:::::: The code at line 161 was first introduced by commit
:::::: a12ee2349312d7112b9b7c6ac2e70c5ec2ca334e arch/sparc: Introduce cmpxchg_u8 SPARC

:::::: TO: Babu Moger <babu.moger@oracle.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
