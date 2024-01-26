Return-Path: <linux-kernel+bounces-40802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7FF83E638
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781D3286C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4352455E57;
	Fri, 26 Jan 2024 23:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K2wz7WX2"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A911156756;
	Fri, 26 Jan 2024 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310464; cv=none; b=LWJZEbvSZF1eGZ6pGPrzTXM5WtB1ynEwoM8DYUA3g6hjn2cEVtXAFwQZjxjziNU/D6ReN/x99yNlG92Ff81vgPsuaDisQiyfV1F67EJj/dZknqiRmBQ2pNeZ7Zsb+MGh3UW3QgVBhAUhbvOPM/PvFhnEEyR4U9y3F1NlrJTPr1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310464; c=relaxed/simple;
	bh=CCBlNiRHutaSOIy4eCuqmtmhS4a3fOQYcAmNjzl5BgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hl9Rg7v6YINaPvTTaLHVkvJU9PDokWj12wbjALT25ZBhO9ZJbYY+j73DIUFTEPgWeladA4x+mhXZIFM0w8xtjGNHTVzVRyIdJSUcXaePsRRXcOYKnXe8XFrSdN2A4bx5RBzokS4j07CGfmA1yrlVbou14ebj46+BwOiZRHQPMtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K2wz7WX2; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706310462; x=1737846462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CCBlNiRHutaSOIy4eCuqmtmhS4a3fOQYcAmNjzl5BgY=;
  b=K2wz7WX2a69IRzJFOaANDD2mv0IPNXiEyg2n+uDOeK3mtCMV53dkW3yy
   D63VgC5WlCxkHIsvz7rq/GLGru9ZSomi2RJExK8oAT3ERZUYGw34zGxYp
   UPpKS6KGxbLDBkYJzNZWbOJfpLdDpDcNlXAtO31eGr7GQJWb//d1MunCB
   qlt7G6aPNUYn71DT9udD2Ya5uLGZ3YbbHQYkK+Wd9f2xbw29dIvpxKqaR
   NrbMYB/GE+kWmrWypA644mGAiQfXlM9vp1ms5RcSp5UwoV8cFqJ8OrPoP
   9b9dPm2h7quHt70BNkNtTHvYM8PQ75DVC27CUl96W6JHdKU7+qzWXAOg0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="399760656"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="399760656"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 15:07:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="930501808"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="930501808"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jan 2024 15:07:36 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTVIM-0001R4-1N;
	Fri, 26 Jan 2024 23:07:34 +0000
Date: Sat, 27 Jan 2024 07:07:23 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Griffin <peter.griffin@linaro.org>, arnd@arndb.de,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	linux@roeck-us.net, wim@linux-watchdog.org, conor+dt@kernel.org,
	alim.akhtar@samsung.com, jaewon02.kim@samsung.com,
	chanho61.park@samsung.com, semen.protsenko@linaro.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kernel-team@android.com, peter.griffin@linaro.org,
	tudor.ambarus@linaro.org, andre.draszik@linaro.org,
	saravanak@google.com, willmcvicker@google.com, linux-fsd@tesla.com,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 2/9] soc: samsung: exynos-pmu: Add
 exynos_pmu_update/read/write APIs and SoC quirks
Message-ID: <202401270633.VorEna6q-lkp@intel.com>
References: <20240122225710.1952066-3-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122225710.1952066-3-peter.griffin@linaro.org>

Hi Peter,

kernel test robot noticed the following build errors:

[auto build test ERROR on krzk/for-next]
[also build test ERROR on robh/for-next soc/for-next linus/master v6.8-rc1 next-20240125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Griffin/dt-bindings-watchdog-samsung-wdt-deprecate-samsung-syscon-phandle/20240123-070052
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git for-next
patch link:    https://lore.kernel.org/r/20240122225710.1952066-3-peter.griffin%40linaro.org
patch subject: [PATCH 2/9] soc: samsung: exynos-pmu: Add exynos_pmu_update/read/write APIs and SoC quirks
config: x86_64-buildonly-randconfig-006-20240126 (https://download.01.org/0day-ci/archive/20240127/202401270633.VorEna6q-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240127/202401270633.VorEna6q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401270633.VorEna6q-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pinctrl/samsung/pinctrl-exynos.c:27:
>> include/linux/soc/samsung/exynos-pmu.h:38:1: error: expected identifier or '('
      38 | {
         | ^
   include/linux/soc/samsung/exynos-pmu.h:44:1: error: expected identifier or '('
      44 | {
         | ^
>> include/linux/soc/samsung/exynos-pmu.h:50:9: error: incompatible pointer to integer conversion returning 'void *' from a function with result type 'int' [-Wint-conversion]
      50 |         return ERR_PTR(-ENODEV);
         |                ^~~~~~~~~~~~~~~~
   include/linux/soc/samsung/exynos-pmu.h:55:9: error: incompatible pointer to integer conversion returning 'void *' from a function with result type 'int' [-Wint-conversion]
      55 |         return ERR_PTR(-ENODEV);
         |                ^~~~~~~~~~~~~~~~
   4 errors generated.


vim +38 include/linux/soc/samsung/exynos-pmu.h

    35	
    36	static inline int exynos_pmu_update_bits(unsigned int offset, unsigned int mask,
    37						 unsigned int val);
  > 38	{
    39		return ERR_PTR(-ENODEV);
    40	}
    41	
    42	static inline int exynos_pmu_update(unsigned int offset, unsigned int mask,
    43					    unsigned int val);
    44	{
    45		return ERR_PTR(-ENODEV);
    46	}
    47	
    48	static inline int exynos_pmu_write(unsigned int offset, unsigned int val)
    49	{
  > 50		return ERR_PTR(-ENODEV);
    51	}
    52	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

