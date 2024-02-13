Return-Path: <linux-kernel+bounces-63069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADCE852A6C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3519B283E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06301799D;
	Tue, 13 Feb 2024 08:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E9OdbRPj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D6E171AF;
	Tue, 13 Feb 2024 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707811420; cv=none; b=V0ydjkwoi3E3inDW07bC2IOL5SZqQJ5ysnzlnxdLVUTH0sGzzdGZQMa5BrFIDk0LXN78105xEk2Ssf6w4xdOCXHPTW6vhq1zRem7NLncFzruOPYhvsWrvwspC5U/fCQ6YaFp0jRxPPTeob6sFlgWLFMnUrY3gNAd3XJRDkwtq9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707811420; c=relaxed/simple;
	bh=r087+GB79p23FR6tfcM56d6lnCI+rGfHLqR9nzg6yPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hxUq4zfXgnH001Tsu5dTIrqRwtZFkGMkIFSDbp7AsUGsBEZ8ibJVtOlHK3raYmN7RAzl80at0Sp/D1MqA96Hb6iEBi0yuYbl4B+VLbFRmhsgzxLi0Vnds570wGSUQnYFIcEFXd6C2NbuBS2dpRSEvVKeRvPugrKXmTSboEmt2dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E9OdbRPj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D7l4fg014541;
	Tue, 13 Feb 2024 08:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=LwcWrrBeGMk5PEnK2mar74GZ06ybPxBuCLBEY2vNIzw=; b=E9
	OdbRPj9ys91T2HS1X5SSlhanUJf2H1SAaNaG31o+WVNimb30XnE6uzkfT3xLPbwq
	9w5Sm+CcW3/p3eknvoxLn7uW040ZR292D39ZIwwdcSf2TxXYtyBIyHNK4F4BHxFw
	jxT9fwt/41X7I9SrAaaBm8GhoFwjODg2Y7iJFmfFOQr7U5H/ZaRyfaoZ6zu/bvno
	DbdptlX6K+24tEBiReh4/N19XzqVwNIGqWtRw7EehOfs/zHHCfy7Nwpk33WE/FS+
	GjftW13tx4DDV3p0mlzOa2wz06O0vbx93QYeT11crliGu7Uq0LlS79pLineilb8n
	bMaDc08l519H3bm1rn8w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7gvjjf60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 08:03:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D83PrE013449
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 08:03:25 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 13 Feb
 2024 00:03:21 -0800
Message-ID: <64fdfa4d-f7ec-a5eb-bfbc-ee35d9cd4722@quicinc.com>
Date: Tue, 13 Feb 2024 13:33:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] firmware: arm_scmi: Add support for marking certain
 frequencies as boost
Content-Language: en-US
To: Sudeep Holla <sudeep.holla@arm.com>,
        Pierre Gondois
	<pierre.gondois@arm.com>
CC: <cristian.marussi@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <sboyd@kernel.org>, <lukasz.luba@arm.com>, <dietmar.eggemann@arm.com>,
        <morten.rasmussen@arm.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <nm@ti.com>
References: <20240117110443.2060704-1-quic_sibis@quicinc.com>
 <20240117110443.2060704-3-quic_sibis@quicinc.com>
 <e3abe1ab-064f-4a6a-a91d-fe8c91574600@arm.com>
 <20240131160848.662dhaoiov3trt4i@bogus>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20240131160848.662dhaoiov3trt4i@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -UksrDOFRADqZzuw6MQ93VX6tSjWhXt0
X-Proofpoint-ORIG-GUID: -UksrDOFRADqZzuw6MQ93VX6tSjWhXt0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=828 adultscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130061



On 1/31/24 21:38, Sudeep Holla wrote:
> On Wed, Jan 31, 2024 at 03:29:43PM +0100, Pierre Gondois wrote:
>> Hello Sibi,
>>
>> On 1/17/24 12:04, Sibi Sankar wrote:
>>> All opps above the sustained level/frequency are treated as boost, so mark
>>> them accordingly.
>>>

Sudeep/Pierre,

Thanks for taking time to review the series.

>>> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
>>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>>> ---
>>>    drivers/firmware/arm_scmi/perf.c | 11 ++++++++++-
>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
>>> index e286f04ee6e3..d3fb8c804b3d 100644
>>> --- a/drivers/firmware/arm_scmi/perf.c
>>> +++ b/drivers/firmware/arm_scmi/perf.c
>>> @@ -811,7 +811,7 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
>>>    				     struct device *dev, u32 domain)
>>>    {
>>>    	int idx, ret;
>>> -	unsigned long freq;
>>> +	unsigned long freq, sustained_freq;
>>>    	struct dev_pm_opp_data data = {};
>>>    	struct perf_dom_info *dom;
>>> @@ -819,12 +819,21 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
>>>    	if (IS_ERR(dom))
>>>    		return PTR_ERR(dom);
>>> +	if (!dom->level_indexing_mode)
>>> +		sustained_freq = dom->sustained_perf_level * dom->mult_factor;
>>> +	else
>>> +		sustained_freq = dom->sustained_freq_khz * dom->mult_factor;
>>> +
>>>    	for (idx = 0; idx < dom->opp_count; idx++) {
>>>    		if (!dom->level_indexing_mode)
>>>    			freq = dom->opp[idx].perf * dom->mult_factor;
>>>    		else
>>>    			freq = dom->opp[idx].indicative_freq * dom->mult_factor;
>>> +		/* All opps above the sustained level/frequency are treated as boost */
>>> +		if (sustained_freq && freq > sustained_freq)
>>
>> It seems the sustained_freq is not optional since SCMI v1.0,
>> is it necessary to check that (sustained_freq != 0) ?
>>
> 
> Technically correct, we don't have to. But since day 1, we checked and
> handled 0 for perf_level specifically to avoid division by zero. I am
> just worried if there are any platforms in the wild with these values as
> 0. We can start without the check and add it if someone complains perhaps ?

sure will drop the check in the re-spin.

-Sibi

> 

