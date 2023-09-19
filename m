Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC5F7A6C8E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 22:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjISUzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 16:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjISUzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 16:55:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B649BF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 13:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695156932; x=1726692932;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FF0ZPQSrk4gbXx35U3K5Nvy3Iv4s+6kViKsplQcKT9Q=;
  b=M3aVdRiZiGRTuLgZyxMu9LRYeXG0ite9QuW5H+Aq5+IrBW1kdSnE34ka
   5B4r+p/VA1IfPDIZDTuxqmmPy15fn1zjtCmy9+eBXjA+LX5yOnsYrDo9T
   KIZeAVrNvjViPq/12TuUaBpaJ/l7mycB+SLDHT9R2BH5FCZH3XSNsrYMO
   Q0yxl0cnGe40txyyH7eeeatWIlwV6t+78CybbXOS8u0reG/eI8sqLBdD4
   E3mUJji9Pw1cJZDI2Xt0+PgqvZ93XA3vjbeeiJEu3/R2lyapRo5r1QKy/
   Mclb0YqNo/MXcdOOdgxg8G6mrHoXHIgP0TJVhgGROA+8xd4DH1mUA5ufj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="377358389"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="377358389"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 13:55:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="836579877"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="836579877"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Sep 2023 13:55:27 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qihkj-0007vI-2v;
        Tue, 19 Sep 2023 20:55:25 +0000
Date:   Wed, 20 Sep 2023 04:55:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Carl Vanderlip <quic_carlv@quicinc.com>,
        Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: drivers/accel/qaic/qaic_control.c:348:17: warning: array subscript
 'struct wrapper_msg[0]' is partly outside array bounds of 'unsigned
 char[44]'
Message-ID: <202309200403.mGPrZFN4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffrey,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2cf0f715623872823a72e451243bbf555d10d032
commit: 759662e4f1f8cd6ea0ec466e10cf29fe7c1fec36 accel/qaic: Add qaic driver to the build system
date:   6 months ago
config: i386-randconfig-i015-20230718 (https://download.01.org/0day-ci/archive/20230920/202309200403.mGPrZFN4-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230920/202309200403.mGPrZFN4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309200403.mGPrZFN4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In function 'add_wrapper',
       inlined from 'abort_dma_cont' at drivers/accel/qaic/qaic_control.c:1107:12,
       inlined from 'qaic_manage_msg_xfer' at drivers/accel/qaic/qaic_control.c:1165:9:
>> drivers/accel/qaic/qaic_control.c:348:17: warning: array subscript 'struct wrapper_msg[0]' is partly outside array bounds of 'unsigned char[44]' [-Warray-bounds]
     348 |         w->head = wrappers;
         |         ~~~~~~~~^~~~~~~~~~
   In file included from include/linux/fs.h:45,
                    from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:855,
                    from include/linux/scatterlist.h:8,
                    from include/linux/dma-mapping.h:10,
                    from drivers/accel/qaic/qaic_control.c:10:
   In function 'kmalloc',
       inlined from 'kzalloc' at include/linux/slab.h:720:9,
       inlined from 'add_wrapper' at drivers/accel/qaic/qaic_control.c:342:26,
       inlined from 'abort_dma_cont' at drivers/accel/qaic/qaic_control.c:1107:12,
       inlined from 'qaic_manage_msg_xfer' at drivers/accel/qaic/qaic_control.c:1165:9:
   include/linux/slab.h:580:24: note: object of size 44 allocated by 'kmalloc_trace'
     580 |                 return kmalloc_trace(
         |                        ^~~~~~~~~~~~~~
     581 |                                 kmalloc_caches[kmalloc_type(flags)][index],
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     582 |                                 flags, size);
         |                                 ~~~~~~~~~~~~
   In function 'abort_dma_cont',
       inlined from 'qaic_manage_msg_xfer' at drivers/accel/qaic/qaic_control.c:1165:9:
   drivers/accel/qaic/qaic_control.c:1121:22: warning: array subscript 'struct wrapper_msg[0]' is partly outside array bounds of 'unsigned char[44]' [-Warray-bounds]
    1121 |         wrapper->len = size;
         |         ~~~~~~~~~~~~~^~~~~~
   In function 'kmalloc',
       inlined from 'kzalloc' at include/linux/slab.h:720:9,
       inlined from 'add_wrapper' at drivers/accel/qaic/qaic_control.c:342:26,
       inlined from 'abort_dma_cont' at drivers/accel/qaic/qaic_control.c:1107:12,
       inlined from 'qaic_manage_msg_xfer' at drivers/accel/qaic/qaic_control.c:1165:9:
   include/linux/slab.h:580:24: note: object of size 44 allocated by 'kmalloc_trace'
     580 |                 return kmalloc_trace(
         |                        ^~~~~~~~~~~~~~
     581 |                                 kmalloc_caches[kmalloc_type(flags)][index],
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     582 |                                 flags, size);
         |                                 ~~~~~~~~~~~~


vim +348 drivers/accel/qaic/qaic_control.c

129776ac2e3823 Jeffrey Hugo 2023-03-27  339  
129776ac2e3823 Jeffrey Hugo 2023-03-27  340  static struct wrapper_msg *add_wrapper(struct wrapper_list *wrappers, u32 size)
129776ac2e3823 Jeffrey Hugo 2023-03-27  341  {
129776ac2e3823 Jeffrey Hugo 2023-03-27  342  	struct wrapper_msg *w = kzalloc(size, GFP_KERNEL);
129776ac2e3823 Jeffrey Hugo 2023-03-27  343  
129776ac2e3823 Jeffrey Hugo 2023-03-27  344  	if (!w)
129776ac2e3823 Jeffrey Hugo 2023-03-27  345  		return NULL;
129776ac2e3823 Jeffrey Hugo 2023-03-27  346  	list_add_tail(&w->list, &wrappers->list);
129776ac2e3823 Jeffrey Hugo 2023-03-27  347  	kref_init(&w->ref_count);
129776ac2e3823 Jeffrey Hugo 2023-03-27 @348  	w->head = wrappers;
129776ac2e3823 Jeffrey Hugo 2023-03-27  349  	return w;
129776ac2e3823 Jeffrey Hugo 2023-03-27  350  }
129776ac2e3823 Jeffrey Hugo 2023-03-27  351  

:::::: The code at line 348 was first introduced by commit
:::::: 129776ac2e38231fa9c02ce20e116c99de291666 accel/qaic: Add control path

:::::: TO: Jeffrey Hugo <quic_jhugo@quicinc.com>
:::::: CC: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
