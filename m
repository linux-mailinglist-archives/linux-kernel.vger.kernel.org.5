Return-Path: <linux-kernel+bounces-57311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF5884D6E4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809A91C22679
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA807DDBC;
	Thu,  8 Feb 2024 00:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jUlib+aS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743C446AF;
	Thu,  8 Feb 2024 00:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707350684; cv=none; b=ePnauxMd0rV0ChGfIZbsgw5C4FUaljosVbosE10Si2PRbcMwdznTMcrqCkK2lrkPSCKNyLRvWDDqOJdViTg4mJpMgRNGCOe6cwXhR9W6YlDqWwRY6d2N8HZMLxCCbWW8S49H+Elc13aGBySFOTWRWrlrlVSkV49SO7cAAt7LhIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707350684; c=relaxed/simple;
	bh=ilrQ/9LuZDX3mrl5dNwhmIXKDyFoTCwolgQjG3Eibtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VZzEwetSfzr20T5EFM2PaJo293SvShW5llF32KU3Fvu0ZyoFTZh3WBxExFylfEsJO6MUtXmT5mYSoF1jBTNVcTKtcg64PWvZoFe6jEXVbuXsmTVLmMRZ39njHF4N8sX3EjarWShNpxOni1BGnw0fUCmfYohrnfJDB10iPdPIdZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jUlib+aS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 417MhqUY009783;
	Thu, 8 Feb 2024 00:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=E05zi/rPFwDZHIzMSBw0q9VxXlsGxPnbK3/aaNx+pdM=; b=jU
	lib+aS4ZOxjiUKV9YuPKlRPVczefcqBln6VnYTVdpVLHOR+NYlqdkQNDDa+cGsxc
	yLviQPIRlBdWxm+ggru+wUQx6I4PUZQ/F6XZ1nqdDVt1jmaJScoe8BNDN3QPjFO0
	vZ2eZcJeAzFco5/TEHbEZLq5iFenPBfGP8UpgNGwhTQ1tG04XZ8XySIvd+d5gm4Y
	2JN1FtmGyWEV4KqPX/rDjc1IKDRGTCA9acC9crosl78uPPZpPvMLyS6PWzT3U1AW
	mMmEQzQnb+Q5yGFiKA+5FTQReOdnfYsC+oeZJHL/WG3OIFq+KqB3SN6CD/JAOZTp
	RsexaupAHoUGgkB/g+dQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w42eatbb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 00:04:23 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41804Moq029693
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 00:04:22 GMT
Received: from [10.110.36.76] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 7 Feb
 2024 16:04:21 -0800
Message-ID: <93c42ced-eb48-ce92-710e-081a48bea79b@quicinc.com>
Date: Wed, 7 Feb 2024 16:04:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v13 32/53] ALSA: usb-audio: Check for support for
 requested audio format
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@linuxfoundation.org>
CC: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Thinh.Nguyen@synopsys.com>,
        <broonie@kernel.org>, <bgoswami@quicinc.com>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
References: <20240203023645.31105-1-quic_wcheng@quicinc.com>
 <20240203023645.31105-33-quic_wcheng@quicinc.com>
 <87wmrhvir7.wl-tiwai@suse.de> <2024020617-limb-name-f852@gregkh>
 <87sf25wsnc.wl-tiwai@suse.de>
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <87sf25wsnc.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9JvJsVoRoOVsJncicwpJMC9jF4dja2UL
X-Proofpoint-ORIG-GUID: 9JvJsVoRoOVsJncicwpJMC9jF4dja2UL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_09,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=943 phishscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402070175



On 2/6/2024 6:53 AM, Takashi Iwai wrote:
> On Tue, 06 Feb 2024 15:50:21 +0100,
> Greg KH wrote:
>>
>> On Tue, Feb 06, 2024 at 02:12:44PM +0100, Takashi Iwai wrote:
>>> On Sat, 03 Feb 2024 03:36:24 +0100,
>>> Wesley Cheng wrote:
>>>>
>>>> Allow for checks on a specific USB audio device to see if a requested PCM
>>>> format is supported.  This is needed for support when playback is
>>>> initiated by the ASoC USB backend path.
>>>>
>>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>>
>>> Just cosmetic:
>>>
>>>> +struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
>>>> +			struct snd_pcm_hw_params *params, int direction)
>>>> +{
>>>> +	struct snd_usb_audio *chip;
>>>> +	struct snd_usb_substream *subs;
>>>> +	struct snd_usb_stream *as;
>>>> +	const struct audioformat *fmt;
>>>> +
>>>> +	/*
>>>> +	 * Register mutex is held when populating and clearing usb_chip
>>>> +	 * array.
>>>> +	 */
>>>> +	mutex_lock(&register_mutex);
>>>> +	chip = usb_chip[card_idx];
>>>> +	if (!chip) {
>>>> +		mutex_unlock(&register_mutex);
>>>> +		return NULL;
>>>> +	}
>>>> +
>>>> +	if (enable[card_idx]) {
>>>> +		list_for_each_entry(as, &chip->pcm_list, list) {
>>>> +			subs = &as->substream[direction];
>>>> +			fmt = snd_usb_find_substream_format(subs, params);
>>>> +			if (fmt) {
>>>> +				mutex_unlock(&register_mutex);
>>>> +				return as;
>>>> +			}
>>>> +		}
>>>> +	}
>>>> +	mutex_unlock(&register_mutex);
>>>
>>> I prefer having the single lock/unlock call pair, e.g.
>>>
>>> 	struct snd_usb_stream *as, *ret;
>>>
>>> 	ret = NULL;
>>> 	mutex_lock(&register_mutex);
>>> 	chip = usb_chip[card_idx];
>>> 	if (chip && enable[card_idx]) {
>>> 		list_for_each_entry(as, &chip->pcm_list, list) {
>>> 			subs = &as->substream[direction];
>>> 			if (snd_usb_find_substream_format(subs, params)) {
>>> 				ret = as;
>>> 				break;
>>> 			}
>>> 		}
>>> 	}
>>> 	mutex_unlock(&register_mutex);
>>> 	return ret;
>>> }
>>>
>>> In this case, we shouldn't reuse "as" for the return value since it
>>> can be non-NULL after the loop end.
>>
>> Why not just use guard(mutex) for this, making it all not an issue?
> 
> Heh, it's too new ;)
> That should work gracefully, yes.
> 

Thanks Greg/Takashi.  That is nifty.

Thanks
Wesley Cheng

