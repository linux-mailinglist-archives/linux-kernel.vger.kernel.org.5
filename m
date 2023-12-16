Return-Path: <linux-kernel+bounces-2333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98370815B2E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 20:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22726285E8D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 19:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B85328BF;
	Sat, 16 Dec 2023 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q5gjwLzh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE15328A2;
	Sat, 16 Dec 2023 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BGJ0D51015126;
	Sat, 16 Dec 2023 19:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bvlk/9qtEMVAepuiNyaBJlqUGz8MCCPfE1zt4TcIcEE=; b=Q5
	gjwLzh28boUyqGUsxEzDWUSyfUhE7FNkhBYjN+R9XkZZK7Hg5TUKjDzemq6XPqQf
	iXmXI8yPJHsEZoLlGek1MQ+GTp7i8dQEd/eKyJ69yuXvYJisd+9Vld2zGuz1btR9
	T2+mUTsIM+jEkNg5DBl7O5aMaujqdI25XH9MDyPcVaE27ZC7RX7rXZHUQwinrjyl
	QFf1Km2ttBXOD36utdX/GxFdfLXPNOGjEeheLUbMzFdMmtDnCdFXI+/131qKoSHO
	35uu5VlOXScA2uI5lszXUWETpzSNqzCVmGhXj+rqHZbLLTCRXXdO5tYa0ecAtL4/
	L/6jHGZux+xJfWYpQHXw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v152q90et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 19:00:16 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BGJ0Fo2027068
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 19:00:15 GMT
Received: from [10.216.0.181] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 16 Dec
 2023 11:00:08 -0800
Message-ID: <aec86af5-1170-4fc4-9986-879c61fc8633@quicinc.com>
Date: Sun, 17 Dec 2023 00:29:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/13] firmware: qcom: add a dedicated TrustZone buffer
 allocator
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh
	<quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        "Maximilian
 Luz" <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        "Srini
 Kandagatla" <srinivas.kandagatla@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@quicinc.com>,
        "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>
References: <20231127141600.20929-1-brgl@bgdev.pl>
 <20231127141600.20929-3-brgl@bgdev.pl>
From: Om Prakash Singh <quic_omprsing@quicinc.com>
In-Reply-To: <20231127141600.20929-3-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JkGTh7Y17o2GPV2akbWlBsAMszaGhK8b
X-Proofpoint-GUID: JkGTh7Y17o2GPV2akbWlBsAMszaGhK8b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1011 malwarescore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160146



