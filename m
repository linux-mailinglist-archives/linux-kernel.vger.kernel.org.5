Return-Path: <linux-kernel+bounces-147015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA0A8A6E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F151F21E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7397413048F;
	Tue, 16 Apr 2024 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FwtwHAbf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5150312C491;
	Tue, 16 Apr 2024 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277691; cv=none; b=LV9/3PLpoHwMNB0tngx79i1p0bgdvu/v5ZedTjztiY1dW796HJPS4F7DYBiyoeyQO4cPL89tCrWNgDN0zecR3F+q/i85v/OuGaF9lmnUlZxD/Vp7aIUTbhjLFdky1nih98+fW+Fu+Q1SS0fhtvTpmTBNlOlyWPcp+kJFPLOiuBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277691; c=relaxed/simple;
	bh=phn+BucdZGMtnw8g08k3T7d/QfnKj5WDeUf8Ocjk1JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5UFwMkM38yam7yN3uy8k9efHYPn6yOKzxFY2X+Iu+uORyvqXonwq20mGxOTeK5BpnBYOUuiWBlmV80Hd2ih9ZAjYfoUWl3mp7x2IUJbN6DqVzZ4Z/xtEPhdR5Z5If6mcUJzG8E8abp2sNPD8f62J26dT2mLkZIk8aYH4WXXBnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FwtwHAbf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713277689; x=1744813689;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=phn+BucdZGMtnw8g08k3T7d/QfnKj5WDeUf8Ocjk1JY=;
  b=FwtwHAbfywuNEXWR7o2hpXzjIM/KvtPxguG9MIOMCswO2L2hbrYNRR9I
   voP+cCPOKUqn646a9EcB2Xnt7Z8afZtrdK5UnLZIcc5TbpIJ63V+6SthZ
   m+CPMIxZV73TcJaTUKFur7399ertCagVuury+tvTteezEEkyMkDI3hXyQ
   wluu4UXYopz7MDyic7LohZZkDmcvSKkvlVNZVTnARvfrtwcytSUfycutw
   CJOP7xwSYK92Uqq5mfvA6H0JEvLTOKVfnCFYmDh1nSveEStI2CQVZpeqH
   5RqEJ0CDo+7LmIP+bA6qrqplYI3DhbK0LCZ5/WbadZxxPAUmkU7/zHZyA
   A==;
X-CSE-ConnectionGUID: ZoLKFnWuQ7aG3B/KIjrrUw==
X-CSE-MsgGUID: gyrDM8lORMmVfoYR/b49ZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="26230017"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="26230017"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 07:28:08 -0700
X-CSE-ConnectionGUID: R7U1Jg+RT8SzMByYQVm9WA==
X-CSE-MsgGUID: r203CmhBQwC3cSYiuuMJEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="53257458"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.239])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 07:28:04 -0700
Message-ID: <0bba3454-ba8a-4c4e-8c17-725b6334b0d6@intel.com>
Date: Tue, 16 Apr 2024 17:27:59 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-msm: pervent access to suspended controller
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mantas Pucka <mantas@8devices.com>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Georgi Djakov <djakov@kernel.org>, Pramod Gurav <pramod.gurav@linaro.org>,
 Ritesh Harjani <ritesh.list@gmail.com>, linux-mmc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Liming Sun <limings@nvidia.com>,
 Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20240321-sdhci-mmc-suspend-v1-1-fbc555a64400@8devices.com>
 <2e712cf6-7521-4c0b-b6fd-76bacc309496@intel.com>
 <CAPDyKFoBgwWDXhcXsbCfBD_nJ=3w1e5eReqHgDQ1BiPf0zJRxw@mail.gmail.com>
 <5bce008a-8354-4ccd-af1f-b7f2b2caf3bc@intel.com>
 <77d76e3b-549e-4d26-834c-a59b91fbb2a0@intel.com>
 <CAPDyKFrx3OdQqzfUvfi_tsoA0Am2rf6HKSrzL1qg77p50BZ3Lw@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAPDyKFrx3OdQqzfUvfi_tsoA0Am2rf6HKSrzL1qg77p50BZ3Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/04/24 00:13, Ulf Hansson wrote:
> On Thu, 4 Apr 2024 at 20:42, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 28/03/24 16:20, Adrian Hunter wrote:
>>> On 27/03/24 17:17, Ulf Hansson wrote:
>>>> On Tue, 26 Mar 2024 at 11:25, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>
>>>>> On 21/03/24 16:30, Mantas Pucka wrote:
>>>>>> Generic sdhci code registers LED device and uses host->runtime_suspended
>>>>>> flag to protect access to it. The sdhci-msm driver doesn't set this flag,
>>>>>> which causes a crash when LED is accessed while controller is runtime
>>>>>> suspended. Fix this by setting the flag correctly.
>>>>>>
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Fixes: 67e6db113c90 ("mmc: sdhci-msm: Add pm_runtime and system PM support")
>>>>>> Signed-off-by: Mantas Pucka <mantas@8devices.com>
>>>>>
>>>>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>>>
>>>> Looks like this problem may exist for other sdhci drivers too. In
>>>> particular for those that enables runtime PM, don't set
>>>> SDHCI_QUIRK_NO_LED and don't use sdhci_runtime|suspend_resume_host().
>>>>
>>>> Don't know if there is a better way to address this, if not on a case
>>>> by case basis. Do you have any thoughts about this?
>>>
>>> Yes probably case by case, but I will look at it.
>>
>> There seem to be 3 that use runtime pm but not
>> sdhci_runtime_suspend_host():
>>
>> 1. dwcmshc_runtime_suspend() : only turns off the card clock
>> via SDHCI_CLOCK_CONTROL register, so registers are presumably
>> still accessible
>>
>> 2. gl9763e_runtime_suspend() : ditto
>>
>> 3. sdhci_tegra_runtime_suspend() : disables the functional
>> clock via clk_disable_unprepare(), so registers are presumably
>> still accessible
>>
>> sdhci_msm_runtime_suspend() is different because it also turns
>> off the interface clock.
>>
>> But it looks like there are no similar cases.
> 
> Not sure we should care, but it still looks a bit fragile to me. We
> may also have a power-domain hooked up to the device, that could get
> power gated too, in which case it's likely affecting the access to
> registers.

Thought some more about this, but there isn't an easy way to know
if drivers are catering for SDIO card interrupt or SD card detect
interrupt.


