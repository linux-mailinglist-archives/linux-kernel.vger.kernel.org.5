Return-Path: <linux-kernel+bounces-43534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4B584153A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4571C23D1C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E858158D64;
	Mon, 29 Jan 2024 21:45:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D49F266D4;
	Mon, 29 Jan 2024 21:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706564714; cv=none; b=p63+eq8wMuvzSZaeHm+0PnrIgYp0W1OksOhPVqJ0QnSP/zsyTsJfw4s/o9M9cVX/VR+QtNXsNjqKzd5h3g3yox2vohemkbwJZ8mswzjHESXEmiWG5is11BEBjOMCHIzmQhy9hI8SXiNvzPVlw8LCHZg2m7bVX//A++KhciUenJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706564714; c=relaxed/simple;
	bh=yY4xF0kLqIPE63javcYLHfeIRhob7wmKoaWeIExeS1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XN1/ocxtadsahfo0WCJgHU3zTYWBY/Va6j2TOtSAtoPqED38443IsNebmYlxf105A/wPV63Awy+xn+SgXSz0Iye2U5Kx1jlwnxAVrA0Yxi50gOI38OmSrStIfooNcGxi0MwolJ5EK8WOcxTLf3KGrQcacxXZiz33vM2J/6I53nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A19BC433F1;
	Mon, 29 Jan 2024 21:45:12 +0000 (UTC)
Date: Mon, 29 Jan 2024 16:45:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner
 <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher
 <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [linus:master] [eventfs] 852e46e239:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <20240129164522.72482faa@gandalf.local.home>
In-Reply-To: <CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
References: <202401291043.e62e89dc-oliver.sang@intel.com>
	<CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
	<20240129120125.605e97af@gandalf.local.home>
	<CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
	<CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
	<CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
	<20240129152600.7587d1aa@gandalf.local.home>
	<CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 12:51:59 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> End result: what simple_lookup() does is say "oh, you didn't have the
> file, so it's by definition a negative dentry", and thus all it does
> is to do "d_add(dentry, NULL)".
> 
> Anyway, removing this was painful. I initially thought "I'll just
> remove the calls". But it all ended up cascading into "that's also
> wrong".
> 
> So now I have a patch that tries to fix this all up, and it looks like thisL:
> 
>  1 file changed, 50 insertions(+), 219 deletions(-)

Thanks, much appreciated.

> 
> because it basically removed all the old code, and replaced it with
> much simpler code.
> 
> I'm including the patch here as an attachment, but I want to note very
> clearly that this *builds* for me, and it looks a *lot* more obvious
> and correct than the old code did, but I haven't tested it. AT ALL.

I'm going to stare at them as I test them. Because I want to understand
them. I may come back with questions.

> 
> Also note that it depends on my previous patches, so I guess I'll
> include them here again just to make it unambiguous.
> 
> Finally - this does *not* fix up the refcounting. I still think the
> SRCU stuff is completely broken. But that's another headache. But at
> least now the *lookup* parts look like they DTRT wrt eventfs_mutex.
> 
> The SRCU logic from the directory iteration parts still needs crapectomy.

I think the not dropping the mutex lock lets me get rid of the SRCU. I
added the SRCU when I was hitting the deadlocks with the iput code which
I'm not hitting anymore. So getting rid of the SRCU shouldn't be hard.

> 
> AGAIN: these patches (ie particularly that last one - 0004) were all
> done entirely "blindly" - I've looked at the code, and fixed the bugs
> and problems I've seen by pure code inspection.
> 
> That's great, but it really means that it's all untested. It *looks*
> better than the old code, but there may be some silly gotcha that I
> have missed.

I'll let you know. 

Oh, does b4 handle attachments? Because this breaks the patchwork flow.
I haven't used b4 yet.

Thanks,

-- Steve

