Return-Path: <linux-kernel+bounces-30193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A60C8831B40
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DECD1F26676
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2932A25772;
	Thu, 18 Jan 2024 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ILou5m1X"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E2028DAF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705587768; cv=none; b=DEjamTlNEosRuDBYIBUpkqwlnz6cI7lHIxL0xzSnllwecBI/FGoJkN1dUHHxHrPPDYu2t+njVPMBV+bLH6/Afp+O4uDTORE2sIPn71eAr1eiMKLaN1K76rszAPlnlpOWLXYye+hrGVkHtAZ7fPsI/WlZ+iNOMg3yYnk5OWn6tfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705587768; c=relaxed/simple;
	bh=49cNhVsuBMgtJHArJcV1m7agcOAtGe87ch9+R4pb5zg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=ew+8ZJ9P16szUDzNfV8FtIyYo0M1VkkAXfo6dWszDc+fLuSdwXsTRNEzAk+bq5xUpF9+AwZi36k12DboAzik1AK1ndRmF9FZjTMSdGC7Y+qf23ZjcRCosmx7QA/r7owt4U3xpMT99n7NZspyExBx4SeREC7FSWTy4YxUWQpMrCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ILou5m1X; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bd9d8ff8ecso275320b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 06:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1705587765; x=1706192565; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MQmQ57jhPNOOjCerNM6q5F9m10YHH8SVIWhIL9dMZTE=;
        b=ILou5m1XcknExlFgvuQEeMGTFxLeGkRm+sqshwCGCyyv6D5IO9Ho4V4NjUyUD/j7Ed
         c4Ewa0piQB/1JgYOZ54UyEJlrHmgkLFRtpAYCuS3InwrlFQyg708NGdPkXb9O7AgL3f9
         1RdCzAUVwBzxfsE4eWuvLKdYg8rtRK3cdzmcl6irl3+6ghzUJliDIoqF5xDYMV3SkXGe
         vLMfeLhWdG/Pk6YVYCdP1TJjjzV+ex0mX3/iRx0Sx11QUlipg8pM5jwcJnOQG5n/0vEJ
         Y9R+3XoAHU/zW5BSkCbe26mGDUBRpRLFLknhfmjqDxBz7uMLzFCdqU5aY9PN8kaDrG3r
         FqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705587765; x=1706192565;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MQmQ57jhPNOOjCerNM6q5F9m10YHH8SVIWhIL9dMZTE=;
        b=oq6JAtVNCz6/994QMF60uHH2hcRGV/jibx5MkkX4jWeCkUh291PAu95i7e7NndOjLz
         xo7MWBdEX0uQxjpgX9QwsPhBAqRcmjQVjGhkAr4dSo5iWulw7vlKfKCCzThvoTGuHVlH
         YORZ4DRVn8qRfhPv8vvbdiF1QAL3maipSgi6dz0TFf2YTKUc90Lk4rt9npZT8DLJkue7
         niWs3wfAAvewRJnY+sVfvXMnj1tshxwlavV3VKcBEyfNuZphe4dPt2R+SUME3T74lvc3
         gE++2pNp0FN3x3PWtlK6GB1RTNqJDD8gw6TF/GQLS9STGlVcCemxAmCo7aDF8k2q05Lg
         YqDg==
X-Gm-Message-State: AOJu0YwfXsNoNHi5I2PIbXXZFKmnfRt7SZh8N/vSSdFYT4bKBKLOUEx6
	YyaRQIoUzM/xaxhCOQtxLMceUjeDwoLobaXCAFsf0EdYVpsgVA0L8W8l/piq5wQ=
X-Google-Smtp-Source: AGHT+IEAZqGHugP6SSHGhmnB2UTe2rde66vWr8xnTZZd44KtjGiA2gbMs46TD4AdmZ56Y+ynbP+VDg==
X-Received: by 2002:a05:6808:1190:b0:3bd:9c61:7d41 with SMTP id j16-20020a056808119000b003bd9c617d41mr982809oil.12.1705587765526;
        Thu, 18 Jan 2024 06:22:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id t8-20020a05680800c800b003bd3c878a99sm261380oic.13.2024.01.18.06.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 06:22:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rQTI3-0051dq-ET;
	Thu, 18 Jan 2024 10:22:43 -0400
Date: Thu, 18 Jan 2024 10:22:43 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "zhangzekun (A)" <zhangzekun11@huawei.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	nicolinc@nvidia.com, mshavit@google.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add a threshold to avoid potential
 soft lockup
