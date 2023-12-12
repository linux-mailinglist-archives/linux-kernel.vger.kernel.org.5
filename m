Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAFE80F9D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377671AbjLLV5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbjLLV5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:57:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8C5AB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702418229; x=1733954229;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xdr5HKMuhE7W4JQItfhwG/Y0riRuwPZtFof6TIMWQVI=;
  b=kL3azFvsYpjKN6XlKqteHKpKQV+sGYi1RqNemlMt/hnCVQGnme6gCs5S
   UWgjH4RJoUA3N5yCRjsnpLMDLMhntRCOm4kazFdTjUBDrgMgF0oADkBvI
   Ocf6bWNJuOSaJDEOAXhDDxpj9jq5UW08P0aoOk0Bpg4oALYYBQEufp51V
   pLwJicy4xsL4+DI0Qh+RN0e7pZqGcxSXo90Mqavdl58qyHzOTnaOq4ntb
   RxV6PDJ0e+puqLd54B+izjdyZS1z0j6MVzBdUXMvn/S2A7soNCR/E4VNW
   fxzR9cjNfUFjJjD4Fmz0LXuKtboK1Cqgzgi7LYkN2085W3qBZEWwvvuqS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="461350441"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="461350441"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 13:57:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="15177907"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 12 Dec 2023 13:57:07 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDAkS-000Jll-1c;
        Tue, 12 Dec 2023 21:57:04 +0000
Date:   Wed, 13 Dec 2023 05:56:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: vmscan.c:(.text+0x40d2): relocation truncated to fit:
 R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
Message-ID: <202312130533.oeTRauf8-lkp@intel.com>
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
head:   cf52eed70e555e864120cfaf280e979e2a035c66
commit: 90b41691b9881376fe784e13b5766ec3676fdb55 mm: add framework for PCP high auto-tuning
date:   7 weeks ago
config: csky-randconfig-001-20231213 (https://download.01.org/0day-ci/archive/20231213/202312130533.oeTRauf8-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231213/202312130533.oeTRauf8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312130533.oeTRauf8-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/vmscan.o: in function `lru_gen_add_folio':
>> vmscan.c:(.text+0x40d2): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   vmscan.c:(.text+0x40e8): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   vmscan.c:(.text+0x40f6): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   vmscan.c:(.text+0x40fa): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   vmscan.c:(.text+0x412e): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   vmscan.c:(.text+0x4174): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   vmscan.c:(.text+0x4180): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   vmscan.c:(.text+0x418c): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   mm/vmscan.o: in function `move_folios_to_lru':
   vmscan.c:(.text+0x419c): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   vmscan.c:(.text+0x41a0): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   vmscan.c:(.text+0x41f8): additional relocation overflows omitted from the output

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
