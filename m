Return-Path: <linux-kernel+bounces-71302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 764E885A32B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7532AB22B81
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B3C2E3F3;
	Mon, 19 Feb 2024 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taKnRuL1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2843B21103;
	Mon, 19 Feb 2024 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345640; cv=none; b=YRMaWyfc8YN5i0R0VIcquD+NdrBIfssBNj3RPHtiJDgb8TlxgLvkaVDYOVqlCKRlkc9SJmtR/FUigmA1aCBJgzfaTsKUGLGvJhQNGZ6CVnS4i7Kq3cpBJ3w4KGeqJF8WtyJYEwgmn8bla7YawotWK3r5lQPLz9l606P1mk0zjks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345640; c=relaxed/simple;
	bh=wjZw+mWJBR/kGq3Uc+1DZLRkxqifdShqnWAT4YCy3W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PnV+35/l1FdPhDJ7/lp6B0vg5LKhTFtrbkrICSvjcDtSpkdXDcubGy3AzLS5n3FZnxENgbfmYfGV3lyZjl7XqE9462jyeElEtGHN/zNSjSwjv8HJtn84POh7Rttl5Fo6M9hWcuL4/hUDq/dqISKCrqopo8mXGrERiiFdo+DM4ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taKnRuL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9CFC433F1;
	Mon, 19 Feb 2024 12:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708345639;
	bh=wjZw+mWJBR/kGq3Uc+1DZLRkxqifdShqnWAT4YCy3W8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=taKnRuL1BdTEPmcAkix1YrJfWe0NSXrx1QPP3+hwp0hsKkylMuo4/QMRgZnrlM5qH
	 FLbKpFGDGbfVykoqDJ3b/2XtdUe5KdgI0khlGlGIl481RFuL1gJn4y7EAJWoOfNADk
	 VXTacMjtmP6iUsMIw1dwzV1xTNWdUzQDDYkyNIk7NjcZx3+ogVSy0Va+i6whO04BFW
	 vs5kgZ6YGRESnLD0S/wzTDYo94fZ5PKDxCzsV8Uokdh+zRgjXDTgA3ad2Lte+Jg+f3
	 jQDEkIOBAaPhL3Z3waxc7PaZ78gvjI6jr7SC9qOo8iH7KvZ7MVaV29xO9yXg9piKNQ
	 yQ2KCXuit0Hyw==
Message-ID: <956ebf94-62ef-4e67-893e-86586a980883@kernel.org>
Date: Mon, 19 Feb 2024 13:27:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mmc: dw_mmc: add support for hi3798mv200
Content-Language: en-US
To: Yang Xiwen <forbidden405@outlook.com>, kernel test robot <lkp@intel.com>,
 Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung
 <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Igor Opaniuk <igor.opaniuk@linaro.org>,
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240216-b4-mmc-hi3798mv200-v1-1-7d46db845ae6@outlook.com>
 <202402181540.H4Ose96P-lkp@intel.com>
 <SEZPR06MB695945299705B6E8BF0E326296522@SEZPR06MB6959.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <SEZPR06MB695945299705B6E8BF0E326296522@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/02/2024 09:21, Yang Xiwen wrote:
> On 2/18/2024 4:03 PM, kernel test robot wrote:
>> Hi Yang,
>>
>> kernel test robot noticed the following build errors:
>>
>> [auto build test ERROR on 8d3dea210042f54b952b481838c1e7dfc4ec751d]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Xiwen-via-B4-Relay/mmc-dw_mmc-add-support-for-hi3798mv200/20240216-014744
>> base:   8d3dea210042f54b952b481838c1e7dfc4ec751d
>> patch link:    https://lore.kernel.org/r/20240216-b4-mmc-hi3798mv200-v1-1-7d46db845ae6%40outlook.com
>> patch subject: [PATCH 1/3] mmc: dw_mmc: add support for hi3798mv200
>> config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20240218/202402181540.H4Ose96P-lkp@intel.com/config)
>> compiler: hppa-linux-gcc (GCC) 13.2.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240218/202402181540.H4Ose96P-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202402181540.H4Ose96P-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>     drivers/mmc/host/dw_mmc-hi3798mv200.c: In function 'dw_mci_hi3798mv200_init':
>>>> drivers/mmc/host/dw_mmc-hi3798mv200.c:178:36: error: passing argument 1 of 'mmc_of_parse_clk_phase' from incompatible pointer type [-Werror=incompatible-pointer-types]
>>       178 |         mmc_of_parse_clk_phase(host->dev, &priv->phase_map);
>>           |                                ~~~~^~~~~
>>           |                                    |
>>           |                                    struct device *
>>     In file included from drivers/mmc/host/dw_mmc-hi3798mv200.c:11:
>>     include/linux/mmc/host.h:542:46: note: expected 'struct mmc_host *' but argument is of type 'struct device *'
>>       542 | void mmc_of_parse_clk_phase(struct mmc_host *host,
>>           |                             ~~~~~~~~~~~~~~~~~^~~~
>>     cc1: some warnings being treated as errors
>>
>>
>> vim +/mmc_of_parse_clk_phase +178 drivers/mmc/host/dw_mmc-hi3798mv200.c
>>
>>     168	
>>     169	static int dw_mci_hi3798mv200_init(struct dw_mci *host)
>>     170	{
>>     171		struct dw_mci_hi3798mv200_priv *priv;
>>     172		struct device_node *np = host->dev->of_node;
>>     173	
>>     174		priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
>>     175		if (!priv)
>>     176			return -ENOMEM;
>>     177	
>>   > 178		mmc_of_parse_clk_phase(host->dev, &priv->phase_map);
> 
> Please note that this patch is depending on another patch[1].
> 
> [1]: 
> https://lore.kernel.org/linux-mmc/ae876e697ba16ba2925ec217c6b4e3d8ffea4ab3.camel@codeconstruct.com.au/T/#t
> 

You did not provide any links to dependencies in cover letter nor in
patch changelog. You included on purpose, which is nice and correct, the
base commit:

	base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d

which does not include above commit apparently.

How anyone can guess it and test your patches?

Please send with proper dependencies marked.

Best regards,
Krzysztof


