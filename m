Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD157D192F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjJTWbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjJTWbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:31:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3E7D6E;
        Fri, 20 Oct 2023 15:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697841097; x=1729377097;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ktERwyBLEExIXBgzNyFt6G5y7R4k1hF6zHPNDQ9AZUk=;
  b=bepYZ+Imf3XuESnYZhB6IrI4JuKukMh5pyZAfQn0685vnrglvQ5exsd5
   qNOjRm/WVrstzSS6+2vWACJWOD+4Gc6zoNfaYaNuYODId7KRxWzwNktEE
   +Pc2RMUDoB5Jus7NjtOVn+XKzCWjEejlewObaRXPP1r1IUwJqSZIGt8dR
   CtsDvjNJ54tXY9E1UWbOi1U6YHhscNnyXsnuOmNyaAJucSqSXADnXa6ZP
   Axs+5RkwZFbRmr+wVyRee67lLDeUfN5mnlvwJt0LwR0EvOekhgjX3QrMO
   1oNq+1CRc1Q49rIFfqDnX6DKj+XvtWFBFM6uBFxOgZqGmv/h1mJxAbkm6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="450813629"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="450813629"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 15:31:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="827864456"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="827864456"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Oct 2023 15:31:32 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qty1i-000438-1S;
        Fri, 20 Oct 2023 22:31:30 +0000
Date:   Sat, 21 Oct 2023 06:30:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chancel Liu <chancel.liu@nxp.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     oe-kbuild-all@lists.linux.dev, Chancel Liu <chancel.liu@nxp.com>
Subject: Re: [PATCH v2 1/3] arm64: dts: imx93: Add audio device nodes
Message-ID: <202310210636.dtEPMrF8-lkp@intel.com>
References: <20231010133838.799714-2-chancel.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010133838.799714-2-chancel.liu@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chancel,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on broonie-sound/for-next linus/master v6.6-rc6 next-20231020]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chancel-Liu/arm64-dts-imx93-Add-audio-device-nodes/20231010-214443
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231010133838.799714-2-chancel.liu%40nxp.com
patch subject: [PATCH v2 1/3] arm64: dts: imx93: Add audio device nodes
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231021/202310210636.dtEPMrF8-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231021/202310210636.dtEPMrF8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310210636.dtEPMrF8-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ERROR: Input tree has errors, aborting (use -f to force output)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
