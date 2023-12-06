Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4758063A6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 01:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376358AbjLFAvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 19:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376351AbjLFAvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 19:51:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFC2C6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 16:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701823865; x=1733359865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lxsl+6fT6wBQtU2JGMUWcGLlxUsdJ/uMypPUri2+hVs=;
  b=Z4xqCPsmAAQklcUbNV/xWoobwDv0imlS6bHbExAXdjlVLpONPDVwVwBd
   IZXvffKFpLY2LMmImW3YdS6miMZurvFMMqwmu8bHVkKdee9Lg3Lta5CYQ
   7nZWx4Ef3faYg50Tr04+L2ondJErFWK5K2Qc7VOmvRpQEeC1pVn8Q4vju
   qOXYrfPH2QH0cz3/g/4k/xRottOPjL3rB32eoR9u2vd8pQsM3SMZE+U1M
   i7UMBIiEnnWKwUbmVjH9jr3Mt3P/PUd647bTeSRC6lP7nzribrF4dr5QC
   fErg4N1/xXGiRyuxwzrOCjAg+NCbNDdxZ3nO4nDy0h47guEs616jMNY9D
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="12698975"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="12698975"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 16:51:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="841652266"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="841652266"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 05 Dec 2023 16:51:01 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAg7v-0009yt-18;
        Wed, 06 Dec 2023 00:50:59 +0000
Date:   Wed, 6 Dec 2023 08:50:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
        srinivas.kandagatla@linaro.org, krzysztof.kozlowski@linaro.org,
        broonie@kernel.org, agross@kernel.org, andersson@kernel.org,
        quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        quic_phaniu@quicinc.com, quic_avangala@quicinc.com
Cc:     oe-kbuild-all@lists.linux.dev,
        Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: Re: [PATCH v1] ASoC: codecs: wcd937x: Add wcd937x codec driver
Message-ID: <202312060830.GFAdSK3t-lkp@intel.com>
References: <20231205123400.6353-1-quic_pkumpatl@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205123400.6353-1-quic_pkumpatl@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prasad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on linus/master v6.7-rc4 next-20231205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Prasad-Kumpatla/ASoC-codecs-wcd937x-Add-wcd937x-codec-driver/20231205-203631
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20231205123400.6353-1-quic_pkumpatl%40quicinc.com
patch subject: [PATCH v1] ASoC: codecs: wcd937x: Add wcd937x codec driver
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20231206/202312060830.GFAdSK3t-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312060830.GFAdSK3t-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312060830.GFAdSK3t-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/codecs/wcd937x-sdw.c:1117:12: warning: 'wcd937x_sdw_runtime_resume' defined but not used [-Wunused-function]
    1117 | static int wcd937x_sdw_runtime_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> sound/soc/codecs/wcd937x-sdw.c:1105:12: warning: 'wcd937x_sdw_runtime_suspend' defined but not used [-Wunused-function]
    1105 | static int wcd937x_sdw_runtime_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/wcd937x_sdw_runtime_resume +1117 sound/soc/codecs/wcd937x-sdw.c

  1104	
> 1105	static int wcd937x_sdw_runtime_suspend(struct device *dev)
  1106	{
  1107		struct wcd937x_sdw_priv *wcd = dev_get_drvdata(dev);
  1108	
  1109		if (wcd->regmap) {
  1110			regcache_cache_only(wcd->regmap, true);
  1111			regcache_mark_dirty(wcd->regmap);
  1112		}
  1113	
  1114		return 0;
  1115	}
  1116	
> 1117	static int wcd937x_sdw_runtime_resume(struct device *dev)
  1118	{
  1119		struct wcd937x_sdw_priv *wcd = dev_get_drvdata(dev);
  1120	
  1121		if (wcd->regmap) {
  1122			regcache_cache_only(wcd->regmap, false);
  1123			regcache_sync(wcd->regmap);
  1124		}
  1125	
  1126		pm_runtime_mark_last_busy(dev);
  1127	
  1128		return 0;
  1129	}
  1130	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
