Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAC47A2E31
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 08:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbjIPG2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 02:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjIPG1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 02:27:37 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45211985
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 23:27:31 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31ffe67b5daso384623f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 23:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694845650; x=1695450450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qA3m7Wd97NA+1WsAxBYaL/T9+9FFGYaq89NwpPExPUw=;
        b=eciXcCc9/1i+QLcHcgnqLEO9h1hsMND/iBAjfOZ5cyhmH79Ll7uTdvH6CjNgzfJ63e
         mndQAVCqaJJorAx+250ceDEL7uDcg68FP67ljo2r9ZbjAxHxQ4os4QEzRBN+0XvCGtRB
         77MU/Sz3BsU/tcCPmGBQB6IdkLse1OYz5Axt/TTCZzxeDz/l/QvWYFmPCkSwMkSH/WxJ
         7jklkYDRsxef0aQA4Odddm2xp+ljLveHy+dvDEcv/5rREgFQGSEZnskBYsaLSfkRZBCw
         5u3AZprXQy2QOsLGsJ4GFBJd7/64yD9w3OcfHjOboc3mfjSv4zBmq3d8IsubWhG1r61G
         8I2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694845650; x=1695450450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qA3m7Wd97NA+1WsAxBYaL/T9+9FFGYaq89NwpPExPUw=;
        b=dA2xo5CG/sbXLk4MCJEz884H0Eps9UWUjgW1ky0RjL/MQrREJEchl7nSfNwfUFiQ0Q
         txWRYJuc7ysXf3vxGRQVoxT36bHe0b7AJw7TA7hkgXN54gTtjO/iP+z7OiGU8NxyrRcE
         zzARxRfh4RrAhvsgmVkVf5MWAHPhoswdLS5OYLlx9EMpWSwcVIAoygHDqZD8VfRZEZm+
         RRw2p1AwwBm4Hlk7ps/afP+Chxj9ywNXI6hXQ9UgBPwnwQLDo4+Twps3r4YWGwC+K433
         TgRmNzZ9plWqGdqLzS0AGO6K6s77VPR7XE6cwcelJ/gSrMLAM3w23q9DE6ab9LTC9Fuy
         BHnQ==
X-Gm-Message-State: AOJu0Ywu8pb0IN3S8Sz4mSAJef+yKfK3Ua7IjrIqePcXbTz6XV3d1Nqr
        IpXaPIyDke0AMNUXzlYJ+dgZKHCtgjXfcuNSZ3Y=
X-Google-Smtp-Source: AGHT+IHVEHn33nx/6pAxr7bxRFYSjBiKm4pipPDJ4FNTUFpg0tRVOz6FVszXyFWu8k+IhzcaqXgF+A==
X-Received: by 2002:a5d:62d2:0:b0:31a:d4e4:4f63 with SMTP id o18-20020a5d62d2000000b0031ad4e44f63mr2929892wrv.18.1694845650282;
        Fri, 15 Sep 2023 23:27:30 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id j6-20020adfff86000000b0031c56218984sm6156170wrr.104.2023.09.15.23.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 23:27:29 -0700 (PDT)
