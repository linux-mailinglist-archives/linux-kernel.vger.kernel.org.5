Return-Path: <linux-kernel+bounces-31455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 170BF832E8E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1031F24DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CBE56746;
	Fri, 19 Jan 2024 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Rq1OrS5m"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027D05644A;
	Fri, 19 Jan 2024 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705687189; cv=none; b=Dt4p6ew/Hi+MBXgUPq7GZx0MporYznWdrzysnMCyBl3ziUK6toZ1iuO16LNWr+vprv5R+JXhYMceJcJbLzWAIvsATlOtb+6QjvGJm1/Dnbd2llWB97LTEaLSkBAmLeFCOUHPpbUxPjTHI7wTvEdGWyScJXIQKxMfY8jS6vmOvzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705687189; c=relaxed/simple;
	bh=MQu8y0M4Jts4ScVci4hTK3ghT1Vrlk00myLt2cCfWcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EIcmHqNNZQX8G3U5Jw6gLEbZa6FqmoFaQr/aYdGYUUvREwF22IOFeLYZcybwkS/FvoUXJBvpkqYB4Qn303McprW+VQ0+osndF9RysndcmVU9xeTQQH1HCG3o6IsTn4W+4LNBDpBJxIWzHALhtV8N+QoVk/fmEEFqBIZCJtU+ySs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Rq1OrS5m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40JGP8wd001659;
	Fri, 19 Jan 2024 17:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=KsejanrJsczGYRynswMeldvh36vvOWZzU/jvY1bGVDk=; b=Rq
	1OrS5mRiRDDbXc7jN0hnAHY05n12/KZrkBCfKxYrNY4lfnTvV3pIDpMZzRXt8RP3
	wEZ6u1Cd7NuF8z8J5ahBa227NXjg5dK1cWaD3iBPDHgWvv/GWUVggIerXIAK4sqq
	VsHgNe0LHQCrKse9cmjkcE917lBpH+GWiHBzvzX6q/5IFg2HqCSJvbO1NEVbIngt
	JHd7fovNfdT3Ri/7zQLuDgg8xL8ZX1vNYhWEYDHMlq416Y4iiRVgzRPrvPsgdMR0
	ti0uadwMGp7xGW/nTlRzaA+XB+7x8S5B+TeO3FH+ASogDTmeGmI0Uh7NGMK1bWLT
	fn8TFaQtDVrLp0NgS44g==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vqmefh82v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 17:59:42 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40JHxfwQ030865
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 17:59:41 GMT
Received: from [10.71.108.105] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 19 Jan
 2024 09:59:39 -0800
Message-ID: <003c8ea1-c455-4f68-bc8d-7ed9aa968a58@quicinc.com>
Date: Fri, 19 Jan 2024 09:59:37 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: qcom: rpmh-rsc: Enhance check for VREG in-flight
 request
Content-Language: en-US
To: Andrew Halaney <ahalaney@redhat.com>,
        Maulik Shah
	<quic_mkshah@quicinc.com>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_collinsd@quicinc.com>, <quic_lsrao@quicinc.com>
References: <20240119-rpmh-rsc-fixes-v2-1-e42c0a9e36f0@quicinc.com>
 <dahguk6hyo35ydugwno5t5lbteporwkiddhvxp6uni5ggbtxcm@3bu6ptvg7mdg>
From: Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <dahguk6hyo35ydugwno5t5lbteporwkiddhvxp6uni5ggbtxcm@3bu6ptvg7mdg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JmPOcrW9QMXxLhMQs8l5CnEympR6SgkV
X-Proofpoint-GUID: JmPOcrW9QMXxLhMQs8l5CnEympR6SgkV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_10,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190105



