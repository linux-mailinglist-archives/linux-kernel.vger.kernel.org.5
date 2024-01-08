Return-Path: <linux-kernel+bounces-19401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B432C826C6A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B1C1C22118
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C12314A84;
	Mon,  8 Jan 2024 11:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vViMx1pl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BE714266;
	Mon,  8 Jan 2024 11:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-154-35-128.elisa-laajakaista.fi [91.154.35.128])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3E010480;
	Mon,  8 Jan 2024 12:17:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1704712631;
	bh=W8CrAfhkyiv7fAUfebx/xn3g2T8W3vPS5MjpkQiP8d0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vViMx1plauJacxy4zx0/u07P9hJchGMkm1rjTEjt+oYUaPvcvILTfWo7lvHoD4CAA
	 K7js/9uVJONTJU89cDq2LN5ecKxAAIIz3x8zPI8J8wvkTi6ic4cfAofan/LLjnKKwf
	 YXrgP+SxCj2C/wsMceRzrEf4olB5Gghux809CSDk=
Message-ID: <7bdd4118-8e09-4599-b8a3-2bbc2d65031e@ideasonboard.com>
Date: Mon, 8 Jan 2024 13:18:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] media: rkisp1: Add and use rkisp1_has_feature()
 macro
Content-Language: en-US
To: Paul Elder <paul.elder@ideasonboard.com>, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Cc: kieran.bingham@ideasonboard.com, umang.jain@ideasonboard.com,
 aford173@gmail.com, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Dafna Hirschfeld <dafna@fastmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>,
 "moderated list:ARM/Rockchip SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240106160221.4183409-1-paul.elder@ideasonboard.com>
 <20240106160221.4183409-2-paul.elder@ideasonboard.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20240106160221.4183409-2-paul.elder@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/01/2024 18:02, Paul Elder wrote:
> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Simplify feature tests with a macro that shortens lines.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Paul Elder <paul.elder@ideasonboard.com>
> Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Tested-by: Adam Ford <aford173@gmail.com>
> ---
>   .../media/platform/rockchip/rkisp1/rkisp1-common.h |  3 +++
>   .../media/platform/rockchip/rkisp1/rkisp1-dev.c    | 14 +++++++-------
>   2 files changed, 10 insertions(+), 7 deletions(-)

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> index b757f75edecf..be6cb42776b0 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> @@ -119,6 +119,9 @@ enum rkisp1_feature {
>   	RKISP1_FEATURE_MIPI_CSI2 = BIT(0),
>   };
>   
> +#define rkisp1_has_feature(rkisp1, feature) \
> +	((rkisp1)->info->features & RKISP1_FEATURE_##feature)
> +
>   /*
>    * struct rkisp1_info - Model-specific ISP Information
>    *
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> index 73cf08a74011..44b753026ba2 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> @@ -207,7 +207,7 @@ static int rkisp1_subdev_notifier_register(struct rkisp1_device *rkisp1)
>   		switch (reg) {
>   		case 0:
>   			/* MIPI CSI-2 port */
> -			if (!(rkisp1->info->features & RKISP1_FEATURE_MIPI_CSI2)) {
> +			if (!rkisp1_has_feature(rkisp1, MIPI_CSI2)) {
>   				dev_err(rkisp1->dev,
>   					"internal CSI must be available for port 0\n");
>   				ret = -EINVAL;
> @@ -361,7 +361,7 @@ static int rkisp1_create_links(struct rkisp1_device *rkisp1)
>   	unsigned int i;
>   	int ret;
>   
> -	if (rkisp1->info->features & RKISP1_FEATURE_MIPI_CSI2) {
> +	if (rkisp1_has_feature(rkisp1, MIPI_CSI2)) {
>   		/* Link the CSI receiver to the ISP. */
>   		ret = media_create_pad_link(&rkisp1->csi.sd.entity,
>   					    RKISP1_CSI_PAD_SRC,
> @@ -413,7 +413,7 @@ static int rkisp1_create_links(struct rkisp1_device *rkisp1)
>   
>   static void rkisp1_entities_unregister(struct rkisp1_device *rkisp1)
>   {
> -	if (rkisp1->info->features & RKISP1_FEATURE_MIPI_CSI2)
> +	if (rkisp1_has_feature(rkisp1, MIPI_CSI2))
>   		rkisp1_csi_unregister(rkisp1);
>   	rkisp1_params_unregister(rkisp1);
>   	rkisp1_stats_unregister(rkisp1);
> @@ -446,7 +446,7 @@ static int rkisp1_entities_register(struct rkisp1_device *rkisp1)
>   	if (ret)
>   		goto error;
>   
> -	if (rkisp1->info->features & RKISP1_FEATURE_MIPI_CSI2) {
> +	if (rkisp1_has_feature(rkisp1, MIPI_CSI2)) {
>   		ret = rkisp1_csi_register(rkisp1);
>   		if (ret)
>   			goto error;
> @@ -629,7 +629,7 @@ static int rkisp1_probe(struct platform_device *pdev)
>   		goto err_unreg_v4l2_dev;
>   	}
>   
> -	if (rkisp1->info->features & RKISP1_FEATURE_MIPI_CSI2) {
> +	if (rkisp1_has_feature(rkisp1, MIPI_CSI2)) {
>   		ret = rkisp1_csi_init(rkisp1);
>   		if (ret)
>   			goto err_unreg_media_dev;
> @@ -650,7 +650,7 @@ static int rkisp1_probe(struct platform_device *pdev)
>   err_unreg_entities:
>   	rkisp1_entities_unregister(rkisp1);
>   err_cleanup_csi:
> -	if (rkisp1->info->features & RKISP1_FEATURE_MIPI_CSI2)
> +	if (rkisp1_has_feature(rkisp1, MIPI_CSI2))
>   		rkisp1_csi_cleanup(rkisp1);
>   err_unreg_media_dev:
>   	media_device_unregister(&rkisp1->media_dev);
> @@ -671,7 +671,7 @@ static void rkisp1_remove(struct platform_device *pdev)
>   	v4l2_async_nf_cleanup(&rkisp1->notifier);
>   
>   	rkisp1_entities_unregister(rkisp1);
> -	if (rkisp1->info->features & RKISP1_FEATURE_MIPI_CSI2)
> +	if (rkisp1_has_feature(rkisp1, MIPI_CSI2))
>   		rkisp1_csi_cleanup(rkisp1);
>   	rkisp1_debug_cleanup(rkisp1);
>   


