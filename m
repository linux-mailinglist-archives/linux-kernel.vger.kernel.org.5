Return-Path: <linux-kernel+bounces-130755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AAA897CBE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C81F1B218A6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC810156C47;
	Wed,  3 Apr 2024 23:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJzqfoyA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C211156890
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 23:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712188593; cv=none; b=J/z6l4DYwUlDwLz+gfj0tjtNAtjdvM7hN/kCiyPoTm31FlO+gUG7cDh08yimm4inc99A48EVHbNf0g5LBx4TpZASAm8vsq078R2Z5UZqfvBDKZHsOWkY12hOjIbPkCSURKWrlwhuE7DbbPk0xebGyJx+ggFdSCL6qwAnJTk78w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712188593; c=relaxed/simple;
	bh=UrXAQasvncSpBHkoTI6cFGko0JNvW/rvXuzK5szDdrs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mu/oQL+AYMre9PkzHBg9ZxBHSRbxyQ+43ibMuUO5JkN7bqcANOySopZCqvmoldlzkIiyf1Q+mXZyT2khsgzx5GpHo6Szc5b/usFedVDoeRgfttzFmIhyzcprtwLsvDUdRF4AcYIWKmvL2AEn+ZjnvyLLm/H6wrr0psW3MNsnt40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJzqfoyA; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712188591; x=1743724591;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UrXAQasvncSpBHkoTI6cFGko0JNvW/rvXuzK5szDdrs=;
  b=YJzqfoyACOnletvFawwnHBE9Zb7XZ0m/WaHFuUCGK/5dOj6GwDz+oj6c
   u2ILrH56gcazxoD1gMbNKGVgYQt/2ap9xR3yDLpiKkxA66gDwQwTBgU/4
   2Jsce8sEFxnitNgKmKvfmjTBiCnAq05Eu2B/uyedOKtyTa8IyvqNkwup+
   WUEADakxbRa1pq4O7if444L8Ca+IEZr56phaqRHuRqdxYnlo3Ux22TXdH
   XP5QbsNV0OkI2JEDuxIupmkCc2dsPpM35OocMa1UfUXisFN4RqdZl2B1U
   2D0ZqAn0kPgfSzna7uEh4D3T7vRWHAOFaans3+wrBWcsaWDgnpKTKkEHh
   Q==;
X-CSE-ConnectionGUID: 6wm9BL79QI+hbDHHUB5cFQ==
X-CSE-MsgGUID: /bcO6s9WQeami/HAhASAZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18068634"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="18068634"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 16:56:30 -0700
X-CSE-ConnectionGUID: +LUqcMe5Tg6zketEoCocVw==
X-CSE-MsgGUID: x5Ktg1vVQmSszC3DmtCLnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="19057023"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 16:56:30 -0700
Date: Wed, 3 Apr 2024 17:00:57 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dimitri Sivanich <sivanich@hpe.com>, David Woodhouse
 <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>, Russ
 Anderson <russ.anderson@hpe.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH] Allocate DMAR fault interrupts locally
Message-ID: <20240403170057.0294a17e@jacob-builder>
In-Reply-To: <87msqnfihs.ffs@tglx>
References: <ZeDj/LK56borSxO4@hpe.com>
	<87plwe7w3m.ffs@tglx>
	<Ze9r47riIq9ovBCY@hpe.com>
	<20240321151357.1d18127f@jacob-builder>
	<87msqnfihs.ffs@tglx>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Thomas,

On Sun, 24 Mar 2024 22:05:35 +0100, Thomas Gleixner <tglx@linutronix.de>
wrote:

I sent out a tested patch based on your code, I made a few changes below.

> -- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1182,7 +1182,6 @@ static void free_iommu(struct intel_iomm
>  			iommu->pr_irq = 0;
>  		}
>  		free_irq(iommu->irq, iommu);
> -		dmar_free_hwirq(iommu->irq);
>  		iommu->irq = 0;
>  	}
>  
> @@ -1956,17 +1955,21 @@ void dmar_msi_mask(struct irq_data *data
>  	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
>  }
>  
> -void dmar_msi_write(int irq, struct msi_msg *msg)
> +static void dmar_iommu_msi_write(struct intel_iommu *iommu, struct
> msi_msg *msg) {
> -	struct intel_iommu *iommu = irq_get_handler_data(irq);
>  	int reg = dmar_msi_reg(iommu, irq);
> -	unsigned long flag;
> +	unsigned long flags;
>  
> -	raw_spin_lock_irqsave(&iommu->register_lock, flag);
> +	raw_spin_lock_irqsave(&iommu->register_lock, flags);
>  	writel(msg->data, iommu->reg + reg + 4);
>  	writel(msg->address_lo, iommu->reg + reg + 8);
>  	writel(msg->address_hi, iommu->reg + reg + 12);
> -	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
> +	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
> +}
> +
> +void dmar_msi_write(int irq, struct msi_msg *msg)
> +{
> +	dmar_iommu_msi_write(irq_get_handler_data(irq), msg);
page request and perfmon irqs also use this function, where irq !=
iommu->irq. In this case, fault irq got overwritten by other dmar irq
sources. So we need to pass in irq as well.

>  }
>  
>  void dmar_msi_read(int irq, struct msi_msg *msg)
> @@ -2100,23 +2103,37 @@ irqreturn_t dmar_fault(int irq, void *de
>  
>  int dmar_set_interrupt(struct intel_iommu *iommu)
>  {
> -	int irq, ret;
> +	static int dmar_irq;
> +	int ret;
>  
> -	/*
> -	 * Check if the fault interrupt is already initialized.
> -	 */
> +	/* Don't initialize it twice for a given iommu */
>  	if (iommu->irq)
>  		return 0;
>  
> -	irq = dmar_alloc_hwirq(iommu->seq_id, iommu->node, iommu);
> -	if (irq > 0) {
> -		iommu->irq = irq;
> +	/*
> +	 * There is one shared interrupt for all IOMMUs to prevent vector
> +	 * exhaustion.
> +	 */
> +	if (!dmar_irq) {
> +		int irq = dmar_alloc_hwirq(iommu->seq_id, iommu->node,
> iommu); +
> +		if (irq <= 0) {
> +			pr_err("No free IRQ vectors\n");
> +			return -EINVAL;
> +		}
> +		dmar_irq = irq;
Need to store the fault irq.
iommu->irq = irq

>  	} else {
> -		pr_err("No free IRQ vectors\n");
> -		return -EINVAL;
> +		struct msi_msg msg;
> +
> +		/*
> +		 * Get the MSI message from the shared interrupt and
> write
> +		 * it to the iommu MSI registers.
> +		 */
> +		dmar_msi_read(dmar_irq, &msg);
> +		dmar_iommu_msi_write(iommu, &msg);
>  	}
>  
> -	ret = request_irq(irq, dmar_fault, IRQF_NO_THREAD, iommu->name,
> iommu);
> +	ret = request_irq(dmar_irq, dmar_fault, IRQF_NO_THREAD |
> IRQF_SHARED, iommu->name, iommu); if (ret)
I added IRQF_NOBALANCING, ok? it makes things simple by not reprogramming
all the DMAR msi controls.

>  		pr_err("Can't request irq\n");
>  	return ret;


Thanks,

Jacob

