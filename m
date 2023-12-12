Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5FB80E249
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345717AbjLLCo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjLLCoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:44:55 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9D0B5;
        Mon, 11 Dec 2023 18:45:01 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BC1d3UL013078;
        Tue, 12 Dec 2023 02:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        qcppdkim1; bh=JrEO67lajTGW8YcWpp+GMjeHTeTZ0xsoLSkntHgPSUQ=; b=Nl
        uAA8zPyZvy0vxBTwUc4ZAbPyG4cf2R9b4ZTrdWSsihsPXT7s/Fv2N8K8mlV1j/Sp
        FczTVwhib+4J8R56Ifdw7bRzMvlL/YhDjUPJkVjwjy5FPkuGx9dF6YdBm99XMVwa
        Olo2gElwjsa8ofC/78vBZezTzOynqPnNpVtDtyIpxpTl+F3H/10WH+hG9LLxMDjw
        uJw7IQ3p62kgCDQl/GG27wPZyFbQt8iGFP3AsUug8oT1yXBNfPtZOoqLH0ouGToP
        fxHp7kjtS+bCrU2IHeerjjw/s6tXCzgUw8/AFYnt/G/ZQ3PNym/cqc0QlQxhkeFt
        1cgDRitYLmkA7+6MSTSQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uxa8jgh68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 02:44:57 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BC2iujs030930
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 02:44:56 GMT
Received: from [10.47.206.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 11 Dec
 2023 18:44:53 -0800
Message-ID: <e1ea82cb-e812-9a1e-3c4d-7f468f5069e9@quicinc.com>
Date:   Mon, 11 Dec 2023 18:44:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] regulator: qcom-rpmh: add support for pm8010
 regulators
Content-Language: en-US
To:     <quic_fenglinw@quicinc.com>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <kernel@quicinc.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>
References: <20231211-pm8010-regulator-v1-0-571e05fb4ecc@quicinc.com>
 <20231211-pm8010-regulator-v1-3-571e05fb4ecc@quicinc.com>
From:   David Collins <quic_collinsd@quicinc.com>
In-Reply-To: <20231211-pm8010-regulator-v1-3-571e05fb4ecc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: U6pyP53BWKuClDFlxFWERVMTcPo_TH4_
X-Proofpoint-ORIG-GUID: U6pyP53BWKuClDFlxFWERVMTcPo_TH4_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120021
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/23 19:17, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <quic_fenglinw@quicinc.com>
> 
> Add RPMH regulators exposed by Qualcomm Technologies, Inc. PM8010
> PMIC. It has 7 LDOs with 3 different types, LDO1 - LDO2 are L502
> NMOS LDOs, LDO5 and LDO7 are L502 PMOS LDOs, LDO3/LDO4/LDO6 are
> L502 PMOS LDO for low noise applications. Also, LDO3 - LDO7 don't
> support LPM.
> 
> Suggested-by: David Collins <quic_collinsd@quicinc.com>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>

Reviewed-by: David Collins <quic_collinsd@quicinc.com>


> ---
>  drivers/regulator/qcom-rpmh-regulator.c | 62 +++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
> index 43b45feb02e6..80e304711345 100644
> --- a/drivers/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/regulator/qcom-rpmh-regulator.c
> @@ -511,6 +511,14 @@ static const int pmic_mode_map_pmic5_ldo[REGULATOR_MODE_STANDBY + 1] = {
>  	[REGULATOR_MODE_FAST]    = -EINVAL,
>  };
>  
> +static const int pmic_mode_map_pmic5_ldo_hpm[REGULATOR_MODE_STANDBY + 1] = {

Minor: This is fine as-is.  However, it might be a bit better with the
name: "pmic_mode_map_pmic5_ldo_hpm_only".


> +	[REGULATOR_MODE_INVALID] = -EINVAL,
> +	[REGULATOR_MODE_STANDBY] = -EINVAL,
> +	[REGULATOR_MODE_IDLE]    = -EINVAL,
> +	[REGULATOR_MODE_NORMAL]  = PMIC5_LDO_MODE_HPM,
> +	[REGULATOR_MODE_FAST]    = -EINVAL,
> +};
> +
>  static unsigned int rpmh_regulator_pmic4_ldo_of_map_mode(unsigned int rpmh_mode)
>  {
>  	unsigned int mode;
> @@ -733,6 +741,33 @@ static const struct rpmh_vreg_hw_data pmic5_pldo515_mv = {
>  	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
>  };
>  
> +static const struct rpmh_vreg_hw_data pmic5_pldo502 = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_ops,
> +	.voltage_ranges = (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(1504000, 0, 255, 8000),
> +	},
> +	.n_linear_ranges = 1,
> +	.n_voltages = 256,
> +	.pmic_mode_map = pmic_mode_map_pmic5_ldo_hpm,
> +	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
> +};
> +
> +static const struct rpmh_vreg_hw_data pmic5_pldo502ln = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_ops,
> +	.voltage_ranges = (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(1800000, 0,  2,  200000),
> +		REGULATOR_LINEAR_RANGE(2608000, 3,  28, 16000),
> +		REGULATOR_LINEAR_RANGE(3104000, 29, 30, 96000),
> +		REGULATOR_LINEAR_RANGE(3312000, 31, 31, 0),
> +	},
> +	.n_linear_ranges = 4,
> +	.n_voltages = 32,
> +	.pmic_mode_map = pmic_mode_map_pmic5_ldo_hpm,
> +	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
> +};
> +
>  static const struct rpmh_vreg_hw_data pmic5_nldo = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_drms_ops,
> @@ -759,6 +794,19 @@ static const struct rpmh_vreg_hw_data pmic5_nldo515 = {
>  	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
>  };
>  
> +static const struct rpmh_vreg_hw_data pmic5_nldo502 = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_drms_ops,
> +	.voltage_ranges = (struct linear_range[]) {
> +		REGULATOR_LINEAR_RANGE(528000, 0, 127, 8000),
> +	},
> +	.n_linear_ranges = 1,
> +	.n_voltages = 128,
> +	.hpm_min_load_uA = 30000,
> +	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
> +	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
> +};
> +
>  static const struct rpmh_vreg_hw_data pmic5_hfsmps510 = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_ops,
> @@ -1210,6 +1258,16 @@ static const struct rpmh_vreg_init_data pm8009_1_vreg_data[] = {
>  	{}
>  };
>  
> +static const struct rpmh_vreg_init_data pm8010_vreg_data[] = {
> +	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo502,   "vdd-l1-l2"),
> +	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo502,   "vdd-l1-l2"),
> +	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_pldo502ln, "vdd-l3-l4"),
> +	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_pldo502ln, "vdd-l3-l4"),
> +	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo502,   "vdd-l5"),
> +	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo502ln, "vdd-l6"),
> +	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo502,   "vdd-l7"),
> +};
> +
>  static const struct rpmh_vreg_init_data pm6150_vreg_data[] = {
>  	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps510, "vdd-s1"),
>  	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps510, "vdd-s2"),
> @@ -1525,6 +1583,10 @@ static const struct of_device_id __maybe_unused rpmh_regulator_match_table[] = {
>  		.compatible = "qcom,pm8009-1-rpmh-regulators",
>  		.data = pm8009_1_vreg_data,
>  	},
> +	{
> +		.compatible = "qcom,pm8010-rpmh-regulators",
> +		.data = pm8010_vreg_data,
> +	},
>  	{
>  		.compatible = "qcom,pm8150-rpmh-regulators",
>  		.data = pm8150_vreg_data,
> 

