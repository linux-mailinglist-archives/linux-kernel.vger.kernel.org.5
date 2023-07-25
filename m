Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBB376275E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 01:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjGYXep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 19:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjGYXen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 19:34:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE4E1BD5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 16:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690328082; x=1721864082;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PrZs6REpcSVjQjLttbz9hc0QGh+tUGcg58hDcxEoPkA=;
  b=TQ0Vr8MlrM9MxI+7CZaAMZhL741MBlT22A9BrQFxtDuogtXeoGQVw8SD
   oJ0PtooeXRC80eZrCboEPRilb/hOOjXU9D/lUFIO2xdfrOJvpSATYC0bC
   eMbTqA3a5uidDO+Jr770s/L2yzhEZv8grHDiVeoaAdBiuunGjN8NOaRUj
   hoTwy7fKDwpalnZdesvjlF24itb6fXrwcwyIOZGMWvMVu6rs0octv33Y3
   MsN7WZjd7FXWuRSFaNWRMb5xPQWZtjCFcR9om4HW0OWC6Q2FNDEGY3MI0
   VjoHYOK0lFLiWAdQI5RBXPtWI7xOSCN0UVTrkXoRSkumTMcTZqsuJYQJj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="366747665"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="366747665"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 16:34:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="755945610"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="755945610"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 25 Jul 2023 16:34:40 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qORY7-0000Ql-2S;
        Tue, 25 Jul 2023 23:34:39 +0000
Date:   Wed, 26 Jul 2023 07:34:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: arch/riscv/net/bpf_jit.h:241:30: sparse: sparse: cast truncates bits
 from constant value (7ff becomes ff)
Message-ID: <202307260704.dUElCrWU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   af2e19389c2c1d8a299e04c5105b180ef0c5b5b5
commit: 2d311f480b52eeb2e1fd432d64b78d82952c3808 riscv, bpf: Fix patch_text implicit declaration
date:   5 months ago
config: riscv-randconfig-r072-20230725 (https://download.01.org/0day-ci/archive/20230726/202307260704.dUElCrWU-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230726/202307260704.dUElCrWU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307260704.dUElCrWU-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zicbom_zihintpause'
   arch/riscv/net/bpf_jit_comp64.c: note: in included file:
>> arch/riscv/net/bpf_jit.h:241:30: sparse: sparse: cast truncates bits from constant value (7ff becomes ff)

vim +241 arch/riscv/net/bpf_jit.h

ca6cb5447ceca6 Luke Nelson 2020-03-04  238  
ca6cb5447ceca6 Luke Nelson 2020-03-04  239  static inline u32 rv_s_insn(u16 imm11_0, u8 rs2, u8 rs1, u8 funct3, u8 opcode)
ca6cb5447ceca6 Luke Nelson 2020-03-04  240  {
ca6cb5447ceca6 Luke Nelson 2020-03-04 @241  	u8 imm11_5 = imm11_0 >> 5, imm4_0 = imm11_0 & 0x1f;
ca6cb5447ceca6 Luke Nelson 2020-03-04  242  
ca6cb5447ceca6 Luke Nelson 2020-03-04  243  	return (imm11_5 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) |
ca6cb5447ceca6 Luke Nelson 2020-03-04  244  		(imm4_0 << 7) | opcode;
ca6cb5447ceca6 Luke Nelson 2020-03-04  245  }
ca6cb5447ceca6 Luke Nelson 2020-03-04  246  

:::::: The code at line 241 was first introduced by commit
:::::: ca6cb5447ceca6a87d6b62c9e5d41042c34f7ffa riscv, bpf: Factor common RISC-V JIT code

:::::: TO: Luke Nelson <lukenels@cs.washington.edu>
:::::: CC: Daniel Borkmann <daniel@iogearbox.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
