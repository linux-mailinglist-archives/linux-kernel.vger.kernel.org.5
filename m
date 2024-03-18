Return-Path: <linux-kernel+bounces-105711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B123D87E34A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C58D1F21BA6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 05:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D1C22087;
	Mon, 18 Mar 2024 05:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LxgE5pX+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20161E89E;
	Mon, 18 Mar 2024 05:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710740443; cv=none; b=KGy1O2rMeREqrUHx/R2dUW3HpUYmf0Rgd7h6vGOKn8DykYXlIEMIVAoe5AMHwNzsv66X1oP8QuLoLLT47GFnuuai+II6a6ECWKuPu7X2x6OBiiHF8r5xw9lxPz0X9egRUvoYxwPclxnWL7sAkaOdk6l5wnxx3/fF3Yhb6qeB76s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710740443; c=relaxed/simple;
	bh=h/Ln9yPHtqlby+Fp6MUf3PS6y0nv61hhQvGCsQv9BhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kOBvvSXQMJMKTJq3z8aoDoTEO7RCA7pv5lwbiwIMGZKh3MPL81RgV43I7VWjSny6yEEjv2ythUelV3pSafjeltMmnAIzzMy3vpd8HbnhGxbp7JW1dLj/wuNNc/TNfEk2tE6GNvEy5Gj3qeL6j/hb63c1BFIjG8iwy1oQfmikR28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LxgE5pX+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42I5dWbk022455;
	Mon, 18 Mar 2024 05:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=SPiZIQTn+g32WTjYdojmq9ZTZLv8aPvVwv57pq3k6Xg=; b=Lx
	gE5pX+0vB4K643dXvGWDy4A6xruBaRzDJN5kQ9ie1OG5+R+a0PqpJSciYMhvUpSU
	plvjikMgISvjw50epftMGm2OFMQdKKr2fPkvAC3fVX4godl8XE3wYq88oLzD4iJF
	1H/NlqDSiZVyd0Jo6YvPNB6fpFeWDtBMxKM2YPNk6bYj9qggXjEv9zwEe5RsoHNT
	fhefp4F48ZttLXAR95R5MNOuvm69le0brl0WAg9iQVBpKg5/0az4JPyFT4QXaLcV
	2pv9+YLAYAoC/dzLbZnBhYChCDI7XO5YFfSDx+izsZlNUMegN/0f1CiK6Ze0R7BI
	5Zm0HXrvYJKMhpESYqDw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wwxtds4tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 05:40:37 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42I5ea7q019434
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 05:40:36 GMT
Received: from [10.216.55.168] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 17 Mar
 2024 22:40:30 -0700
Message-ID: <7d0e81fd-8cc2-46f2-bc12-759a0d48e3ae@quicinc.com>
Date: Mon, 18 Mar 2024 11:09:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: qcom: apss-ipq-pll: use stromer ops for IPQ5018
 to fix boot failure
To: Gabor Juhos <j4g8y7@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Sricharan
 Ramabadhran" <quic_srichara@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Gokul Sriram Palanisamy
	<quic_gokulsri@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20240315-apss-ipq-pll-ipq5018-hang-v2-1-6fe30ada2009@gmail.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <20240315-apss-ipq-pll-ipq5018-hang-v2-1-6fe30ada2009@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VOi_2MVMftvGOeRjEnYMyJVyBiACw76m
X-Proofpoint-ORIG-GUID: VOi_2MVMftvGOeRjEnYMyJVyBiACw76m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403180041



