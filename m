Return-Path: <linux-kernel+bounces-53978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8722184A8B0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B953B1C241DB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35F056B99;
	Mon,  5 Feb 2024 21:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iaXU7vLr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9885756B60;
	Mon,  5 Feb 2024 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707168495; cv=none; b=Szn3ZqsKh/2BYep+KagLjtioNXIuM1lR62j3GjXy7kUQYPHhf3LiwA+tagMyh86s2SHUY7tw2rv5Yscsjpc9pSU8llU4yb/OVF/YeNmcNJp5GJ1a0KOQvDB7S070y1UKmEKQkIbiFiJnec/37o7j1812L5EpNUqVgV08ozCDoJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707168495; c=relaxed/simple;
	bh=5lrum/AjuJwqk20RkwGk9tqExlYNgPl6td00iapqChA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BE+fhy6CXg7b2qGcyc0C5cVUpLo3OmwXjcgJekA1I+ebCh2CsnwC1MX2UPErE+1goqizmH5G9+RPEQmEC7rxPpPDQYMeu8bQDeeUP29URQLNBGG183QwUIeOZ9m5ouab8j8rokWV6IFPCOAXvQDx9XZGClTqsyw2pkwVxvWvPuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iaXU7vLr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 415LASOj014430;
	Mon, 5 Feb 2024 21:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=zUMiOKcNb14lRNC0PHgjnPf539O7z/gNiVeRfyHYiCg=; b=ia
	XU7vLrUjhuLqT39+iCG6Wem2p9KvnCKurTv96O1oN1ZPATRdOwCtKTWtyauoxOz+
	y1pASrsqIrWMpXq+GiYzsF/S7iRE1XTX1JOLv9Zj/8UeY7NyqthiOMXSKj6ZLjUg
	dIDxFBsTyRgcDR/fHFyKo+zDwKcI6pAav/6wFjD2sTZqSovIbrSI4pSlMjSuJRMW
	vJhkZKxQwtnmfBSGduZux9uMHXSthdWo8btz8/60el/vHuYE/5M24vSlGmU7AC0X
	KW9vJaAtNARfIkxC2HiE1pnHIMDlp0NRIQrbOq10qx1qc0Yg2Jr4IskqRo3YMEHd
	Cl/BZWSpmj9jfgzZYTYg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2t9wswnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 21:27:54 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415LRsX1010093
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 21:27:54 GMT
Received: from [10.110.7.251] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 13:27:52 -0800
Message-ID: <4d03b2cf-3b97-a066-15a5-245228813253@quicinc.com>
Date: Mon, 5 Feb 2024 13:27:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v13 50/53] ALSA: usb-audio: Allow for rediscovery of
 connected USB SND devices
Content-Language: en-US
To: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
	<amadeuszx.slawinski@linux.intel.com>,
        <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
References: <20240203023645.31105-1-quic_wcheng@quicinc.com>
 <20240203023645.31105-51-quic_wcheng@quicinc.com>
 <aaa76d7a-4299-4e1c-83f1-cbbea763927f@linux.intel.com>
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <aaa76d7a-4299-4e1c-83f1-cbbea763927f@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Fhx4-0QTJ2jvgXTCbibMBpUNgQgwTlk5
X-Proofpoint-ORIG-GUID: Fhx4-0QTJ2jvgXTCbibMBpUNgQgwTlk5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_15,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050161

Hi Amadeusz,

On 2/5/2024 1:01 AM, Amadeusz Sławiński wrote:
> On 2/3/2024 3:36 AM, Wesley Cheng wrote:
>> In case of notifying SND platform drivers of connection events, some of
>> these use cases, such as offloading, require an ASoC USB backend 
>> device to
>> be initialized before the events can be handled.  If the USB backend 
>> device
>> has not yet been probed, this leads to missing initial USB audio device
>> connection events.
>>
>> Expose an API that traverses the usb_chip array for connected devices, 
>> and
>> to call the respective connection callback registered to the SND platform
>> driver.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   sound/usb/card.c                  | 19 +++++++++++++++++++
>>   sound/usb/card.h                  |  2 ++
>>   sound/usb/qcom/qc_audio_offload.c |  2 ++
>>   3 files changed, 23 insertions(+)
>>
>> diff --git a/sound/usb/card.c b/sound/usb/card.c
>> index 11b827b7a2a5..995b2df676ab 100644
>> --- a/sound/usb/card.c
>> +++ b/sound/usb/card.c
>> @@ -202,6 +202,25 @@ struct snd_usb_stream 
>> *snd_usb_find_suppported_substream(int card_idx,
>>   }
>>   EXPORT_SYMBOL_GPL(snd_usb_find_suppported_substream);
>> +/*
>> + * in case the platform driver was not ready at the time of USB SND
>> + * device connect, expose an API to discover all connected USB devices
>> + * so it can populate any dependent resources/structures.
>> + */
>> +void snd_usb_rediscover_devices(void)
>> +{
>> +    int i;
>> +
>> +    mutex_lock(&register_mutex);
>> +    for (i = 0; i < SNDRV_CARDS; i++) {
>> +        if (usb_chip[i])
>> +            if (platform_ops && platform_ops->connect_cb)
>> +                platform_ops->connect_cb(usb_chip[i]);
> 
> if inside if, it can just be && or maybe move callback check before 
> mutex lock and just return early if it is not present?
> 

Thanks for pointing that out.  Makes sense, and will update it.

Thanks
Wesley Cheng

