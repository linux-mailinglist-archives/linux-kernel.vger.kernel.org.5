Return-Path: <linux-kernel+bounces-28501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C9E82FF51
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D24BB24BEB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCA9747C;
	Wed, 17 Jan 2024 03:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="SRt8WnhD"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F2879EE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 03:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705462547; cv=none; b=QY3KTDlMkaKngxV/y5YAjF0U/xnfbd0pZln53HxGKzcupf9hHA2fX0gP/JMaZvPjkj01Xatwy23EkOJf8V1JupUFMsUfPwjky3dTT6Rwq2rhnKhrPifjrfnAWxKHodpBOqIskEeBxCS3DDvbV1AXGfYKiOWSdfQqkbymkkt4tBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705462547; c=relaxed/simple;
	bh=cBfsCb32nUijnXH54o/TiQ0y5BseV36p/OWgKgIsIlo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=UB3rBS9K4rUMhPfqd2yrNGQW6HOiKDmUmu6gaS7XTWaH2vXIFqOdy0vAX/+ASHTfkSUKdHcCV8PLom/acEy4atS74jkybJLXTmfS9cV47pz0FgRyoYugHcdO6fSCc1062zWXcBK1xg+i9JBTl7+Jz0WveNYZd8/pBPBp2vfouEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=SRt8WnhD; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e9e5c97e1so13306127e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705462543; x=1706067343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPVeCK5B9gXpBTr58po98cr58qEX6SUXFpMHlNs4+4k=;
        b=SRt8WnhDtqXaTRJlroK+b1NSlUxmgZe695eZO64J7052Q7ZgKIxqbDwhR+Fk3Hs5yN
         uBax2mZNH+CGIOAP/KAJ2KsyskcH7eyXED0+FyaOjlAw7vyKlxQKD/dU4hpWL3jf3Lry
         MoTPGUxO8BTeEWeOzXd1du8Rwv7z5CqZP8BbEHjK3o0wNE2CIlqYhI+2u++hC/Y/+UO9
         2QtiLzhArF+P/TjHEWTknr8SsJeFggl/x0oPmg1PqKxBKG/tqfrmLxSbKvKcnYZxb81e
         +l3OScbPdM6PJXKEdxP1XlKcrfQg7AVKdKSLZmBhPiozJBgTa46B2a2TzxlYxKEyfHLl
         i2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705462543; x=1706067343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPVeCK5B9gXpBTr58po98cr58qEX6SUXFpMHlNs4+4k=;
        b=KPH+kw+DeuT2dabhLwkFoPqZsZv5IvEUBzdkJq3lrs1is8fXpfqZqIZuPAHEZnTzhr
         FXfYHfgkMphWWZApylFgBi9Fpz+vMLgG/wZUPvG8ciaShFAH0qpkY6LSPV6im0FuCXyx
         2YFPkexHHdB0836ruKCdrfuWQmx7lZYJW7VraO65SGLXg7c0MErmo0Ihs4GD6uTV0ah5
         j4+h66ZoqE0IOginEIzLTMKTQbCcNQZZFM1ZsfNIPDiQ9+SQxi/BxcrJ8SY1l+JimhP/
         snaLwUlY9HWQF376gHbwlYJHZeKh2VuDCYXTiArOl+aR9SgnTzapR8JSVVyEosYixn1n
         Du2w==
X-Gm-Message-State: AOJu0Yw7URBjjCoWaOBudAEU4K3WSQvkbYPEvBD4FD2j3jdpDpDd2+GK
	0g/+c7VK7qjg561Gw4b9MCWMWAF+QC6rHq1PKDwF33832TuoTA==
X-Google-Smtp-Source: AGHT+IHD9rX+AypBxN5wLbJtFq2oz+0qCtxWPENssoBJF6WaLlzLLisFCbSvBoR6Qt8OOfZpDduvBPuY6PDtvcPgU7U=
X-Received: by 2002:a05:6512:3da0:b0:50e:d514:77c3 with SMTP id
 k32-20020a0565123da000b0050ed51477c3mr4684846lfv.10.1705462542798; Tue, 16
 Jan 2024 19:35:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110073917.2398826-1-peterlin@andestech.com>
 <20240110073917.2398826-8-peterlin@andestech.com> <CAOnJCUKY8H+pvgTWW5zkfm8O4WR-OWOKmyPTcMjUZBCC5RaLWQ@mail.gmail.com>
