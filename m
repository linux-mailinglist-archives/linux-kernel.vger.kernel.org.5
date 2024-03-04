Return-Path: <linux-kernel+bounces-90953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C623E87077D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F91283F3B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254244E1AD;
	Mon,  4 Mar 2024 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xRN9fOS6"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD799495F0;
	Mon,  4 Mar 2024 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570869; cv=none; b=nY+fo8O2uVsfO9EtUvSTnDtIJ8HQXAbE/5ET3vpjnc2DRAyTamylPYM3j0G60hYkUyENmjnWIJ+XVARBC+u67ijYd/pjQUiNWHbaOcG8Ye4Yf1CHjIFSReEhilM8m42qadUJEXuIZWb3onlvLTe9fviLREJCpc8ieB4K9B9dy6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570869; c=relaxed/simple;
	bh=vqaCs6mYffPI4elLE9hYWmT1AKYqmXutoymuIOPZcqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g18I7JNW/BSQ+Nr4iRLDdJ5SBcbwouVEYoVjoQKQYVD7CFls9nKOj6ZlOvRcWt7Z4y/q1bsJ2TZd4h0JQ2GMarDMe6bEC5D1qDSgtwXdtv6bDdANNuCG5PrMLdHC8VcNxrQLTIUITkDQydMiMCbY34AwrhNFi/uGDSnw0IRSs74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xRN9fOS6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=7bG+hQSw2tqOeEGkJrcSkS7HC1Vmfa8Jpar1AvYkw14=; b=xRN9fOS6DqHoknrHLLGcINz4Zr
	npNQ1RWxwvOowQwre5eHRLhnChgbIX5YQYmi6IoEClvlPyfZyqNlvi2ioUuvVp6cB/Bu25sIKMen6
	VcLPtxaf1g60wsrHqxh9XebsN+77vhbsEJP4Yxl6uFVOYPSed3PeqMBFFXCMvwU4jBT4NA4tmDvsu
	5xZ6+NtwxkpL36iuWruYYApoUG5ElF3wautokUDz+Zuo3TpK/bdc9+6zpAMKlc27T0IiHCNPkEH70
	2ZsBdXcloKdswWgqDdhq5NiPtUw34Pv004yIMLuZP1JVRxUGujPCnpAzIWxoeS+4VpHjyHfdQ+uu7
	ocVXxKzA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhBTe-00000009sto-12Ks;
	Mon, 04 Mar 2024 16:47:46 +0000
Message-ID: <b7f3fb0c-6c26-42c7-858c-231f4982a761@infradead.org>
Date: Mon, 4 Mar 2024 08:47:43 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Fix compilation error with FAST_GUP and rv32
Content-Language: en-US
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240304080247.387710-1-alexghiti@rivosinc.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240304080247.387710-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/4/24 00:02, Alexandre Ghiti wrote:
> By surrounding the definition of pte_leaf_size() with a ifdef napot as
> it should have been.
> 
> Fixes: e0fe5ab4192c ("riscv: Fix pte_leaf_size() for NAPOT")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  arch/riscv/include/asm/pgtable.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 25ca14f6942c..54d26a07fa63 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -439,9 +439,11 @@ static inline pte_t pte_mkhuge(pte_t pte)
>  	return pte;
>  }
>  
> +#ifdef CONFIG_RISCV_ISA_SVNAPOT
>  #define pte_leaf_size(pte)	(pte_napot(pte) ?				\
>  					napot_cont_size(napot_cont_order(pte)) :\
>  					PAGE_SIZE)
> +#endif
>  
>  #ifdef CONFIG_NUMA_BALANCING
>  /*

-- 
#Randy

