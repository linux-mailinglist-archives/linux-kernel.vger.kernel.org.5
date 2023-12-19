Return-Path: <linux-kernel+bounces-4825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90691818288
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A881F1C23528
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6BFC8C3;
	Tue, 19 Dec 2023 07:46:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED73A12B7D;
	Tue, 19 Dec 2023 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
	by Atcsqr.andestech.com with ESMTP id 3BJ7hYaZ012432;
	Tue, 19 Dec 2023 15:43:34 +0800 (+08)
	(envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Tue, 19 Dec 2023 15:43:32 +0800
Date: Tue, 19 Dec 2023 15:43:29 +0800
From: Yu-Chien Peter Lin <peterlin@andestech.com>
To: Anup Patel <apatel@ventanamicro.com>
CC: <acme@kernel.org>, <adrian.hunter@intel.com>, <ajones@ventanamicro.com>,
        <alexander.shishkin@linux.intel.com>, <andre.przywara@arm.com>,
        <anup@brainfault.org>, <aou@eecs.berkeley.edu>,
        <atishp@atishpatra.org>, <conor+dt@kernel.org>,
        <conor.dooley@microchip.com>, <conor@kernel.org>,
        <devicetree@vger.kernel.org>, <dminus@andestech.com>,
        <evan@rivosinc.com>, <geert+renesas@glider.be>, <guoren@kernel.org>,
        <heiko@sntech.de>, <irogers@google.com>, <jernej.skrabec@gmail.com>,
        <jolsa@kernel.org>, <jszhang@kernel.org>,
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
        <will@kernel.org>, <ycliang@andestech.com>, <inochiama@outlook.com>
Subject: Re: [PATCH v5 02/16] irqchip/riscv-intc: Allow large non-standard
 interrupt number
Message-ID: <ZYFJjR1rD5Hn-HEH@APC323>
References: <20231213070301.1684751-1-peterlin@andestech.com>
 <20231213070301.1684751-3-peterlin@andestech.com>
 <CAK9=C2WuuYQD8ydrHP16hUXVk6RuKLbfvUe_GpUGw9ppe3Rd8Q@mail.gmail.com>
 <CAK9=C2U+rSP8YMahPmTHLYZ+ZBfwwY5y52JeU_=R+VL1frR1Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK9=C2U+rSP8YMahPmTHLYZ+ZBfwwY5y52JeU_=R+VL1frR1Uw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 3BJ7hYaZ012432

Hi Anup,

On Wed, Dec 13, 2023 at 08:49:23PM +0530, Anup Patel wrote:
> On Wed, Dec 13, 2023 at 7:58 PM Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > On Wed, Dec 13, 2023 at 12:34 PM Yu Chien Peter Lin
> > <peterlin@andestech.com> wrote:
> > >
> > > Currently, the implementation of the RISC-V INTC driver uses the
> > > interrupt cause as hardware interrupt number and has a limitation of
> > > supporting a maximum of 64 interrupts. However, according to the
> > > privileged spec, interrupt causes >= 16 are defined for platform use.
> >
> > I disagree with this patch.
> >
> > Even though RISC-V priv sepc allows interrupt causes >= 16, we
> > still need CSRs to manage arbitrary local interrupts
> >
> > Currently, we have following standard CSRs:
> > 1) [m|s]ie and [m|s]ip which are XLEN wide
> > 2) With AIA, we have [m|s]ieh and [m|s]iph for RV32
> >
> > Clearly, we can only have a XLEN number of standard local
> > interrupts without AIA and 64 local interrupts with AIA.
> >
> > Now for implementations with custom CSRs (such as Andes),
> > we still can't assume infinite local interrupts because HW will
> > have a finite number of custom CSRs.
> >
> > >
> > > This limitation prevents to fully utilize the available local interrupt
> > > sources. Additionally, the interrupt number used on RISC-V are sparse,
> > > with only interrupt numbers 1, 5 and 9 (plus Sscofpmf or T-Head's PMU
> > > interrupt) being currently used for supervisor mode.
> > >
> > > Switch to using irq_domain_create_tree() to create the radix tree
> > > map, so a larger number of hardware interrupts can be handled.
> > >
> > > Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> > > Reviewed-by: Charles Ci-Jyun Wu <dminus@andestech.com>
> > > Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> > > ---
> > > Changes v1 -> v2:
> > >   - Fixed irq mapping failure checking (suggested by Clément and Anup)
> > > Changes v2 -> v3:
> > >   - No change
> > > Changes v3 -> v4: (Suggested by Thomas [1])
> > >   - Use pr_warn_ratelimited instead
> > >   - Fix coding style and commit message
> > > Changes v4 -> v5: (Suggested by Thomas)
> > >   - Fix commit message
> > >
> > > [1] https://patchwork.kernel.org/project/linux-riscv/patch/20231023004100.2663486-3-peterlin@andestech.com/#25573085
> > > ---
> > >  drivers/irqchip/irq-riscv-intc.c | 12 ++++--------
> > >  1 file changed, 4 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
> > > index e8d01b14ccdd..2fdd40f2a791 100644
> > > --- a/drivers/irqchip/irq-riscv-intc.c
> > > +++ b/drivers/irqchip/irq-riscv-intc.c
> > > @@ -24,10 +24,9 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
> > >  {
> > >         unsigned long cause = regs->cause & ~CAUSE_IRQ_FLAG;
> > >
> > > -       if (unlikely(cause >= BITS_PER_LONG))
> > > -               panic("unexpected interrupt cause");
> > > -
> > > -       generic_handle_domain_irq(intc_domain, cause);
> > > +       if (generic_handle_domain_irq(intc_domain, cause))
> > > +               pr_warn_ratelimited("Failed to handle interrupt (cause: %ld)\n",
> > > +                                   cause);
> > >  }
> > >
> > >  /*
> > > @@ -117,8 +116,7 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn)
> > >  {
> > >         int rc;
> > >
> > > -       intc_domain = irq_domain_create_linear(fn, BITS_PER_LONG,
> > > -                                              &riscv_intc_domain_ops, NULL);
> > > +       intc_domain = irq_domain_create_tree(fn, &riscv_intc_domain_ops, NULL);
> >
> > I disagree with this change based on the reasoning above.
> >
> > Instead of this, we should determine the number of local interrupts
> > based on the type of RISC-V intc:
> > 1) For standard INTC without AIA, we have XLEN (or BITS_PER_LONG)
> >     local interrupts
> > 2) For standart INTC with AIA, we have 64 local interrupts
> > 3) For custom INTC (such as Andes), the number of local interrupt
> >     should be custom (Andes specific) which can be determined based
> >     on compatible string.
> >
> > Also, creating a linear domain with a fixed number of local interrupts
> > ensures that drivers can't map a local interrupt beyond the availability
> > of CSRs to manage it.
> 
> Thinking about this more. We do have a problem because Andes local
> interrupts are really sparse which is not the case for standard local
> interrupts
> 
> I have an alternate suggestion which goes as follows ...
> 
> We use irq_domain_create_tree() in-place of irq_domain_create_linear()
> and enforce checks on hwirq in riscv_intc_domain_alloc() to ensure that
> we only allow hwirq for which we have corresponding standard or custom
> CSR.
> 
> To achieve this, riscv_intc_init_common() will have to save the following
> as static global variables:
> 1) riscv_intc_nr_irqs: Number of standard local interrupts
> 2) riscv_intc_custom_base and riscv_intc_custom_nr_irqs: Base and
>     number of custom local interrupts.
> 
> Using the above static global variables, the riscv_intc_domain_alloc()
> can return error if one of the following conditions are met:
> 1) riscv_intc_nr_irqs<= hwirq && hwirq < riscv_intc_custom_base
> 2) (riscv_intc_custom_base + riscv_intc_custom_nr_irqs) <= hwirq
> 
> For standard INTC, we can set the static global variable as follows:
> riscv_intc_nr_irqs = XLEN or BITS_PER_LONG
> riscv_intc_custom_base = riscv_intc_nr_irqs
> riscv_intc_custom_nr_irqs = 0
> 
> For Andes INTC, we can set the static global variables as follows:
> riscv_intc_nr_irqs = XLEN or BITS_PER_LONG
> riscv_intc_custom_base = 256
> riscv_intc_custom_nr_irqs = XLEN or BITS_PER_LONG
> 
> Regards,
> Anup

Thank you for offering your help on this.
I will rework the patch accordingly.

Best regards,
Peter Lin

> >
> > >         if (!intc_domain) {
> > >                 pr_err("unable to add IRQ domain\n");
> > >                 return -ENXIO;
> > > @@ -132,8 +130,6 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn)
> > >
> > >         riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
> > >
> > > -       pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
> > > -
> >
> > Same as above, we should definitely advertise the type of INTC and
> > number of local interrupts mapped.
> >
> > Regards,
> > Anup
> >
> > >         return 0;
> > >  }
> > >
> > > --
> > > 2.34.1
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv

