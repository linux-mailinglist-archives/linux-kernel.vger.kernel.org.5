Return-Path: <linux-kernel+bounces-165119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B01218B8852
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D02D1F24102
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5462E524D7;
	Wed,  1 May 2024 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HwjclCTb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF1251036;
	Wed,  1 May 2024 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714557692; cv=none; b=enSRtC88rCYb08EJXgY+tIkNoMGxVuwHnaBNCGs/RTL5wmYmSWh08pPPlIM3mva7d5FxnUyFBeMGanY9nohzhBIWl9yA+Ig0jg1+naTvWYXfOxpiS/0AaSMnqmblcibbvALhMPzQsXN9xOhzUcM5D+aWd+sE+2pogFO1H0x/8YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714557692; c=relaxed/simple;
	bh=Hd8WBmznF8s3GFca7bl23FfAapWO49hb4n7ZJcgVZX8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YefJSGfexPfO17RFQZx3ZpjBB6iR/1DKV/7I6dnAwzNyKkEW4cq6cGWka+CIsj0UZJFk/kU1mgmZHHL8m4a4cx4X+immuGP+Gs60/I5p0yHOXMl+cDdUGFVV3D+PIjC1HKvS6iSkzdkeb0QMftzxRELTdel0Uun27jTrKaWZA8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HwjclCTb; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714557690; x=1746093690;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hd8WBmznF8s3GFca7bl23FfAapWO49hb4n7ZJcgVZX8=;
  b=HwjclCTb1hokX7PPnZ5NP6KaAcUaZacBc/esx8KFHRewL0cTm8wo0nLF
   BiEYxvXlIYwla76/va4GEjQ/DUBoYV4QnoWiWITvvnzrFYoUvZQ3uqEyk
   LTfLvKI5dT0NHhN6XlWdKw4EcpOlBVKoRzcjfDQAODzAlCyM+w+3ns/uR
   8pC7RLdXyJxBNPljvG+nKDtYpma+6I6BE2HFfthMOP786+kGDBDCpfz87
   5rM99nzKal7PYFmLLfB0C9VCQdbYxmsqdiO6sXwVxMJQgOS5tWJvKnn4t
   wRS9ehsMMlPK65Qfq8Y40/S97hxcUF2Jb2BZGMxeICySJpTM3quumfrde
   A==;
X-CSE-ConnectionGUID: Sgsw640MT620RsRGMbOOkQ==
X-CSE-MsgGUID: qHS9RrHyStSa7RP+lN0E9g==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10155829"
X-IronPort-AV: E=Sophos;i="6.07,245,1708416000"; 
   d="scan'208";a="10155829"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 03:01:29 -0700
X-CSE-ConnectionGUID: udJhc1hNT0e0Cs8MdxtM1Q==
X-CSE-MsgGUID: Hg8wu7WfTWWT6SwKQNXnkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,245,1708416000"; 
   d="scan'208";a="27230625"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.225.176]) ([10.124.225.176])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 03:01:25 -0700
Message-ID: <57678928-4557-4975-ae23-7e11904e5302@linux.intel.com>
Date: Wed, 1 May 2024 18:01:22 +0800
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
Subject: Re: [PATCH v3 3/7] iommu/riscv: Add RISC-V IOMMU PCIe device driver
To: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>
References: <cover.1714494653.git.tjeznach@rivosinc.com>
 <3a04bd180fd510cb90e8d8dba5fb60f207e5e83f.1714494653.git.tjeznach@rivosinc.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <3a04bd180fd510cb90e8d8dba5fb60f207e5e83f.1714494653.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/1 4:01, Tomasz Jeznach wrote:
> Introduce device driver for PCIe implementation
> of RISC-V IOMMU architected hardware.
> 
> IOMMU hardware and system support for MSI or MSI-X is
> required by this implementation.
> 
> Vendor and device identifiers used in this patch
> matches QEMU implementation of the RISC-V IOMMU PCIe
> device, from Rivos VID (0x1efd) range allocated by the PCI-SIG.
> 
> MAINTAINERS | added iommu-pci.c already covered by matching pattern.
> 
> Link:https://lore.kernel.org/qemu-devel/20240307160319.675044-1-dbarboza@ventanamicro.com/
> Co-developed-by: Nick Kossifidis<mick@ics.forth.gr>
> Signed-off-by: Nick Kossifidis<mick@ics.forth.gr>
> Signed-off-by: Tomasz Jeznach<tjeznach@rivosinc.com>
> ---
>   drivers/iommu/riscv/Kconfig     |   5 ++
>   drivers/iommu/riscv/Makefile    |   1 +
>   drivers/iommu/riscv/iommu-pci.c | 119 ++++++++++++++++++++++++++++++++
>   3 files changed, 125 insertions(+)
>   create mode 100644 drivers/iommu/riscv/iommu-pci.c

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

