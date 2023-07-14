Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7FC7531CF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbjGNGN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbjGNGN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:13:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D932D43
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689315206; x=1720851206;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ko0RPclQPZ7JAE9trAcszeFMAN4jsO6NXD+M9MAfuYA=;
  b=lxoKX9gmcIPRsatXFjbHtzV1pA80QX242tcNeCr3ssa/URQx0XW3uM2E
   UvkDxFKodxrNUFbpJYJtUp4utEyOK0PTROKVfbWMah0Z23BYTUwYrjJkD
   BpwizJwUM0qRrIslNHZeJ6IhXhqCKB3oWxT3NdIqrL/RIs0MGrt6xQjQ1
   W5y5MirY0wfi38aunMZMYVaASt1hO7Dg8z7w305WZFArIrOXd9bev/H62
   8YHyW+knXlL6IAkUeUSulNCM+3zxmRdQiXS+zDitkPneK/kb4wsBjYJgr
   hLU699TURHqVbLLxQyZA3hH+XpoUI8o22dGeekIrZrE9ApNgvfZnaXu/X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="362864959"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="362864959"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 23:13:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="896296367"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="896296367"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Jul 2023 23:13:24 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qKC3P-0007EB-0x;
        Fri, 14 Jul 2023 06:13:23 +0000
Date:   Fri, 14 Jul 2023 14:12:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Subject: hostaudio_kern.c:undefined reference to `unregister_sound_mixer'
Message-ID: <202307141416.vxuRVpFv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4b810bf037e524b54669acbe4e0df54b15d87ea1
commit: 8c6174503c7b7134c22072b45f92724c8a959f06 um: hostfs: define our own API boundary
date:   3 months ago
config: um-randconfig-r015-20230714 (https://download.01.org/0day-ci/archive/20230714/202307141416.vxuRVpFv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230714/202307141416.vxuRVpFv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307141416.vxuRVpFv-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: arch/um/drivers/hostaudio_kern.o: in function `hostaudio_cleanup_module':
>> hostaudio_kern.c:(.exit.text+0xa): undefined reference to `unregister_sound_mixer'
>> /usr/bin/ld: hostaudio_kern.c:(.exit.text+0x15): undefined reference to `unregister_sound_dsp'
   /usr/bin/ld: arch/um/drivers/hostaudio_kern.o: in function `hostaudio_init_module':
>> hostaudio_kern.c:(.init.text+0x19): undefined reference to `register_sound_dsp'
>> /usr/bin/ld: hostaudio_kern.c:(.init.text+0x31): undefined reference to `register_sound_mixer'
>> /usr/bin/ld: hostaudio_kern.c:(.init.text+0x49): undefined reference to `unregister_sound_dsp'
   collect2: error: ld returned 1 exit status

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
