Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90987D4A10
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjJXI3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjJXI3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:29:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89911D7B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698136191; x=1729672191;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SLV6MhARR8RYVfBb9XtjSPFc4jJNGlR8zXTP1/dsuaU=;
  b=QosEEBvWeX+uHA2dduVImBNwQMs91V/rwCp/qAGJbCiPODLDaUd6Yggu
   vE+ekNJoWOS3yOaXFBrG9ftA6oB9cjoY8cIGtfnEvYpXTig1AY+5XAZSq
   j44/RoE93shNENYg3ufxYVeBVE/bh3qr2Fv6M9z0tK96XrLWp5pgQ2Cmo
   3RhBYsaCQ7brOpODsNEaByEM1GZTVYQZlfKYwxslfZEeY2ydoFukBwn5X
   gm7eRcXytP8SDl9xKgQeDSRiwzvl0rwxfSpcZOw15LXLkrH7KYbaq/rnp
   wV8Pbky9M+FYF8Wm0SgjMfqDM+L6WMLUUQJTJUqawtbEMjHLE4xzL7nVO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="451242117"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="451242117"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 01:29:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="824218290"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="824218290"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 24 Oct 2023 01:29:46 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qvCnI-0007ib-0t;
        Tue, 24 Oct 2023 08:29:44 +0000
Date:   Tue, 24 Oct 2023 16:28:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: /bin/bash: line 1: 32974 Segmentation fault
      LLVM_OBJCOPY="sh4-linux-objcopy" pahole -J --btf_gen_floats -j
 --lang_exclude=rust --skip_encoding_btf_inconsistent_proto
 --btf_gen_optimized --btf_base vmlinux
 drivers/gpu/drm/logicvc/logicvc-drm.ko
Message-ID: <202310241657.tRyhymM6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d88520ad73b79e71e3ddf08de335b8520ae41c5c
commit: 7b99f75942da332e3f4f865e55a10fec95a30d4f bpf: Add --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags for v1.25
date:   6 months ago
config: sh-randconfig-r081-20230703 (https://download.01.org/0day-ci/archive/20231024/202310241657.tRyhymM6-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231024/202310241657.tRyhymM6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310241657.tRyhymM6-lkp@intel.com/

All errors (new ones prefixed by >>):

   namespace__recode_dwarf_types: couldn't find 0x2baa7 type for 0x26afb (member)!
   namespace__recode_dwarf_types: couldn't find 0x2b740 type for 0x26b08 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bb03 type for 0x26b22 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bc0b type for 0x26b49 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bbf0 type for 0x26b70 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2604d type for 0x26c82 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2604d type for 0x26d0e (member)!
   namespace__recode_dwarf_types: couldn't find 0x2e02d type for 0x26e21 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2c783 type for 0x26e27 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2c1cb type for 0x26e35 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2dd64 type for 0x26e43 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2df67 type for 0x26ea5 (member)!
   namespace__recode_dwarf_types: couldn't find 0x28ebf type for 0x26eb3 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2dfca type for 0x26ec1 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2e05f type for 0x26eed (member)!
   namespace__recode_dwarf_types: couldn't find 0x2ce34 type for 0x26f0b (member)!
   namespace__recode_dwarf_types: couldn't find 0x2ce34 type for 0x26f1a (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bcc9 type for 0x27064 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bcc9 type for 0x27072 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bce3 type for 0x27080 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bcf8 type for 0x2708e (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bd1c type for 0x2709c (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bb8e type for 0x270aa (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bd36 type for 0x270b8 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bd55 type for 0x270c6 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bd6a type for 0x270d4 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bb8e type for 0x270e2 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bb8e type for 0x270f0 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bd93 type for 0x270fe (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bda8 type for 0x2710c (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bdc2 type for 0x2711a (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bc62 type for 0x274b8 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bc8c type for 0x274cc (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bc92 type for 0x274da (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bc67 type for 0x274e8 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2b71d type for 0x2750a (member)!
   namespace__recode_dwarf_types: couldn't find 0x27aa0 type for 0x27a42 (member)!
   namespace__recode_dwarf_types: couldn't find 0x27ab7 type for 0x27a5c (member)!
   namespace__recode_dwarf_types: couldn't find 0x2e02d type for 0x26e21 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2c783 type for 0x26e27 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2c1cb type for 0x26e35 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2dd64 type for 0x26e43 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2df67 type for 0x26ea5 (member)!
   namespace__recode_dwarf_types: couldn't find 0x28ebf type for 0x26eb3 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2dfca type for 0x26ec1 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2e05f type for 0x26eed (member)!
   namespace__recode_dwarf_types: couldn't find 0x2ce34 type for 0x26f0b (member)!
   namespace__recode_dwarf_types: couldn't find 0x2ce34 type for 0x26f1a (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bcc9 type for 0x27064 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bcc9 type for 0x27072 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bce3 type for 0x27080 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bcf8 type for 0x2708e (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bd1c type for 0x2709c (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bb8e type for 0x270aa (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bd36 type for 0x270b8 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bd55 type for 0x270c6 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bd6a type for 0x270d4 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bb8e type for 0x270e2 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bb8e type for 0x270f0 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bd93 type for 0x270fe (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bda8 type for 0x2710c (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bdc2 type for 0x2711a (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bc62 type for 0x274b8 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bc8c type for 0x274cc (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bc92 type for 0x274da (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bc67 type for 0x274e8 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2b71d type for 0x2750a (member)!
   namespace__recode_dwarf_types: couldn't find 0x27aa0 type for 0x27a42 (member)!
   namespace__recode_dwarf_types: couldn't find 0x27ab7 type for 0x27a5c (member)!
   namespace__recode_dwarf_types: couldn't find 0x2e02d type for 0x26e21 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2c783 type for 0x26e27 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2c1cb type for 0x26e35 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2dd64 type for 0x26e43 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2df67 type for 0x26ea5 (member)!
   namespace__recode_dwarf_types: couldn't find 0x28ebf type for 0x26eb3 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2dfca type for 0x26ec1 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2e05f type for 0x26eed (member)!
   namespace__recode_dwarf_types: couldn't find 0x2ce34 type for 0x26f0b (member)!
   namespace__recode_dwarf_types: couldn't find 0x2ce34 type for 0x26f1a (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bcc9 type for 0x27064 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bcc9 type for 0x27072 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bce3 type for 0x27080 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bcf8 type for 0x2708e (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bd1c type for 0x2709c (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bb8e type for 0x270aa (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bd36 type for 0x270b8 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bd55 type for 0x270c6 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bd6a type for 0x270d4 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bb8e type for 0x270e2 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bb8e type for 0x270f0 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bd93 type for 0x270fe (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bda8 type for 0x2710c (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bdc2 type for 0x2711a (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bc62 type for 0x274b8 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bc8c type for 0x274cc (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bc92 type for 0x274da (member)!
   namespace__recode_dwarf_types: couldn't find 0x2bc67 type for 0x274e8 (member)!
   namespace__recode_dwarf_types: couldn't find 0x2b71d type for 0x2750a (member)!
   namespace__recode_dwarf_types: couldn't find 0x27aa0 type for 0x27a42 (member)!
   namespace__recode_dwarf_types: couldn't find 0x27ab7 type for 0x27a5c (member)!
>> /bin/bash: line 1: 32974 Segmentation fault      LLVM_OBJCOPY="sh4-linux-objcopy" pahole -J --btf_gen_floats -j --lang_exclude=rust --skip_encoding_btf_inconsistent_proto --btf_gen_optimized --btf_base vmlinux drivers/gpu/drm/logicvc/logicvc-drm.ko

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
