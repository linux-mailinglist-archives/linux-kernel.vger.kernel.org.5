Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED3C8013EE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379595AbjLAUJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379586AbjLAUJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:09:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ED2FA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 12:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701461402; x=1732997402;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ekETfT6yloJAYS4ADW7GfipxxrW9w4UX+/1WxVPCns4=;
  b=mAEJaxyWPPEZIPb9NqMyIHb+DOFD8bOc4mnhMv0iwaCi3lmy7SY0v6Kw
   Xh6YQRKI65q4NEWFrHpITgIKvHqAPfnkkM1JVOXCXDHtK8ibWzIn6XTgS
   OtHdjNsia9iEkB5bFFad0WJrhq4+Ws1WtIuwiZNj5kDO+J8GNXoHnOIC4
   y6Jij3hLNJoXVowyFJJNC9wayIdu78kGyBN56biCMIcgnOIAncSpnthzg
   E8vvpXOC+qGIqaMj2idOFcnRBxwbXebbUTbrWKKkwJWk3SJg1vpbI8Lik
   4FNnwWMjsGfjARu3YFXY6LRwHC6YbKNDfuEjj2oIhNZ7N1SB7y6XHQQJf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="397148"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="397148"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 12:10:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="763246779"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="763246779"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 01 Dec 2023 12:10:00 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r99pm-0004FG-1K;
        Fri, 01 Dec 2023 20:09:58 +0000
Date:   Sat, 2 Dec 2023 04:09:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: thermometer.c:21:10: fatal error: libconfig.h: No such file or
 directory
Message-ID: <202312020401.EaIsKfof-lkp@intel.com>
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

Hi Daniel,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   994d5c58e50e91bb02c7be4a91d5186292a895c8
commit: 110acbc6a4518145db3a1a9c0686d730bb258bf1 tools/thermal: Add a temperature capture tool
date:   1 year, 6 months ago
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231202/202312020401.EaIsKfof-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312020401.EaIsKfof-lkp@intel.com/

All errors (new ones prefixed by >>):

>> thermometer.c:21:10: fatal error: libconfig.h: No such file or directory
      21 | #include <libconfig.h>
         |          ^~~~~~~~~~~~~
   compilation terminated.
   make[2]: *** [Makefile:23: thermometer] Error 1

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
