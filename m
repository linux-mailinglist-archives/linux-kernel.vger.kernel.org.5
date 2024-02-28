Return-Path: <linux-kernel+bounces-85442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C84E686B605
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7CD28345A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA2D15A483;
	Wed, 28 Feb 2024 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lh7ajcip"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2505E3FBA2;
	Wed, 28 Feb 2024 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141527; cv=none; b=vGMdtu3oZ2+KofT2JeT7GEJi/nEawidYwLoHPF5MsqqpUiNZGi3HbjfMgtrrq7LypnxeTwDyvhhAO5UJku/7XKanuNfePachyCa3DIdKRQg4rm9soRlMKk8oRAUJ/siL2BFP4nfd+BPrLN1WIs80svgVZMJY708/mYU05H5MBe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141527; c=relaxed/simple;
	bh=q/m65mSFAQWv1ZKGkfQ/GUczJr0fLasn2tZbosS0Ib4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YTtM1NrhxLrtdXr66uhN1BwTBEP3C/sLBLhkPviE7neZYJH/MtLZ3mxP3TdY55mY1F2DWwP7yXnQz4ZCS2Y4sbFp3NNR0MCarhoPFpXD0EeUg+z8nqC7I47XhZFXM7PEhaLt8wRl0UT4PYKQ8DD/eWRdRAYGTYrGZC5DdoGrK9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lh7ajcip; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41SEGsXC004941;
	Wed, 28 Feb 2024 17:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Espt4lxlW/6peI/8r/CerAqW/cjoVDWGJeVhPYWvqBc=; b=lh
	7ajcipQnqD7v/vfmZUL7xzmYWvcwjkKIuoOrb8Jfcqk0IY6T/lYLBJATVzNvEuMJ
	WoHaJVdJ96iAn8SzLSd3Udlu2nDPAEDc4HZQmfRQZjDz+GHhlPOaicVErrq7Sb3H
	uhYDg/Nw3dRxNsuKYrYPQ3tixVdTUMHthGwAu+ESKUYgr6EVL+uybgRjDg0Yqojt
	S1tA6dU+kDa5BinqWz2f3N6giDDNBNV86392/BfIyGWYh6Ayoi1K4rdsKN3zCP+Z
	0jwCwCnDp6VBkY4VEmAteAZ4jRMoYr5A44zZDK9gGGCtX0LmONfoSXCbrJsshwej
	8jRrhOyXhVTr8tiOODmA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wj6en8k8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 17:31:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SHVvC9031001
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 17:31:57 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 09:31:53 -0800
Message-ID: <f1ce339e-0d80-743c-b1cf-4ffafd919850@quicinc.com>
Date: Wed, 28 Feb 2024 23:01:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC 4/7] soc: qcom: Utilize qcom scmi vendor protocol for bus
 dvfs
Content-Language: en-US
To: Cristian Marussi <cristian.marussi@arm.com>
CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, <sudeep.holla@arm.com>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <conor+dt@kernel.org>, Amir Vajid <avajid@quicinc.com>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
 <20240117173458.2312669-5-quic_sibis@quicinc.com>
 <CAA8EJpr8qLZ8Y7PjU05ZoxSHWOf=q-KtM+s-tnR5X2t96rFWhw@mail.gmail.com>
 <0adaa065-3883-ebfe-8259-05ebdbd821eb@quicinc.com> <ZdTANrUZuN_UZW9j@pluto>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <ZdTANrUZuN_UZW9j@pluto>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DYx7YJWDoNEaWrcXe0zfITGINFvGxzqx
X-Proofpoint-ORIG-GUID: DYx7YJWDoNEaWrcXe0zfITGINFvGxzqx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280138



On 2/20/24 20:37, Cristian Marussi wrote:
> On Mon, Feb 12, 2024 at 03:54:27PM +0530, Sibi Sankar wrote:
>>
>>
>> On 1/18/24 02:11, Dmitry Baryshkov wrote:
>>> On Wed, 17 Jan 2024 at 19:36, Sibi Sankar <quic_sibis@quicinc.com> wrote:
> 
> Hi,
> 
> I'll comment this patch fully, just a remark down below about this
> mail-thread.
> 
>>>>
>>>> From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>>>>
>>>> This patch introduces a client driver that interacts with the SCMI QCOM
>>>
>>> git grep This.patch Documentation/process/
>>>
>>>> vendor protocol and passes on the required tuneables to start various
>>>> features running on the SCMI controller.
>>>
>>> Is there any word about the 'memlat'? No. Unless one  reads into the
>>> patch, one can not come up with the idea of what is being introduced.
>>
>> ack, will fix it in the re-spin.
>>
>>>
>>>>
>>>> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>>>> Co-developed-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
>>>> Signed-off-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
>>>> Co-developed-by: Amir Vajid <avajid@quicinc.com>
>>>> Signed-off-by: Amir Vajid <avajid@quicinc.com>
>>>> Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
>>>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>>>> ---
>>>>    drivers/soc/qcom/Kconfig            |  10 +
>>>>    drivers/soc/qcom/Makefile           |   1 +
>>>>    drivers/soc/qcom/qcom_scmi_client.c | 486 ++++++++++++++++++++++++++++
>>>
>>> Should it go to drivers/firmware/arm_scmi instead? Or maybe to drivers/devfreq?
>>
>> I don't think it should go into arm_scmi unless Sudeep wants it there.
>> As for drivers/devfreq, I would have moved it there if this driver
>> benfitted being classified as a devfreq device. We can't use any of
>> the available governors on it and the tuneables appear way too custom.
>> These are the reasons why I placed it in drivers/soc/qcom instead.
>>
> 
> I think we used to host a couple of generic SCMI driver related to
> standard protocols but they have been moved out of driver/firmware/arm_scmi
> into the related subsystem...not sure if Sudeep thinks otherwise but I
> suppose we want to host only SCMI drivers that are clearly lacking a
> place where to stay...

