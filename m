Return-Path: <linux-kernel+bounces-146564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B288A674C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9BA1C214EF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D12D85953;
	Tue, 16 Apr 2024 09:38:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477B08526C;
	Tue, 16 Apr 2024 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713260292; cv=none; b=VFoDklmxu0P6ogkJxMBjDglELL1fkPWAE6o2rzo9+LVUb8breGPrAcmmewHCVONkf0MozIzfx7dxDkL7ZV8GeVEUByLd0ZorXW+n2KNt6bW7sjbUDc44LMz1+xGTD22UIKccxg1vMzoDT+Jmj0KhGm2JO5Gu/kZF+KRAPzxp++Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713260292; c=relaxed/simple;
	bh=sr4JscYpSzv5mAB+XPrToKBkcpaYpTMfwvb7Ut+EWtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8z8riMf0gMvwShtTgVEklgIkY7RtGlq8TxyXTJ8KmdjRO2EBG7/6NMN1TgVUISVae8HjFuFFxE7Jo/0ng/E1ZVP6KnMJM/xTQCvlWMk7s+dOPuzYiP2gAEp/QjgYTYy0MQq8XsQU+bqVquORX15daisDVBUGFfF5ezoZUl8Tiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E611B1063;
	Tue, 16 Apr 2024 02:38:38 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 772873F792;
	Tue, 16 Apr 2024 02:38:07 -0700 (PDT)
Message-ID: <0293b97e-8f21-4d0e-966e-1a601bc923b2@arm.com>
Date: Tue, 16 Apr 2024 10:38:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 30/30] hwtracing: hisi_ptt: Assign parent for
 event_source device
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org
Cc: linuxarm@huawei.com, Shaokun Zhang <zhangshaokun@hisilicon.com>,
 Yicong Yang <yangyicong@hisilicon.com>, Jiucheng Xu
 <jiucheng.xu@amlogic.com>, Khuong Dinh <khuong@os.amperecomputing.com>,
 Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Frank Li <Frank.li@nxp.com>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Vineet Gupta <vgupta@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
 linux-fpga@vger.kernel.org, Liang Kan <kan.liang@linux.intel.com>
References: <20240412161057.14099-1-Jonathan.Cameron@huawei.com>
 <20240412161057.14099-31-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240412161057.14099-31-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/04/2024 17:10, Jonathan Cameron wrote:
> Currently the PMU device appears directly under /sys/devices/
> Only root busses should appear there, so instead assign the pmu->dev
> parent to be the PCI device.
> 
> Link: https://lore.kernel.org/linux-cxl/ZCLI9A40PJsyqAmq@kroah.com/
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   drivers/hwtracing/ptt/hisi_ptt.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index 4bf04a977840..3090479a2979 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -1221,6 +1221,7 @@ static int hisi_ptt_register_pmu(struct hisi_ptt *hisi_ptt)
>   
>   	hisi_ptt->hisi_ptt_pmu = (struct pmu) {
>   		.module		= THIS_MODULE,
> +		.parent         = &hisi_ptt->pdev->dev,
>   		.capabilities	= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_NO_EXCLUDE,
>   		.task_ctx_nr	= perf_sw_context,
>   		.attr_groups	= hisi_ptt_pmu_groups,


Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>



