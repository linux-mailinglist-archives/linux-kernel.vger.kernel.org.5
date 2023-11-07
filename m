Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869A07E4912
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 20:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343656AbjKGTTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 14:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbjKGTTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 14:19:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50304119
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 11:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699384778; x=1730920778;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JaNeliEt2AqY/2cfH8cujaaWomO/quuyZNntHGbuo0I=;
  b=Y4TfbHxJ37Sr0eyDO04+vKBy21cPJQBoKptA1IJNXAMwUMmRb2ilM04j
   E4ujQDWbgPdVqr9RHmNmFUiRqbAZEDJXydsFNl/prSjNjv/bYCgCaRLAh
   oXSvukutGE5kB/mn1YOy7Kk2s+DoSvW3R45YD1PuY0EbSZRPlk85F6bsO
   PnuqGLEWk1kMzHcNbYpIlFsZS+HM8w39BVIW1EOWLwGmqYbSLzlhUWy7d
   RTYnZEfWe/gt7aJNTbv5wYKtpw2/2RHoLthIfo6TUX9cEUaeeUpBiBwjl
   GbFl4e3JiCJz6Omys7ILF1sW+Wyb0m05SL4ipGnZ4B3SUOQ+/rYQUJcBy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="2534784"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="2534784"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 11:19:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="833213817"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="833213817"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Nov 2023 11:19:36 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0Rbq-0007LQ-0i;
        Tue, 07 Nov 2023 19:19:34 +0000
Date:   Wed, 8 Nov 2023 03:18:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Wagner <daniel.wagner@bmw-carit.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michal Marek <mmarek@suse.com>
Subject: arch/powerpc/platforms/embedded6xx/mvme5100.c:140:65: error: passing
 argument 5 of 'early_read_config_dword' from incompatible pointer type
