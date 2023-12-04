Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24DE802E19
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343704AbjLDI5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjLDI5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:57:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B545AA5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701680262; x=1733216262;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GxySVDxuiGHiIKw4W+PxgpWkeVuDjpKSSOyOdyQHQFo=;
  b=NQdSfyIrYmm0Oet2yAwvDoOvJvS+SlZpwMNaTb19xa8Zt6+5D1RQ7IRS
   u4UtCqwlDwxf04v75Y0MSw503o5y7sCMqY6njdf9aUMxI//mXGpf7wREa
   +Ozj6gXNtcW012OuNd7EjZkrTjmJLgD1FUGeOr51Qxh4iqjbRl1ifEoei
   hk8/26CFiUaKYhRq0rU1rFi5MPZeLMnTOX77XRCPiYsS8ZFGUbLlClW3V
   AcDHnNqQitJ1JMBynADuy4d0bXzajyC9oIzA9Lfv2BeoZIcGjd+W73vnl
   stEPrK5F/PvpANT1fViQmNf3FXjuWJkVE40Z5+uGZKDOE/4yCSC8OBsoc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="390863366"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="390863366"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 00:57:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="774190999"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="774190999"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 04 Dec 2023 00:57:39 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rA4ll-0007c6-1v;
        Mon, 04 Dec 2023 08:57:37 +0000
Date:   Mon, 4 Dec 2023 16:56:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: drivers/firmware/qcom/qcom_scm.c:1652:34: warning: unused variable
 'qcom_scm_qseecom_allowlist'
Message-ID: <202312041607.kGqDrfpq-lkp@intel.com>
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

Hi Bartosz,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: bdac188ec3c71800dd8419620224ee74ef37732a firmware: qcom: move Qualcomm code into its own directory
date:   6 weeks ago
config: s390-randconfig-002-20231119 (https://download.01.org/0day-ci/archive/20231204/202312041607.kGqDrfpq-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231204/202312041607.kGqDrfpq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312041607.kGqDrfpq-lkp@intel.com/

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
