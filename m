Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F51D7D46B4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 06:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjJXEZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 00:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjJXEZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 00:25:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2E5111
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 21:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698121541; x=1729657541;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9cwGsqvqNV167uxaJQ+j1STGzEdcV5oPegKFc73sd7U=;
  b=XrEetlo6KEdj+6G2be6rPvEPNnukBcYF3tmnqgyeMmhiRcBulmkMyNhQ
   s0ZosMzYeVF8qvQKhhcA90128Kw6mkmNkNY8QLBiJ3KJgHl+B8f5dn1Ul
   qHoHO+Jr0cNfkjGm+1tx8EyjOcZpdE3ivAZyhhULklw+tfhGu74SfcVmV
   IQLQ7m3m0qC9GEBYvdQGg/nDI59/qb5l/OZqjTP9S9xUDWCp41CKQRJtz
   H34xnMT9T3BWd1NBUzEQF40mTnAm7ckhUyLHk+4ayITYWYb050RdqCZwO
   fWb2OZ1pQw305ijtUv/mbAimwA+aMQJ33/GDqE6JCkndQAxyCSx9XwJLw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="377361809"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="377361809"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 21:25:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="758350588"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="758350588"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 23 Oct 2023 21:25:39 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qv8z2-0007ZD-2Q;
        Tue, 24 Oct 2023 04:25:36 +0000
Date:   Tue, 24 Oct 2023 12:25:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: [tip:sched/core 4/45] riscv64-linux-ld: warning: orphan section
 `.bss..Lubsan_data645' from `kernel/sched/core.o' being placed in section
 `.bss..Lubsan_data645'
Message-ID: <202310241201.kBVQXuBP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
head:   4e5b65a22ba0cabe58f895cd797cb10a763d6994
commit: 7a50f76674f8b6f4f30a1cec954179f10e20110c [4/45] sched: Simplify yield_to()
config: riscv-randconfig-002-20230923 (https://download.01.org/0day-ci/archive/20231024/202310241201.kBVQXuBP-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231024/202310241201.kBVQXuBP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310241201.kBVQXuBP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> riscv64-linux-ld: warning: orphan section `.bss..Lubsan_data645' from `kernel/sched/core.o' being placed in section `.bss..Lubsan_data645'
>> riscv64-linux-ld: warning: orphan section `.bss..Lubsan_data645' from `kernel/sched/core.o' being placed in section `.bss..Lubsan_data645'
>> riscv64-linux-ld: warning: orphan section `.bss..Lubsan_data645' from `kernel/sched/core.o' being placed in section `.bss..Lubsan_data645'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
