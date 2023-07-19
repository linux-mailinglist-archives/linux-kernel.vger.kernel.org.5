Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927A9758E1F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjGSGvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjGSGvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:51:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043851FCD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689749465; x=1721285465;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xrAa/EfRGIe1Mjva05iGB8sMeeB2R7tIWEue9UWVP2w=;
  b=Yb7N3hz+bfI6o85dusi0VuiS1hn0KHuybOHrNnunq3Pu+VHQqzdmj1er
   GIDGjXuX17PkeLhZHAqSN03DKeXqEOZI9hDqT4DR2EF9D3h+m48md00sD
   7f9xVFgAljF/WeueKMGi4CNaAkNKIDO7BrRr4f3Y5E5UvqFcOh3JDQQw0
   TlpZXgoh2NtaZauL/bysw7G8T8IMIWwnyDhSb1m4v4bxdafem8IebYif4
   5AhGv/+6O81hycMWJK2cChIuWHiFn7R5juaq1fVmx9AuTT8OzrzwsS+mO
   GJAVR5XiRXz6rEwMPRzBlYpqPYK24xLYKobT8S815ZDk0IM6CHdMUHnTO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="365265527"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="365265527"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 23:51:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="789302607"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="789302607"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jul 2023 23:51:03 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qM11a-0004E7-1H;
        Wed, 19 Jul 2023 06:51:02 +0000
Date:   Wed, 19 Jul 2023 14:50:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: drivers/powercap/intel_rapl_tpmi.c:141:41: sparse: sparse: incorrect
 type in initializer (different address spaces)
Message-ID: <202307191405.B2ozLURw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ccff6d117d8dc8d8d86e8695a75e5f8b01e573bf
commit: 9eef7f9da928c54149199e7b3215b82c2d595ccd powercap: intel_rapl: Introduce RAPL TPMI interface driver
date:   8 weeks ago
config: x86_64-randconfig-x061-20230719 (https://download.01.org/0day-ci/archive/20230719/202307191405.B2ozLURw-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230719/202307191405.B2ozLURw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307191405.B2ozLURw-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/powercap/intel_rapl_tpmi.c:141:41: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [usertype] *tpmi_rapl_regs @@     got void [noderef] __iomem * @@
   drivers/powercap/intel_rapl_tpmi.c:141:41: sparse:     expected unsigned long long [usertype] *tpmi_rapl_regs
   drivers/powercap/intel_rapl_tpmi.c:141:41: sparse:     got void [noderef] __iomem *

vim +141 drivers/powercap/intel_rapl_tpmi.c

   132	
   133	static int parse_one_domain(struct tpmi_rapl_package *trp, u32 offset)
   134	{
   135		u8 tpmi_domain_version;
   136		enum rapl_domain_type domain_type;
   137		enum tpmi_rapl_domain_type tpmi_domain_type;
   138		enum tpmi_rapl_register reg_index;
   139		enum rapl_domain_reg_id reg_id;
   140		int tpmi_domain_size, tpmi_domain_flags;
 > 141		u64 *tpmi_rapl_regs = trp->base + offset;
   142		u64 tpmi_domain_header = readq((void __iomem *)tpmi_rapl_regs);
   143	
   144		/* Domain Parent bits are ignored for now */
   145		tpmi_domain_version = tpmi_domain_header & 0xff;
   146		tpmi_domain_type = tpmi_domain_header >> 8 & 0xff;
   147		tpmi_domain_size = tpmi_domain_header >> 16 & 0xff;
   148		tpmi_domain_flags = tpmi_domain_header >> 32 & 0xffff;
   149	
   150		if (tpmi_domain_version != TPMI_RAPL_VERSION) {
   151			pr_warn(FW_BUG "Unsupported version:%d\n", tpmi_domain_version);
   152			return -ENODEV;
   153		}
   154	
   155		/* Domain size: in unit of 128 Bytes */
   156		if (tpmi_domain_size != 1) {
   157			pr_warn(FW_BUG "Invalid Domain size %d\n", tpmi_domain_size);
   158			return -EINVAL;
   159		}
   160	
   161		/* Unit register and Energy Status register are mandatory for each domain */
   162		if (!(tpmi_domain_flags & BIT(TPMI_RAPL_REG_UNIT)) ||
   163		    !(tpmi_domain_flags & BIT(TPMI_RAPL_REG_ENERGY_STATUS))) {
   164			pr_warn(FW_BUG "Invalid Domain flag 0x%x\n", tpmi_domain_flags);
   165			return -EINVAL;
   166		}
   167	
   168		switch (tpmi_domain_type) {
   169		case TPMI_RAPL_DOMAIN_PACKAGE:
   170			domain_type = RAPL_DOMAIN_PACKAGE;
   171			break;
   172		case TPMI_RAPL_DOMAIN_SYSTEM:
   173			domain_type = RAPL_DOMAIN_PLATFORM;
   174			break;
   175		case TPMI_RAPL_DOMAIN_MEMORY:
   176			domain_type = RAPL_DOMAIN_DRAM;
   177			break;
   178		default:
   179			pr_warn(FW_BUG "Unsupported Domain type %d\n", tpmi_domain_type);
   180			return -EINVAL;
   181		}
   182	
   183		if (trp->priv.regs[domain_type][RAPL_DOMAIN_REG_UNIT]) {
   184			pr_warn(FW_BUG "Duplicate Domain type %d\n", tpmi_domain_type);
   185			return -EINVAL;
   186		}
   187	
   188		reg_index = TPMI_RAPL_REG_HEADER;
   189		while (++reg_index != TPMI_RAPL_REG_MAX) {
   190			if (!(tpmi_domain_flags & BIT(reg_index)))
   191				continue;
   192	
   193			switch (reg_index) {
   194			case TPMI_RAPL_REG_UNIT:
   195				reg_id = RAPL_DOMAIN_REG_UNIT;
   196				break;
   197			case TPMI_RAPL_REG_PL1:
   198				reg_id = RAPL_DOMAIN_REG_LIMIT;
   199				trp->priv.limits[domain_type] |= BIT(POWER_LIMIT1);
   200				break;
   201			case TPMI_RAPL_REG_PL2:
   202				reg_id = RAPL_DOMAIN_REG_PL2;
   203				trp->priv.limits[domain_type] |= BIT(POWER_LIMIT2);
   204				break;
   205			case TPMI_RAPL_REG_PL4:
   206				reg_id = RAPL_DOMAIN_REG_PL4;
   207				trp->priv.limits[domain_type] |= BIT(POWER_LIMIT4);
   208				break;
   209			case TPMI_RAPL_REG_ENERGY_STATUS:
   210				reg_id = RAPL_DOMAIN_REG_STATUS;
   211				break;
   212			case TPMI_RAPL_REG_PERF_STATUS:
   213				reg_id = RAPL_DOMAIN_REG_PERF;
   214				break;
   215			case TPMI_RAPL_REG_POWER_INFO:
   216				reg_id = RAPL_DOMAIN_REG_INFO;
   217				break;
   218			default:
   219				continue;
   220			}
   221			trp->priv.regs[domain_type][reg_id] = (u64)&tpmi_rapl_regs[reg_index];
   222		}
   223	
   224		return 0;
   225	}
   226	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
