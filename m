Return-Path: <linux-kernel+bounces-108940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5431488124B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99B51F249C2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003D64315B;
	Wed, 20 Mar 2024 13:26:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8969D42067;
	Wed, 20 Mar 2024 13:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710941198; cv=none; b=kdsmjGMbBQZFVci918cMkjvx1k5taWNfPHvOX0FiTdMd0cq1gnrnx8Exebj7/JG9VGcPnxExwGhisO1X3SzcogSqHxrN2j0JZp2fVyxrYnVBQXXnWJ17tZYCHLhqsXKctmwDWIxd3E2JHp42iBu17sjdFtDqkC6o9JUr83xh7lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710941198; c=relaxed/simple;
	bh=pCGuVjWlRAi0vFh0p3CgV+1RcpDoThiqGVZ0AmE/iGw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLhc1gdarFBygc4QY5CkbtXBeN9oHfsSxftptqpmQMqezWxIt/VJczv/RT1Nx0o/22hD6/jDmWSxSTunI5beLowDC7mdtkRCbQrBr3bpxNxLvO/c35DhZVlBw+XDhlQFIvbWiqmwdEAx6uA2QXztwD8dpOQWDsESRVqaT/pjAN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF63C43390;
	Wed, 20 Mar 2024 13:26:37 +0000 (UTC)
Date: Wed, 20 Mar 2024 09:29:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [GIT PULL] tracing/tools: Updates for 6.9
Message-ID: <20240320092902.0840c87a@gandalf.local.home>
In-Reply-To: <20f9d90e-454e-448c-989d-84900d380561@kernel.org>
References: <20240318174116.420584-1-bristot@kernel.org>
	<20240319190259.0086706f@gandalf.local.home>
	<20f9d90e-454e-448c-989d-84900d380561@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Mar 2024 13:41:12 +0100
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> On 3/20/24 00:02, Steven Rostedt wrote:
> > On Mon, 18 Mar 2024 18:41:13 +0100
> > Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> >   
> >> Steven,
> >>
> >> Tracing tooling updates for 6.9
> >>
> >> Tracing:
> >>         - Update makefiles for latency-collector and RTLA,
> >>           using tools/build/ makefiles like perf does, inheriting
> >>           its benefits. For example, having a proper way to
> >>           handle dependencies.
> >>
> >>         - The timerlat tracer has an interface for any tool to use.
> >>           rtla timerlat tool uses this interface dispatching its
> >>           own threads as workload. But, rtla timerlat could also be
> >>           used for any other process. So, add 'rtla timerlat -U'
> >>           option, allowing the timerlat tool to measure the latency of
> >>           any task using the timerlat tracer interface.
> >>
> >> Verification:
> >>         - Update makefiles for verification/rv, using tools/build/
> >>           makefiles like perf does, inheriting its benefits.
> >>           For example, having a proper way to handle dependencies.
> >>
> >>
> >> Please pull the latest trace-tools-v6.9 tree, which can be found at:
> >>
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/bristot/linux.git
> >> trace-tools-v6.9  
> > 
> > Looks like you just built on top of a random commit from Linus's tree:  
> 
> yeah :-/
> 
> > commit f6cef5f8c37f58a3bc95b3754c3ae98e086631ca
> > Merge: 906a93befec8 8f06fb458539
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Sun Mar 17 16:59:33 2024 -0700
> > 
> >     Merge tag 'i3c/for-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux
> > 
> > Linus prefers basing off of real tags or previous pulls from us.  
> 
> Ack, took note. I will do on top v6.8 tag.
> 
> > Can you rebase your changes on v6.8 and resend?
> > 
> >   $ git checkout v6.8
> >   $ git cherry-pick f6cef5f8c37f58a3bc95b3754c3ae98e086631ca..trace-tools-v6.9
> > 
> > Appears to work fine.  
> 
> questions: when something go wrong in a pull request....
> 
> 	- Should I keep the old tag, and then do another one with -2
> 	  (it seems you do like this), or delete the old tag and send it again
> 	  with the same name?

Just create a new tag.

> 
> 	- Should I resend the PULL request with something in the log or
> 	  at the Subject saying it is a v2 of the pull request?

Yes please.

> 
> I could ask via chat, but I think it is good for the community to
> have access to these info.

+1

Thanks,


-- Steve

