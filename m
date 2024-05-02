Return-Path: <linux-kernel+bounces-167075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BF28BA423
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6901C21C63
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AA9158A33;
	Thu,  2 May 2024 23:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O2/n/1nn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB98615358F;
	Thu,  2 May 2024 23:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714693065; cv=none; b=uhF/maXTh/bfPMXgY9etLh/poCzmCKeinXElNVaBjl0ayA+DEsBfmutHvN65bedRitP3IqLU5e+el/PMSN06qhaxs4DV5y6lO7/wVrmTwaiGwhtQgLJnXlIhRm5SMRQStrlkKK0KqjRsGlJk/JrfioQm6NiFxxQWyjkDpHHV33o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714693065; c=relaxed/simple;
	bh=ScmNimVD55HCJMpU1ZPTM6tr5t4G+wAg/gscjQhbxFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WSivMeyunEo7vEOE5+cCG4sLDze6/9zRMcT+UIymclU58t0PQNbZzez5atj9uleEdgu1NAtECYAJ+g1lJIcY67TUib+DQoamdOVtdQk5qS98pZO9DorFqlk1RlgJHybpZujtpZRI4GnbkJzGGDbS53pf1FJ4JXyNZNlNKG+coAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O2/n/1nn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 442NKMxO019950;
	Thu, 2 May 2024 23:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=yRahZediyJwd+8tFnCwYNOlw++FRljCtETICqi0KlLs=; b=O2
	/n/1nnkgzSroG5Sq+vOV2/J4HinUGZrLvxhaAONmKDPAQOgn9WUHzYJPDSt0QYpA
	EFUBbWzML+H3epFcUwj3FPH+XY3XjvGnlqYZZUdT05ll8lkzvQkzcQdbtVJvhIcQ
	YJqojw/vXeRHVRMBF4PLrTuWePYkHVoANXOTSTHaHMSJBazzvDgUYC6aRbwUI5kQ
	Wt1zKVXPuZct2q7KHJ2bBtEgVwdE5ymRVmlm+HadKZxLHG5/x+o+bsf7vNaLJzn8
	2aNjbYa+m2DaOOVxzlxaM+jxAL9qlvYSUmeePIy/D5uN5iKmvR3EcsIgRPeTWIyT
	qfyHgkPnafCjNKbG+rUw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xvawbhapu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 23:37:17 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 442NbGor013135
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 23:37:16 GMT
Received: from [10.71.112.114] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 2 May 2024
 16:37:15 -0700
Message-ID: <a88b41f4-7e53-e162-5a6a-2d470e29c0bb@quicinc.com>
Date: Thu, 2 May 2024 16:37:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v20 06/41] usb: host: xhci-sideband: Expose a sideband
 interrupter enable API
Content-Language: en-US
To: Mathias Nyman <mathias.nyman@linux.intel.com>,
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
 <20240425215125.29761-7-quic_wcheng@quicinc.com>
 <ddd682da-5cfd-db09-e316-3c54939caf90@linux.intel.com>
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <ddd682da-5cfd-db09-e316-3c54939caf90@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RmyOpgti89lDhFfWlfBLnFZdjZ9mBcru
X-Proofpoint-ORIG-GUID: RmyOpgti89lDhFfWlfBLnFZdjZ9mBcru
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_14,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405020159

Hi Mathias,

On 5/2/2024 4:07 AM, Mathias Nyman wrote:
> On 26.4.2024 0.50, Wesley Cheng wrote:
>> Some use cases maybe require that the secondary interrupter's events to
>> be handled by the OS.  In this case, configure the IMOD and the
>> skip_events property to enable the interrupter's events.  By default,
>> assume that the secondary interrupter doesn't want to enable OS event
>> handling.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   drivers/usb/host/xhci-sideband.c  | 28 ++++++++++++++++++++++++++++
>>   include/linux/usb/xhci-sideband.h |  2 ++
>>   2 files changed, 30 insertions(+)
>>
>> diff --git a/drivers/usb/host/xhci-sideband.c 
>> b/drivers/usb/host/xhci-sideband.c
>> index 255feae33c6e..6fdae9840c11 100644
>> --- a/drivers/usb/host/xhci-sideband.c
>> +++ b/drivers/usb/host/xhci-sideband.c
>> @@ -237,6 +237,30 @@ xhci_sideband_get_event_buffer(struct 
>> xhci_sideband *sb)
>>   }
>>   EXPORT_SYMBOL_GPL(xhci_sideband_get_event_buffer);
>> +/**
>> + * xhci_sideband_enable_interrupt - enable interrupt for secondary 
>> interrupter
>> + * @sb: sideband instance for this usb device
>> + * @imod_interval: number of event ring segments to allocate
>> + *
>> + * Enables OS owned event handling for a particular interrupter if 
>> client
>> + * requests for it.  In addition, set the IMOD interval for this 
>> particular
>> + * interrupter.
>> + *
>> + * Returns 0 on success, negative error otherwise
>> + */
>> +int xhci_sideband_enable_interrupt(struct xhci_sideband *sb, u32 
>> imod_interval)
>> +{
>> +    if (!sb || !sb->ir)
>> +        return -ENODEV;
>> +
>> +    xhci_set_interrupter_moderation(sb->ir, imod_interval);
> 
> Is there a need to adjust the moderation after initial setup?
> 
> If not then maybe we could pass the imod_interval as a parameter to
> xhci_create_secondary_interrupter(), and avoid exporting
> xhci_set_interrupter_moderation()
> 
> 

Let me preface my comments by saying that I was trying to include some 
aspects of enabling the secondary interrupter line within the main apps 
proc.  If this gets too confusing, I can remove these mechanisms for 
now.  For example, as you mentioned below 
xhci_sideband_enable_interrupt() isn't going to be used in the offload path.

However, I decided to add it so we can have some corresponding function 
that will utilize/set skip_events = false. (as it is "true" by default) 
Again, I can remove this part and revisit later when we actually have a 
use case to handle secondary interrupts on apps.

As for the IMOD setting, depending on what you think, I can add it as 
part of xhci_create_secondary_interrupter()

>> +    sb->ir->skip_events = false;
>> +    xhci_enable_interrupter(sb->ir);
>> +
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(xhci_sideband_enable_interrupt);
> 
> I can't find the place where xhci_sideband_enable_interrupt() is called in
> this series. How is it planned to be used?
> 
> Thanks
> Mathias

Thanks
Wesley Cheng