On 3/15/2024 9:46 PM, Gabor Juhos wrote:
> Booting v6.8 results in a hang on various IPQ5018 based boards.
> Investigating the problem showed that the hang happens when the
> clk_alpha_pll_stromer_plus_set_rate() function tries to write
> into the PLL_MODE register of the APSS PLL.
> 
> Checking the downstream code revealed that it uses [1] stromer
> specific operations for IPQ5018, whereas in the current code
> the stromer plus specific operations are used.
> 
> The ops in the 'ipq_pll_stromer_plus' clock definition can't be
> changed since that is needed for IPQ5332, so add a new alpha pll
> clock declaration which uses the correct stromer ops and use this
> new clock for IPQ5018 to avoid the boot failure.
> 
> Also, change pll_type in 'ipq5018_pll_data' to
> CLK_ALPHA_PLL_TYPE_STROMER to better reflect that it is a Stromer
> PLL and change the apss_ipq_pll_probe() function accordingly.
> 
> 1. https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4/drivers/clk/qcom/apss-ipq5018.c#L67
> 
> Cc: stable@vger.kernel.org
> Fixes: 50492f929486 ("clk: qcom: apss-ipq-pll: add support for IPQ5018")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
> Changes in v2:
>    - extend commit description due to the changes
>    - add a comment about why CLK_ALPHA_PLL_TYPE_STROMER_PLUS register offsets
>      are used
>    - constify hw clock init data (Stephen)
>    - change pll_type in ipq5018_pll_data to CLK_ALPHA_PLL_TYPE_STROMER (Konrad)
>    - Link to v1: https://lore.kernel.org/r/20240311-apss-ipq-pll-ipq5018-hang-v1-1-8ed42b7a904d@gmail.com


I don't see a reason why my tags are dropped, nevertheless

Tested-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Reviewed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>


> ---
> Based on v6.8.
> ---
>   drivers/clk/qcom/apss-ipq-pll.c | 30 +++++++++++++++++++++++++++---
>   1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
> index 678b805f13d45..dfffec2f06ae7 100644
> --- a/drivers/clk/qcom/apss-ipq-pll.c
> +++ b/drivers/clk/qcom/apss-ipq-pll.c
> @@ -55,6 +55,29 @@ static struct clk_alpha_pll ipq_pll_huayra = {
>   	},
>   };
>   
> +static struct clk_alpha_pll ipq_pll_stromer = {
> +	.offset = 0x0,
> +	/*
> +	 * Reuse CLK_ALPHA_PLL_TYPE_STROMER_PLUS register offsets.
> +	 * Although this is a bit confusing, but the offset values
> +	 * are correct nevertheless.
> +	 */
> +	.regs = ipq_pll_offsets[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],
> +	.flags = SUPPORTS_DYNAMIC_UPDATE,
> +	.clkr = {
> +		.enable_reg = 0x0,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "a53pll",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.fw_name = "xo",
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_stromer_ops,
> +		},
> +	},
> +};
> +
>   static struct clk_alpha_pll ipq_pll_stromer_plus = {
>   	.offset = 0x0,
>   	.regs = ipq_pll_offsets[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],
> @@ -144,8 +167,8 @@ struct apss_pll_data {
>   };
>   
>   static const struct apss_pll_data ipq5018_pll_data = {
> -	.pll_type = CLK_ALPHA_PLL_TYPE_STROMER_PLUS,
> -	.pll = &ipq_pll_stromer_plus,
> +	.pll_type = CLK_ALPHA_PLL_TYPE_STROMER,
> +	.pll = &ipq_pll_stromer,
>   	.pll_config = &ipq5018_pll_config,
>   };
>   
> @@ -203,7 +226,8 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
>   
>   	if (data->pll_type == CLK_ALPHA_PLL_TYPE_HUAYRA)
>   		clk_alpha_pll_configure(data->pll, regmap, data->pll_config);
> -	else if (data->pll_type == CLK_ALPHA_PLL_TYPE_STROMER_PLUS)
> +	else if (data->pll_type == CLK_ALPHA_PLL_TYPE_STROMER ||
> +		 data->pll_type == CLK_ALPHA_PLL_TYPE_STROMER_PLUS)
>   		clk_stromer_pll_configure(data->pll, regmap, data->pll_config);
>   
>   	ret = devm_clk_register_regmap(dev, &data->pll->clkr);
> 
> ---
> base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
> change-id: 20240311-apss-ipq-pll-ipq5018-hang-74d9a8f47136
> 
> Best regards,

