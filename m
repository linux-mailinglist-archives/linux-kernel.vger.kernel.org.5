Return-Path: <linux-kernel+bounces-45077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EB7842B71
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69E71F25C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605D6157E6B;
	Tue, 30 Jan 2024 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BCuWEm9r"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391F315697D;
	Tue, 30 Jan 2024 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706637922; cv=none; b=HO0cHsoAmhS8z/+JN/6/XScnbN7d9Unpk4V19XLXOPKsgPRaeXm+iKVw+xk/3OaDNQMLfE1WEsp1WhWVZWfxqshKYS2M8mRqkuPv4n/c0inhg7helWhQiJjqZjBx8WsbBoBJfZJg1PMkkvwB15ampuiMp7AzwzOLrAzVU500KXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706637922; c=relaxed/simple;
	bh=2AnwKBuZ0705w+TINWEJJ6bBO3TvbIc1slGogNTWOwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qq/FbHLo8Q+flmOkSlE0sijNBKjgokri+jyV3+OSaHucpIt5CDqaWlP+7DJsvfeXxZUcTGlG8+eyRhR9XO3dMlNDf+I6+SNr1oclzsjPGz/H9d6zgvIb8DaOgFQ4ErwX9SAHEzzysSLU5eoyXz21OdHLQ+3JcUxOUmw4AZREvyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BCuWEm9r; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-4OLSCEK. (c-76-135-27-212.hsd1.wa.comcast.net [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id ACDD42057C07;
	Tue, 30 Jan 2024 10:05:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ACDD42057C07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706637920;
	bh=MlNI8Snl+eLb0sO9+P8R2IgXBUmpuvIfc8yNSJ1AUYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BCuWEm9rrx+Ivy2BRBPHaAgnS38Luq/1oEnsC9/znmbypJPR+FvWxc4upfbdY3+Ti
	 8vdFroHAR3Fau3phiDjKoyxkbuIu8OHG19SDQv3K4nDQ1Nm2geXPkaK/alxEIgtlLw
	 NJG+wesQCsSxvF/gagJo/8Dsj22YzMhhloEOxA4Y=
Date: Tue, 30 Jan 2024 10:05:15 -0800
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH 2/4] tracing/user_events: Introduce multi-format events
Message-ID: <20240130180515.GA827-beaub@linux.microsoft.com>
References: <20240123220844.928-1-beaub@linux.microsoft.com>
 <20240123220844.928-3-beaub@linux.microsoft.com>
 <20240127000104.7c98b34d295747ab1b084bd2@kernel.org>
 <20240126191007.GA456-beaub@linux.microsoft.com>
 <20240126150445.71c5d426@gandalf.local.home>
 <20240129172907.GA444-beaub@linux.microsoft.com>
 <20240129212407.157a5533@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129212407.157a5533@gandalf.local.home>

On Mon, Jan 29, 2024 at 09:24:07PM -0500, Steven Rostedt wrote:
> On Mon, 29 Jan 2024 09:29:07 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > Thanks, yeah ideally we wouldn't use special characters.
> > 
> > I'm not picky about this. However, I did want something that clearly
> > allowed a glob pattern to find all versions of a given register name of
> > user_events by user programs that record. The dot notation will pull in
> > more than expected if dotted namespace style names are used.
> > 
> > An example is "Asserts" and "Asserts.Verbose" from different programs.
> > If we tried to find all versions of "Asserts" via glob of "Asserts.*" it
> > will pull in "Asserts.Verbose.1" in addition to "Asserts.0".
> 
> Do you prevent brackets in names?
> 

No. However, since brackets have a start and end token that are distinct
finding all versions of your event is trivial compared to a single dot.

Imagine two events:
Asserts
Asserts[MyCoolIndex]

Resolves to tracepoints of:
Asserts:[0]
Asserts[MyCoolIndex]:[1]

Regardless of brackets in the names, a simple glob of Asserts:\[*\] only
finds Asserts:[0]. This is because we have that end bracket in the glob
and the full event name including the start bracket.

If I register another "version" of Asserts, thne I'll have:
Asserts:[0]
Asserts[MyCoolIndex]:[1]
Asserts:[2]

The glob of Asserts:\[*\] will return both:
Asserts:[0]
Asserts:[2]

At this point the program can either record all versions or scan further
to find which version of Asserts is wanted.

> > 
> > While a glob of "Asserts.[0-9]" works when the unique ID is 0-9, it
> > doesn't work if the number is higher, like 128. If we ever decide to
> > change the ID from an integer to say hex to save space, these globs
> > would break.
> > 
> > Is there some scheme that fits the C-variable name that addresses the
> > above scenarios? Brackets gave me a simple glob that seemed to prevent a
> > lot of this ("Asserts.\[*\]" in this case).
> 
> Prevent a lot of what? I'm not sure what your example here is.
> 

I'll try again :)

We have 2 events registered via user_events:
Asserts
Asserts.Verbose

Using dot notation these would result in tracepoints of:
user_events_multi/Asserts.0
user_events_multi/Asserts.Verbose.1

Using bracket notation these would result in tracepoints of:
user_events_multi/Asserts:[0]
user_events_multi/Asserts.Verbose:[1]

A recording program only wants to enable the Asserts tracepoint. It does
not want to record the Asserts.Verbose tracepoint.

The program must find the right tracepoint by scanning tracefs under the
user_events_multi system.

A single dot suffix does not allow a simple glob to be used. The glob
Asserts.* will return both Asserts.0 and Asserts.Verbose.1.

A simple glob of Asserts:\[*\] will only find Asserts:[0], it will not
find Asserts.Verbose:[1].

We could just use brackets and not have the colon (Asserts[0] in this
case). But brackets are still special for bash.

> > 
> > Are we confident that we always want to represent the ID as a base-10
> > integer vs a base-16 integer? The suffix will be ABI to ensure recording
> > programs can find their events easily.
> 
> Is there a difference to what we choose?
> 

If a simple glob of event_name:\[*\] cannot be used, then we must document
what the suffix format is, so an appropriate regex can be created. If we
start with base-10 then later move to base-16 we will break existing regex
patterns on the recording side.

I prefer, and have in this series, a base-16 output since it saves on
the tracepoint name size.

Either way we go, we need to define how recording programs should find
the events they care about. So we must be very clear, IMHO, about the
format of the tracepoint names in our documentation.

I personally think recording programs are likely to get this wrong
without proper guidance.

Thanks,
-Beau

> -- Steve

