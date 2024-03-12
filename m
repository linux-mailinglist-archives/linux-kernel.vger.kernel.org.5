Return-Path: <linux-kernel+bounces-100555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7316A879990
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4EA2854FB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DD480C08;
	Tue, 12 Mar 2024 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Uq41NbSw"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3EC137937
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710262900; cv=none; b=G5RDrtQXk+dnR2IRuwNhBWakBYE1cMBXpiMwwd4at2n9nXQ7C9DR3rYIOAaK0aynP5g+m+CKk2b/qr3owt/G87pWmMJbC4SxhZNxPhTCxZASHsTuH2pkF4EI4R26d5DTmWd7ndBbV5As55xtzdvWa4+Ehk7OO1xCz1C8ICOVtto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710262900; c=relaxed/simple;
	bh=1+uyJt/XM62F43PT2V7q6lumviIdS3zs0F4HClhwjM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2i5yrBLmWi/YpD+qsCKEDhCjAwcFClyZ7mp9XU5KuOa5tqi2MemmqkWtXiqcRX+S320pS4JlL/dUXH60CGncXNnx/vhy+IBEH7+DI6cHLfEj899/miY6awVgIEsM+a3t4RcAficG6pYFH9fBFRyek4/y63nwhVZ4deAEmawHrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Uq41NbSw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A102540E0028;
	Tue, 12 Mar 2024 17:01:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YpqKepYhEfGK; Tue, 12 Mar 2024 17:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710262893; bh=6NKQfjU527nLHAaoilA76llGPofbJado6fAgAUTrens=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uq41NbSw9/fYrBfexrP7VzItaDg/b4/I09fCRQvgtCPhdaTDomuMchvVMhh+cokX0
	 s+Bf3bNSk5G/nnqK65NID+sSyGs779zMPhs9QUKTAYPRNBcynbRTZMQrNr6+iM1qFD
	 leSPB42r2cUKd2SikEatFkNqvsSAxTJHDBkB7bXy+ZWL5EZMXkPi8EITqXtwht2n/4
	 P4YwQQ2AS943cMQZAl/HaRDHlN69x23VzAE0zBO8pTSdLTW8hze8fXkbVw9ayG7DZz
	 KlGJZO1y4o59HMVI5+p5nwLfyjfRkBP/3eR0XpArjwG1BtUTvP5tZ2UVQfLfvlRd06
	 IQQgYUGJGxExMmbIWLdFEq85cEq8BI75KAutxtiD2YpNvA0dFkl9wv7holss1suljU
	 ZDB5mxHrc0ASE77szjvrPWJI1Xhh6Bxs0J0WE5HpB+AkVWTqgSDPdRQzvzbXM3nIl2
	 vrnDKn54JMGAUw1zTmGDqqExMiM1C+XdLQSdT+yEdRkULv79ClJ66JDD7XdyaSOV0I
	 mH76IEO8iDx7bgEVrmzMv1jevcJ+Z6yplEQL26ejPuPUO/ayl9+UWbZ3YHHv4RmItv
	 auutj8mZ3U3QYuetevFRtYyTJqr/qMQxWkbVjR4VG7uI5/2guux2SPqyFLtiepbPQW
	 rhl3GIxYT0vSjA2zxOVLFFjo=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D2E440E016B;
	Tue, 12 Mar 2024 17:01:18 +0000 (UTC)
Date: Tue, 12 Mar 2024 18:01:11 +0100
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
Message-ID: <20240312170111.GHZfCKV_brefr6M_2F@fat_crate.local>
References: <20240312155641.4003683-1-yosryahmed@google.com>
 <d24c8736-d963-4aa5-a3cb-5cc1110e3ca8@intel.com>
 <CAJD7tkYXfFiOQMpM+GkR7a=aUxFM-smDc-ZFTTtFu2Kbd2KoPQ@mail.gmail.com>
 <20240312161337.GFZfB_MdSFtAUXjeLU@fat_crate.local>
 <CAJD7tkYa_NuX2_PD1sEn6kE6Q0Z0VCyq2T2HK_Qdj-_94+OG_w@mail.gmail.com>
 <20240312163502.GGZfCENkvNb41IJWPy@fat_crate.local>
 <CAJD7tkZjHaLpWhn6bKRMwZrgiaK6V3gASB9d--e16xiV8P_7cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJD7tkZjHaLpWhn6bKRMwZrgiaK6V3gASB9d--e16xiV8P_7cw@mail.gmail.com>

On Tue, Mar 12, 2024 at 09:46:07AM -0700, Yosry Ahmed wrote:
> Thanks for sharing that. I have always assumed this was about pinging
> or resending patches when reviews are taking too long. In this case, I
> was responding to review comments. Maybe I misinterpreted that.

So what I would do, for example, is send my set, collect review
comments, work them in, discuss them and once there are no more, I'll do
a rev+1, test and send again. Not under a week unless it is some really
serious bug.

This is a perfectly fine cadence.

> Anyway, sending a new version in the same day is too fast regardless.
> I did admit that already. My bad again :)

No worries. I'm saying this also for all the others who are reading. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

