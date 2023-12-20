Return-Path: <linux-kernel+bounces-6532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA66819A0A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434071F2549F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC78118E3C;
	Wed, 20 Dec 2023 08:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iGiP0KiM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE3F1D6BC;
	Wed, 20 Dec 2023 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK4ptbr004310;
	Wed, 20 Dec 2023 08:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Ez++3c7OvnlF0XKnnJ7dsexqkbW60IzMoHj0YX7aypA=; b=iG
	iP0KiMJ6X0rvqnE7E/fsAjbep6nqH4pRojrfBNMnvakAQGawmfsa6OOzAK95khbJ
	Vnmmr3knvA5PLOL3uHc3ClROWuBK1Wdq6XNanFzYpi5gPo+Dz8IH+k8eUuXjX/G5
	PRbm/QxU4GKeS8yLgyf1MbT0HPDHM46zCkr1ixEhPQJNPNNKsrfwbfiuJrQGd0He
	LBY+ObqgnrT2WpZkMdvSnludrh50KyMNcaHfOBWkITgKnPzLbUm9Z07AdSK33jvq
	tlfcUa+pSzMCvszXqdvdVS/Zi9UC37x/WnbCaD7STtaqxUcBVwcgT2zkTBGqYvH3
	dfXJQGj/0quaz7s/r2gw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3rppggdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:05:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BK85NUa015972
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:05:23 GMT
Received: from [10.216.36.155] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 00:05:18 -0800
Message-ID: <5f106c73-409f-8122-e882-3061b1b34f2e@quicinc.com>
Date: Wed, 20 Dec 2023 13:35:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 08/34] media: iris: introduce state machine for iris
 core
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stanimir.k.varbanov@gmail.com>, <quic_vgarodia@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mchehab@kernel.org>,
        <bryan.odonoghue@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <quic_abhinavk@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <1702899149-21321-9-git-send-email-quic_dikshita@quicinc.com>
 <62de5467-a979-4739-aee3-e00472ab192a@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <62de5467-a979-4739-aee3-e00472ab192a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3SDRcELXFPjIfpPeW0DhxhEGnZ5lKQDR
X-Proofpoint-GUID: 3SDRcELXFPjIfpPeW0DhxhEGnZ5lKQDR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200055



On 12/19/2023 12:16 AM, Dmitry Baryshkov wrote:
> On 18/12/2023 13:32, Dikshita Agarwal wrote:
>> Introduces different states for core. State transitions
>> are defined, based on which they would be allowed/rejected/ignored.
>>
>> IRIS_CORE_DEINIT - default state.
>> IRIS_CORE_INIT_WAIT -  wait state for video core to complete
>> initialization.
>> IRIS_CORE_INIT - core state with core initialized. FW loaded and
>> HW brought out of reset, shared queues established between host
>> driver and firmware.
>> IRIS_CORE_ERROR - error state.
>>
>>              |
>>              v
>>         -----------
>>    +--->| DEINIT  |<---+
>>    |    -----------    |
>>    |         |         |
>>    |         v         |
>>    |    -----------    |
>>    |    |INIT_WAIT|    |
>>    |    -----------    |
>>    |      /     \      |
>>    |     /       \     |
>>    |    /         \    |
>>    |   v           v   v
>>   -----------   ----------.
>>   |  INIT   |-->|  ERROR |
>>   -----------   ----------.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> 
> Can we see users for this API please? Otherwise it's just a dead code.
> 
This is like a preparation patch to add the core state.
These APIs are used in patch-10[1] onward.