Message-ID: <202311080209.eVnG4LWq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   be3ca57cfb777ad820c6659d52e60bbdd36bf5ff
commit: ea8daa7b97842aab8507b5b5b1e3226cf2d514a6 kbuild: Add option to turn incompatible pointer check into error
date:   8 years ago
config: powerpc-randconfig-c003-20220718 (https://download.01.org/0day-ci/archive/20231108/202311080209.eVnG4LWq-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231108/202311080209.eVnG4LWq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311080209.eVnG4LWq-lkp@intel.com/

All errors (new ones prefixed by >>):

         |         ^~~~~~
   include/linux/dma-mapping.h: In function 'dma_unmap_page':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     145 | #define BUG_ON(condition) do { if (condition) ; } while (0)
         |                                               ^
   include/linux/dma-mapping.h:207:9: note: in expansion of macro 'BUG_ON'
     207 |         BUG_ON(!valid_dma_direction(dir));
         |         ^~~~~~
   include/linux/dma-mapping.h: In function 'dma_sync_single_for_cpu':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     145 | #define BUG_ON(condition) do { if (condition) ; } while (0)
         |                                               ^
   include/linux/dma-mapping.h:219:9: note: in expansion of macro 'BUG_ON'
     219 |         BUG_ON(!valid_dma_direction(dir));
         |         ^~~~~~
   include/linux/dma-mapping.h: In function 'dma_sync_single_for_device':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     145 | #define BUG_ON(condition) do { if (condition) ; } while (0)
         |                                               ^
   include/linux/dma-mapping.h:231:9: note: in expansion of macro 'BUG_ON'
     231 |         BUG_ON(!valid_dma_direction(dir));
         |         ^~~~~~
   include/linux/dma-mapping.h: In function 'dma_sync_single_range_for_cpu':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     145 | #define BUG_ON(condition) do { if (condition) ; } while (0)
         |                                               ^
   include/linux/dma-mapping.h:245:9: note: in expansion of macro 'BUG_ON'
     245 |         BUG_ON(!valid_dma_direction(dir));
         |         ^~~~~~
   include/linux/dma-mapping.h: In function 'dma_sync_single_range_for_device':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     145 | #define BUG_ON(condition) do { if (condition) ; } while (0)
         |                                               ^
   include/linux/dma-mapping.h:259:9: note: in expansion of macro 'BUG_ON'
     259 |         BUG_ON(!valid_dma_direction(dir));
         |         ^~~~~~
   include/linux/dma-mapping.h: In function 'dma_sync_sg_for_cpu':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     145 | #define BUG_ON(condition) do { if (condition) ; } while (0)
         |                                               ^
   include/linux/dma-mapping.h:271:9: note: in expansion of macro 'BUG_ON'
     271 |         BUG_ON(!valid_dma_direction(dir));
         |         ^~~~~~
   include/linux/dma-mapping.h: In function 'dma_sync_sg_for_device':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     145 | #define BUG_ON(condition) do { if (condition) ; } while (0)
         |                                               ^
   include/linux/dma-mapping.h:283:9: note: in expansion of macro 'BUG_ON'
     283 |         BUG_ON(!valid_dma_direction(dir));
         |         ^~~~~~
   include/linux/dma-mapping.h: In function 'dma_mmap_attrs':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     145 | #define BUG_ON(condition) do { if (condition) ; } while (0)
         |                                               ^
   include/linux/dma-mapping.h:325:9: note: in expansion of macro 'BUG_ON'
     325 |         BUG_ON(!ops);
         |         ^~~~~~
   include/linux/dma-mapping.h: In function 'dma_get_sgtable_attrs':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     145 | #define BUG_ON(condition) do { if (condition) ; } while (0)
         |                                               ^
   include/linux/dma-mapping.h:342:9: note: in expansion of macro 'BUG_ON'
     342 |         BUG_ON(!ops);
         |         ^~~~~~
   include/linux/dma-mapping.h: In function 'dma_alloc_attrs':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     145 | #define BUG_ON(condition) do { if (condition) ; } while (0)
         |                                               ^
   include/linux/dma-mapping.h:362:9: note: in expansion of macro 'BUG_ON'
     362 |         BUG_ON(!ops);
         |         ^~~~~~
   include/linux/dma-mapping.h: In function 'dma_free_attrs':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     145 | #define BUG_ON(condition) do { if (condition) ; } while (0)
         |                                               ^
   include/linux/dma-mapping.h:383:9: note: in expansion of macro 'BUG_ON'
     383 |         BUG_ON(!ops);
         |         ^~~~~~
   include/linux/seq_file.h: In function 'seq_get_buf':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     145 | #define BUG_ON(condition) do { if (condition) ; } while (0)
         |                                               ^
   include/linux/seq_file.h:70:9: note: in expansion of macro 'BUG_ON'
      70 |         BUG_ON(m->count > m->size);
         |         ^~~~~~
   include/linux/seq_file.h: In function 'seq_commit':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     145 | #define BUG_ON(condition) do { if (condition) ; } while (0)
         |                                               ^
   include/linux/seq_file.h:93:17: note: in expansion of macro 'BUG_ON'
      93 |                 BUG_ON(m->count + num > m->size);
         |                 ^~~~~~
   arch/powerpc/platforms/embedded6xx/mvme5100.c: In function 'mvme5100_pic_init':
   include/asm-generic/bug.h:145:47: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     145 | #define BUG_ON(condition) do { if (condition) ; } while (0)
         |                                               ^
   arch/powerpc/platforms/embedded6xx/mvme5100.c:73:9: note: in expansion of macro 'BUG_ON'
      73 |         BUG_ON(mpic == NULL);
         |         ^~~~~~
   arch/powerpc/platforms/embedded6xx/mvme5100.c: In function 'mvme5100_add_bridge':
>> arch/powerpc/platforms/embedded6xx/mvme5100.c:140:65: error: passing argument 5 of 'early_read_config_dword' from incompatible pointer type [-Werror=incompatible-pointer-types]
     140 |         early_read_config_dword(hose, 0, 0, PCI_BASE_ADDRESS_1, &pci_membase);
         |                                                                 ^~~~~~~~~~~~
         |                                                                 |
         |                                                                 phys_addr_t * {aka long long unsigned int *}
   In file included from arch/powerpc/platforms/embedded6xx/mvme5100.c:23:
   arch/powerpc/include/asm/pci-bridge.h:139:53: note: expected 'u32 *' {aka 'unsigned int *'} but argument is of type 'phys_addr_t *' {aka 'long long unsigned int *'}
     139 |                         int dev_fn, int where, u32 *val);
         |                                                ~~~~~^~~
   In file included from include/linux/printk.h:6,
                    from include/linux/kernel.h:13,
                    from include/linux/list.h:8,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:17,
                    from include/linux/of_platform.h:14,
                    from arch/powerpc/platforms/embedded6xx/mvme5100.c:20:
   include/linux/kern_levels.h:4:25: warning: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'phys_addr_t' {aka 'long long unsigned int'} [-Wformat=]
       4 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/kern_levels.h:13:25: note: in expansion of macro 'KERN_SOH'
      13 | #define KERN_INFO       KERN_SOH "6"    /* informational */
         |                         ^~~~~~~~
   include/linux/printk.h:259:16: note: in expansion of macro 'KERN_INFO'
     259 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~
   arch/powerpc/platforms/embedded6xx/mvme5100.c:147:9: note: in expansion of macro 'pr_info'
     147 |         pr_info("mvme5100_pic_init: pci_membase: %x\n", pci_membase);
         |         ^~~~~~~
   cc1: some warnings being treated as errors


