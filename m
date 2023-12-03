Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A2F802343
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbjLCLmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjLCLmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:42:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACBAFF
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701603740; x=1733139740;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vjatdcq/YDJCzs0+IFKQYa5LXh2dObZqbXdr3Z3PTnM=;
  b=TytMEFVwgtLj00pVTPwpvnrQRvLHmy6cXBBgK03eSBofm4q1P5sOPJY5
   9KALectqMA8YeZRSqA47l1oHdYlOdDJa/IYuzWouNkieMjsW/NcqWSW4K
   wniWCqUxAxNUccRqSMhiwutn2xfdz8DNdfjUdR46a6FyFbmKwDQyhUCpL
   gDZV/5NDqPMTYJELMZSTFqgwgsuh8JcrCrMuoFrn4kquRUuCDkd/b0zhg
   /0wcohHmoHyo97d82VCMpGtsIMh7RWGwzmibxzf0lkKhqUwKMdinx4Zhs
   YNOBGvFWii1QWx/m0NjRJcapKnI3bZ8kPF9qm2zF2fzVwz0YWVjkWK3XC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="424805340"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="424805340"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 03:42:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="914144297"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="914144297"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 03 Dec 2023 03:42:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9krZ-0006bz-1E;
        Sun, 03 Dec 2023 11:42:17 +0000
Date:   Sun, 3 Dec 2023 19:42:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: drivers/iio/dac/ad5755.c:786:34: warning: 'ad5755_of_match' defined
 but not used
Message-ID: <202312031846.QS2OB5i6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   968f35f4ab1c0966ceb39af3c89f2e24afedf878
commit: c947459979c6c9c8aff9c9b5027b31dbf8055106 iio: ad5755: add support for dt bindings
date:   7 years ago
config: x86_64-randconfig-015-20231009 (https://download.01.org/0day-ci/archive/20231203/202312031846.QS2OB5i6-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231203/202312031846.QS2OB5i6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312031846.QS2OB5i6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kobject.h:21,
                    from include/linux/device.h:17,
                    from drivers/iio/dac/ad5755.c:9:
   include/linux/sysfs.h: In function 'sysfs_get_dirent':
   include/linux/sysfs.h:517:44: warning: pointer targets in passing argument 2 of 'kernfs_find_and_get' differ in signedness [-Wpointer-sign]
     517 |         return kernfs_find_and_get(parent, name);
         |                                            ^~~~
         |                                            |
         |                                            const unsigned char *
   In file included from include/linux/sysfs.h:15:
   include/linux/kernfs.h:437:57: note: expected 'const char *' but argument is of type 'const unsigned char *'
     437 | kernfs_find_and_get(struct kernfs_node *kn, const char *name)
         |                                             ~~~~~~~~~~~~^~~~
   drivers/iio/dac/ad5755.c: At top level:
>> drivers/iio/dac/ad5755.c:786:34: warning: 'ad5755_of_match' defined but not used [-Wunused-const-variable=]
     786 | static const struct of_device_id ad5755_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~


vim +/ad5755_of_match +786 drivers/iio/dac/ad5755.c

   785	
 > 786	static const struct of_device_id ad5755_of_match[] = {
   787		{ .compatible = "adi,ad5755" },
   788		{ .compatible = "adi,ad5755-1" },
   789		{ .compatible = "adi,ad5757" },
   790		{ .compatible = "adi,ad5735" },
   791		{ .compatible = "adi,ad5737" },
   792		{ }
   793	};
   794	MODULE_DEVICE_TABLE(of, ad5755_of_match);
   795	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
