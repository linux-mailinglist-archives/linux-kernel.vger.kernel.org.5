Return-Path: <linux-kernel+bounces-10212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1676881D14A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8A4BB2347C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66C5ECF;
	Sat, 23 Dec 2023 02:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSK8eqBs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7F1EC2
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 02:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703299926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6FsXvda8piHC8mKVnVEUK8EOJKqYtl+i/XG7XRDw0vA=;
	b=JSK8eqBsPCc59sSrNB3kYBMfT/mJp2vmZP25/TjmsrBZ/A6kEnAFRu7ITCp0djbVmYOxGY
	8yCdDGYo/bTWD4UUzWLQ/xHNelNdQgKKuIFq11/Xefp78kUa8+U6WRAmeQZL5sqVwp8Ia7
	rd8OnrYx8fuQk1tIL1y08ITad0vy0AQ=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-CZId10nLMgq1fpZRsiqeLQ-1; Fri, 22 Dec 2023 21:52:04 -0500
X-MC-Unique: CZId10nLMgq1fpZRsiqeLQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6d9416d0a3bso1307785b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 18:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703299923; x=1703904723;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6FsXvda8piHC8mKVnVEUK8EOJKqYtl+i/XG7XRDw0vA=;
        b=nKNm4BlS+88lh4RoIvix4JKqawZT9g5fJEWu47Qu8GMxP1lDzaqt0Z4NrWHDk03dAy
         H67qLz0EJU5605qj+g8ZuXTjKFB/10IHxQ/y/bN1ysAPJwA1CG3oErS5mizNajvP/oLD
         EjGT3+8wbhJaZdG07CQXHIx0yKBjyINM7klmFPEabp4aZGU180DAYbj6mdO5Z0frSrMD
         8ugMT2kizo6Wr7G66NQuJHGO35bGatGbrpFyZaXahcjiFeM+yQNGPXB/2K2ejNNShzka
         hQQBFQtmJppQneLMrhcglFdVP7jLhAY4FVtQ5BRRoz8y2qrWXoK/+6LV8Rt4ZAvn8L6Y
         vH3w==
X-Gm-Message-State: AOJu0YwHiP26MgF2ej/eK26F4LyERF+J5ew7lzKYva73RSnFLKAAcX0j
	ktSnVIgG9f+AQSwEOlCRUJLwFXfOUAqB7AqIrgRqDdiaiZhxrCSoV2D1EhptfeQEf4+Gq42AP+c
	L0hlAQKbcqoUCRgLYzHix4RG6pcYfwbj8
X-Received: by 2002:a05:6a21:78a0:b0:195:3e62:29b0 with SMTP id bf32-20020a056a2178a000b001953e6229b0mr977567pzc.81.1703299923023;
        Fri, 22 Dec 2023 18:52:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6xlks/80GQ9vCPW4KsUSOdHlvisDMKZyHP//fnCHq7v50UmfEp6S/CaJroh718uKlIh90zA==
X-Received: by 2002:a05:6a21:78a0:b0:195:3e62:29b0 with SMTP id bf32-20020a056a2178a000b001953e6229b0mr977563pzc.81.1703299922697;
        Fri, 22 Dec 2023 18:52:02 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ed:60ec:45a7:dfa:5e5:9eed])
        by smtp.gmail.com with ESMTPSA id jg13-20020a17090326cd00b001d398876f5esm4131410plb.121.2023.12.22.18.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 18:52:02 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: guoren@kernel.org
Cc: Leonardo Bras <leobras@redhat.com>,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alexghiti@rivosinc.com,
	charlie@rivosinc.com,
	xiao.w.wang@intel.com,
	david@redhat.com,
	panqinglin2020@iscas.ac.cn,
	rick.p.edgecombe@intel.com,
	willy@infradead.org,
	bjorn@rivosinc.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	linux-riscv@lists.infradead.org,
	Guo Ren <guoren@linux.alibaba.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH V3 2/4] riscv: mm: Fixup compat arch_get_mmap_end
Date: Fri, 22 Dec 2023 23:51:48 -0300
Message-ID: <ZYZLRNlEpVXECyq9@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222115703.2404036-3-guoren@kernel.org>
References: <20231222115703.2404036-1-guoren@kernel.org> <20231222115703.2404036-3-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Dec 22, 2023 at 06:57:01AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> When the task is in COMPAT mode, the arch_get_mmap_end should be 2GB,
> not TASK_SIZE_64. The TASK_SIZE has contained is_compat_mode()
> detection, so change the definition of STACK_TOP_MAX to TASK_SIZE
> directly.
> 
> Cc: stable@vger.kernel.org
> Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/processor.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index f19f861cda54..e1944ff0757a 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -16,7 +16,7 @@
>  
>  #ifdef CONFIG_64BIT
>  #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
> -#define STACK_TOP_MAX		TASK_SIZE_64
> +#define STACK_TOP_MAX		TASK_SIZE
>  
>  #define arch_get_mmap_end(addr, len, flags)			\
>  ({								\
> -- 
> 2.40.1
> 


LGTM. 

FWIW:
Reviewed-by: Leonardo Bras <leobras@redhat.com>


