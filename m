Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D057BD110
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 00:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344751AbjJHW51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 18:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjJHW50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 18:57:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48F4A3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 15:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696805845; x=1728341845;
  h=date:from:to:cc:subject:message-id;
  bh=g92GmLArgSK0/hN40MVsgP/cib4wYh8Fcne4lb6DCfc=;
  b=R09gD93ChMyOgLU/cyNCdCF0sLTWqv3p6oIgLiQOeQSVh6SnVHHKkwKS
   hzMP5QCUdlt27VBVKUJgk0N6aJASw54qhkwa3ihDA4oS6OgI+LhutHlZz
   Br2m194OFU70NymJhtScbTvo2bTA/adv+wewh1h6WvHq5/bbzYxDTVjLx
   j321gbYfuSUMbnd+HTGtyCvog7V2k4jbXbOfEhQqtYsI4wMjsarOmD9L5
   +lDsPCR65UoX9pZ8nvAnJktXBOfNGh+axsU7b5V4kCQVbbgqiyCsIGxo6
   Kbt/arcVY03jUV6fd+Np+0Elm9xQ9uXg88gjZn2lciQ0IeLvfDT4iQSmn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="387901551"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="387901551"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 15:57:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="702692538"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="702692538"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Oct 2023 15:57:24 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpci9-0005qz-2f;
        Sun, 08 Oct 2023 22:57:21 +0000
Date:   Mon, 09 Oct 2023 06:57:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 e53899771a02f798d436655efbd9d4b46c0f9265
Message-ID: <202310090612.z31OMJ3t-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: e53899771a02f798d436655efbd9d4b46c0f9265  perf/x86/lbr: Filter vsyscall addresses

elapsed time: 727m

configs tested: 52
configs skipped: 106

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231008   gcc  
i386         buildonly-randconfig-002-20231008   gcc  
i386         buildonly-randconfig-003-20231008   gcc  
i386         buildonly-randconfig-004-20231008   gcc  
i386         buildonly-randconfig-005-20231008   gcc  
i386         buildonly-randconfig-006-20231008   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231008   gcc  
i386                  randconfig-002-20231008   gcc  
i386                  randconfig-003-20231008   gcc  
i386                  randconfig-004-20231008   gcc  
i386                  randconfig-005-20231008   gcc  
i386                  randconfig-006-20231008   gcc  
i386                  randconfig-011-20231008   gcc  
i386                  randconfig-012-20231008   gcc  
i386                  randconfig-013-20231008   gcc  
i386                  randconfig-014-20231008   gcc  
i386                  randconfig-015-20231008   gcc  
i386                  randconfig-016-20231008   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231008   gcc  
x86_64       buildonly-randconfig-002-20231008   gcc  
x86_64       buildonly-randconfig-003-20231008   gcc  
x86_64       buildonly-randconfig-004-20231008   gcc  
x86_64       buildonly-randconfig-005-20231008   gcc  
x86_64       buildonly-randconfig-006-20231008   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231008   gcc  
x86_64                randconfig-002-20231008   gcc  
x86_64                randconfig-003-20231008   gcc  
x86_64                randconfig-004-20231008   gcc  
x86_64                randconfig-005-20231008   gcc  
x86_64                randconfig-006-20231008   gcc  
x86_64                randconfig-011-20231008   gcc  
x86_64                randconfig-012-20231008   gcc  
x86_64                randconfig-013-20231008   gcc  
x86_64                randconfig-014-20231008   gcc  
x86_64                randconfig-015-20231008   gcc  
x86_64                randconfig-016-20231008   gcc  
x86_64                randconfig-071-20231008   gcc  
x86_64                randconfig-072-20231008   gcc  
x86_64                randconfig-073-20231008   gcc  
x86_64                randconfig-074-20231008   gcc  
x86_64                randconfig-075-20231008   gcc  
x86_64                randconfig-076-20231008   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
