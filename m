Return-Path: <linux-kernel+bounces-106278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 117E387EBD1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F88FB21702
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0FE4F1E3;
	Mon, 18 Mar 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LR5xL7jD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251384EB46;
	Mon, 18 Mar 2024 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710774808; cv=none; b=oECudPDMuLZAH6dKt7fmOGXzcbgBf1XVz7OoWecRM7KXh5Cdhs71Me14BqK/BzBYGZIOg/Td7pF7pFbwxx7ZBxdiJL/ivMa3VwrU9xdVdTPDZrjy7JRCASegyYdr1NiSPyo6ZV30rBQ3DFGKbwqiT3mfSY5gpet9iOy0OsS1OJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710774808; c=relaxed/simple;
	bh=aBPqk8trnulh2LGRBAvQNk1eT+wOb0FMAdGGz2elyeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoX1SI9Cg7/iJ8iPT2gM2OiGx+3q9ZU21fMTFs0XRtPClO9n05qAF7cOq0etthNaZxSHOdIRZ8ZdrZtKrW25pQBGDEFFxZqWF6DQVRI7ImR3cbBQk002moQrAtaSNI4AJaumSkwVYccIIJQ2/YhEKnhd9Kh966PR/HevTspF/9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LR5xL7jD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C1BC433C7;
	Mon, 18 Mar 2024 15:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710774807;
	bh=aBPqk8trnulh2LGRBAvQNk1eT+wOb0FMAdGGz2elyeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LR5xL7jDLw+ACyXwZvypw9pcn20xVLyiJQGscTwP9qeIJn9rbxYV0Own5r9K772h1
	 hvcwUM24a6E1csApsJyVmC84o/T43vLLm31UIWr6qHdys0NywIE37jfWOX5MzKAKMw
	 H42HD5vL+bqHBmhhtx0yRQ8KcX3duOPEqs5Lh+P/LvXjqRGeZ5HCtmKUwbSfnYN6k+
	 +iI39UBZxAFE4/LyRujIdWChkfj+11FvdYdn65Fcjyz2eZk4jpGvFpc8vBsrkmHop2
	 3TVTTzz8mMFi3lm4XWidJsDEgRis6eLCZs88fjGKHjD0plwKArp5KFDHLkCTgzyRjQ
	 OnzTYWJlYZfkQ==
Date: Mon, 18 Mar 2024 15:13:23 +0000
From: Lee Jones <lee@kernel.org>
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: Prarit Bhargava <prarit@redhat.com>,
	Vegard Nossum <vegard.nossum@oracle.com>, cve@kernel.org,
	linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2023-52605: ACPI: extlog: fix NULL pointer dereference check
Message-ID: <20240318151323.GS1522089@google.com>
References: <2024030647-CVE-2023-52605-292a@gregkh>
 <e4906091-598e-4d21-9e8d-4cb088855d6f@oracle.com>
 <7591f33e-d64f-49c5-b7c8-deda2b6f0fde@redhat.com>
 <20240314110110.GL1522089@google.com>
 <c9285318-affc-4d45-ba9b-40e3a86be68b@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9285318-affc-4d45-ba9b-40e3a86be68b@intel.com>

On Fri, 15 Mar 2024, Wysocki, Rafael J wrote:

> On 3/14/2024 12:01 PM, Lee Jones wrote:
> > On Mon, 11 Mar 2024, Prarit Bhargava wrote:
> > 
> > > On 3/10/24 04:10, Vegard Nossum wrote:
> > > > (Added author/maintainer to Cc)
> > > > 
> > > > On 06/03/2024 07:46, Greg Kroah-Hartman wrote:
> > > > > Description
> > > > > ===========
> > > > > 
> > > > > In the Linux kernel, the following vulnerability has been resolved:
> > > > > 
> > > > > ACPI: extlog: fix NULL pointer dereference check
> > > > > 
> > > > > The gcc plugin -fanalyzer [1] tries to detect various
> > > > > patterns of incorrect behaviour.  The tool reports:
> > > > > 
> > > > > drivers/acpi/acpi_extlog.c: In function ‘extlog_exit’:
> > > > > drivers/acpi/acpi_extlog.c:307:12: warning: check of
> > > > > ‘extlog_l1_addr’ for NULL after already dereferencing it
> > > > > [-Wanalyzer-deref-before-check]
> > > > >       |
> > > > >       |  306 |         ((struct extlog_l1_head
> > > > > *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
> > > > >       |      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
> > > > >       |      |                                                  |
> > > > >       |      |                                                  (1)
> > > > > pointer ‘extlog_l1_addr’ is dereferenced here
> > > > >       |  307 |         if (extlog_l1_addr)
> > > > >       |      |            ~
> > > > >       |      |            |
> > > > >       |      |            (2) pointer ‘extlog_l1_addr’ is checked for
> > > > > NULL here but it was already dereferenced at (1)
> > > > >       |
> > > > > 
> > > > > Fix the NULL pointer dereference check in extlog_exit().
> > > > > 
> > > > > The Linux kernel CVE team has assigned CVE-2023-52605 to this issue.
> > > > This code is in an __exit function:
> > > > 
> > > > diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> > > > index e120a96e1eaee..193147769146e 100644
> > > > --- a/drivers/acpi/acpi_extlog.c
> > > > +++ b/drivers/acpi/acpi_extlog.c
> > > > @@ -303,9 +303,10 @@ err:
> > > >    static void __exit extlog_exit(void)
> > > >    {
> > > >        mce_unregister_decode_chain(&extlog_mce_dec);
> > > > -    ((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
> > > > -    if (extlog_l1_addr)
> > > > +    if (extlog_l1_addr) {
> > > > +        ((struct extlog_l1_head *)extlog_l1_addr)->flags &=
> > > > ~FLAG_OS_OPTIN;
> > > >            acpi_os_unmap_iomem(extlog_l1_addr, l1_size);
> > > > +    }
> > > >        if (elog_addr)
> > > >            acpi_os_unmap_iomem(elog_addr, elog_size);
> > > >        release_mem_region(elog_base, elog_size);
> > > > 
> > > > This can only run when you unload a module, which is a privileged
> > > > operation (restricted to CAP_SYS_MODULE).
> > > > 
> > > > Moreover, extlog_l1_addr is only ever assigned in the corresponding
> > > > module init function, and it looks like it will never be NULL if the
> > > > module was loaded successfully, at least on a recent mainline kernel.
> > > > 
> > > > Since the module exit won't be called unless module init succeeded, I
> > > > don't see a way to trigger this bug. Is this a vulnerability?
> > > > 
> > > This is certainly not a CVE.
> > > 
> > > > It might be better to just delete the NULL check altogether.
> > > > 
> > > > As usual, I could be wrong...
> > > > 
> > > When I made this code change I thought the same thing: Perhaps it's better
> > > to remove the NULL check given the status of the code.  I assumed that the
> > > check was there as a failsafe on unload.
> > If Rafael agrees with you both, I'd be happy to revoke its CVE status.
> 
> I do agree with the analysis above, sorry for the delay.

No problem Rafael.

Okay, CVE-2023-52605 has now been rejected.

https://lore.kernel.org/all/20240318151025.2952751-2-lee@kernel.org/

-- 
Lee Jones [李琼斯]

