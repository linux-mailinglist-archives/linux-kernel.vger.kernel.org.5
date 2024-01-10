Return-Path: <linux-kernel+bounces-22100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC67829938
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B0E3B277FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3CA47A74;
	Wed, 10 Jan 2024 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L9sEmcEL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20945256;
	Wed, 10 Jan 2024 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A8eRnS025173;
	Wed, 10 Jan 2024 11:35:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=zZr3ydscPJEtSmuUGIcDASkCGcSCsQLJWNIpwguKSA8=; b=L9
	sEmcELyrU+GDg3cUoufiRehahIJlEMCzq5uTnBRZF7jD1WT5j6nGYGKBB8IS6zOY
	jFYtgZUN+MivLHCbo2GB9iuTTgkfVLuTwYNv56Jm7sXagl3pnHWSxVXwZlkfoYMn
	R++tfgJ+f2Qixl4uiW/vdpOKu6Gq5r4LYEv/vXxfNH6T0L+1UzuapT9g5OtZy60i
	3wEkKQbHIVB0BmhjkLtLQXkGR0WQ7Wpai/HTsczG6X/stA0aaSwPgZC/49tnjvT+
	rX8QkwFuTfZZOvrFmaRWeAHn5VJzKdS71KP8UWQb9GO92l15OG5xqTR66lW6bffN
	aPtix9i9b635A2da2uZQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhjh2s1eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:35:24 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABZNj3032150
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:35:23 GMT
Received: from [10.214.66.253] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 10 Jan
 2024 03:35:17 -0800
Message-ID: <9d143762-da25-4bdc-b33f-66a03a144c2e@quicinc.com>
Date: Wed, 10 Jan 2024 17:05:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] iommu/arm-smmu: add ACTLR data and support for
 SM8550
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <joro@8bytes.org>,
        <dmitry.baryshkov@linaro.org>, <jsnitsel@redhat.com>,
        <quic_bjorande@quicinc.com>, <mani@kernel.org>,
        <quic_eberman@quicinc.com>, <robdclark@chromium.org>,
        <u.kleine-koenig@pengutronix.de>, <robh@kernel.org>,
        <vladimir.oltean@nxp.com>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <qipl.kernel.upstream@quicinc.com>
References: <20240109114220.30243-1-quic_bibekkum@quicinc.com>
 <20240109114220.30243-5-quic_bibekkum@quicinc.com>
 <45314345-36ba-4d85-9d3b-298de26eb069@linaro.org>
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <45314345-36ba-4d85-9d3b-298de26eb069@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: De980EDPawXSdyqq1M4nDTubxLRsR_An
X-Proofpoint-GUID: De980EDPawXSdyqq1M4nDTubxLRsR_An
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=837 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100094



On 1/10/2024 4:19 PM, Konrad Dybcio wrote:
> 
> 
> On 1/9/24 12:42, Bibek Kumar Patro wrote:
>> Add ACTLR data table for SM8550 along with support for
>> same including SM8550 specific implementation operations.
>>
>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>> ---
> [...]
> 
>> +static const struct actlr_variant sm8550_actlr[] = {
>> +    { sm8550_apps_actlr_cfg, 0x15000000 },
>> +    { sm8550_gfx_actlr_cfg, 0x03da0000 },
>> +    {},
>> +};
> 
> Please use C99 designated initializers and put the address first.
> 

Noted, thanks for this input. Will take care of this in next patch.

Thanks & regards,
Bibek

> Konrad

