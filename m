Return-Path: <linux-kernel+bounces-95555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEE1874F66
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C171F230DC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155B612BEA8;
	Thu,  7 Mar 2024 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O9B4ETaY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LzMtTl3R";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gyMYZc5S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gfO2KJ72"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D32012881C;
	Thu,  7 Mar 2024 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815704; cv=none; b=TXmXKN20pWO5SHRaoovgZKZl3FMqmOwmxjfDxS+DGoeAV8KRsNRL19v0itmohdjMdYTEFNjH93pa5qF0tGnBPt6bOwaiRpfZUlHPLbg+kZMHXLhYmzjiwzSZAwdaiDnPtzXfSRxU/C+tBpXoYVMw39fixCg7MfykKUemJhKQMTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815704; c=relaxed/simple;
	bh=RzVpJVAtXOpd0w549AjCcXSAo4ve8Geojws5Y3+M0Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilSbyi9PowBYUzPEf3rLVEdzYeMi8BRxg0/3LvSg63z8NaVvdy3nlxWoQUaYccpAk8ykX6+hVTh8miEmZ3Jv1FFgd4DaYXEll7WlwCENxoySjmrK9aK4pVcXI1llQqxSg92boa8hAaId8a9N2wjdazy+fDL2O11rrvCbyyk7CIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O9B4ETaY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LzMtTl3R; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gyMYZc5S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gfO2KJ72; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 127DA5F789;
	Thu,  7 Mar 2024 12:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709813016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a6GKRpRzRAPsvLrEJ5jvndlt+eWkW+qvIFg8nOKRaq8=;
	b=O9B4ETaYszjpXppwfViS4BsWl5MH72SrEUbgd33KlmE9FBaR3yRDhuf70E80p3+RZmgrXt
	Dcs1Ll8dkDvtX0//Q+f7msK82ugM7SyHw2tFj9YUPIpx4SVYdi2VpOj8IU5++zVbNp1tMk
	RcSxaFvfu1EAZgUoThkLiBQPEa5yNuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709813016;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a6GKRpRzRAPsvLrEJ5jvndlt+eWkW+qvIFg8nOKRaq8=;
	b=LzMtTl3R4j1RNcmPhQVCSie0Oqt7nhgYqLMkxMnXBfMQ3RCpG2IBONNTAryiv4ZEbofzIA
	Kca0Sx4AhlihtIBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709813015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a6GKRpRzRAPsvLrEJ5jvndlt+eWkW+qvIFg8nOKRaq8=;
	b=gyMYZc5SWT3mQuda1bpNJvXkr0HkWs8IHb2L1u2Qi73lXBAHg7QdSHwVsnrziFM+dytLK7
	QMcgnpeIbHA6eKatV9twMK20DriNTm91D5MilkHiBXMeHjEoSqJrH+KPbZkgJDv6QNI2rh
	SS5iRTpm6XhsbdHtBPn7JVoUT4nzkWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709813015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a6GKRpRzRAPsvLrEJ5jvndlt+eWkW+qvIFg8nOKRaq8=;
	b=gfO2KJ72VznDzSJzyx9MqhkVbaCesvSeqHv3ANF+PxIyQ50hAWaGcj3DiAeIjy0jieq37R
	IALlLfJEwvTNDsAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 08004132A4;
	Thu,  7 Mar 2024 12:03:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id tuLqARat6WUSPwAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 07 Mar 2024 12:03:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A35AAA0803; Thu,  7 Mar 2024 13:03:25 +0100 (CET)
Date: Thu, 7 Mar 2024 13:03:25 +0100
From: Jan Kara <jack@suse.cz>
To: Winston Wen <wentao@uniontech.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Jan Kara <jack@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the ext3 tree
Message-ID: <20240307120325.44qut2tmlirbav6j@quack3>
References: <20240307110717.50b64fe9@canb.auug.org.au>
 <BB8327439DE51911+20240307141837.3c067e2b@winn-pc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BB8327439DE51911+20240307141837.3c067e2b@winn-pc>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gyMYZc5S;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gfO2KJ72
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 TO_DN_ALL(0.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,auug.org.au:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Score: -2.81
X-Rspamd-Queue-Id: 127DA5F789
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu 07-03-24 14:18:37, Winston Wen wrote:
> On Thu, 7 Mar 2024 11:07:17 +1100
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Hi all,
> > 
> > After merging the ext3 tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> > 
> > In file included from include/linux/sysctl.h:27,
> >                  from include/linux/fanotify.h:5,
> >                  from fs/notify/fanotify/fanotify.c:2:
> > fs/notify/fanotify/fanotify.c: In function 'fanotify_get_response':
> > fs/notify/fanotify/fanotify.c:233:48: error: suggest parentheses
> > around arithmetic in operand of '|' [-Werror=parentheses] 233 |
> >                             TASK_KILLABLE|TASK_FREEZABLE); |
> >                                       ^ include/linux/wait.h:283:11:
> > note: in definition of macro '___wait_is_interruptible' 283 |
> >  (state & (TASK_INTERRUPTIBLE | TASK_WAKEKILL))) |           ^~~~~
> > include/linux/wait.h:935:9: note: in expansion of macro
> > '___wait_event' 935 |         ___wait_event(wq, condition, state, 0,
> > 0, schedule()) |         ^~~~~~~~~~~~~
> > include/linux/wait.h:958:25: note: in expansion of macro
> > '__wait_event_state' 958 |                 __ret =
> > __wait_event_state(wq_head, condition, state);          \ |
> >               ^~~~~~~~~~~~~~~~~~
> > fs/notify/fanotify/fanotify.c:231:15: note: in expansion of macro
> > 'wait_event_state' 231 |         ret =
> > wait_event_state(group->fanotify_data.access_waitq, |
> > ^~~~~~~~~~~~~~~~ cc1: all warnings being treated as errors
> > 
> > Caused by commit
> > 
> >   3440e7e55ced ("fanotify: allow freeze when waiting response for
> > permission events")
> > 
> > Though, I guess, you could argue that the ___wait_is_interruptible
> > macro should parenthesise the use of its "state" argument.
> > 
> > I have used the ext3 tree from next-20240306 for today.
> > 
> 
> Sorry I missed this warning. And agreed! I can add parentheses on the
> call side, but it may be more reasonable to add them in the macro.

Thanks for fixing this and I agree. For now, I've also pushed out a new
version of your patch with additional parentheses into my tree to unblock
it for linux-next.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