In-Reply-To: <CAOnJCUKY8H+pvgTWW5zkfm8O4WR-OWOKmyPTcMjUZBCC5RaLWQ@mail.gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Wed, 17 Jan 2024 09:05:31 +0530
Message-ID: <CAK9=C2WHX6f3miX3ceUnFT6PyjnUNHnUOKoRSmJr_rt78njaQA@mail.gmail.com>
Subject: Re: [PATCH v7 07/16] RISC-V: Move T-Head PMU to CPU feature
 alternative framework
To: Atish Patra <atishp@atishpatra.org>
Cc: Yu Chien Peter Lin <peterlin@andestech.com>, mark.rutland@arm.com, irogers@google.com, 
	heiko@sntech.de, geert+renesas@glider.be, alexander.shishkin@linux.intel.com, 
	linux-kernel@vger.kernel.org, conor.dooley@microchip.com, guoren@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, linux-riscv@lists.infradead.org, 
	will@kernel.org, linux-renesas-soc@vger.kernel.org, tim609@andestech.com, 
	samuel@sholland.org, anup@brainfault.org, dminus@andestech.com, 
	magnus.damm@gmail.com, jernej.skrabec@gmail.com, peterz@infradead.org, 
	wens@csie.org, mingo@redhat.com, jszhang@kernel.org, inochiama@outlook.com, 
	linux-sunxi@lists.linux.dev, ajones@ventanamicro.com, 
	devicetree@vger.kernel.org, conor+dt@kernel.org, aou@eecs.berkeley.edu, 
	andre.przywara@arm.com, locus84@andestech.com, acme@kernel.org, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, robh+dt@kernel.org, 
	paul.walmsley@sifive.com, namhyung@kernel.org, tglx@linutronix.de, 
	linux-arm-kernel@lists.infradead.org, ycliang@andestech.com, 
	n.shubin@yadro.com, rdunlap@infradead.org, chao.wei@sophgo.com, 
	adrian.hunter@intel.com, conor@kernel.org, linux-perf-users@vger.kernel.org, 
	evan@rivosinc.com, palmer@dabbelt.com, jolsa@kernel.org, 
	unicorn_wang@outlook.com, wefu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 2:26=E2=80=AFAM Atish Patra <atishp@atishpatra.org>=
 wrote:
>
> On Tue, Jan 9, 2024 at 11:40=E2=80=AFPM Yu Chien Peter Lin
> <peterlin@andestech.com> wrote:
> >
> > The custom PMU extension aims to support perf event sampling prior
> > to the ratification of Sscofpmf. Instead of diverting the bits and
> > register reserved for future standard, a set of custom registers is
> > added.  Hence, we may consider it as a CPU feature rather than an
> > erratum.
> >
>
> I don't think we should do that. Any custom implementation that
> violates the standard RISC-V spec should
> be an errata not a feature.
> As per my understanding, a vendor can call an extension custom ISA
> extension if the same feature is not available
> in the standard ISA extensions or the mechanism is completely
> different. It must also not violate any standard spec as well.

I agree with Atish here. There is a well defined encoding space for
custom extensions.

If a custom extension spills over to standard encoding space then
it should be treated as an errata and not a proper custom extension.

>
> In this case, a standard sscofpmf is already available. Moreover, both
> Andes and T-head extensions violate the standard
> spec by reusing local interrupt numbers (17(Thead) & 18(Andes)) which
> are clearly specified as reserved for standard local interrupts
> in the AIA specification.
>
> Please implementation Andes PMU support as an errata as well similar to T=
-head
>
>
> > T-Head cores need to append "xtheadpmu" to the riscv,isa-extensions
> > for each cpu node in device tree, and enable CONFIG_THEAD_CUSTOM_PMU
> > for proper functioning as of this commit.

T-Head has many violations of using standard encoding space. I don't see
why this series should be touching T-Head erratas.

If Andes custom PMU CSRs are defined in custom encoding space then
Andes PMU can be treated as proper custom extension.

Regards,
Anup

