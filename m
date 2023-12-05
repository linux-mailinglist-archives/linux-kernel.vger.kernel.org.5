Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0234C8054D4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345223AbjLEMlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjLEMlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:41:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607E4181
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701780088; x=1733316088;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RtBu+QxQtHW+TcgROX0mBY2zSgQvg6znf9uGKvyl8Ag=;
  b=Io6JuLZYaztcscUNAxIjtzBqorkLbIiJ7wlmYuwYlG/i8FLahBSEkEBR
   z0X/dnBDlOAwgdz8VTbchR/T+Mhj5kXLmQ7CZHFqjSU8TNgElb72N8rUh
   bHiWtPWMrUXq38X6BBJlSx9kl5LffjmBDF1P1WHPzhPO3BoSRCAQN6QJq
   b0baOI6IOkiTitaSZ+IkmHk2gQok/5u937KElD1VfG/xRLNorrHjPnz81
   hAoLx2Twj6Jis+kTEKqUll3goBX/YRGVI0AE9N8W/8UjK2U0ae/2tyo3H
   mWVaiF+rXvXSrBEzHS5M2PwDzoVztLOtiJuK9tbBNtfQcMXwKmOCUOP1e
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="942085"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="942085"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 04:41:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="1018210030"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="1018210030"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 05 Dec 2023 04:41:26 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAUjm-0008yf-0P;
        Tue, 05 Dec 2023 12:41:19 +0000
Date:   Tue, 5 Dec 2023 20:40:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Leif Lindholm <leif@nuviainc.com>
Subject: drivers/firmware/efi/libstub/arm32-stub.c:12:28: sparse: sparse:
 symbol 'efi_entry_state' was not declared. Should it be static?
Message-ID: <202312052029.uKL2SfSM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: 2a55280a3675203496d302463b941834228b9875 efi/libstub: arm: Print CPU boot mode and MMU state at boot
date:   3 years, 6 months ago
config: arm-randconfig-r113-20231116 (https://download.01.org/0day-ci/archive/20231205/202312052029.uKL2SfSM-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231205/202312052029.uKL2SfSM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312052029.uKL2SfSM-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/firmware/efi/libstub/arm32-stub.c:12:28: sparse: sparse: symbol 'efi_entry_state' was not declared. Should it be static?

vim +/efi_entry_state +12 drivers/firmware/efi/libstub/arm32-stub.c

    11	
  > 12	struct efi_arm_entry_state *efi_entry_state;
    13	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
