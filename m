Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B077E2C9A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjKFTFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjKFTFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:05:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B0DD7E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699297527; x=1730833527;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cT9aHMN4+6UysGWjGZ57CujKqwE3wlCHm0h+LEp1nF8=;
  b=TKoS1+rWx4CuLY/uKHFr4yffhx64sMLjyMlCmel3DN3uoGL8Zao2101T
   Lns+yXj6QnoXztRmjbdBHSck1hM9IeXnHT7UmfIrLdpQO2osiqkweyx6c
   cpli3bEAFDFfJmnoYWHfeTnwLxTr9kg6w625PTBdW3Uh03oHv92VQpJgd
   GNP6UO04N24tx9Jih1hEJ/O9h2nEbomqKw4hfBU96f3z8JP8SdKQQH8Lr
   JM2bqHZP1GX/roCe43d8XIGjJ6bPqLhIm705gLlYFLkcRStpv5sU1fCkq
   E/ZwqTAeVTpGzTH2GmrbAtJqrAHfrsckU1KSY4/2b1S1x813c1McCxDDb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="475587431"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="475587431"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 11:05:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="3548280"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 06 Nov 2023 11:05:25 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r04uY-0006fY-2D;
        Mon, 06 Nov 2023 19:05:22 +0000
Date:   Tue, 7 Nov 2023 03:04:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@ti.com>
Subject: drivers/usb/gadget/udc/renesas_usb3.c:1797:73: warning: '%d'
 directive output may be truncated writing between 1 and 10 bytes into a
 region of size 6
