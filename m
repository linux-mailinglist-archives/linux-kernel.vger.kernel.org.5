Return-Path: <linux-kernel+bounces-25313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1056482CD5C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 16:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8458D1C21440
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 15:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150EE1FBB;
	Sat, 13 Jan 2024 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gvVnn+XW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9248B33DF;
	Sat, 13 Jan 2024 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705157991; x=1736693991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=74bLiqGHu8v7WR007fIT7Ya/IZKeJiUm7m5omNigiM8=;
  b=gvVnn+XWgl4feaErZ/t3SDYeMwCakk4CPCDz8mj/y33DL02h4gOoLMJA
   SFJS1MoWQDjmZxt9adgDn7sWpsV7wLCiqIavj05pKoUSGcZHQax7qeL7E
   34TXik4+5L4/v5SxUY9ZK0aT4fH3kq13H34Pv3VpJx2HH26X2ee+pEqpC
   YCEr0P/WHF+6a3mifEZokx6K9mT6E3oxfWhCb3qGNuGxY2yjabeNXU9cI
   PYZskXwDeFjOQFKobeGFYiygUMXZh1zhvVABjJdQm8Ric6DeZgpblOHjw
   A7er/eisdlpUH5KdZRrgxshPB7F0DTxT3bAohCEJtJ0Tvfyb8kK9QfjR5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="6102259"
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="6102259"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2024 06:59:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="926683481"
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="926683481"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jan 2024 06:59:44 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOfU4-000AbY-2v;
	Sat, 13 Jan 2024 14:59:41 +0000
Date: Sat, 13 Jan 2024 22:59:06 +0800
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
Message-ID: <202401132220.aTrR8ckA-lkp@intel.com>
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
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20240113/202401132220.aTrR8ckA-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240113/202401132220.aTrR8ckA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401132220.aTrR8ckA-lkp@intel.com/

