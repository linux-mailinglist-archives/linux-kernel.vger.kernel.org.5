Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861067DC239
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 23:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjJ3WCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 18:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjJ3WCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 18:02:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D755A9E
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 15:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698703333; x=1730239333;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jfzh0ip6bSohVXGujADTB1xLhPFtMHVGpGbmPmLH2XI=;
  b=Jt8X2daGsKz/zjRUUfMjXaBHxVSYzbtdYvP4IsfSorbZLGW+/2ggc2mh
   pWVDTMZVF4Hn+U1nwx6CDHwB/zIsIZ7h02+LelzE4meaOU+Fpwy0ui7Rx
   /cGUQNk5TOaMl07x1KoNJxhrarRreEX734tOoNDboIsqp1B9Sta/NrVLy
   cID2ju+RTEvwjNp/YpFiEvQuYGpq94gDqb7ouc1hSCQdroMKkLI8S62/C
   liyx1aA+X1dFd/LurL1mYH+uPzuhjT2z/SMTEDaTqoOjp6jkV+JQAEo4m
   kzP7wB30KUyLBn3AdDcZZMJTJca5M2dlNbLlpumFfy3ikrfOQUO4zhm18
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="474412993"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="474412993"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 15:02:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="764050683"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="764050683"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 30 Oct 2023 15:02:12 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qxaKn-000DaR-03;
        Mon, 30 Oct 2023 22:02:09 +0000
Date:   Tue, 31 Oct 2023 06:01:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: sound/soc/generic/simple-card-utils.c:28:33: sparse: sparse:
 incorrect type in initializer (different base types)
Message-ID: <202310310501.Yb4dFWIo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   14ab6d425e80674b6a0145f05719b11e82e64824
commit: 047a05366f4bb2e32eabbd3c8990d1d91ab87c89 ASoC: simple-card-utils: Fixup DAI sample format
date:   1 year, 3 months ago
config: x86_64-randconfig-x014-20230805 (https://download.01.org/0day-ci/archive/20231031/202310310501.Yb4dFWIo-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231031/202310310501.Yb4dFWIo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310310501.Yb4dFWIo-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> sound/soc/generic/simple-card-utils.c:28:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted snd_pcm_format_t [usertype] @@
   sound/soc/generic/simple-card-utils.c:28:33: sparse:     expected unsigned int [usertype] val
   sound/soc/generic/simple-card-utils.c:28:33: sparse:     got restricted snd_pcm_format_t [usertype]
   sound/soc/generic/simple-card-utils.c:29:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted snd_pcm_format_t [usertype] @@
   sound/soc/generic/simple-card-utils.c:29:33: sparse:     expected unsigned int [usertype] val
   sound/soc/generic/simple-card-utils.c:29:33: sparse:     got restricted snd_pcm_format_t [usertype]
   sound/soc/generic/simple-card-utils.c:30:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted snd_pcm_format_t [usertype] @@
   sound/soc/generic/simple-card-utils.c:30:33: sparse:     expected unsigned int [usertype] val
   sound/soc/generic/simple-card-utils.c:30:33: sparse:     got restricted snd_pcm_format_t [usertype]
   sound/soc/generic/simple-card-utils.c:31:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted snd_pcm_format_t [usertype] @@
   sound/soc/generic/simple-card-utils.c:31:33: sparse:     expected unsigned int [usertype] val
   sound/soc/generic/simple-card-utils.c:31:33: sparse:     got restricted snd_pcm_format_t [usertype]
   sound/soc/generic/simple-card-utils.c:32:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] val @@     got restricted snd_pcm_format_t [usertype] @@
   sound/soc/generic/simple-card-utils.c:32:33: sparse:     expected unsigned int [usertype] val
   sound/soc/generic/simple-card-utils.c:32:33: sparse:     got restricted snd_pcm_format_t [usertype]

vim +28 sound/soc/generic/simple-card-utils.c

    17	
    18	static void asoc_simple_fixup_sample_fmt(struct asoc_simple_data *data,
    19						 struct snd_pcm_hw_params *params)
    20	{
    21		int i;
    22		struct snd_mask *mask = hw_param_mask(params,
    23						      SNDRV_PCM_HW_PARAM_FORMAT);
    24		struct {
    25			char *fmt;
    26			u32 val;
    27		} of_sample_fmt_table[] = {
  > 28			{ "s8",		SNDRV_PCM_FORMAT_S8},
    29			{ "s16_le",	SNDRV_PCM_FORMAT_S16_LE},
    30			{ "s24_le",	SNDRV_PCM_FORMAT_S24_LE},
    31			{ "s24_3le",	SNDRV_PCM_FORMAT_S24_3LE},
    32			{ "s32_le",	SNDRV_PCM_FORMAT_S32_LE},
    33		};
    34	
    35		for (i = 0; i < ARRAY_SIZE(of_sample_fmt_table); i++) {
    36			if (!strcmp(data->convert_sample_format,
    37				    of_sample_fmt_table[i].fmt)) {
    38				snd_mask_none(mask);
    39				snd_mask_set(mask, of_sample_fmt_table[i].val);
    40				break;
    41			}
    42		}
    43	}
    44	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
