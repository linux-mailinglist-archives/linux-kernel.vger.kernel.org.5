Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A348B7BFFEF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjJJPFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjJJPFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:05:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9F9AC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696950332; x=1728486332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mdUyBSaObi/bh3BJzqLGOF381cKMFk0z6OBG3myfggs=;
  b=ZIOfRUX92hO0+cb+B/3gF0jGV7C/OQrqgCUBXc5kmKeDIv3iRGWwcI2f
   U7luNmD6oso92/i3YThoVDNyXVpeMhmfle4bUO8gPWF2pN/GMZu4+ZkNP
   6/NN667feUYLtrVoXfLDwgl5vhXL1viZxQ/OPn1QStwYu5wb/SRg2x1Ys
   y35IVDk+dSbyaIQ6ZZfMrvlLEop1zirzFR8ZHffLticRNFC4WODHa0qwQ
   XXJdk2oTU1Iwi27bbXQMaCnCXRfN3WAuTPySImvFL0pNh7SqSsx3ERT+3
   3hHeSWMP4DVUPgvJWcfDZzG8dLcyLFOPMCS/0hy0+a4fyG0tJyuQImQ3d
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="3007010"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="3007010"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 08:05:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="877255433"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="877255433"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 10 Oct 2023 08:05:28 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqEIX-0000cO-1O;
        Tue, 10 Oct 2023 15:05:25 +0000
Date:   Tue, 10 Oct 2023 23:04:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Charlie Jenkins <charlie@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [PATCH v2 2/2] riscv: Add tests for riscv module loading
Message-ID: <202310102243.0Ab0xH1g-lkp@intel.com>
References: <20231006-module_relocations-v2-2-47566453fedc@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006-module_relocations-v2-2-47566453fedc@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charlie,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 82714078aee4ccbd6ee7579d5a21f8a72155d0fb]

url:    https://github.com/intel-lab-lkp/linux/commits/Charlie-Jenkins/riscv-Add-remaining-module-relocations/20231007-084330
base:   82714078aee4ccbd6ee7579d5a21f8a72155d0fb
patch link:    https://lore.kernel.org/r/20231006-module_relocations-v2-2-47566453fedc%40rivosinc.com
patch subject: [PATCH v2 2/2] riscv: Add tests for riscv module loading
config: riscv-randconfig-002-20231010 (https://download.01.org/0day-ci/archive/20231010/202310102243.0Ab0xH1g-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310102243.0Ab0xH1g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310102243.0Ab0xH1g-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/tests/module_test/test_module_linking_main.c:26:6: warning: no previous prototype for 'run_test_set' [-Wmissing-prototypes]
      26 | void run_test_set(struct kunit *test)
         |      ^~~~~~~~~~~~
>> arch/riscv/kernel/tests/module_test/test_module_linking_main.c:39:6: warning: no previous prototype for 'run_test_sub' [-Wmissing-prototypes]
      39 | void run_test_sub(struct kunit *test)
         |      ^~~~~~~~~~~~
>> arch/riscv/kernel/tests/module_test/test_module_linking_main.c:54:6: warning: no previous prototype for 'run_test_uleb' [-Wmissing-prototypes]
      54 | void run_test_uleb(struct kunit *test)
         |      ^~~~~~~~~~~~~


vim +/run_test_set +26 arch/riscv/kernel/tests/module_test/test_module_linking_main.c

    25	
  > 26	void run_test_set(struct kunit *test)
    27	{
    28		int val32 = test_set32();
    29		int val16 = test_set16();
    30		int val8 = test_set8();
    31		int val6 = test_set6();
    32	
    33		CHECK_EQ(val32, 0);
    34		CHECK_EQ(val16, 0);
    35		CHECK_EQ(val8, 0);
    36		CHECK_EQ(val6, 0);
    37	}
    38	
  > 39	void run_test_sub(struct kunit *test)
    40	{
    41		int val64 = test_sub64();
    42		int val32 = test_sub32();
    43		int val16 = test_sub16();
    44		int val8 = test_sub8();
    45		int val6 = test_sub6();
    46	
    47		CHECK_EQ(val64, 0);
    48		CHECK_EQ(val32, 0);
    49		CHECK_EQ(val16, 0);
    50		CHECK_EQ(val8, 0);
    51		CHECK_EQ(val6, 0);
    52	}
    53	
  > 54	void run_test_uleb(struct kunit *test)
    55	{
    56		int valuleb = test_uleb();
    57	
    58		CHECK_EQ(valuleb, 0);
    59	}
    60	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
