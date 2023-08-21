Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F01783685
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 01:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjHUX5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 19:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbjHUX5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:57:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92F0C7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 16:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692662261; x=1724198261;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x77maobvxv0716Z79bZDjjOJtOUA6+M6SN0qi1SRP9Y=;
  b=EotC3lcxMRL6xhESrJLDh/TFypimAzLXhQmTwwI5HC9eAjdzXFBJuF5V
   tah92asPYNUsNV8GrAbMkUxVIbxw1sMUiGHD0NutRvX8PqkT9c5a2nhGd
   Ua+TSpwjyJ3j+eByA7HNUwYWK2CpoCU8PrL+WMOMADA+chXUqx6I/0QU1
   MHiM/z1UnG5N2P/q/Q09imqdpvF/ORxq9QxlAKKhCeXs9dFL1o1krKriL
   /mySMXjDwpY9QkEIyqKZrDeHTtCqg99axNNmkipr4KV8ck1YX2lPVUbh0
   AdMlIXgAgs33BuObYTmWohpL7RQ8Ke2MSEB0bmWGWJLlPW47uCfXNYG9K
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="437653898"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="437653898"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 16:57:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="806092429"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="806092429"
Received: from lkp-server02.sh.intel.com (HELO 6809aa828f2a) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 21 Aug 2023 16:57:39 -0700
Received: from kbuild by 6809aa828f2a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYEm7-000155-22;
        Mon, 21 Aug 2023 23:57:37 +0000
Date:   Tue, 22 Aug 2023 07:56:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: /bin/bash: line 1: 36578 Segmentation fault
      LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j
 --lang_exclude=rust --skip_encoding_btf_inconsistent_proto
 --btf_gen_optimized --btf_base vmlinux drivers/rpmsg/virtio_rpmsg_bus.ko
Message-ID: <202308220712.sxPVZGmi-lkp@intel.com>
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
head:   f7757129e3dea336c407551c98f50057c22bb266
commit: a0e35a648faf9170e0c32c98b22e66f0a2d964d3 Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
date:   3 months ago
config: hexagon-randconfig-r001-20230821 (https://download.01.org/0day-ci/archive/20230822/202308220712.sxPVZGmi-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230822/202308220712.sxPVZGmi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308220712.sxPVZGmi-lkp@intel.com/

All errors (new ones prefixed by >>):

   die__process: got compile_unit unexpected tag after DW_TAG_compile_unit!
>> /bin/bash: line 1: 36578 Segmentation fault      LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j --lang_exclude=rust --skip_encoding_btf_inconsistent_proto --btf_gen_optimized --btf_base vmlinux drivers/rpmsg/virtio_rpmsg_bus.ko

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
