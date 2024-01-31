Return-Path: <linux-kernel+bounces-45998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E50084390D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC561F22D41
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F1E58ACB;
	Wed, 31 Jan 2024 08:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fGPqk5jw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DE558207;
	Wed, 31 Jan 2024 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689706; cv=none; b=C5J8prfsmwshTZyUMwCuddkFh2pYcgUIjk4SCWqgDVLCHeMezJh3Qc+AEin7Qj+JO0RXBSEalPNOaPgLq2OA3c8DuZ3YVzWKEQlCuh+CdKUFUXZsFqhpuZh+7/NU/3cYyQ3InUYN2UTK/wa5Egp1d1zjZ78EL6sW7knR2bDXHsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689706; c=relaxed/simple;
	bh=YNFeHB8eqcZ9vLVmRGPVGaPpF//8uM09qR5UYs1tgZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kBqV20yXb6e6OX11kFpwZ6NpopfdHbqssBrWZnmgv3LLGhzwRloRlQb285pNUtE1Yo9fxD8tOn+nqxkX56fSbqX7j9iZu9FJDKGakGay3dWaw490+a9BLUblYGbHLUNslsBd0NLh3d+KW+/r6rX6MjYLkHKCY5GjukI6eQ76Wuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fGPqk5jw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V77D2G027491;
	Wed, 31 Jan 2024 08:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tcZItIpAU8+wML7bXkL2MPr3P1wElBDN3H8+hVz69R4=; b=fG
	Pqk5jwFrnuZVRwer74rduNFSDOHTE517q/kMEoMvkrTP9mwiyXAJUYA1RXA0IO3i
	4FS85wPTs+RFFaZNGGb9p4jtTYzgfMEPb+5JNZhh9rA0iGDJ5jur2CSbvBaYIcDH
	LsJZdWEi+qKIkpb9DJzx+8o8ctwReDvODOh848IPiftX3LfvM/dADJqXkUpFtYkw
	YfMROno/Wnw++NQ1PiMNBYJlCWw1vrzpqDzcsVXB5LvG8jFZwL20cXUwr0q4P+A+
	nXfNvl7cRQbKdCpxsrnRifo71R9r4yf3ME+7J8eZVY5ycQs0kEaa25bExvNgfCEh
	5BXDwDcKU2API3I8PiEA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vygp7geab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 08:28:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40V8SJ5f010695
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 08:28:19 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 00:28:14 -0800
Message-ID: <fa9c67ae-e94c-43a0-a971-563687760e4e@quicinc.com>
Date: Wed, 31 Jan 2024 16:28:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: pinctrl: qcom: consolidate functions
 to match with driver
To: Bjorn Andersson <quic_bjorande@quicinc.com>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20240129092512.23602-1-quic_tengfan@quicinc.com>
 <20240129092512.23602-3-quic_tengfan@quicinc.com>
 <20240130043848.GU2936378@hu-bjorande-lv.qualcomm.com>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <20240130043848.GU2936378@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Mt2F_y1mnPt2i6e7BiZFlv9fFchCspgu
X-Proofpoint-GUID: Mt2F_y1mnPt2i6e7BiZFlv9fFchCspgu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_03,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 adultscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401310064



On 1/30/2024 12:38 PM, Bjorn Andersson wrote:
> On Mon, Jan 29, 2024 at 05:25:12PM +0800, Tengfei Fan wrote:
>> Consolidate functions to match with SM4450 pinctrl driver, because
>> consolidate functions are being used in SM4450 pinctrl driver.
> 
> Please make your commit message start by describing the problem you're
> solving, then provide a technical description of the change.
> 
> The problem statement can mention that you consolidated the functions in
> the driver, but did not update the binding before it was merged. And for
> a DeviceTree binding, it should document why this
> non-backwards-compatible change is okay (such as the initial commit is
> broken).
> 
> Regards,
> Bjorn

Thank you for the comments, I will do new commit message as you 
suggested that commit message start by describing the problem, then 
provide a technical description of the chagne.