On 11/27/2023 7:45 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We have several SCM calls that require passing buffers to the TrustZone
> on top of the SMC core which allocates memory for calls that require
> more than 4 arguments.
> 
> Currently every user does their own thing which leads to code
> duplication. Many users call dma_alloc_coherent() for every call which
> is terribly unperformant (speed- and size-wise).
> 
> Provide a set of library functions for creating and managing pool of
> memory which is suitable for sharing with the TrustZone, that is:
> page-aligned, contiguous and non-cachable as well as provides a way of
> mapping of kernel virtual addresses to physical space.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
> ---
>   drivers/firmware/qcom/Kconfig            |  19 ++
>   drivers/firmware/qcom/Makefile           |   1 +
>   drivers/firmware/qcom/qcom_tzmem.c       | 302 +++++++++++++++++++++++
>   drivers/firmware/qcom/qcom_tzmem.h       |  13 +
>   include/linux/firmware/qcom/qcom_tzmem.h |  28 +++
>   5 files changed, 363 insertions(+)
>   create mode 100644 drivers/firmware/qcom/qcom_tzmem.c
>   create mode 100644 drivers/firmware/qcom/qcom_tzmem.h
>   create mode 100644 include/linux/firmware/qcom/qcom_tzmem.h
> 
> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> index 3f05d9854ddf..b80269a28224 100644
> --- a/drivers/firmware/qcom/Kconfig
> +++ b/drivers/firmware/qcom/Kconfig
> @@ -9,6 +9,25 @@ menu "Qualcomm firmware drivers"
>   config QCOM_SCM
>   	tristate
>   
> +config QCOM_TZMEM
> +	tristate
> +
> +choice
> +	prompt "TrustZone interface memory allocator mode"
> +	default QCOM_TZMEM_MODE_DEFAULT
> +	help
> +	  Selects the mode of the memory allocator providing memory buffers of
> +	  suitable format for sharing with the TrustZone. If in doubt, select
> +	  'Default'.
> +
> +config QCOM_TZMEM_MODE_DEFAULT
> +	bool "Default"
> +	help
> +	  Use the default allocator mode. The memory is page-aligned, non-cachable
> +	  and contiguous.
> +
> +endchoice
> +
>   config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
>   	bool "Qualcomm download mode enabled by default"
>   	depends on QCOM_SCM
> diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
> index c9f12ee8224a..0be40a1abc13 100644
> --- a/drivers/firmware/qcom/Makefile
> +++ b/drivers/firmware/qcom/Makefile
> @@ -5,5 +5,6 @@
>   
>   obj-$(CONFIG_QCOM_SCM)		+= qcom-scm.o
>   qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
> +obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
>   obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
>   obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
> diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
> new file mode 100644
> index 000000000000..44a062f2abd4
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_tzmem.c
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Memory allocator for buffers shared with the TrustZone.
> + *
> + * Copyright (C) 2023 Linaro Ltd.
> + */
> +
> +#include <linux/bug.h>
> +#include <linux/cleanup.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/firmware/qcom/qcom_tzmem.h>
> +#include <linux/genalloc.h>
> +#include <linux/gfp.h>
> +#include <linux/mm.h>
> +#include <linux/radix-tree.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +#include "qcom_tzmem.h"
> +
> +struct qcom_tzmem_pool {
> +	void *vbase;
> +	dma_addr_t pbase;
> +	size_t size;
> +	struct gen_pool *pool;
> +	void *priv;
priv is not being using any where.
> +};
> +
> +struct qcom_tzmem_chunk {
> +	phys_addr_t paddr;
> +	size_t size;
> +	struct qcom_tzmem_pool *owner;
Is it okay to use "pool" for this data member?
> +};
> +
> +static struct device *qcom_tzmem_dev;
> +static RADIX_TREE(qcom_tzmem_chunks, GFP_ATOMIC);
> +static DEFINE_SPINLOCK(qcom_tzmem_chunks_lock);
> +
> +#if IS_ENABLED(CONFIG_QCOM_TZMEM_MODE_DEFAULT)
> +
> +static int qcom_tzmem_init(void)
> +{
> +	return 0;
> +}
> +
> +static int qcom_tzmem_init_pool(struct qcom_tzmem_pool *pool)
> +{
> +	return 0;
> +}
> +
> +static void qcom_tzmem_cleanup_pool(struct qcom_tzmem_pool *pool)
> +{
> +
> +}
> +
> +#endif /* CONFIG_QCOM_TZMEM_MODE_DEFAULT */
> +
> +/**
> + * qcom_tzmem_pool_new() - Create a new TZ memory pool.
> + * @size: Size of the new pool in bytes.
> + *
> + * Create a new pool of memory suitable for sharing with the TrustZone.
> + *
> + * Must not be used in atomic context.
> + *
> + * Returns:
> + * New memory pool address or ERR_PTR() on error.
> + */
> +struct qcom_tzmem_pool *qcom_tzmem_pool_new(size_t size)
> +{
> +	struct qcom_tzmem_pool *pool;
> +	int ret = -ENOMEM;
> +
> +	if (!size)
> +		return ERR_PTR(-EINVAL);
> +
> +	size = PAGE_ALIGN(size);
> +
> +	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
> +	if (!pool)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pool->size = size;
> +
> +	pool->vbase = dma_alloc_coherent(qcom_tzmem_dev, size, &pool->pbase,
> +					 GFP_KERNEL);
> +	if (!pool->vbase)
> +		goto err_kfree_pool;
> +
> +	pool->pool = gen_pool_create(PAGE_SHIFT, -1);
> +	if (!pool)
> +		goto err_dma_free;
> +
> +	gen_pool_set_algo(pool->pool, gen_pool_best_fit, NULL);
> +
> +	ret = gen_pool_add_virt(pool->pool, (unsigned long)pool->vbase,
> +				(phys_addr_t)pool->pbase, size, -1);
> +	if (ret)
> +		goto err_destroy_genpool;
> +
> +	ret = qcom_tzmem_init_pool(pool);
> +	if (ret)
> +		goto err_destroy_genpool;
> +
> +	return pool;
> +
> +err_destroy_genpool:
> +	gen_pool_destroy(pool->pool);
> +err_dma_free:
> +	dma_free_coherent(qcom_tzmem_dev, size, pool->vbase, pool->pbase);
> +err_kfree_pool:
> +	kfree(pool);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(qcom_tzmem_pool_new);
> +
> +/**
> + * qcom_tzmem_pool_free() - Destroy a TZ memory pool and free all resources.
> + * @pool: Memory pool to free.
> + *
> + * Must not be called if any of the allocated chunks has not been freed.
> + * Must not be used in atomic context.
> + */
> +void qcom_tzmem_pool_free(struct qcom_tzmem_pool *pool)
> +{
> +	struct qcom_tzmem_chunk *chunk;
> +	struct radix_tree_iter iter;
> +	bool non_empty = false;
> +	void __rcu **slot;
> +
> +	if (!pool)
> +		return;
> +
> +	qcom_tzmem_cleanup_pool(pool);
> +
> +	scoped_guard(spinlock_irqsave, &qcom_tzmem_chunks_lock) {
> +		radix_tree_for_each_slot(slot, &qcom_tzmem_chunks, &iter, 0) {
> +			chunk = radix_tree_deref_slot_protected(slot,
> +						&qcom_tzmem_chunks_lock);
> +
> +			if (chunk->owner == pool)
> +				non_empty = true;
> +		}
> +	}
> +
> +	WARN(non_empty, "Freeing TZ memory pool with memory still allocated");
> +
> +	gen_pool_destroy(pool->pool);
> +	dma_free_coherent(qcom_tzmem_dev, pool->size, pool->vbase, pool->pbase);
> +	kfree(pool);
> +}
> +EXPORT_SYMBOL_GPL(qcom_tzmem_pool_free);
> +
> +static void devm_qcom_tzmem_pool_free(void *data)
> +{
> +	struct qcom_tzmem_pool *pool = data;
> +
> +	qcom_tzmem_pool_free(pool);
> +}
> +
> +/**
> + * devm_qcom_tzmem_pool_new() - Managed variant of qcom_tzmem_pool_new().
> + * @dev: Device managing this resource.
> + * @size: Size of the pool in bytes.
> + *
> + * Must not be used in atomic context.
> + *
> + * Returns:
> + * Address of the managed pool or ERR_PTR() on failure.
> + */
> +struct qcom_tzmem_pool *
> +devm_qcom_tzmem_pool_new(struct device *dev, size_t size)
> +{
> +	struct qcom_tzmem_pool *pool;
> +	int ret;
> +
> +	pool = qcom_tzmem_pool_new(size);
> +	if (IS_ERR(pool))
> +		return pool;
> +
> +	ret = devm_add_action_or_reset(dev, devm_qcom_tzmem_pool_free, pool);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return pool;
> +}
> +
> +/**
> + * qcom_tzmem_alloc() - Allocate a memory chunk suitable for sharing with TZ.
> + * @pool: TZ memory pool from which to allocate memory.
> + * @size: Number of bytes to allocate.
> + * @gfp: GFP flags.
> + *
> + * Can be used in any context.
> + *
> + * Returns:
> + * Address of the allocated buffer or NULL if no more memory can be allocated.
> + * The buffer must be released using qcom_tzmem_free().
> + */
> +void *qcom_tzmem_alloc(struct qcom_tzmem_pool *pool, size_t size, gfp_t gfp)
> +{
> +	struct qcom_tzmem_chunk *chunk;
> +	unsigned long vaddr;
> +	int ret;
> +
> +	if (!size)
> +		return NULL;
> +
> +	size = PAGE_ALIGN(size);
> +
> +	chunk = kzalloc(sizeof(*chunk), gfp);
> +	if (!chunk)
> +		return NULL;
> +
> +	vaddr = gen_pool_alloc(pool->pool, size);
> +	if (!vaddr) {
> +		kfree(chunk);
> +		return NULL;
> +	}
> +
> +	chunk->paddr = gen_pool_virt_to_phys(pool->pool, vaddr);
> +	chunk->size = size;
> +	chunk->owner = pool;
> +
> +	scoped_guard(spinlock_irqsave, &qcom_tzmem_chunks_lock) {
> +		ret = radix_tree_insert(&qcom_tzmem_chunks, vaddr, chunk);
> +		if (ret) {
> +			gen_pool_free(pool->pool, vaddr, size);
> +			kfree(chunk);
> +			return NULL;
> +		}
> +	}
> +
> +	return (void *)vaddr;
> +}
> +EXPORT_SYMBOL_GPL(qcom_tzmem_alloc);
> +
> +/**
> + * qcom_tzmem_free() - Release a buffer allocated from a TZ memory pool.
> + * @vaddr: Virtual address of the buffer.
> + *
> + * Can be used in any context.
> + */
> +void qcom_tzmem_free(void *vaddr)
> +{
> +	struct qcom_tzmem_chunk *chunk;
> +
> +	scoped_guard(spinlock_irqsave, &qcom_tzmem_chunks_lock)
> +		chunk = radix_tree_delete_item(&qcom_tzmem_chunks,
> +					       (unsigned long)vaddr, NULL);
> +
> +	if (!chunk) {
> +		WARN(1, "Virtual address %p not owned by TZ memory allocator",
> +		     vaddr);
> +		return;
> +	}
> +
> +	gen_pool_free(chunk->owner->pool, (unsigned long)vaddr, chunk->size);
> +	kfree(chunk);
> +}
> +EXPORT_SYMBOL_GPL(qcom_tzmem_free);
> +
> +/**
> + * qcom_tzmem_to_phys() - Map the virtual address of a TZ buffer to physical.
> + * @vaddr: Virtual address of the buffer allocated from a TZ memory pool.
> + *
> + * Can be used in any context. The address must have been returned by a call
> + * to qcom_tzmem_alloc().
> + *
> + * Returns:
> + * Physical address of the buffer.
> + */
> +phys_addr_t qcom_tzmem_to_phys(void *vaddr)
> +{
> +	struct qcom_tzmem_chunk *chunk;
> +
> +	guard(spinlock_irqsave)(&qcom_tzmem_chunks_lock);
> +
> +	chunk = radix_tree_lookup(&qcom_tzmem_chunks, (unsigned long)vaddr);
> +	if (!chunk)
> +		return 0;
> +
> +	return chunk->paddr;
> +}
> +EXPORT_SYMBOL_GPL(qcom_tzmem_to_phys);
> +
> +int qcom_tzmem_enable(struct device *dev)
> +{
> +	if (qcom_tzmem_dev)
> +		return -EBUSY;
> +
> +	qcom_tzmem_dev = dev;
> +
> +	return qcom_tzmem_init();
> +}
> +EXPORT_SYMBOL_GPL(qcom_tzmem_enable);
> +
> +MODULE_DESCRIPTION("TrustZone memory allocator for Qualcomm firmware drivers");
> +MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/firmware/qcom/qcom_tzmem.h b/drivers/firmware/qcom/qcom_tzmem.h
> new file mode 100644
> index 000000000000..f82f5dc5b7b1
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_tzmem.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2023 Linaro Ltd.
> + */
> +
> +#ifndef __QCOM_TZMEM_PRIV_H
> +#define __QCOM_TZMEM_PRIV_H
> +
> +struct device;
> +
> +int qcom_tzmem_enable(struct device *dev);
> +
> +#endif /* __QCOM_TZMEM_PRIV_H */
> diff --git a/include/linux/firmware/qcom/qcom_tzmem.h b/include/linux/firmware/qcom/qcom_tzmem.h
> new file mode 100644
> index 000000000000..8e7fddab8cb4
> --- /dev/null
> +++ b/include/linux/firmware/qcom/qcom_tzmem.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2023 Linaro Ltd.
> + */
> +
> +#ifndef __QCOM_TZMEM_H
> +#define __QCOM_TZMEM_H
> +
> +#include <linux/cleanup.h>
> +#include <linux/gfp.h>
> +#include <linux/types.h>
> +
> +struct device;
> +struct qcom_tzmem_pool;
qcom_tzmem_pool stucture definition should be moved to header file.
> +
> +struct qcom_tzmem_pool *qcom_tzmem_pool_new(size_t size);
> +void qcom_tzmem_pool_free(struct qcom_tzmem_pool *pool);
> +struct qcom_tzmem_pool *
> +devm_qcom_tzmem_pool_new(struct device *dev, size_t size);
> +
> +void *qcom_tzmem_alloc(struct qcom_tzmem_pool *pool, size_t size, gfp_t gfp);
> +void qcom_tzmem_free(void *ptr);
> +
> +DEFINE_FREE(qcom_tzmem, void *, if (_T) qcom_tzmem_free(_T));
> +
> +phys_addr_t qcom_tzmem_to_phys(void *ptr);
> +
> +#endif /* __QCOM_TZMEM */

