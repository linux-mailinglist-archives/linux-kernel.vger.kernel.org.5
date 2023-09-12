Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D503879DA0D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjILUbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjILUb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:31:29 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A127510DF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:31:25 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c39bc0439bso1891205ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694550685; x=1695155485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HS4AS8VbR5V4QhF/RUpoUXcwG9s1gQlJ8VLh2Gkpc+o=;
        b=os5brtH8tGQKHkZFzg6zag7Uz7o+IoBM/vL1YFhCgMVrdu5VN8JQOK6On7LLVfSLHh
         DWL8L1F70HBrcLR2KdyVgqQh6CbwlXQ1WTNkgguFufoSw0a9JVLP32ro3mAa7WXU7jzE
         vYA8GGVyIIRGSHa1vrx3zZPDAw689Jzz3M+Coihe+FxZxtDn5S60qHfVVi/rweFRpoOa
         5361rkUU7wQVq+ic4z4eWOYCQa+ojeHC/MQ9GV3yVsze0VVxz6qAYv2Uu6ovkHGu+GXN
         vwIqPnfm4pVpzAH7DM5cj/R/xTGTwaiCWz90muqzXUS8enyyqCAHkrmeyNACUNS8OpCj
         b69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694550685; x=1695155485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HS4AS8VbR5V4QhF/RUpoUXcwG9s1gQlJ8VLh2Gkpc+o=;
        b=oFrH8CnUXp3L0iyO1WlEcxYtzl6omIJa2K7FSVWFUEhtkajUbC76LelUqshy8A3Xoa
         rZUGS/ctm8ssxu42j/qUOappjDmqPDe/WlLLpt2Go8X0Z+SlsVhPKnzJeiDojy++QHV4
         t3ySxr8HgbrMRL5XoA3yasUyOAwDVmDKQHQ2fdbeRXI4xcq2zYLxmng5BHkjrjTJafJE
         pdSTuEtLMsIrR/Dh97rFljTj7IHGkqazCeIqNZMu+Rk9FeVWmiyf3iNa6tz2Qqdud+/W
         7NZcezd/CcYUTbrYBY+s2iC44aGcAMCNSM7TnL2Syi/dQLTJzs0nuEoSahhMj0nOn0WJ
         zOEA==
X-Gm-Message-State: AOJu0Yw+inPvaQiZ6GmiRu8yuO+klT3Wh3VX+GN+82W+PyUyRZL+4NNp
        Z2V3xvzj4DJqaf+guCCwiHM1HFC63ns=
X-Google-Smtp-Source: AGHT+IF1jvtZNZztOXptTJDBThYNLnBm2KUZaXghQjZd7s8ArIIYzQTsJt4XtO34Zo2jt3bqD3AHDQ==
X-Received: by 2002:a17:903:1211:b0:1b7:ca9c:4f5c with SMTP id l17-20020a170903121100b001b7ca9c4f5cmr4456426plh.28.1694550684952;
        Tue, 12 Sep 2023 13:31:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b001bb750189desm8912783plc.255.2023.09.12.13.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 13:31:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 12 Sep 2023 13:31:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Helge Deller <deller@gmx.de>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Fix lockdep static memory detection
Message-ID: <9d0cb447-2556-4609-a96f-13875ddeeda3@roeck-us.net>
References: <ZQC5jS/Kc/JiBEOa@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQC5jS/Kc/JiBEOa@p100>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:18:37PM +0200, Helge Deller wrote:
> Since commit 0a6b58c5cd0d ("lockdep: fix static memory detection even
> more") the lockdep code uses is_kernel_core_data(), is_kernel_rodata()
> and init_section_contains() to verify if a lock is located inside a
> kernel static data section.
> 
> This change triggers a failure on LoongArch, for which the vmlinux.lds.S
> script misses to put the locks (as part of in the .data.rel symbols)
> into the Linux data section.
> This patch fixes the lockdep problem by moving *(.data.rel*) symbols
> into the kernel data section (from _sdata to _edata).
> 
> Additionally, move other wrongly assigned symbols too:
> - altinstructions into the _initdata section,
> - PLT symbols behind the read-only section, and
> - *(.la_abs) into the data section.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: 0a6b58c5cd0d ("lockdep: fix static memory detection even more")
> Cc: stable <stable@kernel.org> # v6.4+

Tested-by: Guenter Roeck <linux@roeck-us.net>

> 
> diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
> index b1686afcf876..bb2ec86f37a8 100644
> --- a/arch/loongarch/kernel/vmlinux.lds.S
> +++ b/arch/loongarch/kernel/vmlinux.lds.S
> @@ -53,33 +53,6 @@ SECTIONS
>  	. = ALIGN(PECOFF_SEGMENT_ALIGN);
>  	_etext = .;
>  
> -	/*
> -	 * struct alt_inst entries. From the header (alternative.h):
> -	 * "Alternative instructions for different CPU types or capabilities"
> -	 * Think locking instructions on spinlocks.
> -	 */
> -	. = ALIGN(4);
> -	.altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
> -		__alt_instructions = .;
> -		*(.altinstructions)
> -		__alt_instructions_end = .;
> -	}
> -
> -#ifdef CONFIG_RELOCATABLE
> -	. = ALIGN(8);
> -	.la_abs : AT(ADDR(.la_abs) - LOAD_OFFSET) {
> -		__la_abs_begin = .;
> -		*(.la_abs)
> -		__la_abs_end = .;
> -	}
> -#endif
> -
> -	.got : ALIGN(16) { *(.got) }
> -	.plt : ALIGN(16) { *(.plt) }
> -	.got.plt : ALIGN(16) { *(.got.plt) }
> -
> -	.data.rel : { *(.data.rel*) }
> -
>  	. = ALIGN(PECOFF_SEGMENT_ALIGN);
>  	__init_begin = .;
>  	__inittext_begin = .;
> @@ -94,6 +67,18 @@ SECTIONS
>  
>  	__initdata_begin = .;
>  
> +	/*
> +	 * struct alt_inst entries. From the header (alternative.h):
> +	 * "Alternative instructions for different CPU types or capabilities"
> +	 * Think locking instructions on spinlocks.
> +	 */
> +	. = ALIGN(4);
> +	.altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
> +		__alt_instructions = .;
> +		*(.altinstructions)
> +		__alt_instructions_end = .;
> +	}
> +
>  	INIT_DATA_SECTION(16)
>  	.exit.data : {
>  		EXIT_DATA
> @@ -113,6 +98,11 @@ SECTIONS
>  
>  	_sdata = .;
>  	RO_DATA(4096)
> +
> +	.got : ALIGN(16) { *(.got) }
> +	.plt : ALIGN(16) { *(.plt) }
> +	.got.plt : ALIGN(16) { *(.got.plt) }
> +
>  	RW_DATA(1 << CONFIG_L1_CACHE_SHIFT, PAGE_SIZE, THREAD_SIZE)
>  
>  	.rela.dyn : ALIGN(8) {
> @@ -121,6 +111,17 @@ SECTIONS
>  		__rela_dyn_end = .;
>  	}
>  
> +	.data.rel : { *(.data.rel*) }
> +
> +#ifdef CONFIG_RELOCATABLE
> +	. = ALIGN(8);
> +	.la_abs : AT(ADDR(.la_abs) - LOAD_OFFSET) {
> +		__la_abs_begin = .;
> +		*(.la_abs)
> +		__la_abs_end = .;
> +	}
> +#endif
> +
>  	.sdata : {
>  		*(.sdata)
>  	}
