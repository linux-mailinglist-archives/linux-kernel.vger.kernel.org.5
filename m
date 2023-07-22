Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D06275DBF4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjGVLib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGVLi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:38:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79E726A5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690025906; x=1721561906;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jwWlax6AcouE4eghhUBXSYgBiSFjO6J/KETelap1o18=;
  b=hPLNVNIGsBowr7Bwrg1M34T6y2tBypY0iBgCdfPnx/oDulcJusawWlS6
   8I6BpOAKMMEGMi5jZZES9Xf13qDDQm7g77KJzlodoBnTRQKmnw4yHHI7u
   t2fIl7DUMGhqNoOaX0RBxRrBPMmbtTaLRKxZJsIaKzSUAArx2NKGDtRLU
   miCQSCIB+I052C0TIT9vUZAShcMiV6wHzmAh/vgCfxofP5UmhqI1Xmdam
   xRAV38wn+5/nwXQj/smptrNO/LOCMzhAZDGjKAVHKV/TP/QFLrn00UiNi
   3qfeyFgas5TwsZb8UwSZ9YTg/KKX4xVl0SFiB3+uedvITxexpQAZi8ZTH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="433419410"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="433419410"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 04:38:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="760251950"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="760251950"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 22 Jul 2023 04:38:23 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qNAwJ-0008HV-0H;
        Sat, 22 Jul 2023 11:38:23 +0000
Date:   Sat, 22 Jul 2023 19:38:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: drivers/md/bcache/btree.c:1571:12: warning: stack frame size (2512)
 exceeds limit (2048) in 'btree_gc_recurse'
