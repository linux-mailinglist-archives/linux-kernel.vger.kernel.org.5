Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08ADD79D948
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbjILTAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjILTAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:00:52 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579F1E6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:00:48 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40037db2fe7so64475445e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1694545247; x=1695150047; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZCDN+p5uNHVLV+K8PpuHk9WpO33FgaNWOUDTmgpTKg=;
        b=nq00U3OCHucRB6hS02ClZk0EpUkouxyt1vSMNwGgLvc2T5fP0hbpYsDbEPobbehd8i
         GkgeW4SQiBdjYlk6FYPAbUcDQJKwA4BJcjMvDaIJdUHjsRjtHE/p4oBGdP2WXciHiUtY
         ppB89P7pdWYg5QlTmmL4WN0VrARCB9VYgZzi4RY7pt4IDyBJJZAnHnPkTvbuIWXrcvdo
         Bx87HPAzGUlrdmLnzr6Ji4vUXL/Pu0i72ZXmQqeC6T3WJv1g8oOmCzOwuNey19jHSxmV
         Z/4pQO/R7AlQqOxrFOufXYUYeRJ1I1Dlmn319QKSd6WNgPssy8837HR+Vuk2x3Qo4vCe
         tJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694545247; x=1695150047;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZCDN+p5uNHVLV+K8PpuHk9WpO33FgaNWOUDTmgpTKg=;
        b=XcQruMxJRr8DRhONSONDMdjBKFgWWWFkmxZCHfA+a3yVL2Yxcizl9vi4LS8/7hZkeJ
         HIjgAmEkfHYkUXz3AvB5uzKo7IoSXl6hgxmYMshi+jq1K4hAj75SeeiF3O6iJcb2hVga
         vKWtjoXmB1UoQr9CYJsSeZ1dWZbYpRU1nTCRDT3kf6EQMT4MEM4NsyLtcu84HMxeUGqu
         zinuLctPkzKZgPY2LpVgbapngdklImH2AU1glift7eq3HZoBGR6Z6bfNZm0/SDzNJ/Ly
         uNK75dbVTfFjmVPNGYAtnY9/zka3KkUXXBQGOhBP8C/v+D7INk7QZi/QIkrBE/3GTF32
         I3+A==
X-Gm-Message-State: AOJu0Ywqkgd2HuHKIjHT5hfJbrnsnpNEqEnH01LdW+7Lf/5a7SF2rkOy
        csP9D6wiJXiXa2gBUzCewSQc+g==
X-Google-Smtp-Source: AGHT+IE/E7hhg2o286wP8NTcBnZyuvKeAIz2ICPMoRjkUoOrsQwkXyIHpAGtsFMIABsORReyuA4aYg==
X-Received: by 2002:a05:600c:2294:b0:403:149:150b with SMTP id 20-20020a05600c229400b004030149150bmr224847wmf.16.1694545246034;
        Tue, 12 Sep 2023 12:00:46 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.246])
        by smtp.gmail.com with ESMTPSA id v11-20020a1cf70b000000b00401d8810c8bsm16788393wmh.15.2023.09.12.12.00.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Sep 2023 12:00:45 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH] riscv: errata: thead: use riscv_nonstd_cache_ops for CMO
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <ZQBDFa0fGNiaqAgh@gmail.com>
Date:   Tue, 12 Sep 2023 20:00:33 +0100
Cc:     Jisheng Zhang <jszhang@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C1EDD7DE-A0A9-4F43-9EC1-1C5A212A7033@jrtc27.com>
References: <20230912072740.2544-1-jszhang@kernel.org>
 <ZQBDFa0fGNiaqAgh@gmail.com>
