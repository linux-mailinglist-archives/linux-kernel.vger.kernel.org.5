Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423587CBA9F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbjJQGMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 02:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbjJQGMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:12:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFE0EA
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 23:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697523162; x=1729059162;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cd8wWqa2wQWkVesEWRSOGVNVPs5wnXyLcNFqueTKMMc=;
  b=IjCkqBw0vD+D44w0vf3JA/3aUW5qrYcM/JV3XQQPTuGWfodIyEtMsP8S
   yiwQwyV9vRe1mm1xPGJsDIZGSzZhZfNSZkO3+syx+Q3tI+MB0OqF6p9U6
   KJSc9wsZn2TKsWhcbjd9gewIziKJTyrUZibrc3DJwQxr8WKnyjdugouVR
   Bs5a74yulHFHv9BlP235p8cQYmqjmSIImd5mmeg91aUgyTAkYk1o7ucts
   1CDFPGS2oEHnta2nDX/t8QVULmSIbcggn6SGgQpnb2ws5fobT45u4nCa8
   C3wlG1xXCygFKQeitKZVSGbJkUK52vuJg05gprSwkpCtDHc/mDnDmiDef
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="416783679"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="416783679"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 23:12:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="732601985"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="732601985"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Oct 2023 23:12:41 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsdJn-00096n-0O;
        Tue, 17 Oct 2023 06:12:39 +0000
Date:   Tue, 17 Oct 2023 14:11:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: <stdin>:1508:2: warning: #warning syscall clone3 not implemented
Message-ID: <202310171424.ZUGeHDAN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   213f891525c222e8ed145ce1ce7ae1f47921cb9c
commit: 8f3220a806545442f6f26195bc491520f5276e7c arch: wire-up clone3() syscall
date:   4 years, 4 months ago
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20231017/202310171424.ZUGeHDAN-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310171424.ZUGeHDAN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310171424.ZUGeHDAN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> <stdin>:1508:2: warning: #warning syscall clone3 not implemented [-Wcpp]
--
   arch/alpha/kernel/asm-offsets.c:15:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
      15 | void foo(void)
         |      ^~~
>> <stdin>:1508:2: warning: #warning syscall clone3 not implemented [-Wcpp]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
