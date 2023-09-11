Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8103D79A314
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 07:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbjIKF5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 01:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjIKF5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 01:57:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFCC114
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 22:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694411857; x=1725947857;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SQxEif+V9tOruTWUuJxjnaqQkDrZNklixMsFBQblnWU=;
  b=giBtgKE15DCCAxCHVDql/Tpx+JJLXsvTcAqmwsiQgp1edXNK4FoJALZc
   aM6d4pAbJx2RkmKuWewh6A9dyvi0Y9k3mV151kF04I3V/J8CvUWNJ1Vmg
   k1dG7iCXaYCxCagHOXuMeILkvZG+arhBcFrJ6a8xMxJ/fx+nQFyVV+njX
   TjQ4hgRVoq8G8R7D6+VJNB/D9OKETF2pXAERkgvTSHxn1uMT8hg9wkq6+
   IwVG75trFEgKn+y6M6UzglBdJz1WJr+kPOj3TqUtgJtVRSjKYzowoTEN9
   C/PV64dXenkofvuQu3+NcJYCSaQM3LHs/SJ41yCMIDsQsxsTbZTHK3K59
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="375355578"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="375355578"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 22:57:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="858190353"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="858190353"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 10 Sep 2023 22:57:35 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfZvR-0005rI-30;
        Mon, 11 Sep 2023 05:57:33 +0000
Date:   Mon, 11 Sep 2023 13:57:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: ld.lld: error: relocation R_RISCV_LO12_I cannot be used against
 symbol 'riscv_cbom_block_size'; recompile with -fPIC
Message-ID: <202309111311.8tcq3KVc-lkp@intel.com>
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
head:   0bb80ecc33a8fb5a682236443c1e740d5c917d1d
commit: e021ae7f5145d46ab64cb058cbffda31059f37e5 riscv: errata: Add Andes alternative ports
date:   10 days ago
config: riscv-randconfig-r022-20230911 (https://download.01.org/0day-ci/archive/20230911/202309111311.8tcq3KVc-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230911/202309111311.8tcq3KVc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309111311.8tcq3KVc-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: relocation R_RISCV_LO12_I cannot be used against symbol 'riscv_cbom_block_size'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/mm/cacheflush.o)
   >>> referenced by errata.c
   >>>               arch/riscv/errata/andes/errata.o:(andes_errata_patch_func) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
