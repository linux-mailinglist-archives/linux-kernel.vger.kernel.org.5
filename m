Return-Path: <linux-kernel+bounces-130124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8525889745E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E541B1F23F55
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CA914B069;
	Wed,  3 Apr 2024 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8VILx7Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B352E14A4C8;
	Wed,  3 Apr 2024 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159281; cv=none; b=PSRe62tpRwRoYIZ+kywnb5W5anQe3vc+FlfLD893G98k9GhYXQhuGZtZJbg0RHAPs0bYiUCN8yv0/CblFcM8383+YTjicZHf0B5i7xJD5LPvuSTuI5UlumhFyGMZqErM86+jmqeUpgbUcRE3Qx8W2Nxg/0/+xoMQMTm6nYZkQAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159281; c=relaxed/simple;
	bh=HHPDm+TLj1RKaDaIxeLlYDtf5KUMp/lQSPe/aTjr+IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GK4qPx4LClDZ1OtMsUdTyLCR9mqUvWzX6agR4++JUwcJSYdiC5uIZdpmL6Mlf1HrCLjPIU9IXH64EvrB2Php8YAVFGOrrgOBsdYrOLwtB9GGkDzzNMyXd537YrE9G+7/f0aFoysXSux9lieFA0jDAQVseWfY4uCNzLI1RiRVAwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z8VILx7Z; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712159280; x=1743695280;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HHPDm+TLj1RKaDaIxeLlYDtf5KUMp/lQSPe/aTjr+IY=;
  b=Z8VILx7ZHGanJgT8YehLXrvuMdIUbKUT2qXRpyMTCEGATGv/M3/rPM+2
   hIRtOdwejeX+fJGtrJZ1/rMRun3Wkjwd+f3zIwWulgSFlg+UdlqSVRuO1
   A0JIAtxbVICStED0GmQx6WSharEvLcpaKnazX2/E4lAvtg5M8tnY0KEve
   n/rdRNRT2vwUsR2kc9oBX4y3oadY+F70BjWsLtkBbkO7k7YzQFJyVOXNd
   VMLqx/Oz8yp+oq3RapWslAz7OIOYULgaL4r04Z7zR0Ic2w+B93FFd+wJ3
   bKYtha8f5Ta2+BxkeJ0nwfDlaqWFHaEKW8frk87iMMIrl55lwqx1PhvO1
   g==;
X-CSE-ConnectionGUID: 4188y/KYR+qT4NpSWF74iQ==
X-CSE-MsgGUID: DFuHLn/BQdSl54BSCXlJdQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18558397"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18558397"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 08:47:59 -0700
X-CSE-ConnectionGUID: Ynzp+NMBQ/SrwU4aUtba9g==
X-CSE-MsgGUID: lnSkcc3aThqAee/09MNTdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18397635"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 03 Apr 2024 08:47:54 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rs2q8-0002Mo-03;
	Wed, 03 Apr 2024 15:47:52 +0000
Date: Wed, 3 Apr 2024 23:42:41 +0800
From: kernel test robot <lkp@intel.com>
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
	konrad.dybcio@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, djakov@kernel.org, dmitry.baryshkov@linaro.org,
	quic_anusha@quicinc.com, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 2/6] interconnect: icc-clk: Remove tristate from
 INTERCONNECT_CLK
Message-ID: <202404032328.7zrla6d9-lkp@intel.com>
References: <20240402103406.3638821-3-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240402103406.3638821-3-quic_varada@quicinc.com>

Hi Varadarajan,

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on robh/for-next linus/master v6.9-rc2 next-20240403]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Varadarajan-Narayanan/dt-bindings-interconnect-Add-Qualcomm-IPQ9574-support/20240402-223729
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20240402103406.3638821-3-quic_varada%40quicinc.com
patch subject: [PATCH v6 2/6] interconnect: icc-clk: Remove tristate from INTERCONNECT_CLK
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240403/202404032328.7zrla6d9-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240403/202404032328.7zrla6d9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404032328.7zrla6d9-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: drivers/clk/qcom/clk-cbf-8996.o: in function `qcom_msm8996_cbf_icc_remove':
>> drivers/clk/qcom/clk-cbf-8996.c:257:(.text+0x10): undefined reference to `icc_clk_unregister'
   aarch64-linux-ld: drivers/clk/qcom/clk-cbf-8996.o: in function `qcom_msm8996_cbf_icc_register':
>> drivers/clk/qcom/clk-cbf-8996.c:244:(.text+0x360): undefined reference to `icc_clk_register'


