Return-Path: <linux-kernel+bounces-137349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD1389E0EE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC861F24249
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4759153BCA;
	Tue,  9 Apr 2024 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L1Bym2eD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E677D14D2AB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682055; cv=none; b=Jm4LvPkOSSxdg90Imh214+M1lt0G1o2rVMa8QpNYnK3vz2gx67z4jpiYYXFWWrOKiIiN4X+qPhU15krZTctQwyomRF+L+kCHlbB0xa0LerYjJ3uM+hYu6No0Zv0Rik5ecHjMziRaqRUo6ntF4v/TQTncldAblW5ZSbQWzNYkp1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682055; c=relaxed/simple;
	bh=FKssRu0p/meu6e+rq96ejjZXIY12wnzoRsWc4bjH1sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edzZ0obhCTyd48uyciwUobm3mT6i5K8IG3A0LeaYC/4KX9A40+SVn6cM8GNDTYZwmFVE413/6ryBSO17ngIjyy4zkNMnyII52/Lz4sr/MA8YCO20xwvgjnRUFQaZrk1Krc3vEf+SnuSHzOUomGxQnxfppin3w/gZzE1rzKgRVhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L1Bym2eD; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712682054; x=1744218054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FKssRu0p/meu6e+rq96ejjZXIY12wnzoRsWc4bjH1sc=;
  b=L1Bym2eDp0fDknvU+nyYR76rfZWjqRyt+8Ym5QYK9hJb+6/ZmmeSsyuG
   SkT+/qf9oZJZcVi3VIIsvrV8A1ObTiwhTt5p9LwADWK/70XY/UV5stjVC
   KjrOgg1bcsFd/MlJ0Mo+zbhlIUx9E3XnniPLSePUDlTivt+VLe1myrdfV
   H8+9OgBlUem5oUbPNvttGh68Bt1R78e9Mi2JgVj26IzqirjgIWWSMBnVi
   huJOOdlXt6Dc0KK0o7ifqnPiJNMhYDtTVbYA3RHUQsoTCoAvbRV5nUUUw
   4Mws2W/MnIcFYZN4NVtsPx84ENg/GRlPX1AzR1A8cXsvXdEl/6NbuYYwT
   Q==;
X-CSE-ConnectionGUID: UH6qhXbnRlu+mq1Jd0DeQw==
X-CSE-MsgGUID: ETgll1ApRICF5axrBcpjRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18573566"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="18573566"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 10:00:53 -0700
X-CSE-ConnectionGUID: aPYdnrrDT+6kda6GqIUjtg==
X-CSE-MsgGUID: g3qMP7FqRYat0QkGxSq9Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="24908740"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 09 Apr 2024 10:00:49 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruEpy-0006K6-2S;
	Tue, 09 Apr 2024 17:00:46 +0000
Date: Wed, 10 Apr 2024 01:00:36 +0800
From: kernel test robot <lkp@intel.com>
To: Baojun Xu <baojun.xu@ti.com>, tiwai@suse.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, robh+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com,
	perex@perex.cz, pierre-louis.bossart@linux.intel.com,
	kevin-lu@ti.com, shenghao-ding@ti.com, navada@ti.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, yung-chuan.liao@linux.intel.com,
	baojun.xu@ti.com, broonie@kernel.org, soyer@irl.hu
Subject: Re: [PATCH v2 2/3] ALSA: hda/tas2781: Main code of tas2781 driver
 for SPI
Message-ID: <202404100015.FAgrEOeO-lkp@intel.com>
References: <20240409024816.1180-3-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409024816.1180-3-baojun.xu@ti.com>

Hi Baojun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on tiwai-sound/for-linus rafael-pm/linux-next linus/master v6.9-rc3 next-20240409]
[cannot apply to rafael-pm/acpi-bus rafael-pm/devprop]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baojun-Xu/ALSA-hda-tas2781-Modification-for-add-tas2781-driver-for-SPI/20240409-105140
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20240409024816.1180-3-baojun.xu%40ti.com
patch subject: [PATCH v2 2/3] ALSA: hda/tas2781: Main code of tas2781 driver for SPI
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20240410/202404100015.FAgrEOeO-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 8b3b4a92adee40483c27f26c478a384cd69c6f05)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240410/202404100015.FAgrEOeO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404100015.FAgrEOeO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from sound/pci/hda/tas2781_hda_spi.c:9:
   In file included from include/linux/acpi.h:39:
   In file included from include/acpi/acpi_io.h:7:
   In file included from arch/arm64/include/asm/acpi.h:14:
   In file included from include/linux/memblock.h:12:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     509 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     516 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     528 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> sound/pci/hda/tas2781_hda_spi.c:1159:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1159 |         if (strstr(dev_name(&spi->dev), "TIAS2781")) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/pci/hda/tas2781_hda_spi.c:1203:6: note: uninitialized use occurs here
    1203 |         if (ret)
         |             ^~~
   sound/pci/hda/tas2781_hda_spi.c:1159:2: note: remove the 'if' if its condition is always true
    1159 |         if (strstr(dev_name(&spi->dev), "TIAS2781")) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1160 |                 device_name = "TIAS2781";
    1161 |                 tas_priv->save_calibration = tas2781_save_calibration;
    1162 |                 tas_priv->apply_calibration = tas2781_apply_calib;
    1163 |         } else
         |           ~~~~
    1164 |                 goto err;
         |                 ~~~~~~~~
