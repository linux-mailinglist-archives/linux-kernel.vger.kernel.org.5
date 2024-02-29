Return-Path: <linux-kernel+bounces-87179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A016486D0BF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A35DB25A70
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2EC70AF2;
	Thu, 29 Feb 2024 17:33:14 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016824AEC0;
	Thu, 29 Feb 2024 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227993; cv=none; b=pmhc5fJqtK+AqLgm9GZ39GDfsfTe6F7hSuql/nIqqAc2gw6wrNs/ysQe0ptDEVcEHPCGIQUpXYp/RCBZSOIc7ia/xoUvL0A2EZGBTzHO/Ajkz5yKJMQFGPnry7WFUtrijLYORGAhHsPmJ7wpD3Ketnfngu5LRaJUebc+FQuTEFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227993; c=relaxed/simple;
	bh=Xcb/Cl9PjMGq/KNM5b/4VikRIorMVBalMVplpmQgSs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMLLbWhS0ZUQMKgiCehT2LaOeDYW1SOjmSMtEh3zRxCI5Q1v5YNdyWN3opYnNBTb1BdugP957oevimBW6vNDlUiHF/jwG9TctS6E8kfy+n5nHCkoz+8BHN+ZAhaTXl3hXsOHbAT20yVe39dc2pNnELswKWAMBemRjXxv/9CRmMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e45f7c63f4so151844a34.1;
        Thu, 29 Feb 2024 09:33:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709227991; x=1709832791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6VNqhRaH2SJuKPVuPLQRWdJSZsktM+MOSg52wWcrck=;
        b=vTdH2kpSXY/kqHOHGaWbLJgrho0r1n+QsW5CcCYjJfhMMfavPOF3x2AL5Q5VXgIB4H
         zQ02smeoMGA3dZZOKJb2BtI+/F0DN0znrf18dz9apJw2tnVuR4N4dlQLeKH04PlIXV1i
         7dYZ3kleVAXI3ZqXNxgVVn9W/nTA+0cLRuDw2W6ej5va8MvBau+hHZmKySqnr/uZ4qfT
         c7QEc/ay/ziFRRqXTERUWeZyAX53v7WeK9hVTiB8aDw1wxR9mXFY0r1uCHKMRl8Kl2Qd
         4jiOaY9fMtjtpWi5Jtw69iq5IlIHtCjgq/Mta1f7Y9xD4oAw3iSRsYeKHaMJxfBSNTpY
         i+Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVIcPaydQDzDd00D2E+oXpDNhhOj17zp3aWw2czmPiroQjLHfxGAbQDi8OhO4slGLb6uV8b6KkM858toHQhBFYzDwfIDKeQ+cZUGd7niK2ZY6aIb9SPW8mRlVdacCVzSYywEuPC94ablVaV1vpQQxAliZTsnW2dAf13pqQqYkPSLzi/
X-Gm-Message-State: AOJu0Yx/nsPnA19hYBaFknyWLBOs8qNuY+3k8BBgfBaDUlWLdJDZID6V
	aNS6oSdxbM0UxhjqQ+XzgFEFYH7Phtzww80hnqDpXAoF4vRi16nCnPCoq9sL8CP7qepMBmsPgm/
	+YQ/Yzok5L6DgyCZT94iNPakqZTPv+l/xIA8=
X-Google-Smtp-Source: AGHT+IGjpEGSMo+0QpJNV2Tg9yYpRW1jakjszfOjfGj7BtHqDShrpf3q2Dla2vdyWIv5WN8dWQm7RDaPT5UuGqZO3T8=
X-Received: by 2002:a4a:a543:0:b0:5a0:ec66:b56b with SMTP id
 s3-20020a4aa543000000b005a0ec66b56bmr1884873oom.0.1709227990938; Thu, 29 Feb
 2024 09:33:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229162520.970986-1-vanshikonda@os.amperecomputing.com> <20240229162520.970986-4-vanshikonda@os.amperecomputing.com>
