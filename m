Return-Path: <linux-kernel+bounces-66087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A42485566E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67401F226AF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330301419B3;
	Wed, 14 Feb 2024 22:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b0TWz7o/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D6057872;
	Wed, 14 Feb 2024 22:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951498; cv=none; b=EhLKQ3AFOWmfqNF9W+iMZ9FAlRCrjfcKbEC+p7Jv9S5qB9CXG/XRrkJC2QbsmwhZqBg9wFtHr63Jyh6RYT84vHICzPywPdNihAvVMxnNyqzkzFP2x5u3sS4zhsy1WflKmGHKwR7DTnhvy/yaSLefNf/Zyrpj3KZPmS/79/sCgSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951498; c=relaxed/simple;
	bh=gSUvTrZr3rXl9rxa9h+n04kX3glePcNe2dBEl2CvPt4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=hp+7g7h6SbsZIvaxzzznNjUZL49xFkTxqQXf5PwzCOm0gclBd7pmrkFyRFGbMUZwl0L5bljuFbNpSB/yI1ZdRRC158GEUm/Ea1rFaZKFFK+HCHC8+KKaCuW9clj/h7Q1k5nzOl/fTzqDsXlAQAx0lMV4BZC+wj2240soanIQBfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b0TWz7o/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41ELrHsR010715;
	Wed, 14 Feb 2024 22:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:subject:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=P3WE3lMB3U1jVjyqfIrkGAFwODySyS5IO0j1eUTCPyk=; b=b0
	TWz7o/x3N8/AZ1opgEr/avUwTe6jB8c4OuL3f6079KX9ut38Qho6sMnDxX0/NXRl
	HF9luXKQE71ywu7/88LW1oFOxyhL4GgW3w37hUAn8grY5IK6NIxHgxtQkCcIcGvB
	/ROTjG1H+NIDuw05+h5w8TL+iMduX8yzNMv1Dcxhtf0CGb0n7QzBMnl+V2i2GnTu
	bGgQGVYb/vt9h8ydnmspVOxAbq5g3dcVhRW/397fx3YS2Cy23oRZvFKIaNBNlAiR
	XeWUvyRouBn57ifET7HUpot6IpyddxUxOylXbX5DTuwTJKoJ4uDgDZdUuDUV9ccf
	q4lMtWv3KqmsFRiSHLzQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w92fxghd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 22:57:52 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41EMvpng005245
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 22:57:51 GMT
Received: from [10.71.114.103] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 14 Feb
 2024 14:57:50 -0800
Message-ID: <f2952acb-4f9e-9283-a5bc-1b62164df9bc@quicinc.com>
Date: Wed, 14 Feb 2024 14:57:46 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From: Wesley Cheng <quic_wcheng@quicinc.com>
Subject: Re: [PATCH v15 39/50] ASoC: Introduce SND kcontrols to select sound
 card and PCM device
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
References: <20240213005422.3121-1-quic_wcheng@quicinc.com>
 <20240213005422.3121-40-quic_wcheng@quicinc.com>
 <87y1boy6ps.wl-tiwai@suse.de>
Content-Language: en-US
In-Reply-To: <87y1boy6ps.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iiFOt1LHNH-vK7dJGiW2u-pqhV-t6b_L
X-Proofpoint-ORIG-GUID: iiFOt1LHNH-vK7dJGiW2u-pqhV-t6b_L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_14,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402140174

Hi Takashi,

On 2/13/2024 2:54 AM, Takashi Iwai wrote:
> On Tue, 13 Feb 2024 01:54:11 +0100,
> Wesley Cheng wrote:
>>
>> +static int soc_usb_get_offload_dev(struct snd_kcontrol *kcontrol,
>> +				   struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
>> +	struct snd_soc_usb *ctx = snd_soc_usb_find_priv_data(component->dev);
>> +	int ret = 0;
>> +
>> +	mutex_lock(&ctx_mutex);
>> +	if (ctx && ctx->get_offload_dev)
>> +		ret = ctx->get_offload_dev(kcontrol, ucontrol);
>> +	mutex_unlock(&ctx_mutex);
> 
> It might be safer to initialize the values with -1 in case when the
> callback isn't available?
> 

Make sense, will do.

>>   /**
>>    * snd_soc_usb_get_components_tag() - Retrieve SOC USB component tag
>>    * @playback: direction of audio stream
>> @@ -157,6 +218,12 @@ EXPORT_SYMBOL_GPL(snd_soc_usb_free_port);
>>    */
>>   int snd_soc_usb_add_port(struct snd_soc_usb *usb)
>>   {
>> +	int ret;
>> +
>> +	ret = snd_soc_usb_control_init(usb->component);
>> +	if (ret < 0)
>> +		return ret;
>> +
>>   	mutex_lock(&ctx_mutex);
>>   	list_add_tail(&usb->list, &usb_ctx_list);
>>   	mutex_unlock(&ctx_mutex);
> 
> We may need to remove the control element upon the driver removal,
> too?  In theory, you can unload the offload stuff while snd-usb-audio
> is still active.
> 

This is managing the control for the ASoC platform card that supports 
offloading.  If we compile the different kernel entities as modules, we 
see that the soc_usb layer has the following users:

soc_usb 16384 3 q6usb,snd_usb_audio_qmi,snd_soc_qcom_offload_utils

So we'd need to remove all these modules before we can unload soc_usb. 
The entity which would be related to the kcontrols created for the ASoC 
sound card would be the q6usb module.  Since the q6usb module is tightly 
coupled with the platform soundcard itself in our design, for the q6usb 
module to be removed, we have to remove the entire ASoC sound card. (in 
which the kcontrols will also be removed)

However, that might not always be the case...so its a good idea to just 
manually remove the kcontrols in soc-usb as you guided.

Thanks
Wesley Cheng


