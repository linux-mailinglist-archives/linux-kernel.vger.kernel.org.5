Return-Path: <linux-kernel+bounces-73503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0AB85C392
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD381F21FCC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175427866C;
	Tue, 20 Feb 2024 18:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="btyhhvSs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1376BB3C;
	Tue, 20 Feb 2024 18:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708453428; cv=none; b=JvdGgdhIpIBPfpE77jMMujBXJdRARPDARSx+Uo0zNF9mQxyKpi9DlgPKov9k6UkSjO/sdPtp8U3NhSySMlBMV9MIMXpA2ToqRgGERD7HQ+82TDC5vNi1HT9eahn9dYDw2cAoKZKcjAxJxwKgTb0/7ARDcBmOiOXVhJe2dXAG184=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708453428; c=relaxed/simple;
	bh=gqQmnGNxvTb9NFXdVOZheZnWxzpRLhsYtTeBC/LigWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eu/eY/hWg3V8M129N1FRGdy2GGeZy1qXZ2B83axRpGoFoSBMrY838uxZK9RSqwmLj4hWOAbJiXY6O2Vbo0uydJGK360RE1tmHmXogAv9JU5uuys/iRoZot+aGLX8RFdT9odJ8iOZXirsVEHJLYqdKNxo3ZGaHAtPr9owF9Fyemk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=btyhhvSs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KEfwfb020497;
	Tue, 20 Feb 2024 18:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=o1XdYNJFsleByPwRb4ZMnCZK00p36/1bvaqiNCoD/gU=; b=bt
	yhhvSsIurjApTQz1q3pO6r6anSvSGyQjLtRwm2vlNUqvzwamZLxFvu2kEQ9hHnex
	fpGpK0njHFTv1sKbjwYvKCIxS7G5JBQ76Ov/SDsBC5W/v0spF+0GNetzx3C5vkWf
	MIdcDbygy7bgo6aZSTSdi54IyvHm378I5sWCl78osjtnOSGJlZtnhL/a+PNcNTy3
	rtKF9ZRVerqDTrKX5biMY5euR0TYKIFrjZ2GlN1/uNnbGiRy0Q+/mMGohTuTZhgh
	h7MSXBf5GiK02odM9j+y6MMCVkAkXcIMNohC/lE9fBrfOiCm/EErPZ4MuvUuvs18
	IIQasRBDZHQvv0+v4qAg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wct3eh220-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 18:23:35 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41KINYc7021949
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 18:23:34 GMT
Received: from [10.71.110.119] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 10:23:30 -0800
Message-ID: <38860940-3b21-42e8-8817-10b433d7bd74@quicinc.com>
Date: Tue, 20 Feb 2024 10:23:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dma-buf: heaps: secure_heap: Add qcom secure system
 heap
Content-Language: en-US
To: Pratyush Brahma <quic_pbrahma@quicinc.com>, <sumit.semwal@linaro.org>,
        <benjamin.gaignard@collabora.com>, <Brian.Starkey@arm.com>,
        <jstultz@google.com>, <tjmercier@google.com>,
        <christian.koenig@amd.com>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <quic_guptap@quicinc.com>,
        Dibakar Singh <quic_dibasing@quicinc.com>
CC: Vijayanand Jitta <quic_vjitta@quicinc.com>
References: <cover.1700544802.git.quic_vjitta@quicinc.com>
 <128a84b983d1ddd192e98a42bc6a15030bb60d75.1700544802.git.quic_vjitta@quicinc.com>
From: Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <128a84b983d1ddd192e98a42bc6a15030bb60d75.1700544802.git.quic_vjitta@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: z8qGia9d6ea18w28Y-_e7hFTGe9a0941
X-Proofpoint-GUID: z8qGia9d6ea18w28Y-_e7hFTGe9a0941
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 clxscore=1011 mlxscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200132



On 11/22/2023 5:47 AM, Pratyush Brahma wrote:
> From: Vijayanand Jitta <quic_vjitta@quicinc.com>
> 
> Add secure system for Pixel and Non pixel video usecases, this
> allocates from system heap and secures using qcom_scm_aasign_mem.
                                                        ^^^^^^
                                                        typo
> 
> Change-Id: If0702f85bff651843c6a5c83694043364229e66b
> Signed-off-by: Vijayanand Jitta <quic_vjitta@quicinc.com>

Please get these patches reviewed internally before sending to mailing
list for basic checks. You can review go/upstream when within Qualcomm corp network.

Pavan mentioned S-o-B is incorrect. Commit text should also not have Change-Id.

Please be sure to send to linux-arm-msm mailing list as well since this affects
Qualcomm chipsets