To:     Guo Ren <guoren@kernel.org>
X-Mailer: Apple Mail (2.3731.600.7)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Sep 2023, at 11:53, Guo Ren <guoren@kernel.org> wrote:
>=20
> On Tue, Sep 12, 2023 at 03:27:40PM +0800, Jisheng Zhang wrote:
>> Previously, we use alternative mechanism to dynamically patch
>> the CMO operations for THEAD C906/C910 during boot for performance
>> reason. But as pointed out by Arnd, "there is already a significant
>> cost in accessing the invalidated cache lines afterwards, which is
>> likely going to be much higher than the cost of an indirect branch".
>> And indeed, there's no performance difference with GMAC and EMMC per
>> my test on Sipeed Lichee Pi 4A board.
>>=20
>> Use riscv_nonstd_cache_ops for THEAD C906/C910 CMO to simplify
>> the alternative code, and to acchieve Arnd's goal -- "I think
>> moving the THEAD ops at the same level as all nonstandard operations
>> makes sense, but I'd still leave CMO as an explicit fast path that
>> avoids the indirect branch. This seems like the right thing to do =
both
>> for readability and for platforms on which the indirect branch has a
>> noticeable overhead."
>>=20
>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>> ---
>> arch/riscv/Kconfig.errata            |  1 +
>> arch/riscv/errata/thead/errata.c     | 76 =
+++++++++++++++++++++++++++-
>> arch/riscv/include/asm/errata_list.h | 50 +++---------------
>> 3 files changed, 81 insertions(+), 46 deletions(-)
>>=20
>> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
>> index 566bcefeab50..d7972914f9de 100644
>> --- a/arch/riscv/Kconfig.errata
>> +++ b/arch/riscv/Kconfig.errata
>> @@ -78,6 +78,7 @@ config ERRATA_THEAD_CMO
>> bool "Apply T-Head cache management errata"
>> depends on ERRATA_THEAD && MMU
>> select RISCV_DMA_NONCOHERENT
>> + select RISCV_NONSTANDARD_CACHE_OPS
>> default y
>> help
>>   This will apply the cache management errata to handle the
>> diff --git a/arch/riscv/errata/thead/errata.c =
b/arch/riscv/errata/thead/errata.c
>> index 0554ed4bf087..1c320abfe446 100644
>> --- a/arch/riscv/errata/thead/errata.c
>> +++ b/arch/riscv/errata/thead/errata.c
>> @@ -12,8 +12,10 @@
>> #include <asm/alternative.h>
>> #include <asm/cacheflush.h>
>> #include <asm/cpufeature.h>
>> +#include <asm/dma-noncoherent.h>
>> #include <asm/errata_list.h>
>> #include <asm/hwprobe.h>
>> +#include <asm/io.h>
>> #include <asm/patch.h>
>> #include <asm/vendorid_list.h>
>>=20
>> @@ -33,6 +35,75 @@ static bool errata_probe_pbmt(unsigned int stage,
>> return false;
>> }
>>=20
>> +/*
>> + * dcache.ipa rs1 (invalidate, physical address)
>> + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
>> + *   0000001    01010      rs1       000      00000  0001011
>> + * dache.iva rs1 (invalida, virtual address)
>> + *   0000001    00110      rs1       000      00000  0001011
> Remove dache.iva rs1 ...
>=20
>> + *
>> + * dcache.cpa rs1 (clean, physical address)
>> + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
>> + *   0000001    01001      rs1       000      00000  0001011
> Remove dcache.cpa rs1 ...
>=20
>> + * dcache.cva rs1 (clean, virtual address)
>> + *   0000001    00101      rs1       000      00000  0001011
> Remove dcache.cva rs1 ...
>=20
>> + *
>> + * dcache.cipa rs1 (clean then invalidate, physical address)
>> + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
>> + *   0000001    01011      rs1       000      00000  0001011
>> + * dcache.civa rs1 (... virtual address)
>> + *   0000001    00111      rs1       000      00000  0001011
> Remove dcache.civa rs1 ...
>=20
>> + *
>> + * sync.s (make sure all cache operations finished)
>> + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
>> + *   0000000    11001     00000      000      00000  0001011
>> + */
>> +#define THEAD_inval_A0 ".long 0x0265000b"
>> +#define THEAD_clean_A0 ".long 0x0255000b"
>> +#define THEAD_flush_A0 ".long 0x0275000b"
>> +#define THEAD_SYNC_S ".long 0x0190000b"
>> +
>> +#define THEAD_CMO_OP(_op, _start, _size, _cachesize) \
>> +asm volatile("mv a0, %1\n\t" \
>> +      "j 2f\n\t" \
>> +      "3:\n\t" \
>> +      THEAD_##_op##_A0 "\n\t" \
>> +      "add a0, a0, %0\n\t" \
>> +      "2:\n\t" \
>> +      "bltu a0, %2, 3b\n\t" \
>> +      THEAD_SYNC_S \
>> +      : : "r"(_cachesize), \
>> +  "r"((unsigned long)(_start) & ~((_cachesize) - 1UL)), \
>> +  "r"((unsigned long)(_start) + (_size)) \
>> +      : "a0")
>> +
>> +static void thead_errata_cache_inv(phys_addr_t paddr, size_t size)
>> +{
>> + void *vaddr =3D phys_to_virt(paddr);
> No need to phys_to_virt, and we could use paddr directly (dcache.ipa
> rs1).
>=20
>> +
>> + THEAD_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
>> +}
>> +
>> +static void thead_errata_cache_wback(phys_addr_t paddr, size_t size)
>> +{
>> + void *vaddr =3D phys_to_virt(paddr);
>> +
>> + THEAD_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
>> +}
> Please remove the thead_errata_cache_wback because T-HEAD processors
> would prioritize using an invalid cacheline instead of evicting an
> existing cacheline. When we do dcache clean, the following operations
> are to let other interconnect masters read. So, keeping wback_inv for
> T-HEAD processors is the best choice, and maybe some other processors'
> vendor has a different idea, but please use the wback_inv instead of
> wback_only for the T-HEAD processors.

