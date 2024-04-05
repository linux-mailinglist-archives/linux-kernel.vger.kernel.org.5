Return-Path: <linux-kernel+bounces-133683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C49F189A751
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B2F1F25038
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5B728DC9;
	Fri,  5 Apr 2024 22:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PuX9Pyki"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3301F60A;
	Fri,  5 Apr 2024 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712356332; cv=none; b=SIQg7wDHr3dz6zNfkN8RPcUvLexX03Chgw+x1gBR1sf+Ly+Zaa4ec1eMU5i6ksmeRGY4+0u4RXcFr9VbQveAH0BSvS3zApAu0QKPBbm3zNXnJDUWkRcYNRNO+G1k2MULZfRToVfKp04Kar/j8gf7PsJqTEIqTFSWPFbEQHboViI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712356332; c=relaxed/simple;
	bh=iacJbwqVzLZ+QPu0PsxC62e+0CS6vwkuBBz/tOH/PtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hv+z/LCVMXr4BneAKbBfuopJmpClOphIN4QPy1N3USkFtTOc6AdWeq3EQN2rX8iOEjm80k67Jbr0MzaTYkWIh/DV0bmSALL0/S5S2BtdJ7+x1VCwLZXs2Dw1mwAQDOc1HcppZwmV/ZXpGKBL+TDtdGFN+96ZUgZGqwjzVtCPnhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PuX9Pyki; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712356331; x=1743892331;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iacJbwqVzLZ+QPu0PsxC62e+0CS6vwkuBBz/tOH/PtA=;
  b=PuX9Pykiem0nWHWHDcw00oYe3CRcSWZLuUnb4hUkT0VXTtkRabc+7wqx
   lE0I989jvN2aBS5PdSwA/Z+dAmDgajJO9f8SC6BnLlK3e777Gz+TSUcag
   Zw7yzxgXT/lt9zGEmcHqlCkXbvshEf1rw46ZOERZNbQKtVASC80tgECWa
   fuZ0Jc/G2gPpPGoU9Gi2Z9sfZ5y+cYcAF+qbqZp4Yl3Bo5yaPbsD354Th
   hJUBHi9rlZyjKJJYwkXCjSdPTYso74wJPY15NITNVMWh1zmS8Wf0XzXVj
   N/khTa80EIazPRVv1mWLiMe3W5o0PQaSIns1eTSaXtPKwN3ZORflrYhNc
   g==;
X-CSE-ConnectionGUID: BAoXTa8sTaies97WQL68fA==
X-CSE-MsgGUID: o+y3ZLyhQ2aj4py/DK2dNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18437354"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="18437354"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 15:32:10 -0700
X-CSE-ConnectionGUID: HJwq05CxRKyOrruQhDcgjQ==
X-CSE-MsgGUID: qJXN4bJnRcOu1ZawYBRsfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19739547"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 05 Apr 2024 15:32:05 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rss6M-0002mu-2A;
	Fri, 05 Apr 2024 22:32:02 +0000
Date: Sat, 6 Apr 2024 06:31:21 +0800
From: kernel test robot <lkp@intel.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 2/6] soc: qcom: smem: Add pcode/fcode getters
Message-ID: <202404060648.DOjOYUSf-lkp@intel.com>
References: <20240405-topic-smem_speedbin-v1-2-ce2b864251b1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405-topic-smem_speedbin-v1-2-ce2b864251b1@linaro.org>

Hi Konrad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2b3d5988ae2cb5cd945ddbc653f0a71706231fdd]

url:    https://github.com/intel-lab-lkp/linux/commits/Konrad-Dybcio/soc-qcom-Move-some-socinfo-defines-to-the-header-expand-them/20240405-164231
base:   2b3d5988ae2cb5cd945ddbc653f0a71706231fdd
patch link:    https://lore.kernel.org/r/20240405-topic-smem_speedbin-v1-2-ce2b864251b1%40linaro.org
patch subject: [PATCH 2/6] soc: qcom: smem: Add pcode/fcode getters
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240406/202404060648.DOjOYUSf-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240406/202404060648.DOjOYUSf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404060648.DOjOYUSf-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/soc/qcom/smem.c:807: warning: Function parameter or struct member 'code' not described in 'qcom_smem_get_feature_code'
>> drivers/soc/qcom/smem.c:807: warning: Excess function parameter 'id' description in 'qcom_smem_get_feature_code'
>> drivers/soc/qcom/smem.c:840: warning: Function parameter or struct member 'code' not described in 'qcom_smem_get_product_code'
>> drivers/soc/qcom/smem.c:840: warning: Excess function parameter 'id' description in 'qcom_smem_get_product_code'


vim +807 drivers/soc/qcom/smem.c

   797	
   798	/**
   799	 * qcom_smem_get_feature_code() - return the feature code
   800	 * @id:	On success, we return the feature code here.
   801	 *
   802	 * Look up the feature code identifier from SMEM and return it.
   803	 *
   804	 * Return: 0 on success, negative errno on failure.
   805	 */
   806	int qcom_smem_get_feature_code(u32 *code)
 > 807	{
   808		struct socinfo *info;
   809		u32 raw_code;
   810	
   811		info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, NULL);
   812		if (IS_ERR(info))
   813			return PTR_ERR(info);
   814	
   815		/* This only makes sense for socinfo >= 16 */
   816		if (__le32_to_cpu(info->fmt) < SOCINFO_VERSION(0, 16))
   817			return -EINVAL;
   818	
   819		raw_code = __le32_to_cpu(info->feature_code);
   820	
   821		/* Ensure the value makes sense */
   822		if (raw_code >= SOCINFO_FC_INT_RESERVE)
   823			raw_code = SOCINFO_FC_UNKNOWN;
   824	
   825		*code = raw_code;
   826	
   827		return 0;
   828	}
   829	EXPORT_SYMBOL_GPL(qcom_smem_get_feature_code);
   830	
   831	/**
   832	 * qcom_smem_get_product_code() - return the product code
   833	 * @id:	On success, we return the product code here.
   834	 *
   835	 * Look up feature code identifier from SMEM and return it.
   836	 *
   837	 * Return: 0 on success, negative errno on failure.
   838	 */
   839	int qcom_smem_get_product_code(u32 *code)
 > 840	{
   841		struct socinfo *info;
   842		u32 raw_code;
   843	
   844		info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, NULL);
   845		if (IS_ERR(info))
   846			return PTR_ERR(info);
   847	
   848		/* This only makes sense for socinfo >= 16 */
   849		if (__le32_to_cpu(info->fmt) < SOCINFO_VERSION(0, 16))
   850			return -EINVAL;
   851	
   852		raw_code = __le32_to_cpu(info->pcode);
   853	
   854		/* Ensure the value makes sense */
   855		if (raw_code >= SOCINFO_FC_INT_RESERVE)
   856			raw_code = SOCINFO_FC_UNKNOWN;
   857	
   858		*code = raw_code;
   859	
   860		return 0;
   861	}
   862	EXPORT_SYMBOL_GPL(qcom_smem_get_product_code);
   863	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

