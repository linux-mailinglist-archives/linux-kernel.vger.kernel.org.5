Return-Path: <linux-kernel+bounces-88841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E175286E761
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058121C21F9D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43A1282EE;
	Fri,  1 Mar 2024 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UTWarH1+"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137F525740
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314430; cv=none; b=td649d//Ke/jdf2owEWs3TmD08I0efQOtYAY6v0PFcdqHYxUdLIiWfLEwlH9kah/+cXTYd0HKR4wFSQoYJHg50tH/ig6WaXjjvuP1QF2JbhRXw+kEns/MS356/+gY+gUSPfByge2Y0K+9vDJqslLwJeOlur1JuekW14e8XFFk7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314430; c=relaxed/simple;
	bh=uPcrWwZo51EZo9dE7TOvBkTfx+6v7yhA6bRe7BwSO+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ie+9955uS/AJusdvTEJzAj55ZBbnIhNkBwqOUcNlC8VAWSBtKuXpt7kVrjPnwa78QdwjsBZ5+jAmqEF57HRYhAZmYdSPtnd5tw65JiP12KASAT+rqzTR6O63AlLT8L7UzpalHXVKU1DK2W/chhoSJEhHu1yGZ0PSDR4KtwSe+6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UTWarH1+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8C2CE40E0028;
	Fri,  1 Mar 2024 17:33:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6E5IhuBVq3GX; Fri,  1 Mar 2024 17:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709314422; bh=0spoTuQNwBK1qcqroj+kYN6zrHCgNmlEdBFjW5XSE+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UTWarH1+F3ypn+rMp1530yxS1poDgUq7Tm+/oBGi10vSklLnOV2oFwFu8NOTM6hb2
	 fpK2bKMZQulEvRVEa76LHm6gBBOA0GKvQwkvKWCcgG3rMpyDkOthba8QORvMTCohXv
	 3dN69w5idhdZO+1Y6QNlaaTAvld37Z6y4uYoJNEgAfihGhOHngn77ImkmwpJQAxThr
	 oqDOwC0lPcDEURVvf1i5zTEAAxzRdkdNCJOURujATuEvFtaoDSgHYUmzSWeB4rX0mQ
	 y4Bo+RJQErHw0jFfqRb3rae0DL9/qHQ91dR9kPwwE76q2WHiaiuaVNMNqaNF4yyGv6
	 38T0NrMM7arGfxy+Gw7JPDXocgCaJjiA5WDS1h/8/YGYBhx0dkAxjM+9tzyyt8CdQM
	 neHAbJGRZkEYnrg2EYa80PASfZ68GSWzY3+mNWD27ymllMhVTiSc0MwPYeqUzLtYwt
	 4fw3RvtPsJ0q9EAoiBeoIMKtrzbCv9sVRntQjZblnR3q5g5TDZk1ZKD5OOsEsoNdff
	 AXzwLLP6j0ruDGspiv8pK7bLW/fo2dJQIw4pFDGZYw6Aj2bDa9hKMVjm1Vy6BUqZ8o
	 qnr9ka87yXK/eblWXUxPFoOct7tgzbqHLb91gzDcthlypxvsp8YmRxxHnfw4RoGLcR
	 K8uB8p6UV5/RsEbxg2AEoAk8=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B1E1340E0196;
	Fri,  1 Mar 2024 17:33:31 +0000 (UTC)
Date: Fri, 1 Mar 2024 18:33:23 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH v7 2/9] x86/startup_64: Defer assignment of 5-level
 paging global variables
Message-ID: <20240301173323.GDZeIRY_BVBqpudkEo@fat_crate.local>
References: <20240227151907.387873-11-ardb+git@google.com>
 <20240227151907.387873-13-ardb+git@google.com>
 <20240228205540.GIZd-dzFYIBbtfIAo3@fat_crate.local>
 <CAMj1kXGhZU+FE2gE262Q8_vZEFHicsRtVPzXT-dhhCvBuiMjUA@mail.gmail.com>
 <20240301160921.GBZeH9sZhp73xX40ze@fat_crate.local>
 <CAMj1kXFJwEUExy7+Snh3QHVn-ATj0C+sYje22Qmc+y=cCtAV7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFJwEUExy7+Snh3QHVn-ATj0C+sYje22Qmc+y=cCtAV7g@mail.gmail.com>

On Fri, Mar 01, 2024 at 06:09:53PM +0100, Ard Biesheuvel wrote:
> On Fri, 1 Mar 2024 at 17:09, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Mar 01, 2024 at 11:01:33AM +0100, Ard Biesheuvel wrote:
> > > The scenario that I have not managed to test is entering from EFI with
> > > 5 levels of paging enabled, and switching back to 4 levels (which
> > > should work regardless of CONFIG_X86_5LEVEL). However, no firmware in
> > > existence actually supports that today, and I am pretty sure that this
> > > code has never been tested under those conditions to begin with. (OVMF
> > > patches are under review atm to allow 5-level paging to be enabled in
> > > the firmware)
> >
> > Aha.
> >
> 
> I've built a debug OVMF image using the latest version of the series,
> and put it at [0]
> 
> Run like this
> 
> qemu-system-x86_64 -M q35 \
>   -cpu qemu64,+la57 -smp 4 \
>   -bios OVMF-5level.fd \
>   -kernel arch/x86/boot/bzImage \
>   -append console=ttyS0\ earlyprintk=ttyS0 \
>   -vga none -nographic -m 1g \
>   -initrd <initrd.img>
> 
> and you will get loads of DEBUG output from the firmware first, and
> then boot into Linux. (initrd can be omitted)
> 
> Right before entering, it will print
> 
> CpuDxe: 5-Level Paging = 1
> 
> which confirms that the firmware is running with 5 levels of paging.
> 
> I've confirmed that this boots happily with this series applied,
> including when using 'no5lvl' on the command line, or when disabling
> CONFIG_X86_5LEVEL [confirmed by inspecting
> /sys/kernel/debug/page_tables/kernel].
> 
> 
> [0] http://files.workofard.com/OVMF-5level.fd.gz

Nice, that might come in handy for other testing too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

