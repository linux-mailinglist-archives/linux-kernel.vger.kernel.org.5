Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105FA807DA7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441967AbjLGBMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjLGBMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:12:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4122A4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701911563; x=1733447563;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=75o2yg8HFzMxltHa+9N8ZFpXsXd9Zld+RtsIRddY6h8=;
  b=cNUf3HwJGpJs24oTPMA/u535nz7WKs/svBOmUwBKBuJjYleq2Mx98FWp
   fAiT4eiIiPeWTdsB8Tg60/wWl9qWkT3TazDJ1InUXF/V0BNYj0uPN3gZx
   atxeYvpdCBdCwUtQCEuAAIqDaG6yu/no/vH2B2IArncxKXNn+Ml67H0ix
   t7LO/O5h8P14Ua+iA6OX34ht8qRaBVHfgNa3YFTU9oshfD6uRay+ySiVm
   AMDIAY1cVY+E2/jk9bd50dHjIRfr+FrvvhFv3Tvt3M/xonT0YOUMwZiz7
   YaKQu//8B3Q7TRXSoTVp8m3yHTQDE193WCCCblhMp4/S7+/chmW/Lx+HS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="458477898"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="458477898"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 17:12:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="944840390"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="944840390"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 06 Dec 2023 17:12:41 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rB2vz-000Beg-01;
        Thu, 07 Dec 2023 01:12:35 +0000
Date:   Thu, 7 Dec 2023 09:11:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Leif Lindholm <leif@nuviainc.com>
Subject: drivers/firmware/efi/libstub/arm32-stub.c:12:28: sparse: sparse:
 symbol 'efi_entry_state' was not declared. Should it be static?
Message-ID: <202312070941.LI8cPgRG-lkp@intel.com>
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
config: arm-randconfig-r113-20231116 (https://download.01.org/0day-ci/archive/20231207/202312070941.LI8cPgRG-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231207/202312070941.LI8cPgRG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312070941.LI8cPgRG-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/firmware/efi/libstub/arm32-stub.c:12:28: sparse: sparse: symbol 'efi_entry_state' was not declared. Should it be static?

vim +/efi_entry_state +12 drivers/firmware/efi/libstub/arm32-stub.c

    11	
  > 12	struct efi_arm_entry_state *efi_entry_state;
    13	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
