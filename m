Return-Path: <linux-kernel+bounces-32341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16017835A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AAE71C21B77
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D99525D;
	Mon, 22 Jan 2024 05:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kggplw5O"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD2B5224;
	Mon, 22 Jan 2024 05:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705902181; cv=none; b=bMKz/rp/m89R5q+eFabHvTB/53lIvZ8UInBz0L7CjnOlkhpAttxxmQafbGoh56XpTmi6OZMpVU1DevFctvSgZWFpwPnwyCHSY6wURz3L9zFT29GOAJotwpGowiB4nED8AkdwyizYQzV2G47wN9CZuoq3ayJH3/St89vs9rvcgT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705902181; c=relaxed/simple;
	bh=KTDF5JXouoXNHw+T2UtDAb3KDuO0Iau+xrPwTY17JJk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=F5wis64n4kS1UvgxV2exF7oC2V2xvOmYlBUQdaRHcRCocXCCxEHkeTfxPVNoXtk7xzDrDmOmZmlpEemT3IYQ04zS2CxmPZiYLxR0J17tAFO981Go4HtjLWQ0j16plK/bKxeMzO+KvLn2CBnkDhgkBfqVtL/OzF2fXmEeZ13Wfjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kggplw5O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M5VVo1015227;
	Mon, 22 Jan 2024 05:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=EQiuCVaaz2sTka8+zIhbPz3RNN3Z899nVMq77Z4yWrE=; b=kg
	gplw5O/RzYbP0LGTuMMK6uNjs2pNrQujnEPWxiW2JjciHbQhqMEtH04XjrTR8mBP
	nORK/L3LZYu8ubkV3UzJGuwErdxfPjIyGvFAsMz1CY6TtElQM0uF3xguy41bSnE+
	hf3GpKw+ofNdRrCLMDRrY1S3wmg+lfyihML3vaijIDJ2vNWeVL4JKDmavhmrFYYu
	KSh635ZV1/gzTflfeFOFeynSnJzUAHF8dyO4OAzpTPxL6PBk+5geW6uMiALqQsgc
	7Uq/wp3nFZrfrRDXujvdGgs1CGJ4k+NMHp4fsB54rvqDIrAwwY5QBSVSnnMjv2o4
	RHOF8i274uKIFC4HC2Kg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr6jbu0f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 05:42:55 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40M5griV028733
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 05:42:53 GMT
Received: from [10.238.139.231] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 21 Jan
 2024 21:42:50 -0800
Message-ID: <5f6c2be1-faf9-4e64-ab3a-88046d75e2cf@quicinc.com>
Date: Mon, 22 Jan 2024 13:42:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] arm64: dts: qcom: qcm6490-idp: Add definition for
 three LEDs
From: hui liu <quic_huliu@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross
	<agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_fenglinw@quicinc.com>
References: <20240115-lpg-v5-1-3c56f77f9cec@quicinc.com>
 <CAA8EJpoemnXTmshWrArVOCm0GRSkWZ5tH557nbAjRL1Tgg-Dig@mail.gmail.com>
 <e16f5ff1-9b12-4f90-89d5-f95cbfb859e7@quicinc.com>
 <6c29ce72-e303-406a-bb75-5b36b0cd8ee4@linaro.org>
 <44ab50c4-c63b-436c-af46-9b4543181446@quicinc.com>
 <CAA8EJpq8exe6n3OQnreLCsV+BnZKcu24d==rEKup=+n28nnDHw@mail.gmail.com>
 <4c82f1f0-1c5a-498f-9845-b5b26cd76468@quicinc.com>
In-Reply-To: <4c82f1f0-1c5a-498f-9845-b5b26cd76468@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KBf4OPrCMOOYOdHPybzya2e9u6Nl6KTo
X-Proofpoint-ORIG-GUID: KBf4OPrCMOOYOdHPybzya2e9u6Nl6KTo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 mlxlogscore=959 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220039



On 1/18/2024 10:06 AM, hui liu wrote:
> 
> 
> On 1/17/2024 11:41 AM, Dmitry Baryshkov wrote:
>> On Wed, 17 Jan 2024 at 05:02, hui liu <quic_huliu@quicinc.com> wrote:
>>>
>>>
>>>
>>> On 1/15/2024 6:26 PM, Krzysztof Kozlowski wrote:
>>>> On 15/01/2024 11:18, hui liu wrote:
>>>>>
>>>>>
>>>>> On 1/15/2024 5:56 PM, Dmitry Baryshkov wrote:
>>>>>> On Mon, 15 Jan 2024 at 11:48, Hui Liu via B4 Relay
>>>>>> <devnull+quic_huliu.quicinc.com@kernel.org> wrote:
>>>>>>>
>>>>>>> From: Hui Liu <quic_huliu@quicinc.com>
>>>>>>>
>>>>>>> Add definition for three LEDs to make sure they can
>>>>>>> be enabled base on QCOM LPG LED driver.
>>>>>>
>>>>>> The "function" property is still placed incorrectly. Posting the next
>>>>>> iteration before concluding the discussion on the previous one is not
>>>>>> the best idea.
>>>>> Do you mean I should update it as below? Seems there is no consumer to
>>>>> use the function config, do we need to add now?
>>>>
>>>> Paste the output of dtbs_check for your board (or CHECK_DTBS=y for your
>>>> Makefile target).
>>> I checked the dt-binding file of LPG LED, I will update the dts as
>>> below, if you think it's correct, I will push v6.
>>
>> Is there any reason why you are defining three different LEDs instead
>> of multi-led with three components?
> 
Hi Dmitry,
  If there is no other issue, can I push the V6?
Thanks,
Hui

> In the HW design, they are three seprete LEDs, there are three LEDs on 
> device. why do we need to add for multi-led?
> 
> Thanks,
> Hui
>>
>>>
>>> +&pm8350c_pwm {
>>> +       #address-cells = <1>;
>>> +       #size-cells = <0>;
>>> +       status = "okay";
>>> +
>>> +       led@1 {
>>> +               reg = <1>;
>>> +               color = <LED_COLOR_ID_RED>;
>>> +               function = LED_FUNCTION_STATUS;
>>> +       };
>>> +
>>> +       led@2 {
>>> +               reg = <2>;
>>> +               color = <LED_COLOR_ID_GREEN>;
>>> +               function = LED_FUNCTION_STATUS;
>>> +       };
>>> +
>>> +       led@3 {
>>> +               reg = <3>;
>>> +               color = <LED_COLOR_ID_BLUE>;
>>> +               function = LED_FUNCTION_STATUS;
>>> +       };
>>> +};
>>
>>
>>

