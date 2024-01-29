Return-Path: <linux-kernel+bounces-43199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B97D18410BE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75990284B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7230C3F9EC;
	Mon, 29 Jan 2024 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="G1lxcQKb"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FE076C61;
	Mon, 29 Jan 2024 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706549354; cv=none; b=FPy9k5Agwj2qqkLTlJPI3Y8CBFEuCBORfghB9VInUABATbNULrNrB+uf6rzn0mNiwpEH+vXWQjbFnFczbG81aj/hUwp/P9dZ8Wm1Aj9Iz3GfoHRg0Kz0Ns/JuS6OgFlhdUblVUcL+GiPQo8pIAZpO2aylsgkdgn1iEDXMskiX7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706549354; c=relaxed/simple;
	bh=W3XWPZGSMK3fE0uF5C5Gi8zDVvbzMbUonqOccKnW2rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZhg5v9LAh+slFVXdes3IxJO8ZoV2EvR/3UhMpHlPV/b22rv5Jo6g8A1MkBpANyrDQ0HpDLb+AEdTFGrzHiM2sS/4DDufoo4SoDT7Qg1Aw5NmgLH1B3dPscSkbH0IcPXAfWVcc0paAUVP7wHY5/Q/zcEZ0hIbF5XdrAmSy9AAJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=G1lxcQKb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-4OLSCEK. (c-76-135-27-212.hsd1.wa.comcast.net [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id B97DB22FF43D;
	Mon, 29 Jan 2024 09:29:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B97DB22FF43D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706549352;
	bh=q31WO/M6IYddLDiJtANlwh/aklgHuYZf/tuCYhTXQ8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G1lxcQKbs+avBaj80Oh/7rqajGWEFByV9TKhO4EFGjb5gJ/SW437ytLFggwrMbWNo
	 EBFx0gvFy+D/GM/PXA300msfbl5aJwrGie0cwIYS5CuDuSujGcvF3oSCK1hQGYd9ge
	 GDFjMuhv2jAyI6lAdWdX67Pzqw1mz3BOkUuSSMAM=
Date: Mon, 29 Jan 2024 09:29:07 -0800
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH 2/4] tracing/user_events: Introduce multi-format events
Message-ID: <20240129172907.GA444-beaub@linux.microsoft.com>
References: <20240123220844.928-1-beaub@linux.microsoft.com>
 <20240123220844.928-3-beaub@linux.microsoft.com>
 <20240127000104.7c98b34d295747ab1b084bd2@kernel.org>
 <20240126191007.GA456-beaub@linux.microsoft.com>
 <20240126150445.71c5d426@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126150445.71c5d426@gandalf.local.home>

On Fri, Jan 26, 2024 at 03:04:45PM -0500, Steven Rostedt wrote:
> On Fri, 26 Jan 2024 11:10:07 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > > OK, so the each different event has suffixed name. But this will
> > > introduce non C-variable name.
> > > 
> > > Steve, do you think your library can handle these symbols? It will
> > > be something like "event:[1]" as the event name.
> > > Personally I like "event.1" style. (of course we need to ensure the
> > > user given event name is NOT including such suffix numbers)
> > >   
> > 
> > Just to clarify around events including a suffix number. This is why
> > multi-events use "user_events_multi" system name and the single-events
> > using just "user_events".
> > 
> > Even if a user program did include a suffix, the suffix would still get
> > appended. An example is "test" vs "test:[0]" using multi-format would
> > result in two tracepoints ("test:[0]" and "test:[0]:[1]" respectively
> > (assuming these are the first multi-events on the system).
> > 
> > I'm with you, we really don't want any spoofing or squatting possible.
> > By using different system names and always appending the suffix I
> > believe covers this.
> > 
> > Looking forward to hearing Steven's thoughts on this as well.
> 
> I'm leaning towards Masami's suggestion to use dots, as that won't conflict
> with special characters from bash, as '[' and ']' do.
> 

Thanks, yeah ideally we wouldn't use special characters.

I'm not picky about this. However, I did want something that clearly
allowed a glob pattern to find all versions of a given register name of
user_events by user programs that record. The dot notation will pull in
more than expected if dotted namespace style names are used.

An example is "Asserts" and "Asserts.Verbose" from different programs.
If we tried to find all versions of "Asserts" via glob of "Asserts.*" it
will pull in "Asserts.Verbose.1" in addition to "Asserts.0".

While a glob of "Asserts.[0-9]" works when the unique ID is 0-9, it
doesn't work if the number is higher, like 128. If we ever decide to
change the ID from an integer to say hex to save space, these globs
would break.

Is there some scheme that fits the C-variable name that addresses the
above scenarios? Brackets gave me a simple glob that seemed to prevent a
lot of this ("Asserts.\[*\]" in this case).

Are we confident that we always want to represent the ID as a base-10
integer vs a base-16 integer? The suffix will be ABI to ensure recording
programs can find their events easily.

Thanks,
-Beau

> -- Steve

