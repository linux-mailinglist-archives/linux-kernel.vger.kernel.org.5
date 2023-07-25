Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D56762285
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjGYTig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjGYTia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:38:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC09270E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 12:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690313879; x=1721849879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iXbgVG18Y7RTGH9a4tg9bgDCR+4JUI1k2BMBe1/7ZtU=;
  b=now2FuGDfJ+noEtq09sgligXlt/61l/KMa1Z342ijiVDlXhBroKskgYH
   Xx5eyR6pkhxBmtlFf98GYfD3HUvt+pEKL8/s+USuCMFEXv90iA+l0pR69
   sQ5uTgyFlSbhyxsy8xutSpuqHfaFYHuW488dLiE9CDVZgP2UpEwZgp9BR
   tGdCRAI6PqsrO8vItm5jDgcbLE44jE99cf+3Xk/IXlStbrZ/FKZAQKAl4
   QXneikaS7z4+MYk00aw73X6ftSVBOzrowLajWvMqtelAXOuSUSn1yFzB4
   MFyQiLHibcSEu56tSZv3dmcarVSSS417a7XDXsbgtyRGCW8CISrlRMaXj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="367856217"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="367856217"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 12:37:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="791512095"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="791512095"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jul 2023 12:37:13 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qONqK-0000I3-1y;
        Tue, 25 Jul 2023 19:37:12 +0000
Date:   Wed, 26 Jul 2023 03:36:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Liao Chang <liaochang1@huawei.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alyssa Ross <hi@alyssa.is>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
Subject: Re: [PATCH v1 3/3] riscv/purgatory: do not link with string.o
Message-ID: <202307260325.E3Uh9dYf-lkp@intel.com>
References: <a083f38c7c3acd6ac9542228e36947be30b58188.1690274483.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a083f38c7c3acd6ac9542228e36947be30b58188.1690274483.git.petr.tesarik.ext@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

kernel test robot noticed the following build errors:

[auto build test ERROR on kees/for-next/pstore]
[also build test ERROR on kees/for-next/kspp linus/master v6.5-rc3 next-20230725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Petr-Tesarik/riscv-kexec-handle-R_RISCV_CALL_PLT-relocation-type/20230725-165116
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
patch link:    https://lore.kernel.org/r/a083f38c7c3acd6ac9542228e36947be30b58188.1690274483.git.petr.tesarik.ext%40huawei.com
patch subject: [PATCH v1 3/3] riscv/purgatory: do not link with string.o
config: riscv-randconfig-r001-20230725 (https://download.01.org/0day-ci/archive/20230726/202307260325.E3Uh9dYf-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230726/202307260325.E3Uh9dYf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307260325.E3Uh9dYf-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: memcmp
   >>> referenced by ctype.c
   >>>               arch/riscv/purgatory/purgatory.ro:(purgatory)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
