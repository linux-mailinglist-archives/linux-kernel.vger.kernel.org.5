Return-Path: <linux-kernel+bounces-167028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C9C8BA394
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C9A2B22317
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143021C2A5;
	Thu,  2 May 2024 22:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ikwLYOCy"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132E08462;
	Thu,  2 May 2024 22:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714690739; cv=none; b=g5E0vMGTQiQkkxx3QIOUdSmWGUqLso0VnV83oooZm8ssrTc+8VzuWjqGl0C8iwuGFJqWRb6AKFKOUZjGtJ6UOZifzyEZWnEZ6nxiIyxYlAaNKsIckSsyZBOD8amN1bB9FSUomA07T4xOKawhH1JF1P4kq23vbVx12fEwfKWP3ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714690739; c=relaxed/simple;
	bh=msiYPhRQUtilTo+LztaXAxLX2WPR5Z/zWMXsElHb7sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9lZogMEkUmcBtTiRk5G6LP+huit9kMf/ev0Lm7HDQ2+caX/Awlp0a6BrIKGB8ip3+9WDp1DT9j6K3RZvIi2mHfMHSZZAXlo/iqOWassvYnxNBWjqYLY4TmvQ0AEQW/RknHBK1CIYcev6suAV8+ST6yFBBRE0GJmMjEe9WDn2/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ikwLYOCy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-4OLSCEK. (c-76-135-27-212.hsd1.wa.comcast.net [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id 894C320B2C80;
	Thu,  2 May 2024 15:58:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 894C320B2C80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714690737;
	bh=2AET+xUdNmbcmeb9M+8cahTXAm+h2fHVKotlqfP/yns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ikwLYOCyD9f9Tzajwbed8pjsLgmHenZuAkIBXLuNw325n+JT4VZUwZYdz/EP+s8TB
	 +GrQuqdUgIpQnceUJZ2S1fyPj+WctugwVDnZ/i9H9Yfx43lT/WdTbJCAHHQBk1RzZt
	 dcBS0rK7D9MvVo4saK3e9VBW8Ih2BZe0u+fCdLCk=
Date: Thu, 2 May 2024 15:58:53 -0700
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	dcook@linux.microsoft.com
Subject: Re: [PATCH v2 1/2] tracing/user_events: Fix non-spaced field matching
Message-ID: <20240502225853.GA412-beaub@linux.microsoft.com>
References: <20240423162338.292-1-beaub@linux.microsoft.com>
 <20240423162338.292-2-beaub@linux.microsoft.com>
 <20240502171634.7e2ac794@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502171634.7e2ac794@gandalf.local.home>

On Thu, May 02, 2024 at 05:16:34PM -0400, Steven Rostedt wrote:
> On Tue, 23 Apr 2024 16:23:37 +0000
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
> I'm curious, what happens if you have: "u8 field1; u8 field2;" ?
> 

You'll get an extra whitespace during the copy, assuming it was really:
"u8 field1;u8 field2"

If it had spaces, this code wouldn't run.

> Do you care? As you will then create "u8 field1; u8 field2; "
> 
> but I'm guessing the extra whitespace at the end doesn't affect anything.
> 

Right, you get an extra byte allocated, but the argv_split() with ignore
it. The compare will work correctly (I've verified this just now to
double check).

IE these all match:
"Test u8 a; u8 b; "
"Test u8 a; u8 b;"
"Test u8 a; u8 b"

> 
> > 
> > Fixes: ba470eebc2f6 ("tracing/user_events: Prevent same name but different args event")
> > Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> > ---
> >  kernel/trace/trace_events_user.c | 76 +++++++++++++++++++++++++++++++-
> >  1 file changed, 75 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> > index 70d428c394b6..82b191f33a28 100644
> > --- a/kernel/trace/trace_events_user.c
> > +++ b/kernel/trace/trace_events_user.c
> > @@ -1989,6 +1989,80 @@ static int user_event_set_tp_name(struct user_event *user)
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
> 
> This will count that "..;" 
> 
> This is most likely not an issue, but since I didn't see this case
> anywhere, I figured I bring it up just to confirm that it's not an issue.
> 

It's not an issue on the matching/logic. However, you do get an extra
byte alloc (which doesn't bother me in this edge case).

Thanks,
-Beau

> -- Steve
> 
> 
> > +	}
> > +
> > +	return count;
> > +}
> > +
> > +/*
> > + * Copies the arguments while ensuring all ';' have a trailing space.
> > + */
> > +static char *insert_space_after_semis(char *args, int count)
> > +{
> > +	char *fixed, *pos;
> > +	int len;
> > +
> > +	len = strlen(args) + count;
> > +	fixed = kmalloc(len + 1, GFP_KERNEL);
> > +
> > +	if (!fixed)
> > +		return NULL;
> > +
> > +	pos = fixed;
> > +
> > +	/* Insert a space after ';' if there is no trailing space. */
> > +	while (*args) {
> > +		*pos = *args++;
> > +
> > +		if (*pos++ == ';' && !isspace(*args))
> > +			*pos++ = ' ';
> > +	}
> > +
> > +	*pos = '\0';
> > +
> > +	return fixed;
> > +}
> > +

