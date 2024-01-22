Return-Path: <linux-kernel+bounces-32606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 048A6835DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A03287B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16DD39FD5;
	Mon, 22 Jan 2024 09:13:49 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D493984B;
	Mon, 22 Jan 2024 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914828; cv=none; b=AtuToZ82MZLFCyGrVIqT83L0IlYMRJ6DnEWYtsgx1h0UAw0tsDtBN7EyHtt0+bLOGuDwcbtDjBv4cVIzynvyePnH8siESZjL7csZWfoFLepFI2dllhpIjXtEaFOz1aZYueM6H8zK8i/JL7Dx6vRohxq5ArDJEpTM+O81RgaX+z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914828; c=relaxed/simple;
	bh=qjTJunYxd6Ymn/24Ra171UNwHdkldPIjlP/bvZ0nGQI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qakd7+3+OWGyM6k0M0qI35xY7kY1p/6ztK79ZpkHD7DKGsjylgJw66+8a5Dn0lEx/6RrtdfFkOJb6Vl3XcCAWnwWZz/F2HF9wTuQ/xcLdookMdgimUS9x42cRsGe1vmQDYGVEqvXVnj/ZAzYnMh2ijucm4avz/nb2+XtlUvMNH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 40M8pNQq089573;
	Mon, 22 Jan 2024 16:51:23 +0800 (+08)
	(envelope-from peterlin@andestech.com)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
	by Atcsqr.andestech.com with ESMTP id 40M8mbXp088104;
	Mon, 22 Jan 2024 16:48:37 +0800 (+08)
	(envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Mon, 22 Jan 2024 16:48:36 +0800
Date: Mon, 22 Jan 2024 16:48:32 +0800
From: Yu-Chien Peter Lin <peterlin@andestech.com>
To: Atish Patra <atishp@atishpatra.org>
CC: Conor Dooley <conor@kernel.org>, <acme@kernel.org>,
        <adrian.hunter@intel.com>, <ajones@ventanamicro.com>,
        <alexander.shishkin@linux.intel.com>, <andre.przywara@arm.com>,
        <anup@brainfault.org>, <aou@eecs.berkeley.edu>, <conor+dt@kernel.org>,
        <conor.dooley@microchip.com>, <devicetree@vger.kernel.org>,
        <dminus@andestech.com>, <evan@rivosinc.com>, <geert+renesas@glider.be>,
        <guoren@kernel.org>, <heiko@sntech.de>, <irogers@google.com>,
        <jernej.skrabec@gmail.com>, <jolsa@kernel.org>, <jszhang@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <locus84@andestech.com>,
        <magnus.damm@gmail.com>, <mark.rutland@arm.com>, <mingo@redhat.com>,
        <n.shubin@yadro.com>, <namhyung@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <peterz@infradead.org>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <sunilvl@ventanamicro.com>, <tglx@linutronix.de>,
        <tim609@andestech.com>, <uwu@icenowy.me>, <wens@csie.org>,
        <will@kernel.org>, <ycliang@andestech.com>, <inochiama@outlook.com>,
        <chao.wei@sophgo.com>, <unicorn_wang@outlook.com>, <wefu@redhat.com>
Subject: Re: [PATCH v7 07/16] RISC-V: Move T-Head PMU to CPU feature
 alternative framework
Message-ID: <Za4r4FB9NVXaCOv5@APC323>
References: <20240110073917.2398826-1-peterlin@andestech.com>
 <20240110073917.2398826-8-peterlin@andestech.com>
 <CAOnJCUKY8H+pvgTWW5zkfm8O4WR-OWOKmyPTcMjUZBCC5RaLWQ@mail.gmail.com>
 <20240116-cherub-revival-5d32cc5f1fd0@spud>
 <CAOnJCU+DvoV08n5LLv-yrPOnUKNEQU9w344UBJ4Ou5-2LJwrrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOnJCU+DvoV08n5LLv-yrPOnUKNEQU9w344UBJ4Ou5-2LJwrrw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 40M8pNQq089573

Thank you all for your opinion,
In fact, the Sscofpmf has been implemented in Andes cores newer than
AX45, which is the last one to support Andes PMU. Additionally, this
feature will be switched to Sscofpmf once Andes core supports AIA.

On Wed, Jan 17, 2024 at 12:58:21AM -0800, Atish Patra wrote:
> On Tue, Jan 16, 2024 at 4:16 PM Conor Dooley <conor@kernel.org> wrote:
> >
> > On Tue, Jan 16, 2024 at 12:55:41PM -0800, Atish Patra wrote:
> > > On Tue, Jan 9, 2024 at 11:40 PM Yu Chien Peter Lin
> > > <peterlin@andestech.com> wrote:
> > > >
> > > > The custom PMU extension aims to support perf event sampling prior
> > > > to the ratification of Sscofpmf. Instead of diverting the bits and
> > > > register reserved for future standard, a set of custom registers is
> > > > added.  Hence, we may consider it as a CPU feature rather than an
> > > > erratum.
> > > >
> > >
> > > I don't think we should do that. Any custom implementation that
> > > violates the standard RISC-V spec should
> > > be an errata not a feature.
> > > As per my understanding, a vendor can call an extension custom ISA
> > > extension if the same feature is not available
> > > in the standard ISA extensions or the mechanism is completely
> > > different. It must also not violate any standard spec as well.
> > >
> > > In this case, a standard sscofpmf is already available. Moreover, both
> > > Andes and T-head extensions violate the standard
> > > spec by reusing local interrupt numbers (17(Thead) & 18(Andes)) which
> > > are clearly specified as reserved for standard local interrupts
> > > in the AIA specification.
> >
> > I disagree with you here. The Andes implementation predated (IIRC that
> > is what was said in replies to an earlier revision) the Sscofpmf
> > extension and certainly predates the AIA specification. I would be on
> > board with this line of thinking if someone comes along in 2030 with
> > "Zbb but with this one tweak" or where something flies entirely in the
> > face of the standard (like the IOCP cache stuff). The relevant section
> > in the AIA spec seems to say:
> > | Interrupt causes that are standardized by the Privileged Architecture
> > | have major identities in the range 0–15, while numbers 16 and higher are
> > | officially available for platform standards or for custom use.
> > | The Advanced Interrupt Architecture claims further authority over
> > | identity numbers in the ranges 16–23 and 32–47, leaving numbers in the
> > | range 24–31 and all major identities 48 and higher still free for custom
> > | use.
> > I don't see how that can be problematic given the Andes implemtation
> > dates from before AIA was a thing. It would be silly to say that because
> > an optional extension later came along and took over something previously
> > allowed for indiscriminate custom use, that support for that custom
> > extension is not permitted.
> >
> 
> AIA is not some optional extension. It defines the RISC-V interrupt
> architecture going forward and will be the default implementation
> in the future. IMO, this will be a slippery slope if we start
> supporting custom implementations to override interrupt ID definitions
> via custom cpu features. T-head implementation works perfectly fine as
> an errata and I don't understand why
> there is a push to make it a cpu feature. We should try to improve the
> ecosystem for future platforms rather than bending
> backwards to support older implementations.
> 
> I understand the push to brand this as a custom extension if current
> errata/alternative can't support it. But I don't think that's the case
> here though. Please correct me if I am wrong.
> 
> > I may well be missing something here though, you clearly know these
> > specs better than I do, but from what I have read I disagree.
> >
> > > Please implementation Andes PMU support as an errata as well similar to T-head
> >
> > I certainly _do not_ want to see things like this detected via lookup
> > tables of marchid and co in the kernel unless it is absolutely required.
> > We have standard probing mechanisms for feature detection (because to me
> > this _is_ a feature) and they should be used. Additionally, we define what
> > entries in the DT properties mean, and if it is convenient to put
> > "psuedo" extensions into the DT, then we should do so. Getting away from
> > being tied to what RVI decrees was one of the goals of the new
> > properties after all, so that we could use a standard mechanism of DT
> > probing for things like this.
> >
> 
> Yes. That's a perfectly valid mechanism for actual custom/vendor ISA extensions.
> I'm sure we'll have many of those, which will be leveraged via pseudo
> extensions in the DT.
> However, these shouldn't co-exist with standard ISA extensions in the
> namespace in riscv_isa_ext and/or hwprobe.
> The vendor-specific extensions should be defined under a
> vendor-specific namespace.

I will remove T-Head PMU changes from this series.
Could you please elaborate a bit more on how should I add a vendor-specific
extension?

Thanks,
Peter Lin

> This was another issue with this series as well. I didn't raise this
> topic earlier because I don't think overriding interrupt
> identities qualifies for a custom ISA extension
> 
> > Thanks,
> > Conor.
> >
> > > > T-Head cores need to append "xtheadpmu" to the riscv,isa-extensions
> > > > for each cpu node in device tree, and enable CONFIG_THEAD_CUSTOM_PMU
> > > > for proper functioning as of this commit.
> > > >
> > > > Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> > > > Reviewed-by: Guo Ren <guoren@kernel.org>
> > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > ---
> > > > Changes v1 -> v2:
> > > >   - New patch
> > > > Changes v2 -> v3:
> > > >   - Removed m{vendor/arch/imp}id checks in pmu_sbi_setup_irqs()
> > > > Changes v3 -> v4:
> > > >   - No change
> > > > Changes v4 -> v5:
> > > >   - Include Guo's Reviewed-by
> > > >   - Let THEAD_CUSTOM_PMU depend on ARCH_THEAD
> > > > Changes v5 -> v6:
> > > >   - Include Conor's Reviewed-by
> > > > Changes v6 -> v7:
> > > >   - No change
> > > > ---
> > > >  arch/riscv/Kconfig.errata            | 13 -------------
> > > >  arch/riscv/errata/thead/errata.c     | 19 -------------------
> > > >  arch/riscv/include/asm/errata_list.h | 15 +--------------
> > > >  arch/riscv/include/asm/hwcap.h       |  1 +
> > > >  arch/riscv/kernel/cpufeature.c       |  1 +
> > > >  drivers/perf/Kconfig                 | 13 +++++++++++++
> > > >  drivers/perf/riscv_pmu_sbi.c         | 19 ++++++++++++++-----
> > > >  7 files changed, 30 insertions(+), 51 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> > > > index e2c731cfed8c..0d19f47d1018 100644
> > > > --- a/arch/riscv/Kconfig.errata
> > > > +++ b/arch/riscv/Kconfig.errata
> > > > @@ -86,17 +86,4 @@ config ERRATA_THEAD_CMO
> > > >
> > > >           If you don't know what to do here, say "Y".
> > > >
> > > > -config ERRATA_THEAD_PMU
> > > > -       bool "Apply T-Head PMU errata"
> > > > -       depends on ERRATA_THEAD && RISCV_PMU_SBI
> > > > -       default y
> > > > -       help
> > > > -         The T-Head C9xx cores implement a PMU overflow extension very
> > > > -         similar to the core SSCOFPMF extension.
> > > > -
> > > > -         This will apply the overflow errata to handle the non-standard
> > > > -         behaviour via the regular SBI PMU driver and interface.
> > > > -
> > > > -         If you don't know what to do here, say "Y".
> > > > -
> > > >  endmenu # "CPU errata selection"
> > > > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> > > > index 0554ed4bf087..5de5f7209132 100644
> > > > --- a/arch/riscv/errata/thead/errata.c
> > > > +++ b/arch/riscv/errata/thead/errata.c
> > > > @@ -53,22 +53,6 @@ static bool errata_probe_cmo(unsigned int stage,
> > > >         return true;
> > > >  }
> > > >
> > > > -static bool errata_probe_pmu(unsigned int stage,
> > > > -                            unsigned long arch_id, unsigned long impid)
> > > > -{
> > > > -       if (!IS_ENABLED(CONFIG_ERRATA_THEAD_PMU))
> > > > -               return false;
> > > > -
> > > > -       /* target-c9xx cores report arch_id and impid as 0 */
> > > > -       if (arch_id != 0 || impid != 0)
> > > > -               return false;
> > > > -
> > > > -       if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> > > > -               return false;
> > > > -
> > > > -       return true;
> > > > -}
> > > > -
> > > >  static u32 thead_errata_probe(unsigned int stage,
> > > >                               unsigned long archid, unsigned long impid)
> > > >  {
> > > > @@ -80,9 +64,6 @@ static u32 thead_errata_probe(unsigned int stage,
> > > >         if (errata_probe_cmo(stage, archid, impid))
> > > >                 cpu_req_errata |= BIT(ERRATA_THEAD_CMO);
> > > >
> > > > -       if (errata_probe_pmu(stage, archid, impid))
> > > > -               cpu_req_errata |= BIT(ERRATA_THEAD_PMU);
> > > > -
> > > >         return cpu_req_errata;
> > > >  }
> > > >
> > > > diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> > > > index 4ed21a62158c..9bccc2ba0eb5 100644
> > > > --- a/arch/riscv/include/asm/errata_list.h
> > > > +++ b/arch/riscv/include/asm/errata_list.h
> > > > @@ -25,8 +25,7 @@
> > > >  #ifdef CONFIG_ERRATA_THEAD
> > > >  #define        ERRATA_THEAD_PBMT 0
> > > >  #define        ERRATA_THEAD_CMO 1
> > > > -#define        ERRATA_THEAD_PMU 2
> > > > -#define        ERRATA_THEAD_NUMBER 3
> > > > +#define        ERRATA_THEAD_NUMBER 2
> > > >  #endif
> > > >
> > > >  #ifdef __ASSEMBLY__
> > > > @@ -147,18 +146,6 @@ asm volatile(ALTERNATIVE_2(                                                \
> > > >             "r"((unsigned long)(_start) + (_size))                      \
> > > >         : "a0")
> > > >
> > > > -#define THEAD_C9XX_RV_IRQ_PMU                  17
> > > > -#define THEAD_C9XX_CSR_SCOUNTEROF              0x5c5
> > > > -
> > > > -#define ALT_SBI_PMU_OVERFLOW(__ovl)                                    \
> > > > -asm volatile(ALTERNATIVE(                                              \
> > > > -       "csrr %0, " __stringify(CSR_SSCOUNTOVF),                        \
> > > > -       "csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),             \
> > > > -               THEAD_VENDOR_ID, ERRATA_THEAD_PMU,                      \
> > > > -               CONFIG_ERRATA_THEAD_PMU)                                \
> > > > -       : "=r" (__ovl) :                                                \
> > > > -       : "memory")
> > > > -
> > > >  #endif /* __ASSEMBLY__ */
> > > >
> > > >  #endif
> > > > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > > > index 5340f818746b..480f9da7fba7 100644
> > > > --- a/arch/riscv/include/asm/hwcap.h
> > > > +++ b/arch/riscv/include/asm/hwcap.h
> > > > @@ -80,6 +80,7 @@
> > > >  #define RISCV_ISA_EXT_ZFA              71
> > > >  #define RISCV_ISA_EXT_ZTSO             72
> > > >  #define RISCV_ISA_EXT_ZACAS            73
> > > > +#define RISCV_ISA_EXT_XTHEADPMU                74
> > > >
> > > >  #define RISCV_ISA_EXT_MAX              128
> > > >  #define RISCV_ISA_EXT_INVALID          U32_MAX
> > > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > > > index e32591e9da90..4aded5bf8fc3 100644
> > > > --- a/arch/riscv/kernel/cpufeature.c
> > > > +++ b/arch/riscv/kernel/cpufeature.c
> > > > @@ -303,6 +303,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
> > > >         __RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
> > > >         __RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
> > > >         __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> > > > +       __RISCV_ISA_EXT_DATA(xtheadpmu, RISCV_ISA_EXT_XTHEADPMU),
> > > >  };
> > > >
> > > >  const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
> > > > diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> > > > index 273d67ecf6d2..6cef15ec7c25 100644
> > > > --- a/drivers/perf/Kconfig
> > > > +++ b/drivers/perf/Kconfig
> > > > @@ -86,6 +86,19 @@ config RISCV_PMU_SBI
> > > >           full perf feature support i.e. counter overflow, privilege mode
> > > >           filtering, counter configuration.
> > > >
> > > > +config THEAD_CUSTOM_PMU
> > > > +       bool "T-Head custom PMU support"
> > > > +       depends on ARCH_THEAD && RISCV_ALTERNATIVE && RISCV_PMU_SBI
> > > > +       default y
> > > > +       help
> > > > +         The T-Head C9xx cores implement a PMU overflow extension very
> > > > +         similar to the core SSCOFPMF extension.
> > > > +
> > > > +         This will patch the overflow CSR and handle the non-standard
> > > > +         behaviour via the regular SBI PMU driver and interface.
> > > > +
> > > > +         If you don't know what to do here, say "Y".
> > > > +
> > > >  config ARM_PMU_ACPI
> > > >         depends on ARM_PMU && ACPI
> > > >         def_bool y
> > > > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> > > > index 2edbc37abadf..31ca79846399 100644
> > > > --- a/drivers/perf/riscv_pmu_sbi.c
> > > > +++ b/drivers/perf/riscv_pmu_sbi.c
> > > > @@ -20,10 +20,21 @@
> > > >  #include <linux/cpu_pm.h>
> > > >  #include <linux/sched/clock.h>
> > > >
> > > > -#include <asm/errata_list.h>
> > > >  #include <asm/sbi.h>
> > > >  #include <asm/cpufeature.h>
> > > >
> > > > +#define THEAD_C9XX_RV_IRQ_PMU          17
> > > > +#define THEAD_C9XX_CSR_SCOUNTEROF      0x5c5
> > > > +
> > > > +#define ALT_SBI_PMU_OVERFLOW(__ovl)                                    \
> > > > +asm volatile(ALTERNATIVE(                                              \
> > > > +       "csrr %0, " __stringify(CSR_SSCOUNTOVF),                        \
> > > > +       "csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),             \
> > > > +               0, RISCV_ISA_EXT_XTHEADPMU,                             \
> > > > +               CONFIG_THEAD_CUSTOM_PMU)                                \
> > > > +       : "=r" (__ovl) :                                                \
> > > > +       : "memory")
> > > > +
> > > >  #define SYSCTL_NO_USER_ACCESS  0
> > > >  #define SYSCTL_USER_ACCESS     1
> > > >  #define SYSCTL_LEGACY          2
> > > > @@ -808,10 +819,8 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
> > > >         if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
> > > >                 riscv_pmu_irq_num = RV_IRQ_PMU;
> > > >                 riscv_pmu_use_irq = true;
> > > > -       } else if (IS_ENABLED(CONFIG_ERRATA_THEAD_PMU) &&
> > > > -                  riscv_cached_mvendorid(0) == THEAD_VENDOR_ID &&
> > > > -                  riscv_cached_marchid(0) == 0 &&
> > > > -                  riscv_cached_mimpid(0) == 0) {
> > > > +       } else if (riscv_isa_extension_available(NULL, XTHEADPMU) &&
> > > > +                  IS_ENABLED(CONFIG_THEAD_CUSTOM_PMU)) {
> > > >                 riscv_pmu_irq_num = THEAD_C9XX_RV_IRQ_PMU;
> > > >                 riscv_pmu_use_irq = true;
> > > >         }
> > > > --
> > > > 2.34.1
> > > >
> > >
> > >
> > > --
> > > Regards,
> > > Atish
> 
> 
> 
> -- 
> Regards,
> Atish

