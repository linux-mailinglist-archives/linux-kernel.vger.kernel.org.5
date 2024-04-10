Return-Path: <linux-kernel+bounces-138123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A0989ECDC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CAE61F21513
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7621A13D2BE;
	Wed, 10 Apr 2024 07:58:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D47C13D277
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735908; cv=none; b=EdCdAZoSUSJLuki3UkQ0Zrst8wIvw61CGmg3lredFexBTUpqOd9hdAk7DaA0btIyDBBXfL5CwHuc5DAuuwlVDeuUodFqBT20e2CPkN9qFZZTaFjTaA8hmN1OliA0t1U1tbHiNWdEZ9FWtS5eHPoEgiinMUf8czlGOLnSHm8fppg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735908; c=relaxed/simple;
	bh=SVFpJC7hpWdsEN6oXEfmHE/kIbC1/z81n1486492/eI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nprBeHRl4r5uMpyPJC7sZ8yL37VcZU3EtJ/tismQoXymI+yRjmoRPm4u7HMCyRFYw1aHiYUv6skDFMnfZ+YP2aT2817Pw8WSqpe6/FxImza14nRd/wcl+9HmWiI4X0QgcSxwObRwA/SmFGWuhYyZ4tEkJCOTuRpNRtsUGeOwas8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3D251480;
	Wed, 10 Apr 2024 00:58:55 -0700 (PDT)
Received: from [10.162.43.6] (a077893.blr.arm.com [10.162.43.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 802AF3F766;
	Wed, 10 Apr 2024 00:58:20 -0700 (PDT)
Message-ID: <bcc75076-3baa-4a23-8709-0012456f30a2@arm.com>
Date: Wed, 10 Apr 2024 13:28:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v3 3/3] arm64: tlb: Allow range operation for
 MAX_TLBI_RANGE_PAGES
To: Gavin Shan <gshan@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
 maz@kernel.org, oliver.upton@linux.dev, ryan.roberts@arm.com,
 apopple@nvidia.com, rananta@google.com, mark.rutland@arm.com,
 v-songbaohua@oppo.com, yangyicong@hisilicon.com, shahuang@redhat.com,
 yihyu@redhat.com, shan.gavin@gmail.com
References: <20240405035852.1532010-1-gshan@redhat.com>
 <20240405035852.1532010-4-gshan@redhat.com>
Content-Language: en-US
In-Reply-To: <20240405035852.1532010-4-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/5/24 09:28, Gavin Shan wrote:
> MAX_TLBI_RANGE_PAGES pages is covered by SCALE#3 and NUM#31 and it's
> supported now. Allow TLBI RANGE operation when the number of pages is
> equal to MAX_TLBI_RANGE_PAGES in __flush_tlb_range_nosync().
> 
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  arch/arm64/include/asm/tlbflush.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 243d71f7bc1f..95fbc8c05607 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -446,11 +446,11 @@ static inline void __flush_tlb_range_nosync(struct vm_area_struct *vma,
>  	 * When not uses TLB range ops, we can handle up to
>  	 * (MAX_DVM_OPS - 1) pages;
>  	 * When uses TLB range ops, we can handle up to
> -	 * (MAX_TLBI_RANGE_PAGES - 1) pages.
> +	 * MAX_TLBI_RANGE_PAGES pages.
>  	 */
>  	if ((!system_supports_tlb_range() &&
>  	     (end - start) >= (MAX_DVM_OPS * stride)) ||
> -	    pages >= MAX_TLBI_RANGE_PAGES) {
> +	    pages > MAX_TLBI_RANGE_PAGES) {
>  		flush_tlb_mm(vma->vm_mm);
>  		return;
>  	}