I see and it makes sense, since it would go through an additional layer
of review from the corresponding sub-system maintainers and only after
sufficient push back it gets to land in driver/firmware/arm_scmi.

> 
>>>
>>>>    3 files changed, 497 insertions(+)
>>>>    create mode 100644 drivers/soc/qcom/qcom_scmi_client.c
>   
>   [snip]
> 
>>>> +static int configure_cpucp_mon(struct scmi_memlat_info *info, int memory_index, int monitor_index)
>>>> +{
>>>> +       const struct qcom_scmi_vendor_ops *ops = info->ops;
>>>> +       struct scmi_memory_info *memory = info->memory[memory_index];
>>>> +       struct scmi_monitor_info *monitor = memory->monitor[monitor_index];
>>>> +       struct scalar_param_msg scalar_msg;
>>>> +       struct map_param_msg map_msg;
>>>> +       struct node_msg msg;
>>>> +       int ret;
>>>> +       int i;
>>>> +
>>>> +       msg.cpumask = monitor->mask;
>>>> +       msg.hw_type = memory->hw_type;
>>>> +       msg.mon_type = monitor->mon_type;
>>>> +       msg.mon_idx = monitor->mon_idx;
>>>> +       strscpy(msg.mon_name, monitor->mon_name, sizeof(msg.mon_name));
>>>> +       ret = ops->set_param(info->ph, &msg, MEMLAT_ALGO_STR, MEMLAT_SET_MONITOR, sizeof(msg));
>>>> +       if (ret < 0) {
>>>> +               pr_err("Failed to configure monitor %s\n", monitor->mon_name);
>>>> +               return ret;
>>>> +       }
>>>> +
>>>> +       scalar_msg.hw_type = memory->hw_type;
>>>> +       scalar_msg.mon_idx = monitor->mon_idx;
>>>> +       scalar_msg.val = monitor->ipm_ceil;
>>>> +       ret = ops->set_param(info->ph, &scalar_msg, MEMLAT_ALGO_STR, MEMLAT_IPM_CEIL,
>>>> +                            sizeof(scalar_msg));
>>>> +       if (ret < 0) {
>>>> +               pr_err("Failed to set ipm ceil for %s\n", monitor->mon_name);
>>>> +               return ret;
>>>> +       }
>>>> +
>>>> +       map_msg.hw_type = memory->hw_type;
>>>> +       map_msg.mon_idx = monitor->mon_idx;
>>>> +       map_msg.nr_rows = monitor->freq_map_len;
>>>> +       for (i = 0; i < monitor->freq_map_len; i++) {
>>>> +               map_msg.tbl[i].v1 = monitor->freq_map[i].cpufreq_mhz;
>>>> +               map_msg.tbl[i].v2 = monitor->freq_map[i].memfreq_khz / 1000;
>>>> +       }
>>>
>>> So this table goes 1:1 to the firmware? Is it going to be the same for
>>> all versions of the SoC? If so, it might be better to turn it into the
>>> static data inside the driver. If it doesn't change, there is no need
>>> to put it to DT.
>>
>> The table does go directly to the firmware but obviously varies across
>> SoCs. Also since it's a SCMI client driver we don't have a way to
>> distinguish between SoCs based on compatibles. So it made more sense to
>> move it to the device tree instead.
>>
> 
> Well, the SCMI fw running the server DOES know where it is running right ?
> 
> So, if you have multiple fixed config tables to feed into the firmware
> that vary based on the SoC you are running on, you could add an SCMI command
> to your QCOM SCMI vendor protocol and expose a related operation in ops to get
> the actual SoC model, so that you can embed the tableS in the driver here (as
> suggested) and then choose at runtime which one to use based on the reported
> platform...this is clearly config stuff (sa said by others) so it just
> does not belong to DT descriptions.

I still think changing it to opp-tables from qcom,cpufreq-memfreq-tbl
like Konrad/Dmitry suggested is the the right way to go for the
following reason. I would expect the SCP FW running on the SoC to be
board invariant i.e. a SoC can support multiple variants of a memory
that we are trying to scale like ram (lpddr4/lpddr5) so the having them
in the device tree actually allows us to configure the supported ddr
frequencies by overriding those in the board files. Thus closer to the
actual representation. Also like I explained just getting the SoC info
won't be sufficient since the tables are expected to change across
boards when there is a change in type or supported frequencies.

-Sibi

> 
> Thanks,
> Cristian

