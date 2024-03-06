Return-Path: <linux-kernel+bounces-93505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0633E8730C5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70FF11F2838D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3552F5D8F6;
	Wed,  6 Mar 2024 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dPhwLhU0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E802374A;
	Wed,  6 Mar 2024 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713919; cv=none; b=p0WqknyWE438g3yzBuFiNu3ytK2rdcbTNHHSye5VwKbOhEM4WfjIb/nSb/ZkG6P5hINk7ZGtCIo12C2fk4qu+A0EJ0eLeTIt8qR+xHRLNNdi013Ex/Iy0SucyHraDuqxi/C4eHNuvb01NrEK/rlted3kf9os4H7d7qnFjCaZ7QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713919; c=relaxed/simple;
	bh=vTXlzKfVuR7thkMypOhy/ZsOpYaW4JBviEC5G7CKrTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JqyzJvJXfJHFmQxIDkUo+Qw+23FmJW1GsMUsmefw2+lRWbmByKW3DY5ENV5PcuMBsU6/05N55niPwf+hpzcWQ8PhxvNwUNR+nlX6vS+5t7XJnieoN7b9q9CiVYcASFP/ROwnlT5KIUl9t1KW6mZArXliGMG2nvdI8x3cD+g+154=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dPhwLhU0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4265xoNr020249;
	Wed, 6 Mar 2024 08:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=q86A9onL0rmqEe1iKRvRqZ3S28SROOVGnLJLR6S1sK8=; b=dP
	hwLhU0DBVyiGKqk04VPPE3RpjYgMykQp1nBuELT+S39/R73q0nIH/igEsvThZiSO
	75C4Mxr3MajWXQ/bmUYgAGTHkN+esMTKFLrzEp3w0ym+7y72zwkSM65fm6hchiSg
	e2pOVMioIX1Ak+XlEEPIareL1RyLu8py6MoQ01AbalBFVF6IereriEUcUU583Bmo
	wNc4o4sBM0R2gYi1NF9eelPoi0QmvuOy3YXOnemh9crMlyJVp0t+U3a4V8nG2Qiv
	/5W3KyoPcxgx6XOREDD4eLbqS4GpAH9H9KlA0m/Bk9VjggbhZe2MtY00YpXpXb/Q
	Rnjud3N7N3H7J9xb3yEQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpgdsrhht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 08:31:20 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4268VJIl012146
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 08:31:19 GMT
Received: from [10.218.19.46] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Mar
 2024 00:31:13 -0800
Message-ID: <83fd1995-a06e-b76a-d91b-de1c1a6ab0ea@quicinc.com>
Date: Wed, 6 Mar 2024 14:00:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 4/5] clk: qcom: Add camera clock controller driver for
 SM8150
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Michael
 Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Abhishek Sahu <absahu@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Stephen Boyd <sboyd@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>,
        "Imran
 Shaik" <quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20240229-camcc-support-sm8150-v1-0-8c28c6c87990@quicinc.com>
 <20240229-camcc-support-sm8150-v1-4-8c28c6c87990@quicinc.com>
 <18567989-fb60-49ae-92e6-94e1bc2fa1c7@linaro.org>
From: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
In-Reply-To: <18567989-fb60-49ae-92e6-94e1bc2fa1c7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 488fqkA63x5DW3xa_wvVr61O3_z7-kd_
X-Proofpoint-GUID: 488fqkA63x5DW3xa_wvVr61O3_z7-kd_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_04,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 spamscore=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403060067


On 3/2/2024 9:43 PM, Bryan O'Donoghue wrote:
> On 29/02/2024 5:38 a.m., Satya Priya Kakitapalli wrote:
>> Add support for the camera clock controller for camera clients
>> to be able to request for camcc clocks on SM8150 platform.
>>
>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>> ---
>
>> +static int cam_cc_sm8150_probe(struct platform_device *pdev)
>> +{
>> +    struct regmap *regmap;
>> +    int ret;
>> +
>> +    ret = devm_pm_runtime_enable(&pdev->dev);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = pm_runtime_resume_and_get(&pdev->dev);
>> +    if (ret)
>> +        return ret;
>> +
>> +    regmap = qcom_cc_map(pdev, &cam_cc_sm8150_desc);
>> +    if (IS_ERR(regmap)) {
>> +        pm_runtime_put(&pdev->dev);
>> +        return PTR_ERR(regmap);
>> +    }
>> +
>> +    clk_trion_pll_configure(&cam_cc_pll0, regmap, &cam_cc_pll0_config);
>> +    clk_trion_pll_configure(&cam_cc_pll1, regmap, &cam_cc_pll1_config);
>> +    clk_regera_pll_configure(&cam_cc_pll2, regmap, 
>> &cam_cc_pll2_config);
>> +    clk_trion_pll_configure(&cam_cc_pll3, regmap, &cam_cc_pll3_config);
>> +    clk_trion_pll_configure(&cam_cc_pll4, regmap, &cam_cc_pll4_config);
>> +
>> +    /* Keep the critical clock always-on */
>> +    qcom_branch_set_clk_en(regmap, 0xc1e4); /* cam_cc_gdsc_clk */
>
> Does this clock need to be specified this way ?
>

Yes, we need this clock to be always on.


> drivers/clk/qcom/camcc-sc8280xp.c::camcc_gdsc_clk specifies the gdsc 
> clock as a shared op clock.
>
> Actually it looks to be register compatible, please try defining 
> titan_top_gdsc as per the example in 8280xp.
>> +
>> +    ret = qcom_cc_really_probe(pdev, &cam_cc_sm8150_desc, regmap);
>> +
>> +    pm_runtime_put(&pdev->dev);
>> +
>> +    return ret;
>> +}
>
> So this is a pattern we keep repeating in the clock probe() functions 
> which I am writing a series to address. There's no need to continue to 
> replicate the bug in new code though.
>
> Only switch on always-on clocks if probe succeeds.
>
>     ret = qcom_cc_really_probe(pdev, &cam_cc_sm8150_desc, regmap);
>     if (ret)
>         goto probe_err;
>
>     qcom_branch_set_clk_en(regmap, 0xc1e4); /* cam_cc_gdsc_clk */
>
>     pm_runtime_put(&pdev->dev);
>
>     return 0;
>
> probe_err:
>     pm_runtime_put_sync(&pdev->dev);
>
> Alternatively switch on the always-on clocks before the really_probe() 
> but then roll back in a probe_err: goto
>
> probe_err:
>     remap_bits_update(regmap, 0xc1e4, BIT(0), 0);
>     pm_runtime_put_sync(&pdev->dev);
>
> There may be corner cases where always-on has to happen before 
> really_probe() I suppose but as a general pattern the above should be 
> how we go.
>
> Anyway I suspect the right thing to do is to define a 
> titan_top_gdsc_clk with shared ops to "park" the GDSC clock to 19.2 
> MHz instead of turning it off.
>
> You can get rid of the hard-coded always-on and indeed represent the 
> clock in /sysfs - which is preferable IMO to just whacking registers 
> to keep clocks always-on in probe anyway.
>
> Please try to define the titan_top_gdsc_clk as a shared_ops clock 
> instead of hard coding to always on.
>

Defining the gdsc clk allows consumers to control it, we do not want 
this clock to be disabled/controlled from consumers. Hence it is better 
to not model this clock and just keep it always on from probe.


> If that doesn't work for some reason, then please fix your always-on 
> logic in probe() to only make the clock fixed on, if really_probe() 
> succeeds.
>

Sure I'll do this.


> ---
> bod

