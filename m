Return-Path: <linux-kernel+bounces-11740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6A081EB08
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 01:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019C91F22AD0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 00:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6811C02;
	Wed, 27 Dec 2023 00:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ud+XFqso"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBC4A40
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 00:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703638388; x=1735174388;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EHyD/Ctzf6HTAfxaY9VOUgCgcVqZDtsz2zblZucRSgg=;
  b=Ud+XFqsoMHr3Z/xChSS6XI8oAcSo2pUH91u9vQcTeobBlLLQfCrwt82f
   BHqyUbp4ADFGWoi1DtZQoBjMn/7tDxCANHqFzMKYDTDDQAgz8IuFiuh2U
   R8ncm3cp6GxW52Z3ZsAgRbObJu9/hPcKDmgY5ymPOpUtxvdPDxW9Glai2
   0FuPi/jZWJWe3lTARQFP9rI2X0GlpX9YIOQFTDAEUBv8gHhIQGWpAHM0A
   zTF8JX5w+olmNodEe5GAJ5Ji2+gj5IahdHnqS+sBoCFMcFAEJyWNect+g
   66y38wmtu6HXC4MnqomrJIbrkkHwgnETijXnETOcEiDIoYfLBZlqTMxS2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="395284842"
X-IronPort-AV: E=Sophos;i="6.04,307,1695711600"; 
   d="scan'208";a="395284842"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 16:53:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="771293812"
X-IronPort-AV: E=Sophos;i="6.04,307,1695711600"; 
   d="scan'208";a="771293812"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 26 Dec 2023 16:53:06 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rIIAR-000Evz-0H;
	Wed, 27 Dec 2023 00:53:03 +0000
Date: Wed, 27 Dec 2023 08:52:23 +0800
From: kernel test robot <lkp@intel.com>
To: Jordan Niethe <jniethe5@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/kvm/test-guest-state-buffer.c:70:25: sparse: sparse:
 restricted __be64 degrades to integer
Message-ID: <202312270830.t3f9Plc5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fbafc3e621c3f4ded43720fdb1d6ce1728ec664e
commit: 6ccbbc33f06adaf79acde18571c6543ad1cb4be6 KVM: PPC: Add helper library for Guest State Buffers
date:   3 months ago
config: powerpc64-randconfig-r131-20231227 (https://download.01.org/0day-ci/archive/20231227/202312270830.t3f9Plc5-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231227/202312270830.t3f9Plc5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312270830.t3f9Plc5-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/kvm/test-guest-state-buffer.c:70:25: sparse: sparse: restricted __be64 degrades to integer
>> arch/powerpc/kvm/test-guest-state-buffer.c:70:25: sparse: sparse: incorrect type in initializer (different base types) @@     expected long long left_value @@     got restricted __be64 const __left @@
   arch/powerpc/kvm/test-guest-state-buffer.c:70:25: sparse:     expected long long left_value
   arch/powerpc/kvm/test-guest-state-buffer.c:70:25: sparse:     got restricted __be64 const __left
   arch/powerpc/kvm/test-guest-state-buffer.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/umh.h, include/linux/kmod.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false

vim +70 arch/powerpc/kvm/test-guest-state-buffer.c

    24	
    25	static void test_adding_element(struct kunit *test)
    26	{
    27		const struct kvmppc_gs_elem *head, *curr;
    28		union {
    29			__vector128 v;
    30			u64 dw[2];
    31		} u;
    32		int rem;
    33		struct kvmppc_gs_buff *gsb;
    34		size_t size = 0x1000;
    35		int i, rc;
    36		u64 data;
    37	
    38		gsb = kvmppc_gsb_new(size, 0, 0, GFP_KERNEL);
    39		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, gsb);
    40	
    41		/* Single elements, direct use of __kvmppc_gse_put() */
    42		data = 0xdeadbeef;
    43		rc = __kvmppc_gse_put(gsb, KVMPPC_GSID_GPR(0), 8, &data);
    44		KUNIT_EXPECT_GE(test, rc, 0);
    45	
    46		head = kvmppc_gsb_data(gsb);
    47		KUNIT_EXPECT_EQ(test, kvmppc_gse_iden(head), KVMPPC_GSID_GPR(0));
    48		KUNIT_EXPECT_EQ(test, kvmppc_gse_len(head), 8);
    49		data = 0;
    50		memcpy(&data, kvmppc_gse_data(head), 8);
    51		KUNIT_EXPECT_EQ(test, data, 0xdeadbeef);
    52	
    53		/* Multiple elements, simple wrapper */
    54		rc = kvmppc_gse_put_u64(gsb, KVMPPC_GSID_GPR(1), 0xcafef00d);
    55		KUNIT_EXPECT_GE(test, rc, 0);
    56	
    57		u.dw[0] = 0x1;
    58		u.dw[1] = 0x2;
    59		rc = kvmppc_gse_put_vector128(gsb, KVMPPC_GSID_VSRS(0), &u.v);
    60		KUNIT_EXPECT_GE(test, rc, 0);
    61		u.dw[0] = 0x0;
    62		u.dw[1] = 0x0;
    63	
    64		kvmppc_gsb_for_each_elem(i, curr, gsb, rem) {
    65			switch (i) {
    66			case 0:
    67				KUNIT_EXPECT_EQ(test, kvmppc_gse_iden(curr),
    68						KVMPPC_GSID_GPR(0));
    69				KUNIT_EXPECT_EQ(test, kvmppc_gse_len(curr), 8);
  > 70				KUNIT_EXPECT_EQ(test, kvmppc_gse_get_be64(curr),
    71						0xdeadbeef);
    72				break;
    73			case 1:
    74				KUNIT_EXPECT_EQ(test, kvmppc_gse_iden(curr),
    75						KVMPPC_GSID_GPR(1));
    76				KUNIT_EXPECT_EQ(test, kvmppc_gse_len(curr), 8);
    77				KUNIT_EXPECT_EQ(test, kvmppc_gse_get_u64(curr),
    78						0xcafef00d);
    79				break;
    80			case 2:
    81				KUNIT_EXPECT_EQ(test, kvmppc_gse_iden(curr),
    82						KVMPPC_GSID_VSRS(0));
    83				KUNIT_EXPECT_EQ(test, kvmppc_gse_len(curr), 16);
    84				kvmppc_gse_get_vector128(curr, &u.v);
    85				KUNIT_EXPECT_EQ(test, u.dw[0], 0x1);
    86				KUNIT_EXPECT_EQ(test, u.dw[1], 0x2);
    87				break;
    88			}
    89		}
    90		KUNIT_EXPECT_EQ(test, i, 3);
    91	
    92		kvmppc_gsb_reset(gsb);
    93		KUNIT_EXPECT_EQ(test, kvmppc_gsb_nelems(gsb), 0);
    94		KUNIT_EXPECT_EQ(test, kvmppc_gsb_len(gsb),
    95				sizeof(struct kvmppc_gs_header));
    96	
    97		kvmppc_gsb_free(gsb);
    98	}
    99	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

