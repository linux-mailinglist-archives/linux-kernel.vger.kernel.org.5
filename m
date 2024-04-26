Return-Path: <linux-kernel+bounces-159772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684D88B33C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779CB1C21BAA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE4713E8B2;
	Fri, 26 Apr 2024 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NtUEw5A+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BFB13C90F;
	Fri, 26 Apr 2024 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123234; cv=none; b=SSBKXWP22zCQQmkiKsCY9mIYD5jyOrIZM3RZx+2fvavpUo8EK61ZVWxe2RwuQnYb3WMk9dmS/N/PwlyiL+NAUKDW+HOvv6u5sbVrDWcpeR2tDyG2sXZvo2Lqk8UUsRcIOSkC/ug0OWGanoxbpN6RVkcn1+ldhiTsNwgYfxGBJJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123234; c=relaxed/simple;
	bh=xBUpP3VAjhJdXrYIjPZD0CAQ4mXC99ueDEdcVvn0xbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YrKe4UIejjFyVfWqUAzzwO57LvdthVhT1vokVOVHr4fGjiiPkyPyM0ClPx/Vf77x4nVx2Ot++okCL/YWSA4SqmbfpRYgbUQM+/OKrjbf9mhiTL5CaaK7+A6AMrvGj+9PAkuB95sYVLOJAH+b3LheM8HJntYIoim96VTb70GEgy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NtUEw5A+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q41YLU012981;
	Fri, 26 Apr 2024 09:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BUIIFoA4N2ESIijEp2JWqnWgumg1YcDccO7inyej7yI=; b=Nt
	UEw5A+H8vL4iSQmfnMTb8OIaAEu9zI1irjgkP9JL4s5QPos/EMOutuHwvoBn0uRx
	ZpR4MsWd/7ksqCHDctVXN/KUFWeO3JLKDxgW2o7gBSpy0ZngQWbCVTGdGRs8n08y
	SD/atlbO/HLr/HaJUkJRWvb6XMUcnm8Auf4+0zJgblHtTaZue42rbquYLaEPH+gd
	rhawsOCZiCiW1MAI1t5tdu0Ap2n41fbrfNuYX6bEPbkx6ptiNQ6RNQSTFaEYKm/q
	ucUzvhf05Jl6IRfgdGr32Jq81Fb6jYPvVzwz8b7WB/qzRW6VT4NYG4bJoaTqo0pO
	HUarX30L6YOVDZL/BWow==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xr3591ctd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 09:20:25 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43Q9KMaN025356
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 09:20:22 GMT
Received: from [10.218.10.146] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 26 Apr
 2024 02:20:16 -0700
Message-ID: <ca017ebf-c099-b436-f062-1341f765a08c@quicinc.com>
Date: Fri, 26 Apr 2024 14:50:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V2 7/8] clk: qcom: Add GPUCC driver support for SM4450
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
Content-Language: en-US
From: Ajit Pandey <quic_ajipan@quicinc.com>
In-Reply-To: <CAA8EJpqwrKcgm7c57=LpxS7+CfrN2UxNg8k_46auBrdZG7vQnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3uiw9dIqgbCoJcFFm8PKZL3HkWEE3PTx
X-Proofpoint-ORIG-GUID: 3uiw9dIqgbCoJcFFm8PKZL3HkWEE3PTx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_09,2024-04-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404260060



On 4/17/2024 11:35 AM, Dmitry Baryshkov wrote:
> On Tue, 16 Apr 2024 at 21:23, Ajit Pandey <quic_ajipan@quicinc.com> wrote:
>>
>> Add Graphics Clock Controller (GPUCC) support for SM4450 platform.
>>
>> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
>> ---
>>   drivers/clk/qcom/Kconfig        |   9 +
>>   drivers/clk/qcom/Makefile       |   1 +
>>   drivers/clk/qcom/gpucc-sm4450.c | 805 ++++++++++++++++++++++++++++++++
>>   3 files changed, 815 insertions(+)
>>   create mode 100644 drivers/clk/qcom/gpucc-sm4450.c
> 
> [skipped]
> 
>> +
>> +static int gpu_cc_sm4450_probe(struct platform_device *pdev)
>> +{
>> +       struct regmap *regmap;
>> +
>> +       regmap = qcom_cc_map(pdev, &gpu_cc_sm4450_desc);
>> +       if (IS_ERR(regmap))
>> +               return PTR_ERR(regmap);
>> +
>> +       clk_lucid_evo_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
>> +       clk_lucid_evo_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
>> +
>> +       /* Keep some clocks always enabled */
>> +       qcom_branch_set_clk_en(regmap, 0x93a4); /* GPU_CC_CB_CLK */
>> +       qcom_branch_set_clk_en(regmap, 0x9004); /* GPU_CC_CXO_AON_CLK */
>> +       qcom_branch_set_clk_en(regmap, 0x900c); /* GPU_CC_DEMET_CLK */
> 
> My main concern here is the AON clocks. If we don't model
> gpu_cc_demet_clk as a leaf clock, then gpu_cc_demet_div_clk_src
> becomes a clock without children and can be disabled by Linux.
> Likewise not modelling gpu_cc_cxo_aon_clk removes one of the voters on
> gpu_cc_xo_clk_src, which can now be turned off by Linux.
> Our usual recommendation is to model such clocks properly and to use
> CLK_IS_CRITICAL or CLK_IGNORE_UNUSED to mark then as aon.
> 
Thanks for review, actually if leaf (branch) clock is ON, hardware will 
take care of enabling and keeping the parent ON. So parent clocks won't 
get turned OFF in HW as long as branch clock is enabled.

For clocks which are fixed rate (19.2MHz) and recommended to be kept ON 
forever from HW design, modelling and exposing clock structure in kernel 
will be a redundant code in kernel memory, hence as per earlier 
suggestion in previous thread such clocks are recommended to be kept 
enabled from probe.
>> +
>> +       return qcom_cc_really_probe(pdev, &gpu_cc_sm4450_desc, regmap);
>> +}
>> +
>> +static struct platform_driver gpu_cc_sm4450_driver = {
>> +       .probe = gpu_cc_sm4450_probe,
>> +       .driver = {
>> +               .name = "gpucc-sm4450",
>> +               .of_match_table = gpu_cc_sm4450_match_table,
>> +       },
>> +};
>> +
>> +module_platform_driver(gpu_cc_sm4450_driver);
>> +
>> +MODULE_DESCRIPTION("QTI GPUCC SM4450 Driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.25.1
>>
>>
> 
> 

-- 
Thanks, and Regards
Ajit

