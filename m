Return-Path: <linux-kernel+bounces-7383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A091B81A715
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 19:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFFF3B232C3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B234482F8;
	Wed, 20 Dec 2023 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hqC7PGOD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC8934566;
	Wed, 20 Dec 2023 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BKImDVP019641;
	Wed, 20 Dec 2023 18:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=uH4lXBMfSLsG7Tfm2blXseD6lH18fQ3JA6FeQVu9E0w=; b=hq
	C7PGODirpYIKKGWxf+8ZG+m/jDj2BbwhSKhAiNrCB57Lay/8NOzygcOAQwHVtMmR
	3Me1iOwoMdVInTyrgTO8IpVAzZFcnblKPSpQgRurSszYkJTDI64CQrFyKRxGgR6d
	XfE6PoyfgebCyaRCa9bTrPqQcVX1qRynLwY6mv8bfvLLX2pbv+tpiYxXmG9IyZyC
	/6W7sKD18YS9sitkWMVQfxNU2z8v3V6kOuzIadC201PrMuDovxz/OtCT0qBznmEQ
	D3ud4nDLobZct8UITX8XwTZI4H43LKafGAL+j98EE1Al4OPlcY+boz5HV95ib5K9
	NRIfb0pUFp98h1dZWqLQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3wt9sfq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 18:55:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BKItgtp014507
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 18:55:42 GMT
Received: from [10.110.55.244] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 10:55:42 -0800
Message-ID: <cf2c1c84-2d9d-1be4-997f-d3dde362b27a@quicinc.com>
Date: Wed, 20 Dec 2023 10:55:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 00/34] Qualcomm video encoder and decoder driver
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vikash Garodia
	<quic_vgarodia@quicinc.com>
CC: Dikshita Agarwal <quic_dikshita@quicinc.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <bryan.odonoghue@linaro.org>,
        <linux-arm-msm@vger.kernel.org>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <a033dfc5-dcf1-4969-ad4d-1836ff9ff0a3@linaro.org>
 <d0ea23ae-8fba-d229-b0f6-dc522f285233@quicinc.com>
 <CAA8EJpouBOLJ_1Pz_YauuOX+97ud9RkLYRaui4GM6ZFJUKYJMw@mail.gmail.com>
 <9d94317c-5da9-5494-26a2-12007761a1e5@quicinc.com>
 <CAA8EJpoCGRT=eETab8mF2MZZ04RmCkNnFKaRBFoUYk5qqDAPhg@mail.gmail.com>
 <eb288a33-a8c3-9dea-ffc1-e97a69be9a4c@quicinc.com>
 <CAA8EJprZ1TK7UwfhSh2PtwuNJLUMace7MWnzQkrUMqV5R+WgOA@mail.gmail.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAA8EJprZ1TK7UwfhSh2PtwuNJLUMace7MWnzQkrUMqV5R+WgOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OBUwtanPNFOUjwoF-KiN5sCuBD_Tksqv
X-Proofpoint-GUID: OBUwtanPNFOUjwoF-KiN5sCuBD_Tksqv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=858
 spamscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200134

Hi Dmitry and Krzysztof

