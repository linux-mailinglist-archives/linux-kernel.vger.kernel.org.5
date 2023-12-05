Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674DF805C8B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbjLERXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346071AbjLERXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:23:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A881AA;
        Tue,  5 Dec 2023 09:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701796991; x=1733332991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xSFoJNtBEh1slwXcU0gofzkPL1OMQMY6UhlC/9rL2Bs=;
  b=EWrIWCc3b1JWpNi3ME1DQZNDI43p6NESSCigO28cmlTNZhQR/gGbeJLp
   jkH+IYDcRIXuOvy2ddF8Ww0U00B4lolRjsW5QfJfGbK2Lqyaf32+mPRaZ
   EpdIIpSpdHKBBeNOVU4NYlFLYkMXrYfqw420ucqyaGQ+eLenI2aM62tOM
   U3OpkS2vLIFN9gZF8CbS3naKEJCfK2islJZlFymE2n4v26ZAuEGdziCMn
   I75i4rjs41Uqxj/FW5+QL0uMzTnSt0JcHQfpMzOWUSFfkXkqQOq3dXB5/
   XcJUX89H2D8DCy9UxHnEhdNykua/9wWH9y8N73lnuMHtrAdxgWA8V8Nsj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="12645337"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="12645337"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 09:23:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="720779258"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="720779258"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 05 Dec 2023 09:23:06 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAZ8S-0009RK-0h;
        Tue, 05 Dec 2023 17:23:04 +0000
Date:   Wed, 6 Dec 2023 01:22:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 5/5] ASoC: codecs: Add WCD939x Codec driver
Message-ID: <202312060107.dTzr6BK9-lkp@intel.com>
References: <20231201-topic-sm8650-upstream-wcd939x-codec-v2-5-94ed814b25aa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201-topic-sm8650-upstream-wcd939x-codec-v2-5-94ed814b25aa@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on linus/master v6.7-rc4 next-20231205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Neil-Armstrong/ASoC-dt-bindings-document-WCD939x-Audio-Codec/20231202-000916
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20231201-topic-sm8650-upstream-wcd939x-codec-v2-5-94ed814b25aa%40linaro.org
patch subject: [PATCH v2 5/5] ASoC: codecs: Add WCD939x Codec driver
config: arc-randconfig-r123-20231203 (https://download.01.org/0day-ci/archive/20231206/202312060107.dTzr6BK9-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231206/202312060107.dTzr6BK9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312060107.dTzr6BK9-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> sound/soc/codecs/wcd939x.c:1563:12: sparse: sparse: symbol 'tx_master_ch_text' was not declared. Should it be static?
>> sound/soc/codecs/wcd939x.c:1570:23: sparse: sparse: symbol 'tx_master_ch_enum' was not declared. Should it be static?

vim +/tx_master_ch_text +1563 sound/soc/codecs/wcd939x.c

  1562	
> 1563	const char * const tx_master_ch_text[] = {
  1564		"ZERO", "SWRM_PCM_OUT", "SWRM_TX1_CH1", "SWRM_TX1_CH2", "SWRM_TX1_CH3",
  1565		"SWRM_TX1_CH4", "SWRM_TX2_CH1", "SWRM_TX2_CH2", "SWRM_TX2_CH3",
  1566		"SWRM_TX2_CH4", "SWRM_TX3_CH1", "SWRM_TX3_CH2", "SWRM_TX3_CH3",
  1567		"SWRM_TX3_CH4", "SWRM_PCM_IN",
  1568	};
  1569	
> 1570	const struct soc_enum tx_master_ch_enum =
  1571		SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(tx_master_ch_text),
  1572				    tx_master_ch_text);
  1573	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
