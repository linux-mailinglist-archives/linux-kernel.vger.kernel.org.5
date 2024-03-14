Return-Path: <linux-kernel+bounces-103282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEC287BD71
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342FD2816E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C485B683;
	Thu, 14 Mar 2024 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ho7CTE2Z"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BE03D0D5;
	Thu, 14 Mar 2024 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710422245; cv=none; b=QqlMMDtmhU9TUvu+vvXvaQrfL8oyvd3XHNVrQUrsT8ehliLOJa+wZ4LXyMhoMh6g+rze490g8yVT0Qdvv3vbjmR+EpUfqHl8AUWJ0/SDGgMq1snNkVnfOZfcFMppyDLaRlon3NZewXqzzemTS0PoCPeDttz23MoIUNq1hif+k58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710422245; c=relaxed/simple;
	bh=8om1TSfZV/lD1t30d/Govum8U1wXvG3FbuXdIOkj6mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rymCzcRpiVvJfEbcyNghy6uGiHW414vAhny0f9BPYX8bqY1lbtDm6CUhmm3orAEzAciZu4urvjeh4M7ql7XzXsIH4kF9FItrLEpYhR0LoxXW5iUPx/vgMZXhlygBYM+uhWzkUOeRV1nOrimcWHWEHA92d2BqW9olL2Qk4dI+W9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ho7CTE2Z; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=clrW0RwMW19aCCVUBe+aDaa6Xr2fikUQUzGV0E47Ik8=; b=ho7CTE2Zq1/DvHgOQchZ4l3JtQ
	k5ID2n2/S4kvmPPE9WrMgxAyc9pWgcLyPizYsqSRtd8W80gi8AYct3bRILrT6ln668Tj9Q8FWDx3G
	uEh81hiCaDn+Kr+6bcuNb1RRA9E0Rs2P51cwzTON2R++WbCGz+BSSutYfuA4BjFKr7/houpCIGZmz
	Q1km00FJT9ueKsGXmjsYD9euNplW3zJK4EkHBw5g5tQmR0YA21vrtJxeVxuiP0G9UdTakINVDCKR/
	iMmP0znPoqK9WArfjueEljzbfOI+lNl4mY7UMH924GL2vKcYY7lNEZ7Ekj2uCbUneYA9wSFamyc+E
	jgzW8UBQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51784)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rkkxM-0000Vg-2h;
	Thu, 14 Mar 2024 13:17:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rkkxE-0005Tc-6M; Thu, 14 Mar 2024 13:17:04 +0000
Date: Thu, 14 Mar 2024 13:17:04 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Christoph Lameter (Ampere)" <cl@linux.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, Will Deacon <will@kernel.org>,
	Jonathan.Cameron@huawei.com, Matteo.Carlini@arm.com,
	Valentin.Schneider@arm.com, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, Eric Mackay <eric.mackay@oracle.com>,
	dave.kleikamp@oracle.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	robin.murphy@arm.com, vanshikonda@os.amperecomputing.com,
	yang@os.amperecomputing.com, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
Message-ID: <ZfL40N6HYzEQaEj1@shell.armlinux.org.uk>
References: <c1f2902d-cefc-4122-9b86-d1d32911f590@samsung.com>
 <Ze9TsQ-qVCZMazfI@arm.com>
 <9352f410-9dad-ac89-181a-b3cfc86176b8@linux.com>
 <bf1757ca-6d41-87e7-53dd-56146eef5693@linux.com>
 <ZfCXJRJSMK4tt_Cm@arm.com>
 <ZfG5oyrgGOkpHYD6@bogus>
 <432c1980-b00f-4b07-9e24-0bec52ccb5d6@samsung.com>
 <ZfHevcKpcb6i1fn5@shell.armlinux.org.uk>
 <ZfK30r8M6zx2aWU6@arm.com>
 <a210104f-a3af-4554-b734-097cfa77a470@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a210104f-a3af-4554-b734-097cfa77a470@samsung.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 14, 2024 at 01:28:40PM +0100, Marek Szyprowski wrote:
> Dear All,
> 
> On 14.03.2024 09:39, Catalin Marinas wrote:
> > On Wed, Mar 13, 2024 at 05:13:33PM +0000, Russell King wrote:
> >> So, I wonder whether what you're seeing is a latent bug which is
> >> being tickled by the presence of the CPU masks being off-stack
> >> changing the kernel timing.
> >>
> >> I would suggest the printk debug approach may help here to see when
> >> the OPPs are begun to be parsed, when they're created etc and their
> >> timing relationship to being used. Given the suspicion, it's possible
> >> that the mere addition of printk() may "fix" the problem, which again
> >> would be another semi-useful data point.
> > It might be an init order problem. Passing "initcall_debug" on the
> > cmdline might help a bit.
> >
> > It would also be useful in dev_pm_opp_set_config(), in the WARN_ON
> > block, to print opp_table->opp_list.next to get an idea whether it looks
> > like a valid pointer or memory corruption.
> 
> I've finally found some time to do the step-by-step printk-based 
> debugging of this issue and finally found what's broken!
> 
> Here is the fix:
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 8bd6e5e8f121..2d83bbc65dd0 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -208,7 +208,7 @@ static int dt_cpufreq_early_init(struct device *dev, 
> int cpu)
>          if (!priv)
>                  return -ENOMEM;
> 
> -       if (!alloc_cpumask_var(&priv->cpus, GFP_KERNEL))
> +       if (!zalloc_cpumask_var(&priv->cpus, GFP_KERNEL))
>                  return -ENOMEM;
> 
>          cpumask_set_cpu(cpu, priv->cpus);
> 
> 
> It is really surprising that this didn't blow up for anyone else so 
> far... This means that the $subject patch is fine.

Wow. I guess we've been lucky with that allocation hitting memory
containing zeros. Well done at tracking it down!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

