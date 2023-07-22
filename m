Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486CC75D934
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 04:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjGVCwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 22:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGVCwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 22:52:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090EF10F4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 19:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689994333; x=1721530333;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=exp7EvxJKUlx3SqBW/sHUJW3z+jiHOVg16APC+Lbyjc=;
  b=Hox5p9MkTJJ7IqunmDuWamlCxiJDIlESI9GSxJvX2gN3K9EHMv8n6ICk
   bAuH0CWkuAHphTUvu/TNrF+0q8sJt0GPw/hAFa6S6iTseAeb3rMzYx1rq
   WBf9L6XIZSZtgiQjGHyf5ohnOmMWQbJHWnAxum4Qjhbp65cla6KJlSbED
   IqlIdaWTXx4roJlf6gwXEDw98T8npjKvEjJGIB8CK/Cj+ys/PPT0ZFdCB
   a67EiUEeq/nkzBYz4FjWRuFTc27QAyHxuXIzJVUDfONSEMB6w//w/I3uH
   GQxLAvU2Jt0u+wRq+bFlhxkclmbrucJaCwmc+5yygLjnSu+OdWTySP0JA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="367186379"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="367186379"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 19:52:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="754694903"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="754694903"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 21 Jul 2023 19:52:10 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qN2j4-0007tf-0a;
        Sat, 22 Jul 2023 02:52:10 +0000
Date:   Sat, 22 Jul 2023 10:51:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Subject: tools/lib/bpf/relo_core.c:1172:5: warning: stack frame size (1040)
 exceeds limit (1024) in 'bpf_core_calc_relo_insn'
