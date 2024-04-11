Return-Path: <linux-kernel+bounces-139698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3F38A069A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CEA3B263E6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783A413B7BC;
	Thu, 11 Apr 2024 03:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNY4khpL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FB723BF;
	Thu, 11 Apr 2024 03:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712805487; cv=none; b=XgF+ObFo6NOC1LVs8ppT3yqLawVCY5pYa2R1ZAHwKMvqx+lpegGoa+1Ks+ZEL70qCC0zfU3uTduacAdQNM5GMLXnVWjqVZU8mESNi6hIW+8JFVaaDqkYZiuVirhcBSM+iXA/CfY5ManKat2WjJwikqMjaSQGL121ozMlrmjKMvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712805487; c=relaxed/simple;
	bh=Do3t+lDJZQ7My5Ynd97bOg7IPixQUDhEiSuYqHly810=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u65am6acmi7ErgdZjbVWHcOOXJ7xwNLz0ZmyHH/2Tf7+lXy5zj6xK5u/yRNAqVAs9MXK9vGwkfK4GMbNW8FcU/osilJo8ka+ab1Rz2UfXNSsmzvCMv/bCRHHI4Hhqx5T3nDj6hfextAN0aUY6kQBbP5v2zxQl0LjeiSBaKeM6nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNY4khpL; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712805485; x=1744341485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Do3t+lDJZQ7My5Ynd97bOg7IPixQUDhEiSuYqHly810=;
  b=NNY4khpLMPV9b01CXW7SB4Ur2HYRdb0SGGhWPfASicZKcKt0/xkUlRIE
   BoDeKKOXBCOThocGVSo4VxVePzFyl6eg2+gqyuHdssLJUb2shS7EW8NMi
   XDG0DrdVb7XvSVquj42am6/XUFnKRHDPIk4xBl/95dvlBHhuf0UlQvOnJ
   h8KNJwUnDEpuswtCb244uRIMxVLdUw3AvcGI9RVGR8/Doo8A0PBmVGTCa
   UhYYrS8IO08UkzbH0smwE/Nm3bzduXW4pGgMbyciuEatljsQJNikaX/qb
   LfgTatlzq/W/yFXIQCxdJXMN4U9hYVHM2AtULGJaVeaPygsCW+YsyoVF3
   A==;
X-CSE-ConnectionGUID: iw9aKiT/SXuVoPwVo0gd7w==
X-CSE-MsgGUID: cZGbMhItTrW8NUCcpe66cw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8361913"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="8361913"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 20:18:05 -0700
X-CSE-ConnectionGUID: MFJlynp3QiuTL7BegSBILg==
X-CSE-MsgGUID: E2fpeducQSmI8sUr5yWpNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="25540715"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 10 Apr 2024 20:18:03 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rukwq-00089i-0r;
	Thu, 11 Apr 2024 03:18:00 +0000
Date: Thu, 11 Apr 2024 11:17:34 +0800
From: kernel test robot <lkp@intel.com>
To: Stefan Binding <sbinding@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	Stefan Binding <sbinding@opensource.cirrus.com>
Subject: Re: [PATCH v1 1/7] ALSA: hda: cs35l41: Set the max PCM Gain using
 tuning setting
Message-ID: <202404111139.1pqQN9c6-lkp@intel.com>
References: <20240410155223.7164-2-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410155223.7164-2-sbinding@opensource.cirrus.com>

Hi Stefan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on tiwai-sound/for-linus linus/master v6.9-rc3 next-20240410]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Binding/ALSA-hda-cs35l41-Set-the-max-PCM-Gain-using-tuning-setting/20240410-235446
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20240410155223.7164-2-sbinding%40opensource.cirrus.com
patch subject: [PATCH v1 1/7] ALSA: hda: cs35l41: Set the max PCM Gain using tuning setting
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240411/202404111139.1pqQN9c6-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240411/202404111139.1pqQN9c6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404111139.1pqQN9c6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/acpi.h:14,
                    from sound/pci/hda/cs35l41_hda.c:9:
   sound/pci/hda/cs35l41_hda.c: In function 'cs35l41_read_tuning_params':