In-Reply-To: <20240229162520.970986-4-vanshikonda@os.amperecomputing.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Feb 2024 18:32:59 +0100
Message-ID: <CAJZ5v0j+qz0okToszmU=kBjZvD3GJKzwz-ZrweOkgw6A2e3pQQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] ACPI: CPPC: Read CPC FFH counters in a single IPI
To: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Cc: Huisong Li <lihuisong@huawei.com>, Beata Michalska <beata.michalska@arm.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	rafael@kernel.org, sumitg@nvidia.com, zengheng4@huawei.com, 
	yang@os.amperecomputing.com, will@kernel.org, sudeep.holla@arm.com, 
	liuyonglong@huawei.com, zhanjie9@hisilicon.com, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 5:25=E2=80=AFPM Vanshidhar Konda
<vanshikonda@os.amperecomputing.com> wrote:
>
> The CPPC driver reads delivered and reference counters using cpc_read
> one at a time. This leads to inaccurate measurement of CPU frequency
> discussed in [1]. If the firmware indicates that both the registers are
> in the FFH interface the kernel can read the registers together in a
> single IPI. This has two benefits:
> 1. Reduces the number of IPIs needed to read the two registers
> 2. The two registers will be read in close proximity resulting in more
>    accurate CPU frequency measurement
>
> [1]: https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperecomp=
uting.com/
>
> Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> ---
>  arch/arm64/kernel/topology.c | 37 ++++++++++++++++++++++++++++++++++++
>  drivers/acpi/cppc_acpi.c     | 32 +++++++++++++++++++++++++++----
>  include/acpi/cppc_acpi.h     | 13 +++++++++++++
>  3 files changed, 78 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 8905eb0c681f..8207565f43ee 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -421,6 +421,43 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *=
val)
>         return ret;
>  }
>
> +static void cpc_update_freq_counters(void *info)
> +{
> +       update_freq_counters_refs();
> +}
> +
> +int cpc_read_regs_ffh(int cpu, struct ffh_cpc_reg_values *ffh_regs)
> +{
> +       struct amu_counters *ctrs =3D per_cpu_ptr(&cpu_samples, cpu);
> +       int idx;
> +
> +       if (!cpc_ffh_supported() || !freq_counters_valid(cpu))
> +               return -EOPNOTSUPP;
> +
> +       if (WARN_ON_ONCE(irqs_disabled()))
> +               return -EPERM;
> +
> +       if (!idle_cpu(cpu))
> +               smp_call_function_single(cpu, cpc_update_freq_counters, N=
ULL, 1);
> +
> +       for (idx =3D 0; idx < MAX_NUM_CPC_REGS_FFH; idx++) {
> +
> +               if (!ffh_regs->regs[idx].reg)
> +                       continue;
> +
> +               switch ((u64)(ffh_regs->regs[idx].reg->address)) {
> +               case 0x0:
> +                       ffh_regs->regs[idx].value =3D ctrs->core_cnt;
> +                       break;
> +               case 0x1:
> +                       ffh_regs->regs[idx].value =3D ctrs->const_cnt;
> +                       break;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
>  {
>         return -EOPNOTSUPP;
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index d155a86a8614..55ffb1915e4f 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -113,6 +113,10 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_pt=
r);
>                                 (cpc)->cpc_entry.reg.space_id =3D=3D     =
   \
>                                 ACPI_ADR_SPACE_SYSTEM_IO)
>
> +#define CPC_IN_FFH(cpc) ((cpc)->type =3D=3D ACPI_TYPE_BUFFER &&         =
   \
> +                               (cpc)->cpc_entry.reg.space_id =3D=3D     =
   \
> +                               ACPI_ADR_SPACE_FIXED_HARDWARE)
> +
>  /* Evaluates to True if reg is a NULL register descriptor */
>  #define IS_NULL_REG(reg) ((reg)->space_id =3D=3D  ACPI_ADR_SPACE_SYSTEM_=
MEMORY && \
>                                 (reg)->address =3D=3D 0 &&               =
   \
> @@ -974,6 +978,11 @@ int __weak cpc_write_ffh(int cpunum, struct cpc_reg =
*reg, u64 val)
>         return -ENOTSUPP;
>  }
>
> +int __weak cpc_read_regs_ffh(int cpu, struct ffh_cpc_reg_values *regs)
> +{
> +       return -ENOTSUPP;
> +}

