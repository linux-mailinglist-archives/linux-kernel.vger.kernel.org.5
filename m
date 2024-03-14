Return-Path: <linux-kernel+bounces-103038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4889687BA38
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A471F242BE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832976CDAB;
	Thu, 14 Mar 2024 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eRIQHige"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5BC6CDA1;
	Thu, 14 Mar 2024 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710407884; cv=none; b=S91kVHvz0yzqJqgQy3OWN4+VZRAQpO3qrawQ0jw/UxNHpcjxHAIxoWuV498kYFmjl2G5FAti1RgIVUQxUsux8rqasB37oIovOMjzvkwN+SA9+gMgo/6Y/r93tX7mAk3bTTPHHrz7CosE31Eo8DrcFNiRFoH9xeopJA4olm45Skc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710407884; c=relaxed/simple;
	bh=dx8srNW2YM17d2PJw0B6UPH8r13xUO8Lw54QEW/ueYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FlkTH1r8Qe3T/M1rs0x0tUtqHX2KQHYlQhnPbNFVUdR8iegjyBNSvPBieViYh+0YxuMNb7bkRQrMRHfIR4yPGlLgj7mr8ucaWqn+tBvSwg+HiczHyL7eMzpiEHMmz/Lrc1pLq4Pi/K2P1DQIA/yoPxdq77+1MwBe75HfRON4olk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eRIQHige; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42E5vISa021556;
	Thu, 14 Mar 2024 09:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=x+n25RRXfOgTMHw/fLF3V41opbcAHyM5Yp3U3NM937g=; b=eR
	IQHiger+rc0egO3mIJG2Q8iRaOvGyP2w/c1iqNsFqEyIaMFVtVVsfxtgRUQYNDzj
	DASrEfwxtOUEnnmjkNyj8J23opxU1O81HiNaEFDpN3rToBS1R9rUZx8WiMIcX68q
	oqQ4o5pxKlCCpEjvgaYaXcdK6MZGgUYrkahABIdCO5rzxogPCpSHU6XhGhdlqL4Y
	psZSa3EviuIo/28T1EhSRdzbQC1xJ8dsEuH02XqIkQvpk3na+Melh9nGyAViRobb
	W1f8k2iYoqD58ZlzRGkamBDzw3veLr5TAm8a6XHtKadPL0XlPH4nAawsqNKy2TGt
	cK6DD007AM/e+s8YRlrg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuuhrrg77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 09:17:55 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42E9HsTv001161
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 09:17:54 GMT
Received: from [10.239.105.140] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Mar
 2024 02:17:52 -0700
Message-ID: <4ca0392d-a9c0-477f-99a6-4245230e6d9a@quicinc.com>
Date: Thu, 14 Mar 2024 17:17:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] virtio-spi: Add virtio SPI driver.
To: Harald Mommer <Harald.Mommer@opensynergy.com>,
        <virtio-dev@lists.oasis-open.org>, Mark Brown <broonie@kernel.org>,
        "Viresh
 Kumar" <viresh.kumar@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <quic_ztu@quicinc.com>, Matti Moell <Matti.Moell@opensynergy.com>,
        "Mikhail Golubev" <Mikhail.Golubev@opensynergy.com>
References: <20240304154342.44021-1-Harald.Mommer@opensynergy.com>
 <20240304154342.44021-4-Harald.Mommer@opensynergy.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <20240304154342.44021-4-Harald.Mommer@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GeysCu5KSvduyCpir3tdInk6cerpfNHa
X-Proofpoint-GUID: GeysCu5KSvduyCpir3tdInk6cerpfNHa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_07,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403140064


Hello,

     Please refer to my comments in virtio_spi_probe function.

