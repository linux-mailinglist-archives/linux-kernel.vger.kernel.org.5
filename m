Return-Path: <linux-kernel+bounces-133972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A855F89AB9E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8AB1F21E18
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C87239FC6;
	Sat,  6 Apr 2024 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lm1mpfwa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94141383A2
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712416841; cv=none; b=ggaA9FGwSoJs74eOV8h8BI769swE0HdYrMYb8pNjJMgBOpSg6AUrETjtNCHfTWNTej1+iTU8a93CrPR5qY6OaC9RORCHsibddqdUJrJof/o9mW+lJSvB53S+28M9n0oGSgRQQiXMOyulfzncq+ZEOdG0NE4rZPqwuBHR8ueg9fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712416841; c=relaxed/simple;
	bh=h33+JRIhIB4C749AdhNoUw22Cg1VDSQp2tVSMyM3x5o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SMkmrFmL+ZIZitTeqNyz9lOjlCHojZ1P7n2X76pOkk9egiJqtZGCRh0duk5Q83ylrIFljHK+pIAP5vNHj5/dwXsd8IPOTt8CggX5kLEYRb60AxKu7vQUsWeLRJXZowzqyYAvSyJBew/xydsim6iMp8IKO9x/fxGjWsy0TZKCmH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lm1mpfwa; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712416840; x=1743952840;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h33+JRIhIB4C749AdhNoUw22Cg1VDSQp2tVSMyM3x5o=;
  b=lm1mpfwa3qty8kK6htinAxrtTlKKp0F50YsdUJsifXHXHkUZUdp8br9G
   aJiSl0g0xA/j6rLBL0fp72XU3cnUnPqJeBkEHJr/rtx//zem5f6dQtxZc
   iIiGrg++jekbU9L21h/bWRTB9eJLSPZUL4eh/sOkU5ftVCG32UjG93f5m
   C6opugyJ92a+TbmOxDrvSy0J98bOzz0ym6QGqKuj1iX0kWkTR//Ek3xPx
   L0/uS2y0qoSOdEBsLjxk2HevY+3put5/zu7aL1pIeryIBAKFOnHaBROgj
   qWWbAFnjoFDC7jj9R7c/voybKAL8JDfFosIzSc/1iiSjtnPXW7ZP9qAyg
   g==;
X-CSE-ConnectionGUID: MQaXraQmRi+IvBRpRgRMkg==
X-CSE-MsgGUID: Dzsaw4AqSmGAGPoYt5YzUQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="7860953"
X-IronPort-AV: E=Sophos;i="6.07,183,1708416000"; 
   d="scan'208";a="7860953"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 08:20:39 -0700
X-CSE-ConnectionGUID: qkt0qdnjSEi7E817opw6KA==
X-CSE-MsgGUID: s+JhaOf3Sayw3xa+On7PkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,183,1708416000"; 
   d="scan'208";a="50415204"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 06 Apr 2024 08:20:37 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rt7qN-0003b6-15;
	Sat, 06 Apr 2024 15:20:35 +0000
Date: Sat, 6 Apr 2024 23:20:21 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>
Subject: powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data150'
 from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data150'
Message-ID: <202404062331.U6Dreg68-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6c6e47d69d821047097909288b6d7f1aafb3b9b1
commit: f568a3d49af9aed813a184353592efe29b0e3d16 bpf,lsm: Add BPF token LSM hooks
date:   2 months ago
config: powerpc-randconfig-r035-20220327 (https://download.01.org/0day-ci/archive/20240406/202404062331.U6Dreg68-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240406/202404062331.U6Dreg68-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404062331.U6Dreg68-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data150' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data150'
>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data150' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data150'
>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data150' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data150'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

