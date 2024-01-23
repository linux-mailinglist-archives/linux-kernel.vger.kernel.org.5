Return-Path: <linux-kernel+bounces-34999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A484B838A61
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50EA11F269E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D0459B6C;
	Tue, 23 Jan 2024 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RmYaGF1Y"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBBB59B4C;
	Tue, 23 Jan 2024 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706002407; cv=none; b=n/kS31Z2KOPvCjIylzTXtTDteetasoMmJzQY0zaLVPbiEHnPqJaBBp4MnElCfZfORwFPHN8J1lWKnQ7T7ZpYQFa+WmLtbnaRDwCRCUFT1FooJ22KYm7C5A7Ii+2zmNSRkHlfmxN6jcQjCsg/OU4coN0uj8denvhBPB5quxpmd7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706002407; c=relaxed/simple;
	bh=tUV9HeYaIlBPoxnsQQp32B4Sy5G/GzhwU1EEi/HJ3HE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LaFfbfVNZWU0vz/pQVJLuHzx+cORRBWaD1fi/YxdofwVylnfVaoeHOKG9zo5r5uen9XV1U7QOMXIrwZwe/YnkTFdFgASqgmvrP1ClgK+xCjpORJNmrLBA6y3vCNPlj+9LC8aj71pAHLPVtAfuYC7+ygK3tLZSl9nFRSby1MBFO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RmYaGF1Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N7MUfQ010744;
	Tue, 23 Jan 2024 09:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=LTfonBMvnMBR44qAE8QB5c/aqCnkCTT8Mrrh/XXED9o=; b=Rm
	YaGF1YQ496OaN+QiCMoPOtu2QkqktvVXFRaYPFGIHjmgTsuTTkbC0QJ14IZ9N++Z
	/nnpDWeQ0GKouFANAA9T+xCZi404flJ1/mujpUxu8KJex5VgB5AmJQ1G8DoXshxa
	cuFOPSl9VPbDPh/yfwjWOyacF37o+5v4JKeMrJMfm6MAvB80WbkMxdC2fmfnxcUC
	puEcFKlsqaIcmOdnMB58gL401GVsqJYWyOqXhyBD2bAs9EwW9nxlvvvLkEDdv8CE
	4cHsm3wAYdOcnU0n7Dbj05ElXAeqoreKXthQFmpoLa4q62so+HCX87QF63PYHFUD
	3xw1AsBsMs2Q4tIJvz8w==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vt8140cu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 09:33:17 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40N9XGOZ014957
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 09:33:16 GMT
Received: from [10.216.0.128] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 01:33:11 -0800
Message-ID: <e993b237-46fb-3a0b-dc91-41e27ea0ab98@quicinc.com>
Date: Tue, 23 Jan 2024 15:03:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v6 01/12] clk: qcom: branch: Add a helper for setting the
 enable bit
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Marijn Suijten <marijn.suijten@somainline.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Johan Hovold
	<johan+linaro@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v6-0-46d136a4e8d0@linaro.org>
 <20230717-topic-branch_aon_cleanup-v6-1-46d136a4e8d0@linaro.org>
Content-Language: en-US
From: Imran Shaik <quic_imrashai@quicinc.com>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v6-1-46d136a4e8d0@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -9zgUxEza7hK566H9pMD3G5V06JJNCFs
X-Proofpoint-ORIG-GUID: -9zgUxEza7hK566H9pMD3G5V06JJNCFs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_04,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 clxscore=1011 impostorscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230069



On 1/13/2024 8:20 PM, Konrad Dybcio wrote:
> We hardcode some clocks to be always-on, as they're essential to the
> functioning of the SoC / some peripherals. Add a helper to do so
> to make the writes less magic.
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/clk/qcom/clk-branch.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
> index 8ffed603c050..0514bc43100b 100644
> --- a/drivers/clk/qcom/clk-branch.h
> +++ b/drivers/clk/qcom/clk-branch.h
> @@ -64,6 +64,7 @@ struct clk_mem_branch {
>   #define CBCR_FORCE_MEM_PERIPH_OFF	BIT(12)
>   #define CBCR_WAKEUP			GENMASK(11, 8)
>   #define CBCR_SLEEP			GENMASK(7, 4)
> +#define CBCR_CLOCK_ENABLE		BIT(0)
>   
>   static inline void qcom_branch_set_force_mem_core(struct regmap *regmap,
>   						  struct clk_branch clk, bool on)
> @@ -98,6 +99,12 @@ static inline void qcom_branch_set_sleep(struct regmap *regmap, struct clk_branc
>   			   FIELD_PREP(CBCR_SLEEP, val));
>   }
>   
> +static inline void qcom_branch_set_clk_en(struct regmap *regmap, u32 cbcr)
> +{
> +	regmap_update_bits(regmap, cbcr, CBCR_CLOCK_ENABLE,
> +			   CBCR_CLOCK_ENABLE);
> +}
> +

Could you please help me understand how this helper function is useful?
Seems like this is just for reducing parameters compared to 
regmap_update_bits(). But anyhow the same is being done in the existing
clock controller drivers with a comment which explains the functionality.

Thanks & Regards,
Imran

>   extern const struct clk_ops clk_branch_ops;
>   extern const struct clk_ops clk_branch2_ops;
>   extern const struct clk_ops clk_branch_simple_ops;
> 

