Return-Path: <linux-kernel+bounces-55752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A6C84C135
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9607E1F254B7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150843C32;
	Wed,  7 Feb 2024 00:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y2PtoaEX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC873211;
	Wed,  7 Feb 2024 00:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707264514; cv=none; b=E9FV4t7npdx2jGBp7AUwUu02rGwTJVnYHsFf9chvd/1VGX3plX38O3vB7fhbmREwpV1EQJSIWKktDFH4nJqPkLKLZciyg2DXB4i0F27tAv+eRzcV8jcRfUSCXbyih1cPGuwtluJWtjPIwTbgQoX1x94D9AshGEsgJSMbm5sdzDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707264514; c=relaxed/simple;
	bh=mFIrM+Di9InkZwQXHNBXM1hyZVucQXVbLEjHXOAJ6EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IOlFx9aWnUTEPXOBUwVkNi1zXCh8qPxkV/BOqnRRuZZ3fYw6PTM4RHRG8jz3LhvX91f9SYy02xE1mSXpyqmP/cP5KUD00ht3mrXG9fy+0cb0ksbMpvjwjnQDbHPOL5hJUy4dkGYru6/3j7Q5/yCiSgMoNAQfHDIiKLeOsXJDQzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y2PtoaEX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 416NpWNL030915;
	Wed, 7 Feb 2024 00:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+D4nktpCYUtZM2am9USds2jdVYtzFu8/AHIYCkKZE+I=; b=Y2
	PtoaEXIjnihGpiCg6oKnkBK+zLcYcdmGipTAQM46Fnqz4sDXtlGo2eaqgQgACc60
	3Bu3KpgMW8IphxFDY35ZlAXW5aNNFnocXJ3kAEaeZbgVSpTYFsgCgwwMadCeW8L/
	a5guZ7DLbpURgr++VkhoAoLABkLdKuuDF9gCd15VVSKycv2OR+rCyOirlw9BBc0A
	H0V20CApS5+twrmoQs0kOlQf0efnsV44nS9poefHImTLf5Hl6cWYGQYWjo3akhC3
	9W2v62JUrvPUu7moPtfYUazJEvnNU/obI0TYf+zffZ/ADF3vPCX5sslCuzWjLHZG
	7XiTzbvjQ4WX0ZfD2l+w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3hyvhtp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 00:08:03 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4170823w004677
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Feb 2024 00:08:02 GMT
Received: from [10.110.7.251] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 6 Feb
 2024 16:08:01 -0800
Message-ID: <ef83036f-6605-1db3-d962-ac28a10711ac@quicinc.com>
Date: Tue, 6 Feb 2024 16:08:00 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v13 35/53] ALSA: usb-audio: Prevent starting of audio
 stream if in use
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
 <20240203023645.31105-36-quic_wcheng@quicinc.com>
 <87y1bxvj0o.wl-tiwai@suse.de>
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <87y1bxvj0o.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qIQyJL9pDt7huHZmKIMEX-BC0aAcy2JV
X-Proofpoint-GUID: qIQyJL9pDt7huHZmKIMEX-BC0aAcy2JV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_15,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=879
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 phishscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060171

Hi Takashi,

On 2/6/2024 5:07 AM, Takashi Iwai wrote:
> On Sat, 03 Feb 2024 03:36:27 +0100,
> Wesley Cheng wrote:
>>
>> With USB audio offloading, an audio session is started from the ASoC
>> platform sound card and PCM devices.  Likewise, the USB SND path is still
>> readily available for use, in case the non-offload path is desired.  In
>> order to prevent the two entities from attempting to use the USB bus,
>> introduce a flag that determines when either paths are in use.
>>
>> If a PCM device is already in use, the check will return an error to
>> userspace notifying that the stream is currently busy.  This ensures that
>> only one path is using the USB substream.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> 
> Hm, I'm not sure whether it's safe to hold chip->mutex there for the
> long code path.  It even kicks off the auto-resume, which may call
> various functions at resuming, and some of them may re-hold
> chip->mutex.
> 

That's a good point.

> If it's only about the open flag, protect only the flag access with
> the mutex, not covering the all open function.  At least the re-entry
> can be avoided by that.
> 

Sure, let me re-order the check/assignment and the mutex locking.  Since 
this is now checked here in USB PCM and the QC offload driver, we want 
to make sure that if there was some application attempting to open both 
at the same time, we prevent any possible races.

I think the best way to address this would be something like:

static int snd_usb_pcm_open(struct snd_pcm_substream *substream)
{
..
	mutex_lock(&chip->mutex);
	if (subs->opened) {
		mutex_unlock(&chip->mutex);
		return -EBUSY;
	}
	subs->opened = 1;
	mutex_unlock(&chip->mutex);

//Execute bulk of PCM open routine
..
	return 0;

// If any errors are seen, unwind
err_resume:
	snd_usb_autosuspend(subs->stream->chip);
err_open:
	mutex_lock(&chip->mutex);
	subs->opened = 0;
	mutex_unlock(&chip->mutex);

	return ret;
}

Set the opened flag first, so that if QC offload checks it, it can exit 
early and vice versa.  Otherwise, if we set the opened flag at the same 
position as the previous patch, we may be calling the other routines in 
parallel to the QC offload enable stream routine.  The only thing with 
this patch is that we'd need some error handling unwinding.

Thanks
Wesley Cheng

