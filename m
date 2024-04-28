Return-Path: <linux-kernel+bounces-161220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 864088B492D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 04:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61B24B220C4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 02:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B783E10FA;
	Sun, 28 Apr 2024 02:08:42 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF68A59
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 02:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714270122; cv=none; b=JnZNkK0TBVHOqWxo1Ov8UNKauFfdLlfwHsM5yJv8uai7RZokETF2Bubm3aYa0R8EHqrTOGi1e+3fJw+eMhiPCNMxpvCpfuIEcyam6lbt49Ft5Ijs73DX6mVc5vvohnx/dobL27a87ajMW4/1EDqswilOq8SXZHX2h/cgmNuoXfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714270122; c=relaxed/simple;
	bh=sY9d7iZCWewJZB0o112OpLu+XuXr4aUcGYostfUNVDU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sYl04kQqq7fzMNe4IWknOI3ZQp0Re6LTvlHxQx7+iRYHOTr72HTlwLxuAKchNBTQRXn0v+2sy/HifiIhmaZAmRw5BAqtFaYkdcDlXmEIP66vhiKHf757v84Xez6Afq5oCbxckpYoZQ3pAo1zNVAkBZHZf6mJK1p83YpBacxdzOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VRqcl2pfLz4f3khk
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 10:08:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 21F491A08C4
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 10:08:31 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RGcry1mQyydLA--.54849S3;
	Sun, 28 Apr 2024 10:08:30 +0800 (CST)
Subject: Re: [PATCH V3 0/2] iommu/arm-smmu-v3: Add support for ECMDQ register
 mode
To: Tanmay Jagdale <tanmay@marvell.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, nicolinc@nvidia.com,
 mshavit@google.com, baolu.lu@linux.intel.com, thunder.leizhen@huawei.com,
 set_pte_at@outlook.com, smostafa@google.com
Cc: sgoutham@marvell.com, gcherian@marvell.com, jcm@jonmasters.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240425144152.52352-1-tanmay@marvell.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <b1706177-051d-8a82-97a8-3b482be353af@huaweicloud.com>
Date: Sun, 28 Apr 2024 10:08:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240425144152.52352-1-tanmay@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAn+RGcry1mQyydLA--.54849S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4UAF18trW7AF4DAr1DKFg_yoW5GrWfpw
	4fWrZIkr45JFn7AwnxX34kZr98Xr48uFy7tw45W39Yqw1qyry0gr1xKa4rW34kCryaqFnx
	AwnFqayDCr43AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UZ18PUUUUU=
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/



On 2024/4/25 22:41, Tanmay Jagdale wrote:
> Resending the patches by Zhen Lei <thunder.leizhen@huawei.com> that add
> support for SMMU ECMDQ feature.
> 
> Tested this feature on a Marvell SoC by implementing a smmu-test driver.
> This test driver spawns a thread per CPU and each thread keeps sending
> map, table-walk and unmap requests for a fixed duration.
> 
> Using this test driver, we compared ECMDQ vs SMMU with software batching
> support and saw ~5% improvement with ECMDQ. Performance numbers are

This data is similar to the performance simulated by our EMU.

> mentioned below:
> 
>                    Total Requests  Average Requests  Difference
>                                       Per CPU         wrt ECMDQ
> -----------------------------------------------------------------
> ECMDQ                 239286381       2991079
> CMDQ Batch Size 1     228232187       2852902         -4.62%
> CMDQ Batch Size 32    233465784       2918322         -2.43%
> CMDQ Batch Size 64    231679588       2895994         -3.18%
> CMDQ Batch Size 128   233189030       2914862         -2.55%
> CMDQ Batch Size 256   230965773       2887072         -3.48%
> 
> 
> v2 --> v3:
> 1. Rebased on linux 6.9-rc5
> 
> v1 --> v2:

Thanks.

> 1. Drop patch "iommu/arm-smmu-v3: Add arm_smmu_ecmdq_issue_cmdlist() for
> non-shared ECMDQ" in v1
> 2. Drop patch "iommu/arm-smmu-v3: Add support for less than one ECMDQ
> per core" in v1
> 3. Replace rwlock with IPI to support lockless protection against the
> write operation to bit
>    'ERRACK' during error handling and the read operation to bit 'ERRACK'
> during command insertion. 
> 4. Standardize variable names.
> -	struct arm_smmu_ecmdq *__percpu	*ecmdq;
> +	struct arm_smmu_ecmdq *__percpu	*ecmdqs;
> 
> 5. Add member 'iobase' to struct arm_smmu_device to record the start
> physical
>    address of the SMMU, to replace translation operation
> (vmalloc_to_pfn(smmu->base) << PAGE_SHIFT)
> +	phys_addr_t			iobase;
> -	smmu_dma_base = (vmalloc_to_pfn(smmu->base) << PAGE_SHIFT);
> 
> 6. Cancel below union. Whether ECMDQ is enabled is determined only based
> on 'ecmdq_enabled'.
> -	union {
> -		u32			nr_ecmdq;
> -		u32			ecmdq_enabled;
> -	};
> +	u32				nr_ecmdq;
> +	bool				ecmdq_enabled;
> 
> 7. Eliminate some sparse check warnings. For example.
> -	struct arm_smmu_ecmdq *ecmdq;
> +	struct arm_smmu_ecmdq __percpu *ecmdq;
> 
> 
> Zhen Lei (2):
>   iommu/arm-smmu-v3: Add support for ECMDQ register mode
>   iommu/arm-smmu-v3: Ensure that a set of associated commands are
>     inserted in the same ECMDQ
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 261 +++++++++++++++++++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  33 +++
>  2 files changed, 286 insertions(+), 8 deletions(-)
> 

-- 
Regards,
  Zhen Lei


