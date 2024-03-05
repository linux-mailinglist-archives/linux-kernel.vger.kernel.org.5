Return-Path: <linux-kernel+bounces-91812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 654738716F3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2201F21E6B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22167EEE7;
	Tue,  5 Mar 2024 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PgKYhqGN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842027E58F;
	Tue,  5 Mar 2024 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623922; cv=none; b=vBC3/Px+iYjBKtppDYYoYPZFOgQ4Lq0aSsy3j5UDfrUiCWX9YZLVOLBd27lELE2gmB4oic6UNCTh/CUxchXLKYT5Np4oGh9jn9+aPkLxgQfM+zxYEMHYYgWIljPRO8BqgiMER1p/ocsUbTc4adSpMXpVSIRtGRT5cMpAlUVERhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623922; c=relaxed/simple;
	bh=BRmbYPu9uwZv0NohdrzAOM6oEjNLSw62KYQSbPqi+fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qMsO5OtI8dASLs6h4o4r6PB4Rv5WQPtYubx8yWG6sil+z6+epegZJZT9Hh43/0Z6uvTp2DlFIxaciCe2FXz4q8q7Cq+3lpKwcJQawG10qAzoNuANME5e7O6/1wpjptS7LH65Wh6ZtaVOhPSo+1atRAG16INXGjzkyWjjJD993IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PgKYhqGN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4256Jttu014028;
	Tue, 5 Mar 2024 07:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=wMbUenWZaYTavA7xWqeeZ0KV1Px9iK8tI8NYl+N974g=; b=Pg
	KYhqGNpF2CsW4JZ9dfZKfrmXlievESq0K//abrY6QkfE6aV8Fe/udjbdOg4y5B5B
	I9uU2fViG8DMTsH2nqq/J9M9RarVupVZL5yTdcgemUaCkDpfWpigG8WOe74w00hV
	DfJmYLQYUJVgdUBDBry7vNQLoQTizUKQRpIY/VsJhRsqChANVci2ZwRs+fz15IF8
	K+Apd1pVhLvVDfDmvSlR5NvNE9jiSxkm2e9uKy3sGkoluMC7ZyqBsXtOqQSPDwGQ
	d6z8BrNvpbQ7wwhw/cWJLHjVOazj2GAd+ndcAfRuMg1r+3gDWx6F4xZp19V1m63o
	mAEQbSpKSt2UF041OrjA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnx0y04c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 07:31:43 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4257Vgnr031877
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 07:31:42 GMT
Received: from [10.216.18.120] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Mar
 2024 23:31:39 -0800
Message-ID: <6dcf6bc5-e1e5-8388-8bcb-c093a5fb61ed@quicinc.com>
Date: Tue, 5 Mar 2024 13:01:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH RESEND STABLE v6.1] iommu: Avoid races around default
 domain allocations
To: Greg KH <gregkh@linuxfoundation.org>
CC: Charan Teja Kalla <quic_charante@quicinc.com>,
        Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <stable@vger.kernel.org>
References: <cbf1295589bd90083ad6f75a7fbced01f327c047.1708680521.git.quic_nprakash@quicinc.com>
 <2024030403-self-morality-062e@gregkh>
Content-Language: en-US
From: Nikhil V <quic_nprakash@quicinc.com>
In-Reply-To: <2024030403-self-morality-062e@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4JT4wgqE_gix773HeXXQ08JPCQ9hKfZi
X-Proofpoint-ORIG-GUID: 4JT4wgqE_gix773HeXXQ08JPCQ9hKfZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_04,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 mlxlogscore=755 lowpriorityscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050058



On 3/4/2024 6:55 PM, Greg KH wrote:
> On Mon, Mar 04, 2024 at 04:40:50PM +0530, Nikhil V wrote:
>> From: Charan Teja Kalla <quic_charante@quicinc.com>
>>
>> This fix is applicable for LTS kernel, 6.1.y. In latest kernels, this race
>> issue is fixed by the patch series [1] and [2]. The right thing to do here
>> would have been propagating these changes from latest kernel to the stable
>> branch, 6.1.y. However, these changes seems too intrusive to be picked for
>> stable branches. Hence, the fix proposed can be taken as an alternative
>> instead of backporting the patch series.
>> [1] https://lore.kernel.org/all/0-v8-81230027b2fa+9d-iommu_all_defdom_jgg@nvidia.com/
>> [2] https://lore.kernel.org/all/0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com/
>>
>> Issue:
>> A race condition is observed when arm_smmu_device_probe and
>> modprobe of client devices happens in parallel. This results
>> in the allocation of a new default domain for the iommu group
>> even though it was previously allocated and the respective iova
>> domain(iovad) was initialized. However, for this newly allocated
>> default domain, iovad will not be initialized. As a result, for
>> devices requesting dma allocations, this uninitialized iovad will
>> be used, thereby causing NULL pointer dereference issue.
>>
>> Flow:
>> - During arm_smmu_device_probe, bus_iommu_probe() will be called
>> as part of iommu_device_register(). This results in the device probe,
>> __iommu_probe_device().
>>
>> - When the modprobe of the client device happens in parallel, it
>> sets up the DMA configuration for the device using of_dma_configure_id(),
>> which inturn calls iommu_probe_device(). Later, default domain is
>> allocated and attached using iommu_alloc_default_domain() and
>> __iommu_attach_device() respectively. It then ends up initializing a
>> mapping domain(IOVA domain) and rcaches for the device via
>> arch_setup_dma_ops()->iommu_setup_dma_ops().
>>
>> - Now, in the bus_iommu_probe() path, it again tries to allocate
>> a default domain via probe_alloc_default_domain(). This results in
>> allocating a new default domain(along with IOVA domain) via
>> __iommu_domain_alloc(). However, this newly allocated IOVA domain
>> will not be initialized.
>>
>> - Now, when the same client device tries dma allocations via
>> iommu_dma_alloc(), it ends up accessing the rcaches of the newly
>> allocated IOVA domain, which is not initialized. This results
>> into NULL pointer dereferencing.
>>
>> Fix this issue by adding a check in probe_alloc_default_domain()
>> to see if the iommu_group already has a default domain allocated
>> and initialized.
>>
>> Cc: <stable@vger.kernel.org> # see patch description, fix applicable only for 6.1.y
>> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
>> Co-developed-by: Nikhil V <quic_nprakash@quicinc.com>
>> Signed-off-by: Nikhil V <quic_nprakash@quicinc.com>
>> ---
>>   drivers/iommu/iommu.c | 3 +++
>>   1 file changed, 3 insertions(+)
> 
> Why RESEND?  What happened to the first send?
> 
> thanks,
> 
> greg k-h


Hi Greg,

There are no changes as such w.r.t first send, [1]. It is resent to gain 
attention on this patch. Also, we have added a proper Cc: stable tag 
with this patch.


[1] 
https://lore.kernel.org/all/cbf1295589bd90083ad6f75a7fbced01f327c047.1708680521.git.quic_nprakash@quicinc.com/

Thanks
Nikhil V

