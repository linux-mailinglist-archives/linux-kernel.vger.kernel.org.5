Return-Path: <linux-kernel+bounces-43611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E0E8416A7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94BD0287268
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A21E524C7;
	Mon, 29 Jan 2024 23:15:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C6B51C4B;
	Mon, 29 Jan 2024 23:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706570119; cv=none; b=oTO0IziK4Cs1AcBxroK486tWuSE7ken16wgwDVMsOaKvGUzV7tjbDw4fpGDTt71zyQQBKzBPF3Z0dHSJcU5ZohEFN+Qw/L7ndQ7d6nBOYBcW+P2FdCxR+CvTfGoXzfu2paYlLEmIyHIxZVmuOoMcmeTMUijGOb1VZ5h1yxFK8JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706570119; c=relaxed/simple;
	bh=gR27Qkt/D00rT1UvrX2VsvQIp//4zeSKmy026dIcPSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rd4CMkfN+rCdxvsq/j34crhJZFiGsIvwgqrvyrWg8bSZdbsedLpXOfwnYR3+BrvI8f4BNbRhbjYbXNpYoR4tapaP/0lEetIxYpi1pMu6KsldocFGXjxvdqaTMlTyDyXmcItb3EV/27KvZeriSpeWEpEPiRRYOQqr1r5Z91Z3nTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270D0C433F1;
	Mon, 29 Jan 2024 23:15:18 +0000 (UTC)
Date: Mon, 29 Jan 2024 18:15:28 -0500
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
Message-ID: <20240129181528.2aa5e39f@gandalf.local.home>
In-Reply-To: <20240129174732.1cea0d69@gandalf.local.home>
References: <202401291043.e62e89dc-oliver.sang@intel.com>
	<CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
	<20240129120125.605e97af@gandalf.local.home>
	<CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
	<CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
	<CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
	<20240129152600.7587d1aa@gandalf.local.home>
	<CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
	<20240129172200.1725f01b@gandalf.local.home>
	<CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
	<20240129174732.1cea0d69@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 17:47:32 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > And I hope there aren't any other stupid things I missed like that.  
> 
> Well the preliminary tests pass with this added to your patch:

Spoke too soon. The later tests started failing.

It fails on creating a kprobe, deleting it, and then recreating it. Even
though the directory is there, it can't be accessed.

 # cd /sys/kernel/tracing

// Create a kprobe

 # echo 'p:sched schedule' >> kprobe_events 
 # ls events/kprobes/
enable  filter  sched

// Now delete the kprobe

 # echo '-:sched schedule' >> kprobe_events

// Make sure it's gone

 # ls events/kprobes/
ls: cannot access 'events/kprobes/': No such file or directory

// Recreate it

 # echo 'p:sched schedule' >> kprobe_events 
 # ls events/kprobes/
ls: cannot access 'events/kprobes/': No such file or directory
 # ls events | grep kprobes
kprobes

No longer able to access it.

 # ls -l events | grep kprobes
ls: cannot access 'events/kprobes': No such file or directory
d????????? ? ?    ?    ?            ? kprobes


-- Steve

