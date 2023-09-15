Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DF57A2991
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbjIOVgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237722AbjIOVfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:35:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605CBB8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694813734; x=1726349734;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/ogXUJOmjDW/bpJ8jXZiRIzF7x9Aedll9nbBHLvWLCQ=;
  b=mXF5lRAORi0wVMUPaMbBX0n3Ct7emVm+vuz5ybyQHZp3jRRdiSHfgTZX
   StwmlXm2FA1YJTEpB+xHf0DUfdbi4Scz9faD9X3mrP/y0mvxJvkm2ZFZG
   LY3sqoDqjv2kHUityqeWAXL3IvRYBCR1isBRJS1hg0YwgfRnlisyMBrKt
   7nEsiGRs46Ehk7gvBQHVQRAHClSvDPt3pLv+R+cmtPb5jhywnXSM7e8+l
   3hqVBPSt+9ehmfBxF1XJ6fTlu6HvUsHdDkQL7ac07Z1QiXHczzDBdo8te
   TS+7E+YL09aqJcfe4Gyh2znhWe+IsPZRwXEAGXTP4x4Sd8rXAyYmmrRmX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="443417141"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="443417141"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 14:35:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="748326764"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="748326764"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 15 Sep 2023 14:35:32 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qhGTJ-0003Tg-2m;
        Fri, 15 Sep 2023 21:35:29 +0000
Date:   Sat, 16 Sep 2023 05:34:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: drivers/iommu/ipmmu-vmsa.c:946:34: warning: 'ipmmu_of_ids' defined
 but not used
