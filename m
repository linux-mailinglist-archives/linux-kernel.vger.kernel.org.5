Return-Path: <linux-kernel+bounces-40544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5061983E239
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82CB31C238AA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711DC224C6;
	Fri, 26 Jan 2024 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="X3pu4LWW"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B022231C;
	Fri, 26 Jan 2024 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706296221; cv=none; b=s3kAAfFFz3l9OWFVhwwveYojIe/E0C4skJY0u/4QVx70NglfX2krAflayLgv9xIWtz1DGyh/8MNyC84lWfpH0lY8m02FwC1C+3e61xIJFGmZFR+qOp3EnfgKnMJ33P5U6GB+rOPlPcXoDStVvzPrnr/lcnl5MPIrrNv2HaszWpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706296221; c=relaxed/simple;
	bh=aW6eWLtmmX6YBORvMLvv3MYshij8bwLypxui5L9zDGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbiAETN7zg1SkV82K2aLnIxLuTywwsyHBrSBYOFNsiOCSebMX/V1ad7CIoq7Do22/MYBnvyjeuWZ8ny3Xm7jBarHNDSsIrCNuYCFgltGWPWnmWItLpKWeNEZXsLF1S54zXdJFmHxPbER3pEBiecaqG3fRC4xw16twtSNNTCv6zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=X3pu4LWW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-4OLSCEK. (c-76-135-27-212.hsd1.wa.comcast.net [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id DF88520E581B;
	Fri, 26 Jan 2024 11:10:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DF88520E581B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706296214;
	bh=Ms9WYGIYUF/XcjRBI9ktWLM55RsEg8t32K1qCIFBxys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X3pu4LWWXPtrMPje2r4p0Jawh81lbXu+TkUXUPWw8Zmu3q749hXmA2cf3ec/qDirE
	 w6TqfcREQymPL1/nNq+dVJw8jF53aUCJ9EpMeuET3kiKGmf8/A3flW0JPAeyavke1R
	 kDx++7GqH9Kek1YflPXdBa+EJ1apXL89mdEj3v2M=
Date: Fri, 26 Jan 2024 11:10:07 -0800
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH 2/4] tracing/user_events: Introduce multi-format events
Message-ID: <20240126191007.GA456-beaub@linux.microsoft.com>
References: <20240123220844.928-1-beaub@linux.microsoft.com>
 <20240123220844.928-3-beaub@linux.microsoft.com>
 <20240127000104.7c98b34d295747ab1b084bd2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127000104.7c98b34d295747ab1b084bd2@kernel.org>

On Sat, Jan 27, 2024 at 12:01:04AM +0900, Masami Hiramatsu wrote:
> On Tue, 23 Jan 2024 22:08:42 +0000
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > Add a register_name (reg_name) to the user_event struct which allows for
> > split naming of events. We now have the name that was used to register
> > within user_events as well as the unique name for the tracepoint. Upon
> > registering events ensure matches based on first the reg_name, followed
> > by the fields and format of the event. This allows for multiple events
> > with the same registered name to have different formats. The underlying
> > tracepoint will have a unique name in the format of {reg_name}:[unique_id].
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
> > Both would be under the new user_events_multi system name to prevent the
> > older ABI from being used to squat on multi-formatted events and block
> > their use.
> [...]
> > @@ -1923,6 +1972,39 @@ static int user_event_trace_register(struct user_event *user)
> >  	return ret;
> >  }
> >  
> > +static int user_event_set_tp_name(struct user_event *user)
> > +{
> > +	lockdep_assert_held(&user->group->reg_mutex);
> > +
> > +	if (EVENT_MULTI_FORMAT(user->reg_flags)) {
> > +		char *multi_name;
> > +		int len;
> > +
> > +		len = snprintf(NULL, 0, "%s:[%llx]", user->reg_name,
> > +			       user->group->multi_id) + 1;
> > +
> > +		multi_name = kzalloc(len, GFP_KERNEL_ACCOUNT);
> > +
> > +		if (!multi_name)
> > +			return -ENOMEM;
> > +
> > +		snprintf(multi_name, len, "%s:[%llx]", user->reg_name,
> > +			 user->group->multi_id);
> 
> OK, so the each different event has suffixed name. But this will
> introduce non C-variable name.
> 
> Steve, do you think your library can handle these symbols? It will
> be something like "event:[1]" as the event name.
> Personally I like "event.1" style. (of course we need to ensure the
> user given event name is NOT including such suffix numbers)
> 

Just to clarify around events including a suffix number. This is why
multi-events use "user_events_multi" system name and the single-events
using just "user_events".

Even if a user program did include a suffix, the suffix would still get
appended. An example is "test" vs "test:[0]" using multi-format would
result in two tracepoints ("test:[0]" and "test:[0]:[1]" respectively
(assuming these are the first multi-events on the system).

I'm with you, we really don't want any spoofing or squatting possible.
By using different system names and always appending the suffix I
believe covers this.

Looking forward to hearing Steven's thoughts on this as well.

Thanks,
-Beau

> Thank you.
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

