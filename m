Return-Path: <linux-kernel+bounces-93899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F7B873684
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E1C289851
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD9A130AC6;
	Wed,  6 Mar 2024 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HItIfRhZ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58B812FF67
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 12:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728373; cv=none; b=Z+j2O3BmEYSatHoFFOTqYSh8u+vod0rTJaKCnVX/OfK0QpAdojMKG3Pu1iUKApS+1PHCvl6t0BFuPiQx4cJ4To6LW0UIb51sPXWA2uuq1u/0yDNEJi5NzZ/VOImcLNYnhxRLIYkM16eK1WDy8hq1Zymf9lAnpdcF88dludzBSWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728373; c=relaxed/simple;
	bh=0Tc0hQYDtt48jZhh0NYn8h+kJpBxzpBz3yqZS60Ykn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qwo7UO8QCQKT+Yr742kRPic77tIYilQvV+Mr7JT1nr8Ra+j5YJBR8KIz3RT9Zy3eHkR2JfkW/XIIV5ZoKS5KH7cG7UdM9PfWQXJt/rjDrRm/MXMk7SBlP0t8OAftN6MFoh+qkh4HyuDrtTXuWC3y5QkReBvfAOIbsq698LamQRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HItIfRhZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 369DB40E01A8;
	Wed,  6 Mar 2024 12:32:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Vl3CpBHFptTT; Wed,  6 Mar 2024 12:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709728365; bh=PAp1bf6qrMiX4CQWZNcoZnKRC6rV4wKaDkhIHyk1xsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HItIfRhZ6cmgWXlbyxVTiOHumC88/3sDgSLBtHKgyUFgjAE84Rsu2wYWymQQ5Scsx
	 gxiRW4FytlI4qiEp0RIsxvHRV5R8HMU9vOnvRY7xCDpDu+edKrKtdmwCzI9kOWq7jZ
	 E1aQ2zCtrRe4Dg8g4+V+JatJ4bLyXJgVJNEPPg9aphRdOF6g9JbQV1w0GAE4OKsCij
	 ws0CpIZTPqOluyt3L7PYKsajN53koEtEOdJ3bEq7m85jAm08fm048WIl1JFVHOJUsg
	 pXvf9tGqCpNcsM86Sal7uM3g3Em2Oc5UWbZMQNKnPzegiUq5MZTR1Tmvsn1rx18qDS
	 ykI8B1zfQsPV7TaLgp69P0sfOt/dJroPDLyzaqmamUq9/kRP7bA3cfxB3TAt7MxIQL
	 ohN3kmjdMmNfNGOd8ctUkqqoEWMajnb8z4Mwcau+k/ucMmQ8Yoi5q/SdbeYPMMxkab
	 fYE5ukc3eIn8mhGxJfCVNTz09jbjsArowojq6NDF3TmL9OqA08fVoRCD+M5kgbhQn7
	 Sn/Fihhz35zHcvAI7uRzO6boVPcRjx9R7nRguXenPw+RiOMJ3nLW3GLnvlGr3VuhCm
	 m71Ys7HxdXJw1lRX6ji+Km6XzZxzPCG4qUCLKBjh28SmiNalJ0bvlqqcSpyAVmO6Xn
	 lpfzutfmuXg5buYpiHkJdpNQ=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 65CD340E0185;
	Wed,  6 Mar 2024 12:32:37 +0000 (UTC)
Date: Wed, 6 Mar 2024 13:32:30 +0100
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, x86-ml <x86@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Antonov <alexander.antonov@linux.intel.com>,
	lkml <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: unchecked MSR access error: WRMSR to 0xd84 (tried to write
 0x0000000000010003) at rIP: 0xffffffffa025a1b8
 (snbep_uncore_msr_init_box+0x38/0x60 [intel_uncore])
Message-ID: <20240306123230.GCZehiXhHIZwi2zU1_@fat_crate.local>
References: <20240304201233.GDZeYrMc9exmV21PFB@fat_crate.local>
 <87sf15ugsz.ffs@tglx>
 <20240305121014.GCZecLppQTzWmpI_yR@fat_crate.local>
 <87a5nbvccx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a5nbvccx.ffs@tglx>

On Wed, Mar 06, 2024 at 12:17:02PM +0100, Thomas Gleixner wrote:
> On Tue, Mar 05 2024 at 13:10, Borislav Petkov wrote:
> > I guess ship it but we'll pay attention to what else ends up
> > complaining.
> 
> Here is an updated version which handles it in the topology core code so
> that MPPARSE is covered as well.
> 
> Thanks,
> 
>         tglx
> ---
> Subject: x86/topology: Ignore non-present APIC IDs in a present package
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Tue, 05 Mar 2024 10:57:26 +0100
> 
> Borislav reported that one of his systems has a broken MADT table which
> advertises eight present APICs and 24 non-present APICs in the same
> package.
> 
> The non-present ones are considered hot-pluggable by the topology
> evaluation code, which is obviously bogus as there is no way to hot-plug
> within the same package.
> 
> As the topology evaluation code accounts for hot-pluggable CPUs in a
> package, the maximum number of cores per package is computed wrong, which
> in turn causes the uncore performance counter driver to access non-existing
> MSRs. It will probably confuse other entities which rely on the maximum
> number of cores and threads per package too.
> 
> Cure this by ignoring hot-pluggable APIC IDs within a present package.
> 
> In theory it would be reasonable to just do this unconditionally, but then
> there is this thing called reality^Wvirtualization which ruins
> everything. Virtualization is the only existing user of "physical" hotplug
> and the virtualization tools allow the above scenario. Whether that is
> actually in use or not is unknown.
> 
> As it can be argued that the virtualization case is not affected by the
> issues which exposed the reported problem, allow the bogosity if the kernel
> determined that it is running in a VM for now.
> 
> Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
> Fixes: 89b0f15f408f ("x86/cpu/topology: Get rid of cpuinfo::x86_max_cores")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/cpu/topology.c |   38 +++++++++++++++++++++++++++++---------
>  1 file changed, 29 insertions(+), 9 deletions(-)
> 
> --- a/arch/x86/kernel/cpu/topology.c
> +++ b/arch/x86/kernel/cpu/topology.c

#include <asm/hypervisor.h>

at the top here.

With that, relevant new lines from dmesg:

+CPU topo: Ignoring hot-pluggable APIC ID 8 in present package.

and

@@ -129,9 +130,10 @@ CPU topo: Max. logical packages:   1
 CPU topo: Max. logical dies:       1
 CPU topo: Max. dies per package:   1
 CPU topo: Max. threads per core:   2
-CPU topo: Num. cores per package:    16
-CPU topo: Num. threads per package:  32
-CPU topo: Allowing 8 present CPUs plus 24 hotplug CPUs
+CPU topo: Num. cores per package:     4
+CPU topo: Num. threads per package:   8
+CPU topo: Allowing 8 present CPUs plus 0 hotplug CPUs
+CPU topo: Rejected CPUs 24

AFAIC, ship it.

Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

