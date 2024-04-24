Return-Path: <linux-kernel+bounces-156957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4E78B0ADC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95498284512
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596C715CD57;
	Wed, 24 Apr 2024 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JbeDNqRM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69F71598E3;
	Wed, 24 Apr 2024 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965448; cv=none; b=p/1/1dpv0BpLquw3ex3LDgpOAZoodfEOsYNZa2J/E0N1Lfit4iw8HpxJJ/bLSfL/9Ig2h4IFEklxeRHDEmMykxNmJW89mkfbNdHxPKpWJ+/kKwl4qbsfPdC62Sm/X6ZvtBXiW19/BHBvpbfSbSyiyErmFRT7mo4TceGaE5dycpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965448; c=relaxed/simple;
	bh=4gwKXrOPdUFR5lhUIndigSGaORrN26b5N4qgWiiUAEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d1Wj0UZuKpC9s7I6F17s1i8BaF5K+mjbt4kC2/xRqVo4jQwPMxwMl3IEGz/8f/g/Bmtzax8IEX0oTtav80mdoJeB2iSa3wTYhwCOlmeqmZtJk5wcJfcC7WSnEI1Qp2L6PUT6xpM9RU1CJoX3/+NYfkaZCvZqSFzWmefSd13v/jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JbeDNqRM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O6X62I012813;
	Wed, 24 Apr 2024 13:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XG3+IqvPxEra7iPK/tJ4oWh7H1vamJU4p+FmAgOmWWA=; b=Jb
	eDNqRMoscKz7LG8q2k59u13ZLqB4blZAVe41/NiCxonZmjMJIG6xaITPKMAY+dtp
	2oW1XALd+qhtRqSC8aSUQLzOs+fHFuAUzx6yTpjLCymxo9a5FwXQof2Sa2k1CT4R
	jVnZDxXVQoyrMf+MtW+RskW6g++SOpYyGRJUsg68VUYRaSgZr87DhZJJ9am8P7DJ
	wPGARQJgFTKqjOWSeEJybGQAFaw1UDssKdA+8k2EJJ54mpFwvWHjEyMxoivtSdZW
	WIH4smvbCwH6sQSQUolTEspXrVaZKMTCjwFnYMv68i8WcMSf9bDc7sNxaRSHV/QX
	JrxzpkvbnONmzgCMWBoQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9pgxpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 13:30:39 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43ODUcVn010303
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 13:30:38 GMT
Received: from [10.253.14.221] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 06:30:36 -0700
Message-ID: <dbc3495e-5f12-4928-afa3-fb8886d276c2@quicinc.com>
Date: Wed, 24 Apr 2024 21:30:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
To: Wren Turkal <wt@penguintechs.org>, Bartosz Golaszewski <brgl@bgdev.pl>
CC: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Marcel
 Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <e64b89b3-a8f5-44e7-ae7f-fc4298841f1c@penguintechs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IqRmyarL06ii4McPmcPm5Gr8c6IGpRf-
X-Proofpoint-ORIG-GUID: IqRmyarL06ii4McPmcPm5Gr8c6IGpRf-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_10,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=678 clxscore=1015
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240046

On 4/24/2024 9:26 PM, Wren Turkal wrote:
> On 4/24/24 6:12 AM, quic_zijuhu wrote:
>> On 4/24/2024 8:27 PM, Bartosz Golaszewski wrote:
>>> On Wed, Apr 24, 2024 at 2:24 PM Wren Turkal <wt@penguintechs.org> wrote:
>>>>>>>
>>>>>>> That's OK, we have the first part right. Let's now see if we can
>>>>>>> reuse
>>>>>>> patch 2/2 from Zijun.
>>>>>>
>>>>>> I'm compiling it right now. Be back soon.
>>>>>>
>>>>>
>>>>> Well I doubt it's correct as it removed Krzysztof's fix which looks
>>>>> right. If I were to guess I'd say we need some mix of both.
>>>>
>>>> Patch 2/2 remove K's fix? I thought only 1/2 did that.
>>>>
>>>> To be specific, I have applied your patch and Zijun's 2/2 only.
>>>>
>>>
>>> No, patch 1/2 from Zijun reverted my changes. Patch 2/2 removes
>>> Krzysztof's changes and replaces them with a different if else. This
>>> patch is a better alternative to Zijun's patch 1/2. For 2/2, I'll let
>>> Krzysztof handle it.
>>>
>> do you really realize what do you talk about?
>> do you really listen what do @Wren says?
>>
>> he says that my patch 2/2 is right based on several verification results.
> 
> she, not he
> 
>> BTW, my 2/2 fix don't have anything about DTS usage.
> 
> I think the problem with your 2/2 patch is that it removes the
> conditional bailing if the device is shutdown or not open.
> 
> Maybe this patch instead?
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 2f7ae38d85eb..fcac44ae7898 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2456,6 +2456,10 @@ static void qca_serdev_shutdown(struct device *dev)
>                     !test_bit(HCI_RUNNING, &hdev->flags))
>                         return;
> 
> +               if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP,
> &hdev->quirks) ||
> +                   hci_dev_test_flag(hdev, HCI_SETUP))
> +                       return;
> +
>                 serdev_device_write_flush(serdev);
>                 ret = serdev_device_write_buf(serdev, ibs_wake_cmd,
>                                               sizeof(ibs_wake_cmd));
> 
>> he maybe be a DTS expert but not BT from his present fix history for
>> bluetooth system.
> 
> 
Hi Wren,
i think i don't need to care about why wrong condition cause wrong results.

