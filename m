Return-Path: <linux-kernel+bounces-18757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D05482629B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 02:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D10B1C20E1A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 01:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C06F17E2;
	Sun,  7 Jan 2024 01:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fz1OUSXV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51BD1382
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 01:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704590926; x=1736126926;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pLKt8l3zHhf2KM16EP0P1b8oNxi281vd02UU80eSG00=;
  b=fz1OUSXVktHwHM1NUEgNYVQk0fGCTsLJskbItF7YI3UOoJBHpEbVEfWQ
   05nB6asSOqDz33WJRAVNZ6v6A2GAxo4nPLSA8MIcwv8mjppLBL/2CX4as
   cUpencvVnl12irte4xgerRicYGhmDBZIvfky6ew/ODpQu5bYJJnuz/YRH
   LXDhnaNfVXcw4iuZRS/22j40YOgjUREPPQkoLcsE+4Kwy5Xd7YMKxOSps
   5UCIPSlZH0EYf7jwo7MGnTw71gkTOHd3H3ow8uUZJBLvpSkcJdppg+ZCg
   XcUQUI4d2bNhf3iTyqB7YXCciM8PN5X41P38qpaEqX5MaVtxk6hLil7U9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="11178043"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="11178043"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 17:28:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="904468580"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="904468580"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 06 Jan 2024 17:28:43 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMHxx-0003F4-0g;
	Sun, 07 Jan 2024 01:28:41 +0000
Date: Sun, 7 Jan 2024 09:28:32 +0800
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: sound/core/control.c:390:11: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <202401070905.atBrWkl7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52b1853b080a082ec3749c3a9577f6c71b1d4a90
commit: c27e1efb61c545f36c450ef60862df9251d239a4 ALSA: control: Use xarray for faster lookups
date:   1 year, 7 months ago
config: x86_64-randconfig-121-20240106 (https://download.01.org/0day-ci/archive/20240107/202401070905.atBrWkl7-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401070905.atBrWkl7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401070905.atBrWkl7-lkp@intel.com/

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
   sound/core/control.c: note: in included file:
   sound/core/control_compat.c:193:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected int [assigned] err @@     got restricted snd_ctl_elem_type_t [usertype] type @@
   sound/core/control_compat.c:193:21: sparse:     expected int [assigned] err
   sound/core/control_compat.c:193:21: sparse:     got restricted snd_ctl_elem_type_t [usertype] type
   sound/core/control_compat.c:203:14: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control_compat.c:205:14: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control_compat.c:207:14: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control_compat.c:209:14: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control_compat.c:237:21: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control_compat.c:238:21: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control_compat.c:270:21: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control_compat.c:271:21: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer

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

