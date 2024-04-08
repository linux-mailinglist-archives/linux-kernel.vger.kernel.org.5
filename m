Return-Path: <linux-kernel+bounces-135559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC98489C78A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2F81C218C0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1DD13F428;
	Mon,  8 Apr 2024 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txqodJ7u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1486B126F07;
	Mon,  8 Apr 2024 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588070; cv=none; b=szKeFTkrpqTZCHJyEjE6C4xqE9MIJsyUiq88i3YqGEoJanMSR/tl/fig0bFWuJcFdG/LLEY6dHJHHOkGggm3Y7l9nZMIDEacEVJNRpWzmogOcDNs7ZRI5Y6/sHRWoEuZK0W2Ax7QFvJ2g94/n8QrXi5MWrhw5SSTHnPSgFfQkLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588070; c=relaxed/simple;
	bh=6nyvPHBNhtt42tmLE/4Kw6HI0hcocSOnFt5NeHT3nEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=li2uRk009/4mQq4DsrmDs7iJ0Po7+BITwsQLLlv4Cy5zKUFTxqCad3+7d2q4cdF9xZYw81Kx4exDymrhwwPiiP9hvW3astWQuhC1Drvn/JJjj8qNWBqUDZp/HT9t1dRxJ3IzUvBwoNiFzlPA1v/YvXBdtTAUSXFgrqatwNsWEtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txqodJ7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42448C43390;
	Mon,  8 Apr 2024 14:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712588069;
	bh=6nyvPHBNhtt42tmLE/4Kw6HI0hcocSOnFt5NeHT3nEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=txqodJ7uy/GQaOX8PSTuc64L79RjRCEeCpLVCqNUXEgUhda0jt8vB/kwSiCz62dn7
	 RIHGvtz08C3PpxT+3F4L639wcylZR8NUXtcS7JeKoFD4LJown+VUItdvdjsW773Xcq
	 Cx5sG81gz+x4s8oHBFczmAM8S3o7YTbm5SfHbP60TLos/P6WvZbOHhpuGbjVF2VNyw
	 /yVX9GAbMnZN3Il23+0TIPH+2dXogL4MuWlWDbBoy4n+oppmO5QX5RyIFoNDgNQfuh
	 Ebf53Bavz1pRUyvJDz8xYBMnpDFl7109se1gckgdoS/zz8EUSVh8LoO2p1ovvzJoVV
	 UlQtAg49UzPFQ==
Date: Mon, 8 Apr 2024 16:54:24 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Fang Xiang <fangxiang3@xiaomi.com>, Marc Zyngier <maz@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Subject: Re: [PATCH v5 0/1] irqchip/gic-v3: Enable non-coherent GIC designs
 probing
Message-ID: <ZhQFICltEOcBHszS@lpieralisi>
References: <20240123110332.112797-1-lpieralisi@kernel.org>
 <ZeiBFBDhwlJnCUZ2@lpieralisi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeiBFBDhwlJnCUZ2@lpieralisi>

On Wed, Mar 06, 2024 at 03:43:32PM +0100, Lorenzo Pieralisi wrote:
> On Tue, Jan 23, 2024 at 12:03:31PM +0100, Lorenzo Pieralisi wrote:
> > This series is v5 of previous series:
> > 
> > v4: https://lore.kernel.org/all/20231227110038.55453-1-lpieralisi@kernel.org
> > v3: https://lore.kernel.org/all/20231006125929.48591-1-lpieralisi@kernel.org
> > v2: https://lore.kernel.org/all/20230906094139.16032-1-lpieralisi@kernel.org
> > v1: https://lore.kernel.org/all/20230905104721.52199-1-lpieralisi@kernel.org
> > 
> > v4 -> v5
> > 	- ACPICA patches merged for v6.8
> > 	- Refactored ACPI parsing code according to review
> > 	- Rebased against v6.8-rc1
> 
> Hi Marc, all,
> 
> this is not an urgent fix (I don't think there is any ACPI platform
> affected in the field so it is not even a fix), I am just asking please
> what should I do with it, I appreciate it is late in the cycle (and I
> know some fixes got merged in -rcX leading up to -rc7 that are
> pre-requisite for this patch to work).

Hi,

just a reminder to ask how to proceed with this patch, I know it
is not urgent, just to understand how to handle it please.

The related ACPICA changes are already merged in the mainline.

Thanks,
Lorenzo

> Thanks,
> Lorenzo
> 
> > v3 -> v4:
> > 	- Dropped patches [1-3], already merged
> > 	- Added Linuxized ACPICA changes accepted upstream
> > 	- Rebased against v6.7-rc3
> > 
> > v2 -> v3:
> > 	- Added ACPICA temporary changes and ACPI changes to implement
> > 	  ECR https://bugzilla.tianocore.org/show_bug.cgi?id=4557
> > 	- ACPI changes are for testing purposes - subject to ECR code
> > 	  first approval
> > 
> > v1 -> v2:
> > 	- Updated DT bindings as per feedback
> > 	- Updated patch[2] to use GIC quirks infrastructure
> > 
> > Original cover letter
> > ---
> > The GICv3 architecture specifications provide a means for the
> > system programmer to set the shareability and cacheability
> > attributes the GIC components (redistributors and ITSes) use
> > to drive memory transactions.
> > 
> > Albeit the architecture give control over shareability/cacheability
> > memory transactions attributes (and barriers), it is allowed to
> > connect the GIC interconnect ports to non-coherent memory ports
> > on the interconnect, basically tying off shareability/cacheability
> > "wires" and de-facto making the redistributors and ITSes non-coherent
> > memory observers.
> > 
> > This series aims at starting a discussion over a possible solution
> > to this problem, by adding to the GIC device tree bindings the
> > standard dma-noncoherent property. The GIC driver uses the property
> > to force the redistributors and ITSes shareability attributes to
> > non-shareable, which consequently forces the driver to use CMOs
> > on GIC memory tables.
> > 
> > On ARM DT DMA is default non-coherent, so the GIC driver can't rely
> > on the generic DT dma-coherent/non-coherent property management layer
> > (of_dma_is_coherent()) which would default all GIC designs in the field
> > as non-coherent; it has to rely on ad-hoc dma-noncoherent property handling.
> > 
> > When a consistent approach is agreed upon for DT an equivalent binding will
> > be put forward for ACPI based systems.
> > 
> > Lorenzo Pieralisi (1):
> >   irqchip/gic-v3: Enable non-coherent redistributors/ITSes ACPI probing
> > 
> >  drivers/acpi/processor_core.c    | 15 +++++++++++++++
> >  drivers/irqchip/irq-gic-v3-its.c |  4 ++++
> >  drivers/irqchip/irq-gic-v3.c     |  9 +++++++++
> >  include/linux/acpi.h             |  3 +++
> >  4 files changed, 31 insertions(+)
> > 
> > -- 
> > 2.34.1
> > 

