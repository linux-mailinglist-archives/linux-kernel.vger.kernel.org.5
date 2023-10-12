Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF027C7222
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379296AbjJLQK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347319AbjJLQKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:10:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E006BCF;
        Thu, 12 Oct 2023 09:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697127049; x=1728663049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3IH5e6EedPYjjBu7HJ8a7UL28mXZ/IialhDv2GNxLp8=;
  b=fee+Jbvcd9FwiZ1q+SivBIt8Qv08XZQ2fqPVDzK6UkdUGwMGUMCh+enM
   tLI6298Y/SCBLaADr4KRtNMq8RUeEFxyrdSEVCarkbSxX9h+GO/3dkMsk
   vSSsW2U0M4fqULyDK+8M4Rumq/6epuarIZQSi9ezDoVDFffhvyelL/nxr
   dFU4yL1WK+amZptpQIFehZ8BYwKqsEmT+9tGT1hb4BCTBfKnffBTwKkh9
   D0ycv5HFEMTOn1wNobbzKqxggLYtNHuUsPd6ApK0ZuAHvA/BUpBnzSV4D
   Yy3cgGEEC/ULUOEwswnHlXNO2qvoeUXzfCPw4ZQJwpPsSg4HIHONKQKnk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="3564391"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="3564391"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 09:10:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="758088082"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="758088082"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 12 Oct 2023 09:10:43 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqyGn-0003cJ-1h;
        Thu, 12 Oct 2023 16:10:41 +0000
Date:   Fri, 13 Oct 2023 00:10:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     oe-kbuild-all@lists.linux.dev, Michael Walle <michael@walle.cc>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v13 4/6] nvmem: core: Rework layouts to become regular
 devices
Message-ID: <202310130059.4jnO98k6-lkp@intel.com>
References: <20231011111529.86440-5-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011111529.86440-5-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.6-rc5 next-20231012]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miquel-Raynal/of-device-Export-of_device_make_bus_id/20231011-191637
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231011111529.86440-5-miquel.raynal%40bootlin.com
patch subject: [PATCH v13 4/6] nvmem: core: Rework layouts to become regular devices
config: um-randconfig-001-20231012 (https://download.01.org/0day-ci/archive/20231013/202310130059.4jnO98k6-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231013/202310130059.4jnO98k6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310130059.4jnO98k6-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: drivers/nvmem/core.o: in function `nvmem_layout_get_match_data':
   core.c:(.text+0x2ed): undefined reference to `of_nvmem_layout_get_container'
   /usr/bin/ld: drivers/nvmem/core.o: in function `nvmem_register':
   core.c:(.text+0x193d): undefined reference to `of_nvmem_layout_get_container'
   /usr/bin/ld: drivers/nvmem/layouts/sl28vpd.o: in function `sl28vpd_add_cells':
   sl28vpd.c:(.text+0x1fa): undefined reference to `of_nvmem_layout_get_container'
   /usr/bin/ld: drivers/nvmem/layouts/sl28vpd.o: in function `sl28vpd_layout_init':
>> sl28vpd.c:(.init.text+0x9): undefined reference to `nvmem_layout_driver_register'
   /usr/bin/ld: drivers/nvmem/layouts/sl28vpd.o: in function `sl28vpd_layout_exit':
>> sl28vpd.c:(.exit.text+0x9): undefined reference to `nvmem_layout_driver_unregister'
   /usr/bin/ld: drivers/nvmem/layouts/onie-tlv.o: in function `onie_tlv_parse_table':
   onie-tlv.c:(.text+0x1c2): undefined reference to `of_nvmem_layout_get_container'
   /usr/bin/ld: drivers/nvmem/layouts/onie-tlv.o: in function `onie_tlv_layout_init':
>> onie-tlv.c:(.init.text+0x9): undefined reference to `nvmem_layout_driver_register'
   /usr/bin/ld: drivers/nvmem/layouts/onie-tlv.o: in function `onie_tlv_layout_exit':
>> onie-tlv.c:(.exit.text+0x9): undefined reference to `nvmem_layout_driver_unregister'
   collect2: error: ld returned 1 exit status

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
