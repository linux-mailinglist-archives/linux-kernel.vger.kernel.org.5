Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039A180272A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 21:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbjLCT4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbjLCT4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:56:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41300B4
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 11:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701633373; x=1733169373;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bHA8yBS7ime9SbKHeTyWP2oyyvBjDaC5idTRV1FvKJw=;
  b=VDe8TekBaYY3+0noUcksVNaE1s6Xj7cYdlTigLKg5Dvg2+/R0HUxewAl
   O7bXOqHk4xYG8AOQpa5PuWMbAdiHe/I4YBtzmPJFRbmRAzVwMo4S5vLe+
   ZWKFCEWdLG6MIvSBTcrDbGkqnEPBfR4T+i4Mpn3T2RBmQjDafCQerjcvy
   5T/1GieqIzWN9WJjKOkZPBKcp6HIC43wlDJtHbgVs6SwW+tQyW47tzFo2
   tO6D2IdZ/Uxm3t2Sabou3e1P94tXk+ZNKI37CjYYiI8DkTXnYg+bxuVYi
   QN92ELwds54Z0pD73ahPXfW0ERfTNWcNnxQHz0tlZ4owXAv90Vxl2f9fB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="373090513"
X-IronPort-AV: E=Sophos;i="6.04,248,1695711600"; 
   d="scan'208";a="373090513"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 11:56:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="746605021"
X-IronPort-AV: E=Sophos;i="6.04,248,1695711600"; 
   d="scan'208";a="746605021"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 03 Dec 2023 11:56:09 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9sZS-00072S-38;
        Sun, 03 Dec 2023 19:56:06 +0000
Date:   Mon, 4 Dec 2023 03:55:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: lib/test_bpf.c:8531:25: sparse: sparse: cast truncates bits from
 constant value (dead0000000000f0 becomes f0)
Message-ID: <202312040313.R5rF4D1f-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: daabb2b098e04753fa3d1b1feed13e5a61bef61c bpf/tests: add tests for cpuv4 instructions
date:   3 months ago
config: mips-randconfig-r123-20231130 (https://download.01.org/0day-ci/archive/20231204/202312040313.R5rF4D1f-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20231204/202312040313.R5rF4D1f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312040313.R5rF4D1f-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   lib/test_bpf.c:6929:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:6930:25: sparse: sparse: cast truncates bits from constant value (fedcba98795b3d1f becomes 795b3d1f)
   lib/test_bpf.c:7006:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7018:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7031:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7043:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7056:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7068:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7081:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7093:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7173:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7184:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7196:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7207:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7219:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7230:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7242:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7314:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7326:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7339:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7351:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7364:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7376:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7389:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7401:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7481:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7492:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7504:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7515:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7527:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7538:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7550:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7574:25: sparse: sparse: cast truncates bits from constant value (ff00ff0000000000 becomes 0)
   lib/test_bpf.c:7586:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7598:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7611:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7623:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7636:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7648:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7661:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7673:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7709:25: sparse: sparse: cast truncates bits from constant value (ff00ff0000000000 becomes 0)
   lib/test_bpf.c:7720:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7731:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7743:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7754:25: sparse: sparse: cast truncates bits from constant value (f123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7766:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7777:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7789:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7846:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7857:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7871:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7877:30: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7882:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7895:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:7906:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:7920:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:7926:30: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:7931:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:7944:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7955:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7969:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7975:30: sparse: sparse: cast truncates bits from constant value (efcdab8967452301 becomes 67452301)
   lib/test_bpf.c:7980:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7993:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:8004:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:8018:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:8024:30: sparse: sparse: cast truncates bits from constant value (1032547698badcfe becomes 98badcfe)
   lib/test_bpf.c:8029:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:8042:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:8053:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:8067:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:8078:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:8091:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:8102:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:8116:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:8127:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:8140:25: sparse: sparse: cast truncates bits from constant value (102030405060708 becomes 5060708)
   lib/test_bpf.c:8160:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:8180:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:8197:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:8213:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:8229:25: sparse: sparse: cast truncates bits from constant value (102030405060708 becomes 5060708)
   lib/test_bpf.c:8249:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:8269:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:8286:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:8302:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:8318:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:8334:25: sparse: sparse: cast truncates bits from constant value (102030405060708 becomes 5060708)
   lib/test_bpf.c:8354:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:8374:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:8391:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:8407:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:8423:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:8439:25: sparse: sparse: cast truncates bits from constant value (102030405060708 becomes 5060708)
   lib/test_bpf.c:8454:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:8469:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:8485:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:8500:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:8515:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
>> lib/test_bpf.c:8531:25: sparse: sparse: cast truncates bits from constant value (dead0000000000f0 becomes f0)
>> lib/test_bpf.c:8551:25: sparse: sparse: cast truncates bits from constant value (dead00000000f123 becomes f123)
   lib/test_bpf.c:8592:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e0f0 becomes c0d0e0f0)
   lib/test_bpf.c:8593:25: sparse: sparse: cast truncates bits from constant value (102030405060708 becomes 5060708)
   lib/test_bpf.c:8594:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e008 becomes c0d0e008)
   lib/test_bpf.c:8614:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e0f0 becomes c0d0e0f0)
   lib/test_bpf.c:8615:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:8616:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e088 becomes c0d0e088)
   lib/test_bpf.c:8636:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e0f0 becomes c0d0e0f0)
   lib/test_bpf.c:8637:25: sparse: sparse: cast truncates bits from constant value (102030405060708 becomes 5060708)
   lib/test_bpf.c:8638:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d00708 becomes c0d00708)
   lib/test_bpf.c:8658:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e0f0 becomes c0d0e0f0)
   lib/test_bpf.c:8659:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:8660:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d08788 becomes c0d08788)
   lib/test_bpf.c:8680:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e0f0 becomes c0d0e0f0)
   lib/test_bpf.c:8681:25: sparse: sparse: cast truncates bits from constant value (102030405060708 becomes 5060708)
   lib/test_bpf.c:8682:25: sparse: sparse: cast truncates bits from constant value (8090a0b005060708 becomes 5060708)
   lib/test_bpf.c:8702:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e0f0 becomes c0d0e0f0)
   lib/test_bpf.c:8703:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
   lib/test_bpf.c:8704:25: sparse: sparse: cast truncates bits from constant value (8090a0b085868788 becomes 85868788)
   lib/test_bpf.c:8858:25: sparse: sparse: cast truncates bits from constant value (ffff00000000ffff becomes ffff)
   lib/test_bpf.c:8904:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:8922:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:9037:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9038:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9039:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9040:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9042:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9043:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9044:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9045:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9057:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9058:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9059:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9060:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9062:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9063:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9064:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9065:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9077:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9078:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9079:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9080:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9082:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9083:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9084:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9085:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9097:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9098:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9099:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9100:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9102:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9103:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9104:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9105:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9117:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9118:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9119:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9120:9: sparse: sparse: cast truncates bits from constant value (baadf00d000000ab becomes ab)
   lib/test_bpf.c:9210:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:9211:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:9227:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:9228:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:9245:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:9246:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:9263:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:9264:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:9282:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:9283:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:9287:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:10504:25: sparse: sparse: cast truncates bits from constant value (eeeeeeeeeeeeeeee becomes eeeeeeee)
   lib/test_bpf.c:10533:25: sparse: sparse: cast truncates bits from constant value (eeeeeeeeeeeeeeee becomes eeeeeeee)
   lib/test_bpf.c:10548:25: sparse: sparse: cast truncates bits from constant value (eeeeeeeeeeeeeeee becomes eeeeeeee)
   lib/test_bpf.c:10577:25: sparse: sparse: cast truncates bits from constant value (eeeeeeeeeeeeeeee becomes eeeeeeee)
   lib/test_bpf.c:11903:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:12134:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:12134:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:12135:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:12135:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:12136:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:12136:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:12137:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:12137:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:12138:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:12138:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:12139:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:12139:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:12140:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:12140:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:12141:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:12141:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:12142:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:12142:9: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:12164:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:12165:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:12166:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:12167:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:12173:25: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:12209:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:12210:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:12211:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)
   lib/test_bpf.c:12212:9: sparse: sparse: cast truncates bits from constant value (123456789acbdef becomes 89acbdef)

