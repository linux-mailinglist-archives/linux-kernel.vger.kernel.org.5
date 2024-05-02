Return-Path: <linux-kernel+bounces-165946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA75B8B93B2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22D23B2207F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B761B815;
	Thu,  2 May 2024 03:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PxQ4M5vl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B65617740;
	Thu,  2 May 2024 03:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714621978; cv=none; b=TZGzycUhDueDNFtpvfH4pgKE0ZBEWQFjowVt8Eg/psAFNoSZofhWWEmBaZGMMeFBCC2wxulZXexYu2VWInbJae7As9ORRjvmS4/GHUO85NHfVjxx030Cr8aklnwqigZ/nQIvl4hKG7w3swrISSLZvP9A8JTgyJ3V07LYYOeQf+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714621978; c=relaxed/simple;
	bh=ufokDlLyeYAEJkn0qhb3kYYK+asNA6o0QGc5jorczJE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YRt0gNrVTrZ7qRvqJ+JdN+VIV2+p5e9/w+CJWRl2j+bDXPdp9Rl+8X3XQI0yc+aYapDiDQFUGHd5Zm0c7jFsKNbPVvLQ3+U946TD2giQMRXrAjJgZr/ftrC/R1QLlUcyw389NFFolIPOg1eIJZnCOZfi038S0dI+SZKxdc6miJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PxQ4M5vl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714621978; x=1746157978;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ufokDlLyeYAEJkn0qhb3kYYK+asNA6o0QGc5jorczJE=;
  b=PxQ4M5vlmg032yFN/ZqCFNCZiSAer7DavAsizPaLbQOwU9DWYX808ASb
   wL2wwWbcbtbPW90v/5XmQozx1Y2jMgPY6vSdkcEz1m08b6v3a3LyB7gX6
   dT0JC6T7oDWGna43cur5zxTgWMcQdjTCJALkR1plMwnVS8G2i4qUyDERn
   Z9SYnrq1sUSBEfxLbIq6QBE9aMMU36odlbyMs6EPZ4Lfumacuah7wiT4w
   LtV8Rblb5QITBZls46d+IsOgVM/g5ab4gpakiUCfOOOOrpC8rGkjy9SE/
   JNZPwpvDReSKX2fbewcchxi734Kof+T98akHDiJmeaHguJXGwsGT0p9CX
   A==;
X-CSE-ConnectionGUID: 1TUz9uPjQpS7Enz4sftN6Q==
X-CSE-MsgGUID: xlHlqSr1RVSB/e6A7AgzpA==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="14196421"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="14196421"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 20:52:58 -0700
X-CSE-ConnectionGUID: FFGWb+U4Q4Sbss+D92Yhvg==
X-CSE-MsgGUID: kuy6D+XUTs6pBANWIhlM7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31662031"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 01 May 2024 20:52:52 -0700
Message-ID: <1eeed328-fd6c-4740-b1f5-339aad559997@linux.intel.com>
Date: Thu, 2 May 2024 11:51:22 +0800
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
Subject: Re: [PATCH v3 6/7] iommu/riscv: Command and fault queue support
To: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>
References: <cover.1714494653.git.tjeznach@rivosinc.com>
 <fbf49cba213b03d42aae398c1b48da06e3f6e1b7.1714494653.git.tjeznach@rivosinc.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <fbf49cba213b03d42aae398c1b48da06e3f6e1b7.1714494653.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/24 4:01 AM, Tomasz Jeznach wrote:
> Introduce device command submission and fault reporting queues,
> as described in Chapter 3.1 and 3.2 of the RISC-V IOMMU Architecture
> Specification.
> 
> Command and fault queues are instantiated in contiguous system memory
> local to IOMMU device domain, or mapped from fixed I/O space provided
> by the hardware implementation. Detection of the location and maximum
> allowed size of the queue utilize WARL properties of queue base control
> register. Driver implementation will try to allocate up to 128KB of
> system memory, while respecting hardware supported maximum queue size.
> 
> Interrupts allocation is based on interrupt vectors availability and
> distributed to all queues in simple round-robin fashion. For hardware
> Implementation with fixed event type to interrupt vector assignment
> IVEC WARL property is used to discover such mappings.
> 
> Address translation, command and queue fault handling in this change
> is limited to simple fault reporting without taking any action.
> 
> Signed-off-by: Tomasz Jeznach<tjeznach@rivosinc.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

