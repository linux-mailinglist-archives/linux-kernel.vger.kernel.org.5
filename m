Return-Path: <linux-kernel+bounces-163813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 134688B71DB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366AA1C225A5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A56012D1FC;
	Tue, 30 Apr 2024 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g9jzemwm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8471012B176;
	Tue, 30 Apr 2024 11:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474889; cv=none; b=sAPb9p5hIQ7vShLAzQwh2vAYJ0+RAJknr6OgAfyrVZtvJAdTKWYrVCx/XpniQnryFE4Fk3OG0B9KrT4cM2EGJHveCmx7ayP1JbDUxzhEKzv3nM33PbLQCgzeluDf2a9M8VZzB0YGHiBswf23dg25qUCYk3OiJLvh69jIiqftxA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474889; c=relaxed/simple;
	bh=b7L3j9BEHAkxTo0bCpfLzXEMvT1DErHSzv9yS4zjp54=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sfCQtU0JtpVRSQX2ZLWUKBLm+ktKiTbFviIJch28ImofYn4jTCRGf/GV5Bf1j5G8RpfTvUc/rL7ULjwYm/LQJwGMi/fS1UfGGqFI4I/TCuGslhEQSjH4R4tvnkcsuh1tAR/2n1mcS0sS0AuRZUZkX4w8Q4ghmnflXeZQbqSvi9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g9jzemwm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U2voaN020937;
	Tue, 30 Apr 2024 11:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=X7Rc8KFfx4MULlBzEIo2WCl6G9Jhr+x3S4V3+nxxJ0I=; b=g9
	jzemwmF0MBxixChOcktgYpOoYgjEeXXBEAJCeFb7VX/AyAkUJCOEKHrQNap430hE
	BIqZqNiI95eR5xXg6gPATc4euYIE54DwPLu5Q0LgVYtqiXGl9ITLA0WqLzbo0YYZ
	vThcNilzhoaZKxHUXd1iE/bN0cZSDRjmQL/QpsPPdnAK7wcgk18no/FnN+wrz1me
	6arn5jGiDqAQ5FU9g1GWDwR8gPsWSXVkEUSa7jeWSaljxFkgyXVioXsIF59Iz+L5
	h5KjncCa7nCYNjQht4TDgYREkUPf+7XXHJGoGndzEEKg+lMbcxzNtWes2JLEi25U
	dgNc9VW7s81hjj+Kap5g==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtb6058bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 11:01:16 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UB1FJt008836
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 11:01:15 GMT
Received: from [10.218.10.146] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 04:01:10 -0700
Message-ID: <2679710d-46a9-8544-afff-8a406fdde918@quicinc.com>
Date: Tue, 30 Apr 2024 16:31:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V2 7/8] clk: qcom: Add GPUCC driver support for SM4450
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Zapolskiy
	<vladimir.zapolskiy@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        "Satya Priya Kakitapalli"
	<quic_skakitap@quicinc.com>
References: <20240416182005.75422-1-quic_ajipan@quicinc.com>
 <20240416182005.75422-8-quic_ajipan@quicinc.com>
 <CAA8EJpqwrKcgm7c57=LpxS7+CfrN2UxNg8k_46auBrdZG7vQnA@mail.gmail.com>
 <ca017ebf-c099-b436-f062-1341f765a08c@quicinc.com>
 <CAA8EJporZFsjagW5CU5AwtqDsEXTtGJmRmLRedyBTZa7249p6w@mail.gmail.com>
From: Ajit Pandey <quic_ajipan@quicinc.com>
In-Reply-To: <CAA8EJporZFsjagW5CU5AwtqDsEXTtGJmRmLRedyBTZa7249p6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zUIEbfvjTV0biSb-FapWKHtNTfURCUKw
X-Proofpoint-ORIG-GUID: zUIEbfvjTV0biSb-FapWKHtNTfURCUKw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_04,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300079



