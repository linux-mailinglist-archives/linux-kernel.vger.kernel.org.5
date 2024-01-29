Return-Path: <linux-kernel+bounces-42077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB87983FC01
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8FE28234B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB77CEADD;
	Mon, 29 Jan 2024 02:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ggNxKTpv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB42DF46;
	Mon, 29 Jan 2024 02:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706494026; cv=none; b=QUwhjMqtuQe8t+ZQaDdrSfmQmIyEdGS5HI1gJNaid/+AlMs6kHZRWJKeRv31ngtUzKD3MMez7bJjW9EKbndUYB3hzVN/WIJgI7KOEz7KyKkidDJmIXbSt/0zkC4MIFGEwPPJHtKkgNl775x/kIf7r3Ewi4qsQ2l+S/Hu6oAkMaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706494026; c=relaxed/simple;
	bh=3i6cKFeIQ1ytJAt62TE0JlxJs2NNSDs63DVrFTeKMcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SRrU4cZSTeYU5tMMYCAjoo6jjxLlgqTWdcyDJrzXbN2Z59QFtvzgp1XGoXlF8sX5RV8iVgpAHQxZVgF0mlRquEydWO7OJyUDMs0EG+mYm2PdmJ3yYFnvbqm6hj1AupdU4TXiQSfx5L/0B4/AW4bNsLxftBsSYJXBgb3IwyMVC+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ggNxKTpv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T0oVwn018083;
	Mon, 29 Jan 2024 02:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DDQk3+y02uSzL86nSTzmFGZIOkpXM2BW+E7wCU4D0WI=; b=gg
	NxKTpvzmxNd/28LVQBShnH0eHfMfzIoyPe6LeHJ39vGHm3VowRVNikTJD38uzvOB
	/f0OeOeGtldHTpuOBv3BeK2Br2REJGfw70t8IEwY5a8Xum3ELUmcLKBYUXWFB9Ku
	BWYO67/SuznF3bFg8elAEqQFpMCo5b7uej57wUIzQMsEJFVFdnTVEOzyQNagzQT4
	sxvOKoh5nV9br9678mshz4721tjNqLAFJoQ4PyQaPBuPMmuALxtI6/pX++JLpFXE
	kRNi3MhJUucKnWES1Lwa245Xdiz0v7aMoKz4N44HJisdYLwTgPUqE3yI2Vm9VbSV
	4piW06pA5P/zNoNEttSA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvt7c2jge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 02:06:52 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T26pE6032069
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 02:06:51 GMT
Received: from [10.238.139.231] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 28 Jan
 2024 18:06:48 -0800
Message-ID: <3ac210a6-d378-4f6a-9924-04f3dee9e79c@quicinc.com>
Date: Mon, 29 Jan 2024 10:06:40 +0800
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
 <4c82f1f0-1c5a-498f-9845-b5b26cd76468@quicinc.com>
 <5f6c2be1-faf9-4e64-ab3a-88046d75e2cf@quicinc.com>
 <1d948daf-1495-4208-a85f-6bd798091d82@quicinc.com>
 <CAA8EJppqL=79rDzEvrhEA8N6wa=YFxN+595eK+JD=JOuCRm1gA@mail.gmail.com>
From: hui liu <quic_huliu@quicinc.com>
In-Reply-To: <CAA8EJppqL=79rDzEvrhEA8N6wa=YFxN+595eK+JD=JOuCRm1gA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gtvtu1ND6x4d7-6vnbaY423bquFx0xkS
X-Proofpoint-GUID: gtvtu1ND6x4d7-6vnbaY423bquFx0xkS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290014



On 1/22/2024 9:37 PM, Dmitry Baryshkov wrote:
> On Mon, 22 Jan 2024 at 08:26, hui liu <quic_huliu@quicinc.com> wrote:
>>
>>
>>
>> On 1/22/2024 1:42 PM, hui liu wrote:
>>>
>>>
>>> On 1/18/2024 10:06 AM, hui liu wrote:
>>>>
>>>>
>>>> On 1/17/2024 11:41 AM, Dmitry Baryshkov wrote:
>>>>> On Wed, 17 Jan 2024 at 05:02, hui liu <quic_huliu@quicinc.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 1/15/2024 6:26 PM, Krzysztof Kozlowski wrote:
>>>>>>> On 15/01/2024 11:18, hui liu wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 1/15/2024 5:56 PM, Dmitry Baryshkov wrote:
>>>>>>>>> On Mon, 15 Jan 2024 at 11:48, Hui Liu via B4 Relay
>>>>>>>>> <devnull+quic_huliu.quicinc.com@kernel.org> wrote:
>>>>>>>>>>
>>>>>>>>>> From: Hui Liu <quic_huliu@quicinc.com>
>>>>>>>>>>
>>>>>>>>>> Add definition for three LEDs to make sure they can
>>>>>>>>>> be enabled base on QCOM LPG LED driver.
>>>>>>>>>
>>>>>>>>> The "function" property is still placed incorrectly. Posting the
>>>>>>>>> next
>>>>>>>>> iteration before concluding the discussion on the previous one is
>>>>>>>>> not
>>>>>>>>> the best idea.
>>>>>>>> Do you mean I should update it as below? Seems there is no
>>>>>>>> consumer to
>>>>>>>> use the function config, do we need to add now?
>>>>>>>
>>>>>>> Paste the output of dtbs_check for your board (or CHECK_DTBS=y for
>>>>>>> your
>>>>>>> Makefile target).
>>>>>> I checked the dt-binding file of LPG LED, I will update the dts as
>>>>>> below, if you think it's correct, I will push v6.
>>>>>
>>>>> Is there any reason why you are defining three different LEDs instead
>>>>> of multi-led with three components?
>>>
>>>> In the HW design, they are three seprete LEDs, there are three LEDs on
>>>> device. why do we need to add for multi-led?
>>>>
>>>> Thanks,
>>>> Hui
>>
>> I double confirmed the HW design, for IDP devcie, we should set it to
>> multi led, for another similar device(RB3-GEN2, I will push LED change
>> for this device later), it should be set to seperate LED.
>> They are different, so I will push V6 to set it for multi-led for
>> QCM6490-IDP device. Thanks for your review.
> 
> Ack, thank you.
Hi Dmitry,
Could you give the approval for V6?
https://lore.kernel.org/all/20240126-lpg-v6-1-f879cecbce69@quicinc.com/
Thanks,
Hui
> 
>>
>>>>>
>>>>>>
>>>>>> +&pm8350c_pwm {
>>>>>> +       #address-cells = <1>;
>>>>>> +       #size-cells = <0>;
>>>>>> +       status = "okay";
>>>>>> +
>>>>>> +       led@1 {
>>>>>> +               reg = <1>;
>>>>>> +               color = <LED_COLOR_ID_RED>;
>>>>>> +               function = LED_FUNCTION_STATUS;
>>>>>> +       };
>>>>>> +
>>>>>> +       led@2 {
>>>>>> +               reg = <2>;
>>>>>> +               color = <LED_COLOR_ID_GREEN>;
>>>>>> +               function = LED_FUNCTION_STATUS;
>>>>>> +       };
>>>>>> +
>>>>>> +       led@3 {
>>>>>> +               reg = <3>;
>>>>>> +               color = <LED_COLOR_ID_BLUE>;
>>>>>> +               function = LED_FUNCTION_STATUS;
>>>>>> +       };
>>>>>> +};
>>>>>
>>>>>
>>>>>
> 
> 
> 

