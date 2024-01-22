Return-Path: <linux-kernel+bounces-34236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB090837616
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D971C25799
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A1148CCC;
	Mon, 22 Jan 2024 22:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gjzFFOVE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AE44879F;
	Mon, 22 Jan 2024 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705962555; cv=none; b=D66XXeVgiQ7EpJxqbffyvGAXWgvsAD0nYPr6YQbAo+wrShVh6W9vBbUCK+G+L2ofRFak2+oiIWAS9L8sPoGg7bruOSly/Y+K5vi4OYma8IAlJWGnREfgdoCBuiTres1Jzi9lYwLZWaMEtjTlVN48PDxxmbG4vD3OzZ1T9lGaUhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705962555; c=relaxed/simple;
	bh=ltWxxupGNMNLQsnT5so5h2i6ipm5vAjxmjxwS/aZCZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B4m8NHl9ZAO7gS3CHhMYcHyk5bRO7dsJBkpk9eC1DxmF5tXrUOWBwV4enOrb9XpOzLWch5K1LwjB2vWaGY2/Rw7FTKm7n8MzcHNCjkIJsxhXnLjpbXYQN2ipU+8zRkXHJPMu3YVLzKKyPqxuTux72lvm/TyYhOq+xIAFI0LxwT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gjzFFOVE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MJglBa006858;
	Mon, 22 Jan 2024 22:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nxmrZmdSdZTD1wAZj6p5gkCdx09nMtdfhJ16VGucuSk=; b=gj
	zFFOVE4knQ0ljeiZZu39ajUa6A1iaVpC1e/PWLmoXFrZk9qk6EGu5MyIPifV/UvC
	ajDw0qu2Vyyhzya7FK/4MgSH1BNywg6q43x6D9NkJ81bP5qtiJ5OrJIPOuOZzej/
	Zarfeye7ydS5ebKcPi4rs/0WAeVrgZ395AySgeaqUZw70i6I1Nr083HJDXTPzBmH
	dVu/WZL8tgXLrg5ZzSazQxLM92A0Cak6hRJGAKkACJwtCqclYCt81AX++WtuMIvU
	H9cZhdHBaE6UOJ/Ca3gHjf7MHpNfCyiVhlf5qQoNZktDvFodvn563GXuN4/4RzSy
	7MJSvdWC5NPiOtf659RA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vssjws5qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 22:29:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MMT9H0020075
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 22:29:09 GMT
Received: from [10.110.26.199] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 22 Jan
 2024 14:29:08 -0800
Message-ID: <710622f7-fddd-47d6-8a5f-3d2e895571f5@quicinc.com>
Date: Mon, 22 Jan 2024 14:29:07 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [1/4] interconnect: qcom: icc-rpmh: Add QoS config support
Content-Language: en-US
To: Odelu Kukatla <quic_okukatla@quicinc.com>, <georgi.djakov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240122143030.11904-1-quic_okukatla@quicinc.com>
 <20240122143030.11904-2-quic_okukatla@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240122143030.11904-2-quic_okukatla@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3rCOQbn9ju_VvtPgZZ7SVDDiu75iyvWJ
X-Proofpoint-ORIG-GUID: 3rCOQbn9ju_VvtPgZZ7SVDDiu75iyvWJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_11,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 mlxlogscore=987
 mlxscore=0 suspectscore=0 clxscore=1011 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220160

On 1/22/2024 6:30 AM, Odelu Kukatla wrote:
> Introduce support to initialize QoS settings for QNOC platforms.
> 
> Change-Id: I068d49cbcfec5d34c01e5adc930eec72d306ed89
> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
> ---
>  drivers/interconnect/qcom/icc-rpmh.c | 158 +++++++++++++++++++++++++++
>  drivers/interconnect/qcom/icc-rpmh.h |  33 ++++++
>  2 files changed, 191 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> index c1aa265c1f4e..49334065ccfa 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.c
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -1,8 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.

Should all of your copyright changes include 2024?


