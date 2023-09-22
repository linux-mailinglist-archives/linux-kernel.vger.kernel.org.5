Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C841F7AA65F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 03:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjIVBHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 21:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjIVBHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:07:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F53F5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 18:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695344857; x=1726880857;
  h=date:from:to:cc:subject:message-id;
  bh=xB7uaeKv1ifr8svABAdMYbZ6ZpYxacIxzRFOHzLng6g=;
  b=aBGW3nyVZNtoXaNLibGxV56IhUucN/iR57XulxegJ+pONLXdx+NU835O
   +6CfHxa32f93X+uqPgHkUI4EgpEYbrPEcuBpAo+ge5lnupnJ81ewfwBVX
   HHP4H0ymu6kB+xdmVoJOQ8iCYuCnu0KVLYUY9grp//YKirn/yfM9h1Yx5
   0PgNwEh3f4/F/Vqayh+TgzFsVBgToIKBg3cOhBJxs4ZMRGlSuKk5y8hRU
   ZzQHOHV8n5n1WCvfEycUtxo+7ZWAZFoB04hMQQKNkIFYjszmSYp2GRHLb
   Gol91XecRI3fePdyn8n+HXGaJRKZnfdHnjTAu1ll3bGYHyNQKWa0BEtGO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="371033322"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="371033322"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 18:07:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="723994025"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="723994025"
Received: from lkp-server02.sh.intel.com (HELO b77866e22201) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2023 18:07:35 -0700
Received: from kbuild by b77866e22201 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjUdp-0000cE-13;
        Fri, 22 Sep 2023 01:07:33 +0000
Date:   Fri, 22 Sep 2023 09:07:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/asm] BUILD SUCCESS
 7c097ca50d2ba7f7989f01175f366151256bfa10
Message-ID: <202309220911.7r1plec5-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
branch HEAD: 7c097ca50d2ba7f7989f01175f366151256bfa10  x86/percpu: Do not clobber %rsi in percpu_{try_,}cmpxchg{64,128}_op

elapsed time: 1018m

configs tested: 52
configs skipped: 114

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230921   gcc  
i386         buildonly-randconfig-002-20230921   gcc  
i386         buildonly-randconfig-003-20230921   gcc  
i386         buildonly-randconfig-004-20230921   gcc  
i386         buildonly-randconfig-005-20230921   gcc  
i386         buildonly-randconfig-006-20230921   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230921   gcc  
i386                  randconfig-002-20230921   gcc  
i386                  randconfig-003-20230921   gcc  
i386                  randconfig-004-20230921   gcc  
i386                  randconfig-005-20230921   gcc  
i386                  randconfig-006-20230921   gcc  
i386                  randconfig-011-20230921   gcc  
i386                  randconfig-012-20230921   gcc  
i386                  randconfig-013-20230921   gcc  
i386                  randconfig-014-20230921   gcc  
i386                  randconfig-015-20230921   gcc  
i386                  randconfig-016-20230921   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230921   gcc  
x86_64       buildonly-randconfig-002-20230921   gcc  
x86_64       buildonly-randconfig-003-20230921   gcc  
x86_64       buildonly-randconfig-004-20230921   gcc  
x86_64       buildonly-randconfig-005-20230921   gcc  
x86_64       buildonly-randconfig-006-20230921   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230921   gcc  
x86_64                randconfig-002-20230921   gcc  
x86_64                randconfig-003-20230921   gcc  
x86_64                randconfig-004-20230921   gcc  
x86_64                randconfig-005-20230921   gcc  
x86_64                randconfig-006-20230921   gcc  
x86_64                randconfig-011-20230921   gcc  
x86_64                randconfig-012-20230921   gcc  
x86_64                randconfig-013-20230921   gcc  
x86_64                randconfig-014-20230921   gcc  
x86_64                randconfig-015-20230921   gcc  
x86_64                randconfig-016-20230921   gcc  
x86_64                randconfig-071-20230921   gcc  
x86_64                randconfig-072-20230921   gcc  
x86_64                randconfig-073-20230921   gcc  
x86_64                randconfig-074-20230921   gcc  
x86_64                randconfig-075-20230921   gcc  
x86_64                randconfig-076-20230921   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
