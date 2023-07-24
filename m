Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376E775FFDD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjGXTjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGXTjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:39:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0956E10F6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 12:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690227544; x=1721763544;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IkiK+g2frn4d6goYddndvFEYn0eSVIZrNs2SJ87y078=;
  b=OQB+mxWArS+MLdbYz5QHu148Igr1ogeVPMbAIYV09hxT8yYMxadZ4J5P
   CY0U9zejRlTaBTdV3mo7H8HRN+hf+O7rHi2jFQIllIybf5Q5XejBECsJF
   reaVpciO8ZrvxDlHGQw3M/A8HZePsyewUqR3Iyzn+j8DQSONuMqanARRs
   ufew57DHdbveo55VVTiMKWg4dxB7k/0nvYYVlsFR+pR2tjFalMZWxgLzq
   XVlW+Akx6IiA5qN1CgMjy54P/6YVf1D1coeMSFJF2mzkJ2tYXbSn38Syx
   5N9kJvN2a2Pw2wXIKAt4NMB8eKhTfH+i2oNuPawEBsoF9XG/Rls+WM0As
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="398445814"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="398445814"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 12:39:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="972389666"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="972389666"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jul 2023 12:39:01 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qO1OV-0009zS-2V;
        Mon, 24 Jul 2023 19:39:00 +0000
Date:   Tue, 25 Jul 2023 03:38:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: debug_vm_pgtable.c:undefined reference to `pmd_set_huge'
Message-ID: <202307250345.iCCBHW1l-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   20ea1e7d13c1b544fe67c4a8dc3943bb1ab33e6f
commit: d8a719059b9dc963aa190598778ac804ff3e6a87 Revert "mm/pgtable: add stubs for {pmd/pub}_{set/clear}_huge"
date:   2 years ago
config: powerpc-randconfig-r033-20230724 (https://download.01.org/0day-ci/archive/20230725/202307250345.iCCBHW1l-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230725/202307250345.iCCBHW1l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307250345.iCCBHW1l-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: warning: certs/system_certificates.o: missing .note.GNU-stack section implies executable stack
   powerpc-linux-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
   powerpc-linux-ld: warning: certs/system_certificates.o: missing .note.GNU-stack section implies executable stack
   powerpc-linux-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
   powerpc-linux-ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with RWX permissions
   powerpc-linux-ld: mm/debug_vm_pgtable.o: in function `pmd_huge_tests':
>> debug_vm_pgtable.c:(.init.text+0x194): undefined reference to `pmd_set_huge'
   powerpc-linux-ld: mm/debug_vm_pgtable.o: in function `pud_huge_tests':
>> debug_vm_pgtable.c:(.init.text+0x29c): undefined reference to `pud_set_huge'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
