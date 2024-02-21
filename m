Return-Path: <linux-kernel+bounces-74332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768FC85D2E5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1E09B22EE9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDA33D0AD;
	Wed, 21 Feb 2024 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eGgPG4d4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5693CF79;
	Wed, 21 Feb 2024 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708505769; cv=none; b=KADnIUzhko/v6VZeVQMUWD0Ax0Ainj+I2RAydS6ISOhXKzOEWr2PVKgi6f/WqUQY6Wg04heH0XWlvKbR2qD/7qeXaKHEKCs2x//kDd5Z7uqsy1BZAHBPd7A9lHZAyNtZeQeXBGcYMOoit9ZZVD7JGtO0cIMFtCtdo2wruwL2pJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708505769; c=relaxed/simple;
	bh=t0i7AUpWThgRz90yQislwVsOXiY5R5YW4Bm983CUoE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ov5DTkp32hBynI+vJjMUrNPT46ZgGRh4ask1pHar+wu55IkNGTKJH2I3Spa/+n0Sr/CNQAE1y1/foZixc8qASa5j6WdP4vd+I7LG/OmJH5sYDAFjNYAmDP3V9oY/yXkesx8oECywep+16m3BhIK8Lg0S5MoN3PDoVox30FT7Gkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eGgPG4d4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L1Ddqk022068;
	Wed, 21 Feb 2024 08:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Dh400oD5PMxWwz0r1DmS8UjX2c9zvWlF7BXlLVaLS2I=; b=eG
	gPG4d4E4a3pt3DEYfWeKUw+o1V7KsSg/zjPcEov42OrMFqDYBiRpdcben/Lfg77c
	kK7yhOv+W0ljd3mBvkHlT2tu3TKCDjt3IdYWsMXafeJZczFEmqegNaVY3wkRLHD+
	dZVJuB7dVh7erMOlaasyzXGXKrebgydlaBz60VPYJUVG/Ze92eJNhaug7nDdSTO2
	gsCnYq07ORVaChYtCMSKYpunzFUvslgnivBtgtEQbK/GXn9a9djbXSkkSYHkHefN
	quLjExsnh7vhYjQrIPnEdIrzzI+PgUU0o7EH9rtCGxy1P9iMN8FPCGClZ3TsM/gB
	4vN3Nh7lJ63c1qWkFzXg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wd22u1eu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 08:55:43 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41L8tfJ1009386
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 08:55:41 GMT
Received: from [10.214.66.253] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 00:55:36 -0800
Message-ID: <201fef09-50ab-436b-af63-4535c7510d15@quicinc.com>
Date: Wed, 21 Feb 2024 14:25:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/5] iommu/arm-smmu: add ACTLR data and support for
 SM8550
To: Will Deacon <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <dmitry.baryshkov@linaro.org>,
        <konrad.dybcio@linaro.org>, <jsnitsel@redhat.com>,
        <quic_bjorande@quicinc.com>, <mani@kernel.org>,
        <quic_eberman@quicinc.com>, <robdclark@chromium.org>,
        <u.kleine-koenig@pengutronix.de>, <robh@kernel.org>,
        <vladimir.oltean@nxp.com>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <saravanak@google.com>
References: <20240123144543.9405-1-quic_bibekkum@quicinc.com>
 <20240123144543.9405-5-quic_bibekkum@quicinc.com>
 <20240213134714.GC28926@willie-the-truck>
Content-Language: en-US
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <20240213134714.GC28926@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GH0YrLu6YqU4VmqqS0F4C2itO15lAgA4
X-Proofpoint-ORIG-GUID: GH0YrLu6YqU4VmqqS0F4C2itO15lAgA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1011
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402210069



On 2/13/2024 7:17 PM, Will Deacon wrote:
> On Tue, Jan 23, 2024 at 08:15:42PM +0530, Bibek Kumar Patro wrote:
>> Add ACTLR data table for SM8550 along with support for
>> same including SM8550 specific implementation operations.
>>
>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 90 ++++++++++++++++++++++
>>   1 file changed, 90 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> index 6004c6d9a7b2..db15b1eade97 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> @@ -23,6 +23,86 @@
>>
>>   #define CPRE			(1 << 1)
>>   #define CMTLB			(1 << 0)
>> +#define PREFETCH_SHIFT		8
>> +#define PREFETCH_DEFAULT	0
>> +#define PREFETCH_SHALLOW	(1 << PREFETCH_SHIFT)
>> +#define PREFETCH_MODERATE	(2 << PREFETCH_SHIFT)
>> +#define PREFETCH_DEEP		(3 << PREFETCH_SHIFT)
>> +#define PREFETCH_SWITCH_GFX	(5 << 3)
>> +
>> +static const struct actlr_config sm8550_apps_actlr_cfg[] = {
>> +	{ 0x18a0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
>> +	{ 0x18e0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
>> +	{ 0x0800, 0x0020, PREFETCH_DEFAULT | CMTLB },
>> +	{ 0x1800, 0x00c0, PREFETCH_DEFAULT | CMTLB },
>> +	{ 0x1820, 0x0000, PREFETCH_DEFAULT | CMTLB },
>> +	{ 0x1860, 0x0000, PREFETCH_DEFAULT | CMTLB },
>> +	{ 0x0c01, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
>> +	{ 0x0c02, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
>> +	{ 0x0c03, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
>> +	{ 0x0c04, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
>> +	{ 0x0c05, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
>> +	{ 0x0c06, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> 
> [...]
> 
> Isn't this effectively hard-coding the topology of the SoC in the driver?
> Wouldn't it better describing higher-level prefetch properties in the DT
> nodes corresponding to the upstream devices?

Since prefetch data stored in this table represent settings for the
ACTLR register, and doesn't exactly define the hardware (So in this
manner prefetch data won't exactly be a part of soc topology ?).
So it seemed apt not to use the device tree for storing the prefetch
property. Hence we reverted from the DT approach (initial proposal in
RFC to piggyback on iommus property to store prefetch settings) back to 
use driver for storing this data.

Some drivers use the same approach for storing their platform specific
data. Examples being
drivers/phy/qualcomm/phy-qcom-qmp-combo.c
drivers/soc/qcom/llcc-qcom.c
These drivers were taken as reference for storing platform specific 
ACTLR data.

Thanks & regards,
Bibek

> 
> Looking back at the prior revisions of this series, it seems like others
> were in favour of this approach, so if that's the general consensus, then
> so be it. But is this _really_ what we want in the SMMU driver? It would
> be good to have an Ack from Robin and a DT maintainer on this mechanism.
>
> It just all feels a bit like a step back into the bad old world of
> platform data to me, where we end up trying to maintain a bunch of random
> constants that supposedly make things faster for somebody :/
> > Will

