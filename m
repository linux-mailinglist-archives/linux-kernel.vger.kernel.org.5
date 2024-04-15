Return-Path: <linux-kernel+bounces-144457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BE18A469F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC23FB222FF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 01:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0CDD29E;
	Mon, 15 Apr 2024 01:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ruHuLy47"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F54363;
	Mon, 15 Apr 2024 01:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713145545; cv=none; b=I6uyhA+o3yPKIYzWL3e/LqZYjmm9eVujQ7eS4Su4VuvXWdriXQfKerA5sM2MJz/V0Rw1KWgcDFopyEVsqZvnZRQF+28ZIu9K5O89VrzDyfinR+LRJMcWPvwb+u8rYKBDDuvOrhLVGq0YS2AhyT5WPE4ZKEzXvN99pwjFeiiaGhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713145545; c=relaxed/simple;
	bh=0YWZ2A184fsDV44PPyrrr7nHujDvo1+aVfAsX5yUCsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kt8lRlBoG/ZU92sZ4DJTCrQVPLOuop7Tpc9iOjSMOqocaRTzEqrJh5gqKUAcATb3+NZ1vtRC8R9YXw7cqWdgExJ9bB49pcKNR1njuBZQjPRQtGaULsnWShl6mjV4L4F/B7ZdDwzHEyYP0v9Zi91mssblC3JrYyf4K1d1PZvyBkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ruHuLy47; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713145539; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VZoYcT8Kw7oToFqc5+hsYWgwEaxDZpmfKFRgJXcoigA=;
	b=ruHuLy47+g6fbj1cJwAfsCu6A/8vnklN4F3AZ+IYQtP/w+HD21mxkGe/ibRUEEIH991kxqHXGURcgjTmXdZPbRTxrwG7lTF2EcwY7Gihq5X/73ud0kI/tXKem0q9U7+ccIe8jmYwB1F87Oj956s0QD4M44JZViDa9pcH9owpegs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W4TszTI_1713145537;
Received: from 30.97.56.61(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W4TszTI_1713145537)
          by smtp.aliyun-inc.com;
          Mon, 15 Apr 2024 09:45:38 +0800
Message-ID: <1cc8e549-11a7-463a-ad74-527ccacb744a@linux.alibaba.com>
Date: Mon, 15 Apr 2024 09:45:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mmc: sdhci-sprd: Constify struct sdhci_ops
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240414-mmc-const-sdhci-ops-v2-0-262f81faadac@kernel.org>
 <20240414-mmc-const-sdhci-ops-v2-3-262f81faadac@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240414-mmc-const-sdhci-ops-v2-3-262f81faadac@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/14 22:07, Krzysztof Kozlowski wrote:
> The local struct sdhci_ops can be made const for code safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   drivers/mmc/host/sdhci-sprd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 685b1c648901..8776f4287119 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -439,7 +439,7 @@ static void sdhci_sprd_set_power(struct sdhci_host *host, unsigned char mode,
>   	}
>   }
>   
> -static struct sdhci_ops sdhci_sprd_ops = {
> +static const struct sdhci_ops sdhci_sprd_ops = {
>   	.read_l = sdhci_sprd_readl,
>   	.write_l = sdhci_sprd_writel,
>   	.write_w = sdhci_sprd_writew,
> 

