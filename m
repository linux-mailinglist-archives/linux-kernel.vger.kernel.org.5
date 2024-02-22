Return-Path: <linux-kernel+bounces-75858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5E885EFEC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63C82850EF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF511775E;
	Thu, 22 Feb 2024 03:32:10 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C52A17578;
	Thu, 22 Feb 2024 03:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708572730; cv=none; b=dCtxiqdggmHKS2LTygLPTkWzgujsN2/QboyKkaMNigBwIQLTMCN4jHDnIVUrUl7+RBLXSaMV+K72wumEhp1ZSt0xT8NBs97OjSZQhEgn1XE6Ti+MRiR1gtsKXT9qNeD55bfi1FxmhoiCtVjrynvqaGXl/O0odUkfaGIJsGndvJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708572730; c=relaxed/simple;
	bh=E7Z8pSK89+sDDxGUmJjzBockun9fP/w10U/EGjDCcDY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmk9l2vGwoM5PWCUuYt/5Jw1sfDXxeQ1N7XXTiXn/NweDN8gdQzkL11d0OlTl62/heRRshDLaqvkE890dG7KCO7Dlub4SVCWWbYj3JzD8o/paczolIESdiXxfwEt7VTzTpyfJGep3TkHluuQ76AUeRzpbUEQiXIZggG+WyMZXhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
	by Atcsqr.andestech.com with ESMTP id 41M3PcR8080879;
	Thu, 22 Feb 2024 11:25:38 +0800 (+08)
	(envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Thu, 22 Feb 2024 11:25:35 +0800
Date: Thu, 22 Feb 2024 11:25:35 +0800
From: Yu-Chien Peter Lin <peterlin@andestech.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: <acme@kernel.org>, <adrian.hunter@intel.com>, <ajones@ventanamicro.com>,
        <alexander.shishkin@linux.intel.com>, <andre.przywara@arm.com>,
        <anup@brainfault.org>, <aou@eecs.berkeley.edu>,
        <atishp@atishpatra.org>, <conor+dt@kernel.org>,
        <conor.dooley@microchip.com>, <conor@kernel.org>,
        <devicetree@vger.kernel.org>, <evan@rivosinc.com>,
        <geert+renesas@glider.be>, <guoren@kernel.org>, <heiko@sntech.de>,
        <irogers@google.com>, <jernej.skrabec@gmail.com>, <jolsa@kernel.org>,
        <jszhang@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <locus84@andestech.com>,
        <magnus.damm@gmail.com>, <mark.rutland@arm.com>, <mingo@redhat.com>,
        <n.shubin@yadro.com>, <namhyung@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <peterz@infradead.org>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <sunilvl@ventanamicro.com>, <tim609@andestech.com>, <uwu@icenowy.me>,
        <wens@csie.org>, <will@kernel.org>, <inochiama@outlook.com>,
        <unicorn_wang@outlook.com>, <wefu@redhat.com>,
        Randolph <randolph@andestech.com>, Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v8 02/10] irqchip/riscv-intc: Allow large non-standard
 interrupt number
Message-ID: <Zda-r16ysaKzPdLV@APC323>
References: <20240129092553.2058043-1-peterlin@andestech.com>
 <20240129092553.2058043-3-peterlin@andestech.com>
 <877cj8issa.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <877cj8issa.ffs@tglx>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 41M3PcR8080879

Hi Thomas,

On Tue, Feb 13, 2024 at 11:04:53AM +0100, Thomas Gleixner wrote:
> On Mon, Jan 29 2024 at 17:25, Yu Chien Peter Lin wrote:
> >  static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
> >  {
> >  	unsigned long cause = regs->cause & ~CAUSE_IRQ_FLAG;
> >  
> > -	if (unlikely(cause >= BITS_PER_LONG))
> > -		panic("unexpected interrupt cause");
> > -
> > -	generic_handle_domain_irq(intc_domain, cause);
> > +	if (generic_handle_domain_irq(intc_domain, cause))
> > +		pr_warn_ratelimited("Failed to handle interrupt (cause: %ld)\n",
> > +				    cause);
> 
> Either let the cause stick out or you need brackets. See:
> 
>   https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#bracket-rules
> 
> >  }
> >  
> >  /*
> > @@ -93,6 +95,14 @@ static int riscv_intc_domain_alloc(struct irq_domain *domain,
> >  	if (ret)
> >  		return ret;
> >  
> > +	/*
> > +	 * Only allow hwirq for which we have corresponding standard or
> > +	 * custom interrupt enable register.
> > +	 */
> > +	if ((riscv_intc_nr_irqs <= hwirq && hwirq < riscv_intc_custom_base) ||
> > +	    (riscv_intc_custom_base + riscv_intc_custom_nr_irqs) <= hwirq)
> > +		return -EINVAL;
> 
> Duh. This mix of ordering required to read this 3 times. What's wrong
> with writing this consistently:
> 
> 	if ((hwirq >= riscv_intc_nr_irqs && hwirq < riscv_intc_custom_base) ||
> 	    (hwirq >= iscv_intc_custom_base + riscv_intc_custom_nr_irqs)
> 		return -EINVAL;
> 
> Hmm?
> 
> > -	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
> > +	pr_info("%d local interrupts mapped\n", riscv_intc_nr_irqs);
> > +	if (riscv_intc_custom_nr_irqs)
> > +		pr_info("%d custom local interrupts mapped\n",
> > +			riscv_intc_custom_nr_irqs);
> 
> See bracket rules.
>   
> >  	return 0;
> >  }
> > @@ -166,6 +178,10 @@ static int __init riscv_intc_init(struct device_node *node,
> >  		return 0;
> >  	}
> >  
> > +	riscv_intc_nr_irqs = BITS_PER_LONG;
> > +	riscv_intc_custom_base = riscv_intc_nr_irqs;
> 
> Why don't you initialize the static variables with constants right away?
> 
> > +	riscv_intc_custom_nr_irqs = 0;
> 
> It's already 0, no?
> 
> >  	return riscv_intc_init_common(of_node_to_fwnode(node));
> >  }
> 
> Thanks,
> 
>         tglx

Thanks for pointing these out, I'll fix them in PATCH v9.

Regards,
Peter Lin

