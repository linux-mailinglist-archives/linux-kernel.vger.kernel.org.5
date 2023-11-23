Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767E37F58FE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343893AbjKWHR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjKWHR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:17:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D47DE7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 23:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700723853; x=1732259853;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4PXxc0t+++cE6UP8C+/3s6Jl5Zp1vVRFCGZntxVr4Jk=;
  b=JVCsu13ovtVT05YMPBVx3khXCK6JqH5hLlmTYFYBuzllXViP9kFI7yZW
   U+ic+vPy29eG0KQxhT/JqejG5RSnqNgT3SCTK34iLH3gO0mbWltpnJYCL
   SnXmHMDh6pjpxRV+5M7bZuIDJx6l2qXhKwglAdakWaISYmvgb+B3AGY6h
   nJpaoOmV0ajV0VY+uVuAhgestvqmOBEUyyNd6k/H3/uShzpkHZjbzJkvX
   SYtp8wGJdo8ryGVVN8TilNeOfhRUwTxKUazhqitKbNgtl5gUDA1SlrB2R
   TrVecRmufV/x7Ay9ilQdKdtLb1NQmIeKpH8IrWqK7VPOOVCKwLDanmVhC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456548940"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="456548940"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 23:17:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="743523280"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="743523280"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Nov 2023 23:17:31 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r63xp-0001Kt-1X;
        Thu, 23 Nov 2023 07:17:29 +0000
Date:   Thu, 23 Nov 2023 15:16:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Robert Jones <rjones@gateworks.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: drivers/iio/imu/fxos8700_spi.c:34:36: warning: 'fxos8700_acpi_match'
 defined but not used
Message-ID: <202311231427.vEQAuxvI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9b6de136b5f0158c60844f85286a593cb70fb364
commit: 84e5ddd5c46ea3bf0cad670da32028994cad5936 iio: imu: Add support for the FXOS8700 IMU
date:   4 years, 1 month ago
config: x86_64-buildonly-randconfig-001-20231012 (https://download.01.org/0day-ci/archive/20231123/202311231427.vEQAuxvI-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231123/202311231427.vEQAuxvI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311231427.vEQAuxvI-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/imu/fxos8700_spi.c:34:36: warning: 'fxos8700_acpi_match' defined but not used [-Wunused-const-variable=]
      34 | static const struct acpi_device_id fxos8700_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~~~


vim +/fxos8700_acpi_match +34 drivers/iio/imu/fxos8700_spi.c

    33	
  > 34	static const struct acpi_device_id fxos8700_acpi_match[] = {
    35		{"FXOS8700", 0},
    36		{ }
    37	};
    38	MODULE_DEVICE_TABLE(acpi, fxos8700_acpi_match);
    39	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