vim +/early_read_config_dword +140 arch/powerpc/platforms/embedded6xx/mvme5100.c

be2019816e4dcd Stephen Chivers 2014-01-09  110  
be2019816e4dcd Stephen Chivers 2014-01-09  111  static int __init mvme5100_add_bridge(struct device_node *dev)
be2019816e4dcd Stephen Chivers 2014-01-09  112  {
be2019816e4dcd Stephen Chivers 2014-01-09  113  	const int		*bus_range;
be2019816e4dcd Stephen Chivers 2014-01-09  114  	int			len;
be2019816e4dcd Stephen Chivers 2014-01-09  115  	struct pci_controller	*hose;
be2019816e4dcd Stephen Chivers 2014-01-09  116  	unsigned short		devid;
be2019816e4dcd Stephen Chivers 2014-01-09  117  
be2019816e4dcd Stephen Chivers 2014-01-09  118  	pr_info("Adding PCI host bridge %s\n", dev->full_name);
be2019816e4dcd Stephen Chivers 2014-01-09  119  
be2019816e4dcd Stephen Chivers 2014-01-09  120  	bus_range = of_get_property(dev, "bus-range", &len);
be2019816e4dcd Stephen Chivers 2014-01-09  121  
be2019816e4dcd Stephen Chivers 2014-01-09  122  	hose = pcibios_alloc_controller(dev);
be2019816e4dcd Stephen Chivers 2014-01-09  123  	if (hose == NULL)
be2019816e4dcd Stephen Chivers 2014-01-09  124  		return -ENOMEM;
be2019816e4dcd Stephen Chivers 2014-01-09  125  
be2019816e4dcd Stephen Chivers 2014-01-09  126  	hose->first_busno = bus_range ? bus_range[0] : 0;
be2019816e4dcd Stephen Chivers 2014-01-09  127  	hose->last_busno = bus_range ? bus_range[1] : 0xff;
be2019816e4dcd Stephen Chivers 2014-01-09  128  
be2019816e4dcd Stephen Chivers 2014-01-09  129  	setup_indirect_pci(hose, 0xfe000cf8, 0xfe000cfc, 0);
be2019816e4dcd Stephen Chivers 2014-01-09  130  
be2019816e4dcd Stephen Chivers 2014-01-09  131  	pci_process_bridge_OF_ranges(hose, dev, 1);
be2019816e4dcd Stephen Chivers 2014-01-09  132  
be2019816e4dcd Stephen Chivers 2014-01-09  133  	early_read_config_word(hose, 0, 0, PCI_DEVICE_ID, &devid);
be2019816e4dcd Stephen Chivers 2014-01-09  134  
be2019816e4dcd Stephen Chivers 2014-01-09  135  	if (devid != PCI_DEVICE_ID_MOTOROLA_HAWK) {
be2019816e4dcd Stephen Chivers 2014-01-09  136  		pr_err("HAWK PHB not present?\n");
be2019816e4dcd Stephen Chivers 2014-01-09  137  		return 0;
be2019816e4dcd Stephen Chivers 2014-01-09  138  	}
be2019816e4dcd Stephen Chivers 2014-01-09  139  
be2019816e4dcd Stephen Chivers 2014-01-09 @140  	early_read_config_dword(hose, 0, 0, PCI_BASE_ADDRESS_1, &pci_membase);
be2019816e4dcd Stephen Chivers 2014-01-09  141  
be2019816e4dcd Stephen Chivers 2014-01-09  142  	if (pci_membase == 0) {
be2019816e4dcd Stephen Chivers 2014-01-09  143  		pr_err("HAWK PHB mibar not correctly set?\n");
be2019816e4dcd Stephen Chivers 2014-01-09  144  		return 0;
be2019816e4dcd Stephen Chivers 2014-01-09  145  	}
be2019816e4dcd Stephen Chivers 2014-01-09  146  
be2019816e4dcd Stephen Chivers 2014-01-09  147  	pr_info("mvme5100_pic_init: pci_membase: %x\n", pci_membase);
be2019816e4dcd Stephen Chivers 2014-01-09  148  
be2019816e4dcd Stephen Chivers 2014-01-09  149  	return 0;
be2019816e4dcd Stephen Chivers 2014-01-09  150  }
be2019816e4dcd Stephen Chivers 2014-01-09  151  

:::::: The code at line 140 was first introduced by commit
:::::: be2019816e4dcdb02493da332b65a8b68b70106c powerpc/embedded6xx: Add support for Motorola/Emerson MVME5100

:::::: TO: Stephen Chivers <schivers@mandarin.aust.csc.com>
:::::: CC: Scott Wood <scottwood@freescale.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
