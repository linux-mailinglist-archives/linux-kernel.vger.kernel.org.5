Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB37B80BC98
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 19:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjLJSi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 13:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJSi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 13:38:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C07D9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 10:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702233544; x=1733769544;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yZPjUxkFLiPX8k3u4sPW4suufDHVdQ5WASfxAHGJMHY=;
  b=ZpAtoKtQ+UrXNTorflv5TOoNyBc4N5pKccKBm0gD1H7+6cg50xkgbyEx
   x8Ro7ubmyoVhMdrjvDKIEkU11j7XBBKJoNkTMo3ghlVs31/yMnlK9nw0P
   dtIAdr8h/A1NnZub47l5xvj45zYimbe8eTgjxyCk1xxA6FOx2DBo647s/
   lFu0HcO9iWrvCjLK48gESw5XUmD+tMOAVpsm/w1y+ZBtlpyLSqw7i1KRk
   iGmpxlW4p+iuUiargATF3klgrxPULPUUPW5oDd4+Kh3AQJhkhxwBxdHd4
   ZzutQk6RMbsehvYb4crSVhp+2h+A/g/blDkMaUseemsIM18x6J3dl8Za4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1688158"
X-IronPort-AV: E=Sophos;i="6.04,266,1695711600"; 
   d="scan'208";a="1688158"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 10:39:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="807018019"
X-IronPort-AV: E=Sophos;i="6.04,266,1695711600"; 
   d="scan'208";a="807018019"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Dec 2023 10:39:01 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCOhf-000HAs-1o;
        Sun, 10 Dec 2023 18:38:59 +0000
Date:   Mon, 11 Dec 2023 02:38:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: drivers/pinctrl/mediatek/pinctrl-mt7986.c:68: warning: Enum value
 'GPIO_BASE' not described in enum '(anonymous)'
Message-ID: <202312110210.x3vxq42A-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c527f5606aa545233a4d2c6d5c636ed82b8633ef
commit: 360de67280641e451bc944a06bab64ddbeaa7fb9 pinctrl: mediatek: add support for MT7986 SoC
date:   2 years, 2 months ago
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20231211/202312110210.x3vxq42A-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231211/202312110210.x3vxq42A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312110210.x3vxq42A-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pinctrl/mediatek/pinctrl-mt7986.c:68: warning: Enum value 'GPIO_BASE' not described in enum '(anonymous)'
>> drivers/pinctrl/mediatek/pinctrl-mt7986.c:68: warning: Enum value 'IOCFG_RT_BASE' not described in enum '(anonymous)'
>> drivers/pinctrl/mediatek/pinctrl-mt7986.c:68: warning: Enum value 'IOCFG_RB_BASE' not described in enum '(anonymous)'
   drivers/pinctrl/mediatek/pinctrl-mt7986.c:68: warning: Enum value 'IOCFG_LT_BASE' not described in enum '(anonymous)'
>> drivers/pinctrl/mediatek/pinctrl-mt7986.c:68: warning: Enum value 'IOCFG_LB_BASE' not described in enum '(anonymous)'
   drivers/pinctrl/mediatek/pinctrl-mt7986.c:68: warning: Enum value 'IOCFG_TR_BASE' not described in enum '(anonymous)'
   drivers/pinctrl/mediatek/pinctrl-mt7986.c:68: warning: Enum value 'IOCFG_TL_BASE' not described in enum '(anonymous)'


vim +68 drivers/pinctrl/mediatek/pinctrl-mt7986.c

    13	
    14	#define PIN_FIELD_BASE(_s_pin, _e_pin, _i_base, _s_addr, _x_addrs, _s_bit,	\
    15				_x_bits)	\
    16			PIN_FIELD_CALC(_s_pin, _e_pin, _i_base, _s_addr, _x_addrs, _s_bit,	\
    17				_x_bits, 32, 0)
    18	
    19	/**
    20	 * enum - Locking variants of the iocfg bases
    21	 *
    22	 * MT7986 have multiple bases to program pin configuration listed as the below:
    23	 * iocfg_rt:0x11c30000, iocfg_rb:0x11c40000, iocfg_lt:0x11e20000,
    24	 * iocfg_lb:0x11e30000, iocfg_tr:0x11f00000, iocfg_tl:0x11f10000,
    25	 * _i_based could be used to indicate what base the pin should be mapped into.
    26	 *
    27	 * Each iocfg register base control different group of pads on the SoC
    28	 *
    29	 *
    30	 *  chip carrier
    31	 *
    32	 *      A  B  C  D  E  F  G  H
    33	 *    +------------------------+
    34	 *  8 | o  o  o  o  o  o  o  o |
    35	 *  7 | o  o  o  o  o  o  o  o |
    36	 *  6 | o  o  o  o  o  o  o  o |
    37	 *  5 | o  o  o  o  o  o  o  o |
    38	 *  4 | o  o  o  o  o  o  o  o |
    39	 *  3 | o  o  o  o  o  o  o  o |
    40	 *  2 | o  o  o  o  o  o  o  o |
    41	 *  1 | o  o  o  o  o  o  o  o |
    42	 *    +------------------------+
    43	 *
    44	 *  inside Chip carrier
    45	 *
    46	 *      A  B  C  D  E  F  G  H
    47	 *    +------------------------+
    48	 *  8 |                        |
    49	 *  7 |        TL  TR          |
    50	 *  6 |      +---------+       |
    51	 *  5 |   LT |         | RT    |
    52	 *  4 |      |         |       |
    53	 *  3 |   LB |         | RB    |
    54	 *  2 |      +---------+       |
    55	 *  1 |                        |
    56	 *    +------------------------+
    57	 *
    58	 */
    59	
    60	enum {
    61		GPIO_BASE,
    62		IOCFG_RT_BASE,
    63		IOCFG_RB_BASE,
    64		IOCFG_LT_BASE,
    65		IOCFG_LB_BASE,
    66		IOCFG_TR_BASE,
    67		IOCFG_TL_BASE,
  > 68	};
    69	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
