Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFAF7AC513
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 22:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjIWUk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 16:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIWUk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 16:40:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DD211B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 13:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695501652; x=1727037652;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mb5FSK1xmqe1l193NGIGELewrGYBbw6yRlcpW8XB6Fo=;
  b=YdBskufVIRiVtW7r+aIonZ4F7Ti5JmVpfmA1wohGoRL7sbxeWCMUXWFU
   hwHFRiJYRjjCY5/w9QAVXZCGQ8dY07snbMz+DcP7JdnTWIMKqXJ7Spxhc
   rI73W5MOY6KxZuP4M9stl93b4TjSUwhuN3rUExfhfUddgqNe+VeEk31Fs
   YS9fyDqcpbR4AQ+2X7zskFW+H9DNMatzdj9mZHwl+0LsU3Voc5BojgGwY
   K7LcnV69Y8yxtbcRv6ZoGG4GAUUTKGgpj6u3klGSkodBZT2emXRwEBVbq
   QT5AJOXTQrHkm4nY9MtjreOxFJLtAGfzZKBuV8ZV1+XCCSMg15v03e8C0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="366114558"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="366114558"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2023 13:40:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="747927119"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="747927119"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 23 Sep 2023 13:40:49 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qk9Ql-0002pd-1Z;
        Sat, 23 Sep 2023 20:40:47 +0000
Date:   Sun, 24 Sep 2023 04:40:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: [tip:sched/core 4/32] riscv64-linux-ld: warning: orphan section
 `.bss..Lubsan_data645' from `kernel/sched/core.o' being placed in section
 `.bss..Lubsan_data645'
Message-ID: <202309240437.vIiE0grd-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
head:   dc461c48deda8a2d243fbaf49e276d555eb833d8
commit: 7a50f76674f8b6f4f30a1cec954179f10e20110c [4/32] sched: Simplify yield_to()
config: riscv-randconfig-002-20230923 (https://download.01.org/0day-ci/archive/20230924/202309240437.vIiE0grd-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230924/202309240437.vIiE0grd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309240437.vIiE0grd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> riscv64-linux-ld: warning: orphan section `.bss..Lubsan_data645' from `kernel/sched/core.o' being placed in section `.bss..Lubsan_data645'
>> riscv64-linux-ld: warning: orphan section `.bss..Lubsan_data645' from `kernel/sched/core.o' being placed in section `.bss..Lubsan_data645'
>> riscv64-linux-ld: warning: orphan section `.bss..Lubsan_data645' from `kernel/sched/core.o' being placed in section `.bss..Lubsan_data645'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
