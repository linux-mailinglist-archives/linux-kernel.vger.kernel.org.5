Return-Path: <linux-kernel+bounces-54106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 508F984AADD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810B71C23F1C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C074D5A7;
	Mon,  5 Feb 2024 23:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Ril7amsS"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF814495F0
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 23:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707177239; cv=none; b=uxOIiKjgNLRCyY+0Lpu9I1OQgUqra8A05dHaSxHcNAqf44IWZcOjWbDjsxi3eVpTp9T72d1BUgcVqS0g0okyAdoW/I4famxYNxsKJwhBLKu3WozncdqiaZ5HP16J1NGtINbmrsdu5vgzACLeys7MYtQL2kj78SblkaZbkTAD5nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707177239; c=relaxed/simple;
	bh=OGoNuHCzozgkC3QL/rGwBky0y/XUcHin0BTqRYK7EaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZig4OUR118L+wfJ5bWlCCgnEtay9v/+Ri47hJGdF34OWoofUeutmlyqQduPpSdEAyR6aPea9QzFn2xF3uqXVVN7LAx+/jVTIoq+2x/e+gae21NfF+xowWNi/kOKJCsWATdQFYHKBCs99R21gZg0p3xjccDToRzUZWm+4UpN5dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Ril7amsS; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d8b519e438so4835089a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 15:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707177237; x=1707782037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hmrdDifKn+uVsNlfDzCvuZfjS7ayNWNTt2suseO1un4=;
        b=Ril7amsSFVpyGMslrLzeOzNZVZ551pvW6l4nQD84218B4EyWOJ9nN9Fkag1q9SpWS+
         nx9W0zmLxISZp9OXNIH+zNGR9NBdEnYo7aRG7iB1qZwEUjAur4mcfqmEF7y20LWSW0lD
         wi09+5QfPH+g+HsCXnrFaA/9MV7WCTAcLIvlc2/VycQ1II0FLQUsYPUTB3QcboSqXxAR
         oVDXoz4+poyf9H5o2PImQ8LcijXjjC52MpemYYyU4Cz7tA68CiMp/6trNpRcqCpNtNN1
         5iGgSe8vgUT8HXihuXODzsyPR/h4/FOWFidA5FOq9c5HQ6MxycRv3mYXbcEK4qmNU6ug
         wvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707177237; x=1707782037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmrdDifKn+uVsNlfDzCvuZfjS7ayNWNTt2suseO1un4=;
        b=GkYRW1VN44o28L8qBAmVveexS5wB1U6UWwA384jE5ukBzuJ0RQgxxuVO8w5Moscw7n
         oQ/riVylNYh0eGJPf048tvY+KKvvI5zFx9PheizB95FHAo4mbXuHMZlWnItFm52tJbDu
         6ptknEhOKqz816KflShaYLnQQb3n0Tkg7sxJPdY7F0i57GFr5wohVFlSY96q97fWE9gQ
         1vdZBG6vg6fezee7E0pzvTHTWTl7Lr/3shpyjdugIdTw0q/4fqGMwzR9ae90H9aVarQX
         +RZ+arl7DWVrGW6Fwjt6W+OCjtlrFzeUwIgZYkkQK0+XR72pcPl8FuudlkPusW0NGQxH
         l/2w==
X-Gm-Message-State: AOJu0YzcdtVLNddlXLllkQYYrnfBc4emg3qkVK0etNWLMtIp4RO8Vj4y
	LhNW34YFbR57Vau8q1HoGwwfw7xB4I36zSWgcmiPvnKH3vNAoGyashzVwsFJyfE=
X-Google-Smtp-Source: AGHT+IHeI/+Sp824UroO/mDYidk3cFb94YOApkQqYdkLtM9PHmtd5rblgX/GhroclrmfDZVRJjAJvQ==
X-Received: by 2002:a05:6a21:2785:b0:19e:89ae:9b52 with SMTP id rn5-20020a056a21278500b0019e89ae9b52mr51387pzb.7.1707177237249;
        Mon, 05 Feb 2024 15:53:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVwcZhTk4c0u0np/uhoHXLwPQ/Wcj2MaeQOM9FqkgxTj2vuWoI/YVq71BO5+lhQYk5e3bISfbaGFDwsMYle96R7byvptgPpHlcZishruHbiB2ER4cRLKUlSlSasxMzD1Asz14TVXCdqBFQGhWo0gN5hQcCmHn1noPYecH0xtKK6GttXmIn4v/8Z3JF41HtMi0WjDjq5Gj2Nv/KL4aEAO6D3s3OGA7wAtbIdL04MZdkkF2CmOjQQvL8jlAJQUqHONWA/1DPJdI0imC15vjTHcmrkvgr7TEDqVli0Mlg9oQnxUwoZXAO1VedoHrNEPmI64j11xtnv2+MgUEhwUUjFpcaFUjralvHAUvXcA5fPQc2628t1uCSBbOcw3jy7ESMZhGUDpplvpP7R7VHdhx+GVMTxtl7eE5RKZQfmkoU4KkGTOYG2+pYJWJumzly5fwvjX22/7ZOWnO5JAcWy1+RlzpyruTNclkK+EwLEI6X/GyAOPAFqnt7d5A==
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id e12-20020a62aa0c000000b006ddc7de91e9sm444758pff.197.2024.02.05.15.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 15:53:57 -0800 (PST)
Date: Mon, 5 Feb 2024 15:53:54 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes] riscv: Flush the tlb when a page directory is
 freed
Message-ID: <ZcF1Er55ClKgJtHJ@ghost>
References: <20240128120405.25876-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128120405.25876-1-alexghiti@rivosinc.com>

On Sun, Jan 28, 2024 at 01:04:05PM +0100, Alexandre Ghiti wrote:
> The riscv privileged specification mandates to flush the TLB whenever a
> page directory is modified, so add that to tlb_flush().
> 
> Fixes: c5e9b2c2ae82 ("riscv: Improve tlb_flush()")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/tlb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
> index 1eb5682b2af6..50b63b5c15bd 100644
> --- a/arch/riscv/include/asm/tlb.h
> +++ b/arch/riscv/include/asm/tlb.h
> @@ -16,7 +16,7 @@ static void tlb_flush(struct mmu_gather *tlb);
>  static inline void tlb_flush(struct mmu_gather *tlb)
>  {
>  #ifdef CONFIG_MMU
> -	if (tlb->fullmm || tlb->need_flush_all)
> +	if (tlb->fullmm || tlb->need_flush_all || tlb->freed_tables)
>  		flush_tlb_mm(tlb->mm);
>  	else
>  		flush_tlb_mm_range(tlb->mm, tlb->start, tlb->end,
> -- 
> 2.39.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


