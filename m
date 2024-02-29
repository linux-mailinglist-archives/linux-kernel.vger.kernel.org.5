Return-Path: <linux-kernel+bounces-87229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5D886D15E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FF12B228DA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B5178268;
	Thu, 29 Feb 2024 18:03:05 +0000 (UTC)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18472E410;
	Thu, 29 Feb 2024 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709229785; cv=none; b=qF1PWog4Z5ZGWtPaNn90X8MC3y+xuAIXpp0KNSdReMRjGE1RiYoo/8Un3py3e5mfPBDRmFR+QScTajL9xIpyHqHp5T4RFpeoFiSU2dqH/1cyfuAloZMGLX+mSDNMtbsb3nmt9JcHvJvnE7vQ6EP1lfOCMLExw1kpigiOcSeSY7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709229785; c=relaxed/simple;
	bh=Yv7Kh+xyzhHgEEJC7cvh6WUFRIzB9hwLqRLYbL6gjZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIfK5DagTAOhrLRtgyU8jKnFTSyUDlvfWg9S2bblDpE7wvwl1aX6oS6Jp++b60v1lDLAIfVmBlhralShjL8Ne7DfzSs1yHwotpRrGKdJU0IAfRGZIlhKSd9qCtVvbxUNtA1LXypD2KJh3IEhhI9ghSxCy/9bfeNrQe4fR5BbmuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e45f7c63f4so156910a34.1;
        Thu, 29 Feb 2024 10:03:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709229782; x=1709834582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+vLszme3j62CDIVZVLpVdKt2WiORGBWMybzMte4imE=;
        b=Z5q4FK3/Bg/XXIgNjGhp6cpRLtGg4cLjLi3kaDf/7DnJNxGFuGrChXwofhr4/AVV/f
         oiHHjGfQtr7MeA6O7mEY1bUgJc1lVU4rytu25STCZ0sv3KSXIAl5Mk6YMf3DuaqFbFJ1
         Pe6BeB0WeJYb2qg/2d68g1+UJfFpwjKaI6gIXlm8ImTv9c2GMFPT3T62loRpSzWaBuoH
         WpaqKU3wmsXqPv6pEEr3PgHULRuriXOTi16DjqYdbbvP8dzm9qWHTYdtggyA3X9H9/sf
         uPJfzLaHt9KJkr76+ObptvSaGuLf4xj6Ax02yOaoKE4Aio1B58BVmOv5/9CPYCjMDOCH
         uEdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqOSQ3YEQdQK4EpOotaiwwofBJSOU4J+mw4hT8myOqHNv+bUF5xwBpGe0gGI5wTRkGcud7yABTrk8RM6hMOUtmYdCn40VDx5/JQQH/uJb2TRqUEr6szaZEBv3CDBJL8ilNeFAHzqIkKKEb2KxVBEXObOjpc28CY6/3cJgbPbDBHwJ+
X-Gm-Message-State: AOJu0Yz9frwHjSq2Z7TQP+d6Zid6FprDFsf3nJD7Ck+TfOUDpSFR0FzL
	znHyWW83Ar2F7FjM/i4VYTJhuGYPZ8eVqbZMyblmfRdvquZFGXtV84PRXBUbnJV+ZlMpvKxb19K
	wsKNCgHFUBcuc/r3n0F2ti3GT5ko=
X-Google-Smtp-Source: AGHT+IGjwCt8gwPhtD2QfGUFtj7EEmyRNMqlWVH4M3FPv6FvZwVjPAuxpU04rmh+tGHIdUKcjXgxVuCjIWguAI1Ld88=
X-Received: by 2002:a4a:301:0:b0:5a0:396d:2489 with SMTP id
 1-20020a4a0301000000b005a0396d2489mr2769270ooi.1.1709229781780; Thu, 29 Feb
 2024 10:03:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229162520.970986-1-vanshikonda@os.amperecomputing.com>
 <20240229162520.970986-4-vanshikonda@os.amperecomputing.com>
 <CAJZ5v0j+qz0okToszmU=kBjZvD3GJKzwz-ZrweOkgw6A2e3pQQ@mail.gmail.com> <5paw5cvh7klhwasvldyl2coaihntkv4cvmogzyov7qwyohxmvl@lt3auiqhg2nv>
In-Reply-To: <5paw5cvh7klhwasvldyl2coaihntkv4cvmogzyov7qwyohxmvl@lt3auiqhg2nv>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Feb 2024 19:02:50 +0100
Message-ID: <CAJZ5v0j9t8y9dvTmVXsyUha73a6CBx8iHQNkteY_Bogx27sHLg@mail.gmail.com>
Subject: Re: Re: [PATCH v1 3/3] ACPI: CPPC: Read CPC FFH counters in a single IPI
To: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Huisong Li <lihuisong@huawei.com>, 
	Beata Michalska <beata.michalska@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, sumitg@nvidia.com, zengheng4@huawei.com, 
	yang@os.amperecomputing.com, will@kernel.org, sudeep.holla@arm.com, 
	liuyonglong@huawei.com, zhanjie9@hisilicon.com, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 7:01=E2=80=AFPM Vanshidhar Konda
