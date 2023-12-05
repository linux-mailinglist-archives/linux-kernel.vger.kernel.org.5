Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4470580611C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346268AbjLEV45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjLEV4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:56:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26815D3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 13:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701813419; x=1733349419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D9EtR6Py7ooGLOmKmiVsc4WAuKZzq54r1HkSKwjte8A=;
  b=KN7rhmlJzPiMB/aNlIe/bwdeoRjxeMp3M7JmyrQsPodWHagxRm+7bywR
   aQx+MP4GAcCDp785xX2VBDI5ANJw2SxsSyuGocv8O/qoHUdpljTfiLCs9
   EKmLKuieWwwx3g82pPTFP6QHzlIN6jkKtUY9hsj+mNZRd9CkqklBJ+lfj
   ULdSCSm+mRdwQSrdSDtM0g6Y1shDl2TRCD7qVTL2Okn1ECA7gkTvQL29z
   fY/aOyF39ehy29wwrWgxVI+1Mn8JuA9QueyN5BJOQRhvsR3k7WLLKGPsc
   +Iit7zUBF2ZnGgAcQPnBeAV3qnKyCrCmEPAFHCNn86oRDXLFzpntZGZBJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="392833559"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="392833559"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:56:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="747388076"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="747388076"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Dec 2023 13:56:54 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAdPQ-0009ma-0g;
        Tue, 05 Dec 2023 21:56:52 +0000
Date:   Wed, 6 Dec 2023 05:56:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
        srinivas.kandagatla@linaro.org, krzysztof.kozlowski@linaro.org,
        broonie@kernel.org, agross@kernel.org, andersson@kernel.org,
        quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        quic_phaniu@quicinc.com, quic_avangala@quicinc.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: Re: [PATCH v1] ASoC: codecs: wcd937x: Add wcd937x codec driver
Message-ID: <202312060522.gxYr8k2D-lkp@intel.com>
References: <20231205123400.6353-1-quic_pkumpatl@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205123400.6353-1-quic_pkumpatl@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
config: i386-buildonly-randconfig-005-20231206 (https://download.01.org/0day-ci/archive/20231206/202312060522.gxYr8k2D-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312060522.gxYr8k2D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312060522.gxYr8k2D-lkp@intel.com/

All warnings (new ones prefixed by >>):

   sound/soc/codecs/wcd937x.c:1024:6: warning: variable 'pre_off_event' set but not used [-Wunused-but-set-variable]
           int pre_off_event = 0, post_off_event = 0;
               ^
   sound/soc/codecs/wcd937x.c:1024:25: warning: variable 'post_off_event' set but not used [-Wunused-but-set-variable]
           int pre_off_event = 0, post_off_event = 0;
                                  ^
   sound/soc/codecs/wcd937x.c:1025:6: warning: variable 'post_on_event' set but not used [-Wunused-but-set-variable]
           int post_on_event = 0, post_dapm_off = 0;
               ^
   sound/soc/codecs/wcd937x.c:1025:25: warning: variable 'post_dapm_off' set but not used [-Wunused-but-set-variable]
           int post_on_event = 0, post_dapm_off = 0;
                                  ^
   sound/soc/codecs/wcd937x.c:1027:6: warning: variable 'post_dapm_on' set but not used [-Wunused-but-set-variable]
           int post_dapm_on = 0;
               ^
>> sound/soc/codecs/wcd937x.c:2909:34: warning: unused variable 'wcd937x_of_match' [-Wunused-const-variable]
   static const struct of_device_id wcd937x_of_match[] = {
                                    ^
   6 warnings generated.


vim +/wcd937x_of_match +2909 sound/soc/codecs/wcd937x.c

  2908	
> 2909	static const struct of_device_id wcd937x_of_match[] = {
  2910		{ .compatible = "qcom,wcd9370-codec" },
  2911		{ }
  2912	};
  2913	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
