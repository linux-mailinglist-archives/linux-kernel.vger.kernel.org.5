Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1557E79DBA9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjILWKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjILWKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:10:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C4110D9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 15:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694556648; x=1726092648;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GGcDPjxsiS4/pVHwmvBa/uCpG08nd8mFte69vlODB3U=;
  b=T1ygNOVdp1okNXX3bzuJRGsZ3R9SY+HWd2AKTyJ5qSBTFdTQrIV0MLAI
   7XeIA34m1b9SpSW7J5omZ1ZFYNQfjtDkZxWl3xBqGzAS5qnT6JraiLatg
   iI3GPSAUygkVWenIMJmoUcYtNKXyY3dW0MrUdM7+gP2ziRPLY/NfTzlsC
   93ZXfvRpfVsc/HWaVNIfwjbQSWGC6v+8NBLPtt8QfL3aDe/g92UwmrvO0
   CIftyLp62WFlRC0MSSexZyxIvii7fDPv+F2Vif+p78Fs9OTml9mu81HWX
   F3h3JhX0aq0JCI80OnqPIIgV7gJ0KrsQ+Pw918SjG/zPWtFcmyw74+c6r
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368771329"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="368771329"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 15:10:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="693636376"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="693636376"
Received: from lkp-server02.sh.intel.com (HELO 47e905db7d2b) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 12 Sep 2023 15:10:46 -0700
Received: from kbuild by 47e905db7d2b with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgBam-0000Kq-0W;
        Tue, 12 Sep 2023 22:10:44 +0000
Date:   Wed, 13 Sep 2023 06:10:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: /tmp/cckUcUEH.s:27: Error: unrecognized opcode: `mfpmr'
Message-ID: <202309130611.xqcERDRy-lkp@intel.com>
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
config: powerpc-randconfig-r001-20230709 (https://download.01.org/0day-ci/archive/20230913/202309130611.xqcERDRy-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309130611.xqcERDRy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309130611.xqcERDRy-lkp@intel.com/

All errors (new ones prefixed by >>):

   /tmp/cckUcUEH.s: Assembler messages:
>> /tmp/cckUcUEH.s:27: Error: unrecognized opcode: `mfpmr'
>> /tmp/cckUcUEH.s:33: Error: unrecognized opcode: `mtpmr'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
