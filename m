Return-Path: <linux-kernel+bounces-58656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B2684E98C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E66328AA36
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866A038F86;
	Thu,  8 Feb 2024 20:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k+2O+Jy9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EB5381CD;
	Thu,  8 Feb 2024 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707423581; cv=none; b=ALtz/4uYFCYy6WrOZHaD8WRSpJ+9ycuVj3PJk3JKL6vnC3P3EoGLfAmP8EZ4TUxTw5ZXCsJ2qUfFWUF7BOY1QiTgkTJs47ylfwlFgVdPbzeBbDZkKIf5/MXD66NhwjTkXROFkni36n9bbRJvPq+Nn6VdKjN8JSdY3862zoyc63Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707423581; c=relaxed/simple;
	bh=KoX6/dH/ZO/n9dDUKYIGb1+9d9iUc6gih8G9MENNf8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Wb+SEcUqWSoBK0MiKKXj0Dw0iPwXGkmrWFBLT8UXmabjDaN5ataK6AS5CV62MsojsITGhdcz2nbTlwILjbEHmLToYxHgxCGgIb/QrIkPjuaTTrBTng6TrDV4+IBGogeUE7PsIIBvwrQYQ+BdtHv39AKrK3AQrkwGI9xPmjvbZyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k+2O+Jy9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 418JMagL007228;
	Thu, 8 Feb 2024 20:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=zgbdh6muC5CIDlTbm/Olgojw+ypqBJvtgGxGHbGnTuU=; b=k+
	2O+Jy9WJdxhhcSdIoNwTqlHcsec5kUGzZGxNGGE1BYEwvA0OrMbRrDObvRuLJrfd
	5YbMeg4gy4UTRX2NvqxZYGJ0jnkAQr2+Gb5hfwvJG7YNwmNqq/AQkKR2m1B0KbXo
	0rSQt4oR7rww7kTuLfoSJm06gkV0ayw13cPE6cAsQOnajqt695lzWZa/4Qbv0B1Z
	UL9deOPAiIN2Yr5j7RCHCf75RG4yeMbOyZmvn6sy7Meuz7RPv8xHm00hfSfcJeCC
	md+AyWuI9UXy2TxB0xO1S+AGeN8t6WbDkElPFXl+64MS79eLciPcCOtloXqLgDgK
	rDyurEzUYmQydjhGvalA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4uphsn8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 20:19:16 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 418KJFn9002954
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 20:19:15 GMT
Received: from [10.71.114.174] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 8 Feb
 2024 12:19:14 -0800
Message-ID: <cfcedbc9-e176-754a-9a34-cfca8d6a3984@quicinc.com>
Date: Thu, 8 Feb 2024 12:19:11 -0800
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
 <ef83036f-6605-1db3-d962-ac28a10711ac@quicinc.com>
 <877cjg7o0k.wl-tiwai@suse.de>
 <810161b3-4d98-755f-163f-fdfc9fe37063@quicinc.com>
 <0cb39613-ec01-50aa-807f-b537f201dac0@quicinc.com>
 <87zfwb4ao9.wl-tiwai@suse.de>
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <87zfwb4ao9.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: W_MHakuDFKPLnhTMumi8mAzEgAPqJOjJ
X-Proofpoint-GUID: W_MHakuDFKPLnhTMumi8mAzEgAPqJOjJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_10,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxlogscore=800
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402080108

Hi Takashi,

