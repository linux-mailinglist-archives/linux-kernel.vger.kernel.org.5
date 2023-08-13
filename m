Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD67077A506
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 07:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjHMFAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 01:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHMFAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 01:00:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F108E53
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 22:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691902834; x=1723438834;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=znG49ausf4ed4XZ/u/R8iD+3wID1AzSoacKO7qK8rjQ=;
  b=XfuQ6RObZZvFpBiWhQ01hsAFTB0d/eY77VqoIDXUjbdgtfahsnrQ6pUR
   7cFc7MQ5tJdmJ82BD7e851+DJ5zW26jqdhUoPKWRQfHulfIJh0rpRWBbF
   mYwSMloZE2vph9Fq/5lEbQ5JHS1kB0lQ813D/SzRNZTYHWN7Ry38I0AAM
   buS0+oBr811cR3KARataU3mcQOu+vJvXD/WpURlUPNXYE7w+JbaaGI7Mn
   23wdqpWPZP5l3UBzHzBFuJFloSqrU0s4MwXFx6jJAfL/FTfsDtGldaQb6
   XVx7Q75x4zlgwVV/8LEHfcXqa23ibkRLxqQ8jmuhVKyoq3XszIKf9jCD2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10800"; a="371876763"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="371876763"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2023 22:00:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10800"; a="803072664"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="803072664"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 12 Aug 2023 22:00:32 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qV3DL-0008xe-0i;
        Sun, 13 Aug 2023 05:00:31 +0000
Date:   Sun, 13 Aug 2023 13:00:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Foley <pefoley2@pefoley.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: arch/um/drivers/pcap_kern.c:18:6: warning: no previous prototype for
 function 'pcap_init_kern'
Message-ID: <202308131223.OGxMwcd4-lkp@intel.com>
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

Hi Peter,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a785fd28d31f76d50004712b6e0b409d5a8239d8
commit: 2c4d3841a82b88ae8a7b518dc6206f84f68e705a um: Avoid pcap multiple definition errors
date:   6 months ago
config: um-randconfig-r022-20230813 (https://download.01.org/0day-ci/archive/20230813/202308131223.OGxMwcd4-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230813/202308131223.OGxMwcd4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308131223.OGxMwcd4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/um/drivers/pcap_kern.c:7:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from arch/um/drivers/pcap_kern.c:7:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from arch/um/drivers/pcap_kern.c:7:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> arch/um/drivers/pcap_kern.c:18:6: warning: no previous prototype for function 'pcap_init_kern' [-Wmissing-prototypes]
      18 | void pcap_init_kern(struct net_device *dev, void *data)
         |      ^
   arch/um/drivers/pcap_kern.c:18:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      18 | void pcap_init_kern(struct net_device *dev, void *data)
         | ^
         | static 
   arch/um/drivers/pcap_kern.c:53:5: warning: no previous prototype for function 'pcap_setup' [-Wmissing-prototypes]
      53 | int pcap_setup(char *str, char **mac_out, void *data)
         |     ^
   arch/um/drivers/pcap_kern.c:53:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      53 | int pcap_setup(char *str, char **mac_out, void *data)
         | ^
         | static 
   14 warnings generated.


vim +/pcap_init_kern +18 arch/um/drivers/pcap_kern.c

    17	
  > 18	void pcap_init_kern(struct net_device *dev, void *data)
    19	{
    20		struct uml_net_private *pri;
    21		struct pcap_data *ppri;
    22		struct pcap_init *init = data;
    23	
    24		pri = netdev_priv(dev);
    25		ppri = (struct pcap_data *) pri->user;
    26		ppri->host_if = init->host_if;
    27		ppri->promisc = init->promisc;
    28		ppri->optimize = init->optimize;
    29		ppri->filter = init->filter;
    30	
    31		printk("pcap backend, host interface %s\n", ppri->host_if);
    32	}
    33	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