> 
>>
>> Fixes: 7bf8b78f86db ("dt-bindings: pinctrl: qcom: Add SM4450 pinctrl")
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   .../bindings/pinctrl/qcom,sm4450-tlmm.yaml    | 51 +++++++------------
>>   1 file changed, 17 insertions(+), 34 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
>> index bb675c8ec220..4109104de054 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
>> @@ -72,40 +72,23 @@ $defs:
>>           description:
>>             Specify the alternative function to be configured for the specified
>>             pins.
>> -        enum: [ gpio, atest_char, atest_char0, atest_char1, atest_char2,
>> -                atest_char3, atest_usb0, atest_usb00, atest_usb01, atest_usb02,
>> -                atest_usb03, audio_ref, cam_mclk, cci_async, cci_i2c,
>> -                cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4,
>> -                cmu_rng0, cmu_rng1, cmu_rng2, cmu_rng3, coex_uart1, cri_trng,
>> -                cri_trng0, cri_trng1, dbg_out, ddr_bist, ddr_pxi0, ddr_pxi1,
>> -                dp0_hot, gcc_gp1, gcc_gp2, gcc_gp3, host2wlan_sol, ibi_i3c,
>> -                jitter_bist, mdp_vsync, mdp_vsync0, mdp_vsync1, mdp_vsync2,
>> -                mdp_vsync3, mi2s0_data0, mi2s0_data1, mi2s0_sck, mi2s0_ws,
>> -                mi2s2_data0, mi2s2_data1, mi2s2_sck, mi2s2_ws, mi2s_mclk0,
>> -                mi2s_mclk1, nav_gpio0, nav_gpio1, nav_gpio2, pcie0_clk,
>> -                phase_flag0, phase_flag1, phase_flag10, phase_flag11,
>> -                phase_flag12, phase_flag13, phase_flag14, phase_flag15,
>> -                phase_flag16, phase_flag17, phase_flag18, phase_flag19,
>> -                phase_flag2, phase_flag20, phase_flag21, phase_flag22,
>> -                phase_flag23, phase_flag24, phase_flag25, phase_flag26,
>> -                phase_flag27, phase_flag28, phase_flag29, phase_flag3,
>> -                phase_flag30, phase_flag31, phase_flag4, phase_flag5,
>> -                phase_flag6, phase_flag7, phase_flag8, phase_flag9,
>> -                pll_bist, pll_clk, prng_rosc0, prng_rosc1, prng_rosc2,
>> -                prng_rosc3, qdss_cti, qdss_gpio, qdss_gpio0, qdss_gpio1,
>> -                qdss_gpio10, qdss_gpio11, qdss_gpio12, qdss_gpio13, qdss_gpio14,
>> -                qdss_gpio15, qdss_gpio2, qdss_gpio3, qdss_gpio4, qdss_gpio5,
>> -                qdss_gpio6, qdss_gpio7, qdss_gpio8, qdss_gpio9, qlink0_enable,
>> -                qlink0_request, qlink0_wmss, qlink1_enable, qlink1_request,
>> -                qlink1_wmss, qlink2_enable, qlink2_request, qlink2_wmss,
>> -                qup0_se0, qup0_se1, qup0_se2, qup0_se3, qup0_se4, qup0_se5,
>> -                qup0_se6, qup0_se7, qup1_se0, qup1_se1, qup1_se2, qup1_se3,
>> -                qup1_se4, qup1_se5, qup1_se6, sd_write, tb_trig, tgu_ch0,
>> -                tgu_ch1, tgu_ch2, tgu_ch3, tmess_prng0, tmess_prng1,
>> -                tmess_prng2, tmess_prng3, tsense_pwm1, tsense_pwm2, uim0_clk,
>> -                uim0_data, uim0_present, uim0_reset, uim1_clk, uim1_data,
>> -                uim1_present, uim1_reset, usb0_hs, usb0_phy, vfr_0, vfr_1,
>> -                vsense_trigger ]
>> +        enum: [ gpio, atest_char, atest_usb0, audio_ref_clk, cam_mclk,
>> +                cci_async_in0, cci_i2c, cci, cmu_rng, coex_uart1_rx,
>> +                coex_uart1_tx, cri_trng, dbg_out_clk, ddr_bist,
>> +                ddr_pxi0_test, ddr_pxi1_test, gcc_gp1_clk, gcc_gp2_clk,
>> +                gcc_gp3_clk, host2wlan_sol, ibi_i3c_qup0, ibi_i3c_qup1,
>> +                jitter_bist_ref, mdp_vsync0_out, mdp_vsync1_out,
>> +                mdp_vsync2_out, mdp_vsync3_out, mdp_vsync, nav,
>> +                pcie0_clk_req, phase_flag, pll_bist_sync, pll_clk_aux,
>> +                prng_rosc, qdss_cti_trig0, qdss_cti_trig1, qdss_gpio,
>> +                qlink0_enable, qlink0_request, qlink0_wmss_reset,
>> +                qup0_se0, qup0_se1, qup0_se2, qup0_se3, qup0_se4,
>> +                qup1_se0, qup1_se1, qup1_se2, qup1_se2_l2, qup1_se3,
>> +                qup1_se4, sd_write_protect, tb_trig_sdc1, tb_trig_sdc2,
>> +                tgu_ch0_trigout, tgu_ch1_trigout, tgu_ch2_trigout,
>> +                tgu_ch3_trigout, tmess_prng, tsense_pwm1_out,
>> +                tsense_pwm2_out, uim0, uim1, usb0_hs_ac, usb0_phy_ps,
>> +                vfr_0_mira, vfr_0_mirb, vfr_1, vsense_trigger_mirnat ]
>>   
>>           required:
>>             - pins
>> -- 
>> 2.17.1
>>

-- 
Thx and BRs,
Tengfei Fan

