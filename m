Return-Path: <linux-kernel+bounces-141833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD468A240D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C6A4B2403E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17E115AF1;
	Fri, 12 Apr 2024 02:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyiiGp2p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F55B14A9D;
	Fri, 12 Apr 2024 02:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890676; cv=none; b=fXHgIFY7dGH6ftHTOr7VNvjoqKfKWYGGx4SG5wpTSuIgqdT9BK4O/wKGj6hI0VhJ6pqxMIEhvzZjIQcSgC3Kx/UkHSIBOvPkXwqKXRKcXdCOJ3V178Iv0zJv2z7aTlxeuC55XLNbCx3SNqRlQ1SMG27aXNSl/k2bOlOWuU2d4tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890676; c=relaxed/simple;
	bh=EWY7NwFu2yfGSK5ePAZnvH/Heip/hmb52AXqPb4qHM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfmxnlIR65aXfFkbWefy3lbw3OQuNdAluDWNnioGReZclO9KEbXwi0tTI9+OuTxFe61bUXdM5bhwNkUHm2gnQ+01XTDpv32x4YVu1TXJxOol6FicSdFQg71NRfcQ+DsuLOlS2OfVKI8t7cSeXu9FU0BNoXE2zCqhBPrOKLP1u6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyiiGp2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A38C072AA;
	Fri, 12 Apr 2024 02:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712890675;
	bh=EWY7NwFu2yfGSK5ePAZnvH/Heip/hmb52AXqPb4qHM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jyiiGp2pS+/hvFq9t6MCd6w2NhaQVa7yYfK4a951hR5h1AvpMQvDWTQc+CDifT8M9
	 Q+24peRwHlPclRNN15xiQ8ro2C1QkgKjxxQC2aRPch7La2uvTkdskGNXJ/lA56Rd2j
	 IWshPS0NgjD9YKyYaPn9+b5eSBsgO0ma5vTIW/2WA6QpkeauVed2FF/KrcEuNHL12R
	 zGIsh02aBUVGzJmROWCjrNtxB2hwSD6kFYXhsdDGqZ7Q9sVdEGLU93jSMjl4rkZeIV
	 FoJmPWP56DzpzVVUc0wEKoGofR8jrynOAiKofx2/esl4EJ8alIx2vlkll0AwhlhB57
	 TCgKw9f0cLZlQ==
Date: Thu, 11 Apr 2024 21:57:53 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bug 218665 - nohz_full=0 prevents kernel from booting
Message-ID: <7kugx5ivbplwwrcq5zp37djtpakl55b3pfy36gpbsbcx43dpcs@uheu6iv7gm7h>
References: <5be248c6-cdda-4d2e-8fae-30fc2cc124c0@leemhuis.info>
 <enqg6mcuhvff7gujjbapdiclicl3z6f2vnggcsg65pexipyr3o@4men5fhyt3vb>
 <28c84b3b-f68f-4f45-8da1-9c3f9a342509@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28c84b3b-f68f-4f45-8da1-9c3f9a342509@leemhuis.info>

On Wed, Apr 10, 2024 at 11:18:04AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 08.04.24 00:52, Bjorn Andersson wrote:
> > On Tue, Apr 02, 2024 at 10:17:16AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> >>
> >> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> >> kernel developers don't keep an eye on it, I decided to forward it by mail.
> >>
> >> Tejun, apparently it's cause by a change of yours.
> >>
> >> Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
> >> not CCed them in mails like this.
> >>
> >> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=218665 :
> >>
> >>> booting the current kernel (6.9.0-rc1, master/712e1425) on x86_64
> >>> with nohz_full=0 cause a page fault and prevents the kernel from
> >>> booting.
> > [...]
> > In addition to this report, I have finally bisected another regression
> > to the same commit:
> > 
> > I start neovim, send SIGSTOP (i.e. ^Z) to it, start another neovim
> > instance and upon sending SIGSTOP to that instance all of userspace
> > locks up - 100% reproducible.
> > 
> > The kernel seems to continue to operate, and tapping the power button
> > dislodge the lockup and I get a clean shutdown.
> > 
> > This is seen on multiple Arm64 (Qualcomm) machines with upstream
> > defconfig since commit '5797b1c18919 ("workqueue: Implement system-wide
> > nr_active enforcement for unbound workqueues")'.
> 
> Hmmm, I had hoped Tejun would reply and share an opinion if these
> problems are related. But that didn't happen. :-/ So let me at least ask
> one question that might help to answer that question: is the machine
> using CPU isolation, like the two other reports about problems caused by
> this commit do (see the
> https://bugzilla.kernel.org/show_bug.cgi?id=218665 and
> https://lore.kernel.org/all/20240402105847.GA24832@redhat.com/ for
> details) ?
> 

No, this is a clean SMP system running stock arch/arm64/defconfig,
booted with "clk_ignore_unused pd_ignore_unused audit=0" as the command
line.

Regards,
Bjorn

