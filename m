Return-Path: <linux-kernel+bounces-2657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC01781600C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686762818B3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F7744C84;
	Sun, 17 Dec 2023 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sarqgtda"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2BA43AAB;
	Sun, 17 Dec 2023 14:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C2EC433C7;
	Sun, 17 Dec 2023 14:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702825068;
	bh=QtsuEf/8ZyE5uK9H7hRidyQ869LmGfE6VYRs1tGvvCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sarqgtdas6GdDzPBQx7mqvPsq1veEDQymFKZ6hpJUaRDhZO69tGoyTLUcIvr1W2xF
	 BmZJNf5q14YHNjCXk8AIHh+cWOchcLm4cNBfHQQMntDMhmcJ9Mm0B93mjEHVwKxuq6
	 Uy36+xr2B1Bjxqohi5rvgaExf9dPNhd9zTHfIvq/STB4AG9n92rCDLBWKbMApiHqSr
	 2REx0WX/S7WscdS8RpzHrt2Ip4BdnuOs1KH66ZvTpn1Dlyle4y1H7v7eBhA2VMQvNJ
	 JjSeQQGb+5nZFbUVFiLt8C+ikqXUQ/GVTyU6fWm416Kf0qDsKeBQ5hGj2Yzw5Le3Q4
	 AIqNAg6IFb85A==
Date: Sun, 17 Dec 2023 14:57:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
 <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
 <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <dan.carpenter@linaro.org>, <dlechner@baylibre.com>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 04/15] iio: adc: ad7091r: Align arguments to function
 call parenthesis
Message-ID: <20231217145731.6639b178@jic23-huawei>
In-Reply-To: <fc71a82d3b4a6bc6f511f27451dbd7a3280a8c95.1702746240.git.marcelo.schmitt1@gmail.com>
References: <cover.1702746240.git.marcelo.schmitt1@gmail.com>
	<fc71a82d3b4a6bc6f511f27451dbd7a3280a8c95.1702746240.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Dec 2023 14:47:01 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Align arguments to function call open parenthesis to comply with the
> Linux kernel coding style.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Applied
> ---
>  drivers/iio/adc/ad7091r-base.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
> index 8aaa854f816f..d3d287d3b953 100644
> --- a/drivers/iio/adc/ad7091r-base.c
> +++ b/drivers/iio/adc/ad7091r-base.c
> @@ -239,8 +239,9 @@ int ad7091r_probe(struct device *dev, const char *name,
>  			return ret;
>  
>  		ret = devm_request_threaded_irq(dev, irq, NULL,
> -				ad7091r_event_handler,
> -				IRQF_TRIGGER_FALLING | IRQF_ONESHOT, name, iio_dev);
> +						ad7091r_event_handler,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT, name, iio_dev);
>  		if (ret)
>  			return ret;
>  	}


