Return-Path: <linux-kernel+bounces-42395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FA08400C8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022D61F2128F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2931054F82;
	Mon, 29 Jan 2024 09:01:06 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C7C54BEC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518865; cv=none; b=FmOTHZrwloBS6yQIjlmA/f/v8MakIp3WcC3UOnhrommgDsmP6mhJGFGU72KD6YBGXhPhMcD3a9B9vcrUmi0bZjhu+fJ8E6UJ8h6o5vCP5BbfnuAQ50PrsVP5ZHWRapeVU8xpzVlYfMenmdLdjEG0HS0qS4PN5tfIK08cGX6LmKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518865; c=relaxed/simple;
	bh=HICoyiV/FoR6mS+MJstzXo2ZfOx/kxWtYORG3VBolcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAhf4xjoLiM+oIkgVydzFQbmL94mD/HM7HS4eo+dDQU999fZvMYkApaOaTMi7fVAQza4DeXDjKyYtAJRP4CJjfVxYjCTxU0kNKa91w1SGimETvUXiHIiEhHfl+WjTYwjHSJyWeOa/X2aBcYyJaxcghsASSrL7/OiOD0Z9C0opr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ce74ea4bf2so1463574a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 01:01:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706518863; x=1707123663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhYaJDE5CFB8YW0bqykwvmnJq3NUnNOhl7XZdq+k3Iw=;
        b=GoHy2qNJimS98/aD4gSUua18SP941P/bBX+GKUIOIlQp6TPUqUNF7ThuA/hW6pBp88
         gm5SkawzEee92vnTiY3nSY1xCff+I0t5VGGOmtnhzFierd2zQNzSLeTqw8PQzgGslj5n
         5X1y+5wLijiHDYeXzEZro5DGhhkC78zZTb6KyL+61du1LiUh3MajNrrZRVUBa5wgrToH
         B1Be+1om51NFJ8dNXb7IDzsfbnjEyr3bBSjz/r9B3YR1CwjV0li1Rx5tRLM/6qEkUK4+
         NaCnpXZuxfNqs90n2cfg4QRAYGcu7j6Qrn2yfVsH2czfSJmrEqyQmduwgy+cMhnBBFXe
         QAjw==
X-Gm-Message-State: AOJu0YznG8P41V8c1/aRwvdw2IJc+Yvx/vm4MbrJknX5O4EzPQ2Dno8d
	bMarnZRJo0yilkGf7urfpafJPpvzl+X4lCRH4M5HBxZm9tftWqhyArpfqk3H
X-Google-Smtp-Source: AGHT+IFfZsGglwKUIEhC2sDvoOnVcokEfT9wX9xbq8ZJ+OYDVfKyQQYX2szarFvqGGSfpI0AQekNZA==
X-Received: by 2002:a05:6a20:7886:b0:19c:748a:303a with SMTP id d6-20020a056a20788600b0019c748a303amr4030758pzg.17.1706518863496;
        Mon, 29 Jan 2024 01:01:03 -0800 (PST)
Received: from snowbird ([136.25.84.107])
        by smtp.gmail.com with ESMTPSA id k28-20020aa7999c000000b006dbac48633bsm5359811pfh.189.2024.01.29.01.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 01:01:02 -0800 (PST)
Date: Mon, 29 Jan 2024 01:01:00 -0800
From: Dennis Zhou <dennis@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Fix wrong size passed to
 local_flush_tlb_range_asid()
Message-ID: <ZbdpTPMOw4lsPxBi@snowbird>
References: <20240123132730.2297719-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123132730.2297719-1-alexghiti@rivosinc.com>

Hi Alexandre,

On Tue, Jan 23, 2024 at 02:27:30PM +0100, Alexandre Ghiti wrote:
> local_flush_tlb_range_asid() takes the size as argument, not the end of
> the range to flush, so fix this by computing the size from the end and
> the start of the range.
> 
> Fixes: 7a92fc8b4d20 ("mm: Introduce flush_cache_vmap_early()")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/mm/tlbflush.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 8d12b26f5ac3..9619965f6501 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -68,7 +68,7 @@ static inline void local_flush_tlb_range_asid(unsigned long start,
>  
>  void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
>  {
> -	local_flush_tlb_range_asid(start, end, PAGE_SIZE, FLUSH_TLB_NO_ASID);
> +	local_flush_tlb_range_asid(start, end - start, PAGE_SIZE, FLUSH_TLB_NO_ASID);
>  }
>  
>  static void __ipi_flush_tlb_all(void *info)
> -- 
> 2.39.2
> 

Sorry for the delay, I just pulled this into percpu#for-6.8-fixes. I'll
send it to Linus this week.

Thanks,
Dennis

