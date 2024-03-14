Return-Path: <linux-kernel+bounces-103790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7566887C486
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981251C215BD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312A176419;
	Thu, 14 Mar 2024 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VypaMdDu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF31B763E4;
	Thu, 14 Mar 2024 20:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710449865; cv=none; b=Z6vxvILyVPabkfbz8PGZ/b9JTCRCtyBNwtaUYNfUTg2FEl92PEyQLGSGBhxP6bkuyzLcI79j54kcLsJKCYxfnAAiXTU1kqwJFH/ukxUaDJ6PE4Bj7FoFJV6vJGBe5PVB16lsKzrkm3nzXZQxKsMKNOMEuBVw0v/PAyCPOk/jMUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710449865; c=relaxed/simple;
	bh=i/In70euOucOu10Yn4mf9BZSNHDbmPI7QOVoNvr1wN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e/Nq4/TEwD36LnwfEosxO1zQ3fEEQQu2hvpwD77PaGFMO+LjfsxX6KHSBJKrSl2hr8ZP9fTazr4zEoVQFJx9K7VGDKH0ePaU0qZ+A0xzaLIyzQJX4fxAyyO8QWFpOS7978NHMkwWtjs7FpIBJE0UxqlhT9jTc6UZ5fB1u3YnI6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VypaMdDu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42EKFsjk019502;
	Thu, 14 Mar 2024 20:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=i1RRwlY+GSx5CIfYwtnNU1qLUiFuXaO9rJ+b19a99LU=; b=Vy
	paMdDuLHTBjsvksPD2BnAdKbsOB51/5Li48ozD40T3l6rwY/B8nOD1KgUDng+sO3
	aiaKBQRFPLsVhYNNk1dD3NVvrA2h3AJs8i3LKGOkWHs91I3yKQS6k6Z8jXZAblbZ
	XnWX+kdgFjWTEj1sUGMlzP5+TQP0c3Ei+sRSCMdmlMD2M6GgRkigVqaZfBYHLpCA
	LC2sZrKu/v4LCyVOXaLBWxaJT/9sDaOofQ9xNSObmdPran5eK+ggiUNcp9u0YLSr
	gibSEaPxQ/pBdwBRDjOk/FkIOuSn23Ab+UZLXeuggME+SClx8erC9dBqmnIQtUZu
	mn4R55nTAKEDQkQ5LqJg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wv81bg2qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 20:57:21 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42EKvK31005345
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 20:57:20 GMT
Received: from [10.71.112.106] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Mar
 2024 13:57:19 -0700
Message-ID: <0e9f0f2f-a404-3b76-3c52-9eca7594efa3@quicinc.com>
Date: Thu, 14 Mar 2024 13:57:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v18 20/41] ALSA: usb-audio: qcom: Introduce QC USB SND
 offloading support
Content-Language: en-US
To: Albert Wang <albertccwang@google.com>
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
References: <20240228013619.29758-1-quic_wcheng@quicinc.com>
 <20240228013619.29758-21-quic_wcheng@quicinc.com>
 <CANqn-rjTgHgzssxZiuwvTKzOS31wzjS4Y9G-XacZN4a7c82MaA@mail.gmail.com>
 <d97f635f-053b-70a7-5ffe-a1ae273091d1@quicinc.com>
 <CANqn-ring2uf=A-F7VuRwnJ--n=FtFzSddCmR-=nfxCGcFAF2g@mail.gmail.com>
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <CANqn-ring2uf=A-F7VuRwnJ--n=FtFzSddCmR-=nfxCGcFAF2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hogKYBgJv_8ag5r84EkBXjMbinIFbgfn
X-Proofpoint-ORIG-GUID: hogKYBgJv_8ag5r84EkBXjMbinIFbgfn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403140161

Hi Albert

On 3/14/2024 3:29 AM, Albert Wang wrote:
> On Thu, Mar 14, 2024 at 3:18 AM Wesley Cheng <quic_wcheng@quicinc.com> wrote:
>>
>> Hi Albert,
>>
>> On 3/13/2024 1:03 AM, Albert Wang wrote:
>>> Hi Wesley,
>>>
>>> The suspend function `qc_usb_audio_offload_suspend()` looks to stop
>>> the traffic on the bus, so that the bus can be suspended. That allows
>>> the application processor(AP) to enter suspend. There is a subtle
>>> difference with our feature, which is to allow AP suspend with the
>>> Host and USB controller active to continue the audio offloading. We
>>> call this feature `allow AP suspend in playback`. So, I have some
>>> points to clarify with you:
>>
>> Yes, I'm aware of that feature also.
>>
>>> 1. Will the suspend flow `usb_audio_suspend() -->
>>> platform_ops->suspend_cb() --> qc_usb_audio_offload_suspend()` be
>>> called when offloading is active?
>>
>> It can be.  This is why in our case, we are going to issue the
>> disconnect event to the audio DSP to stop the session if it is currently
>> in one.
>>
>>> 2. As my understanding, the suspend function is to allow AP suspend
>>> when the offloading is IDLE, but it won't allow AP suspend when in
>>> playback or capture. Please correct me if anything is wrong.
>>
>> As mentioned above, it will let apps go into PM suspend after forcing
>> the audio stream to be idle.  We won't block PM suspend entry.
>>
> Right. Your design is to force the audio stream idle, or say, inform
> the audio DSP
> to stop the current offloading session first, then AP can go into PM
> suspend as usual.
> Then I can say the current design did not support the `allow AP
> suspend in playback`
> feature, right?
> 

Correct, this series does not cover this mechanism.

>> Yes, I saw that patch as well.  I'll take a look once this series lands
>> upstream.
> 
> That patch is rejected and archived now. So we need to find another
> approach to do
> that, even based on your framework.
> 

We can discuss that offline and come up with an approach that is 
reviewable by maintainers and the community.

Thanks
Wesley Cheng

> Thanks,
> Albert
> 
> 
>>> 3. We would like to integrate the `allow AP suspend in playback`
>>> feature with your framework to become one upstream offload solution.
>>> Here is the patch:
>>> https://patchwork.kernel.org/project/linux-pm/patch/20240223143833.1509961-1-guanyulin@google.com/
>>> .
>>
>> Yes, I saw that patch as well.  I'll take a look once this series lands
>> upstream.
>>
>> Thanks
>> Wesley Cheng

