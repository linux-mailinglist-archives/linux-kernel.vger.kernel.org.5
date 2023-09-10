Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78671799E80
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 15:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243660AbjIJN2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 09:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjIJN2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 09:28:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B099ACC5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 06:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694352476; x=1725888476;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lYBBiBhEoN89Xlqf5ftg1W7wnIxmFljScAMjqCKGEsM=;
  b=m36sBsZjpSrKMSJkGMw4huc0UDzLPTm/oZQLteQhd4G+DVKI3JV8KQZ8
   qJD0g3lJ1FAGNqP/AWE4UoIAN6tBo+7yY0KbQVGCXq9cr0CZgdXQ2NqLL
   XyOP6PgOQJTiKDVnWpuhLDzRbotzWq5BNQOSMQ5PWFALjc17XIfe7RU7g
   VX6j8G2rs0GgkSIFF6iae6qKmtRj3OwD8OD70GTf7s8FIp+drXhvC4ctG
   csHw5s/xP9U53hoqvyt2HsjJQ4oNJ8IORkAh5MOZO1luZumDR5jMhicUQ
   U3KH5w6Ed6+fAyHGRgf9gK+Sa/QgAZwYyeLxRe0jk6TuGwY3G/XMPT8B+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="444324815"
X-IronPort-AV: E=Sophos;i="6.02,241,1688454000"; 
   d="scan'208";a="444324815"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 06:27:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="743020892"
X-IronPort-AV: E=Sophos;i="6.02,241,1688454000"; 
   d="scan'208";a="743020892"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 10 Sep 2023 06:27:54 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfKTg-0004zE-15;
        Sun, 10 Sep 2023 13:27:52 +0000
Date:   Sun, 10 Sep 2023 21:26:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: Kernel image exceeds maximum size for relocation!
Message-ID: <202309102133.RrwTjtE4-lkp@intel.com>
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
head:   535a265d7f0dd50d8c3a4f8b4f3a452d56bd160f
commit: 7199c86247e9618981a2916900d3fcb83e5df157 netlink: specs: devlink: add commands that do per-instance dump
date:   4 weeks ago
config: mips-randconfig-r036-20210927 (https://download.01.org/0day-ci/archive/20230910/202309102133.RrwTjtE4-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230910/202309102133.RrwTjtE4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309102133.RrwTjtE4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Kernel image exceeds maximum size for relocation!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
