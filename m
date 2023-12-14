Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4381F812FD6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572947AbjLNMNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572923AbjLNMNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:13:15 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E87BD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:13:21 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-28aeb049942so1542347a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702556001; x=1703160801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxoH3e1pqfRG5EpbAAgxwCw1oRjLeMfi1qyzwQu8z4E=;
        b=ZPgGIYmcWPNimFXItEwd7PxKG6mCBrxpr8rzWObBC5fI9MwAH9tvcN6Yrdao1FOCc9
         nYc7iElwrvB07IA2UV1c7TYI3BuSY5mvJrABPAdS5wSA0WbpFdReu5RfQhJrKSiOB238
         9WG/bJ+Fn4OiYfPk/fD0m2OKv2kjMmCLQAuEskYsVa0N6vCn8mfh+xtU1m4SIYTA3PZn
         yogxhp2FCgQWBejmxldXRgLEAhJQTuqP7XNaqUVCyYnCW9n/XF8ncGUjkbrYn6LBQ1me
         7BMdwVnL1uOe0YyhJuTdRtWhmVE90wn50ndrMk7QJGCrNIov0+VvH0C02ol/xwwRbpoO
         GQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702556001; x=1703160801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxoH3e1pqfRG5EpbAAgxwCw1oRjLeMfi1qyzwQu8z4E=;
        b=bxV3gj3zkTGwE6lB2CEuIrYuvDiVcRp5okMg8/5mZd3JYCNlr8rMGcJp8vH/0peoA4
         bGmSK8ruKMWkhFJ7ofCnjteKF++aXkk9XpkVev3N8vAp+1/ihc21vQMTiAuo7T0BOYH/
         Z+isy8BbBZy1RrUtbp/js3iu0A4azX6s0iNCh91CVY1LWeXmTpe2ssHUY2dh1lIVfPxa
         f6ingLERfPv/leiTHuM+WoUl8kvPpOckw/LmoKJ4nRAG1sbML2raOsP8T/UPZ5Hk0hub
         690J4/Z2/dn65NSmFpSDu/m+i4yxqXDfYIqiXbjIcI1RQ5wr9ZvXKV/60np10XfRuDRe
         skTQ==
X-Gm-Message-State: AOJu0YyNy0PEZnMv5HoPgTj4Yt0tUfScvRZm6FyEI8HQWEmSWs00s2k7
        /173cizGo/0jN/G+XVp4T9WiY2FuM2BoUxi5bSJA1g==
X-Google-Smtp-Source: AGHT+IEooiD5rkngFLDpel3wTKhmmCpJGezIc1l7FQ/uXS5019jlAjf7Ozjts7D2t9f+t/Nftwhsc5T2VEWM2r0TPEI=
X-Received: by 2002:a17:90a:ae0d:b0:286:9b69:a0f6 with SMTP id
 t13-20020a17090aae0d00b002869b69a0f6mr7104084pjq.39.1702556000638; Thu, 14
 Dec 2023 04:13:20 -0800 (PST)
MIME-Version: 1.0
References: <20231205024310.1593100-1-atishp@rivosinc.com> <20231205024310.1593100-2-atishp@rivosinc.com>
In-Reply-To: <20231205024310.1593100-2-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 14 Dec 2023 17:43:09 +0530
Message-ID: <CAAhSdy0j=BKfoNFr2+P+z0YK29LkudpHQ5XQUZhY_F1mfWQAug@mail.gmail.com>
Subject: Re: [RFC 1/9] RISC-V: Fix the typo in Scountovf CSR name
To:     Atish Patra <atishp@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 8:13=E2=80=AFAM Atish Patra <atishp@rivosinc.com> wr=
ote:
>
> The counter overflow CSR name is "scountovf" not "sscountovf".
>
> Fix the csr name.
>
> Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/csr.h         | 2 +-
>  arch/riscv/include/asm/errata_list.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 306a19a5509c..88cdc8a3e654 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -281,7 +281,7 @@
>  #define CSR_HPMCOUNTER30H      0xc9e
>  #define CSR_HPMCOUNTER31H      0xc9f
>
> -#define CSR_SSCOUNTOVF         0xda0
> +#define CSR_SCOUNTOVF          0xda0
>
>  #define CSR_SSTATUS            0x100
>  #define CSR_SIE                        0x104
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/as=
m/errata_list.h
> index 83ed25e43553..7026fba12eeb 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -152,7 +152,7 @@ asm volatile(ALTERNATIVE_2(                          =
               \
>
>  #define ALT_SBI_PMU_OVERFLOW(__ovl)                                    \
>  asm volatile(ALTERNATIVE(                                              \
> -       "csrr %0, " __stringify(CSR_SSCOUNTOVF),                        \
> +       "csrr %0, " __stringify(CSR_SCOUNTOVF),                         \
>         "csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),             \
>                 THEAD_VENDOR_ID, ERRATA_THEAD_PMU,                      \
>                 CONFIG_ERRATA_THEAD_PMU)                                \
> --
> 2.34.1
>
