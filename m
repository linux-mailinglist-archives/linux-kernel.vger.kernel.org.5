Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3643779BC8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 02:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbjHLAKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 20:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjHLAJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 20:09:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366E01FEE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 17:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691798998; x=1723334998;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Krcl/LMo8g28e/jsX+4dkr5H04FoN5IYBkZp6T1ik2Y=;
  b=dNfKYD+aNBwrXI7zvPSNOKKRFjHwqgj6m79y7jwE0TLyb6Mgw/v3kMeK
   fvceXY2Kiipa6M4UdqBTHZYjmNXbsi3zxC7YWtP5dvLh2s9jOTJ8T6J3H
   +zBTWsAAXxEuHxYueYQgApKpEaODZzflJW0OA2LtFGOECgIgmCxYKpdlz
   WoyrAV5dnjONwggyFMllIxp/DoHofynMWvgKvBHEuerkywdoQxKRa7P2H
   mXgnMjjLMVj47KE5ywITJl/mjwUMmQpQbkWfUtjHjvrRZK1iU1fHuUuZ2
   eb73/zlgec+h3OonHt1V6iRa1nHdhVNoVW1ALcEsD2gyUoKiFm54uDeZ/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="351391842"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="351391842"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 17:09:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="802853380"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="802853380"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2023 17:09:55 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUcCY-00087M-1Y;
        Sat, 12 Aug 2023 00:09:54 +0000
Date:   Sat, 12 Aug 2023 08:09:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Justin Ernst <justin.ernst@hpe.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, Steve Wahl <steve.wahl@hpe.com>
Subject: arch/x86/platform/uv/bios_uv.c:175:12: sparse: sparse: function
 'uv_bios_get_master_nasid' with external linkage has definition
Message-ID: <202308120843.j7FXmsnM-lkp@intel.com>
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
head:   190bf7b14b0cf3df19c059061be032bd8994a597
commit: 9a3c425cfdfee169622f1cb1a974b2f287e5560c x86/platform/uv: Add and export uv_bios_* functions
date:   2 years, 9 months ago
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20230812/202308120843.j7FXmsnM-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230812/202308120843.j7FXmsnM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308120843.j7FXmsnM-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/x86/platform/uv/bios_uv.c:175:12: sparse: sparse: function 'uv_bios_get_master_nasid' with external linkage has definition
>> arch/x86/platform/uv/bios_uv.c:182:12: sparse: sparse: function 'uv_bios_get_heapsize' with external linkage has definition
>> arch/x86/platform/uv/bios_uv.c:189:12: sparse: sparse: function 'uv_bios_install_heap' with external linkage has definition
>> arch/x86/platform/uv/bios_uv.c:196:12: sparse: sparse: function 'uv_bios_obj_count' with external linkage has definition
>> arch/x86/platform/uv/bios_uv.c:203:12: sparse: sparse: function 'uv_bios_enum_objs' with external linkage has definition
>> arch/x86/platform/uv/bios_uv.c:210:12: sparse: sparse: function 'uv_bios_enum_ports' with external linkage has definition
>> arch/x86/platform/uv/bios_uv.c:217:12: sparse: sparse: function 'uv_bios_get_geoinfo' with external linkage has definition
>> arch/x86/platform/uv/bios_uv.c:223:12: sparse: sparse: function 'uv_bios_get_pci_topology' with external linkage has definition
   arch/x86/platform/uv/bios_uv.c:249:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct uv_systab *[addressable] [assigned] [toplevel] uv_systab @@     got void [noderef] __iomem * @@
   arch/x86/platform/uv/bios_uv.c:249:19: sparse:     expected struct uv_systab *[addressable] [assigned] [toplevel] uv_systab
   arch/x86/platform/uv/bios_uv.c:249:19: sparse:     got void [noderef] __iomem *
   arch/x86/platform/uv/bios_uv.c:252:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct uv_systab *[addressable] [assigned] [toplevel] uv_systab @@
   arch/x86/platform/uv/bios_uv.c:252:25: sparse:     expected void volatile [noderef] __iomem *addr
   arch/x86/platform/uv/bios_uv.c:252:25: sparse:     got struct uv_systab *[addressable] [assigned] [toplevel] uv_systab
   arch/x86/platform/uv/bios_uv.c:260:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct uv_systab *[addressable] [assigned] [toplevel] uv_systab @@
   arch/x86/platform/uv/bios_uv.c:260:25: sparse:     expected void volatile [noderef] __iomem *addr
   arch/x86/platform/uv/bios_uv.c:260:25: sparse:     got struct uv_systab *[addressable] [assigned] [toplevel] uv_systab
   arch/x86/platform/uv/bios_uv.c:261:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct uv_systab *[addressable] [assigned] [toplevel] uv_systab @@     got void [noderef] __iomem * @@
   arch/x86/platform/uv/bios_uv.c:261:27: sparse:     expected struct uv_systab *[addressable] [assigned] [toplevel] uv_systab
   arch/x86/platform/uv/bios_uv.c:261:27: sparse:     got void [noderef] __iomem *

