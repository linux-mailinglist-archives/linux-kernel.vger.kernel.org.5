Return-Path: <linux-kernel+bounces-86611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440F686C7C8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9116E283C46
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FF07A73A;
	Thu, 29 Feb 2024 11:12:41 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA38579DA7
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709205161; cv=none; b=ATNN+G6ptChZkuIiONn+5/YKTZTf+KW8SI8D30CWHR+ThdyugQp7894YbLjPnStsO8FIj3Fjx6eLeqIgBsPQ9DaHOG1miLf0XiFcO8pbRK5lxybU/vY11N49Rr6OVy2go4IypEAzKwmmQBTYCNh0SidYh7SKpOQl0Q1wtk5vnNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709205161; c=relaxed/simple;
	bh=cxeycH8tCuEZDYMhi2lhSLpSgbgDBpAwm99i4PAz+5I=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rRIu/LCe/zMV7Be5AbJRY/yV8vVCbBncuZzJ3kn/ZZkePgIL3awM8fAit29gb236cSTEihhQJGNYENcK72cFIeF1bk51X11Y3G/gWlj9JNbZLqs/Dcaz18Am4RLxpDd+R8P0AcKW18K7Yj9/PN4uCGi18oTl/rYCSaMbscxcbDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TlpR84Msgz1Q9Nn;
	Thu, 29 Feb 2024 19:10:12 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id D36581402CE;
	Thu, 29 Feb 2024 19:12:28 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 19:12:28 +0800
CC: <will@kernel.org>, <jonathan.cameron@huawei.com>,
	<yangyicong@hisilicon.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>
Subject: Re: [PATCH v2] drivers/perf: hisi: Enable HiSilicon Erratum 162700402
 quirk for HIP09
To: Junhao He <hejunhao3@huawei.com>
References: <20240227125231.53127-1-hejunhao3@huawei.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <4d628dcb-e54f-a6da-83aa-822957674819@huawei.com>
Date: Thu, 29 Feb 2024 19:12:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240227125231.53127-1-hejunhao3@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)

On 2024/2/27 20:52, Junhao He wrote:
> HiSilicon UC PMU v2 suffers the erratum 162700402 that the PMU counter
> cannot be set due to the lack of clock under power saving mode. This will
> lead to error or inaccurate counts. The clock can be enabled by the PMU
> global enabling control.
> 
> This patch tries to fix this by set the UC PMU enable before set event
> period to turn on the clock, and then restore the UC PMU configuration.
> The counter register can hold its value without a clock.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> ---
> 
> Changes since V1:
> - Updated the comment regarding the quirk function.
> - Extract write counter normal to a helper function.
> Link: https://lore.kernel.org/all/20240207094245.34195-1-hejunhao3@huawei.com/
> 

This version looks clearer to me,

Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>

>  drivers/perf/hisilicon/hisi_uncore_uc_pmu.c | 42 ++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
> index 636fb79647c8..481dcc9e8fbf 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
> @@ -287,12 +287,52 @@ static u64 hisi_uc_pmu_read_counter(struct hisi_pmu *uc_pmu,
>  	return readq(uc_pmu->base + HISI_UC_CNTR_REGn(hwc->idx));
>  }
>  
> -static void hisi_uc_pmu_write_counter(struct hisi_pmu *uc_pmu,
> +static bool hisi_uc_pmu_get_glb_en_state(struct hisi_pmu *uc_pmu)
> +{
> +	u32 val;
> +
> +	val = readl(uc_pmu->base + HISI_UC_EVENT_CTRL_REG);
> +	return !!FIELD_GET(HISI_UC_EVENT_GLB_EN, val);
> +}
> +
> +static void hisi_uc_pmu_write_counter_normal(struct hisi_pmu *uc_pmu,
>  				      struct hw_perf_event *hwc, u64 val)
>  {
>  	writeq(val, uc_pmu->base + HISI_UC_CNTR_REGn(hwc->idx));
>  }
>  
> +static void hisi_uc_pmu_write_counter_quirk_v2(struct hisi_pmu *uc_pmu,
> +				      struct hw_perf_event *hwc, u64 val)
> +{
> +	hisi_uc_pmu_start_counters(uc_pmu);
> +	hisi_uc_pmu_write_counter_normal(uc_pmu, hwc, val);
> +	hisi_uc_pmu_stop_counters(uc_pmu);
> +}
> +
> +static void hisi_uc_pmu_write_counter(struct hisi_pmu *uc_pmu,
> +				      struct hw_perf_event *hwc, u64 val)
> +{
> +	bool enable = hisi_uc_pmu_get_glb_en_state(uc_pmu);
> +	bool erratum = uc_pmu->identifier == HISI_PMU_V2;
> +
> +	/*
> +	 * HiSilicon UC PMU v2 suffers the erratum 162700402 that the
> +	 * PMU counter cannot be set due to the lack of clock under power
> +	 * saving mode. This will lead to error or inaccurate counts.
> +	 * The clock can be enabled by the PMU global enabling control.
> +	 * The irq handler and pmu_start() will call the function to set
> +	 * period. If the function under irq context, the PMU has been
> +	 * enabled therefore we set counter directly. Other situations
> +	 * the PMU is disabled, we need to enable it to turn on the
> +	 * counter clock to set period, and then restore PMU enable
> +	 * status, the counter can hold its value without a clock.
> +	 */
> +	if (enable || !erratum)
> +		hisi_uc_pmu_write_counter_normal(uc_pmu, hwc, val);
> +	else
> +		hisi_uc_pmu_write_counter_quirk_v2(uc_pmu, hwc, val);
> +}
> +
>  static void hisi_uc_pmu_enable_counter_int(struct hisi_pmu *uc_pmu,
>  					   struct hw_perf_event *hwc)
>  {
> 