> >
> > Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> > Reviewed-by: Guo Ren <guoren@kernel.org>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > Changes v1 -> v2:
> >   - New patch
> > Changes v2 -> v3:
> >   - Removed m{vendor/arch/imp}id checks in pmu_sbi_setup_irqs()
> > Changes v3 -> v4:
> >   - No change
> > Changes v4 -> v5:
> >   - Include Guo's Reviewed-by
> >   - Let THEAD_CUSTOM_PMU depend on ARCH_THEAD
> > Changes v5 -> v6:
> >   - Include Conor's Reviewed-by
> > Changes v6 -> v7:
> >   - No change
> > ---
> >  arch/riscv/Kconfig.errata            | 13 -------------
> >  arch/riscv/errata/thead/errata.c     | 19 -------------------
> >  arch/riscv/include/asm/errata_list.h | 15 +--------------
> >  arch/riscv/include/asm/hwcap.h       |  1 +
> >  arch/riscv/kernel/cpufeature.c       |  1 +
> >  drivers/perf/Kconfig                 | 13 +++++++++++++
> >  drivers/perf/riscv_pmu_sbi.c         | 19 ++++++++++++++-----
> >  7 files changed, 30 insertions(+), 51 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> > index e2c731cfed8c..0d19f47d1018 100644
> > --- a/arch/riscv/Kconfig.errata
> > +++ b/arch/riscv/Kconfig.errata
> > @@ -86,17 +86,4 @@ config ERRATA_THEAD_CMO
> >
> >           If you don't know what to do here, say "Y".
> >
> > -config ERRATA_THEAD_PMU
> > -       bool "Apply T-Head PMU errata"
> > -       depends on ERRATA_THEAD && RISCV_PMU_SBI
> > -       default y
> > -       help
> > -         The T-Head C9xx cores implement a PMU overflow extension very
> > -         similar to the core SSCOFPMF extension.
> > -
> > -         This will apply the overflow errata to handle the non-standar=
d
> > -         behaviour via the regular SBI PMU driver and interface.
> > -
> > -         If you don't know what to do here, say "Y".
> > -
> >  endmenu # "CPU errata selection"
> > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead=
/errata.c
> > index 0554ed4bf087..5de5f7209132 100644
> > --- a/arch/riscv/errata/thead/errata.c
> > +++ b/arch/riscv/errata/thead/errata.c
> > @@ -53,22 +53,6 @@ static bool errata_probe_cmo(unsigned int stage,
> >         return true;
> >  }
> >
> > -static bool errata_probe_pmu(unsigned int stage,
> > -                            unsigned long arch_id, unsigned long impid=
)
> > -{
> > -       if (!IS_ENABLED(CONFIG_ERRATA_THEAD_PMU))
> > -               return false;
> > -
> > -       /* target-c9xx cores report arch_id and impid as 0 */
> > -       if (arch_id !=3D 0 || impid !=3D 0)
> > -               return false;
> > -
> > -       if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT)
> > -               return false;
> > -
> > -       return true;
> > -}
> > -
> >  static u32 thead_errata_probe(unsigned int stage,
> >                               unsigned long archid, unsigned long impid=
)
> >  {
> > @@ -80,9 +64,6 @@ static u32 thead_errata_probe(unsigned int stage,
> >         if (errata_probe_cmo(stage, archid, impid))
> >                 cpu_req_errata |=3D BIT(ERRATA_THEAD_CMO);
> >
> > -       if (errata_probe_pmu(stage, archid, impid))
> > -               cpu_req_errata |=3D BIT(ERRATA_THEAD_PMU);
> > -
> >         return cpu_req_errata;
> >  }
> >
> > diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/=
asm/errata_list.h
> > index 4ed21a62158c..9bccc2ba0eb5 100644
> > --- a/arch/riscv/include/asm/errata_list.h
> > +++ b/arch/riscv/include/asm/errata_list.h
> > @@ -25,8 +25,7 @@
> >  #ifdef CONFIG_ERRATA_THEAD
> >  #define        ERRATA_THEAD_PBMT 0
> >  #define        ERRATA_THEAD_CMO 1
> > -#define        ERRATA_THEAD_PMU 2
> > -#define        ERRATA_THEAD_NUMBER 3
> > +#define        ERRATA_THEAD_NUMBER 2
> >  #endif
> >
> >  #ifdef __ASSEMBLY__
> > @@ -147,18 +146,6 @@ asm volatile(ALTERNATIVE_2(                       =
                         \
> >             "r"((unsigned long)(_start) + (_size))                     =
 \
> >         : "a0")
> >
> > -#define THEAD_C9XX_RV_IRQ_PMU                  17
> > -#define THEAD_C9XX_CSR_SCOUNTEROF              0x5c5
> > -
> > -#define ALT_SBI_PMU_OVERFLOW(__ovl)                                   =
 \
> > -asm volatile(ALTERNATIVE(                                             =
 \
> > -       "csrr %0, " __stringify(CSR_SSCOUNTOVF),                       =
 \
> > -       "csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),            =
 \
> > -               THEAD_VENDOR_ID, ERRATA_THEAD_PMU,                     =
 \
> > -               CONFIG_ERRATA_THEAD_PMU)                               =
 \
> > -       : "=3Dr" (__ovl) :                                             =
   \
> > -       : "memory")
> > -
> >  #endif /* __ASSEMBLY__ */
> >
> >  #endif
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hw=
cap.h
> > index 5340f818746b..480f9da7fba7 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -80,6 +80,7 @@
> >  #define RISCV_ISA_EXT_ZFA              71
> >  #define RISCV_ISA_EXT_ZTSO             72
> >  #define RISCV_ISA_EXT_ZACAS            73
> > +#define RISCV_ISA_EXT_XTHEADPMU                74
> >
> >  #define RISCV_ISA_EXT_MAX              128
> >  #define RISCV_ISA_EXT_INVALID          U32_MAX
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index e32591e9da90..4aded5bf8fc3 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -303,6 +303,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D=
 {
> >         __RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
> >         __RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
> >         __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> > +       __RISCV_ISA_EXT_DATA(xtheadpmu, RISCV_ISA_EXT_XTHEADPMU),
> >  };
> >
> >  const size_t riscv_isa_ext_count =3D ARRAY_SIZE(riscv_isa_ext);
> > diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> > index 273d67ecf6d2..6cef15ec7c25 100644
> > --- a/drivers/perf/Kconfig
> > +++ b/drivers/perf/Kconfig
> > @@ -86,6 +86,19 @@ config RISCV_PMU_SBI
> >           full perf feature support i.e. counter overflow, privilege mo=
de
> >           filtering, counter configuration.
> >
> > +config THEAD_CUSTOM_PMU
> > +       bool "T-Head custom PMU support"
> > +       depends on ARCH_THEAD && RISCV_ALTERNATIVE && RISCV_PMU_SBI
> > +       default y
> > +       help
> > +         The T-Head C9xx cores implement a PMU overflow extension very
> > +         similar to the core SSCOFPMF extension.
> > +
> > +         This will patch the overflow CSR and handle the non-standard
> > +         behaviour via the regular SBI PMU driver and interface.
> > +
> > +         If you don't know what to do here, say "Y".
> > +
> >  config ARM_PMU_ACPI
> >         depends on ARM_PMU && ACPI
> >         def_bool y
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.=
c
> > index 2edbc37abadf..31ca79846399 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -20,10 +20,21 @@
> >  #include <linux/cpu_pm.h>
> >  #include <linux/sched/clock.h>
> >
> > -#include <asm/errata_list.h>
> >  #include <asm/sbi.h>
> >  #include <asm/cpufeature.h>
> >
> > +#define THEAD_C9XX_RV_IRQ_PMU          17
> > +#define THEAD_C9XX_CSR_SCOUNTEROF      0x5c5
> > +
> > +#define ALT_SBI_PMU_OVERFLOW(__ovl)                                   =
 \
> > +asm volatile(ALTERNATIVE(                                             =
 \
> > +       "csrr %0, " __stringify(CSR_SSCOUNTOVF),                       =
 \
> > +       "csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),            =
 \
> > +               0, RISCV_ISA_EXT_XTHEADPMU,                            =
 \
> > +               CONFIG_THEAD_CUSTOM_PMU)                               =
 \
> > +       : "=3Dr" (__ovl) :                                             =
   \
> > +       : "memory")
> > +
> >  #define SYSCTL_NO_USER_ACCESS  0
> >  #define SYSCTL_USER_ACCESS     1
> >  #define SYSCTL_LEGACY          2
> > @@ -808,10 +819,8 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pm=
u, struct platform_device *pde
> >         if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
> >                 riscv_pmu_irq_num =3D RV_IRQ_PMU;
> >                 riscv_pmu_use_irq =3D true;
> > -       } else if (IS_ENABLED(CONFIG_ERRATA_THEAD_PMU) &&
> > -                  riscv_cached_mvendorid(0) =3D=3D THEAD_VENDOR_ID &&
> > -                  riscv_cached_marchid(0) =3D=3D 0 &&
> > -                  riscv_cached_mimpid(0) =3D=3D 0) {
> > +       } else if (riscv_isa_extension_available(NULL, XTHEADPMU) &&
> > +                  IS_ENABLED(CONFIG_THEAD_CUSTOM_PMU)) {
> >                 riscv_pmu_irq_num =3D THEAD_C9XX_RV_IRQ_PMU;
> >                 riscv_pmu_use_irq =3D true;
> >         }
> > --
> > 2.34.1
> >
>
>
> --
> Regards,
> Atish
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

