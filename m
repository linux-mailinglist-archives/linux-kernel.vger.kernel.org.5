Return-Path: <linux-kernel+bounces-105268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD3687DB39
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 19:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB54F281ACA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12AD1C695;
	Sat, 16 Mar 2024 18:20:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F1D1C684
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710613207; cv=none; b=a9/exS0iJ1QtYtbqAMqGL9PDyO0H/AArFpD6Qv6ofO6WHRnB57QjxfCTKkUIsXfS9EQC51Sl3IvNxq1mrktthE/pFImp8nDxGkbu3apD6zo/iMOL3/bTdnomRs3yggomvRodOAXIhveDYKhnCle7idZZA23fsqvKqMW5uz9yVik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710613207; c=relaxed/simple;
	bh=06+THI7XWuKGGgLhTsUilyeitLcdxYOnW2Qj20XE09Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=haSaZASy9BfgVyxry1PzreSFLR/TfXrq1bmaHr4yNBmg7rxS6YOKOEFkvqyAp1kblNkNWk8ONl+yMNOTsbssK9rj6jpc2AaOK2+Hp6u7dhJM/pAqBidyI4W1nI6xdBLroQuWi1gdyMrhkummNJiUAOYWUVimiEm8pE0W+vO6+T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6828CC433C7;
	Sat, 16 Mar 2024 18:20:05 +0000 (UTC)
Date: Sat, 16 Mar 2024 14:20:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Beau Belgrave <beaub@linux.microsoft.com>, Chengming Zhou
 <zhouchengming@bytedance.com>, Huang Yiwei <quic_hyiwei@quicinc.com>, John
 Garry <john.g.garry@oracle.com>, Randy Dunlap <rdunlap@infradead.org>,
 Thorsten Blum <thorsten.blum@toblux.com>, Vincent Donnefort
 <vdonnefort@google.com>, linke li <lilinke99@qq.com>, Daniel Bristot de
 Oliveira <bristot@redhat.com>
Subject: Re: [GIT PULL] tracing: Updates for v6.9
Message-ID: <20240316142002.7480d74b@rorschach.local.home>
In-Reply-To: <CAHk-=wh5wWeib7+kVHpBVtUn7kx7GGadWqb5mW5FYTdewEfL=w@mail.gmail.com>
References: <20240315122934.1d3231ce@gandalf.local.home>
	<CAHk-=wg24KPFfeNwYdsD0e79MP4QhO3VaWkh0buPSD0M=141xQ@mail.gmail.com>
	<CAHk-=wh5wWeib7+kVHpBVtUn7kx7GGadWqb5mW5FYTdewEfL=w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Mar 2024 09:59:57 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, 16 Mar 2024 at 09:31, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So instead of merging a new feature that was mis-designed and is
> > already having code working around its mis-design, I'm not merging it
> > at all.  
> 
> Here's a clue: when hacking up VFS code, ask for ACK's from the VFS people.
> 
> And when hacking up MM code, make damn sure that you have VM people involved.
> 
> No more of this "random code that happens to work in my tests"
> garbage. Yes, I'm sure that others have done this same disgusting page
> counting hack and this was copied-and-pasted from some other

I admit that this was taken from looking at how other code did it.

> disgusting source, but because of all the history, I'm now looking at
> tracing pulls arefully, and I'm simply not allowing any broken hacks.

That's pretty obvious.

> 
> So in addition to getting actual VM people to help you with mapping
> stuff (hard requirement), I would also suggest:
> 
>  - your allocation has to be live over the whole mmap (and that's due
> to other fundamental issues - you're not even trying to deal with
> actual dynamic allocations and thank Cthulhu for that), and the code
> is literally designed that way, so then faulting pages in one at a
> time and refcounting them one at a time is just pointless and wrong.
> Just do it all at mmap time.
> 
>  - I'd suggest marking it all VM_DONTCOPY | VM_IO | VM_DONTEXPAND to
> not let people play games with the mapping.
> 
>  - avoid all the sub-page ref-counts entirely by using VM_PFNMAP, and
> use vm_insert_pages()
> 
> and a random note:
> 
>  - from a TLB pressure standpoint, it might be a good idea to try to
> keep the page table entries naturally aligned, so putting that one
> status page at the beginning is likely a bad idea. It will typically
> mean that hardware that can silently use larger TLB entries for
> aligned pages won't be able to do so.

This is actually something that I wanted to do, but how much to
allocate was stored in that status page. I could easily make the status
page as big as the sub-buffers themselves so that everything is
naturally aligned. The status pages states how big it is.

> 
> but the effect of that is likely fairly small.

I'm not going to be able to get this done this week, but I don't want
the other changes not to be pulled. As the ring buffer mappings near
the beginning, what do you want me to do in the mean time?

1) Rebase without them (I know how much you love rebasing)

2) revert the entire series.

3) Just make it disabled.

-- Steve


