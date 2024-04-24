Return-Path: <linux-kernel+bounces-157203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42AE8B0E68
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D703286A05
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3293C161314;
	Wed, 24 Apr 2024 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dbba1WZc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D045415B97E;
	Wed, 24 Apr 2024 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972622; cv=none; b=quIOHPgWOyIUJGcV5sLge7ToPA8iHbJc6aTJ+ZIcrUP4XZX+0bEULJN42xVeFqmB6gC65VvYZA595zP+Cqnke4U39m63DYnBLiv0e0rCjcU9FZOzOK26FWTLajR6KDeuPj2oYvdsAqzdHEwfVIuVFZaOula65Dz/W+pQWPUaaAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972622; c=relaxed/simple;
	bh=Rb3e8woeRScQc0FyPXLGuhzPgU+tu+7LVsb9eCDyl8U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=K84S5G40tKDB4Bt+9ZAQT3eGooqwJTZgMjlXz4cbB5kaN08q1kzo0PzDwHCAuumRGu+7v12+ZyKhwV4MQz8fmHc76XameGaf6L6DKNEO5UcxEEyZtEDXXNzrIgu7iALhrTiUIIBR4A15wPIxoeLFsDPAHLIz7Bu/8p5FtLrLgJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Dbba1WZc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OAYs4D016277;
	Wed, 24 Apr 2024 15:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=pTtrhvgb2VDHteJAYAqYBmFdtC5q21PC2G9yrXQWYlM=; b=Db
	ba1WZcrrkPCpDkAUS3RrdRbI9Z1DDsH4Y6yFvXTKvSKovTl4qK0mIDCVXm2FBRtc
	8y4nbVoqhDNEn0c3oCHJx4w47Cj86i+4kwR98drogDNau3+fJcW5wY6dIqSA0uy/
	juTNAXSL8zUzW/8z/Iz3TrxFAk34c2K00NVqs/U8U3LCw1kSM9XwrAkpS/gZ5W+3
	cKbiOB4lQ/xlATQBuS0Q7ygiFB8oNCA4/FDPqIFPGBM1Pehlde/yzx2Hkxo4cwvE
	P4lWMRf4qsqQEdVRs1EIvxH3LODz3HFt4EouDVJiiKgYiT2BenGDX8506u+PoJLV
	WgDxbqEW6N85zcvOST1Q==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9gs855-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 15:30:13 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OFTjcw017165
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 15:29:45 GMT
Received: from [10.253.14.221] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 08:29:43 -0700
Message-ID: <f4bffd0e-0d9b-4fb9-926e-c75a20c92b50@quicinc.com>
Date: Wed, 24 Apr 2024 23:29:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL
 returned by gpiod_get_optional()
From: quic_zijuhu <quic_zijuhu@quicinc.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
CC: Bartosz Golaszewski <brgl@bgdev.pl>,
        Marcel Holtmann
	<marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wren
 Turkal <wt@penguintechs.org>
References: <20240424122932.79120-1-brgl@bgdev.pl>
 <0f8ba1b5-490e-4961-80e2-7942f66730ec@linaro.org>
 <CACMJSeuBCkNyaD60qGVpAq91DqD_OA=tCVEY0t+JNK2vcWBc+Q@mail.gmail.com>
 <d82c2e39-d2b8-4de0-a11a-6ab2420f8f95@quicinc.com>
Content-Language: en-US
In-Reply-To: <d82c2e39-d2b8-4de0-a11a-6ab2420f8f95@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Hc2o8Fc8D-np2iq0E0RP717mFnr9UIN8
X-Proofpoint-ORIG-GUID: Hc2o8Fc8D-np2iq0E0RP717mFnr9UIN8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_12,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=836
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240061

On 4/24/2024 11:24 PM, quic_zijuhu wrote:
> On 4/24/2024 10:52 PM, Bartosz Golaszewski wrote:
>> On Wed, 24 Apr 2024 at 16:46, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 24/04/2024 14:29, Bartosz Golaszewski wrote:
>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>
>>>
>>>>               qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
>>>>               if (IS_ERR(qcadev->susclk)) {
>>>> @@ -2355,10 +2360,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>>>               qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>>>                                              GPIOD_OUT_LOW);
>>>>               if (IS_ERR(qcadev->bt_en)) {
>>>> -                     dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>>>> -                     power_ctrl_enabled = false;
>>>> +                     dev_err(&serdev->dev, "failed to acquire enable gpio\n");
>>>> +                     return PTR_ERR(qcadev->bt_en);
> please think about for QCA2066. if it is returned from here.  BT will
> not working at all.  if you don't return here. i will be working fine
> for every BT functionality.
sorry, correct a type error, it is QCA6390 not QCA2066.
> NAK again by me.
> 
>>>>               }
>>>>
>>>> +             if (!qcadev->bt_en)
>>>> +                     power_ctrl_enabled = false;
>>>
>>> This looks duplicated - you already have such check earlier.
>>>
>>
>> It's under a different switch case!
>>
>> Bartosz
> 
> 


