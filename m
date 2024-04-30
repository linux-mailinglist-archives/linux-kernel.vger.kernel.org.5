Return-Path: <linux-kernel+bounces-163899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F03F8B7570
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29B71F219C4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABD713D633;
	Tue, 30 Apr 2024 12:09:45 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786BC12D1FD;
	Tue, 30 Apr 2024 12:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478984; cv=none; b=uIOsWZjTaCroP7Y2GofptKXyGYlFe+6qOphXx3aFAZf6qYNiZgdQ0yIOFY65wSFJlwHncomHA9rBQkqwNdPCFVPeolO5manjfr9LCgPb68G6NnLXf8Yl/UnFSbTmCWrSWYD6rfCLF8/iSCzDQqhc8gB6AeEY9vteRiumaX1jDkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478984; c=relaxed/simple;
	bh=zslLfaH9w6csnOFBx9NGJNP3WC2jq2ePxFc4JLk63dQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hJEOLAbsprmaatDhU9ArYjBszAZ1Nkxf0FuyrrIPwSPIVlHeZkJZFZNAAsNQ4EnO30OGMoYU2T1krYiK6dqZm7RcMY2RUh+8sB5fXY6xE0ItHBvTDTxULHuxlGKPXeU2m25vm/q5GpoJtsoVPaDbQZxX93G10t3YROaDWOIlMEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTJpW2NMhz6GD3l;
	Tue, 30 Apr 2024 20:06:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 52802140B3C;
	Tue, 30 Apr 2024 20:09:36 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 13:09:35 +0100
Date: Tue, 30 Apr 2024 13:09:34 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Andrew Hepp <andrew.hepp@ahepp.dev>, Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] iio: temperature: mcp9600: Share scale by all
 channels
Message-ID: <20240430130934.00006d33@Huawei.com>
In-Reply-To: <20240430120535.46097-3-dima.fedrau@gmail.com>
References: <20240430120535.46097-1-dima.fedrau@gmail.com>
	<20240430120535.46097-3-dima.fedrau@gmail.com>
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

On Tue, 30 Apr 2024 14:05:32 +0200
Dimitri Fedrau <dima.fedrau@gmail.com> wrote:

> Move bit IIO_CHAN_INFO_SCALE from info_mask_separate to
> info_mask_shared_by_all since temperature format is the same for all
> channels.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Whilst this shouldn't be a problem for well behaved userspace,
it is an ABI change so as a general rule we don't 'fix' cases like
this once they have been in a kernel release.

We may be break someone's hand crafted scripts :(

Jonathan

> ---
>  drivers/iio/temperature/mcp9600.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> index e277edb4ae4b..74e0782fb073 100644
> --- a/drivers/iio/temperature/mcp9600.c
> +++ b/drivers/iio/temperature/mcp9600.c
> @@ -28,16 +28,16 @@ static const struct iio_chan_spec mcp9600_channels[] = {
>  		.address = MCP9600_HOT_JUNCTION,
>  		.channel2 = IIO_MOD_TEMP_OBJECT,
>  		.modified = 1,
> -		.info_mask_separate =
> -			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),
>  	},
>  	{
>  		.type = IIO_TEMP,
>  		.address = MCP9600_COLD_JUNCTION,
>  		.channel2 = IIO_MOD_TEMP_AMBIENT,
>  		.modified = 1,
> -		.info_mask_separate =
> -			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),
>  	},
>  };
>  


