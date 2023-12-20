Return-Path: <linux-kernel+bounces-6552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D090E819A46
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EEE5B25425
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276B11B26F;
	Wed, 20 Dec 2023 08:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f+UZR5qN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE111DDF4;
	Wed, 20 Dec 2023 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK45QWK009487;
	Wed, 20 Dec 2023 08:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=y97PlUBlYA4KaesTFqFePnZ+B1RQueYQWggjALC4a/c=; b=f+
	UZR5qN3Q3sh2WC3AfCaT8vI3hPo5Z5fIgaqxR22V8U6FdEbnSZGXstVJwprkSbLr
	eHPkOa5WnCRH6xAI9tNUTIcm+wSwe6otIF0rpGdJ567yPSqlB84dMJaWqDsEC28J
	hfxZY/0NUIsFFjIjcF6y6HiFvTOvwYdztgAVYLBOQxyRUBX7HCLPgraOsD2Lgr1d
	horG17bsrJB0YFJm3KmidVE7IYps/Ji6YZMFQdr140YkIMEPQTaEyov2vN/scC5W
	fv5oV+k0EK/SXh7whETi6e+hWRtoOuqPAxX6SwzAJvqcMML4rC8OLx+aT4BRqoo0
	x7I1Tk1g5ehC3N5hSw6Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3fa3hn35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:15:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BK8FtFY007975
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:15:55 GMT
Received: from [10.216.36.155] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 00:15:51 -0800
Message-ID: <a1f5a86e-f1ab-04ee-d682-8c2116a6a961@quicinc.com>
Date: Wed, 20 Dec 2023 13:45:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 10/34] media: iris: add PIL functionality for video
 firmware
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stanimir.k.varbanov@gmail.com>,
        <quic_vgarodia@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mchehab@kernel.org>,
        <bryan.odonoghue@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <quic_abhinavk@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <1702899149-21321-11-git-send-email-quic_dikshita@quicinc.com>
 <2997fa9b-2702-437c-ac46-118808f1138a@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <2997fa9b-2702-437c-ac46-118808f1138a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: W0J0ZfX43HEmR4EPMtgMvpZ8vG3-DerY
X-Proofpoint-ORIG-GUID: W0J0ZfX43HEmR4EPMtgMvpZ8vG3-DerY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 adultscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200056



On 12/19/2023 3:10 AM, Konrad Dybcio wrote:
> 
> 
> On 12/18/23 12:32, Dikshita Agarwal wrote:
>> Load/unload firmware in memory via mdt loader.
>> Firmware loading is part of core initialization
>> and unloading is part of core de-initialization.
>> This also changes the core states accordingly.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> ---
> [...]
> 
>> +
>> +#include "iris_core.h"
>> +#include "iris_helpers.h"
>> +#include "iris_hfi.h"
>> +#include "iris_state.h"
>> +
>> +static int iris_core_deinit_locked(struct iris_core *core)
> I suppose you meant to call this something like _nolock, as
> you're calling it with a lock around it
> 
We are trying to coney that this particular API should be called with
locked context only.
doesn't _nolock mean other way? please correct if my understanding is wrong.
>> +{
>> +    int ret;
>> +
>> +    ret = check_core_lock(core);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (core->state == IRIS_CORE_DEINIT)
>> +        return 0;
>> +
>> +    iris_hfi_core_deinit(core);
>> +
>> +    iris_change_core_state(core, IRIS_CORE_DEINIT);
> You're casually ignoring the return value of the two
> above funcs here :/
> 
Right, since this is the tear-down sequence, we don't care of the return
value here.
>> +
>> +    return ret;
>> +}
>> +
>> +int iris_core_deinit(struct iris_core *core)
>> +{
>> +    int ret;
>> +
>> +    mutex_lock(&core->lock);
>> +    ret = iris_core_deinit_locked(core);
>> +    mutex_unlock(&core->lock);
>> +
>> +    return ret;
>> +}
>> +
>> +int iris_core_init(struct iris_core *core)
>> +{
>> +    int ret = 0;
>> +
>> +    mutex_lock(&core->lock);
> You may be interested in scoped mutexes
> 
Will explore this.
>> +    if (core_in_valid_state(core)) {
>> +        goto unlock;
>> +    } else if (core->state == IRIS_CORE_ERROR) {
>> +        ret = -EINVAL;
>> +        goto unlock;
>> +    }
>> +
>> +    if (iris_change_core_state(core, IRIS_CORE_INIT_WAIT)) {
>> +        iris_change_core_state(core, IRIS_CORE_ERROR);
>> +        ret = -EINVAL;
>> +        goto unlock;
>> +    }
>> +
>> +    ret = iris_hfi_core_init(core);
>> +    if (ret) {
>> +        iris_change_core_state(core, IRIS_CORE_ERROR);
>> +        dev_err(core->dev, "%s: core init failed\n", __func__);
> __func__ still seems overly verbose in my eyes
> 
Sure, will remove such instances.
> [...]
> 
>> +
>> +int check_core_lock(struct iris_core *core)
>> +{
>> +    bool fatal = !mutex_is_locked(&core->lock);
>> +
>> +    WARN_ON(fatal);
>> +
>> +    return fatal ? -EINVAL : 0;
> You can simply inline this:
> 
> if (WARN_ON(!mutex_is_locked(&core->lock))
>     return -EINVAL;
> 
Thanks for the suggestion, will update this.
> [...]
>> +#define CP_START           0
>> +#define CP_SIZE            0x25800000
>> +#define CP_NONPIXEL_START  0x01000000
>> +#define CP_NONPIXEL_SIZE   0x24800000
>> +
>> +#define FW_NAME "vpu30_4v.mbn"
> This doesn't scale, at all.
> 
As mentioned in previous patches, we have not introduced platform specific
file yet, when I introduce that in later patch, this will be moved to
platform specific file.
> Konrad

