Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFA2760C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjGYHrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjGYHro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:47:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF5197
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690271263; x=1721807263;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eZZ+qyeBaohDzVVZtquWmk/rLHEfvYZiXNOgb2mMsdw=;
  b=IZvMgfkEaoan4uvuJqvIGiTmuMRI3yPM6Iv+IMFyRsVKMxbl/CtKJulV
   9WSdkoIzJt5Knkug5RpG0sboCbsCnXMNLHVkw8VzHaAKyhRVD+Ut+ogLy
   GT+KhDcj0MiMolWvL6umx5ZgoOwTVx/VMbYsdvGPOL1XkR4dFPztfvFjD
   Klf9rhytIWZQeOwILbvJZzU4+9MA810+raieXlRdnhL7Mt5a6Nss7AKGf
   oJ6GgAX0IUNrIFrrZgyu2Kti54BHX+v02wGh71F2anqIrnJmYxXobXVp/
   cXuwpXfzh8i4oD3c1f1gacJB5stYzdTa0lNeBHOzNcVCaQQqFxDsut5RI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="347254844"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="347254844"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 00:47:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="796053861"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="796053861"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jul 2023 00:47:41 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOClg-000AR2-1H;
        Tue, 25 Jul 2023 07:47:40 +0000
Date:   Tue, 25 Jul 2023 15:46:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/base/regmap/regcache-maple.c:114:23: warning: 'upper_index'
 is used uninitialized
Message-ID: <202307251518.4JYwdU5r-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0b5547c51827e053cc754db47d3ec3e6c2c451d2
commit: f033c26de5a5734625d2dd1dc196745fae186f1b regmap: Add maple tree based register cache
date:   4 months ago
config: arc-randconfig-r001-20230725 (https://download.01.org/0day-ci/archive/20230725/202307251518.4JYwdU5r-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230725/202307251518.4JYwdU5r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307251518.4JYwdU5r-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/base/regmap/regcache-maple.c: In function 'regcache_maple_drop':
>> drivers/base/regmap/regcache-maple.c:114:23: warning: 'upper_index' is used uninitialized [-Wuninitialized]
     114 |         unsigned long upper_index, upper_last;
         |                       ^~~~~~~~~~~
>> drivers/base/regmap/regcache-maple.c:114:36: warning: 'upper_last' is used uninitialized [-Wuninitialized]
     114 |         unsigned long upper_index, upper_last;
         |                                    ^~~~~~~~~~
   drivers/base/regmap/regcache-maple.c:113:23: warning: 'lower_index' is used uninitialized [-Wuninitialized]
     113 |         unsigned long lower_index, lower_last;
         |                       ^~~~~~~~~~~
   drivers/base/regmap/regcache-maple.c:113:36: warning: 'lower_last' is used uninitialized [-Wuninitialized]
     113 |         unsigned long lower_index, lower_last;
         |                                    ^~~~~~~~~~


vim +/upper_index +114 drivers/base/regmap/regcache-maple.c

   106	
   107	static int regcache_maple_drop(struct regmap *map, unsigned int min,
   108				       unsigned int max)
   109	{
   110		struct maple_tree *mt = map->cache;
   111		MA_STATE(mas, mt, min, max);
   112		unsigned long *entry, *lower, *upper;
   113		unsigned long lower_index, lower_last;
 > 114		unsigned long upper_index, upper_last;
   115		int ret;
   116	
   117		lower = NULL;
   118		upper = NULL;
   119	
   120		mas_lock(&mas);
   121	
   122		mas_for_each(&mas, entry, max) {
   123			/*
   124			 * This is safe because the regmap lock means the
   125			 * Maple lock is redundant, but we need to take it due
   126			 * to lockdep asserts in the maple tree code.
   127			 */
   128			mas_unlock(&mas);
   129	
   130			/* Do we need to save any of this entry? */
   131			if (mas.index < min) {
   132				lower_index = mas.index;
   133				lower_last = min -1;
   134	
   135				lower = kmemdup(entry, ((min - mas.index) *
   136							sizeof(unsigned long)),
   137						GFP_KERNEL);
   138				if (!lower) {
   139					ret = -ENOMEM;
   140					goto out;
   141				}
   142			}
   143	
   144			if (mas.last > max) {
   145				upper_index = max + 1;
   146				upper_last = mas.last;
   147	
   148				upper = kmemdup(&entry[max + 1],
   149						((mas.last - max) *
   150						 sizeof(unsigned long)),
   151						GFP_KERNEL);
   152				if (!upper) {
   153					ret = -ENOMEM;
   154					goto out;
   155				}
   156			}
   157	
   158			kfree(entry);
   159			mas_lock(&mas);
   160			mas_erase(&mas);
   161	
   162			/* Insert new nodes with the saved data */
   163			if (lower) {
   164				mas_set_range(&mas, lower_index, lower_last);
   165				ret = mas_store_gfp(&mas, lower, GFP_KERNEL);
   166				if (ret != 0)
   167					goto out;
   168				lower = NULL;
   169			}
   170	
   171			if (upper) {
   172				mas_set_range(&mas, upper_index, upper_last);
   173				ret = mas_store_gfp(&mas, upper, GFP_KERNEL);
   174				if (ret != 0)
   175					goto out;
   176				upper = NULL;
   177			}
   178		}
   179	
   180	out:
   181		mas_unlock(&mas);
   182		kfree(lower);
   183		kfree(upper);
   184	
   185		return ret;
   186	}
   187	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
