Return-Path: <linux-kernel+bounces-164289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB828B7BD1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D7B1F25EC8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FA1143722;
	Tue, 30 Apr 2024 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aIQ9Zh/w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542B27711D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491393; cv=none; b=dzfP3JTKqYFerElw8vzwZPY//KJYhABgLUaNVCBvhxUzAWn7CiB7HRG6R9rqSQLgRDFRv6Vmo8fRIi/k6TVlBH76T7qx2hwKJElMIbAVI5ExgCcZpAxCRPeu2BAD1k077ZR3Byy/ymwLcODztYN6tDPKwpunlhJSUMxrA+w3+ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491393; c=relaxed/simple;
	bh=8BXzHyy7ehPF7TMooHJOjWpBcJsBSwOqFbMdTKacE1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUerUO1QDz6mJvadGgESR+/A8FnuLJEX8wkxfvz4kD1a/vdm8dOtCJGGr5FFo4hb1Sr4V/lTyIu14aY/4B+4YTVdCrTfOZ63JOUE5omB3HkipV+b+fYSRq/an6DI7eeFHp5BvrmPGSr7Xkmh0VmkdHSuqRIdpn35IjC3/F1SZ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aIQ9Zh/w; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714491391; x=1746027391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8BXzHyy7ehPF7TMooHJOjWpBcJsBSwOqFbMdTKacE1c=;
  b=aIQ9Zh/wvpJoKHzwGCKG+Brb+Qf5TIaTJV9Q4FrRP1giNj2WbwDkvolu
   xytCL1ExdQHO6MUTDRq/I9jzdQnOqwnZhMm96cqcbLgK97mqFgdlZjMcg
   klPS3fO+cio0PYxhD0aoJGrNeSlaQjVvBTn5ECG3uizYsMvhXYJJ8Ia9B
   /UwF9yADGPWA2O+SOnjtx/2BuHqzT2ueidb/P1PbffNiY3u+6QAMC+piL
   KALVusdYZ5CEAJesmGf05k6UXNpgoy8mF5O2Xx25PwK4VjGN+kjNWqK2h
   p+TGlAAK3GeH7iG2IzIlSdgE6oR2zKoUPjtP6UPK7noa+cHmlkBX3lpRG
   A==;
X-CSE-ConnectionGUID: ulLNlsmHT8OZy95Qz/5u7Q==
X-CSE-MsgGUID: RfDTZ5szTB6jYoauZADKGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10427098"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10427098"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 08:36:31 -0700
X-CSE-ConnectionGUID: S/fRantCQx6ZNQsusS7ffg==
X-CSE-MsgGUID: EjVFeBzRTTunTKm8CkmtDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="57384784"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 30 Apr 2024 08:36:28 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1pWr-0008H1-2R;
	Tue, 30 Apr 2024 15:36:25 +0000
Date: Tue, 30 Apr 2024 23:36:07 +0800
From: kernel test robot <lkp@intel.com>
To: Vamsi Attunuru <vattunuru@marvell.com>, arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, vattunuru@marvell.com,
	jerinj@marvell.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K DPI
 administrative driver
Message-ID: <202404302343.PSH0M0Cy-lkp@intel.com>
References: <20240429055027.2162310-1-vattunuru@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429055027.2162310-1-vattunuru@marvell.com>

Hi Vamsi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus soc/for-next linus/master v6.9-rc6 next-20240430]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vamsi-Attunuru/misc-mrvl-cn10k-dpi-add-Octeon-CN10K-DPI-administrative-driver/20240430-142354
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20240429055027.2162310-1-vattunuru%40marvell.com
patch subject: [PATCH v6 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K DPI administrative driver
config: m68k-m5208evb_defconfig (https://download.01.org/0day-ci/archive/20240430/202404302343.PSH0M0Cy-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240430/202404302343.PSH0M0Cy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404302343.PSH0M0Cy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/misc/mrvl_cn10k_dpi.c:197:9: warning: 'packed' attribute ignored for field of type 'struct dpi_mbox_message_s' [-Wattributes]
     197 |         } s __packed;
         |         ^
   drivers/misc/mrvl_cn10k_dpi.c: In function 'dpi_reg_write':
   drivers/misc/mrvl_cn10k_dpi.c:202:9: error: implicit declaration of function 'writeq'; did you mean 'writeb'? [-Werror=implicit-function-declaration]
     202 |         writeq(val, dpi->reg_base + offset);
         |         ^~~~~~
         |         writeb
   drivers/misc/mrvl_cn10k_dpi.c: In function 'dpi_reg_read':
   drivers/misc/mrvl_cn10k_dpi.c:207:16: error: implicit declaration of function 'readq'; did you mean 'readb'? [-Werror=implicit-function-declaration]
     207 |         return readq(dpi->reg_base + offset);
         |                ^~~~~
         |                readb
   drivers/misc/mrvl_cn10k_dpi.c: In function 'dpi_free_irq_vectors':
   drivers/misc/mrvl_cn10k_dpi.c:453:9: error: implicit declaration of function 'pci_free_irq_vectors'; did you mean 'dpi_free_irq_vectors'? [-Werror=implicit-function-declaration]
     453 |         pci_free_irq_vectors((struct pci_dev *)pdev);
         |         ^~~~~~~~~~~~~~~~~~~~
         |         dpi_free_irq_vectors
   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/compat.h:9,
                    from drivers/misc/mrvl_cn10k_dpi.c:8:
   drivers/misc/mrvl_cn10k_dpi.c: In function 'dpi_remove':
   include/linux/stddef.h:8:14: error: called object is not a function or function pointer
       8 | #define NULL ((void *)0)
         |              ^
   include/linux/pci.h:2445:41: note: in expansion of macro 'NULL'
    2445 | #define pci_sriov_configure_simple      NULL
         |                                         ^~~~
   drivers/misc/mrvl_cn10k_dpi.c:661:9: note: in expansion of macro 'pci_sriov_configure_simple'
     661 |         pci_sriov_configure_simple(pdev, 0);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/mrvl_cn10k_dpi.c: At top level:
   drivers/misc/mrvl_cn10k_dpi.c:681:1: warning: data definition has no type or storage class
     681 | module_pci_driver(dpi_driver);
         | ^~~~~~~~~~~~~~~~~
   drivers/misc/mrvl_cn10k_dpi.c:681:1: error: type defaults to 'int' in declaration of 'module_pci_driver' [-Werror=implicit-int]
   drivers/misc/mrvl_cn10k_dpi.c:681:1: warning: parameter names (without types) in function declaration
   drivers/misc/mrvl_cn10k_dpi.c:673:26: warning: 'dpi_driver' defined but not used [-Wunused-variable]
     673 | static struct pci_driver dpi_driver = {
         |                          ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +197 drivers/misc/mrvl_cn10k_dpi.c

   175	
   176	union dpi_mbox_message_t {
   177		u64 u[2];
   178		struct dpi_mbox_message_s {
   179			/* VF ID to configure */
   180			u64 vfid           :8;
   181			/* Command code */
   182			u64 cmd            :4;
   183			/* Command buffer size in 8-byte words */
   184			u64 csize          :14;
   185			/* Aura of the command buffer */
   186			u64 aura           :20;
   187			/* SSO PF function */
   188			u64 sso_pf_func    :16;
   189			/* NPA PF function */
   190			u64 npa_pf_func    :16;
   191			/* Work queue completion status enable */
   192			u64 wqecs	:1;
   193			/* Work queue completion status byte offset */
   194			u64 wqecsoff	:7;
   195			/* Reserved */
   196			u64 rsvd	:42;
 > 197		} s __packed;
   198	};
   199	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

