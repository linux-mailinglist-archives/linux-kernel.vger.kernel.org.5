Return-Path: <linux-kernel+bounces-76679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 396BE85FAE6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA851C21F2D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CBD14601D;
	Thu, 22 Feb 2024 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oaz+50pm";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oaz+50pm"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D622BB16;
	Thu, 22 Feb 2024 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708611377; cv=none; b=LhNggCC07rMBmjGzCrmBdTs1m95apWCJfBIFHB3SYWVJuZvacRhqeN96ZL4E6XEA4lbHMdtr7K7CQ5VB0sbQ00IvGKY/N47N4RJK0Rr2k3FScs7BX39BU21C2UfV1981ZkeNpx5VISq1yaJ8CJYQf/rnep+hqrO1ITYE0FK5txc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708611377; c=relaxed/simple;
	bh=E/fPt2xEGMA84fZcQkJWMXozptlGnWvWLOg3QWsZJtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4k0R5keMlbmRIrhpe55r1flNrdX1n3jpy4CnD2Xp2oOMjdH2R5F45yBPVJlpXGMrhPIY4wP5YEn6iyG1JySE0ykoNqoxq9BiAu2eSiltMFPuKKoEwCPU2Ngr83KawniyP9h1zbAEJP6fAXCEr91Hr3R0qFGMe1SQUBpUU2yhqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oaz+50pm; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oaz+50pm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF6F72119A;
	Thu, 22 Feb 2024 14:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708611373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6lq0D1Zv9ew5MQu6n3pDdGjgwnsaGgA0IKlZXqZNnek=;
	b=oaz+50pmopgSUHIy0b7fFO06fBh7nbKQaNZEVUYhzuhKcKan5Z2rCMdGKyKl440M1i8qCt
	tmRTJwgKKPsb7Ka/0b9zM1R4pPJeECfw0KEDJ5v/OWHX3gXs3gv5lVwZk6xlf5M2oj49wP
	RQ+Mql8nwDBFbPSrkC5I6NNhExD0tPk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708611373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6lq0D1Zv9ew5MQu6n3pDdGjgwnsaGgA0IKlZXqZNnek=;
	b=oaz+50pmopgSUHIy0b7fFO06fBh7nbKQaNZEVUYhzuhKcKan5Z2rCMdGKyKl440M1i8qCt
	tmRTJwgKKPsb7Ka/0b9zM1R4pPJeECfw0KEDJ5v/OWHX3gXs3gv5lVwZk6xlf5M2oj49wP
	RQ+Mql8nwDBFbPSrkC5I6NNhExD0tPk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BB09133DC;
	Thu, 22 Feb 2024 14:16:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6iQWHy1X12X7RQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 22 Feb 2024 14:16:13 +0000
Date: Thu, 22 Feb 2024 15:16:12 +0100
From: Michal Hocko <mhocko@suse.com>
To: Carlos Galo <carlosgalo@google.com>
Cc: rostedt@goodmis.org, akpm@linux-foundation.org, surenb@google.com,
	android-mm@google.com, kernel-team@android.com,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: Update mark_victim tracepoints fields
Message-ID: <ZddXLGdJ0QDZTvJS@tiehlicka>
References: <20240111210539.636607-1-carlosgalo@google.com>
 <ZdWshXSoLthv6J6b@tiehlicka>
 <CABtOLR+gpU2BYxcGCCqccZGcRDF337z3JJ=7nvC47ANHmS1tNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABtOLR+gpU2BYxcGCCqccZGcRDF337z3JJ=7nvC47ANHmS1tNA@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Wed 21-02-24 13:30:51, Carlos Galo wrote:
> On Tue, Feb 20, 2024 at 11:55 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > Hi,
> > sorry I have missed this before.
> >
> > On Thu 11-01-24 21:05:30, Carlos Galo wrote:
> > > The current implementation of the mark_victim tracepoint provides only
> > > the process ID (pid) of the victim process. This limitation poses
> > > challenges for userspace tools that need additional information
> > > about the OOM victim. The association between pid and the additional
> > > data may be lost after the kill, making it difficult for userspace to
> > > correlate the OOM event with the specific process.
> >
> > You are correct that post OOM all per-process information is lost. On
> > the other hand we do dump all this information to the kernel log. Could
> > you explain why that is not suitable for your purpose?
> 
> Userspace tools often need real-time visibility into OOM situations
> for userspace intervention. Our use case involves utilizing BPF
> programs, along with BPF ring buffers, to provide OOM notification to
> userspace. Parsing kernel logs would be significant overhead as
> opposed to the event based BPF approach.

Please put that into the changelog.

> > > In order to mitigate this limitation, add the following fields:
> > >
> > > - UID
> > >    In Android each installed application has a unique UID. Including
> > >    the `uid` assists in correlating OOM events with specific apps.
> > >
> > > - Process Name (comm)
> > >    Enables identification of the affected process.
> > >
> > > - OOM Score
> > >    Allows userspace to get additional insights of the relative kill
> > >    priority of the OOM victim.
> >
> > What is the oom score useful for?
> >
> The OOM score provides us a measure of the victim's importance. On the
> android side, it allows us to identify if top or foreground apps are
> killed, which have user perceptible impact.

But the value on its own (wihtout knowing scores of other tasks) doesn't
really tell you anything, does it?
 
> > Is there any reason to provide a different information from the one
> > reported to the kernel log?
> > __oom_kill_process:
> > pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB, UID:%u pgtables:%lukB oom_score_adj:%hd\n",
> >                 message, task_pid_nr(victim), victim->comm, K(mm->total_vm),
> >                 K(get_mm_counter(mm, MM_ANONPAGES)),
> >                 K(get_mm_counter(mm, MM_FILEPAGES)),
> >                 K(get_mm_counter(mm, MM_SHMEMPAGES)),
> >                 from_kuid(&init_user_ns, task_uid(victim)),
> >                 mm_pgtables_bytes(mm) >> 10, victim->signal->oom_score_adj);
> >
> 
> We added these fields we need (UID, process name, and OOM score), but
> we're open to adding the others if you prefer that for consistency
> with the kernel log.

yes, I think the consistency would be better here. For one it reports
numbers which can tell quite a lot about the killed victim. It is a
superset of what you already asking for. With a notable exception of the
oom_score which is really dubious without a wider context.
-- 
Michal Hocko
SUSE Labs

