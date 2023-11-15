Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D130C7EC0D2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjKOKhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 05:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjKOKhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 05:37:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D594A10F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 02:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700044653; x=1731580653;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pASj3ynWAqrCC1Zge9+9eZpkrLPAlWqt+3s/Z4yMYFw=;
  b=mh15Om+K1yJc3c1lSkkQ1z3Wbj0/tC3407wyWJXTFw5ursPEEH92CBYO
   PbAo3xY+KTEjdZfsOK+c7luNb0WhWfJC2FGV8qtkCGmtxrgN/uKPCscim
   iydlV56cm2X8YqbcfN7HVjlpCIw4YqUXPvE9MygOkl4uP8WkNYISZOTTF
   Rm0bPti8c0rpDp4TmxwZvnYJmBuDb9vT1GNqyWzztZHlmz39BKibSKQyX
   FcySk/+Nx9eY4+fPlScJoHVPT1QqjH6sT0hXRqTwAkRIm2jmGBN/WkUE1
   WpBJib+86gaxVBg+pibKgWmu6QopQ5j8yC0VzZnbcFwne2MIhSGOJHbW2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="477074235"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="477074235"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 02:37:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="830915908"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="830915908"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 15 Nov 2023 02:37:32 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3DGv-0000Fc-0R;
        Wed, 15 Nov 2023 10:37:26 +0000
Date:   Wed, 15 Nov 2023 18:36:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: /tmp/ccDME0uz.s:1274: Error: unrecognized opcode: `ldbrx'
Message-ID: <202311151805.cYO3x9wy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicholas,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: f5df87b855fd835ff0f4928575adbf4f5302bb40 powerpc/build: Remove -pipe from compilation flags
date:   5 months ago
config: powerpc-cell_defconfig (https://download.01.org/0day-ci/archive/20231115/202311151805.cYO3x9wy-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231115/202311151805.cYO3x9wy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311151805.cYO3x9wy-lkp@intel.com/

All errors (new ones prefixed by >>):

   /tmp/ccDME0uz.s: Assembler messages:
>> /tmp/ccDME0uz.s:1274: Error: unrecognized opcode: `ldbrx'
   /tmp/ccDME0uz.s:1276: Error: unrecognized opcode: `ldbrx'
   /tmp/ccDME0uz.s:1278: Error: unrecognized opcode: `ldbrx'
   /tmp/ccDME0uz.s:1279: Error: unrecognized opcode: `ldbrx'
   /tmp/ccDME0uz.s:2033: Error: unrecognized opcode: `ldbrx'
   /tmp/ccDME0uz.s:2039: Error: unrecognized opcode: `ldbrx'
   /tmp/ccDME0uz.s:2040: Error: unrecognized opcode: `ldbrx'
   /tmp/ccDME0uz.s:7758: Error: unrecognized opcode: `ldbrx'
   /tmp/ccDME0uz.s:8366: Error: unrecognized opcode: `ldbrx'
   /tmp/ccDME0uz.s:8493: Error: unrecognized opcode: `ldbrx'
   /tmp/ccDME0uz.s:8495: Error: unrecognized opcode: `ldbrx'
   /tmp/ccDME0uz.s:8502: Error: unrecognized opcode: `ldbrx'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
