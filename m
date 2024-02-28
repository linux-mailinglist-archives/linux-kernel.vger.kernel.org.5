Return-Path: <linux-kernel+bounces-84332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AAF86A4FE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D9D2839A2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AC21CF8C;
	Wed, 28 Feb 2024 01:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAlVEy1e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83B81CD0A;
	Wed, 28 Feb 2024 01:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083617; cv=none; b=LHEEqlWiHG0803xHml+UZHzYTWpeDDKOb3YRAR9ncSv87MuldVO53i0BIpIaUCrCvMfU5wibUnfoVnrO8VnOLeUtzlMH1ccB8m0gOL2Np4BdXWf1rGsGH+G6oyAJLjBbWSMXXqfr1gXPia6bPDV8UwRFOi9cy5oNYisKtq0vtps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083617; c=relaxed/simple;
	bh=jfvtXPgUX/JEsGKhrw+3n0AvLdJo0qAYlqV0uQNpfa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lrx9ARresnq/h6Ty3F6EklXcmQ73gbGGLdrDPWrCkW/x8JBNrUWIjOoaQx0cjomq4+bWKS91WOCdCXYuR+I7S0KneFmOduykU9u4p+gK+4SRyh8Z2aZaRcRybA3JraYhhPJDsaHPzLhxXsy4aXfvLIp0JcFb66W3GGS6VEnWYL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAlVEy1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3957BC433F1;
	Wed, 28 Feb 2024 01:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709083617;
	bh=jfvtXPgUX/JEsGKhrw+3n0AvLdJo0qAYlqV0uQNpfa8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=CAlVEy1eVtZgVS8tjEsadAFmuoMrx+IVdzp4i2c9TJ1mne9p1SI9LG55q4Op6he25
	 0HKro4bIRTW1oLORWcHHL7pJcHSgiItqyzSZV46rTyjcUf5Rp8X57BOQe5Qc+0k9eD
	 MK8Q4m3WINZbq46nc5PFmmjsMkunlK12W55oQG9e49midOSgCvYDys9LsiuXsiSiS1
	 UgWmkGZXIa8KintALXSbtH7f0rJq1HG7RpdT2sxIWMKTqo00hHSNepMoPbVwuyRVP3
	 zHyqj6fVPfw4IHmYfQOJ1lZAnjVjR/UDllla223TmUL7FxxcwFgLC8xVuZZYwDqeb2
	 BpFh8grTo9Veg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C5DF0CE098C; Tue, 27 Feb 2024 17:26:56 -0800 (PST)
Date: Tue, 27 Feb 2024 17:26:56 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	x86@kernel.org
Subject: Re: linux-next: duplicate patch in the rcu tree
Message-ID: <f95f6787-ed54-4b4d-afbc-30ed25bbf31f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240228120610.0fdd20af@canb.auug.org.au>
 <87jzmp8k1a.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzmp8k1a.ffs@tglx>

On Wed, Feb 28, 2024 at 02:17:05AM +0100, Thomas Gleixner wrote:
> On Wed, Feb 28 2024 at 12:06, Stephen Rothwell wrote:
> > The following commit is also in the tip tree as a different commit
> > (but the same patch):
> >
> >   020eee167cca ("x86/nmi: Fix "in NMI handler" check")
> >
> > This is commit
> >
> >   d54e56f31a34 ("x86/nmi: Fix the inverse "in NMI handler" check")
> >
> > in the tip tree.
> 
> And why the heck is the RCU tree carrying x86 specific stuff which has
> absolutely nothing to do with RCU?
> 
> Just because, right?

So I could test it.

In the future, I will keep such commits out of the portion of -rcu that
is sent to -next.  Apologies for slipping up this time.

							Thanx, Paul

