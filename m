Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2257AFB9E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjI0HDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0HDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:03:47 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C56EA3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:03:42 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-530bc7c5bc3so12644902a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695798220; x=1696403020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=abujtVG6p0xZNC8A7dBvKw/44lCK9FG1V8Q7D6GoWec=;
        b=KuMYXGyVj9ZBOAaf8zoUF5LV2X/prGH5Z8zhGEnU2RN1UMTR4Q/k0hMc5g08sn7SDC
         bxESysqE8yNKQjt8iyRSm2185FE4kknLPTvZyLh4yD/HTVkVcqDz0Yu0kydyLYsdOIiX
         UsfFkDaq/R0xQ/yDgpCfnZyDGwvIC7EVyAJtbm2arUHS+FCeVa+1xFzbglD3b+kHANpE
         t0LTqQKTZg3GNacdCZ9c/rDv64duxLUpqEi8fgoUASIMHLIo3onpcYuV9BOD0cQRzoGH
         7abZu/Ya6z/eski6xme1Vpmdq58uc+4ANnT3WYUp4fzD5TXHTgjzQicqJLwGcLxTVM8V
         +g9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695798220; x=1696403020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abujtVG6p0xZNC8A7dBvKw/44lCK9FG1V8Q7D6GoWec=;
        b=A3esPur0qTiu3CAZzQmOO82wW1JO+yhiU8wiy3pZZyrm5ViDOoj4YqStcEmuYlxGDl
         V0ldFEsCtrwiOmbkFpPrlb8/mEeCfx5KME4tbmQ/b+RCs6nuOCGopekPYYoS9fRGD1Oh
         TBw/n/yg2xuEPpEkNl8/8+zFGyqLkh/1H6sXJhmlS89giTDgJgYhs0Vl7ppAiJbCByz3
         pKHK3ho8SV4uRdYdm+HUorV4iV1FOCa3DZZxJYSI+EoETrmdK+Tair2fwKdvLk+mW2NI
         mNKuYovCAQW9Qlg2NIyxhhlkIoFMX3yKEU5T41CeQQ5FVGj5uNmEeySptZzyvVySUHW4
         Y0wQ==
X-Gm-Message-State: AOJu0Yw2CMVXHA8rYEW+cwG5QwfVXTb0Jk4nKewO8qvWxWTvFa2aBK8W
        zQDz1IDW8jKQnpR9n8gG+I58sw==
X-Google-Smtp-Source: AGHT+IH8VW5TdXtmFHV3864zObtC+fVmQP9NlxTvcQk4+iFSRrMMkuD0mYj2kUeikFz+QLPU2Yu/1g==
X-Received: by 2002:a05:6402:1b1b:b0:530:f74d:f4ab with SMTP id by27-20020a0564021b1b00b00530f74df4abmr1093293edb.11.1695798220413;
        Wed, 27 Sep 2023 00:03:40 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a25-20020aa7d759000000b0051dd19d6d6esm7749118eds.73.2023.09.27.00.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 00:03:39 -0700 (PDT)
Date:   Wed, 27 Sep 2023 09:03:38 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        greentime.hu@sifive.com, vincent.chen@sifive.com, tjytimi@163.com,
        alex@ghiti.fr, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        wchen <waylingii@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        David Hildenbrand <david@redhat.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] RISC-V: Detect and Enable Svadu Extension Support
Message-ID: <20230927-62fbd3d63f4c6ffada90b7ee@orel>
References: <20230922085701.3164-1-yongxuan.wang@sifive.com>
 <20230922085701.3164-2-yongxuan.wang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922085701.3164-2-yongxuan.wang@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 08:56:47AM +0000, Yong-Xuan Wang wrote:
> We detect Svadu extension support from DTB and add arch_has_hw_pte_young()
> to enable optimization in MGLRU and __wp_page_copy_user() if Svadu
> extension is available.
> 
> Co-developed-by: Jinyu Tang <tjytimi@163.com>
> Signed-off-by: Jinyu Tang <tjytimi@163.com>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  arch/riscv/include/asm/csr.h     | 1 +
>  arch/riscv/include/asm/hwcap.h   | 1 +
>  arch/riscv/include/asm/pgtable.h | 6 ++++++
>  arch/riscv/kernel/cpufeature.c   | 1 +
>  4 files changed, 9 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 777cb8299551..10648b372a2a 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -194,6 +194,7 @@
>  /* xENVCFG flags */
>  #define ENVCFG_STCE			(_AC(1, ULL) << 63)
>  #define ENVCFG_PBMTE			(_AC(1, ULL) << 62)
> +#define ENVCFG_HADE			(_AC(1, ULL) << 61)

This bit is named 'ADUE' in the spec. Why are we calling it HADE?

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

Thanks,
drew