vim +257 drivers/clk/qcom/clk-cbf-8996.c

12dc71953e664f Dmitry Baryshkov 2023-05-12  234  
12dc71953e664f Dmitry Baryshkov 2023-05-12  235  static int qcom_msm8996_cbf_icc_register(struct platform_device *pdev, struct clk_hw *cbf_hw)
12dc71953e664f Dmitry Baryshkov 2023-05-12  236  {
12dc71953e664f Dmitry Baryshkov 2023-05-12  237  	struct device *dev = &pdev->dev;
12dc71953e664f Dmitry Baryshkov 2023-05-12  238  	struct clk *clk = devm_clk_hw_get_clk(dev, cbf_hw, "cbf");
12dc71953e664f Dmitry Baryshkov 2023-05-12  239  	const struct icc_clk_data data[] = {
12dc71953e664f Dmitry Baryshkov 2023-05-12  240  		{ .clk = clk, .name = "cbf", },
12dc71953e664f Dmitry Baryshkov 2023-05-12  241  	};
12dc71953e664f Dmitry Baryshkov 2023-05-12  242  	struct icc_provider *provider;
12dc71953e664f Dmitry Baryshkov 2023-05-12  243  
12dc71953e664f Dmitry Baryshkov 2023-05-12 @244  	provider = icc_clk_register(dev, CBF_MASTER_NODE, ARRAY_SIZE(data), data);
12dc71953e664f Dmitry Baryshkov 2023-05-12  245  	if (IS_ERR(provider))
12dc71953e664f Dmitry Baryshkov 2023-05-12  246  		return PTR_ERR(provider);
12dc71953e664f Dmitry Baryshkov 2023-05-12  247  
12dc71953e664f Dmitry Baryshkov 2023-05-12  248  	platform_set_drvdata(pdev, provider);
12dc71953e664f Dmitry Baryshkov 2023-05-12  249  
12dc71953e664f Dmitry Baryshkov 2023-05-12  250  	return 0;
12dc71953e664f Dmitry Baryshkov 2023-05-12  251  }
12dc71953e664f Dmitry Baryshkov 2023-05-12  252  
abaf59c470a7c9 Uwe Kleine-König 2023-09-11  253  static void qcom_msm8996_cbf_icc_remove(struct platform_device *pdev)
12dc71953e664f Dmitry Baryshkov 2023-05-12  254  {
12dc71953e664f Dmitry Baryshkov 2023-05-12  255  	struct icc_provider *provider = platform_get_drvdata(pdev);
12dc71953e664f Dmitry Baryshkov 2023-05-12  256  
12dc71953e664f Dmitry Baryshkov 2023-05-12 @257  	icc_clk_unregister(provider);
12dc71953e664f Dmitry Baryshkov 2023-05-12  258  }
12dc71953e664f Dmitry Baryshkov 2023-05-12  259  #define qcom_msm8996_cbf_icc_sync_state icc_sync_state
12dc71953e664f Dmitry Baryshkov 2023-05-12  260  #else
12dc71953e664f Dmitry Baryshkov 2023-05-12  261  static int qcom_msm8996_cbf_icc_register(struct platform_device *pdev,  struct clk_hw *cbf_hw)
12dc71953e664f Dmitry Baryshkov 2023-05-12  262  {
12dc71953e664f Dmitry Baryshkov 2023-05-12  263  	dev_warn(&pdev->dev, "CONFIG_INTERCONNECT is disabled, CBF clock is fixed\n");
12dc71953e664f Dmitry Baryshkov 2023-05-12  264  
12dc71953e664f Dmitry Baryshkov 2023-05-12  265  	return 0;
12dc71953e664f Dmitry Baryshkov 2023-05-12  266  }
abaf59c470a7c9 Uwe Kleine-König 2023-09-11  267  #define qcom_msm8996_cbf_icc_remove(pdev) { }
12dc71953e664f Dmitry Baryshkov 2023-05-12  268  #define qcom_msm8996_cbf_icc_sync_state NULL
12dc71953e664f Dmitry Baryshkov 2023-05-12  269  #endif
12dc71953e664f Dmitry Baryshkov 2023-05-12  270  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

