Return-Path: <linux-kernel+bounces-131975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93B2898E28
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776941F2C2CE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB691327FD;
	Thu,  4 Apr 2024 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZKTRAti"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0083F130E29;
	Thu,  4 Apr 2024 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712256175; cv=none; b=nT9v8efRvr6/Me5+FdVXOH9GPACEc+Ma9+PBlswc5yA9JxHdwpiLUCPQqopCxB1Ny6MD9R3gArL3vKrluJYrkJXLIKLPndhMpt0zfAa35/E2JtOI+1wZQSKAcbFBgDmNPTyix/CkDcqVQ66ye+jkH+5aVt//5ltI267VQBlC2Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712256175; c=relaxed/simple;
	bh=4NQR6s8aErkFZR1aqYo3S/4BmQ1dbHV3gCI/EvoLQMk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ISwW/nUTvOWeKOy7EMTW8HOBTrvchLDEUdU2pFqs0TI2YIp9PR4GSUTodXhWacgG41mFZj3tRsELbJtIBEooPPY/gkbHQiPdEuWt2KWEz7E6ywfU/7u61BuNEufpmMEk8sD8VUzWpKNwNf2Vx7PEULps3TDwJA3JofpYFCp2Dvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZKTRAti; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712256174; x=1743792174;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=4NQR6s8aErkFZR1aqYo3S/4BmQ1dbHV3gCI/EvoLQMk=;
  b=eZKTRAtiKEtqOPkraqky2lUoDnx6i3BSHExJ1+NWrN6ASdRtDhgeGhAB
   WccDlSsCAMWVjrtTK5RL3UfMepY/6FubsbJXIPgEz7FCuxPFyV7Aq5UQr
   730eQeon17jGRuQ/OhL68NzGnimXSszqrTuL4rJeW7iAjEQjhnqKHsJzc
   4Zn1ylyvkYJz1byzo2aPcKUfGPrH4+ZdmaBLXEcEVN+dxAlwfs/RrEUB5
   kF7qYuFKtYlsWVIaJSZFDAVyk8b/TeFn4fOG4qaMXUpWa62ai7otO9eqJ
   03IfJqcmakSXZvu6J2Tmm2ILu9t45UgGllQXMLRDlZOWSSkZ/3lp8FCA/
   w==;
X-CSE-ConnectionGUID: Bn0+/+XtSmyCG/Y6u3tBtA==
X-CSE-MsgGUID: iaxRHqvTRGWw4ZOIKkEjRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="8144129"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="8144129"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 11:42:53 -0700
X-CSE-ConnectionGUID: L/rnFIAUR4a+alwgAUI4JQ==
X-CSE-MsgGUID: Y9bcLz4VRtet7EZ2yn0QDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18786003"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.213.127])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 11:42:49 -0700
Message-ID: <77d76e3b-549e-4d26-834c-a59b91fbb2a0@intel.com>
Date: Thu, 4 Apr 2024 21:42:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-msm: pervent access to suspended controller
From: Adrian Hunter <adrian.hunter@intel.com>
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
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <5bce008a-8354-4ccd-af1f-b7f2b2caf3bc@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/03/24 16:20, Adrian Hunter wrote:
> On 27/03/24 17:17, Ulf Hansson wrote:
>> On Tue, 26 Mar 2024 at 11:25, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>
>>> On 21/03/24 16:30, Mantas Pucka wrote:
>>>> Generic sdhci code registers LED device and uses host->runtime_suspended
>>>> flag to protect access to it. The sdhci-msm driver doesn't set this flag,
>>>> which causes a crash when LED is accessed while controller is runtime
>>>> suspended. Fix this by setting the flag correctly.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: 67e6db113c90 ("mmc: sdhci-msm: Add pm_runtime and system PM support")
>>>> Signed-off-by: Mantas Pucka <mantas@8devices.com>
>>>
>>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>
>> Looks like this problem may exist for other sdhci drivers too. In
>> particular for those that enables runtime PM, don't set
>> SDHCI_QUIRK_NO_LED and don't use sdhci_runtime|suspend_resume_host().
>>
>> Don't know if there is a better way to address this, if not on a case
>> by case basis. Do you have any thoughts about this?
> 
> Yes probably case by case, but I will look at it.

There seem to be 3 that use runtime pm but not
sdhci_runtime_suspend_host():

1. dwcmshc_runtime_suspend() : only turns off the card clock
via SDHCI_CLOCK_CONTROL register, so registers are presumably
still accessible

2. gl9763e_runtime_suspend() : ditto

3. sdhci_tegra_runtime_suspend() : disables the functional
clock via clk_disable_unprepare(), so registers are presumably
still accessible

sdhci_msm_runtime_suspend() is different because it also turns
off the interface clock.

But it looks like there are no similar cases.


