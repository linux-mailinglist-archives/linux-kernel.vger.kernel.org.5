Return-Path: <linux-kernel+bounces-152885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526298AC5BE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1881F2239B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F294D131;
	Mon, 22 Apr 2024 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S0qklbmS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9424AEFE;
	Mon, 22 Apr 2024 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771661; cv=none; b=b5NOrs7Hqae6Sbd3nghzBy/f6Dj5RiESMZaFLKs6hwNmwVvPrWj/Z1xB6lqCMiBRGAqKkCY/VQkGJ/GvFk/5U8uEE5H38RQQHVObH2m/hvk3TwMLaLg2ojRX27CKQ8hFUK8iJM0xCjVS3HpCFLJjorLTxpGEKCkNTo9DvykXhZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771661; c=relaxed/simple;
	bh=USR3bFEd40WckrOHmGi8VAlZeJ/vjjPTOFMN/FwP1iw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EftwOw/71Y1LoVh3tHlx9VM5luiTqG96RktmsfDERqjhQ2qTC0oUjg3yYM1KuLDxfunetcp3UnZQO+QEwJwywW8d+LDbNksBfq7QBGlFESRw7VKJpIoRmjP0FGEextKpyvaLSu6Pk+/cY95P3wVLl8jWBwYoxEuLqEmYv1DKuU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S0qklbmS; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713771660; x=1745307660;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=USR3bFEd40WckrOHmGi8VAlZeJ/vjjPTOFMN/FwP1iw=;
  b=S0qklbmSM8d0bIkXWJ5FAudZDbh55r1v7Q4NUooJh+XBKGrfPWHacSye
   u1KZ4gDKgXUu5Vt9Slor/EAjyJLTKfw4jQMxCCenVHhM3x9qIJOBp5bRP
   r5ysrWGFTEvQkrM9tOYZLdD2zH/b3eGjdCH6c3dl4FXoBmBWu3Q4pBldO
   2JGsOrDfnlxExNmfZs82RgL1XldRpcwfbl5xUai2pA9R4aKGxWDG3lEKN
   jrmu7b9lIWOtTFflfzDiuHhcUot9nFb90gDmJOI3t0+FqNupLlwqOrwET
   1GL7eh/8oDN5VvcqLwCj50G2YNZAmP3t8XcYAqjQZxrf2LdYyeTcyZdX4
   w==;
X-CSE-ConnectionGUID: NYkUW69STGq2tfXR+ozkRg==
X-CSE-MsgGUID: C/1kWFZYSqOBJhOMEI+UyQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="20436786"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="20436786"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 00:40:59 -0700
X-CSE-ConnectionGUID: Bhjbqn5PRx+ExxI/+DpaQg==
X-CSE-MsgGUID: I0j9NBpPT8OLzM2aqsevpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="24012803"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.225.176]) ([10.124.225.176])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 00:40:54 -0700
Message-ID: <23ef7fbd-7498-4fb0-895b-81c618acedc1@linux.intel.com>
Date: Mon, 22 Apr 2024 15:40:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>,
 Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux@rivosinc.com
Subject: Re: [PATCH v2 7/7] iommu/riscv: Paging domain support
To: Jason Gunthorpe <jgg@ziepe.ca>, Tomasz Jeznach <tjeznach@rivosinc.com>
References: <cover.1713456597.git.tjeznach@rivosinc.com>
 <301244bc3ff5da484b46d3fecc931cdad7d2806f.1713456598.git.tjeznach@rivosinc.com>
 <20240419125627.GD223006@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240419125627.GD223006@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/19 20:56, Jason Gunthorpe wrote:
>> +		riscv_iommu_cmd_inval_vma(&cmd);
>> +		riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
>> +		if (len > 0 && len < RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
>> +			for (iova = start; iova < end; iova += PAGE_SIZE) {
>> +				riscv_iommu_cmd_inval_set_addr(&cmd, iova);
>> +				riscv_iommu_cmd_send(iommu, &cmd, 0);
>> +			}
>> +		} else {
>> +			riscv_iommu_cmd_send(iommu, &cmd, 0);
>> +		}
>> +	}
> This seems suboptimal, you probably want to copy the new design that
> Intel is doing where you allocate "bonds" that are already
> de-duplicated. Ie if I have 10 devices on the same iommu sharing the
> domain the above will invalidate the PSCID 10 times. It should only be
> done once.
> 
> ie add a "bond" for the (iommu,pscid) and refcount that based on how
> many devices are used. Then another "bond" for the ATS stuff eventually.

The latest version is under discussion here.

https://lore.kernel.org/linux-iommu/20240416080656.60968-1-baolu.lu@linux.intel.com/

Supposedly, you can make such optimization after the base code is landed
in the mainline tree if the change is big.

Best regards,
baolu

