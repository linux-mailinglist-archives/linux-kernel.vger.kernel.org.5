Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB37802455
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 14:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjLCNqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 08:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCNqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 08:46:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DEFF2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 05:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701611197; x=1733147197;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5NG7LGEngowS/be8Mb+90nf3rY0SBqKDkiIzMorgVMQ=;
  b=FIsVJuyt8LHxeamwUcSA6LcBFtJedO0rGwQoVoHMwgbLsFb7TojOinQf
   dCbLd6LUkf/kbG1RCbWwoTRRPKtjtJ5mVrZy/Kdzvr58/VTuV8MXfa45a
   rGKt89dEyn6SAE/EbBWNVBm2s4njVTkt6CFiD3Tu10F6ljte5JSDPCU5r
   adfHk4I/+sMgwRVlSd2VWBAr6MAX2MtLEy2LV7zaAnuJ5pmp39XHn6QTH
   zPULw7EytTIcCtq93om7seMlyKw0X0IC5xcvcfhs9BMjQReo/2vMAIm3f
   YwcJOMqcHycnpHPhN8giOpxOHtYKdbPNNgyn6/hhWG7xZZG1T3IpO4Qst
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="6959658"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="6959658"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 05:46:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="11699241"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 03 Dec 2023 05:46:29 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9mnh-0006ho-3A;
        Sun, 03 Dec 2023 13:46:25 +0000
Date:   Sun, 3 Dec 2023 21:46:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johan Almbladh <johan.almbladh@anyfinetworks.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: lib/test_bpf.c:7480:9: sparse: sparse: cast truncates bits from
 constant value (baadf00d000000ab becomes ab)
Message-ID: <202312032126.oLp7wDG1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: 89b63462765cc0370f22ebec53d3e83cbbb17613 bpf/tests: Add zero-extension checks in BPF_ATOMIC tests
date:   2 years, 2 months ago
config: mips-randconfig-r123-20231130 (https://download.01.org/0day-ci/archive/20231203/202312032126.oLp7wDG1-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20231203/202312032126.oLp7wDG1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312032126.oLp7wDG1-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   lib/test_bpf.c:5753:25: sparse: sparse: cast truncates bits from constant value (ffffffff0000 becomes ffff0000)
   lib/test_bpf.c:5754:25: sparse: sparse: cast truncates bits from constant value (ffff00000000ffff becomes ffff)
   lib/test_bpf.c:5785:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5786:25: sparse: sparse: cast truncates bits from constant value (123456786a4c2e0 becomes 86a4c2e0)
   lib/test_bpf.c:5801:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5802:25: sparse: sparse: cast truncates bits from constant value (fedcba98795b3d1f becomes 795b3d1f)
   lib/test_bpf.c:5878:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5890:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5903:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5915:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5928:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5940:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5953:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5965:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6045:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6056:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6068:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6079:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6091:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6102:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6114:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6186:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6198:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6211:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6223:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6236:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6248:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6261:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6273:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6353:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6364:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6376:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6387:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6399:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6410:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6422:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6446:25: sparse: sparse: cast truncates bits from constant value (ff00ff0000000000 becomes 0)
   lib/test_bpf.c:6458:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6470:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6483:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6495:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6508:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6520:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6533:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6545:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6581:25: sparse: sparse: cast truncates bits from constant value (ff00ff0000000000 becomes 0)
   lib/test_bpf.c:6592:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6603:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6615:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6626:25: sparse: sparse: cast truncates bits from constant value (f123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6638:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6649:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6661:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6718:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6729:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6743:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6749:30: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6754:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6767:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:6778:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:6792:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:6798:30: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:6803:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:6816:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6827:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6841:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6847:30: sparse: sparse: cast truncates bits from constant value (efcdab8967452301 becomes 67452301)
   lib/test_bpf.c:6852:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6865:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:6876:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:6890:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:6896:30: sparse: sparse: cast truncates bits from constant value (1032547698badcfe becomes 98badcfe)
   lib/test_bpf.c:6901:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:6914:25: sparse: sparse: cast truncates bits from constant value (102030405060708 becomes 5060708)
   lib/test_bpf.c:6934:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:6954:25: sparse: sparse: cast truncates bits from constant value (102030405060708 becomes 5060708)
   lib/test_bpf.c:6974:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:6994:25: sparse: sparse: cast truncates bits from constant value (102030405060708 becomes 5060708)
   lib/test_bpf.c:7014:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:7035:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e0f0 becomes c0d0e0f0)
   lib/test_bpf.c:7036:25: sparse: sparse: cast truncates bits from constant value (102030405060708 becomes 5060708)
   lib/test_bpf.c:7037:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e008 becomes c0d0e008)
   lib/test_bpf.c:7057:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e0f0 becomes c0d0e0f0)
   lib/test_bpf.c:7058:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:7059:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e088 becomes c0d0e088)
   lib/test_bpf.c:7079:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e0f0 becomes c0d0e0f0)
   lib/test_bpf.c:7080:25: sparse: sparse: cast truncates bits from constant value (102030405060708 becomes 5060708)
   lib/test_bpf.c:7081:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d00708 becomes c0d00708)
   lib/test_bpf.c:7101:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e0f0 becomes c0d0e0f0)
   lib/test_bpf.c:7102:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:7103:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d08788 becomes c0d08788)
   lib/test_bpf.c:7123:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e0f0 becomes c0d0e0f0)
   lib/test_bpf.c:7124:25: sparse: sparse: cast truncates bits from constant value (102030405060708 becomes 5060708)
   lib/test_bpf.c:7125:25: sparse: sparse: cast truncates bits from constant value (8090a0b005060708 becomes 5060708)
   lib/test_bpf.c:7145:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e0f0 becomes c0d0e0f0)
   lib/test_bpf.c:7146:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:7147:25: sparse: sparse: cast truncates bits from constant value (8090a0b085868788 becomes 85868788)
   lib/test_bpf.c:7301:25: sparse: sparse: cast truncates bits from constant value (ffff00000000ffff becomes ffff)
   lib/test_bpf.c:7347:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7365:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
>> lib/test_bpf.c:7480:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7481:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7482:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7483:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7485:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7486:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7487:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7488:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7500:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7501:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7502:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7503:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7505:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7506:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7507:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7508:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7520:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7521:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7522:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7523:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7525:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7526:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7527:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7528:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7540:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7541:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7542:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7543:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7545:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7546:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7547:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7548:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7560:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7561:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7562:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7563:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:7653:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7654:25: sparse: sparse: cast truncates bits from constant value (fecdba9876543210 becomes 76543210)
   lib/test_bpf.c:7670:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7671:25: sparse: sparse: cast truncates bits from constant value (fecdba9876543210 becomes 76543210)
   lib/test_bpf.c:7688:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7689:25: sparse: sparse: cast truncates bits from constant value (fecdba9876543210 becomes 76543210)
   lib/test_bpf.c:7706:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7707:25: sparse: sparse: cast truncates bits from constant value (fecdba9876543210 becomes 76543210)
   lib/test_bpf.c:7725:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7726:25: sparse: sparse: cast truncates bits from constant value (fecdba9876543210 becomes 76543210)
   lib/test_bpf.c:7730:25: sparse: sparse: cast truncates bits from constant value (fecdba9876543210 becomes 76543210)
   lib/test_bpf.c:8933:25: sparse: sparse: cast truncates bits from constant value (eeeeeeeeeeeeeeee becomes eeeeeeee)
   lib/test_bpf.c:8962:25: sparse: sparse: cast truncates bits from constant value (eeeeeeeeeeeeeeee becomes eeeeeeee)
   lib/test_bpf.c:8977:25: sparse: sparse: cast truncates bits from constant value (eeeeeeeeeeeeeeee becomes eeeeeeee)
   lib/test_bpf.c:9006:25: sparse: sparse: cast truncates bits from constant value (eeeeeeeeeeeeeeee becomes eeeeeeee)

vim +7480 lib/test_bpf.c

