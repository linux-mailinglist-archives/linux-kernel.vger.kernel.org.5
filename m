Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068DE7B6D3F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbjJCPes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjJCPeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:34:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8398995
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 08:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696347282; x=1727883282;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=amYhNn/eD7POZuSrj5Jl80L6ZktVnDMNth2jkW66bBo=;
  b=l+smERd7KZfwEAMKeohiOoMzMk4Icy1WAn9R40R4kVVNEyZ1QcTlXsJ3
   djHlOsTWS7xNVVvFyHUQ43JF/B8te7UR1mcy9NIxWDfGYEbkOPdXs+sVk
   gJuc0Cujdsd+wKi8Z5jIqYgQn9esHJqHsGaQCjq/FPAAJyJJof/qYMw7C
   BLXzM9vOhMH2op8N9O0Dor1KuVq9EtnJ9WJz0TSo1SjD9QyMu9LcuYtAs
   TPkUGobLvzchhYvtlMgG4xGvXhNAJD5aQw9zFzzjvlyysYXZ8FWS4Q7U9
   pwaOy/RZWGXKY7Bt18qvAQ+wuZ6775lgSQZzlF1V1Kqi2w9fvjOBd2c6h
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="469185339"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="469185339"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 08:34:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="786125930"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="786125930"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 03 Oct 2023 08:34:38 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qnhPw-0007EK-05;
        Tue, 03 Oct 2023 15:34:36 +0000
Date:   Tue, 3 Oct 2023 23:34:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: vmlinux.o: warning: objtool: ovl_copy_up_tmpfile() falls through to
 next function wacom_bpt3_touch_msg.cold()
Message-ID: <202310032325.XWZZTk8n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ce36c8b149873b50f2a4b9818eb3dcdd74ddd5a3
commit: 0babf89c9cca7e074d6e59893e462e4886f481cc hwmon: (f71882fg) prevent possible division by zero
date:   5 months ago
config: x86_64-buildonly-randconfig-r004-20220214 (https://download.01.org/0day-ci/archive/20231003/202310032325.XWZZTk8n-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231003/202310032325.XWZZTk8n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310032325.XWZZTk8n-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: ovl_copy_up_tmpfile() falls through to next function wacom_bpt3_touch_msg.cold()

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
