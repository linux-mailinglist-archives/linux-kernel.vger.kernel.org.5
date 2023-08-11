Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3C27786D5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 07:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjHKFDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 01:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjHKFDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 01:03:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D532D44
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691730191; x=1723266191;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tkRNTvZCmg2r2V8njYX1wT5wUIKPbwIvhYjs0xvHC6g=;
  b=UWivuvITTa0wWVQoD2ibBcDN8Qm+Nd/3OFbdzar/8S1cdXpwgWlHSwo8
   U7Omfc/aKuSYctLPFoiTc0xU6Br2eHKzi2Ke7HkU7P+n+ed8KuzH40l0o
   oF8GeGtZjVrQi2nLeRbHXggl1blhIwU9UAXL5Uvx1+2BqiZkkSOlRSxNZ
   9ZaaSgmZogDe6v2JGaj4CWyzECWYYZxRfAXhFKuVe3JxjofcKChNqUq+D
   AZOL7oYkpz9Pks+wLfCPJsOX3lelttMtWIS7Xf72qzcK9FYTXS8HYU+RU
   aAG+LbtkbogPpCjFWHCc/b4P3wVncS0D+YjkvT4FpBmAV2aRN+HcvjWN+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="369066165"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="369066165"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 22:03:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="762065602"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="762065602"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 10 Aug 2023 22:02:31 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUKIA-0007WK-0e;
        Fri, 11 Aug 2023 05:02:30 +0000
Date:   Fri, 11 Aug 2023 13:02:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: {standard input}:1727: Error: operand out of range (-132 is not
 between -128 and 127)
Message-ID: <202308111233.rbf5C0JD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   25aa0bebba72b318e71fe205bfd1236550cc9534
commit: a6889becb05394255c80b62103677e3b095726a9 refscale: Add tests using SLAB_TYPESAFE_BY_RCU
date:   7 months ago
config: arc-randconfig-r006-20230811 (https://download.01.org/0day-ci/archive/20230811/202308111233.rbf5C0JD-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230811/202308111233.rbf5C0JD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308111233.rbf5C0JD-lkp@intel.com/

All errors (new ones prefixed by >>):

   {standard input}: Assembler messages:
>> {standard input}:1727: Error: operand out of range (-132 is not between -128 and 127)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