On 1/19/2024 7:47 AM, Andrew Halaney wrote:
> On Fri, Jan 19, 2024 at 01:56:54PM +0530, Maulik Shah wrote:
>> Each RPMh VREG accelerator resource has 3 or 4 contiguous 4-byte aligned
>> addresses associated with it. These control voltage, enable state, mode,
>> and in legacy targets, voltage headroom. The current in-flight request
>> checking logic looks for exact address matches. Requests for different
>> addresses of the same RPMh resource as thus not detected as in-flight.
>>
>> Enhance the in-flight request check for VREG requests by ignoring the
>> address offset. This ensures that only one request is allowed to be
>> in-flight for a given VREG resource. This is needed to avoid scenarios
>> where request commands are carried out by RPMh hardware out-of-order
>> leading to LDO regulator over-current protection triggering.
>>
>> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> 
> Just noticed I commented on v1 when v2 was already out, sorry. Copy
> pasting this just to keep it on the latest thread:
> 
> Two minor things:
> 
>     1. Does this deserve a Fixes: tag?
>     2. The Signed-off-by chain here confuses me, you sent the patch
>        so your SOB should be last, but then that makes me believe Elliot
>        was the author which I don't think is reflected here (no From:
>        line). Please read [0] for a bit more details
> 
> [0] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1
> 

Maulik's S-o-B should be last. This change was authored by him
in our downstream driver and this change was pointed out as
also being a fix for the upstream driver. I helped rebase/apply
the change to upstream to test and shared patch back with him
for posting to the list.

When he got the rebased patch, my S-o-B would've been last, but
now need to be updated again so his is last.

>> ---
>> Changes in v2:
>> - Use GENMASK() and FIELD_GET()
>> - Link to v1: https://lore.kernel.org/r/20240117-rpmh-rsc-fixes-v1-1-71ee4f8f72a4@quicinc.com
>> ---
>>  drivers/soc/qcom/rpmh-rsc.c | 21 ++++++++++++++++++++-
>>  1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>> index a021dc71807b..e480cde783fe 100644
>> --- a/drivers/soc/qcom/rpmh-rsc.c
>> +++ b/drivers/soc/qcom/rpmh-rsc.c
>> @@ -1,11 +1,13 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  /*
>>   * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
>>   */
>>  
>>  #define pr_fmt(fmt) "%s " fmt, KBUILD_MODNAME
>>  
>>  #include <linux/atomic.h>
>> +#include <linux/bitfield.h>
>>  #include <linux/cpu_pm.h>
>>  #include <linux/delay.h>
>>  #include <linux/interrupt.h>
>> @@ -91,6 +93,15 @@ enum {
>>  #define CMD_STATUS_ISSUED		BIT(8)
>>  #define CMD_STATUS_COMPL		BIT(16)
>>  
>> +#define ACCL_TYPE(addr)			FIELD_GET(GENMASK(19, 16), addr)
>> +#define VREG_ADDR(addr)			FIELD_GET(GENMASK(19, 4), addr)
>> +
>> +enum {
>> +	HW_ACCL_CLK = 0x3,
>> +	HW_ACCL_VREG,
>> +	HW_ACCL_BUS,
>> +};
>> +
>>  /*
>>   * Here's a high level overview of how all the registers in RPMH work
>>   * together:
>> @@ -557,7 +568,15 @@ static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
>>  		for_each_set_bit(j, &curr_enabled, MAX_CMDS_PER_TCS) {
>>  			addr = read_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_ADDR], i, j);
>>  			for (k = 0; k < msg->num_cmds; k++) {
>> -				if (addr == msg->cmds[k].addr)
>> +				/*
>> +				 * Each RPMh VREG accelerator resource has 3 or 4 contiguous 4-byte
>> +				 * aligned addresses associated with it. Ignore the offset to check
>> +				 * for in-flight VREG requests.
>> +				 */
>> +				if (ACCL_TYPE(msg->cmds[k].addr) == HW_ACCL_VREG &&
>> +				    VREG_ADDR(msg->cmds[k].addr) == VREG_ADDR(addr))
>> +					return -EBUSY;
>> +				else if (addr == msg->cmds[k].addr)
>>  					return -EBUSY;
>>  			}
>>  		}
>>
>> ---
>> base-commit: 943b9f0ab2cfbaea148dd6ac279957eb08b96904
>> change-id: 20240117-rpmh-rsc-fixes-6c43c7051828
>>
>> Best regards,
>> -- 
>> Maulik Shah <quic_mkshah@quicinc.com>
>>
>>
> 

