Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D55E802728
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 21:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjLCT4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjLCT4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:56:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB26AC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 11:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701633371; x=1733169371;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LLiMihWBSxYsTzFwA3YUPrrN2+U6rxXIZyC76OTyR+U=;
  b=SEonUW+pS/+ScCadzD2ANkJSizvMXwskr16sJjZYWBhytAd3E1gAxBi1
   VCtDxvRZ0tj74sqnCiWfDAZYu+t+y4u4G4i5czNH+hIDdgIQUovTuIGTN
   bbMdUyFimGMfWxaEOLevOJm2PhFdvvU4iLQEg0sZ+W1LrIz/Q4CvGDmdx
   9fAppZCRe7TlWkomLXL57AlZaRUedyAz48bR/f+++ZajvlMaB7RooUULd
   MeUVin8nMDQw3NbEFrwAYqvPXFxVIqouvLJ0HkAGPkwXWWrRDrWEd3h34
   VzkXoTmmrtzEYNCgM3riGqQOhbh6lPEg+D5sNHQUc9nx1FnjIcP2Xi/Gc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="373090506"
X-IronPort-AV: E=Sophos;i="6.04,248,1695711600"; 
   d="scan'208";a="373090506"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 11:56:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="746605022"
X-IronPort-AV: E=Sophos;i="6.04,248,1695711600"; 
   d="scan'208";a="746605022"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 03 Dec 2023 11:56:09 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9sZT-00072U-07;
        Sun, 03 Dec 2023 19:56:07 +0000
Date:   Mon, 4 Dec 2023 03:55:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gonglei <arei.gonglei@huawei.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: drivers/crypto/virtio/virtio_crypto_common.h:116:13: warning:
 variable 'cpu' set but not used
Message-ID: <202312040315.kPrI1OCE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gonglei,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: dbaf0624ffa57ae6e7d87a823185ccd9a7852d3c crypto: add virtio-crypto driver
date:   7 years ago
config: x86_64-randconfig-015-20231011 (https://download.01.org/0day-ci/archive/20231204/202312040315.kPrI1OCE-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231204/202312040315.kPrI1OCE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312040315.kPrI1OCE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/crypto/virtio/virtio_crypto_algs.c:28:
   drivers/crypto/virtio/virtio_crypto_common.h: In function 'virtio_crypto_get_current_node':
>> drivers/crypto/virtio/virtio_crypto_common.h:116:13: warning: variable 'cpu' set but not used [-Wunused-but-set-variable]
     116 |         int cpu, node;
         |             ^~~
--
   In file included from drivers/crypto/virtio/virtio_crypto_core.c:25:
   drivers/crypto/virtio/virtio_crypto_common.h: In function 'virtio_crypto_get_current_node':
>> drivers/crypto/virtio/virtio_crypto_common.h:116:13: warning: variable 'cpu' set but not used [-Wunused-but-set-variable]
     116 |         int cpu, node;
         |             ^~~
   In file included from drivers/crypto/virtio/virtio_crypto_core.c:20:
   drivers/crypto/virtio/virtio_crypto_core.c: At top level:
   include/linux/module.h:132:13: warning: 'init_module' specifies less restrictive attribute than its target 'virtio_crypto_driver_init': 'cold' [-Wmissing-attributes]
     132 |         int init_module(void) __attribute__((alias(#initfn)));
         |             ^~~~~~~~~~~
   include/linux/device.h:1463:1: note: in expansion of macro 'module_init'
    1463 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/virtio.h:190:9: note: in expansion of macro 'module_driver'
     190 |         module_driver(__virtio_driver, register_virtio_driver, \
         |         ^~~~~~~~~~~~~
   drivers/crypto/virtio/virtio_crypto_core.c:471:1: note: in expansion of macro 'module_virtio_driver'
     471 | module_virtio_driver(virtio_crypto_driver);
         | ^~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/virtio.h:8,
                    from include/linux/virtio_config.h:6,
                    from drivers/crypto/virtio/virtio_crypto_core.c:21:
   drivers/crypto/virtio/virtio_crypto_core.c:471:22: note: 'init_module' target declared here
     471 | module_virtio_driver(virtio_crypto_driver);
         |                      ^~~~~~~~~~~~~~~~~~~~
   include/linux/device.h:1459:19: note: in definition of macro 'module_driver'
    1459 | static int __init __driver##_init(void) \
         |                   ^~~~~~~~
   drivers/crypto/virtio/virtio_crypto_core.c:471:1: note: in expansion of macro 'module_virtio_driver'
     471 | module_virtio_driver(virtio_crypto_driver);
         | ^~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:138:14: warning: 'cleanup_module' specifies less restrictive attribute than its target 'virtio_crypto_driver_exit': 'cold' [-Wmissing-attributes]
     138 |         void cleanup_module(void) __attribute__((alias(#exitfn)));
         |              ^~~~~~~~~~~~~~
   include/linux/device.h:1468:1: note: in expansion of macro 'module_exit'
    1468 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/virtio.h:190:9: note: in expansion of macro 'module_driver'
     190 |         module_driver(__virtio_driver, register_virtio_driver, \
         |         ^~~~~~~~~~~~~
   drivers/crypto/virtio/virtio_crypto_core.c:471:1: note: in expansion of macro 'module_virtio_driver'
     471 | module_virtio_driver(virtio_crypto_driver);
         | ^~~~~~~~~~~~~~~~~~~~
   drivers/crypto/virtio/virtio_crypto_core.c:471:22: note: 'cleanup_module' target declared here
     471 | module_virtio_driver(virtio_crypto_driver);
         |                      ^~~~~~~~~~~~~~~~~~~~
   include/linux/device.h:1464:20: note: in definition of macro 'module_driver'
    1464 | static void __exit __driver##_exit(void) \
         |                    ^~~~~~~~
   drivers/crypto/virtio/virtio_crypto_core.c:471:1: note: in expansion of macro 'module_virtio_driver'
     471 | module_virtio_driver(virtio_crypto_driver);
         | ^~~~~~~~~~~~~~~~~~~~


vim +/cpu +116 drivers/crypto/virtio/virtio_crypto_common.h

   113	
   114	static inline int virtio_crypto_get_current_node(void)
   115	{
 > 116		int cpu, node;
   117	
   118		cpu = get_cpu();
   119		node = topology_physical_package_id(cpu);
   120		put_cpu();
   121	
   122		return node;
   123	}
   124	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
