Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC764779DFD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 09:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbjHLHuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 03:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHLHuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 03:50:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A5F19B2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 00:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691826608; x=1723362608;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=e3PLem7UORvCwHrwfMYi8BWIgfkOqSmAqZBFFhGLuMA=;
  b=iMpcvFbOohFdQAGT2q3iKVJTJyoVIr0Ove6T9UybjH2APUlOjLBMR+ai
   C4PcWtaWXJhMO874gDCsF3DXpWYSTz4dc5MHKzLyzm5yyzMju6bvKJrQ2
   tfOT7K735iJsriOn2/r/vSEHv92UUqlV5uusJStUu+FRZ9zi06vvxbRlu
   FShH7K8BsBsaAd3vNTZb8WL2m0nxJUv/Ip6PTaHZR559DxKMftUiImWhI
   Lk4lfDo2IMNSVM4cnssNlk6j1IEG9L2XF7mmMmXXfCEVFDCNBiT8pj2bL
   BGDnEpOf1+4lh6v+AmZZp4mbdp/2tSHJavpCMbWlDL706kZo0CGoFGI94
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="375521188"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="375521188"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2023 00:50:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="876415081"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 12 Aug 2023 00:50:10 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUjNu-0008O5-0e;
        Sat, 12 Aug 2023 07:50:06 +0000
Date:   Sat, 12 Aug 2023 15:49:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: Cannot find symbol for section 10: .text.kallsyms_test_func_weak.
Message-ID: <202308121535.otQuZept-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f8de32cc060ba3f63171aaa0e8764d22d8c37978
commit: 30f3bb09778de64ef9f23fb4bb5f868c4728a071 kallsyms: Add self-test facility
date:   9 months ago
config: mips-randconfig-r014-20230811 (https://download.01.org/0day-ci/archive/20230812/202308121535.otQuZept-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230812/202308121535.otQuZept-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308121535.otQuZept-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Cannot find symbol for section 10: .text.kallsyms_test_func_weak.
   kernel/kallsyms_selftest.o: failed

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
