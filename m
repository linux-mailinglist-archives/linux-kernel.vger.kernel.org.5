Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E443F803E09
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjLDTFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjLDTE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:04:58 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD18BD7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:05:03 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d03bcf27e9so20605905ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 11:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701716703; x=1702321503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WnV955wezI/faXxHbJEEhr+rw1fOAIjutAuKojl0JeQ=;
        b=gIu8DFfmbeLzZPHUSXfLqemHw1kpK7yM5Tvn/fXm4QUHRJvPP8ndVvvmWGY7gyeEQ5
         trHthDxtKRS1G748jxxjJtS2wycT1ua/LFJdwYRDwyE1kisjnRX0XdNYUXalvdSyO3Xf
         p4OojoBVqw2svv+GGf7/sUF9F08sA+S16EOK2fxKfRUHil05/Z5sQ2tC5JKicdI9fhf2
         vk/NjqlPYS01M53gPhXwLPH6Y/YKCYnEuigsx/upxKjc7w9YDZlc9F8/L/LEm7S0p4Xk
         HGXvyh/FV+JBFzt3fOIaEtegU9YuATY3J7uuwRq6THxOJeg5WGSSP6S2HGBigZ65EqHg
         Fyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716703; x=1702321503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnV955wezI/faXxHbJEEhr+rw1fOAIjutAuKojl0JeQ=;
        b=QpWMqXOudiRZJ+hB8aHJv4MZsK839ELJby6Ox+8itOr2kLpkC76iV2WunOVGpUUyhp
         MUJZ46hD/i3Fug13XlpP5Zyq0PL4rcQ8a1aDO8FXqePx9tR7jEVtvW2dhONTfLYTBvsP
         vt/N2Z/e6I2CMR24nIPpO0WhurY2N/Pa7iRhfTXkGnUrwhs6UJC6chnRcy3FPfVOQvBK
         KqTn8HiGfo+yTto/DM0ymMsV31Dy2TDB94agyNJxukW+hHDE6gwHpsWJ2yP3jaa36n1B
         TL3couZCFvRlCX/pJnlLsQPG43CVxMqueqO45esx8s8AgjrHs5YHuMf0cWLTC4yiW2Wu
         2Haw==
X-Gm-Message-State: AOJu0YxyStlwQlgvMRXB/jRFjNRq+ILRZ6ne9o/wGynQEsf4GrPMnf4T
        QG04kAvqr4qgHlSCqVPjP4mfiw==
X-Google-Smtp-Source: AGHT+IH4DZanW/KNwa0uyD6pEUJfokz8iC0zod8aStQj4slf472OadpXT3yEwARfScyGLpgOau04BA==
X-Received: by 2002:a17:902:dac7:b0:1d0:7d83:fdd9 with SMTP id q7-20020a170902dac700b001d07d83fdd9mr2350350plx.122.1701716703131;
        Mon, 04 Dec 2023 11:05:03 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id y21-20020a170902ed5500b001d04c097d32sm7188363plb.270.2023.12.04.11.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 11:05:02 -0800 (PST)
Date:   Mon, 4 Dec 2023 11:05:00 -0800
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: Use asm-generic for {read,write}{bwlq} and
 their relaxed variant
