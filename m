Return-Path: <linux-kernel+bounces-16979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CF68246C5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB83286C98
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56B225562;
	Thu,  4 Jan 2024 16:58:54 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE60225550
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BFA4C15;
	Thu,  4 Jan 2024 08:59:37 -0800 (PST)
Received: from [10.57.44.155] (unknown [10.57.44.155])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A23ED3F64C;
	Thu,  4 Jan 2024 08:58:47 -0800 (PST)
Message-ID: <11c9ffee-5dbc-4f16-90f5-6f5c23293f52@arm.com>
Date: Thu, 4 Jan 2024 16:58:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] arm64: KVM: Fix renamed function in comment
Content-Language: en-GB
To: James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 broonie@kernel.org, maz@kernel.org, acme@kernel.org
Cc: Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Rob Herring
 <robh@kernel.org>, Miguel Luis <miguel.luis@oracle.com>,
 Jintack Lim <jintack.lim@linaro.org>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Helge Deller <deller@gmx.de>,
 Arnd Bergmann <arnd@arndb.de>, Vincent Donnefort <vdonnefort@google.com>,
 Fuad Tabba <tabba@google.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Joey Gouly <joey.gouly@arm.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Jing Zhang <jingzhangos@google.com>, linux-kernel@vger.kernel.org
References: <20240104162714.1062610-1-james.clark@arm.com>
 <20240104162714.1062610-2-james.clark@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240104162714.1062610-2-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/01/2024 16:27, James Clark wrote:
> finalise_host_mappings() became fix_host_ownership() in
> commit 0d16d12eb26e ("KVM: arm64: Fix-up hyp stage-1 refcounts for all
> pages mapped at EL2") so update the comment.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> ---
>   arch/arm64/kvm/hyp/nvhe/setup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
> index cd2f39388251..b5452e58c49a 100644
> --- a/arch/arm64/kvm/hyp/nvhe/setup.c
> +++ b/arch/arm64/kvm/hyp/nvhe/setup.c
> @@ -150,7 +150,7 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
>   	 * can't be donated or shared with another entity.
>   	 *
>   	 * The ownership transition requires matching changes in the host
> -	 * stage-2. This will be done later (see finalize_host_mappings()) once
> +	 * stage-2. This will be done later (see fix_host_ownership()) once
>   	 * the hyp_vmemmap is addressable.
>   	 */
>   	prot = pkvm_mkstate(PAGE_HYP_RO, PKVM_PAGE_SHARED_OWNED);


