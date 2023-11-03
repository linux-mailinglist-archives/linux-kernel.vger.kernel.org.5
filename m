Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490467E0784
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjKCRgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjKCRga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:36:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C73D44
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 10:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699032984; x=1730568984;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8nJxPpdWo23mUiPSbv26x2/L9tiHfBG+mDDAc7c42Bc=;
  b=UbGE7xfwCsYk8yZxfzL0qRNItq1tm+IMQbd7UWtSW/UdP9c9WfCduVsr
   KYKNBMp+JoY9KeHAaeY/sZWPDbdgAZnRlrHPEV4GxXvDKK4mSbbYbJ4oZ
   Kss2m2uEbTXmfLIli2GH0g1ZtB1rU075HwditGZdlXea4atIloA7/vllH
   Obo148aD8sIZO5nBp9p/XRsyb2w3SyXCZLqpZItKxM1iMDXOeVk6j/IsT
   1fCTiWDkGe5Vnq9ksqHdbSOBXvgsd/kjP/ARC6OYuLVGY5XebS7q0eA0h
   i8a6fge9YIgXUV8qQjSeN2LaLkhgg5Qq/AwHzmU/2/JfCJchDoFyf4boA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="387879592"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="387879592"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 10:36:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="738138407"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="738138407"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Nov 2023 10:36:10 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyy5X-0002lj-2w;
        Fri, 03 Nov 2023 17:36:07 +0000
Date:   Sat, 4 Nov 2023 01:36:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shannon Nelson <shannon.nelson@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: drivers/vdpa/pds/debugfs.c:269:49: warning: '%02d' directive output
 may be truncated writing between 2 and 11 bytes into a region of size 6
Message-ID: <202311040109.RfgJoE7L-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8f6f76a6a29f36d2f3e4510d0bde5046672f6924
commit: 9a8864d2a8dc5c49acd66284fd382871d99b5db8 pds_vdpa: pds_vdps.rst and Kconfig
date:   4 months ago
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231104/202311040109.RfgJoE7L-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311040109.RfgJoE7L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311040109.RfgJoE7L-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/vdpa/pds/debugfs.c: In function 'pds_vdpa_debugfs_add_vdpadev':
>> drivers/vdpa/pds/debugfs.c:269:49: warning: '%02d' directive output may be truncated writing between 2 and 11 bytes into a region of size 6 [-Wformat-truncation=]
     269 |                 snprintf(name, sizeof(name), "vq%02d", i);
         |                                                 ^~~~
   drivers/vdpa/pds/debugfs.c:269:46: note: directive argument in the range [-2147483641, 254]
     269 |                 snprintf(name, sizeof(name), "vq%02d", i);
         |                                              ^~~~~~~~
   drivers/vdpa/pds/debugfs.c:269:17: note: 'snprintf' output between 5 and 14 bytes into a destination of size 8
     269 |                 snprintf(name, sizeof(name), "vq%02d", i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +269 drivers/vdpa/pds/debugfs.c

151cc834f3ddafe Shannon Nelson 2023-05-19  259  
151cc834f3ddafe Shannon Nelson 2023-05-19  260  void pds_vdpa_debugfs_add_vdpadev(struct pds_vdpa_aux *vdpa_aux)
151cc834f3ddafe Shannon Nelson 2023-05-19  261  {
151cc834f3ddafe Shannon Nelson 2023-05-19  262  	int i;
151cc834f3ddafe Shannon Nelson 2023-05-19  263  
151cc834f3ddafe Shannon Nelson 2023-05-19  264  	debugfs_create_file("config", 0400, vdpa_aux->dentry, vdpa_aux->pdsv, &config_fops);
151cc834f3ddafe Shannon Nelson 2023-05-19  265  
151cc834f3ddafe Shannon Nelson 2023-05-19  266  	for (i = 0; i < vdpa_aux->pdsv->num_vqs; i++) {
151cc834f3ddafe Shannon Nelson 2023-05-19  267  		char name[8];
151cc834f3ddafe Shannon Nelson 2023-05-19  268  
151cc834f3ddafe Shannon Nelson 2023-05-19 @269  		snprintf(name, sizeof(name), "vq%02d", i);
151cc834f3ddafe Shannon Nelson 2023-05-19  270  		debugfs_create_file(name, 0400, vdpa_aux->dentry,
151cc834f3ddafe Shannon Nelson 2023-05-19  271  				    &vdpa_aux->pdsv->vqs[i], &vq_fops);
151cc834f3ddafe Shannon Nelson 2023-05-19  272  	}
151cc834f3ddafe Shannon Nelson 2023-05-19  273  }
151cc834f3ddafe Shannon Nelson 2023-05-19  274  

:::::: The code at line 269 was first introduced by commit
:::::: 151cc834f3ddafec869269fe48036460d920d08a pds_vdpa: add support for vdpa and vdpamgmt interfaces

:::::: TO: Shannon Nelson <shannon.nelson@amd.com>
:::::: CC: Michael S. Tsirkin <mst@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
