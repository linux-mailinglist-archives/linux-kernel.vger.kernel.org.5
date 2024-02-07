Return-Path: <linux-kernel+bounces-55754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AB984C13F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C1FBB25276
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0171E3D6B;
	Wed,  7 Feb 2024 00:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EAVvHDP6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918C3DDA7;
	Wed,  7 Feb 2024 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707264536; cv=none; b=Z25bdH2waPyoqu+fxqpNJVgSd03xrt25IiF2rh1g4sj08mKn7mEWaScZJsNdDnd9b7AppPOYlHkpTOQOI7nEqhAe4Z6OyCrUjeWREewQNOfQRWhO1I8J47r0WDfPR6ef/ijgz3yk6LJMUKATp7xX4Y1eGaATxfxQdD78RbyEvJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707264536; c=relaxed/simple;
	bh=g1wkrCHZJPUJiczeRtLCyl0OxKSBFtJD7ZdL0Innc3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X43a/33vqNiotYWI91xWTgCPLit/JotLVASVeSWWKeYchhp1otLaIl6hRN5E0Frpl0nWdZ8/c1S5dfK/QavQbAty+HPmmQehgmlETlQ2JLF65xGi/stnnmxW0012crQ8q6XFuYP7HbYuYqQx38kEYpHtvloKDsBN51cLJOqP3s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EAVvHDP6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 416N3por015273;
	Wed, 7 Feb 2024 00:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Br0O+jemYZqsYtS1SyNg5WN/92FNWZLdy8IQgi7FiCE=; b=EA
	VvHDP67eE8M5AXnA7zoxlhD6DH7oYiEWpyHgK8vgzv6UrRxMbG9AvhWPGCn4ZK3e
	GxI/p/main661p0/ik89OTPjkAnfXjkOiPrjHS8HdvgTxtaOMp+5x2zTYyI6v1XX
	RJ7JLmtFfCN8g9lwQ5R3DJZ873X4GW0rYwAlh9m4mVSEhPZHPldo/rTl+cllRI+K
	kMg6qQangFv4O8m6Enl1SuCQf5v5WrhrPx44BW9f2tpynoJy3b6Iimm7hVEqoUqX
	Cc8t+seSUb/BtSVfXrl0oN/cwFvUhFTQ+MJWYABWnuOSiZMneenGt+dQCQVWEpQK
	tIQajXN7MpkBSn4wvlOQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3hyvhtqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 00:08:38 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41708bRo007736
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Feb 2024 00:08:37 GMT
Received: from [10.110.7.251] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 6 Feb
 2024 16:08:36 -0800
Message-ID: <75f8962c-192b-b7a4-1eae-35d8c46a7d74@quicinc.com>
Date: Tue, 6 Feb 2024 16:08:36 -0800
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
References: <20240203023645.31105-1-quic_wcheng@quicinc.com>
 <20240203023645.31105-33-quic_wcheng@quicinc.com>
 <87wmrhvir7.wl-tiwai@suse.de>
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <87wmrhvir7.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ue4lzn1jeh_HbQIeyoDXs_Vu1MkEVnMz
X-Proofpoint-GUID: ue4lzn1jeh_HbQIeyoDXs_Vu1MkEVnMz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_15,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 phishscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060171

Hi Takashi,

On 2/6/2024 5:12 AM, Takashi Iwai wrote:
> On Sat, 03 Feb 2024 03:36:24 +0100,
> Wesley Cheng wrote:
>>
>> Allow for checks on a specific USB audio device to see if a requested PCM
>> format is supported.  This is needed for support when playback is
>> initiated by the ASoC USB backend path.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> 
> Just cosmetic:
> 
>> +struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
>> +			struct snd_pcm_hw_params *params, int direction)
>> +{
>> +	struct snd_usb_audio *chip;
>> +	struct snd_usb_substream *subs;
>> +	struct snd_usb_stream *as;
>> +	const struct audioformat *fmt;
>> +
>> +	/*
>> +	 * Register mutex is held when populating and clearing usb_chip
>> +	 * array.
>> +	 */
>> +	mutex_lock(&register_mutex);
>> +	chip = usb_chip[card_idx];
>> +	if (!chip) {
>> +		mutex_unlock(&register_mutex);
>> +		return NULL;
>> +	}
>> +
>> +	if (enable[card_idx]) {
>> +		list_for_each_entry(as, &chip->pcm_list, list) {
>> +			subs = &as->substream[direction];
>> +			fmt = snd_usb_find_substream_format(subs, params);
>> +			if (fmt) {
>> +				mutex_unlock(&register_mutex);
>> +				return as;
>> +			}
>> +		}
>> +	}
>> +	mutex_unlock(&register_mutex);
> 
> I prefer having the single lock/unlock call pair, e.g.
> 
> 	struct snd_usb_stream *as, *ret;
> 
> 	ret = NULL;
> 	mutex_lock(&register_mutex);
> 	chip = usb_chip[card_idx];
> 	if (chip && enable[card_idx]) {
> 		list_for_each_entry(as, &chip->pcm_list, list) {
> 			subs = &as->substream[direction];
> 			if (snd_usb_find_substream_format(subs, params)) {
> 				ret = as;
> 				break;
> 			}
> 		}
> 	}
> 	mutex_unlock(&register_mutex);
> 	return ret;
> }
> 
> In this case, we shouldn't reuse "as" for the return value since it
> can be non-NULL after the loop end.
> 
> 
Sure will do, thanks for taking a look.

Thanks
Wesley Cheng

