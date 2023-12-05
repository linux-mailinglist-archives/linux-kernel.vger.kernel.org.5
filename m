Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46662804A43
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 07:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344485AbjLEGhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 01:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344429AbjLEGhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 01:37:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29301135;
        Mon,  4 Dec 2023 22:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701758229; x=1733294229;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F4InaQp/5As/bJn0SZDnulbk5E33HqfsSfpQ2I/hFac=;
  b=DhAb3hbEPLTTAx2xP2MmhfGLOilAwt1ib18HigOKWjonVvujSec7mNX/
   UFWiYrWvO4kzehZFf5CIkF1+LPBdfkzxrrUXOfTysMuY+E/03QkdHy2RA
   q4sWZHUTWHgmi3v7MJY+iaEqvqS9B3thprmxrkUiSaHrjX1YtUJmjOt9+
   dsk3YMzd+727RvF2EIUUkfEZtt0tIyEzBd3lBU9SECjNWYUu17LuF4XL5
   j1/nb5RK/ncwv5aGC1iMbjr4EA/QtfD8bfcX6Qesjn3L+TKX/FuSJcBGL
   vZVFgqxk+G1mSg/IDW8zh3D7O+Bh6fyCx1IaLZm4GPfs74dkX6zfWm2iD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="374035389"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="374035389"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 22:37:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="764224101"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="764224101"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 04 Dec 2023 22:37:03 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAP3F-0008RU-1R;
        Tue, 05 Dec 2023 06:37:01 +0000
Date:   Tue, 5 Dec 2023 14:36:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Jeff LaBundy <jeff@labundy.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        catalin.popescu@leica-geosystems.com,
        mark.satterthwaite@touchnetix.com, bartp@baasheep.co.uk,
        hannah.rossiter@touchnetix.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        bsp-development.geo@leica-geosystems.com,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH v4 3/3] Input: Add TouchNetix axiom i2c touchscreen driver
Message-ID: <202312051457.y3N1q3sZ-lkp@intel.com>
References: <20231204140505.2838916-4-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204140505.2838916-4-kamel.bouhara@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on dtor-input/for-linus robh/for-next linus/master krzk-dt/for-next v6.7-rc4 next-20231204]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kamel-Bouhara/dt-bindings-vendor-prefixes-Add-TouchNetix-AS/20231204-222017
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20231204140505.2838916-4-kamel.bouhara%40bootlin.com
patch subject: [PATCH v4 3/3] Input: Add TouchNetix axiom i2c touchscreen driver
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231205/202312051457.y3N1q3sZ-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312051457.y3N1q3sZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312051457.y3N1q3sZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/input/touchscreen/touchnetix_axiom.c: In function 'axiom_usage_to_target_address':
>> drivers/input/touchscreen/touchnetix_axiom.c:142:31: warning: variable 'device_info' set but not used [-Wunused-but-set-variable]
     142 |         struct axiom_devinfo *device_info;
         |                               ^~~~~~~~~~~


vim +/device_info +142 drivers/input/touchscreen/touchnetix_axiom.c

   136	
   137	/* Translate usage/page/offset triplet into physical address. */
   138	static u16 axiom_usage_to_target_address(struct axiom_data *ts, char usage, char page,
   139						 char offset)
   140	{
   141		struct axiom_usage_entry *usage_table;
 > 142		struct axiom_devinfo *device_info;
   143		u32 i;
   144	
   145		device_info = &ts->devinfo;
   146		usage_table = ts->usage_table;
   147	
   148		/* At the moment the convention is that u31 is always at physical address 0x0 */
   149		if (!ts->usage_table_populated) {
   150			if (usage == AXIOM_DEVINFO_USAGE_ID)
   151				return ((page << 8) + offset);
   152			else
   153				return 0xffff;
   154		}
   155	
   156		for (i = 0; i < ts->devinfo.num_usages; i++) {
   157			if (usage_table[i].id != usage)
   158				continue;
   159	
   160			if (page >= usage_table[i].num_pages) {
   161				dev_err(ts->dev, "Invalid usage table! usage: %u, page: %u, offset: %u\n",
   162					usage, page, offset);
   163				return 0xffff;
   164			}
   165			break;
   166		}
   167	
   168		return ((usage_table[i].start_page + page) << 8) + offset;
   169	}
   170	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
