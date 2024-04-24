Return-Path: <linux-kernel+bounces-157845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 732388B1739
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C043284985
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C0A16F0F2;
	Wed, 24 Apr 2024 23:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pQrrMB4b"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154E4442F;
	Wed, 24 Apr 2024 23:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714001748; cv=none; b=LTmOiKUx83bugTvOEIuuStO98BKEWsXd1aAWcHIaWzmmnzJHObibvn39xoIFBRIPB4jxo0EO0AyMuL2JSMOT7y6MMpGn/oMWwvzYPEQ/GGDJkPzUr9iht5MfBDeKPs7tmiQIAv5miiVWwPtD9t15Yl6IIWFtrtcTeY30fz0Hso0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714001748; c=relaxed/simple;
	bh=alWh828635B9LX6WrzpJ33NK+tWIsqWDA5n+dpzOkVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LpcUAIPaETetvWrvX1fA1s9/LUdJbDVFV9qouS4bIHacEv+ZEk5ygFosIwy0Uk3PPyL/Lpsqq0pZXoWtS29le7TnvdCdK4xoiesFHi7T1ldvan2vgTwiY8yz3/JbTa0TDMU9HhPlpbpoU1uEDh1f7ru9+7Qbgl5CQ1f1HpmlkYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pQrrMB4b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43ONPDi7009559;
	Wed, 24 Apr 2024 23:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=boDSHsbn06oFKEy2YJu1wtGdZZBUC0SEoorcU9qQ8r0=; b=pQ
	rrMB4boYXfgbp2Pcs0WxyIa/gER36XaBwXp6+1kt/nZoccg7al7YZl7Wp6bxst+m
	WjMiEUnl/tPOO1aAJutnIHj/V+2syeybkgd55Bx/LZDd62yDgA6ajf0UhWFWgm/W
	zOwN7pDxBPhnuJb3GErG9w6xCcd8l6OnvjPho/1cQwsMftGA80My5Fa2PuMtdACr
	iuTg9jmsjYfnGXf0NcH4fvFRC7bwVMOolXTNWqDrkcsQBCfxkyaEdq2KGDBscoVa
	RPY74DrcqqJO3AMNY3ctIHlcY46T7CC4tueLp4wd4AI6v3HyT610FF7snq9S5YT9
	/XPfZHKWjKIcIGrMNDYw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9ktcna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 23:35:41 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43ONZeKo005341
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 23:35:40 GMT
Received: from [10.253.14.221] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 16:35:38 -0700
Message-ID: <1d0878e0-d138-4de2-86b8-326ab9ebde3f@quicinc.com>
Date: Thu, 25 Apr 2024 07:35:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
To: Wren Turkal <wt@penguintechs.org>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
CC: Bartosz Golaszewski <brgl@bgdev.pl>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
        Luiz
 Augusto von Dentz <luiz.dentz@gmail.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
References: <20240422130036.31856-1-brgl@bgdev.pl>
 <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
 <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
 <b982b73d-0540-409c-a6e2-0e03ecb11715@penguintechs.org>
 <0381f39c-38ba-4a2b-915c-f14c5f911eb9@penguintechs.org>
 <CAMRc=MfnEct7ThQhCA3AoY7hxq8j1mmFLNNkK17+RSvJxs67XQ@mail.gmail.com>
 <2371f538-ec53-4037-b171-c62bf4e06eb1@penguintechs.org>
 <CACMJSeunUaj0cxLaN4MpFmX5vTOx_vnWjBN4Y2FavdQoQxFRkg@mail.gmail.com>
 <4c33304a-5dbc-450a-b874-e04ba9e93150@penguintechs.org>
 <CAMRc=MeDQFHX9r-sHNxqkfpi=LkHoRSL7i6dWokB-J+J03rBEg@mail.gmail.com>
 <93e15ecf-252f-4789-a23b-a28280f6aa84@quicinc.com>
 <e64b89b3-a8f5-44e7-ae7f-fc4298841f1c@penguintechs.org>
 <CACMJSet1wjEive0-Z=0_eiY7umBoSF_VX3QvVgiwqxhTSDZg6g@mail.gmail.com>
 <aea85118-060a-4451-a1f1-d8e634f1aab7@penguintechs.org>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <aea85118-060a-4451-a1f1-d8e634f1aab7@penguintechs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KIJB2dMPWpvIeDKjfmq4B2snpsXlaTos
X-Proofpoint-GUID: KIJB2dMPWpvIeDKjfmq4B2snpsXlaTos
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_19,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240124