Message-ID: <202307221916.JkdHXZB1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d192f5382581d972c4ae1b4d72e0b59b34cadeb9
commit: 8341dcfbd8dda98a3b2836a421016f7d88e35b1c riscv: Enable Undefined Behavior Sanitizer UBSAN
date:   1 year, 11 months ago
config: riscv-randconfig-r042-20230720 (https://download.01.org/0day-ci/archive/20230722/202307221916.JkdHXZB1-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230722/202307221916.JkdHXZB1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307221916.JkdHXZB1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/md/bcache/btree.c:1571:12: warning: stack frame size (2512) exceeds limit (2048) in 'btree_gc_recurse' [-Wframe-larger-than]
    1571 | static int btree_gc_recurse(struct btree *b, struct btree_op *op,
         |            ^
   1 warning generated.
--
>> drivers/media/dvb-core/dvb_net.c:759:13: warning: stack frame size (3456) exceeds limit (2048) in 'dvb_net_ule' [-Wframe-larger-than]
     759 | static void dvb_net_ule(struct net_device *dev, const u8 *buf, size_t buf_len)
         |             ^
   1 warning generated.
--
>> drivers/net/ethernet/sfc/farch.c:1261:5: warning: stack frame size (2352) exceeds limit (2048) in 'efx_farch_ev_process' [-Wframe-larger-than]
    1261 | int efx_farch_ev_process(struct efx_channel *channel, int budget)
         |     ^
   1 warning generated.
   /tmp/farch-c03a73.s: Assembler messages:
   /tmp/farch-c03a73.s:468: Error: unrecognized opcode `csrrc a3,0x100,2', extension `zicsr' required
   /tmp/farch-c03a73.s:568: Error: unrecognized opcode `csrs 0x100,s6', extension `zicsr' required
   /tmp/farch-c03a73.s:776: Error: unrecognized opcode `csrrc a3,0x100,2', extension `zicsr' required
   /tmp/farch-c03a73.s:840: Error: unrecognized opcode `csrs 0x100,s5', extension `zicsr' required
   /tmp/farch-c03a73.s:3994: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/farch-c03a73.s:4026: Error: unrecognized opcode `csrs 0x100,s5', extension `zicsr' required
   clang: error: assembler command failed with exit code 1 (use -v to see invocation)
--
>> drivers/ata/libata-eh.c:2410:6: warning: stack frame size (2912) exceeds limit (2048) in 'ata_eh_report' [-Wframe-larger-than]
    2410 | void ata_eh_report(struct ata_port *ap)
         |      ^
   drivers/ata/libata-eh.c:3537:5: warning: stack frame size (3520) exceeds limit (2048) in 'ata_eh_recover' [-Wframe-larger-than]
    3537 | int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
         |     ^
   2 warnings generated.
   /tmp/libata-eh-d16ac6.s: Assembler messages:
   /tmp/libata-eh-d16ac6.s:1920: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:1953: Error: unrecognized opcode `csrs 0x100,s6', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:2350: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:2779: Error: unrecognized opcode `csrs 0x100,s2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:3510: Error: unrecognized opcode `csrrc s1,0x100,2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:3559: Error: unrecognized opcode `csrs 0x100,s1', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:3577: Error: unrecognized opcode `csrs 0x100,s1', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:3735: Error: unrecognized opcode `csrrc s1,0x100,2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:3774: Error: unrecognized opcode `csrs 0x100,s1', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:3809: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:4060: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:4198: Error: unrecognized opcode `csrrc s1,0x100,2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:4247: Error: unrecognized opcode `csrs 0x100,s1', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:4284: Error: unrecognized opcode `csrrc s1,0x100,2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:4333: Error: unrecognized opcode `csrs 0x100,s1', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:4362: Error: unrecognized opcode `csrs 0x100,s1', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:4494: Error: unrecognized opcode `csrrc s1,0x100,2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:4568: Error: unrecognized opcode `csrs 0x100,s1', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:4603: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:4647: Error: unrecognized opcode `csrs 0x100,s4', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:5436: Error: unrecognized opcode `csrs 0x100,s4', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:5481: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:5586: Error: unrecognized opcode `csrs 0x100,s2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:6662: Error: unrecognized opcode `csrrc s1,0x100,2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:6705: Error: unrecognized opcode `csrs 0x100,s1', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:6740: Error: unrecognized opcode `csrrc s1,0x100,2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:6821: Error: unrecognized opcode `csrs 0x100,s1', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:7042: Error: unrecognized opcode `csrrc a1,0x100,2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:7168: Error: unrecognized opcode `csrs 0x100,s7', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:8372: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:8404: Error: unrecognized opcode `csrs 0x100,s5', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:8569: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:8639: Error: unrecognized opcode `csrs 0x100,s6', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:8960: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:9038: Error: unrecognized opcode `csrs 0x100,s7', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:9483: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:9596: Error: unrecognized opcode `csrs 0x100,s8', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:10258: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:10328: Error: unrecognized opcode `csrs 0x100,s8', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:21394: Error: unrecognized opcode `csrrc s1,0x100,2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:21444: Error: unrecognized opcode `csrs 0x100,s6', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:22528: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:22597: Error: unrecognized opcode `csrs 0x100,s2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:23205: Error: unrecognized opcode `csrrc s1,0x100,2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:23245: Error: unrecognized opcode `csrs 0x100,s1', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:24852: Error: unrecognized opcode `csrrc s1,0x100,2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:24892: Error: unrecognized opcode `csrs 0x100,s1', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:27416: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:27616: Error: unrecognized opcode `csrs 0x100,s1', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:28852: Error: unrecognized opcode `csrrc s1,0x100,2', extension `zicsr' required
   /tmp/libata-eh-d16ac6.s:28893: Error: unrecognized opcode `csrs 0x100,s1', extension `zicsr' required
   clang: error: assembler command failed with exit code 1 (use -v to see invocation)
--
>> drivers/bus/mhi/core/pm.c:732:6: warning: stack frame size (2880) exceeds limit (2048) in 'mhi_pm_st_worker' [-Wframe-larger-than]
     732 | void mhi_pm_st_worker(struct work_struct *work)
         |      ^
   1 warning generated.
   /tmp/pm-00af0b.s: Assembler messages:
   /tmp/pm-00af0b.s:388: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/pm-00af0b.s:391: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:421: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:665: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/pm-00af0b.s:668: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:693: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:1203: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/pm-00af0b.s:1206: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:1236: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:1413: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/pm-00af0b.s:1416: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:1437: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:1530: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/pm-00af0b.s:1533: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:1573: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:1712: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/pm-00af0b.s:1715: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:1736: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:1772: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/pm-00af0b.s:1775: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:1818: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:2297: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/pm-00af0b.s:2300: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:2336: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:2358: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:2765: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/pm-00af0b.s:2768: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:2797: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:2987: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:3017: Error: unrecognized opcode `csrs 0x100,s4', extension `zicsr' required
   /tmp/pm-00af0b.s:3454: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/pm-00af0b.s:3457: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:3483: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:4772: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/pm-00af0b.s:4775: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:4818: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:4839: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/pm-00af0b.s:4842: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:4870: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:4891: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/pm-00af0b.s:4894: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:4922: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:4995: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/pm-00af0b.s:4998: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:5029: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:5864: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/pm-00af0b.s:5867: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:5897: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:6926: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/pm-00af0b.s:6929: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:6952: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:9221: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/pm-00af0b.s:9224: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:9267: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:9296: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:9615: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/pm-00af0b.s:9618: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:9659: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:10396: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/pm-00af0b.s:10399: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:10430: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:10653: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:11042: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:11841: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/pm-00af0b.s:11844: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:11872: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:12117: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:13281: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/pm-00af0b.s:13284: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:13315: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:13470: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:13671: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:14213: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:14284: Error: unrecognized opcode `csrs 0x100,s5', extension `zicsr' required
   /tmp/pm-00af0b.s:14317: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:14390: Error: unrecognized opcode `csrs 0x100,s5', extension `zicsr' required
   /tmp/pm-00af0b.s:14699: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:14774: Error: unrecognized opcode `csrs 0x100,s5', extension `zicsr' required
   /tmp/pm-00af0b.s:15071: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/pm-00af0b.s:15074: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:15101: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/pm-00af0b.s:15155: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   clang: error: assembler command failed with exit code 1 (use -v to see invocation)
--
>> net/mptcp/subflow.c:1100:13: warning: stack frame size (2496) exceeds limit (2048) in 'subflow_check_data_avail' [-Wframe-larger-than]
    1100 | static bool subflow_check_data_avail(struct sock *ssk)
         |             ^
   1 warning generated.
   /tmp/subflow-004bee.s: Assembler messages:
   /tmp/subflow-004bee.s:2524: Error: unrecognized opcode `csrrc s2,0x100,2', extension `zicsr' required
   /tmp/subflow-004bee.s:2541: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/subflow-004bee.s:3282: Error: unrecognized opcode `csrrc s2,0x100,2', extension `zicsr' required
   /tmp/subflow-004bee.s:3299: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/subflow-004bee.s:3881: Error: unrecognized opcode `csrrc s2,0x100,2', extension `zicsr' required
   /tmp/subflow-004bee.s:3896: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/subflow-004bee.s:4099: Error: unrecognized opcode `csrrc s2,0x100,2', extension `zicsr' required
   /tmp/subflow-004bee.s:4116: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/subflow-004bee.s:5267: Error: unrecognized opcode `csrrc s2,0x100,2', extension `zicsr' required
   /tmp/subflow-004bee.s:5282: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/subflow-004bee.s:8549: Error: unrecognized opcode `csrrc s2,0x100,2', extension `zicsr' required
   /tmp/subflow-004bee.s:8559: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/subflow-004bee.s:8596: Error: unrecognized opcode `csrrc s2,0x100,2', extension `zicsr' required
   /tmp/subflow-004bee.s:8608: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/subflow-004bee.s:12687: Error: unrecognized opcode `csrrc s2,0x100,2', extension `zicsr' required
   /tmp/subflow-004bee.s:12702: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/subflow-004bee.s:12854: Error: unrecognized opcode `csrrc s6,0x100,2', extension `zicsr' required
   /tmp/subflow-004bee.s:12869: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/subflow-004bee.s:12956: Error: unrecognized opcode `csrrc s4,0x100,2', extension `zicsr' required
   /tmp/subflow-004bee.s:12971: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/subflow-004bee.s:14299: Error: unrecognized opcode `csrrc s3,0x100,2', extension `zicsr' required
   /tmp/subflow-004bee.s:14316: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/subflow-004bee.s:14645: Error: unrecognized opcode `csrrc s3,0x100,2', extension `zicsr' required
   /tmp/subflow-004bee.s:14662: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   clang: error: assembler command failed with exit code 1 (use -v to see invocation)
--
>> crypto/testmgr.c:2529:12: warning: stack frame size (2400) exceeds limit (2048) in 'test_aead' [-Wframe-larger-than]
    2529 | static int test_aead(int enc, const struct aead_test_suite *suite,
         |            ^
   1 warning generated.
--
>> fs/io_uring.c:6697:12: warning: stack frame size (2240) exceeds limit (2048) in 'io_submit_sqes' [-Wframe-larger-than]
    6697 | static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr)
         |            ^
   1 warning generated.
   /tmp/io_uring-3f8554.s: Assembler messages:
   /tmp/io_uring-3f8554.s:13400: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/io_uring-3f8554.s:13403: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:13570: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:14399: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:14447: Error: unrecognized opcode `csrs 0x100,s10', extension `zicsr' required
   /tmp/io_uring-3f8554.s:14911: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/io_uring-3f8554.s:14914: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:15087: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:15235: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/io_uring-3f8554.s:15238: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:15384: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:20499: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/io_uring-3f8554.s:20502: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:20589: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:20825: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:20895: Error: unrecognized opcode `csrs 0x100,s6', extension `zicsr' required
   /tmp/io_uring-3f8554.s:20960: Error: unrecognized opcode `csrrc a1,0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:21020: Error: unrecognized opcode `csrs 0x100,s4', extension `zicsr' required
   /tmp/io_uring-3f8554.s:21557: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:21685: Error: unrecognized opcode `csrs 0x100,s8', extension `zicsr' required
   /tmp/io_uring-3f8554.s:25219: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:25287: Error: unrecognized opcode `csrs 0x100,s11', extension `zicsr' required
   /tmp/io_uring-3f8554.s:25414: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:25457: Error: unrecognized opcode `csrs 0x100,s4', extension `zicsr' required
   /tmp/io_uring-3f8554.s:25741: Error: unrecognized opcode `csrs 0x100,s11', extension `zicsr' required
   /tmp/io_uring-3f8554.s:26188: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:26224: Error: unrecognized opcode `csrs 0x100,s9', extension `zicsr' required
   /tmp/io_uring-3f8554.s:27681: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:27980: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:29301: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/io_uring-3f8554.s:29304: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:29494: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/io_uring-3f8554.s:29497: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:29599: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/io_uring-3f8554.s:29602: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:29646: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:30235: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/io_uring-3f8554.s:30238: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:32610: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:32693: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:33027: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:33620: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:34240: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/io_uring-3f8554.s:34243: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:34285: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:39183: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/io_uring-3f8554.s:39186: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:39343: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:39816: Error: unrecognized opcode `csrrc a1,0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:39836: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/io_uring-3f8554.s:40774: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:47800: Error: unrecognized opcode `csrrc s5,0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:47817: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/io_uring-3f8554.s:47826: Error: unrecognized opcode `csrrc s5,0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:47843: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/io_uring-3f8554.s:49676: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/io_uring-3f8554.s:49679: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:52423: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:52488: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:52846: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/io_uring-3f8554.s:52849: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:53683: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:53777: Error: unrecognized opcode `csrs 0x100,s8', extension `zicsr' required
   /tmp/io_uring-3f8554.s:54659: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/io_uring-3f8554.s:54662: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:54722: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:54812: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/io_uring-3f8554.s:54815: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:54845: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:61870: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:61905: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:62656: Error: unrecognized opcode `csrrc s2,0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:62666: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/io_uring-3f8554.s:62805: Error: unrecognized opcode `csrrc s3,0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:62815: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/io_uring-3f8554.s:68429: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:68669: Error: unrecognized opcode `csrs 0x100,s4', extension `zicsr' required
   /tmp/io_uring-3f8554.s:69624: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/io_uring-3f8554.s:69627: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:69665: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:70490: Error: unrecognized opcode `csrrc s2,0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:70500: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/io_uring-3f8554.s:70698: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/io_uring-3f8554.s:70701: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:70789: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:80300: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/io_uring-3f8554.s:80303: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:80386: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:80434: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:87036: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/io_uring-3f8554.s:87039: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:87282: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:88784: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
   /tmp/io_uring-3f8554.s:88787: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:88808: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   /tmp/io_uring-3f8554.s:96173: Error: unrecognized opcode `csrr a0,0x100', extension `zicsr' required
..


vim +/btree_gc_recurse +1571 drivers/md/bcache/btree.c

7f4a59de28137a Tang Junhui     2018-07-26  1569  
7f4a59de28137a Tang Junhui     2018-07-26  1570  
a1f0358b2bf69b Kent Overstreet 2013-09-10 @1571  static int btree_gc_recurse(struct btree *b, struct btree_op *op,
a1f0358b2bf69b Kent Overstreet 2013-09-10  1572  			    struct closure *writes, struct gc_stat *gc)
a1f0358b2bf69b Kent Overstreet 2013-09-10  1573  {
a1f0358b2bf69b Kent Overstreet 2013-09-10  1574  	int ret = 0;
a1f0358b2bf69b Kent Overstreet 2013-09-10  1575  	bool should_rewrite;
a1f0358b2bf69b Kent Overstreet 2013-09-10  1576  	struct bkey *k;
a1f0358b2bf69b Kent Overstreet 2013-09-10  1577  	struct btree_iter iter;
cafe563591446c Kent Overstreet 2013-03-23  1578  	struct gc_merge_info r[GC_MERGE_NODES];
2a285686c10981 Kent Overstreet 2014-03-04  1579  	struct gc_merge_info *i, *last = r + ARRAY_SIZE(r) - 1;
cafe563591446c Kent Overstreet 2013-03-23  1580  
c052dd9a26f60b Kent Overstreet 2013-11-11  1581  	bch_btree_iter_init(&b->keys, &iter, &b->c->gc_done);
cafe563591446c Kent Overstreet 2013-03-23  1582  
2a285686c10981 Kent Overstreet 2014-03-04  1583  	for (i = r; i < r + ARRAY_SIZE(r); i++)
2a285686c10981 Kent Overstreet 2014-03-04  1584  		i->b = ERR_PTR(-EINTR);
cafe563591446c Kent Overstreet 2013-03-23  1585  
a1f0358b2bf69b Kent Overstreet 2013-09-10  1586  	while (1) {
a85e968e66a175 Kent Overstreet 2013-12-20  1587  		k = bch_btree_iter_next_filter(&iter, &b->keys, bch_ptr_bad);
a1f0358b2bf69b Kent Overstreet 2013-09-10  1588  		if (k) {
0a63b66db566cf Kent Overstreet 2014-03-17  1589  			r->b = bch_btree_node_get(b->c, op, k, b->level - 1,
2452cc89063a2a Slava Pestov    2014-07-12  1590  						  true, b);
cafe563591446c Kent Overstreet 2013-03-23  1591  			if (IS_ERR(r->b)) {
cafe563591446c Kent Overstreet 2013-03-23  1592  				ret = PTR_ERR(r->b);
cafe563591446c Kent Overstreet 2013-03-23  1593  				break;
cafe563591446c Kent Overstreet 2013-03-23  1594  			}
cafe563591446c Kent Overstreet 2013-03-23  1595  
a1f0358b2bf69b Kent Overstreet 2013-09-10  1596  			r->keys = btree_gc_count_keys(r->b);
a1f0358b2bf69b Kent Overstreet 2013-09-10  1597  
0a63b66db566cf Kent Overstreet 2014-03-17  1598  			ret = btree_gc_coalesce(b, op, gc, r);
a1f0358b2bf69b Kent Overstreet 2013-09-10  1599  			if (ret)
a1f0358b2bf69b Kent Overstreet 2013-09-10  1600  				break;
a1f0358b2bf69b Kent Overstreet 2013-09-10  1601  		}
a1f0358b2bf69b Kent Overstreet 2013-09-10  1602  
a1f0358b2bf69b Kent Overstreet 2013-09-10  1603  		if (!last->b)
a1f0358b2bf69b Kent Overstreet 2013-09-10  1604  			break;
a1f0358b2bf69b Kent Overstreet 2013-09-10  1605  
a1f0358b2bf69b Kent Overstreet 2013-09-10  1606  		if (!IS_ERR(last->b)) {
a1f0358b2bf69b Kent Overstreet 2013-09-10  1607  			should_rewrite = btree_gc_mark_node(last->b, gc);
0a63b66db566cf Kent Overstreet 2014-03-17  1608  			if (should_rewrite) {
0a63b66db566cf Kent Overstreet 2014-03-17  1609  				ret = btree_gc_rewrite_node(b, op, last->b);
0a63b66db566cf Kent Overstreet 2014-03-17  1610  				if (ret)
cafe563591446c Kent Overstreet 2013-03-23  1611  					break;
cafe563591446c Kent Overstreet 2013-03-23  1612  			}
cafe563591446c Kent Overstreet 2013-03-23  1613  
a1f0358b2bf69b Kent Overstreet 2013-09-10  1614  			if (last->b->level) {
a1f0358b2bf69b Kent Overstreet 2013-09-10  1615  				ret = btree_gc_recurse(last->b, op, writes, gc);
a1f0358b2bf69b Kent Overstreet 2013-09-10  1616  				if (ret)
a1f0358b2bf69b Kent Overstreet 2013-09-10  1617  					break;
a1f0358b2bf69b Kent Overstreet 2013-09-10  1618  			}
cafe563591446c Kent Overstreet 2013-03-23  1619  
a1f0358b2bf69b Kent Overstreet 2013-09-10  1620  			bkey_copy_key(&b->c->gc_done, &last->b->key);
cafe563591446c Kent Overstreet 2013-03-23  1621  
a1f0358b2bf69b Kent Overstreet 2013-09-10  1622  			/*
a1f0358b2bf69b Kent Overstreet 2013-09-10  1623  			 * Must flush leaf nodes before gc ends, since replace
a1f0358b2bf69b Kent Overstreet 2013-09-10  1624  			 * operations aren't journalled
a1f0358b2bf69b Kent Overstreet 2013-09-10  1625  			 */
2a285686c10981 Kent Overstreet 2014-03-04  1626  			mutex_lock(&last->b->write_lock);
a1f0358b2bf69b Kent Overstreet 2013-09-10  1627  			if (btree_node_dirty(last->b))
a1f0358b2bf69b Kent Overstreet 2013-09-10  1628  				bch_btree_node_write(last->b, writes);
2a285686c10981 Kent Overstreet 2014-03-04  1629  			mutex_unlock(&last->b->write_lock);
a1f0358b2bf69b Kent Overstreet 2013-09-10  1630  			rw_unlock(true, last->b);
a1f0358b2bf69b Kent Overstreet 2013-09-10  1631  		}
cafe563591446c Kent Overstreet 2013-03-23  1632  
a1f0358b2bf69b Kent Overstreet 2013-09-10  1633  		memmove(r + 1, r, sizeof(r[0]) * (GC_MERGE_NODES - 1));
a1f0358b2bf69b Kent Overstreet 2013-09-10  1634  		r->b = NULL;
cafe563591446c Kent Overstreet 2013-03-23  1635  
5c25c4fc74af40 Tang Junhui     2018-07-26  1636  		if (atomic_read(&b->c->search_inflight) &&
7f4a59de28137a Tang Junhui     2018-07-26  1637  		    gc->nodes >= gc->nodes_pre + btree_gc_min_nodes(b->c)) {
5c25c4fc74af40 Tang Junhui     2018-07-26  1638  			gc->nodes_pre =  gc->nodes;
5c25c4fc74af40 Tang Junhui     2018-07-26  1639  			ret = -EAGAIN;
5c25c4fc74af40 Tang Junhui     2018-07-26  1640  			break;
5c25c4fc74af40 Tang Junhui     2018-07-26  1641  		}
5c25c4fc74af40 Tang Junhui     2018-07-26  1642  
cafe563591446c Kent Overstreet 2013-03-23  1643  		if (need_resched()) {
cafe563591446c Kent Overstreet 2013-03-23  1644  			ret = -EAGAIN;
cafe563591446c Kent Overstreet 2013-03-23  1645  			break;
cafe563591446c Kent Overstreet 2013-03-23  1646  		}
cafe563591446c Kent Overstreet 2013-03-23  1647  	}
cafe563591446c Kent Overstreet 2013-03-23  1648  
2a285686c10981 Kent Overstreet 2014-03-04  1649  	for (i = r; i < r + ARRAY_SIZE(r); i++)
2a285686c10981 Kent Overstreet 2014-03-04  1650  		if (!IS_ERR_OR_NULL(i->b)) {
2a285686c10981 Kent Overstreet 2014-03-04  1651  			mutex_lock(&i->b->write_lock);
2a285686c10981 Kent Overstreet 2014-03-04  1652  			if (btree_node_dirty(i->b))
2a285686c10981 Kent Overstreet 2014-03-04  1653  				bch_btree_node_write(i->b, writes);
2a285686c10981 Kent Overstreet 2014-03-04  1654  			mutex_unlock(&i->b->write_lock);
2a285686c10981 Kent Overstreet 2014-03-04  1655  			rw_unlock(true, i->b);
a1f0358b2bf69b Kent Overstreet 2013-09-10  1656  		}
cafe563591446c Kent Overstreet 2013-03-23  1657  
cafe563591446c Kent Overstreet 2013-03-23  1658  	return ret;
cafe563591446c Kent Overstreet 2013-03-23  1659  }
cafe563591446c Kent Overstreet 2013-03-23  1660  

:::::: The code at line 1571 was first introduced by commit
:::::: a1f0358b2bf69be216cb6e4ea40fe7ae4d38b8a6 bcache: Incremental gc

:::::: TO: Kent Overstreet <kmo@daterainc.com>
:::::: CC: Kent Overstreet <kmo@daterainc.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
