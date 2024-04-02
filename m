Return-Path: <linux-kernel+bounces-127679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8314C894F5F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228101F21DAA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F30559179;
	Tue,  2 Apr 2024 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nm9dbyEZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3632458AAF;
	Tue,  2 Apr 2024 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052013; cv=none; b=qVoZF+BPo+1QEfapeYVQjbJzOIqL3hx8Pq06DBoMCvUASfa3XWfAkYJyl2MVtewTKGYadZUcdScM0fs9mohgX2Oh5O8GBC7yiJsZfZwZCtCZXrellJPoPDcZqgxrwZjj7UJmgZjuyUb7cUBCpg+wmYdStopMaJBWQLsvInCxtA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052013; c=relaxed/simple;
	bh=b0OIGFVB57rC+vRSHDqJps7mkAfSLfUHZGQ9SaT07mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fChF7BmW4PcamM6MoII/nA4k8Lt4k8kFJK3gzKT68hn/MYBuTtRWbfHZdZSyythq2FBa17DZ3JbXHbCQtJrOGG0L52yQ4aidls6C2dLczUlKvXR6wHiBfFEjNh4PfYveDEY2j1jeBIxKdPF5poAaRC1z3EaOstTq/4BKNVhgDWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nm9dbyEZ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712052012; x=1743588012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b0OIGFVB57rC+vRSHDqJps7mkAfSLfUHZGQ9SaT07mI=;
  b=nm9dbyEZrMWGF8wScXVauCOzgRTiHWn0Mh0X5GT5NcCuzYhg5bftSPE5
   N4FqD5K0OV/X9OEOPL9CVkF7GA91iK7CwaqvRwfZC0fN8E2mYW6TkLIiV
   rYUEZfxhz2mHtolEoQt8+p8S0NTyWxh+0bUIvuV7FK6CW7uPltHUS13QM
   5gkonLDZqukwbFHA0hKQYoa5Vv5LpH+chRBJ+wlw8SbNjKl9Ao7t98Qn2
   9cPa/kfkDviF435amhbDq5onQZGT80r3Ee2dVwR4w71rv0DS2rz1TZqhY
   /mWTSOwUMEvmq2E3omucudgJqp9bEWfCgEk2TBcWRXnnZPzXFHsiLfQKX
   Q==;
X-CSE-ConnectionGUID: iTcCij00TVOyWnrtfI6Png==
X-CSE-MsgGUID: Shdkxse8Q9C5PoQGFeDSrw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="24705416"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="24705416"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:00:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="18069109"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 02 Apr 2024 03:00:00 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rravu-000165-0S;
	Tue, 02 Apr 2024 09:59:58 +0000
Date: Tue, 2 Apr 2024 17:59:43 +0800
From: kernel test robot <lkp@intel.com>
To: Ajit Pandey <quic_ajipan@quicinc.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	Taniya Das <quic_tdas@quicinc.com>,
	Jagadeesh Kona <quic_jkona@quicinc.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
	Ajit Pandey <quic_ajipan@quicinc.com>
Subject: Re: [PATCH 7/7] clk: qcom: Add GPUCC driver support for SM4450
Message-ID: <202404021747.ie04rWAv-lkp@intel.com>
References: <20240330182817.3272224-8-quic_ajipan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240330182817.3272224-8-quic_ajipan@quicinc.com>

Hi Ajit,

kernel test robot noticed the following build warnings:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on robh/for-next linus/master v6.9-rc2 next-20240402]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ajit-Pandey/clk-qcom-clk-alpha-pll-Fix-CAL_L_VAL-override-for-LUCID-EVO-PLL/20240331-023329
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20240330182817.3272224-8-quic_ajipan%40quicinc.com
patch subject: [PATCH 7/7] clk: qcom: Add GPUCC driver support for SM4450
config: powerpc64-randconfig-r132-20240402 (https://download.01.org/0day-ci/archive/20240402/202404021747.ie04rWAv-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 546dc2245ffc4cccd0b05b58b7a5955e355a3b27)
reproduce: (https://download.01.org/0day-ci/archive/20240402/202404021747.ie04rWAv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404021747.ie04rWAv-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/clk/qcom/gpucc-sm4450.c:740:10: sparse: sparse: Initializer entry defined twice
   drivers/clk/qcom/gpucc-sm4450.c:746:10: sparse:   also defined here

vim +740 drivers/clk/qcom/gpucc-sm4450.c

   736	
   737	static const struct qcom_reset_map gpu_cc_sm4450_resets[] = {
   738		[GPU_CC_CB_BCR] = { 0x93a0 },
   739		[GPU_CC_CX_BCR] = { 0x9104 },
 > 740		[GPU_CC_GX_BCR] = { 0x9058 },
   741		[GPU_CC_FAST_HUB_BCR] = { 0x93e4 },
   742		[GPU_CC_ACD_BCR] = { 0x9358 },
   743		[GPU_CC_FF_BCR] = { 0x9470 },
   744		[GPU_CC_GFX3D_AON_BCR] = { 0x9198 },
   745		[GPU_CC_GMU_BCR] = { 0x9314 },
   746		[GPU_CC_GX_BCR] = { 0x9058 },
   747		[GPU_CC_RBCPR_BCR] = { 0x91e0 },
   748		[GPU_CC_XO_BCR] = { 0x9000 },
   749		[GPU_CC_GX_ACD_IROOT_BCR] = { 0x958c },
   750	};
   751	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

