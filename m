Return-Path: <linux-kernel+bounces-16161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FB88239EF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE31F2881EC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B0E4A25;
	Thu,  4 Jan 2024 00:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sLMjNgBN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242CE4417;
	Thu,  4 Jan 2024 00:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=WuhfUh8jXuztGUAOt2fo7d6uquLKe5IrFutXxBh3an4=; b=sLMjNgBNDM0+lRrZPLRhL2aoWQ
	YJ4npP3lBFAdezsjPJ9QeUY5PbciA/y1nS9sU1m8gkxHD72vuFRu7ZLgIZ+6K1cerhCq8uzKrAA08
	6+6TNJ29pxS08KyDehQ/uM/mRWQqGhrTwaCOfyML5K40dx/GVhPVxoGzr0Uo89wuy6RYW358MNmxu
	TxMCq7O8/eMMWDtKm4In6ODqIWL7GoAY/E+8kkaWqfRwQYV7ofgNQvDgdro703plxnilvsl+d8j9n
	7qRaN5roEv9iafzRRYw2P4xeO4lUN0WXr3oSKaXpiIBlWDO6SxC2cbxsqZNYstkn01APrcVpwjULx
	rM4goohw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rLC4k-00CWwd-06;
	Thu, 04 Jan 2024 00:59:10 +0000
Message-ID: <26cfe5b6-a11f-477e-a19e-b37e87f001a0@infradead.org>
Date: Wed, 3 Jan 2024 16:59:09 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] KVM: arm64: Fix typos
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
References: <20240103231605.1801364-1-helgaas@kernel.org>
 <20240103231605.1801364-6-helgaas@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240103231605.1801364-6-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/3/24 15:16, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos, most reported by "codespell arch/arm64".  Only touches comments,
> no code changes.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Zenghui Yu <yuzenghui@huawei.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: kvmarm@lists.linux.dev
> ---
>  arch/arm64/include/asm/kvm_hyp.h | 2 +-
>  arch/arm64/kvm/arch_timer.c      | 2 +-
>  arch/arm64/kvm/fpsimd.c          | 2 +-
>  arch/arm64/kvm/hyp/nvhe/host.S   | 2 +-
>  arch/arm64/kvm/hyp/nvhe/mm.c     | 4 ++--
>  arch/arm64/kvm/inject_fault.c    | 2 +-
>  arch/arm64/kvm/vgic/vgic-init.c  | 2 +-
>  arch/arm64/kvm/vgic/vgic-its.c   | 4 ++--
>  8 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
#Randy

