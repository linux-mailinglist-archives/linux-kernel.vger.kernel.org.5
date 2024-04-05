Return-Path: <linux-kernel+bounces-132679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B3B89987F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740BB1C20D35
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1119E15FCFE;
	Fri,  5 Apr 2024 08:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UbfBcB0f"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29A115FA91;
	Fri,  5 Apr 2024 08:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712307021; cv=none; b=GjUmNUSO6gPJrx4k3ugYR428OXIi/NB+DZZqPmHW1fg4vRO2sNfWWJ1r04QeVd5kc/Ch8Zs4kDdBpWXJRZCqv1c+Y8Z+aHvZymWv/2zCQBOjhc6bN8Lvofa5M9r7x1wkDAUIKu1E2tJxsY+Mm680ZBzwgihrH68SeIt4yRvK/eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712307021; c=relaxed/simple;
	bh=3E3mclh3V0FGZ6/44aB2xXEY7h1qkY9lHfKPyd0dWnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rVTSc5wvIdIgPgPr/7vgGSTW0yCSMQ/UsHxCcZbDaK1QRzldkZ57uWdWDSXrjJx3F67+D2lCPOXyRKaCmf0aqGwpTZAej42vLuXJ1VV1bjdXiWJ29pMt/1pcCwuJ5JztxKBFGJm1kxh1J2tzgtQbl2DgOPlqckV8pXa1jbBXLBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UbfBcB0f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4356t2DS000862;
	Fri, 5 Apr 2024 08:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=rQEQtFpKWMoTGFs+Fm35nV+6RbY73uNgghuY3KIJPoY=; b=Ub
	fBcB0ffMSGZhWNUSwrWRrrvN8GuYF455Yuyey5QU966KS6RW1bkyDFaY/paIvYsV
	UeDA0/biUBEw3q0px6LkLnVJDrJp8LipdiU0eo4PUMhMS1p8L2+EX6VDLEfo9D1g
	d2m0YhXSoHIxAt75LomUHdu2o3Fw0A7H/ueXBnrjx6WFseNJCUhlk3GZRLlqnvlg
	XiXITZpBQe361W5zj4DKK5uhf51Hz+FT+em0y/yXGBadTdZjlNsUPK8xUGai8rvm
	UOsHRusFupc2TH3QWsaqsAoDMQPVZlXxi8PgB98Z2Hr7X9oeGRwXW/E64d4mCLDB
	oXYx6zmtrmJvp5+0deIw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa4ej92y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 08:50:07 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4358o5d9017679
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 08:50:05 GMT
Received: from [10.216.12.56] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 01:50:00 -0700
Message-ID: <b960add1-df5f-ced3-74a8-ba4272cae0f3@quicinc.com>
Date: Fri, 5 Apr 2024 14:19:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 01/19] media: venus: pm_helpers: Only set rate of the
 core clock in core_clks_enable
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Stanimir Varbanov
	<stanimir.k.varbanov@gmail.com>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Philipp
 Zabel" <p.zabel@pengutronix.de>
CC: Marijn Suijten <marijn.suijten@somainline.org>,
        Stanimir Varbanov
	<stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230911-topic-mars-v3-0-79f23b81c261@linaro.org>
 <20230911-topic-mars-v3-1-79f23b81c261@linaro.org>
 <988b641e-120a-9cb7-f35a-512f865aa6bd@quicinc.com>
Content-Language: en-US
From: Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <988b641e-120a-9cb7-f35a-512f865aa6bd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KCFOCHoYFq6y4YYS62-5KwLlNsU2Md7C
X-Proofpoint-GUID: KCFOCHoYFq6y4YYS62-5KwLlNsU2Md7C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_08,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1011 adultscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050064

Hi Konrad,

On 4/5/2024 1:01 PM, Dikshita Agarwal wrote:
> 
> 
> On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
>> Commit c22b1a29497c ("media: venus: core,pm: Vote for min clk freq
>> during venus boot") intended to up the rate of the Venus core clock
>> from the XO minimum to something more reasonable, based on the per-
>> SoC frequency table.
>>
>> Unfortunately, it ended up calling set_rate with that same argument
>> on all clocks in res->clks. Fix that using the OPP API.
It called with same argument, but not with same frequency. The argument is
platform specific and would have different values. Do not see it fixing anything
in existing code, so "Fixes" does not look applicable here. OR, am i  missing
something ?

Thanks,
Vikash
>>
>> Fixes: c22b1a29497c ("media: venus: core,pm: Vote for min clk freq during venus boot")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/media/platform/qcom/venus/pm_helpers.c | 23 +++++++++++------------
>>  1 file changed, 11 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
>> index 502822059498..8bd0ce4ce69d 100644
>> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
>> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
>> @@ -41,24 +41,23 @@ static int core_clks_get(struct venus_core *core)
>>  static int core_clks_enable(struct venus_core *core)
>>  {
>>  	const struct venus_resources *res = core->res;
>> -	const struct freq_tbl *freq_tbl = core->res->freq_tbl;
>> -	unsigned int freq_tbl_size = core->res->freq_tbl_size;
>> -	unsigned long freq;
>> +	struct dev_pm_opp *opp;
>> +	unsigned long freq = 0;
>>  	unsigned int i;
>>  	int ret;
>>  
>> -	if (!freq_tbl)
>> -		return -EINVAL;
>> +	if (core->has_opp_table) {
>> +		opp = dev_pm_opp_find_freq_ceil(core->dev, &freq);
>> +		if (IS_ERR(opp))
>> +			return PTR_ERR(opp);
>> +		dev_pm_opp_put(opp);
>>  
>> -	freq = freq_tbl[freq_tbl_size - 1].freq;
>> +		ret = dev_pm_opp_set_rate(core->dev, freq);
>> +		if (ret)
>> +			return ret;
>> +	}
> Earlier clk_set_rate is called for only V6 target, this change is calling
> it unconditionally. Opp table is available for v4 target as well.
>>  
>>  	for (i = 0; i < res->clks_num; i++) {
>> -		if (IS_V6(core)) {
>> -			ret = clk_set_rate(core->clks[i], freq);
>> -			if (ret)
>> -				goto err;
>> -		}
>> -
>>  		ret = clk_prepare_enable(core->clks[i]);
>>  		if (ret)
>>  			goto err;
>>
> 
> Thanks,
> Dikshita

