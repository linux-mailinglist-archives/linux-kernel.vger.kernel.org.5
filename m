Return-Path: <linux-kernel+bounces-59944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D316384FDBD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740441F2A4A2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CBB1EB34;
	Fri,  9 Feb 2024 20:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MVTQxeHc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74461CF9C;
	Fri,  9 Feb 2024 20:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510920; cv=none; b=oY36ySTe+07+eGu4bdrlARzmKqvZAjv7zs0vmVFIgfhJmMwBOV9Ud+lD6eF/pN9aYMh1Ew/Sr2/rTg5wO2VU5veAbEUPD6ltVPw0YOFr7Aa9Gj5SsAZGOp4/SY2G7Tx+d4iQkMGvIznznU41XyBwafeKVxKtCBO1BanjpI+sz6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510920; c=relaxed/simple;
	bh=AcZcr3f09+rD5Y7GuUWLp4tl4KPCmu+ts7Zq4Po7zKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MyoDzxpRIHvOl0NQCq/hk3el6c3bFrm7U+rdkGGf1elUAUcrMPyZYAxwkeaUWlvoIVJIUACwpe9n2SjifhNPabnxR2I+E+2WHxtZ85IVKUPLq28Qzr7aT+1JGofkky7mggWs7UXoauX8884eL9WuY+Bk519s39hwtfjN0ehPSnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MVTQxeHc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419KVEgL025374;
	Fri, 9 Feb 2024 20:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=EcK6pRWGITTYQwRJIMt0XeWCySM/dPmPOKmlZyQFeLY=; b=MV
	TQxeHcKaUtkHSWaQIIKu4WTKh1B/4yD31xiBpsW+MLQSz2A8bG8zbdkSLGK3gJl3
	dH04youaGU1LSR5J0cPMJekgoGPdlM6xjnO3NMQxfDHshXyoszvcJvzMmZ/BDGuz
	+cYZR3hKhB6WF/sARfFcvddU6Q4enlUtNI12dkO/C/H8XQZoNXE2DKh8QKVpjNRW
	Y/lG6MuVt17x+pS/ZPD5qzKYdp//gmaNK8BXClHWhYfw9a1StmwlP50NkeBL2l36
	8IPXpPSEoEcJYyAL/fPVhbLudpovNQiPNCSog3ioquzLIMjYyb45Dvq0t1Fog1P3
	gMpRbi/HpO4CcG8lQoBA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w5u4br0c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 20:34:42 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 419KYfxF021392
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Feb 2024 20:34:41 GMT
Received: from [10.110.93.252] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 9 Feb
 2024 12:34:40 -0800
Message-ID: <b007a78c-b8fb-83bc-3be6-963708182cee@quicinc.com>
Date: Fri, 9 Feb 2024 12:34:39 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v14 20/53] ASoC: Add SOC USB APIs for adding an USB
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
References: <20240208231406.27397-1-quic_wcheng@quicinc.com>
 <20240208231406.27397-21-quic_wcheng@quicinc.com>
 <87r0hl29ha.wl-tiwai@suse.de>
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <87r0hl29ha.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PRnU2u4QXt78XkFphwTc7NkRjdlhcKXl
X-Proofpoint-GUID: PRnU2u4QXt78XkFphwTc7NkRjdlhcKXl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_18,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=884
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402090150

Hi Takashi,

On 2/9/2024 2:54 AM, Takashi Iwai wrote:
> On Fri, 09 Feb 2024 00:13:33 +0100,
> Wesley Cheng wrote:
>>
>> Some platforms may have support for offloading USB audio devices to a
>> dedicated audio DSP.  Introduce a set of APIs that allow for management of
>> USB sound card and PCM devices enumerated by the USB SND class driver.
>> This allows for the ASoC components to be aware of what USB devices are
>> available for offloading.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> (snip)
>> --- a/sound/soc/Makefile
>> +++ b/sound/soc/Makefile
>> @@ -1,5 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2.0
>> -snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-utils.o soc-dai.o soc-component.o
>> +snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-usb.o soc-utils.o soc-dai.o soc-component.o
>>   snd-soc-core-objs += soc-pcm.o soc-devres.o soc-ops.o soc-link.o soc-card.o
>>   snd-soc-core-$(CONFIG_SND_SOC_COMPRESS) += soc-compress.o
> 
> Do we really want to build this into ASoC core unconditionally?
> This is very specific to Qualcomm USB-offload stuff, so it's better to
> factor out.
> 

Ideally, the SOC USB part shouldn't be Qualcomm specific.  Since I don't 
have access or insight into how other vendors are achieving the same 
thing, I can only base the soc-usb layer to work with the information 
that is required to get the audio stream up and running on the QC 
platforms.  In its simplest form, its basically just a SW entity that 
notifies ASoC components about changes occurring from USB SND, and I 
think all vendors that have an ASoC based platform card handling the 
offload will need this notification.

Thanks
Wesley Cheng

