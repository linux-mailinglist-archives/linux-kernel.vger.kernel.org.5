Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4D37B2697
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjI1U2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 16:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjI1U2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:28:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A454B194
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695932910; x=1727468910;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NCy6eqo/oKm4CVLCojNICH3uPk5kqeZFvJVk2dpz3II=;
  b=ZNcq8HAa9jir1lwRsbo/UM81/XdTRjpsAijVPkxjbCYVWM1U9yU92wTj
   DZnE2sE3waTkM+3E7A/+Ryc5M+h8oI2ZeuqWsNw+Ul1hnaflMQf418d0b
   jSsfQ+l8D+L05/k9SLTUeerTbsOKlPKrkpSrGvap81MVM3T9dI9NIUpK+
   h1xxnmqo51v0/pzMjq1wTg2F/4ai/cQRNGGF+5aSMSXm3wHG9tVyGYeBW
   XUncMRcm5JHVoIyB+RePTlXPtB6dbUC1v4AbPBRwVEgDiMyFWhuJJvLkz
   Me8N90OFAnkeBWC4uRsKGrSuzstLGqGQda2EsRHjpNVcPZgz5Onh31vHN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="367229341"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="367229341"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 13:28:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="1080686843"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="1080686843"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 28 Sep 2023 13:28:28 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlxcY-0001vN-2T;
        Thu, 28 Sep 2023 20:28:26 +0000
Date:   Fri, 29 Sep 2023 04:28:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: cc1: error: AltiVec not supported in this target
Message-ID: <202309290441.KPUf5M1o-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   633b47cb009d09dc8f4ba9cdb3a0ca138809c7c7
commit: ebd1d3b74f8542a8f3bb80b453692d6d18f84071 powerpc/32: Move the old 6xx -mcpu logic before the TARGET_CPU logic
date:   4 years, 9 months ago
config: powerpc-randconfig-r035-20230908 (https://download.01.org/0day-ci/archive/20230929/202309290441.KPUf5M1o-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230929/202309290441.KPUf5M1o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309290441.KPUf5M1o-lkp@intel.com/

All errors (new ones prefixed by >>):

>> cc1: error: AltiVec not supported in this target

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
