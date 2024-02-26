Return-Path: <linux-kernel+bounces-81121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C28486707A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1DE11F26639
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C306C50A83;
	Mon, 26 Feb 2024 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="btr/224+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB5250A65;
	Mon, 26 Feb 2024 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941408; cv=none; b=Srk4WFpC5EEVQsOD4OYxbv22iruorkwHazEvev/E4Io5qc+q0BgUhXUaJ/GuF+C3IzkpTEHNhUjbxX1z1hi6fkY6FgzqhBjfMIBKEB7KV0Mco5DGpNKUJzIV0T8Ot3ejRO4rMAq2lrWWIlitQwlBAemdoD5DpSIrp5dLLpGsehc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941408; c=relaxed/simple;
	bh=x6ej4mbf2hIi7MyOcl44WZems0lFvtXLgKuPqoiHvHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=W6z1rs/v0INvTfs8E8IKQWeZ1ADf4t87OLmvB/gWpoYzDwC73ILeRzPRDm4KBzYVsnlrwgDcKGC3KPDTr0SDinqLnuu0urSU9LD1Fyhw+VCQ9c6EnWrEc7KH+uDUWMJ5r0artFyd/kL+MfTAXOcpzhrLWFRUI/oSHnu2m8ZgTRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=btr/224+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41Q8ICQx020879;
	Mon, 26 Feb 2024 09:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bFgyNpvTKVRR+U8TfuEQ8tv0v09yH1UNBUFzTyydNIE=; b=bt
	r/224+EJ5abP8l9W7alirfHAxcoLbMQVD91KnTTgQb4KVS2vU6BrvKOo3JPSLcCA
	s3fSEHDO4R7qp9Ld3QxzpFmTfpkYwQEPQbbIsJezS8MkRIpX9u4g14cDzPX9JZCj
	EgqDt1VhntN7wsZgiYV6RyjmQE29jHVDOOrlE0s/HW6qSR33DUWoj5R2XSWuau6L
	aPaug6y0BXkvQsUh7zTSWbRXKrfAGdE4xHuQmTBgl30ang7xfPnHUv4m/p6y1GQg
	FHgSAGSN2pBQglpIqeCY9RL650v3X/VwuVTtL63bjituBt+1E+XNuhRn/mRftc+F
	nL6R9gpXBVXdDtzkvfeQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxp8hqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 09:56:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41Q9ufB5022364
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 09:56:41 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 01:56:37 -0800
Message-ID: <8144cb83-077d-46ec-ae10-13d99fba34ae@quicinc.com>
Date: Mon, 26 Feb 2024 15:26:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] clk: qcom: gcc-ipq5018: fix 'halt_reg' offset of
 'gcc_pcie1_pipe_clk'
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
 <20240225-gcc-ipq5018-register-fixes-v1-2-3c191404d9f0@gmail.com>
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <20240225-gcc-ipq5018-register-fixes-v1-2-3c191404d9f0@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: F-0P-0eFBI0TIKNWrJbtHzkldxBZFZTB
X-Proofpoint-GUID: F-0P-0eFBI0TIKNWrJbtHzkldxBZFZTB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260074



On 2/25/2024 11:02 PM, Gabor Juhos wrote:
> The following table shows the values of the 'halt_reg' and the
> 'enable_reg' fields from the pcie clocks defined in the current
> driver:
> 
>    clock                        halt_reg    enable_reg
> 
>    gcc_pcie0_ahb_clk            0x75010     0x75010
>    gcc_pcie0_aux_clk            0x75014     0x75014
>    gcc_pcie0_axi_m_clk          0x75008     0x75008
>    gcc_pcie0_axi_s_bridge_clk   0x75048     0x75048
>    gcc_pcie0_axi_s_clk          0x7500c     0x7500c
>    gcc_pcie0_pipe_clk           0x75018     0x75018
> 
>    gcc_pcie1_ahb_clk            0x76010     0x76010
>    gcc_pcie1_aux_clk            0x76014     0x76014
>    gcc_pcie1_axi_m_clk          0x76008     0x76008
>    gcc_pcie1_axi_s_bridge_clk   0x76048     0x76048
>    gcc_pcie1_axi_s_clk          0x7600c     0x7600c
>    gcc_pcie1_pipe_clk                 8*    0x76018
> 
> Based on the table, it is quite likely that the pcie0 and the pci1
> clocks are using the same register layout, however it seems that
> the value of the 'halt_reg' field in the 'gcc_pcie1_pipe_clk' clock
> is wrong.
> 
> In the downstream driver [1], the same '0x76018' value is used for
> both the 'halt_reg' and for the 'enable_reg' fields of the
> 'gcc_pcie1_pipe_clk' clock.
> 
> Update the current driver to use the same value used downstream as
> probably that is the correct value.
> 
> 1. https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r4/drivers/clk/qcom/gcc-ipq5018.c?ref_type=heads#L2316


Reviewed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>


> 
> Fixes: e3fdbef1bab8 ("clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>   drivers/clk/qcom/gcc-ipq5018.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq5018.c b/drivers/clk/qcom/gcc-ipq5018.c
> index cef9a1e7c9fdb..5e81cfa77293a 100644
> --- a/drivers/clk/qcom/gcc-ipq5018.c
> +++ b/drivers/clk/qcom/gcc-ipq5018.c
> @@ -2180,7 +2180,7 @@ static struct clk_branch gcc_pcie1_axi_s_clk = {
>   };
>   
>   static struct clk_branch gcc_pcie1_pipe_clk = {
> -	.halt_reg = 8,
> +	.halt_reg = 0x76018,
>   	.halt_check = BRANCH_HALT_DELAY,
>   	.halt_bit = 31,
>   	.clkr = {
> 