>> sound/pci/hda/tas2781_hda_spi.c:1153:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    1153 |         if (!tas_priv)
         |             ^~~~~~~~~
   sound/pci/hda/tas2781_hda_spi.c:1203:6: note: uninitialized use occurs here
    1203 |         if (ret)
         |             ^~~
   sound/pci/hda/tas2781_hda_spi.c:1153:2: note: remove the 'if' if its condition is always false
    1153 |         if (!tas_priv)
         |         ^~~~~~~~~~~~~~
    1154 |                 goto err;
         |                 ~~~~~~~~
   sound/pci/hda/tas2781_hda_spi.c:1144:9: note: initialize the variable 'ret' to silence this warning
    1144 |         int ret;
         |                ^
         |                 = 0
   7 warnings generated.


vim +1159 sound/pci/hda/tas2781_hda_spi.c

  1138	
  1139	static int tas2781_hda_spi_probe(struct spi_device *spi)
  1140	{
  1141		struct tasdevice_priv *tas_priv;
  1142		struct tas2781_hda *tas_hda;
  1143		const char *device_name;
  1144		int ret;
  1145	
  1146		tas_hda = devm_kzalloc(&spi->dev, sizeof(*tas_hda), GFP_KERNEL);
  1147		if (!tas_hda)
  1148			return -ENOMEM;
  1149	
  1150		tas_hda->dev = &spi->dev;
  1151	
  1152		tas_priv = devm_kzalloc(&spi->dev, sizeof(*tas_priv), GFP_KERNEL);
> 1153		if (!tas_priv)
  1154			goto err;
  1155		tas_priv->dev = &spi->dev;
  1156		tas_priv->client = (void *)spi;
  1157		tas_hda->priv = tas_priv;
  1158	
> 1159		if (strstr(dev_name(&spi->dev), "TIAS2781")) {
  1160			device_name = "TIAS2781";
  1161			tas_priv->save_calibration = tas2781_save_calibration;
  1162			tas_priv->apply_calibration = tas2781_apply_calib;
  1163		} else
  1164			goto err;
  1165	
  1166		tas_priv->irq_info.irq = spi->irq;
  1167		dev_set_drvdata(&spi->dev, tas_hda);
  1168		ret = tas2781_read_acpi(tas_hda, device_name,
  1169			spi_get_chipselect(spi, 0));
  1170		if (ret)
  1171			return dev_err_probe(tas_hda->dev, ret,
  1172				"Platform not supported\n");
  1173	
  1174		tas_priv->regmap = devm_regmap_init_spi(spi, &tasdevice_regmap);
  1175		if (IS_ERR(tas_priv->regmap)) {
  1176			ret = PTR_ERR(tas_priv->regmap);
  1177			dev_err(tas_priv->dev, "Failed to allocate regmap: %d\n",
  1178				ret);
  1179			goto err;
  1180		}
  1181		ret = tasdevice_spi_init(tas_hda->priv);
  1182		if (ret)
  1183			goto err;
  1184	
  1185		pm_runtime_set_autosuspend_delay(tas_hda->dev, 3000);
  1186		pm_runtime_use_autosuspend(tas_hda->dev);
  1187		pm_runtime_mark_last_busy(tas_hda->dev);
  1188		pm_runtime_set_active(tas_hda->dev);
  1189		pm_runtime_get_noresume(tas_hda->dev);
  1190		pm_runtime_enable(tas_hda->dev);
  1191	
  1192		pm_runtime_put_autosuspend(tas_hda->dev);
  1193	
  1194		tas2781_spi_reset(tas_priv);
  1195	
  1196		ret = component_add(tas_hda->dev, &tas2781_hda_comp_ops);
  1197		if (ret) {
  1198			dev_err(tas_hda->dev, "Register component failed: %d\n", ret);
  1199			pm_runtime_disable(tas_hda->dev);
  1200		}
  1201	
  1202	err:
  1203		if (ret)
  1204			tas2781_hda_remove(&spi->dev);
  1205		return ret;
  1206	}
  1207	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

