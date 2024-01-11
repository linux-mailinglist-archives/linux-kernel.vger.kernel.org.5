Return-Path: <linux-kernel+bounces-24019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA1C82B57F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96BF81F2317D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E03456761;
	Thu, 11 Jan 2024 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PEGyhgxD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C1814F7A;
	Thu, 11 Jan 2024 19:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40BDcV7s002400;
	Thu, 11 Jan 2024 19:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+lnLLq7TtR/P4rD+oeQ2l6vvdyl0+p2FDMljpW6W2Wg=; b=PE
	GyhgxD8J8J1+Hq3ddbVARjE+425WyDmuRrGuVBKzTbvbQn6EVj0WfaK3e/t8w3dq
	P8BWDzlO0Gk4FFkrtvmF1DbeCPM8Cn7/9c0BMik4eVoKCQeIY01PMD2WyhDWnyZa
	em/Fd6OXnHw7jlGwa8JBwAm7nZxvDnlS6uqRc5Q1mFJOYlMJF/grKpVbGts7ejmW
	PwaN1XI8X1aR0DJfYC2YwsB3DfPyfdcX0LNBPB/iKRpSXG8M23S2u9dRIMbI2Zq7
	zbvxWUmokC/HbcpjxwHdzwXPuVsTfg8Y7mCd6d0vOLKIgjFI3HSUMKLvIVJVS70q
	owl/zeg+UqsXyoH0Aukg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjckh9ngx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 19:55:42 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40BJtfiG010113
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 19:55:41 GMT
Received: from [10.110.45.184] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 11 Jan
 2024 11:55:40 -0800
Message-ID: <12d6fe9b-4b07-4c67-a18e-92db9d858a9d@quicinc.com>
Date: Thu, 11 Jan 2024 11:55:39 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm64: dts: qcom: sm8650: mark gpio74 as reserved
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
From: Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20240111-topic-sm8650-upstream-qrd-fix-gpio-reserved-v1-0-fad39b4c5def@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iuGBkGpTRV0jC_HYW6Pj3vgvQcVsadhB
X-Proofpoint-GUID: iuGBkGpTRV0jC_HYW6Pj3vgvQcVsadhB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=682 phishscore=0 mlxscore=0
 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110154



On 1/11/2024 8:58 AM, Neil Armstrong wrote:
> The TLMM gpio74 is also used to communicate with the secure NFC
> on-board module, some variants of the SM8650 QRD & MTP boards requires
> this GPIO to be dedicated to the secure firmware and set reserved
> in order to successfully initialize the TLMM GPIOs from HLOS (Linux).
> On the other boards this GPIO is unused so it's still safe to mark
> the GPIO as reserved.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Double checked these and no others currently are also reserved.

Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>

> ---
> Neil Armstrong (2):
>       arm64: dts: qcom: sm8650-qrd: add gpio74 as reserved gpio
>       arm64: dts: qcom: sm8650-mtp: add gpio74 as reserved gpio
> 
>  arch/arm64/boot/dts/qcom/sm8650-mtp.dts | 2 +-
>  arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> ---
> base-commit: bffdfd2e7e63175ae261131a620f809d946cf9a7
> change-id: 20240111-topic-sm8650-upstream-qrd-fix-gpio-reserved-1c3d56c2d3e8
> 
> Best regards,

