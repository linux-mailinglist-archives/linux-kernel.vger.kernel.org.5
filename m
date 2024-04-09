Return-Path: <linux-kernel+bounces-137465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD4A89E27F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B452D2859EE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75650156C54;
	Tue,  9 Apr 2024 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RDIYaTTg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725F0156892
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712687240; cv=none; b=SHbBpioUOhYJwlHGJrxnIGvSOXH22QVoadpmcUJQaB7TmS8uWlDcfg4Q/atlkTZ7zSrICoVxHoxN+6v5Gda4JGB0Xv1M3tJczC46WKlZV55KiH7AZrUTiHT1HugUB+IjP3UF1jCc8qkWMV2zcs5kgKQovd48Et4YNi7fdB8rYa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712687240; c=relaxed/simple;
	bh=lo23YThJkiJCXKlV2P8H/1qt2vZO8tqLHhRvvMJqdkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkCsoRZXF6826UoyDIblb4U9/U2bPynVmlFCspN/alYvaziy/mcZcJDSTQnaF/7ag9uqHKT7Zabcs57p3fG2U+IdUVCDA6l2K4+lLUI9ZcWTYTvbgevjaM0pDgXFUW73XnAwy1ap4WMGo+CTg4PBGUbYi3Gsi14/hEnobcAFsVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RDIYaTTg; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712687239; x=1744223239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lo23YThJkiJCXKlV2P8H/1qt2vZO8tqLHhRvvMJqdkY=;
  b=RDIYaTTgYFTPt4vVRjsHekfVwrrinlfXLRyvc14Ifgg19Y/a/BMrVAUc
   5sCjJhSuShZa8Je7X0PUZMRYImvksony9FAaVtOKy5629P1Fkg+ndgy4s
   /yyHd2Rg+k1NSPqT8h41Ai/kSYTwbOtlRfEbL3tyiFIwCtJ7FIHAaZs78
   ku5J/SPLt5seOyLPyMLUVoQpzdCqtrpU71UCf43qHpMzQe8+ZUE9dqyEJ
   6IJ4RPTw0nw0SY2LM2Srwlyb29Mlk0dY3UwOgt01QmyfSUNIeBvDIyZji
   xwqf1JZR3lnYjr53zN6FdS0viaX1b2mOoX0zj57gaQIC0ZGrQgbUyNsXm
   A==;
X-CSE-ConnectionGUID: FS8v8nu5RVin/tDemescOA==
X-CSE-MsgGUID: +B5TyFQVSCuv1j/EjA23dg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11794482"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11794482"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 11:27:06 -0700
X-CSE-ConnectionGUID: kl7Y9QmPTgypXWqvuJb2wA==
X-CSE-MsgGUID: EDLQ/48KQ7a9xCHI2+LjwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="57756617"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 09 Apr 2024 11:26:57 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruGBK-0006PK-1f;
	Tue, 09 Apr 2024 18:26:54 +0000
Date: Wed, 10 Apr 2024 02:26:07 +0800
From: kernel test robot <lkp@intel.com>
To: Baojun Xu <baojun.xu@ti.com>, tiwai@suse.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, robh+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com,
	perex@perex.cz, pierre-louis.bossart@linux.intel.com,
	kevin-lu@ti.com, shenghao-ding@ti.com, navada@ti.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, yung-chuan.liao@linux.intel.com,
	baojun.xu@ti.com, broonie@kernel.org, soyer@irl.hu
Subject: Re: [PATCH v2 3/3] ALSA: hda/tas2781: Firmware load for tas2781
 driver for SPI
Message-ID: <202404100229.tkI9vGOu-lkp@intel.com>
References: <20240409024816.1180-4-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409024816.1180-4-baojun.xu@ti.com>

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
patch link:    https://lore.kernel.org/r/20240409024816.1180-4-baojun.xu%40ti.com
patch subject: [PATCH v2 3/3] ALSA: hda/tas2781: Firmware load for tas2781 driver for SPI
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20240410/202404100229.tkI9vGOu-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 8b3b4a92adee40483c27f26c478a384cd69c6f05)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240410/202404100229.tkI9vGOu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404100229.tkI9vGOu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from sound/pci/hda/tas2781_spi_fwlib.c:17:
   In file included from include/sound/pcm_params.h:10:
   In file included from include/sound/pcm.h:15:
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
>> sound/pci/hda/tas2781_spi_fwlib.c:2149:3: warning: variable 'status' is uninitialized when used here [-Wuninitialized]
    2149 |                 status++;
         |                 ^~~~~~
   sound/pci/hda/tas2781_spi_fwlib.c:2084:12: note: initialize the variable 'status' to silence this warning
    2084 |         int status;
         |                   ^
         |                    = 0
   6 warnings generated.