> ---
>  drivers/dma-buf/heaps/secure_heap.c | 163 +++++++++++++++++++++++++++-
>  1 file changed, 160 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma-buf/heaps/secure_heap.c b/drivers/dma-buf/heaps/secure_heap.c
> index 04e2ee000e19..cdcf4b3f5333 100644
> --- a/drivers/dma-buf/heaps/secure_heap.c
> +++ b/drivers/dma-buf/heaps/secure_heap.c
> @@ -58,6 +58,11 @@ enum secure_memory_type {
>  	 * protect it, then the detail memory management also is inside the TEE.
>  	 */
>  	SECURE_MEMORY_TYPE_MTK_CM_CMA	= 2,
> +	/*
> +	 * QCOM secure system heap, use system heap to alloc/free.
> +	 * and use qcom_scm_assign_mem to secure the memory.
> +	 */
> +	SECURE_MEMORY_TYPE_QCOM_SYSTEM	= 3,
>  };
>  
>  struct secure_buffer {
> @@ -69,6 +74,7 @@ struct secure_buffer {
>  	 */
>  	u32				sec_handle;
>  	struct page			*cma_page;
> +	struct sg_table			sg_table;
>  };
>  
>  #define TEE_MEM_COMMAND_ID_BASE_MTK	0x10000
> @@ -329,11 +335,26 @@ static int secure_heap_qcom_secure_memory(struct secure_heap *sec_heap,
>  	next[0].vmid = data->vmid;
>  	next[0].perm = data->perm;
>  
> -
> -	ret = qcom_scm_assign_mem(page_to_phys(sec_buf->cma_page),
> +	if (sec_heap->mem_type == SECURE_MEMORY_TYPE_CMA) {
> +		ret = qcom_scm_assign_mem(page_to_phys(sec_buf->cma_page),
>  				sec_buf->size, &src_perms,
>  				next, 1);
> +	} else if (sec_heap->mem_type == SECURE_MEMORY_TYPE_QCOM_SYSTEM) {
> +		struct sg_table *table;
> +		struct scatterlist *sg;
> +		int i = 0;
> +
> +		table = &sec_buf->sg_table;
> +		for_each_sgtable_sg(table, sg, i) {
> +			struct page *page = sg_page(sg);
>  
> +			ret = qcom_scm_assign_mem(page_to_phys(page),
> +				page_size(page), &src_perms,
> +				next, 1);
> +			if (ret)
> +				break;
> +		}
> +	}
>  	return ret;
>  }
>  
> @@ -347,9 +368,24 @@ static void secure_heap_qcom_unsecure_memory(struct secure_heap *sec_heap,
>  	next[0].vmid = QCOM_SCM_VMID_HLOS;
>  	next[0].perm = QCOM_SCM_PERM_RWX;
>  
> -	qcom_scm_assign_mem(page_to_phys(sec_buf->cma_page),
> +	if (sec_heap->mem_type == SECURE_MEMORY_TYPE_CMA) {
> +		qcom_scm_assign_mem(page_to_phys(sec_buf->cma_page),
>  				sec_buf->size, &src_perms,
>  				next, 1);
> +	} else if (sec_heap->mem_type == SECURE_MEMORY_TYPE_QCOM_SYSTEM) {
> +		struct sg_table *table;
> +		struct scatterlist *sg;
> +		int i = 0;
> +
> +		table = &sec_buf->sg_table;
> +		for_each_sgtable_sg(table, sg, i) {
> +			struct page *page = sg_page(sg);
> +
> +			qcom_scm_assign_mem(page_to_phys(page),
> +				page_size(page), &src_perms,
> +				next, 1);
> +		}
> +	}
>  }
>  
>  const struct secure_heap_prv_data qcom_cma_sec_mem_data = {
> @@ -361,6 +397,117 @@ const struct secure_heap_prv_data qcom_cma_sec_mem_data = {
>  	.unsecure_the_memory    = secure_heap_qcom_unsecure_memory,
>  };
>  
> +/* Using system heap allocator */
> +#define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO)
> +#define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
> +				| __GFP_NORETRY) & ~__GFP_RECLAIM) \
> +				| __GFP_COMP)
> +static gfp_t order_flags[] = {HIGH_ORDER_GFP, HIGH_ORDER_GFP, LOW_ORDER_GFP};
> +static const unsigned int orders[] = {8, 4, 0};
> +#define NUM_ORDERS ARRAY_SIZE(orders)
> +
> +static struct page *alloc_largest_available(unsigned long size,
> +					    unsigned int max_order)
> +{
> +	struct page *page;
> +	int i;
> +
> +	for (i = 0; i < NUM_ORDERS; i++) {
> +		if (size <  (PAGE_SIZE << orders[i]))
> +			continue;
> +		if (max_order < orders[i])
> +			continue;
> +
> +		page = alloc_pages(order_flags[i], orders[i]);
> +		if (!page)
> +			continue;
> +		return page;
> +	}
> +	return NULL;
> +}
> +
> +static int qcom_system_secure_memory_allocate(struct secure_heap *sec_heap,
> +				      struct secure_buffer *sec_buf)
> +{
> +	unsigned long size_remaining = sec_buf->size;
> +	unsigned int max_order = orders[0];
> +	struct sg_table *table;
> +	struct scatterlist *sg;
> +	struct list_head pages;
> +	struct page *page, *tmp_page;
> +	int i = 0, ret = -ENOMEM;
> +
> +	INIT_LIST_HEAD(&pages);
> +	while (size_remaining > 0) {
> +		/*
> +		 * Avoid trying to allocate memory if the process
> +		 * has been killed by SIGKILL
> +		 */
> +		if (fatal_signal_pending(current)) {
> +			return -EINTR;
> +		}
> +
> +		page = alloc_largest_available(size_remaining, max_order);
> +		if (!page)
> +			goto free;
> +
> +		list_add_tail(&page->lru, &pages);
> +		size_remaining -= page_size(page);
> +		max_order = compound_order(page);
> +		i++;
> +	}
> +	table = &sec_buf->sg_table;
> +	if (sg_alloc_table(table, i, GFP_KERNEL))
> +		goto free;
> +
> +	sg = table->sgl;
> +	list_for_each_entry_safe(page, tmp_page, &pages, lru) {
> +		sg_set_page(sg, page, page_size(page), 0);
> +		sg = sg_next(sg);
> +		list_del(&page->lru);
> +	}
> +	return 0;
> +free:
> +	list_for_each_entry_safe(page, tmp_page, &pages, lru)
> +		__free_pages(page, compound_order(page));
> +
> +	return ret;
> +}
> +
> +static void qcom_system_secure_memory_free(struct secure_heap *sec_heap,
> +				   struct secure_buffer *sec_buf)
> +{
> +	struct sg_table *table;
> +	struct scatterlist *sg;
> +	int i;
> +
> +	table = &sec_buf->sg_table;
> +	for_each_sgtable_sg(table, sg, i) {
> +		struct page *page = sg_page(sg);
> +
> +		__free_pages(page, compound_order(page));
> +	}
> +	sg_free_table(table);
> +}
> +
> +const struct secure_heap_prv_data qcom_system_pixel_sec_mem_data = {
> +	.vmid           = QCOM_SCM_VMID_CP_PIXEL,
> +	.perm		= QCOM_SCM_PERM_RW,
> +	.memory_alloc	= qcom_system_secure_memory_allocate,
> +	.memory_free	= qcom_system_secure_memory_free,
> +	.secure_the_memory	= secure_heap_qcom_secure_memory,
> +	.unsecure_the_memory	= secure_heap_qcom_unsecure_memory,
> +};
> +
> +const struct secure_heap_prv_data qcom_system_non_pixel_sec_mem_data = {
> +	.vmid           = QCOM_SCM_VMID_CP_NON_PIXEL,
> +	.perm		= QCOM_SCM_PERM_RW,
> +	.memory_alloc	= qcom_system_secure_memory_allocate,
> +	.memory_free	= qcom_system_secure_memory_free,
> +	.secure_the_memory	= secure_heap_qcom_secure_memory,
> +	.unsecure_the_memory	= secure_heap_qcom_unsecure_memory,
> +};
> +
>  static int secure_heap_secure_memory_allocate(struct secure_heap *sec_heap,
>  					      struct secure_buffer *sec_buf)
>  {
> @@ -585,6 +732,16 @@ static struct secure_heap secure_heaps[] = {
>  		.mem_type	= SECURE_MEMORY_TYPE_MTK_CM_CMA,
>  		.data		= &mtk_sec_mem_data_cma,
>  	},
> +	{
> +		.name		= "secure_system_pixel",
> +		.mem_type	= SECURE_MEMORY_TYPE_QCOM_SYSTEM,
> +		.data		= &qcom_system_pixel_sec_mem_data,
> +	},
> +	{
> +		.name		= "secure_system_non_pixel",
> +		.mem_type	= SECURE_MEMORY_TYPE_QCOM_SYSTEM,
> +		.data		= &qcom_system_non_pixel_sec_mem_data,
> +	},
>  };
>  
>  static int __init secure_cma_init(struct reserved_mem *rmem)

