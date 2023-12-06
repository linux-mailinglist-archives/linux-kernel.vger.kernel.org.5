Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6136806625
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 05:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjLFEYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 23:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjLFEYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 23:24:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A5ED46;
        Tue,  5 Dec 2023 20:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701836681; x=1733372681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h4+9QXz80nPqdIE6m1NyWQGvcxtDrnbM7zgzhRzWAXo=;
  b=jhSbLp3qPvMU21z0XK5EDTICqpwpU6pvVQ+HUowIeZRZviMOADqIsebR
   QxtTYJGCBOwQcSADQ07NnYne9bvGoaIHMDyFPJc76aM7Vh7p9irnYgiYs
   5sbVML4CNgHOMhK1lOfsvmCu2A8R0NzPZP56C/8UYodMWJqzJPsDUKBOU
   Q0QtvJhHhC3BN1OYTMbGW3UAxjTOdIGyWxpQo7AYM9K/aBBsbmnC4ciWx
   xx2jQ9C3cJimKGlBxRxvLq5zgCwNfFJPfwBCc2NmN96VZlwcez5izx7cS
   Fcsi6D3JjeN21ACHVs9eTZduFzovkCbPAbr1jwTbNwrPMuIPRGBZdN2i6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="396794385"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="396794385"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 20:24:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="837189478"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="837189478"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 05 Dec 2023 20:24:35 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAjSb-000AFa-0c;
        Wed, 06 Dec 2023 04:24:33 +0000
Date:   Wed, 6 Dec 2023 12:23:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
        lenb@kernel.org, hdegoede@redhat.com, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alexander.deucher@amd.com, Lijo.Lazar@amd.com,
        mario.limonciello@amd.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, majun@amd.com,
        Evan Quan <quanliangl@hotmail.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: Re: [PATCH v14 4/9] wifi: mac80211: Add support for WBRF features
Message-ID: <202312061221.VlhfjRyI-lkp@intel.com>
References: <20231129091348.3972539-5-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129091348.3972539-5-Jun.Ma2@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ma,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.7-rc1]
[also build test ERROR on next-20231205]
[cannot apply to drm-misc/drm-misc-next wireless-next/main wireless/main linus/master v6.7-rc3 v6.7-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ma-Jun/Documentation-driver-api-Add-document-about-WBRF-mechanism/20231129-181516
base:   v6.7-rc1
patch link:    https://lore.kernel.org/r/20231129091348.3972539-5-Jun.Ma2%40amd.com
patch subject: [PATCH v14 4/9] wifi: mac80211: Add support for WBRF features
config: hexagon-randconfig-002-20231201 (https://download.01.org/0day-ci/archive/20231206/202312061221.VlhfjRyI-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312061221.VlhfjRyI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312061221.VlhfjRyI-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/mac80211/wbrf.c:10:
   In file included from include/net/cfg80211.h:13:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from net/mac80211/wbrf.c:10:
   In file included from include/net/cfg80211.h:13:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from net/mac80211/wbrf.c:10:
   In file included from include/net/cfg80211.h:13:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> net/mac80211/wbrf.c:79:2: error: call to undeclared function 'acpi_amd_wbrf_add_remove'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      79 |         acpi_amd_wbrf_add_remove(dev, WBRF_RECORD_ADD, &ranges_in);
         |         ^
   net/mac80211/wbrf.c:94:2: error: call to undeclared function 'acpi_amd_wbrf_add_remove'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      94 |         acpi_amd_wbrf_add_remove(dev, WBRF_RECORD_REMOVE, &ranges_in);
         |         ^
   6 warnings and 2 errors generated.


vim +/acpi_amd_wbrf_add_remove +79 net/mac80211/wbrf.c

    66	
    67	void ieee80211_add_wbrf(struct ieee80211_local *local, struct cfg80211_chan_def *chandef)
    68	{
    69		struct wbrf_ranges_in_out ranges_in = {0};
    70		struct device *dev;
    71	
    72		if (!local->wbrf_supported)
    73			return;
    74	
    75		dev = local->hw.wiphy->dev.parent;
    76	
    77		get_ranges_from_chandef(chandef, &ranges_in);
    78	
  > 79		acpi_amd_wbrf_add_remove(dev, WBRF_RECORD_ADD, &ranges_in);
    80	}
    81	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