vim +/uv_bios_get_master_nasid +175 arch/x86/platform/uv/bios_uv.c

   174	
 > 175	extern s64 uv_bios_get_master_nasid(u64 size, u64 *master_nasid)
   176	{
   177		return uv_bios_call(UV_BIOS_EXTRA, 0, UV_BIOS_EXTRA_MASTER_NASID, 0,
   178					size, (u64)master_nasid);
   179	}
   180	EXPORT_SYMBOL_GPL(uv_bios_get_master_nasid);
   181	
 > 182	extern s64 uv_bios_get_heapsize(u64 nasid, u64 size, u64 *heap_size)
   183	{
   184		return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_GET_HEAPSIZE,
   185					0, size, (u64)heap_size);
   186	}
   187	EXPORT_SYMBOL_GPL(uv_bios_get_heapsize);
   188	
 > 189	extern s64 uv_bios_install_heap(u64 nasid, u64 heap_size, u64 *bios_heap)
   190	{
   191		return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_INSTALL_HEAP,
   192					0, heap_size, (u64)bios_heap);
   193	}
   194	EXPORT_SYMBOL_GPL(uv_bios_install_heap);
   195	
 > 196	extern s64 uv_bios_obj_count(u64 nasid, u64 size, u64 *objcnt)
   197	{
   198		return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_OBJECT_COUNT,
   199					0, size, (u64)objcnt);
   200	}
   201	EXPORT_SYMBOL_GPL(uv_bios_obj_count);
   202	
 > 203	extern s64 uv_bios_enum_objs(u64 nasid, u64 size, u64 *objbuf)
   204	{
   205		return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_ENUM_OBJECTS,
   206					0, size, (u64)objbuf);
   207	}
   208	EXPORT_SYMBOL_GPL(uv_bios_enum_objs);
   209	
 > 210	extern s64 uv_bios_enum_ports(u64 nasid, u64 obj_id, u64 size, u64 *portbuf)
   211	{
   212		return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_ENUM_PORTS,
   213					obj_id, size, (u64)portbuf);
   214	}
   215	EXPORT_SYMBOL_GPL(uv_bios_enum_ports);
   216	
 > 217	extern s64 uv_bios_get_geoinfo(u64 nasid, u64 size, u64 *buf)
   218	{
   219		return uv_bios_call(UV_BIOS_GET_GEOINFO, nasid, (u64)buf, size, 0, 0);
   220	}
   221	EXPORT_SYMBOL_GPL(uv_bios_get_geoinfo);
   222	
 > 223	extern s64 uv_bios_get_pci_topology(u64 size, u64 *buf)
   224	{
   225		return uv_bios_call(UV_BIOS_GET_PCI_TOPOLOGY, (u64)buf, size, 0, 0, 0);
   226	}
   227	EXPORT_SYMBOL_GPL(uv_bios_get_pci_topology);
   228	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
