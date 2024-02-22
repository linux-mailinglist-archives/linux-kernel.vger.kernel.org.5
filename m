Return-Path: <linux-kernel+bounces-75874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A086085F022
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5E61F2151A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C461774E;
	Thu, 22 Feb 2024 03:49:13 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24BD101EC;
	Thu, 22 Feb 2024 03:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708573752; cv=none; b=eepB2x/HIv2oZqQ8InLRcoXLQFde8ZTCrBIOWvhBdS7r4DMq5Xs//3I9w+lELQqcTGZVP+JhNSEtCbfOxBLJwee1x/ujdJxLqNCTL5AHhOjSSuaSTTAiwjw0xbjUD3i4idPeM8oGqbZlmIQAZx+7iBfaB2A5rraY8JJ7mBJ49v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708573752; c=relaxed/simple;
	bh=dwf0vhpo2jYUb2gwbg7vwjdYNHNEw2bP9BitRqQMy60=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HL72BgZ846KYTPuEnQN2MqO1sh4PdmbXbHoUhTMQhCb1qd/UrkaL74ercZc//Si5OxBiVbLyRwsiLE5Z2sax6XmaGRsp9MQ7t/XYgzxb3i/A8H1sz7RTzSmNjFCwB3wn2PYkxTIYywvcv5viaiAAuy0/RnSHDI449gm+4HeYJv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 41M3PZkX080876;
	Thu, 22 Feb 2024 11:25:35 +0800 (+08)
	(envelope-from peterlin@andestech.com)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
	by Atcsqr.andestech.com with ESMTP id 41M3N6Y8080329;
	Thu, 22 Feb 2024 11:23:06 +0800 (+08)
	(envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Thu, 22 Feb 2024 11:23:03 +0800
Date: Thu, 22 Feb 2024 11:23:00 +0800
From: Yu-Chien Peter Lin <peterlin@andestech.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
CC: <acme@kernel.org>, <adrian.hunter@intel.com>, <ajones@ventanamicro.com>,
        <alexander.shishkin@linux.intel.com>, <andre.przywara@arm.com>,
        <anup@brainfault.org>, <aou@eecs.berkeley.edu>,
        <atishp@atishpatra.org>, <conor+dt@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Conor
 Dooley" <conor@kernel.org>, <devicetree@vger.kernel.org>,
        Evan Green
	<evan@rivosinc.com>, <geert+renesas@glider.be>,
        <guoren@kernel.org>, "Heiko
 Stuebner" <heiko@sntech.de>,
        <irogers@google.com>, <jernej.skrabec@gmail.com>, <jolsa@kernel.org>,
        <jszhang@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <locus84@andestech.com>,
        <magnus.damm@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
        <mingo@redhat.com>, <n.shubin@yadro.com>, <namhyung@kernel.org>,
        "Paul
 Walmsley" <paul.walmsley@sifive.com>, <peterz@infradead.org>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        Sunil V L
	<sunilvl@ventanamicro.com>, <tglx@linutronix.de>,
        <tim609@andestech.com>, <uwu@icenowy.me>, <wens@csie.org>,
        Will Deacon <will@kernel.org>, <inochiama@outlook.com>,
        <unicorn_wang@outlook.com>, <wefu@redhat.com>
Subject: Re: [PATCH v8 00/10] Support Andes PMU extension
Message-ID: <Zda-FE2FpyhbIJKd@APC323>
References: <20240129092553.2058043-1-peterlin@andestech.com>
 <mhng-b85cfae6-43ef-42ac-94b4-d0f4ce2d0940@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <mhng-b85cfae6-43ef-42ac-94b4-d0f4ce2d0940@palmer-ri-x1c9a>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 41M3PZkX080876

Hi Palmer,

On Wed, Feb 21, 2024 at 12:58:31PM -0800, Palmer Dabbelt wrote:
> On Mon, 29 Jan 2024 01:25:43 PST (-0800), peterlin@andestech.com wrote:
> > Hi All,
> > 
> > This patch series introduces the Andes PMU extension, which serves the
> > same purpose as Sscofpmf and Smcntrpmf. Its non-standard local interrupt
> > is assigned to bit 18 in the custom S-mode local interrupt enable and
> > pending registers (slie/slip), while the interrupt cause is (256 + 18).
> > 
> > Linux patches based on:
> > - ed5b7cf ("riscv: errata: andes: Probe for IOCP only once in boot stage")
> > It can be found on Andes Technology GitHub:
> > - https://github.com/andestech/linux/commits/andes-pmu-support-v8
> > 
> > The PMU device tree node used on AX45MP:
> > - https://github.com/riscv-software-src/opensbi/blob/master/docs/pmu_support.md#example-3
> > 
> > Locus Wei-Han Chen (1):
> >   riscv: andes: Support specifying symbolic firmware and hardware raw
> >     events
> > 
> > Yu Chien Peter Lin (9):
> >   riscv: errata: Rename defines for Andes
> >   irqchip/riscv-intc: Allow large non-standard interrupt number
> >   irqchip/riscv-intc: Introduce Andes hart-level interrupt controller
> >   dt-bindings: riscv: Add Andes interrupt controller compatible string
> >   riscv: dts: renesas: r9a07g043f: Update compatible string to use Andes
> >     INTC
> >   perf: RISC-V: Eliminate redundant interrupt enable/disable operations
> >   perf: RISC-V: Introduce Andes PMU to support perf event sampling
> >   dt-bindings: riscv: Add Andes PMU extension description
> >   riscv: dts: renesas: Add Andes PMU extension for r9a07g043f
> > 
> >  .../devicetree/bindings/riscv/cpus.yaml       |   6 +-
> >  .../devicetree/bindings/riscv/extensions.yaml |   7 +
> >  arch/riscv/boot/dts/renesas/r9a07g043f.dtsi   |   4 +-
> >  arch/riscv/errata/andes/errata.c              |  10 +-
> >  arch/riscv/include/asm/errata_list.h          |  13 +-
> >  arch/riscv/include/asm/hwcap.h                |   1 +
> >  arch/riscv/include/asm/vendorid_list.h        |   2 +-
> >  arch/riscv/kernel/alternative.c               |   2 +-
> >  arch/riscv/kernel/cpufeature.c                |   1 +
> >  drivers/irqchip/irq-riscv-intc.c              |  88 ++++++++++--
> >  drivers/perf/Kconfig                          |  14 ++
> >  drivers/perf/riscv_pmu_sbi.c                  |  37 ++++-
> >  include/linux/soc/andes/irq.h                 |  18 +++
> >  .../arch/riscv/andes/ax45/firmware.json       |  68 ++++++++++
> >  .../arch/riscv/andes/ax45/instructions.json   | 127 ++++++++++++++++++
> >  .../arch/riscv/andes/ax45/memory.json         |  57 ++++++++
> >  .../arch/riscv/andes/ax45/microarch.json      |  77 +++++++++++
> >  tools/perf/pmu-events/arch/riscv/mapfile.csv  |   1 +
> >  18 files changed, 494 insertions(+), 39 deletions(-)
> >  create mode 100644 include/linux/soc/andes/irq.h
> >  create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
> >  create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/instructions.json
> >  create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/memory.json
> >  create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/microarch.json
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> in case someone wants to take this via another tree.  I'm also OK taking it
> via the RISC-V tree, pending a resolution to Thomas' comments on patch 2.
> For now I'm going to assume there's a v9 coming.

Yes, I'm working on v9, please hold off taking the series, thanks.

Regards,
Peter Lin

> Thanks!

