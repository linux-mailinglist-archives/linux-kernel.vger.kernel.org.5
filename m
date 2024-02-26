Return-Path: <linux-kernel+bounces-81122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CDD867082
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B57289863
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93A552F7A;
	Mon, 26 Feb 2024 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JHIIIzGD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CCC52F70;
	Mon, 26 Feb 2024 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941564; cv=none; b=njfjvBdfP1ftpWqYPwXWZgHw0UQVcw4PHoJBOVurw68rqco1w/VPyMVaLo/QTRnoIuFnIGmmIyK2J9YXpPRHE58Gj079HWiP9clL3NDjIjWVEwaSGKMgusnpFHPBhknRksDBWXel2nkjYAQYmY94QFFMboGj2hjl7xjPxWQZYPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941564; c=relaxed/simple;
	bh=PqbQ7HhDnfUCKp8V4bv/aDNGTxhql4LdRBtRHErU/Sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u683YRAV0EgKjq4NK95scGNMkYvdmbGfYKZsU4rjNe6KLMXSmrCLq566stBs04Ib7j1TYgDMpymeaAtWtqthIRrZLyDGiLgE4aaDoO9t1DBNpb7BBlPEORLXk5V9zF3krlhbqQd2h1942X/jXe4YHopEIoPYE/kjAApNzoHFZBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JHIIIzGD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41Q9jkwX006747;
	Mon, 26 Feb 2024 09:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=4UEp5bOsLRvDxev+6NWFj3DIo3zIv0AWoJ4gIkyLEx4=; b=JH
	IIIzGDgaCQErqpguwomzCa+1bFkkydUItX91Rt3f8xnzT5XGtsX8G73eDZ8OlCBR
	gjxyqrQ7ohxhNQlsAIylasfiiizhdGR/7W+vpuNAaGCHFWl//wSf/myoSNbHfWRK
	tBx4HmNj8HhUJzuvrCjt6Rb1Pn3u9HgNyvNGDaVY/0wTEUVJYeFmh+XeAB+6a9hj
	HvePj37HDjFb+Xkzx6kZ9ZiI7CGlLp8zvc4/cKFrsgPIZ02JnHgPIr2YMHOx6qZl
	I6VrrqqYwh2+7JurYiL2h6kMbvToTs5SpRfaVao0Ys823RQdsT+FGqgiCuuIrsqb
	ZbczYMgi8jAr9MLaQ4mg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxq0hp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 09:59:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41Q9xG1e021960
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 09:59:16 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 01:59:12 -0800
Message-ID: <3c1b3102-1817-4211-8d9a-aa56d05d7e6a@quicinc.com>
Date: Mon, 26 Feb 2024 15:29:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] clk: qcom: gcc-ipq5018: fix register offset for
 GCC_UBI0_AXI_ARES reset
Content-Language: en-US
To: Gabor Juhos <j4g8y7@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Gokul Sriram
 Palanisamy" <quic_gokulsri@quicinc.com>,
        Varadarajan Narayanan
	<quic_varada@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240225-gcc-ipq5018-register-fixes-v1-0-3c191404d9f0@gmail.com>
 <20240225-gcc-ipq5018-register-fixes-v1-3-3c191404d9f0@gmail.com>
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <20240225-gcc-ipq5018-register-fixes-v1-3-3c191404d9f0@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5in7-8T2oh3cMbMIYNrRhgewU0-869Ov
X-Proofpoint-GUID: 5in7-8T2oh3cMbMIYNrRhgewU0-869Ov
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260075



On 2/25/2024 11:02 PM, Gabor Juhos wrote:
> The current register offset used for the GCC_UBI0_AXI_ARES reset
> seems wrong. Or at least, the downstream driver uses [1] the same
> offset which is used for other the GCC_UBI0_*_ARES resets.
> 
> Change the code to use the same offset used in the downstream
> driver and also specify the reset bit explicitly to use the
> same format as the followup entries.
> 
> 1. https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r4/drivers/clk/qcom/gcc-ipq5018.c?ref_type=heads#L3773


Reviewed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>


> 
> Fixes: e3fdbef1bab8 ("clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>   drivers/clk/qcom/gcc-ipq5018.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq5018.c b/drivers/clk/qcom/gcc-ipq5018.c
> index 5e81cfa77293a..e2bd54826a4ce 100644
> --- a/drivers/clk/qcom/gcc-ipq5018.c
> +++ b/drivers/clk/qcom/gcc-ipq5018.c
> @@ -3632,7 +3632,7 @@ static const struct qcom_reset_map gcc_ipq5018_resets[] = {
>   	[GCC_SYSTEM_NOC_BCR] = { 0x26000, 0 },
>   	[GCC_TCSR_BCR] = { 0x28000, 0 },
>   	[GCC_TLMM_BCR] = { 0x34000, 0 },
> -	[GCC_UBI0_AXI_ARES] = { 0x680},
> +	[GCC_UBI0_AXI_ARES] = { 0x68010, 0 },
>   	[GCC_UBI0_AHB_ARES] = { 0x68010, 1 },
>   	[GCC_UBI0_NC_AXI_ARES] = { 0x68010, 2 },
>   	[GCC_UBI0_DBG_ARES] = { 0x68010, 3 },
> 

