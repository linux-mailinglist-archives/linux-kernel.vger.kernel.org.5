Return-Path: <linux-kernel+bounces-81113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C26E86705F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83FE81C25965
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A5C1CD12;
	Mon, 26 Feb 2024 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lWsbMMCG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD0D1CAB7;
	Mon, 26 Feb 2024 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941235; cv=none; b=hDkCLhAxrw7eqAjE7VRcE3Dz49A1XCmSPd8YHmPdrhsfRcWxauPxdHl9PThTczroT6tO0kIotNOySJsG2eHDXfNwP74iIH27gyZHI28rcumzc0pFs5lr9+wv5+IcjwVmRS63uR/MTmdtBKGWMtrGbnmWTzgGLbubaebyemtzpmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941235; c=relaxed/simple;
	bh=otKhKCgG3K4RgORO6PEh3Fak2iVDCnpgG7MUsCAEoeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bRWcI6JhAFA6rynos64Hb+ZYNzGPyDCN5w+MX7nD826Uc8VZOx5bkpSt4+ntGEgrDNZ5d02D37mfouPJPRkrmndMom0dwSA9ilaLp8UDNNiOE/krcxoEhQlyXunpRgV0QBgdYI3vrgaGzBfniYvooxYPDv/L0kHkWP+XYEcU5wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lWsbMMCG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41Q5drZ9014438;
	Mon, 26 Feb 2024 09:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=8zPjoj4X+fBsy3eU5CMnR7k97bJ2drMICWyL5Kr1yM0=; b=lW
	sbMMCGPG0ADeQ8fIzaxEq5YlNYjFgRYr/dqfehkumyKyNS7Ef6sN8NUnsUahHDcD
	5nyo/HB8f9S8WPT7ADTmyk8g2+xYxRbsmqhzxKnFCjdnuiWXgc/ZgVphLBFquyzj
	miC3gSaIvbPjRkFWmII/cO2leI9Nf3YL9TEsXCyE6p1icQnsreasVzKHI8a4k9JK
	NX+27lWc6EJ0AvW/9kt2IlmVE2+saMolBOgLYuIWlbIqsbNrKGm00iscVrmBygnT
	rnpfyNg1NaFAhicamScqpDtJwFi0DKvDhZ7/BdwbZ9ufFc5SM0GgYoR9TTnJeOCE
	kIv3tJfs2geTFmQk6vhw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxn0hh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 09:53:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41Q9rmxh005771
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 09:53:48 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 01:53:44 -0800
Message-ID: <1ba0fe63-1892-4042-9e5f-b1cd18e760b8@quicinc.com>
Date: Mon, 26 Feb 2024 15:23:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] clk: qcom: gcc-ipq5018: fix 'enable_reg' offset of
 'gcc_gmac0_sys_clk'
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
 <20240225-gcc-ipq5018-register-fixes-v1-1-3c191404d9f0@gmail.com>
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <20240225-gcc-ipq5018-register-fixes-v1-1-3c191404d9f0@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vklQhSSngPc2hpNEt0Pgt9Z4CyrPCkG_
X-Proofpoint-GUID: vklQhSSngPc2hpNEt0Pgt9Z4CyrPCkG_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402260074



On 2/25/2024 11:02 PM, Gabor Juhos wrote:
> The value of the 'enable_reg' field in the 'gcc_gmac0_sys_clk'
> clock definition seems wrong as it is greater than the
> 'max_register' value defined in the regmap configuration.
> Additionally, all other gmac specific branch clock definitions
> within the driver uses the same value both for the 'enable_reg'
> and for the 'halt_reg' fields.
> 
> Due to the lack of documentation the correct value is not known.
> Looking into the downstream driver does not help either, as that
> uses the same (presumably wrong) value [1].
> 
> Nevertheless, change the 'enable_reg' field of 'gcc_gmac0_sys_clk'
> to use the value from the 'halt_reg' field so it follows the pattern
> used in other gmac clock definitions. The change is based on the
> assumption that the register layout of this clock is the same
> as the other gmac clocks.
> 
> 1. https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r4/drivers/clk/qcom/gcc-ipq5018.c?ref_type=heads#L1889


Reviewed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>


> 
> Fixes: e3fdbef1bab8 ("clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>   drivers/clk/qcom/gcc-ipq5018.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq5018.c b/drivers/clk/qcom/gcc-ipq5018.c
> index 4aba47e8700d2..cef9a1e7c9fdb 100644
> --- a/drivers/clk/qcom/gcc-ipq5018.c
> +++ b/drivers/clk/qcom/gcc-ipq5018.c
> @@ -1754,7 +1754,7 @@ static struct clk_branch gcc_gmac0_sys_clk = {
>   	.halt_check = BRANCH_HALT_DELAY,
>   	.halt_bit = 31,
>   	.clkr = {
> -		.enable_reg = 0x683190,
> +		.enable_reg = 0x68190,
>   		.enable_mask = BIT(0),
>   		.hw.init = &(struct clk_init_data) {
>   			.name = "gcc_gmac0_sys_clk",
> 