All errors (new ones prefixed by >>):

      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:730:31: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
     730 |         u8 pinmap = FIELD_GET(PIN_CFG_PIN_MAP_MASK, cfg);
         |                               ^~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/bitfield.h:10:
   drivers/pinctrl/renesas/pinctrl-rzg2l.c: At top level:
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:135:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     135 |                 BUILD_BUG_ON_ZERO((_mask) == 0) +                       \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1537:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1537 |         RZG2L_GPIO_PORT_PACK(2, 0x10, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:137:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     137 |                 BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1537:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1537 |         RZG2L_GPIO_PORT_PACK(2, 0x10, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:118:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     118 | #define __BF_CHECK_POW2(n)      BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:139:17: note: in expansion of macro '__BF_CHECK_POW2'
     139 |                 __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +  \
         |                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1537:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1537 |         RZG2L_GPIO_PORT_PACK(2, 0x10, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1537:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1537 |         RZG2L_GPIO_PORT_PACK(2, 0x10, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:141:64: note: in definition of macro 'FIELD_PREP_CONST'
     141 |                 (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
         |                                                                ^~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1537:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1537 |         RZG2L_GPIO_PORT_PACK(2, 0x10, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: error: initializer element is not constant
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1537:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1537 |         RZG2L_GPIO_PORT_PACK(2, 0x10, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: note: (near initialization for 'r9a07g044_gpio_configs[0]')
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1537:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1537 |         RZG2L_GPIO_PORT_PACK(2, 0x10, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:135:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     135 |                 BUILD_BUG_ON_ZERO((_mask) == 0) +                       \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1538:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1538 |         RZG2L_GPIO_PORT_PACK(2, 0x11, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:137:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     137 |                 BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1538:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1538 |         RZG2L_GPIO_PORT_PACK(2, 0x11, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:118:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     118 | #define __BF_CHECK_POW2(n)      BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:139:17: note: in expansion of macro '__BF_CHECK_POW2'
     139 |                 __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +  \
         |                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1538:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1538 |         RZG2L_GPIO_PORT_PACK(2, 0x11, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1538:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1538 |         RZG2L_GPIO_PORT_PACK(2, 0x11, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:141:64: note: in definition of macro 'FIELD_PREP_CONST'
     141 |                 (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
         |                                                                ^~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1538:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1538 |         RZG2L_GPIO_PORT_PACK(2, 0x11, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: error: initializer element is not constant
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1538:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1538 |         RZG2L_GPIO_PORT_PACK(2, 0x11, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: note: (near initialization for 'r9a07g044_gpio_configs[1]')
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1538:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1538 |         RZG2L_GPIO_PORT_PACK(2, 0x11, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:135:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     135 |                 BUILD_BUG_ON_ZERO((_mask) == 0) +                       \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1539:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1539 |         RZG2L_GPIO_PORT_PACK(2, 0x12, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:137:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     137 |                 BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1539:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1539 |         RZG2L_GPIO_PORT_PACK(2, 0x12, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:118:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     118 | #define __BF_CHECK_POW2(n)      BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:139:17: note: in expansion of macro '__BF_CHECK_POW2'
     139 |                 __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +  \
         |                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1539:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1539 |         RZG2L_GPIO_PORT_PACK(2, 0x12, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1539:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1539 |         RZG2L_GPIO_PORT_PACK(2, 0x12, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:141:64: note: in definition of macro 'FIELD_PREP_CONST'
     141 |                 (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
         |                                                                ^~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1539:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1539 |         RZG2L_GPIO_PORT_PACK(2, 0x12, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: error: initializer element is not constant
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1539:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1539 |         RZG2L_GPIO_PORT_PACK(2, 0x12, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: note: (near initialization for 'r9a07g044_gpio_configs[2]')
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1539:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1539 |         RZG2L_GPIO_PORT_PACK(2, 0x12, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:135:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     135 |                 BUILD_BUG_ON_ZERO((_mask) == 0) +                       \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1540:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1540 |         RZG2L_GPIO_PORT_PACK(2, 0x13, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:137:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     137 |                 BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1540:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1540 |         RZG2L_GPIO_PORT_PACK(2, 0x13, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:118:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     118 | #define __BF_CHECK_POW2(n)      BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:139:17: note: in expansion of macro '__BF_CHECK_POW2'
     139 |                 __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +  \
         |                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1540:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1540 |         RZG2L_GPIO_PORT_PACK(2, 0x13, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1540:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1540 |         RZG2L_GPIO_PORT_PACK(2, 0x13, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:141:64: note: in definition of macro 'FIELD_PREP_CONST'
     141 |                 (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
         |                                                                ^~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1540:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1540 |         RZG2L_GPIO_PORT_PACK(2, 0x13, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: error: initializer element is not constant
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1540:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1540 |         RZG2L_GPIO_PORT_PACK(2, 0x13, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: note: (near initialization for 'r9a07g044_gpio_configs[3]')
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1540:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1540 |         RZG2L_GPIO_PORT_PACK(2, 0x13, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:135:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     135 |                 BUILD_BUG_ON_ZERO((_mask) == 0) +                       \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1541:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1541 |         RZG2L_GPIO_PORT_PACK(2, 0x14, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:137:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     137 |                 BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1541:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1541 |         RZG2L_GPIO_PORT_PACK(2, 0x14, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:118:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     118 | #define __BF_CHECK_POW2(n)      BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:139:17: note: in expansion of macro '__BF_CHECK_POW2'
     139 |                 __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +  \
         |                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1541:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1541 |         RZG2L_GPIO_PORT_PACK(2, 0x14, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1541:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1541 |         RZG2L_GPIO_PORT_PACK(2, 0x14, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:141:64: note: in definition of macro 'FIELD_PREP_CONST'
     141 |                 (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
         |                                                                ^~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1541:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1541 |         RZG2L_GPIO_PORT_PACK(2, 0x14, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: error: initializer element is not constant
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1541:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1541 |         RZG2L_GPIO_PORT_PACK(2, 0x14, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: note: (near initialization for 'r9a07g044_gpio_configs[4]')
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1541:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1541 |         RZG2L_GPIO_PORT_PACK(2, 0x14, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:135:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     135 |                 BUILD_BUG_ON_ZERO((_mask) == 0) +                       \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1542:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1542 |         RZG2L_GPIO_PORT_PACK(3, 0x15, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:137:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     137 |                 BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1542:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1542 |         RZG2L_GPIO_PORT_PACK(3, 0x15, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:118:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     118 | #define __BF_CHECK_POW2(n)      BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:139:17: note: in expansion of macro '__BF_CHECK_POW2'
     139 |                 __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +  \
         |                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1542:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1542 |         RZG2L_GPIO_PORT_PACK(3, 0x15, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1542:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1542 |         RZG2L_GPIO_PORT_PACK(3, 0x15, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:141:64: note: in definition of macro 'FIELD_PREP_CONST'
     141 |                 (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
         |                                                                ^~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1542:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1542 |         RZG2L_GPIO_PORT_PACK(3, 0x15, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: error: initializer element is not constant
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1542:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1542 |         RZG2L_GPIO_PORT_PACK(3, 0x15, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: note: (near initialization for 'r9a07g044_gpio_configs[5]')
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1542:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1542 |         RZG2L_GPIO_PORT_PACK(3, 0x15, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:135:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     135 |                 BUILD_BUG_ON_ZERO((_mask) == 0) +                       \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1543:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1543 |         RZG2L_GPIO_PORT_PACK(2, 0x16, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:137:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     137 |                 BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1543:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1543 |         RZG2L_GPIO_PORT_PACK(2, 0x16, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:118:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     118 | #define __BF_CHECK_POW2(n)      BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:139:17: note: in expansion of macro '__BF_CHECK_POW2'
     139 |                 __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +  \
         |                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1543:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1543 |         RZG2L_GPIO_PORT_PACK(2, 0x16, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1543:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1543 |         RZG2L_GPIO_PORT_PACK(2, 0x16, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:141:64: note: in definition of macro 'FIELD_PREP_CONST'
     141 |                 (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
         |                                                                ^~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1543:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1543 |         RZG2L_GPIO_PORT_PACK(2, 0x16, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: error: initializer element is not constant
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1543:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1543 |         RZG2L_GPIO_PORT_PACK(2, 0x16, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: note: (near initialization for 'r9a07g044_gpio_configs[6]')
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1543:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1543 |         RZG2L_GPIO_PORT_PACK(2, 0x16, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:135:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     135 |                 BUILD_BUG_ON_ZERO((_mask) == 0) +                       \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1544:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1544 |         RZG2L_GPIO_PORT_PACK(3, 0x17, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:137:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     137 |                 BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1544:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1544 |         RZG2L_GPIO_PORT_PACK(3, 0x17, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:118:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     118 | #define __BF_CHECK_POW2(n)      BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:139:17: note: in expansion of macro '__BF_CHECK_POW2'
     139 |                 __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +  \
         |                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1544:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1544 |         RZG2L_GPIO_PORT_PACK(3, 0x17, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1544:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1544 |         RZG2L_GPIO_PORT_PACK(3, 0x17, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:141:64: note: in definition of macro 'FIELD_PREP_CONST'
     141 |                 (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
         |                                                                ^~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1544:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1544 |         RZG2L_GPIO_PORT_PACK(3, 0x17, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: error: initializer element is not constant
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1544:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1544 |         RZG2L_GPIO_PORT_PACK(3, 0x17, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: note: (near initialization for 'r9a07g044_gpio_configs[7]')
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1544:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1544 |         RZG2L_GPIO_PORT_PACK(3, 0x17, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:135:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     135 |                 BUILD_BUG_ON_ZERO((_mask) == 0) +                       \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1545:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1545 |         RZG2L_GPIO_PORT_PACK(3, 0x18, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:137:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     137 |                 BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1545:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1545 |         RZG2L_GPIO_PORT_PACK(3, 0x18, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:118:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     118 | #define __BF_CHECK_POW2(n)      BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:139:17: note: in expansion of macro '__BF_CHECK_POW2'
     139 |                 __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +  \
         |                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1545:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1545 |         RZG2L_GPIO_PORT_PACK(3, 0x18, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1545:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1545 |         RZG2L_GPIO_PORT_PACK(3, 0x18, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:141:64: note: in definition of macro 'FIELD_PREP_CONST'
     141 |                 (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
         |                                                                ^~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1545:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1545 |         RZG2L_GPIO_PORT_PACK(3, 0x18, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: error: initializer element is not constant
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1545:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1545 |         RZG2L_GPIO_PORT_PACK(3, 0x18, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: note: (near initialization for 'r9a07g044_gpio_configs[8]')
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1545:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1545 |         RZG2L_GPIO_PORT_PACK(3, 0x18, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:135:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     135 |                 BUILD_BUG_ON_ZERO((_mask) == 0) +                       \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1546:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1546 |         RZG2L_GPIO_PORT_PACK(2, 0x19, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:137:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     137 |                 BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1546:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1546 |         RZG2L_GPIO_PORT_PACK(2, 0x19, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:118:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     118 | #define __BF_CHECK_POW2(n)      BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:139:17: note: in expansion of macro '__BF_CHECK_POW2'
     139 |                 __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +  \
         |                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1546:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1546 |         RZG2L_GPIO_PORT_PACK(2, 0x19, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1546:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1546 |         RZG2L_GPIO_PORT_PACK(2, 0x19, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:141:64: note: in definition of macro 'FIELD_PREP_CONST'
     141 |                 (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
         |                                                                ^~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1546:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1546 |         RZG2L_GPIO_PORT_PACK(2, 0x19, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: error: initializer element is not constant
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1546:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1546 |         RZG2L_GPIO_PORT_PACK(2, 0x19, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: note: (near initialization for 'r9a07g044_gpio_configs[9]')
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1546:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1546 |         RZG2L_GPIO_PORT_PACK(2, 0x19, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:135:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     135 |                 BUILD_BUG_ON_ZERO((_mask) == 0) +                       \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1547:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1547 |         RZG2L_GPIO_PORT_PACK(2, 0x1a, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:137:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     137 |                 BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1547:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1547 |         RZG2L_GPIO_PORT_PACK(2, 0x1a, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:118:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     118 | #define __BF_CHECK_POW2(n)      BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:139:17: note: in expansion of macro '__BF_CHECK_POW2'
     139 |                 __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +  \
         |                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1547:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1547 |         RZG2L_GPIO_PORT_PACK(2, 0x1a, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1547:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1547 |         RZG2L_GPIO_PORT_PACK(2, 0x1a, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:141:64: note: in definition of macro 'FIELD_PREP_CONST'
     141 |                 (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
         |                                                                ^~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1547:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1547 |         RZG2L_GPIO_PORT_PACK(2, 0x1a, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: error: initializer element is not constant
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1547:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1547 |         RZG2L_GPIO_PORT_PACK(2, 0x1a, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: note: (near initialization for 'r9a07g044_gpio_configs[10]')
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1547:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1547 |         RZG2L_GPIO_PORT_PACK(2, 0x1a, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:135:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     135 |                 BUILD_BUG_ON_ZERO((_mask) == 0) +                       \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1548:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1548 |         RZG2L_GPIO_PORT_PACK(2, 0x1b, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:137:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     137 |                 BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1548:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1548 |         RZG2L_GPIO_PORT_PACK(2, 0x1b, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:118:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     118 | #define __BF_CHECK_POW2(n)      BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:139:17: note: in expansion of macro '__BF_CHECK_POW2'
     139 |                 __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +  \
         |                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1548:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1548 |         RZG2L_GPIO_PORT_PACK(2, 0x1b, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1548:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1548 |         RZG2L_GPIO_PORT_PACK(2, 0x1b, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:141:64: note: in definition of macro 'FIELD_PREP_CONST'
     141 |                 (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
         |                                                                ^~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1548:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1548 |         RZG2L_GPIO_PORT_PACK(2, 0x1b, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: error: initializer element is not constant
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1548:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1548 |         RZG2L_GPIO_PORT_PACK(2, 0x1b, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: note: (near initialization for 'r9a07g044_gpio_configs[11]')
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1548:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1548 |         RZG2L_GPIO_PORT_PACK(2, 0x1b, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:135:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     135 |                 BUILD_BUG_ON_ZERO((_mask) == 0) +                       \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1549:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1549 |         RZG2L_GPIO_PORT_PACK(2, 0x1c, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:137:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     137 |                 BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1549:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1549 |         RZG2L_GPIO_PORT_PACK(2, 0x1c, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:118:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     118 | #define __BF_CHECK_POW2(n)      BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:139:17: note: in expansion of macro '__BF_CHECK_POW2'
     139 |                 __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +  \
         |                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1549:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1549 |         RZG2L_GPIO_PORT_PACK(2, 0x1c, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1549:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1549 |         RZG2L_GPIO_PORT_PACK(2, 0x1c, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:141:64: note: in definition of macro 'FIELD_PREP_CONST'
     141 |                 (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
         |                                                                ^~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1549:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1549 |         RZG2L_GPIO_PORT_PACK(2, 0x1c, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: error: initializer element is not constant
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1549:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1549 |         RZG2L_GPIO_PORT_PACK(2, 0x1c, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: note: (near initialization for 'r9a07g044_gpio_configs[12]')
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1549:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1549 |         RZG2L_GPIO_PORT_PACK(2, 0x1c, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:135:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     135 |                 BUILD_BUG_ON_ZERO((_mask) == 0) +                       \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1550:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1550 |         RZG2L_GPIO_PORT_PACK(3, 0x1d, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:137:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     137 |                 BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1550:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1550 |         RZG2L_GPIO_PORT_PACK(3, 0x1d, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:118:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     118 | #define __BF_CHECK_POW2(n)      BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:139:17: note: in expansion of macro '__BF_CHECK_POW2'
     139 |                 __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +  \
         |                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1550:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1550 |         RZG2L_GPIO_PORT_PACK(3, 0x1d, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1550:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1550 |         RZG2L_GPIO_PORT_PACK(3, 0x1d, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:141:64: note: in definition of macro 'FIELD_PREP_CONST'
     141 |                 (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
         |                                                                ^~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1550:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1550 |         RZG2L_GPIO_PORT_PACK(3, 0x1d, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: error: initializer element is not constant
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1550:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1550 |         RZG2L_GPIO_PORT_PACK(3, 0x1d, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: note: (near initialization for 'r9a07g044_gpio_configs[13]')
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1550:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1550 |         RZG2L_GPIO_PORT_PACK(3, 0x1d, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:135:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     135 |                 BUILD_BUG_ON_ZERO((_mask) == 0) +                       \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1551:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1551 |         RZG2L_GPIO_PORT_PACK(2, 0x1e, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:137:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     137 |                 BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1551:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1551 |         RZG2L_GPIO_PORT_PACK(2, 0x1e, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:118:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     118 | #define __BF_CHECK_POW2(n)      BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:139:17: note: in expansion of macro '__BF_CHECK_POW2'
     139 |                 __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +  \
         |                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1551:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1551 |         RZG2L_GPIO_PORT_PACK(2, 0x1e, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1551:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1551 |         RZG2L_GPIO_PORT_PACK(2, 0x1e, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:141:64: note: in definition of macro 'FIELD_PREP_CONST'
     141 |                 (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
         |                                                                ^~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1551:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1551 |         RZG2L_GPIO_PORT_PACK(2, 0x1e, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: error: initializer element is not constant
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1551:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1551 |         RZG2L_GPIO_PORT_PACK(2, 0x1e, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: note: (near initialization for 'r9a07g044_gpio_configs[14]')
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1551:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1551 |         RZG2L_GPIO_PORT_PACK(2, 0x1e, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:135:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     135 |                 BUILD_BUG_ON_ZERO((_mask) == 0) +                       \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1552:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1552 |         RZG2L_GPIO_PORT_PACK(2, 0x1f, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:137:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     137 |                 BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1552:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1552 |         RZG2L_GPIO_PORT_PACK(2, 0x1f, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:118:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     118 | #define __BF_CHECK_POW2(n)      BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:139:17: note: in expansion of macro '__BF_CHECK_POW2'
     139 |                 __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +  \
         |                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1552:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1552 |         RZG2L_GPIO_PORT_PACK(2, 0x1f, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1552:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1552 |         RZG2L_GPIO_PORT_PACK(2, 0x1f, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:141:64: note: in definition of macro 'FIELD_PREP_CONST'
     141 |                 (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
         |                                                                ^~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1552:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1552 |         RZG2L_GPIO_PORT_PACK(2, 0x1f, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: error: initializer element is not constant
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1552:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1552 |         RZG2L_GPIO_PORT_PACK(2, 0x1f, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: note: (near initialization for 'r9a07g044_gpio_configs[15]')
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1552:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1552 |         RZG2L_GPIO_PORT_PACK(2, 0x1f, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:135:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     135 |                 BUILD_BUG_ON_ZERO((_mask) == 0) +                       \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1553:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1553 |         RZG2L_GPIO_PORT_PACK(2, 0x20, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:137:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     137 |                 BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1553:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1553 |         RZG2L_GPIO_PORT_PACK(2, 0x20, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:118:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     118 | #define __BF_CHECK_POW2(n)      BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:139:17: note: in expansion of macro '__BF_CHECK_POW2'
     139 |                 __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +  \
         |                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1553:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1553 |         RZG2L_GPIO_PORT_PACK(2, 0x20, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1553:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1553 |         RZG2L_GPIO_PORT_PACK(2, 0x20, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:141:64: note: in definition of macro 'FIELD_PREP_CONST'
     141 |                 (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
         |                                                                ^~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1553:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1553 |         RZG2L_GPIO_PORT_PACK(2, 0x20, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: error: initializer element is not constant
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1553:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1553 |         RZG2L_GPIO_PORT_PACK(2, 0x20, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: note: (near initialization for 'r9a07g044_gpio_configs[16]')
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1553:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1553 |         RZG2L_GPIO_PORT_PACK(2, 0x20, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:135:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     135 |                 BUILD_BUG_ON_ZERO((_mask) == 0) +                       \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1554:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1554 |         RZG2L_GPIO_PORT_PACK(3, 0x21, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:137:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     137 |                 BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1554:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1554 |         RZG2L_GPIO_PORT_PACK(3, 0x21, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:118:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     118 | #define __BF_CHECK_POW2(n)      BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:139:17: note: in expansion of macro '__BF_CHECK_POW2'
     139 |                 __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +  \
         |                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1554:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1554 |         RZG2L_GPIO_PORT_PACK(3, 0x21, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1554:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1554 |         RZG2L_GPIO_PORT_PACK(3, 0x21, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:141:64: note: in definition of macro 'FIELD_PREP_CONST'
     141 |                 (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
         |                                                                ^~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1554:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1554 |         RZG2L_GPIO_PORT_PACK(3, 0x21, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: error: initializer element is not constant
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1554:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1554 |         RZG2L_GPIO_PORT_PACK(3, 0x21, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: note: (near initialization for 'r9a07g044_gpio_configs[17]')
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1554:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1554 |         RZG2L_GPIO_PORT_PACK(3, 0x21, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:135:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     135 |                 BUILD_BUG_ON_ZERO((_mask) == 0) +                       \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1555:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1555 |         RZG2L_GPIO_PORT_PACK(2, 0x22, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:137:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     137 |                 BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1555:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1555 |         RZG2L_GPIO_PORT_PACK(2, 0x22, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:118:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     118 | #define __BF_CHECK_POW2(n)      BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:139:17: note: in expansion of macro '__BF_CHECK_POW2'
     139 |                 __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +  \
         |                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1555:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1555 |         RZG2L_GPIO_PORT_PACK(2, 0x22, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1555:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1555 |         RZG2L_GPIO_PORT_PACK(2, 0x22, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:141:64: note: in definition of macro 'FIELD_PREP_CONST'
     141 |                 (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
         |                                                                ^~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1555:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1555 |         RZG2L_GPIO_PORT_PACK(2, 0x22, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: error: initializer element is not constant
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1555:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1555 |         RZG2L_GPIO_PORT_PACK(2, 0x22, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: note: (near initialization for 'r9a07g044_gpio_configs[18]')
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1555:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1555 |         RZG2L_GPIO_PORT_PACK(2, 0x22, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:135:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     135 |                 BUILD_BUG_ON_ZERO((_mask) == 0) +                       \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1556:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1556 |         RZG2L_GPIO_PORT_PACK(2, 0x23, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:137:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     137 |                 BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1556:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1556 |         RZG2L_GPIO_PORT_PACK(2, 0x23, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:118:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     118 | #define __BF_CHECK_POW2(n)      BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:139:17: note: in expansion of macro '__BF_CHECK_POW2'
     139 |                 __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +  \
         |                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1556:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1556 |         RZG2L_GPIO_PORT_PACK(2, 0x23, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1556:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1556 |         RZG2L_GPIO_PORT_PACK(2, 0x23, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:141:64: note: in definition of macro 'FIELD_PREP_CONST'
     141 |                 (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
         |                                                                ^~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1556:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1556 |         RZG2L_GPIO_PORT_PACK(2, 0x23, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: error: initializer element is not constant
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1556:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1556 |         RZG2L_GPIO_PORT_PACK(2, 0x23, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:49: note: (near initialization for 'r9a07g044_gpio_configs[19]')
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                 ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1556:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1556 |         RZG2L_GPIO_PORT_PACK(2, 0x23, RZG2L_MPXED_PIN_FUNCS),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:135:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     135 |                 BUILD_BUG_ON_ZERO((_mask) == 0) +                       \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1557:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1557 |         RZG2L_GPIO_PORT_PACK(3, 0x24, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:137:17: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     137 |                 BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
         |                 ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1557:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1557 |         RZG2L_GPIO_PORT_PACK(3, 0x24, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bitfield.h:118:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     118 | #define __BF_CHECK_POW2(n)      BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:139:17: note: in expansion of macro '__BF_CHECK_POW2'
     139 |                 __BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +  \
         |                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1557:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1557 |         RZG2L_GPIO_PORT_PACK(3, 0x24, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:50: note: in expansion of macro 'FIELD_PREP_CONST'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                  ^~~~~~~~~~~~~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)
         |                                         ^~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:89:67: note: in expansion of macro 'PIN_CFG_PIN_MAP_MASK'
      89 | #define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)    (FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
         |                                                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:97:41: note: in expansion of macro 'RZG2L_GPIO_PORT_SPARSE_PACK'
      97 | #define RZG2L_GPIO_PORT_PACK(n, a, f)   RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1557:9: note: in expansion of macro 'RZG2L_GPIO_PORT_PACK'
    1557 |         RZG2L_GPIO_PORT_PACK(3, 0x24, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:141:64: note: in definition of macro 'FIELD_PREP_CONST'
     141 |                 (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))  \
         |                                                                ^~~~~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:81:41: note: in expansion of macro 'GENMASK'
      81 | #define PIN_CFG_PIN_MAP_MASK            GENMASK(35, 28)


vim +89 drivers/pinctrl/renesas/pinctrl-rzg2l.c

    84	
    85	/*
    86	 * m indicates the bitmap of supported pins, a is the register index
    87	 * and f is pin configuration capabilities supported.
    88	 */
  > 89	#define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)	(FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
    90							 FIELD_PREP_CONST(PIN_CFG_PIN_REG_MASK, (a)) | \
    91							 FIELD_PREP_CONST(PIN_CFG_MASK, (f)))
    92	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

