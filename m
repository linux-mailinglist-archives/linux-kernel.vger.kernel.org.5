Return-Path: <linux-kernel+bounces-37905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6874583B777
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209C4281E63
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590731FBF;
	Thu, 25 Jan 2024 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QbMd3ANx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB0E1866;
	Thu, 25 Jan 2024 03:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706151605; cv=none; b=bWjFi/9TSDKc47jQlMTqY/AhrmBXM2qpeh24st2CkBfV4xH5lHBNUWOXbgbsS6K4RubGK441yAGxTg0/clKCwIRQy2MWkNAq3XS/rFQSm7bcRFZGmox6aZo3COA1vReqa1S5qE1QLwJKWRFWLAHFZ2k6jjDS9a98zqFsDpVT0Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706151605; c=relaxed/simple;
	bh=CzCGo2cwBcCnpe1GOqCp97yh7LTPW/HI2epJpINBHwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g5F/jdHuTvFvRFLmzH9RX3HMHcysaM7yPaLosjMnD9uPL7JdIHx/tRyiAQ6/dRu+QDlCE6IEpEU5YBYxvNDcGs3d4VRVgDjtTDwUHhZ1hz3SysIEWVUdj8yHH423x7lxyqj78jl2KO9/OJ7lyizi1Q7bp1This0LU5MZ26qRa6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QbMd3ANx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P2ktLR015835;
	Thu, 25 Jan 2024 02:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=P0bdtGkJXJ10AYPIH4XmGaFlRnPnceLPtZRfk+9/dvs=; b=Qb
	Md3ANxdwA9ak8p0Fu2rcnbgQOx8Dyt5tksj9xzYsGUWsrCdFLfP4FBDzAFCUBb3C
	UqPEjpvEzHl2oS8paF6RMCWgNxXuA7NQmqejbjjMFKbYcqN+U/UBb4Cg9U2G9bR6
	EFvAS/MHiZCSwSAqMPYctJnM8wfBkW9pg62Q5Hkjrxg6ggX0QVqqzgJBFzzHFo+j
	fy4GWrU9erx1ZbvUbpXH6eXyGs9PjJj9IvnsLTyCnkkGMGG3L3K77cY6tJ3cJpgd
	nZzvo/fmi4n8+DygC6DJU+GCbHj5G8Kb4k4xlFPe4kLpVEfI7lomBQEQTqMVG+ld
	npC0LNOtqDpfXa/L1GaQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vu99b0pt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 02:59:53 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40P2xqlW019041
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 02:59:52 GMT
Received: from [10.239.34.220] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 18:59:49 -0800
Message-ID: <0a3f486d-0135-454e-9da6-b888e516a39e@quicinc.com>
Date: Thu, 25 Jan 2024 10:59:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] phy: qcom: qmp-pcie: Update PCIe PHY settings for
 SM8550
To: <neil.armstrong@linaro.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>, <kishon@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>
References: <1703742157-69840-1-git-send-email-quic_qianyu@quicinc.com>
 <e6b8befb-82e8-4803-929c-32e86d1e825a@linaro.org>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <e6b8befb-82e8-4803-929c-32e86d1e825a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QvtK0XzjqVZl3qlEtnNQuGk1Yb5P-uMV
X-Proofpoint-ORIG-GUID: QvtK0XzjqVZl3qlEtnNQuGk1Yb5P-uMV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_12,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=441 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401250020


On 1/24/2024 4:58 PM, neil.armstrong@linaro.org wrote:
> On 28/12/2023 06:42, Qiang Yu wrote:
>> Align PCIe0/PCIe1 PHY settings with SM8550 latest PCIe PHY Hardware
>> Programming Guide.
>>
>> Can Guo (1):
>>    phy: qcom: qmp-pcie: Update PCIe1 PHY settings for SM8550
>>
>> Qiang Yu (1):
>>    phy: qcom: qmp-pcie: Update PCIe0 PHY settings for SM8550
>>
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c             | 20 
>> ++++++++++++++------
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h      |  2 ++
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h   |  2 ++
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h        |  1 +
>>   .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h   |  2 ++
>>   5 files changed, 21 insertions(+), 6 deletions(-)
>>
>
> - On SM8550-HDK:
> # lspci
> 0000:00:00.0 PCI bridge: Qualcomm Device 0113
> 0000:01:00.0 Network controller: Qualcomm Device 1107 (rev 01)
> 0001:00:00.0 PCI bridge: Qualcomm Device 0113
> 0001:01:00.0 Non-Volatile memory controller: Phison Electronics 
> Corporation E12 NVMe Controller (rev 01)
>
>
> # lspci -nvv
> 0000:00:00.0 0604: 17cb:0113 (prog-if 00 [Normal decode])
>         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L0s L1, Exit 
> Latency L0s <4us, L1 <8us
>         LnkSta:    Speed 5GT/s, Width x2
> 0001:00:00.0 0604: 17cb:0113 (prog-if 00 [Normal decode])
>         LnkCap:    Port #0, Speed 16GT/s, Width x2, ASPM L0s L1, Exit 
> Latency L0s <4us, L1 <8us
>         LnkSta:    Speed 8GT/s, Width x2
>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-HDK
>
> - On SM8550-QRD:
> # lspci
> 00:00.0 PCI bridge: Qualcomm Device 0113
> 01:00.0 Network controller: Qualcomm Device 1107 (rev 01)
>
> # lspci -nvv
>         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L0s L1, Exit 
> Latency L0s <4us, L1 <8us
>         LnkSta:    Speed 5GT/s, Width x2
>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
>
> Thanks,
> Neil

Hi Neil,

Thanks for testing this patch. I verified on aim300, did not see speed 
downgrade. Let me have a try on HDK8550.

Thanks,
Qiang


