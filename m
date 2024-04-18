Return-Path: <linux-kernel+bounces-150678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 219A88AA2F0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A162A1F22E58
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8E11836CC;
	Thu, 18 Apr 2024 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZYxYOdF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932DD18133F;
	Thu, 18 Apr 2024 19:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713468980; cv=none; b=Y68W6hibdlskUKQdTAVH2/ni4cGPvHjSyAJCa/cjcFXhR6IrEiCK0I3YpFm+UTPnDXJ0YoT54S2S3sTO+giyBrNZxD8qEBDPzgCG77gfNHwa2DpyECR1i7jD7M/RVwDKSCL9YL8F8hkuJYVm74CBoQLK18iXbuJVrSxa9S4k5ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713468980; c=relaxed/simple;
	bh=ciSkl5jjmwVLGNqACw+Y9/FoiKB85ls6a6PyIFwTt5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clgzS70mBGRRwk5sgKJGeL/bD/ZG22MC/DEmPA1xvsY0YAZSz3JAeVzDWCD3mRu81KU1+hL0DwnOtb6IC9qS1J12jt04j+lVErWPrR5tFBTXN1ZxMqKcNCf5nxgAbUAoQjsIfEkd/g8p75PcfutZCryXFr9gdO6bCttZ0MvSc/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZYxYOdF; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713468978; x=1745004978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ciSkl5jjmwVLGNqACw+Y9/FoiKB85ls6a6PyIFwTt5s=;
  b=XZYxYOdFo6EyM9u6AP7w9Q/7ICOS3tGBWZUivjlOLmsRUB5RvrgcPIz8
   /tAPFAUeeYalcKkJDIkrFFjNZmUO0xaYwXvmXhbMiEW55l1+ESdSEkkYN
   ebsTmV0dcvtZdNYsiYYxHfDsUfOUm+tghUAv9Pw7QdroSjVUYt0GVVOX+
   sYzQz7WNV4vFLdImW/1Bdgse0Z0eTHmE5E1hTB+d/GCgcqMs3z9hyO7xU
   GzRV8Taz6h9tP0SDtxLRMZ2EjqNo0PIq9iuJeIBBdispdqXB2o4z5WN0w
   UeIDnjVcNqUgWs1FxOKEWCGZAHm2Q3VpaxD8EfqbDL+kq4alrDcbfRXM1
   g==;
X-CSE-ConnectionGUID: 0kjjTXhiQnGfjU+EzV1fdA==
X-CSE-MsgGUID: lMdC05ZERo6gDq8pyTkkFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="26556358"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="26556358"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 12:36:15 -0700
X-CSE-ConnectionGUID: PuNa+9+fT2miWmb6tlExpA==
X-CSE-MsgGUID: WnMTpszQTv6wTRC5wFCo6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23532035"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 18 Apr 2024 12:36:13 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxXYI-00099E-1L;
	Thu, 18 Apr 2024 19:36:10 +0000
Date: Fri, 19 Apr 2024 03:36:07 +0800
From: kernel test robot <lkp@intel.com>
To: Witold Sadowski <wsadowski@marvell.com>, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, broonie@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	pthombar@cadence.com, Witold Sadowski <wsadowski@marvell.com>
Subject: Re: [PATCH v3 3/5] spi: cadence: Add Marvell xSPI IP overlay changes
Message-ID: <202404190319.hTksJJAv-lkp@intel.com>
References: <20240418011353.1764672-4-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418011353.1764672-4-wsadowski@marvell.com>

Hi Witold,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.9-rc4]
[also build test WARNING on linus/master next-20240418]
[cannot apply to broonie-spi/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Witold-Sadowski/spi-cadence-Ensure-data-lines-set-to-low-during-dummy-cycle-period/20240418-091647
base:   v6.9-rc4
patch link:    https://lore.kernel.org/r/20240418011353.1764672-4-wsadowski%40marvell.com
patch subject: [PATCH v3 3/5] spi: cadence: Add Marvell xSPI IP overlay changes
config: x86_64-randconfig-122-20240419 (https://download.01.org/0day-ci/archive/20240419/202404190319.hTksJJAv-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240419/202404190319.hTksJJAv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404190319.hTksJJAv-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/spi/spi-cadence-xspi.c:288:11: sparse: sparse: symbol 'cdns_mrvl_xspi_clk_div_list' was not declared. Should it be static?

vim +/cdns_mrvl_xspi_clk_div_list +288 drivers/spi/spi-cadence-xspi.c

   287	
 > 288	const int cdns_mrvl_xspi_clk_div_list[] = {
   289		4,	//0x0 = Divide by 4.   SPI clock is 200 MHz.
   290		6,	//0x1 = Divide by 6.   SPI clock is 133.33 MHz.
   291		8,	//0x2 = Divide by 8.   SPI clock is 100 MHz.
   292		10,	//0x3 = Divide by 10.  SPI clock is 80 MHz.
   293		12,	//0x4 = Divide by 12.  SPI clock is 66.666 MHz.
   294		16,	//0x5 = Divide by 16.  SPI clock is 50 MHz.
   295		18,	//0x6 = Divide by 18.  SPI clock is 44.44 MHz.
   296		20,	//0x7 = Divide by 20.  SPI clock is 40 MHz.
   297		24,	//0x8 = Divide by 24.  SPI clock is 33.33 MHz.
   298		32,	//0x9 = Divide by 32.  SPI clock is 25 MHz.
   299		40,	//0xA = Divide by 40.  SPI clock is 20 MHz.
   300		50,	//0xB = Divide by 50.  SPI clock is 16 MHz.
   301		64,	//0xC = Divide by 64.  SPI clock is 12.5 MHz.
   302		128,	//0xD = Divide by 128. SPI clock is 6.25 MHz.
   303		-1	//End of list
   304	};
   305	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

