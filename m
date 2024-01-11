Return-Path: <linux-kernel+bounces-24082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FC182B68B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270601F215D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721B558132;
	Thu, 11 Jan 2024 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="crIQjWq3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329EA58125
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705008059; x=1736544059;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8h5DFjlxATjdb8q4sJ0FkG/DSlJ4OkJJ5yUhgXAKbmI=;
  b=crIQjWq3K1QJTaSS3A/g5Oa0b0kL/qDQ2Ejk2ya8KEImoh0H1B3K5TrA
   dYNdB9baVczy69oxOKS9lklSH7a3ysVNgyDWZsvV47p59cSTPF56Dof9a
   1uhJPQzjAOp7iA2oYmiUHiZpday+TXf8L+zfYLZvg1vms7LTHEw3lTooa
   eqjPidy2yzZOwKWgXCn+7vUeUtyTJj+V1Cm7wQkUYdXo+bWxIsKJNJ8gh
   Am7wDk47q9CdTAT2PF83ujzZlrDpYG2f4WlSgrLH4O++WQ4yDZmbPFNYg
   E2qeRn+aYkaUmpske4e0foBJFxNyxdf8DRby5EOCrXI7XDg4v9r5Fda4f
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="6354590"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="6354590"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 13:20:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="873156989"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="873156989"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jan 2024 13:20:57 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rO2Tv-0008kk-1U;
	Thu, 11 Jan 2024 21:20:55 +0000
Date: Fri, 12 Jan 2024 05:20:35 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/base/regmap/regmap-kunit.c:795:43: sparse: sparse: cast to
 restricted __le16
Message-ID: <202401120557.tDMmzgkZ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   de927f6c0b07d9e698416c5b287c521b07694cac
commit: 155a6bd6375b584c8bdbf963b8ddef672ff9aca3 regmap: Provide basic KUnit coverage for the raw register I/O
date:   7 months ago
config: x86_64-randconfig-123-20240106 (https://download.01.org/0day-ci/archive/20240112/202401120557.tDMmzgkZ-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240112/202401120557.tDMmzgkZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401120557.tDMmzgkZ-lkp@intel.com/

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

