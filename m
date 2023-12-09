Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C1480B490
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 14:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjLINXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 08:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLINXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 08:23:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B72FA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 05:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702128200; x=1733664200;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=z+g75rp39+u/KjgG9h4SER7OvkC0rmh4IMHKk9fen8s=;
  b=lAaRulhejuUvb0wyTBR49yAqaE3El6IBEyOdtcUoQrEiRnJ4CoLQ+24p
   Mw9xyVdhSKifP2MOksx2rJo+8AeDBZrZc1AE5S6pEQh967kYylCbLVBDZ
   /KwQ6pyd+tolcBSJj4khtc2nHJP/3uniMxcdOjwy0ff3R5/ppGz6ovk+O
   1p2gbMJyxwhz80BpUD2OgE/kgbR9V0+LGYY09Fiu5YpVL+yBmUxy4Do7h
   cGJOiqEcEhJo2SubQNmFlf9gddtVcGpbauwMno/2g3KhMRvFLUueZG9nx
   TKWePE+io0E+k2kqeKniIuZaP8Xb4oeWPQof9XCsWNH2NOuDtJytpJjLY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="480704943"
X-IronPort-AV: E=Sophos;i="6.04,263,1695711600"; 
   d="scan'208";a="480704943"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 05:23:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="842930282"
X-IronPort-AV: E=Sophos;i="6.04,263,1695711600"; 
   d="scan'208";a="842930282"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 09 Dec 2023 05:23:18 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBxIZ-000FNX-39;
        Sat, 09 Dec 2023 13:23:15 +0000
Date:   Sat, 9 Dec 2023 21:23:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: arch/s390/pci/pci_mmio.c:35:1: sparse: sparse: Using plain integer
 as NULL pointer
Message-ID: <202312092144.nRcv9gfg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f2e8a57ee9036c7d5443382b6c3c09b51a92ec7e
commit: aa0d6e70d3b34e710a6a57a53a3096cb2e0ea99f s390: autogenerate compat syscall wrappers
date:   4 years, 11 months ago
config: s390-randconfig-r113-20231115 (https://download.01.org/0day-ci/archive/20231209/202312092144.nRcv9gfg-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231209/202312092144.nRcv9gfg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312092144.nRcv9gfg-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/s390/pci/pci_mmio.c:35:1: sparse: sparse: Using plain integer as NULL pointer
>> arch/s390/pci/pci_mmio.c:35:1: sparse: sparse: Using plain integer as NULL pointer
   arch/s390/pci/pci_mmio.c:75:1: sparse: sparse: Using plain integer as NULL pointer
   arch/s390/pci/pci_mmio.c:75:1: sparse: sparse: Using plain integer as NULL pointer
--
>> kernel/acct.c:273:1: sparse: sparse: Using plain integer as NULL pointer
>> kernel/acct.c:273:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/acct.c:193:12: sparse: sparse: context imbalance in 'acct_on' - different lock contexts for basic block
   kernel/acct.c:294:9: sparse: sparse: context imbalance in '__se_sys_acct' - different lock contexts for basic block
   kernel/acct.c:297:6: sparse: sparse: context imbalance in 'acct_exit_ns' - wrong count at exit

vim +35 arch/s390/pci/pci_mmio.c

4eafad7febd482 Alexey Ishchuk 2014-11-14  34  
4eafad7febd482 Alexey Ishchuk 2014-11-14 @35  SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, mmio_addr,
4eafad7febd482 Alexey Ishchuk 2014-11-14  36  		const void __user *, user_buffer, size_t, length)
4eafad7febd482 Alexey Ishchuk 2014-11-14  37  {
4eafad7febd482 Alexey Ishchuk 2014-11-14  38  	u8 local_buf[64];
4eafad7febd482 Alexey Ishchuk 2014-11-14  39  	void __iomem *io_addr;
4eafad7febd482 Alexey Ishchuk 2014-11-14  40  	void *buf;
4eafad7febd482 Alexey Ishchuk 2014-11-14  41  	unsigned long pfn;
4eafad7febd482 Alexey Ishchuk 2014-11-14  42  	long ret;
4eafad7febd482 Alexey Ishchuk 2014-11-14  43  
4eafad7febd482 Alexey Ishchuk 2014-11-14  44  	if (!zpci_is_enabled())
4eafad7febd482 Alexey Ishchuk 2014-11-14  45  		return -ENODEV;
4eafad7febd482 Alexey Ishchuk 2014-11-14  46  
4eafad7febd482 Alexey Ishchuk 2014-11-14  47  	if (length <= 0 || PAGE_SIZE - (mmio_addr & ~PAGE_MASK) < length)
4eafad7febd482 Alexey Ishchuk 2014-11-14  48  		return -EINVAL;
4eafad7febd482 Alexey Ishchuk 2014-11-14  49  	if (length > 64) {
4eafad7febd482 Alexey Ishchuk 2014-11-14  50  		buf = kmalloc(length, GFP_KERNEL);
4eafad7febd482 Alexey Ishchuk 2014-11-14  51  		if (!buf)
4eafad7febd482 Alexey Ishchuk 2014-11-14  52  			return -ENOMEM;
4eafad7febd482 Alexey Ishchuk 2014-11-14  53  	} else
4eafad7febd482 Alexey Ishchuk 2014-11-14  54  		buf = local_buf;
4eafad7febd482 Alexey Ishchuk 2014-11-14  55  
4eafad7febd482 Alexey Ishchuk 2014-11-14  56  	ret = get_pfn(mmio_addr, VM_WRITE, &pfn);
4eafad7febd482 Alexey Ishchuk 2014-11-14  57  	if (ret)
4eafad7febd482 Alexey Ishchuk 2014-11-14  58  		goto out;
eba8452525e3fd Heiko Carstens 2014-12-12  59  	io_addr = (void __iomem *)((pfn << PAGE_SHIFT) | (mmio_addr & ~PAGE_MASK));
4eafad7febd482 Alexey Ishchuk 2014-11-14  60  
4eafad7febd482 Alexey Ishchuk 2014-11-14  61  	ret = -EFAULT;
4eafad7febd482 Alexey Ishchuk 2014-11-14  62  	if ((unsigned long) io_addr < ZPCI_IOMAP_ADDR_BASE)
4eafad7febd482 Alexey Ishchuk 2014-11-14  63  		goto out;
4eafad7febd482 Alexey Ishchuk 2014-11-14  64  
4eafad7febd482 Alexey Ishchuk 2014-11-14  65  	if (copy_from_user(buf, user_buffer, length))
4eafad7febd482 Alexey Ishchuk 2014-11-14  66  		goto out;
4eafad7febd482 Alexey Ishchuk 2014-11-14  67  
f0483044c1c960 Sebastian Ott  2015-02-25  68  	ret = zpci_memcpy_toio(io_addr, buf, length);
4eafad7febd482 Alexey Ishchuk 2014-11-14  69  out:
4eafad7febd482 Alexey Ishchuk 2014-11-14  70  	if (buf != local_buf)
4eafad7febd482 Alexey Ishchuk 2014-11-14  71  		kfree(buf);
4eafad7febd482 Alexey Ishchuk 2014-11-14  72  	return ret;
4eafad7febd482 Alexey Ishchuk 2014-11-14  73  }
4eafad7febd482 Alexey Ishchuk 2014-11-14  74  

:::::: The code at line 35 was first introduced by commit
:::::: 4eafad7febd482092b331ea72c37274d745956be s390/kernel: add system calls for PCI memory access

:::::: TO: Alexey Ishchuk <aishchuk@linux.vnet.ibm.com>
:::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
