Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E5E779E83
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 11:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbjHLJWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 05:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjHLJWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 05:22:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B5A1720
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 02:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691832130; x=1723368130;
  h=date:from:to:cc:subject:message-id;
  bh=t1Ig2JcuhsSQA/vlCYgdZUdTx92qR6xgFQH5tQgPlWw=;
  b=iYBXRQQULKhI1Tt6YDzfG2YIVupqr1NrfbfMsXdUEFZBQTopyXfjpghB
   Cyl1BC5zm1DsAuoLqqUy91y1TeWavOfXb9jCeQMbXgT36Rzx5qJs96lCl
   0ZaWAkfUYKBI5z36BDBZT46AmM4mt642ePjNY2tB84+gLTd4a6OGqyOJm
   aw+fQU2qzUt5KSjFXqcAerQONcXcKqWpAvN+OM5EBF+e8qdjrjWfEUrEP
   jP8TO3Sl6+9pbwQKtyGYhP3+kNc5o2t1DbxWufRYj8degDlzDLe1HjUpQ
   n7gJCnz58rxuoiTuHNjLGfpikPhI457FhIco4KOlTC7K2/AwGjjz+XadI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="458186608"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="458186608"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2023 02:22:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="822927093"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="822927093"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Aug 2023 02:22:08 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUkoy-0008RJ-0R;
        Sat, 12 Aug 2023 09:22:08 +0000
Date:   Sat, 12 Aug 2023 17:22:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 6dbef74aeb090d6bee7d64ef3fa82ae6fa53f271
Message-ID: <202308121700.aQXvqzwy-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 6dbef74aeb090d6bee7d64ef3fa82ae6fa53f271  x86/cpu/amd: Enable Zenbleed fix for AMD Custom APU 0405

elapsed time: 725m

configs tested: 38
configs skipped: 95

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230812   gcc  
i386         buildonly-randconfig-r005-20230812   gcc  
i386         buildonly-randconfig-r006-20230812   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230812   gcc  
i386                 randconfig-i002-20230812   gcc  
i386                 randconfig-i003-20230812   gcc  
i386                 randconfig-i004-20230812   gcc  
i386                 randconfig-i005-20230812   gcc  
i386                 randconfig-i006-20230812   gcc  
i386                 randconfig-i011-20230812   clang
i386                 randconfig-i012-20230812   clang
i386                 randconfig-i013-20230812   clang
i386                 randconfig-i014-20230812   clang
i386                 randconfig-i015-20230812   clang
i386                 randconfig-i016-20230812   clang
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230812   gcc  
x86_64       buildonly-randconfig-r002-20230812   gcc  
x86_64       buildonly-randconfig-r003-20230812   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230812   clang
x86_64               randconfig-x002-20230812   clang
x86_64               randconfig-x003-20230812   clang
x86_64               randconfig-x004-20230812   clang
x86_64               randconfig-x005-20230812   clang
x86_64               randconfig-x006-20230812   clang
x86_64               randconfig-x011-20230812   gcc  
x86_64               randconfig-x012-20230812   gcc  
x86_64               randconfig-x013-20230812   gcc  
x86_64               randconfig-x014-20230812   gcc  
x86_64               randconfig-x015-20230812   gcc  
x86_64               randconfig-x016-20230812   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
