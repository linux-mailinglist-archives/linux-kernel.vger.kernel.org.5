Return-Path: <linux-kernel+bounces-16304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C3B823C80
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44BB2883AA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA92E1E51A;
	Thu,  4 Jan 2024 07:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fEph5X2O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441D51DFE2;
	Thu,  4 Jan 2024 07:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704352363; x=1735888363;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BuiT+rA2z6Mm0sjMPQLK1Ojp5SJ1U85xvH6hRCukWEg=;
  b=fEph5X2ODMIMzxPE6GqtlmNy++ZrU1qk8pCIi4P4rOkzLjwkVfkKerYI
   f9TFvgf9NZwvofiDXRGT6sTbTDBLuFPBviSTO5ln8T5x3JgsHVC29dAfC
   w4rwb3Vu1kaXCm46BCeGUSvoVFv167BlFhzl/jmwdKa6hfdAsTsO23G2k
   aEYYIPF/HgOoFAHi8oFkdT4fTyZKnUVekiZ7aJm8nP1CHaXjGcaXJa1Vb
   kY3QoufHgL1V7RNKe5uCQuirevAvs5i03lT+jtUSIBfwoe5p9hiGo/fYR
   nOtF2/KFheDP8LORA/WXh/cHji3gLNZoVrYSgXL/i3bwTudTFGLvHtUfJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="461454224"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="461454224"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 23:12:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="809105147"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="809105147"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.85])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 23:12:39 -0800
Message-ID: <6d0edbac-9b9c-4a90-a3c9-193198e8a088@intel.com>
Date: Thu, 4 Jan 2024 09:12:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Fix smatch errors
Content-Language: en-US
To: Stefan Wahren <wahrenst@gmx.net>,
 Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
 haibo.chen@nxp.com, ulf.hansson@linaro.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20231229130207.3539334-1-hardevsinh.palaniya@siliconsignals.io>
 <838abf56-e2b1-474b-977a-8671a31053ed@gmx.net>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <838abf56-e2b1-474b-977a-8671a31053ed@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/12/23 16:34, Stefan Wahren wrote:
> Hi Hardevsinh,
> 
> the patch subject is a too generic. Maybe something like "fix
> initialization of target_min/max"
> 
> Am 29.12.23 um 14:02 schrieb Hardevsinh Palaniya:
>> Resolve smatch errors in esdhc_executing_tuning()
>>
>> esdhc_executing_tuning() error: uninitialized symbol 'target_min'
>> esdhc_executing_tuning() error: uninitialized symbol 'target_max'
> I think this deserve
> 
> Fixes: 541a95e64d76 ("mmc: sdhci-esdhc-imx: optimize the manual tuing
> logic to get the best timing")

Is smatch right though?

	while (max < ESDHC_TUNE_CTRL_MAX) {	// always true first iteration

	max = min + ESDHC_TUNE_CTRL_STEP;	// max > min

		max -= ESDHC_TUNE_CTRL_STEP;
		break;				// max >= min

	win_length = max - min + 1;		// always > 0 since max >= min

	if (win_length > target_win_length) {	// always true first iteration
		target_min = min;		// always initialized
		target_max = max;		// always initialized

> 
> Thanks
>> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
>>
>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>> index 40a6e2f8145a..839b60138f04 100644
>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> @@ -1166,6 +1166,8 @@ static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
>>       min = ESDHC_TUNE_CTRL_MIN;
>>       max = ESDHC_TUNE_CTRL_MIN;
>>       target_win_length = 0;
>> +    target_min = 0;
>> +    target_max = 0;
>>       while (max < ESDHC_TUNE_CTRL_MAX) {
>>           /* find the mininum delay first which can pass tuning */
>>           while (min < ESDHC_TUNE_CTRL_MAX) {
> 


