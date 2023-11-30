Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E8D7FF1B6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346009AbjK3OZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345994AbjK3OZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:25:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB5583
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701354303; x=1732890303;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ek69eVHUwi6qJ4WXZICg9TBkcqhwADyoJQ5BDbP1dEE=;
  b=ny2AGVr58KyfpiOjz43OYR84SEi4zDDmqWVlN/Tw7Lwn6No0id5fAIyW
   9fLca0f20vdk+AaZbY3nEZOQq5+ZARqIggi4LYT3qxqpD57ZLm5HrLMYS
   HHCwbbGOAkanXJAe7seBU49z1jfFeX3HRu8RXiUd2Q4CF7t0Zd05jtF1l
   QrVJA/pzptnKwq5VtzHXKCw+x9ZODkvNvoLB2ZJyhVXkHOteIAh8zNYYQ
   WcoRuhph/BQZ3mIz4XZGyC0f31Lg62jMpKRuWrwFAhB+HD4/+3dzpX1UZ
   Nlrum8bKqvNl1Ti3r+++8RYjTZcRq+gIrkVFjuE5JA5airJBSdDvqplvO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="378358638"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="378358638"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 06:25:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="769319052"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="769319052"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 30 Nov 2023 06:24:59 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8hyL-000277-0f;
        Thu, 30 Nov 2023 14:24:57 +0000
Date:   Thu, 30 Nov 2023 22:24:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johan Almbladh <johan.almbladh@anyfinetworks.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: lib/test_bpf.c:1999:25: sparse: sparse: cast truncates bits from
 constant value (fedcba9876543210 becomes 76543210)
Message-ID: <202311302244.emELtv4B-lkp@intel.com>
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
head:   3b47bc037bd44f142ac09848e8d3ecccc726be99
commit: 84024a4e86d9b2085f3444190b30d5f88c76e07b bpf, tests: Add tests for ALU operations implemented with function calls
date:   2 years, 4 months ago
config: x86_64-randconfig-122-20231008 (https://download.01.org/0day-ci/archive/20231130/202311302244.emELtv4B-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311302244.emELtv4B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311302244.emELtv4B-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   lib/test_bpf.c:5180:25: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] result @@     got restricted __be16 [usertype] @@
   lib/test_bpf.c:5180:25: sparse:     expected unsigned int [usertype] result
   lib/test_bpf.c:5180:25: sparse:     got restricted __be16 [usertype]
   lib/test_bpf.c:5194:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] result @@     got restricted __be32 [usertype] @@
   lib/test_bpf.c:5194:24: sparse:     expected unsigned int [usertype] result
   lib/test_bpf.c:5194:24: sparse:     got restricted __be32 [usertype]
   lib/test_bpf.c:5205:25: sparse: sparse: cast from restricted __be64
   lib/test_bpf.c:5217:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] result @@     got restricted __le16 [usertype] @@
   lib/test_bpf.c:5217:24: sparse:     expected unsigned int [usertype] result
   lib/test_bpf.c:5217:24: sparse:     got restricted __le16 [usertype]
   lib/test_bpf.c:5231:24: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] result @@     got restricted __le32 [usertype] @@
   lib/test_bpf.c:5231:24: sparse:     expected unsigned int [usertype] result
   lib/test_bpf.c:5231:24: sparse:     got restricted __le32 [usertype]
   lib/test_bpf.c:5242:25: sparse: sparse: cast from restricted __le64
>> lib/test_bpf.c:1999:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:2000:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:2005:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:2006:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:2011:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:2012:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:2017:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:2018:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:2023:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:2024:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:2029:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:2030:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:2035:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:2040:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:2045:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:2046:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:2403:25: sparse: sparse: cast truncates bits from constant value (567800001234 becomes 1234)
   lib/test_bpf.c:2414:25: sparse: sparse: cast truncates bits from constant value (1ffffffff becomes ffffffff)
   lib/test_bpf.c:2491:25: sparse: sparse: cast truncates bits from constant value (ffffffff0000 becomes ffff0000)
   lib/test_bpf.c:2569:25: sparse: sparse: cast truncates bits from constant value (ffffffff0000 becomes ffff0000)
   lib/test_bpf.c:2585:25: sparse: sparse: cast truncates bits from constant value (ffffffff0000 becomes ffff0000)
   lib/test_bpf.c:2710:25: sparse: sparse: cast truncates bits from constant value (100000000 becomes 0)
   lib/test_bpf.c:2888:25: sparse: sparse: cast truncates bits from constant value (100000000 becomes 0)
   lib/test_bpf.c:3198:25: sparse: sparse: cast truncates bits from constant value (fedcba987654321 becomes 87654321)
   lib/test_bpf.c:3199:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef0 becomes 9abcdef0)
   lib/test_bpf.c:3210:25: sparse: sparse: cast truncates bits from constant value (fedcba987654321 becomes 87654321)
   lib/test_bpf.c:3211:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef0 becomes 9abcdef0)
   lib/test_bpf.c:3333:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:3344:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:3731:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:3769:25: sparse: sparse: cast truncates bits from constant value (ffffffff0000 becomes ffff0000)
   lib/test_bpf.c:3785:25: sparse: sparse: cast truncates bits from constant value (ffffffff0000 becomes ffff0000)
   lib/test_bpf.c:3786:25: sparse: sparse: cast truncates bits from constant value (ffffffff0000 becomes ffff0000)
   lib/test_bpf.c:3817:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:3833:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:3834:25: sparse: sparse: cast truncates bits from constant value (123456780a0c0e0 becomes 80a0c0e0)
   lib/test_bpf.c:3943:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:3981:25: sparse: sparse: cast truncates bits from constant value (ffffffff0000 becomes ffff0000)
   lib/test_bpf.c:3982:25: sparse: sparse: cast truncates bits from constant value (ffffffff0000 becomes ffff0000)
   lib/test_bpf.c:3997:25: sparse: sparse: cast truncates bits from constant value (ffffffff0000 becomes ffff0000)
   lib/test_bpf.c:4029:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4030:25: sparse: sparse: cast truncates bits from constant value (12345678fafcfef becomes 8fafcfef)
   lib/test_bpf.c:4045:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4155:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4193:25: sparse: sparse: cast truncates bits from constant value (ffffffff0000 becomes ffff0000)
   lib/test_bpf.c:4194:25: sparse: sparse: cast truncates bits from constant value (ffffffff0000 becomes ffff0000)
   lib/test_bpf.c:4209:25: sparse: sparse: cast truncates bits from constant value (ffffffff0000 becomes ffff0000)
   lib/test_bpf.c:4210:25: sparse: sparse: cast truncates bits from constant value (ffff00000000ffff becomes ffff)
   lib/test_bpf.c:4241:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4242:25: sparse: sparse: cast truncates bits from constant value (123456786a4c2e0 becomes 86a4c2e0)
   lib/test_bpf.c:4257:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4258:25: sparse: sparse: cast truncates bits from constant value (fedcba98795b3d1f becomes 795b3d1f)
   lib/test_bpf.c:4334:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4346:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4359:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4371:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4384:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4396:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4409:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4421:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4501:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4512:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4524:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4535:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4547:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4558:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4570:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4642:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4654:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4667:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4679:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4692:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4704:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4717:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4729:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4809:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4820:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4832:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4843:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4855:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4866:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4878:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4902:25: sparse: sparse: cast truncates bits from constant value (ff00ff0000000000 becomes 0)
   lib/test_bpf.c:4914:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4926:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4939:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4951:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4964:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4976:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:4989:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5001:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5037:25: sparse: sparse: cast truncates bits from constant value (ff00ff0000000000 becomes 0)
   lib/test_bpf.c:5048:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5059:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5071:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5082:25: sparse: sparse: cast truncates bits from constant value (f123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5094:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5105:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5117:25: sparse: sparse: cast truncates bits from constant value (8123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5174:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:5185:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)

vim +1999 lib/test_bpf.c

   463	
   464	static struct bpf_test tests[] = {
   465		{
   466			"TAX",
   467			.u.insns = {
   468				BPF_STMT(BPF_LD | BPF_IMM, 1),
   469				BPF_STMT(BPF_MISC | BPF_TAX, 0),
   470				BPF_STMT(BPF_LD | BPF_IMM, 2),
   471				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
   472				BPF_STMT(BPF_ALU | BPF_NEG, 0), /* A == -3 */
   473				BPF_STMT(BPF_MISC | BPF_TAX, 0),
   474				BPF_STMT(BPF_LD | BPF_LEN, 0),
   475				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
   476				BPF_STMT(BPF_MISC | BPF_TAX, 0), /* X == len - 3 */
   477				BPF_STMT(BPF_LD | BPF_B | BPF_IND, 1),
   478				BPF_STMT(BPF_RET | BPF_A, 0)
   479			},
   480			CLASSIC,
   481			{ 10, 20, 30, 40, 50 },
   482			{ { 2, 10 }, { 3, 20 }, { 4, 30 } },
   483		},
   484		{
   485			"TXA",
   486			.u.insns = {
   487				BPF_STMT(BPF_LDX | BPF_LEN, 0),
   488				BPF_STMT(BPF_MISC | BPF_TXA, 0),
   489				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
   490				BPF_STMT(BPF_RET | BPF_A, 0) /* A == len * 2 */
   491			},
   492			CLASSIC,
   493			{ 10, 20, 30, 40, 50 },
   494			{ { 1, 2 }, { 3, 6 }, { 4, 8 } },
   495		},
   496		{
   497			"ADD_SUB_MUL_K",
   498			.u.insns = {
   499				BPF_STMT(BPF_LD | BPF_IMM, 1),
   500				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 2),
   501				BPF_STMT(BPF_LDX | BPF_IMM, 3),
   502				BPF_STMT(BPF_ALU | BPF_SUB | BPF_X, 0),
   503				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 0xffffffff),
   504				BPF_STMT(BPF_ALU | BPF_MUL | BPF_K, 3),
   505				BPF_STMT(BPF_RET | BPF_A, 0)
   506			},
   507			CLASSIC | FLAG_NO_DATA,
   508			{ },
   509			{ { 0, 0xfffffffd } }
   510		},
   511		{
   512			"DIV_MOD_KX",
   513			.u.insns = {
   514				BPF_STMT(BPF_LD | BPF_IMM, 8),
   515				BPF_STMT(BPF_ALU | BPF_DIV | BPF_K, 2),
   516				BPF_STMT(BPF_MISC | BPF_TAX, 0),
   517				BPF_STMT(BPF_LD | BPF_IMM, 0xffffffff),
   518				BPF_STMT(BPF_ALU | BPF_DIV | BPF_X, 0),
   519				BPF_STMT(BPF_MISC | BPF_TAX, 0),
   520				BPF_STMT(BPF_LD | BPF_IMM, 0xffffffff),
   521				BPF_STMT(BPF_ALU | BPF_DIV | BPF_K, 0x70000000),
   522				BPF_STMT(BPF_MISC | BPF_TAX, 0),
   523				BPF_STMT(BPF_LD | BPF_IMM, 0xffffffff),
   524				BPF_STMT(BPF_ALU | BPF_MOD | BPF_X, 0),
   525				BPF_STMT(BPF_MISC | BPF_TAX, 0),
   526				BPF_STMT(BPF_LD | BPF_IMM, 0xffffffff),
   527				BPF_STMT(BPF_ALU | BPF_MOD | BPF_K, 0x70000000),
   528				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
   529				BPF_STMT(BPF_RET | BPF_A, 0)
   530			},
   531			CLASSIC | FLAG_NO_DATA,
   532			{ },
   533			{ { 0, 0x20000000 } }
   534		},
   535		{
   536			"AND_OR_LSH_K",
   537			.u.insns = {
   538				BPF_STMT(BPF_LD | BPF_IMM, 0xff),
   539				BPF_STMT(BPF_ALU | BPF_AND | BPF_K, 0xf0),
   540				BPF_STMT(BPF_ALU | BPF_LSH | BPF_K, 27),
   541				BPF_STMT(BPF_MISC | BPF_TAX, 0),
   542				BPF_STMT(BPF_LD | BPF_IMM, 0xf),
   543				BPF_STMT(BPF_ALU | BPF_OR | BPF_K, 0xf0),
   544				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
   545				BPF_STMT(BPF_RET | BPF_A, 0)
   546			},
   547			CLASSIC | FLAG_NO_DATA,
   548			{ },
   549			{ { 0, 0x800000ff }, { 1, 0x800000ff } },
   550		},
   551		{
   552			"LD_IMM_0",
   553			.u.insns = {
   554				BPF_STMT(BPF_LD | BPF_IMM, 0), /* ld #0 */
   555				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0, 1, 0),
   556				BPF_STMT(BPF_RET | BPF_K, 0),
   557				BPF_STMT(BPF_RET | BPF_K, 1),
   558			},
   559			CLASSIC,
   560			{ },
   561			{ { 1, 1 } },
   562		},
   563		{
   564			"LD_IND",
   565			.u.insns = {
   566				BPF_STMT(BPF_LDX | BPF_LEN, 0),
   567				BPF_STMT(BPF_LD | BPF_H | BPF_IND, MAX_K),
   568				BPF_STMT(BPF_RET | BPF_K, 1)
   569			},
   570			CLASSIC,
   571			{ },
   572			{ { 1, 0 }, { 10, 0 }, { 60, 0 } },
   573		},
   574		{
   575			"LD_ABS",
   576			.u.insns = {
   577				BPF_STMT(BPF_LD | BPF_W | BPF_ABS, 1000),
   578				BPF_STMT(BPF_RET | BPF_K, 1)
   579			},
   580			CLASSIC,
   581			{ },
   582			{ { 1, 0 }, { 10, 0 }, { 60, 0 } },
   583		},
   584		{
   585			"LD_ABS_LL",
   586			.u.insns = {
   587				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, SKF_LL_OFF),
   588				BPF_STMT(BPF_MISC | BPF_TAX, 0),
   589				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, SKF_LL_OFF + 1),
   590				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
   591				BPF_STMT(BPF_RET | BPF_A, 0)
   592			},
   593			CLASSIC,
   594			{ 1, 2, 3 },
   595			{ { 1, 0 }, { 2, 3 } },
   596		},
   597		{
   598			"LD_IND_LL",
   599			.u.insns = {
   600				BPF_STMT(BPF_LD | BPF_IMM, SKF_LL_OFF - 1),
   601				BPF_STMT(BPF_LDX | BPF_LEN, 0),
   602				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
   603				BPF_STMT(BPF_MISC | BPF_TAX, 0),
   604				BPF_STMT(BPF_LD | BPF_B | BPF_IND, 0),
   605				BPF_STMT(BPF_RET | BPF_A, 0)
   606			},
   607			CLASSIC,
   608			{ 1, 2, 3, 0xff },
   609			{ { 1, 1 }, { 3, 3 }, { 4, 0xff } },
   610		},
   611		{
   612			"LD_ABS_NET",
   613			.u.insns = {
   614				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, SKF_NET_OFF),
   615				BPF_STMT(BPF_MISC | BPF_TAX, 0),
   616				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, SKF_NET_OFF + 1),
   617				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
   618				BPF_STMT(BPF_RET | BPF_A, 0)
   619			},
   620			CLASSIC,
   621			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3 },
   622			{ { 15, 0 }, { 16, 3 } },
   623		},
   624		{
   625			"LD_IND_NET",
   626			.u.insns = {
   627				BPF_STMT(BPF_LD | BPF_IMM, SKF_NET_OFF - 15),
   628				BPF_STMT(BPF_LDX | BPF_LEN, 0),
   629				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
   630				BPF_STMT(BPF_MISC | BPF_TAX, 0),
   631				BPF_STMT(BPF_LD | BPF_B | BPF_IND, 0),
   632				BPF_STMT(BPF_RET | BPF_A, 0)
   633			},
   634			CLASSIC,
   635			{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3 },
   636			{ { 14, 0 }, { 15, 1 }, { 17, 3 } },
   637		},
   638		{
   639			"LD_PKTTYPE",
   640			.u.insns = {
   641				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   642					 SKF_AD_OFF + SKF_AD_PKTTYPE),
   643				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, SKB_TYPE, 1, 0),
   644				BPF_STMT(BPF_RET | BPF_K, 1),
   645				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   646					 SKF_AD_OFF + SKF_AD_PKTTYPE),
   647				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, SKB_TYPE, 1, 0),
   648				BPF_STMT(BPF_RET | BPF_K, 1),
   649				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   650					 SKF_AD_OFF + SKF_AD_PKTTYPE),
   651				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, SKB_TYPE, 1, 0),
   652				BPF_STMT(BPF_RET | BPF_K, 1),
   653				BPF_STMT(BPF_RET | BPF_A, 0)
   654			},
   655			CLASSIC,
   656			{ },
   657			{ { 1, 3 }, { 10, 3 } },
   658		},
   659		{
   660			"LD_MARK",
   661			.u.insns = {
   662				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   663					 SKF_AD_OFF + SKF_AD_MARK),
   664				BPF_STMT(BPF_RET | BPF_A, 0)
   665			},
   666			CLASSIC,
   667			{ },
   668			{ { 1, SKB_MARK}, { 10, SKB_MARK} },
   669		},
   670		{
   671			"LD_RXHASH",
   672			.u.insns = {
   673				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   674					 SKF_AD_OFF + SKF_AD_RXHASH),
   675				BPF_STMT(BPF_RET | BPF_A, 0)
   676			},
   677			CLASSIC,
   678			{ },
   679			{ { 1, SKB_HASH}, { 10, SKB_HASH} },
   680		},
   681		{
   682			"LD_QUEUE",
   683			.u.insns = {
   684				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   685					 SKF_AD_OFF + SKF_AD_QUEUE),
   686				BPF_STMT(BPF_RET | BPF_A, 0)
   687			},
   688			CLASSIC,
   689			{ },
   690			{ { 1, SKB_QUEUE_MAP }, { 10, SKB_QUEUE_MAP } },
   691		},
   692		{
   693			"LD_PROTOCOL",
   694			.u.insns = {
   695				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 1),
   696				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 20, 1, 0),
   697				BPF_STMT(BPF_RET | BPF_K, 0),
   698				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   699					 SKF_AD_OFF + SKF_AD_PROTOCOL),
   700				BPF_STMT(BPF_MISC | BPF_TAX, 0),
   701				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 2),
   702				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 30, 1, 0),
   703				BPF_STMT(BPF_RET | BPF_K, 0),
   704				BPF_STMT(BPF_MISC | BPF_TXA, 0),
   705				BPF_STMT(BPF_RET | BPF_A, 0)
   706			},
   707			CLASSIC,
   708			{ 10, 20, 30 },
   709			{ { 10, ETH_P_IP }, { 100, ETH_P_IP } },
   710		},
   711		{
   712			"LD_VLAN_TAG",
   713			.u.insns = {
   714				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   715					 SKF_AD_OFF + SKF_AD_VLAN_TAG),
   716				BPF_STMT(BPF_RET | BPF_A, 0)
   717			},
   718			CLASSIC,
   719			{ },
   720			{
   721				{ 1, SKB_VLAN_TCI },
   722				{ 10, SKB_VLAN_TCI }
   723			},
   724		},
   725		{
   726			"LD_VLAN_TAG_PRESENT",
   727			.u.insns = {
   728				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   729					 SKF_AD_OFF + SKF_AD_VLAN_TAG_PRESENT),
   730				BPF_STMT(BPF_RET | BPF_A, 0)
   731			},
   732			CLASSIC,
   733			{ },
   734			{
   735				{ 1, SKB_VLAN_PRESENT },
   736				{ 10, SKB_VLAN_PRESENT }
   737			},
   738		},
   739		{
   740			"LD_IFINDEX",
   741			.u.insns = {
   742				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   743					 SKF_AD_OFF + SKF_AD_IFINDEX),
   744				BPF_STMT(BPF_RET | BPF_A, 0)
   745			},
   746			CLASSIC,
   747			{ },
   748			{ { 1, SKB_DEV_IFINDEX }, { 10, SKB_DEV_IFINDEX } },
   749		},
   750		{
   751			"LD_HATYPE",
   752			.u.insns = {
   753				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   754					 SKF_AD_OFF + SKF_AD_HATYPE),
   755				BPF_STMT(BPF_RET | BPF_A, 0)
   756			},
   757			CLASSIC,
   758			{ },
   759			{ { 1, SKB_DEV_TYPE }, { 10, SKB_DEV_TYPE } },
   760		},
   761		{
   762			"LD_CPU",
   763			.u.insns = {
   764				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   765					 SKF_AD_OFF + SKF_AD_CPU),
   766				BPF_STMT(BPF_MISC | BPF_TAX, 0),
   767				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   768					 SKF_AD_OFF + SKF_AD_CPU),
   769				BPF_STMT(BPF_ALU | BPF_SUB | BPF_X, 0),
   770				BPF_STMT(BPF_RET | BPF_A, 0)
   771			},
   772			CLASSIC,
   773			{ },
   774			{ { 1, 0 }, { 10, 0 } },
   775		},
   776		{
   777			"LD_NLATTR",
   778			.u.insns = {
   779				BPF_STMT(BPF_LDX | BPF_IMM, 2),
   780				BPF_STMT(BPF_MISC | BPF_TXA, 0),
   781				BPF_STMT(BPF_LDX | BPF_IMM, 3),
   782				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   783					 SKF_AD_OFF + SKF_AD_NLATTR),
   784				BPF_STMT(BPF_RET | BPF_A, 0)
   785			},
   786			CLASSIC,
   787	#ifdef __BIG_ENDIAN
   788			{ 0xff, 0xff, 0, 4, 0, 2, 0, 4, 0, 3 },
   789	#else
   790			{ 0xff, 0xff, 4, 0, 2, 0, 4, 0, 3, 0 },
   791	#endif
   792			{ { 4, 0 }, { 20, 6 } },
   793		},
   794		{
   795			"LD_NLATTR_NEST",
   796			.u.insns = {
   797				BPF_STMT(BPF_LD | BPF_IMM, 2),
   798				BPF_STMT(BPF_LDX | BPF_IMM, 3),
   799				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   800					 SKF_AD_OFF + SKF_AD_NLATTR_NEST),
   801				BPF_STMT(BPF_LD | BPF_IMM, 2),
   802				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   803					 SKF_AD_OFF + SKF_AD_NLATTR_NEST),
   804				BPF_STMT(BPF_LD | BPF_IMM, 2),
   805				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   806					 SKF_AD_OFF + SKF_AD_NLATTR_NEST),
   807				BPF_STMT(BPF_LD | BPF_IMM, 2),
   808				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   809					 SKF_AD_OFF + SKF_AD_NLATTR_NEST),
   810				BPF_STMT(BPF_LD | BPF_IMM, 2),
   811				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   812					 SKF_AD_OFF + SKF_AD_NLATTR_NEST),
   813				BPF_STMT(BPF_LD | BPF_IMM, 2),
   814				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   815					 SKF_AD_OFF + SKF_AD_NLATTR_NEST),
   816				BPF_STMT(BPF_LD | BPF_IMM, 2),
   817				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   818					 SKF_AD_OFF + SKF_AD_NLATTR_NEST),
   819				BPF_STMT(BPF_LD | BPF_IMM, 2),
   820				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   821					 SKF_AD_OFF + SKF_AD_NLATTR_NEST),
   822				BPF_STMT(BPF_RET | BPF_A, 0)
   823			},
   824			CLASSIC,
   825	#ifdef __BIG_ENDIAN
   826			{ 0xff, 0xff, 0, 12, 0, 1, 0, 4, 0, 2, 0, 4, 0, 3 },
   827	#else
   828			{ 0xff, 0xff, 12, 0, 1, 0, 4, 0, 2, 0, 4, 0, 3, 0 },
   829	#endif
   830			{ { 4, 0 }, { 20, 10 } },
   831		},
   832		{
   833			"LD_PAYLOAD_OFF",
   834			.u.insns = {
   835				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   836					 SKF_AD_OFF + SKF_AD_PAY_OFFSET),
   837				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   838					 SKF_AD_OFF + SKF_AD_PAY_OFFSET),
   839				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   840					 SKF_AD_OFF + SKF_AD_PAY_OFFSET),
   841				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   842					 SKF_AD_OFF + SKF_AD_PAY_OFFSET),
   843				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   844					 SKF_AD_OFF + SKF_AD_PAY_OFFSET),
   845				BPF_STMT(BPF_RET | BPF_A, 0)
   846			},
   847			CLASSIC,
   848			/* 00:00:00:00:00:00 > 00:00:00:00:00:00, ethtype IPv4 (0x0800),
   849			 * length 98: 127.0.0.1 > 127.0.0.1: ICMP echo request,
   850			 * id 9737, seq 1, length 64
   851			 */
   852			{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   853			  0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
   854			  0x08, 0x00,
   855			  0x45, 0x00, 0x00, 0x54, 0xac, 0x8b, 0x40, 0x00, 0x40,
   856			  0x01, 0x90, 0x1b, 0x7f, 0x00, 0x00, 0x01 },
   857			{ { 30, 0 }, { 100, 42 } },
   858		},
   859		{
   860			"LD_ANC_XOR",
   861			.u.insns = {
   862				BPF_STMT(BPF_LD | BPF_IMM, 10),
   863				BPF_STMT(BPF_LDX | BPF_IMM, 300),
   864				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
   865					 SKF_AD_OFF + SKF_AD_ALU_XOR_X),
   866				BPF_STMT(BPF_RET | BPF_A, 0)
   867			},
   868			CLASSIC,
   869			{ },
   870			{ { 4, 0xA ^ 300 }, { 20, 0xA ^ 300 } },
   871		},
   872		{
   873			"SPILL_FILL",
   874			.u.insns = {
   875				BPF_STMT(BPF_LDX | BPF_LEN, 0),
   876				BPF_STMT(BPF_LD | BPF_IMM, 2),
   877				BPF_STMT(BPF_ALU | BPF_RSH, 1),
   878				BPF_STMT(BPF_ALU | BPF_XOR | BPF_X, 0),
   879				BPF_STMT(BPF_ST, 1), /* M1 = 1 ^ len */
   880				BPF_STMT(BPF_ALU | BPF_XOR | BPF_K, 0x80000000),
   881				BPF_STMT(BPF_ST, 2), /* M2 = 1 ^ len ^ 0x80000000 */
   882				BPF_STMT(BPF_STX, 15), /* M3 = len */
   883				BPF_STMT(BPF_LDX | BPF_MEM, 1),
   884				BPF_STMT(BPF_LD | BPF_MEM, 2),
   885				BPF_STMT(BPF_ALU | BPF_XOR | BPF_X, 0),
   886				BPF_STMT(BPF_LDX | BPF_MEM, 15),
   887				BPF_STMT(BPF_ALU | BPF_XOR | BPF_X, 0),
   888				BPF_STMT(BPF_RET | BPF_A, 0)
   889			},
   890			CLASSIC,
   891			{ },
   892			{ { 1, 0x80000001 }, { 2, 0x80000002 }, { 60, 0x80000000 ^ 60 } }
   893		},
   894		{
   895			"JEQ",
   896			.u.insns = {
   897				BPF_STMT(BPF_LDX | BPF_LEN, 0),
   898				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 2),
   899				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_X, 0, 0, 1),
   900				BPF_STMT(BPF_RET | BPF_K, 1),
   901				BPF_STMT(BPF_RET | BPF_K, MAX_K)
   902			},
   903			CLASSIC,
   904			{ 3, 3, 3, 3, 3 },
   905			{ { 1, 0 }, { 3, 1 }, { 4, MAX_K } },
   906		},
   907		{
   908			"JGT",
   909			.u.insns = {
   910				BPF_STMT(BPF_LDX | BPF_LEN, 0),
   911				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 2),
   912				BPF_JUMP(BPF_JMP | BPF_JGT | BPF_X, 0, 0, 1),
   913				BPF_STMT(BPF_RET | BPF_K, 1),
   914				BPF_STMT(BPF_RET | BPF_K, MAX_K)
   915			},
   916			CLASSIC,
   917			{ 4, 4, 4, 3, 3 },
   918			{ { 2, 0 }, { 3, 1 }, { 4, MAX_K } },
   919		},
   920		{
   921			"JGE (jt 0), test 1",
   922			.u.insns = {
   923				BPF_STMT(BPF_LDX | BPF_LEN, 0),
   924				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 2),
   925				BPF_JUMP(BPF_JMP | BPF_JGE | BPF_X, 0, 0, 1),
   926				BPF_STMT(BPF_RET | BPF_K, 1),
   927				BPF_STMT(BPF_RET | BPF_K, MAX_K)
   928			},
   929			CLASSIC,
   930			{ 4, 4, 4, 3, 3 },
   931			{ { 2, 0 }, { 3, 1 }, { 4, 1 } },
   932		},
   933		{
   934			"JGE (jt 0), test 2",
   935			.u.insns = {
   936				BPF_STMT(BPF_LDX | BPF_LEN, 0),
   937				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 2),
   938				BPF_JUMP(BPF_JMP | BPF_JGE | BPF_X, 0, 0, 1),
   939				BPF_STMT(BPF_RET | BPF_K, 1),
   940				BPF_STMT(BPF_RET | BPF_K, MAX_K)
   941			},
   942			CLASSIC,
   943			{ 4, 4, 5, 3, 3 },
   944			{ { 4, 1 }, { 5, 1 }, { 6, MAX_K } },
   945		},
   946		{
   947			"JGE",
   948			.u.insns = {
   949				BPF_STMT(BPF_LDX | BPF_LEN, 0),
   950				BPF_STMT(BPF_LD | BPF_B | BPF_IND, MAX_K),
   951				BPF_JUMP(BPF_JMP | BPF_JGE | BPF_K, 1, 1, 0),
   952				BPF_STMT(BPF_RET | BPF_K, 10),
   953				BPF_JUMP(BPF_JMP | BPF_JGE | BPF_K, 2, 1, 0),
   954				BPF_STMT(BPF_RET | BPF_K, 20),
   955				BPF_JUMP(BPF_JMP | BPF_JGE | BPF_K, 3, 1, 0),
   956				BPF_STMT(BPF_RET | BPF_K, 30),
   957				BPF_JUMP(BPF_JMP | BPF_JGE | BPF_K, 4, 1, 0),
   958				BPF_STMT(BPF_RET | BPF_K, 40),
   959				BPF_STMT(BPF_RET | BPF_K, MAX_K)
   960			},
   961			CLASSIC,
   962			{ 1, 2, 3, 4, 5 },
   963			{ { 1, 20 }, { 3, 40 }, { 5, MAX_K } },
   964		},
   965		{
   966			"JSET",
   967			.u.insns = {
   968				BPF_JUMP(BPF_JMP | BPF_JA, 0, 0, 0),
   969				BPF_JUMP(BPF_JMP | BPF_JA, 1, 1, 1),
   970				BPF_JUMP(BPF_JMP | BPF_JA, 0, 0, 0),
   971				BPF_JUMP(BPF_JMP | BPF_JA, 0, 0, 0),
   972				BPF_STMT(BPF_LDX | BPF_LEN, 0),
   973				BPF_STMT(BPF_MISC | BPF_TXA, 0),
   974				BPF_STMT(BPF_ALU | BPF_SUB | BPF_K, 4),
   975				BPF_STMT(BPF_MISC | BPF_TAX, 0),
   976				BPF_STMT(BPF_LD | BPF_W | BPF_IND, 0),
   977				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 1, 0, 1),
   978				BPF_STMT(BPF_RET | BPF_K, 10),
   979				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0x80000000, 0, 1),
   980				BPF_STMT(BPF_RET | BPF_K, 20),
   981				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0xffffff, 1, 0),
   982				BPF_STMT(BPF_RET | BPF_K, 30),
   983				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0xffffff, 1, 0),
   984				BPF_STMT(BPF_RET | BPF_K, 30),
   985				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0xffffff, 1, 0),
   986				BPF_STMT(BPF_RET | BPF_K, 30),
   987				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0xffffff, 1, 0),
   988				BPF_STMT(BPF_RET | BPF_K, 30),
   989				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0xffffff, 1, 0),
   990				BPF_STMT(BPF_RET | BPF_K, 30),
   991				BPF_STMT(BPF_RET | BPF_K, MAX_K)
   992			},
   993			CLASSIC,
   994			{ 0, 0xAA, 0x55, 1 },
   995			{ { 4, 10 }, { 5, 20 }, { 6, MAX_K } },
   996		},
   997		{
   998			"tcpdump port 22",
   999			.u.insns = {
  1000				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 12),
  1001				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x86dd, 0, 8), /* IPv6 */
  1002				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 20),
  1003				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x84, 2, 0),
  1004				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x6, 1, 0),
  1005				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x11, 0, 17),
  1006				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 54),
  1007				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 22, 14, 0),
  1008				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 56),
  1009				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 22, 12, 13),
  1010				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x0800, 0, 12), /* IPv4 */
  1011				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 23),
  1012				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x84, 2, 0),
  1013				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x6, 1, 0),
  1014				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x11, 0, 8),
  1015				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 20),
  1016				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0x1fff, 6, 0),
  1017				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 14),
  1018				BPF_STMT(BPF_LD | BPF_H | BPF_IND, 14),
  1019				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 22, 2, 0),
  1020				BPF_STMT(BPF_LD | BPF_H | BPF_IND, 16),
  1021				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 22, 0, 1),
  1022				BPF_STMT(BPF_RET | BPF_K, 0xffff),
  1023				BPF_STMT(BPF_RET | BPF_K, 0),
  1024			},
  1025			CLASSIC,
  1026			/* 3c:07:54:43:e5:76 > 10:bf:48:d6:43:d6, ethertype IPv4(0x0800)
  1027			 * length 114: 10.1.1.149.49700 > 10.1.2.10.22: Flags [P.],
  1028			 * seq 1305692979:1305693027, ack 3650467037, win 65535,
  1029			 * options [nop,nop,TS val 2502645400 ecr 3971138], length 48
  1030			 */
  1031			{ 0x10, 0xbf, 0x48, 0xd6, 0x43, 0xd6,
  1032			  0x3c, 0x07, 0x54, 0x43, 0xe5, 0x76,
  1033			  0x08, 0x00,
  1034			  0x45, 0x10, 0x00, 0x64, 0x75, 0xb5,
  1035			  0x40, 0x00, 0x40, 0x06, 0xad, 0x2e, /* IP header */
  1036			  0x0a, 0x01, 0x01, 0x95, /* ip src */
  1037			  0x0a, 0x01, 0x02, 0x0a, /* ip dst */
  1038			  0xc2, 0x24,
  1039			  0x00, 0x16 /* dst port */ },
  1040			{ { 10, 0 }, { 30, 0 }, { 100, 65535 } },
  1041		},
  1042		{
  1043			"tcpdump complex",
  1044			.u.insns = {
  1045				/* tcpdump -nei eth0 'tcp port 22 and (((ip[2:2] -
  1046				 * ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0) and
  1047				 * (len > 115 or len < 30000000000)' -d
  1048				 */
  1049				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 12),
  1050				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x86dd, 30, 0),
  1051				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x800, 0, 29),
  1052				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 23),
  1053				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x6, 0, 27),
  1054				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 20),
  1055				BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 0x1fff, 25, 0),
  1056				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 14),
  1057				BPF_STMT(BPF_LD | BPF_H | BPF_IND, 14),
  1058				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 22, 2, 0),
  1059				BPF_STMT(BPF_LD | BPF_H | BPF_IND, 16),
  1060				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 22, 0, 20),
  1061				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 16),
  1062				BPF_STMT(BPF_ST, 1),
  1063				BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 14),
  1064				BPF_STMT(BPF_ALU | BPF_AND | BPF_K, 0xf),
  1065				BPF_STMT(BPF_ALU | BPF_LSH | BPF_K, 2),
  1066				BPF_STMT(BPF_MISC | BPF_TAX, 0x5), /* libpcap emits K on TAX */
  1067				BPF_STMT(BPF_LD | BPF_MEM, 1),
  1068				BPF_STMT(BPF_ALU | BPF_SUB | BPF_X, 0),
  1069				BPF_STMT(BPF_ST, 5),
  1070				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 14),
  1071				BPF_STMT(BPF_LD | BPF_B | BPF_IND, 26),
  1072				BPF_STMT(BPF_ALU | BPF_AND | BPF_K, 0xf0),
  1073				BPF_STMT(BPF_ALU | BPF_RSH | BPF_K, 2),
  1074				BPF_STMT(BPF_MISC | BPF_TAX, 0x9), /* libpcap emits K on TAX */
  1075				BPF_STMT(BPF_LD | BPF_MEM, 5),
  1076				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_X, 0, 4, 0),
  1077				BPF_STMT(BPF_LD | BPF_LEN, 0),
  1078				BPF_JUMP(BPF_JMP | BPF_JGT | BPF_K, 0x73, 1, 0),
  1079				BPF_JUMP(BPF_JMP | BPF_JGE | BPF_K, 0xfc23ac00, 1, 0),
  1080				BPF_STMT(BPF_RET | BPF_K, 0xffff),
  1081				BPF_STMT(BPF_RET | BPF_K, 0),
  1082			},
  1083			CLASSIC,
  1084			{ 0x10, 0xbf, 0x48, 0xd6, 0x43, 0xd6,
  1085			  0x3c, 0x07, 0x54, 0x43, 0xe5, 0x76,
  1086			  0x08, 0x00,
  1087			  0x45, 0x10, 0x00, 0x64, 0x75, 0xb5,
  1088			  0x40, 0x00, 0x40, 0x06, 0xad, 0x2e, /* IP header */
  1089			  0x0a, 0x01, 0x01, 0x95, /* ip src */
  1090			  0x0a, 0x01, 0x02, 0x0a, /* ip dst */
  1091			  0xc2, 0x24,
  1092			  0x00, 0x16 /* dst port */ },
  1093			{ { 10, 0 }, { 30, 0 }, { 100, 65535 } },
  1094		},
  1095		{
  1096			"RET_A",
  1097			.u.insns = {
  1098				/* check that uninitialized X and A contain zeros */
  1099				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  1100				BPF_STMT(BPF_RET | BPF_A, 0)
  1101			},
  1102			CLASSIC,
  1103			{ },
  1104			{ {1, 0}, {2, 0} },
  1105		},
  1106		{
  1107			"INT: ADD trivial",
  1108			.u.insns_int = {
  1109				BPF_ALU64_IMM(BPF_MOV, R1, 1),
  1110				BPF_ALU64_IMM(BPF_ADD, R1, 2),
  1111				BPF_ALU64_IMM(BPF_MOV, R2, 3),
  1112				BPF_ALU64_REG(BPF_SUB, R1, R2),
  1113				BPF_ALU64_IMM(BPF_ADD, R1, -1),
  1114				BPF_ALU64_IMM(BPF_MUL, R1, 3),
  1115				BPF_ALU64_REG(BPF_MOV, R0, R1),
  1116				BPF_EXIT_INSN(),
  1117			},
  1118			INTERNAL,
  1119			{ },
  1120			{ { 0, 0xfffffffd } }
  1121		},
  1122		{
  1123			"INT: MUL_X",
  1124			.u.insns_int = {
  1125				BPF_ALU64_IMM(BPF_MOV, R0, -1),
  1126				BPF_ALU64_IMM(BPF_MOV, R1, -1),
  1127				BPF_ALU64_IMM(BPF_MOV, R2, 3),
  1128				BPF_ALU64_REG(BPF_MUL, R1, R2),
  1129				BPF_JMP_IMM(BPF_JEQ, R1, 0xfffffffd, 1),
  1130				BPF_EXIT_INSN(),
  1131				BPF_ALU64_IMM(BPF_MOV, R0, 1),
  1132				BPF_EXIT_INSN(),
  1133			},
  1134			INTERNAL,
  1135			{ },
  1136			{ { 0, 1 } }
  1137		},
  1138		{
  1139			"INT: MUL_X2",
  1140			.u.insns_int = {
  1141				BPF_ALU32_IMM(BPF_MOV, R0, -1),
  1142				BPF_ALU32_IMM(BPF_MOV, R1, -1),
  1143				BPF_ALU32_IMM(BPF_MOV, R2, 3),
  1144				BPF_ALU64_REG(BPF_MUL, R1, R2),
  1145				BPF_ALU64_IMM(BPF_RSH, R1, 8),
  1146				BPF_JMP_IMM(BPF_JEQ, R1, 0x2ffffff, 1),
  1147				BPF_EXIT_INSN(),
  1148				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  1149				BPF_EXIT_INSN(),
  1150			},
  1151			INTERNAL,
  1152			{ },
  1153			{ { 0, 1 } }
  1154		},
  1155		{
  1156			"INT: MUL32_X",
  1157			.u.insns_int = {
  1158				BPF_ALU32_IMM(BPF_MOV, R0, -1),
  1159				BPF_ALU64_IMM(BPF_MOV, R1, -1),
  1160				BPF_ALU32_IMM(BPF_MOV, R2, 3),
  1161				BPF_ALU32_REG(BPF_MUL, R1, R2),
  1162				BPF_ALU64_IMM(BPF_RSH, R1, 8),
  1163				BPF_JMP_IMM(BPF_JEQ, R1, 0xffffff, 1),
  1164				BPF_EXIT_INSN(),
  1165				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  1166				BPF_EXIT_INSN(),
  1167			},
  1168			INTERNAL,
  1169			{ },
  1170			{ { 0, 1 } }
  1171		},
  1172		{
  1173			/* Have to test all register combinations, since
  1174			 * JITing of different registers will produce
  1175			 * different asm code.
  1176			 */
  1177			"INT: ADD 64-bit",
  1178			.u.insns_int = {
  1179				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  1180				BPF_ALU64_IMM(BPF_MOV, R1, 1),
  1181				BPF_ALU64_IMM(BPF_MOV, R2, 2),
  1182				BPF_ALU64_IMM(BPF_MOV, R3, 3),
  1183				BPF_ALU64_IMM(BPF_MOV, R4, 4),
  1184				BPF_ALU64_IMM(BPF_MOV, R5, 5),
  1185				BPF_ALU64_IMM(BPF_MOV, R6, 6),
  1186				BPF_ALU64_IMM(BPF_MOV, R7, 7),
  1187				BPF_ALU64_IMM(BPF_MOV, R8, 8),
  1188				BPF_ALU64_IMM(BPF_MOV, R9, 9),
  1189				BPF_ALU64_IMM(BPF_ADD, R0, 20),
  1190				BPF_ALU64_IMM(BPF_ADD, R1, 20),
  1191				BPF_ALU64_IMM(BPF_ADD, R2, 20),
  1192				BPF_ALU64_IMM(BPF_ADD, R3, 20),
  1193				BPF_ALU64_IMM(BPF_ADD, R4, 20),
  1194				BPF_ALU64_IMM(BPF_ADD, R5, 20),
  1195				BPF_ALU64_IMM(BPF_ADD, R6, 20),
  1196				BPF_ALU64_IMM(BPF_ADD, R7, 20),
  1197				BPF_ALU64_IMM(BPF_ADD, R8, 20),
  1198				BPF_ALU64_IMM(BPF_ADD, R9, 20),
  1199				BPF_ALU64_IMM(BPF_SUB, R0, 10),
  1200				BPF_ALU64_IMM(BPF_SUB, R1, 10),
  1201				BPF_ALU64_IMM(BPF_SUB, R2, 10),
  1202				BPF_ALU64_IMM(BPF_SUB, R3, 10),
  1203				BPF_ALU64_IMM(BPF_SUB, R4, 10),
  1204				BPF_ALU64_IMM(BPF_SUB, R5, 10),
  1205				BPF_ALU64_IMM(BPF_SUB, R6, 10),
  1206				BPF_ALU64_IMM(BPF_SUB, R7, 10),
  1207				BPF_ALU64_IMM(BPF_SUB, R8, 10),
  1208				BPF_ALU64_IMM(BPF_SUB, R9, 10),
  1209				BPF_ALU64_REG(BPF_ADD, R0, R0),
  1210				BPF_ALU64_REG(BPF_ADD, R0, R1),
  1211				BPF_ALU64_REG(BPF_ADD, R0, R2),
  1212				BPF_ALU64_REG(BPF_ADD, R0, R3),
  1213				BPF_ALU64_REG(BPF_ADD, R0, R4),
  1214				BPF_ALU64_REG(BPF_ADD, R0, R5),
  1215				BPF_ALU64_REG(BPF_ADD, R0, R6),
  1216				BPF_ALU64_REG(BPF_ADD, R0, R7),
  1217				BPF_ALU64_REG(BPF_ADD, R0, R8),
  1218				BPF_ALU64_REG(BPF_ADD, R0, R9), /* R0 == 155 */
  1219				BPF_JMP_IMM(BPF_JEQ, R0, 155, 1),
  1220				BPF_EXIT_INSN(),
  1221				BPF_ALU64_REG(BPF_ADD, R1, R0),
  1222				BPF_ALU64_REG(BPF_ADD, R1, R1),
  1223				BPF_ALU64_REG(BPF_ADD, R1, R2),
  1224				BPF_ALU64_REG(BPF_ADD, R1, R3),
  1225				BPF_ALU64_REG(BPF_ADD, R1, R4),
  1226				BPF_ALU64_REG(BPF_ADD, R1, R5),
  1227				BPF_ALU64_REG(BPF_ADD, R1, R6),
  1228				BPF_ALU64_REG(BPF_ADD, R1, R7),
  1229				BPF_ALU64_REG(BPF_ADD, R1, R8),
  1230				BPF_ALU64_REG(BPF_ADD, R1, R9), /* R1 == 456 */
  1231				BPF_JMP_IMM(BPF_JEQ, R1, 456, 1),
  1232				BPF_EXIT_INSN(),
  1233				BPF_ALU64_REG(BPF_ADD, R2, R0),
  1234				BPF_ALU64_REG(BPF_ADD, R2, R1),
  1235				BPF_ALU64_REG(BPF_ADD, R2, R2),
  1236				BPF_ALU64_REG(BPF_ADD, R2, R3),
  1237				BPF_ALU64_REG(BPF_ADD, R2, R4),
  1238				BPF_ALU64_REG(BPF_ADD, R2, R5),
  1239				BPF_ALU64_REG(BPF_ADD, R2, R6),
  1240				BPF_ALU64_REG(BPF_ADD, R2, R7),
  1241				BPF_ALU64_REG(BPF_ADD, R2, R8),
  1242				BPF_ALU64_REG(BPF_ADD, R2, R9), /* R2 == 1358 */
  1243				BPF_JMP_IMM(BPF_JEQ, R2, 1358, 1),
  1244				BPF_EXIT_INSN(),
  1245				BPF_ALU64_REG(BPF_ADD, R3, R0),
  1246				BPF_ALU64_REG(BPF_ADD, R3, R1),
  1247				BPF_ALU64_REG(BPF_ADD, R3, R2),
  1248				BPF_ALU64_REG(BPF_ADD, R3, R3),
  1249				BPF_ALU64_REG(BPF_ADD, R3, R4),
  1250				BPF_ALU64_REG(BPF_ADD, R3, R5),
  1251				BPF_ALU64_REG(BPF_ADD, R3, R6),
  1252				BPF_ALU64_REG(BPF_ADD, R3, R7),
  1253				BPF_ALU64_REG(BPF_ADD, R3, R8),
  1254				BPF_ALU64_REG(BPF_ADD, R3, R9), /* R3 == 4063 */
  1255				BPF_JMP_IMM(BPF_JEQ, R3, 4063, 1),
  1256				BPF_EXIT_INSN(),
  1257				BPF_ALU64_REG(BPF_ADD, R4, R0),
  1258				BPF_ALU64_REG(BPF_ADD, R4, R1),
  1259				BPF_ALU64_REG(BPF_ADD, R4, R2),
  1260				BPF_ALU64_REG(BPF_ADD, R4, R3),
  1261				BPF_ALU64_REG(BPF_ADD, R4, R4),
  1262				BPF_ALU64_REG(BPF_ADD, R4, R5),
  1263				BPF_ALU64_REG(BPF_ADD, R4, R6),
  1264				BPF_ALU64_REG(BPF_ADD, R4, R7),
  1265				BPF_ALU64_REG(BPF_ADD, R4, R8),
  1266				BPF_ALU64_REG(BPF_ADD, R4, R9), /* R4 == 12177 */
  1267				BPF_JMP_IMM(BPF_JEQ, R4, 12177, 1),
  1268				BPF_EXIT_INSN(),
  1269				BPF_ALU64_REG(BPF_ADD, R5, R0),
  1270				BPF_ALU64_REG(BPF_ADD, R5, R1),
  1271				BPF_ALU64_REG(BPF_ADD, R5, R2),
  1272				BPF_ALU64_REG(BPF_ADD, R5, R3),
  1273				BPF_ALU64_REG(BPF_ADD, R5, R4),
  1274				BPF_ALU64_REG(BPF_ADD, R5, R5),
  1275				BPF_ALU64_REG(BPF_ADD, R5, R6),
  1276				BPF_ALU64_REG(BPF_ADD, R5, R7),
  1277				BPF_ALU64_REG(BPF_ADD, R5, R8),
  1278				BPF_ALU64_REG(BPF_ADD, R5, R9), /* R5 == 36518 */
  1279				BPF_JMP_IMM(BPF_JEQ, R5, 36518, 1),
  1280				BPF_EXIT_INSN(),
  1281				BPF_ALU64_REG(BPF_ADD, R6, R0),
  1282				BPF_ALU64_REG(BPF_ADD, R6, R1),
  1283				BPF_ALU64_REG(BPF_ADD, R6, R2),
  1284				BPF_ALU64_REG(BPF_ADD, R6, R3),
  1285				BPF_ALU64_REG(BPF_ADD, R6, R4),
  1286				BPF_ALU64_REG(BPF_ADD, R6, R5),
  1287				BPF_ALU64_REG(BPF_ADD, R6, R6),
  1288				BPF_ALU64_REG(BPF_ADD, R6, R7),
  1289				BPF_ALU64_REG(BPF_ADD, R6, R8),
  1290				BPF_ALU64_REG(BPF_ADD, R6, R9), /* R6 == 109540 */
  1291				BPF_JMP_IMM(BPF_JEQ, R6, 109540, 1),
  1292				BPF_EXIT_INSN(),
  1293				BPF_ALU64_REG(BPF_ADD, R7, R0),
  1294				BPF_ALU64_REG(BPF_ADD, R7, R1),
  1295				BPF_ALU64_REG(BPF_ADD, R7, R2),
  1296				BPF_ALU64_REG(BPF_ADD, R7, R3),
  1297				BPF_ALU64_REG(BPF_ADD, R7, R4),
  1298				BPF_ALU64_REG(BPF_ADD, R7, R5),
  1299				BPF_ALU64_REG(BPF_ADD, R7, R6),
  1300				BPF_ALU64_REG(BPF_ADD, R7, R7),
  1301				BPF_ALU64_REG(BPF_ADD, R7, R8),
  1302				BPF_ALU64_REG(BPF_ADD, R7, R9), /* R7 == 328605 */
  1303				BPF_JMP_IMM(BPF_JEQ, R7, 328605, 1),
  1304				BPF_EXIT_INSN(),
  1305				BPF_ALU64_REG(BPF_ADD, R8, R0),
  1306				BPF_ALU64_REG(BPF_ADD, R8, R1),
  1307				BPF_ALU64_REG(BPF_ADD, R8, R2),
  1308				BPF_ALU64_REG(BPF_ADD, R8, R3),
  1309				BPF_ALU64_REG(BPF_ADD, R8, R4),
  1310				BPF_ALU64_REG(BPF_ADD, R8, R5),
  1311				BPF_ALU64_REG(BPF_ADD, R8, R6),
  1312				BPF_ALU64_REG(BPF_ADD, R8, R7),
  1313				BPF_ALU64_REG(BPF_ADD, R8, R8),
  1314				BPF_ALU64_REG(BPF_ADD, R8, R9), /* R8 == 985799 */
  1315				BPF_JMP_IMM(BPF_JEQ, R8, 985799, 1),
  1316				BPF_EXIT_INSN(),
  1317				BPF_ALU64_REG(BPF_ADD, R9, R0),
  1318				BPF_ALU64_REG(BPF_ADD, R9, R1),
  1319				BPF_ALU64_REG(BPF_ADD, R9, R2),
  1320				BPF_ALU64_REG(BPF_ADD, R9, R3),
  1321				BPF_ALU64_REG(BPF_ADD, R9, R4),
  1322				BPF_ALU64_REG(BPF_ADD, R9, R5),
  1323				BPF_ALU64_REG(BPF_ADD, R9, R6),
  1324				BPF_ALU64_REG(BPF_ADD, R9, R7),
  1325				BPF_ALU64_REG(BPF_ADD, R9, R8),
  1326				BPF_ALU64_REG(BPF_ADD, R9, R9), /* R9 == 2957380 */
  1327				BPF_ALU64_REG(BPF_MOV, R0, R9),
  1328				BPF_EXIT_INSN(),
  1329			},
  1330			INTERNAL,
  1331			{ },
  1332			{ { 0, 2957380 } }
  1333		},
  1334		{
  1335			"INT: ADD 32-bit",
  1336			.u.insns_int = {
  1337				BPF_ALU32_IMM(BPF_MOV, R0, 20),
  1338				BPF_ALU32_IMM(BPF_MOV, R1, 1),
  1339				BPF_ALU32_IMM(BPF_MOV, R2, 2),
  1340				BPF_ALU32_IMM(BPF_MOV, R3, 3),
  1341				BPF_ALU32_IMM(BPF_MOV, R4, 4),
  1342				BPF_ALU32_IMM(BPF_MOV, R5, 5),
  1343				BPF_ALU32_IMM(BPF_MOV, R6, 6),
  1344				BPF_ALU32_IMM(BPF_MOV, R7, 7),
  1345				BPF_ALU32_IMM(BPF_MOV, R8, 8),
  1346				BPF_ALU32_IMM(BPF_MOV, R9, 9),
  1347				BPF_ALU64_IMM(BPF_ADD, R1, 10),
  1348				BPF_ALU64_IMM(BPF_ADD, R2, 10),
  1349				BPF_ALU64_IMM(BPF_ADD, R3, 10),
  1350				BPF_ALU64_IMM(BPF_ADD, R4, 10),
  1351				BPF_ALU64_IMM(BPF_ADD, R5, 10),
  1352				BPF_ALU64_IMM(BPF_ADD, R6, 10),
  1353				BPF_ALU64_IMM(BPF_ADD, R7, 10),
  1354				BPF_ALU64_IMM(BPF_ADD, R8, 10),
  1355				BPF_ALU64_IMM(BPF_ADD, R9, 10),
  1356				BPF_ALU32_REG(BPF_ADD, R0, R1),
  1357				BPF_ALU32_REG(BPF_ADD, R0, R2),
  1358				BPF_ALU32_REG(BPF_ADD, R0, R3),
  1359				BPF_ALU32_REG(BPF_ADD, R0, R4),
  1360				BPF_ALU32_REG(BPF_ADD, R0, R5),
  1361				BPF_ALU32_REG(BPF_ADD, R0, R6),
  1362				BPF_ALU32_REG(BPF_ADD, R0, R7),
  1363				BPF_ALU32_REG(BPF_ADD, R0, R8),
  1364				BPF_ALU32_REG(BPF_ADD, R0, R9), /* R0 == 155 */
  1365				BPF_JMP_IMM(BPF_JEQ, R0, 155, 1),
  1366				BPF_EXIT_INSN(),
  1367				BPF_ALU32_REG(BPF_ADD, R1, R0),
  1368				BPF_ALU32_REG(BPF_ADD, R1, R1),
  1369				BPF_ALU32_REG(BPF_ADD, R1, R2),
  1370				BPF_ALU32_REG(BPF_ADD, R1, R3),
  1371				BPF_ALU32_REG(BPF_ADD, R1, R4),
  1372				BPF_ALU32_REG(BPF_ADD, R1, R5),
  1373				BPF_ALU32_REG(BPF_ADD, R1, R6),
  1374				BPF_ALU32_REG(BPF_ADD, R1, R7),
  1375				BPF_ALU32_REG(BPF_ADD, R1, R8),
  1376				BPF_ALU32_REG(BPF_ADD, R1, R9), /* R1 == 456 */
  1377				BPF_JMP_IMM(BPF_JEQ, R1, 456, 1),
  1378				BPF_EXIT_INSN(),
  1379				BPF_ALU32_REG(BPF_ADD, R2, R0),
  1380				BPF_ALU32_REG(BPF_ADD, R2, R1),
  1381				BPF_ALU32_REG(BPF_ADD, R2, R2),
  1382				BPF_ALU32_REG(BPF_ADD, R2, R3),
  1383				BPF_ALU32_REG(BPF_ADD, R2, R4),
  1384				BPF_ALU32_REG(BPF_ADD, R2, R5),
  1385				BPF_ALU32_REG(BPF_ADD, R2, R6),
  1386				BPF_ALU32_REG(BPF_ADD, R2, R7),
  1387				BPF_ALU32_REG(BPF_ADD, R2, R8),
  1388				BPF_ALU32_REG(BPF_ADD, R2, R9), /* R2 == 1358 */
  1389				BPF_JMP_IMM(BPF_JEQ, R2, 1358, 1),
  1390				BPF_EXIT_INSN(),
  1391				BPF_ALU32_REG(BPF_ADD, R3, R0),
  1392				BPF_ALU32_REG(BPF_ADD, R3, R1),
  1393				BPF_ALU32_REG(BPF_ADD, R3, R2),
  1394				BPF_ALU32_REG(BPF_ADD, R3, R3),
  1395				BPF_ALU32_REG(BPF_ADD, R3, R4),
  1396				BPF_ALU32_REG(BPF_ADD, R3, R5),
  1397				BPF_ALU32_REG(BPF_ADD, R3, R6),
  1398				BPF_ALU32_REG(BPF_ADD, R3, R7),
  1399				BPF_ALU32_REG(BPF_ADD, R3, R8),
  1400				BPF_ALU32_REG(BPF_ADD, R3, R9), /* R3 == 4063 */
  1401				BPF_JMP_IMM(BPF_JEQ, R3, 4063, 1),
  1402				BPF_EXIT_INSN(),
  1403				BPF_ALU32_REG(BPF_ADD, R4, R0),
  1404				BPF_ALU32_REG(BPF_ADD, R4, R1),
  1405				BPF_ALU32_REG(BPF_ADD, R4, R2),
  1406				BPF_ALU32_REG(BPF_ADD, R4, R3),
  1407				BPF_ALU32_REG(BPF_ADD, R4, R4),
  1408				BPF_ALU32_REG(BPF_ADD, R4, R5),
  1409				BPF_ALU32_REG(BPF_ADD, R4, R6),
  1410				BPF_ALU32_REG(BPF_ADD, R4, R7),
  1411				BPF_ALU32_REG(BPF_ADD, R4, R8),
  1412				BPF_ALU32_REG(BPF_ADD, R4, R9), /* R4 == 12177 */
  1413				BPF_JMP_IMM(BPF_JEQ, R4, 12177, 1),
  1414				BPF_EXIT_INSN(),
  1415				BPF_ALU32_REG(BPF_ADD, R5, R0),
  1416				BPF_ALU32_REG(BPF_ADD, R5, R1),
  1417				BPF_ALU32_REG(BPF_ADD, R5, R2),
  1418				BPF_ALU32_REG(BPF_ADD, R5, R3),
  1419				BPF_ALU32_REG(BPF_ADD, R5, R4),
  1420				BPF_ALU32_REG(BPF_ADD, R5, R5),
  1421				BPF_ALU32_REG(BPF_ADD, R5, R6),
  1422				BPF_ALU32_REG(BPF_ADD, R5, R7),
  1423				BPF_ALU32_REG(BPF_ADD, R5, R8),
  1424				BPF_ALU32_REG(BPF_ADD, R5, R9), /* R5 == 36518 */
  1425				BPF_JMP_IMM(BPF_JEQ, R5, 36518, 1),
  1426				BPF_EXIT_INSN(),
  1427				BPF_ALU32_REG(BPF_ADD, R6, R0),
  1428				BPF_ALU32_REG(BPF_ADD, R6, R1),
  1429				BPF_ALU32_REG(BPF_ADD, R6, R2),
  1430				BPF_ALU32_REG(BPF_ADD, R6, R3),
  1431				BPF_ALU32_REG(BPF_ADD, R6, R4),
  1432				BPF_ALU32_REG(BPF_ADD, R6, R5),
  1433				BPF_ALU32_REG(BPF_ADD, R6, R6),
  1434				BPF_ALU32_REG(BPF_ADD, R6, R7),
  1435				BPF_ALU32_REG(BPF_ADD, R6, R8),
  1436				BPF_ALU32_REG(BPF_ADD, R6, R9), /* R6 == 109540 */
  1437				BPF_JMP_IMM(BPF_JEQ, R6, 109540, 1),
  1438				BPF_EXIT_INSN(),
  1439				BPF_ALU32_REG(BPF_ADD, R7, R0),
  1440				BPF_ALU32_REG(BPF_ADD, R7, R1),
  1441				BPF_ALU32_REG(BPF_ADD, R7, R2),
  1442				BPF_ALU32_REG(BPF_ADD, R7, R3),
  1443				BPF_ALU32_REG(BPF_ADD, R7, R4),
  1444				BPF_ALU32_REG(BPF_ADD, R7, R5),
  1445				BPF_ALU32_REG(BPF_ADD, R7, R6),
  1446				BPF_ALU32_REG(BPF_ADD, R7, R7),
  1447				BPF_ALU32_REG(BPF_ADD, R7, R8),
  1448				BPF_ALU32_REG(BPF_ADD, R7, R9), /* R7 == 328605 */
  1449				BPF_JMP_IMM(BPF_JEQ, R7, 328605, 1),
  1450				BPF_EXIT_INSN(),
  1451				BPF_ALU32_REG(BPF_ADD, R8, R0),
  1452				BPF_ALU32_REG(BPF_ADD, R8, R1),
  1453				BPF_ALU32_REG(BPF_ADD, R8, R2),
  1454				BPF_ALU32_REG(BPF_ADD, R8, R3),
  1455				BPF_ALU32_REG(BPF_ADD, R8, R4),
  1456				BPF_ALU32_REG(BPF_ADD, R8, R5),
  1457				BPF_ALU32_REG(BPF_ADD, R8, R6),
  1458				BPF_ALU32_REG(BPF_ADD, R8, R7),
  1459				BPF_ALU32_REG(BPF_ADD, R8, R8),
  1460				BPF_ALU32_REG(BPF_ADD, R8, R9), /* R8 == 985799 */
  1461				BPF_JMP_IMM(BPF_JEQ, R8, 985799, 1),
  1462				BPF_EXIT_INSN(),
  1463				BPF_ALU32_REG(BPF_ADD, R9, R0),
  1464				BPF_ALU32_REG(BPF_ADD, R9, R1),
  1465				BPF_ALU32_REG(BPF_ADD, R9, R2),
  1466				BPF_ALU32_REG(BPF_ADD, R9, R3),
  1467				BPF_ALU32_REG(BPF_ADD, R9, R4),
  1468				BPF_ALU32_REG(BPF_ADD, R9, R5),
  1469				BPF_ALU32_REG(BPF_ADD, R9, R6),
  1470				BPF_ALU32_REG(BPF_ADD, R9, R7),
  1471				BPF_ALU32_REG(BPF_ADD, R9, R8),
  1472				BPF_ALU32_REG(BPF_ADD, R9, R9), /* R9 == 2957380 */
  1473				BPF_ALU32_REG(BPF_MOV, R0, R9),
  1474				BPF_EXIT_INSN(),
  1475			},
  1476			INTERNAL,
  1477			{ },
  1478			{ { 0, 2957380 } }
  1479		},
  1480		{	/* Mainly checking JIT here. */
  1481			"INT: SUB",
  1482			.u.insns_int = {
  1483				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  1484				BPF_ALU64_IMM(BPF_MOV, R1, 1),
  1485				BPF_ALU64_IMM(BPF_MOV, R2, 2),
  1486				BPF_ALU64_IMM(BPF_MOV, R3, 3),
  1487				BPF_ALU64_IMM(BPF_MOV, R4, 4),
  1488				BPF_ALU64_IMM(BPF_MOV, R5, 5),
  1489				BPF_ALU64_IMM(BPF_MOV, R6, 6),
  1490				BPF_ALU64_IMM(BPF_MOV, R7, 7),
  1491				BPF_ALU64_IMM(BPF_MOV, R8, 8),
  1492				BPF_ALU64_IMM(BPF_MOV, R9, 9),
  1493				BPF_ALU64_REG(BPF_SUB, R0, R0),
  1494				BPF_ALU64_REG(BPF_SUB, R0, R1),
  1495				BPF_ALU64_REG(BPF_SUB, R0, R2),
  1496				BPF_ALU64_REG(BPF_SUB, R0, R3),
  1497				BPF_ALU64_REG(BPF_SUB, R0, R4),
  1498				BPF_ALU64_REG(BPF_SUB, R0, R5),
  1499				BPF_ALU64_REG(BPF_SUB, R0, R6),
  1500				BPF_ALU64_REG(BPF_SUB, R0, R7),
  1501				BPF_ALU64_REG(BPF_SUB, R0, R8),
  1502				BPF_ALU64_REG(BPF_SUB, R0, R9),
  1503				BPF_ALU64_IMM(BPF_SUB, R0, 10),
  1504				BPF_JMP_IMM(BPF_JEQ, R0, -55, 1),
  1505				BPF_EXIT_INSN(),
  1506				BPF_ALU64_REG(BPF_SUB, R1, R0),
  1507				BPF_ALU64_REG(BPF_SUB, R1, R2),
  1508				BPF_ALU64_REG(BPF_SUB, R1, R3),
  1509				BPF_ALU64_REG(BPF_SUB, R1, R4),
  1510				BPF_ALU64_REG(BPF_SUB, R1, R5),
  1511				BPF_ALU64_REG(BPF_SUB, R1, R6),
  1512				BPF_ALU64_REG(BPF_SUB, R1, R7),
  1513				BPF_ALU64_REG(BPF_SUB, R1, R8),
  1514				BPF_ALU64_REG(BPF_SUB, R1, R9),
  1515				BPF_ALU64_IMM(BPF_SUB, R1, 10),
  1516				BPF_ALU64_REG(BPF_SUB, R2, R0),
  1517				BPF_ALU64_REG(BPF_SUB, R2, R1),
  1518				BPF_ALU64_REG(BPF_SUB, R2, R3),
  1519				BPF_ALU64_REG(BPF_SUB, R2, R4),
  1520				BPF_ALU64_REG(BPF_SUB, R2, R5),
  1521				BPF_ALU64_REG(BPF_SUB, R2, R6),
  1522				BPF_ALU64_REG(BPF_SUB, R2, R7),
  1523				BPF_ALU64_REG(BPF_SUB, R2, R8),
  1524				BPF_ALU64_REG(BPF_SUB, R2, R9),
  1525				BPF_ALU64_IMM(BPF_SUB, R2, 10),
  1526				BPF_ALU64_REG(BPF_SUB, R3, R0),
  1527				BPF_ALU64_REG(BPF_SUB, R3, R1),
  1528				BPF_ALU64_REG(BPF_SUB, R3, R2),
  1529				BPF_ALU64_REG(BPF_SUB, R3, R4),
  1530				BPF_ALU64_REG(BPF_SUB, R3, R5),
  1531				BPF_ALU64_REG(BPF_SUB, R3, R6),
  1532				BPF_ALU64_REG(BPF_SUB, R3, R7),
  1533				BPF_ALU64_REG(BPF_SUB, R3, R8),
  1534				BPF_ALU64_REG(BPF_SUB, R3, R9),
  1535				BPF_ALU64_IMM(BPF_SUB, R3, 10),
  1536				BPF_ALU64_REG(BPF_SUB, R4, R0),
  1537				BPF_ALU64_REG(BPF_SUB, R4, R1),
  1538				BPF_ALU64_REG(BPF_SUB, R4, R2),
  1539				BPF_ALU64_REG(BPF_SUB, R4, R3),
  1540				BPF_ALU64_REG(BPF_SUB, R4, R5),
  1541				BPF_ALU64_REG(BPF_SUB, R4, R6),
  1542				BPF_ALU64_REG(BPF_SUB, R4, R7),
  1543				BPF_ALU64_REG(BPF_SUB, R4, R8),
  1544				BPF_ALU64_REG(BPF_SUB, R4, R9),
  1545				BPF_ALU64_IMM(BPF_SUB, R4, 10),
  1546				BPF_ALU64_REG(BPF_SUB, R5, R0),
  1547				BPF_ALU64_REG(BPF_SUB, R5, R1),
  1548				BPF_ALU64_REG(BPF_SUB, R5, R2),
  1549				BPF_ALU64_REG(BPF_SUB, R5, R3),
  1550				BPF_ALU64_REG(BPF_SUB, R5, R4),
  1551				BPF_ALU64_REG(BPF_SUB, R5, R6),
  1552				BPF_ALU64_REG(BPF_SUB, R5, R7),
  1553				BPF_ALU64_REG(BPF_SUB, R5, R8),
  1554				BPF_ALU64_REG(BPF_SUB, R5, R9),
  1555				BPF_ALU64_IMM(BPF_SUB, R5, 10),
  1556				BPF_ALU64_REG(BPF_SUB, R6, R0),
  1557				BPF_ALU64_REG(BPF_SUB, R6, R1),
  1558				BPF_ALU64_REG(BPF_SUB, R6, R2),
  1559				BPF_ALU64_REG(BPF_SUB, R6, R3),
  1560				BPF_ALU64_REG(BPF_SUB, R6, R4),
  1561				BPF_ALU64_REG(BPF_SUB, R6, R5),
  1562				BPF_ALU64_REG(BPF_SUB, R6, R7),
  1563				BPF_ALU64_REG(BPF_SUB, R6, R8),
  1564				BPF_ALU64_REG(BPF_SUB, R6, R9),
  1565				BPF_ALU64_IMM(BPF_SUB, R6, 10),
  1566				BPF_ALU64_REG(BPF_SUB, R7, R0),
  1567				BPF_ALU64_REG(BPF_SUB, R7, R1),
  1568				BPF_ALU64_REG(BPF_SUB, R7, R2),
  1569				BPF_ALU64_REG(BPF_SUB, R7, R3),
  1570				BPF_ALU64_REG(BPF_SUB, R7, R4),
  1571				BPF_ALU64_REG(BPF_SUB, R7, R5),
  1572				BPF_ALU64_REG(BPF_SUB, R7, R6),
  1573				BPF_ALU64_REG(BPF_SUB, R7, R8),
  1574				BPF_ALU64_REG(BPF_SUB, R7, R9),
  1575				BPF_ALU64_IMM(BPF_SUB, R7, 10),
  1576				BPF_ALU64_REG(BPF_SUB, R8, R0),
  1577				BPF_ALU64_REG(BPF_SUB, R8, R1),
  1578				BPF_ALU64_REG(BPF_SUB, R8, R2),
  1579				BPF_ALU64_REG(BPF_SUB, R8, R3),
  1580				BPF_ALU64_REG(BPF_SUB, R8, R4),
  1581				BPF_ALU64_REG(BPF_SUB, R8, R5),
  1582				BPF_ALU64_REG(BPF_SUB, R8, R6),
  1583				BPF_ALU64_REG(BPF_SUB, R8, R7),
  1584				BPF_ALU64_REG(BPF_SUB, R8, R9),
  1585				BPF_ALU64_IMM(BPF_SUB, R8, 10),
  1586				BPF_ALU64_REG(BPF_SUB, R9, R0),
  1587				BPF_ALU64_REG(BPF_SUB, R9, R1),
  1588				BPF_ALU64_REG(BPF_SUB, R9, R2),
  1589				BPF_ALU64_REG(BPF_SUB, R9, R3),
  1590				BPF_ALU64_REG(BPF_SUB, R9, R4),
  1591				BPF_ALU64_REG(BPF_SUB, R9, R5),
  1592				BPF_ALU64_REG(BPF_SUB, R9, R6),
  1593				BPF_ALU64_REG(BPF_SUB, R9, R7),
  1594				BPF_ALU64_REG(BPF_SUB, R9, R8),
  1595				BPF_ALU64_IMM(BPF_SUB, R9, 10),
  1596				BPF_ALU64_IMM(BPF_SUB, R0, 10),
  1597				BPF_ALU64_IMM(BPF_NEG, R0, 0),
  1598				BPF_ALU64_REG(BPF_SUB, R0, R1),
  1599				BPF_ALU64_REG(BPF_SUB, R0, R2),
  1600				BPF_ALU64_REG(BPF_SUB, R0, R3),
  1601				BPF_ALU64_REG(BPF_SUB, R0, R4),
  1602				BPF_ALU64_REG(BPF_SUB, R0, R5),
  1603				BPF_ALU64_REG(BPF_SUB, R0, R6),
  1604				BPF_ALU64_REG(BPF_SUB, R0, R7),
  1605				BPF_ALU64_REG(BPF_SUB, R0, R8),
  1606				BPF_ALU64_REG(BPF_SUB, R0, R9),
  1607				BPF_EXIT_INSN(),
  1608			},
  1609			INTERNAL,
  1610			{ },
  1611			{ { 0, 11 } }
  1612		},
  1613		{	/* Mainly checking JIT here. */
  1614			"INT: XOR",
  1615			.u.insns_int = {
  1616				BPF_ALU64_REG(BPF_SUB, R0, R0),
  1617				BPF_ALU64_REG(BPF_XOR, R1, R1),
  1618				BPF_JMP_REG(BPF_JEQ, R0, R1, 1),
  1619				BPF_EXIT_INSN(),
  1620				BPF_ALU64_IMM(BPF_MOV, R0, 10),
  1621				BPF_ALU64_IMM(BPF_MOV, R1, -1),
  1622				BPF_ALU64_REG(BPF_SUB, R1, R1),
  1623				BPF_ALU64_REG(BPF_XOR, R2, R2),
  1624				BPF_JMP_REG(BPF_JEQ, R1, R2, 1),
  1625				BPF_EXIT_INSN(),
  1626				BPF_ALU64_REG(BPF_SUB, R2, R2),
  1627				BPF_ALU64_REG(BPF_XOR, R3, R3),
  1628				BPF_ALU64_IMM(BPF_MOV, R0, 10),
  1629				BPF_ALU64_IMM(BPF_MOV, R1, -1),
  1630				BPF_JMP_REG(BPF_JEQ, R2, R3, 1),
  1631				BPF_EXIT_INSN(),
  1632				BPF_ALU64_REG(BPF_SUB, R3, R3),
  1633				BPF_ALU64_REG(BPF_XOR, R4, R4),
  1634				BPF_ALU64_IMM(BPF_MOV, R2, 1),
  1635				BPF_ALU64_IMM(BPF_MOV, R5, -1),
  1636				BPF_JMP_REG(BPF_JEQ, R3, R4, 1),
  1637				BPF_EXIT_INSN(),
  1638				BPF_ALU64_REG(BPF_SUB, R4, R4),
  1639				BPF_ALU64_REG(BPF_XOR, R5, R5),
  1640				BPF_ALU64_IMM(BPF_MOV, R3, 1),
  1641				BPF_ALU64_IMM(BPF_MOV, R7, -1),
  1642				BPF_JMP_REG(BPF_JEQ, R5, R4, 1),
  1643				BPF_EXIT_INSN(),
  1644				BPF_ALU64_IMM(BPF_MOV, R5, 1),
  1645				BPF_ALU64_REG(BPF_SUB, R5, R5),
  1646				BPF_ALU64_REG(BPF_XOR, R6, R6),
  1647				BPF_ALU64_IMM(BPF_MOV, R1, 1),
  1648				BPF_ALU64_IMM(BPF_MOV, R8, -1),
  1649				BPF_JMP_REG(BPF_JEQ, R5, R6, 1),
  1650				BPF_EXIT_INSN(),
  1651				BPF_ALU64_REG(BPF_SUB, R6, R6),
  1652				BPF_ALU64_REG(BPF_XOR, R7, R7),
  1653				BPF_JMP_REG(BPF_JEQ, R7, R6, 1),
  1654				BPF_EXIT_INSN(),
  1655				BPF_ALU64_REG(BPF_SUB, R7, R7),
  1656				BPF_ALU64_REG(BPF_XOR, R8, R8),
  1657				BPF_JMP_REG(BPF_JEQ, R7, R8, 1),
  1658				BPF_EXIT_INSN(),
  1659				BPF_ALU64_REG(BPF_SUB, R8, R8),
  1660				BPF_ALU64_REG(BPF_XOR, R9, R9),
  1661				BPF_JMP_REG(BPF_JEQ, R9, R8, 1),
  1662				BPF_EXIT_INSN(),
  1663				BPF_ALU64_REG(BPF_SUB, R9, R9),
  1664				BPF_ALU64_REG(BPF_XOR, R0, R0),
  1665				BPF_JMP_REG(BPF_JEQ, R9, R0, 1),
  1666				BPF_EXIT_INSN(),
  1667				BPF_ALU64_REG(BPF_SUB, R1, R1),
  1668				BPF_ALU64_REG(BPF_XOR, R0, R0),
  1669				BPF_JMP_REG(BPF_JEQ, R9, R0, 2),
  1670				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  1671				BPF_EXIT_INSN(),
  1672				BPF_ALU64_IMM(BPF_MOV, R0, 1),
  1673				BPF_EXIT_INSN(),
  1674			},
  1675			INTERNAL,
  1676			{ },
  1677			{ { 0, 1 } }
  1678		},
  1679		{	/* Mainly checking JIT here. */
  1680			"INT: MUL",
  1681			.u.insns_int = {
  1682				BPF_ALU64_IMM(BPF_MOV, R0, 11),
  1683				BPF_ALU64_IMM(BPF_MOV, R1, 1),
  1684				BPF_ALU64_IMM(BPF_MOV, R2, 2),
  1685				BPF_ALU64_IMM(BPF_MOV, R3, 3),
  1686				BPF_ALU64_IMM(BPF_MOV, R4, 4),
  1687				BPF_ALU64_IMM(BPF_MOV, R5, 5),
  1688				BPF_ALU64_IMM(BPF_MOV, R6, 6),
  1689				BPF_ALU64_IMM(BPF_MOV, R7, 7),
  1690				BPF_ALU64_IMM(BPF_MOV, R8, 8),
  1691				BPF_ALU64_IMM(BPF_MOV, R9, 9),
  1692				BPF_ALU64_REG(BPF_MUL, R0, R0),
  1693				BPF_ALU64_REG(BPF_MUL, R0, R1),
  1694				BPF_ALU64_REG(BPF_MUL, R0, R2),
  1695				BPF_ALU64_REG(BPF_MUL, R0, R3),
  1696				BPF_ALU64_REG(BPF_MUL, R0, R4),
  1697				BPF_ALU64_REG(BPF_MUL, R0, R5),
  1698				BPF_ALU64_REG(BPF_MUL, R0, R6),
  1699				BPF_ALU64_REG(BPF_MUL, R0, R7),
  1700				BPF_ALU64_REG(BPF_MUL, R0, R8),
  1701				BPF_ALU64_REG(BPF_MUL, R0, R9),
  1702				BPF_ALU64_IMM(BPF_MUL, R0, 10),
  1703				BPF_JMP_IMM(BPF_JEQ, R0, 439084800, 1),
  1704				BPF_EXIT_INSN(),
  1705				BPF_ALU64_REG(BPF_MUL, R1, R0),
  1706				BPF_ALU64_REG(BPF_MUL, R1, R2),
  1707				BPF_ALU64_REG(BPF_MUL, R1, R3),
  1708				BPF_ALU64_REG(BPF_MUL, R1, R4),
  1709				BPF_ALU64_REG(BPF_MUL, R1, R5),
  1710				BPF_ALU64_REG(BPF_MUL, R1, R6),
  1711				BPF_ALU64_REG(BPF_MUL, R1, R7),
  1712				BPF_ALU64_REG(BPF_MUL, R1, R8),
  1713				BPF_ALU64_REG(BPF_MUL, R1, R9),
  1714				BPF_ALU64_IMM(BPF_MUL, R1, 10),
  1715				BPF_ALU64_REG(BPF_MOV, R2, R1),
  1716				BPF_ALU64_IMM(BPF_RSH, R2, 32),
  1717				BPF_JMP_IMM(BPF_JEQ, R2, 0x5a924, 1),
  1718				BPF_EXIT_INSN(),
  1719				BPF_ALU64_IMM(BPF_LSH, R1, 32),
  1720				BPF_ALU64_IMM(BPF_ARSH, R1, 32),
  1721				BPF_JMP_IMM(BPF_JEQ, R1, 0xebb90000, 1),
  1722				BPF_EXIT_INSN(),
  1723				BPF_ALU64_REG(BPF_MUL, R2, R0),
  1724				BPF_ALU64_REG(BPF_MUL, R2, R1),
  1725				BPF_ALU64_REG(BPF_MUL, R2, R3),
  1726				BPF_ALU64_REG(BPF_MUL, R2, R4),
  1727				BPF_ALU64_REG(BPF_MUL, R2, R5),
  1728				BPF_ALU64_REG(BPF_MUL, R2, R6),
  1729				BPF_ALU64_REG(BPF_MUL, R2, R7),
  1730				BPF_ALU64_REG(BPF_MUL, R2, R8),
  1731				BPF_ALU64_REG(BPF_MUL, R2, R9),
  1732				BPF_ALU64_IMM(BPF_MUL, R2, 10),
  1733				BPF_ALU64_IMM(BPF_RSH, R2, 32),
  1734				BPF_ALU64_REG(BPF_MOV, R0, R2),
  1735				BPF_EXIT_INSN(),
  1736			},
  1737			INTERNAL,
  1738			{ },
  1739			{ { 0, 0x35d97ef2 } }
  1740		},
  1741		{	/* Mainly checking JIT here. */
  1742			"MOV REG64",
  1743			.u.insns_int = {
  1744				BPF_LD_IMM64(R0, 0xffffffffffffffffLL),
  1745				BPF_MOV64_REG(R1, R0),
  1746				BPF_MOV64_REG(R2, R1),
  1747				BPF_MOV64_REG(R3, R2),
  1748				BPF_MOV64_REG(R4, R3),
  1749				BPF_MOV64_REG(R5, R4),
  1750				BPF_MOV64_REG(R6, R5),
  1751				BPF_MOV64_REG(R7, R6),
  1752				BPF_MOV64_REG(R8, R7),
  1753				BPF_MOV64_REG(R9, R8),
  1754				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  1755				BPF_ALU64_IMM(BPF_MOV, R1, 0),
  1756				BPF_ALU64_IMM(BPF_MOV, R2, 0),
  1757				BPF_ALU64_IMM(BPF_MOV, R3, 0),
  1758				BPF_ALU64_IMM(BPF_MOV, R4, 0),
  1759				BPF_ALU64_IMM(BPF_MOV, R5, 0),
  1760				BPF_ALU64_IMM(BPF_MOV, R6, 0),
  1761				BPF_ALU64_IMM(BPF_MOV, R7, 0),
  1762				BPF_ALU64_IMM(BPF_MOV, R8, 0),
  1763				BPF_ALU64_IMM(BPF_MOV, R9, 0),
  1764				BPF_ALU64_REG(BPF_ADD, R0, R0),
  1765				BPF_ALU64_REG(BPF_ADD, R0, R1),
  1766				BPF_ALU64_REG(BPF_ADD, R0, R2),
  1767				BPF_ALU64_REG(BPF_ADD, R0, R3),
  1768				BPF_ALU64_REG(BPF_ADD, R0, R4),
  1769				BPF_ALU64_REG(BPF_ADD, R0, R5),
  1770				BPF_ALU64_REG(BPF_ADD, R0, R6),
  1771				BPF_ALU64_REG(BPF_ADD, R0, R7),
  1772				BPF_ALU64_REG(BPF_ADD, R0, R8),
  1773				BPF_ALU64_REG(BPF_ADD, R0, R9),
  1774				BPF_ALU64_IMM(BPF_ADD, R0, 0xfefe),
  1775				BPF_EXIT_INSN(),
  1776			},
  1777			INTERNAL,
  1778			{ },
  1779			{ { 0, 0xfefe } }
  1780		},
  1781		{	/* Mainly checking JIT here. */
  1782			"MOV REG32",
  1783			.u.insns_int = {
  1784				BPF_LD_IMM64(R0, 0xffffffffffffffffLL),
  1785				BPF_MOV64_REG(R1, R0),
  1786				BPF_MOV64_REG(R2, R1),
  1787				BPF_MOV64_REG(R3, R2),
  1788				BPF_MOV64_REG(R4, R3),
  1789				BPF_MOV64_REG(R5, R4),
  1790				BPF_MOV64_REG(R6, R5),
  1791				BPF_MOV64_REG(R7, R6),
  1792				BPF_MOV64_REG(R8, R7),
  1793				BPF_MOV64_REG(R9, R8),
  1794				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  1795				BPF_ALU32_IMM(BPF_MOV, R1, 0),
  1796				BPF_ALU32_IMM(BPF_MOV, R2, 0),
  1797				BPF_ALU32_IMM(BPF_MOV, R3, 0),
  1798				BPF_ALU32_IMM(BPF_MOV, R4, 0),
  1799				BPF_ALU32_IMM(BPF_MOV, R5, 0),
  1800				BPF_ALU32_IMM(BPF_MOV, R6, 0),
  1801				BPF_ALU32_IMM(BPF_MOV, R7, 0),
  1802				BPF_ALU32_IMM(BPF_MOV, R8, 0),
  1803				BPF_ALU32_IMM(BPF_MOV, R9, 0),
  1804				BPF_ALU64_REG(BPF_ADD, R0, R0),
  1805				BPF_ALU64_REG(BPF_ADD, R0, R1),
  1806				BPF_ALU64_REG(BPF_ADD, R0, R2),
  1807				BPF_ALU64_REG(BPF_ADD, R0, R3),
  1808				BPF_ALU64_REG(BPF_ADD, R0, R4),
  1809				BPF_ALU64_REG(BPF_ADD, R0, R5),
  1810				BPF_ALU64_REG(BPF_ADD, R0, R6),
  1811				BPF_ALU64_REG(BPF_ADD, R0, R7),
  1812				BPF_ALU64_REG(BPF_ADD, R0, R8),
  1813				BPF_ALU64_REG(BPF_ADD, R0, R9),
  1814				BPF_ALU64_IMM(BPF_ADD, R0, 0xfefe),
  1815				BPF_EXIT_INSN(),
  1816			},
  1817			INTERNAL,
  1818			{ },
  1819			{ { 0, 0xfefe } }
  1820		},
  1821		{	/* Mainly checking JIT here. */
  1822			"LD IMM64",
  1823			.u.insns_int = {
  1824				BPF_LD_IMM64(R0, 0xffffffffffffffffLL),
  1825				BPF_MOV64_REG(R1, R0),
  1826				BPF_MOV64_REG(R2, R1),
  1827				BPF_MOV64_REG(R3, R2),
  1828				BPF_MOV64_REG(R4, R3),
  1829				BPF_MOV64_REG(R5, R4),
  1830				BPF_MOV64_REG(R6, R5),
  1831				BPF_MOV64_REG(R7, R6),
  1832				BPF_MOV64_REG(R8, R7),
  1833				BPF_MOV64_REG(R9, R8),
  1834				BPF_LD_IMM64(R0, 0x0LL),
  1835				BPF_LD_IMM64(R1, 0x0LL),
  1836				BPF_LD_IMM64(R2, 0x0LL),
  1837				BPF_LD_IMM64(R3, 0x0LL),
  1838				BPF_LD_IMM64(R4, 0x0LL),
  1839				BPF_LD_IMM64(R5, 0x0LL),
  1840				BPF_LD_IMM64(R6, 0x0LL),
  1841				BPF_LD_IMM64(R7, 0x0LL),
  1842				BPF_LD_IMM64(R8, 0x0LL),
  1843				BPF_LD_IMM64(R9, 0x0LL),
  1844				BPF_ALU64_REG(BPF_ADD, R0, R0),
  1845				BPF_ALU64_REG(BPF_ADD, R0, R1),
  1846				BPF_ALU64_REG(BPF_ADD, R0, R2),
  1847				BPF_ALU64_REG(BPF_ADD, R0, R3),
  1848				BPF_ALU64_REG(BPF_ADD, R0, R4),
  1849				BPF_ALU64_REG(BPF_ADD, R0, R5),
  1850				BPF_ALU64_REG(BPF_ADD, R0, R6),
  1851				BPF_ALU64_REG(BPF_ADD, R0, R7),
  1852				BPF_ALU64_REG(BPF_ADD, R0, R8),
  1853				BPF_ALU64_REG(BPF_ADD, R0, R9),
  1854				BPF_ALU64_IMM(BPF_ADD, R0, 0xfefe),
  1855				BPF_EXIT_INSN(),
  1856			},
  1857			INTERNAL,
  1858			{ },
  1859			{ { 0, 0xfefe } }
  1860		},
  1861		{
  1862			"INT: ALU MIX",
  1863			.u.insns_int = {
  1864				BPF_ALU64_IMM(BPF_MOV, R0, 11),
  1865				BPF_ALU64_IMM(BPF_ADD, R0, -1),
  1866				BPF_ALU64_IMM(BPF_MOV, R2, 2),
  1867				BPF_ALU64_IMM(BPF_XOR, R2, 3),
  1868				BPF_ALU64_REG(BPF_DIV, R0, R2),
  1869				BPF_JMP_IMM(BPF_JEQ, R0, 10, 1),
  1870				BPF_EXIT_INSN(),
  1871				BPF_ALU64_IMM(BPF_MOD, R0, 3),
  1872				BPF_JMP_IMM(BPF_JEQ, R0, 1, 1),
  1873				BPF_EXIT_INSN(),
  1874				BPF_ALU64_IMM(BPF_MOV, R0, -1),
  1875				BPF_EXIT_INSN(),
  1876			},
  1877			INTERNAL,
  1878			{ },
  1879			{ { 0, -1 } }
  1880		},
  1881		{
  1882			"INT: shifts by register",
  1883			.u.insns_int = {
  1884				BPF_MOV64_IMM(R0, -1234),
  1885				BPF_MOV64_IMM(R1, 1),
  1886				BPF_ALU32_REG(BPF_RSH, R0, R1),
  1887				BPF_JMP_IMM(BPF_JEQ, R0, 0x7ffffd97, 1),
  1888				BPF_EXIT_INSN(),
  1889				BPF_MOV64_IMM(R2, 1),
  1890				BPF_ALU64_REG(BPF_LSH, R0, R2),
  1891				BPF_MOV32_IMM(R4, -1234),
  1892				BPF_JMP_REG(BPF_JEQ, R0, R4, 1),
  1893				BPF_EXIT_INSN(),
  1894				BPF_ALU64_IMM(BPF_AND, R4, 63),
  1895				BPF_ALU64_REG(BPF_LSH, R0, R4), /* R0 <= 46 */
  1896				BPF_MOV64_IMM(R3, 47),
  1897				BPF_ALU64_REG(BPF_ARSH, R0, R3),
  1898				BPF_JMP_IMM(BPF_JEQ, R0, -617, 1),
  1899				BPF_EXIT_INSN(),
  1900				BPF_MOV64_IMM(R2, 1),
  1901				BPF_ALU64_REG(BPF_LSH, R4, R2), /* R4 = 46 << 1 */
  1902				BPF_JMP_IMM(BPF_JEQ, R4, 92, 1),
  1903				BPF_EXIT_INSN(),
  1904				BPF_MOV64_IMM(R4, 4),
  1905				BPF_ALU64_REG(BPF_LSH, R4, R4), /* R4 = 4 << 4 */
  1906				BPF_JMP_IMM(BPF_JEQ, R4, 64, 1),
  1907				BPF_EXIT_INSN(),
  1908				BPF_MOV64_IMM(R4, 5),
  1909				BPF_ALU32_REG(BPF_LSH, R4, R4), /* R4 = 5 << 5 */
  1910				BPF_JMP_IMM(BPF_JEQ, R4, 160, 1),
  1911				BPF_EXIT_INSN(),
  1912				BPF_MOV64_IMM(R0, -1),
  1913				BPF_EXIT_INSN(),
  1914			},
  1915			INTERNAL,
  1916			{ },
  1917			{ { 0, -1 } }
  1918		},
  1919		{
  1920			/*
  1921			 * Register (non-)clobbering test, in the case where a 32-bit
  1922			 * JIT implements complex ALU64 operations via function calls.
  1923			 * If so, the function call must be invisible in the eBPF
  1924			 * registers. The JIT must then save and restore relevant
  1925			 * registers during the call. The following tests check that
  1926			 * the eBPF registers retain their values after such a call.
  1927			 */
  1928			"INT: Register clobbering, R1 updated",
  1929			.u.insns_int = {
  1930				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  1931				BPF_ALU32_IMM(BPF_MOV, R1, 123456789),
  1932				BPF_ALU32_IMM(BPF_MOV, R2, 2),
  1933				BPF_ALU32_IMM(BPF_MOV, R3, 3),
  1934				BPF_ALU32_IMM(BPF_MOV, R4, 4),
  1935				BPF_ALU32_IMM(BPF_MOV, R5, 5),
  1936				BPF_ALU32_IMM(BPF_MOV, R6, 6),
  1937				BPF_ALU32_IMM(BPF_MOV, R7, 7),
  1938				BPF_ALU32_IMM(BPF_MOV, R8, 8),
  1939				BPF_ALU32_IMM(BPF_MOV, R9, 9),
  1940				BPF_ALU64_IMM(BPF_DIV, R1, 123456789),
  1941				BPF_JMP_IMM(BPF_JNE, R0, 0, 10),
  1942				BPF_JMP_IMM(BPF_JNE, R1, 1, 9),
  1943				BPF_JMP_IMM(BPF_JNE, R2, 2, 8),
  1944				BPF_JMP_IMM(BPF_JNE, R3, 3, 7),
  1945				BPF_JMP_IMM(BPF_JNE, R4, 4, 6),
  1946				BPF_JMP_IMM(BPF_JNE, R5, 5, 5),
  1947				BPF_JMP_IMM(BPF_JNE, R6, 6, 4),
  1948				BPF_JMP_IMM(BPF_JNE, R7, 7, 3),
  1949				BPF_JMP_IMM(BPF_JNE, R8, 8, 2),
  1950				BPF_JMP_IMM(BPF_JNE, R9, 9, 1),
  1951				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  1952				BPF_EXIT_INSN(),
  1953			},
  1954			INTERNAL,
  1955			{ },
  1956			{ { 0, 1 } }
  1957		},
  1958		{
  1959			"INT: Register clobbering, R2 updated",
  1960			.u.insns_int = {
  1961				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  1962				BPF_ALU32_IMM(BPF_MOV, R1, 1),
  1963				BPF_ALU32_IMM(BPF_MOV, R2, 2 * 123456789),
  1964				BPF_ALU32_IMM(BPF_MOV, R3, 3),
  1965				BPF_ALU32_IMM(BPF_MOV, R4, 4),
  1966				BPF_ALU32_IMM(BPF_MOV, R5, 5),
  1967				BPF_ALU32_IMM(BPF_MOV, R6, 6),
  1968				BPF_ALU32_IMM(BPF_MOV, R7, 7),
  1969				BPF_ALU32_IMM(BPF_MOV, R8, 8),
  1970				BPF_ALU32_IMM(BPF_MOV, R9, 9),
  1971				BPF_ALU64_IMM(BPF_DIV, R2, 123456789),
  1972				BPF_JMP_IMM(BPF_JNE, R0, 0, 10),
  1973				BPF_JMP_IMM(BPF_JNE, R1, 1, 9),
  1974				BPF_JMP_IMM(BPF_JNE, R2, 2, 8),
  1975				BPF_JMP_IMM(BPF_JNE, R3, 3, 7),
  1976				BPF_JMP_IMM(BPF_JNE, R4, 4, 6),
  1977				BPF_JMP_IMM(BPF_JNE, R5, 5, 5),
  1978				BPF_JMP_IMM(BPF_JNE, R6, 6, 4),
  1979				BPF_JMP_IMM(BPF_JNE, R7, 7, 3),
  1980				BPF_JMP_IMM(BPF_JNE, R8, 8, 2),
  1981				BPF_JMP_IMM(BPF_JNE, R9, 9, 1),
  1982				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  1983				BPF_EXIT_INSN(),
  1984			},
  1985			INTERNAL,
  1986			{ },
  1987			{ { 0, 1 } }
  1988		},
  1989		{
  1990			/*
  1991			 * Test 32-bit JITs that implement complex ALU64 operations as
  1992			 * function calls R0 = f(R1, R2), and must re-arrange operands.
  1993			 */
  1994	#define NUMER 0xfedcba9876543210ULL
  1995	#define DENOM 0x0123456789abcdefULL
  1996			"ALU64_DIV X: Operand register permutations",
  1997			.u.insns_int = {
  1998				/* R0 / R2 */
> 1999				BPF_LD_IMM64(R0, NUMER),
  2000				BPF_LD_IMM64(R2, DENOM),
  2001				BPF_ALU64_REG(BPF_DIV, R0, R2),
  2002				BPF_JMP_IMM(BPF_JEQ, R0, NUMER / DENOM, 1),
  2003				BPF_EXIT_INSN(),
  2004				/* R1 / R0 */
  2005				BPF_LD_IMM64(R1, NUMER),
  2006				BPF_LD_IMM64(R0, DENOM),
  2007				BPF_ALU64_REG(BPF_DIV, R1, R0),
  2008				BPF_JMP_IMM(BPF_JEQ, R1, NUMER / DENOM, 1),
  2009				BPF_EXIT_INSN(),
  2010				/* R0 / R1 */
  2011				BPF_LD_IMM64(R0, NUMER),
  2012				BPF_LD_IMM64(R1, DENOM),
  2013				BPF_ALU64_REG(BPF_DIV, R0, R1),
  2014				BPF_JMP_IMM(BPF_JEQ, R0, NUMER / DENOM, 1),
  2015				BPF_EXIT_INSN(),
  2016				/* R2 / R0 */
  2017				BPF_LD_IMM64(R2, NUMER),
  2018				BPF_LD_IMM64(R0, DENOM),
  2019				BPF_ALU64_REG(BPF_DIV, R2, R0),
  2020				BPF_JMP_IMM(BPF_JEQ, R2, NUMER / DENOM, 1),
  2021				BPF_EXIT_INSN(),
  2022				/* R2 / R1 */
  2023				BPF_LD_IMM64(R2, NUMER),
  2024				BPF_LD_IMM64(R1, DENOM),
  2025				BPF_ALU64_REG(BPF_DIV, R2, R1),
  2026				BPF_JMP_IMM(BPF_JEQ, R2, NUMER / DENOM, 1),
  2027				BPF_EXIT_INSN(),
  2028				/* R1 / R2 */
  2029				BPF_LD_IMM64(R1, NUMER),
  2030				BPF_LD_IMM64(R2, DENOM),
  2031				BPF_ALU64_REG(BPF_DIV, R1, R2),
  2032				BPF_JMP_IMM(BPF_JEQ, R1, NUMER / DENOM, 1),
  2033				BPF_EXIT_INSN(),
  2034				/* R1 / R1 */
  2035				BPF_LD_IMM64(R1, NUMER),
  2036				BPF_ALU64_REG(BPF_DIV, R1, R1),
  2037				BPF_JMP_IMM(BPF_JEQ, R1, 1, 1),
  2038				BPF_EXIT_INSN(),
  2039				/* R2 / R2 */
  2040				BPF_LD_IMM64(R2, DENOM),
  2041				BPF_ALU64_REG(BPF_DIV, R2, R2),
  2042				BPF_JMP_IMM(BPF_JEQ, R2, 1, 1),
  2043				BPF_EXIT_INSN(),
  2044				/* R3 / R4 */
  2045				BPF_LD_IMM64(R3, NUMER),
  2046				BPF_LD_IMM64(R4, DENOM),
  2047				BPF_ALU64_REG(BPF_DIV, R3, R4),
  2048				BPF_JMP_IMM(BPF_JEQ, R3, NUMER / DENOM, 1),
  2049				BPF_EXIT_INSN(),
  2050				/* Successful return */
  2051				BPF_LD_IMM64(R0, 1),
  2052				BPF_EXIT_INSN(),
  2053			},
  2054			INTERNAL,
  2055			{ },
  2056			{ { 0, 1 } },
  2057	#undef NUMER
  2058	#undef DENOM
  2059		},
  2060		{
  2061			"check: missing ret",
  2062			.u.insns = {
  2063				BPF_STMT(BPF_LD | BPF_IMM, 1),
  2064			},
  2065			CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
  2066			{ },
  2067			{ },
  2068			.fill_helper = NULL,
  2069			.expected_errcode = -EINVAL,
  2070		},
  2071		{
  2072			"check: div_k_0",
  2073			.u.insns = {
  2074				BPF_STMT(BPF_ALU | BPF_DIV | BPF_K, 0),
  2075				BPF_STMT(BPF_RET | BPF_K, 0)
  2076			},
  2077			CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
  2078			{ },
  2079			{ },
  2080			.fill_helper = NULL,
  2081			.expected_errcode = -EINVAL,
  2082		},
  2083		{
  2084			"check: unknown insn",
  2085			.u.insns = {
  2086				/* seccomp insn, rejected in socket filter */
  2087				BPF_STMT(BPF_LDX | BPF_W | BPF_ABS, 0),
  2088				BPF_STMT(BPF_RET | BPF_K, 0)
  2089			},
  2090			CLASSIC | FLAG_EXPECTED_FAIL,
  2091			{ },
  2092			{ },
  2093			.fill_helper = NULL,
  2094			.expected_errcode = -EINVAL,
  2095		},
  2096		{
  2097			"check: out of range spill/fill",
  2098			.u.insns = {
  2099				BPF_STMT(BPF_STX, 16),
  2100				BPF_STMT(BPF_RET | BPF_K, 0)
  2101			},
  2102			CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
  2103			{ },
  2104			{ },
  2105			.fill_helper = NULL,
  2106			.expected_errcode = -EINVAL,
  2107		},
  2108		{
  2109			"JUMPS + HOLES",
  2110			.u.insns = {
  2111				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2112				BPF_JUMP(BPF_JMP | BPF_JGE, 0, 13, 15),
  2113				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2114				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2115				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2116				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2117				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2118				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2119				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2120				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2121				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2122				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2123				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2124				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2125				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2126				BPF_JUMP(BPF_JMP | BPF_JEQ, 0x90c2894d, 3, 4),
  2127				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2128				BPF_JUMP(BPF_JMP | BPF_JEQ, 0x90c2894d, 1, 2),
  2129				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2130				BPF_JUMP(BPF_JMP | BPF_JGE, 0, 14, 15),
  2131				BPF_JUMP(BPF_JMP | BPF_JGE, 0, 13, 14),
  2132				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2133				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2134				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2135				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2136				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2137				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2138				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2139				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2140				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2141				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2142				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2143				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2144				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2145				BPF_JUMP(BPF_JMP | BPF_JEQ, 0x2ac28349, 2, 3),
  2146				BPF_JUMP(BPF_JMP | BPF_JEQ, 0x2ac28349, 1, 2),
  2147				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2148				BPF_JUMP(BPF_JMP | BPF_JGE, 0, 14, 15),
  2149				BPF_JUMP(BPF_JMP | BPF_JGE, 0, 13, 14),
  2150				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2151				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2152				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2153				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2154				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2155				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2156				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2157				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2158				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2159				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2160				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2161				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2162				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2163				BPF_JUMP(BPF_JMP | BPF_JEQ, 0x90d2ff41, 2, 3),
  2164				BPF_JUMP(BPF_JMP | BPF_JEQ, 0x90d2ff41, 1, 2),
  2165				BPF_STMT(BPF_LD | BPF_H | BPF_ABS, 0),
  2166				BPF_STMT(BPF_RET | BPF_A, 0),
  2167				BPF_STMT(BPF_RET | BPF_A, 0),
  2168			},
  2169			CLASSIC,
  2170			{ 0x00, 0x1b, 0x21, 0x3c, 0x9d, 0xf8,
  2171			  0x90, 0xe2, 0xba, 0x0a, 0x56, 0xb4,
  2172			  0x08, 0x00,
  2173			  0x45, 0x00, 0x00, 0x28, 0x00, 0x00,
  2174			  0x20, 0x00, 0x40, 0x11, 0x00, 0x00, /* IP header */
  2175			  0xc0, 0xa8, 0x33, 0x01,
  2176			  0xc0, 0xa8, 0x33, 0x02,
  2177			  0xbb, 0xb6,
  2178			  0xa9, 0xfa,
  2179			  0x00, 0x14, 0x00, 0x00,
  2180			  0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
  2181			  0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
  2182			  0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
  2183			  0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
  2184			  0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
  2185			  0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
  2186			  0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
  2187			  0xcc, 0xcc, 0xcc, 0xcc },
  2188			{ { 88, 0x001b } }
  2189		},
  2190		{
  2191			"check: RET X",
  2192			.u.insns = {
  2193				BPF_STMT(BPF_RET | BPF_X, 0),
  2194			},
  2195			CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
  2196			{ },
  2197			{ },
  2198			.fill_helper = NULL,
  2199			.expected_errcode = -EINVAL,
  2200		},
  2201		{
  2202			"check: LDX + RET X",
  2203			.u.insns = {
  2204				BPF_STMT(BPF_LDX | BPF_IMM, 42),
  2205				BPF_STMT(BPF_RET | BPF_X, 0),
  2206			},
  2207			CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
  2208			{ },
  2209			{ },
  2210			.fill_helper = NULL,
  2211			.expected_errcode = -EINVAL,
  2212		},
  2213		{	/* Mainly checking JIT here. */
  2214			"M[]: alt STX + LDX",
  2215			.u.insns = {
  2216				BPF_STMT(BPF_LDX | BPF_IMM, 100),
  2217				BPF_STMT(BPF_STX, 0),
  2218				BPF_STMT(BPF_LDX | BPF_MEM, 0),
  2219				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  2220				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  2221				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2222				BPF_STMT(BPF_STX, 1),
  2223				BPF_STMT(BPF_LDX | BPF_MEM, 1),
  2224				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  2225				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  2226				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2227				BPF_STMT(BPF_STX, 2),
  2228				BPF_STMT(BPF_LDX | BPF_MEM, 2),
  2229				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  2230				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  2231				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2232				BPF_STMT(BPF_STX, 3),
  2233				BPF_STMT(BPF_LDX | BPF_MEM, 3),
  2234				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  2235				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  2236				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2237				BPF_STMT(BPF_STX, 4),
  2238				BPF_STMT(BPF_LDX | BPF_MEM, 4),
  2239				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  2240				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  2241				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2242				BPF_STMT(BPF_STX, 5),
  2243				BPF_STMT(BPF_LDX | BPF_MEM, 5),
  2244				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  2245				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  2246				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2247				BPF_STMT(BPF_STX, 6),
  2248				BPF_STMT(BPF_LDX | BPF_MEM, 6),
  2249				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  2250				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  2251				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2252				BPF_STMT(BPF_STX, 7),
  2253				BPF_STMT(BPF_LDX | BPF_MEM, 7),
  2254				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  2255				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  2256				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2257				BPF_STMT(BPF_STX, 8),
  2258				BPF_STMT(BPF_LDX | BPF_MEM, 8),
  2259				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  2260				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  2261				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2262				BPF_STMT(BPF_STX, 9),
  2263				BPF_STMT(BPF_LDX | BPF_MEM, 9),
  2264				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  2265				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  2266				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2267				BPF_STMT(BPF_STX, 10),
  2268				BPF_STMT(BPF_LDX | BPF_MEM, 10),
  2269				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  2270				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  2271				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2272				BPF_STMT(BPF_STX, 11),
  2273				BPF_STMT(BPF_LDX | BPF_MEM, 11),
  2274				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  2275				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  2276				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2277				BPF_STMT(BPF_STX, 12),
  2278				BPF_STMT(BPF_LDX | BPF_MEM, 12),
  2279				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  2280				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  2281				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2282				BPF_STMT(BPF_STX, 13),
  2283				BPF_STMT(BPF_LDX | BPF_MEM, 13),
  2284				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  2285				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  2286				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2287				BPF_STMT(BPF_STX, 14),
  2288				BPF_STMT(BPF_LDX | BPF_MEM, 14),
  2289				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  2290				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  2291				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2292				BPF_STMT(BPF_STX, 15),
  2293				BPF_STMT(BPF_LDX | BPF_MEM, 15),
  2294				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  2295				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 1),
  2296				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  2297				BPF_STMT(BPF_RET | BPF_A, 0),
  2298			},
  2299			CLASSIC | FLAG_NO_DATA,
  2300			{ },
  2301			{ { 0, 116 } },
  2302		},
  2303		{	/* Mainly checking JIT here. */
  2304			"M[]: full STX + full LDX",
  2305			.u.insns = {
  2306				BPF_STMT(BPF_LDX | BPF_IMM, 0xbadfeedb),
  2307				BPF_STMT(BPF_STX, 0),
  2308				BPF_STMT(BPF_LDX | BPF_IMM, 0xecabedae),
  2309				BPF_STMT(BPF_STX, 1),
  2310				BPF_STMT(BPF_LDX | BPF_IMM, 0xafccfeaf),
  2311				BPF_STMT(BPF_STX, 2),
  2312				BPF_STMT(BPF_LDX | BPF_IMM, 0xbffdcedc),
  2313				BPF_STMT(BPF_STX, 3),
  2314				BPF_STMT(BPF_LDX | BPF_IMM, 0xfbbbdccb),
  2315				BPF_STMT(BPF_STX, 4),
  2316				BPF_STMT(BPF_LDX | BPF_IMM, 0xfbabcbda),
  2317				BPF_STMT(BPF_STX, 5),
  2318				BPF_STMT(BPF_LDX | BPF_IMM, 0xaedecbdb),
  2319				BPF_STMT(BPF_STX, 6),
  2320				BPF_STMT(BPF_LDX | BPF_IMM, 0xadebbade),
  2321				BPF_STMT(BPF_STX, 7),
  2322				BPF_STMT(BPF_LDX | BPF_IMM, 0xfcfcfaec),
  2323				BPF_STMT(BPF_STX, 8),
  2324				BPF_STMT(BPF_LDX | BPF_IMM, 0xbcdddbdc),
  2325				BPF_STMT(BPF_STX, 9),
  2326				BPF_STMT(BPF_LDX | BPF_IMM, 0xfeefdfac),
  2327				BPF_STMT(BPF_STX, 10),
  2328				BPF_STMT(BPF_LDX | BPF_IMM, 0xcddcdeea),
  2329				BPF_STMT(BPF_STX, 11),
  2330				BPF_STMT(BPF_LDX | BPF_IMM, 0xaccfaebb),
  2331				BPF_STMT(BPF_STX, 12),
  2332				BPF_STMT(BPF_LDX | BPF_IMM, 0xbdcccdcf),
  2333				BPF_STMT(BPF_STX, 13),
  2334				BPF_STMT(BPF_LDX | BPF_IMM, 0xaaedecde),
  2335				BPF_STMT(BPF_STX, 14),
  2336				BPF_STMT(BPF_LDX | BPF_IMM, 0xfaeacdad),
  2337				BPF_STMT(BPF_STX, 15),
  2338				BPF_STMT(BPF_LDX | BPF_MEM, 0),
  2339				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  2340				BPF_STMT(BPF_LDX | BPF_MEM, 1),
  2341				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  2342				BPF_STMT(BPF_LDX | BPF_MEM, 2),
  2343				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  2344				BPF_STMT(BPF_LDX | BPF_MEM, 3),
  2345				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  2346				BPF_STMT(BPF_LDX | BPF_MEM, 4),
  2347				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  2348				BPF_STMT(BPF_LDX | BPF_MEM, 5),
  2349				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  2350				BPF_STMT(BPF_LDX | BPF_MEM, 6),
  2351				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  2352				BPF_STMT(BPF_LDX | BPF_MEM, 7),
  2353				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  2354				BPF_STMT(BPF_LDX | BPF_MEM, 8),
  2355				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  2356				BPF_STMT(BPF_LDX | BPF_MEM, 9),
  2357				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  2358				BPF_STMT(BPF_LDX | BPF_MEM, 10),
  2359				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  2360				BPF_STMT(BPF_LDX | BPF_MEM, 11),
  2361				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  2362				BPF_STMT(BPF_LDX | BPF_MEM, 12),
  2363				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  2364				BPF_STMT(BPF_LDX | BPF_MEM, 13),
  2365				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  2366				BPF_STMT(BPF_LDX | BPF_MEM, 14),
  2367				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  2368				BPF_STMT(BPF_LDX | BPF_MEM, 15),
  2369				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  2370				BPF_STMT(BPF_RET | BPF_A, 0),
  2371			},
  2372			CLASSIC | FLAG_NO_DATA,
  2373			{ },
  2374			{ { 0, 0x2a5a5e5 } },
  2375		},
  2376		{
  2377			"check: SKF_AD_MAX",
  2378			.u.insns = {
  2379				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2380					 SKF_AD_OFF + SKF_AD_MAX),
  2381				BPF_STMT(BPF_RET | BPF_A, 0),
  2382			},
  2383			CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
  2384			{ },
  2385			{ },
  2386			.fill_helper = NULL,
  2387			.expected_errcode = -EINVAL,
  2388		},
  2389		{	/* Passes checker but fails during runtime. */
  2390			"LD [SKF_AD_OFF-1]",
  2391			.u.insns = {
  2392				BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
  2393					 SKF_AD_OFF - 1),
  2394				BPF_STMT(BPF_RET | BPF_K, 1),
  2395			},
  2396			CLASSIC,
  2397			{ },
  2398			{ { 1, 0 } },
  2399		},
  2400		{
  2401			"load 64-bit immediate",
  2402			.u.insns_int = {
  2403				BPF_LD_IMM64(R1, 0x567800001234LL),
  2404				BPF_MOV64_REG(R2, R1),
  2405				BPF_MOV64_REG(R3, R2),
  2406				BPF_ALU64_IMM(BPF_RSH, R2, 32),
  2407				BPF_ALU64_IMM(BPF_LSH, R3, 32),
  2408				BPF_ALU64_IMM(BPF_RSH, R3, 32),
  2409				BPF_ALU64_IMM(BPF_MOV, R0, 0),
  2410				BPF_JMP_IMM(BPF_JEQ, R2, 0x5678, 1),
  2411				BPF_EXIT_INSN(),
  2412				BPF_JMP_IMM(BPF_JEQ, R3, 0x1234, 1),
  2413				BPF_EXIT_INSN(),
  2414				BPF_LD_IMM64(R0, 0x1ffffffffLL),
  2415				BPF_ALU64_IMM(BPF_RSH, R0, 32), /* R0 = 1 */
  2416				BPF_EXIT_INSN(),
  2417			},
  2418			INTERNAL,
  2419			{ },
  2420			{ { 0, 1 } }
  2421		},
  2422		/* BPF_ALU | BPF_MOV | BPF_X */
  2423		{
  2424			"ALU_MOV_X: dst = 2",
  2425			.u.insns_int = {
  2426				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  2427				BPF_ALU32_REG(BPF_MOV, R0, R1),
  2428				BPF_EXIT_INSN(),
  2429			},
  2430			INTERNAL,
  2431			{ },
  2432			{ { 0, 2 } },
  2433		},
  2434		{
  2435			"ALU_MOV_X: dst = 4294967295",
  2436			.u.insns_int = {
  2437				BPF_ALU32_IMM(BPF_MOV, R1, 4294967295U),
  2438				BPF_ALU32_REG(BPF_MOV, R0, R1),
  2439				BPF_EXIT_INSN(),
  2440			},
  2441			INTERNAL,
  2442			{ },
  2443			{ { 0, 4294967295U } },
  2444		},
  2445		{
  2446			"ALU64_MOV_X: dst = 2",
  2447			.u.insns_int = {
  2448				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  2449				BPF_ALU64_REG(BPF_MOV, R0, R1),
  2450				BPF_EXIT_INSN(),
  2451			},
  2452			INTERNAL,
  2453			{ },
  2454			{ { 0, 2 } },
  2455		},
  2456		{
  2457			"ALU64_MOV_X: dst = 4294967295",
  2458			.u.insns_int = {
  2459				BPF_ALU32_IMM(BPF_MOV, R1, 4294967295U),
  2460				BPF_ALU64_REG(BPF_MOV, R0, R1),
  2461				BPF_EXIT_INSN(),
  2462			},
  2463			INTERNAL,
  2464			{ },
  2465			{ { 0, 4294967295U } },
  2466		},
  2467		/* BPF_ALU | BPF_MOV | BPF_K */
  2468		{
  2469			"ALU_MOV_K: dst = 2",
  2470			.u.insns_int = {
  2471				BPF_ALU32_IMM(BPF_MOV, R0, 2),
  2472				BPF_EXIT_INSN(),
  2473			},
  2474			INTERNAL,
  2475			{ },
  2476			{ { 0, 2 } },
  2477		},
  2478		{
  2479			"ALU_MOV_K: dst = 4294967295",
  2480			.u.insns_int = {
  2481				BPF_ALU32_IMM(BPF_MOV, R0, 4294967295U),
  2482				BPF_EXIT_INSN(),
  2483			},
  2484			INTERNAL,
  2485			{ },
  2486			{ { 0, 4294967295U } },
  2487		},
  2488		{
  2489			"ALU_MOV_K: 0x0000ffffffff0000 = 0x00000000ffffffff",
  2490			.u.insns_int = {
  2491				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  2492				BPF_LD_IMM64(R3, 0x00000000ffffffffLL),
  2493				BPF_ALU32_IMM(BPF_MOV, R2, 0xffffffff),
  2494				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  2495				BPF_MOV32_IMM(R0, 2),
  2496				BPF_EXIT_INSN(),
  2497				BPF_MOV32_IMM(R0, 1),
  2498				BPF_EXIT_INSN(),
  2499			},
  2500			INTERNAL,
  2501			{ },
  2502			{ { 0, 0x1 } },
  2503		},
  2504		{
  2505			"ALU_MOV_K: small negative",
  2506			.u.insns_int = {
  2507				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  2508				BPF_EXIT_INSN(),
  2509			},
  2510			INTERNAL,
  2511			{ },
  2512			{ { 0, -123 } }
  2513		},
  2514		{
  2515			"ALU_MOV_K: small negative zero extension",
  2516			.u.insns_int = {
  2517				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  2518				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  2519				BPF_EXIT_INSN(),
  2520			},
  2521			INTERNAL,
  2522			{ },
  2523			{ { 0, 0 } }
  2524		},
  2525		{
  2526			"ALU_MOV_K: large negative",
  2527			.u.insns_int = {
  2528				BPF_ALU32_IMM(BPF_MOV, R0, -123456789),
  2529				BPF_EXIT_INSN(),
  2530			},
  2531			INTERNAL,
  2532			{ },
  2533			{ { 0, -123456789 } }
  2534		},
  2535		{
  2536			"ALU_MOV_K: large negative zero extension",
  2537			.u.insns_int = {
  2538				BPF_ALU32_IMM(BPF_MOV, R0, -123456789),
  2539				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  2540				BPF_EXIT_INSN(),
  2541			},
  2542			INTERNAL,
  2543			{ },
  2544			{ { 0, 0 } }
  2545		},
  2546		{
  2547			"ALU64_MOV_K: dst = 2",
  2548			.u.insns_int = {
  2549				BPF_ALU64_IMM(BPF_MOV, R0, 2),
  2550				BPF_EXIT_INSN(),
  2551			},
  2552			INTERNAL,
  2553			{ },
  2554			{ { 0, 2 } },
  2555		},
  2556		{
  2557			"ALU64_MOV_K: dst = 2147483647",
  2558			.u.insns_int = {
  2559				BPF_ALU64_IMM(BPF_MOV, R0, 2147483647),
  2560				BPF_EXIT_INSN(),
  2561			},
  2562			INTERNAL,
  2563			{ },
  2564			{ { 0, 2147483647 } },
  2565		},
  2566		{
  2567			"ALU64_OR_K: dst = 0x0",
  2568			.u.insns_int = {
  2569				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  2570				BPF_LD_IMM64(R3, 0x0),
  2571				BPF_ALU64_IMM(BPF_MOV, R2, 0x0),
  2572				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  2573				BPF_MOV32_IMM(R0, 2),
  2574				BPF_EXIT_INSN(),
  2575				BPF_MOV32_IMM(R0, 1),
  2576				BPF_EXIT_INSN(),
  2577			},
  2578			INTERNAL,
  2579			{ },
  2580			{ { 0, 0x1 } },
  2581		},
  2582		{
  2583			"ALU64_MOV_K: dst = -1",
  2584			.u.insns_int = {
  2585				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  2586				BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
  2587				BPF_ALU64_IMM(BPF_MOV, R2, 0xffffffff),
  2588				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  2589				BPF_MOV32_IMM(R0, 2),
  2590				BPF_EXIT_INSN(),
  2591				BPF_MOV32_IMM(R0, 1),
  2592				BPF_EXIT_INSN(),
  2593			},
  2594			INTERNAL,
  2595			{ },
  2596			{ { 0, 0x1 } },
  2597		},
  2598		{
  2599			"ALU64_MOV_K: small negative",
  2600			.u.insns_int = {
  2601				BPF_ALU64_IMM(BPF_MOV, R0, -123),
  2602				BPF_EXIT_INSN(),
  2603			},
  2604			INTERNAL,
  2605			{ },
  2606			{ { 0, -123 } }
  2607		},
  2608		{
  2609			"ALU64_MOV_K: small negative sign extension",
  2610			.u.insns_int = {
  2611				BPF_ALU64_IMM(BPF_MOV, R0, -123),
  2612				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  2613				BPF_EXIT_INSN(),
  2614			},
  2615			INTERNAL,
  2616			{ },
  2617			{ { 0, 0xffffffff } }
  2618		},
  2619		{
  2620			"ALU64_MOV_K: large negative",
  2621			.u.insns_int = {
  2622				BPF_ALU64_IMM(BPF_MOV, R0, -123456789),
  2623				BPF_EXIT_INSN(),
  2624			},
  2625			INTERNAL,
  2626			{ },
  2627			{ { 0, -123456789 } }
  2628		},
  2629		{
  2630			"ALU64_MOV_K: large negative sign extension",
  2631			.u.insns_int = {
  2632				BPF_ALU64_IMM(BPF_MOV, R0, -123456789),
  2633				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  2634				BPF_EXIT_INSN(),
  2635			},
  2636			INTERNAL,
  2637			{ },
  2638			{ { 0, 0xffffffff } }
  2639		},
  2640		/* BPF_ALU | BPF_ADD | BPF_X */
  2641		{
  2642			"ALU_ADD_X: 1 + 2 = 3",
  2643			.u.insns_int = {
  2644				BPF_LD_IMM64(R0, 1),
  2645				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  2646				BPF_ALU32_REG(BPF_ADD, R0, R1),
  2647				BPF_EXIT_INSN(),
  2648			},
  2649			INTERNAL,
  2650			{ },
  2651			{ { 0, 3 } },
  2652		},
  2653		{
  2654			"ALU_ADD_X: 1 + 4294967294 = 4294967295",
  2655			.u.insns_int = {
  2656				BPF_LD_IMM64(R0, 1),
  2657				BPF_ALU32_IMM(BPF_MOV, R1, 4294967294U),
  2658				BPF_ALU32_REG(BPF_ADD, R0, R1),
  2659				BPF_EXIT_INSN(),
  2660			},
  2661			INTERNAL,
  2662			{ },
  2663			{ { 0, 4294967295U } },
  2664		},
  2665		{
  2666			"ALU_ADD_X: 2 + 4294967294 = 0",
  2667			.u.insns_int = {
  2668				BPF_LD_IMM64(R0, 2),
  2669				BPF_LD_IMM64(R1, 4294967294U),
  2670				BPF_ALU32_REG(BPF_ADD, R0, R1),
  2671				BPF_JMP_IMM(BPF_JEQ, R0, 0, 2),
  2672				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  2673				BPF_EXIT_INSN(),
  2674				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  2675				BPF_EXIT_INSN(),
  2676			},
  2677			INTERNAL,
  2678			{ },
  2679			{ { 0, 1 } },
  2680		},
  2681		{
  2682			"ALU64_ADD_X: 1 + 2 = 3",
  2683			.u.insns_int = {
  2684				BPF_LD_IMM64(R0, 1),
  2685				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  2686				BPF_ALU64_REG(BPF_ADD, R0, R1),
  2687				BPF_EXIT_INSN(),
  2688			},
  2689			INTERNAL,
  2690			{ },
  2691			{ { 0, 3 } },
  2692		},
  2693		{
  2694			"ALU64_ADD_X: 1 + 4294967294 = 4294967295",
  2695			.u.insns_int = {
  2696				BPF_LD_IMM64(R0, 1),
  2697				BPF_ALU32_IMM(BPF_MOV, R1, 4294967294U),
  2698				BPF_ALU64_REG(BPF_ADD, R0, R1),
  2699				BPF_EXIT_INSN(),
  2700			},
  2701			INTERNAL,
  2702			{ },
  2703			{ { 0, 4294967295U } },
  2704		},
  2705		{
  2706			"ALU64_ADD_X: 2 + 4294967294 = 4294967296",
  2707			.u.insns_int = {
  2708				BPF_LD_IMM64(R0, 2),
  2709				BPF_LD_IMM64(R1, 4294967294U),
  2710				BPF_LD_IMM64(R2, 4294967296ULL),
  2711				BPF_ALU64_REG(BPF_ADD, R0, R1),
  2712				BPF_JMP_REG(BPF_JEQ, R0, R2, 2),
  2713				BPF_MOV32_IMM(R0, 0),
  2714				BPF_EXIT_INSN(),
  2715				BPF_MOV32_IMM(R0, 1),
  2716				BPF_EXIT_INSN(),
  2717			},
  2718			INTERNAL,
  2719			{ },
  2720			{ { 0, 1 } },
  2721		},
  2722		/* BPF_ALU | BPF_ADD | BPF_K */
  2723		{
  2724			"ALU_ADD_K: 1 + 2 = 3",
  2725			.u.insns_int = {
  2726				BPF_LD_IMM64(R0, 1),
  2727				BPF_ALU32_IMM(BPF_ADD, R0, 2),
  2728				BPF_EXIT_INSN(),
  2729			},
  2730			INTERNAL,
  2731			{ },
  2732			{ { 0, 3 } },
  2733		},
  2734		{
  2735			"ALU_ADD_K: 3 + 0 = 3",
  2736			.u.insns_int = {
  2737				BPF_LD_IMM64(R0, 3),
  2738				BPF_ALU32_IMM(BPF_ADD, R0, 0),
  2739				BPF_EXIT_INSN(),
  2740			},
  2741			INTERNAL,
  2742			{ },
  2743			{ { 0, 3 } },
  2744		},
  2745		{
  2746			"ALU_ADD_K: 1 + 4294967294 = 4294967295",
  2747			.u.insns_int = {
  2748				BPF_LD_IMM64(R0, 1),
  2749				BPF_ALU32_IMM(BPF_ADD, R0, 4294967294U),
  2750				BPF_EXIT_INSN(),
  2751			},
  2752			INTERNAL,
  2753			{ },
  2754			{ { 0, 4294967295U } },
  2755		},
  2756		{
  2757			"ALU_ADD_K: 4294967294 + 2 = 0",
  2758			.u.insns_int = {
  2759				BPF_LD_IMM64(R0, 4294967294U),
  2760				BPF_ALU32_IMM(BPF_ADD, R0, 2),
  2761				BPF_JMP_IMM(BPF_JEQ, R0, 0, 2),
  2762				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  2763				BPF_EXIT_INSN(),
  2764				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  2765				BPF_EXIT_INSN(),
  2766			},
  2767			INTERNAL,
  2768			{ },
  2769			{ { 0, 1 } },
  2770		},
  2771		{
  2772			"ALU_ADD_K: 0 + (-1) = 0x00000000ffffffff",
  2773			.u.insns_int = {
  2774				BPF_LD_IMM64(R2, 0x0),
  2775				BPF_LD_IMM64(R3, 0x00000000ffffffff),
  2776				BPF_ALU32_IMM(BPF_ADD, R2, 0xffffffff),
  2777				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  2778				BPF_MOV32_IMM(R0, 2),
  2779				BPF_EXIT_INSN(),
  2780				BPF_MOV32_IMM(R0, 1),
  2781				BPF_EXIT_INSN(),
  2782			},
  2783			INTERNAL,
  2784			{ },
  2785			{ { 0, 0x1 } },
  2786		},
  2787		{
  2788			"ALU_ADD_K: 0 + 0xffff = 0xffff",
  2789			.u.insns_int = {
  2790				BPF_LD_IMM64(R2, 0x0),
  2791				BPF_LD_IMM64(R3, 0xffff),
  2792				BPF_ALU32_IMM(BPF_ADD, R2, 0xffff),
  2793				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  2794				BPF_MOV32_IMM(R0, 2),
  2795				BPF_EXIT_INSN(),
  2796				BPF_MOV32_IMM(R0, 1),
  2797				BPF_EXIT_INSN(),
  2798			},
  2799			INTERNAL,
  2800			{ },
  2801			{ { 0, 0x1 } },
  2802		},
  2803		{
  2804			"ALU_ADD_K: 0 + 0x7fffffff = 0x7fffffff",
  2805			.u.insns_int = {
  2806				BPF_LD_IMM64(R2, 0x0),
  2807				BPF_LD_IMM64(R3, 0x7fffffff),
  2808				BPF_ALU32_IMM(BPF_ADD, R2, 0x7fffffff),
  2809				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  2810				BPF_MOV32_IMM(R0, 2),
  2811				BPF_EXIT_INSN(),
  2812				BPF_MOV32_IMM(R0, 1),
  2813				BPF_EXIT_INSN(),
  2814			},
  2815			INTERNAL,
  2816			{ },
  2817			{ { 0, 0x1 } },
  2818		},
  2819		{
  2820			"ALU_ADD_K: 0 + 0x80000000 = 0x80000000",
  2821			.u.insns_int = {
  2822				BPF_LD_IMM64(R2, 0x0),
  2823				BPF_LD_IMM64(R3, 0x80000000),
  2824				BPF_ALU32_IMM(BPF_ADD, R2, 0x80000000),
  2825				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  2826				BPF_MOV32_IMM(R0, 2),
  2827				BPF_EXIT_INSN(),
  2828				BPF_MOV32_IMM(R0, 1),
  2829				BPF_EXIT_INSN(),
  2830			},
  2831			INTERNAL,
  2832			{ },
  2833			{ { 0, 0x1 } },
  2834		},
  2835		{
  2836			"ALU_ADD_K: 0 + 0x80008000 = 0x80008000",
  2837			.u.insns_int = {
  2838				BPF_LD_IMM64(R2, 0x0),
  2839				BPF_LD_IMM64(R3, 0x80008000),
  2840				BPF_ALU32_IMM(BPF_ADD, R2, 0x80008000),
  2841				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  2842				BPF_MOV32_IMM(R0, 2),
  2843				BPF_EXIT_INSN(),
  2844				BPF_MOV32_IMM(R0, 1),
  2845				BPF_EXIT_INSN(),
  2846			},
  2847			INTERNAL,
  2848			{ },
  2849			{ { 0, 0x1 } },
  2850		},
  2851		{
  2852			"ALU64_ADD_K: 1 + 2 = 3",
  2853			.u.insns_int = {
  2854				BPF_LD_IMM64(R0, 1),
  2855				BPF_ALU64_IMM(BPF_ADD, R0, 2),
  2856				BPF_EXIT_INSN(),
  2857			},
  2858			INTERNAL,
  2859			{ },
  2860			{ { 0, 3 } },
  2861		},
  2862		{
  2863			"ALU64_ADD_K: 3 + 0 = 3",
  2864			.u.insns_int = {
  2865				BPF_LD_IMM64(R0, 3),
  2866				BPF_ALU64_IMM(BPF_ADD, R0, 0),
  2867				BPF_EXIT_INSN(),
  2868			},
  2869			INTERNAL,
  2870			{ },
  2871			{ { 0, 3 } },
  2872		},
  2873		{
  2874			"ALU64_ADD_K: 1 + 2147483646 = 2147483647",
  2875			.u.insns_int = {
  2876				BPF_LD_IMM64(R0, 1),
  2877				BPF_ALU64_IMM(BPF_ADD, R0, 2147483646),
  2878				BPF_EXIT_INSN(),
  2879			},
  2880			INTERNAL,
  2881			{ },
  2882			{ { 0, 2147483647 } },
  2883		},
  2884		{
  2885			"ALU64_ADD_K: 4294967294 + 2 = 4294967296",
  2886			.u.insns_int = {
  2887				BPF_LD_IMM64(R0, 4294967294U),
  2888				BPF_LD_IMM64(R1, 4294967296ULL),
  2889				BPF_ALU64_IMM(BPF_ADD, R0, 2),
  2890				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  2891				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  2892				BPF_EXIT_INSN(),
  2893				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  2894				BPF_EXIT_INSN(),
  2895			},
  2896			INTERNAL,
  2897			{ },
  2898			{ { 0, 1 } },
  2899		},
  2900		{
  2901			"ALU64_ADD_K: 2147483646 + -2147483647 = -1",
  2902			.u.insns_int = {
  2903				BPF_LD_IMM64(R0, 2147483646),
  2904				BPF_ALU64_IMM(BPF_ADD, R0, -2147483647),
  2905				BPF_EXIT_INSN(),
  2906			},
  2907			INTERNAL,
  2908			{ },
  2909			{ { 0, -1 } },
  2910		},
  2911		{
  2912			"ALU64_ADD_K: 1 + 0 = 1",
  2913			.u.insns_int = {
  2914				BPF_LD_IMM64(R2, 0x1),
  2915				BPF_LD_IMM64(R3, 0x1),
  2916				BPF_ALU64_IMM(BPF_ADD, R2, 0x0),
  2917				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  2918				BPF_MOV32_IMM(R0, 2),
  2919				BPF_EXIT_INSN(),
  2920				BPF_MOV32_IMM(R0, 1),
  2921				BPF_EXIT_INSN(),
  2922			},
  2923			INTERNAL,
  2924			{ },
  2925			{ { 0, 0x1 } },
  2926		},
  2927		{
  2928			"ALU64_ADD_K: 0 + (-1) = 0xffffffffffffffff",
  2929			.u.insns_int = {
  2930				BPF_LD_IMM64(R2, 0x0),
  2931				BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
  2932				BPF_ALU64_IMM(BPF_ADD, R2, 0xffffffff),
  2933				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  2934				BPF_MOV32_IMM(R0, 2),
  2935				BPF_EXIT_INSN(),
  2936				BPF_MOV32_IMM(R0, 1),
  2937				BPF_EXIT_INSN(),
  2938			},
  2939			INTERNAL,
  2940			{ },
  2941			{ { 0, 0x1 } },
  2942		},
  2943		{
  2944			"ALU64_ADD_K: 0 + 0xffff = 0xffff",
  2945			.u.insns_int = {
  2946				BPF_LD_IMM64(R2, 0x0),
  2947				BPF_LD_IMM64(R3, 0xffff),
  2948				BPF_ALU64_IMM(BPF_ADD, R2, 0xffff),
  2949				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  2950				BPF_MOV32_IMM(R0, 2),
  2951				BPF_EXIT_INSN(),
  2952				BPF_MOV32_IMM(R0, 1),
  2953				BPF_EXIT_INSN(),
  2954			},
  2955			INTERNAL,
  2956			{ },
  2957			{ { 0, 0x1 } },
  2958		},
  2959		{
  2960			"ALU64_ADD_K: 0 + 0x7fffffff = 0x7fffffff",
  2961			.u.insns_int = {
  2962				BPF_LD_IMM64(R2, 0x0),
  2963				BPF_LD_IMM64(R3, 0x7fffffff),
  2964				BPF_ALU64_IMM(BPF_ADD, R2, 0x7fffffff),
  2965				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  2966				BPF_MOV32_IMM(R0, 2),
  2967				BPF_EXIT_INSN(),
  2968				BPF_MOV32_IMM(R0, 1),
  2969				BPF_EXIT_INSN(),
  2970			},
  2971			INTERNAL,
  2972			{ },
  2973			{ { 0, 0x1 } },
  2974		},
  2975		{
  2976			"ALU64_ADD_K: 0 + 0x80000000 = 0xffffffff80000000",
  2977			.u.insns_int = {
  2978				BPF_LD_IMM64(R2, 0x0),
  2979				BPF_LD_IMM64(R3, 0xffffffff80000000LL),
  2980				BPF_ALU64_IMM(BPF_ADD, R2, 0x80000000),
  2981				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  2982				BPF_MOV32_IMM(R0, 2),
  2983				BPF_EXIT_INSN(),
  2984				BPF_MOV32_IMM(R0, 1),
  2985				BPF_EXIT_INSN(),
  2986			},
  2987			INTERNAL,
  2988			{ },
  2989			{ { 0, 0x1 } },
  2990		},
  2991		{
  2992			"ALU_ADD_K: 0 + 0x80008000 = 0xffffffff80008000",
  2993			.u.insns_int = {
  2994				BPF_LD_IMM64(R2, 0x0),
  2995				BPF_LD_IMM64(R3, 0xffffffff80008000LL),
  2996				BPF_ALU64_IMM(BPF_ADD, R2, 0x80008000),
  2997				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  2998				BPF_MOV32_IMM(R0, 2),
  2999				BPF_EXIT_INSN(),
  3000				BPF_MOV32_IMM(R0, 1),
  3001				BPF_EXIT_INSN(),
  3002			},
  3003			INTERNAL,
  3004			{ },
  3005			{ { 0, 0x1 } },
  3006		},
  3007		/* BPF_ALU | BPF_SUB | BPF_X */
  3008		{
  3009			"ALU_SUB_X: 3 - 1 = 2",
  3010			.u.insns_int = {
  3011				BPF_LD_IMM64(R0, 3),
  3012				BPF_ALU32_IMM(BPF_MOV, R1, 1),
  3013				BPF_ALU32_REG(BPF_SUB, R0, R1),
  3014				BPF_EXIT_INSN(),
  3015			},
  3016			INTERNAL,
  3017			{ },
  3018			{ { 0, 2 } },
  3019		},
  3020		{
  3021			"ALU_SUB_X: 4294967295 - 4294967294 = 1",
  3022			.u.insns_int = {
  3023				BPF_LD_IMM64(R0, 4294967295U),
  3024				BPF_ALU32_IMM(BPF_MOV, R1, 4294967294U),
  3025				BPF_ALU32_REG(BPF_SUB, R0, R1),
  3026				BPF_EXIT_INSN(),
  3027			},
  3028			INTERNAL,
  3029			{ },
  3030			{ { 0, 1 } },
  3031		},
  3032		{
  3033			"ALU64_SUB_X: 3 - 1 = 2",
  3034			.u.insns_int = {
  3035				BPF_LD_IMM64(R0, 3),
  3036				BPF_ALU32_IMM(BPF_MOV, R1, 1),
  3037				BPF_ALU64_REG(BPF_SUB, R0, R1),
  3038				BPF_EXIT_INSN(),
  3039			},
  3040			INTERNAL,
  3041			{ },
  3042			{ { 0, 2 } },
  3043		},
  3044		{
  3045			"ALU64_SUB_X: 4294967295 - 4294967294 = 1",
  3046			.u.insns_int = {
  3047				BPF_LD_IMM64(R0, 4294967295U),
  3048				BPF_ALU32_IMM(BPF_MOV, R1, 4294967294U),
  3049				BPF_ALU64_REG(BPF_SUB, R0, R1),
  3050				BPF_EXIT_INSN(),
  3051			},
  3052			INTERNAL,
  3053			{ },
  3054			{ { 0, 1 } },
  3055		},
  3056		/* BPF_ALU | BPF_SUB | BPF_K */
  3057		{
  3058			"ALU_SUB_K: 3 - 1 = 2",
  3059			.u.insns_int = {
  3060				BPF_LD_IMM64(R0, 3),
  3061				BPF_ALU32_IMM(BPF_SUB, R0, 1),
  3062				BPF_EXIT_INSN(),
  3063			},
  3064			INTERNAL,
  3065			{ },
  3066			{ { 0, 2 } },
  3067		},
  3068		{
  3069			"ALU_SUB_K: 3 - 0 = 3",
  3070			.u.insns_int = {
  3071				BPF_LD_IMM64(R0, 3),
  3072				BPF_ALU32_IMM(BPF_SUB, R0, 0),
  3073				BPF_EXIT_INSN(),
  3074			},
  3075			INTERNAL,
  3076			{ },
  3077			{ { 0, 3 } },
  3078		},
  3079		{
  3080			"ALU_SUB_K: 4294967295 - 4294967294 = 1",
  3081			.u.insns_int = {
  3082				BPF_LD_IMM64(R0, 4294967295U),
  3083				BPF_ALU32_IMM(BPF_SUB, R0, 4294967294U),
  3084				BPF_EXIT_INSN(),
  3085			},
  3086			INTERNAL,
  3087			{ },
  3088			{ { 0, 1 } },
  3089		},
  3090		{
  3091			"ALU64_SUB_K: 3 - 1 = 2",
  3092			.u.insns_int = {
  3093				BPF_LD_IMM64(R0, 3),
  3094				BPF_ALU64_IMM(BPF_SUB, R0, 1),
  3095				BPF_EXIT_INSN(),
  3096			},
  3097			INTERNAL,
  3098			{ },
  3099			{ { 0, 2 } },
  3100		},
  3101		{
  3102			"ALU64_SUB_K: 3 - 0 = 3",
  3103			.u.insns_int = {
  3104				BPF_LD_IMM64(R0, 3),
  3105				BPF_ALU64_IMM(BPF_SUB, R0, 0),
  3106				BPF_EXIT_INSN(),
  3107			},
  3108			INTERNAL,
  3109			{ },
  3110			{ { 0, 3 } },
  3111		},
  3112		{
  3113			"ALU64_SUB_K: 4294967294 - 4294967295 = -1",
  3114			.u.insns_int = {
  3115				BPF_LD_IMM64(R0, 4294967294U),
  3116				BPF_ALU64_IMM(BPF_SUB, R0, 4294967295U),
  3117				BPF_EXIT_INSN(),
  3118			},
  3119			INTERNAL,
  3120			{ },
  3121			{ { 0, -1 } },
  3122		},
  3123		{
  3124			"ALU64_ADD_K: 2147483646 - 2147483647 = -1",
  3125			.u.insns_int = {
  3126				BPF_LD_IMM64(R0, 2147483646),
  3127				BPF_ALU64_IMM(BPF_SUB, R0, 2147483647),
  3128				BPF_EXIT_INSN(),
  3129			},
  3130			INTERNAL,
  3131			{ },
  3132			{ { 0, -1 } },
  3133		},
  3134		/* BPF_ALU | BPF_MUL | BPF_X */
  3135		{
  3136			"ALU_MUL_X: 2 * 3 = 6",
  3137			.u.insns_int = {
  3138				BPF_LD_IMM64(R0, 2),
  3139				BPF_ALU32_IMM(BPF_MOV, R1, 3),
  3140				BPF_ALU32_REG(BPF_MUL, R0, R1),
  3141				BPF_EXIT_INSN(),
  3142			},
  3143			INTERNAL,
  3144			{ },
  3145			{ { 0, 6 } },
  3146		},
  3147		{
  3148			"ALU_MUL_X: 2 * 0x7FFFFFF8 = 0xFFFFFFF0",
  3149			.u.insns_int = {
  3150				BPF_LD_IMM64(R0, 2),
  3151				BPF_ALU32_IMM(BPF_MOV, R1, 0x7FFFFFF8),
  3152				BPF_ALU32_REG(BPF_MUL, R0, R1),
  3153				BPF_EXIT_INSN(),
  3154			},
  3155			INTERNAL,
  3156			{ },
  3157			{ { 0, 0xFFFFFFF0 } },
  3158		},
  3159		{
  3160			"ALU_MUL_X: -1 * -1 = 1",
  3161			.u.insns_int = {
  3162				BPF_LD_IMM64(R0, -1),
  3163				BPF_ALU32_IMM(BPF_MOV, R1, -1),
  3164				BPF_ALU32_REG(BPF_MUL, R0, R1),
  3165				BPF_EXIT_INSN(),
  3166			},
  3167			INTERNAL,
  3168			{ },
  3169			{ { 0, 1 } },
  3170		},
  3171		{
  3172			"ALU64_MUL_X: 2 * 3 = 6",
  3173			.u.insns_int = {
  3174				BPF_LD_IMM64(R0, 2),
  3175				BPF_ALU32_IMM(BPF_MOV, R1, 3),
  3176				BPF_ALU64_REG(BPF_MUL, R0, R1),
  3177				BPF_EXIT_INSN(),
  3178			},
  3179			INTERNAL,
  3180			{ },
  3181			{ { 0, 6 } },
  3182		},
  3183		{
  3184			"ALU64_MUL_X: 1 * 2147483647 = 2147483647",
  3185			.u.insns_int = {
  3186				BPF_LD_IMM64(R0, 1),
  3187				BPF_ALU32_IMM(BPF_MOV, R1, 2147483647),
  3188				BPF_ALU64_REG(BPF_MUL, R0, R1),
  3189				BPF_EXIT_INSN(),
  3190			},
  3191			INTERNAL,
  3192			{ },
  3193			{ { 0, 2147483647 } },
  3194		},
  3195		{
  3196			"ALU64_MUL_X: 64x64 multiply, low word",
  3197			.u.insns_int = {
  3198				BPF_LD_IMM64(R0, 0x0fedcba987654321LL),
  3199				BPF_LD_IMM64(R1, 0x123456789abcdef0LL),
  3200				BPF_ALU64_REG(BPF_MUL, R0, R1),
  3201				BPF_EXIT_INSN(),
  3202			},
  3203			INTERNAL,
  3204			{ },
  3205			{ { 0, 0xe5618cf0 } }
  3206		},
  3207		{
  3208			"ALU64_MUL_X: 64x64 multiply, high word",
  3209			.u.insns_int = {
  3210				BPF_LD_IMM64(R0, 0x0fedcba987654321LL),
  3211				BPF_LD_IMM64(R1, 0x123456789abcdef0LL),
  3212				BPF_ALU64_REG(BPF_MUL, R0, R1),
  3213				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  3214				BPF_EXIT_INSN(),
  3215			},
  3216			INTERNAL,
  3217			{ },
  3218			{ { 0, 0x2236d88f } }
  3219		},
  3220		/* BPF_ALU | BPF_MUL | BPF_K */
  3221		{
  3222			"ALU_MUL_K: 2 * 3 = 6",
  3223			.u.insns_int = {
  3224				BPF_LD_IMM64(R0, 2),
  3225				BPF_ALU32_IMM(BPF_MUL, R0, 3),
  3226				BPF_EXIT_INSN(),
  3227			},
  3228			INTERNAL,
  3229			{ },
  3230			{ { 0, 6 } },
  3231		},
  3232		{
  3233			"ALU_MUL_K: 3 * 1 = 3",
  3234			.u.insns_int = {
  3235				BPF_LD_IMM64(R0, 3),
  3236				BPF_ALU32_IMM(BPF_MUL, R0, 1),
  3237				BPF_EXIT_INSN(),
  3238			},
  3239			INTERNAL,
  3240			{ },
  3241			{ { 0, 3 } },
  3242		},
  3243		{
  3244			"ALU_MUL_K: 2 * 0x7FFFFFF8 = 0xFFFFFFF0",
  3245			.u.insns_int = {
  3246				BPF_LD_IMM64(R0, 2),
  3247				BPF_ALU32_IMM(BPF_MUL, R0, 0x7FFFFFF8),
  3248				BPF_EXIT_INSN(),
  3249			},
  3250			INTERNAL,
  3251			{ },
  3252			{ { 0, 0xFFFFFFF0 } },
  3253		},
  3254		{
  3255			"ALU_MUL_K: 1 * (-1) = 0x00000000ffffffff",
  3256			.u.insns_int = {
  3257				BPF_LD_IMM64(R2, 0x1),
  3258				BPF_LD_IMM64(R3, 0x00000000ffffffff),
  3259				BPF_ALU32_IMM(BPF_MUL, R2, 0xffffffff),
  3260				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  3261				BPF_MOV32_IMM(R0, 2),
  3262				BPF_EXIT_INSN(),
  3263				BPF_MOV32_IMM(R0, 1),
  3264				BPF_EXIT_INSN(),
  3265			},
  3266			INTERNAL,
  3267			{ },
  3268			{ { 0, 0x1 } },
  3269		},
  3270		{
  3271			"ALU64_MUL_K: 2 * 3 = 6",
  3272			.u.insns_int = {
  3273				BPF_LD_IMM64(R0, 2),
  3274				BPF_ALU64_IMM(BPF_MUL, R0, 3),
  3275				BPF_EXIT_INSN(),
  3276			},
  3277			INTERNAL,
  3278			{ },
  3279			{ { 0, 6 } },
  3280		},
  3281		{
  3282			"ALU64_MUL_K: 3 * 1 = 3",
  3283			.u.insns_int = {
  3284				BPF_LD_IMM64(R0, 3),
  3285				BPF_ALU64_IMM(BPF_MUL, R0, 1),
  3286				BPF_EXIT_INSN(),
  3287			},
  3288			INTERNAL,
  3289			{ },
  3290			{ { 0, 3 } },
  3291		},
  3292		{
  3293			"ALU64_MUL_K: 1 * 2147483647 = 2147483647",
  3294			.u.insns_int = {
  3295				BPF_LD_IMM64(R0, 1),
  3296				BPF_ALU64_IMM(BPF_MUL, R0, 2147483647),
  3297				BPF_EXIT_INSN(),
  3298			},
  3299			INTERNAL,
  3300			{ },
  3301			{ { 0, 2147483647 } },
  3302		},
  3303		{
  3304			"ALU64_MUL_K: 1 * -2147483647 = -2147483647",
  3305			.u.insns_int = {
  3306				BPF_LD_IMM64(R0, 1),
  3307				BPF_ALU64_IMM(BPF_MUL, R0, -2147483647),
  3308				BPF_EXIT_INSN(),
  3309			},
  3310			INTERNAL,
  3311			{ },
  3312			{ { 0, -2147483647 } },
  3313		},
  3314		{
  3315			"ALU64_MUL_K: 1 * (-1) = 0xffffffffffffffff",
  3316			.u.insns_int = {
  3317				BPF_LD_IMM64(R2, 0x1),
  3318				BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
  3319				BPF_ALU64_IMM(BPF_MUL, R2, 0xffffffff),
  3320				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  3321				BPF_MOV32_IMM(R0, 2),
  3322				BPF_EXIT_INSN(),
  3323				BPF_MOV32_IMM(R0, 1),
  3324				BPF_EXIT_INSN(),
  3325			},
  3326			INTERNAL,
  3327			{ },
  3328			{ { 0, 0x1 } },
  3329		},
  3330		{
  3331			"ALU64_MUL_K: 64x32 multiply, low word",
  3332			.u.insns_int = {
  3333				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  3334				BPF_ALU64_IMM(BPF_MUL, R0, 0x12345678),
  3335				BPF_EXIT_INSN(),
  3336			},
  3337			INTERNAL,
  3338			{ },
  3339			{ { 0, 0xe242d208 } }
  3340		},
  3341		{
  3342			"ALU64_MUL_K: 64x32 multiply, high word",
  3343			.u.insns_int = {
  3344				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  3345				BPF_ALU64_IMM(BPF_MUL, R0, 0x12345678),
  3346				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  3347				BPF_EXIT_INSN(),
  3348			},
  3349			INTERNAL,
  3350			{ },
  3351			{ { 0, 0xc28f5c28 } }
  3352		},
  3353		/* BPF_ALU | BPF_DIV | BPF_X */
  3354		{
  3355			"ALU_DIV_X: 6 / 2 = 3",
  3356			.u.insns_int = {
  3357				BPF_LD_IMM64(R0, 6),
  3358				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  3359				BPF_ALU32_REG(BPF_DIV, R0, R1),
  3360				BPF_EXIT_INSN(),
  3361			},
  3362			INTERNAL,
  3363			{ },
  3364			{ { 0, 3 } },
  3365		},
  3366		{
  3367			"ALU_DIV_X: 4294967295 / 4294967295 = 1",
  3368			.u.insns_int = {
  3369				BPF_LD_IMM64(R0, 4294967295U),
  3370				BPF_ALU32_IMM(BPF_MOV, R1, 4294967295U),
  3371				BPF_ALU32_REG(BPF_DIV, R0, R1),
  3372				BPF_EXIT_INSN(),
  3373			},
  3374			INTERNAL,
  3375			{ },
  3376			{ { 0, 1 } },
  3377		},
  3378		{
  3379			"ALU64_DIV_X: 6 / 2 = 3",
  3380			.u.insns_int = {
  3381				BPF_LD_IMM64(R0, 6),
  3382				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  3383				BPF_ALU64_REG(BPF_DIV, R0, R1),
  3384				BPF_EXIT_INSN(),
  3385			},
  3386			INTERNAL,
  3387			{ },
  3388			{ { 0, 3 } },
  3389		},
  3390		{
  3391			"ALU64_DIV_X: 2147483647 / 2147483647 = 1",
  3392			.u.insns_int = {
  3393				BPF_LD_IMM64(R0, 2147483647),
  3394				BPF_ALU32_IMM(BPF_MOV, R1, 2147483647),
  3395				BPF_ALU64_REG(BPF_DIV, R0, R1),
  3396				BPF_EXIT_INSN(),
  3397			},
  3398			INTERNAL,
  3399			{ },
  3400			{ { 0, 1 } },
  3401		},
  3402		{
  3403			"ALU64_DIV_X: 0xffffffffffffffff / (-1) = 0x0000000000000001",
  3404			.u.insns_int = {
  3405				BPF_LD_IMM64(R2, 0xffffffffffffffffLL),
  3406				BPF_LD_IMM64(R4, 0xffffffffffffffffLL),
  3407				BPF_LD_IMM64(R3, 0x0000000000000001LL),
  3408				BPF_ALU64_REG(BPF_DIV, R2, R4),
  3409				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  3410				BPF_MOV32_IMM(R0, 2),
  3411				BPF_EXIT_INSN(),
  3412				BPF_MOV32_IMM(R0, 1),
  3413				BPF_EXIT_INSN(),
  3414			},
  3415			INTERNAL,
  3416			{ },
  3417			{ { 0, 0x1 } },
  3418		},
  3419		/* BPF_ALU | BPF_DIV | BPF_K */
  3420		{
  3421			"ALU_DIV_K: 6 / 2 = 3",
  3422			.u.insns_int = {
  3423				BPF_LD_IMM64(R0, 6),
  3424				BPF_ALU32_IMM(BPF_DIV, R0, 2),
  3425				BPF_EXIT_INSN(),
  3426			},
  3427			INTERNAL,
  3428			{ },
  3429			{ { 0, 3 } },
  3430		},
  3431		{
  3432			"ALU_DIV_K: 3 / 1 = 3",
  3433			.u.insns_int = {
  3434				BPF_LD_IMM64(R0, 3),
  3435				BPF_ALU32_IMM(BPF_DIV, R0, 1),
  3436				BPF_EXIT_INSN(),
  3437			},
  3438			INTERNAL,
  3439			{ },
  3440			{ { 0, 3 } },
  3441		},
  3442		{
  3443			"ALU_DIV_K: 4294967295 / 4294967295 = 1",
  3444			.u.insns_int = {
  3445				BPF_LD_IMM64(R0, 4294967295U),
  3446				BPF_ALU32_IMM(BPF_DIV, R0, 4294967295U),
  3447				BPF_EXIT_INSN(),
  3448			},
  3449			INTERNAL,
  3450			{ },
  3451			{ { 0, 1 } },
  3452		},
  3453		{
  3454			"ALU_DIV_K: 0xffffffffffffffff / (-1) = 0x1",
  3455			.u.insns_int = {
  3456				BPF_LD_IMM64(R2, 0xffffffffffffffffLL),
  3457				BPF_LD_IMM64(R3, 0x1UL),
  3458				BPF_ALU32_IMM(BPF_DIV, R2, 0xffffffff),
  3459				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  3460				BPF_MOV32_IMM(R0, 2),
  3461				BPF_EXIT_INSN(),
  3462				BPF_MOV32_IMM(R0, 1),
  3463				BPF_EXIT_INSN(),
  3464			},
  3465			INTERNAL,
  3466			{ },
  3467			{ { 0, 0x1 } },
  3468		},
  3469		{
  3470			"ALU64_DIV_K: 6 / 2 = 3",
  3471			.u.insns_int = {
  3472				BPF_LD_IMM64(R0, 6),
  3473				BPF_ALU64_IMM(BPF_DIV, R0, 2),
  3474				BPF_EXIT_INSN(),
  3475			},
  3476			INTERNAL,
  3477			{ },
  3478			{ { 0, 3 } },
  3479		},
  3480		{
  3481			"ALU64_DIV_K: 3 / 1 = 3",
  3482			.u.insns_int = {
  3483				BPF_LD_IMM64(R0, 3),
  3484				BPF_ALU64_IMM(BPF_DIV, R0, 1),
  3485				BPF_EXIT_INSN(),
  3486			},
  3487			INTERNAL,
  3488			{ },
  3489			{ { 0, 3 } },
  3490		},
  3491		{
  3492			"ALU64_DIV_K: 2147483647 / 2147483647 = 1",
  3493			.u.insns_int = {
  3494				BPF_LD_IMM64(R0, 2147483647),
  3495				BPF_ALU64_IMM(BPF_DIV, R0, 2147483647),
  3496				BPF_EXIT_INSN(),
  3497			},
  3498			INTERNAL,
  3499			{ },
  3500			{ { 0, 1 } },
  3501		},
  3502		{
  3503			"ALU64_DIV_K: 0xffffffffffffffff / (-1) = 0x0000000000000001",
  3504			.u.insns_int = {
  3505				BPF_LD_IMM64(R2, 0xffffffffffffffffLL),
  3506				BPF_LD_IMM64(R3, 0x0000000000000001LL),
  3507				BPF_ALU64_IMM(BPF_DIV, R2, 0xffffffff),
  3508				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  3509				BPF_MOV32_IMM(R0, 2),
  3510				BPF_EXIT_INSN(),
  3511				BPF_MOV32_IMM(R0, 1),
  3512				BPF_EXIT_INSN(),
  3513			},
  3514			INTERNAL,
  3515			{ },
  3516			{ { 0, 0x1 } },
  3517		},
  3518		/* BPF_ALU | BPF_MOD | BPF_X */
  3519		{
  3520			"ALU_MOD_X: 3 % 2 = 1",
  3521			.u.insns_int = {
  3522				BPF_LD_IMM64(R0, 3),
  3523				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  3524				BPF_ALU32_REG(BPF_MOD, R0, R1),
  3525				BPF_EXIT_INSN(),
  3526			},
  3527			INTERNAL,
  3528			{ },
  3529			{ { 0, 1 } },
  3530		},
  3531		{
  3532			"ALU_MOD_X: 4294967295 % 4294967293 = 2",
  3533			.u.insns_int = {
  3534				BPF_LD_IMM64(R0, 4294967295U),
  3535				BPF_ALU32_IMM(BPF_MOV, R1, 4294967293U),
  3536				BPF_ALU32_REG(BPF_MOD, R0, R1),
  3537				BPF_EXIT_INSN(),
  3538			},
  3539			INTERNAL,
  3540			{ },
  3541			{ { 0, 2 } },
  3542		},
  3543		{
  3544			"ALU64_MOD_X: 3 % 2 = 1",
  3545			.u.insns_int = {
  3546				BPF_LD_IMM64(R0, 3),
  3547				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  3548				BPF_ALU64_REG(BPF_MOD, R0, R1),
  3549				BPF_EXIT_INSN(),
  3550			},
  3551			INTERNAL,
  3552			{ },
  3553			{ { 0, 1 } },
  3554		},
  3555		{
  3556			"ALU64_MOD_X: 2147483647 % 2147483645 = 2",
  3557			.u.insns_int = {
  3558				BPF_LD_IMM64(R0, 2147483647),
  3559				BPF_ALU32_IMM(BPF_MOV, R1, 2147483645),
  3560				BPF_ALU64_REG(BPF_MOD, R0, R1),
  3561				BPF_EXIT_INSN(),
  3562			},
  3563			INTERNAL,
  3564			{ },
  3565			{ { 0, 2 } },
  3566		},
  3567		/* BPF_ALU | BPF_MOD | BPF_K */
  3568		{
  3569			"ALU_MOD_K: 3 % 2 = 1",
  3570			.u.insns_int = {
  3571				BPF_LD_IMM64(R0, 3),
  3572				BPF_ALU32_IMM(BPF_MOD, R0, 2),
  3573				BPF_EXIT_INSN(),
  3574			},
  3575			INTERNAL,
  3576			{ },
  3577			{ { 0, 1 } },
  3578		},
  3579		{
  3580			"ALU_MOD_K: 3 % 1 = 0",
  3581			.u.insns_int = {
  3582				BPF_LD_IMM64(R0, 3),
  3583				BPF_ALU32_IMM(BPF_MOD, R0, 1),
  3584				BPF_EXIT_INSN(),
  3585			},
  3586			INTERNAL,
  3587			{ },
  3588			{ { 0, 0 } },
  3589		},
  3590		{
  3591			"ALU_MOD_K: 4294967295 % 4294967293 = 2",
  3592			.u.insns_int = {
  3593				BPF_LD_IMM64(R0, 4294967295U),
  3594				BPF_ALU32_IMM(BPF_MOD, R0, 4294967293U),
  3595				BPF_EXIT_INSN(),
  3596			},
  3597			INTERNAL,
  3598			{ },
  3599			{ { 0, 2 } },
  3600		},
  3601		{
  3602			"ALU64_MOD_K: 3 % 2 = 1",
  3603			.u.insns_int = {
  3604				BPF_LD_IMM64(R0, 3),
  3605				BPF_ALU64_IMM(BPF_MOD, R0, 2),
  3606				BPF_EXIT_INSN(),
  3607			},
  3608			INTERNAL,
  3609			{ },
  3610			{ { 0, 1 } },
  3611		},
  3612		{
  3613			"ALU64_MOD_K: 3 % 1 = 0",
  3614			.u.insns_int = {
  3615				BPF_LD_IMM64(R0, 3),
  3616				BPF_ALU64_IMM(BPF_MOD, R0, 1),
  3617				BPF_EXIT_INSN(),
  3618			},
  3619			INTERNAL,
  3620			{ },
  3621			{ { 0, 0 } },
  3622		},
  3623		{
  3624			"ALU64_MOD_K: 2147483647 % 2147483645 = 2",
  3625			.u.insns_int = {
  3626				BPF_LD_IMM64(R0, 2147483647),
  3627				BPF_ALU64_IMM(BPF_MOD, R0, 2147483645),
  3628				BPF_EXIT_INSN(),
  3629			},
  3630			INTERNAL,
  3631			{ },
  3632			{ { 0, 2 } },
  3633		},
  3634		/* BPF_ALU | BPF_AND | BPF_X */
  3635		{
  3636			"ALU_AND_X: 3 & 2 = 2",
  3637			.u.insns_int = {
  3638				BPF_LD_IMM64(R0, 3),
  3639				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  3640				BPF_ALU32_REG(BPF_AND, R0, R1),
  3641				BPF_EXIT_INSN(),
  3642			},
  3643			INTERNAL,
  3644			{ },
  3645			{ { 0, 2 } },
  3646		},
  3647		{
  3648			"ALU_AND_X: 0xffffffff & 0xffffffff = 0xffffffff",
  3649			.u.insns_int = {
  3650				BPF_LD_IMM64(R0, 0xffffffff),
  3651				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  3652				BPF_ALU32_REG(BPF_AND, R0, R1),
  3653				BPF_EXIT_INSN(),
  3654			},
  3655			INTERNAL,
  3656			{ },
  3657			{ { 0, 0xffffffff } },
  3658		},
  3659		{
  3660			"ALU64_AND_X: 3 & 2 = 2",
  3661			.u.insns_int = {
  3662				BPF_LD_IMM64(R0, 3),
  3663				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  3664				BPF_ALU64_REG(BPF_AND, R0, R1),
  3665				BPF_EXIT_INSN(),
  3666			},
  3667			INTERNAL,
  3668			{ },
  3669			{ { 0, 2 } },
  3670		},
  3671		{
  3672			"ALU64_AND_X: 0xffffffff & 0xffffffff = 0xffffffff",
  3673			.u.insns_int = {
  3674				BPF_LD_IMM64(R0, 0xffffffff),
  3675				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  3676				BPF_ALU64_REG(BPF_AND, R0, R1),
  3677				BPF_EXIT_INSN(),
  3678			},
  3679			INTERNAL,
  3680			{ },
  3681			{ { 0, 0xffffffff } },
  3682		},
  3683		/* BPF_ALU | BPF_AND | BPF_K */
  3684		{
  3685			"ALU_AND_K: 3 & 2 = 2",
  3686			.u.insns_int = {
  3687				BPF_LD_IMM64(R0, 3),
  3688				BPF_ALU32_IMM(BPF_AND, R0, 2),
  3689				BPF_EXIT_INSN(),
  3690			},
  3691			INTERNAL,
  3692			{ },
  3693			{ { 0, 2 } },
  3694		},
  3695		{
  3696			"ALU_AND_K: 0xffffffff & 0xffffffff = 0xffffffff",
  3697			.u.insns_int = {
  3698				BPF_LD_IMM64(R0, 0xffffffff),
  3699				BPF_ALU32_IMM(BPF_AND, R0, 0xffffffff),
  3700				BPF_EXIT_INSN(),
  3701			},
  3702			INTERNAL,
  3703			{ },
  3704			{ { 0, 0xffffffff } },
  3705		},
  3706		{
  3707			"ALU_AND_K: Small immediate",
  3708			.u.insns_int = {
  3709				BPF_ALU32_IMM(BPF_MOV, R0, 0x01020304),
  3710				BPF_ALU32_IMM(BPF_AND, R0, 15),
  3711				BPF_EXIT_INSN(),
  3712			},
  3713			INTERNAL,
  3714			{ },
  3715			{ { 0, 4 } }
  3716		},
  3717		{
  3718			"ALU_AND_K: Large immediate",
  3719			.u.insns_int = {
  3720				BPF_ALU32_IMM(BPF_MOV, R0, 0xf1f2f3f4),
  3721				BPF_ALU32_IMM(BPF_AND, R0, 0xafbfcfdf),
  3722				BPF_EXIT_INSN(),
  3723			},
  3724			INTERNAL,
  3725			{ },
  3726			{ { 0, 0xa1b2c3d4 } }
  3727		},
  3728		{
  3729			"ALU_AND_K: Zero extension",
  3730			.u.insns_int = {
  3731				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  3732				BPF_LD_IMM64(R1, 0x0000000080a0c0e0LL),
  3733				BPF_ALU32_IMM(BPF_AND, R0, 0xf0f0f0f0),
  3734				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  3735				BPF_MOV32_IMM(R0, 2),
  3736				BPF_EXIT_INSN(),
  3737				BPF_MOV32_IMM(R0, 1),
  3738				BPF_EXIT_INSN(),
  3739			},
  3740			INTERNAL,
  3741			{ },
  3742			{ { 0, 1 } }
  3743		},
  3744		{
  3745			"ALU64_AND_K: 3 & 2 = 2",
  3746			.u.insns_int = {
  3747				BPF_LD_IMM64(R0, 3),
  3748				BPF_ALU64_IMM(BPF_AND, R0, 2),
  3749				BPF_EXIT_INSN(),
  3750			},
  3751			INTERNAL,
  3752			{ },
  3753			{ { 0, 2 } },
  3754		},
  3755		{
  3756			"ALU64_AND_K: 0xffffffff & 0xffffffff = 0xffffffff",
  3757			.u.insns_int = {
  3758				BPF_LD_IMM64(R0, 0xffffffff),
  3759				BPF_ALU64_IMM(BPF_AND, R0, 0xffffffff),
  3760				BPF_EXIT_INSN(),
  3761			},
  3762			INTERNAL,
  3763			{ },
  3764			{ { 0, 0xffffffff } },
  3765		},
  3766		{
  3767			"ALU64_AND_K: 0x0000ffffffff0000 & 0x0 = 0x0000000000000000",
  3768			.u.insns_int = {
  3769				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  3770				BPF_LD_IMM64(R3, 0x0000000000000000LL),
  3771				BPF_ALU64_IMM(BPF_AND, R2, 0x0),
  3772				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  3773				BPF_MOV32_IMM(R0, 2),
  3774				BPF_EXIT_INSN(),
  3775				BPF_MOV32_IMM(R0, 1),
  3776				BPF_EXIT_INSN(),
  3777			},
  3778			INTERNAL,
  3779			{ },
  3780			{ { 0, 0x1 } },
  3781		},
  3782		{
  3783			"ALU64_AND_K: 0x0000ffffffff0000 & -1 = 0x0000ffffffff0000",
  3784			.u.insns_int = {
  3785				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  3786				BPF_LD_IMM64(R3, 0x0000ffffffff0000LL),
  3787				BPF_ALU64_IMM(BPF_AND, R2, 0xffffffff),
  3788				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  3789				BPF_MOV32_IMM(R0, 2),
  3790				BPF_EXIT_INSN(),
  3791				BPF_MOV32_IMM(R0, 1),
  3792				BPF_EXIT_INSN(),
  3793			},
  3794			INTERNAL,
  3795			{ },
  3796			{ { 0, 0x1 } },
  3797		},
  3798		{
  3799			"ALU64_AND_K: 0xffffffffffffffff & -1 = 0xffffffffffffffff",
  3800			.u.insns_int = {
  3801				BPF_LD_IMM64(R2, 0xffffffffffffffffLL),
  3802				BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
  3803				BPF_ALU64_IMM(BPF_AND, R2, 0xffffffff),
  3804				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  3805				BPF_MOV32_IMM(R0, 2),
  3806				BPF_EXIT_INSN(),
  3807				BPF_MOV32_IMM(R0, 1),
  3808				BPF_EXIT_INSN(),
  3809			},
  3810			INTERNAL,
  3811			{ },
  3812			{ { 0, 0x1 } },
  3813		},
  3814		{
  3815			"ALU64_AND_K: Sign extension 1",
  3816			.u.insns_int = {
  3817				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  3818				BPF_LD_IMM64(R1, 0x00000000090b0d0fLL),
  3819				BPF_ALU64_IMM(BPF_AND, R0, 0x0f0f0f0f),
  3820				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  3821				BPF_MOV32_IMM(R0, 2),
  3822				BPF_EXIT_INSN(),
  3823				BPF_MOV32_IMM(R0, 1),
  3824				BPF_EXIT_INSN(),
  3825			},
  3826			INTERNAL,
  3827			{ },
  3828			{ { 0, 1 } }
  3829		},
  3830		{
  3831			"ALU64_AND_K: Sign extension 2",
  3832			.u.insns_int = {
  3833				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  3834				BPF_LD_IMM64(R1, 0x0123456780a0c0e0LL),
  3835				BPF_ALU64_IMM(BPF_AND, R0, 0xf0f0f0f0),
  3836				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  3837				BPF_MOV32_IMM(R0, 2),
  3838				BPF_EXIT_INSN(),
  3839				BPF_MOV32_IMM(R0, 1),
  3840				BPF_EXIT_INSN(),
  3841			},
  3842			INTERNAL,
  3843			{ },
  3844			{ { 0, 1 } }
  3845		},
  3846		/* BPF_ALU | BPF_OR | BPF_X */
  3847		{
  3848			"ALU_OR_X: 1 | 2 = 3",
  3849			.u.insns_int = {
  3850				BPF_LD_IMM64(R0, 1),
  3851				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  3852				BPF_ALU32_REG(BPF_OR, R0, R1),
  3853				BPF_EXIT_INSN(),
  3854			},
  3855			INTERNAL,
  3856			{ },
  3857			{ { 0, 3 } },
  3858		},
  3859		{
  3860			"ALU_OR_X: 0x0 | 0xffffffff = 0xffffffff",
  3861			.u.insns_int = {
  3862				BPF_LD_IMM64(R0, 0),
  3863				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  3864				BPF_ALU32_REG(BPF_OR, R0, R1),
  3865				BPF_EXIT_INSN(),
  3866			},
  3867			INTERNAL,
  3868			{ },
  3869			{ { 0, 0xffffffff } },
  3870		},
  3871		{
  3872			"ALU64_OR_X: 1 | 2 = 3",
  3873			.u.insns_int = {
  3874				BPF_LD_IMM64(R0, 1),
  3875				BPF_ALU32_IMM(BPF_MOV, R1, 2),
  3876				BPF_ALU64_REG(BPF_OR, R0, R1),
  3877				BPF_EXIT_INSN(),
  3878			},
  3879			INTERNAL,
  3880			{ },
  3881			{ { 0, 3 } },
  3882		},
  3883		{
  3884			"ALU64_OR_X: 0 | 0xffffffff = 0xffffffff",
  3885			.u.insns_int = {
  3886				BPF_LD_IMM64(R0, 0),
  3887				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  3888				BPF_ALU64_REG(BPF_OR, R0, R1),
  3889				BPF_EXIT_INSN(),
  3890			},
  3891			INTERNAL,
  3892			{ },
  3893			{ { 0, 0xffffffff } },
  3894		},
  3895		/* BPF_ALU | BPF_OR | BPF_K */
  3896		{
  3897			"ALU_OR_K: 1 | 2 = 3",
  3898			.u.insns_int = {
  3899				BPF_LD_IMM64(R0, 1),
  3900				BPF_ALU32_IMM(BPF_OR, R0, 2),
  3901				BPF_EXIT_INSN(),
  3902			},
  3903			INTERNAL,
  3904			{ },
  3905			{ { 0, 3 } },
  3906		},
  3907		{
  3908			"ALU_OR_K: 0 & 0xffffffff = 0xffffffff",
  3909			.u.insns_int = {
  3910				BPF_LD_IMM64(R0, 0),
  3911				BPF_ALU32_IMM(BPF_OR, R0, 0xffffffff),
  3912				BPF_EXIT_INSN(),
  3913			},
  3914			INTERNAL,
  3915			{ },
  3916			{ { 0, 0xffffffff } },
  3917		},
  3918		{
  3919			"ALU_OR_K: Small immediate",
  3920			.u.insns_int = {
  3921				BPF_ALU32_IMM(BPF_MOV, R0, 0x01020304),
  3922				BPF_ALU32_IMM(BPF_OR, R0, 1),
  3923				BPF_EXIT_INSN(),
  3924			},
  3925			INTERNAL,
  3926			{ },
  3927			{ { 0, 0x01020305 } }
  3928		},
  3929		{
  3930			"ALU_OR_K: Large immediate",
  3931			.u.insns_int = {
  3932				BPF_ALU32_IMM(BPF_MOV, R0, 0x01020304),
  3933				BPF_ALU32_IMM(BPF_OR, R0, 0xa0b0c0d0),
  3934				BPF_EXIT_INSN(),
  3935			},
  3936			INTERNAL,
  3937			{ },
  3938			{ { 0, 0xa1b2c3d4 } }
  3939		},
  3940		{
  3941			"ALU_OR_K: Zero extension",
  3942			.u.insns_int = {
  3943				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  3944				BPF_LD_IMM64(R1, 0x00000000f9fbfdffLL),
  3945				BPF_ALU32_IMM(BPF_OR, R0, 0xf0f0f0f0),
  3946				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  3947				BPF_MOV32_IMM(R0, 2),
  3948				BPF_EXIT_INSN(),
  3949				BPF_MOV32_IMM(R0, 1),
  3950				BPF_EXIT_INSN(),
  3951			},
  3952			INTERNAL,
  3953			{ },
  3954			{ { 0, 1 } }
  3955		},
  3956		{
  3957			"ALU64_OR_K: 1 | 2 = 3",
  3958			.u.insns_int = {
  3959				BPF_LD_IMM64(R0, 1),
  3960				BPF_ALU64_IMM(BPF_OR, R0, 2),
  3961				BPF_EXIT_INSN(),
  3962			},
  3963			INTERNAL,
  3964			{ },
  3965			{ { 0, 3 } },
  3966		},
  3967		{
  3968			"ALU64_OR_K: 0 & 0xffffffff = 0xffffffff",
  3969			.u.insns_int = {
  3970				BPF_LD_IMM64(R0, 0),
  3971				BPF_ALU64_IMM(BPF_OR, R0, 0xffffffff),
  3972				BPF_EXIT_INSN(),
  3973			},
  3974			INTERNAL,
  3975			{ },
  3976			{ { 0, 0xffffffff } },
  3977		},
  3978		{
  3979			"ALU64_OR_K: 0x0000ffffffff0000 | 0x0 = 0x0000ffffffff0000",
  3980			.u.insns_int = {
  3981				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  3982				BPF_LD_IMM64(R3, 0x0000ffffffff0000LL),
  3983				BPF_ALU64_IMM(BPF_OR, R2, 0x0),
  3984				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  3985				BPF_MOV32_IMM(R0, 2),
  3986				BPF_EXIT_INSN(),
  3987				BPF_MOV32_IMM(R0, 1),
  3988				BPF_EXIT_INSN(),
  3989			},
  3990			INTERNAL,
  3991			{ },
  3992			{ { 0, 0x1 } },
  3993		},
  3994		{
  3995			"ALU64_OR_K: 0x0000ffffffff0000 | -1 = 0xffffffffffffffff",
  3996			.u.insns_int = {
  3997				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  3998				BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
  3999				BPF_ALU64_IMM(BPF_OR, R2, 0xffffffff),
  4000				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  4001				BPF_MOV32_IMM(R0, 2),
  4002				BPF_EXIT_INSN(),
  4003				BPF_MOV32_IMM(R0, 1),
  4004				BPF_EXIT_INSN(),
  4005			},
  4006			INTERNAL,
  4007			{ },
  4008			{ { 0, 0x1 } },
  4009		},
  4010		{
  4011			"ALU64_OR_K: 0x000000000000000 | -1 = 0xffffffffffffffff",
  4012			.u.insns_int = {
  4013				BPF_LD_IMM64(R2, 0x0000000000000000LL),
  4014				BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
  4015				BPF_ALU64_IMM(BPF_OR, R2, 0xffffffff),
  4016				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  4017				BPF_MOV32_IMM(R0, 2),
  4018				BPF_EXIT_INSN(),
  4019				BPF_MOV32_IMM(R0, 1),
  4020				BPF_EXIT_INSN(),
  4021			},
  4022			INTERNAL,
  4023			{ },
  4024			{ { 0, 0x1 } },
  4025		},
  4026		{
  4027			"ALU64_OR_K: Sign extension 1",
  4028			.u.insns_int = {
  4029				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  4030				BPF_LD_IMM64(R1, 0x012345678fafcfefLL),
  4031				BPF_ALU64_IMM(BPF_OR, R0, 0x0f0f0f0f),
  4032				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  4033				BPF_MOV32_IMM(R0, 2),
  4034				BPF_EXIT_INSN(),
  4035				BPF_MOV32_IMM(R0, 1),
  4036				BPF_EXIT_INSN(),
  4037			},
  4038			INTERNAL,
  4039			{ },
  4040			{ { 0, 1 } }
  4041		},
  4042		{
  4043			"ALU64_OR_K: Sign extension 2",
  4044			.u.insns_int = {
  4045				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  4046				BPF_LD_IMM64(R1, 0xfffffffff9fbfdffLL),
  4047				BPF_ALU64_IMM(BPF_OR, R0, 0xf0f0f0f0),
  4048				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  4049				BPF_MOV32_IMM(R0, 2),
  4050				BPF_EXIT_INSN(),
  4051				BPF_MOV32_IMM(R0, 1),
  4052				BPF_EXIT_INSN(),
  4053			},
  4054			INTERNAL,
  4055			{ },
  4056			{ { 0, 1 } }
  4057		},
  4058		/* BPF_ALU | BPF_XOR | BPF_X */
  4059		{
  4060			"ALU_XOR_X: 5 ^ 6 = 3",
  4061			.u.insns_int = {
  4062				BPF_LD_IMM64(R0, 5),
  4063				BPF_ALU32_IMM(BPF_MOV, R1, 6),
  4064				BPF_ALU32_REG(BPF_XOR, R0, R1),
  4065				BPF_EXIT_INSN(),
  4066			},
  4067			INTERNAL,
  4068			{ },
  4069			{ { 0, 3 } },
  4070		},
  4071		{
  4072			"ALU_XOR_X: 0x1 ^ 0xffffffff = 0xfffffffe",
  4073			.u.insns_int = {
  4074				BPF_LD_IMM64(R0, 1),
  4075				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  4076				BPF_ALU32_REG(BPF_XOR, R0, R1),
  4077				BPF_EXIT_INSN(),
  4078			},
  4079			INTERNAL,
  4080			{ },
  4081			{ { 0, 0xfffffffe } },
  4082		},
  4083		{
  4084			"ALU64_XOR_X: 5 ^ 6 = 3",
  4085			.u.insns_int = {
  4086				BPF_LD_IMM64(R0, 5),
  4087				BPF_ALU32_IMM(BPF_MOV, R1, 6),
  4088				BPF_ALU64_REG(BPF_XOR, R0, R1),
  4089				BPF_EXIT_INSN(),
  4090			},
  4091			INTERNAL,
  4092			{ },
  4093			{ { 0, 3 } },
  4094		},
  4095		{
  4096			"ALU64_XOR_X: 1 ^ 0xffffffff = 0xfffffffe",
  4097			.u.insns_int = {
  4098				BPF_LD_IMM64(R0, 1),
  4099				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  4100				BPF_ALU64_REG(BPF_XOR, R0, R1),
  4101				BPF_EXIT_INSN(),
  4102			},
  4103			INTERNAL,
  4104			{ },
  4105			{ { 0, 0xfffffffe } },
  4106		},
  4107		/* BPF_ALU | BPF_XOR | BPF_K */
  4108		{
  4109			"ALU_XOR_K: 5 ^ 6 = 3",
  4110			.u.insns_int = {
  4111				BPF_LD_IMM64(R0, 5),
  4112				BPF_ALU32_IMM(BPF_XOR, R0, 6),
  4113				BPF_EXIT_INSN(),
  4114			},
  4115			INTERNAL,
  4116			{ },
  4117			{ { 0, 3 } },
  4118		},
  4119		{
  4120			"ALU_XOR_K: 1 ^ 0xffffffff = 0xfffffffe",
  4121			.u.insns_int = {
  4122				BPF_LD_IMM64(R0, 1),
  4123				BPF_ALU32_IMM(BPF_XOR, R0, 0xffffffff),
  4124				BPF_EXIT_INSN(),
  4125			},
  4126			INTERNAL,
  4127			{ },
  4128			{ { 0, 0xfffffffe } },
  4129		},
  4130		{
  4131			"ALU_XOR_K: Small immediate",
  4132			.u.insns_int = {
  4133				BPF_ALU32_IMM(BPF_MOV, R0, 0x01020304),
  4134				BPF_ALU32_IMM(BPF_XOR, R0, 15),
  4135				BPF_EXIT_INSN(),
  4136			},
  4137			INTERNAL,
  4138			{ },
  4139			{ { 0, 0x0102030b } }
  4140		},
  4141		{
  4142			"ALU_XOR_K: Large immediate",
  4143			.u.insns_int = {
  4144				BPF_ALU32_IMM(BPF_MOV, R0, 0xf1f2f3f4),
  4145				BPF_ALU32_IMM(BPF_XOR, R0, 0xafbfcfdf),
  4146				BPF_EXIT_INSN(),
  4147			},
  4148			INTERNAL,
  4149			{ },
  4150			{ { 0, 0x5e4d3c2b } }
  4151		},
  4152		{
  4153			"ALU_XOR_K: Zero extension",
  4154			.u.insns_int = {
  4155				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  4156				BPF_LD_IMM64(R1, 0x00000000795b3d1fLL),
  4157				BPF_ALU32_IMM(BPF_XOR, R0, 0xf0f0f0f0),
  4158				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  4159				BPF_MOV32_IMM(R0, 2),
  4160				BPF_EXIT_INSN(),
  4161				BPF_MOV32_IMM(R0, 1),
  4162				BPF_EXIT_INSN(),
  4163			},
  4164			INTERNAL,
  4165			{ },
  4166			{ { 0, 1 } }
  4167		},
  4168		{
  4169			"ALU64_XOR_K: 5 ^ 6 = 3",
  4170			.u.insns_int = {
  4171				BPF_LD_IMM64(R0, 5),
  4172				BPF_ALU64_IMM(BPF_XOR, R0, 6),
  4173				BPF_EXIT_INSN(),
  4174			},
  4175			INTERNAL,
  4176			{ },
  4177			{ { 0, 3 } },
  4178		},
  4179		{
  4180			"ALU64_XOR_K: 1 ^ 0xffffffff = 0xfffffffe",
  4181			.u.insns_int = {
  4182				BPF_LD_IMM64(R0, 1),
  4183				BPF_ALU64_IMM(BPF_XOR, R0, 0xffffffff),
  4184				BPF_EXIT_INSN(),
  4185			},
  4186			INTERNAL,
  4187			{ },
  4188			{ { 0, 0xfffffffe } },
  4189		},
  4190		{
  4191			"ALU64_XOR_K: 0x0000ffffffff0000 ^ 0x0 = 0x0000ffffffff0000",
  4192			.u.insns_int = {
  4193				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  4194				BPF_LD_IMM64(R3, 0x0000ffffffff0000LL),
  4195				BPF_ALU64_IMM(BPF_XOR, R2, 0x0),
  4196				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  4197				BPF_MOV32_IMM(R0, 2),
  4198				BPF_EXIT_INSN(),
  4199				BPF_MOV32_IMM(R0, 1),
  4200				BPF_EXIT_INSN(),
  4201			},
  4202			INTERNAL,
  4203			{ },
  4204			{ { 0, 0x1 } },
  4205		},
  4206		{
  4207			"ALU64_XOR_K: 0x0000ffffffff0000 ^ -1 = 0xffff00000000ffff",
  4208			.u.insns_int = {
  4209				BPF_LD_IMM64(R2, 0x0000ffffffff0000LL),
  4210				BPF_LD_IMM64(R3, 0xffff00000000ffffLL),
  4211				BPF_ALU64_IMM(BPF_XOR, R2, 0xffffffff),
  4212				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  4213				BPF_MOV32_IMM(R0, 2),
  4214				BPF_EXIT_INSN(),
  4215				BPF_MOV32_IMM(R0, 1),
  4216				BPF_EXIT_INSN(),
  4217			},
  4218			INTERNAL,
  4219			{ },
  4220			{ { 0, 0x1 } },
  4221		},
  4222		{
  4223			"ALU64_XOR_K: 0x000000000000000 ^ -1 = 0xffffffffffffffff",
  4224			.u.insns_int = {
  4225				BPF_LD_IMM64(R2, 0x0000000000000000LL),
  4226				BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
  4227				BPF_ALU64_IMM(BPF_XOR, R2, 0xffffffff),
  4228				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  4229				BPF_MOV32_IMM(R0, 2),
  4230				BPF_EXIT_INSN(),
  4231				BPF_MOV32_IMM(R0, 1),
  4232				BPF_EXIT_INSN(),
  4233			},
  4234			INTERNAL,
  4235			{ },
  4236			{ { 0, 0x1 } },
  4237		},
  4238		{
  4239			"ALU64_XOR_K: Sign extension 1",
  4240			.u.insns_int = {
  4241				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  4242				BPF_LD_IMM64(R1, 0x0123456786a4c2e0LL),
  4243				BPF_ALU64_IMM(BPF_XOR, R0, 0x0f0f0f0f),
  4244				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  4245				BPF_MOV32_IMM(R0, 2),
  4246				BPF_EXIT_INSN(),
  4247				BPF_MOV32_IMM(R0, 1),
  4248				BPF_EXIT_INSN(),
  4249			},
  4250			INTERNAL,
  4251			{ },
  4252			{ { 0, 1 } }
  4253		},
  4254		{
  4255			"ALU64_XOR_K: Sign extension 2",
  4256			.u.insns_int = {
  4257				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  4258				BPF_LD_IMM64(R1, 0xfedcba98795b3d1fLL),
  4259				BPF_ALU64_IMM(BPF_XOR, R0, 0xf0f0f0f0),
  4260				BPF_JMP_REG(BPF_JEQ, R0, R1, 2),
  4261				BPF_MOV32_IMM(R0, 2),
  4262				BPF_EXIT_INSN(),
  4263				BPF_MOV32_IMM(R0, 1),
  4264				BPF_EXIT_INSN(),
  4265			},
  4266			INTERNAL,
  4267			{ },
  4268			{ { 0, 1 } }
  4269		},
  4270		/* BPF_ALU | BPF_LSH | BPF_X */
  4271		{
  4272			"ALU_LSH_X: 1 << 1 = 2",
  4273			.u.insns_int = {
  4274				BPF_LD_IMM64(R0, 1),
  4275				BPF_ALU32_IMM(BPF_MOV, R1, 1),
  4276				BPF_ALU32_REG(BPF_LSH, R0, R1),
  4277				BPF_EXIT_INSN(),
  4278			},
  4279			INTERNAL,
  4280			{ },
  4281			{ { 0, 2 } },
  4282		},
  4283		{
  4284			"ALU_LSH_X: 1 << 31 = 0x80000000",
  4285			.u.insns_int = {
  4286				BPF_LD_IMM64(R0, 1),
  4287				BPF_ALU32_IMM(BPF_MOV, R1, 31),
  4288				BPF_ALU32_REG(BPF_LSH, R0, R1),
  4289				BPF_EXIT_INSN(),
  4290			},
  4291			INTERNAL,
  4292			{ },
  4293			{ { 0, 0x80000000 } },
  4294		},
  4295		{
  4296			"ALU_LSH_X: 0x12345678 << 12 = 0x45678000",
  4297			.u.insns_int = {
  4298				BPF_ALU32_IMM(BPF_MOV, R0, 0x12345678),
  4299				BPF_ALU32_IMM(BPF_MOV, R1, 12),
  4300				BPF_ALU32_REG(BPF_LSH, R0, R1),
  4301				BPF_EXIT_INSN(),
  4302			},
  4303			INTERNAL,
  4304			{ },
  4305			{ { 0, 0x45678000 } }
  4306		},
  4307		{
  4308			"ALU64_LSH_X: 1 << 1 = 2",
  4309			.u.insns_int = {
  4310				BPF_LD_IMM64(R0, 1),
  4311				BPF_ALU32_IMM(BPF_MOV, R1, 1),
  4312				BPF_ALU64_REG(BPF_LSH, R0, R1),
  4313				BPF_EXIT_INSN(),
  4314			},
  4315			INTERNAL,
  4316			{ },
  4317			{ { 0, 2 } },
  4318		},
  4319		{
  4320			"ALU64_LSH_X: 1 << 31 = 0x80000000",
  4321			.u.insns_int = {
  4322				BPF_LD_IMM64(R0, 1),
  4323				BPF_ALU32_IMM(BPF_MOV, R1, 31),
  4324				BPF_ALU64_REG(BPF_LSH, R0, R1),
  4325				BPF_EXIT_INSN(),
  4326			},
  4327			INTERNAL,
  4328			{ },
  4329			{ { 0, 0x80000000 } },
  4330		},
  4331		{
  4332			"ALU64_LSH_X: Shift < 32, low word",
  4333			.u.insns_int = {
  4334				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  4335				BPF_ALU32_IMM(BPF_MOV, R1, 12),
  4336				BPF_ALU64_REG(BPF_LSH, R0, R1),
  4337				BPF_EXIT_INSN(),
  4338			},
  4339			INTERNAL,
  4340			{ },
  4341			{ { 0, 0xbcdef000 } }
  4342		},
  4343		{
  4344			"ALU64_LSH_X: Shift < 32, high word",
  4345			.u.insns_int = {
  4346				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  4347				BPF_ALU32_IMM(BPF_MOV, R1, 12),
  4348				BPF_ALU64_REG(BPF_LSH, R0, R1),
  4349				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4350				BPF_EXIT_INSN(),
  4351			},
  4352			INTERNAL,
  4353			{ },
  4354			{ { 0, 0x3456789a } }
  4355		},
  4356		{
  4357			"ALU64_LSH_X: Shift > 32, low word",
  4358			.u.insns_int = {
  4359				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  4360				BPF_ALU32_IMM(BPF_MOV, R1, 36),
  4361				BPF_ALU64_REG(BPF_LSH, R0, R1),
  4362				BPF_EXIT_INSN(),
  4363			},
  4364			INTERNAL,
  4365			{ },
  4366			{ { 0, 0 } }
  4367		},
  4368		{
  4369			"ALU64_LSH_X: Shift > 32, high word",
  4370			.u.insns_int = {
  4371				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  4372				BPF_ALU32_IMM(BPF_MOV, R1, 36),
  4373				BPF_ALU64_REG(BPF_LSH, R0, R1),
  4374				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4375				BPF_EXIT_INSN(),
  4376			},
  4377			INTERNAL,
  4378			{ },
  4379			{ { 0, 0x9abcdef0 } }
  4380		},
  4381		{
  4382			"ALU64_LSH_X: Shift == 32, low word",
  4383			.u.insns_int = {
  4384				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  4385				BPF_ALU32_IMM(BPF_MOV, R1, 32),
  4386				BPF_ALU64_REG(BPF_LSH, R0, R1),
  4387				BPF_EXIT_INSN(),
  4388			},
  4389			INTERNAL,
  4390			{ },
  4391			{ { 0, 0 } }
  4392		},
  4393		{
  4394			"ALU64_LSH_X: Shift == 32, high word",
  4395			.u.insns_int = {
  4396				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  4397				BPF_ALU32_IMM(BPF_MOV, R1, 32),
  4398				BPF_ALU64_REG(BPF_LSH, R0, R1),
  4399				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4400				BPF_EXIT_INSN(),
  4401			},
  4402			INTERNAL,
  4403			{ },
  4404			{ { 0, 0x89abcdef } }
  4405		},
  4406		{
  4407			"ALU64_LSH_X: Zero shift, low word",
  4408			.u.insns_int = {
  4409				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  4410				BPF_ALU32_IMM(BPF_MOV, R1, 0),
  4411				BPF_ALU64_REG(BPF_LSH, R0, R1),
  4412				BPF_EXIT_INSN(),
  4413			},
  4414			INTERNAL,
  4415			{ },
  4416			{ { 0, 0x89abcdef } }
  4417		},
  4418		{
  4419			"ALU64_LSH_X: Zero shift, high word",
  4420			.u.insns_int = {
  4421				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  4422				BPF_ALU32_IMM(BPF_MOV, R1, 0),
  4423				BPF_ALU64_REG(BPF_LSH, R0, R1),
  4424				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4425				BPF_EXIT_INSN(),
  4426			},
  4427			INTERNAL,
  4428			{ },
  4429			{ { 0, 0x01234567 } }
  4430		},
  4431		/* BPF_ALU | BPF_LSH | BPF_K */
  4432		{
  4433			"ALU_LSH_K: 1 << 1 = 2",
  4434			.u.insns_int = {
  4435				BPF_LD_IMM64(R0, 1),
  4436				BPF_ALU32_IMM(BPF_LSH, R0, 1),
  4437				BPF_EXIT_INSN(),
  4438			},
  4439			INTERNAL,
  4440			{ },
  4441			{ { 0, 2 } },
  4442		},
  4443		{
  4444			"ALU_LSH_K: 1 << 31 = 0x80000000",
  4445			.u.insns_int = {
  4446				BPF_LD_IMM64(R0, 1),
  4447				BPF_ALU32_IMM(BPF_LSH, R0, 31),
  4448				BPF_EXIT_INSN(),
  4449			},
  4450			INTERNAL,
  4451			{ },
  4452			{ { 0, 0x80000000 } },
  4453		},
  4454		{
  4455			"ALU_LSH_K: 0x12345678 << 12 = 0x45678000",
  4456			.u.insns_int = {
  4457				BPF_ALU32_IMM(BPF_MOV, R0, 0x12345678),
  4458				BPF_ALU32_IMM(BPF_LSH, R0, 12),
  4459				BPF_EXIT_INSN(),
  4460			},
  4461			INTERNAL,
  4462			{ },
  4463			{ { 0, 0x45678000 } }
  4464		},
  4465		{
  4466			"ALU_LSH_K: 0x12345678 << 0 = 0x12345678",
  4467			.u.insns_int = {
  4468				BPF_ALU32_IMM(BPF_MOV, R0, 0x12345678),
  4469				BPF_ALU32_IMM(BPF_LSH, R0, 0),
  4470				BPF_EXIT_INSN(),
  4471			},
  4472			INTERNAL,
  4473			{ },
  4474			{ { 0, 0x12345678 } }
  4475		},
  4476		{
  4477			"ALU64_LSH_K: 1 << 1 = 2",
  4478			.u.insns_int = {
  4479				BPF_LD_IMM64(R0, 1),
  4480				BPF_ALU64_IMM(BPF_LSH, R0, 1),
  4481				BPF_EXIT_INSN(),
  4482			},
  4483			INTERNAL,
  4484			{ },
  4485			{ { 0, 2 } },
  4486		},
  4487		{
  4488			"ALU64_LSH_K: 1 << 31 = 0x80000000",
  4489			.u.insns_int = {
  4490				BPF_LD_IMM64(R0, 1),
  4491				BPF_ALU64_IMM(BPF_LSH, R0, 31),
  4492				BPF_EXIT_INSN(),
  4493			},
  4494			INTERNAL,
  4495			{ },
  4496			{ { 0, 0x80000000 } },
  4497		},
  4498		{
  4499			"ALU64_LSH_K: Shift < 32, low word",
  4500			.u.insns_int = {
  4501				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  4502				BPF_ALU64_IMM(BPF_LSH, R0, 12),
  4503				BPF_EXIT_INSN(),
  4504			},
  4505			INTERNAL,
  4506			{ },
  4507			{ { 0, 0xbcdef000 } }
  4508		},
  4509		{
  4510			"ALU64_LSH_K: Shift < 32, high word",
  4511			.u.insns_int = {
  4512				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  4513				BPF_ALU64_IMM(BPF_LSH, R0, 12),
  4514				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4515				BPF_EXIT_INSN(),
  4516			},
  4517			INTERNAL,
  4518			{ },
  4519			{ { 0, 0x3456789a } }
  4520		},
  4521		{
  4522			"ALU64_LSH_K: Shift > 32, low word",
  4523			.u.insns_int = {
  4524				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  4525				BPF_ALU64_IMM(BPF_LSH, R0, 36),
  4526				BPF_EXIT_INSN(),
  4527			},
  4528			INTERNAL,
  4529			{ },
  4530			{ { 0, 0 } }
  4531		},
  4532		{
  4533			"ALU64_LSH_K: Shift > 32, high word",
  4534			.u.insns_int = {
  4535				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  4536				BPF_ALU64_IMM(BPF_LSH, R0, 36),
  4537				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4538				BPF_EXIT_INSN(),
  4539			},
  4540			INTERNAL,
  4541			{ },
  4542			{ { 0, 0x9abcdef0 } }
  4543		},
  4544		{
  4545			"ALU64_LSH_K: Shift == 32, low word",
  4546			.u.insns_int = {
  4547				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  4548				BPF_ALU64_IMM(BPF_LSH, R0, 32),
  4549				BPF_EXIT_INSN(),
  4550			},
  4551			INTERNAL,
  4552			{ },
  4553			{ { 0, 0 } }
  4554		},
  4555		{
  4556			"ALU64_LSH_K: Shift == 32, high word",
  4557			.u.insns_int = {
  4558				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  4559				BPF_ALU64_IMM(BPF_LSH, R0, 32),
  4560				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4561				BPF_EXIT_INSN(),
  4562			},
  4563			INTERNAL,
  4564			{ },
  4565			{ { 0, 0x89abcdef } }
  4566		},
  4567		{
  4568			"ALU64_LSH_K: Zero shift",
  4569			.u.insns_int = {
  4570				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  4571				BPF_ALU64_IMM(BPF_LSH, R0, 0),
  4572				BPF_EXIT_INSN(),
  4573			},
  4574			INTERNAL,
  4575			{ },
  4576			{ { 0, 0x89abcdef } }
  4577		},
  4578		/* BPF_ALU | BPF_RSH | BPF_X */
  4579		{
  4580			"ALU_RSH_X: 2 >> 1 = 1",
  4581			.u.insns_int = {
  4582				BPF_LD_IMM64(R0, 2),
  4583				BPF_ALU32_IMM(BPF_MOV, R1, 1),
  4584				BPF_ALU32_REG(BPF_RSH, R0, R1),
  4585				BPF_EXIT_INSN(),
  4586			},
  4587			INTERNAL,
  4588			{ },
  4589			{ { 0, 1 } },
  4590		},
  4591		{
  4592			"ALU_RSH_X: 0x80000000 >> 31 = 1",
  4593			.u.insns_int = {
  4594				BPF_LD_IMM64(R0, 0x80000000),
  4595				BPF_ALU32_IMM(BPF_MOV, R1, 31),
  4596				BPF_ALU32_REG(BPF_RSH, R0, R1),
  4597				BPF_EXIT_INSN(),
  4598			},
  4599			INTERNAL,
  4600			{ },
  4601			{ { 0, 1 } },
  4602		},
  4603		{
  4604			"ALU_RSH_X: 0x12345678 >> 20 = 0x123",
  4605			.u.insns_int = {
  4606				BPF_ALU32_IMM(BPF_MOV, R0, 0x12345678),
  4607				BPF_ALU32_IMM(BPF_MOV, R1, 20),
  4608				BPF_ALU32_REG(BPF_RSH, R0, R1),
  4609				BPF_EXIT_INSN(),
  4610			},
  4611			INTERNAL,
  4612			{ },
  4613			{ { 0, 0x123 } }
  4614		},
  4615		{
  4616			"ALU64_RSH_X: 2 >> 1 = 1",
  4617			.u.insns_int = {
  4618				BPF_LD_IMM64(R0, 2),
  4619				BPF_ALU32_IMM(BPF_MOV, R1, 1),
  4620				BPF_ALU64_REG(BPF_RSH, R0, R1),
  4621				BPF_EXIT_INSN(),
  4622			},
  4623			INTERNAL,
  4624			{ },
  4625			{ { 0, 1 } },
  4626		},
  4627		{
  4628			"ALU64_RSH_X: 0x80000000 >> 31 = 1",
  4629			.u.insns_int = {
  4630				BPF_LD_IMM64(R0, 0x80000000),
  4631				BPF_ALU32_IMM(BPF_MOV, R1, 31),
  4632				BPF_ALU64_REG(BPF_RSH, R0, R1),
  4633				BPF_EXIT_INSN(),
  4634			},
  4635			INTERNAL,
  4636			{ },
  4637			{ { 0, 1 } },
  4638		},
  4639		{
  4640			"ALU64_RSH_X: Shift < 32, low word",
  4641			.u.insns_int = {
  4642				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  4643				BPF_ALU32_IMM(BPF_MOV, R1, 12),
  4644				BPF_ALU64_REG(BPF_RSH, R0, R1),
  4645				BPF_EXIT_INSN(),
  4646			},
  4647			INTERNAL,
  4648			{ },
  4649			{ { 0, 0x56789abc } }
  4650		},
  4651		{
  4652			"ALU64_RSH_X: Shift < 32, high word",
  4653			.u.insns_int = {
  4654				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  4655				BPF_ALU32_IMM(BPF_MOV, R1, 12),
  4656				BPF_ALU64_REG(BPF_RSH, R0, R1),
  4657				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4658				BPF_EXIT_INSN(),
  4659			},
  4660			INTERNAL,
  4661			{ },
  4662			{ { 0, 0x00081234 } }
  4663		},
  4664		{
  4665			"ALU64_RSH_X: Shift > 32, low word",
  4666			.u.insns_int = {
  4667				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  4668				BPF_ALU32_IMM(BPF_MOV, R1, 36),
  4669				BPF_ALU64_REG(BPF_RSH, R0, R1),
  4670				BPF_EXIT_INSN(),
  4671			},
  4672			INTERNAL,
  4673			{ },
  4674			{ { 0, 0x08123456 } }
  4675		},
  4676		{
  4677			"ALU64_RSH_X: Shift > 32, high word",
  4678			.u.insns_int = {
  4679				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  4680				BPF_ALU32_IMM(BPF_MOV, R1, 36),
  4681				BPF_ALU64_REG(BPF_RSH, R0, R1),
  4682				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4683				BPF_EXIT_INSN(),
  4684			},
  4685			INTERNAL,
  4686			{ },
  4687			{ { 0, 0 } }
  4688		},
  4689		{
  4690			"ALU64_RSH_X: Shift == 32, low word",
  4691			.u.insns_int = {
  4692				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  4693				BPF_ALU32_IMM(BPF_MOV, R1, 32),
  4694				BPF_ALU64_REG(BPF_RSH, R0, R1),
  4695				BPF_EXIT_INSN(),
  4696			},
  4697			INTERNAL,
  4698			{ },
  4699			{ { 0, 0x81234567 } }
  4700		},
  4701		{
  4702			"ALU64_RSH_X: Shift == 32, high word",
  4703			.u.insns_int = {
  4704				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  4705				BPF_ALU32_IMM(BPF_MOV, R1, 32),
  4706				BPF_ALU64_REG(BPF_RSH, R0, R1),
  4707				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4708				BPF_EXIT_INSN(),
  4709			},
  4710			INTERNAL,
  4711			{ },
  4712			{ { 0, 0 } }
  4713		},
  4714		{
  4715			"ALU64_RSH_X: Zero shift, low word",
  4716			.u.insns_int = {
  4717				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  4718				BPF_ALU32_IMM(BPF_MOV, R1, 0),
  4719				BPF_ALU64_REG(BPF_RSH, R0, R1),
  4720				BPF_EXIT_INSN(),
  4721			},
  4722			INTERNAL,
  4723			{ },
  4724			{ { 0, 0x89abcdef } }
  4725		},
  4726		{
  4727			"ALU64_RSH_X: Zero shift, high word",
  4728			.u.insns_int = {
  4729				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  4730				BPF_ALU32_IMM(BPF_MOV, R1, 0),
  4731				BPF_ALU64_REG(BPF_RSH, R0, R1),
  4732				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4733				BPF_EXIT_INSN(),
  4734			},
  4735			INTERNAL,
  4736			{ },
  4737			{ { 0, 0x81234567 } }
  4738		},
  4739		/* BPF_ALU | BPF_RSH | BPF_K */
  4740		{
  4741			"ALU_RSH_K: 2 >> 1 = 1",
  4742			.u.insns_int = {
  4743				BPF_LD_IMM64(R0, 2),
  4744				BPF_ALU32_IMM(BPF_RSH, R0, 1),
  4745				BPF_EXIT_INSN(),
  4746			},
  4747			INTERNAL,
  4748			{ },
  4749			{ { 0, 1 } },
  4750		},
  4751		{
  4752			"ALU_RSH_K: 0x80000000 >> 31 = 1",
  4753			.u.insns_int = {
  4754				BPF_LD_IMM64(R0, 0x80000000),
  4755				BPF_ALU32_IMM(BPF_RSH, R0, 31),
  4756				BPF_EXIT_INSN(),
  4757			},
  4758			INTERNAL,
  4759			{ },
  4760			{ { 0, 1 } },
  4761		},
  4762		{
  4763			"ALU_RSH_K: 0x12345678 >> 20 = 0x123",
  4764			.u.insns_int = {
  4765				BPF_ALU32_IMM(BPF_MOV, R0, 0x12345678),
  4766				BPF_ALU32_IMM(BPF_RSH, R0, 20),
  4767				BPF_EXIT_INSN(),
  4768			},
  4769			INTERNAL,
  4770			{ },
  4771			{ { 0, 0x123 } }
  4772		},
  4773		{
  4774			"ALU_RSH_K: 0x12345678 >> 0 = 0x12345678",
  4775			.u.insns_int = {
  4776				BPF_ALU32_IMM(BPF_MOV, R0, 0x12345678),
  4777				BPF_ALU32_IMM(BPF_RSH, R0, 0),
  4778				BPF_EXIT_INSN(),
  4779			},
  4780			INTERNAL,
  4781			{ },
  4782			{ { 0, 0x12345678 } }
  4783		},
  4784		{
  4785			"ALU64_RSH_K: 2 >> 1 = 1",
  4786			.u.insns_int = {
  4787				BPF_LD_IMM64(R0, 2),
  4788				BPF_ALU64_IMM(BPF_RSH, R0, 1),
  4789				BPF_EXIT_INSN(),
  4790			},
  4791			INTERNAL,
  4792			{ },
  4793			{ { 0, 1 } },
  4794		},
  4795		{
  4796			"ALU64_RSH_K: 0x80000000 >> 31 = 1",
  4797			.u.insns_int = {
  4798				BPF_LD_IMM64(R0, 0x80000000),
  4799				BPF_ALU64_IMM(BPF_RSH, R0, 31),
  4800				BPF_EXIT_INSN(),
  4801			},
  4802			INTERNAL,
  4803			{ },
  4804			{ { 0, 1 } },
  4805		},
  4806		{
  4807			"ALU64_RSH_K: Shift < 32, low word",
  4808			.u.insns_int = {
  4809				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  4810				BPF_ALU64_IMM(BPF_RSH, R0, 12),
  4811				BPF_EXIT_INSN(),
  4812			},
  4813			INTERNAL,
  4814			{ },
  4815			{ { 0, 0x56789abc } }
  4816		},
  4817		{
  4818			"ALU64_RSH_K: Shift < 32, high word",
  4819			.u.insns_int = {
  4820				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  4821				BPF_ALU64_IMM(BPF_RSH, R0, 12),
  4822				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4823				BPF_EXIT_INSN(),
  4824			},
  4825			INTERNAL,
  4826			{ },
  4827			{ { 0, 0x00081234 } }
  4828		},
  4829		{
  4830			"ALU64_RSH_K: Shift > 32, low word",
  4831			.u.insns_int = {
  4832				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  4833				BPF_ALU64_IMM(BPF_RSH, R0, 36),
  4834				BPF_EXIT_INSN(),
  4835			},
  4836			INTERNAL,
  4837			{ },
  4838			{ { 0, 0x08123456 } }
  4839		},
  4840		{
  4841			"ALU64_RSH_K: Shift > 32, high word",
  4842			.u.insns_int = {
  4843				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  4844				BPF_ALU64_IMM(BPF_RSH, R0, 36),
  4845				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4846				BPF_EXIT_INSN(),
  4847			},
  4848			INTERNAL,
  4849			{ },
  4850			{ { 0, 0 } }
  4851		},
  4852		{
  4853			"ALU64_RSH_K: Shift == 32, low word",
  4854			.u.insns_int = {
  4855				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  4856				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4857				BPF_EXIT_INSN(),
  4858			},
  4859			INTERNAL,
  4860			{ },
  4861			{ { 0, 0x81234567 } }
  4862		},
  4863		{
  4864			"ALU64_RSH_K: Shift == 32, high word",
  4865			.u.insns_int = {
  4866				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  4867				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4868				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4869				BPF_EXIT_INSN(),
  4870			},
  4871			INTERNAL,
  4872			{ },
  4873			{ { 0, 0 } }
  4874		},
  4875		{
  4876			"ALU64_RSH_K: Zero shift",
  4877			.u.insns_int = {
  4878				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  4879				BPF_ALU64_IMM(BPF_RSH, R0, 0),
  4880				BPF_EXIT_INSN(),
  4881			},
  4882			INTERNAL,
  4883			{ },
  4884			{ { 0, 0x89abcdef } }
  4885		},
  4886		/* BPF_ALU | BPF_ARSH | BPF_X */
  4887		{
  4888			"ALU32_ARSH_X: -1234 >> 7 = -10",
  4889			.u.insns_int = {
  4890				BPF_ALU32_IMM(BPF_MOV, R0, -1234),
  4891				BPF_ALU32_IMM(BPF_MOV, R1, 7),
  4892				BPF_ALU32_REG(BPF_ARSH, R0, R1),
  4893				BPF_EXIT_INSN(),
  4894			},
  4895			INTERNAL,
  4896			{ },
  4897			{ { 0, -10 } }
  4898		},
  4899		{
  4900			"ALU64_ARSH_X: 0xff00ff0000000000 >> 40 = 0xffffffffffff00ff",
  4901			.u.insns_int = {
  4902				BPF_LD_IMM64(R0, 0xff00ff0000000000LL),
  4903				BPF_ALU32_IMM(BPF_MOV, R1, 40),
  4904				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  4905				BPF_EXIT_INSN(),
  4906			},
  4907			INTERNAL,
  4908			{ },
  4909			{ { 0, 0xffff00ff } },
  4910		},
  4911		{
  4912			"ALU64_ARSH_X: Shift < 32, low word",
  4913			.u.insns_int = {
  4914				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  4915				BPF_ALU32_IMM(BPF_MOV, R1, 12),
  4916				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  4917				BPF_EXIT_INSN(),
  4918			},
  4919			INTERNAL,
  4920			{ },
  4921			{ { 0, 0x56789abc } }
  4922		},
  4923		{
  4924			"ALU64_ARSH_X: Shift < 32, high word",
  4925			.u.insns_int = {
  4926				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  4927				BPF_ALU32_IMM(BPF_MOV, R1, 12),
  4928				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  4929				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4930				BPF_EXIT_INSN(),
  4931			},
  4932			INTERNAL,
  4933			{ },
  4934			{ { 0, 0xfff81234 } }
  4935		},
  4936		{
  4937			"ALU64_ARSH_X: Shift > 32, low word",
  4938			.u.insns_int = {
  4939				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  4940				BPF_ALU32_IMM(BPF_MOV, R1, 36),
  4941				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  4942				BPF_EXIT_INSN(),
  4943			},
  4944			INTERNAL,
  4945			{ },
  4946			{ { 0, 0xf8123456 } }
  4947		},
  4948		{
  4949			"ALU64_ARSH_X: Shift > 32, high word",
  4950			.u.insns_int = {
  4951				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  4952				BPF_ALU32_IMM(BPF_MOV, R1, 36),
  4953				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  4954				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4955				BPF_EXIT_INSN(),
  4956			},
  4957			INTERNAL,
  4958			{ },
  4959			{ { 0, -1 } }
  4960		},
  4961		{
  4962			"ALU64_ARSH_X: Shift == 32, low word",
  4963			.u.insns_int = {
  4964				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  4965				BPF_ALU32_IMM(BPF_MOV, R1, 32),
  4966				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  4967				BPF_EXIT_INSN(),
  4968			},
  4969			INTERNAL,
  4970			{ },
  4971			{ { 0, 0x81234567 } }
  4972		},
  4973		{
  4974			"ALU64_ARSH_X: Shift == 32, high word",
  4975			.u.insns_int = {
  4976				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  4977				BPF_ALU32_IMM(BPF_MOV, R1, 32),
  4978				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  4979				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  4980				BPF_EXIT_INSN(),
  4981			},
  4982			INTERNAL,
  4983			{ },
  4984			{ { 0, -1 } }
  4985		},
  4986		{
  4987			"ALU64_ARSH_X: Zero shift, low word",
  4988			.u.insns_int = {
  4989				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  4990				BPF_ALU32_IMM(BPF_MOV, R1, 0),
  4991				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  4992				BPF_EXIT_INSN(),
  4993			},
  4994			INTERNAL,
  4995			{ },
  4996			{ { 0, 0x89abcdef } }
  4997		},
  4998		{
  4999			"ALU64_ARSH_X: Zero shift, high word",
  5000			.u.insns_int = {
  5001				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  5002				BPF_ALU32_IMM(BPF_MOV, R1, 0),
  5003				BPF_ALU64_REG(BPF_ARSH, R0, R1),
  5004				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  5005				BPF_EXIT_INSN(),
  5006			},
  5007			INTERNAL,
  5008			{ },
  5009			{ { 0, 0x81234567 } }
  5010		},
  5011		/* BPF_ALU | BPF_ARSH | BPF_K */
  5012		{
  5013			"ALU32_ARSH_K: -1234 >> 7 = -10",
  5014			.u.insns_int = {
  5015				BPF_ALU32_IMM(BPF_MOV, R0, -1234),
  5016				BPF_ALU32_IMM(BPF_ARSH, R0, 7),
  5017				BPF_EXIT_INSN(),
  5018			},
  5019			INTERNAL,
  5020			{ },
  5021			{ { 0, -10 } }
  5022		},
  5023		{
  5024			"ALU32_ARSH_K: -1234 >> 0 = -1234",
  5025			.u.insns_int = {
  5026				BPF_ALU32_IMM(BPF_MOV, R0, -1234),
  5027				BPF_ALU32_IMM(BPF_ARSH, R0, 0),
  5028				BPF_EXIT_INSN(),
  5029			},
  5030			INTERNAL,
  5031			{ },
  5032			{ { 0, -1234 } }
  5033		},
  5034		{
  5035			"ALU64_ARSH_K: 0xff00ff0000000000 >> 40 = 0xffffffffffff00ff",
  5036			.u.insns_int = {
  5037				BPF_LD_IMM64(R0, 0xff00ff0000000000LL),
  5038				BPF_ALU64_IMM(BPF_ARSH, R0, 40),
  5039				BPF_EXIT_INSN(),
  5040			},
  5041			INTERNAL,
  5042			{ },
  5043			{ { 0, 0xffff00ff } },
  5044		},
  5045		{
  5046			"ALU64_ARSH_K: Shift < 32, low word",
  5047			.u.insns_int = {
  5048				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  5049				BPF_ALU64_IMM(BPF_RSH, R0, 12),
  5050				BPF_EXIT_INSN(),
  5051			},
  5052			INTERNAL,
  5053			{ },
  5054			{ { 0, 0x56789abc } }
  5055		},
  5056		{
  5057			"ALU64_ARSH_K: Shift < 32, high word",
  5058			.u.insns_int = {
  5059				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  5060				BPF_ALU64_IMM(BPF_ARSH, R0, 12),
  5061				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  5062				BPF_EXIT_INSN(),
  5063			},
  5064			INTERNAL,
  5065			{ },
  5066			{ { 0, 0xfff81234 } }
  5067		},
  5068		{
  5069			"ALU64_ARSH_K: Shift > 32, low word",
  5070			.u.insns_int = {
  5071				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  5072				BPF_ALU64_IMM(BPF_ARSH, R0, 36),
  5073				BPF_EXIT_INSN(),
  5074			},
  5075			INTERNAL,
  5076			{ },
  5077			{ { 0, 0xf8123456 } }
  5078		},
  5079		{
  5080			"ALU64_ARSH_K: Shift > 32, high word",
  5081			.u.insns_int = {
  5082				BPF_LD_IMM64(R0, 0xf123456789abcdefLL),
  5083				BPF_ALU64_IMM(BPF_ARSH, R0, 36),
  5084				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  5085				BPF_EXIT_INSN(),
  5086			},
  5087			INTERNAL,
  5088			{ },
  5089			{ { 0, -1 } }
  5090		},
  5091		{
  5092			"ALU64_ARSH_K: Shift == 32, low word",
  5093			.u.insns_int = {
  5094				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  5095				BPF_ALU64_IMM(BPF_ARSH, R0, 32),
  5096				BPF_EXIT_INSN(),
  5097			},
  5098			INTERNAL,
  5099			{ },
  5100			{ { 0, 0x81234567 } }
  5101		},
  5102		{
  5103			"ALU64_ARSH_K: Shift == 32, high word",
  5104			.u.insns_int = {
  5105				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  5106				BPF_ALU64_IMM(BPF_ARSH, R0, 32),
  5107				BPF_ALU64_IMM(BPF_RSH, R0, 32),
  5108				BPF_EXIT_INSN(),
  5109			},
  5110			INTERNAL,
  5111			{ },
  5112			{ { 0, -1 } }
  5113		},
  5114		{
  5115			"ALU64_ARSH_K: Zero shoft",
  5116			.u.insns_int = {
  5117				BPF_LD_IMM64(R0, 0x8123456789abcdefLL),
  5118				BPF_ALU64_IMM(BPF_ARSH, R0, 0),
  5119				BPF_EXIT_INSN(),
  5120			},
  5121			INTERNAL,
  5122			{ },
  5123			{ { 0, 0x89abcdef } }
  5124		},
  5125		/* BPF_ALU | BPF_NEG */
  5126		{
  5127			"ALU_NEG: -(3) = -3",
  5128			.u.insns_int = {
  5129				BPF_ALU32_IMM(BPF_MOV, R0, 3),
  5130				BPF_ALU32_IMM(BPF_NEG, R0, 0),
  5131				BPF_EXIT_INSN(),
  5132			},
  5133			INTERNAL,
  5134			{ },
  5135			{ { 0, -3 } },
  5136		},
  5137		{
  5138			"ALU_NEG: -(-3) = 3",
  5139			.u.insns_int = {
  5140				BPF_ALU32_IMM(BPF_MOV, R0, -3),
  5141				BPF_ALU32_IMM(BPF_NEG, R0, 0),
  5142				BPF_EXIT_INSN(),
  5143			},
  5144			INTERNAL,
  5145			{ },
  5146			{ { 0, 3 } },
  5147		},
  5148		{
  5149			"ALU64_NEG: -(3) = -3",
  5150			.u.insns_int = {
  5151				BPF_LD_IMM64(R0, 3),
  5152				BPF_ALU64_IMM(BPF_NEG, R0, 0),
  5153				BPF_EXIT_INSN(),
  5154			},
  5155			INTERNAL,
  5156			{ },
  5157			{ { 0, -3 } },
  5158		},
  5159		{
  5160			"ALU64_NEG: -(-3) = 3",
  5161			.u.insns_int = {
  5162				BPF_LD_IMM64(R0, -3),
  5163				BPF_ALU64_IMM(BPF_NEG, R0, 0),
  5164				BPF_EXIT_INSN(),
  5165			},
  5166			INTERNAL,
  5167			{ },
  5168			{ { 0, 3 } },
  5169		},
  5170		/* BPF_ALU | BPF_END | BPF_FROM_BE */
  5171		{
  5172			"ALU_END_FROM_BE 16: 0x0123456789abcdef -> 0xcdef",
  5173			.u.insns_int = {
  5174				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  5175				BPF_ENDIAN(BPF_FROM_BE, R0, 16),
  5176				BPF_EXIT_INSN(),
  5177			},
  5178			INTERNAL,
  5179			{ },
  5180			{ { 0,  cpu_to_be16(0xcdef) } },
  5181		},
  5182		{
  5183			"ALU_END_FROM_BE 32: 0x0123456789abcdef -> 0x89abcdef",
  5184			.u.insns_int = {
  5185				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  5186				BPF_ENDIAN(BPF_FROM_BE, R0, 32),
  5187				BPF_ALU64_REG(BPF_MOV, R1, R0),
  5188				BPF_ALU64_IMM(BPF_RSH, R1, 32),
  5189				BPF_ALU32_REG(BPF_ADD, R0, R1), /* R1 = 0 */
  5190				BPF_EXIT_INSN(),
  5191			},
  5192			INTERNAL,
  5193			{ },
  5194			{ { 0, cpu_to_be32(0x89abcdef) } },
  5195		},
  5196		{
  5197			"ALU_END_FROM_BE 64: 0x0123456789abcdef -> 0x89abcdef",
  5198			.u.insns_int = {
  5199				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  5200				BPF_ENDIAN(BPF_FROM_BE, R0, 64),
  5201				BPF_EXIT_INSN(),
  5202			},
  5203			INTERNAL,
  5204			{ },
  5205			{ { 0, (u32) cpu_to_be64(0x0123456789abcdefLL) } },
  5206		},
  5207		/* BPF_ALU | BPF_END | BPF_FROM_LE */
  5208		{
  5209			"ALU_END_FROM_LE 16: 0x0123456789abcdef -> 0xefcd",
  5210			.u.insns_int = {
  5211				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  5212				BPF_ENDIAN(BPF_FROM_LE, R0, 16),
  5213				BPF_EXIT_INSN(),
  5214			},
  5215			INTERNAL,
  5216			{ },
  5217			{ { 0, cpu_to_le16(0xcdef) } },
  5218		},
  5219		{
  5220			"ALU_END_FROM_LE 32: 0x0123456789abcdef -> 0xefcdab89",
  5221			.u.insns_int = {
  5222				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  5223				BPF_ENDIAN(BPF_FROM_LE, R0, 32),
  5224				BPF_ALU64_REG(BPF_MOV, R1, R0),
  5225				BPF_ALU64_IMM(BPF_RSH, R1, 32),
  5226				BPF_ALU32_REG(BPF_ADD, R0, R1), /* R1 = 0 */
  5227				BPF_EXIT_INSN(),
  5228			},
  5229			INTERNAL,
  5230			{ },
  5231			{ { 0, cpu_to_le32(0x89abcdef) } },
  5232		},
  5233		{
  5234			"ALU_END_FROM_LE 64: 0x0123456789abcdef -> 0x67452301",
  5235			.u.insns_int = {
  5236				BPF_LD_IMM64(R0, 0x0123456789abcdefLL),
  5237				BPF_ENDIAN(BPF_FROM_LE, R0, 64),
  5238				BPF_EXIT_INSN(),
  5239			},
  5240			INTERNAL,
  5241			{ },
  5242			{ { 0, (u32) cpu_to_le64(0x0123456789abcdefLL) } },
  5243		},
  5244		/* BPF_ST(X) | BPF_MEM | BPF_B/H/W/DW */
  5245		{
  5246			"ST_MEM_B: Store/Load byte: max negative",
  5247			.u.insns_int = {
  5248				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  5249				BPF_ST_MEM(BPF_B, R10, -40, 0xff),
  5250				BPF_LDX_MEM(BPF_B, R0, R10, -40),
  5251				BPF_EXIT_INSN(),
  5252			},
  5253			INTERNAL,
  5254			{ },
  5255			{ { 0, 0xff } },
  5256			.stack_depth = 40,
  5257		},
  5258		{
  5259			"ST_MEM_B: Store/Load byte: max positive",
  5260			.u.insns_int = {
  5261				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  5262				BPF_ST_MEM(BPF_H, R10, -40, 0x7f),
  5263				BPF_LDX_MEM(BPF_H, R0, R10, -40),
  5264				BPF_EXIT_INSN(),
  5265			},
  5266			INTERNAL,
  5267			{ },
  5268			{ { 0, 0x7f } },
  5269			.stack_depth = 40,
  5270		},
  5271		{
  5272			"STX_MEM_B: Store/Load byte: max negative",
  5273			.u.insns_int = {
  5274				BPF_LD_IMM64(R0, 0),
  5275				BPF_LD_IMM64(R1, 0xffLL),
  5276				BPF_STX_MEM(BPF_B, R10, R1, -40),
  5277				BPF_LDX_MEM(BPF_B, R0, R10, -40),
  5278				BPF_EXIT_INSN(),
  5279			},
  5280			INTERNAL,
  5281			{ },
  5282			{ { 0, 0xff } },
  5283			.stack_depth = 40,
  5284		},
  5285		{
  5286			"ST_MEM_H: Store/Load half word: max negative",
  5287			.u.insns_int = {
  5288				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  5289				BPF_ST_MEM(BPF_H, R10, -40, 0xffff),
  5290				BPF_LDX_MEM(BPF_H, R0, R10, -40),
  5291				BPF_EXIT_INSN(),
  5292			},
  5293			INTERNAL,
  5294			{ },
  5295			{ { 0, 0xffff } },
  5296			.stack_depth = 40,
  5297		},
  5298		{
  5299			"ST_MEM_H: Store/Load half word: max positive",
  5300			.u.insns_int = {
  5301				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  5302				BPF_ST_MEM(BPF_H, R10, -40, 0x7fff),
  5303				BPF_LDX_MEM(BPF_H, R0, R10, -40),
  5304				BPF_EXIT_INSN(),
  5305			},
  5306			INTERNAL,
  5307			{ },
  5308			{ { 0, 0x7fff } },
  5309			.stack_depth = 40,
  5310		},
  5311		{
  5312			"STX_MEM_H: Store/Load half word: max negative",
  5313			.u.insns_int = {
  5314				BPF_LD_IMM64(R0, 0),
  5315				BPF_LD_IMM64(R1, 0xffffLL),
  5316				BPF_STX_MEM(BPF_H, R10, R1, -40),
  5317				BPF_LDX_MEM(BPF_H, R0, R10, -40),
  5318				BPF_EXIT_INSN(),
  5319			},
  5320			INTERNAL,
  5321			{ },
  5322			{ { 0, 0xffff } },
  5323			.stack_depth = 40,
  5324		},
  5325		{
  5326			"ST_MEM_W: Store/Load word: max negative",
  5327			.u.insns_int = {
  5328				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  5329				BPF_ST_MEM(BPF_W, R10, -40, 0xffffffff),
  5330				BPF_LDX_MEM(BPF_W, R0, R10, -40),
  5331				BPF_EXIT_INSN(),
  5332			},
  5333			INTERNAL,
  5334			{ },
  5335			{ { 0, 0xffffffff } },
  5336			.stack_depth = 40,
  5337		},
  5338		{
  5339			"ST_MEM_W: Store/Load word: max positive",
  5340			.u.insns_int = {
  5341				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  5342				BPF_ST_MEM(BPF_W, R10, -40, 0x7fffffff),
  5343				BPF_LDX_MEM(BPF_W, R0, R10, -40),
  5344				BPF_EXIT_INSN(),
  5345			},
  5346			INTERNAL,
  5347			{ },
  5348			{ { 0, 0x7fffffff } },
  5349			.stack_depth = 40,
  5350		},
  5351		{
  5352			"STX_MEM_W: Store/Load word: max negative",
  5353			.u.insns_int = {
  5354				BPF_LD_IMM64(R0, 0),
  5355				BPF_LD_IMM64(R1, 0xffffffffLL),
  5356				BPF_STX_MEM(BPF_W, R10, R1, -40),
  5357				BPF_LDX_MEM(BPF_W, R0, R10, -40),
  5358				BPF_EXIT_INSN(),
  5359			},
  5360			INTERNAL,
  5361			{ },
  5362			{ { 0, 0xffffffff } },
  5363			.stack_depth = 40,
  5364		},
  5365		{
  5366			"ST_MEM_DW: Store/Load double word: max negative",
  5367			.u.insns_int = {
  5368				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  5369				BPF_ST_MEM(BPF_DW, R10, -40, 0xffffffff),
  5370				BPF_LDX_MEM(BPF_DW, R0, R10, -40),
  5371				BPF_EXIT_INSN(),
  5372			},
  5373			INTERNAL,
  5374			{ },
  5375			{ { 0, 0xffffffff } },
  5376			.stack_depth = 40,
  5377		},
  5378		{
  5379			"ST_MEM_DW: Store/Load double word: max negative 2",
  5380			.u.insns_int = {
  5381				BPF_LD_IMM64(R2, 0xffff00000000ffffLL),
  5382				BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
  5383				BPF_ST_MEM(BPF_DW, R10, -40, 0xffffffff),
  5384				BPF_LDX_MEM(BPF_DW, R2, R10, -40),
  5385				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  5386				BPF_MOV32_IMM(R0, 2),
  5387				BPF_EXIT_INSN(),
  5388				BPF_MOV32_IMM(R0, 1),
  5389				BPF_EXIT_INSN(),
  5390			},
  5391			INTERNAL,
  5392			{ },
  5393			{ { 0, 0x1 } },
  5394			.stack_depth = 40,
  5395		},
  5396		{
  5397			"ST_MEM_DW: Store/Load double word: max positive",
  5398			.u.insns_int = {
  5399				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  5400				BPF_ST_MEM(BPF_DW, R10, -40, 0x7fffffff),
  5401				BPF_LDX_MEM(BPF_DW, R0, R10, -40),
  5402				BPF_EXIT_INSN(),
  5403			},
  5404			INTERNAL,
  5405			{ },
  5406			{ { 0, 0x7fffffff } },
  5407			.stack_depth = 40,
  5408		},
  5409		{
  5410			"STX_MEM_DW: Store/Load double word: max negative",
  5411			.u.insns_int = {
  5412				BPF_LD_IMM64(R0, 0),
  5413				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  5414				BPF_STX_MEM(BPF_DW, R10, R1, -40),
  5415				BPF_LDX_MEM(BPF_DW, R0, R10, -40),
  5416				BPF_EXIT_INSN(),
  5417			},
  5418			INTERNAL,
  5419			{ },
  5420			{ { 0, 0xffffffff } },
  5421			.stack_depth = 40,
  5422		},
  5423		/* BPF_STX | BPF_ATOMIC | BPF_W/DW */
  5424		{
  5425			"STX_XADD_W: Test: 0x12 + 0x10 = 0x22",
  5426			.u.insns_int = {
  5427				BPF_ALU32_IMM(BPF_MOV, R0, 0x12),
  5428				BPF_ST_MEM(BPF_W, R10, -40, 0x10),
  5429				BPF_ATOMIC_OP(BPF_W, BPF_ADD, R10, R0, -40),
  5430				BPF_LDX_MEM(BPF_W, R0, R10, -40),
  5431				BPF_EXIT_INSN(),
  5432			},
  5433			INTERNAL,
  5434			{ },
  5435			{ { 0, 0x22 } },
  5436			.stack_depth = 40,
  5437		},
  5438		{
  5439			"STX_XADD_W: Test side-effects, r10: 0x12 + 0x10 = 0x22",
  5440			.u.insns_int = {
  5441				BPF_ALU64_REG(BPF_MOV, R1, R10),
  5442				BPF_ALU32_IMM(BPF_MOV, R0, 0x12),
  5443				BPF_ST_MEM(BPF_W, R10, -40, 0x10),
  5444				BPF_ATOMIC_OP(BPF_W, BPF_ADD, R10, R0, -40),
  5445				BPF_ALU64_REG(BPF_MOV, R0, R10),
  5446				BPF_ALU64_REG(BPF_SUB, R0, R1),
  5447				BPF_EXIT_INSN(),
  5448			},
  5449			INTERNAL,
  5450			{ },
  5451			{ { 0, 0 } },
  5452			.stack_depth = 40,
  5453		},
  5454		{
  5455			"STX_XADD_W: Test side-effects, r0: 0x12 + 0x10 = 0x22",
  5456			.u.insns_int = {
  5457				BPF_ALU32_IMM(BPF_MOV, R0, 0x12),
  5458				BPF_ST_MEM(BPF_W, R10, -40, 0x10),
  5459				BPF_ATOMIC_OP(BPF_W, BPF_ADD, R10, R0, -40),
  5460				BPF_EXIT_INSN(),
  5461			},
  5462			INTERNAL,
  5463			{ },
  5464			{ { 0, 0x12 } },
  5465			.stack_depth = 40,
  5466		},
  5467		{
  5468			"STX_XADD_W: X + 1 + 1 + 1 + ...",
  5469			{ },
  5470			INTERNAL,
  5471			{ },
  5472			{ { 0, 4134 } },
  5473			.fill_helper = bpf_fill_stxw,
  5474		},
  5475		{
  5476			"STX_XADD_DW: Test: 0x12 + 0x10 = 0x22",
  5477			.u.insns_int = {
  5478				BPF_ALU32_IMM(BPF_MOV, R0, 0x12),
  5479				BPF_ST_MEM(BPF_DW, R10, -40, 0x10),
  5480				BPF_ATOMIC_OP(BPF_DW, BPF_ADD, R10, R0, -40),
  5481				BPF_LDX_MEM(BPF_DW, R0, R10, -40),
  5482				BPF_EXIT_INSN(),
  5483			},
  5484			INTERNAL,
  5485			{ },
  5486			{ { 0, 0x22 } },
  5487			.stack_depth = 40,
  5488		},
  5489		{
  5490			"STX_XADD_DW: Test side-effects, r10: 0x12 + 0x10 = 0x22",
  5491			.u.insns_int = {
  5492				BPF_ALU64_REG(BPF_MOV, R1, R10),
  5493				BPF_ALU32_IMM(BPF_MOV, R0, 0x12),
  5494				BPF_ST_MEM(BPF_DW, R10, -40, 0x10),
  5495				BPF_ATOMIC_OP(BPF_DW, BPF_ADD, R10, R0, -40),
  5496				BPF_ALU64_REG(BPF_MOV, R0, R10),
  5497				BPF_ALU64_REG(BPF_SUB, R0, R1),
  5498				BPF_EXIT_INSN(),
  5499			},
  5500			INTERNAL,
  5501			{ },
  5502			{ { 0, 0 } },
  5503			.stack_depth = 40,
  5504		},
  5505		{
  5506			"STX_XADD_DW: Test side-effects, r0: 0x12 + 0x10 = 0x22",
  5507			.u.insns_int = {
  5508				BPF_ALU32_IMM(BPF_MOV, R0, 0x12),
  5509				BPF_ST_MEM(BPF_DW, R10, -40, 0x10),
  5510				BPF_ATOMIC_OP(BPF_DW, BPF_ADD, R10, R0, -40),
  5511				BPF_EXIT_INSN(),
  5512			},
  5513			INTERNAL,
  5514			{ },
  5515			{ { 0, 0x12 } },
  5516			.stack_depth = 40,
  5517		},
  5518		{
  5519			"STX_XADD_DW: X + 1 + 1 + 1 + ...",
  5520			{ },
  5521			INTERNAL,
  5522			{ },
  5523			{ { 0, 4134 } },
  5524			.fill_helper = bpf_fill_stxdw,
  5525		},
  5526		/* BPF_JMP32 | BPF_JEQ | BPF_K */
  5527		{
  5528			"JMP32_JEQ_K: Small immediate",
  5529			.u.insns_int = {
  5530				BPF_ALU32_IMM(BPF_MOV, R0, 123),
  5531				BPF_JMP32_IMM(BPF_JEQ, R0, 321, 1),
  5532				BPF_JMP32_IMM(BPF_JEQ, R0, 123, 1),
  5533				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5534				BPF_EXIT_INSN(),
  5535			},
  5536			INTERNAL,
  5537			{ },
  5538			{ { 0, 123 } }
  5539		},
  5540		{
  5541			"JMP32_JEQ_K: Large immediate",
  5542			.u.insns_int = {
  5543				BPF_ALU32_IMM(BPF_MOV, R0, 12345678),
  5544				BPF_JMP32_IMM(BPF_JEQ, R0, 12345678 & 0xffff, 1),
  5545				BPF_JMP32_IMM(BPF_JEQ, R0, 12345678, 1),
  5546				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5547				BPF_EXIT_INSN(),
  5548			},
  5549			INTERNAL,
  5550			{ },
  5551			{ { 0, 12345678 } }
  5552		},
  5553		{
  5554			"JMP32_JEQ_K: negative immediate",
  5555			.u.insns_int = {
  5556				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  5557				BPF_JMP32_IMM(BPF_JEQ, R0,  123, 1),
  5558				BPF_JMP32_IMM(BPF_JEQ, R0, -123, 1),
  5559				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5560				BPF_EXIT_INSN(),
  5561			},
  5562			INTERNAL,
  5563			{ },
  5564			{ { 0, -123 } }
  5565		},
  5566		/* BPF_JMP32 | BPF_JEQ | BPF_X */
  5567		{
  5568			"JMP32_JEQ_X",
  5569			.u.insns_int = {
  5570				BPF_ALU32_IMM(BPF_MOV, R0, 1234),
  5571				BPF_ALU32_IMM(BPF_MOV, R1, 4321),
  5572				BPF_JMP32_REG(BPF_JEQ, R0, R1, 2),
  5573				BPF_ALU32_IMM(BPF_MOV, R1, 1234),
  5574				BPF_JMP32_REG(BPF_JEQ, R0, R1, 1),
  5575				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5576				BPF_EXIT_INSN(),
  5577			},
  5578			INTERNAL,
  5579			{ },
  5580			{ { 0, 1234 } }
  5581		},
  5582		/* BPF_JMP32 | BPF_JNE | BPF_K */
  5583		{
  5584			"JMP32_JNE_K: Small immediate",
  5585			.u.insns_int = {
  5586				BPF_ALU32_IMM(BPF_MOV, R0, 123),
  5587				BPF_JMP32_IMM(BPF_JNE, R0, 123, 1),
  5588				BPF_JMP32_IMM(BPF_JNE, R0, 321, 1),
  5589				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5590				BPF_EXIT_INSN(),
  5591			},
  5592			INTERNAL,
  5593			{ },
  5594			{ { 0, 123 } }
  5595		},
  5596		{
  5597			"JMP32_JNE_K: Large immediate",
  5598			.u.insns_int = {
  5599				BPF_ALU32_IMM(BPF_MOV, R0, 12345678),
  5600				BPF_JMP32_IMM(BPF_JNE, R0, 12345678, 1),
  5601				BPF_JMP32_IMM(BPF_JNE, R0, 12345678 & 0xffff, 1),
  5602				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5603				BPF_EXIT_INSN(),
  5604			},
  5605			INTERNAL,
  5606			{ },
  5607			{ { 0, 12345678 } }
  5608		},
  5609		{
  5610			"JMP32_JNE_K: negative immediate",
  5611			.u.insns_int = {
  5612				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  5613				BPF_JMP32_IMM(BPF_JNE, R0, -123, 1),
  5614				BPF_JMP32_IMM(BPF_JNE, R0,  123, 1),
  5615				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5616				BPF_EXIT_INSN(),
  5617			},
  5618			INTERNAL,
  5619			{ },
  5620			{ { 0, -123 } }
  5621		},
  5622		/* BPF_JMP32 | BPF_JNE | BPF_X */
  5623		{
  5624			"JMP32_JNE_X",
  5625			.u.insns_int = {
  5626				BPF_ALU32_IMM(BPF_MOV, R0, 1234),
  5627				BPF_ALU32_IMM(BPF_MOV, R1, 1234),
  5628				BPF_JMP32_REG(BPF_JNE, R0, R1, 2),
  5629				BPF_ALU32_IMM(BPF_MOV, R1, 4321),
  5630				BPF_JMP32_REG(BPF_JNE, R0, R1, 1),
  5631				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5632				BPF_EXIT_INSN(),
  5633			},
  5634			INTERNAL,
  5635			{ },
  5636			{ { 0, 1234 } }
  5637		},
  5638		/* BPF_JMP32 | BPF_JSET | BPF_K */
  5639		{
  5640			"JMP32_JSET_K: Small immediate",
  5641			.u.insns_int = {
  5642				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  5643				BPF_JMP32_IMM(BPF_JSET, R0, 2, 1),
  5644				BPF_JMP32_IMM(BPF_JSET, R0, 3, 1),
  5645				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5646				BPF_EXIT_INSN(),
  5647			},
  5648			INTERNAL,
  5649			{ },
  5650			{ { 0, 1 } }
  5651		},
  5652		{
  5653			"JMP32_JSET_K: Large immediate",
  5654			.u.insns_int = {
  5655				BPF_ALU32_IMM(BPF_MOV, R0, 0x40000000),
  5656				BPF_JMP32_IMM(BPF_JSET, R0, 0x3fffffff, 1),
  5657				BPF_JMP32_IMM(BPF_JSET, R0, 0x60000000, 1),
  5658				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5659				BPF_EXIT_INSN(),
  5660			},
  5661			INTERNAL,
  5662			{ },
  5663			{ { 0, 0x40000000 } }
  5664		},
  5665		{
  5666			"JMP32_JSET_K: negative immediate",
  5667			.u.insns_int = {
  5668				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  5669				BPF_JMP32_IMM(BPF_JSET, R0, -1, 1),
  5670				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5671				BPF_EXIT_INSN(),
  5672			},
  5673			INTERNAL,
  5674			{ },
  5675			{ { 0, -123 } }
  5676		},
  5677		/* BPF_JMP32 | BPF_JSET | BPF_X */
  5678		{
  5679			"JMP32_JSET_X",
  5680			.u.insns_int = {
  5681				BPF_ALU32_IMM(BPF_MOV, R0, 8),
  5682				BPF_ALU32_IMM(BPF_MOV, R1, 7),
  5683				BPF_JMP32_REG(BPF_JSET, R0, R1, 2),
  5684				BPF_ALU32_IMM(BPF_MOV, R1, 8 | 2),
  5685				BPF_JMP32_REG(BPF_JNE, R0, R1, 1),
  5686				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5687				BPF_EXIT_INSN(),
  5688			},
  5689			INTERNAL,
  5690			{ },
  5691			{ { 0, 8 } }
  5692		},
  5693		/* BPF_JMP32 | BPF_JGT | BPF_K */
  5694		{
  5695			"JMP32_JGT_K: Small immediate",
  5696			.u.insns_int = {
  5697				BPF_ALU32_IMM(BPF_MOV, R0, 123),
  5698				BPF_JMP32_IMM(BPF_JGT, R0, 123, 1),
  5699				BPF_JMP32_IMM(BPF_JGT, R0, 122, 1),
  5700				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5701				BPF_EXIT_INSN(),
  5702			},
  5703			INTERNAL,
  5704			{ },
  5705			{ { 0, 123 } }
  5706		},
  5707		{
  5708			"JMP32_JGT_K: Large immediate",
  5709			.u.insns_int = {
  5710				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  5711				BPF_JMP32_IMM(BPF_JGT, R0, 0xffffffff, 1),
  5712				BPF_JMP32_IMM(BPF_JGT, R0, 0xfffffffd, 1),
  5713				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5714				BPF_EXIT_INSN(),
  5715			},
  5716			INTERNAL,
  5717			{ },
  5718			{ { 0, 0xfffffffe } }
  5719		},
  5720		/* BPF_JMP32 | BPF_JGT | BPF_X */
  5721		{
  5722			"JMP32_JGT_X",
  5723			.u.insns_int = {
  5724				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  5725				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  5726				BPF_JMP32_REG(BPF_JGT, R0, R1, 2),
  5727				BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffd),
  5728				BPF_JMP32_REG(BPF_JGT, R0, R1, 1),
  5729				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5730				BPF_EXIT_INSN(),
  5731			},
  5732			INTERNAL,
  5733			{ },
  5734			{ { 0, 0xfffffffe } }
  5735		},
  5736		/* BPF_JMP32 | BPF_JGE | BPF_K */
  5737		{
  5738			"JMP32_JGE_K: Small immediate",
  5739			.u.insns_int = {
  5740				BPF_ALU32_IMM(BPF_MOV, R0, 123),
  5741				BPF_JMP32_IMM(BPF_JGE, R0, 124, 1),
  5742				BPF_JMP32_IMM(BPF_JGE, R0, 123, 1),
  5743				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5744				BPF_EXIT_INSN(),
  5745			},
  5746			INTERNAL,
  5747			{ },
  5748			{ { 0, 123 } }
  5749		},
  5750		{
  5751			"JMP32_JGE_K: Large immediate",
  5752			.u.insns_int = {
  5753				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  5754				BPF_JMP32_IMM(BPF_JGE, R0, 0xffffffff, 1),
  5755				BPF_JMP32_IMM(BPF_JGE, R0, 0xfffffffe, 1),
  5756				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5757				BPF_EXIT_INSN(),
  5758			},
  5759			INTERNAL,
  5760			{ },
  5761			{ { 0, 0xfffffffe } }
  5762		},
  5763		/* BPF_JMP32 | BPF_JGE | BPF_X */
  5764		{
  5765			"JMP32_JGE_X",
  5766			.u.insns_int = {
  5767				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  5768				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  5769				BPF_JMP32_REG(BPF_JGE, R0, R1, 2),
  5770				BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffe),
  5771				BPF_JMP32_REG(BPF_JGE, R0, R1, 1),
  5772				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5773				BPF_EXIT_INSN(),
  5774			},
  5775			INTERNAL,
  5776			{ },
  5777			{ { 0, 0xfffffffe } }
  5778		},
  5779		/* BPF_JMP32 | BPF_JLT | BPF_K */
  5780		{
  5781			"JMP32_JLT_K: Small immediate",
  5782			.u.insns_int = {
  5783				BPF_ALU32_IMM(BPF_MOV, R0, 123),
  5784				BPF_JMP32_IMM(BPF_JLT, R0, 123, 1),
  5785				BPF_JMP32_IMM(BPF_JLT, R0, 124, 1),
  5786				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5787				BPF_EXIT_INSN(),
  5788			},
  5789			INTERNAL,
  5790			{ },
  5791			{ { 0, 123 } }
  5792		},
  5793		{
  5794			"JMP32_JLT_K: Large immediate",
  5795			.u.insns_int = {
  5796				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  5797				BPF_JMP32_IMM(BPF_JLT, R0, 0xfffffffd, 1),
  5798				BPF_JMP32_IMM(BPF_JLT, R0, 0xffffffff, 1),
  5799				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5800				BPF_EXIT_INSN(),
  5801			},
  5802			INTERNAL,
  5803			{ },
  5804			{ { 0, 0xfffffffe } }
  5805		},
  5806		/* BPF_JMP32 | BPF_JLT | BPF_X */
  5807		{
  5808			"JMP32_JLT_X",
  5809			.u.insns_int = {
  5810				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  5811				BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffd),
  5812				BPF_JMP32_REG(BPF_JLT, R0, R1, 2),
  5813				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  5814				BPF_JMP32_REG(BPF_JLT, R0, R1, 1),
  5815				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5816				BPF_EXIT_INSN(),
  5817			},
  5818			INTERNAL,
  5819			{ },
  5820			{ { 0, 0xfffffffe } }
  5821		},
  5822		/* BPF_JMP32 | BPF_JLE | BPF_K */
  5823		{
  5824			"JMP32_JLE_K: Small immediate",
  5825			.u.insns_int = {
  5826				BPF_ALU32_IMM(BPF_MOV, R0, 123),
  5827				BPF_JMP32_IMM(BPF_JLE, R0, 122, 1),
  5828				BPF_JMP32_IMM(BPF_JLE, R0, 123, 1),
  5829				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5830				BPF_EXIT_INSN(),
  5831			},
  5832			INTERNAL,
  5833			{ },
  5834			{ { 0, 123 } }
  5835		},
  5836		{
  5837			"JMP32_JLE_K: Large immediate",
  5838			.u.insns_int = {
  5839				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  5840				BPF_JMP32_IMM(BPF_JLE, R0, 0xfffffffd, 1),
  5841				BPF_JMP32_IMM(BPF_JLE, R0, 0xfffffffe, 1),
  5842				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5843				BPF_EXIT_INSN(),
  5844			},
  5845			INTERNAL,
  5846			{ },
  5847			{ { 0, 0xfffffffe } }
  5848		},
  5849		/* BPF_JMP32 | BPF_JLE | BPF_X */
  5850		{
  5851			"JMP32_JLE_X",
  5852			.u.insns_int = {
  5853				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  5854				BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffd),
  5855				BPF_JMP32_REG(BPF_JLE, R0, R1, 2),
  5856				BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffe),
  5857				BPF_JMP32_REG(BPF_JLE, R0, R1, 1),
  5858				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5859				BPF_EXIT_INSN(),
  5860			},
  5861			INTERNAL,
  5862			{ },
  5863			{ { 0, 0xfffffffe } }
  5864		},
  5865		/* BPF_JMP32 | BPF_JSGT | BPF_K */
  5866		{
  5867			"JMP32_JSGT_K: Small immediate",
  5868			.u.insns_int = {
  5869				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  5870				BPF_JMP32_IMM(BPF_JSGT, R0, -123, 1),
  5871				BPF_JMP32_IMM(BPF_JSGT, R0, -124, 1),
  5872				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5873				BPF_EXIT_INSN(),
  5874			},
  5875			INTERNAL,
  5876			{ },
  5877			{ { 0, -123 } }
  5878		},
  5879		{
  5880			"JMP32_JSGT_K: Large immediate",
  5881			.u.insns_int = {
  5882				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  5883				BPF_JMP32_IMM(BPF_JSGT, R0, -12345678, 1),
  5884				BPF_JMP32_IMM(BPF_JSGT, R0, -12345679, 1),
  5885				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5886				BPF_EXIT_INSN(),
  5887			},
  5888			INTERNAL,
  5889			{ },
  5890			{ { 0, -12345678 } }
  5891		},
  5892		/* BPF_JMP32 | BPF_JSGT | BPF_X */
  5893		{
  5894			"JMP32_JSGT_X",
  5895			.u.insns_int = {
  5896				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  5897				BPF_ALU32_IMM(BPF_MOV, R1, -12345678),
  5898				BPF_JMP32_REG(BPF_JSGT, R0, R1, 2),
  5899				BPF_ALU32_IMM(BPF_MOV, R1, -12345679),
  5900				BPF_JMP32_REG(BPF_JSGT, R0, R1, 1),
  5901				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5902				BPF_EXIT_INSN(),
  5903			},
  5904			INTERNAL,
  5905			{ },
  5906			{ { 0, -12345678 } }
  5907		},
  5908		/* BPF_JMP32 | BPF_JSGE | BPF_K */
  5909		{
  5910			"JMP32_JSGE_K: Small immediate",
  5911			.u.insns_int = {
  5912				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  5913				BPF_JMP32_IMM(BPF_JSGE, R0, -122, 1),
  5914				BPF_JMP32_IMM(BPF_JSGE, R0, -123, 1),
  5915				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5916				BPF_EXIT_INSN(),
  5917			},
  5918			INTERNAL,
  5919			{ },
  5920			{ { 0, -123 } }
  5921		},
  5922		{
  5923			"JMP32_JSGE_K: Large immediate",
  5924			.u.insns_int = {
  5925				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  5926				BPF_JMP32_IMM(BPF_JSGE, R0, -12345677, 1),
  5927				BPF_JMP32_IMM(BPF_JSGE, R0, -12345678, 1),
  5928				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5929				BPF_EXIT_INSN(),
  5930			},
  5931			INTERNAL,
  5932			{ },
  5933			{ { 0, -12345678 } }
  5934		},
  5935		/* BPF_JMP32 | BPF_JSGE | BPF_X */
  5936		{
  5937			"JMP32_JSGE_X",
  5938			.u.insns_int = {
  5939				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  5940				BPF_ALU32_IMM(BPF_MOV, R1, -12345677),
  5941				BPF_JMP32_REG(BPF_JSGE, R0, R1, 2),
  5942				BPF_ALU32_IMM(BPF_MOV, R1, -12345678),
  5943				BPF_JMP32_REG(BPF_JSGE, R0, R1, 1),
  5944				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5945				BPF_EXIT_INSN(),
  5946			},
  5947			INTERNAL,
  5948			{ },
  5949			{ { 0, -12345678 } }
  5950		},
  5951		/* BPF_JMP32 | BPF_JSLT | BPF_K */
  5952		{
  5953			"JMP32_JSLT_K: Small immediate",
  5954			.u.insns_int = {
  5955				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  5956				BPF_JMP32_IMM(BPF_JSLT, R0, -123, 1),
  5957				BPF_JMP32_IMM(BPF_JSLT, R0, -122, 1),
  5958				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5959				BPF_EXIT_INSN(),
  5960			},
  5961			INTERNAL,
  5962			{ },
  5963			{ { 0, -123 } }
  5964		},
  5965		{
  5966			"JMP32_JSLT_K: Large immediate",
  5967			.u.insns_int = {
  5968				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  5969				BPF_JMP32_IMM(BPF_JSLT, R0, -12345678, 1),
  5970				BPF_JMP32_IMM(BPF_JSLT, R0, -12345677, 1),
  5971				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5972				BPF_EXIT_INSN(),
  5973			},
  5974			INTERNAL,
  5975			{ },
  5976			{ { 0, -12345678 } }
  5977		},
  5978		/* BPF_JMP32 | BPF_JSLT | BPF_X */
  5979		{
  5980			"JMP32_JSLT_X",
  5981			.u.insns_int = {
  5982				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  5983				BPF_ALU32_IMM(BPF_MOV, R1, -12345678),
  5984				BPF_JMP32_REG(BPF_JSLT, R0, R1, 2),
  5985				BPF_ALU32_IMM(BPF_MOV, R1, -12345677),
  5986				BPF_JMP32_REG(BPF_JSLT, R0, R1, 1),
  5987				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  5988				BPF_EXIT_INSN(),
  5989			},
  5990			INTERNAL,
  5991			{ },
  5992			{ { 0, -12345678 } }
  5993		},
  5994		/* BPF_JMP32 | BPF_JSLE | BPF_K */
  5995		{
  5996			"JMP32_JSLE_K: Small immediate",
  5997			.u.insns_int = {
  5998				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  5999				BPF_JMP32_IMM(BPF_JSLE, R0, -124, 1),
  6000				BPF_JMP32_IMM(BPF_JSLE, R0, -123, 1),
  6001				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6002				BPF_EXIT_INSN(),
  6003			},
  6004			INTERNAL,
  6005			{ },
  6006			{ { 0, -123 } }
  6007		},
  6008		{
  6009			"JMP32_JSLE_K: Large immediate",
  6010			.u.insns_int = {
  6011				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  6012				BPF_JMP32_IMM(BPF_JSLE, R0, -12345679, 1),
  6013				BPF_JMP32_IMM(BPF_JSLE, R0, -12345678, 1),
  6014				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6015				BPF_EXIT_INSN(),
  6016			},
  6017			INTERNAL,
  6018			{ },
  6019			{ { 0, -12345678 } }
  6020		},
  6021		/* BPF_JMP32 | BPF_JSLE | BPF_K */
  6022		{
  6023			"JMP32_JSLE_X",
  6024			.u.insns_int = {
  6025				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  6026				BPF_ALU32_IMM(BPF_MOV, R1, -12345679),
  6027				BPF_JMP32_REG(BPF_JSLE, R0, R1, 2),
  6028				BPF_ALU32_IMM(BPF_MOV, R1, -12345678),
  6029				BPF_JMP32_REG(BPF_JSLE, R0, R1, 1),
  6030				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6031				BPF_EXIT_INSN(),
  6032			},
  6033			INTERNAL,
  6034			{ },
  6035			{ { 0, -12345678 } }
  6036		},
  6037		/* BPF_JMP | BPF_EXIT */
  6038		{
  6039			"JMP_EXIT",
  6040			.u.insns_int = {
  6041				BPF_ALU32_IMM(BPF_MOV, R0, 0x4711),
  6042				BPF_EXIT_INSN(),
  6043				BPF_ALU32_IMM(BPF_MOV, R0, 0x4712),
  6044			},
  6045			INTERNAL,
  6046			{ },
  6047			{ { 0, 0x4711 } },
  6048		},
  6049		/* BPF_JMP | BPF_JA */
  6050		{
  6051			"JMP_JA: Unconditional jump: if (true) return 1",
  6052			.u.insns_int = {
  6053				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6054				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
  6055				BPF_EXIT_INSN(),
  6056				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6057				BPF_EXIT_INSN(),
  6058			},
  6059			INTERNAL,
  6060			{ },
  6061			{ { 0, 1 } },
  6062		},
  6063		/* BPF_JMP | BPF_JSLT | BPF_K */
  6064		{
  6065			"JMP_JSLT_K: Signed jump: if (-2 < -1) return 1",
  6066			.u.insns_int = {
  6067				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6068				BPF_LD_IMM64(R1, 0xfffffffffffffffeLL),
  6069				BPF_JMP_IMM(BPF_JSLT, R1, -1, 1),
  6070				BPF_EXIT_INSN(),
  6071				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6072				BPF_EXIT_INSN(),
  6073			},
  6074			INTERNAL,
  6075			{ },
  6076			{ { 0, 1 } },
  6077		},
  6078		{
  6079			"JMP_JSLT_K: Signed jump: if (-1 < -1) return 0",
  6080			.u.insns_int = {
  6081				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6082				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  6083				BPF_JMP_IMM(BPF_JSLT, R1, -1, 1),
  6084				BPF_EXIT_INSN(),
  6085				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6086				BPF_EXIT_INSN(),
  6087			},
  6088			INTERNAL,
  6089			{ },
  6090			{ { 0, 1 } },
  6091		},
  6092		/* BPF_JMP | BPF_JSGT | BPF_K */
  6093		{
  6094			"JMP_JSGT_K: Signed jump: if (-1 > -2) return 1",
  6095			.u.insns_int = {
  6096				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6097				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  6098				BPF_JMP_IMM(BPF_JSGT, R1, -2, 1),
  6099				BPF_EXIT_INSN(),
  6100				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6101				BPF_EXIT_INSN(),
  6102			},
  6103			INTERNAL,
  6104			{ },
  6105			{ { 0, 1 } },
  6106		},
  6107		{
  6108			"JMP_JSGT_K: Signed jump: if (-1 > -1) return 0",
  6109			.u.insns_int = {
  6110				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6111				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  6112				BPF_JMP_IMM(BPF_JSGT, R1, -1, 1),
  6113				BPF_EXIT_INSN(),
  6114				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6115				BPF_EXIT_INSN(),
  6116			},
  6117			INTERNAL,
  6118			{ },
  6119			{ { 0, 1 } },
  6120		},
  6121		/* BPF_JMP | BPF_JSLE | BPF_K */
  6122		{
  6123			"JMP_JSLE_K: Signed jump: if (-2 <= -1) return 1",
  6124			.u.insns_int = {
  6125				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6126				BPF_LD_IMM64(R1, 0xfffffffffffffffeLL),
  6127				BPF_JMP_IMM(BPF_JSLE, R1, -1, 1),
  6128				BPF_EXIT_INSN(),
  6129				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6130				BPF_EXIT_INSN(),
  6131			},
  6132			INTERNAL,
  6133			{ },
  6134			{ { 0, 1 } },
  6135		},
  6136		{
  6137			"JMP_JSLE_K: Signed jump: if (-1 <= -1) return 1",
  6138			.u.insns_int = {
  6139				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6140				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  6141				BPF_JMP_IMM(BPF_JSLE, R1, -1, 1),
  6142				BPF_EXIT_INSN(),
  6143				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6144				BPF_EXIT_INSN(),
  6145			},
  6146			INTERNAL,
  6147			{ },
  6148			{ { 0, 1 } },
  6149		},
  6150		{
  6151			"JMP_JSLE_K: Signed jump: value walk 1",
  6152			.u.insns_int = {
  6153				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6154				BPF_LD_IMM64(R1, 3),
  6155				BPF_JMP_IMM(BPF_JSLE, R1, 0, 6),
  6156				BPF_ALU64_IMM(BPF_SUB, R1, 1),
  6157				BPF_JMP_IMM(BPF_JSLE, R1, 0, 4),
  6158				BPF_ALU64_IMM(BPF_SUB, R1, 1),
  6159				BPF_JMP_IMM(BPF_JSLE, R1, 0, 2),
  6160				BPF_ALU64_IMM(BPF_SUB, R1, 1),
  6161				BPF_JMP_IMM(BPF_JSLE, R1, 0, 1),
  6162				BPF_EXIT_INSN(),		/* bad exit */
  6163				BPF_ALU32_IMM(BPF_MOV, R0, 1),	/* good exit */
  6164				BPF_EXIT_INSN(),
  6165			},
  6166			INTERNAL,
  6167			{ },
  6168			{ { 0, 1 } },
  6169		},
  6170		{
  6171			"JMP_JSLE_K: Signed jump: value walk 2",
  6172			.u.insns_int = {
  6173				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6174				BPF_LD_IMM64(R1, 3),
  6175				BPF_JMP_IMM(BPF_JSLE, R1, 0, 4),
  6176				BPF_ALU64_IMM(BPF_SUB, R1, 2),
  6177				BPF_JMP_IMM(BPF_JSLE, R1, 0, 2),
  6178				BPF_ALU64_IMM(BPF_SUB, R1, 2),
  6179				BPF_JMP_IMM(BPF_JSLE, R1, 0, 1),
  6180				BPF_EXIT_INSN(),		/* bad exit */
  6181				BPF_ALU32_IMM(BPF_MOV, R0, 1),	/* good exit */
  6182				BPF_EXIT_INSN(),
  6183			},
  6184			INTERNAL,
  6185			{ },
  6186			{ { 0, 1 } },
  6187		},
  6188		/* BPF_JMP | BPF_JSGE | BPF_K */
  6189		{
  6190			"JMP_JSGE_K: Signed jump: if (-1 >= -2) return 1",
  6191			.u.insns_int = {
  6192				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6193				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  6194				BPF_JMP_IMM(BPF_JSGE, R1, -2, 1),
  6195				BPF_EXIT_INSN(),
  6196				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6197				BPF_EXIT_INSN(),
  6198			},
  6199			INTERNAL,
  6200			{ },
  6201			{ { 0, 1 } },
  6202		},
  6203		{
  6204			"JMP_JSGE_K: Signed jump: if (-1 >= -1) return 1",
  6205			.u.insns_int = {
  6206				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6207				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  6208				BPF_JMP_IMM(BPF_JSGE, R1, -1, 1),
  6209				BPF_EXIT_INSN(),
  6210				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6211				BPF_EXIT_INSN(),
  6212			},
  6213			INTERNAL,
  6214			{ },
  6215			{ { 0, 1 } },
  6216		},
  6217		{
  6218			"JMP_JSGE_K: Signed jump: value walk 1",
  6219			.u.insns_int = {
  6220				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6221				BPF_LD_IMM64(R1, -3),
  6222				BPF_JMP_IMM(BPF_JSGE, R1, 0, 6),
  6223				BPF_ALU64_IMM(BPF_ADD, R1, 1),
  6224				BPF_JMP_IMM(BPF_JSGE, R1, 0, 4),
  6225				BPF_ALU64_IMM(BPF_ADD, R1, 1),
  6226				BPF_JMP_IMM(BPF_JSGE, R1, 0, 2),
  6227				BPF_ALU64_IMM(BPF_ADD, R1, 1),
  6228				BPF_JMP_IMM(BPF_JSGE, R1, 0, 1),
  6229				BPF_EXIT_INSN(),		/* bad exit */
  6230				BPF_ALU32_IMM(BPF_MOV, R0, 1),	/* good exit */
  6231				BPF_EXIT_INSN(),
  6232			},
  6233			INTERNAL,
  6234			{ },
  6235			{ { 0, 1 } },
  6236		},
  6237		{
  6238			"JMP_JSGE_K: Signed jump: value walk 2",
  6239			.u.insns_int = {
  6240				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6241				BPF_LD_IMM64(R1, -3),
  6242				BPF_JMP_IMM(BPF_JSGE, R1, 0, 4),
  6243				BPF_ALU64_IMM(BPF_ADD, R1, 2),
  6244				BPF_JMP_IMM(BPF_JSGE, R1, 0, 2),
  6245				BPF_ALU64_IMM(BPF_ADD, R1, 2),
  6246				BPF_JMP_IMM(BPF_JSGE, R1, 0, 1),
  6247				BPF_EXIT_INSN(),		/* bad exit */
  6248				BPF_ALU32_IMM(BPF_MOV, R0, 1),	/* good exit */
  6249				BPF_EXIT_INSN(),
  6250			},
  6251			INTERNAL,
  6252			{ },
  6253			{ { 0, 1 } },
  6254		},
  6255		/* BPF_JMP | BPF_JGT | BPF_K */
  6256		{
  6257			"JMP_JGT_K: if (3 > 2) return 1",
  6258			.u.insns_int = {
  6259				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6260				BPF_LD_IMM64(R1, 3),
  6261				BPF_JMP_IMM(BPF_JGT, R1, 2, 1),
  6262				BPF_EXIT_INSN(),
  6263				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6264				BPF_EXIT_INSN(),
  6265			},
  6266			INTERNAL,
  6267			{ },
  6268			{ { 0, 1 } },
  6269		},
  6270		{
  6271			"JMP_JGT_K: Unsigned jump: if (-1 > 1) return 1",
  6272			.u.insns_int = {
  6273				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6274				BPF_LD_IMM64(R1, -1),
  6275				BPF_JMP_IMM(BPF_JGT, R1, 1, 1),
  6276				BPF_EXIT_INSN(),
  6277				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6278				BPF_EXIT_INSN(),
  6279			},
  6280			INTERNAL,
  6281			{ },
  6282			{ { 0, 1 } },
  6283		},
  6284		/* BPF_JMP | BPF_JLT | BPF_K */
  6285		{
  6286			"JMP_JLT_K: if (2 < 3) return 1",
  6287			.u.insns_int = {
  6288				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6289				BPF_LD_IMM64(R1, 2),
  6290				BPF_JMP_IMM(BPF_JLT, R1, 3, 1),
  6291				BPF_EXIT_INSN(),
  6292				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6293				BPF_EXIT_INSN(),
  6294			},
  6295			INTERNAL,
  6296			{ },
  6297			{ { 0, 1 } },
  6298		},
  6299		{
  6300			"JMP_JGT_K: Unsigned jump: if (1 < -1) return 1",
  6301			.u.insns_int = {
  6302				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6303				BPF_LD_IMM64(R1, 1),
  6304				BPF_JMP_IMM(BPF_JLT, R1, -1, 1),
  6305				BPF_EXIT_INSN(),
  6306				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6307				BPF_EXIT_INSN(),
  6308			},
  6309			INTERNAL,
  6310			{ },
  6311			{ { 0, 1 } },
  6312		},
  6313		/* BPF_JMP | BPF_JGE | BPF_K */
  6314		{
  6315			"JMP_JGE_K: if (3 >= 2) return 1",
  6316			.u.insns_int = {
  6317				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6318				BPF_LD_IMM64(R1, 3),
  6319				BPF_JMP_IMM(BPF_JGE, R1, 2, 1),
  6320				BPF_EXIT_INSN(),
  6321				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6322				BPF_EXIT_INSN(),
  6323			},
  6324			INTERNAL,
  6325			{ },
  6326			{ { 0, 1 } },
  6327		},
  6328		/* BPF_JMP | BPF_JLE | BPF_K */
  6329		{
  6330			"JMP_JLE_K: if (2 <= 3) return 1",
  6331			.u.insns_int = {
  6332				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6333				BPF_LD_IMM64(R1, 2),
  6334				BPF_JMP_IMM(BPF_JLE, R1, 3, 1),
  6335				BPF_EXIT_INSN(),
  6336				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6337				BPF_EXIT_INSN(),
  6338			},
  6339			INTERNAL,
  6340			{ },
  6341			{ { 0, 1 } },
  6342		},
  6343		/* BPF_JMP | BPF_JGT | BPF_K jump backwards */
  6344		{
  6345			"JMP_JGT_K: if (3 > 2) return 1 (jump backwards)",
  6346			.u.insns_int = {
  6347				BPF_JMP_IMM(BPF_JA, 0, 0, 2), /* goto start */
  6348				BPF_ALU32_IMM(BPF_MOV, R0, 1), /* out: */
  6349				BPF_EXIT_INSN(),
  6350				BPF_ALU32_IMM(BPF_MOV, R0, 0), /* start: */
  6351				BPF_LD_IMM64(R1, 3), /* note: this takes 2 insns */
  6352				BPF_JMP_IMM(BPF_JGT, R1, 2, -6), /* goto out */
  6353				BPF_EXIT_INSN(),
  6354			},
  6355			INTERNAL,
  6356			{ },
  6357			{ { 0, 1 } },
  6358		},
  6359		{
  6360			"JMP_JGE_K: if (3 >= 3) return 1",
  6361			.u.insns_int = {
  6362				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6363				BPF_LD_IMM64(R1, 3),
  6364				BPF_JMP_IMM(BPF_JGE, R1, 3, 1),
  6365				BPF_EXIT_INSN(),
  6366				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6367				BPF_EXIT_INSN(),
  6368			},
  6369			INTERNAL,
  6370			{ },
  6371			{ { 0, 1 } },
  6372		},
  6373		/* BPF_JMP | BPF_JLT | BPF_K jump backwards */
  6374		{
  6375			"JMP_JGT_K: if (2 < 3) return 1 (jump backwards)",
  6376			.u.insns_int = {
  6377				BPF_JMP_IMM(BPF_JA, 0, 0, 2), /* goto start */
  6378				BPF_ALU32_IMM(BPF_MOV, R0, 1), /* out: */
  6379				BPF_EXIT_INSN(),
  6380				BPF_ALU32_IMM(BPF_MOV, R0, 0), /* start: */
  6381				BPF_LD_IMM64(R1, 2), /* note: this takes 2 insns */
  6382				BPF_JMP_IMM(BPF_JLT, R1, 3, -6), /* goto out */
  6383				BPF_EXIT_INSN(),
  6384			},
  6385			INTERNAL,
  6386			{ },
  6387			{ { 0, 1 } },
  6388		},
  6389		{
  6390			"JMP_JLE_K: if (3 <= 3) return 1",
  6391			.u.insns_int = {
  6392				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6393				BPF_LD_IMM64(R1, 3),
  6394				BPF_JMP_IMM(BPF_JLE, R1, 3, 1),
  6395				BPF_EXIT_INSN(),
  6396				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6397				BPF_EXIT_INSN(),
  6398			},
  6399			INTERNAL,
  6400			{ },
  6401			{ { 0, 1 } },
  6402		},
  6403		/* BPF_JMP | BPF_JNE | BPF_K */
  6404		{
  6405			"JMP_JNE_K: if (3 != 2) return 1",
  6406			.u.insns_int = {
  6407				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6408				BPF_LD_IMM64(R1, 3),
  6409				BPF_JMP_IMM(BPF_JNE, R1, 2, 1),
  6410				BPF_EXIT_INSN(),
  6411				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6412				BPF_EXIT_INSN(),
  6413			},
  6414			INTERNAL,
  6415			{ },
  6416			{ { 0, 1 } },
  6417		},
  6418		/* BPF_JMP | BPF_JEQ | BPF_K */
  6419		{
  6420			"JMP_JEQ_K: if (3 == 3) return 1",
  6421			.u.insns_int = {
  6422				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6423				BPF_LD_IMM64(R1, 3),
  6424				BPF_JMP_IMM(BPF_JEQ, R1, 3, 1),
  6425				BPF_EXIT_INSN(),
  6426				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6427				BPF_EXIT_INSN(),
  6428			},
  6429			INTERNAL,
  6430			{ },
  6431			{ { 0, 1 } },
  6432		},
  6433		/* BPF_JMP | BPF_JSET | BPF_K */
  6434		{
  6435			"JMP_JSET_K: if (0x3 & 0x2) return 1",
  6436			.u.insns_int = {
  6437				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6438				BPF_LD_IMM64(R1, 3),
  6439				BPF_JMP_IMM(BPF_JSET, R1, 2, 1),
  6440				BPF_EXIT_INSN(),
  6441				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6442				BPF_EXIT_INSN(),
  6443			},
  6444			INTERNAL,
  6445			{ },
  6446			{ { 0, 1 } },
  6447		},
  6448		{
  6449			"JMP_JSET_K: if (0x3 & 0xffffffff) return 1",
  6450			.u.insns_int = {
  6451				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6452				BPF_LD_IMM64(R1, 3),
  6453				BPF_JMP_IMM(BPF_JSET, R1, 0xffffffff, 1),
  6454				BPF_EXIT_INSN(),
  6455				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6456				BPF_EXIT_INSN(),
  6457			},
  6458			INTERNAL,
  6459			{ },
  6460			{ { 0, 1 } },
  6461		},
  6462		/* BPF_JMP | BPF_JSGT | BPF_X */
  6463		{
  6464			"JMP_JSGT_X: Signed jump: if (-1 > -2) return 1",
  6465			.u.insns_int = {
  6466				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6467				BPF_LD_IMM64(R1, -1),
  6468				BPF_LD_IMM64(R2, -2),
  6469				BPF_JMP_REG(BPF_JSGT, R1, R2, 1),
  6470				BPF_EXIT_INSN(),
  6471				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6472				BPF_EXIT_INSN(),
  6473			},
  6474			INTERNAL,
  6475			{ },
  6476			{ { 0, 1 } },
  6477		},
  6478		{
  6479			"JMP_JSGT_X: Signed jump: if (-1 > -1) return 0",
  6480			.u.insns_int = {
  6481				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6482				BPF_LD_IMM64(R1, -1),
  6483				BPF_LD_IMM64(R2, -1),
  6484				BPF_JMP_REG(BPF_JSGT, R1, R2, 1),
  6485				BPF_EXIT_INSN(),
  6486				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6487				BPF_EXIT_INSN(),
  6488			},
  6489			INTERNAL,
  6490			{ },
  6491			{ { 0, 1 } },
  6492		},
  6493		/* BPF_JMP | BPF_JSLT | BPF_X */
  6494		{
  6495			"JMP_JSLT_X: Signed jump: if (-2 < -1) return 1",
  6496			.u.insns_int = {
  6497				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6498				BPF_LD_IMM64(R1, -1),
  6499				BPF_LD_IMM64(R2, -2),
  6500				BPF_JMP_REG(BPF_JSLT, R2, R1, 1),
  6501				BPF_EXIT_INSN(),
  6502				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6503				BPF_EXIT_INSN(),
  6504			},
  6505			INTERNAL,
  6506			{ },
  6507			{ { 0, 1 } },
  6508		},
  6509		{
  6510			"JMP_JSLT_X: Signed jump: if (-1 < -1) return 0",
  6511			.u.insns_int = {
  6512				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6513				BPF_LD_IMM64(R1, -1),
  6514				BPF_LD_IMM64(R2, -1),
  6515				BPF_JMP_REG(BPF_JSLT, R1, R2, 1),
  6516				BPF_EXIT_INSN(),
  6517				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6518				BPF_EXIT_INSN(),
  6519			},
  6520			INTERNAL,
  6521			{ },
  6522			{ { 0, 1 } },
  6523		},
  6524		/* BPF_JMP | BPF_JSGE | BPF_X */
  6525		{
  6526			"JMP_JSGE_X: Signed jump: if (-1 >= -2) return 1",
  6527			.u.insns_int = {
  6528				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6529				BPF_LD_IMM64(R1, -1),
  6530				BPF_LD_IMM64(R2, -2),
  6531				BPF_JMP_REG(BPF_JSGE, R1, R2, 1),
  6532				BPF_EXIT_INSN(),
  6533				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6534				BPF_EXIT_INSN(),
  6535			},
  6536			INTERNAL,
  6537			{ },
  6538			{ { 0, 1 } },
  6539		},
  6540		{
  6541			"JMP_JSGE_X: Signed jump: if (-1 >= -1) return 1",
  6542			.u.insns_int = {
  6543				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6544				BPF_LD_IMM64(R1, -1),
  6545				BPF_LD_IMM64(R2, -1),
  6546				BPF_JMP_REG(BPF_JSGE, R1, R2, 1),
  6547				BPF_EXIT_INSN(),
  6548				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6549				BPF_EXIT_INSN(),
  6550			},
  6551			INTERNAL,
  6552			{ },
  6553			{ { 0, 1 } },
  6554		},
  6555		/* BPF_JMP | BPF_JSLE | BPF_X */
  6556		{
  6557			"JMP_JSLE_X: Signed jump: if (-2 <= -1) return 1",
  6558			.u.insns_int = {
  6559				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6560				BPF_LD_IMM64(R1, -1),
  6561				BPF_LD_IMM64(R2, -2),
  6562				BPF_JMP_REG(BPF_JSLE, R2, R1, 1),
  6563				BPF_EXIT_INSN(),
  6564				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6565				BPF_EXIT_INSN(),
  6566			},
  6567			INTERNAL,
  6568			{ },
  6569			{ { 0, 1 } },
  6570		},
  6571		{
  6572			"JMP_JSLE_X: Signed jump: if (-1 <= -1) return 1",
  6573			.u.insns_int = {
  6574				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6575				BPF_LD_IMM64(R1, -1),
  6576				BPF_LD_IMM64(R2, -1),
  6577				BPF_JMP_REG(BPF_JSLE, R1, R2, 1),
  6578				BPF_EXIT_INSN(),
  6579				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6580				BPF_EXIT_INSN(),
  6581			},
  6582			INTERNAL,
  6583			{ },
  6584			{ { 0, 1 } },
  6585		},
  6586		/* BPF_JMP | BPF_JGT | BPF_X */
  6587		{
  6588			"JMP_JGT_X: if (3 > 2) return 1",
  6589			.u.insns_int = {
  6590				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6591				BPF_LD_IMM64(R1, 3),
  6592				BPF_LD_IMM64(R2, 2),
  6593				BPF_JMP_REG(BPF_JGT, R1, R2, 1),
  6594				BPF_EXIT_INSN(),
  6595				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6596				BPF_EXIT_INSN(),
  6597			},
  6598			INTERNAL,
  6599			{ },
  6600			{ { 0, 1 } },
  6601		},
  6602		{
  6603			"JMP_JGT_X: Unsigned jump: if (-1 > 1) return 1",
  6604			.u.insns_int = {
  6605				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6606				BPF_LD_IMM64(R1, -1),
  6607				BPF_LD_IMM64(R2, 1),
  6608				BPF_JMP_REG(BPF_JGT, R1, R2, 1),
  6609				BPF_EXIT_INSN(),
  6610				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6611				BPF_EXIT_INSN(),
  6612			},
  6613			INTERNAL,
  6614			{ },
  6615			{ { 0, 1 } },
  6616		},
  6617		/* BPF_JMP | BPF_JLT | BPF_X */
  6618		{
  6619			"JMP_JLT_X: if (2 < 3) return 1",
  6620			.u.insns_int = {
  6621				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6622				BPF_LD_IMM64(R1, 3),
  6623				BPF_LD_IMM64(R2, 2),
  6624				BPF_JMP_REG(BPF_JLT, R2, R1, 1),
  6625				BPF_EXIT_INSN(),
  6626				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6627				BPF_EXIT_INSN(),
  6628			},
  6629			INTERNAL,
  6630			{ },
  6631			{ { 0, 1 } },
  6632		},
  6633		{
  6634			"JMP_JLT_X: Unsigned jump: if (1 < -1) return 1",
  6635			.u.insns_int = {
  6636				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6637				BPF_LD_IMM64(R1, -1),
  6638				BPF_LD_IMM64(R2, 1),
  6639				BPF_JMP_REG(BPF_JLT, R2, R1, 1),
  6640				BPF_EXIT_INSN(),
  6641				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6642				BPF_EXIT_INSN(),
  6643			},
  6644			INTERNAL,
  6645			{ },
  6646			{ { 0, 1 } },
  6647		},
  6648		/* BPF_JMP | BPF_JGE | BPF_X */
  6649		{
  6650			"JMP_JGE_X: if (3 >= 2) return 1",
  6651			.u.insns_int = {
  6652				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6653				BPF_LD_IMM64(R1, 3),
  6654				BPF_LD_IMM64(R2, 2),
  6655				BPF_JMP_REG(BPF_JGE, R1, R2, 1),
  6656				BPF_EXIT_INSN(),
  6657				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6658				BPF_EXIT_INSN(),
  6659			},
  6660			INTERNAL,
  6661			{ },
  6662			{ { 0, 1 } },
  6663		},
  6664		{
  6665			"JMP_JGE_X: if (3 >= 3) return 1",
  6666			.u.insns_int = {
  6667				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6668				BPF_LD_IMM64(R1, 3),
  6669				BPF_LD_IMM64(R2, 3),
  6670				BPF_JMP_REG(BPF_JGE, R1, R2, 1),
  6671				BPF_EXIT_INSN(),
  6672				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6673				BPF_EXIT_INSN(),
  6674			},
  6675			INTERNAL,
  6676			{ },
  6677			{ { 0, 1 } },
  6678		},
  6679		/* BPF_JMP | BPF_JLE | BPF_X */
  6680		{
  6681			"JMP_JLE_X: if (2 <= 3) return 1",
  6682			.u.insns_int = {
  6683				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6684				BPF_LD_IMM64(R1, 3),
  6685				BPF_LD_IMM64(R2, 2),
  6686				BPF_JMP_REG(BPF_JLE, R2, R1, 1),
  6687				BPF_EXIT_INSN(),
  6688				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6689				BPF_EXIT_INSN(),
  6690			},
  6691			INTERNAL,
  6692			{ },
  6693			{ { 0, 1 } },
  6694		},
  6695		{
  6696			"JMP_JLE_X: if (3 <= 3) return 1",
  6697			.u.insns_int = {
  6698				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6699				BPF_LD_IMM64(R1, 3),
  6700				BPF_LD_IMM64(R2, 3),
  6701				BPF_JMP_REG(BPF_JLE, R1, R2, 1),
  6702				BPF_EXIT_INSN(),
  6703				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6704				BPF_EXIT_INSN(),
  6705			},
  6706			INTERNAL,
  6707			{ },
  6708			{ { 0, 1 } },
  6709		},
  6710		{
  6711			/* Mainly testing JIT + imm64 here. */
  6712			"JMP_JGE_X: ldimm64 test 1",
  6713			.u.insns_int = {
  6714				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6715				BPF_LD_IMM64(R1, 3),
  6716				BPF_LD_IMM64(R2, 2),
  6717				BPF_JMP_REG(BPF_JGE, R1, R2, 2),
  6718				BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
  6719				BPF_LD_IMM64(R0, 0xeeeeeeeeeeeeeeeeULL),
  6720				BPF_EXIT_INSN(),
  6721			},
  6722			INTERNAL,
  6723			{ },
  6724			{ { 0, 0xeeeeeeeeU } },
  6725		},
  6726		{
  6727			"JMP_JGE_X: ldimm64 test 2",
  6728			.u.insns_int = {
  6729				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6730				BPF_LD_IMM64(R1, 3),
  6731				BPF_LD_IMM64(R2, 2),
  6732				BPF_JMP_REG(BPF_JGE, R1, R2, 0),
  6733				BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
  6734				BPF_EXIT_INSN(),
  6735			},
  6736			INTERNAL,
  6737			{ },
  6738			{ { 0, 0xffffffffU } },
  6739		},
  6740		{
  6741			"JMP_JGE_X: ldimm64 test 3",
  6742			.u.insns_int = {
  6743				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6744				BPF_LD_IMM64(R1, 3),
  6745				BPF_LD_IMM64(R2, 2),
  6746				BPF_JMP_REG(BPF_JGE, R1, R2, 4),
  6747				BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
  6748				BPF_LD_IMM64(R0, 0xeeeeeeeeeeeeeeeeULL),
  6749				BPF_EXIT_INSN(),
  6750			},
  6751			INTERNAL,
  6752			{ },
  6753			{ { 0, 1 } },
  6754		},
  6755		{
  6756			"JMP_JLE_X: ldimm64 test 1",
  6757			.u.insns_int = {
  6758				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6759				BPF_LD_IMM64(R1, 3),
  6760				BPF_LD_IMM64(R2, 2),
  6761				BPF_JMP_REG(BPF_JLE, R2, R1, 2),
  6762				BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
  6763				BPF_LD_IMM64(R0, 0xeeeeeeeeeeeeeeeeULL),
  6764				BPF_EXIT_INSN(),
  6765			},
  6766			INTERNAL,
  6767			{ },
  6768			{ { 0, 0xeeeeeeeeU } },
  6769		},
  6770		{
  6771			"JMP_JLE_X: ldimm64 test 2",
  6772			.u.insns_int = {
  6773				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6774				BPF_LD_IMM64(R1, 3),
  6775				BPF_LD_IMM64(R2, 2),
  6776				BPF_JMP_REG(BPF_JLE, R2, R1, 0),
  6777				BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
  6778				BPF_EXIT_INSN(),
  6779			},
  6780			INTERNAL,
  6781			{ },
  6782			{ { 0, 0xffffffffU } },
  6783		},
  6784		{
  6785			"JMP_JLE_X: ldimm64 test 3",
  6786			.u.insns_int = {
  6787				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6788				BPF_LD_IMM64(R1, 3),
  6789				BPF_LD_IMM64(R2, 2),
  6790				BPF_JMP_REG(BPF_JLE, R2, R1, 4),
  6791				BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
  6792				BPF_LD_IMM64(R0, 0xeeeeeeeeeeeeeeeeULL),
  6793				BPF_EXIT_INSN(),
  6794			},
  6795			INTERNAL,
  6796			{ },
  6797			{ { 0, 1 } },
  6798		},
  6799		/* BPF_JMP | BPF_JNE | BPF_X */
  6800		{
  6801			"JMP_JNE_X: if (3 != 2) return 1",
  6802			.u.insns_int = {
  6803				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6804				BPF_LD_IMM64(R1, 3),
  6805				BPF_LD_IMM64(R2, 2),
  6806				BPF_JMP_REG(BPF_JNE, R1, R2, 1),
  6807				BPF_EXIT_INSN(),
  6808				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6809				BPF_EXIT_INSN(),
  6810			},
  6811			INTERNAL,
  6812			{ },
  6813			{ { 0, 1 } },
  6814		},
  6815		/* BPF_JMP | BPF_JEQ | BPF_X */
  6816		{
  6817			"JMP_JEQ_X: if (3 == 3) return 1",
  6818			.u.insns_int = {
  6819				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6820				BPF_LD_IMM64(R1, 3),
  6821				BPF_LD_IMM64(R2, 3),
  6822				BPF_JMP_REG(BPF_JEQ, R1, R2, 1),
  6823				BPF_EXIT_INSN(),
  6824				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6825				BPF_EXIT_INSN(),
  6826			},
  6827			INTERNAL,
  6828			{ },
  6829			{ { 0, 1 } },
  6830		},
  6831		/* BPF_JMP | BPF_JSET | BPF_X */
  6832		{
  6833			"JMP_JSET_X: if (0x3 & 0x2) return 1",
  6834			.u.insns_int = {
  6835				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6836				BPF_LD_IMM64(R1, 3),
  6837				BPF_LD_IMM64(R2, 2),
  6838				BPF_JMP_REG(BPF_JSET, R1, R2, 1),
  6839				BPF_EXIT_INSN(),
  6840				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6841				BPF_EXIT_INSN(),
  6842			},
  6843			INTERNAL,
  6844			{ },
  6845			{ { 0, 1 } },
  6846		},
  6847		{
  6848			"JMP_JSET_X: if (0x3 & 0xffffffff) return 1",
  6849			.u.insns_int = {
  6850				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  6851				BPF_LD_IMM64(R1, 3),
  6852				BPF_LD_IMM64(R2, 0xffffffff),
  6853				BPF_JMP_REG(BPF_JSET, R1, R2, 1),
  6854				BPF_EXIT_INSN(),
  6855				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6856				BPF_EXIT_INSN(),
  6857			},
  6858			INTERNAL,
  6859			{ },
  6860			{ { 0, 1 } },
  6861		},
  6862		{
  6863			"JMP_JA: Jump, gap, jump, ...",
  6864			{ },
  6865			CLASSIC | FLAG_NO_DATA,
  6866			{ },
  6867			{ { 0, 0xababcbac } },
  6868			.fill_helper = bpf_fill_ja,
  6869		},
  6870		{	/* Mainly checking JIT here. */
  6871			"BPF_MAXINSNS: Maximum possible literals",
  6872			{ },
  6873			CLASSIC | FLAG_NO_DATA,
  6874			{ },
  6875			{ { 0, 0xffffffff } },
  6876			.fill_helper = bpf_fill_maxinsns1,
  6877		},
  6878		{	/* Mainly checking JIT here. */
  6879			"BPF_MAXINSNS: Single literal",
  6880			{ },
  6881			CLASSIC | FLAG_NO_DATA,
  6882			{ },
  6883			{ { 0, 0xfefefefe } },
  6884			.fill_helper = bpf_fill_maxinsns2,
  6885		},
  6886		{	/* Mainly checking JIT here. */
  6887			"BPF_MAXINSNS: Run/add until end",
  6888			{ },
  6889			CLASSIC | FLAG_NO_DATA,
  6890			{ },
  6891			{ { 0, 0x947bf368 } },
  6892			.fill_helper = bpf_fill_maxinsns3,
  6893		},
  6894		{
  6895			"BPF_MAXINSNS: Too many instructions",
  6896			{ },
  6897			CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
  6898			{ },
  6899			{ },
  6900			.fill_helper = bpf_fill_maxinsns4,
  6901			.expected_errcode = -EINVAL,
  6902		},
  6903		{	/* Mainly checking JIT here. */
  6904			"BPF_MAXINSNS: Very long jump",
  6905			{ },
  6906			CLASSIC | FLAG_NO_DATA,
  6907			{ },
  6908			{ { 0, 0xabababab } },
  6909			.fill_helper = bpf_fill_maxinsns5,
  6910		},
  6911		{	/* Mainly checking JIT here. */
  6912			"BPF_MAXINSNS: Ctx heavy transformations",
  6913			{ },
  6914			CLASSIC,
  6915			{ },
  6916			{
  6917				{  1, SKB_VLAN_PRESENT },
  6918				{ 10, SKB_VLAN_PRESENT }
  6919			},
  6920			.fill_helper = bpf_fill_maxinsns6,
  6921		},
  6922		{	/* Mainly checking JIT here. */
  6923			"BPF_MAXINSNS: Call heavy transformations",
  6924			{ },
  6925			CLASSIC | FLAG_NO_DATA,
  6926			{ },
  6927			{ { 1, 0 }, { 10, 0 } },
  6928			.fill_helper = bpf_fill_maxinsns7,
  6929		},
  6930		{	/* Mainly checking JIT here. */
  6931			"BPF_MAXINSNS: Jump heavy test",
  6932			{ },
  6933			CLASSIC | FLAG_NO_DATA,
  6934			{ },
  6935			{ { 0, 0xffffffff } },
  6936			.fill_helper = bpf_fill_maxinsns8,
  6937		},
  6938		{	/* Mainly checking JIT here. */
  6939			"BPF_MAXINSNS: Very long jump backwards",
  6940			{ },
  6941			INTERNAL | FLAG_NO_DATA,
  6942			{ },
  6943			{ { 0, 0xcbababab } },
  6944			.fill_helper = bpf_fill_maxinsns9,
  6945		},
  6946		{	/* Mainly checking JIT here. */
  6947			"BPF_MAXINSNS: Edge hopping nuthouse",
  6948			{ },
  6949			INTERNAL | FLAG_NO_DATA,
  6950			{ },
  6951			{ { 0, 0xabababac } },
  6952			.fill_helper = bpf_fill_maxinsns10,
  6953		},
  6954		{
  6955			"BPF_MAXINSNS: Jump, gap, jump, ...",
  6956			{ },
  6957			CLASSIC | FLAG_NO_DATA,
  6958			{ },
  6959			{ { 0, 0xababcbac } },
  6960			.fill_helper = bpf_fill_maxinsns11,
  6961		},
  6962		{
  6963			"BPF_MAXINSNS: jump over MSH",
  6964			{ },
  6965			CLASSIC | FLAG_EXPECTED_FAIL,
  6966			{ 0xfa, 0xfb, 0xfc, 0xfd, },
  6967			{ { 4, 0xabababab } },
  6968			.fill_helper = bpf_fill_maxinsns12,
  6969			.expected_errcode = -EINVAL,
  6970		},
  6971		{
  6972			"BPF_MAXINSNS: exec all MSH",
  6973			{ },
  6974			CLASSIC,
  6975			{ 0xfa, 0xfb, 0xfc, 0xfd, },
  6976			{ { 4, 0xababab83 } },
  6977			.fill_helper = bpf_fill_maxinsns13,
  6978		},
  6979		{
  6980			"BPF_MAXINSNS: ld_abs+get_processor_id",
  6981			{ },
  6982			CLASSIC,
  6983			{ },
  6984			{ { 1, 0xbee } },
  6985			.fill_helper = bpf_fill_ld_abs_get_processor_id,
  6986		},
  6987		/*
  6988		 * LD_IND / LD_ABS on fragmented SKBs
  6989		 */
  6990		{
  6991			"LD_IND byte frag",
  6992			.u.insns = {
  6993				BPF_STMT(BPF_LDX | BPF_IMM, 0x40),
  6994				BPF_STMT(BPF_LD | BPF_IND | BPF_B, 0x0),
  6995				BPF_STMT(BPF_RET | BPF_A, 0x0),
  6996			},
  6997			CLASSIC | FLAG_SKB_FRAG,
  6998			{ },
  6999			{ {0x40, 0x42} },
  7000			.frag_data = {
  7001				0x42, 0x00, 0x00, 0x00,
  7002				0x43, 0x44, 0x00, 0x00,
  7003				0x21, 0x07, 0x19, 0x83,
  7004			},
  7005		},
  7006		{
  7007			"LD_IND halfword frag",
  7008			.u.insns = {
  7009				BPF_STMT(BPF_LDX | BPF_IMM, 0x40),
  7010				BPF_STMT(BPF_LD | BPF_IND | BPF_H, 0x4),
  7011				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7012			},
  7013			CLASSIC | FLAG_SKB_FRAG,
  7014			{ },
  7015			{ {0x40, 0x4344} },
  7016			.frag_data = {
  7017				0x42, 0x00, 0x00, 0x00,
  7018				0x43, 0x44, 0x00, 0x00,
  7019				0x21, 0x07, 0x19, 0x83,
  7020			},
  7021		},
  7022		{
  7023			"LD_IND word frag",
  7024			.u.insns = {
  7025				BPF_STMT(BPF_LDX | BPF_IMM, 0x40),
  7026				BPF_STMT(BPF_LD | BPF_IND | BPF_W, 0x8),
  7027				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7028			},
  7029			CLASSIC | FLAG_SKB_FRAG,
  7030			{ },
  7031			{ {0x40, 0x21071983} },
  7032			.frag_data = {
  7033				0x42, 0x00, 0x00, 0x00,
  7034				0x43, 0x44, 0x00, 0x00,
  7035				0x21, 0x07, 0x19, 0x83,
  7036			},
  7037		},
  7038		{
  7039			"LD_IND halfword mixed head/frag",
  7040			.u.insns = {
  7041				BPF_STMT(BPF_LDX | BPF_IMM, 0x40),
  7042				BPF_STMT(BPF_LD | BPF_IND | BPF_H, -0x1),
  7043				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7044			},
  7045			CLASSIC | FLAG_SKB_FRAG,
  7046			{ [0x3e] = 0x25, [0x3f] = 0x05, },
  7047			{ {0x40, 0x0519} },
  7048			.frag_data = { 0x19, 0x82 },
  7049		},
  7050		{
  7051			"LD_IND word mixed head/frag",
  7052			.u.insns = {
  7053				BPF_STMT(BPF_LDX | BPF_IMM, 0x40),
  7054				BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x2),
  7055				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7056			},
  7057			CLASSIC | FLAG_SKB_FRAG,
  7058			{ [0x3e] = 0x25, [0x3f] = 0x05, },
  7059			{ {0x40, 0x25051982} },
  7060			.frag_data = { 0x19, 0x82 },
  7061		},
  7062		{
  7063			"LD_ABS byte frag",
  7064			.u.insns = {
  7065				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, 0x40),
  7066				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7067			},
  7068			CLASSIC | FLAG_SKB_FRAG,
  7069			{ },
  7070			{ {0x40, 0x42} },
  7071			.frag_data = {
  7072				0x42, 0x00, 0x00, 0x00,
  7073				0x43, 0x44, 0x00, 0x00,
  7074				0x21, 0x07, 0x19, 0x83,
  7075			},
  7076		},
  7077		{
  7078			"LD_ABS halfword frag",
  7079			.u.insns = {
  7080				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x44),
  7081				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7082			},
  7083			CLASSIC | FLAG_SKB_FRAG,
  7084			{ },
  7085			{ {0x40, 0x4344} },
  7086			.frag_data = {
  7087				0x42, 0x00, 0x00, 0x00,
  7088				0x43, 0x44, 0x00, 0x00,
  7089				0x21, 0x07, 0x19, 0x83,
  7090			},
  7091		},
  7092		{
  7093			"LD_ABS word frag",
  7094			.u.insns = {
  7095				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x48),
  7096				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7097			},
  7098			CLASSIC | FLAG_SKB_FRAG,
  7099			{ },
  7100			{ {0x40, 0x21071983} },
  7101			.frag_data = {
  7102				0x42, 0x00, 0x00, 0x00,
  7103				0x43, 0x44, 0x00, 0x00,
  7104				0x21, 0x07, 0x19, 0x83,
  7105			},
  7106		},
  7107		{
  7108			"LD_ABS halfword mixed head/frag",
  7109			.u.insns = {
  7110				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x3f),
  7111				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7112			},
  7113			CLASSIC | FLAG_SKB_FRAG,
  7114			{ [0x3e] = 0x25, [0x3f] = 0x05, },
  7115			{ {0x40, 0x0519} },
  7116			.frag_data = { 0x19, 0x82 },
  7117		},
  7118		{
  7119			"LD_ABS word mixed head/frag",
  7120			.u.insns = {
  7121				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x3e),
  7122				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7123			},
  7124			CLASSIC | FLAG_SKB_FRAG,
  7125			{ [0x3e] = 0x25, [0x3f] = 0x05, },
  7126			{ {0x40, 0x25051982} },
  7127			.frag_data = { 0x19, 0x82 },
  7128		},
  7129		/*
  7130		 * LD_IND / LD_ABS on non fragmented SKBs
  7131		 */
  7132		{
  7133			/*
  7134			 * this tests that the JIT/interpreter correctly resets X
  7135			 * before using it in an LD_IND instruction.
  7136			 */
  7137			"LD_IND byte default X",
  7138			.u.insns = {
  7139				BPF_STMT(BPF_LD | BPF_IND | BPF_B, 0x1),
  7140				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7141			},
  7142			CLASSIC,
  7143			{ [0x1] = 0x42 },
  7144			{ {0x40, 0x42 } },
  7145		},
  7146		{
  7147			"LD_IND byte positive offset",
  7148			.u.insns = {
  7149				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  7150				BPF_STMT(BPF_LD | BPF_IND | BPF_B, 0x1),
  7151				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7152			},
  7153			CLASSIC,
  7154			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7155			{ {0x40, 0x82 } },
  7156		},
  7157		{
  7158			"LD_IND byte negative offset",
  7159			.u.insns = {
  7160				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  7161				BPF_STMT(BPF_LD | BPF_IND | BPF_B, -0x1),
  7162				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7163			},
  7164			CLASSIC,
  7165			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7166			{ {0x40, 0x05 } },
  7167		},
  7168		{
  7169			"LD_IND byte positive offset, all ff",
  7170			.u.insns = {
  7171				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  7172				BPF_STMT(BPF_LD | BPF_IND | BPF_B, 0x1),
  7173				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7174			},
  7175			CLASSIC,
  7176			{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
  7177			{ {0x40, 0xff } },
  7178		},
  7179		{
  7180			"LD_IND byte positive offset, out of bounds",
  7181			.u.insns = {
  7182				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  7183				BPF_STMT(BPF_LD | BPF_IND | BPF_B, 0x1),
  7184				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7185			},
  7186			CLASSIC,
  7187			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7188			{ {0x3f, 0 }, },
  7189		},
  7190		{
  7191			"LD_IND byte negative offset, out of bounds",
  7192			.u.insns = {
  7193				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  7194				BPF_STMT(BPF_LD | BPF_IND | BPF_B, -0x3f),
  7195				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7196			},
  7197			CLASSIC,
  7198			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7199			{ {0x3f, 0 } },
  7200		},
  7201		{
  7202			"LD_IND byte negative offset, multiple calls",
  7203			.u.insns = {
  7204				BPF_STMT(BPF_LDX | BPF_IMM, 0x3b),
  7205				BPF_STMT(BPF_LD | BPF_IND | BPF_B, SKF_LL_OFF + 1),
  7206				BPF_STMT(BPF_LD | BPF_IND | BPF_B, SKF_LL_OFF + 2),
  7207				BPF_STMT(BPF_LD | BPF_IND | BPF_B, SKF_LL_OFF + 3),
  7208				BPF_STMT(BPF_LD | BPF_IND | BPF_B, SKF_LL_OFF + 4),
  7209				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7210			},
  7211			CLASSIC,
  7212			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7213			{ {0x40, 0x82 }, },
  7214		},
  7215		{
  7216			"LD_IND halfword positive offset",
  7217			.u.insns = {
  7218				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  7219				BPF_STMT(BPF_LD | BPF_IND | BPF_H, 0x2),
  7220				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7221			},
  7222			CLASSIC,
  7223			{
  7224				[0x1c] = 0xaa, [0x1d] = 0x55,
  7225				[0x1e] = 0xbb, [0x1f] = 0x66,
  7226				[0x20] = 0xcc, [0x21] = 0x77,
  7227				[0x22] = 0xdd, [0x23] = 0x88,
  7228			},
  7229			{ {0x40, 0xdd88 } },
  7230		},
  7231		{
  7232			"LD_IND halfword negative offset",
  7233			.u.insns = {
  7234				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  7235				BPF_STMT(BPF_LD | BPF_IND | BPF_H, -0x2),
  7236				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7237			},
  7238			CLASSIC,
  7239			{
  7240				[0x1c] = 0xaa, [0x1d] = 0x55,
  7241				[0x1e] = 0xbb, [0x1f] = 0x66,
  7242				[0x20] = 0xcc, [0x21] = 0x77,
  7243				[0x22] = 0xdd, [0x23] = 0x88,
  7244			},
  7245			{ {0x40, 0xbb66 } },
  7246		},
  7247		{
  7248			"LD_IND halfword unaligned",
  7249			.u.insns = {
  7250				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  7251				BPF_STMT(BPF_LD | BPF_IND | BPF_H, -0x1),
  7252				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7253			},
  7254			CLASSIC,
  7255			{
  7256				[0x1c] = 0xaa, [0x1d] = 0x55,
  7257				[0x1e] = 0xbb, [0x1f] = 0x66,
  7258				[0x20] = 0xcc, [0x21] = 0x77,
  7259				[0x22] = 0xdd, [0x23] = 0x88,
  7260			},
  7261			{ {0x40, 0x66cc } },
  7262		},
  7263		{
  7264			"LD_IND halfword positive offset, all ff",
  7265			.u.insns = {
  7266				BPF_STMT(BPF_LDX | BPF_IMM, 0x3d),
  7267				BPF_STMT(BPF_LD | BPF_IND | BPF_H, 0x1),
  7268				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7269			},
  7270			CLASSIC,
  7271			{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
  7272			{ {0x40, 0xffff } },
  7273		},
  7274		{
  7275			"LD_IND halfword positive offset, out of bounds",
  7276			.u.insns = {
  7277				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  7278				BPF_STMT(BPF_LD | BPF_IND | BPF_H, 0x1),
  7279				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7280			},
  7281			CLASSIC,
  7282			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7283			{ {0x3f, 0 }, },
  7284		},
  7285		{
  7286			"LD_IND halfword negative offset, out of bounds",
  7287			.u.insns = {
  7288				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  7289				BPF_STMT(BPF_LD | BPF_IND | BPF_H, -0x3f),
  7290				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7291			},
  7292			CLASSIC,
  7293			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7294			{ {0x3f, 0 } },
  7295		},
  7296		{
  7297			"LD_IND word positive offset",
  7298			.u.insns = {
  7299				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  7300				BPF_STMT(BPF_LD | BPF_IND | BPF_W, 0x4),
  7301				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7302			},
  7303			CLASSIC,
  7304			{
  7305				[0x1c] = 0xaa, [0x1d] = 0x55,
  7306				[0x1e] = 0xbb, [0x1f] = 0x66,
  7307				[0x20] = 0xcc, [0x21] = 0x77,
  7308				[0x22] = 0xdd, [0x23] = 0x88,
  7309				[0x24] = 0xee, [0x25] = 0x99,
  7310				[0x26] = 0xff, [0x27] = 0xaa,
  7311			},
  7312			{ {0x40, 0xee99ffaa } },
  7313		},
  7314		{
  7315			"LD_IND word negative offset",
  7316			.u.insns = {
  7317				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  7318				BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x4),
  7319				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7320			},
  7321			CLASSIC,
  7322			{
  7323				[0x1c] = 0xaa, [0x1d] = 0x55,
  7324				[0x1e] = 0xbb, [0x1f] = 0x66,
  7325				[0x20] = 0xcc, [0x21] = 0x77,
  7326				[0x22] = 0xdd, [0x23] = 0x88,
  7327				[0x24] = 0xee, [0x25] = 0x99,
  7328				[0x26] = 0xff, [0x27] = 0xaa,
  7329			},
  7330			{ {0x40, 0xaa55bb66 } },
  7331		},
  7332		{
  7333			"LD_IND word unaligned (addr & 3 == 2)",
  7334			.u.insns = {
  7335				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  7336				BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x2),
  7337				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7338			},
  7339			CLASSIC,
  7340			{
  7341				[0x1c] = 0xaa, [0x1d] = 0x55,
  7342				[0x1e] = 0xbb, [0x1f] = 0x66,
  7343				[0x20] = 0xcc, [0x21] = 0x77,
  7344				[0x22] = 0xdd, [0x23] = 0x88,
  7345				[0x24] = 0xee, [0x25] = 0x99,
  7346				[0x26] = 0xff, [0x27] = 0xaa,
  7347			},
  7348			{ {0x40, 0xbb66cc77 } },
  7349		},
  7350		{
  7351			"LD_IND word unaligned (addr & 3 == 1)",
  7352			.u.insns = {
  7353				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  7354				BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x3),
  7355				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7356			},
  7357			CLASSIC,
  7358			{
  7359				[0x1c] = 0xaa, [0x1d] = 0x55,
  7360				[0x1e] = 0xbb, [0x1f] = 0x66,
  7361				[0x20] = 0xcc, [0x21] = 0x77,
  7362				[0x22] = 0xdd, [0x23] = 0x88,
  7363				[0x24] = 0xee, [0x25] = 0x99,
  7364				[0x26] = 0xff, [0x27] = 0xaa,
  7365			},
  7366			{ {0x40, 0x55bb66cc } },
  7367		},
  7368		{
  7369			"LD_IND word unaligned (addr & 3 == 3)",
  7370			.u.insns = {
  7371				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  7372				BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x1),
  7373				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7374			},
  7375			CLASSIC,
  7376			{
  7377				[0x1c] = 0xaa, [0x1d] = 0x55,
  7378				[0x1e] = 0xbb, [0x1f] = 0x66,
  7379				[0x20] = 0xcc, [0x21] = 0x77,
  7380				[0x22] = 0xdd, [0x23] = 0x88,
  7381				[0x24] = 0xee, [0x25] = 0x99,
  7382				[0x26] = 0xff, [0x27] = 0xaa,
  7383			},
  7384			{ {0x40, 0x66cc77dd } },
  7385		},
  7386		{
  7387			"LD_IND word positive offset, all ff",
  7388			.u.insns = {
  7389				BPF_STMT(BPF_LDX | BPF_IMM, 0x3b),
  7390				BPF_STMT(BPF_LD | BPF_IND | BPF_W, 0x1),
  7391				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7392			},
  7393			CLASSIC,
  7394			{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
  7395			{ {0x40, 0xffffffff } },
  7396		},
  7397		{
  7398			"LD_IND word positive offset, out of bounds",
  7399			.u.insns = {
  7400				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  7401				BPF_STMT(BPF_LD | BPF_IND | BPF_W, 0x1),
  7402				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7403			},
  7404			CLASSIC,
  7405			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7406			{ {0x3f, 0 }, },
  7407		},
  7408		{
  7409			"LD_IND word negative offset, out of bounds",
  7410			.u.insns = {
  7411				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  7412				BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x3f),
  7413				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7414			},
  7415			CLASSIC,
  7416			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7417			{ {0x3f, 0 } },
  7418		},
  7419		{
  7420			"LD_ABS byte",
  7421			.u.insns = {
  7422				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, 0x20),
  7423				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7424			},
  7425			CLASSIC,
  7426			{
  7427				[0x1c] = 0xaa, [0x1d] = 0x55,
  7428				[0x1e] = 0xbb, [0x1f] = 0x66,
  7429				[0x20] = 0xcc, [0x21] = 0x77,
  7430				[0x22] = 0xdd, [0x23] = 0x88,
  7431				[0x24] = 0xee, [0x25] = 0x99,
  7432				[0x26] = 0xff, [0x27] = 0xaa,
  7433			},
  7434			{ {0x40, 0xcc } },
  7435		},
  7436		{
  7437			"LD_ABS byte positive offset, all ff",
  7438			.u.insns = {
  7439				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, 0x3f),
  7440				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7441			},
  7442			CLASSIC,
  7443			{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
  7444			{ {0x40, 0xff } },
  7445		},
  7446		{
  7447			"LD_ABS byte positive offset, out of bounds",
  7448			.u.insns = {
  7449				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, 0x3f),
  7450				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7451			},
  7452			CLASSIC,
  7453			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7454			{ {0x3f, 0 }, },
  7455		},
  7456		{
  7457			"LD_ABS byte negative offset, out of bounds load",
  7458			.u.insns = {
  7459				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, -1),
  7460				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7461			},
  7462			CLASSIC | FLAG_EXPECTED_FAIL,
  7463			.expected_errcode = -EINVAL,
  7464		},
  7465		{
  7466			"LD_ABS byte negative offset, in bounds",
  7467			.u.insns = {
  7468				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3f),
  7469				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7470			},
  7471			CLASSIC,
  7472			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7473			{ {0x40, 0x82 }, },
  7474		},
  7475		{
  7476			"LD_ABS byte negative offset, out of bounds",
  7477			.u.insns = {
  7478				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3f),
  7479				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7480			},
  7481			CLASSIC,
  7482			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7483			{ {0x3f, 0 }, },
  7484		},
  7485		{
  7486			"LD_ABS byte negative offset, multiple calls",
  7487			.u.insns = {
  7488				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3c),
  7489				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3d),
  7490				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3e),
  7491				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3f),
  7492				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7493			},
  7494			CLASSIC,
  7495			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7496			{ {0x40, 0x82 }, },
  7497		},
  7498		{
  7499			"LD_ABS halfword",
  7500			.u.insns = {
  7501				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x22),
  7502				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7503			},
  7504			CLASSIC,
  7505			{
  7506				[0x1c] = 0xaa, [0x1d] = 0x55,
  7507				[0x1e] = 0xbb, [0x1f] = 0x66,
  7508				[0x20] = 0xcc, [0x21] = 0x77,
  7509				[0x22] = 0xdd, [0x23] = 0x88,
  7510				[0x24] = 0xee, [0x25] = 0x99,
  7511				[0x26] = 0xff, [0x27] = 0xaa,
  7512			},
  7513			{ {0x40, 0xdd88 } },
  7514		},
  7515		{
  7516			"LD_ABS halfword unaligned",
  7517			.u.insns = {
  7518				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x25),
  7519				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7520			},
  7521			CLASSIC,
  7522			{
  7523				[0x1c] = 0xaa, [0x1d] = 0x55,
  7524				[0x1e] = 0xbb, [0x1f] = 0x66,
  7525				[0x20] = 0xcc, [0x21] = 0x77,
  7526				[0x22] = 0xdd, [0x23] = 0x88,
  7527				[0x24] = 0xee, [0x25] = 0x99,
  7528				[0x26] = 0xff, [0x27] = 0xaa,
  7529			},
  7530			{ {0x40, 0x99ff } },
  7531		},
  7532		{
  7533			"LD_ABS halfword positive offset, all ff",
  7534			.u.insns = {
  7535				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x3e),
  7536				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7537			},
  7538			CLASSIC,
  7539			{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
  7540			{ {0x40, 0xffff } },
  7541		},
  7542		{
  7543			"LD_ABS halfword positive offset, out of bounds",
  7544			.u.insns = {
  7545				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x3f),
  7546				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7547			},
  7548			CLASSIC,
  7549			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7550			{ {0x3f, 0 }, },
  7551		},
  7552		{
  7553			"LD_ABS halfword negative offset, out of bounds load",
  7554			.u.insns = {
  7555				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, -1),
  7556				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7557			},
  7558			CLASSIC | FLAG_EXPECTED_FAIL,
  7559			.expected_errcode = -EINVAL,
  7560		},
  7561		{
  7562			"LD_ABS halfword negative offset, in bounds",
  7563			.u.insns = {
  7564				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, SKF_LL_OFF + 0x3e),
  7565				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7566			},
  7567			CLASSIC,
  7568			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7569			{ {0x40, 0x1982 }, },
  7570		},
  7571		{
  7572			"LD_ABS halfword negative offset, out of bounds",
  7573			.u.insns = {
  7574				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, SKF_LL_OFF + 0x3e),
  7575				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7576			},
  7577			CLASSIC,
  7578			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7579			{ {0x3f, 0 }, },
  7580		},
  7581		{
  7582			"LD_ABS word",
  7583			.u.insns = {
  7584				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x1c),
  7585				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7586			},
  7587			CLASSIC,
  7588			{
  7589				[0x1c] = 0xaa, [0x1d] = 0x55,
  7590				[0x1e] = 0xbb, [0x1f] = 0x66,
  7591				[0x20] = 0xcc, [0x21] = 0x77,
  7592				[0x22] = 0xdd, [0x23] = 0x88,
  7593				[0x24] = 0xee, [0x25] = 0x99,
  7594				[0x26] = 0xff, [0x27] = 0xaa,
  7595			},
  7596			{ {0x40, 0xaa55bb66 } },
  7597		},
  7598		{
  7599			"LD_ABS word unaligned (addr & 3 == 2)",
  7600			.u.insns = {
  7601				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x22),
  7602				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7603			},
  7604			CLASSIC,
  7605			{
  7606				[0x1c] = 0xaa, [0x1d] = 0x55,
  7607				[0x1e] = 0xbb, [0x1f] = 0x66,
  7608				[0x20] = 0xcc, [0x21] = 0x77,
  7609				[0x22] = 0xdd, [0x23] = 0x88,
  7610				[0x24] = 0xee, [0x25] = 0x99,
  7611				[0x26] = 0xff, [0x27] = 0xaa,
  7612			},
  7613			{ {0x40, 0xdd88ee99 } },
  7614		},
  7615		{
  7616			"LD_ABS word unaligned (addr & 3 == 1)",
  7617			.u.insns = {
  7618				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x21),
  7619				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7620			},
  7621			CLASSIC,
  7622			{
  7623				[0x1c] = 0xaa, [0x1d] = 0x55,
  7624				[0x1e] = 0xbb, [0x1f] = 0x66,
  7625				[0x20] = 0xcc, [0x21] = 0x77,
  7626				[0x22] = 0xdd, [0x23] = 0x88,
  7627				[0x24] = 0xee, [0x25] = 0x99,
  7628				[0x26] = 0xff, [0x27] = 0xaa,
  7629			},
  7630			{ {0x40, 0x77dd88ee } },
  7631		},
  7632		{
  7633			"LD_ABS word unaligned (addr & 3 == 3)",
  7634			.u.insns = {
  7635				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x23),
  7636				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7637			},
  7638			CLASSIC,
  7639			{
  7640				[0x1c] = 0xaa, [0x1d] = 0x55,
  7641				[0x1e] = 0xbb, [0x1f] = 0x66,
  7642				[0x20] = 0xcc, [0x21] = 0x77,
  7643				[0x22] = 0xdd, [0x23] = 0x88,
  7644				[0x24] = 0xee, [0x25] = 0x99,
  7645				[0x26] = 0xff, [0x27] = 0xaa,
  7646			},
  7647			{ {0x40, 0x88ee99ff } },
  7648		},
  7649		{
  7650			"LD_ABS word positive offset, all ff",
  7651			.u.insns = {
  7652				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x3c),
  7653				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7654			},
  7655			CLASSIC,
  7656			{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
  7657			{ {0x40, 0xffffffff } },
  7658		},
  7659		{
  7660			"LD_ABS word positive offset, out of bounds",
  7661			.u.insns = {
  7662				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x3f),
  7663				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7664			},
  7665			CLASSIC,
  7666			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7667			{ {0x3f, 0 }, },
  7668		},
  7669		{
  7670			"LD_ABS word negative offset, out of bounds load",
  7671			.u.insns = {
  7672				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, -1),
  7673				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7674			},
  7675			CLASSIC | FLAG_EXPECTED_FAIL,
  7676			.expected_errcode = -EINVAL,
  7677		},
  7678		{
  7679			"LD_ABS word negative offset, in bounds",
  7680			.u.insns = {
  7681				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, SKF_LL_OFF + 0x3c),
  7682				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7683			},
  7684			CLASSIC,
  7685			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7686			{ {0x40, 0x25051982 }, },
  7687		},
  7688		{
  7689			"LD_ABS word negative offset, out of bounds",
  7690			.u.insns = {
  7691				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, SKF_LL_OFF + 0x3c),
  7692				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7693			},
  7694			CLASSIC,
  7695			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7696			{ {0x3f, 0 }, },
  7697		},
  7698		{
  7699			"LDX_MSH standalone, preserved A",
  7700			.u.insns = {
  7701				BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
  7702				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3c),
  7703				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7704			},
  7705			CLASSIC,
  7706			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7707			{ {0x40, 0xffeebbaa }, },
  7708		},
  7709		{
  7710			"LDX_MSH standalone, preserved A 2",
  7711			.u.insns = {
  7712				BPF_STMT(BPF_LD | BPF_IMM, 0x175e9d63),
  7713				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3c),
  7714				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3d),
  7715				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3e),
  7716				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3f),
  7717				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7718			},
  7719			CLASSIC,
  7720			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7721			{ {0x40, 0x175e9d63 }, },
  7722		},
  7723		{
  7724			"LDX_MSH standalone, test result 1",
  7725			.u.insns = {
  7726				BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
  7727				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3c),
  7728				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  7729				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7730			},
  7731			CLASSIC,
  7732			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7733			{ {0x40, 0x14 }, },
  7734		},
  7735		{
  7736			"LDX_MSH standalone, test result 2",
  7737			.u.insns = {
  7738				BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
  7739				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3e),
  7740				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  7741				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7742			},
  7743			CLASSIC,
  7744			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7745			{ {0x40, 0x24 }, },
  7746		},
  7747		{
  7748			"LDX_MSH standalone, negative offset",
  7749			.u.insns = {
  7750				BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
  7751				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, -1),
  7752				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  7753				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7754			},
  7755			CLASSIC,
  7756			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7757			{ {0x40, 0 }, },
  7758		},
  7759		{
  7760			"LDX_MSH standalone, negative offset 2",
  7761			.u.insns = {
  7762				BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
  7763				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, SKF_LL_OFF + 0x3e),
  7764				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  7765				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7766			},
  7767			CLASSIC,
  7768			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7769			{ {0x40, 0x24 }, },
  7770		},
  7771		{
  7772			"LDX_MSH standalone, out of bounds",
  7773			.u.insns = {
  7774				BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
  7775				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x40),
  7776				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  7777				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7778			},
  7779			CLASSIC,
  7780			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  7781			{ {0x40, 0 }, },
  7782		},
  7783		/*
  7784		 * verify that the interpreter or JIT correctly sets A and X
  7785		 * to 0.
  7786		 */
  7787		{
  7788			"ADD default X",
  7789			.u.insns = {
  7790				/*
  7791				 * A = 0x42
  7792				 * A = A + X
  7793				 * ret A
  7794				 */
  7795				BPF_STMT(BPF_LD | BPF_IMM, 0x42),
  7796				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  7797				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7798			},
  7799			CLASSIC | FLAG_NO_DATA,
  7800			{},
  7801			{ {0x1, 0x42 } },
  7802		},
  7803		{
  7804			"ADD default A",
  7805			.u.insns = {
  7806				/*
  7807				 * A = A + 0x42
  7808				 * ret A
  7809				 */
  7810				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 0x42),
  7811				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7812			},
  7813			CLASSIC | FLAG_NO_DATA,
  7814			{},
  7815			{ {0x1, 0x42 } },
  7816		},
  7817		{
  7818			"SUB default X",
  7819			.u.insns = {
  7820				/*
  7821				 * A = 0x66
  7822				 * A = A - X
  7823				 * ret A
  7824				 */
  7825				BPF_STMT(BPF_LD | BPF_IMM, 0x66),
  7826				BPF_STMT(BPF_ALU | BPF_SUB | BPF_X, 0),
  7827				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7828			},
  7829			CLASSIC | FLAG_NO_DATA,
  7830			{},
  7831			{ {0x1, 0x66 } },
  7832		},
  7833		{
  7834			"SUB default A",
  7835			.u.insns = {
  7836				/*
  7837				 * A = A - -0x66
  7838				 * ret A
  7839				 */
  7840				BPF_STMT(BPF_ALU | BPF_SUB | BPF_K, -0x66),
  7841				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7842			},
  7843			CLASSIC | FLAG_NO_DATA,
  7844			{},
  7845			{ {0x1, 0x66 } },
  7846		},
  7847		{
  7848			"MUL default X",
  7849			.u.insns = {
  7850				/*
  7851				 * A = 0x42
  7852				 * A = A * X
  7853				 * ret A
  7854				 */
  7855				BPF_STMT(BPF_LD | BPF_IMM, 0x42),
  7856				BPF_STMT(BPF_ALU | BPF_MUL | BPF_X, 0),
  7857				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7858			},
  7859			CLASSIC | FLAG_NO_DATA,
  7860			{},
  7861			{ {0x1, 0x0 } },
  7862		},
  7863		{
  7864			"MUL default A",
  7865			.u.insns = {
  7866				/*
  7867				 * A = A * 0x66
  7868				 * ret A
  7869				 */
  7870				BPF_STMT(BPF_ALU | BPF_MUL | BPF_K, 0x66),
  7871				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7872			},
  7873			CLASSIC | FLAG_NO_DATA,
  7874			{},
  7875			{ {0x1, 0x0 } },
  7876		},
  7877		{
  7878			"DIV default X",
  7879			.u.insns = {
  7880				/*
  7881				 * A = 0x42
  7882				 * A = A / X ; this halt the filter execution if X is 0
  7883				 * ret 0x42
  7884				 */
  7885				BPF_STMT(BPF_LD | BPF_IMM, 0x42),
  7886				BPF_STMT(BPF_ALU | BPF_DIV | BPF_X, 0),
  7887				BPF_STMT(BPF_RET | BPF_K, 0x42),
  7888			},
  7889			CLASSIC | FLAG_NO_DATA,
  7890			{},
  7891			{ {0x1, 0x0 } },
  7892		},
  7893		{
  7894			"DIV default A",
  7895			.u.insns = {
  7896				/*
  7897				 * A = A / 1
  7898				 * ret A
  7899				 */
  7900				BPF_STMT(BPF_ALU | BPF_DIV | BPF_K, 0x1),
  7901				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7902			},
  7903			CLASSIC | FLAG_NO_DATA,
  7904			{},
  7905			{ {0x1, 0x0 } },
  7906		},
  7907		{
  7908			"MOD default X",
  7909			.u.insns = {
  7910				/*
  7911				 * A = 0x42
  7912				 * A = A mod X ; this halt the filter execution if X is 0
  7913				 * ret 0x42
  7914				 */
  7915				BPF_STMT(BPF_LD | BPF_IMM, 0x42),
  7916				BPF_STMT(BPF_ALU | BPF_MOD | BPF_X, 0),
  7917				BPF_STMT(BPF_RET | BPF_K, 0x42),
  7918			},
  7919			CLASSIC | FLAG_NO_DATA,
  7920			{},
  7921			{ {0x1, 0x0 } },
  7922		},
  7923		{
  7924			"MOD default A",
  7925			.u.insns = {
  7926				/*
  7927				 * A = A mod 1
  7928				 * ret A
  7929				 */
  7930				BPF_STMT(BPF_ALU | BPF_MOD | BPF_K, 0x1),
  7931				BPF_STMT(BPF_RET | BPF_A, 0x0),
  7932			},
  7933			CLASSIC | FLAG_NO_DATA,
  7934			{},
  7935			{ {0x1, 0x0 } },
  7936		},
  7937		{
  7938			"JMP EQ default A",
  7939			.u.insns = {
  7940				/*
  7941				 * cmp A, 0x0, 0, 1
  7942				 * ret 0x42
  7943				 * ret 0x66
  7944				 */
  7945				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x0, 0, 1),
  7946				BPF_STMT(BPF_RET | BPF_K, 0x42),
  7947				BPF_STMT(BPF_RET | BPF_K, 0x66),
  7948			},
  7949			CLASSIC | FLAG_NO_DATA,
  7950			{},
  7951			{ {0x1, 0x42 } },
  7952		},
  7953		{
  7954			"JMP EQ default X",
  7955			.u.insns = {
  7956				/*
  7957				 * A = 0x0
  7958				 * cmp A, X, 0, 1
  7959				 * ret 0x42
  7960				 * ret 0x66
  7961				 */
  7962				BPF_STMT(BPF_LD | BPF_IMM, 0x0),
  7963				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_X, 0x0, 0, 1),
  7964				BPF_STMT(BPF_RET | BPF_K, 0x42),
  7965				BPF_STMT(BPF_RET | BPF_K, 0x66),
  7966			},
  7967			CLASSIC | FLAG_NO_DATA,
  7968			{},
  7969			{ {0x1, 0x42 } },
  7970		},
  7971		/* Checking interpreter vs JIT wrt signed extended imms. */
  7972		{
  7973			"JNE signed compare, test 1",
  7974			.u.insns_int = {
  7975				BPF_ALU32_IMM(BPF_MOV, R1, 0xfefbbc12),
  7976				BPF_ALU32_IMM(BPF_MOV, R3, 0xffff0000),
  7977				BPF_MOV64_REG(R2, R1),
  7978				BPF_ALU64_REG(BPF_AND, R2, R3),
  7979				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  7980				BPF_JMP_IMM(BPF_JNE, R2, -17104896, 1),
  7981				BPF_ALU32_IMM(BPF_MOV, R0, 2),
  7982				BPF_EXIT_INSN(),
  7983			},
  7984			INTERNAL,
  7985			{ },
  7986			{ { 0, 1 } },
  7987		},
  7988		{
  7989			"JNE signed compare, test 2",
  7990			.u.insns_int = {
  7991				BPF_ALU32_IMM(BPF_MOV, R1, 0xfefbbc12),
  7992				BPF_ALU32_IMM(BPF_MOV, R3, 0xffff0000),
  7993				BPF_MOV64_REG(R2, R1),
  7994				BPF_ALU64_REG(BPF_AND, R2, R3),
  7995				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  7996				BPF_JMP_IMM(BPF_JNE, R2, 0xfefb0000, 1),
  7997				BPF_ALU32_IMM(BPF_MOV, R0, 2),
  7998				BPF_EXIT_INSN(),
  7999			},
  8000			INTERNAL,
  8001			{ },
  8002			{ { 0, 1 } },
  8003		},
  8004		{
  8005			"JNE signed compare, test 3",
  8006			.u.insns_int = {
  8007				BPF_ALU32_IMM(BPF_MOV, R1, 0xfefbbc12),
  8008				BPF_ALU32_IMM(BPF_MOV, R3, 0xffff0000),
  8009				BPF_ALU32_IMM(BPF_MOV, R4, 0xfefb0000),
  8010				BPF_MOV64_REG(R2, R1),
  8011				BPF_ALU64_REG(BPF_AND, R2, R3),
  8012				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8013				BPF_JMP_REG(BPF_JNE, R2, R4, 1),
  8014				BPF_ALU32_IMM(BPF_MOV, R0, 2),
  8015				BPF_EXIT_INSN(),
  8016			},
  8017			INTERNAL,
  8018			{ },
  8019			{ { 0, 2 } },
  8020		},
  8021		{
  8022			"JNE signed compare, test 4",
  8023			.u.insns_int = {
  8024				BPF_LD_IMM64(R1, -17104896),
  8025				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8026				BPF_JMP_IMM(BPF_JNE, R1, -17104896, 1),
  8027				BPF_ALU32_IMM(BPF_MOV, R0, 2),
  8028				BPF_EXIT_INSN(),
  8029			},
  8030			INTERNAL,
  8031			{ },
  8032			{ { 0, 2 } },
  8033		},
  8034		{
  8035			"JNE signed compare, test 5",
  8036			.u.insns_int = {
  8037				BPF_LD_IMM64(R1, 0xfefb0000),
  8038				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8039				BPF_JMP_IMM(BPF_JNE, R1, 0xfefb0000, 1),
  8040				BPF_ALU32_IMM(BPF_MOV, R0, 2),
  8041				BPF_EXIT_INSN(),
  8042			},
  8043			INTERNAL,
  8044			{ },
  8045			{ { 0, 1 } },
  8046		},
  8047		{
  8048			"JNE signed compare, test 6",
  8049			.u.insns_int = {
  8050				BPF_LD_IMM64(R1, 0x7efb0000),
  8051				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8052				BPF_JMP_IMM(BPF_JNE, R1, 0x7efb0000, 1),
  8053				BPF_ALU32_IMM(BPF_MOV, R0, 2),
  8054				BPF_EXIT_INSN(),
  8055			},
  8056			INTERNAL,
  8057			{ },
  8058			{ { 0, 2 } },
  8059		},
  8060		{
  8061			"JNE signed compare, test 7",
  8062			.u.insns = {
  8063				BPF_STMT(BPF_LD | BPF_IMM, 0xffff0000),
  8064				BPF_STMT(BPF_MISC | BPF_TAX, 0),
  8065				BPF_STMT(BPF_LD | BPF_IMM, 0xfefbbc12),
  8066				BPF_STMT(BPF_ALU | BPF_AND | BPF_X, 0),
  8067				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0xfefb0000, 1, 0),
  8068				BPF_STMT(BPF_RET | BPF_K, 1),
  8069				BPF_STMT(BPF_RET | BPF_K, 2),
  8070			},
  8071			CLASSIC | FLAG_NO_DATA,
  8072			{},
  8073			{ { 0, 2 } },
  8074		},
  8075	};
  8076	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
