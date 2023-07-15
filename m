Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F8A754ACA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 20:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjGOSmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 14:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjGOSmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 14:42:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0780E52
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 11:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689446526; x=1720982526;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KtjBI3Rd+hM3/BoGTZr8x+F2mieFfEmW6zPodSxgkGw=;
  b=L6ulFXGVJ0n/ReumTCGVATwz1RR6jptMLPWwgEro5DRdBQ4Gtsb7y1Uq
   wMSU3SVwCwzPmIvvI5+YFSw9CqyLj0x+V40UXbJ2LwaSU1bnbU+AZtSU3
   JirUf9cUSmcYhmjMhmne4hyPePidIKNku27HPJvlaymyvLLDaXq0ovfZf
   CeuLfkE+Q+leUCRaTI9dcxm299swi0JzVO5z8Jr4Tfz29bXUqZ8H2P18N
   S6QepUwPD1zFVRAI/1xgOp1QDyybEG1znnqDJ85f9FRil3mgdxmsypKXG
   +yrypRM+T2hkcKCejOIDLUdfl38hPSQPO5Np+h/jEak00NCbD7ROwo/mO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="431860455"
X-IronPort-AV: E=Sophos;i="6.01,208,1684825200"; 
   d="scan'208";a="431860455"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2023 11:42:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="969366257"
X-IronPort-AV: E=Sophos;i="6.01,208,1684825200"; 
   d="scan'208";a="969366257"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jul 2023 11:42:05 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qKkDT-0008JR-3B;
        Sat, 15 Jul 2023 18:42:04 +0000
Date:   Sun, 16 Jul 2023 02:41:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: fs/overlayfs/copy_up.o: warning: objtool: .text.unlikely: unexpected
 end of section
Message-ID: <202307160233.UXi0pI5S-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   831fe284d8275987596b7d640518dddba5735f61
commit: abf08576afe31506b812c8c1be9714f78613f300 fs: port vfs_*() helpers to struct mnt_idmap
date:   6 months ago
config: x86_64-buildonly-randconfig-r002-20230716 (https://download.01.org/0day-ci/archive/20230716/202307160233.UXi0pI5S-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230716/202307160233.UXi0pI5S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307160233.UXi0pI5S-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/overlayfs/copy_up.o: warning: objtool: .text.unlikely: unexpected end of section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
