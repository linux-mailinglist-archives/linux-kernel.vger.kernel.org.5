Return-Path: <linux-kernel+bounces-151965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D888AB64D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1015281EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDA3376F1;
	Fri, 19 Apr 2024 21:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cuEjqFg4"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8EF10A2C;
	Fri, 19 Apr 2024 21:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713561222; cv=none; b=B/0NdNEsE69S4AaMEHfXmHDK2wP0T05RaALW7oKV++rp+sOuhxmUftp6q4EMoD4q0GUBlmCeq7GLNTbqY6UdvTfV+nnjEVN2bfVxfFex+gQvlZRrd8SYMzZHK54Amh45MUkkp+mAEd1272XRVGSO9isCgt7CwV7t4D7SlzWso5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713561222; c=relaxed/simple;
	bh=oIcZefAdb+coatM174ij1LdSIN84ZaCFeDnUlLrqGXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU/LZ5BGQZByleJCiq9T6LljevPEcgpYBNYqDpUv6RmAQKDCi6KnQ9prZiOUIFuKhTpQSVnsOTjvw+Ie/qo8677cRQTba9pYGsqezemLCxzKIibSytDaKBsrecfvil/IQyCVWVKq+ERZGWU/dA+d+X/bB6HPw6eNbx1ZL1MKIKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cuEjqFg4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-4OLSCEK. (c-76-135-27-212.hsd1.wa.comcast.net [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id C44D620FDC4B;
	Fri, 19 Apr 2024 14:13:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C44D620FDC4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713561220;
	bh=XE0uXoNgtxaWLEQbxNxQNdOcqHe9iSSF1gbTqedCfmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cuEjqFg4dJDkNgNbzNK76wVSFkgIGMb3iAw//dEEgp9GwYszBB9YeKAONXAKwQrIE
	 ZbXNd419UkKbywo2Fbm6yYUuTKOcM7iHmgNqrMAKnYecX/dVbMhJ1jQ52xra354K77
	 KhBHDRu/QjWB+xGPxU5igmsVJAEiIVLHN107LPek=
Date: Fri, 19 Apr 2024 14:13:34 -0700
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	dcook@linux.microsoft.com
Subject: Re: [PATCH 1/2] tracing/user_events: Fix non-spaced field matching
Message-ID: <20240419211334.GA7774-beaub@linux.microsoft.com>
References: <20240416224102.734-1-beaub@linux.microsoft.com>
 <20240416224102.734-2-beaub@linux.microsoft.com>
 <20240419113305.7b0ae2b11395eec16b5c15b6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419113305.7b0ae2b11395eec16b5c15b6@kernel.org>

On Fri, Apr 19, 2024 at 11:33:05AM +0900, Masami Hiramatsu wrote:
> On Tue, 16 Apr 2024 22:41:01 +0000
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > When the ABI was updated to prevent same name w/different args, it
> > missed an important corner case when fields don't end with a space.
> > Typically, space is used for fields to help separate them, like
> > "u8 field1; u8 field2". If no spaces are used, like
> > "u8 field1;u8 field2", then the parsing works for the first time.
> > However, the match check fails on a subsequent register, leading to
> > confusion.
> > 
> > This is because the match check uses argv_split() and assumes that all
> > fields will be split upon the space. When spaces are used, we get back
> > { "u8", "field1;" }, without spaces we get back { "u8", "field1;u8" }.
> > This causes a mismatch, and the user program gets back -EADDRINUSE.
> > 
> > Add a method to detect this case before calling argv_split(). If found
> > force a space after the field separator character ';'. This ensures all
> > cases work properly for matching.
> > 
> > With this fix, the following are all treated as matching:
> > u8 field1;u8 field2
> > u8 field1; u8 field2
> > u8 field1;\tu8 field2
> > u8 field1;\nu8 field2
> 
> Sounds good to me. I just have some nits.
> 
> > 
> > Fixes: ba470eebc2f6 ("tracing/user_events: Prevent same name but different args event")
> > Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> > ---
> >  kernel/trace/trace_events_user.c | 88 +++++++++++++++++++++++++++++++-
> >  1 file changed, 87 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> > index 70d428c394b6..9184d3962b2a 100644
> > --- a/kernel/trace/trace_events_user.c
> > +++ b/kernel/trace/trace_events_user.c
> > @@ -1989,6 +1989,92 @@ static int user_event_set_tp_name(struct user_event *user)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Counts how many ';' without a trailing space are in the args.
> > + */
> > +static int count_semis_no_space(char *args)
> > +{
> > +	int count = 0;
> > +
> > +	while ((args = strchr(args, ';'))) {
> > +		args++;
> > +
> > +		if (!isspace(*args))
> > +			count++;
> > +	}
> > +
> > +	return count;
> > +}
> > +
> > +/*
> > + * Copies the arguments while ensuring all ';' have a trailing space.
> > + */
> > +static char *fix_semis_no_space(char *args, int count)
> 
> nit: This name does not represent what it does. 'insert_space_after_semis()'
> is more self-described.
> 

Sure, will fix in a v2.

> > +{
> > +	char *fixed, *pos;
> > +	char c, last;
> > +	int len;
> > +
> > +	len = strlen(args) + count;
> > +	fixed = kmalloc(len + 1, GFP_KERNEL);
> > +
> > +	if (!fixed)
> > +		return NULL;
> > +
> > +	pos = fixed;
> > +	last = '\0';
> > +
> > +	while (len > 0) {
> > +		c = *args++;
> > +
> > +		if (last == ';' && !isspace(c)) {
> > +			*pos++ = ' ';
> > +			len--;
> > +		}
> > +
> > +		if (len > 0) {
> > +			*pos++ = c;
> > +			len--;
> > +		}
> > +
> > +		last = c;
> > +	}
> 
> nit: This loop can be simpler, because we are sure fixed has enough length;
> 
> /* insert a space after ';' if there is no space. */
> while(*args) {
> 	*pos = *args++;
> 	if (*pos++ == ';' && !isspace(*args))
> 		*pos++ = ' ';
> }
> 

I was worried that if count_semis_no_space() ever had different logic
(maybe after this commit) that it could cause an overflow if the count
was wrong, etc.

I don't have an issue making it shorter, but I was trying to be more on
the safe side, since this isn't a fast path (event register).

> > +
> > +	/*
> > +	 * len is the length of the copy excluding the null.
> > +	 * This ensures we always have room for a null.
> > +	 */
> > +	*pos = '\0';
> > +
> > +	return fixed;
> > +}
> > +
> > +static char **user_event_argv_split(char *args, int *argc)
> > +{
> > +	/* Count how many ';' without a trailing space */
> > +	int count = count_semis_no_space(args);
> > +
> > +	if (count) {
> 
> nit: it is better to exit fast, so 
> 
> 	if (!count)
> 		return argv_split(GFP_KERNEL, args, argc);
> 
> 	...

Sure, will fix in a v2.

> 
> Thank you,
> 
> OT: BTW, can this also simplify synthetic events?
> 

I'm not sure, I'll check when I have some time. I want to get this fix
in sooner rather than later.

Thanks,
-Beau

> > +		/* We must fixup 'field;field' to 'field; field' */
> > +		char *fixed = fix_semis_no_space(args, count);
> > +		char **split;
> > +
> > +		if (!fixed)
> > +			return NULL;
> > +
> > +		/* We do a normal split afterwards */
> > +		split = argv_split(GFP_KERNEL, fixed, argc);
> > +
> > +		/* We can free since argv_split makes a copy */
> > +		kfree(fixed);
> > +
> > +		return split;
> > +	}
> > +
> > +	/* No fixup is required */
> > +	return argv_split(GFP_KERNEL, args, argc);
> > +}
> > +
> >  /*
> >   * Parses the event name, arguments and flags then registers if successful.
> >   * The name buffer lifetime is owned by this method for success cases only.
> > @@ -2012,7 +2098,7 @@ static int user_event_parse(struct user_event_group *group, char *name,
> >  		return -EPERM;
> >  
> >  	if (args) {
> > -		argv = argv_split(GFP_KERNEL, args, &argc);
> > +		argv = user_event_argv_split(args, &argc);
> >  
> >  		if (!argv)
> >  			return -ENOMEM;
> > -- 
> > 2.34.1
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

