Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD008089F6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443001AbjLGOMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjLGOMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:12:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFF710C2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701958369; x=1733494369;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=otLh6o1rX99RrYIJ5oiet7dYcuo6Lqn/Ua6HMYdsT5w=;
  b=cIiZ6Y3pcbDsN2FEQGL/CqK62sDTl8suPiX7R6Qnf6F3Fa5FR2ID4T8F
   SujNF5L0tSkp432LJfbw12QuY8EW559DpBjPwZxxw9ZUjzDmBOqcrLI//
   sLJ4MwrQRZyN6C52SYWknl3m1bGFbX1hexYWGm7MqvWLrumaBibhxLuni
   PmSsdoo0c8DYwpOu6+6QEaIS0098cuK/iwXATDf2vOCc4MFMvMEdsDmbb
   +UVjBj1BtRxM9C0Ge3gT1AqYGM9SqaOIJPFuBY8UOQDEECVnQG6vhsf1J
   +KTv+YldTi6jj3wbHyMhIQ9q5FLcEIVTXXjSxwpmF4vyiZvcrLUui9TC6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="397026053"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="397026053"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 06:12:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="19716476"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 07 Dec 2023 06:12:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBF7N-000CLV-1J;
        Thu, 07 Dec 2023 14:12:45 +0000
Date:   Thu, 7 Dec 2023 22:12:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Leif Lindholm <leif@nuviainc.com>
Subject: drivers/firmware/efi/libstub/arm32-stub.c:12:28: sparse: sparse:
 symbol 'efi_entry_state' was not declared. Should it be static?
Message-ID: <202312072219.Qpsizncn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: 2a55280a3675203496d302463b941834228b9875 efi/libstub: arm: Print CPU boot mode and MMU state at boot
date:   3 years, 6 months ago
config: arm-randconfig-r113-20231116 (https://download.01.org/0day-ci/archive/20231207/202312072219.Qpsizncn-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231207/202312072219.Qpsizncn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312072219.Qpsizncn-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/firmware/efi/libstub/arm32-stub.c:12:28: sparse: sparse: symbol 'efi_entry_state' was not declared. Should it be static?

vim +/efi_entry_state +12 drivers/firmware/efi/libstub/arm32-stub.c

    11	
  > 12	struct efi_arm_entry_state *efi_entry_state;
    13	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
