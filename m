Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6536280406A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbjLDUx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbjLDUxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:53:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CBF182
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701722611; x=1733258611;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/zvbmGJQjO24iQligWWCV3lFEkGyjrjPwZeR+q3oSpw=;
  b=P6XTl73cUTBf/ybB8WVapkHVFs+vCV6htk/C2EK86sy5KHzXJBjw7ndk
   t+XtCYEx3ia1cJ6wDvmWCnfMoEa0UCDTRaiUw467cslcBREmBshDzshNl
   9YvzI+jF2H/t8tcGdR30ezoaS4QOpX1u5sbH5h7umyui1O+wbLwj3/iVb
   Ha2WZmFD16gHCFfY5FPoxioBB5LdpcJjmMZACDRHwcMRCA9emOTlGQ0Af
   zFOORcykxk4cJEzA+zddmPb4Xok74YtVmLogZV8FAT4TZgkcUp6Gix40c
   42bchH3k+dRud8yzR2fOfwxWUiNEQJr0epZY2aD33KZdi10wf9tZA+5HH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="396594698"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="396594698"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 12:43:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="836722405"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="836722405"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 04 Dec 2023 12:43:29 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAFmo-00084c-31;
        Mon, 04 Dec 2023 20:43:26 +0000
Date:   Tue, 5 Dec 2023 04:42:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>
Subject: drivers/tty/serial/ucc_uart.c:264:33: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202312050412.zN2PKArS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: 18f0211c9a104b6f40ab92f644a95d7f3028515c tty: serial: ucc_uart: replace qe_io{read,write}* wrappers by generic io{read,write}*
date:   2 years, 8 months ago
config: powerpc-randconfig-r132-20231117 (https://download.01.org/0day-ci/archive/20231205/202312050412.zN2PKArS-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231205/202312050412.zN2PKArS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312050412.zN2PKArS-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/tty/serial/ucc_uart.c:264:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:264:33: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:264:33: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:268:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:268:33: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:268:33: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:314:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/tty/serial/ucc_uart.c:314:9: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/tty/serial/ucc_uart.c:314:9: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:314:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/tty/serial/ucc_uart.c:314:9: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/tty/serial/ucc_uart.c:314:9: sparse:     got restricted __be16 [noderef] __iomem *
>> drivers/tty/serial/ucc_uart.c:347:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:347:33: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:347:33: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:33: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:350:33: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:369:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:369:30: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:369:30: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:382:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:382:37: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:382:37: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:383:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:383:17: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/tty/serial/ucc_uart.c:383:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:383:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:383:17: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/tty/serial/ucc_uart.c:383:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:386:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:386:33: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:386:33: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:424:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/tty/serial/ucc_uart.c:424:17: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/tty/serial/ucc_uart.c:424:17: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:424:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/tty/serial/ucc_uart.c:424:17: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/tty/serial/ucc_uart.c:424:17: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:435:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/tty/serial/ucc_uart.c:435:9: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/tty/serial/ucc_uart.c:435:9: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:435:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/tty/serial/ucc_uart.c:435:9: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/tty/serial/ucc_uart.c:435:9: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:474:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:474:38: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:474:38: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:481:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:481:33: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:481:33: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:515:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:515:33: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:515:33: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:604:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:604:58: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:604:58: sparse:     got restricted __be16 *
>> drivers/tty/serial/ucc_uart.c:605:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:605:61: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:605:61: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:606:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:606:33: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:606:33: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:612:63: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:612:63: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:612:63: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:613:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:613:53: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:613:53: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:614:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:614:25: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:614:25: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:625:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:625:44: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:625:44: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:626:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:626:61: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:626:61: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:627:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:627:33: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:627:33: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:637:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:637:49: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:637:49: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:638:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:638:53: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:638:53: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:639:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:639:25: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:639:25: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:653:46: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ucc_uart_pram *uccup @@     got struct ucc_uart_pram [noderef] __iomem *uccup @@
   drivers/tty/serial/ucc_uart.c:653:46: sparse:     expected struct ucc_uart_pram *uccup
   drivers/tty/serial/ucc_uart.c:653:46: sparse:     got struct ucc_uart_pram [noderef] __iomem *uccup
   drivers/tty/serial/ucc_uart.c:661:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:661:48: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:661:48: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:662:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:662:48: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:662:48: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:663:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:663:44: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:663:44: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:664:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:664:28: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:664:28: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:665:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:665:25: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:665:25: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:666:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:666:25: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:666:25: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:667:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:667:25: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:667:25: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:668:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:668:25: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:668:25: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:669:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:669:25: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:669:25: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:670:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:670:37: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:670:37: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:671:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:671:37: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:671:37: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:672:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:672:25: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:672:25: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:674:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:674:51: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:674:51: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:675:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:675:30: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:675:30: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:680:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/tty/serial/ucc_uart.c:680:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/tty/serial/ucc_uart.c:680:17: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:680:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/tty/serial/ucc_uart.c:680:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/tty/serial/ucc_uart.c:680:17: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:684:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/tty/serial/ucc_uart.c:684:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/tty/serial/ucc_uart.c:684:17: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:684:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/tty/serial/ucc_uart.c:684:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/tty/serial/ucc_uart.c:684:17: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:687:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/tty/serial/ucc_uart.c:687:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/tty/serial/ucc_uart.c:687:17: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:687:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/tty/serial/ucc_uart.c:687:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/tty/serial/ucc_uart.c:687:17: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:691:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/tty/serial/ucc_uart.c:691:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/tty/serial/ucc_uart.c:691:17: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:691:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/tty/serial/ucc_uart.c:691:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr

vim +264 drivers/tty/serial/ucc_uart.c

   248	
   249	/*
   250	 * Return 1 if the QE is done transmitting all buffers for this port
   251	 *
   252	 * This function scans each BD in sequence.  If we find a BD that is not
   253	 * ready (READY=1), then we return 0 indicating that the QE is still sending
   254	 * data.  If we reach the last BD (WRAP=1), then we know we've scanned
   255	 * the entire list, and all BDs are done.
   256	 */
   257	static unsigned int qe_uart_tx_empty(struct uart_port *port)
   258	{
   259		struct uart_qe_port *qe_port =
   260			container_of(port, struct uart_qe_port, port);
   261		struct qe_bd *bdp = qe_port->tx_bd_base;
   262	
   263		while (1) {
 > 264			if (ioread16be(&bdp->status) & BD_SC_READY)
   265				/* This BD is not done, so return "not done" */
   266				return 0;
   267	
   268			if (ioread16be(&bdp->status) & BD_SC_WRAP)
   269				/*
   270				 * This BD is done and it's the last one, so return
   271				 * "done"
   272				 */
   273				return 1;
   274	
   275			bdp++;
   276		}
   277	}
   278	
   279	/*
   280	 * Set the modem control lines
   281	 *
   282	 * Although the QE can control the modem control lines (e.g. CTS), we
   283	 * don't need that support. This function must exist, however, otherwise
   284	 * the kernel will panic.
   285	 */
   286	static void qe_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
   287	{
   288	}
   289	
   290	/*
   291	 * Get the current modem control line status
   292	 *
   293	 * Although the QE can control the modem control lines (e.g. CTS), this
   294	 * driver currently doesn't support that, so we always return Carrier
   295	 * Detect, Data Set Ready, and Clear To Send.
   296	 */
   297	static unsigned int qe_uart_get_mctrl(struct uart_port *port)
   298	{
   299		return TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
   300	}
   301	
   302	/*
   303	 * Disable the transmit interrupt.
   304	 *
   305	 * Although this function is called "stop_tx", it does not actually stop
   306	 * transmission of data.  Instead, it tells the QE to not generate an
   307	 * interrupt when the UCC is finished sending characters.
   308	 */
   309	static void qe_uart_stop_tx(struct uart_port *port)
   310	{
   311		struct uart_qe_port *qe_port =
   312			container_of(port, struct uart_qe_port, port);
   313	
   314		qe_clrbits_be16(&qe_port->uccp->uccm, UCC_UART_UCCE_TX);
   315	}
   316	
   317	/*
   318	 * Transmit as many characters to the HW as possible.
   319	 *
   320	 * This function will attempt to stuff of all the characters from the
   321	 * kernel's transmit buffer into TX BDs.
   322	 *
   323	 * A return value of non-zero indicates that it successfully stuffed all
   324	 * characters from the kernel buffer.
   325	 *
   326	 * A return value of zero indicates that there are still characters in the
   327	 * kernel's buffer that have not been transmitted, but there are no more BDs
   328	 * available.  This function should be called again after a BD has been made
   329	 * available.
   330	 */
   331	static int qe_uart_tx_pump(struct uart_qe_port *qe_port)
   332	{
   333		struct qe_bd *bdp;
   334		unsigned char *p;
   335		unsigned int count;
   336		struct uart_port *port = &qe_port->port;
   337		struct circ_buf *xmit = &port->state->xmit;
   338	
   339		/* Handle xon/xoff */
   340		if (port->x_char) {
   341			/* Pick next descriptor and fill from buffer */
   342			bdp = qe_port->tx_cur;
   343	
   344			p = qe2cpu_addr(be32_to_cpu(bdp->buf), qe_port);
   345	
   346			*p++ = port->x_char;
 > 347			iowrite16be(1, &bdp->length);
   348			qe_setbits_be16(&bdp->status, BD_SC_READY);
   349			/* Get next BD. */
   350			if (ioread16be(&bdp->status) & BD_SC_WRAP)
   351				bdp = qe_port->tx_bd_base;
   352			else
   353				bdp++;
   354			qe_port->tx_cur = bdp;
   355	
   356			port->icount.tx++;
   357			port->x_char = 0;
   358			return 1;
   359		}
   360	
   361		if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
   362			qe_uart_stop_tx(port);
   363			return 0;
   364		}
   365	
   366		/* Pick next descriptor and fill from buffer */
   367		bdp = qe_port->tx_cur;
   368	
   369		while (!(ioread16be(&bdp->status) & BD_SC_READY) &&
   370		       (xmit->tail != xmit->head)) {
   371			count = 0;
   372			p = qe2cpu_addr(be32_to_cpu(bdp->buf), qe_port);
   373			while (count < qe_port->tx_fifosize) {
   374				*p++ = xmit->buf[xmit->tail];
   375				xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
   376				port->icount.tx++;
   377				count++;
   378				if (xmit->head == xmit->tail)
   379					break;
   380			}
   381	
   382			iowrite16be(count, &bdp->length);
   383			qe_setbits_be16(&bdp->status, BD_SC_READY);
   384	
   385			/* Get next BD. */
   386			if (ioread16be(&bdp->status) & BD_SC_WRAP)
   387				bdp = qe_port->tx_bd_base;
   388			else
   389				bdp++;
   390		}
   391		qe_port->tx_cur = bdp;
   392	
   393		if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
   394			uart_write_wakeup(port);
   395	
   396		if (uart_circ_empty(xmit)) {
   397			/* The kernel buffer is empty, so turn off TX interrupts.  We
   398			   don't need to be told when the QE is finished transmitting
   399			   the data. */
   400			qe_uart_stop_tx(port);
   401			return 0;
   402		}
   403	
   404		return 1;
   405	}
   406	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
