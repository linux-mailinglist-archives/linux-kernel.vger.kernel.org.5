Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C583B813061
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573092AbjLNMmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573056AbjLNMmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:42:04 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C212711A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:42:09 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-28ad7a26f4aso2511856a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702557729; x=1703162529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yws50ylq1EjUkokTIkYOP2sTsutSEl10pAQ1LytLppw=;
        b=KgUHQ5FigzSTSXeBa5FBulKagCWsuMvWQ+tLOd/DRC1hUjqA5K8v8+1YUlcFjtaPYG
         yiMi0THxvA1xiaiuWy4u5DbOM+E377lnLtUNin7AzEfEycfQfrgXf26ao9orrMGQNbKT
         EbEX8iB2aZn64tZqfGJwGywlaUqG0V4ND0t4cJRa8Zz9qbiLw7BiqrR/hajaOBvrvFNN
         U8FAAbneY/s0HuqETgmAOh3ltBlDATN4wLsH9ieAO/h46ptU0MyhgvPpXTMUU8i1eT3a
         wnkmSdw1UWRM4UHCVeq7bI+vANP7tNBhrNK26X4aeig0c6uFUorYjDWwsJmfVZ3gfb+E
         FMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702557729; x=1703162529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yws50ylq1EjUkokTIkYOP2sTsutSEl10pAQ1LytLppw=;
        b=opplEEX6I+flEGJ+G/AcnkHxJMcdc8tT4USax37sINucsgbWt21Vax/zcW+K6NkogW
         UlFWSXHNvBxpEohZrLKTuJ2DWAIonpsi8Kj7CSnOySbC20T8fiSqm6uW2Xsh4nr5kB1D
         RTR1WW3cT3sxum+cHNrGKLRx0tZQqk8q1KoNYi2eZ7lTQrBllfAGNN+sAmzrT/3MIKsK
         jfVzBs25kBngcf0m+IsN9U3Kagf52HaLF15wjcfRmk/iUuAeZ9/Rola62F10m44Uc2oB
         ZZrSFh8pmSWKow7Bcl4PvPFV7wJdeFyaunG+NbB8T29NQL2Gv4pzFlr9yASe63o4Mncf
         4UJQ==
X-Gm-Message-State: AOJu0YxTncEtg9cn3UiprJ3KunomZ7JnSQ3OFJeJ5u4RzXnbzErF/fHq
        T9pnE0RfrVT6IvwyRchhDqcu9VQ2ja+6XL1YI/7tBw==
X-Google-Smtp-Source: AGHT+IHGAsyuOZIB4sppc3GwRu4zHElev+uLaRnUeyYMhAuZzoyenRB6gyAOaSXUB4X/u3gleJnJa3pxzwY2EnvbCio=
X-Received: by 2002:a17:90a:c697:b0:28a:dfa6:f1d3 with SMTP id
 n23-20020a17090ac69700b0028adfa6f1d3mr2094943pjt.0.1702557729115; Thu, 14 Dec
 2023 04:42:09 -0800 (PST)