On 2/8/2024 12:33 AM, Takashi Iwai wrote:
> On Thu, 08 Feb 2024 02:12:00 +0100,
> Wesley Cheng wrote:
>>
>> Hi Takashi,
>>
>> On 2/7/2024 4:02 PM, Wesley Cheng wrote:
>>> Hi Takashi,
>>>
>>> On 2/6/2024 11:05 PM, Takashi Iwai wrote:
>>>> On Wed, 07 Feb 2024 01:08:00 +0100,
>>>> Wesley Cheng wrote:
>>>>>
>>>>> Hi Takashi,
>>>>>
>>>>> On 2/6/2024 5:07 AM, Takashi Iwai wrote:
>>>>>> On Sat, 03 Feb 2024 03:36:27 +0100,
>>>>>> Wesley Cheng wrote:
>>>>>>>
>>>>>>> With USB audio offloading, an audio session is started from the ASoC
>>>>>>> platform sound card and PCM devices.  Likewise, the USB SND path
>>>>>>> is still
>>>>>>> readily available for use, in case the non-offload path is
>>>>>>> desired.  In
>>>>>>> order to prevent the two entities from attempting to use the USB bus,
>>>>>>> introduce a flag that determines when either paths are in use.
>>>>>>>
>>>>>>> If a PCM device is already in use, the check will return an error to
>>>>>>> userspace notifying that the stream is currently busy.  This
>>>>>>> ensures that
>>>>>>> only one path is using the USB substream.
>>>>>>>
>>>>>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>>>>>
>>>>>> Hm, I'm not sure whether it's safe to hold chip->mutex there for the
>>>>>> long code path.  It even kicks off the auto-resume, which may call
>>>>>> various functions at resuming, and some of them may re-hold
>>>>>> chip->mutex.
>>>>>>
>>>>>
>>>>> That's a good point.
>>>>>
>>>>>> If it's only about the open flag, protect only the flag access with
>>>>>> the mutex, not covering the all open function.  At least the re-entry
>>>>>> can be avoided by that.
>>>>>>
>>>>>
>>>>> Sure, let me re-order the check/assignment and the mutex locking.
>>>>> Since this is now checked here in USB PCM and the QC offload driver,
>>>>> we want to make sure that if there was some application attempting to
>>>>> open both at the same time, we prevent any possible races.
>>>>>
>>>>> I think the best way to address this would be something like:
>>>>>
>>>>> static int snd_usb_pcm_open(struct snd_pcm_substream *substream)
>>>>> {
>>>>> ...
>>>>>      mutex_lock(&chip->mutex);
>>>>>      if (subs->opened) {
>>>>>          mutex_unlock(&chip->mutex);
>>>>>          return -EBUSY;
>>>>>      }
>>>>>      subs->opened = 1;
>>>>>      mutex_unlock(&chip->mutex);
>>>>>
>>>>> //Execute bulk of PCM open routine
>>>>> ...
>>>>>      return 0;
>>>>>
>>>>> // If any errors are seen, unwind
>>>>> err_resume:
>>>>>      snd_usb_autosuspend(subs->stream->chip);
>>>>> err_open:
>>>>>      mutex_lock(&chip->mutex);
>>>>>      subs->opened = 0;
>>>>>      mutex_unlock(&chip->mutex);
>>>>>
>>>>>      return ret;
>>>>> }
>>>>>
>>>>> Set the opened flag first, so that if QC offload checks it, it can
>>>>> exit early and vice versa.  Otherwise, if we set the opened flag at
>>>>> the same position as the previous patch, we may be calling the other
>>>>> routines in parallel to the QC offload enable stream routine.  The
>>>>> only thing with this patch is that we'd need some error handling
>>>>> unwinding.
>>>>
>>>> The above is what I had in mind.
>>>>
>>>> But, thinking on this again, you might be able to get the same result
>>>> by using the ALSA PCM core substream open_mutex and hw_opened flag.
>>>> This is already held and set at snd_pcm_core() (the hw_opened flag is
>>>> set after open callback, though).  The offload driver can use those
>>>> instead of the own lock and flag, too, although it's not really
>>>> well-mannered behavior (hence you need proper comments).
>>>>
>>>
>>> I think I had looked into this as well previously, and it was
>>> difficult to achieve, because from the USB offloading perspective,
>>> we don't ever call: snd_usb_pcm_open()
>>>
>>> This is actually where we populate the pcm_substream parameter
>>> within struct snd_usb_substream based on when userspace opens the
>>> USB SND PCM device (which is not the case for offloading).  So the
>>> offload driver doesn't have a way to fetch the struct snd_pcm that
>>> is allocated to the PCM device created by the USB SND card.
>>>
>>
>> Sorry, took a look at it again, and found a way.  Although not pretty,
>> we can access it using:
>> subs->stream->pcm->streams[direction].substream->hw_opened
> 
> Yes, it's not easy to follow it.  So if we want to this path, worth
> for a detailed comment.  That said, I don't mind to introduce the new
> local mutex and flag as you did if the above became too messy in the
> end.
> 

If you don't mind, I prefer to keep it the way it was with the local 
mutex and flag.  It makes it a lot easier to follow, and for other users 
to adopt as well compared to the long equation above :).

Thanks
Wesley Cheng

