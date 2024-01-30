Return-Path: <linux-kernel+bounces-44735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5233E8426B4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4ED5285C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAF46DCFB;
	Tue, 30 Jan 2024 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBgKF1ie"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC8A6D1DB;
	Tue, 30 Jan 2024 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706623947; cv=none; b=Be6UtPMwxfPwQMTTYQHvH0MgsCk1Za1uG0k9REVus5XNmTKbSUPNPLXvURAlpNm1RbELLJWgSmAktuiFOb7QrvFIT2HIVFfiEs5O1onXUwQpxwG2QNJUUA4ky+dC3RnCJe4U1cDs/W9o+csIBTfz94JeOhg2FnAHxhNX7/R6Apw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706623947; c=relaxed/simple;
	bh=V1d6QnJih+bl/9yZ7PYqfSpDrBSlonUiSAcEhRy++04=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=F+2jdMIHiiGo0DG/8ZooS1XlqJJf6Wu/09Hu9hWBdjiM041K0alcepwzyQZ0vjnsnwDG178YW185apXPZgU2A8gQYHuZrgB53C/rkNsXBm014BdAoUepG3JgLYCHurP963NdrfThw2kf2RCGawB1AgezXkPbrhW6GxfV7Ay7tZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBgKF1ie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B393C433F1;
	Tue, 30 Jan 2024 14:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706623946;
	bh=V1d6QnJih+bl/9yZ7PYqfSpDrBSlonUiSAcEhRy++04=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KBgKF1iesVD7dHytxhDJzUvob9bKwNFiKD4xxQIZKRTvm8MP6mHAbTIV7WeFEHgaM
	 suV8USZbVs81ycIPNBHXRgsnylcMONOhtcj/WpDF7dTG+IA8P/WuysjSnEutQUWgKb
	 5Iio6T27L69Hb98/SP0JLrauij9sP3ibXOlcci+myryz1vTauSt7l94E4CSjvHffe5
	 TcD5cbagkYTTimENli94EPX3BQfqcrpvGViA3zc2EEpXedYNTQJ8VFZuyTraS029Vy
	 F5O5/66BoRoXfW5lNvX+9khjsGs6bkG0FAboc9hec6oW+SLSJ6sMF7FZlBxzbwoJPD
	 /RR8KTbdmQsGA==
Date: Tue, 30 Jan 2024 23:12:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH 2/4] tracing/user_events: Introduce multi-format events
Message-Id: <20240130231222.1ff0777d13f6179ce4ada91f@kernel.org>
In-Reply-To: <20240129172907.GA444-beaub@linux.microsoft.com>
References: <20240123220844.928-1-beaub@linux.microsoft.com>
	<20240123220844.928-3-beaub@linux.microsoft.com>
	<20240127000104.7c98b34d295747ab1b084bd2@kernel.org>
	<20240126191007.GA456-beaub@linux.microsoft.com>
	<20240126150445.71c5d426@gandalf.local.home>
	<20240129172907.GA444-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 09:29:07 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> On Fri, Jan 26, 2024 at 03:04:45PM -0500, Steven Rostedt wrote:
> > On Fri, 26 Jan 2024 11:10:07 -0800
> > Beau Belgrave <beaub@linux.microsoft.com> wrote:
> > 
> > > > OK, so the each different event has suffixed name. But this will
> > > > introduce non C-variable name.
> > > > 
> > > > Steve, do you think your library can handle these symbols? It will
> > > > be something like "event:[1]" as the event name.
> > > > Personally I like "event.1" style. (of course we need to ensure the
> > > > user given event name is NOT including such suffix numbers)
> > > >   
> > > 
> > > Just to clarify around events including a suffix number. This is why
> > > multi-events use "user_events_multi" system name and the single-events
> > > using just "user_events".
> > > 
> > > Even if a user program did include a suffix, the suffix would still get
> > > appended. An example is "test" vs "test:[0]" using multi-format would
> > > result in two tracepoints ("test:[0]" and "test:[0]:[1]" respectively
> > > (assuming these are the first multi-events on the system).
> > > 
> > > I'm with you, we really don't want any spoofing or squatting possible.
> > > By using different system names and always appending the suffix I
> > > believe covers this.
> > > 
> > > Looking forward to hearing Steven's thoughts on this as well.
> > 
> > I'm leaning towards Masami's suggestion to use dots, as that won't conflict
> > with special characters from bash, as '[' and ']' do.
> > 
> 
> Thanks, yeah ideally we wouldn't use special characters.
> 
> I'm not picky about this. However, I did want something that clearly
> allowed a glob pattern to find all versions of a given register name of
> user_events by user programs that record. The dot notation will pull in
> more than expected if dotted namespace style names are used.
> 
> An example is "Asserts" and "Asserts.Verbose" from different programs.
> If we tried to find all versions of "Asserts" via glob of "Asserts.*" it
> will pull in "Asserts.Verbose.1" in addition to "Asserts.0".

If we use dot for the suffix number, we can prohibit user to use it
for their name. They still can use '_' (or change the group name?)
I just concerned that the name can be parsed by existing tools. Since
':' is used as a separator for group and event name in some case (e.g.
tracefs "set_event" is using, so trace-cmd and perf is using it.)

> While a glob of "Asserts.[0-9]" works when the unique ID is 0-9, it
> doesn't work if the number is higher, like 128. If we ever decide to
> change the ID from an integer to say hex to save space, these globs
> would break.

Hmm, why can't we use regexp?
And if we limits the number of events up to 1000 for each same-name event
we can use fixed numbers, like Assets.[0-9][0-9][0-9]

Thank you,

> 
> Is there some scheme that fits the C-variable name that addresses the
> above scenarios? Brackets gave me a simple glob that seemed to prevent a
> lot of this ("Asserts.\[*\]" in this case).
> 
> Are we confident that we always want to represent the ID as a base-10
> integer vs a base-16 integer? The suffix will be ABI to ensure recording
> programs can find their events easily.
> 
> Thanks,
> -Beau
> 
> > -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

