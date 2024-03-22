Return-Path: <linux-kernel+bounces-110870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1787886508
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15E8DB216B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B256979CC;
	Fri, 22 Mar 2024 02:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n2ww5tPe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF1E6ABA;
	Fri, 22 Mar 2024 02:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711073389; cv=none; b=LiBlWpb4jsmhdMuzLGIBkWcnhNUog+STOz/SI/UNSxg+n1/MImlGKHxlaEw05xOe/CYu+CgY2TPosk6xb3vluAYlxdp3mUCcDn5OLaWVIUS5DD9oO7xMS5++N8ZL7i7BibM/5tPtCVoeuHrJjpjfApKf15zMd5qn7rlbweevijA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711073389; c=relaxed/simple;
	bh=28UgqqrJiALHfXA47nVVHJe296bE4Shv43fdZnADgWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nb+tRsSA0i/91KJL8cTQjOIAi4+QXy04UukP/OJACtZhcc+T3oe7DlObvIy3HcriD0FhHo4uElmPe9YuS4LpxsgU00HQoOAfP/mQ0gRCbu3OAfzvn3twI52vMnQjQb64LMGv5douq/uFcCa8Opjb2Lb82Z3PqAB6hmpYOaiS+QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n2ww5tPe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42M1QSSV022596;
	Fri, 22 Mar 2024 02:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vNsCjSi1j5/EI3nXw5S3bozjUYto7C8vDTz/nXtktDs=; b=n2
	ww5tPeoLGgGSSRNUVmzWQm7ULj5aNL8OOuoGRfOcnEfCzUwbfXtbZ1lJgrMxHtIU
	r9Q+xrQtscnDqHlk6UIUcgwxtKHE/OfWEiTUWvv5uWagDkGMfjuMzKP4MzUymRkr
	mP+/V2DuMl17ze9BZVpy3JDNCSbAJzmGDsvROUXwmO0mGuJGDyEtt0NvJNgS+AkD
	0kL2pOJhTRrG/S5dfU6dg7mhM28fD2Y3/YnbG+yGFrZQOP/hY0s8zvxuZ2wqJbDC
	GtZu8FCQnl3GSFA2d34rjRw152i2Od4BFbDbECr5AE3AvIVZnI8j/lMedqo3zSGr
	5SJAxRx9DICWUCJnL4Xg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0wy9gch9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 02:09:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42M29bCc001189
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 02:09:37 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Mar
 2024 19:09:35 -0700
Message-ID: <87f0c6c9-43e5-4ea3-8f4c-9425e6a74b10@quicinc.com>
Date: Fri, 22 Mar 2024 10:09:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: workaround to use VMs
Content-Language: en-US
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, <kvalo@kernel.org>,
        <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240321172402.346191-1-jtornosm@redhat.com>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20240321172402.346191-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VZAIN0bIqX9dIjtMgGppOotNdHZwq3oQ
X-Proofpoint-ORIG-GUID: VZAIN0bIqX9dIjtMgGppOotNdHZwq3oQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_14,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403220014



On 3/22/2024 1:23 AM, Jose Ignacio Tornos Martinez wrote:
> Currently, this driver is not working when the device is handled in a
> Virtual Machine (PCI pass-through), as it was already reported here:
> https://lore.kernel.org/all/fc6bd06f-d52b-4dee-ab1b-4bb845cc0b95@quicinc.com/T/
> Baochen Qiang focused the problem and described how to have it working
> for a specific real MSI vector from host that needs to be used in VM too.
> And this value, as it was commented, can change.
> 
> The problem seems complex to me and I don't know if there is any easy way
> to solve it. Meanwhile and using the information from Baochen Qiang,
> since the use of VMs is very interesting for testing procedures,
> I would like to just add this workaround that consists on adding a
> parameter to pass the real MSI vector from host to the VM. In that way,
> checking the 'lscpi' command output from host, it could be handled manually
> or with some user tool in order to have the VM with the driver working.
> Of course, if this parameter is not configured (zero value and default),
> we will have the same behavior as always.
> 
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
>   drivers/net/wireless/ath/ath11k/pci.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
> index be9d2c69cc41..0e322956b10f 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c
> @@ -31,6 +31,11 @@
>   
>   #define TCSR_SOC_HW_SUB_VER	0x1910010
>   
> +static ulong ath11k_host_msi_addr = 0;
> +module_param_named(host_msi_addr, ath11k_host_msi_addr, ulong, 0644);
> +MODULE_PARM_DESC(host_msi_addr,
> +		 "Workaround to configure the MSI address that is used from host in order to be used in VM");
MSI vector contains two parts: the address and the data. So you need to 
add a parameter for MSI data as well.

> +
>   static const struct pci_device_id ath11k_pci_id_table[] = {
>   	{ PCI_VDEVICE(QCOM, QCA6390_DEVICE_ID) },
>   	{ PCI_VDEVICE(QCOM, WCN6855_DEVICE_ID) },
> @@ -443,6 +448,18 @@ static int ath11k_pci_alloc_msi(struct ath11k_pci *ab_pci)
>   
>   	ath11k_pci_msi_disable(ab_pci);
>   
> +	if (ath11k_host_msi_addr) {
> +		ab_pci->ab->pci.msi.ep_base_data = 0;
Here, I guess you are assigning 0 because I gave it in my example. But 
it is not always that, it changes from machine to machine, configuration 
to configuration, and even time to time.

The right way should be to use the MSI data parameter mentioned above.

> +		ab->pci.msi.addr_hi = (u32)(ath11k_host_msi_addr >> 32);
> +		ab->pci.msi.addr_lo = (u32)(ath11k_host_msi_addr & 0xffffffff);
> +
> +		ath11k_dbg(ab, ATH11K_DBG_PCI, "msi addr hi 0x%x lo 0x%x base data is %d\n",
> +			   ab->pci.msi.addr_hi,
> +			   ab->pci.msi.addr_lo,
> +			   ab->pci.msi.ep_base_data);
> +		return 0;
> +	}
> +
>   	msi_desc = irq_get_msi_desc(ab_pci->pdev->irq);
>   	if (!msi_desc) {
>   		ath11k_err(ab, "msi_desc is NULL!\n");
> @@ -482,6 +499,9 @@ static int ath11k_pci_config_msi_data(struct ath11k_pci *ab_pci)
>   {
>   	struct msi_desc *msi_desc;
>   
> +	if (ath11k_host_msi_addr)
> +		return 0;
> +
>   	msi_desc = irq_get_msi_desc(ab_pci->pdev->irq);
>   	if (!msi_desc) {
>   		ath11k_err(ab_pci->ab, "msi_desc is NULL!\n");