On 12/20/2023 1:52 AM, Dmitry Baryshkov wrote:
> On Wed, 20 Dec 2023 at 10:53, Vikash Garodia <quic_vgarodia@quicinc.com> wrote:
>>
>> On 12/20/2023 2:09 PM, Dmitry Baryshkov wrote:
>>> On Wed, 20 Dec 2023 at 10:14, Vikash Garodia <quic_vgarodia@quicinc.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 12/20/2023 1:07 PM, Dmitry Baryshkov wrote:
>>>>> On Wed, 20 Dec 2023 at 08:32, Vikash Garodia <quic_vgarodia@quicinc.com> wrote:
>>>>>>
>>>>>> Hi Dmitry,
>>>>>>
>>>>>> On 12/19/2023 12:08 AM, Dmitry Baryshkov wrote:
>>>>>>> On 18/12/2023 13:31, Dikshita Agarwal wrote:
>>>>>>>> This patch series introduces support for Qualcomm new video acceleration
>>>>>>>> hardware architecture, used for video stream decoding/encoding. This driver
>>>>>>>> is based on new communication protocol between video hardware and application
>>>>>>>> processor.
>>>>>>>
>>>>>>> This doesn't answer one important point, you have been asked for v1. What is the
>>>>>>> actual change point between Venus and Iris? What has been changed so much that
>>>>>>> it demands a separate driver. This is the main question for the cover letter,
>>>>>>> which has not been answered so far.
>>>>>>>
>>>>>>>  From what I see from you bindings, the hardware is pretty close to what we see
>>>>>>> in the latest venus generations. I asssme that there was a change in the vcodec
>>>>>>> inteface to the firmware and other similar changes. Could you please point out,
>>>>>>> which parts of Venus driver do no longer work or are not applicable for sm8550
>>>>>>
>>>>>> The motivation behind having a separate IRIS driver was discussed earlier in [1]
>>>>>> In the same discussion, it was ellaborated on how the impact would be with
>>>>>> change in the new firmware interface and other video layers in the driver. I can
>>>>>> add this in cover letter in the next revision.
>>>>>
>>>>> Ok. So the changes cover the HFI interface. Is that correct?
>>>> Change wise, yes.
>>>>
>>>>>> We see some duplication of code and to handle the same, the series brings in a
>>>>>> common code reusability between iris and venus. Aligning the common peices of
>>>>>> venus and iris will be a work in progress, once we land the base driver for iris.
>>>>>
>>>>> This is not how it usually works. Especially not with the patches you
>>>>> have posted.
>>>>>
>>>>> I have the following suggestion how this story can continue:
>>>>> You can _start_ by reworking venus driver, separating the HFI /
>>>>> firmware / etc interface to an internal interface in the driver. Then
>>>>> implement Iris as a plug in for that interface. I might be mistaken
>>>>> here, but I think this is the way how this can be beneficial for both
>>>>> the video en/decoding on both old and new platforms.
>>>>
>>>> HFI/firmware interface is already confined to HFI layer in the existing venus
>>>> driver. We explained in the previous discussion [1], on how the HFI change
>>>> impacts the other layers by taking example of a DRC usecase. Please have a look
>>>> considering the usecase and the impact it brings to other layers in the driver.
>>>
>>> I have looked at it. And I still see huge change in the interface
>>> side, but it doesn't tell me about the hardware changes.
>>
>> I hope you noticed how the common layers like decoder, response, state layers
>> are impacted in handling one of usecase. Now add that to all the different
>> scenarios like seek, drain, DRC during seek, DRC during drain, etc.
> 
> Yes, for sure.
> 
>>
>>> Have you evaluated the other opportunity?
>>>
>>> To have a common platform interface and firmware-specific backend?
>>>
>>> You have already done a part of it, but from a different perspective.
>>> You have tried to move common code out of the driver. Instead we are
>>> asking you to do a different thing. Move non-common code within the
>>> driver. Then add your code on top of that.
>>
>> For common platform - yes, we are bringing in common stuff like PIL.
>> Other than that, abstraction to firmware interface is not that confined to one
>> layer. It spreads over decoder/encoder/common layers. Now when majority of the
>> layers/code is different, we planned to make it in parallel to venus and have a
>> common layer having common things to both iris and venus.
> 
> My suggestion still holds. Start with this common platform code.
> Rather than arguing back and forth, could you please perform an
> experiment on the current venus driver and move firmware interface to
> subdirs, leaving just the platform / PIL / formats / etc in place?
> This will at least allow us to determine whether it is a feasible
> concept or not.
> 

Your comments are valid. The platform driver piece and some other pieces 
still are common between venus and iris despite this initial effort of 
moving common pieces out. I have also seen this from whatever I have 
reviewed.

Video team also acknowledges this part and internally I think they did 
evaluate this option and their feedback was, the more and more they 
changed, they were touching pretty much every file of venus.

The missing piece i think in all this discussion is that in addition to 
the forward channel, the reverse channel of HFI, based on which the rest 
of the video state machine changes should also be considered.

So even with respect to the code layout, its not just the forward 
communication but the backwards communication of fw--->hfi--->codec is 
becoming a challenge as the venus layers seem to only work with the hfi 
of venus.

For adding support for the new HFI events/communication, it was getting 
harder to extend venus.

What I certainly acknowledge is now with iris whether this can be dealt 
with better for future chipsets to avoid another re-write for another 
HFI as that will be too much of maintenance cost.

I will let the video team comment on this part.

Thanks

Abhinav





>>
>>>>
>>>> [1] https://lore.kernel.org/lkml/8c97d866-1cab-0106-4ab3-3ca070945ef7@quicinc.com/
>>>>> Short rationale:
>>>>> The venus driver has a history of supported platforms. There is
>>>>> already some kind of buffer management in place. Both developers and
>>>>> testers have spent their effort on finding issues there. Sending new
>>>>> driver means that we have to spend the same amount of efforts on this.
>>>>> Moreover, even from the porter point of view. You are creating new
>>>>> bindings for the new hardware. Which do not follow the
>>>>> venus-common.yaml. And they do not follow the defined bindings for the
>>>>> recent venus platforms. Which means that as a developer I have to care
>>>>> about two different ways to describe nearly the same hardware.>> Again qualcomm video team does not have a plan to support sm8550/x1e80100 on
>>>>>> venus as the changes are too interleaved to absorb in venus driver. And there is
>>>>>> significant interest in community to start validating video driver on sm8550 or
>>>>>> x1e80100.
>>>>>>
>>>>>> [1] https://lore.kernel.org/lkml/8c97d866-1cab-0106-4ab3-3ca070945ef7@quicinc.com/
>>>>>>
>>>>>> Regards,
>>>>>> Vikash
>>>>>
>>>>>
>>>>>
>>>
>>>
>>>
> 
> 
> 

