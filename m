Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16732790A53
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 02:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbjICAAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 20:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjICAAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 20:00:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02B3CDB
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 17:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693699237; x=1725235237;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WDnw4cEC1+2HHlRpfQnLW2wiczBIUozhnh6GWXeZQaU=;
  b=MyvAaDb7RxyLheQpf6hPomX0SAFUizJEw4BdNy0hxCVh8SDZiJJ72NnL
   FXAYQS+fTYi7MhgL2FIpRWZXh+M1nGC8YI29IrbeXj9M3q+Y52QNhQpdA
   FccrZl5EjRQbLlWhvJH9gYvxJn/5FpaK2qqPMTAf7/TzxuPAILLyNvqNA
   /mGEBbXOAO5PwMFaoXKWF42SsHsxROUYfpKHHFJVCQNl0D08WBCe82xWi
   tPThdMeSa8Pi81/KoVmS6HWyhRe8yVNLrIs0aCSdYb9wc4bBmGzVfnfYe
   43hWu+VvCtbRpWzPsSrRBYIGGIl2qMit4f2YKug1FXD8lNr2+zKycCiEm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="376340465"
X-IronPort-AV: E=Sophos;i="6.02,223,1688454000"; 
   d="scan'208";a="376340465"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 17:00:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="830514387"
X-IronPort-AV: E=Sophos;i="6.02,223,1688454000"; 
   d="scan'208";a="830514387"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Sep 2023 17:00:35 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qcaXZ-0002hp-0c;
        Sun, 03 Sep 2023 00:00:33 +0000
Date:   Sun, 3 Sep 2023 07:59:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Liu Yun <liuyun@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
Subject: loongson2_pm.c:undefined reference to `input_allocate_device'
Message-ID: <202309030723.tbXa6lNB-lkp@intel.com>
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
head:   92901222f83d988617aee37680cb29e1a743b5e4
commit: 67694c076bd7d6b8b73c59d4881822f0493caf35 soc: loongson2_pm: add power management support
date:   12 days ago
config: loongarch-randconfig-r004-20230903 (https://download.01.org/0day-ci/archive/20230903/202309030723.tbXa6lNB-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230903/202309030723.tbXa6lNB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309030723.tbXa6lNB-lkp@intel.com/

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: drivers/soc/loongson/loongson2_pm.o: in function `.L7':
>> loongson2_pm.c:(.text+0x9c): undefined reference to `input_allocate_device'
>> loongarch64-linux-ld: loongson2_pm.c:(.text+0xd4): undefined reference to `input_set_capability'
>> loongarch64-linux-ld: loongson2_pm.c:(.text+0xdc): undefined reference to `input_register_device'
>> loongarch64-linux-ld: loongson2_pm.c:(.text+0xe8): undefined reference to `input_free_device'
   loongarch64-linux-ld: drivers/soc/loongson/loongson2_pm.o: in function `.L47':
>> loongson2_pm.c:(.text+0x2bc): undefined reference to `input_event'
>> loongarch64-linux-ld: loongson2_pm.c:(.text+0x2d0): undefined reference to `input_event'
   loongarch64-linux-ld: loongson2_pm.c:(.text+0x2e4): undefined reference to `input_event'
   loongarch64-linux-ld: loongson2_pm.c:(.text+0x2f8): undefined reference to `input_event'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
