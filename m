Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BD17CF497
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345159AbjJSKEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345039AbjJSKEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:04:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B4DB8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697709845; x=1729245845;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DiJ9aEbuO+BiTGnKCMTcov+ou8yOqZWmMYvZGWVaTkY=;
  b=JkCHGJjDmUHXi7ouLWMyRMX9uNYOKJvCg+kkRFslwiwaXCMmiySODx3Z
   YNwZtaYS9M4XUYtPU+s4MMMKihKuv5BXV2K6y6lBQBU8ylSIi3TjRjBpy
   /SKdLKfLSUBbZ7r0QkVx5Oo2f9uTZClpnKc2tN3VdkBPTeffOjoAhDg9q
   LGOk7qV01j0vIiU1Ry7r2//KE4UbH0uzBF7iaFQl7NYWK+6HiKFIk5NYZ
   kRGUo7jJ1x97AUu6s0mUlQwLQojNkULIMql+6P3KRM3cv+bDBIDgmRkAJ
   C3Fv6aBtzECXXXPtTeo0e2JjgTnFYzzhb69IOge3Sa3CdqNxObe6u72GT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="365567377"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="365567377"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 03:04:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="900686216"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="900686216"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 19 Oct 2023 03:01:57 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtPso-0001x0-06;
        Thu, 19 Oct 2023 10:04:02 +0000
Date:   Thu, 19 Oct 2023 18:03:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/kernel/pci_of_scan.c:61: warning: Function parameter or
 member 'ss' not described in 'OF_PCI_ADDR0_SPACE'
Message-ID: <202310191708.97T9IVGD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd72f9c7e512da377074d47d990564959b772643
commit: bc605cd79edb68131d3be5b00b949aa312277d39 powerpc/of/pci: Rewrite pci_parse_of_flags
date:   4 years, 2 months ago
config: powerpc-tqm8555_defconfig (https://download.01.org/0day-ci/archive/20231019/202310191708.97T9IVGD-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310191708.97T9IVGD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310191708.97T9IVGD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/powerpc/kernel/pci_of_scan.c:23: warning: Function parameter or member 'np' not described in 'get_int_prop'
   arch/powerpc/kernel/pci_of_scan.c:23: warning: Function parameter or member 'name' not described in 'get_int_prop'
   arch/powerpc/kernel/pci_of_scan.c:23: warning: Function parameter or member 'def' not described in 'get_int_prop'
>> arch/powerpc/kernel/pci_of_scan.c:61: warning: Function parameter or member 'ss' not described in 'OF_PCI_ADDR0_SPACE'
   arch/powerpc/kernel/pci_of_scan.c:61: warning: Excess function parameter 'addr0' description in 'OF_PCI_ADDR0_SPACE'
   arch/powerpc/kernel/pci_of_scan.c:61: warning: Excess function parameter 'bridge' description in 'OF_PCI_ADDR0_SPACE'


vim +61 arch/powerpc/kernel/pci_of_scan.c

    32	
    33	/**
    34	 * pci_parse_of_flags - Parse the flags cell of a device tree PCI address
    35	 * @addr0: value of 1st cell of a device tree PCI address.
    36	 * @bridge: Set this flag if the address is from a bridge 'ranges' property
    37	 *
    38	 * PCI Bus Binding to IEEE Std 1275-1994
    39	 *
    40	 * Bit#            33222222 22221111 11111100 00000000
    41	 *                 10987654 32109876 54321098 76543210
    42	 * phys.hi cell:   npt000ss bbbbbbbb dddddfff rrrrrrrr
    43	 * phys.mid cell:  hhhhhhhh hhhhhhhh hhhhhhhh hhhhhhhh
    44	 * phys.lo cell:   llllllll llllllll llllllll llllllll
    45	 *
    46	 * where:
    47	 * n        is 0 if the address is relocatable, 1 otherwise
    48	 * p        is 1 if the addressable region is "prefetchable", 0 otherwise
    49	 * t        is 1 if the address is aliased (for non-relocatable I/O),
    50	 *          below 1 MB (for Memory),or below 64 KB (for relocatable I/O).
    51	 * ss       is the space code, denoting the address space:
    52	 *              00 denotes Configuration Space
    53	 *              01 denotes I/O Space
    54	 *              10 denotes 32-bit-address Memory Space
    55	 *              11 denotes 64-bit-address Memory Space
    56	 * bbbbbbbb is the 8-bit Bus Number
    57	 * ddddd    is the 5-bit Device Number
    58	 * fff      is the 3-bit Function Number
    59	 * rrrrrrrr is the 8-bit Register Number
    60	 */
  > 61	#define OF_PCI_ADDR0_SPACE(ss)		(((ss)&3)<<24)
    62	#define OF_PCI_ADDR0_SPACE_CFG		OF_PCI_ADDR0_SPACE(0)
    63	#define OF_PCI_ADDR0_SPACE_IO		OF_PCI_ADDR0_SPACE(1)
    64	#define OF_PCI_ADDR0_SPACE_MMIO32	OF_PCI_ADDR0_SPACE(2)
    65	#define OF_PCI_ADDR0_SPACE_MMIO64	OF_PCI_ADDR0_SPACE(3)
    66	#define OF_PCI_ADDR0_SPACE_MASK		OF_PCI_ADDR0_SPACE(3)
    67	#define OF_PCI_ADDR0_RELOC		(1UL<<31)
    68	#define OF_PCI_ADDR0_PREFETCH		(1UL<<30)
    69	#define OF_PCI_ADDR0_ALIAS		(1UL<<29)
    70	#define OF_PCI_ADDR0_BUS		0x00FF0000UL
    71	#define OF_PCI_ADDR0_DEV		0x0000F800UL
    72	#define OF_PCI_ADDR0_FN			0x00000700UL
    73	#define OF_PCI_ADDR0_BARREG		0x000000FFUL
    74	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
