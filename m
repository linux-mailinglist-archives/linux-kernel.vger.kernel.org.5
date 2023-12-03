Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEC8802154
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 07:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjLCGfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 01:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjLCGeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 01:34:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6316F1B2
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 22:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701585255; x=1733121255;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hR6fz2xOKrykPmQwDdoTGtRMrhg03zWY8Keympo/vR0=;
  b=CiYu/i0Bw64EMCLp5tqss3dIYfXNsP1kxmxg3wkJXCUKGf8+0bHWqNmV
   SZttF9zpjYuEbQ/nWgxsQTzB6YsTaQfFM/YEPeWB5JX4+tu29GzCgyRrg
   qs0JJLJLb5baA3MWNxhC340VbFvxNELxaJnDIJ2kQaTPD4pGPls1oEDm9
   U+TLE4ln/VzHU4nTCkxGMuaCi7YfHGap+jD6++NUVbR9RjTQ3t0Ry0ko2
   z9yFxNfCLDYHljubOaFC16qcBwEgkghbcpNert4AW3oTuE9ADPaeeAfKQ
   G5hX73DYko+JEquTrAX4GmUQPFZF+sJXVd/hYumkV05WaJ/+OetufooDb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="6906542"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="6906542"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 22:32:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="770191154"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="770191154"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 02 Dec 2023 22:32:46 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9g20-0006LC-0s;
        Sun, 03 Dec 2023 06:32:44 +0000
Date:   Sun, 3 Dec 2023 14:32:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johan Almbladh <johan.almbladh@anyfinetworks.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: lib/test_bpf.c:6896:30: sparse: sparse: cast truncates bits from
 constant value (1032547698badcfe becomes 98badcfe)
Message-ID: <202312031333.ESYgytOb-lkp@intel.com>
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
head:   968f35f4ab1c0966ceb39af3c89f2e24afedf878
commit: f536a7c80675e4875e50df9182881d7678e27651 bpf/tests: Add more BPF_END byte order conversion tests
date:   2 years, 2 months ago
config: mips-randconfig-r123-20231130 (https://download.01.org/0day-ci/archive/20231203/202312031333.ESYgytOb-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20231203/202312031333.ESYgytOb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312031333.ESYgytOb-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   lib/test_bpf.c:3958:25: sparse: sparse: cast truncates bits from constant value (1ffffffff becomes ffffffff)
   lib/test_bpf.c:4035:25: sparse: sparse: cast truncates bits from constant value (ffffffff0000 becomes ffff0000)
   lib/test_bpf.c:4113:25: sparse: sparse: cast truncates bits from constant value (ffffffff0000 becomes ffff0000)
   lib/test_bpf.c:4129:25: sparse: sparse: cast truncates bits from constant value (ffffffff0000 becomes ffff0000)
   lib/test_bpf.c:4254:25: sparse: sparse: cast truncates bits from constant value (100000000 becomes 0)
   lib/test_bpf.c:4432:25: sparse: sparse: cast truncates bits from constant value (100000000 becomes 0)
   lib/test_bpf.c:4742:25: sparse: sparse: cast truncates bits from constant value (fedcba987654321 becomes 87654321)
   lib/test_bpf.c:4743:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef0 becomes 9abcdef0)
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
>> lib/test_bpf.c:6896:30: sparse: sparse: cast truncates bits from constant value (1032547698badcfe becomes 98badcfe)
   lib/test_bpf.c:6901:25: sparse: sparse: cast truncates bits from constant value (fedcba9876543210 becomes 76543210)
   lib/test_bpf.c:7047:25: sparse: sparse: cast truncates bits from constant value (ffff00000000ffff becomes ffff)
   lib/test_bpf.c:7093:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7111:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7387:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7388:25: sparse: sparse: cast truncates bits from constant value (fecdba9876543210 becomes 76543210)
   lib/test_bpf.c:7404:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7405:25: sparse: sparse: cast truncates bits from constant value (fecdba9876543210 becomes 76543210)
   lib/test_bpf.c:7422:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7423:25: sparse: sparse: cast truncates bits from constant value (fecdba9876543210 becomes 76543210)
   lib/test_bpf.c:7440:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7441:25: sparse: sparse: cast truncates bits from constant value (fecdba9876543210 becomes 76543210)
   lib/test_bpf.c:7459:25: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   lib/test_bpf.c:7460:25: sparse: sparse: cast truncates bits from constant value (fecdba9876543210 becomes 76543210)
   lib/test_bpf.c:7464:25: sparse: sparse: cast truncates bits from constant value (fecdba9876543210 becomes 76543210)
   lib/test_bpf.c:8667:25: sparse: sparse: cast truncates bits from constant value (eeeeeeeeeeeeeeee becomes eeeeeeee)
   lib/test_bpf.c:8696:25: sparse: sparse: cast truncates bits from constant value (eeeeeeeeeeeeeeee becomes eeeeeeee)
   lib/test_bpf.c:8711:25: sparse: sparse: cast truncates bits from constant value (eeeeeeeeeeeeeeee becomes eeeeeeee)
   lib/test_bpf.c:8740:25: sparse: sparse: cast truncates bits from constant value (eeeeeeeeeeeeeeee becomes eeeeeeee)

