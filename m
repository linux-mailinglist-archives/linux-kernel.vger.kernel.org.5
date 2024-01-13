Return-Path: <linux-kernel+bounces-25367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0793882CE71
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 21:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD341C21034
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 20:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4B5EAFC;
	Sat, 13 Jan 2024 20:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="daNjYcRw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8439E4C97;
	Sat, 13 Jan 2024 20:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705178492; x=1736714492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q9huzpE1di9IOGQ1NV6QRQVDnPfRGatTVLcIU4u648M=;
  b=daNjYcRwCQvIln81/UcYdf3+S7lDmxebwHj3cadZbTpGCcMqTvr5DSjJ
   Jw7HJTWW5U40BJwrfYNAMdh+guFlbz/kUoeuAlOQDBlCuy9AeWpHvYfc1
   8vPmEuJZbMdgZvxRr+BKkjITQHd6qWdiH7Mmg109uf0I7iyBNsoZtnscf
   qEamrOOVGMZ9aU68Mx28Is8m8Go+mNBo5XBQcYaEdQh5iPbso8koHwutH
   Zp3uxbHaXNuCeaR2nlC1AueLiAABio1qGQEkUUhQbrH//SSVbZuGWRJ6+
   O7Cl1aRggVQjD58dO3tuVbmQ/zkZ/RFq778XMdYTwV89dLr5cWJxNvNPh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="6763316"
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="6763316"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2024 12:41:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="786705813"
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="786705813"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jan 2024 12:41:26 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOkoj-000At4-1k;
	Sat, 13 Jan 2024 20:41:21 +0000
Date: Sun, 14 Jan 2024 04:40:55 +0800
From: kernel test robot <lkp@intel.com>
To: Prabhakar <prabhakar.csengg@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 3/4] pinctrl: renesas: pinctrl-rzg2l: Add the missing
 port pins P19 to P28
Message-ID: <202401140457.dWlCUkuN-lkp@intel.com>
References: <20240112142621.13525-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112142621.13525-4-prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi Prabhakar,

kernel test robot noticed the following build errors:

