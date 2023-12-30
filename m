Return-Path: <linux-kernel+bounces-13358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 588928203F7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 09:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B062822E9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 08:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46A68F45;
	Sat, 30 Dec 2023 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="ckBfBUTK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D028BED
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7b7d55d7717so352468039f.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 00:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1703923306; x=1704528106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPf6Z8tNoGfk9MBYZ1RUJvDaaG9qPZRvtU/U6N7KNnE=;
        b=ckBfBUTKsPKnbFcdr3E7+Q4lBxFoRTmMzFCEiz4urib9eotQZgmMlP01J8Egb9qkKM
         7klC0kKQ/ExMWvtdXv5mVvQDZzXTLjCeUZS5BcRxvU28dXf7eAZKzhrl2uslOZOpfODd
         sgYAjKGgQXbQOiDH9OyUX00EOa0fsx8Al/lMY9pvH/qBU+rSREru3VAOr8iDRYtLcnAD
         F++WdSBqaI2ssbRzzkl7LFBODmDeKbRwqDltfFNK0jS2XLh38UFYz9qpTuDBYzNM4APm
         vFaa/ngt0uUtV0dJcrILmlH+uinP880j9pSYZw6DwXt+gI14caXv7khUT7dczByMCiOu
         sFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703923306; x=1704528106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPf6Z8tNoGfk9MBYZ1RUJvDaaG9qPZRvtU/U6N7KNnE=;
        b=HvvIbpcEeoXI5euUTKdl8D5/wkdQsWXFhfkyrh1Jq7FPJKdD3crZdP7pk7SYgtz74E
         VVdhKVamMuxwms6ETI9coxTtt1+wRd8rnNEryQm0x01SVgmSG3Xwn/nge02qAG6yKw9t
         RJKSKQWuszR/xVzepKET7Fl3DzVaRjcJB9mQFnJF2yuij9u4hvnNCw8fcn/+/hOkd4g4
         ybOHcAvNzKEgS3gcH6NGLiZ2lqLcOZlLMHAvK+YbDDkUXAI6T14qE4WLOJ9d5Q3oPmrn
         lqv5w164tNneFh/Pammne7WgWWEu0plst7g2Rv/UySeiPQzz6X2hnqo/oBGY0Zy4J5Q2
         ATtQ==
X-Gm-Message-State: AOJu0Yxr9MFYDUacbiYs3wYTmcil34Y3ea+2K/hJJZP9o4nkZBTaXEXg
	N8KX+0ufRpnIOIes9liWDd6R66uz5rzzHbSIiDQlN0uNK94PcBYp7Umg4dKhcLM=
X-Google-Smtp-Source: AGHT+IG8kNEDveFHvGFklktInOSrh1sA+fL4mwRG4OISbyge3JZk+7FM4QwNXRHrKqUNcK01OLVK5yRqEEzfirj8O3E=
X-Received: by 2002:a92:c549:0:b0:35f:ee15:742c with SMTP id
 a9-20020a92c549000000b0035fee15742cmr11876530ilj.7.1703923306083; Sat, 30 Dec
 2023 00:01:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229214950.4061381-1-atishp@rivosinc.com> <20231229214950.4061381-8-atishp@rivosinc.com>
In-Reply-To: <20231229214950.4061381-8-atishp@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 30 Dec 2023 13:31:36 +0530
Message-ID: <CAAhSdy1cb_bEuE+pHusEoumhteu=Y87+WXpE=Eox1k2ng4pdZg@mail.gmail.com>
Subject: Re: [v2 07/10] RISC-V: KVM: No need to exit to the user space if perf
 event failed
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Atish Patra <atishp@atishpatra.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 30, 2023 at 3:20=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> Currently, we return a linux error code if creating a perf event failed
> in kvm. That shouldn't be necessary as guest can continue to operate
> without perf profiling or profiling with firmware counters.
>
> Return appropriate SBI error code to indicate that PMU configuration
> failed. An error message in kvm already describes the reason for failure.
>
> Fixes: 0cb74b65d2e5 ("RISC-V: KVM: Implement perf support without samplin=
g")
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kvm/vcpu_pmu.c     | 14 +++++++++-----
>  arch/riscv/kvm/vcpu_sbi_pmu.c |  6 +++---
>  2 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 8c44f26e754d..08f561998611 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -229,8 +229,9 @@ static int kvm_pmu_validate_counter_mask(struct kvm_p=
mu *kvpmu, unsigned long ct
>         return 0;
>  }
>
> -static int kvm_pmu_create_perf_event(struct kvm_pmc *pmc, struct perf_ev=
ent_attr *attr,
> -                                    unsigned long flags, unsigned long e=
idx, unsigned long evtdata)
> +static long kvm_pmu_create_perf_event(struct kvm_pmc *pmc, struct perf_e=
vent_attr *attr,
> +                                     unsigned long flags, unsigned long =
eidx,
> +                                     unsigned long evtdata)
>  {
>         struct perf_event *event;
>
> @@ -455,7 +456,8 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu =
*vcpu, unsigned long ctr_ba
>                                      unsigned long eidx, u64 evtdata,
>                                      struct kvm_vcpu_sbi_return *retdata)
>  {
> -       int ctr_idx, ret, sbiret =3D 0;
> +       int ctr_idx, sbiret =3D 0;
> +       long ret;
>         bool is_fevent;
>         unsigned long event_code;
>         u32 etype =3D kvm_pmu_get_perf_event_type(eidx);
> @@ -514,8 +516,10 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu=
 *vcpu, unsigned long ctr_ba
>                         kvpmu->fw_event[event_code].started =3D true;
>         } else {
>                 ret =3D kvm_pmu_create_perf_event(pmc, &attr, flags, eidx=
, evtdata);
> -               if (ret)
> -                       return ret;
> +               if (ret) {
> +                       sbiret =3D SBI_ERR_NOT_SUPPORTED;
> +                       goto out;
> +               }
>         }
>
>         set_bit(ctr_idx, kvpmu->pmc_in_use);
> diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.=
c
> index 7eca72df2cbd..b70179e9e875 100644
> --- a/arch/riscv/kvm/vcpu_sbi_pmu.c
> +++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
> @@ -42,9 +42,9 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vcp=
u, struct kvm_run *run,
>  #endif
>                 /*
>                  * This can fail if perf core framework fails to create a=
n event.
> -                * Forward the error to userspace because it's an error w=
hich
> -                * happened within the host kernel. The other option woul=
d be
> -                * to convert to an SBI error and forward to the guest.
> +                * No need to forward the error to userspace and exit the=
 guest
> +                * operation can continue without profiling. Forward the
> +                * appropriate SBI error to the guest.
>                  */
>                 ret =3D kvm_riscv_vcpu_pmu_ctr_cfg_match(vcpu, cp->a0, cp=
->a1,
>                                                        cp->a2, cp->a3, te=
mp, retdata);
> --
> 2.34.1
>

