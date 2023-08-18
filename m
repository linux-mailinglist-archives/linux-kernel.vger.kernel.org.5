Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CA0780268
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 02:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356493AbjHRAHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 20:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356504AbjHRAHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 20:07:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D693A91
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 17:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692317202; x=1723853202;
  h=date:from:to:cc:subject:message-id;
  bh=YqFoW2FZp+M/yeHhdsO9LRO4aAH7i/t1UuscFT5dNI4=;
  b=lwU4lGhAhOGBWiSn4UXar+uqkg2Cl9tm9+HNnayGUBwIZ1rfoLGjf+KF
   8K6TyuVgKa1AXKWXWmO41aKIh2X6J8YvWFS9Ch42M5eJQ8588ZP6DuRh8
   D6JV8MucJABds4vqblGtbzZTojOmdjmGQpmhG/d/7eiVasaJvcbuV3erj
   2iMB5WsIW5Frp+Dsk3DjW2eCgI5LgiKu+tDECjNRAAOQoknGdLef1enj1
   jzhbh/4F4mVSP40UygWdzJoCfNgdJQm0/1SzGBqY1/uNrskRKFmPq9Q09
   epmDfxBoMYvo2OwNX7LYc2gb+CRuFWV/7oJJAvQyVax09/7uHMt4KkpON
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="403948371"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="403948371"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 17:06:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="737911246"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="737911246"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 17 Aug 2023 17:06:40 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWn0i-0001YR-0O;
        Fri, 18 Aug 2023 00:06:40 +0000
Date:   Fri, 18 Aug 2023 08:06:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 54097309620ef0dc2d7083783dc521c6a5fef957
Message-ID: <202308180823.iyH88APT-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 54097309620ef0dc2d7083783dc521c6a5fef957  x86/static_call: Fix __static_call_fixup()

elapsed time: 722m

configs tested: 41
configs skipped: 97

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230817   clang
i386         buildonly-randconfig-r005-20230817   clang
i386         buildonly-randconfig-r006-20230817   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230817   clang
i386                 randconfig-i002-20230817   clang
i386                 randconfig-i003-20230817   clang
i386                 randconfig-i004-20230817   clang
i386                 randconfig-i005-20230817   clang
i386                 randconfig-i006-20230817   clang
i386                 randconfig-i011-20230817   gcc  
i386                 randconfig-i012-20230817   gcc  
i386                 randconfig-i013-20230817   gcc  
i386                 randconfig-i014-20230817   gcc  
i386                 randconfig-i015-20230817   gcc  
i386                 randconfig-i016-20230817   gcc  
i386                 randconfig-r002-20230817   clang
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230817   clang
x86_64       buildonly-randconfig-r002-20230817   clang
x86_64       buildonly-randconfig-r003-20230817   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r003-20230817   clang
x86_64               randconfig-r023-20230817   gcc  
x86_64               randconfig-x001-20230817   gcc  
x86_64               randconfig-x002-20230817   gcc  
x86_64               randconfig-x003-20230817   gcc  
x86_64               randconfig-x004-20230817   gcc  
x86_64               randconfig-x005-20230817   gcc  
x86_64               randconfig-x006-20230817   gcc  
x86_64               randconfig-x011-20230817   clang
x86_64               randconfig-x012-20230817   clang
x86_64               randconfig-x013-20230817   clang
x86_64               randconfig-x014-20230817   clang
x86_64               randconfig-x015-20230817   clang
x86_64               randconfig-x016-20230817   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
