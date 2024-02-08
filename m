Return-Path: <linux-kernel+bounces-58044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535E684E094
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084751F2AA6F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333597319C;
	Thu,  8 Feb 2024 12:20:35 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5982873182
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707394834; cv=none; b=sUJJ0jTDOSenM7OobmwHkleseD3uuEuK8P9tuvcn2bAPzhQSBP6ltaKDLqYE8qYABGeAAaAji2FMZQc4a2i3feqPFX/QKny8vqP5crEHLScwjNshGc0sXG+sA059SKnJbodtG/1JVaYCIkHaeIEQPUem5dNQ8+sEf3rH54bVVxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707394834; c=relaxed/simple;
	bh=r+hfrA5qEDDdPsVezjcdkRd1w6ruSzwoWLPssdSs50o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qua8jVDjJ5eg7jehyWWj3b79WqF65ziWBOjV0b85iNiX0v9eVHxs7tvxe/05NDfqa0tTSQjb7Nt2lmg/pkL2Haa9+yBWcZyzs7J+RGvXjAduu8aENFFPjt8tQ7yISduiZxVyLnp0rTlF6/HBUeba6NzRuNkCLLwA9vbl0LCzOM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TVww84svfz6K98Q;
	Thu,  8 Feb 2024 20:17:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9EA0A140136;
	Thu,  8 Feb 2024 20:20:30 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 8 Feb
 2024 12:20:30 +0000
Date: Thu, 8 Feb 2024 12:20:29 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yicong Yang <yangyicong@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>, <hejunhao3@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: Re: [PATCH 3/7] drivers/perf: hisi_pcie: Add more events for
 counting TLP bandwidth
Message-ID: <20240208122029.000005e1@Huawei.com>
In-Reply-To: <20240204074527.47110-4-yangyicong@huawei.com>
References: <20240204074527.47110-1-yangyicong@huawei.com>
	<20240204074527.47110-4-yangyicong@huawei.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 4 Feb 2024 15:45:23 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> A typical PCIe transaction is consisted of various TLP packets in both
> direction. For counting bandwidth only memory read events are exported
> currently. Add memory write and completion counting events of both
> direction to complementation.

complementation?

> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/perf/hisilicon/hisi_pcie_pmu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> index 9623bed93876..83be3390686c 100644
> --- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> @@ -726,10 +726,18 @@ static struct attribute *hisi_pcie_pmu_events_attr[] = {
>  	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_cnt, 0x10210),
>  	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_latency, 0x0011),
>  	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_cnt, 0x10011),
> +	HISI_PCIE_PMU_EVENT_ATTR(rx_mwr_flux, 0x0104),
> +	HISI_PCIE_PMU_EVENT_ATTR(rx_mwr_time, 0x10104),
>  	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_flux, 0x0804),
>  	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_time, 0x10804),
> +	HISI_PCIE_PMU_EVENT_ATTR(rx_cpl_flux, 0x2004),
> +	HISI_PCIE_PMU_EVENT_ATTR(rx_cpl_time, 0x12004),
> +	HISI_PCIE_PMU_EVENT_ATTR(tx_mwr_flux, 0x0105),
> +	HISI_PCIE_PMU_EVENT_ATTR(tx_mwr_time, 0x10105),
>  	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_flux, 0x0405),
>  	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_time, 0x10405),
> +	HISI_PCIE_PMU_EVENT_ATTR(tx_cpl_flux, 0x1005),
> +	HISI_PCIE_PMU_EVENT_ATTR(tx_cpl_time, 0x11005),
>  	NULL
>  };
>  


