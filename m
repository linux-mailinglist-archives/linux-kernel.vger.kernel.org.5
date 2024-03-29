Return-Path: <linux-kernel+bounces-125438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3B38925EE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FD01C21959
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495E213B59A;
	Fri, 29 Mar 2024 21:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X/A+89B1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC7E1E525;
	Fri, 29 Mar 2024 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711746602; cv=none; b=H3Wm42bN6HMLaqDLtrFBnnthtTd8MwlbRZOJrUxhOCcHi3r9+Or9oaP7rfO8rEigh7tK9QYiu8DwfCLsYLPxXvcbhEP760e+f+Vd5RPoIMQrcn2CWfoH0dxDKF46qsJJgxOLApAf+6x4/LCVJePavkywxVkmnKm0gF/a6iEg8HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711746602; c=relaxed/simple;
	bh=vmACCbBjqg3nWWvDu8URe1G0nj20JBxIU7AuubZpX68=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiSZj4WwQm4jaCe+viPWP9LndAIbOO+SpheBSHUP4NV6D7xoNUhuQR42T5hu6/lOC/W5jj7Mee/qWsXSRiz+G2slT9f4E8GrT19WkMjKn/d8HIqxsLQDaOAFLXjuPxtY9c3DEmI1TS2nXMmcbXdyBCmWa1TVXqhmcFhW11RK/uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X/A+89B1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TJdmkd016939;
	Fri, 29 Mar 2024 21:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=8I78I2NePjZhCju4DquV/
	NnmCdYHcIEmajlzdc9R8vk=; b=X/A+89B16Zm5+rugg0nAT1xF6M5df+qLfRRk2
	giPd9gMEI8hq/TLRPz5ebm7Y5VgTx4NtUVBTMEjqcmLBZpvfqJXS9cjjviHIwfp8
	lUp3wg5NeCQ/dRpdM1Rg8GYZZ73x+g9RyrXCRL4UUdtKERuxgx3PUISFyxAzm8Mt
	hsknl2YCR5MXic2tt1nn2AZ5h1qx4wcZtlkNgzUalzH2zg9z1Pr+0FxAanf4TVwx
	m8veXecyt1e6DfXcoSU3WVkqQqf0zVt49E6kWOwnDr9+hURW6nb/Y9VEYYYtBIuQ
	fCWyPl6gdSoHGUr6Mun1aba7XiW3j5hbpQxkMfL3rUhumZucw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5ybmrvtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 21:09:57 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TL9t1b029756
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 21:09:55 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 29 Mar 2024 14:09:55 -0700
Date: Fri, 29 Mar 2024 14:09:55 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Umang Chheda <quic_uchheda@quicinc.com>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_kamalw@quicinc.com>
Subject: Re: [PATCH] arm64: dts: qcom: qcm6490-idp: Add change to name the
 regulators
Message-ID: <20240329140534820-0700.eberman@hu-eberman-lv.qualcomm.com>
Mail-Followup-To: Umang Chheda <quic_uchheda@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_kamalw@quicinc.com
References: <20240329122940.3649730-1-quic_uchheda@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240329122940.3649730-1-quic_uchheda@quicinc.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: i4h0bVr23mtjriA0EHF4WY15lE23MaPe
X-Proofpoint-GUID: i4h0bVr23mtjriA0EHF4WY15lE23MaPe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=652
 suspectscore=0 adultscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290188

Nit: the subject line should be:

arm64: dts: qcom: qcm6490: Name the regulators

I don't know if it merits a resend, though.

