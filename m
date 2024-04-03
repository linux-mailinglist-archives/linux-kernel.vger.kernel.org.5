Return-Path: <linux-kernel+bounces-129608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE141896D25
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6AA1F31CF8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AA7141987;
	Wed,  3 Apr 2024 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cwctwoeU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6100871B51;
	Wed,  3 Apr 2024 10:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141377; cv=none; b=KxdogYDCrsVe6RqI4fec2ZDXOTRtSArlzuA3cRXMYvSLh4RXGF+bYY2kIPryXZSprUgqB6k3vGui64VwCi95dqthISt2OEOKwh6N436V9iGWHENIDfHT/DHBIZv8CIcCEkRUi1OOUDEl+Vch7mqqoKWQNmmMqqb5GbiUNWZi5xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141377; c=relaxed/simple;
	bh=SCIy0EG+uFbNOzL3613AqHOt6u3B/Y2aby5pgVdljDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u3FpoOsHOjPKqT7MVqx/VEnjH/G8w7h1kRePfQlADF5K47ZNn2V41E2DJ8tyHPyBdIyusP07Cun6mH3Ed/rFcVNdztTTB70RqLIO+z7FACeKYyIB96QPN7BE37FzAykkqtw4ttFBSL93nOIsgZR3/RnRfC7300v2P9SHJkAtHIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cwctwoeU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433AkTpg024670;
	Wed, 3 Apr 2024 10:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=c67oN18iBtPSs/+q3UpsNdiS1NtB1a70D0ttgRP6p0A=; b=cw
	ctwoeUgmumLbOWF69pxlzYJc6kxVz+JJEGD5I873QJEC6THFYO6MaQJqXizt0X38
	VF4SMpUI/7laIotbkg6bYCnaTxwtAw0RiTSPN37b15HCnOkgpoIdKtX+Syyr1y8L
	uEjNg6kRwUGOMcpCHqTdyR4aexrf3GPAFN2GYmyFiauJWSvCvbe+qje3qf7czVNo
	GAQe+Ge8Qg9QGZBVjt22XKfLvaxl4UymcO9r1jj+eR6iY0Mq8ekKGuA6H+snraPS
	i26qU7sCZ1ra1GvPN3nnKIo8oGQI4ZvK64lapc7/7VpDb3rKS5gOZAlP9cCdvADh
	junHiTAa64+9HPFivTJQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9377rbna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 10:49:32 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433AnNUd006151
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 10:49:23 GMT
Received: from [10.218.10.146] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 03:49:18 -0700
Message-ID: <2e70f208-5a8e-3feb-d484-23b78c70d08f@quicinc.com>
Date: Wed, 3 Apr 2024 16:19:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 7/7] clk: qcom: Add GPUCC driver support for SM4450
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
Content-Language: en-US
From: Ajit Pandey <quic_ajipan@quicinc.com>
In-Reply-To: <CAA8EJprP4Skq0GxyuzoF7Eu9pF+2Vm2wwbu9m6jBohdSKjLR9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JKcuvSykRRqScDu95eStN6zVVCh2_z2h
X-Proofpoint-ORIG-GUID: JKcuvSykRRqScDu95eStN6zVVCh2_z2h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_10,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030075



On 4/3/2024 12:53 AM, Dmitry Baryshkov wrote:
> On Tue, 2 Apr 2024 at 21:26, Ajit Pandey <quic_ajipan@quicinc.com> wrote:
>>
>>
>>
>> On 3/31/2024 7:09 AM, Dmitry Baryshkov wrote:
>>> On Sat, 30 Mar 2024 at 20:30, Ajit Pandey <quic_ajipan@quicinc.com> wrote:
>>>>
>>>> Add Graphics Clock Controller (GPUCC) support for SM4450 platform.
>>>>
>>>> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
>>>> ---
>>>>    drivers/clk/qcom/Kconfig        |   9 +
>>>>    drivers/clk/qcom/Makefile       |   1 +
>>>>    drivers/clk/qcom/gpucc-sm4450.c | 806 ++++++++++++++++++++++++++++++++
>>>>    3 files changed, 816 insertions(+)
>>>>    create mode 100644 drivers/clk/qcom/gpucc-sm4450.c
>>>>
>>>
>>> [skipped]
>>>
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
>>> Why? At least other drivers model these three clocks properly.
>>>
>> These clocks are POR on in SM4450 and required to be kept always enabled
>> for GPU functionality hence keep them enabled from probe only.
> 
> Please, check how this is handled on the other platforms, please.
> Hint: `git grep GPU_CC_DEMET_CLK`
> 
yeah these clocks are modeled and handled via always enabled clk ops 
(clk_branch2_aon_ops) in few other platforms like SM8450, SM8650 which 
also do same functionality and keep them in always enabled POR state, 
while we kept them enabled from GPUCC probe in SM8550.
Since we need such clock to be always enabled irrespective of consumer 
votes I guess modeling with aon_ops isn't really required and we can 
simply keep them enabled in probe similar to other always on clocks.
>>
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

