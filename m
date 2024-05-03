Return-Path: <linux-kernel+bounces-167265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 503A98BA6B3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF862829B8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 05:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4029139CEF;
	Fri,  3 May 2024 05:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JRYkBbDX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F532139586;
	Fri,  3 May 2024 05:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714714700; cv=none; b=cz2uWggIYHXtCcqpYDqENqMpIfZGa6HqE7KTZWwVjk20d/uVoUWN1zL56xFZBj+8dd92HmPgoJ80vauMaStnJ3olBLrl2eB35+HsF1IPpZPW3Af81h1UWFDOGsnbbj6GPDMISU5X6FzlSH/+/Cdjev0LDqADIdXClrFzdJotPw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714714700; c=relaxed/simple;
	bh=rKKCeOF3G9JpimaU43Lw2IpoOJrnNfrZXT1xQPXth8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsJA7GGRBkLhW2oV1Pg5KtXXipjAvjaNPwcBOWww8gVVacoSpRngdmUop8kzmhFGtnu3QFTAbjViLVP47wP5iVsjAex7ksVJPKq3t3IVO/dgxGHi4BQVDZMXqijSbedZiM1GAR0zys/QhF8olwy9Jc0QtyUS7iPBAZd/SVXdr4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JRYkBbDX; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714714699; x=1746250699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rKKCeOF3G9JpimaU43Lw2IpoOJrnNfrZXT1xQPXth8A=;
  b=JRYkBbDXPBWorQJQs4RmdDhb6Ly6khOldhDix3cpkQ6UcFW24WsW4WWl
   aQx/ukKvMBFvKGRyy64tbIZzfLLb9TtwNLBxY2TMk6n0KSMpkQmnac3P6
   doUsWMriLMlK6Xq75iJa/xDmB3TTeidDnl1Nnz0HxgJRHzo+o6IPg/6ar
   LxJak5Defmy7j0v3qwUt6I3jOxBY9cyKcpbTYfWVNFAe4ZT2ZBW2tPw7p
   kU6TVrUK4rWcBWIamIg5BC88mZAy4JWdHLGiH1ci+C83kOzg6XSpfXX/g
   oS6qvjVWThtPXkj8btkvIIFIRdKSHfWeNi27RkdvGuHBouklELWg3NAw2
   A==;
X-CSE-ConnectionGUID: fTFehmlBSdKr3RpYmun82w==
X-CSE-MsgGUID: y6r98hMaSBKNSE4jWhHSMA==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="13463445"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="13463445"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 22:38:18 -0700
X-CSE-ConnectionGUID: k8feyb1gQr+mYHjcJFVckg==
X-CSE-MsgGUID: WZxVMUhvTvuHjXpz3ZIjMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27372199"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 02 May 2024 22:38:15 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2lcb-000BLs-1D;
	Fri, 03 May 2024 05:38:13 +0000
Date: Fri, 3 May 2024 13:37:49 +0800
From: kernel test robot <lkp@intel.com>
To: Udipto Goswami <quic_ugoswami@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	Udipto Goswami <quic_ugoswami@quicinc.com>
Subject: Re: [PATCH] phy: qcom-snps-femto-v2: Add load and voltage setting
 for LDO's used
Message-ID: <202405031311.9f1PrPou-lkp@intel.com>
References: <20240502123312.31083-1-quic_ugoswami@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502123312.31083-1-quic_ugoswami@quicinc.com>

Hi Udipto,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.9-rc6 next-20240502]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Udipto-Goswami/phy-qcom-snps-femto-v2-Add-load-and-voltage-setting-for-LDO-s-used/20240502-203521
base:   linus/master
patch link:    https://lore.kernel.org/r/20240502123312.31083-1-quic_ugoswami%40quicinc.com
patch subject: [PATCH] phy: qcom-snps-femto-v2: Add load and voltage setting for LDO's used
config: x86_64-buildonly-randconfig-003-20240503 (https://download.01.org/0day-ci/archive/20240503/202405031311.9f1PrPou-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240503/202405031311.9f1PrPou-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405031311.9f1PrPou-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c:168: warning: Function parameter or struct member 'vreg_list' not described in 'qcom_snps_hsphy'


vim +168 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c

df2217ff17a820 Krishna Kurapati    2022-09-06  136  
51e8114f80d076 Wesley Cheng        2020-05-04  137  /**
51e8114f80d076 Wesley Cheng        2020-05-04  138   * struct qcom_snps_hsphy - snps hs phy attributes
51e8114f80d076 Wesley Cheng        2020-05-04  139   *
8a0eb8f9b9a002 Adrien Thierry      2023-06-29  140   * @dev: device structure
8a0eb8f9b9a002 Adrien Thierry      2023-06-29  141   *
51e8114f80d076 Wesley Cheng        2020-05-04  142   * @phy: generic phy
51e8114f80d076 Wesley Cheng        2020-05-04  143   * @base: iomapped memory space for snps hs phy
51e8114f80d076 Wesley Cheng        2020-05-04  144   *
8a0eb8f9b9a002 Adrien Thierry      2023-06-29  145   * @num_clks: number of clocks
8a0eb8f9b9a002 Adrien Thierry      2023-06-29  146   * @clks: array of clocks
51e8114f80d076 Wesley Cheng        2020-05-04  147   * @phy_reset: phy reset control
51e8114f80d076 Wesley Cheng        2020-05-04  148   * @vregs: regulator supplies bulk data
51e8114f80d076 Wesley Cheng        2020-05-04  149   * @phy_initialized: if PHY has been initialized correctly
dcbec046507615 Wesley Cheng        2020-06-25  150   * @mode: contains the current mode the PHY is in
2a881183dc5ab2 Krzysztof Kozlowski 2023-05-07  151   * @update_seq_cfg: tuning parameters for phy init
51e8114f80d076 Wesley Cheng        2020-05-04  152   */
51e8114f80d076 Wesley Cheng        2020-05-04  153  struct qcom_snps_hsphy {
8a0eb8f9b9a002 Adrien Thierry      2023-06-29  154  	struct device *dev;
8a0eb8f9b9a002 Adrien Thierry      2023-06-29  155  
51e8114f80d076 Wesley Cheng        2020-05-04  156  	struct phy *phy;
51e8114f80d076 Wesley Cheng        2020-05-04  157  	void __iomem *base;
51e8114f80d076 Wesley Cheng        2020-05-04  158  
8a0eb8f9b9a002 Adrien Thierry      2023-06-29  159  	int num_clks;
8a0eb8f9b9a002 Adrien Thierry      2023-06-29  160  	struct clk_bulk_data *clks;
51e8114f80d076 Wesley Cheng        2020-05-04  161  	struct reset_control *phy_reset;
51e8114f80d076 Wesley Cheng        2020-05-04  162  	struct regulator_bulk_data vregs[SNPS_HS_NUM_VREGS];
4dac559b5584a2 Udipto Goswami      2024-05-02  163  	const struct qcom_snps_hsphy_regulator_data *vreg_list;
51e8114f80d076 Wesley Cheng        2020-05-04  164  
51e8114f80d076 Wesley Cheng        2020-05-04  165  	bool phy_initialized;
dcbec046507615 Wesley Cheng        2020-06-25  166  	enum phy_mode mode;
df2217ff17a820 Krishna Kurapati    2022-09-06  167  	struct phy_override_seq update_seq_cfg[NUM_HSPHY_TUNING_PARAMS];
51e8114f80d076 Wesley Cheng        2020-05-04 @168  };
51e8114f80d076 Wesley Cheng        2020-05-04  169  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

