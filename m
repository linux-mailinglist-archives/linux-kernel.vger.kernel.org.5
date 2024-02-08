Return-Path: <linux-kernel+bounces-57692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7990184DC63
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F264F1F223FD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9426BB20;
	Thu,  8 Feb 2024 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nZ1Wviq9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722D267C7E;
	Thu,  8 Feb 2024 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383253; cv=none; b=ACv8/yxag6OwUf6SdR+vUAov+YNilCC65jOXoRz6UbyWvghrMoi6ofPqQNtciYTk8TZ3hA6fwoDNyVqT/AOGJquiNShuz5n65NCeMLq+NmndiyK2F5VceEZEldL7Wz3oWZh8m16LOBTLwJ6swNd8sK7LAqS5IrDyhcwILoeOTJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383253; c=relaxed/simple;
	bh=wr0IKEn24HXWw9pmfAzATPfrrvs2K+Sf+3BDhov5A0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sHEcq97CQY3QnGSOF6D4re3r9fredFZUGxxf1dp0Y2UZ7TJkG5/OAdQ//ghyrBNhCpXPMn+xH2xrLdb4TKq8ptdYMSOgxxxDzTRnfQQbIGEOMF4LoTwvJAPAfvli0v/82+ZI8DdXWL6xfVhoAks2HbIByubbLCrMlQg8PvcMFZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nZ1Wviq9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4188ZdA7029307;
	Thu, 8 Feb 2024 09:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=MXPzNnfDYfLtAUOiy0VTkRebmv+Nk0swilKB3svJo28=; b=nZ
	1Wviq9V3vAa5AVFTD0RAJq8wXDChHkui3M184QGIC+MWRkIAio772+0aFcQ2MEnt
	XIadVWJpYOIsjoXE1JuhUrMVKSkmCEvJB3ZXXiZA3bNe+rcNvfwTxEWMS4B+ZeDr
	7JZZdG1LPzLgr53uOtuo6iU0qVJPaCV+j416l9xzUb+xY8DMIxak1PBW60RdPoFJ
	nCqHQeTx7fHAmC/idnx0/JPVqWXTc+zEvAduS1Ka5U57U7pfxn8EAA0HXnM67v78
	RuU3EnJaim0pfVXDSeiKkimLq1Ty6E+1ur4eaSNpW33sAmbSJehgiRNGe5FDhAJ2
	MX6mJSs/t1m3yeUmc2Kg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4m3ah33n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 09:07:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41897DYd010805
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 09:07:13 GMT
Received: from [10.216.53.86] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 8 Feb
 2024 01:07:10 -0800
Message-ID: <62bba89d-97b0-4129-8abe-6025790d9d13@quicinc.com>
Date: Thu, 8 Feb 2024 14:37:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sa8295p: Enable tertiary controller
 and its 4 USB ports
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>
CC: Rob Herring <robh+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>
References: <20240206114745.1388491-1-quic_kriskura@quicinc.com>
 <20240206114745.1388491-3-quic_kriskura@quicinc.com>
 <CAA8EJpoed-hu4hPXAcwQxmJAaNRwJ2y5q9qybWaPP8bdMnz_oA@mail.gmail.com>
 <0470a930-d629-4467-b619-58d3e76f59a7@quicinc.com>
 <CAA8EJppJAdHXoVs_2VqQf=_Wk_LoEcNMY2H-Xzqu8KzeaN8i0g@mail.gmail.com>
 <fd4f4cc8-3366-485b-b540-b05ef59dd5d4@quicinc.com>
 <CAA8EJppi+3cJqzkhcaDR_3w_Qhy_AzLBJsW7-dtugzE1egM3Kg@mail.gmail.com>
 <7500f1f8-1d97-4fa9-a7cd-7dea0ad52e00@quicinc.com>
 <CAA8EJpoe-gaSgD_HruYSUAPgfBNCw9-G9wnEnvpkiCtmrqFQ7A@mail.gmail.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CAA8EJpoe-gaSgD_HruYSUAPgfBNCw9-G9wnEnvpkiCtmrqFQ7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Oon_ABTvhis6GKHPhltr4YJPODAu-63e
X-Proofpoint-GUID: Oon_ABTvhis6GKHPhltr4YJPODAu-63e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=804 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402080048



On 2/8/2024 10:37 AM, Dmitry Baryshkov wrote:
> On Thu, 8 Feb 2024 at 06:48, Krishna Kurapati PSSNV
> <quic_kriskura@quicinc.com> wrote:
>>
>>
>>
>> On 2/8/2024 10:11 AM, Dmitry Baryshkov wrote:
>>> On Thu, 8 Feb 2024 at 04:40, Krishna Kurapati PSSNV
>>> <quic_kriskura@quicinc.com> wrote:
>>>> On 2/6/2024 6:54 PM, Dmitry Baryshkov wrote:
>>>>> On Tue, 6 Feb 2024 at 14:28, Krishna Kurapati PSSNV
>>>>> <quic_kriskura@quicinc.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2/6/2024 5:43 PM, Dmitry Baryshkov wrote:
>>>>>>> On Tue, 6 Feb 2024 at 14:03, Krishna Kurapati <quic_kriskura@quicinc.com> wrote:
>>>>>>>>
>>>>>>>> Enable tertiary controller for SA8295P (based on SC8280XP).
>>>>>>>> Add pinctrl support for usb ports to provide VBUS to connected peripherals.
>>>>>>>
>>>>>>> These are not just pinctrl entries. They hide VBUS regulators. Please
>>>>>>> implement them properly as corresponding vbus regulators.
>>>>>>>
>>>>>>
>>>>>> Hi Dmitry. Apologies, can you elaborate on your comment. I thought this
>>>>>> implementation was fine as Konrad reviewed it in v13 [1]. I removed his
>>>>>> RB tag as I made one change of dropping "_state" in labels.
>>>>>
>>>>> My comment is pretty simple: if I'm not mistaken, your DT doesn't
>>>>> reflect your hardware design.
>>>>> You have actual VBUS regulators driven by these GPIO pins. Is this correct?
>>>>> If so, you should describe them properly in the device tree rather
>>>>> than describing them just as USB host's pinctrl state.
>>>>>
>>>>
>>>> Hi Dmitry,
>>>>
>>>>     I have very little idea about the gpio controller regulators. I will
>>>> go through it and see how I can implement it. I just found this :
>>>> https://www.kernel.org/doc/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
>>>
>>> Much simpler, it can be found at
>>> Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
>>
>> Thanks for the reference.
>>
>>>
>>>> One query. If we model it as a regulator, do we need to add it as a
>>>> supply and call regulator_enable in dwc3_qcom probe again ?
>>>
>>> Not in probe(), but yes. It needs to be enabled when the VBUS has to
>>> be powered up, when the device is initialised or switched to the host
>>> mode, and disabled when the VBUS has to be powered down, if the device
>>> is being switched to the device mode.
>>>
>>
>> Actually since we never go to device mode, can't we just stick to this
>> pinctrl approach and skip turning on regulator in driver ?
> 
> Scroll several emails back. DT should describe the hardware. Hardware
> has VBUS regulators.
> 

Hi Dmitry,

I dug up the schematic and I see that the gpio's we are using in this 
patch are actually "Enable Pins" to an external chip that provides vbus 
to the peripherals connected. So from the perspective of SoC, it is a 
GPIO and not to be represented as a regulator I believe.

Regards,
Krishna,

