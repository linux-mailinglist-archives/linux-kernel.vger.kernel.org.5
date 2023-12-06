Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA3E806E3D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377744AbjLFLmv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 06:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377700AbjLFLmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:42:50 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D268F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:42:55 -0800 (PST)
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Slb531M4hzShvp;
        Wed,  6 Dec 2023 19:38:31 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemi500023.china.huawei.com (7.221.188.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 19:42:52 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.035;
 Wed, 6 Dec 2023 19:42:52 +0800
From:   "Gonglei (Arei)" <arei.gonglei@huawei.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        kernel test robot <lkp@intel.com>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: drivers/crypto/virtio/virtio_crypto_common.h:116:13: warning:
 variable 'cpu' set but not used
Thread-Topic: drivers/crypto/virtio/virtio_crypto_common.h:116:13: warning:
 variable 'cpu' set but not used
Thread-Index: AQHaJiLRicCCC7Kd2kaW9jApNQwiILCXe7+AgASpWRA=
Date:   Wed, 6 Dec 2023 11:42:52 +0000
Message-ID: <3befffb631604bc4bf7fcb67970736df@huawei.com>
References: <202312040315.kPrI1OCE-lkp@intel.com>
 <20231203152646-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231203152646-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.11]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Monday, December 4, 2023 4:27 AM