This might return a bool value.

Is there any case in which the caller would handle different error
codes differently?

> +
>  /*
>   * Since cpc_read and cpc_write are called while holding pcc_lock, it sh=
ould be
>   * as fast as possible. We have already mapped the PCC subspace during i=
nit, so
> @@ -1317,7 +1326,7 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf=
_fb_ctrs *perf_fb_ctrs)
>         int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpunum);
>         struct cppc_pcc_data *pcc_ss_data =3D NULL;
>         u64 delivered, reference, ref_perf, ctr_wrap_time;
> -       int ret =3D 0, regs_in_pcc =3D 0;
> +       int ret =3D 0, regs_in_pcc =3D 0, regs_read_in_ffh =3D 0;

Please use bool as the type for boolean variables.

>
>         if (!cpc_desc) {
>                 pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> @@ -1353,8 +1362,23 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_per=
f_fb_ctrs *perf_fb_ctrs)
>                 }
>         }
>
> -       cpc_read(cpunum, delivered_reg, &delivered);
> -       cpc_read(cpunum, reference_reg, &reference);
> +       if (CPC_IN_FFH(delivered_reg) && CPC_IN_FFH(reference_reg)) {
> +               struct ffh_cpc_reg_values ffh_regs;
> +
> +               ffh_regs.regs[0].reg =3D &(delivered_reg->cpc_entry.reg);
> +               ffh_regs.regs[1].reg =3D &(reference_reg->cpc_entry.reg);
> +               ret =3D cpc_read_regs_ffh(cpunum, &ffh_regs);
> +               if (!ret) {

If cpc_read_regs_ffh() returned 'true' on success, the above could be writt=
en as

if (cpc_read_regs_ffh(cpunum, &ffh_regs)) {

> +                       delivered =3D ffh_regs.regs[0].value;
> +                       reference =3D ffh_regs.regs[1].value;
> +                       regs_read_in_ffh =3D 1;
> +               }
> +       }
> +
> +       if (!regs_read_in_ffh) {
> +               cpc_read(cpunum, delivered_reg, &delivered);
> +               cpc_read(cpunum, reference_reg, &reference);
> +       }
>         cpc_read(cpunum, ref_perf_reg, &ref_perf);
>
>         /*
> @@ -1366,7 +1390,7 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf=
_fb_ctrs *perf_fb_ctrs)
>         if (CPC_SUPPORTED(ctr_wrap_reg))
>                 cpc_read(cpunum, ctr_wrap_reg, &ctr_wrap_time);
>
> -       if (!delivered || !reference || !ref_perf) {
> +       if (!delivered || !reference || !ref_perf) {
>                 ret =3D -EFAULT;
>                 goto out_err;
>         }
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 3a0995f8bce8..0da614a50edd 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -137,6 +137,18 @@ struct cppc_cpudata {
>  };
>
>  #ifdef CONFIG_ACPI_CPPC_LIB
> +
> +#define MAX_NUM_CPC_REGS_FFH 2
> +
> +struct ffh_cpc_reg {
> +       struct cpc_reg *reg;
> +       u64 value;
> +};
> +
> +struct ffh_cpc_reg_values {
> +       struct ffh_cpc_reg regs[MAX_NUM_CPC_REGS_FFH];
> +};
> +
>  extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
>  extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
>  extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb=
_ctrs);
> @@ -153,6 +165,7 @@ extern unsigned int cppc_get_transition_latency(int c=
pu);
>  extern bool cpc_ffh_supported(void);
>  extern bool cpc_supported_by_cpu(void);
>  extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
> +extern int cpc_read_regs_ffh(int cpu, struct ffh_cpc_reg_values *regs);
>  extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
>  extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>  extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls=
, bool enable);
> --

