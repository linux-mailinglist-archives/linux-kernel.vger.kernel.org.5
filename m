Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13473809438
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbjLGVbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444206AbjLGVap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:30:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E307A326D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 13:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701984418; x=1733520418;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z6WKhviJB5923Gs0f2xtC/iDHT5DEJBLNTzejBz7Des=;
  b=X9lX4FbmMJmQmUFcH1n8l41nV6+2MPwAHf+segZ6QZQTChHU3m87Pt0i
   ys1MCcFQxbLft7E9DwmubJACV5lnEoRbHpjVSlrvinLajsEFTwEUrmote
   DZAPaWUIwYdt4/alj70Fsh688K0cd4LNvUiznOxy4WLwn47KO7lVK6lsb
   HudBUbbYDx+GGRgvz/w+c57zIonKerxfVvKjEjQJ6ltN7j3ps8M7knXvF
   YMU/myKQBPqcZJ68od9QVdmhbGPMONfDVBJKnZP7KYdIVSD6r3Wezlkj1
   adhiFWRxTfxEHQA5OHaBEAOEsCTorr3NiMKTOd5bxjjX0SwcNAhP261Zp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="480509678"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="480509678"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 13:26:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="915713114"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="915713114"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 07 Dec 2023 13:26:56 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBLtV-000CrX-2u;
        Thu, 07 Dec 2023 21:26:53 +0000
Date:   Fri, 8 Dec 2023 05:26:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: drivers/vhost/vringh.c:567:18: sparse: sparse: cast to restricted
 __virtio16
Message-ID: <202312080502.SyHDnIDC-lkp@intel.com>
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
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: d877322bc1adcab9850732275670409e8bcca4c4 openrisc: Fix issue with get_user for 64-bit values
date:   3 years, 3 months ago
config: openrisc-randconfig-r131-20231102 (https://download.01.org/0day-ci/archive/20231208/202312080502.SyHDnIDC-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231208/202312080502.SyHDnIDC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312080502.SyHDnIDC-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/vhost/vringh.c:567:18: sparse: sparse: cast to restricted __virtio16
>> drivers/vhost/vringh.c:567:18: sparse: sparse: cast to restricted __virtio16
>> drivers/vhost/vringh.c:567:18: sparse: sparse: cast to restricted __virtio16
>> drivers/vhost/vringh.c:567:18: sparse: sparse: restricted __virtio16 degrades to integer
>> drivers/vhost/vringh.c:567:18: sparse: sparse: restricted __virtio16 degrades to integer
>> drivers/vhost/vringh.c:567:18: sparse: sparse: cast to restricted __virtio16
>> drivers/vhost/vringh.c:567:18: sparse: sparse: cast to restricted __virtio16

vim +567 drivers/vhost/vringh.c

f87d0fbb579818 Rusty Russell      2013-03-20  562  
f87d0fbb579818 Rusty Russell      2013-03-20  563  /* Userspace access helpers: in this case, addresses are really userspace. */
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12  564  static inline int getu16_user(const struct vringh *vrh, u16 *val, const __virtio16 *p)
f87d0fbb579818 Rusty Russell      2013-03-20  565  {
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12  566  	__virtio16 v = 0;
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12 @567  	int rc = get_user(v, (__force __virtio16 __user *)p);
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12  568  	*val = vringh16_to_cpu(vrh, v);
b9f7ac8c72894c Michael S. Tsirkin 2014-12-12  569  	return rc;
f87d0fbb579818 Rusty Russell      2013-03-20  570  }
f87d0fbb579818 Rusty Russell      2013-03-20  571  

:::::: The code at line 567 was first introduced by commit
:::::: b9f7ac8c72894c19bf258a54ecaa708df4ffbe80 vringh: update for virtio 1.0 APIs

:::::: TO: Michael S. Tsirkin <mst@redhat.com>
:::::: CC: Michael S. Tsirkin <mst@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
