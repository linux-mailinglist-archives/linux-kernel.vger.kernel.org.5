Return-Path: <linux-kernel+bounces-51968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3684384921B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618141F21FAD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 01:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB883A953;
	Mon,  5 Feb 2024 01:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lphxLzhg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F699455;
	Mon,  5 Feb 2024 01:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707094888; cv=none; b=GUF6yCWoODmOJ8jhUNdK2/QjFXD7AX6DygJmSPtpI+BCNotp6Lmv9SPe+W20+IEWAK79p9JcarkLCa/j/XUooOOn1VjGtVXEuOY3ByK4pqNU3zDFmyV+zYzd/lhz4JLLUEWj4LB5b4Kt+L57jCqiILIn8du0ODbHnCNIpgEgLUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707094888; c=relaxed/simple;
	bh=hgBGtjwY1Bs21q9PH8D5y7GXBrkCB8rw9wP8pIRJ5Dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h3qUHjD6HBjkvBJ45RaCvcTuJD3ne9Q/8xNU//tvSk0WVEVTAdCn4cf1VkoOa638DOWmPLil+cM8csYQBtSUuUhF19Yb/PwtCradjumSZtRCCX9zNFIquk3QqOmLFxJp6QcboWXIiqk1kp5jrd/P+C2/nbNF9I2QqvbZdMninCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lphxLzhg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4150tvpJ031582;
	Mon, 5 Feb 2024 01:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=78cIa99MEoyogJ8djgg9C7dZxI+eg7u0VNRcSPZ3UBU=; b=lp
	hxLzhgEXvgRpOznz2kP+7awx9YNfHCtR+R5S35oo21aYlzZc1w/VzkitojEseHzW
	Sml4uqJdKvZxU55/0qHGMpgI5agbKoYDuyPxDT5qVSeEANiIVQoR6w/MSeJ3BaCK
	My4ocZ91lfqIE7W6CAW62AHuvZ7sCL4a2AcoQ3tPnLcsood3K3Tj3shrW1S44EBS
	QtpWWbh0NhXwCiQhXIflZpGF5PjIsn5ine7hNGNpf9AdnPNRr7m/krK7ibWNpqaw
	iMJ/OaH+onWf1Wx51Wx7HHnCCeBvOC3erwgdEDaHRWXBUAxr8w4S5z/p7aaH4fz2
	v4no8BrTdfVkfcWIDjag==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w1ey52bm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 01:01:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41511KAW007485
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 01:01:20 GMT
Received: from [10.110.18.73] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 4 Feb
 2024 17:01:17 -0800
Message-ID: <b01116fe-6c38-329e-70b6-62fb0c585584@quicinc.com>
Date: Sun, 4 Feb 2024 17:01:16 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] soc: qcom: llcc: Add regmap for Broadcast_AND region
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Unnathi Chalicheemala
	<quic_uchalich@quicinc.com>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
References: <cover.1706296015.git.quic_uchalich@quicinc.com>
 <12bfdd23772c49530b8b0993cc82bc89b3eb4ada.1706296015.git.quic_uchalich@quicinc.com>
 <CAA8EJppapW5nOFphBWove1ni8nbkA=xHON9D13NYeYHhyqL1Fg@mail.gmail.com>
 <94b097d4-dcfa-4136-ba75-f665f5bc747d@quicinc.com>
 <CAA8EJpqa5YArFk893nDz_oibbV=oqGEeYq6_jw582rQs=O_WpA@mail.gmail.com>
 <30d972b1-9685-408b-a87c-98352c4a2449@quicinc.com>
 <CAA8EJprPZThviO0vZfyYz+YShPKxg9YcuOUUCv4B_ePghuB8XA@mail.gmail.com>
From: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
In-Reply-To: <CAA8EJprPZThviO0vZfyYz+YShPKxg9YcuOUUCv4B_ePghuB8XA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6r04AXQBLGREbbXYrJWM5SfhiKPSWsxn
X-Proofpoint-ORIG-GUID: 6r04AXQBLGREbbXYrJWM5SfhiKPSWsxn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-04_14,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050006


