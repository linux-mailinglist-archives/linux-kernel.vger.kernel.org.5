Return-Path: <linux-kernel+bounces-163900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F15A08B7578
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66A61F21893
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F2613D88E;
	Tue, 30 Apr 2024 12:11:09 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14EE168A9;
	Tue, 30 Apr 2024 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479068; cv=none; b=OU0wnxaCfWq/9yS51Ow0sm8kVi1YWZfzy65fdCRGjQkuYHM3WoeLepucPrF71kgFxuVMuPl3KRaxZ1OzmbNEbggWZR0Is6a2A/TpJHw/183nXxdZWuK0aAbopadJV0aEgW6fF3QrDBx8f4P8/wQZLnF2KeJ0yFAhVbKxAlL8kYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479068; c=relaxed/simple;
	bh=+aD063Qj7irVTO2scLS85x1LZw91KcVom8VJuUE4upI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EOzkET/aKkL5h4Y6rDKXwUSuBo5ywsjTbBdpdUPWwitTYQkqelB+PBQsK4VuDbAkzE9OeE40nfm4F0KEESh2Dozv9tANsSRVLdz/5TENpxjng7F3TY0Sy9BBSbUYDOL54osD3906wzvpo08cfSlF1xfjC2gKDn2sQsD+SoKPqX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTJts6b6jz6K8sw;
	Tue, 30 Apr 2024 20:10:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BCAF0140B2A;
	Tue, 30 Apr 2024 20:11:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 13:11:03 +0100
Date: Tue, 30 Apr 2024 13:11:02 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Andrew Hepp <andrew.hepp@ahepp.dev>, Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] iio: temperature: mcp9600: set channel2 member
Message-ID: <20240430131102.00005e58@Huawei.com>
In-Reply-To: <20240430120535.46097-2-dima.fedrau@gmail.com>
References: <20240430120535.46097-1-dima.fedrau@gmail.com>
	<20240430120535.46097-2-dima.fedrau@gmail.com>
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

On Tue, 30 Apr 2024 14:05:31 +0200
Dimitri Fedrau <dima.fedrau@gmail.com> wrote:

> Set channel2 member of channel 0 to IIO_MOD_TEMP_OBJECT and set modified
> member to 1.
This an ABI change, so needs a strong argument + must be a fix 
rather than an improvement.  So why does this need to change?

Jonathan

> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---
>  drivers/iio/temperature/mcp9600.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> index 7a3eef5d5e75..e277edb4ae4b 100644
> --- a/drivers/iio/temperature/mcp9600.c
> +++ b/drivers/iio/temperature/mcp9600.c
> @@ -26,6 +26,8 @@ static const struct iio_chan_spec mcp9600_channels[] = {
>  	{
>  		.type = IIO_TEMP,
>  		.address = MCP9600_HOT_JUNCTION,
> +		.channel2 = IIO_MOD_TEMP_OBJECT,
> +		.modified = 1,
>  		.info_mask_separate =
>  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>  	},


