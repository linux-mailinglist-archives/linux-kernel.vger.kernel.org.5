Return-Path: <linux-kernel+bounces-96648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC8B875F73
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC702822E1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAC4524A8;
	Fri,  8 Mar 2024 08:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XmNiLN0f"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9AD2C85C;
	Fri,  8 Mar 2024 08:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709886458; cv=none; b=nwbAA3V6FAYn9r9b1GCdTgfe4aYS6ucUaYX2iSQYx+wlcN9ra8YrsFxvn9po2WlopBs3VFky+mdUV4CZ7RWWqvP+LznXS6tTR1dpVURge/qbdHQTiYaii1x8qVtnc4K3k2lOxMmak2foGzrrNV2FnSL/KJ7Y+mlhhRswPcS83YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709886458; c=relaxed/simple;
	bh=it+8N8x9nkiwam2Z6P8taeub+gmE2B4+vtKE+rvyjVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jNc7D9YvokIR3X+tNsw4iOo4FK850LjisOrZsNB957MjKvLKt+o/dz595R3dOaIu9WHWRpjb3tufCVdBXu6oQuALcQ3jG177twtaFE0okoQId2N8tKBH9m9xSOyf/PgFeHWZ0xA6ve/TEqgcEfWba352vYxOq+SfKLSAg4UQ8sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XmNiLN0f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4281ir34024318;
	Fri, 8 Mar 2024 08:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TTXHftTjjsBsUWU4UrbQ62ok56w6+TCUiqaFxrq8KxM=; b=Xm
	NiLN0fpd08l0sB184F/qADPtqfV6FGGtimrTbKXHM1xqE0R9j4puWAxwLdhpmbB+
	3vlbDawEcmIOmhiga3GtN60QmLZA968XbI+6nRPNWC8WnKExn6EBt5VBlaj6GPOI
	6DCdO0ubt6hw76NB39eEOtHJWkKFWzujX7gHlhQGViJCrIYaiv1KOBexjXvde9xt
	4c1nrsC63fLj+IQAfHIatlEhUtY/FIjF4z7D74HEX/sDpJLp5GVyhEHh6DDmco2V
	TQONb8cGN/GdZHF7eef+iUxW87+OZspXbbsaPUPJdP18KoxC5RSWokN4zUFB6zxs
	MiiiA3rMJKz2nJPMCcNg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqn8q17tw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 08:27:03 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4288R1Ou019589
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Mar 2024 08:27:02 GMT
Received: from [10.216.7.18] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 8 Mar
 2024 00:26:55 -0800
Message-ID: <1e353c1a-e267-14d0-fdf4-36aea9062ed3@quicinc.com>
Date: Fri, 8 Mar 2024 13:56:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/5] clk: qcom: clk-alpha-pll: Add support for Regera PLL
 ops
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>,
        Abhishek Sahu <absahu@codeaurora.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Stephen Boyd <sboyd@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>,
        "Imran
 Shaik" <quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20240229-camcc-support-sm8150-v1-0-8c28c6c87990@quicinc.com>
 <20240229-camcc-support-sm8150-v1-2-8c28c6c87990@quicinc.com>
 <630bb10a-2197-4573-a6d5-01fa6650c315@linaro.org>
From: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
In-Reply-To: <630bb10a-2197-4573-a6d5-01fa6650c315@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DeOmEczicIlX57jmsaIPHm2uetJ4bz6Q
X-Proofpoint-ORIG-GUID: DeOmEczicIlX57jmsaIPHm2uetJ4bz6Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_06,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=880 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080066


On 3/2/2024 5:26 AM, Konrad Dybcio wrote:
> On 29.02.2024 06:38, Satya Priya Kakitapalli wrote:
>> From: Taniya Das <quic_tdas@quicinc.com>
>>
>> Regera PLL ops are required to control the Regera PLL from clock
>> controller drivers, thus add support for the same.
>>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>> ---
> [...]
>
>
>> +static int clk_regera_pll_enable(struct clk_hw *hw)
> This function is 1:1 clk_zonda_pll_enable() logic-wise, except for
> the `if (val & ZONDA_STAY_IN_CFA)` part. Would it be an issue on
> Regera?


Yes, that is only applicable for Zonda PLL, hence we cannot re-use the 
same code for Regera.


>> +static void clk_regera_pll_disable(struct clk_hw *hw)
> This again is clk_zonda_pll_disable(), except the very last value written
> to PLL_OPMODE is different. Could you commonize them?
>

This difference is there between Zonda and regera PLLs as per the HW 
recommendation, hence we cannot re-use this.


>> +
>> +static void zonda_pll_adjust_l_val(unsigned long rate, unsigned long prate,
>> +									u32 *l)
> (Ugly wrapping, please touch it up)
>
> ..should it apply to zonda as the name suggests? Also, any explanations?


Yes, it is applicable for Zonda PLL as well, will update the Zonda pll 
set rate in next post. The L value needs to be adjusted to handle the 16 
bit signed alpha.


>> +	u64 remainder, quotient;
>> +
>> +	quotient = rate;
>> +	remainder = do_div(quotient, prate);
>> +	*l = quotient;
>> +
>> +	if ((remainder * 2) / prate)
>> +		*l = *l + 1;
>> +}
>> +
>> +static int clk_regera_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>> +				  unsigned long prate)
>> +{
>> +	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
>> +	unsigned long rrate;
>> +	u32 l, alpha_width = pll_alpha_width(pll);
>> +	u64 a;
>> +	int ret;
>> +
>> +	rrate = alpha_pll_round_rate(rate, prate, &l, &a, alpha_width);
>> +
>> +	ret = alpha_pll_check_rate_margin(hw, rrate, rate);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (a && (a & BIT(15)))
> What is BIT(15)?
>
> Also, the left part of the condition is totally bogus, if a is 0 then
> a & BIT(15) will surely be zero as well.


Sure, will correct this.


> Konrad
>
>

