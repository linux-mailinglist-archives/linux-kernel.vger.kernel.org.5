Return-Path: <linux-kernel+bounces-3235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBA381699C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C409B212AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE8611720;
	Mon, 18 Dec 2023 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="tN6LLOb4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB87125A1;
	Mon, 18 Dec 2023 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7EBD357E;
	Mon, 18 Dec 2023 10:15:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1702890931;
	bh=sscAUNZitIjJpr6VsUmcITrudmZ/lgKq7hsyj3Gukj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tN6LLOb4d3ZT1ULBijF6IjtiIzb8WrV3yrzSn0wdbaPQwPZR5CCkTiuR1FWrQ9LOq
	 mloPNfvfcYQEJqN4bfCULUkUgPqxPlTU4y1kZRkmfUVInZK6vWAMLgzauzOB9Dl6wI
	 MaoCb9GHkk03udvhOmgUFwHD/UgvvCCAzEClmmTM=
Date: Mon, 18 Dec 2023 11:16:27 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Dafna Hirschfeld <dafna@fastmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Mikhail Rudenko <mike.rudenko@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Paul Elder <paul.elder@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "media: rkisp1: Drop IRQF_SHARED"
Message-ID: <20231218091627.GA26540@pendragon.ideasonboard.com>
References: <20231218-rkisp-shirq-fix-v1-0-173007628248@ideasonboard.com>
 <20231218-rkisp-shirq-fix-v1-1-173007628248@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231218-rkisp-shirq-fix-v1-1-173007628248@ideasonboard.com>

Hi Tomi,

Thank you for the patch.

On Mon, Dec 18, 2023 at 09:54:00AM +0200, Tomi Valkeinen wrote:
> This reverts commit 85d2a31fe4d9be1555f621ead7a520d8791e0f74.
> 
> The rkisp1 does share interrupt lines on some platforms, after all. Thus
> we need to revert this, and implement a fix for the rkisp1 shared irq
> handling in a follow-up patch.
> 
> Reported-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> Closes: https://lore.kernel.org/all/87o7eo8vym.fsf@gmail.com/
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> index f96f821a7b50..acc559652d6e 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> @@ -559,7 +559,7 @@ static int rkisp1_probe(struct platform_device *pdev)
>  				rkisp1->irqs[il] = irq;
>  		}
>  
> -		ret = devm_request_irq(dev, irq, info->isrs[i].isr, 0,
> +		ret = devm_request_irq(dev, irq, info->isrs[i].isr, IRQF_SHARED,
>  				       dev_driver_string(dev), dev);
>  		if (ret) {
>  			dev_err(dev, "request irq failed: %d\n", ret);

-- 
Regards,

Laurent Pinchart

