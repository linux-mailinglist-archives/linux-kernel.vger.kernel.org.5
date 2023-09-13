Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEB179DD39
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 02:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjIMAlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 20:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjIMAlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 20:41:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477C3CF3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 17:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694565680; x=1726101680;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LrWrxy2uxfClc2tV4uw3bdpcemQx2c5yCP3K1yNb6K8=;
  b=TQsFD8PG3OEJl4zqExJeimAPc8/AHOlktzieCQTHcFunKCuTIbLENRLA
   BtIGj4GhuvYPnOIxz/tDBtvHF8Dwq+dpCtIHIOuBI4GY+hoxbfqLR3R+Q
   XpXA+vaVfpCorkS9dhzO0mQelj9c88XQB1USdCcJoGgJZmpSef/Lr+Xmy
   vW7djfAz5NwMaLAJh8bV9npNRbC/OTrcmXLd9BfXfD7Vb3Ox3mANXvx+X
   aKyvaHRuNSmOwu+mk9sULe+iESYJr0DxfKahrbuHJZU05if0MvB4HEhFy
   P/wGqk5mkgYJqx6oq1+Km16Jnaz/qiliz60AUtY/HlYbC8uVrSUNAJ6PP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="409482960"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="409482960"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 17:41:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="743925138"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="743925138"
Received: from lkp-server02.sh.intel.com (HELO 47e905db7d2b) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 12 Sep 2023 17:41:18 -0700
Received: from kbuild by 47e905db7d2b with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgDwS-0000WJ-0O;
        Wed, 13 Sep 2023 00:41:16 +0000
Date:   Wed, 13 Sep 2023 08:40:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgm200.c:32:9: sparse:
 sparse: cast truncates bits from constant value (100000000 becomes 0)
Message-ID: <202309130832.Qg1tPWee-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3669558bdf354cd352be955ef2764cde6a9bf5ec
commit: 6dd9eb95cb6d895be2827b40fd965d9ec2a0747b platform/x86: dell-wmi: Add WMI event 0x0012 0x0003 to the list
date:   1 year ago
config: i386-randconfig-061-20230909 (https://download.01.org/0day-ci/archive/20230913/202309130832.Qg1tPWee-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309130832.Qg1tPWee-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309130832.Qg1tPWee-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgm200.c:32:9: sparse: sparse: cast truncates bits from constant value (100000000 becomes 0)
   drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgm200.c:57:9: sparse: sparse: cast truncates bits from constant value (800000000 becomes 0)

vim +32 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgm200.c

5f300fed645597 Ben Skeggs 2017-11-01  26  
e12cf6ad43888c Ben Skeggs 2017-11-01  27  static void
e12cf6ad43888c Ben Skeggs 2017-11-01  28  gm200_vmm_pgt_sparse(struct nvkm_vmm *vmm,
e12cf6ad43888c Ben Skeggs 2017-11-01  29  		     struct nvkm_mmu_pt *pt, u32 ptei, u32 ptes)
e12cf6ad43888c Ben Skeggs 2017-11-01  30  {
e12cf6ad43888c Ben Skeggs 2017-11-01  31  	/* VALID_FALSE + VOL tells the MMU to treat the PTE as sparse. */
e12cf6ad43888c Ben Skeggs 2017-11-01 @32  	VMM_FO064(pt, vmm, ptei * 8, BIT_ULL(32) /* VOL. */, ptes);
e12cf6ad43888c Ben Skeggs 2017-11-01  33  }
e12cf6ad43888c Ben Skeggs 2017-11-01  34  

:::::: The code at line 32 was first introduced by commit
:::::: e12cf6ad43888c152c3b2edb59525587cd98a227 drm/nouveau/mmu/gm200,gm20b: implement new vmm backend

:::::: TO: Ben Skeggs <bskeggs@redhat.com>
:::::: CC: Ben Skeggs <bskeggs@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
