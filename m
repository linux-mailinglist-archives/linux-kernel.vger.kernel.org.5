Return-Path: <linux-kernel+bounces-45104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FF6842BBE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5B11F2BBB1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A63D15696D;
	Tue, 30 Jan 2024 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HxuFVXGg"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F856DD1B;
	Tue, 30 Jan 2024 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639153; cv=none; b=TWlqvSpxnWTBoS+TKM17m9MWQtQhmPcwDkO1lzgVTk6yqHz/T8q/uHGsiR6MTANLBVXLGtc5Yy08kqlf/9uWd6oCJo3OeTIdAqH80uCn6R0zt1yzxCDd9wmiHJHjYfO2Vpen4Lea7SEWZQFyod6+rEpbGXyM7G7DijnYeEOatjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639153; c=relaxed/simple;
	bh=vZWDvNFjFevC2Yb6vMfMSXRpw54Y8RK4U7bXN9t4w+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXiZxlzmwBdCJii5zyQStxitJtiQRYMp/TdcfeZUd93vQYX+iFDfLRR53bQfKW2YjxToiCuCmfbJPl3Rra/jHz7hAN4qsEtb9vrj+W9MfxhX6tkq7Vzr9+l+4SEhWwHaX2KdzrnsJB4GD9jdZwMuporV4ADDwd2LtiuTA5KvzAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HxuFVXGg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-4OLSCEK. (c-76-135-27-212.hsd1.wa.comcast.net [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id 451E420B2000;
	Tue, 30 Jan 2024 10:25:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 451E420B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706639151;
	bh=Rpth7rsHr70sL6wVt2F6eYm5Krae9Q97xEz+QLp/QmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HxuFVXGggvKj0uRZw2JrJ5tEadyeziDMM/q20nUE1x8WJs+E7SK29gXmelND+5kHa
	 FdIqUvLgr/BV3kW5rtOtiE4edYQSU0C5cuKPTzLGJh35T625P2ZACB2hUwjPpFFFv2
	 Zzw+f4HmWOfhCzAGhFpAEnUogH/TaRDoNsG40ayg=
Date: Tue, 30 Jan 2024 10:25:49 -0800
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH 0/4] tracing/user_events: Introduce multi-format events
Message-ID: <20240130182549.GC827-beaub@linux.microsoft.com>
References: <20240123220844.928-1-beaub@linux.microsoft.com>
 <20240130110933.32c9aa0eceff2f0f917affd1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130110933.32c9aa0eceff2f0f917affd1@kernel.org>

On Tue, Jan 30, 2024 at 11:09:33AM +0900, Masami Hiramatsu wrote:
> Hi Beau,
> 
> On Tue, 23 Jan 2024 22:08:40 +0000
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > Currently user_events supports 1 event with the same name and must have
> > the exact same format when referenced by multiple programs. This opens
> > an opportunity for malicous or poorly thought through programs to
> > create events that others use with different formats. Another scenario
> > is user programs wishing to use the same event name but add more fields
> > later when the software updates. Various versions of a program may be
> > running side-by-side, which is prevented by the current single format
> > requirement.
> > 
> > Add a new register flag (USER_EVENT_REG_MULTI_FORMAT) which indicates
> > the user program wishes to use the same user_event name, but may have
> > several different formats of the event in the future. When this flag is
> > used, create the underlying tracepoint backing the user_event with a
> > unique name per-version of the format. It's important that existing ABI
> > users do not get this logic automatically, even if one of the multi
> > format events matches the format. This ensures existing programs that
> > create events and assume the tracepoint name will match exactly continue
> > to work as expected. Add logic to only check multi-format events with
> > other multi-format events and single-format events to only check
> > single-format events during find.
> 
> Thanks for this work! This will allow many instance to use the same
> user-events at the same time.
> 
> BTW, can we force this flag set by default? My concern is if any user
> program use this user-event interface in the container (maybe it is
> possible if we bind-mount it). In this case, the user program can
> detect the other program is using the event if this flag is not set.
> Moreover, if there is a malicious program running in the container,
> it can prevent using the event name from other programs even if it
> is isolated by the name-space.
> 

The multi-format use a different system name (user_events_multi). So you
cannot use the single-format flag to detect multi-format names, etc. You
can only use it to find other single-format names like you could always do.

Likewise, you cannot use the single-event flag to block or prevent
multi-format events from being created.

Changing this behavior to default would break all of our environments.
So I'm pretty sure it would break others. The current environment
expects tracepoints to show up as their registered name under the
user_events system name. If this changed out from under us on a specific
kernel version, that would be bad.

I'd like eventually to have a tracer namespace concept for containers.
Then we would have a user_event_group per tracer namespace. Then all
user_events within the container have a unique system name which fully
isolates them. However, even with that isolation, we still need a way to
allow programs in the same container to have different versions of the
same event name.

Multi-format events fixes this problem. I think isolation should be
dealt with via true namespace isolation at the tracing level.

> Steve suggested that if a user program which is running in a namespace
> uses user-event without this flag, we can reject that by default.
> 
> What would you think about?
> 

This would break all of our environments. It would make previously
compiled programs using the existing ABI from working as expected.

I'd much prefer that level of isolation to happen at the namespace level
and why user_events as plumbing for different groups to achieve this.
It's also why the ABI does not allow programs to state a system name.
I'm trying to reserve the system name for the group/tracer/namespace
isolation work.

Thanks,
-Beau

> Thank you,
> 
> 
> > 
> > Add a register_name (reg_name) to the user_event struct which allows for
> > split naming of events. We now have the name that was used to register
> > within user_events as well as the unique name for the tracepoint. Upon
> > registering events ensure matches based on first the reg_name, followed
> > by the fields and format of the event. This allows for multiple events
> > with the same registered name to have different formats. The underlying
> > tracepoint will have a unique name in the format of {reg_name}:[unique_id].
> > The unique_id is the time, in nanoseconds, of the event creation converted
> > to hex. Since this is done under the register mutex, it is extremely
> > unlikely for these IDs to ever match. It's also very unlikely a malicious
> > program could consistently guess what the name would be and attempt to
> > squat on it via the single format ABI.
> > 
> > For example, if both "test u32 value" and "test u64 value" are used with
> > the USER_EVENT_REG_MULTI_FORMAT the system would have 2 unique
> > tracepoints. The dynamic_events file would then show the following:
> >   u:test u64 count
> >   u:test u32 count
> > 
> > The actual tracepoint names look like this:
> >   test:[d5874fdac44]
> >   test:[d5914662cd4]
> > 
> > Deleting events via "!u:test u64 count" would only delete the first
> > tracepoint that matched that format. When the delete ABI is used all
> > events with the same name will be attempted to be deleted. If
> > per-version deletion is required, user programs should either not use
> > persistent events or delete them via dynamic_events.
> > 
> > Beau Belgrave (4):
> >   tracing/user_events: Prepare find/delete for same name events
> >   tracing/user_events: Introduce multi-format events
> >   selftests/user_events: Test multi-format events
> >   tracing/user_events: Document multi-format flag
> > 
> >  Documentation/trace/user_events.rst           |  23 +-
> >  include/uapi/linux/user_events.h              |   6 +-
> >  kernel/trace/trace_events_user.c              | 224 +++++++++++++-----
> >  .../testing/selftests/user_events/abi_test.c  | 134 +++++++++++
> >  4 files changed, 325 insertions(+), 62 deletions(-)
> > 
> > 
> > base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
> > -- 
> > 2.34.1
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

