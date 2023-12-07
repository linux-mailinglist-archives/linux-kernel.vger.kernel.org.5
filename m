Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E1D808D29
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjLGQBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjLGQBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:01:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D1210E4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701964904; x=1733500904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=phWQlYp9T78VNLL1jO/M1PShHVS5tnBO9tbtLaPHCwo=;
  b=h/ZqP0YQMT5xvYqS3Kbk6sCHrAsUg8t4xmwzJ8Y3/3SJpuHCbXyNf4ME
   yiyUx2dB0LpBT19BLRc3dwpc6qbit9KpSatp1IASFRf1Cu/edkABqUVEY
   TpaybqxJYVFnVWqpA7KvevU3YtnEoEv5iquTeJLqRbK5osYRUlE1IvxpJ
   wMOtL85lo8PWFSL1VQfVvGwjilJJ5U0EsI3RTm09Y0P+Fbfw8acfKJrl9
   UZRrS2i9bypDn0Dj7agypWfCckrGDOyGYSePOUJSMHY9H2PN0ulhVMX82
   g3snQHUaSABlpQ+C3Ni278pbe8pf8TGQ2Y0iSl7m0E8oCVcvfZozeoff0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1358009"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1358009"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 08:01:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="748006917"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="748006917"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 07 Dec 2023 08:01:32 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBGoc-000CSM-22;
        Thu, 07 Dec 2023 16:01:30 +0000
Date:   Fri, 8 Dec 2023 00:00:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gergo Koteles <soyer@irl.hu>, Shenghao Ding <shenghao-ding@ti.com>,
        Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Gergo Koteles <soyer@irl.hu>
Subject: Re: [PATCH 13/16] ALSA: hda/tas2781: remove sound controls in unbind
Message-ID: <202312072318.9KUgvYeb-lkp@intel.com>
References: <8f16576930682297fd08bba5e063a9a1f3150388.1701906455.git.soyer@irl.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f16576930682297fd08bba5e063a9a1f3150388.1701906455.git.soyer@irl.hu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gergo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on tiwai-sound/for-linus broonie-sound/for-next linus/master v6.7-rc4 next-20231207]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gergo-Koteles/ALSA-hda-tas2781-leave-hda_component-in-usable-state/20231207-085947
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/8f16576930682297fd08bba5e063a9a1f3150388.1701906455.git.soyer%40irl.hu
patch subject: [PATCH 13/16] ALSA: hda/tas2781: remove sound controls in unbind
config: x86_64-randconfig-001-20231207 (https://download.01.org/0day-ci/archive/20231207/202312072318.9KUgvYeb-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231207/202312072318.9KUgvYeb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312072318.9KUgvYeb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/pci/hda/tas2781_hda_i2c.c:868:1: warning: unused label 'out' [-Wunused-label]
   out:
   ^~~~
   1 warning generated.


vim +/out +868 sound/pci/hda/tas2781_hda_i2c.c

   852	
   853	static int tas2781_runtime_resume(struct device *dev)
   854	{
   855		struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
   856	
   857		dev_dbg(tas_hda->dev, "Runtime Resume\n");
   858	
   859		mutex_lock(&tas_hda->priv->codec_lock);
   860	
   861		tasdevice_prmg_load(tas_hda->priv, tas_hda->priv->cur_prog);
   862	
   863		/* If calibrated data occurs error, dsp will still works with default
   864		 * calibrated data inside algo.
   865		 */
   866		tasdevice_apply_calibration(tas_hda->priv);
   867	
 > 868	out:
   869		mutex_unlock(&tas_hda->priv->codec_lock);
   870	
   871		return 0;
   872	}
   873	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