On 3/4/2024 11:43 PM, Harald Mommer wrote:
> From: Harald Mommer <harald.mommer@opensynergy.com>
> 
> This is the virtio SPI Linux kernel driver.
> 
> Signed-off-by: Harald Mommer <Harald.Mommer@opensynergy.com>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   MAINTAINERS              |   6 +
>   drivers/spi/Kconfig      |  11 +
>   drivers/spi/Makefile     |   1 +
>   drivers/spi/spi-virtio.c | 474 +++++++++++++++++++++++++++++++++++++++
>   4 files changed, 492 insertions(+)
>   create mode 100644 drivers/spi/spi-virtio.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4f298c4187fb..42bc6ae594ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23384,6 +23384,12 @@ S:	Maintained
>   F:	include/uapi/linux/virtio_snd.h
>   F:	sound/virtio/*
>   
> +VIRTIO SPI DRIVER
> +M:	Harald Mommer <harald.mommer@opensynergy.com>
> +S:	Maintained
> +F:	include/uapi/linux/virtio_spi.h
> +F:	drivers/spi/spi-virtio.c
> +
>   VIRTUAL BOX GUEST DEVICE DRIVER
>   M:	Hans de Goede <hdegoede@redhat.com>
>   M:	Arnd Bergmann <arnd@arndb.de>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index ddae0fde798e..ff06e595679a 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -1125,6 +1125,17 @@ config SPI_UNIPHIER
>   
>   	  If your SoC supports SCSSI, say Y here.
>   
> +config SPI_VIRTIO
> +	tristate "Virtio SPI Controller"
> +	depends on SPI_MASTER && VIRTIO
> +	help
> +	  This enables the Virtio SPI driver.
> +
> +	  Virtio SPI is an SPI driver for virtual machines using Virtio.
> +
> +	  If your Linux is a virtual machine using Virtio, say Y here.
> +	  If unsure, say N.
> +
>   config SPI_XCOMM
>   	tristate "Analog Devices AD-FMCOMMS1-EBZ SPI-I2C-bridge driver"
>   	depends on I2C
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 4ff8d725ba5e..ff2243e44e00 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -146,6 +146,7 @@ spi-thunderx-objs			:= spi-cavium.o spi-cavium-thunderx.o
>   obj-$(CONFIG_SPI_THUNDERX)		+= spi-thunderx.o
>   obj-$(CONFIG_SPI_TOPCLIFF_PCH)		+= spi-topcliff-pch.o
>   obj-$(CONFIG_SPI_UNIPHIER)		+= spi-uniphier.o
> +obj-$(CONFIG_SPI_VIRTIO)		+= spi-virtio.o
>   obj-$(CONFIG_SPI_XCOMM)		+= spi-xcomm.o
>   obj-$(CONFIG_SPI_XILINX)		+= spi-xilinx.o
>   obj-$(CONFIG_SPI_XLP)			+= spi-xlp.o
> diff --git a/drivers/spi/spi-virtio.c b/drivers/spi/spi-virtio.c
> new file mode 100644
> index 000000000000..4f22b03fb678
> --- /dev/null
> +++ b/drivers/spi/spi-virtio.c
> @@ -0,0 +1,474 @@
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
> +#include <linux/of.h>
> +#include <linux/spi/spi.h>
> +#include <linux/stddef.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_ring.h>
> +#include <linux/virtio_spi.h>
> +
> +struct virtio_spi_req {
> +	struct completion completion;
> +	struct spi_transfer_head transfer_head	____cacheline_aligned;
> +	const uint8_t *tx_buf			____cacheline_aligned;
> +	uint8_t *rx_buf				____cacheline_aligned;
> +	struct spi_transfer_result result	____cacheline_aligned;
> +};
> +
> +struct virtio_spi_priv {
> +	/* Virtio SPI message */
> +	struct virtio_spi_req spi_req;
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
> +		complete(&req->completion);
> +}
> +
> +/*
> + *       .   .      .    .    .   .   .   .   .   .
> + * Delay + A +      + B  +    + C + D + E + F + A +
> + *       .   .      .    .    .   .   .   .   .   .
> + *    ___.   .      .    .    .   .   .___.___.   .
> + * CS#   |___.______.____.____.___.___|   .   |___._____________
> + *       .   .      .    .    .   .   .   .   .   .
> + *       .   .      .    .    .   .   .   .   .   .
> + * SCLK__.___.___NNN_____NNN__.___.___.___.___.___.___NNN_______
> + *
> + * NOTE: 1st transfer has two words, the delay between these two words are
> + * 'B' in the diagram.
> + *
> + * A => struct spi_device -> cs_setup
> + * B => max{struct spi_transfer -> word_delay, struct spi_device -> word_delay}
> + *   Note: spi_device and spi_transfer both have word_delay, Linux
> + *         choose the bigger one, refer to _spi_xfer_word_delay_update function
> + * C => struct spi_transfer -> delay
> + * D => struct spi_device -> cs_hold
> + * E => struct spi_device -> cs_inactive
> + * F => struct spi_transfer -> cs_change_delay
> + *
> + * So the corresponding relationship:
> + * A <===> cs_setup_ns (after CS asserted)
> + * B <===> word_delay_ns (no matter with CS)
> + * C+D <===> cs_delay_hold_ns (before CS deasserted)
> + * E+F <===> cs_change_delay_inactive_ns (after CS deasserted, these two
> + * values are also recommended in the Linux driver to be added up)
> + */
> +static int virtio_spi_set_delays(struct spi_transfer_head *th,
> +				 struct spi_device *spi,
> +				 struct spi_transfer *xfer)
> +{
> +	int cs_setup;
> +	int cs_word_delay_xfer;
> +	int cs_word_delay_spi;
> +	int delay;
> +	int cs_hold;
> +	int cs_inactive;
> +	int cs_change_delay;
> +
> +	cs_setup = spi_delay_to_ns(&spi->cs_setup, xfer);
> +	if (cs_setup < 0) {
> +		dev_warn(&spi->dev, "Cannot convert cs_setup\n");
> +		return cs_setup;
> +	}
> +	th->cs_setup_ns = cpu_to_le32((u32)cs_setup);
> +
> +	cs_word_delay_xfer = spi_delay_to_ns(&xfer->word_delay, xfer);
> +	if (cs_word_delay_xfer < 0) {
> +		dev_warn(&spi->dev, "Cannot convert cs_word_delay_xfer\n");
> +		return cs_word_delay_xfer;
> +	}
> +	cs_word_delay_spi = spi_delay_to_ns(&spi->word_delay, xfer);
> +	if (cs_word_delay_spi < 0) {
> +		dev_warn(&spi->dev, "Cannot convert cs_word_delay_spi\n");
> +		return cs_word_delay_spi;
> +	}
> +	if (cs_word_delay_spi > cs_word_delay_xfer)
> +		th->word_delay_ns = cpu_to_le32((u32)cs_word_delay_spi);
> +	else
> +		th->word_delay_ns = cpu_to_le32((u32)cs_word_delay_xfer);
> +
> +	delay = spi_delay_to_ns(&xfer->delay, xfer);
> +	if (delay < 0) {
> +		dev_warn(&spi->dev, "Cannot convert delay\n");
> +		return delay;
> +	}
> +	cs_hold = spi_delay_to_ns(&spi->cs_hold, xfer);
> +	if (cs_hold < 0) {
> +		dev_warn(&spi->dev, "Cannot convert cs_hold\n");
> +		return cs_hold;
> +	}
> +	th->cs_delay_hold_ns = cpu_to_le32((u32)delay + (u32)cs_hold);
> +
> +	cs_inactive = spi_delay_to_ns(&spi->cs_inactive, xfer);
> +	if (cs_inactive < 0) {
> +		dev_warn(&spi->dev, "Cannot convert cs_inactive\n");
> +		return cs_inactive;
> +	}
> +	cs_change_delay = spi_delay_to_ns(&xfer->cs_change_delay, xfer);
> +	if (cs_change_delay < 0) {
> +		dev_warn(&spi->dev, "Cannot convert cs_change_delay\n");
> +		return cs_change_delay;
> +	}
> +	th->cs_change_delay_inactive_ns =
> +		cpu_to_le32((u32)cs_inactive + (u32)cs_change_delay);
> +
> +	return 0;
> +}
> +
> +static int virtio_spi_transfer_one(struct spi_controller *ctrl,
> +				   struct spi_device *spi,
> +				   struct spi_transfer *xfer)
> +{
> +	struct virtio_spi_priv *priv = spi_controller_get_devdata(ctrl);
> +	struct virtio_spi_req *spi_req = &priv->spi_req;
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
> +	ret = virtio_spi_set_delays(th, spi, xfer);
> +	if (ret)
> +		goto msg_done;
> +
> +	/* Set buffers */
> +	spi_req->tx_buf = xfer->tx_buf;
> +	spi_req->rx_buf = xfer->rx_buf;
> +
> +	/* Prepare sending of virtio message */
> +	reinit_completion(&spi_req->completion);
> +
> +	sg_init_one(&sg_out_head, th, sizeof(*th));
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
> +		sgs[outcnt] = &sg_in_payload;
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
> +	if (ret)
> +		goto msg_done;
> +
> +	/* Simple implementation: There can be only one transfer in flight */
> +	virtqueue_kick(priv->vq);
> +
> +	wait_for_completion(&priv->spi_req.completion);
> +
> +	/* Read result from message and translate return code */
> +	switch (priv->spi_req.result.result) {
> +	case VIRTIO_SPI_TRANS_OK:
> +		/* ret is 0 */
> +		break;
> +	case VIRTIO_SPI_PARAM_ERR:
> +		ret = -EINVAL;
> +		break;
> +	case VIRTIO_SPI_TRANS_ERR:
> +		ret = -EIO;
> +		break;
> +	default: /* Protocol violation */
> +		ret = -EIO;
> +		break;
> +	}
> +
> +msg_done:
> +	if (ret)
> +		ctrl->cur_msg->status = ret;
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
> +	if (!ctrl)
> +		return -ENOMEM;
> +
> +	priv = spi_controller_get_devdata(ctrl);
> +	priv->vdev = vdev;
> +	vdev->priv = priv;
> +	dev_set_drvdata(&vdev->dev, ctrl);

     Here should set ctrl->dev.of_node, to scan the child nodes.

> +
> +	init_completion(&priv->spi_req.completion);
> +
> +	err = of_property_read_u32(np, "spi,bus-num", &bus_num);
> +	if (!err && bus_num <= S16_MAX)
> +		ctrl->bus_num = (s16)bus_num;
> +
> +	virtio_spi_read_config(vdev);
> +
> +	ctrl->transfer_one = virtio_spi_transfer_one;
> +
> +	err = virtio_spi_find_vqs(priv);
> +	if (err) {
> +		dev_err(&vdev->dev, "Cannot setup virtqueues\n");
> +		return err;
> +	}
> +
> +	err = spi_register_controller(ctrl);
> +	if (err) {
> +		dev_err(&vdev->dev, "Cannot register controller\n");
> +		goto err_return;
> +	}
> +
> +	board_info.max_speed_hz = priv->max_freq_hz;
> +	/* spi_new_device() currently does not use bus_num but better set it */
> +	board_info.bus_num = (u16)ctrl->bus_num;
> +

     Please refer to my comments above your previous patch, here 
createing spi devices staticly, will introduce conflicts if there is 
virtio spi device node in device-tree.

> +	/* Add chip selects to controller */
> +	for (csi = 0; csi < ctrl->num_chipselect; csi++) {
> +		dev_dbg(&vdev->dev, "Setting up CS=%u\n", csi);
> +		board_info.chip_select = csi;
> +
> +		if (!(priv->mode_func_supported & VIRTIO_SPI_CS_HIGH))
> +			board_info.mode = SPI_MODE_0;
> +		else
> +			board_info.mode = SPI_MODE_0 | SPI_CS_HIGH;
> +
> +		if (!spi_new_device(ctrl, &board_info)) {
> +			dev_err(&vdev->dev, "Cannot setup device %u\n", csi);
> +			spi_unregister_controller(ctrl);
> +			err = -ENODEV;
> +			goto err_return;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_return:
> +	vdev->config->del_vqs(vdev);
> +	return err;
> +}
> +
> +static void virtio_spi_remove(struct virtio_device *vdev)
> +{
> +	struct spi_controller *ctrl = dev_get_drvdata(&vdev->dev);
> +
> +	/* Order: 1.) unregister controller, 2.) remove virtqueue */
> +	spi_unregister_controller(ctrl);
> +	virtio_spi_del_vq(vdev);
> +}
> +
> +static int virtio_spi_freeze(struct virtio_device *vdev)
> +{
> +	struct device *dev = &vdev->dev;
> +	struct spi_controller *ctrl = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = spi_controller_suspend(ctrl);
> +	if (ret) {
> +		dev_warn(dev, "cannot suspend controller (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	virtio_spi_del_vq(vdev);
> +	return 0;
> +}
> +
> +static int virtio_spi_restore(struct virtio_device *vdev)
> +{
> +	struct device *dev = &vdev->dev;
> +	struct spi_controller *ctrl = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = virtio_spi_find_vqs(vdev->priv);
> +	if (ret) {
> +		dev_err(dev, "problem starting vqueue (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = spi_controller_resume(ctrl);
> +	if (ret)
> +		dev_err(dev, "problem resuming controller (%d)\n", ret);
> +
> +	return ret;
> +}
> +
> +static struct virtio_device_id virtio_spi_id_table[] = {
> +	{ VIRTIO_ID_SPI, VIRTIO_DEV_ANY_ID },
> +	{ 0 },
> +};
> +
> +static struct virtio_driver virtio_spi_driver = {
> +	.driver.name = KBUILD_MODNAME,
> +	.driver.owner = THIS_MODULE,
> +	.id_table = virtio_spi_id_table,
> +	.validate = virtio_spi_validate,
> +	.probe = virtio_spi_probe,
> +	.remove = virtio_spi_remove,
> +	.freeze = pm_sleep_ptr(virtio_spi_freeze),
> +	.restore = pm_sleep_ptr(virtio_spi_restore),
> +};
> +
> +module_virtio_driver(virtio_spi_driver);
> +MODULE_DEVICE_TABLE(virtio, virtio_spi_id_table);
> +
> +MODULE_AUTHOR("OpenSynergy GmbH");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Virtio SPI bus driver");