On 4/26/2024 3:05 PM, Dmitry Baryshkov wrote:
> On Fri, 26 Apr 2024 at 12:20, Ajit Pandey <quic_ajipan@quicinc.com> wrote:
>>
>>
>>
>> On 4/17/2024 11:35 AM, Dmitry Baryshkov wrote:
>>> On Tue, 16 Apr 2024 at 21:23, Ajit Pandey <quic_ajipan@quicinc.com> wrote:
>>>>
>>>> Add Graphics Clock Controller (GPUCC) support for SM4450 platform.
>>>>
>>>> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
>>>> ---
>>>>    drivers/clk/qcom/Kconfig        |   9 +
>>>>    drivers/clk/qcom/Makefile       |   1 +
>>>>    drivers/clk/qcom/gpucc-sm4450.c | 805 ++++++++++++++++++++++++++++++++
>>>>    3 files changed, 815 insertions(+)
>>>>    create mode 100644 drivers/clk/qcom/gpucc-sm4450.c
>>>
>>> [skipped]
>>>
>>>> +
>>>> +static int gpu_cc_sm4450_probe(struct platform_device *pdev)
>>>> +{
>>>> +       struct regmap *regmap;
>>>> +
>>>> +       regmap = qcom_cc_map(pdev, &gpu_cc_sm4450_desc);
>>>> +       if (IS_ERR(regmap))
>>>> +               return PTR_ERR(regmap);
>>>> +
>>>> +       clk_lucid_evo_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
>>>> +       clk_lucid_evo_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
>>>> +
>>>> +       /* Keep some clocks always enabled */
>>>> +       qcom_branch_set_clk_en(regmap, 0x93a4); /* GPU_CC_CB_CLK */
>>>> +       qcom_branch_set_clk_en(regmap, 0x9004); /* GPU_CC_CXO_AON_CLK */
>>>> +       qcom_branch_set_clk_en(regmap, 0x900c); /* GPU_CC_DEMET_CLK */
>>>
>>> My main concern here is the AON clocks. If we don't model
>>> gpu_cc_demet_clk as a leaf clock, then gpu_cc_demet_div_clk_src
>>> becomes a clock without children and can be disabled by Linux.
>>> Likewise not modelling gpu_cc_cxo_aon_clk removes one of the voters on
>>> gpu_cc_xo_clk_src, which can now be turned off by Linux.
>>> Our usual recommendation is to model such clocks properly and to use
>>> CLK_IS_CRITICAL or CLK_IGNORE_UNUSED to mark then as aon.
>>>
>> Thanks for review, actually if leaf (branch) clock is ON, hardware will
>> take care of enabling and keeping the parent ON. So parent clocks won't
>> get turned OFF in HW as long as branch clock is enabled.
>>
>> For clocks which are fixed rate (19.2MHz) and recommended to be kept ON
>> forever from HW design, modelling and exposing clock structure in kernel
>> will be a redundant code in kernel memory, hence as per earlier
>> suggestion in previous thread such clocks are recommended to be kept
>> enabled from probe.
> 
> Recommended by whom?
> 
> Kernel developers clearly recommend describing all the clocks so that
> CCF has knowledge about all the clocks in the system.

Actually it's been recommended earlier by Stephen during initial 
discussion on moving such critical clocks to probe to avoid redundant 
codes in kernel memory. From then we're following similar approach in 
other mainlined CC's drivers for fixed rate clocks which needs to kept 
enabled always - eg: DISP_CC_XO_CLK (keeping bits enabled in probe) in 
SM8450, SM8650 etc.

> 
>>>> +
>>>> +       return qcom_cc_really_probe(pdev, &gpu_cc_sm4450_desc, regmap);
>>>> +}
>>>> +
>>>> +static struct platform_driver gpu_cc_sm4450_driver = {
>>>> +       .probe = gpu_cc_sm4450_probe,
>>>> +       .driver = {
>>>> +               .name = "gpucc-sm4450",
>>>> +               .of_match_table = gpu_cc_sm4450_match_table,
>>>> +       },
>>>> +};
>>>> +
>>>> +module_platform_driver(gpu_cc_sm4450_driver);
>>>> +
>>>> +MODULE_DESCRIPTION("QTI GPUCC SM4450 Driver");
>>>> +MODULE_LICENSE("GPL");
>>>> --
>>>> 2.25.1
>>>>
>>>>
>>>
>>>
>>
>> --
>> Thanks, and Regards
>> Ajit
> 
> 
> 

-- 
Thanks, and Regards
Ajit

