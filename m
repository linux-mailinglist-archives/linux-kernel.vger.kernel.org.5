Return-Path: <linux-kernel+bounces-154065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F8C8AD6C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83DC71C218FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEC21CF8D;
	Mon, 22 Apr 2024 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dmoMk287"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B8D1C6B7;
	Mon, 22 Apr 2024 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713822933; cv=none; b=kpgepxlxwXjoUK58Wa8GB8tRV+bArIgqusshfbbLiiR9tihgQYkWH4BiOVK+0tniHV3jnHxTaWuHDpH+75WiqAHqjrb1y96Iv3Tu4VT5/GnCQXGpyeB7u6pppW0xLjTFBW89qADxbqltbGBVp9/E4YuuGeqUGMTiIVb19TB6X8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713822933; c=relaxed/simple;
	bh=3xmBOAd4rAwvNYraXzGNP4fsO6olJYEcsGJF88jD4+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rV9YEMSgjEwtDxHykBJ4d4J+h59+19QJGnkygmrHCpSLTw3Z+D0IuetCH7pkfye4iNKP65l3vgkvDVxS5JqU6D+v2GdKS1k+G2ONlsCTPLkC9sfkfFTbG2a4Wm3Tcsv/IRugVJjsgGVedVblhXFZ3h97xYwMU9DbFNRyh5rhl58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dmoMk287; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-4OLSCEK. (c-76-135-27-212.hsd1.wa.comcast.net [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id EB16E20FEEDC;
	Mon, 22 Apr 2024 14:55:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EB16E20FEEDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713822930;
	bh=2zy+tbncAFDWlBF6RA+BWmpw8Cfn5+oaU2yF3bMryfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmoMk2873jJAimjjwRt0flmlHZIfEq0Heico/zajNUUhOfoKSari8Fpb6fPVghRW2
	 bn5nHCs2d6FUM4nmmh1F507aVKNqFBChvFxqcoNXlVA53MEqIUuLfJR9TGCEjNL+Vy
	 0bp1Ob4Z0Vi5X4FXLFvtA+25SCv4ONA+jSjIwEVg=
Date: Mon, 22 Apr 2024 14:55:25 -0700
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	dcook@linux.microsoft.com
Subject: Re: [PATCH 1/2] tracing/user_events: Fix non-spaced field matching
Message-ID: <20240422215525.GA414-beaub@linux.microsoft.com>
References: <20240416224102.734-1-beaub@linux.microsoft.com>
 <20240416224102.734-2-beaub@linux.microsoft.com>
 <20240419113305.7b0ae2b11395eec16b5c15b6@kernel.org>
 <20240419211334.GA7774-beaub@linux.microsoft.com>
 <20240420215052.1f806c8acb5f99ec2f63945c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420215052.1f806c8acb5f99ec2f63945c@kernel.org>

On Sat, Apr 20, 2024 at 09:50:52PM +0900, Masami Hiramatsu wrote:
> On Fri, 19 Apr 2024 14:13:34 -0700
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > On Fri, Apr 19, 2024 at 11:33:05AM +0900, Masami Hiramatsu wrote:
> > > On Tue, 16 Apr 2024 22:41:01 +0000
> > > Beau Belgrave <beaub@linux.microsoft.com> wrote:

*SNIP*

> > > nit: This loop can be simpler, because we are sure fixed has enough length;
> > > 
> > > /* insert a space after ';' if there is no space. */
> > > while(*args) {
> > > 	*pos = *args++;
> > > 	if (*pos++ == ';' && !isspace(*args))
> > > 		*pos++ = ' ';
> > > }
> > > 
> > 
> > I was worried that if count_semis_no_space() ever had different logic
> > (maybe after this commit) that it could cause an overflow if the count
> > was wrong, etc.
> > 
> > I don't have an issue making it shorter, but I was trying to be more on
> > the safe side, since this isn't a fast path (event register).
> 
> OK, anyway current code looks correct. But note that I don't think
> "pos++; len--;" is safer, since it is not atomic. This pattern
> easily loose "len--;" in my experience. So please carefully use it ;)
> 

I'll stick with your loop. Perhaps others will chime in on the v2 and
state a stronger opinion.

You scared me with the atomic comment, I went back and looked at all the
paths for this. In the user_events IOCTL the buffer is copied from user
to kernel, so it cannot change (and no other threads access it). I also
checked trace_parse_run_command() which is the same. So at least in this
context the non-atomic part is OK.

> > 
> > > > +
> > > > +	/*
> > > > +	 * len is the length of the copy excluding the null.
> > > > +	 * This ensures we always have room for a null.
> > > > +	 */
> > > > +	*pos = '\0';
> > > > +
> > > > +	return fixed;
> > > > +}
> > > > +
> > > > +static char **user_event_argv_split(char *args, int *argc)
> > > > +{
> > > > +	/* Count how many ';' without a trailing space */
> > > > +	int count = count_semis_no_space(args);
> > > > +
> > > > +	if (count) {
> > > 
> > > nit: it is better to exit fast, so 
> > > 
> > > 	if (!count)
> > > 		return argv_split(GFP_KERNEL, args, argc);
> > > 
> > > 	...
> > 
> > Sure, will fix in a v2.
> > 
> > > 
> > > Thank you,
> > > 
> > > OT: BTW, can this also simplify synthetic events?
> > > 
> > 
> > I'm not sure, I'll check when I have some time. I want to get this fix
> > in sooner rather than later.
> 
> Ah, nevermind. Synthetic event parses the field by strsep(';') first
> and argv_split(). So it does not have this issue.
> 

Ok, seems unrelated. Thanks for checking.

Thanks,
-Beau

> Thank you,
> 
> > 
> > Thanks,
> > -Beau
> > 

*SNIP* 

> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