Message-ID: <20240118142243.GI50608@ziepe.ca>
References: <20240115114040.6279-1-zhangzekun11@huawei.com>
 <20240115153152.GA50608@ziepe.ca>
 <e74ea905-d107-4202-97ca-c2c509e7aa1e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e74ea905-d107-4202-97ca-c2c509e7aa1e@huawei.com>

On Thu, Jan 18, 2024 at 07:21:10PM +0800, zhangzekun (A) wrote:
> > What is the rest of the call chain? How did you get into such a large
> > invalidation?
> we are doing some test with qemu virtual machines. The testing platform has
> 96 cores and 960GB memories. It will enable 64 virtual machines and every
> virtual machine will cost 8G memories. When batching closing these 64
> virtaul machine concurrently, we will get soft lockup.
> 
>  WARN: soft lockup - CPU#18 stuck for 11s! [worker:3219]
> ....
> Call trace:
>  dump_backtrace+0x0/0x200
>  show_stack+0x20/0x30
>  dump_stack+0xf0/0x138
>  watchdog_print_info+0x48/0x54
>  watchdog_process_before_softlockup+0x9c/0xa0
>  watchdog_timer_fn+0x1ac/0x2f0
>  __run_hrtimer+0x98/0x2b4
>  __hrtimer_run_queues+0xc0/0x13c
>  hrtimer_interrupt+0x150/0x3e4
>  arch_timer_handler_phys+0x3c/0x50
>  handle_percpu_devid_irq+0x90/0x1f4
>  __handle_domain_irq+0x84/0xfc
>  gic_handle_irq+0x88/0x2b0
>  el1_irq+0xb8/0x140
>  ktime_get+0x3c/0xac
>  arm_smmu_cmdq_poll_until_not_full+0xb0/0x1a0
>  arm_smmu_cmdq_issue_cmdlist+0x194/0x5f4
>  __arm_smmu_tlb_inv_range+0x114/0x22c
>  arm_smmu_tlb_inv_walk+0x88/0x120
>  __arm_lpae_unmap+0x188/0x2c0
>  __arm_lpae_unmap+0x104/0x2c0
>  arm_lpae_unmap+0x68/0x80
>  arm_smmu_unmap+0x24/0x40
>  __iommu_unmap+0xd8/0x210
>  iommu_unmap_fast+0x18/0x24
>  unmap_unpin_fast+0x7c/0x140 [vfio_iommu_type1]
>  vfio_unmap_unpin+0x14c/0x3ac [vfio_iommu_type1]
>  vfio_remove_dma+0x38/0x124 [vfio_iommu_type1]
>  vfio_iommu_type1_detach_group+0x4b8/0x4e0 [vfio_iommu_type1]
>  __vfio_group_unset_container+0x58/0x18c [vfio]
>  vfio_group_try_dissolve_container+0x80/0x94 [vfio]
>  vfio_group_put_external_user+0x20/0x54 [vfio]
>  kvm_vfio_destroy+0xa8/0x12c
>  kvm_destroy_vm+0x20c/0x300
>  kvm_put_kvm+0x74/0xa0
>  kvm_vcpu_release+0x20/0x30
>  __fput+0xc4/0x270
>  ____fput+0x18/0x24
>  task_work_run+0xd0/0x1a0
>  do_exit+0x1d8/0x480
>  do_group_exit+0x40/0x130
>  get_signal+0x1f8/0x744
>  do_signal+0x98/0x204
>  do_notify_resume+0x15c/0x1e0
>  work_pending+0xc/0xa4

I see, that is interesting. 

I think iommufd is close to substantialy improving this. It already
has the domain destruction ordering:
 - Remove all domain attachments
 - Read back phys addrs, unmap and unpin
 - iommu_domain_free()

Currently smmu continues to issue ASID invalidations for the domain
even though there no references to it. However this is pretty
pointless here as we are going to free the ASID right away.

I'm going to make a series to allow smmu to support multi-instances on
a single domain. In this case when the domain looses all its
attachments it looses all its instances too and it won't have to do
*anything* for invalidation in this workflow.

Ie your flow will boil down to a single ASID invalidation once the
domain attachments are all removed, then on invalidations during unmap
and no invaludation at free. This would be a significantly faster
teardown I suspect.

> Thanks for your patch, the patch described below make sense to me. After
> spliting TLB invalidate operations according to domain stage,
> arm_smmu_tlb_inv_*_s1() can be used both in SVA codes and original smmu
> codes, and can implement arm_smmu_tlb_inv_all_s1() just using
> arm_smmu_tlb_inv_range_s1() by passing a special size. But the current
> smmu-v3 driver has not move "asid" into "struct smmu_domain", we still need
> to pass the exact asid from SVA.

Yes, it is not intended to be applied on the current kernel, there are
a lot of structural problems with how SVA works there..

Jason

