Return-Path: <linux-kernel+bounces-81778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5367867A03
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8B02A25B9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F75F128368;
	Mon, 26 Feb 2024 15:17:00 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BFE12BE8B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960619; cv=none; b=rNFaiQf9oCE+QdfZksNM7wnz4nmgb1f9ysxB5qFAKCB/i6MBuQTspO81RRpjTDmTMe9eUaaaJGK4KakN/bH4qx+GR/SGzSyrjVuFeN7xW9dMeids5x6DDyHg17DUN0pm7GzAXOdkc+3i3jaz8U3KCgwTDGNCQKXxd5sGv9b+ZpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960619; c=relaxed/simple;
	bh=jPx5sZ7Fz5IMTGL6E4+8hQDLHon6rlLCOK8VPFDOvFU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WDUJVjBhadcGlwRe+KTxlKEFyMdRctq4v/5tK25mGSX2JlGKWvDJDIynTrmp/mO8j6sTjgNGZNrsIVPLwBdiKCZr9zlVCbzPloUT/9ywJo2xJ8X174ZpqQDl50bLixyqsGh0WviigPGBVTLmnRfQJ3A9OFdE5TKf9Hq7ZcW9YGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk3yv26JLz6K8lH;
	Mon, 26 Feb 2024 23:13:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 91A05141ACB;
	Mon, 26 Feb 2024 23:16:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 15:16:54 +0000
Date: Mon, 26 Feb 2024 15:16:52 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yicong Yang <yangyicong@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>, <hejunhao3@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: Re: [PATCH v2 6/8] drivers/perf: hisi_pcie: Relax the check on
 related events
Message-ID: <20240226151652.00004e88@Huawei.com>
In-Reply-To: <20240223103359.18669-7-yangyicong@huawei.com>
References: <20240223103359.18669-1-yangyicong@huawei.com>
	<20240223103359.18669-7-yangyicong@huawei.com>
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

On Fri, 23 Feb 2024 18:33:57 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Junhao He <hejunhao3@huawei.com>
> 
> If we use two events with the same filter and related event type
> (see the following example), the driver check whether they are related
> events and are in the same group, otherwise the function
> hisi_pcie_pmu_find_related_event() return -EINVAL, then the 2nd event
> cannot count but the 1st event is running, although the PCIe PMU has
> other idle counters.
> 
> In this case, The perf event scheduler will make the two events to
> multiplex a counter, if the user use the formula
> (1st event_value / 2nd event_value) to calculate the bandwidth, he/she
> won't get the correct value, because they are not counting at the
> same period.
> 
> This patch tries to fix this by making the related events to use
> different idle counters if they are not in the same event group.
> 
> And finally, I'm going to say. The related events are best used in the
> same group [1]. There are two ways to know if they are related events.
> a) By event name, such as the latency events "xxx_latency, xxx_cnt" or
> bandwidth events "xxx_flux, xxx_time".
> b) By event type, such as "event=0xXXXX, event=0x1XXXX".
> 
> Use group to count the related events:
>   [1] -e "{pmu_name/xxx_latency,port=1/,pmu_name/xxx_cnt,port=1/}"
> 
>   example:
>     1st event: hisi_pcie0_core1/event=0x804,port=1
>     2nd event: hisi_pcie0_core1/event=0x10804,port=1
> 
>   test cmd:
>     perf stat -e hisi_pcie0_core1/event=0x804,port=1/ \
>                -e hisi_pcie0_core1/event=0x10804,port=1/
> 
>   before patch:
>             25,281      hisi_pcie0_core1/event=0x804,port=1/    (49.91%)
>            470,598      hisi_pcie0_core1/event=0x10804,port=1/    (50.09%)
> 
>   after patch:
>             24,147      hisi_pcie0_core1/event=0x804,port=1/
>            474,558      hisi_pcie0_core1/event=0x10804,port=1/
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>

> ---
>  drivers/perf/hisilicon/hisi_pcie_pmu.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> index b2dde7559639..5b15f3698188 100644
> --- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> @@ -409,14 +409,10 @@ static int hisi_pcie_pmu_find_related_event(struct hisi_pcie_pmu *pcie_pmu,
>  		if (!sibling)
>  			continue;
>  
> -		if (!hisi_pcie_pmu_cmp_event(sibling, event))
> -			continue;
> -
>  		/* Related events must be used in group */
> -		if (sibling->group_leader == event->group_leader)
> +		if (hisi_pcie_pmu_cmp_event(sibling, event) &&
> +		    sibling->group_leader == event->group_leader)
>  			return idx;
> -		else
> -			return -EINVAL;
>  	}
>  
>  	return idx;


