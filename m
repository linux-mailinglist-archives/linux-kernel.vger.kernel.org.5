Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA2279D64D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjILQ3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjILQ3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:29:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FC6115
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694536182; x=1726072182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+ne2QoXtf7yPAarnt2iHbPmV1YKRfcKbyuDLCVGZRtY=;
  b=FBg9lpxoZlWhYMBPkATdBBi5Vn106WjDb0mIvRFim52G+s09udBLI3ez
   Uwb4PooEsGCHElPwjzfAKNJt5n9MrWZQVbkJMMyLa42BWnncAS5JpnZcm
   ypYA9rKpRy723DfMAHRqSKqXH4WqvsL9i2Kj6d4KFzEtmwIAIaCwCX1Nd
   pxzAf2PDhJU+ZEQepeMSBTutfp3ClmvPKMc6jMab79GOHbG8Mpnb3uMWE
   9cdGZOpES98kaicXzTwBgkpV1tJNyEK1LaSBu0ics8SQy3sCsmOEB4ozw
   oAYDU0vZ12rorFnh5nxghHyNi0NoFHDJ69Ow9U/3GQaEdVdz+gyOJPb70
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="464801235"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="464801235"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 09:20:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="746957326"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="746957326"
Received: from lkp-server02.sh.intel.com (HELO 0a6943a0b3e1) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 12 Sep 2023 09:20:42 -0700
Received: from kbuild by 0a6943a0b3e1 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qg67w-0000E6-0b;
        Tue, 12 Sep 2023 16:20:37 +0000
Date:   Wed, 13 Sep 2023 00:11:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shenghao Ding <shenghao-ding@ti.com>, tiwai@suse.de
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
        lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
        13916275206@139.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
        mengdong.lin@intel.com, baojun.xu@ti.com,
        thomas.gfeller@q-drop.com, peeyush@ti.com, navada@ti.com,
        broonie@kernel.org, gentuser@gmail.com,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Support ACPI_ID both TXNW2781 and
 TIAS2781
Message-ID: <202309122358.aEcJnIUJ-lkp@intel.com>
References: <20230910072704.1359-1-shenghao-ding@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230910072704.1359-1-shenghao-ding@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shenghao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on tiwai-sound/for-linus linus/master v6.6-rc1 next-20230912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shenghao-Ding/ALSA-hda-tas2781-Support-ACPI_ID-both-TXNW2781-and-TIAS2781/20230910-153010
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20230910072704.1359-1-shenghao-ding%40ti.com
patch subject: [PATCH v1] ALSA: hda/tas2781: Support ACPI_ID both TXNW2781 and TIAS2781
config: i386-buildonly-randconfig-003-20230912 (https://download.01.org/0day-ci/archive/20230912/202309122358.aEcJnIUJ-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230912/202309122358.aEcJnIUJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309122358.aEcJnIUJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/pci/hda/tas2781_hda_i2c.c:665:24: warning: variable 'tas_priv' is uninitialized when used here [-Wuninitialized]
                   return dev_err_probe(tas_priv->dev, -ENODEV,
                                        ^~~~~~~~
   sound/pci/hda/tas2781_hda_i2c.c:656:33: note: initialize the variable 'tas_priv' to silence this warning
           struct tasdevice_priv *tas_priv;
                                          ^
                                           = NULL
   1 warning generated.


vim +/tas_priv +665 sound/pci/hda/tas2781_hda_i2c.c

   653	
   654	static int tas2781_hda_i2c_probe(struct i2c_client *clt)
   655	{
   656		struct tasdevice_priv *tas_priv;
   657		int ret, i;
   658	
   659		/* Check TIAS2781 or TXNW2781 */
   660		for (i = 0; i < ARRAY_SIZE(tas2781_acpi_hda_match); i++)
   661			if (strstr(dev_name(&clt->dev), tas2781_acpi_hda_match[i].id))
   662				break;
   663	
   664		if (i == ARRAY_SIZE(tas2781_acpi_hda_match))
 > 665			return dev_err_probe(tas_priv->dev, -ENODEV,
   666				"Device not available\n");
   667	
   668		tas_priv = tasdevice_kzalloc(clt);
   669		if (!tas_priv)
   670			return -ENOMEM;
   671	
   672		tas_priv->irq_info.irq = clt->irq;
   673		ret = tas2781_read_acpi(tas_priv, tas2781_acpi_hda_match[i].id);
   674		if (ret)
   675			return dev_err_probe(tas_priv->dev, ret,
   676				"Platform not supported\n");
   677	
   678		ret = tasdevice_init(tas_priv);
   679		if (ret)
   680			goto err;
   681	
   682		pm_runtime_set_autosuspend_delay(tas_priv->dev, 3000);
   683		pm_runtime_use_autosuspend(tas_priv->dev);
   684		pm_runtime_mark_last_busy(tas_priv->dev);
   685		pm_runtime_set_active(tas_priv->dev);
   686		pm_runtime_get_noresume(tas_priv->dev);
   687		pm_runtime_enable(tas_priv->dev);
   688	
   689		pm_runtime_put_autosuspend(tas_priv->dev);
   690	
   691		ret = component_add(tas_priv->dev, &tas2781_hda_comp_ops);
   692		if (ret) {
   693			dev_err(tas_priv->dev, "Register component failed: %d\n", ret);
   694			pm_runtime_disable(tas_priv->dev);
   695			goto err;
   696		}
   697	
   698		tas2781_reset(tas_priv);
   699	err:
   700		if (ret)
   701			tas2781_hda_remove(&clt->dev);
   702		return ret;
   703	}
   704	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
