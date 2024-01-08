Return-Path: <linux-kernel+bounces-20193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1872B827BB2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C13F1F23D7A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 23:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEFF56742;
	Mon,  8 Jan 2024 23:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fiJRU92I"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAECF1DDDC
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 23:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704757641; x=1736293641;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6RR7L84j9ABImNUePA+VATo4ttwSxPrmI54MpbcpA3o=;
  b=fiJRU92ITzEYHuMjb8Ur1o3eIVJibdQ/zmH132vwcNMlBNe2UVuSnrtD
   23CF5PsEt4090rd2FzC6ZZ75HnHd8IxY82wIIyjN/TSDD/XoV3VSQYWrw
   Rx9ETBiYv+ye/w9BXozl9BpeV8aTynAh2xzhZrZI5654L2No7VrRUur2f
   8KQCXbtxto+rbrc7iauQvLPvuSl7t/a13yaP6K0Mp3YX4syFFONgCQWVM
   MxN8el1XAwfKluIVysdXN8dfJ+wPqIBu5/q282Gkjs2U7lYgUzFLhnPSU
   vuoD7k0C6N7JjyW2u+KsxO2rpthdd+mny+CO3mhF6Y0hXNbQXFN/wu+7h
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="11520957"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="11520957"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 15:47:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="785014921"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="785014921"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jan 2024 15:47:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMzKu-0005EW-24;
	Mon, 08 Jan 2024 23:47:16 +0000
Date: Tue, 9 Jan 2024 07:46:58 +0800
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: sound/core/control.c:390:11: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <202401090705.hJXfE4sT-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5db8752c3b81bd33a549f6f812bab81e3bb61b20
commit: c27e1efb61c545f36c450ef60862df9251d239a4 ALSA: control: Use xarray for faster lookups
date:   1 year, 7 months ago
config: i386-randconfig-063-20240107 (https://download.01.org/0day-ci/archive/20240109/202401090705.hJXfE4sT-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240109/202401090705.hJXfE4sT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401090705.hJXfE4sT-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> sound/core/control.c:390:11: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long h @@     got restricted snd_ctl_elem_iface_t const [usertype] iface @@
   sound/core/control.c:390:11: sparse:     expected unsigned long h
   sound/core/control.c:390:11: sparse:     got restricted snd_ctl_elem_iface_t const [usertype] iface
   sound/core/control.c:926:17: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:926:26: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:927:17: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:927:26: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:946:48: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:1640:40: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer

vim +390 sound/core/control.c

   378	
   379	#ifdef CONFIG_SND_CTL_FAST_LOOKUP
   380	/* Compute a hash key for the corresponding ctl id
   381	 * It's for the name lookup, hence the numid is excluded.
   382	 * The hash key is bound in LONG_MAX to be used for Xarray key.
   383	 */
   384	#define MULTIPLIER	37
   385	static unsigned long get_ctl_id_hash(const struct snd_ctl_elem_id *id)
   386	{
   387		unsigned long h;
   388		const unsigned char *p;
   389	
 > 390		h = id->iface;
   391		h = MULTIPLIER * h + id->device;
   392		h = MULTIPLIER * h + id->subdevice;
   393		for (p = id->name; *p; p++)
   394			h = MULTIPLIER * h + *p;
   395		h = MULTIPLIER * h + id->index;
   396		h &= LONG_MAX;
   397		return h;
   398	}
   399	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

