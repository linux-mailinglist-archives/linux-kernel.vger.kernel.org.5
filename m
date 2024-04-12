Return-Path: <linux-kernel+bounces-143034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF198A3373
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2D2281F55
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BB2148311;
	Fri, 12 Apr 2024 16:15:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A6C5491F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938534; cv=none; b=qUdJtBUo7QGcpCIER7Pfv4YBQohMJ9AkJjFwZSr+4OzAVxX9lgyXxXlm2/vp1PD9dTXvMM2BDx9FLTzRf9g99FqfIwHSFeFWXV4S4L+2va37HcdbniLhbTTyT0MaqV0MIVMSd44kw3NjDN11QTO5rQnyCZg26WmjlqUg39W86kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938534; c=relaxed/simple;
	bh=RLLZ17jVN1alxxjXE6arvEgnN2U+UxV8RZqw9BhEzqc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbK8G6x2GZE/kd2e2PH68P6NbSfKeTpu6EmDuAqIoNJ5U6oM9/Ie1ogUdM3FipWXfImENwL7mQHwGOfcUrQ2Zs+BALyxsNWVJdgFf/DOX+1atKmaB+uyn3woMdNK2KRdp0dtIxXsgIQWReoaHx28ZY43BDXKMdqe61qfWFjBMF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0CFC113CC;
	Fri, 12 Apr 2024 16:15:33 +0000 (UTC)
Date: Fri, 12 Apr 2024 12:15:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Prasad Pandit <pjp@fedoraproject.org>, Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [GIT PULL] tracing: Fixes for v6.9
Message-ID: <20240412121531.24669544@gandalf.local.home>
In-Reply-To: <CAHk-=wgw2NW5tar-Xew614JZPKfyTdet5fC0mgwK+2sUsZ0Ekw@mail.gmail.com>
References: <20240412103204.453d912c@gandalf.local.home>
	<CAHk-=wgw2NW5tar-Xew614JZPKfyTdet5fC0mgwK+2sUsZ0Ekw@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 09:07:18 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 12 Apr 2024 at 07:29, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > - Replace bad tab with space in Kconfig for FTRACE_RECORD_RECURSION_SIZE  
> 
> Argh. What parser is this? We need to fix this craziness.
> 
> Yes, yes, we have "tabs and spaces" issues due to the fundamental
> brokenness of make, and we can't get rid of *that* bogosity.
> 
> But for our own Kconfig files? Whitespace is whitespace (ignoring
> crazy unicode extensions), we need to get away from "tabs and spaces
> act differently".

Note, the tab is here:

-	default	128
+	default 128
               ^

That is, the tab was between "default" and "128".

I'm really agnostic to if we care about it, and was questioning about
taking it or not. But, it looks to be a hidden tab in a weird location,
so I took it.

-- Steve
 