>> sound/pci/hda/cs35l41_hda.c:511:39: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     511 |                 dev_err(cs35l41->dev, "Wrong Size for Tuning Param file. Expected %d got %ld\n",
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   sound/pci/hda/cs35l41_hda.c:511:17: note: in expansion of macro 'dev_err'
     511 |                 dev_err(cs35l41->dev, "Wrong Size for Tuning Param file. Expected %d got %ld\n",
         |                 ^~~~~~~
   sound/pci/hda/cs35l41_hda.c:511:92: note: format string is defined here
     511 |                 dev_err(cs35l41->dev, "Wrong Size for Tuning Param file. Expected %d got %ld\n",
         |                                                                                          ~~^
         |                                                                                            |
         |                                                                                            long int
         |                                                                                          %d
   In file included from include/linux/printk.h:566,
                    from include/asm-generic/bug.h:22,
                    from arch/x86/include/asm/bug.h:87,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/linux/spinlock.h:60,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13:
   sound/pci/hda/cs35l41_hda.c: In function 'cs35l41_load_tuning_params':
   sound/pci/hda/cs35l41_hda.c:565:39: warning: '%s' directive argument is null [-Wformat-overflow=]
     565 |                 dev_dbg(cs35l41->dev, "Missing Tuning Param File: %s: %d\n",
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:224:29: note: in definition of macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:9: note: in expansion of macro '_dynamic_func_call_cls'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:273:9: note: in expansion of macro '_dynamic_func_call'
     273 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   sound/pci/hda/cs35l41_hda.c:565:17: note: in expansion of macro 'dev_dbg'
     565 |                 dev_dbg(cs35l41->dev, "Missing Tuning Param File: %s: %d\n",
         |                 ^~~~~~~
   sound/pci/hda/cs35l41_hda.c:565:67: note: format string is defined here
     565 |                 dev_dbg(cs35l41->dev, "Missing Tuning Param File: %s: %d\n",
         |                                                                   ^~


vim +511 sound/pci/hda/cs35l41_hda.c

   500	
   501	static int cs35l41_read_tuning_params(struct cs35l41_hda *cs35l41, const struct firmware *firmware)
   502	{
   503		struct cs35l41_tuning_params *params;
   504		unsigned int offset = 0;
   505		unsigned int end;
   506		int i;
   507	
   508		params = (void *)&firmware->data[0];
   509	
   510		if (le32_to_cpu(params->size) != firmware->size) {
 > 511			dev_err(cs35l41->dev, "Wrong Size for Tuning Param file. Expected %d got %ld\n",
   512				le32_to_cpu(params->size), firmware->size);
   513			return -EINVAL;
   514		}
   515	
   516		if (le32_to_cpu(params->version) != 1) {
   517			dev_err(cs35l41->dev, "Unsupported Tuning Param Version: %d\n",
   518				le32_to_cpu(params->version));
   519			return -EINVAL;
   520		}
   521	
   522		if (le32_to_cpu(params->signature) != CS35L41_TUNING_SIG) {
   523			dev_err(cs35l41->dev,
   524				"Mismatched Signature for Tuning Param file. Expected %#x got %#x\n",
   525				CS35L41_TUNING_SIG, le32_to_cpu(params->signature));
   526			return -EINVAL;
   527		}
   528	
   529		end = firmware->size - sizeof(struct cs35l41_tuning_params);
   530	
   531		for (i = 0; i < le32_to_cpu(params->num_entries); i++) {
   532			struct cs35l41_tuning_param *param;
   533	
   534			if ((offset >= end) || ((offset + sizeof(struct cs35l41_tuning_param_hdr)) >= end))
   535				return -EFAULT;
   536	
   537			param = (void *)&params->data[offset];
   538			offset += le32_to_cpu(param->hdr.size);
   539	
   540			if (offset > end)
   541				return -EFAULT;
   542	
   543			switch (le32_to_cpu(param->hdr.type)) {
   544			case TUNING_PARAM_GAIN:
   545				cs35l41->tuning_gain = le32_to_cpu(param->gain);
   546				dev_dbg(cs35l41->dev, "Applying Gain: %d\n", cs35l41->tuning_gain);
   547				break;
   548			default:
   549				break;
   550			}
   551		}
   552	
   553		return 0;
   554	}
   555	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

