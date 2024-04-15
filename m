Return-Path: <linux-kernel+bounces-144481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBAC8A46D8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1772B22263
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA3F12E78;
	Mon, 15 Apr 2024 02:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UKJxlxxj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8181171C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 02:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713147466; cv=none; b=h1WHS7zTuTC0mTRQeySHTUG6uBTlaPjDW/YWEU2RfbdQvZzhtG4Cs+dq5RHivlXUx9uToyXQrLwVUZqaYaLtlFEr/6RT+Drpog8juhPq0Sw7xFzavOUJdpL2IZylIlntl2wNbPud0v4FXAINY76mnCVNh7kBB2DItu3aPgN7+bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713147466; c=relaxed/simple;
	bh=fByRjmd63QlLshRhWPWyFhHfJvMedyd0qCUqMBoPieI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Umm1mtfQZHRyJwuKEEqWR+XdTuLgF6m0LTmcGe685+ROiYSOzXZi0X0dNDqA4mBDKy90M/zarnCMeHIiVboFrzDkfmYD+xMLQaIgccJVyjT0Mj9y8bc8pHiLUEWh9OvWsi5vqdjxUEmZnOcfcuTqCmIISAjhxH+POqebeiCpSKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UKJxlxxj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713147464; x=1744683464;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fByRjmd63QlLshRhWPWyFhHfJvMedyd0qCUqMBoPieI=;
  b=UKJxlxxjE8pyRRFbQdk61fX2GKtUq6u+Vp8lxl229kVmAxNs9lpEgOVv
   F4oYKMWvOHr0cdWQlfgzsftMrCmd/3CeAinWb3Sd5+apdPbc6DwFnGRPp
   mfO6BeQtJQXTGTsvjQkiHlJaaoo0BwXlUWywOvOpnOL3/T+NSkE/fcyJQ
   KH8euIopMopiEw46vz+vtTHXbWWItWhCNgDXcn24VgEST8nMjq0xkwexP
   omuYBhSaTDbFBfrmu+VqAhONb3DdLEMO1Odu+i8S5DDb3R7VUynqtUtJr
   GawVjSJxJath62W7wxRcGWY0OSLomfrOGxDPvAf0gzsuxWEaq9XMB/5L0
   Q==;
X-CSE-ConnectionGUID: D1839rXAS3GjV0C4Lj+CCg==
X-CSE-MsgGUID: 8OVENRGvTRCaJfBg0jMbJQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="19663855"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="19663855"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 19:17:43 -0700
X-CSE-ConnectionGUID: jwhbEjinTVmrKls+jyYZYQ==
X-CSE-MsgGUID: e5cTa1yDS9eGFXiMepsF5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21757679"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 14 Apr 2024 19:17:41 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwBtd-0003uZ-34;
	Mon, 15 Apr 2024 02:16:59 +0000
Date: Mon, 15 Apr 2024 10:15:48 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>
Subject: WARNING: modpost: vmlinux: section mismatch in reference:
 __apply_fineibt+0x566 (section: .text) -> poison_endbr (section: .init.text)
Message-ID: <202404151042.vATlNGmU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peter,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0bbac3facb5d6cc0171c45c9873a2dc96bea9680
commit: 04505bbbbb15da950ea0239e328a76a3ad2376e0 x86/fineibt: Poison ENDBR at +0
date:   9 months ago
config: x86_64-buildonly-randconfig-001-20240415 (https://download.01.org/0day-ci/archive/20240415/202404151042.vATlNGmU-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240415/202404151042.vATlNGmU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404151042.vATlNGmU-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x12e (section: .text) -> text_poke_early (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x1f2 (section: .text) -> text_poke_early (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x2e6 (section: .text) -> text_poke_early (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x381 (section: .text) -> text_poke_early (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x3a4 (section: .text) -> text_poke_early (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x44d (section: .text) -> text_poke_early (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x50d (section: .text) -> text_poke_early (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x532 (section: .text) -> text_poke_early (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x566 (section: .text) -> poison_endbr (section: .init.text)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

