Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7297A8087AF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379221AbjLGMWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjLGMWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:22:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F4610D2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701951761; x=1733487761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ujh58FHcb5tb2jGK1N8YKu30AfBLDN/psJSNOj5NXOI=;
  b=jS15MxxmX5AiqzTXTLRe00Dqwg4PHY7rlT7FBpFWjyKqKY/LxmkF5ihO
   Hzd8SX+wTtVS82ULNQct1p2o8Tv6oJn5nqu5bMuX26BG0qXwHlX8rygVE
   DUsfxN44DLE5YMgSK65Ip+Dbj9s/U/PpDGUZC8X+pXfvOfc/HqRxtPE2K
   e0HB3Jmapaic69S3HTTFKM3D4g98oYzIipT9PbS5knajnWKFoPfj08Qq4
   HbAlJyY9RBoJowtLvQMXSzTSDLCaffIT1I8GG5sMmBDSTkLdzJLgaG0rS
   hPFAMFsEGaxELXw6gSvY13VVkb+kfw4LYgPplf6flewLMmDHgupoShCOg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="7530806"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="7530806"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 04:22:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="945013859"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="945013859"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 07 Dec 2023 04:22:37 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBDOk-000CDr-2t;
        Thu, 07 Dec 2023 12:22:34 +0000
Date:   Thu, 7 Dec 2023 20:21:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gergo Koteles <soyer@irl.hu>, Shenghao Ding <shenghao-ding@ti.com>,
        Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Gergo Koteles <soyer@irl.hu>
Subject: Re: [PATCH 13/16] ALSA: hda/tas2781: remove sound controls in unbind
Message-ID: <202312072037.CYK5reOb-lkp@intel.com>
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
config: x86_64-randconfig-013-20231207 (https://download.01.org/0day-ci/archive/20231207/202312072037.CYK5reOb-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231207/202312072037.CYK5reOb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312072037.CYK5reOb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   sound/pci/hda/tas2781_hda_i2c.c: In function 'tas2781_runtime_resume':
>> sound/pci/hda/tas2781_hda_i2c.c:868:1: warning: label 'out' defined but not used [-Wunused-label]
     868 | out:
         | ^~~


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
