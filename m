Return-Path: <linux-kernel+bounces-85235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 928C986B2B1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C06F28B703
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462681534F4;
	Wed, 28 Feb 2024 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cuJtgoZc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3826D158D95;
	Wed, 28 Feb 2024 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132779; cv=none; b=C01H/oor52q5IogfNAT2a6EVWDnS/AR9wBdhpgzKY47xaMuSTm2WYVA+Q89zHsnrLt8+oLgsSuyFTlfN8QkO53lpsSruu+mfZoD6u+P6yl22VTZtRULqbgyTnKKrmVpX31DQuHSxLTv+iC3TRg9akPQ/VmqChjmkxto5Okglyks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132779; c=relaxed/simple;
	bh=Nhhx092QbZ4h8cC+srBIa9hfIgVvSLuTFr4ASjJywqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BiyW72Zax6n5sk/Ay1aDzDIBZTanQc7OCXePkHAUioQ9s+ljAnQLeNWY2sMwUUo9nXMv+ip46zZshuZlAX6CwmyqSpi8dzVR/dzXxsE/SKfN3aJlgX2XOXm+oVjYIgBIeG3rejhgS6NQG7PoWMpXI3il/eNqyXPdtFW4RFs1db0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cuJtgoZc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S97PuM023466;
	Wed, 28 Feb 2024 15:06:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=HamPLu5eUOVkk8MAjs6EMRDM7eqBMUeCObTL/0iqx0w=; b=cu
	JtgoZczs/l0XVkHmUJLkGhgF1xM3rsq8E9B3Z9v0UR1RKaysxeoRU37xww3swwbS
	VmIbjWSraHGBzCHKbUM6lGNXJHGdiTTYKNccFCx9iqwIWtbTgSfv5iYmp29DCLGg
	XQKeAsnZSjVll90ap6RzE/xZSvZptS9mF9kHZa093i9Dv6/EBgxzL72wOcEGsYyA
	YdCD9oPRCfhcwgywuF60FpRR4HZY7Jo1EWKd8eF8F/HxTUQu2dkBlixVmyngjCjD
	lmYM6anaE0bg28C0F2DrdEc9teOBbFTqS9Eul1xFwZwHL0Uf2xsbMMXFvaf5bemw
	qtG5/wldFK6KZ3vO27oA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whw3f1etd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 15:06:11 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SF6B96020991
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 15:06:11 GMT
Received: from [10.216.40.135] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 07:06:03 -0800
Message-ID: <e7241633-d92f-2ab0-a318-60769c12ed50@quicinc.com>
Date: Wed, 28 Feb 2024 20:36:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/3] Add support for the IPQ5321 SoC
Content-Language: en-US
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        "Rafael
 J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20240228-ipq5321-sku-support-v1-0-14e4d4715f4b@quicinc.com>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20240228-ipq5321-sku-support-v1-0-14e4d4715f4b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9uDMigNbzYUPGiGJlvBZrDgbc1Zc9rfj
X-Proofpoint-GUID: 9uDMigNbzYUPGiGJlvBZrDgbc1Zc9rfj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_07,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=829 spamscore=0
 suspectscore=0 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 mlxscore=0 clxscore=1011 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402280119



On 2/28/2024 8:21 PM, Kathiravan Thirumoorthy wrote:
> IPQ5321 SoC belong to IPQ5332 family. Add the SoC ID and the cpufreq
> support. Maximum cpufreq for IPQ5321 is 1.1GHZ, which is determined
> based on the eFuse.
> 
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

for the series..

-Mukesh

> ---
> Kathiravan Thirumoorthy (3):
>        dt-bindings: arm: qcom,ids: Add SoC ID for IPQ5321
>        soc: qcom: socinfo: Add SoC ID for IPQ5321
>        cpufreq: qcom-nvmem: add support for IPQ5321
> 
>   drivers/cpufreq/qcom-cpufreq-nvmem.c | 1 +
>   drivers/soc/qcom/socinfo.c           | 1 +
>   include/dt-bindings/arm/qcom,ids.h   | 1 +
>   3 files changed, 3 insertions(+)
> ---
> base-commit: 20af1ca418d2c0b11bc2a1fe8c0c88f67bcc2a7e
> change-id: 20240228-ipq5321-sku-support-bd07056d5e01
> 
> Best regards,