vim +/status +2149 sound/pci/hda/tas2781_spi_fwlib.c

  2073	
  2074	int tasdevice_spi_select_tuningprm_cfg(void *context, int prm_no,
  2075		int cfg_no, int rca_conf_no)
  2076	{
  2077		struct tasdevice_priv *tas_priv = (struct tasdevice_priv *) context;
  2078		struct tasdevice_rca *rca = &(tas_priv->rcabin);
  2079		struct tasdevice_config_info **cfg_info = rca->cfg_info;
  2080		struct tasdevice_fw *tas_fmw = tas_priv->fmw;
  2081		struct tasdevice_prog *program;
  2082		struct tasdevice_config *conf;
  2083		int prog_status = 0;
  2084		int status;
  2085	
  2086		if (!tas_fmw) {
  2087			dev_err(tas_priv->dev, "%s: Firmware is NULL\n", __func__);
  2088			return 0;
  2089		}
  2090	
  2091		if (cfg_no >= tas_fmw->nr_configurations) {
  2092			dev_err(tas_priv->dev,
  2093				"%s: cfg(%d) is not in range of conf %u\n",
  2094				__func__, cfg_no, tas_fmw->nr_configurations);
  2095			return 0;
  2096		}
  2097	
  2098		if (prm_no >= tas_fmw->nr_programs) {
  2099			dev_err(tas_priv->dev,
  2100				"%s: prm(%d) is not in range of Programs %u\n",
  2101				__func__, prm_no, tas_fmw->nr_programs);
  2102			return 0;
  2103		}
  2104	
  2105		if (rca_conf_no >= rca->ncfgs || rca_conf_no < 0 ||
  2106			!cfg_info) {
  2107			dev_err(tas_priv->dev,
  2108				"conf_no:%d should be in range from 0 to %u\n",
  2109				rca_conf_no, rca->ncfgs-1);
  2110			return 0;
  2111		}
  2112	
  2113		if (cfg_info[rca_conf_no]->active_dev & 1) {
  2114			if (prm_no >= 0	&& (tas_priv->tasdevice.cur_prog != prm_no
  2115				|| tas_priv->force_fwload_status)) {
  2116				tas_priv->tasdevice.cur_conf = -1;
  2117				tas_priv->tasdevice.is_loading = true;
  2118				prog_status++;
  2119			}
  2120		} else {
  2121			tas_priv->tasdevice.is_loading = false;
  2122		}
  2123	
  2124		if (prog_status) {
  2125			program = &(tas_fmw->programs[prm_no]);
  2126			tasdevice_load_data(tas_priv, &(program->dev_data));
  2127			if (tas_priv->tasdevice.is_loaderr == false
  2128				&& tas_priv->tasdevice.is_loading == true) {
  2129				struct tasdevice_fw *cal_fmw =
  2130					tas_priv->tasdevice.cali_data_fmw;
  2131	
  2132				if (cal_fmw) {
  2133					struct tasdevice_calibration
  2134						*cal = cal_fmw->calibrations;
  2135	
  2136					if (cal)
  2137						load_calib_data(tas_priv,
  2138							&(cal->dev_data));
  2139				}
  2140				tas_priv->tasdevice.cur_prog = prm_no;
  2141			}
  2142	
  2143		}
  2144	
  2145		if (cfg_no >= 0
  2146			&& (tas_priv->tasdevice.cur_conf != cfg_no)
  2147			&& (cfg_info[rca_conf_no]->active_dev & 1)
  2148			&& (tas_priv->tasdevice.is_loaderr == false)) {
> 2149			status++;
  2150			tas_priv->tasdevice.is_loading = true;
  2151		} else {
  2152			tas_priv->tasdevice.is_loading = false;
  2153		}
  2154	
  2155		if (status) {
  2156			conf = &(tas_fmw->configs[cfg_no]);
  2157			status = 0;
  2158			tasdevice_load_data(tas_priv, &(conf->dev_data));
  2159			if (tas_priv->tasdevice.is_loaderr == true) {
  2160				status |= 1 << 4;
  2161			} else if (tas_priv->tasdevice.is_loaderr == false
  2162				&& tas_priv->tasdevice.is_loading == true) {
  2163				tas_priv->tasdevice.cur_conf = cfg_no;
  2164			}
  2165		} else
  2166			dev_dbg(tas_priv->dev, "%s: Unneeded loading dsp conf %d\n",
  2167				__func__, cfg_no);
  2168	
  2169		status |= cfg_info[rca_conf_no]->active_dev;
  2170	
  2171		return prog_status;
  2172	}
  2173	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

