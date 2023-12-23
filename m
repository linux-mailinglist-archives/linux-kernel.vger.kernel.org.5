Return-Path: <linux-kernel+bounces-10217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C9281D163
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21941F23D6E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F786123;
	Sat, 23 Dec 2023 02:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EisaBF7Z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568334C6C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 02:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703300288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7/gIS0dmThAjHMew85bTo42lIhhQ7TiHTigvXZh07g=;
	b=EisaBF7ZlwS71aaiR2UxjWLbgBnUxaYzFoQ0ISy8M0CRN6GL7IRuA3wKMBjsvgkncJg+eO
	gGuL19msv4ZHVUn/J+X60eBU/GAiVaH+6nMCX+ARevRCeLDnTABMBYXIbzuDGpawEccjgQ
	SQ7e1m0az0F3rKk6aGh1zYiDQEP6Wms=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-5sWRtSEPONaO_W5hybXACA-1; Fri, 22 Dec 2023 21:58:06 -0500
X-MC-Unique: 5sWRtSEPONaO_W5hybXACA-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-59436f69e8cso1694326eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 18:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703300285; x=1703905085;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p7/gIS0dmThAjHMew85bTo42lIhhQ7TiHTigvXZh07g=;
        b=cOxWUoDy5dEstzVboartRbtDGlKCreTHwSnJJgt4sDmvNo8Yk/HAPyFIlxjYpAOhEq
         qXf8GBTbjvPjT1uM7P+COjZQSwXYfMwV/HRA548LkLPQTHq5cuIaNtLIavr+YI/4+Pu9
         oQQxxv3/f8iA25G72QXBGIipLYbRp/iBa8wAiAja+8HWtV8aC2mc0zQdCkMuvSUtsWVo
         8eWA26nSlgiszJX2IhzJJC6qXx5NMQkPq2rXQJWtfaY2zhNF8bZINaAGR3nOdoCe1c5W
         Ufx/pXOYoQNCIAPZ6HTvVVXTgfk+UadpTsqZ2R1Q8gbEbRpl7EQGoTF3hLZ9qSGwCpom
         +Hug==
X-Gm-Message-State: AOJu0YwicALTwIQrSmIVv8Fhmxri7dVHSPQ6BW4E3J7zN5ywPB08RIRp
	MwByXZ471dni31W9RFv4Bx+MDL+3XlAz4QOhBmcksQzPuVfMZ5kgoOJXrKRVQlz+Z6gwVicg3Ee
	44LkdpxXxrBaX0lLRFLEOZzGyyNG/+mXO
X-Received: by 2002:a05:6358:281e:b0:172:b539:3fcd with SMTP id k30-20020a056358281e00b00172b5393fcdmr2520782rwb.53.1703300285398;
        Fri, 22 Dec 2023 18:58:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFp/Z1JKa0hiVBtqCwmkFA7+oaDvqiyyXhUWFWFs5CbKJ6sOloXd7Rb4vykiapW96ln36Ga+w==
X-Received: by 2002:a05:6358:281e:b0:172:b539:3fcd with SMTP id k30-20020a056358281e00b00172b5393fcdmr2520762rwb.53.1703300285090;
        Fri, 22 Dec 2023 18:58:05 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ed:60ec:45a7:dfa:5e5:9eed])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090aae0800b0028c2b4f5f32sm335968pjq.3.2023.12.22.18.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 18:58:04 -0800 (PST)
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
Subject: Re: [PATCH V3 1/4] riscv: mm: Fixup compat mode boot failure
Date: Fri, 22 Dec 2023 23:57:54 -0300
Message-ID: <ZYZMsgL9Bcz1J_Bd@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222115703.2404036-2-guoren@kernel.org>
References: <20231222115703.2404036-1-guoren@kernel.org> <20231222115703.2404036-2-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Dec 22, 2023 at 06:57:00AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> In COMPAT mode, the STACK_TOP is DEFAULT_MAP_WINDOW (0x80000000), but
> the TASK_SIZE is 0x7fff000. When the user stack is upon 0x7fff000, it
> will cause a user segment fault. Sometimes, it would cause boot
> failure when the whole rootfs is rv32.
> 
> Freeing unused kernel image (initmem) memory: 2236K
> Run /sbin/init as init process
> Starting init: /sbin/init exists but couldn't execute it (error -14)
> Run /etc/init as init process
> ...
> 
> Increase the TASK_SIZE to cover STACK_TOP.
> 
> Cc: stable@vger.kernel.org
> Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index ab00235b018f..74ffb2178f54 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -881,7 +881,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>  #define TASK_SIZE_MIN	(PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
>  
>  #ifdef CONFIG_COMPAT
> -#define TASK_SIZE_32	(_AC(0x80000000, UL) - PAGE_SIZE)
> +#define TASK_SIZE_32	(_AC(0x80000000, UL))
>  #define TASK_SIZE	(test_thread_flag(TIF_32BIT) ? \
>  			 TASK_SIZE_32 : TASK_SIZE_64)
>  #else
> -- 
> 2.40.1
> 

I am not really involved in the issue this is solving, so I have no 
technical opinion on the solution. 

IIUC there should always be (TASK_SIZE >= STACK_TOP), so by itself this 
is fixing an issue.

I have reviewed the code and it does exactly as stated into the commit 
message, so FWIW:
Reviewed-by: Leonardo Bras <leobras@redhat.com>


