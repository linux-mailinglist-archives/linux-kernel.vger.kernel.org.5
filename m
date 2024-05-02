Return-Path: <linux-kernel+bounces-165920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AA78B9364
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3952B1C21D99
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC8018049;
	Thu,  2 May 2024 02:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GaVjSVDy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556FD175AA;
	Thu,  2 May 2024 02:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714616702; cv=none; b=iX1/Q3DGRK5hSEVP0tCMpx55QICusv20ZtcbEyQAtk1h24FRnopkstqwGJGNAMVKA5kuCi56c4OHaKETeOuYXjsQp3f0PD1rE0Pltox+hNMkWNd/KY539sNABl7ihwFkTXGHb7hLDFyMR8mp1RJKk0BW6hG5KIKe4RcPjlm0OE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714616702; c=relaxed/simple;
	bh=jpSeGAw3fd3r1otijxAAN8h2zXrCijx9qZbvcF0BXXo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eQxxCFrHcKMEpUfkWRPfAe8TJ1Mg9B2OoXeZHo38xxwfhvJyTpzDONtMaqcy75mxdvD7JaYKLShijhDNh5cd4Xkl5B3cmbuKMT9riIqn5c3b86UAPujpaAEUY8a0ksZ8VKNDIPKJHKHlYioQCqFdXzGsQme4tDtU+1VDyhQsIME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GaVjSVDy; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714616701; x=1746152701;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jpSeGAw3fd3r1otijxAAN8h2zXrCijx9qZbvcF0BXXo=;
  b=GaVjSVDyZS26mmcJ+nv4ms1kN2K3mfhBwq53HB6kDcMfA13DNz5rAbmf
   XdI7axsMH0MNCkYY/ri2L/dqgQMy5z3Zq8mcBKNMlR3U75UNXzLyV7phA
   mnaSylIfgWFhvU7avEVDasdywbSMFWJv8hrpgEeJr0rRBr1IN2mAujk2z
   SUj/Aex08SQmOPZ6S4YxQlH958eWzfWwCWww7tU+joUwoy6/JU4iLO2il
   gLbgDslhDCgRIh2kkeVJ2QhSF1skNm/Jag2qgHijpWwuQ8si5nBo86maX
   QtkSh7wLYqhYTcIpm4srKrL0q6kh8chIH06T+lyOX1yLGh1g9u4AtFfnX
   w==;
X-CSE-ConnectionGUID: qALUQGLZTAWm5PQPNY+TVg==
X-CSE-MsgGUID: bmSD6cjDQGCHjoPyCkaAcg==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10229994"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10229994"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 19:25:00 -0700
X-CSE-ConnectionGUID: bBj1T5ZZTtSmAr7cLpiTxQ==
X-CSE-MsgGUID: 4FL4oJo5TpWw3ZKRJrJjPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31650464"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 01 May 2024 19:24:56 -0700
Message-ID: <3972c041-d5dd-4b02-9a0d-4541f7adc6d0@linux.intel.com>
Date: Thu, 2 May 2024 10:23:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Nick Kossifidis <mick@ics.forth.gr>,
 Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux@rivosinc.com
Subject: Re: [PATCH v3 2/7] iommu/riscv: Add RISC-V IOMMU platform device
 driver
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <cover.1714494653.git.tjeznach@rivosinc.com>
 <aa5592da66fe72acd4d4730f544882042e7b5293.1714494653.git.tjeznach@rivosinc.com>
 <6b4a4dc0-ac9e-43cd-bd84-447df2370dde@linux.intel.com>
 <20240501142037.GC1723318@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240501142037.GC1723318@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/24 10:20 PM, Jason Gunthorpe wrote:
> On Wed, May 01, 2024 at 06:26:20PM +0800, Baolu Lu wrote:
>> On 2024/5/1 4:01, Tomasz Jeznach wrote:
>>> +static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
>>> +{
>>> +	u64 ddtp;
>>> +
>>> +	/*
>>> +	 * Make sure the IOMMU is switched off or in pass-through mode during regular
>>> +	 * boot flow and disable translation when we boot into a kexec kernel and the
>>> +	 * previous kernel left them enabled.
>>> +	 */
>>> +	ddtp = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_DDTP);
>>> +	if (ddtp & RISCV_IOMMU_DDTP_BUSY)
>>> +		return -EBUSY;
>>> +
>>> +	if (FIELD_GET(RISCV_IOMMU_DDTP_MODE, ddtp) > RISCV_IOMMU_DDTP_MODE_BARE) {
>>> +		if (!is_kdump_kernel())
>> Is kdump supported for RISC-V architectures?  If so, the documentation
>> in Documentation/admin-guide/kdump/kdump.rst might need an update.
>>
>> There is a possibility of ongoing DMAs during the boot process of the
>> kdump capture kernel because there's a small chance of legacy DMA setups
>> targeting any memory location. Kdump typically allows these ongoing DMA
>> transfers to complete, assuming they were intended for valid memory
>> regions.
>>
>> The IOMMU subsystem implements a default domain deferred attachment
>> mechanism for this. In the kdump capture kernel, the whole device
>> context tables are copied from the original kernel and will be
>> overridden once the device driver calls the kernel DMA interface for the
>> first time. This assumes that all old DMA transfers are completed after
>> the driver's takeover.
>>
>> Will you consider this for RISC-V architecture as well?
> It seems we decided not to do that mess in ARM..
> 
> New architectures doing kdump should put the iommu in a full blocking
> state before handing over the next kernel, and this implies that
> devices drivers need to cleanly suspend their DMAs before going into
> the next kernel.

Glad to hear that. :-)

With the above consideration, the driver should consider it an error
case where the iommu is not in the blocking state, and it's in the kdump
kernel, right?

If so, probably the iommu driver should always return failure when the
iommu is not in the blocking state. However, the RISC-V's logic is:

  - if this is a kdump kernel, just disable iommu;
  - otherwise, failure case.

This logic seems problematic.

Best regards,
baolu