On 1/30/2024 10:57 AM, Dmitry Baryshkov wrote:
> On Tue, 30 Jan 2024 at 19:52, Unnathi Chalicheemala
> <quic_uchalich@quicinc.com> wrote:
>> On 1/29/2024 2:03 PM, Dmitry Baryshkov wrote:
>>> On Mon, 29 Jan 2024 at 20:17, Unnathi Chalicheemala
>>> <quic_uchalich@quicinc.com> wrote:
>>>>
>>>>
>>>> On 1/26/2024 12:29 PM, Dmitry Baryshkov wrote:
>>>>> On Fri, 26 Jan 2024 at 21:48, Unnathi Chalicheemala
>>>>> <quic_uchalich@quicinc.com> wrote:
>>>>>> To support CSR programming, a broadcast interface is used to program
>>>>>> all channels in a single command. Until SM8450 there was only one
>>>>>> broadcast region (Broadcast_OR) used to broadcast write and check
>>>>>> for status bit 0. From SM8450 onwards another broadcast region
>>>>>> (Broadcast_AND) has been added which checks for status bit 1.
>>>>>>
>>>>>> Update llcc_drv_data structure with new regmap for Broadcast_AND
>>>>>> region and initialize regmap for Broadcast_AND region when HW block
>>>>>> version is greater than 4.1 for backwards compatibility.
>>>>>>
>>>>>> Switch from broadcast_OR to broadcast_AND region for checking
>>>>>> status bit 1 as Broadcast_OR region checks only for bit 0.
>>>>> This breaks backwards compatibility with the existing DT files,
>>>>> doesn't it?
>>>>>
>>>> It shouldn't as checking for status bit 1 is happening only when the
>>>> block
>>>> version is greater than 4.1, which is when Broadcast_AND region support
>>>> is added.
>>> Let me reiterate, please: with the existing DT files. You are patching
>>> DT files in patches 2-4, but this is not enough. DT files are
>>> considered to be ABI. As such old DT files must continue to work with
>>> newer kernels.
>>>
>> I'm sorry, I think I'm not understanding this right.
>>
>>>>>> While at it, also check return value after reading Broadcast_OR
>>>>>> region in llcc_update_act_ctrl().
>>>>> Separate patch, Fixes tag.
>>>>>
>>>> Ack. Will remove this from existing patch.
>>>> Thanks for the review Dmitry!
>>>>
>>>>>> Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
>>>>>> ---
>>>>>>   drivers/soc/qcom/llcc-qcom.c       | 12 +++++++++++-
>>>>>>   include/linux/soc/qcom/llcc-qcom.h |  4 +++-
>>>>>>   2 files changed, 14 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/soc/qcom/llcc-qcom.c
>>>>>> b/drivers/soc/qcom/llcc-qcom.c
>>>>>> index 4ca88eaebf06..5a2dac2d4772 100644
>>>>>> --- a/drivers/soc/qcom/llcc-qcom.c
>>>>>> +++ b/drivers/soc/qcom/llcc-qcom.c
>>>>>> @@ -849,7 +849,7 @@ static int llcc_update_act_ctrl(u32 sid,
>>>>>>                  return ret;
>>>>>>
>>>>>>          if (drv_data->version >= LLCC_VERSION_4_1_0_0) {
>>>>>> -               ret =
>>>>>> regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
>>>>>> +               ret =
>>>>>> regmap_read_poll_timeout(drv_data->bcast_and_regmap, status_reg,
>>>>>>                                        slice_status, (slice_status &
>>>>>> ACT_COMPLETE),
>>>>>>                                        0, LLCC_STATUS_READ_DELAY);
>> Above if condition will be true only for SM8450, 8550 and 8650 - whose DT
>> files have been changed.
>> It would never check for other existing DT files - I guess I'm failing to
>> understand why the code
>> would break with other DeviceTree files.
> I'm saying that the driver must continue to work (well, at least not
> to crash) even if somebody runs the kernel with older DT.
Thanks Dmitry. While I get the ask, wondering why someone would use old 
DT while DT
is also being updated in this series along with the driver change?

Unnathi, you add check and make sure to update only when bcast_and 
region is specified in DT,
otherwise, stick to what is being done today, that way backwards 
compatibility is maintained.
>>>>>>                  if (ret)
>>>>>> @@ -859,6 +859,8 @@ static int llcc_update_act_ctrl(u32 sid,
>>>>>>          ret = regmap_read_poll_timeout(drv_data->bcast_regmap,
>>>>>> status_reg,
>>>>>>                                        slice_status, !(slice_status &
>>>>>> status),
>>>>>>                                        0, LLCC_STATUS_READ_DELAY);
>>>>>> +       if (ret)
>>>>>> +               return ret;
>>>>>>
>>>>>>          if (drv_data->version >= LLCC_VERSION_4_1_0_0)
>>>>>>                  ret = regmap_write(drv_data->bcast_regmap,
>>>>>> act_clear_reg,
>>>>>> @@ -1282,6 +1284,14 @@ static int qcom_llcc_probe(struct
>>>>>> platform_device *pdev)
>>>>>>
>>>>>>          drv_data->version = version;
>>>>>>
>>>>>> +       if (drv_data->version >= LLCC_VERSION_4_1_0_0) {
>>>>>> +               drv_data->bcast_and_regmap =
>>>>>> qcom_llcc_init_mmio(pdev, i + 1, "llcc_broadcast_and_base");
>>>>>> +               if (IS_ERR(drv_data->bcast_and_regmap)) {
>>>>>> +                       ret = PTR_ERR(drv_data->bcast_and_regmap);
>>>>>> +                       goto err;
>>>>>> +               }
>>>>>> +       }
>> I have added a similar check in the probe function above; are you saying
>> this too will break with
>> existing DT files?
>>
>>>>>> +
>>>>>>          llcc_cfg = cfg->sct_data;
>>>>>>          sz = cfg->size;
>>>>>>
>>>>>> diff --git a/include/linux/soc/qcom/llcc-qcom.h
>>>>>> b/include/linux/soc/qcom/llcc-qcom.h
>>>>>> index 1a886666bbb6..9e9f528b1370 100644
>>>>>> --- a/include/linux/soc/qcom/llcc-qcom.h
>>>>>> +++ b/include/linux/soc/qcom/llcc-qcom.h
>>>>>> @@ -115,7 +115,8 @@ struct llcc_edac_reg_offset {
>>>>>>   /**
>>>>>>    * struct llcc_drv_data - Data associated with the llcc driver
>>>>>>    * @regmaps: regmaps associated with the llcc device
>>>>>> - * @bcast_regmap: regmap associated with llcc broadcast offset
>>>>>> + * @bcast_regmap: regmap associated with llcc broadcast OR offset
>>>>>> + * @bcast_and_regmap: regmap associated with llcc broadcast AND
>>>>>> offset
>>>>>>    * @cfg: pointer to the data structure for slice configuration
>>>>>>    * @edac_reg_offset: Offset of the LLCC EDAC registers
>>>>>>    * @lock: mutex associated with each slice
>>>>>> @@ -129,6 +130,7 @@ struct llcc_edac_reg_offset {
>>>>>>   struct llcc_drv_data {
>>>>>>          struct regmap **regmaps;
>>>>>>          struct regmap *bcast_regmap;
>>>>>> +       struct regmap *bcast_and_regmap;
>>>>>>          const struct llcc_slice_config *cfg;
>>>>>>          const struct llcc_edac_reg_offset *edac_reg_offset;
>>>>>>          struct mutex lock;
>>>>>> --
>>>>>> 2.25.1
>>>>>>
>>>>>>
>>>>>
>>>
>>>
>> --
>> Thanks & Warm Regards,
>> Unnathi
>
>

