Return-Path: <linux-kernel+bounces-8242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D9481B454
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39DF61C245FE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8466BB26;
	Thu, 21 Dec 2023 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnRhr4mf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE4F6979B;
	Thu, 21 Dec 2023 10:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C15DC433C7;
	Thu, 21 Dec 2023 10:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703155793;
	bh=VBUvj5yamNCjbS7Ufz44ltWWNJCZRuRqgGoz+FefXwg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jnRhr4mf7h4Bw3N/PZQ+i5o80xVfCisdmwET/pyaSalcUrpIhu0TyySt8Mw1g29V/
	 2D2MSAE6bxaz7wldi2gCB3+g/ibg1yIGtAnSwNAvHv/fIHPOTjpVUXsSJ9mnY6A0ue
	 21+Phn7ToZunqe6Bsw5dpiWToypWat4VMMgB5xhT3gypwwmO7dWPzfErO5I2W5dNuu
	 R9MlJmyBMJuuqLatWd1BoALFPQBF+YauGmC4VHdLjqoPFHv5hjZNYmoTzmJKuWwWVs
	 if++SqppcI8V2st7tUqHZSjzcwaKcsgCiFINufRsp0pkCzGooHTB3EgoXhbIg1e2eX
	 Pqvg0OW5PSkyg==
Date: Thu, 21 Dec 2023 10:49:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: Use IIO_SEPARATE instead of a hard-coded 0
Message-ID: <20231221104940.7e9d7b0f@jic23-huawei>
In-Reply-To: <1d17f57423172fcb9d9797cfe7c8282f356049c2.1702831285.git.christophe.jaillet@wanadoo.fr>
References: <1d17f57423172fcb9d9797cfe7c8282f356049c2.1702831285.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Dec 2023 17:41:45 +0100
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Use an explicit IIO_SEPARATE instead of 0 for the 'shared_by' parameter
> when calling __iio_add_chan_devattr().
> 
> For some reason, commit 3704432fb1fd ("iio: refactor info mask and ext_info
> attribute creation.") updated only 1 place out of 4.
> Update the remaining ones now.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Makes sense

Applied to the togreg branch of iio.git.

It's fairly unlikely I'll get another pull request out unless the final
6.7 release isn't until after the new year for some reason.

As such, this is probably now 6.9 material

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-buffer.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 09c41e9ccf87..b581a7e80566 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -616,7 +616,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>  				     &iio_show_fixed_type,
>  				     NULL,
>  				     0,
> -				     0,
> +				     IIO_SEPARATE,
>  				     &indio_dev->dev,
>  				     buffer,
>  				     &buffer->buffer_attr_list);
> @@ -629,7 +629,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>  					     &iio_scan_el_show,
>  					     &iio_scan_el_store,
>  					     chan->scan_index,
> -					     0,
> +					     IIO_SEPARATE,
>  					     &indio_dev->dev,
>  					     buffer,
>  					     &buffer->buffer_attr_list);
> @@ -639,7 +639,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>  					     &iio_scan_el_ts_show,
>  					     &iio_scan_el_ts_store,
>  					     chan->scan_index,
> -					     0,
> +					     IIO_SEPARATE,
>  					     &indio_dev->dev,
>  					     buffer,
>  					     &buffer->buffer_attr_list);


