Return-Path: <linux-kernel+bounces-39515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F1583D239
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5F3290939
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC33D4430;
	Fri, 26 Jan 2024 01:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a81xpKFA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F841AD21;
	Fri, 26 Jan 2024 01:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706233579; cv=none; b=NiulQlGQ4aEgGBVfUU220dZOccQkBFfX6Offzj6n3CqI2uk7TivjbY2tunTjVtwvc/S1w+IcDEg1Cdf1tlxJqFt6hd3OtaFIDi5NrSJH3J1ARevnPjrabxhOjItOSnuSrYI84n27WmoKy/etO3cOJVnOlGTNvKqybscWRqwnGB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706233579; c=relaxed/simple;
	bh=/6B+4PLRC+SPYSbNDFlIG2iFDTTG8UHmDRfJ+U5JC3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NZ8zqkDpMovN1LLlbGbAtrrbnU2Ma3La9ejaApTiX6vpALYejfLn1zzqrI4zlZm7z7VnOlsa5eiGLO0FKmPQ55JoymFGlhD3Ebvfk9cHCbP5meWPlFMBT3CRywrYI/stJxVyjyRFDFAujCFJ7cHlY0uDfkR8lLsPoiCtlJxzpVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a81xpKFA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40Q1NixX026731;
	Fri, 26 Jan 2024 01:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tS2e0eB36wLTxUhn39uBkFsB7b8CZJ5AgpbR8XUjaG8=; b=a8
	1xpKFAIgHKltVnsEE6z1LAAKvo9KRN1PdfJ8TOMCCh0AYJPRbKppBEcqlv9XU5SK
	LqaqtPlGn/4V0gtJ9IQNwhG2nsVrXDgIZ3weXblUTsoEAYTmrd0saPiplfeOsUIr
	dBbzRPIOi2hU3NuKZPd+QEnlENuS3n8kEo/Vr78Esp6Q8eAGSLoJiFpe89HDAUOt
	QgEapOSWfmu5JPbJcIbfaCHICIBz7cHCxSLhdC99//nxtX/feVP+vNHaIhVtmIx/
	jm3gXpX8dymNxuKvt656QU5cExs+NN6Yp2xnxLJ6MNT4mvSY+QrVw5RMV/wLABJE
	hEkW2jBgwt/RM73q/0xQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vufk9ayxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 01:46:13 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40Q1kC0Q010385
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 01:46:12 GMT
Received: from [10.47.206.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 17:46:08 -0800
Message-ID: <8995bd46-4e1f-8f79-ba22-c5f37b610fcd@quicinc.com>
Date: Thu, 25 Jan 2024 17:46:07 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: sm8650-mtp: add PM8010
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
        <linux-kernel@vger.kernel.org>
References: <20240125-sm8650_pm8010_support-v3-0-2f291242a7c4@quicinc.com>
 <20240125-sm8650_pm8010_support-v3-1-2f291242a7c4@quicinc.com>
From: David Collins <quic_collinsd@quicinc.com>
In-Reply-To: <20240125-sm8650_pm8010_support-v3-1-2f291242a7c4@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gPjPia8JtB2IhyTU9RCugZqLDTF4_E7d
X-Proofpoint-ORIG-GUID: gPjPia8JtB2IhyTU9RCugZqLDTF4_E7d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=658 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260011

On 1/25/24 01:31, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <quic_fenglinw@quicinc.com>
> 
> Add PM8010 regulator device nodes for sm8650-mtp board.
> 
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8650-mtp.dts | 132 ++++++++++++++++++++++++++++++++
>  1 file changed, 132 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
> index 9d916edb1c73..e440c28e5e9f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
> @@ -428,6 +428,138 @@ vreg_l3i_1p2: ldo3 {
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
> +		vdd-l6-supply = <&vreg_bob1>;
> +		vdd-l7-supply = <&vreg_bob1>;
> +
> +		vreg_l1m_1p1: ldo1 {
> +			regulator-name = "vreg_l1m_1p1";
> +			regulator-min-microvolt = <1104000>;
> +			regulator-max-microvolt = <1104000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2m_1p056: ldo2 {
> +			regulator-name = "vreg_l2m_1p056";
> +			regulator-min-microvolt = <1056000>;
> +			regulator-max-microvolt = <1056000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3m_2p8: ldo3 {
> +			regulator-name = "vreg_l3m_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4m_2p8: ldo4 {
> +			regulator-name = "vreg_l4m_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l5m_1p8: ldo5 {
> +			regulator-name = "vreg_l5m_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6m_2p8: ldo6 {
> +			regulator-name = "vreg_l6m_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7m_2p96: ldo7 {
> +			regulator-name = "vreg_l7m_2p96";
> +			regulator-min-microvolt = <2960000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-7 {
> +		compatible = "qcom,pm8010-rpmh-regulators";
> +		qcom,pmic-id = "n";
> +
> +		vdd-l1-l2-supply = <&vreg_s1c_1p2>;
> +		vdd-l3-l4-supply = <&vreg_s6c_1p8>;
> +		vdd-l5-supply = <&vreg_bob2>;
> +		vdd-l6-supply = <&vreg_bob2>;
> +		vdd-l7-supply = <&vreg_bob1>;
> +
> +		vreg_l1n_1p1: ldo1 {
> +			regulator-name = "vreg_l1n_1p1";
> +			regulator-min-microvolt = <1104000>;
> +			regulator-max-microvolt = <1104000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2n_1p056: ldo2 {
> +			regulator-name = "vreg_l2n_1p056";
> +			regulator-min-microvolt = <1056000>;
> +			regulator-max-microvolt = <1056000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> +						   RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3n_1p8: ldo3 {
> +			regulator-name = "vreg_l3n_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4n_1p8: ldo4 {
> +			regulator-name = "vreg_l4n_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l5n_2p8: ldo5 {
> +			regulator-name = "vreg_l5n_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6n_2p8: ldo6 {
> +			regulator-name = "vreg_l6n_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7n_3p3: ldo7 {
> +			regulator-name = "vreg_l7n_3p3";
> +			regulator-min-microvolt = <3304000>;
> +			regulator-max-microvolt = <3304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
>  };
>  
>  &dispcc {
> 

Reviewed-by: David Collins <quic_collinsd@quicinc.com>


