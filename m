Return-Path: <linux-kernel+bounces-37585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C0183B206
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81CD41F22561
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E65133419;
	Wed, 24 Jan 2024 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PWYDrGa4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E828132C34;
	Wed, 24 Jan 2024 19:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123778; cv=none; b=gdR2KPCiqn63ZegVPtwwypNdGPR/iwwDT6s8lQ9jYhy/YeHIvp80T9NqXAwPWh72wCbsw8LsXsudBMJjs7eh4soqhb/+3AumgOOBG30dU+YifCwTz/Et9bG4aJYfST2naZkcALnSNy2jzCDKm+k01i8LYh3kDLUN/qZ7OTCWL58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123778; c=relaxed/simple;
	bh=KrCr/hBvRMay4+YgPTqpdP3bMZBZPQV/3qgGqMdoJBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BS66sv1PVu4Dyi0ZaWjhV5iIqrtXIOZ/EVe4ixxqwJmvmeTQkN2TIJrj+VMOHwnbAa/EUD6RTVdbuI1+OmH7EbvcUKWzW6BTllKwrcb/aqCPZvh1Y54CphdvA6cZi/pa1YV0RQyytvbnJ4qJEnFFsaLmNxPkxyzaS++HUEbnYaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PWYDrGa4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40OGmt2L020054;
	Wed, 24 Jan 2024 19:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vn/hBrgcXGJSOF3hpgYqBNdqfN8/k3lI9w/bdD85HMk=; b=PW
	YDrGa4+bgiINGbSSMQO2+9AsQR8kH6ZnISgI4K13SJ0KWbkmfsGaLq7I5w1NNnf6
	1TeDh/xn1TazZ4LM5hOKXqfWcQzDJ+BHp7AASIKWQYhBMmqaHeTLrdMrRSL4uwO7
	HgNcJaLtieu5Gm1IiCfmYWyP32+k/1nT0Hwjge8dU2UplSfWzT291l8HNNPG4ZT/
	YQAgQQoUki7A9t1P+Xc9y4/hFcVUNoSsc7eCsQjrl91V8+eBXkca1CTduJb/qfOx
	dO+DmHc2BsQbTy9qkiiVQ8H+mjIDAy67Sosl4dLETkq5va6TNoSZsgjM5PnNQWYh
	nrmiDH9B522qthrTas6Q==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vu19gh4cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 19:16:13 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40OJGCBv009526
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 19:16:12 GMT
Received: from [10.47.206.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 11:16:08 -0800
Message-ID: <2c35dfab-fb6f-4f72-4395-705b5588fab3@quicinc.com>
Date: Wed, 24 Jan 2024 11:16:08 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sm8650-qrd: add PM8010
 regulators
Content-Language: en-US
To: <quic_fenglinw@quicinc.com>, <kernel@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20240123-sm8650_pm8010_support-v2-0-52f517b20a1d@quicinc.com>
 <20240123-sm8650_pm8010_support-v2-2-52f517b20a1d@quicinc.com>
From: David Collins <quic_collinsd@quicinc.com>
In-Reply-To: <20240123-sm8650_pm8010_support-v2-2-52f517b20a1d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _i-cKRmVExs04UCN2DLGWapFeXri_J2t
X-Proofpoint-ORIG-GUID: _i-cKRmVExs04UCN2DLGWapFeXri_J2t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_08,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=790 spamscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401240139

On 1/23/24 00:49, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <quic_fenglinw@quicinc.com>
> 
> Add PM8010 regulator device nodes for sm8650-qrd board.
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 118 ++++++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
> index 592a67a47c78..361894fa201a 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
> @@ -436,6 +436,124 @@ vreg_l3i_1p2: ldo3 {
>  						   RPMH_REGULATOR_MODE_HPM>;
>  		};
>  	};
> +
> +	regulators-6 {
> +		compatible = "qcom,pm8010-rpmh-regulators";
> +		qcom,pmic-id = "m";
> +
> +		vdd-l1-l2-supply = <&vreg_s1c_1p2>;
> +		vdd-l3-l4-supply = <&vreg_bob2>;
> +		vdd-l5-supply = <&vreg_s6c_1p8>;
> +		vdd-l6-l7-supply = <&vreg_bob1>;

Please replace this line with:

vdd-l6-supply = <&vreg_bob1>;
vdd-l7-supply = <&vreg_bob1>;

> +
> +		vreg_l1m_1p1: ldo1 {
> +			regulator-name = "vreg_l1m_1p1";
> +			regulator-min-microvolt = <1104000>;
> +			regulator-max-microvolt = <1104000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;

Optional:
PM8010 L1 and L2 physically support LPM vs HPM configuration.
Therefore, these lines could be added here to allow such configuration
by software at runtime:

regulator-allow-set-load;
regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
			   RPMH_REGULATOR_MODE_HPM>;

> +		};
> +
> +		vreg_l2m_1p056: ldo2 {
> +			regulator-name = "vreg_l2m_1p056";
> +			regulator-min-microvolt = <1056000>;
> +			regulator-max-microvolt = <1056000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;

The same comment about LPM vs HPM configuration applies here.

> +	regulators-7 {
> +		compatible = "qcom,pm8010-rpmh-regulators";
> +		qcom,pmic-id = "n";
> +
> +		vdd-l1-l2-supply = <&vreg_s1c_1p2>;
> +		vdd-l3-l4-supply = <&vreg_s6c_1p8>;
> +		vdd-l5-l6-supply = <&vreg_bob2>;

Please replace this line with:

vdd-l5-supply = <&vreg_bob2>;
vdd-l6-supply = <&vreg_bob2>;

> +		vdd-l7-supply = <&vreg_bob1>;
> +
> +		vreg_l1n_1p1: ldo1 {
> +			regulator-name = "vreg_l1n_1p1";
> +			regulator-min-microvolt = <1104000>;
> +			regulator-max-microvolt = <1104000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;

The same comment about LPM vs HPM configuration applies here.

> +		};
> +
> +		vreg_l2n_1p056: ldo2 {
> +			regulator-name = "vreg_l2n_1p056";
> +			regulator-min-microvolt = <1056000>;
> +			regulator-max-microvolt = <1056000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;

The same comment about LPM vs HPM configuration applies here.

Thanks,
David


