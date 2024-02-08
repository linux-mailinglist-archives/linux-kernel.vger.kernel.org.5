Return-Path: <linux-kernel+bounces-58024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF11484E059
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F641F24620
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7124D6F53A;
	Thu,  8 Feb 2024 12:06:51 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844C36F07B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707394011; cv=none; b=JlucmTNqhaYh4f90bFvLvJ2EK9YyIFAbi+/dRvxhRH5ADKWteh7/buVJAThupriSvWUVUNqQWO9grWtcJe3FJyb0Q6IVS9YsZXaaueeuzdnbdEKLyI6m65aTSBlzw2mkIVIvqnTL/SVedwecdwdmFojCTdyA8D3gqdyq71/qH9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707394011; c=relaxed/simple;
	bh=hbz4yGz3Gm5xafHWrAb4Ptx9P1wHviEoXaM0aaStPQ8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXD85LPAJ9oTNDn8gZF6P6DJIhnhAq0Vz8bAEF503C3fLSmU0YrebvwUwapDeoaO/LUfrwe1IOjKg6N8aYeBnHT9w3Iy8e33PTxJqEoLaXtHrjvQzxiOu1JXuy31kyM+Lbge2rgbCHXWzwANLwn/fIxqMYvGnhkZFJto7w4uM04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TVwcH4Sntz6K99r;
	Thu,  8 Feb 2024 20:03:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BB65C1400D9;
	Thu,  8 Feb 2024 20:06:44 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 8 Feb
 2024 12:06:44 +0000
Date: Thu, 8 Feb 2024 12:06:43 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yicong Yang <yangyicong@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>, <hejunhao3@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: Re: [PATCH 1/7] drivers/perf: hisi_pcie: Introduce
 hisi_pcie_pmu_get_filter()
Message-ID: <20240208120643.000042fa@Huawei.com>
In-Reply-To: <20240204074527.47110-2-yangyicong@huawei.com>
References: <20240204074527.47110-1-yangyicong@huawei.com>
	<20240204074527.47110-2-yangyicong@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 4 Feb 2024 15:45:21 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Factor out retrieving of the register value for the
> corresponding event from hisi_pcie_config_filter() into a
> new function hisi_pcie_pmu_get_filter() allowing future reuse.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/perf/hisilicon/hisi_pcie_pmu.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> index b90ba8aca3fa..11a819cd07f2 100644
> --- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> @@ -216,10 +216,8 @@ static void hisi_pcie_pmu_writeq(struct hisi_pcie_pmu *pcie_pmu, u32 reg_offset,
>  	writeq_relaxed(val, pcie_pmu->base + offset);
>  }
>  
> -static void hisi_pcie_pmu_config_filter(struct perf_event *event)
> +static u64 hisi_pcie_pmu_get_filter(struct perf_event *event)
>  {
> -	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
> -	struct hw_perf_event *hwc = &event->hw;
>  	u64 port, trig_len, thr_len, len_mode;
>  	u64 reg = HISI_PCIE_INIT_SET;
>  
> @@ -256,6 +254,15 @@ static void hisi_pcie_pmu_config_filter(struct perf_event *event)
>  	else
>  		reg |= FIELD_PREP(HISI_PCIE_LEN_M, HISI_PCIE_LEN_M_DEFAULT);
>  
> +	return reg;
> +}
> +
> +static void hisi_pcie_pmu_config_filter(struct perf_event *event)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 reg = hisi_pcie_pmu_get_filter(event);
> +
>  	hisi_pcie_pmu_writeq(pcie_pmu, HISI_PCIE_EVENT_CTRL, hwc->idx, reg);
>  }
>  