<vanshikonda@os.amperecomputing.com> wrote:
>
> On Thu, Feb 29, 2024 at 06:32:59PM +0100, Rafael J. Wysocki wrote:
> >On Thu, Feb 29, 2024 at 5:25=E2=80=AFPM Vanshidhar Konda
> ><vanshikonda@os.amperecomputing.com> wrote:
> >>
> >> The CPPC driver reads delivered and reference counters using cpc_read
> >> one at a time. This leads to inaccurate measurement of CPU frequency
> >> discussed in [1]. If the firmware indicates that both the registers ar=
e
> >> in the FFH interface the kernel can read the registers together in a
> >> single IPI. This has two benefits:
> >> 1. Reduces the number of IPIs needed to read the two registers
> >> 2. The two registers will be read in close proximity resulting in more
> >>    accurate CPU frequency measurement
> >>
> >> [1]: https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperec=
omputing.com/
> >>
> >> Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> >> ---
> >>  arch/arm64/kernel/topology.c | 37 +++++++++++++++++++++++++++++++++++=
+
> >>  drivers/acpi/cppc_acpi.c     | 32 +++++++++++++++++++++++++++----
> >>  include/acpi/cppc_acpi.h     | 13 +++++++++++++
> >>  3 files changed, 78 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology=
c
> >> index 8905eb0c681f..8207565f43ee 100644
> >> --- a/arch/arm64/kernel/topology.c
> >> +++ b/arch/arm64/kernel/topology.c
> >> @@ -421,6 +421,43 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u6=
4 *val)
> >>         return ret;
> >>  }
> >>
> >> +static void cpc_update_freq_counters(void *info)
> >> +{
> >> +       update_freq_counters_refs();
> >> +}
> >> +
> >> +int cpc_read_regs_ffh(int cpu, struct ffh_cpc_reg_values *ffh_regs)
> >> +{
> >> +       struct amu_counters *ctrs =3D per_cpu_ptr(&cpu_samples, cpu);
> >> +       int idx;
> >> +
> >> +       if (!cpc_ffh_supported() || !freq_counters_valid(cpu))
> >> +               return -EOPNOTSUPP;
> >> +
> >> +       if (WARN_ON_ONCE(irqs_disabled()))
> >> +               return -EPERM;
> >> +
> >> +       if (!idle_cpu(cpu))
> >> +               smp_call_function_single(cpu, cpc_update_freq_counters=
, NULL, 1);
> >> +
> >> +       for (idx =3D 0; idx < MAX_NUM_CPC_REGS_FFH; idx++) {
> >> +
> >> +               if (!ffh_regs->regs[idx].reg)
> >> +                       continue;
> >> +
> >> +               switch ((u64)(ffh_regs->regs[idx].reg->address)) {
> >> +               case 0x0:
> >> +                       ffh_regs->regs[idx].value =3D ctrs->core_cnt;
> >> +                       break;
> >> +               case 0x1:
> >> +                       ffh_regs->regs[idx].value =3D ctrs->const_cnt;
> >> +                       break;
> >> +               }
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>  int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
> >>  {
> >>         return -EOPNOTSUPP;
> >> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> >> index d155a86a8614..55ffb1915e4f 100644
> >> --- a/drivers/acpi/cppc_acpi.c
> >> +++ b/drivers/acpi/cppc_acpi.c
> >> @@ -113,6 +113,10 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc=
_ptr);
> >>                                 (cpc)->cpc_entry.reg.space_id =3D=3D  =
      \
> >>                                 ACPI_ADR_SPACE_SYSTEM_IO)
> >>
> >> +#define CPC_IN_FFH(cpc) ((cpc)->type =3D=3D ACPI_TYPE_BUFFER &&      =
      \
> >> +                               (cpc)->cpc_entry.reg.space_id =3D=3D  =
      \
> >> +                               ACPI_ADR_SPACE_FIXED_HARDWARE)
> >> +
> >>  /* Evaluates to True if reg is a NULL register descriptor */
> >>  #define IS_NULL_REG(reg) ((reg)->space_id =3D=3D  ACPI_ADR_SPACE_SYST=
EM_MEMORY && \
> >>                                 (reg)->address =3D=3D 0 &&            =
      \
> >> @@ -974,6 +978,11 @@ int __weak cpc_write_ffh(int cpunum, struct cpc_r=
eg *reg, u64 val)
> >>         return -ENOTSUPP;
> >>  }
> >>
> >> +int __weak cpc_read_regs_ffh(int cpu, struct ffh_cpc_reg_values *regs=
)
> >> +{
> >> +       return -ENOTSUPP;
> >> +}
> >
> >This might return a bool value.
> >
> >Is there any case in which the caller would handle different error
> >codes differently?
> >
> I kept this similar to cpc_read_ffh(). I didn't see any usage of the erro=
r
> codes. The return value of cpc_read_ffh() is returned only from cpc_read(=
),
> but I didn't see anyone consuming the return value of cpc_read().
> Additionally, checkpatch complains about using -ENOTSUPP and suggests
> replacing it with -EOPNOTSUPP. Does it make sense to update
> cpc_read/write_ffh() as well to switch to return type bool?

Probably, but in a separate patch.