Date:   Sat, 16 Sep 2023 08:27:29 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     palmer@dabbelt.com, Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] RISC-V: capitalise CMO op macros
Message-ID: <20230916-b290c565eabad8c5935a85c2@orel>
References: <20230915-aloe-dollar-994937477776@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915-aloe-dollar-994937477776@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 04:40:44PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The CMO op macros initially used lower case, as the original iteration
> of the ALT_CMO_OP alternative stringified the first parameter to
> finalise the assembly for the standard variant.
> As a knock-on, the T-Head versions of these CMOs had to use mixed case
> defines. Commit dd23e9535889 ("RISC-V: replace cbom instructions with
> an insn-def") removed the asm construction with stringify, replacing it
> an insn-def macro, rending the lower-case surplus to requirements.
> As far as I can tell from a brief check, CBO_zero does not see similar
> use and didn't require the mixed case define in the first place.
> Replace the lower case characters now for consistency with other
> insn-def macros in the standard and T-Head forms, and adjust the
> callsites.
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: linux-riscv@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> ---
>  arch/riscv/include/asm/errata_list.h |  6 +++---
>  arch/riscv/include/asm/insn-def.h    |  8 +++----
>  arch/riscv/lib/clear_page.S          | 32 ++++++++++++++--------------
>  arch/riscv/mm/dma-noncoherent.c      |  8 +++----
>  arch/riscv/mm/pmem.c                 |  4 ++--
>  5 files changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index e2ecd01bfac7..5801af83d154 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -117,9 +117,9 @@ asm volatile(ALTERNATIVE(						\
>   * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
>   *   0000000    11001     00000      000      00000  0001011
>   */
> -#define THEAD_inval_A0	".long 0x0265000b"
> -#define THEAD_clean_A0	".long 0x0245000b"
> -#define THEAD_flush_A0	".long 0x0275000b"
> +#define THEAD_INVAL_A0	".long 0x0265000b"
> +#define THEAD_CLEAN_A0	".long 0x0245000b"
> +#define THEAD_FLUSH_A0	".long 0x0275000b"
>  #define THEAD_SYNC_S	".long 0x0190000b"
>  
>  #define ALT_CMO_OP(_op, _start, _size, _cachesize)			\
> diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
> index 6960beb75f32..e27179b26086 100644
> --- a/arch/riscv/include/asm/insn-def.h
> +++ b/arch/riscv/include/asm/insn-def.h
> @@ -180,19 +180,19 @@
>  	INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(51),		\
>  	       __RD(0), RS1(gaddr), RS2(vmid))
>  
> -#define CBO_inval(base)						\
> +#define CBO_INVAL(base)						\
>  	INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),		\
>  	       RS1(base), SIMM12(0))
>  
> -#define CBO_clean(base)						\
> +#define CBO_CLEAN(base)						\
>  	INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),		\
>  	       RS1(base), SIMM12(1))
>  
> -#define CBO_flush(base)						\
> +#define CBO_FLUSH(base)						\
>  	INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),		\
>  	       RS1(base), SIMM12(2))
>  
> -#define CBO_zero(base)						\
> +#define CBO_ZERO(base)						\
>  	INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),		\
>  	       RS1(base), SIMM12(4))
>  
> diff --git a/arch/riscv/lib/clear_page.S b/arch/riscv/lib/clear_page.S
> index d7a256eb53f4..b22de1231144 100644
> --- a/arch/riscv/lib/clear_page.S
> +++ b/arch/riscv/lib/clear_page.S
> @@ -29,41 +29,41 @@ SYM_FUNC_START(clear_page)
>  	lw	a1, riscv_cboz_block_size
>  	add	a2, a0, a2
>  .Lzero_loop:
> -	CBO_zero(a0)
> +	CBO_ZERO(a0)
>  	add	a0, a0, a1
>  	CBOZ_ALT(11, "bltu a0, a2, .Lzero_loop; ret", "nop; nop")
> -	CBO_zero(a0)
> +	CBO_ZERO(a0)
>  	add	a0, a0, a1
>  	CBOZ_ALT(10, "bltu a0, a2, .Lzero_loop; ret", "nop; nop")
> -	CBO_zero(a0)
> +	CBO_ZERO(a0)
>  	add	a0, a0, a1
> -	CBO_zero(a0)
> +	CBO_ZERO(a0)
>  	add	a0, a0, a1
>  	CBOZ_ALT(9, "bltu a0, a2, .Lzero_loop; ret", "nop; nop")
> -	CBO_zero(a0)
> +	CBO_ZERO(a0)
>  	add	a0, a0, a1
> -	CBO_zero(a0)
> +	CBO_ZERO(a0)
>  	add	a0, a0, a1
> -	CBO_zero(a0)
> +	CBO_ZERO(a0)
>  	add	a0, a0, a1
> -	CBO_zero(a0)
> +	CBO_ZERO(a0)
>  	add	a0, a0, a1
>  	CBOZ_ALT(8, "bltu a0, a2, .Lzero_loop; ret", "nop; nop")
> -	CBO_zero(a0)
> +	CBO_ZERO(a0)
>  	add	a0, a0, a1
> -	CBO_zero(a0)
> +	CBO_ZERO(a0)
>  	add	a0, a0, a1
> -	CBO_zero(a0)
> +	CBO_ZERO(a0)
>  	add	a0, a0, a1
> -	CBO_zero(a0)
> +	CBO_ZERO(a0)
>  	add	a0, a0, a1
> -	CBO_zero(a0)
> +	CBO_ZERO(a0)
>  	add	a0, a0, a1
> -	CBO_zero(a0)
> +	CBO_ZERO(a0)
>  	add	a0, a0, a1
> -	CBO_zero(a0)
> +	CBO_ZERO(a0)
>  	add	a0, a0, a1
> -	CBO_zero(a0)
> +	CBO_ZERO(a0)
>  	add	a0, a0, a1
>  	bltu	a0, a2, .Lzero_loop
>  	ret
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> index b76e7e192eb1..607d5f47d437 100644
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -31,7 +31,7 @@ static inline void arch_dma_cache_wback(phys_addr_t paddr, size_t size)
>  		return;
>  	}
>  #endif
> -	ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
> +	ALT_CMO_OP(CLEAN, vaddr, size, riscv_cbom_block_size);
>  }
>  
>  static inline void arch_dma_cache_inv(phys_addr_t paddr, size_t size)
> @@ -45,7 +45,7 @@ static inline void arch_dma_cache_inv(phys_addr_t paddr, size_t size)
>  	}
>  #endif
>  
> -	ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
> +	ALT_CMO_OP(INVAL, vaddr, size, riscv_cbom_block_size);
>  }
>  
>  static inline void arch_dma_cache_wback_inv(phys_addr_t paddr, size_t size)
> @@ -59,7 +59,7 @@ static inline void arch_dma_cache_wback_inv(phys_addr_t paddr, size_t size)
>  	}
>  #endif
>  
> -	ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> +	ALT_CMO_OP(FLUSH, vaddr, size, riscv_cbom_block_size);
>  }
>  
>  static inline bool arch_sync_dma_clean_before_fromdevice(void)
> @@ -131,7 +131,7 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
>  	}
>  #endif
>  
> -	ALT_CMO_OP(flush, flush_addr, size, riscv_cbom_block_size);
> +	ALT_CMO_OP(FLUSH, flush_addr, size, riscv_cbom_block_size);
>  }
>  
>  void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> diff --git a/arch/riscv/mm/pmem.c b/arch/riscv/mm/pmem.c
> index c5fc5ec96f6d..370a422ede11 100644
> --- a/arch/riscv/mm/pmem.c
> +++ b/arch/riscv/mm/pmem.c
> @@ -17,7 +17,7 @@ void arch_wb_cache_pmem(void *addr, size_t size)
>  		return;
>  	}
>  #endif
> -	ALT_CMO_OP(clean, addr, size, riscv_cbom_block_size);
> +	ALT_CMO_OP(CLEAN, addr, size, riscv_cbom_block_size);
>  }
>  EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
>  
> @@ -29,6 +29,6 @@ void arch_invalidate_pmem(void *addr, size_t size)
>  		return;
>  	}
>  #endif
> -	ALT_CMO_OP(inval, addr, size, riscv_cbom_block_size);
> +	ALT_CMO_OP(INVAL, addr, size, riscv_cbom_block_size);
>  }
>  EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
> -- 
> 2.39.2
>

If it compiles, ship it :-)

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