MIME-Version: 1.0
References: <20231205024310.1593100-1-atishp@rivosinc.com> <20231205024310.1593100-10-atishp@rivosinc.com>
In-Reply-To: <20231205024310.1593100-10-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 14 Dec 2023 18:11:57 +0530
Message-ID: <CAAhSdy24k0r7vS1MkuRkAZwu9vOM7nLz4z+_gUjQE7ppkSq15g@mail.gmail.com>
Subject: Re: [RFC 9/9] RISC-V: KVM: Support 64 bit firmware counters on RV32
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
> The SBI v2.0 introduced a fw_read_hi function to read 64 bit firmware
> counters for RV32 based systems.
>
> Add infrastructure to support that.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/kvm_vcpu_pmu.h |  6 ++++-
>  arch/riscv/kvm/vcpu_pmu.c             | 38 ++++++++++++++++++++++++++-
>  arch/riscv/kvm/vcpu_sbi_pmu.c         |  7 +++++
>  3 files changed, 49 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include/a=
sm/kvm_vcpu_pmu.h
> index 64c75acad6ba..dd655315e706 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_pmu.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_pmu.h
> @@ -20,7 +20,7 @@ static_assert(RISCV_KVM_MAX_COUNTERS <=3D 64);
>
>  struct kvm_fw_event {
>         /* Current value of the event */
> -       unsigned long value;
> +       uint64_t value;
>
>         /* Event monitoring status */
>         bool started;
> @@ -91,6 +91,10 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *=
vcpu, unsigned long ctr_ba
>                                      struct kvm_vcpu_sbi_return *retdata)=
;
>  int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cid=
x,
>                                 struct kvm_vcpu_sbi_return *retdata);
> +#if defined(CONFIG_32BIT)
> +int kvm_riscv_vcpu_pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned lo=
ng cidx,
> +                               struct kvm_vcpu_sbi_return *retdata);
> +#endif
>  void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu);
>  int kvm_riscv_vcpu_pmu_setup_snapshot(struct kvm_vcpu *vcpu, unsigned lo=
ng saddr_low,
>                                        unsigned long saddr_high, unsigned=
 long flags,
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 86c8e92f92d3..5b4a93647256 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -195,6 +195,28 @@ static int pmu_get_pmc_index(struct kvm_pmu *pmu, un=
signed long eidx,
>
>         return kvm_pmu_get_programmable_pmc_index(pmu, eidx, cbase, cmask=
);
>  }

Newline here.

> +#if defined(CONFIG_32BIT)

Just like other patches, let's use IS_ENABLED() here.

> +static int pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
> +                             unsigned long *out_val)
> +{
> +       struct kvm_pmu *kvpmu =3D vcpu_to_pmu(vcpu);
> +       struct kvm_pmc *pmc;
> +       u64 enabled, running;
> +       int fevent_code;
> +
> +       pmc =3D &kvpmu->pmc[cidx];
> +
> +       if (pmc->cinfo.type !=3D SBI_PMU_CTR_TYPE_FW)
> +               return -EINVAL;
> +
> +       fevent_code =3D get_event_code(pmc->event_idx);
> +       pmc->counter_val =3D kvpmu->fw_event[fevent_code].value;
> +
> +       *out_val =3D pmc->counter_val >> 32;
> +
> +       return 0;
> +}
> +#endif
>
>  static int pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
>                         unsigned long *out_val)
> @@ -696,6 +718,20 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu=
 *vcpu, unsigned long ctr_ba
>         return 0;
>  }
>
> +#if defined(CONFIG_32BIT)
> +int kvm_riscv_vcpu_pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned lo=
ng cidx,
> +                                  struct kvm_vcpu_sbi_return *retdata)
> +{
> +       int ret;
> +
> +       ret =3D pmu_fw_ctr_read_hi(vcpu, cidx, &retdata->out_val);
> +       if (ret =3D=3D -EINVAL)
> +               retdata->err_val =3D SBI_ERR_INVALID_PARAM;
> +
> +       return 0;
> +}
> +#endif
> +
>  int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cid=
x,
>                                 struct kvm_vcpu_sbi_return *retdata)
>  {
> @@ -769,7 +805,7 @@ void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu)
>                         pmc->cinfo.csr =3D CSR_CYCLE + i;
>                 } else {
>                         pmc->cinfo.type =3D SBI_PMU_CTR_TYPE_FW;
> -                       pmc->cinfo.width =3D BITS_PER_LONG - 1;
> +                       pmc->cinfo.width =3D 63;
>                 }
>         }
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.=
c
> index 77c20a61fd7d..0cd051d5a448 100644
> --- a/arch/riscv/kvm/vcpu_sbi_pmu.c
> +++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
> @@ -64,6 +64,13 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vc=
pu, struct kvm_run *run,
>         case SBI_EXT_PMU_COUNTER_FW_READ:
>                 ret =3D kvm_riscv_vcpu_pmu_ctr_read(vcpu, cp->a0, retdata=
);
>                 break;
> +       case SBI_EXT_PMU_COUNTER_FW_READ_HI:
> +#if defined(CONFIG_32BIT)

Same as above, use IS_ENABLED() here.

> +               ret =3D kvm_riscv_vcpu_pmu_fw_ctr_read_hi(vcpu, cp->a0, r=
etdata);
> +#else
> +               retdata->out_val =3D 0;
> +#endif
> +               break;
>         case SBI_EXT_PMU_SNAPSHOT_SET_SHMEM:
>                 ret =3D kvm_riscv_vcpu_pmu_setup_snapshot(vcpu, cp->a0, c=
p->a1, cp->a2, retdata);
>                 break;
> --
> 2.34.1
>

Apart from minor nits above, this looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
