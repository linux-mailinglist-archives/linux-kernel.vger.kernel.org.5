Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C2F812FDF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572953AbjLNMQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572951AbjLNMQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:16:23 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89162118
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:16:29 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d3536cd414so14948645ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702556189; x=1703160989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tiT7wfNqaw2vJLSE5DYIhR3c6v+dX+na4nc8HEVIgQ=;
        b=PNL+oBMmA4ybqQboMcw6INWYK/fcxPF0zMNCA8vSPOyZuOEEbPqUskBN+6QjVPdmfA
         dBLac9j5SRDcIfvBJxtN7/A4pTYdAzulqVtgiS8TOVLehRDRS+ZdvUYU6z5hB9kdWm1W
         pxfxZpfLHT7cKR2sD8dlLnOLwovGg5HDZNcCCaiPaF3HcePlD+FKvz641wghA4EPoL3w
         97n8lb/AvOYXoJ+5tGQBEdCWKINSHZjuz/xv+ZypR9fDidFX7K5zbNwiVH7guwMPovBn
         xXKC07k0jTDbuABa97QJATQtdo7CyW9VRr755E0HWB5OQPib8M7OcWgELZjY8ordvwoe
         Yxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702556189; x=1703160989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tiT7wfNqaw2vJLSE5DYIhR3c6v+dX+na4nc8HEVIgQ=;
        b=uyDVc/Vcu4OFrjoFbMS69sF46gPtZ7+l+tRP8OOLsIC57H/ILJmh/2+/SE/ZHpCrq+
         FQqONCq8re1INc/WhpTSeFuV/Av8T8Rg6jv4mxEIwVCyilKKHoArZN8fms9JCKPJf0kG
         2HsoV+IoblvGbwS/X39C0axGafwdEU6oykmgSCkxRe2SRWzvUsicye8O0vnTfNUZdIJM
         IeYkHu0wq/N47DabmhjGhR+8sFEX+aTGjV/Inbx/oxDzxrIiq/mnCaigxqzHvXpcR+CR
         RqMW+83hGW3MFfPi5gI0vEi/3uNY5zWKGFxTAf/5iFGyugfCGdZHp64nMAU7BsP/r/P3
         ecIg==
X-Gm-Message-State: AOJu0YwTUV3OoGWn3KkifauxmY7/Y3q9EgWVfPSQ/TWgj2WOLn1V2LfG
        agmcZzB8qxPqmt4yj0thSAyp6VD0zNjvQsbBnC94Tw==
X-Google-Smtp-Source: AGHT+IEthyLwcbpFlS0nGuCTagq11nyWQP0JyD3gThdiIWZOLD3HKt6owX5IozE98AMNclf4HsOdhasFFYWjQPb1jH0=
X-Received: by 2002:a17:903:2351:b0:1d3:60f7:4620 with SMTP id
 c17-20020a170903235100b001d360f74620mr1427318plh.128.1702556188931; Thu, 14
 Dec 2023 04:16:28 -0800 (PST)
MIME-Version: 1.0
References: <20231205024310.1593100-1-atishp@rivosinc.com> <20231205024310.1593100-4-atishp@rivosinc.com>
In-Reply-To: <20231205024310.1593100-4-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 14 Dec 2023 17:46:17 +0530
Message-ID: <CAAhSdy0_DdCeFdzzJgoWhnrMz1-UqQXKLWNBAAXB6SQ_eJ2gyg@mail.gmail.com>
Subject: Re: [RFC 3/9] RISC-V: Add FIRMWARE_READ_HI definition
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
> SBI v2.0 added another function to SBI PMU extension to read
> the upper bits of a counter with width larger than XLEN.
>
> Add the definition for that function.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/sbi.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 0892f4421bc4..f3eeca79a02d 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -121,6 +121,7 @@ enum sbi_ext_pmu_fid {
>         SBI_EXT_PMU_COUNTER_START,
>         SBI_EXT_PMU_COUNTER_STOP,
>         SBI_EXT_PMU_COUNTER_FW_READ,
> +       SBI_EXT_PMU_COUNTER_FW_READ_HI,
>  };
>
>  union sbi_pmu_ctr_info {
> --
> 2.34.1
>
