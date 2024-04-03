Return-Path: <linux-kernel+bounces-129694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B639D896E90
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17466B26E14
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2508914535B;
	Wed,  3 Apr 2024 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JAY+XuuX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02B8134CCA;
	Wed,  3 Apr 2024 11:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712145595; cv=none; b=B4hUiH7wGVpmrz6wFVqBElSfRF/Z9hPHITWda2jGNVmBRKYuoLoRNlfmP37U+dUfcMjiZjz0levD3Dj6vR/HN3lZtHsOa26P/CxUFIdvfK+U9/w/Nl3JvWCurvEMt2VckzV8q0YOLpTCnumfCkaSRB/WTQ51/fqhdYHjZ5r0gIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712145595; c=relaxed/simple;
	bh=ZE610OT3UJTto1qL8N/i3fU6Phc1zRed3SqgmLvRFnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=klXVBwd84JBFEmMr0vgGhHFiziAxMXSmaoRtFt68TZO12uLquMaTLu9kO51e6+28i5ouKW/OV+Wy/+3g/nhWi9wu/2Nc6V3OZOGx7+0kQHCbHTs7vifJB9Tenh9HEX26J08C9W4tMlxUz/OZ4vjJpW1Rlq//Z13iqgqCSwQuCXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JAY+XuuX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433BISmx003400;
	Wed, 3 Apr 2024 11:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=SWKE56W6+s/zJsnCEIYz1kKJqYjsDE1d+Us6cb+wsqE=; b=JA
	Y+XuuXSNGgPgXLC4Nvd64H/yq+42JghJgK4t7/YNKoN+fR+M9KWJTOYBp0jPFrXw
	vnRmXnsxCQnbJClMseE17SpHOVu41VpHUV9M9GSGIkEPr4V4ZoJOVq3U61ZBALCL
	mz7UnmM1W1atoJFu3UiCVrSELC6OGrBVTK3++yTgqyGrOF+NhXAdyZH30Y4g3war
	Wwp9sCa6FZbBnexDuExe/QxrmV0dnMwfUyT08bPW8OUC2IseA+k4cB2Pqn8es+I+
	jqZ4u2I+5zMWFyjOSgp/mz1/ksEbkzUAasE9ukybwHYYe7icIaWJEgtRD337FyOn
	JMOM7yugePx8IkBjIXQg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8xnxs0y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 11:59:48 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433BxlaX031781
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 11:59:47 GMT
Received: from [10.218.10.146] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 04:59:42 -0700
Message-ID: <3e5f2b9a-0b15-5ce8-bcda-df2877f507df@quicinc.com>
Date: Wed, 3 Apr 2024 17:29:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 7/7] clk: qcom: Add GPUCC driver support for SM4450
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
        <linux-kernel@vger.kernel.org>, Taniya Das
	<quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>
References: <20240330182817.3272224-1-quic_ajipan@quicinc.com>
 <20240330182817.3272224-8-quic_ajipan@quicinc.com>
 <CAA8EJprtCbePun+gpwxg5e6o5NaBnunEJrmDrCV+O8BdHEeuYQ@mail.gmail.com>
 <9106b0eb-e15d-f2fa-d681-4017412c4a76@quicinc.com>
 <CAA8EJprP4Skq0GxyuzoF7Eu9pF+2Vm2wwbu9m6jBohdSKjLR9g@mail.gmail.com>
 <2e70f208-5a8e-3feb-d484-23b78c70d08f@quicinc.com>
 <CAA8EJprPeGMvN49HDEjc+cLSA+cwd=yDKOt2neFnuAmoO44gsw@mail.gmail.com>
From: Ajit Pandey <quic_ajipan@quicinc.com>
In-Reply-To: <CAA8EJprPeGMvN49HDEjc+cLSA+cwd=yDKOt2neFnuAmoO44gsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nJ1MXoYixSz5QzVJZE49lX1EH633sQxv
X-Proofpoint-GUID: nJ1MXoYixSz5QzVJZE49lX1EH633sQxv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_10,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030082



