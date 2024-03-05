Return-Path: <linux-kernel+bounces-91829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB01871739
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76BBCB219A8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA707F466;
	Tue,  5 Mar 2024 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ADTQ14US"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF837EF02;
	Tue,  5 Mar 2024 07:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709624826; cv=none; b=XqYoDY9s4nAqcY/ADzYcnujI6wiwH/NDMsVwEQqSFbqJp93XVfEDVYGX8XTvIM+fmybpUIgr/RP2nQWqGg8KBjwABmyhBG3XvpDCbSnI7ITNGFAf8ZV1gGA/GMd22+Roqg6YiBCvaBqOcIYj0QQfGhlDBV7b/YliLW1DgcMDf1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709624826; c=relaxed/simple;
	bh=/qasr9z7u/T737mrrPguBWimHiwHsXToDQCi1g3Jtec=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IDRjM3C/KwEs8WYM9kTQsBBwOZUo3ZPTNC+p1b1FKQE8ATJcE+l7+xa813fCZvBX+sBxw6LtRmcKBiBwcuulmrRDOSO02FNYK+29FiPnBqUsx5usuKPPlLGJ4+joizP9udL9auTO6mip6wMiGLFoQ3RLYoBuKfwziXnWbjg/OJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ADTQ14US; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4255SlbA005013;
	Tue, 5 Mar 2024 07:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=sZ6PvWjS312K7oq9+4hnndIA20U/xzpROGr6fX1/dbY=; b=AD
	TQ14USASNroSIQ+PxwbYqop19YeVwJPO+i+P67JJmBKbeFfNaaU28OZ7dApNAQrG
	t/NVlZ59EI2U0X3JwH+Cb15fQIKknP5pFX3ViqwMM9pTTi4gT4xaeE5S1li7FnNF
	BtiDgnDDXbmh64C3jMaS63xU3MZi3bWOk7OjL9y45vnRaPXKxHtqfE0osrlavjP9
	4g6QZa9DZqJaTZB65sB0LT3RDB51R8uXrEgE1/3bP+vj+y2Ri4yZB/yaj18VAgg3
	DUIxW64H3eFnE1VmAHgSgXFjM833qKBVnRhLhmy20x3aRcaGUmursAf1Gws/IZS9
	2TDBkPsyvw08lGNcavVQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnu470f4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 07:46:56 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4257ktE2017094
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 07:46:55 GMT
Received: from [10.253.74.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Mar
 2024 23:46:53 -0800
Message-ID: <c7c939c9-50e0-4d86-bd44-d8b4b90ca14d@quicinc.com>
Date: Tue, 5 Mar 2024 15:46:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [virtio-dev] Re: [RFC PATCH v3 3/3] SPI: Add virtio SPI driver.
Content-Language: en-US
To: Harald Mommer <harald.mommer@opensynergy.com>
CC: <quic_ztu@quicinc.com>, Matti Moell <Matti.Moell@opensynergy.com>,
        "Mikhail Golubev" <Mikhail.Golubev@opensynergy.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>,
        "Mark Brown" <broonie@kernel.org>
References: <20240213135350.5878-1-Harald.Mommer@opensynergy.com>
 <20240213135350.5878-4-Harald.Mommer@opensynergy.com>
 <e2e5a7a0-7a2b-40d3-acf7-6f0b91bd5d40@quicinc.com>
 <2a911f96-eed9-4adc-9043-27fd1d3a7ca2@opensynergy.com>
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <2a911f96-eed9-4adc-9043-27fd1d3a7ca2@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: u4LG9Zb497TrCeLj3ufGMa5CefhS5TjC
X-Proofpoint-GUID: u4LG9Zb497TrCeLj3ufGMa5CefhS5TjC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_05,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050060

Hello Harald,

Thank you for your detailed expatiation. To my knowledge, you took 
Vanilla as the front-end, and VMM is QEMU. Can you please explain 
further how do you test the SPI transfer without the Vanilla userspace 
interface? Thanks again.

Haixu Cui

On 3/4/2024 6:52 PM, Harald Mommer wrote:
> Hello Haixu,
> 
> no, I've not touched spidev.c. Nowhere. I took Vanilla next/stable and 
> applied the patches I sent.
> 
> Run the driver as a (somewhat different but comparable) module on 6.5 on 
> hardware over virtio-MMIO. Probes and goes live.
> 
> Tested on next/stable using a specially adapted QEMU version which 
> allows the usage of our proprietary virtio SPI device over PCI in qemu. 
> Probes and goes live.
> 
> There may be other patches in the setup we're using I'm not aware of but 
> not this one.
> 
> Only in case you're using some locally developed virtio SPI device on 
> qemu which uses PCI transport:
> 
> SPI has ID 45. Means 0x2d.
> 
> https://www.qemu.org/docs/master/specs/pci-ids.html
> 
> 1af4:1040 to 1af4:10ef
> 
>     ID range for modern virtio devices. The PCI device ID is calculated
>     from the virtio device ID by adding the 0x1040 offset. ...
> 
> lspci on qemu:
> 
> / # lspci
> ...
> 00:03.0 Class 00ff: 1af4:106d
> ...
> 
> / #
> 
> You see something like this?
> 
> Regards
> Harald
> 
> On 04.03.24 08:11, Haixu Cui wrote:
>>
>>
>> On 2/13/2024 9:53 PM, Harald Mommer wrote:
>>> +static struct spi_board_info board_info = {
>>> +    .modalias = "spi-virtio",
>>> +};
>>
>> Hi Harald,
>>     Do you add "spi-virtio" in spidev_spi_ids in spidev.c when you 
>> doing the tests, to probe spidev driver?
>>
>> Thanks
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>

