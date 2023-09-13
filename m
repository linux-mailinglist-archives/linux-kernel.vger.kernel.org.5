Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E847679DFC9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 08:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbjIMGPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 02:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjIMGPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 02:15:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80E21730
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 23:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694585714; x=1726121714;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hZ/M8E+ZHwfsIOF+Fry8Kt1u42TV4X2c2fSobBSkMD8=;
  b=ca64iWwp8yO75zyzOFM31T3zpf+FrtRTeMhcSZcB89oMqs/8cqBVR+79
   WeoDWJbtM73QNO5jlaUl+Zt7qJjG7BkSjeL+W2mMjsbP7uSJ3bC+911Q9
   h0rRF1l4YzZ8kKkxpN1+vU52SeeuFcbFIB7Vlog3PaALkUr6lTjjtFKBr
   DNUt+o6XJYf3F5aUolPsos2AZpAe2A90r/HxgCMPy23cbuenEnd8HaAY3
   QANOJcrIpsTtXb0Fbslf7oEWcFqocmOSGv9ryNr3QW+IUe5LAN+3jvBI0
   QtYKFtAyZn8mV+rjgd0JGKBceTWQ/8qj0FS/3rQ1np0IwbMjvBLRn2xaM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368842202"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="368842202"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 23:15:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="859117127"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="859117127"
Received: from lkp-server02.sh.intel.com (HELO cf13c67269a2) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 12 Sep 2023 23:15:12 -0700
Received: from kbuild by cf13c67269a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgJ7S-00007l-0M;
        Wed, 13 Sep 2023 06:13:25 +0000
Date:   Wed, 13 Sep 2023 14:12:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: /tmp/ccB3TqZP.s:15: Error: unrecognized opcode: `wrtee'
Message-ID: <202309131416.qCTju9Td-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3669558bdf354cd352be955ef2764cde6a9bf5ec
commit: f5df87b855fd835ff0f4928575adbf4f5302bb40 powerpc/build: Remove -pipe from compilation flags
date:   3 months ago
config: powerpc-buildonly-randconfig-r006-20220531 (https://download.01.org/0day-ci/archive/20230913/202309131416.qCTju9Td-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309131416.qCTju9Td-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309131416.qCTju9Td-lkp@intel.com/

All errors (new ones prefixed by >>):

   /tmp/ccB3TqZP.s: Assembler messages:
>> /tmp/ccB3TqZP.s:15: Error: unrecognized opcode: `wrtee'
   /tmp/ccB3TqZP.s:64: Error: unrecognized opcode: `wrteei'
--
   /tmp/ccFA32eu.s: Assembler messages:
   /tmp/ccFA32eu.s:240: Error: unrecognized opcode: `wrtee'
   /tmp/ccFA32eu.s:304: Error: unrecognized opcode: `wrteei'
   /tmp/ccFA32eu.s:2159: Error: unrecognized opcode: `wrteei'
   /tmp/ccFA32eu.s:3451: Error: unrecognized opcode: `wrteei'
   /tmp/ccFA32eu.s:3710: Error: unrecognized opcode: `wrteei'
   /tmp/ccFA32eu.s:7053: Error: unrecognized opcode: `wrteei'
   /tmp/ccFA32eu.s:7507: Error: unrecognized opcode: `wrteei'
   /tmp/ccFA32eu.s:8171: Error: unrecognized opcode: `wrteei'
>> /tmp/ccFA32eu.s:8582: Error: unrecognized opcode: `mbar'
   /tmp/ccFA32eu.s:12273: Error: unrecognized opcode: `wrteei'
   /tmp/ccFA32eu.s:12607: Error: unrecognized opcode: `wrteei'
   /tmp/ccFA32eu.s:13473: Error: unrecognized opcode: `wrteei'
   /tmp/ccFA32eu.s:13726: Error: unrecognized opcode: `wrteei'
   /tmp/ccFA32eu.s:13965: Error: unrecognized opcode: `wrteei'
--
   /tmp/cczs4OOF.s: Assembler messages:
   /tmp/cczs4OOF.s:2812: Error: unrecognized opcode: `mullhwu'
   /tmp/cczs4OOF.s:2830: Error: unrecognized opcode: `mullhwu'
>> /tmp/cczs4OOF.s:19996: Error: unrecognized opcode: `mullhwu.'
   /tmp/cczs4OOF.s:20170: Error: unrecognized opcode: `mullhwu'
--
   /tmp/ccv20csa.s: Assembler messages:
>> /tmp/ccv20csa.s:24: Error: unrecognized opcode: `mtdcr'
>> /tmp/ccv20csa.s:27: Error: unrecognized opcode: `mfdcr'
   /tmp/ccv20csa.s:74: Error: unrecognized opcode: `mtdcr'
   /tmp/ccv20csa.s:77: Error: unrecognized opcode: `mfdcr'
   /tmp/ccv20csa.s:735: Error: unrecognized opcode: `mfdcr'
   /tmp/ccv20csa.s:742: Error: unrecognized opcode: `mfdcr'
   /tmp/ccv20csa.s:749: Error: unrecognized opcode: `mfdcr'
   /tmp/ccv20csa.s:757: Error: unrecognized opcode: `mfdcr'
   /tmp/ccv20csa.s:764: Error: unrecognized opcode: `mfdcr'
   /tmp/ccv20csa.s:771: Error: unrecognized opcode: `mfdcr'
   /tmp/ccv20csa.s:778: Error: unrecognized opcode: `mfdcr'
   /tmp/ccv20csa.s:786: Error: unrecognized opcode: `mfdcr'
   /tmp/ccv20csa.s:897: Error: unrecognized opcode: `mtdcr'
   /tmp/ccv20csa.s:900: Error: unrecognized opcode: `mfdcr'
   /tmp/ccv20csa.s:903: Error: unrecognized opcode: `mtdcr'
   /tmp/ccv20csa.s:909: Error: unrecognized opcode: `mtdcr'
   /tmp/ccv20csa.s:915: Error: unrecognized opcode: `mtdcr'
   /tmp/ccv20csa.s:918: Error: unrecognized opcode: `mfdcr'
   /tmp/ccv20csa.s:921: Error: unrecognized opcode: `mtdcr'
   /tmp/ccv20csa.s:927: Error: unrecognized opcode: `mtdcr'
--
   /tmp/ccAshUsv.s: Assembler messages:
   /tmp/ccAshUsv.s:299: Error: unrecognized opcode: `iccci'
>> /tmp/ccAshUsv.s:419: Error: unrecognized opcode: `tlbwe'
   /tmp/ccAshUsv.s:420: Error: unrecognized opcode: `tlbwe'
   /tmp/ccAshUsv.s:421: Error: unrecognized opcode: `tlbwe'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