On 4/25/2024 6:17 AM, Wren Turkal wrote:
> On 4/24/24 6:53 AM, Bartosz Golaszewski wrote:
>> On Wed, 24 Apr 2024 at 15:26, Wren Turkal <wt@penguintechs.org> wrote:
>>>
>>> On 4/24/24 6:12 AM, quic_zijuhu wrote:
>>>> On 4/24/2024 8:27 PM, Bartosz Golaszewski wrote:
>>>>> On Wed, Apr 24, 2024 at 2:24 PM Wren Turkal <wt@penguintechs.org>
>>>>> wrote:
>>>>>>>>>
>>>>>>>>> That's OK, we have the first part right. Let's now see if we
>>>>>>>>> can reuse
>>>>>>>>> patch 2/2 from Zijun.
>>>>>>>>
>>>>>>>> I'm compiling it right now. Be back soon.
>>>>>>>>
>>>>>>>
>>>>>>> Well I doubt it's correct as it removed Krzysztof's fix which looks
>>>>>>> right. If I were to guess I'd say we need some mix of both.
>>>>>>
>>>>>> Patch 2/2 remove K's fix? I thought only 1/2 did that.
>>>>>>
>>>>>> To be specific, I have applied your patch and Zijun's 2/2 only.
>>>>>>
>>>>>
>>>>> No, patch 1/2 from Zijun reverted my changes. Patch 2/2 removes
>>>>> Krzysztof's changes and replaces them with a different if else. This
>>>>> patch is a better alternative to Zijun's patch 1/2. For 2/2, I'll let
>>>>> Krzysztof handle it.
>>>>>
>>>> do you really realize what do you talk about?
>>>> do you really listen what do @Wren says?
>>>>
>>>> he says that my patch 2/2 is right based on several verification
>>>> results.
>>>
>>> she, not he
>>>
>>>> BTW, my 2/2 fix don't have anything about DTS usage.
>>>
>>> I think the problem with your 2/2 patch is that it removes the
>>> conditional bailing if the device is shutdown or not open.
>>>
>>> Maybe this patch instead?
>>>
>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>> index 2f7ae38d85eb..fcac44ae7898 100644
>>> --- a/drivers/bluetooth/hci_qca.c
>>> +++ b/drivers/bluetooth/hci_qca.c
>>> @@ -2456,6 +2456,10 @@ static void qca_serdev_shutdown(struct device
>>> *dev)
>>>                       !test_bit(HCI_RUNNING, &hdev->flags))
>>>                           return;
>>>
>>> +               if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP,
>>> &hdev->quirks) ||
>>> +                   hci_dev_test_flag(hdev, HCI_SETUP))
>>> +                       return;
>>> +
>>>                   serdev_device_write_flush(serdev);
>>>                   ret = serdev_device_write_buf(serdev, ibs_wake_cmd,
>>>                                                 sizeof(ibs_wake_cmd));
>>>
>>>> he maybe be a DTS expert but not BT from his present fix history for
>>>> bluetooth system.
>>>
>>>
>>
>> Did you test it? Does it work? If so, please consider sending it
>> upstream for review.
>>
>> You can keep Zijun's authorship but add your own SoB tag at the end
>> and mention what you did. Something like this:
>>

[V7 2/2] as shown by below link is the formal fix.
https://patchwork.kernel.org/project/bluetooth/patch/1713932807-19619-3-git-send-email-quic_zijuhu@quicinc.com/

this fix logic was introduced from the very beginning when i saw your
issue description as shown by below link
https://lore.kernel.org/all/1713095825-4954-3-git-send-email-quic_zijuhu@quicinc.com/#t

>> [Wren: kept Krzysztof's fix]
>> Signed-off-by: Wren...
>>
>> Bartosz
> 
> @Bartosz, I have tested this, and it works functionally for my setup. I
> cannot detect a difference between this and Zijun's logic when I compile
> a kernel with this patch.
> 
> @Zijun, I think you have objections to this patch. I would like to make
> sure I hear your concern. Can you please take through it like I'm a 5
> year old who barely knows C? In retrospect, I guess that I would be a
> pretty precocious 5 year old. LOL.
> 
> In all seriousness, @Zijun, I really appreciate the work you did on
> this. I would like to understand why you assert that removing the logic
> of Krzysztof is appropriate. Again, I am not a kernel developer, so this
> stuff is really outside my wheelhouse. Having said that, by my reading,
> which may very well be worng, it seems like you are just adding another
> case that is orthogonal to K's conditions. I'd like to truly understand
> you position to know if the patch I am suggesting is somehow harmful.
> This is an earnest question. I really want to respect your expertise
> here, and I really want you to know how much I appreciate your work.
> you maybe see all replies of [2/2] patch for this issue within below
link. i believe you will understand it. the bottom of the link includes
all reply history.
https://lore.kernel.org/all/fe1a0e3b-3408-4a33-90e9-d4ffcfc7a99b@quicinc.com/
> wt


