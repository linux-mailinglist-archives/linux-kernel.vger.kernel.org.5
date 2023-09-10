Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D0D799FFD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 22:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjIJUze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 16:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjIJUz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 16:55:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A7318B
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 13:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694379324; x=1725915324;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GhlWNRqhbecokBqazbv3oP1ixcMd/ur7J2xjsKjpf3s=;
  b=IrKkZX5QUrTOevR7slH0prP8aTGYmTULFFc56mBOxMXi68e9e/ay8STc
   EwpCPdqrwDXuGw6gUNjZzFx4lkVpkGTXcUJVekMYqTK18scrTrykE7yQI
   l00o7Sx5XtmBB2GcaTHSUra679J5bAeYJovnmd9dqKp6IHfRsVAQffPzF
   ySy1lYl+JLk+ebLHwGRzaFGadNqM3TuEOvMsRE4h9n9Il4nktlbQbkZDJ
   +Xv7Q2nSqCGKEP4j/VLkbzb/CIu6eGKncfstZ/uCH1WpJd0GrSB7Ykw5M
   HZSsYz/Gb0N4Hv7KZfTqLEnwD5e0gJwBp4K4X2ws02gysIjQpKkAYPoGU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="362968515"
X-IronPort-AV: E=Sophos;i="6.02,242,1688454000"; 
   d="scan'208";a="362968515"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 13:55:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="916794380"
X-IronPort-AV: E=Sophos;i="6.02,242,1688454000"; 
   d="scan'208";a="916794380"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Sep 2023 13:55:22 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfRSi-0005Os-2H;
        Sun, 10 Sep 2023 20:55:20 +0000
Date:   Mon, 11 Sep 2023 04:54:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/base/regmap/regmap-kunit.c:795:43: sparse: sparse: cast to
 restricted __le16
Message-ID: <202309110407.qVp0e60U-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e56b2b6057996c5f48da518c79d6590f8bfaabf3
commit: 155a6bd6375b584c8bdbf963b8ddef672ff9aca3 regmap: Provide basic KUnit coverage for the raw register I/O
date:   3 months ago
config: i386-randconfig-063-20230910 (https://download.01.org/0day-ci/archive/20230911/202309110407.qVp0e60U-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230911/202309110407.qVp0e60U-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309110407.qVp0e60U-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/base/regmap/regmap-kunit.c:795:43: sparse: sparse: cast to restricted __le16
>> drivers/base/regmap/regmap-kunit.c:798:43: sparse: sparse: cast to restricted __be16
   drivers/base/regmap/regmap-kunit.c:875:25: sparse: sparse: cast to restricted __be16
   drivers/base/regmap/regmap-kunit.c:875:25: sparse: sparse: cast to restricted __be16
   drivers/base/regmap/regmap-kunit.c:877:25: sparse: sparse: cast to restricted __le16
   drivers/base/regmap/regmap-kunit.c:877:25: sparse: sparse: cast to restricted __le16
   drivers/base/regmap/regmap-kunit.c:944:33: sparse: sparse: cast to restricted __be16
   drivers/base/regmap/regmap-kunit.c:944:33: sparse: sparse: cast to restricted __be16
   drivers/base/regmap/regmap-kunit.c:947:33: sparse: sparse: cast to restricted __le16
   drivers/base/regmap/regmap-kunit.c:947:33: sparse: sparse: cast to restricted __le16
   drivers/base/regmap/regmap-kunit.c:989:17: sparse: sparse: cast to restricted __be16
   drivers/base/regmap/regmap-kunit.c:989:17: sparse: sparse: cast to restricted __be16
   drivers/base/regmap/regmap-kunit.c:992:17: sparse: sparse: cast to restricted __le16
   drivers/base/regmap/regmap-kunit.c:992:17: sparse: sparse: cast to restricted __le16
   drivers/base/regmap/regmap-kunit.c:1004:33: sparse: sparse: cast to restricted __be16
   drivers/base/regmap/regmap-kunit.c:1004:33: sparse: sparse: cast to restricted __be16
   drivers/base/regmap/regmap-kunit.c:1007:33: sparse: sparse: cast to restricted __le16
   drivers/base/regmap/regmap-kunit.c:1007:33: sparse: sparse: cast to restricted __le16

vim +795 drivers/base/regmap/regmap-kunit.c

   758	
   759	static struct regmap *gen_raw_regmap(struct regmap_config *config,
   760					     struct raw_test_types *test_type,
   761					     struct regmap_ram_data **data)
   762	{
   763		u16 *buf;
   764		struct regmap *ret;
   765		size_t size = (config->max_register + 1) * config->reg_bits / 8;
   766		int i;
   767		struct reg_default *defaults;
   768	
   769		config->cache_type = test_type->cache_type;
   770		config->val_format_endian = test_type->val_endian;
   771	
   772		buf = kmalloc(size, GFP_KERNEL);
   773		if (!buf)
   774			return ERR_PTR(-ENOMEM);
   775	
   776		get_random_bytes(buf, size);
   777	
   778		*data = kzalloc(sizeof(**data), GFP_KERNEL);
   779		if (!(*data))
   780			return ERR_PTR(-ENOMEM);
   781		(*data)->vals = (void *)buf;
   782	
   783		config->num_reg_defaults = config->max_register + 1;
   784		defaults = kcalloc(config->num_reg_defaults,
   785				   sizeof(struct reg_default),
   786				   GFP_KERNEL);
   787		if (!defaults)
   788			return ERR_PTR(-ENOMEM);
   789		config->reg_defaults = defaults;
   790	
   791		for (i = 0; i < config->num_reg_defaults; i++) {
   792			defaults[i].reg = i;
   793			switch (test_type->val_endian) {
   794			case REGMAP_ENDIAN_LITTLE:
 > 795				defaults[i].def = le16_to_cpu(buf[i]);
   796				break;
   797			case REGMAP_ENDIAN_BIG:
 > 798				defaults[i].def = be16_to_cpu(buf[i]);
   799				break;
   800			default:
   801				return ERR_PTR(-EINVAL);
   802			}
   803		}
   804	
   805		/*
   806		 * We use the defaults in the tests but they don't make sense
   807		 * to the core if there's no cache.
   808		 */
   809		if (config->cache_type == REGCACHE_NONE)
   810			config->num_reg_defaults = 0;
   811	
   812		ret = regmap_init_raw_ram(config, *data);
   813		if (IS_ERR(ret)) {
   814			kfree(buf);
   815			kfree(*data);
   816		}
   817	
   818		return ret;
   819	}
   820	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
