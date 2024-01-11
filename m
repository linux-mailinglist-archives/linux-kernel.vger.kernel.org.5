Return-Path: <linux-kernel+bounces-23990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898DF82B4D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4120B23196
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAE553E28;
	Thu, 11 Jan 2024 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HMR9BZAA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AA615E9B;
	Thu, 11 Jan 2024 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40BCjVc0024397;
	Thu, 11 Jan 2024 18:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=M6dSsxI5b1GoasriyNGDw+EBcG03gCHOu1sd3MerZdU=; b=HM
	R9BZAAd2mLb1SZIWc0OIkn+JHEi6mdgCJKbxHJS05rsG3bMMx7amF2RXT4wMeTSJ
	Uq2zI6UDReXBhsDHPqMXGfp4YkogCfdF1eKde2kzUjo60L3S5TFmpEUOvk8iks88
	fP6d1Wvo+skXyADrriExpdqKviiGNV3R/mHOVVijrXhDf8PnwKICKzD2ct33iMQn
	qXENHR1sA+ILpeyO15OBLp6GK0Oz1PlbomrNgZoRBsQUVJjjP8EBmQ5RSfxxksQz
	Eh54AO3sspgIoVVEk5JMbmEJ7JKd8y+EES0SWxtrHjkTnuWiUYY/YjA4s85QR3OK
	6b85JEbvtiZqmLuotr7w==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjckh9e3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 18:40:01 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40BIe0cH031515
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 18:40:00 GMT
Received: from [10.251.44.162] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 11 Jan
 2024 10:39:58 -0800
Message-ID: <7079629a-0226-4bf8-87b9-721bb46439b2@quicinc.com>
Date: Thu, 11 Jan 2024 20:39:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8650-mtp: add gpio74 as reserved
 gpio
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Georgi Djakov <djakov@kernel.org>
References: <20240111-topic-sm8650-upstream-qrd-fix-gpio-reserved-v1-0-fad39b4c5def@linaro.org>
 <20240111-topic-sm8650-upstream-qrd-fix-gpio-reserved-v1-2-fad39b4c5def@linaro.org>
From: Georgi Djakov <quic_c_gdjako@quicinc.com>
In-Reply-To: <20240111-topic-sm8650-upstream-qrd-fix-gpio-reserved-v1-2-fad39b4c5def@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ki6ShOKvoRNMszexSP4W1pmn6Z04h_pZ
X-Proofpoint-GUID: Ki6ShOKvoRNMszexSP4W1pmn6Z04h_pZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=771 phishscore=0 mlxscore=0
 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110146

On 1/11/2024 6:58 PM, Neil Armstrong wrote:
> The TLMM gpio74 is also used to communicate with the secure NFC
> on-board module, some variants of the SM8650-MTP board requires
> this GPIO to be dedicated to the secure firmware and set reserved
> in order to successfully initialize the TLMM GPIOs from HLOS (Linux).
> On the other boards this GPIO is unused so it's still safe to mark
> the GPIO as reserved.
> 
> Fixes: 6fbdb3c1fac7 ("arm64: dts: qcom: sm8650: add initial SM8650 MTP dts")
> Reported-by: Georgi Djakov <djakov@kernel.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

The SM8650-MTP board boots successfully with this patch. Thanks Neil!

Tested-by: Georgi Djakov <quic_c_gdjako@quicinc.com>

> ---
>  arch/arm64/boot/dts/qcom/sm8650-mtp.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
> index 9d916edb1c73..be133a3d5cbe 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
> @@ -622,7 +622,7 @@ right_spkr: speaker@0,1 {
>  
>  &tlmm {
>  	/* Reserved I/Os for NFC */
> -	gpio-reserved-ranges = <32 8>;
> +	gpio-reserved-ranges = <32 8>, <74 1>;
>  
>  	disp0_reset_n_active: disp0-reset-n-active-state {
>  		pins = "gpio133";
> 


