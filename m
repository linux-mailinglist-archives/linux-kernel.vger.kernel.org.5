Return-Path: <linux-kernel+bounces-42270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B1B83FECF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774C71C23018
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4CF4D595;
	Mon, 29 Jan 2024 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Od8FpcHj"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64094D599
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 07:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706512018; cv=none; b=MFeBQXedt8ki8o4cOq0A9MZvLf7eG2COcCospwCNHptHGflYhe4mJusv7ulBr8YePw3OITiznyUJOu/2QRFWU9BCKPt/qGwflNJpqrQ9onekN9zEn8WJdrz0nHg8jmza7VRjhLEkSrbcwrxcJHUNQFbz+tnOOpAZMLWnzPTmwZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706512018; c=relaxed/simple;
	bh=Oayq8Dw725yp+toQ5K+FgTYhbSISaqGcXBRwdcuOLNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9M5ibO6787bp62oEFa1HntxNTEZ01rfwRhLGiQKKzX7nGJ5XoqEL+8sr21qAJOKL8rMeJDtXgWb/B1OaZHa9SxwIXF9caHucaxFmZwu8mb4td+YhY5D5CflghetCE0s53uK2hy+MmVUEmRmZRufSPCNcrh83dG471o1jCXcjDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Od8FpcHj; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5f69383e653so27556437b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 23:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706512015; x=1707116815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h24MhBfrPnvujPuq7YWAFLnfdfeKZbXlfOwALtS6Rpc=;
        b=Od8FpcHjcNK5j1qPCoG3IW21rlnQpHfREsGLweEKdy8YC7gKvN13HlNvT0y7moxmqa
         rE2OUKtgZSKGbbR17Rcnt82w0OWq7/O8YKVk7xBgYGkuFqlSKeS9JR8q5zcKNNojR6aZ
         isQ3rsHBTFy07dNE6KwWg7lPLymQxUTMtLOVs4ebiawx5PvoOMKmzxVGcDaWNoEEMUwB
         /9BOa8e6sWGdZrxBXL7CwdkMRUSdD67QSzjqrSUmBCI94PA13Zg4G/U7ZmyhbkQBe8Em
         s6E4ZFvWdIQcoklCDZGJOewmthrl/8uhdZoHVrwFaQ/FDlenZ+E4xDIONAUlnC30lWDK
         e2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706512015; x=1707116815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h24MhBfrPnvujPuq7YWAFLnfdfeKZbXlfOwALtS6Rpc=;
        b=w2/VGJwM7aSdsR4uyQEWE+sqDWFUUDaXBfolYU8yS7j5BUun30TdOLziM/0YcbdSsP
         lGT/bzDbdaIU7WrgjXKCsIcBVzdeDqLPVhuMhLNR2iaG2j3gy98mjXuS5yT63X4c4c58
         gA7x+fvtc9uknlCtkJwXQFnrUlCdAAAVK7e5zjlDbDQ1kfKV6GF+BJFhHVyxuZxUBHv+
         cZt879CB1OrPziOBE7rAcMHfbJgKfz53G23ipJe5Dc4MLzDKXyccC3xuK4Eq+XubUtDz
         1jbMB7mDLmPefQ2NUneIPo48x4ecJI5TEMNmQTw/dc48z4KA9ws99M+Ztu78jPgR+KGK
         cWKQ==
X-Gm-Message-State: AOJu0YxFrLAsn+3m5iRWY6+A3wCg6BdiLEZeBXOG8ogcgVs2lPE0i0B3
	jd6UriWqXDp71h0QTPpEBr0IbaHgYDxQYVcMS4RCspU1mqdjOp0OO77W1+914CQ=
X-Google-Smtp-Source: AGHT+IGb4w97KXzlHBM/vCVV+rtYjgAZWUP7MKaeHqFTr9kBXKzN+RVMJE1ZuzN3eh+HdqHV7SlhYA==
X-Received: by 2002:a0d:d817:0:b0:602:d182:93ae with SMTP id a23-20020a0dd817000000b00602d18293aemr3505357ywe.101.1706512015566;
        Sun, 28 Jan 2024 23:06:55 -0800 (PST)
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id y3-20020a63de43000000b005cf9e59477esm5465253pgi.26.2024.01.28.23.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 23:06:54 -0800 (PST)
Date: Mon, 29 Jan 2024 12:36:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Harald Mommer <Harald.Mommer@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, Haixu Cui <quic_haixcui@quicinc.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ztu@quicinc.com,
	Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC PATCH v2 3/3] SPI: Add virtio SPI driver (V10 draft
 specification).
