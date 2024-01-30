Return-Path: <linux-kernel+bounces-43890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AAC841A6F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82F9285CA7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0016376ED;
	Tue, 30 Jan 2024 03:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jhelIZ8d"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E11381BB;
	Tue, 30 Jan 2024 03:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584920; cv=none; b=bfvHtUxmNLegdXKugHaVdxNax1SkTUyK9Izd90kkEXMs3trV12KROhiuQzb2ROzEKKMWwx72cAetRB90bZGPcZiYdwKtquECK6ivWxb72Q+oRSC2fgKv6aBTdan1Axi1wQcVACzqe1yC6Ndz+cIieyX6gRjhS+h/aYlxNU+l+O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584920; c=relaxed/simple;
	bh=Jg4g46oHnjN6JSJ1dLnWV3troM8bRoNJNukuLAuNbnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rUGLMHJZC+F/y6fk7ePfArhUWC51CdWaDpf02OHZuLefAtdmQBtrDzjsp/BIxGzknpCXEMs9umew9mNLJ22Ssk3VnC8NSZPgO0rK8WVk8b9a9oFw3fgmCTeYSspCyCh2kFW14AoE9enzEhWwmyIJKTOsST7Fq+FkWEF+/TT9VKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jhelIZ8d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U2ZQbM024955;
	Tue, 30 Jan 2024 03:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Wh8zgEaazd7ulGl+NEbArQRq/lSeRWPAHkHYo9Bvu9I=; b=jh
	elIZ8dAg+3D7bzi1FM9iFazOyMVdBm0IXzgFlFc8iZM0slaR7nh4IIvdjxFzoboT
	1vI1Ktr+6H+PKduDwjGvhVe/FDKzM00h9EKe+TQkMto2blhhfRrft10GONMW0qVg
	K8GqrntKr19GjzJGFEh4pCewGkLe6QRr39mNruAQb2yHgK0nrMRZgZFTbaPNqtzj
	fmCuhSHAQKcK/uox7hDIpm9jSexv9o2uJ8goKYygV7UHPEp/q2kv3S9QG0Lo+UMk
	iACc1z456BKetUiRauMtKjBbw5E0AZY32Jnwvzkg37oH9jlLo10IB5jIVfqgBJwD
	EtquV5SFvyKjGan7WhSg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxevds9n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 03:21:51 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U3Lo6u032726
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 03:21:50 GMT
Received: from [10.253.76.230] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 19:21:48 -0800
Message-ID: <6171c1c3-55ba-4f74-ae60-764820cf1caf@quicinc.com>
Date: Tue, 30 Jan 2024 11:21:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/3] SPI: Add virtio SPI driver (V10 draft
 specification).
To: Harald Mommer <Harald.Mommer@opensynergy.com>,
        <virtio-dev@lists.oasis-open.org>, Mark Brown <broonie@kernel.org>,
        "Viresh
 Kumar" <viresh.kumar@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <quic_ztu@quicinc.com>, Matti Moell <Matti.Moell@opensynergy.com>,
        "Mikhail Golubev" <Mikhail.Golubev@opensynergy.com>
References: <20240104130129.17823-1-Harald.Mommer@opensynergy.com>
 <20240104130129.17823-4-Harald.Mommer@opensynergy.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <20240104130129.17823-4-Harald.Mommer@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rBliWEThQDO7wqDQQWFqj4bOO3y6Lcyv
X-Proofpoint-ORIG-GUID: rBliWEThQDO7wqDQQWFqj4bOO3y6Lcyv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401300021



On 1/4/2024 9:01 PM, Harald Mommer wrote:
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
> +	 * Got comment: "The virtio spec for cs_change is*not*  what the Linux
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

Hi Harald,

     spi_device structure has three cs timing members, which will also 
affect the cs timing.

     struct spi_device {
         ...
         struct spi_delay        cs_setup;
         struct spi_delay        cs_hold;
         struct spi_delay        cs_inactive;
         ...
     }

     These three values should also be passed to the backend, for the 
controller to control cs lines.

     spi_device->cs_setup is the delay before cs asserted, 
spi_device->cs_hold with spi_transfer->delay work before cs deasserted, 
and spi_device->cs_inactive with spi_transfer->cs_change_delay take 
effect at the stage after cs deasserted.

Here is the diagram
       .   .      .    .    .   .   .   .   .   .
Delay + A +      + B  +    + C + D + E + F + A +
       .   .      .    .    .   .   .   .   .   .
    ___.   .      .    .    .   .   .___.___.   .
CS#   |___.______.____.____.___.___|   .   |___._____________
       .   .      .    .    .   .   .   .   .   .
       .   .      .    .    .   .   .   .   .   .
SCLK__.___.___NNN_____NNN__.___.___.___.___.___.___NNN_______


NOTE: 1st transfer has two words, the delay betweent these two words are 
'B' in the diagram.

A => struct spi_device -> cs_setup
B => max{struct spi_transfer -> word_delay,
          struct spi_device -> word_delay}
     Note: spi_device and spi_transfer both have word_delay, Linux
          choose the bigger one, refer to _spi_xfer_word_delay_update
          function
C => struct spi_transfer -> delay
D => struct spi_device -> cs_hold
E => struct spi_device -> cs_inactive
F => struct spi_transfer -> cs_change_delay

So the corresponding relationship:
A <===> cs_setup_ns (after CS asserted)
B <===> word_delay_ns (no matter with CS)
C+D <===> cs_delay_hold_ns (before CS deasserted)
E+F <===> cs_change_delay_inactive_ns (after CS deasserted, these two 
values also recommend in Linux driver to be added up)

Best Regards
Haixu


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

