Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E3A77A0C9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 17:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjHLP2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 11:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHLP2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 11:28:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CF4E54
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 08:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691854098; x=1723390098;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bbfNGtVQl1/C0AChnlWCxxZkBJ1JAK67j4ZYRZ31wu8=;
  b=nevc5lVrVo3FNAtt7LrzF4fqiflt7jK1l+XV7srHFLxYgyWEwHPw6JBs
   3bWhHiAa04mrcbnMUNTA38THR5tHc4fXTgXR4heLOxzRLwcAcGu8ueLTF
   DdF9O2ncixyOr9ZNQyGlXR2jC6MEFvzrizUWullSI5mluq6pSC7OU0sP1
   LNnNd/7Yh5CqBsCEUi27LlKneVPFmXQ16EpoyEvNT0IItpkVfizv2hjzR
   ukkKP7Sq3lGwhUSTAidUHc4BYZ0NzUmiAcsrUiRTujDt0AzHUUKlui7ym
   u4k8jLVWaLxkifB+JXCOeclD0GKLLUM9TGBVZUA4PNg+cu637l5qFMWsk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10800"; a="369305303"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="369305303"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2023 08:28:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="876477831"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 12 Aug 2023 08:28:20 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUqXI-0008dk-07;
        Sat, 12 Aug 2023 15:28:16 +0000
Date:   Sat, 12 Aug 2023 23:27:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, Kai Huang <kai.huang@intel.com>
Subject: arch/x86/kernel/cpu/sgx/virt.c:295:36: sparse: sparse: cast removes
 address space '__user' of expression
Message-ID: <202308122341.T4Bg7lx0-lkp@intel.com>
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
commit: d155030b1e7c0e448aab22a803f7a71ea2e117d7 x86/sgx: Add helpers to expose ECREATE and EINIT to KVM
date:   2 years, 4 months ago
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20230812/202308122341.T4Bg7lx0-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230812/202308122341.T4Bg7lx0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308122341.T4Bg7lx0-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected int [assigned] ret @@     got restricted vm_fault_t @@
   arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse:     expected int [assigned] ret
   arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse:     got restricted vm_fault_t
   arch/x86/kernel/cpu/sgx/virt.c:60:20: sparse: sparse: restricted vm_fault_t degrades to integer
   arch/x86/kernel/cpu/sgx/virt.c:95:35: sparse: sparse: symbol 'sgx_vepc_vm_ops' was not declared. Should it be static?
>> arch/x86/kernel/cpu/sgx/virt.c:295:36: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/kernel/cpu/sgx/virt.c:326:24: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/kernel/cpu/sgx/virt.c:326:43: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/kernel/cpu/sgx/virt.c:326:58: sparse: sparse: cast removes address space '__user' of expression

vim +/__user +295 arch/x86/kernel/cpu/sgx/virt.c

   260	
   261	/**
   262	 * sgx_virt_ecreate() - Run ECREATE on behalf of guest
   263	 * @pageinfo:	Pointer to PAGEINFO structure
   264	 * @secs:	Userspace pointer to SECS page
   265	 * @trapnr:	trap number injected to guest in case of ECREATE error
   266	 *
   267	 * Run ECREATE on behalf of guest after KVM traps ECREATE for the purpose
   268	 * of enforcing policies of guest's enclaves, and return the trap number
   269	 * which should be injected to guest in case of any ECREATE error.
   270	 *
   271	 * Return:
   272	 * -  0:	ECREATE was successful.
   273	 * - <0:	on error.
   274	 */
   275	int sgx_virt_ecreate(struct sgx_pageinfo *pageinfo, void __user *secs,
   276			     int *trapnr)
   277	{
   278		int ret;
   279	
   280		/*
   281		 * @secs is an untrusted, userspace-provided address.  It comes from
   282		 * KVM and is assumed to be a valid pointer which points somewhere in
   283		 * userspace.  This can fault and call SGX or other fault handlers when
   284		 * userspace mapping @secs doesn't exist.
   285		 *
   286		 * Add a WARN() to make sure @secs is already valid userspace pointer
   287		 * from caller (KVM), who should already have handled invalid pointer
   288		 * case (for instance, made by malicious guest).  All other checks,
   289		 * such as alignment of @secs, are deferred to ENCLS itself.
   290		 */
   291		if (WARN_ON_ONCE(!access_ok(secs, PAGE_SIZE)))
   292			return -EINVAL;
   293	
   294		__uaccess_begin();
 > 295		ret = __ecreate(pageinfo, (void *)secs);
   296		__uaccess_end();
   297	
   298		if (encls_faulted(ret)) {
   299			*trapnr = ENCLS_TRAPNR(ret);
   300			return -EFAULT;
   301		}
   302	
   303		/* ECREATE doesn't return an error code, it faults or succeeds. */
   304		WARN_ON_ONCE(ret);
   305		return 0;
   306	}
   307	EXPORT_SYMBOL_GPL(sgx_virt_ecreate);
   308	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
