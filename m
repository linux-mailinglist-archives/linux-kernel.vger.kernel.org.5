Return-Path: <linux-kernel+bounces-100520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221E9879905
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26702825C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC2B7D3E9;
	Tue, 12 Mar 2024 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AZVdRiHX"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77797B3C7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710261330; cv=none; b=cem4PoSLifAQE4QPjC0T7iukkEDMzx88+5yTG9GKPOeugATjhdbNO2vZ/qYXYNqV20/V9buRl9udWhV13Clyqsd6kKpSsf/PEJ16/0xLJwFqepFR8iwJFYozTTGzE3ej3ii9zvmt9MUmPRW1S1f2Rn1a35vOw699plZdcixhrc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710261330; c=relaxed/simple;
	bh=S8Gs69JN4BRkAeykLxUkio2jGlDuEezvviIDYxcsAWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYTzJGIl0y6XM0pO4RIMBe3A7oDmQsvHxxa3UXJTOXCBQY+JvdXW2GuzVRdzmEt3cDLP3aVcV5zmzjEqO5bLTbc/JWU25I2iLTiwVFSIJO2i2zjTVZdbAd0tc0CVpo2FDNAnTPE4YYwaTxS7yqCx2LKk5FdP/AeL5OB58RXx4no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AZVdRiHX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4B7E140E01A0;
	Tue, 12 Mar 2024 16:35:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id C7Fj07iVaBQ2; Tue, 12 Mar 2024 16:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710261323; bh=P6Nl44Mmk5e+Il2mmTMKgMSHn/Wtfj20yZkZYWVB8Gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZVdRiHXZef7l0OGlxlbI6SoxrveedSFzf03ZcUuRzJXZtM794XB2slSMvi0l3P4H
	 myLYJheI1jT6lDWHIcabRHGOKvVTvzBvjJ8DnMe1EylB1iLVf/RBTN0lTf02U3lxpI
	 bO0VcO4Z9oG0onMeephMq7Lre6CRv0U0m7hIYfByQjE/W6Uy6p9lt8COWXDLe58lID
	 W+3ZDUnsRg+wlK98R/jv5Az6j4oGLrZL52kxhLgsqx5bwR1KLkrTyqggiTNe6VAidJ
	 iK4suK3AuqGiGN0RZcksQrv5RXSU/xek9gq5Da+pIvftgpxN7pSusWpX4twi5vWcYu
	 CA4OJZy+lCqDdRxTCExCBwNJ8uNED3R7LB6V/qIGzrkokuib/M4KnibwpZcOQJnSDk
	 lJnVbDF2O+WBuJTEX1ulc09wCi1c8zfZ7uSr+vJixzzk3VDihLanhL9IlTUo9p+zr+
	 dY/ALOvvHLYBb/UQK8yAe4ZocdifI2dNnCa/BzRtzMeLtMNz+mSR1OvyuqD+T/hlrZ
	 UsVcKVbHCQe6TYRx1+sfrAyIxSLpxI4qay6l1+z137D7IJ5bzu8u4Zs8xjNDhIwsBY
	 Y5BMo/KPX0P4BqCxq6nG/UZIKf/5Fg8TOw9I9bCoAwPEtNMASwTnOlJFb6lBwhXFWc
	 zEmyw1hYE3OtSnFXQ0QzFgJE=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0F86240E016B;
	Tue, 12 Mar 2024 16:35:08 +0000 (UTC)
Date: Tue, 12 Mar 2024 17:35:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@google.com>
Subject: Re: [PATCH v2 1/3] x86/mm: Use IPIs to synchronize LAM enablement
Message-ID: <20240312163502.GGZfCENkvNb41IJWPy@fat_crate.local>
References: <20240312155641.4003683-1-yosryahmed@google.com>
 <d24c8736-d963-4aa5-a3cb-5cc1110e3ca8@intel.com>
 <CAJD7tkYXfFiOQMpM+GkR7a=aUxFM-smDc-ZFTTtFu2Kbd2KoPQ@mail.gmail.com>
 <20240312161337.GFZfB_MdSFtAUXjeLU@fat_crate.local>
 <CAJD7tkYa_NuX2_PD1sEn6kE6Q0Z0VCyq2T2HK_Qdj-_94+OG_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJD7tkYa_NuX2_PD1sEn6kE6Q0Z0VCyq2T2HK_Qdj-_94+OG_w@mail.gmail.com>

On Tue, Mar 12, 2024 at 09:23:48AM -0700, Yosry Ahmed wrote:
> Sure, although I am kinda familiar with that. It would be useful to
> point out what part(s) I may be violating :)

Are you kidding?

Dave just told you.

Lemme paste the whole text for you:

"Don't get discouraged - or impatient

After you have submitted your change, be patient and wait. Reviewers are
busy people and may not get to your patch right away.

Once upon a time, patches used to disappear into the void without
comment, but the development process works more smoothly than that now.
You should receive comments within a few weeks (typically 2-3); if that
does not happen, make sure that you have sent your patches to the right
place. Wait for a minimum of one week before resubmitting or pinging
reviewers - possibly longer during busy times like merge windows."

https://kernel.org/doc/html/latest/process/submitting-patches.html

> Right, I am aware of that part. According to the tip tree handbook I
> shouldn't expect them to be handled during the merge window, but do
> x86 folks prefer I hold off on sending them until after the merge
> window?

I believe I speak for all of tip folks when I say that they prefer not
to be spammed with the same set too regularly.

As to when you send: there's never a good moment because our mailboxes
are constantly overflowing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

