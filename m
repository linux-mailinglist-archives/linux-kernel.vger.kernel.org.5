Return-Path: <linux-kernel+bounces-85699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A19786B97A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F022838B8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C0C8624F;
	Wed, 28 Feb 2024 20:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HpOWWwuk"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A61286249
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 20:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709153770; cv=none; b=UlckeJdmFBjiKNDgbkNCgI35Eouq7m3Pc8/Mx1uQlTksVwVQZ4pZyhGDD4WGJsiivsf8H00GNWcBF104x/OXJQuAW1MnQu6geOa6f5GmvdCOmdYFAOun/IOQ7KUXus1OCMjQDchsnCWdCjrS78dQdi8HqF/gJ4GsEvqQaJoI7lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709153770; c=relaxed/simple;
	bh=U354uceyDGIoRShSXmYwpeaIYP/NzDagW/jDTIPvKTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsJZktB+2DOc2xqYx6fanKC39BNn8KXSSP8iZM4f9sDo4T0lkL1Kha24IMDg7530o7mZ7nN4mWbPOMgUxzP26H7EZFkyrMhjRUY04JXtbHe6zKCC4eg6qAHvpWJIGDSSdf0+lTge+z5KWiv441OSTby3idmNf7idZWrfboqoEjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HpOWWwuk; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A4D9F40E019B;
	Wed, 28 Feb 2024 20:56:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yjFN27kc-qHx; Wed, 28 Feb 2024 20:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709153758; bh=QHuZ4VosF2FmtJLDXnBvie+0GIreAYKapP+EcU48Axc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HpOWWwuk3g4JvXMQkdeMBZJB398F1wXcHzLKfRsA8Ef2GGrjsNNNcAUqujeSDJ73M
	 7wvPiSm1T1JMo24IPZWFeQGNBjEABdyOlbUSJ/f4ZGpnjcW9AXXAQbLWjGxXqRMmkO
	 JdRiyaVZtd60QnO28ujI0FKxJxIMaBiQPp38zzWqLZEKr846+DwkQvmf7HUV2yL2Zy
	 GalYRZ8nMlN/4tIL8L1/jI4pRqP2LBuHbAerJNG+XI9gkDQvWs+B/ix8Z8zphqpDzJ
	 +NH1LmaJuOL76Jdf7U8O0dC94vgVO9vL52F/9thscozBdfedGcuzLH4+Qnh4B8J1BX
	 vq87Y8klDwjo7C95rYyxnUPPJGFWhFR7cTaLKBZ6c+zlJtdiiiGEYnBMHOvuAqtesj
	 XUaWFh4SvV+2Dr7oICjd1BUZpQb2xVE/OS+LxbuG+W+O58Jtw8h8g2kJ8Wz5zK+H4Y
	 HT1KiqOEtQW0BnyAThqQyDzx0Fc8BUzpKUfFHi3bgb2HZpn4euppm22CPp9OzbEKBT
	 19BZrMPm3VG04I3d4uZwlbkW2kNvELj2aCo1aAZ83XyuPdjhuatkGHvlbpTFiXH8qt
	 HnFTZcU5v+peqw/nZrQ49YIaW5f2YuFpHkKmcrizL1EGzEbOYzj2agxGlWRoNYNR6y
	 EyBu+MPJbH8rf/K+rV+XYOjs=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CECAC40E0196;
	Wed, 28 Feb 2024 20:55:46 +0000 (UTC)
Date: Wed, 28 Feb 2024 21:55:40 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH v7 2/9] x86/startup_64: Defer assignment of 5-level
 paging global variables
Message-ID: <20240228205540.GIZd-dzFYIBbtfIAo3@fat_crate.local>
References: <20240227151907.387873-11-ardb+git@google.com>
 <20240227151907.387873-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240227151907.387873-13-ardb+git@google.com>

On Tue, Feb 27, 2024 at 04:19:10PM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Assigning the 5-level paging related global variables from the earliest
> C code using explicit references that use the 1:1 translation of memory
> is unnecessary, as the startup code itself does not rely on them to
> create the initial page tables, and this is all it should be doing. So
> defer these assignments to the primary C entry code that executes via
> the ordinary kernel virtual mapping.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/include/asm/pgtable_64_types.h |  2 +-
>  arch/x86/kernel/head64.c                | 44 +++++++-------------
>  2 files changed, 15 insertions(+), 31 deletions(-)

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

Those should probably be tested on a 5level machine, just in case.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

