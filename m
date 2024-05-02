Return-Path: <linux-kernel+bounces-165968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 014758B9401
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94EE91F24B77
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B981CD3B;
	Thu,  2 May 2024 04:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3zl5MD5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440801C2AF
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 04:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625725; cv=none; b=LP9ui7DDOL69KFTY7vKD4uAmcPuyCyrAuvK+l+LubOB9X5zQ4fwL/xy4KxkPlXcOWGr0d6+O2cFFchUAfBg+L+9GSXFuo6AxC5PnhcMuiW0xJ58L9cm4xOfA6vWxb/Wtoa+U2/IAtS2yZ4gWybfUuufBjCsD9XFxzd2D+MojF2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625725; c=relaxed/simple;
	bh=4IglGpEQXVEJd3y9Ud+13pqeqzo11NDvuTmBinB2z90=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=olnbSG6ufOoYPZWdj7tn+ncguTuhLI7mCg48s8DQRduQDtk9nV6OKVaMmdLnARtT8z4WgBcFrYYJxpDDUGGg+reVYTJ1Gq84CkjgoDdTrQnZ98mOYt2VJqgnaDEOfZFjD7+ycUBY1U1I8hJkXBMyJN+lI10B8sYs3bIxilMX20s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I3zl5MD5; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714625724; x=1746161724;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4IglGpEQXVEJd3y9Ud+13pqeqzo11NDvuTmBinB2z90=;
  b=I3zl5MD51K3MtJrCkYDjylzcw6QME7pqFUvUJS9LPdY9CPeL9YpZAKJ3
   29555IQzFX+gFiThbnmrNbf3nNtgiMHrjPeprAQaIppOw8rkRBLXh/CpN
   WjRG06D36MZjxvNO/cFrf+k+QgLLCdkfCM9+wHLCtUSG/LX3GuXR0ZP+r
   rtglaee/FfDtJl/MZsBM0u0+Kj7z5TEXWK9NJRXeszs5YQ5RN/4WM4bvS
   6mzsubuKvzUdPgSR4i0JF3HSSnNrXicFWJU7kafakMVSdLKgc0oshkdXH
   IkcYlGOaUGx4yFBSMNnsVJPKGAbdiN+UcuJkivBHvRIvnksu868wPRkDp
   w==;
X-CSE-ConnectionGUID: 8zYqznxuRKmaCb2yVZfU7A==
X-CSE-MsgGUID: ST5mad8GQSKlfuSWwT5dzA==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="14157639"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="14157639"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 21:55:23 -0700
X-CSE-ConnectionGUID: oEc6hzzvTXCgCbWiK/RNpQ==
X-CSE-MsgGUID: ltjWT4plSKGKyTGA/GMSSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="50192763"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 01 May 2024 21:55:21 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2OTX-000AP2-0g;
	Thu, 02 May 2024 04:55:19 +0000
Date: Thu, 2 May 2024 12:54:54 +0800
From: kernel test robot <lkp@intel.com>
To: Shenghao Ding <13916275206@139.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: include/linux/compiler.h:69:46: warning: 'fw_entry' is used
 uninitialized
Message-ID: <202405021200.YHInjV43-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Shenghao,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0106679839f7c69632b3b9833c3268c316c0a9fc
commit: ef3bcde75d06d65f78ba38a30d5a87fb83a5cdae ASoC: tas2781: Add tas2781 driver
date:   11 months ago
config: sh-randconfig-r033-20230707 (https://download.01.org/0day-ci/archive/20240502/202405021200.YHInjV43-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240502/202405021200.YHInjV43-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405021200.YHInjV43-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/firmware.h:6,
                    from sound/soc/codecs/tas2781-fmwlib.c:10:
   sound/soc/codecs/tas2781-fmwlib.c: In function 'tas2781_load_calibration':
>> include/linux/compiler.h:69:46: warning: 'fw_entry' is used uninitialized [-Wuninitialized]
      68 |         (cond) ?                                        \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      69 |                 (__if_trace.miss_hit[1]++,1) :          \
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
      70 |                 (__if_trace.miss_hit[0]++,0);           \
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
   include/linux/compiler.h:57:69: note: in expansion of macro '__trace_if_value'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                                     ^~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   sound/soc/codecs/tas2781-fmwlib.c:1972:9: note: in expansion of macro 'if'
    1972 |         if (fw_entry)
         |         ^~
   sound/soc/codecs/tas2781-fmwlib.c:1911:32: note: 'fw_entry' was declared here
    1911 |         const struct firmware *fw_entry;
         |                                ^~~~~~~~


vim +/fw_entry +69 include/linux/compiler.h

a15fd609ad53a6 Linus Torvalds 2019-03-20  58  
a15fd609ad53a6 Linus Torvalds 2019-03-20  59  #define __trace_if_value(cond) ({			\
2bcd521a684cc9 Steven Rostedt 2008-11-21  60  	static struct ftrace_branch_data		\
e04462fb82f8dd Miguel Ojeda   2018-09-03  61  		__aligned(4)				\
33def8498fdde1 Joe Perches    2020-10-21  62  		__section("_ftrace_branch")		\
a15fd609ad53a6 Linus Torvalds 2019-03-20  63  		__if_trace = {				\
2bcd521a684cc9 Steven Rostedt 2008-11-21  64  			.func = __func__,		\
2bcd521a684cc9 Steven Rostedt 2008-11-21  65  			.file = __FILE__,		\
2bcd521a684cc9 Steven Rostedt 2008-11-21  66  			.line = __LINE__,		\
2bcd521a684cc9 Steven Rostedt 2008-11-21  67  		};					\
a15fd609ad53a6 Linus Torvalds 2019-03-20  68  	(cond) ?					\
a15fd609ad53a6 Linus Torvalds 2019-03-20 @69  		(__if_trace.miss_hit[1]++,1) :		\
a15fd609ad53a6 Linus Torvalds 2019-03-20  70  		(__if_trace.miss_hit[0]++,0);		\
a15fd609ad53a6 Linus Torvalds 2019-03-20  71  })
a15fd609ad53a6 Linus Torvalds 2019-03-20  72  

:::::: The code at line 69 was first introduced by commit
:::::: a15fd609ad53a631a927c6680e8fb606f42a712b tracing: Simplify "if" macro code

:::::: TO: Linus Torvalds <torvalds@linux-foundation.org>
:::::: CC: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

