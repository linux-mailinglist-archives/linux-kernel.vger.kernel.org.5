Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549AF7E182C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 01:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjKFAge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 19:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjKFAgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 19:36:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC7CE0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 16:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699230990; x=1730766990;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=brHf+JZKVeK3dWeM7VKqangfUHVTV8Kw0OD8i85pkBY=;
  b=PgK18tuDSieUhGBA2OH/kol6xkWfMjoJ6vTsNFH7phKqotomL3Wn/1n7
   qFdRSjCc89aMkJ6T5oxN1zvB7m9FaMkfa4B+2OSDjII+jfTEh5kVz0vCV
   2sywlqXfyOHuAqndLfpa7fFn7svN0h6IPeXDHNeQGDI3Qivy14IXMrlL/
   Cr++rhST7vQs7Ugo7sygI1Yx/MeK31wXKuUGFS6FWxabXzYZYOxJbpF91
   QIx3ExYbdYTY9cqJzbsY7EOklM9Zyi98WIOGpcHbsEzz67Mtnw2OQU2II
   J259SXjYoydIgFVyDe6Z9pbVJ8bpy3USZ7TB8RGUUyIgPnHgyCmo5hM8+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="393084897"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="393084897"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 16:36:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="10294116"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 05 Nov 2023 16:36:28 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qznbO-0005vk-0k;
        Mon, 06 Nov 2023 00:36:26 +0000
Date:   Mon, 6 Nov 2023 08:35:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ye Xiang <xiang.ye@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>
Subject: drivers/hid/intel-ish-hid/ishtp/bus.c:853: warning: Function
 parameter or member 'dev' not described in 'ishtp_wait_resume'
Message-ID: <202311060843.dXENYlGc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   77fa2fbe87fc605c4bfa87dff87be9bfded0e9a3
commit: e48bf29cf9d6d60d810e2af71e54b71a324094e0 HID: intel-ish-hid: use async resume function
date:   2 years, 4 months ago
config: x86_64-randconfig-004-20230909 (https://download.01.org/0day-ci/archive/20231106/202311060843.dXENYlGc-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311060843.dXENYlGc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311060843.dXENYlGc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hid/intel-ish-hid/ishtp/bus.c:853: warning: Function parameter or member 'dev' not described in 'ishtp_wait_resume'


vim +853 drivers/hid/intel-ish-hid/ishtp/bus.c

   844	
   845	/**
   846	 * ishtp_wait_resume() - Wait for IPC resume
   847	 *
   848	 * Wait for IPC resume
   849	 *
   850	 * Return: resume complete or not
   851	 */
   852	bool ishtp_wait_resume(struct ishtp_device *dev)
 > 853	{
   854		/* 50ms to get resume response */
   855		#define WAIT_FOR_RESUME_ACK_MS		50
   856	
   857		/* Waiting to get resume response */
   858		if (dev->resume_flag)
   859			wait_event_interruptible_timeout(dev->resume_wait,
   860							 !dev->resume_flag,
   861							 msecs_to_jiffies(WAIT_FOR_RESUME_ACK_MS));
   862	
   863		return (!dev->resume_flag);
   864	}
   865	EXPORT_SYMBOL_GPL(ishtp_wait_resume);
   866	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
