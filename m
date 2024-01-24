Return-Path: <linux-kernel+bounces-37584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C82E583B200
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811E728947F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E546A132C2F;
	Wed, 24 Jan 2024 19:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OZQQDeWQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A30131E39;
	Wed, 24 Jan 2024 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123777; cv=none; b=AXp+9hYKeahrfZdxTj5HmVO99eekgpzaeiPdLkRqX48pq8R08rn28NiwC0Lbv7PVqX+DdYa8q44ZJrakrqX/UYhwUVW1R6nyZHD1jOOpX32w33knzynI6492a+Eif0uzLAMgKpggyPEctmaCx50q62AOULpYI1sJYu6ADELlGac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123777; c=relaxed/simple;
	bh=f8ZlH9vMT3sL/6YvPJqJqZJEUCSDArESjpkMfEz3DPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CA4Kq2pkFjgrKCzbaqe6XWmXZJiGS13Zkb0tmmCThvthwur9R4PJD6/lz+rZ1U9nxrmMQVltDfV692CW7+i20z8DvwJjM4XGoq0b9cLoihoNk8UnpkkjoLSuijEOz1FwJoQ8L2a+gFRJMddhByrabfrQuOVpDbxDa29RcmgNw5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OZQQDeWQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40OGw6wk017115;
	Wed, 24 Jan 2024 19:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Qm8Va0Smjl0rI/8Z3ZF/j5Yb6xxaE3u5cp+h4D7wR/A=; b=OZ
	QQDeWQQseVZKGPysenBCOk3W1sdEPGEAKuLxD2wrhilRU4wr4anFru85U2RaexOt
	ZTUc0nyDp8Krdhp+ZqTeDgtosYJad2Iwd8pQ72xHxJCTm46drUF4vC2VPE7yejJ4
	o2Qm+x8x+E5/s7o2/lXGBvVTK4qlphkug9AT+g3Z+DVxi4hWP3g+frtz/tfuC0R/
	Bay6gHjDR/K+tZ+r4scK/Bw9z+hkckAZwCcyvGRrDxItlJECqQxGGE13CRNhuEmo
	QAHkBNXwMeSXAvFjbYwvrOoHnQdWOTciMRep21PhpWXdV3SoQsboQ7n6cnmbcenr
	sxriMZyq9KcxBH58RfOQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtwd61s7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 19:16:08 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40OJG6OJ030518
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 19:16:06 GMT
Received: from [10.47.206.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 11:16:03 -0800
Message-ID: <892058db-8013-879d-6c6f-3fbbf4ed3c57@quicinc.com>
Date: Wed, 24 Jan 2024 11:15:24 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: sm8650-mtp: add PM8010
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
 <20240123-sm8650_pm8010_support-v2-1-52f517b20a1d@quicinc.com>
From: David Collins <quic_collinsd@quicinc.com>
In-Reply-To: <20240123-sm8650_pm8010_support-v2-1-52f517b20a1d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ve1ErF9GB-CinKO6v_vYJ1D4tF3AbBcQ
X-Proofpoint-ORIG-GUID: Ve1ErF9GB-CinKO6v_vYJ1D4tF3AbBcQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_08,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=838 spamscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240139

On 1/23/24 00:49, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <quic_fenglinw@quicinc.com>
> 
> Add PM8010 regulator device nodes for sm8650-mtp board.
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8650-mtp.dts | 118 ++++++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
> index 9d916edb1c73..3791971efee6 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
> @@ -428,6 +428,124 @@ vreg_l3i_1p2: ldo3 {
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


