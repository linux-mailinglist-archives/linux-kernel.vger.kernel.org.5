Return-Path: <linux-kernel+bounces-149817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 273F28A963B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08A71F224CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D325D15ADB0;
	Thu, 18 Apr 2024 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j0oy+b4K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90FE15AD95;
	Thu, 18 Apr 2024 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432819; cv=none; b=PohqbPj5xJR1kzUCSvsukTLHDJK3KPL4VPExBr1QH5hiON/vB81SEw7d45kLlXjDQ5esQv4zlDaIL4Hqa2IdsXGv9SsB+3nsITTACo/861bAtte+/hV6XCdmfcAZSnZd9ZSM3cRuXhKfyOl9pqk2+g9XQjvcs8HTLZCOqcZNQHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432819; c=relaxed/simple;
	bh=E0biilYrIbmIjH3B+Vc73MXIyGjCLEOCwMUtZLWWAh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZKXWFa7GsNjuU9R7tJzJ9Pc9mY27JkgVNyOrE575TiwGkpKoSnmvYIMzYpbXUdv9GNIN4rl4D86HGzv8/C2IZxxuK6RnJZCcTKXCspWWd4FkzbYI/22yv8AOwtaieBTJXYbfpnX4ds8ks+2AFb9BQrzrHNnh1MlkPxv5yxkOts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j0oy+b4K; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713432819; x=1744968819;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E0biilYrIbmIjH3B+Vc73MXIyGjCLEOCwMUtZLWWAh8=;
  b=j0oy+b4KY9aGnaWIvwzWCeGhyQIBrH4P0Pf7Pgqvpe79MI2EDFw3eAoq
   Z4rJaauzo4/lX/SuXlWZdvelykORPwxg1rRjvzQlLVrICirGKoVYXT9Zp
   JPGNfHzMZcvuIXnPrPLi/Wgae7JByoR7GPtTXFjmBtqr0WXZVLR3h3XqH
   DjdXDq0J2oElGN7qgncNwZs5bMDmSNtNAekkhTlI/UiwAhlmpJE2S8zxr
   ClBqvDiijefyi4q0EA/Rgoy8ha8g3B2+32Riz4Z8ScklxSoqc/S7yuITE
   4d6AKMaHRWnHkMKb6kHoFklYnMgPHt4ZsXvEG6hpkxS6Ax/JW7cmTibVB
   g==;
X-CSE-ConnectionGUID: G917lpoHTfG9SJ/+yNQ6fg==
X-CSE-MsgGUID: u0uGcf9OTS+LGmnrY9ca2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19529244"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="19529244"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 02:33:38 -0700
X-CSE-ConnectionGUID: qDdLuTCaQ/iJkG+SFZJSrA==
X-CSE-MsgGUID: A2YnpKPSSuaRUJmdDI7L4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="22795965"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 02:33:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxO95-00000000HiX-38KV;
	Thu, 18 Apr 2024 12:33:31 +0300
Date: Thu, 18 Apr 2024 12:33:31 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Aubin Constans <aubin.constans@microchip.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v1 4/5] mmc: atmel-mci: Incapsulate used to be a platform
 data into host structure
Message-ID: <ZiDo618dp5EWnwPc@smile.fi.intel.com>
References: <20240417165708.2965612-5-andriy.shevchenko@linux.intel.com>
 <202404180428.bZDYDFAE-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404180428.bZDYDFAE-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 18, 2024 at 04:42:07AM +0800, kernel test robot wrote:
> Hi Andy,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on soc/for-next]
> [also build test WARNING on linus/master v6.9-rc4 next-20240417]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/mmc-atmel-mci-Get-rid-of-platform-data-leftovers/20240418-005915
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
> patch link:    https://lore.kernel.org/r/20240417165708.2965612-5-andriy.shevchenko%40linux.intel.com
> patch subject: [PATCH v1 4/5] mmc: atmel-mci: Incapsulate used to be a platform data into host structure
> config: arm-defconfig (https://download.01.org/0day-ci/archive/20240418/202404180428.bZDYDFAE-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240418/202404180428.bZDYDFAE-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202404180428.bZDYDFAE-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/mmc/host/atmel-mci.c:378: warning: Function parameter or struct member 'pdata' not described in 'atmel_mci'

Indeed. I'll fix this in next version, but will wait for others to comment on
the real code and approach in general.

-- 
With Best Regards,
Andy Shevchenko



