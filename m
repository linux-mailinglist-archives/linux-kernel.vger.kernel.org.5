Return-Path: <linux-kernel+bounces-50286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 254D78476FB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CEDC1F26B7E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C241B14D438;
	Fri,  2 Feb 2024 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nw+0bw6t"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD90E1474C5;
	Fri,  2 Feb 2024 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896957; cv=none; b=AEUGnTI84J1Dv4gfcWhwT2QMccCf/Ke3Hm7GrmBhVy6FshDyiLn9aELtOJGiPj83Po9z1pbawaUgV6sZY/3hxr2zEVV5RLE9sbg/+pRbY3nSnnlkQtwkuCBtBQJD8ch4errVnyw0dkieW0X9rDofJ8W6iOgQ0A+F0vFK3/9VKo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896957; c=relaxed/simple;
	bh=AObZK8lt0kI8yyuwv9Pg9H4m9ru+FQwHPMzYJIqRXqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+XCJdD6yqgrgJ8MAjNgReZn4UVIngidlmz6GwrpF7M+Fa1G80eiSZS1306g1NRa2Htwl5wy3sJ6Ce5bJOT+OkOLNTNbjhM3YB7bxxsf9ovhHDWx89pWPxiwgo1hzY0941cvV/oro1I4yV8NH0sxeqr9kHw9LD9yVatIkm+/I7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nw+0bw6t; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706896955; x=1738432955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AObZK8lt0kI8yyuwv9Pg9H4m9ru+FQwHPMzYJIqRXqk=;
  b=nw+0bw6tgqqQ3FEpkmwBt7Bm8TC0of0iNxxnT5Ecf99jGe1y4UL3gcp0
   iXeHhoW528XOBpvBAKpvfO8eEHn2tol3P6jwOW7ZRVZcHojlSut1xGuUM
   37fpTLp1NNZ97JosC/rnApLTpItzMIaOWTKahhnhRV+05YBff94SzqU8C
   7sYnUm/QO1WHikQiLvXwq6awdIOceVe4YMFpbbfmXQyI9PiEmmH7GrR7O
   Pw7Uo4t17JVG3TJ3iKG1h3h2bz7+ug5XbEOxn+Zr+4CX1X6IrJBF21GuI
   p7/OBK9by8CP+QUT6PpOnNh/IGIxoqmwRPZRERf1jWh1Tx3Bew5lVytz4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="434424"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="434424"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 10:02:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="23410586"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 02 Feb 2024 10:02:29 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVxru-00048M-2Q;
	Fri, 02 Feb 2024 18:02:26 +0000
Date: Sat, 3 Feb 2024 02:02:15 +0800
From: kernel test robot <lkp@intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Guru Das Srinagesh <quic_gurus@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Deepti Jaggi <quic_djaggi@quicinc.com>
Subject: Re: [RESEND PATCH v6 02/12] firmware: qcom: scm: enable the TZ mem
 allocator
Message-ID: <202402030101.nxmgLcAB-lkp@intel.com>
References: <20240122102157.22761-3-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122102157.22761-3-brgl@bgdev.pl>

Hi Bartosz,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on krzk-dt/for-next v6.8-rc2 next-20240202]
[cannot apply to arm64/for-next/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/firmware-qcom-add-a-dedicated-TrustZone-buffer-allocator/20240122-182633
base:   linus/master
patch link:    https://lore.kernel.org/r/20240122102157.22761-3-brgl%40bgdev.pl
patch subject: [RESEND PATCH v6 02/12] firmware: qcom: scm: enable the TZ mem allocator
config: i386-buildonly-randconfig-004-20240202 (https://download.01.org/0day-ci/archive/20240203/202402030101.nxmgLcAB-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240203/202402030101.nxmgLcAB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402030101.nxmgLcAB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: gen_pool_create
   >>> referenced by qcom_tzmem.c
   >>>               drivers/firmware/qcom/qcom_tzmem.o:(qcom_tzmem_pool_new) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: gen_pool_best_fit
   >>> referenced by qcom_tzmem.c
   >>>               drivers/firmware/qcom/qcom_tzmem.o:(qcom_tzmem_pool_new) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: gen_pool_set_algo
   >>> referenced by qcom_tzmem.c
   >>>               drivers/firmware/qcom/qcom_tzmem.o:(qcom_tzmem_pool_new) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: gen_pool_add_owner
   >>> referenced by qcom_tzmem.c
   >>>               drivers/firmware/qcom/qcom_tzmem.o:(qcom_tzmem_pool_new) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: gen_pool_destroy
   >>> referenced by qcom_tzmem.c
   >>>               drivers/firmware/qcom/qcom_tzmem.o:(qcom_tzmem_pool_new) in archive vmlinux.a
   >>> referenced by qcom_tzmem.c
   >>>               drivers/firmware/qcom/qcom_tzmem.o:(qcom_tzmem_pool_free) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: gen_pool_alloc_algo_owner
   >>> referenced by qcom_tzmem.c
   >>>               drivers/firmware/qcom/qcom_tzmem.o:(qcom_tzmem_alloc) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: gen_pool_virt_to_phys
   >>> referenced by qcom_tzmem.c
   >>>               drivers/firmware/qcom/qcom_tzmem.o:(qcom_tzmem_alloc) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: gen_pool_free_owner
   >>> referenced by qcom_tzmem.c
   >>>               drivers/firmware/qcom/qcom_tzmem.o:(qcom_tzmem_alloc) in archive vmlinux.a
   >>> referenced by qcom_tzmem.c
   >>>               drivers/firmware/qcom/qcom_tzmem.o:(qcom_tzmem_free) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

