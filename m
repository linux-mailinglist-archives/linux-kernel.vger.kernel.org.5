Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024D4790AF9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 07:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbjICFrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 01:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjICFru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 01:47:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BEACC5
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 22:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693720067; x=1725256067;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GwWDbHIcrQuHPY2syUV0RcZammZyL1aS/I6fXxFsrAA=;
  b=kpCWSKxC4OhbWNd40ldLvHfxM8CR4BVJocu4f9GqJkIwEWHemRdZ3yf+
   GcMFg5v3QKh4FgZb7cTx3G2Pt+HmI/XG9bCeTbToHqqXHAmeIvX4uqiOd
   1aHCcrrNIOtEq+seamZutGLY/K3rsGgN9t9IOAWbiX5EwWvmnpZalOO1S
   uJUKe+d52YmY229j+hsUFQL/AXhxvs8DkQ86ZhLEC4dVg1fBgrSW+c1Ca
   I9JIaWl5z8UFNHFxPGJ6hBMD+oPKzkLvONdAk98SjctXceEKQGgYNsF4N
   5YiyW/oGQZ9ynp9lnhVRfBmXQlnMI16SKcb8Ay6MQf17pnnVNfCfH/B/T
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="366652035"
X-IronPort-AV: E=Sophos;i="6.02,223,1688454000"; 
   d="scan'208";a="366652035"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 22:47:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="987138962"
X-IronPort-AV: E=Sophos;i="6.02,224,1688454000"; 
   d="scan'208";a="987138962"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 02 Sep 2023 22:47:45 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qcfxW-0002wV-32;
        Sun, 03 Sep 2023 05:47:42 +0000
Date:   Sun, 3 Sep 2023 13:47:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: db1000.c:undefined reference to `mmc_detect_change'
Message-ID: <202309031319.FjILvr3H-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   92901222f83d988617aee37680cb29e1a743b5e4
commit: d4a5c59a955bba96b273ec1a5885bada24c56979 mmc: au1xmmc: force non-modular build and remove symbol_get usage
date:   4 weeks ago
config: mips-randconfig-r003-20230903 (https://download.01.org/0day-ci/archive/20230903/202309031319.FjILvr3H-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230903/202309031319.FjILvr3H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309031319.FjILvr3H-lkp@intel.com/

All errors (new ones prefixed by >>):

   mipsel-linux-ld: arch/mips/alchemy/devboards/db1000.o: in function `db1100_mmc_cd':
>> db1000.c:(.text+0x1f0): undefined reference to `mmc_detect_change'
   mipsel-linux-ld: arch/mips/alchemy/devboards/db1200.o: in function `pb1200_mmc1_cdfn':
>> db1200.c:(.text+0x3b0): undefined reference to `mmc_detect_change'
   mipsel-linux-ld: arch/mips/alchemy/devboards/db1200.o: in function `db1200_mmc_cdfn':
   db1200.c:(.text+0x428): undefined reference to `mmc_detect_change'
   mipsel-linux-ld: arch/mips/alchemy/devboards/db1300.o: in function `db1300_mmc_cdfn':
>> db1300.c:(.text+0x240): undefined reference to `mmc_detect_change'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
