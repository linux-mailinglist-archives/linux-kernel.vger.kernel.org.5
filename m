Return-Path: <linux-kernel+bounces-98547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8494C877BD6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C1628130A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2926E125B4;
	Mon, 11 Mar 2024 08:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WKNg6Bgb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CD91173F;
	Mon, 11 Mar 2024 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710146578; cv=none; b=rZKzAuDpn/WJLnk3TaVE8FYG/eWhb8YNLw3/nJT65TDtQrmHyinmLSgy+6f1QXshYIWN78IG/XG4Cv33c5iBAelOUN6iQJmXpoAIwhk04eMSCaFeKTdgTbF/SvfvJMP+GkUMD1F9VRur9nHUWeNFK7yFFL3cnM/x7/PwR9OeEA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710146578; c=relaxed/simple;
	bh=nFtFkNNeWFq1qGq8aKTKJOBUm95N5gYay+CiAaz/Bqg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=d4rlNAL/nVWbEdPiqW07sDfQ/ddXHaOyHMsAQ7i83UrFONHRJmBDzTQDP3mN5yfBkxkKtSBOsAuRVrWg8Jxcv0tDnFN1OC0+0gKH+z09VkBDJUcmOjLzVQtkcK4wRF9kvHDczV37rUItyv7Siw/LrAj4lM5FjiFl7eEXp7GXNGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WKNg6Bgb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B4Yabx026682;
	Mon, 11 Mar 2024 08:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:subject:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=rbBiPLaD7aT3pY+ebUIPfAuhH4QRqD2CZRFmflsXf9M=; b=WK
	Ng6BgbP0xIueqP9GSkcMWYNp7L+m/wHtET7b9bXiO0yDS7mNCCOmQP52fCYzqwXg
	PvF5CMTTmyVl0Wu3nd/U7efHMIsmewKVYHpT64uhGOLjxwtQE4TsYQ5cME6+qGHD
	IUTVpXeoBvEIQRgQb0wHYNSUuKy7U6yzUwq2NzecS8mjonOw41nO1YItxspbCMDE
	5wiFyW7l7z8L5IVTwBhvexoGyS7Lo9oZWC8dBIq6NjsoXk+2axp10JTYPU/5epNu
	HFOPt3q4K0rsHc49vjYyxJMLkLP1f6Ba1/QZWYtS8M7zN9EjuYMA2ReSes8vJLv3
	d5gmYGs5kUuTAm8qvHAg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wssgv8hd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 08:42:21 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42B8gLgo012316
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 08:42:21 GMT
Received: from [10.214.66.253] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 11 Mar
 2024 01:42:14 -0700
Message-ID: <2b0d8c5b-7e79-41ff-bc57-003d1b947c16@quicinc.com>
Date: Mon, 11 Mar 2024 14:12:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
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
 <201fef09-50ab-436b-af63-4535c7510d15@quicinc.com>
 <20240221132101.GB7273@willie-the-truck>
Content-Language: en-US
In-Reply-To: <20240221132101.GB7273@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D7s9_4USJISRv-v30YVnG93YgSELK_Bw
X-Proofpoint-ORIG-GUID: D7s9_4USJISRv-v30YVnG93YgSELK_Bw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_04,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 clxscore=1011 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403110064



On 2/21/2024 6:51 PM, Will Deacon wrote:
> On Wed, Feb 21, 2024 at 02:25:26PM +0530, Bibek Kumar Patro wrote:
>> On 2/13/2024 7:17 PM, Will Deacon wrote:
>>> On Tue, Jan 23, 2024 at 08:15:42PM +0530, Bibek Kumar Patro wrote:
>>>> Add ACTLR data table for SM8550 along with support for
>>>> same including SM8550 specific implementation operations.
>>>>
>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>>>> ---
>>>>    drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 90 ++++++++++++++++++++++
>>>>    1 file changed, 90 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> index 6004c6d9a7b2..db15b1eade97 100644
>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> @@ -23,6 +23,86 @@
>>>>
>>>>    #define CPRE			(1 << 1)
>>>>    #define CMTLB			(1 << 0)
>>>> +#define PREFETCH_SHIFT		8
>>>> +#define PREFETCH_DEFAULT	0
>>>> +#define PREFETCH_SHALLOW	(1 << PREFETCH_SHIFT)
>>>> +#define PREFETCH_MODERATE	(2 << PREFETCH_SHIFT)
>>>> +#define PREFETCH_DEEP		(3 << PREFETCH_SHIFT)
>>>> +#define PREFETCH_SWITCH_GFX	(5 << 3)
>>>> +
>>>> +static const struct actlr_config sm8550_apps_actlr_cfg[] = {
>>>> +	{ 0x18a0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
>>>> +	{ 0x18e0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
>>>> +	{ 0x0800, 0x0020, PREFETCH_DEFAULT | CMTLB },
>>>> +	{ 0x1800, 0x00c0, PREFETCH_DEFAULT | CMTLB },
>>>> +	{ 0x1820, 0x0000, PREFETCH_DEFAULT | CMTLB },
>>>> +	{ 0x1860, 0x0000, PREFETCH_DEFAULT | CMTLB },
>>>> +	{ 0x0c01, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +	{ 0x0c02, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +	{ 0x0c03, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +	{ 0x0c04, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +	{ 0x0c05, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +	{ 0x0c06, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
>>>
>>> [...]
>>>
>>> Isn't this effectively hard-coding the topology of the SoC in the driver?
>>> Wouldn't it better describing higher-level prefetch properties in the DT
>>> nodes corresponding to the upstream devices?
>>
>> Since prefetch data stored in this table represent settings for the
>> ACTLR register, and doesn't exactly define the hardware (So in this
>> manner prefetch data won't exactly be a part of soc topology ?).
> 
> The first two columns of the table are StreamID/Mask pairs, no? How is that
> _not_ the SoC topology? I really think it would be better to define some
> high-level prefetch properties in the DT binding which can be put on the
> master nodes.
> 
>> So it seemed apt not to use the device tree for storing the prefetch
>> property. Hence we reverted from the DT approach (initial proposal in
>> RFC to piggyback on iommus property to store prefetch settings) back to use
>> driver for storing this data.
>>
>> Some drivers use the same approach for storing their platform specific
>> data. Examples being
>> drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>> drivers/soc/qcom/llcc-qcom.c
>> These drivers were taken as reference for storing platform specific ACTLR
>> data.
> 
> I don't know anything about those drivers, but on the SMMU side we already
> have ways to describe the topology in the DT and the driver is using them,
> so I'm struggling to see the need to add these tables as well.
> 
> But as I said before, if Robin and the DT folks prefer this approach,
> then I won't get in the way.
> 

With the driver approach at the current state of patches, it has been 
ACKed by DT folks and it seems there has been no concern/objection from 
Robin till now.
So can this patch go ahead Will?
Let us know Robin of your opinion as well please.

Thanks & regards,
Bibek

> Will

