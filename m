Return-Path: <linux-kernel+bounces-42263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E12683FEAB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144531C22973
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53064D5B4;
	Mon, 29 Jan 2024 06:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KFuUtS8U"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919E24D11F;
	Mon, 29 Jan 2024 06:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706511031; cv=none; b=jB4P4PPoe/SKnDVZOVbGugX/gAeewN7fqP1/CBsi9aWJeQQTMNPnvWMJV4ySpiV/6cva+wwuPjYj+iurbHPqrnTsy0vRe3R8uTnwj7zpOMqsp/SxSxOUkqnJ/5rqf7iit7ym1S+BQErfm4DXeLAMFZTl5LmkD+tWuYu4fgCEXvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706511031; c=relaxed/simple;
	bh=9Lqd0Wp9CWGCgQ+dzHt3vF/KMkDgZyHWiuF0t1cbXPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PO65JIfJleSp0MG/vzjzA36aA1qr5XDJb0eT3fjDnIzEk5Wk3EdgbEVeSv1FWFrlytQrFK4JrnTzv9hZ0n3xMSDQNDtt51yPkIHK7ArGk0wMpfVXUgC98P2mavnpjE41QXc2fHTjBHoHFRMdRbuL17QoiN2YOSpIU56bUnh+1f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KFuUtS8U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T6HEs6015884;
	Mon, 29 Jan 2024 06:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vNIxtC/0z3l+0eOI0Cy/6uCXq7BnHzaxNCHgoNCSk4s=; b=KF
	uUtS8UUApYyrYz3pWumhfDafA3qchrm2uCyMl942A4EQqzGdcBJ1TwntsTCoWrB5
	UBDyN0U+HsbuTzfPByhV/o5fhWn5gnRIxHtZqPVn0pTBE/fNB0R47uvzCzh8y+rf
	SMKqJdh9KedWfdbcCnEtK9vufiUjaSQRe8BD+HkC1TiqpZSEGpkFYYmFFcqWHnuO
	L7xEz7fi0uaeC/qahg7RbAgDo8ZARhUzldvhNpHX1YlFzLFh5zjI0grNWb4uqIOy
	yLEAuf3CahjgE80ZCdbbkvKZDVUZ4r9TzWwnSFgcR6cjKk8cUYGxWjdhq7Plp4tq
	NMHhE+KXKFWe+gFyf7uA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvu4ctwsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:50:23 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T6oNC2002546
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:50:23 GMT
Received: from [10.217.218.207] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 28 Jan
 2024 22:50:14 -0800
Message-ID: <b59331a1-567f-403c-9173-b0919bdd0f8e@quicinc.com>
Date: Mon, 29 Jan 2024 12:20:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/3] mmc: core: Add partial initialization support
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_cang@quicinc.com>, <quic_nguyenb@quicinc.com>,
        <quic_rampraka@quicinc.com>, <quic_pragalla@quicinc.com>,
        <quic_sayalil@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_sachgupt@quicinc.com>, <quic_bhaskarv@quicinc.com>,
        <quic_narepall@quicinc.com>, <kernel@quicinc.com>,
        Veerabhadrarao Badiganti
	<quic_vbadigan@quicinc.com>
References: <20231019054612.9192-1-quic_sartgarg@quicinc.com>
 <20231019054612.9192-2-quic_sartgarg@quicinc.com>
 <CAPDyKFofS16AsQeTVNiDi_PHUatGoQ3no-1+Azo+yqG0SPTe4Q@mail.gmail.com>
 <21208de0-79bc-42c7-b32f-355daf5b09f0@quicinc.com>
 <CAPDyKFrVNfqUxU2iGEDXrshOEKm1KROCHTPpSyDAgZPMPojfsg@mail.gmail.com>