vim +6896 lib/test_bpf.c

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
> 6896			{ { 0, (u32) cpu_to_le64(0xfedcba9876543210ULL) } },
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
  6910		/* BPF_ST(X) | BPF_MEM | BPF_B/H/W/DW */
  6911		{
  6912			"ST_MEM_B: Store/Load byte: max negative",
  6913			.u.insns_int = {
  6914				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6915				BPF_ST_MEM(BPF_B, R10, -40, 0xff),
  6916				BPF_LDX_MEM(BPF_B, R0, R10, -40),
  6917				BPF_EXIT_INSN(),
  6918			},
  6919			INTERNAL,
  6920			{ },
  6921			{ { 0, 0xff } },
  6922			.stack_depth = 40,
  6923		},
  6924		{
  6925			"ST_MEM_B: Store/Load byte: max positive",
  6926			.u.insns_int = {
  6927				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6928				BPF_ST_MEM(BPF_H, R10, -40, 0x7f),
  6929				BPF_LDX_MEM(BPF_H, R0, R10, -40),
  6930				BPF_EXIT_INSN(),
  6931			},
  6932			INTERNAL,
  6933			{ },
  6934			{ { 0, 0x7f } },
  6935			.stack_depth = 40,
  6936		},
  6937		{
  6938			"STX_MEM_B: Store/Load byte: max negative",
  6939			.u.insns_int = {
  6940				BPF_LD_IMM64(R0, 0),
  6941				BPF_LD_IMM64(R1, 0xffLL),
  6942				BPF_STX_MEM(BPF_B, R10, R1, -40),
  6943				BPF_LDX_MEM(BPF_B, R0, R10, -40),
  6944				BPF_EXIT_INSN(),
  6945			},
  6946			INTERNAL,
  6947			{ },
  6948			{ { 0, 0xff } },
  6949			.stack_depth = 40,
  6950		},
  6951		{
  6952			"ST_MEM_H: Store/Load half word: max negative",
  6953			.u.insns_int = {
  6954				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6955				BPF_ST_MEM(BPF_H, R10, -40, 0xffff),
  6956				BPF_LDX_MEM(BPF_H, R0, R10, -40),
  6957				BPF_EXIT_INSN(),
  6958			},
  6959			INTERNAL,
  6960			{ },
  6961			{ { 0, 0xffff } },
  6962			.stack_depth = 40,
  6963		},
  6964		{
  6965			"ST_MEM_H: Store/Load half word: max positive",
  6966			.u.insns_int = {
  6967				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6968				BPF_ST_MEM(BPF_H, R10, -40, 0x7fff),
  6969				BPF_LDX_MEM(BPF_H, R0, R10, -40),
  6970				BPF_EXIT_INSN(),
  6971			},
  6972			INTERNAL,
  6973			{ },
  6974			{ { 0, 0x7fff } },
  6975			.stack_depth = 40,
  6976		},
  6977		{
  6978			"STX_MEM_H: Store/Load half word: max negative",
  6979			.u.insns_int = {
  6980				BPF_LD_IMM64(R0, 0),
  6981				BPF_LD_IMM64(R1, 0xffffLL),
  6982				BPF_STX_MEM(BPF_H, R10, R1, -40),
  6983				BPF_LDX_MEM(BPF_H, R0, R10, -40),
  6984				BPF_EXIT_INSN(),
  6985			},
  6986			INTERNAL,
  6987			{ },
  6988			{ { 0, 0xffff } },
  6989			.stack_depth = 40,
  6990		},
  6991		{
  6992			"ST_MEM_W: Store/Load word: max negative",
  6993			.u.insns_int = {
  6994				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  6995				BPF_ST_MEM(BPF_W, R10, -40, 0xffffffff),
  6996				BPF_LDX_MEM(BPF_W, R0, R10, -40),
  6997				BPF_EXIT_INSN(),
  6998			},
  6999			INTERNAL,
  7000			{ },
  7001			{ { 0, 0xffffffff } },
  7002			.stack_depth = 40,
  7003		},
  7004		{
  7005			"ST_MEM_W: Store/Load word: max positive",
  7006			.u.insns_int = {
  7007				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  7008				BPF_ST_MEM(BPF_W, R10, -40, 0x7fffffff),
  7009				BPF_LDX_MEM(BPF_W, R0, R10, -40),
  7010				BPF_EXIT_INSN(),
  7011			},
  7012			INTERNAL,
  7013			{ },
  7014			{ { 0, 0x7fffffff } },
  7015			.stack_depth = 40,
  7016		},
  7017		{
  7018			"STX_MEM_W: Store/Load word: max negative",
  7019			.u.insns_int = {
  7020				BPF_LD_IMM64(R0, 0),
  7021				BPF_LD_IMM64(R1, 0xffffffffLL),
  7022				BPF_STX_MEM(BPF_W, R10, R1, -40),
  7023				BPF_LDX_MEM(BPF_W, R0, R10, -40),
  7024				BPF_EXIT_INSN(),
  7025			},
  7026			INTERNAL,
  7027			{ },
  7028			{ { 0, 0xffffffff } },
  7029			.stack_depth = 40,
  7030		},
  7031		{
  7032			"ST_MEM_DW: Store/Load double word: max negative",
  7033			.u.insns_int = {
  7034				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  7035				BPF_ST_MEM(BPF_DW, R10, -40, 0xffffffff),
  7036				BPF_LDX_MEM(BPF_DW, R0, R10, -40),
  7037				BPF_EXIT_INSN(),
  7038			},
  7039			INTERNAL,
  7040			{ },
  7041			{ { 0, 0xffffffff } },
  7042			.stack_depth = 40,
  7043		},
  7044		{
  7045			"ST_MEM_DW: Store/Load double word: max negative 2",
  7046			.u.insns_int = {
  7047				BPF_LD_IMM64(R2, 0xffff00000000ffffLL),
  7048				BPF_LD_IMM64(R3, 0xffffffffffffffffLL),
  7049				BPF_ST_MEM(BPF_DW, R10, -40, 0xffffffff),
  7050				BPF_LDX_MEM(BPF_DW, R2, R10, -40),
  7051				BPF_JMP_REG(BPF_JEQ, R2, R3, 2),
  7052				BPF_MOV32_IMM(R0, 2),
  7053				BPF_EXIT_INSN(),
  7054				BPF_MOV32_IMM(R0, 1),
  7055				BPF_EXIT_INSN(),
  7056			},
  7057			INTERNAL,
  7058			{ },
  7059			{ { 0, 0x1 } },
  7060			.stack_depth = 40,
  7061		},
  7062		{
  7063			"ST_MEM_DW: Store/Load double word: max positive",
  7064			.u.insns_int = {
  7065				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  7066				BPF_ST_MEM(BPF_DW, R10, -40, 0x7fffffff),
  7067				BPF_LDX_MEM(BPF_DW, R0, R10, -40),
  7068				BPF_EXIT_INSN(),
  7069			},
  7070			INTERNAL,
  7071			{ },
  7072			{ { 0, 0x7fffffff } },
  7073			.stack_depth = 40,
  7074		},
  7075		{
  7076			"STX_MEM_DW: Store/Load double word: max negative",
  7077			.u.insns_int = {
  7078				BPF_LD_IMM64(R0, 0),
  7079				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  7080				BPF_STX_MEM(BPF_DW, R10, R1, -40),
  7081				BPF_LDX_MEM(BPF_DW, R0, R10, -40),
  7082				BPF_EXIT_INSN(),
  7083			},
  7084			INTERNAL,
  7085			{ },
  7086			{ { 0, 0xffffffff } },
  7087			.stack_depth = 40,
  7088		},
  7089		{
  7090			"STX_MEM_DW: Store double word: first word in memory",
  7091			.u.insns_int = {
  7092				BPF_LD_IMM64(R0, 0),
  7093				BPF_LD_IMM64(R1, 0x0123456789abcdefLL),
  7094				BPF_STX_MEM(BPF_DW, R10, R1, -40),
  7095				BPF_LDX_MEM(BPF_W, R0, R10, -40),
  7096				BPF_EXIT_INSN(),
  7097			},
  7098			INTERNAL,
  7099			{ },
  7100	#ifdef __BIG_ENDIAN
  7101			{ { 0, 0x01234567 } },
  7102	#else
  7103			{ { 0, 0x89abcdef } },
  7104	#endif
  7105			.stack_depth = 40,
  7106		},
  7107		{
  7108			"STX_MEM_DW: Store double word: second word in memory",
  7109			.u.insns_int = {
  7110				BPF_LD_IMM64(R0, 0),
  7111				BPF_LD_IMM64(R1, 0x0123456789abcdefLL),
  7112				BPF_STX_MEM(BPF_DW, R10, R1, -40),
  7113				BPF_LDX_MEM(BPF_W, R0, R10, -36),
  7114				BPF_EXIT_INSN(),
  7115			},
  7116			INTERNAL,
  7117			{ },
  7118	#ifdef __BIG_ENDIAN
  7119			{ { 0, 0x89abcdef } },
  7120	#else
  7121			{ { 0, 0x01234567 } },
  7122	#endif
  7123			.stack_depth = 40,
  7124		},
  7125		/* BPF_STX | BPF_ATOMIC | BPF_W/DW */
  7126		{
  7127			"STX_XADD_W: X + 1 + 1 + 1 + ...",
  7128			{ },
  7129			INTERNAL,
  7130			{ },
  7131			{ { 0, 4134 } },
  7132			.fill_helper = bpf_fill_stxw,
  7133		},
  7134		{
  7135			"STX_XADD_DW: X + 1 + 1 + 1 + ...",
  7136			{ },
  7137			INTERNAL,
  7138			{ },
  7139			{ { 0, 4134 } },
  7140			.fill_helper = bpf_fill_stxdw,
  7141		},
  7142		/*
  7143		 * Exhaustive tests of atomic operation variants.
  7144		 * Individual tests are expanded from template macros for all
  7145		 * combinations of ALU operation, word size and fetching.
  7146		 */
  7147	#define BPF_ATOMIC_OP_TEST1(width, op, logic, old, update, result)	\
  7148	{									\
  7149		"BPF_ATOMIC | " #width ", " #op ": Test: "			\
  7150			#old " " #logic " " #update " = " #result,		\
  7151		.u.insns_int = {						\
  7152			BPF_ALU32_IMM(BPF_MOV, R5, update),			\
  7153			BPF_ST_MEM(width, R10, -40, old),			\
  7154			BPF_ATOMIC_OP(width, op, R10, R5, -40),			\
  7155			BPF_LDX_MEM(width, R0, R10, -40),			\
  7156			BPF_EXIT_INSN(),					\
  7157		},								\
  7158		INTERNAL,							\
  7159		{ },								\
  7160		{ { 0, result } },						\
  7161		.stack_depth = 40,						\
  7162	}
  7163	#define BPF_ATOMIC_OP_TEST2(width, op, logic, old, update, result)	\
  7164	{									\
  7165		"BPF_ATOMIC | " #width ", " #op ": Test side effects, r10: "	\
  7166			#old " " #logic " " #update " = " #result,		\
  7167		.u.insns_int = {						\
  7168			BPF_ALU64_REG(BPF_MOV, R1, R10),			\
  7169			BPF_ALU32_IMM(BPF_MOV, R0, update),			\
  7170			BPF_ST_MEM(BPF_W, R10, -40, old),			\
  7171			BPF_ATOMIC_OP(width, op, R10, R0, -40),			\
  7172			BPF_ALU64_REG(BPF_MOV, R0, R10),			\
  7173			BPF_ALU64_REG(BPF_SUB, R0, R1),				\
  7174			BPF_EXIT_INSN(),					\
  7175		},								\
  7176		INTERNAL,							\
  7177		{ },								\
  7178		{ { 0, 0 } },							\
  7179		.stack_depth = 40,						\
  7180	}
  7181	#define BPF_ATOMIC_OP_TEST3(width, op, logic, old, update, result)	\
  7182	{									\
  7183		"BPF_ATOMIC | " #width ", " #op ": Test side effects, r0: "	\
  7184			#old " " #logic " " #update " = " #result,		\
  7185		.u.insns_int = {						\
  7186			BPF_ALU64_REG(BPF_MOV, R0, R10),			\
  7187			BPF_ALU32_IMM(BPF_MOV, R1, update),			\
  7188			BPF_ST_MEM(width, R10, -40, old),			\
  7189			BPF_ATOMIC_OP(width, op, R10, R1, -40),			\
  7190			BPF_ALU64_REG(BPF_SUB, R0, R10),			\
  7191			BPF_EXIT_INSN(),					\
  7192		},								\
  7193		INTERNAL,                                                       \
  7194		{ },                                                            \
  7195		{ { 0, 0 } },                                                   \
  7196		.stack_depth = 40,                                              \
  7197	}
  7198	#define BPF_ATOMIC_OP_TEST4(width, op, logic, old, update, result)	\
  7199	{									\
  7200		"BPF_ATOMIC | " #width ", " #op ": Test fetch: "		\
  7201			#old " " #logic " " #update " = " #result,		\
  7202		.u.insns_int = {						\
  7203			BPF_ALU32_IMM(BPF_MOV, R3, update),			\
  7204			BPF_ST_MEM(width, R10, -40, old),			\
  7205			BPF_ATOMIC_OP(width, op, R10, R3, -40),			\
  7206			BPF_ALU64_REG(BPF_MOV, R0, R3),                         \
  7207			BPF_EXIT_INSN(),					\
  7208		},								\
  7209		INTERNAL,                                                       \
  7210		{ },                                                            \
  7211		{ { 0, (op) & BPF_FETCH ? old : update } },			\
  7212		.stack_depth = 40,                                              \
  7213	}
  7214		/* BPF_ATOMIC | BPF_W: BPF_ADD */
  7215		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_ADD, +, 0x12, 0xab, 0xbd),
  7216		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_ADD, +, 0x12, 0xab, 0xbd),
  7217		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_ADD, +, 0x12, 0xab, 0xbd),
  7218		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_ADD, +, 0x12, 0xab, 0xbd),
  7219		/* BPF_ATOMIC | BPF_W: BPF_ADD | BPF_FETCH */
  7220		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
  7221		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
  7222		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
  7223		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
  7224		/* BPF_ATOMIC | BPF_DW: BPF_ADD */
  7225		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_ADD, +, 0x12, 0xab, 0xbd),
  7226		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_ADD, +, 0x12, 0xab, 0xbd),
  7227		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_ADD, +, 0x12, 0xab, 0xbd),
  7228		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_ADD, +, 0x12, 0xab, 0xbd),
  7229		/* BPF_ATOMIC | BPF_DW: BPF_ADD | BPF_FETCH */
  7230		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
  7231		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
  7232		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
  7233		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_ADD | BPF_FETCH, +, 0x12, 0xab, 0xbd),
  7234		/* BPF_ATOMIC | BPF_W: BPF_AND */
  7235		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_AND, &, 0x12, 0xab, 0x02),
  7236		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_AND, &, 0x12, 0xab, 0x02),
  7237		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_AND, &, 0x12, 0xab, 0x02),
  7238		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_AND, &, 0x12, 0xab, 0x02),
  7239		/* BPF_ATOMIC | BPF_W: BPF_AND | BPF_FETCH */
  7240		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
  7241		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
  7242		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
  7243		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
  7244		/* BPF_ATOMIC | BPF_DW: BPF_AND */
  7245		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_AND, &, 0x12, 0xab, 0x02),
  7246		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_AND, &, 0x12, 0xab, 0x02),
  7247		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_AND, &, 0x12, 0xab, 0x02),
  7248		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_AND, &, 0x12, 0xab, 0x02),
  7249		/* BPF_ATOMIC | BPF_DW: BPF_AND | BPF_FETCH */
  7250		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
  7251		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
  7252		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
  7253		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_AND | BPF_FETCH, &, 0x12, 0xab, 0x02),
  7254		/* BPF_ATOMIC | BPF_W: BPF_OR */
  7255		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_OR, |, 0x12, 0xab, 0xbb),
  7256		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_OR, |, 0x12, 0xab, 0xbb),
  7257		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_OR, |, 0x12, 0xab, 0xbb),
  7258		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_OR, |, 0x12, 0xab, 0xbb),
  7259		/* BPF_ATOMIC | BPF_W: BPF_OR | BPF_FETCH */
  7260		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
  7261		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
  7262		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
  7263		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
  7264		/* BPF_ATOMIC | BPF_DW: BPF_OR */
  7265		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_OR, |, 0x12, 0xab, 0xbb),
  7266		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_OR, |, 0x12, 0xab, 0xbb),
  7267		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_OR, |, 0x12, 0xab, 0xbb),
  7268		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_OR, |, 0x12, 0xab, 0xbb),
  7269		/* BPF_ATOMIC | BPF_DW: BPF_OR | BPF_FETCH */
  7270		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
  7271		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
  7272		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
  7273		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_OR | BPF_FETCH, |, 0x12, 0xab, 0xbb),
  7274		/* BPF_ATOMIC | BPF_W: BPF_XOR */
  7275		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_XOR, ^, 0x12, 0xab, 0xb9),
  7276		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_XOR, ^, 0x12, 0xab, 0xb9),
  7277		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_XOR, ^, 0x12, 0xab, 0xb9),
  7278		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_XOR, ^, 0x12, 0xab, 0xb9),
  7279		/* BPF_ATOMIC | BPF_W: BPF_XOR | BPF_FETCH */
  7280		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
  7281		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
  7282		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
  7283		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
  7284		/* BPF_ATOMIC | BPF_DW: BPF_XOR */
  7285		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_XOR, ^, 0x12, 0xab, 0xb9),
  7286		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_XOR, ^, 0x12, 0xab, 0xb9),
  7287		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_XOR, ^, 0x12, 0xab, 0xb9),
  7288		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_XOR, ^, 0x12, 0xab, 0xb9),
  7289		/* BPF_ATOMIC | BPF_DW: BPF_XOR | BPF_FETCH */
  7290		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
  7291		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
  7292		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
  7293		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_XOR | BPF_FETCH, ^, 0x12, 0xab, 0xb9),
  7294		/* BPF_ATOMIC | BPF_W: BPF_XCHG */
  7295		BPF_ATOMIC_OP_TEST1(BPF_W, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
  7296		BPF_ATOMIC_OP_TEST2(BPF_W, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
  7297		BPF_ATOMIC_OP_TEST3(BPF_W, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
  7298		BPF_ATOMIC_OP_TEST4(BPF_W, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
  7299		/* BPF_ATOMIC | BPF_DW: BPF_XCHG */
  7300		BPF_ATOMIC_OP_TEST1(BPF_DW, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
  7301		BPF_ATOMIC_OP_TEST2(BPF_DW, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
  7302		BPF_ATOMIC_OP_TEST3(BPF_DW, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
  7303		BPF_ATOMIC_OP_TEST4(BPF_DW, BPF_XCHG, xchg, 0x12, 0xab, 0xab),
  7304	#undef BPF_ATOMIC_OP_TEST1
  7305	#undef BPF_ATOMIC_OP_TEST2
  7306	#undef BPF_ATOMIC_OP_TEST3
  7307	#undef BPF_ATOMIC_OP_TEST4
  7308		/* BPF_ATOMIC | BPF_W, BPF_CMPXCHG */
  7309		{
  7310			"BPF_ATOMIC | BPF_W, BPF_CMPXCHG: Test successful return",
  7311			.u.insns_int = {
  7312				BPF_ST_MEM(BPF_W, R10, -40, 0x01234567),
  7313				BPF_ALU32_IMM(BPF_MOV, R0, 0x01234567),
  7314				BPF_ALU32_IMM(BPF_MOV, R3, 0x89abcdef),
  7315				BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R3, -40),
  7316				BPF_EXIT_INSN(),
  7317			},
  7318			INTERNAL,
  7319			{ },
  7320			{ { 0, 0x01234567 } },
  7321			.stack_depth = 40,
  7322		},
  7323		{
  7324			"BPF_ATOMIC | BPF_W, BPF_CMPXCHG: Test successful store",
  7325			.u.insns_int = {
  7326				BPF_ST_MEM(BPF_W, R10, -40, 0x01234567),
  7327				BPF_ALU32_IMM(BPF_MOV, R0, 0x01234567),
  7328				BPF_ALU32_IMM(BPF_MOV, R3, 0x89abcdef),
  7329				BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R3, -40),
  7330				BPF_LDX_MEM(BPF_W, R0, R10, -40),
  7331				BPF_EXIT_INSN(),
  7332			},
  7333			INTERNAL,
  7334			{ },
  7335			{ { 0, 0x89abcdef } },
  7336			.stack_depth = 40,
  7337		},
  7338		{
  7339			"BPF_ATOMIC | BPF_W, BPF_CMPXCHG: Test failure return",
  7340			.u.insns_int = {
  7341				BPF_ST_MEM(BPF_W, R10, -40, 0x01234567),
  7342				BPF_ALU32_IMM(BPF_MOV, R0, 0x76543210),
  7343				BPF_ALU32_IMM(BPF_MOV, R3, 0x89abcdef),
  7344				BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R3, -40),
  7345				BPF_EXIT_INSN(),
  7346			},
  7347			INTERNAL,
  7348			{ },
  7349			{ { 0, 0x01234567 } },
  7350			.stack_depth = 40,
  7351		},
  7352		{
  7353			"BPF_ATOMIC | BPF_W, BPF_CMPXCHG: Test failure store",
  7354			.u.insns_int = {
  7355				BPF_ST_MEM(BPF_W, R10, -40, 0x01234567),
  7356				BPF_ALU32_IMM(BPF_MOV, R0, 0x76543210),
  7357				BPF_ALU32_IMM(BPF_MOV, R3, 0x89abcdef),
  7358				BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R3, -40),
  7359				BPF_LDX_MEM(BPF_W, R0, R10, -40),
  7360				BPF_EXIT_INSN(),
  7361			},
  7362			INTERNAL,
  7363			{ },
  7364			{ { 0, 0x01234567 } },
  7365			.stack_depth = 40,
  7366		},
  7367		{
  7368			"BPF_ATOMIC | BPF_W, BPF_CMPXCHG: Test side effects",
  7369			.u.insns_int = {
  7370				BPF_ST_MEM(BPF_W, R10, -40, 0x01234567),
  7371				BPF_ALU32_IMM(BPF_MOV, R0, 0x01234567),
  7372				BPF_ALU32_IMM(BPF_MOV, R3, 0x89abcdef),
  7373				BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R3, -40),
  7374				BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, R10, R3, -40),
  7375				BPF_ALU32_REG(BPF_MOV, R0, R3),
  7376				BPF_EXIT_INSN(),
  7377			},
  7378			INTERNAL,
  7379			{ },
  7380			{ { 0, 0x89abcdef } },
  7381			.stack_depth = 40,
  7382		},
  7383		/* BPF_ATOMIC | BPF_DW, BPF_CMPXCHG */
  7384		{
  7385			"BPF_ATOMIC | BPF_DW, BPF_CMPXCHG: Test successful return",
  7386			.u.insns_int = {
  7387				BPF_LD_IMM64(R1, 0x0123456789abcdefULL),
  7388				BPF_LD_IMM64(R2, 0xfecdba9876543210ULL),
  7389				BPF_ALU64_REG(BPF_MOV, R0, R1),
  7390				BPF_STX_MEM(BPF_DW, R10, R1, -40),
  7391				BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -40),
  7392				BPF_JMP_REG(BPF_JNE, R0, R1, 1),
  7393				BPF_ALU64_REG(BPF_SUB, R0, R1),
  7394				BPF_EXIT_INSN(),
  7395			},
  7396			INTERNAL,
  7397			{ },
  7398			{ { 0, 0 } },
  7399			.stack_depth = 40,
  7400		},
  7401		{
  7402			"BPF_ATOMIC | BPF_DW, BPF_CMPXCHG: Test successful store",
  7403			.u.insns_int = {
  7404				BPF_LD_IMM64(R1, 0x0123456789abcdefULL),
  7405				BPF_LD_IMM64(R2, 0xfecdba9876543210ULL),
  7406				BPF_ALU64_REG(BPF_MOV, R0, R1),
  7407				BPF_STX_MEM(BPF_DW, R10, R0, -40),
  7408				BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -40),
  7409				BPF_LDX_MEM(BPF_DW, R0, R10, -40),
  7410				BPF_JMP_REG(BPF_JNE, R0, R2, 1),
  7411				BPF_ALU64_REG(BPF_SUB, R0, R2),
  7412				BPF_EXIT_INSN(),
  7413			},
  7414			INTERNAL,
  7415			{ },
  7416			{ { 0, 0 } },
  7417			.stack_depth = 40,
  7418		},
  7419		{
  7420			"BPF_ATOMIC | BPF_DW, BPF_CMPXCHG: Test failure return",
  7421			.u.insns_int = {
  7422				BPF_LD_IMM64(R1, 0x0123456789abcdefULL),
  7423				BPF_LD_IMM64(R2, 0xfecdba9876543210ULL),
  7424				BPF_ALU64_REG(BPF_MOV, R0, R1),
  7425				BPF_ALU64_IMM(BPF_ADD, R0, 1),
  7426				BPF_STX_MEM(BPF_DW, R10, R1, -40),
  7427				BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -40),
  7428				BPF_JMP_REG(BPF_JNE, R0, R1, 1),
  7429				BPF_ALU64_REG(BPF_SUB, R0, R1),
  7430				BPF_EXIT_INSN(),
  7431			},
  7432			INTERNAL,
  7433			{ },
  7434			{ { 0, 0 } },
  7435			.stack_depth = 40,
  7436		},
  7437		{
  7438			"BPF_ATOMIC | BPF_DW, BPF_CMPXCHG: Test failure store",
  7439			.u.insns_int = {
  7440				BPF_LD_IMM64(R1, 0x0123456789abcdefULL),
  7441				BPF_LD_IMM64(R2, 0xfecdba9876543210ULL),
  7442				BPF_ALU64_REG(BPF_MOV, R0, R1),
  7443				BPF_ALU64_IMM(BPF_ADD, R0, 1),
  7444				BPF_STX_MEM(BPF_DW, R10, R1, -40),
  7445				BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -40),
  7446				BPF_LDX_MEM(BPF_DW, R0, R10, -40),
  7447				BPF_JMP_REG(BPF_JNE, R0, R1, 1),
  7448				BPF_ALU64_REG(BPF_SUB, R0, R1),
  7449				BPF_EXIT_INSN(),
  7450			},
  7451			INTERNAL,
  7452			{ },
  7453			{ { 0, 0 } },
  7454			.stack_depth = 40,
  7455		},
  7456		{
  7457			"BPF_ATOMIC | BPF_DW, BPF_CMPXCHG: Test side effects",
  7458			.u.insns_int = {
  7459				BPF_LD_IMM64(R1, 0x0123456789abcdefULL),
  7460				BPF_LD_IMM64(R2, 0xfecdba9876543210ULL),
  7461				BPF_ALU64_REG(BPF_MOV, R0, R1),
  7462				BPF_STX_MEM(BPF_DW, R10, R1, -40),
  7463				BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, R10, R2, -40),
  7464				BPF_LD_IMM64(R0, 0xfecdba9876543210ULL),
  7465				BPF_JMP_REG(BPF_JNE, R0, R2, 1),
  7466				BPF_ALU64_REG(BPF_SUB, R0, R2),
  7467				BPF_EXIT_INSN(),
  7468			},
  7469			INTERNAL,
  7470			{ },
  7471			{ { 0, 0 } },
  7472			.stack_depth = 40,
  7473		},
  7474		/* BPF_JMP32 | BPF_JEQ | BPF_K */
  7475		{
  7476			"JMP32_JEQ_K: Small immediate",
  7477			.u.insns_int = {
  7478				BPF_ALU32_IMM(BPF_MOV, R0, 123),
  7479				BPF_JMP32_IMM(BPF_JEQ, R0, 321, 1),
  7480				BPF_JMP32_IMM(BPF_JEQ, R0, 123, 1),
  7481				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7482				BPF_EXIT_INSN(),
  7483			},
  7484			INTERNAL,
  7485			{ },
  7486			{ { 0, 123 } }
  7487		},
  7488		{
  7489			"JMP32_JEQ_K: Large immediate",
  7490			.u.insns_int = {
  7491				BPF_ALU32_IMM(BPF_MOV, R0, 12345678),
  7492				BPF_JMP32_IMM(BPF_JEQ, R0, 12345678 & 0xffff, 1),
  7493				BPF_JMP32_IMM(BPF_JEQ, R0, 12345678, 1),
  7494				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7495				BPF_EXIT_INSN(),
  7496			},
  7497			INTERNAL,
  7498			{ },
  7499			{ { 0, 12345678 } }
  7500		},
  7501		{
  7502			"JMP32_JEQ_K: negative immediate",
  7503			.u.insns_int = {
  7504				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  7505				BPF_JMP32_IMM(BPF_JEQ, R0,  123, 1),
  7506				BPF_JMP32_IMM(BPF_JEQ, R0, -123, 1),
  7507				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7508				BPF_EXIT_INSN(),
  7509			},
  7510			INTERNAL,
  7511			{ },
  7512			{ { 0, -123 } }
  7513		},
  7514		/* BPF_JMP32 | BPF_JEQ | BPF_X */
  7515		{
  7516			"JMP32_JEQ_X",
  7517			.u.insns_int = {
  7518				BPF_ALU32_IMM(BPF_MOV, R0, 1234),
  7519				BPF_ALU32_IMM(BPF_MOV, R1, 4321),
  7520				BPF_JMP32_REG(BPF_JEQ, R0, R1, 2),
  7521				BPF_ALU32_IMM(BPF_MOV, R1, 1234),
  7522				BPF_JMP32_REG(BPF_JEQ, R0, R1, 1),
  7523				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7524				BPF_EXIT_INSN(),
  7525			},
  7526			INTERNAL,
  7527			{ },
  7528			{ { 0, 1234 } }
  7529		},
  7530		/* BPF_JMP32 | BPF_JNE | BPF_K */
  7531		{
  7532			"JMP32_JNE_K: Small immediate",
  7533			.u.insns_int = {
  7534				BPF_ALU32_IMM(BPF_MOV, R0, 123),
  7535				BPF_JMP32_IMM(BPF_JNE, R0, 123, 1),
  7536				BPF_JMP32_IMM(BPF_JNE, R0, 321, 1),
  7537				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7538				BPF_EXIT_INSN(),
  7539			},
  7540			INTERNAL,
  7541			{ },
  7542			{ { 0, 123 } }
  7543		},
  7544		{
  7545			"JMP32_JNE_K: Large immediate",
  7546			.u.insns_int = {
  7547				BPF_ALU32_IMM(BPF_MOV, R0, 12345678),
  7548				BPF_JMP32_IMM(BPF_JNE, R0, 12345678, 1),
  7549				BPF_JMP32_IMM(BPF_JNE, R0, 12345678 & 0xffff, 1),
  7550				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7551				BPF_EXIT_INSN(),
  7552			},
  7553			INTERNAL,
  7554			{ },
  7555			{ { 0, 12345678 } }
  7556		},
  7557		{
  7558			"JMP32_JNE_K: negative immediate",
  7559			.u.insns_int = {
  7560				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  7561				BPF_JMP32_IMM(BPF_JNE, R0, -123, 1),
  7562				BPF_JMP32_IMM(BPF_JNE, R0,  123, 1),
  7563				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7564				BPF_EXIT_INSN(),
  7565			},
  7566			INTERNAL,
  7567			{ },
  7568			{ { 0, -123 } }
  7569		},
  7570		/* BPF_JMP32 | BPF_JNE | BPF_X */
  7571		{
  7572			"JMP32_JNE_X",
  7573			.u.insns_int = {
  7574				BPF_ALU32_IMM(BPF_MOV, R0, 1234),
  7575				BPF_ALU32_IMM(BPF_MOV, R1, 1234),
  7576				BPF_JMP32_REG(BPF_JNE, R0, R1, 2),
  7577				BPF_ALU32_IMM(BPF_MOV, R1, 4321),
  7578				BPF_JMP32_REG(BPF_JNE, R0, R1, 1),
  7579				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7580				BPF_EXIT_INSN(),
  7581			},
  7582			INTERNAL,
  7583			{ },
  7584			{ { 0, 1234 } }
  7585		},
  7586		/* BPF_JMP32 | BPF_JSET | BPF_K */
  7587		{
  7588			"JMP32_JSET_K: Small immediate",
  7589			.u.insns_int = {
  7590				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  7591				BPF_JMP32_IMM(BPF_JSET, R0, 2, 1),
  7592				BPF_JMP32_IMM(BPF_JSET, R0, 3, 1),
  7593				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7594				BPF_EXIT_INSN(),
  7595			},
  7596			INTERNAL,
  7597			{ },
  7598			{ { 0, 1 } }
  7599		},
  7600		{
  7601			"JMP32_JSET_K: Large immediate",
  7602			.u.insns_int = {
  7603				BPF_ALU32_IMM(BPF_MOV, R0, 0x40000000),
  7604				BPF_JMP32_IMM(BPF_JSET, R0, 0x3fffffff, 1),
  7605				BPF_JMP32_IMM(BPF_JSET, R0, 0x60000000, 1),
  7606				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7607				BPF_EXIT_INSN(),
  7608			},
  7609			INTERNAL,
  7610			{ },
  7611			{ { 0, 0x40000000 } }
  7612		},
  7613		{
  7614			"JMP32_JSET_K: negative immediate",
  7615			.u.insns_int = {
  7616				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  7617				BPF_JMP32_IMM(BPF_JSET, R0, -1, 1),
  7618				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7619				BPF_EXIT_INSN(),
  7620			},
  7621			INTERNAL,
  7622			{ },
  7623			{ { 0, -123 } }
  7624		},
  7625		/* BPF_JMP32 | BPF_JSET | BPF_X */
  7626		{
  7627			"JMP32_JSET_X",
  7628			.u.insns_int = {
  7629				BPF_ALU32_IMM(BPF_MOV, R0, 8),
  7630				BPF_ALU32_IMM(BPF_MOV, R1, 7),
  7631				BPF_JMP32_REG(BPF_JSET, R0, R1, 2),
  7632				BPF_ALU32_IMM(BPF_MOV, R1, 8 | 2),
  7633				BPF_JMP32_REG(BPF_JNE, R0, R1, 1),
  7634				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7635				BPF_EXIT_INSN(),
  7636			},
  7637			INTERNAL,
  7638			{ },
  7639			{ { 0, 8 } }
  7640		},
  7641		/* BPF_JMP32 | BPF_JGT | BPF_K */
  7642		{
  7643			"JMP32_JGT_K: Small immediate",
  7644			.u.insns_int = {
  7645				BPF_ALU32_IMM(BPF_MOV, R0, 123),
  7646				BPF_JMP32_IMM(BPF_JGT, R0, 123, 1),
  7647				BPF_JMP32_IMM(BPF_JGT, R0, 122, 1),
  7648				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7649				BPF_EXIT_INSN(),
  7650			},
  7651			INTERNAL,
  7652			{ },
  7653			{ { 0, 123 } }
  7654		},
  7655		{
  7656			"JMP32_JGT_K: Large immediate",
  7657			.u.insns_int = {
  7658				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  7659				BPF_JMP32_IMM(BPF_JGT, R0, 0xffffffff, 1),
  7660				BPF_JMP32_IMM(BPF_JGT, R0, 0xfffffffd, 1),
  7661				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7662				BPF_EXIT_INSN(),
  7663			},
  7664			INTERNAL,
  7665			{ },
  7666			{ { 0, 0xfffffffe } }
  7667		},
  7668		/* BPF_JMP32 | BPF_JGT | BPF_X */
  7669		{
  7670			"JMP32_JGT_X",
  7671			.u.insns_int = {
  7672				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  7673				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  7674				BPF_JMP32_REG(BPF_JGT, R0, R1, 2),
  7675				BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffd),
  7676				BPF_JMP32_REG(BPF_JGT, R0, R1, 1),
  7677				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7678				BPF_EXIT_INSN(),
  7679			},
  7680			INTERNAL,
  7681			{ },
  7682			{ { 0, 0xfffffffe } }
  7683		},
  7684		/* BPF_JMP32 | BPF_JGE | BPF_K */
  7685		{
  7686			"JMP32_JGE_K: Small immediate",
  7687			.u.insns_int = {
  7688				BPF_ALU32_IMM(BPF_MOV, R0, 123),
  7689				BPF_JMP32_IMM(BPF_JGE, R0, 124, 1),
  7690				BPF_JMP32_IMM(BPF_JGE, R0, 123, 1),
  7691				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7692				BPF_EXIT_INSN(),
  7693			},
  7694			INTERNAL,
  7695			{ },
  7696			{ { 0, 123 } }
  7697		},
  7698		{
  7699			"JMP32_JGE_K: Large immediate",
  7700			.u.insns_int = {
  7701				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  7702				BPF_JMP32_IMM(BPF_JGE, R0, 0xffffffff, 1),
  7703				BPF_JMP32_IMM(BPF_JGE, R0, 0xfffffffe, 1),
  7704				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7705				BPF_EXIT_INSN(),
  7706			},
  7707			INTERNAL,
  7708			{ },
  7709			{ { 0, 0xfffffffe } }
  7710		},
  7711		/* BPF_JMP32 | BPF_JGE | BPF_X */
  7712		{
  7713			"JMP32_JGE_X",
  7714			.u.insns_int = {
  7715				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  7716				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  7717				BPF_JMP32_REG(BPF_JGE, R0, R1, 2),
  7718				BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffe),
  7719				BPF_JMP32_REG(BPF_JGE, R0, R1, 1),
  7720				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7721				BPF_EXIT_INSN(),
  7722			},
  7723			INTERNAL,
  7724			{ },
  7725			{ { 0, 0xfffffffe } }
  7726		},
  7727		/* BPF_JMP32 | BPF_JLT | BPF_K */
  7728		{
  7729			"JMP32_JLT_K: Small immediate",
  7730			.u.insns_int = {
  7731				BPF_ALU32_IMM(BPF_MOV, R0, 123),
  7732				BPF_JMP32_IMM(BPF_JLT, R0, 123, 1),
  7733				BPF_JMP32_IMM(BPF_JLT, R0, 124, 1),
  7734				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7735				BPF_EXIT_INSN(),
  7736			},
  7737			INTERNAL,
  7738			{ },
  7739			{ { 0, 123 } }
  7740		},
  7741		{
  7742			"JMP32_JLT_K: Large immediate",
  7743			.u.insns_int = {
  7744				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  7745				BPF_JMP32_IMM(BPF_JLT, R0, 0xfffffffd, 1),
  7746				BPF_JMP32_IMM(BPF_JLT, R0, 0xffffffff, 1),
  7747				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7748				BPF_EXIT_INSN(),
  7749			},
  7750			INTERNAL,
  7751			{ },
  7752			{ { 0, 0xfffffffe } }
  7753		},
  7754		/* BPF_JMP32 | BPF_JLT | BPF_X */
  7755		{
  7756			"JMP32_JLT_X",
  7757			.u.insns_int = {
  7758				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  7759				BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffd),
  7760				BPF_JMP32_REG(BPF_JLT, R0, R1, 2),
  7761				BPF_ALU32_IMM(BPF_MOV, R1, 0xffffffff),
  7762				BPF_JMP32_REG(BPF_JLT, R0, R1, 1),
  7763				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7764				BPF_EXIT_INSN(),
  7765			},
  7766			INTERNAL,
  7767			{ },
  7768			{ { 0, 0xfffffffe } }
  7769		},
  7770		/* BPF_JMP32 | BPF_JLE | BPF_K */
  7771		{
  7772			"JMP32_JLE_K: Small immediate",
  7773			.u.insns_int = {
  7774				BPF_ALU32_IMM(BPF_MOV, R0, 123),
  7775				BPF_JMP32_IMM(BPF_JLE, R0, 122, 1),
  7776				BPF_JMP32_IMM(BPF_JLE, R0, 123, 1),
  7777				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7778				BPF_EXIT_INSN(),
  7779			},
  7780			INTERNAL,
  7781			{ },
  7782			{ { 0, 123 } }
  7783		},
  7784		{
  7785			"JMP32_JLE_K: Large immediate",
  7786			.u.insns_int = {
  7787				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  7788				BPF_JMP32_IMM(BPF_JLE, R0, 0xfffffffd, 1),
  7789				BPF_JMP32_IMM(BPF_JLE, R0, 0xfffffffe, 1),
  7790				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7791				BPF_EXIT_INSN(),
  7792			},
  7793			INTERNAL,
  7794			{ },
  7795			{ { 0, 0xfffffffe } }
  7796		},
  7797		/* BPF_JMP32 | BPF_JLE | BPF_X */
  7798		{
  7799			"JMP32_JLE_X",
  7800			.u.insns_int = {
  7801				BPF_ALU32_IMM(BPF_MOV, R0, 0xfffffffe),
  7802				BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffd),
  7803				BPF_JMP32_REG(BPF_JLE, R0, R1, 2),
  7804				BPF_ALU32_IMM(BPF_MOV, R1, 0xfffffffe),
  7805				BPF_JMP32_REG(BPF_JLE, R0, R1, 1),
  7806				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7807				BPF_EXIT_INSN(),
  7808			},
  7809			INTERNAL,
  7810			{ },
  7811			{ { 0, 0xfffffffe } }
  7812		},
  7813		/* BPF_JMP32 | BPF_JSGT | BPF_K */
  7814		{
  7815			"JMP32_JSGT_K: Small immediate",
  7816			.u.insns_int = {
  7817				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  7818				BPF_JMP32_IMM(BPF_JSGT, R0, -123, 1),
  7819				BPF_JMP32_IMM(BPF_JSGT, R0, -124, 1),
  7820				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7821				BPF_EXIT_INSN(),
  7822			},
  7823			INTERNAL,
  7824			{ },
  7825			{ { 0, -123 } }
  7826		},
  7827		{
  7828			"JMP32_JSGT_K: Large immediate",
  7829			.u.insns_int = {
  7830				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  7831				BPF_JMP32_IMM(BPF_JSGT, R0, -12345678, 1),
  7832				BPF_JMP32_IMM(BPF_JSGT, R0, -12345679, 1),
  7833				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7834				BPF_EXIT_INSN(),
  7835			},
  7836			INTERNAL,
  7837			{ },
  7838			{ { 0, -12345678 } }
  7839		},
  7840		/* BPF_JMP32 | BPF_JSGT | BPF_X */
  7841		{
  7842			"JMP32_JSGT_X",
  7843			.u.insns_int = {
  7844				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  7845				BPF_ALU32_IMM(BPF_MOV, R1, -12345678),
  7846				BPF_JMP32_REG(BPF_JSGT, R0, R1, 2),
  7847				BPF_ALU32_IMM(BPF_MOV, R1, -12345679),
  7848				BPF_JMP32_REG(BPF_JSGT, R0, R1, 1),
  7849				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7850				BPF_EXIT_INSN(),
  7851			},
  7852			INTERNAL,
  7853			{ },
  7854			{ { 0, -12345678 } }
  7855		},
  7856		/* BPF_JMP32 | BPF_JSGE | BPF_K */
  7857		{
  7858			"JMP32_JSGE_K: Small immediate",
  7859			.u.insns_int = {
  7860				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  7861				BPF_JMP32_IMM(BPF_JSGE, R0, -122, 1),
  7862				BPF_JMP32_IMM(BPF_JSGE, R0, -123, 1),
  7863				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7864				BPF_EXIT_INSN(),
  7865			},
  7866			INTERNAL,
  7867			{ },
  7868			{ { 0, -123 } }
  7869		},
  7870		{
  7871			"JMP32_JSGE_K: Large immediate",
  7872			.u.insns_int = {
  7873				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  7874				BPF_JMP32_IMM(BPF_JSGE, R0, -12345677, 1),
  7875				BPF_JMP32_IMM(BPF_JSGE, R0, -12345678, 1),
  7876				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7877				BPF_EXIT_INSN(),
  7878			},
  7879			INTERNAL,
  7880			{ },
  7881			{ { 0, -12345678 } }
  7882		},
  7883		/* BPF_JMP32 | BPF_JSGE | BPF_X */
  7884		{
  7885			"JMP32_JSGE_X",
  7886			.u.insns_int = {
  7887				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  7888				BPF_ALU32_IMM(BPF_MOV, R1, -12345677),
  7889				BPF_JMP32_REG(BPF_JSGE, R0, R1, 2),
  7890				BPF_ALU32_IMM(BPF_MOV, R1, -12345678),
  7891				BPF_JMP32_REG(BPF_JSGE, R0, R1, 1),
  7892				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7893				BPF_EXIT_INSN(),
  7894			},
  7895			INTERNAL,
  7896			{ },
  7897			{ { 0, -12345678 } }
  7898		},
  7899		/* BPF_JMP32 | BPF_JSLT | BPF_K */
  7900		{
  7901			"JMP32_JSLT_K: Small immediate",
  7902			.u.insns_int = {
  7903				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  7904				BPF_JMP32_IMM(BPF_JSLT, R0, -123, 1),
  7905				BPF_JMP32_IMM(BPF_JSLT, R0, -122, 1),
  7906				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7907				BPF_EXIT_INSN(),
  7908			},
  7909			INTERNAL,
  7910			{ },
  7911			{ { 0, -123 } }
  7912		},
  7913		{
  7914			"JMP32_JSLT_K: Large immediate",
  7915			.u.insns_int = {
  7916				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  7917				BPF_JMP32_IMM(BPF_JSLT, R0, -12345678, 1),
  7918				BPF_JMP32_IMM(BPF_JSLT, R0, -12345677, 1),
  7919				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7920				BPF_EXIT_INSN(),
  7921			},
  7922			INTERNAL,
  7923			{ },
  7924			{ { 0, -12345678 } }
  7925		},
  7926		/* BPF_JMP32 | BPF_JSLT | BPF_X */
  7927		{
  7928			"JMP32_JSLT_X",
  7929			.u.insns_int = {
  7930				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  7931				BPF_ALU32_IMM(BPF_MOV, R1, -12345678),
  7932				BPF_JMP32_REG(BPF_JSLT, R0, R1, 2),
  7933				BPF_ALU32_IMM(BPF_MOV, R1, -12345677),
  7934				BPF_JMP32_REG(BPF_JSLT, R0, R1, 1),
  7935				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7936				BPF_EXIT_INSN(),
  7937			},
  7938			INTERNAL,
  7939			{ },
  7940			{ { 0, -12345678 } }
  7941		},
  7942		/* BPF_JMP32 | BPF_JSLE | BPF_K */
  7943		{
  7944			"JMP32_JSLE_K: Small immediate",
  7945			.u.insns_int = {
  7946				BPF_ALU32_IMM(BPF_MOV, R0, -123),
  7947				BPF_JMP32_IMM(BPF_JSLE, R0, -124, 1),
  7948				BPF_JMP32_IMM(BPF_JSLE, R0, -123, 1),
  7949				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7950				BPF_EXIT_INSN(),
  7951			},
  7952			INTERNAL,
  7953			{ },
  7954			{ { 0, -123 } }
  7955		},
  7956		{
  7957			"JMP32_JSLE_K: Large immediate",
  7958			.u.insns_int = {
  7959				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  7960				BPF_JMP32_IMM(BPF_JSLE, R0, -12345679, 1),
  7961				BPF_JMP32_IMM(BPF_JSLE, R0, -12345678, 1),
  7962				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7963				BPF_EXIT_INSN(),
  7964			},
  7965			INTERNAL,
  7966			{ },
  7967			{ { 0, -12345678 } }
  7968		},
  7969		/* BPF_JMP32 | BPF_JSLE | BPF_K */
  7970		{
  7971			"JMP32_JSLE_X",
  7972			.u.insns_int = {
  7973				BPF_ALU32_IMM(BPF_MOV, R0, -12345678),
  7974				BPF_ALU32_IMM(BPF_MOV, R1, -12345679),
  7975				BPF_JMP32_REG(BPF_JSLE, R0, R1, 2),
  7976				BPF_ALU32_IMM(BPF_MOV, R1, -12345678),
  7977				BPF_JMP32_REG(BPF_JSLE, R0, R1, 1),
  7978				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  7979				BPF_EXIT_INSN(),
  7980			},
  7981			INTERNAL,
  7982			{ },
  7983			{ { 0, -12345678 } }
  7984		},
  7985		/* BPF_JMP | BPF_EXIT */
  7986		{
  7987			"JMP_EXIT",
  7988			.u.insns_int = {
  7989				BPF_ALU32_IMM(BPF_MOV, R0, 0x4711),
  7990				BPF_EXIT_INSN(),
  7991				BPF_ALU32_IMM(BPF_MOV, R0, 0x4712),
  7992			},
  7993			INTERNAL,
  7994			{ },
  7995			{ { 0, 0x4711 } },
  7996		},
  7997		/* BPF_JMP | BPF_JA */
  7998		{
  7999			"JMP_JA: Unconditional jump: if (true) return 1",
  8000			.u.insns_int = {
  8001				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8002				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
  8003				BPF_EXIT_INSN(),
  8004				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8005				BPF_EXIT_INSN(),
  8006			},
  8007			INTERNAL,
  8008			{ },
  8009			{ { 0, 1 } },
  8010		},
  8011		/* BPF_JMP | BPF_JSLT | BPF_K */
  8012		{
  8013			"JMP_JSLT_K: Signed jump: if (-2 < -1) return 1",
  8014			.u.insns_int = {
  8015				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8016				BPF_LD_IMM64(R1, 0xfffffffffffffffeLL),
  8017				BPF_JMP_IMM(BPF_JSLT, R1, -1, 1),
  8018				BPF_EXIT_INSN(),
  8019				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8020				BPF_EXIT_INSN(),
  8021			},
  8022			INTERNAL,
  8023			{ },
  8024			{ { 0, 1 } },
  8025		},
  8026		{
  8027			"JMP_JSLT_K: Signed jump: if (-1 < -1) return 0",
  8028			.u.insns_int = {
  8029				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8030				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  8031				BPF_JMP_IMM(BPF_JSLT, R1, -1, 1),
  8032				BPF_EXIT_INSN(),
  8033				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8034				BPF_EXIT_INSN(),
  8035			},
  8036			INTERNAL,
  8037			{ },
  8038			{ { 0, 1 } },
  8039		},
  8040		/* BPF_JMP | BPF_JSGT | BPF_K */
  8041		{
  8042			"JMP_JSGT_K: Signed jump: if (-1 > -2) return 1",
  8043			.u.insns_int = {
  8044				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8045				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  8046				BPF_JMP_IMM(BPF_JSGT, R1, -2, 1),
  8047				BPF_EXIT_INSN(),
  8048				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8049				BPF_EXIT_INSN(),
  8050			},
  8051			INTERNAL,
  8052			{ },
  8053			{ { 0, 1 } },
  8054		},
  8055		{
  8056			"JMP_JSGT_K: Signed jump: if (-1 > -1) return 0",
  8057			.u.insns_int = {
  8058				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8059				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  8060				BPF_JMP_IMM(BPF_JSGT, R1, -1, 1),
  8061				BPF_EXIT_INSN(),
  8062				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8063				BPF_EXIT_INSN(),
  8064			},
  8065			INTERNAL,
  8066			{ },
  8067			{ { 0, 1 } },
  8068		},
  8069		/* BPF_JMP | BPF_JSLE | BPF_K */
  8070		{
  8071			"JMP_JSLE_K: Signed jump: if (-2 <= -1) return 1",
  8072			.u.insns_int = {
  8073				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8074				BPF_LD_IMM64(R1, 0xfffffffffffffffeLL),
  8075				BPF_JMP_IMM(BPF_JSLE, R1, -1, 1),
  8076				BPF_EXIT_INSN(),
  8077				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8078				BPF_EXIT_INSN(),
  8079			},
  8080			INTERNAL,
  8081			{ },
  8082			{ { 0, 1 } },
  8083		},
  8084		{
  8085			"JMP_JSLE_K: Signed jump: if (-1 <= -1) return 1",
  8086			.u.insns_int = {
  8087				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8088				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  8089				BPF_JMP_IMM(BPF_JSLE, R1, -1, 1),
  8090				BPF_EXIT_INSN(),
  8091				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8092				BPF_EXIT_INSN(),
  8093			},
  8094			INTERNAL,
  8095			{ },
  8096			{ { 0, 1 } },
  8097		},
  8098		{
  8099			"JMP_JSLE_K: Signed jump: value walk 1",
  8100			.u.insns_int = {
  8101				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8102				BPF_LD_IMM64(R1, 3),
  8103				BPF_JMP_IMM(BPF_JSLE, R1, 0, 6),
  8104				BPF_ALU64_IMM(BPF_SUB, R1, 1),
  8105				BPF_JMP_IMM(BPF_JSLE, R1, 0, 4),
  8106				BPF_ALU64_IMM(BPF_SUB, R1, 1),
  8107				BPF_JMP_IMM(BPF_JSLE, R1, 0, 2),
  8108				BPF_ALU64_IMM(BPF_SUB, R1, 1),
  8109				BPF_JMP_IMM(BPF_JSLE, R1, 0, 1),
  8110				BPF_EXIT_INSN(),		/* bad exit */
  8111				BPF_ALU32_IMM(BPF_MOV, R0, 1),	/* good exit */
  8112				BPF_EXIT_INSN(),
  8113			},
  8114			INTERNAL,
  8115			{ },
  8116			{ { 0, 1 } },
  8117		},
  8118		{
  8119			"JMP_JSLE_K: Signed jump: value walk 2",
  8120			.u.insns_int = {
  8121				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8122				BPF_LD_IMM64(R1, 3),
  8123				BPF_JMP_IMM(BPF_JSLE, R1, 0, 4),
  8124				BPF_ALU64_IMM(BPF_SUB, R1, 2),
  8125				BPF_JMP_IMM(BPF_JSLE, R1, 0, 2),
  8126				BPF_ALU64_IMM(BPF_SUB, R1, 2),
  8127				BPF_JMP_IMM(BPF_JSLE, R1, 0, 1),
  8128				BPF_EXIT_INSN(),		/* bad exit */
  8129				BPF_ALU32_IMM(BPF_MOV, R0, 1),	/* good exit */
  8130				BPF_EXIT_INSN(),
  8131			},
  8132			INTERNAL,
  8133			{ },
  8134			{ { 0, 1 } },
  8135		},
  8136		/* BPF_JMP | BPF_JSGE | BPF_K */
  8137		{
  8138			"JMP_JSGE_K: Signed jump: if (-1 >= -2) return 1",
  8139			.u.insns_int = {
  8140				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8141				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  8142				BPF_JMP_IMM(BPF_JSGE, R1, -2, 1),
  8143				BPF_EXIT_INSN(),
  8144				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8145				BPF_EXIT_INSN(),
  8146			},
  8147			INTERNAL,
  8148			{ },
  8149			{ { 0, 1 } },
  8150		},
  8151		{
  8152			"JMP_JSGE_K: Signed jump: if (-1 >= -1) return 1",
  8153			.u.insns_int = {
  8154				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8155				BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
  8156				BPF_JMP_IMM(BPF_JSGE, R1, -1, 1),
  8157				BPF_EXIT_INSN(),
  8158				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8159				BPF_EXIT_INSN(),
  8160			},
  8161			INTERNAL,
  8162			{ },
  8163			{ { 0, 1 } },
  8164		},
  8165		{
  8166			"JMP_JSGE_K: Signed jump: value walk 1",
  8167			.u.insns_int = {
  8168				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8169				BPF_LD_IMM64(R1, -3),
  8170				BPF_JMP_IMM(BPF_JSGE, R1, 0, 6),
  8171				BPF_ALU64_IMM(BPF_ADD, R1, 1),
  8172				BPF_JMP_IMM(BPF_JSGE, R1, 0, 4),
  8173				BPF_ALU64_IMM(BPF_ADD, R1, 1),
  8174				BPF_JMP_IMM(BPF_JSGE, R1, 0, 2),
  8175				BPF_ALU64_IMM(BPF_ADD, R1, 1),
  8176				BPF_JMP_IMM(BPF_JSGE, R1, 0, 1),
  8177				BPF_EXIT_INSN(),		/* bad exit */
  8178				BPF_ALU32_IMM(BPF_MOV, R0, 1),	/* good exit */
  8179				BPF_EXIT_INSN(),
  8180			},
  8181			INTERNAL,
  8182			{ },
  8183			{ { 0, 1 } },
  8184		},
  8185		{
  8186			"JMP_JSGE_K: Signed jump: value walk 2",
  8187			.u.insns_int = {
  8188				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8189				BPF_LD_IMM64(R1, -3),
  8190				BPF_JMP_IMM(BPF_JSGE, R1, 0, 4),
  8191				BPF_ALU64_IMM(BPF_ADD, R1, 2),
  8192				BPF_JMP_IMM(BPF_JSGE, R1, 0, 2),
  8193				BPF_ALU64_IMM(BPF_ADD, R1, 2),
  8194				BPF_JMP_IMM(BPF_JSGE, R1, 0, 1),
  8195				BPF_EXIT_INSN(),		/* bad exit */
  8196				BPF_ALU32_IMM(BPF_MOV, R0, 1),	/* good exit */
  8197				BPF_EXIT_INSN(),
  8198			},
  8199			INTERNAL,
  8200			{ },
  8201			{ { 0, 1 } },
  8202		},
  8203		/* BPF_JMP | BPF_JGT | BPF_K */
  8204		{
  8205			"JMP_JGT_K: if (3 > 2) return 1",
  8206			.u.insns_int = {
  8207				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8208				BPF_LD_IMM64(R1, 3),
  8209				BPF_JMP_IMM(BPF_JGT, R1, 2, 1),
  8210				BPF_EXIT_INSN(),
  8211				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8212				BPF_EXIT_INSN(),
  8213			},
  8214			INTERNAL,
  8215			{ },
  8216			{ { 0, 1 } },
  8217		},
  8218		{
  8219			"JMP_JGT_K: Unsigned jump: if (-1 > 1) return 1",
  8220			.u.insns_int = {
  8221				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8222				BPF_LD_IMM64(R1, -1),
  8223				BPF_JMP_IMM(BPF_JGT, R1, 1, 1),
  8224				BPF_EXIT_INSN(),
  8225				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8226				BPF_EXIT_INSN(),
  8227			},
  8228			INTERNAL,
  8229			{ },
  8230			{ { 0, 1 } },
  8231		},
  8232		/* BPF_JMP | BPF_JLT | BPF_K */
  8233		{
  8234			"JMP_JLT_K: if (2 < 3) return 1",
  8235			.u.insns_int = {
  8236				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8237				BPF_LD_IMM64(R1, 2),
  8238				BPF_JMP_IMM(BPF_JLT, R1, 3, 1),
  8239				BPF_EXIT_INSN(),
  8240				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8241				BPF_EXIT_INSN(),
  8242			},
  8243			INTERNAL,
  8244			{ },
  8245			{ { 0, 1 } },
  8246		},
  8247		{
  8248			"JMP_JGT_K: Unsigned jump: if (1 < -1) return 1",
  8249			.u.insns_int = {
  8250				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8251				BPF_LD_IMM64(R1, 1),
  8252				BPF_JMP_IMM(BPF_JLT, R1, -1, 1),
  8253				BPF_EXIT_INSN(),
  8254				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8255				BPF_EXIT_INSN(),
  8256			},
  8257			INTERNAL,
  8258			{ },
  8259			{ { 0, 1 } },
  8260		},
  8261		/* BPF_JMP | BPF_JGE | BPF_K */
  8262		{
  8263			"JMP_JGE_K: if (3 >= 2) return 1",
  8264			.u.insns_int = {
  8265				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8266				BPF_LD_IMM64(R1, 3),
  8267				BPF_JMP_IMM(BPF_JGE, R1, 2, 1),
  8268				BPF_EXIT_INSN(),
  8269				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8270				BPF_EXIT_INSN(),
  8271			},
  8272			INTERNAL,
  8273			{ },
  8274			{ { 0, 1 } },
  8275		},
  8276		/* BPF_JMP | BPF_JLE | BPF_K */
  8277		{
  8278			"JMP_JLE_K: if (2 <= 3) return 1",
  8279			.u.insns_int = {
  8280				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8281				BPF_LD_IMM64(R1, 2),
  8282				BPF_JMP_IMM(BPF_JLE, R1, 3, 1),
  8283				BPF_EXIT_INSN(),
  8284				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8285				BPF_EXIT_INSN(),
  8286			},
  8287			INTERNAL,
  8288			{ },
  8289			{ { 0, 1 } },
  8290		},
  8291		/* BPF_JMP | BPF_JGT | BPF_K jump backwards */
  8292		{
  8293			"JMP_JGT_K: if (3 > 2) return 1 (jump backwards)",
  8294			.u.insns_int = {
  8295				BPF_JMP_IMM(BPF_JA, 0, 0, 2), /* goto start */
  8296				BPF_ALU32_IMM(BPF_MOV, R0, 1), /* out: */
  8297				BPF_EXIT_INSN(),
  8298				BPF_ALU32_IMM(BPF_MOV, R0, 0), /* start: */
  8299				BPF_LD_IMM64(R1, 3), /* note: this takes 2 insns */
  8300				BPF_JMP_IMM(BPF_JGT, R1, 2, -6), /* goto out */
  8301				BPF_EXIT_INSN(),
  8302			},
  8303			INTERNAL,
  8304			{ },
  8305			{ { 0, 1 } },
  8306		},
  8307		{
  8308			"JMP_JGE_K: if (3 >= 3) return 1",
  8309			.u.insns_int = {
  8310				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8311				BPF_LD_IMM64(R1, 3),
  8312				BPF_JMP_IMM(BPF_JGE, R1, 3, 1),
  8313				BPF_EXIT_INSN(),
  8314				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8315				BPF_EXIT_INSN(),
  8316			},
  8317			INTERNAL,
  8318			{ },
  8319			{ { 0, 1 } },
  8320		},
  8321		/* BPF_JMP | BPF_JLT | BPF_K jump backwards */
  8322		{
  8323			"JMP_JGT_K: if (2 < 3) return 1 (jump backwards)",
  8324			.u.insns_int = {
  8325				BPF_JMP_IMM(BPF_JA, 0, 0, 2), /* goto start */
  8326				BPF_ALU32_IMM(BPF_MOV, R0, 1), /* out: */
  8327				BPF_EXIT_INSN(),
  8328				BPF_ALU32_IMM(BPF_MOV, R0, 0), /* start: */
  8329				BPF_LD_IMM64(R1, 2), /* note: this takes 2 insns */
  8330				BPF_JMP_IMM(BPF_JLT, R1, 3, -6), /* goto out */
  8331				BPF_EXIT_INSN(),
  8332			},
  8333			INTERNAL,
  8334			{ },
  8335			{ { 0, 1 } },
  8336		},
  8337		{
  8338			"JMP_JLE_K: if (3 <= 3) return 1",
  8339			.u.insns_int = {
  8340				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8341				BPF_LD_IMM64(R1, 3),
  8342				BPF_JMP_IMM(BPF_JLE, R1, 3, 1),
  8343				BPF_EXIT_INSN(),
  8344				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8345				BPF_EXIT_INSN(),
  8346			},
  8347			INTERNAL,
  8348			{ },
  8349			{ { 0, 1 } },
  8350		},
  8351		/* BPF_JMP | BPF_JNE | BPF_K */
  8352		{
  8353			"JMP_JNE_K: if (3 != 2) return 1",
  8354			.u.insns_int = {
  8355				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8356				BPF_LD_IMM64(R1, 3),
  8357				BPF_JMP_IMM(BPF_JNE, R1, 2, 1),
  8358				BPF_EXIT_INSN(),
  8359				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8360				BPF_EXIT_INSN(),
  8361			},
  8362			INTERNAL,
  8363			{ },
  8364			{ { 0, 1 } },
  8365		},
  8366		/* BPF_JMP | BPF_JEQ | BPF_K */
  8367		{
  8368			"JMP_JEQ_K: if (3 == 3) return 1",
  8369			.u.insns_int = {
  8370				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8371				BPF_LD_IMM64(R1, 3),
  8372				BPF_JMP_IMM(BPF_JEQ, R1, 3, 1),
  8373				BPF_EXIT_INSN(),
  8374				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8375				BPF_EXIT_INSN(),
  8376			},
  8377			INTERNAL,
  8378			{ },
  8379			{ { 0, 1 } },
  8380		},
  8381		/* BPF_JMP | BPF_JSET | BPF_K */
  8382		{
  8383			"JMP_JSET_K: if (0x3 & 0x2) return 1",
  8384			.u.insns_int = {
  8385				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8386				BPF_LD_IMM64(R1, 3),
  8387				BPF_JMP_IMM(BPF_JSET, R1, 2, 1),
  8388				BPF_EXIT_INSN(),
  8389				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8390				BPF_EXIT_INSN(),
  8391			},
  8392			INTERNAL,
  8393			{ },
  8394			{ { 0, 1 } },
  8395		},
  8396		{
  8397			"JMP_JSET_K: if (0x3 & 0xffffffff) return 1",
  8398			.u.insns_int = {
  8399				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8400				BPF_LD_IMM64(R1, 3),
  8401				BPF_JMP_IMM(BPF_JSET, R1, 0xffffffff, 1),
  8402				BPF_EXIT_INSN(),
  8403				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8404				BPF_EXIT_INSN(),
  8405			},
  8406			INTERNAL,
  8407			{ },
  8408			{ { 0, 1 } },
  8409		},
  8410		/* BPF_JMP | BPF_JSGT | BPF_X */
  8411		{
  8412			"JMP_JSGT_X: Signed jump: if (-1 > -2) return 1",
  8413			.u.insns_int = {
  8414				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8415				BPF_LD_IMM64(R1, -1),
  8416				BPF_LD_IMM64(R2, -2),
  8417				BPF_JMP_REG(BPF_JSGT, R1, R2, 1),
  8418				BPF_EXIT_INSN(),
  8419				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8420				BPF_EXIT_INSN(),
  8421			},
  8422			INTERNAL,
  8423			{ },
  8424			{ { 0, 1 } },
  8425		},
  8426		{
  8427			"JMP_JSGT_X: Signed jump: if (-1 > -1) return 0",
  8428			.u.insns_int = {
  8429				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8430				BPF_LD_IMM64(R1, -1),
  8431				BPF_LD_IMM64(R2, -1),
  8432				BPF_JMP_REG(BPF_JSGT, R1, R2, 1),
  8433				BPF_EXIT_INSN(),
  8434				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8435				BPF_EXIT_INSN(),
  8436			},
  8437			INTERNAL,
  8438			{ },
  8439			{ { 0, 1 } },
  8440		},
  8441		/* BPF_JMP | BPF_JSLT | BPF_X */
  8442		{
  8443			"JMP_JSLT_X: Signed jump: if (-2 < -1) return 1",
  8444			.u.insns_int = {
  8445				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8446				BPF_LD_IMM64(R1, -1),
  8447				BPF_LD_IMM64(R2, -2),
  8448				BPF_JMP_REG(BPF_JSLT, R2, R1, 1),
  8449				BPF_EXIT_INSN(),
  8450				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8451				BPF_EXIT_INSN(),
  8452			},
  8453			INTERNAL,
  8454			{ },
  8455			{ { 0, 1 } },
  8456		},
  8457		{
  8458			"JMP_JSLT_X: Signed jump: if (-1 < -1) return 0",
  8459			.u.insns_int = {
  8460				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8461				BPF_LD_IMM64(R1, -1),
  8462				BPF_LD_IMM64(R2, -1),
  8463				BPF_JMP_REG(BPF_JSLT, R1, R2, 1),
  8464				BPF_EXIT_INSN(),
  8465				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8466				BPF_EXIT_INSN(),
  8467			},
  8468			INTERNAL,
  8469			{ },
  8470			{ { 0, 1 } },
  8471		},
  8472		/* BPF_JMP | BPF_JSGE | BPF_X */
  8473		{
  8474			"JMP_JSGE_X: Signed jump: if (-1 >= -2) return 1",
  8475			.u.insns_int = {
  8476				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8477				BPF_LD_IMM64(R1, -1),
  8478				BPF_LD_IMM64(R2, -2),
  8479				BPF_JMP_REG(BPF_JSGE, R1, R2, 1),
  8480				BPF_EXIT_INSN(),
  8481				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8482				BPF_EXIT_INSN(),
  8483			},
  8484			INTERNAL,
  8485			{ },
  8486			{ { 0, 1 } },
  8487		},
  8488		{
  8489			"JMP_JSGE_X: Signed jump: if (-1 >= -1) return 1",
  8490			.u.insns_int = {
  8491				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8492				BPF_LD_IMM64(R1, -1),
  8493				BPF_LD_IMM64(R2, -1),
  8494				BPF_JMP_REG(BPF_JSGE, R1, R2, 1),
  8495				BPF_EXIT_INSN(),
  8496				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8497				BPF_EXIT_INSN(),
  8498			},
  8499			INTERNAL,
  8500			{ },
  8501			{ { 0, 1 } },
  8502		},
  8503		/* BPF_JMP | BPF_JSLE | BPF_X */
  8504		{
  8505			"JMP_JSLE_X: Signed jump: if (-2 <= -1) return 1",
  8506			.u.insns_int = {
  8507				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8508				BPF_LD_IMM64(R1, -1),
  8509				BPF_LD_IMM64(R2, -2),
  8510				BPF_JMP_REG(BPF_JSLE, R2, R1, 1),
  8511				BPF_EXIT_INSN(),
  8512				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8513				BPF_EXIT_INSN(),
  8514			},
  8515			INTERNAL,
  8516			{ },
  8517			{ { 0, 1 } },
  8518		},
  8519		{
  8520			"JMP_JSLE_X: Signed jump: if (-1 <= -1) return 1",
  8521			.u.insns_int = {
  8522				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8523				BPF_LD_IMM64(R1, -1),
  8524				BPF_LD_IMM64(R2, -1),
  8525				BPF_JMP_REG(BPF_JSLE, R1, R2, 1),
  8526				BPF_EXIT_INSN(),
  8527				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8528				BPF_EXIT_INSN(),
  8529			},
  8530			INTERNAL,
  8531			{ },
  8532			{ { 0, 1 } },
  8533		},
  8534		/* BPF_JMP | BPF_JGT | BPF_X */
  8535		{
  8536			"JMP_JGT_X: if (3 > 2) return 1",
  8537			.u.insns_int = {
  8538				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8539				BPF_LD_IMM64(R1, 3),
  8540				BPF_LD_IMM64(R2, 2),
  8541				BPF_JMP_REG(BPF_JGT, R1, R2, 1),
  8542				BPF_EXIT_INSN(),
  8543				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8544				BPF_EXIT_INSN(),
  8545			},
  8546			INTERNAL,
  8547			{ },
  8548			{ { 0, 1 } },
  8549		},
  8550		{
  8551			"JMP_JGT_X: Unsigned jump: if (-1 > 1) return 1",
  8552			.u.insns_int = {
  8553				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8554				BPF_LD_IMM64(R1, -1),
  8555				BPF_LD_IMM64(R2, 1),
  8556				BPF_JMP_REG(BPF_JGT, R1, R2, 1),
  8557				BPF_EXIT_INSN(),
  8558				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8559				BPF_EXIT_INSN(),
  8560			},
  8561			INTERNAL,
  8562			{ },
  8563			{ { 0, 1 } },
  8564		},
  8565		/* BPF_JMP | BPF_JLT | BPF_X */
  8566		{
  8567			"JMP_JLT_X: if (2 < 3) return 1",
  8568			.u.insns_int = {
  8569				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8570				BPF_LD_IMM64(R1, 3),
  8571				BPF_LD_IMM64(R2, 2),
  8572				BPF_JMP_REG(BPF_JLT, R2, R1, 1),
  8573				BPF_EXIT_INSN(),
  8574				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8575				BPF_EXIT_INSN(),
  8576			},
  8577			INTERNAL,
  8578			{ },
  8579			{ { 0, 1 } },
  8580		},
  8581		{
  8582			"JMP_JLT_X: Unsigned jump: if (1 < -1) return 1",
  8583			.u.insns_int = {
  8584				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8585				BPF_LD_IMM64(R1, -1),
  8586				BPF_LD_IMM64(R2, 1),
  8587				BPF_JMP_REG(BPF_JLT, R2, R1, 1),
  8588				BPF_EXIT_INSN(),
  8589				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8590				BPF_EXIT_INSN(),
  8591			},
  8592			INTERNAL,
  8593			{ },
  8594			{ { 0, 1 } },
  8595		},
  8596		/* BPF_JMP | BPF_JGE | BPF_X */
  8597		{
  8598			"JMP_JGE_X: if (3 >= 2) return 1",
  8599			.u.insns_int = {
  8600				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8601				BPF_LD_IMM64(R1, 3),
  8602				BPF_LD_IMM64(R2, 2),
  8603				BPF_JMP_REG(BPF_JGE, R1, R2, 1),
  8604				BPF_EXIT_INSN(),
  8605				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8606				BPF_EXIT_INSN(),
  8607			},
  8608			INTERNAL,
  8609			{ },
  8610			{ { 0, 1 } },
  8611		},
  8612		{
  8613			"JMP_JGE_X: if (3 >= 3) return 1",
  8614			.u.insns_int = {
  8615				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8616				BPF_LD_IMM64(R1, 3),
  8617				BPF_LD_IMM64(R2, 3),
  8618				BPF_JMP_REG(BPF_JGE, R1, R2, 1),
  8619				BPF_EXIT_INSN(),
  8620				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8621				BPF_EXIT_INSN(),
  8622			},
  8623			INTERNAL,
  8624			{ },
  8625			{ { 0, 1 } },
  8626		},
  8627		/* BPF_JMP | BPF_JLE | BPF_X */
  8628		{
  8629			"JMP_JLE_X: if (2 <= 3) return 1",
  8630			.u.insns_int = {
  8631				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8632				BPF_LD_IMM64(R1, 3),
  8633				BPF_LD_IMM64(R2, 2),
  8634				BPF_JMP_REG(BPF_JLE, R2, R1, 1),
  8635				BPF_EXIT_INSN(),
  8636				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8637				BPF_EXIT_INSN(),
  8638			},
  8639			INTERNAL,
  8640			{ },
  8641			{ { 0, 1 } },
  8642		},
  8643		{
  8644			"JMP_JLE_X: if (3 <= 3) return 1",
  8645			.u.insns_int = {
  8646				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8647				BPF_LD_IMM64(R1, 3),
  8648				BPF_LD_IMM64(R2, 3),
  8649				BPF_JMP_REG(BPF_JLE, R1, R2, 1),
  8650				BPF_EXIT_INSN(),
  8651				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8652				BPF_EXIT_INSN(),
  8653			},
  8654			INTERNAL,
  8655			{ },
  8656			{ { 0, 1 } },
  8657		},
  8658		{
  8659			/* Mainly testing JIT + imm64 here. */
  8660			"JMP_JGE_X: ldimm64 test 1",
  8661			.u.insns_int = {
  8662				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8663				BPF_LD_IMM64(R1, 3),
  8664				BPF_LD_IMM64(R2, 2),
  8665				BPF_JMP_REG(BPF_JGE, R1, R2, 2),
  8666				BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
  8667				BPF_LD_IMM64(R0, 0xeeeeeeeeeeeeeeeeULL),
  8668				BPF_EXIT_INSN(),
  8669			},
  8670			INTERNAL,
  8671			{ },
  8672			{ { 0, 0xeeeeeeeeU } },
  8673		},
  8674		{
  8675			"JMP_JGE_X: ldimm64 test 2",
  8676			.u.insns_int = {
  8677				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8678				BPF_LD_IMM64(R1, 3),
  8679				BPF_LD_IMM64(R2, 2),
  8680				BPF_JMP_REG(BPF_JGE, R1, R2, 0),
  8681				BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
  8682				BPF_EXIT_INSN(),
  8683			},
  8684			INTERNAL,
  8685			{ },
  8686			{ { 0, 0xffffffffU } },
  8687		},
  8688		{
  8689			"JMP_JGE_X: ldimm64 test 3",
  8690			.u.insns_int = {
  8691				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8692				BPF_LD_IMM64(R1, 3),
  8693				BPF_LD_IMM64(R2, 2),
  8694				BPF_JMP_REG(BPF_JGE, R1, R2, 4),
  8695				BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
  8696				BPF_LD_IMM64(R0, 0xeeeeeeeeeeeeeeeeULL),
  8697				BPF_EXIT_INSN(),
  8698			},
  8699			INTERNAL,
  8700			{ },
  8701			{ { 0, 1 } },
  8702		},
  8703		{
  8704			"JMP_JLE_X: ldimm64 test 1",
  8705			.u.insns_int = {
  8706				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8707				BPF_LD_IMM64(R1, 3),
  8708				BPF_LD_IMM64(R2, 2),
  8709				BPF_JMP_REG(BPF_JLE, R2, R1, 2),
  8710				BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
  8711				BPF_LD_IMM64(R0, 0xeeeeeeeeeeeeeeeeULL),
  8712				BPF_EXIT_INSN(),
  8713			},
  8714			INTERNAL,
  8715			{ },
  8716			{ { 0, 0xeeeeeeeeU } },
  8717		},
  8718		{
  8719			"JMP_JLE_X: ldimm64 test 2",
  8720			.u.insns_int = {
  8721				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8722				BPF_LD_IMM64(R1, 3),
  8723				BPF_LD_IMM64(R2, 2),
  8724				BPF_JMP_REG(BPF_JLE, R2, R1, 0),
  8725				BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
  8726				BPF_EXIT_INSN(),
  8727			},
  8728			INTERNAL,
  8729			{ },
  8730			{ { 0, 0xffffffffU } },
  8731		},
  8732		{
  8733			"JMP_JLE_X: ldimm64 test 3",
  8734			.u.insns_int = {
  8735				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8736				BPF_LD_IMM64(R1, 3),
  8737				BPF_LD_IMM64(R2, 2),
  8738				BPF_JMP_REG(BPF_JLE, R2, R1, 4),
  8739				BPF_LD_IMM64(R0, 0xffffffffffffffffULL),
  8740				BPF_LD_IMM64(R0, 0xeeeeeeeeeeeeeeeeULL),
  8741				BPF_EXIT_INSN(),
  8742			},
  8743			INTERNAL,
  8744			{ },
  8745			{ { 0, 1 } },
  8746		},
  8747		/* BPF_JMP | BPF_JNE | BPF_X */
  8748		{
  8749			"JMP_JNE_X: if (3 != 2) return 1",
  8750			.u.insns_int = {
  8751				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8752				BPF_LD_IMM64(R1, 3),
  8753				BPF_LD_IMM64(R2, 2),
  8754				BPF_JMP_REG(BPF_JNE, R1, R2, 1),
  8755				BPF_EXIT_INSN(),
  8756				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8757				BPF_EXIT_INSN(),
  8758			},
  8759			INTERNAL,
  8760			{ },
  8761			{ { 0, 1 } },
  8762		},
  8763		/* BPF_JMP | BPF_JEQ | BPF_X */
  8764		{
  8765			"JMP_JEQ_X: if (3 == 3) return 1",
  8766			.u.insns_int = {
  8767				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8768				BPF_LD_IMM64(R1, 3),
  8769				BPF_LD_IMM64(R2, 3),
  8770				BPF_JMP_REG(BPF_JEQ, R1, R2, 1),
  8771				BPF_EXIT_INSN(),
  8772				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8773				BPF_EXIT_INSN(),
  8774			},
  8775			INTERNAL,
  8776			{ },
  8777			{ { 0, 1 } },
  8778		},
  8779		/* BPF_JMP | BPF_JSET | BPF_X */
  8780		{
  8781			"JMP_JSET_X: if (0x3 & 0x2) return 1",
  8782			.u.insns_int = {
  8783				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8784				BPF_LD_IMM64(R1, 3),
  8785				BPF_LD_IMM64(R2, 2),
  8786				BPF_JMP_REG(BPF_JSET, R1, R2, 1),
  8787				BPF_EXIT_INSN(),
  8788				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8789				BPF_EXIT_INSN(),
  8790			},
  8791			INTERNAL,
  8792			{ },
  8793			{ { 0, 1 } },
  8794		},
  8795		{
  8796			"JMP_JSET_X: if (0x3 & 0xffffffff) return 1",
  8797			.u.insns_int = {
  8798				BPF_ALU32_IMM(BPF_MOV, R0, 0),
  8799				BPF_LD_IMM64(R1, 3),
  8800				BPF_LD_IMM64(R2, 0xffffffff),
  8801				BPF_JMP_REG(BPF_JSET, R1, R2, 1),
  8802				BPF_EXIT_INSN(),
  8803				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  8804				BPF_EXIT_INSN(),
  8805			},
  8806			INTERNAL,
  8807			{ },
  8808			{ { 0, 1 } },
  8809		},
  8810		{
  8811			"JMP_JA: Jump, gap, jump, ...",
  8812			{ },
  8813			CLASSIC | FLAG_NO_DATA,
  8814			{ },
  8815			{ { 0, 0xababcbac } },
  8816			.fill_helper = bpf_fill_ja,
  8817		},
  8818		{	/* Mainly checking JIT here. */
  8819			"BPF_MAXINSNS: Maximum possible literals",
  8820			{ },
  8821			CLASSIC | FLAG_NO_DATA,
  8822			{ },
  8823			{ { 0, 0xffffffff } },
  8824			.fill_helper = bpf_fill_maxinsns1,
  8825		},
  8826		{	/* Mainly checking JIT here. */
  8827			"BPF_MAXINSNS: Single literal",
  8828			{ },
  8829			CLASSIC | FLAG_NO_DATA,
  8830			{ },
  8831			{ { 0, 0xfefefefe } },
  8832			.fill_helper = bpf_fill_maxinsns2,
  8833		},
  8834		{	/* Mainly checking JIT here. */
  8835			"BPF_MAXINSNS: Run/add until end",
  8836			{ },
  8837			CLASSIC | FLAG_NO_DATA,
  8838			{ },
  8839			{ { 0, 0x947bf368 } },
  8840			.fill_helper = bpf_fill_maxinsns3,
  8841		},
  8842		{
  8843			"BPF_MAXINSNS: Too many instructions",
  8844			{ },
  8845			CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
  8846			{ },
  8847			{ },
  8848			.fill_helper = bpf_fill_maxinsns4,
  8849			.expected_errcode = -EINVAL,
  8850		},
  8851		{	/* Mainly checking JIT here. */
  8852			"BPF_MAXINSNS: Very long jump",
  8853			{ },
  8854			CLASSIC | FLAG_NO_DATA,
  8855			{ },
  8856			{ { 0, 0xabababab } },
  8857			.fill_helper = bpf_fill_maxinsns5,
  8858		},
  8859		{	/* Mainly checking JIT here. */
  8860			"BPF_MAXINSNS: Ctx heavy transformations",
  8861			{ },
  8862			CLASSIC,
  8863			{ },
  8864			{
  8865				{  1, SKB_VLAN_PRESENT },
  8866				{ 10, SKB_VLAN_PRESENT }
  8867			},
  8868			.fill_helper = bpf_fill_maxinsns6,
  8869		},
  8870		{	/* Mainly checking JIT here. */
  8871			"BPF_MAXINSNS: Call heavy transformations",
  8872			{ },
  8873			CLASSIC | FLAG_NO_DATA,
  8874			{ },
  8875			{ { 1, 0 }, { 10, 0 } },
  8876			.fill_helper = bpf_fill_maxinsns7,
  8877		},
  8878		{	/* Mainly checking JIT here. */
  8879			"BPF_MAXINSNS: Jump heavy test",
  8880			{ },
  8881			CLASSIC | FLAG_NO_DATA,
  8882			{ },
  8883			{ { 0, 0xffffffff } },
  8884			.fill_helper = bpf_fill_maxinsns8,
  8885		},
  8886		{	/* Mainly checking JIT here. */
  8887			"BPF_MAXINSNS: Very long jump backwards",
  8888			{ },
  8889			INTERNAL | FLAG_NO_DATA,
  8890			{ },
  8891			{ { 0, 0xcbababab } },
  8892			.fill_helper = bpf_fill_maxinsns9,
  8893		},
  8894		{	/* Mainly checking JIT here. */
  8895			"BPF_MAXINSNS: Edge hopping nuthouse",
  8896			{ },
  8897			INTERNAL | FLAG_NO_DATA,
  8898			{ },
  8899			{ { 0, 0xabababac } },
  8900			.fill_helper = bpf_fill_maxinsns10,
  8901		},
  8902		{
  8903			"BPF_MAXINSNS: Jump, gap, jump, ...",
  8904			{ },
  8905			CLASSIC | FLAG_NO_DATA,
  8906			{ },
  8907			{ { 0, 0xababcbac } },
  8908			.fill_helper = bpf_fill_maxinsns11,
  8909		},
  8910		{
  8911			"BPF_MAXINSNS: jump over MSH",
  8912			{ },
  8913			CLASSIC | FLAG_EXPECTED_FAIL,
  8914			{ 0xfa, 0xfb, 0xfc, 0xfd, },
  8915			{ { 4, 0xabababab } },
  8916			.fill_helper = bpf_fill_maxinsns12,
  8917			.expected_errcode = -EINVAL,
  8918		},
  8919		{
  8920			"BPF_MAXINSNS: exec all MSH",
  8921			{ },
  8922			CLASSIC,
  8923			{ 0xfa, 0xfb, 0xfc, 0xfd, },
  8924			{ { 4, 0xababab83 } },
  8925			.fill_helper = bpf_fill_maxinsns13,
  8926		},
  8927		{
  8928			"BPF_MAXINSNS: ld_abs+get_processor_id",
  8929			{ },
  8930			CLASSIC,
  8931			{ },
  8932			{ { 1, 0xbee } },
  8933			.fill_helper = bpf_fill_ld_abs_get_processor_id,
  8934		},
  8935		/*
  8936		 * LD_IND / LD_ABS on fragmented SKBs
  8937		 */
  8938		{
  8939			"LD_IND byte frag",
  8940			.u.insns = {
  8941				BPF_STMT(BPF_LDX | BPF_IMM, 0x40),
  8942				BPF_STMT(BPF_LD | BPF_IND | BPF_B, 0x0),
  8943				BPF_STMT(BPF_RET | BPF_A, 0x0),
  8944			},
  8945			CLASSIC | FLAG_SKB_FRAG,
  8946			{ },
  8947			{ {0x40, 0x42} },
  8948			.frag_data = {
  8949				0x42, 0x00, 0x00, 0x00,
  8950				0x43, 0x44, 0x00, 0x00,
  8951				0x21, 0x07, 0x19, 0x83,
  8952			},
  8953		},
  8954		{
  8955			"LD_IND halfword frag",
  8956			.u.insns = {
  8957				BPF_STMT(BPF_LDX | BPF_IMM, 0x40),
  8958				BPF_STMT(BPF_LD | BPF_IND | BPF_H, 0x4),
  8959				BPF_STMT(BPF_RET | BPF_A, 0x0),
  8960			},
  8961			CLASSIC | FLAG_SKB_FRAG,
  8962			{ },
  8963			{ {0x40, 0x4344} },
  8964			.frag_data = {
  8965				0x42, 0x00, 0x00, 0x00,
  8966				0x43, 0x44, 0x00, 0x00,
  8967				0x21, 0x07, 0x19, 0x83,
  8968			},
  8969		},
  8970		{
  8971			"LD_IND word frag",
  8972			.u.insns = {
  8973				BPF_STMT(BPF_LDX | BPF_IMM, 0x40),
  8974				BPF_STMT(BPF_LD | BPF_IND | BPF_W, 0x8),
  8975				BPF_STMT(BPF_RET | BPF_A, 0x0),
  8976			},
  8977			CLASSIC | FLAG_SKB_FRAG,
  8978			{ },
  8979			{ {0x40, 0x21071983} },
  8980			.frag_data = {
  8981				0x42, 0x00, 0x00, 0x00,
  8982				0x43, 0x44, 0x00, 0x00,
  8983				0x21, 0x07, 0x19, 0x83,
  8984			},
  8985		},
  8986		{
  8987			"LD_IND halfword mixed head/frag",
  8988			.u.insns = {
  8989				BPF_STMT(BPF_LDX | BPF_IMM, 0x40),
  8990				BPF_STMT(BPF_LD | BPF_IND | BPF_H, -0x1),
  8991				BPF_STMT(BPF_RET | BPF_A, 0x0),
  8992			},
  8993			CLASSIC | FLAG_SKB_FRAG,
  8994			{ [0x3e] = 0x25, [0x3f] = 0x05, },
  8995			{ {0x40, 0x0519} },
  8996			.frag_data = { 0x19, 0x82 },
  8997		},
  8998		{
  8999			"LD_IND word mixed head/frag",
  9000			.u.insns = {
  9001				BPF_STMT(BPF_LDX | BPF_IMM, 0x40),
  9002				BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x2),
  9003				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9004			},
  9005			CLASSIC | FLAG_SKB_FRAG,
  9006			{ [0x3e] = 0x25, [0x3f] = 0x05, },
  9007			{ {0x40, 0x25051982} },
  9008			.frag_data = { 0x19, 0x82 },
  9009		},
  9010		{
  9011			"LD_ABS byte frag",
  9012			.u.insns = {
  9013				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, 0x40),
  9014				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9015			},
  9016			CLASSIC | FLAG_SKB_FRAG,
  9017			{ },
  9018			{ {0x40, 0x42} },
  9019			.frag_data = {
  9020				0x42, 0x00, 0x00, 0x00,
  9021				0x43, 0x44, 0x00, 0x00,
  9022				0x21, 0x07, 0x19, 0x83,
  9023			},
  9024		},
  9025		{
  9026			"LD_ABS halfword frag",
  9027			.u.insns = {
  9028				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x44),
  9029				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9030			},
  9031			CLASSIC | FLAG_SKB_FRAG,
  9032			{ },
  9033			{ {0x40, 0x4344} },
  9034			.frag_data = {
  9035				0x42, 0x00, 0x00, 0x00,
  9036				0x43, 0x44, 0x00, 0x00,
  9037				0x21, 0x07, 0x19, 0x83,
  9038			},
  9039		},
  9040		{
  9041			"LD_ABS word frag",
  9042			.u.insns = {
  9043				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x48),
  9044				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9045			},
  9046			CLASSIC | FLAG_SKB_FRAG,
  9047			{ },
  9048			{ {0x40, 0x21071983} },
  9049			.frag_data = {
  9050				0x42, 0x00, 0x00, 0x00,
  9051				0x43, 0x44, 0x00, 0x00,
  9052				0x21, 0x07, 0x19, 0x83,
  9053			},
  9054		},
  9055		{
  9056			"LD_ABS halfword mixed head/frag",
  9057			.u.insns = {
  9058				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x3f),
  9059				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9060			},
  9061			CLASSIC | FLAG_SKB_FRAG,
  9062			{ [0x3e] = 0x25, [0x3f] = 0x05, },
  9063			{ {0x40, 0x0519} },
  9064			.frag_data = { 0x19, 0x82 },
  9065		},
  9066		{
  9067			"LD_ABS word mixed head/frag",
  9068			.u.insns = {
  9069				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x3e),
  9070				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9071			},
  9072			CLASSIC | FLAG_SKB_FRAG,
  9073			{ [0x3e] = 0x25, [0x3f] = 0x05, },
  9074			{ {0x40, 0x25051982} },
  9075			.frag_data = { 0x19, 0x82 },
  9076		},
  9077		/*
  9078		 * LD_IND / LD_ABS on non fragmented SKBs
  9079		 */
  9080		{
  9081			/*
  9082			 * this tests that the JIT/interpreter correctly resets X
  9083			 * before using it in an LD_IND instruction.
  9084			 */
  9085			"LD_IND byte default X",
  9086			.u.insns = {
  9087				BPF_STMT(BPF_LD | BPF_IND | BPF_B, 0x1),
  9088				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9089			},
  9090			CLASSIC,
  9091			{ [0x1] = 0x42 },
  9092			{ {0x40, 0x42 } },
  9093		},
  9094		{
  9095			"LD_IND byte positive offset",
  9096			.u.insns = {
  9097				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9098				BPF_STMT(BPF_LD | BPF_IND | BPF_B, 0x1),
  9099				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9100			},
  9101			CLASSIC,
  9102			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9103			{ {0x40, 0x82 } },
  9104		},
  9105		{
  9106			"LD_IND byte negative offset",
  9107			.u.insns = {
  9108				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9109				BPF_STMT(BPF_LD | BPF_IND | BPF_B, -0x1),
  9110				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9111			},
  9112			CLASSIC,
  9113			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9114			{ {0x40, 0x05 } },
  9115		},
  9116		{
  9117			"LD_IND byte positive offset, all ff",
  9118			.u.insns = {
  9119				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9120				BPF_STMT(BPF_LD | BPF_IND | BPF_B, 0x1),
  9121				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9122			},
  9123			CLASSIC,
  9124			{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
  9125			{ {0x40, 0xff } },
  9126		},
  9127		{
  9128			"LD_IND byte positive offset, out of bounds",
  9129			.u.insns = {
  9130				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9131				BPF_STMT(BPF_LD | BPF_IND | BPF_B, 0x1),
  9132				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9133			},
  9134			CLASSIC,
  9135			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9136			{ {0x3f, 0 }, },
  9137		},
  9138		{
  9139			"LD_IND byte negative offset, out of bounds",
  9140			.u.insns = {
  9141				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9142				BPF_STMT(BPF_LD | BPF_IND | BPF_B, -0x3f),
  9143				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9144			},
  9145			CLASSIC,
  9146			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9147			{ {0x3f, 0 } },
  9148		},
  9149		{
  9150			"LD_IND byte negative offset, multiple calls",
  9151			.u.insns = {
  9152				BPF_STMT(BPF_LDX | BPF_IMM, 0x3b),
  9153				BPF_STMT(BPF_LD | BPF_IND | BPF_B, SKF_LL_OFF + 1),
  9154				BPF_STMT(BPF_LD | BPF_IND | BPF_B, SKF_LL_OFF + 2),
  9155				BPF_STMT(BPF_LD | BPF_IND | BPF_B, SKF_LL_OFF + 3),
  9156				BPF_STMT(BPF_LD | BPF_IND | BPF_B, SKF_LL_OFF + 4),
  9157				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9158			},
  9159			CLASSIC,
  9160			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9161			{ {0x40, 0x82 }, },
  9162		},
  9163		{
  9164			"LD_IND halfword positive offset",
  9165			.u.insns = {
  9166				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  9167				BPF_STMT(BPF_LD | BPF_IND | BPF_H, 0x2),
  9168				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9169			},
  9170			CLASSIC,
  9171			{
  9172				[0x1c] = 0xaa, [0x1d] = 0x55,
  9173				[0x1e] = 0xbb, [0x1f] = 0x66,
  9174				[0x20] = 0xcc, [0x21] = 0x77,
  9175				[0x22] = 0xdd, [0x23] = 0x88,
  9176			},
  9177			{ {0x40, 0xdd88 } },
  9178		},
  9179		{
  9180			"LD_IND halfword negative offset",
  9181			.u.insns = {
  9182				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  9183				BPF_STMT(BPF_LD | BPF_IND | BPF_H, -0x2),
  9184				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9185			},
  9186			CLASSIC,
  9187			{
  9188				[0x1c] = 0xaa, [0x1d] = 0x55,
  9189				[0x1e] = 0xbb, [0x1f] = 0x66,
  9190				[0x20] = 0xcc, [0x21] = 0x77,
  9191				[0x22] = 0xdd, [0x23] = 0x88,
  9192			},
  9193			{ {0x40, 0xbb66 } },
  9194		},
  9195		{
  9196			"LD_IND halfword unaligned",
  9197			.u.insns = {
  9198				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  9199				BPF_STMT(BPF_LD | BPF_IND | BPF_H, -0x1),
  9200				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9201			},
  9202			CLASSIC,
  9203			{
  9204				[0x1c] = 0xaa, [0x1d] = 0x55,
  9205				[0x1e] = 0xbb, [0x1f] = 0x66,
  9206				[0x20] = 0xcc, [0x21] = 0x77,
  9207				[0x22] = 0xdd, [0x23] = 0x88,
  9208			},
  9209			{ {0x40, 0x66cc } },
  9210		},
  9211		{
  9212			"LD_IND halfword positive offset, all ff",
  9213			.u.insns = {
  9214				BPF_STMT(BPF_LDX | BPF_IMM, 0x3d),
  9215				BPF_STMT(BPF_LD | BPF_IND | BPF_H, 0x1),
  9216				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9217			},
  9218			CLASSIC,
  9219			{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
  9220			{ {0x40, 0xffff } },
  9221		},
  9222		{
  9223			"LD_IND halfword positive offset, out of bounds",
  9224			.u.insns = {
  9225				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9226				BPF_STMT(BPF_LD | BPF_IND | BPF_H, 0x1),
  9227				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9228			},
  9229			CLASSIC,
  9230			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9231			{ {0x3f, 0 }, },
  9232		},
  9233		{
  9234			"LD_IND halfword negative offset, out of bounds",
  9235			.u.insns = {
  9236				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9237				BPF_STMT(BPF_LD | BPF_IND | BPF_H, -0x3f),
  9238				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9239			},
  9240			CLASSIC,
  9241			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9242			{ {0x3f, 0 } },
  9243		},
  9244		{
  9245			"LD_IND word positive offset",
  9246			.u.insns = {
  9247				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  9248				BPF_STMT(BPF_LD | BPF_IND | BPF_W, 0x4),
  9249				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9250			},
  9251			CLASSIC,
  9252			{
  9253				[0x1c] = 0xaa, [0x1d] = 0x55,
  9254				[0x1e] = 0xbb, [0x1f] = 0x66,
  9255				[0x20] = 0xcc, [0x21] = 0x77,
  9256				[0x22] = 0xdd, [0x23] = 0x88,
  9257				[0x24] = 0xee, [0x25] = 0x99,
  9258				[0x26] = 0xff, [0x27] = 0xaa,
  9259			},
  9260			{ {0x40, 0xee99ffaa } },
  9261		},
  9262		{
  9263			"LD_IND word negative offset",
  9264			.u.insns = {
  9265				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  9266				BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x4),
  9267				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9268			},
  9269			CLASSIC,
  9270			{
  9271				[0x1c] = 0xaa, [0x1d] = 0x55,
  9272				[0x1e] = 0xbb, [0x1f] = 0x66,
  9273				[0x20] = 0xcc, [0x21] = 0x77,
  9274				[0x22] = 0xdd, [0x23] = 0x88,
  9275				[0x24] = 0xee, [0x25] = 0x99,
  9276				[0x26] = 0xff, [0x27] = 0xaa,
  9277			},
  9278			{ {0x40, 0xaa55bb66 } },
  9279		},
  9280		{
  9281			"LD_IND word unaligned (addr & 3 == 2)",
  9282			.u.insns = {
  9283				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  9284				BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x2),
  9285				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9286			},
  9287			CLASSIC,
  9288			{
  9289				[0x1c] = 0xaa, [0x1d] = 0x55,
  9290				[0x1e] = 0xbb, [0x1f] = 0x66,
  9291				[0x20] = 0xcc, [0x21] = 0x77,
  9292				[0x22] = 0xdd, [0x23] = 0x88,
  9293				[0x24] = 0xee, [0x25] = 0x99,
  9294				[0x26] = 0xff, [0x27] = 0xaa,
  9295			},
  9296			{ {0x40, 0xbb66cc77 } },
  9297		},
  9298		{
  9299			"LD_IND word unaligned (addr & 3 == 1)",
  9300			.u.insns = {
  9301				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  9302				BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x3),
  9303				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9304			},
  9305			CLASSIC,
  9306			{
  9307				[0x1c] = 0xaa, [0x1d] = 0x55,
  9308				[0x1e] = 0xbb, [0x1f] = 0x66,
  9309				[0x20] = 0xcc, [0x21] = 0x77,
  9310				[0x22] = 0xdd, [0x23] = 0x88,
  9311				[0x24] = 0xee, [0x25] = 0x99,
  9312				[0x26] = 0xff, [0x27] = 0xaa,
  9313			},
  9314			{ {0x40, 0x55bb66cc } },
  9315		},
  9316		{
  9317			"LD_IND word unaligned (addr & 3 == 3)",
  9318			.u.insns = {
  9319				BPF_STMT(BPF_LDX | BPF_IMM, 0x20),
  9320				BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x1),
  9321				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9322			},
  9323			CLASSIC,
  9324			{
  9325				[0x1c] = 0xaa, [0x1d] = 0x55,
  9326				[0x1e] = 0xbb, [0x1f] = 0x66,
  9327				[0x20] = 0xcc, [0x21] = 0x77,
  9328				[0x22] = 0xdd, [0x23] = 0x88,
  9329				[0x24] = 0xee, [0x25] = 0x99,
  9330				[0x26] = 0xff, [0x27] = 0xaa,
  9331			},
  9332			{ {0x40, 0x66cc77dd } },
  9333		},
  9334		{
  9335			"LD_IND word positive offset, all ff",
  9336			.u.insns = {
  9337				BPF_STMT(BPF_LDX | BPF_IMM, 0x3b),
  9338				BPF_STMT(BPF_LD | BPF_IND | BPF_W, 0x1),
  9339				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9340			},
  9341			CLASSIC,
  9342			{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
  9343			{ {0x40, 0xffffffff } },
  9344		},
  9345		{
  9346			"LD_IND word positive offset, out of bounds",
  9347			.u.insns = {
  9348				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9349				BPF_STMT(BPF_LD | BPF_IND | BPF_W, 0x1),
  9350				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9351			},
  9352			CLASSIC,
  9353			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9354			{ {0x3f, 0 }, },
  9355		},
  9356		{
  9357			"LD_IND word negative offset, out of bounds",
  9358			.u.insns = {
  9359				BPF_STMT(BPF_LDX | BPF_IMM, 0x3e),
  9360				BPF_STMT(BPF_LD | BPF_IND | BPF_W, -0x3f),
  9361				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9362			},
  9363			CLASSIC,
  9364			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9365			{ {0x3f, 0 } },
  9366		},
  9367		{
  9368			"LD_ABS byte",
  9369			.u.insns = {
  9370				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, 0x20),
  9371				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9372			},
  9373			CLASSIC,
  9374			{
  9375				[0x1c] = 0xaa, [0x1d] = 0x55,
  9376				[0x1e] = 0xbb, [0x1f] = 0x66,
  9377				[0x20] = 0xcc, [0x21] = 0x77,
  9378				[0x22] = 0xdd, [0x23] = 0x88,
  9379				[0x24] = 0xee, [0x25] = 0x99,
  9380				[0x26] = 0xff, [0x27] = 0xaa,
  9381			},
  9382			{ {0x40, 0xcc } },
  9383		},
  9384		{
  9385			"LD_ABS byte positive offset, all ff",
  9386			.u.insns = {
  9387				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, 0x3f),
  9388				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9389			},
  9390			CLASSIC,
  9391			{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
  9392			{ {0x40, 0xff } },
  9393		},
  9394		{
  9395			"LD_ABS byte positive offset, out of bounds",
  9396			.u.insns = {
  9397				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, 0x3f),
  9398				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9399			},
  9400			CLASSIC,
  9401			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9402			{ {0x3f, 0 }, },
  9403		},
  9404		{
  9405			"LD_ABS byte negative offset, out of bounds load",
  9406			.u.insns = {
  9407				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, -1),
  9408				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9409			},
  9410			CLASSIC | FLAG_EXPECTED_FAIL,
  9411			.expected_errcode = -EINVAL,
  9412		},
  9413		{
  9414			"LD_ABS byte negative offset, in bounds",
  9415			.u.insns = {
  9416				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3f),
  9417				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9418			},
  9419			CLASSIC,
  9420			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9421			{ {0x40, 0x82 }, },
  9422		},
  9423		{
  9424			"LD_ABS byte negative offset, out of bounds",
  9425			.u.insns = {
  9426				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3f),
  9427				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9428			},
  9429			CLASSIC,
  9430			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9431			{ {0x3f, 0 }, },
  9432		},
  9433		{
  9434			"LD_ABS byte negative offset, multiple calls",
  9435			.u.insns = {
  9436				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3c),
  9437				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3d),
  9438				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3e),
  9439				BPF_STMT(BPF_LD | BPF_ABS | BPF_B, SKF_LL_OFF + 0x3f),
  9440				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9441			},
  9442			CLASSIC,
  9443			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9444			{ {0x40, 0x82 }, },
  9445		},
  9446		{
  9447			"LD_ABS halfword",
  9448			.u.insns = {
  9449				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x22),
  9450				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9451			},
  9452			CLASSIC,
  9453			{
  9454				[0x1c] = 0xaa, [0x1d] = 0x55,
  9455				[0x1e] = 0xbb, [0x1f] = 0x66,
  9456				[0x20] = 0xcc, [0x21] = 0x77,
  9457				[0x22] = 0xdd, [0x23] = 0x88,
  9458				[0x24] = 0xee, [0x25] = 0x99,
  9459				[0x26] = 0xff, [0x27] = 0xaa,
  9460			},
  9461			{ {0x40, 0xdd88 } },
  9462		},
  9463		{
  9464			"LD_ABS halfword unaligned",
  9465			.u.insns = {
  9466				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x25),
  9467				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9468			},
  9469			CLASSIC,
  9470			{
  9471				[0x1c] = 0xaa, [0x1d] = 0x55,
  9472				[0x1e] = 0xbb, [0x1f] = 0x66,
  9473				[0x20] = 0xcc, [0x21] = 0x77,
  9474				[0x22] = 0xdd, [0x23] = 0x88,
  9475				[0x24] = 0xee, [0x25] = 0x99,
  9476				[0x26] = 0xff, [0x27] = 0xaa,
  9477			},
  9478			{ {0x40, 0x99ff } },
  9479		},
  9480		{
  9481			"LD_ABS halfword positive offset, all ff",
  9482			.u.insns = {
  9483				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x3e),
  9484				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9485			},
  9486			CLASSIC,
  9487			{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
  9488			{ {0x40, 0xffff } },
  9489		},
  9490		{
  9491			"LD_ABS halfword positive offset, out of bounds",
  9492			.u.insns = {
  9493				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, 0x3f),
  9494				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9495			},
  9496			CLASSIC,
  9497			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9498			{ {0x3f, 0 }, },
  9499		},
  9500		{
  9501			"LD_ABS halfword negative offset, out of bounds load",
  9502			.u.insns = {
  9503				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, -1),
  9504				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9505			},
  9506			CLASSIC | FLAG_EXPECTED_FAIL,
  9507			.expected_errcode = -EINVAL,
  9508		},
  9509		{
  9510			"LD_ABS halfword negative offset, in bounds",
  9511			.u.insns = {
  9512				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, SKF_LL_OFF + 0x3e),
  9513				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9514			},
  9515			CLASSIC,
  9516			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9517			{ {0x40, 0x1982 }, },
  9518		},
  9519		{
  9520			"LD_ABS halfword negative offset, out of bounds",
  9521			.u.insns = {
  9522				BPF_STMT(BPF_LD | BPF_ABS | BPF_H, SKF_LL_OFF + 0x3e),
  9523				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9524			},
  9525			CLASSIC,
  9526			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9527			{ {0x3f, 0 }, },
  9528		},
  9529		{
  9530			"LD_ABS word",
  9531			.u.insns = {
  9532				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x1c),
  9533				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9534			},
  9535			CLASSIC,
  9536			{
  9537				[0x1c] = 0xaa, [0x1d] = 0x55,
  9538				[0x1e] = 0xbb, [0x1f] = 0x66,
  9539				[0x20] = 0xcc, [0x21] = 0x77,
  9540				[0x22] = 0xdd, [0x23] = 0x88,
  9541				[0x24] = 0xee, [0x25] = 0x99,
  9542				[0x26] = 0xff, [0x27] = 0xaa,
  9543			},
  9544			{ {0x40, 0xaa55bb66 } },
  9545		},
  9546		{
  9547			"LD_ABS word unaligned (addr & 3 == 2)",
  9548			.u.insns = {
  9549				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x22),
  9550				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9551			},
  9552			CLASSIC,
  9553			{
  9554				[0x1c] = 0xaa, [0x1d] = 0x55,
  9555				[0x1e] = 0xbb, [0x1f] = 0x66,
  9556				[0x20] = 0xcc, [0x21] = 0x77,
  9557				[0x22] = 0xdd, [0x23] = 0x88,
  9558				[0x24] = 0xee, [0x25] = 0x99,
  9559				[0x26] = 0xff, [0x27] = 0xaa,
  9560			},
  9561			{ {0x40, 0xdd88ee99 } },
  9562		},
  9563		{
  9564			"LD_ABS word unaligned (addr & 3 == 1)",
  9565			.u.insns = {
  9566				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x21),
  9567				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9568			},
  9569			CLASSIC,
  9570			{
  9571				[0x1c] = 0xaa, [0x1d] = 0x55,
  9572				[0x1e] = 0xbb, [0x1f] = 0x66,
  9573				[0x20] = 0xcc, [0x21] = 0x77,
  9574				[0x22] = 0xdd, [0x23] = 0x88,
  9575				[0x24] = 0xee, [0x25] = 0x99,
  9576				[0x26] = 0xff, [0x27] = 0xaa,
  9577			},
  9578			{ {0x40, 0x77dd88ee } },
  9579		},
  9580		{
  9581			"LD_ABS word unaligned (addr & 3 == 3)",
  9582			.u.insns = {
  9583				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x23),
  9584				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9585			},
  9586			CLASSIC,
  9587			{
  9588				[0x1c] = 0xaa, [0x1d] = 0x55,
  9589				[0x1e] = 0xbb, [0x1f] = 0x66,
  9590				[0x20] = 0xcc, [0x21] = 0x77,
  9591				[0x22] = 0xdd, [0x23] = 0x88,
  9592				[0x24] = 0xee, [0x25] = 0x99,
  9593				[0x26] = 0xff, [0x27] = 0xaa,
  9594			},
  9595			{ {0x40, 0x88ee99ff } },
  9596		},
  9597		{
  9598			"LD_ABS word positive offset, all ff",
  9599			.u.insns = {
  9600				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x3c),
  9601				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9602			},
  9603			CLASSIC,
  9604			{ [0x3c] = 0xff, [0x3d] = 0xff,  [0x3e] = 0xff, [0x3f] = 0xff },
  9605			{ {0x40, 0xffffffff } },
  9606		},
  9607		{
  9608			"LD_ABS word positive offset, out of bounds",
  9609			.u.insns = {
  9610				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, 0x3f),
  9611				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9612			},
  9613			CLASSIC,
  9614			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9615			{ {0x3f, 0 }, },
  9616		},
  9617		{
  9618			"LD_ABS word negative offset, out of bounds load",
  9619			.u.insns = {
  9620				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, -1),
  9621				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9622			},
  9623			CLASSIC | FLAG_EXPECTED_FAIL,
  9624			.expected_errcode = -EINVAL,
  9625		},
  9626		{
  9627			"LD_ABS word negative offset, in bounds",
  9628			.u.insns = {
  9629				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, SKF_LL_OFF + 0x3c),
  9630				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9631			},
  9632			CLASSIC,
  9633			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9634			{ {0x40, 0x25051982 }, },
  9635		},
  9636		{
  9637			"LD_ABS word negative offset, out of bounds",
  9638			.u.insns = {
  9639				BPF_STMT(BPF_LD | BPF_ABS | BPF_W, SKF_LL_OFF + 0x3c),
  9640				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9641			},
  9642			CLASSIC,
  9643			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9644			{ {0x3f, 0 }, },
  9645		},
  9646		{
  9647			"LDX_MSH standalone, preserved A",
  9648			.u.insns = {
  9649				BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
  9650				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3c),
  9651				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9652			},
  9653			CLASSIC,
  9654			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9655			{ {0x40, 0xffeebbaa }, },
  9656		},
  9657		{
  9658			"LDX_MSH standalone, preserved A 2",
  9659			.u.insns = {
  9660				BPF_STMT(BPF_LD | BPF_IMM, 0x175e9d63),
  9661				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3c),
  9662				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3d),
  9663				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3e),
  9664				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3f),
  9665				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9666			},
  9667			CLASSIC,
  9668			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9669			{ {0x40, 0x175e9d63 }, },
  9670		},
  9671		{
  9672			"LDX_MSH standalone, test result 1",
  9673			.u.insns = {
  9674				BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
  9675				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3c),
  9676				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  9677				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9678			},
  9679			CLASSIC,
  9680			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9681			{ {0x40, 0x14 }, },
  9682		},
  9683		{
  9684			"LDX_MSH standalone, test result 2",
  9685			.u.insns = {
  9686				BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
  9687				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x3e),
  9688				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  9689				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9690			},
  9691			CLASSIC,
  9692			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9693			{ {0x40, 0x24 }, },
  9694		},
  9695		{
  9696			"LDX_MSH standalone, negative offset",
  9697			.u.insns = {
  9698				BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
  9699				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, -1),
  9700				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  9701				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9702			},
  9703			CLASSIC,
  9704			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9705			{ {0x40, 0 }, },
  9706		},
  9707		{
  9708			"LDX_MSH standalone, negative offset 2",
  9709			.u.insns = {
  9710				BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
  9711				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, SKF_LL_OFF + 0x3e),
  9712				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  9713				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9714			},
  9715			CLASSIC,
  9716			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9717			{ {0x40, 0x24 }, },
  9718		},
  9719		{
  9720			"LDX_MSH standalone, out of bounds",
  9721			.u.insns = {
  9722				BPF_STMT(BPF_LD | BPF_IMM, 0xffeebbaa),
  9723				BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0x40),
  9724				BPF_STMT(BPF_MISC | BPF_TXA, 0),
  9725				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9726			},
  9727			CLASSIC,
  9728			{ [0x3c] = 0x25, [0x3d] = 0x05,  [0x3e] = 0x19, [0x3f] = 0x82 },
  9729			{ {0x40, 0 }, },
  9730		},
  9731		/*
  9732		 * verify that the interpreter or JIT correctly sets A and X
  9733		 * to 0.
  9734		 */
  9735		{
  9736			"ADD default X",
  9737			.u.insns = {
  9738				/*
  9739				 * A = 0x42
  9740				 * A = A + X
  9741				 * ret A
  9742				 */
  9743				BPF_STMT(BPF_LD | BPF_IMM, 0x42),
  9744				BPF_STMT(BPF_ALU | BPF_ADD | BPF_X, 0),
  9745				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9746			},
  9747			CLASSIC | FLAG_NO_DATA,
  9748			{},
  9749			{ {0x1, 0x42 } },
  9750		},
  9751		{
  9752			"ADD default A",
  9753			.u.insns = {
  9754				/*
  9755				 * A = A + 0x42
  9756				 * ret A
  9757				 */
  9758				BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 0x42),
  9759				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9760			},
  9761			CLASSIC | FLAG_NO_DATA,
  9762			{},
  9763			{ {0x1, 0x42 } },
  9764		},
  9765		{
  9766			"SUB default X",
  9767			.u.insns = {
  9768				/*
  9769				 * A = 0x66
  9770				 * A = A - X
  9771				 * ret A
  9772				 */
  9773				BPF_STMT(BPF_LD | BPF_IMM, 0x66),
  9774				BPF_STMT(BPF_ALU | BPF_SUB | BPF_X, 0),
  9775				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9776			},
  9777			CLASSIC | FLAG_NO_DATA,
  9778			{},
  9779			{ {0x1, 0x66 } },
  9780		},
  9781		{
  9782			"SUB default A",
  9783			.u.insns = {
  9784				/*
  9785				 * A = A - -0x66
  9786				 * ret A
  9787				 */
  9788				BPF_STMT(BPF_ALU | BPF_SUB | BPF_K, -0x66),
  9789				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9790			},
  9791			CLASSIC | FLAG_NO_DATA,
  9792			{},
  9793			{ {0x1, 0x66 } },
  9794		},
  9795		{
  9796			"MUL default X",
  9797			.u.insns = {
  9798				/*
  9799				 * A = 0x42
  9800				 * A = A * X
  9801				 * ret A
  9802				 */
  9803				BPF_STMT(BPF_LD | BPF_IMM, 0x42),
  9804				BPF_STMT(BPF_ALU | BPF_MUL | BPF_X, 0),
  9805				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9806			},
  9807			CLASSIC | FLAG_NO_DATA,
  9808			{},
  9809			{ {0x1, 0x0 } },
  9810		},
  9811		{
  9812			"MUL default A",
  9813			.u.insns = {
  9814				/*
  9815				 * A = A * 0x66
  9816				 * ret A
  9817				 */
  9818				BPF_STMT(BPF_ALU | BPF_MUL | BPF_K, 0x66),
  9819				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9820			},
  9821			CLASSIC | FLAG_NO_DATA,
  9822			{},
  9823			{ {0x1, 0x0 } },
  9824		},
  9825		{
  9826			"DIV default X",
  9827			.u.insns = {
  9828				/*
  9829				 * A = 0x42
  9830				 * A = A / X ; this halt the filter execution if X is 0
  9831				 * ret 0x42
  9832				 */
  9833				BPF_STMT(BPF_LD | BPF_IMM, 0x42),
  9834				BPF_STMT(BPF_ALU | BPF_DIV | BPF_X, 0),
  9835				BPF_STMT(BPF_RET | BPF_K, 0x42),
  9836			},
  9837			CLASSIC | FLAG_NO_DATA,
  9838			{},
  9839			{ {0x1, 0x0 } },
  9840		},
  9841		{
  9842			"DIV default A",
  9843			.u.insns = {
  9844				/*
  9845				 * A = A / 1
  9846				 * ret A
  9847				 */
  9848				BPF_STMT(BPF_ALU | BPF_DIV | BPF_K, 0x1),
  9849				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9850			},
  9851			CLASSIC | FLAG_NO_DATA,
  9852			{},
  9853			{ {0x1, 0x0 } },
  9854		},
  9855		{
  9856			"MOD default X",
  9857			.u.insns = {
  9858				/*
  9859				 * A = 0x42
  9860				 * A = A mod X ; this halt the filter execution if X is 0
  9861				 * ret 0x42
  9862				 */
  9863				BPF_STMT(BPF_LD | BPF_IMM, 0x42),
  9864				BPF_STMT(BPF_ALU | BPF_MOD | BPF_X, 0),
  9865				BPF_STMT(BPF_RET | BPF_K, 0x42),
  9866			},
  9867			CLASSIC | FLAG_NO_DATA,
  9868			{},
  9869			{ {0x1, 0x0 } },
  9870		},
  9871		{
  9872			"MOD default A",
  9873			.u.insns = {
  9874				/*
  9875				 * A = A mod 1
  9876				 * ret A
  9877				 */
  9878				BPF_STMT(BPF_ALU | BPF_MOD | BPF_K, 0x1),
  9879				BPF_STMT(BPF_RET | BPF_A, 0x0),
  9880			},
  9881			CLASSIC | FLAG_NO_DATA,
  9882			{},
  9883			{ {0x1, 0x0 } },
  9884		},
  9885		{
  9886			"JMP EQ default A",
  9887			.u.insns = {
  9888				/*
  9889				 * cmp A, 0x0, 0, 1
  9890				 * ret 0x42
  9891				 * ret 0x66
  9892				 */
  9893				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0x0, 0, 1),
  9894				BPF_STMT(BPF_RET | BPF_K, 0x42),
  9895				BPF_STMT(BPF_RET | BPF_K, 0x66),
  9896			},
  9897			CLASSIC | FLAG_NO_DATA,
  9898			{},
  9899			{ {0x1, 0x42 } },
  9900		},
  9901		{
  9902			"JMP EQ default X",
  9903			.u.insns = {
  9904				/*
  9905				 * A = 0x0
  9906				 * cmp A, X, 0, 1
  9907				 * ret 0x42
  9908				 * ret 0x66
  9909				 */
  9910				BPF_STMT(BPF_LD | BPF_IMM, 0x0),
  9911				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_X, 0x0, 0, 1),
  9912				BPF_STMT(BPF_RET | BPF_K, 0x42),
  9913				BPF_STMT(BPF_RET | BPF_K, 0x66),
  9914			},
  9915			CLASSIC | FLAG_NO_DATA,
  9916			{},
  9917			{ {0x1, 0x42 } },
  9918		},
  9919		/* Checking interpreter vs JIT wrt signed extended imms. */
  9920		{
  9921			"JNE signed compare, test 1",
  9922			.u.insns_int = {
  9923				BPF_ALU32_IMM(BPF_MOV, R1, 0xfefbbc12),
  9924				BPF_ALU32_IMM(BPF_MOV, R3, 0xffff0000),
  9925				BPF_MOV64_REG(R2, R1),
  9926				BPF_ALU64_REG(BPF_AND, R2, R3),
  9927				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9928				BPF_JMP_IMM(BPF_JNE, R2, -17104896, 1),
  9929				BPF_ALU32_IMM(BPF_MOV, R0, 2),
  9930				BPF_EXIT_INSN(),
  9931			},
  9932			INTERNAL,
  9933			{ },
  9934			{ { 0, 1 } },
  9935		},
  9936		{
  9937			"JNE signed compare, test 2",
  9938			.u.insns_int = {
  9939				BPF_ALU32_IMM(BPF_MOV, R1, 0xfefbbc12),
  9940				BPF_ALU32_IMM(BPF_MOV, R3, 0xffff0000),
  9941				BPF_MOV64_REG(R2, R1),
  9942				BPF_ALU64_REG(BPF_AND, R2, R3),
  9943				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9944				BPF_JMP_IMM(BPF_JNE, R2, 0xfefb0000, 1),
  9945				BPF_ALU32_IMM(BPF_MOV, R0, 2),
  9946				BPF_EXIT_INSN(),
  9947			},
  9948			INTERNAL,
  9949			{ },
  9950			{ { 0, 1 } },
  9951		},
  9952		{
  9953			"JNE signed compare, test 3",
  9954			.u.insns_int = {
  9955				BPF_ALU32_IMM(BPF_MOV, R1, 0xfefbbc12),
  9956				BPF_ALU32_IMM(BPF_MOV, R3, 0xffff0000),
  9957				BPF_ALU32_IMM(BPF_MOV, R4, 0xfefb0000),
  9958				BPF_MOV64_REG(R2, R1),
  9959				BPF_ALU64_REG(BPF_AND, R2, R3),
  9960				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9961				BPF_JMP_REG(BPF_JNE, R2, R4, 1),
  9962				BPF_ALU32_IMM(BPF_MOV, R0, 2),
  9963				BPF_EXIT_INSN(),
  9964			},
  9965			INTERNAL,
  9966			{ },
  9967			{ { 0, 2 } },
  9968		},
  9969		{
  9970			"JNE signed compare, test 4",
  9971			.u.insns_int = {
  9972				BPF_LD_IMM64(R1, -17104896),
  9973				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9974				BPF_JMP_IMM(BPF_JNE, R1, -17104896, 1),
  9975				BPF_ALU32_IMM(BPF_MOV, R0, 2),
  9976				BPF_EXIT_INSN(),
  9977			},
  9978			INTERNAL,
  9979			{ },
  9980			{ { 0, 2 } },
  9981		},
  9982		{
  9983			"JNE signed compare, test 5",
  9984			.u.insns_int = {
  9985				BPF_LD_IMM64(R1, 0xfefb0000),
  9986				BPF_ALU32_IMM(BPF_MOV, R0, 1),
  9987				BPF_JMP_IMM(BPF_JNE, R1, 0xfefb0000, 1),
  9988				BPF_ALU32_IMM(BPF_MOV, R0, 2),
  9989				BPF_EXIT_INSN(),
  9990			},
  9991			INTERNAL,
  9992			{ },
  9993			{ { 0, 1 } },
  9994		},
  9995		{
  9996			"JNE signed compare, test 6",
  9997			.u.insns_int = {
  9998				BPF_LD_IMM64(R1, 0x7efb0000),
  9999				BPF_ALU32_IMM(BPF_MOV, R0, 1),
 10000				BPF_JMP_IMM(BPF_JNE, R1, 0x7efb0000, 1),
 10001				BPF_ALU32_IMM(BPF_MOV, R0, 2),
 10002				BPF_EXIT_INSN(),
 10003			},
 10004			INTERNAL,
 10005			{ },
 10006			{ { 0, 2 } },
 10007		},
 10008		{
 10009			"JNE signed compare, test 7",
 10010			.u.insns = {
 10011				BPF_STMT(BPF_LD | BPF_IMM, 0xffff0000),
 10012				BPF_STMT(BPF_MISC | BPF_TAX, 0),
 10013				BPF_STMT(BPF_LD | BPF_IMM, 0xfefbbc12),
 10014				BPF_STMT(BPF_ALU | BPF_AND | BPF_X, 0),
 10015				BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 0xfefb0000, 1, 0),
 10016				BPF_STMT(BPF_RET | BPF_K, 1),
 10017				BPF_STMT(BPF_RET | BPF_K, 2),
 10018			},
 10019			CLASSIC | FLAG_NO_DATA,
 10020			{},
 10021			{ { 0, 2 } },
 10022		},
 10023		/* Exhaustive test of ALU64 shift operations */
 10024		{
 10025			"ALU64_LSH_K: all shift values",
 10026			{ },
 10027			INTERNAL | FLAG_NO_DATA,
 10028			{ },
 10029			{ { 0, 1 } },
 10030			.fill_helper = bpf_fill_alu_lsh_imm,
 10031		},
 10032		{
 10033			"ALU64_RSH_K: all shift values",
 10034			{ },
 10035			INTERNAL | FLAG_NO_DATA,
 10036			{ },
 10037			{ { 0, 1 } },
 10038			.fill_helper = bpf_fill_alu_rsh_imm,
 10039		},
 10040		{
 10041			"ALU64_ARSH_K: all shift values",
 10042			{ },
 10043			INTERNAL | FLAG_NO_DATA,
 10044			{ },
 10045			{ { 0, 1 } },
 10046			.fill_helper = bpf_fill_alu_arsh_imm,
 10047		},
 10048		{
 10049			"ALU64_LSH_X: all shift values",
 10050			{ },
 10051			INTERNAL | FLAG_NO_DATA,
 10052			{ },
 10053			{ { 0, 1 } },
 10054			.fill_helper = bpf_fill_alu_lsh_reg,
 10055		},
 10056		{
 10057			"ALU64_RSH_X: all shift values",
 10058			{ },
 10059			INTERNAL | FLAG_NO_DATA,
 10060			{ },
 10061			{ { 0, 1 } },
 10062			.fill_helper = bpf_fill_alu_rsh_reg,
 10063		},
 10064		{
 10065			"ALU64_ARSH_X: all shift values",
 10066			{ },
 10067			INTERNAL | FLAG_NO_DATA,
 10068			{ },
 10069			{ { 0, 1 } },
 10070			.fill_helper = bpf_fill_alu_arsh_reg,
 10071		},
 10072		/* Exhaustive test of ALU32 shift operations */
 10073		{
 10074			"ALU32_LSH_K: all shift values",
 10075			{ },
 10076			INTERNAL | FLAG_NO_DATA,
 10077			{ },
 10078			{ { 0, 1 } },
 10079			.fill_helper = bpf_fill_alu32_lsh_imm,
 10080		},
 10081		{
 10082			"ALU32_RSH_K: all shift values",
 10083			{ },
 10084			INTERNAL | FLAG_NO_DATA,
 10085			{ },
 10086			{ { 0, 1 } },
 10087			.fill_helper = bpf_fill_alu32_rsh_imm,
 10088		},
 10089		{
 10090			"ALU32_ARSH_K: all shift values",
 10091			{ },
 10092			INTERNAL | FLAG_NO_DATA,
 10093			{ },
 10094			{ { 0, 1 } },
 10095			.fill_helper = bpf_fill_alu32_arsh_imm,
 10096		},
 10097		{
 10098			"ALU32_LSH_X: all shift values",
 10099			{ },
 10100			INTERNAL | FLAG_NO_DATA,
 10101			{ },
 10102			{ { 0, 1 } },
 10103			.fill_helper = bpf_fill_alu32_lsh_reg,
 10104		},
 10105		{
 10106			"ALU32_RSH_X: all shift values",
 10107			{ },
 10108			INTERNAL | FLAG_NO_DATA,
 10109			{ },
 10110			{ { 0, 1 } },
 10111			.fill_helper = bpf_fill_alu32_rsh_reg,
 10112		},
 10113		{
 10114			"ALU32_ARSH_X: all shift values",
 10115			{ },
 10116			INTERNAL | FLAG_NO_DATA,
 10117			{ },
 10118			{ { 0, 1 } },
 10119			.fill_helper = bpf_fill_alu32_arsh_reg,
 10120		},
 10121		/* ALU64 immediate magnitudes */
 10122		{
 10123			"ALU64_MOV_K: all immediate value magnitudes",
 10124			{ },
 10125			INTERNAL | FLAG_NO_DATA,
 10126			{ },
 10127			{ { 0, 1 } },
 10128			.fill_helper = bpf_fill_alu64_mov_imm,
 10129			.nr_testruns = NR_PATTERN_RUNS,
 10130		},
 10131		{
 10132			"ALU64_AND_K: all immediate value magnitudes",
 10133			{ },
 10134			INTERNAL | FLAG_NO_DATA,
 10135			{ },
 10136			{ { 0, 1 } },
 10137			.fill_helper = bpf_fill_alu64_and_imm,
 10138			.nr_testruns = NR_PATTERN_RUNS,
 10139		},
 10140		{
 10141			"ALU64_OR_K: all immediate value magnitudes",
 10142			{ },
 10143			INTERNAL | FLAG_NO_DATA,
 10144			{ },
 10145			{ { 0, 1 } },
 10146			.fill_helper = bpf_fill_alu64_or_imm,
 10147			.nr_testruns = NR_PATTERN_RUNS,
 10148		},
 10149		{
 10150			"ALU64_XOR_K: all immediate value magnitudes",
 10151			{ },
 10152			INTERNAL | FLAG_NO_DATA,
 10153			{ },
 10154			{ { 0, 1 } },
 10155			.fill_helper = bpf_fill_alu64_xor_imm,
 10156			.nr_testruns = NR_PATTERN_RUNS,
 10157		},
 10158		{
 10159			"ALU64_ADD_K: all immediate value magnitudes",
 10160			{ },
 10161			INTERNAL | FLAG_NO_DATA,
 10162			{ },
 10163			{ { 0, 1 } },
 10164			.fill_helper = bpf_fill_alu64_add_imm,
 10165			.nr_testruns = NR_PATTERN_RUNS,
 10166		},
 10167		{
 10168			"ALU64_SUB_K: all immediate value magnitudes",
 10169			{ },
 10170			INTERNAL | FLAG_NO_DATA,
 10171			{ },
 10172			{ { 0, 1 } },
 10173			.fill_helper = bpf_fill_alu64_sub_imm,
 10174			.nr_testruns = NR_PATTERN_RUNS,
 10175		},
 10176		{
 10177			"ALU64_MUL_K: all immediate value magnitudes",
 10178			{ },
 10179			INTERNAL | FLAG_NO_DATA,
 10180			{ },
 10181			{ { 0, 1 } },
 10182			.fill_helper = bpf_fill_alu64_mul_imm,
 10183			.nr_testruns = NR_PATTERN_RUNS,
 10184		},
 10185		{
 10186			"ALU64_DIV_K: all immediate value magnitudes",
 10187			{ },
 10188			INTERNAL | FLAG_NO_DATA,
 10189			{ },
 10190			{ { 0, 1 } },
 10191			.fill_helper = bpf_fill_alu64_div_imm,
 10192			.nr_testruns = NR_PATTERN_RUNS,
 10193		},
 10194		{
 10195			"ALU64_MOD_K: all immediate value magnitudes",
 10196			{ },
 10197			INTERNAL | FLAG_NO_DATA,
 10198			{ },
 10199			{ { 0, 1 } },
 10200			.fill_helper = bpf_fill_alu64_mod_imm,
 10201			.nr_testruns = NR_PATTERN_RUNS,
 10202		},
 10203		/* ALU32 immediate magnitudes */
 10204		{
 10205			"ALU32_MOV_K: all immediate value magnitudes",
 10206			{ },
 10207			INTERNAL | FLAG_NO_DATA,
 10208			{ },
 10209			{ { 0, 1 } },
 10210			.fill_helper = bpf_fill_alu32_mov_imm,
 10211			.nr_testruns = NR_PATTERN_RUNS,
 10212		},
 10213		{
 10214			"ALU32_AND_K: all immediate value magnitudes",
 10215			{ },
 10216			INTERNAL | FLAG_NO_DATA,
 10217			{ },
 10218			{ { 0, 1 } },
 10219			.fill_helper = bpf_fill_alu32_and_imm,
 10220			.nr_testruns = NR_PATTERN_RUNS,
 10221		},
 10222		{
 10223			"ALU32_OR_K: all immediate value magnitudes",
 10224			{ },
 10225			INTERNAL | FLAG_NO_DATA,
 10226			{ },
 10227			{ { 0, 1 } },
 10228			.fill_helper = bpf_fill_alu32_or_imm,
 10229			.nr_testruns = NR_PATTERN_RUNS,
 10230		},
 10231		{
 10232			"ALU32_XOR_K: all immediate value magnitudes",
 10233			{ },
 10234			INTERNAL | FLAG_NO_DATA,
 10235			{ },
 10236			{ { 0, 1 } },
 10237			.fill_helper = bpf_fill_alu32_xor_imm,
 10238			.nr_testruns = NR_PATTERN_RUNS,
 10239		},
 10240		{
 10241			"ALU32_ADD_K: all immediate value magnitudes",
 10242			{ },
 10243			INTERNAL | FLAG_NO_DATA,
 10244			{ },
 10245			{ { 0, 1 } },
 10246			.fill_helper = bpf_fill_alu32_add_imm,
 10247			.nr_testruns = NR_PATTERN_RUNS,
 10248		},
 10249		{
 10250			"ALU32_SUB_K: all immediate value magnitudes",
 10251			{ },
 10252			INTERNAL | FLAG_NO_DATA,
 10253			{ },
 10254			{ { 0, 1 } },
 10255			.fill_helper = bpf_fill_alu32_sub_imm,
 10256			.nr_testruns = NR_PATTERN_RUNS,
 10257		},
 10258		{
 10259			"ALU32_MUL_K: all immediate value magnitudes",
 10260			{ },
 10261			INTERNAL | FLAG_NO_DATA,
 10262			{ },
 10263			{ { 0, 1 } },
 10264			.fill_helper = bpf_fill_alu32_mul_imm,
 10265			.nr_testruns = NR_PATTERN_RUNS,
 10266		},
 10267		{
 10268			"ALU32_DIV_K: all immediate value magnitudes",
 10269			{ },
 10270			INTERNAL | FLAG_NO_DATA,
 10271			{ },
 10272			{ { 0, 1 } },
 10273			.fill_helper = bpf_fill_alu32_div_imm,
 10274			.nr_testruns = NR_PATTERN_RUNS,
 10275		},
 10276		{
 10277			"ALU32_MOD_K: all immediate value magnitudes",
 10278			{ },
 10279			INTERNAL | FLAG_NO_DATA,
 10280			{ },
 10281			{ { 0, 1 } },
 10282			.fill_helper = bpf_fill_alu32_mod_imm,
 10283			.nr_testruns = NR_PATTERN_RUNS,
 10284		},
 10285		/* ALU64 register magnitudes */
 10286		{
 10287			"ALU64_MOV_X: all register value magnitudes",
 10288			{ },
 10289			INTERNAL | FLAG_NO_DATA,
 10290			{ },
 10291			{ { 0, 1 } },
 10292			.fill_helper = bpf_fill_alu64_mov_reg,
 10293			.nr_testruns = NR_PATTERN_RUNS,
 10294		},
 10295		{
 10296			"ALU64_AND_X: all register value magnitudes",
 10297			{ },
 10298			INTERNAL | FLAG_NO_DATA,
 10299			{ },
 10300			{ { 0, 1 } },
 10301			.fill_helper = bpf_fill_alu64_and_reg,
 10302			.nr_testruns = NR_PATTERN_RUNS,
 10303		},
 10304		{
 10305			"ALU64_OR_X: all register value magnitudes",
 10306			{ },
 10307			INTERNAL | FLAG_NO_DATA,
 10308			{ },
 10309			{ { 0, 1 } },
 10310			.fill_helper = bpf_fill_alu64_or_reg,
 10311			.nr_testruns = NR_PATTERN_RUNS,
 10312		},
 10313		{
 10314			"ALU64_XOR_X: all register value magnitudes",
 10315			{ },
 10316			INTERNAL | FLAG_NO_DATA,
 10317			{ },
 10318			{ { 0, 1 } },
 10319			.fill_helper = bpf_fill_alu64_xor_reg,
 10320			.nr_testruns = NR_PATTERN_RUNS,
 10321		},
 10322		{
 10323			"ALU64_ADD_X: all register value magnitudes",
 10324			{ },
 10325			INTERNAL | FLAG_NO_DATA,
 10326			{ },
 10327			{ { 0, 1 } },
 10328			.fill_helper = bpf_fill_alu64_add_reg,
 10329			.nr_testruns = NR_PATTERN_RUNS,
 10330		},
 10331		{
 10332			"ALU64_SUB_X: all register value magnitudes",
 10333			{ },
 10334			INTERNAL | FLAG_NO_DATA,
 10335			{ },
 10336			{ { 0, 1 } },
 10337			.fill_helper = bpf_fill_alu64_sub_reg,
 10338			.nr_testruns = NR_PATTERN_RUNS,
 10339		},
 10340		{
 10341			"ALU64_MUL_X: all register value magnitudes",
 10342			{ },
 10343			INTERNAL | FLAG_NO_DATA,
 10344			{ },
 10345			{ { 0, 1 } },
 10346			.fill_helper = bpf_fill_alu64_mul_reg,
 10347			.nr_testruns = NR_PATTERN_RUNS,
 10348		},
 10349		{
 10350			"ALU64_DIV_X: all register value magnitudes",
 10351			{ },
 10352			INTERNAL | FLAG_NO_DATA,
 10353			{ },
 10354			{ { 0, 1 } },
 10355			.fill_helper = bpf_fill_alu64_div_reg,
 10356			.nr_testruns = NR_PATTERN_RUNS,
 10357		},
 10358		{
 10359			"ALU64_MOD_X: all register value magnitudes",
 10360			{ },
 10361			INTERNAL | FLAG_NO_DATA,
 10362			{ },
 10363			{ { 0, 1 } },
 10364			.fill_helper = bpf_fill_alu64_mod_reg,
 10365			.nr_testruns = NR_PATTERN_RUNS,
 10366		},
 10367		/* ALU32 register magnitudes */
 10368		{
 10369			"ALU32_MOV_X: all register value magnitudes",
 10370			{ },
 10371			INTERNAL | FLAG_NO_DATA,
 10372			{ },
 10373			{ { 0, 1 } },
 10374			.fill_helper = bpf_fill_alu32_mov_reg,
 10375			.nr_testruns = NR_PATTERN_RUNS,
 10376		},
 10377		{
 10378			"ALU32_AND_X: all register value magnitudes",
 10379			{ },
 10380			INTERNAL | FLAG_NO_DATA,
 10381			{ },
 10382			{ { 0, 1 } },
 10383			.fill_helper = bpf_fill_alu32_and_reg,
 10384			.nr_testruns = NR_PATTERN_RUNS,
 10385		},
 10386		{
 10387			"ALU32_OR_X: all register value magnitudes",
 10388			{ },
 10389			INTERNAL | FLAG_NO_DATA,
 10390			{ },
 10391			{ { 0, 1 } },
 10392			.fill_helper = bpf_fill_alu32_or_reg,
 10393			.nr_testruns = NR_PATTERN_RUNS,
 10394		},
 10395		{
 10396			"ALU32_XOR_X: all register value magnitudes",
 10397			{ },
 10398			INTERNAL | FLAG_NO_DATA,
 10399			{ },
 10400			{ { 0, 1 } },
 10401			.fill_helper = bpf_fill_alu32_xor_reg,
 10402			.nr_testruns = NR_PATTERN_RUNS,
 10403		},
 10404		{
 10405			"ALU32_ADD_X: all register value magnitudes",
 10406			{ },
 10407			INTERNAL | FLAG_NO_DATA,
 10408			{ },
 10409			{ { 0, 1 } },
 10410			.fill_helper = bpf_fill_alu32_add_reg,
 10411			.nr_testruns = NR_PATTERN_RUNS,
 10412		},
 10413		{
 10414			"ALU32_SUB_X: all register value magnitudes",
 10415			{ },
 10416			INTERNAL | FLAG_NO_DATA,
 10417			{ },
 10418			{ { 0, 1 } },
 10419			.fill_helper = bpf_fill_alu32_sub_reg,
 10420			.nr_testruns = NR_PATTERN_RUNS,
 10421		},
 10422		{
 10423			"ALU32_MUL_X: all register value magnitudes",
 10424			{ },
 10425			INTERNAL | FLAG_NO_DATA,
 10426			{ },
 10427			{ { 0, 1 } },
 10428			.fill_helper = bpf_fill_alu32_mul_reg,
 10429			.nr_testruns = NR_PATTERN_RUNS,
 10430		},
 10431		{
 10432			"ALU32_DIV_X: all register value magnitudes",
 10433			{ },
 10434			INTERNAL | FLAG_NO_DATA,
 10435			{ },
 10436			{ { 0, 1 } },
 10437			.fill_helper = bpf_fill_alu32_div_reg,
 10438			.nr_testruns = NR_PATTERN_RUNS,
 10439		},
 10440		{
 10441			"ALU32_MOD_X: all register value magnitudes",
 10442			{ },
 10443			INTERNAL | FLAG_NO_DATA,
 10444			{ },
 10445			{ { 0, 1 } },
 10446			.fill_helper = bpf_fill_alu32_mod_reg,
 10447			.nr_testruns = NR_PATTERN_RUNS,
 10448		},
 10449		/* LD_IMM64 immediate magnitudes */
 10450		{
 10451			"LD_IMM64: all immediate value magnitudes",
 10452			{ },
 10453			INTERNAL | FLAG_NO_DATA,
 10454			{ },
 10455			{ { 0, 1 } },
 10456			.fill_helper = bpf_fill_ld_imm64,
 10457		},
 10458		/* JMP immediate magnitudes */
 10459		{
 10460			"JMP_JSET_K: all immediate value magnitudes",
 10461			{ },
 10462			INTERNAL | FLAG_NO_DATA,
 10463			{ },
 10464			{ { 0, 1 } },
 10465			.fill_helper = bpf_fill_jmp_jset_imm,
 10466			.nr_testruns = NR_PATTERN_RUNS,
 10467		},
 10468		{
 10469			"JMP_JEQ_K: all immediate value magnitudes",
 10470			{ },
 10471			INTERNAL | FLAG_NO_DATA,
 10472			{ },
 10473			{ { 0, 1 } },
 10474			.fill_helper = bpf_fill_jmp_jeq_imm,
 10475			.nr_testruns = NR_PATTERN_RUNS,
 10476		},
 10477		{
 10478			"JMP_JNE_K: all immediate value magnitudes",
 10479			{ },
 10480			INTERNAL | FLAG_NO_DATA,
 10481			{ },
 10482			{ { 0, 1 } },
 10483			.fill_helper = bpf_fill_jmp_jne_imm,
 10484			.nr_testruns = NR_PATTERN_RUNS,
 10485		},
 10486		{
 10487			"JMP_JGT_K: all immediate value magnitudes",
 10488			{ },
 10489			INTERNAL | FLAG_NO_DATA,
 10490			{ },
 10491			{ { 0, 1 } },
 10492			.fill_helper = bpf_fill_jmp_jgt_imm,
 10493			.nr_testruns = NR_PATTERN_RUNS,
 10494		},
 10495		{
 10496			"JMP_JGE_K: all immediate value magnitudes",
 10497			{ },
 10498			INTERNAL | FLAG_NO_DATA,
 10499			{ },
 10500			{ { 0, 1 } },
 10501			.fill_helper = bpf_fill_jmp_jge_imm,
 10502			.nr_testruns = NR_PATTERN_RUNS,
 10503		},
 10504		{
 10505			"JMP_JLT_K: all immediate value magnitudes",
 10506			{ },
 10507			INTERNAL | FLAG_NO_DATA,
 10508			{ },
 10509			{ { 0, 1 } },
 10510			.fill_helper = bpf_fill_jmp_jlt_imm,
 10511			.nr_testruns = NR_PATTERN_RUNS,
 10512		},
 10513		{
 10514			"JMP_JLE_K: all immediate value magnitudes",
 10515			{ },
 10516			INTERNAL | FLAG_NO_DATA,
 10517			{ },
 10518			{ { 0, 1 } },
 10519			.fill_helper = bpf_fill_jmp_jle_imm,
 10520			.nr_testruns = NR_PATTERN_RUNS,
 10521		},
 10522		{
 10523			"JMP_JSGT_K: all immediate value magnitudes",
 10524			{ },
 10525			INTERNAL | FLAG_NO_DATA,
 10526			{ },
 10527			{ { 0, 1 } },
 10528			.fill_helper = bpf_fill_jmp_jsgt_imm,
 10529			.nr_testruns = NR_PATTERN_RUNS,
 10530		},
 10531		{
 10532			"JMP_JSGE_K: all immediate value magnitudes",
 10533			{ },
 10534			INTERNAL | FLAG_NO_DATA,
 10535			{ },
 10536			{ { 0, 1 } },
 10537			.fill_helper = bpf_fill_jmp_jsge_imm,
 10538			.nr_testruns = NR_PATTERN_RUNS,
 10539		},
 10540		{
 10541			"JMP_JSLT_K: all immediate value magnitudes",
 10542			{ },
 10543			INTERNAL | FLAG_NO_DATA,
 10544			{ },
 10545			{ { 0, 1 } },
 10546			.fill_helper = bpf_fill_jmp_jslt_imm,
 10547			.nr_testruns = NR_PATTERN_RUNS,
 10548		},
 10549		{
 10550			"JMP_JSLE_K: all immediate value magnitudes",
 10551			{ },
 10552			INTERNAL | FLAG_NO_DATA,
 10553			{ },
 10554			{ { 0, 1 } },
 10555			.fill_helper = bpf_fill_jmp_jsle_imm,
 10556			.nr_testruns = NR_PATTERN_RUNS,
 10557		},
 10558		/* JMP register magnitudes */
 10559		{
 10560			"JMP_JSET_X: all register value magnitudes",
 10561			{ },
 10562			INTERNAL | FLAG_NO_DATA,
 10563			{ },
 10564			{ { 0, 1 } },
 10565			.fill_helper = bpf_fill_jmp_jset_reg,
 10566			.nr_testruns = NR_PATTERN_RUNS,
 10567		},
 10568		{
 10569			"JMP_JEQ_X: all register value magnitudes",
 10570			{ },
 10571			INTERNAL | FLAG_NO_DATA,
 10572			{ },
 10573			{ { 0, 1 } },
 10574			.fill_helper = bpf_fill_jmp_jeq_reg,
 10575			.nr_testruns = NR_PATTERN_RUNS,
 10576		},
 10577		{
 10578			"JMP_JNE_X: all register value magnitudes",
 10579			{ },
 10580			INTERNAL | FLAG_NO_DATA,
 10581			{ },
 10582			{ { 0, 1 } },
 10583			.fill_helper = bpf_fill_jmp_jne_reg,
 10584			.nr_testruns = NR_PATTERN_RUNS,
 10585		},
 10586		{
 10587			"JMP_JGT_X: all register value magnitudes",
 10588			{ },
 10589			INTERNAL | FLAG_NO_DATA,
 10590			{ },
 10591			{ { 0, 1 } },
 10592			.fill_helper = bpf_fill_jmp_jgt_reg,
 10593			.nr_testruns = NR_PATTERN_RUNS,
 10594		},
 10595		{
 10596			"JMP_JGE_X: all register value magnitudes",
 10597			{ },
 10598			INTERNAL | FLAG_NO_DATA,
 10599			{ },
 10600			{ { 0, 1 } },
 10601			.fill_helper = bpf_fill_jmp_jge_reg,
 10602			.nr_testruns = NR_PATTERN_RUNS,
 10603		},
 10604		{
 10605			"JMP_JLT_X: all register value magnitudes",
 10606			{ },
 10607			INTERNAL | FLAG_NO_DATA,
 10608			{ },
 10609			{ { 0, 1 } },
 10610			.fill_helper = bpf_fill_jmp_jlt_reg,
 10611			.nr_testruns = NR_PATTERN_RUNS,
 10612		},
 10613		{
 10614			"JMP_JLE_X: all register value magnitudes",
 10615			{ },
 10616			INTERNAL | FLAG_NO_DATA,
 10617			{ },
 10618			{ { 0, 1 } },
 10619			.fill_helper = bpf_fill_jmp_jle_reg,
 10620			.nr_testruns = NR_PATTERN_RUNS,
 10621		},
 10622		{
 10623			"JMP_JSGT_X: all register value magnitudes",
 10624			{ },
 10625			INTERNAL | FLAG_NO_DATA,
 10626			{ },
 10627			{ { 0, 1 } },
 10628			.fill_helper = bpf_fill_jmp_jsgt_reg,
 10629			.nr_testruns = NR_PATTERN_RUNS,
 10630		},
 10631		{
 10632			"JMP_JSGE_X: all register value magnitudes",
 10633			{ },
 10634			INTERNAL | FLAG_NO_DATA,
 10635			{ },
 10636			{ { 0, 1 } },
 10637			.fill_helper = bpf_fill_jmp_jsge_reg,
 10638			.nr_testruns = NR_PATTERN_RUNS,
 10639		},
 10640		{
 10641			"JMP_JSLT_X: all register value magnitudes",
 10642			{ },
 10643			INTERNAL | FLAG_NO_DATA,
 10644			{ },
 10645			{ { 0, 1 } },
 10646			.fill_helper = bpf_fill_jmp_jslt_reg,
 10647			.nr_testruns = NR_PATTERN_RUNS,
 10648		},
 10649		{
 10650			"JMP_JSLE_X: all register value magnitudes",
 10651			{ },
 10652			INTERNAL | FLAG_NO_DATA,
 10653			{ },
 10654			{ { 0, 1 } },
 10655			.fill_helper = bpf_fill_jmp_jsle_reg,
 10656			.nr_testruns = NR_PATTERN_RUNS,
 10657		},
 10658		/* JMP32 immediate magnitudes */
 10659		{
 10660			"JMP32_JSET_K: all immediate value magnitudes",
 10661			{ },
 10662			INTERNAL | FLAG_NO_DATA,
 10663			{ },
 10664			{ { 0, 1 } },
 10665			.fill_helper = bpf_fill_jmp32_jset_imm,
 10666			.nr_testruns = NR_PATTERN_RUNS,
 10667		},
 10668		{
 10669			"JMP32_JEQ_K: all immediate value magnitudes",
 10670			{ },
 10671			INTERNAL | FLAG_NO_DATA,
 10672			{ },
 10673			{ { 0, 1 } },
 10674			.fill_helper = bpf_fill_jmp32_jeq_imm,
 10675			.nr_testruns = NR_PATTERN_RUNS,
 10676		},
 10677		{
 10678			"JMP32_JNE_K: all immediate value magnitudes",
 10679			{ },
 10680			INTERNAL | FLAG_NO_DATA,
 10681			{ },
 10682			{ { 0, 1 } },
 10683			.fill_helper = bpf_fill_jmp32_jne_imm,
 10684			.nr_testruns = NR_PATTERN_RUNS,
 10685		},
 10686		{
 10687			"JMP32_JGT_K: all immediate value magnitudes",
 10688			{ },
 10689			INTERNAL | FLAG_NO_DATA,
 10690			{ },
 10691			{ { 0, 1 } },
 10692			.fill_helper = bpf_fill_jmp32_jgt_imm,
 10693			.nr_testruns = NR_PATTERN_RUNS,
 10694		},
 10695		{
 10696			"JMP32_JGE_K: all immediate value magnitudes",
 10697			{ },
 10698			INTERNAL | FLAG_NO_DATA,
 10699			{ },
 10700			{ { 0, 1 } },
 10701			.fill_helper = bpf_fill_jmp32_jge_imm,
 10702			.nr_testruns = NR_PATTERN_RUNS,
 10703		},
 10704		{
 10705			"JMP32_JLT_K: all immediate value magnitudes",
 10706			{ },
 10707			INTERNAL | FLAG_NO_DATA,
 10708			{ },
 10709			{ { 0, 1 } },
 10710			.fill_helper = bpf_fill_jmp32_jlt_imm,
 10711			.nr_testruns = NR_PATTERN_RUNS,
 10712		},
 10713		{
 10714			"JMP32_JLE_K: all immediate value magnitudes",
 10715			{ },
 10716			INTERNAL | FLAG_NO_DATA,
 10717			{ },
 10718			{ { 0, 1 } },
 10719			.fill_helper = bpf_fill_jmp32_jle_imm,
 10720			.nr_testruns = NR_PATTERN_RUNS,
 10721		},
 10722		{
 10723			"JMP32_JSGT_K: all immediate value magnitudes",
 10724			{ },
 10725			INTERNAL | FLAG_NO_DATA,
 10726			{ },
 10727			{ { 0, 1 } },
 10728			.fill_helper = bpf_fill_jmp32_jsgt_imm,
 10729			.nr_testruns = NR_PATTERN_RUNS,
 10730		},
 10731		{
 10732			"JMP32_JSGE_K: all immediate value magnitudes",
 10733			{ },
 10734			INTERNAL | FLAG_NO_DATA,
 10735			{ },
 10736			{ { 0, 1 } },
 10737			.fill_helper = bpf_fill_jmp32_jsge_imm,
 10738			.nr_testruns = NR_PATTERN_RUNS,
 10739		},
 10740		{
 10741			"JMP32_JSLT_K: all immediate value magnitudes",
 10742			{ },
 10743			INTERNAL | FLAG_NO_DATA,
 10744			{ },
 10745			{ { 0, 1 } },
 10746			.fill_helper = bpf_fill_jmp32_jslt_imm,
 10747			.nr_testruns = NR_PATTERN_RUNS,
 10748		},
 10749		{
 10750			"JMP32_JSLE_K: all immediate value magnitudes",
 10751			{ },
 10752			INTERNAL | FLAG_NO_DATA,
 10753			{ },
 10754			{ { 0, 1 } },
 10755			.fill_helper = bpf_fill_jmp32_jsle_imm,
 10756			.nr_testruns = NR_PATTERN_RUNS,
 10757		},
 10758		/* JMP32 register magnitudes */
 10759		{
 10760			"JMP32_JSET_X: all register value magnitudes",
 10761			{ },
 10762			INTERNAL | FLAG_NO_DATA,
 10763			{ },
 10764			{ { 0, 1 } },
 10765			.fill_helper = bpf_fill_jmp32_jset_reg,
 10766			.nr_testruns = NR_PATTERN_RUNS,
 10767		},
 10768		{
 10769			"JMP32_JEQ_X: all register value magnitudes",
 10770			{ },
 10771			INTERNAL | FLAG_NO_DATA,
 10772			{ },
 10773			{ { 0, 1 } },
 10774			.fill_helper = bpf_fill_jmp32_jeq_reg,
 10775			.nr_testruns = NR_PATTERN_RUNS,
 10776		},
 10777		{
 10778			"JMP32_JNE_X: all register value magnitudes",
 10779			{ },
 10780			INTERNAL | FLAG_NO_DATA,
 10781			{ },
 10782			{ { 0, 1 } },
 10783			.fill_helper = bpf_fill_jmp32_jne_reg,
 10784			.nr_testruns = NR_PATTERN_RUNS,
 10785		},
 10786		{
 10787			"JMP32_JGT_X: all register value magnitudes",
 10788			{ },
 10789			INTERNAL | FLAG_NO_DATA,
 10790			{ },
 10791			{ { 0, 1 } },
 10792			.fill_helper = bpf_fill_jmp32_jgt_reg,
 10793			.nr_testruns = NR_PATTERN_RUNS,
 10794		},
 10795		{
 10796			"JMP32_JGE_X: all register value magnitudes",
 10797			{ },
 10798			INTERNAL | FLAG_NO_DATA,
 10799			{ },
 10800			{ { 0, 1 } },
 10801			.fill_helper = bpf_fill_jmp32_jge_reg,
 10802			.nr_testruns = NR_PATTERN_RUNS,
 10803		},
 10804		{
 10805			"JMP32_JLT_X: all register value magnitudes",
 10806			{ },
 10807			INTERNAL | FLAG_NO_DATA,
 10808			{ },
 10809			{ { 0, 1 } },
 10810			.fill_helper = bpf_fill_jmp32_jlt_reg,
 10811			.nr_testruns = NR_PATTERN_RUNS,
 10812		},
 10813		{
 10814			"JMP32_JLE_X: all register value magnitudes",
 10815			{ },
 10816			INTERNAL | FLAG_NO_DATA,
 10817			{ },
 10818			{ { 0, 1 } },
 10819			.fill_helper = bpf_fill_jmp32_jle_reg,
 10820			.nr_testruns = NR_PATTERN_RUNS,
 10821		},
 10822		{
 10823			"JMP32_JSGT_X: all register value magnitudes",
 10824			{ },
 10825			INTERNAL | FLAG_NO_DATA,
 10826			{ },
 10827			{ { 0, 1 } },
 10828			.fill_helper = bpf_fill_jmp32_jsgt_reg,
 10829			.nr_testruns = NR_PATTERN_RUNS,
 10830		},
 10831		{
 10832			"JMP32_JSGE_X: all register value magnitudes",
 10833			{ },
 10834			INTERNAL | FLAG_NO_DATA,
 10835			{ },
 10836			{ { 0, 1 } },
 10837			.fill_helper = bpf_fill_jmp32_jsge_reg,
 10838			.nr_testruns = NR_PATTERN_RUNS,
 10839		},
 10840		{
 10841			"JMP32_JSLT_X: all register value magnitudes",
 10842			{ },
 10843			INTERNAL | FLAG_NO_DATA,
 10844			{ },
 10845			{ { 0, 1 } },
 10846			.fill_helper = bpf_fill_jmp32_jslt_reg,
 10847			.nr_testruns = NR_PATTERN_RUNS,
 10848		},
 10849		{
 10850			"JMP32_JSLE_X: all register value magnitudes",
 10851			{ },
 10852			INTERNAL | FLAG_NO_DATA,
 10853			{ },
 10854			{ { 0, 1 } },
 10855			.fill_helper = bpf_fill_jmp32_jsle_reg,
 10856			.nr_testruns = NR_PATTERN_RUNS,
 10857		},
 10858		/* Conditional jumps with constant decision */
 10859		{
 10860			"JMP_JSET_K: imm = 0 -> never taken",
 10861			.u.insns_int = {
 10862				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 10863				BPF_JMP_IMM(BPF_JSET, R1, 0, 1),
 10864				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 10865				BPF_EXIT_INSN(),
 10866			},
 10867			INTERNAL | FLAG_NO_DATA,
 10868			{ },
 10869			{ { 0, 0 } },
 10870		},
 10871		{
 10872			"JMP_JLT_K: imm = 0 -> never taken",
 10873			.u.insns_int = {
 10874				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 10875				BPF_JMP_IMM(BPF_JLT, R1, 0, 1),
 10876				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 10877				BPF_EXIT_INSN(),
 10878			},
 10879			INTERNAL | FLAG_NO_DATA,
 10880			{ },
 10881			{ { 0, 0 } },
 10882		},
 10883		{
 10884			"JMP_JGE_K: imm = 0 -> always taken",
 10885			.u.insns_int = {
 10886				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 10887				BPF_JMP_IMM(BPF_JGE, R1, 0, 1),
 10888				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 10889				BPF_EXIT_INSN(),
 10890			},
 10891			INTERNAL | FLAG_NO_DATA,
 10892			{ },
 10893			{ { 0, 1 } },
 10894		},
 10895		{
 10896			"JMP_JGT_K: imm = 0xffffffff -> never taken",
 10897			.u.insns_int = {
 10898				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 10899				BPF_JMP_IMM(BPF_JGT, R1, U32_MAX, 1),
 10900				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 10901				BPF_EXIT_INSN(),
 10902			},
 10903			INTERNAL | FLAG_NO_DATA,
 10904			{ },
 10905			{ { 0, 0 } },
 10906		},
 10907		{
 10908			"JMP_JLE_K: imm = 0xffffffff -> always taken",
 10909			.u.insns_int = {
 10910				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 10911				BPF_JMP_IMM(BPF_JLE, R1, U32_MAX, 1),
 10912				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 10913				BPF_EXIT_INSN(),
 10914			},
 10915			INTERNAL | FLAG_NO_DATA,
 10916			{ },
 10917			{ { 0, 1 } },
 10918		},
 10919		{
 10920			"JMP32_JSGT_K: imm = 0x7fffffff -> never taken",
 10921			.u.insns_int = {
 10922				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 10923				BPF_JMP32_IMM(BPF_JSGT, R1, S32_MAX, 1),
 10924				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 10925				BPF_EXIT_INSN(),
 10926			},
 10927			INTERNAL | FLAG_NO_DATA,
 10928			{ },
 10929			{ { 0, 0 } },
 10930		},
 10931		{
 10932			"JMP32_JSGE_K: imm = -0x80000000 -> always taken",
 10933			.u.insns_int = {
 10934				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 10935				BPF_JMP32_IMM(BPF_JSGE, R1, S32_MIN, 1),
 10936				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 10937				BPF_EXIT_INSN(),
 10938			},
 10939			INTERNAL | FLAG_NO_DATA,
 10940			{ },
 10941			{ { 0, 1 } },
 10942		},
 10943		{
 10944			"JMP32_JSLT_K: imm = -0x80000000 -> never taken",
 10945			.u.insns_int = {
 10946				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 10947				BPF_JMP32_IMM(BPF_JSLT, R1, S32_MIN, 1),
 10948				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 10949				BPF_EXIT_INSN(),
 10950			},
 10951			INTERNAL | FLAG_NO_DATA,
 10952			{ },
 10953			{ { 0, 0 } },
 10954		},
 10955		{
 10956			"JMP32_JSLE_K: imm = 0x7fffffff -> always taken",
 10957			.u.insns_int = {
 10958				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 10959				BPF_JMP32_IMM(BPF_JSLE, R1, S32_MAX, 1),
 10960				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 10961				BPF_EXIT_INSN(),
 10962			},
 10963			INTERNAL | FLAG_NO_DATA,
 10964			{ },
 10965			{ { 0, 1 } },
 10966		},
 10967		{
 10968			"JMP_JEQ_X: dst = src -> always taken",
 10969			.u.insns_int = {
 10970				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 10971				BPF_JMP_REG(BPF_JEQ, R1, R1, 1),
 10972				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 10973				BPF_EXIT_INSN(),
 10974			},
 10975			INTERNAL | FLAG_NO_DATA,
 10976			{ },
 10977			{ { 0, 1 } },
 10978		},
 10979		{
 10980			"JMP_JGE_X: dst = src -> always taken",
 10981			.u.insns_int = {
 10982				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 10983				BPF_JMP_REG(BPF_JGE, R1, R1, 1),
 10984				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 10985				BPF_EXIT_INSN(),
 10986			},
 10987			INTERNAL | FLAG_NO_DATA,
 10988			{ },
 10989			{ { 0, 1 } },
 10990		},
 10991		{
 10992			"JMP_JLE_X: dst = src -> always taken",
 10993			.u.insns_int = {
 10994				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 10995				BPF_JMP_REG(BPF_JLE, R1, R1, 1),
 10996				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 10997				BPF_EXIT_INSN(),
 10998			},
 10999			INTERNAL | FLAG_NO_DATA,
 11000			{ },
 11001			{ { 0, 1 } },
 11002		},
 11003		{
 11004			"JMP_JSGE_X: dst = src -> always taken",
 11005			.u.insns_int = {
 11006				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11007				BPF_JMP_REG(BPF_JSGE, R1, R1, 1),
 11008				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11009				BPF_EXIT_INSN(),
 11010			},
 11011			INTERNAL | FLAG_NO_DATA,
 11012			{ },
 11013			{ { 0, 1 } },
 11014		},
 11015		{
 11016			"JMP_JSLE_X: dst = src -> always taken",
 11017			.u.insns_int = {
 11018				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11019				BPF_JMP_REG(BPF_JSLE, R1, R1, 1),
 11020				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11021				BPF_EXIT_INSN(),
 11022			},
 11023			INTERNAL | FLAG_NO_DATA,
 11024			{ },
 11025			{ { 0, 1 } },
 11026		},
 11027		{
 11028			"JMP_JNE_X: dst = src -> never taken",
 11029			.u.insns_int = {
 11030				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11031				BPF_JMP_REG(BPF_JNE, R1, R1, 1),
 11032				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11033				BPF_EXIT_INSN(),
 11034			},
 11035			INTERNAL | FLAG_NO_DATA,
 11036			{ },
 11037			{ { 0, 0 } },
 11038		},
 11039		{
 11040			"JMP_JGT_X: dst = src -> never taken",
 11041			.u.insns_int = {
 11042				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11043				BPF_JMP_REG(BPF_JGT, R1, R1, 1),
 11044				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11045				BPF_EXIT_INSN(),
 11046			},
 11047			INTERNAL | FLAG_NO_DATA,
 11048			{ },
 11049			{ { 0, 0 } },
 11050		},
 11051		{
 11052			"JMP_JLT_X: dst = src -> never taken",
 11053			.u.insns_int = {
 11054				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11055				BPF_JMP_REG(BPF_JLT, R1, R1, 1),
 11056				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11057				BPF_EXIT_INSN(),
 11058			},
 11059			INTERNAL | FLAG_NO_DATA,
 11060			{ },
 11061			{ { 0, 0 } },
 11062		},
 11063		{
 11064			"JMP_JSGT_X: dst = src -> never taken",
 11065			.u.insns_int = {
 11066				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11067				BPF_JMP_REG(BPF_JSGT, R1, R1, 1),
 11068				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11069				BPF_EXIT_INSN(),
 11070			},
 11071			INTERNAL | FLAG_NO_DATA,
 11072			{ },
 11073			{ { 0, 0 } },
 11074		},
 11075		{
 11076			"JMP_JSLT_X: dst = src -> never taken",
 11077			.u.insns_int = {
 11078				BPF_ALU64_IMM(BPF_MOV, R0, 1),
 11079				BPF_JMP_REG(BPF_JSLT, R1, R1, 1),
 11080				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11081				BPF_EXIT_INSN(),
 11082			},
 11083			INTERNAL | FLAG_NO_DATA,
 11084			{ },
 11085			{ { 0, 0 } },
 11086		},
 11087		/* Short relative jumps */
 11088		{
 11089			"Short relative jump: offset=0",
 11090			.u.insns_int = {
 11091				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11092				BPF_JMP_IMM(BPF_JEQ, R0, 0, 0),
 11093				BPF_EXIT_INSN(),
 11094				BPF_ALU32_IMM(BPF_MOV, R0, -1),
 11095			},
 11096			INTERNAL | FLAG_NO_DATA | FLAG_VERIFIER_ZEXT,
 11097			{ },
 11098			{ { 0, 0 } },
 11099		},
 11100		{
 11101			"Short relative jump: offset=1",
 11102			.u.insns_int = {
 11103				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11104				BPF_JMP_IMM(BPF_JEQ, R0, 0, 1),
 11105				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 11106				BPF_EXIT_INSN(),
 11107				BPF_ALU32_IMM(BPF_MOV, R0, -1),
 11108			},
 11109			INTERNAL | FLAG_NO_DATA | FLAG_VERIFIER_ZEXT,
 11110			{ },
 11111			{ { 0, 0 } },
 11112		},
 11113		{
 11114			"Short relative jump: offset=2",
 11115			.u.insns_int = {
 11116				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11117				BPF_JMP_IMM(BPF_JEQ, R0, 0, 2),
 11118				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 11119				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 11120				BPF_EXIT_INSN(),
 11121				BPF_ALU32_IMM(BPF_MOV, R0, -1),
 11122			},
 11123			INTERNAL | FLAG_NO_DATA | FLAG_VERIFIER_ZEXT,
 11124			{ },
 11125			{ { 0, 0 } },
 11126		},
 11127		{
 11128			"Short relative jump: offset=3",
 11129			.u.insns_int = {
 11130				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11131				BPF_JMP_IMM(BPF_JEQ, R0, 0, 3),
 11132				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 11133				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 11134				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 11135				BPF_EXIT_INSN(),
 11136				BPF_ALU32_IMM(BPF_MOV, R0, -1),
 11137			},
 11138			INTERNAL | FLAG_NO_DATA | FLAG_VERIFIER_ZEXT,
 11139			{ },
 11140			{ { 0, 0 } },
 11141		},
 11142		{
 11143			"Short relative jump: offset=4",
 11144			.u.insns_int = {
 11145				BPF_ALU64_IMM(BPF_MOV, R0, 0),
 11146				BPF_JMP_IMM(BPF_JEQ, R0, 0, 4),
 11147				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 11148				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 11149				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 11150				BPF_ALU32_IMM(BPF_ADD, R0, 1),
 11151				BPF_EXIT_INSN(),
 11152				BPF_ALU32_IMM(BPF_MOV, R0, -1),
 11153			},
 11154			INTERNAL | FLAG_NO_DATA | FLAG_VERIFIER_ZEXT,
 11155			{ },
 11156			{ { 0, 0 } },
 11157		},
 11158		/* Conditional branch conversions */
 11159		{
 11160			"Long conditional jump: taken at runtime",
 11161			{ },
 11162			INTERNAL | FLAG_NO_DATA,
 11163			{ },
 11164			{ { 0, 1 } },
 11165			.fill_helper = bpf_fill_max_jmp_taken,
 11166		},
 11167		{
 11168			"Long conditional jump: not taken at runtime",
 11169			{ },
 11170			INTERNAL | FLAG_NO_DATA,
 11171			{ },
 11172			{ { 0, 2 } },
 11173			.fill_helper = bpf_fill_max_jmp_not_taken,
 11174		},
 11175		{
 11176			"Long conditional jump: always taken, known at JIT time",
 11177			{ },
 11178			INTERNAL | FLAG_NO_DATA,
 11179			{ },
 11180			{ { 0, 1 } },
 11181			.fill_helper = bpf_fill_max_jmp_always_taken,
 11182		},
 11183		{
 11184			"Long conditional jump: never taken, known at JIT time",
 11185			{ },
 11186			INTERNAL | FLAG_NO_DATA,
 11187			{ },
 11188			{ { 0, 2 } },
 11189			.fill_helper = bpf_fill_max_jmp_never_taken,
 11190		},
 11191		/* Staggered jump sequences, immediate */
 11192		{
 11193			"Staggered jumps: JMP_JA",
 11194			{ },
 11195			INTERNAL | FLAG_NO_DATA,
 11196			{ },
 11197			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11198			.fill_helper = bpf_fill_staggered_ja,
 11199			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11200		},
 11201		{
 11202			"Staggered jumps: JMP_JEQ_K",
 11203			{ },
 11204			INTERNAL | FLAG_NO_DATA,
 11205			{ },
 11206			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11207			.fill_helper = bpf_fill_staggered_jeq_imm,
 11208			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11209		},
 11210		{
 11211			"Staggered jumps: JMP_JNE_K",
 11212			{ },
 11213			INTERNAL | FLAG_NO_DATA,
 11214			{ },
 11215			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11216			.fill_helper = bpf_fill_staggered_jne_imm,
 11217			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11218		},
 11219		{
 11220			"Staggered jumps: JMP_JSET_K",
 11221			{ },
 11222			INTERNAL | FLAG_NO_DATA,
 11223			{ },
 11224			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11225			.fill_helper = bpf_fill_staggered_jset_imm,
 11226			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11227		},
 11228		{
 11229			"Staggered jumps: JMP_JGT_K",
 11230			{ },
 11231			INTERNAL | FLAG_NO_DATA,
 11232			{ },
 11233			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11234			.fill_helper = bpf_fill_staggered_jgt_imm,
 11235			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11236		},
 11237		{
 11238			"Staggered jumps: JMP_JGE_K",
 11239			{ },
 11240			INTERNAL | FLAG_NO_DATA,
 11241			{ },
 11242			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11243			.fill_helper = bpf_fill_staggered_jge_imm,
 11244			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11245		},
 11246		{
 11247			"Staggered jumps: JMP_JLT_K",
 11248			{ },
 11249			INTERNAL | FLAG_NO_DATA,
 11250			{ },
 11251			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11252			.fill_helper = bpf_fill_staggered_jlt_imm,
 11253			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11254		},
 11255		{
 11256			"Staggered jumps: JMP_JLE_K",
 11257			{ },
 11258			INTERNAL | FLAG_NO_DATA,
 11259			{ },
 11260			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11261			.fill_helper = bpf_fill_staggered_jle_imm,
 11262			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11263		},
 11264		{
 11265			"Staggered jumps: JMP_JSGT_K",
 11266			{ },
 11267			INTERNAL | FLAG_NO_DATA,
 11268			{ },
 11269			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11270			.fill_helper = bpf_fill_staggered_jsgt_imm,
 11271			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11272		},
 11273		{
 11274			"Staggered jumps: JMP_JSGE_K",
 11275			{ },
 11276			INTERNAL | FLAG_NO_DATA,
 11277			{ },
 11278			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11279			.fill_helper = bpf_fill_staggered_jsge_imm,
 11280			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11281		},
 11282		{
 11283			"Staggered jumps: JMP_JSLT_K",
 11284			{ },
 11285			INTERNAL | FLAG_NO_DATA,
 11286			{ },
 11287			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11288			.fill_helper = bpf_fill_staggered_jslt_imm,
 11289			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11290		},
 11291		{
 11292			"Staggered jumps: JMP_JSLE_K",
 11293			{ },
 11294			INTERNAL | FLAG_NO_DATA,
 11295			{ },
 11296			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11297			.fill_helper = bpf_fill_staggered_jsle_imm,
 11298			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11299		},
 11300		/* Staggered jump sequences, register */
 11301		{
 11302			"Staggered jumps: JMP_JEQ_X",
 11303			{ },
 11304			INTERNAL | FLAG_NO_DATA,
 11305			{ },
 11306			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11307			.fill_helper = bpf_fill_staggered_jeq_reg,
 11308			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11309		},
 11310		{
 11311			"Staggered jumps: JMP_JNE_X",
 11312			{ },
 11313			INTERNAL | FLAG_NO_DATA,
 11314			{ },
 11315			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11316			.fill_helper = bpf_fill_staggered_jne_reg,
 11317			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11318		},
 11319		{
 11320			"Staggered jumps: JMP_JSET_X",
 11321			{ },
 11322			INTERNAL | FLAG_NO_DATA,
 11323			{ },
 11324			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11325			.fill_helper = bpf_fill_staggered_jset_reg,
 11326			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11327		},
 11328		{
 11329			"Staggered jumps: JMP_JGT_X",
 11330			{ },
 11331			INTERNAL | FLAG_NO_DATA,
 11332			{ },
 11333			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11334			.fill_helper = bpf_fill_staggered_jgt_reg,
 11335			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11336		},
 11337		{
 11338			"Staggered jumps: JMP_JGE_X",
 11339			{ },
 11340			INTERNAL | FLAG_NO_DATA,
 11341			{ },
 11342			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11343			.fill_helper = bpf_fill_staggered_jge_reg,
 11344			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11345		},
 11346		{
 11347			"Staggered jumps: JMP_JLT_X",
 11348			{ },
 11349			INTERNAL | FLAG_NO_DATA,
 11350			{ },
 11351			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11352			.fill_helper = bpf_fill_staggered_jlt_reg,
 11353			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11354		},
 11355		{
 11356			"Staggered jumps: JMP_JLE_X",
 11357			{ },
 11358			INTERNAL | FLAG_NO_DATA,
 11359			{ },
 11360			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11361			.fill_helper = bpf_fill_staggered_jle_reg,
 11362			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11363		},
 11364		{
 11365			"Staggered jumps: JMP_JSGT_X",
 11366			{ },
 11367			INTERNAL | FLAG_NO_DATA,
 11368			{ },
 11369			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11370			.fill_helper = bpf_fill_staggered_jsgt_reg,
 11371			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11372		},
 11373		{
 11374			"Staggered jumps: JMP_JSGE_X",
 11375			{ },
 11376			INTERNAL | FLAG_NO_DATA,
 11377			{ },
 11378			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11379			.fill_helper = bpf_fill_staggered_jsge_reg,
 11380			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11381		},
 11382		{
 11383			"Staggered jumps: JMP_JSLT_X",
 11384			{ },
 11385			INTERNAL | FLAG_NO_DATA,
 11386			{ },
 11387			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11388			.fill_helper = bpf_fill_staggered_jslt_reg,
 11389			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11390		},
 11391		{
 11392			"Staggered jumps: JMP_JSLE_X",
 11393			{ },
 11394			INTERNAL | FLAG_NO_DATA,
 11395			{ },
 11396			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11397			.fill_helper = bpf_fill_staggered_jsle_reg,
 11398			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11399		},
 11400		/* Staggered jump sequences, JMP32 immediate */
 11401		{
 11402			"Staggered jumps: JMP32_JEQ_K",
 11403			{ },
 11404			INTERNAL | FLAG_NO_DATA,
 11405			{ },
 11406			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11407			.fill_helper = bpf_fill_staggered_jeq32_imm,
 11408			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11409		},
 11410		{
 11411			"Staggered jumps: JMP32_JNE_K",
 11412			{ },
 11413			INTERNAL | FLAG_NO_DATA,
 11414			{ },
 11415			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11416			.fill_helper = bpf_fill_staggered_jne32_imm,
 11417			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11418		},
 11419		{
 11420			"Staggered jumps: JMP32_JSET_K",
 11421			{ },
 11422			INTERNAL | FLAG_NO_DATA,
 11423			{ },
 11424			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11425			.fill_helper = bpf_fill_staggered_jset32_imm,
 11426			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11427		},
 11428		{
 11429			"Staggered jumps: JMP32_JGT_K",
 11430			{ },
 11431			INTERNAL | FLAG_NO_DATA,
 11432			{ },
 11433			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11434			.fill_helper = bpf_fill_staggered_jgt32_imm,
 11435			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11436		},
 11437		{
 11438			"Staggered jumps: JMP32_JGE_K",
 11439			{ },
 11440			INTERNAL | FLAG_NO_DATA,
 11441			{ },
 11442			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11443			.fill_helper = bpf_fill_staggered_jge32_imm,
 11444			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11445		},
 11446		{
 11447			"Staggered jumps: JMP32_JLT_K",
 11448			{ },
 11449			INTERNAL | FLAG_NO_DATA,
 11450			{ },
 11451			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11452			.fill_helper = bpf_fill_staggered_jlt32_imm,
 11453			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11454		},
 11455		{
 11456			"Staggered jumps: JMP32_JLE_K",
 11457			{ },
 11458			INTERNAL | FLAG_NO_DATA,
 11459			{ },
 11460			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11461			.fill_helper = bpf_fill_staggered_jle32_imm,
 11462			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11463		},
 11464		{
 11465			"Staggered jumps: JMP32_JSGT_K",
 11466			{ },
 11467			INTERNAL | FLAG_NO_DATA,
 11468			{ },
 11469			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11470			.fill_helper = bpf_fill_staggered_jsgt32_imm,
 11471			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11472		},
 11473		{
 11474			"Staggered jumps: JMP32_JSGE_K",
 11475			{ },
 11476			INTERNAL | FLAG_NO_DATA,
 11477			{ },
 11478			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11479			.fill_helper = bpf_fill_staggered_jsge32_imm,
 11480			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11481		},
 11482		{
 11483			"Staggered jumps: JMP32_JSLT_K",
 11484			{ },
 11485			INTERNAL | FLAG_NO_DATA,
 11486			{ },
 11487			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11488			.fill_helper = bpf_fill_staggered_jslt32_imm,
 11489			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11490		},
 11491		{
 11492			"Staggered jumps: JMP32_JSLE_K",
 11493			{ },
 11494			INTERNAL | FLAG_NO_DATA,
 11495			{ },
 11496			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11497			.fill_helper = bpf_fill_staggered_jsle32_imm,
 11498			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11499		},
 11500		/* Staggered jump sequences, JMP32 register */
 11501		{
 11502			"Staggered jumps: JMP32_JEQ_X",
 11503			{ },
 11504			INTERNAL | FLAG_NO_DATA,
 11505			{ },
 11506			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11507			.fill_helper = bpf_fill_staggered_jeq32_reg,
 11508			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11509		},
 11510		{
 11511			"Staggered jumps: JMP32_JNE_X",
 11512			{ },
 11513			INTERNAL | FLAG_NO_DATA,
 11514			{ },
 11515			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11516			.fill_helper = bpf_fill_staggered_jne32_reg,
 11517			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11518		},
 11519		{
 11520			"Staggered jumps: JMP32_JSET_X",
 11521			{ },
 11522			INTERNAL | FLAG_NO_DATA,
 11523			{ },
 11524			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11525			.fill_helper = bpf_fill_staggered_jset32_reg,
 11526			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11527		},
 11528		{
 11529			"Staggered jumps: JMP32_JGT_X",
 11530			{ },
 11531			INTERNAL | FLAG_NO_DATA,
 11532			{ },
 11533			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11534			.fill_helper = bpf_fill_staggered_jgt32_reg,
 11535			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11536		},
 11537		{
 11538			"Staggered jumps: JMP32_JGE_X",
 11539			{ },
 11540			INTERNAL | FLAG_NO_DATA,
 11541			{ },
 11542			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11543			.fill_helper = bpf_fill_staggered_jge32_reg,
 11544			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11545		},
 11546		{
 11547			"Staggered jumps: JMP32_JLT_X",
 11548			{ },
 11549			INTERNAL | FLAG_NO_DATA,
 11550			{ },
 11551			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11552			.fill_helper = bpf_fill_staggered_jlt32_reg,
 11553			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11554		},
 11555		{
 11556			"Staggered jumps: JMP32_JLE_X",
 11557			{ },
 11558			INTERNAL | FLAG_NO_DATA,
 11559			{ },
 11560			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11561			.fill_helper = bpf_fill_staggered_jle32_reg,
 11562			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11563		},
 11564		{
 11565			"Staggered jumps: JMP32_JSGT_X",
 11566			{ },
 11567			INTERNAL | FLAG_NO_DATA,
 11568			{ },
 11569			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11570			.fill_helper = bpf_fill_staggered_jsgt32_reg,
 11571			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11572		},
 11573		{
 11574			"Staggered jumps: JMP32_JSGE_X",
 11575			{ },
 11576			INTERNAL | FLAG_NO_DATA,
 11577			{ },
 11578			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11579			.fill_helper = bpf_fill_staggered_jsge32_reg,
 11580			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11581		},
 11582		{
 11583			"Staggered jumps: JMP32_JSLT_X",
 11584			{ },
 11585			INTERNAL | FLAG_NO_DATA,
 11586			{ },
 11587			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11588			.fill_helper = bpf_fill_staggered_jslt32_reg,
 11589			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11590		},
 11591		{
 11592			"Staggered jumps: JMP32_JSLE_X",
 11593			{ },
 11594			INTERNAL | FLAG_NO_DATA,
 11595			{ },
 11596			{ { 0, MAX_STAGGERED_JMP_SIZE + 1 } },
 11597			.fill_helper = bpf_fill_staggered_jsle32_reg,
 11598			.nr_testruns = NR_STAGGERED_JMP_RUNS,
 11599		},
 11600	};
 11601	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