> To: kernel test robot <lkp@intel.com>
> Cc: Gonglei (Arei) <arei.gonglei@huawei.com>; oe-kbuild-all@lists.linux.dev;
> linux-kernel@vger.kernel.org
> Subject: Re: drivers/crypto/virtio/virtio_crypto_common.h:116:13: warning:
> variable 'cpu' set but not used
> 
> On Mon, Dec 04, 2023 at 03:55:43AM +0800, kernel test robot wrote:
> > Hi Gonglei,
> >
> > FYI, the error/warning still remains.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> master
> > head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
> > commit: dbaf0624ffa57ae6e7d87a823185ccd9a7852d3c crypto: add
> virtio-crypto driver
> > date:   7 years ago
> > config: x86_64-randconfig-015-20231011
> > (https://download.01.org/0day-ci/archive/20231204/202312040315.kPrI1OC
> > E-lkp@intel.com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0 reproduce (this is a W=1
> > build):
> > (https://download.01.org/0day-ci/archive/20231204/202312040315.kPrI1OC
> > E-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new
> > version of the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes:
> > | https://lore.kernel.org/oe-kbuild-all/202312040315.kPrI1OCE-lkp@inte
> > | l.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >    In file included from drivers/crypto/virtio/virtio_crypto_algs.c:28:
> >    drivers/crypto/virtio/virtio_crypto_common.h: In function
> 'virtio_crypto_get_current_node':
> > >> drivers/crypto/virtio/virtio_crypto_common.h:116:13: warning:
> > >> variable 'cpu' set but not used [-Wunused-but-set-variable]
> >      116 |         int cpu, node;
> >          |             ^~~
> > --
> >    In file included from drivers/crypto/virtio/virtio_crypto_core.c:25:
> >    drivers/crypto/virtio/virtio_crypto_common.h: In function
> 'virtio_crypto_get_current_node':
> > >> drivers/crypto/virtio/virtio_crypto_common.h:116:13: warning:
> > >> variable 'cpu' set but not used [-Wunused-but-set-variable]
> >      116 |         int cpu, node;
> >          |             ^~~

The warning occurs when CONFIG_SMG is not set. Will fix it later.


> >    In file included from drivers/crypto/virtio/virtio_crypto_core.c:20:
> >    drivers/crypto/virtio/virtio_crypto_core.c: At top level:
> >    include/linux/module.h:132:13: warning: 'init_module' specifies less
> restrictive attribute than its target 'virtio_crypto_driver_init': 'cold'
> [-Wmissing-attributes]
> >      132 |         int init_module(void) __attribute__((alias(#initfn)));
> >          |             ^~~~~~~~~~~
> >    include/linux/device.h:1463:1: note: in expansion of macro 'module_init'
> >     1463 | module_init(__driver##_init); \
> >          | ^~~~~~~~~~~
> >    include/linux/virtio.h:190:9: note: in expansion of macro 'module_driver'
> >      190 |         module_driver(__virtio_driver, register_virtio_driver, \
> >          |         ^~~~~~~~~~~~~
> >    drivers/crypto/virtio/virtio_crypto_core.c:471:1: note: in expansion of
> macro 'module_virtio_driver'
> >      471 | module_virtio_driver(virtio_crypto_driver);
> >          | ^~~~~~~~~~~~~~~~~~~~
> >    In file included from include/linux/virtio.h:8,
> >                     from include/linux/virtio_config.h:6,
> >                     from drivers/crypto/virtio/virtio_crypto_core.c:21:
> >    drivers/crypto/virtio/virtio_crypto_core.c:471:22: note: 'init_module'
> target declared here
> >      471 | module_virtio_driver(virtio_crypto_driver);
> >          |                      ^~~~~~~~~~~~~~~~~~~~
> >    include/linux/device.h:1459:19: note: in definition of macro
> 'module_driver'
> >     1459 | static int __init __driver##_init(void) \
> >          |                   ^~~~~~~~
> >    drivers/crypto/virtio/virtio_crypto_core.c:471:1: note: in expansion of
> macro 'module_virtio_driver'
> >      471 | module_virtio_driver(virtio_crypto_driver);
> >          | ^~~~~~~~~~~~~~~~~~~~
> >    include/linux/module.h:138:14: warning: 'cleanup_module' specifies less
> restrictive attribute than its target 'virtio_crypto_driver_exit': 'cold'
> [-Wmissing-attributes]
> >      138 |         void cleanup_module(void)
> __attribute__((alias(#exitfn)));
> >          |              ^~~~~~~~~~~~~~
> >    include/linux/device.h:1468:1: note: in expansion of macro 'module_exit'
> >     1468 | module_exit(__driver##_exit);
> >          | ^~~~~~~~~~~
> >    include/linux/virtio.h:190:9: note: in expansion of macro 'module_driver'
> >      190 |         module_driver(__virtio_driver, register_virtio_driver, \
> >          |         ^~~~~~~~~~~~~
> >    drivers/crypto/virtio/virtio_crypto_core.c:471:1: note: in expansion of
> macro 'module_virtio_driver'
> >      471 | module_virtio_driver(virtio_crypto_driver);
> >          | ^~~~~~~~~~~~~~~~~~~~
> >    drivers/crypto/virtio/virtio_crypto_core.c:471:22: note:
> 'cleanup_module' target declared here
> >      471 | module_virtio_driver(virtio_crypto_driver);
> >          |                      ^~~~~~~~~~~~~~~~~~~~
> >    include/linux/device.h:1464:20: note: in definition of macro
> 'module_driver'
> >     1464 | static void __exit __driver##_exit(void) \
> >          |                    ^~~~~~~~
> >    drivers/crypto/virtio/virtio_crypto_core.c:471:1: note: in expansion of
> macro 'module_virtio_driver'
> >      471 | module_virtio_driver(virtio_crypto_driver);
> >          | ^~~~~~~~~~~~~~~~~~~~
> >
Actually those warnings were fixed by upstream commit a6e60d84989.

> >
> > vim +/cpu +116 drivers/crypto/virtio/virtio_crypto_common.h
> >
> >    113
> >    114	static inline int virtio_crypto_get_current_node(void)
> >    115	{
> >  > 116		int cpu, node;
> >    117
> >    118		cpu = get_cpu();
> >    119		node = topology_physical_package_id(cpu);
> >    120		put_cpu();
> >    121
> >    122		return node;
> >    123	}
> >    124
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 
> Seems easy to fix. Gonglei?
> 

Regards,
-Gonglei

