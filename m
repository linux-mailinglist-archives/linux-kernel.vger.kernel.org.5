Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C465F80DDAD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345465AbjLKVyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjLKVyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:54:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A35D2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 13:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702331652; x=1733867652;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jkXLZZPUNAXyn/UomHJptfFKUuDXT496fp+rpERlQFc=;
  b=IN9iOagk9bAXB1SG4EU3nWNB00kEw5op78p5TreZD9KHLZhg4imAA6nh
   hVVWKH+w3UKNw5KXxMUTagz6zHPZeh4SEniutylysGqEfJEmuHtDAOFHx
   wQtNTgG3PcdeSbuOyBbD0+AFc0T3W6Z/fruFJJzSmDSLrh/SiR0omNnFm
   Gx+EDYjyZikr66TBJTPxRFOaM0IkeXv5HP4KRbNCbEIkyD8IFel/NP5IR
   lnliT/TqKQ9Lt3CYUTEhD3Ifd9meqHLIUV82pmgVpliSuSAgLlILxHjAE
   llqiT84Vxzr8fAaQODMWzdVY8cTIuqd4w0+M8+8ve0rEne3BIbZKMY858
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="8077199"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="8077199"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 13:54:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="21249714"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 11 Dec 2023 13:54:07 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCoE0-000IVa-3B;
        Mon, 11 Dec 2023 21:54:04 +0000
Date:   Tue, 12 Dec 2023 05:53:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Paul Greenwalt <paul.greenwalt@intel.com>,
        Simon Horman <horms@kernel.org>
Subject: WARNING: modpost: vmlinux: section mismatch in reference:
 ice_adv_lnk_speed_maps+0x14 (section: .data) ->
 __setup_str_initcall_blacklist (section: .init.rodata)
Message-ID: <202312120508.TQnoTl9M-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
commit: 982b0192db455d288fc1deb06632f529c35daa15 ice: Refactor finding advertised link speed
date:   8 weeks ago
config: xtensa-randconfig-r011-20220519 (https://download.01.org/0day-ci/archive/20231212/202312120508.TQnoTl9M-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231212/202312120508.TQnoTl9M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312120508.TQnoTl9M-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
>> WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0x14 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0x30 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0x4c (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0x68 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0x84 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0xa0 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0xbc (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0xd8 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0xf4 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: qed_mfw_legacy_maps+0x14 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: qed_mfw_legacy_maps+0x30 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: qed_mfw_legacy_maps+0x4c (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: qed_mfw_legacy_maps+0x68 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: qed_mfw_legacy_maps+0x84 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: qed_mfw_legacy_maps+0xa0 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: qed_mfw_legacy_maps+0xbc (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: qed_mfw_ext_maps+0x14 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: qed_mfw_ext_maps+0x30 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: qed_mfw_ext_maps+0x4c (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: qed_mfw_ext_maps+0x68 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: qed_mfw_ext_maps+0x84 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: qed_mfw_ext_maps+0xa0 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: qed_mfw_ext_maps+0xbc (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: qed_mfw_ext_maps+0xd8 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: qede_forced_speed_maps+0x14 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: qede_forced_speed_maps+0x30 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: qede_forced_speed_maps+0x4c (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: qede_forced_speed_maps+0x68 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: qede_forced_speed_maps+0x84 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: qede_forced_speed_maps+0xa0 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: qede_forced_speed_maps+0xbc (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