Message-ID: <20240129070652.6ikngp5qft2w5ybh@vireshk-i7>
References: <20240104130129.17823-1-Harald.Mommer@opensynergy.com>
 <20240104130129.17823-4-Harald.Mommer@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104130129.17823-4-Harald.Mommer@opensynergy.com>

Hi Harald,

On 04-01-24, 14:01, Harald Mommer wrote:
> From: Harald Mommer <harald.mommer@opensynergy.com>
> 
> This is the virtio SPI Linux kernel driver compliant to the "PATCH v10"
> draft virtio SPI specification.

Its okay with the RFC, but later on, please remove the versioning part
from the commit log. All such information can be added to the cover
letter.

> Signed-off-by: Harald Mommer <Harald.Mommer@opensynergy.com>
> ---
>  drivers/spi/Kconfig      |  11 +
>  drivers/spi/Makefile     |   1 +
>  drivers/spi/spi-virtio.c | 430 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 442 insertions(+)
>  create mode 100644 drivers/spi/spi-virtio.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index ddae0fde798e..f4f617c79ad7 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -1125,6 +1125,17 @@ config SPI_UNIPHIER
>  
>  	  If your SoC supports SCSSI, say Y here.
>  
> +config SPI_VIRTIO
> +	tristate "Virtio SPI SPI Controller"

s/SPI SPI/SPI/ ?

> +	depends on VIRTIO

Maybe a "depends on SPI_MASTER" as well ? Or "select" ?

> +	help
> +	  This enables the Virtio SPI driver.
> +
> +	  Virtio SPI is an SPI driver for virtual machines using Virtio.
> +
> +	  If your Linux is a virtual machine using Virtio, say Y here.
> +	  If unsure, say N.
> +
>  config SPI_XCOMM
>  	tristate "Analog Devices AD-FMCOMMS1-EBZ SPI-I2C-bridge driver"
>  	depends on I2C
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 4ff8d725ba5e..ff2243e44e00 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -146,6 +146,7 @@ spi-thunderx-objs			:= spi-cavium.o spi-cavium-thunderx.o
>  obj-$(CONFIG_SPI_THUNDERX)		+= spi-thunderx.o
>  obj-$(CONFIG_SPI_TOPCLIFF_PCH)		+= spi-topcliff-pch.o
>  obj-$(CONFIG_SPI_UNIPHIER)		+= spi-uniphier.o
> +obj-$(CONFIG_SPI_VIRTIO)		+= spi-virtio.o
>  obj-$(CONFIG_SPI_XCOMM)		+= spi-xcomm.o
>  obj-$(CONFIG_SPI_XILINX)		+= spi-xilinx.o
>  obj-$(CONFIG_SPI_XLP)			+= spi-xlp.o
> diff --git a/drivers/spi/spi-virtio.c b/drivers/spi/spi-virtio.c
> new file mode 100644
> index 000000000000..39eb38184793
> --- /dev/null
> +++ b/drivers/spi/spi-virtio.c
> @@ -0,0 +1,430 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SPI bus driver for the Virtio SPI controller
> + * Copyright (C) 2023 OpenSynergy GmbH
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/stddef.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_ring.h>
> +#include <linux/version.h>
> +#include <linux/of.h>
> +#include <linux/spi/spi.h>
> +#include <linux/virtio_spi.h>

Alphabetical order is preferred normally for headers.