Message-ID: <202307221012.UciyuMNh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yonghong,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d192f5382581d972c4ae1b4d72e0b59b34cadeb9
commit: 776281652ddcd98bb292335ea3634da341c849b4 libbpf: Permit 64bit relocation value
date:   1 year, 1 month ago
config: riscv-randconfig-r022-20230722 (https://download.01.org/0day-ci/archive/20230722/202307221012.UciyuMNh-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20230722/202307221012.UciyuMNh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307221012.UciyuMNh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> tools/lib/bpf/relo_core.c:1172:5: warning: stack frame size (1040) exceeds limit (1024) in 'bpf_core_calc_relo_insn' [-Wframe-larger-than]
   int bpf_core_calc_relo_insn(const char *prog_name,
       ^
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   1 warning and 20 errors generated.


vim +/bpf_core_calc_relo_insn +1172 tools/lib/bpf/relo_core.c

b0588390dbcedc Alexei Starovoitov 2021-07-20  1121  
b0588390dbcedc Alexei Starovoitov 2021-07-20  1122  /*
adb8fa195efdfa Mauricio Vásquez   2022-02-15  1123   * Calculate CO-RE relocation target result.
b0588390dbcedc Alexei Starovoitov 2021-07-20  1124   *
b0588390dbcedc Alexei Starovoitov 2021-07-20  1125   * The outline and important points of the algorithm:
b0588390dbcedc Alexei Starovoitov 2021-07-20  1126   * 1. For given local type, find corresponding candidate target types.
b0588390dbcedc Alexei Starovoitov 2021-07-20  1127   *    Candidate type is a type with the same "essential" name, ignoring
b0588390dbcedc Alexei Starovoitov 2021-07-20  1128   *    everything after last triple underscore (___). E.g., `sample`,
b0588390dbcedc Alexei Starovoitov 2021-07-20  1129   *    `sample___flavor_one`, `sample___flavor_another_one`, are all candidates
b0588390dbcedc Alexei Starovoitov 2021-07-20  1130   *    for each other. Names with triple underscore are referred to as
b0588390dbcedc Alexei Starovoitov 2021-07-20  1131   *    "flavors" and are useful, among other things, to allow to
b0588390dbcedc Alexei Starovoitov 2021-07-20  1132   *    specify/support incompatible variations of the same kernel struct, which
b0588390dbcedc Alexei Starovoitov 2021-07-20  1133   *    might differ between different kernel versions and/or build
b0588390dbcedc Alexei Starovoitov 2021-07-20  1134   *    configurations.
b0588390dbcedc Alexei Starovoitov 2021-07-20  1135   *
b0588390dbcedc Alexei Starovoitov 2021-07-20  1136   *    N.B. Struct "flavors" could be generated by bpftool's BTF-to-C
b0588390dbcedc Alexei Starovoitov 2021-07-20  1137   *    converter, when deduplicated BTF of a kernel still contains more than
b0588390dbcedc Alexei Starovoitov 2021-07-20  1138   *    one different types with the same name. In that case, ___2, ___3, etc
b0588390dbcedc Alexei Starovoitov 2021-07-20  1139   *    are appended starting from second name conflict. But start flavors are
b0588390dbcedc Alexei Starovoitov 2021-07-20  1140   *    also useful to be defined "locally", in BPF program, to extract same
b0588390dbcedc Alexei Starovoitov 2021-07-20  1141   *    data from incompatible changes between different kernel
b0588390dbcedc Alexei Starovoitov 2021-07-20  1142   *    versions/configurations. For instance, to handle field renames between
b0588390dbcedc Alexei Starovoitov 2021-07-20  1143   *    kernel versions, one can use two flavors of the struct name with the
b0588390dbcedc Alexei Starovoitov 2021-07-20  1144   *    same common name and use conditional relocations to extract that field,
b0588390dbcedc Alexei Starovoitov 2021-07-20  1145   *    depending on target kernel version.
b0588390dbcedc Alexei Starovoitov 2021-07-20  1146   * 2. For each candidate type, try to match local specification to this
b0588390dbcedc Alexei Starovoitov 2021-07-20  1147   *    candidate target type. Matching involves finding corresponding
b0588390dbcedc Alexei Starovoitov 2021-07-20  1148   *    high-level spec accessors, meaning that all named fields should match,
b0588390dbcedc Alexei Starovoitov 2021-07-20  1149   *    as well as all array accesses should be within the actual bounds. Also,
b0588390dbcedc Alexei Starovoitov 2021-07-20  1150   *    types should be compatible (see bpf_core_fields_are_compat for details).
b0588390dbcedc Alexei Starovoitov 2021-07-20  1151   * 3. It is supported and expected that there might be multiple flavors
b0588390dbcedc Alexei Starovoitov 2021-07-20  1152   *    matching the spec. As long as all the specs resolve to the same set of
b0588390dbcedc Alexei Starovoitov 2021-07-20  1153   *    offsets across all candidates, there is no error. If there is any
9bbdfad8a5192c Daniel Müller      2022-06-01  1154   *    ambiguity, CO-RE relocation will fail. This is necessary to accommodate
9bbdfad8a5192c Daniel Müller      2022-06-01  1155   *    imperfection of BTF deduplication, which can cause slight duplication of
b0588390dbcedc Alexei Starovoitov 2021-07-20  1156   *    the same BTF type, if some directly or indirectly referenced (by
b0588390dbcedc Alexei Starovoitov 2021-07-20  1157   *    pointer) type gets resolved to different actual types in different
9bbdfad8a5192c Daniel Müller      2022-06-01  1158   *    object files. If such a situation occurs, deduplicated BTF will end up
b0588390dbcedc Alexei Starovoitov 2021-07-20  1159   *    with two (or more) structurally identical types, which differ only in
b0588390dbcedc Alexei Starovoitov 2021-07-20  1160   *    types they refer to through pointer. This should be OK in most cases and
b0588390dbcedc Alexei Starovoitov 2021-07-20  1161   *    is not an error.
b0588390dbcedc Alexei Starovoitov 2021-07-20  1162   * 4. Candidate types search is performed by linearly scanning through all
b0588390dbcedc Alexei Starovoitov 2021-07-20  1163   *    types in target BTF. It is anticipated that this is overall more
b0588390dbcedc Alexei Starovoitov 2021-07-20  1164   *    efficient memory-wise and not significantly worse (if not better)
b0588390dbcedc Alexei Starovoitov 2021-07-20  1165   *    CPU-wise compared to prebuilding a map from all local type names to
b0588390dbcedc Alexei Starovoitov 2021-07-20  1166   *    a list of candidate type names. It's also sped up by caching resolved
b0588390dbcedc Alexei Starovoitov 2021-07-20  1167   *    list of matching candidates per each local "root" type ID, that has at
b0588390dbcedc Alexei Starovoitov 2021-07-20  1168   *    least one bpf_core_relo associated with it. This list is shared
b0588390dbcedc Alexei Starovoitov 2021-07-20  1169   *    between multiple relocations for the same type ID and is updated as some
b0588390dbcedc Alexei Starovoitov 2021-07-20  1170   *    of the candidates are pruned due to structural incompatibility.
b0588390dbcedc Alexei Starovoitov 2021-07-20  1171   */
adb8fa195efdfa Mauricio Vásquez   2022-02-15 @1172  int bpf_core_calc_relo_insn(const char *prog_name,

:::::: The code at line 1172 was first introduced by commit
:::::: adb8fa195efdfaac5852aaac24810b456ce43b04 libbpf: Split bpf_core_apply_relo()

:::::: TO: Mauricio Vásquez <mauricio@kinvolk.io>
:::::: CC: Andrii Nakryiko <andrii@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