Message-ID: <202311070258.WXmAZXKE-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2f51b3516dade79269ff45eae2a7668ae711b25
commit: 746bfe63bba37ad55956b7377c9af494e7e28929 usb: gadget: renesas_usb3: add support for Renesas USB3.0 peripheral controller
date:   8 years ago
config: x86_64-buildonly-randconfig-006-20230830 (https://download.01.org/0day-ci/archive/20231107/202311070258.WXmAZXKE-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231107/202311070258.WXmAZXKE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311070258.WXmAZXKE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kobject.h:21,
                    from include/linux/module.h:17,
                    from drivers/usb/gadget/udc/renesas_usb3.c:15:
   include/linux/sysfs.h: In function 'sysfs_get_dirent':
   include/linux/sysfs.h:517:44: warning: pointer targets in passing argument 2 of 'kernfs_find_and_get' differ in signedness [-Wpointer-sign]
     517 |         return kernfs_find_and_get(parent, name);
         |                                            ^~~~
         |                                            |
         |                                            const unsigned char *
   In file included from include/linux/sysfs.h:15:
   include/linux/kernfs.h:428:57: note: expected 'const char *' but argument is of type 'const unsigned char *'
     428 | kernfs_find_and_get(struct kernfs_node *kn, const char *name)
         |                                             ~~~~~~~~~~~~^~~~
   drivers/usb/gadget/udc/renesas_usb3.c: In function 'usb3_get_setup_data':
   drivers/usb/gadget/udc/renesas_usb3.c:718:9: warning: converting a packed 'struct usb_ctrlrequest' pointer (alignment 1) to a 'u32' {aka 'unsigned int'} pointer (alignment 4) may result in an unaligned pointer value [-Waddress-of-packed-member]
     718 |         u32 *data = (u32 *)ctrl;
         |         ^~~
   In file included from include/linux/usb/ch9.h:36,
                    from drivers/usb/gadget/udc/renesas_usb3.c:21:
   include/uapi/linux/usb/ch9.h:185:8: note: defined here
     185 | struct usb_ctrlrequest {
         |        ^~~~~~~~~~~~~~~
   drivers/usb/gadget/udc/renesas_usb3.c: At top level:
   include/linux/module.h:136:14: warning: 'cleanup_module' specifies less restrictive attribute than its target 'renesas_usb3_driver_exit': 'cold' [-Wmissing-attributes]
     136 |         void cleanup_module(void) __attribute__((alias(#exitfn)));
         |              ^~~~~~~~~~~~~~
   include/linux/device.h:1334:1: note: in expansion of macro 'module_exit'
    1334 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/platform_device.h:222:9: note: in expansion of macro 'module_driver'
     222 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/usb/gadget/udc/renesas_usb3.c:1970:1: note: in expansion of macro 'module_platform_driver'
    1970 | module_platform_driver(renesas_usb3_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/node.h:17,
                    from include/linux/cpu.h:16,
                    from include/linux/of_device.h:4,
                    from drivers/usb/gadget/udc/renesas_usb3.c:16:
   drivers/usb/gadget/udc/renesas_usb3.c:1970:24: note: 'cleanup_module' target declared here
    1970 | module_platform_driver(renesas_usb3_driver);
         |                        ^~~~~~~~~~~~~~~~~~~
   include/linux/device.h:1330:20: note: in definition of macro 'module_driver'
    1330 | static void __exit __driver##_exit(void) \
         |                    ^~~~~~~~
   drivers/usb/gadget/udc/renesas_usb3.c:1970:1: note: in expansion of macro 'module_platform_driver'
    1970 | module_platform_driver(renesas_usb3_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:130:13: warning: 'init_module' specifies less restrictive attribute than its target 'renesas_usb3_driver_init': 'cold' [-Wmissing-attributes]
     130 |         int init_module(void) __attribute__((alias(#initfn)));
         |             ^~~~~~~~~~~
   include/linux/device.h:1329:1: note: in expansion of macro 'module_init'
    1329 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/platform_device.h:222:9: note: in expansion of macro 'module_driver'
     222 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/usb/gadget/udc/renesas_usb3.c:1970:1: note: in expansion of macro 'module_platform_driver'
    1970 | module_platform_driver(renesas_usb3_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/gadget/udc/renesas_usb3.c:1970:24: note: 'init_module' target declared here
    1970 | module_platform_driver(renesas_usb3_driver);
         |                        ^~~~~~~~~~~~~~~~~~~
   include/linux/device.h:1325:19: note: in definition of macro 'module_driver'
    1325 | static int __init __driver##_init(void) \
         |                   ^~~~~~~~
   drivers/usb/gadget/udc/renesas_usb3.c:1970:1: note: in expansion of macro 'module_platform_driver'
    1970 | module_platform_driver(renesas_usb3_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/gadget/udc/renesas_usb3.c: In function 'renesas_usb3_probe':
>> drivers/usb/gadget/udc/renesas_usb3.c:1797:73: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 6 [-Wformat-truncation=]
    1797 |                 snprintf(usb3_ep->ep_name, sizeof(usb3_ep->ep_name), "ep%d", i);
         |                                                                         ^~
   In function 'renesas_usb3_init_ep',
       inlined from 'renesas_usb3_probe' at drivers/usb/gadget/udc/renesas_usb3.c:1928:8:
   drivers/usb/gadget/udc/renesas_usb3.c:1797:70: note: directive argument in the range [0, 2147483646]
    1797 |                 snprintf(usb3_ep->ep_name, sizeof(usb3_ep->ep_name), "ep%d", i);
         |                                                                      ^~~~~~
   drivers/usb/gadget/udc/renesas_usb3.c:1797:17: note: 'snprintf' output between 4 and 13 bytes into a destination of size 8
    1797 |                 snprintf(usb3_ep->ep_name, sizeof(usb3_ep->ep_name), "ep%d", i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +1797 drivers/usb/gadget/udc/renesas_usb3.c

  1771	
  1772	static int renesas_usb3_init_ep(struct renesas_usb3 *usb3, struct device *dev,
  1773					const struct renesas_usb3_priv *priv)
  1774	{
  1775		struct renesas_usb3_ep *usb3_ep;
  1776		int i;
  1777	
  1778		/* calculate num_usb3_eps from renesas_usb3_priv */
  1779		usb3->num_usb3_eps = priv->ramsize_per_ramif * priv->num_ramif * 2 /
  1780				     priv->ramsize_per_pipe + 1;
  1781	
  1782		if (usb3->num_usb3_eps > USB3_MAX_NUM_PIPES)
  1783			usb3->num_usb3_eps = USB3_MAX_NUM_PIPES;
  1784	
  1785		usb3->usb3_ep = devm_kzalloc(dev, sizeof(*usb3_ep) * usb3->num_usb3_eps,
  1786					     GFP_KERNEL);
  1787		if (!usb3->usb3_ep)
  1788			return -ENOMEM;
  1789	
  1790		dev_dbg(dev, "%s: num_usb3_eps = %d\n", __func__, usb3->num_usb3_eps);
  1791		/*
  1792		 * This driver prepares pipes as the followings:
  1793		 *  - odd pipes = IN pipe
  1794		 *  - even pipes = OUT pipe (except pipe 0)
  1795		 */
  1796		usb3_for_each_ep(usb3_ep, usb3, i) {
> 1797			snprintf(usb3_ep->ep_name, sizeof(usb3_ep->ep_name), "ep%d", i);
  1798			usb3_ep->usb3 = usb3;
  1799			usb3_ep->num = i;
  1800			usb3_ep->ep.name = usb3_ep->ep_name;
  1801			usb3_ep->ep.ops = &renesas_usb3_ep_ops;
  1802			INIT_LIST_HEAD(&usb3_ep->queue);
  1803			INIT_LIST_HEAD(&usb3_ep->ep.ep_list);
  1804			if (!i) {
  1805				/* for control pipe */
  1806				usb3->gadget.ep0 = &usb3_ep->ep;
  1807				usb_ep_set_maxpacket_limit(&usb3_ep->ep,
  1808							USB3_EP0_HSFS_MAX_PACKET_SIZE);
  1809				usb3_ep->ep.caps.type_control = true;
  1810				usb3_ep->ep.caps.dir_in = true;
  1811				usb3_ep->ep.caps.dir_out = true;
  1812				continue;
  1813			}
  1814	
  1815			/* for bulk or interrupt pipe */
  1816			usb_ep_set_maxpacket_limit(&usb3_ep->ep, ~0);
  1817			list_add_tail(&usb3_ep->ep.ep_list, &usb3->gadget.ep_list);
  1818			usb3_ep->ep.caps.type_bulk = true;
  1819			usb3_ep->ep.caps.type_int = true;
  1820			if (i & 1)
  1821				usb3_ep->ep.caps.dir_in = true;
  1822			else
  1823				usb3_ep->ep.caps.dir_out = true;
  1824		}
  1825	
  1826		return 0;
  1827	}
  1828	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
