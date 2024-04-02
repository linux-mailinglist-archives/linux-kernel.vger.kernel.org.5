Return-Path: <linux-kernel+bounces-128501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA18895BB9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97442B224FF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD8815ADBF;
	Tue,  2 Apr 2024 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p4Kj/IEu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED2B15AD89;
	Tue,  2 Apr 2024 18:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712082373; cv=none; b=gNT+wmpQzjd2qnpkuzqsQBDdxD/GZEWDW2X7XO9YbNJUHjFT24zTMpIMLG8RxufPuIOv9PUbZmSfILy1ScLoLTOfAyI0/6UV7qwtb5nzdQ/jtsEPZ32vSutOvvN8nbKYLi8XeEYILuNaSt+ruAgTFymyNT9T0APDK8FtWe4+R7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712082373; c=relaxed/simple;
	bh=IKOBRv9yUAUu4NNxTf13WbE/G+qhbLfdiZPgQkPGTu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qzxUZajAwGucFxgvPpD/Y5VjbT2VyYCM+YDXzTIV/CwYNq+bE3ydUt9bUiiW1uy+nnaJ5zgdSJzti1BZvAJmahQWBqwUl7S8ci1bgH+Omh+/P5jiq3t/z68G/oC9/ke2e+f4cps305DdXdtiqaUN8Y37CQJP70dyRoFn4kKW1PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p4Kj/IEu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432HEFtP032260;
	Tue, 2 Apr 2024 18:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nHuqqc39J6qv7N+Uls09WMbBsERelSSBoPqHT/2oBqA=; b=p4
	Kj/IEuFlxXcNRxENGjCgfgdq4O9Xi8cv3A1nBscegNILRRgvlsP/fRkJIWg3TLvJ
	hn/WNn9s9Qbeqi6dV5jjzMmsYKEI+3AmPhzc7iqW7ebS6YHT9QfhlWI3rOL+7WLw
	fMl6Y+k0MZP2djQ4Cy6O0n4dtKn9jJ+Q7lYOe43qY9fYetcf2YXHo9C/9qAoTV+W
	rUREZvj39tWLrnvAhwBZ8hN/HxPio2GXMnMRIr4oyY2cvEw6xavYX2JGZF0Qy2in
	bt0rwDmh+kmeKCM4aZU5Ox9SguwgxeZhf7qfnUpygOubjDoxgf4SQAXQpAoMKFrU
	PfYftQEBQyLe4w9s09XA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8dnbhx2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 18:26:06 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432IQ5pb006486
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 18:26:05 GMT
Received: from [10.216.46.192] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 2 Apr 2024
 11:25:55 -0700
Message-ID: <9106b0eb-e15d-f2fa-d681-4017412c4a76@quicinc.com>
Date: Tue, 2 Apr 2024 23:55:49 +0530
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
From: Ajit Pandey <quic_ajipan@quicinc.com>
In-Reply-To: <CAA8EJprtCbePun+gpwxg5e6o5NaBnunEJrmDrCV+O8BdHEeuYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8wR8PRzQ65hBYeo3nBDfGJpKJP4JgFUt
X-Proofpoint-ORIG-GUID: 8wR8PRzQ65hBYeo3nBDfGJpKJP4JgFUt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_12,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404020137



On 3/31/2024 7:09 AM, Dmitry Baryshkov wrote:
> On Sat, 30 Mar 2024 at 20:30, Ajit Pandey <quic_ajipan@quicinc.com> wrote:
>>
>> Add Graphics Clock Controller (GPUCC) support for SM4450 platform.
>>
>> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
>> ---
>>   drivers/clk/qcom/Kconfig        |   9 +
>>   drivers/clk/qcom/Makefile       |   1 +
>>   drivers/clk/qcom/gpucc-sm4450.c | 806 ++++++++++++++++++++++++++++++++
>>   3 files changed, 816 insertions(+)
>>   create mode 100644 drivers/clk/qcom/gpucc-sm4450.c
>>
> 
> [skipped]
> 
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
> Why? At least other drivers model these three clocks properly.
>
These clocks are POR on in SM4450 and required to be kept always enabled 
for GPU functionality hence keep them enabled from probe only.

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