89b63462765cc0 Johan Almbladh     2021-10-01   7402  
e4517b3637c648 Johan Almbladh     2021-08-09   7403  #define BPF_ATOMIC_OP_TEST1(width, op, logic, old, update, result)	\
e4517b3637c648 Johan Almbladh     2021-08-09   7404  {									\
e4517b3637c648 Johan Almbladh     2021-08-09   7405  	"BPF_ATOMIC | " #width ", " #op ": Test: "			\
e4517b3637c648 Johan Almbladh     2021-08-09   7406  		#old " " #logic " " #update " = " #result,		\
e4517b3637c648 Johan Almbladh     2021-08-09   7407  	.u.insns_int = {						\
89b63462765cc0 Johan Almbladh     2021-10-01   7408  		BPF_LD_IMM64(R5, (update) | BPF_ATOMIC_POISON(width)),	\
e4517b3637c648 Johan Almbladh     2021-08-09   7409  		BPF_ST_MEM(width, R10, -40, old),			\
e4517b3637c648 Johan Almbladh     2021-08-09   7410  		BPF_ATOMIC_OP(width, op, R10, R5, -40),			\
e4517b3637c648 Johan Almbladh     2021-08-09   7411  		BPF_LDX_MEM(width, R0, R10, -40),			\
89b63462765cc0 Johan Almbladh     2021-10-01   7412  		BPF_ALU64_REG(BPF_MOV, R1, R0),				\
89b63462765cc0 Johan Almbladh     2021-10-01   7413  		BPF_ALU64_IMM(BPF_RSH, R1, 32),				\
89b63462765cc0 Johan Almbladh     2021-10-01   7414  		BPF_ALU64_REG(BPF_OR, R0, R1),				\
e4517b3637c648 Johan Almbladh     2021-08-09   7415  		BPF_EXIT_INSN(),					\
e4517b3637c648 Johan Almbladh     2021-08-09   7416  	},								\
e4517b3637c648 Johan Almbladh     2021-08-09   7417  	INTERNAL,							\
e4517b3637c648 Johan Almbladh     2021-08-09   7418  	{ },								\
e4517b3637c648 Johan Almbladh     2021-08-09   7419  	{ { 0, result } },						\
e4517b3637c648 Johan Almbladh     2021-08-09   7420  	.stack_depth = 40,						\
e4517b3637c648 Johan Almbladh     2021-08-09   7421  }
e4517b3637c648 Johan Almbladh     2021-08-09   7422  #define BPF_ATOMIC_OP_TEST2(width, op, logic, old, update, result)	\
e4517b3637c648 Johan Almbladh     2021-08-09   7423  {									\
e4517b3637c648 Johan Almbladh     2021-08-09   7424  	"BPF_ATOMIC | " #width ", " #op ": Test side effects, r10: "	\
e4517b3637c648 Johan Almbladh     2021-08-09   7425  		#old " " #logic " " #update " = " #result,		\
e4517b3637c648 Johan Almbladh     2021-08-09   7426  	.u.insns_int = {						\
e4517b3637c648 Johan Almbladh     2021-08-09   7427  		BPF_ALU64_REG(BPF_MOV, R1, R10),			\
89b63462765cc0 Johan Almbladh     2021-10-01   7428  		BPF_LD_IMM64(R0, (update) | BPF_ATOMIC_POISON(width)),	\
e4517b3637c648 Johan Almbladh     2021-08-09   7429  		BPF_ST_MEM(BPF_W, R10, -40, old),			\
e4517b3637c648 Johan Almbladh     2021-08-09   7430  		BPF_ATOMIC_OP(width, op, R10, R0, -40),			\
e4517b3637c648 Johan Almbladh     2021-08-09   7431  		BPF_ALU64_REG(BPF_MOV, R0, R10),			\
e4517b3637c648 Johan Almbladh     2021-08-09   7432  		BPF_ALU64_REG(BPF_SUB, R0, R1),				\
89b63462765cc0 Johan Almbladh     2021-10-01   7433  		BPF_ALU64_REG(BPF_MOV, R1, R0),				\
89b63462765cc0 Johan Almbladh     2021-10-01   7434  		BPF_ALU64_IMM(BPF_RSH, R1, 32),				\
89b63462765cc0 Johan Almbladh     2021-10-01   7435  		BPF_ALU64_REG(BPF_OR, R0, R1),				\
e4517b3637c648 Johan Almbladh     2021-08-09   7436  		BPF_EXIT_INSN(),					\
e4517b3637c648 Johan Almbladh     2021-08-09   7437  	},								\
e4517b3637c648 Johan Almbladh     2021-08-09   7438  	INTERNAL,							\
e4517b3637c648 Johan Almbladh     2021-08-09   7439  	{ },								\
e4517b3637c648 Johan Almbladh     2021-08-09   7440  	{ { 0, 0 } },							\
e4517b3637c648 Johan Almbladh     2021-08-09   7441  	.stack_depth = 40,						\
e4517b3637c648 Johan Almbladh     2021-08-09   7442  }
e4517b3637c648 Johan Almbladh     2021-08-09   7443  #define BPF_ATOMIC_OP_TEST3(width, op, logic, old, update, result)	\
e4517b3637c648 Johan Almbladh     2021-08-09   7444  {									\
e4517b3637c648 Johan Almbladh     2021-08-09   7445  	"BPF_ATOMIC | " #width ", " #op ": Test side effects, r0: "	\
e4517b3637c648 Johan Almbladh     2021-08-09   7446  		#old " " #logic " " #update " = " #result,		\
e4517b3637c648 Johan Almbladh     2021-08-09   7447  	.u.insns_int = {						\
e4517b3637c648 Johan Almbladh     2021-08-09   7448  		BPF_ALU64_REG(BPF_MOV, R0, R10),			\
89b63462765cc0 Johan Almbladh     2021-10-01   7449  		BPF_LD_IMM64(R1, (update) | BPF_ATOMIC_POISON(width)),	\
e4517b3637c648 Johan Almbladh     2021-08-09   7450  		BPF_ST_MEM(width, R10, -40, old),			\
e4517b3637c648 Johan Almbladh     2021-08-09   7451  		BPF_ATOMIC_OP(width, op, R10, R1, -40),			\
e4517b3637c648 Johan Almbladh     2021-08-09   7452  		BPF_ALU64_REG(BPF_SUB, R0, R10),			\
89b63462765cc0 Johan Almbladh     2021-10-01   7453  		BPF_ALU64_REG(BPF_MOV, R1, R0),				\
89b63462765cc0 Johan Almbladh     2021-10-01   7454  		BPF_ALU64_IMM(BPF_RSH, R1, 32),				\
89b63462765cc0 Johan Almbladh     2021-10-01   7455  		BPF_ALU64_REG(BPF_OR, R0, R1),				\
e4517b3637c648 Johan Almbladh     2021-08-09   7456  		BPF_EXIT_INSN(),					\
e4517b3637c648 Johan Almbladh     2021-08-09   7457  	},								\
e4517b3637c648 Johan Almbladh     2021-08-09   7458  	INTERNAL,                                                       \
e4517b3637c648 Johan Almbladh     2021-08-09   7459  	{ },                                                            \
e4517b3637c648 Johan Almbladh     2021-08-09   7460  	{ { 0, 0 } },                                                   \
e4517b3637c648 Johan Almbladh     2021-08-09   7461  	.stack_depth = 40,                                              \
e4517b3637c648 Johan Almbladh     2021-08-09   7462  }
e4517b3637c648 Johan Almbladh     2021-08-09   7463  #define BPF_ATOMIC_OP_TEST4(width, op, logic, old, update, result)	\
e4517b3637c648 Johan Almbladh     2021-08-09   7464  {									\
e4517b3637c648 Johan Almbladh     2021-08-09   7465  	"BPF_ATOMIC | " #width ", " #op ": Test fetch: "		\
e4517b3637c648 Johan Almbladh     2021-08-09   7466  		#old " " #logic " " #update " = " #result,		\
e4517b3637c648 Johan Almbladh     2021-08-09   7467  	.u.insns_int = {						\
89b63462765cc0 Johan Almbladh     2021-10-01   7468  		BPF_LD_IMM64(R3, (update) | BPF_ATOMIC_POISON(width)),	\
e4517b3637c648 Johan Almbladh     2021-08-09   7469  		BPF_ST_MEM(width, R10, -40, old),			\
e4517b3637c648 Johan Almbladh     2021-08-09   7470  		BPF_ATOMIC_OP(width, op, R10, R3, -40),			\
89b63462765cc0 Johan Almbladh     2021-10-01   7471  		BPF_ALU32_REG(BPF_MOV, R0, R3),                         \
e4517b3637c648 Johan Almbladh     2021-08-09   7472  		BPF_EXIT_INSN(),					\
e4517b3637c648 Johan Almbladh     2021-08-09   7473  	},								\
e4517b3637c648 Johan Almbladh     2021-08-09   7474  	INTERNAL,                                                       \
e4517b3637c648 Johan Almbladh     2021-08-09   7475  	{ },                                                            \
e4517b3637c648 Johan Almbladh     2021-08-09   7476  	{ { 0, (op) & BPF_FETCH ? old : update } },			\
e4517b3637c648 Johan Almbladh     2021-08-09   7477  	.stack_depth = 40,                                              \
e4517b3637c648 Johan Almbladh     2021-08-09   7478  }
e4517b3637c648 Johan Almbladh     2021-08-09   7479  	/* BPF_ATOMIC | BPF_W: BPF_ADD */
e4517b3637c648 Johan Almbladh     2021-08-09  @7480  	BPF_ATOMIC_OP_TEST1(BPF_W, BPF_ADD, +, 0x12, 0xab, 0xbd),
e4517b3637c648 Johan Almbladh     2021-08-09   7481  	BPF_ATOMIC_OP_TEST2(BPF_W, BPF_ADD, +, 0x12, 0xab, 0xbd),
e4517b3637c648 Johan Almbladh     2021-08-09   7482  	BPF_ATOMIC_OP_TEST3(BPF_W, BPF_ADD, +, 0x12, 0xab, 0xbd),
e4517b3637c648 Johan Almbladh     2021-08-09   7483  	BPF_ATOMIC_OP_TEST4(BPF_W, BPF_ADD, +, 0x12, 0xab, 0xbd),
e4517b3637c648 Johan Almbladh     2021-08-09   7484  	/* BPF_ATOMIC | BPF_W: BPF_ADD | BPF_FETCH */
e4517b3637c648 Johan Almbladh     2021-08-09   7485  	BPF_ATOMIC_OP_TEST1(BPF_W, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
e4517b3637c648 Johan Almbladh     2021-08-09   7486  	BPF_ATOMIC_OP_TEST2(BPF_W, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
e4517b3637c648 Johan Almbladh     2021-08-09   7487  	BPF_ATOMIC_OP_TEST3(BPF_W, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
e4517b3637c648 Johan Almbladh     2021-08-09   7488  	BPF_ATOMIC_OP_TEST4(BPF_W, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
e4517b3637c648 Johan Almbladh     2021-08-09   7489  	/* BPF_ATOMIC | BPF_DW: BPF_ADD */
e4517b3637c648 Johan Almbladh     2021-08-09   7490  	BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_ADD, +, 0x12, 0xab, 0xbd),
e4517b3637c648 Johan Almbladh     2021-08-09   7491  	BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_ADD, +, 0x12, 0xab, 0xbd),
e4517b3637c648 Johan Almbladh     2021-08-09   7492  	BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_ADD, +, 0x12, 0xab, 0xbd),
e4517b3637c648 Johan Almbladh     2021-08-09   7493  	BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_ADD, +, 0x12, 0xab, 0xbd),
e4517b3637c648 Johan Almbladh     2021-08-09   7494  	/* BPF_ATOMIC | BPF_DW: BPF_ADD | BPF_FETCH */
e4517b3637c648 Johan Almbladh     2021-08-09   7495  	BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
e4517b3637c648 Johan Almbladh     2021-08-09   7496  	BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
e4517b3637c648 Johan Almbladh     2021-08-09   7497  	BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
e4517b3637c648 Johan Almbladh     2021-08-09   7498  	BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
e4517b3637c648 Johan Almbladh     2021-08-09   7499  	/* BPF_ATOMIC | BPF_W: BPF_AND */
e4517b3637c648 Johan Almbladh     2021-08-09   7500  	BPF_ATOMIC_OP_TEST1(BPF_W, BPF_AND, &, 0x12, 0xab, 0x02),
e4517b3637c648 Johan Almbladh     2021-08-09   7501  	BPF_ATOMIC_OP_TEST2(BPF_W, BPF_AND, &, 0x12, 0xab, 0x02),
e4517b3637c648 Johan Almbladh     2021-08-09   7502  	BPF_ATOMIC_OP_TEST3(BPF_W, BPF_AND, &, 0x12, 0xab, 0x02),
e4517b3637c648 Johan Almbladh     2021-08-09   7503  	BPF_ATOMIC_OP_TEST4(BPF_W, BPF_AND, &, 0x12, 0xab, 0x02),
e4517b3637c648 Johan Almbladh     2021-08-09   7504  	/* BPF_ATOMIC | BPF_W: BPF_AND | BPF_FETCH */
e4517b3637c648 Johan Almbladh     2021-08-09   7505  	BPF_ATOMIC_OP_TEST1(BPF_W, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
e4517b3637c648 Johan Almbladh     2021-08-09   7506  	BPF_ATOMIC_OP_TEST2(BPF_W, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
e4517b3637c648 Johan Almbladh     2021-08-09   7507  	BPF_ATOMIC_OP_TEST3(BPF_W, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
e4517b3637c648 Johan Almbladh     2021-08-09   7508  	BPF_ATOMIC_OP_TEST4(BPF_W, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
e4517b3637c648 Johan Almbladh     2021-08-09   7509  	/* BPF_ATOMIC | BPF_DW: BPF_AND */
e4517b3637c648 Johan Almbladh     2021-08-09   7510  	BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_AND, &, 0x12, 0xab, 0x02),
e4517b3637c648 Johan Almbladh     2021-08-09   7511  	BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_AND, &, 0x12, 0xab, 0x02),
e4517b3637c648 Johan Almbladh     2021-08-09   7512  	BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_AND, &, 0x12, 0xab, 0x02),
e4517b3637c648 Johan Almbladh     2021-08-09   7513  	BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_AND, &, 0x12, 0xab, 0x02),
e4517b3637c648 Johan Almbladh     2021-08-09   7514  	/* BPF_ATOMIC | BPF_DW: BPF_AND | BPF_FETCH */
e4517b3637c648 Johan Almbladh     2021-08-09   7515  	BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
e4517b3637c648 Johan Almbladh     2021-08-09   7516  	BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
e4517b3637c648 Johan Almbladh     2021-08-09   7517  	BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
e4517b3637c648 Johan Almbladh     2021-08-09   7518  	BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
e4517b3637c648 Johan Almbladh     2021-08-09   7519  	/* BPF_ATOMIC | BPF_W: BPF_OR */
e4517b3637c648 Johan Almbladh     2021-08-09   7520  	BPF_ATOMIC_OP_TEST1(BPF_W, BPF_OR, |, 0x12, 0xab, 0xbb),
e4517b3637c648 Johan Almbladh     2021-08-09   7521  	BPF_ATOMIC_OP_TEST2(BPF_W, BPF_OR, |, 0x12, 0xab, 0xbb),
e4517b3637c648 Johan Almbladh     2021-08-09   7522  	BPF_ATOMIC_OP_TEST3(BPF_W, BPF_OR, |, 0x12, 0xab, 0xbb),
e4517b3637c648 Johan Almbladh     2021-08-09   7523  	BPF_ATOMIC_OP_TEST4(BPF_W, BPF_OR, |, 0x12, 0xab, 0xbb),
e4517b3637c648 Johan Almbladh     2021-08-09   7524  	/* BPF_ATOMIC | BPF_W: BPF_OR | BPF_FETCH */
e4517b3637c648 Johan Almbladh     2021-08-09   7525  	BPF_ATOMIC_OP_TEST1(BPF_W, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
e4517b3637c648 Johan Almbladh     2021-08-09   7526  	BPF_ATOMIC_OP_TEST2(BPF_W, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
e4517b3637c648 Johan Almbladh     2021-08-09   7527  	BPF_ATOMIC_OP_TEST3(BPF_W, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
e4517b3637c648 Johan Almbladh     2021-08-09   7528  	BPF_ATOMIC_OP_TEST4(BPF_W, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
e4517b3637c648 Johan Almbladh     2021-08-09   7529  	/* BPF_ATOMIC | BPF_DW: BPF_OR */
e4517b3637c648 Johan Almbladh     2021-08-09   7530  	BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_OR, |, 0x12, 0xab, 0xbb),
e4517b3637c648 Johan Almbladh     2021-08-09   7531  	BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_OR, |, 0x12, 0xab, 0xbb),
e4517b3637c648 Johan Almbladh     2021-08-09   7532  	BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_OR, |, 0x12, 0xab, 0xbb),
e4517b3637c648 Johan Almbladh     2021-08-09   7533  	BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_OR, |, 0x12, 0xab, 0xbb),
e4517b3637c648 Johan Almbladh     2021-08-09   7534  	/* BPF_ATOMIC | BPF_DW: BPF_OR | BPF_FETCH */
e4517b3637c648 Johan Almbladh     2021-08-09   7535  	BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
e4517b3637c648 Johan Almbladh     2021-08-09   7536  	BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
e4517b3637c648 Johan Almbladh     2021-08-09   7537  	BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
e4517b3637c648 Johan Almbladh     2021-08-09   7538  	BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
e4517b3637c648 Johan Almbladh     2021-08-09   7539  	/* BPF_ATOMIC | BPF_W: BPF_XOR */
e4517b3637c648 Johan Almbladh     2021-08-09   7540  	BPF_ATOMIC_OP_TEST1(BPF_W, BPF_XOR, ^, 0x12, 0xab, 0xb9),
e4517b3637c648 Johan Almbladh     2021-08-09   7541  	BPF_ATOMIC_OP_TEST2(BPF_W, BPF_XOR, ^, 0x12, 0xab, 0xb9),
e4517b3637c648 Johan Almbladh     2021-08-09   7542  	BPF_ATOMIC_OP_TEST3(BPF_W, BPF_XOR, ^, 0x12, 0xab, 0xb9),
e4517b3637c648 Johan Almbladh     2021-08-09   7543  	BPF_ATOMIC_OP_TEST4(BPF_W, BPF_XOR, ^, 0x12, 0xab, 0xb9),
e4517b3637c648 Johan Almbladh     2021-08-09   7544  	/* BPF_ATOMIC | BPF_W: BPF_XOR | BPF_FETCH */
e4517b3637c648 Johan Almbladh     2021-08-09   7545  	BPF_ATOMIC_OP_TEST1(BPF_W, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
e4517b3637c648 Johan Almbladh     2021-08-09   7546  	BPF_ATOMIC_OP_TEST2(BPF_W, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
e4517b3637c648 Johan Almbladh     2021-08-09   7547  	BPF_ATOMIC_OP_TEST3(BPF_W, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
e4517b3637c648 Johan Almbladh     2021-08-09   7548  	BPF_ATOMIC_OP_TEST4(BPF_W, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
e4517b3637c648 Johan Almbladh     2021-08-09   7549  	/* BPF_ATOMIC | BPF_DW: BPF_XOR */
e4517b3637c648 Johan Almbladh     2021-08-09   7550  	BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_XOR, ^, 0x12, 0xab, 0xb9),
e4517b3637c648 Johan Almbladh     2021-08-09   7551  	BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_XOR, ^, 0x12, 0xab, 0xb9),
e4517b3637c648 Johan Almbladh     2021-08-09   7552  	BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_XOR, ^, 0x12, 0xab, 0xb9),
e4517b3637c648 Johan Almbladh     2021-08-09   7553  	BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_XOR, ^, 0x12, 0xab, 0xb9),
e4517b3637c648 Johan Almbladh     2021-08-09   7554  	/* BPF_ATOMIC | BPF_DW: BPF_XOR | BPF_FETCH */
e4517b3637c648 Johan Almbladh     2021-08-09   7555  	BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
e4517b3637c648 Johan Almbladh     2021-08-09   7556  	BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
e4517b3637c648 Johan Almbladh     2021-08-09   7557  	BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
e4517b3637c648 Johan Almbladh     2021-08-09   7558  	BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
e4517b3637c648 Johan Almbladh     2021-08-09   7559  	/* BPF_ATOMIC | BPF_W: BPF_XCHG */
e4517b3637c648 Johan Almbladh     2021-08-09   7560  	BPF_ATOMIC_OP_TEST1(BPF_W, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
e4517b3637c648 Johan Almbladh     2021-08-09   7561  	BPF_ATOMIC_OP_TEST2(BPF_W, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
e4517b3637c648 Johan Almbladh     2021-08-09   7562  	BPF_ATOMIC_OP_TEST3(BPF_W, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
e4517b3637c648 Johan Almbladh     2021-08-09   7563  	BPF_ATOMIC_OP_TEST4(BPF_W, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
e4517b3637c648 Johan Almbladh     2021-08-09   7564  	/* BPF_ATOMIC | BPF_DW: BPF_XCHG */
e4517b3637c648 Johan Almbladh     2021-08-09   7565  	BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
e4517b3637c648 Johan Almbladh     2021-08-09   7566  	BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
e4517b3637c648 Johan Almbladh     2021-08-09   7567  	BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
e4517b3637c648 Johan Almbladh     2021-08-09   7568  	BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
89b63462765cc0 Johan Almbladh     2021-10-01   7569  #undef BPF_ATOMIC_POISON
e4517b3637c648 Johan Almbladh     2021-08-09   7570  #undef BPF_ATOMIC_OP_TEST1
e4517b3637c648 Johan Almbladh     2021-08-09   7571  #undef BPF_ATOMIC_OP_TEST2
e4517b3637c648 Johan Almbladh     2021-08-09   7572  #undef BPF_ATOMIC_OP_TEST3
e4517b3637c648 Johan Almbladh     2021-08-09   7573  #undef BPF_ATOMIC_OP_TEST4
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7574  	/* BPF_ATOMIC | BPF_W, BPF_CMPXCHG */
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7575  	{
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7576  		"BPF_ATOMIC | BPF_W, BPF_CMPXCHG: Test successful return",
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7577  		.u.insns_int = {
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7578  			BPF_ST_MEM(BPF_W, R10, -40, 0x01234567),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7579  			BPF_ALU32_IMM(BPF_MOV, R0, 0x01234567),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7580  			BPF_ALU32_IMM(BPF_MOV, R3, 0x89abcdef),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7581  			BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R3, -40),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7582  			BPF_EXIT_INSN(),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7583  		},
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7584  		INTERNAL,
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7585  		{ },
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7586  		{ { 0, 0x01234567 } },
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7587  		.stack_depth = 40,
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7588  	},
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7589  	{
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7590  		"BPF_ATOMIC | BPF_W, BPF_CMPXCHG: Test successful store",
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7591  		.u.insns_int = {
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7592  			BPF_ST_MEM(BPF_W, R10, -40, 0x01234567),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7593  			BPF_ALU32_IMM(BPF_MOV, R0, 0x01234567),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7594  			BPF_ALU32_IMM(BPF_MOV, R3, 0x89abcdef),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7595  			BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R3, -40),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7596  			BPF_LDX_MEM(BPF_W, R0, R10, -40),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7597  			BPF_EXIT_INSN(),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7598  		},
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7599  		INTERNAL,
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7600  		{ },
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7601  		{ { 0, 0x89abcdef } },
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7602  		.stack_depth = 40,
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7603  	},
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7604  	{
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7605  		"BPF_ATOMIC | BPF_W, BPF_CMPXCHG: Test failure return",
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7606  		.u.insns_int = {
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7607  			BPF_ST_MEM(BPF_W, R10, -40, 0x01234567),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7608  			BPF_ALU32_IMM(BPF_MOV, R0, 0x76543210),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7609  			BPF_ALU32_IMM(BPF_MOV, R3, 0x89abcdef),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7610  			BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R3, -40),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7611  			BPF_EXIT_INSN(),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7612  		},
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7613  		INTERNAL,
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7614  		{ },
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7615  		{ { 0, 0x01234567 } },
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7616  		.stack_depth = 40,
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7617  	},
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7618  	{
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7619  		"BPF_ATOMIC | BPF_W, BPF_CMPXCHG: Test failure store",
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7620  		.u.insns_int = {
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7621  			BPF_ST_MEM(BPF_W, R10, -40, 0x01234567),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7622  			BPF_ALU32_IMM(BPF_MOV, R0, 0x76543210),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7623  			BPF_ALU32_IMM(BPF_MOV, R3, 0x89abcdef),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7624  			BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R3, -40),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7625  			BPF_LDX_MEM(BPF_W, R0, R10, -40),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7626  			BPF_EXIT_INSN(),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7627  		},
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7628  		INTERNAL,
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7629  		{ },
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7630  		{ { 0, 0x01234567 } },
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7631  		.stack_depth = 40,
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7632  	},
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7633  	{
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7634  		"BPF_ATOMIC | BPF_W, BPF_CMPXCHG: Test side effects",
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7635  		.u.insns_int = {
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7636  			BPF_ST_MEM(BPF_W, R10, -40, 0x01234567),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7637  			BPF_ALU32_IMM(BPF_MOV, R0, 0x01234567),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7638  			BPF_ALU32_IMM(BPF_MOV, R3, 0x89abcdef),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7639  			BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R3, -40),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7640  			BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R3, -40),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7641  			BPF_ALU32_REG(BPF_MOV, R0, R3),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7642  			BPF_EXIT_INSN(),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7643  		},
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7644  		INTERNAL,
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7645  		{ },
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7646  		{ { 0, 0x89abcdef } },
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7647  		.stack_depth = 40,
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7648  	},
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7649  	/* BPF_ATOMIC | BPF_DW, BPF_CMPXCHG */
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7650  	{
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7651  		"BPF_ATOMIC | BPF_DW, BPF_CMPXCHG: Test successful return",
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7652  		.u.insns_int = {
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7653  			BPF_LD_IMM64(R1, 0x0123456789abcdefULL),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7654  			BPF_LD_IMM64(R2, 0xfecdba9876543210ULL),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7655  			BPF_ALU64_REG(BPF_MOV, R0, R1),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7656  			BPF_STX_MEM(BPF_DW, R10, R1, -40),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7657  			BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -40),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7658  			BPF_JMP_REG(BPF_JNE, R0, R1, 1),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7659  			BPF_ALU64_REG(BPF_SUB, R0, R1),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7660  			BPF_EXIT_INSN(),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7661  		},
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7662  		INTERNAL,
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7663  		{ },
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7664  		{ { 0, 0 } },
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7665  		.stack_depth = 40,
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7666  	},
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7667  	{
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7668  		"BPF_ATOMIC | BPF_DW, BPF_CMPXCHG: Test successful store",
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7669  		.u.insns_int = {
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7670  			BPF_LD_IMM64(R1, 0x0123456789abcdefULL),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7671  			BPF_LD_IMM64(R2, 0xfecdba9876543210ULL),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7672  			BPF_ALU64_REG(BPF_MOV, R0, R1),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7673  			BPF_STX_MEM(BPF_DW, R10, R0, -40),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7674  			BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -40),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7675  			BPF_LDX_MEM(BPF_DW, R0, R10, -40),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7676  			BPF_JMP_REG(BPF_JNE, R0, R2, 1),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7677  			BPF_ALU64_REG(BPF_SUB, R0, R2),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7678  			BPF_EXIT_INSN(),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7679  		},
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7680  		INTERNAL,
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7681  		{ },
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7682  		{ { 0, 0 } },
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7683  		.stack_depth = 40,
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7684  	},
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7685  	{
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7686  		"BPF_ATOMIC | BPF_DW, BPF_CMPXCHG: Test failure return",
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7687  		.u.insns_int = {
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7688  			BPF_LD_IMM64(R1, 0x0123456789abcdefULL),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7689  			BPF_LD_IMM64(R2, 0xfecdba9876543210ULL),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7690  			BPF_ALU64_REG(BPF_MOV, R0, R1),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7691  			BPF_ALU64_IMM(BPF_ADD, R0, 1),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7692  			BPF_STX_MEM(BPF_DW, R10, R1, -40),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7693  			BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -40),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7694  			BPF_JMP_REG(BPF_JNE, R0, R1, 1),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7695  			BPF_ALU64_REG(BPF_SUB, R0, R1),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7696  			BPF_EXIT_INSN(),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7697  		},
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7698  		INTERNAL,
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7699  		{ },
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7700  		{ { 0, 0 } },
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7701  		.stack_depth = 40,
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7702  	},
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7703  	{
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7704  		"BPF_ATOMIC | BPF_DW, BPF_CMPXCHG: Test failure store",
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7705  		.u.insns_int = {
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7706  			BPF_LD_IMM64(R1, 0x0123456789abcdefULL),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7707  			BPF_LD_IMM64(R2, 0xfecdba9876543210ULL),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7708  			BPF_ALU64_REG(BPF_MOV, R0, R1),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7709  			BPF_ALU64_IMM(BPF_ADD, R0, 1),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7710  			BPF_STX_MEM(BPF_DW, R10, R1, -40),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7711  			BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -40),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7712  			BPF_LDX_MEM(BPF_DW, R0, R10, -40),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7713  			BPF_JMP_REG(BPF_JNE, R0, R1, 1),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7714  			BPF_ALU64_REG(BPF_SUB, R0, R1),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7715  			BPF_EXIT_INSN(),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7716  		},
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7717  		INTERNAL,
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7718  		{ },
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7719  		{ { 0, 0 } },
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7720  		.stack_depth = 40,
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7721  	},
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7722  	{
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7723  		"BPF_ATOMIC | BPF_DW, BPF_CMPXCHG: Test side effects",
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7724  		.u.insns_int = {
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7725  			BPF_LD_IMM64(R1, 0x0123456789abcdefULL),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7726  			BPF_LD_IMM64(R2, 0xfecdba9876543210ULL),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7727  			BPF_ALU64_REG(BPF_MOV, R0, R1),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7728  			BPF_STX_MEM(BPF_DW, R10, R1, -40),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7729  			BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -40),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7730  			BPF_LD_IMM64(R0, 0xfecdba9876543210ULL),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7731  			BPF_JMP_REG(BPF_JNE, R0, R2, 1),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7732  			BPF_ALU64_REG(BPF_SUB, R0, R2),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7733  			BPF_EXIT_INSN(),
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7734  		},
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7735  		INTERNAL,
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7736  		{ },
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7737  		{ { 0, 0 } },
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7738  		.stack_depth = 40,
6a3b24ca489ea0 Johan Almbladh     2021-08-09   7739  	},
b55dfa85001545 Johan Almbladh     2021-08-09   7740  	/* BPF_JMP32 | BPF_JEQ | BPF_K */
b55dfa85001545 Johan Almbladh     2021-08-09   7741  	{
b55dfa85001545 Johan Almbladh     2021-08-09   7742  		"JMP32_JEQ_K: Small immediate",
b55dfa85001545 Johan Almbladh     2021-08-09   7743  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   7744  			BPF_ALU32_IMM(BPF_MOV, R0, 123),
b55dfa85001545 Johan Almbladh     2021-08-09   7745  			BPF_JMP32_IMM(BPF_JEQ, R0, 321, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7746  			BPF_JMP32_IMM(BPF_JEQ, R0, 123, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7747  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   7748  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   7749  		},
b55dfa85001545 Johan Almbladh     2021-08-09   7750  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   7751  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   7752  		{ { 0, 123 } }
b55dfa85001545 Johan Almbladh     2021-08-09   7753  	},
b55dfa85001545 Johan Almbladh     2021-08-09   7754  	{
b55dfa85001545 Johan Almbladh     2021-08-09   7755  		"JMP32_JEQ_K: Large immediate",
b55dfa85001545 Johan Almbladh     2021-08-09   7756  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   7757  			BPF_ALU32_IMM(BPF_MOV, R0, 12345678),
b55dfa85001545 Johan Almbladh     2021-08-09   7758  			BPF_JMP32_IMM(BPF_JEQ, R0, 12345678 & 0xffff, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7759  			BPF_JMP32_IMM(BPF_JEQ, R0, 12345678, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7760  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   7761  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   7762  		},
b55dfa85001545 Johan Almbladh     2021-08-09   7763  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   7764  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   7765  		{ { 0, 12345678 } }
b55dfa85001545 Johan Almbladh     2021-08-09   7766  	},
b55dfa85001545 Johan Almbladh     2021-08-09   7767  	{
b55dfa85001545 Johan Almbladh     2021-08-09   7768  		"JMP32_JEQ_K: negative immediate",
b55dfa85001545 Johan Almbladh     2021-08-09   7769  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   7770  			BPF_ALU32_IMM(BPF_MOV, R0, -123),
b55dfa85001545 Johan Almbladh     2021-08-09   7771  			BPF_JMP32_IMM(BPF_JEQ, R0,  123, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7772  			BPF_JMP32_IMM(BPF_JEQ, R0, -123, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7773  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   7774  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   7775  		},
b55dfa85001545 Johan Almbladh     2021-08-09   7776  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   7777  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   7778  		{ { 0, -123 } }
b55dfa85001545 Johan Almbladh     2021-08-09   7779  	},
b55dfa85001545 Johan Almbladh     2021-08-09   7780  	/* BPF_JMP32 | BPF_JEQ | BPF_X */
b55dfa85001545 Johan Almbladh     2021-08-09   7781  	{
b55dfa85001545 Johan Almbladh     2021-08-09   7782  		"JMP32_JEQ_X",
b55dfa85001545 Johan Almbladh     2021-08-09   7783  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   7784  			BPF_ALU32_IMM(BPF_MOV, R0, 1234),
b55dfa85001545 Johan Almbladh     2021-08-09   7785  			BPF_ALU32_IMM(BPF_MOV, R1, 4321),
b55dfa85001545 Johan Almbladh     2021-08-09   7786  			BPF_JMP32_REG(BPF_JEQ, R0, R1, 2),
b55dfa85001545 Johan Almbladh     2021-08-09   7787  			BPF_ALU32_IMM(BPF_MOV, R1, 1234),
b55dfa85001545 Johan Almbladh     2021-08-09   7788  			BPF_JMP32_REG(BPF_JEQ, R0, R1, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7789  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   7790  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   7791  		},
b55dfa85001545 Johan Almbladh     2021-08-09   7792  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   7793  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   7794  		{ { 0, 1234 } }
b55dfa85001545 Johan Almbladh     2021-08-09   7795  	},
b55dfa85001545 Johan Almbladh     2021-08-09   7796  	/* BPF_JMP32 | BPF_JNE | BPF_K */
b55dfa85001545 Johan Almbladh     2021-08-09   7797  	{
b55dfa85001545 Johan Almbladh     2021-08-09   7798  		"JMP32_JNE_K: Small immediate",
b55dfa85001545 Johan Almbladh     2021-08-09   7799  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   7800  			BPF_ALU32_IMM(BPF_MOV, R0, 123),
b55dfa85001545 Johan Almbladh     2021-08-09   7801  			BPF_JMP32_IMM(BPF_JNE, R0, 123, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7802  			BPF_JMP32_IMM(BPF_JNE, R0, 321, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7803  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   7804  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   7805  		},
b55dfa85001545 Johan Almbladh     2021-08-09   7806  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   7807  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   7808  		{ { 0, 123 } }
b55dfa85001545 Johan Almbladh     2021-08-09   7809  	},
b55dfa85001545 Johan Almbladh     2021-08-09   7810  	{
b55dfa85001545 Johan Almbladh     2021-08-09   7811  		"JMP32_JNE_K: Large immediate",
b55dfa85001545 Johan Almbladh     2021-08-09   7812  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   7813  			BPF_ALU32_IMM(BPF_MOV, R0, 12345678),
b55dfa85001545 Johan Almbladh     2021-08-09   7814  			BPF_JMP32_IMM(BPF_JNE, R0, 12345678, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7815  			BPF_JMP32_IMM(BPF_JNE, R0, 12345678 & 0xffff, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7816  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   7817  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   7818  		},
b55dfa85001545 Johan Almbladh     2021-08-09   7819  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   7820  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   7821  		{ { 0, 12345678 } }
b55dfa85001545 Johan Almbladh     2021-08-09   7822  	},
b55dfa85001545 Johan Almbladh     2021-08-09   7823  	{
b55dfa85001545 Johan Almbladh     2021-08-09   7824  		"JMP32_JNE_K: negative immediate",
b55dfa85001545 Johan Almbladh     2021-08-09   7825  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   7826  			BPF_ALU32_IMM(BPF_MOV, R0, -123),
b55dfa85001545 Johan Almbladh     2021-08-09   7827  			BPF_JMP32_IMM(BPF_JNE, R0, -123, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7828  			BPF_JMP32_IMM(BPF_JNE, R0,  123, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7829  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   7830  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   7831  		},
b55dfa85001545 Johan Almbladh     2021-08-09   7832  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   7833  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   7834  		{ { 0, -123 } }
b55dfa85001545 Johan Almbladh     2021-08-09   7835  	},
b55dfa85001545 Johan Almbladh     2021-08-09   7836  	/* BPF_JMP32 | BPF_JNE | BPF_X */
b55dfa85001545 Johan Almbladh     2021-08-09   7837  	{
b55dfa85001545 Johan Almbladh     2021-08-09   7838  		"JMP32_JNE_X",
b55dfa85001545 Johan Almbladh     2021-08-09   7839  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   7840  			BPF_ALU32_IMM(BPF_MOV, R0, 1234),
b55dfa85001545 Johan Almbladh     2021-08-09   7841  			BPF_ALU32_IMM(BPF_MOV, R1, 1234),
b55dfa85001545 Johan Almbladh     2021-08-09   7842  			BPF_JMP32_REG(BPF_JNE, R0, R1, 2),
b55dfa85001545 Johan Almbladh     2021-08-09   7843  			BPF_ALU32_IMM(BPF_MOV, R1, 4321),
b55dfa85001545 Johan Almbladh     2021-08-09   7844  			BPF_JMP32_REG(BPF_JNE, R0, R1, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7845  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   7846  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   7847  		},
b55dfa85001545 Johan Almbladh     2021-08-09   7848  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   7849  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   7850  		{ { 0, 1234 } }
b55dfa85001545 Johan Almbladh     2021-08-09   7851  	},
b55dfa85001545 Johan Almbladh     2021-08-09   7852  	/* BPF_JMP32 | BPF_JSET | BPF_K */
b55dfa85001545 Johan Almbladh     2021-08-09   7853  	{
b55dfa85001545 Johan Almbladh     2021-08-09   7854  		"JMP32_JSET_K: Small immediate",
b55dfa85001545 Johan Almbladh     2021-08-09   7855  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   7856  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7857  			BPF_JMP32_IMM(BPF_JSET, R0, 2, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7858  			BPF_JMP32_IMM(BPF_JSET, R0, 3, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7859  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   7860  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   7861  		},
b55dfa85001545 Johan Almbladh     2021-08-09   7862  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   7863  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   7864  		{ { 0, 1 } }
b55dfa85001545 Johan Almbladh     2021-08-09   7865  	},
b55dfa85001545 Johan Almbladh     2021-08-09   7866  	{
b55dfa85001545 Johan Almbladh     2021-08-09   7867  		"JMP32_JSET_K: Large immediate",
b55dfa85001545 Johan Almbladh     2021-08-09   7868  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   7869  			BPF_ALU32_IMM(BPF_MOV, R0, 0x40000000),
b55dfa85001545 Johan Almbladh     2021-08-09   7870  			BPF_JMP32_IMM(BPF_JSET, R0, 0x3fffffff, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7871  			BPF_JMP32_IMM(BPF_JSET, R0, 0x60000000, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7872  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   7873  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   7874  		},
b55dfa85001545 Johan Almbladh     2021-08-09   7875  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   7876  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   7877  		{ { 0, 0x40000000 } }
b55dfa85001545 Johan Almbladh     2021-08-09   7878  	},
b55dfa85001545 Johan Almbladh     2021-08-09   7879  	{
b55dfa85001545 Johan Almbladh     2021-08-09   7880  		"JMP32_JSET_K: negative immediate",
b55dfa85001545 Johan Almbladh     2021-08-09   7881  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   7882  			BPF_ALU32_IMM(BPF_MOV, R0, -123),
b55dfa85001545 Johan Almbladh     2021-08-09   7883  			BPF_JMP32_IMM(BPF_JSET, R0, -1, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7884  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   7885  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   7886  		},
b55dfa85001545 Johan Almbladh     2021-08-09   7887  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   7888  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   7889  		{ { 0, -123 } }
b55dfa85001545 Johan Almbladh     2021-08-09   7890  	},
b55dfa85001545 Johan Almbladh     2021-08-09   7891  	/* BPF_JMP32 | BPF_JSET | BPF_X */
b55dfa85001545 Johan Almbladh     2021-08-09   7892  	{
b55dfa85001545 Johan Almbladh     2021-08-09   7893  		"JMP32_JSET_X",
b55dfa85001545 Johan Almbladh     2021-08-09   7894  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   7895  			BPF_ALU32_IMM(BPF_MOV, R0, 8),
b55dfa85001545 Johan Almbladh     2021-08-09   7896  			BPF_ALU32_IMM(BPF_MOV, R1, 7),
b55dfa85001545 Johan Almbladh     2021-08-09   7897  			BPF_JMP32_REG(BPF_JSET, R0, R1, 2),
b55dfa85001545 Johan Almbladh     2021-08-09   7898  			BPF_ALU32_IMM(BPF_MOV, R1, 8 | 2),
b55dfa85001545 Johan Almbladh     2021-08-09   7899  			BPF_JMP32_REG(BPF_JNE, R0, R1, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7900  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   7901  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   7902  		},
b55dfa85001545 Johan Almbladh     2021-08-09   7903  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   7904  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   7905  		{ { 0, 8 } }
b55dfa85001545 Johan Almbladh     2021-08-09   7906  	},
b55dfa85001545 Johan Almbladh     2021-08-09   7907  	/* BPF_JMP32 | BPF_JGT | BPF_K */
b55dfa85001545 Johan Almbladh     2021-08-09   7908  	{
b55dfa85001545 Johan Almbladh     2021-08-09   7909  		"JMP32_JGT_K: Small immediate",
b55dfa85001545 Johan Almbladh     2021-08-09   7910  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   7911  			BPF_ALU32_IMM(BPF_MOV, R0, 123),
b55dfa85001545 Johan Almbladh     2021-08-09   7912  			BPF_JMP32_IMM(BPF_JGT, R0, 123, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7913  			BPF_JMP32_IMM(BPF_JGT, R0, 122, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7914  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   7915  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   7916  		},
b55dfa85001545 Johan Almbladh     2021-08-09   7917  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   7918  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   7919  		{ { 0, 123 } }
b55dfa85001545 Johan Almbladh     2021-08-09   7920  	},
b55dfa85001545 Johan Almbladh     2021-08-09   7921  	{
b55dfa85001545 Johan Almbladh     2021-08-09   7922  		"JMP32_JGT_K: Large immediate",
b55dfa85001545 Johan Almbladh     2021-08-09   7923  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   7924  			BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
b55dfa85001545 Johan Almbladh     2021-08-09   7925  			BPF_JMP32_IMM(BPF_JGT, R0, 0xffffffff, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7926  			BPF_JMP32_IMM(BPF_JGT, R0, 0xfffffffd, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7927  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   7928  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   7929  		},
b55dfa85001545 Johan Almbladh     2021-08-09   7930  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   7931  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   7932  		{ { 0, 0xfffffffe } }
b55dfa85001545 Johan Almbladh     2021-08-09   7933  	},
b55dfa85001545 Johan Almbladh     2021-08-09   7934  	/* BPF_JMP32 | BPF_JGT | BPF_X */
b55dfa85001545 Johan Almbladh     2021-08-09   7935  	{
b55dfa85001545 Johan Almbladh     2021-08-09   7936  		"JMP32_JGT_X",
b55dfa85001545 Johan Almbladh     2021-08-09   7937  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   7938  			BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
b55dfa85001545 Johan Almbladh     2021-08-09   7939  			BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
b55dfa85001545 Johan Almbladh     2021-08-09   7940  			BPF_JMP32_REG(BPF_JGT, R0, R1, 2),
b55dfa85001545 Johan Almbladh     2021-08-09   7941  			BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffd),
b55dfa85001545 Johan Almbladh     2021-08-09   7942  			BPF_JMP32_REG(BPF_JGT, R0, R1, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7943  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   7944  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   7945  		},
b55dfa85001545 Johan Almbladh     2021-08-09   7946  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   7947  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   7948  		{ { 0, 0xfffffffe } }
b55dfa85001545 Johan Almbladh     2021-08-09   7949  	},
b55dfa85001545 Johan Almbladh     2021-08-09   7950  	/* BPF_JMP32 | BPF_JGE | BPF_K */
b55dfa85001545 Johan Almbladh     2021-08-09   7951  	{
b55dfa85001545 Johan Almbladh     2021-08-09   7952  		"JMP32_JGE_K: Small immediate",
b55dfa85001545 Johan Almbladh     2021-08-09   7953  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   7954  			BPF_ALU32_IMM(BPF_MOV, R0, 123),
b55dfa85001545 Johan Almbladh     2021-08-09   7955  			BPF_JMP32_IMM(BPF_JGE, R0, 124, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7956  			BPF_JMP32_IMM(BPF_JGE, R0, 123, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7957  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   7958  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   7959  		},
b55dfa85001545 Johan Almbladh     2021-08-09   7960  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   7961  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   7962  		{ { 0, 123 } }
b55dfa85001545 Johan Almbladh     2021-08-09   7963  	},
b55dfa85001545 Johan Almbladh     2021-08-09   7964  	{
b55dfa85001545 Johan Almbladh     2021-08-09   7965  		"JMP32_JGE_K: Large immediate",
b55dfa85001545 Johan Almbladh     2021-08-09   7966  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   7967  			BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
b55dfa85001545 Johan Almbladh     2021-08-09   7968  			BPF_JMP32_IMM(BPF_JGE, R0, 0xffffffff, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7969  			BPF_JMP32_IMM(BPF_JGE, R0, 0xfffffffe, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7970  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   7971  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   7972  		},
b55dfa85001545 Johan Almbladh     2021-08-09   7973  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   7974  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   7975  		{ { 0, 0xfffffffe } }
b55dfa85001545 Johan Almbladh     2021-08-09   7976  	},
b55dfa85001545 Johan Almbladh     2021-08-09   7977  	/* BPF_JMP32 | BPF_JGE | BPF_X */
b55dfa85001545 Johan Almbladh     2021-08-09   7978  	{
b55dfa85001545 Johan Almbladh     2021-08-09   7979  		"JMP32_JGE_X",
b55dfa85001545 Johan Almbladh     2021-08-09   7980  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   7981  			BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
b55dfa85001545 Johan Almbladh     2021-08-09   7982  			BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
b55dfa85001545 Johan Almbladh     2021-08-09   7983  			BPF_JMP32_REG(BPF_JGE, R0, R1, 2),
b55dfa85001545 Johan Almbladh     2021-08-09   7984  			BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffe),
b55dfa85001545 Johan Almbladh     2021-08-09   7985  			BPF_JMP32_REG(BPF_JGE, R0, R1, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7986  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   7987  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   7988  		},
b55dfa85001545 Johan Almbladh     2021-08-09   7989  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   7990  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   7991  		{ { 0, 0xfffffffe } }
b55dfa85001545 Johan Almbladh     2021-08-09   7992  	},
b55dfa85001545 Johan Almbladh     2021-08-09   7993  	/* BPF_JMP32 | BPF_JLT | BPF_K */
b55dfa85001545 Johan Almbladh     2021-08-09   7994  	{
b55dfa85001545 Johan Almbladh     2021-08-09   7995  		"JMP32_JLT_K: Small immediate",
b55dfa85001545 Johan Almbladh     2021-08-09   7996  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   7997  			BPF_ALU32_IMM(BPF_MOV, R0, 123),
b55dfa85001545 Johan Almbladh     2021-08-09   7998  			BPF_JMP32_IMM(BPF_JLT, R0, 123, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   7999  			BPF_JMP32_IMM(BPF_JLT, R0, 124, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8000  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   8001  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   8002  		},
b55dfa85001545 Johan Almbladh     2021-08-09   8003  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   8004  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   8005  		{ { 0, 123 } }
b55dfa85001545 Johan Almbladh     2021-08-09   8006  	},
b55dfa85001545 Johan Almbladh     2021-08-09   8007  	{
b55dfa85001545 Johan Almbladh     2021-08-09   8008  		"JMP32_JLT_K: Large immediate",
b55dfa85001545 Johan Almbladh     2021-08-09   8009  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   8010  			BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
b55dfa85001545 Johan Almbladh     2021-08-09   8011  			BPF_JMP32_IMM(BPF_JLT, R0, 0xfffffffd, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8012  			BPF_JMP32_IMM(BPF_JLT, R0, 0xffffffff, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8013  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   8014  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   8015  		},
b55dfa85001545 Johan Almbladh     2021-08-09   8016  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   8017  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   8018  		{ { 0, 0xfffffffe } }
b55dfa85001545 Johan Almbladh     2021-08-09   8019  	},
b55dfa85001545 Johan Almbladh     2021-08-09   8020  	/* BPF_JMP32 | BPF_JLT | BPF_X */
b55dfa85001545 Johan Almbladh     2021-08-09   8021  	{
b55dfa85001545 Johan Almbladh     2021-08-09   8022  		"JMP32_JLT_X",
b55dfa85001545 Johan Almbladh     2021-08-09   8023  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   8024  			BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
b55dfa85001545 Johan Almbladh     2021-08-09   8025  			BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffd),
b55dfa85001545 Johan Almbladh     2021-08-09   8026  			BPF_JMP32_REG(BPF_JLT, R0, R1, 2),
b55dfa85001545 Johan Almbladh     2021-08-09   8027  			BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
b55dfa85001545 Johan Almbladh     2021-08-09   8028  			BPF_JMP32_REG(BPF_JLT, R0, R1, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8029  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   8030  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   8031  		},
b55dfa85001545 Johan Almbladh     2021-08-09   8032  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   8033  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   8034  		{ { 0, 0xfffffffe } }
b55dfa85001545 Johan Almbladh     2021-08-09   8035  	},
b55dfa85001545 Johan Almbladh     2021-08-09   8036  	/* BPF_JMP32 | BPF_JLE | BPF_K */
b55dfa85001545 Johan Almbladh     2021-08-09   8037  	{
b55dfa85001545 Johan Almbladh     2021-08-09   8038  		"JMP32_JLE_K: Small immediate",
b55dfa85001545 Johan Almbladh     2021-08-09   8039  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   8040  			BPF_ALU32_IMM(BPF_MOV, R0, 123),
b55dfa85001545 Johan Almbladh     2021-08-09   8041  			BPF_JMP32_IMM(BPF_JLE, R0, 122, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8042  			BPF_JMP32_IMM(BPF_JLE, R0, 123, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8043  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   8044  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   8045  		},
b55dfa85001545 Johan Almbladh     2021-08-09   8046  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   8047  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   8048  		{ { 0, 123 } }
b55dfa85001545 Johan Almbladh     2021-08-09   8049  	},
b55dfa85001545 Johan Almbladh     2021-08-09   8050  	{
b55dfa85001545 Johan Almbladh     2021-08-09   8051  		"JMP32_JLE_K: Large immediate",
b55dfa85001545 Johan Almbladh     2021-08-09   8052  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   8053  			BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
b55dfa85001545 Johan Almbladh     2021-08-09   8054  			BPF_JMP32_IMM(BPF_JLE, R0, 0xfffffffd, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8055  			BPF_JMP32_IMM(BPF_JLE, R0, 0xfffffffe, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8056  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   8057  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   8058  		},
b55dfa85001545 Johan Almbladh     2021-08-09   8059  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   8060  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   8061  		{ { 0, 0xfffffffe } }
b55dfa85001545 Johan Almbladh     2021-08-09   8062  	},
b55dfa85001545 Johan Almbladh     2021-08-09   8063  	/* BPF_JMP32 | BPF_JLE | BPF_X */
b55dfa85001545 Johan Almbladh     2021-08-09   8064  	{
b55dfa85001545 Johan Almbladh     2021-08-09   8065  		"JMP32_JLE_X",
b55dfa85001545 Johan Almbladh     2021-08-09   8066  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   8067  			BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
b55dfa85001545 Johan Almbladh     2021-08-09   8068  			BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffd),
b55dfa85001545 Johan Almbladh     2021-08-09   8069  			BPF_JMP32_REG(BPF_JLE, R0, R1, 2),
b55dfa85001545 Johan Almbladh     2021-08-09   8070  			BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffe),
b55dfa85001545 Johan Almbladh     2021-08-09   8071  			BPF_JMP32_REG(BPF_JLE, R0, R1, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8072  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   8073  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   8074  		},
b55dfa85001545 Johan Almbladh     2021-08-09   8075  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   8076  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   8077  		{ { 0, 0xfffffffe } }
b55dfa85001545 Johan Almbladh     2021-08-09   8078  	},
b55dfa85001545 Johan Almbladh     2021-08-09   8079  	/* BPF_JMP32 | BPF_JSGT | BPF_K */
b55dfa85001545 Johan Almbladh     2021-08-09   8080  	{
b55dfa85001545 Johan Almbladh     2021-08-09   8081  		"JMP32_JSGT_K: Small immediate",
b55dfa85001545 Johan Almbladh     2021-08-09   8082  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   8083  			BPF_ALU32_IMM(BPF_MOV, R0, -123),
b55dfa85001545 Johan Almbladh     2021-08-09   8084  			BPF_JMP32_IMM(BPF_JSGT, R0, -123, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8085  			BPF_JMP32_IMM(BPF_JSGT, R0, -124, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8086  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   8087  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   8088  		},
b55dfa85001545 Johan Almbladh     2021-08-09   8089  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   8090  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   8091  		{ { 0, -123 } }
b55dfa85001545 Johan Almbladh     2021-08-09   8092  	},
b55dfa85001545 Johan Almbladh     2021-08-09   8093  	{
b55dfa85001545 Johan Almbladh     2021-08-09   8094  		"JMP32_JSGT_K: Large immediate",
b55dfa85001545 Johan Almbladh     2021-08-09   8095  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   8096  			BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
b55dfa85001545 Johan Almbladh     2021-08-09   8097  			BPF_JMP32_IMM(BPF_JSGT, R0, -12345678, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8098  			BPF_JMP32_IMM(BPF_JSGT, R0, -12345679, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8099  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   8100  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   8101  		},
b55dfa85001545 Johan Almbladh     2021-08-09   8102  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   8103  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   8104  		{ { 0, -12345678 } }
b55dfa85001545 Johan Almbladh     2021-08-09   8105  	},
b55dfa85001545 Johan Almbladh     2021-08-09   8106  	/* BPF_JMP32 | BPF_JSGT | BPF_X */
b55dfa85001545 Johan Almbladh     2021-08-09   8107  	{
b55dfa85001545 Johan Almbladh     2021-08-09   8108  		"JMP32_JSGT_X",
b55dfa85001545 Johan Almbladh     2021-08-09   8109  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   8110  			BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
b55dfa85001545 Johan Almbladh     2021-08-09   8111  			BPF_ALU32_IMM(BPF_MOV, R1, -12345678),
b55dfa85001545 Johan Almbladh     2021-08-09   8112  			BPF_JMP32_REG(BPF_JSGT, R0, R1, 2),
b55dfa85001545 Johan Almbladh     2021-08-09   8113  			BPF_ALU32_IMM(BPF_MOV, R1, -12345679),
b55dfa85001545 Johan Almbladh     2021-08-09   8114  			BPF_JMP32_REG(BPF_JSGT, R0, R1, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8115  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   8116  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   8117  		},
b55dfa85001545 Johan Almbladh     2021-08-09   8118  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   8119  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   8120  		{ { 0, -12345678 } }
b55dfa85001545 Johan Almbladh     2021-08-09   8121  	},
b55dfa85001545 Johan Almbladh     2021-08-09   8122  	/* BPF_JMP32 | BPF_JSGE | BPF_K */
b55dfa85001545 Johan Almbladh     2021-08-09   8123  	{
b55dfa85001545 Johan Almbladh     2021-08-09   8124  		"JMP32_JSGE_K: Small immediate",
b55dfa85001545 Johan Almbladh     2021-08-09   8125  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   8126  			BPF_ALU32_IMM(BPF_MOV, R0, -123),
b55dfa85001545 Johan Almbladh     2021-08-09   8127  			BPF_JMP32_IMM(BPF_JSGE, R0, -122, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8128  			BPF_JMP32_IMM(BPF_JSGE, R0, -123, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8129  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   8130  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   8131  		},
b55dfa85001545 Johan Almbladh     2021-08-09   8132  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   8133  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   8134  		{ { 0, -123 } }
b55dfa85001545 Johan Almbladh     2021-08-09   8135  	},
b55dfa85001545 Johan Almbladh     2021-08-09   8136  	{
b55dfa85001545 Johan Almbladh     2021-08-09   8137  		"JMP32_JSGE_K: Large immediate",
b55dfa85001545 Johan Almbladh     2021-08-09   8138  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   8139  			BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
b55dfa85001545 Johan Almbladh     2021-08-09   8140  			BPF_JMP32_IMM(BPF_JSGE, R0, -12345677, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8141  			BPF_JMP32_IMM(BPF_JSGE, R0, -12345678, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8142  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   8143  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   8144  		},
b55dfa85001545 Johan Almbladh     2021-08-09   8145  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   8146  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   8147  		{ { 0, -12345678 } }
b55dfa85001545 Johan Almbladh     2021-08-09   8148  	},
b55dfa85001545 Johan Almbladh     2021-08-09   8149  	/* BPF_JMP32 | BPF_JSGE | BPF_X */
b55dfa85001545 Johan Almbladh     2021-08-09   8150  	{
b55dfa85001545 Johan Almbladh     2021-08-09   8151  		"JMP32_JSGE_X",
b55dfa85001545 Johan Almbladh     2021-08-09   8152  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   8153  			BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
b55dfa85001545 Johan Almbladh     2021-08-09   8154  			BPF_ALU32_IMM(BPF_MOV, R1, -12345677),
b55dfa85001545 Johan Almbladh     2021-08-09   8155  			BPF_JMP32_REG(BPF_JSGE, R0, R1, 2),
b55dfa85001545 Johan Almbladh     2021-08-09   8156  			BPF_ALU32_IMM(BPF_MOV, R1, -12345678),
b55dfa85001545 Johan Almbladh     2021-08-09   8157  			BPF_JMP32_REG(BPF_JSGE, R0, R1, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8158  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   8159  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   8160  		},
b55dfa85001545 Johan Almbladh     2021-08-09   8161  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   8162  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   8163  		{ { 0, -12345678 } }
b55dfa85001545 Johan Almbladh     2021-08-09   8164  	},
b55dfa85001545 Johan Almbladh     2021-08-09   8165  	/* BPF_JMP32 | BPF_JSLT | BPF_K */
b55dfa85001545 Johan Almbladh     2021-08-09   8166  	{
b55dfa85001545 Johan Almbladh     2021-08-09   8167  		"JMP32_JSLT_K: Small immediate",
b55dfa85001545 Johan Almbladh     2021-08-09   8168  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   8169  			BPF_ALU32_IMM(BPF_MOV, R0, -123),
b55dfa85001545 Johan Almbladh     2021-08-09   8170  			BPF_JMP32_IMM(BPF_JSLT, R0, -123, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8171  			BPF_JMP32_IMM(BPF_JSLT, R0, -122, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8172  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   8173  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   8174  		},
b55dfa85001545 Johan Almbladh     2021-08-09   8175  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   8176  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   8177  		{ { 0, -123 } }
b55dfa85001545 Johan Almbladh     2021-08-09   8178  	},
b55dfa85001545 Johan Almbladh     2021-08-09   8179  	{
b55dfa85001545 Johan Almbladh     2021-08-09   8180  		"JMP32_JSLT_K: Large immediate",
b55dfa85001545 Johan Almbladh     2021-08-09   8181  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   8182  			BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
b55dfa85001545 Johan Almbladh     2021-08-09   8183  			BPF_JMP32_IMM(BPF_JSLT, R0, -12345678, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8184  			BPF_JMP32_IMM(BPF_JSLT, R0, -12345677, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8185  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   8186  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   8187  		},
b55dfa85001545 Johan Almbladh     2021-08-09   8188  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   8189  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   8190  		{ { 0, -12345678 } }
b55dfa85001545 Johan Almbladh     2021-08-09   8191  	},
b55dfa85001545 Johan Almbladh     2021-08-09   8192  	/* BPF_JMP32 | BPF_JSLT | BPF_X */
b55dfa85001545 Johan Almbladh     2021-08-09   8193  	{
b55dfa85001545 Johan Almbladh     2021-08-09   8194  		"JMP32_JSLT_X",
b55dfa85001545 Johan Almbladh     2021-08-09   8195  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   8196  			BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
b55dfa85001545 Johan Almbladh     2021-08-09   8197  			BPF_ALU32_IMM(BPF_MOV, R1, -12345678),
b55dfa85001545 Johan Almbladh     2021-08-09   8198  			BPF_JMP32_REG(BPF_JSLT, R0, R1, 2),
b55dfa85001545 Johan Almbladh     2021-08-09   8199  			BPF_ALU32_IMM(BPF_MOV, R1, -12345677),
b55dfa85001545 Johan Almbladh     2021-08-09   8200  			BPF_JMP32_REG(BPF_JSLT, R0, R1, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8201  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   8202  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   8203  		},
b55dfa85001545 Johan Almbladh     2021-08-09   8204  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   8205  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   8206  		{ { 0, -12345678 } }
b55dfa85001545 Johan Almbladh     2021-08-09   8207  	},
b55dfa85001545 Johan Almbladh     2021-08-09   8208  	/* BPF_JMP32 | BPF_JSLE | BPF_K */
b55dfa85001545 Johan Almbladh     2021-08-09   8209  	{
b55dfa85001545 Johan Almbladh     2021-08-09   8210  		"JMP32_JSLE_K: Small immediate",
b55dfa85001545 Johan Almbladh     2021-08-09   8211  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   8212  			BPF_ALU32_IMM(BPF_MOV, R0, -123),
b55dfa85001545 Johan Almbladh     2021-08-09   8213  			BPF_JMP32_IMM(BPF_JSLE, R0, -124, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8214  			BPF_JMP32_IMM(BPF_JSLE, R0, -123, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8215  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   8216  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   8217  		},
b55dfa85001545 Johan Almbladh     2021-08-09   8218  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   8219  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   8220  		{ { 0, -123 } }
b55dfa85001545 Johan Almbladh     2021-08-09   8221  	},
b55dfa85001545 Johan Almbladh     2021-08-09   8222  	{
b55dfa85001545 Johan Almbladh     2021-08-09   8223  		"JMP32_JSLE_K: Large immediate",
b55dfa85001545 Johan Almbladh     2021-08-09   8224  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   8225  			BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
b55dfa85001545 Johan Almbladh     2021-08-09   8226  			BPF_JMP32_IMM(BPF_JSLE, R0, -12345679, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8227  			BPF_JMP32_IMM(BPF_JSLE, R0, -12345678, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8228  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   8229  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   8230  		},
b55dfa85001545 Johan Almbladh     2021-08-09   8231  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   8232  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   8233  		{ { 0, -12345678 } }
b55dfa85001545 Johan Almbladh     2021-08-09   8234  	},
b55dfa85001545 Johan Almbladh     2021-08-09   8235  	/* BPF_JMP32 | BPF_JSLE | BPF_K */
b55dfa85001545 Johan Almbladh     2021-08-09   8236  	{
b55dfa85001545 Johan Almbladh     2021-08-09   8237  		"JMP32_JSLE_X",
b55dfa85001545 Johan Almbladh     2021-08-09   8238  		.u.insns_int = {
b55dfa85001545 Johan Almbladh     2021-08-09   8239  			BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
b55dfa85001545 Johan Almbladh     2021-08-09   8240  			BPF_ALU32_IMM(BPF_MOV, R1, -12345679),
b55dfa85001545 Johan Almbladh     2021-08-09   8241  			BPF_JMP32_REG(BPF_JSLE, R0, R1, 2),
b55dfa85001545 Johan Almbladh     2021-08-09   8242  			BPF_ALU32_IMM(BPF_MOV, R1, -12345678),
b55dfa85001545 Johan Almbladh     2021-08-09   8243  			BPF_JMP32_REG(BPF_JSLE, R0, R1, 1),
b55dfa85001545 Johan Almbladh     2021-08-09   8244  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
b55dfa85001545 Johan Almbladh     2021-08-09   8245  			BPF_EXIT_INSN(),
b55dfa85001545 Johan Almbladh     2021-08-09   8246  		},
b55dfa85001545 Johan Almbladh     2021-08-09   8247  		INTERNAL,
b55dfa85001545 Johan Almbladh     2021-08-09   8248  		{ },
b55dfa85001545 Johan Almbladh     2021-08-09   8249  		{ { 0, -12345678 } }
b55dfa85001545 Johan Almbladh     2021-08-09   8250  	},
cffc642d93f932 Michael Holzheu    2015-05-11   8251  	/* BPF_JMP | BPF_EXIT */
cffc642d93f932 Michael Holzheu    2015-05-11   8252  	{
cffc642d93f932 Michael Holzheu    2015-05-11   8253  		"JMP_EXIT",
cffc642d93f932 Michael Holzheu    2015-05-11   8254  		.u.insns_int = {
cffc642d93f932 Michael Holzheu    2015-05-11   8255  			BPF_ALU32_IMM(BPF_MOV, R0, 0x4711),
cffc642d93f932 Michael Holzheu    2015-05-11   8256  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8257  			BPF_ALU32_IMM(BPF_MOV, R0, 0x4712),
cffc642d93f932 Michael Holzheu    2015-05-11   8258  		},
cffc642d93f932 Michael Holzheu    2015-05-11   8259  		INTERNAL,
cffc642d93f932 Michael Holzheu    2015-05-11   8260  		{ },
cffc642d93f932 Michael Holzheu    2015-05-11   8261  		{ { 0, 0x4711 } },
cffc642d93f932 Michael Holzheu    2015-05-11   8262  	},
cffc642d93f932 Michael Holzheu    2015-05-11   8263  	/* BPF_JMP | BPF_JA */
cffc642d93f932 Michael Holzheu    2015-05-11   8264  	{
cffc642d93f932 Michael Holzheu    2015-05-11   8265  		"JMP_JA: Unconditional jump: if (true) return 1",
cffc642d93f932 Michael Holzheu    2015-05-11   8266  		.u.insns_int = {
cffc642d93f932 Michael Holzheu    2015-05-11   8267  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
cffc642d93f932 Michael Holzheu    2015-05-11   8268  			BPF_JMP_IMM(BPF_JA, 0, 0, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8269  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8270  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8271  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8272  		},
cffc642d93f932 Michael Holzheu    2015-05-11   8273  		INTERNAL,
cffc642d93f932 Michael Holzheu    2015-05-11   8274  		{ },
cffc642d93f932 Michael Holzheu    2015-05-11   8275  		{ { 0, 1 } },
cffc642d93f932 Michael Holzheu    2015-05-11   8276  	},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8277  	/* BPF_JMP | BPF_JSLT | BPF_K */
92b31a9af73b3a Daniel Borkmann    2017-08-10   8278  	{
92b31a9af73b3a Daniel Borkmann    2017-08-10   8279  		"JMP_JSLT_K: Signed jump: if (-2 < -1) return 1",
92b31a9af73b3a Daniel Borkmann    2017-08-10   8280  		.u.insns_int = {
92b31a9af73b3a Daniel Borkmann    2017-08-10   8281  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8282  			BPF_LD_IMM64(R1, 0xfffffffffffffffeLL),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8283  			BPF_JMP_IMM(BPF_JSLT, R1, -1, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8284  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8285  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8286  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8287  		},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8288  		INTERNAL,
92b31a9af73b3a Daniel Borkmann    2017-08-10   8289  		{ },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8290  		{ { 0, 1 } },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8291  	},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8292  	{
92b31a9af73b3a Daniel Borkmann    2017-08-10   8293  		"JMP_JSLT_K: Signed jump: if (-1 < -1) return 0",
92b31a9af73b3a Daniel Borkmann    2017-08-10   8294  		.u.insns_int = {
92b31a9af73b3a Daniel Borkmann    2017-08-10   8295  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8296  			BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8297  			BPF_JMP_IMM(BPF_JSLT, R1, -1, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8298  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8299  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8300  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8301  		},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8302  		INTERNAL,
92b31a9af73b3a Daniel Borkmann    2017-08-10   8303  		{ },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8304  		{ { 0, 1 } },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8305  	},
cffc642d93f932 Michael Holzheu    2015-05-11   8306  	/* BPF_JMP | BPF_JSGT | BPF_K */
cffc642d93f932 Michael Holzheu    2015-05-11   8307  	{
cffc642d93f932 Michael Holzheu    2015-05-11   8308  		"JMP_JSGT_K: Signed jump: if (-1 > -2) return 1",
cffc642d93f932 Michael Holzheu    2015-05-11   8309  		.u.insns_int = {
cffc642d93f932 Michael Holzheu    2015-05-11   8310  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
cffc642d93f932 Michael Holzheu    2015-05-11   8311  			BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
cffc642d93f932 Michael Holzheu    2015-05-11   8312  			BPF_JMP_IMM(BPF_JSGT, R1, -2, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8313  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8314  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8315  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8316  		},
cffc642d93f932 Michael Holzheu    2015-05-11   8317  		INTERNAL,
cffc642d93f932 Michael Holzheu    2015-05-11   8318  		{ },
cffc642d93f932 Michael Holzheu    2015-05-11   8319  		{ { 0, 1 } },
cffc642d93f932 Michael Holzheu    2015-05-11   8320  	},
cffc642d93f932 Michael Holzheu    2015-05-11   8321  	{
cffc642d93f932 Michael Holzheu    2015-05-11   8322  		"JMP_JSGT_K: Signed jump: if (-1 > -1) return 0",
cffc642d93f932 Michael Holzheu    2015-05-11   8323  		.u.insns_int = {
cffc642d93f932 Michael Holzheu    2015-05-11   8324  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8325  			BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
cffc642d93f932 Michael Holzheu    2015-05-11   8326  			BPF_JMP_IMM(BPF_JSGT, R1, -1, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8327  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8328  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
cffc642d93f932 Michael Holzheu    2015-05-11   8329  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8330  		},
cffc642d93f932 Michael Holzheu    2015-05-11   8331  		INTERNAL,
cffc642d93f932 Michael Holzheu    2015-05-11   8332  		{ },
cffc642d93f932 Michael Holzheu    2015-05-11   8333  		{ { 0, 1 } },
cffc642d93f932 Michael Holzheu    2015-05-11   8334  	},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8335  	/* BPF_JMP | BPF_JSLE | BPF_K */
92b31a9af73b3a Daniel Borkmann    2017-08-10   8336  	{
92b31a9af73b3a Daniel Borkmann    2017-08-10   8337  		"JMP_JSLE_K: Signed jump: if (-2 <= -1) return 1",
92b31a9af73b3a Daniel Borkmann    2017-08-10   8338  		.u.insns_int = {
92b31a9af73b3a Daniel Borkmann    2017-08-10   8339  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8340  			BPF_LD_IMM64(R1, 0xfffffffffffffffeLL),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8341  			BPF_JMP_IMM(BPF_JSLE, R1, -1, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8342  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8343  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8344  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8345  		},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8346  		INTERNAL,
92b31a9af73b3a Daniel Borkmann    2017-08-10   8347  		{ },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8348  		{ { 0, 1 } },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8349  	},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8350  	{
92b31a9af73b3a Daniel Borkmann    2017-08-10   8351  		"JMP_JSLE_K: Signed jump: if (-1 <= -1) return 1",
92b31a9af73b3a Daniel Borkmann    2017-08-10   8352  		.u.insns_int = {
92b31a9af73b3a Daniel Borkmann    2017-08-10   8353  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8354  			BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8355  			BPF_JMP_IMM(BPF_JSLE, R1, -1, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8356  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8357  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8358  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8359  		},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8360  		INTERNAL,
92b31a9af73b3a Daniel Borkmann    2017-08-10   8361  		{ },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8362  		{ { 0, 1 } },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8363  	},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8364  	{
92b31a9af73b3a Daniel Borkmann    2017-08-10   8365  		"JMP_JSLE_K: Signed jump: value walk 1",
92b31a9af73b3a Daniel Borkmann    2017-08-10   8366  		.u.insns_int = {
92b31a9af73b3a Daniel Borkmann    2017-08-10   8367  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8368  			BPF_LD_IMM64(R1, 3),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8369  			BPF_JMP_IMM(BPF_JSLE, R1, 0, 6),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8370  			BPF_ALU64_IMM(BPF_SUB, R1, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8371  			BPF_JMP_IMM(BPF_JSLE, R1, 0, 4),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8372  			BPF_ALU64_IMM(BPF_SUB, R1, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8373  			BPF_JMP_IMM(BPF_JSLE, R1, 0, 2),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8374  			BPF_ALU64_IMM(BPF_SUB, R1, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8375  			BPF_JMP_IMM(BPF_JSLE, R1, 0, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8376  			BPF_EXIT_INSN(),		/* bad exit */
92b31a9af73b3a Daniel Borkmann    2017-08-10   8377  			BPF_ALU32_IMM(BPF_MOV, R0, 1),	/* good exit */
92b31a9af73b3a Daniel Borkmann    2017-08-10   8378  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8379  		},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8380  		INTERNAL,
92b31a9af73b3a Daniel Borkmann    2017-08-10   8381  		{ },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8382  		{ { 0, 1 } },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8383  	},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8384  	{
92b31a9af73b3a Daniel Borkmann    2017-08-10   8385  		"JMP_JSLE_K: Signed jump: value walk 2",
92b31a9af73b3a Daniel Borkmann    2017-08-10   8386  		.u.insns_int = {
92b31a9af73b3a Daniel Borkmann    2017-08-10   8387  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8388  			BPF_LD_IMM64(R1, 3),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8389  			BPF_JMP_IMM(BPF_JSLE, R1, 0, 4),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8390  			BPF_ALU64_IMM(BPF_SUB, R1, 2),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8391  			BPF_JMP_IMM(BPF_JSLE, R1, 0, 2),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8392  			BPF_ALU64_IMM(BPF_SUB, R1, 2),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8393  			BPF_JMP_IMM(BPF_JSLE, R1, 0, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8394  			BPF_EXIT_INSN(),		/* bad exit */
92b31a9af73b3a Daniel Borkmann    2017-08-10   8395  			BPF_ALU32_IMM(BPF_MOV, R0, 1),	/* good exit */
92b31a9af73b3a Daniel Borkmann    2017-08-10   8396  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8397  		},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8398  		INTERNAL,
92b31a9af73b3a Daniel Borkmann    2017-08-10   8399  		{ },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8400  		{ { 0, 1 } },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8401  	},
cffc642d93f932 Michael Holzheu    2015-05-11   8402  	/* BPF_JMP | BPF_JSGE | BPF_K */
cffc642d93f932 Michael Holzheu    2015-05-11   8403  	{
cffc642d93f932 Michael Holzheu    2015-05-11   8404  		"JMP_JSGE_K: Signed jump: if (-1 >= -2) return 1",
cffc642d93f932 Michael Holzheu    2015-05-11   8405  		.u.insns_int = {
cffc642d93f932 Michael Holzheu    2015-05-11   8406  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
cffc642d93f932 Michael Holzheu    2015-05-11   8407  			BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
cffc642d93f932 Michael Holzheu    2015-05-11   8408  			BPF_JMP_IMM(BPF_JSGE, R1, -2, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8409  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8410  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8411  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8412  		},
cffc642d93f932 Michael Holzheu    2015-05-11   8413  		INTERNAL,
cffc642d93f932 Michael Holzheu    2015-05-11   8414  		{ },
cffc642d93f932 Michael Holzheu    2015-05-11   8415  		{ { 0, 1 } },
cffc642d93f932 Michael Holzheu    2015-05-11   8416  	},
cffc642d93f932 Michael Holzheu    2015-05-11   8417  	{
cffc642d93f932 Michael Holzheu    2015-05-11   8418  		"JMP_JSGE_K: Signed jump: if (-1 >= -1) return 1",
cffc642d93f932 Michael Holzheu    2015-05-11   8419  		.u.insns_int = {
cffc642d93f932 Michael Holzheu    2015-05-11   8420  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
cffc642d93f932 Michael Holzheu    2015-05-11   8421  			BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
cffc642d93f932 Michael Holzheu    2015-05-11   8422  			BPF_JMP_IMM(BPF_JSGE, R1, -1, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8423  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8424  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8425  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8426  		},
cffc642d93f932 Michael Holzheu    2015-05-11   8427  		INTERNAL,
cffc642d93f932 Michael Holzheu    2015-05-11   8428  		{ },
cffc642d93f932 Michael Holzheu    2015-05-11   8429  		{ { 0, 1 } },
cffc642d93f932 Michael Holzheu    2015-05-11   8430  	},
791caeb084c57e David Daney        2017-05-24   8431  	{
791caeb084c57e David Daney        2017-05-24   8432  		"JMP_JSGE_K: Signed jump: value walk 1",
791caeb084c57e David Daney        2017-05-24   8433  		.u.insns_int = {
791caeb084c57e David Daney        2017-05-24   8434  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
791caeb084c57e David Daney        2017-05-24   8435  			BPF_LD_IMM64(R1, -3),
791caeb084c57e David Daney        2017-05-24   8436  			BPF_JMP_IMM(BPF_JSGE, R1, 0, 6),
791caeb084c57e David Daney        2017-05-24   8437  			BPF_ALU64_IMM(BPF_ADD, R1, 1),
791caeb084c57e David Daney        2017-05-24   8438  			BPF_JMP_IMM(BPF_JSGE, R1, 0, 4),
791caeb084c57e David Daney        2017-05-24   8439  			BPF_ALU64_IMM(BPF_ADD, R1, 1),
791caeb084c57e David Daney        2017-05-24   8440  			BPF_JMP_IMM(BPF_JSGE, R1, 0, 2),
791caeb084c57e David Daney        2017-05-24   8441  			BPF_ALU64_IMM(BPF_ADD, R1, 1),
791caeb084c57e David Daney        2017-05-24   8442  			BPF_JMP_IMM(BPF_JSGE, R1, 0, 1),
791caeb084c57e David Daney        2017-05-24   8443  			BPF_EXIT_INSN(),		/* bad exit */
791caeb084c57e David Daney        2017-05-24   8444  			BPF_ALU32_IMM(BPF_MOV, R0, 1),	/* good exit */
791caeb084c57e David Daney        2017-05-24   8445  			BPF_EXIT_INSN(),
791caeb084c57e David Daney        2017-05-24   8446  		},
791caeb084c57e David Daney        2017-05-24   8447  		INTERNAL,
791caeb084c57e David Daney        2017-05-24   8448  		{ },
791caeb084c57e David Daney        2017-05-24   8449  		{ { 0, 1 } },
791caeb084c57e David Daney        2017-05-24   8450  	},
791caeb084c57e David Daney        2017-05-24   8451  	{
791caeb084c57e David Daney        2017-05-24   8452  		"JMP_JSGE_K: Signed jump: value walk 2",
791caeb084c57e David Daney        2017-05-24   8453  		.u.insns_int = {
791caeb084c57e David Daney        2017-05-24   8454  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
791caeb084c57e David Daney        2017-05-24   8455  			BPF_LD_IMM64(R1, -3),
791caeb084c57e David Daney        2017-05-24   8456  			BPF_JMP_IMM(BPF_JSGE, R1, 0, 4),
791caeb084c57e David Daney        2017-05-24   8457  			BPF_ALU64_IMM(BPF_ADD, R1, 2),
791caeb084c57e David Daney        2017-05-24   8458  			BPF_JMP_IMM(BPF_JSGE, R1, 0, 2),
791caeb084c57e David Daney        2017-05-24   8459  			BPF_ALU64_IMM(BPF_ADD, R1, 2),
791caeb084c57e David Daney        2017-05-24   8460  			BPF_JMP_IMM(BPF_JSGE, R1, 0, 1),
791caeb084c57e David Daney        2017-05-24   8461  			BPF_EXIT_INSN(),		/* bad exit */
791caeb084c57e David Daney        2017-05-24   8462  			BPF_ALU32_IMM(BPF_MOV, R0, 1),	/* good exit */
791caeb084c57e David Daney        2017-05-24   8463  			BPF_EXIT_INSN(),
791caeb084c57e David Daney        2017-05-24   8464  		},
791caeb084c57e David Daney        2017-05-24   8465  		INTERNAL,
791caeb084c57e David Daney        2017-05-24   8466  		{ },
791caeb084c57e David Daney        2017-05-24   8467  		{ { 0, 1 } },
791caeb084c57e David Daney        2017-05-24   8468  	},
cffc642d93f932 Michael Holzheu    2015-05-11   8469  	/* BPF_JMP | BPF_JGT | BPF_K */
cffc642d93f932 Michael Holzheu    2015-05-11   8470  	{
cffc642d93f932 Michael Holzheu    2015-05-11   8471  		"JMP_JGT_K: if (3 > 2) return 1",
cffc642d93f932 Michael Holzheu    2015-05-11   8472  		.u.insns_int = {
cffc642d93f932 Michael Holzheu    2015-05-11   8473  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
cffc642d93f932 Michael Holzheu    2015-05-11   8474  			BPF_LD_IMM64(R1, 3),
cffc642d93f932 Michael Holzheu    2015-05-11   8475  			BPF_JMP_IMM(BPF_JGT, R1, 2, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8476  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8477  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8478  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8479  		},
cffc642d93f932 Michael Holzheu    2015-05-11   8480  		INTERNAL,
cffc642d93f932 Michael Holzheu    2015-05-11   8481  		{ },
cffc642d93f932 Michael Holzheu    2015-05-11   8482  		{ { 0, 1 } },
cffc642d93f932 Michael Holzheu    2015-05-11   8483  	},
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8484  	{
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8485  		"JMP_JGT_K: Unsigned jump: if (-1 > 1) return 1",
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8486  		.u.insns_int = {
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8487  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8488  			BPF_LD_IMM64(R1, -1),
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8489  			BPF_JMP_IMM(BPF_JGT, R1, 1, 1),
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8490  			BPF_EXIT_INSN(),
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8491  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8492  			BPF_EXIT_INSN(),
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8493  		},
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8494  		INTERNAL,
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8495  		{ },
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8496  		{ { 0, 1 } },
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8497  	},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8498  	/* BPF_JMP | BPF_JLT | BPF_K */
92b31a9af73b3a Daniel Borkmann    2017-08-10   8499  	{
92b31a9af73b3a Daniel Borkmann    2017-08-10   8500  		"JMP_JLT_K: if (2 < 3) return 1",
92b31a9af73b3a Daniel Borkmann    2017-08-10   8501  		.u.insns_int = {
92b31a9af73b3a Daniel Borkmann    2017-08-10   8502  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8503  			BPF_LD_IMM64(R1, 2),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8504  			BPF_JMP_IMM(BPF_JLT, R1, 3, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8505  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8506  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8507  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8508  		},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8509  		INTERNAL,
92b31a9af73b3a Daniel Borkmann    2017-08-10   8510  		{ },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8511  		{ { 0, 1 } },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8512  	},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8513  	{
92b31a9af73b3a Daniel Borkmann    2017-08-10   8514  		"JMP_JGT_K: Unsigned jump: if (1 < -1) return 1",
92b31a9af73b3a Daniel Borkmann    2017-08-10   8515  		.u.insns_int = {
92b31a9af73b3a Daniel Borkmann    2017-08-10   8516  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8517  			BPF_LD_IMM64(R1, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8518  			BPF_JMP_IMM(BPF_JLT, R1, -1, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8519  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8520  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8521  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8522  		},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8523  		INTERNAL,
92b31a9af73b3a Daniel Borkmann    2017-08-10   8524  		{ },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8525  		{ { 0, 1 } },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8526  	},
cffc642d93f932 Michael Holzheu    2015-05-11   8527  	/* BPF_JMP | BPF_JGE | BPF_K */
cffc642d93f932 Michael Holzheu    2015-05-11   8528  	{
cffc642d93f932 Michael Holzheu    2015-05-11   8529  		"JMP_JGE_K: if (3 >= 2) return 1",
cffc642d93f932 Michael Holzheu    2015-05-11   8530  		.u.insns_int = {
cffc642d93f932 Michael Holzheu    2015-05-11   8531  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
cffc642d93f932 Michael Holzheu    2015-05-11   8532  			BPF_LD_IMM64(R1, 3),
cffc642d93f932 Michael Holzheu    2015-05-11   8533  			BPF_JMP_IMM(BPF_JGE, R1, 2, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8534  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8535  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8536  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8537  		},
cffc642d93f932 Michael Holzheu    2015-05-11   8538  		INTERNAL,
cffc642d93f932 Michael Holzheu    2015-05-11   8539  		{ },
cffc642d93f932 Michael Holzheu    2015-05-11   8540  		{ { 0, 1 } },
cffc642d93f932 Michael Holzheu    2015-05-11   8541  	},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8542  	/* BPF_JMP | BPF_JLE | BPF_K */
92b31a9af73b3a Daniel Borkmann    2017-08-10   8543  	{
92b31a9af73b3a Daniel Borkmann    2017-08-10   8544  		"JMP_JLE_K: if (2 <= 3) return 1",
92b31a9af73b3a Daniel Borkmann    2017-08-10   8545  		.u.insns_int = {
92b31a9af73b3a Daniel Borkmann    2017-08-10   8546  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8547  			BPF_LD_IMM64(R1, 2),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8548  			BPF_JMP_IMM(BPF_JLE, R1, 3, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8549  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8550  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8551  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8552  		},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8553  		INTERNAL,
92b31a9af73b3a Daniel Borkmann    2017-08-10   8554  		{ },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8555  		{ { 0, 1 } },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8556  	},
fe593844957a7c Michael Holzheu    2015-05-22   8557  	/* BPF_JMP | BPF_JGT | BPF_K jump backwards */
fe593844957a7c Michael Holzheu    2015-05-22   8558  	{
fe593844957a7c Michael Holzheu    2015-05-22   8559  		"JMP_JGT_K: if (3 > 2) return 1 (jump backwards)",
fe593844957a7c Michael Holzheu    2015-05-22   8560  		.u.insns_int = {
fe593844957a7c Michael Holzheu    2015-05-22   8561  			BPF_JMP_IMM(BPF_JA, 0, 0, 2), /* goto start */
fe593844957a7c Michael Holzheu    2015-05-22   8562  			BPF_ALU32_IMM(BPF_MOV, R0, 1), /* out: */
fe593844957a7c Michael Holzheu    2015-05-22   8563  			BPF_EXIT_INSN(),
fe593844957a7c Michael Holzheu    2015-05-22   8564  			BPF_ALU32_IMM(BPF_MOV, R0, 0), /* start: */
fe593844957a7c Michael Holzheu    2015-05-22   8565  			BPF_LD_IMM64(R1, 3), /* note: this takes 2 insns */
fe593844957a7c Michael Holzheu    2015-05-22   8566  			BPF_JMP_IMM(BPF_JGT, R1, 2, -6), /* goto out */
fe593844957a7c Michael Holzheu    2015-05-22   8567  			BPF_EXIT_INSN(),
fe593844957a7c Michael Holzheu    2015-05-22   8568  		},
fe593844957a7c Michael Holzheu    2015-05-22   8569  		INTERNAL,
fe593844957a7c Michael Holzheu    2015-05-22   8570  		{ },
fe593844957a7c Michael Holzheu    2015-05-22   8571  		{ { 0, 1 } },
fe593844957a7c Michael Holzheu    2015-05-22   8572  	},
cffc642d93f932 Michael Holzheu    2015-05-11   8573  	{
cffc642d93f932 Michael Holzheu    2015-05-11   8574  		"JMP_JGE_K: if (3 >= 3) return 1",
cffc642d93f932 Michael Holzheu    2015-05-11   8575  		.u.insns_int = {
cffc642d93f932 Michael Holzheu    2015-05-11   8576  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
cffc642d93f932 Michael Holzheu    2015-05-11   8577  			BPF_LD_IMM64(R1, 3),
cffc642d93f932 Michael Holzheu    2015-05-11   8578  			BPF_JMP_IMM(BPF_JGE, R1, 3, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8579  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8580  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8581  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8582  		},
cffc642d93f932 Michael Holzheu    2015-05-11   8583  		INTERNAL,
cffc642d93f932 Michael Holzheu    2015-05-11   8584  		{ },
cffc642d93f932 Michael Holzheu    2015-05-11   8585  		{ { 0, 1 } },
cffc642d93f932 Michael Holzheu    2015-05-11   8586  	},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8587  	/* BPF_JMP | BPF_JLT | BPF_K jump backwards */
92b31a9af73b3a Daniel Borkmann    2017-08-10   8588  	{
92b31a9af73b3a Daniel Borkmann    2017-08-10   8589  		"JMP_JGT_K: if (2 < 3) return 1 (jump backwards)",
92b31a9af73b3a Daniel Borkmann    2017-08-10   8590  		.u.insns_int = {
92b31a9af73b3a Daniel Borkmann    2017-08-10   8591  			BPF_JMP_IMM(BPF_JA, 0, 0, 2), /* goto start */
92b31a9af73b3a Daniel Borkmann    2017-08-10   8592  			BPF_ALU32_IMM(BPF_MOV, R0, 1), /* out: */
92b31a9af73b3a Daniel Borkmann    2017-08-10   8593  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8594  			BPF_ALU32_IMM(BPF_MOV, R0, 0), /* start: */
92b31a9af73b3a Daniel Borkmann    2017-08-10   8595  			BPF_LD_IMM64(R1, 2), /* note: this takes 2 insns */
92b31a9af73b3a Daniel Borkmann    2017-08-10   8596  			BPF_JMP_IMM(BPF_JLT, R1, 3, -6), /* goto out */
92b31a9af73b3a Daniel Borkmann    2017-08-10   8597  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8598  		},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8599  		INTERNAL,
92b31a9af73b3a Daniel Borkmann    2017-08-10   8600  		{ },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8601  		{ { 0, 1 } },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8602  	},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8603  	{
92b31a9af73b3a Daniel Borkmann    2017-08-10   8604  		"JMP_JLE_K: if (3 <= 3) return 1",
92b31a9af73b3a Daniel Borkmann    2017-08-10   8605  		.u.insns_int = {
92b31a9af73b3a Daniel Borkmann    2017-08-10   8606  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8607  			BPF_LD_IMM64(R1, 3),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8608  			BPF_JMP_IMM(BPF_JLE, R1, 3, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8609  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8610  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8611  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8612  		},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8613  		INTERNAL,
92b31a9af73b3a Daniel Borkmann    2017-08-10   8614  		{ },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8615  		{ { 0, 1 } },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8616  	},
cffc642d93f932 Michael Holzheu    2015-05-11   8617  	/* BPF_JMP | BPF_JNE | BPF_K */
cffc642d93f932 Michael Holzheu    2015-05-11   8618  	{
cffc642d93f932 Michael Holzheu    2015-05-11   8619  		"JMP_JNE_K: if (3 != 2) return 1",
cffc642d93f932 Michael Holzheu    2015-05-11   8620  		.u.insns_int = {
cffc642d93f932 Michael Holzheu    2015-05-11   8621  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
cffc642d93f932 Michael Holzheu    2015-05-11   8622  			BPF_LD_IMM64(R1, 3),
cffc642d93f932 Michael Holzheu    2015-05-11   8623  			BPF_JMP_IMM(BPF_JNE, R1, 2, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8624  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8625  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8626  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8627  		},
cffc642d93f932 Michael Holzheu    2015-05-11   8628  		INTERNAL,
cffc642d93f932 Michael Holzheu    2015-05-11   8629  		{ },
cffc642d93f932 Michael Holzheu    2015-05-11   8630  		{ { 0, 1 } },
cffc642d93f932 Michael Holzheu    2015-05-11   8631  	},
cffc642d93f932 Michael Holzheu    2015-05-11   8632  	/* BPF_JMP | BPF_JEQ | BPF_K */
cffc642d93f932 Michael Holzheu    2015-05-11   8633  	{
cffc642d93f932 Michael Holzheu    2015-05-11   8634  		"JMP_JEQ_K: if (3 == 3) return 1",
cffc642d93f932 Michael Holzheu    2015-05-11   8635  		.u.insns_int = {
cffc642d93f932 Michael Holzheu    2015-05-11   8636  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
cffc642d93f932 Michael Holzheu    2015-05-11   8637  			BPF_LD_IMM64(R1, 3),
cffc642d93f932 Michael Holzheu    2015-05-11   8638  			BPF_JMP_IMM(BPF_JEQ, R1, 3, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8639  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8640  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8641  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8642  		},
cffc642d93f932 Michael Holzheu    2015-05-11   8643  		INTERNAL,
cffc642d93f932 Michael Holzheu    2015-05-11   8644  		{ },
cffc642d93f932 Michael Holzheu    2015-05-11   8645  		{ { 0, 1 } },
cffc642d93f932 Michael Holzheu    2015-05-11   8646  	},
cffc642d93f932 Michael Holzheu    2015-05-11   8647  	/* BPF_JMP | BPF_JSET | BPF_K */
cffc642d93f932 Michael Holzheu    2015-05-11   8648  	{
cffc642d93f932 Michael Holzheu    2015-05-11   8649  		"JMP_JSET_K: if (0x3 & 0x2) return 1",
cffc642d93f932 Michael Holzheu    2015-05-11   8650  		.u.insns_int = {
cffc642d93f932 Michael Holzheu    2015-05-11   8651  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
cffc642d93f932 Michael Holzheu    2015-05-11   8652  			BPF_LD_IMM64(R1, 3),
9f134c34fbce58 Naveen N. Rao      2016-04-05   8653  			BPF_JMP_IMM(BPF_JSET, R1, 2, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8654  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8655  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8656  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8657  		},
cffc642d93f932 Michael Holzheu    2015-05-11   8658  		INTERNAL,
cffc642d93f932 Michael Holzheu    2015-05-11   8659  		{ },
cffc642d93f932 Michael Holzheu    2015-05-11   8660  		{ { 0, 1 } },
cffc642d93f932 Michael Holzheu    2015-05-11   8661  	},
cffc642d93f932 Michael Holzheu    2015-05-11   8662  	{
cffc642d93f932 Michael Holzheu    2015-05-11   8663  		"JMP_JSET_K: if (0x3 & 0xffffffff) return 1",
cffc642d93f932 Michael Holzheu    2015-05-11   8664  		.u.insns_int = {
cffc642d93f932 Michael Holzheu    2015-05-11   8665  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
cffc642d93f932 Michael Holzheu    2015-05-11   8666  			BPF_LD_IMM64(R1, 3),
9f134c34fbce58 Naveen N. Rao      2016-04-05   8667  			BPF_JMP_IMM(BPF_JSET, R1, 0xffffffff, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8668  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8669  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8670  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8671  		},
cffc642d93f932 Michael Holzheu    2015-05-11   8672  		INTERNAL,
cffc642d93f932 Michael Holzheu    2015-05-11   8673  		{ },
cffc642d93f932 Michael Holzheu    2015-05-11   8674  		{ { 0, 1 } },
cffc642d93f932 Michael Holzheu    2015-05-11   8675  	},
cffc642d93f932 Michael Holzheu    2015-05-11   8676  	/* BPF_JMP | BPF_JSGT | BPF_X */
cffc642d93f932 Michael Holzheu    2015-05-11   8677  	{
cffc642d93f932 Michael Holzheu    2015-05-11   8678  		"JMP_JSGT_X: Signed jump: if (-1 > -2) return 1",
cffc642d93f932 Michael Holzheu    2015-05-11   8679  		.u.insns_int = {
cffc642d93f932 Michael Holzheu    2015-05-11   8680  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
cffc642d93f932 Michael Holzheu    2015-05-11   8681  			BPF_LD_IMM64(R1, -1),
cffc642d93f932 Michael Holzheu    2015-05-11   8682  			BPF_LD_IMM64(R2, -2),
cffc642d93f932 Michael Holzheu    2015-05-11   8683  			BPF_JMP_REG(BPF_JSGT, R1, R2, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8684  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8685  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8686  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8687  		},
cffc642d93f932 Michael Holzheu    2015-05-11   8688  		INTERNAL,
cffc642d93f932 Michael Holzheu    2015-05-11   8689  		{ },
cffc642d93f932 Michael Holzheu    2015-05-11   8690  		{ { 0, 1 } },
cffc642d93f932 Michael Holzheu    2015-05-11   8691  	},
cffc642d93f932 Michael Holzheu    2015-05-11   8692  	{
cffc642d93f932 Michael Holzheu    2015-05-11   8693  		"JMP_JSGT_X: Signed jump: if (-1 > -1) return 0",
cffc642d93f932 Michael Holzheu    2015-05-11   8694  		.u.insns_int = {
cffc642d93f932 Michael Holzheu    2015-05-11   8695  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8696  			BPF_LD_IMM64(R1, -1),
cffc642d93f932 Michael Holzheu    2015-05-11   8697  			BPF_LD_IMM64(R2, -1),
cffc642d93f932 Michael Holzheu    2015-05-11   8698  			BPF_JMP_REG(BPF_JSGT, R1, R2, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8699  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8700  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
cffc642d93f932 Michael Holzheu    2015-05-11   8701  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8702  		},
cffc642d93f932 Michael Holzheu    2015-05-11   8703  		INTERNAL,
cffc642d93f932 Michael Holzheu    2015-05-11   8704  		{ },
cffc642d93f932 Michael Holzheu    2015-05-11   8705  		{ { 0, 1 } },
cffc642d93f932 Michael Holzheu    2015-05-11   8706  	},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8707  	/* BPF_JMP | BPF_JSLT | BPF_X */
92b31a9af73b3a Daniel Borkmann    2017-08-10   8708  	{
92b31a9af73b3a Daniel Borkmann    2017-08-10   8709  		"JMP_JSLT_X: Signed jump: if (-2 < -1) return 1",
92b31a9af73b3a Daniel Borkmann    2017-08-10   8710  		.u.insns_int = {
92b31a9af73b3a Daniel Borkmann    2017-08-10   8711  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8712  			BPF_LD_IMM64(R1, -1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8713  			BPF_LD_IMM64(R2, -2),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8714  			BPF_JMP_REG(BPF_JSLT, R2, R1, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8715  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8716  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8717  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8718  		},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8719  		INTERNAL,
92b31a9af73b3a Daniel Borkmann    2017-08-10   8720  		{ },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8721  		{ { 0, 1 } },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8722  	},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8723  	{
92b31a9af73b3a Daniel Borkmann    2017-08-10   8724  		"JMP_JSLT_X: Signed jump: if (-1 < -1) return 0",
92b31a9af73b3a Daniel Borkmann    2017-08-10   8725  		.u.insns_int = {
92b31a9af73b3a Daniel Borkmann    2017-08-10   8726  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8727  			BPF_LD_IMM64(R1, -1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8728  			BPF_LD_IMM64(R2, -1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8729  			BPF_JMP_REG(BPF_JSLT, R1, R2, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8730  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8731  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8732  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8733  		},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8734  		INTERNAL,
92b31a9af73b3a Daniel Borkmann    2017-08-10   8735  		{ },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8736  		{ { 0, 1 } },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8737  	},
cffc642d93f932 Michael Holzheu    2015-05-11   8738  	/* BPF_JMP | BPF_JSGE | BPF_X */
cffc642d93f932 Michael Holzheu    2015-05-11   8739  	{
cffc642d93f932 Michael Holzheu    2015-05-11   8740  		"JMP_JSGE_X: Signed jump: if (-1 >= -2) return 1",
cffc642d93f932 Michael Holzheu    2015-05-11   8741  		.u.insns_int = {
cffc642d93f932 Michael Holzheu    2015-05-11   8742  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
cffc642d93f932 Michael Holzheu    2015-05-11   8743  			BPF_LD_IMM64(R1, -1),
cffc642d93f932 Michael Holzheu    2015-05-11   8744  			BPF_LD_IMM64(R2, -2),
cffc642d93f932 Michael Holzheu    2015-05-11   8745  			BPF_JMP_REG(BPF_JSGE, R1, R2, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8746  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8747  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8748  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8749  		},
cffc642d93f932 Michael Holzheu    2015-05-11   8750  		INTERNAL,
cffc642d93f932 Michael Holzheu    2015-05-11   8751  		{ },
cffc642d93f932 Michael Holzheu    2015-05-11   8752  		{ { 0, 1 } },
cffc642d93f932 Michael Holzheu    2015-05-11   8753  	},
cffc642d93f932 Michael Holzheu    2015-05-11   8754  	{
cffc642d93f932 Michael Holzheu    2015-05-11   8755  		"JMP_JSGE_X: Signed jump: if (-1 >= -1) return 1",
cffc642d93f932 Michael Holzheu    2015-05-11   8756  		.u.insns_int = {
cffc642d93f932 Michael Holzheu    2015-05-11   8757  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
cffc642d93f932 Michael Holzheu    2015-05-11   8758  			BPF_LD_IMM64(R1, -1),
cffc642d93f932 Michael Holzheu    2015-05-11   8759  			BPF_LD_IMM64(R2, -1),
cffc642d93f932 Michael Holzheu    2015-05-11   8760  			BPF_JMP_REG(BPF_JSGE, R1, R2, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8761  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8762  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8763  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8764  		},
cffc642d93f932 Michael Holzheu    2015-05-11   8765  		INTERNAL,
cffc642d93f932 Michael Holzheu    2015-05-11   8766  		{ },
cffc642d93f932 Michael Holzheu    2015-05-11   8767  		{ { 0, 1 } },
cffc642d93f932 Michael Holzheu    2015-05-11   8768  	},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8769  	/* BPF_JMP | BPF_JSLE | BPF_X */
92b31a9af73b3a Daniel Borkmann    2017-08-10   8770  	{
92b31a9af73b3a Daniel Borkmann    2017-08-10   8771  		"JMP_JSLE_X: Signed jump: if (-2 <= -1) return 1",
92b31a9af73b3a Daniel Borkmann    2017-08-10   8772  		.u.insns_int = {
92b31a9af73b3a Daniel Borkmann    2017-08-10   8773  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8774  			BPF_LD_IMM64(R1, -1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8775  			BPF_LD_IMM64(R2, -2),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8776  			BPF_JMP_REG(BPF_JSLE, R2, R1, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8777  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8778  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8779  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8780  		},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8781  		INTERNAL,
92b31a9af73b3a Daniel Borkmann    2017-08-10   8782  		{ },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8783  		{ { 0, 1 } },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8784  	},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8785  	{
92b31a9af73b3a Daniel Borkmann    2017-08-10   8786  		"JMP_JSLE_X: Signed jump: if (-1 <= -1) return 1",
92b31a9af73b3a Daniel Borkmann    2017-08-10   8787  		.u.insns_int = {
92b31a9af73b3a Daniel Borkmann    2017-08-10   8788  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8789  			BPF_LD_IMM64(R1, -1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8790  			BPF_LD_IMM64(R2, -1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8791  			BPF_JMP_REG(BPF_JSLE, R1, R2, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8792  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8793  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8794  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8795  		},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8796  		INTERNAL,
92b31a9af73b3a Daniel Borkmann    2017-08-10   8797  		{ },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8798  		{ { 0, 1 } },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8799  	},
cffc642d93f932 Michael Holzheu    2015-05-11   8800  	/* BPF_JMP | BPF_JGT | BPF_X */
cffc642d93f932 Michael Holzheu    2015-05-11   8801  	{
cffc642d93f932 Michael Holzheu    2015-05-11   8802  		"JMP_JGT_X: if (3 > 2) return 1",
cffc642d93f932 Michael Holzheu    2015-05-11   8803  		.u.insns_int = {
cffc642d93f932 Michael Holzheu    2015-05-11   8804  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
cffc642d93f932 Michael Holzheu    2015-05-11   8805  			BPF_LD_IMM64(R1, 3),
cffc642d93f932 Michael Holzheu    2015-05-11   8806  			BPF_LD_IMM64(R2, 2),
cffc642d93f932 Michael Holzheu    2015-05-11   8807  			BPF_JMP_REG(BPF_JGT, R1, R2, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8808  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8809  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8810  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8811  		},
cffc642d93f932 Michael Holzheu    2015-05-11   8812  		INTERNAL,
cffc642d93f932 Michael Holzheu    2015-05-11   8813  		{ },
cffc642d93f932 Michael Holzheu    2015-05-11   8814  		{ { 0, 1 } },
cffc642d93f932 Michael Holzheu    2015-05-11   8815  	},
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8816  	{
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8817  		"JMP_JGT_X: Unsigned jump: if (-1 > 1) return 1",
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8818  		.u.insns_int = {
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8819  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8820  			BPF_LD_IMM64(R1, -1),
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8821  			BPF_LD_IMM64(R2, 1),
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8822  			BPF_JMP_REG(BPF_JGT, R1, R2, 1),
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8823  			BPF_EXIT_INSN(),
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8824  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8825  			BPF_EXIT_INSN(),
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8826  		},
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8827  		INTERNAL,
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8828  		{ },
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8829  		{ { 0, 1 } },
c7395d6bd7cc1c Naveen N. Rao      2016-04-05   8830  	},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8831  	/* BPF_JMP | BPF_JLT | BPF_X */
92b31a9af73b3a Daniel Borkmann    2017-08-10   8832  	{
92b31a9af73b3a Daniel Borkmann    2017-08-10   8833  		"JMP_JLT_X: if (2 < 3) return 1",
92b31a9af73b3a Daniel Borkmann    2017-08-10   8834  		.u.insns_int = {
92b31a9af73b3a Daniel Borkmann    2017-08-10   8835  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8836  			BPF_LD_IMM64(R1, 3),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8837  			BPF_LD_IMM64(R2, 2),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8838  			BPF_JMP_REG(BPF_JLT, R2, R1, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8839  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8840  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8841  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8842  		},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8843  		INTERNAL,
92b31a9af73b3a Daniel Borkmann    2017-08-10   8844  		{ },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8845  		{ { 0, 1 } },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8846  	},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8847  	{
92b31a9af73b3a Daniel Borkmann    2017-08-10   8848  		"JMP_JLT_X: Unsigned jump: if (1 < -1) return 1",
92b31a9af73b3a Daniel Borkmann    2017-08-10   8849  		.u.insns_int = {
92b31a9af73b3a Daniel Borkmann    2017-08-10   8850  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8851  			BPF_LD_IMM64(R1, -1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8852  			BPF_LD_IMM64(R2, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8853  			BPF_JMP_REG(BPF_JLT, R2, R1, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8854  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8855  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8856  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8857  		},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8858  		INTERNAL,
92b31a9af73b3a Daniel Borkmann    2017-08-10   8859  		{ },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8860  		{ { 0, 1 } },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8861  	},
cffc642d93f932 Michael Holzheu    2015-05-11   8862  	/* BPF_JMP | BPF_JGE | BPF_X */
cffc642d93f932 Michael Holzheu    2015-05-11   8863  	{
cffc642d93f932 Michael Holzheu    2015-05-11   8864  		"JMP_JGE_X: if (3 >= 2) return 1",
cffc642d93f932 Michael Holzheu    2015-05-11   8865  		.u.insns_int = {
cffc642d93f932 Michael Holzheu    2015-05-11   8866  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
cffc642d93f932 Michael Holzheu    2015-05-11   8867  			BPF_LD_IMM64(R1, 3),
cffc642d93f932 Michael Holzheu    2015-05-11   8868  			BPF_LD_IMM64(R2, 2),
cffc642d93f932 Michael Holzheu    2015-05-11   8869  			BPF_JMP_REG(BPF_JGE, R1, R2, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8870  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8871  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8872  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8873  		},
cffc642d93f932 Michael Holzheu    2015-05-11   8874  		INTERNAL,
cffc642d93f932 Michael Holzheu    2015-05-11   8875  		{ },
cffc642d93f932 Michael Holzheu    2015-05-11   8876  		{ { 0, 1 } },
cffc642d93f932 Michael Holzheu    2015-05-11   8877  	},
cffc642d93f932 Michael Holzheu    2015-05-11   8878  	{
cffc642d93f932 Michael Holzheu    2015-05-11   8879  		"JMP_JGE_X: if (3 >= 3) return 1",
cffc642d93f932 Michael Holzheu    2015-05-11   8880  		.u.insns_int = {
cffc642d93f932 Michael Holzheu    2015-05-11   8881  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
cffc642d93f932 Michael Holzheu    2015-05-11   8882  			BPF_LD_IMM64(R1, 3),
cffc642d93f932 Michael Holzheu    2015-05-11   8883  			BPF_LD_IMM64(R2, 3),
cffc642d93f932 Michael Holzheu    2015-05-11   8884  			BPF_JMP_REG(BPF_JGE, R1, R2, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8885  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8886  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   8887  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   8888  		},
cffc642d93f932 Michael Holzheu    2015-05-11   8889  		INTERNAL,
cffc642d93f932 Michael Holzheu    2015-05-11   8890  		{ },
cffc642d93f932 Michael Holzheu    2015-05-11   8891  		{ { 0, 1 } },
cffc642d93f932 Michael Holzheu    2015-05-11   8892  	},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8893  	/* BPF_JMP | BPF_JLE | BPF_X */
92b31a9af73b3a Daniel Borkmann    2017-08-10   8894  	{
92b31a9af73b3a Daniel Borkmann    2017-08-10   8895  		"JMP_JLE_X: if (2 <= 3) return 1",
92b31a9af73b3a Daniel Borkmann    2017-08-10   8896  		.u.insns_int = {
92b31a9af73b3a Daniel Borkmann    2017-08-10   8897  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8898  			BPF_LD_IMM64(R1, 3),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8899  			BPF_LD_IMM64(R2, 2),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8900  			BPF_JMP_REG(BPF_JLE, R2, R1, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8901  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8902  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8903  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8904  		},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8905  		INTERNAL,
92b31a9af73b3a Daniel Borkmann    2017-08-10   8906  		{ },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8907  		{ { 0, 1 } },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8908  	},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8909  	{
92b31a9af73b3a Daniel Borkmann    2017-08-10   8910  		"JMP_JLE_X: if (3 <= 3) return 1",
92b31a9af73b3a Daniel Borkmann    2017-08-10   8911  		.u.insns_int = {
92b31a9af73b3a Daniel Borkmann    2017-08-10   8912  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8913  			BPF_LD_IMM64(R1, 3),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8914  			BPF_LD_IMM64(R2, 3),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8915  			BPF_JMP_REG(BPF_JLE, R1, R2, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8916  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8917  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8918  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8919  		},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8920  		INTERNAL,
92b31a9af73b3a Daniel Borkmann    2017-08-10   8921  		{ },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8922  		{ { 0, 1 } },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8923  	},
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8924  	{
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8925  		/* Mainly testing JIT + imm64 here. */
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8926  		"JMP_JGE_X: ldimm64 test 1",
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8927  		.u.insns_int = {
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8928  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8929  			BPF_LD_IMM64(R1, 3),
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8930  			BPF_LD_IMM64(R2, 2),
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8931  			BPF_JMP_REG(BPF_JGE, R1, R2, 2),
86f8e247b960d6 Geert Uytterhoeven 2017-05-03   8932  			BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
86f8e247b960d6 Geert Uytterhoeven 2017-05-03   8933  			BPF_LD_IMM64(R0, 0xeeeeeeeeeeeeeeeeULL),
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8934  			BPF_EXIT_INSN(),
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8935  		},
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8936  		INTERNAL,
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8937  		{ },
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8938  		{ { 0, 0xeeeeeeeeU } },
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8939  	},
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8940  	{
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8941  		"JMP_JGE_X: ldimm64 test 2",
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8942  		.u.insns_int = {
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8943  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8944  			BPF_LD_IMM64(R1, 3),
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8945  			BPF_LD_IMM64(R2, 2),
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8946  			BPF_JMP_REG(BPF_JGE, R1, R2, 0),
86f8e247b960d6 Geert Uytterhoeven 2017-05-03   8947  			BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8948  			BPF_EXIT_INSN(),
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8949  		},
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8950  		INTERNAL,
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8951  		{ },
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8952  		{ { 0, 0xffffffffU } },
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8953  	},
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8954  	{
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8955  		"JMP_JGE_X: ldimm64 test 3",
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8956  		.u.insns_int = {
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8957  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8958  			BPF_LD_IMM64(R1, 3),
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8959  			BPF_LD_IMM64(R2, 2),
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8960  			BPF_JMP_REG(BPF_JGE, R1, R2, 4),
86f8e247b960d6 Geert Uytterhoeven 2017-05-03   8961  			BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
86f8e247b960d6 Geert Uytterhoeven 2017-05-03   8962  			BPF_LD_IMM64(R0, 0xeeeeeeeeeeeeeeeeULL),
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8963  			BPF_EXIT_INSN(),
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8964  		},
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8965  		INTERNAL,
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8966  		{ },
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8967  		{ { 0, 1 } },
ddc665a4bb4b72 Daniel Borkmann    2017-05-02   8968  	},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8969  	{
92b31a9af73b3a Daniel Borkmann    2017-08-10   8970  		"JMP_JLE_X: ldimm64 test 1",
92b31a9af73b3a Daniel Borkmann    2017-08-10   8971  		.u.insns_int = {
92b31a9af73b3a Daniel Borkmann    2017-08-10   8972  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8973  			BPF_LD_IMM64(R1, 3),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8974  			BPF_LD_IMM64(R2, 2),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8975  			BPF_JMP_REG(BPF_JLE, R2, R1, 2),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8976  			BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8977  			BPF_LD_IMM64(R0, 0xeeeeeeeeeeeeeeeeULL),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8978  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8979  		},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8980  		INTERNAL,
92b31a9af73b3a Daniel Borkmann    2017-08-10   8981  		{ },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8982  		{ { 0, 0xeeeeeeeeU } },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8983  	},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8984  	{
92b31a9af73b3a Daniel Borkmann    2017-08-10   8985  		"JMP_JLE_X: ldimm64 test 2",
92b31a9af73b3a Daniel Borkmann    2017-08-10   8986  		.u.insns_int = {
92b31a9af73b3a Daniel Borkmann    2017-08-10   8987  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8988  			BPF_LD_IMM64(R1, 3),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8989  			BPF_LD_IMM64(R2, 2),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8990  			BPF_JMP_REG(BPF_JLE, R2, R1, 0),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8991  			BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8992  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   8993  		},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8994  		INTERNAL,
92b31a9af73b3a Daniel Borkmann    2017-08-10   8995  		{ },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8996  		{ { 0, 0xffffffffU } },
92b31a9af73b3a Daniel Borkmann    2017-08-10   8997  	},
92b31a9af73b3a Daniel Borkmann    2017-08-10   8998  	{
92b31a9af73b3a Daniel Borkmann    2017-08-10   8999  		"JMP_JLE_X: ldimm64 test 3",
92b31a9af73b3a Daniel Borkmann    2017-08-10   9000  		.u.insns_int = {
92b31a9af73b3a Daniel Borkmann    2017-08-10   9001  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
92b31a9af73b3a Daniel Borkmann    2017-08-10   9002  			BPF_LD_IMM64(R1, 3),
92b31a9af73b3a Daniel Borkmann    2017-08-10   9003  			BPF_LD_IMM64(R2, 2),
92b31a9af73b3a Daniel Borkmann    2017-08-10   9004  			BPF_JMP_REG(BPF_JLE, R2, R1, 4),
92b31a9af73b3a Daniel Borkmann    2017-08-10   9005  			BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
92b31a9af73b3a Daniel Borkmann    2017-08-10   9006  			BPF_LD_IMM64(R0, 0xeeeeeeeeeeeeeeeeULL),
92b31a9af73b3a Daniel Borkmann    2017-08-10   9007  			BPF_EXIT_INSN(),
92b31a9af73b3a Daniel Borkmann    2017-08-10   9008  		},
92b31a9af73b3a Daniel Borkmann    2017-08-10   9009  		INTERNAL,
92b31a9af73b3a Daniel Borkmann    2017-08-10   9010  		{ },
92b31a9af73b3a Daniel Borkmann    2017-08-10   9011  		{ { 0, 1 } },
92b31a9af73b3a Daniel Borkmann    2017-08-10   9012  	},
cffc642d93f932 Michael Holzheu    2015-05-11   9013  	/* BPF_JMP | BPF_JNE | BPF_X */
cffc642d93f932 Michael Holzheu    2015-05-11   9014  	{
cffc642d93f932 Michael Holzheu    2015-05-11   9015  		"JMP_JNE_X: if (3 != 2) return 1",
cffc642d93f932 Michael Holzheu    2015-05-11   9016  		.u.insns_int = {
cffc642d93f932 Michael Holzheu    2015-05-11   9017  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
cffc642d93f932 Michael Holzheu    2015-05-11   9018  			BPF_LD_IMM64(R1, 3),
cffc642d93f932 Michael Holzheu    2015-05-11   9019  			BPF_LD_IMM64(R2, 2),
cffc642d93f932 Michael Holzheu    2015-05-11   9020  			BPF_JMP_REG(BPF_JNE, R1, R2, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   9021  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   9022  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   9023  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   9024  		},
cffc642d93f932 Michael Holzheu    2015-05-11   9025  		INTERNAL,
cffc642d93f932 Michael Holzheu    2015-05-11   9026  		{ },
cffc642d93f932 Michael Holzheu    2015-05-11   9027  		{ { 0, 1 } },
cffc642d93f932 Michael Holzheu    2015-05-11   9028  	},
cffc642d93f932 Michael Holzheu    2015-05-11   9029  	/* BPF_JMP | BPF_JEQ | BPF_X */
cffc642d93f932 Michael Holzheu    2015-05-11   9030  	{
cffc642d93f932 Michael Holzheu    2015-05-11   9031  		"JMP_JEQ_X: if (3 == 3) return 1",
cffc642d93f932 Michael Holzheu    2015-05-11   9032  		.u.insns_int = {
cffc642d93f932 Michael Holzheu    2015-05-11   9033  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
cffc642d93f932 Michael Holzheu    2015-05-11   9034  			BPF_LD_IMM64(R1, 3),
cffc642d93f932 Michael Holzheu    2015-05-11   9035  			BPF_LD_IMM64(R2, 3),
cffc642d93f932 Michael Holzheu    2015-05-11   9036  			BPF_JMP_REG(BPF_JEQ, R1, R2, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   9037  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   9038  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   9039  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   9040  		},
cffc642d93f932 Michael Holzheu    2015-05-11   9041  		INTERNAL,
cffc642d93f932 Michael Holzheu    2015-05-11   9042  		{ },
cffc642d93f932 Michael Holzheu    2015-05-11   9043  		{ { 0, 1 } },
cffc642d93f932 Michael Holzheu    2015-05-11   9044  	},
cffc642d93f932 Michael Holzheu    2015-05-11   9045  	/* BPF_JMP | BPF_JSET | BPF_X */
cffc642d93f932 Michael Holzheu    2015-05-11   9046  	{
cffc642d93f932 Michael Holzheu    2015-05-11   9047  		"JMP_JSET_X: if (0x3 & 0x2) return 1",
cffc642d93f932 Michael Holzheu    2015-05-11   9048  		.u.insns_int = {
cffc642d93f932 Michael Holzheu    2015-05-11   9049  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
cffc642d93f932 Michael Holzheu    2015-05-11   9050  			BPF_LD_IMM64(R1, 3),
cffc642d93f932 Michael Holzheu    2015-05-11   9051  			BPF_LD_IMM64(R2, 2),
9f134c34fbce58 Naveen N. Rao      2016-04-05   9052  			BPF_JMP_REG(BPF_JSET, R1, R2, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   9053  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   9054  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   9055  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   9056  		},
cffc642d93f932 Michael Holzheu    2015-05-11   9057  		INTERNAL,
cffc642d93f932 Michael Holzheu    2015-05-11   9058  		{ },
cffc642d93f932 Michael Holzheu    2015-05-11   9059  		{ { 0, 1 } },
cffc642d93f932 Michael Holzheu    2015-05-11   9060  	},
cffc642d93f932 Michael Holzheu    2015-05-11   9061  	{
cffc642d93f932 Michael Holzheu    2015-05-11   9062  		"JMP_JSET_X: if (0x3 & 0xffffffff) return 1",
cffc642d93f932 Michael Holzheu    2015-05-11   9063  		.u.insns_int = {
cffc642d93f932 Michael Holzheu    2015-05-11   9064  			BPF_ALU32_IMM(BPF_MOV, R0, 0),
cffc642d93f932 Michael Holzheu    2015-05-11   9065  			BPF_LD_IMM64(R1, 3),
cffc642d93f932 Michael Holzheu    2015-05-11   9066  			BPF_LD_IMM64(R2, 0xffffffff),
9f134c34fbce58 Naveen N. Rao      2016-04-05   9067  			BPF_JMP_REG(BPF_JSET, R1, R2, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   9068  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   9069  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
cffc642d93f932 Michael Holzheu    2015-05-11   9070  			BPF_EXIT_INSN(),
cffc642d93f932 Michael Holzheu    2015-05-11   9071  		},
cffc642d93f932 Michael Holzheu    2015-05-11   9072  		INTERNAL,
cffc642d93f932 Michael Holzheu    2015-05-11   9073  		{ },
cffc642d93f932 Michael Holzheu    2015-05-11   9074  		{ { 0, 1 } },
cffc642d93f932 Michael Holzheu    2015-05-11   9075  	},
bde28bc6ad0c57 Daniel Borkmann    2015-05-26   9076  	{
bde28bc6ad0c57 Daniel Borkmann    2015-05-26   9077  		"JMP_JA: Jump, gap, jump, ...",
bde28bc6ad0c57 Daniel Borkmann    2015-05-26   9078  		{ },
bde28bc6ad0c57 Daniel Borkmann    2015-05-26   9079  		CLASSIC | FLAG_NO_DATA,
bde28bc6ad0c57 Daniel Borkmann    2015-05-26   9080  		{ },
bde28bc6ad0c57 Daniel Borkmann    2015-05-26   9081  		{ { 0, 0xababcbac } },
bde28bc6ad0c57 Daniel Borkmann    2015-05-26   9082  		.fill_helper = bpf_fill_ja,
bde28bc6ad0c57 Daniel Borkmann    2015-05-26   9083  	},
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9084  	{	/* Mainly checking JIT here. */
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9085  		"BPF_MAXINSNS: Maximum possible literals",
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9086  		{ },
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9087  		CLASSIC | FLAG_NO_DATA,
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9088  		{ },
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9089  		{ { 0, 0xffffffff } },
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9090  		.fill_helper = bpf_fill_maxinsns1,
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9091  	},
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9092  	{	/* Mainly checking JIT here. */
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9093  		"BPF_MAXINSNS: Single literal",
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9094  		{ },
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9095  		CLASSIC | FLAG_NO_DATA,
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9096  		{ },
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9097  		{ { 0, 0xfefefefe } },
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9098  		.fill_helper = bpf_fill_maxinsns2,
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9099  	},
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9100  	{	/* Mainly checking JIT here. */
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9101  		"BPF_MAXINSNS: Run/add until end",
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9102  		{ },
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9103  		CLASSIC | FLAG_NO_DATA,
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9104  		{ },
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9105  		{ { 0, 0x947bf368 } },
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9106  		.fill_helper = bpf_fill_maxinsns3,
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9107  	},
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9108  	{
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9109  		"BPF_MAXINSNS: Too many instructions",
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9110  		{ },
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9111  		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9112  		{ },
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9113  		{ },
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9114  		.fill_helper = bpf_fill_maxinsns4,
09584b40674241 Yonghong Song      2018-02-02   9115  		.expected_errcode = -EINVAL,
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9116  	},
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9117  	{	/* Mainly checking JIT here. */
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9118  		"BPF_MAXINSNS: Very long jump",
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9119  		{ },
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9120  		CLASSIC | FLAG_NO_DATA,
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9121  		{ },
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9122  		{ { 0, 0xabababab } },
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9123  		.fill_helper = bpf_fill_maxinsns5,
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9124  	},
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9125  	{	/* Mainly checking JIT here. */
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9126  		"BPF_MAXINSNS: Ctx heavy transformations",
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9127  		{ },
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9128  		CLASSIC,
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9129  		{ },
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9130  		{
0c4b2d370514cb Michał Mirosław    2018-11-10   9131  			{  1, SKB_VLAN_PRESENT },
0c4b2d370514cb Michał Mirosław    2018-11-10   9132  			{ 10, SKB_VLAN_PRESENT }
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9133  		},
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9134  		.fill_helper = bpf_fill_maxinsns6,
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9135  	},
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9136  	{	/* Mainly checking JIT here. */
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9137  		"BPF_MAXINSNS: Call heavy transformations",
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9138  		{ },
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9139  		CLASSIC | FLAG_NO_DATA,
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9140  		{ },
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9141  		{ { 1, 0 }, { 10, 0 } },
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9142  		.fill_helper = bpf_fill_maxinsns7,
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9143  	},
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9144  	{	/* Mainly checking JIT here. */
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9145  		"BPF_MAXINSNS: Jump heavy test",
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9146  		{ },
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9147  		CLASSIC | FLAG_NO_DATA,
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9148  		{ },
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9149  		{ { 0, 0xffffffff } },
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9150  		.fill_helper = bpf_fill_maxinsns8,
a4afd37b26f4b9 Daniel Borkmann    2015-05-13   9151  	},
3b52960266a36f Daniel Borkmann    2015-05-23   9152  	{	/* Mainly checking JIT here. */
3b52960266a36f Daniel Borkmann    2015-05-23   9153  		"BPF_MAXINSNS: Very long jump backwards",
3b52960266a36f Daniel Borkmann    2015-05-23   9154  		{ },
3b52960266a36f Daniel Borkmann    2015-05-23   9155  		INTERNAL | FLAG_NO_DATA,
3b52960266a36f Daniel Borkmann    2015-05-23   9156  		{ },
3b52960266a36f Daniel Borkmann    2015-05-23   9157  		{ { 0, 0xcbababab } },
3b52960266a36f Daniel Borkmann    2015-05-23   9158  		.fill_helper = bpf_fill_maxinsns9,
3b52960266a36f Daniel Borkmann    2015-05-23   9159  	},
3b52960266a36f Daniel Borkmann    2015-05-23   9160  	{	/* Mainly checking JIT here. */
3b52960266a36f Daniel Borkmann    2015-05-23   9161  		"BPF_MAXINSNS: Edge hopping nuthouse",
3b52960266a36f Daniel Borkmann    2015-05-23   9162  		{ },
3b52960266a36f Daniel Borkmann    2015-05-23   9163  		INTERNAL | FLAG_NO_DATA,
3b52960266a36f Daniel Borkmann    2015-05-23   9164  		{ },
3b52960266a36f Daniel Borkmann    2015-05-23   9165  		{ { 0, 0xabababac } },
3b52960266a36f Daniel Borkmann    2015-05-23   9166  		.fill_helper = bpf_fill_maxinsns10,
3b52960266a36f Daniel Borkmann    2015-05-23   9167  	},
bde28bc6ad0c57 Daniel Borkmann    2015-05-26   9168  	{
bde28bc6ad0c57 Daniel Borkmann    2015-05-26   9169  		"BPF_MAXINSNS: Jump, gap, jump, ...",
bde28bc6ad0c57 Daniel Borkmann    2015-05-26   9170  		{ },
bde28bc6ad0c57 Daniel Borkmann    2015-05-26   9171  		CLASSIC | FLAG_NO_DATA,
bde28bc6ad0c57 Daniel Borkmann    2015-05-26   9172  		{ },
bde28bc6ad0c57 Daniel Borkmann    2015-05-26   9173  		{ { 0, 0xababcbac } },
bde28bc6ad0c57 Daniel Borkmann    2015-05-26   9174  		.fill_helper = bpf_fill_maxinsns11,
bde28bc6ad0c57 Daniel Borkmann    2015-05-26   9175  	},
be08815c5d3b25 Daniel Borkmann    2018-06-02   9176  	{
be08815c5d3b25 Daniel Borkmann    2018-06-02   9177  		"BPF_MAXINSNS: jump over MSH",
be08815c5d3b25 Daniel Borkmann    2018-06-02   9178  		{ },
be08815c5d3b25 Daniel Borkmann    2018-06-02   9179  		CLASSIC | FLAG_EXPECTED_FAIL,
be08815c5d3b25 Daniel Borkmann    2018-06-02   9180  		{ 0xfa, 0xfb, 0xfc, 0xfd, },
be08815c5d3b25 Daniel Borkmann    2018-06-02   9181  		{ { 4, 0xabababab } },
be08815c5d3b25 Daniel Borkmann    2018-06-02   9182  		.fill_helper = bpf_fill_maxinsns12,
be08815c5d3b25 Daniel Borkmann    2018-06-02   9183  		.expected_errcode = -EINVAL,
be08815c5d3b25 Daniel Borkmann    2018-06-02   9184  	},
be08815c5d3b25 Daniel Borkmann    2018-06-02   9185  	{
be08815c5d3b25 Daniel Borkmann    2018-06-02   9186  		"BPF_MAXINSNS: exec all MSH",
be08815c5d3b25 Daniel Borkmann    2018-06-02   9187  		{ },
be08815c5d3b25 Daniel Borkmann    2018-06-02   9188  		CLASSIC,
be08815c5d3b25 Daniel Borkmann    2018-06-02   9189  		{ 0xfa, 0xfb, 0xfc, 0xfd, },
be08815c5d3b25 Daniel Borkmann    2018-06-02   9190  		{ { 4, 0xababab83 } },
be08815c5d3b25 Daniel Borkmann    2018-06-02   9191  		.fill_helper = bpf_fill_maxinsns13,
be08815c5d3b25 Daniel Borkmann    2018-06-02   9192  	},
4d9c5c53ac99e4 Alexei Starovoitov 2015-07-20   9193  	{
4d9c5c53ac99e4 Alexei Starovoitov 2015-07-20   9194  		"BPF_MAXINSNS: ld_abs+get_processor_id",
4d9c5c53ac99e4 Alexei Starovoitov 2015-07-20   9195  		{ },
4d9c5c53ac99e4 Alexei Starovoitov 2015-07-20   9196  		CLASSIC,
4d9c5c53ac99e4 Alexei Starovoitov 2015-07-20   9197  		{ },
4d9c5c53ac99e4 Alexei Starovoitov 2015-07-20   9198  		{ { 1, 0xbee } },
4d9c5c53ac99e4 Alexei Starovoitov 2015-07-20   9199  		.fill_helper = bpf_fill_ld_abs_get_processor_id,
4d9c5c53ac99e4 Alexei Starovoitov 2015-07-20   9200  	},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9201  	/*
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9202  	 * LD_IND / LD_ABS on fragmented SKBs
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9203  	 */
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9204  	{
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9205  		"LD_IND byte frag",
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9206  		.u.insns = {
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9207  			BPF_STMT(BPF_LDX | BPF_IMM, 0x40),
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9208  			BPF_STMT(BPF_LD | BPF_IND | BPF_B, 0x0),
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9209  			BPF_STMT(BPF_RET | BPF_A, 0x0),
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9210  		},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9211  		CLASSIC | FLAG_SKB_FRAG,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9212  		{ },
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9213  		{ {0x40, 0x42} },
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9214  		.frag_data = {
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9215  			0x42, 0x00, 0x00, 0x00,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9216  			0x43, 0x44, 0x00, 0x00,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9217  			0x21, 0x07, 0x19, 0x83,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9218  		},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9219  	},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9220  	{
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9221  		"LD_IND halfword frag",
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9222  		.u.insns = {
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9223  			BPF_STMT(BPF_LDX | BPF_IMM, 0x40),
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9224  			BPF_STMT(BPF_LD | BPF_IND | BPF_H, 0x4),
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9225  			BPF_STMT(BPF_RET | BPF_A, 0x0),
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9226  		},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9227  		CLASSIC | FLAG_SKB_FRAG,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9228  		{ },
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9229  		{ {0x40, 0x4344} },
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9230  		.frag_data = {
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9231  			0x42, 0x00, 0x00, 0x00,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9232  			0x43, 0x44, 0x00, 0x00,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9233  			0x21, 0x07, 0x19, 0x83,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9234  		},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9235  	},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9236  	{
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9237  		"LD_IND word frag",
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9238  		.u.insns = {
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9239  			BPF_STMT(BPF_LDX | BPF_IMM, 0x40),
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9240  			BPF_STMT(BPF_LD | BPF_IND | BPF_W, 0x8),
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9241  			BPF_STMT(BPF_RET | BPF_A, 0x0),
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9242  		},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9243  		CLASSIC | FLAG_SKB_FRAG,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9244  		{ },
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9245  		{ {0x40, 0x21071983} },
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9246  		.frag_data = {
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9247  			0x42, 0x00, 0x00, 0x00,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9248  			0x43, 0x44, 0x00, 0x00,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9249  			0x21, 0x07, 0x19, 0x83,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9250  		},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9251  	},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9252  	{
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9253  		"LD_IND halfword mixed head/frag",
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9254  		.u.insns = {
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9255  			BPF_STMT(BPF_LDX | BPF_IMM, 0x40),
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9256  			BPF_STMT(BPF_LD | BPF_IND | BPF_H, -0x1),
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9257  			BPF_STMT(BPF_RET | BPF_A, 0x0),
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9258  		},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9259  		CLASSIC | FLAG_SKB_FRAG,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9260  		{ [0x3e] = 0x25, [0x3f] = 0x05, },
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9261  		{ {0x40, 0x0519} },
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9262  		.frag_data = { 0x19, 0x82 },
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9263  	},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9264  	{
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9265  		"LD_IND word mixed head/frag",
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9266  		.u.insns = {
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9267  			BPF_STMT(BPF_LDX | BPF_IMM, 0x40),
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9268  			BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x2),
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9269  			BPF_STMT(BPF_RET | BPF_A, 0x0),
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9270  		},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9271  		CLASSIC | FLAG_SKB_FRAG,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9272  		{ [0x3e] = 0x25, [0x3f] = 0x05, },
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9273  		{ {0x40, 0x25051982} },
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9274  		.frag_data = { 0x19, 0x82 },
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9275  	},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9276  	{
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9277  		"LD_ABS byte frag",
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9278  		.u.insns = {
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9279  			BPF_STMT(BPF_LD | BPF_ABS | BPF_B, 0x40),
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9280  			BPF_STMT(BPF_RET | BPF_A, 0x0),
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9281  		},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9282  		CLASSIC | FLAG_SKB_FRAG,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9283  		{ },
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9284  		{ {0x40, 0x42} },
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9285  		.frag_data = {
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9286  			0x42, 0x00, 0x00, 0x00,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9287  			0x43, 0x44, 0x00, 0x00,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9288  			0x21, 0x07, 0x19, 0x83,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9289  		},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9290  	},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9291  	{
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9292  		"LD_ABS halfword frag",
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9293  		.u.insns = {
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9294  			BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x44),
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9295  			BPF_STMT(BPF_RET | BPF_A, 0x0),
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9296  		},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9297  		CLASSIC | FLAG_SKB_FRAG,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9298  		{ },
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9299  		{ {0x40, 0x4344} },
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9300  		.frag_data = {
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9301  			0x42, 0x00, 0x00, 0x00,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9302  			0x43, 0x44, 0x00, 0x00,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9303  			0x21, 0x07, 0x19, 0x83,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9304  		},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9305  	},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9306  	{
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9307  		"LD_ABS word frag",
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9308  		.u.insns = {
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9309  			BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x48),
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9310  			BPF_STMT(BPF_RET | BPF_A, 0x0),
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9311  		},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9312  		CLASSIC | FLAG_SKB_FRAG,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9313  		{ },
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9314  		{ {0x40, 0x21071983} },
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9315  		.frag_data = {
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9316  			0x42, 0x00, 0x00, 0x00,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9317  			0x43, 0x44, 0x00, 0x00,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9318  			0x21, 0x07, 0x19, 0x83,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9319  		},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9320  	},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9321  	{
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9322  		"LD_ABS halfword mixed head/frag",
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9323  		.u.insns = {
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9324  			BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x3f),
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9325  			BPF_STMT(BPF_RET | BPF_A, 0x0),
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9326  		},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9327  		CLASSIC | FLAG_SKB_FRAG,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9328  		{ [0x3e] = 0x25, [0x3f] = 0x05, },
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9329  		{ {0x40, 0x0519} },
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9330  		.frag_data = { 0x19, 0x82 },
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9331  	},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9332  	{
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9333  		"LD_ABS word mixed head/frag",
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9334  		.u.insns = {
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9335  			BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x3e),
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9336  			BPF_STMT(BPF_RET | BPF_A, 0x0),
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9337  		},
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9338  		CLASSIC | FLAG_SKB_FRAG,
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9339  		{ [0x3e] = 0x25, [0x3f] = 0x05, },
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9340  		{ {0x40, 0x25051982} },
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9341  		.frag_data = { 0x19, 0x82 },
2cf1ad759307f4 Nicolas Schichan   2015-08-04   9342  	},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9343  	/*
08fcb08fc06758 Nicolas Schichan   2015-08-04   9344  	 * LD_IND / LD_ABS on non fragmented SKBs
08fcb08fc06758 Nicolas Schichan   2015-08-04   9345  	 */
08fcb08fc06758 Nicolas Schichan   2015-08-04   9346  	{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9347  		/*
08fcb08fc06758 Nicolas Schichan   2015-08-04   9348  		 * this tests that the JIT/interpreter correctly resets X
08fcb08fc06758 Nicolas Schichan   2015-08-04   9349  		 * before using it in an LD_IND instruction.
08fcb08fc06758 Nicolas Schichan   2015-08-04   9350  		 */
08fcb08fc06758 Nicolas Schichan   2015-08-04   9351  		"LD_IND byte default X",
08fcb08fc06758 Nicolas Schichan   2015-08-04   9352  		.u.insns = {
08fcb08fc06758 Nicolas Schichan   2015-08-04   9353  			BPF_STMT(BPF_LD | BPF_IND | BPF_B, 0x1),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9354  			BPF_STMT(BPF_RET | BPF_A, 0x0),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9355  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9356  		CLASSIC,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9357  		{ [0x1] = 0x42 },
08fcb08fc06758 Nicolas Schichan   2015-08-04   9358  		{ {0x40, 0x42 } },
08fcb08fc06758 Nicolas Schichan   2015-08-04   9359  	},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9360  	{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9361  		"LD_IND byte positive offset",
08fcb08fc06758 Nicolas Schichan   2015-08-04   9362  		.u.insns = {
08fcb08fc06758 Nicolas Schichan   2015-08-04   9363  			BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9364  			BPF_STMT(BPF_LD | BPF_IND | BPF_B, 0x1),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9365  			BPF_STMT(BPF_RET | BPF_A, 0x0),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9366  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9367  		CLASSIC,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9368  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
08fcb08fc06758 Nicolas Schichan   2015-08-04   9369  		{ {0x40, 0x82 } },
08fcb08fc06758 Nicolas Schichan   2015-08-04   9370  	},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9371  	{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9372  		"LD_IND byte negative offset",
08fcb08fc06758 Nicolas Schichan   2015-08-04   9373  		.u.insns = {
08fcb08fc06758 Nicolas Schichan   2015-08-04   9374  			BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9375  			BPF_STMT(BPF_LD | BPF_IND | BPF_B, -0x1),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9376  			BPF_STMT(BPF_RET | BPF_A, 0x0),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9377  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9378  		CLASSIC,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9379  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
08fcb08fc06758 Nicolas Schichan   2015-08-04   9380  		{ {0x40, 0x05 } },
08fcb08fc06758 Nicolas Schichan   2015-08-04   9381  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9382  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9383  		"LD_IND byte positive offset, all ff",
93731ef086cee9 Daniel Borkmann    2018-05-04   9384  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9385  			BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
93731ef086cee9 Daniel Borkmann    2018-05-04   9386  			BPF_STMT(BPF_LD | BPF_IND | BPF_B, 0x1),
93731ef086cee9 Daniel Borkmann    2018-05-04   9387  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9388  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9389  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9390  		{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
93731ef086cee9 Daniel Borkmann    2018-05-04   9391  		{ {0x40, 0xff } },
93731ef086cee9 Daniel Borkmann    2018-05-04   9392  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9393  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9394  		"LD_IND byte positive offset, out of bounds",
93731ef086cee9 Daniel Borkmann    2018-05-04   9395  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9396  			BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
93731ef086cee9 Daniel Borkmann    2018-05-04   9397  			BPF_STMT(BPF_LD | BPF_IND | BPF_B, 0x1),
93731ef086cee9 Daniel Borkmann    2018-05-04   9398  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9399  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9400  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9401  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
93731ef086cee9 Daniel Borkmann    2018-05-04   9402  		{ {0x3f, 0 }, },
93731ef086cee9 Daniel Borkmann    2018-05-04   9403  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9404  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9405  		"LD_IND byte negative offset, out of bounds",
93731ef086cee9 Daniel Borkmann    2018-05-04   9406  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9407  			BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
93731ef086cee9 Daniel Borkmann    2018-05-04   9408  			BPF_STMT(BPF_LD | BPF_IND | BPF_B, -0x3f),
93731ef086cee9 Daniel Borkmann    2018-05-04   9409  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9410  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9411  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9412  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
93731ef086cee9 Daniel Borkmann    2018-05-04   9413  		{ {0x3f, 0 } },
93731ef086cee9 Daniel Borkmann    2018-05-04   9414  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9415  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9416  		"LD_IND byte negative offset, multiple calls",
93731ef086cee9 Daniel Borkmann    2018-05-04   9417  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9418  			BPF_STMT(BPF_LDX | BPF_IMM, 0x3b),
93731ef086cee9 Daniel Borkmann    2018-05-04   9419  			BPF_STMT(BPF_LD | BPF_IND | BPF_B, SKF_LL_OFF + 1),
93731ef086cee9 Daniel Borkmann    2018-05-04   9420  			BPF_STMT(BPF_LD | BPF_IND | BPF_B, SKF_LL_OFF + 2),
93731ef086cee9 Daniel Borkmann    2018-05-04   9421  			BPF_STMT(BPF_LD | BPF_IND | BPF_B, SKF_LL_OFF + 3),
93731ef086cee9 Daniel Borkmann    2018-05-04   9422  			BPF_STMT(BPF_LD | BPF_IND | BPF_B, SKF_LL_OFF + 4),
93731ef086cee9 Daniel Borkmann    2018-05-04   9423  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9424  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9425  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9426  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
93731ef086cee9 Daniel Borkmann    2018-05-04   9427  		{ {0x40, 0x82 }, },
93731ef086cee9 Daniel Borkmann    2018-05-04   9428  	},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9429  	{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9430  		"LD_IND halfword positive offset",
08fcb08fc06758 Nicolas Schichan   2015-08-04   9431  		.u.insns = {
08fcb08fc06758 Nicolas Schichan   2015-08-04   9432  			BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9433  			BPF_STMT(BPF_LD | BPF_IND | BPF_H, 0x2),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9434  			BPF_STMT(BPF_RET | BPF_A, 0x0),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9435  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9436  		CLASSIC,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9437  		{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9438  			[0x1c] = 0xaa, [0x1d] = 0x55,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9439  			[0x1e] = 0xbb, [0x1f] = 0x66,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9440  			[0x20] = 0xcc, [0x21] = 0x77,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9441  			[0x22] = 0xdd, [0x23] = 0x88,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9442  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9443  		{ {0x40, 0xdd88 } },
08fcb08fc06758 Nicolas Schichan   2015-08-04   9444  	},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9445  	{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9446  		"LD_IND halfword negative offset",
08fcb08fc06758 Nicolas Schichan   2015-08-04   9447  		.u.insns = {
08fcb08fc06758 Nicolas Schichan   2015-08-04   9448  			BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9449  			BPF_STMT(BPF_LD | BPF_IND | BPF_H, -0x2),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9450  			BPF_STMT(BPF_RET | BPF_A, 0x0),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9451  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9452  		CLASSIC,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9453  		{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9454  			[0x1c] = 0xaa, [0x1d] = 0x55,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9455  			[0x1e] = 0xbb, [0x1f] = 0x66,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9456  			[0x20] = 0xcc, [0x21] = 0x77,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9457  			[0x22] = 0xdd, [0x23] = 0x88,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9458  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9459  		{ {0x40, 0xbb66 } },
08fcb08fc06758 Nicolas Schichan   2015-08-04   9460  	},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9461  	{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9462  		"LD_IND halfword unaligned",
08fcb08fc06758 Nicolas Schichan   2015-08-04   9463  		.u.insns = {
08fcb08fc06758 Nicolas Schichan   2015-08-04   9464  			BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9465  			BPF_STMT(BPF_LD | BPF_IND | BPF_H, -0x1),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9466  			BPF_STMT(BPF_RET | BPF_A, 0x0),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9467  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9468  		CLASSIC,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9469  		{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9470  			[0x1c] = 0xaa, [0x1d] = 0x55,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9471  			[0x1e] = 0xbb, [0x1f] = 0x66,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9472  			[0x20] = 0xcc, [0x21] = 0x77,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9473  			[0x22] = 0xdd, [0x23] = 0x88,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9474  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9475  		{ {0x40, 0x66cc } },
08fcb08fc06758 Nicolas Schichan   2015-08-04   9476  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9477  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9478  		"LD_IND halfword positive offset, all ff",
93731ef086cee9 Daniel Borkmann    2018-05-04   9479  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9480  			BPF_STMT(BPF_LDX | BPF_IMM, 0x3d),
93731ef086cee9 Daniel Borkmann    2018-05-04   9481  			BPF_STMT(BPF_LD | BPF_IND | BPF_H, 0x1),
93731ef086cee9 Daniel Borkmann    2018-05-04   9482  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9483  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9484  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9485  		{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
93731ef086cee9 Daniel Borkmann    2018-05-04   9486  		{ {0x40, 0xffff } },
93731ef086cee9 Daniel Borkmann    2018-05-04   9487  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9488  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9489  		"LD_IND halfword positive offset, out of bounds",
93731ef086cee9 Daniel Borkmann    2018-05-04   9490  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9491  			BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
93731ef086cee9 Daniel Borkmann    2018-05-04   9492  			BPF_STMT(BPF_LD | BPF_IND | BPF_H, 0x1),
93731ef086cee9 Daniel Borkmann    2018-05-04   9493  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9494  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9495  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9496  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
93731ef086cee9 Daniel Borkmann    2018-05-04   9497  		{ {0x3f, 0 }, },
93731ef086cee9 Daniel Borkmann    2018-05-04   9498  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9499  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9500  		"LD_IND halfword negative offset, out of bounds",
93731ef086cee9 Daniel Borkmann    2018-05-04   9501  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9502  			BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
93731ef086cee9 Daniel Borkmann    2018-05-04   9503  			BPF_STMT(BPF_LD | BPF_IND | BPF_H, -0x3f),
93731ef086cee9 Daniel Borkmann    2018-05-04   9504  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9505  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9506  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9507  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
93731ef086cee9 Daniel Borkmann    2018-05-04   9508  		{ {0x3f, 0 } },
93731ef086cee9 Daniel Borkmann    2018-05-04   9509  	},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9510  	{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9511  		"LD_IND word positive offset",
08fcb08fc06758 Nicolas Schichan   2015-08-04   9512  		.u.insns = {
08fcb08fc06758 Nicolas Schichan   2015-08-04   9513  			BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9514  			BPF_STMT(BPF_LD | BPF_IND | BPF_W, 0x4),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9515  			BPF_STMT(BPF_RET | BPF_A, 0x0),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9516  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9517  		CLASSIC,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9518  		{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9519  			[0x1c] = 0xaa, [0x1d] = 0x55,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9520  			[0x1e] = 0xbb, [0x1f] = 0x66,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9521  			[0x20] = 0xcc, [0x21] = 0x77,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9522  			[0x22] = 0xdd, [0x23] = 0x88,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9523  			[0x24] = 0xee, [0x25] = 0x99,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9524  			[0x26] = 0xff, [0x27] = 0xaa,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9525  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9526  		{ {0x40, 0xee99ffaa } },
08fcb08fc06758 Nicolas Schichan   2015-08-04   9527  	},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9528  	{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9529  		"LD_IND word negative offset",
08fcb08fc06758 Nicolas Schichan   2015-08-04   9530  		.u.insns = {
08fcb08fc06758 Nicolas Schichan   2015-08-04   9531  			BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9532  			BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x4),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9533  			BPF_STMT(BPF_RET | BPF_A, 0x0),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9534  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9535  		CLASSIC,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9536  		{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9537  			[0x1c] = 0xaa, [0x1d] = 0x55,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9538  			[0x1e] = 0xbb, [0x1f] = 0x66,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9539  			[0x20] = 0xcc, [0x21] = 0x77,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9540  			[0x22] = 0xdd, [0x23] = 0x88,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9541  			[0x24] = 0xee, [0x25] = 0x99,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9542  			[0x26] = 0xff, [0x27] = 0xaa,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9543  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9544  		{ {0x40, 0xaa55bb66 } },
08fcb08fc06758 Nicolas Schichan   2015-08-04   9545  	},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9546  	{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9547  		"LD_IND word unaligned (addr & 3 == 2)",
08fcb08fc06758 Nicolas Schichan   2015-08-04   9548  		.u.insns = {
08fcb08fc06758 Nicolas Schichan   2015-08-04   9549  			BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9550  			BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x2),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9551  			BPF_STMT(BPF_RET | BPF_A, 0x0),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9552  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9553  		CLASSIC,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9554  		{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9555  			[0x1c] = 0xaa, [0x1d] = 0x55,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9556  			[0x1e] = 0xbb, [0x1f] = 0x66,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9557  			[0x20] = 0xcc, [0x21] = 0x77,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9558  			[0x22] = 0xdd, [0x23] = 0x88,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9559  			[0x24] = 0xee, [0x25] = 0x99,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9560  			[0x26] = 0xff, [0x27] = 0xaa,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9561  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9562  		{ {0x40, 0xbb66cc77 } },
08fcb08fc06758 Nicolas Schichan   2015-08-04   9563  	},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9564  	{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9565  		"LD_IND word unaligned (addr & 3 == 1)",
08fcb08fc06758 Nicolas Schichan   2015-08-04   9566  		.u.insns = {
08fcb08fc06758 Nicolas Schichan   2015-08-04   9567  			BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9568  			BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x3),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9569  			BPF_STMT(BPF_RET | BPF_A, 0x0),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9570  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9571  		CLASSIC,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9572  		{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9573  			[0x1c] = 0xaa, [0x1d] = 0x55,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9574  			[0x1e] = 0xbb, [0x1f] = 0x66,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9575  			[0x20] = 0xcc, [0x21] = 0x77,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9576  			[0x22] = 0xdd, [0x23] = 0x88,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9577  			[0x24] = 0xee, [0x25] = 0x99,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9578  			[0x26] = 0xff, [0x27] = 0xaa,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9579  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9580  		{ {0x40, 0x55bb66cc } },
08fcb08fc06758 Nicolas Schichan   2015-08-04   9581  	},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9582  	{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9583  		"LD_IND word unaligned (addr & 3 == 3)",
08fcb08fc06758 Nicolas Schichan   2015-08-04   9584  		.u.insns = {
08fcb08fc06758 Nicolas Schichan   2015-08-04   9585  			BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9586  			BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x1),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9587  			BPF_STMT(BPF_RET | BPF_A, 0x0),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9588  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9589  		CLASSIC,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9590  		{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9591  			[0x1c] = 0xaa, [0x1d] = 0x55,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9592  			[0x1e] = 0xbb, [0x1f] = 0x66,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9593  			[0x20] = 0xcc, [0x21] = 0x77,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9594  			[0x22] = 0xdd, [0x23] = 0x88,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9595  			[0x24] = 0xee, [0x25] = 0x99,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9596  			[0x26] = 0xff, [0x27] = 0xaa,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9597  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9598  		{ {0x40, 0x66cc77dd } },
08fcb08fc06758 Nicolas Schichan   2015-08-04   9599  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9600  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9601  		"LD_IND word positive offset, all ff",
93731ef086cee9 Daniel Borkmann    2018-05-04   9602  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9603  			BPF_STMT(BPF_LDX | BPF_IMM, 0x3b),
93731ef086cee9 Daniel Borkmann    2018-05-04   9604  			BPF_STMT(BPF_LD | BPF_IND | BPF_W, 0x1),
93731ef086cee9 Daniel Borkmann    2018-05-04   9605  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9606  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9607  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9608  		{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
93731ef086cee9 Daniel Borkmann    2018-05-04   9609  		{ {0x40, 0xffffffff } },
93731ef086cee9 Daniel Borkmann    2018-05-04   9610  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9611  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9612  		"LD_IND word positive offset, out of bounds",
93731ef086cee9 Daniel Borkmann    2018-05-04   9613  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9614  			BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
93731ef086cee9 Daniel Borkmann    2018-05-04   9615  			BPF_STMT(BPF_LD | BPF_IND | BPF_W, 0x1),
93731ef086cee9 Daniel Borkmann    2018-05-04   9616  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9617  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9618  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9619  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
93731ef086cee9 Daniel Borkmann    2018-05-04   9620  		{ {0x3f, 0 }, },
93731ef086cee9 Daniel Borkmann    2018-05-04   9621  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9622  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9623  		"LD_IND word negative offset, out of bounds",
93731ef086cee9 Daniel Borkmann    2018-05-04   9624  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9625  			BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
93731ef086cee9 Daniel Borkmann    2018-05-04   9626  			BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x3f),
93731ef086cee9 Daniel Borkmann    2018-05-04   9627  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9628  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9629  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9630  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
93731ef086cee9 Daniel Borkmann    2018-05-04   9631  		{ {0x3f, 0 } },
93731ef086cee9 Daniel Borkmann    2018-05-04   9632  	},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9633  	{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9634  		"LD_ABS byte",
08fcb08fc06758 Nicolas Schichan   2015-08-04   9635  		.u.insns = {
08fcb08fc06758 Nicolas Schichan   2015-08-04   9636  			BPF_STMT(BPF_LD | BPF_ABS | BPF_B, 0x20),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9637  			BPF_STMT(BPF_RET | BPF_A, 0x0),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9638  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9639  		CLASSIC,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9640  		{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9641  			[0x1c] = 0xaa, [0x1d] = 0x55,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9642  			[0x1e] = 0xbb, [0x1f] = 0x66,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9643  			[0x20] = 0xcc, [0x21] = 0x77,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9644  			[0x22] = 0xdd, [0x23] = 0x88,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9645  			[0x24] = 0xee, [0x25] = 0x99,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9646  			[0x26] = 0xff, [0x27] = 0xaa,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9647  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9648  		{ {0x40, 0xcc } },
08fcb08fc06758 Nicolas Schichan   2015-08-04   9649  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9650  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9651  		"LD_ABS byte positive offset, all ff",
93731ef086cee9 Daniel Borkmann    2018-05-04   9652  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9653  			BPF_STMT(BPF_LD | BPF_ABS | BPF_B, 0x3f),
93731ef086cee9 Daniel Borkmann    2018-05-04   9654  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9655  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9656  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9657  		{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
93731ef086cee9 Daniel Borkmann    2018-05-04   9658  		{ {0x40, 0xff } },
93731ef086cee9 Daniel Borkmann    2018-05-04   9659  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9660  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9661  		"LD_ABS byte positive offset, out of bounds",
93731ef086cee9 Daniel Borkmann    2018-05-04   9662  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9663  			BPF_STMT(BPF_LD | BPF_ABS | BPF_B, 0x3f),
93731ef086cee9 Daniel Borkmann    2018-05-04   9664  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9665  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9666  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9667  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
93731ef086cee9 Daniel Borkmann    2018-05-04   9668  		{ {0x3f, 0 }, },
93731ef086cee9 Daniel Borkmann    2018-05-04   9669  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9670  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9671  		"LD_ABS byte negative offset, out of bounds load",
93731ef086cee9 Daniel Borkmann    2018-05-04   9672  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9673  			BPF_STMT(BPF_LD | BPF_ABS | BPF_B, -1),
93731ef086cee9 Daniel Borkmann    2018-05-04   9674  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9675  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9676  		CLASSIC | FLAG_EXPECTED_FAIL,
93731ef086cee9 Daniel Borkmann    2018-05-04   9677  		.expected_errcode = -EINVAL,
93731ef086cee9 Daniel Borkmann    2018-05-04   9678  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9679  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9680  		"LD_ABS byte negative offset, in bounds",
93731ef086cee9 Daniel Borkmann    2018-05-04   9681  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9682  			BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3f),
93731ef086cee9 Daniel Borkmann    2018-05-04   9683  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9684  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9685  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9686  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
93731ef086cee9 Daniel Borkmann    2018-05-04   9687  		{ {0x40, 0x82 }, },
93731ef086cee9 Daniel Borkmann    2018-05-04   9688  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9689  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9690  		"LD_ABS byte negative offset, out of bounds",
93731ef086cee9 Daniel Borkmann    2018-05-04   9691  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9692  			BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3f),
93731ef086cee9 Daniel Borkmann    2018-05-04   9693  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9694  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9695  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9696  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
93731ef086cee9 Daniel Borkmann    2018-05-04   9697  		{ {0x3f, 0 }, },
93731ef086cee9 Daniel Borkmann    2018-05-04   9698  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9699  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9700  		"LD_ABS byte negative offset, multiple calls",
93731ef086cee9 Daniel Borkmann    2018-05-04   9701  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9702  			BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3c),
93731ef086cee9 Daniel Borkmann    2018-05-04   9703  			BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3d),
93731ef086cee9 Daniel Borkmann    2018-05-04   9704  			BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3e),
93731ef086cee9 Daniel Borkmann    2018-05-04   9705  			BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3f),
93731ef086cee9 Daniel Borkmann    2018-05-04   9706  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9707  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9708  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9709  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
93731ef086cee9 Daniel Borkmann    2018-05-04   9710  		{ {0x40, 0x82 }, },
93731ef086cee9 Daniel Borkmann    2018-05-04   9711  	},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9712  	{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9713  		"LD_ABS halfword",
08fcb08fc06758 Nicolas Schichan   2015-08-04   9714  		.u.insns = {
08fcb08fc06758 Nicolas Schichan   2015-08-04   9715  			BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x22),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9716  			BPF_STMT(BPF_RET | BPF_A, 0x0),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9717  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9718  		CLASSIC,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9719  		{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9720  			[0x1c] = 0xaa, [0x1d] = 0x55,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9721  			[0x1e] = 0xbb, [0x1f] = 0x66,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9722  			[0x20] = 0xcc, [0x21] = 0x77,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9723  			[0x22] = 0xdd, [0x23] = 0x88,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9724  			[0x24] = 0xee, [0x25] = 0x99,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9725  			[0x26] = 0xff, [0x27] = 0xaa,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9726  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9727  		{ {0x40, 0xdd88 } },
08fcb08fc06758 Nicolas Schichan   2015-08-04   9728  	},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9729  	{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9730  		"LD_ABS halfword unaligned",
08fcb08fc06758 Nicolas Schichan   2015-08-04   9731  		.u.insns = {
08fcb08fc06758 Nicolas Schichan   2015-08-04   9732  			BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x25),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9733  			BPF_STMT(BPF_RET | BPF_A, 0x0),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9734  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9735  		CLASSIC,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9736  		{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9737  			[0x1c] = 0xaa, [0x1d] = 0x55,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9738  			[0x1e] = 0xbb, [0x1f] = 0x66,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9739  			[0x20] = 0xcc, [0x21] = 0x77,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9740  			[0x22] = 0xdd, [0x23] = 0x88,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9741  			[0x24] = 0xee, [0x25] = 0x99,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9742  			[0x26] = 0xff, [0x27] = 0xaa,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9743  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9744  		{ {0x40, 0x99ff } },
08fcb08fc06758 Nicolas Schichan   2015-08-04   9745  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9746  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9747  		"LD_ABS halfword positive offset, all ff",
93731ef086cee9 Daniel Borkmann    2018-05-04   9748  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9749  			BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x3e),
93731ef086cee9 Daniel Borkmann    2018-05-04   9750  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9751  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9752  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9753  		{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
93731ef086cee9 Daniel Borkmann    2018-05-04   9754  		{ {0x40, 0xffff } },
93731ef086cee9 Daniel Borkmann    2018-05-04   9755  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9756  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9757  		"LD_ABS halfword positive offset, out of bounds",
93731ef086cee9 Daniel Borkmann    2018-05-04   9758  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9759  			BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x3f),
93731ef086cee9 Daniel Borkmann    2018-05-04   9760  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9761  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9762  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9763  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
93731ef086cee9 Daniel Borkmann    2018-05-04   9764  		{ {0x3f, 0 }, },
93731ef086cee9 Daniel Borkmann    2018-05-04   9765  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9766  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9767  		"LD_ABS halfword negative offset, out of bounds load",
93731ef086cee9 Daniel Borkmann    2018-05-04   9768  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9769  			BPF_STMT(BPF_LD | BPF_ABS | BPF_H, -1),
93731ef086cee9 Daniel Borkmann    2018-05-04   9770  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9771  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9772  		CLASSIC | FLAG_EXPECTED_FAIL,
93731ef086cee9 Daniel Borkmann    2018-05-04   9773  		.expected_errcode = -EINVAL,
93731ef086cee9 Daniel Borkmann    2018-05-04   9774  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9775  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9776  		"LD_ABS halfword negative offset, in bounds",
93731ef086cee9 Daniel Borkmann    2018-05-04   9777  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9778  			BPF_STMT(BPF_LD | BPF_ABS | BPF_H, SKF_LL_OFF + 0x3e),
93731ef086cee9 Daniel Borkmann    2018-05-04   9779  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9780  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9781  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9782  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
93731ef086cee9 Daniel Borkmann    2018-05-04   9783  		{ {0x40, 0x1982 }, },
93731ef086cee9 Daniel Borkmann    2018-05-04   9784  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9785  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9786  		"LD_ABS halfword negative offset, out of bounds",
93731ef086cee9 Daniel Borkmann    2018-05-04   9787  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9788  			BPF_STMT(BPF_LD | BPF_ABS | BPF_H, SKF_LL_OFF + 0x3e),
93731ef086cee9 Daniel Borkmann    2018-05-04   9789  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9790  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9791  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9792  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
93731ef086cee9 Daniel Borkmann    2018-05-04   9793  		{ {0x3f, 0 }, },
93731ef086cee9 Daniel Borkmann    2018-05-04   9794  	},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9795  	{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9796  		"LD_ABS word",
08fcb08fc06758 Nicolas Schichan   2015-08-04   9797  		.u.insns = {
08fcb08fc06758 Nicolas Schichan   2015-08-04   9798  			BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x1c),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9799  			BPF_STMT(BPF_RET | BPF_A, 0x0),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9800  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9801  		CLASSIC,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9802  		{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9803  			[0x1c] = 0xaa, [0x1d] = 0x55,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9804  			[0x1e] = 0xbb, [0x1f] = 0x66,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9805  			[0x20] = 0xcc, [0x21] = 0x77,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9806  			[0x22] = 0xdd, [0x23] = 0x88,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9807  			[0x24] = 0xee, [0x25] = 0x99,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9808  			[0x26] = 0xff, [0x27] = 0xaa,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9809  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9810  		{ {0x40, 0xaa55bb66 } },
08fcb08fc06758 Nicolas Schichan   2015-08-04   9811  	},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9812  	{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9813  		"LD_ABS word unaligned (addr & 3 == 2)",
08fcb08fc06758 Nicolas Schichan   2015-08-04   9814  		.u.insns = {
08fcb08fc06758 Nicolas Schichan   2015-08-04   9815  			BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x22),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9816  			BPF_STMT(BPF_RET | BPF_A, 0x0),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9817  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9818  		CLASSIC,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9819  		{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9820  			[0x1c] = 0xaa, [0x1d] = 0x55,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9821  			[0x1e] = 0xbb, [0x1f] = 0x66,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9822  			[0x20] = 0xcc, [0x21] = 0x77,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9823  			[0x22] = 0xdd, [0x23] = 0x88,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9824  			[0x24] = 0xee, [0x25] = 0x99,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9825  			[0x26] = 0xff, [0x27] = 0xaa,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9826  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9827  		{ {0x40, 0xdd88ee99 } },
08fcb08fc06758 Nicolas Schichan   2015-08-04   9828  	},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9829  	{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9830  		"LD_ABS word unaligned (addr & 3 == 1)",
08fcb08fc06758 Nicolas Schichan   2015-08-04   9831  		.u.insns = {
08fcb08fc06758 Nicolas Schichan   2015-08-04   9832  			BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x21),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9833  			BPF_STMT(BPF_RET | BPF_A, 0x0),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9834  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9835  		CLASSIC,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9836  		{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9837  			[0x1c] = 0xaa, [0x1d] = 0x55,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9838  			[0x1e] = 0xbb, [0x1f] = 0x66,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9839  			[0x20] = 0xcc, [0x21] = 0x77,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9840  			[0x22] = 0xdd, [0x23] = 0x88,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9841  			[0x24] = 0xee, [0x25] = 0x99,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9842  			[0x26] = 0xff, [0x27] = 0xaa,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9843  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9844  		{ {0x40, 0x77dd88ee } },
08fcb08fc06758 Nicolas Schichan   2015-08-04   9845  	},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9846  	{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9847  		"LD_ABS word unaligned (addr & 3 == 3)",
08fcb08fc06758 Nicolas Schichan   2015-08-04   9848  		.u.insns = {
08fcb08fc06758 Nicolas Schichan   2015-08-04   9849  			BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x23),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9850  			BPF_STMT(BPF_RET | BPF_A, 0x0),
08fcb08fc06758 Nicolas Schichan   2015-08-04   9851  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9852  		CLASSIC,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9853  		{
08fcb08fc06758 Nicolas Schichan   2015-08-04   9854  			[0x1c] = 0xaa, [0x1d] = 0x55,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9855  			[0x1e] = 0xbb, [0x1f] = 0x66,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9856  			[0x20] = 0xcc, [0x21] = 0x77,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9857  			[0x22] = 0xdd, [0x23] = 0x88,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9858  			[0x24] = 0xee, [0x25] = 0x99,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9859  			[0x26] = 0xff, [0x27] = 0xaa,
08fcb08fc06758 Nicolas Schichan   2015-08-04   9860  		},
08fcb08fc06758 Nicolas Schichan   2015-08-04   9861  		{ {0x40, 0x88ee99ff } },
08fcb08fc06758 Nicolas Schichan   2015-08-04   9862  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9863  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9864  		"LD_ABS word positive offset, all ff",
93731ef086cee9 Daniel Borkmann    2018-05-04   9865  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9866  			BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x3c),
93731ef086cee9 Daniel Borkmann    2018-05-04   9867  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9868  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9869  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9870  		{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
93731ef086cee9 Daniel Borkmann    2018-05-04   9871  		{ {0x40, 0xffffffff } },
93731ef086cee9 Daniel Borkmann    2018-05-04   9872  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9873  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9874  		"LD_ABS word positive offset, out of bounds",
93731ef086cee9 Daniel Borkmann    2018-05-04   9875  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9876  			BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x3f),
93731ef086cee9 Daniel Borkmann    2018-05-04   9877  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9878  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9879  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9880  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
93731ef086cee9 Daniel Borkmann    2018-05-04   9881  		{ {0x3f, 0 }, },
93731ef086cee9 Daniel Borkmann    2018-05-04   9882  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9883  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9884  		"LD_ABS word negative offset, out of bounds load",
93731ef086cee9 Daniel Borkmann    2018-05-04   9885  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9886  			BPF_STMT(BPF_LD | BPF_ABS | BPF_W, -1),
93731ef086cee9 Daniel Borkmann    2018-05-04   9887  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9888  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9889  		CLASSIC | FLAG_EXPECTED_FAIL,
93731ef086cee9 Daniel Borkmann    2018-05-04   9890  		.expected_errcode = -EINVAL,
93731ef086cee9 Daniel Borkmann    2018-05-04   9891  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9892  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9893  		"LD_ABS word negative offset, in bounds",
93731ef086cee9 Daniel Borkmann    2018-05-04   9894  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9895  			BPF_STMT(BPF_LD | BPF_ABS | BPF_W, SKF_LL_OFF + 0x3c),
93731ef086cee9 Daniel Borkmann    2018-05-04   9896  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9897  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9898  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9899  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
93731ef086cee9 Daniel Borkmann    2018-05-04   9900  		{ {0x40, 0x25051982 }, },
93731ef086cee9 Daniel Borkmann    2018-05-04   9901  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9902  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9903  		"LD_ABS word negative offset, out of bounds",
93731ef086cee9 Daniel Borkmann    2018-05-04   9904  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9905  			BPF_STMT(BPF_LD | BPF_ABS | BPF_W, SKF_LL_OFF + 0x3c),
93731ef086cee9 Daniel Borkmann    2018-05-04   9906  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9907  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9908  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9909  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
93731ef086cee9 Daniel Borkmann    2018-05-04   9910  		{ {0x3f, 0 }, },
93731ef086cee9 Daniel Borkmann    2018-05-04   9911  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9912  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9913  		"LDX_MSH standalone, preserved A",
93731ef086cee9 Daniel Borkmann    2018-05-04   9914  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9915  			BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
93731ef086cee9 Daniel Borkmann    2018-05-04   9916  			BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3c),
93731ef086cee9 Daniel Borkmann    2018-05-04   9917  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9918  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9919  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9920  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
93731ef086cee9 Daniel Borkmann    2018-05-04   9921  		{ {0x40, 0xffeebbaa }, },
93731ef086cee9 Daniel Borkmann    2018-05-04   9922  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9923  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9924  		"LDX_MSH standalone, preserved A 2",
93731ef086cee9 Daniel Borkmann    2018-05-04   9925  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9926  			BPF_STMT(BPF_LD | BPF_IMM, 0x175e9d63),
93731ef086cee9 Daniel Borkmann    2018-05-04   9927  			BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3c),
93731ef086cee9 Daniel Borkmann    2018-05-04   9928  			BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3d),
93731ef086cee9 Daniel Borkmann    2018-05-04   9929  			BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3e),
93731ef086cee9 Daniel Borkmann    2018-05-04   9930  			BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3f),
93731ef086cee9 Daniel Borkmann    2018-05-04   9931  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9932  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9933  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9934  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
93731ef086cee9 Daniel Borkmann    2018-05-04   9935  		{ {0x40, 0x175e9d63 }, },
93731ef086cee9 Daniel Borkmann    2018-05-04   9936  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9937  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9938  		"LDX_MSH standalone, test result 1",
93731ef086cee9 Daniel Borkmann    2018-05-04   9939  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9940  			BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
93731ef086cee9 Daniel Borkmann    2018-05-04   9941  			BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3c),
93731ef086cee9 Daniel Borkmann    2018-05-04   9942  			BPF_STMT(BPF_MISC | BPF_TXA, 0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9943  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9944  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9945  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9946  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
93731ef086cee9 Daniel Borkmann    2018-05-04   9947  		{ {0x40, 0x14 }, },
93731ef086cee9 Daniel Borkmann    2018-05-04   9948  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9949  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9950  		"LDX_MSH standalone, test result 2",
93731ef086cee9 Daniel Borkmann    2018-05-04   9951  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9952  			BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
93731ef086cee9 Daniel Borkmann    2018-05-04   9953  			BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3e),
93731ef086cee9 Daniel Borkmann    2018-05-04   9954  			BPF_STMT(BPF_MISC | BPF_TXA, 0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9955  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9956  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9957  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9958  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
93731ef086cee9 Daniel Borkmann    2018-05-04   9959  		{ {0x40, 0x24 }, },
93731ef086cee9 Daniel Borkmann    2018-05-04   9960  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9961  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9962  		"LDX_MSH standalone, negative offset",
93731ef086cee9 Daniel Borkmann    2018-05-04   9963  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9964  			BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
93731ef086cee9 Daniel Borkmann    2018-05-04   9965  			BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, -1),
93731ef086cee9 Daniel Borkmann    2018-05-04   9966  			BPF_STMT(BPF_MISC | BPF_TXA, 0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9967  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9968  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9969  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9970  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
93731ef086cee9 Daniel Borkmann    2018-05-04   9971  		{ {0x40, 0 }, },
93731ef086cee9 Daniel Borkmann    2018-05-04   9972  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9973  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9974  		"LDX_MSH standalone, negative offset 2",
93731ef086cee9 Daniel Borkmann    2018-05-04   9975  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9976  			BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
93731ef086cee9 Daniel Borkmann    2018-05-04   9977  			BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, SKF_LL_OFF + 0x3e),
93731ef086cee9 Daniel Borkmann    2018-05-04   9978  			BPF_STMT(BPF_MISC | BPF_TXA, 0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9979  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9980  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9981  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9982  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
93731ef086cee9 Daniel Borkmann    2018-05-04   9983  		{ {0x40, 0x24 }, },
93731ef086cee9 Daniel Borkmann    2018-05-04   9984  	},
93731ef086cee9 Daniel Borkmann    2018-05-04   9985  	{
93731ef086cee9 Daniel Borkmann    2018-05-04   9986  		"LDX_MSH standalone, out of bounds",
93731ef086cee9 Daniel Borkmann    2018-05-04   9987  		.u.insns = {
93731ef086cee9 Daniel Borkmann    2018-05-04   9988  			BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
93731ef086cee9 Daniel Borkmann    2018-05-04   9989  			BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x40),
93731ef086cee9 Daniel Borkmann    2018-05-04   9990  			BPF_STMT(BPF_MISC | BPF_TXA, 0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9991  			BPF_STMT(BPF_RET | BPF_A, 0x0),
93731ef086cee9 Daniel Borkmann    2018-05-04   9992  		},
93731ef086cee9 Daniel Borkmann    2018-05-04   9993  		CLASSIC,
93731ef086cee9 Daniel Borkmann    2018-05-04   9994  		{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
93731ef086cee9 Daniel Borkmann    2018-05-04   9995  		{ {0x40, 0 }, },
93731ef086cee9 Daniel Borkmann    2018-05-04   9996  	},
86bf1721b22636 Nicolas Schichan   2015-08-04   9997  	/*
86bf1721b22636 Nicolas Schichan   2015-08-04   9998  	 * verify that the interpreter or JIT correctly sets A and X
86bf1721b22636 Nicolas Schichan   2015-08-04   9999  	 * to 0.
86bf1721b22636 Nicolas Schichan   2015-08-04  10000  	 */
86bf1721b22636 Nicolas Schichan   2015-08-04  10001  	{
86bf1721b22636 Nicolas Schichan   2015-08-04  10002  		"ADD default X",
86bf1721b22636 Nicolas Schichan   2015-08-04  10003  		.u.insns = {
86bf1721b22636 Nicolas Schichan   2015-08-04  10004  			/*
86bf1721b22636 Nicolas Schichan   2015-08-04  10005  			 * A = 0x42
86bf1721b22636 Nicolas Schichan   2015-08-04  10006  			 * A = A + X
86bf1721b22636 Nicolas Schichan   2015-08-04  10007  			 * ret A
86bf1721b22636 Nicolas Schichan   2015-08-04  10008  			 */
86bf1721b22636 Nicolas Schichan   2015-08-04  10009  			BPF_STMT(BPF_LD | BPF_IMM, 0x42),
86bf1721b22636 Nicolas Schichan   2015-08-04  10010  			BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
86bf1721b22636 Nicolas Schichan   2015-08-04  10011  			BPF_STMT(BPF_RET | BPF_A, 0x0),
86bf1721b22636 Nicolas Schichan   2015-08-04  10012  		},
86bf1721b22636 Nicolas Schichan   2015-08-04  10013  		CLASSIC | FLAG_NO_DATA,
86bf1721b22636 Nicolas Schichan   2015-08-04  10014  		{},
86bf1721b22636 Nicolas Schichan   2015-08-04  10015  		{ {0x1, 0x42 } },
86bf1721b22636 Nicolas Schichan   2015-08-04  10016  	},
86bf1721b22636 Nicolas Schichan   2015-08-04  10017  	{
86bf1721b22636 Nicolas Schichan   2015-08-04  10018  		"ADD default A",
86bf1721b22636 Nicolas Schichan   2015-08-04  10019  		.u.insns = {
86bf1721b22636 Nicolas Schichan   2015-08-04  10020  			/*
86bf1721b22636 Nicolas Schichan   2015-08-04  10021  			 * A = A + 0x42
86bf1721b22636 Nicolas Schichan   2015-08-04  10022  			 * ret A
86bf1721b22636 Nicolas Schichan   2015-08-04  10023  			 */
86bf1721b22636 Nicolas Schichan   2015-08-04  10024  			BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 0x42),
86bf1721b22636 Nicolas Schichan   2015-08-04  10025  			BPF_STMT(BPF_RET | BPF_A, 0x0),
86bf1721b22636 Nicolas Schichan   2015-08-04  10026  		},
86bf1721b22636 Nicolas Schichan   2015-08-04  10027  		CLASSIC | FLAG_NO_DATA,
86bf1721b22636 Nicolas Schichan   2015-08-04  10028  		{},
86bf1721b22636 Nicolas Schichan   2015-08-04  10029  		{ {0x1, 0x42 } },
86bf1721b22636 Nicolas Schichan   2015-08-04  10030  	},
86bf1721b22636 Nicolas Schichan   2015-08-04  10031  	{
86bf1721b22636 Nicolas Schichan   2015-08-04  10032  		"SUB default X",
86bf1721b22636 Nicolas Schichan   2015-08-04  10033  		.u.insns = {
86bf1721b22636 Nicolas Schichan   2015-08-04  10034  			/*
86bf1721b22636 Nicolas Schichan   2015-08-04  10035  			 * A = 0x66
86bf1721b22636 Nicolas Schichan   2015-08-04  10036  			 * A = A - X
86bf1721b22636 Nicolas Schichan   2015-08-04  10037  			 * ret A
86bf1721b22636 Nicolas Schichan   2015-08-04  10038  			 */
86bf1721b22636 Nicolas Schichan   2015-08-04  10039  			BPF_STMT(BPF_LD | BPF_IMM, 0x66),
86bf1721b22636 Nicolas Schichan   2015-08-04  10040  			BPF_STMT(BPF_ALU | BPF_SUB | BPF_X, 0),
86bf1721b22636 Nicolas Schichan   2015-08-04  10041  			BPF_STMT(BPF_RET | BPF_A, 0x0),
86bf1721b22636 Nicolas Schichan   2015-08-04  10042  		},
86bf1721b22636 Nicolas Schichan   2015-08-04  10043  		CLASSIC | FLAG_NO_DATA,
86bf1721b22636 Nicolas Schichan   2015-08-04  10044  		{},
86bf1721b22636 Nicolas Schichan   2015-08-04  10045  		{ {0x1, 0x66 } },
86bf1721b22636 Nicolas Schichan   2015-08-04  10046  	},
86bf1721b22636 Nicolas Schichan   2015-08-04  10047  	{
86bf1721b22636 Nicolas Schichan   2015-08-04  10048  		"SUB default A",
86bf1721b22636 Nicolas Schichan   2015-08-04  10049  		.u.insns = {
86bf1721b22636 Nicolas Schichan   2015-08-04  10050  			/*
86bf1721b22636 Nicolas Schichan   2015-08-04  10051  			 * A = A - -0x66
86bf1721b22636 Nicolas Schichan   2015-08-04  10052  			 * ret A
86bf1721b22636 Nicolas Schichan   2015-08-04  10053  			 */
86bf1721b22636 Nicolas Schichan   2015-08-04  10054  			BPF_STMT(BPF_ALU | BPF_SUB | BPF_K, -0x66),
86bf1721b22636 Nicolas Schichan   2015-08-04  10055  			BPF_STMT(BPF_RET | BPF_A, 0x0),
86bf1721b22636 Nicolas Schichan   2015-08-04  10056  		},
86bf1721b22636 Nicolas Schichan   2015-08-04  10057  		CLASSIC | FLAG_NO_DATA,
86bf1721b22636 Nicolas Schichan   2015-08-04  10058  		{},
86bf1721b22636 Nicolas Schichan   2015-08-04  10059  		{ {0x1, 0x66 } },
86bf1721b22636 Nicolas Schichan   2015-08-04  10060  	},
86bf1721b22636 Nicolas Schichan   2015-08-04  10061  	{
86bf1721b22636 Nicolas Schichan   2015-08-04  10062  		"MUL default X",
86bf1721b22636 Nicolas Schichan   2015-08-04  10063  		.u.insns = {
86bf1721b22636 Nicolas Schichan   2015-08-04  10064  			/*
86bf1721b22636 Nicolas Schichan   2015-08-04  10065  			 * A = 0x42
86bf1721b22636 Nicolas Schichan   2015-08-04  10066  			 * A = A * X
86bf1721b22636 Nicolas Schichan   2015-08-04  10067  			 * ret A
86bf1721b22636 Nicolas Schichan   2015-08-04  10068  			 */
86bf1721b22636 Nicolas Schichan   2015-08-04  10069  			BPF_STMT(BPF_LD | BPF_IMM, 0x42),
86bf1721b22636 Nicolas Schichan   2015-08-04  10070  			BPF_STMT(BPF_ALU | BPF_MUL | BPF_X, 0),
86bf1721b22636 Nicolas Schichan   2015-08-04  10071  			BPF_STMT(BPF_RET | BPF_A, 0x0),
86bf1721b22636 Nicolas Schichan   2015-08-04  10072  		},
86bf1721b22636 Nicolas Schichan   2015-08-04  10073  		CLASSIC | FLAG_NO_DATA,
86bf1721b22636 Nicolas Schichan   2015-08-04  10074  		{},
86bf1721b22636 Nicolas Schichan   2015-08-04  10075  		{ {0x1, 0x0 } },
86bf1721b22636 Nicolas Schichan   2015-08-04  10076  	},
86bf1721b22636 Nicolas Schichan   2015-08-04  10077  	{
86bf1721b22636 Nicolas Schichan   2015-08-04  10078  		"MUL default A",
86bf1721b22636 Nicolas Schichan   2015-08-04  10079  		.u.insns = {
86bf1721b22636 Nicolas Schichan   2015-08-04  10080  			/*
86bf1721b22636 Nicolas Schichan   2015-08-04  10081  			 * A = A * 0x66
86bf1721b22636 Nicolas Schichan   2015-08-04  10082  			 * ret A
86bf1721b22636 Nicolas Schichan   2015-08-04  10083  			 */
86bf1721b22636 Nicolas Schichan   2015-08-04  10084  			BPF_STMT(BPF_ALU | BPF_MUL | BPF_K, 0x66),
86bf1721b22636 Nicolas Schichan   2015-08-04  10085  			BPF_STMT(BPF_RET | BPF_A, 0x0),
86bf1721b22636 Nicolas Schichan   2015-08-04  10086  		},
86bf1721b22636 Nicolas Schichan   2015-08-04  10087  		CLASSIC | FLAG_NO_DATA,
86bf1721b22636 Nicolas Schichan   2015-08-04  10088  		{},
86bf1721b22636 Nicolas Schichan   2015-08-04  10089  		{ {0x1, 0x0 } },
86bf1721b22636 Nicolas Schichan   2015-08-04  10090  	},
86bf1721b22636 Nicolas Schichan   2015-08-04  10091  	{
86bf1721b22636 Nicolas Schichan   2015-08-04  10092  		"DIV default X",
86bf1721b22636 Nicolas Schichan   2015-08-04  10093  		.u.insns = {
86bf1721b22636 Nicolas Schichan   2015-08-04  10094  			/*
86bf1721b22636 Nicolas Schichan   2015-08-04  10095  			 * A = 0x42
86bf1721b22636 Nicolas Schichan   2015-08-04  10096  			 * A = A / X ; this halt the filter execution if X is 0
86bf1721b22636 Nicolas Schichan   2015-08-04  10097  			 * ret 0x42
86bf1721b22636 Nicolas Schichan   2015-08-04  10098  			 */
86bf1721b22636 Nicolas Schichan   2015-08-04  10099  			BPF_STMT(BPF_LD | BPF_IMM, 0x42),
86bf1721b22636 Nicolas Schichan   2015-08-04  10100  			BPF_STMT(BPF_ALU | BPF_DIV | BPF_X, 0),
86bf1721b22636 Nicolas Schichan   2015-08-04  10101  			BPF_STMT(BPF_RET | BPF_K, 0x42),
86bf1721b22636 Nicolas Schichan   2015-08-04  10102  		},
86bf1721b22636 Nicolas Schichan   2015-08-04  10103  		CLASSIC | FLAG_NO_DATA,
86bf1721b22636 Nicolas Schichan   2015-08-04  10104  		{},
86bf1721b22636 Nicolas Schichan   2015-08-04  10105  		{ {0x1, 0x0 } },
86bf1721b22636 Nicolas Schichan   2015-08-04  10106  	},
86bf1721b22636 Nicolas Schichan   2015-08-04  10107  	{
86bf1721b22636 Nicolas Schichan   2015-08-04  10108  		"DIV default A",
86bf1721b22636 Nicolas Schichan   2015-08-04  10109  		.u.insns = {
86bf1721b22636 Nicolas Schichan   2015-08-04  10110  			/*
86bf1721b22636 Nicolas Schichan   2015-08-04  10111  			 * A = A / 1
86bf1721b22636 Nicolas Schichan   2015-08-04  10112  			 * ret A
86bf1721b22636 Nicolas Schichan   2015-08-04  10113  			 */
86bf1721b22636 Nicolas Schichan   2015-08-04  10114  			BPF_STMT(BPF_ALU | BPF_DIV | BPF_K, 0x1),
86bf1721b22636 Nicolas Schichan   2015-08-04  10115  			BPF_STMT(BPF_RET | BPF_A, 0x0),
86bf1721b22636 Nicolas Schichan   2015-08-04  10116  		},
86bf1721b22636 Nicolas Schichan   2015-08-04  10117  		CLASSIC | FLAG_NO_DATA,
86bf1721b22636 Nicolas Schichan   2015-08-04  10118  		{},
86bf1721b22636 Nicolas Schichan   2015-08-04  10119  		{ {0x1, 0x0 } },
86bf1721b22636 Nicolas Schichan   2015-08-04  10120  	},
d4e4bc16102cb1 Yang Shi           2015-11-04  10121  	{
d4e4bc16102cb1 Yang Shi           2015-11-04  10122  		"MOD default X",
d4e4bc16102cb1 Yang Shi           2015-11-04  10123  		.u.insns = {
d4e4bc16102cb1 Yang Shi           2015-11-04  10124  			/*
d4e4bc16102cb1 Yang Shi           2015-11-04  10125  			 * A = 0x42
d4e4bc16102cb1 Yang Shi           2015-11-04  10126  			 * A = A mod X ; this halt the filter execution if X is 0
d4e4bc16102cb1 Yang Shi           2015-11-04  10127  			 * ret 0x42
d4e4bc16102cb1 Yang Shi           2015-11-04  10128  			 */
d4e4bc16102cb1 Yang Shi           2015-11-04  10129  			BPF_STMT(BPF_LD | BPF_IMM, 0x42),
d4e4bc16102cb1 Yang Shi           2015-11-04  10130  			BPF_STMT(BPF_ALU | BPF_MOD | BPF_X, 0),
d4e4bc16102cb1 Yang Shi           2015-11-04  10131  			BPF_STMT(BPF_RET | BPF_K, 0x42),
d4e4bc16102cb1 Yang Shi           2015-11-04  10132  		},
d4e4bc16102cb1 Yang Shi           2015-11-04  10133  		CLASSIC | FLAG_NO_DATA,
d4e4bc16102cb1 Yang Shi           2015-11-04  10134  		{},
d4e4bc16102cb1 Yang Shi           2015-11-04  10135  		{ {0x1, 0x0 } },
d4e4bc16102cb1 Yang Shi           2015-11-04  10136  	},
d4e4bc16102cb1 Yang Shi           2015-11-04  10137  	{
d4e4bc16102cb1 Yang Shi           2015-11-04  10138  		"MOD default A",
d4e4bc16102cb1 Yang Shi           2015-11-04  10139  		.u.insns = {
d4e4bc16102cb1 Yang Shi           2015-11-04  10140  			/*
d4e4bc16102cb1 Yang Shi           2015-11-04  10141  			 * A = A mod 1
d4e4bc16102cb1 Yang Shi           2015-11-04  10142  			 * ret A
d4e4bc16102cb1 Yang Shi           2015-11-04  10143  			 */
d4e4bc16102cb1 Yang Shi           2015-11-04  10144  			BPF_STMT(BPF_ALU | BPF_MOD | BPF_K, 0x1),
d4e4bc16102cb1 Yang Shi           2015-11-04  10145  			BPF_STMT(BPF_RET | BPF_A, 0x0),
d4e4bc16102cb1 Yang Shi           2015-11-04  10146  		},
d4e4bc16102cb1 Yang Shi           2015-11-04  10147  		CLASSIC | FLAG_NO_DATA,
d4e4bc16102cb1 Yang Shi           2015-11-04  10148  		{},
d4e4bc16102cb1 Yang Shi           2015-11-04  10149  		{ {0x1, 0x0 } },
d4e4bc16102cb1 Yang Shi           2015-11-04  10150  	},
86bf1721b22636 Nicolas Schichan   2015-08-04  10151  	{
86bf1721b22636 Nicolas Schichan   2015-08-04  10152  		"JMP EQ default A",
86bf1721b22636 Nicolas Schichan   2015-08-04  10153  		.u.insns = {
86bf1721b22636 Nicolas Schichan   2015-08-04  10154  			/*
86bf1721b22636 Nicolas Schichan   2015-08-04  10155  			 * cmp A, 0x0, 0, 1
86bf1721b22636 Nicolas Schichan   2015-08-04  10156  			 * ret 0x42
86bf1721b22636 Nicolas Schichan   2015-08-04  10157  			 * ret 0x66
86bf1721b22636 Nicolas Schichan   2015-08-04  10158  			 */
86bf1721b22636 Nicolas Schichan   2015-08-04  10159  			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x0, 0, 1),
86bf1721b22636 Nicolas Schichan   2015-08-04  10160  			BPF_STMT(BPF_RET | BPF_K, 0x42),
86bf1721b22636 Nicolas Schichan   2015-08-04  10161  			BPF_STMT(BPF_RET | BPF_K, 0x66),
86bf1721b22636 Nicolas Schichan   2015-08-04  10162  		},
86bf1721b22636 Nicolas Schichan   2015-08-04  10163  		CLASSIC | FLAG_NO_DATA,
86bf1721b22636 Nicolas Schichan   2015-08-04  10164  		{},
86bf1721b22636 Nicolas Schichan   2015-08-04  10165  		{ {0x1, 0x42 } },
86bf1721b22636 Nicolas Schichan   2015-08-04  10166  	},
86bf1721b22636 Nicolas Schichan   2015-08-04  10167  	{
86bf1721b22636 Nicolas Schichan   2015-08-04  10168  		"JMP EQ default X",
86bf1721b22636 Nicolas Schichan   2015-08-04  10169  		.u.insns = {
86bf1721b22636 Nicolas Schichan   2015-08-04  10170  			/*
86bf1721b22636 Nicolas Schichan   2015-08-04  10171  			 * A = 0x0
86bf1721b22636 Nicolas Schichan   2015-08-04  10172  			 * cmp A, X, 0, 1
86bf1721b22636 Nicolas Schichan   2015-08-04  10173  			 * ret 0x42
86bf1721b22636 Nicolas Schichan   2015-08-04  10174  			 * ret 0x66
86bf1721b22636 Nicolas Schichan   2015-08-04  10175  			 */
86bf1721b22636 Nicolas Schichan   2015-08-04  10176  			BPF_STMT(BPF_LD | BPF_IMM, 0x0),
86bf1721b22636 Nicolas Schichan   2015-08-04  10177  			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_X, 0x0, 0, 1),
86bf1721b22636 Nicolas Schichan   2015-08-04  10178  			BPF_STMT(BPF_RET | BPF_K, 0x42),
86bf1721b22636 Nicolas Schichan   2015-08-04  10179  			BPF_STMT(BPF_RET | BPF_K, 0x66),
86bf1721b22636 Nicolas Schichan   2015-08-04  10180  		},
86bf1721b22636 Nicolas Schichan   2015-08-04  10181  		CLASSIC | FLAG_NO_DATA,
86bf1721b22636 Nicolas Schichan   2015-08-04  10182  		{},
86bf1721b22636 Nicolas Schichan   2015-08-04  10183  		{ {0x1, 0x42 } },
86bf1721b22636 Nicolas Schichan   2015-08-04  10184  	},
fcd1c917719548 Daniel Borkmann    2018-01-20  10185  	/* Checking interpreter vs JIT wrt signed extended imms. */
fcd1c917719548 Daniel Borkmann    2018-01-20  10186  	{
fcd1c917719548 Daniel Borkmann    2018-01-20  10187  		"JNE signed compare, test 1",
fcd1c917719548 Daniel Borkmann    2018-01-20  10188  		.u.insns_int = {
fcd1c917719548 Daniel Borkmann    2018-01-20  10189  			BPF_ALU32_IMM(BPF_MOV, R1, 0xfefbbc12),
fcd1c917719548 Daniel Borkmann    2018-01-20  10190  			BPF_ALU32_IMM(BPF_MOV, R3, 0xffff0000),
fcd1c917719548 Daniel Borkmann    2018-01-20  10191  			BPF_MOV64_REG(R2, R1),
fcd1c917719548 Daniel Borkmann    2018-01-20  10192  			BPF_ALU64_REG(BPF_AND, R2, R3),
fcd1c917719548 Daniel Borkmann    2018-01-20  10193  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
fcd1c917719548 Daniel Borkmann    2018-01-20  10194  			BPF_JMP_IMM(BPF_JNE, R2, -17104896, 1),
fcd1c917719548 Daniel Borkmann    2018-01-20  10195  			BPF_ALU32_IMM(BPF_MOV, R0, 2),
fcd1c917719548 Daniel Borkmann    2018-01-20  10196  			BPF_EXIT_INSN(),
fcd1c917719548 Daniel Borkmann    2018-01-20  10197  		},
fcd1c917719548 Daniel Borkmann    2018-01-20  10198  		INTERNAL,
fcd1c917719548 Daniel Borkmann    2018-01-20  10199  		{ },
fcd1c917719548 Daniel Borkmann    2018-01-20  10200  		{ { 0, 1 } },
fcd1c917719548 Daniel Borkmann    2018-01-20  10201  	},
fcd1c917719548 Daniel Borkmann    2018-01-20  10202  	{
fcd1c917719548 Daniel Borkmann    2018-01-20  10203  		"JNE signed compare, test 2",
fcd1c917719548 Daniel Borkmann    2018-01-20  10204  		.u.insns_int = {
fcd1c917719548 Daniel Borkmann    2018-01-20  10205  			BPF_ALU32_IMM(BPF_MOV, R1, 0xfefbbc12),
fcd1c917719548 Daniel Borkmann    2018-01-20  10206  			BPF_ALU32_IMM(BPF_MOV, R3, 0xffff0000),
fcd1c917719548 Daniel Borkmann    2018-01-20  10207  			BPF_MOV64_REG(R2, R1),
fcd1c917719548 Daniel Borkmann    2018-01-20  10208  			BPF_ALU64_REG(BPF_AND, R2, R3),
fcd1c917719548 Daniel Borkmann    2018-01-20  10209  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
fcd1c917719548 Daniel Borkmann    2018-01-20  10210  			BPF_JMP_IMM(BPF_JNE, R2, 0xfefb0000, 1),
fcd1c917719548 Daniel Borkmann    2018-01-20  10211  			BPF_ALU32_IMM(BPF_MOV, R0, 2),
fcd1c917719548 Daniel Borkmann    2018-01-20  10212  			BPF_EXIT_INSN(),
fcd1c917719548 Daniel Borkmann    2018-01-20  10213  		},
fcd1c917719548 Daniel Borkmann    2018-01-20  10214  		INTERNAL,
fcd1c917719548 Daniel Borkmann    2018-01-20  10215  		{ },
fcd1c917719548 Daniel Borkmann    2018-01-20  10216  		{ { 0, 1 } },
fcd1c917719548 Daniel Borkmann    2018-01-20  10217  	},
fcd1c917719548 Daniel Borkmann    2018-01-20  10218  	{
fcd1c917719548 Daniel Borkmann    2018-01-20  10219  		"JNE signed compare, test 3",
fcd1c917719548 Daniel Borkmann    2018-01-20  10220  		.u.insns_int = {
fcd1c917719548 Daniel Borkmann    2018-01-20  10221  			BPF_ALU32_IMM(BPF_MOV, R1, 0xfefbbc12),
fcd1c917719548 Daniel Borkmann    2018-01-20  10222  			BPF_ALU32_IMM(BPF_MOV, R3, 0xffff0000),
fcd1c917719548 Daniel Borkmann    2018-01-20  10223  			BPF_ALU32_IMM(BPF_MOV, R4, 0xfefb0000),
fcd1c917719548 Daniel Borkmann    2018-01-20  10224  			BPF_MOV64_REG(R2, R1),
fcd1c917719548 Daniel Borkmann    2018-01-20  10225  			BPF_ALU64_REG(BPF_AND, R2, R3),
fcd1c917719548 Daniel Borkmann    2018-01-20  10226  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
fcd1c917719548 Daniel Borkmann    2018-01-20  10227  			BPF_JMP_REG(BPF_JNE, R2, R4, 1),
fcd1c917719548 Daniel Borkmann    2018-01-20  10228  			BPF_ALU32_IMM(BPF_MOV, R0, 2),
fcd1c917719548 Daniel Borkmann    2018-01-20  10229  			BPF_EXIT_INSN(),
fcd1c917719548 Daniel Borkmann    2018-01-20  10230  		},
fcd1c917719548 Daniel Borkmann    2018-01-20  10231  		INTERNAL,
fcd1c917719548 Daniel Borkmann    2018-01-20  10232  		{ },
fcd1c917719548 Daniel Borkmann    2018-01-20  10233  		{ { 0, 2 } },
fcd1c917719548 Daniel Borkmann    2018-01-20  10234  	},
fcd1c917719548 Daniel Borkmann    2018-01-20  10235  	{
fcd1c917719548 Daniel Borkmann    2018-01-20  10236  		"JNE signed compare, test 4",
fcd1c917719548 Daniel Borkmann    2018-01-20  10237  		.u.insns_int = {
fcd1c917719548 Daniel Borkmann    2018-01-20  10238  			BPF_LD_IMM64(R1, -17104896),
fcd1c917719548 Daniel Borkmann    2018-01-20  10239  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
fcd1c917719548 Daniel Borkmann    2018-01-20  10240  			BPF_JMP_IMM(BPF_JNE, R1, -17104896, 1),
fcd1c917719548 Daniel Borkmann    2018-01-20  10241  			BPF_ALU32_IMM(BPF_MOV, R0, 2),
fcd1c917719548 Daniel Borkmann    2018-01-20  10242  			BPF_EXIT_INSN(),
fcd1c917719548 Daniel Borkmann    2018-01-20  10243  		},
fcd1c917719548 Daniel Borkmann    2018-01-20  10244  		INTERNAL,
fcd1c917719548 Daniel Borkmann    2018-01-20  10245  		{ },
fcd1c917719548 Daniel Borkmann    2018-01-20  10246  		{ { 0, 2 } },
fcd1c917719548 Daniel Borkmann    2018-01-20  10247  	},
fcd1c917719548 Daniel Borkmann    2018-01-20  10248  	{
fcd1c917719548 Daniel Borkmann    2018-01-20  10249  		"JNE signed compare, test 5",
fcd1c917719548 Daniel Borkmann    2018-01-20  10250  		.u.insns_int = {
fcd1c917719548 Daniel Borkmann    2018-01-20  10251  			BPF_LD_IMM64(R1, 0xfefb0000),
fcd1c917719548 Daniel Borkmann    2018-01-20  10252  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
fcd1c917719548 Daniel Borkmann    2018-01-20  10253  			BPF_JMP_IMM(BPF_JNE, R1, 0xfefb0000, 1),
fcd1c917719548 Daniel Borkmann    2018-01-20  10254  			BPF_ALU32_IMM(BPF_MOV, R0, 2),
fcd1c917719548 Daniel Borkmann    2018-01-20  10255  			BPF_EXIT_INSN(),
fcd1c917719548 Daniel Borkmann    2018-01-20  10256  		},
fcd1c917719548 Daniel Borkmann    2018-01-20  10257  		INTERNAL,
fcd1c917719548 Daniel Borkmann    2018-01-20  10258  		{ },
fcd1c917719548 Daniel Borkmann    2018-01-20  10259  		{ { 0, 1 } },
fcd1c917719548 Daniel Borkmann    2018-01-20  10260  	},
fcd1c917719548 Daniel Borkmann    2018-01-20  10261  	{
fcd1c917719548 Daniel Borkmann    2018-01-20  10262  		"JNE signed compare, test 6",
fcd1c917719548 Daniel Borkmann    2018-01-20  10263  		.u.insns_int = {
fcd1c917719548 Daniel Borkmann    2018-01-20  10264  			BPF_LD_IMM64(R1, 0x7efb0000),
fcd1c917719548 Daniel Borkmann    2018-01-20  10265  			BPF_ALU32_IMM(BPF_MOV, R0, 1),
fcd1c917719548 Daniel Borkmann    2018-01-20  10266  			BPF_JMP_IMM(BPF_JNE, R1, 0x7efb0000, 1),
fcd1c917719548 Daniel Borkmann    2018-01-20  10267  			BPF_ALU32_IMM(BPF_MOV, R0, 2),
fcd1c917719548 Daniel Borkmann    2018-01-20  10268  			BPF_EXIT_INSN(),
fcd1c917719548 Daniel Borkmann    2018-01-20  10269  		},
fcd1c917719548 Daniel Borkmann    2018-01-20  10270  		INTERNAL,
fcd1c917719548 Daniel Borkmann    2018-01-20  10271  		{ },
fcd1c917719548 Daniel Borkmann    2018-01-20  10272  		{ { 0, 2 } },
fcd1c917719548 Daniel Borkmann    2018-01-20  10273  	},
fcd1c917719548 Daniel Borkmann    2018-01-20  10274  	{
fcd1c917719548 Daniel Borkmann    2018-01-20  10275  		"JNE signed compare, test 7",
fcd1c917719548 Daniel Borkmann    2018-01-20  10276  		.u.insns = {
fcd1c917719548 Daniel Borkmann    2018-01-20  10277  			BPF_STMT(BPF_LD | BPF_IMM, 0xffff0000),
fcd1c917719548 Daniel Borkmann    2018-01-20  10278  			BPF_STMT(BPF_MISC | BPF_TAX, 0),
fcd1c917719548 Daniel Borkmann    2018-01-20  10279  			BPF_STMT(BPF_LD | BPF_IMM, 0xfefbbc12),
fcd1c917719548 Daniel Borkmann    2018-01-20  10280  			BPF_STMT(BPF_ALU | BPF_AND | BPF_X, 0),
fcd1c917719548 Daniel Borkmann    2018-01-20  10281  			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0xfefb0000, 1, 0),
fcd1c917719548 Daniel Borkmann    2018-01-20  10282  			BPF_STMT(BPF_RET | BPF_K, 1),
fcd1c917719548 Daniel Borkmann    2018-01-20  10283  			BPF_STMT(BPF_RET | BPF_K, 2),
fcd1c917719548 Daniel Borkmann    2018-01-20  10284  		},
fcd1c917719548 Daniel Borkmann    2018-01-20  10285  		CLASSIC | FLAG_NO_DATA,
fcd1c917719548 Daniel Borkmann    2018-01-20  10286  		{},
fcd1c917719548 Daniel Borkmann    2018-01-20  10287  		{ { 0, 2 } },
fcd1c917719548 Daniel Borkmann    2018-01-20  10288  	},
68c956fe741757 Johan Almbladh     2021-09-14  10289  	/* Exhaustive test of ALU64 shift operations */
68c956fe741757 Johan Almbladh     2021-09-14  10290  	{
68c956fe741757 Johan Almbladh     2021-09-14  10291  		"ALU64_LSH_K: all shift values",
68c956fe741757 Johan Almbladh     2021-09-14  10292  		{ },
68c956fe741757 Johan Almbladh     2021-09-14  10293  		INTERNAL | FLAG_NO_DATA,
68c956fe741757 Johan Almbladh     2021-09-14  10294  		{ },
68c956fe741757 Johan Almbladh     2021-09-14  10295  		{ { 0, 1 } },
68c956fe741757 Johan Almbladh     2021-09-14  10296  		.fill_helper = bpf_fill_alu_lsh_imm,
68c956fe741757 Johan Almbladh     2021-09-14  10297  	},
68c956fe741757 Johan Almbladh     2021-09-14  10298  	{
68c956fe741757 Johan Almbladh     2021-09-14  10299  		"ALU64_RSH_K: all shift values",
68c956fe741757 Johan Almbladh     2021-09-14  10300  		{ },
68c956fe741757 Johan Almbladh     2021-09-14  10301  		INTERNAL | FLAG_NO_DATA,
68c956fe741757 Johan Almbladh     2021-09-14  10302  		{ },
68c956fe741757 Johan Almbladh     2021-09-14  10303  		{ { 0, 1 } },
68c956fe741757 Johan Almbladh     2021-09-14  10304  		.fill_helper = bpf_fill_alu_rsh_imm,
68c956fe741757 Johan Almbladh     2021-09-14  10305  	},
68c956fe741757 Johan Almbladh     2021-09-14  10306  	{
68c956fe741757 Johan Almbladh     2021-09-14  10307  		"ALU64_ARSH_K: all shift values",
68c956fe741757 Johan Almbladh     2021-09-14  10308  		{ },
68c956fe741757 Johan Almbladh     2021-09-14  10309  		INTERNAL | FLAG_NO_DATA,
68c956fe741757 Johan Almbladh     2021-09-14  10310  		{ },
68c956fe741757 Johan Almbladh     2021-09-14  10311  		{ { 0, 1 } },
68c956fe741757 Johan Almbladh     2021-09-14  10312  		.fill_helper = bpf_fill_alu_arsh_imm,
68c956fe741757 Johan Almbladh     2021-09-14  10313  	},
68c956fe741757 Johan Almbladh     2021-09-14  10314  	{
68c956fe741757 Johan Almbladh     2021-09-14  10315  		"ALU64_LSH_X: all shift values",
68c956fe741757 Johan Almbladh     2021-09-14  10316  		{ },
68c956fe741757 Johan Almbladh     2021-09-14  10317  		INTERNAL | FLAG_NO_DATA,
68c956fe741757 Johan Almbladh     2021-09-14  10318  		{ },
68c956fe741757 Johan Almbladh     2021-09-14  10319  		{ { 0, 1 } },
68c956fe741757 Johan Almbladh     2021-09-14  10320  		.fill_helper = bpf_fill_alu_lsh_reg,
68c956fe741757 Johan Almbladh     2021-09-14  10321  	},
68c956fe741757 Johan Almbladh     2021-09-14  10322  	{
68c956fe741757 Johan Almbladh     2021-09-14  10323  		"ALU64_RSH_X: all shift values",
68c956fe741757 Johan Almbladh     2021-09-14  10324  		{ },
68c956fe741757 Johan Almbladh     2021-09-14  10325  		INTERNAL | FLAG_NO_DATA,
68c956fe741757 Johan Almbladh     2021-09-14  10326  		{ },
68c956fe741757 Johan Almbladh     2021-09-14  10327  		{ { 0, 1 } },
68c956fe741757 Johan Almbladh     2021-09-14  10328  		.fill_helper = bpf_fill_alu_rsh_reg,
68c956fe741757 Johan Almbladh     2021-09-14  10329  	},
68c956fe741757 Johan Almbladh     2021-09-14  10330  	{
68c956fe741757 Johan Almbladh     2021-09-14  10331  		"ALU64_ARSH_X: all shift values",
68c956fe741757 Johan Almbladh     2021-09-14  10332  		{ },
68c956fe741757 Johan Almbladh     2021-09-14  10333  		INTERNAL | FLAG_NO_DATA,
68c956fe741757 Johan Almbladh     2021-09-14  10334  		{ },
68c956fe741757 Johan Almbladh     2021-09-14  10335  		{ { 0, 1 } },
68c956fe741757 Johan Almbladh     2021-09-14  10336  		.fill_helper = bpf_fill_alu_arsh_reg,
68c956fe741757 Johan Almbladh     2021-09-14  10337  	},
68c956fe741757 Johan Almbladh     2021-09-14  10338  	/* Exhaustive test of ALU32 shift operations */
68c956fe741757 Johan Almbladh     2021-09-14  10339  	{
68c956fe741757 Johan Almbladh     2021-09-14  10340  		"ALU32_LSH_K: all shift values",
68c956fe741757 Johan Almbladh     2021-09-14  10341  		{ },
68c956fe741757 Johan Almbladh     2021-09-14  10342  		INTERNAL | FLAG_NO_DATA,
68c956fe741757 Johan Almbladh     2021-09-14  10343  		{ },
68c956fe741757 Johan Almbladh     2021-09-14  10344  		{ { 0, 1 } },
68c956fe741757 Johan Almbladh     2021-09-14  10345  		.fill_helper = bpf_fill_alu32_lsh_imm,
68c956fe741757 Johan Almbladh     2021-09-14  10346  	},
68c956fe741757 Johan Almbladh     2021-09-14  10347  	{
68c956fe741757 Johan Almbladh     2021-09-14  10348  		"ALU32_RSH_K: all shift values",
68c956fe741757 Johan Almbladh     2021-09-14  10349  		{ },
68c956fe741757 Johan Almbladh     2021-09-14  10350  		INTERNAL | FLAG_NO_DATA,
68c956fe741757 Johan Almbladh     2021-09-14  10351  		{ },
68c956fe741757 Johan Almbladh     2021-09-14  10352  		{ { 0, 1 } },
68c956fe741757 Johan Almbladh     2021-09-14  10353  		.fill_helper = bpf_fill_alu32_rsh_imm,
68c956fe741757 Johan Almbladh     2021-09-14  10354  	},
68c956fe741757 Johan Almbladh     2021-09-14  10355  	{
68c956fe741757 Johan Almbladh     2021-09-14  10356  		"ALU32_ARSH_K: all shift values",
68c956fe741757 Johan Almbladh     2021-09-14  10357  		{ },
68c956fe741757 Johan Almbladh     2021-09-14  10358  		INTERNAL | FLAG_NO_DATA,
68c956fe741757 Johan Almbladh     2021-09-14  10359  		{ },
68c956fe741757 Johan Almbladh     2021-09-14  10360  		{ { 0, 1 } },
68c956fe741757 Johan Almbladh     2021-09-14  10361  		.fill_helper = bpf_fill_alu32_arsh_imm,
68c956fe741757 Johan Almbladh     2021-09-14  10362  	},
68c956fe741757 Johan Almbladh     2021-09-14  10363  	{
68c956fe741757 Johan Almbladh     2021-09-14  10364  		"ALU32_LSH_X: all shift values",
68c956fe741757 Johan Almbladh     2021-09-14  10365  		{ },
68c956fe741757 Johan Almbladh     2021-09-14  10366  		INTERNAL | FLAG_NO_DATA,
68c956fe741757 Johan Almbladh     2021-09-14  10367  		{ },
68c956fe741757 Johan Almbladh     2021-09-14  10368  		{ { 0, 1 } },
68c956fe741757 Johan Almbladh     2021-09-14  10369  		.fill_helper = bpf_fill_alu32_lsh_reg,
68c956fe741757 Johan Almbladh     2021-09-14  10370  	},
68c956fe741757 Johan Almbladh     2021-09-14  10371  	{
68c956fe741757 Johan Almbladh     2021-09-14  10372  		"ALU32_RSH_X: all shift values",
68c956fe741757 Johan Almbladh     2021-09-14  10373  		{ },
68c956fe741757 Johan Almbladh     2021-09-14  10374  		INTERNAL | FLAG_NO_DATA,
68c956fe741757 Johan Almbladh     2021-09-14  10375  		{ },
68c956fe741757 Johan Almbladh     2021-09-14  10376  		{ { 0, 1 } },
68c956fe741757 Johan Almbladh     2021-09-14  10377  		.fill_helper = bpf_fill_alu32_rsh_reg,
68c956fe741757 Johan Almbladh     2021-09-14  10378  	},
68c956fe741757 Johan Almbladh     2021-09-14  10379  	{
68c956fe741757 Johan Almbladh     2021-09-14  10380  		"ALU32_ARSH_X: all shift values",
68c956fe741757 Johan Almbladh     2021-09-14  10381  		{ },
68c956fe741757 Johan Almbladh     2021-09-14  10382  		INTERNAL | FLAG_NO_DATA,
68c956fe741757 Johan Almbladh     2021-09-14  10383  		{ },
68c956fe741757 Johan Almbladh     2021-09-14  10384  		{ { 0, 1 } },
68c956fe741757 Johan Almbladh     2021-09-14  10385  		.fill_helper = bpf_fill_alu32_arsh_reg,
68c956fe741757 Johan Almbladh     2021-09-14  10386  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10387  	/* ALU64 immediate magnitudes */
9298e63eafea1e Johan Almbladh     2021-09-14  10388  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10389  		"ALU64_MOV_K: all immediate value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10390  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10391  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10392  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10393  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10394  		.fill_helper = bpf_fill_alu64_mov_imm,
9298e63eafea1e Johan Almbladh     2021-09-14  10395  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10396  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10397  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10398  		"ALU64_AND_K: all immediate value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10399  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10400  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10401  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10402  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10403  		.fill_helper = bpf_fill_alu64_and_imm,
9298e63eafea1e Johan Almbladh     2021-09-14  10404  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10405  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10406  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10407  		"ALU64_OR_K: all immediate value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10408  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10409  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10410  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10411  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10412  		.fill_helper = bpf_fill_alu64_or_imm,
9298e63eafea1e Johan Almbladh     2021-09-14  10413  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10414  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10415  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10416  		"ALU64_XOR_K: all immediate value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10417  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10418  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10419  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10420  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10421  		.fill_helper = bpf_fill_alu64_xor_imm,
9298e63eafea1e Johan Almbladh     2021-09-14  10422  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10423  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10424  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10425  		"ALU64_ADD_K: all immediate value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10426  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10427  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10428  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10429  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10430  		.fill_helper = bpf_fill_alu64_add_imm,
9298e63eafea1e Johan Almbladh     2021-09-14  10431  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10432  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10433  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10434  		"ALU64_SUB_K: all immediate value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10435  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10436  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10437  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10438  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10439  		.fill_helper = bpf_fill_alu64_sub_imm,
9298e63eafea1e Johan Almbladh     2021-09-14  10440  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10441  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10442  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10443  		"ALU64_MUL_K: all immediate value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10444  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10445  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10446  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10447  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10448  		.fill_helper = bpf_fill_alu64_mul_imm,
9298e63eafea1e Johan Almbladh     2021-09-14  10449  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10450  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10451  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10452  		"ALU64_DIV_K: all immediate value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10453  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10454  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10455  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10456  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10457  		.fill_helper = bpf_fill_alu64_div_imm,
9298e63eafea1e Johan Almbladh     2021-09-14  10458  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10459  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10460  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10461  		"ALU64_MOD_K: all immediate value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10462  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10463  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10464  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10465  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10466  		.fill_helper = bpf_fill_alu64_mod_imm,
9298e63eafea1e Johan Almbladh     2021-09-14  10467  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10468  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10469  	/* ALU32 immediate magnitudes */
9298e63eafea1e Johan Almbladh     2021-09-14  10470  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10471  		"ALU32_MOV_K: all immediate value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10472  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10473  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10474  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10475  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10476  		.fill_helper = bpf_fill_alu32_mov_imm,
9298e63eafea1e Johan Almbladh     2021-09-14  10477  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10478  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10479  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10480  		"ALU32_AND_K: all immediate value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10481  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10482  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10483  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10484  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10485  		.fill_helper = bpf_fill_alu32_and_imm,
9298e63eafea1e Johan Almbladh     2021-09-14  10486  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10487  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10488  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10489  		"ALU32_OR_K: all immediate value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10490  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10491  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10492  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10493  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10494  		.fill_helper = bpf_fill_alu32_or_imm,
9298e63eafea1e Johan Almbladh     2021-09-14  10495  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10496  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10497  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10498  		"ALU32_XOR_K: all immediate value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10499  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10500  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10501  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10502  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10503  		.fill_helper = bpf_fill_alu32_xor_imm,
9298e63eafea1e Johan Almbladh     2021-09-14  10504  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10505  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10506  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10507  		"ALU32_ADD_K: all immediate value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10508  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10509  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10510  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10511  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10512  		.fill_helper = bpf_fill_alu32_add_imm,
9298e63eafea1e Johan Almbladh     2021-09-14  10513  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10514  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10515  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10516  		"ALU32_SUB_K: all immediate value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10517  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10518  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10519  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10520  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10521  		.fill_helper = bpf_fill_alu32_sub_imm,
9298e63eafea1e Johan Almbladh     2021-09-14  10522  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10523  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10524  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10525  		"ALU32_MUL_K: all immediate value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10526  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10527  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10528  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10529  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10530  		.fill_helper = bpf_fill_alu32_mul_imm,
9298e63eafea1e Johan Almbladh     2021-09-14  10531  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10532  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10533  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10534  		"ALU32_DIV_K: all immediate value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10535  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10536  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10537  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10538  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10539  		.fill_helper = bpf_fill_alu32_div_imm,
9298e63eafea1e Johan Almbladh     2021-09-14  10540  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10541  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10542  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10543  		"ALU32_MOD_K: all immediate value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10544  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10545  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10546  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10547  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10548  		.fill_helper = bpf_fill_alu32_mod_imm,
a5a36544de3805 Johan Almbladh     2021-09-14  10549  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10550  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10551  	/* ALU64 register magnitudes */
9298e63eafea1e Johan Almbladh     2021-09-14  10552  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10553  		"ALU64_MOV_X: all register value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10554  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10555  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10556  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10557  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10558  		.fill_helper = bpf_fill_alu64_mov_reg,
9298e63eafea1e Johan Almbladh     2021-09-14  10559  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10560  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10561  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10562  		"ALU64_AND_X: all register value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10563  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10564  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10565  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10566  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10567  		.fill_helper = bpf_fill_alu64_and_reg,
9298e63eafea1e Johan Almbladh     2021-09-14  10568  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10569  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10570  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10571  		"ALU64_OR_X: all register value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10572  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10573  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10574  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10575  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10576  		.fill_helper = bpf_fill_alu64_or_reg,
9298e63eafea1e Johan Almbladh     2021-09-14  10577  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10578  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10579  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10580  		"ALU64_XOR_X: all register value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10581  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10582  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10583  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10584  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10585  		.fill_helper = bpf_fill_alu64_xor_reg,
9298e63eafea1e Johan Almbladh     2021-09-14  10586  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10587  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10588  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10589  		"ALU64_ADD_X: all register value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10590  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10591  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10592  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10593  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10594  		.fill_helper = bpf_fill_alu64_add_reg,
9298e63eafea1e Johan Almbladh     2021-09-14  10595  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10596  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10597  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10598  		"ALU64_SUB_X: all register value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10599  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10600  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10601  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10602  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10603  		.fill_helper = bpf_fill_alu64_sub_reg,
9298e63eafea1e Johan Almbladh     2021-09-14  10604  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10605  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10606  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10607  		"ALU64_MUL_X: all register value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10608  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10609  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10610  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10611  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10612  		.fill_helper = bpf_fill_alu64_mul_reg,
9298e63eafea1e Johan Almbladh     2021-09-14  10613  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10614  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10615  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10616  		"ALU64_DIV_X: all register value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10617  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10618  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10619  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10620  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10621  		.fill_helper = bpf_fill_alu64_div_reg,
9298e63eafea1e Johan Almbladh     2021-09-14  10622  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10623  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10624  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10625  		"ALU64_MOD_X: all register value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10626  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10627  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10628  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10629  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10630  		.fill_helper = bpf_fill_alu64_mod_reg,
9298e63eafea1e Johan Almbladh     2021-09-14  10631  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10632  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10633  	/* ALU32 register magnitudes */
9298e63eafea1e Johan Almbladh     2021-09-14  10634  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10635  		"ALU32_MOV_X: all register value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10636  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10637  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10638  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10639  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10640  		.fill_helper = bpf_fill_alu32_mov_reg,
9298e63eafea1e Johan Almbladh     2021-09-14  10641  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10642  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10643  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10644  		"ALU32_AND_X: all register value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10645  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10646  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10647  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10648  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10649  		.fill_helper = bpf_fill_alu32_and_reg,
9298e63eafea1e Johan Almbladh     2021-09-14  10650  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10651  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10652  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10653  		"ALU32_OR_X: all register value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10654  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10655  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10656  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10657  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10658  		.fill_helper = bpf_fill_alu32_or_reg,
9298e63eafea1e Johan Almbladh     2021-09-14  10659  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10660  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10661  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10662  		"ALU32_XOR_X: all register value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10663  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10664  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10665  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10666  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10667  		.fill_helper = bpf_fill_alu32_xor_reg,
9298e63eafea1e Johan Almbladh     2021-09-14  10668  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10669  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10670  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10671  		"ALU32_ADD_X: all register value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10672  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10673  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10674  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10675  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10676  		.fill_helper = bpf_fill_alu32_add_reg,
9298e63eafea1e Johan Almbladh     2021-09-14  10677  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10678  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10679  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10680  		"ALU32_SUB_X: all register value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10681  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10682  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10683  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10684  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10685  		.fill_helper = bpf_fill_alu32_sub_reg,
9298e63eafea1e Johan Almbladh     2021-09-14  10686  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10687  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10688  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10689  		"ALU32_MUL_X: all register value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10690  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10691  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10692  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10693  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10694  		.fill_helper = bpf_fill_alu32_mul_reg,
9298e63eafea1e Johan Almbladh     2021-09-14  10695  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10696  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10697  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10698  		"ALU32_DIV_X: all register value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10699  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10700  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10701  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10702  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10703  		.fill_helper = bpf_fill_alu32_div_reg,
9298e63eafea1e Johan Almbladh     2021-09-14  10704  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10705  	},
9298e63eafea1e Johan Almbladh     2021-09-14  10706  	{
9298e63eafea1e Johan Almbladh     2021-09-14  10707  		"ALU32_MOD_X: all register value magnitudes",
9298e63eafea1e Johan Almbladh     2021-09-14  10708  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10709  		INTERNAL | FLAG_NO_DATA,
9298e63eafea1e Johan Almbladh     2021-09-14  10710  		{ },
9298e63eafea1e Johan Almbladh     2021-09-14  10711  		{ { 0, 1 } },
9298e63eafea1e Johan Almbladh     2021-09-14  10712  		.fill_helper = bpf_fill_alu32_mod_reg,
9298e63eafea1e Johan Almbladh     2021-09-14  10713  		.nr_testruns = NR_PATTERN_RUNS,
9298e63eafea1e Johan Almbladh     2021-09-14  10714  	},
2e807611945c2d Johan Almbladh     2021-09-14  10715  	/* LD_IMM64 immediate magnitudes */
2e807611945c2d Johan Almbladh     2021-09-14  10716  	{
2e807611945c2d Johan Almbladh     2021-09-14  10717  		"LD_IMM64: all immediate value magnitudes",
2e807611945c2d Johan Almbladh     2021-09-14  10718  		{ },
2e807611945c2d Johan Almbladh     2021-09-14  10719  		INTERNAL | FLAG_NO_DATA,
2e807611945c2d Johan Almbladh     2021-09-14  10720  		{ },
2e807611945c2d Johan Almbladh     2021-09-14  10721  		{ { 0, 1 } },
2e807611945c2d Johan Almbladh     2021-09-14  10722  		.fill_helper = bpf_fill_ld_imm64,
2e807611945c2d Johan Almbladh     2021-09-14  10723  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10724  	/* JMP immediate magnitudes */
a5a36544de3805 Johan Almbladh     2021-09-14  10725  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10726  		"JMP_JSET_K: all immediate value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10727  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10728  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10729  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10730  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10731  		.fill_helper = bpf_fill_jmp_jset_imm,
a5a36544de3805 Johan Almbladh     2021-09-14  10732  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10733  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10734  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10735  		"JMP_JEQ_K: all immediate value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10736  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10737  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10738  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10739  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10740  		.fill_helper = bpf_fill_jmp_jeq_imm,
a5a36544de3805 Johan Almbladh     2021-09-14  10741  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10742  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10743  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10744  		"JMP_JNE_K: all immediate value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10745  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10746  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10747  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10748  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10749  		.fill_helper = bpf_fill_jmp_jne_imm,
a5a36544de3805 Johan Almbladh     2021-09-14  10750  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10751  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10752  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10753  		"JMP_JGT_K: all immediate value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10754  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10755  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10756  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10757  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10758  		.fill_helper = bpf_fill_jmp_jgt_imm,
a5a36544de3805 Johan Almbladh     2021-09-14  10759  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10760  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10761  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10762  		"JMP_JGE_K: all immediate value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10763  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10764  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10765  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10766  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10767  		.fill_helper = bpf_fill_jmp_jge_imm,
a5a36544de3805 Johan Almbladh     2021-09-14  10768  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10769  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10770  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10771  		"JMP_JLT_K: all immediate value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10772  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10773  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10774  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10775  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10776  		.fill_helper = bpf_fill_jmp_jlt_imm,
a5a36544de3805 Johan Almbladh     2021-09-14  10777  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10778  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10779  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10780  		"JMP_JLE_K: all immediate value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10781  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10782  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10783  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10784  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10785  		.fill_helper = bpf_fill_jmp_jle_imm,
a5a36544de3805 Johan Almbladh     2021-09-14  10786  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10787  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10788  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10789  		"JMP_JSGT_K: all immediate value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10790  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10791  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10792  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10793  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10794  		.fill_helper = bpf_fill_jmp_jsgt_imm,
a5a36544de3805 Johan Almbladh     2021-09-14  10795  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10796  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10797  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10798  		"JMP_JSGE_K: all immediate value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10799  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10800  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10801  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10802  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10803  		.fill_helper = bpf_fill_jmp_jsge_imm,
a5a36544de3805 Johan Almbladh     2021-09-14  10804  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10805  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10806  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10807  		"JMP_JSLT_K: all immediate value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10808  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10809  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10810  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10811  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10812  		.fill_helper = bpf_fill_jmp_jslt_imm,
a5a36544de3805 Johan Almbladh     2021-09-14  10813  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10814  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10815  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10816  		"JMP_JSLE_K: all immediate value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10817  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10818  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10819  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10820  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10821  		.fill_helper = bpf_fill_jmp_jsle_imm,
a5a36544de3805 Johan Almbladh     2021-09-14  10822  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10823  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10824  	/* JMP register magnitudes */
a5a36544de3805 Johan Almbladh     2021-09-14  10825  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10826  		"JMP_JSET_X: all register value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10827  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10828  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10829  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10830  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10831  		.fill_helper = bpf_fill_jmp_jset_reg,
a5a36544de3805 Johan Almbladh     2021-09-14  10832  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10833  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10834  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10835  		"JMP_JEQ_X: all register value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10836  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10837  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10838  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10839  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10840  		.fill_helper = bpf_fill_jmp_jeq_reg,
a5a36544de3805 Johan Almbladh     2021-09-14  10841  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10842  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10843  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10844  		"JMP_JNE_X: all register value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10845  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10846  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10847  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10848  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10849  		.fill_helper = bpf_fill_jmp_jne_reg,
a5a36544de3805 Johan Almbladh     2021-09-14  10850  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10851  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10852  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10853  		"JMP_JGT_X: all register value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10854  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10855  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10856  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10857  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10858  		.fill_helper = bpf_fill_jmp_jgt_reg,
a5a36544de3805 Johan Almbladh     2021-09-14  10859  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10860  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10861  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10862  		"JMP_JGE_X: all register value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10863  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10864  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10865  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10866  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10867  		.fill_helper = bpf_fill_jmp_jge_reg,
a5a36544de3805 Johan Almbladh     2021-09-14  10868  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10869  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10870  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10871  		"JMP_JLT_X: all register value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10872  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10873  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10874  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10875  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10876  		.fill_helper = bpf_fill_jmp_jlt_reg,
a5a36544de3805 Johan Almbladh     2021-09-14  10877  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10878  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10879  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10880  		"JMP_JLE_X: all register value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10881  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10882  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10883  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10884  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10885  		.fill_helper = bpf_fill_jmp_jle_reg,
a5a36544de3805 Johan Almbladh     2021-09-14  10886  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10887  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10888  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10889  		"JMP_JSGT_X: all register value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10890  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10891  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10892  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10893  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10894  		.fill_helper = bpf_fill_jmp_jsgt_reg,
a5a36544de3805 Johan Almbladh     2021-09-14  10895  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10896  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10897  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10898  		"JMP_JSGE_X: all register value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10899  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10900  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10901  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10902  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10903  		.fill_helper = bpf_fill_jmp_jsge_reg,
a5a36544de3805 Johan Almbladh     2021-09-14  10904  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10905  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10906  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10907  		"JMP_JSLT_X: all register value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10908  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10909  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10910  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10911  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10912  		.fill_helper = bpf_fill_jmp_jslt_reg,
a5a36544de3805 Johan Almbladh     2021-09-14  10913  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10914  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10915  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10916  		"JMP_JSLE_X: all register value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10917  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10918  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10919  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10920  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10921  		.fill_helper = bpf_fill_jmp_jsle_reg,
a5a36544de3805 Johan Almbladh     2021-09-14  10922  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10923  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10924  	/* JMP32 immediate magnitudes */
a5a36544de3805 Johan Almbladh     2021-09-14  10925  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10926  		"JMP32_JSET_K: all immediate value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10927  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10928  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10929  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10930  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10931  		.fill_helper = bpf_fill_jmp32_jset_imm,
a5a36544de3805 Johan Almbladh     2021-09-14  10932  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10933  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10934  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10935  		"JMP32_JEQ_K: all immediate value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10936  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10937  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10938  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10939  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10940  		.fill_helper = bpf_fill_jmp32_jeq_imm,
a5a36544de3805 Johan Almbladh     2021-09-14  10941  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10942  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10943  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10944  		"JMP32_JNE_K: all immediate value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10945  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10946  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10947  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10948  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10949  		.fill_helper = bpf_fill_jmp32_jne_imm,
a5a36544de3805 Johan Almbladh     2021-09-14  10950  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10951  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10952  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10953  		"JMP32_JGT_K: all immediate value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10954  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10955  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10956  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10957  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10958  		.fill_helper = bpf_fill_jmp32_jgt_imm,
a5a36544de3805 Johan Almbladh     2021-09-14  10959  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10960  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10961  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10962  		"JMP32_JGE_K: all immediate value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10963  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10964  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10965  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10966  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10967  		.fill_helper = bpf_fill_jmp32_jge_imm,
a5a36544de3805 Johan Almbladh     2021-09-14  10968  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10969  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10970  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10971  		"JMP32_JLT_K: all immediate value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10972  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10973  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10974  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10975  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10976  		.fill_helper = bpf_fill_jmp32_jlt_imm,
a5a36544de3805 Johan Almbladh     2021-09-14  10977  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10978  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10979  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10980  		"JMP32_JLE_K: all immediate value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10981  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10982  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10983  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10984  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10985  		.fill_helper = bpf_fill_jmp32_jle_imm,
a5a36544de3805 Johan Almbladh     2021-09-14  10986  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10987  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10988  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10989  		"JMP32_JSGT_K: all immediate value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10990  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10991  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  10992  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  10993  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  10994  		.fill_helper = bpf_fill_jmp32_jsgt_imm,
a5a36544de3805 Johan Almbladh     2021-09-14  10995  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  10996  	},
a5a36544de3805 Johan Almbladh     2021-09-14  10997  	{
a5a36544de3805 Johan Almbladh     2021-09-14  10998  		"JMP32_JSGE_K: all immediate value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  10999  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11000  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  11001  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11002  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  11003  		.fill_helper = bpf_fill_jmp32_jsge_imm,
a5a36544de3805 Johan Almbladh     2021-09-14  11004  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  11005  	},
a5a36544de3805 Johan Almbladh     2021-09-14  11006  	{
a5a36544de3805 Johan Almbladh     2021-09-14  11007  		"JMP32_JSLT_K: all immediate value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  11008  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11009  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  11010  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11011  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  11012  		.fill_helper = bpf_fill_jmp32_jslt_imm,
a5a36544de3805 Johan Almbladh     2021-09-14  11013  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  11014  	},
a5a36544de3805 Johan Almbladh     2021-09-14  11015  	{
a5a36544de3805 Johan Almbladh     2021-09-14  11016  		"JMP32_JSLE_K: all immediate value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  11017  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11018  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  11019  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11020  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  11021  		.fill_helper = bpf_fill_jmp32_jsle_imm,
a5a36544de3805 Johan Almbladh     2021-09-14  11022  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  11023  	},
a5a36544de3805 Johan Almbladh     2021-09-14  11024  	/* JMP32 register magnitudes */
a5a36544de3805 Johan Almbladh     2021-09-14  11025  	{
a5a36544de3805 Johan Almbladh     2021-09-14  11026  		"JMP32_JSET_X: all register value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  11027  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11028  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  11029  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11030  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  11031  		.fill_helper = bpf_fill_jmp32_jset_reg,
a5a36544de3805 Johan Almbladh     2021-09-14  11032  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  11033  	},
a5a36544de3805 Johan Almbladh     2021-09-14  11034  	{
a5a36544de3805 Johan Almbladh     2021-09-14  11035  		"JMP32_JEQ_X: all register value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  11036  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11037  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  11038  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11039  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  11040  		.fill_helper = bpf_fill_jmp32_jeq_reg,
a5a36544de3805 Johan Almbladh     2021-09-14  11041  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  11042  	},
a5a36544de3805 Johan Almbladh     2021-09-14  11043  	{
a5a36544de3805 Johan Almbladh     2021-09-14  11044  		"JMP32_JNE_X: all register value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  11045  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11046  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  11047  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11048  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  11049  		.fill_helper = bpf_fill_jmp32_jne_reg,
a5a36544de3805 Johan Almbladh     2021-09-14  11050  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  11051  	},
a5a36544de3805 Johan Almbladh     2021-09-14  11052  	{
a5a36544de3805 Johan Almbladh     2021-09-14  11053  		"JMP32_JGT_X: all register value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  11054  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11055  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  11056  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11057  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  11058  		.fill_helper = bpf_fill_jmp32_jgt_reg,
a5a36544de3805 Johan Almbladh     2021-09-14  11059  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  11060  	},
a5a36544de3805 Johan Almbladh     2021-09-14  11061  	{
a5a36544de3805 Johan Almbladh     2021-09-14  11062  		"JMP32_JGE_X: all register value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  11063  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11064  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  11065  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11066  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  11067  		.fill_helper = bpf_fill_jmp32_jge_reg,
a5a36544de3805 Johan Almbladh     2021-09-14  11068  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  11069  	},
a5a36544de3805 Johan Almbladh     2021-09-14  11070  	{
a5a36544de3805 Johan Almbladh     2021-09-14  11071  		"JMP32_JLT_X: all register value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  11072  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11073  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  11074  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11075  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  11076  		.fill_helper = bpf_fill_jmp32_jlt_reg,
a5a36544de3805 Johan Almbladh     2021-09-14  11077  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  11078  	},
a5a36544de3805 Johan Almbladh     2021-09-14  11079  	{
a5a36544de3805 Johan Almbladh     2021-09-14  11080  		"JMP32_JLE_X: all register value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  11081  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11082  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  11083  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11084  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  11085  		.fill_helper = bpf_fill_jmp32_jle_reg,
a5a36544de3805 Johan Almbladh     2021-09-14  11086  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  11087  	},
a5a36544de3805 Johan Almbladh     2021-09-14  11088  	{
a5a36544de3805 Johan Almbladh     2021-09-14  11089  		"JMP32_JSGT_X: all register value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  11090  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11091  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  11092  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11093  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  11094  		.fill_helper = bpf_fill_jmp32_jsgt_reg,
a5a36544de3805 Johan Almbladh     2021-09-14  11095  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  11096  	},
a5a36544de3805 Johan Almbladh     2021-09-14  11097  	{
a5a36544de3805 Johan Almbladh     2021-09-14  11098  		"JMP32_JSGE_X: all register value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  11099  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11100  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  11101  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11102  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  11103  		.fill_helper = bpf_fill_jmp32_jsge_reg,
a5a36544de3805 Johan Almbladh     2021-09-14  11104  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  11105  	},
a5a36544de3805 Johan Almbladh     2021-09-14  11106  	{
a5a36544de3805 Johan Almbladh     2021-09-14  11107  		"JMP32_JSLT_X: all register value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  11108  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11109  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  11110  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11111  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  11112  		.fill_helper = bpf_fill_jmp32_jslt_reg,
a5a36544de3805 Johan Almbladh     2021-09-14  11113  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  11114  	},
a5a36544de3805 Johan Almbladh     2021-09-14  11115  	{
a5a36544de3805 Johan Almbladh     2021-09-14  11116  		"JMP32_JSLE_X: all register value magnitudes",
a5a36544de3805 Johan Almbladh     2021-09-14  11117  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11118  		INTERNAL | FLAG_NO_DATA,
a5a36544de3805 Johan Almbladh     2021-09-14  11119  		{ },
a5a36544de3805 Johan Almbladh     2021-09-14  11120  		{ { 0, 1 } },
a5a36544de3805 Johan Almbladh     2021-09-14  11121  		.fill_helper = bpf_fill_jmp32_jsle_reg,
a5a36544de3805 Johan Almbladh     2021-09-14  11122  		.nr_testruns = NR_PATTERN_RUNS,
a5a36544de3805 Johan Almbladh     2021-09-14  11123  	},
c4df4559db8447 Johan Almbladh     2021-09-14  11124  	/* Conditional jumps with constant decision */
c4df4559db8447 Johan Almbladh     2021-09-14  11125  	{
c4df4559db8447 Johan Almbladh     2021-09-14  11126  		"JMP_JSET_K: imm = 0 -> never taken",
c4df4559db8447 Johan Almbladh     2021-09-14  11127  		.u.insns_int = {
c4df4559db8447 Johan Almbladh     2021-09-14  11128  			BPF_ALU64_IMM(BPF_MOV, R0, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11129  			BPF_JMP_IMM(BPF_JSET, R1, 0, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11130  			BPF_ALU64_IMM(BPF_MOV, R0, 0),
c4df4559db8447 Johan Almbladh     2021-09-14  11131  			BPF_EXIT_INSN(),
c4df4559db8447 Johan Almbladh     2021-09-14  11132  		},
c4df4559db8447 Johan Almbladh     2021-09-14  11133  		INTERNAL | FLAG_NO_DATA,
c4df4559db8447 Johan Almbladh     2021-09-14  11134  		{ },
c4df4559db8447 Johan Almbladh     2021-09-14  11135  		{ { 0, 0 } },
c4df4559db8447 Johan Almbladh     2021-09-14  11136  	},
c4df4559db8447 Johan Almbladh     2021-09-14  11137  	{
c4df4559db8447 Johan Almbladh     2021-09-14  11138  		"JMP_JLT_K: imm = 0 -> never taken",
c4df4559db8447 Johan Almbladh     2021-09-14  11139  		.u.insns_int = {
c4df4559db8447 Johan Almbladh     2021-09-14  11140  			BPF_ALU64_IMM(BPF_MOV, R0, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11141  			BPF_JMP_IMM(BPF_JLT, R1, 0, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11142  			BPF_ALU64_IMM(BPF_MOV, R0, 0),
c4df4559db8447 Johan Almbladh     2021-09-14  11143  			BPF_EXIT_INSN(),
c4df4559db8447 Johan Almbladh     2021-09-14  11144  		},
c4df4559db8447 Johan Almbladh     2021-09-14  11145  		INTERNAL | FLAG_NO_DATA,
c4df4559db8447 Johan Almbladh     2021-09-14  11146  		{ },
c4df4559db8447 Johan Almbladh     2021-09-14  11147  		{ { 0, 0 } },
c4df4559db8447 Johan Almbladh     2021-09-14  11148  	},
c4df4559db8447 Johan Almbladh     2021-09-14  11149  	{
c4df4559db8447 Johan Almbladh     2021-09-14  11150  		"JMP_JGE_K: imm = 0 -> always taken",
c4df4559db8447 Johan Almbladh     2021-09-14  11151  		.u.insns_int = {
c4df4559db8447 Johan Almbladh     2021-09-14  11152  			BPF_ALU64_IMM(BPF_MOV, R0, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11153  			BPF_JMP_IMM(BPF_JGE, R1, 0, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11154  			BPF_ALU64_IMM(BPF_MOV, R0, 0),
c4df4559db8447 Johan Almbladh     2021-09-14  11155  			BPF_EXIT_INSN(),
c4df4559db8447 Johan Almbladh     2021-09-14  11156  		},
c4df4559db8447 Johan Almbladh     2021-09-14  11157  		INTERNAL | FLAG_NO_DATA,
c4df4559db8447 Johan Almbladh     2021-09-14  11158  		{ },
c4df4559db8447 Johan Almbladh     2021-09-14  11159  		{ { 0, 1 } },
c4df4559db8447 Johan Almbladh     2021-09-14  11160  	},
c4df4559db8447 Johan Almbladh     2021-09-14  11161  	{
c4df4559db8447 Johan Almbladh     2021-09-14  11162  		"JMP_JGT_K: imm = 0xffffffff -> never taken",
c4df4559db8447 Johan Almbladh     2021-09-14  11163  		.u.insns_int = {
c4df4559db8447 Johan Almbladh     2021-09-14  11164  			BPF_ALU64_IMM(BPF_MOV, R0, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11165  			BPF_JMP_IMM(BPF_JGT, R1, U32_MAX, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11166  			BPF_ALU64_IMM(BPF_MOV, R0, 0),
c4df4559db8447 Johan Almbladh     2021-09-14  11167  			BPF_EXIT_INSN(),
c4df4559db8447 Johan Almbladh     2021-09-14  11168  		},
c4df4559db8447 Johan Almbladh     2021-09-14  11169  		INTERNAL | FLAG_NO_DATA,
c4df4559db8447 Johan Almbladh     2021-09-14  11170  		{ },
c4df4559db8447 Johan Almbladh     2021-09-14  11171  		{ { 0, 0 } },
c4df4559db8447 Johan Almbladh     2021-09-14  11172  	},
c4df4559db8447 Johan Almbladh     2021-09-14  11173  	{
c4df4559db8447 Johan Almbladh     2021-09-14  11174  		"JMP_JLE_K: imm = 0xffffffff -> always taken",
c4df4559db8447 Johan Almbladh     2021-09-14  11175  		.u.insns_int = {
c4df4559db8447 Johan Almbladh     2021-09-14  11176  			BPF_ALU64_IMM(BPF_MOV, R0, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11177  			BPF_JMP_IMM(BPF_JLE, R1, U32_MAX, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11178  			BPF_ALU64_IMM(BPF_MOV, R0, 0),
c4df4559db8447 Johan Almbladh     2021-09-14  11179  			BPF_EXIT_INSN(),
c4df4559db8447 Johan Almbladh     2021-09-14  11180  		},
c4df4559db8447 Johan Almbladh     2021-09-14  11181  		INTERNAL | FLAG_NO_DATA,
c4df4559db8447 Johan Almbladh     2021-09-14  11182  		{ },
c4df4559db8447 Johan Almbladh     2021-09-14  11183  		{ { 0, 1 } },
c4df4559db8447 Johan Almbladh     2021-09-14  11184  	},
c4df4559db8447 Johan Almbladh     2021-09-14  11185  	{
c4df4559db8447 Johan Almbladh     2021-09-14  11186  		"JMP32_JSGT_K: imm = 0x7fffffff -> never taken",
c4df4559db8447 Johan Almbladh     2021-09-14  11187  		.u.insns_int = {
c4df4559db8447 Johan Almbladh     2021-09-14  11188  			BPF_ALU64_IMM(BPF_MOV, R0, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11189  			BPF_JMP32_IMM(BPF_JSGT, R1, S32_MAX, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11190  			BPF_ALU64_IMM(BPF_MOV, R0, 0),
c4df4559db8447 Johan Almbladh     2021-09-14  11191  			BPF_EXIT_INSN(),
c4df4559db8447 Johan Almbladh     2021-09-14  11192  		},
c4df4559db8447 Johan Almbladh     2021-09-14  11193  		INTERNAL | FLAG_NO_DATA,
c4df4559db8447 Johan Almbladh     2021-09-14  11194  		{ },
c4df4559db8447 Johan Almbladh     2021-09-14  11195  		{ { 0, 0 } },
c4df4559db8447 Johan Almbladh     2021-09-14  11196  	},
c4df4559db8447 Johan Almbladh     2021-09-14  11197  	{
c4df4559db8447 Johan Almbladh     2021-09-14  11198  		"JMP32_JSGE_K: imm = -0x80000000 -> always taken",
c4df4559db8447 Johan Almbladh     2021-09-14  11199  		.u.insns_int = {
c4df4559db8447 Johan Almbladh     2021-09-14  11200  			BPF_ALU64_IMM(BPF_MOV, R0, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11201  			BPF_JMP32_IMM(BPF_JSGE, R1, S32_MIN, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11202  			BPF_ALU64_IMM(BPF_MOV, R0, 0),
c4df4559db8447 Johan Almbladh     2021-09-14  11203  			BPF_EXIT_INSN(),
c4df4559db8447 Johan Almbladh     2021-09-14  11204  		},
c4df4559db8447 Johan Almbladh     2021-09-14  11205  		INTERNAL | FLAG_NO_DATA,
c4df4559db8447 Johan Almbladh     2021-09-14  11206  		{ },
c4df4559db8447 Johan Almbladh     2021-09-14  11207  		{ { 0, 1 } },
c4df4559db8447 Johan Almbladh     2021-09-14  11208  	},
c4df4559db8447 Johan Almbladh     2021-09-14  11209  	{
c4df4559db8447 Johan Almbladh     2021-09-14  11210  		"JMP32_JSLT_K: imm = -0x80000000 -> never taken",
c4df4559db8447 Johan Almbladh     2021-09-14  11211  		.u.insns_int = {
c4df4559db8447 Johan Almbladh     2021-09-14  11212  			BPF_ALU64_IMM(BPF_MOV, R0, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11213  			BPF_JMP32_IMM(BPF_JSLT, R1, S32_MIN, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11214  			BPF_ALU64_IMM(BPF_MOV, R0, 0),
c4df4559db8447 Johan Almbladh     2021-09-14  11215  			BPF_EXIT_INSN(),
c4df4559db8447 Johan Almbladh     2021-09-14  11216  		},
c4df4559db8447 Johan Almbladh     2021-09-14  11217  		INTERNAL | FLAG_NO_DATA,
c4df4559db8447 Johan Almbladh     2021-09-14  11218  		{ },
c4df4559db8447 Johan Almbladh     2021-09-14  11219  		{ { 0, 0 } },
c4df4559db8447 Johan Almbladh     2021-09-14  11220  	},
c4df4559db8447 Johan Almbladh     2021-09-14  11221  	{
c4df4559db8447 Johan Almbladh     2021-09-14  11222  		"JMP32_JSLE_K: imm = 0x7fffffff -> always taken",
c4df4559db8447 Johan Almbladh     2021-09-14  11223  		.u.insns_int = {
c4df4559db8447 Johan Almbladh     2021-09-14  11224  			BPF_ALU64_IMM(BPF_MOV, R0, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11225  			BPF_JMP32_IMM(BPF_JSLE, R1, S32_MAX, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11226  			BPF_ALU64_IMM(BPF_MOV, R0, 0),
c4df4559db8447 Johan Almbladh     2021-09-14  11227  			BPF_EXIT_INSN(),
c4df4559db8447 Johan Almbladh     2021-09-14  11228  		},
c4df4559db8447 Johan Almbladh     2021-09-14  11229  		INTERNAL | FLAG_NO_DATA,
c4df4559db8447 Johan Almbladh     2021-09-14  11230  		{ },
c4df4559db8447 Johan Almbladh     2021-09-14  11231  		{ { 0, 1 } },
c4df4559db8447 Johan Almbladh     2021-09-14  11232  	},
c4df4559db8447 Johan Almbladh     2021-09-14  11233  	{
c4df4559db8447 Johan Almbladh     2021-09-14  11234  		"JMP_JEQ_X: dst = src -> always taken",
c4df4559db8447 Johan Almbladh     2021-09-14  11235  		.u.insns_int = {
c4df4559db8447 Johan Almbladh     2021-09-14  11236  			BPF_ALU64_IMM(BPF_MOV, R0, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11237  			BPF_JMP_REG(BPF_JEQ, R1, R1, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11238  			BPF_ALU64_IMM(BPF_MOV, R0, 0),
c4df4559db8447 Johan Almbladh     2021-09-14  11239  			BPF_EXIT_INSN(),
c4df4559db8447 Johan Almbladh     2021-09-14  11240  		},
c4df4559db8447 Johan Almbladh     2021-09-14  11241  		INTERNAL | FLAG_NO_DATA,
c4df4559db8447 Johan Almbladh     2021-09-14  11242  		{ },
c4df4559db8447 Johan Almbladh     2021-09-14  11243  		{ { 0, 1 } },
c4df4559db8447 Johan Almbladh     2021-09-14  11244  	},
c4df4559db8447 Johan Almbladh     2021-09-14  11245  	{
c4df4559db8447 Johan Almbladh     2021-09-14  11246  		"JMP_JGE_X: dst = src -> always taken",
c4df4559db8447 Johan Almbladh     2021-09-14  11247  		.u.insns_int = {
c4df4559db8447 Johan Almbladh     2021-09-14  11248  			BPF_ALU64_IMM(BPF_MOV, R0, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11249  			BPF_JMP_REG(BPF_JGE, R1, R1, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11250  			BPF_ALU64_IMM(BPF_MOV, R0, 0),
c4df4559db8447 Johan Almbladh     2021-09-14  11251  			BPF_EXIT_INSN(),
c4df4559db8447 Johan Almbladh     2021-09-14  11252  		},
c4df4559db8447 Johan Almbladh     2021-09-14  11253  		INTERNAL | FLAG_NO_DATA,
c4df4559db8447 Johan Almbladh     2021-09-14  11254  		{ },
c4df4559db8447 Johan Almbladh     2021-09-14  11255  		{ { 0, 1 } },
c4df4559db8447 Johan Almbladh     2021-09-14  11256  	},
c4df4559db8447 Johan Almbladh     2021-09-14  11257  	{
c4df4559db8447 Johan Almbladh     2021-09-14  11258  		"JMP_JLE_X: dst = src -> always taken",
c4df4559db8447 Johan Almbladh     2021-09-14  11259  		.u.insns_int = {
c4df4559db8447 Johan Almbladh     2021-09-14  11260  			BPF_ALU64_IMM(BPF_MOV, R0, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11261  			BPF_JMP_REG(BPF_JLE, R1, R1, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11262  			BPF_ALU64_IMM(BPF_MOV, R0, 0),
c4df4559db8447 Johan Almbladh     2021-09-14  11263  			BPF_EXIT_INSN(),
c4df4559db8447 Johan Almbladh     2021-09-14  11264  		},
c4df4559db8447 Johan Almbladh     2021-09-14  11265  		INTERNAL | FLAG_NO_DATA,
c4df4559db8447 Johan Almbladh     2021-09-14  11266  		{ },
c4df4559db8447 Johan Almbladh     2021-09-14  11267  		{ { 0, 1 } },
c4df4559db8447 Johan Almbladh     2021-09-14  11268  	},
c4df4559db8447 Johan Almbladh     2021-09-14  11269  	{
c4df4559db8447 Johan Almbladh     2021-09-14  11270  		"JMP_JSGE_X: dst = src -> always taken",
c4df4559db8447 Johan Almbladh     2021-09-14  11271  		.u.insns_int = {
c4df4559db8447 Johan Almbladh     2021-09-14  11272  			BPF_ALU64_IMM(BPF_MOV, R0, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11273  			BPF_JMP_REG(BPF_JSGE, R1, R1, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11274  			BPF_ALU64_IMM(BPF_MOV, R0, 0),
c4df4559db8447 Johan Almbladh     2021-09-14  11275  			BPF_EXIT_INSN(),
c4df4559db8447 Johan Almbladh     2021-09-14  11276  		},
c4df4559db8447 Johan Almbladh     2021-09-14  11277  		INTERNAL | FLAG_NO_DATA,
c4df4559db8447 Johan Almbladh     2021-09-14  11278  		{ },
c4df4559db8447 Johan Almbladh     2021-09-14  11279  		{ { 0, 1 } },
c4df4559db8447 Johan Almbladh     2021-09-14  11280  	},
c4df4559db8447 Johan Almbladh     2021-09-14  11281  	{
c4df4559db8447 Johan Almbladh     2021-09-14  11282  		"JMP_JSLE_X: dst = src -> always taken",
c4df4559db8447 Johan Almbladh     2021-09-14  11283  		.u.insns_int = {
c4df4559db8447 Johan Almbladh     2021-09-14  11284  			BPF_ALU64_IMM(BPF_MOV, R0, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11285  			BPF_JMP_REG(BPF_JSLE, R1, R1, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11286  			BPF_ALU64_IMM(BPF_MOV, R0, 0),
c4df4559db8447 Johan Almbladh     2021-09-14  11287  			BPF_EXIT_INSN(),
c4df4559db8447 Johan Almbladh     2021-09-14  11288  		},
c4df4559db8447 Johan Almbladh     2021-09-14  11289  		INTERNAL | FLAG_NO_DATA,
c4df4559db8447 Johan Almbladh     2021-09-14  11290  		{ },
c4df4559db8447 Johan Almbladh     2021-09-14  11291  		{ { 0, 1 } },
c4df4559db8447 Johan Almbladh     2021-09-14  11292  	},
c4df4559db8447 Johan Almbladh     2021-09-14  11293  	{
c4df4559db8447 Johan Almbladh     2021-09-14  11294  		"JMP_JNE_X: dst = src -> never taken",
c4df4559db8447 Johan Almbladh     2021-09-14  11295  		.u.insns_int = {
c4df4559db8447 Johan Almbladh     2021-09-14  11296  			BPF_ALU64_IMM(BPF_MOV, R0, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11297  			BPF_JMP_REG(BPF_JNE, R1, R1, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11298  			BPF_ALU64_IMM(BPF_MOV, R0, 0),
c4df4559db8447 Johan Almbladh     2021-09-14  11299  			BPF_EXIT_INSN(),
c4df4559db8447 Johan Almbladh     2021-09-14  11300  		},
c4df4559db8447 Johan Almbladh     2021-09-14  11301  		INTERNAL | FLAG_NO_DATA,
c4df4559db8447 Johan Almbladh     2021-09-14  11302  		{ },
c4df4559db8447 Johan Almbladh     2021-09-14  11303  		{ { 0, 0 } },
c4df4559db8447 Johan Almbladh     2021-09-14  11304  	},
c4df4559db8447 Johan Almbladh     2021-09-14  11305  	{
c4df4559db8447 Johan Almbladh     2021-09-14  11306  		"JMP_JGT_X: dst = src -> never taken",
c4df4559db8447 Johan Almbladh     2021-09-14  11307  		.u.insns_int = {
c4df4559db8447 Johan Almbladh     2021-09-14  11308  			BPF_ALU64_IMM(BPF_MOV, R0, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11309  			BPF_JMP_REG(BPF_JGT, R1, R1, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11310  			BPF_ALU64_IMM(BPF_MOV, R0, 0),
c4df4559db8447 Johan Almbladh     2021-09-14  11311  			BPF_EXIT_INSN(),
c4df4559db8447 Johan Almbladh     2021-09-14  11312  		},
c4df4559db8447 Johan Almbladh     2021-09-14  11313  		INTERNAL | FLAG_NO_DATA,
c4df4559db8447 Johan Almbladh     2021-09-14  11314  		{ },
c4df4559db8447 Johan Almbladh     2021-09-14  11315  		{ { 0, 0 } },
c4df4559db8447 Johan Almbladh     2021-09-14  11316  	},
c4df4559db8447 Johan Almbladh     2021-09-14  11317  	{
c4df4559db8447 Johan Almbladh     2021-09-14  11318  		"JMP_JLT_X: dst = src -> never taken",
c4df4559db8447 Johan Almbladh     2021-09-14  11319  		.u.insns_int = {
c4df4559db8447 Johan Almbladh     2021-09-14  11320  			BPF_ALU64_IMM(BPF_MOV, R0, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11321  			BPF_JMP_REG(BPF_JLT, R1, R1, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11322  			BPF_ALU64_IMM(BPF_MOV, R0, 0),
c4df4559db8447 Johan Almbladh     2021-09-14  11323  			BPF_EXIT_INSN(),
c4df4559db8447 Johan Almbladh     2021-09-14  11324  		},
c4df4559db8447 Johan Almbladh     2021-09-14  11325  		INTERNAL | FLAG_NO_DATA,
c4df4559db8447 Johan Almbladh     2021-09-14  11326  		{ },
c4df4559db8447 Johan Almbladh     2021-09-14  11327  		{ { 0, 0 } },
c4df4559db8447 Johan Almbladh     2021-09-14  11328  	},
c4df4559db8447 Johan Almbladh     2021-09-14  11329  	{
c4df4559db8447 Johan Almbladh     2021-09-14  11330  		"JMP_JSGT_X: dst = src -> never taken",
c4df4559db8447 Johan Almbladh     2021-09-14  11331  		.u.insns_int = {
c4df4559db8447 Johan Almbladh     2021-09-14  11332  			BPF_ALU64_IMM(BPF_MOV, R0, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11333  			BPF_JMP_REG(BPF_JSGT, R1, R1, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11334  			BPF_ALU64_IMM(BPF_MOV, R0, 0),
c4df4559db8447 Johan Almbladh     2021-09-14  11335  			BPF_EXIT_INSN(),
c4df4559db8447 Johan Almbladh     2021-09-14  11336  		},
c4df4559db8447 Johan Almbladh     2021-09-14  11337  		INTERNAL | FLAG_NO_DATA,
c4df4559db8447 Johan Almbladh     2021-09-14  11338  		{ },
c4df4559db8447 Johan Almbladh     2021-09-14  11339  		{ { 0, 0 } },
c4df4559db8447 Johan Almbladh     2021-09-14  11340  	},
c4df4559db8447 Johan Almbladh     2021-09-14  11341  	{
c4df4559db8447 Johan Almbladh     2021-09-14  11342  		"JMP_JSLT_X: dst = src -> never taken",
c4df4559db8447 Johan Almbladh     2021-09-14  11343  		.u.insns_int = {
c4df4559db8447 Johan Almbladh     2021-09-14  11344  			BPF_ALU64_IMM(BPF_MOV, R0, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11345  			BPF_JMP_REG(BPF_JSLT, R1, R1, 1),
c4df4559db8447 Johan Almbladh     2021-09-14  11346  			BPF_ALU64_IMM(BPF_MOV, R0, 0),
c4df4559db8447 Johan Almbladh     2021-09-14  11347  			BPF_EXIT_INSN(),
c4df4559db8447 Johan Almbladh     2021-09-14  11348  		},
c4df4559db8447 Johan Almbladh     2021-09-14  11349  		INTERNAL | FLAG_NO_DATA,
c4df4559db8447 Johan Almbladh     2021-09-14  11350  		{ },
c4df4559db8447 Johan Almbladh     2021-09-14  11351  		{ { 0, 0 } },
c4df4559db8447 Johan Almbladh     2021-09-14  11352  	},
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11353  	/* Short relative jumps */
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11354  	{
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11355  		"Short relative jump: offset=0",
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11356  		.u.insns_int = {
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11357  			BPF_ALU64_IMM(BPF_MOV, R0, 0),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11358  			BPF_JMP_IMM(BPF_JEQ, R0, 0, 0),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11359  			BPF_EXIT_INSN(),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11360  			BPF_ALU32_IMM(BPF_MOV, R0, -1),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11361  		},
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11362  		INTERNAL | FLAG_NO_DATA | FLAG_VERIFIER_ZEXT,
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11363  		{ },
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11364  		{ { 0, 0 } },
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11365  	},
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11366  	{
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11367  		"Short relative jump: offset=1",
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11368  		.u.insns_int = {
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11369  			BPF_ALU64_IMM(BPF_MOV, R0, 0),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11370  			BPF_JMP_IMM(BPF_JEQ, R0, 0, 1),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11371  			BPF_ALU32_IMM(BPF_ADD, R0, 1),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11372  			BPF_EXIT_INSN(),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11373  			BPF_ALU32_IMM(BPF_MOV, R0, -1),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11374  		},
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11375  		INTERNAL | FLAG_NO_DATA | FLAG_VERIFIER_ZEXT,
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11376  		{ },
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11377  		{ { 0, 0 } },
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11378  	},
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11379  	{
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11380  		"Short relative jump: offset=2",
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11381  		.u.insns_int = {
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11382  			BPF_ALU64_IMM(BPF_MOV, R0, 0),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11383  			BPF_JMP_IMM(BPF_JEQ, R0, 0, 2),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11384  			BPF_ALU32_IMM(BPF_ADD, R0, 1),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11385  			BPF_ALU32_IMM(BPF_ADD, R0, 1),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11386  			BPF_EXIT_INSN(),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11387  			BPF_ALU32_IMM(BPF_MOV, R0, -1),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11388  		},
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11389  		INTERNAL | FLAG_NO_DATA | FLAG_VERIFIER_ZEXT,
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11390  		{ },
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11391  		{ { 0, 0 } },
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11392  	},
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11393  	{
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11394  		"Short relative jump: offset=3",
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11395  		.u.insns_int = {
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11396  			BPF_ALU64_IMM(BPF_MOV, R0, 0),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11397  			BPF_JMP_IMM(BPF_JEQ, R0, 0, 3),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11398  			BPF_ALU32_IMM(BPF_ADD, R0, 1),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11399  			BPF_ALU32_IMM(BPF_ADD, R0, 1),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11400  			BPF_ALU32_IMM(BPF_ADD, R0, 1),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11401  			BPF_EXIT_INSN(),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11402  			BPF_ALU32_IMM(BPF_MOV, R0, -1),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11403  		},
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11404  		INTERNAL | FLAG_NO_DATA | FLAG_VERIFIER_ZEXT,
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11405  		{ },
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11406  		{ { 0, 0 } },
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11407  	},
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11408  	{
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11409  		"Short relative jump: offset=4",
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11410  		.u.insns_int = {
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11411  			BPF_ALU64_IMM(BPF_MOV, R0, 0),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11412  			BPF_JMP_IMM(BPF_JEQ, R0, 0, 4),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11413  			BPF_ALU32_IMM(BPF_ADD, R0, 1),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11414  			BPF_ALU32_IMM(BPF_ADD, R0, 1),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11415  			BPF_ALU32_IMM(BPF_ADD, R0, 1),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11416  			BPF_ALU32_IMM(BPF_ADD, R0, 1),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11417  			BPF_EXIT_INSN(),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11418  			BPF_ALU32_IMM(BPF_MOV, R0, -1),
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11419  		},
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11420  		INTERNAL | FLAG_NO_DATA | FLAG_VERIFIER_ZEXT,
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11421  		{ },
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11422  		{ { 0, 0 } },
d4ff9ee2dc0bbb Johan Almbladh     2021-09-14  11423  	},
f1517eb790f97c Johan Almbladh     2021-09-14  11424  	/* Conditional branch conversions */
f1517eb790f97c Johan Almbladh     2021-09-14  11425  	{
f1517eb790f97c Johan Almbladh     2021-09-14  11426  		"Long conditional jump: taken at runtime",
f1517eb790f97c Johan Almbladh     2021-09-14  11427  		{ },
f1517eb790f97c Johan Almbladh     2021-09-14  11428  		INTERNAL | FLAG_NO_DATA,
f1517eb790f97c Johan Almbladh     2021-09-14  11429  		{ },
f1517eb790f97c Johan Almbladh     2021-09-14  11430  		{ { 0, 1 } },
f1517eb790f97c Johan Almbladh     2021-09-14  11431  		.fill_helper = bpf_fill_max_jmp_taken,
f1517eb790f97c Johan Almbladh     2021-09-14  11432  	},
f1517eb790f97c Johan Almbladh     2021-09-14  11433  	{
f1517eb790f97c Johan Almbladh     2021-09-14  11434  		"Long conditional jump: not taken at runtime",
f1517eb790f97c Johan Almbladh     2021-09-14  11435  		{ },
f1517eb790f97c Johan Almbladh     2021-09-14  11436  		INTERNAL | FLAG_NO_DATA,
f1517eb790f97c Johan Almbladh     2021-09-14  11437  		{ },
f1517eb790f97c Johan Almbladh     2021-09-14  11438  		{ { 0, 2 } },
f1517eb790f97c Johan Almbladh     2021-09-14  11439  		.fill_helper = bpf_fill_max_jmp_not_taken,
f1517eb790f97c Johan Almbladh     2021-09-14  11440  	},
f1517eb790f97c Johan Almbladh     2021-09-14  11441  	{
f1517eb790f97c Johan Almbladh     2021-09-14  11442  		"Long conditional jump: always taken, known at JIT time",
f1517eb790f97c Johan Almbladh     2021-09-14  11443  		{ },
f1517eb790f97c Johan Almbladh     2021-09-14  11444  		INTERNAL | FLAG_NO_DATA,
f1517eb790f97c Johan Almbladh     2021-09-14  11445  		{ },
f1517eb790f97c Johan Almbladh     2021-09-14  11446  		{ { 0, 1 } },
f1517eb790f97c Johan Almbladh     2021-09-14  11447  		.fill_helper = bpf_fill_max_jmp_always_taken,
f1517eb790f97c Johan Almbladh     2021-09-14  11448  	},
f1517eb790f97c Johan Almbladh     2021-09-14  11449  	{
f1517eb790f97c Johan Almbladh     2021-09-14  11450  		"Long conditional jump: never taken, known at JIT time",
f1517eb790f97c Johan Almbladh     2021-09-14  11451  		{ },
f1517eb790f97c Johan Almbladh     2021-09-14  11452  		INTERNAL | FLAG_NO_DATA,
f1517eb790f97c Johan Almbladh     2021-09-14  11453  		{ },
f1517eb790f97c Johan Almbladh     2021-09-14  11454  		{ { 0, 2 } },
f1517eb790f97c Johan Almbladh     2021-09-14  11455  		.fill_helper = bpf_fill_max_jmp_never_taken,
f1517eb790f97c Johan Almbladh     2021-09-14  11456  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11457  	/* Staggered jump sequences, immediate */
a7d2e752e52050 Johan Almbladh     2021-09-14  11458  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11459  		"Staggered jumps: JMP_JA",
a7d2e752e52050 Johan Almbladh     2021-09-14  11460  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11461  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11462  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11463  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11464  		.fill_helper = bpf_fill_staggered_ja,
a7d2e752e52050 Johan Almbladh     2021-09-14  11465  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11466  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11467  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11468  		"Staggered jumps: JMP_JEQ_K",
a7d2e752e52050 Johan Almbladh     2021-09-14  11469  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11470  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11471  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11472  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11473  		.fill_helper = bpf_fill_staggered_jeq_imm,
a7d2e752e52050 Johan Almbladh     2021-09-14  11474  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11475  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11476  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11477  		"Staggered jumps: JMP_JNE_K",
a7d2e752e52050 Johan Almbladh     2021-09-14  11478  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11479  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11480  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11481  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11482  		.fill_helper = bpf_fill_staggered_jne_imm,
a7d2e752e52050 Johan Almbladh     2021-09-14  11483  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11484  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11485  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11486  		"Staggered jumps: JMP_JSET_K",
a7d2e752e52050 Johan Almbladh     2021-09-14  11487  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11488  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11489  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11490  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11491  		.fill_helper = bpf_fill_staggered_jset_imm,
a7d2e752e52050 Johan Almbladh     2021-09-14  11492  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11493  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11494  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11495  		"Staggered jumps: JMP_JGT_K",
a7d2e752e52050 Johan Almbladh     2021-09-14  11496  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11497  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11498  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11499  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11500  		.fill_helper = bpf_fill_staggered_jgt_imm,
a7d2e752e52050 Johan Almbladh     2021-09-14  11501  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11502  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11503  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11504  		"Staggered jumps: JMP_JGE_K",
a7d2e752e52050 Johan Almbladh     2021-09-14  11505  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11506  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11507  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11508  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11509  		.fill_helper = bpf_fill_staggered_jge_imm,
a7d2e752e52050 Johan Almbladh     2021-09-14  11510  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11511  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11512  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11513  		"Staggered jumps: JMP_JLT_K",
a7d2e752e52050 Johan Almbladh     2021-09-14  11514  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11515  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11516  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11517  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11518  		.fill_helper = bpf_fill_staggered_jlt_imm,
a7d2e752e52050 Johan Almbladh     2021-09-14  11519  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11520  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11521  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11522  		"Staggered jumps: JMP_JLE_K",
a7d2e752e52050 Johan Almbladh     2021-09-14  11523  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11524  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11525  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11526  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11527  		.fill_helper = bpf_fill_staggered_jle_imm,
a7d2e752e52050 Johan Almbladh     2021-09-14  11528  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11529  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11530  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11531  		"Staggered jumps: JMP_JSGT_K",
a7d2e752e52050 Johan Almbladh     2021-09-14  11532  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11533  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11534  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11535  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11536  		.fill_helper = bpf_fill_staggered_jsgt_imm,
a7d2e752e52050 Johan Almbladh     2021-09-14  11537  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11538  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11539  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11540  		"Staggered jumps: JMP_JSGE_K",
a7d2e752e52050 Johan Almbladh     2021-09-14  11541  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11542  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11543  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11544  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11545  		.fill_helper = bpf_fill_staggered_jsge_imm,
a7d2e752e52050 Johan Almbladh     2021-09-14  11546  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11547  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11548  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11549  		"Staggered jumps: JMP_JSLT_K",
a7d2e752e52050 Johan Almbladh     2021-09-14  11550  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11551  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11552  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11553  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11554  		.fill_helper = bpf_fill_staggered_jslt_imm,
a7d2e752e52050 Johan Almbladh     2021-09-14  11555  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11556  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11557  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11558  		"Staggered jumps: JMP_JSLE_K",
a7d2e752e52050 Johan Almbladh     2021-09-14  11559  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11560  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11561  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11562  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11563  		.fill_helper = bpf_fill_staggered_jsle_imm,
a7d2e752e52050 Johan Almbladh     2021-09-14  11564  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11565  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11566  	/* Staggered jump sequences, register */
a7d2e752e52050 Johan Almbladh     2021-09-14  11567  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11568  		"Staggered jumps: JMP_JEQ_X",
a7d2e752e52050 Johan Almbladh     2021-09-14  11569  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11570  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11571  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11572  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11573  		.fill_helper = bpf_fill_staggered_jeq_reg,
a7d2e752e52050 Johan Almbladh     2021-09-14  11574  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11575  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11576  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11577  		"Staggered jumps: JMP_JNE_X",
a7d2e752e52050 Johan Almbladh     2021-09-14  11578  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11579  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11580  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11581  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11582  		.fill_helper = bpf_fill_staggered_jne_reg,
a7d2e752e52050 Johan Almbladh     2021-09-14  11583  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11584  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11585  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11586  		"Staggered jumps: JMP_JSET_X",
a7d2e752e52050 Johan Almbladh     2021-09-14  11587  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11588  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11589  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11590  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11591  		.fill_helper = bpf_fill_staggered_jset_reg,
a7d2e752e52050 Johan Almbladh     2021-09-14  11592  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11593  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11594  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11595  		"Staggered jumps: JMP_JGT_X",
a7d2e752e52050 Johan Almbladh     2021-09-14  11596  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11597  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11598  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11599  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11600  		.fill_helper = bpf_fill_staggered_jgt_reg,
a7d2e752e52050 Johan Almbladh     2021-09-14  11601  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11602  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11603  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11604  		"Staggered jumps: JMP_JGE_X",
a7d2e752e52050 Johan Almbladh     2021-09-14  11605  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11606  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11607  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11608  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11609  		.fill_helper = bpf_fill_staggered_jge_reg,
a7d2e752e52050 Johan Almbladh     2021-09-14  11610  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11611  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11612  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11613  		"Staggered jumps: JMP_JLT_X",
a7d2e752e52050 Johan Almbladh     2021-09-14  11614  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11615  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11616  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11617  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11618  		.fill_helper = bpf_fill_staggered_jlt_reg,
a7d2e752e52050 Johan Almbladh     2021-09-14  11619  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11620  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11621  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11622  		"Staggered jumps: JMP_JLE_X",
a7d2e752e52050 Johan Almbladh     2021-09-14  11623  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11624  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11625  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11626  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11627  		.fill_helper = bpf_fill_staggered_jle_reg,
a7d2e752e52050 Johan Almbladh     2021-09-14  11628  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11629  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11630  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11631  		"Staggered jumps: JMP_JSGT_X",
a7d2e752e52050 Johan Almbladh     2021-09-14  11632  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11633  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11634  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11635  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11636  		.fill_helper = bpf_fill_staggered_jsgt_reg,
a7d2e752e52050 Johan Almbladh     2021-09-14  11637  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11638  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11639  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11640  		"Staggered jumps: JMP_JSGE_X",
a7d2e752e52050 Johan Almbladh     2021-09-14  11641  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11642  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11643  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11644  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11645  		.fill_helper = bpf_fill_staggered_jsge_reg,
a7d2e752e52050 Johan Almbladh     2021-09-14  11646  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11647  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11648  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11649  		"Staggered jumps: JMP_JSLT_X",
a7d2e752e52050 Johan Almbladh     2021-09-14  11650  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11651  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11652  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11653  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11654  		.fill_helper = bpf_fill_staggered_jslt_reg,
a7d2e752e52050 Johan Almbladh     2021-09-14  11655  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11656  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11657  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11658  		"Staggered jumps: JMP_JSLE_X",
a7d2e752e52050 Johan Almbladh     2021-09-14  11659  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11660  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11661  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11662  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11663  		.fill_helper = bpf_fill_staggered_jsle_reg,
a7d2e752e52050 Johan Almbladh     2021-09-14  11664  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11665  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11666  	/* Staggered jump sequences, JMP32 immediate */
a7d2e752e52050 Johan Almbladh     2021-09-14  11667  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11668  		"Staggered jumps: JMP32_JEQ_K",
a7d2e752e52050 Johan Almbladh     2021-09-14  11669  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11670  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11671  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11672  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11673  		.fill_helper = bpf_fill_staggered_jeq32_imm,
a7d2e752e52050 Johan Almbladh     2021-09-14  11674  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11675  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11676  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11677  		"Staggered jumps: JMP32_JNE_K",
a7d2e752e52050 Johan Almbladh     2021-09-14  11678  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11679  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11680  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11681  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11682  		.fill_helper = bpf_fill_staggered_jne32_imm,
a7d2e752e52050 Johan Almbladh     2021-09-14  11683  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11684  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11685  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11686  		"Staggered jumps: JMP32_JSET_K",
a7d2e752e52050 Johan Almbladh     2021-09-14  11687  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11688  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11689  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11690  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11691  		.fill_helper = bpf_fill_staggered_jset32_imm,
a7d2e752e52050 Johan Almbladh     2021-09-14  11692  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11693  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11694  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11695  		"Staggered jumps: JMP32_JGT_K",
a7d2e752e52050 Johan Almbladh     2021-09-14  11696  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11697  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11698  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11699  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11700  		.fill_helper = bpf_fill_staggered_jgt32_imm,
a7d2e752e52050 Johan Almbladh     2021-09-14  11701  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11702  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11703  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11704  		"Staggered jumps: JMP32_JGE_K",
a7d2e752e52050 Johan Almbladh     2021-09-14  11705  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11706  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11707  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11708  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11709  		.fill_helper = bpf_fill_staggered_jge32_imm,
a7d2e752e52050 Johan Almbladh     2021-09-14  11710  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11711  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11712  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11713  		"Staggered jumps: JMP32_JLT_K",
a7d2e752e52050 Johan Almbladh     2021-09-14  11714  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11715  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11716  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11717  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11718  		.fill_helper = bpf_fill_staggered_jlt32_imm,
a7d2e752e52050 Johan Almbladh     2021-09-14  11719  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11720  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11721  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11722  		"Staggered jumps: JMP32_JLE_K",
a7d2e752e52050 Johan Almbladh     2021-09-14  11723  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11724  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11725  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11726  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11727  		.fill_helper = bpf_fill_staggered_jle32_imm,
a7d2e752e52050 Johan Almbladh     2021-09-14  11728  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11729  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11730  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11731  		"Staggered jumps: JMP32_JSGT_K",
a7d2e752e52050 Johan Almbladh     2021-09-14  11732  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11733  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11734  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11735  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11736  		.fill_helper = bpf_fill_staggered_jsgt32_imm,
a7d2e752e52050 Johan Almbladh     2021-09-14  11737  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11738  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11739  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11740  		"Staggered jumps: JMP32_JSGE_K",
a7d2e752e52050 Johan Almbladh     2021-09-14  11741  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11742  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11743  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11744  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11745  		.fill_helper = bpf_fill_staggered_jsge32_imm,
a7d2e752e52050 Johan Almbladh     2021-09-14  11746  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11747  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11748  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11749  		"Staggered jumps: JMP32_JSLT_K",
a7d2e752e52050 Johan Almbladh     2021-09-14  11750  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11751  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11752  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11753  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11754  		.fill_helper = bpf_fill_staggered_jslt32_imm,
a7d2e752e52050 Johan Almbladh     2021-09-14  11755  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11756  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11757  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11758  		"Staggered jumps: JMP32_JSLE_K",
a7d2e752e52050 Johan Almbladh     2021-09-14  11759  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11760  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11761  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11762  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11763  		.fill_helper = bpf_fill_staggered_jsle32_imm,
a7d2e752e52050 Johan Almbladh     2021-09-14  11764  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11765  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11766  	/* Staggered jump sequences, JMP32 register */
a7d2e752e52050 Johan Almbladh     2021-09-14  11767  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11768  		"Staggered jumps: JMP32_JEQ_X",
a7d2e752e52050 Johan Almbladh     2021-09-14  11769  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11770  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11771  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11772  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11773  		.fill_helper = bpf_fill_staggered_jeq32_reg,
a7d2e752e52050 Johan Almbladh     2021-09-14  11774  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11775  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11776  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11777  		"Staggered jumps: JMP32_JNE_X",
a7d2e752e52050 Johan Almbladh     2021-09-14  11778  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11779  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11780  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11781  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11782  		.fill_helper = bpf_fill_staggered_jne32_reg,
a7d2e752e52050 Johan Almbladh     2021-09-14  11783  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11784  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11785  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11786  		"Staggered jumps: JMP32_JSET_X",
a7d2e752e52050 Johan Almbladh     2021-09-14  11787  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11788  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11789  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11790  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11791  		.fill_helper = bpf_fill_staggered_jset32_reg,
a7d2e752e52050 Johan Almbladh     2021-09-14  11792  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11793  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11794  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11795  		"Staggered jumps: JMP32_JGT_X",
a7d2e752e52050 Johan Almbladh     2021-09-14  11796  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11797  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11798  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11799  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11800  		.fill_helper = bpf_fill_staggered_jgt32_reg,
a7d2e752e52050 Johan Almbladh     2021-09-14  11801  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11802  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11803  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11804  		"Staggered jumps: JMP32_JGE_X",
a7d2e752e52050 Johan Almbladh     2021-09-14  11805  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11806  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11807  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11808  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11809  		.fill_helper = bpf_fill_staggered_jge32_reg,
a7d2e752e52050 Johan Almbladh     2021-09-14  11810  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11811  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11812  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11813  		"Staggered jumps: JMP32_JLT_X",
a7d2e752e52050 Johan Almbladh     2021-09-14  11814  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11815  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11816  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11817  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11818  		.fill_helper = bpf_fill_staggered_jlt32_reg,
a7d2e752e52050 Johan Almbladh     2021-09-14  11819  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11820  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11821  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11822  		"Staggered jumps: JMP32_JLE_X",
a7d2e752e52050 Johan Almbladh     2021-09-14  11823  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11824  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11825  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11826  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11827  		.fill_helper = bpf_fill_staggered_jle32_reg,
a7d2e752e52050 Johan Almbladh     2021-09-14  11828  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11829  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11830  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11831  		"Staggered jumps: JMP32_JSGT_X",
a7d2e752e52050 Johan Almbladh     2021-09-14  11832  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11833  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11834  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11835  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11836  		.fill_helper = bpf_fill_staggered_jsgt32_reg,
a7d2e752e52050 Johan Almbladh     2021-09-14  11837  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11838  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11839  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11840  		"Staggered jumps: JMP32_JSGE_X",
a7d2e752e52050 Johan Almbladh     2021-09-14  11841  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11842  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11843  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11844  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11845  		.fill_helper = bpf_fill_staggered_jsge32_reg,
a7d2e752e52050 Johan Almbladh     2021-09-14  11846  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11847  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11848  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11849  		"Staggered jumps: JMP32_JSLT_X",
a7d2e752e52050 Johan Almbladh     2021-09-14  11850  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11851  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11852  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11853  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11854  		.fill_helper = bpf_fill_staggered_jslt32_reg,
a7d2e752e52050 Johan Almbladh     2021-09-14  11855  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11856  	},
a7d2e752e52050 Johan Almbladh     2021-09-14  11857  	{
a7d2e752e52050 Johan Almbladh     2021-09-14  11858  		"Staggered jumps: JMP32_JSLE_X",
a7d2e752e52050 Johan Almbladh     2021-09-14  11859  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11860  		INTERNAL | FLAG_NO_DATA,
a7d2e752e52050 Johan Almbladh     2021-09-14  11861  		{ },
a7d2e752e52050 Johan Almbladh     2021-09-14  11862  		{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
a7d2e752e52050 Johan Almbladh     2021-09-14  11863  		.fill_helper = bpf_fill_staggered_jsle32_reg,
a7d2e752e52050 Johan Almbladh     2021-09-14  11864  		.nr_testruns = NR_STAGGERED_JMP_RUNS,
a7d2e752e52050 Johan Almbladh     2021-09-14  11865  	},
64a8946b447e41 Alexei Starovoitov 2014-05-08  11866  };
64a8946b447e41 Alexei Starovoitov 2014-05-08  11867  

:::::: The code at line 7480 was first introduced by commit
:::::: e4517b3637c648b215307e3343900ec675fde607 bpf, tests: Add tests for atomic operations

:::::: TO: Johan Almbladh <johan.almbladh@anyfinetworks.com>
:::::: CC: Daniel Borkmann <daniel@iogearbox.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
