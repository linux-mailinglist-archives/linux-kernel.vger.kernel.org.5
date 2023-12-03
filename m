Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABA480224D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 10:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjLCJiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 04:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjLCJiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 04:38:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8462E8
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 01:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701596280; x=1733132280;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=u9aFPG7yUn/Gictim0aOPqpsVxD7Ay6HogtkcdS1zkM=;
  b=e0IUh8BMgTneMZQSWEJC9lgC0jkLxAM4Jx/ODpP+2RgXc0yWP7AVsvyZ
   zNEVpUGML73tjqYiWqN/dIO+rmjaaVd+MdHMMpJ/wCtXNCfT006fIyOdB
   xeBxq/w0zUANROQT5egh46oFiKB+LimWAOOdpJkwUaz8pXaL6QE+YbuDh
   A/FYpmDoMgB5HnndToMox2pTFEnTo2Bb+ZDKSMt4tTsQxKPEJZjc6AOUW
   qhmN78vVtsy0pXSlTUKOmIO6LBTjYSpDP1BPFhoUrXCzc49Qb+Jd7wS/C
   mUZ8BB5x9x6vaWMBeWeR3E/5O2gjiJW8ojl+K50iJ0jGrjZiq6/1Dhfrw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="397521554"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="397521554"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 01:37:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="943588097"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="943588097"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 03 Dec 2023 01:37:56 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9ivC-0006VN-0M;
        Sun, 03 Dec 2023 09:37:54 +0000
Date:   Sun, 3 Dec 2023 17:37:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johan Almbladh <johan.almbladh@anyfinetworks.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: lib/test_bpf.c:7035:25: sparse: sparse: cast truncates bits from
 constant value (8090a0b0c0d0e0f0 becomes c0d0e0f0)
Message-ID: <202312031741.0OFS5NYL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   968f35f4ab1c0966ceb39af3c89f2e24afedf878
commit: caaaa1667bf198c54cc3141ad92ca6ce853e99cd bpf/tests: Add tests of BPF_LDX and BPF_STX with small sizes
date:   2 years, 2 months ago
config: mips-randconfig-r123-20231130 (https://download.01.org/0day-ci/archive/20231203/202312031741.0OFS5NYL-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20231203/202312031741.0OFS5NYL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312031741.0OFS5NYL-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   lib/test_bpf.c:4754:25: sparse: sparse: cast truncates bits from constant value (fedcba987654321 becomes 87654321)
   lib/test_bpf.c:4755:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef0 becomes 9abcdef0)
   lib/test_bpf.c:4877:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4888:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5275:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5313:25: sparse: sparse: cast truncates bits from constant value (ffffffff0000 becomes ffff0000)
   lib/test_bpf.c:5329:25: sparse: sparse: cast truncates bits from constant value (ffffffff0000 becomes ffff0000)
   lib/test_bpf.c:5330:25: sparse: sparse: cast truncates bits from constant value (ffffffff0000 becomes ffff0000)
   lib/test_bpf.c:5361:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5377:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5378:25: sparse: sparse: cast truncates bits from constant value (123456780a0c0e0 becomes 80a0c0e0)
   lib/test_bpf.c:5487:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5525:25: sparse: sparse: cast truncates bits from constant value (ffffffff0000 becomes ffff0000)
   lib/test_bpf.c:5526:25: sparse: sparse: cast truncates bits from constant value (ffffffff0000 becomes ffff0000)
   lib/test_bpf.c:5541:25: sparse: sparse: cast truncates bits from constant value (ffffffff0000 becomes ffff0000)
   lib/test_bpf.c:5573:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5574:25: sparse: sparse: cast truncates bits from constant value (12345678fafcfef becomes 8fafcfef)
   lib/test_bpf.c:5589:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5699:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5737:25: sparse: sparse: cast truncates bits from constant value (ffffffff0000 becomes ffff0000)
   lib/test_bpf.c:5738:25: sparse: sparse: cast truncates bits from constant value (ffffffff0000 becomes ffff0000)
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
>> lib/test_bpf.c:7035:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e0f0 becomes c0d0e0f0)
   lib/test_bpf.c:7036:25: sparse: sparse: cast truncates bits from constant value (102030405060708 becomes 5060708)
>> lib/test_bpf.c:7037:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e008 becomes c0d0e008)
   lib/test_bpf.c:7057:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e0f0 becomes c0d0e0f0)
   lib/test_bpf.c:7058:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
>> lib/test_bpf.c:7059:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e088 becomes c0d0e088)
   lib/test_bpf.c:7079:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e0f0 becomes c0d0e0f0)
   lib/test_bpf.c:7080:25: sparse: sparse: cast truncates bits from constant value (102030405060708 becomes 5060708)
>> lib/test_bpf.c:7081:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d00708 becomes c0d00708)
   lib/test_bpf.c:7101:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e0f0 becomes c0d0e0f0)
   lib/test_bpf.c:7102:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
>> lib/test_bpf.c:7103:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d08788 becomes c0d08788)
   lib/test_bpf.c:7123:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e0f0 becomes c0d0e0f0)
   lib/test_bpf.c:7124:25: sparse: sparse: cast truncates bits from constant value (102030405060708 becomes 5060708)
>> lib/test_bpf.c:7125:25: sparse: sparse: cast truncates bits from constant value (8090a0b005060708 becomes 5060708)
   lib/test_bpf.c:7145:25: sparse: sparse: cast truncates bits from constant value (8090a0b0c0d0e0f0 becomes c0d0e0f0)
   lib/test_bpf.c:7146:25: sparse: sparse: cast truncates bits from constant value (8182838485868788 becomes 85868788)
>> lib/test_bpf.c:7147:25: sparse: sparse: cast truncates bits from constant value (8090a0b085868788 becomes 85868788)
   lib/test_bpf.c:7301:25: sparse: sparse: cast truncates bits from constant value (ffff00000000ffff becomes ffff)
   lib/test_bpf.c:7347:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7365:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7641:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7642:25: sparse: sparse: cast truncates bits from constant value (fecdba9876543210 becomes 76543210)
   lib/test_bpf.c:7658:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7659:25: sparse: sparse: cast truncates bits from constant value (fecdba9876543210 becomes 76543210)
   lib/test_bpf.c:7676:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7677:25: sparse: sparse: cast truncates bits from constant value (fecdba9876543210 becomes 76543210)
   lib/test_bpf.c:7694:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7695:25: sparse: sparse: cast truncates bits from constant value (fecdba9876543210 becomes 76543210)
   lib/test_bpf.c:7713:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7714:25: sparse: sparse: cast truncates bits from constant value (fecdba9876543210 becomes 76543210)
   lib/test_bpf.c:7718:25: sparse: sparse: cast truncates bits from constant value (fecdba9876543210 becomes 76543210)
   lib/test_bpf.c:8921:25: sparse: sparse: cast truncates bits from constant value (eeeeeeeeeeeeeeee becomes eeeeeeee)
   lib/test_bpf.c:8950:25: sparse: sparse: cast truncates bits from constant value (eeeeeeeeeeeeeeee becomes eeeeeeee)
   lib/test_bpf.c:8965:25: sparse: sparse: cast truncates bits from constant value (eeeeeeeeeeeeeeee becomes eeeeeeee)
   lib/test_bpf.c:8994:25: sparse: sparse: cast truncates bits from constant value (eeeeeeeeeeeeeeee becomes eeeeeeee)

vim +7035 lib/test_bpf.c

  1990	
  1991	
  1992	static struct bpf_test tests[] = {
  1993		{
  1994			"TAX",
  1995			.u.insns = {
  1996				BPF_STMT(BPF_LD | BPF_IMM, 1),
  1997				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  1998				BPF_STMT(BPF_LD | BPF_IMM, 2),
  1999				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  2000				BPF_STMT(BPF_ALU | BPF_NEG, 0), /* A == -3 */
  2001				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2002				BPF_STMT(BPF_LD | BPF_LEN, 0),
  2003				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  2004				BPF_STMT(BPF_MISC | BPF_TAX, 0), /* X == len - 3 */
  2005				BPF_STMT(BPF_LD | BPF_B | BPF_IND, 1),
  2006				BPF_STMT(BPF_RET | BPF_A, 0)
  2007			},
  2008			CLASSIC,
  2009			{ 10, 20, 30, 40, 50 },
  2010			{ { 2, 10 }, { 3, 20 }, { 4, 30 } },
  2011		},
  2012		{
  2013			"TXA",
  2014			.u.insns = {
  2015				BPF_STMT(BPF_LDX | BPF_LEN, 0),
  2016				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  2017				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  2018				BPF_STMT(BPF_RET | BPF_A, 0) /* A == len * 2 */
  2019			},
  2020			CLASSIC,
  2021			{ 10, 20, 30, 40, 50 },
  2022			{ { 1, 2 }, { 3, 6 }, { 4, 8 } },
  2023		},
  2024		{
  2025			"ADD_SUB_MUL_K",
  2026			.u.insns = {
  2027				BPF_STMT(BPF_LD | BPF_IMM, 1),
  2028				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 2),
  2029				BPF_STMT(BPF_LDX | BPF_IMM, 3),
  2030				BPF_STMT(BPF_ALU | BPF_SUB | BPF_X, 0),
  2031				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 0xffffffff),
  2032				BPF_STMT(BPF_ALU | BPF_MUL | BPF_K, 3),
  2033				BPF_STMT(BPF_RET | BPF_A, 0)
  2034			},
  2035			CLASSIC | FLAG_NO_DATA,
  2036			{ },
  2037			{ { 0, 0xfffffffd } }
  2038		},
  2039		{
  2040			"DIV_MOD_KX",
  2041			.u.insns = {
  2042				BPF_STMT(BPF_LD | BPF_IMM, 8),
  2043				BPF_STMT(BPF_ALU | BPF_DIV | BPF_K, 2),
  2044				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2045				BPF_STMT(BPF_LD | BPF_IMM, 0xffffffff),
  2046				BPF_STMT(BPF_ALU | BPF_DIV | BPF_X, 0),
  2047				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2048				BPF_STMT(BPF_LD | BPF_IMM, 0xffffffff),
  2049				BPF_STMT(BPF_ALU | BPF_DIV | BPF_K, 0x70000000),
  2050				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2051				BPF_STMT(BPF_LD | BPF_IMM, 0xffffffff),
  2052				BPF_STMT(BPF_ALU | BPF_MOD | BPF_X, 0),
  2053				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2054				BPF_STMT(BPF_LD | BPF_IMM, 0xffffffff),
  2055				BPF_STMT(BPF_ALU | BPF_MOD | BPF_K, 0x70000000),
  2056				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  2057				BPF_STMT(BPF_RET | BPF_A, 0)
  2058			},
  2059			CLASSIC | FLAG_NO_DATA,
  2060			{ },
  2061			{ { 0, 0x20000000 } }
  2062		},
  2063		{
  2064			"AND_OR_LSH_K",
  2065			.u.insns = {
  2066				BPF_STMT(BPF_LD | BPF_IMM, 0xff),
  2067				BPF_STMT(BPF_ALU | BPF_AND | BPF_K, 0xf0),
  2068				BPF_STMT(BPF_ALU | BPF_LSH | BPF_K, 27),
  2069				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2070				BPF_STMT(BPF_LD | BPF_IMM, 0xf),
  2071				BPF_STMT(BPF_ALU | BPF_OR | BPF_K, 0xf0),
  2072				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  2073				BPF_STMT(BPF_RET | BPF_A, 0)
  2074			},
  2075			CLASSIC | FLAG_NO_DATA,
  2076			{ },
  2077			{ { 0, 0x800000ff }, { 1, 0x800000ff } },
  2078		},
  2079		{
  2080			"LD_IMM_0",
  2081			.u.insns = {
  2082				BPF_STMT(BPF_LD | BPF_IMM, 0), /* ld #0 */
  2083				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0, 1, 0),
  2084				BPF_STMT(BPF_RET | BPF_K, 0),
  2085				BPF_STMT(BPF_RET | BPF_K, 1),
  2086			},
  2087			CLASSIC,
  2088			{ },
  2089			{ { 1, 1 } },
  2090		},
  2091		{
  2092			"LD_IND",
  2093			.u.insns = {
  2094				BPF_STMT(BPF_LDX | BPF_LEN, 0),
  2095				BPF_STMT(BPF_LD | BPF_H | BPF_IND, MAX_K),
  2096				BPF_STMT(BPF_RET | BPF_K, 1)
  2097			},
  2098			CLASSIC,
  2099			{ },
  2100			{ { 1, 0 }, { 10, 0 }, { 60, 0 } },
  2101		},
  2102		{
  2103			"LD_ABS",
  2104			.u.insns = {
  2105				BPF_STMT(BPF_LD | BPF_W | BPF_ABS, 1000),
  2106				BPF_STMT(BPF_RET | BPF_K, 1)
  2107			},
  2108			CLASSIC,
  2109			{ },
  2110			{ { 1, 0 }, { 10, 0 }, { 60, 0 } },
  2111		},
  2112		{
  2113			"LD_ABS_LL",
  2114			.u.insns = {
  2115				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, SKF_LL_OFF),
  2116				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2117				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, SKF_LL_OFF + 1),
  2118				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  2119				BPF_STMT(BPF_RET | BPF_A, 0)
  2120			},
  2121			CLASSIC,
  2122			{ 1, 2, 3 },
  2123			{ { 1, 0 }, { 2, 3 } },
  2124		},
  2125		{
  2126			"LD_IND_LL",
  2127			.u.insns = {
  2128				BPF_STMT(BPF_LD | BPF_IMM, SKF_LL_OFF - 1),
  2129				BPF_STMT(BPF_LDX | BPF_LEN, 0),
  2130				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  2131				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2132				BPF_STMT(BPF_LD | BPF_B | BPF_IND, 0),
  2133				BPF_STMT(BPF_RET | BPF_A, 0)
  2134			},
  2135			CLASSIC,
  2136			{ 1, 2, 3, 0xff },
  2137			{ { 1, 1 }, { 3, 3 }, { 4, 0xff } },
  2138		},
  2139		{
  2140			"LD_ABS_NET",
  2141			.u.insns = {
  2142				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, SKF_NET_OFF),
  2143				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2144				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, SKF_NET_OFF + 1),
  2145				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  2146				BPF_STMT(BPF_RET | BPF_A, 0)
  2147			},
  2148			CLASSIC,
  2149			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3 },
  2150			{ { 15, 0 }, { 16, 3 } },
  2151		},
  2152		{
  2153			"LD_IND_NET",
  2154			.u.insns = {
  2155				BPF_STMT(BPF_LD | BPF_IMM, SKF_NET_OFF - 15),
  2156				BPF_STMT(BPF_LDX | BPF_LEN, 0),
  2157				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  2158				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2159				BPF_STMT(BPF_LD | BPF_B | BPF_IND, 0),
  2160				BPF_STMT(BPF_RET | BPF_A, 0)
  2161			},
  2162			CLASSIC,
  2163			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3 },
  2164			{ { 14, 0 }, { 15, 1 }, { 17, 3 } },
  2165		},
  2166		{
  2167			"LD_PKTTYPE",
  2168			.u.insns = {
  2169				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2170					 SKF_AD_OFF + SKF_AD_PKTTYPE),
  2171				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, SKB_TYPE, 1, 0),
  2172				BPF_STMT(BPF_RET | BPF_K, 1),
  2173				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2174					 SKF_AD_OFF + SKF_AD_PKTTYPE),
  2175				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, SKB_TYPE, 1, 0),
  2176				BPF_STMT(BPF_RET | BPF_K, 1),
  2177				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2178					 SKF_AD_OFF + SKF_AD_PKTTYPE),
  2179				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, SKB_TYPE, 1, 0),
  2180				BPF_STMT(BPF_RET | BPF_K, 1),
  2181				BPF_STMT(BPF_RET | BPF_A, 0)
  2182			},
  2183			CLASSIC,
  2184			{ },
  2185			{ { 1, 3 }, { 10, 3 } },
  2186		},
  2187		{
  2188			"LD_MARK",
  2189			.u.insns = {
  2190				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2191					 SKF_AD_OFF + SKF_AD_MARK),
  2192				BPF_STMT(BPF_RET | BPF_A, 0)
  2193			},
  2194			CLASSIC,
  2195			{ },
  2196			{ { 1, SKB_MARK}, { 10, SKB_MARK} },
  2197		},
  2198		{
  2199			"LD_RXHASH",
  2200			.u.insns = {
  2201				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2202					 SKF_AD_OFF + SKF_AD_RXHASH),
  2203				BPF_STMT(BPF_RET | BPF_A, 0)
  2204			},
  2205			CLASSIC,
  2206			{ },
  2207			{ { 1, SKB_HASH}, { 10, SKB_HASH} },
  2208		},
  2209		{
  2210			"LD_QUEUE",
  2211			.u.insns = {
  2212				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2213					 SKF_AD_OFF + SKF_AD_QUEUE),
  2214				BPF_STMT(BPF_RET | BPF_A, 0)
  2215			},
  2216			CLASSIC,
  2217			{ },
  2218			{ { 1, SKB_QUEUE_MAP }, { 10, SKB_QUEUE_MAP } },
  2219		},
  2220		{
  2221			"LD_PROTOCOL",
  2222			.u.insns = {
  2223				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 1),
  2224				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 20, 1, 0),
  2225				BPF_STMT(BPF_RET | BPF_K, 0),
  2226				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2227					 SKF_AD_OFF + SKF_AD_PROTOCOL),
  2228				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2229				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 2),
  2230				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 30, 1, 0),
  2231				BPF_STMT(BPF_RET | BPF_K, 0),
  2232				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  2233				BPF_STMT(BPF_RET | BPF_A, 0)
  2234			},
  2235			CLASSIC,
  2236			{ 10, 20, 30 },
  2237			{ { 10, ETH_P_IP }, { 100, ETH_P_IP } },
  2238		},
  2239		{
  2240			"LD_VLAN_TAG",
  2241			.u.insns = {
  2242				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2243					 SKF_AD_OFF + SKF_AD_VLAN_TAG),
  2244				BPF_STMT(BPF_RET | BPF_A, 0)
  2245			},
  2246			CLASSIC,
  2247			{ },
  2248			{
  2249				{ 1, SKB_VLAN_TCI },
  2250				{ 10, SKB_VLAN_TCI }
  2251			},
  2252		},
  2253		{
  2254			"LD_VLAN_TAG_PRESENT",
  2255			.u.insns = {
  2256				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2257					 SKF_AD_OFF + SKF_AD_VLAN_TAG_PRESENT),
  2258				BPF_STMT(BPF_RET | BPF_A, 0)
  2259			},
  2260			CLASSIC,
  2261			{ },
  2262			{
  2263				{ 1, SKB_VLAN_PRESENT },
  2264				{ 10, SKB_VLAN_PRESENT }
  2265			},
  2266		},
  2267		{
  2268			"LD_IFINDEX",
  2269			.u.insns = {
  2270				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2271					 SKF_AD_OFF + SKF_AD_IFINDEX),
  2272				BPF_STMT(BPF_RET | BPF_A, 0)
  2273			},
  2274			CLASSIC,
  2275			{ },
  2276			{ { 1, SKB_DEV_IFINDEX }, { 10, SKB_DEV_IFINDEX } },
  2277		},
  2278		{
  2279			"LD_HATYPE",
  2280			.u.insns = {
  2281				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2282					 SKF_AD_OFF + SKF_AD_HATYPE),
  2283				BPF_STMT(BPF_RET | BPF_A, 0)
  2284			},
  2285			CLASSIC,
  2286			{ },
  2287			{ { 1, SKB_DEV_TYPE }, { 10, SKB_DEV_TYPE } },
  2288		},
  2289		{
  2290			"LD_CPU",
  2291			.u.insns = {
  2292				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2293					 SKF_AD_OFF + SKF_AD_CPU),
  2294				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2295				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2296					 SKF_AD_OFF + SKF_AD_CPU),
  2297				BPF_STMT(BPF_ALU | BPF_SUB | BPF_X, 0),
  2298				BPF_STMT(BPF_RET | BPF_A, 0)
  2299			},
  2300			CLASSIC,
  2301			{ },
  2302			{ { 1, 0 }, { 10, 0 } },
  2303		},
  2304		{
  2305			"LD_NLATTR",
  2306			.u.insns = {
  2307				BPF_STMT(BPF_LDX | BPF_IMM, 2),
  2308				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  2309				BPF_STMT(BPF_LDX | BPF_IMM, 3),
  2310				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2311					 SKF_AD_OFF + SKF_AD_NLATTR),
  2312				BPF_STMT(BPF_RET | BPF_A, 0)
  2313			},
  2314			CLASSIC,
  2315	#ifdef __BIG_ENDIAN
  2316			{ 0xff, 0xff, 0, 4, 0, 2, 0, 4, 0, 3 },
  2317	#else
  2318			{ 0xff, 0xff, 4, 0, 2, 0, 4, 0, 3, 0 },
  2319	#endif
  2320			{ { 4, 0 }, { 20, 6 } },
  2321		},
  2322		{
  2323			"LD_NLATTR_NEST",
  2324			.u.insns = {
  2325				BPF_STMT(BPF_LD | BPF_IMM, 2),
  2326				BPF_STMT(BPF_LDX | BPF_IMM, 3),
  2327				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2328					 SKF_AD_OFF + SKF_AD_NLATTR_NEST),
  2329				BPF_STMT(BPF_LD | BPF_IMM, 2),
  2330				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2331					 SKF_AD_OFF + SKF_AD_NLATTR_NEST),
  2332				BPF_STMT(BPF_LD | BPF_IMM, 2),
  2333				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2334					 SKF_AD_OFF + SKF_AD_NLATTR_NEST),
  2335				BPF_STMT(BPF_LD | BPF_IMM, 2),
  2336				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2337					 SKF_AD_OFF + SKF_AD_NLATTR_NEST),
  2338				BPF_STMT(BPF_LD | BPF_IMM, 2),
  2339				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2340					 SKF_AD_OFF + SKF_AD_NLATTR_NEST),
  2341				BPF_STMT(BPF_LD | BPF_IMM, 2),
  2342				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2343					 SKF_AD_OFF + SKF_AD_NLATTR_NEST),
  2344				BPF_STMT(BPF_LD | BPF_IMM, 2),
  2345				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2346					 SKF_AD_OFF + SKF_AD_NLATTR_NEST),
  2347				BPF_STMT(BPF_LD | BPF_IMM, 2),
  2348				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2349					 SKF_AD_OFF + SKF_AD_NLATTR_NEST),
  2350				BPF_STMT(BPF_RET | BPF_A, 0)
  2351			},
  2352			CLASSIC,
  2353	#ifdef __BIG_ENDIAN
  2354			{ 0xff, 0xff, 0, 12, 0, 1, 0, 4, 0, 2, 0, 4, 0, 3 },
  2355	#else
  2356			{ 0xff, 0xff, 12, 0, 1, 0, 4, 0, 2, 0, 4, 0, 3, 0 },
  2357	#endif
  2358			{ { 4, 0 }, { 20, 10 } },
  2359		},
  2360		{
  2361			"LD_PAYLOAD_OFF",
  2362			.u.insns = {
  2363				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2364					 SKF_AD_OFF + SKF_AD_PAY_OFFSET),
  2365				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2366					 SKF_AD_OFF + SKF_AD_PAY_OFFSET),
  2367				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2368					 SKF_AD_OFF + SKF_AD_PAY_OFFSET),
  2369				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2370					 SKF_AD_OFF + SKF_AD_PAY_OFFSET),
  2371				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2372					 SKF_AD_OFF + SKF_AD_PAY_OFFSET),
  2373				BPF_STMT(BPF_RET | BPF_A, 0)
  2374			},
  2375			CLASSIC,
  2376			/* 00:00:00:00:00:00 > 00:00:00:00:00:00, ethtype IPv4 (0x0800),
  2377			 * length 98: 127.0.0.1 > 127.0.0.1: ICMP echo request,
  2378			 * id 9737, seq 1, length 64
  2379			 */
  2380			{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
  2381			  0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
  2382			  0x08, 0x00,
  2383			  0x45, 0x00, 0x00, 0x54, 0xac, 0x8b, 0x40, 0x00, 0x40,
  2384			  0x01, 0x90, 0x1b, 0x7f, 0x00, 0x00, 0x01 },
  2385			{ { 30, 0 }, { 100, 42 } },
  2386		},
  2387		{
  2388			"LD_ANC_XOR",
  2389			.u.insns = {
  2390				BPF_STMT(BPF_LD | BPF_IMM, 10),
  2391				BPF_STMT(BPF_LDX | BPF_IMM, 300),
  2392				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2393					 SKF_AD_OFF + SKF_AD_ALU_XOR_X),
  2394				BPF_STMT(BPF_RET | BPF_A, 0)
  2395			},
  2396			CLASSIC,
  2397			{ },
  2398			{ { 4, 0xA ^ 300 }, { 20, 0xA ^ 300 } },
  2399		},
  2400		{
  2401			"SPILL_FILL",
  2402			.u.insns = {
  2403				BPF_STMT(BPF_LDX | BPF_LEN, 0),
  2404				BPF_STMT(BPF_LD | BPF_IMM, 2),
  2405				BPF_STMT(BPF_ALU | BPF_RSH, 1),
  2406				BPF_STMT(BPF_ALU | BPF_XOR | BPF_X, 0),
  2407				BPF_STMT(BPF_ST, 1), /* M1 = 1 ^ len */
  2408				BPF_STMT(BPF_ALU | BPF_XOR | BPF_K, 0x80000000),
  2409				BPF_STMT(BPF_ST, 2), /* M2 = 1 ^ len ^ 0x80000000 */
  2410				BPF_STMT(BPF_STX, 15), /* M3 = len */
  2411				BPF_STMT(BPF_LDX | BPF_MEM, 1),
  2412				BPF_STMT(BPF_LD | BPF_MEM, 2),
  2413				BPF_STMT(BPF_ALU | BPF_XOR | BPF_X, 0),
  2414				BPF_STMT(BPF_LDX | BPF_MEM, 15),
  2415				BPF_STMT(BPF_ALU | BPF_XOR | BPF_X, 0),
  2416				BPF_STMT(BPF_RET | BPF_A, 0)
  2417			},
  2418			CLASSIC,
  2419			{ },
  2420			{ { 1, 0x80000001 }, { 2, 0x80000002 }, { 60, 0x80000000 ^ 60 } }
  2421		},
  2422		{
  2423			"JEQ",
  2424			.u.insns = {
  2425				BPF_STMT(BPF_LDX | BPF_LEN, 0),
  2426				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 2),
  2427				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_X, 0, 0, 1),
  2428				BPF_STMT(BPF_RET | BPF_K, 1),
  2429				BPF_STMT(BPF_RET | BPF_K, MAX_K)
  2430			},
  2431			CLASSIC,
  2432			{ 3, 3, 3, 3, 3 },
  2433			{ { 1, 0 }, { 3, 1 }, { 4, MAX_K } },
  2434		},
  2435		{
  2436			"JGT",
  2437			.u.insns = {
  2438				BPF_STMT(BPF_LDX | BPF_LEN, 0),
  2439				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 2),
  2440				BPF_JUMP(BPF_JMP | BPF_JGT | BPF_X, 0, 0, 1),
  2441				BPF_STMT(BPF_RET | BPF_K, 1),
  2442				BPF_STMT(BPF_RET | BPF_K, MAX_K)
  2443			},
  2444			CLASSIC,
  2445			{ 4, 4, 4, 3, 3 },
  2446			{ { 2, 0 }, { 3, 1 }, { 4, MAX_K } },
  2447		},
  2448		{
  2449			"JGE (jt 0), test 1",
  2450			.u.insns = {
  2451				BPF_STMT(BPF_LDX | BPF_LEN, 0),
  2452				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 2),
  2453				BPF_JUMP(BPF_JMP | BPF_JGE | BPF_X, 0, 0, 1),
  2454				BPF_STMT(BPF_RET | BPF_K, 1),
  2455				BPF_STMT(BPF_RET | BPF_K, MAX_K)
  2456			},
  2457			CLASSIC,
  2458			{ 4, 4, 4, 3, 3 },
  2459			{ { 2, 0 }, { 3, 1 }, { 4, 1 } },
  2460		},
  2461		{
  2462			"JGE (jt 0), test 2",
  2463			.u.insns = {
  2464				BPF_STMT(BPF_LDX | BPF_LEN, 0),
  2465				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 2),
  2466				BPF_JUMP(BPF_JMP | BPF_JGE | BPF_X, 0, 0, 1),
  2467				BPF_STMT(BPF_RET | BPF_K, 1),
  2468				BPF_STMT(BPF_RET | BPF_K, MAX_K)
  2469			},
  2470			CLASSIC,
  2471			{ 4, 4, 5, 3, 3 },
  2472			{ { 4, 1 }, { 5, 1 }, { 6, MAX_K } },
  2473		},
  2474		{
  2475			"JGE",
  2476			.u.insns = {
  2477				BPF_STMT(BPF_LDX | BPF_LEN, 0),
  2478				BPF_STMT(BPF_LD | BPF_B | BPF_IND, MAX_K),
  2479				BPF_JUMP(BPF_JMP | BPF_JGE | BPF_K, 1, 1, 0),
  2480				BPF_STMT(BPF_RET | BPF_K, 10),
  2481				BPF_JUMP(BPF_JMP | BPF_JGE | BPF_K, 2, 1, 0),
  2482				BPF_STMT(BPF_RET | BPF_K, 20),
  2483				BPF_JUMP(BPF_JMP | BPF_JGE | BPF_K, 3, 1, 0),
  2484				BPF_STMT(BPF_RET | BPF_K, 30),
  2485				BPF_JUMP(BPF_JMP | BPF_JGE | BPF_K, 4, 1, 0),
  2486				BPF_STMT(BPF_RET | BPF_K, 40),
  2487				BPF_STMT(BPF_RET | BPF_K, MAX_K)
  2488			},
  2489			CLASSIC,
  2490			{ 1, 2, 3, 4, 5 },
  2491			{ { 1, 20 }, { 3, 40 }, { 5, MAX_K } },
  2492		},
  2493		{
  2494			"JSET",
  2495			.u.insns = {
  2496				BPF_JUMP(BPF_JMP | BPF_JA, 0, 0, 0),
  2497				BPF_JUMP(BPF_JMP | BPF_JA, 1, 1, 1),
  2498				BPF_JUMP(BPF_JMP | BPF_JA, 0, 0, 0),
  2499				BPF_JUMP(BPF_JMP | BPF_JA, 0, 0, 0),
  2500				BPF_STMT(BPF_LDX | BPF_LEN, 0),
  2501				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  2502				BPF_STMT(BPF_ALU | BPF_SUB | BPF_K, 4),
  2503				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2504				BPF_STMT(BPF_LD | BPF_W | BPF_IND, 0),
  2505				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 1, 0, 1),
  2506				BPF_STMT(BPF_RET | BPF_K, 10),
  2507				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0x80000000, 0, 1),
  2508				BPF_STMT(BPF_RET | BPF_K, 20),
  2509				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0xffffff, 1, 0),
  2510				BPF_STMT(BPF_RET | BPF_K, 30),
  2511				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0xffffff, 1, 0),
  2512				BPF_STMT(BPF_RET | BPF_K, 30),
  2513				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0xffffff, 1, 0),
  2514				BPF_STMT(BPF_RET | BPF_K, 30),
  2515				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0xffffff, 1, 0),
  2516				BPF_STMT(BPF_RET | BPF_K, 30),
  2517				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0xffffff, 1, 0),
  2518				BPF_STMT(BPF_RET | BPF_K, 30),
  2519				BPF_STMT(BPF_RET | BPF_K, MAX_K)
  2520			},
  2521			CLASSIC,
  2522			{ 0, 0xAA, 0x55, 1 },
  2523			{ { 4, 10 }, { 5, 20 }, { 6, MAX_K } },
  2524		},
  2525		{
  2526			"tcpdump port 22",
  2527			.u.insns = {
  2528				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 12),
  2529				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x86dd, 0, 8), /* IPv6 */
  2530				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 20),
  2531				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x84, 2, 0),
  2532				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x6, 1, 0),
  2533				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x11, 0, 17),
  2534				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 54),
  2535				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 22, 14, 0),
  2536				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 56),
  2537				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 22, 12, 13),
  2538				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x0800, 0, 12), /* IPv4 */
  2539				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 23),
  2540				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x84, 2, 0),
  2541				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x6, 1, 0),
  2542				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x11, 0, 8),
  2543				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 20),
  2544				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0x1fff, 6, 0),
  2545				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 14),
  2546				BPF_STMT(BPF_LD | BPF_H | BPF_IND, 14),
  2547				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 22, 2, 0),
  2548				BPF_STMT(BPF_LD | BPF_H | BPF_IND, 16),
  2549				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 22, 0, 1),
  2550				BPF_STMT(BPF_RET | BPF_K, 0xffff),
  2551				BPF_STMT(BPF_RET | BPF_K, 0),
  2552			},
  2553			CLASSIC,
  2554			/* 3c:07:54:43:e5:76 > 10:bf:48:d6:43:d6, ethertype IPv4(0x0800)
  2555			 * length 114: 10.1.1.149.49700 > 10.1.2.10.22: Flags [P.],
  2556			 * seq 1305692979:1305693027, ack 3650467037, win 65535,
  2557			 * options [nop,nop,TS val 2502645400 ecr 3971138], length 48
  2558			 */
  2559			{ 0x10, 0xbf, 0x48, 0xd6, 0x43, 0xd6,
  2560			  0x3c, 0x07, 0x54, 0x43, 0xe5, 0x76,
  2561			  0x08, 0x00,
  2562			  0x45, 0x10, 0x00, 0x64, 0x75, 0xb5,
  2563			  0x40, 0x00, 0x40, 0x06, 0xad, 0x2e, /* IP header */
  2564			  0x0a, 0x01, 0x01, 0x95, /* ip src */
  2565			  0x0a, 0x01, 0x02, 0x0a, /* ip dst */
  2566			  0xc2, 0x24,
  2567			  0x00, 0x16 /* dst port */ },
  2568			{ { 10, 0 }, { 30, 0 }, { 100, 65535 } },
  2569		},
  2570		{
  2571			"tcpdump complex",
  2572			.u.insns = {
  2573				/* tcpdump -nei eth0 'tcp port 22 and (((ip[2:2] -
  2574				 * ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0) and
  2575				 * (len > 115 or len < 30000000000)' -d
  2576				 */
  2577				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 12),
  2578				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x86dd, 30, 0),
  2579				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x800, 0, 29),
  2580				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 23),
  2581				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x6, 0, 27),
  2582				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 20),
  2583				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0x1fff, 25, 0),
  2584				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 14),
  2585				BPF_STMT(BPF_LD | BPF_H | BPF_IND, 14),
  2586				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 22, 2, 0),
  2587				BPF_STMT(BPF_LD | BPF_H | BPF_IND, 16),
  2588				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 22, 0, 20),
  2589				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 16),
  2590				BPF_STMT(BPF_ST, 1),
  2591				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 14),
  2592				BPF_STMT(BPF_ALU | BPF_AND | BPF_K, 0xf),
  2593				BPF_STMT(BPF_ALU | BPF_LSH | BPF_K, 2),
  2594				BPF_STMT(BPF_MISC | BPF_TAX, 0x5), /* libpcap emits K on TAX */
  2595				BPF_STMT(BPF_LD | BPF_MEM, 1),
  2596				BPF_STMT(BPF_ALU | BPF_SUB | BPF_X, 0),
  2597				BPF_STMT(BPF_ST, 5),
  2598				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 14),
  2599				BPF_STMT(BPF_LD | BPF_B | BPF_IND, 26),
  2600				BPF_STMT(BPF_ALU | BPF_AND | BPF_K, 0xf0),
  2601				BPF_STMT(BPF_ALU | BPF_RSH | BPF_K, 2),
  2602				BPF_STMT(BPF_MISC | BPF_TAX, 0x9), /* libpcap emits K on TAX */
  2603				BPF_STMT(BPF_LD | BPF_MEM, 5),
  2604				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_X, 0, 4, 0),
  2605				BPF_STMT(BPF_LD | BPF_LEN, 0),
  2606				BPF_JUMP(BPF_JMP | BPF_JGT | BPF_K, 0x73, 1, 0),
  2607				BPF_JUMP(BPF_JMP | BPF_JGE | BPF_K, 0xfc23ac00, 1, 0),
  2608				BPF_STMT(BPF_RET | BPF_K, 0xffff),
  2609				BPF_STMT(BPF_RET | BPF_K, 0),
  2610			},
  2611			CLASSIC,
  2612			{ 0x10, 0xbf, 0x48, 0xd6, 0x43, 0xd6,
  2613			  0x3c, 0x07, 0x54, 0x43, 0xe5, 0x76,
  2614			  0x08, 0x00,
  2615			  0x45, 0x10, 0x00, 0x64, 0x75, 0xb5,
  2616			  0x40, 0x00, 0x40, 0x06, 0xad, 0x2e, /* IP header */
  2617			  0x0a, 0x01, 0x01, 0x95, /* ip src */
  2618			  0x0a, 0x01, 0x02, 0x0a, /* ip dst */
  2619			  0xc2, 0x24,
  2620			  0x00, 0x16 /* dst port */ },
  2621			{ { 10, 0 }, { 30, 0 }, { 100, 65535 } },
  2622		},
  2623		{
  2624			"RET_A",
  2625			.u.insns = {
  2626				/* check that uninitialized X and A contain zeros */
  2627				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  2628				BPF_STMT(BPF_RET | BPF_A, 0)
  2629			},
  2630			CLASSIC,
  2631			{ },
  2632			{ {1, 0}, {2, 0} },
  2633		},
  2634		{
  2635			"INT: ADD trivial",
  2636			.u.insns_int = {
  2637				BPF_ALU64_IMM(BPF_MOV, R1, 1),
  2638				BPF_ALU64_IMM(BPF_ADD, R1, 2),
  2639				BPF_ALU64_IMM(BPF_MOV, R2, 3),
  2640				BPF_ALU64_REG(BPF_SUB, R1, R2),
  2641				BPF_ALU64_IMM(BPF_ADD, R1, -1),
  2642				BPF_ALU64_IMM(BPF_MUL, R1, 3),
  2643				BPF_ALU64_REG(BPF_MOV, R0, R1),
  2644				BPF_EXIT_INSN(),
  2645			},
  2646			INTERNAL,
  2647			{ },
  2648			{ { 0, 0xfffffffd } }
  2649		},
  2650		{
  2651			"INT: MUL_X",
  2652			.u.insns_int = {
  2653				BPF_ALU64_IMM(BPF_MOV, R0, -1),
  2654				BPF_ALU64_IMM(BPF_MOV, R1, -1),
  2655				BPF_ALU64_IMM(BPF_MOV, R2, 3),
  2656				BPF_ALU64_REG(BPF_MUL, R1, R2),
  2657				BPF_JMP_IMM(BPF_JEQ, R1, 0xfffffffd, 1),
  2658				BPF_EXIT_INSN(),
  2659				BPF_ALU64_IMM(BPF_MOV, R0, 1),
  2660				BPF_EXIT_INSN(),
  2661			},
  2662			INTERNAL,
  2663			{ },
  2664			{ { 0, 1 } }
  2665		},
  2666		{
  2667			"INT: MUL_X2",
  2668			.u.insns_int = {
  2669				BPF_ALU32_IMM(BPF_MOV, R0, -1),
  2670				BPF_ALU32_IMM(BPF_MOV, R1, -1),
  2671				BPF_ALU32_IMM(BPF_MOV, R2, 3),
  2672				BPF_ALU64_REG(BPF_MUL, R1, R2),
  2673				BPF_ALU64_IMM(BPF_RSH, R1, 8),
  2674				BPF_JMP_IMM(BPF_JEQ, R1, 0x2ffffff, 1),
  2675				BPF_EXIT_INSN(),
  2676				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  2677				BPF_EXIT_INSN(),
  2678			},
  2679			INTERNAL,
  2680			{ },
  2681			{ { 0, 1 } }
  2682		},
  2683		{
  2684			"INT: MUL32_X",
  2685			.u.insns_int = {
  2686				BPF_ALU32_IMM(BPF_MOV, R0, -1),
  2687				BPF_ALU64_IMM(BPF_MOV, R1, -1),
  2688				BPF_ALU32_IMM(BPF_MOV, R2, 3),
  2689				BPF_ALU32_REG(BPF_MUL, R1, R2),
  2690				BPF_ALU64_IMM(BPF_RSH, R1, 8),
  2691				BPF_JMP_IMM(BPF_JEQ, R1, 0xffffff, 1),
  2692				BPF_EXIT_INSN(),
  2693				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  2694				BPF_EXIT_INSN(),
  2695			},
  2696			INTERNAL,
  2697			{ },
  2698			{ { 0, 1 } }
  2699		},
  2700		{
  2701			/* Have to test all register combinations, since
  2702			 * JITing of different registers will produce
  2703			 * different asm code.
  2704			 */
  2705			"INT: ADD 64-bit",
  2706			.u.insns_int = {
  2707				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  2708				BPF_ALU64_IMM(BPF_MOV, R1, 1),
  2709				BPF_ALU64_IMM(BPF_MOV, R2, 2),
  2710				BPF_ALU64_IMM(BPF_MOV, R3, 3),
  2711				BPF_ALU64_IMM(BPF_MOV, R4, 4),
  2712				BPF_ALU64_IMM(BPF_MOV, R5, 5),
  2713				BPF_ALU64_IMM(BPF_MOV, R6, 6),
  2714				BPF_ALU64_IMM(BPF_MOV, R7, 7),
  2715				BPF_ALU64_IMM(BPF_MOV, R8, 8),
  2716				BPF_ALU64_IMM(BPF_MOV, R9, 9),
  2717				BPF_ALU64_IMM(BPF_ADD, R0, 20),
  2718				BPF_ALU64_IMM(BPF_ADD, R1, 20),
  2719				BPF_ALU64_IMM(BPF_ADD, R2, 20),
  2720				BPF_ALU64_IMM(BPF_ADD, R3, 20),
  2721				BPF_ALU64_IMM(BPF_ADD, R4, 20),
  2722				BPF_ALU64_IMM(BPF_ADD, R5, 20),
  2723				BPF_ALU64_IMM(BPF_ADD, R6, 20),
  2724				BPF_ALU64_IMM(BPF_ADD, R7, 20),
  2725				BPF_ALU64_IMM(BPF_ADD, R8, 20),
  2726				BPF_ALU64_IMM(BPF_ADD, R9, 20),
  2727				BPF_ALU64_IMM(BPF_SUB, R0, 10),
  2728				BPF_ALU64_IMM(BPF_SUB, R1, 10),
  2729				BPF_ALU64_IMM(BPF_SUB, R2, 10),
  2730				BPF_ALU64_IMM(BPF_SUB, R3, 10),
  2731				BPF_ALU64_IMM(BPF_SUB, R4, 10),
  2732				BPF_ALU64_IMM(BPF_SUB, R5, 10),
  2733				BPF_ALU64_IMM(BPF_SUB, R6, 10),
  2734				BPF_ALU64_IMM(BPF_SUB, R7, 10),
  2735				BPF_ALU64_IMM(BPF_SUB, R8, 10),
  2736				BPF_ALU64_IMM(BPF_SUB, R9, 10),
  2737				BPF_ALU64_REG(BPF_ADD, R0, R0),
  2738				BPF_ALU64_REG(BPF_ADD, R0, R1),
  2739				BPF_ALU64_REG(BPF_ADD, R0, R2),
  2740				BPF_ALU64_REG(BPF_ADD, R0, R3),
  2741				BPF_ALU64_REG(BPF_ADD, R0, R4),
  2742				BPF_ALU64_REG(BPF_ADD, R0, R5),
  2743				BPF_ALU64_REG(BPF_ADD, R0, R6),
  2744				BPF_ALU64_REG(BPF_ADD, R0, R7),
  2745				BPF_ALU64_REG(BPF_ADD, R0, R8),
  2746				BPF_ALU64_REG(BPF_ADD, R0, R9), /* R0 == 155 */
  2747				BPF_JMP_IMM(BPF_JEQ, R0, 155, 1),
  2748				BPF_EXIT_INSN(),
  2749				BPF_ALU64_REG(BPF_ADD, R1, R0),
  2750				BPF_ALU64_REG(BPF_ADD, R1, R1),
  2751				BPF_ALU64_REG(BPF_ADD, R1, R2),
  2752				BPF_ALU64_REG(BPF_ADD, R1, R3),
  2753				BPF_ALU64_REG(BPF_ADD, R1, R4),
  2754				BPF_ALU64_REG(BPF_ADD, R1, R5),
  2755				BPF_ALU64_REG(BPF_ADD, R1, R6),
  2756				BPF_ALU64_REG(BPF_ADD, R1, R7),
  2757				BPF_ALU64_REG(BPF_ADD, R1, R8),
  2758				BPF_ALU64_REG(BPF_ADD, R1, R9), /* R1 == 456 */
  2759				BPF_JMP_IMM(BPF_JEQ, R1, 456, 1),
  2760				BPF_EXIT_INSN(),
  2761				BPF_ALU64_REG(BPF_ADD, R2, R0),
  2762				BPF_ALU64_REG(BPF_ADD, R2, R1),
  2763				BPF_ALU64_REG(BPF_ADD, R2, R2),
  2764				BPF_ALU64_REG(BPF_ADD, R2, R3),
  2765				BPF_ALU64_REG(BPF_ADD, R2, R4),
  2766				BPF_ALU64_REG(BPF_ADD, R2, R5),
  2767				BPF_ALU64_REG(BPF_ADD, R2, R6),
  2768				BPF_ALU64_REG(BPF_ADD, R2, R7),
  2769				BPF_ALU64_REG(BPF_ADD, R2, R8),
  2770				BPF_ALU64_REG(BPF_ADD, R2, R9), /* R2 == 1358 */
  2771				BPF_JMP_IMM(BPF_JEQ, R2, 1358, 1),
  2772				BPF_EXIT_INSN(),
  2773				BPF_ALU64_REG(BPF_ADD, R3, R0),
  2774				BPF_ALU64_REG(BPF_ADD, R3, R1),
  2775				BPF_ALU64_REG(BPF_ADD, R3, R2),
  2776				BPF_ALU64_REG(BPF_ADD, R3, R3),
  2777				BPF_ALU64_REG(BPF_ADD, R3, R4),
  2778				BPF_ALU64_REG(BPF_ADD, R3, R5),
  2779				BPF_ALU64_REG(BPF_ADD, R3, R6),
  2780				BPF_ALU64_REG(BPF_ADD, R3, R7),
  2781				BPF_ALU64_REG(BPF_ADD, R3, R8),
  2782				BPF_ALU64_REG(BPF_ADD, R3, R9), /* R3 == 4063 */
  2783				BPF_JMP_IMM(BPF_JEQ, R3, 4063, 1),
  2784				BPF_EXIT_INSN(),
  2785				BPF_ALU64_REG(BPF_ADD, R4, R0),
  2786				BPF_ALU64_REG(BPF_ADD, R4, R1),
  2787				BPF_ALU64_REG(BPF_ADD, R4, R2),
  2788				BPF_ALU64_REG(BPF_ADD, R4, R3),
  2789				BPF_ALU64_REG(BPF_ADD, R4, R4),
  2790				BPF_ALU64_REG(BPF_ADD, R4, R5),
  2791				BPF_ALU64_REG(BPF_ADD, R4, R6),
  2792				BPF_ALU64_REG(BPF_ADD, R4, R7),
  2793				BPF_ALU64_REG(BPF_ADD, R4, R8),
  2794				BPF_ALU64_REG(BPF_ADD, R4, R9), /* R4 == 12177 */
  2795				BPF_JMP_IMM(BPF_JEQ, R4, 12177, 1),
  2796				BPF_EXIT_INSN(),
  2797				BPF_ALU64_REG(BPF_ADD, R5, R0),
  2798				BPF_ALU64_REG(BPF_ADD, R5, R1),
  2799				BPF_ALU64_REG(BPF_ADD, R5, R2),
  2800				BPF_ALU64_REG(BPF_ADD, R5, R3),
  2801				BPF_ALU64_REG(BPF_ADD, R5, R4),
  2802				BPF_ALU64_REG(BPF_ADD, R5, R5),
  2803				BPF_ALU64_REG(BPF_ADD, R5, R6),
  2804				BPF_ALU64_REG(BPF_ADD, R5, R7),
  2805				BPF_ALU64_REG(BPF_ADD, R5, R8),
  2806				BPF_ALU64_REG(BPF_ADD, R5, R9), /* R5 == 36518 */
  2807				BPF_JMP_IMM(BPF_JEQ, R5, 36518, 1),
  2808				BPF_EXIT_INSN(),
  2809				BPF_ALU64_REG(BPF_ADD, R6, R0),
  2810				BPF_ALU64_REG(BPF_ADD, R6, R1),
  2811				BPF_ALU64_REG(BPF_ADD, R6, R2),
  2812				BPF_ALU64_REG(BPF_ADD, R6, R3),
  2813				BPF_ALU64_REG(BPF_ADD, R6, R4),
  2814				BPF_ALU64_REG(BPF_ADD, R6, R5),
  2815				BPF_ALU64_REG(BPF_ADD, R6, R6),
  2816				BPF_ALU64_REG(BPF_ADD, R6, R7),
  2817				BPF_ALU64_REG(BPF_ADD, R6, R8),
  2818				BPF_ALU64_REG(BPF_ADD, R6, R9), /* R6 == 109540 */
  2819				BPF_JMP_IMM(BPF_JEQ, R6, 109540, 1),
  2820				BPF_EXIT_INSN(),
  2821				BPF_ALU64_REG(BPF_ADD, R7, R0),
  2822				BPF_ALU64_REG(BPF_ADD, R7, R1),
  2823				BPF_ALU64_REG(BPF_ADD, R7, R2),
  2824				BPF_ALU64_REG(BPF_ADD, R7, R3),
  2825				BPF_ALU64_REG(BPF_ADD, R7, R4),
  2826				BPF_ALU64_REG(BPF_ADD, R7, R5),
  2827				BPF_ALU64_REG(BPF_ADD, R7, R6),
  2828				BPF_ALU64_REG(BPF_ADD, R7, R7),
  2829				BPF_ALU64_REG(BPF_ADD, R7, R8),
  2830				BPF_ALU64_REG(BPF_ADD, R7, R9), /* R7 == 328605 */
  2831				BPF_JMP_IMM(BPF_JEQ, R7, 328605, 1),
  2832				BPF_EXIT_INSN(),
  2833				BPF_ALU64_REG(BPF_ADD, R8, R0),
  2834				BPF_ALU64_REG(BPF_ADD, R8, R1),
  2835				BPF_ALU64_REG(BPF_ADD, R8, R2),
  2836				BPF_ALU64_REG(BPF_ADD, R8, R3),
  2837				BPF_ALU64_REG(BPF_ADD, R8, R4),
  2838				BPF_ALU64_REG(BPF_ADD, R8, R5),
  2839				BPF_ALU64_REG(BPF_ADD, R8, R6),
  2840				BPF_ALU64_REG(BPF_ADD, R8, R7),
  2841				BPF_ALU64_REG(BPF_ADD, R8, R8),
  2842				BPF_ALU64_REG(BPF_ADD, R8, R9), /* R8 == 985799 */
  2843				BPF_JMP_IMM(BPF_JEQ, R8, 985799, 1),
  2844				BPF_EXIT_INSN(),
  2845				BPF_ALU64_REG(BPF_ADD, R9, R0),
  2846				BPF_ALU64_REG(BPF_ADD, R9, R1),
  2847				BPF_ALU64_REG(BPF_ADD, R9, R2),
  2848				BPF_ALU64_REG(BPF_ADD, R9, R3),
  2849				BPF_ALU64_REG(BPF_ADD, R9, R4),
  2850				BPF_ALU64_REG(BPF_ADD, R9, R5),
  2851				BPF_ALU64_REG(BPF_ADD, R9, R6),
  2852				BPF_ALU64_REG(BPF_ADD, R9, R7),
  2853				BPF_ALU64_REG(BPF_ADD, R9, R8),
  2854				BPF_ALU64_REG(BPF_ADD, R9, R9), /* R9 == 2957380 */
  2855				BPF_ALU64_REG(BPF_MOV, R0, R9),
  2856				BPF_EXIT_INSN(),
  2857			},
  2858			INTERNAL,
  2859			{ },
  2860			{ { 0, 2957380 } }
  2861		},
  2862		{
  2863			"INT: ADD 32-bit",
  2864			.u.insns_int = {
  2865				BPF_ALU32_IMM(BPF_MOV, R0, 20),
  2866				BPF_ALU32_IMM(BPF_MOV, R1, 1),
  2867				BPF_ALU32_IMM(BPF_MOV, R2, 2),
  2868				BPF_ALU32_IMM(BPF_MOV, R3, 3),
  2869				BPF_ALU32_IMM(BPF_MOV, R4, 4),
  2870				BPF_ALU32_IMM(BPF_MOV, R5, 5),
  2871				BPF_ALU32_IMM(BPF_MOV, R6, 6),
  2872				BPF_ALU32_IMM(BPF_MOV, R7, 7),
  2873				BPF_ALU32_IMM(BPF_MOV, R8, 8),
  2874				BPF_ALU32_IMM(BPF_MOV, R9, 9),
  2875				BPF_ALU64_IMM(BPF_ADD, R1, 10),
  2876				BPF_ALU64_IMM(BPF_ADD, R2, 10),
  2877				BPF_ALU64_IMM(BPF_ADD, R3, 10),
  2878				BPF_ALU64_IMM(BPF_ADD, R4, 10),
  2879				BPF_ALU64_IMM(BPF_ADD, R5, 10),
  2880				BPF_ALU64_IMM(BPF_ADD, R6, 10),
  2881				BPF_ALU64_IMM(BPF_ADD, R7, 10),
  2882				BPF_ALU64_IMM(BPF_ADD, R8, 10),
  2883				BPF_ALU64_IMM(BPF_ADD, R9, 10),
  2884				BPF_ALU32_REG(BPF_ADD, R0, R1),
  2885				BPF_ALU32_REG(BPF_ADD, R0, R2),
  2886				BPF_ALU32_REG(BPF_ADD, R0, R3),
  2887				BPF_ALU32_REG(BPF_ADD, R0, R4),
  2888				BPF_ALU32_REG(BPF_ADD, R0, R5),
  2889				BPF_ALU32_REG(BPF_ADD, R0, R6),
  2890				BPF_ALU32_REG(BPF_ADD, R0, R7),
  2891				BPF_ALU32_REG(BPF_ADD, R0, R8),
  2892				BPF_ALU32_REG(BPF_ADD, R0, R9), /* R0 == 155 */
  2893				BPF_JMP_IMM(BPF_JEQ, R0, 155, 1),
  2894				BPF_EXIT_INSN(),
  2895				BPF_ALU32_REG(BPF_ADD, R1, R0),
  2896				BPF_ALU32_REG(BPF_ADD, R1, R1),
  2897				BPF_ALU32_REG(BPF_ADD, R1, R2),
  2898				BPF_ALU32_REG(BPF_ADD, R1, R3),
  2899				BPF_ALU32_REG(BPF_ADD, R1, R4),
  2900				BPF_ALU32_REG(BPF_ADD, R1, R5),
  2901				BPF_ALU32_REG(BPF_ADD, R1, R6),
  2902				BPF_ALU32_REG(BPF_ADD, R1, R7),
  2903				BPF_ALU32_REG(BPF_ADD, R1, R8),
  2904				BPF_ALU32_REG(BPF_ADD, R1, R9), /* R1 == 456 */
  2905				BPF_JMP_IMM(BPF_JEQ, R1, 456, 1),
  2906				BPF_EXIT_INSN(),
  2907				BPF_ALU32_REG(BPF_ADD, R2, R0),
  2908				BPF_ALU32_REG(BPF_ADD, R2, R1),
  2909				BPF_ALU32_REG(BPF_ADD, R2, R2),
  2910				BPF_ALU32_REG(BPF_ADD, R2, R3),
  2911				BPF_ALU32_REG(BPF_ADD, R2, R4),
  2912				BPF_ALU32_REG(BPF_ADD, R2, R5),
  2913				BPF_ALU32_REG(BPF_ADD, R2, R6),
  2914				BPF_ALU32_REG(BPF_ADD, R2, R7),
  2915				BPF_ALU32_REG(BPF_ADD, R2, R8),
  2916				BPF_ALU32_REG(BPF_ADD, R2, R9), /* R2 == 1358 */
  2917				BPF_JMP_IMM(BPF_JEQ, R2, 1358, 1),
  2918				BPF_EXIT_INSN(),
  2919				BPF_ALU32_REG(BPF_ADD, R3, R0),
  2920				BPF_ALU32_REG(BPF_ADD, R3, R1),
  2921				BPF_ALU32_REG(BPF_ADD, R3, R2),
  2922				BPF_ALU32_REG(BPF_ADD, R3, R3),
  2923				BPF_ALU32_REG(BPF_ADD, R3, R4),
  2924				BPF_ALU32_REG(BPF_ADD, R3, R5),
  2925				BPF_ALU32_REG(BPF_ADD, R3, R6),
  2926				BPF_ALU32_REG(BPF_ADD, R3, R7),
  2927				BPF_ALU32_REG(BPF_ADD, R3, R8),
  2928				BPF_ALU32_REG(BPF_ADD, R3, R9), /* R3 == 4063 */
  2929				BPF_JMP_IMM(BPF_JEQ, R3, 4063, 1),
  2930				BPF_EXIT_INSN(),
  2931				BPF_ALU32_REG(BPF_ADD, R4, R0),
  2932				BPF_ALU32_REG(BPF_ADD, R4, R1),
  2933				BPF_ALU32_REG(BPF_ADD, R4, R2),
  2934				BPF_ALU32_REG(BPF_ADD, R4, R3),
  2935				BPF_ALU32_REG(BPF_ADD, R4, R4),
  2936				BPF_ALU32_REG(BPF_ADD, R4, R5),
  2937				BPF_ALU32_REG(BPF_ADD, R4, R6),
  2938				BPF_ALU32_REG(BPF_ADD, R4, R7),
  2939				BPF_ALU32_REG(BPF_ADD, R4, R8),
  2940				BPF_ALU32_REG(BPF_ADD, R4, R9), /* R4 == 12177 */
  2941				BPF_JMP_IMM(BPF_JEQ, R4, 12177, 1),
  2942				BPF_EXIT_INSN(),
  2943				BPF_ALU32_REG(BPF_ADD, R5, R0),
  2944				BPF_ALU32_REG(BPF_ADD, R5, R1),
  2945				BPF_ALU32_REG(BPF_ADD, R5, R2),
  2946				BPF_ALU32_REG(BPF_ADD, R5, R3),
  2947				BPF_ALU32_REG(BPF_ADD, R5, R4),
  2948				BPF_ALU32_REG(BPF_ADD, R5, R5),
  2949				BPF_ALU32_REG(BPF_ADD, R5, R6),
  2950				BPF_ALU32_REG(BPF_ADD, R5, R7),
  2951				BPF_ALU32_REG(BPF_ADD, R5, R8),
  2952				BPF_ALU32_REG(BPF_ADD, R5, R9), /* R5 == 36518 */
  2953				BPF_JMP_IMM(BPF_JEQ, R5, 36518, 1),
  2954				BPF_EXIT_INSN(),
  2955				BPF_ALU32_REG(BPF_ADD, R6, R0),
  2956				BPF_ALU32_REG(BPF_ADD, R6, R1),
  2957				BPF_ALU32_REG(BPF_ADD, R6, R2),
  2958				BPF_ALU32_REG(BPF_ADD, R6, R3),
  2959				BPF_ALU32_REG(BPF_ADD, R6, R4),
  2960				BPF_ALU32_REG(BPF_ADD, R6, R5),
  2961				BPF_ALU32_REG(BPF_ADD, R6, R6),
  2962				BPF_ALU32_REG(BPF_ADD, R6, R7),
  2963				BPF_ALU32_REG(BPF_ADD, R6, R8),
  2964				BPF_ALU32_REG(BPF_ADD, R6, R9), /* R6 == 109540 */
  2965				BPF_JMP_IMM(BPF_JEQ, R6, 109540, 1),
  2966				BPF_EXIT_INSN(),
  2967				BPF_ALU32_REG(BPF_ADD, R7, R0),
  2968				BPF_ALU32_REG(BPF_ADD, R7, R1),
  2969				BPF_ALU32_REG(BPF_ADD, R7, R2),
  2970				BPF_ALU32_REG(BPF_ADD, R7, R3),
  2971				BPF_ALU32_REG(BPF_ADD, R7, R4),
  2972				BPF_ALU32_REG(BPF_ADD, R7, R5),
  2973				BPF_ALU32_REG(BPF_ADD, R7, R6),
  2974				BPF_ALU32_REG(BPF_ADD, R7, R7),
  2975				BPF_ALU32_REG(BPF_ADD, R7, R8),
  2976				BPF_ALU32_REG(BPF_ADD, R7, R9), /* R7 == 328605 */
  2977				BPF_JMP_IMM(BPF_JEQ, R7, 328605, 1),
  2978				BPF_EXIT_INSN(),
  2979				BPF_ALU32_REG(BPF_ADD, R8, R0),
  2980				BPF_ALU32_REG(BPF_ADD, R8, R1),
  2981				BPF_ALU32_REG(BPF_ADD, R8, R2),
  2982				BPF_ALU32_REG(BPF_ADD, R8, R3),
  2983				BPF_ALU32_REG(BPF_ADD, R8, R4),
  2984				BPF_ALU32_REG(BPF_ADD, R8, R5),
  2985				BPF_ALU32_REG(BPF_ADD, R8, R6),
  2986				BPF_ALU32_REG(BPF_ADD, R8, R7),
  2987				BPF_ALU32_REG(BPF_ADD, R8, R8),
  2988				BPF_ALU32_REG(BPF_ADD, R8, R9), /* R8 == 985799 */
  2989				BPF_JMP_IMM(BPF_JEQ, R8, 985799, 1),
  2990				BPF_EXIT_INSN(),
  2991				BPF_ALU32_REG(BPF_ADD, R9, R0),
  2992				BPF_ALU32_REG(BPF_ADD, R9, R1),
  2993				BPF_ALU32_REG(BPF_ADD, R9, R2),
  2994				BPF_ALU32_REG(BPF_ADD, R9, R3),
  2995				BPF_ALU32_REG(BPF_ADD, R9, R4),
  2996				BPF_ALU32_REG(BPF_ADD, R9, R5),
  2997				BPF_ALU32_REG(BPF_ADD, R9, R6),
  2998				BPF_ALU32_REG(BPF_ADD, R9, R7),
  2999				BPF_ALU32_REG(BPF_ADD, R9, R8),
  3000				BPF_ALU32_REG(BPF_ADD, R9, R9), /* R9 == 2957380 */
  3001				BPF_ALU32_REG(BPF_MOV, R0, R9),
  3002				BPF_EXIT_INSN(),
  3003			},
  3004			INTERNAL,
  3005			{ },
  3006			{ { 0, 2957380 } }
  3007		},
  3008		{	/* Mainly checking JIT here. */
  3009			"INT: SUB",
  3010			.u.insns_int = {
  3011				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  3012				BPF_ALU64_IMM(BPF_MOV, R1, 1),
  3013				BPF_ALU64_IMM(BPF_MOV, R2, 2),
  3014				BPF_ALU64_IMM(BPF_MOV, R3, 3),
  3015				BPF_ALU64_IMM(BPF_MOV, R4, 4),
  3016				BPF_ALU64_IMM(BPF_MOV, R5, 5),
  3017				BPF_ALU64_IMM(BPF_MOV, R6, 6),
  3018				BPF_ALU64_IMM(BPF_MOV, R7, 7),
  3019				BPF_ALU64_IMM(BPF_MOV, R8, 8),
  3020				BPF_ALU64_IMM(BPF_MOV, R9, 9),
  3021				BPF_ALU64_REG(BPF_SUB, R0, R0),
  3022				BPF_ALU64_REG(BPF_SUB, R0, R1),
  3023				BPF_ALU64_REG(BPF_SUB, R0, R2),
  3024				BPF_ALU64_REG(BPF_SUB, R0, R3),
  3025				BPF_ALU64_REG(BPF_SUB, R0, R4),
  3026				BPF_ALU64_REG(BPF_SUB, R0, R5),
  3027				BPF_ALU64_REG(BPF_SUB, R0, R6),
  3028				BPF_ALU64_REG(BPF_SUB, R0, R7),
  3029				BPF_ALU64_REG(BPF_SUB, R0, R8),
  3030				BPF_ALU64_REG(BPF_SUB, R0, R9),
  3031				BPF_ALU64_IMM(BPF_SUB, R0, 10),
  3032				BPF_JMP_IMM(BPF_JEQ, R0, -55, 1),
  3033				BPF_EXIT_INSN(),
  3034				BPF_ALU64_REG(BPF_SUB, R1, R0),
  3035				BPF_ALU64_REG(BPF_SUB, R1, R2),
  3036				BPF_ALU64_REG(BPF_SUB, R1, R3),
  3037				BPF_ALU64_REG(BPF_SUB, R1, R4),
  3038				BPF_ALU64_REG(BPF_SUB, R1, R5),
  3039				BPF_ALU64_REG(BPF_SUB, R1, R6),
  3040				BPF_ALU64_REG(BPF_SUB, R1, R7),
  3041				BPF_ALU64_REG(BPF_SUB, R1, R8),
  3042				BPF_ALU64_REG(BPF_SUB, R1, R9),
  3043				BPF_ALU64_IMM(BPF_SUB, R1, 10),
  3044				BPF_ALU64_REG(BPF_SUB, R2, R0),
  3045				BPF_ALU64_REG(BPF_SUB, R2, R1),
  3046				BPF_ALU64_REG(BPF_SUB, R2, R3),
  3047				BPF_ALU64_REG(BPF_SUB, R2, R4),
  3048				BPF_ALU64_REG(BPF_SUB, R2, R5),
  3049				BPF_ALU64_REG(BPF_SUB, R2, R6),
  3050				BPF_ALU64_REG(BPF_SUB, R2, R7),
  3051				BPF_ALU64_REG(BPF_SUB, R2, R8),
  3052				BPF_ALU64_REG(BPF_SUB, R2, R9),
  3053				BPF_ALU64_IMM(BPF_SUB, R2, 10),
  3054				BPF_ALU64_REG(BPF_SUB, R3, R0),
  3055				BPF_ALU64_REG(BPF_SUB, R3, R1),
  3056				BPF_ALU64_REG(BPF_SUB, R3, R2),
  3057				BPF_ALU64_REG(BPF_SUB, R3, R4),
  3058				BPF_ALU64_REG(BPF_SUB, R3, R5),
  3059				BPF_ALU64_REG(BPF_SUB, R3, R6),
  3060				BPF_ALU64_REG(BPF_SUB, R3, R7),
  3061				BPF_ALU64_REG(BPF_SUB, R3, R8),
  3062				BPF_ALU64_REG(BPF_SUB, R3, R9),
  3063				BPF_ALU64_IMM(BPF_SUB, R3, 10),
  3064				BPF_ALU64_REG(BPF_SUB, R4, R0),
  3065				BPF_ALU64_REG(BPF_SUB, R4, R1),
  3066				BPF_ALU64_REG(BPF_SUB, R4, R2),
  3067				BPF_ALU64_REG(BPF_SUB, R4, R3),
  3068				BPF_ALU64_REG(BPF_SUB, R4, R5),
  3069				BPF_ALU64_REG(BPF_SUB, R4, R6),
  3070				BPF_ALU64_REG(BPF_SUB, R4, R7),
  3071				BPF_ALU64_REG(BPF_SUB, R4, R8),
  3072				BPF_ALU64_REG(BPF_SUB, R4, R9),
  3073				BPF_ALU64_IMM(BPF_SUB, R4, 10),
  3074				BPF_ALU64_REG(BPF_SUB, R5, R0),
  3075				BPF_ALU64_REG(BPF_SUB, R5, R1),
  3076				BPF_ALU64_REG(BPF_SUB, R5, R2),
  3077				BPF_ALU64_REG(BPF_SUB, R5, R3),
  3078				BPF_ALU64_REG(BPF_SUB, R5, R4),
  3079				BPF_ALU64_REG(BPF_SUB, R5, R6),
  3080				BPF_ALU64_REG(BPF_SUB, R5, R7),
  3081				BPF_ALU64_REG(BPF_SUB, R5, R8),
  3082				BPF_ALU64_REG(BPF_SUB, R5, R9),
  3083				BPF_ALU64_IMM(BPF_SUB, R5, 10),
  3084				BPF_ALU64_REG(BPF_SUB, R6, R0),
  3085				BPF_ALU64_REG(BPF_SUB, R6, R1),
  3086				BPF_ALU64_REG(BPF_SUB, R6, R2),
  3087				BPF_ALU64_REG(BPF_SUB, R6, R3),
  3088				BPF_ALU64_REG(BPF_SUB, R6, R4),
  3089				BPF_ALU64_REG(BPF_SUB, R6, R5),
  3090				BPF_ALU64_REG(BPF_SUB, R6, R7),
  3091				BPF_ALU64_REG(BPF_SUB, R6, R8),
  3092				BPF_ALU64_REG(BPF_SUB, R6, R9),
  3093				BPF_ALU64_IMM(BPF_SUB, R6, 10),
  3094				BPF_ALU64_REG(BPF_SUB, R7, R0),
  3095				BPF_ALU64_REG(BPF_SUB, R7, R1),
  3096				BPF_ALU64_REG(BPF_SUB, R7, R2),
  3097				BPF_ALU64_REG(BPF_SUB, R7, R3),
  3098				BPF_ALU64_REG(BPF_SUB, R7, R4),
  3099				BPF_ALU64_REG(BPF_SUB, R7, R5),
  3100				BPF_ALU64_REG(BPF_SUB, R7, R6),
  3101				BPF_ALU64_REG(BPF_SUB, R7, R8),
  3102				BPF_ALU64_REG(BPF_SUB, R7, R9),
  3103				BPF_ALU64_IMM(BPF_SUB, R7, 10),
  3104				BPF_ALU64_REG(BPF_SUB, R8, R0),
  3105				BPF_ALU64_REG(BPF_SUB, R8, R1),
  3106				BPF_ALU64_REG(BPF_SUB, R8, R2),
  3107				BPF_ALU64_REG(BPF_SUB, R8, R3),
  3108				BPF_ALU64_REG(BPF_SUB, R8, R4),
  3109				BPF_ALU64_REG(BPF_SUB, R8, R5),
  3110				BPF_ALU64_REG(BPF_SUB, R8, R6),
  3111				BPF_ALU64_REG(BPF_SUB, R8, R7),
  3112				BPF_ALU64_REG(BPF_SUB, R8, R9),
  3113				BPF_ALU64_IMM(BPF_SUB, R8, 10),
  3114				BPF_ALU64_REG(BPF_SUB, R9, R0),
  3115				BPF_ALU64_REG(BPF_SUB, R9, R1),
  3116				BPF_ALU64_REG(BPF_SUB, R9, R2),
  3117				BPF_ALU64_REG(BPF_SUB, R9, R3),
  3118				BPF_ALU64_REG(BPF_SUB, R9, R4),
  3119				BPF_ALU64_REG(BPF_SUB, R9, R5),
  3120				BPF_ALU64_REG(BPF_SUB, R9, R6),
  3121				BPF_ALU64_REG(BPF_SUB, R9, R7),
  3122				BPF_ALU64_REG(BPF_SUB, R9, R8),
  3123				BPF_ALU64_IMM(BPF_SUB, R9, 10),
  3124				BPF_ALU64_IMM(BPF_SUB, R0, 10),
  3125				BPF_ALU64_IMM(BPF_NEG, R0, 0),
  3126				BPF_ALU64_REG(BPF_SUB, R0, R1),
  3127				BPF_ALU64_REG(BPF_SUB, R0, R2),
  3128				BPF_ALU64_REG(BPF_SUB, R0, R3),
  3129				BPF_ALU64_REG(BPF_SUB, R0, R4),
  3130				BPF_ALU64_REG(BPF_SUB, R0, R5),
  3131				BPF_ALU64_REG(BPF_SUB, R0, R6),
  3132				BPF_ALU64_REG(BPF_SUB, R0, R7),
  3133				BPF_ALU64_REG(BPF_SUB, R0, R8),
  3134				BPF_ALU64_REG(BPF_SUB, R0, R9),
  3135				BPF_EXIT_INSN(),
  3136			},
  3137			INTERNAL,
  3138			{ },
  3139			{ { 0, 11 } }
  3140		},
  3141		{	/* Mainly checking JIT here. */
  3142			"INT: XOR",
  3143			.u.insns_int = {
  3144				BPF_ALU64_REG(BPF_SUB, R0, R0),
  3145				BPF_ALU64_REG(BPF_XOR, R1, R1),
  3146				BPF_JMP_REG(BPF_JEQ, R0, R1, 1),
  3147				BPF_EXIT_INSN(),
  3148				BPF_ALU64_IMM(BPF_MOV, R0, 10),
  3149				BPF_ALU64_IMM(BPF_MOV, R1, -1),
  3150				BPF_ALU64_REG(BPF_SUB, R1, R1),
  3151				BPF_ALU64_REG(BPF_XOR, R2, R2),
  3152				BPF_JMP_REG(BPF_JEQ, R1, R2, 1),
  3153				BPF_EXIT_INSN(),
  3154				BPF_ALU64_REG(BPF_SUB, R2, R2),
  3155				BPF_ALU64_REG(BPF_XOR, R3, R3),
  3156				BPF_ALU64_IMM(BPF_MOV, R0, 10),
  3157				BPF_ALU64_IMM(BPF_MOV, R1, -1),
  3158				BPF_JMP_REG(BPF_JEQ, R2, R3, 1),
  3159				BPF_EXIT_INSN(),
  3160				BPF_ALU64_REG(BPF_SUB, R3, R3),
  3161				BPF_ALU64_REG(BPF_XOR, R4, R4),
  3162				BPF_ALU64_IMM(BPF_MOV, R2, 1),
  3163				BPF_ALU64_IMM(BPF_MOV, R5, -1),
  3164				BPF_JMP_REG(BPF_JEQ, R3, R4, 1),
  3165				BPF_EXIT_INSN(),
  3166				BPF_ALU64_REG(BPF_SUB, R4, R4),
  3167				BPF_ALU64_REG(BPF_XOR, R5, R5),
  3168				BPF_ALU64_IMM(BPF_MOV, R3, 1),
  3169				BPF_ALU64_IMM(BPF_MOV, R7, -1),
  3170				BPF_JMP_REG(BPF_JEQ, R5, R4, 1),
  3171				BPF_EXIT_INSN(),
  3172				BPF_ALU64_IMM(BPF_MOV, R5, 1),
  3173				BPF_ALU64_REG(BPF_SUB, R5, R5),
  3174				BPF_ALU64_REG(BPF_XOR, R6, R6),
  3175				BPF_ALU64_IMM(BPF_MOV, R1, 1),
  3176				BPF_ALU64_IMM(BPF_MOV, R8, -1),
  3177				BPF_JMP_REG(BPF_JEQ, R5, R6, 1),
  3178				BPF_EXIT_INSN(),
  3179				BPF_ALU64_REG(BPF_SUB, R6, R6),
  3180				BPF_ALU64_REG(BPF_XOR, R7, R7),
  3181				BPF_JMP_REG(BPF_JEQ, R7, R6, 1),
  3182				BPF_EXIT_INSN(),
  3183				BPF_ALU64_REG(BPF_SUB, R7, R7),
  3184				BPF_ALU64_REG(BPF_XOR, R8, R8),
  3185				BPF_JMP_REG(BPF_JEQ, R7, R8, 1),
  3186				BPF_EXIT_INSN(),
  3187				BPF_ALU64_REG(BPF_SUB, R8, R8),
  3188				BPF_ALU64_REG(BPF_XOR, R9, R9),
  3189				BPF_JMP_REG(BPF_JEQ, R9, R8, 1),
  3190				BPF_EXIT_INSN(),
  3191				BPF_ALU64_REG(BPF_SUB, R9, R9),
  3192				BPF_ALU64_REG(BPF_XOR, R0, R0),
  3193				BPF_JMP_REG(BPF_JEQ, R9, R0, 1),
  3194				BPF_EXIT_INSN(),
  3195				BPF_ALU64_REG(BPF_SUB, R1, R1),
  3196				BPF_ALU64_REG(BPF_XOR, R0, R0),
  3197				BPF_JMP_REG(BPF_JEQ, R9, R0, 2),
  3198				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  3199				BPF_EXIT_INSN(),
  3200				BPF_ALU64_IMM(BPF_MOV, R0, 1),
  3201				BPF_EXIT_INSN(),
  3202			},
  3203			INTERNAL,
  3204			{ },
  3205			{ { 0, 1 } }
  3206		},
  3207		{	/* Mainly checking JIT here. */
  3208			"INT: MUL",
  3209			.u.insns_int = {
  3210				BPF_ALU64_IMM(BPF_MOV, R0, 11),
  3211				BPF_ALU64_IMM(BPF_MOV, R1, 1),
  3212				BPF_ALU64_IMM(BPF_MOV, R2, 2),
  3213				BPF_ALU64_IMM(BPF_MOV, R3, 3),
  3214				BPF_ALU64_IMM(BPF_MOV, R4, 4),
  3215				BPF_ALU64_IMM(BPF_MOV, R5, 5),
  3216				BPF_ALU64_IMM(BPF_MOV, R6, 6),
  3217				BPF_ALU64_IMM(BPF_MOV, R7, 7),
  3218				BPF_ALU64_IMM(BPF_MOV, R8, 8),
  3219				BPF_ALU64_IMM(BPF_MOV, R9, 9),
  3220				BPF_ALU64_REG(BPF_MUL, R0, R0),
  3221				BPF_ALU64_REG(BPF_MUL, R0, R1),
  3222				BPF_ALU64_REG(BPF_MUL, R0, R2),
  3223				BPF_ALU64_REG(BPF_MUL, R0, R3),
  3224				BPF_ALU64_REG(BPF_MUL, R0, R4),
  3225				BPF_ALU64_REG(BPF_MUL, R0, R5),
  3226				BPF_ALU64_REG(BPF_MUL, R0, R6),
  3227				BPF_ALU64_REG(BPF_MUL, R0, R7),
  3228				BPF_ALU64_REG(BPF_MUL, R0, R8),
  3229				BPF_ALU64_REG(BPF_MUL, R0, R9),
  3230				BPF_ALU64_IMM(BPF_MUL, R0, 10),
  3231				BPF_JMP_IMM(BPF_JEQ, R0, 439084800, 1),
  3232				BPF_EXIT_INSN(),
  3233				BPF_ALU64_REG(BPF_MUL, R1, R0),
  3234				BPF_ALU64_REG(BPF_MUL, R1, R2),
  3235				BPF_ALU64_REG(BPF_MUL, R1, R3),
  3236				BPF_ALU64_REG(BPF_MUL, R1, R4),
  3237				BPF_ALU64_REG(BPF_MUL, R1, R5),
  3238				BPF_ALU64_REG(BPF_MUL, R1, R6),
  3239				BPF_ALU64_REG(BPF_MUL, R1, R7),
  3240				BPF_ALU64_REG(BPF_MUL, R1, R8),
  3241				BPF_ALU64_REG(BPF_MUL, R1, R9),
  3242				BPF_ALU64_IMM(BPF_MUL, R1, 10),
  3243				BPF_ALU64_REG(BPF_MOV, R2, R1),
  3244				BPF_ALU64_IMM(BPF_RSH, R2, 32),
  3245				BPF_JMP_IMM(BPF_JEQ, R2, 0x5a924, 1),
  3246				BPF_EXIT_INSN(),
  3247				BPF_ALU64_IMM(BPF_LSH, R1, 32),
  3248				BPF_ALU64_IMM(BPF_ARSH, R1, 32),
  3249				BPF_JMP_IMM(BPF_JEQ, R1, 0xebb90000, 1),
  3250				BPF_EXIT_INSN(),
  3251				BPF_ALU64_REG(BPF_MUL, R2, R0),
  3252				BPF_ALU64_REG(BPF_MUL, R2, R1),
  3253				BPF_ALU64_REG(BPF_MUL, R2, R3),
  3254				BPF_ALU64_REG(BPF_MUL, R2, R4),
  3255				BPF_ALU64_REG(BPF_MUL, R2, R5),
  3256				BPF_ALU64_REG(BPF_MUL, R2, R6),
  3257				BPF_ALU64_REG(BPF_MUL, R2, R7),
  3258				BPF_ALU64_REG(BPF_MUL, R2, R8),
  3259				BPF_ALU64_REG(BPF_MUL, R2, R9),
  3260				BPF_ALU64_IMM(BPF_MUL, R2, 10),
  3261				BPF_ALU64_IMM(BPF_RSH, R2, 32),
  3262				BPF_ALU64_REG(BPF_MOV, R0, R2),
  3263				BPF_EXIT_INSN(),
  3264			},
  3265			INTERNAL,
  3266			{ },
  3267			{ { 0, 0x35d97ef2 } }
  3268		},
  3269		{	/* Mainly checking JIT here. */
  3270			"MOV REG64",
  3271			.u.insns_int = {
  3272				BPF_LD_IMM64(R0, 0xffffffffffffffffLL),
  3273				BPF_MOV64_REG(R1, R0),
  3274				BPF_MOV64_REG(R2, R1),
  3275				BPF_MOV64_REG(R3, R2),
  3276				BPF_MOV64_REG(R4, R3),
  3277				BPF_MOV64_REG(R5, R4),
  3278				BPF_MOV64_REG(R6, R5),
  3279				BPF_MOV64_REG(R7, R6),
  3280				BPF_MOV64_REG(R8, R7),
  3281				BPF_MOV64_REG(R9, R8),
  3282				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  3283				BPF_ALU64_IMM(BPF_MOV, R1, 0),
  3284				BPF_ALU64_IMM(BPF_MOV, R2, 0),
  3285				BPF_ALU64_IMM(BPF_MOV, R3, 0),
  3286				BPF_ALU64_IMM(BPF_MOV, R4, 0),
  3287				BPF_ALU64_IMM(BPF_MOV, R5, 0),
  3288				BPF_ALU64_IMM(BPF_MOV, R6, 0),
  3289				BPF_ALU64_IMM(BPF_MOV, R7, 0),
  3290				BPF_ALU64_IMM(BPF_MOV, R8, 0),
  3291				BPF_ALU64_IMM(BPF_MOV, R9, 0),
  3292				BPF_ALU64_REG(BPF_ADD, R0, R0),
  3293				BPF_ALU64_REG(BPF_ADD, R0, R1),
  3294				BPF_ALU64_REG(BPF_ADD, R0, R2),
  3295				BPF_ALU64_REG(BPF_ADD, R0, R3),
  3296				BPF_ALU64_REG(BPF_ADD, R0, R4),
  3297				BPF_ALU64_REG(BPF_ADD, R0, R5),
  3298				BPF_ALU64_REG(BPF_ADD, R0, R6),
  3299				BPF_ALU64_REG(BPF_ADD, R0, R7),
  3300				BPF_ALU64_REG(BPF_ADD, R0, R8),
  3301				BPF_ALU64_REG(BPF_ADD, R0, R9),
  3302				BPF_ALU64_IMM(BPF_ADD, R0, 0xfefe),
  3303				BPF_EXIT_INSN(),
  3304			},
  3305			INTERNAL,
  3306			{ },
  3307			{ { 0, 0xfefe } }
  3308		},
  3309		{	/* Mainly checking JIT here. */
  3310			"MOV REG32",
  3311			.u.insns_int = {
  3312				BPF_LD_IMM64(R0, 0xffffffffffffffffLL),
  3313				BPF_MOV64_REG(R1, R0),
  3314				BPF_MOV64_REG(R2, R1),
  3315				BPF_MOV64_REG(R3, R2),
  3316				BPF_MOV64_REG(R4, R3),
  3317				BPF_MOV64_REG(R5, R4),
  3318				BPF_MOV64_REG(R6, R5),
  3319				BPF_MOV64_REG(R7, R6),
  3320				BPF_MOV64_REG(R8, R7),
  3321				BPF_MOV64_REG(R9, R8),
  3322				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  3323				BPF_ALU32_IMM(BPF_MOV, R1, 0),
  3324				BPF_ALU32_IMM(BPF_MOV, R2, 0),
  3325				BPF_ALU32_IMM(BPF_MOV, R3, 0),
  3326				BPF_ALU32_IMM(BPF_MOV, R4, 0),
  3327				BPF_ALU32_IMM(BPF_MOV, R5, 0),
  3328				BPF_ALU32_IMM(BPF_MOV, R6, 0),
  3329				BPF_ALU32_IMM(BPF_MOV, R7, 0),
  3330				BPF_ALU32_IMM(BPF_MOV, R8, 0),
  3331				BPF_ALU32_IMM(BPF_MOV, R9, 0),
  3332				BPF_ALU64_REG(BPF_ADD, R0, R0),
  3333				BPF_ALU64_REG(BPF_ADD, R0, R1),
  3334				BPF_ALU64_REG(BPF_ADD, R0, R2),
  3335				BPF_ALU64_REG(BPF_ADD, R0, R3),
  3336				BPF_ALU64_REG(BPF_ADD, R0, R4),
  3337				BPF_ALU64_REG(BPF_ADD, R0, R5),
  3338				BPF_ALU64_REG(BPF_ADD, R0, R6),
  3339				BPF_ALU64_REG(BPF_ADD, R0, R7),
  3340				BPF_ALU64_REG(BPF_ADD, R0, R8),
  3341				BPF_ALU64_REG(BPF_ADD, R0, R9),
  3342				BPF_ALU64_IMM(BPF_ADD, R0, 0xfefe),
  3343				BPF_EXIT_INSN(),
  3344			},
  3345			INTERNAL,
  3346			{ },
  3347			{ { 0, 0xfefe } }
  3348		},
  3349		{	/* Mainly checking JIT here. */
  3350			"LD IMM64",
  3351			.u.insns_int = {
  3352				BPF_LD_IMM64(R0, 0xffffffffffffffffLL),
  3353				BPF_MOV64_REG(R1, R0),
  3354				BPF_MOV64_REG(R2, R1),
  3355				BPF_MOV64_REG(R3, R2),
  3356				BPF_MOV64_REG(R4, R3),
  3357				BPF_MOV64_REG(R5, R4),
  3358				BPF_MOV64_REG(R6, R5),
  3359				BPF_MOV64_REG(R7, R6),
  3360				BPF_MOV64_REG(R8, R7),
  3361				BPF_MOV64_REG(R9, R8),
  3362				BPF_LD_IMM64(R0, 0x0LL),
  3363				BPF_LD_IMM64(R1, 0x0LL),
  3364				BPF_LD_IMM64(R2, 0x0LL),
  3365				BPF_LD_IMM64(R3, 0x0LL),
  3366				BPF_LD_IMM64(R4, 0x0LL),
  3367				BPF_LD_IMM64(R5, 0x0LL),
  3368				BPF_LD_IMM64(R6, 0x0LL),
  3369				BPF_LD_IMM64(R7, 0x0LL),
  3370				BPF_LD_IMM64(R8, 0x0LL),
  3371				BPF_LD_IMM64(R9, 0x0LL),
  3372				BPF_ALU64_REG(BPF_ADD, R0, R0),
  3373				BPF_ALU64_REG(BPF_ADD, R0, R1),
  3374				BPF_ALU64_REG(BPF_ADD, R0, R2),
  3375				BPF_ALU64_REG(BPF_ADD, R0, R3),
  3376				BPF_ALU64_REG(BPF_ADD, R0, R4),
  3377				BPF_ALU64_REG(BPF_ADD, R0, R5),
  3378				BPF_ALU64_REG(BPF_ADD, R0, R6),
  3379				BPF_ALU64_REG(BPF_ADD, R0, R7),
  3380				BPF_ALU64_REG(BPF_ADD, R0, R8),
  3381				BPF_ALU64_REG(BPF_ADD, R0, R9),
  3382				BPF_ALU64_IMM(BPF_ADD, R0, 0xfefe),
  3383				BPF_EXIT_INSN(),
  3384			},
  3385			INTERNAL,
  3386			{ },
  3387			{ { 0, 0xfefe } }
  3388		},
  3389		{
  3390			"INT: ALU MIX",
  3391			.u.insns_int = {
  3392				BPF_ALU64_IMM(BPF_MOV, R0, 11),
  3393				BPF_ALU64_IMM(BPF_ADD, R0, -1),
  3394				BPF_ALU64_IMM(BPF_MOV, R2, 2),
  3395				BPF_ALU64_IMM(BPF_XOR, R2, 3),
  3396				BPF_ALU64_REG(BPF_DIV, R0, R2),
  3397				BPF_JMP_IMM(BPF_JEQ, R0, 10, 1),
  3398				BPF_EXIT_INSN(),
  3399				BPF_ALU64_IMM(BPF_MOD, R0, 3),
  3400				BPF_JMP_IMM(BPF_JEQ, R0, 1, 1),
  3401				BPF_EXIT_INSN(),
  3402				BPF_ALU64_IMM(BPF_MOV, R0, -1),
  3403				BPF_EXIT_INSN(),
  3404			},
  3405			INTERNAL,
  3406			{ },
  3407			{ { 0, -1 } }
  3408		},
  3409		{
  3410			"INT: shifts by register",
  3411			.u.insns_int = {
  3412				BPF_MOV64_IMM(R0, -1234),
  3413				BPF_MOV64_IMM(R1, 1),
  3414				BPF_ALU32_REG(BPF_RSH, R0, R1),
  3415				BPF_JMP_IMM(BPF_JEQ, R0, 0x7ffffd97, 1),
  3416				BPF_EXIT_INSN(),
  3417				BPF_MOV64_IMM(R2, 1),
  3418				BPF_ALU64_REG(BPF_LSH, R0, R2),
  3419				BPF_MOV32_IMM(R4, -1234),
  3420				BPF_JMP_REG(BPF_JEQ, R0, R4, 1),
  3421				BPF_EXIT_INSN(),
  3422				BPF_ALU64_IMM(BPF_AND, R4, 63),
  3423				BPF_ALU64_REG(BPF_LSH, R0, R4), /* R0 <= 46 */
  3424				BPF_MOV64_IMM(R3, 47),
  3425				BPF_ALU64_REG(BPF_ARSH, R0, R3),
  3426				BPF_JMP_IMM(BPF_JEQ, R0, -617, 1),
  3427				BPF_EXIT_INSN(),
  3428				BPF_MOV64_IMM(R2, 1),
  3429				BPF_ALU64_REG(BPF_LSH, R4, R2), /* R4 = 46 << 1 */
  3430				BPF_JMP_IMM(BPF_JEQ, R4, 92, 1),
  3431				BPF_EXIT_INSN(),
  3432				BPF_MOV64_IMM(R4, 4),
  3433				BPF_ALU64_REG(BPF_LSH, R4, R4), /* R4 = 4 << 4 */
  3434				BPF_JMP_IMM(BPF_JEQ, R4, 64, 1),
  3435				BPF_EXIT_INSN(),
  3436				BPF_MOV64_IMM(R4, 5),
  3437				BPF_ALU32_REG(BPF_LSH, R4, R4), /* R4 = 5 << 5 */
  3438				BPF_JMP_IMM(BPF_JEQ, R4, 160, 1),
  3439				BPF_EXIT_INSN(),
  3440				BPF_MOV64_IMM(R0, -1),
  3441				BPF_EXIT_INSN(),
  3442			},
  3443			INTERNAL,
  3444			{ },
  3445			{ { 0, -1 } }
  3446		},
  3447		{
  3448			/*
  3449			 * Register (non-)clobbering test, in the case where a 32-bit
  3450			 * JIT implements complex ALU64 operations via function calls.
  3451			 * If so, the function call must be invisible in the eBPF
  3452			 * registers. The JIT must then save and restore relevant
  3453			 * registers during the call. The following tests check that
  3454			 * the eBPF registers retain their values after such a call.
  3455			 */
  3456			"INT: Register clobbering, R1 updated",
  3457			.u.insns_int = {
  3458				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  3459				BPF_ALU32_IMM(BPF_MOV, R1, 123456789),
  3460				BPF_ALU32_IMM(BPF_MOV, R2, 2),
  3461				BPF_ALU32_IMM(BPF_MOV, R3, 3),
  3462				BPF_ALU32_IMM(BPF_MOV, R4, 4),
  3463				BPF_ALU32_IMM(BPF_MOV, R5, 5),
  3464				BPF_ALU32_IMM(BPF_MOV, R6, 6),
  3465				BPF_ALU32_IMM(BPF_MOV, R7, 7),
  3466				BPF_ALU32_IMM(BPF_MOV, R8, 8),
  3467				BPF_ALU32_IMM(BPF_MOV, R9, 9),
  3468				BPF_ALU64_IMM(BPF_DIV, R1, 123456789),
  3469				BPF_JMP_IMM(BPF_JNE, R0, 0, 10),
  3470				BPF_JMP_IMM(BPF_JNE, R1, 1, 9),
  3471				BPF_JMP_IMM(BPF_JNE, R2, 2, 8),
  3472				BPF_JMP_IMM(BPF_JNE, R3, 3, 7),
  3473				BPF_JMP_IMM(BPF_JNE, R4, 4, 6),
  3474				BPF_JMP_IMM(BPF_JNE, R5, 5, 5),
  3475				BPF_JMP_IMM(BPF_JNE, R6, 6, 4),
  3476				BPF_JMP_IMM(BPF_JNE, R7, 7, 3),
  3477				BPF_JMP_IMM(BPF_JNE, R8, 8, 2),
  3478				BPF_JMP_IMM(BPF_JNE, R9, 9, 1),
  3479				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  3480				BPF_EXIT_INSN(),
  3481			},
  3482			INTERNAL,
  3483			{ },
  3484			{ { 0, 1 } }
  3485		},
  3486		{
  3487			"INT: Register clobbering, R2 updated",
  3488			.u.insns_int = {
  3489				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  3490				BPF_ALU32_IMM(BPF_MOV, R1, 1),
  3491				BPF_ALU32_IMM(BPF_MOV, R2, 2 * 123456789),
  3492				BPF_ALU32_IMM(BPF_MOV, R3, 3),
  3493				BPF_ALU32_IMM(BPF_MOV, R4, 4),
  3494				BPF_ALU32_IMM(BPF_MOV, R5, 5),
  3495				BPF_ALU32_IMM(BPF_MOV, R6, 6),
  3496				BPF_ALU32_IMM(BPF_MOV, R7, 7),
  3497				BPF_ALU32_IMM(BPF_MOV, R8, 8),
  3498				BPF_ALU32_IMM(BPF_MOV, R9, 9),
  3499				BPF_ALU64_IMM(BPF_DIV, R2, 123456789),
  3500				BPF_JMP_IMM(BPF_JNE, R0, 0, 10),
  3501				BPF_JMP_IMM(BPF_JNE, R1, 1, 9),
  3502				BPF_JMP_IMM(BPF_JNE, R2, 2, 8),
  3503				BPF_JMP_IMM(BPF_JNE, R3, 3, 7),
  3504				BPF_JMP_IMM(BPF_JNE, R4, 4, 6),
  3505				BPF_JMP_IMM(BPF_JNE, R5, 5, 5),
  3506				BPF_JMP_IMM(BPF_JNE, R6, 6, 4),
  3507				BPF_JMP_IMM(BPF_JNE, R7, 7, 3),
  3508				BPF_JMP_IMM(BPF_JNE, R8, 8, 2),
  3509				BPF_JMP_IMM(BPF_JNE, R9, 9, 1),
  3510				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  3511				BPF_EXIT_INSN(),
  3512			},
  3513			INTERNAL,
  3514			{ },
  3515			{ { 0, 1 } }
  3516		},
  3517		{
  3518			/*
  3519			 * Test 32-bit JITs that implement complex ALU64 operations as
  3520			 * function calls R0 = f(R1, R2), and must re-arrange operands.
  3521			 */
  3522	#define NUMER 0xfedcba9876543210ULL
  3523	#define DENOM 0x0123456789abcdefULL
  3524			"ALU64_DIV X: Operand register permutations",
  3525			.u.insns_int = {
  3526				/* R0 / R2 */
  3527				BPF_LD_IMM64(R0, NUMER),
  3528				BPF_LD_IMM64(R2, DENOM),
  3529				BPF_ALU64_REG(BPF_DIV, R0, R2),
  3530				BPF_JMP_IMM(BPF_JEQ, R0, NUMER / DENOM, 1),
  3531				BPF_EXIT_INSN(),
  3532				/* R1 / R0 */
  3533				BPF_LD_IMM64(R1, NUMER),
  3534				BPF_LD_IMM64(R0, DENOM),
  3535				BPF_ALU64_REG(BPF_DIV, R1, R0),
  3536				BPF_JMP_IMM(BPF_JEQ, R1, NUMER / DENOM, 1),
  3537				BPF_EXIT_INSN(),
  3538				/* R0 / R1 */
  3539				BPF_LD_IMM64(R0, NUMER),
  3540				BPF_LD_IMM64(R1, DENOM),
  3541				BPF_ALU64_REG(BPF_DIV, R0, R1),
  3542				BPF_JMP_IMM(BPF_JEQ, R0, NUMER / DENOM, 1),
  3543				BPF_EXIT_INSN(),
  3544				/* R2 / R0 */
  3545				BPF_LD_IMM64(R2, NUMER),
  3546				BPF_LD_IMM64(R0, DENOM),
  3547				BPF_ALU64_REG(BPF_DIV, R2, R0),
  3548				BPF_JMP_IMM(BPF_JEQ, R2, NUMER / DENOM, 1),
  3549				BPF_EXIT_INSN(),
  3550				/* R2 / R1 */
  3551				BPF_LD_IMM64(R2, NUMER),
  3552				BPF_LD_IMM64(R1, DENOM),
  3553				BPF_ALU64_REG(BPF_DIV, R2, R1),
  3554				BPF_JMP_IMM(BPF_JEQ, R2, NUMER / DENOM, 1),
  3555				BPF_EXIT_INSN(),
  3556				/* R1 / R2 */
  3557				BPF_LD_IMM64(R1, NUMER),
  3558				BPF_LD_IMM64(R2, DENOM),
  3559				BPF_ALU64_REG(BPF_DIV, R1, R2),
  3560				BPF_JMP_IMM(BPF_JEQ, R1, NUMER / DENOM, 1),
  3561				BPF_EXIT_INSN(),
  3562				/* R1 / R1 */
  3563				BPF_LD_IMM64(R1, NUMER),
  3564				BPF_ALU64_REG(BPF_DIV, R1, R1),
  3565				BPF_JMP_IMM(BPF_JEQ, R1, 1, 1),
  3566				BPF_EXIT_INSN(),
  3567				/* R2 / R2 */
  3568				BPF_LD_IMM64(R2, DENOM),
  3569				BPF_ALU64_REG(BPF_DIV, R2, R2),
  3570				BPF_JMP_IMM(BPF_JEQ, R2, 1, 1),
  3571				BPF_EXIT_INSN(),
  3572				/* R3 / R4 */
  3573				BPF_LD_IMM64(R3, NUMER),
  3574				BPF_LD_IMM64(R4, DENOM),
  3575				BPF_ALU64_REG(BPF_DIV, R3, R4),
  3576				BPF_JMP_IMM(BPF_JEQ, R3, NUMER / DENOM, 1),
  3577				BPF_EXIT_INSN(),
  3578				/* Successful return */
  3579				BPF_LD_IMM64(R0, 1),
  3580				BPF_EXIT_INSN(),
  3581			},
  3582			INTERNAL,
  3583			{ },
  3584			{ { 0, 1 } },
  3585	#undef NUMER
  3586	#undef DENOM
  3587		},
  3588	#ifdef CONFIG_32BIT
  3589		{
  3590			"INT: 32-bit context pointer word order and zero-extension",
  3591			.u.insns_int = {
  3592				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  3593				BPF_JMP32_IMM(BPF_JEQ, R1, 0, 3),
  3594				BPF_ALU64_IMM(BPF_RSH, R1, 32),
  3595				BPF_JMP32_IMM(BPF_JNE, R1, 0, 1),
  3596				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  3597				BPF_EXIT_INSN(),
  3598			},
  3599			INTERNAL,
  3600			{ },
  3601			{ { 0, 1 } }
  3602		},
  3603	#endif
  3604		{
  3605			"check: missing ret",
  3606			.u.insns = {
  3607				BPF_STMT(BPF_LD | BPF_IMM, 1),
  3608			},
  3609			CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
  3610			{ },
  3611			{ },
  3612			.fill_helper = NULL,
  3613			.expected_errcode = -EINVAL,
  3614		},
  3615		{
  3616			"check: div_k_0",
  3617			.u.insns = {
  3618				BPF_STMT(BPF_ALU | BPF_DIV | BPF_K, 0),
  3619				BPF_STMT(BPF_RET | BPF_K, 0)
  3620			},
  3621			CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
  3622			{ },
  3623			{ },
  3624			.fill_helper = NULL,
  3625			.expected_errcode = -EINVAL,
  3626		},
  3627		{
  3628			"check: unknown insn",
  3629			.u.insns = {
  3630				/* seccomp insn, rejected in socket filter */
  3631				BPF_STMT(BPF_LDX | BPF_W | BPF_ABS, 0),
  3632				BPF_STMT(BPF_RET | BPF_K, 0)
  3633			},
  3634			CLASSIC | FLAG_EXPECTED_FAIL,
  3635			{ },
  3636			{ },
  3637			.fill_helper = NULL,
  3638			.expected_errcode = -EINVAL,
  3639		},
  3640		{
  3641			"check: out of range spill/fill",
  3642			.u.insns = {
  3643				BPF_STMT(BPF_STX, 16),
  3644				BPF_STMT(BPF_RET | BPF_K, 0)
  3645			},
  3646			CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
  3647			{ },
  3648			{ },
  3649			.fill_helper = NULL,
  3650			.expected_errcode = -EINVAL,
  3651		},
  3652		{
  3653			"JUMPS + HOLES",
  3654			.u.insns = {
  3655				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3656				BPF_JUMP(BPF_JMP | BPF_JGE, 0, 13, 15),
  3657				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3658				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3659				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3660				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3661				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3662				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3663				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3664				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3665				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3666				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3667				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3668				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3669				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3670				BPF_JUMP(BPF_JMP | BPF_JEQ, 0x90c2894d, 3, 4),
  3671				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3672				BPF_JUMP(BPF_JMP | BPF_JEQ, 0x90c2894d, 1, 2),
  3673				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3674				BPF_JUMP(BPF_JMP | BPF_JGE, 0, 14, 15),
  3675				BPF_JUMP(BPF_JMP | BPF_JGE, 0, 13, 14),
  3676				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3677				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3678				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3679				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3680				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3681				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3682				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3683				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3684				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3685				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3686				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3687				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3688				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3689				BPF_JUMP(BPF_JMP | BPF_JEQ, 0x2ac28349, 2, 3),
  3690				BPF_JUMP(BPF_JMP | BPF_JEQ, 0x2ac28349, 1, 2),
  3691				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3692				BPF_JUMP(BPF_JMP | BPF_JGE, 0, 14, 15),
  3693				BPF_JUMP(BPF_JMP | BPF_JGE, 0, 13, 14),
  3694				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3695				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3696				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3697				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3698				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3699				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3700				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3701				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3702				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3703				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3704				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3705				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3706				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3707				BPF_JUMP(BPF_JMP | BPF_JEQ, 0x90d2ff41, 2, 3),
  3708				BPF_JUMP(BPF_JMP | BPF_JEQ, 0x90d2ff41, 1, 2),
  3709				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  3710				BPF_STMT(BPF_RET | BPF_A, 0),
  3711				BPF_STMT(BPF_RET | BPF_A, 0),
  3712			},
  3713			CLASSIC,
  3714			{ 0x00, 0x1b, 0x21, 0x3c, 0x9d, 0xf8,
  3715			  0x90, 0xe2, 0xba, 0x0a, 0x56, 0xb4,
  3716			  0x08, 0x00,
  3717			  0x45, 0x00, 0x00, 0x28, 0x00, 0x00,
  3718			  0x20, 0x00, 0x40, 0x11, 0x00, 0x00, /* IP header */
  3719			  0xc0, 0xa8, 0x33, 0x01,
  3720			  0xc0, 0xa8, 0x33, 0x02,
  3721			  0xbb, 0xb6,
  3722			  0xa9, 0xfa,
  3723			  0x00, 0x14, 0x00, 0x00,
  3724			  0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
  3725			  0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
  3726			  0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
  3727			  0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
  3728			  0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
  3729			  0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
  3730			  0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
  3731			  0xcc, 0xcc, 0xcc, 0xcc },
  3732			{ { 88, 0x001b } }
  3733		},
  3734		{
  3735			"check: RET X",
  3736			.u.insns = {
  3737				BPF_STMT(BPF_RET | BPF_X, 0),
  3738			},
  3739			CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
  3740			{ },
  3741			{ },
  3742			.fill_helper = NULL,
  3743			.expected_errcode = -EINVAL,
  3744		},
  3745		{
  3746			"check: LDX + RET X",
  3747			.u.insns = {
  3748				BPF_STMT(BPF_LDX | BPF_IMM, 42),
  3749				BPF_STMT(BPF_RET | BPF_X, 0),
  3750			},
  3751			CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
  3752			{ },
  3753			{ },
  3754			.fill_helper = NULL,
  3755			.expected_errcode = -EINVAL,
  3756		},
  3757		{	/* Mainly checking JIT here. */
  3758			"M[]: alt STX + LDX",
  3759			.u.insns = {
  3760				BPF_STMT(BPF_LDX | BPF_IMM, 100),
  3761				BPF_STMT(BPF_STX, 0),
  3762				BPF_STMT(BPF_LDX | BPF_MEM, 0),
  3763				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  3764				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  3765				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3766				BPF_STMT(BPF_STX, 1),
  3767				BPF_STMT(BPF_LDX | BPF_MEM, 1),
  3768				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  3769				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  3770				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3771				BPF_STMT(BPF_STX, 2),
  3772				BPF_STMT(BPF_LDX | BPF_MEM, 2),
  3773				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  3774				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  3775				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3776				BPF_STMT(BPF_STX, 3),
  3777				BPF_STMT(BPF_LDX | BPF_MEM, 3),
  3778				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  3779				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  3780				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3781				BPF_STMT(BPF_STX, 4),
  3782				BPF_STMT(BPF_LDX | BPF_MEM, 4),
  3783				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  3784				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  3785				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3786				BPF_STMT(BPF_STX, 5),
  3787				BPF_STMT(BPF_LDX | BPF_MEM, 5),
  3788				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  3789				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  3790				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3791				BPF_STMT(BPF_STX, 6),
  3792				BPF_STMT(BPF_LDX | BPF_MEM, 6),
  3793				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  3794				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  3795				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3796				BPF_STMT(BPF_STX, 7),
  3797				BPF_STMT(BPF_LDX | BPF_MEM, 7),
  3798				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  3799				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  3800				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3801				BPF_STMT(BPF_STX, 8),
  3802				BPF_STMT(BPF_LDX | BPF_MEM, 8),
  3803				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  3804				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  3805				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3806				BPF_STMT(BPF_STX, 9),
  3807				BPF_STMT(BPF_LDX | BPF_MEM, 9),
  3808				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  3809				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  3810				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3811				BPF_STMT(BPF_STX, 10),
  3812				BPF_STMT(BPF_LDX | BPF_MEM, 10),
  3813				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  3814				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  3815				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3816				BPF_STMT(BPF_STX, 11),
  3817				BPF_STMT(BPF_LDX | BPF_MEM, 11),
  3818				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  3819				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  3820				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3821				BPF_STMT(BPF_STX, 12),
  3822				BPF_STMT(BPF_LDX | BPF_MEM, 12),
  3823				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  3824				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  3825				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3826				BPF_STMT(BPF_STX, 13),
  3827				BPF_STMT(BPF_LDX | BPF_MEM, 13),
  3828				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  3829				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  3830				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3831				BPF_STMT(BPF_STX, 14),
  3832				BPF_STMT(BPF_LDX | BPF_MEM, 14),
  3833				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  3834				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  3835				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3836				BPF_STMT(BPF_STX, 15),
  3837				BPF_STMT(BPF_LDX | BPF_MEM, 15),
  3838				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  3839				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  3840				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  3841				BPF_STMT(BPF_RET | BPF_A, 0),
  3842			},
  3843			CLASSIC | FLAG_NO_DATA,
  3844			{ },
  3845			{ { 0, 116 } },
  3846		},
  3847		{	/* Mainly checking JIT here. */
  3848			"M[]: full STX + full LDX",
  3849			.u.insns = {
  3850				BPF_STMT(BPF_LDX | BPF_IMM, 0xbadfeedb),
  3851				BPF_STMT(BPF_STX, 0),
  3852				BPF_STMT(BPF_LDX | BPF_IMM, 0xecabedae),
  3853				BPF_STMT(BPF_STX, 1),
  3854				BPF_STMT(BPF_LDX | BPF_IMM, 0xafccfeaf),
  3855				BPF_STMT(BPF_STX, 2),
  3856				BPF_STMT(BPF_LDX | BPF_IMM, 0xbffdcedc),
  3857				BPF_STMT(BPF_STX, 3),
  3858				BPF_STMT(BPF_LDX | BPF_IMM, 0xfbbbdccb),
  3859				BPF_STMT(BPF_STX, 4),
  3860				BPF_STMT(BPF_LDX | BPF_IMM, 0xfbabcbda),
  3861				BPF_STMT(BPF_STX, 5),
  3862				BPF_STMT(BPF_LDX | BPF_IMM, 0xaedecbdb),
  3863				BPF_STMT(BPF_STX, 6),
  3864				BPF_STMT(BPF_LDX | BPF_IMM, 0xadebbade),
  3865				BPF_STMT(BPF_STX, 7),
  3866				BPF_STMT(BPF_LDX | BPF_IMM, 0xfcfcfaec),
  3867				BPF_STMT(BPF_STX, 8),
  3868				BPF_STMT(BPF_LDX | BPF_IMM, 0xbcdddbdc),
  3869				BPF_STMT(BPF_STX, 9),
  3870				BPF_STMT(BPF_LDX | BPF_IMM, 0xfeefdfac),
  3871				BPF_STMT(BPF_STX, 10),
  3872				BPF_STMT(BPF_LDX | BPF_IMM, 0xcddcdeea),
  3873				BPF_STMT(BPF_STX, 11),
  3874				BPF_STMT(BPF_LDX | BPF_IMM, 0xaccfaebb),
  3875				BPF_STMT(BPF_STX, 12),
  3876				BPF_STMT(BPF_LDX | BPF_IMM, 0xbdcccdcf),
  3877				BPF_STMT(BPF_STX, 13),
  3878				BPF_STMT(BPF_LDX | BPF_IMM, 0xaaedecde),
  3879				BPF_STMT(BPF_STX, 14),
  3880				BPF_STMT(BPF_LDX | BPF_IMM, 0xfaeacdad),
  3881				BPF_STMT(BPF_STX, 15),
  3882				BPF_STMT(BPF_LDX | BPF_MEM, 0),
  3883				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  3884				BPF_STMT(BPF_LDX | BPF_MEM, 1),
  3885				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  3886				BPF_STMT(BPF_LDX | BPF_MEM, 2),
  3887				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  3888				BPF_STMT(BPF_LDX | BPF_MEM, 3),
  3889				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  3890				BPF_STMT(BPF_LDX | BPF_MEM, 4),
  3891				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  3892				BPF_STMT(BPF_LDX | BPF_MEM, 5),
  3893				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  3894				BPF_STMT(BPF_LDX | BPF_MEM, 6),
  3895				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  3896				BPF_STMT(BPF_LDX | BPF_MEM, 7),
  3897				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  3898				BPF_STMT(BPF_LDX | BPF_MEM, 8),
  3899				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  3900				BPF_STMT(BPF_LDX | BPF_MEM, 9),
  3901				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  3902				BPF_STMT(BPF_LDX | BPF_MEM, 10),
  3903				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  3904				BPF_STMT(BPF_LDX | BPF_MEM, 11),
  3905				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  3906				BPF_STMT(BPF_LDX | BPF_MEM, 12),
  3907				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  3908				BPF_STMT(BPF_LDX | BPF_MEM, 13),
  3909				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  3910				BPF_STMT(BPF_LDX | BPF_MEM, 14),
  3911				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  3912				BPF_STMT(BPF_LDX | BPF_MEM, 15),
  3913				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  3914				BPF_STMT(BPF_RET | BPF_A, 0),
  3915			},
  3916			CLASSIC | FLAG_NO_DATA,
  3917			{ },
  3918			{ { 0, 0x2a5a5e5 } },
  3919		},
  3920		{
  3921			"check: SKF_AD_MAX",
  3922			.u.insns = {
  3923				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3924					 SKF_AD_OFF + SKF_AD_MAX),
  3925				BPF_STMT(BPF_RET | BPF_A, 0),
  3926			},
  3927			CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
  3928			{ },
  3929			{ },
  3930			.fill_helper = NULL,
  3931			.expected_errcode = -EINVAL,
  3932		},
  3933		{	/* Passes checker but fails during runtime. */
  3934			"LD [SKF_AD_OFF-1]",
  3935			.u.insns = {
  3936				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  3937					 SKF_AD_OFF - 1),
  3938				BPF_STMT(BPF_RET | BPF_K, 1),
  3939			},
  3940			CLASSIC,
  3941			{ },
  3942			{ { 1, 0 } },
  3943		},
  3944		{
  3945			"load 64-bit immediate",
  3946			.u.insns_int = {
  3947				BPF_LD_IMM64(R1, 0x567800001234LL),
  3948				BPF_MOV64_REG(R2, R1),
  3949				BPF_MOV64_REG(R3, R2),
  3950				BPF_ALU64_IMM(BPF_RSH, R2, 32),
  3951				BPF_ALU64_IMM(BPF_LSH, R3, 32),
  3952				BPF_ALU64_IMM(BPF_RSH, R3, 32),
  3953				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  3954				BPF_JMP_IMM(BPF_JEQ, R2, 0x5678, 1),
  3955				BPF_EXIT_INSN(),
  3956				BPF_JMP_IMM(BPF_JEQ, R3, 0x1234, 1),
  3957				BPF_EXIT_INSN(),
  3958				BPF_LD_IMM64(R0, 0x1ffffffffLL),
  3959				BPF_ALU64_IMM(BPF_RSH, R0, 32), /* R0 = 1 */
  3960				BPF_EXIT_INSN(),
  3961			},
  3962			INTERNAL,
  3963			{ },
  3964			{ { 0, 1 } }
  3965		},
  3966		/* BPF_ALU | BPF_MOV | BPF_X */
  3967		{
  3968			"ALU_MOV_X: dst = 2",
  3969			.u.insns_int = {
  3970				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  3971				BPF_ALU32_REG(BPF_MOV, R0, R1),
  3972				BPF_EXIT_INSN(),
  3973			},
  3974			INTERNAL,
  3975			{ },
  3976			{ { 0, 2 } },
  3977		},
  3978		{
  3979			"ALU_MOV_X: dst = 4294967295",
  3980			.u.insns_int = {
  3981				BPF_ALU32_IMM(BPF_MOV, R1, 4294967295U),
  3982				BPF_ALU32_REG(BPF_MOV, R0, R1),
  3983				BPF_EXIT_INSN(),
  3984			},
  3985			INTERNAL,
  3986			{ },
  3987			{ { 0, 4294967295U } },
  3988		},
  3989		{
  3990			"ALU64_MOV_X: dst = 2",
  3991			.u.insns_int = {
  3992				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  3993				BPF_ALU64_REG(BPF_MOV, R0, R1),
  3994				BPF_EXIT_INSN(),
  3995			},
  3996			INTERNAL,
  3997			{ },
  3998			{ { 0, 2 } },
  3999		},
  4000		{
  4001			"ALU64_MOV_X: dst = 4294967295",
  4002			.u.insns_int = {
  4003				BPF_ALU32_IMM(BPF_MOV, R1, 4294967295U),
  4004				BPF_ALU64_REG(BPF_MOV, R0, R1),
  4005				BPF_EXIT_INSN(),
  4006			},
  4007			INTERNAL,
  4008			{ },
  4009			{ { 0, 4294967295U } },
  4010		},
  4011		/* BPF_ALU | BPF_MOV | BPF_K */
  4012		{
  4013			"ALU_MOV_K: dst = 2",
  4014			.u.insns_int = {
  4015				BPF_ALU32_IMM(BPF_MOV, R0, 2),
  4016				BPF_EXIT_INSN(),
  4017			},
  4018			INTERNAL,
  4019			{ },
  4020			{ { 0, 2 } },
  4021		},
  4022		{
  4023			"ALU_MOV_K: dst = 4294967295",
  4024			.u.insns_int = {
  4025				BPF_ALU32_IMM(BPF_MOV, R0, 4294967295U),
  4026				BPF_EXIT_INSN(),
  4027			},
  4028			INTERNAL,
  4029			{ },
  4030			{ { 0, 4294967295U } },
  4031		},
  4032		{
  4033			"ALU_MOV_K: 0x0000ffffffff0000 = 0x00000000ffffffff",
  4034			.u.insns_int = {
  4035				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  4036				BPF_LD_IMM64(R3, 0x00000000ffffffffLL),
  4037				BPF_ALU32_IMM(BPF_MOV, R2, 0xffffffff),
  4038				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  4039				BPF_MOV32_IMM(R0, 2),
  4040				BPF_EXIT_INSN(),
  4041				BPF_MOV32_IMM(R0, 1),
  4042				BPF_EXIT_INSN(),
  4043			},
  4044			INTERNAL,
  4045			{ },
  4046			{ { 0, 0x1 } },
  4047		},
  4048		{
  4049			"ALU_MOV_K: small negative",
  4050			.u.insns_int = {
  4051				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  4052				BPF_EXIT_INSN(),
  4053			},
  4054			INTERNAL,
  4055			{ },
  4056			{ { 0, -123 } }
  4057		},
  4058		{
  4059			"ALU_MOV_K: small negative zero extension",
  4060			.u.insns_int = {
  4061				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  4062				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4063				BPF_EXIT_INSN(),
  4064			},
  4065			INTERNAL,
  4066			{ },
  4067			{ { 0, 0 } }
  4068		},
  4069		{
  4070			"ALU_MOV_K: large negative",
  4071			.u.insns_int = {
  4072				BPF_ALU32_IMM(BPF_MOV, R0, -123456789),
  4073				BPF_EXIT_INSN(),
  4074			},
  4075			INTERNAL,
  4076			{ },
  4077			{ { 0, -123456789 } }
  4078		},
  4079		{
  4080			"ALU_MOV_K: large negative zero extension",
  4081			.u.insns_int = {
  4082				BPF_ALU32_IMM(BPF_MOV, R0, -123456789),
  4083				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4084				BPF_EXIT_INSN(),
  4085			},
  4086			INTERNAL,
  4087			{ },
  4088			{ { 0, 0 } }
  4089		},
  4090		{
  4091			"ALU64_MOV_K: dst = 2",
  4092			.u.insns_int = {
  4093				BPF_ALU64_IMM(BPF_MOV, R0, 2),
  4094				BPF_EXIT_INSN(),
  4095			},
  4096			INTERNAL,
  4097			{ },
  4098			{ { 0, 2 } },
  4099		},
  4100		{
  4101			"ALU64_MOV_K: dst = 2147483647",
  4102			.u.insns_int = {
  4103				BPF_ALU64_IMM(BPF_MOV, R0, 2147483647),
  4104				BPF_EXIT_INSN(),
  4105			},
  4106			INTERNAL,
  4107			{ },
  4108			{ { 0, 2147483647 } },
  4109		},
  4110		{
  4111			"ALU64_OR_K: dst = 0x0",
  4112			.u.insns_int = {
  4113				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  4114				BPF_LD_IMM64(R3, 0x0),
  4115				BPF_ALU64_IMM(BPF_MOV, R2, 0x0),
  4116				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  4117				BPF_MOV32_IMM(R0, 2),
  4118				BPF_EXIT_INSN(),
  4119				BPF_MOV32_IMM(R0, 1),
  4120				BPF_EXIT_INSN(),
  4121			},
  4122			INTERNAL,
  4123			{ },
  4124			{ { 0, 0x1 } },
  4125		},
  4126		{
  4127			"ALU64_MOV_K: dst = -1",
  4128			.u.insns_int = {
  4129				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  4130				BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
  4131				BPF_ALU64_IMM(BPF_MOV, R2, 0xffffffff),
  4132				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  4133				BPF_MOV32_IMM(R0, 2),
  4134				BPF_EXIT_INSN(),
  4135				BPF_MOV32_IMM(R0, 1),
  4136				BPF_EXIT_INSN(),
  4137			},
  4138			INTERNAL,
  4139			{ },
  4140			{ { 0, 0x1 } },
  4141		},
  4142		{
  4143			"ALU64_MOV_K: small negative",
  4144			.u.insns_int = {
  4145				BPF_ALU64_IMM(BPF_MOV, R0, -123),
  4146				BPF_EXIT_INSN(),
  4147			},
  4148			INTERNAL,
  4149			{ },
  4150			{ { 0, -123 } }
  4151		},
  4152		{
  4153			"ALU64_MOV_K: small negative sign extension",
  4154			.u.insns_int = {
  4155				BPF_ALU64_IMM(BPF_MOV, R0, -123),
  4156				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4157				BPF_EXIT_INSN(),
  4158			},
  4159			INTERNAL,
  4160			{ },
  4161			{ { 0, 0xffffffff } }
  4162		},
  4163		{
  4164			"ALU64_MOV_K: large negative",
  4165			.u.insns_int = {
  4166				BPF_ALU64_IMM(BPF_MOV, R0, -123456789),
  4167				BPF_EXIT_INSN(),
  4168			},
  4169			INTERNAL,
  4170			{ },
  4171			{ { 0, -123456789 } }
  4172		},
  4173		{
  4174			"ALU64_MOV_K: large negative sign extension",
  4175			.u.insns_int = {
  4176				BPF_ALU64_IMM(BPF_MOV, R0, -123456789),
  4177				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4178				BPF_EXIT_INSN(),
  4179			},
  4180			INTERNAL,
  4181			{ },
  4182			{ { 0, 0xffffffff } }
  4183		},
  4184		/* BPF_ALU | BPF_ADD | BPF_X */
  4185		{
  4186			"ALU_ADD_X: 1 + 2 = 3",
  4187			.u.insns_int = {
  4188				BPF_LD_IMM64(R0, 1),
  4189				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  4190				BPF_ALU32_REG(BPF_ADD, R0, R1),
  4191				BPF_EXIT_INSN(),
  4192			},
  4193			INTERNAL,
  4194			{ },
  4195			{ { 0, 3 } },
  4196		},
  4197		{
  4198			"ALU_ADD_X: 1 + 4294967294 = 4294967295",
  4199			.u.insns_int = {
  4200				BPF_LD_IMM64(R0, 1),
  4201				BPF_ALU32_IMM(BPF_MOV, R1, 4294967294U),
  4202				BPF_ALU32_REG(BPF_ADD, R0, R1),
  4203				BPF_EXIT_INSN(),
  4204			},
  4205			INTERNAL,
  4206			{ },
  4207			{ { 0, 4294967295U } },
  4208		},
  4209		{
  4210			"ALU_ADD_X: 2 + 4294967294 = 0",
  4211			.u.insns_int = {
  4212				BPF_LD_IMM64(R0, 2),
  4213				BPF_LD_IMM64(R1, 4294967294U),
  4214				BPF_ALU32_REG(BPF_ADD, R0, R1),
  4215				BPF_JMP_IMM(BPF_JEQ, R0, 0, 2),
  4216				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  4217				BPF_EXIT_INSN(),
  4218				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  4219				BPF_EXIT_INSN(),
  4220			},
  4221			INTERNAL,
  4222			{ },
  4223			{ { 0, 1 } },
  4224		},
  4225		{
  4226			"ALU64_ADD_X: 1 + 2 = 3",
  4227			.u.insns_int = {
  4228				BPF_LD_IMM64(R0, 1),
  4229				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  4230				BPF_ALU64_REG(BPF_ADD, R0, R1),
  4231				BPF_EXIT_INSN(),
  4232			},
  4233			INTERNAL,
  4234			{ },
  4235			{ { 0, 3 } },
  4236		},
  4237		{
  4238			"ALU64_ADD_X: 1 + 4294967294 = 4294967295",
  4239			.u.insns_int = {
  4240				BPF_LD_IMM64(R0, 1),
  4241				BPF_ALU32_IMM(BPF_MOV, R1, 4294967294U),
  4242				BPF_ALU64_REG(BPF_ADD, R0, R1),
  4243				BPF_EXIT_INSN(),
  4244			},
  4245			INTERNAL,
  4246			{ },
  4247			{ { 0, 4294967295U } },
  4248		},
  4249		{
  4250			"ALU64_ADD_X: 2 + 4294967294 = 4294967296",
  4251			.u.insns_int = {
  4252				BPF_LD_IMM64(R0, 2),
  4253				BPF_LD_IMM64(R1, 4294967294U),
  4254				BPF_LD_IMM64(R2, 4294967296ULL),
  4255				BPF_ALU64_REG(BPF_ADD, R0, R1),
  4256				BPF_JMP_REG(BPF_JEQ, R0, R2, 2),
  4257				BPF_MOV32_IMM(R0, 0),
  4258				BPF_EXIT_INSN(),
  4259				BPF_MOV32_IMM(R0, 1),
  4260				BPF_EXIT_INSN(),
  4261			},
  4262			INTERNAL,
  4263			{ },
  4264			{ { 0, 1 } },
  4265		},
  4266		/* BPF_ALU | BPF_ADD | BPF_K */
  4267		{
  4268			"ALU_ADD_K: 1 + 2 = 3",
  4269			.u.insns_int = {
  4270				BPF_LD_IMM64(R0, 1),
  4271				BPF_ALU32_IMM(BPF_ADD, R0, 2),
  4272				BPF_EXIT_INSN(),
  4273			},
  4274			INTERNAL,
  4275			{ },
  4276			{ { 0, 3 } },
  4277		},
  4278		{
  4279			"ALU_ADD_K: 3 + 0 = 3",
  4280			.u.insns_int = {
  4281				BPF_LD_IMM64(R0, 3),
  4282				BPF_ALU32_IMM(BPF_ADD, R0, 0),
  4283				BPF_EXIT_INSN(),
  4284			},
  4285			INTERNAL,
  4286			{ },
  4287			{ { 0, 3 } },
  4288		},
  4289		{
  4290			"ALU_ADD_K: 1 + 4294967294 = 4294967295",
  4291			.u.insns_int = {
  4292				BPF_LD_IMM64(R0, 1),
  4293				BPF_ALU32_IMM(BPF_ADD, R0, 4294967294U),
  4294				BPF_EXIT_INSN(),
  4295			},
  4296			INTERNAL,
  4297			{ },
  4298			{ { 0, 4294967295U } },
  4299		},
  4300		{
  4301			"ALU_ADD_K: 4294967294 + 2 = 0",
  4302			.u.insns_int = {
  4303				BPF_LD_IMM64(R0, 4294967294U),
  4304				BPF_ALU32_IMM(BPF_ADD, R0, 2),
  4305				BPF_JMP_IMM(BPF_JEQ, R0, 0, 2),
  4306				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  4307				BPF_EXIT_INSN(),
  4308				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  4309				BPF_EXIT_INSN(),
  4310			},
  4311			INTERNAL,
  4312			{ },
  4313			{ { 0, 1 } },
  4314		},
  4315		{
  4316			"ALU_ADD_K: 0 + (-1) = 0x00000000ffffffff",
  4317			.u.insns_int = {
  4318				BPF_LD_IMM64(R2, 0x0),
  4319				BPF_LD_IMM64(R3, 0x00000000ffffffff),
  4320				BPF_ALU32_IMM(BPF_ADD, R2, 0xffffffff),
  4321				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  4322				BPF_MOV32_IMM(R0, 2),
  4323				BPF_EXIT_INSN(),
  4324				BPF_MOV32_IMM(R0, 1),
  4325				BPF_EXIT_INSN(),
  4326			},
  4327			INTERNAL,
  4328			{ },
  4329			{ { 0, 0x1 } },
  4330		},
  4331		{
  4332			"ALU_ADD_K: 0 + 0xffff = 0xffff",
  4333			.u.insns_int = {
  4334				BPF_LD_IMM64(R2, 0x0),
  4335				BPF_LD_IMM64(R3, 0xffff),
  4336				BPF_ALU32_IMM(BPF_ADD, R2, 0xffff),
  4337				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  4338				BPF_MOV32_IMM(R0, 2),
  4339				BPF_EXIT_INSN(),
  4340				BPF_MOV32_IMM(R0, 1),
  4341				BPF_EXIT_INSN(),
  4342			},
  4343			INTERNAL,
  4344			{ },
  4345			{ { 0, 0x1 } },
  4346		},
  4347		{
  4348			"ALU_ADD_K: 0 + 0x7fffffff = 0x7fffffff",
  4349			.u.insns_int = {
  4350				BPF_LD_IMM64(R2, 0x0),
  4351				BPF_LD_IMM64(R3, 0x7fffffff),
  4352				BPF_ALU32_IMM(BPF_ADD, R2, 0x7fffffff),
  4353				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  4354				BPF_MOV32_IMM(R0, 2),
  4355				BPF_EXIT_INSN(),
  4356				BPF_MOV32_IMM(R0, 1),
  4357				BPF_EXIT_INSN(),
  4358			},
  4359			INTERNAL,
  4360			{ },
  4361			{ { 0, 0x1 } },
  4362		},
  4363		{
  4364			"ALU_ADD_K: 0 + 0x80000000 = 0x80000000",
  4365			.u.insns_int = {
  4366				BPF_LD_IMM64(R2, 0x0),
  4367				BPF_LD_IMM64(R3, 0x80000000),
  4368				BPF_ALU32_IMM(BPF_ADD, R2, 0x80000000),
  4369				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  4370				BPF_MOV32_IMM(R0, 2),
  4371				BPF_EXIT_INSN(),
  4372				BPF_MOV32_IMM(R0, 1),
  4373				BPF_EXIT_INSN(),
  4374			},
  4375			INTERNAL,
  4376			{ },
  4377			{ { 0, 0x1 } },
  4378		},
  4379		{
  4380			"ALU_ADD_K: 0 + 0x80008000 = 0x80008000",
  4381			.u.insns_int = {
  4382				BPF_LD_IMM64(R2, 0x0),
  4383				BPF_LD_IMM64(R3, 0x80008000),
  4384				BPF_ALU32_IMM(BPF_ADD, R2, 0x80008000),
  4385				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  4386				BPF_MOV32_IMM(R0, 2),
  4387				BPF_EXIT_INSN(),
  4388				BPF_MOV32_IMM(R0, 1),
  4389				BPF_EXIT_INSN(),
  4390			},
  4391			INTERNAL,
  4392			{ },
  4393			{ { 0, 0x1 } },
  4394		},
  4395		{
  4396			"ALU64_ADD_K: 1 + 2 = 3",
  4397			.u.insns_int = {
  4398				BPF_LD_IMM64(R0, 1),
  4399				BPF_ALU64_IMM(BPF_ADD, R0, 2),
  4400				BPF_EXIT_INSN(),
  4401			},
  4402			INTERNAL,
  4403			{ },
  4404			{ { 0, 3 } },
  4405		},
  4406		{
  4407			"ALU64_ADD_K: 3 + 0 = 3",
  4408			.u.insns_int = {
  4409				BPF_LD_IMM64(R0, 3),
  4410				BPF_ALU64_IMM(BPF_ADD, R0, 0),
  4411				BPF_EXIT_INSN(),
  4412			},
  4413			INTERNAL,
  4414			{ },
  4415			{ { 0, 3 } },
  4416		},
  4417		{
  4418			"ALU64_ADD_K: 1 + 2147483646 = 2147483647",
  4419			.u.insns_int = {
  4420				BPF_LD_IMM64(R0, 1),
  4421				BPF_ALU64_IMM(BPF_ADD, R0, 2147483646),
  4422				BPF_EXIT_INSN(),
  4423			},
  4424			INTERNAL,
  4425			{ },
  4426			{ { 0, 2147483647 } },
  4427		},
  4428		{
  4429			"ALU64_ADD_K: 4294967294 + 2 = 4294967296",
  4430			.u.insns_int = {
  4431				BPF_LD_IMM64(R0, 4294967294U),
  4432				BPF_LD_IMM64(R1, 4294967296ULL),
  4433				BPF_ALU64_IMM(BPF_ADD, R0, 2),
  4434				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  4435				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  4436				BPF_EXIT_INSN(),
  4437				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  4438				BPF_EXIT_INSN(),
  4439			},
  4440			INTERNAL,
  4441			{ },
  4442			{ { 0, 1 } },
  4443		},
  4444		{
  4445			"ALU64_ADD_K: 2147483646 + -2147483647 = -1",
  4446			.u.insns_int = {
  4447				BPF_LD_IMM64(R0, 2147483646),
  4448				BPF_ALU64_IMM(BPF_ADD, R0, -2147483647),
  4449				BPF_EXIT_INSN(),
  4450			},
  4451			INTERNAL,
  4452			{ },
  4453			{ { 0, -1 } },
  4454		},
  4455		{
  4456			"ALU64_ADD_K: 1 + 0 = 1",
  4457			.u.insns_int = {
  4458				BPF_LD_IMM64(R2, 0x1),
  4459				BPF_LD_IMM64(R3, 0x1),
  4460				BPF_ALU64_IMM(BPF_ADD, R2, 0x0),
  4461				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  4462				BPF_MOV32_IMM(R0, 2),
  4463				BPF_EXIT_INSN(),
  4464				BPF_MOV32_IMM(R0, 1),
  4465				BPF_EXIT_INSN(),
  4466			},
  4467			INTERNAL,
  4468			{ },
  4469			{ { 0, 0x1 } },
  4470		},
  4471		{
  4472			"ALU64_ADD_K: 0 + (-1) = 0xffffffffffffffff",
  4473			.u.insns_int = {
  4474				BPF_LD_IMM64(R2, 0x0),
  4475				BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
  4476				BPF_ALU64_IMM(BPF_ADD, R2, 0xffffffff),
  4477				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  4478				BPF_MOV32_IMM(R0, 2),
  4479				BPF_EXIT_INSN(),
  4480				BPF_MOV32_IMM(R0, 1),
  4481				BPF_EXIT_INSN(),
  4482			},
  4483			INTERNAL,
  4484			{ },
  4485			{ { 0, 0x1 } },
  4486		},
  4487		{
  4488			"ALU64_ADD_K: 0 + 0xffff = 0xffff",
  4489			.u.insns_int = {
  4490				BPF_LD_IMM64(R2, 0x0),
  4491				BPF_LD_IMM64(R3, 0xffff),
  4492				BPF_ALU64_IMM(BPF_ADD, R2, 0xffff),
  4493				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  4494				BPF_MOV32_IMM(R0, 2),
  4495				BPF_EXIT_INSN(),
  4496				BPF_MOV32_IMM(R0, 1),
  4497				BPF_EXIT_INSN(),
  4498			},
  4499			INTERNAL,
  4500			{ },
  4501			{ { 0, 0x1 } },
  4502		},
  4503		{
  4504			"ALU64_ADD_K: 0 + 0x7fffffff = 0x7fffffff",
  4505			.u.insns_int = {
  4506				BPF_LD_IMM64(R2, 0x0),
  4507				BPF_LD_IMM64(R3, 0x7fffffff),
  4508				BPF_ALU64_IMM(BPF_ADD, R2, 0x7fffffff),
  4509				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  4510				BPF_MOV32_IMM(R0, 2),
  4511				BPF_EXIT_INSN(),
  4512				BPF_MOV32_IMM(R0, 1),
  4513				BPF_EXIT_INSN(),
  4514			},
  4515			INTERNAL,
  4516			{ },
  4517			{ { 0, 0x1 } },
  4518		},
  4519		{
  4520			"ALU64_ADD_K: 0 + 0x80000000 = 0xffffffff80000000",
  4521			.u.insns_int = {
  4522				BPF_LD_IMM64(R2, 0x0),
  4523				BPF_LD_IMM64(R3, 0xffffffff80000000LL),
  4524				BPF_ALU64_IMM(BPF_ADD, R2, 0x80000000),
  4525				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  4526				BPF_MOV32_IMM(R0, 2),
  4527				BPF_EXIT_INSN(),
  4528				BPF_MOV32_IMM(R0, 1),
  4529				BPF_EXIT_INSN(),
  4530			},
  4531			INTERNAL,
  4532			{ },
  4533			{ { 0, 0x1 } },
  4534		},
  4535		{
  4536			"ALU_ADD_K: 0 + 0x80008000 = 0xffffffff80008000",
  4537			.u.insns_int = {
  4538				BPF_LD_IMM64(R2, 0x0),
  4539				BPF_LD_IMM64(R3, 0xffffffff80008000LL),
  4540				BPF_ALU64_IMM(BPF_ADD, R2, 0x80008000),
  4541				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  4542				BPF_MOV32_IMM(R0, 2),
  4543				BPF_EXIT_INSN(),
  4544				BPF_MOV32_IMM(R0, 1),
  4545				BPF_EXIT_INSN(),
  4546			},
  4547			INTERNAL,
  4548			{ },
  4549			{ { 0, 0x1 } },
  4550		},
  4551		/* BPF_ALU | BPF_SUB | BPF_X */
  4552		{
  4553			"ALU_SUB_X: 3 - 1 = 2",
  4554			.u.insns_int = {
  4555				BPF_LD_IMM64(R0, 3),
  4556				BPF_ALU32_IMM(BPF_MOV, R1, 1),
  4557				BPF_ALU32_REG(BPF_SUB, R0, R1),
  4558				BPF_EXIT_INSN(),
  4559			},
  4560			INTERNAL,
  4561			{ },
  4562			{ { 0, 2 } },
  4563		},
  4564		{
  4565			"ALU_SUB_X: 4294967295 - 4294967294 = 1",
  4566			.u.insns_int = {
  4567				BPF_LD_IMM64(R0, 4294967295U),
  4568				BPF_ALU32_IMM(BPF_MOV, R1, 4294967294U),
  4569				BPF_ALU32_REG(BPF_SUB, R0, R1),
  4570				BPF_EXIT_INSN(),
  4571			},
  4572			INTERNAL,
  4573			{ },
  4574			{ { 0, 1 } },
  4575		},
  4576		{
  4577			"ALU64_SUB_X: 3 - 1 = 2",
  4578			.u.insns_int = {
  4579				BPF_LD_IMM64(R0, 3),
  4580				BPF_ALU32_IMM(BPF_MOV, R1, 1),
  4581				BPF_ALU64_REG(BPF_SUB, R0, R1),
  4582				BPF_EXIT_INSN(),
  4583			},
  4584			INTERNAL,
  4585			{ },
  4586			{ { 0, 2 } },
  4587		},
  4588		{
  4589			"ALU64_SUB_X: 4294967295 - 4294967294 = 1",
  4590			.u.insns_int = {
  4591				BPF_LD_IMM64(R0, 4294967295U),
  4592				BPF_ALU32_IMM(BPF_MOV, R1, 4294967294U),
  4593				BPF_ALU64_REG(BPF_SUB, R0, R1),
  4594				BPF_EXIT_INSN(),
  4595			},
  4596			INTERNAL,
  4597			{ },
  4598			{ { 0, 1 } },
  4599		},
  4600		/* BPF_ALU | BPF_SUB | BPF_K */
  4601		{
  4602			"ALU_SUB_K: 3 - 1 = 2",
  4603			.u.insns_int = {
  4604				BPF_LD_IMM64(R0, 3),
  4605				BPF_ALU32_IMM(BPF_SUB, R0, 1),
  4606				BPF_EXIT_INSN(),
  4607			},
  4608			INTERNAL,
  4609			{ },
  4610			{ { 0, 2 } },
  4611		},
  4612		{
  4613			"ALU_SUB_K: 3 - 0 = 3",
  4614			.u.insns_int = {
  4615				BPF_LD_IMM64(R0, 3),
  4616				BPF_ALU32_IMM(BPF_SUB, R0, 0),
  4617				BPF_EXIT_INSN(),
  4618			},
  4619			INTERNAL,
  4620			{ },
  4621			{ { 0, 3 } },
  4622		},
  4623		{
  4624			"ALU_SUB_K: 4294967295 - 4294967294 = 1",
  4625			.u.insns_int = {
  4626				BPF_LD_IMM64(R0, 4294967295U),
  4627				BPF_ALU32_IMM(BPF_SUB, R0, 4294967294U),
  4628				BPF_EXIT_INSN(),
  4629			},
  4630			INTERNAL,
  4631			{ },
  4632			{ { 0, 1 } },
  4633		},
  4634		{
  4635			"ALU64_SUB_K: 3 - 1 = 2",
  4636			.u.insns_int = {
  4637				BPF_LD_IMM64(R0, 3),
  4638				BPF_ALU64_IMM(BPF_SUB, R0, 1),
  4639				BPF_EXIT_INSN(),
  4640			},
  4641			INTERNAL,
  4642			{ },
  4643			{ { 0, 2 } },
  4644		},
  4645		{
  4646			"ALU64_SUB_K: 3 - 0 = 3",
  4647			.u.insns_int = {
  4648				BPF_LD_IMM64(R0, 3),
  4649				BPF_ALU64_IMM(BPF_SUB, R0, 0),
  4650				BPF_EXIT_INSN(),
  4651			},
  4652			INTERNAL,
  4653			{ },
  4654			{ { 0, 3 } },
  4655		},
  4656		{
  4657			"ALU64_SUB_K: 4294967294 - 4294967295 = -1",
  4658			.u.insns_int = {
  4659				BPF_LD_IMM64(R0, 4294967294U),
  4660				BPF_ALU64_IMM(BPF_SUB, R0, 4294967295U),
  4661				BPF_EXIT_INSN(),
  4662			},
  4663			INTERNAL,
  4664			{ },
  4665			{ { 0, -1 } },
  4666		},
  4667		{
  4668			"ALU64_ADD_K: 2147483646 - 2147483647 = -1",
  4669			.u.insns_int = {
  4670				BPF_LD_IMM64(R0, 2147483646),
  4671				BPF_ALU64_IMM(BPF_SUB, R0, 2147483647),
  4672				BPF_EXIT_INSN(),
  4673			},
  4674			INTERNAL,
  4675			{ },
  4676			{ { 0, -1 } },
  4677		},
  4678		/* BPF_ALU | BPF_MUL | BPF_X */
  4679		{
  4680			"ALU_MUL_X: 2 * 3 = 6",
  4681			.u.insns_int = {
  4682				BPF_LD_IMM64(R0, 2),
  4683				BPF_ALU32_IMM(BPF_MOV, R1, 3),
  4684				BPF_ALU32_REG(BPF_MUL, R0, R1),
  4685				BPF_EXIT_INSN(),
  4686			},
  4687			INTERNAL,
  4688			{ },
  4689			{ { 0, 6 } },
  4690		},
  4691		{
  4692			"ALU_MUL_X: 2 * 0x7FFFFFF8 = 0xFFFFFFF0",
  4693			.u.insns_int = {
  4694				BPF_LD_IMM64(R0, 2),
  4695				BPF_ALU32_IMM(BPF_MOV, R1, 0x7FFFFFF8),
  4696				BPF_ALU32_REG(BPF_MUL, R0, R1),
  4697				BPF_EXIT_INSN(),
  4698			},
  4699			INTERNAL,
  4700			{ },
  4701			{ { 0, 0xFFFFFFF0 } },
  4702		},
  4703		{
  4704			"ALU_MUL_X: -1 * -1 = 1",
  4705			.u.insns_int = {
  4706				BPF_LD_IMM64(R0, -1),
  4707				BPF_ALU32_IMM(BPF_MOV, R1, -1),
  4708				BPF_ALU32_REG(BPF_MUL, R0, R1),
  4709				BPF_EXIT_INSN(),
  4710			},
  4711			INTERNAL,
  4712			{ },
  4713			{ { 0, 1 } },
  4714		},
  4715		{
  4716			"ALU64_MUL_X: 2 * 3 = 6",
  4717			.u.insns_int = {
  4718				BPF_LD_IMM64(R0, 2),
  4719				BPF_ALU32_IMM(BPF_MOV, R1, 3),
  4720				BPF_ALU64_REG(BPF_MUL, R0, R1),
  4721				BPF_EXIT_INSN(),
  4722			},
  4723			INTERNAL,
  4724			{ },
  4725			{ { 0, 6 } },
  4726		},
  4727		{
  4728			"ALU64_MUL_X: 1 * 2147483647 = 2147483647",
  4729			.u.insns_int = {
  4730				BPF_LD_IMM64(R0, 1),
  4731				BPF_ALU32_IMM(BPF_MOV, R1, 2147483647),
  4732				BPF_ALU64_REG(BPF_MUL, R0, R1),
  4733				BPF_EXIT_INSN(),
  4734			},
  4735			INTERNAL,
  4736			{ },
  4737			{ { 0, 2147483647 } },
  4738		},
  4739		{
  4740			"ALU64_MUL_X: 64x64 multiply, low word",
  4741			.u.insns_int = {
  4742				BPF_LD_IMM64(R0, 0x0fedcba987654321LL),
  4743				BPF_LD_IMM64(R1, 0x123456789abcdef0LL),
  4744				BPF_ALU64_REG(BPF_MUL, R0, R1),
  4745				BPF_EXIT_INSN(),
  4746			},
  4747			INTERNAL,
  4748			{ },
  4749			{ { 0, 0xe5618cf0 } }
  4750		},
  4751		{
  4752			"ALU64_MUL_X: 64x64 multiply, high word",
  4753			.u.insns_int = {
  4754				BPF_LD_IMM64(R0, 0x0fedcba987654321LL),
  4755				BPF_LD_IMM64(R1, 0x123456789abcdef0LL),
  4756				BPF_ALU64_REG(BPF_MUL, R0, R1),
  4757				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4758				BPF_EXIT_INSN(),
  4759			},
  4760			INTERNAL,
  4761			{ },
  4762			{ { 0, 0x2236d88f } }
  4763		},
  4764		/* BPF_ALU | BPF_MUL | BPF_K */
  4765		{
  4766			"ALU_MUL_K: 2 * 3 = 6",
  4767			.u.insns_int = {
  4768				BPF_LD_IMM64(R0, 2),
  4769				BPF_ALU32_IMM(BPF_MUL, R0, 3),
  4770				BPF_EXIT_INSN(),
  4771			},
  4772			INTERNAL,
  4773			{ },
  4774			{ { 0, 6 } },
  4775		},
  4776		{
  4777			"ALU_MUL_K: 3 * 1 = 3",
  4778			.u.insns_int = {
  4779				BPF_LD_IMM64(R0, 3),
  4780				BPF_ALU32_IMM(BPF_MUL, R0, 1),
  4781				BPF_EXIT_INSN(),
  4782			},
  4783			INTERNAL,
  4784			{ },
  4785			{ { 0, 3 } },
  4786		},
  4787		{
  4788			"ALU_MUL_K: 2 * 0x7FFFFFF8 = 0xFFFFFFF0",
  4789			.u.insns_int = {
  4790				BPF_LD_IMM64(R0, 2),
  4791				BPF_ALU32_IMM(BPF_MUL, R0, 0x7FFFFFF8),
  4792				BPF_EXIT_INSN(),
  4793			},
  4794			INTERNAL,
  4795			{ },
  4796			{ { 0, 0xFFFFFFF0 } },
  4797		},
  4798		{
  4799			"ALU_MUL_K: 1 * (-1) = 0x00000000ffffffff",
  4800			.u.insns_int = {
  4801				BPF_LD_IMM64(R2, 0x1),
  4802				BPF_LD_IMM64(R3, 0x00000000ffffffff),
  4803				BPF_ALU32_IMM(BPF_MUL, R2, 0xffffffff),
  4804				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  4805				BPF_MOV32_IMM(R0, 2),
  4806				BPF_EXIT_INSN(),
  4807				BPF_MOV32_IMM(R0, 1),
  4808				BPF_EXIT_INSN(),
  4809			},
  4810			INTERNAL,
  4811			{ },
  4812			{ { 0, 0x1 } },
  4813		},
  4814		{
  4815			"ALU64_MUL_K: 2 * 3 = 6",
  4816			.u.insns_int = {
  4817				BPF_LD_IMM64(R0, 2),
  4818				BPF_ALU64_IMM(BPF_MUL, R0, 3),
  4819				BPF_EXIT_INSN(),
  4820			},
  4821			INTERNAL,
  4822			{ },
  4823			{ { 0, 6 } },
  4824		},
  4825		{
  4826			"ALU64_MUL_K: 3 * 1 = 3",
  4827			.u.insns_int = {
  4828				BPF_LD_IMM64(R0, 3),
  4829				BPF_ALU64_IMM(BPF_MUL, R0, 1),
  4830				BPF_EXIT_INSN(),
  4831			},
  4832			INTERNAL,
  4833			{ },
  4834			{ { 0, 3 } },
  4835		},
  4836		{
  4837			"ALU64_MUL_K: 1 * 2147483647 = 2147483647",
  4838			.u.insns_int = {
  4839				BPF_LD_IMM64(R0, 1),
  4840				BPF_ALU64_IMM(BPF_MUL, R0, 2147483647),
  4841				BPF_EXIT_INSN(),
  4842			},
  4843			INTERNAL,
  4844			{ },
  4845			{ { 0, 2147483647 } },
  4846		},
  4847		{
  4848			"ALU64_MUL_K: 1 * -2147483647 = -2147483647",
  4849			.u.insns_int = {
  4850				BPF_LD_IMM64(R0, 1),
  4851				BPF_ALU64_IMM(BPF_MUL, R0, -2147483647),
  4852				BPF_EXIT_INSN(),
  4853			},
  4854			INTERNAL,
  4855			{ },
  4856			{ { 0, -2147483647 } },
  4857		},
  4858		{
  4859			"ALU64_MUL_K: 1 * (-1) = 0xffffffffffffffff",
  4860			.u.insns_int = {
  4861				BPF_LD_IMM64(R2, 0x1),
  4862				BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
  4863				BPF_ALU64_IMM(BPF_MUL, R2, 0xffffffff),
  4864				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  4865				BPF_MOV32_IMM(R0, 2),
  4866				BPF_EXIT_INSN(),
  4867				BPF_MOV32_IMM(R0, 1),
  4868				BPF_EXIT_INSN(),
  4869			},
  4870			INTERNAL,
  4871			{ },
  4872			{ { 0, 0x1 } },
  4873		},
  4874		{
  4875			"ALU64_MUL_K: 64x32 multiply, low word",
  4876			.u.insns_int = {
  4877				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  4878				BPF_ALU64_IMM(BPF_MUL, R0, 0x12345678),
  4879				BPF_EXIT_INSN(),
  4880			},
  4881			INTERNAL,
  4882			{ },
  4883			{ { 0, 0xe242d208 } }
  4884		},
  4885		{
  4886			"ALU64_MUL_K: 64x32 multiply, high word",
  4887			.u.insns_int = {
  4888				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  4889				BPF_ALU64_IMM(BPF_MUL, R0, 0x12345678),
  4890				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4891				BPF_EXIT_INSN(),
  4892			},
  4893			INTERNAL,
  4894			{ },
  4895			{ { 0, 0xc28f5c28 } }
  4896		},
  4897		/* BPF_ALU | BPF_DIV | BPF_X */
  4898		{
  4899			"ALU_DIV_X: 6 / 2 = 3",
  4900			.u.insns_int = {
  4901				BPF_LD_IMM64(R0, 6),
  4902				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  4903				BPF_ALU32_REG(BPF_DIV, R0, R1),
  4904				BPF_EXIT_INSN(),
  4905			},
  4906			INTERNAL,
  4907			{ },
  4908			{ { 0, 3 } },
  4909		},
  4910		{
  4911			"ALU_DIV_X: 4294967295 / 4294967295 = 1",
  4912			.u.insns_int = {
  4913				BPF_LD_IMM64(R0, 4294967295U),
  4914				BPF_ALU32_IMM(BPF_MOV, R1, 4294967295U),
  4915				BPF_ALU32_REG(BPF_DIV, R0, R1),
  4916				BPF_EXIT_INSN(),
  4917			},
  4918			INTERNAL,
  4919			{ },
  4920			{ { 0, 1 } },
  4921		},
  4922		{
  4923			"ALU64_DIV_X: 6 / 2 = 3",
  4924			.u.insns_int = {
  4925				BPF_LD_IMM64(R0, 6),
  4926				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  4927				BPF_ALU64_REG(BPF_DIV, R0, R1),
  4928				BPF_EXIT_INSN(),
  4929			},
  4930			INTERNAL,
  4931			{ },
  4932			{ { 0, 3 } },
  4933		},
  4934		{
  4935			"ALU64_DIV_X: 2147483647 / 2147483647 = 1",
  4936			.u.insns_int = {
  4937				BPF_LD_IMM64(R0, 2147483647),
  4938				BPF_ALU32_IMM(BPF_MOV, R1, 2147483647),
  4939				BPF_ALU64_REG(BPF_DIV, R0, R1),
  4940				BPF_EXIT_INSN(),
  4941			},
  4942			INTERNAL,
  4943			{ },
  4944			{ { 0, 1 } },
  4945		},
  4946		{
  4947			"ALU64_DIV_X: 0xffffffffffffffff / (-1) = 0x0000000000000001",
  4948			.u.insns_int = {
  4949				BPF_LD_IMM64(R2, 0xffffffffffffffffLL),
  4950				BPF_LD_IMM64(R4, 0xffffffffffffffffLL),
  4951				BPF_LD_IMM64(R3, 0x0000000000000001LL),
  4952				BPF_ALU64_REG(BPF_DIV, R2, R4),
  4953				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  4954				BPF_MOV32_IMM(R0, 2),
  4955				BPF_EXIT_INSN(),
  4956				BPF_MOV32_IMM(R0, 1),
  4957				BPF_EXIT_INSN(),
  4958			},
  4959			INTERNAL,
  4960			{ },
  4961			{ { 0, 0x1 } },
  4962		},
  4963		/* BPF_ALU | BPF_DIV | BPF_K */
  4964		{
  4965			"ALU_DIV_K: 6 / 2 = 3",
  4966			.u.insns_int = {
  4967				BPF_LD_IMM64(R0, 6),
  4968				BPF_ALU32_IMM(BPF_DIV, R0, 2),
  4969				BPF_EXIT_INSN(),
  4970			},
  4971			INTERNAL,
  4972			{ },
  4973			{ { 0, 3 } },
  4974		},
  4975		{
  4976			"ALU_DIV_K: 3 / 1 = 3",
  4977			.u.insns_int = {
  4978				BPF_LD_IMM64(R0, 3),
  4979				BPF_ALU32_IMM(BPF_DIV, R0, 1),
  4980				BPF_EXIT_INSN(),
  4981			},
  4982			INTERNAL,
  4983			{ },
  4984			{ { 0, 3 } },
  4985		},
  4986		{
  4987			"ALU_DIV_K: 4294967295 / 4294967295 = 1",
  4988			.u.insns_int = {
  4989				BPF_LD_IMM64(R0, 4294967295U),
  4990				BPF_ALU32_IMM(BPF_DIV, R0, 4294967295U),
  4991				BPF_EXIT_INSN(),
  4992			},
  4993			INTERNAL,
  4994			{ },
  4995			{ { 0, 1 } },
  4996		},
  4997		{
  4998			"ALU_DIV_K: 0xffffffffffffffff / (-1) = 0x1",
  4999			.u.insns_int = {
  5000				BPF_LD_IMM64(R2, 0xffffffffffffffffLL),
  5001				BPF_LD_IMM64(R3, 0x1UL),
  5002				BPF_ALU32_IMM(BPF_DIV, R2, 0xffffffff),
  5003				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5004				BPF_MOV32_IMM(R0, 2),
  5005				BPF_EXIT_INSN(),
  5006				BPF_MOV32_IMM(R0, 1),
  5007				BPF_EXIT_INSN(),
  5008			},
  5009			INTERNAL,
  5010			{ },
  5011			{ { 0, 0x1 } },
  5012		},
  5013		{
  5014			"ALU64_DIV_K: 6 / 2 = 3",
  5015			.u.insns_int = {
  5016				BPF_LD_IMM64(R0, 6),
  5017				BPF_ALU64_IMM(BPF_DIV, R0, 2),
  5018				BPF_EXIT_INSN(),
  5019			},
  5020			INTERNAL,
  5021			{ },
  5022			{ { 0, 3 } },
  5023		},
  5024		{
  5025			"ALU64_DIV_K: 3 / 1 = 3",
  5026			.u.insns_int = {
  5027				BPF_LD_IMM64(R0, 3),
  5028				BPF_ALU64_IMM(BPF_DIV, R0, 1),
  5029				BPF_EXIT_INSN(),
  5030			},
  5031			INTERNAL,
  5032			{ },
  5033			{ { 0, 3 } },
  5034		},
  5035		{
  5036			"ALU64_DIV_K: 2147483647 / 2147483647 = 1",
  5037			.u.insns_int = {
  5038				BPF_LD_IMM64(R0, 2147483647),
  5039				BPF_ALU64_IMM(BPF_DIV, R0, 2147483647),
  5040				BPF_EXIT_INSN(),
  5041			},
  5042			INTERNAL,
  5043			{ },
  5044			{ { 0, 1 } },
  5045		},
  5046		{
  5047			"ALU64_DIV_K: 0xffffffffffffffff / (-1) = 0x0000000000000001",
  5048			.u.insns_int = {
  5049				BPF_LD_IMM64(R2, 0xffffffffffffffffLL),
  5050				BPF_LD_IMM64(R3, 0x0000000000000001LL),
  5051				BPF_ALU64_IMM(BPF_DIV, R2, 0xffffffff),
  5052				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5053				BPF_MOV32_IMM(R0, 2),
  5054				BPF_EXIT_INSN(),
  5055				BPF_MOV32_IMM(R0, 1),
  5056				BPF_EXIT_INSN(),
  5057			},
  5058			INTERNAL,
  5059			{ },
  5060			{ { 0, 0x1 } },
  5061		},
  5062		/* BPF_ALU | BPF_MOD | BPF_X */
  5063		{
  5064			"ALU_MOD_X: 3 % 2 = 1",
  5065			.u.insns_int = {
  5066				BPF_LD_IMM64(R0, 3),
  5067				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  5068				BPF_ALU32_REG(BPF_MOD, R0, R1),
  5069				BPF_EXIT_INSN(),
  5070			},
  5071			INTERNAL,
  5072			{ },
  5073			{ { 0, 1 } },
  5074		},
  5075		{
  5076			"ALU_MOD_X: 4294967295 % 4294967293 = 2",
  5077			.u.insns_int = {
  5078				BPF_LD_IMM64(R0, 4294967295U),
  5079				BPF_ALU32_IMM(BPF_MOV, R1, 4294967293U),
  5080				BPF_ALU32_REG(BPF_MOD, R0, R1),
  5081				BPF_EXIT_INSN(),
  5082			},
  5083			INTERNAL,
  5084			{ },
  5085			{ { 0, 2 } },
  5086		},
  5087		{
  5088			"ALU64_MOD_X: 3 % 2 = 1",
  5089			.u.insns_int = {
  5090				BPF_LD_IMM64(R0, 3),
  5091				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  5092				BPF_ALU64_REG(BPF_MOD, R0, R1),
  5093				BPF_EXIT_INSN(),
  5094			},
  5095			INTERNAL,
  5096			{ },
  5097			{ { 0, 1 } },
  5098		},
  5099		{
  5100			"ALU64_MOD_X: 2147483647 % 2147483645 = 2",
  5101			.u.insns_int = {
  5102				BPF_LD_IMM64(R0, 2147483647),
  5103				BPF_ALU32_IMM(BPF_MOV, R1, 2147483645),
  5104				BPF_ALU64_REG(BPF_MOD, R0, R1),
  5105				BPF_EXIT_INSN(),
  5106			},
  5107			INTERNAL,
  5108			{ },
  5109			{ { 0, 2 } },
  5110		},
  5111		/* BPF_ALU | BPF_MOD | BPF_K */
  5112		{
  5113			"ALU_MOD_K: 3 % 2 = 1",
  5114			.u.insns_int = {
  5115				BPF_LD_IMM64(R0, 3),
  5116				BPF_ALU32_IMM(BPF_MOD, R0, 2),
  5117				BPF_EXIT_INSN(),
  5118			},
  5119			INTERNAL,
  5120			{ },
  5121			{ { 0, 1 } },
  5122		},
  5123		{
  5124			"ALU_MOD_K: 3 % 1 = 0",
  5125			.u.insns_int = {
  5126				BPF_LD_IMM64(R0, 3),
  5127				BPF_ALU32_IMM(BPF_MOD, R0, 1),
  5128				BPF_EXIT_INSN(),
  5129			},
  5130			INTERNAL,
  5131			{ },
  5132			{ { 0, 0 } },
  5133		},
  5134		{
  5135			"ALU_MOD_K: 4294967295 % 4294967293 = 2",
  5136			.u.insns_int = {
  5137				BPF_LD_IMM64(R0, 4294967295U),
  5138				BPF_ALU32_IMM(BPF_MOD, R0, 4294967293U),
  5139				BPF_EXIT_INSN(),
  5140			},
  5141			INTERNAL,
  5142			{ },
  5143			{ { 0, 2 } },
  5144		},
  5145		{
  5146			"ALU64_MOD_K: 3 % 2 = 1",
  5147			.u.insns_int = {
  5148				BPF_LD_IMM64(R0, 3),
  5149				BPF_ALU64_IMM(BPF_MOD, R0, 2),
  5150				BPF_EXIT_INSN(),
  5151			},
  5152			INTERNAL,
  5153			{ },
  5154			{ { 0, 1 } },
  5155		},
  5156		{
  5157			"ALU64_MOD_K: 3 % 1 = 0",
  5158			.u.insns_int = {
  5159				BPF_LD_IMM64(R0, 3),
  5160				BPF_ALU64_IMM(BPF_MOD, R0, 1),
  5161				BPF_EXIT_INSN(),
  5162			},
  5163			INTERNAL,
  5164			{ },
  5165			{ { 0, 0 } },
  5166		},
  5167		{
  5168			"ALU64_MOD_K: 2147483647 % 2147483645 = 2",
  5169			.u.insns_int = {
  5170				BPF_LD_IMM64(R0, 2147483647),
  5171				BPF_ALU64_IMM(BPF_MOD, R0, 2147483645),
  5172				BPF_EXIT_INSN(),
  5173			},
  5174			INTERNAL,
  5175			{ },
  5176			{ { 0, 2 } },
  5177		},
  5178		/* BPF_ALU | BPF_AND | BPF_X */
  5179		{
  5180			"ALU_AND_X: 3 & 2 = 2",
  5181			.u.insns_int = {
  5182				BPF_LD_IMM64(R0, 3),
  5183				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  5184				BPF_ALU32_REG(BPF_AND, R0, R1),
  5185				BPF_EXIT_INSN(),
  5186			},
  5187			INTERNAL,
  5188			{ },
  5189			{ { 0, 2 } },
  5190		},
  5191		{
  5192			"ALU_AND_X: 0xffffffff & 0xffffffff = 0xffffffff",
  5193			.u.insns_int = {
  5194				BPF_LD_IMM64(R0, 0xffffffff),
  5195				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  5196				BPF_ALU32_REG(BPF_AND, R0, R1),
  5197				BPF_EXIT_INSN(),
  5198			},
  5199			INTERNAL,
  5200			{ },
  5201			{ { 0, 0xffffffff } },
  5202		},
  5203		{
  5204			"ALU64_AND_X: 3 & 2 = 2",
  5205			.u.insns_int = {
  5206				BPF_LD_IMM64(R0, 3),
  5207				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  5208				BPF_ALU64_REG(BPF_AND, R0, R1),
  5209				BPF_EXIT_INSN(),
  5210			},
  5211			INTERNAL,
  5212			{ },
  5213			{ { 0, 2 } },
  5214		},
  5215		{
  5216			"ALU64_AND_X: 0xffffffff & 0xffffffff = 0xffffffff",
  5217			.u.insns_int = {
  5218				BPF_LD_IMM64(R0, 0xffffffff),
  5219				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  5220				BPF_ALU64_REG(BPF_AND, R0, R1),
  5221				BPF_EXIT_INSN(),
  5222			},
  5223			INTERNAL,
  5224			{ },
  5225			{ { 0, 0xffffffff } },
  5226		},
  5227		/* BPF_ALU | BPF_AND | BPF_K */
  5228		{
  5229			"ALU_AND_K: 3 & 2 = 2",
  5230			.u.insns_int = {
  5231				BPF_LD_IMM64(R0, 3),
  5232				BPF_ALU32_IMM(BPF_AND, R0, 2),
  5233				BPF_EXIT_INSN(),
  5234			},
  5235			INTERNAL,
  5236			{ },
  5237			{ { 0, 2 } },
  5238		},
  5239		{
  5240			"ALU_AND_K: 0xffffffff & 0xffffffff = 0xffffffff",
  5241			.u.insns_int = {
  5242				BPF_LD_IMM64(R0, 0xffffffff),
  5243				BPF_ALU32_IMM(BPF_AND, R0, 0xffffffff),
  5244				BPF_EXIT_INSN(),
  5245			},
  5246			INTERNAL,
  5247			{ },
  5248			{ { 0, 0xffffffff } },
  5249		},
  5250		{
  5251			"ALU_AND_K: Small immediate",
  5252			.u.insns_int = {
  5253				BPF_ALU32_IMM(BPF_MOV, R0, 0x01020304),
  5254				BPF_ALU32_IMM(BPF_AND, R0, 15),
  5255				BPF_EXIT_INSN(),
  5256			},
  5257			INTERNAL,
  5258			{ },
  5259			{ { 0, 4 } }
  5260		},
  5261		{
  5262			"ALU_AND_K: Large immediate",
  5263			.u.insns_int = {
  5264				BPF_ALU32_IMM(BPF_MOV, R0, 0xf1f2f3f4),
  5265				BPF_ALU32_IMM(BPF_AND, R0, 0xafbfcfdf),
  5266				BPF_EXIT_INSN(),
  5267			},
  5268			INTERNAL,
  5269			{ },
  5270			{ { 0, 0xa1b2c3d4 } }
  5271		},
  5272		{
  5273			"ALU_AND_K: Zero extension",
  5274			.u.insns_int = {
  5275				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  5276				BPF_LD_IMM64(R1, 0x0000000080a0c0e0LL),
  5277				BPF_ALU32_IMM(BPF_AND, R0, 0xf0f0f0f0),
  5278				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  5279				BPF_MOV32_IMM(R0, 2),
  5280				BPF_EXIT_INSN(),
  5281				BPF_MOV32_IMM(R0, 1),
  5282				BPF_EXIT_INSN(),
  5283			},
  5284			INTERNAL,
  5285			{ },
  5286			{ { 0, 1 } }
  5287		},
  5288		{
  5289			"ALU64_AND_K: 3 & 2 = 2",
  5290			.u.insns_int = {
  5291				BPF_LD_IMM64(R0, 3),
  5292				BPF_ALU64_IMM(BPF_AND, R0, 2),
  5293				BPF_EXIT_INSN(),
  5294			},
  5295			INTERNAL,
  5296			{ },
  5297			{ { 0, 2 } },
  5298		},
  5299		{
  5300			"ALU64_AND_K: 0xffffffff & 0xffffffff = 0xffffffff",
  5301			.u.insns_int = {
  5302				BPF_LD_IMM64(R0, 0xffffffff),
  5303				BPF_ALU64_IMM(BPF_AND, R0, 0xffffffff),
  5304				BPF_EXIT_INSN(),
  5305			},
  5306			INTERNAL,
  5307			{ },
  5308			{ { 0, 0xffffffff } },
  5309		},
  5310		{
  5311			"ALU64_AND_K: 0x0000ffffffff0000 & 0x0 = 0x0000000000000000",
  5312			.u.insns_int = {
  5313				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  5314				BPF_LD_IMM64(R3, 0x0000000000000000LL),
  5315				BPF_ALU64_IMM(BPF_AND, R2, 0x0),
  5316				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5317				BPF_MOV32_IMM(R0, 2),
  5318				BPF_EXIT_INSN(),
  5319				BPF_MOV32_IMM(R0, 1),
  5320				BPF_EXIT_INSN(),
  5321			},
  5322			INTERNAL,
  5323			{ },
  5324			{ { 0, 0x1 } },
  5325		},
  5326		{
  5327			"ALU64_AND_K: 0x0000ffffffff0000 & -1 = 0x0000ffffffff0000",
  5328			.u.insns_int = {
  5329				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  5330				BPF_LD_IMM64(R3, 0x0000ffffffff0000LL),
  5331				BPF_ALU64_IMM(BPF_AND, R2, 0xffffffff),
  5332				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5333				BPF_MOV32_IMM(R0, 2),
  5334				BPF_EXIT_INSN(),
  5335				BPF_MOV32_IMM(R0, 1),
  5336				BPF_EXIT_INSN(),
  5337			},
  5338			INTERNAL,
  5339			{ },
  5340			{ { 0, 0x1 } },
  5341		},
  5342		{
  5343			"ALU64_AND_K: 0xffffffffffffffff & -1 = 0xffffffffffffffff",
  5344			.u.insns_int = {
  5345				BPF_LD_IMM64(R2, 0xffffffffffffffffLL),
  5346				BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
  5347				BPF_ALU64_IMM(BPF_AND, R2, 0xffffffff),
  5348				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5349				BPF_MOV32_IMM(R0, 2),
  5350				BPF_EXIT_INSN(),
  5351				BPF_MOV32_IMM(R0, 1),
  5352				BPF_EXIT_INSN(),
  5353			},
  5354			INTERNAL,
  5355			{ },
  5356			{ { 0, 0x1 } },
  5357		},
  5358		{
  5359			"ALU64_AND_K: Sign extension 1",
  5360			.u.insns_int = {
  5361				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  5362				BPF_LD_IMM64(R1, 0x00000000090b0d0fLL),
  5363				BPF_ALU64_IMM(BPF_AND, R0, 0x0f0f0f0f),
  5364				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  5365				BPF_MOV32_IMM(R0, 2),
  5366				BPF_EXIT_INSN(),
  5367				BPF_MOV32_IMM(R0, 1),
  5368				BPF_EXIT_INSN(),
  5369			},
  5370			INTERNAL,
  5371			{ },
  5372			{ { 0, 1 } }
  5373		},
  5374		{
  5375			"ALU64_AND_K: Sign extension 2",
  5376			.u.insns_int = {
  5377				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  5378				BPF_LD_IMM64(R1, 0x0123456780a0c0e0LL),
  5379				BPF_ALU64_IMM(BPF_AND, R0, 0xf0f0f0f0),
  5380				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  5381				BPF_MOV32_IMM(R0, 2),
  5382				BPF_EXIT_INSN(),
  5383				BPF_MOV32_IMM(R0, 1),
  5384				BPF_EXIT_INSN(),
  5385			},
  5386			INTERNAL,
  5387			{ },
  5388			{ { 0, 1 } }
  5389		},
  5390		/* BPF_ALU | BPF_OR | BPF_X */
  5391		{
  5392			"ALU_OR_X: 1 | 2 = 3",
  5393			.u.insns_int = {
  5394				BPF_LD_IMM64(R0, 1),
  5395				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  5396				BPF_ALU32_REG(BPF_OR, R0, R1),
  5397				BPF_EXIT_INSN(),
  5398			},
  5399			INTERNAL,
  5400			{ },
  5401			{ { 0, 3 } },
  5402		},
  5403		{
  5404			"ALU_OR_X: 0x0 | 0xffffffff = 0xffffffff",
  5405			.u.insns_int = {
  5406				BPF_LD_IMM64(R0, 0),
  5407				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  5408				BPF_ALU32_REG(BPF_OR, R0, R1),
  5409				BPF_EXIT_INSN(),
  5410			},
  5411			INTERNAL,
  5412			{ },
  5413			{ { 0, 0xffffffff } },
  5414		},
  5415		{
  5416			"ALU64_OR_X: 1 | 2 = 3",
  5417			.u.insns_int = {
  5418				BPF_LD_IMM64(R0, 1),
  5419				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  5420				BPF_ALU64_REG(BPF_OR, R0, R1),
  5421				BPF_EXIT_INSN(),
  5422			},
  5423			INTERNAL,
  5424			{ },
  5425			{ { 0, 3 } },
  5426		},
  5427		{
  5428			"ALU64_OR_X: 0 | 0xffffffff = 0xffffffff",
  5429			.u.insns_int = {
  5430				BPF_LD_IMM64(R0, 0),
  5431				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  5432				BPF_ALU64_REG(BPF_OR, R0, R1),
  5433				BPF_EXIT_INSN(),
  5434			},
  5435			INTERNAL,
  5436			{ },
  5437			{ { 0, 0xffffffff } },
  5438		},
  5439		/* BPF_ALU | BPF_OR | BPF_K */
  5440		{
  5441			"ALU_OR_K: 1 | 2 = 3",
  5442			.u.insns_int = {
  5443				BPF_LD_IMM64(R0, 1),
  5444				BPF_ALU32_IMM(BPF_OR, R0, 2),
  5445				BPF_EXIT_INSN(),
  5446			},
  5447			INTERNAL,
  5448			{ },
  5449			{ { 0, 3 } },
  5450		},
  5451		{
  5452			"ALU_OR_K: 0 & 0xffffffff = 0xffffffff",
  5453			.u.insns_int = {
  5454				BPF_LD_IMM64(R0, 0),
  5455				BPF_ALU32_IMM(BPF_OR, R0, 0xffffffff),
  5456				BPF_EXIT_INSN(),
  5457			},
  5458			INTERNAL,
  5459			{ },
  5460			{ { 0, 0xffffffff } },
  5461		},
  5462		{
  5463			"ALU_OR_K: Small immediate",
  5464			.u.insns_int = {
  5465				BPF_ALU32_IMM(BPF_MOV, R0, 0x01020304),
  5466				BPF_ALU32_IMM(BPF_OR, R0, 1),
  5467				BPF_EXIT_INSN(),
  5468			},
  5469			INTERNAL,
  5470			{ },
  5471			{ { 0, 0x01020305 } }
  5472		},
  5473		{
  5474			"ALU_OR_K: Large immediate",
  5475			.u.insns_int = {
  5476				BPF_ALU32_IMM(BPF_MOV, R0, 0x01020304),
  5477				BPF_ALU32_IMM(BPF_OR, R0, 0xa0b0c0d0),
  5478				BPF_EXIT_INSN(),
  5479			},
  5480			INTERNAL,
  5481			{ },
  5482			{ { 0, 0xa1b2c3d4 } }
  5483		},
  5484		{
  5485			"ALU_OR_K: Zero extension",
  5486			.u.insns_int = {
  5487				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  5488				BPF_LD_IMM64(R1, 0x00000000f9fbfdffLL),
  5489				BPF_ALU32_IMM(BPF_OR, R0, 0xf0f0f0f0),
  5490				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  5491				BPF_MOV32_IMM(R0, 2),
  5492				BPF_EXIT_INSN(),
  5493				BPF_MOV32_IMM(R0, 1),
  5494				BPF_EXIT_INSN(),
  5495			},
  5496			INTERNAL,
  5497			{ },
  5498			{ { 0, 1 } }
  5499		},
  5500		{
  5501			"ALU64_OR_K: 1 | 2 = 3",
  5502			.u.insns_int = {
  5503				BPF_LD_IMM64(R0, 1),
  5504				BPF_ALU64_IMM(BPF_OR, R0, 2),
  5505				BPF_EXIT_INSN(),
  5506			},
  5507			INTERNAL,
  5508			{ },
  5509			{ { 0, 3 } },
  5510		},
  5511		{
  5512			"ALU64_OR_K: 0 & 0xffffffff = 0xffffffff",
  5513			.u.insns_int = {
  5514				BPF_LD_IMM64(R0, 0),
  5515				BPF_ALU64_IMM(BPF_OR, R0, 0xffffffff),
  5516				BPF_EXIT_INSN(),
  5517			},
  5518			INTERNAL,
  5519			{ },
  5520			{ { 0, 0xffffffff } },
  5521		},
  5522		{
  5523			"ALU64_OR_K: 0x0000ffffffff0000 | 0x0 = 0x0000ffffffff0000",
  5524			.u.insns_int = {
  5525				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  5526				BPF_LD_IMM64(R3, 0x0000ffffffff0000LL),
  5527				BPF_ALU64_IMM(BPF_OR, R2, 0x0),
  5528				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5529				BPF_MOV32_IMM(R0, 2),
  5530				BPF_EXIT_INSN(),
  5531				BPF_MOV32_IMM(R0, 1),
  5532				BPF_EXIT_INSN(),
  5533			},
  5534			INTERNAL,
  5535			{ },
  5536			{ { 0, 0x1 } },
  5537		},
  5538		{
  5539			"ALU64_OR_K: 0x0000ffffffff0000 | -1 = 0xffffffffffffffff",
  5540			.u.insns_int = {
  5541				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  5542				BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
  5543				BPF_ALU64_IMM(BPF_OR, R2, 0xffffffff),
  5544				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5545				BPF_MOV32_IMM(R0, 2),
  5546				BPF_EXIT_INSN(),
  5547				BPF_MOV32_IMM(R0, 1),
  5548				BPF_EXIT_INSN(),
  5549			},
  5550			INTERNAL,
  5551			{ },
  5552			{ { 0, 0x1 } },
  5553		},
  5554		{
  5555			"ALU64_OR_K: 0x000000000000000 | -1 = 0xffffffffffffffff",
  5556			.u.insns_int = {
  5557				BPF_LD_IMM64(R2, 0x0000000000000000LL),
  5558				BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
  5559				BPF_ALU64_IMM(BPF_OR, R2, 0xffffffff),
  5560				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5561				BPF_MOV32_IMM(R0, 2),
  5562				BPF_EXIT_INSN(),
  5563				BPF_MOV32_IMM(R0, 1),
  5564				BPF_EXIT_INSN(),
  5565			},
  5566			INTERNAL,
  5567			{ },
  5568			{ { 0, 0x1 } },
  5569		},
  5570		{
  5571			"ALU64_OR_K: Sign extension 1",
  5572			.u.insns_int = {
  5573				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  5574				BPF_LD_IMM64(R1, 0x012345678fafcfefLL),
  5575				BPF_ALU64_IMM(BPF_OR, R0, 0x0f0f0f0f),
  5576				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  5577				BPF_MOV32_IMM(R0, 2),
  5578				BPF_EXIT_INSN(),
  5579				BPF_MOV32_IMM(R0, 1),
  5580				BPF_EXIT_INSN(),
  5581			},
  5582			INTERNAL,
  5583			{ },
  5584			{ { 0, 1 } }
  5585		},
  5586		{
  5587			"ALU64_OR_K: Sign extension 2",
  5588			.u.insns_int = {
  5589				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  5590				BPF_LD_IMM64(R1, 0xfffffffff9fbfdffLL),
  5591				BPF_ALU64_IMM(BPF_OR, R0, 0xf0f0f0f0),
  5592				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  5593				BPF_MOV32_IMM(R0, 2),
  5594				BPF_EXIT_INSN(),
  5595				BPF_MOV32_IMM(R0, 1),
  5596				BPF_EXIT_INSN(),
  5597			},
  5598			INTERNAL,
  5599			{ },
  5600			{ { 0, 1 } }
  5601		},
  5602		/* BPF_ALU | BPF_XOR | BPF_X */
  5603		{
  5604			"ALU_XOR_X: 5 ^ 6 = 3",
  5605			.u.insns_int = {
  5606				BPF_LD_IMM64(R0, 5),
  5607				BPF_ALU32_IMM(BPF_MOV, R1, 6),
  5608				BPF_ALU32_REG(BPF_XOR, R0, R1),
  5609				BPF_EXIT_INSN(),
  5610			},
  5611			INTERNAL,
  5612			{ },
  5613			{ { 0, 3 } },
  5614		},
  5615		{
  5616			"ALU_XOR_X: 0x1 ^ 0xffffffff = 0xfffffffe",
  5617			.u.insns_int = {
  5618				BPF_LD_IMM64(R0, 1),
  5619				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  5620				BPF_ALU32_REG(BPF_XOR, R0, R1),
  5621				BPF_EXIT_INSN(),
  5622			},
  5623			INTERNAL,
  5624			{ },
  5625			{ { 0, 0xfffffffe } },
  5626		},
  5627		{
  5628			"ALU64_XOR_X: 5 ^ 6 = 3",
  5629			.u.insns_int = {
  5630				BPF_LD_IMM64(R0, 5),
  5631				BPF_ALU32_IMM(BPF_MOV, R1, 6),
  5632				BPF_ALU64_REG(BPF_XOR, R0, R1),
  5633				BPF_EXIT_INSN(),
  5634			},
  5635			INTERNAL,
  5636			{ },
  5637			{ { 0, 3 } },
  5638		},
  5639		{
  5640			"ALU64_XOR_X: 1 ^ 0xffffffff = 0xfffffffe",
  5641			.u.insns_int = {
  5642				BPF_LD_IMM64(R0, 1),
  5643				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  5644				BPF_ALU64_REG(BPF_XOR, R0, R1),
  5645				BPF_EXIT_INSN(),
  5646			},
  5647			INTERNAL,
  5648			{ },
  5649			{ { 0, 0xfffffffe } },
  5650		},
  5651		/* BPF_ALU | BPF_XOR | BPF_K */
  5652		{
  5653			"ALU_XOR_K: 5 ^ 6 = 3",
  5654			.u.insns_int = {
  5655				BPF_LD_IMM64(R0, 5),
  5656				BPF_ALU32_IMM(BPF_XOR, R0, 6),
  5657				BPF_EXIT_INSN(),
  5658			},
  5659			INTERNAL,
  5660			{ },
  5661			{ { 0, 3 } },
  5662		},
  5663		{
  5664			"ALU_XOR_K: 1 ^ 0xffffffff = 0xfffffffe",
  5665			.u.insns_int = {
  5666				BPF_LD_IMM64(R0, 1),
  5667				BPF_ALU32_IMM(BPF_XOR, R0, 0xffffffff),
  5668				BPF_EXIT_INSN(),
  5669			},
  5670			INTERNAL,
  5671			{ },
  5672			{ { 0, 0xfffffffe } },
  5673		},
  5674		{
  5675			"ALU_XOR_K: Small immediate",
  5676			.u.insns_int = {
  5677				BPF_ALU32_IMM(BPF_MOV, R0, 0x01020304),
  5678				BPF_ALU32_IMM(BPF_XOR, R0, 15),
  5679				BPF_EXIT_INSN(),
  5680			},
  5681			INTERNAL,
  5682			{ },
  5683			{ { 0, 0x0102030b } }
  5684		},
  5685		{
  5686			"ALU_XOR_K: Large immediate",
  5687			.u.insns_int = {
  5688				BPF_ALU32_IMM(BPF_MOV, R0, 0xf1f2f3f4),
  5689				BPF_ALU32_IMM(BPF_XOR, R0, 0xafbfcfdf),
  5690				BPF_EXIT_INSN(),
  5691			},
  5692			INTERNAL,
  5693			{ },
  5694			{ { 0, 0x5e4d3c2b } }
  5695		},
  5696		{
  5697			"ALU_XOR_K: Zero extension",
  5698			.u.insns_int = {
  5699				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  5700				BPF_LD_IMM64(R1, 0x00000000795b3d1fLL),
  5701				BPF_ALU32_IMM(BPF_XOR, R0, 0xf0f0f0f0),
  5702				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  5703				BPF_MOV32_IMM(R0, 2),
  5704				BPF_EXIT_INSN(),
  5705				BPF_MOV32_IMM(R0, 1),
  5706				BPF_EXIT_INSN(),
  5707			},
  5708			INTERNAL,
  5709			{ },
  5710			{ { 0, 1 } }
  5711		},
  5712		{
  5713			"ALU64_XOR_K: 5 ^ 6 = 3",
  5714			.u.insns_int = {
  5715				BPF_LD_IMM64(R0, 5),
  5716				BPF_ALU64_IMM(BPF_XOR, R0, 6),
  5717				BPF_EXIT_INSN(),
  5718			},
  5719			INTERNAL,
  5720			{ },
  5721			{ { 0, 3 } },
  5722		},
  5723		{
  5724			"ALU64_XOR_K: 1 ^ 0xffffffff = 0xfffffffe",
  5725			.u.insns_int = {
  5726				BPF_LD_IMM64(R0, 1),
  5727				BPF_ALU64_IMM(BPF_XOR, R0, 0xffffffff),
  5728				BPF_EXIT_INSN(),
  5729			},
  5730			INTERNAL,
  5731			{ },
  5732			{ { 0, 0xfffffffe } },
  5733		},
  5734		{
  5735			"ALU64_XOR_K: 0x0000ffffffff0000 ^ 0x0 = 0x0000ffffffff0000",
  5736			.u.insns_int = {
  5737				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  5738				BPF_LD_IMM64(R3, 0x0000ffffffff0000LL),
  5739				BPF_ALU64_IMM(BPF_XOR, R2, 0x0),
  5740				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5741				BPF_MOV32_IMM(R0, 2),
  5742				BPF_EXIT_INSN(),
  5743				BPF_MOV32_IMM(R0, 1),
  5744				BPF_EXIT_INSN(),
  5745			},
  5746			INTERNAL,
  5747			{ },
  5748			{ { 0, 0x1 } },
  5749		},
  5750		{
  5751			"ALU64_XOR_K: 0x0000ffffffff0000 ^ -1 = 0xffff00000000ffff",
  5752			.u.insns_int = {
  5753				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  5754				BPF_LD_IMM64(R3, 0xffff00000000ffffLL),
  5755				BPF_ALU64_IMM(BPF_XOR, R2, 0xffffffff),
  5756				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5757				BPF_MOV32_IMM(R0, 2),
  5758				BPF_EXIT_INSN(),
  5759				BPF_MOV32_IMM(R0, 1),
  5760				BPF_EXIT_INSN(),
  5761			},
  5762			INTERNAL,
  5763			{ },
  5764			{ { 0, 0x1 } },
  5765		},
  5766		{
  5767			"ALU64_XOR_K: 0x000000000000000 ^ -1 = 0xffffffffffffffff",
  5768			.u.insns_int = {
  5769				BPF_LD_IMM64(R2, 0x0000000000000000LL),
  5770				BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
  5771				BPF_ALU64_IMM(BPF_XOR, R2, 0xffffffff),
  5772				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5773				BPF_MOV32_IMM(R0, 2),
  5774				BPF_EXIT_INSN(),
  5775				BPF_MOV32_IMM(R0, 1),
  5776				BPF_EXIT_INSN(),
  5777			},
  5778			INTERNAL,
  5779			{ },
  5780			{ { 0, 0x1 } },
  5781		},
  5782		{
  5783			"ALU64_XOR_K: Sign extension 1",
  5784			.u.insns_int = {
  5785				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  5786				BPF_LD_IMM64(R1, 0x0123456786a4c2e0LL),
  5787				BPF_ALU64_IMM(BPF_XOR, R0, 0x0f0f0f0f),
  5788				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  5789				BPF_MOV32_IMM(R0, 2),
  5790				BPF_EXIT_INSN(),
  5791				BPF_MOV32_IMM(R0, 1),
  5792				BPF_EXIT_INSN(),
  5793			},
  5794			INTERNAL,
  5795			{ },
  5796			{ { 0, 1 } }
  5797		},
  5798		{
  5799			"ALU64_XOR_K: Sign extension 2",
  5800			.u.insns_int = {
  5801				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  5802				BPF_LD_IMM64(R1, 0xfedcba98795b3d1fLL),
  5803				BPF_ALU64_IMM(BPF_XOR, R0, 0xf0f0f0f0),
  5804				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  5805				BPF_MOV32_IMM(R0, 2),
  5806				BPF_EXIT_INSN(),
  5807				BPF_MOV32_IMM(R0, 1),
  5808				BPF_EXIT_INSN(),
  5809			},
  5810			INTERNAL,
  5811			{ },
  5812			{ { 0, 1 } }
  5813		},
  5814		/* BPF_ALU | BPF_LSH | BPF_X */
  5815		{
  5816			"ALU_LSH_X: 1 << 1 = 2",
  5817			.u.insns_int = {
  5818				BPF_LD_IMM64(R0, 1),
  5819				BPF_ALU32_IMM(BPF_MOV, R1, 1),
  5820				BPF_ALU32_REG(BPF_LSH, R0, R1),
  5821				BPF_EXIT_INSN(),
  5822			},
  5823			INTERNAL,
  5824			{ },
  5825			{ { 0, 2 } },
  5826		},
  5827		{
  5828			"ALU_LSH_X: 1 << 31 = 0x80000000",
  5829			.u.insns_int = {
  5830				BPF_LD_IMM64(R0, 1),
  5831				BPF_ALU32_IMM(BPF_MOV, R1, 31),
  5832				BPF_ALU32_REG(BPF_LSH, R0, R1),
  5833				BPF_EXIT_INSN(),
  5834			},
  5835			INTERNAL,
  5836			{ },
  5837			{ { 0, 0x80000000 } },
  5838		},
  5839		{
  5840			"ALU_LSH_X: 0x12345678 << 12 = 0x45678000",
  5841			.u.insns_int = {
  5842				BPF_ALU32_IMM(BPF_MOV, R0, 0x12345678),
  5843				BPF_ALU32_IMM(BPF_MOV, R1, 12),
  5844				BPF_ALU32_REG(BPF_LSH, R0, R1),
  5845				BPF_EXIT_INSN(),
  5846			},
  5847			INTERNAL,
  5848			{ },
  5849			{ { 0, 0x45678000 } }
  5850		},
  5851		{
  5852			"ALU64_LSH_X: 1 << 1 = 2",
  5853			.u.insns_int = {
  5854				BPF_LD_IMM64(R0, 1),
  5855				BPF_ALU32_IMM(BPF_MOV, R1, 1),
  5856				BPF_ALU64_REG(BPF_LSH, R0, R1),
  5857				BPF_EXIT_INSN(),
  5858			},
  5859			INTERNAL,
  5860			{ },
  5861			{ { 0, 2 } },
  5862		},
  5863		{
  5864			"ALU64_LSH_X: 1 << 31 = 0x80000000",
  5865			.u.insns_int = {
  5866				BPF_LD_IMM64(R0, 1),
  5867				BPF_ALU32_IMM(BPF_MOV, R1, 31),
  5868				BPF_ALU64_REG(BPF_LSH, R0, R1),
  5869				BPF_EXIT_INSN(),
  5870			},
  5871			INTERNAL,
  5872			{ },
  5873			{ { 0, 0x80000000 } },
  5874		},
  5875		{
  5876			"ALU64_LSH_X: Shift < 32, low word",
  5877			.u.insns_int = {
  5878				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  5879				BPF_ALU32_IMM(BPF_MOV, R1, 12),
  5880				BPF_ALU64_REG(BPF_LSH, R0, R1),
  5881				BPF_EXIT_INSN(),
  5882			},
  5883			INTERNAL,
  5884			{ },
  5885			{ { 0, 0xbcdef000 } }
  5886		},
  5887		{
  5888			"ALU64_LSH_X: Shift < 32, high word",
  5889			.u.insns_int = {
  5890				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  5891				BPF_ALU32_IMM(BPF_MOV, R1, 12),
  5892				BPF_ALU64_REG(BPF_LSH, R0, R1),
  5893				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  5894				BPF_EXIT_INSN(),
  5895			},
  5896			INTERNAL,
  5897			{ },
  5898			{ { 0, 0x3456789a } }
  5899		},
  5900		{
  5901			"ALU64_LSH_X: Shift > 32, low word",
  5902			.u.insns_int = {
  5903				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  5904				BPF_ALU32_IMM(BPF_MOV, R1, 36),
  5905				BPF_ALU64_REG(BPF_LSH, R0, R1),
  5906				BPF_EXIT_INSN(),
  5907			},
  5908			INTERNAL,
  5909			{ },
  5910			{ { 0, 0 } }
  5911		},
  5912		{
  5913			"ALU64_LSH_X: Shift > 32, high word",
  5914			.u.insns_int = {
  5915				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  5916				BPF_ALU32_IMM(BPF_MOV, R1, 36),
  5917				BPF_ALU64_REG(BPF_LSH, R0, R1),
  5918				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  5919				BPF_EXIT_INSN(),
  5920			},
  5921			INTERNAL,
  5922			{ },
  5923			{ { 0, 0x9abcdef0 } }
  5924		},
  5925		{
  5926			"ALU64_LSH_X: Shift == 32, low word",
  5927			.u.insns_int = {
  5928				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  5929				BPF_ALU32_IMM(BPF_MOV, R1, 32),
  5930				BPF_ALU64_REG(BPF_LSH, R0, R1),
  5931				BPF_EXIT_INSN(),
  5932			},
  5933			INTERNAL,
  5934			{ },
  5935			{ { 0, 0 } }
  5936		},
  5937		{
  5938			"ALU64_LSH_X: Shift == 32, high word",
  5939			.u.insns_int = {
  5940				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  5941				BPF_ALU32_IMM(BPF_MOV, R1, 32),
  5942				BPF_ALU64_REG(BPF_LSH, R0, R1),
  5943				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  5944				BPF_EXIT_INSN(),
  5945			},
  5946			INTERNAL,
  5947			{ },
  5948			{ { 0, 0x89abcdef } }
  5949		},
  5950		{
  5951			"ALU64_LSH_X: Zero shift, low word",
  5952			.u.insns_int = {
  5953				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  5954				BPF_ALU32_IMM(BPF_MOV, R1, 0),
  5955				BPF_ALU64_REG(BPF_LSH, R0, R1),
  5956				BPF_EXIT_INSN(),
  5957			},
  5958			INTERNAL,
  5959			{ },
  5960			{ { 0, 0x89abcdef } }
  5961		},
  5962		{
  5963			"ALU64_LSH_X: Zero shift, high word",
  5964			.u.insns_int = {
  5965				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  5966				BPF_ALU32_IMM(BPF_MOV, R1, 0),
  5967				BPF_ALU64_REG(BPF_LSH, R0, R1),
  5968				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  5969				BPF_EXIT_INSN(),
  5970			},
  5971			INTERNAL,
  5972			{ },
  5973			{ { 0, 0x01234567 } }
  5974		},
  5975		/* BPF_ALU | BPF_LSH | BPF_K */
  5976		{
  5977			"ALU_LSH_K: 1 << 1 = 2",
  5978			.u.insns_int = {
  5979				BPF_LD_IMM64(R0, 1),
  5980				BPF_ALU32_IMM(BPF_LSH, R0, 1),
  5981				BPF_EXIT_INSN(),
  5982			},
  5983			INTERNAL,
  5984			{ },
  5985			{ { 0, 2 } },
  5986		},
  5987		{
  5988			"ALU_LSH_K: 1 << 31 = 0x80000000",
  5989			.u.insns_int = {
  5990				BPF_LD_IMM64(R0, 1),
  5991				BPF_ALU32_IMM(BPF_LSH, R0, 31),
  5992				BPF_EXIT_INSN(),
  5993			},
  5994			INTERNAL,
  5995			{ },
  5996			{ { 0, 0x80000000 } },
  5997		},
  5998		{
  5999			"ALU_LSH_K: 0x12345678 << 12 = 0x45678000",
  6000			.u.insns_int = {
  6001				BPF_ALU32_IMM(BPF_MOV, R0, 0x12345678),
  6002				BPF_ALU32_IMM(BPF_LSH, R0, 12),
  6003				BPF_EXIT_INSN(),
  6004			},
  6005			INTERNAL,
  6006			{ },
  6007			{ { 0, 0x45678000 } }
  6008		},
  6009		{
  6010			"ALU_LSH_K: 0x12345678 << 0 = 0x12345678",
  6011			.u.insns_int = {
  6012				BPF_ALU32_IMM(BPF_MOV, R0, 0x12345678),
  6013				BPF_ALU32_IMM(BPF_LSH, R0, 0),
  6014				BPF_EXIT_INSN(),
  6015			},
  6016			INTERNAL,
  6017			{ },
  6018			{ { 0, 0x12345678 } }
  6019		},
  6020		{
  6021			"ALU64_LSH_K: 1 << 1 = 2",
  6022			.u.insns_int = {
  6023				BPF_LD_IMM64(R0, 1),
  6024				BPF_ALU64_IMM(BPF_LSH, R0, 1),
  6025				BPF_EXIT_INSN(),
  6026			},
  6027			INTERNAL,
  6028			{ },
  6029			{ { 0, 2 } },
  6030		},
  6031		{
  6032			"ALU64_LSH_K: 1 << 31 = 0x80000000",
  6033			.u.insns_int = {
  6034				BPF_LD_IMM64(R0, 1),
  6035				BPF_ALU64_IMM(BPF_LSH, R0, 31),
  6036				BPF_EXIT_INSN(),
  6037			},
  6038			INTERNAL,
  6039			{ },
  6040			{ { 0, 0x80000000 } },
  6041		},
  6042		{
  6043			"ALU64_LSH_K: Shift < 32, low word",
  6044			.u.insns_int = {
  6045				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  6046				BPF_ALU64_IMM(BPF_LSH, R0, 12),
  6047				BPF_EXIT_INSN(),
  6048			},
  6049			INTERNAL,
  6050			{ },
  6051			{ { 0, 0xbcdef000 } }
  6052		},
  6053		{
  6054			"ALU64_LSH_K: Shift < 32, high word",
  6055			.u.insns_int = {
  6056				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  6057				BPF_ALU64_IMM(BPF_LSH, R0, 12),
  6058				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  6059				BPF_EXIT_INSN(),
  6060			},
  6061			INTERNAL,
  6062			{ },
  6063			{ { 0, 0x3456789a } }
  6064		},
  6065		{
  6066			"ALU64_LSH_K: Shift > 32, low word",
  6067			.u.insns_int = {
  6068				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  6069				BPF_ALU64_IMM(BPF_LSH, R0, 36),
  6070				BPF_EXIT_INSN(),
  6071			},
  6072			INTERNAL,
  6073			{ },
  6074			{ { 0, 0 } }
  6075		},
  6076		{
  6077			"ALU64_LSH_K: Shift > 32, high word",
  6078			.u.insns_int = {
  6079				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  6080				BPF_ALU64_IMM(BPF_LSH, R0, 36),
  6081				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  6082				BPF_EXIT_INSN(),
  6083			},
  6084			INTERNAL,
  6085			{ },
  6086			{ { 0, 0x9abcdef0 } }
  6087		},
  6088		{
  6089			"ALU64_LSH_K: Shift == 32, low word",
  6090			.u.insns_int = {
  6091				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  6092				BPF_ALU64_IMM(BPF_LSH, R0, 32),
  6093				BPF_EXIT_INSN(),
  6094			},
  6095			INTERNAL,
  6096			{ },
  6097			{ { 0, 0 } }
  6098		},
  6099		{
  6100			"ALU64_LSH_K: Shift == 32, high word",
  6101			.u.insns_int = {
  6102				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  6103				BPF_ALU64_IMM(BPF_LSH, R0, 32),
  6104				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  6105				BPF_EXIT_INSN(),
  6106			},
  6107			INTERNAL,
  6108			{ },
  6109			{ { 0, 0x89abcdef } }
  6110		},
  6111		{
  6112			"ALU64_LSH_K: Zero shift",
  6113			.u.insns_int = {
  6114				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  6115				BPF_ALU64_IMM(BPF_LSH, R0, 0),
  6116				BPF_EXIT_INSN(),
  6117			},
  6118			INTERNAL,
  6119			{ },
  6120			{ { 0, 0x89abcdef } }
  6121		},
  6122		/* BPF_ALU | BPF_RSH | BPF_X */
  6123		{
  6124			"ALU_RSH_X: 2 >> 1 = 1",
  6125			.u.insns_int = {
  6126				BPF_LD_IMM64(R0, 2),
  6127				BPF_ALU32_IMM(BPF_MOV, R1, 1),
  6128				BPF_ALU32_REG(BPF_RSH, R0, R1),
  6129				BPF_EXIT_INSN(),
  6130			},
  6131			INTERNAL,
  6132			{ },
  6133			{ { 0, 1 } },
  6134		},
  6135		{
  6136			"ALU_RSH_X: 0x80000000 >> 31 = 1",
  6137			.u.insns_int = {
  6138				BPF_LD_IMM64(R0, 0x80000000),
  6139				BPF_ALU32_IMM(BPF_MOV, R1, 31),
  6140				BPF_ALU32_REG(BPF_RSH, R0, R1),
  6141				BPF_EXIT_INSN(),
  6142			},
  6143			INTERNAL,
  6144			{ },
  6145			{ { 0, 1 } },
  6146		},
  6147		{
  6148			"ALU_RSH_X: 0x12345678 >> 20 = 0x123",
  6149			.u.insns_int = {
  6150				BPF_ALU32_IMM(BPF_MOV, R0, 0x12345678),
  6151				BPF_ALU32_IMM(BPF_MOV, R1, 20),
  6152				BPF_ALU32_REG(BPF_RSH, R0, R1),
  6153				BPF_EXIT_INSN(),
  6154			},
  6155			INTERNAL,
  6156			{ },
  6157			{ { 0, 0x123 } }
  6158		},
  6159		{
  6160			"ALU64_RSH_X: 2 >> 1 = 1",
  6161			.u.insns_int = {
  6162				BPF_LD_IMM64(R0, 2),
  6163				BPF_ALU32_IMM(BPF_MOV, R1, 1),
  6164				BPF_ALU64_REG(BPF_RSH, R0, R1),
  6165				BPF_EXIT_INSN(),
  6166			},
  6167			INTERNAL,
  6168			{ },
  6169			{ { 0, 1 } },
  6170		},
  6171		{
  6172			"ALU64_RSH_X: 0x80000000 >> 31 = 1",
  6173			.u.insns_int = {
  6174				BPF_LD_IMM64(R0, 0x80000000),
  6175				BPF_ALU32_IMM(BPF_MOV, R1, 31),
  6176				BPF_ALU64_REG(BPF_RSH, R0, R1),
  6177				BPF_EXIT_INSN(),
  6178			},
  6179			INTERNAL,
  6180			{ },
  6181			{ { 0, 1 } },
  6182		},
  6183		{
  6184			"ALU64_RSH_X: Shift < 32, low word",
  6185			.u.insns_int = {
  6186				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6187				BPF_ALU32_IMM(BPF_MOV, R1, 12),
  6188				BPF_ALU64_REG(BPF_RSH, R0, R1),
  6189				BPF_EXIT_INSN(),
  6190			},
  6191			INTERNAL,
  6192			{ },
  6193			{ { 0, 0x56789abc } }
  6194		},
  6195		{
  6196			"ALU64_RSH_X: Shift < 32, high word",
  6197			.u.insns_int = {
  6198				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6199				BPF_ALU32_IMM(BPF_MOV, R1, 12),
  6200				BPF_ALU64_REG(BPF_RSH, R0, R1),
  6201				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  6202				BPF_EXIT_INSN(),
  6203			},
  6204			INTERNAL,
  6205			{ },
  6206			{ { 0, 0x00081234 } }
  6207		},
  6208		{
  6209			"ALU64_RSH_X: Shift > 32, low word",
  6210			.u.insns_int = {
  6211				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6212				BPF_ALU32_IMM(BPF_MOV, R1, 36),
  6213				BPF_ALU64_REG(BPF_RSH, R0, R1),
  6214				BPF_EXIT_INSN(),
  6215			},
  6216			INTERNAL,
  6217			{ },
  6218			{ { 0, 0x08123456 } }
  6219		},
  6220		{
  6221			"ALU64_RSH_X: Shift > 32, high word",
  6222			.u.insns_int = {
  6223				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6224				BPF_ALU32_IMM(BPF_MOV, R1, 36),
  6225				BPF_ALU64_REG(BPF_RSH, R0, R1),
  6226				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  6227				BPF_EXIT_INSN(),
  6228			},
  6229			INTERNAL,
  6230			{ },
  6231			{ { 0, 0 } }
  6232		},
  6233		{
  6234			"ALU64_RSH_X: Shift == 32, low word",
  6235			.u.insns_int = {
  6236				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6237				BPF_ALU32_IMM(BPF_MOV, R1, 32),
  6238				BPF_ALU64_REG(BPF_RSH, R0, R1),
  6239				BPF_EXIT_INSN(),
  6240			},
  6241			INTERNAL,
  6242			{ },
  6243			{ { 0, 0x81234567 } }
  6244		},
  6245		{
  6246			"ALU64_RSH_X: Shift == 32, high word",
  6247			.u.insns_int = {
  6248				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6249				BPF_ALU32_IMM(BPF_MOV, R1, 32),
  6250				BPF_ALU64_REG(BPF_RSH, R0, R1),
  6251				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  6252				BPF_EXIT_INSN(),
  6253			},
  6254			INTERNAL,
  6255			{ },
  6256			{ { 0, 0 } }
  6257		},
  6258		{
  6259			"ALU64_RSH_X: Zero shift, low word",
  6260			.u.insns_int = {
  6261				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6262				BPF_ALU32_IMM(BPF_MOV, R1, 0),
  6263				BPF_ALU64_REG(BPF_RSH, R0, R1),
  6264				BPF_EXIT_INSN(),
  6265			},
  6266			INTERNAL,
  6267			{ },
  6268			{ { 0, 0x89abcdef } }
  6269		},
  6270		{
  6271			"ALU64_RSH_X: Zero shift, high word",
  6272			.u.insns_int = {
  6273				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6274				BPF_ALU32_IMM(BPF_MOV, R1, 0),
  6275				BPF_ALU64_REG(BPF_RSH, R0, R1),
  6276				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  6277				BPF_EXIT_INSN(),
  6278			},
  6279			INTERNAL,
  6280			{ },
  6281			{ { 0, 0x81234567 } }
  6282		},
  6283		/* BPF_ALU | BPF_RSH | BPF_K */
  6284		{
  6285			"ALU_RSH_K: 2 >> 1 = 1",
  6286			.u.insns_int = {
  6287				BPF_LD_IMM64(R0, 2),
  6288				BPF_ALU32_IMM(BPF_RSH, R0, 1),
  6289				BPF_EXIT_INSN(),
  6290			},
  6291			INTERNAL,
  6292			{ },
  6293			{ { 0, 1 } },
  6294		},
  6295		{
  6296			"ALU_RSH_K: 0x80000000 >> 31 = 1",
  6297			.u.insns_int = {
  6298				BPF_LD_IMM64(R0, 0x80000000),
  6299				BPF_ALU32_IMM(BPF_RSH, R0, 31),
  6300				BPF_EXIT_INSN(),
  6301			},
  6302			INTERNAL,
  6303			{ },
  6304			{ { 0, 1 } },
  6305		},
  6306		{
  6307			"ALU_RSH_K: 0x12345678 >> 20 = 0x123",
  6308			.u.insns_int = {
  6309				BPF_ALU32_IMM(BPF_MOV, R0, 0x12345678),
  6310				BPF_ALU32_IMM(BPF_RSH, R0, 20),
  6311				BPF_EXIT_INSN(),
  6312			},
  6313			INTERNAL,
  6314			{ },
  6315			{ { 0, 0x123 } }
  6316		},
  6317		{
  6318			"ALU_RSH_K: 0x12345678 >> 0 = 0x12345678",
  6319			.u.insns_int = {
  6320				BPF_ALU32_IMM(BPF_MOV, R0, 0x12345678),
  6321				BPF_ALU32_IMM(BPF_RSH, R0, 0),
  6322				BPF_EXIT_INSN(),
  6323			},
  6324			INTERNAL,
  6325			{ },
  6326			{ { 0, 0x12345678 } }
  6327		},
  6328		{
  6329			"ALU64_RSH_K: 2 >> 1 = 1",
  6330			.u.insns_int = {
  6331				BPF_LD_IMM64(R0, 2),
  6332				BPF_ALU64_IMM(BPF_RSH, R0, 1),
  6333				BPF_EXIT_INSN(),
  6334			},
  6335			INTERNAL,
  6336			{ },
  6337			{ { 0, 1 } },
  6338		},
  6339		{
  6340			"ALU64_RSH_K: 0x80000000 >> 31 = 1",
  6341			.u.insns_int = {
  6342				BPF_LD_IMM64(R0, 0x80000000),
  6343				BPF_ALU64_IMM(BPF_RSH, R0, 31),
  6344				BPF_EXIT_INSN(),
  6345			},
  6346			INTERNAL,
  6347			{ },
  6348			{ { 0, 1 } },
  6349		},
  6350		{
  6351			"ALU64_RSH_K: Shift < 32, low word",
  6352			.u.insns_int = {
  6353				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6354				BPF_ALU64_IMM(BPF_RSH, R0, 12),
  6355				BPF_EXIT_INSN(),
  6356			},
  6357			INTERNAL,
  6358			{ },
  6359			{ { 0, 0x56789abc } }
  6360		},
  6361		{
  6362			"ALU64_RSH_K: Shift < 32, high word",
  6363			.u.insns_int = {
  6364				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6365				BPF_ALU64_IMM(BPF_RSH, R0, 12),
  6366				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  6367				BPF_EXIT_INSN(),
  6368			},
  6369			INTERNAL,
  6370			{ },
  6371			{ { 0, 0x00081234 } }
  6372		},
  6373		{
  6374			"ALU64_RSH_K: Shift > 32, low word",
  6375			.u.insns_int = {
  6376				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6377				BPF_ALU64_IMM(BPF_RSH, R0, 36),
  6378				BPF_EXIT_INSN(),
  6379			},
  6380			INTERNAL,
  6381			{ },
  6382			{ { 0, 0x08123456 } }
  6383		},
  6384		{
  6385			"ALU64_RSH_K: Shift > 32, high word",
  6386			.u.insns_int = {
  6387				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6388				BPF_ALU64_IMM(BPF_RSH, R0, 36),
  6389				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  6390				BPF_EXIT_INSN(),
  6391			},
  6392			INTERNAL,
  6393			{ },
  6394			{ { 0, 0 } }
  6395		},
  6396		{
  6397			"ALU64_RSH_K: Shift == 32, low word",
  6398			.u.insns_int = {
  6399				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6400				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  6401				BPF_EXIT_INSN(),
  6402			},
  6403			INTERNAL,
  6404			{ },
  6405			{ { 0, 0x81234567 } }
  6406		},
  6407		{
  6408			"ALU64_RSH_K: Shift == 32, high word",
  6409			.u.insns_int = {
  6410				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6411				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  6412				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  6413				BPF_EXIT_INSN(),
  6414			},
  6415			INTERNAL,
  6416			{ },
  6417			{ { 0, 0 } }
  6418		},
  6419		{
  6420			"ALU64_RSH_K: Zero shift",
  6421			.u.insns_int = {
  6422				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  6423				BPF_ALU64_IMM(BPF_RSH, R0, 0),
  6424				BPF_EXIT_INSN(),
  6425			},
  6426			INTERNAL,
  6427			{ },
  6428			{ { 0, 0x89abcdef } }
  6429		},
  6430		/* BPF_ALU | BPF_ARSH | BPF_X */
  6431		{
  6432			"ALU32_ARSH_X: -1234 >> 7 = -10",
  6433			.u.insns_int = {
  6434				BPF_ALU32_IMM(BPF_MOV, R0, -1234),
  6435				BPF_ALU32_IMM(BPF_MOV, R1, 7),
  6436				BPF_ALU32_REG(BPF_ARSH, R0, R1),
  6437				BPF_EXIT_INSN(),
  6438			},
  6439			INTERNAL,
  6440			{ },
  6441			{ { 0, -10 } }
  6442		},
  6443		{
  6444			"ALU64_ARSH_X: 0xff00ff0000000000 >> 40 = 0xffffffffffff00ff",
  6445			.u.insns_int = {
  6446				BPF_LD_IMM64(R0, 0xff00ff0000000000LL),
  6447				BPF_ALU32_IMM(BPF_MOV, R1, 40),
  6448				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  6449				BPF_EXIT_INSN(),
  6450			},
  6451			INTERNAL,
  6452			{ },
  6453			{ { 0, 0xffff00ff } },
  6454		},
  6455		{
  6456			"ALU64_ARSH_X: Shift < 32, low word",
  6457			.u.insns_int = {
  6458				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6459				BPF_ALU32_IMM(BPF_MOV, R1, 12),
  6460				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  6461				BPF_EXIT_INSN(),
  6462			},
  6463			INTERNAL,
  6464			{ },
  6465			{ { 0, 0x56789abc } }
  6466		},
  6467		{
  6468			"ALU64_ARSH_X: Shift < 32, high word",
  6469			.u.insns_int = {
  6470				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6471				BPF_ALU32_IMM(BPF_MOV, R1, 12),
  6472				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  6473				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  6474				BPF_EXIT_INSN(),
  6475			},
  6476			INTERNAL,
  6477			{ },
  6478			{ { 0, 0xfff81234 } }
  6479		},
  6480		{
  6481			"ALU64_ARSH_X: Shift > 32, low word",
  6482			.u.insns_int = {
  6483				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6484				BPF_ALU32_IMM(BPF_MOV, R1, 36),
  6485				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  6486				BPF_EXIT_INSN(),
  6487			},
  6488			INTERNAL,
  6489			{ },
  6490			{ { 0, 0xf8123456 } }
  6491		},
  6492		{
  6493			"ALU64_ARSH_X: Shift > 32, high word",
  6494			.u.insns_int = {
  6495				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6496				BPF_ALU32_IMM(BPF_MOV, R1, 36),
  6497				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  6498				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  6499				BPF_EXIT_INSN(),
  6500			},
  6501			INTERNAL,
  6502			{ },
  6503			{ { 0, -1 } }
  6504		},
  6505		{
  6506			"ALU64_ARSH_X: Shift == 32, low word",
  6507			.u.insns_int = {
  6508				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6509				BPF_ALU32_IMM(BPF_MOV, R1, 32),
  6510				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  6511				BPF_EXIT_INSN(),
  6512			},
  6513			INTERNAL,
  6514			{ },
  6515			{ { 0, 0x81234567 } }
  6516		},
  6517		{
  6518			"ALU64_ARSH_X: Shift == 32, high word",
  6519			.u.insns_int = {
  6520				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6521				BPF_ALU32_IMM(BPF_MOV, R1, 32),
  6522				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  6523				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  6524				BPF_EXIT_INSN(),
  6525			},
  6526			INTERNAL,
  6527			{ },
  6528			{ { 0, -1 } }
  6529		},
  6530		{
  6531			"ALU64_ARSH_X: Zero shift, low word",
  6532			.u.insns_int = {
  6533				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6534				BPF_ALU32_IMM(BPF_MOV, R1, 0),
  6535				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  6536				BPF_EXIT_INSN(),
  6537			},
  6538			INTERNAL,
  6539			{ },
  6540			{ { 0, 0x89abcdef } }
  6541		},
  6542		{
  6543			"ALU64_ARSH_X: Zero shift, high word",
  6544			.u.insns_int = {
  6545				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6546				BPF_ALU32_IMM(BPF_MOV, R1, 0),
  6547				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  6548				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  6549				BPF_EXIT_INSN(),
  6550			},
  6551			INTERNAL,
  6552			{ },
  6553			{ { 0, 0x81234567 } }
  6554		},
  6555		/* BPF_ALU | BPF_ARSH | BPF_K */
  6556		{
  6557			"ALU32_ARSH_K: -1234 >> 7 = -10",
  6558			.u.insns_int = {
  6559				BPF_ALU32_IMM(BPF_MOV, R0, -1234),
  6560				BPF_ALU32_IMM(BPF_ARSH, R0, 7),
  6561				BPF_EXIT_INSN(),
  6562			},
  6563			INTERNAL,
  6564			{ },
  6565			{ { 0, -10 } }
  6566		},
  6567		{
  6568			"ALU32_ARSH_K: -1234 >> 0 = -1234",
  6569			.u.insns_int = {
  6570				BPF_ALU32_IMM(BPF_MOV, R0, -1234),
  6571				BPF_ALU32_IMM(BPF_ARSH, R0, 0),
  6572				BPF_EXIT_INSN(),
  6573			},
  6574			INTERNAL,
  6575			{ },
  6576			{ { 0, -1234 } }
  6577		},
  6578		{
  6579			"ALU64_ARSH_K: 0xff00ff0000000000 >> 40 = 0xffffffffffff00ff",
  6580			.u.insns_int = {
  6581				BPF_LD_IMM64(R0, 0xff00ff0000000000LL),
  6582				BPF_ALU64_IMM(BPF_ARSH, R0, 40),
  6583				BPF_EXIT_INSN(),
  6584			},
  6585			INTERNAL,
  6586			{ },
  6587			{ { 0, 0xffff00ff } },
  6588		},
  6589		{
  6590			"ALU64_ARSH_K: Shift < 32, low word",
  6591			.u.insns_int = {
  6592				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6593				BPF_ALU64_IMM(BPF_RSH, R0, 12),
  6594				BPF_EXIT_INSN(),
  6595			},
  6596			INTERNAL,
  6597			{ },
  6598			{ { 0, 0x56789abc } }
  6599		},
  6600		{
  6601			"ALU64_ARSH_K: Shift < 32, high word",
  6602			.u.insns_int = {
  6603				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6604				BPF_ALU64_IMM(BPF_ARSH, R0, 12),
  6605				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  6606				BPF_EXIT_INSN(),
  6607			},
  6608			INTERNAL,
  6609			{ },
  6610			{ { 0, 0xfff81234 } }
  6611		},
  6612		{
  6613			"ALU64_ARSH_K: Shift > 32, low word",
  6614			.u.insns_int = {
  6615				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6616				BPF_ALU64_IMM(BPF_ARSH, R0, 36),
  6617				BPF_EXIT_INSN(),
  6618			},
  6619			INTERNAL,
  6620			{ },
  6621			{ { 0, 0xf8123456 } }
  6622		},
  6623		{
  6624			"ALU64_ARSH_K: Shift > 32, high word",
  6625			.u.insns_int = {
  6626				BPF_LD_IMM64(R0, 0xf123456789abcdefLL),
  6627				BPF_ALU64_IMM(BPF_ARSH, R0, 36),
  6628				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  6629				BPF_EXIT_INSN(),
  6630			},
  6631			INTERNAL,
  6632			{ },
  6633			{ { 0, -1 } }
  6634		},
  6635		{
  6636			"ALU64_ARSH_K: Shift == 32, low word",
  6637			.u.insns_int = {
  6638				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6639				BPF_ALU64_IMM(BPF_ARSH, R0, 32),
  6640				BPF_EXIT_INSN(),
  6641			},
  6642			INTERNAL,
  6643			{ },
  6644			{ { 0, 0x81234567 } }
  6645		},
  6646		{
  6647			"ALU64_ARSH_K: Shift == 32, high word",
  6648			.u.insns_int = {
  6649				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6650				BPF_ALU64_IMM(BPF_ARSH, R0, 32),
  6651				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  6652				BPF_EXIT_INSN(),
  6653			},
  6654			INTERNAL,
  6655			{ },
  6656			{ { 0, -1 } }
  6657		},
  6658		{
  6659			"ALU64_ARSH_K: Zero shift",
  6660			.u.insns_int = {
  6661				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  6662				BPF_ALU64_IMM(BPF_ARSH, R0, 0),
  6663				BPF_EXIT_INSN(),
  6664			},
  6665			INTERNAL,
  6666			{ },
  6667			{ { 0, 0x89abcdef } }
  6668		},
  6669		/* BPF_ALU | BPF_NEG */
  6670		{
  6671			"ALU_NEG: -(3) = -3",
  6672			.u.insns_int = {
  6673				BPF_ALU32_IMM(BPF_MOV, R0, 3),
  6674				BPF_ALU32_IMM(BPF_NEG, R0, 0),
  6675				BPF_EXIT_INSN(),
  6676			},
  6677			INTERNAL,
  6678			{ },
  6679			{ { 0, -3 } },
  6680		},
  6681		{
  6682			"ALU_NEG: -(-3) = 3",
  6683			.u.insns_int = {
  6684				BPF_ALU32_IMM(BPF_MOV, R0, -3),
  6685				BPF_ALU32_IMM(BPF_NEG, R0, 0),
  6686				BPF_EXIT_INSN(),
  6687			},
  6688			INTERNAL,
  6689			{ },
  6690			{ { 0, 3 } },
  6691		},
  6692		{
  6693			"ALU64_NEG: -(3) = -3",
  6694			.u.insns_int = {
  6695				BPF_LD_IMM64(R0, 3),
  6696				BPF_ALU64_IMM(BPF_NEG, R0, 0),
  6697				BPF_EXIT_INSN(),
  6698			},
  6699			INTERNAL,
  6700			{ },
  6701			{ { 0, -3 } },
  6702		},
  6703		{
  6704			"ALU64_NEG: -(-3) = 3",
  6705			.u.insns_int = {
  6706				BPF_LD_IMM64(R0, -3),
  6707				BPF_ALU64_IMM(BPF_NEG, R0, 0),
  6708				BPF_EXIT_INSN(),
  6709			},
  6710			INTERNAL,
  6711			{ },
  6712			{ { 0, 3 } },
  6713		},
  6714		/* BPF_ALU | BPF_END | BPF_FROM_BE */
  6715		{
  6716			"ALU_END_FROM_BE 16: 0x0123456789abcdef -> 0xcdef",
  6717			.u.insns_int = {
  6718				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  6719				BPF_ENDIAN(BPF_FROM_BE, R0, 16),
  6720				BPF_EXIT_INSN(),
  6721			},
  6722			INTERNAL,
  6723			{ },
  6724			{ { 0,  cpu_to_be16(0xcdef) } },
  6725		},
  6726		{
  6727			"ALU_END_FROM_BE 32: 0x0123456789abcdef -> 0x89abcdef",
  6728			.u.insns_int = {
  6729				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  6730				BPF_ENDIAN(BPF_FROM_BE, R0, 32),
  6731				BPF_ALU64_REG(BPF_MOV, R1, R0),
  6732				BPF_ALU64_IMM(BPF_RSH, R1, 32),
  6733				BPF_ALU32_REG(BPF_ADD, R0, R1), /* R1 = 0 */
  6734				BPF_EXIT_INSN(),
  6735			},
  6736			INTERNAL,
  6737			{ },
  6738			{ { 0, cpu_to_be32(0x89abcdef) } },
  6739		},
  6740		{
  6741			"ALU_END_FROM_BE 64: 0x0123456789abcdef -> 0x89abcdef",
  6742			.u.insns_int = {
  6743				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  6744				BPF_ENDIAN(BPF_FROM_BE, R0, 64),
  6745				BPF_EXIT_INSN(),
  6746			},
  6747			INTERNAL,
  6748			{ },
  6749			{ { 0, (u32) cpu_to_be64(0x0123456789abcdefLL) } },
  6750		},
  6751		{
  6752			"ALU_END_FROM_BE 64: 0x0123456789abcdef >> 32 -> 0x01234567",
  6753			.u.insns_int = {
  6754				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  6755				BPF_ENDIAN(BPF_FROM_BE, R0, 64),
  6756				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  6757				BPF_EXIT_INSN(),
  6758			},
  6759			INTERNAL,
  6760			{ },
  6761			{ { 0, (u32) (cpu_to_be64(0x0123456789abcdefLL) >> 32) } },
  6762		},
  6763		/* BPF_ALU | BPF_END | BPF_FROM_BE, reversed */
  6764		{
  6765			"ALU_END_FROM_BE 16: 0xfedcba9876543210 -> 0x3210",
  6766			.u.insns_int = {
  6767				BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
  6768				BPF_ENDIAN(BPF_FROM_BE, R0, 16),
  6769				BPF_EXIT_INSN(),
  6770			},
  6771			INTERNAL,
  6772			{ },
  6773			{ { 0,  cpu_to_be16(0x3210) } },
  6774		},
  6775		{
  6776			"ALU_END_FROM_BE 32: 0xfedcba9876543210 -> 0x76543210",
  6777			.u.insns_int = {
  6778				BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
  6779				BPF_ENDIAN(BPF_FROM_BE, R0, 32),
  6780				BPF_ALU64_REG(BPF_MOV, R1, R0),
  6781				BPF_ALU64_IMM(BPF_RSH, R1, 32),
  6782				BPF_ALU32_REG(BPF_ADD, R0, R1), /* R1 = 0 */
  6783				BPF_EXIT_INSN(),
  6784			},
  6785			INTERNAL,
  6786			{ },
  6787			{ { 0, cpu_to_be32(0x76543210) } },
  6788		},
  6789		{
  6790			"ALU_END_FROM_BE 64: 0xfedcba9876543210 -> 0x76543210",
  6791			.u.insns_int = {
  6792				BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
  6793				BPF_ENDIAN(BPF_FROM_BE, R0, 64),
  6794				BPF_EXIT_INSN(),
  6795			},
  6796			INTERNAL,
  6797			{ },
  6798			{ { 0, (u32) cpu_to_be64(0xfedcba9876543210ULL) } },
  6799		},
  6800		{
  6801			"ALU_END_FROM_BE 64: 0xfedcba9876543210 >> 32 -> 0xfedcba98",
  6802			.u.insns_int = {
  6803				BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
  6804				BPF_ENDIAN(BPF_FROM_BE, R0, 64),
  6805				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  6806				BPF_EXIT_INSN(),
  6807			},
  6808			INTERNAL,
  6809			{ },
  6810			{ { 0, (u32) (cpu_to_be64(0xfedcba9876543210ULL) >> 32) } },
  6811		},
  6812		/* BPF_ALU | BPF_END | BPF_FROM_LE */
  6813		{
  6814			"ALU_END_FROM_LE 16: 0x0123456789abcdef -> 0xefcd",
  6815			.u.insns_int = {
  6816				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  6817				BPF_ENDIAN(BPF_FROM_LE, R0, 16),
  6818				BPF_EXIT_INSN(),
  6819			},
  6820			INTERNAL,
  6821			{ },
  6822			{ { 0, cpu_to_le16(0xcdef) } },
  6823		},
  6824		{
  6825			"ALU_END_FROM_LE 32: 0x0123456789abcdef -> 0xefcdab89",
  6826			.u.insns_int = {
  6827				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  6828				BPF_ENDIAN(BPF_FROM_LE, R0, 32),
  6829				BPF_ALU64_REG(BPF_MOV, R1, R0),
  6830				BPF_ALU64_IMM(BPF_RSH, R1, 32),
  6831				BPF_ALU32_REG(BPF_ADD, R0, R1), /* R1 = 0 */
  6832				BPF_EXIT_INSN(),
  6833			},
  6834			INTERNAL,
  6835			{ },
  6836			{ { 0, cpu_to_le32(0x89abcdef) } },
  6837		},
  6838		{
  6839			"ALU_END_FROM_LE 64: 0x0123456789abcdef -> 0x67452301",
  6840			.u.insns_int = {
  6841				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  6842				BPF_ENDIAN(BPF_FROM_LE, R0, 64),
  6843				BPF_EXIT_INSN(),
  6844			},
  6845			INTERNAL,
  6846			{ },
  6847			{ { 0, (u32) cpu_to_le64(0x0123456789abcdefLL) } },
  6848		},
  6849		{
  6850			"ALU_END_FROM_LE 64: 0x0123456789abcdef >> 32 -> 0xefcdab89",
  6851			.u.insns_int = {
  6852				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  6853				BPF_ENDIAN(BPF_FROM_LE, R0, 64),
  6854				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  6855				BPF_EXIT_INSN(),
  6856			},
  6857			INTERNAL,
  6858			{ },
  6859			{ { 0, (u32) (cpu_to_le64(0x0123456789abcdefLL) >> 32) } },
  6860		},
  6861		/* BPF_ALU | BPF_END | BPF_FROM_LE, reversed */
  6862		{
  6863			"ALU_END_FROM_LE 16: 0xfedcba9876543210 -> 0x1032",
  6864			.u.insns_int = {
  6865				BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
  6866				BPF_ENDIAN(BPF_FROM_LE, R0, 16),
  6867				BPF_EXIT_INSN(),
  6868			},
  6869			INTERNAL,
  6870			{ },
  6871			{ { 0,  cpu_to_le16(0x3210) } },
  6872		},
  6873		{
  6874			"ALU_END_FROM_LE 32: 0xfedcba9876543210 -> 0x10325476",
  6875			.u.insns_int = {
  6876				BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
  6877				BPF_ENDIAN(BPF_FROM_LE, R0, 32),
  6878				BPF_ALU64_REG(BPF_MOV, R1, R0),
  6879				BPF_ALU64_IMM(BPF_RSH, R1, 32),
  6880				BPF_ALU32_REG(BPF_ADD, R0, R1), /* R1 = 0 */
  6881				BPF_EXIT_INSN(),
  6882			},
  6883			INTERNAL,
  6884			{ },
  6885			{ { 0, cpu_to_le32(0x76543210) } },
  6886		},
  6887		{
  6888			"ALU_END_FROM_LE 64: 0xfedcba9876543210 -> 0x10325476",
  6889			.u.insns_int = {
  6890				BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
  6891				BPF_ENDIAN(BPF_FROM_LE, R0, 64),
  6892				BPF_EXIT_INSN(),
  6893			},
  6894			INTERNAL,
  6895			{ },
  6896			{ { 0, (u32) cpu_to_le64(0xfedcba9876543210ULL) } },
  6897		},
  6898		{
  6899			"ALU_END_FROM_LE 64: 0xfedcba9876543210 >> 32 -> 0x98badcfe",
  6900			.u.insns_int = {
  6901				BPF_LD_IMM64(R0, 0xfedcba9876543210ULL),
  6902				BPF_ENDIAN(BPF_FROM_LE, R0, 64),
  6903				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  6904				BPF_EXIT_INSN(),
  6905			},
  6906			INTERNAL,
  6907			{ },
  6908			{ { 0, (u32) (cpu_to_le64(0xfedcba9876543210ULL) >> 32) } },
  6909		},
  6910		/* BPF_LDX_MEM B/H/W/DW */
  6911		{
  6912			"BPF_LDX_MEM | BPF_B",
  6913			.u.insns_int = {
  6914				BPF_LD_IMM64(R1, 0x0102030405060708ULL),
  6915				BPF_LD_IMM64(R2, 0x0000000000000008ULL),
  6916				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  6917	#ifdef __BIG_ENDIAN
  6918				BPF_LDX_MEM(BPF_B, R0, R10, -1),
  6919	#else
  6920				BPF_LDX_MEM(BPF_B, R0, R10, -8),
  6921	#endif
  6922				BPF_JMP_REG(BPF_JNE, R0, R2, 1),
  6923				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  6924				BPF_EXIT_INSN(),
  6925			},
  6926			INTERNAL,
  6927			{ },
  6928			{ { 0, 0 } },
  6929			.stack_depth = 8,
  6930		},
  6931		{
  6932			"BPF_LDX_MEM | BPF_B, MSB set",
  6933			.u.insns_int = {
  6934				BPF_LD_IMM64(R1, 0x8182838485868788ULL),
  6935				BPF_LD_IMM64(R2, 0x0000000000000088ULL),
  6936				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  6937	#ifdef __BIG_ENDIAN
  6938				BPF_LDX_MEM(BPF_B, R0, R10, -1),
  6939	#else
  6940				BPF_LDX_MEM(BPF_B, R0, R10, -8),
  6941	#endif
  6942				BPF_JMP_REG(BPF_JNE, R0, R2, 1),
  6943				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  6944				BPF_EXIT_INSN(),
  6945			},
  6946			INTERNAL,
  6947			{ },
  6948			{ { 0, 0 } },
  6949			.stack_depth = 8,
  6950		},
  6951		{
  6952			"BPF_LDX_MEM | BPF_H",
  6953			.u.insns_int = {
  6954				BPF_LD_IMM64(R1, 0x0102030405060708ULL),
  6955				BPF_LD_IMM64(R2, 0x0000000000000708ULL),
  6956				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  6957	#ifdef __BIG_ENDIAN
  6958				BPF_LDX_MEM(BPF_H, R0, R10, -2),
  6959	#else
  6960				BPF_LDX_MEM(BPF_H, R0, R10, -8),
  6961	#endif
  6962				BPF_JMP_REG(BPF_JNE, R0, R2, 1),
  6963				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  6964				BPF_EXIT_INSN(),
  6965			},
  6966			INTERNAL,
  6967			{ },
  6968			{ { 0, 0 } },
  6969			.stack_depth = 8,
  6970		},
  6971		{
  6972			"BPF_LDX_MEM | BPF_H, MSB set",
  6973			.u.insns_int = {
  6974				BPF_LD_IMM64(R1, 0x8182838485868788ULL),
  6975				BPF_LD_IMM64(R2, 0x0000000000008788ULL),
  6976				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  6977	#ifdef __BIG_ENDIAN
  6978				BPF_LDX_MEM(BPF_H, R0, R10, -2),
  6979	#else
  6980				BPF_LDX_MEM(BPF_H, R0, R10, -8),
  6981	#endif
  6982				BPF_JMP_REG(BPF_JNE, R0, R2, 1),
  6983				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  6984				BPF_EXIT_INSN(),
  6985			},
  6986			INTERNAL,
  6987			{ },
  6988			{ { 0, 0 } },
  6989			.stack_depth = 8,
  6990		},
  6991		{
  6992			"BPF_LDX_MEM | BPF_W",
  6993			.u.insns_int = {
  6994				BPF_LD_IMM64(R1, 0x0102030405060708ULL),
  6995				BPF_LD_IMM64(R2, 0x0000000005060708ULL),
  6996				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  6997	#ifdef __BIG_ENDIAN
  6998				BPF_LDX_MEM(BPF_W, R0, R10, -4),
  6999	#else
  7000				BPF_LDX_MEM(BPF_W, R0, R10, -8),
  7001	#endif
  7002				BPF_JMP_REG(BPF_JNE, R0, R2, 1),
  7003				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  7004				BPF_EXIT_INSN(),
  7005			},
  7006			INTERNAL,
  7007			{ },
  7008			{ { 0, 0 } },
  7009			.stack_depth = 8,
  7010		},
  7011		{
  7012			"BPF_LDX_MEM | BPF_W, MSB set",
  7013			.u.insns_int = {
  7014				BPF_LD_IMM64(R1, 0x8182838485868788ULL),
  7015				BPF_LD_IMM64(R2, 0x0000000085868788ULL),
  7016				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  7017	#ifdef __BIG_ENDIAN
  7018				BPF_LDX_MEM(BPF_W, R0, R10, -4),
  7019	#else
  7020				BPF_LDX_MEM(BPF_W, R0, R10, -8),
  7021	#endif
  7022				BPF_JMP_REG(BPF_JNE, R0, R2, 1),
  7023				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  7024				BPF_EXIT_INSN(),
  7025			},
  7026			INTERNAL,
  7027			{ },
  7028			{ { 0, 0 } },
  7029			.stack_depth = 8,
  7030		},
  7031		/* BPF_STX_MEM B/H/W/DW */
  7032		{
  7033			"BPF_STX_MEM | BPF_B",
  7034			.u.insns_int = {
> 7035				BPF_LD_IMM64(R1, 0x8090a0b0c0d0e0f0ULL),
  7036				BPF_LD_IMM64(R2, 0x0102030405060708ULL),
> 7037				BPF_LD_IMM64(R3, 0x8090a0b0c0d0e008ULL),
  7038				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  7039	#ifdef __BIG_ENDIAN
  7040				BPF_STX_MEM(BPF_B, R10, R2, -1),
  7041	#else
  7042				BPF_STX_MEM(BPF_B, R10, R2, -8),
  7043	#endif
  7044				BPF_LDX_MEM(BPF_DW, R0, R10, -8),
  7045				BPF_JMP_REG(BPF_JNE, R0, R3, 1),
  7046				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  7047				BPF_EXIT_INSN(),
  7048			},
  7049			INTERNAL,
  7050			{ },
  7051			{ { 0, 0 } },
  7052			.stack_depth = 8,
  7053		},
  7054		{
  7055			"BPF_STX_MEM | BPF_B, MSB set",
  7056			.u.insns_int = {
  7057				BPF_LD_IMM64(R1, 0x8090a0b0c0d0e0f0ULL),
  7058				BPF_LD_IMM64(R2, 0x8182838485868788ULL),
> 7059				BPF_LD_IMM64(R3, 0x8090a0b0c0d0e088ULL),
  7060				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  7061	#ifdef __BIG_ENDIAN
  7062				BPF_STX_MEM(BPF_B, R10, R2, -1),
  7063	#else
  7064				BPF_STX_MEM(BPF_B, R10, R2, -8),
  7065	#endif
  7066				BPF_LDX_MEM(BPF_DW, R0, R10, -8),
  7067				BPF_JMP_REG(BPF_JNE, R0, R3, 1),
  7068				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  7069				BPF_EXIT_INSN(),
  7070			},
  7071			INTERNAL,
  7072			{ },
  7073			{ { 0, 0 } },
  7074			.stack_depth = 8,
  7075		},
  7076		{
  7077			"BPF_STX_MEM | BPF_H",
  7078			.u.insns_int = {
  7079				BPF_LD_IMM64(R1, 0x8090a0b0c0d0e0f0ULL),
  7080				BPF_LD_IMM64(R2, 0x0102030405060708ULL),
> 7081				BPF_LD_IMM64(R3, 0x8090a0b0c0d00708ULL),
  7082				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  7083	#ifdef __BIG_ENDIAN
  7084				BPF_STX_MEM(BPF_H, R10, R2, -2),
  7085	#else
  7086				BPF_STX_MEM(BPF_H, R10, R2, -8),
  7087	#endif
  7088				BPF_LDX_MEM(BPF_DW, R0, R10, -8),
  7089				BPF_JMP_REG(BPF_JNE, R0, R3, 1),
  7090				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  7091				BPF_EXIT_INSN(),
  7092			},
  7093			INTERNAL,
  7094			{ },
  7095			{ { 0, 0 } },
  7096			.stack_depth = 8,
  7097		},
  7098		{
  7099			"BPF_STX_MEM | BPF_H, MSB set",
  7100			.u.insns_int = {
  7101				BPF_LD_IMM64(R1, 0x8090a0b0c0d0e0f0ULL),
  7102				BPF_LD_IMM64(R2, 0x8182838485868788ULL),
> 7103				BPF_LD_IMM64(R3, 0x8090a0b0c0d08788ULL),
  7104				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  7105	#ifdef __BIG_ENDIAN
  7106				BPF_STX_MEM(BPF_H, R10, R2, -2),
  7107	#else
  7108				BPF_STX_MEM(BPF_H, R10, R2, -8),
  7109	#endif
  7110				BPF_LDX_MEM(BPF_DW, R0, R10, -8),
  7111				BPF_JMP_REG(BPF_JNE, R0, R3, 1),
  7112				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  7113				BPF_EXIT_INSN(),
  7114			},
  7115			INTERNAL,
  7116			{ },
  7117			{ { 0, 0 } },
  7118			.stack_depth = 8,
  7119		},
  7120		{
  7121			"BPF_STX_MEM | BPF_W",
  7122			.u.insns_int = {
  7123				BPF_LD_IMM64(R1, 0x8090a0b0c0d0e0f0ULL),
  7124				BPF_LD_IMM64(R2, 0x0102030405060708ULL),
> 7125				BPF_LD_IMM64(R3, 0x8090a0b005060708ULL),
  7126				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  7127	#ifdef __BIG_ENDIAN
  7128				BPF_STX_MEM(BPF_W, R10, R2, -4),
  7129	#else
  7130				BPF_STX_MEM(BPF_W, R10, R2, -8),
  7131	#endif
  7132				BPF_LDX_MEM(BPF_DW, R0, R10, -8),
  7133				BPF_JMP_REG(BPF_JNE, R0, R3, 1),
  7134				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  7135				BPF_EXIT_INSN(),
  7136			},
  7137			INTERNAL,
  7138			{ },
  7139			{ { 0, 0 } },
  7140			.stack_depth = 8,
  7141		},
  7142		{
  7143			"BPF_STX_MEM | BPF_W, MSB set",
  7144			.u.insns_int = {
  7145				BPF_LD_IMM64(R1, 0x8090a0b0c0d0e0f0ULL),
  7146				BPF_LD_IMM64(R2, 0x8182838485868788ULL),
> 7147				BPF_LD_IMM64(R3, 0x8090a0b085868788ULL),
  7148				BPF_STX_MEM(BPF_DW, R10, R1, -8),
  7149	#ifdef __BIG_ENDIAN
  7150				BPF_STX_MEM(BPF_W, R10, R2, -4),
  7151	#else
  7152				BPF_STX_MEM(BPF_W, R10, R2, -8),
  7153	#endif
  7154				BPF_LDX_MEM(BPF_DW, R0, R10, -8),
  7155				BPF_JMP_REG(BPF_JNE, R0, R3, 1),
  7156				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  7157				BPF_EXIT_INSN(),
  7158			},
  7159			INTERNAL,
  7160			{ },
  7161			{ { 0, 0 } },
  7162			.stack_depth = 8,
  7163		},
  7164		/* BPF_ST(X) | BPF_MEM | BPF_B/H/W/DW */
  7165		{
  7166			"ST_MEM_B: Store/Load byte: max negative",
  7167			.u.insns_int = {
  7168				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  7169				BPF_ST_MEM(BPF_B, R10, -40, 0xff),
  7170				BPF_LDX_MEM(BPF_B, R0, R10, -40),
  7171				BPF_EXIT_INSN(),
  7172			},
  7173			INTERNAL,
  7174			{ },
  7175			{ { 0, 0xff } },
  7176			.stack_depth = 40,
  7177		},
  7178		{
  7179			"ST_MEM_B: Store/Load byte: max positive",
  7180			.u.insns_int = {
  7181				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  7182				BPF_ST_MEM(BPF_H, R10, -40, 0x7f),
  7183				BPF_LDX_MEM(BPF_H, R0, R10, -40),
  7184				BPF_EXIT_INSN(),
  7185			},
  7186			INTERNAL,
  7187			{ },
  7188			{ { 0, 0x7f } },
  7189			.stack_depth = 40,
  7190		},
  7191		{
  7192			"STX_MEM_B: Store/Load byte: max negative",
  7193			.u.insns_int = {
  7194				BPF_LD_IMM64(R0, 0),
  7195				BPF_LD_IMM64(R1, 0xffLL),
  7196				BPF_STX_MEM(BPF_B, R10, R1, -40),
  7197				BPF_LDX_MEM(BPF_B, R0, R10, -40),
  7198				BPF_EXIT_INSN(),
  7199			},
  7200			INTERNAL,
  7201			{ },
  7202			{ { 0, 0xff } },
  7203			.stack_depth = 40,
  7204		},
  7205		{
  7206			"ST_MEM_H: Store/Load half word: max negative",
  7207			.u.insns_int = {
  7208				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  7209				BPF_ST_MEM(BPF_H, R10, -40, 0xffff),
  7210				BPF_LDX_MEM(BPF_H, R0, R10, -40),
  7211				BPF_EXIT_INSN(),
  7212			},
  7213			INTERNAL,
  7214			{ },
  7215			{ { 0, 0xffff } },
  7216			.stack_depth = 40,
  7217		},
  7218		{
  7219			"ST_MEM_H: Store/Load half word: max positive",
  7220			.u.insns_int = {
  7221				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  7222				BPF_ST_MEM(BPF_H, R10, -40, 0x7fff),
  7223				BPF_LDX_MEM(BPF_H, R0, R10, -40),
  7224				BPF_EXIT_INSN(),
  7225			},
  7226			INTERNAL,
  7227			{ },
  7228			{ { 0, 0x7fff } },
  7229			.stack_depth = 40,
  7230		},
  7231		{
  7232			"STX_MEM_H: Store/Load half word: max negative",
  7233			.u.insns_int = {
  7234				BPF_LD_IMM64(R0, 0),
  7235				BPF_LD_IMM64(R1, 0xffffLL),
  7236				BPF_STX_MEM(BPF_H, R10, R1, -40),
  7237				BPF_LDX_MEM(BPF_H, R0, R10, -40),
  7238				BPF_EXIT_INSN(),
  7239			},
  7240			INTERNAL,
  7241			{ },
  7242			{ { 0, 0xffff } },
  7243			.stack_depth = 40,
  7244		},
  7245		{
  7246			"ST_MEM_W: Store/Load word: max negative",
  7247			.u.insns_int = {
  7248				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  7249				BPF_ST_MEM(BPF_W, R10, -40, 0xffffffff),
  7250				BPF_LDX_MEM(BPF_W, R0, R10, -40),
  7251				BPF_EXIT_INSN(),
  7252			},
  7253			INTERNAL,
  7254			{ },
  7255			{ { 0, 0xffffffff } },
  7256			.stack_depth = 40,
  7257		},
  7258		{
  7259			"ST_MEM_W: Store/Load word: max positive",
  7260			.u.insns_int = {
  7261				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  7262				BPF_ST_MEM(BPF_W, R10, -40, 0x7fffffff),
  7263				BPF_LDX_MEM(BPF_W, R0, R10, -40),
  7264				BPF_EXIT_INSN(),
  7265			},
  7266			INTERNAL,
  7267			{ },
  7268			{ { 0, 0x7fffffff } },
  7269			.stack_depth = 40,
  7270		},
  7271		{
  7272			"STX_MEM_W: Store/Load word: max negative",
  7273			.u.insns_int = {
  7274				BPF_LD_IMM64(R0, 0),
  7275				BPF_LD_IMM64(R1, 0xffffffffLL),
  7276				BPF_STX_MEM(BPF_W, R10, R1, -40),
  7277				BPF_LDX_MEM(BPF_W, R0, R10, -40),
  7278				BPF_EXIT_INSN(),
  7279			},
  7280			INTERNAL,
  7281			{ },
  7282			{ { 0, 0xffffffff } },
  7283			.stack_depth = 40,
  7284		},
  7285		{
  7286			"ST_MEM_DW: Store/Load double word: max negative",
  7287			.u.insns_int = {
  7288				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  7289				BPF_ST_MEM(BPF_DW, R10, -40, 0xffffffff),
  7290				BPF_LDX_MEM(BPF_DW, R0, R10, -40),
  7291				BPF_EXIT_INSN(),
  7292			},
  7293			INTERNAL,
  7294			{ },
  7295			{ { 0, 0xffffffff } },
  7296			.stack_depth = 40,
  7297		},
  7298		{
  7299			"ST_MEM_DW: Store/Load double word: max negative 2",
  7300			.u.insns_int = {
  7301				BPF_LD_IMM64(R2, 0xffff00000000ffffLL),
  7302				BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
  7303				BPF_ST_MEM(BPF_DW, R10, -40, 0xffffffff),
  7304				BPF_LDX_MEM(BPF_DW, R2, R10, -40),
  7305				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  7306				BPF_MOV32_IMM(R0, 2),
  7307				BPF_EXIT_INSN(),
  7308				BPF_MOV32_IMM(R0, 1),
  7309				BPF_EXIT_INSN(),
  7310			},
  7311			INTERNAL,
  7312			{ },
  7313			{ { 0, 0x1 } },
  7314			.stack_depth = 40,
  7315		},
  7316		{
  7317			"ST_MEM_DW: Store/Load double word: max positive",
  7318			.u.insns_int = {
  7319				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  7320				BPF_ST_MEM(BPF_DW, R10, -40, 0x7fffffff),
  7321				BPF_LDX_MEM(BPF_DW, R0, R10, -40),
  7322				BPF_EXIT_INSN(),
  7323			},
  7324			INTERNAL,
  7325			{ },
  7326			{ { 0, 0x7fffffff } },
  7327			.stack_depth = 40,
  7328		},
  7329		{
  7330			"STX_MEM_DW: Store/Load double word: max negative",
  7331			.u.insns_int = {
  7332				BPF_LD_IMM64(R0, 0),
  7333				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  7334				BPF_STX_MEM(BPF_DW, R10, R1, -40),
  7335				BPF_LDX_MEM(BPF_DW, R0, R10, -40),
  7336				BPF_EXIT_INSN(),
  7337			},
  7338			INTERNAL,
  7339			{ },
  7340			{ { 0, 0xffffffff } },
  7341			.stack_depth = 40,
  7342		},
  7343		{
  7344			"STX_MEM_DW: Store double word: first word in memory",
  7345			.u.insns_int = {
  7346				BPF_LD_IMM64(R0, 0),
  7347				BPF_LD_IMM64(R1, 0x0123456789abcdefLL),
  7348				BPF_STX_MEM(BPF_DW, R10, R1, -40),
  7349				BPF_LDX_MEM(BPF_W, R0, R10, -40),
  7350				BPF_EXIT_INSN(),
  7351			},
  7352			INTERNAL,
  7353			{ },
  7354	#ifdef __BIG_ENDIAN
  7355			{ { 0, 0x01234567 } },
  7356	#else
  7357			{ { 0, 0x89abcdef } },
  7358	#endif
  7359			.stack_depth = 40,
  7360		},
  7361		{
  7362			"STX_MEM_DW: Store double word: second word in memory",
  7363			.u.insns_int = {
  7364				BPF_LD_IMM64(R0, 0),
  7365				BPF_LD_IMM64(R1, 0x0123456789abcdefLL),
  7366				BPF_STX_MEM(BPF_DW, R10, R1, -40),
  7367				BPF_LDX_MEM(BPF_W, R0, R10, -36),
  7368				BPF_EXIT_INSN(),
  7369			},
  7370			INTERNAL,
  7371			{ },
  7372	#ifdef __BIG_ENDIAN
  7373			{ { 0, 0x89abcdef } },
  7374	#else
  7375			{ { 0, 0x01234567 } },
  7376	#endif
  7377			.stack_depth = 40,
  7378		},
  7379		/* BPF_STX | BPF_ATOMIC | BPF_W/DW */
  7380		{
  7381			"STX_XADD_W: X + 1 + 1 + 1 + ...",
  7382			{ },
  7383			INTERNAL,
  7384			{ },
  7385			{ { 0, 4134 } },
  7386			.fill_helper = bpf_fill_stxw,
  7387		},
  7388		{
  7389			"STX_XADD_DW: X + 1 + 1 + 1 + ...",
  7390			{ },
  7391			INTERNAL,
  7392			{ },
  7393			{ { 0, 4134 } },
  7394			.fill_helper = bpf_fill_stxdw,
  7395		},
  7396		/*
  7397		 * Exhaustive tests of atomic operation variants.
  7398		 * Individual tests are expanded from template macros for all
  7399		 * combinations of ALU operation, word size and fetching.
  7400		 */
  7401	#define BPF_ATOMIC_OP_TEST1(width, op, logic, old, update, result)	\
  7402	{									\
  7403		"BPF_ATOMIC | " #width ", " #op ": Test: "			\
  7404			#old " " #logic " " #update " = " #result,		\
  7405		.u.insns_int = {						\
  7406			BPF_ALU32_IMM(BPF_MOV, R5, update),			\
  7407			BPF_ST_MEM(width, R10, -40, old),			\
  7408			BPF_ATOMIC_OP(width, op, R10, R5, -40),			\
  7409			BPF_LDX_MEM(width, R0, R10, -40),			\
  7410			BPF_EXIT_INSN(),					\
  7411		},								\
  7412		INTERNAL,							\
  7413		{ },								\
  7414		{ { 0, result } },						\
  7415		.stack_depth = 40,						\
  7416	}
  7417	#define BPF_ATOMIC_OP_TEST2(width, op, logic, old, update, result)	\
  7418	{									\
  7419		"BPF_ATOMIC | " #width ", " #op ": Test side effects, r10: "	\
  7420			#old " " #logic " " #update " = " #result,		\
  7421		.u.insns_int = {						\
  7422			BPF_ALU64_REG(BPF_MOV, R1, R10),			\
  7423			BPF_ALU32_IMM(BPF_MOV, R0, update),			\
  7424			BPF_ST_MEM(BPF_W, R10, -40, old),			\
  7425			BPF_ATOMIC_OP(width, op, R10, R0, -40),			\
  7426			BPF_ALU64_REG(BPF_MOV, R0, R10),			\
  7427			BPF_ALU64_REG(BPF_SUB, R0, R1),				\
  7428			BPF_EXIT_INSN(),					\
  7429		},								\
  7430		INTERNAL,							\
  7431		{ },								\
  7432		{ { 0, 0 } },							\
  7433		.stack_depth = 40,						\
  7434	}
  7435	#define BPF_ATOMIC_OP_TEST3(width, op, logic, old, update, result)	\
  7436	{									\
  7437		"BPF_ATOMIC | " #width ", " #op ": Test side effects, r0: "	\
  7438			#old " " #logic " " #update " = " #result,		\
  7439		.u.insns_int = {						\
  7440			BPF_ALU64_REG(BPF_MOV, R0, R10),			\
  7441			BPF_ALU32_IMM(BPF_MOV, R1, update),			\
  7442			BPF_ST_MEM(width, R10, -40, old),			\
  7443			BPF_ATOMIC_OP(width, op, R10, R1, -40),			\
  7444			BPF_ALU64_REG(BPF_SUB, R0, R10),			\
  7445			BPF_EXIT_INSN(),					\
  7446		},								\
  7447		INTERNAL,                                                       \
  7448		{ },                                                            \
  7449		{ { 0, 0 } },                                                   \
  7450		.stack_depth = 40,                                              \
  7451	}
  7452	#define BPF_ATOMIC_OP_TEST4(width, op, logic, old, update, result)	\
  7453	{									\
  7454		"BPF_ATOMIC | " #width ", " #op ": Test fetch: "		\
  7455			#old " " #logic " " #update " = " #result,		\
  7456		.u.insns_int = {						\
  7457			BPF_ALU32_IMM(BPF_MOV, R3, update),			\
  7458			BPF_ST_MEM(width, R10, -40, old),			\
  7459			BPF_ATOMIC_OP(width, op, R10, R3, -40),			\
  7460			BPF_ALU64_REG(BPF_MOV, R0, R3),                         \
  7461			BPF_EXIT_INSN(),					\
  7462		},								\
  7463		INTERNAL,                                                       \
  7464		{ },                                                            \
  7465		{ { 0, (op) & BPF_FETCH ? old : update } },			\
  7466		.stack_depth = 40,                                              \
  7467	}
  7468		/* BPF_ATOMIC | BPF_W: BPF_ADD */
  7469		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_ADD, +, 0x12, 0xab, 0xbd),
  7470		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_ADD, +, 0x12, 0xab, 0xbd),
  7471		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_ADD, +, 0x12, 0xab, 0xbd),
  7472		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_ADD, +, 0x12, 0xab, 0xbd),
  7473		/* BPF_ATOMIC | BPF_W: BPF_ADD | BPF_FETCH */
  7474		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
  7475		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
  7476		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
  7477		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
  7478		/* BPF_ATOMIC | BPF_DW: BPF_ADD */
  7479		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_ADD, +, 0x12, 0xab, 0xbd),
  7480		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_ADD, +, 0x12, 0xab, 0xbd),
  7481		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_ADD, +, 0x12, 0xab, 0xbd),
  7482		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_ADD, +, 0x12, 0xab, 0xbd),
  7483		/* BPF_ATOMIC | BPF_DW: BPF_ADD | BPF_FETCH */
  7484		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
  7485		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
  7486		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
  7487		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
  7488		/* BPF_ATOMIC | BPF_W: BPF_AND */
  7489		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_AND, &, 0x12, 0xab, 0x02),
  7490		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_AND, &, 0x12, 0xab, 0x02),
  7491		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_AND, &, 0x12, 0xab, 0x02),
  7492		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_AND, &, 0x12, 0xab, 0x02),
  7493		/* BPF_ATOMIC | BPF_W: BPF_AND | BPF_FETCH */
  7494		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
  7495		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
  7496		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
  7497		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
  7498		/* BPF_ATOMIC | BPF_DW: BPF_AND */
  7499		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_AND, &, 0x12, 0xab, 0x02),
  7500		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_AND, &, 0x12, 0xab, 0x02),
  7501		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_AND, &, 0x12, 0xab, 0x02),
  7502		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_AND, &, 0x12, 0xab, 0x02),
  7503		/* BPF_ATOMIC | BPF_DW: BPF_AND | BPF_FETCH */
  7504		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
  7505		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
  7506		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
  7507		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
  7508		/* BPF_ATOMIC | BPF_W: BPF_OR */
  7509		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_OR, |, 0x12, 0xab, 0xbb),
  7510		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_OR, |, 0x12, 0xab, 0xbb),
  7511		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_OR, |, 0x12, 0xab, 0xbb),
  7512		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_OR, |, 0x12, 0xab, 0xbb),
  7513		/* BPF_ATOMIC | BPF_W: BPF_OR | BPF_FETCH */
  7514		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
  7515		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
  7516		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
  7517		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
  7518		/* BPF_ATOMIC | BPF_DW: BPF_OR */
  7519		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_OR, |, 0x12, 0xab, 0xbb),
  7520		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_OR, |, 0x12, 0xab, 0xbb),
  7521		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_OR, |, 0x12, 0xab, 0xbb),
  7522		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_OR, |, 0x12, 0xab, 0xbb),
  7523		/* BPF_ATOMIC | BPF_DW: BPF_OR | BPF_FETCH */
  7524		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
  7525		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
  7526		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
  7527		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
  7528		/* BPF_ATOMIC | BPF_W: BPF_XOR */
  7529		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_XOR, ^, 0x12, 0xab, 0xb9),
  7530		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_XOR, ^, 0x12, 0xab, 0xb9),
  7531		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_XOR, ^, 0x12, 0xab, 0xb9),
  7532		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_XOR, ^, 0x12, 0xab, 0xb9),
  7533		/* BPF_ATOMIC | BPF_W: BPF_XOR | BPF_FETCH */
  7534		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
  7535		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
  7536		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
  7537		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
  7538		/* BPF_ATOMIC | BPF_DW: BPF_XOR */
  7539		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_XOR, ^, 0x12, 0xab, 0xb9),
  7540		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_XOR, ^, 0x12, 0xab, 0xb9),
  7541		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_XOR, ^, 0x12, 0xab, 0xb9),
  7542		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_XOR, ^, 0x12, 0xab, 0xb9),
  7543		/* BPF_ATOMIC | BPF_DW: BPF_XOR | BPF_FETCH */
  7544		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
  7545		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
  7546		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
  7547		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
  7548		/* BPF_ATOMIC | BPF_W: BPF_XCHG */
  7549		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
  7550		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
  7551		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
  7552		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
  7553		/* BPF_ATOMIC | BPF_DW: BPF_XCHG */
  7554		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
  7555		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
  7556		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
  7557		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
  7558	#undef BPF_ATOMIC_OP_TEST1
  7559	#undef BPF_ATOMIC_OP_TEST2
  7560	#undef BPF_ATOMIC_OP_TEST3
  7561	#undef BPF_ATOMIC_OP_TEST4
  7562		/* BPF_ATOMIC | BPF_W, BPF_CMPXCHG */
  7563		{
  7564			"BPF_ATOMIC | BPF_W, BPF_CMPXCHG: Test successful return",
  7565			.u.insns_int = {
  7566				BPF_ST_MEM(BPF_W, R10, -40, 0x01234567),
  7567				BPF_ALU32_IMM(BPF_MOV, R0, 0x01234567),
  7568				BPF_ALU32_IMM(BPF_MOV, R3, 0x89abcdef),
  7569				BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R3, -40),
  7570				BPF_EXIT_INSN(),
  7571			},
  7572			INTERNAL,
  7573			{ },
  7574			{ { 0, 0x01234567 } },
  7575			.stack_depth = 40,
  7576		},
  7577		{
  7578			"BPF_ATOMIC | BPF_W, BPF_CMPXCHG: Test successful store",
  7579			.u.insns_int = {
  7580				BPF_ST_MEM(BPF_W, R10, -40, 0x01234567),
  7581				BPF_ALU32_IMM(BPF_MOV, R0, 0x01234567),
  7582				BPF_ALU32_IMM(BPF_MOV, R3, 0x89abcdef),
  7583				BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R3, -40),
  7584				BPF_LDX_MEM(BPF_W, R0, R10, -40),
  7585				BPF_EXIT_INSN(),
  7586			},
  7587			INTERNAL,
  7588			{ },
  7589			{ { 0, 0x89abcdef } },
  7590			.stack_depth = 40,
  7591		},
  7592		{
  7593			"BPF_ATOMIC | BPF_W, BPF_CMPXCHG: Test failure return",
  7594			.u.insns_int = {
  7595				BPF_ST_MEM(BPF_W, R10, -40, 0x01234567),
  7596				BPF_ALU32_IMM(BPF_MOV, R0, 0x76543210),
  7597				BPF_ALU32_IMM(BPF_MOV, R3, 0x89abcdef),
  7598				BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R3, -40),
  7599				BPF_EXIT_INSN(),
  7600			},
  7601			INTERNAL,
  7602			{ },
  7603			{ { 0, 0x01234567 } },
  7604			.stack_depth = 40,
  7605		},
  7606		{
  7607			"BPF_ATOMIC | BPF_W, BPF_CMPXCHG: Test failure store",
  7608			.u.insns_int = {
  7609				BPF_ST_MEM(BPF_W, R10, -40, 0x01234567),
  7610				BPF_ALU32_IMM(BPF_MOV, R0, 0x76543210),
  7611				BPF_ALU32_IMM(BPF_MOV, R3, 0x89abcdef),
  7612				BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R3, -40),
  7613				BPF_LDX_MEM(BPF_W, R0, R10, -40),
  7614				BPF_EXIT_INSN(),
  7615			},
  7616			INTERNAL,
  7617			{ },
  7618			{ { 0, 0x01234567 } },
  7619			.stack_depth = 40,
  7620		},
  7621		{
  7622			"BPF_ATOMIC | BPF_W, BPF_CMPXCHG: Test side effects",
  7623			.u.insns_int = {
  7624				BPF_ST_MEM(BPF_W, R10, -40, 0x01234567),
  7625				BPF_ALU32_IMM(BPF_MOV, R0, 0x01234567),
  7626				BPF_ALU32_IMM(BPF_MOV, R3, 0x89abcdef),
  7627				BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R3, -40),
  7628				BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R3, -40),
  7629				BPF_ALU32_REG(BPF_MOV, R0, R3),
  7630				BPF_EXIT_INSN(),
  7631			},
  7632			INTERNAL,
  7633			{ },
  7634			{ { 0, 0x89abcdef } },
  7635			.stack_depth = 40,
  7636		},
  7637		/* BPF_ATOMIC | BPF_DW, BPF_CMPXCHG */
  7638		{
  7639			"BPF_ATOMIC | BPF_DW, BPF_CMPXCHG: Test successful return",
  7640			.u.insns_int = {
  7641				BPF_LD_IMM64(R1, 0x0123456789abcdefULL),
  7642				BPF_LD_IMM64(R2, 0xfecdba9876543210ULL),
  7643				BPF_ALU64_REG(BPF_MOV, R0, R1),
  7644				BPF_STX_MEM(BPF_DW, R10, R1, -40),
  7645				BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -40),
  7646				BPF_JMP_REG(BPF_JNE, R0, R1, 1),
  7647				BPF_ALU64_REG(BPF_SUB, R0, R1),
  7648				BPF_EXIT_INSN(),
  7649			},
  7650			INTERNAL,
  7651			{ },
  7652			{ { 0, 0 } },
  7653			.stack_depth = 40,
  7654		},
  7655		{
  7656			"BPF_ATOMIC | BPF_DW, BPF_CMPXCHG: Test successful store",
  7657			.u.insns_int = {
  7658				BPF_LD_IMM64(R1, 0x0123456789abcdefULL),
  7659				BPF_LD_IMM64(R2, 0xfecdba9876543210ULL),
  7660				BPF_ALU64_REG(BPF_MOV, R0, R1),
  7661				BPF_STX_MEM(BPF_DW, R10, R0, -40),
  7662				BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -40),
  7663				BPF_LDX_MEM(BPF_DW, R0, R10, -40),
  7664				BPF_JMP_REG(BPF_JNE, R0, R2, 1),
  7665				BPF_ALU64_REG(BPF_SUB, R0, R2),
  7666				BPF_EXIT_INSN(),
  7667			},
  7668			INTERNAL,
  7669			{ },
  7670			{ { 0, 0 } },
  7671			.stack_depth = 40,
  7672		},
  7673		{
  7674			"BPF_ATOMIC | BPF_DW, BPF_CMPXCHG: Test failure return",
  7675			.u.insns_int = {
  7676				BPF_LD_IMM64(R1, 0x0123456789abcdefULL),
  7677				BPF_LD_IMM64(R2, 0xfecdba9876543210ULL),
  7678				BPF_ALU64_REG(BPF_MOV, R0, R1),
  7679				BPF_ALU64_IMM(BPF_ADD, R0, 1),
  7680				BPF_STX_MEM(BPF_DW, R10, R1, -40),
  7681				BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -40),
  7682				BPF_JMP_REG(BPF_JNE, R0, R1, 1),
  7683				BPF_ALU64_REG(BPF_SUB, R0, R1),
  7684				BPF_EXIT_INSN(),
  7685			},
  7686			INTERNAL,
  7687			{ },
  7688			{ { 0, 0 } },
  7689			.stack_depth = 40,
  7690		},
  7691		{
  7692			"BPF_ATOMIC | BPF_DW, BPF_CMPXCHG: Test failure store",
  7693			.u.insns_int = {
  7694				BPF_LD_IMM64(R1, 0x0123456789abcdefULL),
  7695				BPF_LD_IMM64(R2, 0xfecdba9876543210ULL),
  7696				BPF_ALU64_REG(BPF_MOV, R0, R1),
  7697				BPF_ALU64_IMM(BPF_ADD, R0, 1),
  7698				BPF_STX_MEM(BPF_DW, R10, R1, -40),
  7699				BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -40),
  7700				BPF_LDX_MEM(BPF_DW, R0, R10, -40),
  7701				BPF_JMP_REG(BPF_JNE, R0, R1, 1),
  7702				BPF_ALU64_REG(BPF_SUB, R0, R1),
  7703				BPF_EXIT_INSN(),
  7704			},
  7705			INTERNAL,
  7706			{ },
  7707			{ { 0, 0 } },
  7708			.stack_depth = 40,
  7709		},
  7710		{
  7711			"BPF_ATOMIC | BPF_DW, BPF_CMPXCHG: Test side effects",
  7712			.u.insns_int = {
  7713				BPF_LD_IMM64(R1, 0x0123456789abcdefULL),
  7714				BPF_LD_IMM64(R2, 0xfecdba9876543210ULL),
  7715				BPF_ALU64_REG(BPF_MOV, R0, R1),
  7716				BPF_STX_MEM(BPF_DW, R10, R1, -40),
  7717				BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -40),
  7718				BPF_LD_IMM64(R0, 0xfecdba9876543210ULL),
  7719				BPF_JMP_REG(BPF_JNE, R0, R2, 1),
  7720				BPF_ALU64_REG(BPF_SUB, R0, R2),
  7721				BPF_EXIT_INSN(),
  7722			},
  7723			INTERNAL,
  7724			{ },
  7725			{ { 0, 0 } },
  7726			.stack_depth = 40,
  7727		},
  7728		/* BPF_JMP32 | BPF_JEQ | BPF_K */
  7729		{
  7730			"JMP32_JEQ_K: Small immediate",
  7731			.u.insns_int = {
  7732				BPF_ALU32_IMM(BPF_MOV, R0, 123),
  7733				BPF_JMP32_IMM(BPF_JEQ, R0, 321, 1),
  7734				BPF_JMP32_IMM(BPF_JEQ, R0, 123, 1),
  7735				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7736				BPF_EXIT_INSN(),
  7737			},
  7738			INTERNAL,
  7739			{ },
  7740			{ { 0, 123 } }
  7741		},
  7742		{
  7743			"JMP32_JEQ_K: Large immediate",
  7744			.u.insns_int = {
  7745				BPF_ALU32_IMM(BPF_MOV, R0, 12345678),
  7746				BPF_JMP32_IMM(BPF_JEQ, R0, 12345678 & 0xffff, 1),
  7747				BPF_JMP32_IMM(BPF_JEQ, R0, 12345678, 1),
  7748				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7749				BPF_EXIT_INSN(),
  7750			},
  7751			INTERNAL,
  7752			{ },
  7753			{ { 0, 12345678 } }
  7754		},
  7755		{
  7756			"JMP32_JEQ_K: negative immediate",
  7757			.u.insns_int = {
  7758				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  7759				BPF_JMP32_IMM(BPF_JEQ, R0,  123, 1),
  7760				BPF_JMP32_IMM(BPF_JEQ, R0, -123, 1),
  7761				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7762				BPF_EXIT_INSN(),
  7763			},
  7764			INTERNAL,
  7765			{ },
  7766			{ { 0, -123 } }
  7767		},
  7768		/* BPF_JMP32 | BPF_JEQ | BPF_X */
  7769		{
  7770			"JMP32_JEQ_X",
  7771			.u.insns_int = {
  7772				BPF_ALU32_IMM(BPF_MOV, R0, 1234),
  7773				BPF_ALU32_IMM(BPF_MOV, R1, 4321),
  7774				BPF_JMP32_REG(BPF_JEQ, R0, R1, 2),
  7775				BPF_ALU32_IMM(BPF_MOV, R1, 1234),
  7776				BPF_JMP32_REG(BPF_JEQ, R0, R1, 1),
  7777				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7778				BPF_EXIT_INSN(),
  7779			},
  7780			INTERNAL,
  7781			{ },
  7782			{ { 0, 1234 } }
  7783		},
  7784		/* BPF_JMP32 | BPF_JNE | BPF_K */
  7785		{
  7786			"JMP32_JNE_K: Small immediate",
  7787			.u.insns_int = {
  7788				BPF_ALU32_IMM(BPF_MOV, R0, 123),
  7789				BPF_JMP32_IMM(BPF_JNE, R0, 123, 1),
  7790				BPF_JMP32_IMM(BPF_JNE, R0, 321, 1),
  7791				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7792				BPF_EXIT_INSN(),
  7793			},
  7794			INTERNAL,
  7795			{ },
  7796			{ { 0, 123 } }
  7797		},
  7798		{
  7799			"JMP32_JNE_K: Large immediate",
  7800			.u.insns_int = {
  7801				BPF_ALU32_IMM(BPF_MOV, R0, 12345678),
  7802				BPF_JMP32_IMM(BPF_JNE, R0, 12345678, 1),
  7803				BPF_JMP32_IMM(BPF_JNE, R0, 12345678 & 0xffff, 1),
  7804				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7805				BPF_EXIT_INSN(),
  7806			},
  7807			INTERNAL,
  7808			{ },
  7809			{ { 0, 12345678 } }
  7810		},
  7811		{
  7812			"JMP32_JNE_K: negative immediate",
  7813			.u.insns_int = {
  7814				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  7815				BPF_JMP32_IMM(BPF_JNE, R0, -123, 1),
  7816				BPF_JMP32_IMM(BPF_JNE, R0,  123, 1),
  7817				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7818				BPF_EXIT_INSN(),
  7819			},
  7820			INTERNAL,
  7821			{ },
  7822			{ { 0, -123 } }
  7823		},
  7824		/* BPF_JMP32 | BPF_JNE | BPF_X */
  7825		{
  7826			"JMP32_JNE_X",
  7827			.u.insns_int = {
  7828				BPF_ALU32_IMM(BPF_MOV, R0, 1234),
  7829				BPF_ALU32_IMM(BPF_MOV, R1, 1234),
  7830				BPF_JMP32_REG(BPF_JNE, R0, R1, 2),
  7831				BPF_ALU32_IMM(BPF_MOV, R1, 4321),
  7832				BPF_JMP32_REG(BPF_JNE, R0, R1, 1),
  7833				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7834				BPF_EXIT_INSN(),
  7835			},
  7836			INTERNAL,
  7837			{ },
  7838			{ { 0, 1234 } }
  7839		},
  7840		/* BPF_JMP32 | BPF_JSET | BPF_K */
  7841		{
  7842			"JMP32_JSET_K: Small immediate",
  7843			.u.insns_int = {
  7844				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  7845				BPF_JMP32_IMM(BPF_JSET, R0, 2, 1),
  7846				BPF_JMP32_IMM(BPF_JSET, R0, 3, 1),
  7847				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7848				BPF_EXIT_INSN(),
  7849			},
  7850			INTERNAL,
  7851			{ },
  7852			{ { 0, 1 } }
  7853		},
  7854		{
  7855			"JMP32_JSET_K: Large immediate",
  7856			.u.insns_int = {
  7857				BPF_ALU32_IMM(BPF_MOV, R0, 0x40000000),
  7858				BPF_JMP32_IMM(BPF_JSET, R0, 0x3fffffff, 1),
  7859				BPF_JMP32_IMM(BPF_JSET, R0, 0x60000000, 1),
  7860				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7861				BPF_EXIT_INSN(),
  7862			},
  7863			INTERNAL,
  7864			{ },
  7865			{ { 0, 0x40000000 } }
  7866		},
  7867		{
  7868			"JMP32_JSET_K: negative immediate",
  7869			.u.insns_int = {
  7870				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  7871				BPF_JMP32_IMM(BPF_JSET, R0, -1, 1),
  7872				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7873				BPF_EXIT_INSN(),
  7874			},
  7875			INTERNAL,
  7876			{ },
  7877			{ { 0, -123 } }
  7878		},
  7879		/* BPF_JMP32 | BPF_JSET | BPF_X */
  7880		{
  7881			"JMP32_JSET_X",
  7882			.u.insns_int = {
  7883				BPF_ALU32_IMM(BPF_MOV, R0, 8),
  7884				BPF_ALU32_IMM(BPF_MOV, R1, 7),
  7885				BPF_JMP32_REG(BPF_JSET, R0, R1, 2),
  7886				BPF_ALU32_IMM(BPF_MOV, R1, 8 | 2),
  7887				BPF_JMP32_REG(BPF_JNE, R0, R1, 1),
  7888				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7889				BPF_EXIT_INSN(),
  7890			},
  7891			INTERNAL,
  7892			{ },
  7893			{ { 0, 8 } }
  7894		},
  7895		/* BPF_JMP32 | BPF_JGT | BPF_K */
  7896		{
  7897			"JMP32_JGT_K: Small immediate",
  7898			.u.insns_int = {
  7899				BPF_ALU32_IMM(BPF_MOV, R0, 123),
  7900				BPF_JMP32_IMM(BPF_JGT, R0, 123, 1),
  7901				BPF_JMP32_IMM(BPF_JGT, R0, 122, 1),
  7902				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7903				BPF_EXIT_INSN(),
  7904			},
  7905			INTERNAL,
  7906			{ },
  7907			{ { 0, 123 } }
  7908		},
  7909		{
  7910			"JMP32_JGT_K: Large immediate",
  7911			.u.insns_int = {
  7912				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  7913				BPF_JMP32_IMM(BPF_JGT, R0, 0xffffffff, 1),
  7914				BPF_JMP32_IMM(BPF_JGT, R0, 0xfffffffd, 1),
  7915				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7916				BPF_EXIT_INSN(),
  7917			},
  7918			INTERNAL,
  7919			{ },
  7920			{ { 0, 0xfffffffe } }
  7921		},
  7922		/* BPF_JMP32 | BPF_JGT | BPF_X */
  7923		{
  7924			"JMP32_JGT_X",
  7925			.u.insns_int = {
  7926				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  7927				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  7928				BPF_JMP32_REG(BPF_JGT, R0, R1, 2),
  7929				BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffd),
  7930				BPF_JMP32_REG(BPF_JGT, R0, R1, 1),
  7931				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7932				BPF_EXIT_INSN(),
  7933			},
  7934			INTERNAL,
  7935			{ },
  7936			{ { 0, 0xfffffffe } }
  7937		},
  7938		/* BPF_JMP32 | BPF_JGE | BPF_K */
  7939		{
  7940			"JMP32_JGE_K: Small immediate",
  7941			.u.insns_int = {
  7942				BPF_ALU32_IMM(BPF_MOV, R0, 123),
  7943				BPF_JMP32_IMM(BPF_JGE, R0, 124, 1),
  7944				BPF_JMP32_IMM(BPF_JGE, R0, 123, 1),
  7945				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7946				BPF_EXIT_INSN(),
  7947			},
  7948			INTERNAL,
  7949			{ },
  7950			{ { 0, 123 } }
  7951		},
  7952		{
  7953			"JMP32_JGE_K: Large immediate",
  7954			.u.insns_int = {
  7955				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  7956				BPF_JMP32_IMM(BPF_JGE, R0, 0xffffffff, 1),
  7957				BPF_JMP32_IMM(BPF_JGE, R0, 0xfffffffe, 1),
  7958				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7959				BPF_EXIT_INSN(),
  7960			},
  7961			INTERNAL,
  7962			{ },
  7963			{ { 0, 0xfffffffe } }
  7964		},
  7965		/* BPF_JMP32 | BPF_JGE | BPF_X */
  7966		{
  7967			"JMP32_JGE_X",
  7968			.u.insns_int = {
  7969				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  7970				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  7971				BPF_JMP32_REG(BPF_JGE, R0, R1, 2),
  7972				BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffe),
  7973				BPF_JMP32_REG(BPF_JGE, R0, R1, 1),
  7974				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7975				BPF_EXIT_INSN(),
  7976			},
  7977			INTERNAL,
  7978			{ },
  7979			{ { 0, 0xfffffffe } }
  7980		},
  7981		/* BPF_JMP32 | BPF_JLT | BPF_K */
  7982		{
  7983			"JMP32_JLT_K: Small immediate",
  7984			.u.insns_int = {
  7985				BPF_ALU32_IMM(BPF_MOV, R0, 123),
  7986				BPF_JMP32_IMM(BPF_JLT, R0, 123, 1),
  7987				BPF_JMP32_IMM(BPF_JLT, R0, 124, 1),
  7988				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7989				BPF_EXIT_INSN(),
  7990			},
  7991			INTERNAL,
  7992			{ },
  7993			{ { 0, 123 } }
  7994		},
  7995		{
  7996			"JMP32_JLT_K: Large immediate",
  7997			.u.insns_int = {
  7998				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  7999				BPF_JMP32_IMM(BPF_JLT, R0, 0xfffffffd, 1),
  8000				BPF_JMP32_IMM(BPF_JLT, R0, 0xffffffff, 1),
  8001				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8002				BPF_EXIT_INSN(),
  8003			},
  8004			INTERNAL,
  8005			{ },
  8006			{ { 0, 0xfffffffe } }
  8007		},
  8008		/* BPF_JMP32 | BPF_JLT | BPF_X */
  8009		{
  8010			"JMP32_JLT_X",
  8011			.u.insns_int = {
  8012				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  8013				BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffd),
  8014				BPF_JMP32_REG(BPF_JLT, R0, R1, 2),
  8015				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  8016				BPF_JMP32_REG(BPF_JLT, R0, R1, 1),
  8017				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8018				BPF_EXIT_INSN(),
  8019			},
  8020			INTERNAL,
  8021			{ },
  8022			{ { 0, 0xfffffffe } }
  8023		},
  8024		/* BPF_JMP32 | BPF_JLE | BPF_K */
  8025		{
  8026			"JMP32_JLE_K: Small immediate",
  8027			.u.insns_int = {
  8028				BPF_ALU32_IMM(BPF_MOV, R0, 123),
  8029				BPF_JMP32_IMM(BPF_JLE, R0, 122, 1),
  8030				BPF_JMP32_IMM(BPF_JLE, R0, 123, 1),
  8031				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8032				BPF_EXIT_INSN(),
  8033			},
  8034			INTERNAL,
  8035			{ },
  8036			{ { 0, 123 } }
  8037		},
  8038		{
  8039			"JMP32_JLE_K: Large immediate",
  8040			.u.insns_int = {
  8041				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  8042				BPF_JMP32_IMM(BPF_JLE, R0, 0xfffffffd, 1),
  8043				BPF_JMP32_IMM(BPF_JLE, R0, 0xfffffffe, 1),
  8044				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8045				BPF_EXIT_INSN(),
  8046			},
  8047			INTERNAL,
  8048			{ },
  8049			{ { 0, 0xfffffffe } }
  8050		},
  8051		/* BPF_JMP32 | BPF_JLE | BPF_X */
  8052		{
  8053			"JMP32_JLE_X",
  8054			.u.insns_int = {
  8055				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  8056				BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffd),
  8057				BPF_JMP32_REG(BPF_JLE, R0, R1, 2),
  8058				BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffe),
  8059				BPF_JMP32_REG(BPF_JLE, R0, R1, 1),
  8060				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8061				BPF_EXIT_INSN(),
  8062			},
  8063			INTERNAL,
  8064			{ },
  8065			{ { 0, 0xfffffffe } }
  8066		},
  8067		/* BPF_JMP32 | BPF_JSGT | BPF_K */
  8068		{
  8069			"JMP32_JSGT_K: Small immediate",
  8070			.u.insns_int = {
  8071				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  8072				BPF_JMP32_IMM(BPF_JSGT, R0, -123, 1),
  8073				BPF_JMP32_IMM(BPF_JSGT, R0, -124, 1),
  8074				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8075				BPF_EXIT_INSN(),
  8076			},
  8077			INTERNAL,
  8078			{ },
  8079			{ { 0, -123 } }
  8080		},
  8081		{
  8082			"JMP32_JSGT_K: Large immediate",
  8083			.u.insns_int = {
  8084				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  8085				BPF_JMP32_IMM(BPF_JSGT, R0, -12345678, 1),
  8086				BPF_JMP32_IMM(BPF_JSGT, R0, -12345679, 1),
  8087				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8088				BPF_EXIT_INSN(),
  8089			},
  8090			INTERNAL,
  8091			{ },
  8092			{ { 0, -12345678 } }
  8093		},
  8094		/* BPF_JMP32 | BPF_JSGT | BPF_X */
  8095		{
  8096			"JMP32_JSGT_X",
  8097			.u.insns_int = {
  8098				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  8099				BPF_ALU32_IMM(BPF_MOV, R1, -12345678),
  8100				BPF_JMP32_REG(BPF_JSGT, R0, R1, 2),
  8101				BPF_ALU32_IMM(BPF_MOV, R1, -12345679),
  8102				BPF_JMP32_REG(BPF_JSGT, R0, R1, 1),
  8103				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8104				BPF_EXIT_INSN(),
  8105			},
  8106			INTERNAL,
  8107			{ },
  8108			{ { 0, -12345678 } }
  8109		},
  8110		/* BPF_JMP32 | BPF_JSGE | BPF_K */
  8111		{
  8112			"JMP32_JSGE_K: Small immediate",
  8113			.u.insns_int = {
  8114				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  8115				BPF_JMP32_IMM(BPF_JSGE, R0, -122, 1),
  8116				BPF_JMP32_IMM(BPF_JSGE, R0, -123, 1),
  8117				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8118				BPF_EXIT_INSN(),
  8119			},
  8120			INTERNAL,
  8121			{ },
  8122			{ { 0, -123 } }
  8123		},
  8124		{
  8125			"JMP32_JSGE_K: Large immediate",
  8126			.u.insns_int = {
  8127				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  8128				BPF_JMP32_IMM(BPF_JSGE, R0, -12345677, 1),
  8129				BPF_JMP32_IMM(BPF_JSGE, R0, -12345678, 1),
  8130				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8131				BPF_EXIT_INSN(),
  8132			},
  8133			INTERNAL,
  8134			{ },
  8135			{ { 0, -12345678 } }
  8136		},
  8137		/* BPF_JMP32 | BPF_JSGE | BPF_X */
  8138		{
  8139			"JMP32_JSGE_X",
  8140			.u.insns_int = {
  8141				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  8142				BPF_ALU32_IMM(BPF_MOV, R1, -12345677),
  8143				BPF_JMP32_REG(BPF_JSGE, R0, R1, 2),
  8144				BPF_ALU32_IMM(BPF_MOV, R1, -12345678),
  8145				BPF_JMP32_REG(BPF_JSGE, R0, R1, 1),
  8146				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8147				BPF_EXIT_INSN(),
  8148			},
  8149			INTERNAL,
  8150			{ },
  8151			{ { 0, -12345678 } }
  8152		},
  8153		/* BPF_JMP32 | BPF_JSLT | BPF_K */
  8154		{
  8155			"JMP32_JSLT_K: Small immediate",
  8156			.u.insns_int = {
  8157				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  8158				BPF_JMP32_IMM(BPF_JSLT, R0, -123, 1),
  8159				BPF_JMP32_IMM(BPF_JSLT, R0, -122, 1),
  8160				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8161				BPF_EXIT_INSN(),
  8162			},
  8163			INTERNAL,
  8164			{ },
  8165			{ { 0, -123 } }
  8166		},
  8167		{
  8168			"JMP32_JSLT_K: Large immediate",
  8169			.u.insns_int = {
  8170				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  8171				BPF_JMP32_IMM(BPF_JSLT, R0, -12345678, 1),
  8172				BPF_JMP32_IMM(BPF_JSLT, R0, -12345677, 1),
  8173				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8174				BPF_EXIT_INSN(),
  8175			},
  8176			INTERNAL,
  8177			{ },
  8178			{ { 0, -12345678 } }
  8179		},
  8180		/* BPF_JMP32 | BPF_JSLT | BPF_X */
  8181		{
  8182			"JMP32_JSLT_X",
  8183			.u.insns_int = {
  8184				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  8185				BPF_ALU32_IMM(BPF_MOV, R1, -12345678),
  8186				BPF_JMP32_REG(BPF_JSLT, R0, R1, 2),
  8187				BPF_ALU32_IMM(BPF_MOV, R1, -12345677),
  8188				BPF_JMP32_REG(BPF_JSLT, R0, R1, 1),
  8189				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8190				BPF_EXIT_INSN(),
  8191			},
  8192			INTERNAL,
  8193			{ },
  8194			{ { 0, -12345678 } }
  8195		},
  8196		/* BPF_JMP32 | BPF_JSLE | BPF_K */
  8197		{
  8198			"JMP32_JSLE_K: Small immediate",
  8199			.u.insns_int = {
  8200				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  8201				BPF_JMP32_IMM(BPF_JSLE, R0, -124, 1),
  8202				BPF_JMP32_IMM(BPF_JSLE, R0, -123, 1),
  8203				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8204				BPF_EXIT_INSN(),
  8205			},
  8206			INTERNAL,
  8207			{ },
  8208			{ { 0, -123 } }
  8209		},
  8210		{
  8211			"JMP32_JSLE_K: Large immediate",
  8212			.u.insns_int = {
  8213				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  8214				BPF_JMP32_IMM(BPF_JSLE, R0, -12345679, 1),
  8215				BPF_JMP32_IMM(BPF_JSLE, R0, -12345678, 1),
  8216				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8217				BPF_EXIT_INSN(),
  8218			},
  8219			INTERNAL,
  8220			{ },
  8221			{ { 0, -12345678 } }
  8222		},
  8223		/* BPF_JMP32 | BPF_JSLE | BPF_K */
  8224		{
  8225			"JMP32_JSLE_X",
  8226			.u.insns_int = {
  8227				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  8228				BPF_ALU32_IMM(BPF_MOV, R1, -12345679),
  8229				BPF_JMP32_REG(BPF_JSLE, R0, R1, 2),
  8230				BPF_ALU32_IMM(BPF_MOV, R1, -12345678),
  8231				BPF_JMP32_REG(BPF_JSLE, R0, R1, 1),
  8232				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8233				BPF_EXIT_INSN(),
  8234			},
  8235			INTERNAL,
  8236			{ },
  8237			{ { 0, -12345678 } }
  8238		},
  8239		/* BPF_JMP | BPF_EXIT */
  8240		{
  8241			"JMP_EXIT",
  8242			.u.insns_int = {
  8243				BPF_ALU32_IMM(BPF_MOV, R0, 0x4711),
  8244				BPF_EXIT_INSN(),
  8245				BPF_ALU32_IMM(BPF_MOV, R0, 0x4712),
  8246			},
  8247			INTERNAL,
  8248			{ },
  8249			{ { 0, 0x4711 } },
  8250		},
  8251		/* BPF_JMP | BPF_JA */
  8252		{
  8253			"JMP_JA: Unconditional jump: if (true) return 1",
  8254			.u.insns_int = {
  8255				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8256				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
  8257				BPF_EXIT_INSN(),
  8258				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8259				BPF_EXIT_INSN(),
  8260			},
  8261			INTERNAL,
  8262			{ },
  8263			{ { 0, 1 } },
  8264		},
  8265		/* BPF_JMP | BPF_JSLT | BPF_K */
  8266		{
  8267			"JMP_JSLT_K: Signed jump: if (-2 < -1) return 1",
  8268			.u.insns_int = {
  8269				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8270				BPF_LD_IMM64(R1, 0xfffffffffffffffeLL),
  8271				BPF_JMP_IMM(BPF_JSLT, R1, -1, 1),
  8272				BPF_EXIT_INSN(),
  8273				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8274				BPF_EXIT_INSN(),
  8275			},
  8276			INTERNAL,
  8277			{ },
  8278			{ { 0, 1 } },
  8279		},
  8280		{
  8281			"JMP_JSLT_K: Signed jump: if (-1 < -1) return 0",
  8282			.u.insns_int = {
  8283				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8284				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  8285				BPF_JMP_IMM(BPF_JSLT, R1, -1, 1),
  8286				BPF_EXIT_INSN(),
  8287				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8288				BPF_EXIT_INSN(),
  8289			},
  8290			INTERNAL,
  8291			{ },
  8292			{ { 0, 1 } },
  8293		},
  8294		/* BPF_JMP | BPF_JSGT | BPF_K */
  8295		{
  8296			"JMP_JSGT_K: Signed jump: if (-1 > -2) return 1",
  8297			.u.insns_int = {
  8298				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8299				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  8300				BPF_JMP_IMM(BPF_JSGT, R1, -2, 1),
  8301				BPF_EXIT_INSN(),
  8302				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8303				BPF_EXIT_INSN(),
  8304			},
  8305			INTERNAL,
  8306			{ },
  8307			{ { 0, 1 } },
  8308		},
  8309		{
  8310			"JMP_JSGT_K: Signed jump: if (-1 > -1) return 0",
  8311			.u.insns_int = {
  8312				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8313				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  8314				BPF_JMP_IMM(BPF_JSGT, R1, -1, 1),
  8315				BPF_EXIT_INSN(),
  8316				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8317				BPF_EXIT_INSN(),
  8318			},
  8319			INTERNAL,
  8320			{ },
  8321			{ { 0, 1 } },
  8322		},
  8323		/* BPF_JMP | BPF_JSLE | BPF_K */
  8324		{
  8325			"JMP_JSLE_K: Signed jump: if (-2 <= -1) return 1",
  8326			.u.insns_int = {
  8327				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8328				BPF_LD_IMM64(R1, 0xfffffffffffffffeLL),
  8329				BPF_JMP_IMM(BPF_JSLE, R1, -1, 1),
  8330				BPF_EXIT_INSN(),
  8331				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8332				BPF_EXIT_INSN(),
  8333			},
  8334			INTERNAL,
  8335			{ },
  8336			{ { 0, 1 } },
  8337		},
  8338		{
  8339			"JMP_JSLE_K: Signed jump: if (-1 <= -1) return 1",
  8340			.u.insns_int = {
  8341				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8342				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  8343				BPF_JMP_IMM(BPF_JSLE, R1, -1, 1),
  8344				BPF_EXIT_INSN(),
  8345				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8346				BPF_EXIT_INSN(),
  8347			},
  8348			INTERNAL,
  8349			{ },
  8350			{ { 0, 1 } },
  8351		},
  8352		{
  8353			"JMP_JSLE_K: Signed jump: value walk 1",
  8354			.u.insns_int = {
  8355				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8356				BPF_LD_IMM64(R1, 3),
  8357				BPF_JMP_IMM(BPF_JSLE, R1, 0, 6),
  8358				BPF_ALU64_IMM(BPF_SUB, R1, 1),
  8359				BPF_JMP_IMM(BPF_JSLE, R1, 0, 4),
  8360				BPF_ALU64_IMM(BPF_SUB, R1, 1),
  8361				BPF_JMP_IMM(BPF_JSLE, R1, 0, 2),
  8362				BPF_ALU64_IMM(BPF_SUB, R1, 1),
  8363				BPF_JMP_IMM(BPF_JSLE, R1, 0, 1),
  8364				BPF_EXIT_INSN(),		/* bad exit */
  8365				BPF_ALU32_IMM(BPF_MOV, R0, 1),	/* good exit */
  8366				BPF_EXIT_INSN(),
  8367			},
  8368			INTERNAL,
  8369			{ },
  8370			{ { 0, 1 } },
  8371		},
  8372		{
  8373			"JMP_JSLE_K: Signed jump: value walk 2",
  8374			.u.insns_int = {
  8375				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8376				BPF_LD_IMM64(R1, 3),
  8377				BPF_JMP_IMM(BPF_JSLE, R1, 0, 4),
  8378				BPF_ALU64_IMM(BPF_SUB, R1, 2),
  8379				BPF_JMP_IMM(BPF_JSLE, R1, 0, 2),
  8380				BPF_ALU64_IMM(BPF_SUB, R1, 2),
  8381				BPF_JMP_IMM(BPF_JSLE, R1, 0, 1),
  8382				BPF_EXIT_INSN(),		/* bad exit */
  8383				BPF_ALU32_IMM(BPF_MOV, R0, 1),	/* good exit */
  8384				BPF_EXIT_INSN(),
  8385			},
  8386			INTERNAL,
  8387			{ },
  8388			{ { 0, 1 } },
  8389		},
  8390		/* BPF_JMP | BPF_JSGE | BPF_K */
  8391		{
  8392			"JMP_JSGE_K: Signed jump: if (-1 >= -2) return 1",
  8393			.u.insns_int = {
  8394				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8395				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  8396				BPF_JMP_IMM(BPF_JSGE, R1, -2, 1),
  8397				BPF_EXIT_INSN(),
  8398				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8399				BPF_EXIT_INSN(),
  8400			},
  8401			INTERNAL,
  8402			{ },
  8403			{ { 0, 1 } },
  8404		},
  8405		{
  8406			"JMP_JSGE_K: Signed jump: if (-1 >= -1) return 1",
  8407			.u.insns_int = {
  8408				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8409				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  8410				BPF_JMP_IMM(BPF_JSGE, R1, -1, 1),
  8411				BPF_EXIT_INSN(),
  8412				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8413				BPF_EXIT_INSN(),
  8414			},
  8415			INTERNAL,
  8416			{ },
  8417			{ { 0, 1 } },
  8418		},
  8419		{
  8420			"JMP_JSGE_K: Signed jump: value walk 1",
  8421			.u.insns_int = {
  8422				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8423				BPF_LD_IMM64(R1, -3),
  8424				BPF_JMP_IMM(BPF_JSGE, R1, 0, 6),
  8425				BPF_ALU64_IMM(BPF_ADD, R1, 1),
  8426				BPF_JMP_IMM(BPF_JSGE, R1, 0, 4),
  8427				BPF_ALU64_IMM(BPF_ADD, R1, 1),
  8428				BPF_JMP_IMM(BPF_JSGE, R1, 0, 2),
  8429				BPF_ALU64_IMM(BPF_ADD, R1, 1),
  8430				BPF_JMP_IMM(BPF_JSGE, R1, 0, 1),
  8431				BPF_EXIT_INSN(),		/* bad exit */
  8432				BPF_ALU32_IMM(BPF_MOV, R0, 1),	/* good exit */
  8433				BPF_EXIT_INSN(),
  8434			},
  8435			INTERNAL,
  8436			{ },
  8437			{ { 0, 1 } },
  8438		},
  8439		{
  8440			"JMP_JSGE_K: Signed jump: value walk 2",
  8441			.u.insns_int = {
  8442				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8443				BPF_LD_IMM64(R1, -3),
  8444				BPF_JMP_IMM(BPF_JSGE, R1, 0, 4),
  8445				BPF_ALU64_IMM(BPF_ADD, R1, 2),
  8446				BPF_JMP_IMM(BPF_JSGE, R1, 0, 2),
  8447				BPF_ALU64_IMM(BPF_ADD, R1, 2),
  8448				BPF_JMP_IMM(BPF_JSGE, R1, 0, 1),
  8449				BPF_EXIT_INSN(),		/* bad exit */
  8450				BPF_ALU32_IMM(BPF_MOV, R0, 1),	/* good exit */
  8451				BPF_EXIT_INSN(),
  8452			},
  8453			INTERNAL,
  8454			{ },
  8455			{ { 0, 1 } },
  8456		},
  8457		/* BPF_JMP | BPF_JGT | BPF_K */
  8458		{
  8459			"JMP_JGT_K: if (3 > 2) return 1",
  8460			.u.insns_int = {
  8461				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8462				BPF_LD_IMM64(R1, 3),
  8463				BPF_JMP_IMM(BPF_JGT, R1, 2, 1),
  8464				BPF_EXIT_INSN(),
  8465				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8466				BPF_EXIT_INSN(),
  8467			},
  8468			INTERNAL,
  8469			{ },
  8470			{ { 0, 1 } },
  8471		},
  8472		{
  8473			"JMP_JGT_K: Unsigned jump: if (-1 > 1) return 1",
  8474			.u.insns_int = {
  8475				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8476				BPF_LD_IMM64(R1, -1),
  8477				BPF_JMP_IMM(BPF_JGT, R1, 1, 1),
  8478				BPF_EXIT_INSN(),
  8479				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8480				BPF_EXIT_INSN(),
  8481			},
  8482			INTERNAL,
  8483			{ },
  8484			{ { 0, 1 } },
  8485		},
  8486		/* BPF_JMP | BPF_JLT | BPF_K */
  8487		{
  8488			"JMP_JLT_K: if (2 < 3) return 1",
  8489			.u.insns_int = {
  8490				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8491				BPF_LD_IMM64(R1, 2),
  8492				BPF_JMP_IMM(BPF_JLT, R1, 3, 1),
  8493				BPF_EXIT_INSN(),
  8494				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8495				BPF_EXIT_INSN(),
  8496			},
  8497			INTERNAL,
  8498			{ },
  8499			{ { 0, 1 } },
  8500		},
  8501		{
  8502			"JMP_JGT_K: Unsigned jump: if (1 < -1) return 1",
  8503			.u.insns_int = {
  8504				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8505				BPF_LD_IMM64(R1, 1),
  8506				BPF_JMP_IMM(BPF_JLT, R1, -1, 1),
  8507				BPF_EXIT_INSN(),
  8508				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8509				BPF_EXIT_INSN(),
  8510			},
  8511			INTERNAL,
  8512			{ },
  8513			{ { 0, 1 } },
  8514		},
  8515		/* BPF_JMP | BPF_JGE | BPF_K */
  8516		{
  8517			"JMP_JGE_K: if (3 >= 2) return 1",
  8518			.u.insns_int = {
  8519				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8520				BPF_LD_IMM64(R1, 3),
  8521				BPF_JMP_IMM(BPF_JGE, R1, 2, 1),
  8522				BPF_EXIT_INSN(),
  8523				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8524				BPF_EXIT_INSN(),
  8525			},
  8526			INTERNAL,
  8527			{ },
  8528			{ { 0, 1 } },
  8529		},
  8530		/* BPF_JMP | BPF_JLE | BPF_K */
  8531		{
  8532			"JMP_JLE_K: if (2 <= 3) return 1",
  8533			.u.insns_int = {
  8534				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8535				BPF_LD_IMM64(R1, 2),
  8536				BPF_JMP_IMM(BPF_JLE, R1, 3, 1),
  8537				BPF_EXIT_INSN(),
  8538				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8539				BPF_EXIT_INSN(),
  8540			},
  8541			INTERNAL,
  8542			{ },
  8543			{ { 0, 1 } },
  8544		},
  8545		/* BPF_JMP | BPF_JGT | BPF_K jump backwards */
  8546		{
  8547			"JMP_JGT_K: if (3 > 2) return 1 (jump backwards)",
  8548			.u.insns_int = {
  8549				BPF_JMP_IMM(BPF_JA, 0, 0, 2), /* goto start */
  8550				BPF_ALU32_IMM(BPF_MOV, R0, 1), /* out: */
  8551				BPF_EXIT_INSN(),
  8552				BPF_ALU32_IMM(BPF_MOV, R0, 0), /* start: */
  8553				BPF_LD_IMM64(R1, 3), /* note: this takes 2 insns */
  8554				BPF_JMP_IMM(BPF_JGT, R1, 2, -6), /* goto out */
  8555				BPF_EXIT_INSN(),
  8556			},
  8557			INTERNAL,
  8558			{ },
  8559			{ { 0, 1 } },
  8560		},
  8561		{
  8562			"JMP_JGE_K: if (3 >= 3) return 1",
  8563			.u.insns_int = {
  8564				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8565				BPF_LD_IMM64(R1, 3),
  8566				BPF_JMP_IMM(BPF_JGE, R1, 3, 1),
  8567				BPF_EXIT_INSN(),
  8568				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8569				BPF_EXIT_INSN(),
  8570			},
  8571			INTERNAL,
  8572			{ },
  8573			{ { 0, 1 } },
  8574		},
  8575		/* BPF_JMP | BPF_JLT | BPF_K jump backwards */
  8576		{
  8577			"JMP_JGT_K: if (2 < 3) return 1 (jump backwards)",
  8578			.u.insns_int = {
  8579				BPF_JMP_IMM(BPF_JA, 0, 0, 2), /* goto start */
  8580				BPF_ALU32_IMM(BPF_MOV, R0, 1), /* out: */
  8581				BPF_EXIT_INSN(),
  8582				BPF_ALU32_IMM(BPF_MOV, R0, 0), /* start: */
  8583				BPF_LD_IMM64(R1, 2), /* note: this takes 2 insns */
  8584				BPF_JMP_IMM(BPF_JLT, R1, 3, -6), /* goto out */
  8585				BPF_EXIT_INSN(),
  8586			},
  8587			INTERNAL,
  8588			{ },
  8589			{ { 0, 1 } },
  8590		},
  8591		{
  8592			"JMP_JLE_K: if (3 <= 3) return 1",
  8593			.u.insns_int = {
  8594				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8595				BPF_LD_IMM64(R1, 3),
  8596				BPF_JMP_IMM(BPF_JLE, R1, 3, 1),
  8597				BPF_EXIT_INSN(),
  8598				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8599				BPF_EXIT_INSN(),
  8600			},
  8601			INTERNAL,
  8602			{ },
  8603			{ { 0, 1 } },
  8604		},
  8605		/* BPF_JMP | BPF_JNE | BPF_K */
  8606		{
  8607			"JMP_JNE_K: if (3 != 2) return 1",
  8608			.u.insns_int = {
  8609				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8610				BPF_LD_IMM64(R1, 3),
  8611				BPF_JMP_IMM(BPF_JNE, R1, 2, 1),
  8612				BPF_EXIT_INSN(),
  8613				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8614				BPF_EXIT_INSN(),
  8615			},
  8616			INTERNAL,
  8617			{ },
  8618			{ { 0, 1 } },
  8619		},
  8620		/* BPF_JMP | BPF_JEQ | BPF_K */
  8621		{
  8622			"JMP_JEQ_K: if (3 == 3) return 1",
  8623			.u.insns_int = {
  8624				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8625				BPF_LD_IMM64(R1, 3),
  8626				BPF_JMP_IMM(BPF_JEQ, R1, 3, 1),
  8627				BPF_EXIT_INSN(),
  8628				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8629				BPF_EXIT_INSN(),
  8630			},
  8631			INTERNAL,
  8632			{ },
  8633			{ { 0, 1 } },
  8634		},
  8635		/* BPF_JMP | BPF_JSET | BPF_K */
  8636		{
  8637			"JMP_JSET_K: if (0x3 & 0x2) return 1",
  8638			.u.insns_int = {
  8639				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8640				BPF_LD_IMM64(R1, 3),
  8641				BPF_JMP_IMM(BPF_JSET, R1, 2, 1),
  8642				BPF_EXIT_INSN(),
  8643				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8644				BPF_EXIT_INSN(),
  8645			},
  8646			INTERNAL,
  8647			{ },
  8648			{ { 0, 1 } },
  8649		},
  8650		{
  8651			"JMP_JSET_K: if (0x3 & 0xffffffff) return 1",
  8652			.u.insns_int = {
  8653				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8654				BPF_LD_IMM64(R1, 3),
  8655				BPF_JMP_IMM(BPF_JSET, R1, 0xffffffff, 1),
  8656				BPF_EXIT_INSN(),
  8657				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8658				BPF_EXIT_INSN(),
  8659			},
  8660			INTERNAL,
  8661			{ },
  8662			{ { 0, 1 } },
  8663		},
  8664		/* BPF_JMP | BPF_JSGT | BPF_X */
  8665		{
  8666			"JMP_JSGT_X: Signed jump: if (-1 > -2) return 1",
  8667			.u.insns_int = {
  8668				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8669				BPF_LD_IMM64(R1, -1),
  8670				BPF_LD_IMM64(R2, -2),
  8671				BPF_JMP_REG(BPF_JSGT, R1, R2, 1),
  8672				BPF_EXIT_INSN(),
  8673				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8674				BPF_EXIT_INSN(),
  8675			},
  8676			INTERNAL,
  8677			{ },
  8678			{ { 0, 1 } },
  8679		},
  8680		{
  8681			"JMP_JSGT_X: Signed jump: if (-1 > -1) return 0",
  8682			.u.insns_int = {
  8683				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8684				BPF_LD_IMM64(R1, -1),
  8685				BPF_LD_IMM64(R2, -1),
  8686				BPF_JMP_REG(BPF_JSGT, R1, R2, 1),
  8687				BPF_EXIT_INSN(),
  8688				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8689				BPF_EXIT_INSN(),
  8690			},
  8691			INTERNAL,
  8692			{ },
  8693			{ { 0, 1 } },
  8694		},
  8695		/* BPF_JMP | BPF_JSLT | BPF_X */
  8696		{
  8697			"JMP_JSLT_X: Signed jump: if (-2 < -1) return 1",
  8698			.u.insns_int = {
  8699				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8700				BPF_LD_IMM64(R1, -1),
  8701				BPF_LD_IMM64(R2, -2),
  8702				BPF_JMP_REG(BPF_JSLT, R2, R1, 1),
  8703				BPF_EXIT_INSN(),
  8704				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8705				BPF_EXIT_INSN(),
  8706			},
  8707			INTERNAL,
  8708			{ },
  8709			{ { 0, 1 } },
  8710		},
  8711		{
  8712			"JMP_JSLT_X: Signed jump: if (-1 < -1) return 0",
  8713			.u.insns_int = {
  8714				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8715				BPF_LD_IMM64(R1, -1),
  8716				BPF_LD_IMM64(R2, -1),
  8717				BPF_JMP_REG(BPF_JSLT, R1, R2, 1),
  8718				BPF_EXIT_INSN(),
  8719				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8720				BPF_EXIT_INSN(),
  8721			},
  8722			INTERNAL,
  8723			{ },
  8724			{ { 0, 1 } },
  8725		},
  8726		/* BPF_JMP | BPF_JSGE | BPF_X */
  8727		{
  8728			"JMP_JSGE_X: Signed jump: if (-1 >= -2) return 1",
  8729			.u.insns_int = {
  8730				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8731				BPF_LD_IMM64(R1, -1),
  8732				BPF_LD_IMM64(R2, -2),
  8733				BPF_JMP_REG(BPF_JSGE, R1, R2, 1),
  8734				BPF_EXIT_INSN(),
  8735				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8736				BPF_EXIT_INSN(),
  8737			},
  8738			INTERNAL,
  8739			{ },
  8740			{ { 0, 1 } },
  8741		},
  8742		{
  8743			"JMP_JSGE_X: Signed jump: if (-1 >= -1) return 1",
  8744			.u.insns_int = {
  8745				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8746				BPF_LD_IMM64(R1, -1),
  8747				BPF_LD_IMM64(R2, -1),
  8748				BPF_JMP_REG(BPF_JSGE, R1, R2, 1),
  8749				BPF_EXIT_INSN(),
  8750				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8751				BPF_EXIT_INSN(),
  8752			},
  8753			INTERNAL,
  8754			{ },
  8755			{ { 0, 1 } },
  8756		},
  8757		/* BPF_JMP | BPF_JSLE | BPF_X */
  8758		{
  8759			"JMP_JSLE_X: Signed jump: if (-2 <= -1) return 1",
  8760			.u.insns_int = {
  8761				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8762				BPF_LD_IMM64(R1, -1),
  8763				BPF_LD_IMM64(R2, -2),
  8764				BPF_JMP_REG(BPF_JSLE, R2, R1, 1),
  8765				BPF_EXIT_INSN(),
  8766				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8767				BPF_EXIT_INSN(),
  8768			},
  8769			INTERNAL,
  8770			{ },
  8771			{ { 0, 1 } },
  8772		},
  8773		{
  8774			"JMP_JSLE_X: Signed jump: if (-1 <= -1) return 1",
  8775			.u.insns_int = {
  8776				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8777				BPF_LD_IMM64(R1, -1),
  8778				BPF_LD_IMM64(R2, -1),
  8779				BPF_JMP_REG(BPF_JSLE, R1, R2, 1),
  8780				BPF_EXIT_INSN(),
  8781				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8782				BPF_EXIT_INSN(),
  8783			},
  8784			INTERNAL,
  8785			{ },
  8786			{ { 0, 1 } },
  8787		},
  8788		/* BPF_JMP | BPF_JGT | BPF_X */
  8789		{
  8790			"JMP_JGT_X: if (3 > 2) return 1",
  8791			.u.insns_int = {
  8792				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8793				BPF_LD_IMM64(R1, 3),
  8794				BPF_LD_IMM64(R2, 2),
  8795				BPF_JMP_REG(BPF_JGT, R1, R2, 1),
  8796				BPF_EXIT_INSN(),
  8797				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8798				BPF_EXIT_INSN(),
  8799			},
  8800			INTERNAL,
  8801			{ },
  8802			{ { 0, 1 } },
  8803		},
  8804		{
  8805			"JMP_JGT_X: Unsigned jump: if (-1 > 1) return 1",
  8806			.u.insns_int = {
  8807				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8808				BPF_LD_IMM64(R1, -1),
  8809				BPF_LD_IMM64(R2, 1),
  8810				BPF_JMP_REG(BPF_JGT, R1, R2, 1),
  8811				BPF_EXIT_INSN(),
  8812				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8813				BPF_EXIT_INSN(),
  8814			},
  8815			INTERNAL,
  8816			{ },
  8817			{ { 0, 1 } },
  8818		},
  8819		/* BPF_JMP | BPF_JLT | BPF_X */
  8820		{
  8821			"JMP_JLT_X: if (2 < 3) return 1",
  8822			.u.insns_int = {
  8823				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8824				BPF_LD_IMM64(R1, 3),
  8825				BPF_LD_IMM64(R2, 2),
  8826				BPF_JMP_REG(BPF_JLT, R2, R1, 1),
  8827				BPF_EXIT_INSN(),
  8828				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8829				BPF_EXIT_INSN(),
  8830			},
  8831			INTERNAL,
  8832			{ },
  8833			{ { 0, 1 } },
  8834		},
  8835		{
  8836			"JMP_JLT_X: Unsigned jump: if (1 < -1) return 1",
  8837			.u.insns_int = {
  8838				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8839				BPF_LD_IMM64(R1, -1),
  8840				BPF_LD_IMM64(R2, 1),
  8841				BPF_JMP_REG(BPF_JLT, R2, R1, 1),
  8842				BPF_EXIT_INSN(),
  8843				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8844				BPF_EXIT_INSN(),
  8845			},
  8846			INTERNAL,
  8847			{ },
  8848			{ { 0, 1 } },
  8849		},
  8850		/* BPF_JMP | BPF_JGE | BPF_X */
  8851		{
  8852			"JMP_JGE_X: if (3 >= 2) return 1",
  8853			.u.insns_int = {
  8854				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8855				BPF_LD_IMM64(R1, 3),
  8856				BPF_LD_IMM64(R2, 2),
  8857				BPF_JMP_REG(BPF_JGE, R1, R2, 1),
  8858				BPF_EXIT_INSN(),
  8859				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8860				BPF_EXIT_INSN(),
  8861			},
  8862			INTERNAL,
  8863			{ },
  8864			{ { 0, 1 } },
  8865		},
  8866		{
  8867			"JMP_JGE_X: if (3 >= 3) return 1",
  8868			.u.insns_int = {
  8869				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8870				BPF_LD_IMM64(R1, 3),
  8871				BPF_LD_IMM64(R2, 3),
  8872				BPF_JMP_REG(BPF_JGE, R1, R2, 1),
  8873				BPF_EXIT_INSN(),
  8874				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8875				BPF_EXIT_INSN(),
  8876			},
  8877			INTERNAL,
  8878			{ },
  8879			{ { 0, 1 } },
  8880		},
  8881		/* BPF_JMP | BPF_JLE | BPF_X */
  8882		{
  8883			"JMP_JLE_X: if (2 <= 3) return 1",
  8884			.u.insns_int = {
  8885				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8886				BPF_LD_IMM64(R1, 3),
  8887				BPF_LD_IMM64(R2, 2),
  8888				BPF_JMP_REG(BPF_JLE, R2, R1, 1),
  8889				BPF_EXIT_INSN(),
  8890				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8891				BPF_EXIT_INSN(),
  8892			},
  8893			INTERNAL,
  8894			{ },
  8895			{ { 0, 1 } },
  8896		},
  8897		{
  8898			"JMP_JLE_X: if (3 <= 3) return 1",
  8899			.u.insns_int = {
  8900				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8901				BPF_LD_IMM64(R1, 3),
  8902				BPF_LD_IMM64(R2, 3),
  8903				BPF_JMP_REG(BPF_JLE, R1, R2, 1),
  8904				BPF_EXIT_INSN(),
  8905				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8906				BPF_EXIT_INSN(),
  8907			},
  8908			INTERNAL,
  8909			{ },
  8910			{ { 0, 1 } },
  8911		},
  8912		{
  8913			/* Mainly testing JIT + imm64 here. */
  8914			"JMP_JGE_X: ldimm64 test 1",
  8915			.u.insns_int = {
  8916				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8917				BPF_LD_IMM64(R1, 3),
  8918				BPF_LD_IMM64(R2, 2),
  8919				BPF_JMP_REG(BPF_JGE, R1, R2, 2),
  8920				BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
  8921				BPF_LD_IMM64(R0, 0xeeeeeeeeeeeeeeeeULL),
  8922				BPF_EXIT_INSN(),
  8923			},
  8924			INTERNAL,
  8925			{ },
  8926			{ { 0, 0xeeeeeeeeU } },
  8927		},
  8928		{
  8929			"JMP_JGE_X: ldimm64 test 2",
  8930			.u.insns_int = {
  8931				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8932				BPF_LD_IMM64(R1, 3),
  8933				BPF_LD_IMM64(R2, 2),
  8934				BPF_JMP_REG(BPF_JGE, R1, R2, 0),
  8935				BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
  8936				BPF_EXIT_INSN(),
  8937			},
  8938			INTERNAL,
  8939			{ },
  8940			{ { 0, 0xffffffffU } },
  8941		},
  8942		{
  8943			"JMP_JGE_X: ldimm64 test 3",
  8944			.u.insns_int = {
  8945				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8946				BPF_LD_IMM64(R1, 3),
  8947				BPF_LD_IMM64(R2, 2),
  8948				BPF_JMP_REG(BPF_JGE, R1, R2, 4),
  8949				BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
  8950				BPF_LD_IMM64(R0, 0xeeeeeeeeeeeeeeeeULL),
  8951				BPF_EXIT_INSN(),
  8952			},
  8953			INTERNAL,
  8954			{ },
  8955			{ { 0, 1 } },
  8956		},
  8957		{
  8958			"JMP_JLE_X: ldimm64 test 1",
  8959			.u.insns_int = {
  8960				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8961				BPF_LD_IMM64(R1, 3),
  8962				BPF_LD_IMM64(R2, 2),
  8963				BPF_JMP_REG(BPF_JLE, R2, R1, 2),
  8964				BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
  8965				BPF_LD_IMM64(R0, 0xeeeeeeeeeeeeeeeeULL),
  8966				BPF_EXIT_INSN(),
  8967			},
  8968			INTERNAL,
  8969			{ },
  8970			{ { 0, 0xeeeeeeeeU } },
  8971		},
  8972		{
  8973			"JMP_JLE_X: ldimm64 test 2",
  8974			.u.insns_int = {
  8975				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8976				BPF_LD_IMM64(R1, 3),
  8977				BPF_LD_IMM64(R2, 2),
  8978				BPF_JMP_REG(BPF_JLE, R2, R1, 0),
  8979				BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
  8980				BPF_EXIT_INSN(),
  8981			},
  8982			INTERNAL,
  8983			{ },
  8984			{ { 0, 0xffffffffU } },
  8985		},
  8986		{
  8987			"JMP_JLE_X: ldimm64 test 3",
  8988			.u.insns_int = {
  8989				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8990				BPF_LD_IMM64(R1, 3),
  8991				BPF_LD_IMM64(R2, 2),
  8992				BPF_JMP_REG(BPF_JLE, R2, R1, 4),
  8993				BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
  8994				BPF_LD_IMM64(R0, 0xeeeeeeeeeeeeeeeeULL),
  8995				BPF_EXIT_INSN(),
  8996			},
  8997			INTERNAL,
  8998			{ },
  8999			{ { 0, 1 } },
  9000		},
  9001		/* BPF_JMP | BPF_JNE | BPF_X */
  9002		{
  9003			"JMP_JNE_X: if (3 != 2) return 1",
  9004			.u.insns_int = {
  9005				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9006				BPF_LD_IMM64(R1, 3),
  9007				BPF_LD_IMM64(R2, 2),
  9008				BPF_JMP_REG(BPF_JNE, R1, R2, 1),
  9009				BPF_EXIT_INSN(),
  9010				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9011				BPF_EXIT_INSN(),
  9012			},
  9013			INTERNAL,
  9014			{ },
  9015			{ { 0, 1 } },
  9016		},
  9017		/* BPF_JMP | BPF_JEQ | BPF_X */
  9018		{
  9019			"JMP_JEQ_X: if (3 == 3) return 1",
  9020			.u.insns_int = {
  9021				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9022				BPF_LD_IMM64(R1, 3),
  9023				BPF_LD_IMM64(R2, 3),
  9024				BPF_JMP_REG(BPF_JEQ, R1, R2, 1),
  9025				BPF_EXIT_INSN(),
  9026				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9027				BPF_EXIT_INSN(),
  9028			},
  9029			INTERNAL,
  9030			{ },
  9031			{ { 0, 1 } },
  9032		},
  9033		/* BPF_JMP | BPF_JSET | BPF_X */
  9034		{
  9035			"JMP_JSET_X: if (0x3 & 0x2) return 1",
  9036			.u.insns_int = {
  9037				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9038				BPF_LD_IMM64(R1, 3),
  9039				BPF_LD_IMM64(R2, 2),
  9040				BPF_JMP_REG(BPF_JSET, R1, R2, 1),
  9041				BPF_EXIT_INSN(),
  9042				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9043				BPF_EXIT_INSN(),
  9044			},
  9045			INTERNAL,
  9046			{ },
  9047			{ { 0, 1 } },
  9048		},
  9049		{
  9050			"JMP_JSET_X: if (0x3 & 0xffffffff) return 1",
  9051			.u.insns_int = {
  9052				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  9053				BPF_LD_IMM64(R1, 3),
  9054				BPF_LD_IMM64(R2, 0xffffffff),
  9055				BPF_JMP_REG(BPF_JSET, R1, R2, 1),
  9056				BPF_EXIT_INSN(),
  9057				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9058				BPF_EXIT_INSN(),
  9059			},
  9060			INTERNAL,
  9061			{ },
  9062			{ { 0, 1 } },
  9063		},
  9064		{
  9065			"JMP_JA: Jump, gap, jump, ...",
  9066			{ },
  9067			CLASSIC | FLAG_NO_DATA,
  9068			{ },
  9069			{ { 0, 0xababcbac } },
  9070			.fill_helper = bpf_fill_ja,
  9071		},
  9072		{	/* Mainly checking JIT here. */
  9073			"BPF_MAXINSNS: Maximum possible literals",
  9074			{ },
  9075			CLASSIC | FLAG_NO_DATA,
  9076			{ },
  9077			{ { 0, 0xffffffff } },
  9078			.fill_helper = bpf_fill_maxinsns1,
  9079		},
  9080		{	/* Mainly checking JIT here. */
  9081			"BPF_MAXINSNS: Single literal",
  9082			{ },
  9083			CLASSIC | FLAG_NO_DATA,
  9084			{ },
  9085			{ { 0, 0xfefefefe } },
  9086			.fill_helper = bpf_fill_maxinsns2,
  9087		},
  9088		{	/* Mainly checking JIT here. */
  9089			"BPF_MAXINSNS: Run/add until end",
  9090			{ },
  9091			CLASSIC | FLAG_NO_DATA,
  9092			{ },
  9093			{ { 0, 0x947bf368 } },
  9094			.fill_helper = bpf_fill_maxinsns3,
  9095		},
  9096		{
  9097			"BPF_MAXINSNS: Too many instructions",
  9098			{ },
  9099			CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
  9100			{ },
  9101			{ },
  9102			.fill_helper = bpf_fill_maxinsns4,
  9103			.expected_errcode = -EINVAL,
  9104		},
  9105		{	/* Mainly checking JIT here. */
  9106			"BPF_MAXINSNS: Very long jump",
  9107			{ },
  9108			CLASSIC | FLAG_NO_DATA,
  9109			{ },
  9110			{ { 0, 0xabababab } },
  9111			.fill_helper = bpf_fill_maxinsns5,
  9112		},
  9113		{	/* Mainly checking JIT here. */
  9114			"BPF_MAXINSNS: Ctx heavy transformations",
  9115			{ },
  9116			CLASSIC,
  9117			{ },
  9118			{
  9119				{  1, SKB_VLAN_PRESENT },
  9120				{ 10, SKB_VLAN_PRESENT }
  9121			},
  9122			.fill_helper = bpf_fill_maxinsns6,
  9123		},
  9124		{	/* Mainly checking JIT here. */
  9125			"BPF_MAXINSNS: Call heavy transformations",
  9126			{ },
  9127			CLASSIC | FLAG_NO_DATA,
  9128			{ },
  9129			{ { 1, 0 }, { 10, 0 } },
  9130			.fill_helper = bpf_fill_maxinsns7,
  9131		},
  9132		{	/* Mainly checking JIT here. */
  9133			"BPF_MAXINSNS: Jump heavy test",
  9134			{ },
  9135			CLASSIC | FLAG_NO_DATA,
  9136			{ },
  9137			{ { 0, 0xffffffff } },
  9138			.fill_helper = bpf_fill_maxinsns8,
  9139		},
  9140		{	/* Mainly checking JIT here. */
  9141			"BPF_MAXINSNS: Very long jump backwards",
  9142			{ },
  9143			INTERNAL | FLAG_NO_DATA,
  9144			{ },
  9145			{ { 0, 0xcbababab } },
  9146			.fill_helper = bpf_fill_maxinsns9,
  9147		},
  9148		{	/* Mainly checking JIT here. */
  9149			"BPF_MAXINSNS: Edge hopping nuthouse",
  9150			{ },
  9151			INTERNAL | FLAG_NO_DATA,
  9152			{ },
  9153			{ { 0, 0xabababac } },
  9154			.fill_helper = bpf_fill_maxinsns10,
  9155		},
  9156		{
  9157			"BPF_MAXINSNS: Jump, gap, jump, ...",
  9158			{ },
  9159			CLASSIC | FLAG_NO_DATA,
  9160			{ },
  9161			{ { 0, 0xababcbac } },
  9162			.fill_helper = bpf_fill_maxinsns11,
  9163		},
  9164		{
  9165			"BPF_MAXINSNS: jump over MSH",
  9166			{ },
  9167			CLASSIC | FLAG_EXPECTED_FAIL,
  9168			{ 0xfa, 0xfb, 0xfc, 0xfd, },
  9169			{ { 4, 0xabababab } },
  9170			.fill_helper = bpf_fill_maxinsns12,
  9171			.expected_errcode = -EINVAL,
  9172		},
  9173		{
  9174			"BPF_MAXINSNS: exec all MSH",
  9175			{ },
  9176			CLASSIC,
  9177			{ 0xfa, 0xfb, 0xfc, 0xfd, },
  9178			{ { 4, 0xababab83 } },
  9179			.fill_helper = bpf_fill_maxinsns13,
  9180		},
  9181		{
  9182			"BPF_MAXINSNS: ld_abs+get_processor_id",
  9183			{ },
  9184			CLASSIC,
  9185			{ },
  9186			{ { 1, 0xbee } },
  9187			.fill_helper = bpf_fill_ld_abs_get_processor_id,
  9188		},
  9189		/*
  9190		 * LD_IND / LD_ABS on fragmented SKBs
  9191		 */
  9192		{
  9193			"LD_IND byte frag",
  9194			.u.insns = {
  9195				BPF_STMT(BPF_LDX | BPF_IMM, 0x40),
  9196				BPF_STMT(BPF_LD | BPF_IND | BPF_B, 0x0),
  9197				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9198			},
  9199			CLASSIC | FLAG_SKB_FRAG,
  9200			{ },
  9201			{ {0x40, 0x42} },
  9202			.frag_data = {
  9203				0x42, 0x00, 0x00, 0x00,
  9204				0x43, 0x44, 0x00, 0x00,
  9205				0x21, 0x07, 0x19, 0x83,
  9206			},
  9207		},
  9208		{
  9209			"LD_IND halfword frag",
  9210			.u.insns = {
  9211				BPF_STMT(BPF_LDX | BPF_IMM, 0x40),
  9212				BPF_STMT(BPF_LD | BPF_IND | BPF_H, 0x4),
  9213				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9214			},
  9215			CLASSIC | FLAG_SKB_FRAG,
  9216			{ },
  9217			{ {0x40, 0x4344} },
  9218			.frag_data = {
  9219				0x42, 0x00, 0x00, 0x00,
  9220				0x43, 0x44, 0x00, 0x00,
  9221				0x21, 0x07, 0x19, 0x83,
  9222			},
  9223		},
  9224		{
  9225			"LD_IND word frag",
  9226			.u.insns = {
  9227				BPF_STMT(BPF_LDX | BPF_IMM, 0x40),
  9228				BPF_STMT(BPF_LD | BPF_IND | BPF_W, 0x8),
  9229				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9230			},
  9231			CLASSIC | FLAG_SKB_FRAG,
  9232			{ },
  9233			{ {0x40, 0x21071983} },
  9234			.frag_data = {
  9235				0x42, 0x00, 0x00, 0x00,
  9236				0x43, 0x44, 0x00, 0x00,
  9237				0x21, 0x07, 0x19, 0x83,
  9238			},
  9239		},
  9240		{
  9241			"LD_IND halfword mixed head/frag",
  9242			.u.insns = {
  9243				BPF_STMT(BPF_LDX | BPF_IMM, 0x40),
  9244				BPF_STMT(BPF_LD | BPF_IND | BPF_H, -0x1),
  9245				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9246			},
  9247			CLASSIC | FLAG_SKB_FRAG,
  9248			{ [0x3e] = 0x25, [0x3f] = 0x05, },
  9249			{ {0x40, 0x0519} },
  9250			.frag_data = { 0x19, 0x82 },
  9251		},
  9252		{
  9253			"LD_IND word mixed head/frag",
  9254			.u.insns = {
  9255				BPF_STMT(BPF_LDX | BPF_IMM, 0x40),
  9256				BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x2),
  9257				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9258			},
  9259			CLASSIC | FLAG_SKB_FRAG,
  9260			{ [0x3e] = 0x25, [0x3f] = 0x05, },
  9261			{ {0x40, 0x25051982} },
  9262			.frag_data = { 0x19, 0x82 },
  9263		},
  9264		{
  9265			"LD_ABS byte frag",
  9266			.u.insns = {
  9267				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, 0x40),
  9268				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9269			},
  9270			CLASSIC | FLAG_SKB_FRAG,
  9271			{ },
  9272			{ {0x40, 0x42} },
  9273			.frag_data = {
  9274				0x42, 0x00, 0x00, 0x00,
  9275				0x43, 0x44, 0x00, 0x00,
  9276				0x21, 0x07, 0x19, 0x83,
  9277			},
  9278		},
  9279		{
  9280			"LD_ABS halfword frag",
  9281			.u.insns = {
  9282				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x44),
  9283				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9284			},
  9285			CLASSIC | FLAG_SKB_FRAG,
  9286			{ },
  9287			{ {0x40, 0x4344} },
  9288			.frag_data = {
  9289				0x42, 0x00, 0x00, 0x00,
  9290				0x43, 0x44, 0x00, 0x00,
  9291				0x21, 0x07, 0x19, 0x83,
  9292			},
  9293		},
  9294		{
  9295			"LD_ABS word frag",
  9296			.u.insns = {
  9297				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x48),
  9298				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9299			},
  9300			CLASSIC | FLAG_SKB_FRAG,
  9301			{ },
  9302			{ {0x40, 0x21071983} },
  9303			.frag_data = {
  9304				0x42, 0x00, 0x00, 0x00,
  9305				0x43, 0x44, 0x00, 0x00,
  9306				0x21, 0x07, 0x19, 0x83,
  9307			},
  9308		},
  9309		{
  9310			"LD_ABS halfword mixed head/frag",
  9311			.u.insns = {
  9312				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x3f),
  9313				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9314			},
  9315			CLASSIC | FLAG_SKB_FRAG,
  9316			{ [0x3e] = 0x25, [0x3f] = 0x05, },
  9317			{ {0x40, 0x0519} },
  9318			.frag_data = { 0x19, 0x82 },
  9319		},
  9320		{
  9321			"LD_ABS word mixed head/frag",
  9322			.u.insns = {
  9323				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x3e),
  9324				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9325			},
  9326			CLASSIC | FLAG_SKB_FRAG,
  9327			{ [0x3e] = 0x25, [0x3f] = 0x05, },
  9328			{ {0x40, 0x25051982} },
  9329			.frag_data = { 0x19, 0x82 },
  9330		},
  9331		/*
  9332		 * LD_IND / LD_ABS on non fragmented SKBs
  9333		 */
  9334		{
  9335			/*
  9336			 * this tests that the JIT/interpreter correctly resets X
  9337			 * before using it in an LD_IND instruction.
  9338			 */
  9339			"LD_IND byte default X",
  9340			.u.insns = {
  9341				BPF_STMT(BPF_LD | BPF_IND | BPF_B, 0x1),
  9342				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9343			},
  9344			CLASSIC,
  9345			{ [0x1] = 0x42 },
  9346			{ {0x40, 0x42 } },
  9347		},
  9348		{
  9349			"LD_IND byte positive offset",
  9350			.u.insns = {
  9351				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9352				BPF_STMT(BPF_LD | BPF_IND | BPF_B, 0x1),
  9353				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9354			},
  9355			CLASSIC,
  9356			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9357			{ {0x40, 0x82 } },
  9358		},
  9359		{
  9360			"LD_IND byte negative offset",
  9361			.u.insns = {
  9362				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9363				BPF_STMT(BPF_LD | BPF_IND | BPF_B, -0x1),
  9364				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9365			},
  9366			CLASSIC,
  9367			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9368			{ {0x40, 0x05 } },
  9369		},
  9370		{
  9371			"LD_IND byte positive offset, all ff",
  9372			.u.insns = {
  9373				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9374				BPF_STMT(BPF_LD | BPF_IND | BPF_B, 0x1),
  9375				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9376			},
  9377			CLASSIC,
  9378			{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
  9379			{ {0x40, 0xff } },
  9380		},
  9381		{
  9382			"LD_IND byte positive offset, out of bounds",
  9383			.u.insns = {
  9384				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9385				BPF_STMT(BPF_LD | BPF_IND | BPF_B, 0x1),
  9386				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9387			},
  9388			CLASSIC,
  9389			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9390			{ {0x3f, 0 }, },
  9391		},
  9392		{
  9393			"LD_IND byte negative offset, out of bounds",
  9394			.u.insns = {
  9395				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9396				BPF_STMT(BPF_LD | BPF_IND | BPF_B, -0x3f),
  9397				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9398			},
  9399			CLASSIC,
  9400			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9401			{ {0x3f, 0 } },
  9402		},
  9403		{
  9404			"LD_IND byte negative offset, multiple calls",
  9405			.u.insns = {
  9406				BPF_STMT(BPF_LDX | BPF_IMM, 0x3b),
  9407				BPF_STMT(BPF_LD | BPF_IND | BPF_B, SKF_LL_OFF + 1),
  9408				BPF_STMT(BPF_LD | BPF_IND | BPF_B, SKF_LL_OFF + 2),
  9409				BPF_STMT(BPF_LD | BPF_IND | BPF_B, SKF_LL_OFF + 3),
  9410				BPF_STMT(BPF_LD | BPF_IND | BPF_B, SKF_LL_OFF + 4),
  9411				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9412			},
  9413			CLASSIC,
  9414			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9415			{ {0x40, 0x82 }, },
  9416		},
  9417		{
  9418			"LD_IND halfword positive offset",
  9419			.u.insns = {
  9420				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  9421				BPF_STMT(BPF_LD | BPF_IND | BPF_H, 0x2),
  9422				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9423			},
  9424			CLASSIC,
  9425			{
  9426				[0x1c] = 0xaa, [0x1d] = 0x55,
  9427				[0x1e] = 0xbb, [0x1f] = 0x66,
  9428				[0x20] = 0xcc, [0x21] = 0x77,
  9429				[0x22] = 0xdd, [0x23] = 0x88,
  9430			},
  9431			{ {0x40, 0xdd88 } },
  9432		},
  9433		{
  9434			"LD_IND halfword negative offset",
  9435			.u.insns = {
  9436				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  9437				BPF_STMT(BPF_LD | BPF_IND | BPF_H, -0x2),
  9438				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9439			},
  9440			CLASSIC,
  9441			{
  9442				[0x1c] = 0xaa, [0x1d] = 0x55,
  9443				[0x1e] = 0xbb, [0x1f] = 0x66,
  9444				[0x20] = 0xcc, [0x21] = 0x77,
  9445				[0x22] = 0xdd, [0x23] = 0x88,
  9446			},
  9447			{ {0x40, 0xbb66 } },
  9448		},
  9449		{
  9450			"LD_IND halfword unaligned",
  9451			.u.insns = {
  9452				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  9453				BPF_STMT(BPF_LD | BPF_IND | BPF_H, -0x1),
  9454				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9455			},
  9456			CLASSIC,
  9457			{
  9458				[0x1c] = 0xaa, [0x1d] = 0x55,
  9459				[0x1e] = 0xbb, [0x1f] = 0x66,
  9460				[0x20] = 0xcc, [0x21] = 0x77,
  9461				[0x22] = 0xdd, [0x23] = 0x88,
  9462			},
  9463			{ {0x40, 0x66cc } },
  9464		},
  9465		{
  9466			"LD_IND halfword positive offset, all ff",
  9467			.u.insns = {
  9468				BPF_STMT(BPF_LDX | BPF_IMM, 0x3d),
  9469				BPF_STMT(BPF_LD | BPF_IND | BPF_H, 0x1),
  9470				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9471			},
  9472			CLASSIC,
  9473			{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
  9474			{ {0x40, 0xffff } },
  9475		},
  9476		{
  9477			"LD_IND halfword positive offset, out of bounds",
  9478			.u.insns = {
  9479				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9480				BPF_STMT(BPF_LD | BPF_IND | BPF_H, 0x1),
  9481				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9482			},
  9483			CLASSIC,
  9484			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9485			{ {0x3f, 0 }, },
  9486		},
  9487		{
  9488			"LD_IND halfword negative offset, out of bounds",
  9489			.u.insns = {
  9490				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9491				BPF_STMT(BPF_LD | BPF_IND | BPF_H, -0x3f),
  9492				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9493			},
  9494			CLASSIC,
  9495			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9496			{ {0x3f, 0 } },
  9497		},
  9498		{
  9499			"LD_IND word positive offset",
  9500			.u.insns = {
  9501				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  9502				BPF_STMT(BPF_LD | BPF_IND | BPF_W, 0x4),
  9503				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9504			},
  9505			CLASSIC,
  9506			{
  9507				[0x1c] = 0xaa, [0x1d] = 0x55,
  9508				[0x1e] = 0xbb, [0x1f] = 0x66,
  9509				[0x20] = 0xcc, [0x21] = 0x77,
  9510				[0x22] = 0xdd, [0x23] = 0x88,
  9511				[0x24] = 0xee, [0x25] = 0x99,
  9512				[0x26] = 0xff, [0x27] = 0xaa,
  9513			},
  9514			{ {0x40, 0xee99ffaa } },
  9515		},
  9516		{
  9517			"LD_IND word negative offset",
  9518			.u.insns = {
  9519				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  9520				BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x4),
  9521				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9522			},
  9523			CLASSIC,
  9524			{
  9525				[0x1c] = 0xaa, [0x1d] = 0x55,
  9526				[0x1e] = 0xbb, [0x1f] = 0x66,
  9527				[0x20] = 0xcc, [0x21] = 0x77,
  9528				[0x22] = 0xdd, [0x23] = 0x88,
  9529				[0x24] = 0xee, [0x25] = 0x99,
  9530				[0x26] = 0xff, [0x27] = 0xaa,
  9531			},
  9532			{ {0x40, 0xaa55bb66 } },
  9533		},
  9534		{
  9535			"LD_IND word unaligned (addr & 3 == 2)",
  9536			.u.insns = {
  9537				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  9538				BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x2),
  9539				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9540			},
  9541			CLASSIC,
  9542			{
  9543				[0x1c] = 0xaa, [0x1d] = 0x55,
  9544				[0x1e] = 0xbb, [0x1f] = 0x66,
  9545				[0x20] = 0xcc, [0x21] = 0x77,
  9546				[0x22] = 0xdd, [0x23] = 0x88,
  9547				[0x24] = 0xee, [0x25] = 0x99,
  9548				[0x26] = 0xff, [0x27] = 0xaa,
  9549			},
  9550			{ {0x40, 0xbb66cc77 } },
  9551		},
  9552		{
  9553			"LD_IND word unaligned (addr & 3 == 1)",
  9554			.u.insns = {
  9555				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  9556				BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x3),
  9557				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9558			},
  9559			CLASSIC,
  9560			{
  9561				[0x1c] = 0xaa, [0x1d] = 0x55,
  9562				[0x1e] = 0xbb, [0x1f] = 0x66,
  9563				[0x20] = 0xcc, [0x21] = 0x77,
  9564				[0x22] = 0xdd, [0x23] = 0x88,
  9565				[0x24] = 0xee, [0x25] = 0x99,
  9566				[0x26] = 0xff, [0x27] = 0xaa,
  9567			},
  9568			{ {0x40, 0x55bb66cc } },
  9569		},
  9570		{
  9571			"LD_IND word unaligned (addr & 3 == 3)",
  9572			.u.insns = {
  9573				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  9574				BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x1),
  9575				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9576			},
  9577			CLASSIC,
  9578			{
  9579				[0x1c] = 0xaa, [0x1d] = 0x55,
  9580				[0x1e] = 0xbb, [0x1f] = 0x66,
  9581				[0x20] = 0xcc, [0x21] = 0x77,
  9582				[0x22] = 0xdd, [0x23] = 0x88,
  9583				[0x24] = 0xee, [0x25] = 0x99,
  9584				[0x26] = 0xff, [0x27] = 0xaa,
  9585			},
  9586			{ {0x40, 0x66cc77dd } },
  9587		},
  9588		{
  9589			"LD_IND word positive offset, all ff",
  9590			.u.insns = {
  9591				BPF_STMT(BPF_LDX | BPF_IMM, 0x3b),
  9592				BPF_STMT(BPF_LD | BPF_IND | BPF_W, 0x1),
  9593				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9594			},
  9595			CLASSIC,
  9596			{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
  9597			{ {0x40, 0xffffffff } },
  9598		},
  9599		{
  9600			"LD_IND word positive offset, out of bounds",
  9601			.u.insns = {
  9602				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9603				BPF_STMT(BPF_LD | BPF_IND | BPF_W, 0x1),
  9604				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9605			},
  9606			CLASSIC,
  9607			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9608			{ {0x3f, 0 }, },
  9609		},
  9610		{
  9611			"LD_IND word negative offset, out of bounds",
  9612			.u.insns = {
  9613				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9614				BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x3f),
  9615				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9616			},
  9617			CLASSIC,
  9618			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9619			{ {0x3f, 0 } },
  9620		},
  9621		{
  9622			"LD_ABS byte",
  9623			.u.insns = {
  9624				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, 0x20),
  9625				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9626			},
  9627			CLASSIC,
  9628			{
  9629				[0x1c] = 0xaa, [0x1d] = 0x55,
  9630				[0x1e] = 0xbb, [0x1f] = 0x66,
  9631				[0x20] = 0xcc, [0x21] = 0x77,
  9632				[0x22] = 0xdd, [0x23] = 0x88,
  9633				[0x24] = 0xee, [0x25] = 0x99,
  9634				[0x26] = 0xff, [0x27] = 0xaa,
  9635			},
  9636			{ {0x40, 0xcc } },
  9637		},
  9638		{
  9639			"LD_ABS byte positive offset, all ff",
  9640			.u.insns = {
  9641				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, 0x3f),
  9642				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9643			},
  9644			CLASSIC,
  9645			{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
  9646			{ {0x40, 0xff } },
  9647		},
  9648		{
  9649			"LD_ABS byte positive offset, out of bounds",
  9650			.u.insns = {
  9651				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, 0x3f),
  9652				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9653			},
  9654			CLASSIC,
  9655			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9656			{ {0x3f, 0 }, },
  9657		},
  9658		{
  9659			"LD_ABS byte negative offset, out of bounds load",
  9660			.u.insns = {
  9661				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, -1),
  9662				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9663			},
  9664			CLASSIC | FLAG_EXPECTED_FAIL,
  9665			.expected_errcode = -EINVAL,
  9666		},
  9667		{
  9668			"LD_ABS byte negative offset, in bounds",
  9669			.u.insns = {
  9670				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3f),
  9671				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9672			},
  9673			CLASSIC,
  9674			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9675			{ {0x40, 0x82 }, },
  9676		},
  9677		{
  9678			"LD_ABS byte negative offset, out of bounds",
  9679			.u.insns = {
  9680				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3f),
  9681				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9682			},
  9683			CLASSIC,
  9684			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9685			{ {0x3f, 0 }, },
  9686		},
  9687		{
  9688			"LD_ABS byte negative offset, multiple calls",
  9689			.u.insns = {
  9690				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3c),
  9691				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3d),
  9692				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3e),
  9693				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3f),
  9694				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9695			},
  9696			CLASSIC,
  9697			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9698			{ {0x40, 0x82 }, },
  9699		},
  9700		{
  9701			"LD_ABS halfword",
  9702			.u.insns = {
  9703				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x22),
  9704				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9705			},
  9706			CLASSIC,
  9707			{
  9708				[0x1c] = 0xaa, [0x1d] = 0x55,
  9709				[0x1e] = 0xbb, [0x1f] = 0x66,
  9710				[0x20] = 0xcc, [0x21] = 0x77,
  9711				[0x22] = 0xdd, [0x23] = 0x88,
  9712				[0x24] = 0xee, [0x25] = 0x99,
  9713				[0x26] = 0xff, [0x27] = 0xaa,
  9714			},
  9715			{ {0x40, 0xdd88 } },
  9716		},
  9717		{
  9718			"LD_ABS halfword unaligned",
  9719			.u.insns = {
  9720				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x25),
  9721				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9722			},
  9723			CLASSIC,
  9724			{
  9725				[0x1c] = 0xaa, [0x1d] = 0x55,
  9726				[0x1e] = 0xbb, [0x1f] = 0x66,
  9727				[0x20] = 0xcc, [0x21] = 0x77,
  9728				[0x22] = 0xdd, [0x23] = 0x88,
  9729				[0x24] = 0xee, [0x25] = 0x99,
  9730				[0x26] = 0xff, [0x27] = 0xaa,
  9731			},
  9732			{ {0x40, 0x99ff } },
  9733		},
  9734		{
  9735			"LD_ABS halfword positive offset, all ff",
  9736			.u.insns = {
  9737				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x3e),
  9738				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9739			},
  9740			CLASSIC,
  9741			{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
  9742			{ {0x40, 0xffff } },
  9743		},
  9744		{
  9745			"LD_ABS halfword positive offset, out of bounds",
  9746			.u.insns = {
  9747				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x3f),
  9748				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9749			},
  9750			CLASSIC,
  9751			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9752			{ {0x3f, 0 }, },
  9753		},
  9754		{
  9755			"LD_ABS halfword negative offset, out of bounds load",
  9756			.u.insns = {
  9757				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, -1),
  9758				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9759			},
  9760			CLASSIC | FLAG_EXPECTED_FAIL,
  9761			.expected_errcode = -EINVAL,
  9762		},
  9763		{
  9764			"LD_ABS halfword negative offset, in bounds",
  9765			.u.insns = {
  9766				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, SKF_LL_OFF + 0x3e),
  9767				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9768			},
  9769			CLASSIC,
  9770			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9771			{ {0x40, 0x1982 }, },
  9772		},
  9773		{
  9774			"LD_ABS halfword negative offset, out of bounds",
  9775			.u.insns = {
  9776				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, SKF_LL_OFF + 0x3e),
  9777				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9778			},
  9779			CLASSIC,
  9780			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9781			{ {0x3f, 0 }, },
  9782		},
  9783		{
  9784			"LD_ABS word",
  9785			.u.insns = {
  9786				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x1c),
  9787				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9788			},
  9789			CLASSIC,
  9790			{
  9791				[0x1c] = 0xaa, [0x1d] = 0x55,
  9792				[0x1e] = 0xbb, [0x1f] = 0x66,
  9793				[0x20] = 0xcc, [0x21] = 0x77,
  9794				[0x22] = 0xdd, [0x23] = 0x88,
  9795				[0x24] = 0xee, [0x25] = 0x99,
  9796				[0x26] = 0xff, [0x27] = 0xaa,
  9797			},
  9798			{ {0x40, 0xaa55bb66 } },
  9799		},
  9800		{
  9801			"LD_ABS word unaligned (addr & 3 == 2)",
  9802			.u.insns = {
  9803				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x22),
  9804				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9805			},
  9806			CLASSIC,
  9807			{
  9808				[0x1c] = 0xaa, [0x1d] = 0x55,
  9809				[0x1e] = 0xbb, [0x1f] = 0x66,
  9810				[0x20] = 0xcc, [0x21] = 0x77,
  9811				[0x22] = 0xdd, [0x23] = 0x88,
  9812				[0x24] = 0xee, [0x25] = 0x99,
  9813				[0x26] = 0xff, [0x27] = 0xaa,
  9814			},
  9815			{ {0x40, 0xdd88ee99 } },
  9816		},
  9817		{
  9818			"LD_ABS word unaligned (addr & 3 == 1)",
  9819			.u.insns = {
  9820				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x21),
  9821				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9822			},
  9823			CLASSIC,
  9824			{
  9825				[0x1c] = 0xaa, [0x1d] = 0x55,
  9826				[0x1e] = 0xbb, [0x1f] = 0x66,
  9827				[0x20] = 0xcc, [0x21] = 0x77,
  9828				[0x22] = 0xdd, [0x23] = 0x88,
  9829				[0x24] = 0xee, [0x25] = 0x99,
  9830				[0x26] = 0xff, [0x27] = 0xaa,
  9831			},
  9832			{ {0x40, 0x77dd88ee } },
  9833		},
  9834		{
  9835			"LD_ABS word unaligned (addr & 3 == 3)",
  9836			.u.insns = {
  9837				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x23),
  9838				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9839			},
  9840			CLASSIC,
  9841			{
  9842				[0x1c] = 0xaa, [0x1d] = 0x55,
  9843				[0x1e] = 0xbb, [0x1f] = 0x66,
  9844				[0x20] = 0xcc, [0x21] = 0x77,
  9845				[0x22] = 0xdd, [0x23] = 0x88,
  9846				[0x24] = 0xee, [0x25] = 0x99,
  9847				[0x26] = 0xff, [0x27] = 0xaa,
  9848			},
  9849			{ {0x40, 0x88ee99ff } },
  9850		},
  9851		{
  9852			"LD_ABS word positive offset, all ff",
  9853			.u.insns = {
  9854				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x3c),
  9855				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9856			},
  9857			CLASSIC,
  9858			{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
  9859			{ {0x40, 0xffffffff } },
  9860		},
  9861		{
  9862			"LD_ABS word positive offset, out of bounds",
  9863			.u.insns = {
  9864				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x3f),
  9865				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9866			},
  9867			CLASSIC,
  9868			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9869			{ {0x3f, 0 }, },
  9870		},
  9871		{
  9872			"LD_ABS word negative offset, out of bounds load",
  9873			.u.insns = {
  9874				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, -1),
  9875				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9876			},
  9877			CLASSIC | FLAG_EXPECTED_FAIL,
  9878			.expected_errcode = -EINVAL,
  9879		},
  9880		{
  9881			"LD_ABS word negative offset, in bounds",
  9882			.u.insns = {
  9883				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, SKF_LL_OFF + 0x3c),
  9884				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9885			},
  9886			CLASSIC,
  9887			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9888			{ {0x40, 0x25051982 }, },
  9889		},
  9890		{
  9891			"LD_ABS word negative offset, out of bounds",
  9892			.u.insns = {
  9893				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, SKF_LL_OFF + 0x3c),
  9894				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9895			},
  9896			CLASSIC,
  9897			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9898			{ {0x3f, 0 }, },
  9899		},
  9900		{
  9901			"LDX_MSH standalone, preserved A",
  9902			.u.insns = {
  9903				BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
  9904				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3c),
  9905				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9906			},
  9907			CLASSIC,
  9908			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9909			{ {0x40, 0xffeebbaa }, },
  9910		},
  9911		{
  9912			"LDX_MSH standalone, preserved A 2",
  9913			.u.insns = {
  9914				BPF_STMT(BPF_LD | BPF_IMM, 0x175e9d63),
  9915				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3c),
  9916				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3d),
  9917				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3e),
  9918				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3f),
  9919				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9920			},
  9921			CLASSIC,
  9922			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9923			{ {0x40, 0x175e9d63 }, },
  9924		},
  9925		{
  9926			"LDX_MSH standalone, test result 1",
  9927			.u.insns = {
  9928				BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
  9929				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3c),
  9930				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  9931				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9932			},
  9933			CLASSIC,
  9934			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9935			{ {0x40, 0x14 }, },
  9936		},
  9937		{
  9938			"LDX_MSH standalone, test result 2",
  9939			.u.insns = {
  9940				BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
  9941				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3e),
  9942				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  9943				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9944			},
  9945			CLASSIC,
  9946			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9947			{ {0x40, 0x24 }, },
  9948		},
  9949		{
  9950			"LDX_MSH standalone, negative offset",
  9951			.u.insns = {
  9952				BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
  9953				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, -1),
  9954				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  9955				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9956			},
  9957			CLASSIC,
  9958			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9959			{ {0x40, 0 }, },
  9960		},
  9961		{
  9962			"LDX_MSH standalone, negative offset 2",
  9963			.u.insns = {
  9964				BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
  9965				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, SKF_LL_OFF + 0x3e),
  9966				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  9967				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9968			},
  9969			CLASSIC,
  9970			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9971			{ {0x40, 0x24 }, },
  9972		},
  9973		{
  9974			"LDX_MSH standalone, out of bounds",
  9975			.u.insns = {
  9976				BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
  9977				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x40),
  9978				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  9979				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9980			},
  9981			CLASSIC,
  9982			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9983			{ {0x40, 0 }, },
  9984		},
  9985		/*
  9986		 * verify that the interpreter or JIT correctly sets A and X
  9987		 * to 0.
  9988		 */
  9989		{
  9990			"ADD default X",
  9991			.u.insns = {
  9992				/*
  9993				 * A = 0x42
  9994				 * A = A + X
  9995				 * ret A
  9996				 */
  9997				BPF_STMT(BPF_LD | BPF_IMM, 0x42),
  9998				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  9999				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10000			},
 10001			CLASSIC | FLAG_NO_DATA,
 10002			{},
 10003			{ {0x1, 0x42 } },
 10004		},
 10005		{
 10006			"ADD default A",
 10007			.u.insns = {
 10008				/*
 10009				 * A = A + 0x42
 10010				 * ret A
 10011				 */
 10012				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 0x42),
 10013				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10014			},
 10015			CLASSIC | FLAG_NO_DATA,
 10016			{},
 10017			{ {0x1, 0x42 } },
 10018		},
 10019		{
 10020			"SUB default X",
 10021			.u.insns = {
 10022				/*
 10023				 * A = 0x66
 10024				 * A = A - X
 10025				 * ret A
 10026				 */
 10027				BPF_STMT(BPF_LD | BPF_IMM, 0x66),
 10028				BPF_STMT(BPF_ALU | BPF_SUB | BPF_X, 0),
 10029				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10030			},
 10031			CLASSIC | FLAG_NO_DATA,
 10032			{},
 10033			{ {0x1, 0x66 } },
 10034		},
 10035		{
 10036			"SUB default A",
 10037			.u.insns = {
 10038				/*
 10039				 * A = A - -0x66
 10040				 * ret A
 10041				 */
 10042				BPF_STMT(BPF_ALU | BPF_SUB | BPF_K, -0x66),
 10043				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10044			},
 10045			CLASSIC | FLAG_NO_DATA,
 10046			{},
 10047			{ {0x1, 0x66 } },
 10048		},
 10049		{
 10050			"MUL default X",
 10051			.u.insns = {
 10052				/*
 10053				 * A = 0x42
 10054				 * A = A * X
 10055				 * ret A
 10056				 */
 10057				BPF_STMT(BPF_LD | BPF_IMM, 0x42),
 10058				BPF_STMT(BPF_ALU | BPF_MUL | BPF_X, 0),
 10059				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10060			},
 10061			CLASSIC | FLAG_NO_DATA,
 10062			{},
 10063			{ {0x1, 0x0 } },
 10064		},
 10065		{
 10066			"MUL default A",
 10067			.u.insns = {
 10068				/*
 10069				 * A = A * 0x66
 10070				 * ret A
 10071				 */
 10072				BPF_STMT(BPF_ALU | BPF_MUL | BPF_K, 0x66),
 10073				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10074			},
 10075			CLASSIC | FLAG_NO_DATA,
 10076			{},
 10077			{ {0x1, 0x0 } },
 10078		},
 10079		{
 10080			"DIV default X",
 10081			.u.insns = {
 10082				/*
 10083				 * A = 0x42
 10084				 * A = A / X ; this halt the filter execution if X is 0
 10085				 * ret 0x42
 10086				 */
 10087				BPF_STMT(BPF_LD | BPF_IMM, 0x42),
 10088				BPF_STMT(BPF_ALU | BPF_DIV | BPF_X, 0),
 10089				BPF_STMT(BPF_RET | BPF_K, 0x42),
 10090			},
 10091			CLASSIC | FLAG_NO_DATA,
 10092			{},
 10093			{ {0x1, 0x0 } },
 10094		},
 10095		{
 10096			"DIV default A",
 10097			.u.insns = {
 10098				/*
 10099				 * A = A / 1
 10100				 * ret A
 10101				 */
 10102				BPF_STMT(BPF_ALU | BPF_DIV | BPF_K, 0x1),
 10103				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10104			},
 10105			CLASSIC | FLAG_NO_DATA,
 10106			{},
 10107			{ {0x1, 0x0 } },
 10108		},
 10109		{
 10110			"MOD default X",
 10111			.u.insns = {
 10112				/*
 10113				 * A = 0x42
 10114				 * A = A mod X ; this halt the filter execution if X is 0
 10115				 * ret 0x42
 10116				 */
 10117				BPF_STMT(BPF_LD | BPF_IMM, 0x42),
 10118				BPF_STMT(BPF_ALU | BPF_MOD | BPF_X, 0),
 10119				BPF_STMT(BPF_RET | BPF_K, 0x42),
 10120			},
 10121			CLASSIC | FLAG_NO_DATA,
 10122			{},
 10123			{ {0x1, 0x0 } },
 10124		},
 10125		{
 10126			"MOD default A",
 10127			.u.insns = {
 10128				/*
 10129				 * A = A mod 1
 10130				 * ret A
 10131				 */
 10132				BPF_STMT(BPF_ALU | BPF_MOD | BPF_K, 0x1),
 10133				BPF_STMT(BPF_RET | BPF_A, 0x0),
 10134			},
 10135			CLASSIC | FLAG_NO_DATA,
 10136			{},
 10137			{ {0x1, 0x0 } },
 10138		},
 10139		{
 10140			"JMP EQ default A",
 10141			.u.insns = {
 10142				/*
 10143				 * cmp A, 0x0, 0, 1
 10144				 * ret 0x42
 10145				 * ret 0x66
 10146				 */
 10147				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x0, 0, 1),
 10148				BPF_STMT(BPF_RET | BPF_K, 0x42),
 10149				BPF_STMT(BPF_RET | BPF_K, 0x66),
 10150			},
 10151			CLASSIC | FLAG_NO_DATA,
 10152			{},
 10153			{ {0x1, 0x42 } },
 10154		},
 10155		{
 10156			"JMP EQ default X",
 10157			.u.insns = {
 10158				/*
 10159				 * A = 0x0
 10160				 * cmp A, X, 0, 1
 10161				 * ret 0x42
 10162				 * ret 0x66
 10163				 */
 10164				BPF_STMT(BPF_LD | BPF_IMM, 0x0),
 10165				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_X, 0x0, 0, 1),
 10166				BPF_STMT(BPF_RET | BPF_K, 0x42),
 10167				BPF_STMT(BPF_RET | BPF_K, 0x66),
 10168			},
 10169			CLASSIC | FLAG_NO_DATA,
 10170			{},
 10171			{ {0x1, 0x42 } },
 10172		},
 10173		/* Checking interpreter vs JIT wrt signed extended imms. */
 10174		{
 10175			"JNE signed compare, test 1",
 10176			.u.insns_int = {
 10177				BPF_ALU32_IMM(BPF_MOV, R1, 0xfefbbc12),
 10178				BPF_ALU32_IMM(BPF_MOV, R3, 0xffff0000),
 10179				BPF_MOV64_REG(R2, R1),
 10180				BPF_ALU64_REG(BPF_AND, R2, R3),
 10181				BPF_ALU32_IMM(BPF_MOV, R0, 1),
 10182				BPF_JMP_IMM(BPF_JNE, R2, -17104896, 1),
 10183				BPF_ALU32_IMM(BPF_MOV, R0, 2),
 10184				BPF_EXIT_INSN(),
 10185			},
 10186			INTERNAL,
 10187			{ },
 10188			{ { 0, 1 } },
 10189		},
 10190		{
 10191			"JNE signed compare, test 2",
 10192			.u.insns_int = {
 10193				BPF_ALU32_IMM(BPF_MOV, R1, 0xfefbbc12),
 10194				BPF_ALU32_IMM(BPF_MOV, R3, 0xffff0000),
 10195				BPF_MOV64_REG(R2, R1),
 10196				BPF_ALU64_REG(BPF_AND, R2, R3),
 10197				BPF_ALU32_IMM(BPF_MOV, R0, 1),
 10198				BPF_JMP_IMM(BPF_JNE, R2, 0xfefb0000, 1),
 10199				BPF_ALU32_IMM(BPF_MOV, R0, 2),
 10200				BPF_EXIT_INSN(),
 10201			},
 10202			INTERNAL,
 10203			{ },
 10204			{ { 0, 1 } },
 10205		},
 10206		{
 10207			"JNE signed compare, test 3",
 10208			.u.insns_int = {
 10209				BPF_ALU32_IMM(BPF_MOV, R1, 0xfefbbc12),
 10210				BPF_ALU32_IMM(BPF_MOV, R3, 0xffff0000),
 10211				BPF_ALU32_IMM(BPF_MOV, R4, 0xfefb0000),
 10212				BPF_MOV64_REG(R2, R1),
 10213				BPF_ALU64_REG(BPF_AND, R2, R3),
 10214				BPF_ALU32_IMM(BPF_MOV, R0, 1),
 10215				BPF_JMP_REG(BPF_JNE, R2, R4, 1),
 10216				BPF_ALU32_IMM(BPF_MOV, R0, 2),
 10217				BPF_EXIT_INSN(),
 10218			},
 10219			INTERNAL,
 10220			{ },
 10221			{ { 0, 2 } },
 10222		},
 10223		{
 10224			"JNE signed compare, test 4",
 10225			.u.insns_int = {
 10226				BPF_LD_IMM64(R1, -17104896),
 10227				BPF_ALU32_IMM(BPF_MOV, R0, 1),
 10228				BPF_JMP_IMM(BPF_JNE, R1, -17104896, 1),
 10229				BPF_ALU32_IMM(BPF_MOV, R0, 2),
 10230				BPF_EXIT_INSN(),
 10231			},
 10232			INTERNAL,
 10233			{ },
 10234			{ { 0, 2 } },
 10235		},
 10236		{
 10237			"JNE signed compare, test 5",
 10238			.u.insns_int = {
 10239				BPF_LD_IMM64(R1, 0xfefb0000),
 10240				BPF_ALU32_IMM(BPF_MOV, R0, 1),
 10241				BPF_JMP_IMM(BPF_JNE, R1, 0xfefb0000, 1),
 10242				BPF_ALU32_IMM(BPF_MOV, R0, 2),
 10243				BPF_EXIT_INSN(),
 10244			},
 10245			INTERNAL,
 10246			{ },
 10247			{ { 0, 1 } },
 10248		},
 10249		{
 10250			"JNE signed compare, test 6",
 10251			.u.insns_int = {
 10252				BPF_LD_IMM64(R1, 0x7efb0000),
 10253				BPF_ALU32_IMM(BPF_MOV, R0, 1),
 10254				BPF_JMP_IMM(BPF_JNE, R1, 0x7efb0000, 1),
 10255				BPF_ALU32_IMM(BPF_MOV, R0, 2),
 10256				BPF_EXIT_INSN(),
 10257			},
 10258			INTERNAL,
 10259			{ },
 10260			{ { 0, 2 } },
 10261		},
 10262		{
 10263			"JNE signed compare, test 7",
 10264			.u.insns = {
 10265				BPF_STMT(BPF_LD | BPF_IMM, 0xffff0000),
 10266				BPF_STMT(BPF_MISC | BPF_TAX, 0),
 10267				BPF_STMT(BPF_LD | BPF_IMM, 0xfefbbc12),
 10268				BPF_STMT(BPF_ALU | BPF_AND | BPF_X, 0),
 10269				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0xfefb0000, 1, 0),
 10270				BPF_STMT(BPF_RET | BPF_K, 1),
 10271				BPF_STMT(BPF_RET | BPF_K, 2),
 10272			},
 10273			CLASSIC | FLAG_NO_DATA,
 10274			{},
 10275			{ { 0, 2 } },
 10276		},
 10277		/* Exhaustive test of ALU64 shift operations */
 10278		{
 10279			"ALU64_LSH_K: all shift values",
 10280			{ },
 10281			INTERNAL | FLAG_NO_DATA,
 10282			{ },
 10283			{ { 0, 1 } },
 10284			.fill_helper = bpf_fill_alu_lsh_imm,
 10285		},
 10286		{
 10287			"ALU64_RSH_K: all shift values",
 10288			{ },
 10289			INTERNAL | FLAG_NO_DATA,
 10290			{ },
 10291			{ { 0, 1 } },
 10292			.fill_helper = bpf_fill_alu_rsh_imm,
 10293		},
 10294		{
 10295			"ALU64_ARSH_K: all shift values",
 10296			{ },
 10297			INTERNAL | FLAG_NO_DATA,
 10298			{ },
 10299			{ { 0, 1 } },
 10300			.fill_helper = bpf_fill_alu_arsh_imm,
 10301		},
 10302		{
 10303			"ALU64_LSH_X: all shift values",
 10304			{ },
 10305			INTERNAL | FLAG_NO_DATA,
 10306			{ },
 10307			{ { 0, 1 } },
 10308			.fill_helper = bpf_fill_alu_lsh_reg,
 10309		},
 10310		{
 10311			"ALU64_RSH_X: all shift values",
 10312			{ },
 10313			INTERNAL | FLAG_NO_DATA,
 10314			{ },
 10315			{ { 0, 1 } },
 10316			.fill_helper = bpf_fill_alu_rsh_reg,
 10317		},
 10318		{
 10319			"ALU64_ARSH_X: all shift values",
 10320			{ },
 10321			INTERNAL | FLAG_NO_DATA,
 10322			{ },
 10323			{ { 0, 1 } },
 10324			.fill_helper = bpf_fill_alu_arsh_reg,
 10325		},
 10326		/* Exhaustive test of ALU32 shift operations */
 10327		{
 10328			"ALU32_LSH_K: all shift values",
 10329			{ },
 10330			INTERNAL | FLAG_NO_DATA,
 10331			{ },
 10332			{ { 0, 1 } },
 10333			.fill_helper = bpf_fill_alu32_lsh_imm,
 10334		},
 10335		{
 10336			"ALU32_RSH_K: all shift values",
 10337			{ },
 10338			INTERNAL | FLAG_NO_DATA,
 10339			{ },
 10340			{ { 0, 1 } },
 10341			.fill_helper = bpf_fill_alu32_rsh_imm,
 10342		},
 10343		{
 10344			"ALU32_ARSH_K: all shift values",
 10345			{ },
 10346			INTERNAL | FLAG_NO_DATA,
 10347			{ },
 10348			{ { 0, 1 } },
 10349			.fill_helper = bpf_fill_alu32_arsh_imm,
 10350		},
 10351		{
 10352			"ALU32_LSH_X: all shift values",
 10353			{ },
 10354			INTERNAL | FLAG_NO_DATA,
 10355			{ },
 10356			{ { 0, 1 } },
 10357			.fill_helper = bpf_fill_alu32_lsh_reg,
 10358		},
 10359		{
 10360			"ALU32_RSH_X: all shift values",
 10361			{ },
 10362			INTERNAL | FLAG_NO_DATA,
 10363			{ },
 10364			{ { 0, 1 } },
 10365			.fill_helper = bpf_fill_alu32_rsh_reg,
 10366		},
 10367		{
 10368			"ALU32_ARSH_X: all shift values",
 10369			{ },
 10370			INTERNAL | FLAG_NO_DATA,
 10371			{ },
 10372			{ { 0, 1 } },
 10373			.fill_helper = bpf_fill_alu32_arsh_reg,
 10374		},
 10375		/* ALU64 immediate magnitudes */
 10376		{
 10377			"ALU64_MOV_K: all immediate value magnitudes",
 10378			{ },
 10379			INTERNAL | FLAG_NO_DATA,
 10380			{ },
 10381			{ { 0, 1 } },
 10382			.fill_helper = bpf_fill_alu64_mov_imm,
 10383			.nr_testruns = NR_PATTERN_RUNS,
 10384		},
 10385		{
 10386			"ALU64_AND_K: all immediate value magnitudes",
 10387			{ },
 10388			INTERNAL | FLAG_NO_DATA,
 10389			{ },
 10390			{ { 0, 1 } },
 10391			.fill_helper = bpf_fill_alu64_and_imm,
 10392			.nr_testruns = NR_PATTERN_RUNS,
 10393		},
 10394		{
 10395			"ALU64_OR_K: all immediate value magnitudes",
 10396			{ },
 10397			INTERNAL | FLAG_NO_DATA,
 10398			{ },
 10399			{ { 0, 1 } },
 10400			.fill_helper = bpf_fill_alu64_or_imm,
 10401			.nr_testruns = NR_PATTERN_RUNS,
 10402		},
 10403		{
 10404			"ALU64_XOR_K: all immediate value magnitudes",
 10405			{ },
 10406			INTERNAL | FLAG_NO_DATA,
 10407			{ },
 10408			{ { 0, 1 } },
 10409			.fill_helper = bpf_fill_alu64_xor_imm,
 10410			.nr_testruns = NR_PATTERN_RUNS,
 10411		},
 10412		{
 10413			"ALU64_ADD_K: all immediate value magnitudes",
 10414			{ },
 10415			INTERNAL | FLAG_NO_DATA,
 10416			{ },
 10417			{ { 0, 1 } },
 10418			.fill_helper = bpf_fill_alu64_add_imm,
 10419			.nr_testruns = NR_PATTERN_RUNS,
 10420		},
 10421		{
 10422			"ALU64_SUB_K: all immediate value magnitudes",
 10423			{ },
 10424			INTERNAL | FLAG_NO_DATA,
 10425			{ },
 10426			{ { 0, 1 } },
 10427			.fill_helper = bpf_fill_alu64_sub_imm,
 10428			.nr_testruns = NR_PATTERN_RUNS,
 10429		},
 10430		{
 10431			"ALU64_MUL_K: all immediate value magnitudes",
 10432			{ },
 10433			INTERNAL | FLAG_NO_DATA,
 10434			{ },
 10435			{ { 0, 1 } },
 10436			.fill_helper = bpf_fill_alu64_mul_imm,
 10437			.nr_testruns = NR_PATTERN_RUNS,
 10438		},
 10439		{
 10440			"ALU64_DIV_K: all immediate value magnitudes",
 10441			{ },
 10442			INTERNAL | FLAG_NO_DATA,
 10443			{ },
 10444			{ { 0, 1 } },
 10445			.fill_helper = bpf_fill_alu64_div_imm,
 10446			.nr_testruns = NR_PATTERN_RUNS,
 10447		},
 10448		{
 10449			"ALU64_MOD_K: all immediate value magnitudes",
 10450			{ },
 10451			INTERNAL | FLAG_NO_DATA,
 10452			{ },
 10453			{ { 0, 1 } },
 10454			.fill_helper = bpf_fill_alu64_mod_imm,
 10455			.nr_testruns = NR_PATTERN_RUNS,
 10456		},
 10457		/* ALU32 immediate magnitudes */
 10458		{
 10459			"ALU32_MOV_K: all immediate value magnitudes",
 10460			{ },
 10461			INTERNAL | FLAG_NO_DATA,
 10462			{ },
 10463			{ { 0, 1 } },
 10464			.fill_helper = bpf_fill_alu32_mov_imm,
 10465			.nr_testruns = NR_PATTERN_RUNS,
 10466		},
 10467		{
 10468			"ALU32_AND_K: all immediate value magnitudes",
 10469			{ },
 10470			INTERNAL | FLAG_NO_DATA,
 10471			{ },
 10472			{ { 0, 1 } },
 10473			.fill_helper = bpf_fill_alu32_and_imm,
 10474			.nr_testruns = NR_PATTERN_RUNS,
 10475		},
 10476		{
 10477			"ALU32_OR_K: all immediate value magnitudes",
 10478			{ },
 10479			INTERNAL | FLAG_NO_DATA,
 10480			{ },
 10481			{ { 0, 1 } },
 10482			.fill_helper = bpf_fill_alu32_or_imm,
 10483			.nr_testruns = NR_PATTERN_RUNS,
 10484		},
 10485		{
 10486			"ALU32_XOR_K: all immediate value magnitudes",
 10487			{ },
 10488			INTERNAL | FLAG_NO_DATA,
 10489			{ },
 10490			{ { 0, 1 } },
 10491			.fill_helper = bpf_fill_alu32_xor_imm,
 10492			.nr_testruns = NR_PATTERN_RUNS,
 10493		},
 10494		{
 10495			"ALU32_ADD_K: all immediate value magnitudes",
 10496			{ },
 10497			INTERNAL | FLAG_NO_DATA,
 10498			{ },
 10499			{ { 0, 1 } },
 10500			.fill_helper = bpf_fill_alu32_add_imm,
 10501			.nr_testruns = NR_PATTERN_RUNS,
 10502		},
 10503		{
 10504			"ALU32_SUB_K: all immediate value magnitudes",
 10505			{ },
 10506			INTERNAL | FLAG_NO_DATA,
 10507			{ },
 10508			{ { 0, 1 } },
 10509			.fill_helper = bpf_fill_alu32_sub_imm,
 10510			.nr_testruns = NR_PATTERN_RUNS,
 10511		},
 10512		{
 10513			"ALU32_MUL_K: all immediate value magnitudes",
 10514			{ },
 10515			INTERNAL | FLAG_NO_DATA,
 10516			{ },
 10517			{ { 0, 1 } },
 10518			.fill_helper = bpf_fill_alu32_mul_imm,
 10519			.nr_testruns = NR_PATTERN_RUNS,
 10520		},
 10521		{
 10522			"ALU32_DIV_K: all immediate value magnitudes",
 10523			{ },
 10524			INTERNAL | FLAG_NO_DATA,
 10525			{ },
 10526			{ { 0, 1 } },
 10527			.fill_helper = bpf_fill_alu32_div_imm,
 10528			.nr_testruns = NR_PATTERN_RUNS,
 10529		},
 10530		{
 10531			"ALU32_MOD_K: all immediate value magnitudes",
 10532			{ },
 10533			INTERNAL | FLAG_NO_DATA,
 10534			{ },
 10535			{ { 0, 1 } },
 10536			.fill_helper = bpf_fill_alu32_mod_imm,
 10537			.nr_testruns = NR_PATTERN_RUNS,
 10538		},
 10539		/* ALU64 register magnitudes */
 10540		{
 10541			"ALU64_MOV_X: all register value magnitudes",
 10542			{ },
 10543			INTERNAL | FLAG_NO_DATA,
 10544			{ },
 10545			{ { 0, 1 } },
 10546			.fill_helper = bpf_fill_alu64_mov_reg,
 10547			.nr_testruns = NR_PATTERN_RUNS,
 10548		},
 10549		{
 10550			"ALU64_AND_X: all register value magnitudes",
 10551			{ },
 10552			INTERNAL | FLAG_NO_DATA,
 10553			{ },
 10554			{ { 0, 1 } },
 10555			.fill_helper = bpf_fill_alu64_and_reg,
 10556			.nr_testruns = NR_PATTERN_RUNS,
 10557		},
 10558		{
 10559			"ALU64_OR_X: all register value magnitudes",
 10560			{ },
 10561			INTERNAL | FLAG_NO_DATA,
 10562			{ },
 10563			{ { 0, 1 } },
 10564			.fill_helper = bpf_fill_alu64_or_reg,
 10565			.nr_testruns = NR_PATTERN_RUNS,
 10566		},
 10567		{
 10568			"ALU64_XOR_X: all register value magnitudes",
 10569			{ },
 10570			INTERNAL | FLAG_NO_DATA,
 10571			{ },
 10572			{ { 0, 1 } },
 10573			.fill_helper = bpf_fill_alu64_xor_reg,
 10574			.nr_testruns = NR_PATTERN_RUNS,
 10575		},
 10576		{
 10577			"ALU64_ADD_X: all register value magnitudes",
 10578			{ },
 10579			INTERNAL | FLAG_NO_DATA,
 10580			{ },
 10581			{ { 0, 1 } },
 10582			.fill_helper = bpf_fill_alu64_add_reg,
 10583			.nr_testruns = NR_PATTERN_RUNS,
 10584		},
 10585		{
 10586			"ALU64_SUB_X: all register value magnitudes",
 10587			{ },
 10588			INTERNAL | FLAG_NO_DATA,
 10589			{ },
 10590			{ { 0, 1 } },
 10591			.fill_helper = bpf_fill_alu64_sub_reg,
 10592			.nr_testruns = NR_PATTERN_RUNS,
 10593		},
 10594		{
 10595			"ALU64_MUL_X: all register value magnitudes",
 10596			{ },
 10597			INTERNAL | FLAG_NO_DATA,
 10598			{ },
 10599			{ { 0, 1 } },
 10600			.fill_helper = bpf_fill_alu64_mul_reg,
 10601			.nr_testruns = NR_PATTERN_RUNS,
 10602		},
 10603		{
 10604			"ALU64_DIV_X: all register value magnitudes",
 10605			{ },
 10606			INTERNAL | FLAG_NO_DATA,
 10607			{ },
 10608			{ { 0, 1 } },
 10609			.fill_helper = bpf_fill_alu64_div_reg,
 10610			.nr_testruns = NR_PATTERN_RUNS,
 10611		},
 10612		{
 10613			"ALU64_MOD_X: all register value magnitudes",
 10614			{ },
 10615			INTERNAL | FLAG_NO_DATA,
 10616			{ },
 10617			{ { 0, 1 } },
 10618			.fill_helper = bpf_fill_alu64_mod_reg,
 10619			.nr_testruns = NR_PATTERN_RUNS,
 10620		},
 10621		/* ALU32 register magnitudes */
 10622		{
 10623			"ALU32_MOV_X: all register value magnitudes",
 10624			{ },
 10625			INTERNAL | FLAG_NO_DATA,
 10626			{ },
 10627			{ { 0, 1 } },
 10628			.fill_helper = bpf_fill_alu32_mov_reg,
 10629			.nr_testruns = NR_PATTERN_RUNS,
 10630		},
 10631		{
 10632			"ALU32_AND_X: all register value magnitudes",
 10633			{ },
 10634			INTERNAL | FLAG_NO_DATA,
 10635			{ },
 10636			{ { 0, 1 } },
 10637			.fill_helper = bpf_fill_alu32_and_reg,
 10638			.nr_testruns = NR_PATTERN_RUNS,
 10639		},
 10640		{
 10641			"ALU32_OR_X: all register value magnitudes",
 10642			{ },
 10643			INTERNAL | FLAG_NO_DATA,
 10644			{ },
 10645			{ { 0, 1 } },
 10646			.fill_helper = bpf_fill_alu32_or_reg,
 10647			.nr_testruns = NR_PATTERN_RUNS,
 10648		},
 10649		{
 10650			"ALU32_XOR_X: all register value magnitudes",
 10651			{ },
 10652			INTERNAL | FLAG_NO_DATA,
 10653			{ },
 10654			{ { 0, 1 } },
 10655			.fill_helper = bpf_fill_alu32_xor_reg,
 10656			.nr_testruns = NR_PATTERN_RUNS,
 10657		},
 10658		{
 10659			"ALU32_ADD_X: all register value magnitudes",
 10660			{ },
 10661			INTERNAL | FLAG_NO_DATA,
 10662			{ },
 10663			{ { 0, 1 } },
 10664			.fill_helper = bpf_fill_alu32_add_reg,
 10665			.nr_testruns = NR_PATTERN_RUNS,
 10666		},
 10667		{
 10668			"ALU32_SUB_X: all register value magnitudes",
 10669			{ },
 10670			INTERNAL | FLAG_NO_DATA,
 10671			{ },
 10672			{ { 0, 1 } },
 10673			.fill_helper = bpf_fill_alu32_sub_reg,
 10674			.nr_testruns = NR_PATTERN_RUNS,
 10675		},
 10676		{
 10677			"ALU32_MUL_X: all register value magnitudes",
 10678			{ },
 10679			INTERNAL | FLAG_NO_DATA,
 10680			{ },
 10681			{ { 0, 1 } },
 10682			.fill_helper = bpf_fill_alu32_mul_reg,
 10683			.nr_testruns = NR_PATTERN_RUNS,
 10684		},
 10685		{
 10686			"ALU32_DIV_X: all register value magnitudes",
 10687			{ },
 10688			INTERNAL | FLAG_NO_DATA,
 10689			{ },
 10690			{ { 0, 1 } },
 10691			.fill_helper = bpf_fill_alu32_div_reg,
 10692			.nr_testruns = NR_PATTERN_RUNS,
 10693		},
 10694		{
 10695			"ALU32_MOD_X: all register value magnitudes",
 10696			{ },
 10697			INTERNAL | FLAG_NO_DATA,
 10698			{ },
 10699			{ { 0, 1 } },
 10700			.fill_helper = bpf_fill_alu32_mod_reg,
 10701			.nr_testruns = NR_PATTERN_RUNS,
 10702		},
 10703		/* LD_IMM64 immediate magnitudes */
 10704		{
 10705			"LD_IMM64: all immediate value magnitudes",
 10706			{ },
 10707			INTERNAL | FLAG_NO_DATA,
 10708			{ },
 10709			{ { 0, 1 } },
 10710			.fill_helper = bpf_fill_ld_imm64,
 10711		},
 10712		/* JMP immediate magnitudes */
 10713		{
 10714			"JMP_JSET_K: all immediate value magnitudes",
 10715			{ },
 10716			INTERNAL | FLAG_NO_DATA,
 10717			{ },
 10718			{ { 0, 1 } },
 10719			.fill_helper = bpf_fill_jmp_jset_imm,
 10720			.nr_testruns = NR_PATTERN_RUNS,
 10721		},
 10722		{
 10723			"JMP_JEQ_K: all immediate value magnitudes",
 10724			{ },
 10725			INTERNAL | FLAG_NO_DATA,
 10726			{ },
 10727			{ { 0, 1 } },
 10728			.fill_helper = bpf_fill_jmp_jeq_imm,
 10729			.nr_testruns = NR_PATTERN_RUNS,
 10730		},
 10731		{
 10732			"JMP_JNE_K: all immediate value magnitudes",
 10733			{ },
 10734			INTERNAL | FLAG_NO_DATA,
 10735			{ },
 10736			{ { 0, 1 } },
 10737			.fill_helper = bpf_fill_jmp_jne_imm,
 10738			.nr_testruns = NR_PATTERN_RUNS,
 10739		},
 10740		{
 10741			"JMP_JGT_K: all immediate value magnitudes",
 10742			{ },
 10743			INTERNAL | FLAG_NO_DATA,
 10744			{ },
 10745			{ { 0, 1 } },
 10746			.fill_helper = bpf_fill_jmp_jgt_imm,
 10747			.nr_testruns = NR_PATTERN_RUNS,
 10748		},
 10749		{
 10750			"JMP_JGE_K: all immediate value magnitudes",
 10751			{ },
 10752			INTERNAL | FLAG_NO_DATA,
 10753			{ },
 10754			{ { 0, 1 } },
 10755			.fill_helper = bpf_fill_jmp_jge_imm,
 10756			.nr_testruns = NR_PATTERN_RUNS,
 10757		},
 10758		{
 10759			"JMP_JLT_K: all immediate value magnitudes",
 10760			{ },
 10761			INTERNAL | FLAG_NO_DATA,
 10762			{ },
 10763			{ { 0, 1 } },
 10764			.fill_helper = bpf_fill_jmp_jlt_imm,
 10765			.nr_testruns = NR_PATTERN_RUNS,
 10766		},
 10767		{
 10768			"JMP_JLE_K: all immediate value magnitudes",
 10769			{ },
 10770			INTERNAL | FLAG_NO_DATA,
 10771			{ },
 10772			{ { 0, 1 } },
 10773			.fill_helper = bpf_fill_jmp_jle_imm,
 10774			.nr_testruns = NR_PATTERN_RUNS,
 10775		},
 10776		{
 10777			"JMP_JSGT_K: all immediate value magnitudes",
 10778			{ },
 10779			INTERNAL | FLAG_NO_DATA,
 10780			{ },
 10781			{ { 0, 1 } },
 10782			.fill_helper = bpf_fill_jmp_jsgt_imm,
 10783			.nr_testruns = NR_PATTERN_RUNS,
 10784		},
 10785		{
 10786			"JMP_JSGE_K: all immediate value magnitudes",
 10787			{ },
 10788			INTERNAL | FLAG_NO_DATA,
 10789			{ },
 10790			{ { 0, 1 } },
 10791			.fill_helper = bpf_fill_jmp_jsge_imm,
 10792			.nr_testruns = NR_PATTERN_RUNS,
 10793		},
 10794		{
 10795			"JMP_JSLT_K: all immediate value magnitudes",
 10796			{ },
 10797			INTERNAL | FLAG_NO_DATA,
 10798			{ },
 10799			{ { 0, 1 } },
 10800			.fill_helper = bpf_fill_jmp_jslt_imm,
 10801			.nr_testruns = NR_PATTERN_RUNS,
 10802		},
 10803		{
 10804			"JMP_JSLE_K: all immediate value magnitudes",
 10805			{ },
 10806			INTERNAL | FLAG_NO_DATA,
 10807			{ },
 10808			{ { 0, 1 } },
 10809			.fill_helper = bpf_fill_jmp_jsle_imm,
 10810			.nr_testruns = NR_PATTERN_RUNS,
 10811		},
 10812		/* JMP register magnitudes */
 10813		{
 10814			"JMP_JSET_X: all register value magnitudes",
 10815			{ },
 10816			INTERNAL | FLAG_NO_DATA,
 10817			{ },
 10818			{ { 0, 1 } },
 10819			.fill_helper = bpf_fill_jmp_jset_reg,
 10820			.nr_testruns = NR_PATTERN_RUNS,
 10821		},
 10822		{
 10823			"JMP_JEQ_X: all register value magnitudes",
 10824			{ },
 10825			INTERNAL | FLAG_NO_DATA,
 10826			{ },
 10827			{ { 0, 1 } },
 10828			.fill_helper = bpf_fill_jmp_jeq_reg,
 10829			.nr_testruns = NR_PATTERN_RUNS,
 10830		},
 10831		{
 10832			"JMP_JNE_X: all register value magnitudes",
 10833			{ },
 10834			INTERNAL | FLAG_NO_DATA,
 10835			{ },
 10836			{ { 0, 1 } },
 10837			.fill_helper = bpf_fill_jmp_jne_reg,
 10838			.nr_testruns = NR_PATTERN_RUNS,
 10839		},
 10840		{
 10841			"JMP_JGT_X: all register value magnitudes",
 10842			{ },
 10843			INTERNAL | FLAG_NO_DATA,
 10844			{ },
 10845			{ { 0, 1 } },
 10846			.fill_helper = bpf_fill_jmp_jgt_reg,
 10847			.nr_testruns = NR_PATTERN_RUNS,
 10848		},
 10849		{
 10850			"JMP_JGE_X: all register value magnitudes",
 10851			{ },
 10852			INTERNAL | FLAG_NO_DATA,
 10853			{ },
 10854			{ { 0, 1 } },
 10855			.fill_helper = bpf_fill_jmp_jge_reg,
 10856			.nr_testruns = NR_PATTERN_RUNS,
 10857		},
 10858		{
 10859			"JMP_JLT_X: all register value magnitudes",
 10860			{ },
 10861			INTERNAL | FLAG_NO_DATA,
 10862			{ },
 10863			{ { 0, 1 } },
 10864			.fill_helper = bpf_fill_jmp_jlt_reg,
 10865			.nr_testruns = NR_PATTERN_RUNS,
 10866		},
 10867		{
 10868			"JMP_JLE_X: all register value magnitudes",
 10869			{ },
 10870			INTERNAL | FLAG_NO_DATA,
 10871			{ },
 10872			{ { 0, 1 } },
 10873			.fill_helper = bpf_fill_jmp_jle_reg,
 10874			.nr_testruns = NR_PATTERN_RUNS,
 10875		},
 10876		{
 10877			"JMP_JSGT_X: all register value magnitudes",
 10878			{ },
 10879			INTERNAL | FLAG_NO_DATA,
 10880			{ },
 10881			{ { 0, 1 } },
 10882			.fill_helper = bpf_fill_jmp_jsgt_reg,
 10883			.nr_testruns = NR_PATTERN_RUNS,
 10884		},
 10885		{
 10886			"JMP_JSGE_X: all register value magnitudes",
 10887			{ },
 10888			INTERNAL | FLAG_NO_DATA,
 10889			{ },
 10890			{ { 0, 1 } },
 10891			.fill_helper = bpf_fill_jmp_jsge_reg,
 10892			.nr_testruns = NR_PATTERN_RUNS,
 10893		},
 10894		{
 10895			"JMP_JSLT_X: all register value magnitudes",
 10896			{ },
 10897			INTERNAL | FLAG_NO_DATA,
 10898			{ },
 10899			{ { 0, 1 } },
 10900			.fill_helper = bpf_fill_jmp_jslt_reg,
 10901			.nr_testruns = NR_PATTERN_RUNS,
 10902		},
 10903		{
 10904			"JMP_JSLE_X: all register value magnitudes",
 10905			{ },
 10906			INTERNAL | FLAG_NO_DATA,
 10907			{ },
 10908			{ { 0, 1 } },
 10909			.fill_helper = bpf_fill_jmp_jsle_reg,
 10910			.nr_testruns = NR_PATTERN_RUNS,
 10911		},
 10912		/* JMP32 immediate magnitudes */
 10913		{
 10914			"JMP32_JSET_K: all immediate value magnitudes",
 10915			{ },
 10916			INTERNAL | FLAG_NO_DATA,
 10917			{ },
 10918			{ { 0, 1 } },
 10919			.fill_helper = bpf_fill_jmp32_jset_imm,
 10920			.nr_testruns = NR_PATTERN_RUNS,
 10921		},
 10922		{
 10923			"JMP32_JEQ_K: all immediate value magnitudes",
 10924			{ },
 10925			INTERNAL | FLAG_NO_DATA,
 10926			{ },
 10927			{ { 0, 1 } },
 10928			.fill_helper = bpf_fill_jmp32_jeq_imm,
 10929			.nr_testruns = NR_PATTERN_RUNS,
 10930		},
 10931		{
 10932			"JMP32_JNE_K: all immediate value magnitudes",
 10933			{ },
 10934			INTERNAL | FLAG_NO_DATA,
 10935			{ },
 10936			{ { 0, 1 } },
 10937			.fill_helper = bpf_fill_jmp32_jne_imm,
 10938			.nr_testruns = NR_PATTERN_RUNS,
 10939		},
 10940		{
 10941			"JMP32_JGT_K: all immediate value magnitudes",
 10942			{ },
 10943			INTERNAL | FLAG_NO_DATA,
 10944			{ },
 10945			{ { 0, 1 } },
 10946			.fill_helper = bpf_fill_jmp32_jgt_imm,
 10947			.nr_testruns = NR_PATTERN_RUNS,
 10948		},
 10949		{
 10950			"JMP32_JGE_K: all immediate value magnitudes",
 10951			{ },
 10952			INTERNAL | FLAG_NO_DATA,
 10953			{ },
 10954			{ { 0, 1 } },
 10955			.fill_helper = bpf_fill_jmp32_jge_imm,
 10956			.nr_testruns = NR_PATTERN_RUNS,
 10957		},
 10958		{
 10959			"JMP32_JLT_K: all immediate value magnitudes",
 10960			{ },
 10961			INTERNAL | FLAG_NO_DATA,
 10962			{ },
 10963			{ { 0, 1 } },
 10964			.fill_helper = bpf_fill_jmp32_jlt_imm,
 10965			.nr_testruns = NR_PATTERN_RUNS,
 10966		},
 10967		{
 10968			"JMP32_JLE_K: all immediate value magnitudes",
 10969			{ },
 10970			INTERNAL | FLAG_NO_DATA,
 10971			{ },
 10972			{ { 0, 1 } },
 10973			.fill_helper = bpf_fill_jmp32_jle_imm,
 10974			.nr_testruns = NR_PATTERN_RUNS,
 10975		},
 10976		{
 10977			"JMP32_JSGT_K: all immediate value magnitudes",
 10978			{ },
 10979			INTERNAL | FLAG_NO_DATA,
 10980			{ },
 10981			{ { 0, 1 } },
 10982			.fill_helper = bpf_fill_jmp32_jsgt_imm,
 10983			.nr_testruns = NR_PATTERN_RUNS,
 10984		},
 10985		{
 10986			"JMP32_JSGE_K: all immediate value magnitudes",
 10987			{ },
 10988			INTERNAL | FLAG_NO_DATA,
 10989			{ },
 10990			{ { 0, 1 } },
 10991			.fill_helper = bpf_fill_jmp32_jsge_imm,
 10992			.nr_testruns = NR_PATTERN_RUNS,
 10993		},
 10994		{
 10995			"JMP32_JSLT_K: all immediate value magnitudes",
 10996			{ },
 10997			INTERNAL | FLAG_NO_DATA,
 10998			{ },
 10999			{ { 0, 1 } },
 11000			.fill_helper = bpf_fill_jmp32_jslt_imm,
 11001			.nr_testruns = NR_PATTERN_RUNS,
 11002		},
 11003		{
 11004			"JMP32_JSLE_K: all immediate value magnitudes",
 11005			{ },
 11006			INTERNAL | FLAG_NO_DATA,
 11007			{ },
 11008			{ { 0, 1 } },
 11009			.fill_helper = bpf_fill_jmp32_jsle_imm,
 11010			.nr_testruns = NR_PATTERN_RUNS,
 11011		},
 11012		/* JMP32 register magnitudes */
 11013		{
 11014			"JMP32_JSET_X: all register value magnitudes",
 11015			{ },
 11016			INTERNAL | FLAG_NO_DATA,
 11017			{ },
 11018			{ { 0, 1 } },
 11019			.fill_helper = bpf_fill_jmp32_jset_reg,
 11020			.nr_testruns = NR_PATTERN_RUNS,
 11021		},
 11022		{
 11023			"JMP32_JEQ_X: all register value magnitudes",
 11024			{ },
 11025			INTERNAL | FLAG_NO_DATA,
 11026			{ },
 11027			{ { 0, 1 } },
 11028			.fill_helper = bpf_fill_jmp32_jeq_reg,
 11029			.nr_testruns = NR_PATTERN_RUNS,
 11030		},
 11031		{
 11032			"JMP32_JNE_X: all register value magnitudes",
 11033			{ },
 11034			INTERNAL | FLAG_NO_DATA,
 11035			{ },
 11036			{ { 0, 1 } },
 11037			.fill_helper = bpf_fill_jmp32_jne_reg,
 11038			.nr_testruns = NR_PATTERN_RUNS,
 11039		},
 11040		{
 11041			"JMP32_JGT_X: all register value magnitudes",
 11042			{ },
 11043			INTERNAL | FLAG_NO_DATA,
 11044			{ },
 11045			{ { 0, 1 } },
 11046			.fill_helper = bpf_fill_jmp32_jgt_reg,
 11047			.nr_testruns = NR_PATTERN_RUNS,
 11048		},
 11049		{
 11050			"JMP32_JGE_X: all register value magnitudes",
 11051			{ },
 11052			INTERNAL | FLAG_NO_DATA,
 11053			{ },
 11054			{ { 0, 1 } },
 11055			.fill_helper = bpf_fill_jmp32_jge_reg,
 11056			.nr_testruns = NR_PATTERN_RUNS,
 11057		},
 11058		{
 11059			"JMP32_JLT_X: all register value magnitudes",
 11060			{ },
 11061			INTERNAL | FLAG_NO_DATA,
 11062			{ },
 11063			{ { 0, 1 } },
 11064			.fill_helper = bpf_fill_jmp32_jlt_reg,
 11065			.nr_testruns = NR_PATTERN_RUNS,
 11066		},
 11067		{
 11068			"JMP32_JLE_X: all register value magnitudes",
 11069			{ },
 11070			INTERNAL | FLAG_NO_DATA,
 11071			{ },
 11072			{ { 0, 1 } },
 11073			.fill_helper = bpf_fill_jmp32_jle_reg,
 11074			.nr_testruns = NR_PATTERN_RUNS,
 11075		},
 11076		{
 11077			"JMP32_JSGT_X: all register value magnitudes",
 11078			{ },
 11079			INTERNAL | FLAG_NO_DATA,
 11080			{ },
 11081			{ { 0, 1 } },
 11082			.fill_helper = bpf_fill_jmp32_jsgt_reg,
 11083			.nr_testruns = NR_PATTERN_RUNS,
 11084		},
 11085		{
 11086			"JMP32_JSGE_X: all register value magnitudes",
 11087			{ },
 11088			INTERNAL | FLAG_NO_DATA,
 11089			{ },
 11090			{ { 0, 1 } },
 11091			.fill_helper = bpf_fill_jmp32_jsge_reg,
 11092			.nr_testruns = NR_PATTERN_RUNS,
 11093		},
 11094		{
 11095			"JMP32_JSLT_X: all register value magnitudes",
 11096			{ },
 11097			INTERNAL | FLAG_NO_DATA,
 11098			{ },
 11099			{ { 0, 1 } },
 11100			.fill_helper = bpf_fill_jmp32_jslt_reg,
 11101			.nr_testruns = NR_PATTERN_RUNS,
 11102		},
 11103		{
 11104			"JMP32_JSLE_X: all register value magnitudes",
 11105			{ },
 11106			INTERNAL | FLAG_NO_DATA,
 11107			{ },
 11108			{ { 0, 1 } },
 11109			.fill_helper = bpf_fill_jmp32_jsle_reg,
 11110			.nr_testruns = NR_PATTERN_RUNS,
 11111		},
 11112		/* Conditional jumps with constant decision */
 11113		{
 11114			"JMP_JSET_K: imm = 0 -> never taken",
 11115			.u.insns_int = {
 11116				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11117				BPF_JMP_IMM(BPF_JSET, R1, 0, 1),
 11118				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11119				BPF_EXIT_INSN(),
 11120			},
 11121			INTERNAL | FLAG_NO_DATA,
 11122			{ },
 11123			{ { 0, 0 } },
 11124		},
 11125		{
 11126			"JMP_JLT_K: imm = 0 -> never taken",
 11127			.u.insns_int = {
 11128				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11129				BPF_JMP_IMM(BPF_JLT, R1, 0, 1),
 11130				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11131				BPF_EXIT_INSN(),
 11132			},
 11133			INTERNAL | FLAG_NO_DATA,
 11134			{ },
 11135			{ { 0, 0 } },
 11136		},
 11137		{
 11138			"JMP_JGE_K: imm = 0 -> always taken",
 11139			.u.insns_int = {
 11140				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11141				BPF_JMP_IMM(BPF_JGE, R1, 0, 1),
 11142				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11143				BPF_EXIT_INSN(),
 11144			},
 11145			INTERNAL | FLAG_NO_DATA,
 11146			{ },
 11147			{ { 0, 1 } },
 11148		},
 11149		{
 11150			"JMP_JGT_K: imm = 0xffffffff -> never taken",
 11151			.u.insns_int = {
 11152				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11153				BPF_JMP_IMM(BPF_JGT, R1, U32_MAX, 1),
 11154				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11155				BPF_EXIT_INSN(),
 11156			},
 11157			INTERNAL | FLAG_NO_DATA,
 11158			{ },
 11159			{ { 0, 0 } },
 11160		},
 11161		{
 11162			"JMP_JLE_K: imm = 0xffffffff -> always taken",
 11163			.u.insns_int = {
 11164				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11165				BPF_JMP_IMM(BPF_JLE, R1, U32_MAX, 1),
 11166				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11167				BPF_EXIT_INSN(),
 11168			},
 11169			INTERNAL | FLAG_NO_DATA,
 11170			{ },
 11171			{ { 0, 1 } },
 11172		},
 11173		{
 11174			"JMP32_JSGT_K: imm = 0x7fffffff -> never taken",
 11175			.u.insns_int = {
 11176				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11177				BPF_JMP32_IMM(BPF_JSGT, R1, S32_MAX, 1),
 11178				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11179				BPF_EXIT_INSN(),
 11180			},
 11181			INTERNAL | FLAG_NO_DATA,
 11182			{ },
 11183			{ { 0, 0 } },
 11184		},
 11185		{
 11186			"JMP32_JSGE_K: imm = -0x80000000 -> always taken",
 11187			.u.insns_int = {
 11188				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11189				BPF_JMP32_IMM(BPF_JSGE, R1, S32_MIN, 1),
 11190				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11191				BPF_EXIT_INSN(),
 11192			},
 11193			INTERNAL | FLAG_NO_DATA,
 11194			{ },
 11195			{ { 0, 1 } },
 11196		},
 11197		{
 11198			"JMP32_JSLT_K: imm = -0x80000000 -> never taken",
 11199			.u.insns_int = {
 11200				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11201				BPF_JMP32_IMM(BPF_JSLT, R1, S32_MIN, 1),
 11202				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11203				BPF_EXIT_INSN(),
 11204			},
 11205			INTERNAL | FLAG_NO_DATA,
 11206			{ },
 11207			{ { 0, 0 } },
 11208		},
 11209		{
 11210			"JMP32_JSLE_K: imm = 0x7fffffff -> always taken",
 11211			.u.insns_int = {
 11212				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11213				BPF_JMP32_IMM(BPF_JSLE, R1, S32_MAX, 1),
 11214				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11215				BPF_EXIT_INSN(),
 11216			},
 11217			INTERNAL | FLAG_NO_DATA,
 11218			{ },
 11219			{ { 0, 1 } },
 11220		},
 11221		{
 11222			"JMP_JEQ_X: dst = src -> always taken",
 11223			.u.insns_int = {
 11224				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11225				BPF_JMP_REG(BPF_JEQ, R1, R1, 1),
 11226				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11227				BPF_EXIT_INSN(),
 11228			},
 11229			INTERNAL | FLAG_NO_DATA,
 11230			{ },
 11231			{ { 0, 1 } },
 11232		},
 11233		{
 11234			"JMP_JGE_X: dst = src -> always taken",
 11235			.u.insns_int = {
 11236				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11237				BPF_JMP_REG(BPF_JGE, R1, R1, 1),
 11238				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11239				BPF_EXIT_INSN(),
 11240			},
 11241			INTERNAL | FLAG_NO_DATA,
 11242			{ },
 11243			{ { 0, 1 } },
 11244		},
 11245		{
 11246			"JMP_JLE_X: dst = src -> always taken",
 11247			.u.insns_int = {
 11248				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11249				BPF_JMP_REG(BPF_JLE, R1, R1, 1),
 11250				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11251				BPF_EXIT_INSN(),
 11252			},
 11253			INTERNAL | FLAG_NO_DATA,
 11254			{ },
 11255			{ { 0, 1 } },
 11256		},
 11257		{
 11258			"JMP_JSGE_X: dst = src -> always taken",
 11259			.u.insns_int = {
 11260				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11261				BPF_JMP_REG(BPF_JSGE, R1, R1, 1),
 11262				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11263				BPF_EXIT_INSN(),
 11264			},
 11265			INTERNAL | FLAG_NO_DATA,
 11266			{ },
 11267			{ { 0, 1 } },
 11268		},
 11269		{
 11270			"JMP_JSLE_X: dst = src -> always taken",
 11271			.u.insns_int = {
 11272				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11273				BPF_JMP_REG(BPF_JSLE, R1, R1, 1),
 11274				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11275				BPF_EXIT_INSN(),
 11276			},
 11277			INTERNAL | FLAG_NO_DATA,
 11278			{ },
 11279			{ { 0, 1 } },
 11280		},
 11281		{
 11282			"JMP_JNE_X: dst = src -> never taken",
 11283			.u.insns_int = {
 11284				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11285				BPF_JMP_REG(BPF_JNE, R1, R1, 1),
 11286				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11287				BPF_EXIT_INSN(),
 11288			},
 11289			INTERNAL | FLAG_NO_DATA,
 11290			{ },
 11291			{ { 0, 0 } },
 11292		},
 11293		{
 11294			"JMP_JGT_X: dst = src -> never taken",
 11295			.u.insns_int = {
 11296				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11297				BPF_JMP_REG(BPF_JGT, R1, R1, 1),
 11298				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11299				BPF_EXIT_INSN(),
 11300			},
 11301			INTERNAL | FLAG_NO_DATA,
 11302			{ },
 11303			{ { 0, 0 } },
 11304		},
 11305		{
 11306			"JMP_JLT_X: dst = src -> never taken",
 11307			.u.insns_int = {
 11308				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11309				BPF_JMP_REG(BPF_JLT, R1, R1, 1),
 11310				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11311				BPF_EXIT_INSN(),
 11312			},
 11313			INTERNAL | FLAG_NO_DATA,
 11314			{ },
 11315			{ { 0, 0 } },
 11316		},
 11317		{
 11318			"JMP_JSGT_X: dst = src -> never taken",
 11319			.u.insns_int = {
 11320				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11321				BPF_JMP_REG(BPF_JSGT, R1, R1, 1),
 11322				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11323				BPF_EXIT_INSN(),
 11324			},
 11325			INTERNAL | FLAG_NO_DATA,
 11326			{ },
 11327			{ { 0, 0 } },
 11328		},
 11329		{
 11330			"JMP_JSLT_X: dst = src -> never taken",
 11331			.u.insns_int = {
 11332				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11333				BPF_JMP_REG(BPF_JSLT, R1, R1, 1),
 11334				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11335				BPF_EXIT_INSN(),
 11336			},
 11337			INTERNAL | FLAG_NO_DATA,
 11338			{ },
 11339			{ { 0, 0 } },
 11340		},
 11341		/* Short relative jumps */
 11342		{
 11343			"Short relative jump: offset=0",
 11344			.u.insns_int = {
 11345				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11346				BPF_JMP_IMM(BPF_JEQ, R0, 0, 0),
 11347				BPF_EXIT_INSN(),
 11348				BPF_ALU32_IMM(BPF_MOV, R0, -1),
 11349			},
 11350			INTERNAL | FLAG_NO_DATA | FLAG_VERIFIER_ZEXT,
 11351			{ },
 11352			{ { 0, 0 } },
 11353		},
 11354		{
 11355			"Short relative jump: offset=1",
 11356			.u.insns_int = {
 11357				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11358				BPF_JMP_IMM(BPF_JEQ, R0, 0, 1),
 11359				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 11360				BPF_EXIT_INSN(),
 11361				BPF_ALU32_IMM(BPF_MOV, R0, -1),
 11362			},
 11363			INTERNAL | FLAG_NO_DATA | FLAG_VERIFIER_ZEXT,
 11364			{ },
 11365			{ { 0, 0 } },
 11366		},
 11367		{
 11368			"Short relative jump: offset=2",
 11369			.u.insns_int = {
 11370				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11371				BPF_JMP_IMM(BPF_JEQ, R0, 0, 2),
 11372				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 11373				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 11374				BPF_EXIT_INSN(),
 11375				BPF_ALU32_IMM(BPF_MOV, R0, -1),
 11376			},
 11377			INTERNAL | FLAG_NO_DATA | FLAG_VERIFIER_ZEXT,
 11378			{ },
 11379			{ { 0, 0 } },
 11380		},
 11381		{
 11382			"Short relative jump: offset=3",
 11383			.u.insns_int = {
 11384				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11385				BPF_JMP_IMM(BPF_JEQ, R0, 0, 3),
 11386				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 11387				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 11388				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 11389				BPF_EXIT_INSN(),
 11390				BPF_ALU32_IMM(BPF_MOV, R0, -1),
 11391			},
 11392			INTERNAL | FLAG_NO_DATA | FLAG_VERIFIER_ZEXT,
 11393			{ },
 11394			{ { 0, 0 } },
 11395		},
 11396		{
 11397			"Short relative jump: offset=4",
 11398			.u.insns_int = {
 11399				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11400				BPF_JMP_IMM(BPF_JEQ, R0, 0, 4),
 11401				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 11402				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 11403				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 11404				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 11405				BPF_EXIT_INSN(),
 11406				BPF_ALU32_IMM(BPF_MOV, R0, -1),
 11407			},
 11408			INTERNAL | FLAG_NO_DATA | FLAG_VERIFIER_ZEXT,
 11409			{ },
 11410			{ { 0, 0 } },
 11411		},
 11412		/* Conditional branch conversions */
 11413		{
 11414			"Long conditional jump: taken at runtime",
 11415			{ },
 11416			INTERNAL | FLAG_NO_DATA,
 11417			{ },
 11418			{ { 0, 1 } },
 11419			.fill_helper = bpf_fill_max_jmp_taken,
 11420		},
 11421		{
 11422			"Long conditional jump: not taken at runtime",
 11423			{ },
 11424			INTERNAL | FLAG_NO_DATA,
 11425			{ },
 11426			{ { 0, 2 } },
 11427			.fill_helper = bpf_fill_max_jmp_not_taken,
 11428		},
 11429		{
 11430			"Long conditional jump: always taken, known at JIT time",
 11431			{ },
 11432			INTERNAL | FLAG_NO_DATA,
 11433			{ },
 11434			{ { 0, 1 } },
 11435			.fill_helper = bpf_fill_max_jmp_always_taken,
 11436		},
 11437		{
 11438			"Long conditional jump: never taken, known at JIT time",
 11439			{ },
 11440			INTERNAL | FLAG_NO_DATA,
 11441			{ },
 11442			{ { 0, 2 } },
 11443			.fill_helper = bpf_fill_max_jmp_never_taken,
 11444		},
 11445		/* Staggered jump sequences, immediate */
 11446		{
 11447			"Staggered jumps: JMP_JA",
 11448			{ },
 11449			INTERNAL | FLAG_NO_DATA,
 11450			{ },
 11451			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11452			.fill_helper = bpf_fill_staggered_ja,
 11453			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11454		},
 11455		{
 11456			"Staggered jumps: JMP_JEQ_K",
 11457			{ },
 11458			INTERNAL | FLAG_NO_DATA,
 11459			{ },
 11460			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11461			.fill_helper = bpf_fill_staggered_jeq_imm,
 11462			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11463		},
 11464		{
 11465			"Staggered jumps: JMP_JNE_K",
 11466			{ },
 11467			INTERNAL | FLAG_NO_DATA,
 11468			{ },
 11469			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11470			.fill_helper = bpf_fill_staggered_jne_imm,
 11471			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11472		},
 11473		{
 11474			"Staggered jumps: JMP_JSET_K",
 11475			{ },
 11476			INTERNAL | FLAG_NO_DATA,
 11477			{ },
 11478			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11479			.fill_helper = bpf_fill_staggered_jset_imm,
 11480			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11481		},
 11482		{
 11483			"Staggered jumps: JMP_JGT_K",
 11484			{ },
 11485			INTERNAL | FLAG_NO_DATA,
 11486			{ },
 11487			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11488			.fill_helper = bpf_fill_staggered_jgt_imm,
 11489			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11490		},
 11491		{
 11492			"Staggered jumps: JMP_JGE_K",
 11493			{ },
 11494			INTERNAL | FLAG_NO_DATA,
 11495			{ },
 11496			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11497			.fill_helper = bpf_fill_staggered_jge_imm,
 11498			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11499		},
 11500		{
 11501			"Staggered jumps: JMP_JLT_K",
 11502			{ },
 11503			INTERNAL | FLAG_NO_DATA,
 11504			{ },
 11505			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11506			.fill_helper = bpf_fill_staggered_jlt_imm,
 11507			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11508		},
 11509		{
 11510			"Staggered jumps: JMP_JLE_K",
 11511			{ },
 11512			INTERNAL | FLAG_NO_DATA,
 11513			{ },
 11514			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11515			.fill_helper = bpf_fill_staggered_jle_imm,
 11516			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11517		},
 11518		{
 11519			"Staggered jumps: JMP_JSGT_K",
 11520			{ },
 11521			INTERNAL | FLAG_NO_DATA,
 11522			{ },
 11523			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11524			.fill_helper = bpf_fill_staggered_jsgt_imm,
 11525			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11526		},
 11527		{
 11528			"Staggered jumps: JMP_JSGE_K",
 11529			{ },
 11530			INTERNAL | FLAG_NO_DATA,
 11531			{ },
 11532			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11533			.fill_helper = bpf_fill_staggered_jsge_imm,
 11534			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11535		},
 11536		{
 11537			"Staggered jumps: JMP_JSLT_K",
 11538			{ },
 11539			INTERNAL | FLAG_NO_DATA,
 11540			{ },
 11541			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11542			.fill_helper = bpf_fill_staggered_jslt_imm,
 11543			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11544		},
 11545		{
 11546			"Staggered jumps: JMP_JSLE_K",
 11547			{ },
 11548			INTERNAL | FLAG_NO_DATA,
 11549			{ },
 11550			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11551			.fill_helper = bpf_fill_staggered_jsle_imm,
 11552			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11553		},
 11554		/* Staggered jump sequences, register */
 11555		{
 11556			"Staggered jumps: JMP_JEQ_X",
 11557			{ },
 11558			INTERNAL | FLAG_NO_DATA,
 11559			{ },
 11560			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11561			.fill_helper = bpf_fill_staggered_jeq_reg,
 11562			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11563		},
 11564		{
 11565			"Staggered jumps: JMP_JNE_X",
 11566			{ },
 11567			INTERNAL | FLAG_NO_DATA,
 11568			{ },
 11569			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11570			.fill_helper = bpf_fill_staggered_jne_reg,
 11571			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11572		},
 11573		{
 11574			"Staggered jumps: JMP_JSET_X",
 11575			{ },
 11576			INTERNAL | FLAG_NO_DATA,
 11577			{ },
 11578			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11579			.fill_helper = bpf_fill_staggered_jset_reg,
 11580			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11581		},
 11582		{
 11583			"Staggered jumps: JMP_JGT_X",
 11584			{ },
 11585			INTERNAL | FLAG_NO_DATA,
 11586			{ },
 11587			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11588			.fill_helper = bpf_fill_staggered_jgt_reg,
 11589			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11590		},
 11591		{
 11592			"Staggered jumps: JMP_JGE_X",
 11593			{ },
 11594			INTERNAL | FLAG_NO_DATA,
 11595			{ },
 11596			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11597			.fill_helper = bpf_fill_staggered_jge_reg,
 11598			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11599		},
 11600		{
 11601			"Staggered jumps: JMP_JLT_X",
 11602			{ },
 11603			INTERNAL | FLAG_NO_DATA,
 11604			{ },
 11605			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11606			.fill_helper = bpf_fill_staggered_jlt_reg,
 11607			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11608		},
 11609		{
 11610			"Staggered jumps: JMP_JLE_X",
 11611			{ },
 11612			INTERNAL | FLAG_NO_DATA,
 11613			{ },
 11614			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11615			.fill_helper = bpf_fill_staggered_jle_reg,
 11616			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11617		},
 11618		{
 11619			"Staggered jumps: JMP_JSGT_X",
 11620			{ },
 11621			INTERNAL | FLAG_NO_DATA,
 11622			{ },
 11623			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11624			.fill_helper = bpf_fill_staggered_jsgt_reg,
 11625			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11626		},
 11627		{
 11628			"Staggered jumps: JMP_JSGE_X",
 11629			{ },
 11630			INTERNAL | FLAG_NO_DATA,
 11631			{ },
 11632			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11633			.fill_helper = bpf_fill_staggered_jsge_reg,
 11634			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11635		},
 11636		{
 11637			"Staggered jumps: JMP_JSLT_X",
 11638			{ },
 11639			INTERNAL | FLAG_NO_DATA,
 11640			{ },
 11641			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11642			.fill_helper = bpf_fill_staggered_jslt_reg,
 11643			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11644		},
 11645		{
 11646			"Staggered jumps: JMP_JSLE_X",
 11647			{ },
 11648			INTERNAL | FLAG_NO_DATA,
 11649			{ },
 11650			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11651			.fill_helper = bpf_fill_staggered_jsle_reg,
 11652			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11653		},
 11654		/* Staggered jump sequences, JMP32 immediate */
 11655		{
 11656			"Staggered jumps: JMP32_JEQ_K",
 11657			{ },
 11658			INTERNAL | FLAG_NO_DATA,
 11659			{ },
 11660			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11661			.fill_helper = bpf_fill_staggered_jeq32_imm,
 11662			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11663		},
 11664		{
 11665			"Staggered jumps: JMP32_JNE_K",
 11666			{ },
 11667			INTERNAL | FLAG_NO_DATA,
 11668			{ },
 11669			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11670			.fill_helper = bpf_fill_staggered_jne32_imm,
 11671			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11672		},
 11673		{
 11674			"Staggered jumps: JMP32_JSET_K",
 11675			{ },
 11676			INTERNAL | FLAG_NO_DATA,
 11677			{ },
 11678			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11679			.fill_helper = bpf_fill_staggered_jset32_imm,
 11680			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11681		},
 11682		{
 11683			"Staggered jumps: JMP32_JGT_K",
 11684			{ },
 11685			INTERNAL | FLAG_NO_DATA,
 11686			{ },
 11687			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11688			.fill_helper = bpf_fill_staggered_jgt32_imm,
 11689			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11690		},
 11691		{
 11692			"Staggered jumps: JMP32_JGE_K",
 11693			{ },
 11694			INTERNAL | FLAG_NO_DATA,
 11695			{ },
 11696			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11697			.fill_helper = bpf_fill_staggered_jge32_imm,
 11698			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11699		},
 11700		{
 11701			"Staggered jumps: JMP32_JLT_K",
 11702			{ },
 11703			INTERNAL | FLAG_NO_DATA,
 11704			{ },
 11705			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11706			.fill_helper = bpf_fill_staggered_jlt32_imm,
 11707			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11708		},
 11709		{
 11710			"Staggered jumps: JMP32_JLE_K",
 11711			{ },
 11712			INTERNAL | FLAG_NO_DATA,
 11713			{ },
 11714			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11715			.fill_helper = bpf_fill_staggered_jle32_imm,
 11716			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11717		},
 11718		{
 11719			"Staggered jumps: JMP32_JSGT_K",
 11720			{ },
 11721			INTERNAL | FLAG_NO_DATA,
 11722			{ },
 11723			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11724			.fill_helper = bpf_fill_staggered_jsgt32_imm,
 11725			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11726		},
 11727		{
 11728			"Staggered jumps: JMP32_JSGE_K",
 11729			{ },
 11730			INTERNAL | FLAG_NO_DATA,
 11731			{ },
 11732			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11733			.fill_helper = bpf_fill_staggered_jsge32_imm,
 11734			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11735		},
 11736		{
 11737			"Staggered jumps: JMP32_JSLT_K",
 11738			{ },
 11739			INTERNAL | FLAG_NO_DATA,
 11740			{ },
 11741			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11742			.fill_helper = bpf_fill_staggered_jslt32_imm,
 11743			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11744		},
 11745		{
 11746			"Staggered jumps: JMP32_JSLE_K",
 11747			{ },
 11748			INTERNAL | FLAG_NO_DATA,
 11749			{ },
 11750			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11751			.fill_helper = bpf_fill_staggered_jsle32_imm,
 11752			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11753		},
 11754		/* Staggered jump sequences, JMP32 register */
 11755		{
 11756			"Staggered jumps: JMP32_JEQ_X",
 11757			{ },
 11758			INTERNAL | FLAG_NO_DATA,
 11759			{ },
 11760			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11761			.fill_helper = bpf_fill_staggered_jeq32_reg,
 11762			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11763		},
 11764		{
 11765			"Staggered jumps: JMP32_JNE_X",
 11766			{ },
 11767			INTERNAL | FLAG_NO_DATA,
 11768			{ },
 11769			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11770			.fill_helper = bpf_fill_staggered_jne32_reg,
 11771			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11772		},
 11773		{
 11774			"Staggered jumps: JMP32_JSET_X",
 11775			{ },
 11776			INTERNAL | FLAG_NO_DATA,
 11777			{ },
 11778			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11779			.fill_helper = bpf_fill_staggered_jset32_reg,
 11780			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11781		},
 11782		{
 11783			"Staggered jumps: JMP32_JGT_X",
 11784			{ },
 11785			INTERNAL | FLAG_NO_DATA,
 11786			{ },
 11787			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11788			.fill_helper = bpf_fill_staggered_jgt32_reg,
 11789			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11790		},
 11791		{
 11792			"Staggered jumps: JMP32_JGE_X",
 11793			{ },
 11794			INTERNAL | FLAG_NO_DATA,
 11795			{ },
 11796			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11797			.fill_helper = bpf_fill_staggered_jge32_reg,
 11798			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11799		},
 11800		{
 11801			"Staggered jumps: JMP32_JLT_X",
 11802			{ },
 11803			INTERNAL | FLAG_NO_DATA,
 11804			{ },
 11805			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11806			.fill_helper = bpf_fill_staggered_jlt32_reg,
 11807			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11808		},
 11809		{
 11810			"Staggered jumps: JMP32_JLE_X",
 11811			{ },
 11812			INTERNAL | FLAG_NO_DATA,
 11813			{ },
 11814			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11815			.fill_helper = bpf_fill_staggered_jle32_reg,
 11816			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11817		},
 11818		{
 11819			"Staggered jumps: JMP32_JSGT_X",
 11820			{ },
 11821			INTERNAL | FLAG_NO_DATA,
 11822			{ },
 11823			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11824			.fill_helper = bpf_fill_staggered_jsgt32_reg,
 11825			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11826		},
 11827		{
 11828			"Staggered jumps: JMP32_JSGE_X",
 11829			{ },
 11830			INTERNAL | FLAG_NO_DATA,
 11831			{ },
 11832			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11833			.fill_helper = bpf_fill_staggered_jsge32_reg,
 11834			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11835		},
 11836		{
 11837			"Staggered jumps: JMP32_JSLT_X",
 11838			{ },
 11839			INTERNAL | FLAG_NO_DATA,
 11840			{ },
 11841			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11842			.fill_helper = bpf_fill_staggered_jslt32_reg,
 11843			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11844		},
 11845		{
 11846			"Staggered jumps: JMP32_JSLE_X",
 11847			{ },
 11848			INTERNAL | FLAG_NO_DATA,
 11849			{ },
 11850			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11851			.fill_helper = bpf_fill_staggered_jsle32_reg,
 11852			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11853		},
 11854	};
 11855	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
