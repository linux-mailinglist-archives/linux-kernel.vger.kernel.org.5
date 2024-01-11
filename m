Return-Path: <linux-kernel+bounces-22988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B3982A613
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06DA51C23265
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC4B15A1;
	Thu, 11 Jan 2024 02:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kk8VBVgl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2C51858
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704940406; x=1736476406;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dpuckrJ9RLkzl0Q+o/IlZ62I1VZ/421rojV/xq2668k=;
  b=Kk8VBVglIbjuhNunl+6NIvTcYxH6uoxOeHcBGOI5DbIFjTW4LNJSiHQJ
   Pa563za9K0xxQ4IwieAv00hNl20Mqln9h4Q4+f9AIBebxlfRelOUdsYqn
   ASpjVxp3meBInLiwvwfK+VSw0PUBqSvisvFnRxMk7DKcB68/lMD+tlwl5
   6h94AtX+SL2zNUY5TkY72B3aKfs9EDWQiZTXnoZtgVPzb9Qmn/ZJ0x0BP
   pDDwwE8QvvDI6VoT8A2jp7mno91hPb6b2atjq0uD8tIp+sWgAa+zl6jLp
   mviKyk8bbVigdSxH7dFxj+JlPlSaJxfi8seuuiriH+Q2ctqbUNYMTFq6W
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="5801725"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="5801725"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 18:33:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="775446583"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="775446583"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 10 Jan 2024 18:33:23 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNksj-0007ik-0u;
	Thu, 11 Jan 2024 02:33:21 +0000
Date: Thu, 11 Jan 2024 10:33:09 +0800
From: kernel test robot <lkp@intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: lib/vsprintf.c:1528:9: warning: function 'va_format' might be a
 candidate for 'gnu_printf' format attribute
Message-ID: <202401111051.dDNWAfKw-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   acc657692aed438e9931438f8c923b2b107aebf9
commit: 45c3e93d751ea50861c796da3cbfc848fa6ddf55 vsprintf: Factor out %pV handler as va_format()
date:   4 years, 9 months ago
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20240111/202401111051.dDNWAfKw-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240111/202401111051.dDNWAfKw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401111051.dDNWAfKw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   lib/vsprintf.c:625:7: warning: no previous prototype for 'pointer_string' [-Wmissing-prototypes]
     625 | char *pointer_string(char *buf, char *end, const void *ptr,
         |       ^~~~~~~~~~~~~~
   lib/vsprintf.c: In function 'va_format':
>> lib/vsprintf.c:1528:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1528 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |         ^~~


vim +1528 lib/vsprintf.c

  1522	
  1523	static char *va_format(char *buf, char *end, struct va_format *va_fmt)
  1524	{
  1525		va_list va;
  1526	
  1527		va_copy(va, *va_fmt->va);
> 1528		buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
  1529		va_end(va);
  1530	
  1531		return buf;
  1532	}
  1533	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

