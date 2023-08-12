Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D6F779F66
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 12:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbjHLK6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 06:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjHLK6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 06:58:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACBAA7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 03:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691837895; x=1723373895;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=e/8VYDfygzC/52VFy9+ytTHq9T5/W2xZbV+sXpEqpr8=;
  b=NFLKqWIB02PfBWBwAkXThU5HKIrXBY9UgeYbbHzDc2bKjjhYHjTWhJAC
   f6cyTj34TOFRBT4IrlG0te13yDl/gKADRnpoEbW/aKzLEOLf8/ITLg/ff
   9SDC+G7zEQtjdBpXxOVt7ALBZf3wVDr9S9+1O/RQVPrbs7Cv/tBdyxDYz
   JadPI6iYt6xxR3/dZn10SVi1Tazoda72XBceoZ5A+JHVpbEu1E3s2Zlfx
   JCl9u8hMcu6mtSvCAYh17hr/JNIcSzuFmQ9DCjaaJLnAxKg8u15uHuSDn
   JOxEFt7L7Cu/U7gEpyUPRsn3eGep8v+HeAKaj1U1CEhGllZpkyMtt31rv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="370720430"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="370720430"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2023 03:58:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="709799179"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="709799179"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 12 Aug 2023 03:58:12 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUmJv-0008Wa-2J;
        Sat, 12 Aug 2023 10:58:11 +0000
Date:   Sat, 12 Aug 2023 18:57:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, Kai Huang <kai.huang@intel.com>
Subject: arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse: sparse: incorrect type
 in assignment (different base types)
Message-ID: <202308121812.AERo19Sw-lkp@intel.com>
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
head:   f8de32cc060ba3f63171aaa0e8764d22d8c37978
commit: 540745ddbc70eabdc7dbd3fcc00fe4fb17cd59ba x86/sgx: Introduce virtual EPC for use by KVM guests
date:   2 years, 4 months ago
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20230812/202308121812.AERo19Sw-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230812/202308121812.AERo19Sw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308121812.AERo19Sw-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected int [assigned] ret @@     got restricted vm_fault_t @@
   arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse:     expected int [assigned] ret
   arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse:     got restricted vm_fault_t
>> arch/x86/kernel/cpu/sgx/virt.c:60:20: sparse: sparse: restricted vm_fault_t degrades to integer
   arch/x86/kernel/cpu/sgx/virt.c:95:35: sparse: sparse: symbol 'sgx_vepc_vm_ops' was not declared. Should it be static?

vim +59 arch/x86/kernel/cpu/sgx/virt.c

    32	
    33	static int __sgx_vepc_fault(struct sgx_vepc *vepc,
    34				    struct vm_area_struct *vma, unsigned long addr)
    35	{
    36		struct sgx_epc_page *epc_page;
    37		unsigned long index, pfn;
    38		int ret;
    39	
    40		WARN_ON(!mutex_is_locked(&vepc->lock));
    41	
    42		/* Calculate index of EPC page in virtual EPC's page_array */
    43		index = vma->vm_pgoff + PFN_DOWN(addr - vma->vm_start);
    44	
    45		epc_page = xa_load(&vepc->page_array, index);
    46		if (epc_page)
    47			return 0;
    48	
    49		epc_page = sgx_alloc_epc_page(vepc, false);
    50		if (IS_ERR(epc_page))
    51			return PTR_ERR(epc_page);
    52	
    53		ret = xa_err(xa_store(&vepc->page_array, index, epc_page, GFP_KERNEL));
    54		if (ret)
    55			goto err_free;
    56	
    57		pfn = PFN_DOWN(sgx_get_epc_phys_addr(epc_page));
    58	
  > 59		ret = vmf_insert_pfn(vma, addr, pfn);
  > 60		if (ret != VM_FAULT_NOPAGE) {
    61			ret = -EFAULT;
    62			goto err_delete;
    63		}
    64	
    65		return 0;
    66	
    67	err_delete:
    68		xa_erase(&vepc->page_array, index);
    69	err_free:
    70		sgx_free_epc_page(epc_page);
    71		return ret;
    72	}
    73	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
