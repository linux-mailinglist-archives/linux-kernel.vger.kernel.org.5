Return-Path: <linux-kernel+bounces-92317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84C4871E5F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8582845EA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAEB58ADC;
	Tue,  5 Mar 2024 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GYQFIw5M"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CA859146
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709639750; cv=none; b=A3+3l6xn0HrIQrex5VjAyNhv83Y7Jrzb/xwwngqH60JCEMnLMR34XsQSH2vQJdAJOTpkKpjIYMKqoMrc2FieyadbY3yRFNw8DSet8NCoWlMiZajXuUKwlXqys5lROsl+nOyXZkY8MWb9qQbOJ9uu/3xDz8xXYcmnmrFUE4Tg/Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709639750; c=relaxed/simple;
	bh=TINiIPF1v1HNQXJC916gUTlXV9aKE/yApjDYCWSc43Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COIC0AWdv1wwZgxfkZoNawSAwTvBGu45azJymh6U/BOmrmGQ5cR8puktpsX4ESdHtIDnUe2UA7vfhUAJDTnn8a8o1yOn4bqONB5D/iLudCqLkjn2UUwX5VZu/yJKJp0E0xXCK0woXtU0HZmxWVRjVMDdn7FmRFQDLh9GhhOXsWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GYQFIw5M; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B684B40E01A8;
	Tue,  5 Mar 2024 11:55:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ILTmc77TMCuZ; Tue,  5 Mar 2024 11:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709639742; bh=9Q7sSI80+QC4+NwaBZXKZ4DDS7yw7ZGuhT1y0zerePs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GYQFIw5MN7yw1C8SZo5dbAmou1GuaXiJn3jPEs32qvVZ3Ua96kJIWIP1VnhTB29en
	 ENMjzj8/SIm9JyANMbIqCrnBxZR1uusEwyIo/txBnSd7thZH3BCivOSm0Q0UBhg6KX
	 TGzfSMIQAt3w5nF6BMHc7knWVHpOU93z3374RlyAN/+PWMmEDFUXXDtudfqyUPY8Wm
	 M9LZDqIvTsux+BtQ8DjvGaCVve+yprN6wGES9qhoM8cEU3pJbo57JP0rMrG4EWCvoB
	 k/Kq5Jqgg9CADTZeQvKH7f3fo2okxu7cIoGNbNb28Jw6Q3pK4S63LuSZ5ww/Mbtqtj
	 kLk07ECtaMIwNWaKP6P4DE9OT5WkX1j60HyEI4dimrWgUCICvIeU9R31MTOVxDEdtA
	 XQrJotXwD5qV7JeMwOSQcFuKWEOn8DwH32K0aVqDxdsjcwm3NCMVjxvOjFxJL0ldRn
	 AUjT5OgPpMzSC+LviyAywklpenVBvQm3LyI7JKsf33TqgHrNcKLsV9Sm6cRNA0v8Jy
	 dX5rejZ6EMNIsI9ha6ntM9lQeiCCUcqvzBJhHfRcvGfEZymwtdQrSxdX2TZlMVzUUZ
	 aBEwyzjamHyS+XpggAGht9809ljzo9F8zvvWBlvLfGytHBE4d/KITRzJG+RcWE8Slv
	 3gA7WP4w+b0MyjROZaH4ru7M=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C247740E0196;
	Tue,  5 Mar 2024 11:55:38 +0000 (UTC)
Date: Tue, 5 Mar 2024 12:55:33 +0100
From: Borislav Petkov <bp@alien8.de>
To: Baoquan He <bhe@redhat.com>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	dyoung@redhat.com
Subject: Re: [RFC PATCH 1/2] Revert "x86/kexec/64: Prevent kexec from 5-level
 paging to a 4-level only kernel"
Message-ID: <20240305115533.GBZecINWGlb73W0nQS@fat_crate.local>
References: <20240301185618.19663-1-bp@alien8.de>
 <20240301185618.19663-2-bp@alien8.de>
 <ZeWnrhzU86pz7y5Z@MiWiFi-R3L-srv>
 <20240304111127.GAZeWsX3gBabiwrrVV@fat_crate.local>
 <ZeaUxXbZ3MB/pXm5@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZeaUxXbZ3MB/pXm5@MiWiFi-R3L-srv>

On Tue, Mar 05, 2024 at 11:43:01AM +0800, Baoquan He wrote:
> Guess you mean upstream kernel doesn't care about 'customers'. Downstream
> kernel does care about customers.

You know very well what I mean. You're at Red Hat - I was at SUSE for
a decade. You know exactly well what the distinction is.

> Hmm, there's different view between upstream and downstream. For distros
> kernel, we need a lot of testing to make sure one kernel is trustworthy
> as kdump kernel. Here, 'a lot of testing' means a long list of user cases
> for kexec/kdump. Please see below file from centos kexec-tools package:
> 
> https://git.centos.org/rpms/kexec-tools/blob/bb7919506eba39a2b7277c8d36fe1774f9c33428/f/SOURCES/supported-kdump-targets.txt
> 
> And the kdump kernel doesn't have to be the same kernel as the 1st kernel.

This "example" basically proves my point. None of those dump targets
talk about architecture support - this is all drivers.

> I can give several examples:
> 
> 1) Nvidia GPU or AMD GPU doesn't work well when kexec/kdump jumping to
> 2nd kernel in some releases. When we meet that case, we want to use the
> newer kernel as 1st kernel. we also want to deploy kdump kernel to
> capture the vmcore for analyzing once corruption encountered. Then the
> old kernel which have been tested and prove to be working well can be
> configured as 2nd kernel.

Same as above - nothing to do with architecture support. Both kernels
can and will have 5level support because you won't do two kernel images:
one with and one without 5level.

> E.g kdump kernel is too old, or like this 5-level case, jumping from
> 5-level to 4-level will fail.

5level support is present upstream since when?

$ git describe 6fb895692a034
v4.11-rc1-97-g6fb895692a03

There's no sensible kdump use case where you jump between 4.12 *and*
6.10, depending on when we revert this.

> No, it's not true. Kexec-tools doesn't check,

No, it is true. kexec-tools does *NOT* use those flags. Vs

"The flags will be used by the kernel kexec subsystem and the userspace
 kexec tools."

from f2d08c5d3bcf3f7ef788af122b57a919efa1e9d0.

> If we take off the checking, and people want to jump from the new kernel
> to an old kernel where 5-level kernel code haven't been added or
> CONFIG_X86_5LEVEL is unset on purpose, it won't fail and prompt message at
> all until 2nd kernel booting silently failed. E.g, the coming RHEL10 anchor
> a upstream kernel w/o the flag checking, people want to kexec/kdump jump
> from rhel10 to an old rhel7 kernel. It could be an extreme case, while
> revealing the scenario.

That is the only valid reason you've given until now. Yes, that makes
sense - the removal of those flags should go together with the removal
of CONFIG_X86_5LEVEL and making this feature unconditional.

Because, practically, that config item is enabled on every relevant
x86 kernel config out there. It would be silly if not.

/me puts on TODO.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

