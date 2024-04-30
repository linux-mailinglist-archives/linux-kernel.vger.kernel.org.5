Return-Path: <linux-kernel+bounces-164351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E02FE8B7CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B88E1F24A6C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8C91F5FA;
	Tue, 30 Apr 2024 16:19:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51124176FA3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714493967; cv=none; b=TByDK0x33ZI2la2fdDnryhjJtXtbpYmgbkw0L3PIEAZV5erRIKxSD01BnbKh4LP+1UAy4FpY02N4fZVUk9NsCle02sJci+Gc9t8lP18s/88Sq65xa+CrDwIOtuiGDxq+01id3a776boEhWzL6F8xFOGfgT8GLZbe53xmjl6HV+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714493967; c=relaxed/simple;
	bh=yYdLPc+I+9+9f84rs7LgN9Ih3ymu0XcTzO3mnqVMFQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xog3WrHfC1H6HglUvhM/k/qDnREkA8jT+XhmTz0f310Euq7QmKm0lMbgJ579QMgNynDElIfehQGCkFk4sp0Bg3J2639ltE7gn7dJQKQxAVEusMTOyhLwJrBPTrUh9zNuFj+wkJEsA2enoNtggRD027r9pVDnlIxgRkUZvdP25Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9814C2F4;
	Tue, 30 Apr 2024 09:19:50 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 619A93F73F;
	Tue, 30 Apr 2024 09:19:21 -0700 (PDT)
Date: Tue, 30 Apr 2024 17:19:15 +0100
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
Subject: Re: [PATCH v1 28/31] x86/resctrl: Drop __init/__exit on assorted
 symbols
Message-ID: <ZjEaA+YRPA+p9msM@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-29-james.morse@arm.com>
 <c27c7813-5744-4363-bb7b-f9fbe80fd549@intel.com>
 <ZhfzF8L6w1pgJJ1r@e133380.arm.com>
 <47af4fef-35d3-4d88-9afa-42c1a99fbe07@marvell.com>
 <ZhlfQKMg4xeA53SD@e133380.arm.com>
 <b87653fa-34e3-4124-a96f-f5d2b9730f10@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b87653fa-34e3-4124-a96f-f5d2b9730f10@marvell.com>

On Tue, Apr 30, 2024 at 12:43:05PM +0530, Amit Singh Tomar wrote:
> Hi Dave,
> 
> > Is it possible to unmount resctrl once the system is in this state?
> No, it can't be unmounted, as there is no mount exist.

I see.


> > > # mount -t resctrl resctrl /sys/fs/resctrl
> > > mount: /sys/fs/resctrl: mount point does not exist.
> > 
> > What if you now try to mount resctrl somewhere else, e.g.:
> > 
> > # mount -t resctrl resctrl /mnt
> root@localhost:~# mount -t resctrl resctrl /test
> mount: /test: unknown filesystem type 'resctrl'.

Oh, right, so the resctrl filesystem gets unregistered in that
case...

> > 
> > I'm guessing this _should_ fail if you weren't able to unmount resctrl,
> > since resctrl seems to forbid multiple mount instances.
> > 
> > I'm not sure what the best behaviour is here.  Leaving resctrl "half-
> > mounted" might be a good thing: at this point the system is in a semi-
> > bad state we want to make sure it can't be remounted.  Unregistering the
> > resctrl filesystem from the fs core feels cleaner if feasible though.
> > 
> > Leaving an impossible unmount operation for init to do during reboot/
> > shutdown feels unfortunate.
> > 
> > We might have to look at what other filesystems do in this area.
> > 
> > The mount machinery does provide other ways of getting into broken,
> > impossible situations from userspace, so this doesn't feel like an
> > entirely new problem.
> > 
> > > 
> > > Additionally, a question regarding this, Is a complete system restart
> > > necessary to regain the mount?
> > > 
> > > Thanks
> > > -Amit
> > 
> > I think James will need to comment on this, but I think that yes, it
> > is probably appropriate to require a reboot.  I think an MPAM error
> > interrupt should only happen if the software did something wrong, so
> > it's a bit like hitting a BUG(): we don't promise that everything works
> > 100% properly until the system is restarted.  Misbehaviour should be
> > contained to MPAM though.
> > 
> if "resctrl" is nonfunctional in this state, then this comment[1] here does
> *not* make sense.
> 
> "restore any modified controls to their reset values."

Can you clarify what you mean here?

I think it makes sense to clean up the MPAM hardware as well as we can
in these situations, even if we can't be certain what went wrong.

[final comments below]

> Thanks
> -Amit
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tree/drivers/platform/mpam/mpam_devices.c?h=mpam/snapshot/v6.7-rc2#n2228
> 
> root@localhost:~# mount
> tmpfs on /run/user/0 type tmpfs
> (rw,nosuid,nodev,relatime,size=32923772k,nr_inodes=8230943,mode=700)
> resctrl on /sys/fs/resctrl type resctrl (rw,relatime)
> 
> root@localhost:~# devmem msc_addr 32 0x9999
> [  687.096276] mpam: error irq from msc:1 'PARTID_SEL_Range', partid:39321,
> pmg: 0, ris: 0
> 
> root@localhost:~# mount
> tmpfs on /run/user/0 type tmpfs
> (rw,nosuid,nodev,relatime,size=32923772k,nr_inodes=8230943,mode=700)
> resctrl on /sys/fs/resctrl type resctrl (rw,relatime)
> 
> root@localhost:~# umount resctrl
> umount: /sys/fs/resctrl: no mount point specified.
> 
> root@localhost:~# mount
> tmpfs on /run/user/0 type tmpfs
> (rw,nosuid,nodev,relatime,size=32923772k,nr_inodes=8230943,mode=700)
> 
> root@localhost:~# mount -t resctrl resctrl /test
> mount: /test: unknown filesystem type 'resctrl'.


Thanks for trying this out.

I guess the behaviour here might want a bit more thought.

I'm not too keen on us leaving a defective mount in the namespace,
with a nonexistent mount pount.  I'm wondering whether things like
systemd may get confused by this...

Cheers
---Dave

