Return-Path: <linux-kernel+bounces-105382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C2687DD1C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 13:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162A01F2124F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 12:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E6C1BC30;
	Sun, 17 Mar 2024 12:14:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36A51B94F
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710677688; cv=none; b=l6GzYMlp8DYYuPEzcR1979LuR7iveMfwWwuBSfSlZThZ8SSyO1u0gaGLRk6poW7yDZmOhgaoYXtKpd560WXIdfFbcIuwnb1LYJrDRlOAgoaNHpXEBJvKbLvyTi+zMNZtd/fiPUAyjbNoV/+s91KFzSn4McNBS1hUcoXWMfp/HWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710677688; c=relaxed/simple;
	bh=+fA4uD8TXCCWit+FaH43kOV1sKlYA5kCHMWzBPZz3vI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3URx6b2KtYN/xkzcRfIJCgSPVcXtEpZIdEevRtD/O66CYnzmDoVRl4u5lYnbndrNcqZfQz3+2I666y7aHpPBoWARg8T7ajXbU3AGaZo+I43AC26vc77z488p9Q8p20WzT05q0EP8tJFQLBX/R+JRDPiV28EcFNk3vf4WrXUmvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32A4C433C7;
	Sun, 17 Mar 2024 12:14:46 +0000 (UTC)
Date: Sun, 17 Mar 2024 08:14:44 -0400
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
Message-ID: <20240317081444.189fa238@rorschach.local.home>
In-Reply-To: <CAHk-=wgKJti5WBi7VmA_ETDiXjmkEqvVW7De5ajwtkyJ=c==kA@mail.gmail.com>
References: <20240315122934.1d3231ce@gandalf.local.home>
	<CAHk-=wg24KPFfeNwYdsD0e79MP4QhO3VaWkh0buPSD0M=141xQ@mail.gmail.com>
	<CAHk-=wh5wWeib7+kVHpBVtUn7kx7GGadWqb5mW5FYTdewEfL=w@mail.gmail.com>
	<20240316142002.7480d74b@rorschach.local.home>
	<CAHk-=wgKJti5WBi7VmA_ETDiXjmkEqvVW7De5ajwtkyJ=c==kA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Mar 2024 11:42:42 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, 16 Mar 2024 at 11:20, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > 1) Rebase without them (I know how much you love rebasing)  
> 
> This.
> 
> Except honestly, the pulls are getting to be so complicated for me
> because I have to check them, that I'd really like you to start doing
> topic branches for individual things.
> 

We started doing that (with the trace probes and tools). But sure, I
can make a few more topic branches.

> 
> Do you have to do it for the current situation where I just can't take
> the mmap stuff? No. But please look at it going forward.

Since I had to do a rebase, I'm rebasing it off of the last pull you
did from me for some fixes that didn't make it into 6.8. That way it
will include the fix in your tree that I need to add the string checks
for the TRACE_EVENT() __assign_str() and __string() checks.

I'm testing everything now.

-- Steve

