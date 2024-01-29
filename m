Return-Path: <linux-kernel+bounces-42315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693D783FF86
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A65FBB20C22
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12DA4F1F3;
	Mon, 29 Jan 2024 07:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FjXCsnDU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050F74F1EB;
	Mon, 29 Jan 2024 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706515193; cv=none; b=HnttuRoFywnXFFnIGGHyFs9ptweSTgq5p9TRffmHJ/wqWTM/uHZUYXuo5z7uv3zKxcnAWiMw55HNwDEBb0mHtXYbZ+LtcHNd59K04ijKPt2P2AYvyPHySpkkMg8sJGWLaLME2tBJFk4G1oxhtLWLL9WKlwUyk5EsgsfCpET9PIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706515193; c=relaxed/simple;
	bh=plLshtK+RITjGhwATgeoSX0sPilbHGm2+YFolGzoJKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Fmi+qk1dSYq5ePT/PvKOLUOwaqIeFBOxAWDdXpuOsb+E6vktZ5WTZM4fwV5No1Tz+4CIci0Xsd3qNnHrJI+7773IEJ4iNCPs3fSM2uMWtfPF2WrfD0i4nLO5KgldSRo7aQ3DuhXo097Qz2Minm0/8oWzvyZmNXTwEluHech3g5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FjXCsnDU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T6LGGB024238;
	Mon, 29 Jan 2024 07:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=3F1KzcBoJ3XwnLMtZZTe9ubNn9dX0gK9Ma9AZ6lNisc=; b=Fj
	XCsnDUTGvP5K5AQXLrBRxTFiBetgzxCAZOXe+hfuFjRVOyZMaRjdL9yDmb6kvBwH
	ceUmUd+Ow7IO8bJJUUe5VoRH53z1HWDZSCez6rFwgUH2Q1mI6SAIu0dTntGsXoiC
	uLebUWHNgX2pEDWTibmm9DM5V7xiBO2uBTgXsj2Y5DtN9iAipAFkP62kPDzEAIjR
	YChJtsASujc0KFsOs2g3T5fHsV2u6U0lieUfUgv+OiGESx0dsQXiY5aBk48SUNQU
	clwL79/6kFDAA6Yg7HnkmIOzrtpC+n4ML64i4A8mdstRn1PDXPxarc0E2YX/rwRC
	PU/evmHmWKzZlATUVYXA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx3t2gek6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 07:59:42 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T7xf6h001254
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 07:59:41 GMT
Received: from [10.216.17.54] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 28 Jan
 2024 23:59:38 -0800
Message-ID: <139a9abe-75d8-3bda-3ec9-a14a493eb2a9@quicinc.com>
Date: Mon, 29 Jan 2024 13:29:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH 1/1] iommu: Avoid races around default domain allocations
To: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "Robin
 Murphy" <robin.murphy@arm.com>
CC: Charan Teja Kalla <quic_charante@quicinc.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <e605b38a2d40b1e7589e10110c6d3ece35f6af4e.1705571894.git.quic_nprakash@quicinc.com>
Content-Language: en-US
From: Nikhil V <quic_nprakash@quicinc.com>
In-Reply-To: <e605b38a2d40b1e7589e10110c6d3ece35f6af4e.1705571894.git.quic_nprakash@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6voW1mS14NMM2FhN4yqUxB1_OKUJrNtY
X-Proofpoint-GUID: 6voW1mS14NMM2FhN4yqUxB1_OKUJrNtY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_04,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290056



On 1/18/2024 3:41 PM, Nikhil V wrote:
> From: Charan Teja Kalla <quic_charante@quicinc.com>
> 
> This fix is applicable for 6.1 kernel. In latest kernels, this race
> issue is fixed by the patch series [1] and [2]. This fix can be taken
> as alternative instead of backporting the series of patches as these
> seems too intrusive to be picked for stable branches.
> [1] https://lore.kernel.org/all/0-v8-81230027b2fa+9d-iommu_all_defdom_jgg@nvidia.com/
> [2] https://lore.kernel.org/all/0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com/
> 
> A race condition is observed when arm_smmu_device_probe and
> modprobe of client devices happens in parallel. This results
> in the allocation of a new default domain for the iommu group
> even though it was previously allocated and the respective iova
> domain(iovad) was initialized. However, for this newly allocated
> default domain, iovad will not be initialized. As a result, for
> devices requesting dma allocations, this uninitialized iovad will
> be used, thereby causing NULL pointer dereference issue.
> 
> Flow:
> - During arm_smmu_device_probe, bus_iommu_probe() will be called
> as part of iommu_device_register(). This results in the device probe,
> __iommu_probe_device().
> 
> - When the modprobe of the client device happens in parallel, it
> sets up the DMA configuration for the device using of_dma_configure_id(),
> which inturn calls iommu_probe_device(). Later, default domain is
> allocated and attached using iommu_alloc_default_domain() and
> __iommu_attach_device() respectively. It then ends up initializing a
> mapping domain(IOVA domain) and rcaches for the device via
> arch_setup_dma_ops()->iommu_setup_dma_ops().
> 
> - Now, in the bus_iommu_probe() path, it again tries to allocate
> a default domain via probe_alloc_default_domain(). This results in
> allocating a new default domain(along with IOVA domain) via
> __iommu_domain_alloc(). However, this newly allocated IOVA domain
> will not be initialized.
> 
> - Now, when the same client device tries dma allocations via
> iommu_dma_alloc(), it ends up accessing the rcaches of the newly
> allocated IOVA domain, which is not initialized. This results
> into NULL pointer dereferencing.
> 
> Fix this issue by adding a check in iommu_group_alloc_default_domain()
> to see if the iommu_group already has a default domain allocated
> and initialized.
> 
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> Co-developed-by: Nikhil V <quic_nprakash@quicinc.com>
> Signed-off-by: Nikhil V <quic_nprakash@quicinc.com>
> ---
>   drivers/iommu/iommu.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 8b3897239477..99f8cd5af497 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1594,6 +1594,9 @@ static int iommu_group_alloc_default_domain(struct bus_type *bus,
>   {
>   	struct iommu_domain *dom;
>   
> +	if (group->default_domain)
> +		return 0;
> +
>   	dom = __iommu_domain_alloc(bus, type);
>   	if (!dom && type != IOMMU_DOMAIN_DMA) {
>   		dom = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);

Hi,

Gentle ping to have your valuable feedback. This fix is helping us 
downstream without which we see a bunch of kernel crashes.

Thanks
Nikhil V