[auto build test ERROR on geert-renesas-drivers/renesas-pinctrl]
[cannot apply to geert-renesas-devel/next linusw-pinctrl/devel linusw-pinctrl/for-next linus/master v6.7 next-20240112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Prabhakar/pinctrl-renesas-rzg2l-Improve-code-for-readability/20240112-222833
base:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git renesas-pinctrl
patch link:    https://lore.kernel.org/r/20240112142621.13525-4-prabhakar.mahadev-lad.rj%40bp.renesas.com
patch subject: [PATCH v4 3/4] pinctrl: renesas: pinctrl-rzg2l: Add the missing port pins P19 to P28
config: powerpc-randconfig-r081-20240113 (https://download.01.org/0day-ci/archive/20240114/202401140457.dWlCUkuN-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240114/202401140457.dWlCUkuN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401140457.dWlCUkuN-lkp@intel.com/

All errors (new ones prefixed by >>):

   #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
                                                    ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:31: note: expanded from macro 'PIN_CFG_PIN_MAP_MASK'
   #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
                                           ^
   include/linux/bits.h:37:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:35:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^
   include/linux/bitfield.h:141:50: note: expanded from macro 'FIELD_PREP_CONST'
                   (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
                                                                  ^~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1577:2: warning: shift count is negative [-Wshift-count-negative]
           RZG2L_GPIO_PORT_PACK(3, 0x38, RZG2L_MPXED_PIN_FUNCS),
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:39: note: expanded from macro 'RZG2L_GPIO_PORT_PACK'
   #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:64: note: expanded from macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
   #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
                                                    ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:31: note: expanded from macro 'PIN_CFG_PIN_MAP_MASK'
   #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
                                           ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/bits.h:35:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^
   include/linux/bitfield.h:141:39: note: expanded from macro 'FIELD_PREP_CONST'
                   (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
                                              ~~~~~~~~~^~~~~~
   include/linux/bitfield.h:45:38: note: expanded from macro '__bf_shf'
   #define __bf_shf(x) (__builtin_ffsll(x) - 1)
                                        ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1577:2: warning: shift count is negative [-Wshift-count-negative]
           RZG2L_GPIO_PORT_PACK(3, 0x38, RZG2L_MPXED_PIN_FUNCS),
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:39: note: expanded from macro 'RZG2L_GPIO_PORT_PACK'
   #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:64: note: expanded from macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
   #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
                                                    ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:31: note: expanded from macro 'PIN_CFG_PIN_MAP_MASK'
   #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
                                           ^
   include/linux/bits.h:37:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:35:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^
   include/linux/bitfield.h:141:50: note: expanded from macro 'FIELD_PREP_CONST'
                   (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
                                                                  ^~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1578:2: warning: shift count is negative [-Wshift-count-negative]
           RZG2L_GPIO_PORT_PACK(2, 0x39, RZG2L_MPXED_PIN_FUNCS),
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:39: note: expanded from macro 'RZG2L_GPIO_PORT_PACK'
   #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:64: note: expanded from macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
   #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
                                                    ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:31: note: expanded from macro 'PIN_CFG_PIN_MAP_MASK'
   #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
                                           ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/bits.h:35:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^
   include/linux/bitfield.h:141:39: note: expanded from macro 'FIELD_PREP_CONST'
                   (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
                                              ~~~~~~~~~^~~~~~
   include/linux/bitfield.h:45:38: note: expanded from macro '__bf_shf'
   #define __bf_shf(x) (__builtin_ffsll(x) - 1)
                                        ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1578:2: warning: shift count is negative [-Wshift-count-negative]
           RZG2L_GPIO_PORT_PACK(2, 0x39, RZG2L_MPXED_PIN_FUNCS),
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:39: note: expanded from macro 'RZG2L_GPIO_PORT_PACK'
   #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:64: note: expanded from macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
   #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
                                                    ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:31: note: expanded from macro 'PIN_CFG_PIN_MAP_MASK'
   #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
                                           ^
   include/linux/bits.h:37:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:35:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^
   include/linux/bitfield.h:141:50: note: expanded from macro 'FIELD_PREP_CONST'
                   (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
                                                                  ^~~~~
>> drivers/pinctrl/renesas/pinctrl-rzg2l.c:1579:2: error: anonymous bit-field has negative width (-1)
           RZG2L_GPIO_PORT_PACK(5, 0x3a, RZG2L_MPXED_PIN_FUNCS),
           ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:39: note: expanded from macro 'RZG2L_GPIO_PORT_PACK'
   #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
                                           ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:47: note: expanded from macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
   #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
                                                    ^
   include/linux/bitfield.h:137:3: note: expanded from macro 'FIELD_PREP_CONST'
                   BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
                   ^
   include/linux/build_bug.h:16:53: note: expanded from macro 'BUILD_BUG_ON_ZERO'
   #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
                                                       ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1579:2: warning: shift count is negative [-Wshift-count-negative]
           RZG2L_GPIO_PORT_PACK(5, 0x3a, RZG2L_MPXED_PIN_FUNCS),
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:39: note: expanded from macro 'RZG2L_GPIO_PORT_PACK'
   #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:64: note: expanded from macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
   #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
                                                    ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:31: note: expanded from macro 'PIN_CFG_PIN_MAP_MASK'
   #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
                                           ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/bits.h:35:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^
   include/linux/bitfield.h:141:39: note: expanded from macro 'FIELD_PREP_CONST'
                   (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
                                              ~~~~~~~~~^~~~~~
   include/linux/bitfield.h:45:38: note: expanded from macro '__bf_shf'
   #define __bf_shf(x) (__builtin_ffsll(x) - 1)
                                        ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1579:2: warning: shift count is negative [-Wshift-count-negative]
           RZG2L_GPIO_PORT_PACK(5, 0x3a, RZG2L_MPXED_PIN_FUNCS),
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:39: note: expanded from macro 'RZG2L_GPIO_PORT_PACK'
   #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:64: note: expanded from macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
   #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
                                                    ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:31: note: expanded from macro 'PIN_CFG_PIN_MAP_MASK'
   #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
                                           ^
   include/linux/bits.h:37:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:35:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^
   include/linux/bitfield.h:141:50: note: expanded from macro 'FIELD_PREP_CONST'
                   (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
                                                                  ^~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1580:2: warning: shift count is negative [-Wshift-count-negative]
           RZG2L_GPIO_PORT_PACK(4, 0x3b, RZG2L_MPXED_PIN_FUNCS),
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:39: note: expanded from macro 'RZG2L_GPIO_PORT_PACK'
   #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:64: note: expanded from macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
   #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
                                                    ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:31: note: expanded from macro 'PIN_CFG_PIN_MAP_MASK'
   #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
                                           ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/bits.h:35:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^
   include/linux/bitfield.h:141:39: note: expanded from macro 'FIELD_PREP_CONST'
                   (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
                                              ~~~~~~~~~^~~~~~
   include/linux/bitfield.h:45:38: note: expanded from macro '__bf_shf'
   #define __bf_shf(x) (__builtin_ffsll(x) - 1)
                                        ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1580:2: warning: shift count is negative [-Wshift-count-negative]
           RZG2L_GPIO_PORT_PACK(4, 0x3b, RZG2L_MPXED_PIN_FUNCS),
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:39: note: expanded from macro 'RZG2L_GPIO_PORT_PACK'
   #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:64: note: expanded from macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
   #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
                                                    ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:31: note: expanded from macro 'PIN_CFG_PIN_MAP_MASK'
   #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
                                           ^
   include/linux/bits.h:37:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/linux/bits.h:35:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^
   include/linux/bitfield.h:141:50: note: expanded from macro 'FIELD_PREP_CONST'
                   (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
                                                                  ^~~~~


vim +1579 drivers/pinctrl/renesas/pinctrl-rzg2l.c

c4c4637eb57f2a Lad Prabhakar 2021-07-27  1535  
943be6806bed3f Lad Prabhakar 2024-01-12  1536  static const u64 r9a07g044_gpio_configs[] = {
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1537  	RZG2L_GPIO_PORT_PACK(2, 0x10, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1538  	RZG2L_GPIO_PORT_PACK(2, 0x11, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1539  	RZG2L_GPIO_PORT_PACK(2, 0x12, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1540  	RZG2L_GPIO_PORT_PACK(2, 0x13, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1541  	RZG2L_GPIO_PORT_PACK(2, 0x14, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1542  	RZG2L_GPIO_PORT_PACK(3, 0x15, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1543  	RZG2L_GPIO_PORT_PACK(2, 0x16, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1544  	RZG2L_GPIO_PORT_PACK(3, 0x17, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1545  	RZG2L_GPIO_PORT_PACK(3, 0x18, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1546  	RZG2L_GPIO_PORT_PACK(2, 0x19, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1547  	RZG2L_GPIO_PORT_PACK(2, 0x1a, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1548  	RZG2L_GPIO_PORT_PACK(2, 0x1b, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1549  	RZG2L_GPIO_PORT_PACK(2, 0x1c, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1550  	RZG2L_GPIO_PORT_PACK(3, 0x1d, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1551  	RZG2L_GPIO_PORT_PACK(2, 0x1e, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1552  	RZG2L_GPIO_PORT_PACK(2, 0x1f, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1553  	RZG2L_GPIO_PORT_PACK(2, 0x20, RZG2L_MPXED_PIN_FUNCS),
fcfb63148c241a Biju Das      2021-09-22  1554  	RZG2L_GPIO_PORT_PACK(3, 0x21, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1555  	RZG2L_GPIO_PORT_PACK(2, 0x22, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1556  	RZG2L_GPIO_PORT_PACK(2, 0x23, RZG2L_MPXED_PIN_FUNCS),
22972a2d5bc4ba Lad Prabhakar 2021-11-10  1557  	RZG2L_GPIO_PORT_PACK(3, 0x24, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
22972a2d5bc4ba Lad Prabhakar 2021-11-10  1558  	RZG2L_GPIO_PORT_PACK(2, 0x25, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
22972a2d5bc4ba Lad Prabhakar 2021-11-10  1559  	RZG2L_GPIO_PORT_PACK(2, 0x26, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
22972a2d5bc4ba Lad Prabhakar 2021-11-10  1560  	RZG2L_GPIO_PORT_PACK(2, 0x27, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
22972a2d5bc4ba Lad Prabhakar 2021-11-10  1561  	RZG2L_GPIO_PORT_PACK(2, 0x28, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
22972a2d5bc4ba Lad Prabhakar 2021-11-10  1562  	RZG2L_GPIO_PORT_PACK(2, 0x29, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
22972a2d5bc4ba Lad Prabhakar 2021-11-10  1563  	RZG2L_GPIO_PORT_PACK(2, 0x2a, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
22972a2d5bc4ba Lad Prabhakar 2021-11-10  1564  	RZG2L_GPIO_PORT_PACK(2, 0x2b, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
22972a2d5bc4ba Lad Prabhakar 2021-11-10  1565  	RZG2L_GPIO_PORT_PACK(2, 0x2c, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
22972a2d5bc4ba Lad Prabhakar 2021-11-10  1566  	RZG2L_GPIO_PORT_PACK(2, 0x2d, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
22972a2d5bc4ba Lad Prabhakar 2021-11-10  1567  	RZG2L_GPIO_PORT_PACK(2, 0x2e, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
22972a2d5bc4ba Lad Prabhakar 2021-11-10  1568  	RZG2L_GPIO_PORT_PACK(2, 0x2f, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
22972a2d5bc4ba Lad Prabhakar 2021-11-10  1569  	RZG2L_GPIO_PORT_PACK(2, 0x30, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
22972a2d5bc4ba Lad Prabhakar 2021-11-10  1570  	RZG2L_GPIO_PORT_PACK(2, 0x31, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
22972a2d5bc4ba Lad Prabhakar 2021-11-10  1571  	RZG2L_GPIO_PORT_PACK(2, 0x32, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
22972a2d5bc4ba Lad Prabhakar 2021-11-10  1572  	RZG2L_GPIO_PORT_PACK(2, 0x33, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
22972a2d5bc4ba Lad Prabhakar 2021-11-10  1573  	RZG2L_GPIO_PORT_PACK(2, 0x34, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
22972a2d5bc4ba Lad Prabhakar 2021-11-10  1574  	RZG2L_GPIO_PORT_PACK(3, 0x35, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1575  	RZG2L_GPIO_PORT_PACK(2, 0x36, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1576  	RZG2L_GPIO_PORT_PACK(3, 0x37, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1577  	RZG2L_GPIO_PORT_PACK(3, 0x38, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1578  	RZG2L_GPIO_PORT_PACK(2, 0x39, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27 @1579  	RZG2L_GPIO_PORT_PACK(5, 0x3a, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1580  	RZG2L_GPIO_PORT_PACK(4, 0x3b, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1581  	RZG2L_GPIO_PORT_PACK(4, 0x3c, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1582  	RZG2L_GPIO_PORT_PACK(4, 0x3d, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1583  	RZG2L_GPIO_PORT_PACK(4, 0x3e, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1584  	RZG2L_GPIO_PORT_PACK(4, 0x3f, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1585  	RZG2L_GPIO_PORT_PACK(5, 0x40, RZG2L_MPXED_PIN_FUNCS),
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1586  };
c4c4637eb57f2a Lad Prabhakar 2021-07-27  1587  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

