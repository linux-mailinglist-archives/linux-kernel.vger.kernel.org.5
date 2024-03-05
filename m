Return-Path: <linux-kernel+bounces-92170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825DD871C36
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B681C22C67
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F544627E7;
	Tue,  5 Mar 2024 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MkR7jZLm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8F85F548;
	Tue,  5 Mar 2024 10:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635405; cv=none; b=oRtJnV2tJz6/NYrKvLpfJqa2GhjY2RPJfd0Z36B1b9aOTh5r7USt7ihF23+gXdqh9yjxO38rBtP6sjBP1HyYjwI5LuC+kb2crNfI8+rQWU0lMgPZth8Co8G8HvQSFNmDlMuuUWVkyd5a6FXDqONXzZQSShDSVcB1ZKiNzuWxxxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635405; c=relaxed/simple;
	bh=hDbY2NQ9polGrv9HSJqo9UNEanixoEg4qzdkooTajxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E7XxzNotQ1MFwqa7qailBrPWKcqM1X7kSFbnTHwOekGZD6SThnDiGoqndQssDaCUCSBxOmHHu6+le0YObYzmTgTWl6iEwKB7WC7d+eHmX8T5k7HF0WAw1KnYxuje10miJotAfjgPKRu2Z4nlWpAdqGSFmehLbVcE2Z52tYoaQw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MkR7jZLm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4258dt9C021261;
	Tue, 5 Mar 2024 10:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=8PGf5hdv0hOQx9O36PwsQAiUUTJREg1bm9I7Nb6wUFA=; b=Mk
	R7jZLmhOym9Dbs1hn584vPzFkBZJ6S5hyfvrlZagN4YnKQiVhJBZOCD+nAAY5dsV
	Pw5mHpiNutYo5L5yL4k26bx28WzLLNlzMIW8KXfgKDANKbnX0IIrTlVibHl4kWCk
	vw5w8/gKDB3cAhxS1xtr4bsfPzUZukne+NJB602VwIwsZUg3nnp8Yke+oVbs+J8I
	u2GFEGGWQEk8OTYkFPmzl6EnL/7n2W1FXh6z7Z0Izsgex1/BM9eQI4042KtG44mw
	89j1Xu4mOduGL35URilZm7rXsdV3ohe21lsQ1bJqN7nHK8gmSgYfY+AJghYG/wpz
	gObpNIlsu0mAGCpD1hSA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnucrrsf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 10:43:20 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 425AhJns001655
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 10:43:19 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Mar
 2024 02:43:15 -0800
Message-ID: <fb419b4b-62b2-8316-201e-e11430e32d8f@quicinc.com>
Date: Tue, 5 Mar 2024 16:13:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 3/9] firmware: qcom: scm: Modify only the download
 bits in TCSR register
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>
CC: <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>,
        Poovendhan Selvaraj
	<quic_poovendh@quicinc.com>,
        Kathiravan Thirumoorthy
	<quic_kathirav@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>
References: <20240227155308.18395-1-quic_mojha@quicinc.com>
 <20240227155308.18395-4-quic_mojha@quicinc.com>
 <ncyanjtxtqyx236d5tfm46nepvy6ncxikonc6g6hlddhx2joee@jqjhfxtu3sr6>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <ncyanjtxtqyx236d5tfm46nepvy6ncxikonc6g6hlddhx2joee@jqjhfxtu3sr6>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: owAQoPT0hUqYLOay4X0cQRPRi_y6TqrM
X-Proofpoint-ORIG-GUID: owAQoPT0hUqYLOay4X0cQRPRi_y6TqrM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_08,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050085



On 3/3/2024 12:43 AM, Bjorn Andersson wrote:
> On Tue, Feb 27, 2024 at 09:23:02PM +0530, Mukesh Ojha wrote:
>> Crashdump collection is done based on DLOAD bits of TCSR register.
>> To retain other bits, scm driver need to read the register and
>> modify only the DLOAD bits, as other bits in TCSR may have their
>> own significance.
>>
>> Co-developed-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> Tested-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com> # IPQ9574 and IPQ5332
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   drivers/firmware/qcom/qcom_scm.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
>> index 8f766fce5f7c..bd6bfdf2d828 100644
>> --- a/drivers/firmware/qcom/qcom_scm.c
>> +++ b/drivers/firmware/qcom/qcom_scm.c
>> @@ -4,6 +4,8 @@
>>    */
>>   
>>   #include <linux/arm-smccc.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/bits.h>
>>   #include <linux/clk.h>
>>   #include <linux/completion.h>
>>   #include <linux/cpumask.h>
>> @@ -114,6 +116,12 @@ static const u8 qcom_scm_cpu_warm_bits[QCOM_SCM_BOOT_MAX_CPUS] = {
>>   #define QCOM_SMC_WAITQ_FLAG_WAKE_ONE	BIT(0)
>>   #define QCOM_SMC_WAITQ_FLAG_WAKE_ALL	BIT(1)
>>   
>> +#define QCOM_DLOAD_MASK		GENMASK(5, 4)
>> +enum qcom_dload_mode {
>> +	QCOM_DLOAD_NODUMP	= 0,
>> +	QCOM_DLOAD_FULLDUMP	= 1,
> 
> These values are not enumerations, they represent fixed/defined values
> in the interface. As such it's appropriate to use #define.
> 

Thanks for giving reasoning on why it should be #define and not enum.

-Mukesh

