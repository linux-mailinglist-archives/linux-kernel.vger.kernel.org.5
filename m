Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8BE7F04ED
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 10:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjKSJOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 04:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjKSJO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 04:14:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78390138
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 01:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700385266; x=1731921266;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/wJMprHo/hGCSPGEmhrRtWjfvwHBT5y37td5BtCsHGI=;
  b=Ool2pFgolzm/EeliG3k0JKKKSatNtVL6ehK9IBGO8qGB8lKUAjPHXLiz
   3Bmx0L8brlN0SVnU+qfzuG9c8uIm+zFHDQ3r6bgJu5MJfxALZguWLNMBP
   9jvqwQ/fvpqz+mqtVy+Lt1Oz1H6gbeBcauzmQVkUm7Yzr5f5/prtmdPRH
   CV8eR+w3ykAyfINlFDlDprZ/Ers2dqJDR8Ucnj/sQ6DqRbUU/8iXKfXAa
   f0APk126aPhOfmVlXOMfGSUiQa84aaz8rJO6eSZAyYb086rTXJgGpX96M
   JjM2WUOFFVBN/kDSpqM6XhNhS2By8Vzm4AkmORaiN9SFWpr1pTMVKqQrG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="4644088"
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="4644088"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 01:14:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="800864598"
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="800864598"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 19 Nov 2023 01:14:22 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4dsi-0004tL-1t;
        Sun, 19 Nov 2023 09:14:20 +0000
Date:   Sun, 19 Nov 2023 17:13:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: drivers/firmware/qcom/qcom_scm.c:1652:34: warning: unused variable
 'qcom_scm_qseecom_allowlist'
Message-ID: <202311191654.S4wlVUrz-lkp@intel.com>
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
head:   037266a5f7239ead1530266f7d7af153d2a867fa
commit: bdac188ec3c71800dd8419620224ee74ef37732a firmware: qcom: move Qualcomm code into its own directory
date:   4 weeks ago
config: s390-randconfig-002-20231119 (https://download.01.org/0day-ci/archive/20231119/202311191654.S4wlVUrz-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231119/202311191654.S4wlVUrz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311191654.S4wlVUrz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/firmware/qcom/qcom_scm.c:10:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/firmware/qcom/qcom_scm.c:10:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/firmware/qcom/qcom_scm.c:10:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
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
>> drivers/firmware/qcom/qcom_scm.c:1652:34: warning: unused variable 'qcom_scm_qseecom_allowlist' [-Wunused-const-variable]
    1652 | static const struct of_device_id qcom_scm_qseecom_allowlist[] = {
         |                                  ^
   13 warnings generated.


vim +/qcom_scm_qseecom_allowlist +1652 drivers/firmware/qcom/qcom_scm.c

00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1647  
00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1648  /*
00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1649   * We do not yet support re-entrant calls via the qseecom interface. To prevent
00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1650   + any potential issues with this, only allow validated machines for now.
00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1651   */
00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27 @1652  static const struct of_device_id qcom_scm_qseecom_allowlist[] = {
00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1653  	{ .compatible = "lenovo,thinkpad-x13s", },
00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1654  	{ }
00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1655  };
00b1248606ba39 drivers/firmware/qcom_scm.c Maximilian Luz 2023-08-27  1656  

:::::: The code at line 1652 was first introduced by commit
:::::: 00b1248606ba3979ccae30ed11df8cdc1a84245a firmware: qcom_scm: Add support for Qualcomm Secure Execution Environment SCM interface

:::::: TO: Maximilian Luz <luzmaximilian@gmail.com>
:::::: CC: Bjorn Andersson <andersson@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
