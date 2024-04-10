Return-Path: <linux-kernel+bounces-139034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF0D89FDB3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4AC71F212D9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDA517BB1A;
	Wed, 10 Apr 2024 17:04:17 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79C817BB01
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768656; cv=none; b=n76ZLih+Ael1JqAHseRt9+uDxTZtjxicMI9h1LYmx28EvcrlMpTpxtHuUC+u4Irq+kRzjP93LfmXUlPeprLYJuaLNLPXNa0lmrKxEfO2zEjcA7Klx5Pt8QsA1o74E4aRVI5HjBDmsXeNapfVZv/l/1XaTBwGM0jqbRfOiecnGbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768656; c=relaxed/simple;
	bh=SQ4K/v5QQTv+vk6IVu/x6ynSF4jikLHPm3kjTu9TLvw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CuG90RgBlEIpxJg2gXf8T5Z48sEmKrPft2yR5fuianVbT9otLFtnXk2a/LJHV6GrkA8eOKHwuH5lc+NW4y+o9WAmrDAP5wPv3cglZpA6TM9L7Y5yAktKRx38uwOAOXOJUC62OvcoFq21QhQ/bC0dDRRiXsQ6o2Yg4L1D95WAJqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VF8Jc2Hbqz6JBTr;
	Thu, 11 Apr 2024 01:02:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id AA6751404FC;
	Thu, 11 Apr 2024 01:04:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 18:04:04 +0100
Date: Wed, 10 Apr 2024 18:04:03 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf/arm-cmn: Set PMU device parent
Message-ID: <20240410180403.00004cff@Huawei.com>
In-Reply-To: <25d4428df1ddad966c74a3ed60171cd3ca6c8b66.1712682917.git.robin.murphy@arm.com>
References: <25d4428df1ddad966c74a3ed60171cd3ca6c8b66.1712682917.git.robin.murphy@arm.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue,  9 Apr 2024 18:15:17 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> Now that perf supports giving the PMU device a parent, we can use our
> platform device to make the relationship between CMN instances and PMU
> IDs trivially discoverable, from either nominal direction:
> 
> root@crazy-taxi:~# ls /sys/devices/platform/ARMHC600:00 | grep cmn
> arm_cmn_0
> root@crazy-taxi:~# realpath /sys/bus/event_source/devices/arm_cmn_0/..
> /sys/devices/platform/ARMHC600:00
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Nice.  I'd forgotten all about this :( 

https://lore.kernel.org/all/20230404134225.13408-1-Jonathan.Cameron@huawei.com/
still has a bunch of these + there were many I never looked into.

Guess I should respin that series though probably 50% at least still apply.

J


> ---
>  drivers/perf/arm-cmn.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 7ef9c7e4836b..b2c607cf3ad7 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -2482,6 +2482,7 @@ static int arm_cmn_probe(struct platform_device *pdev)
>  	cmn->cpu = cpumask_local_spread(0, dev_to_node(cmn->dev));
>  	cmn->pmu = (struct pmu) {
>  		.module = THIS_MODULE,
> +		.parent = cmn->dev,
>  		.attr_groups = arm_cmn_attr_groups,
>  		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
>  		.task_ctx_nr = perf_invalid_context,


