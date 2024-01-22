Return-Path: <linux-kernel+bounces-33647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1B5836D88
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 527CBB253D8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE68B4EB31;
	Mon, 22 Jan 2024 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eamRYZ0M"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896C93EA8F;
	Mon, 22 Jan 2024 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939418; cv=none; b=p8bvF2UgXZ7bS8cTig4j0d8St9ozBheIZ76mYzeZrxXZgdD01baHqt2/Jsb8L0Ce9tpKX5El+Rk6P33E9tTgVkWsFOd/vXlCtHt+IrFCKsPaYFwEyt5gytLdbb6A5/9SwSe4158m+gaODX/5hAsbbrlSKNrMbB5mNsmf0DT2c48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939418; c=relaxed/simple;
	bh=QGXSD/SDVZivoaMa5ArrDzQaQVGkjfhExyjmEzM5iSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qLKpjeiFoZKilOuvdodKsaf2qNE8HF9fhBS1khBE5w14ZwnvXcZQAXhxqco1yUsZnnzLTbb0TtwvQnaAcCff52nMkrE+D1Vb1HD5YPemSWtvmly+yKJ7bh0vYrCOh1INz/0rersByvwFyKI/eV+iX07DRSrVKU/q6zOdiPUKZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eamRYZ0M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MDmuNs009117;
	Mon, 22 Jan 2024 16:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Yv75h0rlM5YC4o4po53BdQlfr7U8O8sgTrQ4h1Po+Es=; b=ea
	mRYZ0MKgpcgI6QupiqOlapXMPYmY4KFLiXOPdzNM081H5pZKf0Pi6GxzDFEfJsfF
	6AqQWCc1bp2E0aVbx+AgOHSVfLn3YYHpWiyke5KpB7KaT6kOltYsfMkx+BQkDe/p
	zWLnvOYs4G6i9jhQ7iMkYdRjLaarHv3fREAGmWDgJ6OZmQF/q4ynB5yeurxylJRS
	6SlXf6ab5XnYLL15ymTsi96U59QD+8nzr3JHpgcRW28iL20ZWhsbEa48RdTVZm02
	IGcaiPykh7Et0DX5c2u9QEfOqe66eg/DL06c/cUjAV2pLzotX7g+x3qV+4XMWBTx
	EvRYz30WXQkCr+UZ5NJQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vssjwrae9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 16:03:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MG3JmS017379
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 16:03:19 GMT
Received: from [10.216.24.76] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 22 Jan
 2024 08:03:14 -0800
Message-ID: <ac35936e-2fc0-4ca5-b746-25fa0e31afac@quicinc.com>
Date: Mon, 22 Jan 2024 21:33:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: ipq5018-rdp432-c2: correct board name
To: Ziyang Huang <hzyitc@outlook.com>, <agross@kernel.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <TYZPR01MB55564BE24CE8718DBD4644A2C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <TYZPR01MB55564BE24CE8718DBD4644A2C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AaEfHXUF4EUAUeiBAKduXP-CvRT9BGnR
X-Proofpoint-ORIG-GUID: AaEfHXUF4EUAUeiBAKduXP-CvRT9BGnR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_06,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 mlxlogscore=511
 mlxscore=0 suspectscore=0 clxscore=1011 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220110



On 1/21/2024 6:22 PM, Ziyang Huang wrote:
> According to Qualcomm document:
>    MP03.1 is RDP404
>    RDP432 is MP03.5
> 
> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
> ---
>   arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
> index 074b78d7939c..f7e8b5af6b44 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
>   /*
> - * IPQ5018 MP03.1-C2 board device tree source
> + * IPQ5018 MP03.5-C2 board device tree source


I suggest to use the RDP number itself here...


>    *
>    * Copyright (c) 2023 The Linux Foundation. All rights reserved.
>    */

