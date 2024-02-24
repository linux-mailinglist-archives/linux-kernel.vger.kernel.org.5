Return-Path: <linux-kernel+bounces-79483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CC28622E6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 07:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D671F23A73
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 06:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D41717C8D;
	Sat, 24 Feb 2024 06:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J4TSy+Mm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE513FFF;
	Sat, 24 Feb 2024 06:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708755812; cv=none; b=bN+/on8d/N/vq9zOcyHVRsDrMyHk+EaNKM10Gx+ULTdEztlMECy/6kqAKVFYkGLLCMImU7tKKiRxom3BlRtvtwQQ6AQ0YACOCSS1BlKIV6Qg38IfMobRLZMdUZpAbIdJRnLA6P938BegO+0/qk5pb5ygGnG24IgyZWY2vPXTnfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708755812; c=relaxed/simple;
	bh=W0u5IT/H5hLXinO/B5FelGXdqlc5c1QwMVi0wEyDxCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OTzUWSACK4WTMvdwK7tB8K2rbTgdVz5ijhNdRVg/4Nyu8BejrMgVIEWJX0bcXGotLXh0UDNTeYEeGi7UgwDUjwQiM+RPaL96d5GnqMdmJN3YlpEOIlYjTV4/buj6N0NQMmR6KY9xQaBXTZ3AmbxkFBAn3FwA0x72Sqg9ytJUn6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J4TSy+Mm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41O5pM72004828;
	Sat, 24 Feb 2024 06:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=QCYPc8ZRVSnAHVFnIu3U13dqMb2KRmhi+yyRJZMHU5M=; b=J4
	TSy+MmWnctP1jtu2cXW9nSBuUjYMjc3VRLXJdbd3ywzS0ZW8jiRGtT2HY56pI8HF
	b1/g3fTj0RAGMyGNv6IjywbpmWNlF6bdeobrLbiFM/MhZbbTEDPud84mRYMQiiTP
	jGRz4AHhqhfNjwQXt7tOWgPmRbC0XaJf0bchSnUWrMfGfiZ3T6hBF6hHF/19msue
	LXyvwcVBniQzj5XzuZaoEbs8W6FFIuCBfPLU4z2IcKGTaYbOZk5FVwDzDZva2Spe
	qwXVcbzHuzpzymPJqTm4nVXKpCwpVRYVZbZ3nX0XGb81r+wbyfWq0pPKMNSYnRGD
	pMZ2hdiQ2XECFTNQw42A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wf65hrbbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Feb 2024 06:22:57 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41O6MuwG006607
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Feb 2024 06:22:56 GMT
Received: from [10.110.15.108] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 22:22:55 -0800
Message-ID: <76922981-88ec-a376-ce61-ea1ff85f43d2@quicinc.com>
Date: Fri, 23 Feb 2024 22:22:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v14 32/53] ALSA: usb-audio: Check for support for
 requested audio format
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
CC: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <alsa-devel@alsa-project.org>
References: <20240208231406.27397-1-quic_wcheng@quicinc.com>
 <20240208231406.27397-33-quic_wcheng@quicinc.com>
 <87v86x2a27.wl-tiwai@suse.de>
 <cb3b7857-dc6c-80db-4fa7-6772a856f328@quicinc.com>
 <7f0c4f85-5a63-4643-8553-e3f5d6af67ec@quicinc.com>
 <87y1bjpfn0.wl-tiwai@suse.de>
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <87y1bjpfn0.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Q1NKQpUrdoWd5O5aWBixNCa6-08HgSIz
X-Proofpoint-GUID: Q1NKQpUrdoWd5O5aWBixNCa6-08HgSIz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-24_02,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=949 suspectscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402240050

Hi Takashi,

