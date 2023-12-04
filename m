Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0232B803E92
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjLDTlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjLDTlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:41:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3D4101
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701718885; x=1733254885;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Cn3HF3BLDHxc0DqiqH1kl0D43aZ0X1U8VI8mw9YCNec=;
  b=J/FOTW6S0BdpX/agEX6ty+rh5ibgGaOA8zsLgMnoIgK2nwVh6247Z/aG
   EGOcVTuqm/3PY1dAOrBuAzyq8rhFOy17uPODI1BeRNGvOXncgDt+gZP4H
   47oSOmtxUwFmX72zqwN7GaW/QkjqqEMagfFIOsxONQHXROadfm7Qv+JXQ
   D398L2E5x51d+/BHq7UyVFKS/J4yZk7h1k2k8Wk7EBCikDSv8JN+y/7XZ
   5oRiNtEUHHTuWXGbxyuBkv2WrR1zCNfcMKSe+KZzj66DrRGQe8KMlzk3T
   2KDf/VXmH8nh0YFZHNI86YcOMzO4zKKQa6k8Kyn11TlMG4L9TEtAElcru
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="460281326"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="460281326"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 11:41:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="720426368"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="720426368"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 04 Dec 2023 11:41:23 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAEoK-00081m-2e;
        Mon, 04 Dec 2023 19:41:04 +0000
Date:   Tue, 5 Dec 2023 03:40:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lyude Paul <lyude@redhat.com>
Subject: drivers/gpu/drm/nouveau/nouveau_backlight.c:54:69: warning: '%d'
 directive output may be truncated writing between 1 and 10 bytes into a
 region of size 3
Message-ID: <202312050324.0kv4PnfZ-lkp@intel.com>
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
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: ab244be47a8f111bc82496a8a20c907236e37f95 drm/nouveau: Fix a potential theorical leak in nouveau_get_backlight_name()
date:   1 year, 7 months ago
config: x86_64-buildonly-randconfig-005-20230918 (https://download.01.org/0day-ci/archive/20231205/202312050324.0kv4PnfZ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312050324.0kv4PnfZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312050324.0kv4PnfZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/nouveau/nouveau_backlight.c: In function 'nouveau_backlight_init':
>> drivers/gpu/drm/nouveau/nouveau_backlight.c:54:69: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 3 [-Wformat-truncation=]
      54 |                 snprintf(backlight_name, BL_NAME_SIZE, "nv_backlight%d", nb);
         |                                                                     ^~
   In function 'nouveau_get_backlight_name',
       inlined from 'nouveau_backlight_init' at drivers/gpu/drm/nouveau/nouveau_backlight.c:408:7:
   drivers/gpu/drm/nouveau/nouveau_backlight.c:54:56: note: directive argument in the range [1, 2147483647]
      54 |                 snprintf(backlight_name, BL_NAME_SIZE, "nv_backlight%d", nb);
         |                                                        ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/nouveau/nouveau_backlight.c:54:17: note: 'snprintf' output between 14 and 23 bytes into a destination of size 15
      54 |                 snprintf(backlight_name, BL_NAME_SIZE, "nv_backlight%d", nb);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +54 drivers/gpu/drm/nouveau/nouveau_backlight.c

db1a0ae21461af Pierre Moreau      2016-12-08  44  
db1a0ae21461af Pierre Moreau      2016-12-08  45  static bool
6d757753cef8d5 Lyude Paul         2018-09-06  46  nouveau_get_backlight_name(char backlight_name[BL_NAME_SIZE],
6d757753cef8d5 Lyude Paul         2018-09-06  47  			   struct nouveau_backlight *bl)
db1a0ae21461af Pierre Moreau      2016-12-08  48  {
ab244be47a8f11 Christophe JAILLET 2022-02-09  49  	const int nb = ida_alloc_max(&bl_ida, 99, GFP_KERNEL);
ab244be47a8f11 Christophe JAILLET 2022-02-09  50  
ab244be47a8f11 Christophe JAILLET 2022-02-09  51  	if (nb < 0)
db1a0ae21461af Pierre Moreau      2016-12-08  52  		return false;
db1a0ae21461af Pierre Moreau      2016-12-08  53  	if (nb > 0)
db1a0ae21461af Pierre Moreau      2016-12-08 @54  		snprintf(backlight_name, BL_NAME_SIZE, "nv_backlight%d", nb);
db1a0ae21461af Pierre Moreau      2016-12-08  55  	else
db1a0ae21461af Pierre Moreau      2016-12-08  56  		snprintf(backlight_name, BL_NAME_SIZE, "nv_backlight");
6d757753cef8d5 Lyude Paul         2018-09-06  57  	bl->id = nb;
db1a0ae21461af Pierre Moreau      2016-12-08  58  	return true;
db1a0ae21461af Pierre Moreau      2016-12-08  59  }
db1a0ae21461af Pierre Moreau      2016-12-08  60  

:::::: The code at line 54 was first introduced by commit
:::::: db1a0ae21461afa4bc435651a6dd55e0e6ef4a8b drm/nouveau/bl: Assign different names to interfaces

:::::: TO: Pierre Moreau <pierre.morrow@free.fr>
:::::: CC: Ben Skeggs <bskeggs@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
