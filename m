Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F27751C24
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbjGMIte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbjGMItF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:49:05 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62412729
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689238132; x=1720774132;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N3CGWABMKysaB6zJWeS8pB0qgMTObx3+ZHhkd6+GAOY=;
  b=NjTahdOSc6fIumHuoyt/XYUWghxSGgBC4djeKFaICAgH8Gb/r/nQjery
   j6Pr/oNibgrU+lyAJM4wTN7IjxZ4naUsvOR2lG7A3s38BpJahTbVC0o9K
   Z9Q7dNgyfUHz/+Wb/F3dW4EfGFqjSoJ6RN7ZmbkJ7IVWFaGVAsjHQiSQG
   T97qnpSmC/xVmqfnFJlrlJ7oqE6cmrwsMx/oKAozWxftqWH8YDTsW3tFM
   MBi9OnCjkGH7dxhf+KAKJR8Ko3bxDZEw6PgwtAxk2uo+YMo3dHYQaf409
   E4ErLisDE/4Fmf4o3rSOuc5rxOAeJG8qXEtBJKAJcFtUZx5PGiCah5WjN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="451494348"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="451494348"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 01:48:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="968531002"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="968531002"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jul 2023 01:48:47 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJs0E-0006Rb-14;
        Thu, 13 Jul 2023 08:48:46 +0000
Date:   Thu, 13 Jul 2023 16:47:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: ld.lld: warning: stack frame size (2136) exceeds limit (2048) in
 function 'hidinput_configure_usage'
Message-ID: <202307131635.1isJZ30o-lkp@intel.com>
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
head:   eb26cbb1a754ccde5d4d74527dad5ba051808fad
commit: f12b034afeb3a977bbb1c6584dedc0f3dc666f14 scripts/Makefile.clang: default to LLVM_IAS=1
date:   1 year, 11 months ago
config: x86_64-buildonly-randconfig-r002-20230713 (https://download.01.org/0day-ci/archive/20230713/202307131635.1isJZ30o-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230713/202307131635.1isJZ30o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307131635.1isJZ30o-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> ld.lld: warning: stack frame size (2136) exceeds limit (2048) in function 'hidinput_configure_usage'
   vmlinux.o: warning: objtool: .altinstr_replacement+0x2dd: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x2f6: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x33d: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x371: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x3cb: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x3d7: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x3f8: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x460: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x485: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x49e: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x4ab: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x4b7: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x4c4: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x8a7: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x9f9: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0xb6a: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0xd78: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0xe3a: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x1469: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x15a3: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x17fc: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x1bbc: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x1c93: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x1ff5: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x2537: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x2543: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x2820: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x2846: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x29b4: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x29c1: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x29f4: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x2a1a: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x2a53: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x2a94: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x2aa8: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x2ac5: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x2adf: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x2feb: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x3209: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x322a: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x3a4f: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x3e5f: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x3e9c: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x3f70: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x45fc: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x4b07: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x4b4f: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x528c: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x5993: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x59d8: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x5a43: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x5a8f: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x5aa8: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x5ac1: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x5ada: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x5b6f: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x5c35: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x5d64: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x61a2: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x61c8: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x61ee: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x62ec: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x6305: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x6350: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x63e7: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x645f: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x646b: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x6489: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x6524: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x66fd: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x68b9: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x68d2: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x76bf: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x76d8: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x7a1f: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x8026: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x81c2: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x8381: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x88a6: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x8948: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x8dc0: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x9605: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x9847: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x993d: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0xcc4f: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0xcced: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0xced2: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0xcef3: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0xcf0c: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0xcf25: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0xe954: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x1241a: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x12ddc: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x1358f: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x13698: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x136be: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x14dba: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x1503f: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x1507a: redundant UACCESS disable
   vmlinux.o: warning: objtool: .altinstr_replacement+0x151ab: redundant UACCESS disable

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
