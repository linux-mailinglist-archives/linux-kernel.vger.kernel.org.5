Return-Path: <linux-kernel+bounces-148000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE86D8A7C69
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1AB2853F3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168F6657DC;
	Wed, 17 Apr 2024 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CkYWw4Ai"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2C57339
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 06:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335957; cv=none; b=JxGTlbML9OLTks/rhN2y4KloW7FDZ7r//zTihr3lfgk8XCzTgkSFnnSLo+X8YAER0tjRL6vOklgIpRIq3OkwiVRXLyhxsUq1cKbgSkhkoRJ3KP2UDuONw9tm4xDj18NVsHVxGELB/CPXh7y1jcz3SavPDYNrO+f+FMfSGtM2BzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335957; c=relaxed/simple;
	bh=hGvxjhXuCepgErMdOPNHJvrFLROK88okJam3kP1Idgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1sfusUX9q9ZwGyTgzKGwEbqG9J3rOzXinV0JDROwfEknH7Zchaz97V/lnkF6ZWzaYKch0dgvdF64bVqmJwtFdky1o+2Xh7ZLrLDyMt5EdZ4sVyF+TsH1+80icUYgtyXwYLumfcSvLK1owHio74jyP4TjD3DDPcZj7qMIWQHCio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CkYWw4Ai; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713335956; x=1744871956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hGvxjhXuCepgErMdOPNHJvrFLROK88okJam3kP1Idgo=;
  b=CkYWw4Ai6GgmlDqKAtUe7IO3uQIeOqIAk+IgdgCr+Yn0u3g0vs9/nlX0
   aylBlMXHSPlnLjoOO3VKNtk8A8uel13kogZSwcMFM27j1PnK+x/nyTfJT
   U95nKS2DVXLiFEA6VQ9psfL+9tLdzNB4U01bQ6iEmQQWOyUXEdKw86OYb
   QZSe+mP3mfoQgWXoGZJm2iBcJjUAdxIqIPHxt+8/q1/se05b191SvQi99
   S6bUt5MvdoOLrcRV3YubbYlRMep/s6xVzolsTeq0VE+Pkfh3Pn4HjB9AB
   uuM8bQr+T8OyEakWamr8WywmHF/CSTOwn/+z7Jn8dkz8YfVQAcoAiHXya
   g==;
X-CSE-ConnectionGUID: 9JZOCscmSJ2cCSpHVXSXug==
X-CSE-MsgGUID: 5HPhyfW8TzqZZqWnH4RdTA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8737654"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="8737654"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 23:39:15 -0700
X-CSE-ConnectionGUID: aggS6JuPTMKWL1HfIJx5Zg==
X-CSE-MsgGUID: C7L5QiKTSOyN6vUAJOjwGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="22575350"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 16 Apr 2024 23:39:11 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwywk-0006E7-1h;
	Wed, 17 Apr 2024 06:39:07 +0000
Date: Wed, 17 Apr 2024 14:37:51 +0800
From: kernel test robot <lkp@intel.com>
To: Maxwell Bland <mbland@motorola.com>,
	linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Maxwell Bland <mbland@motorola.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	David Hildenbrand <david@redhat.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5 RESEND] arm64: dynamic enforcement of PXNTable
Message-ID: <202404171444.fqXW3YmG-lkp@intel.com>
References: <20240416122254.868007168-5-mbland@motorola.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416122254.868007168-5-mbland@motorola.com>

Hi Maxwell,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0bbac3facb5d6cc0171c45c9873a2dc96bea9680]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxwell-Bland/mm-allow-arch-refinement-skip-for-vmap-alloc/20240417-032149
base:   0bbac3facb5d6cc0171c45c9873a2dc96bea9680
patch link:    https://lore.kernel.org/r/20240416122254.868007168-5-mbland%40motorola.com
patch subject: [PATCH 4/5 RESEND] arm64: dynamic enforcement of PXNTable
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20240417/202404171444.fqXW3YmG-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240417/202404171444.fqXW3YmG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404171444.fqXW3YmG-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: arch/arm64/kernel/setup.o: in function `setup_arch':
   setup.c:(.init.text+0x694): undefined reference to `module_init_limits'
   aarch64-linux-ld: mm/memory.o: in function `__pte_alloc_kernel':
>> memory.c:(.text+0x2b64): undefined reference to `module_plt_base'
   aarch64-linux-ld: mm/memory.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `module_plt_base' which may bind externally can not be used when making a shared object; recompile with -fPIC
   memory.c:(.text+0x2b64): dangerous relocation: unsupported relocation
>> aarch64-linux-ld: memory.c:(.text+0x2b6c): undefined reference to `module_plt_base'
>> aarch64-linux-ld: memory.c:(.text+0x2b74): undefined reference to `module_direct_base'
   aarch64-linux-ld: mm/memory.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `module_direct_base' which may bind externally can not be used when making a shared object; recompile with -fPIC
   memory.c:(.text+0x2b74): dangerous relocation: unsupported relocation
   aarch64-linux-ld: memory.c:(.text+0x2b78): undefined reference to `module_direct_base'
   aarch64-linux-ld: mm/sparse-vmemmap.o: in function `vmemmap_pmd_populate':
>> sparse-vmemmap.c:(.meminit.text+0x450): undefined reference to `module_plt_base'
   aarch64-linux-ld: mm/sparse-vmemmap.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `module_plt_base' which may bind externally can not be used when making a shared object; recompile with -fPIC
   sparse-vmemmap.c:(.meminit.text+0x450): dangerous relocation: unsupported relocation
>> aarch64-linux-ld: sparse-vmemmap.c:(.meminit.text+0x458): undefined reference to `module_plt_base'
>> aarch64-linux-ld: sparse-vmemmap.c:(.meminit.text+0x460): undefined reference to `module_direct_base'
   aarch64-linux-ld: mm/sparse-vmemmap.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `module_direct_base' which may bind externally can not be used when making a shared object; recompile with -fPIC
   sparse-vmemmap.c:(.meminit.text+0x460): dangerous relocation: unsupported relocation
   aarch64-linux-ld: sparse-vmemmap.c:(.meminit.text+0x464): undefined reference to `module_direct_base'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

