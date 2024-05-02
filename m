Return-Path: <linux-kernel+bounces-165945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 505138B93B0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0A31F22674
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC801B299;
	Thu,  2 May 2024 03:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c/koTYUH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F175F18AF4;
	Thu,  2 May 2024 03:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714621932; cv=none; b=ASmVqD3O7KKlV2KqAwcWL07vG4mQ+V75qALx82UKjCLfNnT00KaikotQeFY1RlL9f1Nq4mnFeEQu5ugkCSYSSVIMhXQDWbnGdWBeQCTcBw3WVZ9UxpRk7pWRqVceZXy1qyqBA1ZFAB6b11VCamQL9bItF1MkRPBk+jojCX+qaoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714621932; c=relaxed/simple;
	bh=qK6quWd0+fR1tNL6dF/6F94raTQfcmC3+2BRAFGNCVc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pqcgK1ivSNk2vlMhBylaGPtM8gimaYyBJlx+0mEHQBqQQcX6T0WBXec4i6bB/RyP0aX1H/wg8HDIzi6oNLY46zzaRlNvZxp+qdqGmVJu2QYKEsFkHSxjC0YGKgaQAFaZLyYSikm2wI/RM5+56LU9hJv1PIdGr7BtMKAD4xwG76g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c/koTYUH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714621932; x=1746157932;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qK6quWd0+fR1tNL6dF/6F94raTQfcmC3+2BRAFGNCVc=;
  b=c/koTYUHZPPPsqf7TMLACBhFnoIoi4zIYdn39p4uF2vAMOKl3PUaqGup
   7BiyBtl05QT0IqkeWhO94n6l4eQVBHSydRLwGc4Dx759kX2Xnv3su4umn
   vsp+Yej1WIyXM7eytxNIld+TAP1lKLjBfrRN9eusdXA6cp2QH9jtwVhXs
   jCbiBXQ1AqyhT1dTHwyc93zkqgn7tMOpJKKrvio69MCv3DXx9OzazImZZ
   rFbP55blCDv5OYT36E/cFAKxUD9HmwbZ62tLmNqYbK/7NbV5EcUNJOZPh
   yOrY5NjshdvWGIsgOH3dp0rnAWbhwz7F5whbrBLg+LzL12KBMo2Ml/Any
   Q==;
X-CSE-ConnectionGUID: G2x9X0oLTSSN8v4jan5aHA==
X-CSE-MsgGUID: T0bXO3oNTJ+PHCAUtyMBcg==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="14196395"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="14196395"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 20:52:11 -0700
X-CSE-ConnectionGUID: vGfpbaSWRyeFeHIYwU+aJA==
X-CSE-MsgGUID: LEuKkd3RTSO3a82B1VFTUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31661944"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 01 May 2024 20:52:06 -0700
Message-ID: <7c3fc511-6a3b-44d8-94fa-e4fff54f93b9@linux.intel.com>
Date: Thu, 2 May 2024 11:50:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Nick Kossifidis <mick@ics.forth.gr>,
 Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux@rivosinc.com
Subject: Re: [PATCH v3 7/7] iommu/riscv: Paging domain support
To: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>
References: <cover.1714494653.git.tjeznach@rivosinc.com>
 <b83f81c04d1f3885d860b1eec03761fe63a33183.1714494653.git.tjeznach@rivosinc.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <b83f81c04d1f3885d860b1eec03761fe63a33183.1714494653.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/24 4:01 AM, Tomasz Jeznach wrote:
> +/*
> + * Send IOTLB.INVAL for whole address space for ranges larger than 2MB.
> + * This limit will be replaced with range invalidations, if supported by
> + * the hardware, when RISC-V IOMMU architecture specification update for
> + * range invalidations update will be available.
> + */
> +#define RISCV_IOMMU_IOTLB_INVAL_LIMIT	(2 << 20)
> +
> +static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
> +				    unsigned long start, unsigned long end)
> +{
> +	struct riscv_iommu_bond *bond;
> +	struct riscv_iommu_device *iommu, *prev;
> +	struct riscv_iommu_command cmd;
> +	unsigned long len = end - start + 1;
> +	unsigned long iova;
> +
> +	rcu_read_lock();
> +
> +	prev = NULL;
> +	list_for_each_entry_rcu(bond, &domain->bonds, list) {
> +		iommu = dev_to_iommu(bond->dev);
> +
> +		riscv_iommu_cmd_inval_vma(&cmd);
> +		riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
> +		if (len && len >= RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
> +			for (iova = start; iova < end; iova += PAGE_SIZE) {
> +				riscv_iommu_cmd_inval_set_addr(&cmd, iova);
> +				riscv_iommu_cmd_send(iommu, &cmd, 0);
> +			}
> +		} else {
> +			riscv_iommu_cmd_send(iommu, &cmd, 0);
> +		}
> +
> +		/*
> +		 * IOTLB invalidation request can be safely omitted if already sent
> +		 * to the IOMMU for the same PSCID, and with domain->bonds list
> +		 * arranged based on the device's IOMMU, it's sufficient to check
> +		 * last device the invalidation was sent to.
> +		 */
> +		if (iommu == prev)
> +			continue;
> +
> +		prev = iommu;
> +		riscv_iommu_cmd_send(iommu, &cmd, 0);
> +	}

I don't quite follow why not moving "if (iommu == prev)" check to the
top and removing the last riscv_iommu_cmd_send(). My understanding is
that we could make it simply like below:

	prev = NULL;
	list_for_each_entry_rcu(bond, &domain->bonds, list) {
		iommu = dev_to_iommu(bond->dev);
		if (iommu == prev)
			continue;

		/*
		 * Send an invalidation request to the request queue
		 * without wait.
		 */
		... ...

		prev = iommu;
	}

> +
> +	prev = NULL;
> +	list_for_each_entry_rcu(bond, &domain->bonds, list) {
> +		iommu = dev_to_iommu(bond->dev);
> +		if (iommu == prev)
> +			continue;
> +
> +		prev = iommu;
> +		riscv_iommu_cmd_iofence(&cmd);
> +		riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_QUEUE_TIMEOUT);
> +	}
> +	rcu_read_unlock();
> +}

Best regards,
baolu

