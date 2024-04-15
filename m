Return-Path: <linux-kernel+bounces-144840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BE28A4B91
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C391C20F9F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035B23FE2A;
	Mon, 15 Apr 2024 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f2Kqu/nS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE493FB99;
	Mon, 15 Apr 2024 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713173724; cv=none; b=B0ctOp7hmkvb2BtPp8AvIMJZjE7FzB4Q9AT1TE8tYsTzfgKoXYVgMuvYcu51AkkUa9QPetLIqbj8tpBR8VB5GvsUsyDM8PjuvVFLg0c8CoeJCyt8fuSeVjEf0mR0qZIyst+/BJas7cLni6Myp4mC7sm7U0eu/nUW3xKuFZ7nI0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713173724; c=relaxed/simple;
	bh=wBSd5Y+TxWHD4LOFHSfb4cgjJpmNUSVnhOraR697swQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sL7jBQcTSXvxiHJ3DW5lnm5LdfaTNbapQAqT5Ec/65vyyeGKmy3MPYwlz/9NQEu1mM8QKwZ+nX0CIo4ilp/WCLCQat3/lIOVOAzcPUweuc1WEARS8qwh3YDwbaH6GdIRATqHidw8/BS9g220/QGkJsqhkh3pM8oBuk5F37B6Wbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f2Kqu/nS; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713173723; x=1744709723;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wBSd5Y+TxWHD4LOFHSfb4cgjJpmNUSVnhOraR697swQ=;
  b=f2Kqu/nSbHxB8YNuz6SC2yWQhFN+yPcROnOCgzZr4G/II6QeEAX5TBmm
   TrGAr6jh3kq43DbNLGr5PVDyxr7QToBMwc1Sw/gqWEXwiAPbG2/r1o5Cf
   QzhPgsqJjc61/vBvdNyj71yH78om99Qiw9QO/2F0pVLc60AK5E69Tf2mi
   VdFlSan0oy5uh52kTfwYS2AqWpK4iDFlBdUyTuUUFntPSXjbAagwOuWqV
   ZxAbrSSZgVeQB8uziZXCx3vGbY5IVD1FHaB1jd15SrBobNuUMSkEncaQm
   yWM2pNak0xKRdwtStkSKxgZQpHJvMDPoPKkpqfBmlKHyc7BHBPFsHRkgk
   A==;
X-CSE-ConnectionGUID: 2JGKiuuwTkSZ17MqBdHPTg==
X-CSE-MsgGUID: mElYACCuSS+NXX44BZzKdw==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="19945547"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="19945547"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 02:35:22 -0700
X-CSE-ConnectionGUID: GnbRCkgnSgGpFl3/1d/tYw==
X-CSE-MsgGUID: tS21odWISD2AIiblLYPrkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="52807041"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.38.19])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 02:35:19 -0700
Message-ID: <ba32a2ca-e482-45c2-b381-f8371b8da4be@intel.com>
Date: Mon, 15 Apr 2024 12:35:14 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sdhci: Fix SD card detection issue
To: richard clark <richard.xnu.clark@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240415070620.133143-1-richard.xnu.clark@gmail.com>
 <52c08a01-8357-44dd-b727-a06438ec6c30@intel.com>
 <CAJNi4rOyuXdHOifib6kX0Wdb5O5LXPEm9nsvEMe-jbCz9GyQww@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAJNi4rOyuXdHOifib6kX0Wdb5O5LXPEm9nsvEMe-jbCz9GyQww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

+Nvidia guys

On 15/04/24 11:11, richard clark wrote:
> On Mon, Apr 15, 2024 at 3:18 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 15/04/24 10:06, Richard Clark wrote:
>>> The mmc_gpio_get_cd(...) will return 0 called from sdhci_get_cd(...), which means
>>> the card is not present. Actually, the card detection pin is active low by default
>>> according to the SDHCI psec, thus the card detection result is not correct, more
>>
>> SDHCI spec covers the SDHCI lines.  GPIO is separate.
>>
>>> specificly below if condition is true in mmc_rescan(...):
>>>       ...
>>>       if (mmc_card_is_removable(host) && host->ops->get_cd &&
>>>               host->ops->get_cd(host) == 0) {
>>>               ...
>>>               goto out;
>>>       }
>>> The SD card device will have no chance to be created.
>>>
>>> This commit fixes this detection issue via the MMC_CAP2_CD_ACTIVE_HIGH cap2 flag,
>>> parsed from the 'cd-inverted' property of DT.
>>
>> What hardware / driver is it?
> sdhci-tegra on Orin.
>>>
>>> Signed-off-by: Richard Clark <richard.xnu.clark@gmail.com>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index c79f73459915..79f33a161ca8 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -2483,6 +2483,9 @@ static int sdhci_get_cd(struct mmc_host *mmc)
>>>        * Try slot gpio detect, if defined it take precedence
>>>        * over build in controller functionality
>>>        */
>>> +     if (!(mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH))
>>> +             gpio_cd = !gpio_cd;
>>
>> MMC_CAP2_CD_ACTIVE_HIGH is already handled in
>> mmc_gpiod_request_cd(), and this turns an error (gpio_cd < 0)
>> into 0, which is not right.
> 
> But in case of 'cd-inverted' is not specified, the gpio CD pin return
> 0 which will be explained as card is not present.
>>
>>> +
>>>       if (gpio_cd >= 0)
>>>               return !!gpio_cd;
>>>
>>


