Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1A97BC092
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjJFUml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbjJFUmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:42:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B39C2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696624954; x=1728160954;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UViyi8XdqDaf4Zz+Enms3juwPuqKKxUUshyEiDhi8uk=;
  b=N1oTtnqWOVkZe47tELFLx6J/EY8qGEUpPm2N/R9W14/aJvZpAQNrPMZp
   QwhiQQ8qMjm48EV9P4NXQOXiPfKDrtnnbJ94Vc7mwQcnxvKg4kEdf69BT
   rKAzuHSMwl+vciL8EFukm+JLXHDZX1FuNQiA1M6jTicATOTyGAgT7Sd0i
   VDuXJpTpVLTzZTfh3IsCdF5hOxPlhPkO6jD6PAc/ox+aeVo/0gJ+3zcAK
   P3NoyZa9xyWw1C/bLVGpL+NrNEM+SuJodnYfHUliIk33QM1bOfAQBxKTW
   /NZx7qGgjVngLPJdBZLSvBzVTyESt6NvWt1iFlzF0Dv5LJJlYvbTmB60X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="450325198"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="450325198"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 13:42:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="728982579"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="728982579"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Oct 2023 13:42:32 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoreX-0003d7-30;
        Fri, 06 Oct 2023 20:42:29 +0000
Date:   Sat, 7 Oct 2023 04:41:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: ERROR: start_text address is c000000000000900, should be
 c000000000000200
Message-ID: <202310070419.BcA2fDgk-lkp@intel.com>
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

Hi Randy,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   af95dc6fdc25e616051d0234aad638e15c02ec8f
commit: 47c258d71ebfc832a760a1dc6540cf3c33968023 powerpc/head_check: use stdout for error messages
date:   2 years, 2 months ago
config: powerpc64-buildonly-randconfig-r003-20211118 (https://download.01.org/0day-ci/archive/20231007/202310070419.BcA2fDgk-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310070419.BcA2fDgk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310070419.BcA2fDgk-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ERROR: start_text address is c000000000000900, should be c000000000000200
   ERROR: try to enable LD_HEAD_STUB_CATCH config option
   ERROR: see comments in arch/powerpc/tools/head_check.sh

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
