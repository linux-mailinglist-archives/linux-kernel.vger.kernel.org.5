Return-Path: <linux-kernel+bounces-137982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D76AA89EAC9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F681C22007
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C123629CF7;
	Wed, 10 Apr 2024 06:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Idi/7YMc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D7126AFF;
	Wed, 10 Apr 2024 06:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730232; cv=none; b=ZTXonCsMg4AixBL9Ir8W6lreLUO4Y0A1Zb88IC69+U3XbUHFcS5Jen5Qe6pnw8oqWTMgZE5jDCDdHLGnow3l4UyRI7oOEbtW9bH0Di2wlX36SMhQBvbaujDKxEItwT2+SF0z8gSxlIo1ZOV2tN1HhB420YsxX0XWSYm+oK36vHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730232; c=relaxed/simple;
	bh=CrqbmIXc8hcwOYEXXRkcAJ1s6Ei9utAjsjiuOZBrYVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2AKNTvqKsIAFmolfXgY7Lw8bZyW74W2cvbkv+rfYLpMj7kK9s9S0aHM1+hOxK41FDWZlQK5EmEXV7xvAH5TVCdVKSunrAyBuDTWcz5FJZcf6EeyhwB6qUmq6gEnxPP7J64lKZtdCt6U5WVGPQFeMfH0UxVduxG4arLxgWT6iRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Idi/7YMc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712730230; x=1744266230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CrqbmIXc8hcwOYEXXRkcAJ1s6Ei9utAjsjiuOZBrYVk=;
  b=Idi/7YMc7UJfqKZ5iOQv2SLVHhwtmsvOb0H3JBKpRw12JLFuF1e8NaWs
   APXDzX5RUOs392l+amPq3I3HFjkaztEw/BclNjl7365UTI9xi4FEJ9w/1
   e0KCEbBEbj/nVbftQKMlhACRaFHAf6P5Vr2ae9b13lojvrOG6COuRjHv0
   2ZwsxsiwuvArqkNnN5dGMEtUDd5ZCxWCbYhBl1phJklVZ7qUEt3I5XMm6
   xG5CwCZJ0HrigaDknVfReaIwXLLLBlgspEA95A5URGluTpz135kxbVL0O
   iC4KZ+DiLmOfqtEdbqi1GJ4i6W477d4bnv0j/ZW4L6rWFmdWsac6JeoKB
   Q==;
X-CSE-ConnectionGUID: sOszONwUR3G/uhWOVuDjhg==
X-CSE-MsgGUID: s4rmwrdiQJirH0caH/q7iA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11864691"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11864691"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 23:23:50 -0700
X-CSE-ConnectionGUID: HDtH6VViTZiBlgivADDNxQ==
X-CSE-MsgGUID: f4IleIp6Qzu/2LKbUep5XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="24932405"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 09 Apr 2024 23:23:43 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruRMz-0006zq-2C;
	Wed, 10 Apr 2024 06:23:41 +0000
Date: Wed, 10 Apr 2024 14:23:05 +0800
From: kernel test robot <lkp@intel.com>
To: wefu@redhat.com, jszhang@kernel.org, guoren@kernel.org,
	conor@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, jic23@kernel.org,
	lars@metafoo.de, andriy.shevchenko@linux.intel.com,
	nuno.sa@analog.com, marcelo.schmitt@analog.com,
	bigunclemax@gmail.com, marius.cristea@microchip.com,
	fr0st61te@gmail.com, okan.sahin@analog.com,
	marcus.folkesson@gmail.com, schnelle@linux.ibm.com, lee@kernel.org,
	mike.looijmans@topic.nl
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Wei Fu <wefu@redhat.com>
Subject: Re: [PATCH 2/3] riscv: dts: thead: Add XuanTie TH1520 ADC device node
Message-ID: <202404101407.KnrqaGoC-lkp@intel.com>
References: <20240329200241.4122000-3-wefu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329200241.4122000-3-wefu@redhat.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on robh/for-next linus/master v6.9-rc3 next-20240409]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/wefu-redhat-com/drivers-iio-adc-Add-XuanTie-TH1520-ADC-driver/20240330-041029
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240329200241.4122000-3-wefu%40redhat.com
patch subject: [PATCH 2/3] riscv: dts: thead: Add XuanTie TH1520 ADC device node
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20240410/202404101407.KnrqaGoC-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 546dc2245ffc4cccd0b05b58b7a5955e355a3b27)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240410/202404101407.KnrqaGoC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404101407.KnrqaGoC-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ERROR: Input tree has errors, aborting (use -f to force output)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

