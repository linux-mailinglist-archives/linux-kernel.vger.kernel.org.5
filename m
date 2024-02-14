Return-Path: <linux-kernel+bounces-66099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D93D78556DE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1756C1C24173
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1781E1419B1;
	Wed, 14 Feb 2024 23:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L4y8Ewfv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADAD65191;
	Wed, 14 Feb 2024 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951906; cv=none; b=UlZaG5sj/GWeYhWPeDHJdANAiSacKt4WsvHH8W/NN3FZbnzADbaDwzWdgZZkBso65IV81ljsDABTyg/QK5hKSKQkhNpBPNCzVGC9ImZ/W6SkiaNJtyIDtNuI9iBNz309R+oRvQl2Q3wTnXVzjvsKbPhTTIdEGfsP3SpnDHraUhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951906; c=relaxed/simple;
	bh=NF5NUr80OtbglWaZRPMW8XuNliEAQsYjfE/zJTAavQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jn6ML6+dL+wX6qny7cF8GnG0t09035jbx+F3wOAC6MJkzhEkjimjvpHoFsDV0shyGx2KhCvT2w6u3fvUfBTKYpk9H0ZI3EikfKlEm2dYJ2UOhgFovzVxfcktw8gFnXP6gWDw8C7RHwoxAS125QcwupCvLyumqSJjr1vL5+R6Io4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L4y8Ewfv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41EMWmtR004681;
	Wed, 14 Feb 2024 23:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=y0Uz8mXSkjvYpXhQtlSAFEFG7yr5QWKHlI01ir09dWQ=; b=L4
	y8EwfvWY/MSIRk9KRaT27rQwH0bU8zFAw2ylQSlnqaMws8FoKxCNU1E7FKG3PKQD
	U69vxyTl+s7Gq8sA72GkfOvu48EXZeBEjDZfdcq9ITlMY5N+cYcYDwLzy3YUqVtH
	IZdPC5Rbm9S11S8pq0AQDtbieP1lGuH/EQbtqL6WjI9LDIlylGTs7USbsqfp0qBK
	ezREmJDaAP92qaGK2mxaocOpjqtToMsu6A9mmbCPFznTtDowSpYyKLNSaH0B+1XY
	JjzCDd5o6fmx2R453ESMwOpRRySCPeTkBeUB77dcz+ZXbR+nXvmTFjwcNaL46JW+
	rLbeB4Bi7TF8ZlhRfojg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9435raed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 23:04:47 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41EN4kmI001141
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 23:04:46 GMT
Received: from [10.71.114.103] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 14 Feb
 2024 15:04:45 -0800
Message-ID: <ecec5590-1a96-9363-1209-342b4735096c@quicinc.com>
Date: Wed, 14 Feb 2024 15:04:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v15 18/50] ASoC: Add SOC USB APIs for adding an USB
 backend
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
References: <20240213005422.3121-1-quic_wcheng@quicinc.com>
 <20240213005422.3121-19-quic_wcheng@quicinc.com>
 <87zfw4y717.wl-tiwai@suse.de>
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <87zfw4y717.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JuSmwtbiiWjb1-tzjemz6pa5NF-cujTB
X-Proofpoint-ORIG-GUID: JuSmwtbiiWjb1-tzjemz6pa5NF-cujTB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_14,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402140174

Hi Takashi,

On 2/13/2024 2:48 AM, Takashi Iwai wrote:
> On Tue, 13 Feb 2024 01:53:50 +0100,
> Wesley Cheng wrote:
>>
>> --- a/sound/soc/Kconfig
>> +++ b/sound/soc/Kconfig
>> @@ -76,6 +76,15 @@ config SND_SOC_UTILS_KUNIT_TEST
>>   config SND_SOC_ACPI
>>   	tristate
>>   
>> +config SND_SOC_USB
>> +	bool "SoC based USB audio offloading"
>> +	help
>> +	  Enable this option if an ASoC platform card has support to handle
>> +	  USB audio offloading.  This enables the SoC USB layer, which will
>> +	  notifies the ASoC USB DPCM backend DAI link about available USB audio
>> +	  devices.  Based on the notifications, sequences to enable the audio
>> +	  stream can be taken based on the design.
> 
> This should be tristate, and...
> 
>> --- a/sound/soc/Makefile
>> +++ b/sound/soc/Makefile
>> @@ -31,6 +31,10 @@ endif
>>   
>>   obj-$(CONFIG_SND_SOC_ACPI) += snd-soc-acpi.o
>>   
>> +ifneq ($(CONFIG_SND_SOC_USB),)
>> +snd-soc-core-objs += soc-usb.o
>> +endif
> 
> ... split it to an individual module, i.e.:
> 
> snd-soc-usb-objs := soc-usb.o
> obj-$(CONFIG_SND_SOC_USB) += snd-soc-usb.o
> 
> Otherwise it'll lead to a hard-dependency to snd-soc-core on
> snd-usb-audio, which is utterly unnecessary for most of other
> devices.
> 

Got it...getting this to compile as its own separate module also 
required some changes to the other layers I had.  Anyway, I've reworked 
some of the dependencies with other drivers and is working fine now.

Thanks
Wesley Cheng

