Return-Path: <linux-kernel+bounces-61220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C448850F17
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C4728185A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F38FBF5;
	Mon, 12 Feb 2024 08:50:57 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD260F51F;
	Mon, 12 Feb 2024 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707727856; cv=none; b=k70Qai4Yq784ivZbjrNTgKP/mVWXMO6HOAiHxKdO7A/dIooMF3Q3yGMRGeOoyzGcMVZaZtaslk7wP1n/oTr6e4aJtdE4MIPRa/yZYm953b3ij5fZ7eVcJSPujnGsJmfhmaaAdzT8PAAZxUCV6e2dPDyAEovpfHd4z7tW7zT7NtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707727856; c=relaxed/simple;
	bh=YaPDIXL/enci4YMm0NeULa97BgyORhah7lo+UD5sAV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VldP8AXmcFYnOW7DSGEUZkHLeAZ4hkv7x9+zcKBw4hnjigJjS6BVg7tBeCOZkiuPjGraHBQ+qjJqoihDL+P4Ux6KtKxfmsq3lmi+lkGiMkXqWYWQXEcXYI3ZItisHwx2PhaO29BuOOuJpm6mN+XwVAOQKCY9ZavBF4tmSnVxtw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED67C433C7;
	Mon, 12 Feb 2024 08:50:54 +0000 (UTC)
Message-ID: <a45a22ec-a9ec-4441-a81e-3354d4be11a8@xs4all.nl>
Date: Mon, 12 Feb 2024 09:50:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/32] media: usb/msi2500: Follow renaming of SPI
 "master" to "controller"
Content-Language: en-US, nl
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
 <d4dc8acc3c4105b9093e97f6337a81d11e6d30ae.1707324794.git.u.kleine-koenig@pengutronix.de>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <d4dc8acc3c4105b9093e97f6337a81d11e6d30ae.1707324794.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/02/2024 19:40, Uwe Kleine-König wrote:
> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
> 
> To be able to remove these compatibility macros push the renaming into
> this driver.
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Regards,

	Hans

> ---
>  drivers/media/usb/msi2500/msi2500.c | 38 ++++++++++++++---------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/media/usb/msi2500/msi2500.c b/drivers/media/usb/msi2500/msi2500.c
> index 9759996ee6a4..5138486abfa0 100644
> --- a/drivers/media/usb/msi2500/msi2500.c
> +++ b/drivers/media/usb/msi2500/msi2500.c
> @@ -107,7 +107,7 @@ struct msi2500_dev {
>  	struct video_device vdev;
>  	struct v4l2_device v4l2_dev;
>  	struct v4l2_subdev *v4l2_subdev;
> -	struct spi_master *master;
> +	struct spi_controller *ctlr;
>  
>  	/* videobuf2 queue and queued buffers list */
>  	struct vb2_queue vb_queue;
> @@ -574,7 +574,7 @@ static void msi2500_disconnect(struct usb_interface *intf)
>  	dev->udev = NULL;
>  	v4l2_device_disconnect(&dev->v4l2_dev);
>  	video_unregister_device(&dev->vdev);
> -	spi_unregister_master(dev->master);
> +	spi_unregister_controller(dev->ctlr);
>  	mutex_unlock(&dev->v4l2_lock);
>  	mutex_unlock(&dev->vb_queue_lock);
>  
> @@ -1136,10 +1136,10 @@ static void msi2500_video_release(struct v4l2_device *v)
>  	kfree(dev);
>  }
>  
> -static int msi2500_transfer_one_message(struct spi_master *master,
> +static int msi2500_transfer_one_message(struct spi_controller *ctlr,
>  					struct spi_message *m)
>  {
> -	struct msi2500_dev *dev = spi_master_get_devdata(master);
> +	struct msi2500_dev *dev = spi_controller_get_devdata(ctlr);
>  	struct spi_transfer *t;
>  	int ret = 0;
>  	u32 data;
> @@ -1154,7 +1154,7 @@ static int msi2500_transfer_one_message(struct spi_master *master,
>  	}
>  
>  	m->status = ret;
> -	spi_finalize_current_message(master);
> +	spi_finalize_current_message(ctlr);
>  	return ret;
>  }
>  
> @@ -1163,7 +1163,7 @@ static int msi2500_probe(struct usb_interface *intf,
>  {
>  	struct msi2500_dev *dev;
>  	struct v4l2_subdev *sd;
> -	struct spi_master *master;
> +	struct spi_controller *ctlr;
>  	int ret;
>  	static struct spi_board_info board_info = {
>  		.modalias		= "msi001",
> @@ -1220,30 +1220,30 @@ static int msi2500_probe(struct usb_interface *intf,
>  	}
>  
>  	/* SPI master adapter */
> -	master = spi_alloc_master(dev->dev, 0);
> -	if (master == NULL) {
> +	ctlr = spi_alloc_master(dev->dev, 0);
> +	if (ctlr == NULL) {
>  		ret = -ENOMEM;
>  		goto err_unregister_v4l2_dev;
>  	}
>  
> -	dev->master = master;
> -	master->bus_num = -1;
> -	master->num_chipselect = 1;
> -	master->transfer_one_message = msi2500_transfer_one_message;
> -	spi_master_set_devdata(master, dev);
> -	ret = spi_register_master(master);
> +	dev->ctlr = ctlr;
> +	ctlr->bus_num = -1;
> +	ctlr->num_chipselect = 1;
> +	ctlr->transfer_one_message = msi2500_transfer_one_message;
> +	spi_controller_set_devdata(ctlr, dev);
> +	ret = spi_register_controller(ctlr);
>  	if (ret) {
> -		spi_master_put(master);
> +		spi_controller_put(ctlr);
>  		goto err_unregister_v4l2_dev;
>  	}
>  
>  	/* load v4l2 subdevice */
> -	sd = v4l2_spi_new_subdev(&dev->v4l2_dev, master, &board_info);
> +	sd = v4l2_spi_new_subdev(&dev->v4l2_dev, ctlr, &board_info);
>  	dev->v4l2_subdev = sd;
>  	if (sd == NULL) {
>  		dev_err(dev->dev, "cannot get v4l2 subdevice\n");
>  		ret = -ENODEV;
> -		goto err_unregister_master;
> +		goto err_unregister_controller;
>  	}
>  
>  	/* Register controls */
> @@ -1276,8 +1276,8 @@ static int msi2500_probe(struct usb_interface *intf,
>  	return 0;
>  err_free_controls:
>  	v4l2_ctrl_handler_free(&dev->hdl);
> -err_unregister_master:
> -	spi_unregister_master(dev->master);
> +err_unregister_controller:
> +	spi_unregister_controller(dev->ctlr);
>  err_unregister_v4l2_dev:
>  	v4l2_device_unregister(&dev->v4l2_dev);
>  err_free_mem:


