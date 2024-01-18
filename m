Return-Path: <linux-kernel+bounces-29646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A231D831142
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1703CB24C05
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F294698;
	Thu, 18 Jan 2024 02:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fy96bxi5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F21323D9;
	Thu, 18 Jan 2024 02:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705543627; cv=none; b=osMuQhtrk7ydj6tukVgKqYE9oQFYnslTivHD+mq6oMqhavrENpRJQ3jnsXq4252O0nVYJw88uwMHA/Zmpz4TvOxiTVldzH5eWhNBtKApqo+5tShV5DxxY7BnLDyDp41GBSb0jDcvnaxmAqUlxnK5gbJzpKXDZKGX7lhBHRBJBUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705543627; c=relaxed/simple;
	bh=eNa6RnBmD6nBUUK+JlWTYmea+WAEaaTuBXMWGIdloyw=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=TJA0xWMYSWufZ8XXxnETSNjSY3F/Sc+jT40JohwFcdpuwrkT8xS197Wees8NG8Vjm7ijq1WfOnzVSCroLMNmLFG9XBy9mHaIAdf6iW6Ved2hCE0lIoAlaXr0DHu9veYFTPVRFyDvphTxVbqmGKCKfYhPvJj+y09Vb/agEMSxG9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fy96bxi5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40I1CTKw032163;
	Thu, 18 Jan 2024 02:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=eJ775hQQr50RGfFRrsXBtSjR/Rhx1p4HhwQ06OFvHNM=; b=fy
	96bxi5SlQXZ4d0gGhzvAjYTLZIFbUvUCcvo7tRwlCYjeLckToxG3XvHlUXlAvamu
	AxJ+KUVBjpsiZpBeIuLaChYUyDzH4avYWzcjnTcRYx4esT9rAuYqkCm3P05Ztq8/
	d2tr1cFUR1LrUGKMHW6+cwpYL2al2ncm7Kf+veyOoXezLrlbohMdQ9bN/j7losH+
	umSG5YluBlxfmSJQdcWz6DjuwJaZ39BY5Nlf18c0SOavUnunQ69Tb2WbdJMU1MLn
	34S7R+PFcQ0xP9caoZ7/C4zOX29/YuSEzvLTi5m9T0tYY2J4pKnsxcvN4AIYLAIN
	XqsCHopfDJQVoNgLc80A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vpejp1rg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 02:06:59 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40I26wOc004919
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 02:06:58 GMT
Received: from [10.238.139.231] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Jan
 2024 18:06:54 -0800
Message-ID: <4c82f1f0-1c5a-498f-9845-b5b26cd76468@quicinc.com>
Date: Thu, 18 Jan 2024 10:06:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] arm64: dts: qcom: qcm6490-idp: Add definition for
 three LEDs
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
From: hui liu <quic_huliu@quicinc.com>
In-Reply-To: <CAA8EJpq8exe6n3OQnreLCsV+BnZKcu24d==rEKup=+n28nnDHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MX9vm9BR0clH7AOyHGumzPF0KEVobwiq
X-Proofpoint-GUID: MX9vm9BR0clH7AOyHGumzPF0KEVobwiq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_14,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=944 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401180012



On 1/17/2024 11:41 AM, Dmitry Baryshkov wrote:
> On Wed, 17 Jan 2024 at 05:02, hui liu <quic_huliu@quicinc.com> wrote:
>>
>>
>>
>> On 1/15/2024 6:26 PM, Krzysztof Kozlowski wrote:
>>> On 15/01/2024 11:18, hui liu wrote:
>>>>
>>>>
>>>> On 1/15/2024 5:56 PM, Dmitry Baryshkov wrote:
>>>>> On Mon, 15 Jan 2024 at 11:48, Hui Liu via B4 Relay
>>>>> <devnull+quic_huliu.quicinc.com@kernel.org> wrote:
>>>>>>
>>>>>> From: Hui Liu <quic_huliu@quicinc.com>
>>>>>>
>>>>>> Add definition for three LEDs to make sure they can
>>>>>> be enabled base on QCOM LPG LED driver.
>>>>>
>>>>> The "function" property is still placed incorrectly. Posting the next
>>>>> iteration before concluding the discussion on the previous one is not
>>>>> the best idea.
>>>> Do you mean I should update it as below? Seems there is no consumer to
>>>> use the function config, do we need to add now?
>>>
>>> Paste the output of dtbs_check for your board (or CHECK_DTBS=y for your
>>> Makefile target).
>> I checked the dt-binding file of LPG LED, I will update the dts as
>> below, if you think it's correct, I will push v6.
> 
> Is there any reason why you are defining three different LEDs instead
> of multi-led with three components?

In the HW design, they are three seprete LEDs, there are three LEDs on 
device. why do we need to add for multi-led?

Thanks,
Hui
> 
>>
>> +&pm8350c_pwm {
>> +       #address-cells = <1>;
>> +       #size-cells = <0>;
>> +       status = "okay";
>> +
>> +       led@1 {
>> +               reg = <1>;
>> +               color = <LED_COLOR_ID_RED>;
>> +               function = LED_FUNCTION_STATUS;
>> +       };
>> +
>> +       led@2 {
>> +               reg = <2>;
>> +               color = <LED_COLOR_ID_GREEN>;
>> +               function = LED_FUNCTION_STATUS;
>> +       };
>> +
>> +       led@3 {
>> +               reg = <3>;
>> +               color = <LED_COLOR_ID_BLUE>;
>> +               function = LED_FUNCTION_STATUS;
>> +       };
>> +};
> 
> 
> 