Content-Language: en-US
From: Sarthak Garg <quic_sartgarg@quicinc.com>
In-Reply-To: <CAPDyKFrVNfqUxU2iGEDXrshOEKm1KROCHTPpSyDAgZPMPojfsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4RRZ3PVkPOHNZaSm6CJsg3skL3JrtV8D
X-Proofpoint-ORIG-GUID: 4RRZ3PVkPOHNZaSm6CJsg3skL3JrtV8D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_03,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290047



On 10/27/2023 3:23 PM, Ulf Hansson wrote:
> [...]
> 
>>>> +{
>>>> +       int err = 0;
>>>> +       struct mmc_card *card = host->card;
>>>> +
>>>> +       mmc_set_bus_width(host, host->cached_ios.bus_width);
>>>> +       mmc_set_timing(host, host->cached_ios.timing);
>>>> +       if (host->cached_ios.enhanced_strobe) {
>>>> +               host->ios.enhanced_strobe = true;
>>>> +               if (host->ops->hs400_enhanced_strobe)
>>>> +                       host->ops->hs400_enhanced_strobe(host, &host->ios);
>>>> +       }
>>>> +       mmc_set_clock(host, host->cached_ios.clock);
>>>> +       mmc_set_bus_mode(host, host->cached_ios.bus_mode);
>>>> +
>>>
>>> Rather than re-using the above APIs and the ->set_ios() callback in
>>> the host, I believe it would be better to add a new host ops to manage
>>> all of the above at once instead. Something along the lines of the
>>> below, would then replace all of the above.
>>>
>>> host->ops->restore_ios(host, &host->cached_ios)
>>> memcpy(&host->ios, &host->cached_ios, sizeof(host->ios));
>>>
>>> Would that make sense to you too?
>>>
>>
>>
>> I didn't get this completely. Do you mean that we should implement a new
>> restore_ios callback (e.g. sdhci_restore_ios) similar to sdhci_set_ios
>> and removing all the redundant code from sdhci_set_ios which should
>> achieve the behaviour same as calling all the above mmc_set_* API's ?
> 
> Correct. Would it not simply the things in the driver too?
> 
>>
>>
>>>> +       if (!mmc_card_hs400es(card) &&
>>>> +                       (mmc_card_hs200(card) || mmc_card_hs400(card))) {
>>>> +               err = mmc_execute_tuning(card);
>>>> +               if (err) {
>>>> +                       pr_err("%s: %s: Tuning failed (%d)\n",
>>>> +                               mmc_hostname(host), __func__, err);
>>>
>>> There is already a print being done in mmc_execute_tuning() at
>>> failure. So, let's drop the above print.
>>>
>>
>> Sure will take care in V4.
>>
>>>> +                       goto out;
>>>> +               }
>>>> +       }
>>>> +
>>>> +       err = mmc_test_awake_ext_csd(host);
>>>
>>> Again, I don't get why this is needed, so let's discuss this more.
>>>
>>
>> This is just a safety check added because ext_csd has some W/E_P or
>> W/C_P registers which gets reset if any HW reset happens to the card.
>> So this will check for those cases if any other vendor is doing reset as
>> part of suspend and compare a subset of those W/E_P and W/C_P registers
>> and if they are changed then we will bail out of this partial init
>> feature and go for full initialization.
>> We are also fine with removing this function but just added for the
>> above mentioned case.
> 
> In that case, I would rather remove it as I think it's superfluous.
> 
> More precisely, I would expect that we fail to wake up the card with a
> CMD5 (get an error response for the CMD) if there has been a HW reset
> somewhere done before.
> 
> Another reason to *not* read the ext_csd would be to further improve
> the resume time, as reading it takes time too. I would be curious to
> know how much though. :-)
> 
> [...]
> 
> Kind regards
> Uffe

Hi ulf,

Sorry for the delay but we are seeing some stability issues when testing 
this feature with HS400 cards which I am debugging and may take some 
time and will come back.
Note: This feature is working perfectly fine with HS400ES cards.