> +
> +/* virtio_spi private data structure */
> +struct virtio_spi_priv {
> +	/* The virtio device we're associated with */
> +	struct virtio_device *vdev;
> +	/* Pointer to the virtqueue */
> +	struct virtqueue *vq;
> +	/* Copy of config space mode_func_supported */
> +	u32 mode_func_supported;
> +	/* Copy of config space max_freq_hz */
> +	u32 max_freq_hz;
> +};
> +
> +struct virtio_spi_req {
> +	struct completion completion;
> +	struct spi_transfer_head transfer_head	____cacheline_aligned;
> +	const uint8_t *tx_buf			____cacheline_aligned;
> +	uint8_t *rx_buf				____cacheline_aligned;
> +	struct spi_transfer_result result	____cacheline_aligned;
> +};
> +
> +static struct spi_board_info board_info = {
> +	.modalias = "spi-virtio",
> +};
> +
> +static void virtio_spi_msg_done(struct virtqueue *vq)
> +{
> +	struct virtio_spi_req *req;
> +	unsigned int len;
> +
> +	while ((req = virtqueue_get_buf(vq, &len)))

Do we really need a while loop here ? Since for now we are
transferring the messages one by one.

> +		complete(&req->completion);
> +}
> +
> +static int virtio_spi_one_transfer(struct virtio_spi_req *spi_req,
> +				   struct spi_controller *ctrl,
> +				   struct spi_message *msg,
> +				   struct spi_transfer *xfer)
> +{
> +	struct virtio_spi_priv *priv = spi_controller_get_devdata(ctrl);
> +	struct device *dev = &priv->vdev->dev;
> +	struct spi_device *spi = msg->spi;
> +	struct spi_transfer_head *th;
> +	struct scatterlist sg_out_head, sg_out_payload;
> +	struct scatterlist sg_in_result, sg_in_payload;
> +	struct scatterlist *sgs[4];
> +	unsigned int outcnt = 0u;
> +	unsigned int incnt = 0u;
> +	int ret;
> +
> +	th = &spi_req->transfer_head;
> +
> +	/* Fill struct spi_transfer_head */
> +	th->chip_select_id = spi_get_chipselect(spi, 0);
> +	th->bits_per_word = spi->bits_per_word;
> +	/*
> +	 * Got comment: "The virtio spec for cs_change is *not* what the Linux
> +	 * cs_change field does, this will not do the right thing."
> +	 * TODO: Understand/discuss this, still unclear what may be wrong here
> +	 */
> +	th->cs_change = xfer->cs_change;
> +	th->tx_nbits = xfer->tx_nbits;
> +	th->rx_nbits = xfer->rx_nbits;
> +	th->reserved[0] = 0;
> +	th->reserved[1] = 0;
> +	th->reserved[2] = 0;
> +
> +	BUILD_BUG_ON(VIRTIO_SPI_CPHA != SPI_CPHA);
> +	BUILD_BUG_ON(VIRTIO_SPI_CPOL != SPI_CPOL);
> +	BUILD_BUG_ON(VIRTIO_SPI_CS_HIGH != SPI_CS_HIGH);
> +	BUILD_BUG_ON(VIRTIO_SPI_MODE_LSB_FIRST != SPI_LSB_FIRST);
> +
> +	th->mode = cpu_to_le32(spi->mode & (SPI_LSB_FIRST | SPI_CS_HIGH |
> +					    SPI_CPOL | SPI_CPHA));
> +	if ((spi->mode & SPI_LOOP) != 0)
> +		th->mode |= cpu_to_le32(VIRTIO_SPI_MODE_LOOP);
> +
> +	th->freq = cpu_to_le32(xfer->speed_hz);
> +
> +	ret = spi_delay_to_ns(&xfer->word_delay, xfer);
> +	if (ret < 0) {
> +		dev_warn(dev, "Cannot convert word_delay\n");
> +		goto msg_done;
> +	}
> +	th->word_delay_ns = cpu_to_le32((u32)ret);
> +
> +	ret = spi_delay_to_ns(&xfer->delay, xfer);
> +	if (ret < 0) {
> +		dev_warn(dev, "Cannot convert delay\n");
> +		goto msg_done;
> +	}
> +	th->cs_setup_ns = cpu_to_le32((u32)ret);
> +	th->cs_delay_hold_ns = cpu_to_le32((u32)ret);
> +
> +	/* This is the "off" time when CS has to be deasserted for a moment */
> +	ret = spi_delay_to_ns(&xfer->cs_change_delay, xfer);
> +	if (ret < 0) {
> +		dev_warn(dev, "Cannot convert cs_change_delay\n");
> +		goto msg_done;
> +	}
> +	th->cs_change_delay_inactive_ns = cpu_to_le32((u32)ret);
> +
> +	/* Set buffers */
> +	spi_req->tx_buf = xfer->tx_buf;
> +	spi_req->rx_buf = xfer->rx_buf;
> +
> +	/* Prepare sending of virtio message */
> +	init_completion(&spi_req->completion);
> +
> +	sg_init_one(&sg_out_head, &spi_req->transfer_head,
> +		    sizeof(struct spi_transfer_head));

sizeof(*th) ?

> +	sgs[outcnt] = &sg_out_head;
> +	outcnt++;
> +
> +	if (spi_req->tx_buf) {
> +		sg_init_one(&sg_out_payload, spi_req->tx_buf, xfer->len);
> +		sgs[outcnt] = &sg_out_payload;
> +		outcnt++;
> +	}
> +
> +	if (spi_req->rx_buf) {
> +		sg_init_one(&sg_in_payload, spi_req->rx_buf, xfer->len);
> +		sgs[outcnt + incnt] = &sg_in_payload;
> +		incnt++;
> +	}
> +
> +	sg_init_one(&sg_in_result, &spi_req->result,
> +		    sizeof(struct spi_transfer_result));
> +	sgs[outcnt + incnt] = &sg_in_result;
> +	incnt++;
> +
> +	ret = virtqueue_add_sgs(priv->vq, sgs, outcnt, incnt, spi_req,
> +				GFP_KERNEL);
> +
> +msg_done:
> +	if (ret)
> +		msg->status = ret;
> +
> +	return ret;
> +}
> +
> +static int virtio_spi_transfer_one_message(struct spi_controller *ctrl,
> +					   struct spi_message *msg)
> +{
> +	struct virtio_spi_priv *priv = spi_controller_get_devdata(ctrl);
> +	struct virtio_spi_req *spi_req;
> +	struct spi_transfer *xfer;
> +	int ret = 0;
> +
> +	spi_req = kzalloc(sizeof(*spi_req), GFP_KERNEL);
> +	if (!spi_req) {
> +		ret = -ENOMEM;
> +		goto no_mem;
> +	}
> +
> +	/*
> +	 * Simple implementation: Process message by message and wait for each
> +	 * message to be completed by the device side.
> +	 */
> +	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> +		ret = virtio_spi_one_transfer(spi_req, ctrl, msg, xfer);
> +		if (ret)
> +			goto msg_done;
> +
> +		virtqueue_kick(priv->vq);
> +
> +		wait_for_completion(&spi_req->completion);
> +
> +		/* Read result from message */
> +		ret = (int)spi_req->result.result;
> +		if (ret)
> +			goto msg_done;
> +	}
> +
> +msg_done:
> +	kfree(spi_req);
> +no_mem:
> +	msg->status = ret;
> +	spi_finalize_current_message(ctrl);
> +
> +	return ret;
> +}
> +
> +static void virtio_spi_read_config(struct virtio_device *vdev)
> +{
> +	struct spi_controller *ctrl = dev_get_drvdata(&vdev->dev);
> +	struct virtio_spi_priv *priv = vdev->priv;
> +	u8 cs_max_number;
> +	u8 tx_nbits_supported;
> +	u8 rx_nbits_supported;
> +
> +	cs_max_number = virtio_cread8(vdev, offsetof(struct virtio_spi_config,
> +						     cs_max_number));
> +	ctrl->num_chipselect = cs_max_number;
> +
> +	/* Set the mode bits which are understood by this driver */
> +	priv->mode_func_supported =
> +		virtio_cread32(vdev, offsetof(struct virtio_spi_config,
> +					      mode_func_supported));
> +	ctrl->mode_bits = priv->mode_func_supported &
> +			  (VIRTIO_SPI_CS_HIGH | VIRTIO_SPI_MODE_LSB_FIRST);
> +	if ((priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_CPHA_1) != 0)
> +		ctrl->mode_bits |= VIRTIO_SPI_CPHA;
> +	if ((priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_CPOL_1) != 0)
> +		ctrl->mode_bits |= VIRTIO_SPI_CPOL;
> +	if ((priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_LSB_FIRST) != 0)
> +		ctrl->mode_bits |= SPI_LSB_FIRST;
> +	if ((priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_LOOPBACK) != 0)
> +		ctrl->mode_bits |= SPI_LOOP;
> +	tx_nbits_supported =
> +		virtio_cread8(vdev, offsetof(struct virtio_spi_config,
> +					     tx_nbits_supported));
> +	if ((tx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_DUAL) != 0)
> +		ctrl->mode_bits |= SPI_TX_DUAL;
> +	if ((tx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_QUAD) != 0)
> +		ctrl->mode_bits |= SPI_TX_QUAD;
> +	if ((tx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_OCTAL) != 0)
> +		ctrl->mode_bits |= SPI_TX_OCTAL;
> +	rx_nbits_supported =
> +		virtio_cread8(vdev, offsetof(struct virtio_spi_config,
> +					     rx_nbits_supported));
> +	if ((rx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_DUAL) != 0)
> +		ctrl->mode_bits |= SPI_RX_DUAL;
> +	if ((rx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_QUAD) != 0)
> +		ctrl->mode_bits |= SPI_RX_QUAD;
> +	if ((rx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_OCTAL) != 0)
> +		ctrl->mode_bits |= SPI_RX_OCTAL;
> +
> +	ctrl->bits_per_word_mask =
> +		virtio_cread32(vdev, offsetof(struct virtio_spi_config,
> +					      bits_per_word_mask));
> +
> +	priv->max_freq_hz =
> +		virtio_cread32(vdev, offsetof(struct virtio_spi_config,
> +					      max_freq_hz));
> +}
> +
> +static int virtio_spi_find_vqs(struct virtio_spi_priv *priv)
> +{
> +	struct virtqueue *vq;
> +
> +	vq = virtio_find_single_vq(priv->vdev, virtio_spi_msg_done, "spi-rq");
> +	if (IS_ERR(vq))
> +		return (int)PTR_ERR(vq);
> +	priv->vq = vq;
> +	return 0;
> +}
> +
> +/* Function must not be called before virtio_spi_find_vqs() has been run */
> +static void virtio_spi_del_vq(struct virtio_device *vdev)
> +{
> +	virtio_reset_device(vdev);
> +	vdev->config->del_vqs(vdev);
> +}
> +
> +static int virtio_spi_validate(struct virtio_device *vdev)
> +{
> +	/*
> +	 * SPI needs always access to the config space.
> +	 * Check that the driver can access the config space
> +	 */
> +	if (!vdev->config->get) {
> +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +		dev_err(&vdev->dev,
> +			"device does not comply with spec version 1.x\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int virtio_spi_probe(struct virtio_device *vdev)
> +{
> +	struct device_node *np = vdev->dev.parent->of_node;
> +	struct virtio_spi_priv *priv;
> +	struct spi_controller *ctrl;
> +	int err;
> +	u32 bus_num;
> +	u16 csi;
> +
> +	ctrl = devm_spi_alloc_host(&vdev->dev, sizeof(*priv));
> +	if (!ctrl) {
> +		dev_err(&vdev->dev, "Kernel memory exhausted in %s()\n",
> +			__func__);

I thought you agreed to drop it earlier ?

> +		err = -ENOMEM;
> +		goto err_return;
> +	}
> +
> +	priv = spi_controller_get_devdata(ctrl);
> +	priv->vdev = vdev;
> +	vdev->priv = priv;
> +	dev_set_drvdata(&vdev->dev, ctrl);
> +
> +	err = of_property_read_u32(np, "spi,bus-num", &bus_num);
> +	if (!err && bus_num <= S16_MAX)
> +		ctrl->bus_num = (s16)bus_num;
> +
> +	virtio_spi_read_config(vdev);
> +
> +	/* Method to transfer a single SPI message */
> +	ctrl->transfer_one_message = virtio_spi_transfer_one_message;
> +
> +	/* Initialize virtqueues */
> +	err = virtio_spi_find_vqs(priv);
> +	if (err) {
> +		dev_err(&vdev->dev, "Cannot setup virtqueues\n");
> +		goto err_return;
> +	}
> +
> +	err = spi_register_controller(ctrl);
> +	if (err) {

Remove virtqueues here ?

> +		dev_err(&vdev->dev, "Cannot register controller\n");
> +		goto err_return;
> +	}
> +
> +	board_info.max_speed_hz = priv->max_freq_hz;
> +	/* spi_new_device() currently does not use bus_num but better set it */
> +	board_info.bus_num = (u16)ctrl->bus_num;
> +
> +	/* Add chip selects to controller */
> +	for (csi = 0; csi < ctrl->num_chipselect; csi++) {
> +		dev_dbg(&vdev->dev, "Setting up CS=%u\n", csi);
> +		board_info.chip_select = csi;
> +		/* TODO: Discuss setting of board_info.mode */
> +		if (!(priv->mode_func_supported & VIRTIO_SPI_CS_HIGH))
> +			board_info.mode = SPI_MODE_0;
> +		else
> +			board_info.mode = SPI_MODE_0 | SPI_CS_HIGH;
> +		if (!spi_new_device(ctrl, &board_info)) {
> +			dev_err(&vdev->dev, "Cannot setup device %u\n", csi);
> +			err = -ENODEV;

Remove controller and virtqueues here ?

> +			goto err_return;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_return:
> +	return err;
> +}

-- 
viresh