Message-ID: <202309160540.Y5aiYqMR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9608c7b729e29c177525006711966ae0fd399b11
commit: b87d6d7fa405e23478f1e1dff6d66b5a533a5433 iommu/ipmmu-vmsa: Clean up bus_set_iommu()
date:   1 year ago
config: um-randconfig-002-20230916 (https://download.01.org/0day-ci/archive/20230916/202309160540.Y5aiYqMR-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230916/202309160540.Y5aiYqMR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309160540.Y5aiYqMR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iommu/ipmmu-vmsa.c:946:34: warning: 'ipmmu_of_ids' defined but not used [-Wunused-const-variable=]
     946 | static const struct of_device_id ipmmu_of_ids[] = {
         |                                  ^~~~~~~~~~~~


vim +/ipmmu_of_ids +946 drivers/iommu/ipmmu-vmsa.c

7a62ced8ebd0e1 Yoshihiro Shimoda       2021-09-07  945  
33f3ac9b511612 Magnus Damm             2017-10-16 @946  static const struct of_device_id ipmmu_of_ids[] = {
33f3ac9b511612 Magnus Damm             2017-10-16  947  	{
33f3ac9b511612 Magnus Damm             2017-10-16  948  		.compatible = "renesas,ipmmu-vmsa",
33f3ac9b511612 Magnus Damm             2017-10-16  949  		.data = &ipmmu_features_default,
60fb0083c9d43b Fabrizio Castro         2018-08-23  950  	}, {
60fb0083c9d43b Fabrizio Castro         2018-08-23  951  		.compatible = "renesas,ipmmu-r8a774a1",
60fb0083c9d43b Fabrizio Castro         2018-08-23  952  		.data = &ipmmu_features_rcar_gen3,
757f26a3a9ec2c Biju Das                2019-09-27  953  	}, {
757f26a3a9ec2c Biju Das                2019-09-27  954  		.compatible = "renesas,ipmmu-r8a774b1",
757f26a3a9ec2c Biju Das                2019-09-27  955  		.data = &ipmmu_features_rcar_gen3,
b6d39cd82241bf Fabrizio Castro         2018-12-13  956  	}, {
b6d39cd82241bf Fabrizio Castro         2018-12-13  957  		.compatible = "renesas,ipmmu-r8a774c0",
b6d39cd82241bf Fabrizio Castro         2018-12-13  958  		.data = &ipmmu_features_rcar_gen3,
4b2aa7a6f9b793 Marian-Cristian Rotariu 2020-07-14  959  	}, {
4b2aa7a6f9b793 Marian-Cristian Rotariu 2020-07-14  960  		.compatible = "renesas,ipmmu-r8a774e1",
4b2aa7a6f9b793 Marian-Cristian Rotariu 2020-07-14  961  		.data = &ipmmu_features_rcar_gen3,
58b8e8bf409236 Magnus Damm             2017-10-16  962  	}, {
58b8e8bf409236 Magnus Damm             2017-10-16  963  		.compatible = "renesas,ipmmu-r8a7795",
0b8ac1409641e1 Magnus Damm             2018-06-14  964  		.data = &ipmmu_features_rcar_gen3,
0b8ac1409641e1 Magnus Damm             2018-06-14  965  	}, {
0b8ac1409641e1 Magnus Damm             2018-06-14  966  		.compatible = "renesas,ipmmu-r8a7796",
0b8ac1409641e1 Magnus Damm             2018-06-14  967  		.data = &ipmmu_features_rcar_gen3,
17fe1618163980 Yoshihiro Shimoda       2020-06-11  968  	}, {
17fe1618163980 Yoshihiro Shimoda       2020-06-11  969  		.compatible = "renesas,ipmmu-r8a77961",
17fe1618163980 Yoshihiro Shimoda       2020-06-11  970  		.data = &ipmmu_features_rcar_gen3,
98dbffd39a6513 Jacopo Mondi            2018-06-14  971  	}, {
98dbffd39a6513 Jacopo Mondi            2018-06-14  972  		.compatible = "renesas,ipmmu-r8a77965",
98dbffd39a6513 Jacopo Mondi            2018-06-14  973  		.data = &ipmmu_features_rcar_gen3,
3701c123e1c13c Simon Horman            2018-06-14  974  	}, {
3701c123e1c13c Simon Horman            2018-06-14  975  		.compatible = "renesas,ipmmu-r8a77970",
3701c123e1c13c Simon Horman            2018-06-14  976  		.data = &ipmmu_features_rcar_gen3,
1cdeb52e5c245b Nikita Yushchenko       2021-09-23  977  	}, {
1cdeb52e5c245b Nikita Yushchenko       2021-09-23  978  		.compatible = "renesas,ipmmu-r8a77980",
1cdeb52e5c245b Nikita Yushchenko       2021-09-23  979  		.data = &ipmmu_features_rcar_gen3,
b0c32912150565 Hai Nguyen Pham         2018-10-17  980  	}, {
b0c32912150565 Hai Nguyen Pham         2018-10-17  981  		.compatible = "renesas,ipmmu-r8a77990",
b0c32912150565 Hai Nguyen Pham         2018-10-17  982  		.data = &ipmmu_features_rcar_gen3,
3701c123e1c13c Simon Horman            2018-06-14  983  	}, {
3701c123e1c13c Simon Horman            2018-06-14  984  		.compatible = "renesas,ipmmu-r8a77995",
3701c123e1c13c Simon Horman            2018-06-14  985  		.data = &ipmmu_features_rcar_gen3,
7a62ced8ebd0e1 Yoshihiro Shimoda       2021-09-07  986  	}, {
7a62ced8ebd0e1 Yoshihiro Shimoda       2021-09-07  987  		.compatible = "renesas,ipmmu-r8a779a0",
ae684caf465b7d Yoshihiro Shimoda       2022-02-08  988  		.data = &ipmmu_features_rcar_gen4,
ae684caf465b7d Yoshihiro Shimoda       2022-02-08  989  	}, {
9f7d09fe23a011 Yoshihiro Shimoda       2022-06-17  990  		.compatible = "renesas,rcar-gen4-ipmmu-vmsa",
ae684caf465b7d Yoshihiro Shimoda       2022-02-08  991  		.data = &ipmmu_features_rcar_gen4,
33f3ac9b511612 Magnus Damm             2017-10-16  992  	}, {
33f3ac9b511612 Magnus Damm             2017-10-16  993  		/* Terminator */
33f3ac9b511612 Magnus Damm             2017-10-16  994  	},
33f3ac9b511612 Magnus Damm             2017-10-16  995  };
33f3ac9b511612 Magnus Damm             2017-10-16  996  

:::::: The code at line 946 was first introduced by commit
:::::: 33f3ac9b511612153bae1d328b0c84c0367cd08d iommu/ipmmu-vmsa: Introduce features, break out alias

:::::: TO: Magnus Damm <damm+renesas@opensource.se>
:::::: CC: Alex Williamson <alex.williamson@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
