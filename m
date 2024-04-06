Return-Path: <linux-kernel+bounces-133891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 868D389AA63
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 12:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D111C20FA2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 10:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F9E2B9D5;
	Sat,  6 Apr 2024 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m3POpngX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EB410A1A;
	Sat,  6 Apr 2024 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712400217; cv=none; b=jbHZbkz84NQQhk1kEGT5N1ranzlmmfziPEmVzO37mAsOPE0n7DhL/5Ha1reTo7dpJ1zR0HrNRs+d7kMce47tAJUP2N9PGojSojd9wUj8ZFSTmHO3c/eos72bUwQAmnneslimy9zeQIkvpNkQ1kx7VpFgLpdlC+8cwU8FJv3Zmag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712400217; c=relaxed/simple;
	bh=Tm6UWiTLvuOtjlROTNsk00qGzT5cJ18ladKJb9+pq98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uibg7LGDfhNAVYyi4jc/bD/b3qrHCaVHrmqWNemI8O16Dem+H2L5tON4xiaTr9tuA5/nvSTK4UOTjFj5GWN8GiaGTMYAs9Brnzw0readsWxVJxa5fcKtFFB2VVlCl3l8683u3NV1O0DFmVlxw4V9qbMktRaMJxiGbN2/UNNbMhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m3POpngX; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712400216; x=1743936216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tm6UWiTLvuOtjlROTNsk00qGzT5cJ18ladKJb9+pq98=;
  b=m3POpngXbZTNm+06/6vRyjKB0oiWslDGTjS5vm+QiqGKTv7ISOzuNnEa
   7cwITpI5EMXOFnk+Np9hXglMt7V8DrznEQjDgLcJZQgXV5jILyAI70CvH
   fVyeyCyKke7zza3wLWiiNXwAEHDGeqmj5ye3EgjYhHub3BpW692FXtE7z
   E3+MiAfJtL7dKFUZMFDMmr5j9Mh0Za/KGS/pCzigIpU/7TaIrxYl9KgEm
   kOBrbSrw44c+bj9H/SLcQ+rhLtRxSXe40WytKLvgkwaP56Ml9lvl6FBg4
   vX4TE8Bm3ahpVdvhKf/m1lrot9KKHjTO/FbZv/gkm2ky23rirsZ3hHlah
   w==;
X-CSE-ConnectionGUID: v16h7/QpSaWL38lyANZtVg==
X-CSE-MsgGUID: VgLfeNasTSmH9bobBPZKOg==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7587519"
X-IronPort-AV: E=Sophos;i="6.07,183,1708416000"; 
   d="scan'208";a="7587519"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 03:43:35 -0700
X-CSE-ConnectionGUID: W9ti95udRzCOBx4nQii9Ow==
X-CSE-MsgGUID: aGMwCivbQ5iG+39nOsS2Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,183,1708416000"; 
   d="scan'208";a="24133297"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 06 Apr 2024 03:43:30 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rt3WC-0003OG-0n;
	Sat, 06 Apr 2024 10:43:28 +0000
Date: Sat, 6 Apr 2024 18:42:56 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 4/6] drm/msm/adreno: Implement SMEM-based speed bin
Message-ID: <202404061841.njUovDV7-lkp@intel.com>
References: <20240405-topic-smem_speedbin-v1-4-ce2b864251b1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405-topic-smem_speedbin-v1-4-ce2b864251b1@linaro.org>

Hi Konrad,

kernel test robot noticed the following build errors:

[auto build test ERROR on 2b3d5988ae2cb5cd945ddbc653f0a71706231fdd]

url:    https://github.com/intel-lab-lkp/linux/commits/Konrad-Dybcio/soc-qcom-Move-some-socinfo-defines-to-the-header-expand-them/20240405-164231
base:   2b3d5988ae2cb5cd945ddbc653f0a71706231fdd
patch link:    https://lore.kernel.org/r/20240405-topic-smem_speedbin-v1-4-ce2b864251b1%40linaro.org
patch subject: [PATCH 4/6] drm/msm/adreno: Implement SMEM-based speed bin
config: i386-buildonly-randconfig-003-20240406 (https://download.01.org/0day-ci/archive/20240406/202404061841.njUovDV7-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240406/202404061841.njUovDV7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404061841.njUovDV7-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/msm/adreno/adreno_gpu.c: In function 'adreno_read_speedbin':
>> drivers/gpu/drm/msm/adreno/adreno_gpu.c:1090:14: error: implicit declaration of function 'FIELD_PREP'; did you mean 'NEED_PGE'? [-Werror=implicit-function-declaration]
     *speedbin = FIELD_PREP(ADRENO_SKU_ID_PCODE, pcode) |
                 ^~~~~~~~~~
                 NEED_PGE
   cc1: some warnings being treated as errors


vim +1090 drivers/gpu/drm/msm/adreno/adreno_gpu.c

  1062	
  1063	int adreno_read_speedbin(struct adreno_gpu *adreno_gpu,
  1064				 struct device *dev, u32 *speedbin)
  1065	{
  1066		u32 fcode, pcode;
  1067		int ret;
  1068	
  1069		/* Try reading the speedbin via a nvmem cell first */
  1070		ret = nvmem_cell_read_variable_le_u32(dev, "speed_bin", speedbin);
  1071		if (!ret && ret != -EINVAL)
  1072			return ret;
  1073	
  1074		ret = qcom_smem_get_feature_code(&fcode);
  1075		if (ret) {
  1076			dev_err(dev, "Couldn't get feature code from SMEM!\n");
  1077			return ret;
  1078		}
  1079	
  1080		ret = qcom_smem_get_product_code(&pcode);
  1081		if (ret) {
  1082			dev_err(dev, "Couldn't get product code from SMEM!\n");
  1083			return ret;
  1084		}
  1085	
  1086		/* Don't consider fcode for external feature codes */
  1087		if (fcode <= SOCINFO_FC_EXT_RESERVE)
  1088			fcode = SOCINFO_FC_UNKNOWN;
  1089	
> 1090		*speedbin = FIELD_PREP(ADRENO_SKU_ID_PCODE, pcode) |
  1091			    FIELD_PREP(ADRENO_SKU_ID_FCODE, fcode);
  1092	
  1093		return ret;
  1094	}
  1095	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

