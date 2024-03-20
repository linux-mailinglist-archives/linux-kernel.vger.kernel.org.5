Return-Path: <linux-kernel+bounces-109262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FB18816F3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B034B20FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994196AF86;
	Wed, 20 Mar 2024 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KKZ51g+u"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2116A8C3;
	Wed, 20 Mar 2024 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957572; cv=none; b=KJP1D8TX9SICloIAVA2kIEwuOZ5XzeZx7F6BJFna3Voqz0kmSh24o8xsy+nu+ODBuf4+bT2R+u7GU1TmZSHtWbwHEDCy3tleT+x079PlKl7Mu5UcY3zDlkIWd5SSJO/UnxWucZlUgrApuLDeA4cTTJMh2vzfElD42JZv3lS59zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957572; c=relaxed/simple;
	bh=R+7tV7dktd45LPg/YF32aUCOYKAWmKksE4IzEk3YgCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ttqeOkrmHfgy/LyufmOGEfE+S7f1lva7E9jrUAm13H4TrjMuOckCP3e8PWxqbI8RpfL112OaozuI50dw4I6lGOYkL0n7BUnTQ/M2iEd8J1w3RodGrS6UXbc8t+fyNptV+GEBDbSoLbm14h4nryAiqpnY+lNqKhwXNXTMlSJehRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KKZ51g+u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KEjcni004879;
	Wed, 20 Mar 2024 17:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GwAPSGgZJycBh9DQwmyuX+kQ0nITXlVU3IEbYQiabf4=; b=KK
	Z51g+u+h+6i+qDtxYI2sIBxcpLnlpYZqesFiI8zFVNZ7Z+rr7YK//EPa8nVMkP4A
	Pp6gqhif1vP2yjoGAdO2Cuwo7NG2uGkdASVVdSLtPFIdwEtCsZXJP7LtxJ0ZcPLe
	PRIascamMfg6oRu08JRcGQZJEhXqrmxN9nS9IccqBuKVQL99QIjzuumGpI6rUf7k
	2EEGq5TmHqvbN4jKqf8jk5Fet2ikBtve4OGsB1GchegkYJpQm+4jnV1GxdFB9yq9
	JI/TmG+D/eGrriynZKnjeZfTBDl/4P/wKmFmgTIRZsBV0F9/JNU/wRuCDDbqbRMI
	YwCSBcX2+W5k1w8iC3Vw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wypxq1xdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:59:23 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KHxMnK015241
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:59:22 GMT
Received: from [10.50.49.240] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Mar
 2024 10:59:16 -0700
Message-ID: <f27bcfff-f710-4a76-b94e-8f1e5365802b@quicinc.com>
Date: Wed, 20 Mar 2024 23:29:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] interconnect: qcom: icc-rpmh: Add QoS
 configuration support
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Kees Cook <keescook@chromium.org>, <cros-qcom-dts-watchers@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <quic_rlaggysh@quicinc.com>,
        <quic_mdtipton@quicinc.com>
References: <20240306073016.2163-1-quic_okukatla@quicinc.com>
 <20240306073016.2163-2-quic_okukatla@quicinc.com>
 <b5ade82e-3a7e-427f-907f-bafe1d203d45@linaro.org>
From: Odelu Kukatla <quic_okukatla@quicinc.com>
In-Reply-To: <b5ade82e-3a7e-427f-907f-bafe1d203d45@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RGD2IVYRZINWp6Ixwexm0TjInTKnGKf3
X-Proofpoint-GUID: RGD2IVYRZINWp6Ixwexm0TjInTKnGKf3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403200143



On 3/6/2024 9:48 PM, Konrad Dybcio wrote:
> 
> 
> On 3/6/24 08:30, Odelu Kukatla wrote:
>> It adds QoS support for QNOC device and includes support for
>> configuring priority, priority forward disable, urgency forwarding.
>> This helps in priortizing the traffic originating from different
>> interconnect masters at NoC(Network On Chip).
>>
>> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
>> ---
>>   drivers/interconnect/qcom/icc-rpmh.c | 105 +++++++++++++++++++++++++++
>>   drivers/interconnect/qcom/icc-rpmh.h |  32 ++++++++
>>   2 files changed, 137 insertions(+)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
>> index c1aa265c1f4e..b4681849df80 100644
>> --- a/drivers/interconnect/qcom/icc-rpmh.c
>> +++ b/drivers/interconnect/qcom/icc-rpmh.c
>> @@ -1,19 +1,57 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /*
>>    * Copyright (c) 2020, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>>    */
>>   
>> +#include <linux/clk.h>
>>   #include <linux/interconnect.h>
>>   #include <linux/interconnect-provider.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>>   #include <linux/of_platform.h>
>>   #include <linux/slab.h>
>> +#include <linux/bitfield.h>
> 
> Please keep the alphabetical order
> 

I will address this in next version.

>>   
>>   #include "bcm-voter.h"
>>   #include "icc-common.h"
>>   #include "icc-rpmh.h"
>>   
>> +/* QNOC QoS */
>> +#define QOSGEN_MAINCTL_LO(p, qp)	(0x8 + (p->port_offsets[qp]))
>> +#define QOS_SLV_URG_MSG_EN_MASK		BIT_MASK(3)
> 
> Mixing BIT_MASK and GENMASK is very confusing..
> 

I will fix this in v4.

>> +#define QOS_DFLT_PRIO_MASK		GENMASK(6, 4)
>> +#define QOS_DISABLE_MASK		BIT_MASK(24)
>> +
>> +/**
>> + * qcom_icc_set_qos - initialize static QoS configurations
>> + * @qp: qcom icc provider to which @node belongs
>> + * @node: qcom icc node to operate on
>> + */
>> +static void qcom_icc_set_qos(struct qcom_icc_provider *qp,
>> +				struct qcom_icc_node *node)
>> +{
>> +	const struct qcom_icc_qosbox *qos = node->qosbox;
>> +	int port;
>> +
>> +	if (!qp->regmap || !qos)
>> +		return;
> 
> This is not possible if you follow the code flow, I think..
> 
> [...]
> 

Right, it is not needed.

>> + * @prio: priority value assigned to requests on the node
>> + * @urg_fwd: whether to forward the urgency promotion issued by master(endpoint), or discard
> 
> space before the opening brace, please also wrap to 80 lines
> 

I will fix this in v4.

>> + * @prio_fwd_disable: whether to forward the priority driven by mster, or override by @prio
> 
> typo: mster, please also wrap it
> 
> Konrad

Thanks,
Odelu

