Return-Path: <linux-kernel+bounces-167102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD468BA48D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20713285482
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E09441F;
	Fri,  3 May 2024 00:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W897Nhad"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89A6634
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 00:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714696151; cv=none; b=LwoGrQv6XlJv3pijWtOdEKcng3Ih2upC8v7ZDMrzDEiCC407p3dbf4JYaugk7sWXrjKm469PxYelM+Cxat2nwvNHwD0Ivme/1fKpWdvJqqc7cuTXgpsU7VT9zqJdmZ3fzoxJusgrl3/ImIFKAY2aAcmXM7KnEzZvCq9cliTKRwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714696151; c=relaxed/simple;
	bh=puLPOqHdTBWzrdDXPT9XAFBKgG0JlBdLbY25lWqckzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoG1f/+0Iw/Ta+tEwglHk0awYCEeK3QtmoN1ct3MjGoYNU0J+Nt5bgw/NvhokBxEDTG6TfWFQlVZiLWMtTVLJy2KrME224z+yHOXW63o+eMICP7O2IG0XzF4HPSaW5/af1BI8zFNNi5itgAbtBOmOuqMHDQozFXiOf8nCdYOXms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W897Nhad; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714696150; x=1746232150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=puLPOqHdTBWzrdDXPT9XAFBKgG0JlBdLbY25lWqckzg=;
  b=W897Nhad1SrlT7uWUdB+3PCygYR+TmxToIWdKNXVWrlja10OnFstG+Uv
   UJOn8Y0mNNFnT/C/Pz0Yr7jvX7MSM4EIQwbqllpOpYZ4TIgcXkmkIUV1z
   D7jvXx9dqfaCl5GodsCoVbXmH9JKfP62bkh8ieKQs2Z5RGlT8Q/xWjeIG
   33sorRkCEj+JRmaMr57HoERnG9tDIzaN6hmMFtSG3RbayxMyUQuxsk5w/
   nBVuIAdiwPm4kP5zHelbFeEY/PJO7u1/y7+Rwth9wNKZKFx1wHqVHrwBb
   ku/VqH/8chID/ml6PiII18nOk/6R9vUrKwKffsEKnW8Urx5mzXXz5LG3z
   g==;
X-CSE-ConnectionGUID: orBNdTJOSSuM0m7J8SeSug==
X-CSE-MsgGUID: TtRIDQ9ATwyagRuVf9fW+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10716088"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10716088"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 17:29:09 -0700
X-CSE-ConnectionGUID: X9l6xvDRRbS1T0WgUDKoFA==
X-CSE-MsgGUID: Q71nkuTYR+qnkgThUY4ymQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27171393"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 02 May 2024 17:29:06 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2gnQ-000BAK-16;
	Fri, 03 May 2024 00:29:04 +0000
Date: Fri, 3 May 2024 08:28:05 +0800
From: kernel test robot <lkp@intel.com>
To: Maksim Davydov <davydov-max@yandex-team.ru>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davydov-max@yandex-team.ru,
	den-plotnikov@yandex-team.ru, dave.hansen@linux.intel.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	gpiccoli@igalia.com
Subject: Re: [PATCH v2] x86/split_lock: fix delayed detection enabling
Message-ID: <202405030838.XyIfnymG-lkp@intel.com>
References: <20240502102731.84429-1-davydov-max@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502102731.84429-1-davydov-max@yandex-team.ru>

Hi Maksim,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on tip/master linus/master v6.9-rc6 next-20240502]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maksim-Davydov/x86-split_lock-fix-delayed-detection-enabling/20240502-183110
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20240502102731.84429-1-davydov-max%40yandex-team.ru
patch subject: [PATCH v2] x86/split_lock: fix delayed detection enabling
config: i386-buildonly-randconfig-005-20240503 (https://download.01.org/0day-ci/archive/20240503/202405030838.XyIfnymG-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240503/202405030838.XyIfnymG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405030838.XyIfnymG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/intel.c:1113:13: warning: '__split_lock_reenable' defined but not used [-Wunused-function]
    1113 | static void __split_lock_reenable(struct work_struct *work)
         |             ^~~~~~~~~~~~~~~~~~~~~


vim +/__split_lock_reenable +1113 arch/x86/kernel/cpu/intel.c

727209376f4998 Guilherme G. Piccoli 2022-10-24  1112  
727209376f4998 Guilherme G. Piccoli 2022-10-24 @1113  static void __split_lock_reenable(struct work_struct *work)
727209376f4998 Guilherme G. Piccoli 2022-10-24  1114  {
727209376f4998 Guilherme G. Piccoli 2022-10-24  1115  	sld_update_msr(true);
727209376f4998 Guilherme G. Piccoli 2022-10-24  1116  }
73f2dbc05507dd Maksim Davydov       2024-05-02  1117  /*
73f2dbc05507dd Maksim Davydov       2024-05-02  1118   * In order for each CPU to schedule itself delayed work independently of the
73f2dbc05507dd Maksim Davydov       2024-05-02  1119   * others, delayed work struct should be per-CPU. This is not required when
73f2dbc05507dd Maksim Davydov       2024-05-02  1120   * sysctl_sld_mitigate is enabled because of the semaphore, that limits
73f2dbc05507dd Maksim Davydov       2024-05-02  1121   * the number of simultaneously scheduled delayed works to 1.
73f2dbc05507dd Maksim Davydov       2024-05-02  1122   */
73f2dbc05507dd Maksim Davydov       2024-05-02  1123  static DEFINE_PER_CPU(struct delayed_work, sl_reenable);
73f2dbc05507dd Maksim Davydov       2024-05-02  1124  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

