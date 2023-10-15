Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7D67C97EA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 06:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjJOEsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 00:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjJOEsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 00:48:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E33D9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 21:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697345318; x=1728881318;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nWekX2Qj8+IwOIEXBxYcFbWVxiVUX/wA/uWt88Mcyzw=;
  b=aw4K+GH0a3k3LHuQLUgEx+maOZnx7r2RY34gRta7cPs5iN3fOvy+zlaA
   FsLV26CIRs8iwADG5tThO5GMV736W4iuuuOcBgA3aJ2lXm0oOb+rGF8fq
   aC8/56vdQKc6k1VsG36RN/VL6GKdX5gxOF8RIQo9hh1QjNKKANwrf+azk
   akyIJYW7Q/NwcBZ4seJINdDNc/4p2AsTsoB7TNhRJytU7kmGIe9/lpzGI
   Am+Ve2xcHykOMJclI5wKXZ0O3aldLs8Smgq88MkjGUnFZlH9mq4ymEEJV
   UCgbJ/RPJHqv1/dJUbS3iBeEe2hsHuY+b/CctkWR6tJdegtyGuR+eVaF5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="451842634"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="451842634"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2023 21:48:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="1086655292"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="1086655292"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 14 Oct 2023 21:48:36 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qrt3J-00072d-2k;
        Sun, 15 Oct 2023 04:48:33 +0000
Date:   Sun, 15 Oct 2023 12:48:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shannon Nelson <shannon.nelson@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/amd/pds_core/core.c:156:2-7: WARNING: NULL
 check before some freeing functions is not needed.
Message-ID: <202310151223.hg8OrOsd-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9a3dad63edbe9a2ab2be1e7361a2133f519f855b
commit: ddbcb22055d136f58841c73ca2226dab79eb6101 pds_core: Kconfig and pds_core.rst
date:   6 months ago
config: x86_64-randconfig-103-20231015 (https://download.01.org/0day-ci/archive/20231015/202310151223.hg8OrOsd-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231015/202310151223.hg8OrOsd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310151223.hg8OrOsd-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/amd/pds_core/core.c:156:2-7: WARNING: NULL check before some freeing functions is not needed.
   drivers/net/ethernet/amd/pds_core/core.c:159:2-7: WARNING: NULL check before some freeing functions is not needed.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
