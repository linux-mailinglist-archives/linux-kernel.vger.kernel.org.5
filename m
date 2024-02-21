Return-Path: <linux-kernel+bounces-75147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B6285E3D0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBCF11F21AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA3183CA2;
	Wed, 21 Feb 2024 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="tGwfON4L"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8803A7FBC4;
	Wed, 21 Feb 2024 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534577; cv=none; b=Q+k1+eHlSXC4Smhq0S/Wyqfuaoces4Y/HwVcUTD5bHlyCKbmEPp0ob1K1PQZLRQUwYlxtodo3ce52hlERUiuQkcKAblklTOZJ+cy1dsRJGVavjIwSBPCYuNN0+ZiKbk7Se/WfZejCPwke3fFjuq59UyjqLvcbsDA8cx/F9Menqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534577; c=relaxed/simple;
	bh=4NtW4aeUxD/AmECNuJyVZrOaIfeQcVURpE8RzhY/Eic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuk2b0VgMvIbc8BUEshY3TQha8StHIpTFqwqwH8b2j8A9auwug2J6RiD4VD6eDKHEhGgRN3EWYFdela0BJnVO4nyaEDJ+Cifbzy6Nop74daW1MPAyMMXHwXV/Gl3jc4ib7gm7yFALtPc1M2cvHjW/MTcXjC4Dcm+McLmRWxM430=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=tGwfON4L; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-4OLSCEK. (c-76-135-27-212.hsd1.wa.comcast.net [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1409A20B2000;
	Wed, 21 Feb 2024 08:56:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1409A20B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708534576;
	bh=3WQ3mLec9Jebwe3nros1Bu7UOMPeSwJ2ljwzi0xUrEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tGwfON4LA6b6vj30oKVfHe0c1NRyJXrBbMRCVNX6aj/Rx/W9MaIPU33YOUHIh9u2t
	 fyoQYoKW3cJoUSPpkTmlLoj41Be/zgkcgwK2mGgvY6Rz+HTMu69iSKGKF6t52fy1S3
	 c/E8uF68fx1kWSxQ9/coQqKdY5xoCqygUbyLaikI=
Date: Wed, 21 Feb 2024 08:56:13 -0800
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v3 2/4] tracing/user_events: Introduce multi-format events
Message-ID: <20240221165613.GB441-beaub@linux.microsoft.com>
References: <20240214175046.240-1-beaub@linux.microsoft.com>
 <20240214175046.240-3-beaub@linux.microsoft.com>
 <20240221100833.1eb5c254@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221100833.1eb5c254@gandalf.local.home>

On Wed, Feb 21, 2024 at 10:08:33AM -0500, Steven Rostedt wrote:
> On Wed, 14 Feb 2024 17:50:44 +0000
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > +static char *user_event_group_system_multi_name(void)
> > +{
> > +	char *system_name;
> > +	int len = sizeof(USER_EVENTS_MULTI_SYSTEM) + 1;
> 
> FYI, the sizeof() will include the "\0" so no need for "+ 1", but I don't
> think this matters as for what I mention below.
> 
> > +
> > +	system_name = kmalloc(len, GFP_KERNEL);
> > +
> > +	if (!system_name)
> > +		return NULL;
> > +
> > +	snprintf(system_name, len, "%s", USER_EVENTS_MULTI_SYSTEM);
> > +
> > +	return system_name;
> 
> Hmm, the above looks like an open coded version of:
> 
> 	system_name = kstrdup(USER_EVENTS_MULTI_SYSTEM, GFP_KERNEL);
> 

That's much cleaner, I'll move to that.

> 
> > +}
> > +
> >  static struct user_event_group *current_user_event_group(void)
> >  {
> >  	return init_group;
> > @@ -367,6 +390,11 @@ static struct user_event_group *user_event_group_create(void)
> >  	if (!group->system_name)
> >  		goto error;
> >  
> > +	group->system_multi_name = user_event_group_system_multi_name();
> > +
> > +	if (!group->system_multi_name)
> > +		goto error;
> > +
> >  	mutex_init(&group->reg_mutex);
> >  	hash_init(group->register_table);
> >  
> > @@ -1482,6 +1510,11 @@ static int destroy_user_event(struct user_event *user)
> >  	hash_del(&user->node);
> >  
> >  	user_event_destroy_validators(user);
> > +
> > +	/* If we have different names, both must be freed */
> > +	if (EVENT_NAME(user) != EVENT_TP_NAME(user))
> > +		kfree(EVENT_TP_NAME(user));
> > +
> >  	kfree(user->call.print_fmt);
> >  	kfree(EVENT_NAME(user));
> >  	kfree(user);
> > @@ -1504,12 +1537,24 @@ static struct user_event *find_user_event(struct user_event_group *group,
> >  	*outkey = key;
> >  
> >  	hash_for_each_possible(group->register_table, user, node, key) {
> > +		/*
> > +		 * Single-format events shouldn't return multi-format
> > +		 * events. Callers expect the underlying tracepoint to match
> > +		 * the name exactly in these cases. Only check like-formats.
> > +		 */
> > +		if (EVENT_MULTI_FORMAT(flags) != EVENT_MULTI_FORMAT(user->reg_flags))
> > +			continue;
> > +
> >  		if (strcmp(EVENT_NAME(user), name))
> >  			continue;
> >  
> >  		if (user_fields_match(user, argc, argv))
> >  			return user_event_get(user);
> >  
> > +		/* Scan others if this is a multi-format event */
> > +		if (EVENT_MULTI_FORMAT(flags))
> > +			continue;
> > +
> >  		return ERR_PTR(-EADDRINUSE);
> >  	}
> >  
> > @@ -1889,8 +1934,12 @@ static bool user_event_match(const char *system, const char *event,
> >  	struct user_event *user = container_of(ev, struct user_event, devent);
> >  	bool match;
> >  
> > -	match = strcmp(EVENT_NAME(user), event) == 0 &&
> > -		(!system || strcmp(system, USER_EVENTS_SYSTEM) == 0);
> > +	match = strcmp(EVENT_NAME(user), event) == 0;
> > +
> > +	if (match && system) {
> > +		match = strcmp(system, user->group->system_name) == 0 ||
> > +			strcmp(system, user->group->system_multi_name) == 0;
> > +	}
> >  
> >  	if (match)
> >  		match = user_fields_match(user, argc, argv);
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
> > +		len = snprintf(NULL, 0, "%s.%llx", user->reg_name,
> > +			       user->group->multi_id) + 1;
> > +
> > +		multi_name = kzalloc(len, GFP_KERNEL_ACCOUNT);
> > +
> > +		if (!multi_name)
> > +			return -ENOMEM;
> > +
> > +		snprintf(multi_name, len, "%s.%llx", user->reg_name,
> > +			 user->group->multi_id);
> 
> I believe the above can be replaced with:
> 
> 		multi_name = kasprintf(GFP_KERNEL_ACCOUNT, "%s.%llx", user->reg_name,
> 				       user->group->multi_id);
> 		if (!multi_name)
> 			return -ENOMEM;
> 

Great, I'll move to that as well and validate.

Thanks,
-Beau

> -- Steve
> 
> > +
> > +		user->call.name = multi_name;
> > +		user->tracepoint.name = multi_name;
> > +
> > +		/* Inc to ensure unique multi-event name next time */
> > +		user->group->multi_id++;
> > +	} else {
> > +		/* Non Multi-format uses register name */
> > +		user->call.name = user->reg_name;
> > +		user->tracepoint.name = user->reg_name;
> > +	}
> > +
> > +	return 0;
> > +}

