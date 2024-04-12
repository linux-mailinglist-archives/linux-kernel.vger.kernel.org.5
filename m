Return-Path: <linux-kernel+bounces-143055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 728708A33A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3161F21F3E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2E614A4D2;
	Fri, 12 Apr 2024 16:20:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE02B14A4D0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938824; cv=none; b=h/+stMicBnnPs+51/k4wBZyidErAMDOkZWPzlFMq9WiDWMgtn3yybWwSyxEG5nvTYtDH3dhcRQugTKDsuowac+sH4veFj7mcUKidPJMqyMnUk4jdLmodMAqCwYdOnf63JpbOl5k2TX8bmV3SaNqt5l3mrhGLwken9ySnwhORxDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938824; c=relaxed/simple;
	bh=JcFWIlWAmP82bnMMOxigsCewAls5gbc2qooWyldRIlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZneJsRP2TX1Kl7K85v1fcxB3g24oIuxUPOQ9U4ycDUeREmZvQhVW6sIB1GeZQXoTYRA/ClbWBFsBRp5FwO5DGNiYt3I0XZ+fq7Uuhv1e1txA4Nv88hDf9FktW0XtiXToDTizlbu9CrlbroOAiIVo2z3tj3z6Kweq7Q3QFkg6ys8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40FAB339;
	Fri, 12 Apr 2024 09:20:51 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 482AE3F64C;
	Fri, 12 Apr 2024 09:20:19 -0700 (PDT)
Date: Fri, 12 Apr 2024 17:20:16 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Amit Singh Tomar <amitsinght@marvell.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	James Morse <james.morse@arm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: Re: [EXTERNAL] Re: [PATCH v1 28/31] x86/resctrl: Drop __init/__exit
 on assorted symbols
Message-ID: <ZhlfQKMg4xeA53SD@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-29-james.morse@arm.com>
 <c27c7813-5744-4363-bb7b-f9fbe80fd549@intel.com>
 <ZhfzF8L6w1pgJJ1r@e133380.arm.com>
 <47af4fef-35d3-4d88-9afa-42c1a99fbe07@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47af4fef-35d3-4d88-9afa-42c1a99fbe07@marvell.com>

On Thu, Apr 11, 2024 at 09:21:38PM +0530, Amit Singh Tomar wrote:
> Hi Dave, Reinette,
> 
> > On Mon, Apr 08, 2024 at 08:32:36PM -0700, Reinette Chatre wrote:
> > > Hi James,
> > > 
> > > On 3/21/2024 9:51 AM, James Morse wrote:
> > > > Because ARM's MPAM controls are probed using MMIO, resctrl can't be
> > > > initialised until enough CPUs are online to have determined the
> > > > system-wide supported num_closid. Arm64 also supports 'late onlined
> > > > secondaries', where only a subset of CPUs are online during boot.
> > > > 
> > > > These two combine to mean the MPAM driver may not be able to initialise
> > > > resctrl until user-space has brought 'enough' CPUs online.
> > > > 
> > > > To allow MPAM to initialise resctrl after __init text has been free'd,
> > > > remove all the __init markings from resctrl.
> > > > 
> > > > The existing __exit markings cause these functions to be removed by the
> > > > linker as it has never been possible to build resctrl as a module. MPAM
> > > > has an error interrupt which causes the driver to reset and disable
> > > > itself. Remove the __exit markings to allow the MPAM driver to tear down
> > > > resctrl when an error occurs.
> > > 
> > > Obviously for the reasons you state this code has never been exercised.
> > > Were you able to test this error interrupt flow yet?
> > > 
> > > Reinette
> > > 
> > 
> > I think this will have to wait for James to respond.
> > 
> > There is code to tear down resctrl in response to an MPAM error interrupt,
> > but I don't know how it has been exercised so far (if at all).
> 
> We are managed to test the MPAM error interrupt (on the platform that
> supports MPAM interrupts on software errors). For instance programming
> more resource control groups (part IDs) than available, and It appears to
> correctly remove the "resctrl" mount point (though mount command still shows
> resctrl on /sys/fs/resctrl type resctrl (rw,relatime)
> ), but

Thanks for trying this out!

Is it possible to unmount resctrl once the system is in this state?

> # mount -t resctrl resctrl /sys/fs/resctrl
> mount: /sys/fs/resctrl: mount point does not exist.

What if you now try to mount resctrl somewhere else, e.g.:

# mount -t resctrl resctrl /mnt

I'm guessing this _should_ fail if you weren't able to unmount resctrl,
since resctrl seems to forbid multiple mount instances.

I'm not sure what the best behaviour is here.  Leaving resctrl "half-
mounted" might be a good thing: at this point the system is in a semi-
bad state we want to make sure it can't be remounted.  Unregistering the
resctrl filesystem from the fs core feels cleaner if feasible though.

Leaving an impossible unmount operation for init to do during reboot/
shutdown feels unfortunate.

We might have to look at what other filesystems do in this area.

The mount machinery does provide other ways of getting into broken,
impossible situations from userspace, so this doesn't feel like an
entirely new problem.

> 
> Additionally, a question regarding this, Is a complete system restart
> necessary to regain the mount?
> 
> Thanks
> -Amit

I think James will need to comment on this, but I think that yes, it
is probably appropriate to require a reboot.  I think an MPAM error
interrupt should only happen if the software did something wrong, so
it's a bit like hitting a BUG(): we don't promise that everything works
100% properly until the system is restarted.  Misbehaviour should be
contained to MPAM though.

Cheers
---Dave

