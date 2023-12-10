Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046D880BC08
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 16:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjLJPfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 10:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjLJPfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 10:35:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32FDF3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702222536; x=1733758536;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gFbx6xzUXM1eZfjbY7RukjNbO2y8jdVKx5iTIVT56/s=;
  b=R9Wtyr0Vud0Z4F0563q2cW7F4uwYYJeqDw0gplcnHusiRfivtuEz+wyx
   waPCMbSUCm6e5cfYhu+8ucqoke0SBiNxe1SuH9Ov2iMcpMeEQxggyd3Bp
   t3uqZbUN/MjRTHxCnXgo/6yWRFqgvvNABCKMt4J9wFsnmRN3EC+r5TmRn
   F4zA5A3XwKfEKUrJB8gqfxPIsI5/nLTRqK3M6eqIubzbGWArn8gL3JoE0
   azzhZigiC4qv/p4G3jYp7SW+H1djwS0FBwM5Ekw6RTq+pZiG5ZaeZQjt1
   RU/tI5h0vy5EPBdOV3fFGdMkv6v7FM1ECXCQiZ/u8ArtA4hcO1k5P60BK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="374718857"
X-IronPort-AV: E=Sophos;i="6.04,266,1695711600"; 
   d="scan'208";a="374718857"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 07:35:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="748956943"
X-IronPort-AV: E=Sophos;i="6.04,266,1695711600"; 
   d="scan'208";a="748956943"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 10 Dec 2023 07:35:34 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCLq8-000Gym-1X;
        Sun, 10 Dec 2023 15:35:32 +0000
Date:   Sun, 10 Dec 2023 23:35:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Markus Pargmann <mpa@pengutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: drivers/iio/gyro/bmg160_i2c.c:41:36: warning: 'bmg160_acpi_match'
 defined but not used
Message-ID: <202312102310.LXEzAWcy-lkp@intel.com>
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
head:   c527f5606aa545233a4d2c6d5c636ed82b8633ef
commit: 13426454b6493a847cebe276fb1ec3a7f1d48d0e iio: bmg160: Separate i2c and core driver
date:   8 years ago
config: m68k-randconfig-c031-20230421 (https://download.01.org/0day-ci/archive/20231210/202312102310.LXEzAWcy-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231210/202312102310.LXEzAWcy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312102310.LXEzAWcy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:8,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:17,
                    from include/linux/i2c.h:30,
                    from drivers/iio/gyro/bmg160_i2c.c:1:
   include/linux/log2.h:22:1: warning: ignoring attribute 'noreturn' because it conflicts with attribute 'const' [-Wattributes]
      22 | int ____ilog2_NaN(void);
         | ^~~
>> drivers/iio/gyro/bmg160_i2c.c:41:36: warning: 'bmg160_acpi_match' defined but not used [-Wunused-const-variable=]
      41 | static const struct acpi_device_id bmg160_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~


vim +/bmg160_acpi_match +41 drivers/iio/gyro/bmg160_i2c.c

    40	
  > 41	static const struct acpi_device_id bmg160_acpi_match[] = {
    42		{"BMG0160", 0},
    43		{"BMI055B", 0},
    44		{},
    45	};
    46	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
