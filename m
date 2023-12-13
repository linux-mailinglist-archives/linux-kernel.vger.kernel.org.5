Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74013811544
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441920AbjLMOxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbjLMOxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:53:32 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8074293
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:53:37 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3363880e9f3so694240f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702479216; x=1703084016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AhlOkscoUfjpVGzLbSN2huPD+4bK2j9Udj5/KiwJMTU=;
        b=l9Enddh8TyPaIMGcB7PaoXLGQUcmziKz7jdEwl6XZG/7oW1Tkapp9+0vkF5CPCHPVN
         eQo9DGKxsqXGZdKmaxWrNJs6JNZ+NhZrPCjde7oDexa25Dx9QREvSfyqNYLJghL5Uy2x
         pSIhbgDxihZRXE+JoQs0AQLNFioOC+boY7V8d38GqBpO2r1xoyKSDjVXVWQ/+4rA4k5p
         SEduRXJJUQ4GsNKLcYG7kNDmiZLjYvAJcLOZV2VGApj5uxqIAg1nIHoOYcd66QeIq14W
         KVyd59Y0FO7rIZ/vw7WRedJYeEZ3CIDl9jz08qPAm/XOYgcr3uaQ3atkzaWFAUFi4uqW
         CLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702479216; x=1703084016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhlOkscoUfjpVGzLbSN2huPD+4bK2j9Udj5/KiwJMTU=;
        b=L2Gg4g1lk69dZqaFJiOkBxqeJOf8tWi+V7vwP6vI/4QfRU4hp3o7hjOAsW76KOgHEm
         6ahd7aUb9VKVrB4/tg3BiHqws7PZQ1f/vJCteaMKbI4J/le+NiwTyCA56wM8BVphSdhc
         GdPpsK0MComihkhm0UwixrncK0CRPcHNdC/6nqK3eAwSzELezJtRuV5qHOzoRhfGhDQe
         0JcVNvVo9SWa1p+9KjADu3AmqXZWXdihfQNiHYFfNJYp/TUSGUkScDPcmTy6u36FOA93
         xkLqfCGD/rEUpY9RnIFAwZiFlal9LgRR0bS5GneDIcSJQWb+2Aaj45Rro732JRR8o9tV
         g0zQ==
X-Gm-Message-State: AOJu0YzcImIpdGT64kD60HHGaXBPVY9AM4zcQQxTd8/62TSEIvVMXx62
        TXItSStxhwKtZlH6h0Mjb+o5Dw==
X-Google-Smtp-Source: AGHT+IFJaHAGSF4+C+q14MpFvBK1EjMX0mkGLB00ScBYwZtJnyS3hfOb1jvveNLZlYXxoeDIuOj4CQ==
X-Received: by 2002:adf:ebd0:0:b0:333:4fd1:1c6d with SMTP id v16-20020adfebd0000000b003334fd11c6dmr4089376wrn.31.1702479215933;
        Wed, 13 Dec 2023 06:53:35 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id k14-20020a5d524e000000b00333479734a7sm13480574wrc.99.2023.12.13.06.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:53:35 -0800 (PST)
Date:   Wed, 13 Dec 2023 15:53:34 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        greentime.hu@sifive.com, vincent.chen@sifive.com, tjytimi@163.com,
        alex@ghiti.fr, conor.dooley@microchip.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        David Hildenbrand <david@redhat.com>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] RISC-V: Detect and Enable Svadu Extension Support
Message-ID: <20231213-0160e1e392ad2172c27807c2@orel>
References: <20231102120129.11261-1-yongxuan.wang@sifive.com>
 <20231102120129.11261-2-yongxuan.wang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102120129.11261-2-yongxuan.wang@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 12:01:22PM +0000, Yong-Xuan Wang wrote:
> Svadu is a RISC-V extension for hardware updating of PTE A/D bits.
> 
> In this patch we detect Svadu extension support from DTB and
> add arch_has_hw_pte_young() to enable optimization in MGLRU and
> __wp_page_copy_user() if Svadu extension is available.
> 
> Co-developed-by: Jinyu Tang <tjytimi@163.com>
> Signed-off-by: Jinyu Tang <tjytimi@163.com>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/include/asm/csr.h     | 1 +
>  arch/riscv/include/asm/hwcap.h   | 1 +
>  arch/riscv/include/asm/pgtable.h | 6 ++++++
>  arch/riscv/kernel/cpufeature.c   | 1 +
>  4 files changed, 9 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 777cb8299551..e6935fd48c0c 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -194,6 +194,7 @@
>  /* xENVCFG flags */
>  #define ENVCFG_STCE			(_AC(1, ULL) << 63)
>  #define ENVCFG_PBMTE			(_AC(1, ULL) << 62)
> +#define ENVCFG_ADUE			(_AC(1, ULL) << 61)
>  #define ENVCFG_CBZE			(_AC(1, UL) << 7)
>  #define ENVCFG_CBCFE			(_AC(1, UL) << 6)
>  #define ENVCFG_CBIE_SHIFT		4
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index b7b58258f6c7..1013661d6516 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -58,6 +58,7 @@
>  #define RISCV_ISA_EXT_ZICSR		40
>  #define RISCV_ISA_EXT_ZIFENCEI		41
>  #define RISCV_ISA_EXT_ZIHPM		42
> +#define RISCV_ISA_EXT_SVADU		43
>  
>  #define RISCV_ISA_EXT_MAX		64
>  
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index b2ba3f79cfe9..028b700cd27b 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -629,6 +629,12 @@ static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
>  	return __pgprot(prot);
>  }
>  
> +#define arch_has_hw_pte_young arch_has_hw_pte_young
> +static inline bool arch_has_hw_pte_young(void)
> +{
> +	return riscv_has_extension_unlikely(RISCV_ISA_EXT_SVADU);
> +}
> +
>  /*
>   * THP functions
>   */
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 1cfbba65d11a..ead378c04991 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -178,6 +178,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>  	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
>  	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
> +	__RISCV_ISA_EXT_DATA(svadu, RISCV_ISA_EXT_SVADU),
>  	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
>  	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
>  	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> -- 
> 2.17.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
