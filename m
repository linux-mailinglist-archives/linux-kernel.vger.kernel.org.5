Return-Path: <linux-kernel+bounces-130117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5BF897442
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE7328487A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5454D14A4EF;
	Wed,  3 Apr 2024 15:43:52 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1974614A4EC;
	Wed,  3 Apr 2024 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159031; cv=none; b=sBvxPZQpE0KrTWYckjicU7eSt4LySqMoPIpmjbOaDMSwHyziq+eG4wgvwTLDtQd0T3elTlVAELgUBu0NE8mBl/33gZ2WE3SQXIjX69kHXemMBu19xRiPbzAYnE0DDlPfV4rGbRYZLhiYyxuprGBAm2RQ7Ikm5/8MqjNPBWOOzWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159031; c=relaxed/simple;
	bh=EUdlrtYcP9SwWnsQ8olJN/RqljV2d9AFFIWAUVklaZA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJE4qUBxEqmy3Sx+KyqFL98ZKBGeBA68uxCcfcVbToWImp5wUjwveqlOFHmQPxMSagqm6NJHhDF2cj6fYQM6+nF3Wc7jeBFkdq7CCy9kUY2WPB4ZQqS8DXpdYtplM3BejM+RC1Oh1QkGtq/GR9lqwaLiCG/sUFuo+Ib3CtDF2nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V8psd4VBDz6G89M;
	Wed,  3 Apr 2024 23:42:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6461B140516;
	Wed,  3 Apr 2024 23:43:46 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 3 Apr
 2024 16:43:46 +0100
Date: Wed, 3 Apr 2024 16:43:45 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Huang Ying <ying.huang@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: Add debug message for invalid interleave
 granularity
Message-ID: <20240403164345.00002e3d@Huawei.com>
In-Reply-To: <20240402061016.388408-1-ying.huang@intel.com>
References: <20240402061016.388408-1-ying.huang@intel.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue,  2 Apr 2024 14:10:16 +0800
Huang Ying <ying.huang@intel.com> wrote:

> There's no debug message for invalid interleave granularity.  This
> makes it hard to debug related bugs.  So, this is added in this patch.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
That is indeed odd given similar code around it.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/hdm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7d97790b893d..973a27543ed5 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -888,8 +888,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	}
>  	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
>  				 &cxld->interleave_granularity);
> -	if (rc)
> +	if (rc) {
> +		dev_warn(&port->dev,
> +			 "decoder%d.%d: Invalid interleave granularity (ctrl: %#x)\n",
> +			 port->id, cxld->id, ctrl);
>  		return rc;
> +	}
>  
>  	dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
>  		port->id, cxld->id, cxld->hpa_range.start, cxld->hpa_range.end,


