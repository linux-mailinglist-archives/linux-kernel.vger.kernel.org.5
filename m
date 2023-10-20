Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BA17D075F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 06:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjJTEmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 00:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjJTEmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 00:42:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98600D41
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 21:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697776969; x=1729312969;
  h=date:from:to:cc:subject:message-id;
  bh=jcd41RCc2EPwClnULwSreFfwCjlIzWGZtTKABuEOfuw=;
  b=UVH8HEJDERv1L6QP2WNgmI9lXAY+KktXL6F77eDZV7DncyXwwLfEk7GR
   h8t8Y7+UsAkJaBAyLwhoNmaoUX6xwAs76DmAbl4hf/qM92+m+CawDTHk5
   ima2y4Q28/VlGP70j8b6THoy9GuVu8ozvXm7UQ1LBqnsimcPCLiIO4U+p
   ItS71+HJ/Hqtv0V1H8KFbc00zigQg6Vi4dKJu2Q6acgEZ3n/AbnjZj+Li
   YspdYJ+65Gc3tk1k5MAO6761i4NOj9syR5EHUwiLJLJopyqooA3Tm+Wi/
   86yc7I4YaeR2PyrlcoycCK06HHGWwHhVTxyrHIDGzKEmwgrKrnTCA8UPq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="390310352"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="390310352"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 21:42:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="847958547"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="847958547"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Oct 2023 21:42:48 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qthLR-000310-2L;
        Fri, 20 Oct 2023 04:42:45 +0000
Date:   Fri, 20 Oct 2023 12:41:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/percpu] BUILD SUCCESS
 e39828d2c1c0781ccfcf742791daf88fdfa481ea
Message-ID: <202310201256.Fa4zQbZR-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/percpu
branch HEAD: e39828d2c1c0781ccfcf742791daf88fdfa481ea  x86/percpu: Use the correct asm operand modifier in percpu_stable_op()

elapsed time: 2343m

configs tested: 52
configs skipped: 110

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231019   gcc  
i386         buildonly-randconfig-002-20231019   gcc  
i386         buildonly-randconfig-003-20231019   gcc  
i386         buildonly-randconfig-004-20231019   gcc  
i386         buildonly-randconfig-005-20231019   gcc  
i386         buildonly-randconfig-006-20231019   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231019   gcc  
i386                  randconfig-002-20231019   gcc  
i386                  randconfig-003-20231019   gcc  
i386                  randconfig-004-20231019   gcc  
i386                  randconfig-005-20231019   gcc  
i386                  randconfig-006-20231019   gcc  
i386                  randconfig-011-20231019   gcc  
i386                  randconfig-012-20231019   gcc  
i386                  randconfig-013-20231019   gcc  
i386                  randconfig-014-20231019   gcc  
i386                  randconfig-015-20231019   gcc  
i386                  randconfig-016-20231019   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231019   gcc  
x86_64       buildonly-randconfig-002-20231019   gcc  
x86_64       buildonly-randconfig-003-20231019   gcc  
x86_64       buildonly-randconfig-004-20231019   gcc  
x86_64       buildonly-randconfig-005-20231019   gcc  
x86_64       buildonly-randconfig-006-20231019   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231019   gcc  
x86_64                randconfig-002-20231019   gcc  
x86_64                randconfig-003-20231019   gcc  
x86_64                randconfig-004-20231019   gcc  
x86_64                randconfig-005-20231019   gcc  
x86_64                randconfig-006-20231019   gcc  
x86_64                randconfig-011-20231019   gcc  
x86_64                randconfig-012-20231019   gcc  
x86_64                randconfig-013-20231019   gcc  
x86_64                randconfig-014-20231019   gcc  
x86_64                randconfig-015-20231019   gcc  
x86_64                randconfig-016-20231019   gcc  
x86_64                randconfig-071-20231019   gcc  
x86_64                randconfig-072-20231019   gcc  
x86_64                randconfig-073-20231019   gcc  
x86_64                randconfig-074-20231019   gcc  
x86_64                randconfig-075-20231019   gcc  
x86_64                randconfig-076-20231019   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
