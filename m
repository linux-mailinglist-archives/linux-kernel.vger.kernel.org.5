Return-Path: <linux-kernel+bounces-109286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85E0881726
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078BB1C209D9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85946E5FB;
	Wed, 20 Mar 2024 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fNgRUmhc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8060D6A8DB;
	Wed, 20 Mar 2024 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957948; cv=none; b=fp2iQfFbmkHuXPrINa5ZqY5ifaYgODBQ5X7SMYyZfOMf6Ut84gDmQdNsDWwB+TonrnXMRyoHId+pOFv6MOhgmPyE7bs6wnmkXjxAGZQWg+itCfj1ghH8W32uxJnPlwXvPJo01P45kljDrkhGH80cqhhdkiTRxIwSt61uCEW7zKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957948; c=relaxed/simple;
	bh=iQVUGzXn0c5bi/SU4zDmbsnd52UvgjyG9N6rleVGyHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FjbiF9sXFwOrXi4cew5bl+z+sNL4CEvIUsX1pCK9uWMTxkOjvcYnx+/H+z522mj97Z2phIYJYHb4EFFhk7CzB3llid8G+HOFebYscJ+CWw5f735BvL9hzykGHKA/MPJSljugFAUO2s29Q2LidItrJJ7mNcTOWDvYZx/NC6wvf3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fNgRUmhc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KGMStc007784;
	Wed, 20 Mar 2024 18:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+8jPJ+sngF+v8V500bMd4bYQ1kZLjlxsZw5hsALYqYQ=; b=fN
	gRUmhcpHBPKzKsMoKzq79NcFeFTd21O0Sg/1DHPOyE2G9HOUsoMI9KSg9wpCLgEq
	VIxAAwOb83sJAV+RDvXatFQ9bq716GqQW8t0P8Bg11izsG0GxTZ4xpMigguffAs3
	qr5HkJx+EPibk9gRI9a8tIRdeIyb+L6JbuZOI7wS+XaxxuUKX53PDT7huA0HFs6T
	miBaXXC5XYk3/rsnSfl1Amsvy/0y4Lv/9Yw0jP6RYkKdnpOaobhKzsuvQWbHwzoE
	gQUqgnMUeuCgmFqMZOhChYDCGdEN8ghwhv9nkAjwCczdaRVHtrAwSt63Ex9uK98C
	NMTEtvMsuoUF1E5DU22g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x038xr81f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 18:05:41 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KI5etb000985
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 18:05:40 GMT
Received: from [10.50.49.240] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Mar
 2024 11:05:35 -0700
Message-ID: <95045552-dd6c-49b1-ac39-e2d6151e171c@quicinc.com>
Date: Wed, 20 Mar 2024 23:35:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] interconnect: qcom: sc7280: enable QoS programming
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
 <20240306073016.2163-3-quic_okukatla@quicinc.com>
 <3bace619-46fc-4f9f-bfb3-4c55cb4d8408@linaro.org>
From: Odelu Kukatla <quic_okukatla@quicinc.com>
In-Reply-To: <3bace619-46fc-4f9f-bfb3-4c55cb4d8408@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7bW50m-yPk0FJAH1zpB-pyp2w7x93tuY
X-Proofpoint-ORIG-GUID: 7bW50m-yPk0FJAH1zpB-pyp2w7x93tuY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200144



On 3/6/2024 9:55 PM, Konrad Dybcio wrote:
> 
> 
> On 3/6/24 08:30, Odelu Kukatla wrote:
>> Enable QoS for the master ports with predefined values
>> for priority and urgency.
>>
>> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
>> ---
>>   drivers/interconnect/qcom/sc7280.c | 332 +++++++++++++++++++++++++++++
>>   1 file changed, 332 insertions(+)
>>
>> diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
>> index 7d33694368e8..1e1002c4d3d8 100644
>> --- a/drivers/interconnect/qcom/sc7280.c
>> +++ b/drivers/interconnect/qcom/sc7280.c
>> @@ -1,6 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /*
>>    * Copyright (c) 2021, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>>    *
>>    */
>>   
>> @@ -16,29 +17,53 @@
>>   #include "icc-rpmh.h"
>>   #include "sc7280.h"
>>   
>> +static const struct qcom_icc_qosbox qhm_qspi_qos = {
>> +	.num_ports = 1,
>> +	.port_offsets = { 0x7000 },
>> +	.prio = 2,
>> +	.urg_fwd = 0,
>> +};
>> +
>>   static struct qcom_icc_node qhm_qspi = {
>>   	.name = "qhm_qspi",
>>   	.id = SC7280_MASTER_QSPI_0,
>>   	.channels = 1,
>>   	.buswidth = 4,
>> +	.qosbox = &qhm_qspi_qos,
> 
> 	.qosbox = &(const struct qcom_icc_qosbox) {
> 		.num_ports = 1,
> 		...
> 	},
>

I would like to keep as it is, it provides better readability for QoS parameters.
 
> 
> 
> Looks sensible otherwise
> 
> Konrad

Thanks,
Odelu