On Fri, Mar 29, 2024 at 05:59:40PM +0530, Umang Chheda wrote:
> Without explicitly specifying names for the regulators they are named
> based on the DeviceTree node name. This results in multiple regulators
> with the same name, making it impossible to reason debug prints and
> regulator_summary.
> 
> Signed-off-by: Umang Chheda <quic_uchheda@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 41 ++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> index f8f8a43f638d..ac6d741868ca 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> @@ -195,129 +195,151 @@ regulators-0 {
>  		vdd-l14-l16-supply = <&vreg_s8b_1p272>;
>  
>  		vreg_s1b_1p872: smps1 {
> +			regulator-name = "vreg_s1b_1p872";
>  			regulator-min-microvolt = <1840000>;
>  			regulator-max-microvolt = <2040000>;
>  		};
>  
>  		vreg_s2b_0p876: smps2 {
> +			regulator-name = "vreg_s2b_0p876";
>  			regulator-min-microvolt = <570070>;
>  			regulator-max-microvolt = <1050000>;
>  		};
>  
>  		vreg_s7b_0p972: smps7 {
> +			regulator-name = "vreg_s7b_0p972";
>  			regulator-min-microvolt = <535000>;
>  			regulator-max-microvolt = <1120000>;
>  		};
>  
>  		vreg_s8b_1p272: smps8 {
> +			regulator-name = "vreg_s8b_1p272";
>  			regulator-min-microvolt = <1200000>;
>  			regulator-max-microvolt = <1500000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_RET>;
>  		};
>  
>  		vreg_l1b_0p912: ldo1 {
> +			regulator-name = "vreg_l1b_0p912";
>  			regulator-min-microvolt = <825000>;
>  			regulator-max-microvolt = <925000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l2b_3p072: ldo2 {
> +			regulator-name = "vreg_l2b_3p072";
>  			regulator-min-microvolt = <2700000>;
>  			regulator-max-microvolt = <3544000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l3b_0p504: ldo3 {
> +			regulator-name = "vreg_l3b_0p504";
>  			regulator-min-microvolt = <312000>;
>  			regulator-max-microvolt = <910000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l4b_0p752: ldo4 {
> +			regulator-name = "vreg_l4b_0p752";
>  			regulator-min-microvolt = <752000>;
>  			regulator-max-microvolt = <820000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		reg_l5b_0p752: ldo5 {
> +			regulator-name = "reg_l5b_0p752";
>  			regulator-min-microvolt = <552000>;
>  			regulator-max-microvolt = <832000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l6b_1p2: ldo6 {
> +			regulator-name = "vreg_l6b_1p2";
>  			regulator-min-microvolt = <1140000>;
>  			regulator-max-microvolt = <1260000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l7b_2p952: ldo7 {
> +			regulator-name = "vreg_l7b_2p952";
>  			regulator-min-microvolt = <2400000>;
>  			regulator-max-microvolt = <3544000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l8b_0p904: ldo8 {
> +			regulator-name = "vreg_l8b_0p904";
>  			regulator-min-microvolt = <870000>;
>  			regulator-max-microvolt = <970000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l9b_1p2: ldo9 {
> +			regulator-name = "vreg_l9b_1p2";
>  			regulator-min-microvolt = <1200000>;
>  			regulator-max-microvolt = <1304000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l11b_1p504: ldo11 {
> +			regulator-name = "vreg_l11b_1p504";
>  			regulator-min-microvolt = <1504000>;
>  			regulator-max-microvolt = <2000000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l12b_0p751: ldo12 {
> +			regulator-name = "vreg_l12b_0p751";
>  			regulator-min-microvolt = <751000>;
>  			regulator-max-microvolt = <824000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l13b_0p53: ldo13 {
> +			regulator-name = "vreg_l13b_0p53";
>  			regulator-min-microvolt = <530000>;
>  			regulator-max-microvolt = <824000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l14b_1p08: ldo14 {
> +			regulator-name = "vreg_l14b_1p08";
>  			regulator-min-microvolt = <1080000>;
>  			regulator-max-microvolt = <1304000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l15b_0p765: ldo15 {
> +			regulator-name = "vreg_l15b_0p765";
>  			regulator-min-microvolt = <765000>;
>  			regulator-max-microvolt = <1020000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l16b_1p1: ldo16 {
> +			regulator-name = "vreg_l16b_1p1";
>  			regulator-min-microvolt = <1100000>;
>  			regulator-max-microvolt = <1300000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l17b_1p7: ldo17 {
> +			regulator-name = "vreg_l17b_1p7";
>  			regulator-min-microvolt = <1700000>;
>  			regulator-max-microvolt = <1900000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l18b_1p8: ldo18 {
> +			regulator-name = "vreg_l18b_1p8";
>  			regulator-min-microvolt = <1800000>;
>  			regulator-max-microvolt = <2000000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l19b_1p8: ldo19 {
> +			regulator-name = "vreg_l19b_1p8";
>  			regulator-min-microvolt = <1800000>;
>  			regulator-max-microvolt = <2000000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> @@ -349,109 +371,128 @@ regulators-1 {
>  		vdd-bob-supply = <&vph_pwr>;
>  
>  		vreg_s1c_2p19: smps1 {
> +			regulator-name = "vreg_s1c_2p19";
>  			regulator-min-microvolt = <2190000>;
>  			regulator-max-microvolt = <2210000>;
>  		};
>  
>  		vreg_s2c_0p752: smps2 {
> +			regulator-name = "vreg_s2c_0p752";
>  			regulator-min-microvolt = <750000>;
>  			regulator-max-microvolt = <800000>;
>  		};
>  
>  		vreg_s5c_0p752: smps5 {
> +			regulator-name = "vreg_s5c_0p752";
>  			regulator-min-microvolt = <465000>;
>  			regulator-max-microvolt = <1050000>;
>  		};
>  
>  		vreg_s7c_0p752: smps7 {
> +			regulator-name = "vreg_s7c_0p752";
>  			regulator-min-microvolt = <465000>;
>  			regulator-max-microvolt = <800000>;
>  		};
>  
>  		vreg_s9c_1p084: smps9 {
> +			regulator-name = "vreg_s9c_1p084";
>  			regulator-min-microvolt = <1010000>;
>  			regulator-max-microvolt = <1170000>;
>  		};
>  
>  		vreg_l1c_1p8: ldo1 {
> +			regulator-name = "vreg_l1c_1p8";
>  			regulator-min-microvolt = <1800000>;
>  			regulator-max-microvolt = <1980000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l2c_1p62: ldo2 {
> +			regulator-name = "vreg_l2c_1p62";
>  			regulator-min-microvolt = <1620000>;
>  			regulator-max-microvolt = <1980000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l3c_2p8: ldo3 {
> +			regulator-name = "vreg_l3c_2p8";
>  			regulator-min-microvolt = <2800000>;
>  			regulator-max-microvolt = <3540000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l4c_1p62: ldo4 {
> +			regulator-name = "vreg_l4c_1p62";
>  			regulator-min-microvolt = <1620000>;
>  			regulator-max-microvolt = <3300000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l5c_1p62: ldo5 {
> +			regulator-name = "vreg_l5c_1p62";
>  			regulator-min-microvolt = <1620000>;
>  			regulator-max-microvolt = <3300000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l6c_2p96: ldo6 {
> +			regulator-name = "vreg_l6c_2p96";
>  			regulator-min-microvolt = <1650000>;
>  			regulator-max-microvolt = <3544000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l7c_3p0: ldo7 {
> +			regulator-name = "vreg_l7c_3p0";
>  			regulator-min-microvolt = <3000000>;
>  			regulator-max-microvolt = <3544000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l8c_1p62: ldo8 {
> +			regulator-name = "vreg_l8c_1p62";
>  			regulator-min-microvolt = <1620000>;
>  			regulator-max-microvolt = <2000000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l9c_2p96: ldo9 {
> +			regulator-name = "vreg_l9c_2p96";
>  			regulator-min-microvolt = <2700000>;
>  			regulator-max-microvolt = <35440000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l10c_0p88: ldo10 {
> +			regulator-name = "vreg_l10c_0p88";
>  			regulator-min-microvolt = <720000>;
>  			regulator-max-microvolt = <1050000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l11c_2p8: ldo11 {
> +			regulator-name = "vreg_l11c_2p8";
>  			regulator-min-microvolt = <2800000>;
>  			regulator-max-microvolt = <3544000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l12c_1p65: ldo12 {
> +			regulator-name = "vreg_l12c_1p65";
>  			regulator-min-microvolt = <1650000>;
>  			regulator-max-microvolt = <2000000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_l13c_2p7: ldo13 {
> +			regulator-name = "vreg_l13c_2p7";
>  			regulator-min-microvolt = <2700000>;
>  			regulator-max-microvolt = <3544000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
>  		vreg_bob_3p296: bob {
> +			regulator-name = "vreg_bob_3p296";
>  			regulator-min-microvolt = <3008000>;
>  			regulator-max-microvolt = <3960000>;
>  		};
> -- 
> 2.25.1
> 
> 

