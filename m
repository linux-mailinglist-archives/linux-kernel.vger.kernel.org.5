Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281D580B88C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 04:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjLJD1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 22:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLJD1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 22:27:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7400EC4
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 19:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702178839; x=1733714839;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LSmlCgf8rbUUa7XYmYUr/lKbx3NqGMOu3esSOOZAKLk=;
  b=AlXdlQKLSnEWSdzcasnNmSQUQigN/yfB4hXiiMvp2+Aae923XODK/q4K
   iB82POudakkJhx7e+W8EkbdhE9+34i4VcidhV1BJfKK92Oe7l5YNsLrd3
   kefEA7ZrxxXl9y9EREZXXYMrQgZZoaIGtQrIH73Bl9jCjHkH1Nb7pxwsJ
   Ys1SSoKPn9alJVLAHbfmvJNi2VAiLS4JzsXUGqbNoCMGthhqYiWc8vkL+
   rb/T6B3yxYzformjhJDzFv4mB2iqb5QjWgKOONXGxFyg7yeof30DAkfO2
   453hdGYUerEQvJ8j8mhgFK3t9Njn0i2IZ4tnxJ0NlJPuTHjH4k5U91u6c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="398396670"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="398396670"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 19:27:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="765916493"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="765916493"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 09 Dec 2023 19:27:17 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCATL-000GKr-26;
        Sun, 10 Dec 2023 03:27:15 +0000
Date:   Sun, 10 Dec 2023 11:26:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [tip:x86/percpu 27/31] WARNING: modpost: vmlinux: section mismatch
 in reference: patch_dest+0x95 (section: .text) -> apply_relocation (section:
 .init.text)
Message-ID: <202312101129.oPl9VVEP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/percpu
head:   fc50065325f8b88d6986f089ae103b5db858ab96
commit: 6724ba89e0b03667d56616614f55e1f772d38fdb [27/31] x86/callthunks: Mark apply_relocation() as __init_or_module
config: x86_64-alldefconfig (https://download.01.org/0day-ci/archive/20231210/202312101129.oPl9VVEP-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231210/202312101129.oPl9VVEP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312101129.oPl9VVEP-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
>> WARNING: modpost: vmlinux: section mismatch in reference: patch_dest+0x95 (section: .text) -> apply_relocation (section: .init.text)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
