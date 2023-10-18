Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DBB7CD291
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 05:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjJRDOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 23:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjJRDOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 23:14:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C8AFC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 20:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697598877; x=1729134877;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RFdegzCEt8URtrRM0wztYKDqppOmOCATldAg1ZnFHu0=;
  b=buT9PfweOZPtLYfOQ9Mvq9mOarNWlw12f4eMY/LMpnkw0FxUyT/7N2Ho
   oDDE9mVoQL1a4kcLFt9VC/2cwl6Mux7hB1JZB1X/v8T213+Nraw0s2NRy
   0ZZ7DHwoW7F2+x/aMt0KlWjM07rwzU3r/VMfiASPufL0UpTAl5SaM5IoW
   ywTn482lVMYLl4/LDgRsD3gF9RVc4cxb2DDpn80tggVn21fm01UlhMmer
   HmuJuZ6g3OK0vI7jdCVocQqKCx++l4ixIw6lWujpZ2OrcT2P+3uP94gM8
   4uLPKuPTDqdew9VD2y9wf8uRnJwXaxeO4axXWvR7k63B28yQinHFIIJHZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="389802701"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="389802701"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 20:14:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="929994107"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="929994107"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 Oct 2023 20:14:35 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsx0z-000ARd-1L;
        Wed, 18 Oct 2023 03:14:33 +0000
Date:   Wed, 18 Oct 2023 11:14:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Perry Yuan <perry.yuan@amd.com>
Subject: include/linux/amd-pstate.h:87:27: warning: 'amd_pstate_mode_string'
 defined but not used
Message-ID: <202310181119.Ws0iO2pZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wyes,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   06dc10eae55b5ceabfef287a7e5f16ceea204aa0
commit: 36c5014e5460963ad7766487c0e22a7ff28681fc cpufreq: amd-pstate: optimize driver working mode selection in amd_pstate_param()
date:   9 months ago
config: x86_64-randconfig-002-20231010 (https://download.01.org/0day-ci/archive/20231018/202310181119.Ws0iO2pZ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310181119.Ws0iO2pZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310181119.Ws0iO2pZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/cpufreq/amd-pstate-ut.c:29:
>> include/linux/amd-pstate.h:87:27: warning: 'amd_pstate_mode_string' defined but not used [-Wunused-const-variable=]
      87 | static const char * const amd_pstate_mode_string[] = {
         |                           ^~~~~~~~~~~~~~~~~~~~~~


vim +/amd_pstate_mode_string +87 include/linux/amd-pstate.h

    86	
  > 87	static const char * const amd_pstate_mode_string[] = {
    88		[AMD_PSTATE_DISABLE]     = "disable",
    89		[AMD_PSTATE_PASSIVE]     = "passive",
    90		[AMD_PSTATE_ACTIVE]      = "active",
    91		NULL,
    92	};
    93	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