On 2/17/2024 2:08 AM, Takashi Iwai wrote:
> On Sat, 17 Feb 2024 00:42:18 +0100,
> Wesley Cheng wrote:
>>
>> Hi Takashi,
>>
>> On 2/9/2024 1:34 PM, Wesley Cheng wrote:
>>> Hi Takashi,
>>>
>>> On 2/9/2024 2:42 AM, Takashi Iwai wrote:
>>>> On Fri, 09 Feb 2024 00:13:45 +0100,
>>>> Wesley Cheng wrote:
>>>>>
>>>>> Allow for checks on a specific USB audio device to see if a
>>>>> requested PCM
>>>>> format is supported.  This is needed for support when playback is
>>>>> initiated by the ASoC USB backend path.
>>>>>
>>>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>>>> ---
>>>>>    sound/usb/card.c | 31 +++++++++++++++++++++++++++++++
>>>>>    sound/usb/card.h | 11 +++++++++++
>>>>>    2 files changed, 42 insertions(+)
>>>>>
>>>>> diff --git a/sound/usb/card.c b/sound/usb/card.c
>>>>> index 7dc8007ba839..1ad99a462038 100644
>>>>> --- a/sound/usb/card.c
>>>>> +++ b/sound/usb/card.c
>>>>> @@ -155,6 +155,37 @@ int snd_usb_unregister_platform_ops(void)
>>>>>    }
>>>>>    EXPORT_SYMBOL_GPL(snd_usb_unregister_platform_ops);
>>>>> +/*
>>>>> + * Checks to see if requested audio profile, i.e sample rate, # of
>>>>> + * channels, etc... is supported by the substream associated to the
>>>>> + * USB audio device.
>>>>> + */
>>>>> +struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
>>>>> +            struct snd_pcm_hw_params *params, int direction)
>>>>> +{
>>>>> +    struct snd_usb_audio *chip;
>>>>> +    struct snd_usb_substream *subs;
>>>>> +    struct snd_usb_stream *as;
>>>>> +
>>>>> +    /*
>>>>> +     * Register mutex is held when populating and clearing usb_chip
>>>>> +     * array.
>>>>> +     */
>>>>> +    guard(mutex)(&register_mutex);
>>>>> +    chip = usb_chip[card_idx];
>>>>> +
>>>>> +    if (chip && enable[card_idx]) {
>>>>> +        list_for_each_entry(as, &chip->pcm_list, list) {
>>>>> +            subs = &as->substream[direction];
>>>>> +            if (snd_usb_find_substream_format(subs, params))
>>>>> +                return as;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    return NULL;
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(snd_usb_find_suppported_substream);
>>>>> +
>>>>>    /*
>>>>>     * disconnect streams
>>>>>     * called from usb_audio_disconnect()
>>>>> diff --git a/sound/usb/card.h b/sound/usb/card.h
>>>>> index 02e4ea898db5..ed4a664e24e5 100644
>>>>> --- a/sound/usb/card.h
>>>>> +++ b/sound/usb/card.h
>>>>> @@ -217,4 +217,15 @@ struct snd_usb_platform_ops {
>>>>>    int snd_usb_register_platform_ops(struct snd_usb_platform_ops *ops);
>>>>>    int snd_usb_unregister_platform_ops(void);
>>>>> +
>>>>> +#if IS_ENABLED(CONFIG_SND_USB_AUDIO)
>>>>> +struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
>>>>> +            struct snd_pcm_hw_params *params, int direction);
>>>>> +#else
>>>>> +static struct snd_usb_stream
>>>>> *snd_usb_find_suppported_substream(int card_idx,
>>>>> +            struct snd_pcm_hw_params *params, int direction)
>>>>> +{
>>>>> +    return NULL;
>>>>> +}
>>>>> +#endif /* IS_ENABLED(CONFIG_SND_USB_AUDIO) */
>>>>
>>>> The usefulness of ifdef guard here is doubtful, IMO.  This header is
>>>> only for USB-audio driver enablement, and not seen as generic
>>>> helpers.  So, just add the new function declarations without dummy
>>>> definitions.
>>>>
>>>
>>> Got it, will remove it.  We also have a dependency in place for the
>>> qc_audio_offload driver and SND USB AUDIO in the Kconfig.
>>>
>>
>> Looking at this again after trying some mixed Kconfig settings.  These
>> declarations aren't specific for USB-audio.  They are helpers that are
>> exposed to soc usb, so that it can do some basic verification with soc
>> usb before allowing the enable stream to continue.
> 
> Then rather the question is why snd-soc-usb calls those functions
> *unconditionally*.  No matter whether we have dependencies in Kconfig,
> calling the function means that the callee shall be drug when the
> corresponding code is running.
> 
> If it were generic core API stuff such as power-management or ACPI,
> it'd make sense to define dummy functions without the enablement, as
> many code may have optional calls.  If the API is enabled, it's anyway
> in the core.  If not, it's optional.  That'll be fine.
> 
> OTOH, the stuff you're calling certainly belongs to snd-usb-audio.
> Even if the call is really optional, it means that you'll have a hard
> dependency when snd-usb-audio is built, no matter whether you need or
> not.
> 
>> Since the ASoC
>> layer doesn't have insight on what audio profiles are supported by the
>> usb device, this API will ensure that the request profile is
>> supported.
>>
>> Issues are seen when we disable SND USB audio config and enable the
>> ASoC parts.
> 
> If snd-usb-audio is disabled, what snd-soc-usb would serve at all?
> Does it still make sense to keep it enabled?
> That said, the statement above (building snd-soc-usb without
> snd-usb-audio) looks already dubious; isn't it better to have a proper
> dependency in Kconfig, instead?
> 

Ok, took a look at it a bit more and should have gotten all the 
dependencies addressed through Kconfigs.  Thanks for the review comments 
and feedback.

Thanks
Wesley Cheng