On 4/3/2024 4:22 PM, Dmitry Baryshkov wrote:
> On Wed, 3 Apr 2024 at 13:49, Ajit Pandey <quic_ajipan@quicinc.com> wrote:
>>
>>
>>
>> On 4/3/2024 12:53 AM, Dmitry Baryshkov wrote:
>>> On Tue, 2 Apr 2024 at 21:26, Ajit Pandey <quic_ajipan@quicinc.com> wrote:
>>>>
>>>>
>>>>
>>>> On 3/31/2024 7:09 AM, Dmitry Baryshkov wrote:
>>>>> On Sat, 30 Mar 2024 at 20:30, Ajit Pandey <quic_ajipan@quicinc.com> wrote:
>>>>>>
>>>>>> Add Graphics Clock Controller (GPUCC) support for SM4450 platform.
>>>>>>
>>>>>> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
>>>>>> ---
>>>>>>     drivers/clk/qcom/Kconfig        |   9 +
>>>>>>     drivers/clk/qcom/Makefile       |   1 +
>>>>>>     drivers/clk/qcom/gpucc-sm4450.c | 806 ++++++++++++++++++++++++++++++++
>>>>>>     3 files changed, 816 insertions(+)
>>>>>>     create mode 100644 drivers/clk/qcom/gpucc-sm4450.c
>>>>>>
>>>>>
>>>>> [skipped]
>>>>>
>>>>>> +static int gpu_cc_sm4450_probe(struct platform_device *pdev)
>>>>>> +{
>>>>>> +       struct regmap *regmap;
>>>>>> +
>>>>>> +       regmap = qcom_cc_map(pdev, &gpu_cc_sm4450_desc);
>>>>>> +       if (IS_ERR(regmap))
>>>>>> +               return PTR_ERR(regmap);
>>>>>> +
>>>>>> +       clk_lucid_evo_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
>>>>>> +       clk_lucid_evo_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
>>>>>> +
>>>>>> +       /* Keep some clocks always enabled */
>>>>>> +       qcom_branch_set_clk_en(regmap, 0x93a4); /* GPU_CC_CB_CLK */
>>>>>> +       qcom_branch_set_clk_en(regmap, 0x9004); /* GPU_CC_CXO_AON_CLK */
>>>>>> +       qcom_branch_set_clk_en(regmap, 0x900c); /* GPU_CC_DEMET_CLK */
>>>>>
>>>>> Why? At least other drivers model these three clocks properly.
>>>>>
>>>> These clocks are POR on in SM4450 and required to be kept always enabled
>>>> for GPU functionality hence keep them enabled from probe only.
>>>
>>> Please, check how this is handled on the other platforms, please.
>>> Hint: `git grep GPU_CC_DEMET_CLK`
>>>
>> yeah these clocks are modeled and handled via always enabled clk ops
>> (clk_branch2_aon_ops) in few other platforms like SM8450, SM8650 which
>> also do same functionality and keep them in always enabled POR state,
>> while we kept them enabled from GPUCC probe in SM8550.
>> Since we need such clock to be always enabled irrespective of consumer
>> votes I guess modeling with aon_ops isn't really required and we can
>> simply keep them enabled in probe similar to other always on clocks.
> 
> Why are they required to be kept on even if there is no consumer?
>
We've GPU as consumer for these clocks but it's recommended to keep them
always enabled for basic GPU functionality as per HW recommendation.
Hence instead of modeling with _aon_ops we can simply keep them enabled 
all time from probe to avoid any issues.
>>>>
>>>>>> +
>>>>>> +       return qcom_cc_really_probe(pdev, &gpu_cc_sm4450_desc, regmap);
>>>>>> +}
>>>>>> +
>>>>>> +static struct platform_driver gpu_cc_sm4450_driver = {
>>>>>> +       .probe = gpu_cc_sm4450_probe,
>>>>>> +       .driver = {
>>>>>> +               .name = "gpucc-sm4450",
>>>>>> +               .of_match_table = gpu_cc_sm4450_match_table,
>>>>>> +       },
>>>>>> +};
>>>>>> +
>>>>>> +module_platform_driver(gpu_cc_sm4450_driver);
>>>>>> +
>>>>>> +MODULE_DESCRIPTION("QTI GPUCC SM4450 Driver");
>>>>>> +MODULE_LICENSE("GPL");
>>>>>> --
>>>>>> 2.25.1
>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>
>>>> --
>>>> Thanks, and Regards
>>>> Ajit
>>>
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

