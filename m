Return-Path: <linux-kernel+bounces-139724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BB28A06DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4EE284080
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3F513BAF1;
	Thu, 11 Apr 2024 03:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQiD5xjx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E02C13BAD2;
	Thu, 11 Apr 2024 03:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712806808; cv=none; b=tFEU+MQ5zrjyyJUHTO5ci9OrxIvQ2olZofQPvoAiYKhitY/b2CNINtIp7jgjNERNYl/lWnLm/LxMDSNk3DHBz9tCcZst28TgCMTNOgDeSRLOOxnZj5NcDnrvqE/dPu5CHPqRKokPoM90GwgEiBeHKrptGWeAc+v8bNlXTdgJtWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712806808; c=relaxed/simple;
	bh=2vVOJkm9dcqmIFTabw4YgBLSFIUdPWkH3GowrVie1xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oX7rYHmhju7d874enqyqhFXKLQDdpT9SmFFf3GfkzNYuzmdzKUcsnJfJdYOi0H6eeXSF2Yb0xX0TqL6fPYWfKQl5xJ11opJkZx0jcp6quMf+a/oqSVdHRB4H4whXKmqfF/oVUZshSGP/5OVhkWKyMsNo0bzYvc2xUs8N+JSfW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQiD5xjx; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712806806; x=1744342806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2vVOJkm9dcqmIFTabw4YgBLSFIUdPWkH3GowrVie1xo=;
  b=IQiD5xjxsz7IexdysMonK5JuirBixlwdpIomG+MmS/PLOpuqXtSRCsdw
   qLFK8w7y+vxBZVl17R0UYeY8wTtdCpAhtRW8LGwb60CLHbd73BC7WS/CO
   ZhTk4Cd/1j/d2Ac2aCw2Fiuk1LQKj6PKZhGhW0SuieqnAaMAoBlG+zOov
   +OSojEgY/uQiUt6Vc+gSJnd51IBFP6LJFJ0dd4csiGTj/l3m3lkyqBIit
   TLf7YgFVANtpaJzBAbadp442ZNl5+O/eocgjNcxPaJCSY42H8xr9kc1Js
   jqZpKs+9IylYRqGUhSqs3AM1kj69Vl9hE4KuK8Sl3xi6zxFeIgUSoR8O5
   w==;
X-CSE-ConnectionGUID: kr+Z7qpDT0q+4Fihp4OqbA==
X-CSE-MsgGUID: CpFLYCU3TEmDoGtbLLxUYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8375827"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="8375827"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 20:40:05 -0700
X-CSE-ConnectionGUID: JzFuyIHkS1mooMbLng2hCQ==
X-CSE-MsgGUID: SpoaNdRSSfCRG/krM6/zWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="20805023"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 10 Apr 2024 20:40:03 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rulI9-0008As-01;
	Thu, 11 Apr 2024 03:40:01 +0000
Date: Thu, 11 Apr 2024 11:39:52 +0800
From: kernel test robot <lkp@intel.com>
To: Stefan Binding <sbinding@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	Stefan Binding <sbinding@opensource.cirrus.com>
Subject: Re: [PATCH v1 1/7] ALSA: hda: cs35l41: Set the max PCM Gain using
 tuning setting
Message-ID: <202404111107.rM73jRGt-lkp@intel.com>
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
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20240411/202404111107.rM73jRGt-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240411/202404111107.rM73jRGt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404111107.rM73jRGt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:566,
                    from include/asm-generic/bug.h:22,
                    from arch/loongarch/include/asm/bug.h:60,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/loongarch/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from sound/pci/hda/cs35l41_hda.c:9:
   sound/pci/hda/cs35l41_hda.c: In function 'cs35l41_load_tuning_params':
>> sound/pci/hda/cs35l41_hda.c:565:39: warning: '%s' directive argument is null [-Wformat-overflow=]
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


vim +565 sound/pci/hda/cs35l41_hda.c

   555	
   556	static int cs35l41_load_tuning_params(struct cs35l41_hda *cs35l41, char *tuning_filename)
   557	{
   558		const struct firmware *tuning_param_file = NULL;
   559		char *tuning_param_filename = NULL;
   560		int ret;
   561	
   562		ret = cs35l41_request_tuning_param_file(cs35l41, tuning_filename, &tuning_param_file,
   563							&tuning_param_filename, cs35l41->acpi_subsystem_id);
   564		if (ret) {
 > 565			dev_dbg(cs35l41->dev, "Missing Tuning Param File: %s: %d\n",
   566				tuning_param_filename, ret);
   567			return 0;
   568		}
   569	
   570		ret = cs35l41_read_tuning_params(cs35l41, tuning_param_file);
   571		if (ret) {
   572			dev_err(cs35l41->dev, "Error reading Tuning Params from file: %s: %d\n",
   573				tuning_param_filename, ret);
   574			/* Reset to default Tuning Parameters */
   575			cs35l41_set_default_tuning_params(cs35l41);
   576		}
   577	
   578		release_firmware(tuning_param_file);
   579		kfree(tuning_param_filename);
   580	
   581		return ret;
   582	}
   583	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

