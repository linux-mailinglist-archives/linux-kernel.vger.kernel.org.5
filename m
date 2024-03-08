Return-Path: <linux-kernel+bounces-96543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB03875DD3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00291F21BEC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F50C32C9C;
	Fri,  8 Mar 2024 05:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BBOXMGXy"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007B42564
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 05:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709876761; cv=none; b=Z58QLp4cNb6tt5QaR9fjpTq8q+GHWHCKrWLL9UkVlmxFE62CRj6B429DNPuMzkvqEdXS5s12TOUkZ5kNfjvWo2uGXAeH/rlcntt8fWbHxa8XN1ytpOz+p6OMPKJ5GkZ/QyBuY1vRqE3PSMf8/ARl227bxhWCUxQvJ7OuNA1H0fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709876761; c=relaxed/simple;
	bh=jfEzWTSQXbRFhwMd3qNl7Trxa7yy3NJ9+kuWmILOIqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ya/WuexBd/tDvNr4ZUxBPks59207P5Z8iRWCNZoiY1wnOmvYXnrj5hI5EThrT1pB8m7+HyDYxE4GG3LfqbUy241CrPH/ezAg77TPYk/UKWSmXCBav0FGQUa+53wFH9ji/Vr1laHtQ1rJ4YnHapd3BFjnd4loNFS7SLmIszs7zv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BBOXMGXy; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8B95340E0185;
	Fri,  8 Mar 2024 05:45:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2ctcx-lkY7Jc; Fri,  8 Mar 2024 05:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709876751; bh=FKsdy0bUX5Q/9NG8GdgiRx0riUw7WOmPGga/MBUabv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BBOXMGXyRzAvYZiRVuMzTMmwXmzvwt+YY4FsWy408k6v/+KAZVBMKddy/dIE/L3qV
	 TwbIpuf9m+gw3UZC37b9Z0aWwEWm0bIURxyU2VuYczafpTdbgixwhVBtWTP2GZSQI0
	 g1k/7dRg3UVIMcBKVOImKcsxenv3aO4LJv+EUtlqFwv2M+Ah9VPN0lMvX33+64hiiw
	 +GnlMiH7PTOMnJTFmi67Oa/jtoNpQKOa3RCvmKluJKvPQfxaKWPAHB8/pfGUClAPId
	 iY8KImKlY899mmAUETIc6Sss8CyqfakGm9ZB/M2JVjVzUa3txRInQAIa40BnxufFKV
	 s0dWZDYTJX4zEOaDW9S7k/6cfC12cJaoH0Xzq4y+msRY/cWpwJweHJdaEgLS8kEDx3
	 jjLQEGvMHLm23rd+Xk7YeXEtxEiPfRFWQCG4i/UEhS+QvakkJ+OzZ1QZviWy1upR1J
	 oEy6JlBH67KKegv3rmQo4B9R6v3S1MVpFCUYx/fNuw+lh9FJ236EoDrufoi0a2wPvL
	 09mKbG2gKpFi0DOVTpxteM3g8JQz3hhroefhOEtz7d+rt3CcpU99hX1D3rVzwCyNEs
	 qpN5SBK1topBvdfS/nilgRZ50qdjPpxxHZdugQhJSMbx2HI24mNcQHm48sxSvCRGHe
	 KA499DZy48Je4n/XaiBe+HkE=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0155740E016C;
	Fri,  8 Mar 2024 05:45:38 +0000 (UTC)
Date: Fri, 8 Mar 2024 06:45:32 +0100
From: Borislav Petkov <bp@alien8.de>
To: Changbin Du <changbin.du@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH] x86: kmsan: fix boot failure due to instrumentation
Message-ID: <20240308054532.GAZeql_HPGb5lAU-jx@fat_crate.local>
References: <20240308044401.1120395-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240308044401.1120395-1-changbin.du@huawei.com>

On Fri, Mar 08, 2024 at 12:44:01PM +0800, Changbin Du wrote:
> Instrumenting sev.c and mem_encrypt_identity.c with KMSAN will result in
> kernel being unable to boot. Some of the code are invoked too early in
> boot stage that before kmsan is ready.

How do you trigger this?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

