Return-Path: <linux-kernel+bounces-165902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 314E58B9328
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B6FCB21401
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A908114AB2;
	Thu,  2 May 2024 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IEWcvywz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C001A12B93;
	Thu,  2 May 2024 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714614033; cv=none; b=lnysjY2U/ibR0HPKVqr0nVn9TFjjqVw7ysE2Jl1pk0wTm5I7so8j3d8pyW7gLU+RI84nGwdNY6oy7+AMNQp79lBx33XKfyEFP3CEUSQx5KCTWrWDKSPbG3ZwtLGc/FNb+Yjotu8FRSWqIbQJa0TixcokCbyOcfBOmg4eBKs2l3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714614033; c=relaxed/simple;
	bh=rB8QaHvvVc37SrREtm9E3Ka0ivGapfuZ+pPLjENqNqQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=arUOzZsNOadg6i0hZGAKWonFTfyFd2ePj/XGl0LUruTvQjAJtzTwL2rB5s+w/WS3GcbmEaWbAryQclwBs7/STDh6MdEks4hFJtm9959kNiNLqurHrgCd6QnvpT6NQxR/p8+kPr8JIkWbld4az6dQDVU+D5/uVtLyHowQsP5cyUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IEWcvywz; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714614030; x=1746150030;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rB8QaHvvVc37SrREtm9E3Ka0ivGapfuZ+pPLjENqNqQ=;
  b=IEWcvywzV/4Q550N/Ry63JQ22rQrOX79MOLV9m76SfWjEikMAd3YD6yV
   a84y2E6dSiE1fOtp57tVE6ZDnbcnI3vCYPIlrcDP+3SfrmXl71JlVaNTt
   OXt8bg2K3iYdxvUUCALwjAob2pBgwHUmG0n8EBh57WU6NxziIGLcNmO3i
   qaV9HSDe8AKtjb8Awkyvo8MW1XnWJVn6pEbMQwUBuzePi1RSMBuONzAlm
   MJklK758yR4JfksGhX7BM04JQXWqWirqnVU/zfVmGj+f2y2b2a022YxlW
   Ihf1nz+u7I0Gf0mzioHk8evyljMDKuGKIWjc+l4AJvTwq0CbFkZDAaSHh
   g==;
X-CSE-ConnectionGUID: g9k4RxdHTZiBv9dhZ2g2fA==
X-CSE-MsgGUID: fjBpj5gsTLmSmJjBcEfT7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="32883905"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="32883905"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 18:40:29 -0700
X-CSE-ConnectionGUID: h5YM6Yf1Q9GE9Rwcx5b5JA==
X-CSE-MsgGUID: QsBLxdJaTuCtZm8iROSJEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31581522"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 01 May 2024 18:40:25 -0700
Message-ID: <104358de-ea86-4e25-8942-ba285d6f317b@linux.intel.com>
Date: Thu, 2 May 2024 09:38:54 +0800
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
Subject: Re: [PATCH v3 5/7] iommu/riscv: Device directory management.
To: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>
References: <cover.1714494653.git.tjeznach@rivosinc.com>
 <ce3b82a20db0b776685269674ce9b7a926d5680d.1714494653.git.tjeznach@rivosinc.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ce3b82a20db0b776685269674ce9b7a926d5680d.1714494653.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/24 4:01 AM, Tomasz Jeznach wrote:
> @@ -128,6 +489,7 @@ void riscv_iommu_remove(struct riscv_iommu_device *iommu)
>   {
>   	iommu_device_unregister(&iommu->iommu);
>   	iommu_device_sysfs_remove(&iommu->iommu);
> +	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
>   }
>   
>   int riscv_iommu_init(struct riscv_iommu_device *iommu)
> @@ -138,12 +500,13 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
>   	if (rc)
>   		return dev_err_probe(iommu->dev, rc, "unexpected device state\n");
>   
> -	/*
> -	 * Placeholder for a complete IOMMU device initialization.
> -	 * For now, only bare minimum: enable global identity mapping mode and register sysfs.
> -	 */
> -	riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_DDTP,
> -			   FIELD_PREP(RISCV_IOMMU_DDTP_MODE, RISCV_IOMMU_DDTP_MODE_BARE));
> +	rc = riscv_iommu_iodir_alloc(iommu);
> +	if (rc)
> +		goto err_init;
> +
> +	rc = riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_MODE_MAX);
> +	if (rc)
> +		goto err_init;
>   
>   	rc = iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "riscv-iommu@%s",
>   				    dev_name(iommu->dev));

The device directory root page might be allocated in
riscv_iommu_iodir_alloc(),

+	if (!iommu->ddt_root) {
+		iommu->ddt_root = riscv_iommu_get_pages(iommu, 0);
+		iommu->ddt_phys = __pa(iommu->ddt_root);
+	}

But I didn't find any place to free it in the error paths. Did I
overlook anything?

Best regards,
baolu

