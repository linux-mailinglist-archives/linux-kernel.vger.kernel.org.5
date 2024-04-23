Return-Path: <linux-kernel+bounces-154650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5988ADF1D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CE8B1C2170F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586C25FB87;
	Tue, 23 Apr 2024 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jSskKB2m"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D614CE13;
	Tue, 23 Apr 2024 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713859223; cv=none; b=gNWPnlj9MVCMFaZKZ4hkSvA4GGS6BCq6gI5RRyxyuETUZ9OwuW2bhW/vfZrz6fW0AMkqKmSiq3opUEqS0CU23xPmVSWpVKTo+Kbku3ixFD8Ej06kttVdx7xsZbv45ggScARVPTieVX6pW9iBoxe8+TWHthWtthB8G5/niTGf1tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713859223; c=relaxed/simple;
	bh=Gjs1YyXbZfSoqXu9tkhXaa5jQcOvYAwpdnPpusemcgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TNSYcx2+dG2RpSw1vS5ku2x8nrGfTcQeVOgQiE26Yib3JTzHzyKisFxVDQ38R73Bu13POJNUlnuJYCaOOrbTuPyJBJAmjZAiZBrblAjb3KJF+0VsH5C+wKYywxxO84/bXq2Km3nQRzDg7KZorMxG+XjbHzDdnwlxTiefk56hUDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jSskKB2m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N5oIIj008040;
	Tue, 23 Apr 2024 08:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=K/NDNJoRVdEQv/C7r79vn1Wo3m5uwWt6KFqsxftKVRE=; b=jS
	skKB2mCDwwYAy6UUar8eMx83vU82oN8LNldajW22zDFa5cWJ4zuW9k9RsX7vW1Ph
	rOxuFqC0kT2JYCjuUncus1X3PuzLzN2ZIbnARZeZP0ThtX3fIlWuj9AdM8FHStJ8
	T/sLIg6gKm51WO/gzlE/tYBpKBiP4vZTVd7QcD4aU1HpZx5LQh/XmlVFI+a3S1dj
	8LPJIKW13/qyZpovhoQRD7FMRGkcRbHimDHLaOtkJlVrN8ddnTunn1OxeBuR7EZ4
	iixvbE0fwgzayc7TgG5oUlskEF9pukWZROF/8nxEJoHubi5wKmjWSmNk4D19RGHf
	H2mcxzCUOCaJlpdjGjoQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnne2anvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 08:00:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43N801QA003319
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 08:00:01 GMT
Received: from [10.111.135.16] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 00:59:57 -0700
Message-ID: <ae274d8b-54ee-9ad3-6f98-0b403a75b179@quicinc.com>
Date: Tue, 23 Apr 2024 13:29:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 05/19] media: venus: pm_helpers: Kill dead code
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov
	<stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross
	<agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Mauro Carvalho
 Chehab" <mchehab@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: Marijn Suijten <marijn.suijten@somainline.org>,
        Stanimir Varbanov
	<stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230911-topic-mars-v3-0-79f23b81c261@linaro.org>
 <20230911-topic-mars-v3-5-79f23b81c261@linaro.org>
 <fe9744d9-2db0-b1f3-72be-0fff1ee90d07@quicinc.com>
 <cb406f9a-36a9-45f5-a10c-d989bf602da6@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <cb406f9a-36a9-45f5-a10c-d989bf602da6@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z7kqn-50HUVOsqrbt5iocuXlUsGe8SzK
X-Proofpoint-ORIG-GUID: Z7kqn-50HUVOsqrbt5iocuXlUsGe8SzK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_04,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1011
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404230022



On 4/9/2024 11:54 PM, Konrad Dybcio wrote:
> 
> 
> On 4/5/24 09:49, Dikshita Agarwal wrote:
>>
>>
>> On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
>>> A situation like:
>>>
>>> if (!foo)
>>>     goto bar;
>>>
>>> for (i = 0; i < foo; i++)
>>>     ...1...
>>>
>>> bar:
>>>     ...2...
>>>
>>> is totally identical to:
>>>
>>> for (i = 0; i < 0; i++) // === if (0)
>>>     ...1...
>>>
>>> ...2...
>>>
>>> Get rid of such boilerplate.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>   drivers/media/platform/qcom/venus/pm_helpers.c | 10 ----------
>>>   1 file changed, 10 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c
>>> b/drivers/media/platform/qcom/venus/pm_helpers.c
>>> index ef4b0f0da36f..730c4b593cec 100644
>>> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
>>> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
>>> @@ -878,14 +878,10 @@ static int vcodec_domains_get(struct venus_core
>>> *core)
>>>           .pd_flags = PD_FLAG_NO_DEV_LINK,
>>>       };
>>>   -    if (!res->vcodec_pmdomains_num)
>>> -        goto skip_pmdomains;
>>> -
>> this condition should still be there to skip calling
>> dev_pm_domain_attach_list if vcodec_pmdomains_num is 0.
> 
> That should be totally fine, within that function there's this bit
> 
> if (num_pds <= 0)
>     return 0;
> 
> which bails out gracefully
> 
AFAIU, this condition won't be true eg: for 8916 and 8996.
because in the else condition[1], num_pds will be non-zero, as there is one
entry for power-domains in dtsi file for 8916, 8996 as well.

[1]https://elixir.bootlin.com/linux/v6.9-rc5/source/drivers/base/power/common.c#L213
Am I missing something here?

> Konrad

