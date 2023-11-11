Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4394E7E8AF6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 13:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjKKMzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 07:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjKKMzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 07:55:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB7E2D7F
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 04:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699707348; x=1731243348;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RYElpEXqXTCYDdqsnylHu1Qq93o3aYs/43B1MrYGmB4=;
  b=QEn6ax3y/bKACx0rn9bg/hodGkZ7iHu+6WOkcdIYuCzbwEUPfTPj/sL6
   DWE4HxSDaA+361C5X4+yQYdWxBUmVebOCl78Ge7dJZ0AChg7WH9f3tNGW
   fE16h6GLyYN8lfIjPZ+yKy358Hs85kVpWdOMtUJHMrOTxIaWkpPNqPMS1
   K9OJZ5lzsYJqWnXqyKp5giFMETKVwnfKB/b1nzcW4Vd6Kld7sWFL3l2WW
   uDsEOZOQNv8YiSlYm+XMzkvJ86Oa29tBhEB7/3fwY+rdpPzA2n6UbyDr4
   QNxPxnzbRr6i82kYzJvGf10g3uyQDd9BwREbyzKTy+NSlChx6VXlW+amR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="369606650"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="369606650"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 04:55:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="740374230"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="740374230"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 11 Nov 2023 04:55:46 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1nWa-000ASS-0U;
        Sat, 11 Nov 2023 12:55:44 +0000
Date:   Sat, 11 Nov 2023 20:55:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Peter Stuge <peter@stuge.se>
Subject: drivers/gpu/drm/gud/gud_drv.c:95:28: sparse: sparse: cast to
 restricted __le32
Message-ID: <202311112013.3oeb6fZG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3ca112b71f35dd5d99fc4571a56b5fc6f0c15814
commit: 40e1a70b4aedf2859a1829991b48ef0ebe650bf2 drm: Add GUD USB Display driver
date:   2 years, 8 months ago
config: i386-randconfig-062-20230912 (https://download.01.org/0day-ci/archive/20231111/202311112013.3oeb6fZG-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311112013.3oeb6fZG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311112013.3oeb6fZG-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/gud/gud_drv.c:95:28: sparse: sparse: cast to restricted __le32
>> drivers/gpu/drm/gud/gud_drv.c:95:17: sparse: sparse: restricted __le32 degrades to integer

vim +95 drivers/gpu/drm/gud/gud_drv.c

    76	
    77	static int gud_get_display_descriptor(struct usb_interface *intf,
    78					      struct gud_display_descriptor_req *desc)
    79	{
    80		void *buf;
    81		int ret;
    82	
    83		buf = kmalloc(sizeof(*desc), GFP_KERNEL);
    84		if (!buf)
    85			return -ENOMEM;
    86	
    87		ret = gud_usb_control_msg(intf, true, GUD_REQ_GET_DESCRIPTOR, 0, buf, sizeof(*desc));
    88		memcpy(desc, buf, sizeof(*desc));
    89		kfree(buf);
    90		if (ret < 0)
    91			return ret;
    92		if (ret != sizeof(*desc))
    93			return -EIO;
    94	
  > 95		if (desc->magic != le32_to_cpu(GUD_DISPLAY_MAGIC))
    96			return -ENODATA;
    97	
    98		DRM_DEV_DEBUG_DRIVER(&intf->dev,
    99				     "version=%u flags=0x%x compression=0x%x max_buffer_size=%u\n",
   100				     desc->version, le32_to_cpu(desc->flags), desc->compression,
   101				     le32_to_cpu(desc->max_buffer_size));
   102	
   103		if (!desc->version || !desc->max_width || !desc->max_height ||
   104		    le32_to_cpu(desc->min_width) > le32_to_cpu(desc->max_width) ||
   105		    le32_to_cpu(desc->min_height) > le32_to_cpu(desc->max_height))
   106			return -EINVAL;
   107	
   108		return 0;
   109	}
   110	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