vim +8531 lib/test_bpf.c

  3061	
  3062	
  3063	static struct bpf_test tests[] = {
  3064		{
  3065			"TAX",
  3066			.u.insns = {
  3067				BPF_STMT(BPF_LD | BPF_IMM, 1),
  3068				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3069				BPF_STMT(BPF_LD | BPF_IMM, 2),
  3070				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  3071				BPF_STMT(BPF_ALU | BPF_NEG, 0), /* A == -3 */
  3072				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3073				BPF_STMT(BPF_LD | BPF_LEN, 0),
  3074				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  3075				BPF_STMT(BPF_MISC | BPF_TAX, 0), /* X == len - 3 */
  3076				BPF_STMT(BPF_LD | BPF_B | BPF_IND, 1),
  3077				BPF_STMT(BPF_RET | BPF_A, 0)
  3078			},
  3079			CLASSIC,
  3080			{ 10, 20, 30, 40, 50 },
  3081			{ { 2, 10 }, { 3, 20 }, { 4, 30 } },
  3082		},
  3083		{
  3084			"TXA",
  3085			.u.insns = {
  3086				BPF_STMT(BPF_LDX | BPF_LEN, 0),
  3087				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  3088				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  3089				BPF_STMT(BPF_RET | BPF_A, 0) /* A == len * 2 */
  3090			},
  3091			CLASSIC,
  3092			{ 10, 20, 30, 40, 50 },
  3093			{ { 1, 2 }, { 3, 6 }, { 4, 8 } },
  3094		},
  3095		{
  3096			"ADD_SUB_MUL_K",
  3097			.u.insns = {
  3098				BPF_STMT(BPF_LD | BPF_IMM, 1),
  3099				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 2),
  3100				BPF_STMT(BPF_LDX | BPF_IMM, 3),
  3101				BPF_STMT(BPF_ALU | BPF_SUB | BPF_X, 0),
  3102				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 0xffffffff),
  3103				BPF_STMT(BPF_ALU | BPF_MUL | BPF_K, 3),
  3104				BPF_STMT(BPF_RET | BPF_A, 0)
  3105			},
  3106			CLASSIC | FLAG_NO_DATA,
  3107			{ },
  3108			{ { 0, 0xfffffffd } }
  3109		},
  3110		{
  3111			"DIV_MOD_KX",
  3112			.u.insns = {
  3113				BPF_STMT(BPF_LD | BPF_IMM, 8),
  3114				BPF_STMT(BPF_ALU | BPF_DIV | BPF_K, 2),
  3115				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3116				BPF_STMT(BPF_LD | BPF_IMM, 0xffffffff),
  3117				BPF_STMT(BPF_ALU | BPF_DIV | BPF_X, 0),
  3118				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3119				BPF_STMT(BPF_LD | BPF_IMM, 0xffffffff),
  3120				BPF_STMT(BPF_ALU | BPF_DIV | BPF_K, 0x70000000),
  3121				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3122				BPF_STMT(BPF_LD | BPF_IMM, 0xffffffff),
  3123				BPF_STMT(BPF_ALU | BPF_MOD | BPF_X, 0),
  3124				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3125				BPF_STMT(BPF_LD | BPF_IMM, 0xffffffff),
  3126				BPF_STMT(BPF_ALU | BPF_MOD | BPF_K, 0x70000000),
  3127				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  3128				BPF_STMT(BPF_RET | BPF_A, 0)
  3129			},
  3130			CLASSIC | FLAG_NO_DATA,
  3131			{ },
  3132			{ { 0, 0x20000000 } }
  3133		},
  3134		{
  3135			"AND_OR_LSH_K",
  3136			.u.insns = {
  3137				BPF_STMT(BPF_LD | BPF_IMM, 0xff),
  3138				BPF_STMT(BPF_ALU | BPF_AND | BPF_K, 0xf0),
  3139				BPF_STMT(BPF_ALU | BPF_LSH | BPF_K, 27),
  3140				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3141				BPF_STMT(BPF_LD | BPF_IMM, 0xf),
  3142				BPF_STMT(BPF_ALU | BPF_OR | BPF_K, 0xf0),
  3143				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  3144				BPF_STMT(BPF_RET | BPF_A, 0)
  3145			},
  3146			CLASSIC | FLAG_NO_DATA,
  3147			{ },
  3148			{ { 0, 0x800000ff }, { 1, 0x800000ff } },
  3149		},
  3150		{
  3151			"LD_IMM_0",
  3152			.u.insns = {
  3153				BPF_STMT(BPF_LD | BPF_IMM, 0), /* ld #0 */
  3154				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0, 1, 0),
  3155				BPF_STMT(BPF_RET | BPF_K, 0),
  3156				BPF_STMT(BPF_RET | BPF_K, 1),
  3157			},
  3158			CLASSIC,
  3159			{ },
  3160			{ { 1, 1 } },
  3161		},
  3162		{
  3163			"LD_IND",
  3164			.u.insns = {
  3165				BPF_STMT(BPF_LDX | BPF_LEN, 0),
  3166				BPF_STMT(BPF_LD | BPF_H | BPF_IND, MAX_K),
  3167				BPF_STMT(BPF_RET | BPF_K, 1)
  3168			},
  3169			CLASSIC,
  3170			{ },
  3171			{ { 1, 0 }, { 10, 0 }, { 60, 0 } },
  3172		},
  3173		{
  3174			"LD_ABS",
  3175			.u.insns = {
  3176				BPF_STMT(BPF_LD | BPF_W | BPF_ABS, 1000),
  3177				BPF_STMT(BPF_RET | BPF_K, 1)
  3178			},
  3179			CLASSIC,
  3180			{ },
  3181			{ { 1, 0 }, { 10, 0 }, { 60, 0 } },
  3182		},
  3183		{
  3184			"LD_ABS_LL",
  3185			.u.insns = {
  3186				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, SKF_LL_OFF),
  3187				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3188				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, SKF_LL_OFF + 1),
  3189				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  3190				BPF_STMT(BPF_RET | BPF_A, 0)
  3191			},
  3192			CLASSIC,
  3193			{ 1, 2, 3 },
  3194			{ { 1, 0 }, { 2, 3 } },
  3195		},
  3196		{
  3197			"LD_IND_LL",
  3198			.u.insns = {
  3199				BPF_STMT(BPF_LD | BPF_IMM, SKF_LL_OFF - 1),
  3200				BPF_STMT(BPF_LDX | BPF_LEN, 0),
  3201				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  3202				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3203				BPF_STMT(BPF_LD | BPF_B | BPF_IND, 0),
  3204				BPF_STMT(BPF_RET | BPF_A, 0)
  3205			},
  3206			CLASSIC,
  3207			{ 1, 2, 3, 0xff },
  3208			{ { 1, 1 }, { 3, 3 }, { 4, 0xff } },
  3209		},
  3210		{
  3211			"LD_ABS_NET",
  3212			.u.insns = {
  3213				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, SKF_NET_OFF),
  3214				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3215				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, SKF_NET_OFF + 1),
  3216				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  3217				BPF_STMT(BPF_RET | BPF_A, 0)
  3218			},
  3219			CLASSIC,
  3220			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3 },
  3221			{ { 15, 0 }, { 16, 3 } },
  3222		},
  3223		{
  3224			"LD_IND_NET",
  3225			.u.insns = {
  3226				BPF_STMT(BPF_LD | BPF_IMM, SKF_NET_OFF - 15),
  3227				BPF_STMT(BPF_LDX | BPF_LEN, 0),
  3228				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  3229				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3230				BPF_STMT(BPF_LD | BPF_B | BPF_IND, 0),
  3231				BPF_STMT(BPF_RET | BPF_A, 0)
  3232			},
  3233			CLASSIC,
  3234			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3 },
  3235			{ { 14, 0 }, { 15, 1 }, { 17, 3 } },
  3236		},
  3237		{
  3238			"LD_PKTTYPE",
  3239			.u.insns = {
  3240				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3241					 SKF_AD_OFF + SKF_AD_PKTTYPE),
  3242				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, SKB_TYPE, 1, 0),
  3243				BPF_STMT(BPF_RET | BPF_K, 1),
  3244				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3245					 SKF_AD_OFF + SKF_AD_PKTTYPE),
  3246				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, SKB_TYPE, 1, 0),
  3247				BPF_STMT(BPF_RET | BPF_K, 1),
  3248				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3249					 SKF_AD_OFF + SKF_AD_PKTTYPE),
  3250				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, SKB_TYPE, 1, 0),
  3251				BPF_STMT(BPF_RET | BPF_K, 1),
  3252				BPF_STMT(BPF_RET | BPF_A, 0)
  3253			},
  3254			CLASSIC,
  3255			{ },
  3256			{ { 1, 3 }, { 10, 3 } },
  3257		},
  3258		{
  3259			"LD_MARK",
  3260			.u.insns = {
  3261				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3262					 SKF_AD_OFF + SKF_AD_MARK),
  3263				BPF_STMT(BPF_RET | BPF_A, 0)
  3264			},
  3265			CLASSIC,
  3266			{ },
  3267			{ { 1, SKB_MARK}, { 10, SKB_MARK} },
  3268		},
  3269		{
  3270			"LD_RXHASH",
  3271			.u.insns = {
  3272				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3273					 SKF_AD_OFF + SKF_AD_RXHASH),
  3274				BPF_STMT(BPF_RET | BPF_A, 0)
  3275			},
  3276			CLASSIC,
  3277			{ },
  3278			{ { 1, SKB_HASH}, { 10, SKB_HASH} },
  3279		},
  3280		{
  3281			"LD_QUEUE",
  3282			.u.insns = {
  3283				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3284					 SKF_AD_OFF + SKF_AD_QUEUE),
  3285				BPF_STMT(BPF_RET | BPF_A, 0)
  3286			},
  3287			CLASSIC,
  3288			{ },
  3289			{ { 1, SKB_QUEUE_MAP }, { 10, SKB_QUEUE_MAP } },
  3290		},
  3291		{
  3292			"LD_PROTOCOL",
  3293			.u.insns = {
  3294				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 1),
  3295				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 20, 1, 0),
  3296				BPF_STMT(BPF_RET | BPF_K, 0),
  3297				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3298					 SKF_AD_OFF + SKF_AD_PROTOCOL),
  3299				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3300				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 2),
  3301				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 30, 1, 0),
  3302				BPF_STMT(BPF_RET | BPF_K, 0),
  3303				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  3304				BPF_STMT(BPF_RET | BPF_A, 0)
  3305			},
  3306			CLASSIC,
  3307			{ 10, 20, 30 },
  3308			{ { 10, ETH_P_IP }, { 100, ETH_P_IP } },
  3309		},
  3310		{
  3311			"LD_VLAN_TAG",
  3312			.u.insns = {
  3313				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3314					 SKF_AD_OFF + SKF_AD_VLAN_TAG),
  3315				BPF_STMT(BPF_RET | BPF_A, 0)
  3316			},
  3317			CLASSIC,
  3318			{ },
  3319			{
  3320				{ 1, SKB_VLAN_TCI },
  3321				{ 10, SKB_VLAN_TCI }
  3322			},
  3323		},
  3324		{
  3325			"LD_VLAN_TAG_PRESENT",
  3326			.u.insns = {
  3327				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3328					 SKF_AD_OFF + SKF_AD_VLAN_TAG_PRESENT),
  3329				BPF_STMT(BPF_RET | BPF_A, 0)
  3330			},
  3331			CLASSIC,
  3332			{ },
  3333			{
  3334				{ 1, SKB_VLAN_PRESENT },
  3335				{ 10, SKB_VLAN_PRESENT }
  3336			},
  3337		},
  3338		{
  3339			"LD_IFINDEX",
  3340			.u.insns = {
  3341				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3342					 SKF_AD_OFF + SKF_AD_IFINDEX),
  3343				BPF_STMT(BPF_RET | BPF_A, 0)
  3344			},
  3345			CLASSIC,
  3346			{ },
  3347			{ { 1, SKB_DEV_IFINDEX }, { 10, SKB_DEV_IFINDEX } },
  3348		},
  3349		{
  3350			"LD_HATYPE",
  3351			.u.insns = {
  3352				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3353					 SKF_AD_OFF + SKF_AD_HATYPE),
  3354				BPF_STMT(BPF_RET | BPF_A, 0)
  3355			},
  3356			CLASSIC,
  3357			{ },
  3358			{ { 1, SKB_DEV_TYPE }, { 10, SKB_DEV_TYPE } },
  3359		},
  3360		{
  3361			"LD_CPU",
  3362			.u.insns = {
  3363				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3364					 SKF_AD_OFF + SKF_AD_CPU),
  3365				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3366				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3367					 SKF_AD_OFF + SKF_AD_CPU),
  3368				BPF_STMT(BPF_ALU | BPF_SUB | BPF_X, 0),
  3369				BPF_STMT(BPF_RET | BPF_A, 0)
  3370			},
  3371			CLASSIC,
  3372			{ },
  3373			{ { 1, 0 }, { 10, 0 } },
  3374		},
  3375		{
  3376			"LD_NLATTR",
  3377			.u.insns = {
  3378				BPF_STMT(BPF_LDX | BPF_IMM, 2),
  3379				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  3380				BPF_STMT(BPF_LDX | BPF_IMM, 3),
  3381				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3382					 SKF_AD_OFF + SKF_AD_NLATTR),
  3383				BPF_STMT(BPF_RET | BPF_A, 0)
  3384			},
  3385			CLASSIC,
  3386	#ifdef __BIG_ENDIAN
  3387			{ 0xff, 0xff, 0, 4, 0, 2, 0, 4, 0, 3 },
  3388	#else
  3389			{ 0xff, 0xff, 4, 0, 2, 0, 4, 0, 3, 0 },
  3390	#endif
  3391			{ { 4, 0 }, { 20, 6 } },
  3392		},
  3393		{
  3394			"LD_NLATTR_NEST",
  3395			.u.insns = {
  3396				BPF_STMT(BPF_LD | BPF_IMM, 2),
  3397				BPF_STMT(BPF_LDX | BPF_IMM, 3),
  3398				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3399					 SKF_AD_OFF + SKF_AD_NLATTR_NEST),
  3400				BPF_STMT(BPF_LD | BPF_IMM, 2),
  3401				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3402					 SKF_AD_OFF + SKF_AD_NLATTR_NEST),
  3403				BPF_STMT(BPF_LD | BPF_IMM, 2),
  3404				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3405					 SKF_AD_OFF + SKF_AD_NLATTR_NEST),
  3406				BPF_STMT(BPF_LD | BPF_IMM, 2),
  3407				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3408					 SKF_AD_OFF + SKF_AD_NLATTR_NEST),
  3409				BPF_STMT(BPF_LD | BPF_IMM, 2),
  3410				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3411					 SKF_AD_OFF + SKF_AD_NLATTR_NEST),
  3412				BPF_STMT(BPF_LD | BPF_IMM, 2),
  3413				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3414					 SKF_AD_OFF + SKF_AD_NLATTR_NEST),
  3415				BPF_STMT(BPF_LD | BPF_IMM, 2),
  3416				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3417					 SKF_AD_OFF + SKF_AD_NLATTR_NEST),
  3418				BPF_STMT(BPF_LD | BPF_IMM, 2),
  3419				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3420					 SKF_AD_OFF + SKF_AD_NLATTR_NEST),
  3421				BPF_STMT(BPF_RET | BPF_A, 0)
  3422			},
  3423			CLASSIC,
  3424	#ifdef __BIG_ENDIAN
  3425			{ 0xff, 0xff, 0, 12, 0, 1, 0, 4, 0, 2, 0, 4, 0, 3 },
  3426	#else
  3427			{ 0xff, 0xff, 12, 0, 1, 0, 4, 0, 2, 0, 4, 0, 3, 0 },
  3428	#endif
  3429			{ { 4, 0 }, { 20, 10 } },
  3430		},
  3431		{
  3432			"LD_PAYLOAD_OFF",
  3433			.u.insns = {
  3434				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3435					 SKF_AD_OFF + SKF_AD_PAY_OFFSET),
  3436				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3437					 SKF_AD_OFF + SKF_AD_PAY_OFFSET),
  3438				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3439					 SKF_AD_OFF + SKF_AD_PAY_OFFSET),
  3440				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3441					 SKF_AD_OFF + SKF_AD_PAY_OFFSET),
  3442				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3443					 SKF_AD_OFF + SKF_AD_PAY_OFFSET),
  3444				BPF_STMT(BPF_RET | BPF_A, 0)
  3445			},
  3446			CLASSIC,
  3447			/* 00:00:00:00:00:00 > 00:00:00:00:00:00, ethtype IPv4 (0x0800),
  3448			 * length 98: 127.0.0.1 > 127.0.0.1: ICMP echo request,
  3449			 * id 9737, seq 1, length 64
  3450			 */
  3451			{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
  3452			  0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
  3453			  0x08, 0x00,
  3454			  0x45, 0x00, 0x00, 0x54, 0xac, 0x8b, 0x40, 0x00, 0x40,
  3455			  0x01, 0x90, 0x1b, 0x7f, 0x00, 0x00, 0x01 },
  3456			{ { 30, 0 }, { 100, 42 } },
  3457		},
  3458		{
  3459			"LD_ANC_XOR",
  3460			.u.insns = {
  3461				BPF_STMT(BPF_LD | BPF_IMM, 10),
  3462				BPF_STMT(BPF_LDX | BPF_IMM, 300),
  3463				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3464					 SKF_AD_OFF + SKF_AD_ALU_XOR_X),
  3465				BPF_STMT(BPF_RET | BPF_A, 0)
  3466			},
  3467			CLASSIC,
  3468			{ },
  3469			{ { 4, 0xA ^ 300 }, { 20, 0xA ^ 300 } },
  3470		},
  3471		{
  3472			"SPILL_FILL",
  3473			.u.insns = {
  3474				BPF_STMT(BPF_LDX | BPF_LEN, 0),
  3475				BPF_STMT(BPF_LD | BPF_IMM, 2),
  3476				BPF_STMT(BPF_ALU | BPF_RSH, 1),
  3477				BPF_STMT(BPF_ALU | BPF_XOR | BPF_X, 0),
  3478				BPF_STMT(BPF_ST, 1), /* M1 = 1 ^ len */
  3479				BPF_STMT(BPF_ALU | BPF_XOR | BPF_K, 0x80000000),
  3480				BPF_STMT(BPF_ST, 2), /* M2 = 1 ^ len ^ 0x80000000 */
  3481				BPF_STMT(BPF_STX, 15), /* M3 = len */
  3482				BPF_STMT(BPF_LDX | BPF_MEM, 1),
  3483				BPF_STMT(BPF_LD | BPF_MEM, 2),
  3484				BPF_STMT(BPF_ALU | BPF_XOR | BPF_X, 0),
  3485				BPF_STMT(BPF_LDX | BPF_MEM, 15),
  3486				BPF_STMT(BPF_ALU | BPF_XOR | BPF_X, 0),
  3487				BPF_STMT(BPF_RET | BPF_A, 0)
  3488			},
  3489			CLASSIC,
  3490			{ },
  3491			{ { 1, 0x80000001 }, { 2, 0x80000002 }, { 60, 0x80000000 ^ 60 } }
  3492		},
  3493		{
  3494			"JEQ",
  3495			.u.insns = {
  3496				BPF_STMT(BPF_LDX | BPF_LEN, 0),
  3497				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 2),
  3498				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_X, 0, 0, 1),
  3499				BPF_STMT(BPF_RET | BPF_K, 1),
  3500				BPF_STMT(BPF_RET | BPF_K, MAX_K)
  3501			},
  3502			CLASSIC,
  3503			{ 3, 3, 3, 3, 3 },
  3504			{ { 1, 0 }, { 3, 1 }, { 4, MAX_K } },
  3505		},
  3506		{
  3507			"JGT",
  3508			.u.insns = {
  3509				BPF_STMT(BPF_LDX | BPF_LEN, 0),
  3510				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 2),
  3511				BPF_JUMP(BPF_JMP | BPF_JGT | BPF_X, 0, 0, 1),
  3512				BPF_STMT(BPF_RET | BPF_K, 1),
  3513				BPF_STMT(BPF_RET | BPF_K, MAX_K)
  3514			},
  3515			CLASSIC,
  3516			{ 4, 4, 4, 3, 3 },
  3517			{ { 2, 0 }, { 3, 1 }, { 4, MAX_K } },
  3518		},
  3519		{
  3520			"JGE (jt 0), test 1",
  3521			.u.insns = {
  3522				BPF_STMT(BPF_LDX | BPF_LEN, 0),
  3523				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 2),
  3524				BPF_JUMP(BPF_JMP | BPF_JGE | BPF_X, 0, 0, 1),
  3525				BPF_STMT(BPF_RET | BPF_K, 1),
  3526				BPF_STMT(BPF_RET | BPF_K, MAX_K)
  3527			},
  3528			CLASSIC,
  3529			{ 4, 4, 4, 3, 3 },
  3530			{ { 2, 0 }, { 3, 1 }, { 4, 1 } },
  3531		},
  3532		{
  3533			"JGE (jt 0), test 2",
  3534			.u.insns = {
  3535				BPF_STMT(BPF_LDX | BPF_LEN, 0),
  3536				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 2),
  3537				BPF_JUMP(BPF_JMP | BPF_JGE | BPF_X, 0, 0, 1),
  3538				BPF_STMT(BPF_RET | BPF_K, 1),
  3539				BPF_STMT(BPF_RET | BPF_K, MAX_K)
  3540			},
  3541			CLASSIC,
  3542			{ 4, 4, 5, 3, 3 },
  3543			{ { 4, 1 }, { 5, 1 }, { 6, MAX_K } },
  3544		},
  3545		{
  3546			"JGE",
  3547			.u.insns = {
  3548				BPF_STMT(BPF_LDX | BPF_LEN, 0),
  3549				BPF_STMT(BPF_LD | BPF_B | BPF_IND, MAX_K),
  3550				BPF_JUMP(BPF_JMP | BPF_JGE | BPF_K, 1, 1, 0),
  3551				BPF_STMT(BPF_RET | BPF_K, 10),
  3552				BPF_JUMP(BPF_JMP | BPF_JGE | BPF_K, 2, 1, 0),
  3553				BPF_STMT(BPF_RET | BPF_K, 20),
  3554				BPF_JUMP(BPF_JMP | BPF_JGE | BPF_K, 3, 1, 0),
  3555				BPF_STMT(BPF_RET | BPF_K, 30),
  3556				BPF_JUMP(BPF_JMP | BPF_JGE | BPF_K, 4, 1, 0),
  3557				BPF_STMT(BPF_RET | BPF_K, 40),
  3558				BPF_STMT(BPF_RET | BPF_K, MAX_K)
  3559			},
  3560			CLASSIC,
  3561			{ 1, 2, 3, 4, 5 },
  3562			{ { 1, 20 }, { 3, 40 }, { 5, MAX_K } },
  3563		},
  3564		{
  3565			"JSET",
  3566			.u.insns = {
  3567				BPF_JUMP(BPF_JMP | BPF_JA, 0, 0, 0),
  3568				BPF_JUMP(BPF_JMP | BPF_JA, 1, 1, 1),
  3569				BPF_JUMP(BPF_JMP | BPF_JA, 0, 0, 0),
  3570				BPF_JUMP(BPF_JMP | BPF_JA, 0, 0, 0),
  3571				BPF_STMT(BPF_LDX | BPF_LEN, 0),
  3572				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  3573				BPF_STMT(BPF_ALU | BPF_SUB | BPF_K, 4),
  3574				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3575				BPF_STMT(BPF_LD | BPF_W | BPF_IND, 0),
  3576				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 1, 0, 1),
  3577				BPF_STMT(BPF_RET | BPF_K, 10),
  3578				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0x80000000, 0, 1),
  3579				BPF_STMT(BPF_RET | BPF_K, 20),
  3580				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0xffffff, 1, 0),
  3581				BPF_STMT(BPF_RET | BPF_K, 30),
  3582				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0xffffff, 1, 0),
  3583				BPF_STMT(BPF_RET | BPF_K, 30),
  3584				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0xffffff, 1, 0),
  3585				BPF_STMT(BPF_RET | BPF_K, 30),
  3586				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0xffffff, 1, 0),
  3587				BPF_STMT(BPF_RET | BPF_K, 30),
  3588				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0xffffff, 1, 0),
  3589				BPF_STMT(BPF_RET | BPF_K, 30),
  3590				BPF_STMT(BPF_RET | BPF_K, MAX_K)
  3591			},
  3592			CLASSIC,
  3593			{ 0, 0xAA, 0x55, 1 },
  3594			{ { 4, 10 }, { 5, 20 }, { 6, MAX_K } },
  3595		},
  3596		{
  3597			"tcpdump port 22",
  3598			.u.insns = {
  3599				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 12),
  3600				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x86dd, 0, 8), /* IPv6 */
  3601				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 20),
  3602				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x84, 2, 0),
  3603				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x6, 1, 0),
  3604				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x11, 0, 17),
  3605				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 54),
  3606				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 22, 14, 0),
  3607				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 56),
  3608				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 22, 12, 13),
  3609				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x0800, 0, 12), /* IPv4 */
  3610				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 23),
  3611				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x84, 2, 0),
  3612				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x6, 1, 0),
  3613				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x11, 0, 8),
  3614				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 20),
  3615				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0x1fff, 6, 0),
  3616				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 14),
  3617				BPF_STMT(BPF_LD | BPF_H | BPF_IND, 14),
  3618				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 22, 2, 0),
  3619				BPF_STMT(BPF_LD | BPF_H | BPF_IND, 16),
  3620				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 22, 0, 1),
  3621				BPF_STMT(BPF_RET | BPF_K, 0xffff),
  3622				BPF_STMT(BPF_RET | BPF_K, 0),
  3623			},
  3624			CLASSIC,
  3625			/* 3c:07:54:43:e5:76 > 10:bf:48:d6:43:d6, ethertype IPv4(0x0800)
  3626			 * length 114: 10.1.1.149.49700 > 10.1.2.10.22: Flags [P.],
  3627			 * seq 1305692979:1305693027, ack 3650467037, win 65535,
  3628			 * options [nop,nop,TS val 2502645400 ecr 3971138], length 48
  3629			 */
  3630			{ 0x10, 0xbf, 0x48, 0xd6, 0x43, 0xd6,
  3631			  0x3c, 0x07, 0x54, 0x43, 0xe5, 0x76,
  3632			  0x08, 0x00,
  3633			  0x45, 0x10, 0x00, 0x64, 0x75, 0xb5,
  3634			  0x40, 0x00, 0x40, 0x06, 0xad, 0x2e, /* IP header */
  3635			  0x0a, 0x01, 0x01, 0x95, /* ip src */
  3636			  0x0a, 0x01, 0x02, 0x0a, /* ip dst */
  3637			  0xc2, 0x24,
  3638			  0x00, 0x16 /* dst port */ },
  3639			{ { 10, 0 }, { 30, 0 }, { 100, 65535 } },
  3640		},
  3641		{
  3642			"tcpdump complex",
  3643			.u.insns = {
  3644				/* tcpdump -nei eth0 'tcp port 22 and (((ip[2:2] -
  3645				 * ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0) and
  3646				 * (len > 115 or len < 30000000000)' -d
  3647				 */
  3648				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 12),
  3649				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x86dd, 30, 0),
  3650				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x800, 0, 29),
  3651				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 23),
  3652				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x6, 0, 27),
  3653				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 20),
  3654				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0x1fff, 25, 0),
  3655				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 14),
  3656				BPF_STMT(BPF_LD | BPF_H | BPF_IND, 14),
  3657				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 22, 2, 0),
  3658				BPF_STMT(BPF_LD | BPF_H | BPF_IND, 16),
  3659				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 22, 0, 20),
  3660				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 16),
  3661				BPF_STMT(BPF_ST, 1),
  3662				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 14),
  3663				BPF_STMT(BPF_ALU | BPF_AND | BPF_K, 0xf),
  3664				BPF_STMT(BPF_ALU | BPF_LSH | BPF_K, 2),
  3665				BPF_STMT(BPF_MISC | BPF_TAX, 0x5), /* libpcap emits K on TAX */
  3666				BPF_STMT(BPF_LD | BPF_MEM, 1),
  3667				BPF_STMT(BPF_ALU | BPF_SUB | BPF_X, 0),
  3668				BPF_STMT(BPF_ST, 5),
  3669				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 14),
  3670				BPF_STMT(BPF_LD | BPF_B | BPF_IND, 26),
  3671				BPF_STMT(BPF_ALU | BPF_AND | BPF_K, 0xf0),
  3672				BPF_STMT(BPF_ALU | BPF_RSH | BPF_K, 2),
  3673				BPF_STMT(BPF_MISC | BPF_TAX, 0x9), /* libpcap emits K on TAX */
  3674				BPF_STMT(BPF_LD | BPF_MEM, 5),
  3675				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_X, 0, 4, 0),
  3676				BPF_STMT(BPF_LD | BPF_LEN, 0),
  3677				BPF_JUMP(BPF_JMP | BPF_JGT | BPF_K, 0x73, 1, 0),
  3678				BPF_JUMP(BPF_JMP | BPF_JGE | BPF_K, 0xfc23ac00, 1, 0),
  3679				BPF_STMT(BPF_RET | BPF_K, 0xffff),
  3680				BPF_STMT(BPF_RET | BPF_K, 0),
  3681			},
  3682			CLASSIC,
  3683			{ 0x10, 0xbf, 0x48, 0xd6, 0x43, 0xd6,
  3684			  0x3c, 0x07, 0x54, 0x43, 0xe5, 0x76,
  3685			  0x08, 0x00,
  3686			  0x45, 0x10, 0x00, 0x64, 0x75, 0xb5,
  3687			  0x40, 0x00, 0x40, 0x06, 0xad, 0x2e, /* IP header */
  3688			  0x0a, 0x01, 0x01, 0x95, /* ip src */
  3689			  0x0a, 0x01, 0x02, 0x0a, /* ip dst */
  3690			  0xc2, 0x24,
  3691			  0x00, 0x16 /* dst port */ },
  3692			{ { 10, 0 }, { 30, 0 }, { 100, 65535 } },
  3693		},
  3694		{
  3695			"RET_A",
  3696			.u.insns = {
  3697				/* check that uninitialized X and A contain zeros */
  3698				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  3699				BPF_STMT(BPF_RET | BPF_A, 0)
  3700			},
  3701			CLASSIC,
  3702			{ },
  3703			{ {1, 0}, {2, 0} },
  3704		},
  3705		{
  3706			"INT: ADD trivial",
  3707			.u.insns_int = {
  3708				BPF_ALU64_IMM(BPF_MOV, R1, 1),
  3709				BPF_ALU64_IMM(BPF_ADD, R1, 2),
  3710				BPF_ALU64_IMM(BPF_MOV, R2, 3),
  3711				BPF_ALU64_REG(BPF_SUB, R1, R2),
  3712				BPF_ALU64_IMM(BPF_ADD, R1, -1),
  3713				BPF_ALU64_IMM(BPF_MUL, R1, 3),
  3714				BPF_ALU64_REG(BPF_MOV, R0, R1),
  3715				BPF_EXIT_INSN(),
  3716			},
  3717			INTERNAL,
  3718			{ },
  3719			{ { 0, 0xfffffffd } }
  3720		},
  3721		{
  3722			"INT: MUL_X",
  3723			.u.insns_int = {
  3724				BPF_ALU64_IMM(BPF_MOV, R0, -1),
  3725				BPF_ALU64_IMM(BPF_MOV, R1, -1),
  3726				BPF_ALU64_IMM(BPF_MOV, R2, 3),
  3727				BPF_ALU64_REG(BPF_MUL, R1, R2),
  3728				BPF_JMP_IMM(BPF_JEQ, R1, 0xfffffffd, 1),
  3729				BPF_EXIT_INSN(),
  3730				BPF_ALU64_IMM(BPF_MOV, R0, 1),
  3731				BPF_EXIT_INSN(),
  3732			},
  3733			INTERNAL,
  3734			{ },
  3735			{ { 0, 1 } }
  3736		},
  3737		{
  3738			"INT: MUL_X2",
  3739			.u.insns_int = {
  3740				BPF_ALU32_IMM(BPF_MOV, R0, -1),
  3741				BPF_ALU32_IMM(BPF_MOV, R1, -1),
  3742				BPF_ALU32_IMM(BPF_MOV, R2, 3),
  3743				BPF_ALU64_REG(BPF_MUL, R1, R2),
  3744				BPF_ALU64_IMM(BPF_RSH, R1, 8),
  3745				BPF_JMP_IMM(BPF_JEQ, R1, 0x2ffffff, 1),
  3746				BPF_EXIT_INSN(),
  3747				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  3748				BPF_EXIT_INSN(),
  3749			},
  3750			INTERNAL,
  3751			{ },
  3752			{ { 0, 1 } }
  3753		},
  3754		{
  3755			"INT: MUL32_X",
  3756			.u.insns_int = {
  3757				BPF_ALU32_IMM(BPF_MOV, R0, -1),
  3758				BPF_ALU64_IMM(BPF_MOV, R1, -1),
  3759				BPF_ALU32_IMM(BPF_MOV, R2, 3),
  3760				BPF_ALU32_REG(BPF_MUL, R1, R2),
  3761				BPF_ALU64_IMM(BPF_RSH, R1, 8),
  3762				BPF_JMP_IMM(BPF_JEQ, R1, 0xffffff, 1),
  3763				BPF_EXIT_INSN(),
  3764				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  3765				BPF_EXIT_INSN(),
  3766			},
  3767			INTERNAL,
  3768			{ },
  3769			{ { 0, 1 } }
  3770		},
  3771		{
  3772			/* Have to test all register combinations, since
  3773			 * JITing of different registers will produce
  3774			 * different asm code.
  3775			 */
  3776			"INT: ADD 64-bit",
  3777			.u.insns_int = {
  3778				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  3779				BPF_ALU64_IMM(BPF_MOV, R1, 1),
  3780				BPF_ALU64_IMM(BPF_MOV, R2, 2),
  3781				BPF_ALU64_IMM(BPF_MOV, R3, 3),
  3782				BPF_ALU64_IMM(BPF_MOV, R4, 4),
  3783				BPF_ALU64_IMM(BPF_MOV, R5, 5),
  3784				BPF_ALU64_IMM(BPF_MOV, R6, 6),
  3785				BPF_ALU64_IMM(BPF_MOV, R7, 7),
  3786				BPF_ALU64_IMM(BPF_MOV, R8, 8),
  3787				BPF_ALU64_IMM(BPF_MOV, R9, 9),
  3788				BPF_ALU64_IMM(BPF_ADD, R0, 20),
  3789				BPF_ALU64_IMM(BPF_ADD, R1, 20),
  3790				BPF_ALU64_IMM(BPF_ADD, R2, 20),
  3791				BPF_ALU64_IMM(BPF_ADD, R3, 20),
  3792				BPF_ALU64_IMM(BPF_ADD, R4, 20),
  3793				BPF_ALU64_IMM(BPF_ADD, R5, 20),
  3794				BPF_ALU64_IMM(BPF_ADD, R6, 20),
  3795				BPF_ALU64_IMM(BPF_ADD, R7, 20),
  3796				BPF_ALU64_IMM(BPF_ADD, R8, 20),
  3797				BPF_ALU64_IMM(BPF_ADD, R9, 20),
  3798				BPF_ALU64_IMM(BPF_SUB, R0, 10),
  3799				BPF_ALU64_IMM(BPF_SUB, R1, 10),
  3800				BPF_ALU64_IMM(BPF_SUB, R2, 10),
  3801				BPF_ALU64_IMM(BPF_SUB, R3, 10),
  3802				BPF_ALU64_IMM(BPF_SUB, R4, 10),
  3803				BPF_ALU64_IMM(BPF_SUB, R5, 10),
  3804				BPF_ALU64_IMM(BPF_SUB, R6, 10),
  3805				BPF_ALU64_IMM(BPF_SUB, R7, 10),
  3806				BPF_ALU64_IMM(BPF_SUB, R8, 10),
  3807				BPF_ALU64_IMM(BPF_SUB, R9, 10),
  3808				BPF_ALU64_REG(BPF_ADD, R0, R0),
  3809				BPF_ALU64_REG(BPF_ADD, R0, R1),
  3810				BPF_ALU64_REG(BPF_ADD, R0, R2),
  3811				BPF_ALU64_REG(BPF_ADD, R0, R3),
  3812				BPF_ALU64_REG(BPF_ADD, R0, R4),
  3813				BPF_ALU64_REG(BPF_ADD, R0, R5),
  3814				BPF_ALU64_REG(BPF_ADD, R0, R6),
  3815				BPF_ALU64_REG(BPF_ADD, R0, R7),
  3816				BPF_ALU64_REG(BPF_ADD, R0, R8),
  3817				BPF_ALU64_REG(BPF_ADD, R0, R9), /* R0 == 155 */
  3818				BPF_JMP_IMM(BPF_JEQ, R0, 155, 1),
  3819				BPF_EXIT_INSN(),
  3820				BPF_ALU64_REG(BPF_ADD, R1, R0),
  3821				BPF_ALU64_REG(BPF_ADD, R1, R1),
  3822				BPF_ALU64_REG(BPF_ADD, R1, R2),
  3823				BPF_ALU64_REG(BPF_ADD, R1, R3),
  3824				BPF_ALU64_REG(BPF_ADD, R1, R4),
  3825				BPF_ALU64_REG(BPF_ADD, R1, R5),
  3826				BPF_ALU64_REG(BPF_ADD, R1, R6),
  3827				BPF_ALU64_REG(BPF_ADD, R1, R7),
  3828				BPF_ALU64_REG(BPF_ADD, R1, R8),
  3829				BPF_ALU64_REG(BPF_ADD, R1, R9), /* R1 == 456 */
  3830				BPF_JMP_IMM(BPF_JEQ, R1, 456, 1),
  3831				BPF_EXIT_INSN(),
  3832				BPF_ALU64_REG(BPF_ADD, R2, R0),
  3833				BPF_ALU64_REG(BPF_ADD, R2, R1),
  3834				BPF_ALU64_REG(BPF_ADD, R2, R2),
  3835				BPF_ALU64_REG(BPF_ADD, R2, R3),
  3836				BPF_ALU64_REG(BPF_ADD, R2, R4),
  3837				BPF_ALU64_REG(BPF_ADD, R2, R5),
  3838				BPF_ALU64_REG(BPF_ADD, R2, R6),
  3839				BPF_ALU64_REG(BPF_ADD, R2, R7),
  3840				BPF_ALU64_REG(BPF_ADD, R2, R8),
  3841				BPF_ALU64_REG(BPF_ADD, R2, R9), /* R2 == 1358 */
  3842				BPF_JMP_IMM(BPF_JEQ, R2, 1358, 1),
  3843				BPF_EXIT_INSN(),
  3844				BPF_ALU64_REG(BPF_ADD, R3, R0),
  3845				BPF_ALU64_REG(BPF_ADD, R3, R1),
  3846				BPF_ALU64_REG(BPF_ADD, R3, R2),
  3847				BPF_ALU64_REG(BPF_ADD, R3, R3),
  3848				BPF_ALU64_REG(BPF_ADD, R3, R4),
  3849				BPF_ALU64_REG(BPF_ADD, R3, R5),
  3850				BPF_ALU64_REG(BPF_ADD, R3, R6),
  3851				BPF_ALU64_REG(BPF_ADD, R3, R7),
  3852				BPF_ALU64_REG(BPF_ADD, R3, R8),
  3853				BPF_ALU64_REG(BPF_ADD, R3, R9), /* R3 == 4063 */
  3854				BPF_JMP_IMM(BPF_JEQ, R3, 4063, 1),
  3855				BPF_EXIT_INSN(),
  3856				BPF_ALU64_REG(BPF_ADD, R4, R0),
  3857				BPF_ALU64_REG(BPF_ADD, R4, R1),
  3858				BPF_ALU64_REG(BPF_ADD, R4, R2),
  3859				BPF_ALU64_REG(BPF_ADD, R4, R3),
  3860				BPF_ALU64_REG(BPF_ADD, R4, R4),
  3861				BPF_ALU64_REG(BPF_ADD, R4, R5),
  3862				BPF_ALU64_REG(BPF_ADD, R4, R6),
  3863				BPF_ALU64_REG(BPF_ADD, R4, R7),
  3864				BPF_ALU64_REG(BPF_ADD, R4, R8),
  3865				BPF_ALU64_REG(BPF_ADD, R4, R9), /* R4 == 12177 */
  3866				BPF_JMP_IMM(BPF_JEQ, R4, 12177, 1),
  3867				BPF_EXIT_INSN(),
  3868				BPF_ALU64_REG(BPF_ADD, R5, R0),
  3869				BPF_ALU64_REG(BPF_ADD, R5, R1),
  3870				BPF_ALU64_REG(BPF_ADD, R5, R2),
  3871				BPF_ALU64_REG(BPF_ADD, R5, R3),
  3872				BPF_ALU64_REG(BPF_ADD, R5, R4),
  3873				BPF_ALU64_REG(BPF_ADD, R5, R5),
  3874				BPF_ALU64_REG(BPF_ADD, R5, R6),
  3875				BPF_ALU64_REG(BPF_ADD, R5, R7),
  3876				BPF_ALU64_REG(BPF_ADD, R5, R8),
  3877				BPF_ALU64_REG(BPF_ADD, R5, R9), /* R5 == 36518 */
  3878				BPF_JMP_IMM(BPF_JEQ, R5, 36518, 1),
  3879				BPF_EXIT_INSN(),
  3880				BPF_ALU64_REG(BPF_ADD, R6, R0),
  3881				BPF_ALU64_REG(BPF_ADD, R6, R1),
  3882				BPF_ALU64_REG(BPF_ADD, R6, R2),
  3883				BPF_ALU64_REG(BPF_ADD, R6, R3),
  3884				BPF_ALU64_REG(BPF_ADD, R6, R4),
  3885				BPF_ALU64_REG(BPF_ADD, R6, R5),
  3886				BPF_ALU64_REG(BPF_ADD, R6, R6),
  3887				BPF_ALU64_REG(BPF_ADD, R6, R7),
  3888				BPF_ALU64_REG(BPF_ADD, R6, R8),
  3889				BPF_ALU64_REG(BPF_ADD, R6, R9), /* R6 == 109540 */
  3890				BPF_JMP_IMM(BPF_JEQ, R6, 109540, 1),
  3891				BPF_EXIT_INSN(),
  3892				BPF_ALU64_REG(BPF_ADD, R7, R0),
  3893				BPF_ALU64_REG(BPF_ADD, R7, R1),
  3894				BPF_ALU64_REG(BPF_ADD, R7, R2),
  3895				BPF_ALU64_REG(BPF_ADD, R7, R3),
  3896				BPF_ALU64_REG(BPF_ADD, R7, R4),
  3897				BPF_ALU64_REG(BPF_ADD, R7, R5),
  3898				BPF_ALU64_REG(BPF_ADD, R7, R6),
  3899				BPF_ALU64_REG(BPF_ADD, R7, R7),
  3900				BPF_ALU64_REG(BPF_ADD, R7, R8),
  3901				BPF_ALU64_REG(BPF_ADD, R7, R9), /* R7 == 328605 */
  3902				BPF_JMP_IMM(BPF_JEQ, R7, 328605, 1),
  3903				BPF_EXIT_INSN(),
  3904				BPF_ALU64_REG(BPF_ADD, R8, R0),
  3905				BPF_ALU64_REG(BPF_ADD, R8, R1),
  3906				BPF_ALU64_REG(BPF_ADD, R8, R2),
  3907				BPF_ALU64_REG(BPF_ADD, R8, R3),
  3908				BPF_ALU64_REG(BPF_ADD, R8, R4),
  3909				BPF_ALU64_REG(BPF_ADD, R8, R5),
  3910				BPF_ALU64_REG(BPF_ADD, R8, R6),
  3911				BPF_ALU64_REG(BPF_ADD, R8, R7),
  3912				BPF_ALU64_REG(BPF_ADD, R8, R8),
  3913				BPF_ALU64_REG(BPF_ADD, R8, R9), /* R8 == 985799 */
  3914				BPF_JMP_IMM(BPF_JEQ, R8, 985799, 1),
  3915				BPF_EXIT_INSN(),
  3916				BPF_ALU64_REG(BPF_ADD, R9, R0),
  3917				BPF_ALU64_REG(BPF_ADD, R9, R1),
  3918				BPF_ALU64_REG(BPF_ADD, R9, R2),
  3919				BPF_ALU64_REG(BPF_ADD, R9, R3),
  3920				BPF_ALU64_REG(BPF_ADD, R9, R4),
  3921				BPF_ALU64_REG(BPF_ADD, R9, R5),
  3922				BPF_ALU64_REG(BPF_ADD, R9, R6),
  3923				BPF_ALU64_REG(BPF_ADD, R9, R7),
  3924				BPF_ALU64_REG(BPF_ADD, R9, R8),
  3925				BPF_ALU64_REG(BPF_ADD, R9, R9), /* R9 == 2957380 */
  3926				BPF_ALU64_REG(BPF_MOV, R0, R9),
  3927				BPF_EXIT_INSN(),
  3928			},
  3929			INTERNAL,
  3930			{ },
  3931			{ { 0, 2957380 } }
  3932		},
  3933		{
  3934			"INT: ADD 32-bit",
  3935			.u.insns_int = {
  3936				BPF_ALU32_IMM(BPF_MOV, R0, 20),
  3937				BPF_ALU32_IMM(BPF_MOV, R1, 1),
  3938				BPF_ALU32_IMM(BPF_MOV, R2, 2),
  3939				BPF_ALU32_IMM(BPF_MOV, R3, 3),
  3940				BPF_ALU32_IMM(BPF_MOV, R4, 4),
  3941				BPF_ALU32_IMM(BPF_MOV, R5, 5),
  3942				BPF_ALU32_IMM(BPF_MOV, R6, 6),
  3943				BPF_ALU32_IMM(BPF_MOV, R7, 7),
  3944				BPF_ALU32_IMM(BPF_MOV, R8, 8),
  3945				BPF_ALU32_IMM(BPF_MOV, R9, 9),
  3946				BPF_ALU64_IMM(BPF_ADD, R1, 10),
  3947				BPF_ALU64_IMM(BPF_ADD, R2, 10),
  3948				BPF_ALU64_IMM(BPF_ADD, R3, 10),
  3949				BPF_ALU64_IMM(BPF_ADD, R4, 10),
  3950				BPF_ALU64_IMM(BPF_ADD, R5, 10),
  3951				BPF_ALU64_IMM(BPF_ADD, R6, 10),
  3952				BPF_ALU64_IMM(BPF_ADD, R7, 10),
  3953				BPF_ALU64_IMM(BPF_ADD, R8, 10),
  3954				BPF_ALU64_IMM(BPF_ADD, R9, 10),
  3955				BPF_ALU32_REG(BPF_ADD, R0, R1),
  3956				BPF_ALU32_REG(BPF_ADD, R0, R2),
  3957				BPF_ALU32_REG(BPF_ADD, R0, R3),
  3958				BPF_ALU32_REG(BPF_ADD, R0, R4),
  3959				BPF_ALU32_REG(BPF_ADD, R0, R5),
  3960				BPF_ALU32_REG(BPF_ADD, R0, R6),
  3961				BPF_ALU32_REG(BPF_ADD, R0, R7),
  3962				BPF_ALU32_REG(BPF_ADD, R0, R8),
  3963				BPF_ALU32_REG(BPF_ADD, R0, R9), /* R0 == 155 */
  3964				BPF_JMP_IMM(BPF_JEQ, R0, 155, 1),
  3965				BPF_EXIT_INSN(),
  3966				BPF_ALU32_REG(BPF_ADD, R1, R0),
  3967				BPF_ALU32_REG(BPF_ADD, R1, R1),
  3968				BPF_ALU32_REG(BPF_ADD, R1, R2),
  3969				BPF_ALU32_REG(BPF_ADD, R1, R3),
  3970				BPF_ALU32_REG(BPF_ADD, R1, R4),
  3971				BPF_ALU32_REG(BPF_ADD, R1, R5),
  3972				BPF_ALU32_REG(BPF_ADD, R1, R6),
  3973				BPF_ALU32_REG(BPF_ADD, R1, R7),
  3974				BPF_ALU32_REG(BPF_ADD, R1, R8),
  3975				BPF_ALU32_REG(BPF_ADD, R1, R9), /* R1 == 456 */
  3976				BPF_JMP_IMM(BPF_JEQ, R1, 456, 1),
  3977				BPF_EXIT_INSN(),
  3978				BPF_ALU32_REG(BPF_ADD, R2, R0),
  3979				BPF_ALU32_REG(BPF_ADD, R2, R1),
  3980				BPF_ALU32_REG(BPF_ADD, R2, R2),
  3981				BPF_ALU32_REG(BPF_ADD, R2, R3),
  3982				BPF_ALU32_REG(BPF_ADD, R2, R4),
  3983				BPF_ALU32_REG(BPF_ADD, R2, R5),
  3984				BPF_ALU32_REG(BPF_ADD, R2, R6),
  3985				BPF_ALU32_REG(BPF_ADD, R2, R7),
  3986				BPF_ALU32_REG(BPF_ADD, R2, R8),
  3987				BPF_ALU32_REG(BPF_ADD, R2, R9), /* R2 == 1358 */
  3988				BPF_JMP_IMM(BPF_JEQ, R2, 1358, 1),
  3989				BPF_EXIT_INSN(),
  3990				BPF_ALU32_REG(BPF_ADD, R3, R0),
  3991				BPF_ALU32_REG(BPF_ADD, R3, R1),
  3992				BPF_ALU32_REG(BPF_ADD, R3, R2),
  3993				BPF_ALU32_REG(BPF_ADD, R3, R3),
  3994				BPF_ALU32_REG(BPF_ADD, R3, R4),
  3995				BPF_ALU32_REG(BPF_ADD, R3, R5),
  3996				BPF_ALU32_REG(BPF_ADD, R3, R6),
  3997				BPF_ALU32_REG(BPF_ADD, R3, R7),
  3998				BPF_ALU32_REG(BPF_ADD, R3, R8),
  3999				BPF_ALU32_REG(BPF_ADD, R3, R9), /* R3 == 4063 */
  4000				BPF_JMP_IMM(BPF_JEQ, R3, 4063, 1),
  4001				BPF_EXIT_INSN(),
  4002				BPF_ALU32_REG(BPF_ADD, R4, R0),
  4003				BPF_ALU32_REG(BPF_ADD, R4, R1),
  4004				BPF_ALU32_REG(BPF_ADD, R4, R2),
  4005				BPF_ALU32_REG(BPF_ADD, R4, R3),
  4006				BPF_ALU32_REG(BPF_ADD, R4, R4),
  4007				BPF_ALU32_REG(BPF_ADD, R4, R5),
  4008				BPF_ALU32_REG(BPF_ADD, R4, R6),
  4009				BPF_ALU32_REG(BPF_ADD, R4, R7),
  4010				BPF_ALU32_REG(BPF_ADD, R4, R8),
  4011				BPF_ALU32_REG(BPF_ADD, R4, R9), /* R4 == 12177 */
  4012				BPF_JMP_IMM(BPF_JEQ, R4, 12177, 1),
  4013				BPF_EXIT_INSN(),
  4014				BPF_ALU32_REG(BPF_ADD, R5, R0),
  4015				BPF_ALU32_REG(BPF_ADD, R5, R1),
  4016				BPF_ALU32_REG(BPF_ADD, R5, R2),
  4017				BPF_ALU32_REG(BPF_ADD, R5, R3),
  4018				BPF_ALU32_REG(BPF_ADD, R5, R4),
  4019				BPF_ALU32_REG(BPF_ADD, R5, R5),
  4020				BPF_ALU32_REG(BPF_ADD, R5, R6),
  4021				BPF_ALU32_REG(BPF_ADD, R5, R7),
  4022				BPF_ALU32_REG(BPF_ADD, R5, R8),
  4023				BPF_ALU32_REG(BPF_ADD, R5, R9), /* R5 == 36518 */
  4024				BPF_JMP_IMM(BPF_JEQ, R5, 36518, 1),
  4025				BPF_EXIT_INSN(),
  4026				BPF_ALU32_REG(BPF_ADD, R6, R0),
  4027				BPF_ALU32_REG(BPF_ADD, R6, R1),
  4028				BPF_ALU32_REG(BPF_ADD, R6, R2),
  4029				BPF_ALU32_REG(BPF_ADD, R6, R3),
  4030				BPF_ALU32_REG(BPF_ADD, R6, R4),
  4031				BPF_ALU32_REG(BPF_ADD, R6, R5),
  4032				BPF_ALU32_REG(BPF_ADD, R6, R6),
  4033				BPF_ALU32_REG(BPF_ADD, R6, R7),
  4034				BPF_ALU32_REG(BPF_ADD, R6, R8),
  4035				BPF_ALU32_REG(BPF_ADD, R6, R9), /* R6 == 109540 */
  4036				BPF_JMP_IMM(BPF_JEQ, R6, 109540, 1),
  4037				BPF_EXIT_INSN(),
  4038				BPF_ALU32_REG(BPF_ADD, R7, R0),
  4039				BPF_ALU32_REG(BPF_ADD, R7, R1),
  4040				BPF_ALU32_REG(BPF_ADD, R7, R2),
  4041				BPF_ALU32_REG(BPF_ADD, R7, R3),
  4042				BPF_ALU32_REG(BPF_ADD, R7, R4),
  4043				BPF_ALU32_REG(BPF_ADD, R7, R5),
  4044				BPF_ALU32_REG(BPF_ADD, R7, R6),
  4045				BPF_ALU32_REG(BPF_ADD, R7, R7),
  4046				BPF_ALU32_REG(BPF_ADD, R7, R8),
  4047				BPF_ALU32_REG(BPF_ADD, R7, R9), /* R7 == 328605 */
  4048				BPF_JMP_IMM(BPF_JEQ, R7, 328605, 1),
  4049				BPF_EXIT_INSN(),
  4050				BPF_ALU32_REG(BPF_ADD, R8, R0),
  4051				BPF_ALU32_REG(BPF_ADD, R8, R1),
  4052				BPF_ALU32_REG(BPF_ADD, R8, R2),
  4053				BPF_ALU32_REG(BPF_ADD, R8, R3),
  4054				BPF_ALU32_REG(BPF_ADD, R8, R4),
  4055				BPF_ALU32_REG(BPF_ADD, R8, R5),
  4056				BPF_ALU32_REG(BPF_ADD, R8, R6),
  4057				BPF_ALU32_REG(BPF_ADD, R8, R7),
  4058				BPF_ALU32_REG(BPF_ADD, R8, R8),
  4059				BPF_ALU32_REG(BPF_ADD, R8, R9), /* R8 == 985799 */
  4060				BPF_JMP_IMM(BPF_JEQ, R8, 985799, 1),
  4061				BPF_EXIT_INSN(),
  4062				BPF_ALU32_REG(BPF_ADD, R9, R0),
  4063				BPF_ALU32_REG(BPF_ADD, R9, R1),
  4064				BPF_ALU32_REG(BPF_ADD, R9, R2),
  4065				BPF_ALU32_REG(BPF_ADD, R9, R3),
  4066				BPF_ALU32_REG(BPF_ADD, R9, R4),
  4067				BPF_ALU32_REG(BPF_ADD, R9, R5),
  4068				BPF_ALU32_REG(BPF_ADD, R9, R6),
  4069				BPF_ALU32_REG(BPF_ADD, R9, R7),
  4070				BPF_ALU32_REG(BPF_ADD, R9, R8),
  4071				BPF_ALU32_REG(BPF_ADD, R9, R9), /* R9 == 2957380 */
  4072				BPF_ALU32_REG(BPF_MOV, R0, R9),
  4073				BPF_EXIT_INSN(),
  4074			},
  4075			INTERNAL,
  4076			{ },
  4077			{ { 0, 2957380 } }
  4078		},
  4079		{	/* Mainly checking JIT here. */
  4080			"INT: SUB",
  4081			.u.insns_int = {
  4082				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  4083				BPF_ALU64_IMM(BPF_MOV, R1, 1),
  4084				BPF_ALU64_IMM(BPF_MOV, R2, 2),
  4085				BPF_ALU64_IMM(BPF_MOV, R3, 3),
  4086				BPF_ALU64_IMM(BPF_MOV, R4, 4),
  4087				BPF_ALU64_IMM(BPF_MOV, R5, 5),
  4088				BPF_ALU64_IMM(BPF_MOV, R6, 6),
  4089				BPF_ALU64_IMM(BPF_MOV, R7, 7),
  4090				BPF_ALU64_IMM(BPF_MOV, R8, 8),
  4091				BPF_ALU64_IMM(BPF_MOV, R9, 9),
  4092				BPF_ALU64_REG(BPF_SUB, R0, R0),
  4093				BPF_ALU64_REG(BPF_SUB, R0, R1),
  4094				BPF_ALU64_REG(BPF_SUB, R0, R2),
  4095				BPF_ALU64_REG(BPF_SUB, R0, R3),
  4096				BPF_ALU64_REG(BPF_SUB, R0, R4),
  4097				BPF_ALU64_REG(BPF_SUB, R0, R5),
  4098				BPF_ALU64_REG(BPF_SUB, R0, R6),
  4099				BPF_ALU64_REG(BPF_SUB, R0, R7),
  4100				BPF_ALU64_REG(BPF_SUB, R0, R8),
  4101				BPF_ALU64_REG(BPF_SUB, R0, R9),
  4102				BPF_ALU64_IMM(BPF_SUB, R0, 10),
  4103				BPF_JMP_IMM(BPF_JEQ, R0, -55, 1),
  4104				BPF_EXIT_INSN(),
  4105				BPF_ALU64_REG(BPF_SUB, R1, R0),
  4106				BPF_ALU64_REG(BPF_SUB, R1, R2),
  4107				BPF_ALU64_REG(BPF_SUB, R1, R3),
  4108				BPF_ALU64_REG(BPF_SUB, R1, R4),
  4109				BPF_ALU64_REG(BPF_SUB, R1, R5),
  4110				BPF_ALU64_REG(BPF_SUB, R1, R6),
  4111				BPF_ALU64_REG(BPF_SUB, R1, R7),
  4112				BPF_ALU64_REG(BPF_SUB, R1, R8),
  4113				BPF_ALU64_REG(BPF_SUB, R1, R9),
  4114				BPF_ALU64_IMM(BPF_SUB, R1, 10),
  4115				BPF_ALU64_REG(BPF_SUB, R2, R0),
  4116				BPF_ALU64_REG(BPF_SUB, R2, R1),
  4117				BPF_ALU64_REG(BPF_SUB, R2, R3),
  4118				BPF_ALU64_REG(BPF_SUB, R2, R4),
  4119				BPF_ALU64_REG(BPF_SUB, R2, R5),
  4120				BPF_ALU64_REG(BPF_SUB, R2, R6),
  4121				BPF_ALU64_REG(BPF_SUB, R2, R7),
  4122				BPF_ALU64_REG(BPF_SUB, R2, R8),
  4123				BPF_ALU64_REG(BPF_SUB, R2, R9),
  4124				BPF_ALU64_IMM(BPF_SUB, R2, 10),
  4125				BPF_ALU64_REG(BPF_SUB, R3, R0),
  4126				BPF_ALU64_REG(BPF_SUB, R3, R1),
  4127				BPF_ALU64_REG(BPF_SUB, R3, R2),
  4128				BPF_ALU64_REG(BPF_SUB, R3, R4),
  4129				BPF_ALU64_REG(BPF_SUB, R3, R5),
  4130				BPF_ALU64_REG(BPF_SUB, R3, R6),
  4131				BPF_ALU64_REG(BPF_SUB, R3, R7),
  4132				BPF_ALU64_REG(BPF_SUB, R3, R8),
  4133				BPF_ALU64_REG(BPF_SUB, R3, R9),
  4134				BPF_ALU64_IMM(BPF_SUB, R3, 10),
  4135				BPF_ALU64_REG(BPF_SUB, R4, R0),
  4136				BPF_ALU64_REG(BPF_SUB, R4, R1),
  4137				BPF_ALU64_REG(BPF_SUB, R4, R2),
  4138				BPF_ALU64_REG(BPF_SUB, R4, R3),
  4139				BPF_ALU64_REG(BPF_SUB, R4, R5),
  4140				BPF_ALU64_REG(BPF_SUB, R4, R6),
  4141				BPF_ALU64_REG(BPF_SUB, R4, R7),
  4142				BPF_ALU64_REG(BPF_SUB, R4, R8),
  4143				BPF_ALU64_REG(BPF_SUB, R4, R9),
  4144				BPF_ALU64_IMM(BPF_SUB, R4, 10),
  4145				BPF_ALU64_REG(BPF_SUB, R5, R0),
  4146				BPF_ALU64_REG(BPF_SUB, R5, R1),
  4147				BPF_ALU64_REG(BPF_SUB, R5, R2),
  4148				BPF_ALU64_REG(BPF_SUB, R5, R3),
  4149				BPF_ALU64_REG(BPF_SUB, R5, R4),
  4150				BPF_ALU64_REG(BPF_SUB, R5, R6),
  4151				BPF_ALU64_REG(BPF_SUB, R5, R7),
  4152				BPF_ALU64_REG(BPF_SUB, R5, R8),
  4153				BPF_ALU64_REG(BPF_SUB, R5, R9),
  4154				BPF_ALU64_IMM(BPF_SUB, R5, 10),
  4155				BPF_ALU64_REG(BPF_SUB, R6, R0),
  4156				BPF_ALU64_REG(BPF_SUB, R6, R1),
  4157				BPF_ALU64_REG(BPF_SUB, R6, R2),
  4158				BPF_ALU64_REG(BPF_SUB, R6, R3),
  4159				BPF_ALU64_REG(BPF_SUB, R6, R4),
  4160				BPF_ALU64_REG(BPF_SUB, R6, R5),
  4161				BPF_ALU64_REG(BPF_SUB, R6, R7),
  4162				BPF_ALU64_REG(BPF_SUB, R6, R8),
  4163				BPF_ALU64_REG(BPF_SUB, R6, R9),
  4164				BPF_ALU64_IMM(BPF_SUB, R6, 10),
  4165				BPF_ALU64_REG(BPF_SUB, R7, R0),
  4166				BPF_ALU64_REG(BPF_SUB, R7, R1),
  4167				BPF_ALU64_REG(BPF_SUB, R7, R2),
  4168				BPF_ALU64_REG(BPF_SUB, R7, R3),
  4169				BPF_ALU64_REG(BPF_SUB, R7, R4),
  4170				BPF_ALU64_REG(BPF_SUB, R7, R5),
  4171				BPF_ALU64_REG(BPF_SUB, R7, R6),
  4172				BPF_ALU64_REG(BPF_SUB, R7, R8),
  4173				BPF_ALU64_REG(BPF_SUB, R7, R9),
  4174				BPF_ALU64_IMM(BPF_SUB, R7, 10),
  4175				BPF_ALU64_REG(BPF_SUB, R8, R0),
  4176				BPF_ALU64_REG(BPF_SUB, R8, R1),
  4177				BPF_ALU64_REG(BPF_SUB, R8, R2),
  4178				BPF_ALU64_REG(BPF_SUB, R8, R3),
  4179				BPF_ALU64_REG(BPF_SUB, R8, R4),
  4180				BPF_ALU64_REG(BPF_SUB, R8, R5),
  4181				BPF_ALU64_REG(BPF_SUB, R8, R6),
  4182				BPF_ALU64_REG(BPF_SUB, R8, R7),
  4183				BPF_ALU64_REG(BPF_SUB, R8, R9),
  4184				BPF_ALU64_IMM(BPF_SUB, R8, 10),
  4185				BPF_ALU64_REG(BPF_SUB, R9, R0),
  4186				BPF_ALU64_REG(BPF_SUB, R9, R1),
  4187				BPF_ALU64_REG(BPF_SUB, R9, R2),
  4188				BPF_ALU64_REG(BPF_SUB, R9, R3),
  4189				BPF_ALU64_REG(BPF_SUB, R9, R4),
  4190				BPF_ALU64_REG(BPF_SUB, R9, R5),
  4191				BPF_ALU64_REG(BPF_SUB, R9, R6),
  4192				BPF_ALU64_REG(BPF_SUB, R9, R7),
  4193				BPF_ALU64_REG(BPF_SUB, R9, R8),
  4194				BPF_ALU64_IMM(BPF_SUB, R9, 10),
  4195				BPF_ALU64_IMM(BPF_SUB, R0, 10),
  4196				BPF_ALU64_IMM(BPF_NEG, R0, 0),
  4197				BPF_ALU64_REG(BPF_SUB, R0, R1),
  4198				BPF_ALU64_REG(BPF_SUB, R0, R2),
  4199				BPF_ALU64_REG(BPF_SUB, R0, R3),
  4200				BPF_ALU64_REG(BPF_SUB, R0, R4),
  4201				BPF_ALU64_REG(BPF_SUB, R0, R5),
  4202				BPF_ALU64_REG(BPF_SUB, R0, R6),
  4203				BPF_ALU64_REG(BPF_SUB, R0, R7),
  4204				BPF_ALU64_REG(BPF_SUB, R0, R8),
  4205				BPF_ALU64_REG(BPF_SUB, R0, R9),
  4206				BPF_EXIT_INSN(),
  4207			},
  4208			INTERNAL,
  4209			{ },
  4210			{ { 0, 11 } }
  4211		},
  4212		{	/* Mainly checking JIT here. */
  4213			"INT: XOR",
  4214			.u.insns_int = {
  4215				BPF_ALU64_REG(BPF_SUB, R0, R0),
  4216				BPF_ALU64_REG(BPF_XOR, R1, R1),
  4217				BPF_JMP_REG(BPF_JEQ, R0, R1, 1),
  4218				BPF_EXIT_INSN(),
  4219				BPF_ALU64_IMM(BPF_MOV, R0, 10),
  4220				BPF_ALU64_IMM(BPF_MOV, R1, -1),
  4221				BPF_ALU64_REG(BPF_SUB, R1, R1),
  4222				BPF_ALU64_REG(BPF_XOR, R2, R2),
  4223				BPF_JMP_REG(BPF_JEQ, R1, R2, 1),
  4224				BPF_EXIT_INSN(),
  4225				BPF_ALU64_REG(BPF_SUB, R2, R2),
  4226				BPF_ALU64_REG(BPF_XOR, R3, R3),
  4227				BPF_ALU64_IMM(BPF_MOV, R0, 10),
  4228				BPF_ALU64_IMM(BPF_MOV, R1, -1),
  4229				BPF_JMP_REG(BPF_JEQ, R2, R3, 1),
  4230				BPF_EXIT_INSN(),
  4231				BPF_ALU64_REG(BPF_SUB, R3, R3),
  4232				BPF_ALU64_REG(BPF_XOR, R4, R4),
  4233				BPF_ALU64_IMM(BPF_MOV, R2, 1),
  4234				BPF_ALU64_IMM(BPF_MOV, R5, -1),
  4235				BPF_JMP_REG(BPF_JEQ, R3, R4, 1),
  4236				BPF_EXIT_INSN(),
  4237				BPF_ALU64_REG(BPF_SUB, R4, R4),
  4238				BPF_ALU64_REG(BPF_XOR, R5, R5),
  4239				BPF_ALU64_IMM(BPF_MOV, R3, 1),
  4240				BPF_ALU64_IMM(BPF_MOV, R7, -1),
  4241				BPF_JMP_REG(BPF_JEQ, R5, R4, 1),
  4242				BPF_EXIT_INSN(),
  4243				BPF_ALU64_IMM(BPF_MOV, R5, 1),
  4244				BPF_ALU64_REG(BPF_SUB, R5, R5),
  4245				BPF_ALU64_REG(BPF_XOR, R6, R6),
  4246				BPF_ALU64_IMM(BPF_MOV, R1, 1),
  4247				BPF_ALU64_IMM(BPF_MOV, R8, -1),
  4248				BPF_JMP_REG(BPF_JEQ, R5, R6, 1),
  4249				BPF_EXIT_INSN(),
  4250				BPF_ALU64_REG(BPF_SUB, R6, R6),
  4251				BPF_ALU64_REG(BPF_XOR, R7, R7),
  4252				BPF_JMP_REG(BPF_JEQ, R7, R6, 1),
  4253				BPF_EXIT_INSN(),
  4254				BPF_ALU64_REG(BPF_SUB, R7, R7),
  4255				BPF_ALU64_REG(BPF_XOR, R8, R8),
  4256				BPF_JMP_REG(BPF_JEQ, R7, R8, 1),
  4257				BPF_EXIT_INSN(),
  4258				BPF_ALU64_REG(BPF_SUB, R8, R8),
  4259				BPF_ALU64_REG(BPF_XOR, R9, R9),
  4260				BPF_JMP_REG(BPF_JEQ, R9, R8, 1),
  4261				BPF_EXIT_INSN(),
  4262				BPF_ALU64_REG(BPF_SUB, R9, R9),
  4263				BPF_ALU64_REG(BPF_XOR, R0, R0),
  4264				BPF_JMP_REG(BPF_JEQ, R9, R0, 1),
  4265				BPF_EXIT_INSN(),
  4266				BPF_ALU64_REG(BPF_SUB, R1, R1),
  4267				BPF_ALU64_REG(BPF_XOR, R0, R0),
  4268				BPF_JMP_REG(BPF_JEQ, R9, R0, 2),
  4269				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  4270				BPF_EXIT_INSN(),
  4271				BPF_ALU64_IMM(BPF_MOV, R0, 1),
  4272				BPF_EXIT_INSN(),
  4273			},
  4274			INTERNAL,
  4275			{ },
  4276			{ { 0, 1 } }
  4277		},
  4278		{	/* Mainly checking JIT here. */
  4279			"INT: MUL",
  4280			.u.insns_int = {
  4281				BPF_ALU64_IMM(BPF_MOV, R0, 11),
  4282				BPF_ALU64_IMM(BPF_MOV, R1, 1),
  4283				BPF_ALU64_IMM(BPF_MOV, R2, 2),
  4284				BPF_ALU64_IMM(BPF_MOV, R3, 3),
  4285				BPF_ALU64_IMM(BPF_MOV, R4, 4),
  4286				BPF_ALU64_IMM(BPF_MOV, R5, 5),
  4287				BPF_ALU64_IMM(BPF_MOV, R6, 6),
  4288				BPF_ALU64_IMM(BPF_MOV, R7, 7),
  4289				BPF_ALU64_IMM(BPF_MOV, R8, 8),
  4290				BPF_ALU64_IMM(BPF_MOV, R9, 9),
  4291				BPF_ALU64_REG(BPF_MUL, R0, R0),
  4292				BPF_ALU64_REG(BPF_MUL, R0, R1),
  4293				BPF_ALU64_REG(BPF_MUL, R0, R2),
  4294				BPF_ALU64_REG(BPF_MUL, R0, R3),
  4295				BPF_ALU64_REG(BPF_MUL, R0, R4),
  4296				BPF_ALU64_REG(BPF_MUL, R0, R5),
  4297				BPF_ALU64_REG(BPF_MUL, R0, R6),
  4298				BPF_ALU64_REG(BPF_MUL, R0, R7),
  4299				BPF_ALU64_REG(BPF_MUL, R0, R8),
  4300				BPF_ALU64_REG(BPF_MUL, R0, R9),
  4301				BPF_ALU64_IMM(BPF_MUL, R0, 10),
  4302				BPF_JMP_IMM(BPF_JEQ, R0, 439084800, 1),
  4303				BPF_EXIT_INSN(),
  4304				BPF_ALU64_REG(BPF_MUL, R1, R0),
  4305				BPF_ALU64_REG(BPF_MUL, R1, R2),
  4306				BPF_ALU64_REG(BPF_MUL, R1, R3),
  4307				BPF_ALU64_REG(BPF_MUL, R1, R4),
  4308				BPF_ALU64_REG(BPF_MUL, R1, R5),
  4309				BPF_ALU64_REG(BPF_MUL, R1, R6),
  4310				BPF_ALU64_REG(BPF_MUL, R1, R7),
  4311				BPF_ALU64_REG(BPF_MUL, R1, R8),
  4312				BPF_ALU64_REG(BPF_MUL, R1, R9),
  4313				BPF_ALU64_IMM(BPF_MUL, R1, 10),
  4314				BPF_ALU64_REG(BPF_MOV, R2, R1),
  4315				BPF_ALU64_IMM(BPF_RSH, R2, 32),
  4316				BPF_JMP_IMM(BPF_JEQ, R2, 0x5a924, 1),
  4317				BPF_EXIT_INSN(),
  4318				BPF_ALU64_IMM(BPF_LSH, R1, 32),
  4319				BPF_ALU64_IMM(BPF_ARSH, R1, 32),
  4320				BPF_JMP_IMM(BPF_JEQ, R1, 0xebb90000, 1),
  4321				BPF_EXIT_INSN(),
  4322				BPF_ALU64_REG(BPF_MUL, R2, R0),
  4323				BPF_ALU64_REG(BPF_MUL, R2, R1),
  4324				BPF_ALU64_REG(BPF_MUL, R2, R3),
  4325				BPF_ALU64_REG(BPF_MUL, R2, R4),
  4326				BPF_ALU64_REG(BPF_MUL, R2, R5),
  4327				BPF_ALU64_REG(BPF_MUL, R2, R6),
  4328				BPF_ALU64_REG(BPF_MUL, R2, R7),
  4329				BPF_ALU64_REG(BPF_MUL, R2, R8),
  4330				BPF_ALU64_REG(BPF_MUL, R2, R9),
  4331				BPF_ALU64_IMM(BPF_MUL, R2, 10),
  4332				BPF_ALU64_IMM(BPF_RSH, R2, 32),
  4333				BPF_ALU64_REG(BPF_MOV, R0, R2),
  4334				BPF_EXIT_INSN(),
  4335			},
  4336			INTERNAL,
  4337			{ },
  4338			{ { 0, 0x35d97ef2 } }
  4339		},
  4340		{	/* Mainly checking JIT here. */
  4341			"MOV REG64",
  4342			.u.insns_int = {
  4343				BPF_LD_IMM64(R0, 0xffffffffffffffffLL),
  4344				BPF_MOV64_REG(R1, R0),
  4345				BPF_MOV64_REG(R2, R1),
  4346				BPF_MOV64_REG(R3, R2),
  4347				BPF_MOV64_REG(R4, R3),
  4348				BPF_MOV64_REG(R5, R4),
  4349				BPF_MOV64_REG(R6, R5),
  4350				BPF_MOV64_REG(R7, R6),
  4351				BPF_MOV64_REG(R8, R7),
  4352				BPF_MOV64_REG(R9, R8),
  4353				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  4354				BPF_ALU64_IMM(BPF_MOV, R1, 0),
  4355				BPF_ALU64_IMM(BPF_MOV, R2, 0),
  4356				BPF_ALU64_IMM(BPF_MOV, R3, 0),
  4357				BPF_ALU64_IMM(BPF_MOV, R4, 0),
  4358				BPF_ALU64_IMM(BPF_MOV, R5, 0),
  4359				BPF_ALU64_IMM(BPF_MOV, R6, 0),
  4360				BPF_ALU64_IMM(BPF_MOV, R7, 0),
  4361				BPF_ALU64_IMM(BPF_MOV, R8, 0),
  4362				BPF_ALU64_IMM(BPF_MOV, R9, 0),
  4363				BPF_ALU64_REG(BPF_ADD, R0, R0),
  4364				BPF_ALU64_REG(BPF_ADD, R0, R1),
  4365				BPF_ALU64_REG(BPF_ADD, R0, R2),
  4366				BPF_ALU64_REG(BPF_ADD, R0, R3),
  4367				BPF_ALU64_REG(BPF_ADD, R0, R4),
  4368				BPF_ALU64_REG(BPF_ADD, R0, R5),
  4369				BPF_ALU64_REG(BPF_ADD, R0, R6),
  4370				BPF_ALU64_REG(BPF_ADD, R0, R7),
  4371				BPF_ALU64_REG(BPF_ADD, R0, R8),
  4372				BPF_ALU64_REG(BPF_ADD, R0, R9),
  4373				BPF_ALU64_IMM(BPF_ADD, R0, 0xfefe),
  4374				BPF_EXIT_INSN(),
  4375			},
  4376			INTERNAL,
  4377			{ },
  4378			{ { 0, 0xfefe } }
  4379		},
  4380		{	/* Mainly checking JIT here. */
  4381			"MOV REG32",
  4382			.u.insns_int = {
  4383				BPF_LD_IMM64(R0, 0xffffffffffffffffLL),
  4384				BPF_MOV64_REG(R1, R0),
  4385				BPF_MOV64_REG(R2, R1),
  4386				BPF_MOV64_REG(R3, R2),
  4387				BPF_MOV64_REG(R4, R3),
  4388				BPF_MOV64_REG(R5, R4),
  4389				BPF_MOV64_REG(R6, R5),
  4390				BPF_MOV64_REG(R7, R6),
  4391				BPF_MOV64_REG(R8, R7),
  4392				BPF_MOV64_REG(R9, R8),
  4393				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  4394				BPF_ALU32_IMM(BPF_MOV, R1, 0),
  4395				BPF_ALU32_IMM(BPF_MOV, R2, 0),
  4396				BPF_ALU32_IMM(BPF_MOV, R3, 0),
  4397				BPF_ALU32_IMM(BPF_MOV, R4, 0),
  4398				BPF_ALU32_IMM(BPF_MOV, R5, 0),
  4399				BPF_ALU32_IMM(BPF_MOV, R6, 0),
  4400				BPF_ALU32_IMM(BPF_MOV, R7, 0),
  4401				BPF_ALU32_IMM(BPF_MOV, R8, 0),
  4402				BPF_ALU32_IMM(BPF_MOV, R9, 0),
  4403				BPF_ALU64_REG(BPF_ADD, R0, R0),
  4404				BPF_ALU64_REG(BPF_ADD, R0, R1),
  4405				BPF_ALU64_REG(BPF_ADD, R0, R2),
  4406				BPF_ALU64_REG(BPF_ADD, R0, R3),
  4407				BPF_ALU64_REG(BPF_ADD, R0, R4),
  4408				BPF_ALU64_REG(BPF_ADD, R0, R5),
  4409				BPF_ALU64_REG(BPF_ADD, R0, R6),
  4410				BPF_ALU64_REG(BPF_ADD, R0, R7),
  4411				BPF_ALU64_REG(BPF_ADD, R0, R8),
  4412				BPF_ALU64_REG(BPF_ADD, R0, R9),
  4413				BPF_ALU64_IMM(BPF_ADD, R0, 0xfefe),
  4414				BPF_EXIT_INSN(),
  4415			},
  4416			INTERNAL,
  4417			{ },
  4418			{ { 0, 0xfefe } }
  4419		},
  4420		{	/* Mainly checking JIT here. */
  4421			"LD IMM64",
  4422			.u.insns_int = {
  4423				BPF_LD_IMM64(R0, 0xffffffffffffffffLL),
  4424				BPF_MOV64_REG(R1, R0),
  4425				BPF_MOV64_REG(R2, R1),
  4426				BPF_MOV64_REG(R3, R2),
  4427				BPF_MOV64_REG(R4, R3),
  4428				BPF_MOV64_REG(R5, R4),
  4429				BPF_MOV64_REG(R6, R5),
  4430				BPF_MOV64_REG(R7, R6),
  4431				BPF_MOV64_REG(R8, R7),
  4432				BPF_MOV64_REG(R9, R8),
  4433				BPF_LD_IMM64(R0, 0x0LL),
  4434				BPF_LD_IMM64(R1, 0x0LL),
  4435				BPF_LD_IMM64(R2, 0x0LL),
  4436				BPF_LD_IMM64(R3, 0x0LL),
  4437				BPF_LD_IMM64(R4, 0x0LL),
  4438				BPF_LD_IMM64(R5, 0x0LL),
  4439				BPF_LD_IMM64(R6, 0x0LL),
  4440				BPF_LD_IMM64(R7, 0x0LL),
  4441				BPF_LD_IMM64(R8, 0x0LL),
  4442				BPF_LD_IMM64(R9, 0x0LL),
  4443				BPF_ALU64_REG(BPF_ADD, R0, R0),
  4444				BPF_ALU64_REG(BPF_ADD, R0, R1),
  4445				BPF_ALU64_REG(BPF_ADD, R0, R2),
  4446				BPF_ALU64_REG(BPF_ADD, R0, R3),
  4447				BPF_ALU64_REG(BPF_ADD, R0, R4),
  4448				BPF_ALU64_REG(BPF_ADD, R0, R5),
  4449				BPF_ALU64_REG(BPF_ADD, R0, R6),
  4450				BPF_ALU64_REG(BPF_ADD, R0, R7),
  4451				BPF_ALU64_REG(BPF_ADD, R0, R8),
  4452				BPF_ALU64_REG(BPF_ADD, R0, R9),
  4453				BPF_ALU64_IMM(BPF_ADD, R0, 0xfefe),
  4454				BPF_EXIT_INSN(),
  4455			},
  4456			INTERNAL,
  4457			{ },
  4458			{ { 0, 0xfefe } }
  4459		},
  4460		{
  4461			"INT: ALU MIX",
  4462			.u.insns_int = {
  4463				BPF_ALU64_IMM(BPF_MOV, R0, 11),
  4464				BPF_ALU64_IMM(BPF_ADD, R0, -1),
  4465				BPF_ALU64_IMM(BPF_MOV, R2, 2),
  4466				BPF_ALU64_IMM(BPF_XOR, R2, 3),
  4467				BPF_ALU64_REG(BPF_DIV, R0, R2),
  4468				BPF_JMP_IMM(BPF_JEQ, R0, 10, 1),
  4469				BPF_EXIT_INSN(),
  4470				BPF_ALU64_IMM(BPF_MOD, R0, 3),
  4471				BPF_JMP_IMM(BPF_JEQ, R0, 1, 1),
  4472				BPF_EXIT_INSN(),
  4473				BPF_ALU64_IMM(BPF_MOV, R0, -1),
  4474				BPF_EXIT_INSN(),
  4475			},
  4476			INTERNAL,
  4477			{ },
  4478			{ { 0, -1 } }
  4479		},
  4480		{
  4481			"INT: shifts by register",
  4482			.u.insns_int = {
  4483				BPF_MOV64_IMM(R0, -1234),
  4484				BPF_MOV64_IMM(R1, 1),
  4485				BPF_ALU32_REG(BPF_RSH, R0, R1),
  4486				BPF_JMP_IMM(BPF_JEQ, R0, 0x7ffffd97, 1),
  4487				BPF_EXIT_INSN(),
  4488				BPF_MOV64_IMM(R2, 1),
  4489				BPF_ALU64_REG(BPF_LSH, R0, R2),
  4490				BPF_MOV32_IMM(R4, -1234),
  4491				BPF_JMP_REG(BPF_JEQ, R0, R4, 1),
  4492				BPF_EXIT_INSN(),
  4493				BPF_ALU64_IMM(BPF_AND, R4, 63),
  4494				BPF_ALU64_REG(BPF_LSH, R0, R4), /* R0 <= 46 */
  4495				BPF_MOV64_IMM(R3, 47),
  4496				BPF_ALU64_REG(BPF_ARSH, R0, R3),
  4497				BPF_JMP_IMM(BPF_JEQ, R0, -617, 1),
  4498				BPF_EXIT_INSN(),
  4499				BPF_MOV64_IMM(R2, 1),
  4500				BPF_ALU64_REG(BPF_LSH, R4, R2), /* R4 = 46 << 1 */
  4501				BPF_JMP_IMM(BPF_JEQ, R4, 92, 1),
  4502				BPF_EXIT_INSN(),
  4503				BPF_MOV64_IMM(R4, 4),
  4504				BPF_ALU64_REG(BPF_LSH, R4, R4), /* R4 = 4 << 4 */
  4505				BPF_JMP_IMM(BPF_JEQ, R4, 64, 1),
  4506				BPF_EXIT_INSN(),
  4507				BPF_MOV64_IMM(R4, 5),
  4508				BPF_ALU32_REG(BPF_LSH, R4, R4), /* R4 = 5 << 5 */
  4509				BPF_JMP_IMM(BPF_JEQ, R4, 160, 1),
  4510				BPF_EXIT_INSN(),
  4511				BPF_MOV64_IMM(R0, -1),
  4512				BPF_EXIT_INSN(),
  4513			},
  4514			INTERNAL,
  4515			{ },
  4516			{ { 0, -1 } }
  4517		},
  4518	#ifdef CONFIG_32BIT
  4519		{
  4520			"INT: 32-bit context pointer word order and zero-extension",
  4521			.u.insns_int = {
  4522				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  4523				BPF_JMP32_IMM(BPF_JEQ, R1, 0, 3),
  4524				BPF_ALU64_IMM(BPF_RSH, R1, 32),
  4525				BPF_JMP32_IMM(BPF_JNE, R1, 0, 1),
  4526				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  4527				BPF_EXIT_INSN(),
  4528			},
  4529			INTERNAL,
  4530			{ },
  4531			{ { 0, 1 } }
  4532		},
  4533	#endif
  4534		{
  4535			"check: missing ret",
  4536			.u.insns = {
  4537				BPF_STMT(BPF_LD | BPF_IMM, 1),
  4538			},
  4539			CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
  4540			{ },
  4541			{ },
  4542			.fill_helper = NULL,
  4543			.expected_errcode = -EINVAL,
  4544		},
  4545		{
  4546			"check: div_k_0",
  4547			.u.insns = {
  4548				BPF_STMT(BPF_ALU | BPF_DIV | BPF_K, 0),
  4549				BPF_STMT(BPF_RET | BPF_K, 0)
  4550			},
  4551			CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
  4552			{ },
  4553			{ },
  4554			.fill_helper = NULL,
  4555			.expected_errcode = -EINVAL,
  4556		},
  4557		{
  4558			"check: unknown insn",
  4559			.u.insns = {
  4560				/* seccomp insn, rejected in socket filter */
  4561				BPF_STMT(BPF_LDX | BPF_W | BPF_ABS, 0),
  4562				BPF_STMT(BPF_RET | BPF_K, 0)
  4563			},
  4564			CLASSIC | FLAG_EXPECTED_FAIL,
  4565			{ },
  4566			{ },
  4567			.fill_helper = NULL,
  4568			.expected_errcode = -EINVAL,
  4569		},
  4570		{
  4571			"check: out of range spill/fill",
  4572			.u.insns = {
  4573				BPF_STMT(BPF_STX, 16),
  4574				BPF_STMT(BPF_RET | BPF_K, 0)
  4575			},
  4576			CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
  4577			{ },
  4578			{ },
  4579			.fill_helper = NULL,
  4580			.expected_errcode = -EINVAL,
  4581		},
  4582		{
  4583			"JUMPS + HOLES",
  4584			.u.insns = {
  4585				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4586				BPF_JUMP(BPF_JMP | BPF_JGE, 0, 13, 15),
  4587				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4588				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4589				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4590				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4591				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4592				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4593				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4594				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4595				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4596				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4597				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4598				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4599				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4600				BPF_JUMP(BPF_JMP | BPF_JEQ, 0x90c2894d, 3, 4),
  4601				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4602				BPF_JUMP(BPF_JMP | BPF_JEQ, 0x90c2894d, 1, 2),
  4603				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4604				BPF_JUMP(BPF_JMP | BPF_JGE, 0, 14, 15),
  4605				BPF_JUMP(BPF_JMP | BPF_JGE, 0, 13, 14),
  4606				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4607				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4608				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4609				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4610				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4611				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4612				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4613				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4614				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4615				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4616				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4617				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4618				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4619				BPF_JUMP(BPF_JMP | BPF_JEQ, 0x2ac28349, 2, 3),
  4620				BPF_JUMP(BPF_JMP | BPF_JEQ, 0x2ac28349, 1, 2),
  4621				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4622				BPF_JUMP(BPF_JMP | BPF_JGE, 0, 14, 15),
  4623				BPF_JUMP(BPF_JMP | BPF_JGE, 0, 13, 14),
  4624				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4625				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4626				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4627				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4628				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4629				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4630				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4631				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4632				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4633				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4634				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4635				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4636				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4637				BPF_JUMP(BPF_JMP | BPF_JEQ, 0x90d2ff41, 2, 3),
  4638				BPF_JUMP(BPF_JMP | BPF_JEQ, 0x90d2ff41, 1, 2),
  4639				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  4640				BPF_STMT(BPF_RET | BPF_A, 0),
  4641				BPF_STMT(BPF_RET | BPF_A, 0),
  4642			},
  4643			CLASSIC,
  4644			{ 0x00, 0x1b, 0x21, 0x3c, 0x9d, 0xf8,
  4645			  0x90, 0xe2, 0xba, 0x0a, 0x56, 0xb4,
  4646			  0x08, 0x00,
  4647			  0x45, 0x00, 0x00, 0x28, 0x00, 0x00,
  4648			  0x20, 0x00, 0x40, 0x11, 0x00, 0x00, /* IP header */
  4649			  0xc0, 0xa8, 0x33, 0x01,
  4650			  0xc0, 0xa8, 0x33, 0x02,
  4651			  0xbb, 0xb6,
  4652			  0xa9, 0xfa,
  4653			  0x00, 0x14, 0x00, 0x00,
  4654			  0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
  4655			  0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
  4656			  0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
  4657			  0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
  4658			  0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
  4659			  0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
  4660			  0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
  4661			  0xcc, 0xcc, 0xcc, 0xcc },
  4662			{ { 88, 0x001b } }
  4663		},
  4664		{
  4665			"check: RET X",
  4666			.u.insns = {
  4667				BPF_STMT(BPF_RET | BPF_X, 0),
  4668			},
  4669			CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
  4670			{ },
  4671			{ },
  4672			.fill_helper = NULL,
  4673			.expected_errcode = -EINVAL,
  4674		},
  4675		{
  4676			"check: LDX + RET X",
  4677			.u.insns = {
  4678				BPF_STMT(BPF_LDX | BPF_IMM, 42),
  4679				BPF_STMT(BPF_RET | BPF_X, 0),
  4680			},
  4681			CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
  4682			{ },
  4683			{ },
  4684			.fill_helper = NULL,
  4685			.expected_errcode = -EINVAL,
  4686		},
  4687		{	/* Mainly checking JIT here. */
  4688			"M[]: alt STX + LDX",
  4689			.u.insns = {
  4690				BPF_STMT(BPF_LDX | BPF_IMM, 100),
  4691				BPF_STMT(BPF_STX, 0),
  4692				BPF_STMT(BPF_LDX | BPF_MEM, 0),
  4693				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  4694				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  4695				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  4696				BPF_STMT(BPF_STX, 1),
  4697				BPF_STMT(BPF_LDX | BPF_MEM, 1),
  4698				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  4699				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  4700				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  4701				BPF_STMT(BPF_STX, 2),
  4702				BPF_STMT(BPF_LDX | BPF_MEM, 2),
  4703				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  4704				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  4705				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  4706				BPF_STMT(BPF_STX, 3),
  4707				BPF_STMT(BPF_LDX | BPF_MEM, 3),
  4708				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  4709				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  4710				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  4711				BPF_STMT(BPF_STX, 4),
  4712				BPF_STMT(BPF_LDX | BPF_MEM, 4),
  4713				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  4714				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  4715				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  4716				BPF_STMT(BPF_STX, 5),
  4717				BPF_STMT(BPF_LDX | BPF_MEM, 5),
  4718				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  4719				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  4720				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  4721				BPF_STMT(BPF_STX, 6),
  4722				BPF_STMT(BPF_LDX | BPF_MEM, 6),
  4723				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  4724				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  4725				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  4726				BPF_STMT(BPF_STX, 7),
  4727				BPF_STMT(BPF_LDX | BPF_MEM, 7),
  4728				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  4729				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  4730				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  4731				BPF_STMT(BPF_STX, 8),
  4732				BPF_STMT(BPF_LDX | BPF_MEM, 8),
  4733				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  4734				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  4735				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  4736				BPF_STMT(BPF_STX, 9),
  4737				BPF_STMT(BPF_LDX | BPF_MEM, 9),
  4738				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  4739				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  4740				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  4741				BPF_STMT(BPF_STX, 10),
  4742				BPF_STMT(BPF_LDX | BPF_MEM, 10),
  4743				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  4744				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  4745				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  4746				BPF_STMT(BPF_STX, 11),
  4747				BPF_STMT(BPF_LDX | BPF_MEM, 11),
  4748				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  4749				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  4750				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  4751				BPF_STMT(BPF_STX, 12),
  4752				BPF_STMT(BPF_LDX | BPF_MEM, 12),
  4753				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  4754				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  4755				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  4756				BPF_STMT(BPF_STX, 13),
  4757				BPF_STMT(BPF_LDX | BPF_MEM, 13),
  4758				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  4759				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  4760				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  4761				BPF_STMT(BPF_STX, 14),
  4762				BPF_STMT(BPF_LDX | BPF_MEM, 14),
  4763				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  4764				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  4765				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  4766				BPF_STMT(BPF_STX, 15),
  4767				BPF_STMT(BPF_LDX | BPF_MEM, 15),
  4768				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  4769				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  4770				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  4771				BPF_STMT(BPF_RET | BPF_A, 0),
  4772			},
  4773			CLASSIC | FLAG_NO_DATA,
  4774			{ },
  4775			{ { 0, 116 } },
  4776		},
  4777		{	/* Mainly checking JIT here. */
  4778			"M[]: full STX + full LDX",
  4779			.u.insns = {
  4780				BPF_STMT(BPF_LDX | BPF_IMM, 0xbadfeedb),
  4781				BPF_STMT(BPF_STX, 0),
  4782				BPF_STMT(BPF_LDX | BPF_IMM, 0xecabedae),
  4783				BPF_STMT(BPF_STX, 1),
  4784				BPF_STMT(BPF_LDX | BPF_IMM, 0xafccfeaf),
  4785				BPF_STMT(BPF_STX, 2),
  4786				BPF_STMT(BPF_LDX | BPF_IMM, 0xbffdcedc),
  4787				BPF_STMT(BPF_STX, 3),
  4788				BPF_STMT(BPF_LDX | BPF_IMM, 0xfbbbdccb),
  4789				BPF_STMT(BPF_STX, 4),
  4790				BPF_STMT(BPF_LDX | BPF_IMM, 0xfbabcbda),
  4791				BPF_STMT(BPF_STX, 5),
  4792				BPF_STMT(BPF_LDX | BPF_IMM, 0xaedecbdb),
  4793				BPF_STMT(BPF_STX, 6),
  4794				BPF_STMT(BPF_LDX | BPF_IMM, 0xadebbade),
  4795				BPF_STMT(BPF_STX, 7),
  4796				BPF_STMT(BPF_LDX | BPF_IMM, 0xfcfcfaec),
  4797				BPF_STMT(BPF_STX, 8),
  4798				BPF_STMT(BPF_LDX | BPF_IMM, 0xbcdddbdc),
  4799				BPF_STMT(BPF_STX, 9),
  4800				BPF_STMT(BPF_LDX | BPF_IMM, 0xfeefdfac),
  4801				BPF_STMT(BPF_STX, 10),
  4802				BPF_STMT(BPF_LDX | BPF_IMM, 0xcddcdeea),
  4803				BPF_STMT(BPF_STX, 11),
  4804				BPF_STMT(BPF_LDX | BPF_IMM, 0xaccfaebb),
  4805				BPF_STMT(BPF_STX, 12),
  4806				BPF_STMT(BPF_LDX | BPF_IMM, 0xbdcccdcf),
  4807				BPF_STMT(BPF_STX, 13),
  4808				BPF_STMT(BPF_LDX | BPF_IMM, 0xaaedecde),
  4809				BPF_STMT(BPF_STX, 14),
  4810				BPF_STMT(BPF_LDX | BPF_IMM, 0xfaeacdad),
  4811				BPF_STMT(BPF_STX, 15),
  4812				BPF_STMT(BPF_LDX | BPF_MEM, 0),
  4813				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  4814				BPF_STMT(BPF_LDX | BPF_MEM, 1),
  4815				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  4816				BPF_STMT(BPF_LDX | BPF_MEM, 2),
  4817				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  4818				BPF_STMT(BPF_LDX | BPF_MEM, 3),
  4819				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  4820				BPF_STMT(BPF_LDX | BPF_MEM, 4),
  4821				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  4822				BPF_STMT(BPF_LDX | BPF_MEM, 5),
  4823				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  4824				BPF_STMT(BPF_LDX | BPF_MEM, 6),
  4825				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  4826				BPF_STMT(BPF_LDX | BPF_MEM, 7),
  4827				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  4828				BPF_STMT(BPF_LDX | BPF_MEM, 8),
  4829				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  4830				BPF_STMT(BPF_LDX | BPF_MEM, 9),
  4831				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  4832				BPF_STMT(BPF_LDX | BPF_MEM, 10),
  4833				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  4834				BPF_STMT(BPF_LDX | BPF_MEM, 11),
  4835				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  4836				BPF_STMT(BPF_LDX | BPF_MEM, 12),
  4837				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  4838				BPF_STMT(BPF_LDX | BPF_MEM, 13),
  4839				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  4840				BPF_STMT(BPF_LDX | BPF_MEM, 14),
  4841				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  4842				BPF_STMT(BPF_LDX | BPF_MEM, 15),
  4843				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  4844				BPF_STMT(BPF_RET | BPF_A, 0),
  4845			},
  4846			CLASSIC | FLAG_NO_DATA,
  4847			{ },
  4848			{ { 0, 0x2a5a5e5 } },
  4849		},
  4850		{
  4851			"check: SKF_AD_MAX",
  4852			.u.insns = {
  4853				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  4854					 SKF_AD_OFF + SKF_AD_MAX),
  4855				BPF_STMT(BPF_RET | BPF_A, 0),
  4856			},
  4857			CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
  4858			{ },
  4859			{ },
  4860			.fill_helper = NULL,
  4861			.expected_errcode = -EINVAL,
  4862		},
  4863		{	/* Passes checker but fails during runtime. */
  4864			"LD [SKF_AD_OFF-1]",
  4865			.u.insns = {
  4866				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  4867					 SKF_AD_OFF - 1),
  4868				BPF_STMT(BPF_RET | BPF_K, 1),
  4869			},
  4870			CLASSIC,
  4871			{ },
  4872			{ { 1, 0 } },
  4873		},
  4874		{
  4875			"load 64-bit immediate",
  4876			.u.insns_int = {
  4877				BPF_LD_IMM64(R1, 0x567800001234LL),
  4878				BPF_MOV64_REG(R2, R1),
  4879				BPF_MOV64_REG(R3, R2),
  4880				BPF_ALU64_IMM(BPF_RSH, R2, 32),
  4881				BPF_ALU64_IMM(BPF_LSH, R3, 32),
  4882				BPF_ALU64_IMM(BPF_RSH, R3, 32),
  4883				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  4884				BPF_JMP_IMM(BPF_JEQ, R2, 0x5678, 1),
  4885				BPF_EXIT_INSN(),
  4886				BPF_JMP_IMM(BPF_JEQ, R3, 0x1234, 1),
  4887				BPF_EXIT_INSN(),
  4888				BPF_LD_IMM64(R0, 0x1ffffffffLL),
  4889				BPF_ALU64_IMM(BPF_RSH, R0, 32), /* R0 = 1 */
  4890				BPF_EXIT_INSN(),
  4891			},
  4892			INTERNAL,
  4893			{ },
  4894			{ { 0, 1 } }
  4895		},
  4896		/* BPF_ALU | BPF_MOV | BPF_X */
  4897		{
  4898			"ALU_MOV_X: dst = 2",
  4899			.u.insns_int = {
  4900				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  4901				BPF_ALU32_REG(BPF_MOV, R0, R1),
  4902				BPF_EXIT_INSN(),
  4903			},
  4904			INTERNAL,
  4905			{ },
  4906			{ { 0, 2 } },
  4907		},
  4908		{
  4909			"ALU_MOV_X: dst = 4294967295",
  4910			.u.insns_int = {
  4911				BPF_ALU32_IMM(BPF_MOV, R1, 4294967295U),
  4912				BPF_ALU32_REG(BPF_MOV, R0, R1),
  4913				BPF_EXIT_INSN(),
  4914			},
  4915			INTERNAL,
  4916			{ },
  4917			{ { 0, 4294967295U } },
  4918		},
  4919		{
  4920			"ALU64_MOV_X: dst = 2",
  4921			.u.insns_int = {
  4922				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  4923				BPF_ALU64_REG(BPF_MOV, R0, R1),
  4924				BPF_EXIT_INSN(),
  4925			},
  4926			INTERNAL,
  4927			{ },
  4928			{ { 0, 2 } },
  4929		},
  4930		{
  4931			"ALU64_MOV_X: dst = 4294967295",
  4932			.u.insns_int = {
  4933				BPF_ALU32_IMM(BPF_MOV, R1, 4294967295U),
  4934				BPF_ALU64_REG(BPF_MOV, R0, R1),
  4935				BPF_EXIT_INSN(),
  4936			},
  4937			INTERNAL,
  4938			{ },
  4939			{ { 0, 4294967295U } },
  4940		},
  4941		/* BPF_ALU | BPF_MOV | BPF_K */
  4942		{
  4943			"ALU_MOV_K: dst = 2",
  4944			.u.insns_int = {
  4945				BPF_ALU32_IMM(BPF_MOV, R0, 2),
  4946				BPF_EXIT_INSN(),
  4947			},
  4948			INTERNAL,
  4949			{ },
  4950			{ { 0, 2 } },
  4951		},
  4952		{
  4953			"ALU_MOV_K: dst = 4294967295",
  4954			.u.insns_int = {
  4955				BPF_ALU32_IMM(BPF_MOV, R0, 4294967295U),
  4956				BPF_EXIT_INSN(),
  4957			},
  4958			INTERNAL,
  4959			{ },
  4960			{ { 0, 4294967295U } },
  4961		},
  4962		{
  4963			"ALU_MOV_K: 0x0000ffffffff0000 = 0x00000000ffffffff",
  4964			.u.insns_int = {
  4965				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  4966				BPF_LD_IMM64(R3, 0x00000000ffffffffLL),
  4967				BPF_ALU32_IMM(BPF_MOV, R2, 0xffffffff),
  4968				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  4969				BPF_MOV32_IMM(R0, 2),
  4970				BPF_EXIT_INSN(),
  4971				BPF_MOV32_IMM(R0, 1),
  4972				BPF_EXIT_INSN(),
  4973			},
  4974			INTERNAL,
  4975			{ },
  4976			{ { 0, 0x1 } },
  4977		},
  4978		{
  4979			"ALU_MOV_K: small negative",
  4980			.u.insns_int = {
  4981				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  4982				BPF_EXIT_INSN(),
  4983			},
  4984			INTERNAL,
  4985			{ },
  4986			{ { 0, -123 } }
  4987		},
  4988		{
  4989			"ALU_MOV_K: small negative zero extension",
  4990			.u.insns_int = {
  4991				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  4992				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4993				BPF_EXIT_INSN(),
  4994			},
  4995			INTERNAL,
  4996			{ },
  4997			{ { 0, 0 } }
  4998		},
  4999		{
  5000			"ALU_MOV_K: large negative",
  5001			.u.insns_int = {
  5002				BPF_ALU32_IMM(BPF_MOV, R0, -123456789),
  5003				BPF_EXIT_INSN(),
  5004			},
  5005			INTERNAL,
  5006			{ },
  5007			{ { 0, -123456789 } }
  5008		},
  5009		{
  5010			"ALU_MOV_K: large negative zero extension",
  5011			.u.insns_int = {
  5012				BPF_ALU32_IMM(BPF_MOV, R0, -123456789),
  5013				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  5014				BPF_EXIT_INSN(),
  5015			},
  5016			INTERNAL,
  5017			{ },
  5018			{ { 0, 0 } }
  5019		},
  5020		{
  5021			"ALU64_MOV_K: dst = 2",
  5022			.u.insns_int = {
  5023				BPF_ALU64_IMM(BPF_MOV, R0, 2),
  5024				BPF_EXIT_INSN(),
  5025			},
  5026			INTERNAL,
  5027			{ },
  5028			{ { 0, 2 } },
  5029		},
  5030		{
  5031			"ALU64_MOV_K: dst = 2147483647",
  5032			.u.insns_int = {
  5033				BPF_ALU64_IMM(BPF_MOV, R0, 2147483647),
  5034				BPF_EXIT_INSN(),
  5035			},
  5036			INTERNAL,
  5037			{ },
  5038			{ { 0, 2147483647 } },
  5039		},
  5040		{
  5041			"ALU64_OR_K: dst = 0x0",
  5042			.u.insns_int = {
  5043				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  5044				BPF_LD_IMM64(R3, 0x0),
  5045				BPF_ALU64_IMM(BPF_MOV, R2, 0x0),
  5046				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5047				BPF_MOV32_IMM(R0, 2),
  5048				BPF_EXIT_INSN(),
  5049				BPF_MOV32_IMM(R0, 1),
  5050				BPF_EXIT_INSN(),
  5051			},
  5052			INTERNAL,
  5053			{ },
  5054			{ { 0, 0x1 } },
  5055		},
  5056		{
  5057			"ALU64_MOV_K: dst = -1",
  5058			.u.insns_int = {
  5059				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  5060				BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
  5061				BPF_ALU64_IMM(BPF_MOV, R2, 0xffffffff),
  5062				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5063				BPF_MOV32_IMM(R0, 2),
  5064				BPF_EXIT_INSN(),
  5065				BPF_MOV32_IMM(R0, 1),
  5066				BPF_EXIT_INSN(),
  5067			},
  5068			INTERNAL,
  5069			{ },
  5070			{ { 0, 0x1 } },
  5071		},
  5072		{
  5073			"ALU64_MOV_K: small negative",
  5074			.u.insns_int = {
  5075				BPF_ALU64_IMM(BPF_MOV, R0, -123),
  5076				BPF_EXIT_INSN(),
  5077			},
  5078			INTERNAL,
  5079			{ },
  5080			{ { 0, -123 } }
  5081		},
  5082		{
  5083			"ALU64_MOV_K: small negative sign extension",
  5084			.u.insns_int = {
  5085				BPF_ALU64_IMM(BPF_MOV, R0, -123),
  5086				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  5087				BPF_EXIT_INSN(),
  5088			},
  5089			INTERNAL,
  5090			{ },
  5091			{ { 0, 0xffffffff } }
  5092		},
  5093		{
  5094			"ALU64_MOV_K: large negative",
  5095			.u.insns_int = {
  5096				BPF_ALU64_IMM(BPF_MOV, R0, -123456789),
  5097				BPF_EXIT_INSN(),
  5098			},
  5099			INTERNAL,
  5100			{ },
  5101			{ { 0, -123456789 } }
  5102		},
  5103		{
  5104			"ALU64_MOV_K: large negative sign extension",
  5105			.u.insns_int = {
  5106				BPF_ALU64_IMM(BPF_MOV, R0, -123456789),
  5107				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  5108				BPF_EXIT_INSN(),
  5109			},
  5110			INTERNAL,
  5111			{ },
  5112			{ { 0, 0xffffffff } }
  5113		},
  5114		/* MOVSX32 */
  5115		{
  5116			"ALU_MOVSX | BPF_B",
  5117			.u.insns_int = {
  5118				BPF_LD_IMM64(R2, 0x00000000ffffffefLL),
  5119				BPF_LD_IMM64(R3, 0xdeadbeefdeadbeefLL),
  5120				BPF_MOVSX32_REG(R1, R3, 8),
  5121				BPF_JMP_REG(BPF_JEQ, R2, R1, 2),
  5122				BPF_MOV32_IMM(R0, 2),
  5123				BPF_EXIT_INSN(),
  5124				BPF_MOV32_IMM(R0, 1),
  5125				BPF_EXIT_INSN(),
  5126			},
  5127			INTERNAL,
  5128			{ },
  5129			{ { 0, 0x1 } },
  5130		},
  5131		{
  5132			"ALU_MOVSX | BPF_H",
  5133			.u.insns_int = {
  5134				BPF_LD_IMM64(R2, 0x00000000ffffbeefLL),
  5135				BPF_LD_IMM64(R3, 0xdeadbeefdeadbeefLL),
  5136				BPF_MOVSX32_REG(R1, R3, 16),
  5137				BPF_JMP_REG(BPF_JEQ, R2, R1, 2),
  5138				BPF_MOV32_IMM(R0, 2),
  5139				BPF_EXIT_INSN(),
  5140				BPF_MOV32_IMM(R0, 1),
  5141				BPF_EXIT_INSN(),
  5142			},
  5143			INTERNAL,
  5144			{ },
  5145			{ { 0, 0x1 } },
  5146		},
  5147		{
  5148			"ALU_MOVSX | BPF_W",
  5149			.u.insns_int = {
  5150				BPF_LD_IMM64(R2, 0x00000000deadbeefLL),
  5151				BPF_LD_IMM64(R3, 0xdeadbeefdeadbeefLL),
  5152				BPF_MOVSX32_REG(R1, R3, 32),
  5153				BPF_JMP_REG(BPF_JEQ, R2, R1, 2),
  5154				BPF_MOV32_IMM(R0, 2),
  5155				BPF_EXIT_INSN(),
  5156				BPF_MOV32_IMM(R0, 1),
  5157				BPF_EXIT_INSN(),
  5158			},
  5159			INTERNAL,
  5160			{ },
  5161			{ { 0, 0x1 } },
  5162		},
  5163		/* MOVSX64 REG */
  5164		{
  5165			"ALU64_MOVSX | BPF_B",
  5166			.u.insns_int = {
  5167				BPF_LD_IMM64(R2, 0xffffffffffffffefLL),
  5168				BPF_LD_IMM64(R3, 0xdeadbeefdeadbeefLL),
  5169				BPF_MOVSX64_REG(R1, R3, 8),
  5170				BPF_JMP_REG(BPF_JEQ, R2, R1, 2),
  5171				BPF_MOV32_IMM(R0, 2),
  5172				BPF_EXIT_INSN(),
  5173				BPF_MOV32_IMM(R0, 1),
  5174				BPF_EXIT_INSN(),
  5175			},
  5176			INTERNAL,
  5177			{ },
  5178			{ { 0, 0x1 } },
  5179		},
  5180		{
  5181			"ALU64_MOVSX | BPF_H",
  5182			.u.insns_int = {
  5183				BPF_LD_IMM64(R2, 0xffffffffffffbeefLL),
  5184				BPF_LD_IMM64(R3, 0xdeadbeefdeadbeefLL),
  5185				BPF_MOVSX64_REG(R1, R3, 16),
  5186				BPF_JMP_REG(BPF_JEQ, R2, R1, 2),
  5187				BPF_MOV32_IMM(R0, 2),
  5188				BPF_EXIT_INSN(),
  5189				BPF_MOV32_IMM(R0, 1),
  5190				BPF_EXIT_INSN(),
  5191			},
  5192			INTERNAL,
  5193			{ },
  5194			{ { 0, 0x1 } },
  5195		},
  5196		{
  5197			"ALU64_MOVSX | BPF_W",
  5198			.u.insns_int = {
  5199				BPF_LD_IMM64(R2, 0xffffffffdeadbeefLL),
  5200				BPF_LD_IMM64(R3, 0xdeadbeefdeadbeefLL),
  5201				BPF_MOVSX64_REG(R1, R3, 32),
  5202				BPF_JMP_REG(BPF_JEQ, R2, R1, 2),
  5203				BPF_MOV32_IMM(R0, 2),
  5204				BPF_EXIT_INSN(),
  5205				BPF_MOV32_IMM(R0, 1),
  5206				BPF_EXIT_INSN(),
  5207			},
  5208			INTERNAL,
  5209			{ },
  5210			{ { 0, 0x1 } },
  5211		},
  5212		/* BPF_ALU | BPF_ADD | BPF_X */
  5213		{
  5214			"ALU_ADD_X: 1 + 2 = 3",
  5215			.u.insns_int = {
  5216				BPF_LD_IMM64(R0, 1),
  5217				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  5218				BPF_ALU32_REG(BPF_ADD, R0, R1),
  5219				BPF_EXIT_INSN(),
  5220			},
  5221			INTERNAL,
  5222			{ },
  5223			{ { 0, 3 } },
  5224		},
  5225		{
  5226			"ALU_ADD_X: 1 + 4294967294 = 4294967295",
  5227			.u.insns_int = {
  5228				BPF_LD_IMM64(R0, 1),
  5229				BPF_ALU32_IMM(BPF_MOV, R1, 4294967294U),
  5230				BPF_ALU32_REG(BPF_ADD, R0, R1),
  5231				BPF_EXIT_INSN(),
  5232			},
  5233			INTERNAL,
  5234			{ },
  5235			{ { 0, 4294967295U } },
  5236		},
  5237		{
  5238			"ALU_ADD_X: 2 + 4294967294 = 0",
  5239			.u.insns_int = {
  5240				BPF_LD_IMM64(R0, 2),
  5241				BPF_LD_IMM64(R1, 4294967294U),
  5242				BPF_ALU32_REG(BPF_ADD, R0, R1),
  5243				BPF_JMP_IMM(BPF_JEQ, R0, 0, 2),
  5244				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5245				BPF_EXIT_INSN(),
  5246				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  5247				BPF_EXIT_INSN(),
  5248			},
  5249			INTERNAL,
  5250			{ },
  5251			{ { 0, 1 } },
  5252		},
  5253		{
  5254			"ALU64_ADD_X: 1 + 2 = 3",
  5255			.u.insns_int = {
  5256				BPF_LD_IMM64(R0, 1),
  5257				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  5258				BPF_ALU64_REG(BPF_ADD, R0, R1),
  5259				BPF_EXIT_INSN(),
  5260			},
  5261			INTERNAL,
  5262			{ },
  5263			{ { 0, 3 } },
  5264		},
  5265		{
  5266			"ALU64_ADD_X: 1 + 4294967294 = 4294967295",
  5267			.u.insns_int = {
  5268				BPF_LD_IMM64(R0, 1),
  5269				BPF_ALU32_IMM(BPF_MOV, R1, 4294967294U),
  5270				BPF_ALU64_REG(BPF_ADD, R0, R1),
  5271				BPF_EXIT_INSN(),
  5272			},
  5273			INTERNAL,
  5274			{ },
  5275			{ { 0, 4294967295U } },
  5276		},
  5277		{
  5278			"ALU64_ADD_X: 2 + 4294967294 = 4294967296",
  5279			.u.insns_int = {
  5280				BPF_LD_IMM64(R0, 2),
  5281				BPF_LD_IMM64(R1, 4294967294U),
  5282				BPF_LD_IMM64(R2, 4294967296ULL),
  5283				BPF_ALU64_REG(BPF_ADD, R0, R1),
  5284				BPF_JMP_REG(BPF_JEQ, R0, R2, 2),
  5285				BPF_MOV32_IMM(R0, 0),
  5286				BPF_EXIT_INSN(),
  5287				BPF_MOV32_IMM(R0, 1),
  5288				BPF_EXIT_INSN(),
  5289			},
  5290			INTERNAL,
  5291			{ },
  5292			{ { 0, 1 } },
  5293		},
  5294		/* BPF_ALU | BPF_ADD | BPF_K */
  5295		{
  5296			"ALU_ADD_K: 1 + 2 = 3",
  5297			.u.insns_int = {
  5298				BPF_LD_IMM64(R0, 1),
  5299				BPF_ALU32_IMM(BPF_ADD, R0, 2),
  5300				BPF_EXIT_INSN(),
  5301			},
  5302			INTERNAL,
  5303			{ },
  5304			{ { 0, 3 } },
  5305		},
  5306		{
  5307			"ALU_ADD_K: 3 + 0 = 3",
  5308			.u.insns_int = {
  5309				BPF_LD_IMM64(R0, 3),
  5310				BPF_ALU32_IMM(BPF_ADD, R0, 0),
  5311				BPF_EXIT_INSN(),
  5312			},
  5313			INTERNAL,
  5314			{ },
  5315			{ { 0, 3 } },
  5316		},
  5317		{
  5318			"ALU_ADD_K: 1 + 4294967294 = 4294967295",
  5319			.u.insns_int = {
  5320				BPF_LD_IMM64(R0, 1),
  5321				BPF_ALU32_IMM(BPF_ADD, R0, 4294967294U),
  5322				BPF_EXIT_INSN(),
  5323			},
  5324			INTERNAL,
  5325			{ },
  5326			{ { 0, 4294967295U } },
  5327		},
  5328		{
  5329			"ALU_ADD_K: 4294967294 + 2 = 0",
  5330			.u.insns_int = {
  5331				BPF_LD_IMM64(R0, 4294967294U),
  5332				BPF_ALU32_IMM(BPF_ADD, R0, 2),
  5333				BPF_JMP_IMM(BPF_JEQ, R0, 0, 2),
  5334				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5335				BPF_EXIT_INSN(),
  5336				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  5337				BPF_EXIT_INSN(),
  5338			},
  5339			INTERNAL,
  5340			{ },
  5341			{ { 0, 1 } },
  5342		},
  5343		{
  5344			"ALU_ADD_K: 0 + (-1) = 0x00000000ffffffff",
  5345			.u.insns_int = {
  5346				BPF_LD_IMM64(R2, 0x0),
  5347				BPF_LD_IMM64(R3, 0x00000000ffffffff),
  5348				BPF_ALU32_IMM(BPF_ADD, R2, 0xffffffff),
  5349				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5350				BPF_MOV32_IMM(R0, 2),
  5351				BPF_EXIT_INSN(),
  5352				BPF_MOV32_IMM(R0, 1),
  5353				BPF_EXIT_INSN(),
  5354			},
  5355			INTERNAL,
  5356			{ },
  5357			{ { 0, 0x1 } },
  5358		},
  5359		{
  5360			"ALU_ADD_K: 0 + 0xffff = 0xffff",
  5361			.u.insns_int = {
  5362				BPF_LD_IMM64(R2, 0x0),
  5363				BPF_LD_IMM64(R3, 0xffff),
  5364				BPF_ALU32_IMM(BPF_ADD, R2, 0xffff),
  5365				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5366				BPF_MOV32_IMM(R0, 2),
  5367				BPF_EXIT_INSN(),
  5368				BPF_MOV32_IMM(R0, 1),
  5369				BPF_EXIT_INSN(),
  5370			},
  5371			INTERNAL,
  5372			{ },
  5373			{ { 0, 0x1 } },
  5374		},
  5375		{
  5376			"ALU_ADD_K: 0 + 0x7fffffff = 0x7fffffff",
  5377			.u.insns_int = {
  5378				BPF_LD_IMM64(R2, 0x0),
  5379				BPF_LD_IMM64(R3, 0x7fffffff),
  5380				BPF_ALU32_IMM(BPF_ADD, R2, 0x7fffffff),
  5381				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5382				BPF_MOV32_IMM(R0, 2),
  5383				BPF_EXIT_INSN(),
  5384				BPF_MOV32_IMM(R0, 1),
  5385				BPF_EXIT_INSN(),
  5386			},
  5387			INTERNAL,
  5388			{ },
  5389			{ { 0, 0x1 } },
  5390		},
  5391		{
  5392			"ALU_ADD_K: 0 + 0x80000000 = 0x80000000",
  5393			.u.insns_int = {
  5394				BPF_LD_IMM64(R2, 0x0),
  5395				BPF_LD_IMM64(R3, 0x80000000),
  5396				BPF_ALU32_IMM(BPF_ADD, R2, 0x80000000),
  5397				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5398				BPF_MOV32_IMM(R0, 2),
  5399				BPF_EXIT_INSN(),
  5400				BPF_MOV32_IMM(R0, 1),
  5401				BPF_EXIT_INSN(),
  5402			},
  5403			INTERNAL,
  5404			{ },
  5405			{ { 0, 0x1 } },
  5406		},
  5407		{
  5408			"ALU_ADD_K: 0 + 0x80008000 = 0x80008000",
  5409			.u.insns_int = {
  5410				BPF_LD_IMM64(R2, 0x0),
  5411				BPF_LD_IMM64(R3, 0x80008000),
  5412				BPF_ALU32_IMM(BPF_ADD, R2, 0x80008000),
  5413				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5414				BPF_MOV32_IMM(R0, 2),
  5415				BPF_EXIT_INSN(),
  5416				BPF_MOV32_IMM(R0, 1),
  5417				BPF_EXIT_INSN(),
  5418			},
  5419			INTERNAL,
  5420			{ },
  5421			{ { 0, 0x1 } },
  5422		},
  5423		{
  5424			"ALU64_ADD_K: 1 + 2 = 3",
  5425			.u.insns_int = {
  5426				BPF_LD_IMM64(R0, 1),
  5427				BPF_ALU64_IMM(BPF_ADD, R0, 2),
  5428				BPF_EXIT_INSN(),
  5429			},
  5430			INTERNAL,
  5431			{ },
  5432			{ { 0, 3 } },
  5433		},
  5434		{
  5435			"ALU64_ADD_K: 3 + 0 = 3",
  5436			.u.insns_int = {
  5437				BPF_LD_IMM64(R0, 3),
  5438				BPF_ALU64_IMM(BPF_ADD, R0, 0),
  5439				BPF_EXIT_INSN(),
  5440			},
  5441			INTERNAL,
  5442			{ },
  5443			{ { 0, 3 } },
  5444		},
  5445		{
  5446			"ALU64_ADD_K: 1 + 2147483646 = 2147483647",
  5447			.u.insns_int = {
  5448				BPF_LD_IMM64(R0, 1),
  5449				BPF_ALU64_IMM(BPF_ADD, R0, 2147483646),
  5450				BPF_EXIT_INSN(),
  5451			},
  5452			INTERNAL,
  5453			{ },
  5454			{ { 0, 2147483647 } },
  5455		},
  5456		{
  5457			"ALU64_ADD_K: 4294967294 + 2 = 4294967296",
  5458			.u.insns_int = {
  5459				BPF_LD_IMM64(R0, 4294967294U),
  5460				BPF_LD_IMM64(R1, 4294967296ULL),
  5461				BPF_ALU64_IMM(BPF_ADD, R0, 2),
  5462				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  5463				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5464				BPF_EXIT_INSN(),
  5465				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  5466				BPF_EXIT_INSN(),
  5467			},
  5468			INTERNAL,
  5469			{ },
  5470			{ { 0, 1 } },
  5471		},
  5472		{
  5473			"ALU64_ADD_K: 2147483646 + -2147483647 = -1",
  5474			.u.insns_int = {
  5475				BPF_LD_IMM64(R0, 2147483646),
  5476				BPF_ALU64_IMM(BPF_ADD, R0, -2147483647),
  5477				BPF_EXIT_INSN(),
  5478			},
  5479			INTERNAL,
  5480			{ },
  5481			{ { 0, -1 } },
  5482		},
  5483		{
  5484			"ALU64_ADD_K: 1 + 0 = 1",
  5485			.u.insns_int = {
  5486				BPF_LD_IMM64(R2, 0x1),
  5487				BPF_LD_IMM64(R3, 0x1),
  5488				BPF_ALU64_IMM(BPF_ADD, R2, 0x0),
  5489				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5490				BPF_MOV32_IMM(R0, 2),
  5491				BPF_EXIT_INSN(),
  5492				BPF_MOV32_IMM(R0, 1),
  5493				BPF_EXIT_INSN(),
  5494			},
  5495			INTERNAL,
  5496			{ },
  5497			{ { 0, 0x1 } },
  5498		},
  5499		{
  5500			"ALU64_ADD_K: 0 + (-1) = 0xffffffffffffffff",
  5501			.u.insns_int = {
  5502				BPF_LD_IMM64(R2, 0x0),
  5503				BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
  5504				BPF_ALU64_IMM(BPF_ADD, R2, 0xffffffff),
  5505				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5506				BPF_MOV32_IMM(R0, 2),
  5507				BPF_EXIT_INSN(),
  5508				BPF_MOV32_IMM(R0, 1),
  5509				BPF_EXIT_INSN(),
  5510			},
  5511			INTERNAL,
  5512			{ },
  5513			{ { 0, 0x1 } },
  5514		},
  5515		{
  5516			"ALU64_ADD_K: 0 + 0xffff = 0xffff",
  5517			.u.insns_int = {
  5518				BPF_LD_IMM64(R2, 0x0),
  5519				BPF_LD_IMM64(R3, 0xffff),
  5520				BPF_ALU64_IMM(BPF_ADD, R2, 0xffff),
  5521				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5522				BPF_MOV32_IMM(R0, 2),
  5523				BPF_EXIT_INSN(),
  5524				BPF_MOV32_IMM(R0, 1),
  5525				BPF_EXIT_INSN(),
  5526			},
  5527			INTERNAL,
  5528			{ },
  5529			{ { 0, 0x1 } },
  5530		},
  5531		{
  5532			"ALU64_ADD_K: 0 + 0x7fffffff = 0x7fffffff",
  5533			.u.insns_int = {
  5534				BPF_LD_IMM64(R2, 0x0),
  5535				BPF_LD_IMM64(R3, 0x7fffffff),
  5536				BPF_ALU64_IMM(BPF_ADD, R2, 0x7fffffff),
  5537				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5538				BPF_MOV32_IMM(R0, 2),
  5539				BPF_EXIT_INSN(),
  5540				BPF_MOV32_IMM(R0, 1),
  5541				BPF_EXIT_INSN(),
  5542			},
  5543			INTERNAL,
  5544			{ },
  5545			{ { 0, 0x1 } },
  5546		},
  5547		{
  5548			"ALU64_ADD_K: 0 + 0x80000000 = 0xffffffff80000000",
  5549			.u.insns_int = {
  5550				BPF_LD_IMM64(R2, 0x0),
  5551				BPF_LD_IMM64(R3, 0xffffffff80000000LL),
  5552				BPF_ALU64_IMM(BPF_ADD, R2, 0x80000000),
  5553				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5554				BPF_MOV32_IMM(R0, 2),
  5555				BPF_EXIT_INSN(),
  5556				BPF_MOV32_IMM(R0, 1),
  5557				BPF_EXIT_INSN(),
  5558			},
  5559			INTERNAL,
  5560			{ },
  5561			{ { 0, 0x1 } },
  5562		},
  5563		{
  5564			"ALU_ADD_K: 0 + 0x80008000 = 0xffffffff80008000",
  5565			.u.insns_int = {
  5566				BPF_LD_IMM64(R2, 0x0),
  5567				BPF_LD_IMM64(R3, 0xffffffff80008000LL),
  5568				BPF_ALU64_IMM(BPF_ADD, R2, 0x80008000),
  5569				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5570				BPF_MOV32_IMM(R0, 2),
  5571				BPF_EXIT_INSN(),
  5572				BPF_MOV32_IMM(R0, 1),
  5573				BPF_EXIT_INSN(),
  5574			},
  5575			INTERNAL,
  5576			{ },
  5577			{ { 0, 0x1 } },
  5578		},
  5579		/* BPF_ALU | BPF_SUB | BPF_X */
  5580		{
  5581			"ALU_SUB_X: 3 - 1 = 2",
  5582			.u.insns_int = {
  5583				BPF_LD_IMM64(R0, 3),
  5584				BPF_ALU32_IMM(BPF_MOV, R1, 1),
  5585				BPF_ALU32_REG(BPF_SUB, R0, R1),
  5586				BPF_EXIT_INSN(),
  5587			},
  5588			INTERNAL,
  5589			{ },
  5590			{ { 0, 2 } },
  5591		},
  5592		{
  5593			"ALU_SUB_X: 4294967295 - 4294967294 = 1",
  5594			.u.insns_int = {
  5595				BPF_LD_IMM64(R0, 4294967295U),
  5596				BPF_ALU32_IMM(BPF_MOV, R1, 4294967294U),
  5597				BPF_ALU32_REG(BPF_SUB, R0, R1),
  5598				BPF_EXIT_INSN(),
  5599			},
  5600			INTERNAL,
  5601			{ },
  5602			{ { 0, 1 } },
  5603		},
  5604		{
  5605			"ALU64_SUB_X: 3 - 1 = 2",
  5606			.u.insns_int = {
  5607				BPF_LD_IMM64(R0, 3),
  5608				BPF_ALU32_IMM(BPF_MOV, R1, 1),
  5609				BPF_ALU64_REG(BPF_SUB, R0, R1),
  5610				BPF_EXIT_INSN(),
  5611			},
  5612			INTERNAL,
  5613			{ },
  5614			{ { 0, 2 } },
  5615		},
  5616		{
  5617			"ALU64_SUB_X: 4294967295 - 4294967294 = 1",
  5618			.u.insns_int = {
  5619				BPF_LD_IMM64(R0, 4294967295U),
  5620				BPF_ALU32_IMM(BPF_MOV, R1, 4294967294U),
  5621				BPF_ALU64_REG(BPF_SUB, R0, R1),
  5622				BPF_EXIT_INSN(),
  5623			},
  5624			INTERNAL,
  5625			{ },
  5626			{ { 0, 1 } },
  5627		},
  5628		/* BPF_ALU | BPF_SUB | BPF_K */
  5629		{
  5630			"ALU_SUB_K: 3 - 1 = 2",
  5631			.u.insns_int = {
  5632				BPF_LD_IMM64(R0, 3),
  5633				BPF_ALU32_IMM(BPF_SUB, R0, 1),
  5634				BPF_EXIT_INSN(),
  5635			},
  5636			INTERNAL,
  5637			{ },
  5638			{ { 0, 2 } },
  5639		},
  5640		{
  5641			"ALU_SUB_K: 3 - 0 = 3",
  5642			.u.insns_int = {
  5643				BPF_LD_IMM64(R0, 3),
  5644				BPF_ALU32_IMM(BPF_SUB, R0, 0),
  5645				BPF_EXIT_INSN(),
  5646			},
  5647			INTERNAL,
  5648			{ },
  5649			{ { 0, 3 } },
  5650		},
  5651		{
  5652			"ALU_SUB_K: 4294967295 - 4294967294 = 1",
  5653			.u.insns_int = {
  5654				BPF_LD_IMM64(R0, 4294967295U),
  5655				BPF_ALU32_IMM(BPF_SUB, R0, 4294967294U),
  5656				BPF_EXIT_INSN(),
  5657			},
  5658			INTERNAL,
  5659			{ },
  5660			{ { 0, 1 } },
  5661		},
  5662		{
  5663			"ALU64_SUB_K: 3 - 1 = 2",
  5664			.u.insns_int = {
  5665				BPF_LD_IMM64(R0, 3),
  5666				BPF_ALU64_IMM(BPF_SUB, R0, 1),
  5667				BPF_EXIT_INSN(),
  5668			},
  5669			INTERNAL,
  5670			{ },
  5671			{ { 0, 2 } },
  5672		},
  5673		{
  5674			"ALU64_SUB_K: 3 - 0 = 3",
  5675			.u.insns_int = {
  5676				BPF_LD_IMM64(R0, 3),
  5677				BPF_ALU64_IMM(BPF_SUB, R0, 0),
  5678				BPF_EXIT_INSN(),
  5679			},
  5680			INTERNAL,
  5681			{ },
  5682			{ { 0, 3 } },
  5683		},
  5684		{
  5685			"ALU64_SUB_K: 4294967294 - 4294967295 = -1",
  5686			.u.insns_int = {
  5687				BPF_LD_IMM64(R0, 4294967294U),
  5688				BPF_ALU64_IMM(BPF_SUB, R0, 4294967295U),
  5689				BPF_EXIT_INSN(),
  5690			},
  5691			INTERNAL,
  5692			{ },
  5693			{ { 0, -1 } },
  5694		},
  5695		{
  5696			"ALU64_ADD_K: 2147483646 - 2147483647 = -1",
  5697			.u.insns_int = {
  5698				BPF_LD_IMM64(R0, 2147483646),
  5699				BPF_ALU64_IMM(BPF_SUB, R0, 2147483647),
  5700				BPF_EXIT_INSN(),
  5701			},
  5702			INTERNAL,
  5703			{ },
  5704			{ { 0, -1 } },
  5705		},
  5706		/* BPF_ALU | BPF_MUL | BPF_X */
  5707		{
  5708			"ALU_MUL_X: 2 * 3 = 6",
  5709			.u.insns_int = {
  5710				BPF_LD_IMM64(R0, 2),
  5711				BPF_ALU32_IMM(BPF_MOV, R1, 3),
  5712				BPF_ALU32_REG(BPF_MUL, R0, R1),
  5713				BPF_EXIT_INSN(),
  5714			},
  5715			INTERNAL,
  5716			{ },
  5717			{ { 0, 6 } },
  5718		},
  5719		{
  5720			"ALU_MUL_X: 2 * 0x7FFFFFF8 = 0xFFFFFFF0",
  5721			.u.insns_int = {
  5722				BPF_LD_IMM64(R0, 2),
  5723				BPF_ALU32_IMM(BPF_MOV, R1, 0x7FFFFFF8),
  5724				BPF_ALU32_REG(BPF_MUL, R0, R1),
  5725				BPF_EXIT_INSN(),
  5726			},
  5727			INTERNAL,
  5728			{ },
  5729			{ { 0, 0xFFFFFFF0 } },
  5730		},
  5731		{
  5732			"ALU_MUL_X: -1 * -1 = 1",
  5733			.u.insns_int = {
  5734				BPF_LD_IMM64(R0, -1),
  5735				BPF_ALU32_IMM(BPF_MOV, R1, -1),
  5736				BPF_ALU32_REG(BPF_MUL, R0, R1),
  5737				BPF_EXIT_INSN(),
  5738			},
  5739			INTERNAL,
  5740			{ },
  5741			{ { 0, 1 } },
  5742		},
  5743		{
  5744			"ALU64_MUL_X: 2 * 3 = 6",
  5745			.u.insns_int = {
  5746				BPF_LD_IMM64(R0, 2),
  5747				BPF_ALU32_IMM(BPF_MOV, R1, 3),
  5748				BPF_ALU64_REG(BPF_MUL, R0, R1),
  5749				BPF_EXIT_INSN(),
  5750			},
  5751			INTERNAL,
  5752			{ },
  5753			{ { 0, 6 } },
  5754		},
  5755		{
  5756			"ALU64_MUL_X: 1 * 2147483647 = 2147483647",
  5757			.u.insns_int = {
  5758				BPF_LD_IMM64(R0, 1),
  5759				BPF_ALU32_IMM(BPF_MOV, R1, 2147483647),
  5760				BPF_ALU64_REG(BPF_MUL, R0, R1),
  5761				BPF_EXIT_INSN(),
  5762			},
  5763			INTERNAL,
  5764			{ },
  5765			{ { 0, 2147483647 } },
  5766		},
  5767		{
  5768			"ALU64_MUL_X: 64x64 multiply, low word",
  5769			.u.insns_int = {
  5770				BPF_LD_IMM64(R0, 0x0fedcba987654321LL),
  5771				BPF_LD_IMM64(R1, 0x123456789abcdef0LL),
  5772				BPF_ALU64_REG(BPF_MUL, R0, R1),
  5773				BPF_EXIT_INSN(),
  5774			},
  5775			INTERNAL,
  5776			{ },
  5777			{ { 0, 0xe5618cf0 } }
  5778		},
  5779		{
  5780			"ALU64_MUL_X: 64x64 multiply, high word",
  5781			.u.insns_int = {
  5782				BPF_LD_IMM64(R0, 0x0fedcba987654321LL),
  5783				BPF_LD_IMM64(R1, 0x123456789abcdef0LL),
  5784				BPF_ALU64_REG(BPF_MUL, R0, R1),
  5785				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  5786				BPF_EXIT_INSN(),
  5787			},
  5788			INTERNAL,
  5789			{ },
  5790			{ { 0, 0x2236d88f } }
  5791		},
  5792		/* BPF_ALU | BPF_MUL | BPF_K */
  5793		{
  5794			"ALU_MUL_K: 2 * 3 = 6",
  5795			.u.insns_int = {
  5796				BPF_LD_IMM64(R0, 2),
  5797				BPF_ALU32_IMM(BPF_MUL, R0, 3),
  5798				BPF_EXIT_INSN(),
  5799			},
  5800			INTERNAL,
  5801			{ },
  5802			{ { 0, 6 } },
  5803		},
  5804		{
  5805			"ALU_MUL_K: 3 * 1 = 3",
  5806			.u.insns_int = {
  5807				BPF_LD_IMM64(R0, 3),
  5808				BPF_ALU32_IMM(BPF_MUL, R0, 1),
  5809				BPF_EXIT_INSN(),
  5810			},
  5811			INTERNAL,
  5812			{ },
  5813			{ { 0, 3 } },
  5814		},
  5815		{
  5816			"ALU_MUL_K: 2 * 0x7FFFFFF8 = 0xFFFFFFF0",
  5817			.u.insns_int = {
  5818				BPF_LD_IMM64(R0, 2),
  5819				BPF_ALU32_IMM(BPF_MUL, R0, 0x7FFFFFF8),
  5820				BPF_EXIT_INSN(),
  5821			},
  5822			INTERNAL,
  5823			{ },
  5824			{ { 0, 0xFFFFFFF0 } },
  5825		},
  5826		{
  5827			"ALU_MUL_K: 1 * (-1) = 0x00000000ffffffff",
  5828			.u.insns_int = {
  5829				BPF_LD_IMM64(R2, 0x1),
  5830				BPF_LD_IMM64(R3, 0x00000000ffffffff),
  5831				BPF_ALU32_IMM(BPF_MUL, R2, 0xffffffff),
  5832				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5833				BPF_MOV32_IMM(R0, 2),
  5834				BPF_EXIT_INSN(),
  5835				BPF_MOV32_IMM(R0, 1),
  5836				BPF_EXIT_INSN(),
  5837			},
  5838			INTERNAL,
  5839			{ },
  5840			{ { 0, 0x1 } },
  5841		},
  5842		{
  5843			"ALU64_MUL_K: 2 * 3 = 6",
  5844			.u.insns_int = {
  5845				BPF_LD_IMM64(R0, 2),
  5846				BPF_ALU64_IMM(BPF_MUL, R0, 3),
  5847				BPF_EXIT_INSN(),
  5848			},
  5849			INTERNAL,
  5850			{ },
  5851			{ { 0, 6 } },
  5852		},
  5853		{
  5854			"ALU64_MUL_K: 3 * 1 = 3",
  5855			.u.insns_int = {
  5856				BPF_LD_IMM64(R0, 3),
  5857				BPF_ALU64_IMM(BPF_MUL, R0, 1),
  5858				BPF_EXIT_INSN(),
  5859			},
  5860			INTERNAL,
  5861			{ },
  5862			{ { 0, 3 } },
  5863		},
  5864		{
  5865			"ALU64_MUL_K: 1 * 2147483647 = 2147483647",
  5866			.u.insns_int = {
  5867				BPF_LD_IMM64(R0, 1),
  5868				BPF_ALU64_IMM(BPF_MUL, R0, 2147483647),
  5869				BPF_EXIT_INSN(),
  5870			},
  5871			INTERNAL,
  5872			{ },
  5873			{ { 0, 2147483647 } },
  5874		},
  5875		{
  5876			"ALU64_MUL_K: 1 * -2147483647 = -2147483647",
  5877			.u.insns_int = {
  5878				BPF_LD_IMM64(R0, 1),
  5879				BPF_ALU64_IMM(BPF_MUL, R0, -2147483647),
  5880				BPF_EXIT_INSN(),
  5881			},
  5882			INTERNAL,
  5883			{ },
  5884			{ { 0, -2147483647 } },
  5885		},
  5886		{
  5887			"ALU64_MUL_K: 1 * (-1) = 0xffffffffffffffff",
  5888			.u.insns_int = {
  5889				BPF_LD_IMM64(R2, 0x1),
  5890				BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
  5891				BPF_ALU64_IMM(BPF_MUL, R2, 0xffffffff),
  5892				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5893				BPF_MOV32_IMM(R0, 2),
  5894				BPF_EXIT_INSN(),
  5895				BPF_MOV32_IMM(R0, 1),
  5896				BPF_EXIT_INSN(),
  5897			},
  5898			INTERNAL,
  5899			{ },
  5900			{ { 0, 0x1 } },
  5901		},
  5902		{
  5903			"ALU64_MUL_K: 64x32 multiply, low word",
  5904			.u.insns_int = {
  5905				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  5906				BPF_ALU64_IMM(BPF_MUL, R0, 0x12345678),
  5907				BPF_EXIT_INSN(),
  5908			},
  5909			INTERNAL,
  5910			{ },
  5911			{ { 0, 0xe242d208 } }
  5912		},
  5913		{
  5914			"ALU64_MUL_K: 64x32 multiply, high word",
  5915			.u.insns_int = {
  5916				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  5917				BPF_ALU64_IMM(BPF_MUL, R0, 0x12345678),
  5918				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  5919				BPF_EXIT_INSN(),
  5920			},
  5921			INTERNAL,
  5922			{ },
  5923			{ { 0, 0xc28f5c28 } }
  5924		},
  5925		/* BPF_ALU | BPF_DIV | BPF_X */
  5926		{
  5927			"ALU_DIV_X: 6 / 2 = 3",
  5928			.u.insns_int = {
  5929				BPF_LD_IMM64(R0, 6),
  5930				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  5931				BPF_ALU32_REG(BPF_DIV, R0, R1),
  5932				BPF_EXIT_INSN(),
  5933			},
  5934			INTERNAL,
  5935			{ },
  5936			{ { 0, 3 } },
  5937		},
  5938		{
  5939			"ALU_DIV_X: 4294967295 / 4294967295 = 1",
  5940			.u.insns_int = {
  5941				BPF_LD_IMM64(R0, 4294967295U),
  5942				BPF_ALU32_IMM(BPF_MOV, R1, 4294967295U),
  5943				BPF_ALU32_REG(BPF_DIV, R0, R1),
  5944				BPF_EXIT_INSN(),
  5945			},
  5946			INTERNAL,
  5947			{ },
  5948			{ { 0, 1 } },
  5949		},
  5950		{
  5951			"ALU64_DIV_X: 6 / 2 = 3",
  5952			.u.insns_int = {
  5953				BPF_LD_IMM64(R0, 6),
  5954				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  5955				BPF_ALU64_REG(BPF_DIV, R0, R1),
  5956				BPF_EXIT_INSN(),
  5957			},
  5958			INTERNAL,
  5959			{ },
  5960			{ { 0, 3 } },
  5961		},
  5962		{
  5963			"ALU64_DIV_X: 2147483647 / 2147483647 = 1",
  5964			.u.insns_int = {
  5965				BPF_LD_IMM64(R0, 2147483647),
  5966				BPF_ALU32_IMM(BPF_MOV, R1, 2147483647),
  5967				BPF_ALU64_REG(BPF_DIV, R0, R1),
  5968				BPF_EXIT_INSN(),
  5969			},
  5970			INTERNAL,
  5971			{ },
  5972			{ { 0, 1 } },
  5973		},
  5974		{
  5975			"ALU64_DIV_X: 0xffffffffffffffff / (-1) = 0x0000000000000001",
  5976			.u.insns_int = {
  5977				BPF_LD_IMM64(R2, 0xffffffffffffffffLL),
  5978				BPF_LD_IMM64(R4, 0xffffffffffffffffLL),
  5979				BPF_LD_IMM64(R3, 0x0000000000000001LL),
  5980				BPF_ALU64_REG(BPF_DIV, R2, R4),
  5981				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5982				BPF_MOV32_IMM(R0, 2),
  5983				BPF_EXIT_INSN(),
  5984				BPF_MOV32_IMM(R0, 1),
  5985				BPF_EXIT_INSN(),
  5986			},
  5987			INTERNAL,
  5988			{ },
  5989			{ { 0, 0x1 } },
  5990		},
  5991		/* BPF_ALU | BPF_DIV | BPF_K */
  5992		{
  5993			"ALU_DIV_K: 6 / 2 = 3",
  5994			.u.insns_int = {
  5995				BPF_LD_IMM64(R0, 6),
  5996				BPF_ALU32_IMM(BPF_DIV, R0, 2),
  5997				BPF_EXIT_INSN(),
  5998			},
  5999			INTERNAL,
  6000			{ },
  6001			{ { 0, 3 } },
  6002		},
  6003		{
  6004			"ALU_DIV_K: 3 / 1 = 3",
  6005			.u.insns_int = {
  6006				BPF_LD_IMM64(R0, 3),
  6007				BPF_ALU32_IMM(BPF_DIV, R0, 1),
  6008				BPF_EXIT_INSN(),
  6009			},
  6010			INTERNAL,
  6011			{ },
  6012			{ { 0, 3 } },
  6013		},
  6014		{
  6015			"ALU_DIV_K: 4294967295 / 4294967295 = 1",
  6016			.u.insns_int = {
  6017				BPF_LD_IMM64(R0, 4294967295U),
  6018				BPF_ALU32_IMM(BPF_DIV, R0, 4294967295U),
  6019				BPF_EXIT_INSN(),
  6020			},
  6021			INTERNAL,
  6022			{ },
  6023			{ { 0, 1 } },
  6024		},
  6025		{
  6026			"ALU_DIV_K: 0xffffffffffffffff / (-1) = 0x1",
  6027			.u.insns_int = {
  6028				BPF_LD_IMM64(R2, 0xffffffffffffffffLL),
  6029				BPF_LD_IMM64(R3, 0x1UL),
  6030				BPF_ALU32_IMM(BPF_DIV, R2, 0xffffffff),
  6031				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  6032				BPF_MOV32_IMM(R0, 2),
  6033				BPF_EXIT_INSN(),
  6034				BPF_MOV32_IMM(R0, 1),
  6035				BPF_EXIT_INSN(),
  6036			},
  6037			INTERNAL,
  6038			{ },
  6039			{ { 0, 0x1 } },
  6040		},
  6041		{
  6042			"ALU64_DIV_K: 6 / 2 = 3",
  6043			.u.insns_int = {
  6044				BPF_LD_IMM64(R0, 6),
  6045				BPF_ALU64_IMM(BPF_DIV, R0, 2),
  6046				BPF_EXIT_INSN(),
  6047			},
  6048			INTERNAL,
  6049			{ },
  6050			{ { 0, 3 } },
  6051		},
  6052		{
  6053			"ALU64_DIV_K: 3 / 1 = 3",
  6054			.u.insns_int = {
  6055				BPF_LD_IMM64(R0, 3),
  6056				BPF_ALU64_IMM(BPF_DIV, R0, 1),
  6057				BPF_EXIT_INSN(),
  6058			},
  6059			INTERNAL,
  6060			{ },
  6061			{ { 0, 3 } },
  6062		},
  6063		{
  6064			"ALU64_DIV_K: 2147483647 / 2147483647 = 1",
  6065			.u.insns_int = {
  6066				BPF_LD_IMM64(R0, 2147483647),
  6067				BPF_ALU64_IMM(BPF_DIV, R0, 2147483647),
  6068				BPF_EXIT_INSN(),
  6069			},
  6070			INTERNAL,
  6071			{ },
  6072			{ { 0, 1 } },
  6073		},
  6074		{
  6075			"ALU64_DIV_K: 0xffffffffffffffff / (-1) = 0x0000000000000001",
  6076			.u.insns_int = {
  6077				BPF_LD_IMM64(R2, 0xffffffffffffffffLL),
  6078				BPF_LD_IMM64(R3, 0x0000000000000001LL),
  6079				BPF_ALU64_IMM(BPF_DIV, R2, 0xffffffff),
  6080				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  6081				BPF_MOV32_IMM(R0, 2),
  6082				BPF_EXIT_INSN(),
  6083				BPF_MOV32_IMM(R0, 1),
  6084				BPF_EXIT_INSN(),
  6085			},
  6086			INTERNAL,
  6087			{ },
  6088			{ { 0, 0x1 } },
  6089		},
  6090		/* BPF_ALU | BPF_MOD | BPF_X */
  6091		{
  6092			"ALU_MOD_X: 3 % 2 = 1",
  6093			.u.insns_int = {
  6094				BPF_LD_IMM64(R0, 3),
  6095				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  6096				BPF_ALU32_REG(BPF_MOD, R0, R1),
  6097				BPF_EXIT_INSN(),
  6098			},
  6099			INTERNAL,
  6100			{ },
  6101			{ { 0, 1 } },
  6102		},
  6103		{
  6104			"ALU_MOD_X: 4294967295 % 4294967293 = 2",
  6105			.u.insns_int = {
  6106				BPF_LD_IMM64(R0, 4294967295U),
  6107				BPF_ALU32_IMM(BPF_MOV, R1, 4294967293U),
  6108				BPF_ALU32_REG(BPF_MOD, R0, R1),
  6109				BPF_EXIT_INSN(),
  6110			},
  6111			INTERNAL,
  6112			{ },
  6113			{ { 0, 2 } },
  6114		},
  6115		{
  6116			"ALU64_MOD_X: 3 % 2 = 1",
  6117			.u.insns_int = {
  6118				BPF_LD_IMM64(R0, 3),
  6119				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  6120				BPF_ALU64_REG(BPF_MOD, R0, R1),
  6121				BPF_EXIT_INSN(),
  6122			},
  6123			INTERNAL,
  6124			{ },
  6125			{ { 0, 1 } },
  6126		},
  6127		{
  6128			"ALU64_MOD_X: 2147483647 % 2147483645 = 2",
  6129			.u.insns_int = {
  6130				BPF_LD_IMM64(R0, 2147483647),
  6131				BPF_ALU32_IMM(BPF_MOV, R1, 2147483645),
  6132				BPF_ALU64_REG(BPF_MOD, R0, R1),
  6133				BPF_EXIT_INSN(),
  6134			},
  6135			INTERNAL,
  6136			{ },
  6137			{ { 0, 2 } },
  6138		},
  6139		/* BPF_ALU | BPF_MOD | BPF_K */
  6140		{
  6141			"ALU_MOD_K: 3 % 2 = 1",
  6142			.u.insns_int = {
  6143				BPF_LD_IMM64(R0, 3),
  6144				BPF_ALU32_IMM(BPF_MOD, R0, 2),
  6145				BPF_EXIT_INSN(),
  6146			},
  6147			INTERNAL,
  6148			{ },
  6149			{ { 0, 1 } },
  6150		},
  6151		{
  6152			"ALU_MOD_K: 3 % 1 = 0",
  6153			.u.insns_int = {
  6154				BPF_LD_IMM64(R0, 3),
  6155				BPF_ALU32_IMM(BPF_MOD, R0, 1),
  6156				BPF_EXIT_INSN(),
  6157			},
  6158			INTERNAL,
  6159			{ },
  6160			{ { 0, 0 } },
  6161		},
  6162		{
  6163			"ALU_MOD_K: 4294967295 % 4294967293 = 2",
  6164			.u.insns_int = {
  6165				BPF_LD_IMM64(R0, 4294967295U),
  6166				BPF_ALU32_IMM(BPF_MOD, R0, 4294967293U),
  6167				BPF_EXIT_INSN(),
  6168			},
  6169			INTERNAL,
  6170			{ },
  6171			{ { 0, 2 } },
  6172		},
  6173		{
  6174			"ALU64_MOD_K: 3 % 2 = 1",
  6175			.u.insns_int = {
  6176				BPF_LD_IMM64(R0, 3),
  6177				BPF_ALU64_IMM(BPF_MOD, R0, 2),
  6178				BPF_EXIT_INSN(),
  6179			},
  6180			INTERNAL,
  6181			{ },
  6182			{ { 0, 1 } },
  6183		},
  6184		{
  6185			"ALU64_MOD_K: 3 % 1 = 0",
  6186			.u.insns_int = {
  6187				BPF_LD_IMM64(R0, 3),
  6188				BPF_ALU64_IMM(BPF_MOD, R0, 1),
  6189				BPF_EXIT_INSN(),
  6190			},
  6191			INTERNAL,
  6192			{ },
  6193			{ { 0, 0 } },
  6194		},
  6195		{
  6196			"ALU64_MOD_K: 2147483647 % 2147483645 = 2",
  6197			.u.insns_int = {
  6198				BPF_LD_IMM64(R0, 2147483647),
  6199				BPF_ALU64_IMM(BPF_MOD, R0, 2147483645),
  6200				BPF_EXIT_INSN(),
  6201			},
  6202			INTERNAL,
  6203			{ },
  6204			{ { 0, 2 } },
  6205		},
  6206		/* BPF_ALU | BPF_DIV | BPF_X off=1 (SDIV) */
  6207		{
  6208			"ALU_SDIV_X: -6 / 2 = -3",
  6209			.u.insns_int = {
  6210				BPF_LD_IMM64(R0, -6),
  6211				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  6212				BPF_ALU32_REG_OFF(BPF_DIV, R0, R1, 1),
  6213				BPF_EXIT_INSN(),
  6214			},
  6215			INTERNAL,
  6216			{ },
  6217			{ { 0, -3 } },
  6218		},
  6219		/* BPF_ALU | BPF_DIV | BPF_K off=1 (SDIV) */
  6220		{
  6221			"ALU_SDIV_K: -6 / 2 = -3",
  6222			.u.insns_int = {
  6223				BPF_LD_IMM64(R0, -6),
  6224				BPF_ALU32_IMM_OFF(BPF_DIV, R0, 2, 1),
  6225				BPF_EXIT_INSN(),
  6226			},
  6227			INTERNAL,
  6228			{ },
  6229			{ { 0, -3 } },
  6230		},
  6231		/* BPF_ALU64 | BPF_DIV | BPF_X off=1 (SDIV64) */
  6232		{
  6233			"ALU64_SDIV_X: -6 / 2 = -3",
  6234			.u.insns_int = {
  6235				BPF_LD_IMM64(R0, -6),
  6236				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  6237				BPF_ALU64_REG_OFF(BPF_DIV, R0, R1, 1),
  6238				BPF_EXIT_INSN(),
  6239			},
  6240			INTERNAL,
  6241			{ },
  6242			{ { 0, -3 } },
  6243		},
  6244		/* BPF_ALU64 | BPF_DIV | BPF_K off=1 (SDIV64) */
  6245		{
  6246			"ALU64_SDIV_K: -6 / 2 = -3",
  6247			.u.insns_int = {
  6248				BPF_LD_IMM64(R0, -6),
  6249				BPF_ALU64_IMM_OFF(BPF_DIV, R0, 2, 1),
  6250				BPF_EXIT_INSN(),
  6251			},
  6252			INTERNAL,
  6253			{ },
  6254			{ { 0, -3 } },
  6255		},
  6256		/* BPF_ALU | BPF_MOD | BPF_X off=1 (SMOD) */
  6257		{
  6258			"ALU_SMOD_X: -7 % 2 = -1",
  6259			.u.insns_int = {
  6260				BPF_LD_IMM64(R0, -7),
  6261				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  6262				BPF_ALU32_REG_OFF(BPF_MOD, R0, R1, 1),
  6263				BPF_EXIT_INSN(),
  6264			},
  6265			INTERNAL,
  6266			{ },
  6267			{ { 0, -1 } },
  6268		},
  6269		/* BPF_ALU | BPF_MOD | BPF_K off=1 (SMOD) */
  6270		{
  6271			"ALU_SMOD_K: -7 % 2 = -1",
  6272			.u.insns_int = {
  6273				BPF_LD_IMM64(R0, -7),
  6274				BPF_ALU32_IMM_OFF(BPF_MOD, R0, 2, 1),
  6275				BPF_EXIT_INSN(),
  6276			},
  6277			INTERNAL,
  6278			{ },
  6279			{ { 0, -1 } },
  6280		},
  6281		/* BPF_ALU64 | BPF_MOD | BPF_X off=1 (SMOD64) */
  6282		{
  6283			"ALU64_SMOD_X: -7 % 2 = -1",
  6284			.u.insns_int = {
  6285				BPF_LD_IMM64(R0, -7),
  6286				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  6287				BPF_ALU64_REG_OFF(BPF_MOD, R0, R1, 1),
  6288				BPF_EXIT_INSN(),
  6289			},
  6290			INTERNAL,
  6291			{ },
  6292			{ { 0, -1 } },
  6293		},
  6294		/* BPF_ALU64 | BPF_MOD | BPF_K off=1 (SMOD64) */
  6295		{
  6296			"ALU64_SMOD_X: -7 % 2 = -1",
  6297			.u.insns_int = {
  6298				BPF_LD_IMM64(R0, -7),
  6299				BPF_ALU64_IMM_OFF(BPF_MOD, R0, 2, 1),
  6300				BPF_EXIT_INSN(),
  6301			},
  6302			INTERNAL,
  6303			{ },
  6304			{ { 0, -1 } },
  6305		},
  6306		/* BPF_ALU | BPF_AND | BPF_X */
  6307		{
  6308			"ALU_AND_X: 3 & 2 = 2",
  6309			.u.insns_int = {
  6310				BPF_LD_IMM64(R0, 3),
  6311				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  6312				BPF_ALU32_REG(BPF_AND, R0, R1),
  6313				BPF_EXIT_INSN(),
  6314			},
  6315			INTERNAL,
  6316			{ },
  6317			{ { 0, 2 } },
  6318		},
  6319		{
  6320			"ALU_AND_X: 0xffffffff & 0xffffffff = 0xffffffff",
  6321			.u.insns_int = {
  6322				BPF_LD_IMM64(R0, 0xffffffff),
  6323				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  6324				BPF_ALU32_REG(BPF_AND, R0, R1),
  6325				BPF_EXIT_INSN(),
  6326			},
  6327			INTERNAL,
  6328			{ },
  6329			{ { 0, 0xffffffff } },
  6330		},
  6331		{
  6332			"ALU64_AND_X: 3 & 2 = 2",
  6333			.u.insns_int = {
  6334				BPF_LD_IMM64(R0, 3),
  6335				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  6336				BPF_ALU64_REG(BPF_AND, R0, R1),
  6337				BPF_EXIT_INSN(),
  6338			},
  6339			INTERNAL,
  6340			{ },
  6341			{ { 0, 2 } },
  6342		},
  6343		{
  6344			"ALU64_AND_X: 0xffffffff & 0xffffffff = 0xffffffff",
  6345			.u.insns_int = {
  6346				BPF_LD_IMM64(R0, 0xffffffff),
  6347				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  6348				BPF_ALU64_REG(BPF_AND, R0, R1),
  6349				BPF_EXIT_INSN(),
  6350			},
  6351			INTERNAL,
  6352			{ },
  6353			{ { 0, 0xffffffff } },
  6354		},
  6355		/* BPF_ALU | BPF_AND | BPF_K */
  6356		{
  6357			"ALU_AND_K: 3 & 2 = 2",
  6358			.u.insns_int = {
  6359				BPF_LD_IMM64(R0, 3),
  6360				BPF_ALU32_IMM(BPF_AND, R0, 2),
  6361				BPF_EXIT_INSN(),
  6362			},
  6363			INTERNAL,
  6364			{ },
  6365			{ { 0, 2 } },
  6366		},
  6367		{
  6368			"ALU_AND_K: 0xffffffff & 0xffffffff = 0xffffffff",
  6369			.u.insns_int = {
  6370				BPF_LD_IMM64(R0, 0xffffffff),
  6371				BPF_ALU32_IMM(BPF_AND, R0, 0xffffffff),
  6372				BPF_EXIT_INSN(),
  6373			},
  6374			INTERNAL,
  6375			{ },
  6376			{ { 0, 0xffffffff } },
  6377		},
  6378		{
  6379			"ALU_AND_K: Small immediate",
  6380			.u.insns_int = {
  6381				BPF_ALU32_IMM(BPF_MOV, R0, 0x01020304),
  6382				BPF_ALU32_IMM(BPF_AND, R0, 15),
  6383				BPF_EXIT_INSN(),
  6384			},
  6385			INTERNAL,
  6386			{ },
  6387			{ { 0, 4 } }
  6388		},
  6389		{
  6390			"ALU_AND_K: Large immediate",
  6391			.u.insns_int = {
  6392				BPF_ALU32_IMM(BPF_MOV, R0, 0xf1f2f3f4),
  6393				BPF_ALU32_IMM(BPF_AND, R0, 0xafbfcfdf),
  6394				BPF_EXIT_INSN(),
  6395			},
  6396			INTERNAL,
  6397			{ },
  6398			{ { 0, 0xa1b2c3d4 } }
  6399		},
  6400		{
  6401			"ALU_AND_K: Zero extension",
  6402			.u.insns_int = {
  6403				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  6404				BPF_LD_IMM64(R1, 0x0000000080a0c0e0LL),
  6405				BPF_ALU32_IMM(BPF_AND, R0, 0xf0f0f0f0),
  6406				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  6407				BPF_MOV32_IMM(R0, 2),
  6408				BPF_EXIT_INSN(),
  6409				BPF_MOV32_IMM(R0, 1),
  6410				BPF_EXIT_INSN(),
  6411			},
  6412			INTERNAL,
  6413			{ },
  6414			{ { 0, 1 } }
  6415		},
  6416		{
  6417			"ALU64_AND_K: 3 & 2 = 2",
  6418			.u.insns_int = {
  6419				BPF_LD_IMM64(R0, 3),
  6420				BPF_ALU64_IMM(BPF_AND, R0, 2),
  6421				BPF_EXIT_INSN(),
  6422			},
  6423			INTERNAL,
  6424			{ },
  6425			{ { 0, 2 } },
  6426		},
  6427		{
  6428			"ALU64_AND_K: 0xffffffff & 0xffffffff = 0xffffffff",
  6429			.u.insns_int = {
  6430				BPF_LD_IMM64(R0, 0xffffffff),
  6431				BPF_ALU64_IMM(BPF_AND, R0, 0xffffffff),
  6432				BPF_EXIT_INSN(),
  6433			},
  6434			INTERNAL,
  6435			{ },
  6436			{ { 0, 0xffffffff } },
  6437		},
  6438		{
  6439			"ALU64_AND_K: 0x0000ffffffff0000 & 0x0 = 0x0000000000000000",
  6440			.u.insns_int = {
  6441				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  6442				BPF_LD_IMM64(R3, 0x0000000000000000LL),
  6443				BPF_ALU64_IMM(BPF_AND, R2, 0x0),
  6444				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  6445				BPF_MOV32_IMM(R0, 2),
  6446				BPF_EXIT_INSN(),
  6447				BPF_MOV32_IMM(R0, 1),
  6448				BPF_EXIT_INSN(),
  6449			},
  6450			INTERNAL,
  6451			{ },
  6452			{ { 0, 0x1 } },
  6453		},
  6454		{
  6455			"ALU64_AND_K: 0x0000ffffffff0000 & -1 = 0x0000ffffffff0000",
  6456			.u.insns_int = {
  6457				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  6458				BPF_LD_IMM64(R3, 0x0000ffffffff0000LL),
  6459				BPF_ALU64_IMM(BPF_AND, R2, 0xffffffff),
  6460				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  6461				BPF_MOV32_IMM(R0, 2),
  6462				BPF_EXIT_INSN(),
  6463				BPF_MOV32_IMM(R0, 1),
  6464				BPF_EXIT_INSN(),
  6465			},
  6466			INTERNAL,
  6467			{ },
  6468			{ { 0, 0x1 } },
  6469		},
  6470		{
  6471			"ALU64_AND_K: 0xffffffffffffffff & -1 = 0xffffffffffffffff",
  6472			.u.insns_int = {
  6473				BPF_LD_IMM64(R2, 0xffffffffffffffffLL),
  6474				BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
  6475				BPF_ALU64_IMM(BPF_AND, R2, 0xffffffff),
  6476				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  6477				BPF_MOV32_IMM(R0, 2),
  6478				BPF_EXIT_INSN(),
  6479				BPF_MOV32_IMM(R0, 1),
  6480				BPF_EXIT_INSN(),
  6481			},
  6482			INTERNAL,
  6483			{ },
  6484			{ { 0, 0x1 } },
  6485		},
  6486		{
  6487			"ALU64_AND_K: Sign extension 1",
  6488			.u.insns_int = {
  6489				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  6490				BPF_LD_IMM64(R1, 0x00000000090b0d0fLL),
  6491				BPF_ALU64_IMM(BPF_AND, R0, 0x0f0f0f0f),
  6492				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  6493				BPF_MOV32_IMM(R0, 2),
  6494				BPF_EXIT_INSN(),
  6495				BPF_MOV32_IMM(R0, 1),
  6496				BPF_EXIT_INSN(),
  6497			},
  6498			INTERNAL,
  6499			{ },
  6500			{ { 0, 1 } }
  6501		},
  6502		{
  6503			"ALU64_AND_K: Sign extension 2",
  6504			.u.insns_int = {
  6505				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  6506				BPF_LD_IMM64(R1, 0x0123456780a0c0e0LL),
  6507				BPF_ALU64_IMM(BPF_AND, R0, 0xf0f0f0f0),
  6508				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  6509				BPF_MOV32_IMM(R0, 2),
  6510				BPF_EXIT_INSN(),
  6511				BPF_MOV32_IMM(R0, 1),
  6512				BPF_EXIT_INSN(),
  6513			},
  6514			INTERNAL,
  6515			{ },
  6516			{ { 0, 1 } }
  6517		},
  6518		/* BPF_ALU | BPF_OR | BPF_X */
  6519		{
  6520			"ALU_OR_X: 1 | 2 = 3",
  6521			.u.insns_int = {
  6522				BPF_LD_IMM64(R0, 1),
  6523				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  6524				BPF_ALU32_REG(BPF_OR, R0, R1),
  6525				BPF_EXIT_INSN(),
  6526			},
  6527			INTERNAL,
  6528			{ },
  6529			{ { 0, 3 } },
  6530		},
  6531		{
  6532			"ALU_OR_X: 0x0 | 0xffffffff = 0xffffffff",
  6533			.u.insns_int = {
  6534				BPF_LD_IMM64(R0, 0),
  6535				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  6536				BPF_ALU32_REG(BPF_OR, R0, R1),
  6537				BPF_EXIT_INSN(),
  6538			},
  6539			INTERNAL,
  6540			{ },
  6541			{ { 0, 0xffffffff } },
  6542		},
  6543		{
  6544			"ALU64_OR_X: 1 | 2 = 3",
  6545			.u.insns_int = {
  6546				BPF_LD_IMM64(R0, 1),
  6547				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  6548				BPF_ALU64_REG(BPF_OR, R0, R1),
  6549				BPF_EXIT_INSN(),
  6550			},
  6551			INTERNAL,
  6552			{ },
  6553			{ { 0, 3 } },
  6554		},
  6555		{
  6556			"ALU64_OR_X: 0 | 0xffffffff = 0xffffffff",
  6557			.u.insns_int = {
  6558				BPF_LD_IMM64(R0, 0),
  6559				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  6560				BPF_ALU64_REG(BPF_OR, R0, R1),
  6561				BPF_EXIT_INSN(),
  6562			},
  6563			INTERNAL,
  6564			{ },
  6565			{ { 0, 0xffffffff } },
  6566		},
  6567		/* BPF_ALU | BPF_OR | BPF_K */
  6568		{
  6569			"ALU_OR_K: 1 | 2 = 3",
  6570			.u.insns_int = {
  6571				BPF_LD_IMM64(R0, 1),
  6572				BPF_ALU32_IMM(BPF_OR, R0, 2),
  6573				BPF_EXIT_INSN(),
  6574			},
  6575			INTERNAL,
  6576			{ },
  6577			{ { 0, 3 } },
  6578		},
  6579		{
  6580			"ALU_OR_K: 0 & 0xffffffff = 0xffffffff",
  6581			.u.insns_int = {
  6582				BPF_LD_IMM64(R0, 0),
  6583				BPF_ALU32_IMM(BPF_OR, R0, 0xffffffff),
  6584				BPF_EXIT_INSN(),
  6585			},
  6586			INTERNAL,
  6587			{ },
  6588			{ { 0, 0xffffffff } },
  6589		},
  6590		{
  6591			"ALU_OR_K: Small immediate",
  6592			.u.insns_int = {
  6593				BPF_ALU32_IMM(BPF_MOV, R0, 0x01020304),
  6594				BPF_ALU32_IMM(BPF_OR, R0, 1),
  6595				BPF_EXIT_INSN(),
  6596			},
  6597			INTERNAL,
  6598			{ },
  6599			{ { 0, 0x01020305 } }
  6600		},
  6601		{
  6602			"ALU_OR_K: Large immediate",
  6603			.u.insns_int = {
  6604				BPF_ALU32_IMM(BPF_MOV, R0, 0x01020304),
  6605				BPF_ALU32_IMM(BPF_OR, R0, 0xa0b0c0d0),
  6606				BPF_EXIT_INSN(),
  6607			},
  6608			INTERNAL,
  6609			{ },
  6610			{ { 0, 0xa1b2c3d4 } }
  6611		},
  6612		{
  6613			"ALU_OR_K: Zero extension",
  6614			.u.insns_int = {
  6615				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  6616				BPF_LD_IMM64(R1, 0x00000000f9fbfdffLL),
  6617				BPF_ALU32_IMM(BPF_OR, R0, 0xf0f0f0f0),
  6618				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  6619				BPF_MOV32_IMM(R0, 2),
  6620				BPF_EXIT_INSN(),
  6621				BPF_MOV32_IMM(R0, 1),
  6622				BPF_EXIT_INSN(),
  6623			},
  6624			INTERNAL,
  6625			{ },
  6626			{ { 0, 1 } }
  6627		},
  6628		{
  6629			"ALU64_OR_K: 1 | 2 = 3",
  6630			.u.insns_int = {
  6631				BPF_LD_IMM64(R0, 1),
  6632				BPF_ALU64_IMM(BPF_OR, R0, 2),
  6633				BPF_EXIT_INSN(),
  6634			},
  6635			INTERNAL,
  6636			{ },
  6637			{ { 0, 3 } },
  6638		},
  6639		{
  6640			"ALU64_OR_K: 0 & 0xffffffff = 0xffffffff",
  6641			.u.insns_int = {
  6642				BPF_LD_IMM64(R0, 0),
  6643				BPF_ALU64_IMM(BPF_OR, R0, 0xffffffff),
  6644				BPF_EXIT_INSN(),
  6645			},
  6646			INTERNAL,
  6647			{ },
  6648			{ { 0, 0xffffffff } },
  6649		},
  6650		{
  6651			"ALU64_OR_K: 0x0000ffffffff0000 | 0x0 = 0x0000ffffffff0000",
  6652			.u.insns_int = {
  6653				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  6654				BPF_LD_IMM64(R3, 0x0000ffffffff0000LL),
  6655				BPF_ALU64_IMM(BPF_OR, R2, 0x0),
  6656				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  6657				BPF_MOV32_IMM(R0, 2),
  6658				BPF_EXIT_INSN(),
  6659				BPF_MOV32_IMM(R0, 1),
  6660				BPF_EXIT_INSN(),
  6661			},
  6662			INTERNAL,
  6663			{ },
  6664			{ { 0, 0x1 } },
  6665		},
  6666		{
  6667			"ALU64_OR_K: 0x0000ffffffff0000 | -1 = 0xffffffffffffffff",
  6668			.u.insns_int = {
  6669				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  6670				BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
  6671				BPF_ALU64_IMM(BPF_OR, R2, 0xffffffff),
  6672				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  6673				BPF_MOV32_IMM(R0, 2),
  6674				BPF_EXIT_INSN(),
  6675				BPF_MOV32_IMM(R0, 1),
  6676				BPF_EXIT_INSN(),
  6677			},
  6678			INTERNAL,
  6679			{ },
  6680			{ { 0, 0x1 } },
  6681		},
  6682		{
  6683			"ALU64_OR_K: 0x000000000000000 | -1 = 0xffffffffffffffff",
  6684			.u.insns_int = {
  6685				BPF_LD_IMM64(R2, 0x0000000000000000LL),
  6686				BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
  6687				BPF_ALU64_IMM(BPF_OR, R2, 0xffffffff),
  6688				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  6689				BPF_MOV32_IMM(R0, 2),
  6690				BPF_EXIT_INSN(),
  6691				BPF_MOV32_IMM(R0, 1),
  6692				BPF_EXIT_INSN(),
  6693			},
  6694			INTERNAL,
  6695			{ },
  6696			{ { 0, 0x1 } },
  6697		},
  6698		{
  6699			"ALU64_OR_K: Sign extension 1",
  6700			.u.insns_int = {
  6701				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  6702				BPF_LD_IMM64(R1, 0x012345678fafcfefLL),
  6703				BPF_ALU64_IMM(BPF_OR, R0, 0x0f0f0f0f),
  6704				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  6705				BPF_MOV32_IMM(R0, 2),
  6706				BPF_EXIT_INSN(),
  6707				BPF_MOV32_IMM(R0, 1),
  6708				BPF_EXIT_INSN(),
  6709			},
  6710			INTERNAL,
  6711			{ },
  6712			{ { 0, 1 } }
  6713		},
  6714		{
  6715			"ALU64_OR_K: Sign extension 2",
  6716			.u.insns_int = {
  6717				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  6718				BPF_LD_IMM64(R1, 0xfffffffff9fbfdffLL),
  6719				BPF_ALU64_IMM(BPF_OR, R0, 0xf0f0f0f0),
  6720				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  6721				BPF_MOV32_IMM(R0, 2),
  6722				BPF_EXIT_INSN(),
  6723				BPF_MOV32_IMM(R0, 1),
  6724				BPF_EXIT_INSN(),
  6725			},
  6726			INTERNAL,
  6727			{ },
  6728			{ { 0, 1 } }
  6729		},
  6730		/* BPF_ALU | BPF_XOR | BPF_X */
  6731		{
  6732			"ALU_XOR_X: 5 ^ 6 = 3",
  6733			.u.insns_int = {
  6734				BPF_LD_IMM64(R0, 5),
  6735				BPF_ALU32_IMM(BPF_MOV, R1, 6),
  6736				BPF_ALU32_REG(BPF_XOR, R0, R1),
  6737				BPF_EXIT_INSN(),
  6738			},
  6739			INTERNAL,
  6740			{ },
  6741			{ { 0, 3 } },
  6742		},
  6743		{
  6744			"ALU_XOR_X: 0x1 ^ 0xffffffff = 0xfffffffe",
  6745			.u.insns_int = {
  6746				BPF_LD_IMM64(R0, 1),
  6747				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  6748				BPF_ALU32_REG(BPF_XOR, R0, R1),
  6749				BPF_EXIT_INSN(),
  6750			},
  6751			INTERNAL,
  6752			{ },
  6753			{ { 0, 0xfffffffe } },
  6754		},
  6755		{
  6756			"ALU64_XOR_X: 5 ^ 6 = 3",
  6757			.u.insns_int = {
  6758				BPF_LD_IMM64(R0, 5),
  6759				BPF_ALU32_IMM(BPF_MOV, R1, 6),
  6760				BPF_ALU64_REG(BPF_XOR, R0, R1),
  6761				BPF_EXIT_INSN(),
  6762			},
  6763			INTERNAL,
  6764			{ },
  6765			{ { 0, 3 } },
  6766		},
  6767		{
  6768			"ALU64_XOR_X: 1 ^ 0xffffffff = 0xfffffffe",
  6769			.u.insns_int = {
  6770				BPF_LD_IMM64(R0, 1),
  6771				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  6772				BPF_ALU64_REG(BPF_XOR, R0, R1),
  6773				BPF_EXIT_INSN(),
  6774			},
  6775			INTERNAL,
  6776			{ },
  6777			{ { 0, 0xfffffffe } },
  6778		},
  6779		/* BPF_ALU | BPF_XOR | BPF_K */
  6780		{
  6781			"ALU_XOR_K: 5 ^ 6 = 3",
  6782			.u.insns_int = {
  6783				BPF_LD_IMM64(R0, 5),
  6784				BPF_ALU32_IMM(BPF_XOR, R0, 6),
  6785				BPF_EXIT_INSN(),
  6786			},
  6787			INTERNAL,
  6788			{ },
  6789			{ { 0, 3 } },
  6790		},
  6791		{
  6792			"ALU_XOR_K: 1 ^ 0xffffffff = 0xfffffffe",
  6793			.u.insns_int = {
  6794				BPF_LD_IMM64(R0, 1),
  6795				BPF_ALU32_IMM(BPF_XOR, R0, 0xffffffff),
  6796				BPF_EXIT_INSN(),
  6797			},
  6798			INTERNAL,
  6799			{ },
  6800			{ { 0, 0xfffffffe } },
  6801		},
  6802		{
  6803			"ALU_XOR_K: Small immediate",
  6804			.u.insns_int = {
  6805				BPF_ALU32_IMM(BPF_MOV, R0, 0x01020304),
  6806				BPF_ALU32_IMM(BPF_XOR, R0, 15),
  6807				BPF_EXIT_INSN(),
  6808			},
  6809			INTERNAL,
  6810			{ },
  6811			{ { 0, 0x0102030b } }
  6812		},
  6813		{
  6814			"ALU_XOR_K: Large immediate",
  6815			.u.insns_int = {
  6816				BPF_ALU32_IMM(BPF_MOV, R0, 0xf1f2f3f4),
  6817				BPF_ALU32_IMM(BPF_XOR, R0, 0xafbfcfdf),
  6818				BPF_EXIT_INSN(),
  6819			},
  6820			INTERNAL,
  6821			{ },
  6822			{ { 0, 0x5e4d3c2b } }
  6823		},
  6824		{
  6825			"ALU_XOR_K: Zero extension",
  6826			.u.insns_int = {
  6827				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  6828				BPF_LD_IMM64(R1, 0x00000000795b3d1fLL),
  6829				BPF_ALU32_IMM(BPF_XOR, R0, 0xf0f0f0f0),
  6830				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  6831				BPF_MOV32_IMM(R0, 2),
  6832				BPF_EXIT_INSN(),
  6833				BPF_MOV32_IMM(R0, 1),
  6834				BPF_EXIT_INSN(),
  6835			},
  6836			INTERNAL,
  6837			{ },
  6838			{ { 0, 1 } }
  6839		},
  6840		{
  6841			"ALU64_XOR_K: 5 ^ 6 = 3",
  6842			.u.insns_int = {
  6843				BPF_LD_IMM64(R0, 5),
  6844				BPF_ALU64_IMM(BPF_XOR, R0, 6),
  6845				BPF_EXIT_INSN(),
  6846			},
  6847			INTERNAL,
  6848			{ },
  6849			{ { 0, 3 } },
  6850		},
  6851		{
  6852			"ALU64_XOR_K: 1 ^ 0xffffffff = 0xfffffffe",
  6853			.u.insns_int = {
  6854				BPF_LD_IMM64(R0, 1),
  6855				BPF_ALU64_IMM(BPF_XOR, R0, 0xffffffff),
  6856				BPF_EXIT_INSN(),
  6857			},
  6858			INTERNAL,
  6859			{ },
  6860			{ { 0, 0xfffffffe } },
  6861		},
  6862		{
  6863			"ALU64_XOR_K: 0x0000ffffffff0000 ^ 0x0 = 0x0000ffffffff0000",
  6864			.u.insns_int = {
  6865				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  6866				BPF_LD_IMM64(R3, 0x0000ffffffff0000LL),
  6867				BPF_ALU64_IMM(BPF_XOR, R2, 0x0),
  6868				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  6869				BPF_MOV32_IMM(R0, 2),
  6870				BPF_EXIT_INSN(),
  6871				BPF_MOV32_IMM(R0, 1),
  6872				BPF_EXIT_INSN(),
  6873			},
  6874			INTERNAL,
  6875			{ },
  6876			{ { 0, 0x1 } },
  6877		},
  6878		{
  6879			"ALU64_XOR_K: 0x0000ffffffff0000 ^ -1 = 0xffff00000000ffff",
  6880			.u.insns_int = {
  6881				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  6882				BPF_LD_IMM64(R3, 0xffff00000000ffffLL),
  6883				BPF_ALU64_IMM(BPF_XOR, R2, 0xffffffff),
  6884				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  6885				BPF_MOV32_IMM(R0, 2),
  6886				BPF_EXIT_INSN(),
  6887				BPF_MOV32_IMM(R0, 1),
  6888				BPF_EXIT_INSN(),
  6889			},
  6890			INTERNAL,
  6891			{ },
  6892			{ { 0, 0x1 } },
  6893		},
  6894		{
  6895			"ALU64_XOR_K: 0x000000000000000 ^ -1 = 0xffffffffffffffff",
  6896			.u.insns_int = {
  6897				BPF_LD_IMM64(R2, 0x0000000000000000LL),
  6898				BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
  6899				BPF_ALU64_IMM(BPF_XOR, R2, 0xffffffff),
  6900				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  6901				BPF_MOV32_IMM(R0, 2),
  6902				BPF_EXIT_INSN(),
  6903				BPF_MOV32_IMM(R0, 1),
  6904				BPF_EXIT_INSN(),
  6905			},
  6906			INTERNAL,
  6907			{ },
  6908			{ { 0, 0x1 } },
  6909		},
  6910		{
  6911			"ALU64_XOR_K: Sign extension 1",
  6912			.u.insns_int = {
  6913				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  6914				BPF_LD_IMM64(R1, 0x0123456786a4c2e0LL),
  6915				BPF_ALU64_IMM(BPF_XOR, R0, 0x0f0f0f0f),
  6916				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  6917				BPF_MOV32_IMM(R0, 2),
  6918				BPF_EXIT_INSN(),
  6919				BPF_MOV32_IMM(R0, 1),
  6920				BPF_EXIT_INSN(),
  6921			},
  6922			INTERNAL,
  6923			{ },
  6924			{ { 0, 1 } }
  6925		},
  6926		{
  6927			"ALU64_XOR_K: Sign extension 2",
  6928			.u.insns_int = {
  6929				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  6930				BPF_LD_IMM64(R1, 0xfedcba98795b3d1fLL),
  6931				BPF_ALU64_IMM(BPF_XOR, R0, 0xf0f0f0f0),
  6932				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  6933				BPF_MOV32_IMM(R0, 2),
  6934				BPF_EXIT_INSN(),
  6935				BPF_MOV32_IMM(R0, 1),
  6936				BPF_EXIT_INSN(),
  6937			},
  6938			INTERNAL,
  6939			{ },
  6940			{ { 0, 1 } }
  6941		},
  6942		/* BPF_ALU | BPF_LSH | BPF_X */
  6943		{
  6944			"ALU_LSH_X: 1 << 1 = 2",
  6945			.u.insns_int = {
  6946				BPF_LD_IMM64(R0, 1),
  6947				BPF_ALU32_IMM(BPF_MOV, R1, 1),
  6948				BPF_ALU32_REG(BPF_LSH, R0, R1),
  6949				BPF_EXIT_INSN(),
  6950			},
  6951			INTERNAL,
  6952			{ },
  6953			{ { 0, 2 } },
  6954		},
  6955		{
  6956			"ALU_LSH_X: 1 << 31 = 0x80000000",
  6957			.u.insns_int = {
  6958				BPF_LD_IMM64(R0, 1),
  6959				BPF_ALU32_IMM(BPF_MOV, R1, 31),
  6960				BPF_ALU32_REG(BPF_LSH, R0, R1),
  6961				BPF_EXIT_INSN(),
  6962			},
  6963			INTERNAL,
  6964			{ },
  6965			{ { 0, 0x80000000 } },
  6966		},
  6967		{
  6968			"ALU_LSH_X: 0x12345678 << 12 = 0x45678000",
  6969			.u.insns_int = {
  6970				BPF_ALU32_IMM(BPF_MOV, R0, 0x12345678),
  6971				BPF_ALU32_IMM(BPF_MOV, R1, 12),
  6972				BPF_ALU32_REG(BPF_LSH, R0, R1),
  6973				BPF_EXIT_INSN(),
  6974			},
  6975			INTERNAL,
  6976			{ },
  6977			{ { 0, 0x45678000 } }
  6978		},
  6979		{
  6980			"ALU64_LSH_X: 1 << 1 = 2",
  6981			.u.insns_int = {
  6982				BPF_LD_IMM64(R0, 1),
  6983				BPF_ALU32_IMM(BPF_MOV, R1, 1),
  6984				BPF_ALU64_REG(BPF_LSH, R0, R1),
  6985				BPF_EXIT_INSN(),
  6986			},
  6987			INTERNAL,
  6988			{ },
  6989			{ { 0, 2 } },
  6990		},
  6991		{
  6992			"ALU64_LSH_X: 1 << 31 = 0x80000000",
  6993			.u.insns_int = {
  6994				BPF_LD_IMM64(R0, 1),
  6995				BPF_ALU32_IMM(BPF_MOV, R1, 31),
  6996				BPF_ALU64_REG(BPF_LSH, R0, R1),
  6997				BPF_EXIT_INSN(),
  6998			},
  6999			INTERNAL,
  7000			{ },
  7001			{ { 0, 0x80000000 } },
  7002		},
  7003		{
  7004			"ALU64_LSH_X: Shift < 32, low word",
  7005			.u.insns_int = {
  7006				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  7007				BPF_ALU32_IMM(BPF_MOV, R1, 12),
  7008				BPF_ALU64_REG(BPF_LSH, R0, R1),
  7009				BPF_EXIT_INSN(),
  7010			},
  7011			INTERNAL,
  7012			{ },
  7013			{ { 0, 0xbcdef000 } }
  7014		},
  7015		{
  7016			"ALU64_LSH_X: Shift < 32, high word",
  7017			.u.insns_int = {
  7018				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  7019				BPF_ALU32_IMM(BPF_MOV, R1, 12),
  7020				BPF_ALU64_REG(BPF_LSH, R0, R1),
  7021				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7022				BPF_EXIT_INSN(),
  7023			},
  7024			INTERNAL,
  7025			{ },
  7026			{ { 0, 0x3456789a } }
  7027		},
  7028		{
  7029			"ALU64_LSH_X: Shift > 32, low word",
  7030			.u.insns_int = {
  7031				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  7032				BPF_ALU32_IMM(BPF_MOV, R1, 36),
  7033				BPF_ALU64_REG(BPF_LSH, R0, R1),
  7034				BPF_EXIT_INSN(),
  7035			},
  7036			INTERNAL,
  7037			{ },
  7038			{ { 0, 0 } }
  7039		},
  7040		{
  7041			"ALU64_LSH_X: Shift > 32, high word",
  7042			.u.insns_int = {
  7043				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  7044				BPF_ALU32_IMM(BPF_MOV, R1, 36),
  7045				BPF_ALU64_REG(BPF_LSH, R0, R1),
  7046				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7047				BPF_EXIT_INSN(),
  7048			},
  7049			INTERNAL,
  7050			{ },
  7051			{ { 0, 0x9abcdef0 } }
  7052		},
  7053		{
  7054			"ALU64_LSH_X: Shift == 32, low word",
  7055			.u.insns_int = {
  7056				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  7057				BPF_ALU32_IMM(BPF_MOV, R1, 32),
  7058				BPF_ALU64_REG(BPF_LSH, R0, R1),
  7059				BPF_EXIT_INSN(),
  7060			},
  7061			INTERNAL,
  7062			{ },
  7063			{ { 0, 0 } }
  7064		},
  7065		{
  7066			"ALU64_LSH_X: Shift == 32, high word",
  7067			.u.insns_int = {
  7068				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  7069				BPF_ALU32_IMM(BPF_MOV, R1, 32),
  7070				BPF_ALU64_REG(BPF_LSH, R0, R1),
  7071				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7072				BPF_EXIT_INSN(),
  7073			},
  7074			INTERNAL,
  7075			{ },
  7076			{ { 0, 0x89abcdef } }
  7077		},
  7078		{
  7079			"ALU64_LSH_X: Zero shift, low word",
  7080			.u.insns_int = {
  7081				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  7082				BPF_ALU32_IMM(BPF_MOV, R1, 0),
  7083				BPF_ALU64_REG(BPF_LSH, R0, R1),
  7084				BPF_EXIT_INSN(),
  7085			},
  7086			INTERNAL,
  7087			{ },
  7088			{ { 0, 0x89abcdef } }
  7089		},
  7090		{
  7091			"ALU64_LSH_X: Zero shift, high word",
  7092			.u.insns_int = {
  7093				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  7094				BPF_ALU32_IMM(BPF_MOV, R1, 0),
  7095				BPF_ALU64_REG(BPF_LSH, R0, R1),
  7096				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7097				BPF_EXIT_INSN(),
  7098			},
  7099			INTERNAL,
  7100			{ },
  7101			{ { 0, 0x01234567 } }
  7102		},
  7103		/* BPF_ALU | BPF_LSH | BPF_K */
  7104		{
  7105			"ALU_LSH_K: 1 << 1 = 2",
  7106			.u.insns_int = {
  7107				BPF_LD_IMM64(R0, 1),
  7108				BPF_ALU32_IMM(BPF_LSH, R0, 1),
  7109				BPF_EXIT_INSN(),
  7110			},
  7111			INTERNAL,
  7112			{ },
  7113			{ { 0, 2 } },
  7114		},
  7115		{
  7116			"ALU_LSH_K: 1 << 31 = 0x80000000",
  7117			.u.insns_int = {
  7118				BPF_LD_IMM64(R0, 1),
  7119				BPF_ALU32_IMM(BPF_LSH, R0, 31),
  7120				BPF_EXIT_INSN(),
  7121			},
  7122			INTERNAL,
  7123			{ },
  7124			{ { 0, 0x80000000 } },
  7125		},
  7126		{
  7127			"ALU_LSH_K: 0x12345678 << 12 = 0x45678000",
  7128			.u.insns_int = {
  7129				BPF_ALU32_IMM(BPF_MOV, R0, 0x12345678),
  7130				BPF_ALU32_IMM(BPF_LSH, R0, 12),
  7131				BPF_EXIT_INSN(),
  7132			},
  7133			INTERNAL,
  7134			{ },
  7135			{ { 0, 0x45678000 } }
  7136		},
  7137		{
  7138			"ALU_LSH_K: 0x12345678 << 0 = 0x12345678",
  7139			.u.insns_int = {
  7140				BPF_ALU32_IMM(BPF_MOV, R0, 0x12345678),
  7141				BPF_ALU32_IMM(BPF_LSH, R0, 0),
  7142				BPF_EXIT_INSN(),
  7143			},
  7144			INTERNAL,
  7145			{ },
  7146			{ { 0, 0x12345678 } }
  7147		},
  7148		{
  7149			"ALU64_LSH_K: 1 << 1 = 2",
  7150			.u.insns_int = {
  7151				BPF_LD_IMM64(R0, 1),
  7152				BPF_ALU64_IMM(BPF_LSH, R0, 1),
  7153				BPF_EXIT_INSN(),
  7154			},
  7155			INTERNAL,
  7156			{ },
  7157			{ { 0, 2 } },
  7158		},
  7159		{
  7160			"ALU64_LSH_K: 1 << 31 = 0x80000000",
  7161			.u.insns_int = {
  7162				BPF_LD_IMM64(R0, 1),
  7163				BPF_ALU64_IMM(BPF_LSH, R0, 31),
  7164				BPF_EXIT_INSN(),
  7165			},
  7166			INTERNAL,
  7167			{ },
  7168			{ { 0, 0x80000000 } },
  7169		},
  7170		{
  7171			"ALU64_LSH_K: Shift < 32, low word",
  7172			.u.insns_int = {
  7173				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  7174				BPF_ALU64_IMM(BPF_LSH, R0, 12),
  7175				BPF_EXIT_INSN(),
  7176			},
  7177			INTERNAL,
  7178			{ },
  7179			{ { 0, 0xbcdef000 } }
  7180		},
  7181		{
  7182			"ALU64_LSH_K: Shift < 32, high word",
  7183			.u.insns_int = {
  7184				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  7185				BPF_ALU64_IMM(BPF_LSH, R0, 12),
  7186				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7187				BPF_EXIT_INSN(),
  7188			},
  7189			INTERNAL,
  7190			{ },
  7191			{ { 0, 0x3456789a } }
  7192		},
  7193		{
  7194			"ALU64_LSH_K: Shift > 32, low word",
  7195			.u.insns_int = {
  7196				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  7197				BPF_ALU64_IMM(BPF_LSH, R0, 36),
  7198				BPF_EXIT_INSN(),
  7199			},
  7200			INTERNAL,
  7201			{ },
  7202			{ { 0, 0 } }
  7203		},
  7204		{
  7205			"ALU64_LSH_K: Shift > 32, high word",
  7206			.u.insns_int = {
  7207				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  7208				BPF_ALU64_IMM(BPF_LSH, R0, 36),
  7209				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7210				BPF_EXIT_INSN(),
  7211			},
  7212			INTERNAL,
  7213			{ },
  7214			{ { 0, 0x9abcdef0 } }
  7215		},
  7216		{
  7217			"ALU64_LSH_K: Shift == 32, low word",
  7218			.u.insns_int = {
  7219				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  7220				BPF_ALU64_IMM(BPF_LSH, R0, 32),
  7221				BPF_EXIT_INSN(),
  7222			},
  7223			INTERNAL,
  7224			{ },
  7225			{ { 0, 0 } }
  7226		},
  7227		{
  7228			"ALU64_LSH_K: Shift == 32, high word",
  7229			.u.insns_int = {
  7230				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  7231				BPF_ALU64_IMM(BPF_LSH, R0, 32),
  7232				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7233				BPF_EXIT_INSN(),
  7234			},
  7235			INTERNAL,
  7236			{ },
  7237			{ { 0, 0x89abcdef } }
  7238		},
  7239		{
  7240			"ALU64_LSH_K: Zero shift",
  7241			.u.insns_int = {
  7242				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  7243				BPF_ALU64_IMM(BPF_LSH, R0, 0),
  7244				BPF_EXIT_INSN(),
  7245			},
  7246			INTERNAL,
  7247			{ },
  7248			{ { 0, 0x89abcdef } }
  7249		},
  7250		/* BPF_ALU | BPF_RSH | BPF_X */
  7251		{
  7252			"ALU_RSH_X: 2 >> 1 = 1",
  7253			.u.insns_int = {
  7254				BPF_LD_IMM64(R0, 2),
  7255				BPF_ALU32_IMM(BPF_MOV, R1, 1),
  7256				BPF_ALU32_REG(BPF_RSH, R0, R1),
  7257				BPF_EXIT_INSN(),
  7258			},
  7259			INTERNAL,
  7260			{ },
  7261			{ { 0, 1 } },
  7262		},
  7263		{
  7264			"ALU_RSH_X: 0x80000000 >> 31 = 1",
  7265			.u.insns_int = {
  7266				BPF_LD_IMM64(R0, 0x80000000),
  7267				BPF_ALU32_IMM(BPF_MOV, R1, 31),
  7268				BPF_ALU32_REG(BPF_RSH, R0, R1),
  7269				BPF_EXIT_INSN(),
  7270			},
  7271			INTERNAL,
  7272			{ },
  7273			{ { 0, 1 } },
  7274		},
  7275		{
  7276			"ALU_RSH_X: 0x12345678 >> 20 = 0x123",
  7277			.u.insns_int = {
  7278				BPF_ALU32_IMM(BPF_MOV, R0, 0x12345678),
  7279				BPF_ALU32_IMM(BPF_MOV, R1, 20),
  7280				BPF_ALU32_REG(BPF_RSH, R0, R1),
  7281				BPF_EXIT_INSN(),
  7282			},
  7283			INTERNAL,
  7284			{ },
  7285			{ { 0, 0x123 } }
  7286		},
  7287		{
  7288			"ALU64_RSH_X: 2 >> 1 = 1",
  7289			.u.insns_int = {
  7290				BPF_LD_IMM64(R0, 2),
  7291				BPF_ALU32_IMM(BPF_MOV, R1, 1),
  7292				BPF_ALU64_REG(BPF_RSH, R0, R1),
  7293				BPF_EXIT_INSN(),
  7294			},
  7295			INTERNAL,
  7296			{ },
  7297			{ { 0, 1 } },
  7298		},
  7299		{
  7300			"ALU64_RSH_X: 0x80000000 >> 31 = 1",
  7301			.u.insns_int = {
  7302				BPF_LD_IMM64(R0, 0x80000000),
  7303				BPF_ALU32_IMM(BPF_MOV, R1, 31),
  7304				BPF_ALU64_REG(BPF_RSH, R0, R1),
  7305				BPF_EXIT_INSN(),
  7306			},
  7307			INTERNAL,
  7308			{ },
  7309			{ { 0, 1 } },
  7310		},
  7311		{
  7312			"ALU64_RSH_X: Shift < 32, low word",
  7313			.u.insns_int = {
  7314				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7315				BPF_ALU32_IMM(BPF_MOV, R1, 12),
  7316				BPF_ALU64_REG(BPF_RSH, R0, R1),
  7317				BPF_EXIT_INSN(),
  7318			},
  7319			INTERNAL,
  7320			{ },
  7321			{ { 0, 0x56789abc } }
  7322		},
  7323		{
  7324			"ALU64_RSH_X: Shift < 32, high word",
  7325			.u.insns_int = {
  7326				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7327				BPF_ALU32_IMM(BPF_MOV, R1, 12),
  7328				BPF_ALU64_REG(BPF_RSH, R0, R1),
  7329				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7330				BPF_EXIT_INSN(),
  7331			},
  7332			INTERNAL,
  7333			{ },
  7334			{ { 0, 0x00081234 } }
  7335		},
  7336		{
  7337			"ALU64_RSH_X: Shift > 32, low word",
  7338			.u.insns_int = {
  7339				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7340				BPF_ALU32_IMM(BPF_MOV, R1, 36),
  7341				BPF_ALU64_REG(BPF_RSH, R0, R1),
  7342				BPF_EXIT_INSN(),
  7343			},
  7344			INTERNAL,
  7345			{ },
  7346			{ { 0, 0x08123456 } }
  7347		},
  7348		{
  7349			"ALU64_RSH_X: Shift > 32, high word",
  7350			.u.insns_int = {
  7351				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7352				BPF_ALU32_IMM(BPF_MOV, R1, 36),
  7353				BPF_ALU64_REG(BPF_RSH, R0, R1),
  7354				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7355				BPF_EXIT_INSN(),
  7356			},
  7357			INTERNAL,
  7358			{ },
  7359			{ { 0, 0 } }
  7360		},
  7361		{
  7362			"ALU64_RSH_X: Shift == 32, low word",
  7363			.u.insns_int = {
  7364				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7365				BPF_ALU32_IMM(BPF_MOV, R1, 32),
  7366				BPF_ALU64_REG(BPF_RSH, R0, R1),
  7367				BPF_EXIT_INSN(),
  7368			},
  7369			INTERNAL,
  7370			{ },
  7371			{ { 0, 0x81234567 } }
  7372		},
  7373		{
  7374			"ALU64_RSH_X: Shift == 32, high word",
  7375			.u.insns_int = {
  7376				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7377				BPF_ALU32_IMM(BPF_MOV, R1, 32),
  7378				BPF_ALU64_REG(BPF_RSH, R0, R1),
  7379				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7380				BPF_EXIT_INSN(),
  7381			},
  7382			INTERNAL,
  7383			{ },
  7384			{ { 0, 0 } }
  7385		},
  7386		{
  7387			"ALU64_RSH_X: Zero shift, low word",
  7388			.u.insns_int = {
  7389				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7390				BPF_ALU32_IMM(BPF_MOV, R1, 0),
  7391				BPF_ALU64_REG(BPF_RSH, R0, R1),
  7392				BPF_EXIT_INSN(),
  7393			},
  7394			INTERNAL,
  7395			{ },
  7396			{ { 0, 0x89abcdef } }
  7397		},
  7398		{
  7399			"ALU64_RSH_X: Zero shift, high word",
  7400			.u.insns_int = {
  7401				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7402				BPF_ALU32_IMM(BPF_MOV, R1, 0),
  7403				BPF_ALU64_REG(BPF_RSH, R0, R1),
  7404				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7405				BPF_EXIT_INSN(),
  7406			},
  7407			INTERNAL,
  7408			{ },
  7409			{ { 0, 0x81234567 } }
  7410		},
  7411		/* BPF_ALU | BPF_RSH | BPF_K */
  7412		{
  7413			"ALU_RSH_K: 2 >> 1 = 1",
  7414			.u.insns_int = {
  7415				BPF_LD_IMM64(R0, 2),
  7416				BPF_ALU32_IMM(BPF_RSH, R0, 1),
  7417				BPF_EXIT_INSN(),
  7418			},
  7419			INTERNAL,
  7420			{ },
  7421			{ { 0, 1 } },
  7422		},
  7423		{
  7424			"ALU_RSH_K: 0x80000000 >> 31 = 1",
  7425			.u.insns_int = {
  7426				BPF_LD_IMM64(R0, 0x80000000),
  7427				BPF_ALU32_IMM(BPF_RSH, R0, 31),
  7428				BPF_EXIT_INSN(),
  7429			},
  7430			INTERNAL,
  7431			{ },
  7432			{ { 0, 1 } },
  7433		},
  7434		{
  7435			"ALU_RSH_K: 0x12345678 >> 20 = 0x123",
  7436			.u.insns_int = {
  7437				BPF_ALU32_IMM(BPF_MOV, R0, 0x12345678),
  7438				BPF_ALU32_IMM(BPF_RSH, R0, 20),
  7439				BPF_EXIT_INSN(),
  7440			},
  7441			INTERNAL,
  7442			{ },
  7443			{ { 0, 0x123 } }
  7444		},
  7445		{
  7446			"ALU_RSH_K: 0x12345678 >> 0 = 0x12345678",
  7447			.u.insns_int = {
  7448				BPF_ALU32_IMM(BPF_MOV, R0, 0x12345678),
  7449				BPF_ALU32_IMM(BPF_RSH, R0, 0),
  7450				BPF_EXIT_INSN(),
  7451			},
  7452			INTERNAL,
  7453			{ },
  7454			{ { 0, 0x12345678 } }
  7455		},
  7456		{
  7457			"ALU64_RSH_K: 2 >> 1 = 1",
  7458			.u.insns_int = {
  7459				BPF_LD_IMM64(R0, 2),
  7460				BPF_ALU64_IMM(BPF_RSH, R0, 1),
  7461				BPF_EXIT_INSN(),
  7462			},
  7463			INTERNAL,
  7464			{ },
  7465			{ { 0, 1 } },
  7466		},
  7467		{
  7468			"ALU64_RSH_K: 0x80000000 >> 31 = 1",
  7469			.u.insns_int = {
  7470				BPF_LD_IMM64(R0, 0x80000000),
  7471				BPF_ALU64_IMM(BPF_RSH, R0, 31),
  7472				BPF_EXIT_INSN(),
  7473			},
  7474			INTERNAL,
  7475			{ },
  7476			{ { 0, 1 } },
  7477		},
  7478		{
  7479			"ALU64_RSH_K: Shift < 32, low word",
  7480			.u.insns_int = {
  7481				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7482				BPF_ALU64_IMM(BPF_RSH, R0, 12),
  7483				BPF_EXIT_INSN(),
  7484			},
  7485			INTERNAL,
  7486			{ },
  7487			{ { 0, 0x56789abc } }
  7488		},
  7489		{
  7490			"ALU64_RSH_K: Shift < 32, high word",
  7491			.u.insns_int = {
  7492				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7493				BPF_ALU64_IMM(BPF_RSH, R0, 12),
  7494				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7495				BPF_EXIT_INSN(),
  7496			},
  7497			INTERNAL,
  7498			{ },
  7499			{ { 0, 0x00081234 } }
  7500		},
  7501		{
  7502			"ALU64_RSH_K: Shift > 32, low word",
  7503			.u.insns_int = {
  7504				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7505				BPF_ALU64_IMM(BPF_RSH, R0, 36),
  7506				BPF_EXIT_INSN(),
  7507			},
  7508			INTERNAL,
  7509			{ },
  7510			{ { 0, 0x08123456 } }
  7511		},
  7512		{
  7513			"ALU64_RSH_K: Shift > 32, high word",
  7514			.u.insns_int = {
  7515				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7516				BPF_ALU64_IMM(BPF_RSH, R0, 36),
  7517				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7518				BPF_EXIT_INSN(),
  7519			},
  7520			INTERNAL,
  7521			{ },
  7522			{ { 0, 0 } }
  7523		},
  7524		{
  7525			"ALU64_RSH_K: Shift == 32, low word",
  7526			.u.insns_int = {
  7527				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7528				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7529				BPF_EXIT_INSN(),
  7530			},
  7531			INTERNAL,
  7532			{ },
  7533			{ { 0, 0x81234567 } }
  7534		},
  7535		{
  7536			"ALU64_RSH_K: Shift == 32, high word",
  7537			.u.insns_int = {
  7538				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7539				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7540				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7541				BPF_EXIT_INSN(),
  7542			},
  7543			INTERNAL,
  7544			{ },
  7545			{ { 0, 0 } }
  7546		},
  7547		{
  7548			"ALU64_RSH_K: Zero shift",
  7549			.u.insns_int = {
  7550				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  7551				BPF_ALU64_IMM(BPF_RSH, R0, 0),
  7552				BPF_EXIT_INSN(),
  7553			},
  7554			INTERNAL,
  7555			{ },
  7556			{ { 0, 0x89abcdef } }
  7557		},
  7558		/* BPF_ALU | BPF_ARSH | BPF_X */
  7559		{
  7560			"ALU32_ARSH_X: -1234 >> 7 = -10",
  7561			.u.insns_int = {
  7562				BPF_ALU32_IMM(BPF_MOV, R0, -1234),
  7563				BPF_ALU32_IMM(BPF_MOV, R1, 7),
  7564				BPF_ALU32_REG(BPF_ARSH, R0, R1),
  7565				BPF_EXIT_INSN(),
  7566			},
  7567			INTERNAL,
  7568			{ },
  7569			{ { 0, -10 } }
  7570		},
  7571		{
  7572			"ALU64_ARSH_X: 0xff00ff0000000000 >> 40 = 0xffffffffffff00ff",
  7573			.u.insns_int = {
  7574				BPF_LD_IMM64(R0, 0xff00ff0000000000LL),
  7575				BPF_ALU32_IMM(BPF_MOV, R1, 40),
  7576				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  7577				BPF_EXIT_INSN(),
  7578			},
  7579			INTERNAL,
  7580			{ },
  7581			{ { 0, 0xffff00ff } },
  7582		},
  7583		{
  7584			"ALU64_ARSH_X: Shift < 32, low word",
  7585			.u.insns_int = {
  7586				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7587				BPF_ALU32_IMM(BPF_MOV, R1, 12),
  7588				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  7589				BPF_EXIT_INSN(),
  7590			},
  7591			INTERNAL,
  7592			{ },
  7593			{ { 0, 0x56789abc } }
  7594		},
  7595		{
  7596			"ALU64_ARSH_X: Shift < 32, high word",
  7597			.u.insns_int = {
  7598				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7599				BPF_ALU32_IMM(BPF_MOV, R1, 12),
  7600				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  7601				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7602				BPF_EXIT_INSN(),
  7603			},
  7604			INTERNAL,
  7605			{ },
  7606			{ { 0, 0xfff81234 } }
  7607		},
  7608		{
  7609			"ALU64_ARSH_X: Shift > 32, low word",
  7610			.u.insns_int = {
  7611				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7612				BPF_ALU32_IMM(BPF_MOV, R1, 36),
  7613				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  7614				BPF_EXIT_INSN(),
  7615			},
  7616			INTERNAL,
  7617			{ },
  7618			{ { 0, 0xf8123456 } }
  7619		},
  7620		{
  7621			"ALU64_ARSH_X: Shift > 32, high word",
  7622			.u.insns_int = {
  7623				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7624				BPF_ALU32_IMM(BPF_MOV, R1, 36),
  7625				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  7626				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7627				BPF_EXIT_INSN(),
  7628			},
  7629			INTERNAL,
  7630			{ },
  7631			{ { 0, -1 } }
  7632		},
  7633		{
  7634			"ALU64_ARSH_X: Shift == 32, low word",
  7635			.u.insns_int = {
  7636				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7637				BPF_ALU32_IMM(BPF_MOV, R1, 32),
  7638				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  7639				BPF_EXIT_INSN(),
  7640			},
  7641			INTERNAL,
  7642			{ },
  7643			{ { 0, 0x81234567 } }
  7644		},
  7645		{
  7646			"ALU64_ARSH_X: Shift == 32, high word",
  7647			.u.insns_int = {
  7648				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7649				BPF_ALU32_IMM(BPF_MOV, R1, 32),
  7650				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  7651				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7652				BPF_EXIT_INSN(),
  7653			},
  7654			INTERNAL,
  7655			{ },
  7656			{ { 0, -1 } }
  7657		},
  7658		{
  7659			"ALU64_ARSH_X: Zero shift, low word",
  7660			.u.insns_int = {
  7661				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7662				BPF_ALU32_IMM(BPF_MOV, R1, 0),
  7663				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  7664				BPF_EXIT_INSN(),
  7665			},
  7666			INTERNAL,
  7667			{ },
  7668			{ { 0, 0x89abcdef } }
  7669		},
  7670		{
  7671			"ALU64_ARSH_X: Zero shift, high word",
  7672			.u.insns_int = {
  7673				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7674				BPF_ALU32_IMM(BPF_MOV, R1, 0),
  7675				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  7676				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7677				BPF_EXIT_INSN(),
  7678			},
  7679			INTERNAL,
  7680			{ },
  7681			{ { 0, 0x81234567 } }
  7682		},
  7683		/* BPF_ALU | BPF_ARSH | BPF_K */
  7684		{
  7685			"ALU32_ARSH_K: -1234 >> 7 = -10",
  7686			.u.insns_int = {
  7687				BPF_ALU32_IMM(BPF_MOV, R0, -1234),
  7688				BPF_ALU32_IMM(BPF_ARSH, R0, 7),
  7689				BPF_EXIT_INSN(),
  7690			},
  7691			INTERNAL,
  7692			{ },
  7693			{ { 0, -10 } }
  7694		},
  7695		{
  7696			"ALU32_ARSH_K: -1234 >> 0 = -1234",
  7697			.u.insns_int = {
  7698				BPF_ALU32_IMM(BPF_MOV, R0, -1234),
  7699				BPF_ALU32_IMM(BPF_ARSH, R0, 0),
  7700				BPF_EXIT_INSN(),
  7701			},
  7702			INTERNAL,
  7703			{ },
  7704			{ { 0, -1234 } }
  7705		},
  7706		{
  7707			"ALU64_ARSH_K: 0xff00ff0000000000 >> 40 = 0xffffffffffff00ff",
  7708			.u.insns_int = {
  7709				BPF_LD_IMM64(R0, 0xff00ff0000000000LL),
  7710				BPF_ALU64_IMM(BPF_ARSH, R0, 40),
  7711				BPF_EXIT_INSN(),
  7712			},
  7713			INTERNAL,
  7714			{ },
  7715			{ { 0, 0xffff00ff } },
  7716		},
  7717		{
  7718			"ALU64_ARSH_K: Shift < 32, low word",
  7719			.u.insns_int = {
  7720				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7721				BPF_ALU64_IMM(BPF_RSH, R0, 12),
  7722				BPF_EXIT_INSN(),
  7723			},
  7724			INTERNAL,
  7725			{ },
  7726			{ { 0, 0x56789abc } }
  7727		},
  7728		{
  7729			"ALU64_ARSH_K: Shift < 32, high word",
  7730			.u.insns_int = {
  7731				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7732				BPF_ALU64_IMM(BPF_ARSH, R0, 12),
  7733				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7734				BPF_EXIT_INSN(),
  7735			},
  7736			INTERNAL,
  7737			{ },
  7738			{ { 0, 0xfff81234 } }
  7739		},
  7740		{
  7741			"ALU64_ARSH_K: Shift > 32, low word",
  7742			.u.insns_int = {
  7743				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7744				BPF_ALU64_IMM(BPF_ARSH, R0, 36),
  7745				BPF_EXIT_INSN(),
  7746			},
  7747			INTERNAL,
  7748			{ },
  7749			{ { 0, 0xf8123456 } }
  7750		},
  7751		{
  7752			"ALU64_ARSH_K: Shift > 32, high word",
  7753			.u.insns_int = {
  7754				BPF_LD_IMM64(R0, 0xf123456789abcdefLL),
  7755				BPF_ALU64_IMM(BPF_ARSH, R0, 36),
  7756				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7757				BPF_EXIT_INSN(),
  7758			},
  7759			INTERNAL,
  7760			{ },
  7761			{ { 0, -1 } }
  7762		},
  7763		{
  7764			"ALU64_ARSH_K: Shift == 32, low word",
  7765			.u.insns_int = {
  7766				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7767				BPF_ALU64_IMM(BPF_ARSH, R0, 32),
  7768				BPF_EXIT_INSN(),
  7769			},
  7770			INTERNAL,
  7771			{ },
  7772			{ { 0, 0x81234567 } }
  7773		},
  7774		{
  7775			"ALU64_ARSH_K: Shift == 32, high word",
  7776			.u.insns_int = {
  7777				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7778				BPF_ALU64_IMM(BPF_ARSH, R0, 32),
  7779				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7780				BPF_EXIT_INSN(),
  7781			},
  7782			INTERNAL,
  7783			{ },
  7784			{ { 0, -1 } }
  7785		},
  7786		{
  7787			"ALU64_ARSH_K: Zero shift",
  7788			.u.insns_int = {
  7789				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  7790				BPF_ALU64_IMM(BPF_ARSH, R0, 0),
  7791				BPF_EXIT_INSN(),
  7792			},
  7793			INTERNAL,
  7794			{ },
  7795			{ { 0, 0x89abcdef } }
  7796		},
  7797		/* BPF_ALU | BPF_NEG */
  7798		{
  7799			"ALU_NEG: -(3) = -3",
  7800			.u.insns_int = {
  7801				BPF_ALU32_IMM(BPF_MOV, R0, 3),
  7802				BPF_ALU32_IMM(BPF_NEG, R0, 0),
  7803				BPF_EXIT_INSN(),
  7804			},
  7805			INTERNAL,
  7806			{ },
  7807			{ { 0, -3 } },
  7808		},
  7809		{
  7810			"ALU_NEG: -(-3) = 3",
  7811			.u.insns_int = {
  7812				BPF_ALU32_IMM(BPF_MOV, R0, -3),
  7813				BPF_ALU32_IMM(BPF_NEG, R0, 0),
  7814				BPF_EXIT_INSN(),
  7815			},
  7816			INTERNAL,
  7817			{ },
  7818			{ { 0, 3 } },
  7819		},
  7820		{
  7821			"ALU64_NEG: -(3) = -3",
  7822			.u.insns_int = {
  7823				BPF_LD_IMM64(R0, 3),
  7824				BPF_ALU64_IMM(BPF_NEG, R0, 0),
  7825				BPF_EXIT_INSN(),
  7826			},
  7827			INTERNAL,
  7828			{ },
  7829			{ { 0, -3 } },
  7830		},
  7831		{
  7832			"ALU64_NEG: -(-3) = 3",
  7833			.u.insns_int = {
  7834				BPF_LD_IMM64(R0, -3),
  7835				BPF_ALU64_IMM(BPF_NEG, R0, 0),
  7836				BPF_EXIT_INSN(),
  7837			},
  7838			INTERNAL,
  7839			{ },
  7840			{ { 0, 3 } },
  7841		},
  7842		/* BPF_ALU | BPF_END | BPF_FROM_BE */
  7843		{
  7844			"ALU_END_FROM_BE 16: 0x0123456789abcdef -> 0xcdef",
  7845			.u.insns_int = {
  7846				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  7847				BPF_ENDIAN(BPF_FROM_BE, R0, 16),
  7848				BPF_EXIT_INSN(),
  7849			},
  7850			INTERNAL,
  7851			{ },
  7852			{ { 0,  cpu_to_be16(0xcdef) } },
  7853		},
  7854		{
  7855			"ALU_END_FROM_BE 32: 0x0123456789abcdef -> 0x89abcdef",
  7856			.u.insns_int = {
  7857				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  7858				BPF_ENDIAN(BPF_FROM_BE, R0, 32),
  7859				BPF_ALU64_REG(BPF_MOV, R1, R0),
  7860				BPF_ALU64_IMM(BPF_RSH, R1, 32),
  7861				BPF_ALU32_REG(BPF_ADD, R0, R1), /* R1 = 0 */
  7862				BPF_EXIT_INSN(),
  7863			},
  7864			INTERNAL,
  7865			{ },
  7866			{ { 0, cpu_to_be32(0x89abcdef) } },
  7867		},
  7868		{
  7869			"ALU_END_FROM_BE 64: 0x0123456789abcdef -> 0x89abcdef",
  7870			.u.insns_int = {
  7871				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  7872				BPF_ENDIAN(BPF_FROM_BE, R0, 64),
  7873				BPF_EXIT_INSN(),
  7874			},
  7875			INTERNAL,
  7876			{ },
  7877			{ { 0, (u32) cpu_to_be64(0x0123456789abcdefLL) } },
  7878		},
  7879		{
  7880			"ALU_END_FROM_BE 64: 0x0123456789abcdef >> 32 -> 0x01234567",
  7881			.u.insns_int = {
  7882				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  7883				BPF_ENDIAN(BPF_FROM_BE, R0, 64),
  7884				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7885				BPF_EXIT_INSN(),
  7886			},
  7887			INTERNAL,
  7888			{ },
  7889			{ { 0, (u32) (cpu_to_be64(0x0123456789abcdefLL) >> 32) } },
  7890		},
  7891		/* BPF_ALU | BPF_END | BPF_FROM_BE, reversed */
  7892		{
  7893			"ALU_END_FROM_BE 16: 0xfedcba9876543210 -> 0x3210",
  7894			.u.insns_int = {
  7895				BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
  7896				BPF_ENDIAN(BPF_FROM_BE, R0, 16),
  7897				BPF_EXIT_INSN(),
  7898			},
  7899			INTERNAL,
  7900			{ },
  7901			{ { 0,  cpu_to_be16(0x3210) } },
  7902		},
  7903		{
  7904			"ALU_END_FROM_BE 32: 0xfedcba9876543210 -> 0x76543210",
  7905			.u.insns_int = {
  7906				BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
  7907				BPF_ENDIAN(BPF_FROM_BE, R0, 32),
  7908				BPF_ALU64_REG(BPF_MOV, R1, R0),
  7909				BPF_ALU64_IMM(BPF_RSH, R1, 32),
  7910				BPF_ALU32_REG(BPF_ADD, R0, R1), /* R1 = 0 */
  7911				BPF_EXIT_INSN(),
  7912			},
  7913			INTERNAL,
  7914			{ },
  7915			{ { 0, cpu_to_be32(0x76543210) } },
  7916		},
  7917		{
  7918			"ALU_END_FROM_BE 64: 0xfedcba9876543210 -> 0x76543210",
  7919			.u.insns_int = {
  7920				BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
  7921				BPF_ENDIAN(BPF_FROM_BE, R0, 64),
  7922				BPF_EXIT_INSN(),
  7923			},
  7924			INTERNAL,
  7925			{ },
  7926			{ { 0, (u32) cpu_to_be64(0xfedcba9876543210ULL) } },
  7927		},
  7928		{
  7929			"ALU_END_FROM_BE 64: 0xfedcba9876543210 >> 32 -> 0xfedcba98",
  7930			.u.insns_int = {
  7931				BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
  7932				BPF_ENDIAN(BPF_FROM_BE, R0, 64),
  7933				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7934				BPF_EXIT_INSN(),
  7935			},
  7936			INTERNAL,
  7937			{ },
  7938			{ { 0, (u32) (cpu_to_be64(0xfedcba9876543210ULL) >> 32) } },
  7939		},
  7940		/* BPF_ALU | BPF_END | BPF_FROM_LE */
  7941		{
  7942			"ALU_END_FROM_LE 16: 0x0123456789abcdef -> 0xefcd",
  7943			.u.insns_int = {
  7944				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  7945				BPF_ENDIAN(BPF_FROM_LE, R0, 16),
  7946				BPF_EXIT_INSN(),
  7947			},
  7948			INTERNAL,
  7949			{ },
  7950			{ { 0, cpu_to_le16(0xcdef) } },
  7951		},
  7952		{
  7953			"ALU_END_FROM_LE 32: 0x0123456789abcdef -> 0xefcdab89",
  7954			.u.insns_int = {
  7955				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  7956				BPF_ENDIAN(BPF_FROM_LE, R0, 32),
  7957				BPF_ALU64_REG(BPF_MOV, R1, R0),
  7958				BPF_ALU64_IMM(BPF_RSH, R1, 32),
  7959				BPF_ALU32_REG(BPF_ADD, R0, R1), /* R1 = 0 */
  7960				BPF_EXIT_INSN(),
  7961			},
  7962			INTERNAL,
  7963			{ },
  7964			{ { 0, cpu_to_le32(0x89abcdef) } },
  7965		},
  7966		{
  7967			"ALU_END_FROM_LE 64: 0x0123456789abcdef -> 0x67452301",
  7968			.u.insns_int = {
  7969				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  7970				BPF_ENDIAN(BPF_FROM_LE, R0, 64),
  7971				BPF_EXIT_INSN(),
  7972			},
  7973			INTERNAL,
  7974			{ },
  7975			{ { 0, (u32) cpu_to_le64(0x0123456789abcdefLL) } },
  7976		},
  7977		{
  7978			"ALU_END_FROM_LE 64: 0x0123456789abcdef >> 32 -> 0xefcdab89",
  7979			.u.insns_int = {
  7980				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  7981				BPF_ENDIAN(BPF_FROM_LE, R0, 64),
  7982				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  7983				BPF_EXIT_INSN(),
  7984			},
  7985			INTERNAL,
  7986			{ },
  7987			{ { 0, (u32) (cpu_to_le64(0x0123456789abcdefLL) >> 32) } },
  7988		},
  7989		/* BPF_ALU | BPF_END | BPF_FROM_LE, reversed */
  7990		{
  7991			"ALU_END_FROM_LE 16: 0xfedcba9876543210 -> 0x1032",
  7992			.u.insns_int = {
  7993				BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
  7994				BPF_ENDIAN(BPF_FROM_LE, R0, 16),
  7995				BPF_EXIT_INSN(),
  7996			},
  7997			INTERNAL,
  7998			{ },
  7999			{ { 0,  cpu_to_le16(0x3210) } },
  8000		},
  8001		{
  8002			"ALU_END_FROM_LE 32: 0xfedcba9876543210 -> 0x10325476",
  8003			.u.insns_int = {
  8004				BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
  8005				BPF_ENDIAN(BPF_FROM_LE, R0, 32),
  8006				BPF_ALU64_REG(BPF_MOV, R1, R0),
  8007				BPF_ALU64_IMM(BPF_RSH, R1, 32),
  8008				BPF_ALU32_REG(BPF_ADD, R0, R1), /* R1 = 0 */
  8009				BPF_EXIT_INSN(),
  8010			},
  8011			INTERNAL,
  8012			{ },
  8013			{ { 0, cpu_to_le32(0x76543210) } },
  8014		},
  8015		{
  8016			"ALU_END_FROM_LE 64: 0xfedcba9876543210 -> 0x10325476",
  8017			.u.insns_int = {
  8018				BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
  8019				BPF_ENDIAN(BPF_FROM_LE, R0, 64),
  8020				BPF_EXIT_INSN(),
  8021			},
  8022			INTERNAL,
  8023			{ },
  8024			{ { 0, (u32) cpu_to_le64(0xfedcba9876543210ULL) } },
  8025		},
  8026		{
  8027			"ALU_END_FROM_LE 64: 0xfedcba9876543210 >> 32 -> 0x98badcfe",
  8028			.u.insns_int = {
  8029				BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
  8030				BPF_ENDIAN(BPF_FROM_LE, R0, 64),
  8031				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  8032				BPF_EXIT_INSN(),
  8033			},
  8034			INTERNAL,
  8035			{ },
  8036			{ { 0, (u32) (cpu_to_le64(0xfedcba9876543210ULL) >> 32) } },
  8037		},
  8038		/* BSWAP */
  8039		{
  8040			"BSWAP 16: 0x0123456789abcdef -> 0xefcd",
  8041			.u.insns_int = {
  8042				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  8043				BPF_BSWAP(R0, 16),
  8044				BPF_EXIT_INSN(),
  8045			},
  8046			INTERNAL,
  8047			{ },
  8048			{ { 0, 0xefcd } },
  8049		},
  8050		{
  8051			"BSWAP 32: 0x0123456789abcdef -> 0xefcdab89",
  8052			.u.insns_int = {
  8053				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  8054				BPF_BSWAP(R0, 32),
  8055				BPF_ALU64_REG(BPF_MOV, R1, R0),
  8056				BPF_ALU64_IMM(BPF_RSH, R1, 32),
  8057				BPF_ALU32_REG(BPF_ADD, R0, R1), /* R1 = 0 */
  8058				BPF_EXIT_INSN(),
  8059			},
  8060			INTERNAL,
  8061			{ },
  8062			{ { 0, 0xefcdab89 } },
  8063		},
  8064		{
  8065			"BSWAP 64: 0x0123456789abcdef -> 0x67452301",
  8066			.u.insns_int = {
  8067				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  8068				BPF_BSWAP(R0, 64),
  8069				BPF_EXIT_INSN(),
  8070			},
  8071			INTERNAL,
  8072			{ },
  8073			{ { 0, 0x67452301 } },
  8074		},
  8075		{
  8076			"BSWAP 64: 0x0123456789abcdef >> 32 -> 0xefcdab89",
  8077			.u.insns_int = {
  8078				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  8079				BPF_BSWAP(R0, 64),
  8080				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  8081				BPF_EXIT_INSN(),
  8082			},
  8083			INTERNAL,
  8084			{ },
  8085			{ { 0, 0xefcdab89 } },
  8086		},
  8087		/* BSWAP, reversed */
  8088		{
  8089			"BSWAP 16: 0xfedcba9876543210 -> 0x1032",
  8090			.u.insns_int = {
  8091				BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
  8092				BPF_BSWAP(R0, 16),
  8093				BPF_EXIT_INSN(),
  8094			},
  8095			INTERNAL,
  8096			{ },
  8097			{ { 0, 0x1032 } },
  8098		},
  8099		{
  8100			"BSWAP 32: 0xfedcba9876543210 -> 0x10325476",
  8101			.u.insns_int = {
  8102				BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
  8103				BPF_BSWAP(R0, 32),
  8104				BPF_ALU64_REG(BPF_MOV, R1, R0),
  8105				BPF_ALU64_IMM(BPF_RSH, R1, 32),
  8106				BPF_ALU32_REG(BPF_ADD, R0, R1), /* R1 = 0 */
  8107				BPF_EXIT_INSN(),
  8108			},
  8109			INTERNAL,
  8110			{ },
  8111			{ { 0, 0x10325476 } },
  8112		},
  8113		{
  8114			"BSWAP 64: 0xfedcba9876543210 -> 0x98badcfe",
  8115			.u.insns_int = {
  8116				BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
  8117				BPF_BSWAP(R0, 64),
  8118				BPF_EXIT_INSN(),
  8119			},
  8120			INTERNAL,
  8121			{ },
  8122			{ { 0, 0x98badcfe } },
  8123		},
  8124		{
  8125			"BSWAP 64: 0xfedcba9876543210 >> 32 -> 0x10325476",
  8126			.u.insns_int = {
  8127				BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
  8128				BPF_BSWAP(R0, 64),
  8129				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  8130				BPF_EXIT_INSN(),
  8131			},
  8132			INTERNAL,
  8133			{ },
  8134			{ { 0, 0x10325476 } },
  8135		},
  8136		/* BPF_LDX_MEM B/H/W/DW */
  8137		{
  8138			"BPF_LDX_MEM | BPF_B, base",
  8139			.u.insns_int = {
  8140				BPF_LD_IMM64(R1, 0x0102030405060708ULL),
  8141				BPF_LD_IMM64(R2, 0x0000000000000008ULL),
  8142				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  8143	#ifdef __BIG_ENDIAN
  8144				BPF_LDX_MEM(BPF_B, R0, R10, -1),
  8145	#else
  8146				BPF_LDX_MEM(BPF_B, R0, R10, -8),
  8147	#endif
  8148				BPF_JMP_REG(BPF_JNE, R0, R2, 1),
  8149				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8150				BPF_EXIT_INSN(),
  8151			},
  8152			INTERNAL,
  8153			{ },
  8154			{ { 0, 0 } },
  8155			.stack_depth = 8,
  8156		},
  8157		{
  8158			"BPF_LDX_MEM | BPF_B, MSB set",
  8159			.u.insns_int = {
  8160				BPF_LD_IMM64(R1, 0x8182838485868788ULL),
  8161				BPF_LD_IMM64(R2, 0x0000000000000088ULL),
  8162				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  8163	#ifdef __BIG_ENDIAN
  8164				BPF_LDX_MEM(BPF_B, R0, R10, -1),
  8165	#else
  8166				BPF_LDX_MEM(BPF_B, R0, R10, -8),
  8167	#endif
  8168				BPF_JMP_REG(BPF_JNE, R0, R2, 1),
  8169				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8170				BPF_EXIT_INSN(),
  8171			},
  8172			INTERNAL,
  8173			{ },
  8174			{ { 0, 0 } },
  8175			.stack_depth = 8,
  8176		},
  8177		{
  8178			"BPF_LDX_MEM | BPF_B, negative offset",
  8179			.u.insns_int = {
  8180				BPF_LD_IMM64(R2, 0x8182838485868788ULL),
  8181				BPF_LD_IMM64(R3, 0x0000000000000088ULL),
  8182				BPF_ALU64_IMM(BPF_ADD, R1, 512),
  8183				BPF_STX_MEM(BPF_B, R1, R2, -256),
  8184				BPF_LDX_MEM(BPF_B, R0, R1, -256),
  8185				BPF_JMP_REG(BPF_JNE, R0, R3, 1),
  8186				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8187				BPF_EXIT_INSN(),
  8188			},
  8189			INTERNAL | FLAG_LARGE_MEM,
  8190			{ },
  8191			{ { 512, 0 } },
  8192			.stack_depth = 0,
  8193		},
  8194		{
  8195			"BPF_LDX_MEM | BPF_B, small positive offset",
  8196			.u.insns_int = {
  8197				BPF_LD_IMM64(R2, 0x8182838485868788ULL),
  8198				BPF_LD_IMM64(R3, 0x0000000000000088ULL),
  8199				BPF_STX_MEM(BPF_B, R1, R2, 256),
  8200				BPF_LDX_MEM(BPF_B, R0, R1, 256),
  8201				BPF_JMP_REG(BPF_JNE, R0, R3, 1),
  8202				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8203				BPF_EXIT_INSN(),
  8204			},
  8205			INTERNAL | FLAG_LARGE_MEM,
  8206			{ },
  8207			{ { 512, 0 } },
  8208			.stack_depth = 0,
  8209		},
  8210		{
  8211			"BPF_LDX_MEM | BPF_B, large positive offset",
  8212			.u.insns_int = {
  8213				BPF_LD_IMM64(R2, 0x8182838485868788ULL),
  8214				BPF_LD_IMM64(R3, 0x0000000000000088ULL),
  8215				BPF_STX_MEM(BPF_B, R1, R2, 4096),
  8216				BPF_LDX_MEM(BPF_B, R0, R1, 4096),
  8217				BPF_JMP_REG(BPF_JNE, R0, R3, 1),
  8218				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8219				BPF_EXIT_INSN(),
  8220			},
  8221			INTERNAL | FLAG_LARGE_MEM,
  8222			{ },
  8223			{ { 4096 + 16, 0 } },
  8224			.stack_depth = 0,
  8225		},
  8226		{
  8227			"BPF_LDX_MEM | BPF_H, base",
  8228			.u.insns_int = {
  8229				BPF_LD_IMM64(R1, 0x0102030405060708ULL),
  8230				BPF_LD_IMM64(R2, 0x0000000000000708ULL),
  8231				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  8232	#ifdef __BIG_ENDIAN
  8233				BPF_LDX_MEM(BPF_H, R0, R10, -2),
  8234	#else
  8235				BPF_LDX_MEM(BPF_H, R0, R10, -8),
  8236	#endif
  8237				BPF_JMP_REG(BPF_JNE, R0, R2, 1),
  8238				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8239				BPF_EXIT_INSN(),
  8240			},
  8241			INTERNAL,
  8242			{ },
  8243			{ { 0, 0 } },
  8244			.stack_depth = 8,
  8245		},
  8246		{
  8247			"BPF_LDX_MEM | BPF_H, MSB set",
  8248			.u.insns_int = {
  8249				BPF_LD_IMM64(R1, 0x8182838485868788ULL),
  8250				BPF_LD_IMM64(R2, 0x0000000000008788ULL),
  8251				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  8252	#ifdef __BIG_ENDIAN
  8253				BPF_LDX_MEM(BPF_H, R0, R10, -2),
  8254	#else
  8255				BPF_LDX_MEM(BPF_H, R0, R10, -8),
  8256	#endif
  8257				BPF_JMP_REG(BPF_JNE, R0, R2, 1),
  8258				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8259				BPF_EXIT_INSN(),
  8260			},
  8261			INTERNAL,
  8262			{ },
  8263			{ { 0, 0 } },
  8264			.stack_depth = 8,
  8265		},
  8266		{
  8267			"BPF_LDX_MEM | BPF_H, negative offset",
  8268			.u.insns_int = {
  8269				BPF_LD_IMM64(R2, 0x8182838485868788ULL),
  8270				BPF_LD_IMM64(R3, 0x0000000000008788ULL),
  8271				BPF_ALU64_IMM(BPF_ADD, R1, 512),
  8272				BPF_STX_MEM(BPF_H, R1, R2, -256),
  8273				BPF_LDX_MEM(BPF_H, R0, R1, -256),
  8274				BPF_JMP_REG(BPF_JNE, R0, R3, 1),
  8275				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8276				BPF_EXIT_INSN(),
  8277			},
  8278			INTERNAL | FLAG_LARGE_MEM,
  8279			{ },
  8280			{ { 512, 0 } },
  8281			.stack_depth = 0,
  8282		},
  8283		{
  8284			"BPF_LDX_MEM | BPF_H, small positive offset",
  8285			.u.insns_int = {
  8286				BPF_LD_IMM64(R2, 0x8182838485868788ULL),
  8287				BPF_LD_IMM64(R3, 0x0000000000008788ULL),
  8288				BPF_STX_MEM(BPF_H, R1, R2, 256),
  8289				BPF_LDX_MEM(BPF_H, R0, R1, 256),
  8290				BPF_JMP_REG(BPF_JNE, R0, R3, 1),
  8291				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8292				BPF_EXIT_INSN(),
  8293			},
  8294			INTERNAL | FLAG_LARGE_MEM,
  8295			{ },
  8296			{ { 512, 0 } },
  8297			.stack_depth = 0,
  8298		},
  8299		{
  8300			"BPF_LDX_MEM | BPF_H, large positive offset",
  8301			.u.insns_int = {
  8302				BPF_LD_IMM64(R2, 0x8182838485868788ULL),
  8303				BPF_LD_IMM64(R3, 0x0000000000008788ULL),
  8304				BPF_STX_MEM(BPF_H, R1, R2, 8192),
  8305				BPF_LDX_MEM(BPF_H, R0, R1, 8192),
  8306				BPF_JMP_REG(BPF_JNE, R0, R3, 1),
  8307				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8308				BPF_EXIT_INSN(),
  8309			},
  8310			INTERNAL | FLAG_LARGE_MEM,
  8311			{ },
  8312			{ { 8192 + 16, 0 } },
  8313			.stack_depth = 0,
  8314		},
  8315		{
  8316			"BPF_LDX_MEM | BPF_H, unaligned positive offset",
  8317			.u.insns_int = {
  8318				BPF_LD_IMM64(R2, 0x8182838485868788ULL),
  8319				BPF_LD_IMM64(R3, 0x0000000000008788ULL),
  8320				BPF_STX_MEM(BPF_H, R1, R2, 13),
  8321				BPF_LDX_MEM(BPF_H, R0, R1, 13),
  8322				BPF_JMP_REG(BPF_JNE, R0, R3, 1),
  8323				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8324				BPF_EXIT_INSN(),
  8325			},
  8326			INTERNAL | FLAG_LARGE_MEM,
  8327			{ },
  8328			{ { 32, 0 } },
  8329			.stack_depth = 0,
  8330		},
  8331		{
  8332			"BPF_LDX_MEM | BPF_W, base",
  8333			.u.insns_int = {
  8334				BPF_LD_IMM64(R1, 0x0102030405060708ULL),
  8335				BPF_LD_IMM64(R2, 0x0000000005060708ULL),
  8336				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  8337	#ifdef __BIG_ENDIAN
  8338				BPF_LDX_MEM(BPF_W, R0, R10, -4),
  8339	#else
  8340				BPF_LDX_MEM(BPF_W, R0, R10, -8),
  8341	#endif
  8342				BPF_JMP_REG(BPF_JNE, R0, R2, 1),
  8343				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8344				BPF_EXIT_INSN(),
  8345			},
  8346			INTERNAL,
  8347			{ },
  8348			{ { 0, 0 } },
  8349			.stack_depth = 8,
  8350		},
  8351		{
  8352			"BPF_LDX_MEM | BPF_W, MSB set",
  8353			.u.insns_int = {
  8354				BPF_LD_IMM64(R1, 0x8182838485868788ULL),
  8355				BPF_LD_IMM64(R2, 0x0000000085868788ULL),
  8356				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  8357	#ifdef __BIG_ENDIAN
  8358				BPF_LDX_MEM(BPF_W, R0, R10, -4),
  8359	#else
  8360				BPF_LDX_MEM(BPF_W, R0, R10, -8),
  8361	#endif
  8362				BPF_JMP_REG(BPF_JNE, R0, R2, 1),
  8363				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8364				BPF_EXIT_INSN(),
  8365			},
  8366			INTERNAL,
  8367			{ },
  8368			{ { 0, 0 } },
  8369			.stack_depth = 8,
  8370		},
  8371		{
  8372			"BPF_LDX_MEM | BPF_W, negative offset",
  8373			.u.insns_int = {
  8374				BPF_LD_IMM64(R2, 0x8182838485868788ULL),
  8375				BPF_LD_IMM64(R3, 0x0000000085868788ULL),
  8376				BPF_ALU64_IMM(BPF_ADD, R1, 512),
  8377				BPF_STX_MEM(BPF_W, R1, R2, -256),
  8378				BPF_LDX_MEM(BPF_W, R0, R1, -256),
  8379				BPF_JMP_REG(BPF_JNE, R0, R3, 1),
  8380				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8381				BPF_EXIT_INSN(),
  8382			},
  8383			INTERNAL | FLAG_LARGE_MEM,
  8384			{ },
  8385			{ { 512, 0 } },
  8386			.stack_depth = 0,
  8387		},
  8388		{
  8389			"BPF_LDX_MEM | BPF_W, small positive offset",
  8390			.u.insns_int = {
  8391				BPF_LD_IMM64(R2, 0x8182838485868788ULL),
  8392				BPF_LD_IMM64(R3, 0x0000000085868788ULL),
  8393				BPF_STX_MEM(BPF_W, R1, R2, 256),
  8394				BPF_LDX_MEM(BPF_W, R0, R1, 256),
  8395				BPF_JMP_REG(BPF_JNE, R0, R3, 1),
  8396				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8397				BPF_EXIT_INSN(),
  8398			},
  8399			INTERNAL | FLAG_LARGE_MEM,
  8400			{ },
  8401			{ { 512, 0 } },
  8402			.stack_depth = 0,
  8403		},
  8404		{
  8405			"BPF_LDX_MEM | BPF_W, large positive offset",
  8406			.u.insns_int = {
  8407				BPF_LD_IMM64(R2, 0x8182838485868788ULL),
  8408				BPF_LD_IMM64(R3, 0x0000000085868788ULL),
  8409				BPF_STX_MEM(BPF_W, R1, R2, 16384),
  8410				BPF_LDX_MEM(BPF_W, R0, R1, 16384),
  8411				BPF_JMP_REG(BPF_JNE, R0, R3, 1),
  8412				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8413				BPF_EXIT_INSN(),
  8414			},
  8415			INTERNAL | FLAG_LARGE_MEM,
  8416			{ },
  8417			{ { 16384 + 16, 0 } },
  8418			.stack_depth = 0,
  8419		},
  8420		{
  8421			"BPF_LDX_MEM | BPF_W, unaligned positive offset",
  8422			.u.insns_int = {
  8423				BPF_LD_IMM64(R2, 0x8182838485868788ULL),
  8424				BPF_LD_IMM64(R3, 0x0000000085868788ULL),
  8425				BPF_STX_MEM(BPF_W, R1, R2, 13),
  8426				BPF_LDX_MEM(BPF_W, R0, R1, 13),
  8427				BPF_JMP_REG(BPF_JNE, R0, R3, 1),
  8428				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8429				BPF_EXIT_INSN(),
  8430			},
  8431			INTERNAL | FLAG_LARGE_MEM,
  8432			{ },
  8433			{ { 32, 0 } },
  8434			.stack_depth = 0,
  8435		},
  8436		{
  8437			"BPF_LDX_MEM | BPF_DW, base",
  8438			.u.insns_int = {
  8439				BPF_LD_IMM64(R1, 0x0102030405060708ULL),
  8440				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  8441				BPF_LDX_MEM(BPF_DW, R0, R10, -8),
  8442				BPF_JMP_REG(BPF_JNE, R0, R1, 1),
  8443				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8444				BPF_EXIT_INSN(),
  8445			},
  8446			INTERNAL,
  8447			{ },
  8448			{ { 0, 0 } },
  8449			.stack_depth = 8,
  8450		},
  8451		{
  8452			"BPF_LDX_MEM | BPF_DW, MSB set",
  8453			.u.insns_int = {
  8454				BPF_LD_IMM64(R1, 0x8182838485868788ULL),
  8455				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  8456				BPF_LDX_MEM(BPF_DW, R0, R10, -8),
  8457				BPF_JMP_REG(BPF_JNE, R0, R1, 1),
  8458				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8459				BPF_EXIT_INSN(),
  8460			},
  8461			INTERNAL,
  8462			{ },
  8463			{ { 0, 0 } },
  8464			.stack_depth = 8,
  8465		},
  8466		{
  8467			"BPF_LDX_MEM | BPF_DW, negative offset",
  8468			.u.insns_int = {
  8469				BPF_LD_IMM64(R2, 0x8182838485868788ULL),
  8470				BPF_ALU64_IMM(BPF_ADD, R1, 512),
  8471				BPF_STX_MEM(BPF_DW, R1, R2, -256),
  8472				BPF_LDX_MEM(BPF_DW, R0, R1, -256),
  8473				BPF_JMP_REG(BPF_JNE, R0, R2, 1),
  8474				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8475				BPF_EXIT_INSN(),
  8476			},
  8477			INTERNAL | FLAG_LARGE_MEM,
  8478			{ },
  8479			{ { 512, 0 } },
  8480			.stack_depth = 0,
  8481		},
  8482		{
  8483			"BPF_LDX_MEM | BPF_DW, small positive offset",
  8484			.u.insns_int = {
  8485				BPF_LD_IMM64(R2, 0x8182838485868788ULL),
  8486				BPF_STX_MEM(BPF_DW, R1, R2, 256),
  8487				BPF_LDX_MEM(BPF_DW, R0, R1, 256),
  8488				BPF_JMP_REG(BPF_JNE, R0, R2, 1),
  8489				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8490				BPF_EXIT_INSN(),
  8491			},
  8492			INTERNAL | FLAG_LARGE_MEM,
  8493			{ },
  8494			{ { 512, 0 } },
  8495			.stack_depth = 8,
  8496		},
  8497		{
  8498			"BPF_LDX_MEM | BPF_DW, large positive offset",
  8499			.u.insns_int = {
  8500				BPF_LD_IMM64(R2, 0x8182838485868788ULL),
  8501				BPF_STX_MEM(BPF_DW, R1, R2, 32760),
  8502				BPF_LDX_MEM(BPF_DW, R0, R1, 32760),
  8503				BPF_JMP_REG(BPF_JNE, R0, R2, 1),
  8504				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8505				BPF_EXIT_INSN(),
  8506			},
  8507			INTERNAL | FLAG_LARGE_MEM,
  8508			{ },
  8509			{ { 32768, 0 } },
  8510			.stack_depth = 0,
  8511		},
  8512		{
  8513			"BPF_LDX_MEM | BPF_DW, unaligned positive offset",
  8514			.u.insns_int = {
  8515				BPF_LD_IMM64(R2, 0x8182838485868788ULL),
  8516				BPF_STX_MEM(BPF_DW, R1, R2, 13),
  8517				BPF_LDX_MEM(BPF_DW, R0, R1, 13),
  8518				BPF_JMP_REG(BPF_JNE, R0, R2, 1),
  8519				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8520				BPF_EXIT_INSN(),
  8521			},
  8522			INTERNAL | FLAG_LARGE_MEM,
  8523			{ },
  8524			{ { 32, 0 } },
  8525			.stack_depth = 0,
  8526		},
  8527		/* BPF_LDX_MEMSX B/H/W */
  8528		{
  8529			"BPF_LDX_MEMSX | BPF_B",
  8530			.u.insns_int = {
> 8531				BPF_LD_IMM64(R1, 0xdead0000000000f0ULL),
  8532				BPF_LD_IMM64(R2, 0xfffffffffffffff0ULL),
  8533				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  8534	#ifdef __BIG_ENDIAN
  8535				BPF_LDX_MEMSX(BPF_B, R0, R10, -1),
  8536	#else
  8537				BPF_LDX_MEMSX(BPF_B, R0, R10, -8),
  8538	#endif
  8539				BPF_JMP_REG(BPF_JNE, R0, R2, 1),
  8540				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8541				BPF_EXIT_INSN(),
  8542			},
  8543			INTERNAL,
  8544			{ },
  8545			{ { 0, 0 } },
  8546			.stack_depth = 8,
  8547		},
  8548		{
  8549			"BPF_LDX_MEMSX | BPF_H",
  8550			.u.insns_int = {
> 8551				BPF_LD_IMM64(R1, 0xdead00000000f123ULL),
  8552				BPF_LD_IMM64(R2, 0xfffffffffffff123ULL),
  8553				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  8554	#ifdef __BIG_ENDIAN
  8555				BPF_LDX_MEMSX(BPF_H, R0, R10, -2),
  8556	#else
  8557				BPF_LDX_MEMSX(BPF_H, R0, R10, -8),
  8558	#endif
  8559				BPF_JMP_REG(BPF_JNE, R0, R2, 1),
  8560				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8561				BPF_EXIT_INSN(),
  8562			},
  8563			INTERNAL,
  8564			{ },
  8565			{ { 0, 0 } },
  8566			.stack_depth = 8,
  8567		},
  8568		{
  8569			"BPF_LDX_MEMSX | BPF_W",
  8570			.u.insns_int = {
  8571				BPF_LD_IMM64(R1, 0x00000000deadbeefULL),
  8572				BPF_LD_IMM64(R2, 0xffffffffdeadbeefULL),
  8573				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  8574	#ifdef __BIG_ENDIAN
  8575				BPF_LDX_MEMSX(BPF_W, R0, R10, -4),
  8576	#else
  8577				BPF_LDX_MEMSX(BPF_W, R0, R10, -8),
  8578	#endif
  8579				BPF_JMP_REG(BPF_JNE, R0, R2, 1),
  8580				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8581				BPF_EXIT_INSN(),
  8582			},
  8583			INTERNAL,
  8584			{ },
  8585			{ { 0, 0 } },
  8586			.stack_depth = 8,
  8587		},
  8588		/* BPF_STX_MEM B/H/W/DW */
  8589		{
  8590			"BPF_STX_MEM | BPF_B",
  8591			.u.insns_int = {
  8592				BPF_LD_IMM64(R1, 0x8090a0b0c0d0e0f0ULL),
  8593				BPF_LD_IMM64(R2, 0x0102030405060708ULL),
  8594				BPF_LD_IMM64(R3, 0x8090a0b0c0d0e008ULL),
  8595				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  8596	#ifdef __BIG_ENDIAN
  8597				BPF_STX_MEM(BPF_B, R10, R2, -1),
  8598	#else
  8599				BPF_STX_MEM(BPF_B, R10, R2, -8),
  8600	#endif
  8601				BPF_LDX_MEM(BPF_DW, R0, R10, -8),
  8602				BPF_JMP_REG(BPF_JNE, R0, R3, 1),
  8603				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8604				BPF_EXIT_INSN(),
  8605			},
  8606			INTERNAL,
  8607			{ },
  8608			{ { 0, 0 } },
  8609			.stack_depth = 8,
  8610		},
  8611		{
  8612			"BPF_STX_MEM | BPF_B, MSB set",
  8613			.u.insns_int = {
  8614				BPF_LD_IMM64(R1, 0x8090a0b0c0d0e0f0ULL),
  8615				BPF_LD_IMM64(R2, 0x8182838485868788ULL),
  8616				BPF_LD_IMM64(R3, 0x8090a0b0c0d0e088ULL),
  8617				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  8618	#ifdef __BIG_ENDIAN
  8619				BPF_STX_MEM(BPF_B, R10, R2, -1),
  8620	#else
  8621				BPF_STX_MEM(BPF_B, R10, R2, -8),
  8622	#endif
  8623				BPF_LDX_MEM(BPF_DW, R0, R10, -8),
  8624				BPF_JMP_REG(BPF_JNE, R0, R3, 1),
  8625				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8626				BPF_EXIT_INSN(),
  8627			},
  8628			INTERNAL,
  8629			{ },
  8630			{ { 0, 0 } },
  8631			.stack_depth = 8,
  8632		},
  8633		{
  8634			"BPF_STX_MEM | BPF_H",
  8635			.u.insns_int = {
  8636				BPF_LD_IMM64(R1, 0x8090a0b0c0d0e0f0ULL),
  8637				BPF_LD_IMM64(R2, 0x0102030405060708ULL),
  8638				BPF_LD_IMM64(R3, 0x8090a0b0c0d00708ULL),
  8639				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  8640	#ifdef __BIG_ENDIAN
  8641				BPF_STX_MEM(BPF_H, R10, R2, -2),
  8642	#else
  8643				BPF_STX_MEM(BPF_H, R10, R2, -8),
  8644	#endif
  8645				BPF_LDX_MEM(BPF_DW, R0, R10, -8),
  8646				BPF_JMP_REG(BPF_JNE, R0, R3, 1),
  8647				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8648				BPF_EXIT_INSN(),
  8649			},
  8650			INTERNAL,
  8651			{ },
  8652			{ { 0, 0 } },
  8653			.stack_depth = 8,
  8654		},
  8655		{
  8656			"BPF_STX_MEM | BPF_H, MSB set",
  8657			.u.insns_int = {
  8658				BPF_LD_IMM64(R1, 0x8090a0b0c0d0e0f0ULL),
  8659				BPF_LD_IMM64(R2, 0x8182838485868788ULL),
  8660				BPF_LD_IMM64(R3, 0x8090a0b0c0d08788ULL),
  8661				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  8662	#ifdef __BIG_ENDIAN
  8663				BPF_STX_MEM(BPF_H, R10, R2, -2),
  8664	#else
  8665				BPF_STX_MEM(BPF_H, R10, R2, -8),
  8666	#endif
  8667				BPF_LDX_MEM(BPF_DW, R0, R10, -8),
  8668				BPF_JMP_REG(BPF_JNE, R0, R3, 1),
  8669				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8670				BPF_EXIT_INSN(),
  8671			},
  8672			INTERNAL,
  8673			{ },
  8674			{ { 0, 0 } },
  8675			.stack_depth = 8,
  8676		},
  8677		{
  8678			"BPF_STX_MEM | BPF_W",
  8679			.u.insns_int = {
  8680				BPF_LD_IMM64(R1, 0x8090a0b0c0d0e0f0ULL),
  8681				BPF_LD_IMM64(R2, 0x0102030405060708ULL),
  8682				BPF_LD_IMM64(R3, 0x8090a0b005060708ULL),
  8683				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  8684	#ifdef __BIG_ENDIAN
  8685				BPF_STX_MEM(BPF_W, R10, R2, -4),
  8686	#else
  8687				BPF_STX_MEM(BPF_W, R10, R2, -8),
  8688	#endif
  8689				BPF_LDX_MEM(BPF_DW, R0, R10, -8),
  8690				BPF_JMP_REG(BPF_JNE, R0, R3, 1),
  8691				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8692				BPF_EXIT_INSN(),
  8693			},
  8694			INTERNAL,
  8695			{ },
  8696			{ { 0, 0 } },
  8697			.stack_depth = 8,
  8698		},
  8699		{
  8700			"BPF_STX_MEM | BPF_W, MSB set",
  8701			.u.insns_int = {
  8702				BPF_LD_IMM64(R1, 0x8090a0b0c0d0e0f0ULL),
  8703				BPF_LD_IMM64(R2, 0x8182838485868788ULL),
  8704				BPF_LD_IMM64(R3, 0x8090a0b085868788ULL),
  8705				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  8706	#ifdef __BIG_ENDIAN
  8707				BPF_STX_MEM(BPF_W, R10, R2, -4),
  8708	#else
  8709				BPF_STX_MEM(BPF_W, R10, R2, -8),
  8710	#endif
  8711				BPF_LDX_MEM(BPF_DW, R0, R10, -8),
  8712				BPF_JMP_REG(BPF_JNE, R0, R3, 1),
  8713				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  8714				BPF_EXIT_INSN(),
  8715			},
  8716			INTERNAL,
  8717			{ },
  8718			{ { 0, 0 } },
  8719			.stack_depth = 8,
  8720		},
  8721		/* BPF_ST(X) | BPF_MEM | BPF_B/H/W/DW */
  8722		{
  8723			"ST_MEM_B: Store/Load byte: max negative",
  8724			.u.insns_int = {
  8725				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8726				BPF_ST_MEM(BPF_B, R10, -40, 0xff),
  8727				BPF_LDX_MEM(BPF_B, R0, R10, -40),
  8728				BPF_EXIT_INSN(),
  8729			},
  8730			INTERNAL,
  8731			{ },
  8732			{ { 0, 0xff } },
  8733			.stack_depth = 40,
  8734		},
  8735		{
  8736			"ST_MEM_B: Store/Load byte: max positive",
  8737			.u.insns_int = {
  8738				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8739				BPF_ST_MEM(BPF_H, R10, -40, 0x7f),
  8740				BPF_LDX_MEM(BPF_H, R0, R10, -40),
  8741				BPF_EXIT_INSN(),
  8742			},
  8743			INTERNAL,
  8744			{ },
  8745			{ { 0, 0x7f } },
  8746			.stack_depth = 40,
  8747		},
  8748		{
  8749			"STX_MEM_B: Store/Load byte: max negative",
  8750			.u.insns_int = {
  8751				BPF_LD_IMM64(R0, 0),
  8752				BPF_LD_IMM64(R1, 0xffLL),
  8753				BPF_STX_MEM(BPF_B, R10, R1, -40),
  8754				BPF_LDX_MEM(BPF_B, R0, R10, -40),
  8755				BPF_EXIT_INSN(),
  8756			},
  8757			INTERNAL,
  8758			{ },
  8759			{ { 0, 0xff } },
  8760			.stack_depth = 40,
  8761		},
  8762		{
  8763			"ST_MEM_H: Store/Load half word: max negative",
  8764			.u.insns_int = {
  8765				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8766				BPF_ST_MEM(BPF_H, R10, -40, 0xffff),
  8767				BPF_LDX_MEM(BPF_H, R0, R10, -40),
  8768				BPF_EXIT_INSN(),
  8769			},
  8770			INTERNAL,
  8771			{ },
  8772			{ { 0, 0xffff } },
  8773			.stack_depth = 40,
  8774		},
  8775		{
  8776			"ST_MEM_H: Store/Load half word: max positive",
  8777			.u.insns_int = {
  8778				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8779				BPF_ST_MEM(BPF_H, R10, -40, 0x7fff),
  8780				BPF_LDX_MEM(BPF_H, R0, R10, -40),
  8781				BPF_EXIT_INSN(),
  8782			},
  8783			INTERNAL,
  8784			{ },
  8785			{ { 0, 0x7fff } },
  8786			.stack_depth = 40,
  8787		},
  8788		{
  8789			"STX_MEM_H: Store/Load half word: max negative",
  8790			.u.insns_int = {
  8791				BPF_LD_IMM64(R0, 0),
  8792				BPF_LD_IMM64(R1, 0xffffLL),
  8793				BPF_STX_MEM(BPF_H, R10, R1, -40),
  8794				BPF_LDX_MEM(BPF_H, R0, R10, -40),
  8795				BPF_EXIT_INSN(),
  8796			},
  8797			INTERNAL,
  8798			{ },
  8799			{ { 0, 0xffff } },
  8800			.stack_depth = 40,
  8801		},
  8802		{
  8803			"ST_MEM_W: Store/Load word: max negative",
  8804			.u.insns_int = {
  8805				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8806				BPF_ST_MEM(BPF_W, R10, -40, 0xffffffff),
  8807				BPF_LDX_MEM(BPF_W, R0, R10, -40),
  8808				BPF_EXIT_INSN(),
  8809			},
  8810			INTERNAL,
  8811			{ },
  8812			{ { 0, 0xffffffff } },
  8813			.stack_depth = 40,
  8814		},
  8815		{
  8816			"ST_MEM_W: Store/Load word: max positive",
  8817			.u.insns_int = {
  8818				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8819				BPF_ST_MEM(BPF_W, R10, -40, 0x7fffffff),
  8820				BPF_LDX_MEM(BPF_W, R0, R10, -40),
  8821				BPF_EXIT_INSN(),
  8822			},
  8823			INTERNAL,
  8824			{ },
  8825			{ { 0, 0x7fffffff } },
  8826			.stack_depth = 40,
  8827		},
  8828		{
  8829			"STX_MEM_W: Store/Load word: max negative",
  8830			.u.insns_int = {
  8831				BPF_LD_IMM64(R0, 0),
  8832				BPF_LD_IMM64(R1, 0xffffffffLL),
  8833				BPF_STX_MEM(BPF_W, R10, R1, -40),
  8834				BPF_LDX_MEM(BPF_W, R0, R10, -40),
  8835				BPF_EXIT_INSN(),
  8836			},
  8837			INTERNAL,
  8838			{ },
  8839			{ { 0, 0xffffffff } },
  8840			.stack_depth = 40,
  8841		},
  8842		{
  8843			"ST_MEM_DW: Store/Load double word: max negative",
  8844			.u.insns_int = {
  8845				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8846				BPF_ST_MEM(BPF_DW, R10, -40, 0xffffffff),
  8847				BPF_LDX_MEM(BPF_DW, R0, R10, -40),
  8848				BPF_EXIT_INSN(),
  8849			},
  8850			INTERNAL,
  8851			{ },
  8852			{ { 0, 0xffffffff } },
  8853			.stack_depth = 40,
  8854		},
  8855		{
  8856			"ST_MEM_DW: Store/Load double word: max negative 2",
  8857			.u.insns_int = {
  8858				BPF_LD_IMM64(R2, 0xffff00000000ffffLL),
  8859				BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
  8860				BPF_ST_MEM(BPF_DW, R10, -40, 0xffffffff),
  8861				BPF_LDX_MEM(BPF_DW, R2, R10, -40),
  8862				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  8863				BPF_MOV32_IMM(R0, 2),
  8864				BPF_EXIT_INSN(),
  8865				BPF_MOV32_IMM(R0, 1),
  8866				BPF_EXIT_INSN(),
  8867			},
  8868			INTERNAL,
  8869			{ },
  8870			{ { 0, 0x1 } },
  8871			.stack_depth = 40,
  8872		},
  8873		{
  8874			"ST_MEM_DW: Store/Load double word: max positive",
  8875			.u.insns_int = {
  8876				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8877				BPF_ST_MEM(BPF_DW, R10, -40, 0x7fffffff),
  8878				BPF_LDX_MEM(BPF_DW, R0, R10, -40),
  8879				BPF_EXIT_INSN(),
  8880			},
  8881			INTERNAL,
  8882			{ },
  8883			{ { 0, 0x7fffffff } },
  8884			.stack_depth = 40,
  8885		},
  8886		{
  8887			"STX_MEM_DW: Store/Load double word: max negative",
  8888			.u.insns_int = {
  8889				BPF_LD_IMM64(R0, 0),
  8890				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  8891				BPF_STX_MEM(BPF_DW, R10, R1, -40),
  8892				BPF_LDX_MEM(BPF_DW, R0, R10, -40),
  8893				BPF_EXIT_INSN(),
  8894			},
  8895			INTERNAL,
  8896			{ },
  8897			{ { 0, 0xffffffff } },
  8898			.stack_depth = 40,
  8899		},
  8900		{
  8901			"STX_MEM_DW: Store double word: first word in memory",
  8902			.u.insns_int = {
  8903				BPF_LD_IMM64(R0, 0),
  8904				BPF_LD_IMM64(R1, 0x0123456789abcdefLL),
  8905				BPF_STX_MEM(BPF_DW, R10, R1, -40),
  8906				BPF_LDX_MEM(BPF_W, R0, R10, -40),
  8907				BPF_EXIT_INSN(),
  8908			},
  8909			INTERNAL,
  8910			{ },
  8911	#ifdef __BIG_ENDIAN
  8912			{ { 0, 0x01234567 } },
  8913	#else
  8914			{ { 0, 0x89abcdef } },
  8915	#endif
  8916			.stack_depth = 40,
  8917		},
  8918		{
  8919			"STX_MEM_DW: Store double word: second word in memory",
  8920			.u.insns_int = {
  8921				BPF_LD_IMM64(R0, 0),
  8922				BPF_LD_IMM64(R1, 0x0123456789abcdefLL),
  8923				BPF_STX_MEM(BPF_DW, R10, R1, -40),
  8924				BPF_LDX_MEM(BPF_W, R0, R10, -36),
  8925				BPF_EXIT_INSN(),
  8926			},
  8927			INTERNAL,
  8928			{ },
  8929	#ifdef __BIG_ENDIAN
  8930			{ { 0, 0x89abcdef } },
  8931	#else
  8932			{ { 0, 0x01234567 } },
  8933	#endif
  8934			.stack_depth = 40,
  8935		},
  8936		/* BPF_STX | BPF_ATOMIC | BPF_W/DW */
  8937		{
  8938			"STX_XADD_W: X + 1 + 1 + 1 + ...",
  8939			{ },
  8940			INTERNAL,
  8941			{ },
  8942			{ { 0, 4134 } },
  8943			.fill_helper = bpf_fill_stxw,
  8944		},
  8945		{
  8946			"STX_XADD_DW: X + 1 + 1 + 1 + ...",
  8947			{ },
  8948			INTERNAL,
  8949			{ },
  8950			{ { 0, 4134 } },
  8951			.fill_helper = bpf_fill_stxdw,
  8952		},
  8953		/*
  8954		 * Exhaustive tests of atomic operation variants.
  8955		 * Individual tests are expanded from template macros for all
  8956		 * combinations of ALU operation, word size and fetching.
  8957		 */
  8958	#define BPF_ATOMIC_POISON(width) ((width) == BPF_W ? (0xbaadf00dULL << 32) : 0)
  8959	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