Unless you can demonstrate that your cores have significantly worse
performance when using wback instead of wback_inv I do not think the
non-standard implementation should deviate from the semantics of the
standard one. There are efforts to unify the implemented semantics of
the operations across architectures and this would obstruct those.

Jess

>> +
>> +static void thead_errata_cache_wback_inv(phys_addr_t paddr, size_t =
size)
>> +{
>> + void *vaddr =3D phys_to_virt(paddr);
> Ditto.
>=20
>> +
>> + THEAD_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
>> +}
>> +
>> +static const struct riscv_nonstd_cache_ops thead_errata_cmo_ops =3D =
{
>> + .wback =3D &thead_errata_cache_wback,
> Please  .wback =3D &thead_errata_cache_wback_inv,
>=20
>=20
>> + .inv =3D &thead_errata_cache_inv,
>> + .wback_inv =3D &thead_errata_cache_wback_inv,
>> +};
>> +
>> static bool errata_probe_cmo(unsigned int stage,
>>      unsigned long arch_id, unsigned long impid)
>> {
>> @@ -48,6 +119,8 @@ static bool errata_probe_cmo(unsigned int stage,
>> if (stage =3D=3D RISCV_ALTERNATIVES_BOOT) {
>> riscv_cbom_block_size =3D L1_CACHE_BYTES;
>> riscv_noncoherent_supported();
>> + if (IS_ENABLED(CONFIG_RISCV_NONSTANDARD_CACHE_OPS))
>> + riscv_noncoherent_register_cache_ops(&thead_errata_cmo_ops);
>> }
>>=20
>> return true;
>> @@ -77,8 +150,7 @@ static u32 thead_errata_probe(unsigned int stage,
>> if (errata_probe_pbmt(stage, archid, impid))
>> cpu_req_errata |=3D BIT(ERRATA_THEAD_PBMT);
>>=20
>> - if (errata_probe_cmo(stage, archid, impid))
>> - cpu_req_errata |=3D BIT(ERRATA_THEAD_CMO);
>> + errata_probe_cmo(stage, archid, impid);
>>=20
>> if (errata_probe_pmu(stage, archid, impid))
>> cpu_req_errata |=3D BIT(ERRATA_THEAD_PMU);
>> diff --git a/arch/riscv/include/asm/errata_list.h =
b/arch/riscv/include/asm/errata_list.h
>> index b55b434f0059..ea33288f8a25 100644
>> --- a/arch/riscv/include/asm/errata_list.h
>> +++ b/arch/riscv/include/asm/errata_list.h
>> @@ -24,9 +24,8 @@
>>=20
>> #ifdef CONFIG_ERRATA_THEAD
>> #define ERRATA_THEAD_PBMT 0
>> -#define ERRATA_THEAD_CMO 1
>> -#define ERRATA_THEAD_PMU 2
>> -#define ERRATA_THEAD_NUMBER 3
>> +#define ERRATA_THEAD_PMU 1
>> +#define ERRATA_THEAD_NUMBER 2
>> #endif
>>=20
>> #ifdef __ASSEMBLY__
>> @@ -94,54 +93,17 @@ asm volatile(ALTERNATIVE( \
>> #define ALT_THEAD_PMA(_val)
>> #endif
>>=20
>> -/*
>> - * dcache.ipa rs1 (invalidate, physical address)
>> - * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
>> - *   0000001    01010      rs1       000      00000  0001011
>> - * dache.iva rs1 (invalida, virtual address)
>> - *   0000001    00110      rs1       000      00000  0001011
>> - *
>> - * dcache.cpa rs1 (clean, physical address)
>> - * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
>> - *   0000001    01001      rs1       000      00000  0001011
>> - * dcache.cva rs1 (clean, virtual address)
>> - *   0000001    00101      rs1       000      00000  0001011
>> - *
>> - * dcache.cipa rs1 (clean then invalidate, physical address)
>> - * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
>> - *   0000001    01011      rs1       000      00000  0001011
>> - * dcache.civa rs1 (... virtual address)
>> - *   0000001    00111      rs1       000      00000  0001011
>> - *
>> - * sync.s (make sure all cache operations finished)
>> - * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
>> - *   0000000    11001     00000      000      00000  0001011
>> - */
>> -#define THEAD_inval_A0 ".long 0x0265000b"
>> -#define THEAD_clean_A0 ".long 0x0255000b"
>> -#define THEAD_flush_A0 ".long 0x0275000b"
>> -#define THEAD_SYNC_S ".long 0x0190000b"
>> -
>> #define ALT_CMO_OP(_op, _start, _size, _cachesize) \
>> -asm volatile(ALTERNATIVE_2( \
>> - __nops(6), \
>> +asm volatile(ALTERNATIVE( \
>> + __nops(5), \
>> "mv a0, %1\n\t" \
>> "j 2f\n\t" \
>> "3:\n\t" \
>> CBO_##_op(a0) \
>> "add a0, a0, %0\n\t" \
>> "2:\n\t" \
>> - "bltu a0, %2, 3b\n\t" \
>> - "nop", 0, RISCV_ISA_EXT_ZICBOM, CONFIG_RISCV_ISA_ZICBOM, \
>> - "mv a0, %1\n\t" \
>> - "j 2f\n\t" \
>> - "3:\n\t" \
>> - THEAD_##_op##_A0 "\n\t" \
>> - "add a0, a0, %0\n\t" \
>> - "2:\n\t" \
>> - "bltu a0, %2, 3b\n\t" \
>> - THEAD_SYNC_S, THEAD_VENDOR_ID, \
>> - ERRATA_THEAD_CMO, CONFIG_ERRATA_THEAD_CMO) \
>> + "bltu a0, %2, 3b\n\t", \
>> + 0, RISCV_ISA_EXT_ZICBOM, CONFIG_RISCV_ISA_ZICBOM) \
>> : : "r"(_cachesize), \
>>     "r"((unsigned long)(_start) & ~((_cachesize) - 1UL)), \
>>     "r"((unsigned long)(_start) + (_size)) \
>> --=20
>> 2.40.1
>>=20
>>=20
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