Message-ID: <ZW4i3MqVRg21RmRV@ghost>
References: <20231202133813.4003-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202133813.4003-1-jszhang@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2023 at 09:38:13PM +0800, Jisheng Zhang wrote:
> The asm-generic implementation is functionally identical to the riscv
> version. At the same time, the readl{q}_relaxed is replaced with the
> raw version for nommu building.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
> 
> Since v1:
>  - fix nommu build
> 
>  arch/riscv/include/asm/mmio.h  | 62 +---------------------------------
>  arch/riscv/include/asm/timex.h |  6 ++--
>  2 files changed, 4 insertions(+), 64 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/mmio.h b/arch/riscv/include/asm/mmio.h
> index 4c58ee7f95ec..a491590593ca 100644
> --- a/arch/riscv/include/asm/mmio.h
> +++ b/arch/riscv/include/asm/mmio.h
> @@ -80,54 +80,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
>  #endif
>  
>  /*
> - * Unordered I/O memory access primitives.  These are even more relaxed than
> - * the relaxed versions, as they don't even order accesses between successive
> - * operations to the I/O regions.
> - */
> -#define readb_cpu(c)		({ u8  __r = __raw_readb(c); __r; })
> -#define readw_cpu(c)		({ u16 __r = le16_to_cpu((__force __le16)__raw_readw(c)); __r; })
> -#define readl_cpu(c)		({ u32 __r = le32_to_cpu((__force __le32)__raw_readl(c)); __r; })
> -
> -#define writeb_cpu(v, c)	((void)__raw_writeb((v), (c)))
> -#define writew_cpu(v, c)	((void)__raw_writew((__force u16)cpu_to_le16(v), (c)))
> -#define writel_cpu(v, c)	((void)__raw_writel((__force u32)cpu_to_le32(v), (c)))
> -
> -#ifdef CONFIG_64BIT
> -#define readq_cpu(c)		({ u64 __r = le64_to_cpu((__force __le64)__raw_readq(c)); __r; })
> -#define writeq_cpu(v, c)	((void)__raw_writeq((__force u64)cpu_to_le64(v), (c)))
> -#endif
> -
> -/*
> - * Relaxed I/O memory access primitives. These follow the Device memory
> - * ordering rules but do not guarantee any ordering relative to Normal memory
> - * accesses.  These are defined to order the indicated access (either a read or
> - * write) with all other I/O memory accesses to the same peripheral. Since the
> - * platform specification defines that all I/O regions are strongly ordered on
> - * channel 0, no explicit fences are required to enforce this ordering.
> - */
> -/* FIXME: These are now the same as asm-generic */
> -#define __io_rbr()		do {} while (0)
> -#define __io_rar()		do {} while (0)
> -#define __io_rbw()		do {} while (0)
> -#define __io_raw()		do {} while (0)
> -
> -#define readb_relaxed(c)	({ u8  __v; __io_rbr(); __v = readb_cpu(c); __io_rar(); __v; })
> -#define readw_relaxed(c)	({ u16 __v; __io_rbr(); __v = readw_cpu(c); __io_rar(); __v; })
> -#define readl_relaxed(c)	({ u32 __v; __io_rbr(); __v = readl_cpu(c); __io_rar(); __v; })
> -
> -#define writeb_relaxed(v, c)	({ __io_rbw(); writeb_cpu((v), (c)); __io_raw(); })
> -#define writew_relaxed(v, c)	({ __io_rbw(); writew_cpu((v), (c)); __io_raw(); })
> -#define writel_relaxed(v, c)	({ __io_rbw(); writel_cpu((v), (c)); __io_raw(); })
> -
> -#ifdef CONFIG_64BIT
> -#define readq_relaxed(c)	({ u64 __v; __io_rbr(); __v = readq_cpu(c); __io_rar(); __v; })
> -#define writeq_relaxed(v, c)	({ __io_rbw(); writeq_cpu((v), (c)); __io_raw(); })
> -#endif
> -
> -/*
> - * I/O memory access primitives.  Reads are ordered relative to any following
> - * Normal memory read and delay() loop.  Writes are ordered relative to any
> - * prior Normal memory write.  The memory barriers here are necessary as RISC-V
> + * I/O barriers. The memory barriers here are necessary as RISC-V
>   * doesn't define any ordering between the memory space and the I/O space.
>   */
>  #define __io_br()	do {} while (0)
> @@ -135,17 +88,4 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
>  #define __io_bw()	({ __asm__ __volatile__ ("fence w,o" : : : "memory"); })
>  #define __io_aw()	mmiowb_set_pending()
>  
> -#define readb(c)	({ u8  __v; __io_br(); __v = readb_cpu(c); __io_ar(__v); __v; })
> -#define readw(c)	({ u16 __v; __io_br(); __v = readw_cpu(c); __io_ar(__v); __v; })
> -#define readl(c)	({ u32 __v; __io_br(); __v = readl_cpu(c); __io_ar(__v); __v; })
> -
> -#define writeb(v, c)	({ __io_bw(); writeb_cpu((v), (c)); __io_aw(); })
> -#define writew(v, c)	({ __io_bw(); writew_cpu((v), (c)); __io_aw(); })
> -#define writel(v, c)	({ __io_bw(); writel_cpu((v), (c)); __io_aw(); })
> -
> -#ifdef CONFIG_64BIT
> -#define readq(c)	({ u64 __v; __io_br(); __v = readq_cpu(c); __io_ar(__v); __v; })
> -#define writeq(v, c)	({ __io_bw(); writeq_cpu((v), (c)); __io_aw(); })
> -#endif
> -
>  #endif /* _ASM_RISCV_MMIO_H */
> diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
> index a06697846e69..9ff9f398f61a 100644
> --- a/arch/riscv/include/asm/timex.h
> +++ b/arch/riscv/include/asm/timex.h
> @@ -17,18 +17,18 @@ typedef unsigned long cycles_t;
>  #ifdef CONFIG_64BIT
>  static inline cycles_t get_cycles(void)
>  {
> -	return readq_relaxed(clint_time_val);
> +	return __raw_readq(clint_time_val);
>  }
>  #else /* !CONFIG_64BIT */
>  static inline u32 get_cycles(void)
>  {
> -	return readl_relaxed(((u32 *)clint_time_val));
> +	return __raw_readl(((u32 *)clint_time_val));
>  }
>  #define get_cycles get_cycles
>  
>  static inline u32 get_cycles_hi(void)
>  {
> -	return readl_relaxed(((u32 *)clint_time_val) + 1);
> +	return __raw_readl(((u32 *)clint_time_val) + 1);
>  }
>  #define get_cycles_hi get_cycles_hi
>  #endif /* CONFIG_64BIT */
> -- 
> 2.42.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

