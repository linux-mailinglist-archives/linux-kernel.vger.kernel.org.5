Return-Path: <linux-kernel+bounces-105889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DA687E60B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88E07B21A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A88B2C68D;
	Mon, 18 Mar 2024 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BdPTMYsb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFE02C684;
	Mon, 18 Mar 2024 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754800; cv=none; b=oZXPGO7p5VdfVJkk8bEgQ6NWtznyDbxK5w0vdOWXWY7VqOCKuYZsrb37xynfe5wFvcOi4dDTcTVhZl4pgP20Ug1hVqkEQ25I1WshgUqemMWM/1KgJARUg71CDbi4pNLJOaSRvHB80rnC8cfZyMc8USXWCc8Q2j2L/MfXY6V+SBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754800; c=relaxed/simple;
	bh=50YaI2n0VuOEu3tt9ntCWB5AQam/u5Dxjxpq9od6GyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OB/8clsnszbecuj5n0VSb1TTPO94883A4HH/ZCzar3maRi5gTsyn8r+saOeWera05766pNvVYZVShvAY0sWOPb/ZBsgpFMFF80y/1yEBUJcuaibxk8LJ0kq7pohd75n40dCATe77KwMZQbwECC4xEx6ZXHGR3yZE5WoGzOI9k5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BdPTMYsb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42I90DXA027784;
	Mon, 18 Mar 2024 09:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=yRZ8sDTWNByeUKFCqiJMw3MpR+3Matyzrhx/mNen+rA=; b=Bd
	PTMYsbQgC9MCySfVdyIN4HK556B3rxFAo5wUYQnGqNq5eroarQe4LBaZQpTmBCiz
	WgKk6ogSQB9cUl7lAsbd7qnh3/Qulw2JOhTFQ4TEb9Z9esQvFzfhi9crI9pZsG72
	VNTwTxzw5XARUIOmsQlUiBMKUTYq66XYtnTMcqATBsTq7PTm8a44t5jNscjz9307
	KxzJKVc+/MIOYYala5UEXokso2XJtj9MVKgPF5GjmnPeBj6BKwRgpX2sQ1nAOEKJ
	jVySvkTfVJ/oOs6D1V31V8nJf/lgYAm/1W6L0GXnDPqvcLoD09jsFvspuz1d64Gq
	rBMDJugWqKxkjjKaosBQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wwxtb9jkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 09:39:51 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42I9do88007438
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 09:39:50 GMT
Received: from [10.239.105.140] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Mar
 2024 02:39:47 -0700
Message-ID: <99afc631-c02b-42da-a8d4-87c65087f390@quicinc.com>
Date: Mon, 18 Mar 2024 17:39:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] virtio-spi: Add virtio SPI driver.
To: Harald Mommer <Harald.Mommer@opensynergy.com>,
        Mark Brown
	<broonie@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, <linux-spi@vger.kernel.org>,
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
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9448SFoxk27IclCQEEm6QTKuAfBHbmqv
X-Proofpoint-ORIG-GUID: 9448SFoxk27IclCQEEm6QTKuAfBHbmqv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403180072

Hello,

     As Mark recommended, I reserve the virtio_spi_probe function only 
and list my comments.

On 3/4/2024 11:43 PM, Harald Mommer wrote:
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

     ctrl->dev.of_node is not set, so the child node cannot be parsed. I 
would say, it's necessary to support the virtio spi device node in the 
format:

     virtio-spi@4b013000 {
         compatible = "virtio,mmio";
         reg = <0x4b013000 0x1000>;
         interrupts = <0 497 4>;

         spi {
             compatible = "virtio,device2d";
             #address-cells = <1>;
             #size-cells = <0>;

             spidev {
                 compatible = "xxx";
                 reg = <0>;
                 spi-max-frequency = <100000>;
             };
         };
     };
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
> +	/* Add chip selects to controller */

         Creating the spi devices here statically, will introduce 
conflicts if the same spi devices also in the device-tree.

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

