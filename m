Return-Path: <linux-kernel+bounces-47690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E21845159
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D51291C53
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD6D633E5;
	Thu,  1 Feb 2024 06:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2z2SCyDS"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346D75FB9C;
	Thu,  1 Feb 2024 06:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706768360; cv=none; b=qGYiieCO6uzZLRHJW/PgIr2wq3f1L/3U1XnrdSb9+qTnhwKm5T6OoOhdzrNlnFFndFAOw1NBkxc32+v3NiZ4PmKe0k5GI0x8mJ/ppYkgGf0yZ4n3+OtRjF7ZP/HbgqAF5Vq3CSew9MiDsGvKnBv3dmRKyKrvpQZXQQcWx8MpdCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706768360; c=relaxed/simple;
	bh=0WQrkAB5ozC8QOgt+WRwba2ZGzlj0F5COm9Urd2BqYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgBfgoiXniUYb2enIzOyu0snhh/1C2H/4sAxkp/rxFjUZ2r2u4cPPugTxI2J5Zhos9injLeLIrsfTvtwOE6+UKK00l2h23S1DsOHraBwKSEehahhkFW//lIPYlBrcx1U8xFgE2EvWcJwMp9f/7tjozuiihADJt6Fk2F3Rx9zvjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2z2SCyDS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=jSO6Qj6Tg/KjBkU82SdhtrrXMKEyhoKG9bXOHoyz9tc=; b=2z2SCyDSFP2EJALXk9/uEzwDLs
	dlFh6vMrCZPMU1uDerHRDtcxgzt988VbC8t+1xS2ESAW2ER/wKqzkw1wfznx85XZvF774N2jcxt82
	rReOtIh0EFg4UkwI4yLX7xz/x+I2aBEqpBb/pVQrGBzj3DH7e5PR/UjaZbRBkdhSHjNoHyxFZJL3i
	RWBBWtLj5+DiikqSZl3RT6iR9hMGTNhfGr6ruNPes/etEw4T7AupU6qmEa+1K/R/crk9k6WXnhc0s
	eb342GUyjSmQeFNnREFiw2vjFDs8y/N9npkiMJl8jbZQ/6j8wWl6Z/71D5vUW64ymkKJChgiCUz0k
	HbfdqA2Q==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVQPr-00000006jz7-0mjm;
	Thu, 01 Feb 2024 06:19:15 +0000
Message-ID: <618cb278-0b9f-4cc2-bfc6-bfcbefc79b69@infradead.org>
Date: Wed, 31 Jan 2024 22:19:14 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] KVM: arm64: fix many kernel-doc warnings
Content-Language: en-US
To: linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20240117230714.31025-1-rdunlap@infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240117230714.31025-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Any comments on this series?

Thanks.

On 1/17/24 15:07, Randy Dunlap wrote:
> Fix a bunch of kernel-doc warnings in arch/arm64/kvm/.
> 
>  [PATCH 01/10] KVM: arm64: debug: fix kernel-doc warnings
>  [PATCH 02/10] KVM: arm64: guest: fix kernel-doc warnings
>  [PATCH 03/10] KVM: arm64: hyp/aarch32: fix kernel-doc warnings
>  [PATCH 04/10] KVM: arm64: vhe: fix a kernel-doc warning
>  [PATCH 05/10] KVM: arm64: mmu: fix a kernel-doc warning
>  [PATCH 06/10] KVM: arm64: PMU: fix kernel-doc warnings
>  [PATCH 07/10] KVM: arm64: sys_regs: fix kernel-doc warnings
>  [PATCH 08/10] KVM: arm64: vgic-init: fix a kernel-doc warning
>  [PATCH 09/10] KVM: arm64: vgic-its: fix kernel-doc warnings
>  [PATCH 10/10] KVM: arm64: vgic: fix a kernel-doc warning
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: James Morse <james.morse@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Zenghui Yu <yuzenghui@huawei.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: kvmarm@lists.linux.dev
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> 

-- 
#Randy

