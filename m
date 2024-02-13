Return-Path: <linux-kernel+bounces-64492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093DB853F23
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CCDA1C2824E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309336313A;
	Tue, 13 Feb 2024 22:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IYveZ237"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8636310E;
	Tue, 13 Feb 2024 22:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864559; cv=none; b=lLDL71mF/gGaJ+uYT/tWcDORvxMTZetx4JfZfOgrb9NM4171ETajiO3FWriEqvFFhC92GTjup8dOPBkm2FUNaUpgqvlem0V4RAE1CnGa7hHC5sVuN4G16hzQx2uhpijERlHDC9bPoaA5eOSe6Fz6TPYU95lEP1WBwBdi8eAJlyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864559; c=relaxed/simple;
	bh=jHvv+4ryYbSvF7PPwhAN75HK+TodxoZw2ak0Ibxc0XA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f9nfOLhtiNRbhKXwnZwDJXRUuoPMzzRHnC+aRa4RW7pqeHkzkoqlKzkbxOnGRmQEKPcg7fylDE82vWfsO87IoZX+Yyi2xn4oZw9rpqDIC7XNqfDeJtLiLI6/ol68ITlVrjVShNOKqKCymwNToEtGigEQXW42DnbRqvbj6FE0Msw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IYveZ237; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41DMNqvB013597;
	Tue, 13 Feb 2024 22:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=kS0BuS/dFc0Sb2CDmjSXKeRKMVaweomB8kr69lr3DUI=; b=IY
	veZ237BYo3/8kkpCqtX8a0sQz3ISSeSw1tccp3RkOlE6Y43Axf71iYjuE2NSieSv
	09W7xZATnKZfM+C7VArnuqvb/mqOn8+hfN6Irq8zT7seH9rqT6SAMcGkUu2FCZlF
	Iprk/CyP+3OLlBJ6gS+QTOsqPHtdI5JD74oarLbPAp8Rs8Wf4ChGdUWXXRJTMSf8
	aQWUiCHRcr+QQBQPOPQ9bXOB7u5GeOXd7AUq+/CrKHcVQsTRQyNlcat5kB8mndON
	n1cHkAmUFWFO5DqBIWsyb73MUimvr2IeLhKT/zWMxDS4aAH5cOsWZgwidmCYpwiR
	dderqNLjSn7fbZJk4sFw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7yh329ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 22:48:37 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41DMma8G004283
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 22:48:36 GMT
Received: from [10.110.76.255] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 13 Feb
 2024 14:48:36 -0800
Message-ID: <289ae266-c1a4-796a-1f87-387d8ec98646@quicinc.com>
Date: Tue, 13 Feb 2024 14:48:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v15 29/50] ALSA: usb-audio: qcom: Introduce QC USB SND
 offloading support
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
 <20240213005422.3121-30-quic_wcheng@quicinc.com>
 <87wmr8y6hi.wl-tiwai@suse.de>
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <87wmr8y6hi.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CPkrbzsESQIWkFFv2CJithY9DWfBhg74
X-Proofpoint-GUID: CPkrbzsESQIWkFFv2CJithY9DWfBhg74
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_14,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=666 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130179

Hi Takashi,

On 2/13/2024 2:59 AM, Takashi Iwai wrote:
> On Tue, 13 Feb 2024 01:54:01 +0100,
> Wesley Cheng wrote:
>> +static int __init qc_usb_audio_offload_init(void)
>> +{
>> +	struct uaudio_qmi_svc *svc;
>> +	int ret;
>> +
>> +	svc = kzalloc(sizeof(struct uaudio_qmi_svc), GFP_KERNEL);
>> +	if (!svc)
>> +		return -ENOMEM;
>> +
>> +	svc->uaudio_wq = create_singlethread_workqueue("uaudio_svc");
>> +	if (!svc->uaudio_wq) {
>> +		ret = -ENOMEM;
>> +		goto free_svc;
>> +	}
> 
> Do we need a dedicated workqueue?  I don't mind much, but an own
> workqueue isn't usually needed unless specifically required such as
> the request quantity control or isolation.
> 

I think we can remove this.  I checked the QMI interface implementation 
and looks like they are running all the notifications on its own WQ, so 
doing duplicate work with queuing to our own WQ here in qc_audio_offload.

Thanks
Wesley Cheng

