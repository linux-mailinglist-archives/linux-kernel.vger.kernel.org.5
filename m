Return-Path: <linux-kernel+bounces-45084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E970842B87
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01F11F26711
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DC7157056;
	Tue, 30 Jan 2024 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Pt21Sxs6"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF691552EC;
	Tue, 30 Jan 2024 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706638477; cv=none; b=VmtVxDNmOGYxolnoVZQNFblTKAgMEUi6OYbFdeEhdgrhAap7DB0KXp+RgvQXgCXGMuc/Yp/hkeXv+eBsjxc1vVfgodhAxj0aQPHilGIipEL15hSzVdQs3TY+/TRDBLf6d9TFG8AUk0MAkQi9Nr3mqPWchzwHtuMjA6nHaoyTfx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706638477; c=relaxed/simple;
	bh=FmOTcDYkN0aegLs81VJGLogVhcJ/Xf0gVSm/L+TmVdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGjJEwqUwiqWmGDF5KKkTAOwXh5gE2UPEJvxMIM7XgVo1KKg1E7Aj2INy7teffA8xZUMttNY1CYT3nlQDwAP4+zKKJv5ZcSgF5PfdXrAJ1wZaVQ4+tnWgK64/K9VEmp8uDfuUGdPJXuNkBTn34mitNhsHeOzoly9m+I+7OAaVfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Pt21Sxs6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-4OLSCEK. (c-76-135-27-212.hsd1.wa.comcast.net [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id D4A6F20B2000;
	Tue, 30 Jan 2024 10:14:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D4A6F20B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706638475;
	bh=JN16uiIf/4cLJ/Dw3JU5WgDwDBiOHGFcVXJaToRNsQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pt21Sxs6WdLY/cpJ5eodRDIv2riGetPSgmw665jfm5VwwVaiBcTRG2KctUCOfz77q
	 O5G1vCMFuCYaFQ26s/YD8FGcfIRerAeX1ZTySJsW59s3a8VUZkzYUO7EnanDXhb7OR
	 DHbv+5dwtuAgEqEKjFYBrDm3EV9AYGm5L8fXWyF4=
Date: Tue, 30 Jan 2024 10:14:34 -0800
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH 2/4] tracing/user_events: Introduce multi-format events
Message-ID: <20240130181434.GB827-beaub@linux.microsoft.com>
References: <20240123220844.928-1-beaub@linux.microsoft.com>
 <20240123220844.928-3-beaub@linux.microsoft.com>
 <20240127000104.7c98b34d295747ab1b084bd2@kernel.org>
 <20240126191007.GA456-beaub@linux.microsoft.com>
 <20240126150445.71c5d426@gandalf.local.home>
 <20240129172907.GA444-beaub@linux.microsoft.com>
 <20240130231222.1ff0777d13f6179ce4ada91f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130231222.1ff0777d13f6179ce4ada91f@kernel.org>

On Tue, Jan 30, 2024 at 11:12:22PM +0900, Masami Hiramatsu wrote:
> On Mon, 29 Jan 2024 09:29:07 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > On Fri, Jan 26, 2024 at 03:04:45PM -0500, Steven Rostedt wrote:
> > > On Fri, 26 Jan 2024 11:10:07 -0800
> > > Beau Belgrave <beaub@linux.microsoft.com> wrote:
> > > 
> > > > > OK, so the each different event has suffixed name. But this will
> > > > > introduce non C-variable name.
> > > > > 
> > > > > Steve, do you think your library can handle these symbols? It will
> > > > > be something like "event:[1]" as the event name.
> > > > > Personally I like "event.1" style. (of course we need to ensure the
> > > > > user given event name is NOT including such suffix numbers)
> > > > >   
> > > > 
> > > > Just to clarify around events including a suffix number. This is why
> > > > multi-events use "user_events_multi" system name and the single-events
> > > > using just "user_events".
> > > > 
> > > > Even if a user program did include a suffix, the suffix would still get
> > > > appended. An example is "test" vs "test:[0]" using multi-format would
> > > > result in two tracepoints ("test:[0]" and "test:[0]:[1]" respectively
> > > > (assuming these are the first multi-events on the system).
> > > > 
> > > > I'm with you, we really don't want any spoofing or squatting possible.
> > > > By using different system names and always appending the suffix I
> > > > believe covers this.
> > > > 
> > > > Looking forward to hearing Steven's thoughts on this as well.
> > > 
> > > I'm leaning towards Masami's suggestion to use dots, as that won't conflict
> > > with special characters from bash, as '[' and ']' do.
> > > 
> > 
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
> If we use dot for the suffix number, we can prohibit user to use it
> for their name. They still can use '_' (or change the group name?)

We could, however, we have user_event integration in OpenTelemetry and
I'm unsure if we should really try to restrict names. We'll also at some
point have libside integration, which might not have the same
restrictions on the user-tracer side as the kernel-tracer side.

I'm trying to restrict the user_event group name from changing outside
of an eventual tracer namespace. I'd like for each container to inherit
a tracer namespace long-term which decides what the actual group name
will be instead of users self-selecting names to prevent squatting or
spoofing of events.

> I just concerned that the name can be parsed by existing tools. Since
> ':' is used as a separator for group and event name in some case (e.g.
> tracefs "set_event" is using, so trace-cmd and perf is using it.)
> 

Good point.

What about just event_name[unique_id]? IE: Drop the colon.

Brackets are still special in bash, but it would prevent simple glob
patterns from matching to incorrect tracepoints under user_events_multi.

> > While a glob of "Asserts.[0-9]" works when the unique ID is 0-9, it
> > doesn't work if the number is higher, like 128. If we ever decide to
> > change the ID from an integer to say hex to save space, these globs
> > would break.
> 
> Hmm, why can't we use regexp?

We can use regex, but we'll need to agree the suffix format. We won't be
able to change it after that point. I'd prefer a base-16/Hex suffix
either in brackets or a simple dot.

> And if we limits the number of events up to 1000 for each same-name event
> we can use fixed numbers, like Assets.[0-9][0-9][0-9]
> 

I'm always wrong when I guess how many events programs will end up
using. Folks always surprise me. I'd rather have a solution that scales
to the max number of tracepoints allowed on the system (currently 16-bit
max value).

Thanks,
-Beau

> Thank you,
> 
> > 
> > Is there some scheme that fits the C-variable name that addresses the
> > above scenarios? Brackets gave me a simple glob that seemed to prevent a
> > lot of this ("Asserts.\[*\]" in this case).
> > 
> > Are we confident that we always want to represent the ID as a base-10
> > integer vs a base-16 integer? The suffix will be ABI to ensure recording
> > programs can find their events easily.
> > 
> > Thanks,
> > -Beau
> > 
> > > -- Steve
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

