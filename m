Return-Path: <linux-kernel+bounces-165103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C50548B881E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020FB1C2289E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6009C524D4;
	Wed,  1 May 2024 09:31:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396933FB09;
	Wed,  1 May 2024 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714555866; cv=none; b=kTFwaW5MmNDzafUSjonYbpSHl32gSiInhdH0wJnh0v8HSk3g+EON7lHavHolFQ5K3WBfe2siX/W4mE+YB4BG9sWBWOlJIv9NrwJ+ybL1AW+keizwUPT3YGbv+bN29ICNaKMCIbyh2aZvipy7cQH7Mt6w41LIAMLa2SUK69DIuvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714555866; c=relaxed/simple;
	bh=/WvfKNTqeV3Kh/V7Imy68oPA+fzwWDSPALr2nzaFSR4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDymHvjPSRjtyLOu5v8CWL2hoWRYS5Z8qvdNDajk1FRZdnacybL0NIcXmH3G2RdjGU5vAyO5bTkPUVGKMyor2w7i9FJw9jOoMNDNkxMOQOwJkMalOoq/ckSY5GJgtVVXmrjQkhIP8aO/Nb/v17Vmp6ssLljTJyWKKwhJ+8MepAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D9AA2F4;
	Wed,  1 May 2024 02:31:30 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E87563F793;
	Wed,  1 May 2024 02:31:02 -0700 (PDT)
Date: Wed, 1 May 2024 10:30:59 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-sunxi@lists.linux.dev, wens@csie.org, jernej.skrabec@gmail.com,
 samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: Add cache information to the SoC
 dtsi for H6
Message-ID: <20240501103059.10a8f7de@donnerap.manchester.arm.com>
In-Reply-To: <f4f4163d908c95d2a3f6f48bc3d7de49@manjaro.org>
References: <6a772756c2c677dbdaaab4a2c71a358d8e4b27e9.1714304058.git.dsimic@manjaro.org>
	<49abb93000078c692c48c0a65ff677893909361a.1714304071.git.dsimic@manjaro.org>
	<20240430001002.4797e4e3@minigeek.lan>
	<6fdeb49d57ccccca62e4f43dbe9475e3@manjaro.org>
	<20240430114627.0cfcd14a@donnerap.manchester.arm.com>
	<f4f4163d908c95d2a3f6f48bc3d7de49@manjaro.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 13:10:41 +0200
Dragan Simic <dsimic@manjaro.org> wrote:

> Hello Andre,
> 
> On 2024-04-30 12:46, Andre Przywara wrote:
> > On Tue, 30 Apr 2024 02:01:42 +0200
> > Dragan Simic <dsimic@manjaro.org> wrote:  
> >> On 2024-04-30 01:10, Andre Przywara wrote:  
> >> > On Sun, 28 Apr 2024 13:40:36 +0200
> >> > Dragan Simic <dsimic@manjaro.org> wrote:
> >> >  
> >> >> Add missing cache information to the Allwinner H6 SoC dtsi, to allow
> >> >> the userspace, which includes lscpu(1) that uses the virtual files
> >> >> provided
> >> >> by the kernel under the /sys/devices/system/cpu directory, to display
> >> >> the
> >> >> proper H6 cache information.
> >> >>
> >> >> Adding the cache information to the H6 SoC dtsi also makes the
> >> >> following
> >> >> warning message in the kernel log go away:
> >> >>
> >> >>   cacheinfo: Unable to detect cache hierarchy for CPU 0
> >> >>
> >> >> The cache parameters for the H6 dtsi were obtained and partially
> >> >> derived
> >> >> by hand from the cache size and layout specifications found in the
> >> >> following
> >> >> datasheets and technical reference manuals:
> >> >>
> >> >>   - Allwinner H6 V200 datasheet, version 1.1
> >> >>   - ARM Cortex-A53 revision r0p3 TRM, version E
> >> >>
> >> >> For future reference, here's a brief summary of the documentation:
> >> >>
> >> >>   - All caches employ the 64-byte cache line length
> >> >>   - Each Cortex-A53 core has 32 KB of L1 2-way, set-associative
> >> >> instruction
> >> >>     cache and 32 KB of L1 4-way, set-associative data cache
> >> >>   - The entire SoC has 512 KB of unified L2 16-way, set-associative
> >> >> cache
> >> >>
> >> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>  
> >> >
> >> > I can confirm that the data below matches the manuals, but also the
> >> > decoding of the architectural cache type registers (CCSIDR_EL1):
> >> >   L1D: 32 KB: 128 sets, 4 way associative, 64 bytes/line
> >> >   L1I: 32 KB: 256 sets, 2 way associative, 64 bytes/line
> >> >   L2: 512 KB: 512 sets, 16 way associative, 64 bytes/line  
> >> 
> >> Thank you very much for reviewing my patch in such a detailed way!
> >> It's good to know that the values in the Allwinner datasheets match
> >> with the observed reality, so to speak. :)  
> > 
> > YW, and yes, I like to double check things when it comes to Allwinner
> > documentation ;-) And it was comparably easy for this problem.  
> 
> Double checking is always good, IMHO. :)
> 
> > Out of curiosity: what triggered that patch? Trying to get rid of false
> > warning/error messages?  
> 
> Yes, one of the motivators was to get rid of the false kernel warning,
> and the other was to have the cache information nicely available through
> lscpu(1).  I already did the same for a few Rockchip SoCs, [1][2][3] so
> a couple of Allwinner SoCs were the next on my mental TODO list. :)

Thanks for doing this!

> > And do you plan to address the H616 as well? It's a bit more tricky 
> > there,
> > since there are two die revisions out: one with 256(?)KB of L2, one 
> > with
> > 1MB(!). We know how to tell them apart, so I could provide some TF-A 
> > code
> > to patch that up in the DT. The kernel DT copy could go with 256KB 
> > then.  
> 
> I have no boards based on the Allwinner H616, so it wasn't on my radar.
> Though, I'd be happy to prepare and submit a similar kernel patch for
> the H616, if you'd then take it further and submit a TF-A patch that
> fixes the DT according to the detected die revision?  Did I understand
> the plan right?

Yes, that was the idea. I have a working version of that TF-A patch now,
just need to figure out some details about the best way to only build this
for the H616 port.

Neither the data sheet nor the user manual mention the cache sizes for the
H616, but I checked the CSSIDR_EL1 register readouts on both an old H616
and a new H618, and they confirm that the former has 256 KB L2, and the
latter 1MB. Also I ran tinymembench on two boards to confirm this,
community benchmarks results are available here:
https://github.com/ThomasKaiser/sbc-bench/blob/master/Results.md
The OrangePi Zero2 and OrangePi Zero3 are good examples, respectively.
Associativity and cache line size are dictated by the Arm Cortex cores,
and the L1I & L1D sizes are the same as in the other SoCs.

Cheers,
Andre

> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=67a6a98575974416834c2294853b3814376a7ce7
> [2] 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=8612169a05c5e979af033868b7a9b177e0f9fcdf
> [3] 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=b72633ba5cfa932405832de25d0f0a11716903b4


