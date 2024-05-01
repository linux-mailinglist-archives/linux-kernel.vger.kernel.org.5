Return-Path: <linux-kernel+bounces-164835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD2E8B83C4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5921EB223EA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28631522A;
	Wed,  1 May 2024 00:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D0fGt0cW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5A3646;
	Wed,  1 May 2024 00:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714523619; cv=none; b=aR7QeBWL7TTQMBbON2pSxyjcnayHwBkWYNyrzSrYKmBecl199+Gzpv4e7XjXflNPRMOh5uLO0yepB/SZtcR0Zp1ybL7KGsvETQG/F1+pvrO9+LTiV0VxlThFHDHhrVqKZjDG+LhahiNMxNDxfX4K641/MReiKOMEz0llvtKc/nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714523619; c=relaxed/simple;
	bh=3GxgYzbam8HgNyK+VdtYgp46UreAUNvtQ0s3h2WWRpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kwusV+vIE7JcjYgm3CUKJwJRdOPAG4tHbXLOlgZZ7rXt2J58kI4k039jZsGjgGkCEvVex/zF4C0Ukyb7axrkMKxbXRIEE49cG9dXtHIkimU19pIwSIrKR9G2pW09B4fL6PacPr2e5jxOc7zuIz96NuF5itzyFEoBSM8Qt6AMYC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D0fGt0cW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UNxo8v005742;
	Wed, 1 May 2024 00:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=LRnPNBK8fB5m3Wd6M+Ba4l+Ai4vlC8s1ZRRcL3qyiV8=; b=D0
	fGt0cWBkZIPWOJq1/d0Q52iDWMscdVnrML7zq7Mbq2eSO79vTDbgEhppVdmaZYB9
	W07e1ZyXYOAC1U9O8EZLDsYzZ/bpdB97r9bWIItYRofzjyHE/VY7+6V/JdLo6Fcx
	qY6g+5mkCVUTLisci98ZNdXtuwDMVR/rULDTu38jVUqwYaFijmmKAWZOdbSUYj+A
	pYi+sHTXkQW6eM6eGzbhl6MQ8jRsvz3fHaUHJahsaQ7ouVkBfc/FbF1I3Vi+BM9X
	h/s/nmOZbCRG4RGgMyTr+0iRCMdVjCr8fjnAXGop8Z5xU3QP8wIKGtaT/Ukm7qVz
	v/FZnk2+9pAbCBnH4CrA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtw1hj6qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 May 2024 00:32:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4410WQEC025873
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 1 May 2024 00:32:26 GMT
Received: from [10.110.61.50] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 17:32:25 -0700
Message-ID: <a1115d39-b60e-a5da-5c7e-79266d6ced17@quicinc.com>
Date: Tue, 30 Apr 2024 17:32:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v20 33/41] ASoC: usb: Create SOC USB SND jack kcontrol
Content-Language: en-US
To: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
	<amadeuszx.slawinski@linux.intel.com>,
        <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
References: <20240425215125.29761-1-quic_wcheng@quicinc.com>
 <20240425215125.29761-34-quic_wcheng@quicinc.com>
 <c8bd16e8-b204-471b-a702-36e14c8695c5@linux.intel.com>
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <c8bd16e8-b204-471b-a702-36e14c8695c5@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ciB1uOnPTSzQscrGnEx8GYc3pFB6UvC6
X-Proofpoint-ORIG-GUID: ciB1uOnPTSzQscrGnEx8GYc3pFB6UvC6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=877 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405010002

Hi Amadeusz,

On 4/26/2024 6:26 AM, Amadeusz Sławiński wrote:
> On 4/25/2024 11:51 PM, Wesley Cheng wrote:
>> Expose API for creation of a jack control for notifying of available
>> devices that are plugged in/discovered, and that support offloading.  
>> This
>> allows for control names to be standardized across implementations of USB
>> audio offloading.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
> 
> (...)
> 
>>   /* SOC USB sound kcontrols */
>> +/**
>> + * snd_soc_usb_setup_offload_jack() - Create USB offloading jack
>> + * @component: USB DPCM backend DAI component
>> + * @jack: jack structure to create
>> + *
>> + * Creates a jack device for notifying userspace of the availability
>> + * of an offload capable device.
>> + *
>> + * Returns 0 on success, negative on error.
>> + *
>> + */
>> +int snd_soc_usb_setup_offload_jack(struct snd_soc_component *component,
>> +                    struct snd_soc_jack *jack)
>> +{
>> +    int ret;
>> +
>> +    ret = snd_soc_card_jack_new(component->card, "USB Offload 
>> Playback Jack",
>> +                    SND_JACK_HEADPHONE, jack);
>> +    if (ret < 0) {
>> +        dev_err(component->card->dev, "Unable to add USB offload 
>> jack\n");
>> +        return ret;
>> +    }
>> +
>> +    ret = snd_soc_component_set_jack(component, jack, NULL);
>> +    if (ret) {
>> +        dev_warn(component->card->dev, "Failed to set jack: %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(snd_soc_usb_setup_offload_jack);
>> +
>>   static int snd_soc_usb_get_offload_card_status(struct snd_kcontrol 
>> *kcontrol,
>>                      struct snd_ctl_elem_value *ucontrol)
>>   {
>>
> 
> I'm not sure if this should be handled in generic USB API, this feels 
> like something that should be handled in specific device driver side, 
> like all users currently do.
> 

In some of the previous comments, it was mentioned that maybe it was 
better to have more consistent/defined naming across devices that do 
have support for audio offload.  Initially, I did have these within our 
vendor specific ASoC platform driver also.

> Anyway I think there should also be some function that tears jack down, 
> by calling:
> snd_soc_component_set_jack(component, NULL, NULL);
> so it can get cleaned up properly?

I can add that.  I didn't realize there were some situations where maybe 
components would want to disable the jack.  I will leave the cleanup 
part to ASoC when the platform card is removed.

Thanks
Wesley Cheng

