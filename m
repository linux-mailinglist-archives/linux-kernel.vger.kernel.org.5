Return-Path: <linux-kernel+bounces-17312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3957B824B47
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9F21C224F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8232D043;
	Thu,  4 Jan 2024 22:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IbdD9WfV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7252D029;
	Thu,  4 Jan 2024 22:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 404Mhfd0010981;
	Thu, 4 Jan 2024 22:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=HptTqmPQ1Pxy0XsGa3EiuulInmHFr8LzcaXL6ybczHA=; b=Ib
	dD9WfVbkslO5ioVWwkPMHulUDcKTFithYgFTvHl0MZoFQB+LQZe7k9KSv+CGyxTi
	IPzT5b+OABbfjxr1X8NLj7U1ccBb5GguXmzvW2Wo0MXh0BBXwd/dD4L5O7GQktFZ
	jQIVHJVIVbboeQcnLFcA/kQ2hlSfQDikSRcp5dRbR/WMtUeWnsFIvUhaS+o3hKte
	yXwLt/bI13Vph07LivpzKuwH5YUNeb86zvuzHFjzyIEXXGpeilzuiqyIrs8Y9voN
	u4+yqMoHzmhAQ/nuSe7tW1Zp3qTr44VIy/WISnZvRfZMQARTE6ugON7qj1TAfNIE
	/R272n7BtKSQ/m6Ksx1A==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ve1sgghj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 22:58:31 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 404MwUIu027484
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jan 2024 22:58:30 GMT
Received: from [10.71.108.105] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 4 Jan
 2024 14:58:29 -0800
Message-ID: <1e9fd6f2-3fdb-4779-b79a-274e51c4cbba@quicinc.com>
Date: Thu, 4 Jan 2024 14:58:29 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] phy: qualcomm: eusb2-repeater: Some fixes after the
 regmap rework
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20240104-phy-qcom-eusb2-repeater-fixes-v1-0-047b7b6b8333@linaro.org>
From: Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20240104-phy-qcom-eusb2-repeater-fixes-v1-0-047b7b6b8333@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OdiNoiUE90c92Fr3UrgSrfVNDcasfR6y
X-Proofpoint-ORIG-GUID: OdiNoiUE90c92Fr3UrgSrfVNDcasfR6y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 spamscore=0 bulkscore=0 mlxscore=0 mlxlogscore=546 impostorscore=0
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401040174



On 1/4/2024 6:52 AM, Abel Vesa wrote:
> Found the first issue (from first patch) while adding support
> for X Elite (X1E80100) which comes with more than one repeaters.
> The second fix is just bonus.
> 

Tested-by: Elliot Berman <quic_eberman@quicinc.com> # sm8650-qrd

> ---
> Abel Vesa (2):
>       phy: qualcomm: eusb2-repeater: Fix the regfields for multiple instances
>       phy: qualcomm: eusb2-repeater: Drop the redundant zeroing
> 
>  drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> ---
> base-commit: 0fef202ac2f8e6d9ad21aead648278f1226b9053
> change-id: 20240104-phy-qcom-eusb2-repeater-fixes-c9201113032c
> 
> Best regards,

