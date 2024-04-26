Return-Path: <linux-kernel+bounces-159856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8469A8B352C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5FFF1C20E98
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA13145348;
	Fri, 26 Apr 2024 10:17:48 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9125A142E9F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126668; cv=none; b=WGm0ZY4NN3zZOvVhSr8A2dTnLyDa684ChrGkO2SlaiGpat9eG7AoDjsjoLj6no9oCsdcuvC8mw/o3n1GxgF1N06e3yKBi9Fmtk9LdQiBdhaMWcKU+EvrIHPmgv+A4Im8wOi/mMwdCoOjPNjJdlnX3bjfwKa8joVuKRCfQkC/gwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126668; c=relaxed/simple;
	bh=UA+qhiN+Bq3ho/gVgazfx7ShJo3fwf6VSLFedZizZpY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z5YxiuNX7AXTck7hWEnEvL2qoN96hgdMy2G/TX1abcrShhIwrXKISzuPOc4u4SHLNiBvp2xCSqbmbjL2HVF+O+clgrQBGKZv0eOYxdRUMTaO+lq1qCzNGNQPQ/iueL+JYfqZShczQbrZHFFpG2J5J5Ygk+CX7whKsGOqn8dSNeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VQpWD5gTqz1yn2v;
	Fri, 26 Apr 2024 18:15:04 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id E71B9140134;
	Fri, 26 Apr 2024 18:17:37 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 18:17:37 +0800
Message-ID: <9c402089-1aed-4777-84af-5879bf72624b@huawei.com>
Date: Fri, 26 Apr 2024 18:17:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <chenhao418@huawei.com>
Subject: Re: [PATCH 3/3] drivers/perf: hisi: hns3: Actually use
 devm_add_action_or_reset()
To: Junhao He <hejunhao3@huawei.com>, <will@kernel.org>,
	<jonathan.cameron@huawei.com>, <yangyicong@huawei.com>
References: <20240425124627.13764-1-hejunhao3@huawei.com>
 <20240425124627.13764-4-hejunhao3@huawei.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240425124627.13764-4-hejunhao3@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600007.china.huawei.com (7.193.23.208)

Reviewed-by: Jijie Shao<shaojijie@huawei.com>

on 2024/4/25 20:46, Junhao He wrote:
> From: Hao Chen <chenhao418@huawei.com>
>
> pci_alloc_irq_vectors() allocates an irq vector. When devm_add_action()
> fails, the irq vector is not freed, which leads to a memory leak.
>
> Replace the devm_add_action with devm_add_action_or_reset to ensure
> the irq vector can be destroyed when it fails.
>
> Fixes: 66637ab137b4 ("drivers/perf: hisi: add driver for HNS3 PMU")
> Signed-off-by: Hao Chen <chenhao418@huawei.com>
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> ---
>   drivers/perf/hisilicon/hns3_pmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/perf/hisilicon/hns3_pmu.c b/drivers/perf/hisilicon/hns3_pmu.c
> index cbdd53b0a034..60062eaa342a 100644
> --- a/drivers/perf/hisilicon/hns3_pmu.c
> +++ b/drivers/perf/hisilicon/hns3_pmu.c
> @@ -1527,7 +1527,7 @@ static int hns3_pmu_irq_register(struct pci_dev *pdev,
>   		return ret;
>   	}
>   
> -	ret = devm_add_action(&pdev->dev, hns3_pmu_free_irq, pdev);
> +	ret = devm_add_action_or_reset(&pdev->dev, hns3_pmu_free_irq, pdev);
>   	if (ret) {
>   		pci_err(pdev, "failed to add free irq action, ret = %d.\n", ret);
>   		return ret;

