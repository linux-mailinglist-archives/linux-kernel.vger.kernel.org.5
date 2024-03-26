Return-Path: <linux-kernel+bounces-118684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 015E688BE00
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC6D1F6118D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD317441F;
	Tue, 26 Mar 2024 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PULiK7P7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AF974414;
	Tue, 26 Mar 2024 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711445182; cv=none; b=PVLzR+ncaze8vkxwoq8NMgss1dOdMUO8VRnYoZ6oiV3RQgxzQRE+0rkzLEfS8uicWSS4mReNTIsOU8ZR6i1HXEhhX/yij7vDKRm5BOLD4wFi4RUVMOerUeYKhfkxt7CbRoigYiA3OrBPEmnHSMI0uGyLXAP8nWY729PtrzqSfzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711445182; c=relaxed/simple;
	bh=BIWWw8INVgFbVYlCNSVCSXKr5nfSD3WYB4BQMSkbYDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L/RNufQctWKDKmDItCspaTZOx+VPd8kmmGLl+3GBbi/NsdZLmQdiOiozEehWxkDDEV4vuFRScZETi7WbHxxrmsb76PrdsaxkCFLCLRk04kzjnggYG2dtzfkdiWngUTPRnw0u37Ezw8CQrNvEYXGeyp1FdPX7C9TuCWqpfdicEcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PULiK7P7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q6RYBx027139;
	Tue, 26 Mar 2024 09:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BMhFHhRNIcpJJMFIKlSsNwlVmtmxYOcIFrOt1gt3EN8=; b=PU
	LiK7P7VRDcvqzvajCbXEV3LDkUsYIZLrSb9CUvxaCXjPbjoi7Vr2DctaEnwTa6T9
	yPKcXSMUQsTTyYGzTbaAvi7EW3vYc4nkQCdfzP3YCaLsPPWezWe4EK7TjaqzdKA2
	mJDAOQGFNTnC3oYfzcIH162YmCAWX5D4EB1oY6AsUhwm/FU24gfkuBwo80g8MzWG
	hTsuNa1Xp8YVZLLy68j4GQevGkZqTR7rpb72ZSvh+jGbv/uCZvG4BLVyLi6jUR+4
	Al56Lc5bHY/S49nRd4MNa4elbGhxUxlsSPh125KudWYkragim1ATD0RK8T69HdCH
	MicEQ0MohZnRUOBCEUFA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3mems4yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 09:26:15 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42Q9QEA3027920
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 09:26:14 GMT
Received: from [10.239.105.140] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Mar
 2024 02:26:12 -0700
Message-ID: <8fbb904c-8d24-4d00-bff8-65f1e4bad5bb@quicinc.com>
Date: Tue, 26 Mar 2024 17:26:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] virtio-spi: Add virtio SPI driver.
To: Viresh Kumar <viresh.kumar@linaro.org>,
        Harald Mommer
	<harald.mommer@opensynergy.com>
CC: Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ztu@quicinc.com>,
        Matti Moell
	<Matti.Moell@opensynergy.com>,
        Mikhail Golubev
	<Mikhail.Golubev@opensynergy.com>
References: <20240304154342.44021-1-Harald.Mommer@opensynergy.com>
 <20240304154342.44021-4-Harald.Mommer@opensynergy.com>
 <99afc631-c02b-42da-a8d4-87c65087f390@quicinc.com>
 <5dedcd26-ed59-415f-b978-87a546a0816d@opensynergy.com>
 <20240320031253.eutoon7l7nkjehft@vireshk-i7>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <20240320031253.eutoon7l7nkjehft@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y5TuuR43vNRe00J5-t0FxUv0bZLb9JeG
X-Proofpoint-ORIG-GUID: y5TuuR43vNRe00J5-t0FxUv0bZLb9JeG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_04,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 suspectscore=0 clxscore=1011 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260064

Hi all,

On 3/20/2024 11:12 AM, Viresh Kumar wrote:
> Hi Harald,
> 
> On 19-03-24, 16:05, Harald Mommer wrote:
>> On 18.03.24 10:39, Haixu Cui wrote:
>>> On 3/4/2024 11:43 PM, Harald Mommer wrote:
>>>> +static int virtio_spi_probe(struct virtio_device *vdev)
>>>> +{
>>>> +    struct device_node *np = vdev->dev.parent->of_node;
>>>> +    struct virtio_spi_priv *priv;
>>>> +    struct spi_controller *ctrl;
>>>> +    int err;
>>>> +    u32 bus_num;
>>>> +    u16 csi;
>>>> +
>>>> +    ctrl = devm_spi_alloc_host(&vdev->dev, sizeof(*priv));
>>>> +    if (!ctrl)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    priv = spi_controller_get_devdata(ctrl);
>>>> +    priv->vdev = vdev;
>>>> +    vdev->priv = priv;
>>>> +    dev_set_drvdata(&vdev->dev, ctrl);
>>>
>>>      ctrl->dev.of_node is not set, so the child node cannot be parsed. I
>>> would say, it's necessary to support the virtio spi device node in the
>>> format:
>>
>>
>> What you most probably want to have here is
>>
>>    ctrl->dev.of_node = np;
> 
> Looking at how i2c-virtio does it, it should be tied to the device itself
> instead of its parent:

Yes, it is
         ctrl->dev.of_node = vdev->dev.of_node;

> 
> ctrl->dev.of_node = vdev->dev.of_node;
> 
>>>      virtio-spi@4b013000 {
>>>          compatible = "virtio,mmio";
>>>          reg = <0x4b013000 0x1000>;
>>>          interrupts = <0 497 4>;
>>>
>>>          spi {
>>>              compatible = "virtio,device2d";
>>>              #address-cells = <1>;
>>>              #size-cells = <0>;
>>>
>>>              spidev {
>>>                  compatible = "xxx";
>>>                  reg = <0>;
>>>                  spi-max-frequency = <100000>;
>>>              };
>>>          };
>>>      };
> 
> Right, some work was done in the past to standardize these compatibles:
> 
> $ git log -p --stat --reverse 0d8c9e7d4b40..694a1116b405
> 
     Here I would like the inner layer "spidev", to match then probe the 
spidev driver, the "reg" is the chip select index. "spi-max-frequency" 
is not necessary, while It doesn't matter.

     You can also customize the inner layer to match your own driver.

     In my test, I set the cs max number as 1, and in device tree node 
inner layer, reg as 0. So certainly spidev driver probed and spidev0.0 
is added successfully.

     But then the driver proceed to the following code, chip select 
index 0 device is created again, the driver fail with log: "chipselect 0 
already in use".

         for (csi = 0; csi < ctrl->num_chipselect; csi++) {
             dev_dbg(&vdev->dev, "Setting up CS=%u\n", csi);
             board_info.chip_select = csi;

             if (!(priv->mode_func_supported & VIRTIO_SPI_CS_HIGH))
                 board_info.mode = SPI_MODE_0;
             else
                 board_info.mode = SPI_MODE_0 | SPI_CS_HIGH;

             if (!spi_new_device(ctrl, &board_info)) {
                 dev_err(&vdev->dev, "Cannot setup device %u\n", csi);
                 spi_unregister_controller(ctrl);
                 err = -ENODEV;
                 goto err_return;
             }
         }


     I hope I made myself clear. Thank you, Harald and Kumar. Best regards.


