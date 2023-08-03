Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8911176EE8C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbjHCPqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbjHCPqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:46:18 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C27CE46
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:46:17 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so4797550a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 08:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691077576; x=1691682376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4fTeL2P8Yv+tDw/vvA4jiimjzUtsJmuMUQjaZcjxkA=;
        b=Vh0Wyic7PtflwEr+T5yKOG8q6hKR0UHdoX5FHJSQHvkqPcc00Pgx5VLHGP9jNP/wCN
         JB8NMQy/EZfAz6SpIqvodOOutaoBSLPEun/+LDcOmRB29kwOoxnSsKzQY02zTl6RJlwI
         tsFvOHj8eFSdpe2fyDZ5IbQCphql6LzCvMvyMSA69xunCGoeQmqsY+hdL7qA/58BPf1w
         f/R/BhBYPhLhRQkig9/vxK6Nq55VoznTvEo7TWAe3KbE2c3tGFf/kleXFkjz032QgzUi
         5THpIV1PGsUsyQssn64a2tbboQnnqloHi5IfO1+QXR+ewcm0+R2X3/21aFTEx/+IgMS/
         UZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691077576; x=1691682376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4fTeL2P8Yv+tDw/vvA4jiimjzUtsJmuMUQjaZcjxkA=;
        b=aoekCKNV5FNMUldlig1KyFd6i2sL5EzehV8LXbn5yeYK3YWqg4w1wZWfS2Dbb0UOnU
         KTagc5uqb7Uvi5HkavD7RMhne/uFTp2ul9fS0wtsXv2JLVNwksYZMgIms0ue93Ko1MNs
         +yjeJAp+o4r/5xXvpr8ycCPmxXUkM3XLLdZ90oF9RY1UX0fL33eaeJu4hJtfcIe15CkJ
         F+r3nY2rd5VsozUCELUjV9wNommdpl5URXyusYXLjx6u7X+U/ORNLya62JoiTCOooF9t
         NmXb40q9rShubEdofoR1maSjfeduQwPaOrjFtl38aRrJQlUG7pERTQ/qjoUyiO+x2ZY2
         3sMw==
X-Gm-Message-State: ABy/qLablM2FAsQCF0CSgqKCYd+wrJ1Y3yAPRzid2I+tMdD/Ts5o6YMC
        m73b/zloZeijWxZmp1XyVIU=
X-Google-Smtp-Source: APBJJlGpCCrBoijXOyRlK610Lg+G+JM7sm4kVHl3xf3UIndFTQtPEvCd26TO3FcbjXknoaEQzUEaKg==
X-Received: by 2002:a05:6402:520e:b0:51d:cf7b:c9f0 with SMTP id s14-20020a056402520e00b0051dcf7bc9f0mr11203868edd.12.1691077575654;
        Thu, 03 Aug 2023 08:46:15 -0700 (PDT)
Received: from andrea (host-82-57-177-142.retail.telecomitalia.it. [82.57.177.142])
        by smtp.gmail.com with ESMTPSA id h21-20020aa7c955000000b005230f52195esm929046edt.44.2023.08.03.08.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 08:46:15 -0700 (PDT)
Date:   Thu, 3 Aug 2023 17:45:36 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     mathieu.desnoyers@efficios.com, paulmck@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        mmaas@google.com, hboehm@google.com, striker@us.ibm.com
Subject: Re: [RFC PATCH] membarrier: riscv: Provide core serializing command
Message-ID: <ZMvLoI6PxLR8RJvR@andrea>
References: <20230803040111.5101-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803040111.5101-1-parri.andrea@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Martin, Hans and Derek to the Cc: list,

  Andrea


On Thu, Aug 03, 2023 at 06:01:11AM +0200, Andrea Parri wrote:
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Suggested-by: Palmer Dabbelt <palmer@dabbelt.com>
> ---
> For the MEMBARRIER maintainers:  RISC-V does not have "core serializing
> instructions", meaning that there is no occurence of such a term in the
> RISC-V ISA.  The discussion and git history about the SYNC_CORE command
> suggested the implementation below: a FENCE.I instruction "synchronizes
> the instruction and data streams" [1] on a CPU; in litmus parlance,
> 
>   (single-hart test)
> 
>   CPU0
> 
>   UPDATE text   ;
>   FENCE.I       ;
>   EXECUTE text  ;  /* <-- will execute the updated/new text */
> 
> 
>   (message-passing test)
> 
>   CPU0             CPU1
> 
>   UPDATE text   |  IF (flag) {     ;
>   WMB           |    FENCE.I       ;
>   SET flag      |    EXECUTE text  ;  /* execute the new text */
>                 |  }               ;
> 
> 
>   (and many others, including "maybe"s!  ;-) )
> 
> How do these remarks resonate with the semantics of "a core serializing
> instruction" (to be issued before returning to user-space)?
> 
> RISCV maintainers, I'm missing some paths to user-space? (besides xRET)
> 
>   Andrea
> 
> [1] https://github.com/riscv/riscv-isa-manual/blob/main/src/zifencei.adoc
> 
> 
>  .../sched/membarrier-sync-core/arch-support.txt   |  2 +-
>  arch/riscv/Kconfig                                |  2 ++
>  arch/riscv/include/asm/sync_core.h                | 15 +++++++++++++++
>  3 files changed, 18 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/include/asm/sync_core.h
> 
> diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> index 23260ca449468..a17117d76e6d8 100644
> --- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> +++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> @@ -44,7 +44,7 @@
>      |    openrisc: | TODO |
>      |      parisc: | TODO |
>      |     powerpc: |  ok  |
> -    |       riscv: | TODO |
> +    |       riscv: |  ok  |
>      |        s390: |  ok  |
>      |          sh: | TODO |
>      |       sparc: | TODO |
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 4c07b9189c867..ed7ddaedc692e 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -27,6 +27,7 @@ config RISCV
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select ARCH_HAS_GIGANTIC_PAGE
>  	select ARCH_HAS_KCOV
> +	select ARCH_HAS_MEMBARRIER_SYNC_CORE
>  	select ARCH_HAS_MMIOWB
>  	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>  	select ARCH_HAS_PMEM_API
> @@ -35,6 +36,7 @@ config RISCV
>  	select ARCH_HAS_SET_MEMORY if MMU
>  	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
>  	select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
> +	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
>  	select ARCH_HAS_VDSO_DATA
> diff --git a/arch/riscv/include/asm/sync_core.h b/arch/riscv/include/asm/sync_core.h
> new file mode 100644
> index 0000000000000..d3ec6ac47ac9b
> --- /dev/null
> +++ b/arch/riscv/include/asm/sync_core.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_RISCV_SYNC_CORE_H
> +#define _ASM_RISCV_SYNC_CORE_H
> +
> +/*
> + * Ensure that a core serializing instruction is issued before returning
> + * to user-mode.  RISC-V implements return to user-space through an xRET
> + * instruction, which is not core serializing.
> + */
> +static inline void sync_core_before_usermode(void)
> +{
> +	asm volatile ("fence.i" ::: "memory");
> +}
> +
> +#endif /* _ASM_RISCV_SYNC_CORE_H */
> -- 
> 2.34.1
> 
