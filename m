Return-Path: <linux-kernel+bounces-81767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EEA8679E4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E486296667
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D9B130E48;
	Mon, 26 Feb 2024 15:11:18 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D56C130E34
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960277; cv=none; b=QpLpnkIJEriGkUgT5UsgtyKqBsUcA82hJUnOBxLC52xE4d4iPP/D4bCdREbN/We7wC3S7iyFSwphChi4dcD8K3EvuO1Ts2v35xsf7LvgNJmkBLYj+PIUlRV/GYG1JqFhvW+UeMLRDZPlT/RWvGYThvIHlBE/gp+UWoX4BjNGN2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960277; c=relaxed/simple;
	bh=Ln0cX2n+IvK9NohheK8A2fdeto9nWPwvxS5WtezTlKw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nI5WIZ06p7GZk3P/ZaV5N5CEyU/HXW7GWgMTrlOBtDdCO2y9rTgIi/lFndq+UzK3lGBDaQ6XVdVLDleaGL/4acKQ/zq01Xn5MZlIzde7kUTejFTZ4p8ckSUtUhXbTwqUuMR5dAfICiwPsTWIvsFtVXw8wpU0ymCps3QGleV0zOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk3qJ6YCkz6J9qf;
	Mon, 26 Feb 2024 23:06:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C74521419FA;
	Mon, 26 Feb 2024 23:11:10 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 15:11:10 +0000
Date: Mon, 26 Feb 2024 15:11:09 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yicong Yang <yangyicong@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>, <hejunhao3@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: Re: [PATCH v2 1/8] drivers/perf: hisi_pcie: Rename
 hisi_pcie_pmu_{config,clear}_filter()
Message-ID: <20240226151109.00003b31@Huawei.com>
In-Reply-To: <20240223103359.18669-2-yangyicong@huawei.com>
References: <20240223103359.18669-1-yangyicong@huawei.com>
	<20240223103359.18669-2-yangyicong@huawei.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Feb 2024 18:33:52 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> hisi_pcie_pmu_{config,clear}_filter() are config/clear HISI_PCIE_EVENT_CTRL
> register which contains not only the filter but also the event code. The
> function names are bit misleading. Rename it to
> hisi_pcie_pmu_{config,clear}_event_ctrl() to reflects their functions
> more accurately.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Definitely an improvement on readability.  As discussed offline I'm
not sure the 'clear' part is strictly right either, but in some
sense that's a separate issue.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/perf/hisilicon/hisi_pcie_pmu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> index b90ba8aca3fa..9760ddde46fd 100644
> --- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> @@ -216,7 +216,7 @@ static void hisi_pcie_pmu_writeq(struct hisi_pcie_pmu *pcie_pmu, u32 reg_offset,
>  	writeq_relaxed(val, pcie_pmu->base + offset);
>  }
>  
> -static void hisi_pcie_pmu_config_filter(struct perf_event *event)
> +static void hisi_pcie_pmu_config_event_ctrl(struct perf_event *event)
>  {
>  	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
>  	struct hw_perf_event *hwc = &event->hw;
> @@ -259,7 +259,7 @@ static void hisi_pcie_pmu_config_filter(struct perf_event *event)
>  	hisi_pcie_pmu_writeq(pcie_pmu, HISI_PCIE_EVENT_CTRL, hwc->idx, reg);
>  }
>  
> -static void hisi_pcie_pmu_clear_filter(struct perf_event *event)
> +static void hisi_pcie_pmu_clear_event_ctrl(struct perf_event *event)
>  {
>  	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
>  	struct hw_perf_event *hwc = &event->hw;
> @@ -505,7 +505,7 @@ static void hisi_pcie_pmu_start(struct perf_event *event, int flags)
>  	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
>  	hwc->state = 0;
>  
> -	hisi_pcie_pmu_config_filter(event);
> +	hisi_pcie_pmu_config_event_ctrl(event);
>  	hisi_pcie_pmu_enable_counter(pcie_pmu, hwc);
>  	hisi_pcie_pmu_enable_int(pcie_pmu, hwc);
>  	hisi_pcie_pmu_set_period(event);
> @@ -526,7 +526,7 @@ static void hisi_pcie_pmu_stop(struct perf_event *event, int flags)
>  	hisi_pcie_pmu_event_update(event);
>  	hisi_pcie_pmu_disable_int(pcie_pmu, hwc);
>  	hisi_pcie_pmu_disable_counter(pcie_pmu, hwc);
> -	hisi_pcie_pmu_clear_filter(event);
> +	hisi_pcie_pmu_clear_event_ctrl(event);
>  	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
>  	hwc->state |= PERF_HES_STOPPED;
>  


