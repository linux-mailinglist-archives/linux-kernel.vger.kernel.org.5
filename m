Return-Path: <linux-kernel+bounces-18680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7128260EC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 18:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CE72828D3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DECC8EC;
	Sat,  6 Jan 2024 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RGSK7PyQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CDCC2D9;
	Sat,  6 Jan 2024 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704562312; x=1736098312;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n3+Tj0E2c0KPwQ7B4hOXXMxq2BNvY8cDkv/UylSvfWo=;
  b=RGSK7PyQ0JN4E7PniJMI3eHpKUwxQ3hqym1f6ad4x0X7g7juNqLYNmp5
   Bn/phI6FT01EmKtEHHPFCYQRymBU1RIUOWAofE6mnqswONsFXCbzE9uOf
   8Sk3Jwg7BMVmGHJ0ZaxCaYwOeviD/sO0mI3+gRQukjP/VQBaSMleBc1eJ
   bo1ED42ovMv6r3CuzQpmkU5Qkm/jv6tD91hX03px7m6XGv62Opv7f5fBp
   lx01CM/YrulCfQxqPgPO3wrD8In08lDXV7SRj3KWb02iDsvcBLE3Ug8Q1
   NsFN5f1pRVHXA5sW01u5AHAUXfT/jX/2C4pwpg0XwWeXncNPtzPOTC+O/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="11022453"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="11022453"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 09:31:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="784470349"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="784470349"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 06 Jan 2024 09:31:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMAWQ-0002o8-1c;
	Sat, 06 Jan 2024 17:31:46 +0000
Date: Sun, 7 Jan 2024 01:30:46 +0800
From: kernel test robot <lkp@intel.com>
To: Abel Vesa <abel.vesa@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH 2/2] phy: qualcomm: eusb2-repeater: Drop the redundant
 zeroing
Message-ID: <202401070143.pnnuXAwC-lkp@intel.com>
References: <20240104-phy-qcom-eusb2-repeater-fixes-v1-2-047b7b6b8333@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104-phy-qcom-eusb2-repeater-fixes-v1-2-047b7b6b8333@linaro.org>

Hi Abel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0fef202ac2f8e6d9ad21aead648278f1226b9053]

url:    https://github.com/intel-lab-lkp/linux/commits/Abel-Vesa/phy-qualcomm-eusb2-repeater-Fix-the-regfields-for-multiple-instances/20240104-225513
base:   0fef202ac2f8e6d9ad21aead648278f1226b9053
patch link:    https://lore.kernel.org/r/20240104-phy-qcom-eusb2-repeater-fixes-v1-2-047b7b6b8333%40linaro.org
patch subject: [PATCH 2/2] phy: qualcomm: eusb2-repeater: Drop the redundant zeroing
config: i386-buildonly-randconfig-004-20240106 (https://download.01.org/0day-ci/archive/20240107/202401070143.pnnuXAwC-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401070143.pnnuXAwC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401070143.pnnuXAwC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c: In function 'eusb2_repeater_init':
>> drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c:145:20: warning: unused variable 'regfields' [-Wunused-variable]
     struct reg_field *regfields = rptr->regfields;
                       ^~~~~~~~~


vim +/regfields +145 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c

56d77c9a10d97d Abel Vesa     2023-02-08  141  
56d77c9a10d97d Abel Vesa     2023-02-08  142  static int eusb2_repeater_init(struct phy *phy)
56d77c9a10d97d Abel Vesa     2023-02-08  143  {
56d77c9a10d97d Abel Vesa     2023-02-08  144  	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
ac0aae0074102c Abel Vesa     2024-01-04 @145  	struct reg_field *regfields = rptr->regfields;
56156a76e765d3 Konrad Dybcio 2023-09-13  146  	struct device_node *np = rptr->dev->of_node;
56156a76e765d3 Konrad Dybcio 2023-09-13  147  	u32 init_tbl[F_NUM_TUNE_FIELDS] = { 0 };
56156a76e765d3 Konrad Dybcio 2023-09-13  148  	u8 override;
56d77c9a10d97d Abel Vesa     2023-02-08  149  	u32 val;
56d77c9a10d97d Abel Vesa     2023-02-08  150  	int ret;
56d77c9a10d97d Abel Vesa     2023-02-08  151  	int i;
56d77c9a10d97d Abel Vesa     2023-02-08  152  
56d77c9a10d97d Abel Vesa     2023-02-08  153  	ret = regulator_bulk_enable(rptr->cfg->num_vregs, rptr->vregs);
56d77c9a10d97d Abel Vesa     2023-02-08  154  	if (ret)
56d77c9a10d97d Abel Vesa     2023-02-08  155  		return ret;
56d77c9a10d97d Abel Vesa     2023-02-08  156  
4ba2e52718c0ce Konrad Dybcio 2023-09-13  157  	regmap_field_update_bits(rptr->regs[F_EN_CTL1], EUSB2_RPTR_EN, EUSB2_RPTR_EN);
56d77c9a10d97d Abel Vesa     2023-02-08  158  
56156a76e765d3 Konrad Dybcio 2023-09-13  159  	memcpy(init_tbl, rptr->cfg->init_tbl, sizeof(init_tbl));
56156a76e765d3 Konrad Dybcio 2023-09-13  160  
56156a76e765d3 Konrad Dybcio 2023-09-13  161  	if (!of_property_read_u8(np, "qcom,tune-usb2-amplitude", &override))
56156a76e765d3 Konrad Dybcio 2023-09-13  162  		init_tbl[F_TUNE_IUSB2] = override;
56156a76e765d3 Konrad Dybcio 2023-09-13  163  
56156a76e765d3 Konrad Dybcio 2023-09-13  164  	if (!of_property_read_u8(np, "qcom,tune-usb2-disc-thres", &override))
56156a76e765d3 Konrad Dybcio 2023-09-13  165  		init_tbl[F_TUNE_HSDISC] = override;
56156a76e765d3 Konrad Dybcio 2023-09-13  166  
56156a76e765d3 Konrad Dybcio 2023-09-13  167  	if (!of_property_read_u8(np, "qcom,tune-usb2-preem", &override))
56156a76e765d3 Konrad Dybcio 2023-09-13  168  		init_tbl[F_TUNE_USB2_PREEM] = override;
56156a76e765d3 Konrad Dybcio 2023-09-13  169  
56156a76e765d3 Konrad Dybcio 2023-09-13  170  	for (i = 0; i < F_NUM_TUNE_FIELDS; i++)
56156a76e765d3 Konrad Dybcio 2023-09-13  171  		regmap_field_update_bits(rptr->regs[i], init_tbl[i], init_tbl[i]);
56d77c9a10d97d Abel Vesa     2023-02-08  172  
4ba2e52718c0ce Konrad Dybcio 2023-09-13  173  	ret = regmap_field_read_poll_timeout(rptr->regs[F_RPTR_STATUS],
4ba2e52718c0ce Konrad Dybcio 2023-09-13  174  					     val, val & RPTR_OK, 10, 5);
56d77c9a10d97d Abel Vesa     2023-02-08  175  	if (ret)
56d77c9a10d97d Abel Vesa     2023-02-08  176  		dev_err(rptr->dev, "initialization timed-out\n");
56d77c9a10d97d Abel Vesa     2023-02-08  177  
56d77c9a10d97d Abel Vesa     2023-02-08  178  	return ret;
56d77c9a10d97d Abel Vesa     2023-02-08  179  }
56d77c9a10d97d Abel Vesa     2023-02-08  180  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

