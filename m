Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBE881302D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573046AbjLNMc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573030AbjLNMcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:32:25 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33BA11D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:32:31 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5ca5b61f101so452065a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702557151; x=1703161951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHs0a9X4fElRxkh1m4Obf7cu50BAmw2Tug+rwqngNXM=;
        b=rTUdyDnx0uZyyMLdBq/39Sz/gjFVrGgpyKLlpYbesZsJXm5qekReLG1fkuAZqUCJxF
         GJcLI0hl2daTeRGAuY+hjKGgdaF6LaAOoo5WEQU2OXNCFLLam8F4IfFricyUnwirJ6JB
         uVJrQTwnrn5NDXkcvqnkU2QPAPwvRffrTEZdS2RDIvhSsVyq/8D0S1YEfZIKJprABZ/m
         zVqvH4wLBJ1Q6UlCt6SCTKN+QS2nrz9BzKEe2FAt3P4qHOrLAsvtW6Q9m9uteXrm2zvi
         EPF8Q/sNe/RT45dXjJyNhBoctCXiO8U3qSVG0jn5sXLTJxM4RqXAMJQXUdK5i98LnyU5
         WSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702557151; x=1703161951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHs0a9X4fElRxkh1m4Obf7cu50BAmw2Tug+rwqngNXM=;
        b=KNCjd6SXrKl7jpL4y/4vKXJ94c+Aae54fboiLZJygTLyudWDxNnDjc3kn02baXuYDc
         zk59Fkq3ueVDpBkuDTgxegwOX/Uka0icBH+/8OWiN7qnry1Lb31WBtMoWm+mG/s412bO
         K7PdXGpeDaycDj0C2d7oLDh/yN0/QCumaO+gynJcYSQkIoL96mgA8Z49eV+azHesBuUT
         BnPv+AkCN55hnpS0aU3+4nEiJoJTlpKGbCTO385o8laeM8ggeWoP5qRaeZ/U0W7GsqA5
         0kvyARTvOSNW8IsyIZE3odzMKqm3QdiqD2N8S51NjfeNtV4WtCIKVNIfhm6vFUig4Mw9
         nX6A==
X-Gm-Message-State: AOJu0Yznro+ppAnlBxIqfaItL+F95kDhOD0Fb0wRf4s7AEgzihy0Nd5E
        Y1ZT8GcvqiSKU7MnupUEy8UpxE/pQ45k6nCM7tA4RA==
X-Google-Smtp-Source: AGHT+IHtJNIxrFwRTRE/bqbHJp34NVZj1ThA00NgG2O+fluhMv9I0JgSLSsCVqYFeOP3WU22OtYuCLxxss5Y01LGpik=
X-Received: by 2002:a17:90a:de94:b0:28b:1fbd:27de with SMTP id
 n20-20020a17090ade9400b0028b1fbd27demr4566pjv.29.1702557151290; Thu, 14 Dec
 2023 04:32:31 -0800 (PST)
MIME-Version: 1.0
References: <20231205024310.1593100-1-atishp@rivosinc.com> <20231205024310.1593100-6-atishp@rivosinc.com>
In-Reply-To: <20231205024310.1593100-6-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 14 Dec 2023 18:02:19 +0530
Message-ID: <CAAhSdy1L6smTUtjO1XJp2L=EfK-jYN9CS70h9nNa639ownKJBg@mail.gmail.com>
Subject: Re: [RFC 5/9] RISC-V: Add SBI PMU snapshot definitions
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
> SBI PMU Snapshot function optimizes the number of traps to
> higher privilege mode by leveraging a shared memory between the S/VS-mode
> and the M/HS mode. Add the definitions for that extension
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/sbi.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index f3eeca79a02d..29821addb9b7 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -122,6 +122,7 @@ enum sbi_ext_pmu_fid {
>         SBI_EXT_PMU_COUNTER_STOP,
>         SBI_EXT_PMU_COUNTER_FW_READ,
>         SBI_EXT_PMU_COUNTER_FW_READ_HI,
> +       SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
>  };
>
>  union sbi_pmu_ctr_info {
> @@ -138,6 +139,13 @@ union sbi_pmu_ctr_info {
>         };
>  };
>
> +/* Data structure to contain the pmu snapshot data */
> +struct riscv_pmu_snapshot_data {
> +       uint64_t ctr_overflow_mask;
> +       uint64_t ctr_values[64];
> +       uint64_t reserved[447];
> +};
> +
>  #define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(47, 0)
>  #define RISCV_PMU_RAW_EVENT_IDX 0x20000
>
> @@ -234,9 +242,11 @@ enum sbi_pmu_ctr_type {
>
>  /* Flags defined for counter start function */
>  #define SBI_PMU_START_FLAG_SET_INIT_VALUE (1 << 0)
> +#define SBI_PMU_START_FLAG_INIT_FROM_SNAPSHOT (1 << 1)
>
>  /* Flags defined for counter stop function */
>  #define SBI_PMU_STOP_FLAG_RESET (1 << 0)
> +#define SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT (1 << 1)
>
>  enum sbi_ext_dbcn_fid {
>         SBI_EXT_DBCN_CONSOLE_WRITE =3D 0,
> --
> 2.34.1
>
