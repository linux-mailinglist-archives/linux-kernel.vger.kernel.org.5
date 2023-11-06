Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38B67E2E69
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjKFUsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjKFUso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:48:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4861710A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699303721; x=1730839721;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2A3DxbgwDIeKtTHs+XIhBI+I56ziuucumFGPKJ8wOPc=;
  b=L9AKyJuoP6fz0137jKo1QnGeRVwraO+0F1bMtYeCEvlqhLOZr5NlSsNZ
   VzHQSqwWgrZ54gNrFTfF3/6XdIYppSFjpwAurCyzigkCM54/siIlX/qvq
   1NpvlnDxJbQ/lsMIRVNGGUmldOiS9pZwanZIhHoJ+8UX69PmP7pfNjAdH
   k2iXSRRPgsnG1vPiZ2jIuktMcw/5TuWw6I3lwvqCMGxrVbcpNqvgojX5u
   g0kAQ5qfTIHqyvzI8dAE6jFEZozsaEXC/gOULsT5d/+ZcJr9youHHrH/u
   tI83nb0z7Q81k2CDat+dYpx1DCzo8mStPZ6MFzmxnn+9cZ8+jD5Oq/PvZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="455845985"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="455845985"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 12:48:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="10577613"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 06 Nov 2023 12:48:39 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r06WS-0006im-2W;
        Mon, 06 Nov 2023 20:48:36 +0000
Date:   Tue, 7 Nov 2023 04:48:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rohan McLure <rmclure@linux.ibm.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c:578:5:
 warning: stack frame size (2144) exceeds limit (2048) in
 'hantro_g2_hevc_dec_run'
Message-ID: <202311070412.oRu9ZBhc-lkp@intel.com>
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

Hi Rohan,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2f51b3516dade79269ff45eae2a7668ae711b25
commit: 6f0926c00565a91f3bd7ca1aa05db307daed5e0f powerpc/kcsan: Add KCSAN Support
date:   9 months ago
config: powerpc64-allyesconfig (https://download.01.org/0day-ci/archive/20231107/202311070412.oRu9ZBhc-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231107/202311070412.oRu9ZBhc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311070412.oRu9ZBhc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c:578:5: warning: stack frame size (2144) exceeds limit (2048) in 'hantro_g2_hevc_dec_run' [-Wframe-larger-than]
     578 | int hantro_g2_hevc_dec_run(struct hantro_ctx *ctx)
         |     ^
   1 warning generated.
--
>> drivers/input/touchscreen/cyttsp4_core.c:1682:12: warning: stack frame size (2112) exceeds limit (2048) in 'cyttsp4_startup' [-Wframe-larger-than]
    1682 | static int cyttsp4_startup(struct cyttsp4 *cd)
         |            ^
   1 warning generated.
--
   drivers/net/ethernet/ibm/ibmvnic.c:194:6: warning: variable 'rc' set but not used [-Wunused-but-set-variable]
     194 |         int rc, i;
         |             ^
>> drivers/net/ethernet/ibm/ibmvnic.c:5970:13: warning: stack frame size (2320) exceeds limit (2048) in 'ibmvnic_tasklet' [-Wframe-larger-than]
    5970 | static void ibmvnic_tasklet(struct tasklet_struct *t)
         |             ^
   2 warnings generated.
--
>> drivers/net/ethernet/qlogic/qed/qed_mng_tlv.c:1244:5: warning: stack frame size (2368) exceeds limit (2048) in 'qed_mfw_process_tlv_req' [-Wframe-larger-than]
    1244 | int qed_mfw_process_tlv_req(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
         |     ^
   1 warning generated.


vim +/hantro_g2_hevc_dec_run +578 drivers/media/platform/verisilicon/hantro_g2_hevc_dec.c

5523dc7b851849 drivers/staging/media/hantro/hantro_g2_hevc_dec.c Benjamin Gaignard 2021-07-15  577  
cb5dd5a0fa518d drivers/staging/media/hantro/hantro_g2_hevc_dec.c Benjamin Gaignard 2021-06-03 @578  int hantro_g2_hevc_dec_run(struct hantro_ctx *ctx)

:::::: The code at line 578 was first introduced by commit
:::::: cb5dd5a0fa518dff14ff2b90837c3c8f98f4dd5c media: hantro: Introduce G2/HEVC decoder

:::::: TO: Benjamin Gaignard <benjamin.gaignard@collabora.com>
:::::: CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