[1]:
https://patchwork.kernel.org/project/linux-media/patch/1702899149-21321-11-git-send-email-quic_dikshita@quicinc.com/
>> ---
>>   drivers/media/platform/qcom/vcodec/iris/Makefile   |  3 +-
>>   .../media/platform/qcom/vcodec/iris/iris_core.h    |  4 ++
>>   .../media/platform/qcom/vcodec/iris/iris_state.c   | 64
>> ++++++++++++++++++++++
>>   .../media/platform/qcom/vcodec/iris/iris_state.h   | 22 ++++++++
>>   4 files changed, 92 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_state.c
>>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_state.h
>>
>> diff --git a/drivers/media/platform/qcom/vcodec/iris/Makefile
>> b/drivers/media/platform/qcom/vcodec/iris/Makefile
>> index 0748819..12a74de 100644
>> --- a/drivers/media/platform/qcom/vcodec/iris/Makefile
>> +++ b/drivers/media/platform/qcom/vcodec/iris/Makefile
>> @@ -1,4 +1,5 @@
>>   iris-objs += iris_probe.o \
>> -             resources.o
>> +             resources.o \
>> +             iris_state.o
>>     obj-$(CONFIG_VIDEO_QCOM_IRIS) += iris.o
>> diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_core.h
>> b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
>> index c2bc95d..56a5b7d 100644
>> --- a/drivers/media/platform/qcom/vcodec/iris/iris_core.h
>> +++ b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
>> @@ -9,6 +9,8 @@
>>   #include <linux/types.h>
>>   #include <media/v4l2-device.h>
>>   +#include "iris_state.h"
>> +
>>   /**
>>    * struct iris_core - holds core parameters valid for all instances
>>    *
>> @@ -27,6 +29,7 @@
>>    * @clk_count: count of iris clocks
>>    * @reset_tbl: table of iris reset clocks
>>    * @reset_count: count of iris reset clocks
>> + * @state: current state of core
>>    */
>>     struct iris_core {
>> @@ -45,6 +48,7 @@ struct iris_core {
>>       u32                    clk_count;
>>       struct reset_info            *reset_tbl;
>>       u32                    reset_count;
>> +    enum iris_core_state            state;
>>   };
>>     #endif
>> diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_state.c
>> b/drivers/media/platform/qcom/vcodec/iris/iris_state.c
>> new file mode 100644
>> index 0000000..22557af
>> --- /dev/null
>> +++ b/drivers/media/platform/qcom/vcodec/iris/iris_state.c
>> @@ -0,0 +1,64 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights
>> reserved.
>> + */
>> +
>> +#include "iris_core.h"
>> +#include "iris_state.h"
>> +
>> +#define IRIS_STATE(name)[IRIS_CORE_##name] = "CORE_"#name
> 
> Inline this please.
> 
>> +
>> +static const char * const core_state_names[] = {
>> +    IRIS_STATE(DEINIT),
>> +    IRIS_STATE(INIT_WAIT),
>> +    IRIS_STATE(INIT),
>> +    IRIS_STATE(ERROR),
>> +};
>> +
>> +#undef IRIS_STATE
>> +
>> +bool core_in_valid_state(struct iris_core *core)
> 
> So, even in your driver you have global names? That's really ugh. Please
> fix them.
> 
Sure will fix these names.
>> +{
>> +    return core->state == IRIS_CORE_INIT ||
>> +        core->state == IRIS_CORE_INIT_WAIT;
>> +}
>> +
>> +static const char *core_state_name(enum iris_core_state state)
>> +{
>> +    if ((unsigned int)state < ARRAY_SIZE(core_state_names))
>> +        return core_state_names[state];
>> +
>> +    return "UNKNOWN_STATE";
>> +}
>> +
>> +static bool iris_allow_core_state_change(struct iris_core *core,
>> +                     enum iris_core_state req_state)
>> +{
>> +    if (core->state == IRIS_CORE_DEINIT)
>> +        return req_state == IRIS_CORE_INIT_WAIT || req_state ==
>> IRIS_CORE_ERROR;
>> +    else if (core->state == IRIS_CORE_INIT_WAIT)
>> +        return req_state == IRIS_CORE_INIT || req_state == IRIS_CORE_ERROR;
>> +    else if (core->state == IRIS_CORE_INIT)
>> +        return req_state == IRIS_CORE_DEINIT || req_state ==
>> IRIS_CORE_ERROR;
>> +    else if (core->state == IRIS_CORE_ERROR)
>> +        return req_state == IRIS_CORE_DEINIT;
>> +
>> +    dev_warn(core->dev, "core state change %s -> %s is not allowed\n",
>> +         core_state_name(core->state), core_state_name(req_state));
>> +
>> +    return false;
>> +}
>> +
>> +int iris_change_core_state(struct iris_core *core,
>> +               enum iris_core_state request_state)
>> +{
>> +    if (core->state == request_state)
>> +        return 0;
>> +
>> +    if (!iris_allow_core_state_change(core, request_state))
>> +        return -EINVAL;
>> +
>> +    core->state = request_state;
>> +
>> +    return 0;
>> +}
>> diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_state.h
>> b/drivers/media/platform/qcom/vcodec/iris/iris_state.h
>> new file mode 100644
>> index 0000000..ee20842
>> --- /dev/null
>> +++ b/drivers/media/platform/qcom/vcodec/iris/iris_state.h
>> @@ -0,0 +1,22 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights
>> reserved.
>> + */
>> +
>> +#ifndef _IRIS_STATE_H_
>> +#define _IRIS_STATE_H_
>> +
>> +struct iris_core;
>> +
>> +enum iris_core_state {
>> +    IRIS_CORE_DEINIT,
>> +    IRIS_CORE_INIT_WAIT,
>> +    IRIS_CORE_INIT,
>> +    IRIS_CORE_ERROR,
>> +};
>> +
>> +bool core_in_valid_state(struct iris_core *core);
>> +int iris_change_core_state(struct iris_core *core,
>> +               enum iris_core_state request_state);
>> +
>> +#endif
> 

